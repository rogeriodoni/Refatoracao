*==============================================================================
* FormCmr.prg - Formulario de Cadastro de Itens de Mapa de Resultados
* Data: 2026-07-29
* Tabela: SigCdMri | PK: CidChaves | FK: Balancos -> SigCdMrr.Balancos
* Legado: SIGCDCMR.SCX (frmcadastro) - form filho, aberto pelo form de Mapas
*==============================================================================

DEFINE CLASS FormCmr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Itens"
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
    this_cModoAtual      = "LISTA"
    this_cBalancos       = ""   && FK: balanco pai
    this_nMapas          = 0    && 1=normal, 2=com titulo de coluna
    this_cCidChavesAtual = ""   && PK do registro selecionado na lista
    this_lAltSubtot      = .T.  && .T. se pode marcar SubTot100s=1

    *==========================================================================
    * INICIALIZACAO
    *==========================================================================

    PROCEDURE Init(par_cBalancos, par_nMapas)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF PCOUNT() >= 1 AND VARTYPE(par_cBalancos) = "C"
                THIS.this_cBalancos = ALLTRIM(par_cBalancos)
                THIS.Caption = "Itens : " + ALLTRIM(par_cBalancos)
            ENDIF
            IF PCOUNT() >= 2 AND VARTYPE(par_nMapas) = "N"
                THIS.this_nMapas = par_nMapas
            ENDIF

            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MostrarErro("Erro ao inicializar FormCmr:" + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                        loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("CmrBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar Business Object CmrBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.this_oBusinessObject.this_cBalancos = THIS.this_cBalancos

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo") = "O"
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                ENDIF

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormCmr:" + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                        loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CONFIGURACAO PAGEFRAME
    *==========================================================================

    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 629
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
    * CONFIGURACAO PAGE1 - LISTA
    * Compensacao +29: Grupo_op.Top=-1 -> 28; cntSombra.Top=2 -> 31
    *==========================================================================

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container Cabecalho (cntSombra no legado, Top=2+29=31)
        *----------------------------------------------------------------------
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
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 10
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 10
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Container Botoes CRUD (Grupo_op no legado)
        * Legado: Left=344(800px) -> proporcional 542(1000px), Top=-1+29=28
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
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
            .Visible         = .T.
        ENDWITH

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
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
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
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
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
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
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
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Container Saida - PADRAO CANONICO (Left=917, Width=90, Top=29)
        *----------------------------------------------------------------------
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
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Grid de Lista (Grade no legado)
        * Colunas na ordem do legado: Classes, Nivels, Oper, Grupos, A/S, DescGrps, Fator, Titulo, Ordem
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 9
        loc_oPagina.grd_4c_Lista.RecordSource = ""

        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 12
            .Width              = 900
            .Height             = 455
            .FontName           = "Tahoma"
            .FontSize           = 8
            .RowHeight          = 16
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.

            .Column1.Width          = 80
            .Column1.Alignment      = 0
            .Column1.Header1.Caption = "Classe"

            .Column2.Width          = 33
            .Column2.Alignment      = 1
            .Column2.Header1.Caption = "N" + CHR(237) + "vel"

            .Column3.Width          = 40
            .Column3.Alignment      = 1
            .Column3.Header1.Caption = "Oper"

            .Column4.Width          = 80
            .Column4.Alignment      = 0
            .Column4.Header1.Caption = "Grupo"

            .Column5.Width          = 30
            .Column5.Alignment      = 1
            .Column5.Header1.Caption = "A/S"

            .Column6.Width          = 220
            .Column6.Alignment      = 0
            .Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            .Column7.Width          = 40
            .Column7.Alignment      = 1
            .Column7.Header1.Caption = "Fator"

            .Column8.Width          = 80
            .Column8.Alignment      = 0
            .Column8.Header1.Caption = "T" + CHR(237) + "tulo"

            .Column9.Width          = 50
            .Column9.Alignment      = 1
            .Column9.Header1.Caption = "Ordem"
        ENDWITH

        *----------------------------------------------------------------------
        * BINDEVENTs - botoes Page1 (metodos PUBLIC para BINDEVENT)
        *----------------------------------------------------------------------
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CONFIGURACAO PAGE2 - DADOS
    * Todos os controles com compensacao +29 de PageFrame.Top=-29
    *==========================================================================

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container BotoesAcao (Grupo_Salva: Top=4+29=33, Left=842)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
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
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
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
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Container Saida Page2 - PADRAO CANONICO
        *----------------------------------------------------------------------
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
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * optTpregs - Tipo de registro (Top=175+29=204)
        * Button 1: "\<Grupo" (Left=5, Value=1=Grupo)
        * Button 2: "\<SubTotal" (Left=120, Value=2=SubTotal)
        * Button 3: "Classe" (Left=59, Value=3=Classe)
        * Nota: Buttons visualmente em ordem Grupo/Classe/SubTotal (Left: 5/59/120)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("obj_4c_OptTpregs", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptTpregs
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 204
            .Left        = 304
            .Width       = 185
            .Height      = 26
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTpregs.Buttons(1)
            .Caption   = "\<Grupo"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 47
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTpregs.Buttons(2)
            .Caption   = "\<SubTotal"
            .BackStyle = 0
            .Left      = 120
            .Top       = 6
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTpregs.Buttons(3)
            .Caption   = "Classe"
            .BackStyle = 0
            .Left      = 59
            .Top       = 5
            .Width     = 49
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Say1: Descricao SubTotal (Top=211+29=240)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o SubTotal :"
            .Top       = 240
            .Left      = 197
            .Width     = 103
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getDescgrps (Top=205+29=234)
        loc_oPagina.AddObject("txt_4c_Descgrps", "TextBox")
        WITH loc_oPagina.txt_4c_Descgrps
            .Top       = 234
            .Left      = 304
            .Width     = 220
            .Height    = 25
            .MaxLength = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say6: Ordem (Top=210+29=239)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Ordem :"
            .Top       = 239
            .Left      = 526
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getOrdems (Top=206+29=235)
        loc_oPagina.AddObject("txt_4c_Ordems", "TextBox")
        WITH loc_oPagina.txt_4c_Ordems
            .Top       = 235
            .Left      = 574
            .Width     = 31
            .Height    = 25
            .InputMask = "999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- lbl_grupos (Top=236+29=265)
        loc_oPagina.AddObject("lbl_4c_Lbl_grupos", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_grupos
            .Caption   = "Grupo :"
            .Top       = 265
            .Left      = 262
            .Width     = 38
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- get_cd_grupos (Top=231+29=260)
        loc_oPagina.AddObject("txt_4c__cd_grupos", "TextBox")
        WITH loc_oPagina.txt_4c__cd_grupos
            .Top       = 260
            .Left      = 304
            .Width     = 80
            .Height    = 25
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- get_ds_grupos (Top=231+29=260)
        loc_oPagina.AddObject("txt_4c__ds_grupos", "TextBox")
        WITH loc_oPagina.txt_4c__ds_grupos
            .Top       = 260
            .Left      = 385
            .Width     = 150
            .Height    = 25
            .MaxLength = 20
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say4: Classe (Top=263+29=292)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Classe :"
            .Top       = 292
            .Left      = 260
            .Width     = 40
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_classe (Top=257+29=286)
        loc_oPagina.AddObject("txt_4c_Classe", "TextBox")
        WITH loc_oPagina.txt_4c_Classe
            .Top       = 286
            .Left      = 304
            .Width     = 80
            .Height    = 25
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_dclasse (Top=257+29=286)
        loc_oPagina.AddObject("txt_4c_Dclasse", "TextBox")
        WITH loc_oPagina.txt_4c_Dclasse
            .Top       = 286
            .Left      = 385
            .Width     = 220
            .Height    = 25
            .MaxLength = 20
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- lbl_operacaos (Top=289+29=318)
        loc_oPagina.AddObject("lbl_4c_Lbl_operacaos", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_operacaos
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 318
            .Left      = 244
            .Width     = 56
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- cmb_operacaos (Top=283+29=312, Style=2 dropdown list)
        loc_oPagina.AddObject("cbo_4c_Cmb_operacaos", "ComboBox")
        WITH loc_oPagina.cbo_4c_Cmb_operacaos
            .Top       = 312
            .Left      = 304
            .Width     = 150
            .Height    = 25
            .Style     = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.cbo_4c_Cmb_operacaos.AddItem(PADR("(+) Soma",    15))
        loc_oPagina.cbo_4c_Cmb_operacaos.AddItem(PADR("(-) Subtrai", 15))
        loc_oPagina.cbo_4c_Cmb_operacaos.ListIndex = 1

        *-- lbl_analitico (Top=313+29=342)
        loc_oPagina.AddObject("lbl_4c_Lbl_analitico", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_analitico
            .Caption   = "Impress" + CHR(227) + "o Anal" + CHR(237) + "tica :"
            .Top       = 342
            .Left      = 198
            .Width     = 102
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- opt_analiticos (Top=308+29=337)
        loc_oPagina.AddObject("obj_4c_Opt_analiticos", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opt_analiticos
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 337
            .Left        = 304
            .Width       = 97
            .Height      = 25
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_analiticos.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_analiticos.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 51
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Say5: Contra Partida (Top=335+29=364)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Contra Partida :"
            .Top       = 364
            .Left      = 221
            .Width     = 79
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Opt_CPartida (Top=330+29=359, default Value=2=Nao)
        loc_oPagina.AddObject("obj_4c_Opt_CPartida", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opt_CPartida
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Top         = 359
            .Left        = 304
            .Width       = 97
            .Height      = 25
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_CPartida.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_CPartida.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 51
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Say7: SubTotal 100% (Top=358+29=387)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "SubTotal 100% :"
            .Top       = 387
            .Left      = 217
            .Width     = 83
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- opt_subtot100 (Top=354+29=383, default Value=2=Nao)
        loc_oPagina.AddObject("obj_4c_Opt_subtot100", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opt_subtot100
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Top         = 383
            .Left        = 304
            .Width       = 97
            .Height      = 25
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_subtot100.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_Opt_subtot100.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 51
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Say2: Fator (Top=383+29=412)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Fator :"
            .Top       = 412
            .Left      = 265
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- fator (Top=380+29=409, default 100)
        loc_oPagina.AddObject("txt_4c_Fator", "TextBox")
        WITH loc_oPagina.txt_4c_Fator
            .Top       = 409
            .Left      = 304
            .Width     = 31
            .Height    = 25
            .InputMask = "999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Say3: % (Top=384+29=413)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "%"
            .Top       = 413
            .Left      = 343
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- sayTitulo (Top=407+29=436) - visivel somente quando Mapas=2
        loc_oPagina.AddObject("lbl_4c_SayTitulo", "Label")
        WITH loc_oPagina.lbl_4c_SayTitulo
            .Caption   = "T" + CHR(237) + "tulo :"
            .Top       = 436
            .Left      = 265
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = (THIS.this_nMapas = 2)
        ENDWITH

        *-- getTitulo (Top=404+29=433) - visivel somente quando Mapas=2
        loc_oPagina.AddObject("txt_4c_Titulo", "TextBox")
        WITH loc_oPagina.txt_4c_Titulo
            .Top         = 433
            .Left        = 304
            .Width       = 80
            .Height      = 25
            .InputMask   = "!!!!!!!!!!"
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .ToolTipText = "Cabe" + CHR(231) + "alho da Coluna no Relat" + CHR(243) + "rio"
            .Visible     = (THIS.this_nMapas = 2)
        ENDWITH

        *-- SayDtitulo (Top=410+29=439) - visivel somente quando Mapas=2
        loc_oPagina.AddObject("lbl_4c_Dtitulo", "Label")
        WITH loc_oPagina.lbl_4c_Dtitulo
            .Caption   = "(Emiss" + CHR(227) + "o de Mapa)"
            .Top       = 439
            .Left      = 388
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = (THIS.this_nMapas = 2)
        ENDWITH

        *-- Say8: Checar Data (Top=436+29=465)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Checar Data :"
            .Top       = 465
            .Left      = 231
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- optTpDatas (Top=431+29=460)
        *-- Button 1: Emissao(1), Button 2: Lancamento(2), Button 3: Vencimento(3=default), Button 4: Baixa(4)
        loc_oPagina.AddObject("obj_4c_OptTpDatas", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptTpDatas
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 3
            .Top         = 460
            .Left        = 298
            .Width       = 320
            .Height      = 25
            .AutoSize    = .T.
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTpDatas.Buttons(1)
            .Caption   = "Emiss" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .Width     = 56
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTpDatas.Buttons(2)
            .Caption   = "Lan" + CHR(231) + "amento"
            .BackStyle = 0
            .Left      = 78
            .Top       = 5
            .Width     = 76
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTpDatas.Buttons(3)
            .Caption   = "Vencimento"
            .BackStyle = 0
            .Left      = 173
            .Top       = 5
            .Width     = 73
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTpDatas.Buttons(4)
            .Caption   = "Baixa"
            .BackStyle = 0
            .Left      = 266
            .Top       = 5
            .Width     = 44
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *----------------------------------------------------------------------
        * BINDEVENTs Page2
        *----------------------------------------------------------------------
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,       "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.obj_4c_OptTpregs,     "InteractiveChange", THIS, "OptTpregsChanged")
        BINDEVENT(loc_oPagina.txt_4c__cd_grupos,    "KeyPress",        THIS, "ValidarGrupo")
        BINDEVENT(loc_oPagina.txt_4c__ds_grupos,    "KeyPress",        THIS, "ValidarDescGrupo")
        BINDEVENT(loc_oPagina.txt_4c_Classe,        "KeyPress",        THIS, "ValidarClasse")
        BINDEVENT(loc_oPagina.txt_4c_Dclasse,       "KeyPress",        THIS, "ValidarDescClasse")
        BINDEVENT(loc_oPagina.txt_4c_Titulo,        "LostFocus",        THIS, "ValidarTitulo")

        *-- F4/DblClick para campos de lookup (equivalente ao evento Valid+F4 do fwget legado)
        BINDEVENT(loc_oPagina.txt_4c__cd_grupos, "KeyPress", THIS, "CdGruposKeyPress")
        BINDEVENT(loc_oPagina.txt_4c__cd_grupos, "DblClick", THIS, "AbrirLookupGrupo")
        BINDEVENT(loc_oPagina.txt_4c__ds_grupos, "KeyPress", THIS, "DsGruposKeyPress")
        BINDEVENT(loc_oPagina.txt_4c__ds_grupos, "DblClick", THIS, "AbrirLookupGrupoDesc")
        BINDEVENT(loc_oPagina.txt_4c_Classe,     "KeyPress", THIS, "ClasseKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Classe,     "DblClick", THIS, "AbrirLookupClasse")
        BINDEVENT(loc_oPagina.txt_4c_Dclasse,    "KeyPress", THIS, "DclasseKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Dclasse,    "DblClick", THIS, "AbrirLookupClasseDesc")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CARREGAR LISTA - preenche o grid com dados do cursor
    *==========================================================================

    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF NOT USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (CidChaves C(20), Balancos C(20), ;
                    Tpregs N(1), Grupos C(10), DescGrps C(30), Classes C(10), ;
                    Analiticos N(1), Operacaos C(1), Cpartidas N(1), Subtot100s N(1), ;
                    Fators N(3), Titulos C(10), Ordems N(3), TpDatas N(1), Nivels N(1))
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource FORA do WITH (garante criacao das colunas)
                    loc_oGrid.ColumnCount = 9
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    *-- Re-definir ControlSource e Headers APOS RecordSource
                    WITH loc_oGrid
                        *-- Column1: Classe (mostra Classes se Grupos vazio, senao branco)
                        .Column1.ControlSource  = "iif(EMPTY(cursor_4c_Dados.Grupos),cursor_4c_Dados.Classes,'')"
                        .Column1.Header1.Caption = "Classe"
                        .Column1.Width  = 80
                        .Column1.Alignment = 0

                        *-- Column2: Nivel
                        .Column2.ControlSource  = "cursor_4c_Dados.Nivels"
                        .Column2.Header1.Caption = "N" + CHR(237) + "vel"
                        .Column2.Width  = 33
                        .Column2.Alignment = 1

                        *-- Column3: Operacao (+/-) com indicador visual
                        .Column3.ControlSource  = "iif(cursor_4c_Dados.Operacaos='-','[-]','[+]')"
                        .Column3.Header1.Caption = "Oper"
                        .Column3.Width  = 40
                        .Column3.Alignment = 1

                        *-- Column4: Grupo
                        .Column4.ControlSource  = "cursor_4c_Dados.Grupos"
                        .Column4.Header1.Caption = "Grupo"
                        .Column4.Width  = 80
                        .Column4.Alignment = 0

                        *-- Column5: Analitico/Sintetico
                        .Column5.ControlSource  = "iif(cursor_4c_Dados.Analiticos=1,'A','S')"
                        .Column5.Header1.Caption = "A/S"
                        .Column5.Width  = 30
                        .Column5.Alignment = 1

                        *-- Column6: Descricao SubTotal
                        .Column6.ControlSource  = "cursor_4c_Dados.DescGrps"
                        .Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        .Column6.Width  = 220
                        .Column6.Alignment = 0

                        *-- Column7: Fator %
                        .Column7.ControlSource  = "cursor_4c_Dados.Fators"
                        .Column7.Header1.Caption = "Fator"
                        .Column7.Width  = 40
                        .Column7.Alignment = 1

                        *-- Column8: Titulo de coluna
                        .Column8.ControlSource  = "cursor_4c_Dados.Titulos"
                        .Column8.Header1.Caption = "T" + CHR(237) + "tulo"
                        .Column8.Width  = 80
                        .Column8.Alignment = 0

                        *-- Column9: Ordem
                        .Column9.ControlSource  = "cursor_4c_Dados.Ordems"
                        .Column9.Header1.Caption = "Ordem"
                        .Column9.Width  = 50
                        .Column9.Alignment = 1
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar lista: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ALTERNAR PAGINA
    *==========================================================================

    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao alternar p" + CHR(225) + "gina: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * HABILITAR/DESABILITAR CAMPOS
    *==========================================================================

    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.obj_4c_OptTpregs.Enabled                   = par_lHabilitar
        loc_oPg2.txt_4c_Descgrps.Enabled                    = par_lHabilitar
        loc_oPg2.txt_4c_Ordems.Enabled                      = par_lHabilitar
        loc_oPg2.txt_4c__cd_grupos.Enabled                  = par_lHabilitar
        loc_oPg2.txt_4c__ds_grupos.Enabled                  = par_lHabilitar AND .F.
        loc_oPg2.txt_4c_Classe.Enabled                      = par_lHabilitar
        loc_oPg2.txt_4c_Dclasse.Enabled                     = par_lHabilitar AND .F.
        loc_oPg2.cbo_4c_Cmb_operacaos.Enabled               = par_lHabilitar
        loc_oPg2.obj_4c_Opt_analiticos.Buttons(1).Enabled   = par_lHabilitar
        loc_oPg2.obj_4c_Opt_analiticos.Buttons(2).Enabled   = par_lHabilitar
        loc_oPg2.obj_4c_Opt_CPartida.Buttons(1).Enabled     = par_lHabilitar
        loc_oPg2.obj_4c_Opt_CPartida.Buttons(2).Enabled     = par_lHabilitar
        loc_oPg2.obj_4c_Opt_subtot100.Buttons(1).Enabled    = par_lHabilitar
        loc_oPg2.obj_4c_Opt_subtot100.Buttons(2).Enabled    = par_lHabilitar
        loc_oPg2.txt_4c_Fator.Enabled                       = par_lHabilitar
        loc_oPg2.txt_4c_Titulo.Enabled                      = par_lHabilitar
        loc_oPg2.obj_4c_OptTpDatas.Buttons(1).Enabled       = par_lHabilitar
        loc_oPg2.obj_4c_OptTpDatas.Buttons(2).Enabled       = par_lHabilitar
        loc_oPg2.obj_4c_OptTpDatas.Buttons(3).Enabled       = par_lHabilitar
        loc_oPg2.obj_4c_OptTpDatas.Buttons(4).Enabled       = par_lHabilitar

        *-- Confirmar/Cancelar: visiveis somente em modo edicao
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.

        *-- Refinar habilitacao por tipo (Tpregs) quando habilitando
        IF par_lHabilitar
            THIS.OptTpregsChanged()
        ENDIF
    ENDPROC

    *==========================================================================
    * LIMPAR CAMPOS
    *==========================================================================

    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.obj_4c_OptTpregs.Value             = 1
        loc_oPg2.txt_4c_Descgrps.Value              = ""
        loc_oPg2.txt_4c_Ordems.Value                = 0
        loc_oPg2.txt_4c__cd_grupos.Value            = ""
        loc_oPg2.txt_4c__ds_grupos.Value            = ""
        loc_oPg2.txt_4c_Classe.Value                = ""
        loc_oPg2.txt_4c_Dclasse.Value               = ""
        loc_oPg2.cbo_4c_Cmb_operacaos.ListIndex     = 1
        loc_oPg2.obj_4c_Opt_analiticos.Value        = 1
        loc_oPg2.obj_4c_Opt_CPartida.Value          = 2
        loc_oPg2.obj_4c_Opt_subtot100.Value         = 2
        loc_oPg2.txt_4c_Fator.Value                 = 100
        loc_oPg2.obj_4c_OptTpDatas.Value            = 3
        IF THIS.this_nMapas = 2
            loc_oPg2.txt_4c_Titulo.Value            = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * FORM PARA BO (transfere campos do formulario para o Business Object)
    *==========================================================================

    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_nListIdx
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_nTpregs    = loc_oPg2.obj_4c_OptTpregs.Value
        THIS.this_oBusinessObject.this_cDescGrps  = ALLTRIM(loc_oPg2.txt_4c_Descgrps.Value)
        THIS.this_oBusinessObject.this_nOrdems    = loc_oPg2.txt_4c_Ordems.Value
        THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPg2.txt_4c__cd_grupos.Value)
        THIS.this_oBusinessObject.this_cClasses   = ALLTRIM(loc_oPg2.txt_4c_Classe.Value)
        THIS.this_oBusinessObject.this_nAnaliticos = loc_oPg2.obj_4c_Opt_analiticos.Value
        THIS.this_oBusinessObject.this_nCpartidas  = loc_oPg2.obj_4c_Opt_CPartida.Value
        THIS.this_oBusinessObject.this_nSubtot100s = loc_oPg2.obj_4c_Opt_subtot100.Value
        THIS.this_oBusinessObject.this_nFators    = loc_oPg2.txt_4c_Fator.Value
        THIS.this_oBusinessObject.this_nTpDatas   = loc_oPg2.obj_4c_OptTpDatas.Value
        THIS.this_oBusinessObject.this_cBalancos  = THIS.this_cBalancos

        IF THIS.this_nMapas = 2
            THIS.this_oBusinessObject.this_cTitulos = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)
        ENDIF

        loc_nListIdx = loc_oPg2.cbo_4c_Cmb_operacaos.ListIndex
        THIS.this_oBusinessObject.this_cOperacaos = IIF(loc_nListIdx = 1, "+", "-")
    ENDPROC

    *==========================================================================
    * BO PARA FORM (carrega propriedades do BO nos campos do formulario)
    *==========================================================================

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO, loc_cSQL, loc_nResult
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        loc_oPg2.obj_4c_OptTpregs.Value             = loc_oBO.this_nTpregs
        loc_oPg2.txt_4c_Descgrps.Value              = ALLTRIM(loc_oBO.this_cDescGrps)
        loc_oPg2.txt_4c_Ordems.Value                = loc_oBO.this_nOrdems
        loc_oPg2.txt_4c__cd_grupos.Value            = ALLTRIM(loc_oBO.this_cGrupos)
        loc_oPg2.txt_4c_Classe.Value                = ALLTRIM(loc_oBO.this_cClasses)
        loc_oPg2.obj_4c_Opt_analiticos.Value        = IIF(loc_oBO.this_nAnaliticos > 0, loc_oBO.this_nAnaliticos, 1)
        loc_oPg2.obj_4c_Opt_CPartida.Value          = IIF(loc_oBO.this_nCpartidas  > 0, loc_oBO.this_nCpartidas,  2)
        loc_oPg2.obj_4c_Opt_subtot100.Value         = IIF(loc_oBO.this_nSubtot100s > 0, loc_oBO.this_nSubtot100s, 2)
        loc_oPg2.txt_4c_Fator.Value                 = IIF(loc_oBO.this_nFators > 0, loc_oBO.this_nFators, 100)
        loc_oPg2.obj_4c_OptTpDatas.Value            = IIF(loc_oBO.this_nTpDatas   > 0, loc_oBO.this_nTpDatas,   3)
        loc_oPg2.cbo_4c_Cmb_operacaos.ListIndex    = IIF(loc_oBO.this_cOperacaos = "+", 1, 2)

        IF THIS.this_nMapas = 2
            loc_oPg2.txt_4c_Titulo.Value = ALLTRIM(loc_oBO.this_cTitulos)
        ENDIF

        *-- Popular descricao do Grupo (get_ds_grupos) via SQL
        IF NOT EMPTY(ALLTRIM(loc_oBO.this_cGrupos))
            TRY
                loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE Codigos = " + ;
                           EscaparSQL(ALLTRIM(loc_oBO.this_cGrupos))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrDesc")
                IF loc_nResult >= 0 AND USED("cursor_4c_GcrDesc") AND RECCOUNT("cursor_4c_GcrDesc") > 0
                    loc_oPg2.txt_4c__ds_grupos.Value = ALLTRIM(cursor_4c_GcrDesc.Descrs)
                ENDIF
                IF USED("cursor_4c_GcrDesc")
                    USE IN cursor_4c_GcrDesc
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o do grupo: " + ;
                        loException.Message, "Erro")
            ENDTRY
        ELSE
            loc_oPg2.txt_4c__ds_grupos.Value = ""
        ENDIF

        *-- Popular descricao da Classe (txt_4c_Dclasse) via SQL
        IF NOT EMPTY(ALLTRIM(loc_oBO.this_cClasses))
            TRY
                loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdCss WHERE Classes = " + ;
                           EscaparSQL(ALLTRIM(loc_oBO.this_cClasses))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssDesc")
                IF loc_nResult >= 0 AND USED("cursor_4c_CssDesc") AND RECCOUNT("cursor_4c_CssDesc") > 0
                    loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_CssDesc.Descrs)
                ENDIF
                IF USED("cursor_4c_CssDesc")
                    USE IN cursor_4c_CssDesc
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o da classe: " + ;
                        loException.Message, "Erro")
            ENDTRY
        ELSE
            loc_oPg2.txt_4c_Dclasse.Value = ""
        ENDIF

        THIS.OptTpregsChanged()
    ENDPROC

    *==========================================================================
    * HANDLER: TIPO DE REGISTRO MUDOU (optTpregs InteractiveChange)
    * Habilita/desabilita campos conforme o tipo selecionado
    *==========================================================================

    PROCEDURE OptTpregsChanged()
        LOCAL loc_oPg2, loc_nTpregs, loc_lEditar
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_nTpregs = loc_oPg2.obj_4c_OptTpregs.Value
        loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        *-- Campos por tipo:
        *-- Tpregs=1 (Grupo): cd_grupos/ds_grupos habilitados
        *-- Tpregs=2 (SubTotal): Descgrps habilitado
        *-- Tpregs=3 (Classe): Classe/Dclasse habilitados
        loc_oPg2.txt_4c_Descgrps.Enabled    = (loc_nTpregs = 2) AND loc_lEditar
        loc_oPg2.lbl_4c_Label1.Enabled      = (loc_nTpregs = 2)
        loc_oPg2.txt_4c__cd_grupos.Enabled  = (loc_nTpregs = 1) AND loc_lEditar
        loc_oPg2.lbl_4c_Lbl_grupos.Enabled  = (loc_nTpregs = 1)
        loc_oPg2.txt_4c_Classe.Enabled      = (loc_nTpregs = 3) AND loc_lEditar
        loc_oPg2.lbl_4c_Label4.Enabled      = (loc_nTpregs = 3)

        *-- cmb_operacaos: somente Tpregs=1 ou 3
        loc_oPg2.cbo_4c_Cmb_operacaos.Enabled = INLIST(loc_nTpregs, 1, 3) AND loc_lEditar
        loc_oPg2.lbl_4c_Lbl_operacaos.Enabled = INLIST(loc_nTpregs, 1, 3)

        *-- opt_analiticos: somente Tpregs=1
        loc_oPg2.obj_4c_Opt_analiticos.Buttons(1).Enabled = (loc_nTpregs = 1) AND loc_lEditar
        loc_oPg2.obj_4c_Opt_analiticos.Buttons(2).Enabled = (loc_nTpregs = 1) AND loc_lEditar
        loc_oPg2.lbl_4c_Lbl_analitico.Enabled             = (loc_nTpregs = 1)

        *-- Opt_CPartida: somente Tpregs=1 e Analiticos=1
        loc_oPg2.obj_4c_Opt_CPartida.Buttons(1).Enabled = ;
            (loc_nTpregs = 1) AND (loc_oPg2.obj_4c_Opt_analiticos.Value = 1) AND loc_lEditar
        loc_oPg2.obj_4c_Opt_CPartida.Buttons(2).Enabled = ;
            (loc_nTpregs = 1) AND (loc_oPg2.obj_4c_Opt_analiticos.Value = 1) AND loc_lEditar
        loc_oPg2.lbl_4c_Label5.Enabled = (loc_nTpregs = 1)

        *-- opt_subtot100: somente Tpregs=2 e llaltsubtot
        loc_oPg2.obj_4c_Opt_subtot100.Buttons(1).Enabled = ;
            (loc_nTpregs = 2) AND loc_lEditar AND THIS.this_lAltSubtot
        loc_oPg2.obj_4c_Opt_subtot100.Buttons(2).Enabled = (loc_nTpregs = 2) AND loc_lEditar
        loc_oPg2.lbl_4c_Label7.Enabled = (loc_nTpregs = 2)
    ENDPROC

    *==========================================================================
    * VALIDACAO: GRUPO (LostFocus de txt_4c__cd_grupos)
    * Busca em SigCdGcr, popula descricao ou abre picker
    *==========================================================================

    PROCEDURE ValidarGrupo
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cGrupo, loc_cSQL, loc_nResult, loc_oBusca
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c__cd_grupos.Value)

        IF EMPTY(loc_cGrupo)
            loc_oPg2.txt_4c__ds_grupos.Value = ""
            RETURN
        ENDIF

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
                       EscaparSQL(loc_cGrupo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
            IF loc_nResult >= 0 AND USED("cursor_4c_GcrVal") AND RECCOUNT("cursor_4c_GcrVal") > 0
                loc_oPg2.txt_4c__ds_grupos.Value = ALLTRIM(cursor_4c_GcrVal.Descrs)
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
                    "Grupos de Conta Corrente")

                IF VARTYPE(loc_oBusca) = "O"
                    IF NOT loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                        loc_oPg2.txt_4c__cd_grupos.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                        loc_oPg2.txt_4c__ds_grupos.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
                    ELSE
                        loc_oPg2.txt_4c__cd_grupos.Value = ""
                        loc_oPg2.txt_4c__ds_grupos.Value = ""
                    ENDIF

                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaGrupo")
                    USE IN cursor_4c_BuscaGrupo
                ENDIF
            ENDIF

            IF USED("cursor_4c_GcrVal")
                USE IN cursor_4c_GcrVal
            ENDIF

            *-- No modo INSERIR, popular Titulo com codigo do grupo
            IF THIS.this_cModoAtual = "INCLUIR"
                loc_oPg2.txt_4c_Titulo.Value = ALLTRIM(loc_oPg2.txt_4c__cd_grupos.Value)
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
            IF USED("cursor_4c_GcrVal")
                USE IN cursor_4c_GcrVal
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO: DESCRICAO DO GRUPO (LostFocus de txt_4c__ds_grupos)
    *==========================================================================

    PROCEDURE ValidarDescGrupo
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cDesc, loc_oBusca
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cDesc  = ALLTRIM(loc_oPg2.txt_4c__ds_grupos.Value)

        IF EMPTY(loc_cDesc) OR NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupoDsc", "Descrs", loc_cDesc, ;
                "Grupos de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                IF NOT loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupoDsc")
                    loc_oPg2.txt_4c__cd_grupos.Value = ALLTRIM(cursor_4c_BuscaGrupoDsc.Codigos)
                    loc_oPg2.txt_4c__ds_grupos.Value = ALLTRIM(cursor_4c_BuscaGrupoDsc.Descrs)
                ELSE
                    loc_oPg2.txt_4c__ds_grupos.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGrupoDsc")
                USE IN cursor_4c_BuscaGrupoDsc
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o do grupo: " + ;
                    loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO: CLASSE (LostFocus de txt_4c_Classe)
    * Busca em SigCdCss por Classes, popula descricao
    *==========================================================================

    PROCEDURE ValidarClasse
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cClasse, loc_cSQL, loc_nResult, loc_oBusca
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cClasse = ALLTRIM(loc_oPg2.txt_4c_Classe.Value)

        IF EMPTY(loc_cClasse)
            loc_oPg2.txt_4c_Dclasse.Value = ""
            RETURN
        ENDIF

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Classes, Descrs FROM SigCdCss WHERE Classes = " + ;
                       EscaparSQL(loc_cClasse)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssVal")
            IF loc_nResult >= 0 AND USED("cursor_4c_CssVal") AND RECCOUNT("cursor_4c_CssVal") > 0
                loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_CssVal.Descrs)
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCss", "cursor_4c_BuscaClasse", "Classes", loc_cClasse, ;
                    "Classes Cont" + CHR(225) + "beis")

                IF VARTYPE(loc_oBusca) = "O"
                    IF NOT loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Classes", "", "Classe")
                        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasse")
                        loc_oPg2.txt_4c_Classe.Value  = ALLTRIM(cursor_4c_BuscaClasse.Classes)
                        loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_BuscaClasse.Descrs)
                    ELSE
                        loc_oPg2.txt_4c_Classe.Value  = ""
                        loc_oPg2.txt_4c_Dclasse.Value = ""
                    ENDIF

                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaClasse")
                    USE IN cursor_4c_BuscaClasse
                ENDIF
            ENDIF

            IF USED("cursor_4c_CssVal")
                USE IN cursor_4c_CssVal
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao validar classe: " + loException.Message, "Erro")
            IF USED("cursor_4c_CssVal")
                USE IN cursor_4c_CssVal
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO: DESCRICAO DA CLASSE (LostFocus de txt_4c_Dclasse)
    *==========================================================================

    PROCEDURE ValidarDescClasse
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cDesc, loc_oBusca
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cDesc  = ALLTRIM(loc_oPg2.txt_4c_Dclasse.Value)

        IF EMPTY(loc_cDesc) OR NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCss", "cursor_4c_BuscaClasseDsc", "Descrs", loc_cDesc, ;
                "Classes Cont" + CHR(225) + "beis")

            IF VARTYPE(loc_oBusca) = "O"
                IF NOT loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Classes", "", "Classe")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasseDsc")
                    loc_oPg2.txt_4c_Classe.Value  = ALLTRIM(cursor_4c_BuscaClasseDsc.Classes)
                    loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_BuscaClasseDsc.Descrs)
                ELSE
                    loc_oPg2.txt_4c_Dclasse.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaClasseDsc")
                USE IN cursor_4c_BuscaClasseDsc
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o da classe: " + ;
                    loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * KEYPRESS HANDLERS para lookup fields (F4 = 115 abre picker)
    *==========================================================================

    FUNCTION CdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDFUNC

    FUNCTION DsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupGrupoDesc()
        ENDIF
    ENDFUNC

    FUNCTION ClasseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupClasse()
        ENDIF
    ENDFUNC

    FUNCTION DclasseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupClasseDesc()
        ENDIF
    ENDFUNC

    *==========================================================================
    * LOOKUP DE GRUPO (SigCdGcr) por codigo e por descricao
    *==========================================================================

    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oPg2, loc_oBusca, loc_cCodigo, loc_cDescrs
        LOCAL loc_lResultado
        loc_lResultado = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", "", ;
                "Grupos de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                IF NOT loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
                    loc_cDescrs = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
                    loc_oPg2.txt_4c__cd_grupos.Value = loc_cCodigo
                    loc_oPg2.txt_4c__ds_grupos.Value = loc_cDescrs

                    IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_nMapas = 2
                        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Titulo.Value))
                            loc_oPg2.txt_4c_Titulo.Value = loc_cDescrs
                        ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
            MsgErro("Erro ao abrir lookup de grupo: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    PROCEDURE AbrirLookupGrupoDesc()
        LOCAL loc_oPg2, loc_oBusca, loc_cCodigo, loc_cDescrs
        LOCAL loc_lResultado
        loc_lResultado = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "Descrs", "", ;
                "Grupos de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                IF NOT loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
                    loc_cDescrs = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
                    loc_oPg2.txt_4c__cd_grupos.Value = loc_cCodigo
                    loc_oPg2.txt_4c__ds_grupos.Value = loc_cDescrs

                    IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_nMapas = 2
                        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Titulo.Value))
                            loc_oPg2.txt_4c_Titulo.Value = loc_cDescrs
                        ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
            MsgErro("Erro ao abrir lookup de grupo: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * LOOKUP DE CLASSE (SigCdCss) por codigo e por descricao
    *==========================================================================

    PROCEDURE AbrirLookupClasse()
        LOCAL loc_oPg2, loc_oBusca, loc_cClasse, loc_cDescrs
        LOCAL loc_lResultado
        loc_lResultado = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCss", "cursor_4c_BuscaCss", "Classes", "", ;
                "Classes Cont" + CHR(225) + "beis")

            IF VARTYPE(loc_oBusca) = "O"
                IF NOT loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Classes", "", "Classe")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss")
                    loc_cClasse = ALLTRIM(cursor_4c_BuscaCss.Classes)
                    loc_cDescrs = ALLTRIM(cursor_4c_BuscaCss.Descrs)
                    loc_oPg2.txt_4c_Classe.Value  = loc_cClasse
                    loc_oPg2.txt_4c_Dclasse.Value = loc_cDescrs
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCss")
                USE IN cursor_4c_BuscaCss
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaCss")
                USE IN cursor_4c_BuscaCss
            ENDIF
            MsgErro("Erro ao abrir lookup de classe: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    PROCEDURE AbrirLookupClasseDesc()
        LOCAL loc_oPg2, loc_oBusca, loc_cClasse, loc_cDescrs
        LOCAL loc_lResultado
        loc_lResultado = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCss", "cursor_4c_BuscaCss", "Descrs", "", ;
                "Classes Cont" + CHR(225) + "beis")

            IF VARTYPE(loc_oBusca) = "O"
                IF NOT loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Classes", "", "Classe")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss")
                    loc_cClasse = ALLTRIM(cursor_4c_BuscaCss.Classes)
                    loc_cDescrs = ALLTRIM(cursor_4c_BuscaCss.Descrs)
                    loc_oPg2.txt_4c_Classe.Value  = loc_cClasse
                    loc_oPg2.txt_4c_Dclasse.Value = loc_cDescrs
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCss")
                USE IN cursor_4c_BuscaCss
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaCss")
                USE IN cursor_4c_BuscaCss
            ENDIF
            MsgErro("Erro ao abrir lookup de classe: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VALIDAR TITULO (LostFocus ? unicidade em SigCdMri para o mesmo Balanco)
    * Ativo apenas quando Mapas=2 e no modo INCLUIR ou ALTERAR
    *==========================================================================

    FUNCTION ValidarTitulo()
        LOCAL loc_oPg2, loc_cTitulo, loc_cSQL, loc_nResult
        LOCAL loc_lResultado
        loc_lResultado = .T.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF THIS.this_nMapas <> 2
            RETURN .T.
        ENDIF

        IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN .T.
        ENDIF

        loc_cTitulo = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)

        IF EMPTY(loc_cTitulo)
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
                       " AND Titulos = " + EscaparSQL(loc_cTitulo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupTit")
            IF loc_nResult >= 0 AND USED("cursor_4c_DupTit") AND RECCOUNT("cursor_4c_DupTit") > 0
                IF cursor_4c_DupTit.QTD > 0
                    IF USED("cursor_4c_DupTit")
                        USE IN cursor_4c_DupTit
                    ENDIF
                    MsgAviso("T" + CHR(237) + "tulo j" + CHR(225) + " utilizado!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.txt_4c_Titulo.SetFocus()
                    loc_lResultado = .F.
                ENDIF
            ENDIF
            IF USED("cursor_4c_DupTit")
                USE IN cursor_4c_DupTit
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_DupTit")
                USE IN cursor_4c_DupTit
            ENDIF
            MsgErro("Erro ao validar t" + CHR(237) + "tulo: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CALCULAR PROXIMA ORDEM (retorna proximo Ordems disponivel)
    *==========================================================================

    PROTECTED PROCEDURE CalcularProximaOrdem()
        LOCAL loc_cSQL, loc_nResult, loc_nOrdem
        loc_nOrdem = 1

        TRY
            loc_cSQL = "SELECT MAX(Ordems) + 1 AS ProxOrdem FROM SigCdMri" + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxOrdem")
            IF loc_nResult >= 0 AND USED("cursor_4c_ProxOrdem") AND RECCOUNT("cursor_4c_ProxOrdem") > 0
                IF NOT ISNULL(cursor_4c_ProxOrdem.ProxOrdem)
                    loc_nOrdem = cursor_4c_ProxOrdem.ProxOrdem
                ENDIF
            ENDIF
            IF USED("cursor_4c_ProxOrdem")
                USE IN cursor_4c_ProxOrdem
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao calcular ordem: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_nOrdem
    ENDPROC

    *==========================================================================
    * CALCULAR llAltSubtot (verifica se ha outro SubTot100 para DescGrps diferente)
    *==========================================================================

    PROTECTED PROCEDURE CalcularAltSubtot(par_cDescGrpsAtual)
        LOCAL loc_cSQL, loc_nResult, loc_nQtd, loc_lResultado
        loc_lResultado = .T.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
                       " AND Subtot100s = 1"

            IF NOT EMPTY(ALLTRIM(par_cDescGrpsAtual))
                loc_cSQL = loc_cSQL + " AND DescGrps <> " + EscaparSQL(ALLTRIM(par_cDescGrpsAtual))
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AltSubtot")
            IF loc_nResult >= 0 AND USED("cursor_4c_AltSubtot") AND RECCOUNT("cursor_4c_AltSubtot") > 0
                loc_nQtd = cursor_4c_AltSubtot.QTD
                loc_lResultado = (loc_nQtd <= 0)
            ENDIF
            IF USED("cursor_4c_AltSubtot")
                USE IN cursor_4c_AltSubtot
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao verificar subtotal: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VALIDAR CAMPOS antes de salvar (equivalente ao Salva.Click do legado)
    * Retorna .T. se valido, .F. se invalido (ja exibe mensagem)
    * Tambem auto-popula Classes, DescGrps, Nivels no BO
    * REGRA: NUNCA usar RETURN dentro de TRY/CATCH (CLAUDE.md regra 1)
    *==========================================================================

    PROTECTED PROCEDURE ValidarCampos()
        LOCAL loc_oPg2, loc_nTpregs, loc_cGrupos, loc_cClasses, loc_cDescGrps
        LOCAL loc_nFator, loc_nAnaliticos, loc_nListIdx
        LOCAL loc_cSQL, loc_nResult, loc_oBO, loc_lResultado
        LOCAL loc_cTituloVal, loc_nResultTit

        loc_lResultado = .T.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_oBO        = THIS.this_oBusinessObject
        loc_nTpregs    = loc_oPg2.obj_4c_OptTpregs.Value
        loc_cGrupos    = ALLTRIM(loc_oPg2.txt_4c__cd_grupos.Value)
        loc_cClasses   = ALLTRIM(loc_oPg2.txt_4c_Classe.Value)
        loc_cDescGrps  = ALLTRIM(loc_oPg2.txt_4c_Descgrps.Value)
        loc_nFator     = loc_oPg2.txt_4c_Fator.Value
        loc_nAnaliticos = loc_oPg2.obj_4c_Opt_analiticos.Value
        loc_nListIdx   = loc_oPg2.cbo_4c_Cmb_operacaos.ListIndex

        *-- Titulo obrigatorio e unico se Mapas=2
        IF THIS.this_nMapas = 2
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Titulo.Value))
                MsgAviso("T" + CHR(237) + "tulo N" + CHR(227) + "o Preenchido!", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Titulo.SetFocus()
                RETURN .F.
            ENDIF

            loc_cTituloVal = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)
            TRY
                loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
                           " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
                           " AND Titulos = " + EscaparSQL(loc_cTituloVal)
                loc_nResultTit = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupTit")
                IF loc_nResultTit >= 0 AND USED("cursor_4c_DupTit") AND RECCOUNT("cursor_4c_DupTit") > 0
                    IF cursor_4c_DupTit.QTD > 0
                        IF USED("cursor_4c_DupTit")
                            USE IN cursor_4c_DupTit
                        ENDIF
                        MsgAviso("T" + CHR(237) + "tulo j" + CHR(225) + " utilizado!", "Valida" + CHR(231) + CHR(227) + "o")
                        loc_oPg2.txt_4c_Titulo.SetFocus()
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_DupTit")
                    USE IN cursor_4c_DupTit
                ENDIF
            CATCH TO loException
                IF USED("cursor_4c_DupTit")
                    USE IN cursor_4c_DupTit
                ENDIF
                MsgErro("Erro ao validar t" + CHR(237) + "tulo: " + loException.Message, "Erro")
                loc_lResultado = .F.
            ENDTRY

            IF !loc_lResultado
                RETURN .F.
            ENDIF
        ENDIF

        *-- Validar Grupo (Tpregs=1)
        IF loc_nTpregs = 1
            IF EMPTY(loc_cGrupos)
                MsgAviso("Grupo inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c__cd_grupos.SetFocus()
                RETURN .F.
            ENDIF

            TRY
                loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
                           EscaparSQL(loc_cGrupos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGcr")
                IF loc_nResult >= 0 AND USED("cursor_4c_VGcr") AND RECCOUNT("cursor_4c_VGcr") > 0
                    loc_oBO.this_cDescGrps = ALLTRIM(cursor_4c_VGcr.Descrs)
                    loc_oBO.this_cClasses  = loc_cGrupos
                    IF USED("cursor_4c_VGcr")
                        USE IN cursor_4c_VGcr
                    ENDIF
                ELSE
                    IF USED("cursor_4c_VGcr")
                        USE IN cursor_4c_VGcr
                    ENDIF
                    MsgAviso("Grupo Inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.txt_4c__cd_grupos.SetFocus()
                    loc_lResultado = .F.
                ENDIF
            CATCH TO loException
                IF USED("cursor_4c_VGcr")
                    USE IN cursor_4c_VGcr
                ENDIF
                MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
                loc_lResultado = .F.
            ENDTRY

            IF !loc_lResultado
                RETURN .F.
            ENDIF
        ENDIF

        *-- Validar Classe (Tpregs=3)
        IF loc_nTpregs = 3
            IF EMPTY(loc_cClasses)
                MsgAviso("Classe Inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Classe.SetFocus()
                RETURN .F.
            ENDIF

            TRY
                loc_cSQL = "SELECT TOP 1 Classes, Descrs, Nivels FROM SigCdCss WHERE Classes = " + ;
                           EscaparSQL(loc_cClasses)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCss")
                IF loc_nResult >= 0 AND USED("cursor_4c_VCss") AND RECCOUNT("cursor_4c_VCss") > 0
                    loc_oBO.this_cDescGrps = ALLTRIM(cursor_4c_VCss.Descrs)
                    loc_oBO.this_nNivels   = cursor_4c_VCss.Nivels
                    IF USED("cursor_4c_VCss")
                        USE IN cursor_4c_VCss
                    ENDIF
                ELSE
                    IF USED("cursor_4c_VCss")
                        USE IN cursor_4c_VCss
                    ENDIF
                    MsgAviso("Classe Inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.txt_4c_Classe.SetFocus()
                    loc_lResultado = .F.
                ENDIF
            CATCH TO loException
                IF USED("cursor_4c_VCss")
                    USE IN cursor_4c_VCss
                ENDIF
                MsgErro("Erro ao validar classe: " + loException.Message, "Erro")
                loc_lResultado = .F.
            ENDTRY

            IF !loc_lResultado
                RETURN .F.
            ENDIF

            TRY
                loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
                           " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
                           " AND Classes = " + EscaparSQL(loc_cClasses)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCls")
                IF loc_nResult >= 0 AND USED("cursor_4c_DupCls") AND RECCOUNT("cursor_4c_DupCls") > 0
                    IF cursor_4c_DupCls.QTD > 0
                        IF USED("cursor_4c_DupCls")
                            USE IN cursor_4c_DupCls
                        ENDIF
                        MsgAviso("Classe j" + CHR(225) + " cadastrada!!", "Valida" + CHR(231) + CHR(227) + "o")
                        loc_oPg2.txt_4c_Classe.SetFocus()
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_DupCls")
                    USE IN cursor_4c_DupCls
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao verificar duplicidade de classe: " + loException.Message, "Erro")
                loc_lResultado = .F.
            ENDTRY

            IF !loc_lResultado
                RETURN .F.
            ENDIF
        ENDIF

        *-- Validar SubTotal (Tpregs=2)
        IF loc_nTpregs = 2
            IF EMPTY(loc_cDescGrps)
                MsgAviso("SubTotal Inv" + CHR(225) + "lido.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Descgrps.SetFocus()
                RETURN .F.
            ENDIF

            IF loc_nFator <> 100
                MsgAviso("Fator Inv" + CHR(225) + "lido", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Fator.Value = 100
                loc_oPg2.txt_4c_Fator.SetFocus()
                RETURN .F.
            ENDIF

            loc_oBO.this_cClasses = "6"

            TRY
                loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
                           " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
                           " AND DescGrps = " + EscaparSQL(loc_cDescGrps)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupSub")
                IF loc_nResult >= 0 AND USED("cursor_4c_DupSub") AND RECCOUNT("cursor_4c_DupSub") > 0
                    IF cursor_4c_DupSub.QTD > 0
                        IF USED("cursor_4c_DupSub")
                            USE IN cursor_4c_DupSub
                        ENDIF
                        MsgAviso("SubTotal j" + CHR(225) + " Cadastrado.", "Valida" + CHR(231) + CHR(227) + "o")
                        loc_oPg2.txt_4c_Descgrps.SetFocus()
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_DupSub")
                    USE IN cursor_4c_DupSub
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao verificar SubTotal: " + loException.Message, "Erro")
                loc_lResultado = .F.
            ENDTRY

            IF !loc_lResultado
                RETURN .F.
            ENDIF
        ENDIF

        *-- Validar Operacao selecionada
        IF loc_nListIdx <= 0
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.cbo_4c_Cmb_operacaos.SetFocus()
            RETURN .F.
        ENDIF

        *-- Validar Analiticos
        IF NOT INLIST(loc_nAnaliticos, 1, 2)
            MsgAviso("Op" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.obj_4c_Opt_analiticos.SetFocus()
            RETURN .F.
        ENDIF

        *-- Validar Fator (1-100, exceto SubTotal que exige 100 e ja foi validado)
        IF loc_nTpregs <> 2
            IF loc_nFator <= 0 OR loc_nFator > 100
                MsgAviso("Fator Inv" + CHR(225) + "lido!!", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Fator.Value = 100
                loc_oPg2.txt_4c_Fator.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        *-- Auto-popular Nivels para Tpregs=1 via SigCdCss
        IF loc_nTpregs = 1
            TRY
                loc_cSQL = "SELECT TOP 1 Nivels FROM SigCdCss WHERE Classes = " + ;
                           EscaparSQL(loc_oBO.this_cClasses)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NivGrp")
                IF loc_nResult >= 0 AND USED("cursor_4c_NivGrp") AND RECCOUNT("cursor_4c_NivGrp") > 0
                    loc_oBO.this_nNivels = cursor_4c_NivGrp.Nivels
                ELSE
                    loc_oBO.this_nNivels = 0
                ENDIF
                IF USED("cursor_4c_NivGrp")
                    USE IN cursor_4c_NivGrp
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao obter n" + CHR(237) + "vel: " + loException.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * EVENTOS DOS BOTOES - todos PUBLIC para BINDEVENT
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPg2, loc_nProxOrdem
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Calcular AltSubtot para novo registro (sem DescGrps atual)
        THIS.this_lAltSubtot = THIS.CalcularAltSubtot("")

        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()

        *-- Calcular e setar proxima ordem
        loc_nProxOrdem = THIS.CalcularProximaOrdem()
        loc_oPg2.txt_4c_Ordems.Value = loc_nProxOrdem

        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        loc_oPg2.obj_4c_OptTpregs.Buttons(1).SetFocus()
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidChaves
        loc_cCidChaves = ""

        IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCidChaves = ALLTRIM(cursor_4c_Dados.CidChaves)
        ENDIF

        IF EMPTY(loc_cCidChaves)
            MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
            THIS.this_cCidChavesAtual = loc_cCidChaves
            THIS.this_cModoAtual      = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidChaves, loc_cDescGrpsAtual
        loc_cCidChaves = ""

        IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCidChaves     = ALLTRIM(cursor_4c_Dados.CidChaves)
            loc_cDescGrpsAtual = ALLTRIM(cursor_4c_Dados.DescGrps)
        ENDIF

        IF EMPTY(loc_cCidChaves)
            MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
            THIS.this_cCidChavesAtual = loc_cCidChaves
            THIS.this_lAltSubtot      = THIS.CalcularAltSubtot(loc_cDescGrpsAtual)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidChaves, loc_lConfirma
        loc_cCidChaves = ""

        IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCidChaves = ALLTRIM(cursor_4c_Dados.CidChaves)
        ENDIF

        IF EMPTY(loc_cCidChaves)
            MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
                                    "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnBuscarClick()
        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
            GO TOP IN cursor_4c_Dados
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        *-- Transferir campos do form para o BO
        THIS.FormParaBO()

        *-- Validar e auto-popular campos derivados
        IF NOT THIS.ValidarCampos()
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Sucesso")
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * DESTROY
    *==========================================================================

    PROCEDURE Destroy()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro ao destruir FormCmr: " + loException.Message, "Erro")
        ENDTRY

        DODEFAULT()
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AUXILIARES
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

    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

ENDDEFINE
