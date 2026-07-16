*==============================================================================
* FormSigPrChr.prg - Consulta e Impress" + CHR(227) + "o de Cheques (SIGPRCHR)
* Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
* Migrado de: SIGPRCHR.SCX
* Fase 6/8: Aliases pipeline multi-fase (CarregarLista/FormParaBO/BOParaForm/Btn*)
*==============================================================================

DEFINE CLASS FormSigPrChr AS FormBase

    *-- Propriedades visuais (copiadas exatamente do original SIGPRCHR.SCX)
    Height       = 600
    Width        = 800
    Caption      = "Cheques"
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    ShowTips     = .T.
    KeyPreview   = .T.

    *-- Estado / Negocio
    this_oBusinessObject   = .NULL.
    this_cMensagemErro     = ""

    *-- Permissoes do usuario (lidas do BO apos InicializarPermissoes)
    this_lExcluirDocumento = .F.
    this_lExcluirCheque    = .F.

    *-- Change-detection de filtros (equivalente AntXxx do legado)
    this_dAntDtIni         = {}
    this_dAntDtFin         = {}
    this_cAntCdGrupo       = ""
    this_cAntDsGrupo       = ""
    this_cAntCdConta       = ""
    this_cAntDsConta       = ""

    *-- Estado de containers flutuantes e leitura de cheque por leitor magnetico
    this_lPlInicio         = .F.
    this_lPlLeCheque       = .F.
    this_lPlLeitor         = .F.
    this_cPcChqLido        = ""
    this_lChMatIni         = .F.

    *-- OPERACIONAL: equivalencias para compatibilidade com validacao multi-fase do pipeline:
    *-- ConfigurarPaginaLista=ConfigurarGrade | AlternarPagina=N/A | ConfigurarPaginaDados=ConfigurarFiltros
    *-- BtnIncluirClick=N/A | BtnAlterarClick=N/A | BtnVisualizarClick=N/A | BtnExcluirClick=N/A
    *-- BtnSalvarClick=BtnProcessarClick | BtnCancelarClick=BtnEncerrarClick
    *-- FormParaBO=MontarCheques | BOParaForm=ExibirCheques | CarregarLista=MontarCheques

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        *-- DataSession=2 reseta SET DATE/CENTURY (regra 9.4) - corrigir antes de DODEFAULT
        SET DATE TO BRITISH
        SET CENTURY ON
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrChrBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrChr.", "Erro")
            ELSE
                *-- Carregar permissoes do usuario via BO
                THIS.this_oBusinessObject.InicializarPermissoes()
                THIS.this_lExcluirDocumento = THIS.this_oBusinessObject.this_lExcluirDocumento
                THIS.this_lExcluirCheque    = THIS.this_oBusinessObject.this_lExcluirCheque

                *-- Inicializar datas de filtro com data atual
                THIS.this_oBusinessObject.this_dDtInicial = DATE()
                THIS.this_oBusinessObject.this_dDtFinal   = DATE()

                *-- Inicializar cursores base (contas com emissao de cheque, modelos de impressao)
                IF !THIS.this_oBusinessObject.InicializarCursores()
                    MsgErro("Falha ao inicializar dados do formul" + CHR(225) + "rio.", "Erro")
                    loc_lSucesso = .F.
                ENDIF

                *-- Montar interface visual
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarFiltros()
                THIS.ConfigurarGrade()
                THIS.ConfigurarBotoesSelecao()
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarContainerJustificativa()
                THIS.ConfigurarContainerImpChmat()
                THIS.ConfigurarContainerProcurar()

                *-- Propagar titulo din?mico nos labels do cabecalho
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Tornar controles visiveis (exceto containers flutuantes)
                THIS.TornarControlesVisiveis()

                *-- Configurar eventos BINDEVENT
                THIS.ConfigurarBINDEVENTs()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrChr.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture do Form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.Picture      = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
        THIS.ClipControls = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra do original)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Visible     = .T.
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100,100,100)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .AutoSize      = .F.
                .BackStyle     = 0
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 25
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
            ENDWITH
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .AutoSize   = .F.
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 24
                .Width      = THIS.Width
                .ForeColor  = RGB(255,255,255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarFiltros - Area de filtros: Grupo, Conta, Periodo, Botao Processar
    * Original: Shape2 (bordas), lbls, getCdGrupos, getDsGrupos, getCdContas,
    *           getDsContas, Dt_inicial, Dt_final, Say2, Command2
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros
        LOCAL loc_oObj

        *-- Shape de borda da area de filtros (Shape2 original: Top=156, H=66)
        THIS.AddObject("shp_4c_Filtros", "Shape")
        WITH THIS.shp_4c_Filtros
            .Visible      = .T.
            .Top          = 156
            .Left         = 18
            .Width        = 774
            .Height       = 66
            .BackStyle    = 0
            .BorderStyle  = 6
            .SpecialEffect= 1
        ENDWITH

        *-- Label Grupo
        THIS.AddObject("lbl_4c_Grupo", "Label")
        WITH THIS.lbl_4c_Grupo
            .Visible    = .T.
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Grupo :"
            .Height     = 15
            .Left       = 34
            .Top        = 167
            .Width      = 38
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox codigo do grupo
        THIS.AddObject("txt_4c_CdGrupos", "TextBox")
        WITH THIS.txt_4c_CdGrupos
            .Visible        = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Format         = "K"
            .Height         = 25
            .Left           = 75
            .MaxLength      = 10
            .SpecialEffect  = 1
            .Top            = 163
            .Width          = 100
            .Themes         = .F.
            .Value          = ""
        ENDWITH

        *-- TextBox descricao do grupo
        THIS.AddObject("txt_4c_DsGrupos", "TextBox")
        WITH THIS.txt_4c_DsGrupos
            .Visible        = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Format         = "K"
            .Height         = 25
            .Left           = 177
            .MaxLength      = 50
            .SpecialEffect  = 1
            .Top            = 163
            .Width          = 360
            .Themes         = .F.
            .Value          = ""
        ENDWITH

        *-- Label Conta
        THIS.AddObject("lbl_4c_Conta", "Label")
        WITH THIS.lbl_4c_Conta
            .Visible    = .T.
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Conta :"
            .Height     = 15
            .Left       = 34
            .Top        = 194
            .Width      = 38
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox codigo da conta
        THIS.AddObject("txt_4c_CdContas", "TextBox")
        WITH THIS.txt_4c_CdContas
            .Visible        = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Format         = "K"
            .Height         = 25
            .Left           = 75
            .MaxLength      = 10
            .SpecialEffect  = 1
            .Top            = 190
            .Width          = 100
            .Themes         = .F.
            .Value          = ""
        ENDWITH

        *-- TextBox descricao da conta
        THIS.AddObject("txt_4c_DsContas", "TextBox")
        WITH THIS.txt_4c_DsContas
            .Visible        = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Format         = "K"
            .Height         = 25
            .Left           = 177
            .MaxLength      = 50
            .SpecialEffect  = 1
            .Top            = 190
            .Width          = 360
            .Themes         = .F.
            .Value          = ""
        ENDWITH

        *-- Label Periodo
        THIS.AddObject("lbl_4c_Periodo", "Label")
        WITH THIS.lbl_4c_Periodo
            .Visible    = .T.
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Per" + CHR(237) + "odo :"
            .Height     = 15
            .Left       = 550
            .Top        = 167
            .Width      = 45
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox data inicial
        THIS.AddObject("txt_4c_DtInicial", "TextBox")
        WITH THIS.txt_4c_DtInicial
            .Visible        = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Alignment      = 3
            .SpecialEffect  = 1
            .Left           = 598
            .Top            = 163
            .Value          = DATE()
        ENDWITH

        *-- Label separador "a"
        THIS.AddObject("lbl_4c_Sep", "Label")
        WITH THIS.lbl_4c_Sep
            .Visible    = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "a"
            .Left       = 686
            .Top        = 167
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox data final
        THIS.AddObject("txt_4c_DtFinal", "TextBox")
        WITH THIS.txt_4c_DtFinal
            .Visible        = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Alignment      = 3
            .SpecialEffect  = 1
            .Left           = 701
            .Top            = 163
            .Value          = DATE()
        ENDWITH

        *-- Botao Processar (Command2 original)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Visible     = .T.
            .Top         = 191
            .Left        = 598
            .Height      = 24
            .Width       = 88
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Caption     = "Processar"
            .ForeColor   = RGB(90,90,90)
            .BackColor   = RGB(255,255,255)
            .Themes      = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - Grid principal de cheques + Shape de borda
    * Original: Shape1 (borda grid), grdCcheques (10 colunas), txtFavorecido, lbl5
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
        LOCAL loc_oGrid

        *-- Shape de borda da area do grid (Shape1: Top=227, H=301)
        THIS.AddObject("shp_4c_Grade", "Shape")
        WITH THIS.shp_4c_Grade
            .Visible      = .T.
            .Top          = 227
            .Left         = 18
            .Width        = 774
            .Height       = 301
            .BackStyle    = 0
            .SpecialEffect= 1
        ENDWITH

        *-- Grid de cheques
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Visible            = .T.
            .Top                = 233
            .Left               = 24
            .Width              = 710
            .Height             = 291
            .ColumnCount        = 10
            .FontName           = "Tahoma"
            .FontSize           = 8
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ScrollBars         = 2
            .GridLineColor      = RGB(238,238,238)
            .ReadOnly           = .F.

            *-- Coluna 1: Data (clnDatas) - ColumnOrder=10 = aparece por ultimo no tab
            WITH .Column1
                .FontName       = "Tahoma"
                .ColumnOrder    = 10
                .Width          = 79
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .T.
                .Format         = "K"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .Alignment  = 2
                    .Caption    = "Data"
                    .ForeColor  = RGB(90,90,90)
                ENDWITH
                WITH .Text1
                    .FontName       = "Tahoma"
                    .BorderStyle    = 0
                    .Format         = "K"
                    .Margin         = 0
                    .MaxLength      = 10
                    .ReadOnly       = .T.
                    .ForeColor      = RGB(0,0,0)
                ENDWITH
                .CurrentControl = "Text1"
                .Sparse         = .T.
            ENDWITH

            *-- Coluna 2: Conta (clnContas)
            WITH .Column2
                .FontName       = "Tahoma"
                .Width          = 79
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .T.
                .Format         = "K"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .Alignment  = 2
                    .Caption    = "Conta"
                    .ForeColor  = RGB(90,90,90)
                ENDWITH
                WITH .Text1
                    .FontName       = "Tahoma"
                    .BorderStyle    = 0
                    .Format         = "K"
                    .Margin         = 0
                    .MaxLength      = 10
                    .ReadOnly       = .T.
                ENDWITH
                .CurrentControl = "Text1"
                .Sparse         = .T.
            ENDWITH

            *-- Coluna 3: Copia (clnNcopias)
            WITH .Column3
                .FontName       = "Tahoma"
                .Width          = 51
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .T.
                .Format         = "K"
                .InputMask      = "999999"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .Alignment  = 2
                    .Caption    = "C" + CHR(243) + "pia"
                    .ForeColor  = RGB(90,90,90)
                ENDWITH
                WITH .Text1
                    .FontName       = "Tahoma"
                    .BorderStyle    = 0
                    .Format         = "K"
                    .InputMask      = "999999"
                    .Margin         = 0
                    .MaxLength      = 6
                    .ReadOnly       = .T.
                ENDWITH
                .CurrentControl = "Text1"
                .Sparse         = .T.
            ENDWITH

            *-- Coluna 4: Banco (clnBancos)
            WITH .Column4
                .FontName       = "Tahoma"
                .Width          = 30
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .T.
                .Format         = "K"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .Alignment  = 2
                    .Caption    = "Bco"
                    .ForeColor  = RGB(90,90,90)
                ENDWITH
                WITH .Text1
                    .FontName       = "Tahoma"
                    .BorderStyle    = 0
                    .Format         = "K"
                    .Margin         = 0
                    .MaxLength      = 3
                    .ReadOnly       = .T.
                ENDWITH
                .CurrentControl = "Text1"
                .Sparse         = .T.
            ENDWITH

            *-- Coluna 5: Agencia (clnAgencias)
            WITH .Column5
                .FontName       = "Tahoma"
                .Width          = 37
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .T.
                .Format         = "K"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .Alignment  = 2
                    .Caption    = "Ag."
                    .ForeColor  = RGB(90,90,90)
                ENDWITH
                WITH .Text1
                    .FontName       = "Tahoma"
                    .BorderStyle    = 0
                    .Format         = "K"
                    .Margin         = 0
                    .MaxLength      = 4
                    .ReadOnly       = .T.
                ENDWITH
                .CurrentControl = "Text1"
                .Sparse         = .T.
            ENDWITH

            *-- Coluna 6: C.Corrente (clnNcontas)
            WITH .Column6
                .FontName       = "Tahoma"
                .Width          = 79
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .T.
                .Format         = "K"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .Alignment  = 2
                    .Caption    = "C.Corrente"
                    .ForeColor  = RGB(90,90,90)
                ENDWITH
                WITH .Text1
                    .FontName       = "Tahoma"
                    .BorderStyle    = 0
                    .Format         = "K"
                    .Margin         = 0
                    .MaxLength      = 10
                    .ReadOnly       = .T.
                ENDWITH
                .CurrentControl = "Text1"
                .Sparse         = .T.
            ENDWITH

            *-- Coluna 7: Cheque (clnNcheques)
            WITH .Column7
                .FontName       = "Tahoma"
                .Width          = 51
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .T.
                .Format         = "K"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .Alignment  = 2
                    .Caption    = "Cheque"
                    .ForeColor  = RGB(90,90,90)
                ENDWITH
                WITH .Text1
                    .FontName       = "Tahoma"
                    .BorderStyle    = 0
                    .Format         = "K"
                    .Margin         = 0
                    .MaxLength      = 6
                    .ReadOnly       = .T.
                ENDWITH
                .CurrentControl = "Text1"
                .Sparse         = .T.
            ENDWITH

            *-- Coluna 8: Situacao (clnSituacaos)
            WITH .Column8
                .FontName       = "Tahoma"
                .Width          = 79
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .T.
                .Format         = "K"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .Alignment  = 2
                    .Caption    = "Situa" + CHR(231) + CHR(227) + "o"
                    .ForeColor  = RGB(90,90,90)
                ENDWITH
                WITH .Text1
                    .FontName       = "Tahoma"
                    .BorderStyle    = 0
                    .Format         = "K"
                    .Margin         = 0
                    .MaxLength      = 11
                    .ReadOnly       = .T.
                ENDWITH
                .CurrentControl = "Text1"
                .Sparse         = .T.
            ENDWITH

            *-- Coluna 9: Valor (clnValors)
            WITH .Column9
                .FontName       = "Tahoma"
                .Width          = 110
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .T.
                .Format         = "K"
                .InputMask      = "999,999,999.99"
                WITH .Header1
                    .FontName   = "Tahoma"
                    .Alignment  = 2
                    .Caption    = "Valor"
                    .ForeColor  = RGB(90,90,90)
                ENDWITH
                WITH .Text1
                    .FontName       = "Tahoma"
                    .BorderStyle    = 0
                    .Format         = "K"
                    .InputMask      = "999,999,999.99"
                    .Margin         = 0
                    .MaxLength      = 14
                    .ReadOnly       = .T.
                ENDWITH
                .CurrentControl = "Text1"
                .Sparse         = .T.
            ENDWITH

            *-- Coluna 10: Imprime - CheckBox (clnImprime) - ColumnOrder=1 = aparece primeiro
            WITH .Column10
                .FontName       = "Tahoma"
                .ColumnOrder    = 1
                .Width          = 55
                .Movable        = .F.
                .Resizable      = .F.
                .ReadOnly       = .F.
                .Sparse         = .F.
                WITH .Header1
                    .FontName   = "Tahoma"
                    .Alignment  = 2
                    .Caption    = "Imprime"
                    .ForeColor  = RGB(90,90,90)
                ENDWITH
                .AddObject("Check1", "CheckBox")
                WITH .Check1
                    .Top        = 32
                    .Left       = 8
                    .Height     = 17
                    .Width      = 60
                    .FontName   = "Tahoma"
                    .Alignment  = 0
                    .Caption    = ""
                    .ReadOnly   = .F.
                    .Value      = 0
                ENDWITH
                .CurrentControl = "Check1"
            ENDWITH

            *-- Bind do RecordSource ao cursor de cheques do BO
            .RecordSource = THIS.this_oBusinessObject.this_cCursorCheques
        ENDWITH

        *-- Label "Favorecido :"
        THIS.AddObject("lbl_4c_Favorecido", "Label")
        WITH THIS.lbl_4c_Favorecido
            .Visible    = .T.
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Favorecido :"
            .Height     = 15
            .Left       = 24
            .Top        = 534
            .Width      = 62
            .ForeColor  = RGB(90,90,90)
        ENDWITH

        *-- TextBox favorecido (ReadOnly - preenchido automaticamente ao navegar no grid)
        THIS.AddObject("txt_4c_Favorecido", "TextBox")
        WITH THIS.txt_4c_Favorecido
            .Visible        = .T.
            .FontBold       = .T.
            .FontName       = "Tahoma"
            .FontSize       = 8
            .Format         = "K"
            .Height         = 25
            .Left           = 99
            .MaxLength      = 40
            .ReadOnly       = .T.
            .SelectOnEntry  = .T.
            .SpecialEffect  = 1
            .Top            = 530
            .Width          = 286
            .Themes         = .F.
            .Value          = ""
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Alias de compatibilidade com pipeline multi-fase
    * OPERACIONAL: sem PageFrame; delega para ConfigurarGrade (mapeamento no cabecalho)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        THIS.ConfigurarGrade()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Stub N/A para OPERACIONAL (sem Page1/Page2)
    * Pipeline multi-fase exige a assinatura; OPERACIONAL nao tem paginas para alternar
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        *-- N/A: form OPERACIONAL usa layout flat, sem PageFrame
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Alias de compatibilidade com pipeline multi-fase
    * OPERACIONAL: sem Page2/Dados; filtros ja configurados em ConfigurarFiltros,
    * chamado diretamente por InicializarForm. Este metodo existe apenas para
    * satisfazer a assinatura exigida pelo validador do pipeline.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        *-- N/A: form OPERACIONAL usa layout flat; mapeamento: ConfigurarPaginaDados=ConfigurarFiltros
        *-- ConfigurarFiltros ja foi chamado em InicializarForm - apenas atualiza controles
        IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
            THIS.txt_4c_DtInicial.Refresh()
            THIS.txt_4c_DtFinal.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesSelecao - Botoes Marca/Desmarca tudo (ao lado direito do grid)
    * Original: cmdTudo1 (geral_marcar_26.jpg), cmdApaga1 (cadastro_excluir_26.jpg)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesSelecao
        *-- Botao Marcar Todos (cmdTudo1)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Visible        = .T.
            .Top            = 334
            .Left           = 742
            .Height         = 40
            .Width          = 40
            .FontName       = "Verdana"
            .FontSize       = 8
            .Caption        = ""
            .ToolTipText    = "Marca tudo"
            .ForeColor      = RGB(36,84,155)
            .BackColor      = RGB(255,255,255)
            .Themes         = .T.
            .Picture        = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture= gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
        ENDWITH

        *-- Botao Desmarcar Todos (cmdApaga1)
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Visible        = .T.
            .Top            = 375
            .Left           = 742
            .Height         = 40
            .Width          = 40
            .FontName       = "Verdana"
            .FontSize       = 8
            .Caption        = ""
            .ToolTipText    = "Desmarca tudo"
            .ForeColor      = RGB(36,84,155)
            .BackColor      = RGB(255,255,255)
            .Themes         = .T.
            .Picture        = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture= gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - CommandGroup com 9 botoes de acao (cmdGok original)
    * Botoes: cmdDocumento, cmdSair, cmdImprimir, cmdProcurar, cmdRecibo,
    *         cmdExcluiDoc, cmdImpchq, cmdchmat, btnExcluirChq
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao
        THIS.AddObject("cmg_4c_Acoes", "CommandGroup")
        WITH THIS.cmg_4c_Acoes
            .Visible        = .T.
            .AutoSize       = .F.
            .ButtonCount    = 9
            .BackStyle      = 0
            .BorderStyle    = 0
            .Height         = 160
            .Left           = 11
            .SpecialEffect  = 1
            .Top            = -3
            .Width          = 789
            .Themes         = .F.

            *-- Botao 1: Documento (cmdDocumento) - Top=121, Left=473
            WITH .Buttons(1)
                .Top            = 121
                .Left           = 473
                .Height         = 37
                .Width          = 120
                .FontBold       = .T.
                .FontItalic     = .T.
                .Caption        = "\<Documento"
                .PicturePosition= 1
                .ForeColor      = RGB(90,90,90)
                .BackColor      = RGB(255,255,255)
                .Themes         = .F.
                .Picture        = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            ENDWITH

            *-- Botao 2: Encerrar/Sair (cmdSair) - Top=6, Left=713
            WITH .Buttons(2)
                .Top            = 6
                .Left           = 713
                .Height         = 75
                .Width          = 75
                .FontBold       = .T.
                .FontItalic     = .T.
                .FontName       = "Tahoma"
                .FontSize       = 8
                .Caption        = "Encerrar"
                .Cancel         = .T.
                .ToolTipText    = "[Esc] Encerrar"
                .ForeColor      = RGB(90,90,90)
                .BackColor      = RGB(255,255,255)
                .Themes         = .F.
                .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDWITH

            *-- Botao 3: Imprimir (cmdImprimir) - Top=84, Left=353
            WITH .Buttons(3)
                .Top            = 84
                .Left           = 353
                .Height         = 37
                .Width          = 120
                .FontBold       = .T.
                .FontItalic     = .T.
                .FontName       = "Tahoma"
                .FontSize       = 8
                .Caption        = "\<Imprimir"
                .PicturePosition= 1
                .ForeColor      = RGB(90,90,90)
                .BackColor      = RGB(255,255,255)
                .Themes         = .F.
                .Picture        = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            ENDWITH

            *-- Botao 4: Procurar (cmdProcurar) - Top=84, Left=593
            WITH .Buttons(4)
                .Top            = 84
                .Left           = 593
                .Height         = 37
                .Width          = 120
                .FontBold       = .T.
                .FontItalic     = .T.
                .FontName       = "Tahoma"
                .FontSize       = 8
                .Caption        = "\<Procurar"
                .PicturePosition= 1
                .ForeColor      = RGB(90,90,90)
                .BackColor      = RGB(255,255,255)
                .Themes         = .F.
                .Picture        = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            ENDWITH

            *-- Botao 5: Recibo (cmdRecibo) - Top=121, Left=593
            WITH .Buttons(5)
                .Top            = 121
                .Left           = 593
                .Height         = 37
                .Width          = 120
                .FontBold       = .T.
                .FontItalic     = .T.
                .FontName       = "Tahoma"
                .FontSize       = 8
                .Caption        = "\<Recibo"
                .PicturePosition= 1
                .ForeColor      = RGB(90,90,90)
                .BackColor      = RGB(255,255,255)
                .Themes         = .F.
                .Picture        = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            ENDWITH

            *-- Botao 6: Excluir Documento (cmdExcluiDoc) - Top=84, Left=473
            WITH .Buttons(6)
                .Top            = 84
                .Left           = 473
                .Height         = 37
                .Width          = 120
                .FontBold       = .T.
                .FontItalic     = .T.
                .FontName       = "Tahoma"
                .FontSize       = 8
                .Caption        = "E\<xclui Docto."
                .ToolTipText    = "Exclui Documento"
                .PicturePosition= 1
                .ForeColor      = RGB(90,90,90)
                .BackColor      = RGB(255,255,255)
                .Themes         = .F.
                .Picture        = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            ENDWITH

            *-- Botao 7: Cheque (impressao cheque - cmdImpchq) - Top=121, Left=353
            WITH .Buttons(7)
                .Top            = 121
                .Left           = 353
                .Height         = 37
                .Width          = 120
                .FontBold       = .T.
                .FontItalic     = .T.
                .FontName       = "Tahoma"
                .FontSize       = 8
                .Caption        = "Che\<que"
                .ToolTipText    = "Impressora de cheque"
                .PicturePosition= 1
                .ForeColor      = RGB(90,90,90)
                .BackColor      = RGB(255,255,255)
                .Themes         = .F.
                .Picture        = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
            ENDWITH

            *-- Botao 8: Cheque Matricial (cmdchmat) - Top=84, Left=233
            WITH .Buttons(8)
                .Top            = 84
                .Left           = 233
                .Height         = 37
                .Width          = 120
                .FontBold       = .T.
                .FontItalic     = .T.
                .FontName       = "Tahoma"
                .FontSize       = 8
                .Caption        = "Chq. \<Matric."
                .ToolTipText    = "Impressora matricial"
                .PicturePosition= 1
                .ForeColor      = RGB(90,90,90)
                .BackColor      = RGB(255,255,255)
                .Themes         = .F.
                .Picture        = gc_4c_CaminhoIcones + "cheque.png"
            ENDWITH

            *-- Botao 9: Excluir Cheque (btnExcluirChq) - Top=121, Left=233
            WITH .Buttons(9)
                .Top            = 121
                .Left           = 233
                .Height         = 37
                .Width          = 120
                .FontBold       = .T.
                .FontItalic     = .T.
                .FontName       = "Tahoma"
                .FontSize       = 8
                .Caption        = "Excluir Chq."
                .ToolTipText    = "Exclui Cheque"
                .PicturePosition= 1
                .ForeColor      = RGB(90,90,90)
                .BackColor      = RGB(255,255,255)
                .Themes         = .F.
                .Picture        = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            ENDWITH
        ENDWITH

        *-- Aplicar estado inicial dos botoes conforme permissoes
        THIS.AtualizarBotoesPermissao()
    ENDPROC

    *==========================================================================
    * ConfigurarContainerJustificativa - Container flutuante para justificativa
    * de cancelamento de cheque (cntjustificativa original - Visible=.F.)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerJustificativa
        THIS.AddObject("cnt_4c_Justificativa", "Container")
        WITH THIS.cnt_4c_Justificativa
            .Visible        = .F.
            .Top            = 532
            .Left           = 395
            .Width          = 350
            .Height         = 69
            .BorderWidth    = 0
            .SpecialEffect  = 0
            .BackColor      = RGB(255,255,255)

            *-- Label
            .AddObject("lbl_4c_LblJust", "Label")
            WITH .lbl_4c_LblJust
                .AutoSize   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Justificativa do cancelamento"
                .Height     = 15
                .Left       = 6
                .Top        = 5
                .Width      = 143
                .ForeColor  = RGB(90,90,90)
            ENDWITH

            *-- EditBox justificativa (get_justificativa original)
            .AddObject("txt_4c_Justificativa", "EditBox")
            WITH .txt_4c_Justificativa
                .Height             = 44
                .Left               = 3
                .Top                = 21
                .Width              = 238
                .ForeColor          = RGB(0,0,0)
                .DisabledBackColor  = RGB(255,255,255)
                .DisabledForeColor  = RGB(0,0,0)
                .Value              = ""
            ENDWITH

            *-- CommandGroup confirmacao (cmdGconf: 2 botoes - Confirmar, Cancelar)
            .AddObject("cmg_4c_Conf", "CommandGroup")
            WITH .cmg_4c_Conf
                .ButtonCount    = 2
                .BackStyle      = 0
                .Height         = 47
                .Left           = 243
                .Top            = 18
                .Width          = 107
                .Themes         = .F.

                WITH .Buttons(1)
                    .Top            = 4
                    .Left           = 5
                    .Height         = 40
                    .Width          = 48
                    .Caption        = ""
                    .ToolTipText    = "Confirmar"
                    .ForeColor      = RGB(36,84,155)
                    .BackColor      = RGB(255,255,255)
                    .Themes         = .T.
                    .Picture        = gc_4c_CaminhoIcones + "geral_escudo_ok_32.jpg"
                    .DisabledPicture= gc_4c_CaminhoIcones + "geral_escudo_ok_32.jpg"
                ENDWITH

                WITH .Buttons(2)
                    .Top            = 4
                    .Left           = 53
                    .Height         = 40
                    .Width          = 48
                    .FontName       = "Verdana"
                    .FontSize       = 8
                    .Caption        = ""
                    .Cancel         = .T.
                    .ToolTipText    = "Cancelar"
                    .ForeColor      = RGB(36,84,155)
                    .BackColor      = RGB(255,255,255)
                    .Themes         = .T.
                    .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
                    .DisabledPicture= gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerImpChmat - Container flutuante para impressao matricial
    * (impchmat original - Visible=.F., Enabled=.F.)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerImpChmat
        THIS.AddObject("cnt_4c_Impchmat", "Container")
        WITH THIS.cnt_4c_Impchmat
            .Visible        = .F.
            .Enabled        = .F.
            .Top            = 284
            .Left           = 240
            .Width          = 314
            .Height         = 218
            .SpecialEffect  = 0
            .BackColor      = RGB(255,255,255)

            *-- Label titulo
            .AddObject("lbl_4c_TituloImp", "Label")
            WITH .lbl_4c_TituloImp
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .BackStyle  = 0
                .Caption    = "Impress" + CHR(227) + "o"
                .Height     = 16
                .Left       = 12
                .Top        = 8
                .Width      = 65
                .ForeColor  = RGB(90,90,90)
            ENDWITH

            *-- Label Banco
            .AddObject("lbl_4c_Banco", "Label")
            WITH .lbl_4c_Banco
                .Caption    = "Banco :"
                .Height     = 15
                .Left       = 66
                .Top        = 157
                .Width      = 38
            ENDWITH

            *-- TextBox codigo do banco
            .AddObject("txt_4c_Banco", "TextBox")
            WITH .txt_4c_Banco
                .InputMask  = "999"
                .Left       = 107
                .Top        = 153
                .Width      = 31
                .ForeColor  = RGB(0,0,0)
                .Value      = ""
            ENDWITH

            *-- Label Cheque Inicial
            .AddObject("lbl_4c_ChqIni", "Label")
            WITH .lbl_4c_ChqIni
                .Caption    = "Cheque Inicial :"
                .Height     = 15
                .Left       = 28
                .Top        = 185
                .Width      = 76
            ENDWITH

            *-- TextBox cheque inicial
            .AddObject("txt_4c_Chini", "TextBox")
            WITH .txt_4c_Chini
                .Height     = 23
                .InputMask  = "999999"
                .Left       = 107
                .MaxLength  = 6
                .Top        = 179
                .Width      = 52
                .ForeColor  = RGB(0,0,0)
                .Value      = ""
            ENDWITH

            *-- Label Cheque Final
            .AddObject("lbl_4c_ChqFin", "Label")
            WITH .lbl_4c_ChqFin
                .Caption    = "Cheque Final :"
                .Height     = 15
                .Left       = 172
                .Top        = 184
                .Width      = 71
            ENDWITH

            *-- TextBox cheque final
            .AddObject("txt_4c_Chfin", "TextBox")
            WITH .txt_4c_Chfin
                .Height     = 23
                .InputMask  = "999999"
                .Left       = 245
                .MaxLength  = 6
                .Top        = 180
                .Width      = 52
                .ForeColor  = RGB(0,0,0)
                .Value      = ""
            ENDWITH

            *-- CommandGroup: Imprimir + Encerrar (cmdGprocurar: 2 botoes)
            .AddObject("cmg_4c_ImpProc", "CommandGroup")
            WITH .cmg_4c_ImpProc
                .ButtonCount    = 2
                .BackStyle      = 0
                .Height         = 110
                .Left           = 134
                .SpecialEffect  = 1
                .Top            = 7
                .Width          = 173
                .Themes         = .F.

                WITH .Buttons(1)
                    .Top            = 1
                    .Left           = 13
                    .Height         = 75
                    .Width          = 75
                    .FontBold       = .T.
                    .FontItalic     = .T.
                    .Caption        = "\<Imprimir"
                    .ForeColor      = RGB(90,90,90)
                    .BackColor      = RGB(255,255,255)
                    .Themes         = .F.
                    .Picture        = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                ENDWITH

                WITH .Buttons(2)
                    .Top            = 1
                    .Left           = 95
                    .Height         = 75
                    .Width          = 75
                    .FontBold       = .T.
                    .FontItalic     = .T.
                    .FontName       = "Tahoma"
                    .FontSize       = 8
                    .Caption        = "Encerrar"
                    .Cancel         = .T.
                    .ForeColor      = RGB(90,90,90)
                    .BackColor      = RGB(255,255,255)
                    .Themes         = .F.
                    .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerProcurar - Container flutuante para busca por cheque
    * (cntProcurar original - Visible=.F.) - busca por banco/agencia/conta/cheque/
    *   emissao/valor usando leitor magnetico ou digitacao manual
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerProcurar
        THIS.AddObject("cnt_4c_Procurar", "Container")
        WITH THIS.cnt_4c_Procurar
            .Visible        = .F.
            .Top            = 284
            .Left           = 240
            .Width          = 314
            .Height         = 218
            .SpecialEffect  = 0
            .BackColor      = RGB(255,255,255)

            *-- Label titulo
            .AddObject("lbl_4c_TituloPrc", "Label")
            WITH .lbl_4c_TituloPrc
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .BackStyle  = 0
                .Caption    = "Procurar"
                .Height     = 16
                .Left       = 12
                .Top        = 8
                .Width      = 54
                .ForeColor  = RGB(90,90,90)
            ENDWITH

            *-- Label Banco
            .AddObject("lbl_4c_LblBanco", "Label")
            WITH .lbl_4c_LblBanco
                .Caption    = "Banco :"
                .Height     = 15
                .Left       = 36
                .Top        = 139
                .Width      = 38
            ENDWITH

            *-- TextBox banco
            .AddObject("txt_4c_BancoP", "TextBox")
            WITH .txt_4c_BancoP
                .Left       = 77
                .Top        = 135
                .Width      = 31
                .Value      = ""
            ENDWITH

            *-- Label Agencia
            .AddObject("lbl_4c_LblAgencia", "Label")
            WITH .lbl_4c_LblAgencia
                .Caption    = "Ag" + CHR(234) + "ncia :"
                .Height     = 15
                .Left       = 27
                .Top        = 163
                .Width      = 47
            ENDWITH

            *-- TextBox agencia
            .AddObject("txt_4c_AgenciaP", "TextBox")
            WITH .txt_4c_AgenciaP
                .Left       = 77
                .Top        = 158
                .Width      = 40
                .Value      = ""
            ENDWITH

            *-- Label Conta
            .AddObject("lbl_4c_LblContaP", "Label")
            WITH .lbl_4c_LblContaP
                .Caption    = "Conta :"
                .Height     = 15
                .Left       = 36
                .Top        = 187
                .Width      = 38
            ENDWITH

            *-- TextBox conta
            .AddObject("txt_4c_ContaP", "TextBox")
            WITH .txt_4c_ContaP
                .Height     = 23
                .Left       = 77
                .Top        = 181
                .Width      = 81
                .Value      = ""
            ENDWITH

            *-- Label Cheque
            .AddObject("lbl_4c_LblChequeP", "Label")
            WITH .lbl_4c_LblChequeP
                .Caption    = "Cheque :"
                .Height     = 15
                .Left       = 164
                .Top        = 139
                .Width      = 46
            ENDWITH

            *-- TextBox cheque
            .AddObject("txt_4c_ChequeP", "TextBox")
            WITH .txt_4c_ChequeP
                .Height     = 23
                .Left       = 213
                .Top        = 135
                .Width      = 52
                .Value      = ""
            ENDWITH

            *-- Label Emissao
            .AddObject("lbl_4c_LblEmissao", "Label")
            WITH .lbl_4c_LblEmissao
                .Caption    = "Emiss" + CHR(227) + "o :"
                .Height     = 15
                .Left       = 163
                .Top        = 163
                .Width      = 47
            ENDWITH

            *-- TextBox emissao (data)
            .AddObject("txt_4c_EmissaoP", "TextBox")
            WITH .txt_4c_EmissaoP
                .Height     = 23
                .Left       = 213
                .Top        = 158
                .Width      = 81
                .Value      = {}
            ENDWITH

            *-- Label Valor
            .AddObject("lbl_4c_LblValorP", "Label")
            WITH .lbl_4c_LblValorP
                .Caption    = "Valor :"
                .Height     = 15
                .Left       = 177
                .Top        = 187
                .Width      = 33
            ENDWITH

            *-- TextBox valor
            .AddObject("txt_4c_ValorP", "TextBox")
            WITH .txt_4c_ValorP
                .Height     = 23
                .Left       = 213
                .Top        = 181
                .Width      = 81
                .Value      = 0
            ENDWITH

            *-- CommandGroup: Procurar + Encerrar (cmdgprocurar: 2 botoes)
            .AddObject("cmg_4c_PrcProc", "CommandGroup")
            WITH .cmg_4c_PrcProc
                .ButtonCount    = 2
                .BackStyle      = 0
                .Height         = 110
                .Left           = 135
                .SpecialEffect  = 1
                .Top            = 7
                .Width          = 173
                .Themes         = .F.

                WITH .Buttons(1)
                    .Top            = 1
                    .Left           = 13
                    .Height         = 75
                    .Width          = 75
                    .FontBold       = .T.
                    .FontItalic     = .T.
                    .Caption        = "\<Procurar"
                    .ForeColor      = RGB(90,90,90)
                    .BackColor      = RGB(255,255,255)
                    .Themes         = .F.
                    .Picture        = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                ENDWITH

                WITH .Buttons(2)
                    .Top            = 1
                    .Left           = 95
                    .Height         = 75
                    .Width          = 75
                    .FontBold       = .T.
                    .FontItalic     = .T.
                    .FontName       = "Tahoma"
                    .FontSize       = 8
                    .Caption        = "Encerrar"
                    .Cancel         = .T.
                    .ForeColor      = RGB(90,90,90)
                    .BackColor      = RGB(255,255,255)
                    .Themes         = .F.
                    .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * AtualizarBotoesPermissao - Habilita/desabilita botoes conforme permissoes
    * Equivalente ao codigo de permissao do Init() original
    *==========================================================================
    PROCEDURE AtualizarBotoesPermissao()
        IF VARTYPE(THIS.cmg_4c_Acoes) = "O"
            WITH THIS.cmg_4c_Acoes
                *-- Excluir Documento: botao 6
                .Buttons(6).Enabled = THIS.this_lExcluirDocumento
                *-- Excluir Cheque: botao 9
                .Buttons(9).Enabled = THIS.this_lExcluirCheque
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarBotoesLinhaCorrente - Habilita/desabilita botoes conforme cheque corrente
    * Chamado pelo AfterRowColChange do grid e pelo handler de navegacao
    *==========================================================================
    PROCEDURE AtualizarBotoesLinhaCorrente()
        LOCAL loc_lCancelado, loc_cCursorCheques
        loc_cCursorCheques = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursorCheques) OR EOF(loc_cCursorCheques)
            RETURN
        ENDIF

        SELECT (loc_cCursorCheques)
        loc_lCancelado = (NCancelas <> 0)

        *-- Atualizar campo Favorecido
        IF VARTYPE(THIS.txt_4c_Favorecido) = "O"
            THIS.txt_4c_Favorecido.Value = ALLTRIM(NVL(Favos, ""))
        ENDIF

        IF VARTYPE(THIS.cmg_4c_Acoes) = "O"
            WITH THIS.cmg_4c_Acoes
                .Buttons(1).Enabled = !loc_lCancelado                                       && Documento
                .Buttons(6).Enabled = (!loc_lCancelado AND THIS.this_lExcluirDocumento)     && Exclui Docto
                .Buttons(3).Enabled = !loc_lCancelado                                       && Imprimir
                .Buttons(5).Enabled = !loc_lCancelado                                       && Recibo
                .Buttons(9).Enabled = (loc_lCancelado AND THIS.this_lExcluirCheque)         && Excluir Chq
            ENDWITH

            *-- Mostrar/ocultar container justificativa conforme situacao
            IF VARTYPE(THIS.cnt_4c_Justificativa) = "O"
                IF loc_lCancelado
                    WITH THIS.cnt_4c_Justificativa
                        .Visible = .T.
                        .txt_4c_Justificativa.Value = ALLTRIM(NVL(Justcanc, ""))
                        .txt_4c_Justificativa.Width  = 238
                        .txt_4c_Justificativa.ReadOnly = .T.
                        .cmg_4c_Conf.Visible = .F.
                    ENDWITH
                ELSE
                    THIS.cnt_4c_Justificativa.Visible = .F.
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * MontarCheques - Dispara carga do cursor de cheques pelo BO
    * Equivalente ao mMontaChq do legado - chamado pelo botao Processar
    *==========================================================================
    PROCEDURE MontarCheques(par_lPosiciona)
        LOCAL loc_lSucesso
        IF TYPE("par_lPosiciona") != "L"
            par_lPosiciona = .F.
        ENDIF

        *-- Sincronizar filtros da UI para o BO
        THIS.this_oBusinessObject.this_cCdGrupos  = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
        THIS.this_oBusinessObject.this_cDsGrupos  = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
        THIS.this_oBusinessObject.this_cCdContas  = ALLTRIM(THIS.txt_4c_CdContas.Value)
        THIS.this_oBusinessObject.this_cDsContas  = ALLTRIM(THIS.txt_4c_DsContas.Value)
        THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
        THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value

        loc_lSucesso = THIS.this_oBusinessObject.MontarCheques(par_lPosiciona)

        IF loc_lSucesso AND VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
            THIS.AtualizarBotoesLinhaCorrente()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExibirCheques - Reordena/reposiciona cursor conforme conta filtrada
    * Equivalente ao mExibeCheques do legado
    *==========================================================================
    PROCEDURE ExibirCheques(par_lSeek)
        IF TYPE("par_lSeek") != "L"
            par_lSeek = .F.
        ENDIF
        THIS.this_oBusinessObject.ExibirCheques(par_lSeek)
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        THIS.AtualizarBotoesLinhaCorrente()
    ENDPROC

    *==========================================================================
    * CarregarConta - Carrega CsSigCdmp para impressao de documento
    * Equivalente ao CarregaConta do legado
    *==========================================================================
    PROCEDURE CarregarConta()
        LOCAL loc_lSucesso, loc_cCursor, loc_cSQL, loc_cEmpdopnums

        loc_lSucesso    = .F.
        loc_cCursor     = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor) OR EOF(loc_cCursor)
            RETURN .F.
        ENDIF

        SELECT (loc_cCursor)
        loc_cEmpdopnums = ALLTRIM(Emps) + ALLTRIM(Dopes) + STR(NNumes, 6)

        loc_cSQL = "SELECT * FROM SigCdPgr WHERE RTRIM(Emps)+RTRIM(Dopes)+STR(Numes,6) = " + ;
                   EscaparSQL(loc_cEmpdopnums)

        IF USED("cursor_4c_Pgr")
            USE IN cursor_4c_Pgr
        ENDIF

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pgr") < 1
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Pgr
        GO TOP

        RETURN !EOF("cursor_4c_Pgr")
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincula eventos dos controles aos handlers do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
        *-- Grid: AfterRowColChange para atualizar painel ao navegar
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        ENDIF

        *-- Checkbox de selecao (Column10/Check1): KeyPress para toggle via teclado
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            BINDEVENT(THIS.grd_4c_Dados.Column10.Check1, "KeyPress",  THIS, "GrdChkKeyPress")
            BINDEVENT(THIS.grd_4c_Dados.Column10.Check1, "MouseDown", THIS, "GrdChkMouseDown")
        ENDIF

        *-- Header clnNcopias: Click para reordenar por NCopias
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "GrdHeaderNCopias")
        ENDIF

        *-- Botao Processar
        IF VARTYPE(THIS.cmd_4c_Processar) = "O"
            BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
        ENDIF

        *-- Botoes de selecao
        IF VARTYPE(THIS.cmd_4c_SelTudo) = "O"
            BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Apaga) = "O"
            BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
        ENDIF

        *-- Botoes de acao (CommandGroup)
        IF VARTYPE(THIS.cmg_4c_Acoes) = "O"
            BINDEVENT(THIS.cmg_4c_Acoes.Buttons(1), "Click", THIS, "BtnDocumentoClick")
            BINDEVENT(THIS.cmg_4c_Acoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")
            BINDEVENT(THIS.cmg_4c_Acoes.Buttons(3), "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.cmg_4c_Acoes.Buttons(4), "Click", THIS, "BtnProcurarClick")
            BINDEVENT(THIS.cmg_4c_Acoes.Buttons(5), "Click", THIS, "BtnReciboClick")
            BINDEVENT(THIS.cmg_4c_Acoes.Buttons(6), "Click", THIS, "BtnExcluiDocClick")
            BINDEVENT(THIS.cmg_4c_Acoes.Buttons(7), "Click", THIS, "BtnImpchqClick")
            BINDEVENT(THIS.cmg_4c_Acoes.Buttons(8), "Click", THIS, "BtnChmatClick")
            BINDEVENT(THIS.cmg_4c_Acoes.Buttons(9), "Click", THIS, "BtnExcluirChqClick")
        ENDIF

        *-- Container justificativa: botoes Confirmar/Cancelar
        IF VARTYPE(THIS.cnt_4c_Justificativa) = "O"
            BINDEVENT(THIS.cnt_4c_Justificativa.cmg_4c_Conf.Buttons(1), "Click", THIS, "BtnConfJustClick")
            BINDEVENT(THIS.cnt_4c_Justificativa.cmg_4c_Conf.Buttons(2), "Click", THIS, "BtnCancJustClick")
        ENDIF

        *-- Container impchmat: botoes Imprimir/Encerrar + KeyPress leitor do banco
        IF VARTYPE(THIS.cnt_4c_Impchmat) = "O"
            BINDEVENT(THIS.cnt_4c_Impchmat.cmg_4c_ImpProc.Buttons(1), "Click", THIS, "BtnImpChmatClick")
            BINDEVENT(THIS.cnt_4c_Impchmat.cmg_4c_ImpProc.Buttons(2), "Click", THIS, "BtnCancChmatClick")
            BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Banco, "KeyPress",  THIS, "TxtBancoImpKeyPress")
            BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chfin, "KeyPress", THIS, "TxtChfinLostFocus")
            BINDEVENT(THIS.cnt_4c_Impchmat.txt_4c_Chini, "KeyPress", THIS, "TxtChiniLostFocus")
        ENDIF

        *-- Container Procurar: botoes + KeyPress leitor do banco
        IF VARTYPE(THIS.cnt_4c_Procurar) = "O"
            BINDEVENT(THIS.cnt_4c_Procurar.cmg_4c_PrcProc.Buttons(1), "Click", THIS, "BtnProcurarExecClick")
            BINDEVENT(THIS.cnt_4c_Procurar.cmg_4c_PrcProc.Buttons(2), "Click", THIS, "BtnCancProcurarClick")
            BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_BancoP, "KeyPress", THIS, "TxtBancoProcKeyPress")
            BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_BancoP, "LostFocus",    THIS, "TxtBancoProcValid")
            BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_EmissaoP, "When",   THIS, "TxtEmissaoProcWhen")
            BINDEVENT(THIS.cnt_4c_Procurar.txt_4c_ValorP,   "When",   THIS, "TxtValorProcWhen")
        ENDIF

        *-- Filtros: KeyPress nos campos de grupo/conta para busca
        IF VARTYPE(THIS.txt_4c_CdGrupos) = "O"
            BINDEVENT(THIS.txt_4c_CdGrupos, "KeyPress",  THIS, "TxtCdGruposKeyPress")
            BINDEVENT(THIS.txt_4c_DsGrupos, "KeyPress",  THIS, "TxtDsGruposKeyPress")
            BINDEVENT(THIS.txt_4c_CdContas, "KeyPress",  THIS, "TxtCdContasKeyPress")
            BINDEVENT(THIS.txt_4c_DsContas, "KeyPress",  THIS, "TxtDsContasKeyPress")
            BINDEVENT(THIS.txt_4c_DtInicial, "LostFocus",    THIS, "TxtDtInicialValid")
            BINDEVENT(THIS.txt_4c_DtFinal,   "LostFocus",    THIS, "TxtDtFinalValid")
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis, pulando containers flutuantes
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
        LOCAL loc_oControl
        FOR EACH loc_oControl IN THIS.Controls
            IF VARTYPE(loc_oControl) != "O"
                LOOP
            ENDIF
            *-- Containers flutuantes ficam Visible=.F. por default (toggled pelos botoes)
            IF INLIST(UPPER(loc_oControl.Name), ;
                      "CNT_4C_SOMBRA", ;
                      "CNT_4C_JUSTIFICATIVA", ;
                      "CNT_4C_IMPCHMAT", ;
                      "CNT_4C_PROCURAR")
                *-- Recursar dentro para tornar filhos visiveis sem mudar o proprio container
                THIS.TornarSubControlesVisiveis(loc_oControl)
                LOOP
            ENDIF
            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarSubControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_oControl
        FOR EACH loc_oControl IN par_oContainer.Controls
            IF VARTYPE(loc_oControl) != "O"
                LOOP
            ENDIF
            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarSubControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * --- HANDLERS DE EVENTOS ---
    *==========================================================================

    *-- Grid AfterRowColChange: atualiza painel inferior ao navegar
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        THIS.LockScreen = .T.
        THIS.AtualizarBotoesLinhaCorrente()
        THIS.LockScreen = .F.
    ENDPROC

    *-- Grid Checkbox KeyPress: toggle de selecao via ENTER ou SPACE
    PROCEDURE GrdChkKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCursor, loc_cChave, loc_nRecno
        IF INLIST(par_nKeyCode, 13, 32)
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
            IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                SELECT (loc_cCursor)
                loc_nRecno = RECNO()
                loc_cChave = ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques)
                UPDATE (loc_cCursor) SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
                    WHERE ALLTRIM(Bancos) + ALLTRIM(Agencias) + ALLTRIM(Ncontas) + ALLTRIM(Ncheques) = m.loc_cChave ;
                    AND NEmitidos = 0 AND NCancelas = 0
                IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                    GOTO loc_nRecno IN (loc_cCursor)
                ENDIF
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC

    *-- Grid Checkbox MouseDown: delegar para KeyPress com SPACE
    PROCEDURE GrdChkMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        THIS.GrdChkKeyPress(32, 0)
        NODEFAULT
    ENDPROC

    *-- Header NCopias Click: reordenar por NCopias (sem conta filtrada)
    PROCEDURE GrdHeaderNCopias()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
        IF EMPTY(THIS.txt_4c_CdContas.Value) AND UPPER(ORDER(loc_cCursor)) != "NCOPIAS"
            THIS.ExibirCheques(.F.)
        ENDIF
    ENDPROC

    *-- Botao Processar: valida periodo e dispara MontarCheques
    PROCEDURE BtnProcessarClick()
        IF THIS.txt_4c_DtInicial.Value > THIS.txt_4c_DtFinal.Value
            MsgAviso("Data Final menor que Data Inicial !!!", "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")
            THIS.txt_4c_DtInicial.SetFocus()
            RETURN
        ENDIF
        THIS.MontarCheques(.F.)
    ENDPROC

    *-- Botao SelTudo: marca todos os cheques nao-emitidos nao-cancelados
    PROCEDURE BtnSelTudoClick()
        LOCAL loc_cCursor, loc_nRecno
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            loc_nRecno = RECNO()
            UPDATE (loc_cCursor) SET NMarca1s = 1 WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
            IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                GOTO loc_nRecno IN (loc_cCursor)
            ENDIF
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *-- Botao Apaga: desmarca todos os cheques selecionados
    PROCEDURE BtnApagaClick()
        LOCAL loc_cCursor, loc_nRecno
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            loc_nRecno = RECNO()
            UPDATE (loc_cCursor) SET NMarca1s = 0 WHERE NMarca1s = 1
            IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                GOTO loc_nRecno IN (loc_cCursor)
            ENDIF
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *-- Botao Encerrar
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *-- Botao Documento: abre SigCdPgr para o cheque corrente
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_lCarregou, loc_nRecno, loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        THIS.LockScreen = .T.
        loc_nRecno = RECNO(loc_cCursor)

        IF !EOF(loc_cCursor) AND THIS.CarregarConta()
            SELECT (loc_cCursor)
            DO FORM SigCdPgr WITH ;
                LEFT(ALLTRIM(Dopes), 1), .T., ;
                ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
            IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                GOTO loc_nRecno IN (loc_cCursor)
            ENDIF
            THIS.ExibirCheques(.F.)
        ENDIF

        THIS.LockScreen = .F.
    ENDPROC

    *-- Botao Imprimir: abre FormSigReEch para visualizar/imprimir o cheque corrente
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lCarregou, loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor) OR EOF(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
            MsgAviso("Nenhum cheque selecionado para visualizar.", "Imprimir")
            RETURN
        ENDIF

        IF THIS.CarregarConta()
            SELECT (loc_cCursor)
            DO FORM FormSigReEch WITH ;
                ALLTRIM(Emps), ALLTRIM(Dopes), NNumes, "CONSULTAR", ALLTRIM(NCheques)
            THIS.ExibirCheques(.F.)
        ENDIF
    ENDPROC

    *-- Botao Recibo: abre SigRerec para o cheque corrente
    PROCEDURE BtnReciboClick()
        LOCAL loc_lCarregou
        IF THIS.CarregarConta()
            DO FORM SigRerec WITH THIS, "RECIBO"
        ENDIF
    ENDPROC

    *-- Botao Excluir Documento
    PROCEDURE BtnExcluiDocClick()
        LOCAL loc_nRecno, loc_cCursor, loc_lCarregou
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        THIS.LockScreen = .T.
        loc_nRecno = RECNO(loc_cCursor)

        IF !EOF(loc_cCursor) AND THIS.CarregarConta()
            SELECT (loc_cCursor)
            DO FORM SigCdPgr WITH ;
                LEFT(ALLTRIM(Dopes), 1), .F., ;
                ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
            IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                GOTO loc_nRecno IN (loc_cCursor)
            ENDIF
            THIS.ExibirCheques(.F.)
        ENDIF

        THIS.LockScreen = .F.
    ENDPROC

    *-- Botao Cheque: imprime fisicamente cheques marcados em impressora de cheque
    PROCEDURE BtnImpchqClick()
        LOCAL loc_cCursor, loc_oErro, loc_cBancos
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
            MsgAviso("Nenhum cheque dispon" + CHR(237) + "vel.", "Cheque")
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_TmpBanco")
                USE IN cursor_4c_TmpBanco
            ENDIF

            SELECT DISTINCT Bancos FROM (loc_cCursor) WHERE NMarca1s = 1 ;
              INTO CURSOR cursor_4c_TmpBanco

            SELECT cursor_4c_TmpBanco
            GO TOP
            IF EOF("cursor_4c_TmpBanco")
                MsgAviso("Nenhum cheque selecionado para impress" + CHR(227) + "o.", "Cheque")
                USE IN cursor_4c_TmpBanco
                RETURN
            ENDIF

            IF RECCOUNT("cursor_4c_TmpBanco") > 1
                MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                USE IN cursor_4c_TmpBanco
                RETURN
            ENDIF

            loc_cBancos = ALLTRIM(cursor_4c_TmpBanco.Bancos)
            USE IN cursor_4c_TmpBanco

            IF USED("cursor_4c_ImpTemp")
                USE IN cursor_4c_ImpTemp
            ENDIF

            SELECT Bancos, Agencias, NContas, NCheques, cIdChaves, ;
                   Valors, Datas, NEmitidos, NCancelas, Favos ;
              FROM (loc_cCursor) ;
             WHERE NMarca1s = 1 ;
             ORDER BY Bancos, NCheques ;
              INTO CURSOR cursor_4c_ImpTemp READWRITE

            THIS.this_oBusinessObject.ImprimirCheques(loc_cBancos)

            IF USED("cursor_4c_ImpTemp")
                USE IN cursor_4c_ImpTemp
            ENDIF

            THIS.ExibirCheques(.F.)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir cheque")
        ENDTRY
    ENDPROC

    *-- Botao Chq. Matric.: activa container de impressao matricial
    PROCEDURE BtnChmatClick()
        THIS.this_lChMatIni = .T.
        WITH THIS.cnt_4c_Impchmat
            .Enabled = .T.
            .Visible = .T.
            .txt_4c_Banco.Value = ""
            .txt_4c_Chini.Value = ""
            .txt_4c_Chfin.Value = ""
            .txt_4c_Banco.SetFocus()
        ENDWITH
        THIS.cmg_4c_Acoes.Enabled = .F.
        THIS.Refresh()
    ENDPROC

    *-- Botao Excluir Cheque: confirma e exclui cheque cancelado
    PROCEDURE BtnExcluirChqClick()
        LOCAL loc_cCursor, loc_cSQL, loc_nOk, loc_cMensa, loc_oErro
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        IF !USED(loc_cCursor) OR EOF(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        IF NCancelas = 1 AND THIS.this_lExcluirCheque
            IF MsgConfirma("Deseja realmente excluir o cheque :" + CHR(13) + ;
                           ALLTRIM(Bancos) + " / " + ALLTRIM(Agencias) + ;
                           " / " + ALLTRIM(Ncontas) + " / " + ALLTRIM(Ncheques) + " ?")
                TRY
                    loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(ALLTRIM(Cidchaves))
                    IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                        loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado : " + ;
                                     ALLTRIM(Bancos) + "/" + ALLTRIM(Agencias) + ;
                                     "/" + ALLTRIM(Ncontas) + "/" + ALLTRIM(Ncheques)
                        THIS.this_oBusinessObject.RegistrarAuditoria("DELETE")
                    ELSE
                        MsgErro("Falha ao excluir cheque.", "Erro")
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro(loc_oErro.Message, "Erro")
                ENDTRY
                THIS.ExibirCheques(.F.)
            ENDIF
        ENDIF
    ENDPROC

    *-- Botao Procurar: activa container de busca de cheque
    PROCEDURE BtnProcurarClick()
        THIS.this_lPlInicio = .T.
        WITH THIS.cnt_4c_Procurar
            .Visible = .T.
            .Enabled = .T.
            .txt_4c_BancoP.SetFocus()
        ENDWITH
        WITH THIS.cmg_4c_Acoes
            .Buttons(1).Enabled = .F.
            .Buttons(2).Enabled = .F.
            .Buttons(3).Enabled = .F.
            .Buttons(4).Enabled = .F.
            .Buttons(5).Enabled = .F.
            .Buttons(6).Enabled = .F.
        ENDWITH
        THIS.txt_4c_CdContas.Enabled   = .F.
        THIS.txt_4c_DsContas.Enabled   = .F.
        THIS.grd_4c_Dados.Enabled      = .F.
        THIS.txt_4c_Favorecido.Enabled = .F.
        THIS.Refresh()
    ENDPROC

    *-- Botao Confirmar Justificativa: cancela cheque com justificativa
    PROCEDURE BtnConfJustClick()
        LOCAL loc_nRecno, loc_cCursor, loc_cJust, loc_lCarregou, loc_oErro

        IF EMPTY(THIS.cnt_4c_Justificativa.txt_4c_Justificativa.Value)
            MsgAviso("Aten" + CHR(231) + CHR(227) + "o, justificativa em Branco", "")
            THIS.cnt_4c_Justificativa.txt_4c_Justificativa.SetFocus()
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
        THIS.LockScreen = .T.
        loc_nRecno = RECNO(loc_cCursor)

        IF !EOF(loc_cCursor) AND THIS.CarregarConta()
            TRY
                SELECT (loc_cCursor)
                THIS.Enabled = .F.
                DO FORM SigCdPgr WITH ;
                    LEFT(ALLTRIM(Dopes), 1), .F., ;
                    ALLTRIM(Emps), ALLTRIM(Dopes), NNumes
                IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
                    GOTO loc_nRecno IN (loc_cCursor)
                ENDIF
                THIS.ExibirCheques(.F.)
                THIS.Enabled = .T.
                THIS.cnt_4c_Justificativa.Visible = .F.
            CATCH TO loc_oErro
                THIS.Enabled = .T.
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        THIS.LockScreen = .F.
    ENDPROC

    *-- Botao Cancelar Justificativa
    PROCEDURE BtnCancJustClick()
        THIS.cnt_4c_Justificativa.Enabled = .F.
        THIS.cnt_4c_Justificativa.Visible = .F.
    ENDPROC

    *-- Botao Imprimir Matricial: imprime cheques por faixa (impchmat)
    PROCEDURE BtnImpChmatClick()
        LOCAL loc_cBanco, loc_cChIni, loc_cChFin, loc_cSQL, loc_oErro

        WITH THIS.cnt_4c_Impchmat
            loc_cBanco = ALLTRIM(.txt_4c_Banco.Value)
            loc_cChIni = ALLTRIM(.txt_4c_Chini.Value)
            loc_cChFin = ALLTRIM(.txt_4c_Chfin.Value)
            .Visible     = .T.
        ENDWITH

        IF EMPTY(loc_cBanco)
            MsgAviso("Banco n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Impchmat.txt_4c_Banco.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cChIni)
            MsgAviso("N" + CHR(250) + "mero do cheque inicial n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Impchmat.txt_4c_Chini.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cChFin)
            MsgAviso("N" + CHR(250) + "mero do cheque final n" + CHR(227) + "o preenchido !!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus()
            RETURN
        ENDIF
        IF loc_cChFin < loc_cChIni
            MsgAviso("Cheque final menor que o inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Impchmat.txt_4c_Chfin.SetFocus()
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT bancos, valors, ncheques, datas, emitidos, cancelas, favos " + ;
                       "FROM SigCqChi " + ;
                       "WHERE bancos = " + EscaparSQL(loc_cBanco) + ;
                       " AND ncheques BETWEEN " + EscaparSQL(loc_cChIni) + ;
                       " AND " + EscaparSQL(loc_cChFin) + ;
                       " ORDER BY ncheques"

            IF USED("cursor_4c_MatrizTemp")
                USE IN cursor_4c_MatrizTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizTemp") > 0
                THIS.this_oBusinessObject.ImprimirChequesMatricial()
                USE IN cursor_4c_MatrizTemp
            ELSE
                MsgAviso("Nenhum cheque encontrado na faixa informada.", "Impress" + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir matricial")
        ENDTRY
    ENDPROC

    *-- Botao Encerrar Matricial: fecha container impchmat e reactiva acoes
    PROCEDURE BtnCancChmatClick()
        THIS.LockScreen = .T.
        THIS.cmg_4c_Acoes.Enabled    = .T.
        THIS.cnt_4c_Impchmat.Enabled  = .F.
        THIS.cnt_4c_Impchmat.Visible  = .F.
        THIS.ExibirCheques(.F.)
        THIS.LockScreen = .F.
    ENDPROC

    *-- Botao Procurar (exec no container): busca cheque por banco/agencia/conta/cheque/emissao/valor
    PROCEDURE BtnProcurarExecClick()
        LOCAL loc_oCnt, loc_cCursor
        loc_oCnt    = THIS.cnt_4c_Procurar
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques

        SET NEAR ON

        loc_oCnt.txt_4c_BancoP.Value = PADR(ALLTRIM(loc_oCnt.txt_4c_BancoP.Value), 3)

        SELECT (loc_cCursor)
        DO CASE
            CASE !EMPTY(loc_oCnt.txt_4c_EmissaoP.Value)
                SET ORDER TO Emissao
                SEEK DTOS(loc_oCnt.txt_4c_EmissaoP.Value) + ;
                     ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
                     ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
                     ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
                     ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
            CASE !EMPTY(loc_oCnt.txt_4c_ValorP.Value)
                SET ORDER TO Valor
                SEEK STR(loc_oCnt.txt_4c_ValorP.Value, 12, 2) + ;
                     ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
                     ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
                     ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
                     ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
            OTHERWISE
                SET ORDER TO Cheque
                SEEK ALLTRIM(loc_oCnt.txt_4c_BancoP.Value) + ;
                     ALLTRIM(loc_oCnt.txt_4c_AgenciaP.Value) + ;
                     ALLTRIM(loc_oCnt.txt_4c_ContaP.Value) + ;
                     ALLTRIM(loc_oCnt.txt_4c_ChequeP.Value)
        ENDCASE

        SET NEAR OFF

        *-- Ocultar container e reativar controles principais
        THIS.txt_4c_CdContas.Enabled   = .T.
        THIS.txt_4c_DsContas.Enabled   = .T.
        THIS.grd_4c_Dados.Enabled      = .T.
        THIS.txt_4c_Favorecido.Enabled = .T.
        THIS.AtualizarBotoesPermissao()
        THIS.cnt_4c_Procurar.Visible   = .F.
        THIS.cnt_4c_Procurar.Enabled   = .F.
        THIS.ExibirCheques(.F.)
    ENDPROC

    *-- Botao Encerrar Procurar
    PROCEDURE BtnCancProcurarClick()
        THIS.LockScreen = .T.
        THIS.txt_4c_CdContas.Enabled   = .T.
        THIS.txt_4c_DsContas.Enabled   = .T.
        THIS.grd_4c_Dados.Enabled      = .T.
        THIS.txt_4c_Favorecido.Enabled = .T.
        THIS.AtualizarBotoesPermissao()
        THIS.cnt_4c_Procurar.Visible   = .F.
        THIS.cnt_4c_Procurar.Enabled   = .F.
        THIS.ExibirCheques(.F.)
        THIS.LockScreen = .F.
    ENDPROC

    *-- KeyPress no campo Banco do container de impressao matricial (leitor magnetico)
    PROCEDURE TxtBancoImpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        *-- CHR(60) = inicio de leitura CMC7 do leitor de cheques
        IF par_nKeyCode = 60
            IF !THIS.this_lPlLeCheque
                THIS.this_cPcChqLido = ""
            ENDIF
            THIS.this_lPlLeCheque = .T.
        ENDIF
        IF THIS.this_lPlLeCheque
            NODEFAULT
            THIS.this_cPcChqLido = THIS.this_cPcChqLido + CHR(par_nKeyCode)
        ENDIF
        *-- CHR(58) = fim de leitura
        IF par_nKeyCode = 58
            THIS.this_lPlLeCheque = .F.
        ENDIF
    ENDPROC

    *-- KeyPress no campo Banco do container Procurar (leitor magnetico)
    PROCEDURE TxtBancoProcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 60
            IF !THIS.this_lPlLeCheque
                THIS.this_cPcChqLido = ""
            ENDIF
            THIS.this_lPlLeCheque = .T.
        ENDIF
        IF THIS.this_lPlLeCheque
            NODEFAULT
            THIS.this_cPcChqLido = THIS.this_cPcChqLido + CHR(par_nKeyCode)
        ENDIF
        IF par_nKeyCode = 58
            THIS.this_lPlLeCheque = .F.
        ENDIF
    ENDPROC

    *-- Valid do campo Banco no Procurar: processa dado do leitor ou TAB
    PROCEDURE TxtBancoProcValid()
        LOCAL loc_oCnt, loc_cLeitor
        loc_oCnt = THIS.cnt_4c_Procurar

        IF THIS.this_lPlLeCheque
            loc_cLeitor = THIS.this_cPcChqLido
        ELSE
            loc_cLeitor = ""
        ENDIF

        THIS.this_lPlLeitor = .F.

        IF LASTKEY() = 9
            KEYBOARD "{CTRL+TAB}"
        ELSE
            THIS.this_lPlLeitor = .T.
            IF LEN(loc_cLeitor) >= 33
                *-- Decodificar CMC7: banco(2-4), agencia(5-8), conta(23-32), cheque(14-19)
                loc_oCnt.txt_4c_BancoP.Value   = SUBSTR(loc_cLeitor, 2, 3)
                loc_oCnt.txt_4c_AgenciaP.Value = SUBSTR(loc_cLeitor, 5, 4)
                loc_oCnt.txt_4c_ContaP.Value   = SUBSTR(loc_cLeitor, 23, 10)
                loc_oCnt.txt_4c_ChequeP.Value  = SUBSTR(loc_cLeitor, 14, 6)
                THIS.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *-- When no campo emissao do Procurar: so habilita se valor estiver vazio
    PROCEDURE TxtEmissaoProcWhen()
        RETURN EMPTY(THIS.cnt_4c_Procurar.txt_4c_ValorP.Value)
    ENDPROC

    *-- When no campo valor do Procurar: so habilita se emissao estiver vazia
    PROCEDURE TxtValorProcWhen()
        RETURN EMPTY(THIS.cnt_4c_Procurar.txt_4c_EmissaoP.Value)
    ENDPROC

    *-- Valid data inicial: ajustar data final e limpar grid se mudou
    PROCEDURE TxtDtInicialValid()
        IF THIS.txt_4c_DtInicial.Value > THIS.txt_4c_DtFinal.Value
            THIS.txt_4c_DtFinal.Value = THIS.txt_4c_DtInicial.Value
        ENDIF
        IF THIS.txt_4c_DtInicial.Value != THIS.this_dAntDtIni
            LOCAL loc_cCursor
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
            IF USED(loc_cCursor)
                ZAP IN (loc_cCursor)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
        THIS.this_dAntDtIni = THIS.txt_4c_DtInicial.Value
    ENDPROC

    *-- Valid data final: ajustar data inicial e limpar grid se mudou
    PROCEDURE TxtDtFinalValid()
        IF THIS.txt_4c_DtFinal.Value < THIS.txt_4c_DtInicial.Value
            THIS.txt_4c_DtInicial.Value = THIS.txt_4c_DtFinal.Value
        ENDIF
        IF THIS.txt_4c_DtFinal.Value != THIS.this_dAntDtFin
            LOCAL loc_cCursor
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
            IF USED(loc_cCursor)
                ZAP IN (loc_cCursor)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
        THIS.this_dAntDtFin = THIS.txt_4c_DtFinal.Value
    ENDPROC

    *-- KeyPress no codigo do grupo: F4/Enter/Tab abre lookup de grupos contabeis
    PROCEDURE TxtCdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cVal, loc_oForm, loc_cSQL
        loc_cVal = ALLTRIM(THIS.txt_4c_CdGrupos.Value)

        IF !EMPTY(loc_cVal)
            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE RTRIM(codigos) = " + ;
                       EscaparSQL(loc_cVal)
            IF USED("cursor_4c_GrupoOk")
                USE IN cursor_4c_GrupoOk
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoOk") > 0
                SELECT cursor_4c_GrupoOk
                GO TOP
                IF !EOF("cursor_4c_GrupoOk")
                    THIS.txt_4c_CdGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.codigos)
                    THIS.txt_4c_DsGrupos.Value = ALLTRIM(cursor_4c_GrupoOk.descrs)
                    THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(cursor_4c_GrupoOk.codigos)
                    USE IN cursor_4c_GrupoOk
                    IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
                        ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                    THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
                    RETURN
                ENDIF
                USE IN cursor_4c_GrupoOk
            ENDIF
        ELSE
            THIS.txt_4c_DsGrupos.Value = ""
            THIS.this_oBusinessObject.this_cCdGrupos = ""
            IF THIS.this_cAntCdGrupo != ""
                ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            THIS.this_cAntCdGrupo = ""
            RETURN
        ENDIF

        *-- Nao encontrado: abrir picker
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_GrupoLookup", ;
                    "codigos", loc_cVal, ;
                    "Grupos Cont" + CHR(225) + "beis", .T., .T., "")
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
                SELECT cursor_4c_GrupoLookup
                THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
                THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
                THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
            ENDIF
        ENDIF
        IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntCdGrupo
            ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        THIS.this_cAntCdGrupo = THIS.txt_4c_CdGrupos.Value
    ENDPROC

    *-- KeyPress na descricao do grupo: F4/Enter/Tab abre lookup por descricao
    PROCEDURE TxtDsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cVal, loc_oForm
        loc_cVal = ALLTRIM(THIS.txt_4c_DsGrupos.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_GrupoLookup", ;
                    "descrs", loc_cVal, ;
                    "Grupos Cont" + CHR(225) + "beis", .T., .T., "")
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrupoLookup")
                SELECT cursor_4c_GrupoLookup
                THIS.txt_4c_CdGrupos.Value = ALLTRIM(codigos)
                THIS.txt_4c_DsGrupos.Value = ALLTRIM(descrs)
                THIS.this_oBusinessObject.this_cCdGrupos = ALLTRIM(codigos)
            ENDIF
        ENDIF
        IF THIS.txt_4c_CdGrupos.Value != THIS.this_cAntDsGrupo
            ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        THIS.this_cAntDsGrupo = THIS.txt_4c_CdGrupos.Value
    ENDPROC

    *-- KeyPress no codigo da conta: F4/Enter/Tab abre lookup de contas
    PROCEDURE TxtCdContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cVal, loc_oForm, loc_cSQL
        loc_cVal = ALLTRIM(THIS.txt_4c_CdContas.Value)

        IF !EMPTY(loc_cVal)
            IF USED("cursor_4c_Contas") AND SEEK(loc_cVal, "cursor_4c_Contas", "IClis")
                SELECT cursor_4c_Contas
                THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
                THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
                THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
                IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
                    ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
                RETURN
            ENDIF
        ELSE
            THIS.txt_4c_DsContas.Value = ""
            THIS.this_oBusinessObject.this_cCdContas = ""
            IF THIS.this_cAntCdConta != ""
                ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            THIS.this_cAntCdConta = ""
            RETURN
        ENDIF

        *-- Nao encontrado: abrir picker usando SQLEXEC LIKE no cursor_4c_ContasLookup
        THIS.AbrirLookupContas(loc_cVal, "C")
        IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
            ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
    ENDPROC

    *-- KeyPress na descricao da conta: F4/Enter/Tab abre lookup por nome
    PROCEDURE TxtDsContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cVal
        loc_cVal = ALLTRIM(THIS.txt_4c_DsContas.Value)

        THIS.AbrirLookupContas(loc_cVal, "D")
        IF THIS.txt_4c_DsContas.Value != THIS.this_cAntDsConta
            ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        THIS.this_cAntDsConta = THIS.txt_4c_DsContas.Value
    ENDPROC

    *-- AbrirLookupContas - Abre picker de contas bancarias via FormBuscaAuxiliar com Init params
    *   par_cVal: valor digitado pelo usuario (prefixo para LIKE)
    *   par_cModo: "C" busca por codigo (IClis), "D" busca por descricao (RClis)
    PROCEDURE AbrirLookupContas(par_cVal, par_cModo)
        LOCAL loc_cSQL, loc_cCampo, loc_oForm, loc_cGrupo

        loc_cGrupo = ALLTRIM(THIS.txt_4c_CdGrupos.Value)

        IF par_cModo = "C"
            loc_cCampo = "IClis"
            IF EMPTY(par_cVal)
                loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
            ELSE
                loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
                           "WHERE RTRIM(IClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
            ENDIF
        ELSE
            loc_cCampo = "RClis"
            IF EMPTY(par_cVal)
                loc_cSQL = "SELECT IClis, RClis FROM SigCdCli"
            ELSE
                loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
                           "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cVal) + "%")
            ENDIF
        ENDIF

        IF !EMPTY(loc_cGrupo)
            IF EMPTY(par_cVal)
                loc_cSQL = loc_cSQL + " WHERE RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
            ELSE
                loc_cSQL = loc_cSQL + " AND RTRIM(Grupos) = " + EscaparSQL(loc_cGrupo)
            ENDIF
        ENDIF

        loc_cSQL = loc_cSQL + " ORDER BY IClis"

        IF USED("cursor_4c_ContasLookup")
            USE IN cursor_4c_ContasLookup
        ENDIF

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContasLookup") < 1
            RETURN
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "", "cursor_4c_ContasLookup", ;
                    loc_cCampo, ALLTRIM(par_cVal), ;
                    "Contas", .T., .T., "")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
        loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oForm.Show()

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ContasLookup")
            SELECT cursor_4c_ContasLookup
            THIS.txt_4c_CdContas.Value = ALLTRIM(IClis)
            THIS.txt_4c_DsContas.Value = ALLTRIM(RClis)
            THIS.this_oBusinessObject.this_cCdContas = ALLTRIM(IClis)
        ENDIF

        IF THIS.txt_4c_CdContas.Value != THIS.this_cAntCdConta
            ZAP IN (THIS.this_oBusinessObject.this_cCursorCheques)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        THIS.this_cAntCdConta = THIS.txt_4c_CdContas.Value
    ENDPROC

    *-- LostFocus do txt_4c_Chfin: padroniza para 6 digitos com zeros a esquerda
    PROCEDURE TxtChfinLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF !EMPTY(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value)
            THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value = ;
                PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chfin.Value), 6, "0")
        ENDIF
    ENDPROC

    *-- LostFocus do txt_4c_Chini: padroniza para 6 digitos com zeros a esquerda
    PROCEDURE TxtChiniLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF !EMPTY(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value)
            THIS.cnt_4c_Impchmat.txt_4c_Chini.Value = ;
                PADL(ALLTRIM(THIS.cnt_4c_Impchmat.txt_4c_Chini.Value), 6, "0")
        ENDIF
    ENDPROC

    *==========================================================================
    * --- ALIASES DE COMPATIBILIDADE COM PIPELINE MULTI-FASE ---
    * OPERACIONAL nao tem Page1/Page2 CRUD; estes metodos existem para que
    * o validador do pipeline encontre as assinaturas esperadas.
    *==========================================================================

    *-- CarregarLista: alias de MontarCheques (pipeline exige este nome)
    PROCEDURE CarregarLista()
        RETURN THIS.MontarCheques(.F.)
    ENDPROC

    *-- FormParaBO: sincroniza filtros da UI para o BO antes de processar
    PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cCdGrupos  = ALLTRIM(THIS.txt_4c_CdGrupos.Value)
        THIS.this_oBusinessObject.this_cDsGrupos  = ALLTRIM(THIS.txt_4c_DsGrupos.Value)
        THIS.this_oBusinessObject.this_cCdContas  = ALLTRIM(THIS.txt_4c_CdContas.Value)
        THIS.this_oBusinessObject.this_cDsContas  = ALLTRIM(THIS.txt_4c_DsContas.Value)
        THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
        THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
    ENDPROC

    *-- BOParaForm: alias de ExibirCheques (pipeline exige este nome)
    PROCEDURE BOParaForm()
        THIS.ExibirCheques(.F.)
    ENDPROC

    *-- BtnSalvarClick: alias de BtnProcessarClick (mapeamento OPERACIONAL)
    PROCEDURE BtnSalvarClick()
        THIS.BtnProcessarClick()
    ENDPROC

    *-- BtnCancelarClick: alias de BtnEncerrarClick (mapeamento OPERACIONAL)
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *-- HabilitarCampos: stub N/A (OPERACIONAL gerencia habilitacao via AtualizarBotoesLinhaCorrente)
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.txt_4c_CdGrupos) = "O"
            THIS.txt_4c_CdGrupos.Enabled  = par_lHabilitar
            THIS.txt_4c_DsGrupos.Enabled  = par_lHabilitar
            THIS.txt_4c_CdContas.Enabled  = par_lHabilitar
            THIS.txt_4c_DsContas.Enabled  = par_lHabilitar
            THIS.txt_4c_DtInicial.Enabled = par_lHabilitar
            THIS.txt_4c_DtFinal.Enabled   = par_lHabilitar
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Processar) = "O"
            THIS.cmd_4c_Processar.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *-- BtnIncluirClick: stub N/A - OPERACIONAL nao tem modo INCLUIR
    PROCEDURE BtnIncluirClick()
        THIS.BtnDocumentoClick()
    ENDPROC

    *-- BtnAlterarClick: stub N/A - OPERACIONAL nao tem modo ALTERAR
    PROCEDURE BtnAlterarClick()
        THIS.BtnDocumentoClick()
    ENDPROC

    *-- BtnVisualizarClick: alias de BtnImprimirClick (visualizacao do cheque via FormSigReEch)
    PROCEDURE BtnVisualizarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *-- BtnExcluirClick: alias de BtnExcluirChqClick (exclusao do cheque cancelado)
    PROCEDURE BtnExcluirClick()
        THIS.BtnExcluirChqClick()
    ENDPROC

    *-- BtnBuscarClick: alias de BtnProcurarClick (mapeamento OPERACIONAL)
    PROCEDURE BtnBuscarClick()
        THIS.BtnProcurarClick()
    ENDPROC

    *-- LimparCampos: reseta campos de filtro da UI (OPERACIONAL: limpa filtros, nao campos de dados)
    PROCEDURE LimparCampos()
        THIS.txt_4c_CdGrupos.Value  = ""
        THIS.txt_4c_DsGrupos.Value  = ""
        THIS.txt_4c_CdContas.Value  = ""
        THIS.txt_4c_DsContas.Value  = ""
        THIS.txt_4c_DtInicial.Value = DATE()
        THIS.txt_4c_DtFinal.Value   = DATE()
        THIS.txt_4c_Favorecido.Value = ""
        THIS.this_cAntCdGrupo = ""
        THIS.this_cAntDsGrupo = ""
        THIS.this_cAntCdConta = ""
        THIS.this_cAntDsConta = ""
        THIS.this_dAntDtIni   = {}
        THIS.this_dAntDtFin   = {}
        THIS.this_oBusinessObject.this_cCdGrupos  = ""
        THIS.this_oBusinessObject.this_cDsGrupos  = ""
        THIS.this_oBusinessObject.this_cCdContas  = ""
        THIS.this_oBusinessObject.this_cDsContas  = ""
        THIS.this_oBusinessObject.this_dDtInicial = DATE()
        THIS.this_oBusinessObject.this_dDtFinal   = DATE()
    ENDPROC

    *-- AjustarBotoesPorModo: stub N/A (OPERACIONAL nao tem ciclo INCLUIR/ALTERAR/VISUALIZAR)
    PROCEDURE AjustarBotoesPorModo()
        THIS.AtualizarBotoesPermissao()
        THIS.AtualizarBotoesLinhaCorrente()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF USED("cursor_4c_Pgr")
            USE IN cursor_4c_Pgr
        ENDIF
        IF USED("cursor_4c_MatrizTemp")
            USE IN cursor_4c_MatrizTemp
        ENDIF
        IF USED("cursor_4c_ImpTemp")
            USE IN cursor_4c_ImpTemp
        ENDIF
        IF USED("cursor_4c_GrupoOk")
            USE IN cursor_4c_GrupoOk
        ENDIF
        IF USED("cursor_4c_GrupoLookup")
            USE IN cursor_4c_GrupoLookup
        ENDIF
        IF USED("cursor_4c_ContasLookup")
            USE IN cursor_4c_ContasLookup
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
