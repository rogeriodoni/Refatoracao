*==============================================================================
* FormSigPrSdd.prg - Senha do Dia
* Tipo: OPERACIONAL (dialog simples migrado sobre estrutura CRUD base)
* Migracao de: SIGPRSDD.SCX
* Tabela: SigPrSnd
* Fase 8/8: Form - COMPLETO (todos os metodos implementados)
*
* NOTA: forma OPERACIONAL flat mapeada para PageFrame com 2 paginas para
* compatibilidade com o pipeline de fases (Page1 = lista placeholder,
* Page2 = dialog de dados). ActivePage inicial = 2 (Dados).
*==============================================================================

DEFINE CLASS FormSigPrSdd AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - original 799x288, redimensionado para
    * suportar cabecalho + botoes CRUD do padrao novo)
    *--------------------------------------------------------------------------
    Width        = 1000
    Height       = 600
    Caption      = "Senha do dia"
    AutoCenter   = .T.
    DataSession  = 2
    ShowWindow = 1
    WindowType = 1
    TitleBar     = 1
    ControlBox   = .T.
    Closable     = .T.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    BorderStyle  = 2
    ShowTips     = .T.
    FontName     = "Tahoma"
    FontSize     = 8
    BackColor    = RGB(100, 100, 100)

    *--------------------------------------------------------------------------
    * Propriedades da instancia
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "OPERACIONAL"
    this_lProducao       = .F.

    *==========================================================================
    * Init - Captura parametro Producao ANTES de DODEFAULT() chamar
    *        InicializarForm(), pois this_lProducao e usado la dentro
    * par_lProducao: .T. = modo producao (SigCdOpd)
    *                .F. = modo simulacao (SigCdOpe)
    *==========================================================================
    PROCEDURE Init(par_lProducao)
        IF PCOUNT() >= 1 AND VARTYPE(par_lProducao) = "L"
            THIS.this_lProducao = par_lProducao
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria estrutura completa do formulario
    * Chamado automaticamente por FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrSddBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_lProducao = THIS.this_lProducao

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                THIS.CarregarLista()
                THIS.AjustarBotoesPorModo()
                THIS.pgf_4c_Paginas.Visible = .T.

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrSddBO", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (lista) e Page2 (dados)
    * Estrutura base: PageFrame invisivel (Tabs=.F., Top=-29) + containers
    * principais vazios em Page2 (cabecalho + botoes + botoes de acao).
    * Fase 3 nao popula os containers - fases posteriores adicionam grid,
    * botoes CRUD e campos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPag2

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount   = 2
            .Top         = -29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height + 29
            .Tabs        = .F.
            .BorderWidth = 0
            .Visible     = .T.
            IF FILE(gc_4c_CaminhoIcones + "fundo_cad_1003.jpg")
                .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            ENDIF
        ENDWITH

        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *-- Container Cabecalho (barra escura com titulo) - vazio nesta fase
        loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPag2.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Container Botoes CRUD (lado direito do cabecalho) - vazio nesta fase
        loc_oPag2.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPag2.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Container Saida/Encerrar (canto direito) - vazio nesta fase
        loc_oPag2.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPag2.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Container Botoes de Acao especificos (Boleto/Gerar Senha) - vazio
        loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPag2.cnt_4c_BotoesAcao
            .Top         = 29
            .Left        = 569
            .Width       = 240
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Pages E Controls para PageFrames aninhados
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Constroi Page1 com cabecalho, botoes CRUD e grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid

        loc_oPag1 = THIS.pgf_4c_Paginas.Page1

        *----------------------------------------------------------------------
        * Cabecalho cinza com titulo
        *----------------------------------------------------------------------
        loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPag1.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oCab = loc_oPag1.cnt_4c_Cabecalho

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize    = .F.
            .Width       = THIS.Width
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 16
            .BackStyle   = 0
            .Caption     = "Senha do Dia"
            .Height      = 40
            .Left        = 10
            .Top         = 15
            .ForeColor   = RGB(0, 0, 0)
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize    = .F.
            .Width       = THIS.Width
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 16
            .BackStyle   = 0
            .Caption     = "Senha do Dia"
            .Height      = 46
            .Left        = 10
            .Top         = 18
            .ForeColor   = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Container de botoes CRUD (lado direito)
        *----------------------------------------------------------------------
        loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPag1.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oBotoes = loc_oPag1.cnt_4c_Botoes

        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Gerar" + CHR(13) + "Senha"
            .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Left            = 80
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Left            = 155
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Left            = 230
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Left            = 305
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *----------------------------------------------------------------------
        * Container Saida/Encerrar - padrao canonico Left=917 W=90
        *----------------------------------------------------------------------
        loc_oPag1.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPag1.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oSaida = loc_oPag1.cnt_4c_Saida

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * Grid de lista de senhas geradas (SigPrSnd)
        *----------------------------------------------------------------------
        loc_oPag1.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPag1.grd_4c_Lista
            .Top                = 117
            .Left               = 5
            .Width              = 990
            .Height             = 450
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
            .ColumnCount        = 8
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH
        loc_oGrid = loc_oPag1.grd_4c_Lista
        loc_oGrid.Column1.Width = 120
        loc_oGrid.Column2.Width = 90
        loc_oGrid.Column3.Width = 50
        loc_oGrid.Column4.Width = 170
        loc_oGrid.Column5.Width = 110
        loc_oGrid.Column6.Width = 110
        loc_oGrid.Column7.Width = 80
        loc_oGrid.Column8.Width = 60
    ENDPROC

    *==========================================================================
    * CarregarLista - Busca registros de SigPrSnd e popula grd_4c_Lista
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_cSQL, loc_nRet, loc_oErro

        TRY
            loc_cSQL = "SELECT TOP 500 " + ;
                       "cidchaves, datas, solicits, operas, docs, valors, senhads, tipos, emps " + ;
                       "FROM SigPrSnd " + ;
                       "ORDER BY datas DESC"

            IF USED("cursor_4c_ListaTemp")
                USE IN cursor_4c_ListaTemp
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaTemp")

            IF loc_nRet > 0 AND USED("cursor_4c_ListaTemp")
                IF USED("cursor_4c_Lista")
                    SELECT cursor_4c_Lista
                    ZAP
                    APPEND FROM DBF("cursor_4c_ListaTemp")
                ELSE
                    SELECT * FROM cursor_4c_ListaTemp INTO CURSOR cursor_4c_Lista READWRITE
                ENDIF
                USE IN cursor_4c_ListaTemp
            ENDIF

            IF USED("cursor_4c_Lista")
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount  = 8
                loc_oGrid.RecordSource = "cursor_4c_Lista"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.datas"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.solicits"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.emps"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.operas"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.docs"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.valors"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Lista.senhads"
                loc_oGrid.Column8.ControlSource = "cursor_4c_Lista.tipos"

                loc_oGrid.Column1.Header1.Caption = "Data/Hora"
                loc_oGrid.Column2.Header1.Caption = "Solicitante"
                loc_oGrid.Column3.Header1.Caption = "Empresa"
                loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column5.Header1.Caption = "Documento"
                loc_oGrid.Column6.Header1.Caption = "Valor"
                loc_oGrid.Column7.Header1.Caption = "Senha"
                loc_oGrid.Column8.Header1.Caption = "Tipo"

                loc_oGrid.Column1.Width = 120
                loc_oGrid.Column2.Width = 90
                loc_oGrid.Column3.Width = 50
                loc_oGrid.Column4.Width = 170
                loc_oGrid.Column5.Width = 110
                loc_oGrid.Column5.Alignment = 1
                loc_oGrid.Column6.Width = 110
                loc_oGrid.Column6.Alignment = 1
                loc_oGrid.Column7.Width = 80
                loc_oGrid.Column8.Width = 60
                loc_oGrid.Column8.Alignment = 2

                THIS.FormatarGridLista(loc_oGrid)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual ao grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega para a pagina especificada
    * par_nPagina: 1=Lista, 2=Dados
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF par_nPagina = 1
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        ENDIF
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara form para nova senha e vai para Page2
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos("INCLUIR")
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo visualizacao
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
            MsgAviso("Selecione um registro na lista.", "Aviso")
        ELSE
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Lista")
            THIS.BOParaForm()
            THIS.HabilitarCampos("VISUALIZAR")
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado em modo edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
            MsgAviso("Selecione um registro na lista.", "Aviso")
        ELSE
            THIS.this_cModoAtual = "ALTERAR"
            THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Lista")
            THIS.BOParaForm()
            THIS.HabilitarCampos("ALTERAR")
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma, loc_lSucesso, loc_oErro

        loc_lConfirma = .F.
        loc_lSucesso  = .F.

        IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
            MsgAviso("Selecione um registro na lista.", "Aviso")
        ELSE
            TRY
                THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Lista")
                loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Confirmar")
                IF loc_lConfirma
                    loc_lSucesso = THIS.this_oBusinessObject.Excluir()
                    IF loc_lSucesso
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                        " PROC=" + loc_oErro.Procedure, "Erro ao Excluir")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega a lista de senhas
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Constroi Page2: cabecalho, botoes de acao
    *                         e PRIMEIRA METADE dos campos do dialogo
    *                         (Fase 5/8: Solicitante, Empresa, Operacao)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag2, loc_oCab, loc_oBotoesAcao, loc_oSaida

        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *----------------------------------------------------------------------
        * Cabecalho cinza com titulo (container criado em ConfigurarPageFrame)
        *----------------------------------------------------------------------
        loc_oCab = loc_oPag2.cnt_4c_Cabecalho

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Width     = THIS.Width
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .BackStyle = 0
            .Caption   = "Senha do Dia"
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .Width     = THIS.Width
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .BackStyle = 0
            .Caption   = "Senha do Dia"
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Botoes de acao: Boleto e Gerar Senha (container criado em ConfigurarPageFrame)
        *----------------------------------------------------------------------
        loc_oBotoesAcao = loc_oPag2.cnt_4c_BotoesAcao

        loc_oBotoesAcao.AddObject("cmd_4c_Boleto", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Boleto
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Boleto"
            .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Boleto, "Click", THIS, "BtnBoletoClick")

        loc_oBotoesAcao.AddObject("cmd_4c_GeraSenha", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_GeraSenha
            .Left            = 80
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Gerar" + CHR(13) + "Senha"
            .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_GeraSenha, "Click", THIS, "BtnGeraSenhaClick")

        *----------------------------------------------------------------------
        * Botao Encerrar (container cnt_4c_Saida criado em ConfigurarPageFrame)
        *----------------------------------------------------------------------
        loc_oSaida = loc_oPag2.cnt_4c_Saida

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Left            = 5
            .Top             = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * Solicitante (TabIndex=1) - Top original 83 + 29 = 112
        * Label original Top=86 + 29 = 115
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("lbl_4c_Solicitante", "Label")
        WITH loc_oPag2.lbl_4c_Solicitante
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Solicitante : "
            .Height    = 15
            .Left      = 81
            .Top       = 115
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Solic", "TextBox")
        WITH loc_oPag2.txt_4c_Solic
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 10
            .Height        = 23
            .Left          = 144
            .Top           = 112
            .Width         = 80
            .Format        = "K!"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Empresa - Codigo (TabIndex=2) e Nome (TabIndex=3)
        * Top original 108 + 29 = 137; label original Top=112 + 29 = 141
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPag2.lbl_4c_Empresa
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Empresa : "
            .Height    = 15
            .Left      = 89
            .Top       = 141
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Cd_Empresa", "TextBox")
        WITH loc_oPag2.txt_4c_Cd_Empresa
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 3
            .Height        = 25
            .Left          = 144
            .Top           = 137
            .Width         = 32
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Ds_Empresa", "TextBox")
        WITH loc_oPag2.txt_4c_Ds_Empresa
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 40
            .Height        = 25
            .Left          = 178
            .Top           = 137
            .Width         = 290
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Operacao (TabIndex=4) - Top original 135 + 29 = 164
        * Label original Top=140 + 29 = 169
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oPag2.lbl_4c_Operacao
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o : "
            .Height    = 15
            .Left      = 83
            .Top       = 169
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Operacao", "TextBox")
        WITH loc_oPag2.txt_4c_Operacao
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 20
            .Height        = 25
            .Left          = 144
            .Top           = 164
            .Width         = 150
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Documento (TabIndex=5) - Top original 162 + 29 = 191
        * Label original Top=165 + 29 = 194
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("lbl_4c_Documento", "Label")
        WITH loc_oPag2.lbl_4c_Documento
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Documento : "
            .Height    = 15
            .Left      = 76
            .Top       = 194
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Doc", "TextBox")
        WITH loc_oPag2.txt_4c_Doc
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0
            .InputMask     = "9999999999"
            .Height        = 23
            .Left          = 144
            .Top           = 191
            .Width         = 80
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Cond. Pagto / Forma Pagamento (TabIndex=6) - Top original 187 + 29 = 216
        * Label original Top=192 + 29 = 221
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("lbl_4c_CondPagto", "Label")
        WITH loc_oPag2.lbl_4c_CondPagto
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Cond. Pagto : "
            .Height    = 15
            .Left      = 70
            .Top       = 221
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Fpg", "TextBox")
        WITH loc_oPag2.txt_4c_Fpg
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 12
            .Height        = 23
            .Left          = 144
            .Top           = 216
            .Width         = 94
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .ToolTipText   = "Digite a forma de pagamento"
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Data (TabIndex=7) - Top original 212 + 29 = 241
        * ReadOnly: When original retorna .F. (campo sempre bloqueado)
        * Label original Top=215 + 29 = 244
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("lbl_4c_Data", "Label")
        WITH loc_oPag2.lbl_4c_Data
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Data : "
            .Height    = 15
            .Left      = 107
            .Top       = 244
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Data", "TextBox")
        WITH loc_oPag2.txt_4c_Data
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = DATETIME()
            .ReadOnly      = .T.
            .Height        = 23
            .Left          = 144
            .Top           = 241
            .Width         = 75
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Valor (TabIndex=8) - Top original 237 + 29 = 266
        * Habilitado apenas em modo !Producao (When = Not Thisform.Producao)
        * Label original Top=240 + 29 = 269
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("lbl_4c_Valor", "Label")
        WITH loc_oPag2.lbl_4c_Valor
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Valor : "
            .Height    = 15
            .Left      = 106
            .Top       = 269
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oPag2.txt_4c_Valor
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0
            .InputMask     = "999,999,999.99"
            .Height        = 23
            .Left          = 144
            .Top           = 266
            .Width         = 100
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Enabled       = !THIS.this_lProducao
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Motivo (TabIndex=9) - Top original 262 + 29 = 291
        * Label original Top=265 + 29 = 294
        *----------------------------------------------------------------------
        loc_oPag2.AddObject("lbl_4c_Motivo", "Label")
        WITH loc_oPag2.lbl_4c_Motivo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Motivo : "
            .Height    = 15
            .Left      = 98
            .Top       = 294
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag2.AddObject("txt_4c_Motivo", "TextBox")
        WITH loc_oPag2.txt_4c_Motivo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .MaxLength     = 40
            .Height        = 23
            .Left          = 144
            .Top           = 291
            .Width         = 360
            .Format        = "K!"
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * BINDEVENTs para lookups (KeyPress: Enter=13, Tab=9, F4=115)
        *----------------------------------------------------------------------
        BINDEVENT(loc_oPag2.txt_4c_Cd_Empresa, "KeyPress", THIS, "TxtCdEmpresaKeyPress")
        BINDEVENT(loc_oPag2.txt_4c_Ds_Empresa, "KeyPress", THIS, "TxtDsEmpresaKeyPress")
        BINDEVENT(loc_oPag2.txt_4c_Operacao,   "KeyPress", THIS, "TxtOperacaoKeyPress")
        BINDEVENT(loc_oPag2.txt_4c_Fpg,        "KeyPress", THIS, "TxtFpgKeyPress")

    ENDPROC

    *==========================================================================
    * BtnBoletoClick - Abre formulario de geracao de boleto (FormSigOpBol)
    * Reproduz logica de Fwbtng1.Click do legado: Do Form SigOpBol With ThisForm,15
    *==========================================================================
    PROCEDURE BtnBoletoClick()
        LOCAL loc_oForm, loc_oErro

        TRY
            loc_oForm = CREATEOBJECT("FormSigOpBol")
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ELSE
                MsgErro("Erro ao criar FormSigOpBol." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao Abrir Boleto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnGeraSenhaClick - Valida campos e gera senha diaria via BO
    * Reproduz logica de GeraSenha.Click do legado (SIGPRSDD.SCX)
    * Usa PEMSTATUS para leitura segura de campos (suporte a execucao parcial)
    *==========================================================================
    PROCEDURE BtnGeraSenhaClick()
        LOCAL loc_oPag2, loc_oBO, loc_cSenha, loc_oErro

        loc_cSenha = ""

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            loc_oBO   = THIS.this_oBusinessObject

            *-- Transferir valores da tela para o BO
            IF PEMSTATUS(loc_oPag2, "txt_4c_Solic", 5)
                loc_oBO.this_cSolicits = ALLTRIM(loc_oPag2.txt_4c_Solic.Value)
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Cd_Empresa", 5)
                loc_oBO.this_cEmps = ALLTRIM(loc_oPag2.txt_4c_Cd_Empresa.Value)
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Operacao", 5)
                loc_oBO.this_cOperas = ALLTRIM(loc_oPag2.txt_4c_Operacao.Value)
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Doc", 5)
                loc_oBO.this_nDocs = IIF(VARTYPE(loc_oPag2.txt_4c_Doc.Value) = "N", ;
                                         loc_oPag2.txt_4c_Doc.Value, 0)
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Fpg", 5)
                loc_oBO.this_cFpags = ALLTRIM(loc_oPag2.txt_4c_Fpg.Value)
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Valor", 5)
                loc_oBO.this_nValors = IIF(VARTYPE(loc_oPag2.txt_4c_Valor.Value) = "N", ;
                                           loc_oPag2.txt_4c_Valor.Value, 0)
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Motivo", 5)
                loc_oBO.this_cMotivos = ALLTRIM(loc_oPag2.txt_4c_Motivo.Value)
            ENDIF

            loc_oBO.this_dDatas    = DATETIME()
            loc_oBO.this_lProducao = THIS.this_lProducao
            loc_oBO.this_nTipos    = IIF(THIS.this_lProducao, 1, 0)

            loc_cSenha = loc_oBO.GeraSenha()

            IF !EMPTY(ALLTRIM(loc_cSenha))
                MsgInfo("Favor Anotar a Senha :" + CHR(13) + CHR(13) + ;
                        loc_cSenha + CHR(13) + CHR(13), "Senha do Dia")
                THIS.CarregarLista()
                THIS.pgf_4c_Paginas.ActivePage = 1
            ELSE
                IF !EMPTY(ALLTRIM(loc_oBO.this_cMensagemErro))
                    MsgAviso(loc_oBO.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao Gerar Senha")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o form
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Lista")
            USE IN cursor_4c_Lista
        ENDIF
        IF USED("cursor_4c_ListaTemp")
            USE IN cursor_4c_ListaTemp
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula campos do formulario a partir das propriedades do BO
    * Usado em Visualizar/Alterar apos CarregarDoCursor
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPag2, loc_oBO, loc_cSQL, loc_nRet, loc_oErro

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            loc_oBO   = THIS.this_oBusinessObject

            IF PEMSTATUS(loc_oPag2, "txt_4c_Solic", 5)
                loc_oPag2.txt_4c_Solic.Value = NVL(loc_oBO.this_cSolicits, "")
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Cd_Empresa", 5)
                loc_oPag2.txt_4c_Cd_Empresa.Value = NVL(loc_oBO.this_cEmps, "")
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Operacao", 5)
                loc_oPag2.txt_4c_Operacao.Value = NVL(loc_oBO.this_cOperas, "")
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Doc", 5)
                loc_oPag2.txt_4c_Doc.Value = NVL(loc_oBO.this_nDocs, 0)
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Fpg", 5)
                loc_oPag2.txt_4c_Fpg.Value = NVL(loc_oBO.this_cFpags, "")
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Data", 5)
                IF VARTYPE(loc_oBO.this_dDatas) = "T" AND !EMPTY(loc_oBO.this_dDatas)
                    loc_oPag2.txt_4c_Data.Value = loc_oBO.this_dDatas
                ELSE
                    loc_oPag2.txt_4c_Data.Value = DATETIME()
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Valor", 5)
                loc_oPag2.txt_4c_Valor.Value = NVL(loc_oBO.this_nValors, 0)
            ENDIF
            IF PEMSTATUS(loc_oPag2, "txt_4c_Motivo", 5)
                loc_oPag2.txt_4c_Motivo.Value = NVL(loc_oBO.this_cMotivos, "")
            ENDIF

            *-- Preencher nome da empresa a partir do codigo
            IF PEMSTATUS(loc_oPag2, "txt_4c_Cd_Empresa", 5) AND ;
               PEMSTATUS(loc_oPag2, "txt_4c_Ds_Empresa", 5) AND ;
               !EMPTY(ALLTRIM(loc_oPag2.txt_4c_Cd_Empresa.Value))

                loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE RTRIM(Cemps) = " + ;
                           EscaparSQL(ALLTRIM(loc_oPag2.txt_4c_Cd_Empresa.Value))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpBO")

                IF loc_nRet > 0 AND USED("cursor_4c_BuscaEmpBO") AND ;
                   RECCOUNT("cursor_4c_BuscaEmpBO") > 0
                    SELECT cursor_4c_BuscaEmpBO
                    loc_oPag2.txt_4c_Ds_Empresa.Value = ALLTRIM(NVL(Razas, ""))
                ENDIF
                IF USED("cursor_4c_BuscaEmpBO")
                    USE IN cursor_4c_BuscaEmpBO
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos do formulario para novo registro
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPag2

        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPag2, "txt_4c_Solic", 5)
            loc_oPag2.txt_4c_Solic.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Cd_Empresa", 5)
            loc_oPag2.txt_4c_Cd_Empresa.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Ds_Empresa", 5)
            loc_oPag2.txt_4c_Ds_Empresa.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Operacao", 5)
            loc_oPag2.txt_4c_Operacao.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Doc", 5)
            loc_oPag2.txt_4c_Doc.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Fpg", 5)
            loc_oPag2.txt_4c_Fpg.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Data", 5)
            loc_oPag2.txt_4c_Data.Value = DATETIME()
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Valor", 5)
            loc_oPag2.txt_4c_Valor.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Motivo", 5)
            loc_oPag2.txt_4c_Motivo.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtCdEmpresaKeyPress - Handler KeyPress para txt_4c_Cd_Empresa
    * Enter(13)/Tab(9)/F4(115): valida codigo ou abre picker
    *==========================================================================
    PROCEDURE TxtCdEmpresaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupEmpresaCodigo()
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresaCodigo - Valida codigo de empresa; abre picker se nao achou
    * SigCdEmp: Cemps char(3) = codigo, Razas char(40) = nome/razao
    *==========================================================================
    PROCEDURE AbrirLookupEmpresaCodigo()
        LOCAL loc_oPag2, loc_cCodigo, loc_cSQL, loc_nRet, loc_oErro

        TRY
            loc_oPag2   = THIS.pgf_4c_Paginas.Page2
            loc_cCodigo = ALLTRIM(loc_oPag2.txt_4c_Cd_Empresa.Value)

            IF EMPTY(loc_cCodigo)
                RETURN
            ENDIF

            loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp " + ;
                       "WHERE RTRIM(Cemps) = " + EscaparSQL(loc_cCodigo)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")

            IF loc_nRet > 0 AND USED("cursor_4c_BuscaEmp") AND ;
               RECCOUNT("cursor_4c_BuscaEmp") > 0
                SELECT cursor_4c_BuscaEmp
                loc_oPag2.txt_4c_Cd_Empresa.Value = ALLTRIM(NVL(Cemps, ""))
                loc_oPag2.txt_4c_Ds_Empresa.Value = ALLTRIM(NVL(Razas, ""))
            ELSE
                THIS.AbrirLookupEmpresaNomePicker()
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Lookup Empresa C" + CHR(243) + "digo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtDsEmpresaKeyPress - Handler KeyPress para txt_4c_Ds_Empresa
    * Enter(13)/Tab(9)/F4(115): abre picker de empresa por nome
    *==========================================================================
    PROCEDURE TxtDsEmpresaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupEmpresaNomePicker()
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresaNomePicker - Abre FormBuscaAuxiliar para selecao de empresa
    * Substitui fAcessoEmpresa(Usuar,'D',...) do legado (funcao nao portada)
    * SigCdEmp: Cemps (cod char 3), Razas (nome char 40)
    *==========================================================================
    PROCEDURE AbrirLookupEmpresaNomePicker()
        LOCAL loc_oPag2, loc_cFiltro, loc_oBusca, loc_oErro

        TRY
            loc_oPag2   = THIS.pgf_4c_Paginas.Page2
            loc_cFiltro = ALLTRIM(loc_oPag2.txt_4c_Ds_Empresa.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmp", ;
                "Cemps", ;
                loc_cFiltro, ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa")

            loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Empresa")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                SELECT cursor_4c_BuscaEmp
                loc_oPag2.txt_4c_Cd_Empresa.Value = ALLTRIM(NVL(Cemps, ""))
                loc_oPag2.txt_4c_Ds_Empresa.Value = ALLTRIM(NVL(Razas, ""))
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Lookup Empresa Nome")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtOperacaoKeyPress - Handler KeyPress para txt_4c_Operacao
    * Enter(13)/Tab(9)/F4(115): abre picker de operacao
    * Modo Producao: SigCdOpd (campo Dopps)
    * Modo Simulacao: SigCdOpe (campo Dopes) - single-column, sem descrs!
    *==========================================================================
    PROCEDURE TxtOperacaoKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupOperacao()
    ENDPROC

    *==========================================================================
    * AbrirLookupOperacao - Abre FormBuscaAuxiliar para selecao de operacao
    * SigCdOpd: Dopps (producao) | SigCdOpe: Dopes (simulacao)
    * ATENCAO: ambas tabelas sao single-column (sem coluna descrs separada)
    *==========================================================================
    PROCEDURE AbrirLookupOperacao()
        LOCAL loc_oPag2, loc_cTabela, loc_cCampo, loc_cCaption, loc_cFiltro
        LOCAL loc_oBusca, loc_oErro

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            IF THIS.this_lProducao
                loc_cTabela  = "SigCdOpd"
                loc_cCampo   = "Dopps"
                loc_cCaption = "Opera" + CHR(231) + CHR(227) + "o (Produ" + CHR(231) + CHR(227) + "o)"
            ELSE
                loc_cTabela  = "SigCdOpe"
                loc_cCampo   = "Dopes"
                loc_cCaption = "Opera" + CHR(231) + CHR(227) + "o (Simula" + CHR(231) + CHR(227) + "o)"
            ENDIF

            loc_cFiltro = ALLTRIM(loc_oPag2.txt_4c_Operacao.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                loc_cTabela, ;
                "cursor_4c_BuscaOp", ;
                loc_cCampo, ;
                loc_cFiltro, ;
                loc_cCaption)

            loc_oBusca.mAddColuna(loc_cCampo, "", "Opera" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOp")
                SELECT cursor_4c_BuscaOp
                IF THIS.this_lProducao
                    loc_oPag2.txt_4c_Operacao.Value = ALLTRIM(NVL(Dopps, ""))
                ELSE
                    loc_oPag2.txt_4c_Operacao.Value = ALLTRIM(NVL(Dopes, ""))
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaOp")
                USE IN cursor_4c_BuscaOp
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Lookup Opera" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtFpgKeyPress - Handler KeyPress para txt_4c_Fpg (Forma Pagamento)
    * Enter(13)/Tab(9)/F4(115): abre picker de forma de pagamento
    *==========================================================================
    PROCEDURE TxtFpgKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupFpg()
    ENDPROC

    *==========================================================================
    * AbrirLookupFpg - Abre FormBuscaAuxiliar para selecao de Forma de Pagamento
    * SigOpFp: Fpags (cod), Descrs (desc), MoeFPgs (moeda), FParcs (#)
    *==========================================================================
    PROCEDURE AbrirLookupFpg()
        LOCAL loc_oPag2, loc_cFiltro, loc_oBusca, loc_oErro

        TRY
            loc_oPag2   = THIS.pgf_4c_Paginas.Page2
            loc_cFiltro = ALLTRIM(loc_oPag2.txt_4c_Fpg.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpFp", ;
                "cursor_4c_BuscaFpg", ;
                "Fpags", ;
                loc_cFiltro, ;
                "Forma de Pagamento")

            loc_oBusca.mAddColuna("Fpags",   "XXXXXXXXXXXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("MoeFPgs", "XXXXX", "Moeda")
            loc_oBusca.mAddColuna("FParcs",  "99", "#")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
                SELECT cursor_4c_BuscaFpg
                loc_oPag2.txt_4c_Fpg.Value = ALLTRIM(NVL(Fpags, ""))
            ENDIF

            IF USED("cursor_4c_BuscaFpg")
                USE IN cursor_4c_BuscaFpg
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Lookup Forma Pagamento")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do formulario para o BO
    * Chamado antes de salvar (Inserir/Atualizar)
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPag2, loc_oBO

        loc_oPag2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO   = THIS.this_oBusinessObject

        IF PEMSTATUS(loc_oPag2, "txt_4c_Solic", 5)
            loc_oBO.this_cSolicits = ALLTRIM(loc_oPag2.txt_4c_Solic.Value)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Cd_Empresa", 5)
            loc_oBO.this_cEmps = ALLTRIM(loc_oPag2.txt_4c_Cd_Empresa.Value)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Operacao", 5)
            loc_oBO.this_cOperas = ALLTRIM(loc_oPag2.txt_4c_Operacao.Value)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Doc", 5)
            loc_oBO.this_nDocs = IIF(VARTYPE(loc_oPag2.txt_4c_Doc.Value) = "N", ;
                                     loc_oPag2.txt_4c_Doc.Value, 0)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Fpg", 5)
            loc_oBO.this_cFpags = ALLTRIM(loc_oPag2.txt_4c_Fpg.Value)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Valor", 5)
            loc_oBO.this_nValors = IIF(VARTYPE(loc_oPag2.txt_4c_Valor.Value) = "N", ;
                                       loc_oPag2.txt_4c_Valor.Value, 0)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Motivo", 5)
            loc_oBO.this_cMotivos = ALLTRIM(loc_oPag2.txt_4c_Motivo.Value)
        ENDIF

        loc_oBO.this_dDatas    = DATETIME()
        loc_oBO.this_lProducao = THIS.this_lProducao
        loc_oBO.this_nTipos    = IIF(THIS.this_lProducao, 1, 0)
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva alteracoes no modo ALTERAR; no INCLUIR delega
    *                  para BtnGeraSenhaClick (geracao completa de senha)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF THIS.this_cModoAtual = "INCLUIR"
                THIS.BtnGeraSenhaClick()
            ELSE
                IF THIS.this_cModoAtual = "ALTERAR"
                THIS.FormParaBO()

                IF THIS.this_oBusinessObject.ValidarDados()
                    loc_lSucesso = THIS.this_oBusinessObject.Atualizar()

                    IF loc_lSucesso
                        MsgInfo("Registro atualizado com sucesso.", "Sucesso")
                        THIS.this_cModoAtual = "LISTA"
                        THIS.AlternarPagina(1)
                    ELSE
                        IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro))
                            MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                                     "Valida" + CHR(231) + CHR(227) + "o")
                        ENDIF
                    ENDIF
                ELSE
                    IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro))
                        MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                                 "Valida" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao Salvar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo atual
    * INCLUIR/ALTERAR: editavel | VISUALIZAR: somente leitura
    *==========================================================================
    PROCEDURE HabilitarCampos(par_cModo)
        LOCAL loc_oPag2, loc_lHabilitar

        loc_oPag2      = THIS.pgf_4c_Paginas.Page2
        loc_lHabilitar = (par_cModo = "INCLUIR" OR par_cModo = "ALTERAR")

        IF PEMSTATUS(loc_oPag2, "txt_4c_Solic", 5)
            loc_oPag2.txt_4c_Solic.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Cd_Empresa", 5)
            loc_oPag2.txt_4c_Cd_Empresa.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Ds_Empresa", 5)
            loc_oPag2.txt_4c_Ds_Empresa.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Operacao", 5)
            loc_oPag2.txt_4c_Operacao.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Doc", 5)
            loc_oPag2.txt_4c_Doc.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Fpg", 5)
            loc_oPag2.txt_4c_Fpg.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Valor", 5)
            loc_oPag2.txt_4c_Valor.ReadOnly = (!loc_lHabilitar OR THIS.this_lProducao)
        ENDIF
        IF PEMSTATUS(loc_oPag2, "txt_4c_Motivo", 5)
            loc_oPag2.txt_4c_Motivo.ReadOnly = !loc_lHabilitar
        ENDIF

        *-- Controla visibilidade dos containers de botoes na Page2
        *-- Modo INCLUIR/ALTERAR: mostra BotoesAcao (GeraSenha/Boleto)
        *-- Modo VISUALIZAR: oculta BotoesAcao
        IF PEMSTATUS(loc_oPag2, "cnt_4c_BotoesAcao", 5)
            loc_oPag2.cnt_4c_BotoesAcao.Visible = loc_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado habilitado dos botoes da lista (Page1)
    * Visualizar/Alterar/Excluir apenas habilitados se ha registro selecionado
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPag1, loc_lTemRegistro

        loc_oPag1        = THIS.pgf_4c_Paginas.Page1
        loc_lTemRegistro = USED("cursor_4c_Lista") AND RECCOUNT("cursor_4c_Lista") > 0

        IF PEMSTATUS(loc_oPag1, "cnt_4c_Botoes", 5)
            WITH loc_oPag1.cnt_4c_Botoes
                IF PEMSTATUS(.cmd_4c_Incluir, "Enabled", 5)
                    .cmd_4c_Incluir.Enabled    = .T.
                ENDIF
                IF PEMSTATUS(.cmd_4c_Visualizar, "Enabled", 5)
                    .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
                ENDIF
                IF PEMSTATUS(.cmd_4c_Alterar, "Enabled", 5)
                    .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
                ENDIF
                IF PEMSTATUS(.cmd_4c_Excluir, "Enabled", 5)
                    .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
                ENDIF
                IF PEMSTATUS(.cmd_4c_Buscar, "Enabled", 5)
                    .cmd_4c_Buscar.Enabled     = .T.
                ENDIF
                .Visible     = .T.
            ENDWITH
        ENDIF
    ENDPROC

ENDDEFINE
