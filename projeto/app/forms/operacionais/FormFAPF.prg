*------------------------------------------------------------------------------
* FormFAPF.prg - Form Operacional: FAPF
* Herda de FormBase
* Migrado de SIGCDFAPF.SCX
*------------------------------------------------------------------------------
DEFINE CLASS FormFAPF AS FormBase

    *-- Propriedades visuais (original: Width=375, Height=250, TitleBar=0)
    this_cMensagemErro = ""
    Top         = 0
    Left        = 0
    Height      = 250
    Width       = 375
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Caption     = "Form1"
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("FAPFBO")

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                IF gnConnHandle <= 0
                    MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                            "o Com o Servidor de Banco de Dados...", ;
                            "Conex" + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.TornarControlesVisiveis()
            THIS.ConfigurarBINDEVENTs()
            THIS.CarregarLista()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o cabecalho cinza superior do form
    * Forms OPERACIONAIS nao usam PageFrame CRUD - o cabecalho e um container
    * direto no form, equivalente ao cntSombra do framework legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BackStyle   = 1
                .BorderWidth = 0

                .AddObject("lbl_4c_LblSombra", "Label")
                WITH .lbl_4c_LblSombra
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .WordWrap  = .T.
                    .Alignment = 0
                    .ForeColor = RGB(0, 0, 0)
                    .Caption   = "FAPF"
                ENDWITH

                .AddObject("lbl_4c_LblTitulo", "Label")
                WITH .lbl_4c_LblTitulo
                    .Top       = 17
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .WordWrap  = .T.
                    .Alignment = 0
                    .ForeColor = RGB(255, 255, 255)
                    .Caption   = "FAPF"
                ENDWITH

                .Visible = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Constroi os controles principais do form OPERACIONAL
    * Para forms OPERACIONAIS, este metodo unifica a configuracao dos elementos
    * da area de conteudo (botoes de acao e campos de entrada)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro

        TRY
            THIS.ConfigurarBotoesAcao()
            THIS.ConfigurarBotoesCRUD()
            THIS.ConfigurarGrade()
            THIS.ConfigurarPaginaDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Cria o container canonico de saida (Encerrar)
    * Padrao canonico: cnt_4c_Saida.Left=917 (adaptado para Width=718: Left=638)
    * cmd_4c_Encerrar: Left=5, Top=5, Width=75, Height=75, Caption="Encerrar"
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Saida", "Container")
            WITH THIS.cnt_4c_Saida
                .Top         = 5
                .Left        = 917
                .Width       = 90
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0

                .AddObject("cmd_4c_Encerrar", "CommandButton")
                WITH .cmd_4c_Encerrar
                    .Top             = 5
                    .Left            = 917
                    .Width           = 90
                    .Height          = 75
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
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles de nivel raiz do form
    * cnt_4c_Sombra ja tem Visible=.T. definido em ConfigurarPageFrame
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oErro

        TRY
            THIS.TornarVisivelRecursivo(THIS)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarVisivelRecursivo - Percorre container recursivamente tornando visiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarVisivelRecursivo(par_oContainer)
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                *-- Pular containers com visibilidade controlada explicitamente; recursar filhos apenas
                IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_PAINELDADOS", "CNT_4C_SOMBRA")
                    IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
                       loc_oCtrl.ControlCount > 0
                        THIS.TornarVisivelRecursivo(loc_oCtrl)
                    ENDIF
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
                   loc_oCtrl.ControlCount > 0
                    THIS.TornarVisivelRecursivo(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincula o evento do botao Encerrar
    * Eventos dos campos de entrada serao vinculados nas fases de conteudo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        LOCAL loc_oErro

        TRY
            BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
            BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Confirmar, ;
                      "Click", THIS, "BtnConfirmarClick")
            BINDEVENT(THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Cancelar, ;
                      "Click", THIS, "BtnCancelarClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarBINDEVENTs")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesCRUD - Cria container com os 5 botoes de operacao CRUD
    * Posicionado no cabecalho, a esquerda do cnt_4c_Saida
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesCRUD()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Botoes", "Container")
            WITH THIS.cnt_4c_Botoes
                .Top         = 5
                .Left        = THIS.Width - 85 - 390 - 5
                .Width       = 390
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .AddObject("cmd_4c_Incluir",    "CommandButton")
                .AddObject("cmd_4c_Visualizar", "CommandButton")
                .AddObject("cmd_4c_Alterar",    "CommandButton")
                .AddObject("cmd_4c_Excluir",    "CommandButton")
                .AddObject("cmd_4c_Buscar",     "CommandButton")
                .Visible     = .T.
            ENDWITH

            WITH THIS.cnt_4c_Botoes.cmd_4c_Incluir
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Incluir"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .F.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            ENDWITH

            WITH THIS.cnt_4c_Botoes.cmd_4c_Visualizar
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Caption         = "Visualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .F.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .Enabled         = .F.
            ENDWITH

            WITH THIS.cnt_4c_Botoes.cmd_4c_Alterar
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .Caption         = "Alterar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .F.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .Enabled         = .F.
            ENDWITH

            WITH THIS.cnt_4c_Botoes.cmd_4c_Excluir
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
                .Caption         = "Excluir"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .F.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .Enabled         = .F.
            ENDWITH

            WITH THIS.cnt_4c_Botoes.cmd_4c_Buscar
                .Top             = 5
                .Left            = 305
                .Width           = 75
                .Height          = 75
                .Caption         = "Buscar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .F.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarBotoesCRUD")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - Cria o grid de exibicao de registros com cursor vazio
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oErro

        TRY
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados (Codigo C(20) NULL, Descricao C(60) NULL)
            SET NULL OFF

            THIS.AddObject("grd_4c_Lista", "Grid")
            WITH THIS.grd_4c_Lista
                .Top                = 95
                .Left               = 5
                .Width              = THIS.Width - 10
                .Height             = THIS.Height - 100
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
                .ScrollBars         = 2
                .RowHeight          = 16
            ENDWITH
            THIS.grd_4c_Lista.ColumnCount              = 2
            THIS.grd_4c_Lista.RecordSource              = "cursor_4c_Dados"
            THIS.grd_4c_Lista.Column1.ControlSource     = "cursor_4c_Dados.Codigo"
            THIS.grd_4c_Lista.Column1.Width              = 150
            THIS.grd_4c_Lista.Column1.Header1.Caption   = "C" + CHR(243) + "digo"
            THIS.grd_4c_Lista.Column2.ControlSource     = "cursor_4c_Dados.Descricao"
            THIS.grd_4c_Lista.Column2.Width              = THIS.Width - 10 - 150 - 5
            THIS.grd_4c_Lista.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega/recarrega dados no grid principal
    * Form operacional sem tabela propria - cursor permanece vazio por padrao
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                ZAP
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (Codigo C(20) NULL, Descricao C(60) NULL)
                SET NULL OFF
            ENDIF

            IF VARTYPE(THIS.grd_4c_Lista) = "O"
                THIS.grd_4c_Lista.ColumnCount                 = 2
                THIS.grd_4c_Lista.RecordSource                = "cursor_4c_Dados"
                THIS.grd_4c_Lista.Column1.ControlSource       = "cursor_4c_Dados.Codigo"
                THIS.grd_4c_Lista.Column2.ControlSource       = "cursor_4c_Dados.Descricao"
                THIS.grd_4c_Lista.Column1.Header1.Caption     = "C" + CHR(243) + "digo"
                THIS.grd_4c_Lista.Column2.Header1.Caption     = ;
                    "Descri" + CHR(231) + CHR(227) + "o"
            ENDIF

            THIS.AlternarPagina(1)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro CarregarLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre modo Lista (1) e modo Dados (2)
    * Ajusta estado dos botoes CRUD conforme modo corrente
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lTemRegistro

        IF VARTYPE(THIS.cnt_4c_Botoes) != "O"
            RETURN
        ENDIF

        loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0

        IF par_nPagina = 1
            *-- Modo Lista: exibe grid, oculta painel de dados
            IF VARTYPE(THIS.grd_4c_Lista) = "O"
                THIS.grd_4c_Lista.Visible = .T.
            ENDIF
            IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
                THIS.cnt_4c_PainelDados.Visible = .F.
            ENDIF
            THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
            THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
            THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
            THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
        ELSE
            *-- Modo Dados: oculta grid, exibe painel de dados
            IF VARTYPE(THIS.grd_4c_Lista) = "O"
                THIS.grd_4c_Lista.Visible = .F.
            ENDIF
            IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
                THIS.cnt_4c_PainelDados.Visible = .T.
            ENDIF
            THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .F.
            THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .F.
            THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .F.
            THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .F.
            THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.BOParaForm()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe registro selecionado para visualizacao
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para visualizar.", "Visualizar")
            RETURN
        ENDIF
        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
        THIS.BOParaForm()
        THIS.HabilitarCampos(.F.)
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Inicia alteracao do registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para alterar.", "Alterar")
            RETURN
        ENDIF
        THIS.this_oBusinessObject.EditarRegistro()
        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
        THIS.BOParaForm()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui o registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para excluir.", "Excluir")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
                "Excluir")
            RETURN
        ENDIF

        loc_lResultado = THIS.this_oBusinessObject.Excluir()

        IF loc_lResultado
            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
            THIS.CarregarLista()
        ELSE
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Excluir")
            ELSE
                MsgErro("Erro ao excluir o registro.", "Excluir")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega a lista de registros
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Salva o registro em edicao/inclusao
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lResultado

        THIS.FormParaBO()
        loc_lResultado = THIS.this_oBusinessObject.Salvar()

        IF loc_lResultado
            MsgInfo("Registro salvo com sucesso.", "Confirmar")
            THIS.CarregarLista()
        ELSE
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Confirmar")
            ELSE
                MsgErro("Erro ao salvar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias para BtnConfirmarClick (compatibilidade)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           THIS.this_oBusinessObject.this_lEmEdicao
            THIS.this_oBusinessObject.Cancelar()
        ENDIF
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos para o Business Object
    * Form sem campos - nenhum mapeamento necessario
    *==========================================================================
    PROCEDURE FormParaBO()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do Business Object para os campos
    * Form sem campos - nenhum mapeamento necessario
    *==========================================================================
    PROCEDURE BOParaForm()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de entrada
    * par_lHabilitar: .T. = editavel, .F. = somente leitura (modo visualizar)
    * Form sem campos - controla apenas botao Confirmar
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
            THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Confirmar.Enabled = ;
                par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Cria o painel de dados (Page2 do form OPERACIONAL)
    * Form sem campos proprios: apenas container com botoes Confirmar/Cancelar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_PainelDados", "Container")
            WITH THIS.cnt_4c_PainelDados
                .Top         = 95
                .Left        = 0
                .Width       = THIS.Width
                .Height      = THIS.Height - 95
                .BackStyle   = 1
                .BackColor   = RGB(255, 255, 255)
                .BorderWidth = 0

                .AddObject("cnt_4c_BotoesDados", "Container")
                .Visible     = .T.
            ENDWITH

            WITH THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados
                .Top         = THIS.Height - 185
                .Left        = THIS.Width - 170
                .Width       = 165
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0

                .AddObject("cmd_4c_Confirmar", "CommandButton")
                .AddObject("cmd_4c_Cancelar",  "CommandButton")
                .Visible     = .T.
            ENDWITH

            WITH THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Confirmar
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Confirmar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .F.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            ENDWITH

            WITH THIS.cnt_4c_PainelDados.cnt_4c_BotoesDados.cmd_4c_Cancelar
                .Top             = 5
                .Left            = 85
                .Width           = 75
                .Height          = 75
                .Caption         = "Cancelar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .Themes          = .F.
                .MousePointer    = 15
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa campos de entrada e redefine estado do cursor
    * Form sem campos proprios: zera cursor de dados e ajusta botoes
    *==========================================================================
    PROCEDURE LimparCampos()
        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            ZAP
        ENDIF
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD conforme dados
    * Habilitado/Desabilitado conforme existencia de registros no cursor
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemRegistro
        IF VARTYPE(THIS.cnt_4c_Botoes) != "O"
            RETURN
        ENDIF
        loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
        THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
        THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
        THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
        THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
        THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
    ENDPROC

ENDDEFINE
