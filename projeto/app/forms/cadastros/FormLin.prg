*==============================================================================
* FormLin.prg - Cadastro de Linhas de Producao
* Migrado de: SIGCDLIN.SCX
* Tabelas: SigCdLin (principal), SigCdLnf (Fases), SigCdLni (Composicao), SigPrPrc (Comp.Obrig.)
*==============================================================================

DEFINE CLASS FormLin AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height          = 600
    Width           = 1000
    Caption         = "Cadastro de Linhas"
    AutoCenter      = .T.
    ShowWindow      = 1
    WindowType      = 1
    ControlBox      = .F.
    TitleBar        = 0
    Themes          = .F.
    BorderStyle     = 2
    FontName        = "Tahoma"
    FontSize        = 8

    *-- Propriedades de negocio
    this_oBusinessObject    = .NULL.
    this_cModoAtual         = "LISTA"
    this_nBusca             = 1

    *==========================================================================
    * Init - Inicializa o formulario
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("LinBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar LinBO" + CHR(13) + "VARTYPE retornou: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "Inicializa" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "FormLin.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria o PageFrame externo (Page1=Lista, Page2=Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .PageCount      = 2
                .Top            = -29
                .Left           = 0
                .Width          = THIS.Width
                .Height         = THIS.Height + 29
                .Tabs           = .F.
                .Visible        = .T.
                .Page1.Caption  = "Lista"
                .Page2.Caption  = "Dados"
                .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            ENDWITH
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho + containers (grid/botoes na Fase 4)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Cabecalho cinza superior
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Caption    = "Cadastro de Linhas"
                    .Top        = 15
                    .Left       = 12
                    .Width      = THIS.Width
                    .Height     = 40
                    .FontName   = "Tahoma"
                    .FontSize   = 16
                    .FontBold   = .T.
                    .ForeColor  = RGB(0, 0, 0)
                    .BackStyle  = 0
                    .AutoSize   = .F.
                    .Visible    = .T.
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Caption    = "Cadastro de Linhas"
                    .Top        = 18
                    .Left       = 10
                    .Width      = THIS.Width
                    .Height     = 46
                    .FontName   = "Tahoma"
                    .FontSize   = 16
                    .FontBold   = .T.
                    .ForeColor  = RGB(255, 255, 255)
                    .BackStyle  = 0
                    .AutoSize   = .F.
                    .Visible    = .T.
                ENDWITH
            ENDWITH

            *-- Container botoes CRUD (canonico: Left=542, lado direito)
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
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                    .PicturePosition = 13
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
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                    .PicturePosition = 13
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
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                    .PicturePosition = 13
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
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .PicturePosition = 13
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
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .PicturePosition = 13
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

            *-- Container Encerrar (padrao canonico - Left=917, Width=90)
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
                    .Top             = 5
                    .Left            = 917
                    .Width           = 90
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
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

            *-- Grid de listagem (SigCdLin: Linhas + Descs)
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            loc_oPagina.grd_4c_Lista.ColumnCount = 2
            WITH loc_oPagina.grd_4c_Lista
                .Top                = 117
                .Left               = 26
                .Width              = 890
                .Height             = 498
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .RowHeight          = 16
                .ScrollBars         = 2
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .Visible            = .T.
                .Column1.Width               = 120
                .Column1.Header1.Caption     = ""
                .Column2.Width               = 770
                .Column2.Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

            THIS.TornarControlesVisiveis(loc_oPagina)
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar + PageFrame interno
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Container botoes Confirmar/Cancelar (Top=4+29=33)
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 33
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Confirmar", "CommandButton")
                WITH .cmd_4c_Confirmar
                    .Caption         = "Confirmar"
                    .Top             = 5
                    .Left            = 5
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .PicturePosition = 13
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
                    .Top             = 5
                    .Left            = 80
                    .Width           = 75
                    .Height          = 75
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .PicturePosition = 13
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

            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            *-- PageFrame interno com 3 abas: Geral | Fases | Composicao
            *-- Top = 121 (original) + 29 (compensacao outer PF) = 150
            *-- Left = -4, Width = 1007 (original - cobre largura total com overlap minimo)
            loc_oPagina.AddObject("pgf_4c_Abas", "PageFrame")
            WITH loc_oPagina.pgf_4c_Abas
                .PageCount      = 3
                .Top            = 150
                .Left           = -4
                .Width          = 1007
                .Height         = 483
                .Tabs           = .T.
                .Visible        = .T.
                .Page1.Caption  = "Geral"
                .Page2.Caption  = "Fases"
                .Page3.Caption  = "Composi" + CHR(231) + CHR(227) + "o"
            ENDWITH

            THIS.ConfigurarAbaGeral()
            THIS.ConfigurarAbaFases()
            THIS.ConfigurarAbaComposicao()
            THIS.TornarControlesVisiveis(loc_oPagina)
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no cursor_4c_Dados (grid configurado na Fase 4)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (Linhas C(10), Descs C(40), TpCustos C(1), TpVendas C(1))
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    IF VARTYPE(loc_oGrid) = "O"
                        loc_oGrid.ColumnCount = 2
                        loc_oGrid.RecordSource          = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Linhas"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descs"
                        loc_oGrid.Column1.Header1.Caption = ""
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva o registro atual (logica completa na Fase 7)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF

            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Confirma" + CHR(231) + CHR(227) + "o")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao salvar o registro.", "FormLin.BtnSalvarClick")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara novo registro e navega para Page2
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.InicializarCursoresDetalhe()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.AjustarBotoesPorModo()
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cLinhas
        loc_cLinhas = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cLinhas = ALLTRIM(cursor_4c_Dados.Linhas)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLinhas)
                THIS.BOParaForm()
                THIS.CarregarAbasDetalhe(loc_cLinhas)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(2)
                THIS.AjustarBotoesPorModo()
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cLinhas
        loc_cLinhas = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cLinhas = ALLTRIM(cursor_4c_Dados.Linhas)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLinhas)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.CarregarAbasDetalhe(loc_cLinhas)
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina(2)
                THIS.AjustarBotoesPorModo()
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "Alterar")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cLinhas
        loc_cLinhas = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cLinhas = ALLTRIM(cursor_4c_Dados.Linhas)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da linha '" + loc_cLinhas + "'?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLinhas)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
                            "Exclus" + CHR(227) + "o")
                    THIS.CarregarLista()
                ELSE
                    MsgErro("Erro ao excluir o registro.", "FormLin.BtnExcluirClick")
                ENDIF
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "Excluir")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre busca auxiliar para localizar linha na grade
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cLinhas
        loc_cLinhas = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdLin", "cursor_4c_BuscaLin", "Linhas", "", ;
                "Buscar Linha de Produ" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Linhas", "", "Linha")
                loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
                    SELECT cursor_4c_BuscaLin
                    loc_cLinhas = ALLTRIM(cursor_4c_BuscaLin.Linhas)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaLin")
            USE IN cursor_4c_BuscaLin
        ENDIF

        IF !EMPTY(loc_cLinhas) AND USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(Linhas) = loc_cLinhas
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCampos - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarCampos()
        LOCAL loc_lValido, loc_oPg1
        loc_lValido = .T.

        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1

            IF VARTYPE(loc_oPg1) = "O" AND ;
               PEMSTATUS(loc_oPg1, "txt_4c_Linhas", 5)
                IF EMPTY(ALLTRIM(loc_oPg1.txt_4c_Linhas.Value))
                    MsgAviso("Linha de Produ" + CHR(231) + CHR(227) + "o obrigat" + ;
                             CHR(243) + "ria!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oPg1.txt_4c_Linhas.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF

            IF loc_lValido AND VARTYPE(loc_oPg1) = "O" AND ;
               PEMSTATUS(loc_oPg1, "txt_4c_Descs", 5)
                IF EMPTY(ALLTRIM(loc_oPg1.txt_4c_Descs.Value))
                    MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + ;
                             CHR(243) + "ria!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oPg1.txt_4c_Descs.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.ValidarCampos")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do Form para o BO (completo na Fase 7)
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg1
        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
            IF VARTYPE(loc_oPg1) = "O"
                IF PEMSTATUS(loc_oPg1, "txt_4c_Linhas", 5)
                    THIS.this_oBusinessObject.this_cLinhas = ALLTRIM(loc_oPg1.txt_4c_Linhas.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_Descs", 5)
                    THIS.this_oBusinessObject.this_cDescs = ALLTRIM(loc_oPg1.txt_4c_Descs.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_Pedidos", 5)
                    THIS.this_oBusinessObject.this_cPedidos = ALLTRIM(loc_oPg1.txt_4c_Pedidos.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_TpCustos", 5)
                    THIS.this_oBusinessObject.this_cTpCustos = ALLTRIM(loc_oPg1.txt_4c_TpCustos.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_TpVendas", 5)
                    THIS.this_oBusinessObject.this_cTpVendas = ALLTRIM(loc_oPg1.txt_4c_TpVendas.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_TpPesos", 5)
                    THIS.this_oBusinessObject.this_cTpPesos = ALLTRIM(loc_oPg1.txt_4c_TpPesos.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_AnaPes", 5)
                    THIS.this_oBusinessObject.this_nChkPesags = ALLTRIM(loc_oPg1.txt_4c_AnaPes.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_QtPcs", 5)
                    THIS.this_oBusinessObject.this_nQtPcs = loc_oPg1.txt_4c_QtPcs.Value
                ENDIF
                IF PEMSTATUS(loc_oPg1, "opt_4c_Bonus", 5)
                    THIS.this_oBusinessObject.this_nBonus = loc_oPg1.opt_4c_Bonus.Value
                ENDIF
                IF PEMSTATUS(loc_oPg1, "opt_4c_Preco", 5)
                    THIS.this_oBusinessObject.this_nVlrFixos = loc_oPg1.opt_4c_Preco.Value
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para o Form (completo na Fase 7)
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg1
        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
            IF VARTYPE(loc_oPg1) = "O"
                IF PEMSTATUS(loc_oPg1, "txt_4c_Linhas", 5)
                    loc_oPg1.txt_4c_Linhas.Value  = THIS.this_oBusinessObject.this_cLinhas
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_Descs", 5)
                    loc_oPg1.txt_4c_Descs.Value   = THIS.this_oBusinessObject.this_cDescs
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_Pedidos", 5)
                    loc_oPg1.txt_4c_Pedidos.Value = THIS.this_oBusinessObject.this_cPedidos
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_TpCustos", 5)
                    loc_oPg1.txt_4c_TpCustos.Value = THIS.this_oBusinessObject.this_cTpCustos
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_TpVendas", 5)
                    loc_oPg1.txt_4c_TpVendas.Value = THIS.this_oBusinessObject.this_cTpVendas
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_TpPesos", 5)
                    loc_oPg1.txt_4c_TpPesos.Value = THIS.this_oBusinessObject.this_cTpPesos
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_AnaPes", 5)
                    loc_oPg1.txt_4c_AnaPes.Value  = TRANSFORM(THIS.this_oBusinessObject.this_nChkPesags)
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_QtPcs", 5)
                    loc_oPg1.txt_4c_QtPcs.Value   = THIS.this_oBusinessObject.this_nQtPcs
                ENDIF
                IF PEMSTATUS(loc_oPg1, "opt_4c_Bonus", 5)
                    loc_oPg1.opt_4c_Bonus.Value   = THIS.this_oBusinessObject.this_nBonus
                ENDIF
                IF PEMSTATUS(loc_oPg1, "opt_4c_Preco", 5)
                    loc_oPg1.opt_4c_Preco.Value   = THIS.this_oBusinessObject.this_nVlrFixos
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos do formulario de dados
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg1
        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
            IF VARTYPE(loc_oPg1) = "O"
                IF PEMSTATUS(loc_oPg1, "txt_4c_Linhas", 5)
                    loc_oPg1.txt_4c_Linhas.Value  = ""
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_Descs", 5)
                    loc_oPg1.txt_4c_Descs.Value   = ""
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_Pedidos", 5)
                    loc_oPg1.txt_4c_Pedidos.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_TpCustos", 5)
                    loc_oPg1.txt_4c_TpCustos.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_TpVendas", 5)
                    loc_oPg1.txt_4c_TpVendas.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_TpPesos", 5)
                    loc_oPg1.txt_4c_TpPesos.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_AnaPes", 5)
                    loc_oPg1.txt_4c_AnaPes.Value  = ""
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_QtPcs", 5)
                    loc_oPg1.txt_4c_QtPcs.Value   = 0
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg1, loc_lModoIncluir
        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
            loc_lModoIncluir = (THIS.this_cModoAtual = "INCLUIR")

            IF VARTYPE(loc_oPg1) = "O"
                IF PEMSTATUS(loc_oPg1, "txt_4c_Linhas", 5)
                    loc_oPg1.txt_4c_Linhas.ReadOnly  = !loc_lModoIncluir
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_Descs", 5)
                    loc_oPg1.txt_4c_Descs.ReadOnly   = !par_lHabilitar
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_Pedidos", 5)
                    loc_oPg1.txt_4c_Pedidos.ReadOnly = !par_lHabilitar
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_TpCustos", 5)
                    loc_oPg1.txt_4c_TpCustos.ReadOnly = !par_lHabilitar
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_TpVendas", 5)
                    loc_oPg1.txt_4c_TpVendas.ReadOnly = !par_lHabilitar
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_TpPesos", 5)
                    loc_oPg1.txt_4c_TpPesos.ReadOnly = !par_lHabilitar
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_AnaPes", 5)
                    loc_oPg1.txt_4c_AnaPes.ReadOnly = !par_lHabilitar
                ENDIF
                IF PEMSTATUS(loc_oPg1, "txt_4c_QtPcs", 5)
                    loc_oPg1.txt_4c_QtPcs.ReadOnly = !par_lHabilitar
                ENDIF
                IF PEMSTATUS(loc_oPg1, "opt_4c_Bonus", 5)
                    loc_oPg1.opt_4c_Bonus.Enabled = par_lHabilitar
                ENDIF
                IF PEMSTATUS(loc_oPg1, "opt_4c_Preco", 5)
                    loc_oPg1.opt_4c_Preco.Enabled = par_lHabilitar
                ENDIF
                IF PEMSTATUS(loc_oPg1, "cmd_4c_CmdgFigura", 5)
                    loc_oPg1.cmd_4c_CmdgFigura.Enabled = par_lHabilitar
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme o modo
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lModoLista
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_lModoLista = (THIS.this_cModoAtual = "LISTA")

            IF VARTYPE(loc_oCnt) = "O"
                IF PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
                    loc_oCnt.cmd_4c_Incluir.Enabled    = loc_lModoLista
                ENDIF
                IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
                    loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lModoLista
                ENDIF
                IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
                    loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lModoLista
                ENDIF
                IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
                    loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lModoLista
                ENDIF
                IF PEMSTATUS(loc_oCnt, "cmd_4c_Buscar", 5)
                    loc_oCnt.cmd_4c_Buscar.Enabled     = loc_lModoLista
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo; torna todos os controles visiveis
    *==========================================================================
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

    *==========================================================================
    * ConfigurarAbaGeral - Aba "Geral" do pgf_4c_Abas - primeira metade dos campos
    *   Campos: Linhas, Descs, Pedidos, TpCustos, TpVendas, AnaPes (+ labels/hints)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaGeral()
        LOCAL loc_oAba
        TRY
            loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1

            *-- Linha (PK - top=29, label top=34)
            loc_oAba.AddObject("lbl_4c_LabelLinha", "Label")
            WITH loc_oAba.lbl_4c_LabelLinha
                .Caption   = "Linha :"
                .Top       = 34
                .Left      = 208
                .Width     = 34
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("txt_4c_Linhas", "TextBox")
            WITH loc_oAba.txt_4c_Linhas
                .Value     = ""
                .Top       = 29
                .Left      = 247
                .Width     = 79
                .Height    = 25
                .MaxLength = 10
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Descricao (top=57, label top=62)
            loc_oAba.AddObject("lbl_4c_LabelDescricao", "Label")
            WITH loc_oAba.lbl_4c_LabelDescricao
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top       = 62
                .Left      = 187
                .Width     = 55
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("txt_4c_Descs", "TextBox")
            WITH loc_oAba.txt_4c_Descs
                .Value     = ""
                .Top       = 57
                .Left      = 247
                .Width     = 289
                .Height    = 25
                .MaxLength = 50
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Pedido de Estoque Minimo (top=84, label top=88) - lookup SigCdOpe
            loc_oAba.AddObject("lbl_4c_LabelPedido", "Label")
            WITH loc_oAba.lbl_4c_LabelPedido
                .Caption   = "Pedido de Estoque M" + CHR(237) + "nimo :"
                .Top       = 88
                .Left      = 109
                .Width     = 133
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("txt_4c_Pedidos", "TextBox")
            WITH loc_oAba.txt_4c_Pedidos
                .Value     = ""
                .Top       = 84
                .Left      = 247
                .Width     = 151
                .Height    = 23
                .MaxLength = 5
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Tipo de Custo [1]=Unitario [2]=Por Peso (top=110, label top=114)
            loc_oAba.AddObject("lbl_4c_LabelTpCusto", "Label")
            WITH loc_oAba.lbl_4c_LabelTpCusto
                .Caption   = "Tipo de Custo :"
                .Top       = 114
                .Left      = 167
                .Width     = 75
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("txt_4c_TpCustos", "TextBox")
            WITH loc_oAba.txt_4c_TpCustos
                .Value     = ""
                .Top       = 110
                .Left      = 247
                .Width     = 20
                .Height    = 23
                .MaxLength = 1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("lbl_4c_HintTpCusto", "Label")
            WITH loc_oAba.lbl_4c_HintTpCusto
                .Caption   = "[1] Unit" + CHR(225) + "rio  [2] Por Peso"
                .Top       = 114
                .Left      = 274
                .Width     = 118
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Tipo de Venda [1]=Unitario [2]=Por Peso (top=136, label top=140)
            loc_oAba.AddObject("lbl_4c_LabelTpVenda", "Label")
            WITH loc_oAba.lbl_4c_LabelTpVenda
                .Caption   = "Tipo de Venda :"
                .Top       = 140
                .Left      = 165
                .Width     = 75
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("txt_4c_TpVendas", "TextBox")
            WITH loc_oAba.txt_4c_TpVendas
                .Value     = ""
                .Top       = 136
                .Left      = 247
                .Width     = 20
                .Height    = 23
                .MaxLength = 1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("lbl_4c_HintTpVenda", "Label")
            WITH loc_oAba.lbl_4c_HintTpVenda
                .Caption   = "[1] Unit" + CHR(225) + "rio  [2] Por Peso"
                .Top       = 140
                .Left      = 274
                .Width     = 118
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Analisa Pesagem [1]=Sim [2]=Nao (top=162, label top=166)
            loc_oAba.AddObject("lbl_4c_LabelAnaPes", "Label")
            WITH loc_oAba.lbl_4c_LabelAnaPes
                .Caption   = "Analisa Pesagem :"
                .Top       = 166
                .Left      = 153
                .Width     = 87
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("txt_4c_AnaPes", "TextBox")
            WITH loc_oAba.txt_4c_AnaPes
                .Value     = ""
                .Top       = 162
                .Left      = 247
                .Width     = 20
                .Height    = 23
                .MaxLength = 1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("lbl_4c_HintAnaPes", "Label")
            WITH loc_oAba.lbl_4c_HintAnaPes
                .Caption   = "[1] Sim  [2] N" + CHR(227) + "o"
                .Top       = 166
                .Left      = 274
                .Width     = 74
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Tipo de Peso [1]=Normal [2]=Imagem Total (original top=188, label top=192)
            loc_oAba.AddObject("lbl_4c_LabelTpPeso", "Label")
            WITH loc_oAba.lbl_4c_LabelTpPeso
                .Caption   = "Tipo de Peso :"
                .Top       = 192
                .Left      = 172
                .Width     = 70
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("txt_4c_TpPesos", "TextBox")
            WITH loc_oAba.txt_4c_TpPesos
                .Value     = ""
                .Top       = 188
                .Left      = 247
                .Width     = 20
                .Height    = 23
                .MaxLength = 1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("lbl_4c_HintTpPeso", "Label")
            WITH loc_oAba.lbl_4c_HintTpPeso
                .Caption   = "[1] Normal  [2] Imagem Total"
                .Top       = 192
                .Left      = 274
                .Width     = 137
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Qtd Pecas por OF (original top=214, label top=218)
            loc_oAba.AddObject("lbl_4c_LabelQtPcs", "Label")
            WITH loc_oAba.lbl_4c_LabelQtPcs
                .Caption   = "Qtd Pe" + CHR(231) + "as por OF :"
                .Top       = 218
                .Left      = 148
                .Width     = 94
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("txt_4c_QtPcs", "TextBox")
            WITH loc_oAba.txt_4c_QtPcs
                .Value     = 0
                .Top       = 214
                .Left      = 247
                .Width     = 58
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Bonus OptionGroup (original top=239, label top=242)
            loc_oAba.AddObject("lbl_4c_LabelBonus", "Label")
            WITH loc_oAba.lbl_4c_LabelBonus
                .Caption   = "B" + CHR(244) + "nus :"
                .Top       = 242
                .Left      = 204
                .Width     = 38
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("opt_4c_Bonus", "OptionGroup")
            WITH loc_oAba.opt_4c_Bonus
                .ButtonCount = 2
                .Top         = 239
                .Left        = 243
                .Width       = 90
                .Height      = 20
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 2
                .Visible     = .T.
            ENDWITH
            WITH loc_oAba.opt_4c_Bonus.Buttons(1)
                .Caption  = "Sim"
                .BackStyle = 0
                .Left     = 5
                .Top      = 3
                .Width    = 35
                .AutoSize = .F.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH loc_oAba.opt_4c_Bonus.Buttons(2)
                .Caption  = "N" + CHR(227) + "o"
                .BackStyle = 0
                .Left     = 42
                .Top      = 3
                .Width    = 38
                .AutoSize = .F.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Preco Fixo SubNivel por Operacao OptionGroup (original top=261, label top=264)
            loc_oAba.AddObject("lbl_4c_LabelPreco", "Label")
            WITH loc_oAba.lbl_4c_LabelPreco
                .Caption   = "Pre" + CHR(231) + "o Fixo SubN" + CHR(237) + "vel / Opera" + CHR(231) + CHR(227) + "o :"
                .Top       = 264
                .Left      = 55
                .Width     = 187
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("opt_4c_Preco", "OptionGroup")
            WITH loc_oAba.opt_4c_Preco
                .ButtonCount = 2
                .Top         = 261
                .Left        = 243
                .Width       = 90
                .Height      = 20
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 2
                .Visible     = .T.
            ENDWITH
            WITH loc_oAba.opt_4c_Preco.Buttons(1)
                .Caption  = "Sim"
                .BackStyle = 0
                .Left     = 5
                .Top      = 3
                .Width    = 35
                .AutoSize = .F.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH loc_oAba.opt_4c_Preco.Buttons(2)
                .Caption  = "N" + CHR(227) + "o"
                .BackStyle = 0
                .Left     = 42
                .Top      = 3
                .Width    = 38
                .AutoSize = .F.
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Area de imagem da linha tecnica (Shape + Image + Botao selecionar)
            loc_oAba.AddObject("shp_4c_Figura", "Shape")
            WITH loc_oAba.shp_4c_Figura
                .Top           = 26
                .Left          = 598
                .Width         = 320
                .Height        = 193
                .FillStyle     = 1
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            loc_oAba.AddObject("img_4c_FigTec", "Image")
            WITH loc_oAba.img_4c_FigTec
                .Top     = 27
                .Left    = 599
                .Width   = 318
                .Height  = 191
                .Stretch = 2
                .Visible = .T.
            ENDWITH

            loc_oAba.AddObject("cmd_4c_CmdgFigura", "CommandButton")
            WITH loc_oAba.cmd_4c_CmdgFigura
                .Caption         = ""
                .Top             = 180
                .Left            = 923
                .Width           = 40
                .Height          = 40
                .PicturePosition = 4
                .BackColor       = RGB(240, 240, 240)
                .Themes          = .T.
                .SpecialEffect   = 0
                .ToolTipText     = "Selecionar Imagem"
                .Visible         = .T.
            ENDWITH

            BINDEVENT(loc_oAba.txt_4c_Pedidos,      "KeyPress", THIS, "ValidarOperacao")
            BINDEVENT(loc_oAba.txt_4c_TpCustos,     "KeyPress", THIS, "ValidarTpCusto")
            BINDEVENT(loc_oAba.txt_4c_TpVendas,     "KeyPress", THIS, "ValidarTpVenda")
            BINDEVENT(loc_oAba.txt_4c_AnaPes,       "KeyPress", THIS, "ValidarAnaPes")
            BINDEVENT(loc_oAba.txt_4c_TpPesos,      "KeyPress", THIS, "ValidarTpPeso")
            BINDEVENT(loc_oAba.cmd_4c_CmdgFigura,   "Click",     THIS, "CmdgFiguraClick")

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.ConfigurarAbaGeral")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarOperacao - Lookup em SigCdOpe para campo Pedido de Estoque Minimo
    *==========================================================================
    PROCEDURE ValidarOperacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDopes, loc_oBusca
        loc_cDopes = ""

        TRY
            loc_cDopes = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_Pedidos.Value)
            IF EMPTY(loc_cDopes)
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", loc_cDopes, ;
                "Selecionar Opera" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dopes",  "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("NDopes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                        SELECT cursor_4c_BuscaOpe
                        THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_Pedidos.Value = ;
                            ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                    ELSE
                        THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_Pedidos.Value = ""
                    ENDIF
                ELSE
                    IF USED("cursor_4c_BuscaOpe")
                        SELECT cursor_4c_BuscaOpe
                        THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_Pedidos.Value = ;
                            ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.ValidarOperacao")
        ENDTRY

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarTpCusto - Valida tipo de custo (deve ser "1" ou "2")
    *==========================================================================
    PROCEDURE ValidarTpCusto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        TRY
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_TpCustos.Value)
            IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "1", "2")
                MsgAviso("Op" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida! Use [1] ou [2].", ;
                         "Tipo de Custo")
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_TpCustos.Value = ""
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_TpCustos.SetFocus()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.ValidarTpCusto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarTpVenda - Valida tipo de venda (deve ser "1" ou "2")
    *==========================================================================
    PROCEDURE ValidarTpVenda(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        TRY
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_TpVendas.Value)
            IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "1", "2")
                MsgAviso("Op" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida! Use [1] ou [2].", ;
                         "Tipo de Venda")
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_TpVendas.Value = ""
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_TpVendas.SetFocus()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.ValidarTpVenda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarAnaPes - Valida analisa pesagem (deve ser "1" ou "2")
    *==========================================================================
    PROCEDURE ValidarAnaPes(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        TRY
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_AnaPes.Value)
            IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "1", "2")
                MsgAviso("Op" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida! Use [1] ou [2].", ;
                         "Analisa Pesagem")
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_AnaPes.Value = ""
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_AnaPes.SetFocus()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.ValidarAnaPes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual ao grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
            .SetAll("ForeColor", RGB(90, 90, 90), "Column")
        ENDWITH
    ENDPROC

    *==========================================================================
    * ValidarTpPeso - Valida tipo de peso (deve ser "1" ou "2")
    *==========================================================================
    PROCEDURE ValidarTpPeso(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        TRY
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_TpPesos.Value)
            IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "1", "2")
                MsgAviso("Op" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida! Use [1] ou [2].", ;
                         "Tipo de Peso")
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_TpPesos.Value = ""
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.txt_4c_TpPesos.SetFocus()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.ValidarTpPeso")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdgFiguraClick - Seleciona imagem tecnica da linha de producao
    *==========================================================================
    PROCEDURE CmdgFiguraClick()
        LOCAL loc_cArquivo, loc_mImagem
        loc_cArquivo = ""

        TRY
            loc_cArquivo = GETPICT("jpg;bmp;png;gif", "Selecionar Imagem da Linha")
            IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
                loc_mImagem = FILETOSTR(loc_cArquivo)
                THIS.this_oBusinessObject.this_mFigTec = loc_mImagem
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.img_4c_FigTec.Picture = loc_cArquivo
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CmdgFiguraClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAbaFases - Aba "Fases" do pgf_4c_Abas (Page2)
    *   Grid grd_4c_Fases 10 colunas + botoes + EditBox Obs
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaFases()
        LOCAL loc_oAba
        TRY
            loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2

            loc_oAba.AddObject("cmd_4c_FaseInserir", "CommandButton")
            WITH loc_oAba.cmd_4c_FaseInserir
                .Caption         = ""
                .Top             = 87
                .Left            = 942
                .Width           = 40
                .Height          = 40
                .PicturePosition = 4
                .Picture         = gc_4c_CaminhoIcones + "geral_inserir_26.jpg"
                .ToolTipText     = "Inserir Fase"
                .Themes          = .T.
                .SpecialEffect   = 0
                .Visible         = .T.
            ENDWITH

            loc_oAba.AddObject("cmd_4c_FaseExcluir", "CommandButton")
            WITH loc_oAba.cmd_4c_FaseExcluir
                .Caption         = ""
                .Top             = 127
                .Left            = 942
                .Width           = 40
                .Height          = 40
                .PicturePosition = 4
                .Picture         = gc_4c_CaminhoIcones + "geral_excluir_26.jpg"
                .ToolTipText     = "Excluir Fase"
                .Themes          = .T.
                .SpecialEffect   = 0
                .Visible         = .T.
            ENDWITH

            loc_oAba.AddObject("cmd_4c_FaseAlternativa", "CommandButton")
            WITH loc_oAba.cmd_4c_FaseAlternativa
                .Caption         = ""
                .Top             = 180
                .Left            = 942
                .Width           = 40
                .Height          = 40
                .PicturePosition = 4
                .Picture         = gc_4c_CaminhoIcones + "geral_copia_26.jpg"
                .ToolTipText     = "Fase Alternativa"
                .Themes          = .T.
                .SpecialEffect   = 0
                .Visible         = .T.
            ENDWITH

            *-- Grid de Fases: ColumnCount ANTES do WITH (Problema 36)
            loc_oAba.AddObject("grd_4c_Fases", "Grid")
            loc_oAba.grd_4c_Fases.ColumnCount = 10
            WITH loc_oAba.grd_4c_Fases
                .Top          = 7
                .Left         = 9
                .Width        = 926
                .Height       = 323
                .RecordSource = ""
                .GridLines    = 1
                .FontName     = "Verdana"
                .FontSize     = 8
                .Visible      = .T.
                .RecordMark   = .F.
                .DeleteMark   = .F.
            ENDWITH
            WITH loc_oAba.grd_4c_Fases.Column1
                .Width = 45
                .Header1.Caption = "Ordem"
            ENDWITH
            WITH loc_oAba.grd_4c_Fases.Column2
                .Width = 65
                .Header1.Caption = "Fase"
            ENDWITH
            WITH loc_oAba.grd_4c_Fases.Column3
                .Width = 175
                .ReadOnly = .T.
                .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH
            WITH loc_oAba.grd_4c_Fases.Column4
                .Width          = 55
                .Sparse         = .F.
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Alignment = 0
                .Check1.ReadOnly  = .F.
                .Check1.Visible   = .T.
                .Check1.Top       = 9
                .Check1.Left      = 2
                .Check1.Height    = 17
                .Check1.Width     = 22
                .CurrentControl = "Check1"
                .Header1.Caption = ""
                .AddObject("Check1", "CheckBox")
                WITH .Check1
                    .Caption   = ""
                    .Alignment = 0
                    .ReadOnly  = .F.
                    .Visible   = .T.
                    .Top       = 9
                    .Left      = 2
                    .Height    = 17
                    .Width     = 22
                ENDWITH
            ENDWITH
            WITH loc_oAba.grd_4c_Fases.Column5
                .Width = 90
                .Header1.Caption = "Conta"
            ENDWITH
            WITH loc_oAba.grd_4c_Fases.Column6
                .Width = 55
                .Header1.Caption = "Grp.Prod"
            ENDWITH
            WITH loc_oAba.grd_4c_Fases.Column7
                .Width = 40
                .Header1.Caption = "Dias"
            ENDWITH
            WITH loc_oAba.grd_4c_Fases.Column8
                .Width = 90
                .Header1.Caption = "Uni. Produtiva"
            ENDWITH
            WITH loc_oAba.grd_4c_Fases.Column9
                .Width = 100
                .Header1.Caption = "Usu" + CHR(225) + "rio"
            ENDWITH
            WITH loc_oAba.grd_4c_Fases.Column10
                .Width = 55
                .Header1.Caption = "G.Grupo"
            ENDWITH

            *-- Label Observacao acima do EditBox (Say1 do legado, top=333)
            loc_oAba.AddObject("lbl_4c_ObsFase", "Label")
            WITH loc_oAba.lbl_4c_ObsFase
                .Caption  = "Observa" + CHR(231) + CHR(227) + "o"
                .Top      = 333
                .Left     = 10
                .AutoSize = .F.
                .Width    = 100
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- EditBox para Obs da fase selecionada
            loc_oAba.AddObject("edt_4c_ObsFase", "EditBox")
            WITH loc_oAba.edt_4c_ObsFase
                .Top      = 347
                .Left     = 9
                .Width    = 926
                .Height   = 102
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            BINDEVENT(loc_oAba.cmd_4c_FaseInserir,           "Click",             THIS, "FaseBtnInserirClick")
            BINDEVENT(loc_oAba.cmd_4c_FaseExcluir,           "Click",             THIS, "FaseBtnExcluirClick")
            BINDEVENT(loc_oAba.cmd_4c_FaseAlternativa,       "Click",             THIS, "FaseBtnAlternativaClick")
            BINDEVENT(loc_oAba.grd_4c_Fases,                 "KeyPress",          THIS, "GradFaseKeyPress")
            BINDEVENT(loc_oAba.grd_4c_Fases,                 "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
            BINDEVENT(loc_oAba.edt_4c_ObsFase,               "KeyPress",         THIS, "FaseObsLostFocus")
            BINDEVENT(loc_oAba.grd_4c_Fases.Column1.Text1,   "KeyPress",         THIS, "FaseOrdemLostFocus")
            BINDEVENT(loc_oAba.grd_4c_Fases.Column4.Check1,  "Click",             THIS, "FaseAgregarClick")

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.ConfigurarAbaFases")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAbaComposicao - Aba "Composicao" do pgf_4c_Abas (Page3)
    *   grd_4c_Composicao (9 cols) + grd_4c_CompObrig (4 cols) + botoes + desc
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaComposicao()
        LOCAL loc_oAba
        TRY
            loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3

            *-- Botoes para grd_4c_Composicao
            loc_oAba.AddObject("cmd_4c_CompoInserir", "CommandButton")
            WITH loc_oAba.cmd_4c_CompoInserir
                .Caption         = ""
                .Top             = 87
                .Left            = 949
                .Width           = 40
                .Height          = 40
                .PicturePosition = 4
                .Picture         = gc_4c_CaminhoIcones + "geral_inserir_26.jpg"
                .ToolTipText     = "Inserir Composi" + CHR(231) + CHR(227) + "o"
                .Themes          = .T.
                .SpecialEffect   = 0
                .Visible         = .T.
            ENDWITH

            loc_oAba.AddObject("cmd_4c_CompoExcluir", "CommandButton")
            WITH loc_oAba.cmd_4c_CompoExcluir
                .Caption         = ""
                .Top             = 127
                .Left            = 949
                .Width           = 40
                .Height          = 40
                .PicturePosition = 4
                .Picture         = gc_4c_CaminhoIcones + "geral_excluir_26.jpg"
                .ToolTipText     = "Excluir Composi" + CHR(231) + CHR(227) + "o"
                .Themes          = .T.
                .SpecialEffect   = 0
                .Visible         = .T.
            ENDWITH

            *-- Grid de Composicao: ColumnCount ANTES do WITH (Problema 36)
            loc_oAba.AddObject("grd_4c_Composicao", "Grid")
            loc_oAba.grd_4c_Composicao.ColumnCount = 9
            WITH loc_oAba.grd_4c_Composicao
                .Top          = 9
                .Left         = 8
                .Width        = 938
                .Height       = 243
                .RecordSource = ""
                .GridLines    = 1
                .FontName     = "Verdana"
                .FontSize     = 8
                .Visible      = .T.
                .RecordMark   = .F.
                .DeleteMark   = .F.
            ENDWITH
            WITH loc_oAba.grd_4c_Composicao.Column1
                .Width = 100
                .Header1.Caption = "Consumo"
            ENDWITH
            WITH loc_oAba.grd_4c_Composicao.Column2
                .Width = 195
                .ReadOnly = .T.
                .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH
            WITH loc_oAba.grd_4c_Composicao.Column3
                .Width = 55
                .Header1.Caption = "Uni"
            ENDWITH
            WITH loc_oAba.grd_4c_Composicao.Column4
                .Width = 80
                .Header1.Caption = "Valor"
            ENDWITH
            WITH loc_oAba.grd_4c_Composicao.Column5
                .Width = 80
                .Header1.Caption = "Qtde"
            ENDWITH
            WITH loc_oAba.grd_4c_Composicao.Column6
                .Width = 80
                .Header1.Caption = "Total"
            ENDWITH
            WITH loc_oAba.grd_4c_Composicao.Column7
                .Width = 55
                .Header1.Caption = "Moe"
            ENDWITH
            WITH loc_oAba.grd_4c_Composicao.Column8
                .Width = 100
                .Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
            ENDWITH
            WITH loc_oAba.grd_4c_Composicao.Column9
                .Width = 55
                .Header1.Caption = "Etiq"
            ENDWITH

            *-- Campo desc do produto selecionado na composicao (Get_Desc do legado)
            loc_oAba.AddObject("lbl_4c_LabelCompoDesc", "Label")
            WITH loc_oAba.lbl_4c_LabelCompoDesc
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top       = 260
                .Left      = 8
                .Width     = 122
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oAba.AddObject("txt_4c_CompoDesc", "TextBox")
            WITH loc_oAba.txt_4c_CompoDesc
                .Value    = ""
                .Top      = 256
                .Left     = 135
                .Width    = 290
                .Height   = 23
                .ReadOnly = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Titulo da secao Composicao Obrigatoria
            loc_oAba.AddObject("lbl_4c_CompoObrig", "Label")
            WITH loc_oAba.lbl_4c_CompoObrig
                .Caption   = "Composi" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria"
                .Top       = 288
                .Left      = 11
                .Width     = 200
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Botoes para grd_4c_CompObrig
            loc_oAba.AddObject("cmd_4c_CompObrigInserir", "CommandButton")
            WITH loc_oAba.cmd_4c_CompObrigInserir
                .Caption         = ""
                .Top             = 87
                .Left            = 942
                .Width           = 40
                .Height          = 40
                .PicturePosition = 4
                .Picture         = gc_4c_CaminhoIcones + "geral_inserir_26.jpg"
                .ToolTipText     = "Inserir Comp. Obrigat" + CHR(243) + "ria"
                .Themes          = .T.
                .SpecialEffect   = 0
                .Visible         = .T.
            ENDWITH

            loc_oAba.AddObject("cmd_4c_CompObrigExcluir", "CommandButton")
            WITH loc_oAba.cmd_4c_CompObrigExcluir
                .Caption         = ""
                .Top             = 127
                .Left            = 942
                .Width           = 40
                .Height          = 40
                .PicturePosition = 4
                .Picture         = gc_4c_CaminhoIcones + "geral_excluir_26.jpg"
                .ToolTipText     = "Excluir Comp. Obrigat" + CHR(243) + "ria"
                .Themes          = .T.
                .SpecialEffect   = 0
                .Visible         = .T.
            ENDWITH

            *-- Grid de Composicao Obrigatoria: ColumnCount ANTES do WITH (Problema 36)
            loc_oAba.AddObject("grd_4c_CompObrig", "Grid")
            loc_oAba.grd_4c_CompObrig.ColumnCount = 4
            WITH loc_oAba.grd_4c_CompObrig
                .Top          = 304
                .Left         = 11
                .Width        = 336
                .Height       = 147
                .RecordSource = ""
                .GridLines    = 1
                .FontName     = "Verdana"
                .FontSize     = 8
                .Visible      = .T.
                .RecordMark   = .F.
                .DeleteMark   = .F.
            ENDWITH
            WITH loc_oAba.grd_4c_CompObrig.Column1
                .Width = 80
                .Header1.Caption = "Componente A"
            ENDWITH
            WITH loc_oAba.grd_4c_CompObrig.Column2
                .Width = 55
                .Header1.Caption = "G.Grupo"
            ENDWITH
            WITH loc_oAba.grd_4c_CompObrig.Column3
                .Width = 55
                .Header1.Caption = "Grupo"
            ENDWITH
            WITH loc_oAba.grd_4c_CompObrig.Column4
                .Width = 80
                .Header1.Caption = "Componente B"
            ENDWITH

            BINDEVENT(loc_oAba.cmd_4c_CompoInserir,     "Click",             THIS, "CompoBtnInserirClick")
            BINDEVENT(loc_oAba.cmd_4c_CompoExcluir,     "Click",             THIS, "CompoBtnExcluirClick")
            BINDEVENT(loc_oAba.grd_4c_Composicao,       "KeyPress",          THIS, "GrdCompoKeyPress")
            BINDEVENT(loc_oAba.grd_4c_Composicao,       "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
            BINDEVENT(loc_oAba.cmd_4c_CompObrigInserir, "Click",             THIS, "CompObrigBtnInserirClick")
            BINDEVENT(loc_oAba.cmd_4c_CompObrigExcluir, "Click",             THIS, "CompObrigBtnExcluirClick")
            BINDEVENT(loc_oAba.grd_4c_CompObrig,        "KeyPress",          THIS, "GrdProKeyPress")

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.ConfigurarAbaComposicao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FaseBtnInserirClick - Insere nova linha vazia na grade de Fases
    *==========================================================================
    PROCEDURE FaseBtnInserirClick()
        LOCAL loc_oGrd, loc_nNovaOrdem, loc_cLinhas
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_Fases")
                THIS.InicializarCursoresDetalhe()
            ENDIF
            loc_cLinhas   = ALLTRIM(THIS.this_oBusinessObject.this_cLinhas)
            loc_oGrd      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
            SELECT cursor_4c_Fases
            IF RECCOUNT() = 0
                loc_nNovaOrdem = 10
            ELSE
                GO BOTTOM
                loc_nNovaOrdem = cursor_4c_Fases.Ordems + 10
            ENDIF
            INSERT INTO cursor_4c_Fases ;
                (Linhas, Ordems, Ordem2, Grupos, Descrs, Agregas, ;
                 Contas, Cgrus, Ndias, UniPrdts, Usuars, Mercs, Obs) ;
                VALUES (loc_cLinhas, loc_nNovaOrdem, loc_nNovaOrdem * 10, "", "", ;
                .F., "", "", 0, "", "", "", "")
            IF VARTYPE(loc_oGrd) = "O"
                GO BOTTOM IN cursor_4c_Fases
                loc_oGrd.Refresh()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FaseBtnInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FaseBtnExcluirClick - Exclui linha selecionada da grade de Fases
    *==========================================================================
    PROCEDURE FaseBtnExcluirClick()
        LOCAL loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_Fases") OR RECCOUNT("cursor_4c_Fases") = 0
                MsgAviso("Nenhuma fase selecionada para excluir.", "Excluir Fase")
                RETURN
            ENDIF
            IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o desta fase?", "Excluir Fase")
                RETURN
            ENDIF
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
            SELECT cursor_4c_Fases
            DELETE
            PACK
            IF VARTYPE(loc_oGrd) = "O"
                loc_oGrd.Refresh()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FaseBtnExcluirClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FaseBtnAlternativaClick - Cria fase alternativa (mesmo Ordems, Ordem2 sequencial)
    *==========================================================================
    PROCEDURE FaseBtnAlternativaClick()
        LOCAL loc_oGrd, loc_nOrdem, loc_nCount, loc_cLinhas, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_Fases") OR RECCOUNT("cursor_4c_Fases") = 0
                MsgAviso("Selecione uma fase para criar alternativa.", "Fase Alternativa")
                RETURN
            ENDIF
            loc_cLinhas = ALLTRIM(THIS.this_oBusinessObject.this_cLinhas)
            loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
            SELECT cursor_4c_Fases
            loc_nOrdem = cursor_4c_Fases.Ordems
            COUNT FOR Ordems = loc_nOrdem TO loc_nCount
            INSERT INTO cursor_4c_Fases ;
                (Linhas, Ordems, Ordem2, Grupos, Descrs, Agregas, ;
                 Contas, Cgrus, Ndias, UniPrdts, Usuars, Mercs, Obs) ;
                VALUES (loc_cLinhas, loc_nOrdem, (loc_nOrdem * 10) + loc_nCount, "", "", ;
                .F., "", "", 0, "", "", "", "")
            IF VARTYPE(loc_oGrd) = "O"
                GO BOTTOM IN cursor_4c_Fases
                loc_oGrd.Refresh()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FaseBtnAlternativaClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GradFaseAfterRowColChange - Atualiza EditBox Obs ao navegar na grade Fases
    *==========================================================================
    PROCEDURE GradFaseAfterRowColChange(par_nColIndex)
        TRY
            IF USED("cursor_4c_Fases") AND !EOF("cursor_4c_Fases")
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2, "edt_4c_ObsFase", 5)
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.edt_4c_ObsFase.Value = ;
                        cursor_4c_Fases.Obs
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.GradFaseAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradFaseKeyPress - Dispatcher F4 para lookups da grade de Fases
    *==========================================================================
    PROCEDURE GradFaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrd, loc_nCol
        TRY
            IF par_nKeyCode <> 28  && F4
                RETURN
            ENDIF
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
            IF VARTYPE(loc_oGrd) <> "O"
                RETURN
            ENDIF
            loc_nCol = loc_oGrd.ActiveColumn
            DO CASE
                CASE loc_nCol = 2
                    THIS.FaseLookupFase()
                CASE loc_nCol = 5
                    THIS.FaseLookupConta()
                CASE loc_nCol = 6
                    THIS.FaseLookupGrpProd()
                CASE loc_nCol = 8
                    THIS.FaseLookupUniProd()
                CASE loc_nCol = 9
                    THIS.FaseLookupUsuario()
                CASE loc_nCol = 10
                    THIS.FaseLookupGGrupo()
            ENDCASE
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.GradFaseKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FaseObsLostFocus - Salva conteudo do EditBox Obs de volta ao cursor de Fases
    *==========================================================================
    PROCEDURE FaseObsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
               USED("cursor_4c_Fases") AND !EOF("cursor_4c_Fases")
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2, "edt_4c_ObsFase", 5)
                    SELECT cursor_4c_Fases
                    REPLACE Obs WITH THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.edt_4c_ObsFase.Value
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FaseObsLostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FaseOrdemLostFocus - Reordena grade de Fases apos edicao do campo Ordem
    *==========================================================================
    PROCEDURE FaseOrdemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrd
        TRY
            IF USED("cursor_4c_Fases") AND RECCOUNT("cursor_4c_Fases") > 0
                SELECT cursor_4c_Fases
                INDEX ON STR(Ordems,2) + STR(Ordem2,3) TAG tmpord COMPACT
                loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
                IF VARTYPE(loc_oGrd) = "O"
                    loc_oGrd.Refresh()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FaseOrdemLostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FaseAgregarClick - Garante no maximo 1 linha com Agregar marcada
    *==========================================================================
    PROCEDURE FaseAgregarClick()
        LOCAL loc_oGrd, loc_nRecNo
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
                RETURN
            ENDIF
            SELECT cursor_4c_Fases
            IF cursor_4c_Fases.Agregas
                loc_nRecNo = RECNO("cursor_4c_Fases")
                SCAN
                    IF RECNO() <> loc_nRecNo
                        REPLACE Agregas WITH .F.
                    ENDIF
                ENDSCAN
                GO loc_nRecNo IN cursor_4c_Fases
            ENDIF
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
            IF VARTYPE(loc_oGrd) = "O"
                loc_oGrd.Refresh()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FaseAgregarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FaseLookupFase - Lookup de Fase em SigCdGcr (codigos/descrs)
    *==========================================================================
    PROCEDURE FaseLookupFase()
        LOCAL loc_oBusca, loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
            IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", "", ;
                "Selecionar Fase")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    SELECT cursor_4c_Fases
                    REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaGcr.codigos)
                    REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaGcr.descrs)
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FaseLookupFase")
        ENDTRY
        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FaseLookupConta - Lookup de Conta em SIGCDCLI (iclis/rclis)
    *==========================================================================
    PROCEDURE FaseLookupConta()
        LOCAL loc_oBusca, loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
            IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", "", ;
                "Selecionar Conta", .F., .F., ;
                "emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    SELECT cursor_4c_BuscaCli
                    SELECT cursor_4c_Fases
                    REPLACE Contas WITH ALLTRIM(cursor_4c_BuscaCli.iclis)
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FaseLookupConta")
        ENDTRY
        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FaseLookupGrpProd - Lookup de Grupo de Producao em SigCdGrp (cgrus/dgrus)
    *==========================================================================
    PROCEDURE FaseLookupGrpProd()
        LOCAL loc_oBusca, loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
            IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrp", "cgrus", "", ;
                "Selecionar Grupo de Produ" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                    SELECT cursor_4c_BuscaGrp
                    SELECT cursor_4c_Fases
                    REPLACE Cgrus WITH ALLTRIM(cursor_4c_BuscaGrp.cgrus)
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FaseLookupGrpProd")
        ENDTRY
        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FaseLookupUniProd - Lookup de Unidade de Producao em SigCdUpd (filtrado por Grupos)
    *==========================================================================
    PROCEDURE FaseLookupUniProd()
        LOCAL loc_oBusca, loc_oGrd, loc_cGrupos, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
            IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
                RETURN
            ENDIF
            SELECT cursor_4c_Fases
            loc_cGrupos = ALLTRIM(cursor_4c_Fases.Grupos)
            IF EMPTY(loc_cGrupos)
                MsgAviso("Selecione uma Fase (coluna Fase) antes de buscar a Unidade de Produ" + ;
                    CHR(231) + CHR(227) + "o.", "Unidade de Produ" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUpd", "cursor_4c_BuscaUpd", "uniprdts", "", ;
                "Selecionar Unidade de Produ" + CHR(231) + CHR(227) + "o", ;
                .F., .F., "codigos = " + EscaparSQL(loc_cGrupos))
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("uniprdts", "", "Unidade de Produ" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd")
                    SELECT cursor_4c_BuscaUpd
                    SELECT cursor_4c_Fases
                    REPLACE UniPrdts WITH ALLTRIM(cursor_4c_BuscaUpd.uniprdts)
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FaseLookupUniProd")
        ENDTRY
        IF USED("cursor_4c_BuscaUpd")
            USE IN cursor_4c_BuscaUpd
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FaseLookupUsuario - Lookup de Usuario em sigcdusu (usuarios/ncomps)
    *==========================================================================
    PROCEDURE FaseLookupUsuario()
        LOCAL loc_oBusca, loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
            IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "sigcdusu", "cursor_4c_BuscaUsu", "usuarios", "", ;
                "Selecionar Usu" + CHR(225) + "rio")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("usuarios", "", "Login")
                loc_oBusca.mAddColuna("ncomps",   "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                    SELECT cursor_4c_BuscaUsu
                    SELECT cursor_4c_Fases
                    REPLACE Usuars WITH ALLTRIM(cursor_4c_BuscaUsu.usuarios)
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FaseLookupUsuario")
        ENDTRY
        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FaseLookupGGrupo - Lookup de Grande Grupo em SigCdGpr (codigos/descs)
    *==========================================================================
    PROCEDURE FaseLookupGGrupo()
        LOCAL loc_oBusca, loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
            IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaGpr", "codigos", "", ;
                "Selecionar Grande Grupo")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGpr")
                    SELECT cursor_4c_BuscaGpr
                    SELECT cursor_4c_Fases
                    REPLACE Mercs WITH ALLTRIM(cursor_4c_BuscaGpr.codigos)
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.FaseLookupGGrupo")
        ENDTRY
        IF USED("cursor_4c_BuscaGpr")
            USE IN cursor_4c_BuscaGpr
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CompoBtnInserirClick - Insere nova linha vazia na grade de Composicao
    *==========================================================================
    PROCEDURE CompoBtnInserirClick()
        LOCAL loc_oGrd, loc_cLinhas, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_Composicao")
                THIS.InicializarCursoresDetalhe()
            ENDIF
            loc_cLinhas = ALLTRIM(THIS.this_oBusinessObject.this_cLinhas)
            loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Composicao
            SELECT cursor_4c_Composicao
            INSERT INTO cursor_4c_Composicao ;
                (Linhas, Mats, Dcompos, UniCompos, Pcompos, Qtds, Totas, Moeds, ObsCompos, Etiqs) ;
                VALUES (loc_cLinhas, "", "", "", 0, 0, 0, "", "", "")
            IF VARTYPE(loc_oGrd) = "O"
                GO BOTTOM IN cursor_4c_Composicao
                loc_oGrd.Refresh()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CompoBtnInserirClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CompoBtnExcluirClick - Exclui linha selecionada da grade de Composicao
    *==========================================================================
    PROCEDURE CompoBtnExcluirClick()
        LOCAL loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_Composicao") OR RECCOUNT("cursor_4c_Composicao") = 0
                MsgAviso("Nenhum item selecionado para excluir.", ;
                    "Excluir Composi" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste item da composi" + ;
                CHR(231) + CHR(227) + "o?", "Excluir Composi" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Composicao
            SELECT cursor_4c_Composicao
            DELETE
            PACK
            IF VARTYPE(loc_oGrd) = "O"
                loc_oGrd.Refresh()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CompoBtnExcluirClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GrdCompoAfterRowColChange - Atualiza campo desc ao navegar na grade Composicao
    *==========================================================================
    PROCEDURE GrdCompoAfterRowColChange(par_nColIndex)
        TRY
            IF USED("cursor_4c_Composicao") AND !EOF("cursor_4c_Composicao")
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3, "txt_4c_CompoDesc", 5)
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.txt_4c_CompoDesc.Value = ;
                        ALLTRIM(cursor_4c_Composicao.Dcompos)
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.GrdCompoAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdCompoKeyPress - Dispatcher F4 para lookups da grade de Composicao
    *==========================================================================
    PROCEDURE GrdCompoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrd, loc_nCol
        TRY
            IF par_nKeyCode <> 28  && F4
                RETURN
            ENDIF
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Composicao
            IF VARTYPE(loc_oGrd) <> "O"
                RETURN
            ENDIF
            loc_nCol = loc_oGrd.ActiveColumn
            DO CASE
                CASE loc_nCol = 1
                    THIS.CompoLookupCaract()
                CASE loc_nCol = 3
                    THIS.CompoLookupUni()
                CASE loc_nCol = 7
                    THIS.CompoLookupMoeda()
            ENDCASE
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.GrdCompoKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CompoLookupCaract - Lookup de Produto/Materia-Prima em SigCdPro (cpros/dpros)
    *==========================================================================
    PROCEDURE CompoLookupCaract()
        LOCAL loc_oBusca, loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Composicao
            IF !USED("cursor_4c_Composicao") OR EOF("cursor_4c_Composicao")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaPro", "cpros", "", ;
                "Selecionar Mat" + CHR(233) + "ria-Prima")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                    SELECT cursor_4c_BuscaPro
                    LOCAL loc_cCpros, loc_cDpros
                    loc_cCpros = ALLTRIM(cursor_4c_BuscaPro.cpros)
                    loc_cDpros = ALLTRIM(cursor_4c_BuscaPro.dpros)
                    SELECT cursor_4c_Composicao
                    REPLACE Mats   WITH loc_cCpros
                    REPLACE Dcompos WITH LEFT(loc_cDpros, 30)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3, "txt_4c_CompoDesc", 5)
                        THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.txt_4c_CompoDesc.Value = loc_cDpros
                    ENDIF
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CompoLookupCaract")
        ENDTRY
        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CompoLookupUni - Lookup de Unidade em SigCdUni (cunis/dunis)
    *==========================================================================
    PROCEDURE CompoLookupUni()
        LOCAL loc_oBusca, loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Composicao
            IF !USED("cursor_4c_Composicao") OR EOF("cursor_4c_Composicao")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUni", "cursor_4c_BuscaUni", "cunis", "", ;
                "Selecionar Unidade")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
                    SELECT cursor_4c_BuscaUni
                    SELECT cursor_4c_Composicao
                    REPLACE UniCompos WITH ALLTRIM(cursor_4c_BuscaUni.cunis)
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CompoLookupUni")
        ENDTRY
        IF USED("cursor_4c_BuscaUni")
            USE IN cursor_4c_BuscaUni
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CompoLookupMoeda - Lookup de Moeda em SigCdMoe (cmoes/dmoes)
    *==========================================================================
    PROCEDURE CompoLookupMoeda()
        LOCAL loc_oBusca, loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Composicao
            IF !USED("cursor_4c_Composicao") OR EOF("cursor_4c_Composicao")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", "", ;
                "Selecionar Moeda")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    SELECT cursor_4c_Composicao
                    REPLACE Moeds WITH ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CompoLookupMoeda")
        ENDTRY
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CompObrigBtnInserirClick - Insere nova linha na grade de Composicao Obrigatoria
    *==========================================================================
    PROCEDURE CompObrigBtnInserirClick()
        LOCAL loc_oGrd, loc_cLinhas, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_CompObrig")
                THIS.InicializarCursoresDetalhe()
            ENDIF
            loc_cLinhas = ALLTRIM(THIS.this_oBusinessObject.this_cLinhas)
            loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_CompObrig
            SELECT cursor_4c_CompObrig
            INSERT INTO cursor_4c_CompObrig (Linhas, Mat1s, Cgrus, Mercs, Mat2s) ;
                VALUES (loc_cLinhas, "", "", "", "")
            IF VARTYPE(loc_oGrd) = "O"
                GO BOTTOM IN cursor_4c_CompObrig
                loc_oGrd.Refresh()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CompObrigBtnInserirClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CompObrigBtnExcluirClick - Exclui linha da grade de Composicao Obrigatoria
    *==========================================================================
    PROCEDURE CompObrigBtnExcluirClick()
        LOCAL loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_CompObrig") OR RECCOUNT("cursor_4c_CompObrig") = 0
                MsgAviso("Nenhum item selecionado para excluir.", ;
                    "Excluir Comp. Obrigat" + CHR(243) + "ria")
                RETURN
            ENDIF
            IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste item?", ;
                "Excluir Comp. Obrigat" + CHR(243) + "ria")
                RETURN
            ENDIF
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_CompObrig
            SELECT cursor_4c_CompObrig
            DELETE
            PACK
            IF VARTYPE(loc_oGrd) = "O"
                loc_oGrd.Refresh()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CompObrigBtnExcluirClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GrdProKeyPress - Dispatcher F4 para lookups da grade de Composicao Obrigatoria
    *==========================================================================
    PROCEDURE GrdProKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrd, loc_nCol
        TRY
            IF par_nKeyCode <> 28  && F4
                RETURN
            ENDIF
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_CompObrig
            IF VARTYPE(loc_oGrd) <> "O"
                RETURN
            ENDIF
            loc_nCol = loc_oGrd.ActiveColumn
            DO CASE
                CASE loc_nCol = 1
                    THIS.CompObrigLookupCompA()
                CASE loc_nCol = 2
                    THIS.CompObrigLookupGGrupo()
                CASE loc_nCol = 3
                    THIS.CompObrigLookupGrupo()
                CASE loc_nCol = 4
                    THIS.CompObrigLookupCompB()
            ENDCASE
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.GrdProKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CompObrigLookupCompA - Lookup de Produto A em SigCdPro (cpros/dpros)
    *==========================================================================
    PROCEDURE CompObrigLookupCompA()
        LOCAL loc_oBusca, loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_CompObrig
            IF !USED("cursor_4c_CompObrig") OR EOF("cursor_4c_CompObrig")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaPro", "cpros", "", ;
                "Selecionar Produto A")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                    SELECT cursor_4c_BuscaPro
                    SELECT cursor_4c_CompObrig
                    REPLACE Mat1s WITH ALLTRIM(cursor_4c_BuscaPro.cpros)
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CompObrigLookupCompA")
        ENDTRY
        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CompObrigLookupGGrupo - Lookup de Grande Grupo em SigCdGpr (codigos/descs)
    *==========================================================================
    PROCEDURE CompObrigLookupGGrupo()
        LOCAL loc_oBusca, loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_CompObrig
            IF !USED("cursor_4c_CompObrig") OR EOF("cursor_4c_CompObrig")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaGpr", "codigos", "", ;
                "Selecionar Grande Grupo")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGpr")
                    SELECT cursor_4c_BuscaGpr
                    SELECT cursor_4c_CompObrig
                    REPLACE Cgrus WITH ALLTRIM(cursor_4c_BuscaGpr.codigos)
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CompObrigLookupGGrupo")
        ENDTRY
        IF USED("cursor_4c_BuscaGpr")
            USE IN cursor_4c_BuscaGpr
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CompObrigLookupGrupo - Lookup de Grupo de Producao em SigCdGrp (cgrus/dgrus)
    *==========================================================================
    PROCEDURE CompObrigLookupGrupo()
        LOCAL loc_oBusca, loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_CompObrig
            IF !USED("cursor_4c_CompObrig") OR EOF("cursor_4c_CompObrig")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrp", "cgrus", "", ;
                "Selecionar Grupo de Produ" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                    SELECT cursor_4c_BuscaGrp
                    SELECT cursor_4c_CompObrig
                    REPLACE Mercs WITH ALLTRIM(cursor_4c_BuscaGrp.cgrus)
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CompObrigLookupGrupo")
        ENDTRY
        IF USED("cursor_4c_BuscaGrp")
            USE IN cursor_4c_BuscaGrp
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CompObrigLookupCompB - Lookup de Produto B em SigCdPro (cpros/dpros)
    *==========================================================================
    PROCEDURE CompObrigLookupCompB()
        LOCAL loc_oBusca, loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_CompObrig
            IF !USED("cursor_4c_CompObrig") OR EOF("cursor_4c_CompObrig")
                RETURN
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaPro", "cpros", "", ;
                "Selecionar Produto B")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                    SELECT cursor_4c_BuscaPro
                    SELECT cursor_4c_CompObrig
                    REPLACE Mat2s WITH ALLTRIM(cursor_4c_BuscaPro.cpros)
                    IF VARTYPE(loc_oGrd) = "O"
                        loc_oGrd.Refresh()
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CompObrigLookupCompB")
        ENDTRY
        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VincularGradesDetalhe - Vincula cursores de detalhe as grades (RecordSource + ControlSource)
    *==========================================================================
    PROTECTED PROCEDURE VincularGradesDetalhe()
        LOCAL loc_oGrd, loc_lResultado
        loc_lResultado = .F.
        TRY
            *-- Grade de Fases
            IF USED("cursor_4c_Fases")
                loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Fases
                IF VARTYPE(loc_oGrd) = "O"
                    loc_oGrd.ColumnCount = 10
                    loc_oGrd.RecordSource             = "cursor_4c_Fases"
                    loc_oGrd.Column1.ControlSource    = "cursor_4c_Fases.Ordems"
                    loc_oGrd.Column2.ControlSource    = "cursor_4c_Fases.Grupos"
                    loc_oGrd.Column3.ControlSource    = "cursor_4c_Fases.Descrs"
                    loc_oGrd.Column5.ControlSource    = "cursor_4c_Fases.Contas"
                    loc_oGrd.Column6.ControlSource    = "cursor_4c_Fases.Cgrus"
                    loc_oGrd.Column7.ControlSource    = "cursor_4c_Fases.Ndias"
                    loc_oGrd.Column8.ControlSource    = "cursor_4c_Fases.UniPrdts"
                    loc_oGrd.Column9.ControlSource    = "cursor_4c_Fases.Usuars"
                    loc_oGrd.Column10.ControlSource   = "cursor_4c_Fases.Mercs"
                    loc_oGrd.Column1.Header1.Caption  = "Ordem"
                    loc_oGrd.Column2.Header1.Caption  = "Fase"
                    loc_oGrd.Column3.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrd.Column4.Header1.Caption  = ""
                    loc_oGrd.Column5.Header1.Caption  = "Conta"
                    loc_oGrd.Column6.Header1.Caption  = "Grp.Prod"
                    loc_oGrd.Column7.Header1.Caption  = "Dias"
                    loc_oGrd.Column8.Header1.Caption  = "Uni. Produtiva"
                    loc_oGrd.Column9.Header1.Caption  = "Usu" + CHR(225) + "rio"
                    loc_oGrd.Column10.Header1.Caption = "G.Grupo"
                    loc_oGrd.Refresh()
                ENDIF
            ENDIF

            *-- Grade de Composicao
            IF USED("cursor_4c_Composicao")
                loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Composicao
                IF VARTYPE(loc_oGrd) = "O"
                    loc_oGrd.ColumnCount = 9
                    loc_oGrd.RecordSource             = "cursor_4c_Composicao"
                    loc_oGrd.Column1.ControlSource    = "cursor_4c_Composicao.Mats"
                    loc_oGrd.Column2.ControlSource    = "cursor_4c_Composicao.Dcompos"
                    loc_oGrd.Column3.ControlSource    = "cursor_4c_Composicao.UniCompos"
                    loc_oGrd.Column4.ControlSource    = "cursor_4c_Composicao.Pcompos"
                    loc_oGrd.Column5.ControlSource    = "cursor_4c_Composicao.Qtds"
                    loc_oGrd.Column6.ControlSource    = "cursor_4c_Composicao.Totas"
                    loc_oGrd.Column7.ControlSource    = "cursor_4c_Composicao.Moeds"
                    loc_oGrd.Column8.ControlSource    = "cursor_4c_Composicao.ObsCompos"
                    loc_oGrd.Column9.ControlSource    = "cursor_4c_Composicao.Etiqs"
                    loc_oGrd.Column1.Header1.Caption  = "Consumo"
                    loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrd.Column3.Header1.Caption  = "Uni"
                    loc_oGrd.Column4.Header1.Caption  = "Valor"
                    loc_oGrd.Column5.Header1.Caption  = "Qtde"
                    loc_oGrd.Column6.Header1.Caption  = "Total"
                    loc_oGrd.Column7.Header1.Caption  = "Moe"
                    loc_oGrd.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
                    loc_oGrd.Column9.Header1.Caption  = "Etiq"
                    loc_oGrd.Refresh()
                ENDIF
            ENDIF

            *-- Grade de Composicao Obrigatoria
            IF USED("cursor_4c_CompObrig")
                loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_CompObrig
                IF VARTYPE(loc_oGrd) = "O"
                    loc_oGrd.ColumnCount = 4
                    loc_oGrd.RecordSource            = "cursor_4c_CompObrig"
                    loc_oGrd.Column1.ControlSource   = "cursor_4c_CompObrig.Mat1s"
                    loc_oGrd.Column2.ControlSource   = "cursor_4c_CompObrig.Cgrus"
                    loc_oGrd.Column3.ControlSource   = "cursor_4c_CompObrig.Mercs"
                    loc_oGrd.Column4.ControlSource   = "cursor_4c_CompObrig.Mat2s"
                    loc_oGrd.Column1.Header1.Caption = "Componente A"
                    loc_oGrd.Column2.Header1.Caption = "G.Grupo"
                    loc_oGrd.Column3.Header1.Caption = "Grupo"
                    loc_oGrd.Column4.Header1.Caption = "Componente B"
                    loc_oGrd.Refresh()
                ENDIF
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.VincularGradesDetalhe")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarAbasDetalhe - Carrega cursores de detalhe do BO e vincula as grades
    *==========================================================================
    PROTECTED PROCEDURE CarregarAbasDetalhe(par_cLinhas)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject.BuscarFases(par_cLinhas)
            THIS.this_oBusinessObject.BuscarComposicao(par_cLinhas)
            THIS.this_oBusinessObject.BuscarCompObrig(par_cLinhas)
            THIS.VincularGradesDetalhe()
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.CarregarAbasDetalhe")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarCursoresDetalhe - Cria cursores locais vazios para novo registro
    *==========================================================================
    PROTECTED PROCEDURE InicializarCursoresDetalhe()
        TRY
            IF USED("cursor_4c_Fases")
                USE IN cursor_4c_Fases
            ENDIF
            IF USED("cursor_4c_Composicao")
                USE IN cursor_4c_Composicao
            ENDIF
            IF USED("cursor_4c_CompObrig")
                USE IN cursor_4c_CompObrig
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Fases ;
                (Linhas   C(10), ;
                 Ordems   N(2,0), ;
                 Ordem2   N(3,0), ;
                 Grupos   C(10), ;
                 Descrs   C(40), ;
                 Agregas  L, ;
                 Contas   C(10), ;
                 Cgrus    C(3), ;
                 Ndias    N(2,0), ;
                 UniPrdts C(10), ;
                 Usuars   C(10), ;
                 Mercs    C(3), ;
                 Obs      M)
            SET NULL OFF

            SET NULL ON
            CREATE CURSOR cursor_4c_Composicao ;
                (Linhas    C(10), ;
                 Mats      C(14), ;
                 Dcompos   C(30), ;
                 UniCompos C(3), ;
                 Pcompos   N(11,3), ;
                 Qtds      N(8,3), ;
                 Totas     N(11,3), ;
                 Moeds     C(3), ;
                 ObsCompos C(10), ;
                 Etiqs     C(1))
            SET NULL OFF

            SET NULL ON
            CREATE CURSOR cursor_4c_CompObrig ;
                (Linhas C(10), ;
                 Mat1s  C(14), ;
                 Cgrus  C(3), ;
                 Mercs  C(3), ;
                 Mat2s  C(14))
            SET NULL OFF

            THIS.VincularGradesDetalhe()
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.InicializarCursoresDetalhe")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Destrutor do formulario
    *==========================================================================
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Fases")
                USE IN cursor_4c_Fases
            ENDIF
            IF USED("cursor_4c_Composicao")
                USE IN cursor_4c_Composicao
            ENDIF
            IF USED("cursor_4c_CompObrig")
                USE IN cursor_4c_CompObrig
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLin.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
