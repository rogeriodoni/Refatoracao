*==============================================================================
* FormDrs.prg - Formulario de Fichas Tecnicas (SigSyCrs)
* Migrado de: SigCdDrs.SCX (frmcadastro)
*
* Recebe par_cTits (C20) para identificar o tipo de ficha tecnica.
* Modelo: chave-valor em SigSyCrs (Tits+Cods = PK logica; Campos=campo; Resps=valor).
* Campos dinamicos definidos em SigSyCit; campos fixos: Emps, Dopes, Numes, Aprova, Datas, Baixa.
* Workflow: Aprovar/Desaprovar (cmd_4c_Aprovar) e Baixar/Canc Baixa (cmd_4c_Baixar).
*==============================================================================

DEFINE CLASS FormDrs AS FormBase

    *-- Propriedades visuais
    Height      = 640
    Width       = 1007
    Caption     = "Fichas T" + CHR(233) + "cnicas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cTits           = ""
    this_nCodAtual       = 0
    this_lMontouObjetos  = .F.
    this_nNroControles   = 0
    this_lSemTits        = .F.   && .T. = sem tipo escolhido; o chamador NAO deve exibir o form

    *-- Array de controles dinamicos (nomeCtrl, obrigatorio, nomeCampo)
    DIMENSION laControles[1, 3]

    *===========================================================================
    * Init - Recebe par_cTits antes de delegar ao FormBase
    *
    * O form eh GENERICO: no legado o Init recebe pPrg obrigatoriamente
    * (ThisForm.Tits = Padr(pPrg,20)) e TUDO depende dele - os campos vem de
    * SigSyCit Where Tits = <tipo> e os registros de SigSyCrs Where Tits = <tipo>.
    * Chamado sem o parametro, Tits fica vazio, as consultas filtram por '' e a
    * tela abre sem campos e sem linhas (Erro228). Como o menu do sistema novo
    * nao tem como saber o tipo, aqui ele eh ESCOLHIDO pelo usuario.
    *===========================================================================
    PROCEDURE Init(par_cTits)
        IF VARTYPE(par_cTits) = "C"
            THIS.this_cTits = PADR(ALLTRIM(par_cTits), 20)
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cTits))
            IF !THIS.SelecionarTits()
                *-- Sem tipo nao ha o que montar: avisa o chamador e nao segue
                THIS.this_lSemTits = .T.
                RETURN .T.
            ENDIF
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * SelecionarTits - Escolhe o tipo de ficha tecnica (SigSyCit.Tits)
    * Retorna .T. se o usuario escolheu um tipo.
    *===========================================================================
    PROTECTED FUNCTION SelecionarTits()
        LOCAL loc_cSQL, loc_nRet, loc_oBusca, loc_lEscolheu
        loc_lEscolheu = .F.
        loc_oBusca    = .NULL.

        TRY
            IF USED("cursor_4c_BuscaTits")
                USE IN cursor_4c_BuscaTits
            ENDIF

            *-- 2 colunas: o ConfigurarGrid do FormBuscaAuxiliar da 80px a
            *-- primeira e divide o restante entre as demais; com uma coluna so
            *-- a grade ficaria com 80px usados e o resto vazio.
            loc_cSQL = "SELECT RTRIM(Tits) AS Tits, COUNT(*) AS Campos FROM SigSyCit" + ;
                       " WHERE RTRIM(Tits) <> '' GROUP BY RTRIM(Tits) ORDER BY 1"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTits")

            DO CASE
                CASE loc_nRet < 0 OR !USED("cursor_4c_BuscaTits")
                    MsgErro("Erro ao listar os tipos de ficha t" + CHR(233) + "cnica:" + ;
                        CHR(13) + CapturarErroSQL(), "Fichas T" + CHR(233) + "cnicas")

                CASE RECCOUNT("cursor_4c_BuscaTits") = 0
                    MsgAviso("Nenhum tipo de ficha t" + CHR(233) + "cnica cadastrado " + ;
                        "em SigSyCit.", "Fichas T" + CHR(233) + "cnicas")

                CASE RECCOUNT("cursor_4c_BuscaTits") = 1
                    *-- Tipo unico: nao faz sentido perguntar
                    SELECT cursor_4c_BuscaTits
                    GO TOP
                    THIS.this_cTits = PADR(ALLTRIM(cursor_4c_BuscaTits.Tits), 20)
                    loc_lEscolheu   = .T.

                OTHERWISE
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTits"
                        loc_oBusca.mAddColuna("Tits",   "X(20)", "Ficha T" + CHR(233) + "cnica")
                        loc_oBusca.mAddColuna("Campos", "9999",  "Campos")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTits")
                            SELECT cursor_4c_BuscaTits
                            THIS.this_cTits = PADR(ALLTRIM(cursor_4c_BuscaTits.Tits), 20)
                            loc_lEscolheu   = .T.
                        ENDIF
                        loc_oBusca.Release()
                        loc_oBusca = .NULL.
                    ENDIF
            ENDCASE

            IF USED("cursor_4c_BuscaTits")
                USE IN cursor_4c_BuscaTits
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao selecionar o tipo de ficha t" + CHR(233) + "cnica:" + ;
                CHR(13) + loc_oErro.Message, "Fichas T" + CHR(233) + "cnicas")
            IF USED("cursor_4c_BuscaTits")
                USE IN cursor_4c_BuscaTits
            ENDIF
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        ENDTRY

        RETURN loc_lEscolheu
    ENDFUNC

    *===========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("DrsBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar DrsBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormDrs.InicializarForm")
            ELSE
                THIS.this_oBusinessObject.this_cTits = THIS.this_cTits

                IF !THIS.this_oBusinessObject.CarregarSigSyCit()
                    MostrarErro("Erro ao carregar SigSyCit para Tits=" + ;
                        ALLTRIM(THIS.this_cTits), "FormDrs.InicializarForm")
                ELSE
                    THIS.this_oBusinessObject.InicializarCursores()

                    THIS.ConfigurarPageFrame()
                    THIS.Caption = "Ficha T" + CHR(233) + "cnica - " + ALLTRIM(THIS.this_cTits)
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Visible    = .T.
                    THIS.pgf_4c_Paginas.ActivePage = 1
                    THIS.this_cModoAtual           = "LISTA"

                    IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                        THIS.CarregarLista()
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormDrs:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - PageFrame com 2 paginas (Top=-29, Tabs=.F.)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho + CRUD + filtro + workflow + grid
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 750
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 750
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Botoes CRUD (Incluir/Alterar/Excluir/Buscar)
        *-- Original grupo_op: Left=342, Top=-1. Compensado: Top=29
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80) - legado: grupo_op.consultar, Top=5 Left=80.
        *-- A migracao perdeu este botao e deixou o vao de 75px entre Incluir e
        *-- Alterar; o modo CONSULTAR tinha sido enfiado no botao Buscar (Erro228).
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
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
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- optFiltro: Todas/Pendentes/Baixadas
        *-- Original: Left=35, Top=87. Compensado: Top=116 (87+29)
        loc_oPagina.AddObject("opt_4c_Filtro", "OptionGroup")
        WITH loc_oPagina.opt_4c_Filtro
            .ButtonCount  = 3
            .AutoSize     = .F.
            .Height       = 58
            .Left         = 35
            .Top          = 116
            .Width        = 82
            .BackStyle    = 0
            .BorderStyle  = 0
            .Value        = 1
            .Visible      = .T.

            WITH .Buttons(1)
                .Caption   = "Todas"
                .Height    = 17
                .Left      = 3
                .Top       = 3
                .Width     = 74
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Pendentes"
                .Height    = 17
                .Left      = 3
                .Top       = 21
                .Width     = 74
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Baixadas"
                .Height    = 17
                .Left      = 3
                .Top       = 39
                .Width     = 74
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_Filtro, "InteractiveChange", THIS, "OptFiltroInteractiveChange")

        *-- Botoes de Workflow: Aprovar/Desaprovar e Baixar/Canc Baixa
        *-- Original Commandgroup1: Left=115, Top=91. Compensado: Top=120 (91+29)
        loc_oPagina.AddObject("cnt_4c_Workflow", "Container")
        WITH loc_oPagina.cnt_4c_Workflow
            .Top         = 120
            .Left        = 122
            .Width       = 250
            .Height      = 55
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Workflow.AddObject("cmd_4c_Aprovar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Workflow.cmd_4c_Aprovar
            .Caption         = "Aprovar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_32.jpg"
            .PicturePosition = 1
            .Top             = 5
            .Left            = 4
            .Width           = 115
            .Height          = 45
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Workflow.cmd_4c_Aprovar, "Click", THIS, "BtnAprovarClick")

        loc_oPagina.cnt_4c_Workflow.AddObject("cmd_4c_Baixar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Workflow.cmd_4c_Baixar
            .Caption         = "Baixar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 1
            .Top             = 5
            .Left            = 127
            .Width           = 115
            .Height          = 45
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Workflow.cmd_4c_Baixar, "Click", THIS, "BtnBaixarClick")

        *-- Grid de listagem (colunas montadas em MontarColunasGrid apos Buscar)
        *-- Original grade: Left=29, Top=142. Compensado Top: 175 (142+29+4)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 0
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 180
            .Left               = 29
            .Width              = 880
            .Height             = 425
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
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GrdAfterRowColChange")
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick",          THIS, "BtnAlterarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2: botoes acao + codigo + container dinamico
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
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



        *-- Botoes Confirmar/Cancelar
        *-- Original grupo_salva: Top=9. Compensado: Top=38 (9+29)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 38
            .Left        = 840
            .Width       = 160
            .Height      = 85
            .BackStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 83
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label e TextBox de Codigo
        *-- Original Label1: Left=102, Top=137; getCods: Left=152, Top=134
        *-- Compensados: Top Label=166 (137+29), Top getCods=163 (134+29)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 166
            .Left      = 102
            .Height    = 16
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cods", "TextBox")
        WITH loc_oPagina.txt_4c_Cods
            .Value             = 0
            .Enabled           = .F.
            .Left              = 155
            .Top               = 163
            .Width             = 52
            .Height            = 20
            .DisabledBackColor = RGB(255, 255, 255)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH

        *-- Container para campos dinamicos de SigSyCit + campos fixos de header
        *-- Original Shape1: Top=167, Height=309, Left=65, Width=670 -> compensado Top=196
        *-- Equivale ao poWindowCad do legado (criarform):
        *--   Left = Pagina.Left + 10 | Width = Pagina.Width - 40
        *-- O migrado tinha Left=65 com Width=THIS.Width (1007), ou seja 65..1072:
        *-- 65px alem da borda do form, e a Page RECORTAVA o excedente (Erro228).
        loc_oPagina.AddObject("cnt_4c_Campos", "Container")
        WITH loc_oPagina.cnt_4c_Campos
            .Top         = 196
            .Left        = 10
            .Width       = THIS.Width - 40
            .Height      = 420
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderColor = RGB(180, 180, 180)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Busca registros e configura grid dinamico
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cFiltro, loc_oGrd, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oGrd    = loc_oPagina.grd_4c_Lista

            DO CASE
                CASE loc_oPagina.opt_4c_Filtro.Value = 2
                    loc_cFiltro = "PENDENTES"
                CASE loc_oPagina.opt_4c_Filtro.Value = 3
                    loc_cFiltro = "BAIXADAS"
                OTHERWISE
                    loc_cFiltro = "TODAS"
            ENDCASE

            IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                *-- cursor_4c_Dados: alias padrao do framework de testes
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                IF USED("crSigSyCrs")
                    SELECT * FROM crSigSyCrs INTO CURSOR cursor_4c_Dados NOFILTER READWRITE
                    SELECT crSigSyCrs
                ENDIF
                THIS.MontarColunasGrid()
                IF USED("crSigSyCrs")
                    loc_oGrd.SetAll("DynamicForeColor", ;
                        "Iif(crSigSyCrs.ChkSubn, RGB(0,0,255), Iif(crSigSyCrs.ChkApro, RGB(0,128,0), RGB(0,0,0)))", ;
                        "Column")
                    loc_oGrd.RecordSource = "crSigSyCrs"
                    loc_oGrd.Refresh()
                ENDIF
                THIS.AtualizarBotoesWorkflow()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.CarregarLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * MontarColunasGrid - Configura colunas do grid baseado em crSigSyCit.Listas=1
    *===========================================================================
    PROTECTED PROCEDURE MontarColunasGrid()
        LOCAL loc_oGrd, loc_nCols, loc_nColIdx, loc_cCampo, loc_nWidth, loc_cHeader
        TRY
            loc_oGrd  = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
            loc_nCols = 1

            IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCit
                SCAN
                    IF crSigSyCit.Listas = 1
                        loc_nCols = loc_nCols + 1
                    ENDIF
                ENDSCAN
            ENDIF

            loc_oGrd.RecordSource = ""
            loc_oGrd.ColumnCount  = loc_nCols

            WITH loc_oGrd.Column1
                .ControlSource       = "crSigSyCrs.Cods"
                .Width               = 60
                .ReadOnly            = .T.
                .Header1.Caption     = "C" + CHR(243) + "digo"
                .Header1.FontName    = "Tahoma"
                .Header1.FontBold    = .T.
                .Header1.FontSize    = 8
            ENDWITH

            IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
                loc_nColIdx = 2
                SELECT crSigSyCit
                SCAN
                    IF crSigSyCit.Listas = 1
                        loc_cCampo  = ALLTRIM(crSigSyCit.Campos)
                        loc_cHeader = PROPER(ALLTRIM(crSigSyCit.Descs))

                        DO CASE
                            CASE crSigSyCit.Tipos = "D"
                                loc_nWidth = 80
                            CASE crSigSyCit.Tipos = "N"
                                loc_nWidth = 100
                            CASE !EMPTY(ALLTRIM(crSigSyCit.Pictures))
                                loc_nWidth = MAX(60, LEN(ALLTRIM(crSigSyCit.Pictures)) * 8)
                            OTHERWISE
                                loc_nWidth = 400
                        ENDCASE

                        WITH loc_oGrd.Columns(loc_nColIdx)
                            .ControlSource       = "crSigSyCrs." + loc_cCampo
                            .Width               = loc_nWidth
                            .ReadOnly            = .T.
                            .Header1.Caption     = loc_cHeader
                            .Header1.FontName    = "Tahoma"
                            .Header1.FontBold    = .T.
                            .Header1.FontSize    = 8
                        ENDWITH

                        loc_nColIdx = loc_nColIdx + 1
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.MontarColunasGrid")
        ENDTRY
    ENDPROC

    *===========================================================================
    * MontarObjetos - Popula cnt_4c_Campos com Label+Controle por campo de SigSyCit
    * par_cModo: "INSERIR" | "ALTERAR" | "EXCLUIR" | "CONSULTAR"
    *===========================================================================
    PROCEDURE MontarObjetos(par_cModo)
        LOCAL loc_oCnt, loc_nTop, loc_nLef, loc_nWid, loc_nHei
        LOCAL loc_cObjName, loc_cLblName, loc_lReadOnly
        LOCAL loc_cTipos, loc_cCampo, loc_cDescs, loc_nOrdems, loc_cInputMask
        LOCAL loc_nWidCtrl, loc_nIdx, loc_cNome
        TRY
            THIS.DesmontarObjetos()

            loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos
            loc_lReadOnly = INLIST(UPPER(ALLTRIM(par_cModo)), "EXCLUIR", "CONSULTAR")
            loc_nTop      = 6
            loc_nLef      = 5
            loc_nWid      = loc_oCnt.Width - 30
            THIS.this_nNroControles = 0

            IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCit
                SCAN
                    loc_cCampo     = ALLTRIM(crSigSyCit.Campos)
                    loc_cDescs     = ALLTRIM(crSigSyCit.Descs)
                    loc_cTipos     = ALLTRIM(crSigSyCit.Tipos)
                    loc_nOrdems    = crSigSyCit.Ordems
                    loc_cInputMask = ALLTRIM(crSigSyCit.Pictures)

                    *-- Label
                    loc_cLblName = "lbl_4c_F" + ALLTRIM(STR(loc_nOrdems, 3))
                    loc_oCnt.AddObject(loc_cLblName, "Label")
                    WITH loc_oCnt.&loc_cLblName.
                        .Caption   = PROPER(loc_cDescs)
                        .Top       = loc_nTop
                        .Left      = loc_nLef + 4
                        .FontName  = "Tahoma"
                        .FontBold  = .T.
                        .FontSize  = 8
                        .ForeColor = RGB(0, 0, 128)
                        .BackStyle = 0
                        .AutoSize  = .T.
                        .Visible   = .T.
                    ENDWITH

                    loc_nTop = loc_nTop + 14

                    *-- Controle de entrada
                    loc_cObjName = "txt_4c_F" + ALLTRIM(STR(loc_nOrdems, 3))
                    loc_nHei     = IIF(crSigSyCit.Linhas > 1 OR loc_cTipos = "M", ;
                                       MAX(23, crSigSyCit.Linhas * 16), 23)

                    DO CASE
                        CASE loc_cTipos = "M" AND EMPTY(crSigSyCit.Files)
                            loc_oCnt.AddObject(loc_cObjName, "EditBox")
                            loc_nWidCtrl = IIF(EMPTY(loc_cInputMask), loc_nWid, MIN(loc_nWid, LEN(loc_cInputMask) * 8))
                            WITH loc_oCnt.&loc_cObjName.
                                .Value             = ""
                                .Top               = loc_nTop
                                .Left              = loc_nLef
                                .Width             = loc_nWidCtrl
                                .Height            = loc_nHei
                                .ReadOnly          = loc_lReadOnly
                                .DisabledBackColor = RGB(255, 255, 255)
                                .DisabledForeColor = RGB(0, 0, 128)
                                .FontName          = "Tahoma"
                                .FontSize          = 8
                                .Visible           = .T.
                            ENDWITH

                        CASE loc_cTipos = "D"
                            loc_oCnt.AddObject(loc_cObjName, "TextBox")
                            WITH loc_oCnt.&loc_cObjName.
                                .Value             = CTOD("")
                                .InputMask         = "99/99/9999"
                                .Top               = loc_nTop
                                .Left              = loc_nLef
                                .Width             = 80
                                .Height            = loc_nHei
                                .ReadOnly          = loc_lReadOnly
                                .DisabledBackColor = RGB(255, 255, 255)
                                .DisabledForeColor = RGB(0, 0, 128)
                                .FontName          = "Tahoma"
                                .FontSize          = 8
                                .Visible           = .T.
                            ENDWITH

                        CASE loc_cTipos = "N"
                            loc_nWidCtrl = IIF(EMPTY(loc_cInputMask), 100, MIN(loc_nWid, LEN(loc_cInputMask) * 8))
                            loc_oCnt.AddObject(loc_cObjName, "TextBox")
                            WITH loc_oCnt.&loc_cObjName.
                                .Value             = 0
                                .InputMask         = IIF(EMPTY(loc_cInputMask), "999999999.99", loc_cInputMask)
                                .Top               = loc_nTop
                                .Left              = loc_nLef
                                .Width             = loc_nWidCtrl
                                .Height            = loc_nHei
                                .ReadOnly          = loc_lReadOnly
                                .DisabledBackColor = RGB(255, 255, 255)
                                .DisabledForeColor = RGB(0, 0, 128)
                                .FontName          = "Tahoma"
                                .FontSize          = 8
                                .Visible           = .T.
                            ENDWITH

                        OTHERWISE
                            loc_nWidCtrl = IIF(EMPTY(loc_cInputMask), loc_nWid, MIN(loc_nWid, LEN(loc_cInputMask) * 8))
                            loc_oCnt.AddObject(loc_cObjName, "TextBox")
                            WITH loc_oCnt.&loc_cObjName.
                                .Value             = ""
                                .MaxLength         = IIF(EMPTY(loc_cInputMask), 200, LEN(loc_cInputMask))
                                .Top               = loc_nTop
                                .Left              = loc_nLef
                                .Width             = loc_nWidCtrl
                                .Height            = loc_nHei
                                .ReadOnly          = loc_lReadOnly
                                .DisabledBackColor = RGB(255, 255, 255)
                                .DisabledForeColor = RGB(0, 0, 128)
                                .FontName          = "Tahoma"
                                .FontSize          = 8
                                .Visible           = .T.
                            ENDWITH
                    ENDCASE

                    *-- Registrar no array de controles
                    THIS.this_nNroControles = THIS.this_nNroControles + 1
                    DIMENSION THIS.laControles[THIS.this_nNroControles, 3]
                    THIS.laControles[THIS.this_nNroControles, 1] = loc_cObjName
                    THIS.laControles[THIS.this_nNroControles, 2] = crSigSyCit.Obrigatorios
                    THIS.laControles[THIS.this_nNroControles, 3] = loc_cCampo

                    loc_nTop = loc_nTop + loc_nHei + 4
                ENDSCAN

                *-- Separador antes dos campos fixos de header
                loc_oCnt.AddObject("shp_4c_Sep1", "Shape")
                WITH loc_oCnt.shp_4c_Sep1
                    .Top           = loc_nTop
                    .Left          = 1
                    .Width         = loc_nWid + 9
                    .Height        = 2
                    .SpecialEffect = 0
                    .Visible       = .T.
                ENDWITH
                loc_nTop = loc_nTop + 6

                *-- Labels dos campos fixos (mesma linha)
                loc_oCnt.AddObject("lbl_4c_FEmps", "Label")
                WITH loc_oCnt.lbl_4c_FEmps
                    .Caption   = "Empresa"
                    .Top       = loc_nTop
                    .Left      = loc_nLef + 4
                    .FontName  = "Tahoma"
                    .FontBold  = .T.
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                loc_oCnt.AddObject("lbl_4c_FDopes", "Label")
                WITH loc_oCnt.lbl_4c_FDopes
                    .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                    .Top       = loc_nTop
                    .Left      = loc_nLef + 41
                    .FontName  = "Tahoma"
                    .FontBold  = .T.
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                loc_oCnt.AddObject("lbl_4c_FNumes", "Label")
                WITH loc_oCnt.lbl_4c_FNumes
                    .Caption   = "N" + CHR(250) + "mero"
                    .Top       = loc_nTop
                    .Left      = loc_nLef + 196
                    .FontName  = "Tahoma"
                    .FontBold  = .T.
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                loc_oCnt.AddObject("lbl_4c_FAprova", "Label")
                WITH loc_oCnt.lbl_4c_FAprova
                    .Caption   = "Aprovador"
                    .Top       = loc_nTop
                    .Left      = loc_nLef + 252
                    .FontName  = "Tahoma"
                    .FontBold  = .T.
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                loc_oCnt.AddObject("lbl_4c_FDatas", "Label")
                WITH loc_oCnt.lbl_4c_FDatas
                    .Caption   = "Data Aprov."
                    .Top       = loc_nTop
                    .Left      = loc_nLef + 335
                    .FontName  = "Tahoma"
                    .FontBold  = .T.
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                loc_nTop = loc_nTop + 14

                *-- TextBoxes dos campos fixos
                loc_oCnt.AddObject("txt_4c_FEmps", "TextBox")
                WITH loc_oCnt.txt_4c_FEmps
                    .Value             = ""
                    .MaxLength         = 3
                    .Top               = loc_nTop
                    .Left              = loc_nLef
                    .Width             = 35
                    .Height            = 23
                    .ReadOnly          = loc_lReadOnly
                    .DisabledBackColor = RGB(255, 255, 255)
                    .FontName          = "Tahoma"
                    .FontSize          = 8
                    .Visible           = .T.
                ENDWITH

                loc_oCnt.AddObject("txt_4c_FDopes", "TextBox")
                WITH loc_oCnt.txt_4c_FDopes
                    .Value             = ""
                    .MaxLength         = 20
                    .Top               = loc_nTop
                    .Left              = loc_nLef + 37
                    .Width             = 155
                    .Height            = 23
                    .ReadOnly          = loc_lReadOnly
                    .DisabledBackColor = RGB(255, 255, 255)
                    .FontName          = "Tahoma"
                    .FontSize          = 8
                    .Visible           = .T.
                ENDWITH

                loc_oCnt.AddObject("txt_4c_FNumes", "TextBox")
                WITH loc_oCnt.txt_4c_FNumes
                    .Value             = ""
                    .MaxLength         = 6
                    .Top               = loc_nTop
                    .Left              = loc_nLef + 194
                    .Width             = 54
                    .Height            = 23
                    .ReadOnly          = loc_lReadOnly
                    .DisabledBackColor = RGB(255, 255, 255)
                    .FontName          = "Tahoma"
                    .FontSize          = 8
                    .Visible           = .T.
                ENDWITH

                loc_oCnt.AddObject("txt_4c_FAprova", "TextBox")
                WITH loc_oCnt.txt_4c_FAprova
                    .Value             = ""
                    .MaxLength         = 10
                    .Top               = loc_nTop
                    .Left              = loc_nLef + 250
                    .Width             = 80
                    .Height            = 23
                    .ReadOnly          = .T.
                    .DisabledBackColor = RGB(255, 255, 255)
                    .FontName          = "Tahoma"
                    .FontSize          = 8
                    .Visible           = .T.
                ENDWITH

                loc_oCnt.AddObject("txt_4c_FDatas", "TextBox")
                WITH loc_oCnt.txt_4c_FDatas
                    .Value             = ""
                    .MaxLength         = 20
                    .Top               = loc_nTop
                    .Left              = loc_nLef + 332
                    .Width             = 122
                    .Height            = 23
                    .ReadOnly          = .T.
                    .DisabledBackColor = RGB(255, 255, 255)
                    .FontName          = "Tahoma"
                    .FontSize          = 8
                    .Visible           = .T.
                ENDWITH
            ENDIF

            THIS.this_lMontouObjetos = .T.
            THIS.this_cModoAtual     = par_cModo
            THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = THIS.this_nCodAtual

            THIS.TornarControlesVisiveis(THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.MontarObjetos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * DesmontarObjetos - Remove controles dinamicos de cnt_4c_Campos
    *===========================================================================
    PROCEDURE DesmontarObjetos()
        LOCAL loc_oCnt, loc_cNome, loc_cLbl, loc_nIdx
        LOCAL loc_aFixos[11]
        TRY
            IF THIS.this_lMontouObjetos AND VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos

                FOR loc_nIdx = 1 TO THIS.this_nNroControles
                    loc_cNome = THIS.laControles[loc_nIdx, 1]
                    loc_cLbl  = STRTRAN(loc_cNome, "txt_4c_F", "lbl_4c_F")
                    IF TYPE("loc_oCnt.&loc_cNome.") = "O"
                        loc_oCnt.RemoveObject(loc_cNome)
                    ENDIF
                    IF TYPE("loc_oCnt.&loc_cLbl.") = "O"
                        loc_oCnt.RemoveObject(loc_cLbl)
                    ENDIF
                ENDFOR

                loc_aFixos[1]  = "shp_4c_Sep1"
                loc_aFixos[2]  = "lbl_4c_FEmps"
                loc_aFixos[3]  = "lbl_4c_FDopes"
                loc_aFixos[4]  = "lbl_4c_FNumes"
                loc_aFixos[5]  = "lbl_4c_FAprova"
                loc_aFixos[6]  = "lbl_4c_FDatas"
                loc_aFixos[7]  = "txt_4c_FEmps"
                loc_aFixos[8]  = "txt_4c_FDopes"
                loc_aFixos[9]  = "txt_4c_FNumes"
                loc_aFixos[10] = "txt_4c_FAprova"
                loc_aFixos[11] = "txt_4c_FDatas"

                FOR loc_nIdx = 1 TO 11
                    loc_cNome = loc_aFixos[loc_nIdx]
                    IF TYPE("loc_oCnt.&loc_cNome.") = "O"
                        loc_oCnt.RemoveObject(loc_cNome)
                    ENDIF
                ENDFOR

                THIS.this_lMontouObjetos = .F.
                THIS.this_nNroControles  = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.DesmontarObjetos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CarregarDados - Popula controles com valores do registro (via LocalCadRs)
    *===========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_oCnt, loc_cObjName, loc_cCampo, loc_cTipos, loc_cVal, loc_nIdx, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            IF !THIS.this_lMontouObjetos
                loc_lProsseguir = .F.
            ENDIF
            IF loc_lProsseguir
                loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos

                IF !USED("LocalCadRs")
                    THIS.this_oBusinessObject.ApanhaRespostas()
                ENDIF

                FOR loc_nIdx = 1 TO THIS.this_nNroControles
                    loc_cObjName = THIS.laControles[loc_nIdx, 1]
                    loc_cCampo   = THIS.laControles[loc_nIdx, 3]
    
                    SELECT crSigSyCit
                    LOCATE FOR ALLTRIM(Campos) = loc_cCampo
                    IF !EOF("crSigSyCit")
                        loc_cTipos = ALLTRIM(crSigSyCit.Tipos)
                    ELSE
                        loc_cTipos = "M"
                    ENDIF
    
                    IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR(loc_cCampo, 10), "LocalCadRs", "CodCampos")
                        loc_cVal = ALLTRIM(LocalCadRs.Resps)
                    ELSE
                        loc_cVal = ""
                    ENDIF
    
                    IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
                        DO CASE
                            CASE loc_cTipos = "D"
                                loc_oCnt.&loc_cObjName..Value = IIF(EMPTY(loc_cVal), CTOD(""), CTOD(loc_cVal))
                            CASE loc_cTipos = "N"
                                loc_oCnt.&loc_cObjName..Value = VAL(loc_cVal)
                            OTHERWISE
                                loc_oCnt.&loc_cObjName..Value = loc_cVal
                        ENDCASE
                    ENDIF
                ENDFOR

            *-- Campos fixos
                IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR("Emps", 10), "LocalCadRs", "CodCampos")
                    IF TYPE("loc_oCnt.txt_4c_FEmps") = "O"
                        loc_oCnt.txt_4c_FEmps.Value = ALLTRIM(LocalCadRs.Resps)
                    ENDIF
                ENDIF
                IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR("Dopes", 10), "LocalCadRs", "CodCampos")
                    IF TYPE("loc_oCnt.txt_4c_FDopes") = "O"
                        loc_oCnt.txt_4c_FDopes.Value = ALLTRIM(LocalCadRs.Resps)
                    ENDIF
                ENDIF
                IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR("Numes", 10), "LocalCadRs", "CodCampos")
                    IF TYPE("loc_oCnt.txt_4c_FNumes") = "O"
                        loc_oCnt.txt_4c_FNumes.Value = ALLTRIM(LocalCadRs.Resps)
                    ENDIF
                ENDIF
                IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR("Aprova", 10), "LocalCadRs", "CodCampos")
                    IF TYPE("loc_oCnt.txt_4c_FAprova") = "O"
                        loc_oCnt.txt_4c_FAprova.Value = ALLTRIM(LocalCadRs.Resps)
                    ENDIF
                ENDIF
                IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR("Datas", 10), "LocalCadRs", "CodCampos")
                    IF TYPE("loc_oCnt.txt_4c_FDatas") = "O"
                        loc_oCnt.txt_4c_FDatas.Value = ALLTRIM(LocalCadRs.Resps)
                    ENDIF
                ENDIF

            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.CarregarDados")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GravarDados - Le controles e preenche crGrvCadRs para o BO salvar
    * Retorna .T. se gravou, .F. se falhou
    *===========================================================================
    FUNCTION GravarDados()
        LOCAL loc_oCnt, loc_cObjName, loc_cCampo, loc_cTipos, loc_cVal
        LOCAL loc_lResultado, loc_lGrv, loc_cPicture, loc_cDescs, loc_nIdx
        loc_lResultado = .F.
        TRY
            IF THIS.this_lMontouObjetos AND USED("crGrvCadRs")
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos

            ZAP IN crGrvCadRs

            *-- Campos dinamicos de SigSyCit
            FOR loc_nIdx = 1 TO THIS.this_nNroControles
                loc_cObjName = THIS.laControles[loc_nIdx, 1]
                loc_cCampo   = THIS.laControles[loc_nIdx, 3]

                SELECT crSigSyCit
                LOCATE FOR ALLTRIM(Campos) = loc_cCampo
                IF !EOF("crSigSyCit")
                    loc_cTipos   = ALLTRIM(crSigSyCit.Tipos)
                    loc_cPicture = ALLTRIM(crSigSyCit.Pictures)
                    loc_cDescs   = ALLTRIM(crSigSyCit.Descs)
                ELSE
                    loc_cTipos   = "M"
                    loc_cPicture = ""
                    loc_cDescs   = loc_cCampo
                ENDIF

                IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
                    DO CASE
                        CASE loc_cTipos = "M"
                            loc_cVal = ALLTRIM(loc_oCnt.&loc_cObjName..Value)
                        CASE loc_cTipos = "D"
                            loc_cVal = DTOC(loc_oCnt.&loc_cObjName..Value)
                        CASE loc_cTipos = "N"
                            loc_cVal = ALLTRIM(IIF(EMPTY(loc_cPicture), ;
                                STR(loc_oCnt.&loc_cObjName..Value), ;
                                TRANSFORM(loc_oCnt.&loc_cObjName..Value, loc_cPicture)))
                        OTHERWISE
                            loc_cVal = ALLTRIM(loc_oCnt.&loc_cObjName..Value)
                    ENDCASE

                    IF !EMPTY(loc_cVal)
                        INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                            VALUES (THIS.this_cTits, loc_cCampo, THIS.this_nCodAtual, ;
                                    loc_cVal, loc_cDescs, ;
                                    THIS.this_oBusinessObject.this_lChkApro, .F.)
                    ENDIF
                ENDIF
            ENDFOR

            *-- Campos fixos: Emps, Dopes, Numes (determina ChkSubn)
            loc_lGrv = .T.

            loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FEmps") = "O", ALLTRIM(loc_oCnt.txt_4c_FEmps.Value), "")
            IF !EMPTY(loc_cVal)
                INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                    VALUES (THIS.this_cTits, "Emps", THIS.this_nCodAtual, ;
                            loc_cVal, "Empresa", THIS.this_oBusinessObject.this_lChkApro, .F.)
            ELSE
                loc_lGrv = .F.
            ENDIF

            loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FDopes") = "O", ALLTRIM(loc_oCnt.txt_4c_FDopes.Value), "")
            IF !EMPTY(loc_cVal)
                INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                    VALUES (THIS.this_cTits, "Dopes", THIS.this_nCodAtual, ;
                            loc_cVal, "Opera" + CHR(231) + CHR(227) + "o", ;
                            THIS.this_oBusinessObject.this_lChkApro, .F.)
            ELSE
                loc_lGrv = .F.
            ENDIF

            loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FNumes") = "O", ALLTRIM(loc_oCnt.txt_4c_FNumes.Value), "")
            IF !EMPTY(loc_cVal)
                INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                    VALUES (THIS.this_cTits, "Numes", THIS.this_nCodAtual, ;
                            loc_cVal, "N" + CHR(250) + "mero", ;
                            THIS.this_oBusinessObject.this_lChkApro, .F.)
                INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                    VALUES (THIS.this_cTits, "Baixa", THIS.this_nCodAtual, ;
                            ALLTRIM(gc_4c_UsuarioLogado), "Baixa", ;
                            THIS.this_oBusinessObject.this_lChkApro, .F.)
            ELSE
                loc_lGrv = .F.
            ENDIF

            *-- Aprova/Datas (readonly, preservados se preenchidos)
            loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FAprova") = "O", ALLTRIM(loc_oCnt.txt_4c_FAprova.Value), "")
            IF !EMPTY(loc_cVal)
                INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                    VALUES (THIS.this_cTits, "Aprova", THIS.this_nCodAtual, ;
                            loc_cVal, "Aprovado", .T., loc_lGrv)
            ENDIF

            loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FDatas") = "O", ALLTRIM(loc_oCnt.txt_4c_FDatas.Value), "")
            IF !EMPTY(loc_cVal)
                INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                    VALUES (THIS.this_cTits, "Datas", THIS.this_nCodAtual, ;
                            loc_cVal, "Data", .T., loc_lGrv)
            ENDIF

            *-- ChkSubn = .T. somente quando Emps+Dopes+Numes todos preenchidos
            REPLACE ALL ChkSubn WITH loc_lGrv IN crGrvCadRs

            loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.GravarDados")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * AtualizarBotoesWorkflow - Atualiza estado dos botoes Aprovar/Baixar
    *===========================================================================
    PROCEDURE AtualizarBotoesWorkflow()
        LOCAL loc_oPagina, loc_oAprovar, loc_oBaixar
        TRY
            loc_oPagina  = THIS.pgf_4c_Paginas.Page1
            loc_oAprovar = loc_oPagina.cnt_4c_Workflow.cmd_4c_Aprovar
            loc_oBaixar  = loc_oPagina.cnt_4c_Workflow.cmd_4c_Baixar

            IF USED("crSigSyCrs") AND !EOF("crSigSyCrs")
                IF crSigSyCrs.ChkSubn
                    loc_oAprovar.Enabled = .F.
                    loc_oAprovar.Caption = "Aprovar"
                    loc_oBaixar.Caption  = "Canc Baixa"
                    loc_oBaixar.Enabled  = .T.
                ELSE
                    loc_oAprovar.Enabled = .T.
                    loc_oBaixar.Enabled  = .T.
                    loc_oBaixar.Caption  = "Baixar"
                    IF crSigSyCrs.ChkApro
                        loc_oAprovar.Caption = "Desaprovar"
                    ELSE
                        loc_oAprovar.Caption = "Aprovar"
                    ENDIF
                ENDIF
            ELSE
                loc_oAprovar.Enabled = .F.
                loc_oBaixar.Enabled  = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.AtualizarBotoesWorkflow")
        ENDTRY
    ENDPROC

    *===========================================================================
    * OptFiltroInteractiveChange - Recarrega lista ao mudar filtro
    *===========================================================================
    PROCEDURE OptFiltroInteractiveChange()
        TRY
            THIS.CarregarLista()
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.OptFiltroInteractiveChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GrdAfterRowColChange - Atualiza botoes ao mudar linha do grid
    *===========================================================================
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
        THIS.AtualizarBotoesWorkflow()
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara novo registro
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_nNewCods
        TRY
            loc_nNewCods = THIS.this_oBusinessObject.GerarNovoCods()
            IF loc_nNewCods > 0
                THIS.this_nCodAtual = loc_nNewCods
                THIS.this_oBusinessObject.this_nCods         = loc_nNewCods
                THIS.this_oBusinessObject.this_lNovoRegistro = .T.
                THIS.this_oBusinessObject.this_lEmEdicao     = .T.
                THIS.this_oBusinessObject.this_lChkApro      = .F.
                THIS.this_oBusinessObject.this_lChkSubn      = .F.

                THIS.this_oBusinessObject.InicializarCursores()
                THIS.MontarObjetos("INSERIR")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = loc_nNewCods
                THIS.pgf_4c_Paginas.ActivePage = 2
            ELSE
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar novo c" + ;
                    CHR(243) + "digo.", "Fichas T" + CHR(233) + "cnicas")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Edita registro selecionado no grid
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCods, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
                MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
                loc_lProsseguir = .F.
            ENDIF
            IF loc_lProsseguir
                IF crSigSyCrs.ChkApro OR crSigSyCrs.ChkSubn
                    MsgAviso("Registro aprovado ou baixado n" + CHR(227) + ;
                        "o pode ser alterado.", "Fichas T" + CHR(233) + "cnicas")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_nCods = crSigSyCrs.Cods
                THIS.this_nCodAtual = loc_nCods
                THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCods)
                THIS.this_oBusinessObject.this_lNovoRegistro = .F.
                THIS.this_oBusinessObject.this_lEmEdicao     = .T.
                THIS.this_oBusinessObject.InicializarCursores()
                THIS.MontarObjetos("ALTERAR")
                THIS.CarregarDados()
                THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = loc_nCods
                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCods, loc_lConfirma, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
                MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
                loc_lProsseguir = .F.
            ENDIF
            IF loc_lProsseguir
                IF crSigSyCrs.ChkApro OR crSigSyCrs.ChkSubn
                    MsgAviso("Registro aprovado ou baixado n" + CHR(227) + "o pode ser exclu" + ;
                        CHR(237) + "do.", "Fichas T" + CHR(233) + "cnicas")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro " + ;
                    ALLTRIM(STR(crSigSyCrs.Cods)) + "?", "Excluir Ficha")
                IF loc_lConfirma
                    loc_nCods = crSigSyCrs.Cods
                    THIS.this_oBusinessObject.this_nCods = loc_nCods
                    THIS.this_oBusinessObject.this_cTits = THIS.this_cTits
                    IF THIS.this_oBusinessObject.Excluir()
                        THIS.this_oBusinessObject.ApanhaRespostas()
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Exibe registro selecionado em modo leitura
    * Legado: grupo_op.consultar -> pcEscolha = 'CONSULTAR' (campos ReadOnly)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCods, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
                MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_nCods = crSigSyCrs.Cods
                THIS.this_nCodAtual = loc_nCods
                THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCods)
                THIS.this_oBusinessObject.this_lNovoRegistro = .F.
                THIS.MontarObjetos("CONSULTAR")
                THIS.CarregarDados()
                THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = loc_nCods
                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Localiza um registro pelo codigo (modo PROCURAR)
    * Legado: grupo_op.procurar -> pcEscolha = 'PROCURAR'; o unico modo em que
    * getCods fica Enabled (grupo_op.Click) e msv_procurar faz o Locate.
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            IF !USED("crSigSyCrs")
                MsgAviso("Nenhum registro dispon" + CHR(237) + "vel.", ;
                    "Fichas T" + CHR(233) + "cnicas")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                THIS.this_oBusinessObject.this_lNovoRegistro = .F.
                THIS.MontarObjetos("PROCURAR")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value   = 0
                *-- legado: loDad.getCods.Enabled = .t. SOMENTE em PROCURAR
                THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Enabled = .T.
                THIS.pgf_4c_Paginas.ActivePage = 2
                THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ExecutarProcurar - msv_procurar do legado: Locate For Cods = getCods.Value
    *===========================================================================
    PROTECTED PROCEDURE ExecutarProcurar()
        LOCAL loc_nCods
        loc_nCods = THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value

        IF USED("crSigSyCrs")
            SELECT crSigSyCrs
            LOCATE FOR crSigSyCrs.Cods = loc_nCods
            IF !FOUND()
                MsgAviso("Registro n" + CHR(227) + "o encontrado.", ;
                    "Fichas T" + CHR(233) + "cnicas")
            ENDIF
        ENDIF

        *-- legado: getCods volta desabilitado ao sair do modo PROCURAR
        THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Enabled = .F.
        THIS.DesmontarObjetos()
        THIS.pgf_4c_Paginas.ActivePage = 1
        THIS.this_cModoAtual = "LISTA"
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida, grava em crGrvCadRs e persiste via BO
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_nIdx, loc_cObjName, loc_oCnt, loc_lValido, loc_lProsseguir
        LOCAL loc_cEmps, loc_cDopes, loc_cNumes, loc_lSoDigitos, loc_nChr
        LOCAL loc_cEDN, loc_nResult
        loc_lProsseguir = .T.
        TRY
            *-- legado: no modo PROCURAR o Confirmar executa msv_procurar
            IF THIS.this_cModoAtual = "PROCURAR"
                THIS.ExecutarProcurar()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
                THIS.BtnCancelarClick()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oCnt    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos
                loc_lValido = .T.

            *-- Validar campos obrigatorios
                FOR loc_nIdx = 1 TO THIS.this_nNroControles
                    IF THIS.laControles[loc_nIdx, 2] = 1
                        loc_cObjName = THIS.laControles[loc_nIdx, 1]
                        IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
                            IF EMPTY(loc_oCnt.&loc_cObjName..Value)
                                MsgAviso("Campo de preenchimento obrigat" + CHR(243) + "rio n" + ;
                                    CHR(227) + "o preenchido.", "Fichas T" + CHR(233) + "cnicas")
                                loc_oCnt.&loc_cObjName..SetFocus()
                                loc_lValido = .F.
                                EXIT
                            ENDIF
                        ENDIF
                    ENDIF
                ENDFOR

                IF !loc_lValido
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            *-- Validar Numes (somente digitos, se preenchido)
            IF loc_lProsseguir
                loc_cNumes = IIF(TYPE("loc_oCnt.txt_4c_FNumes") = "O", ALLTRIM(loc_oCnt.txt_4c_FNumes.Value), "")
                IF !EMPTY(loc_cNumes)
                    loc_lSoDigitos = .T.
                    FOR loc_nChr = 1 TO LEN(loc_cNumes)
                        IF !ISDIGIT(SUBSTR(loc_cNumes, loc_nChr, 1))
                            loc_lSoDigitos = .F.
                            EXIT
                        ENDIF
                    ENDFOR
                    IF !loc_lSoDigitos
                        MsgAviso("O N" + CHR(250) + "mero da Opera" + CHR(231) + CHR(227) + ;
                            "o digitado n" + CHR(227) + "o " + CHR(233) + " v" + CHR(225) + "lido.", ;
                            "Fichas T" + CHR(233) + "cnicas")
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- Obter valores dos campos header
            IF loc_lProsseguir
                loc_cEmps  = IIF(TYPE("loc_oCnt.txt_4c_FEmps")  = "O", ALLTRIM(loc_oCnt.txt_4c_FEmps.Value),  "")
                loc_cDopes = IIF(TYPE("loc_oCnt.txt_4c_FDopes") = "O", ALLTRIM(loc_oCnt.txt_4c_FDopes.Value), "")
                loc_cNumes = IIF(TYPE("loc_oCnt.txt_4c_FNumes") = "O", ALLTRIM(loc_oCnt.txt_4c_FNumes.Value), "")

            *-- Empresa obrigatoria quando Dopes e Numes informados
                IF EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND !EMPTY(loc_cNumes)
                    MsgAviso(CHR(201) + " necess" + CHR(225) + "rio preencher a Empresa ao informar" + ;
                        " a Opera" + CHR(231) + CHR(227) + "o e o N" + CHR(250) + "mero.", ;
                        "Fichas T" + CHR(233) + "cnicas")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            *-- Se Emps+Dopes+Numes preenchidos: deve estar aprovado + validar SigMvCab
            IF loc_lProsseguir
                IF !EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND !EMPTY(loc_cNumes)
                    IF !THIS.this_oBusinessObject.this_lChkApro
                        MsgAviso("Baixa n" + CHR(227) + "o Aprovada!", "Fichas T" + CHR(233) + "cnicas")
                        loc_lProsseguir = .F.
                    ENDIF
                    IF loc_lProsseguir
                        loc_cEDN    = PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + PADL(loc_cNumes, 6)
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT TOP 1 EmpDopNums FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEDN), ;
                            "cursor_4c_ValidaEDN")
                        IF loc_nResult > 0
                            IF EOF("cursor_4c_ValidaEDN")
                                MsgAviso("A Opera" + CHR(231) + CHR(227) + "o com o N" + CHR(250) + ;
                                    "mero digitado n" + CHR(227) + "o foi encontrada na Empresa.", ;
                                    "Fichas T" + CHR(233) + "cnicas")
                                USE IN cursor_4c_ValidaEDN
                                loc_lProsseguir = .F.
                            ENDIF
                            IF loc_lProsseguir
                                USE IN cursor_4c_ValidaEDN
                            ENDIF
                        ELSE
                            MsgErro("Erro ao validar SigMvCab:" + CHR(13) + CapturarErroSQL(), ;
                                "FormDrs.BtnSalvarClick")
                            loc_lProsseguir = .F.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- Gravar controles em crGrvCadRs e persistir via BO
            IF loc_lProsseguir
                IF THIS.GravarDados()
                    THIS.this_oBusinessObject.this_nCods = THIS.this_nCodAtual
                    THIS.this_oBusinessObject.this_cTits = THIS.this_cTits
                    IF THIS.this_oBusinessObject.Salvar()
                        THIS.this_oBusinessObject.ApanhaRespostas()
                        THIS.DesmontarObjetos()
                        THIS.pgf_4c_Paginas.ActivePage = 1
                        THIS.this_cModoAtual = "LISTA"
                        THIS.CarregarLista()
                    ENDIF
                ENDIF

            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Descarta edicao e volta para lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.DesmontarObjetos()
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnAprovarClick - Aprova ou Desaprova o registro selecionado
    *===========================================================================
    PROCEDURE BtnAprovarClick()
        LOCAL loc_oAprovar, loc_lConfirma, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
                MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oAprovar = THIS.pgf_4c_Paginas.Page1.cnt_4c_Workflow.cmd_4c_Aprovar

                IF !crSigSyCrs.ChkApro
                    loc_lConfirma = MsgConfirma("Confirma Aprova" + CHR(231) + CHR(227) + "o?", ;
                        "Fichas T" + CHR(233) + "cnicas")
                    IF loc_lConfirma
                        THIS.this_oBusinessObject.this_nCods = crSigSyCrs.Cods
                        IF THIS.this_oBusinessObject.Aprovar(ALLTRIM(gc_4c_UsuarioLogado))
                            SELECT crSigSyCrs
                            REPLACE crSigSyCrs.ChkApro WITH .T.
                            loc_oAprovar.Caption = "Desaprovar"
                            THIS.AtualizarBotoesWorkflow()
                            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                        ENDIF
                    ENDIF
                ELSE
                    loc_lConfirma = MsgConfirma("Confirma Desaprova" + CHR(231) + CHR(227) + "o?", ;
                        "Fichas T" + CHR(233) + "cnicas")
                    IF loc_lConfirma
                        THIS.this_oBusinessObject.this_nCods = crSigSyCrs.Cods
                        IF THIS.this_oBusinessObject.Desaprovar()
                            SELECT crSigSyCrs
                            REPLACE crSigSyCrs.ChkApro WITH .F.
                            loc_oAprovar.Caption = "Aprovar"
                            THIS.AtualizarBotoesWorkflow()
                            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnAprovarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBaixarClick - Baixa (abre Page2 em ALTERAR) ou Cancela Baixa
    *===========================================================================
    PROCEDURE BtnBaixarClick()
        LOCAL loc_oBaixar, loc_lConfirma, loc_nCods, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
                MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oBaixar = THIS.pgf_4c_Paginas.Page1.cnt_4c_Workflow.cmd_4c_Baixar

                IF !crSigSyCrs.ChkSubn
                    *-- Baixar: exige aprovacao previa
                    IF !crSigSyCrs.ChkApro
                        MsgAviso("Baixa n" + CHR(227) + "o Aprovada!", "Fichas T" + CHR(233) + "cnicas")
                        loc_lProsseguir = .F.
                    ENDIF
                    *-- Abre Page2 em modo ALTERAR para preencher Emps/Dopes/Numes
                    IF loc_lProsseguir
                        loc_nCods = crSigSyCrs.Cods
                        THIS.this_nCodAtual = loc_nCods
                        THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCods)
                        THIS.this_oBusinessObject.this_lNovoRegistro = .F.
                        THIS.this_oBusinessObject.this_lEmEdicao     = .T.
                        THIS.this_oBusinessObject.InicializarCursores()
                        THIS.MontarObjetos("ALTERAR")
                        THIS.CarregarDados()
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = loc_nCods
                        THIS.pgf_4c_Paginas.ActivePage = 2
                        THIS.this_cModoAtual = "ALTERAR"
                    ENDIF
                ELSE
                    *-- Cancelar Baixa
                    loc_lConfirma = MsgConfirma("Confirma Cancelamento da Baixa?", ;
                        "Fichas T" + CHR(233) + "cnicas")
                    IF loc_lConfirma
                        IF THIS.this_oBusinessObject.CancelarBaixa(crSigSyCrs.Cods)
                            SELECT crSigSyCrs
                            REPLACE crSigSyCrs.ChkSubn WITH .F.
                            loc_oBaixar.Caption = "Baixar"
                            THIS.AtualizarBotoesWorkflow()
                            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnBaixarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *===========================================================================
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

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * Destroy - Limpa recursos ao fechar
    *===========================================================================
    PROCEDURE Destroy()
        TRY
            THIS.DesmontarObjetos()
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.FecharCursores()
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE

