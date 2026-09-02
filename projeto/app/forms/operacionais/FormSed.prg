*==============================================================================
* FormSed.prg - Formulario Operacional: Etiquetas de Sedex
* Herda de: FormBase
* Origem:  SIGCDSED.SCX
* Tabela:  SigCdSed
*
* MIGRADO COMPLETO (Fases 3-6/8):
*   - DEFINE CLASS + propriedades visuais
*   - Init / InicializarForm / Destroy
*   - ConfigurarCabecalho (cnt_4c_Cabecalho + labels sombra/titulo)
*   - ConfigurarBotoesAcao (cmd_4c_Cmdprocessar "Gerar" + cmd_4c_Sair "Encerrar")
*   - ConfigurarPaginaLista (filtros faixa inicial/final + grid 5 colunas + botao Excluir)
*   - CarregarDados (chama SedBO.CarregarSedex + vincula cursor ao grid, Pattern #180)
*   - Handlers: cmd_4c_CmdprocessarClick / cmd_4c_SairClick / cmd_4c_ExcluirClick
*   - TornarControlesVisiveis recursivo (form flat, sem containers flutuantes)
*   - Integrado no menu.prg: popMovimentos BAR 121 -> AbrirFormSed()
*   - Fase 6: Form plano sem Page2/lookups. LockScreen em exclusao (fidelidade UX).
*             Refresh() explicito no grid apos rebinding. Implementacao COMPLETA.
*   - Fase 7: Interface publica Btn*Click para controle de modo pelo wrapper
*             (equivalente ao pcEscolha legado). BtnExcluirClick delega para
*             cmd_4c_ExcluirClick que ja tem a logica completa.
*
* Layout OPERACIONAL flat (600x400 legado -> 1000x600 sistema novo).
* Nao usa PageFrame Lista/Dados do padrao CRUD.
*==============================================================================

DEFINE CLASS FormSed AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais do form
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    WindowType   = 1
    FontName     = "Verdana"
    FontSize     = 8
    ForeColor    = RGB(36, 84, 155)
    Caption      = "Etiquetas de Sedex"

    *--------------------------------------------------------------------------
    * Propriedades de estado
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "INSERIR"
    this_oParent         = .NULL.

    *==========================================================================
    * Init - Cria BO e delega inicializacao ao FormBase.Init
    * par_oParent    : form pai (wrapper), opcional
    * par_cModoAtual : "INSERIR" / "ALTERAR" / "VISUALIZAR"
    *==========================================================================
    FUNCTION Init(par_oParent, par_cModoAtual)
        IF VARTYPE(par_oParent) = "O"
            THIS.this_oParent = par_oParent
        ENDIF

        IF VARTYPE(par_cModoAtual) = "C" AND !EMPTY(par_cModoAtual)
            THIS.this_cModoAtual = par_cModoAtual
        ENDIF

        THIS.this_oBusinessObject = CREATEOBJECT("SedBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SedBO.", "Erro")
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    * InicializarForm - Monta a estrutura base do form
    * Deve retornar .T. em sucesso e .F. em falha (contrato do FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoesAcao()
            THIS.ConfigurarPaginaLista()

            BINDEVENT(THIS.cmd_4c_Cmdprocessar, "Click", THIS, "cmd_4c_CmdprocessarClick")
            BINDEVENT(THIS.cmd_4c_Sair,         "Click", THIS, "cmd_4c_SairClick")
            BINDEVENT(THIS.cmd_4c_Excluir,      "Click", THIS, "cmd_4c_ExcluirClick")

            THIS.TornarControlesVisiveis(THIS)

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarDados()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSed.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
    * cnt_4c_Cabecalho: Top=0 Left=0 Width=1000 Height=80 BackColor=RGB(100,100,100)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblSombra
            .Top        = 18
            .Left       = 10
            .Width      = THIS.Width - 20
            .Height     = 40
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .ForeColor  = RGB(0, 0, 0)
            .BackStyle  = 0
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Caption    = "Etiquetas de Sedex"
            .Visible    = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblTitulo
            .Top        = 17
            .Left       = 10
            .Width      = THIS.Width - 20
            .Height     = 46
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .ForeColor  = RGB(255, 255, 255)
            .BackStyle  = 0
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Caption    = "Etiquetas de Sedex"
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Botoes Gerar e Encerrar (canto superior direito)
    * Layout proporcional 600->1000 (originais Left=450 e Left=525):
    *   cmd_4c_Cmdprocessar (Gerar)   : Left=750
    *   cmd_4c_Sair          (Encerrar): Left=875 (Cancel=.T. p/ ESC)
    * Gerar so habilitado em INSERIR/ALTERAR
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_lModoHabilita

        loc_lModoHabilita = INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")

        THIS.AddObject("cmd_4c_Cmdprocessar", "CommandButton")
        WITH THIS.cmd_4c_Cmdprocessar
            .Top             = 3
            .Left            = 750
            .Width           = 75
            .Height          = 75
            .Caption         = "Gerar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Enabled         = loc_lModoHabilita
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top             = 3
            .Left            = 875
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
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda hierarquia
    * Form flat sem containers flutuantes, portanto sem lista de skip.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - Libera cursores e recursos. DODEFAULT no fim (rebuild menu).
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Sedex")
            USE IN cursor_4c_Sedex
        ENDIF
        IF USED("cursor_4c_SedVerif")
            USE IN cursor_4c_SedVerif
        ENDIF
        IF USED("cursor_4c_SedChk")
            USE IN cursor_4c_SedChk
        ENDIF

        THIS.this_oBusinessObject = .NULL.
        THIS.this_oParent         = .NULL.

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Monta area de filtros, grid e botao Excluir
    * Form OPERACIONAL flat (sem PageFrame): todo o conteudo vai direto no form.
    * Filtros:  lbl_4c_LblFaixa, txt_4c_Faixainicial, lbl_4c_LblAte, txt_4c_Faixafinal
    * Grid:     grd_4c_Dados (5 colunas: DtIncs|FaixaInis|FaixaFins|nLivres|nUsadas)
    * Botao:    cmd_4c_Excluir (icone-only, direita do grid)
    * Escalado de 600x400 (original) para 1000x600 (novo padrao)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_lModoHabilita

        loc_lModoHabilita = INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")

        *-- Label "Faixa:"
        THIS.AddObject("lbl_4c_LblFaixa", "Label")
        WITH THIS.lbl_4c_LblFaixa
            .Top       = 101
            .Left      = 12
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Faixa :"
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox faixa inicial (MaxLength=14, Format="K!" converte para maiusculo)
        THIS.AddObject("txt_4c_Faixainicial", "TextBox")
        WITH THIS.txt_4c_Faixainicial
            .Top           = 97
            .Left          = 74
            .Width         = 180
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 0
            .BackStyle     = 1
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .BorderStyle   = 1
            .Format        = "K!"
            .MaxLength     = 14
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Enabled       = loc_lModoHabilita
            .Visible       = .T.
        ENDWITH

        *-- Label "ate"
        THIS.AddObject("lbl_4c_LblAte", "Label")
        WITH THIS.lbl_4c_LblAte
            .Top       = 101
            .Left      = 260
            .Width     = 30
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox faixa final (mesmas propriedades da inicial)
        THIS.AddObject("txt_4c_Faixafinal", "TextBox")
        WITH THIS.txt_4c_Faixafinal
            .Top           = 97
            .Left          = 295
            .Width         = 180
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 0
            .BackStyle     = 1
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .BorderStyle   = 1
            .Format        = "K!"
            .MaxLength     = 14
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = ""
            .Enabled       = loc_lModoHabilita
            .Visible       = .T.
        ENDWITH

        *-- Botao Excluir (icone-only, posicionado a direita do grid - nunca .Enabled=.F.)
        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top             = 335
            .Left            = 867
            .Width           = 75
            .Height          = 75
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText     = "Excluir"
            .FontName        = "Verdana"
            .FontBold        = .T.
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        *-- Grid principal (escalado: original Left=35 W=482 H=254 -> novo Left=12 W=860 H=440)
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top                = 130
            .Left               = 12
            .Width              = 860
            .Height             = 440
            .ColumnCount        = 5
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(36, 84, 155)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .ReadOnly           = .T.

            *-- Column5 = DtIncs (ColumnOrder=1: aparece primeiro, original Column5.ColumnOrder=1)
            WITH .Column5
                .ColumnOrder = 1
                .Width       = 160
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Data Inclus" + CHR(227) + "o"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column1 = FaixaInis (ColumnOrder=2)
            WITH .Column1
                .ColumnOrder = 2
                .Width       = 200
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Faixa Inicial"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column2 = FaixaFins (ColumnOrder=3)
            WITH .Column2
                .ColumnOrder = 3
                .Width       = 200
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Faixa Final"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column3 = nLivres (ColumnOrder=4)
            WITH .Column3
                .ColumnOrder = 4
                .Width       = 150
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Livres"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            *-- Column4 = nUsadas (ColumnOrder=5)
            WITH .Column4
                .ColumnOrder = 5
                .Width       = 150
                .Resizable   = .F.
                .ReadOnly    = .T.
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Usadas"
                ENDWITH
                WITH .Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDWITH

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarDados - Chama SedBO.CarregarSedex e vincula cursor ao grid
    * Pattern #180: re-configura Width e Caption apos RecordSource (Problema 48)
    *==========================================================================
    FUNCTION CarregarDados()
        LOCAL loc_lSucesso, loc_oGrid, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_oGrid = THIS.grd_4c_Dados

            IF THIS.this_oBusinessObject.CarregarSedex(go_4c_Sistema.cCodEmpresa)
                loc_oGrid.ColumnCount  = 5
                loc_oGrid.RecordSource = "cursor_4c_Sedex"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Sedex.FaixaInis"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Sedex.FaixaFins"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Sedex.nLivres"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Sedex.nUsadas"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Sedex.DtIncs"

                *-- Re-configurar apos troca de RecordSource (Pattern #180 / Problema 48)
                loc_oGrid.Column1.Width           = 200
                loc_oGrid.Column1.Header1.Caption = "Faixa Inicial"
                loc_oGrid.Column2.Width           = 200
                loc_oGrid.Column2.Header1.Caption = "Faixa Final"
                loc_oGrid.Column3.Width           = 150
                loc_oGrid.Column3.Header1.Caption = "Livres"
                loc_oGrid.Column4.Width           = 150
                loc_oGrid.Column4.Header1.Caption = "Usadas"
                loc_oGrid.Column5.Width           = 160
                loc_oGrid.Column5.Header1.Caption = "Data Inclus" + CHR(227) + "o"

                loc_oGrid.Refresh()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSed.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConfigurarPaginaDados - Form OPERACIONAL flat (sem PageFrame Lista/Dados)
    * Layout completo (cabecalho, filtros, grid, botoes) esta em ConfigurarCabecalho +
    * ConfigurarBotoesAcao + ConfigurarPaginaLista, chamados no InicializarForm.
    * Presente por convencao do pipeline (validador Fase 5 exige o nome do metodo)
    * e para compatibilidade com AlternarPagina caso o form seja invocado por
    * wrapper que espere a mesma interface dos forms CRUD.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *==========================================================================
    * AlternarPagina - Stub (form flat sem PageFrame; sem alternancia de paginas)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * cmd_4c_CmdprocessarClick - Handler do botao Gerar
    * Valida faixas, chama GerarEtiquetas no BO e recarrega grid
    *==========================================================================
    PROCEDURE cmd_4c_CmdprocessarClick()
        LOCAL loc_lSucesso, loc_cFaixaIni, loc_cFaixaFin

        IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        loc_cFaixaIni = ALLTRIM(THIS.txt_4c_Faixainicial.Value)
        loc_cFaixaFin = ALLTRIM(THIS.txt_4c_Faixafinal.Value)

        IF EMPTY(loc_cFaixaIni) OR EMPTY(loc_cFaixaFin)
            MsgAviso("Faixa inicial e final s" + CHR(227) + "o obrigat" + CHR(243) + "rias.", "Aviso")
            RETURN
        ENDIF

        loc_lSucesso = THIS.this_oBusinessObject.GerarEtiquetas( ;
            loc_cFaixaIni, loc_cFaixaFin, go_4c_Sistema.cCodEmpresa)

        IF loc_lSucesso
            THIS.CarregarDados()
        ENDIF
    ENDPROC

    *==========================================================================
    * cmd_4c_SairClick - Handler do botao Encerrar
    *==========================================================================
    PROCEDURE cmd_4c_SairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * cmd_4c_ExcluirClick - Handler do botao Excluir
    * Le FaixaInis e nUsadas do registro corrente no cursor e chama ExcluirFaixa.
    * LockScreen durante delete + reload evita flickering (fidelidade ao legado).
    *==========================================================================
    PROCEDURE cmd_4c_ExcluirClick()
        LOCAL loc_cFaixaIni, loc_nUsadas

        IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF !USED("cursor_4c_Sedex") OR RECCOUNT("cursor_4c_Sedex") = 0
            MsgAviso("Selecione um registro para excluir.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Sedex
        IF EOF("cursor_4c_Sedex")
            MsgAviso("Selecione um registro para excluir.", "Aviso")
            RETURN
        ENDIF

        loc_cFaixaIni = ALLTRIM(NVL(cursor_4c_Sedex.FaixaInis, ""))
        loc_nUsadas   = NVL(cursor_4c_Sedex.nUsadas, 0)

        THIS.LockScreen = .T.

        IF THIS.this_oBusinessObject.ExcluirFaixa(loc_cFaixaIni, go_4c_Sistema.cCodEmpresa, loc_nUsadas)
            THIS.CarregarDados()
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Configura form para modo INSERIR e limpa campos de faixa
    * Interface publica equivalente a pcEscolha='INSERIR' no wrapper legado.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_cModoAtual = "INSERIR"
        THIS.txt_4c_Faixainicial.Value   = ""
        THIS.txt_4c_Faixafinal.Value     = ""
        THIS.txt_4c_Faixainicial.Enabled = .T.
        THIS.txt_4c_Faixafinal.Enabled   = .T.
        THIS.cmd_4c_Cmdprocessar.Enabled = .T.
        THIS.txt_4c_Faixainicial.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Configura form para modo ALTERAR habilitando controles
    * Interface publica equivalente a pcEscolha='ALTERAR' no wrapper legado.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.this_cModoAtual = "ALTERAR"
        THIS.txt_4c_Faixainicial.Enabled = .T.
        THIS.txt_4c_Faixafinal.Enabled   = .T.
        THIS.cmd_4c_Cmdprocessar.Enabled = .T.
        THIS.txt_4c_Faixainicial.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Configura form para modo VISUALIZAR (somente leitura)
    * Interface publica equivalente a pcEscolha='VISUALIZAR' no wrapper legado.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.txt_4c_Faixainicial.Enabled = .F.
        THIS.txt_4c_Faixafinal.Enabled   = .F.
        THIS.cmd_4c_Cmdprocessar.Enabled = .F.
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Dispara exclusao da faixa selecionada no grid
    * Delega para cmd_4c_ExcluirClick que tem a logica completa com validacao
    * de nUsadas > 0 e chamada ao BO.ExcluirFaixa.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.cmd_4c_ExcluirClick()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega grid com dados atuais da empresa
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario (alias publico para cmd_4c_SairClick)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.cmd_4c_SairClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Executa geracao de etiquetas (alias publico para "Gerar")
    * Mapeia a acao "Salvar" do padrao CRUD para "GerarEtiquetas" deste form
    * operacional.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.cmd_4c_CmdprocessarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela operacao atual: limpa campos de faixa
    * e retorna foco para o primeiro campo editavel.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.txt_4c_Faixainicial.SetFocus()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere campos do form para as propriedades do SedBO
    * Popula this_cFaixaInis, this_cFaixaFins e this_cEmps antes de Gerar.
    *==========================================================================
    PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cFaixaInis = ALLTRIM(THIS.txt_4c_Faixainicial.Value)
        THIS.this_oBusinessObject.this_cFaixaFins = ALLTRIM(THIS.txt_4c_Faixafinal.Value)
        THIS.this_oBusinessObject.this_cEmps      = go_4c_Sistema.cCodEmpresa
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos de faixa do form
    *==========================================================================
    PROCEDURE BOParaForm()
        THIS.txt_4c_Faixainicial.Value = THIS.this_oBusinessObject.this_cFaixaInis
        THIS.txt_4c_Faixafinal.Value   = THIS.this_oBusinessObject.this_cFaixaFins
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita controles editaveis
    * par_lHabilitar: .T. = modo edicao (INSERIR/ALTERAR), .F. = somente leitura
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lEdit

        loc_lEdit = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)

        THIS.txt_4c_Faixainicial.Enabled = loc_lEdit
        THIS.txt_4c_Faixafinal.Enabled   = loc_lEdit
        THIS.cmd_4c_Cmdprocessar.Enabled = loc_lEdit
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa os campos de faixa inicial e final
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.txt_4c_Faixainicial.Value = ""
        THIS.txt_4c_Faixafinal.Value   = ""
    ENDPROC

    *==========================================================================
    * CarregarLista - Alias para CarregarDados (compatibilidade com interface CRUD)
    * Forms operacionais nao tem lista separada dos dados; o grid unico e
    * atualizado pelo CarregarDados.
    *==========================================================================
    FUNCTION CarregarLista()
        RETURN THIS.CarregarDados()
    ENDFUNC

    *==========================================================================
    * AjustarBotoesPorModo - Centraliza habilitacao de controles por modo
    * Equivalente ao When legado: Return(INLIST(pcEscolha,'INSERIR','ALTERAR'))
    * Chamado por wrappers ou logica externa que altera this_cModoAtual.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lModoEdicao

        loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")

        THIS.HabilitarCampos(loc_lModoEdicao)

        THIS.cmd_4c_Excluir.Visible = loc_lModoEdicao
    ENDPROC

ENDDEFINE
