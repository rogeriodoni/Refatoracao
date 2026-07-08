*==============================================================================
* FormSrv.prg - Formulario de Cadastro de Servicos (Saidas/Entradas)
* Data: 2026-03-22
* Tabela: SigCdSrv | PK: CodServs | Detalhe: SigSeRvp
* Legado: SIGCDSRV.SCX (frmcadastro)
* Parametro Init: par_cTipo = "S" (Saidas) ou "E" (Entradas)
*==============================================================================

DEFINE CLASS FormSrv AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 620
    Width        = 812
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_cModoAtual      = ""
    this_cTipo           = "S"   && S=Saidas, E=Entradas

    *==========================================================================
    * Init - Aceita parametro de tipo (S=Saidas, E=Entradas)
    *==========================================================================
    PROCEDURE Init()
    LPARAMETERS par_cTipo
        IF TYPE("par_cTipo") = "C" AND !EMPTY(par_cTipo)
            THIS.this_cTipo = par_cTipo
        ELSE
            THIS.this_cTipo = "S"
        ENDIF

        IF THIS.this_cTipo = "S"
            THIS.Caption = "Servi" + CHR(231) + "os de Sa" + CHR(237) + "das"
        ELSE
            THIS.Caption = "Servi" + CHR(231) + "os de Entradas"
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configuracao completa do formulario
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SrvBO")

            IF ISNULL(THIS.this_oBusinessObject)
                THIS.this_cMensagemErro = "Erro ao criar SrvBO"
            ELSE
                *-- Criar cursor placeholder ANTES de configurar controles com ControlSource
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados ( ;
                    CodServs C(10), DescServs C(100), cTipos C(1), cIdChaves C(16), ;
                    aiss N(10,4), apiss N(10,4), acofinss N(10,4), airrfs N(10,4), ;
                    ainss N(10,4), acslls N(10,4), ;
                    vminpiss N(15,4), vmincofins N(15,4), vMinIrrfs N(15,4), ;
                    vMinInss N(15,4), vMinCslls N(15,4), ;
                    vminbpiss N(15,4), vminbcofin N(15,4), vMinbIrrfs N(15,4), ;
                    vMinbInss N(15,4), vMinbCslls N(15,4), ;
                    bpisms N(1,0), bcofinms N(1,0), birrfms N(1,0), ;
                    binssms N(1,0), bcsllms N(1,0), ;
                    nLanFPiss N(1,0), nLanFCofin N(1,0), nLanFIrrfs N(1,0), ;
                    nLanFInss N(1,0), nLanFIss N(1,0), nLanFCslls N(1,0), ;
                    cOcorPiss C(10), cOcorCofin C(10), cOcorIrrfs C(10), ;
                    cOcorInss C(10), cOcorCslls C(10), cOcoriSS C(10), ;
                    cGrupo C(10), cContab C(10), ;
                    vcpis N(1,0), vccofins N(1,0), vcirrf N(1,0), ;
                    vcinss N(1,0), vccsll N(1,0), vciss N(1,0), ;
                    cgrppiss C(10), cCtaPiss C(10), cGrpCofins C(10), cCtaCofins C(10), ;
                    cGrpIrrfs C(10), cCtaIrrfs C(10), cGrpInss C(10), cCtaInss C(10), ;
                    cGrpCslls C(10), cCtaCslls C(10), cGrpIss C(10), cCtaIss C(10), ;
                    codpiss C(10), codcofinss C(10), codcslls C(10), ;
                    codrecpis C(10), codreccof C(10), codreccsll C(10), codrecirrf C(10), ;
                    nrpas N(1,0), maxretinss N(15,4) ;
                )
                SET NULL OFF
                APPEND BLANK

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarBindings()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Visibilidade do container RPA depende do tipo
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.cnt_4c_RPA.Visible = ;
                    (THIS.this_cTipo = "E")

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarOcorrencias()
                    IF !THIS.CarregarLista()
                        *-- falha nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame principal (outer)
    * Legado: pagina Top=-29, Width=800, Height=631
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 815
            .Height    = 651
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: grade de listagem + botoes CRUD
    * Legado: grade Top=108, Left=28, Width=743, Height=470
    *         grupo_op Left=344, Top=0->29; grupo_saida Left=719, Top=0->29
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho (cntSombra: Top=2->31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 20
            .Left      = 20
            .Width     = 450
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Botoes CRUD (grupo_op: Left=344, Top=0->29, Width=385, Height=85)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (inserir: Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (consultar: Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (alterar: Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (excluir: Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 230
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (procurar: Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 305
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida (grupo_saida: Left=719, Top=0->29)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grade de listagem (grade: Top=108->137, Left=28, Width=743, Height=470)
        *-- Cursor: cursor_4c_Dados | Colunas: CodServs(80), DescServs(480)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            .Top               = 137
            .Left              = 28
            .Width             = 743
            .Height            = 470
            .ColumnCount       = 2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .T.
            .RowHeight         = 17
            .ScrollBars        = 3
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightStyle    = 2
            .Visible           = .T.
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column1
            .Width   = 80
            .FontSize = 8
        ENDWITH
        WITH loc_oPagina.grd_4c_Dados.Column1.Header1
            .Caption   = "C" + CHR(243) + "digo"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH loc_oPagina.grd_4c_Dados.Column2
            .Width    = 480
            .FontSize = 8
        ENDWITH
        WITH loc_oPagina.grd_4c_Dados.Column2.Header1
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        BINDEVENT(loc_oPagina.grd_4c_Dados, "DblClick", THIS, "BtnVisualizarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: botoes salvar/cancelar + inner PageFrame
    * Legado: grupo_salva Top=-3->26, Left=642; pgDados Top=132->161, Left=29
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Botoes Salvar/Cancelar (grupo_salva: Left=642, Top=-3->26)
        loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oPagina.cnt_4c_BotoesDados
            .Top         = 26
            .Left        = 642
            .Width       = 170
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Inner PageFrame (pgDados: Top=132->161, Left=29, Width=740, Height=417)
        *-- 3 sub-paginas: Impostos, Vencimentos, Retencao
        loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
        WITH loc_oPagina.pgf_4c_Dados
            .Top       = 161
            .Left      = 29
            .Width     = 740
            .Height    = 417
            .PageCount = 3
            .Tabs      = .T.
            .Visible   = .T.

            .Page1.FontName  = "Tahoma"
            .Page1.FontSize  = 8
            .Page1.Caption   = "Impostos"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.ForeColor = RGB(90, 90, 90)

            .Page2.FontName  = "Tahoma"
            .Page2.FontSize  = 8
            .Page2.Caption   = "Vencimentos"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.ForeColor = RGB(90, 90, 90)

            .Page3.FontName  = "Tahoma"
            .Page3.FontSize  = 8
            .Page3.Caption   = "Reten" + CHR(231) + CHR(227) + "o"
            .Page3.BackColor = RGB(255, 255, 255)
            .Page3.ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.ConfigurarSubPaginaImpostos(loc_oPagina.pgf_4c_Dados.Page1)
        THIS.ConfigurarSubPaginaVencimentos(loc_oPagina.pgf_4c_Dados.Page2)
        THIS.ConfigurarSubPaginaRetencao(loc_oPagina.pgf_4c_Dados.Page3)
    ENDPROC

    *==========================================================================
    * ConfigurarSubPaginaImpostos - Page1 do inner PF (pgImpostos)
    * Campos: Codigo, Descricao, Aliquotas, Val.Minimos, Base Calc,
    *         Lanc.Financeiro, Ocorrencias, Conta Contabil
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSubPaginaImpostos(par_oPg)
        *-- SHAPES (decorativos, adicionados primeiro - camada inferior)
        *-- Shape2: bordao externo Top=1, Left=8, H=331, W=721
        par_oPg.AddObject("shp_4c_Shape2", "Shape")
        WITH par_oPg.shp_4c_Shape2
            .Top           = 1
            .Left          = 8
            .Height        = 331
            .Width         = 721
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Shape1: secao aliquotas Top=44, H=37
        par_oPg.AddObject("shp_4c_Shape1", "Shape")
        WITH par_oPg.shp_4c_Shape1
            .Top           = 44
            .Left          = 13
            .Height        = 37
            .Width         = 712
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Shape7: secao val.minimos Top=93, H=37
        par_oPg.AddObject("shp_4c_Shape7", "Shape")
        WITH par_oPg.shp_4c_Shape7
            .Top           = 93
            .Left          = 13
            .Height        = 37
            .Width         = 712
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Shape4: secao base calc Top=146, H=54
        par_oPg.AddObject("shp_4c_Shape4", "Shape")
        WITH par_oPg.shp_4c_Shape4
            .Top           = 146
            .Left          = 13
            .Height        = 54
            .Width         = 712
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Shape3: secao lanc.financeiro Top=209, H=31
        par_oPg.AddObject("shp_4c_Shape3", "Shape")
        WITH par_oPg.shp_4c_Shape3
            .Top           = 209
            .Left          = 13
            .Height        = 31
            .Width         = 712
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Shape8: secao ocorrencias Top=258, H=35
        par_oPg.AddObject("shp_4c_Shape8", "Shape")
        WITH par_oPg.shp_4c_Shape8
            .Top           = 258
            .Left          = 13
            .Height        = 35
            .Width         = 712
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- SECAO: Cabecalho (Codigo + Descricao)
        *-- Label3: "Codigo :" Left=44, Top=16
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH par_oPg.lbl_4c_Label3
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "C" + CHR(243) + "digo :"
            .Height    = 15
            .Left      = 44
            .Top       = 16
            .Width     = 46
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCodigos: Left=92, Top=11, Width=80, Height=23
        par_oPg.AddObject("txt_4c_Codigos", "TextBox")
        WITH par_oPg.txt_4c_Codigos
            .Value         = ""
            .Left          = 92
            .Top           = 11
            .Width         = 80
            .Height        = 23
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.CodServs"
            .Format        = "!K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- getDescricao: Left=173, Top=11, Width=324, Height=23
        par_oPg.AddObject("txt_4c_Descricao", "TextBox")
        WITH par_oPg.txt_4c_Descricao
            .Value         = ""
            .Left          = 173
            .Top           = 11
            .Width         = 324
            .Height        = 23
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.descservs"
            .Format        = "!K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- SECAO: Aliquotas (Label6 + campos % ISS/PIS/COFINS/IRRF/INSS/CSLL)
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label6", "Label")
        WITH par_oPg.lbl_4c_Label6
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 1
            .Caption   = "Al" + CHR(237) + "quotas"
            .Height    = 15
            .Left      = 20
            .Top       = 36
            .Width     = 55
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Label1: "% ISS :" Left=19, Top=56
        par_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPg.lbl_4c_Label1
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "% ISS :"
            .Height    = 15
            .Left      = 19
            .Top       = 56
            .Width     = 43
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_ISS: Left=61, Top=52, Width=50, Height=23
        par_oPg.AddObject("txt_4c__ISS", "TextBox")
        WITH par_oPg.txt_4c__ISS
            .Value         = 0
            .Left          = 61
            .Top           = 52
            .Width         = 50
            .Height        = 23
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.aiss"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label2: "% PIS :" Left=126, Top=56
        par_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH par_oPg.lbl_4c_Label2
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "% PIS :"
            .Height    = 15
            .Left      = 126
            .Top       = 56
            .Width     = 43
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_PIS: Left=168, Top=53, Width=50, Height=22
        par_oPg.AddObject("txt_4c__PIS", "TextBox")
        WITH par_oPg.txt_4c__PIS
            .Value         = 0
            .Left          = 168
            .Top           = 53
            .Width         = 50
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.apiss"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label4: "% COFINS :" Left=234, Top=57
        par_oPg.AddObject("lbl_4c_Label4", "Label")
        WITH par_oPg.lbl_4c_Label4
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "% COFINS :"
            .Height    = 15
            .Left      = 234
            .Top       = 57
            .Width     = 64
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_COFINS: Left=303, Top=53, Width=50, Height=22
        par_oPg.AddObject("txt_4c__COFINS", "TextBox")
        WITH par_oPg.txt_4c__COFINS
            .Value         = 0
            .Left          = 303
            .Top           = 53
            .Width         = 50
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.acofinss"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label5: "% IRRF :" Left=373, Top=57
        par_oPg.AddObject("lbl_4c_Label5", "Label")
        WITH par_oPg.lbl_4c_Label5
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "% IRRF :"
            .Height    = 15
            .Left      = 373
            .Top       = 57
            .Width     = 51
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_IRRF: Left=423, Top=53, Width=50, Height=22
        par_oPg.AddObject("txt_4c__IRRF", "TextBox")
        WITH par_oPg.txt_4c__IRRF
            .Value         = 0
            .Left          = 423
            .Top           = 53
            .Width         = 50
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.airrfs"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label7: "% INSS :" Left=491, Top=57
        par_oPg.AddObject("lbl_4c_Label7", "Label")
        WITH par_oPg.lbl_4c_Label7
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "% INSS :"
            .Height    = 15
            .Left      = 491
            .Top       = 57
            .Width     = 50
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_INSS: Left=544, Top=53, Width=50, Height=22
        par_oPg.AddObject("txt_4c__INSS", "TextBox")
        WITH par_oPg.txt_4c__INSS
            .Value         = 0
            .Left          = 544
            .Top           = 53
            .Width         = 50
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.ainss"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label8: "% CSLL :" Left=609, Top=57
        par_oPg.AddObject("lbl_4c_Label8", "Label")
        WITH par_oPg.lbl_4c_Label8
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "% CSLL :"
            .Height    = 15
            .Left      = 609
            .Top       = 57
            .Width     = 50
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_CSLL: Left=661, Top=53, Width=50, Height=22
        par_oPg.AddObject("txt_4c__CSLL", "TextBox")
        WITH par_oPg.txt_4c__CSLL
            .Value         = 0
            .Left          = 661
            .Top           = 53
            .Width         = 50
            .Height        = 22
            .FontSize      = 8
            .BackStyle     = 1
            .ControlSource = "cursor_4c_Dados.acslls"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- SECAO: Valores Minimos a recolher (Label25 + campos vMin*)
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label25", "Label")
        WITH par_oPg.lbl_4c_Label25
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 1
            .Caption   = "Valores M" + CHR(237) + "nimos " + CHR(224) + " recolher"
            .Height    = 15
            .Left      = 20
            .Top       = 85
            .Width     = 154
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Label10: "PIS :" Left=21, Top=106
        par_oPg.AddObject("lbl_4c_Label10", "Label")
        WITH par_oPg.lbl_4c_Label10
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "PIS :"
            .Height    = 15
            .Left      = 21
            .Top       = 106
            .Width     = 27
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_VMinPis: Left=48, Top=102, Width=90, Height=22
        par_oPg.AddObject("txt_4c__VMinPis", "TextBox")
        WITH par_oPg.txt_4c__VMinPis
            .Value         = 0
            .Left          = 48
            .Top           = 102
            .Width         = 90
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.vminpiss"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label11: "COFINS :" Left=161, Top=106
        par_oPg.AddObject("lbl_4c_Label11", "Label")
        WITH par_oPg.lbl_4c_Label11
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "COFINS :"
            .Height    = 15
            .Left      = 161
            .Top       = 106
            .Width     = 48
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_VMinCofins: Left=212, Top=102, Width=90, Height=22
        par_oPg.AddObject("txt_4c__VMinCofins", "TextBox")
        WITH par_oPg.txt_4c__VMinCofins
            .Value         = 0
            .Left          = 212
            .Top           = 102
            .Width         = 90
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.vmincofins"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label12: "IRRF :" Left=314, Top=106
        par_oPg.AddObject("lbl_4c_Label12", "Label")
        WITH par_oPg.lbl_4c_Label12
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "IRRF :"
            .Height    = 15
            .Left      = 314
            .Top       = 106
            .Width     = 35
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_VMinIrrf: Left=348, Top=102, Width=90, Height=22
        par_oPg.AddObject("txt_4c__VMinIrrf", "TextBox")
        WITH par_oPg.txt_4c__VMinIrrf
            .Value         = 0
            .Left          = 348
            .Top           = 102
            .Width         = 90
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.vMinIrrfs"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label13: "INSS :" Left=451, Top=106
        par_oPg.AddObject("lbl_4c_Label13", "Label")
        WITH par_oPg.lbl_4c_Label13
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "INSS :"
            .Height    = 15
            .Left      = 451
            .Top       = 106
            .Width     = 34
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_VMinInss: Left=487, Top=102, Width=90, Height=22
        par_oPg.AddObject("txt_4c__VMinInss", "TextBox")
        WITH par_oPg.txt_4c__VMinInss
            .Value         = 0
            .Left          = 487
            .Top           = 102
            .Width         = 90
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.vMinInss"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label14: "CSLL :" Left=586, Top=107
        par_oPg.AddObject("lbl_4c_Label14", "Label")
        WITH par_oPg.lbl_4c_Label14
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "CSLL :"
            .Height    = 15
            .Left      = 586
            .Top       = 107
            .Width     = 34
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_VMinCsll: Left=621, Top=102, Width=90, Height=22
        par_oPg.AddObject("txt_4c__VMinCsll", "TextBox")
        WITH par_oPg.txt_4c__VMinCsll
            .Value         = 0
            .Left          = 621
            .Top           = 102
            .Width         = 90
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.vMinCslls"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- SECAO: Base de Calculo Minima (Label28 + campos vMinB*)
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label28", "Label")
        WITH par_oPg.lbl_4c_Label28
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 1
            .Caption   = "Base de c" + CHR(225) + "lculo m" + CHR(237) + "nima"
            .Height    = 15
            .Left      = 20
            .Top       = 138
            .Width     = 133
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Label24: "PIS :" Left=21, Top=158
        par_oPg.AddObject("lbl_4c_Label24", "Label")
        WITH par_oPg.lbl_4c_Label24
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "PIS :"
            .Height    = 15
            .Left      = 21
            .Top       = 158
            .Width     = 27
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_VMinBPis: Left=48, Top=155, Width=90, Height=22
        par_oPg.AddObject("txt_4c__VMinBPis", "TextBox")
        WITH par_oPg.txt_4c__VMinBPis
            .Value         = 0
            .Left          = 48
            .Top           = 155
            .Width         = 90
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.vminbpiss"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label22: "COFINS :" Left=161, Top=159
        par_oPg.AddObject("lbl_4c_Label22", "Label")
        WITH par_oPg.lbl_4c_Label22
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "COFINS :"
            .Height    = 15
            .Left      = 161
            .Top       = 159
            .Width     = 48
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_VMinBCofins: Left=212, Top=155, Width=90, Height=22
        par_oPg.AddObject("txt_4c__VMinBCofins", "TextBox")
        WITH par_oPg.txt_4c__VMinBCofins
            .Value         = 0
            .Left          = 212
            .Top           = 155
            .Width         = 90
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.vminbcofin"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label20: "IRRF :" Left=314, Top=159
        par_oPg.AddObject("lbl_4c_Label20", "Label")
        WITH par_oPg.lbl_4c_Label20
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "IRRF :"
            .Height    = 15
            .Left      = 314
            .Top       = 159
            .Width     = 35
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_VMinBIrrf: Left=348, Top=155, Width=90, Height=22
        par_oPg.AddObject("txt_4c__VMinBIrrf", "TextBox")
        WITH par_oPg.txt_4c__VMinBIrrf
            .Value         = 0
            .Left          = 348
            .Top           = 155
            .Width         = 90
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.vMinbIrrfs"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label18: "INSS :" Left=451, Top=159
        par_oPg.AddObject("lbl_4c_Label18", "Label")
        WITH par_oPg.lbl_4c_Label18
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "INSS :"
            .Height    = 15
            .Left      = 451
            .Top       = 159
            .Width     = 34
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_VMinBInss: Left=487, Top=155, Width=90, Height=22
        par_oPg.AddObject("txt_4c__VMinBInss", "TextBox")
        WITH par_oPg.txt_4c__VMinBInss
            .Value         = 0
            .Left          = 487
            .Top           = 155
            .Width         = 90
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.vMinbInss"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label16: "CSLL :" Left=586, Top=159
        par_oPg.AddObject("lbl_4c_Label16", "Label")
        WITH par_oPg.lbl_4c_Label16
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "CSLL :"
            .Height    = 15
            .Left      = 586
            .Top       = 159
            .Width     = 34
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_vMinBCsll: Left=621, Top=155, Width=90, Height=22
        par_oPg.AddObject("txt_4c__vMinBCsll", "TextBox")
        WITH par_oPg.txt_4c__vMinBCsll
            .Value         = 0
            .Left          = 621
            .Top           = 155
            .Width         = 90
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.vMinbCslls"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- SECAO: Lancamento Financeiro (Label26 + checkboxes mensais + LancFin)
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label26", "Label")
        WITH par_oPg.lbl_4c_Label26
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 1
            .Caption   = "Lan" + CHR(231) + "amento Financeiro"
            .Height    = 15
            .Left      = 20
            .Top       = 201
            .Width     = 133
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Checkboxes "Mensal" (Top=180) para cada imposto
        *-- chk_bpisms: Left=48
        par_oPg.AddObject("chk_4c_Chk_bpisms", "CheckBox")
        WITH par_oPg.chk_4c_Chk_bpisms
            .Top                 = 180
            .Left                = 48
            .Height              = 15
            .Width               = 58
            .FontBold            = .T.
            .FontName            = "Tahoma"
            .FontSize            = 8
            .AutoSize            = .T.
            .Alignment           = 0
            .BackStyle           = 0
            .Caption             = "Mensal"
            .Value               = 0
            .ControlSource       = "cursor_4c_Dados.bpisms"
            .ForeColor           = RGB(90, 90, 90)
            .DisabledForeColor   = RGB(128, 128, 128)
            .DisabledBackColor   = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH

        *-- chk_bcofinms: Left=212
        par_oPg.AddObject("chk_4c_Chk_bcofinms", "CheckBox")
        WITH par_oPg.chk_4c_Chk_bcofinms
            .Top                 = 180
            .Left                = 212
            .Height              = 15
            .Width               = 58
            .FontBold            = .T.
            .FontName            = "Tahoma"
            .FontSize            = 8
            .AutoSize            = .T.
            .Alignment           = 0
            .BackStyle           = 0
            .Caption             = "Mensal"
            .Value               = 0
            .ControlSource       = "cursor_4c_Dados.bcofinms"
            .ForeColor           = RGB(90, 90, 90)
            .DisabledForeColor   = RGB(128, 128, 128)
            .DisabledBackColor   = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH

        *-- chk_birrfms: Left=348
        par_oPg.AddObject("chk_4c_Chk_birrfms", "CheckBox")
        WITH par_oPg.chk_4c_Chk_birrfms
            .Top                 = 180
            .Left                = 348
            .Height              = 15
            .Width               = 58
            .FontBold            = .T.
            .FontName            = "Tahoma"
            .FontSize            = 8
            .AutoSize            = .T.
            .Alignment           = 0
            .BackStyle           = 0
            .Caption             = "Mensal"
            .Value               = 0
            .ControlSource       = "cursor_4c_Dados.birrfms"
            .ForeColor           = RGB(90, 90, 90)
            .DisabledForeColor   = RGB(128, 128, 128)
            .DisabledBackColor   = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH

        *-- chk_binssms: Left=487
        par_oPg.AddObject("chk_4c_Chk_binssms", "CheckBox")
        WITH par_oPg.chk_4c_Chk_binssms
            .Top                 = 180
            .Left                = 487
            .Height              = 15
            .Width               = 58
            .FontBold            = .T.
            .FontName            = "Tahoma"
            .FontSize            = 8
            .AutoSize            = .T.
            .Alignment           = 0
            .BackStyle           = 0
            .Caption             = "Mensal"
            .Value               = 0
            .ControlSource       = "cursor_4c_Dados.binssms"
            .ForeColor           = RGB(90, 90, 90)
            .DisabledForeColor   = RGB(128, 128, 128)
            .DisabledBackColor   = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH

        *-- chk_bcsllms: Left=621
        par_oPg.AddObject("chk_4c_Chk_bcsllms", "CheckBox")
        WITH par_oPg.chk_4c_Chk_bcsllms
            .Top                 = 180
            .Left                = 621
            .Height              = 15
            .Width               = 58
            .FontBold            = .T.
            .FontName            = "Tahoma"
            .FontSize            = 8
            .AutoSize            = .T.
            .Alignment           = 0
            .BackStyle           = 0
            .Caption             = "Mensal"
            .Value               = 0
            .ControlSource       = "cursor_4c_Dados.bcsllms"
            .ForeColor           = RGB(90, 90, 90)
            .DisabledForeColor   = RGB(128, 128, 128)
            .DisabledBackColor   = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH

        *-- Checkboxes "Lancamento Financeiro" (Top=217)
        *-- chk_LancFinPis: Left=27, Caption="PIS"
        par_oPg.AddObject("chk_4c_Chk_LancFinPis", "CheckBox")
        WITH par_oPg.chk_4c_Chk_LancFinPis
            .Top                 = 217
            .Left                = 27
            .Height              = 15
            .Width               = 37
            .FontBold            = .T.
            .FontName            = "Tahoma"
            .FontSize            = 8
            .AutoSize            = .T.
            .Alignment           = 0
            .BackStyle           = 0
            .Caption             = "PIS"
            .Value               = 0
            .ControlSource       = "cursor_4c_Dados.nLanFPiss"
            .ForeColor           = RGB(90, 90, 90)
            .DisabledForeColor   = RGB(128, 128, 128)
            .DisabledBackColor   = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH

        *-- ck_LancFinCofins: Left=138, Caption="COFINS"
        par_oPg.AddObject("chk_4c_Ck_LancFinCofins", "CheckBox")
        WITH par_oPg.chk_4c_Ck_LancFinCofins
            .Top                 = 217
            .Left                = 138
            .Height              = 15
            .Width               = 58
            .FontBold            = .T.
            .FontName            = "Tahoma"
            .FontSize            = 8
            .AutoSize            = .T.
            .Alignment           = 0
            .BackStyle           = 0
            .Caption             = "COFINS"
            .Value               = 0
            .ControlSource       = "cursor_4c_Dados.nLanFCofin"
            .ForeColor           = RGB(90, 90, 90)
            .DisabledForeColor   = RGB(128, 128, 128)
            .DisabledBackColor   = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH

        *-- ck_LancFinIrrf: Left=279, Caption="IRRF"
        par_oPg.AddObject("chk_4c_Ck_LancFinIrrf", "CheckBox")
        WITH par_oPg.chk_4c_Ck_LancFinIrrf
            .Top                 = 217
            .Left                = 279
            .Height              = 15
            .Width               = 45
            .FontBold            = .T.
            .FontName            = "Tahoma"
            .FontSize            = 8
            .AutoSize            = .T.
            .Alignment           = 0
            .BackStyle           = 0
            .Caption             = "IRRF"
            .Value               = 0
            .ControlSource       = "cursor_4c_Dados.nLanFIrrfs"
            .ForeColor           = RGB(90, 90, 90)
            .DisabledForeColor   = RGB(128, 128, 128)
            .DisabledBackColor   = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH

        *-- ck_LancFinInss: Left=409, Caption="INSS"
        par_oPg.AddObject("chk_4c_Ck_LancFinInss", "CheckBox")
        WITH par_oPg.chk_4c_Ck_LancFinInss
            .Top                 = 217
            .Left                = 409
            .Height              = 15
            .Width               = 44
            .FontBold            = .T.
            .FontName            = "Tahoma"
            .FontSize            = 8
            .AutoSize            = .T.
            .Alignment           = 0
            .BackStyle           = 0
            .Caption             = "INSS"
            .Value               = 0
            .ControlSource       = "cursor_4c_Dados.nLanFInss"
            .ForeColor           = RGB(90, 90, 90)
            .DisabledForeColor   = RGB(128, 128, 128)
            .DisabledBackColor   = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH

        *-- ck_LancFinCsll: Left=526, Caption="CSLL"
        par_oPg.AddObject("chk_4c_Ck_LancFinCsll", "CheckBox")
        WITH par_oPg.chk_4c_Ck_LancFinCsll
            .Top                 = 217
            .Left                = 526
            .Height              = 15
            .Width               = 44
            .FontBold            = .T.
            .FontName            = "Tahoma"
            .FontSize            = 8
            .AutoSize            = .T.
            .Alignment           = 0
            .BackStyle           = 0
            .Caption             = "CSLL"
            .Value               = 0
            .ControlSource       = "cursor_4c_Dados.nLanFCslls"
            .ForeColor           = RGB(90, 90, 90)
            .DisabledForeColor   = RGB(128, 128, 128)
            .DisabledBackColor   = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH

        *-- ck_LancFinIss: Left=645, Caption="ISS"
        par_oPg.AddObject("chk_4c_Ck_LancFinIss", "CheckBox")
        WITH par_oPg.chk_4c_Ck_LancFinIss
            .Top                 = 217
            .Left                = 645
            .Height              = 15
            .Width               = 37
            .FontBold            = .T.
            .FontName            = "Tahoma"
            .FontSize            = 8
            .AutoSize            = .T.
            .Alignment           = 0
            .BackStyle           = 0
            .Caption             = "ISS"
            .Value               = 0
            .ControlSource       = "cursor_4c_Dados.nLanFIss"
            .ForeColor           = RGB(90, 90, 90)
            .DisabledForeColor   = RGB(128, 128, 128)
            .DisabledBackColor   = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- SECAO: Ocorrencias (Label27 + campos CodOcor*)
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label27", "Label")
        WITH par_oPg.lbl_4c_Label27
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 1
            .Caption   = "Ocorr" + CHR(234) + "ncias"
            .Height    = 15
            .Left      = 20
            .Top       = 250
            .Width     = 69
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Label15: "PIS" Left=20, Top=271
        par_oPg.AddObject("lbl_4c_Label15", "Label")
        WITH par_oPg.lbl_4c_Label15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "PIS"
            .Height    = 15
            .Left      = 20
            .Top       = 271
            .Width     = 21
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_CodOcorPis: Left=43, Top=265, Width=78
        par_oPg.AddObject("txt_4c__CodOcorPis", "TextBox")
        WITH par_oPg.txt_4c__CodOcorPis
            .Value         = ""
            .Left          = 43
            .Top           = 265
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cOcorPiss"
            .Margin        = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label17: "COFINS" Left=129, Top=270
        par_oPg.AddObject("lbl_4c_Label17", "Label")
        WITH par_oPg.lbl_4c_Label17
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "COFINS"
            .Height    = 15
            .Left      = 129
            .Top       = 270
            .Width     = 42
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_CodOcorCofins: Left=178, Top=265, Width=78
        par_oPg.AddObject("txt_4c__CodOcorCofins", "TextBox")
        WITH par_oPg.txt_4c__CodOcorCofins
            .Value         = ""
            .Left          = 178
            .Top           = 265
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cOcorCofin"
            .Margin        = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label19: "IRRF" Left=261, Top=270
        par_oPg.AddObject("lbl_4c_Label19", "Label")
        WITH par_oPg.lbl_4c_Label19
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "IRRF"
            .Height    = 15
            .Left      = 261
            .Top       = 270
            .Width     = 29
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_CodOcorIrrf: Left=291, Top=265, Width=78
        par_oPg.AddObject("txt_4c__CodOcorIrrf", "TextBox")
        WITH par_oPg.txt_4c__CodOcorIrrf
            .Value         = ""
            .Left          = 291
            .Top           = 265
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cOcorIrrfs"
            .Margin        = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label21: "INSS" Left=377, Top=270
        par_oPg.AddObject("lbl_4c_Label21", "Label")
        WITH par_oPg.lbl_4c_Label21
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "INSS"
            .Height    = 15
            .Left      = 377
            .Top       = 270
            .Width     = 28
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_CodOcorInss: Left=411, Top=265, Width=78
        par_oPg.AddObject("txt_4c__CodOcorInss", "TextBox")
        WITH par_oPg.txt_4c__CodOcorInss
            .Value         = ""
            .Left          = 411
            .Top           = 265
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cOcorInss"
            .Margin        = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label23: "CSLL" Left=496, Top=270
        par_oPg.AddObject("lbl_4c_Label23", "Label")
        WITH par_oPg.lbl_4c_Label23
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "CSLL"
            .Height    = 15
            .Left      = 496
            .Top       = 270
            .Width     = 28
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_CodOcorCsll: Left=529, Top=265, Width=78
        par_oPg.AddObject("txt_4c__CodOcorCsll", "TextBox")
        WITH par_oPg.txt_4c__CodOcorCsll
            .Value         = ""
            .Left          = 529
            .Top           = 265
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cOcorCslls"
            .Margin        = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label31: "ISS" Left=612, Top=269
        par_oPg.AddObject("lbl_4c_Label31", "Label")
        WITH par_oPg.lbl_4c_Label31
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "ISS"
            .Height    = 15
            .Left      = 612
            .Top       = 269
            .Width     = 21
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_CodOcoriSS: Left=635, Top=265, Width=78
        par_oPg.AddObject("txt_4c__CodOcoriSS", "TextBox")
        WITH par_oPg.txt_4c__CodOcoriSS
            .Value         = ""
            .Left          = 635
            .Top           = 265
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cOcoriSS"
            .Margin        = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- SECAO: Conta Contabil (Label9 + Get_grupoo + Get_contao + Get_dcontao)
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label9", "Label")
        WITH par_oPg.lbl_4c_Label9
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Cta Cont" + CHR(225) + "bil :"
            .Height    = 15
            .Left      = 44
            .Top       = 306
            .Width     = 76
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_grupoo: Left=127, Top=301, Width=78
        par_oPg.AddObject("txt_4c_Grupo", "TextBox")
        WITH par_oPg.txt_4c_Grupo
            .Value         = ""
            .Left          = 127
            .Top           = 301
            .Width         = 78
            .Height        = 23
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cGrupo"
            .Margin        = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Get_contao: Left=206, Top=301, Width=78
        par_oPg.AddObject("txt_4c_Contao", "TextBox")
        WITH par_oPg.txt_4c_Contao
            .Value         = ""
            .Left          = 206
            .Top           = 301
            .Width         = 78
            .Height        = 23
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.cContab"
            .Margin        = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Get_dcontao: Left=285, Top=301, Width=290 (descricao - somente leitura)
        par_oPg.AddObject("txt_4c_Dcontao", "TextBox")
        WITH par_oPg.txt_4c_Dcontao
            .Value         = ""
            .Left          = 285
            .Top           = 301
            .Width         = 290
            .Height        = 23
            .FontSize      = 8
            .ControlSource = ""
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarSubPaginaVencimentos - Page2 do inner PF (pgVencimentos)
    * Linhas de vencimento: PIS, COFINS, IRRF, INSS, CSLL, ISS
    * Secao de Produtos (grdProdutos + cmdInserir/cmdExcluir)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSubPaginaVencimentos(par_oPg)
        *-- Shapes (decorativos - camada inferior)
        *-- Shape6: bordao externo vencimentos Top=13, H=154, W=719
        par_oPg.AddObject("shp_4c_Shape6", "Shape")
        WITH par_oPg.shp_4c_Shape6
            .Top           = 13
            .Left          = 8
            .Height        = 154
            .Width         = 719
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Shape4: secao vencimentos interna Top=13, Left=61, H=154, W=270
        par_oPg.AddObject("shp_4c_Shape4", "Shape")
        WITH par_oPg.shp_4c_Shape4
            .Top           = 13
            .Left          = 61
            .Height        = 154
            .Width         = 270
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Shape1: secao produtos Top=176, H=154, W=719
        par_oPg.AddObject("shp_4c_Shape1", "Shape")
        WITH par_oPg.shp_4c_Shape1
            .Top           = 176
            .Left          = 8
            .Height        = 154
            .Width         = 719
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Labels de cabecalho das colunas
        *-- Label29: "Vencimentos" Left=69, Top=5, BackStyle=1
        par_oPg.AddObject("lbl_4c_Label29", "Label")
        WITH par_oPg.lbl_4c_Label29
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 1
            .Caption   = "Vencimentos"
            .Height    = 15
            .Left      = 69
            .Top       = 5
            .Width     = 75
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Label28: "Orgao Contribuinte" Left=335, Top=5, BackStyle=1
        par_oPg.AddObject("lbl_4c_Label28", "Label")
        WITH par_oPg.lbl_4c_Label28
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 1
            .Caption   = "Org" + CHR(227) + "o Contribuinte"
            .Height    = 15
            .Left      = 335
            .Top       = 5
            .Width     = 109
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- LINHA PIS (Top=23/28)
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label16", "Label")
        WITH par_oPg.lbl_4c_Label16
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "PIS"
            .Height    = 15
            .Left      = 16
            .Top       = 28
            .Width     = 21
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- opt_VencPis: Left=66, Top=23, Width=261, Height=24, ButtonCount=3
        par_oPg.AddObject("obj_4c_Opt_VencPis", "OptionGroup")
        WITH par_oPg.obj_4c_Opt_VencPis
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 1
            .Value         = 1
            .ControlSource = "cursor_4c_Dados.vcpis"
            .Height        = 24
            .Left          = 66
            .Top           = 23
            .Width         = 261
            .Visible       = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencPis.Buttons(1)
            .Caption    = "T" + CHR(237) + "tulo"
            .Left       = 5
            .Top        = 5
            .Width      = 44
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencPis.Buttons(2)
            .Caption    = "10 D F M" + CHR(234) + "s"
            .Left       = 52
            .Top        = 5
            .Width      = 71
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencPis.Buttons(3)
            .Caption    = CHR(218) + "lt Dia " + CHR(218) + "til Quinz Seg"
            .Left       = 129
            .Top        = 5
            .Width      = 118
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        *-- get_grupopis: Left=342, Top=22, Width=78
        par_oPg.AddObject("txt_4c__grupopis", "TextBox")
        WITH par_oPg.txt_4c__grupopis
            .Value         = ""
            .Left          = 342
            .Top           = 22
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cgrppiss"
            .Margin        = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- get_contapis: Left=421, Top=22, Width=78
        par_oPg.AddObject("txt_4c__contapis", "TextBox")
        WITH par_oPg.txt_4c__contapis
            .Value         = ""
            .Left          = 421
            .Top           = 22
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.cCtaPiss"
            .Margin        = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- get_dcontapis: Left=500, Top=22, Width=220 (descricao - ReadOnly)
        par_oPg.AddObject("txt_4c__dcontapis", "TextBox")
        WITH par_oPg.txt_4c__dcontapis
            .Value         = ""
            .Left          = 500
            .Top           = 22
            .Width         = 220
            .Height        = 22
            .FontSize      = 8
            .ControlSource = ""
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- LINHA COFINS (Top=45/50)
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label18", "Label")
        WITH par_oPg.lbl_4c_Label18
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "COFINS"
            .Height    = 15
            .Left      = 16
            .Top       = 50
            .Width     = 42
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_VencCofins", "OptionGroup")
        WITH par_oPg.obj_4c_Opt_VencCofins
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 1
            .Value         = 1
            .ControlSource = "cursor_4c_Dados.vccofins"
            .Height        = 24
            .Left          = 66
            .Top           = 45
            .Width         = 261
            .Visible       = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencCofins.Buttons(1)
            .Caption    = "T" + CHR(237) + "tulo"
            .Left       = 5
            .Top        = 5
            .Width      = 44
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencCofins.Buttons(2)
            .Caption    = "10 D F M" + CHR(234) + "s"
            .Left       = 52
            .Top        = 5
            .Width      = 71
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencCofins.Buttons(3)
            .Caption    = CHR(218) + "lt Dia " + CHR(218) + "til Quinz Seg"
            .Left       = 129
            .Top        = 5
            .Width      = 118
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__grupocofins", "TextBox")
        WITH par_oPg.txt_4c__grupocofins
            .Value         = ""
            .Left          = 342
            .Top           = 45
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cGrpCofins"
            .Margin        = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__contacofins", "TextBox")
        WITH par_oPg.txt_4c__contacofins
            .Value         = ""
            .Left          = 421
            .Top           = 45
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.cCtaCofins"
            .Margin        = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__dcontacofins", "TextBox")
        WITH par_oPg.txt_4c__dcontacofins
            .Value         = ""
            .Left          = 500
            .Top           = 45
            .Width         = 220
            .Height        = 22
            .FontSize      = 8
            .ControlSource = ""
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- LINHA IRRF (Top=67/72)
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label20", "Label")
        WITH par_oPg.lbl_4c_Label20
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "IRRF"
            .Height    = 15
            .Left      = 16
            .Top       = 72
            .Width     = 29
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_VencIrrf", "OptionGroup")
        WITH par_oPg.obj_4c_Opt_VencIrrf
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 1
            .Value         = 1
            .ControlSource = "cursor_4c_Dados.vcirrf"
            .Height        = 24
            .Left          = 66
            .Top           = 67
            .Width         = 261
            .Visible       = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencIrrf.Buttons(1)
            .Caption    = "T" + CHR(237) + "tulo"
            .Left       = 5
            .Top        = 5
            .Width      = 44
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencIrrf.Buttons(2)
            .Caption    = "10 D F M" + CHR(234) + "s"
            .Left       = 52
            .Top        = 5
            .Width      = 71
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencIrrf.Buttons(3)
            .Caption    = CHR(218) + "lt Dia " + CHR(218) + "til Quinz Seg"
            .Left       = 129
            .Top        = 5
            .Width      = 118
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__grupoirrf", "TextBox")
        WITH par_oPg.txt_4c__grupoirrf
            .Value         = ""
            .Left          = 342
            .Top           = 68
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cGrpIrrfs"
            .Margin        = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__contairrf", "TextBox")
        WITH par_oPg.txt_4c__contairrf
            .Value         = ""
            .Left          = 421
            .Top           = 68
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.cCtaIrrfs"
            .Margin        = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__dcontairrf", "TextBox")
        WITH par_oPg.txt_4c__dcontairrf
            .Value         = ""
            .Left          = 500
            .Top           = 68
            .Width         = 220
            .Height        = 22
            .FontSize      = 8
            .ControlSource = ""
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- LINHA INSS (Top=89/94)
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label22", "Label")
        WITH par_oPg.lbl_4c_Label22
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "INSS"
            .Height    = 15
            .Left      = 16
            .Top       = 94
            .Width     = 28
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_VencInss", "OptionGroup")
        WITH par_oPg.obj_4c_Opt_VencInss
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 1
            .Value         = 1
            .ControlSource = "cursor_4c_Dados.vcinss"
            .Height        = 24
            .Left          = 66
            .Top           = 89
            .Width         = 261
            .Visible       = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencInss.Buttons(1)
            .Caption    = "T" + CHR(237) + "tulo"
            .Left       = 5
            .Top        = 5
            .Width      = 44
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencInss.Buttons(2)
            .Caption    = "10 D F M" + CHR(234) + "s"
            .Left       = 52
            .Top        = 5
            .Width      = 71
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencInss.Buttons(3)
            .Caption    = CHR(218) + "lt Dia " + CHR(218) + "til Quinz Seg"
            .Left       = 129
            .Top        = 5
            .Width      = 118
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__grupoinss", "TextBox")
        WITH par_oPg.txt_4c__grupoinss
            .Value         = ""
            .Left          = 342
            .Top           = 91
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cGrpInss"
            .Margin        = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__containss", "TextBox")
        WITH par_oPg.txt_4c__containss
            .Value         = ""
            .Left          = 421
            .Top           = 91
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.cCtaInss"
            .Margin        = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__dcontainss", "TextBox")
        WITH par_oPg.txt_4c__dcontainss
            .Value         = ""
            .Left          = 500
            .Top           = 91
            .Width         = 220
            .Height        = 22
            .FontSize      = 8
            .ControlSource = ""
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- LINHA CSLL (Top=111/116)
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label24", "Label")
        WITH par_oPg.lbl_4c_Label24
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "CSLL"
            .Height    = 15
            .Left      = 16
            .Top       = 116
            .Width     = 28
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_VencCsll", "OptionGroup")
        WITH par_oPg.obj_4c_Opt_VencCsll
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 1
            .Value         = 1
            .ControlSource = "cursor_4c_Dados.vccsll"
            .Height        = 24
            .Left          = 66
            .Top           = 111
            .Width         = 261
            .Visible       = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencCsll.Buttons(1)
            .Caption    = "T" + CHR(237) + "tulo"
            .Left       = 5
            .Top        = 5
            .Width      = 44
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencCsll.Buttons(2)
            .Caption    = "10 D F M" + CHR(234) + "s"
            .Left       = 52
            .Top        = 5
            .Width      = 71
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_VencCsll.Buttons(3)
            .Caption    = CHR(218) + "lt Dia " + CHR(218) + "til Quinz Seg"
            .Left       = 129
            .Top        = 5
            .Width      = 118
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__grupocsll", "TextBox")
        WITH par_oPg.txt_4c__grupocsll
            .Value         = ""
            .Left          = 342
            .Top           = 114
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cGrpCslls"
            .Margin        = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__contacsll", "TextBox")
        WITH par_oPg.txt_4c__contacsll
            .Value         = ""
            .Left          = 421
            .Top           = 114
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.cCtaCslls"
            .Margin        = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__dcontacsll", "TextBox")
        WITH par_oPg.txt_4c__dcontacsll
            .Value         = ""
            .Left          = 500
            .Top           = 114
            .Width         = 220
            .Height        = 22
            .FontSize      = 8
            .ControlSource = ""
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- LINHA ISS (Top=133/138)
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label30", "Label")
        WITH par_oPg.lbl_4c_Label30
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "ISS"
            .Height    = 15
            .Left      = 16
            .Top       = 138
            .Width     = 21
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("obj_4c_Opt_vencIss", "OptionGroup")
        WITH par_oPg.obj_4c_Opt_vencIss
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 1
            .Value         = 1
            .ControlSource = "cursor_4c_Dados.vciss"
            .Height        = 24
            .Left          = 66
            .Top           = 133
            .Width         = 261
            .Visible       = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_vencIss.Buttons(1)
            .Caption    = "T" + CHR(237) + "tulo"
            .Left       = 5
            .Top        = 5
            .Width      = 44
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_vencIss.Buttons(2)
            .Caption    = "10 D F M" + CHR(234) + "s"
            .Left       = 52
            .Top        = 5
            .Width      = 71
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.obj_4c_Opt_vencIss.Buttons(3)
            .Caption    = CHR(218) + "lt Dia " + CHR(218) + "til Quinz Seg"
            .Left       = 129
            .Top        = 5
            .Width      = 118
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .AutoSize   = .T.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__grupoiss", "TextBox")
        WITH par_oPg.txt_4c__grupoiss
            .Value         = ""
            .Left          = 342
            .Top           = 137
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .Alignment     = 3
            .ControlSource = "cursor_4c_Dados.cGrpIss"
            .Margin        = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__contaiss", "TextBox")
        WITH par_oPg.txt_4c__contaiss
            .Value         = ""
            .Left          = 421
            .Top           = 137
            .Width         = 78
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.cCtaIss"
            .Margin        = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c__dcontaiss", "TextBox")
        WITH par_oPg.txt_4c__dcontaiss
            .Value         = ""
            .Left          = 500
            .Top           = 137
            .Width         = 220
            .Height        = 22
            .FontSize      = 8
            .ControlSource = ""
            .Margin        = 2
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- SECAO: Produtos (grdProdutos + cmdInserir + cmdExcluir)
        *-- "Produtos (utilizado para cupons fiscais - NFe)"
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPg.lbl_4c_Label1
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 1
            .Caption   = "Produtos (utilizado para cupons fiscais - NFe)"
            .Height    = 15
            .Left      = 16
            .Top       = 169
            .Width     = 255
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- grdProdutos: Top=187, Left=14, Width=430, Height=138, ColumnCount=2
        *-- Cursor: cursor_4c_Produtos | Cols: cPros(108), dPros(290)
        par_oPg.AddObject("grd_4c_Dados", "Grid")
        WITH par_oPg.grd_4c_Dados
            .Top               = 187
            .Left              = 14
            .Width             = 430
            .Height            = 138
            .ColumnCount       = 2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .T.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightStyle    = 2
            .Visible           = .T.
        ENDWITH

        WITH par_oPg.grd_4c_Dados.Column1
            .Width    = 108
            .FontSize = 8
        ENDWITH
        WITH par_oPg.grd_4c_Dados.Column1.Header1
            .Caption   = "C" + CHR(243) + "digo"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        WITH par_oPg.grd_4c_Dados.Column2
            .Width     = 290
            .FontSize  = 8
            .Alignment = 3
        ENDWITH
        WITH par_oPg.grd_4c_Dados.Column2.Header1
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- cmdInserir: Top=234, Left=448, Width=64, Height=46
        par_oPg.AddObject("cmd_4c_CmdInserir", "CommandButton")
        WITH par_oPg.cmd_4c_CmdInserir
            .Top           = 234
            .Left          = 448
            .Height        = 46
            .Width         = 64
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Picture       = gc_4c_CaminhoIcones + "A_INSERT1.bmp"
            .Caption       = "I\<nserir"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(par_oPg.cmd_4c_CmdInserir, "Click", THIS, "BtnInserirProdutoClick")

        *-- cmdExcluir: Top=280, Left=448, Width=64, Height=46
        par_oPg.AddObject("cmd_4c_CmdExcluir", "CommandButton")
        WITH par_oPg.cmd_4c_CmdExcluir
            .Top           = 280
            .Left          = 448
            .Height        = 46
            .Width         = 64
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Picture       = gc_4c_CaminhoIcones + "A_DELETE1.bmp"
            .Caption       = "E\<xcluir"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(par_oPg.cmd_4c_CmdExcluir, "Click", THIS, "BtnExcluirProdutoClick")
    ENDPROC

    *==========================================================================
    * ConfigurarSubPaginaRetencao - Page3 do inner PF (pgRetencao)
    * Secoes: Codigos de retencao (PIS/COFINS/CSLL) + container RPA
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSubPaginaRetencao(par_oPg)
        *-- Shape1: fundo secao codigos retencao Top=13, H=37, W=721
        par_oPg.AddObject("shp_4c_Shape1", "Shape")
        WITH par_oPg.shp_4c_Shape1
            .Top           = 13
            .Left          = 5
            .Height        = 37
            .Width         = 721
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- SECAO: Codigos de retencao (nao-RPA): PIS, COFINS, CSLL
        *----------------------------------------------------------------------
        par_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPg.lbl_4c_Label1
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 1
            .Caption   = "C" + CHR(243) + "digos de reten" + CHR(231) + CHR(227) + "o"
            .Height    = 15
            .Left      = 18
            .Top       = 6
            .Width     = 117
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Label2: "PIS :" Left=199, Top=24
        par_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH par_oPg.lbl_4c_Label2
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "PIS :"
            .Height    = 15
            .Left      = 199
            .Top       = 24
            .Width     = 27
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_PIS (retencao): Left=228, Top=21, Width=50, CS=codpiss
        par_oPg.AddObject("txt_4c__PIS", "TextBox")
        WITH par_oPg.txt_4c__PIS
            .Value         = ""
            .Left          = 228
            .Top           = 21
            .Width         = 50
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.codpiss"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label4: "COFINS :" Left=294, Top=24
        par_oPg.AddObject("lbl_4c_Label4", "Label")
        WITH par_oPg.lbl_4c_Label4
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "COFINS :"
            .Height    = 15
            .Left      = 294
            .Top       = 24
            .Width     = 48
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_COFINS (retencao): Left=344, Top=21, Width=50, CS=codcofinss
        par_oPg.AddObject("txt_4c__COFINS", "TextBox")
        WITH par_oPg.txt_4c__COFINS
            .Value         = ""
            .Left          = 344
            .Top           = 21
            .Width         = 50
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.codcofinss"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label8: "CSLL :" Left=403, Top=24
        par_oPg.AddObject("lbl_4c_Label8", "Label")
        WITH par_oPg.lbl_4c_Label8
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "CSLL :"
            .Height    = 15
            .Left      = 403
            .Top       = 24
            .Width     = 34
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_CSLL (retencao): Left=439, Top=21, Width=50, CS=codcslls
        par_oPg.AddObject("txt_4c__CSLL", "TextBox")
        WITH par_oPg.txt_4c__CSLL
            .Value         = ""
            .Left          = 439
            .Top           = 21
            .Width         = 50
            .Height        = 22
            .FontSize      = 8
            .BackStyle     = 1
            .ControlSource = "cursor_4c_Dados.codcslls"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CONTAINER RPA (cntRPA: Top=64, Left=9, Width=721, Height=125)
        *-- Visibilidade controlada por this_cTipo (Visible apenas para Entradas)
        *----------------------------------------------------------------------
        par_oPg.AddObject("cnt_4c_RPA", "Container")
        WITH par_oPg.cnt_4c_RPA
            .Top         = 64
            .Left        = 9
            .Width       = 721
            .Height      = 125
            .BackStyle   = 0
            .SpecialEffect = 0
            .Visible     = .F.   && Controlado em InicializarForm por this_cTipo
        ENDWITH

        *-- Shape2 dentro do cntRPA: separador horizontal Top=76, H=2
        par_oPg.cnt_4c_RPA.AddObject("shp_4c_Shape2", "Shape")
        WITH par_oPg.cnt_4c_RPA.shp_4c_Shape2
            .Top           = 76
            .Left          = 1
            .Height        = 2
            .Width         = 681
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label3: "RPA" Left=5, Top=1
        par_oPg.cnt_4c_RPA.AddObject("lbl_4c_Label3", "Label")
        WITH par_oPg.cnt_4c_RPA.lbl_4c_Label3
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = " RPA "
            .Height    = 15
            .Left      = 5
            .Top       = 1
            .Width     = 31
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label16: "Servico e um RPA :" Left=123, Top=16
        par_oPg.cnt_4c_RPA.AddObject("lbl_4c_Label16", "Label")
        WITH par_oPg.cnt_4c_RPA.lbl_4c_Label16
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Servi" + CHR(231) + "o " + CHR(233) + " um RPA :"
            .Height    = 15
            .Left      = 123
            .Top       = 16
            .Width     = 107
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- opt_RPA: Left=249, Top=12, Width=93, ButtonCount=2, CS=nrpas
        *-- Value=2 = "Nao" por padrao
        par_oPg.cnt_4c_RPA.AddObject("obj_4c_Opt_RPA", "OptionGroup")
        WITH par_oPg.cnt_4c_RPA.obj_4c_Opt_RPA
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .ControlSource = "cursor_4c_Dados.nrpas"
            .Height        = 24
            .Left          = 249
            .Top           = 12
            .Width         = 122
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        WITH par_oPg.cnt_4c_RPA.obj_4c_Opt_RPA.Buttons(1)
            .Caption    = "Sim"
            .Left       = 5
            .Top        = 4
            .Width      = 44
            .Height     = 17
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        WITH par_oPg.cnt_4c_RPA.obj_4c_Opt_RPA.Buttons(2)
            .Caption    = "N" + CHR(227) + "o"
            .Left       = 50
            .Top        = 4
            .Width      = 62
            .Height     = 17
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        *-- Label5: "Valor Maximo p/ Retencao do INSS :" Left=10, Top=43
        par_oPg.cnt_4c_RPA.AddObject("lbl_4c_Label5", "Label")
        WITH par_oPg.cnt_4c_RPA.lbl_4c_Label5
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Valor M" + CHR(225) + "ximo p/ Reten" + CHR(231) + CHR(227) + "o do INSS :"
            .Height    = 15
            .Left      = 10
            .Top       = 43
            .Width     = 204
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_MaxRetInss: Left=248, Top=40, Width=90
        par_oPg.cnt_4c_RPA.AddObject("txt_4c__MaxRetInss", "TextBox")
        WITH par_oPg.cnt_4c_RPA.txt_4c__MaxRetInss
            .Value         = 0
            .Left          = 248
            .Top           = 40
            .Width         = 90
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.maxretinss"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label6: "Codigos de Receita no DARF" Left=9, Top=69, BackStyle=1
        par_oPg.cnt_4c_RPA.AddObject("lbl_4c_Label6", "Label")
        WITH par_oPg.cnt_4c_RPA.lbl_4c_Label6
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 1
            .Caption   = "C" + CHR(243) + "digos de Receita no DARF "
            .Height    = 15
            .Left      = 9
            .Top       = 69
            .Width     = 162
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Label7: "PIS :" Left=137, Top=94
        par_oPg.cnt_4c_RPA.AddObject("lbl_4c_Label7", "Label")
        WITH par_oPg.cnt_4c_RPA.lbl_4c_Label7
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "PIS :"
            .Height    = 15
            .Left      = 137
            .Top       = 94
            .Width     = 27
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCodRecPis: Left=169, Top=91, Width=50
        par_oPg.cnt_4c_RPA.AddObject("txt_4c_CodRecPis", "TextBox")
        WITH par_oPg.cnt_4c_RPA.txt_4c_CodRecPis
            .Value         = ""
            .Left          = 169
            .Top           = 91
            .Width         = 50
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.codrecpis"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label9: "COFINS :" Left=227, Top=94
        par_oPg.cnt_4c_RPA.AddObject("lbl_4c_Label9", "Label")
        WITH par_oPg.cnt_4c_RPA.lbl_4c_Label9
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "COFINS :"
            .Height    = 15
            .Left      = 227
            .Top       = 94
            .Width     = 48
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCodRecCof: Left=285, Top=91, Width=50
        par_oPg.cnt_4c_RPA.AddObject("txt_4c_CodRecCof", "TextBox")
        WITH par_oPg.cnt_4c_RPA.txt_4c_CodRecCof
            .Value         = ""
            .Left          = 285
            .Top           = 91
            .Width         = 50
            .Height        = 22
            .FontSize      = 8
            .ControlSource = "cursor_4c_Dados.codreccof"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label10: "CSLL :" Left=340, Top=94
        par_oPg.cnt_4c_RPA.AddObject("lbl_4c_Label10", "Label")
        WITH par_oPg.cnt_4c_RPA.lbl_4c_Label10
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "CSLL :"
            .Height    = 15
            .Left      = 340
            .Top       = 94
            .Width     = 34
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCodRecCsll: Left=382, Top=92, Width=50
        par_oPg.cnt_4c_RPA.AddObject("txt_4c_CodRecCsll", "TextBox")
        WITH par_oPg.cnt_4c_RPA.txt_4c_CodRecCsll
            .Value         = ""
            .Left          = 382
            .Top           = 92
            .Width         = 50
            .Height        = 22
            .FontSize      = 8
            .BackStyle     = 1
            .ControlSource = "cursor_4c_Dados.codreccsll"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label11: "IRRF :" Left=441, Top=94
        par_oPg.cnt_4c_RPA.AddObject("lbl_4c_Label11", "Label")
        WITH par_oPg.cnt_4c_RPA.lbl_4c_Label11
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "IRRF :"
            .Height    = 15
            .Left      = 441
            .Top       = 94
            .Width     = 35
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- getCodRecIrrf: Left=483, Top=91, Width=50
        par_oPg.cnt_4c_RPA.AddObject("txt_4c_CodRecIrrf", "TextBox")
        WITH par_oPg.cnt_4c_RPA.txt_4c_CodRecIrrf
            .Value         = ""
            .Left          = 483
            .Top           = 91
            .Width         = 50
            .Height        = 22
            .FontSize      = 8
            .BackStyle     = 1
            .ControlSource = "cursor_4c_Dados.codrecirrf"
            .Format        = "!K"
            .InputMask     = ""
            .MaxLength     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    *-- HANDLERS DE BOTOES (PUBLIC - obrigatorio para BINDEVENT)
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF NOT USED("cursor_4c_Dados")
                IF !THIS.CarregarLista()
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            SELECT cursor_4c_Dados
            APPEND BLANK
            REPLACE cursor_4c_Dados.cTipos    WITH THIS.this_cTipo
            REPLACE cursor_4c_Dados.cIdChaves WITH SYS(2015)

            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                ZAP
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Produtos (CodServs C(10), cPros C(10), dPros C(50), cIdChaves C(16))
                SET NULL OFF
            ENDIF

            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
            THIS.HabilitarCampos()
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Codigos.SetFocus
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao incluir: " + loc_oErro.Message)
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                THIS.CarregarProdutos()
                THIS.CarregarDescricoesConta()
                THIS.this_oBusinessObject.this_lNovoRegistro = .F.
                THIS.this_cModoAtual = "CONSULTAR"
                THIS.AlternarPagina(2)
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
                THIS.DesabilitarCampos()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao visualizar: " + loc_oErro.Message)
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                THIS.CarregarProdutos()
                THIS.CarregarDescricoesConta()
                THIS.this_oBusinessObject.this_lNovoRegistro = .F.
                THIS.this_oBusinessObject.this_lEmEdicao = .T.
                THIS.this_cModoAtual = "ALTERAR"
                THIS.AlternarPagina(2)
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
                THIS.HabilitarCampos()
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Codigos.SetFocus
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao alterar: " + loc_oErro.Message)
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_lValido, loc_nResp, loc_cCod
        loc_lResultado = .F.
        TRY
            loc_lValido = (USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados"))
            IF loc_lValido
                loc_cCod = ALLTRIM(cursor_4c_Dados.CodServs)
                IF EMPTY(loc_cCod)
                    loc_lValido = .F.
                ENDIF
            ENDIF
            IF loc_lValido
                loc_nResp = MsgConfirma("Confirma a exclus" + CHR(227) + "o do servi" + CHR(231) + CHR(227) + "o " + loc_cCod + "?")
                IF loc_nResp
                    THIS.this_oBusinessObject.this_cCodServs    = loc_cCod
                    THIS.this_oBusinessObject.this_cTipos       = THIS.this_cTipo
                    THIS.this_oBusinessObject.this_lNovoRegistro = .F.
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Servi" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                        loc_lResultado = .T.
                    ELSE
                        MsgErro(THIS.this_oBusinessObject.ObterMensagemErro())
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir: " + loc_oErro.Message)
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF NOT USED("cursor_4c_Dados")
                THIS.CarregarLista()
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", "cursor_4c_Dados", "CodServs")
            loc_oBusca.mAddColuna("CodServs",  "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("DescServs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                *-- cursor ja esta posicionado no registro selecionado
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                loc_lResultado = .T.
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro("Erro na busca: " + loc_oErro.Message)
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lResultado
        loc_lResultado = .T.
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_lValido, loc_lNovoReg, loc_cCod, loc_cSQL, loc_nRet
        loc_lResultado = .F.
        TRY
            loc_lValido = USED("cursor_4c_Dados")
            IF !loc_lValido
                MsgAviso("Nenhum registro para salvar")
            ENDIF
            IF loc_lValido
                loc_lNovoReg = (THIS.this_cModoAtual = "INCLUIR")
                loc_cCod = ALLTRIM(cursor_4c_Dados.CodServs)
                IF EMPTY(loc_cCod)
                    MsgAviso("Obrigat" + CHR(243) + "rio informar o C" + CHR(243) + "digo!")
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Codigos.SetFocus
                    loc_lValido = .F.
                ENDIF
            ENDIF
            IF loc_lValido
                IF EMPTY(ALLTRIM(cursor_4c_Dados.DescServs))
                    MsgAviso("Obrigat" + CHR(243) + "rio informar a Descri" + CHR(231) + CHR(227) + "o!")
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Descricao.SetFocus
                    loc_lValido = .F.
                ENDIF
            ENDIF
            IF loc_lValido AND loc_lNovoReg
                *-- Verificar duplicidade no INSERT
                loc_cSQL = "SELECT CodServs FROM SigCdSrv WHERE CodServs = " + ;
                           EscaparSQL(loc_cCod) + " AND cTipos = " + EscaparSQL(THIS.this_cTipo)
                IF USED("cursor_4c_BuscaDup")
                    USE IN cursor_4c_BuscaDup
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDup")
                IF loc_nRet > 0 AND USED("cursor_4c_BuscaDup") AND !EOF("cursor_4c_BuscaDup")
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Codigos.SetFocus
                    loc_lValido = .F.
                ENDIF
                IF USED("cursor_4c_BuscaDup")
                    USE IN cursor_4c_BuscaDup
                ENDIF
            ENDIF
            IF loc_lValido AND loc_lNovoReg
                *-- Garantir cTipos e cIdChaves preenchidos
                REPLACE cursor_4c_Dados.cTipos WITH THIS.this_cTipo
                IF EMPTY(ALLTRIM(cursor_4c_Dados.cIdChaves))
                    REPLACE cursor_4c_Dados.cIdChaves WITH SYS(2015)
                ENDIF
            ENDIF
            IF loc_lValido
                *-- Transferir cursor -> BO e salvar
                THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    THIS.SalvarProdutos(loc_cCod)
                    MsgInfo("Servi" + CHR(231) + CHR(227) + "o salvo com sucesso!")
                    THIS.DesabilitarCampos()
                    THIS.AlternarPagina(1)
                    THIS.CarregarLista()
                    THIS.this_cModoAtual = "LISTA"
                    loc_lResultado = .T.
                ELSE
                    MsgErro(THIS.this_oBusinessObject.ObterMensagemErro())
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar: " + loc_oErro.Message)
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_oBusinessObject.CancelarEdicao()
            THIS.DesabilitarCampos()
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    PROCEDURE BtnInserirProdutoClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF NOT USED("cursor_4c_Produtos")
                SET NULL ON
                CREATE CURSOR cursor_4c_Produtos (CodServs C(10), cPros C(10), dPros C(50), cIdChaves C(16))
                SET NULL OFF
            ENDIF
            SELECT cursor_4c_Produtos
            IF EOF("cursor_4c_Produtos") OR !EMPTY(ALLTRIM(cursor_4c_Produtos.cPros))
                APPEND BLANK
                IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                    REPLACE cursor_4c_Produtos.CodServs  WITH ALLTRIM(cursor_4c_Dados.CodServs)
                ENDIF
                REPLACE cursor_4c_Produtos.cIdChaves WITH SYS(2015)
            ENDIF
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Dados.Refresh()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir produto: " + loc_oErro.Message)
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnExcluirProdutoClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Produtos") AND !EOF("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                DELETE
                SKIP
                IF EOF("cursor_4c_Produtos")
                    SKIP -1
                ENDIF
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Dados.Refresh()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir produto: " + loc_oErro.Message)
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *-- LostFocus: Validacao de campos de Ocorrencia (todos seguem mesmo padrao)
    PROCEDURE ValidarCodOcorPis(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        THIS.ValidarCampoOcorrencia(loc_pg.txt_4c__CodOcorPis)
    ENDPROC

    PROCEDURE ValidarCodOcorCofins(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        THIS.ValidarCampoOcorrencia(loc_pg.txt_4c__CodOcorCofins)
    ENDPROC

    PROCEDURE ValidarCodOcorIrrf(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        THIS.ValidarCampoOcorrencia(loc_pg.txt_4c__CodOcorIrrf)
    ENDPROC

    PROCEDURE ValidarCodOcorInss(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        THIS.ValidarCampoOcorrencia(loc_pg.txt_4c__CodOcorInss)
    ENDPROC

    PROCEDURE ValidarCodOcorCsll(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        THIS.ValidarCampoOcorrencia(loc_pg.txt_4c__CodOcorCsll)
    ENDPROC

    PROCEDURE ValidarCodOcoriSS(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        THIS.ValidarCampoOcorrencia(loc_pg.txt_4c__CodOcoriSS)
    ENDPROC

    *-- LostFocus: Conta contabil principal (pgImpostos)
    PROCEDURE ValidarGrupoImpostos(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg, loc_cValor
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cValor = ALLTRIM(loc_pg.txt_4c_Grupo.Value)
        IF EMPTY(loc_cValor)
            loc_pg.txt_4c_Contao.Value = ""
            loc_pg.txt_4c_Dcontao.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE ValidarContaImpostos(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        THIS.BuscarDescricaoConta(loc_pg.txt_4c_Contao, loc_pg.txt_4c_Dcontao)
    ENDPROC

    *-- LostFocus: Contas contabeis por imposto (pgVencimentos)
    PROCEDURE ValidarGrupoPis(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg, loc_cValor
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_cValor = ALLTRIM(loc_pg.txt_4c__grupopis.Value)
        IF EMPTY(loc_cValor)
            loc_pg.txt_4c__contapis.Value  = ""
            loc_pg.txt_4c__dcontapis.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE ValidarContaPis(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        THIS.BuscarDescricaoConta(loc_pg.txt_4c__contapis, loc_pg.txt_4c__dcontapis)
    ENDPROC

    PROCEDURE ValidarGrupoCofins(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg, loc_cValor
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_cValor = ALLTRIM(loc_pg.txt_4c__grupocofins.Value)
        IF EMPTY(loc_cValor)
            loc_pg.txt_4c__contacofins.Value  = ""
            loc_pg.txt_4c__dcontacofins.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE ValidarContaCofins(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        THIS.BuscarDescricaoConta(loc_pg.txt_4c__contacofins, loc_pg.txt_4c__dcontacofins)
    ENDPROC

    PROCEDURE ValidarGrupoIrrf(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg, loc_cValor
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_cValor = ALLTRIM(loc_pg.txt_4c__grupoirrf.Value)
        IF EMPTY(loc_cValor)
            loc_pg.txt_4c__contairrf.Value  = ""
            loc_pg.txt_4c__dcontairrf.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE ValidarContaIrrf(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        THIS.BuscarDescricaoConta(loc_pg.txt_4c__contairrf, loc_pg.txt_4c__dcontairrf)
    ENDPROC

    PROCEDURE ValidarGrupoInss(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg, loc_cValor
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_cValor = ALLTRIM(loc_pg.txt_4c__grupoinss.Value)
        IF EMPTY(loc_cValor)
            loc_pg.txt_4c__containss.Value  = ""
            loc_pg.txt_4c__dcontainss.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE ValidarContaInss(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        THIS.BuscarDescricaoConta(loc_pg.txt_4c__containss, loc_pg.txt_4c__dcontainss)
    ENDPROC

    PROCEDURE ValidarGrupoCsll(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg, loc_cValor
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_cValor = ALLTRIM(loc_pg.txt_4c__grupocsll.Value)
        IF EMPTY(loc_cValor)
            loc_pg.txt_4c__contacsll.Value  = ""
            loc_pg.txt_4c__dcontacsll.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE ValidarContaCsll(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        THIS.BuscarDescricaoConta(loc_pg.txt_4c__contacsll, loc_pg.txt_4c__dcontacsll)
    ENDPROC

    PROCEDURE ValidarGrupoIss(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg, loc_cValor
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_cValor = ALLTRIM(loc_pg.txt_4c__grupoiss.Value)
        IF EMPTY(loc_cValor)
            loc_pg.txt_4c__contaiss.Value  = ""
            loc_pg.txt_4c__dcontaiss.Value = ""
        ENDIF
    ENDPROC

    PROCEDURE ValidarContaIss(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_pg
        loc_pg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        THIS.BuscarDescricaoConta(loc_pg.txt_4c__contaiss, loc_pg.txt_4c__dcontaiss)
    ENDPROC

    *==========================================================================
    *-- METODOS DE DADOS
    *==========================================================================

    PROCEDURE CarregarLista()
        LOCAL loc_cSQL, loc_nRet, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigCdSrv WHERE cTipos = " + EscaparSQL(THIS.this_cTipo) + " ORDER BY CodServs"
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
            IF loc_nRet > 0
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                SELECT * FROM cursor_4c_DadosTemp INTO CURSOR cursor_4c_Dados READWRITE
                USE IN cursor_4c_DadosTemp
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.RecordSource = ""
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.ColumnCount = 2
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Dados.CodServs"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Dados.DescServs"
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar lista de servi" + CHR(231) + CHR(227) + "os"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROTECTED PROCEDURE CarregarRegistroSelecionado()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Refresh()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROTECTED PROCEDURE CarregarProdutos()
        LOCAL loc_cCod, loc_cSQL, loc_nRet
        TRY
            IF NOT (USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados"))
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(cursor_4c_Dados.CodServs)
            IF EMPTY(loc_cCod)
                IF USED("cursor_4c_Produtos")
                    SELECT cursor_4c_Produtos
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Produtos (CodServs C(10), cPros C(10), dPros C(50), cIdChaves C(16))
                    SET NULL OFF
                ENDIF
                RETURN
            ENDIF
            loc_cSQL = "SELECT a.CodServs, a.cPros, b.dPros, a.cIdChaves " + ;
                       "FROM SigSeRvp a " + ;
                       "INNER JOIN SigCdPro b ON b.cpros = a.cpros " + ;
                       "WHERE a.CodServs = " + EscaparSQL(loc_cCod)
            IF USED("cursor_4c_ProdTemp")
                USE IN cursor_4c_ProdTemp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdTemp")
            IF USED("cursor_4c_Produtos")
                USE IN cursor_4c_Produtos
            ENDIF
            IF loc_nRet > 0
                SELECT * FROM cursor_4c_ProdTemp INTO CURSOR cursor_4c_Produtos READWRITE
                USE IN cursor_4c_ProdTemp
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Produtos (CodServs C(10), cPros C(10), dPros C(50), cIdChaves C(16))
                SET NULL OFF
                IF USED("cursor_4c_ProdTemp")
                    USE IN cursor_4c_ProdTemp
                ENDIF
            ENDIF
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Dados.RecordSource = ""
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Dados.ColumnCount = 2
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.cPros"
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.dPros"
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE CarregarDescricoesConta()
        LOCAL loc_pg1, loc_pg2
        TRY
            IF NOT (USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados"))
                RETURN
            ENDIF
            loc_pg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_pg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            THIS.BuscarDescricaoConta(loc_pg1.txt_4c_Contao,      loc_pg1.txt_4c_Dcontao)
            THIS.BuscarDescricaoConta(loc_pg2.txt_4c__contapis,   loc_pg2.txt_4c__dcontapis)
            THIS.BuscarDescricaoConta(loc_pg2.txt_4c__contacofins, loc_pg2.txt_4c__dcontacofins)
            THIS.BuscarDescricaoConta(loc_pg2.txt_4c__contairrf,  loc_pg2.txt_4c__dcontairrf)
            THIS.BuscarDescricaoConta(loc_pg2.txt_4c__containss,  loc_pg2.txt_4c__dcontainss)
            THIS.BuscarDescricaoConta(loc_pg2.txt_4c__contacsll,  loc_pg2.txt_4c__dcontacsll)
            THIS.BuscarDescricaoConta(loc_pg2.txt_4c__contaiss,   loc_pg2.txt_4c__dcontaiss)
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO
        TRY
            IF NOT (USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados"))
                RETURN
            ENDIF
            loc_oBO = THIS.this_oBusinessObject
            loc_oBO.this_cCodServs   = ALLTRIM(cursor_4c_Dados.CodServs)
            loc_oBO.this_cDescServs  = ALLTRIM(cursor_4c_Dados.DescServs)
            loc_oBO.this_cTipos      = THIS.this_cTipo
            loc_oBO.this_cIdChaves   = ALLTRIM(cursor_4c_Dados.cIdChaves)
            loc_oBO.this_nAiss       = NVL(cursor_4c_Dados.aiss, 0)
            loc_oBO.this_nApiss      = NVL(cursor_4c_Dados.apiss, 0)
            loc_oBO.this_nAcofinss   = NVL(cursor_4c_Dados.acofinss, 0)
            loc_oBO.this_nAirrfs     = NVL(cursor_4c_Dados.airrfs, 0)
            loc_oBO.this_nAinss      = NVL(cursor_4c_Dados.ainss, 0)
            loc_oBO.this_nAcslls     = NVL(cursor_4c_Dados.acslls, 0)
            loc_oBO.this_nVminpiss   = NVL(cursor_4c_Dados.vminpiss, 0)
            loc_oBO.this_nVmincofins = NVL(cursor_4c_Dados.vmincofins, 0)
            loc_oBO.this_nVMinIrrfs  = NVL(cursor_4c_Dados.vMinIrrfs, 0)
            loc_oBO.this_nVMinInss   = NVL(cursor_4c_Dados.vMinInss, 0)
            loc_oBO.this_nVMinCslls  = NVL(cursor_4c_Dados.vMinCslls, 0)
            loc_oBO.this_nVminbpiss  = NVL(cursor_4c_Dados.vminbpiss, 0)
            loc_oBO.this_nVminbcofin = NVL(cursor_4c_Dados.vminbcofin, 0)
            loc_oBO.this_nVMinbIrrfs = NVL(cursor_4c_Dados.vMinbIrrfs, 0)
            loc_oBO.this_nVMinbInss  = NVL(cursor_4c_Dados.vMinbInss, 0)
            loc_oBO.this_nVMinbCslls = NVL(cursor_4c_Dados.vMinbCslls, 0)
            loc_oBO.this_nNLanFPiss  = NVL(cursor_4c_Dados.nLanFPiss, 0)
            loc_oBO.this_nNLanFCofin = NVL(cursor_4c_Dados.nLanFCofin, 0)
            loc_oBO.this_nNLanFIrrfs = NVL(cursor_4c_Dados.nLanFIrrfs, 0)
            loc_oBO.this_nNLanFInss  = NVL(cursor_4c_Dados.nLanFInss, 0)
            loc_oBO.this_nNLanFIss   = NVL(cursor_4c_Dados.nLanFIss, 0)
            loc_oBO.this_nNLanFCslls = NVL(cursor_4c_Dados.nLanFCslls, 0)
            loc_oBO.this_nBpisms     = NVL(cursor_4c_Dados.bpisms, 0)
            loc_oBO.this_nBcofinms   = NVL(cursor_4c_Dados.bcofinms, 0)
            loc_oBO.this_nBirrfms    = NVL(cursor_4c_Dados.birrfms, 0)
            loc_oBO.this_nBinssms    = NVL(cursor_4c_Dados.binssms, 0)
            loc_oBO.this_nBcsllms    = NVL(cursor_4c_Dados.bcsllms, 0)
            loc_oBO.this_cOcorPiss   = ALLTRIM(NVL(cursor_4c_Dados.cOcorPiss, ""))
            loc_oBO.this_cOcorCofin  = ALLTRIM(NVL(cursor_4c_Dados.cOcorCofin, ""))
            loc_oBO.this_cOcorIrrfs  = ALLTRIM(NVL(cursor_4c_Dados.cOcorIrrfs, ""))
            loc_oBO.this_cOcorInss   = ALLTRIM(NVL(cursor_4c_Dados.cOcorInss, ""))
            loc_oBO.this_cOcorCslls  = ALLTRIM(NVL(cursor_4c_Dados.cOcorCslls, ""))
            loc_oBO.this_cOcoriSS    = ALLTRIM(NVL(cursor_4c_Dados.cOcoriSS, ""))
            loc_oBO.this_cGrupo      = ALLTRIM(NVL(cursor_4c_Dados.cGrupo, ""))
            loc_oBO.this_cContab     = ALLTRIM(NVL(cursor_4c_Dados.cContab, ""))
            loc_oBO.this_nVcpis      = NVL(cursor_4c_Dados.vcpis, 1)
            loc_oBO.this_nVccofins   = NVL(cursor_4c_Dados.vccofins, 1)
            loc_oBO.this_nVcirrf     = NVL(cursor_4c_Dados.vcirrf, 1)
            loc_oBO.this_nVcinss     = NVL(cursor_4c_Dados.vcinss, 1)
            loc_oBO.this_nVccsll     = NVL(cursor_4c_Dados.vccsll, 1)
            loc_oBO.this_nVciss      = NVL(cursor_4c_Dados.vciss, 1)
            loc_oBO.this_cGrppiss    = ALLTRIM(NVL(cursor_4c_Dados.cGrppiss, ""))
            loc_oBO.this_cCtaPiss    = ALLTRIM(NVL(cursor_4c_Dados.cCtaPiss, ""))
            loc_oBO.this_cGrpCofins  = ALLTRIM(NVL(cursor_4c_Dados.cGrpCofins, ""))
            loc_oBO.this_cCtaCofins  = ALLTRIM(NVL(cursor_4c_Dados.cCtaCofins, ""))
            loc_oBO.this_cGrpIrrfs   = ALLTRIM(NVL(cursor_4c_Dados.cGrpIrrfs, ""))
            loc_oBO.this_cCtaIrrfs   = ALLTRIM(NVL(cursor_4c_Dados.cCtaIrrfs, ""))
            loc_oBO.this_cGrpInss    = ALLTRIM(NVL(cursor_4c_Dados.cGrpInss, ""))
            loc_oBO.this_cCtaInss    = ALLTRIM(NVL(cursor_4c_Dados.cCtaInss, ""))
            loc_oBO.this_cGrpCslls   = ALLTRIM(NVL(cursor_4c_Dados.cGrpCslls, ""))
            loc_oBO.this_cCtaCslls   = ALLTRIM(NVL(cursor_4c_Dados.cCtaCslls, ""))
            loc_oBO.this_cGrpIss     = ALLTRIM(NVL(cursor_4c_Dados.cGrpIss, ""))
            loc_oBO.this_cCtaIss     = ALLTRIM(NVL(cursor_4c_Dados.cCtaIss, ""))
            loc_oBO.this_cCodpiss    = ALLTRIM(NVL(cursor_4c_Dados.codpiss, ""))
            loc_oBO.this_cCodcofinss = ALLTRIM(NVL(cursor_4c_Dados.codcofinss, ""))
            loc_oBO.this_cCodcslls   = ALLTRIM(NVL(cursor_4c_Dados.codcslls, ""))
            loc_oBO.this_cCodrecpis  = ALLTRIM(NVL(cursor_4c_Dados.codrecpis, ""))
            loc_oBO.this_cCodreccof  = ALLTRIM(NVL(cursor_4c_Dados.codreccof, ""))
            loc_oBO.this_cCodreccsll = ALLTRIM(NVL(cursor_4c_Dados.codreccsll, ""))
            loc_oBO.this_cCodrecirrf = ALLTRIM(NVL(cursor_4c_Dados.codrecirrf, ""))
            loc_oBO.this_nNrpas      = NVL(cursor_4c_Dados.nrpas, 2)
            loc_oBO.this_nMaxretinss = NVL(cursor_4c_Dados.maxretinss, 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        *-- Cursor cursor_4c_Dados tem os dados via ControlSource - apenas refresh
        TRY
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Refresh()
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE LimparCampos()
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                REPLACE cursor_4c_Dados.CodServs   WITH ""
                REPLACE cursor_4c_Dados.DescServs  WITH ""
                REPLACE cursor_4c_Dados.cIdChaves  WITH ""
                REPLACE cursor_4c_Dados.aiss       WITH 0
                REPLACE cursor_4c_Dados.apiss      WITH 0
                REPLACE cursor_4c_Dados.acofinss   WITH 0
                REPLACE cursor_4c_Dados.airrfs     WITH 0
                REPLACE cursor_4c_Dados.ainss      WITH 0
                REPLACE cursor_4c_Dados.acslls     WITH 0
                REPLACE cursor_4c_Dados.vcpis      WITH 1
                REPLACE cursor_4c_Dados.vccofins   WITH 1
                REPLACE cursor_4c_Dados.vcirrf     WITH 1
                REPLACE cursor_4c_Dados.vcinss     WITH 1
                REPLACE cursor_4c_Dados.vccsll     WITH 1
                REPLACE cursor_4c_Dados.vciss      WITH 1
                REPLACE cursor_4c_Dados.nrpas      WITH 2
                REPLACE cursor_4c_Dados.maxretinss WITH 0
            ENDIF
            *-- Limpar descricoes de conta (readonly)
            LOCAL loc_pg1, loc_pg2
            loc_pg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_pg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_pg1.txt_4c_Dcontao.Value      = ""
            loc_pg2.txt_4c__dcontapis.Value   = ""
            loc_pg2.txt_4c__dcontacofins.Value = ""
            loc_pg2.txt_4c__dcontairrf.Value  = ""
            loc_pg2.txt_4c__dcontainss.Value  = ""
            loc_pg2.txt_4c__dcontacsll.Value  = ""
            loc_pg2.txt_4c__dcontaiss.Value   = ""
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE HabilitarCampos()
        LOCAL loc_lEmEdicao
        loc_lEmEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        TRY
            LOCAL loc_pg1, loc_pg2, loc_pg3
            loc_pg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_pg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_pg3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3

            *-- Page1: Impostos
            loc_pg1.txt_4c_Codigos.ReadOnly   = !loc_lEmEdicao OR (THIS.this_cModoAtual = "ALTERAR")
            loc_pg1.txt_4c_Descricao.ReadOnly = !loc_lEmEdicao
            loc_pg1.txt_4c__ISS.ReadOnly      = !loc_lEmEdicao
            loc_pg1.txt_4c__PIS.ReadOnly      = !loc_lEmEdicao
            loc_pg1.txt_4c__COFINS.ReadOnly   = !loc_lEmEdicao
            loc_pg1.txt_4c__IRRF.ReadOnly     = !loc_lEmEdicao
            loc_pg1.txt_4c__INSS.ReadOnly     = !loc_lEmEdicao
            loc_pg1.txt_4c__CSLL.ReadOnly     = !loc_lEmEdicao

            loc_pg1.chk_4c_Chk_bpisms.Enabled    = loc_lEmEdicao
            loc_pg1.chk_4c_Chk_bcofinms.Enabled  = loc_lEmEdicao
            loc_pg1.chk_4c_Chk_birrfms.Enabled   = loc_lEmEdicao
            loc_pg1.chk_4c_Chk_binssms.Enabled   = loc_lEmEdicao
            loc_pg1.chk_4c_Chk_bcsllms.Enabled   = loc_lEmEdicao
            loc_pg1.chk_4c_Chk_LancFinPis.Enabled = loc_lEmEdicao
            loc_pg1.chk_4c_Ck_LancFinCofins.Enabled = loc_lEmEdicao
            loc_pg1.chk_4c_Ck_LancFinIrrf.Enabled   = loc_lEmEdicao
            loc_pg1.chk_4c_Ck_LancFinInss.Enabled   = loc_lEmEdicao
            loc_pg1.chk_4c_Ck_LancFinIss.Enabled    = loc_lEmEdicao
            loc_pg1.chk_4c_Ck_LancFinCsll.Enabled   = loc_lEmEdicao

            loc_pg1.txt_4c__CodOcorPis.ReadOnly    = !loc_lEmEdicao
            loc_pg1.txt_4c__CodOcorCofins.ReadOnly = !loc_lEmEdicao
            loc_pg1.txt_4c__CodOcorIrrf.ReadOnly   = !loc_lEmEdicao
            loc_pg1.txt_4c__CodOcorInss.ReadOnly   = !loc_lEmEdicao
            loc_pg1.txt_4c__CodOcorCsll.ReadOnly   = !loc_lEmEdicao
            loc_pg1.txt_4c__CodOcoriSS.ReadOnly    = !loc_lEmEdicao
            loc_pg1.txt_4c_Grupo.ReadOnly           = !loc_lEmEdicao
            loc_pg1.txt_4c_Contao.ReadOnly          = !loc_lEmEdicao

            *-- Page2: Vencimentos OptionGroups
            loc_pg2.obj_4c_Opt_VencPis.Enabled    = loc_lEmEdicao
            loc_pg2.obj_4c_Opt_VencCofins.Enabled = loc_lEmEdicao
            loc_pg2.obj_4c_Opt_VencIrrf.Enabled   = loc_lEmEdicao
            loc_pg2.obj_4c_Opt_VencInss.Enabled   = loc_lEmEdicao
            loc_pg2.obj_4c_Opt_VencCsll.Enabled   = loc_lEmEdicao
            loc_pg2.obj_4c_Opt_vencIss.Enabled    = loc_lEmEdicao

            loc_pg2.txt_4c__grupopis.ReadOnly     = !loc_lEmEdicao
            loc_pg2.txt_4c__contapis.ReadOnly     = !loc_lEmEdicao
            loc_pg2.txt_4c__grupocofins.ReadOnly  = !loc_lEmEdicao
            loc_pg2.txt_4c__contacofins.ReadOnly  = !loc_lEmEdicao
            loc_pg2.txt_4c__grupoirrf.ReadOnly    = !loc_lEmEdicao
            loc_pg2.txt_4c__contairrf.ReadOnly    = !loc_lEmEdicao
            loc_pg2.txt_4c__grupoinss.ReadOnly    = !loc_lEmEdicao
            loc_pg2.txt_4c__containss.ReadOnly    = !loc_lEmEdicao
            loc_pg2.txt_4c__grupocsll.ReadOnly    = !loc_lEmEdicao
            loc_pg2.txt_4c__contacsll.ReadOnly    = !loc_lEmEdicao
            loc_pg2.txt_4c__grupoiss.ReadOnly     = !loc_lEmEdicao
            loc_pg2.txt_4c__contaiss.ReadOnly     = !loc_lEmEdicao

            loc_pg2.cmd_4c_CmdInserir.Enabled = loc_lEmEdicao
            loc_pg2.cmd_4c_CmdExcluir.Enabled = loc_lEmEdicao

            *-- Page3: Retencao
            loc_pg3.txt_4c__PIS.ReadOnly   = !loc_lEmEdicao
            loc_pg3.txt_4c__COFINS.ReadOnly = !loc_lEmEdicao
            loc_pg3.txt_4c__CSLL.ReadOnly  = !loc_lEmEdicao
            IF THIS.this_cTipo = "E"
                loc_pg3.cnt_4c_RPA.obj_4c_Opt_RPA.Enabled       = loc_lEmEdicao
                loc_pg3.cnt_4c_RPA.txt_4c__MaxRetInss.ReadOnly  = !loc_lEmEdicao
                loc_pg3.cnt_4c_RPA.txt_4c_CodRecPis.ReadOnly    = !loc_lEmEdicao
                loc_pg3.cnt_4c_RPA.txt_4c_CodRecCof.ReadOnly    = !loc_lEmEdicao
                loc_pg3.cnt_4c_RPA.txt_4c_CodRecCsll.ReadOnly   = !loc_lEmEdicao
                loc_pg3.cnt_4c_RPA.txt_4c_CodRecIrrf.ReadOnly   = !loc_lEmEdicao
            ENDIF

            *-- Botoes salvar/cancelar
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.cmd_4c_Salvar.Enabled  = loc_lEmEdicao
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.cmd_4c_Cancelar.Enabled = .T.
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE DesabilitarCampos()
        TRY
            LOCAL loc_pg1, loc_pg2, loc_pg3
            loc_pg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_pg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_pg3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3

            loc_pg1.txt_4c_Codigos.ReadOnly   = .T.
            loc_pg1.txt_4c_Descricao.ReadOnly = .T.
            loc_pg1.txt_4c__ISS.ReadOnly      = .T.
            loc_pg1.txt_4c__PIS.ReadOnly      = .T.
            loc_pg1.txt_4c__COFINS.ReadOnly   = .T.
            loc_pg1.txt_4c__IRRF.ReadOnly     = .T.
            loc_pg1.txt_4c__INSS.ReadOnly     = .T.
            loc_pg1.txt_4c__CSLL.ReadOnly     = .T.
            loc_pg1.chk_4c_Chk_bpisms.Enabled    = .F.
            loc_pg1.chk_4c_Chk_bcofinms.Enabled  = .F.
            loc_pg1.chk_4c_Chk_birrfms.Enabled   = .F.
            loc_pg1.chk_4c_Chk_binssms.Enabled   = .F.
            loc_pg1.chk_4c_Chk_bcsllms.Enabled   = .F.
            loc_pg1.chk_4c_Chk_LancFinPis.Enabled = .F.
            loc_pg1.chk_4c_Ck_LancFinCofins.Enabled = .F.
            loc_pg1.chk_4c_Ck_LancFinIrrf.Enabled   = .F.
            loc_pg1.chk_4c_Ck_LancFinInss.Enabled   = .F.
            loc_pg1.chk_4c_Ck_LancFinIss.Enabled    = .F.
            loc_pg1.chk_4c_Ck_LancFinCsll.Enabled   = .F.
            loc_pg1.txt_4c__CodOcorPis.ReadOnly    = .T.
            loc_pg1.txt_4c__CodOcorCofins.ReadOnly = .T.
            loc_pg1.txt_4c__CodOcorIrrf.ReadOnly   = .T.
            loc_pg1.txt_4c__CodOcorInss.ReadOnly   = .T.
            loc_pg1.txt_4c__CodOcorCsll.ReadOnly   = .T.
            loc_pg1.txt_4c__CodOcoriSS.ReadOnly    = .T.
            loc_pg1.txt_4c_Grupo.ReadOnly           = .T.
            loc_pg1.txt_4c_Contao.ReadOnly          = .T.

            loc_pg2.obj_4c_Opt_VencPis.Enabled    = .F.
            loc_pg2.obj_4c_Opt_VencCofins.Enabled = .F.
            loc_pg2.obj_4c_Opt_VencIrrf.Enabled   = .F.
            loc_pg2.obj_4c_Opt_VencInss.Enabled   = .F.
            loc_pg2.obj_4c_Opt_VencCsll.Enabled   = .F.
            loc_pg2.obj_4c_Opt_vencIss.Enabled    = .F.
            loc_pg2.txt_4c__grupopis.ReadOnly     = .T.
            loc_pg2.txt_4c__contapis.ReadOnly     = .T.
            loc_pg2.txt_4c__grupocofins.ReadOnly  = .T.
            loc_pg2.txt_4c__contacofins.ReadOnly  = .T.
            loc_pg2.txt_4c__grupoirrf.ReadOnly    = .T.
            loc_pg2.txt_4c__contairrf.ReadOnly    = .T.
            loc_pg2.txt_4c__grupoinss.ReadOnly    = .T.
            loc_pg2.txt_4c__containss.ReadOnly    = .T.
            loc_pg2.txt_4c__grupocsll.ReadOnly    = .T.
            loc_pg2.txt_4c__contacsll.ReadOnly    = .T.
            loc_pg2.txt_4c__grupoiss.ReadOnly     = .T.
            loc_pg2.txt_4c__contaiss.ReadOnly     = .T.
            loc_pg2.cmd_4c_CmdInserir.Enabled = .F.
            loc_pg2.cmd_4c_CmdExcluir.Enabled = .F.

            loc_pg3.txt_4c__PIS.ReadOnly   = .T.
            loc_pg3.txt_4c__COFINS.ReadOnly = .T.
            loc_pg3.txt_4c__CSLL.ReadOnly  = .T.
            IF THIS.this_cTipo = "E"
                loc_pg3.cnt_4c_RPA.obj_4c_Opt_RPA.Enabled      = .F.
                loc_pg3.cnt_4c_RPA.txt_4c__MaxRetInss.ReadOnly = .T.
                loc_pg3.cnt_4c_RPA.txt_4c_CodRecPis.ReadOnly   = .T.
                loc_pg3.cnt_4c_RPA.txt_4c_CodRecCof.ReadOnly   = .T.
                loc_pg3.cnt_4c_RPA.txt_4c_CodRecCsll.ReadOnly  = .T.
                loc_pg3.cnt_4c_RPA.txt_4c_CodRecIrrf.ReadOnly  = .T.
            ENDIF
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    *==========================================================================
    *-- METODOS AUXILIARES
    *==========================================================================

    PROTECTED PROCEDURE ConfigurarBindings()
        LOCAL loc_pg1, loc_pg2
        TRY
            loc_pg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_pg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

            *-- LostFocus: CodOcorrencia fields
            BINDEVENT(loc_pg1.txt_4c__CodOcorPis,    "KeyPress", THIS, "ValidarCodOcorPis")
            BINDEVENT(loc_pg1.txt_4c__CodOcorCofins, "KeyPress", THIS, "ValidarCodOcorCofins")
            BINDEVENT(loc_pg1.txt_4c__CodOcorIrrf,   "KeyPress", THIS, "ValidarCodOcorIrrf")
            BINDEVENT(loc_pg1.txt_4c__CodOcorInss,   "KeyPress", THIS, "ValidarCodOcorInss")
            BINDEVENT(loc_pg1.txt_4c__CodOcorCsll,   "KeyPress", THIS, "ValidarCodOcorCsll")
            BINDEVENT(loc_pg1.txt_4c__CodOcoriSS,    "KeyPress", THIS, "ValidarCodOcoriSS")

            *-- LostFocus: Conta contabil principal
            BINDEVENT(loc_pg1.txt_4c_Grupo,  "KeyPress", THIS, "ValidarGrupoImpostos")
            BINDEVENT(loc_pg1.txt_4c_Contao, "KeyPress", THIS, "ValidarContaImpostos")

            *-- LostFocus: Contas por imposto (Vencimentos)
            BINDEVENT(loc_pg2.txt_4c__grupopis,     "KeyPress", THIS, "ValidarGrupoPis")
            BINDEVENT(loc_pg2.txt_4c__contapis,     "KeyPress", THIS, "ValidarContaPis")
            BINDEVENT(loc_pg2.txt_4c__grupocofins,  "KeyPress", THIS, "ValidarGrupoCofins")
            BINDEVENT(loc_pg2.txt_4c__contacofins,  "KeyPress", THIS, "ValidarContaCofins")
            BINDEVENT(loc_pg2.txt_4c__grupoirrf,    "KeyPress", THIS, "ValidarGrupoIrrf")
            BINDEVENT(loc_pg2.txt_4c__contairrf,    "KeyPress", THIS, "ValidarContaIrrf")
            BINDEVENT(loc_pg2.txt_4c__grupoinss,    "KeyPress", THIS, "ValidarGrupoInss")
            BINDEVENT(loc_pg2.txt_4c__containss,    "KeyPress", THIS, "ValidarContaInss")
            BINDEVENT(loc_pg2.txt_4c__grupocsll,    "KeyPress", THIS, "ValidarGrupoCsll")
            BINDEVENT(loc_pg2.txt_4c__contacsll,    "KeyPress", THIS, "ValidarContaCsll")
            BINDEVENT(loc_pg2.txt_4c__grupoiss,     "KeyPress", THIS, "ValidarGrupoIss")
            BINDEVENT(loc_pg2.txt_4c__contaiss,     "KeyPress", THIS, "ValidarContaIss")
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE CarregarOcorrencias()
        LOCAL loc_cSQL, loc_nRet
        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigOpOco ORDER BY Codigos"
            IF USED("cursor_4c_Ocorrencias")
                USE IN cursor_4c_Ocorrencias
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OcorTemp")
            IF loc_nRet > 0
                SELECT * FROM cursor_4c_OcorTemp INTO CURSOR cursor_4c_Ocorrencias READWRITE
                USE IN cursor_4c_OcorTemp
                SELECT cursor_4c_Ocorrencias
                INDEX ON ALLTRIM(Codigos) TAG Codigos
            ENDIF
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE SalvarProdutos(par_cCodServs)
        LOCAL loc_cSQL, loc_lResultado
        loc_lResultado = .F.
        TRY
            *-- Remove produtos existentes
            loc_cSQL = "DELETE FROM SigSeRvp WHERE CodServs = " + EscaparSQL(par_cCodServs)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Reinsere produtos do cursor
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                GO TOP
                DO WHILE !EOF("cursor_4c_Produtos")
                    IF !DELETED("cursor_4c_Produtos") AND !EMPTY(ALLTRIM(cursor_4c_Produtos.cPros))
                        loc_cSQL = "INSERT INTO SigSeRvp (CodServs, cPros, cIdChaves) VALUES (" + ;
                                   EscaparSQL(par_cCodServs) + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Produtos.cPros)) + ", " + ;
                                   EscaparSQL(SYS(2015)) + ")"
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    SKIP IN cursor_4c_Produtos
                ENDDO
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROTECTED PROCEDURE ValidarCampoOcorrencia(par_oControl)
        LOCAL loc_cValor, loc_oBusca
        TRY
            loc_cValor = ALLTRIM(par_oControl.Value)
            IF EMPTY(loc_cValor)
                RETURN
            ENDIF
            IF NOT USED("cursor_4c_Ocorrencias")
                THIS.CarregarOcorrencias()
            ENDIF
            IF USED("cursor_4c_Ocorrencias")
                IF NOT SEEK(loc_cValor, "cursor_4c_Ocorrencias", "Codigos")
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", "cursor_4c_Ocorrencias", "Codigos")
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou
                        SELECT cursor_4c_Ocorrencias
                        par_oControl.Value = ALLTRIM(cursor_4c_Ocorrencias.Codigos)
                    ELSE
                        par_oControl.Value = ""
                    ENDIF
                    loc_oBusca.Release()
                    loc_oBusca = .NULL.
                ELSE
                    par_oControl.Value = ALLTRIM(cursor_4c_Ocorrencias.Codigos)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE BuscarDescricaoConta(par_oConta, par_oDconta)
        LOCAL loc_cValor, loc_cSQL, loc_nRet
        TRY
            loc_cValor = ALLTRIM(par_oConta.Value)
            IF EMPTY(loc_cValor)
                par_oDconta.Value = ""
                RETURN
            ENDIF
            loc_cSQL = "SELECT rClis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cValor)
            IF USED("cursor_4c_CliTemp")
                USE IN cursor_4c_CliTemp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliTemp")
            IF loc_nRet > 0 AND USED("cursor_4c_CliTemp") AND !EOF("cursor_4c_CliTemp")
                par_oDconta.Value = ALLTRIM(NVL(cursor_4c_CliTemp.rClis, ""))
            ELSE
                par_oDconta.Value = ""
            ENDIF
            IF USED("cursor_4c_CliTemp")
                USE IN cursor_4c_CliTemp
            ENDIF
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Limpeza ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        TRY
            IF !ISNULL(THIS.this_oBusinessObject)
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
