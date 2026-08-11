*==============================================================================
* FormSigPrSlp.prg - Selecao Lista de Preco (Form Operacional)
* Herda de: FormBase
* Tipo: OPERACIONAL - dialogo filho do form de pedido/venda
* Chamado via: CREATEOBJECT("FormSigPrSlp", oParentForm, cLPrecoAtual)
* Tabelas: SigCdLpc (cabecalho lista), SigCdLpi (itens lista)
* Legado: SIGPRSLP.SCX (form, Width=800, Height=600)
*==============================================================================

DEFINE CLASS FormSigPrSlp AS FormBase

    *-- Dimensoes (dialogo - manter 800x600 do legado)
    Height       = 600
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    WindowType   = 1
    FontName     = "Arial"
    FontSize     = 9
    ShowTips     = .T.

    *-- BO e estado
    this_oBusinessObject  = .NULL.
    this_cModoAtual       = ""
    this_cMensagemErro    = ""

    *-- Parametros recebidos do form pai
    this_oParentForm   = .NULL.   && Referencia ao form pai (pedido/venda)
    this_cLPrecoAtual  = ""       && Codigo da lista corrente (excluida de grd_4c_Listas)

    *--------------------------------------------------------------------------
    * Init - Recebe parametros do form pai, configura Caption e propriedades
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_cLPreco)
        THIS.Caption          = "Sele" + CHR(231) + CHR(227) + "o Lista de Pre" + CHR(231) + "o"
        THIS.this_oParentForm = par_oParentForm
        THIS.this_cLPrecoAtual = IIF(VARTYPE(par_cLPreco) = "C", ALLTRIM(par_cLPreco), "")

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura, carrega dados e vincula eventos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrSlpBO")

            THIS.ConfigurarPageFrame()

            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            THIS.TornarControlesVisiveis(THIS)

            *-- Carrega listas disponiveis e vincula evento de selecao
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarGradeLista()
            ENDIF
            BINDEVENT(THIS.grd_4c_Listas, "AfterRowColChange", THIS, "GradeListasAfterRowColChange")
            BINDEVENT(THIS.grd_4c_Itens.Column1.Check1, "When", THIS, "GradeItensCheck1When")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria cabecalho + grids + botoes (flat, sem PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Fundo do dialogo (original: Picture = new_background.jpg)
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

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

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .WordWrap  = .T.
            .Alignment = 0
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 17
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .WordWrap  = .T.
            .Alignment = 0
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        *-- Layout flat (dialogo sem PageFrame): grids + botoes de acao
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta a area de selecao (grid de listas + grid de
    * itens marcaveis + botoes de acao). Neste dialogo OPERACIONAL nao existe
    * PageFrame; o nome eh mantido para paridade com a API dos forms CRUD e
    * agrega toda a configuracao visual da "lista" de itens selecionaveis.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarGradeLista()
        THIS.ConfigurarGradeItens()
        THIS.ConfigurarBotoesForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Mantido por paridade de API com forms CRUD
    * Este eh um dialogo OPERACIONAL (sem Page1=Lista/Page2=Dados). Toda a
    * area de "dados" do dialogo eh, na pratica, o grd_4c_Itens (checkbox +
    * codigo + descricao + preco + moeda + comissao), configurado em
    * ConfigurarGradeItens(). Nao ha TextBoxes/Labels individuais para exibir
    * porque a selecao acontece diretamente nas linhas do grid.
    *
    * Metodo delega para ConfigurarGradeItens() para que qualquer chamada
    * externa (ex: rerender apos redimensionamento) reconstrua a area de dados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Nesse dialogo OPERACIONAL, "pagina de dados" = grid de itens marcaveis
        IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.ConfigurarGradeItens()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Move o foco entre os dois grids do dialogo.
    * par_nPagina = 1  -> grd_4c_Listas (cabecalho: escolha da lista de preco)
    * par_nPagina = 2  -> grd_4c_Itens  (detalhe: marcacao dos itens)
    * Neste dialogo nao ha PageFrame real; o metodo existe para compatibilidade
    * de API com forms CRUD e para permitir navegacao programatica entre grids.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina

        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        DO CASE
            CASE loc_nPagina = 1
                IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
                    THIS.grd_4c_Listas.SetFocus()
                ENDIF
            CASE loc_nPagina = 2
                IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                    THIS.grd_4c_Itens.SetFocus()
                ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeLista - Cria grd_4c_Listas para selecao de lista de preco
    * Original: GradeLista Top=96 Left=263 Width=258 Height=112 ColumnCount=1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeLista()
        THIS.AddObject("grd_4c_Listas", "Grid")
        WITH THIS.grd_4c_Listas
            .Top         = 96
            .Left        = 263
            .Width       = 258
            .Height      = 112
            .ColumnCount = 1
            .FontName    = "Courier New"
            .FontSize    = 9
            .ReadOnly    = .T.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .GridLineColor      = RGB(238, 238, 238)
            .ScrollBars  = 2
            .RowHeight   = 16
            WITH .Column1
                .Width    = 220
                .ReadOnly = .T.
                .FontName = "Courier New"
                .FontSize = 9
                .Header1.Caption   = "Lista de Pre" + CHR(231) + "os"
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(0, 0, 0)
            ENDWITH
            *-- Estilo do TextBox padrao da coluna (fiel ao SCX original)
            IF PEMSTATUS(THIS.grd_4c_Listas.Column1, "Text1", 5)
                WITH THIS.grd_4c_Listas.Column1.Text1
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                ENDWITH
            ENDIF
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeItens - Cria grd_4c_Itens com checkbox na Column1 (6 cols)
    * Original: GradeItens Top=215 Left=72 Width=663 Height=184 ColumnCount=6
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeItens()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Itens", "Grid")
        loc_oGrid = THIS.grd_4c_Itens

        WITH loc_oGrid
            .Top         = 215
            .Left        = 72
            .Width       = 663
            .Height      = 184
            .ColumnCount = 6
            .FontName    = "Courier New"
            .FontSize    = 9
            .ReadOnly    = .F.
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .GridLineColor      = RGB(238, 238, 238)
            .ScrollBars  = 2
            .RowHeight   = 16
        ENDWITH

        *-- Column1: CheckBox para marcacao (Sparse=.F. obrigatorio para todas as linhas)
        WITH loc_oGrid.Column1
            .Width    = 22
            .ReadOnly = .F.
            .Sparse   = .F.
            .AddObject("Check1", "CheckBox")
            .Check1.Top       = 23
            .Check1.Left      = 3
            .Check1.Height    = 17
            .Check1.Width     = 60
            .Check1.FontName  = "Courier New"
            .Check1.Alignment = 0
            .Check1.Caption   = ""
            .Check1.Alignment = 0
            .Check1.ReadOnly  = .F.
            .Check1.Visible   = .T.
            .Check1.Top       = 9
            .Check1.Left      = 2
            .Check1.Height    = 17
            .Check1.Width     = 22
            .Check1.Value     = 0
            .CurrentControl = "Check1"
            .Header1.Caption  = ""
            .Header1.FontName = "Tahoma"
            .Header1.FontSize = 8
        ENDWITH

        WITH loc_oGrid.Column2
            .Width    = 108
            .ReadOnly = .T.
            .FontName = "Courier New"
            .FontSize = 9
            .Header1.Caption   = "C" + CHR(243) + "digo Produto"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
        ENDWITH
        IF PEMSTATUS(loc_oGrid.Column2, "Text1", 5)
            WITH loc_oGrid.Column2.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDIF

        WITH loc_oGrid.Column3
            .Width    = 290
            .ReadOnly = .T.
            .FontName = "Courier New"
            .FontSize = 9
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
        ENDWITH
        IF PEMSTATUS(loc_oGrid.Column3, "Text1", 5)
            WITH loc_oGrid.Column3.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDIF

        WITH loc_oGrid.Column4
            .Width     = 108
            .ReadOnly  = .T.
            .FontName  = "Courier New"
            .FontSize  = 9
            .InputMask = "999,999,999.99"
            .Header1.Caption   = "Pre" + CHR(231) + "o de Venda"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
        ENDWITH
        IF PEMSTATUS(loc_oGrid.Column4, "Text1", 5)
            WITH loc_oGrid.Column4.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .FontSize    = 9
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDIF

        WITH loc_oGrid.Column5
            .Width    = 40
            .ReadOnly = .T.
            .FontName = "Courier New"
            .FontSize = 9
            .Header1.Caption   = "Moeda"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
        ENDWITH
        IF PEMSTATUS(loc_oGrid.Column5, "Text1", 5)
            WITH loc_oGrid.Column5.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDIF

        WITH loc_oGrid.Column6
            .Width     = 60
            .ReadOnly  = .T.
            .FontName  = "Courier New"
            .FontSize  = 9
            .InputMask = "999.99"
            .Header1.Caption   = "Comiss" + CHR(227) + "o"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
        ENDWITH
        IF PEMSTATUS(loc_oGrid.Column6, "Text1", 5)
            WITH loc_oGrid.Column6.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDIF

        loc_oGrid.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesForm - Cria botoes de acao do dialogo
    * Original: Command1 Top=413 Left=80 W=288 H=27
    *           cmdSelTudo Top=407 Left=632 / CmdApgTudo Top=407 Left=672
    *           Sair Top=3 Left=725 (Encerrar, Cancel=.T.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesForm()
        *-- Botao principal: adiciona itens marcados a lista atual
        THIS.AddObject("cmd_4c_Adicionar", "CommandButton")
        WITH THIS.cmd_4c_Adicionar
            .Top       = 413
            .Left      = 80
            .Width     = 288
            .Height    = 27
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Adiciona os itens marcados " + CHR(224) + " Lista atual"
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Adicionar, "Click", THIS, "CmdAdicionarClick")

        *-- Botao Selecionar Tudo (icone pequeno ao lado do grid)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top             = 407
            .Left            = 632
            .Width           = 32
            .Height          = 32
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Themes          = .T.
            .SpecialEffect   = 0
            .TabStop         = .F.
            .ToolTipText     = "Selecionar Tudo"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")

        *-- Botao Desmarcar Tudo
        THIS.AddObject("cmd_4c_ApgaTudo", "CommandButton")
        WITH THIS.cmd_4c_ApgaTudo
            .Top             = 407
            .Left            = 672
            .Width           = 32
            .Height          = 32
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Themes          = .T.
            .SpecialEffect   = 0
            .TabStop         = .F.
            .ToolTipText     = "Desmarcar Tudo"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_ApgaTudo, "Click", THIS, "CmdApgaTudoClick")

        *-- Botao Encerrar (canto superior direito, sobre o cabecalho)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .Cancel          = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeLista - Chama BO.BuscarListasDisponiveis e popula grd_4c_Listas
    * Apos carregar, chama MontaGrade2 com a primeira lista disponivel
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradeLista()
        LOCAL loc_lSucesso, loc_cCursorListas

        loc_lSucesso = THIS.this_oBusinessObject.BuscarListasDisponiveis(THIS.this_cLPrecoAtual)

        IF loc_lSucesso
            loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas

            THIS.grd_4c_Listas.RecordSource = ""
            THIS.grd_4c_Listas.Column1.ControlSource = loc_cCursorListas + ".lprecos"
            THIS.grd_4c_Listas.RecordSource = loc_cCursorListas
            *-- Reconfigurar header apos RecordSource (VFP9 reseta headers)
            THIS.grd_4c_Listas.Column1.Header1.Caption   = "Lista de Pre" + CHR(231) + "os"
            THIS.grd_4c_Listas.Column1.Header1.FontName  = "Tahoma"
            THIS.grd_4c_Listas.Column1.Header1.FontSize  = 8
            THIS.grd_4c_Listas.Column1.Header1.Alignment = 2
            THIS.grd_4c_Listas.Column1.Header1.ForeColor = RGB(0, 0, 0)

            *-- Carregar itens da primeira lista disponivel
            SELECT (loc_cCursorListas)
            GO TOP
            IF !EOF()
                THIS.MontaGrade2(ALLTRIM(lprecos))
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontaGrade2 - Carrega itens de SigCdLpi para grd_4c_Itens
    * par_cLPrecos: codigo da lista selecionada em grd_4c_Listas
    *--------------------------------------------------------------------------
    PROCEDURE MontaGrade2(par_cLPrecos)
        LOCAL loc_lSucesso, loc_cCursorItens

        loc_lSucesso = THIS.this_oBusinessObject.BuscarItensDaLista(par_cLPrecos)

        IF loc_lSucesso
            loc_cCursorItens = THIS.this_oBusinessObject.this_cCursorItens

            THIS.grd_4c_Itens.RecordSource = ""
            THIS.grd_4c_Itens.Column1.ControlSource = loc_cCursorItens + ".lMarcas"
            THIS.grd_4c_Itens.Column2.ControlSource = loc_cCursorItens + ".cpros"
            THIS.grd_4c_Itens.Column3.ControlSource = loc_cCursorItens + ".dpros"
            THIS.grd_4c_Itens.Column4.ControlSource = loc_cCursorItens + ".pvens"
            THIS.grd_4c_Itens.Column5.ControlSource = loc_cCursorItens + ".moevs"
            THIS.grd_4c_Itens.Column6.ControlSource = loc_cCursorItens + ".comiss"
            THIS.grd_4c_Itens.RecordSource = loc_cCursorItens
            *-- Reconfigurar headers apos RecordSource (VFP9 reseta headers)
            THIS.grd_4c_Itens.Column1.Header1.Caption = ""
            THIS.grd_4c_Itens.Column2.Header1.Caption = "C" + CHR(243) + "digo Produto"
            THIS.grd_4c_Itens.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
            THIS.grd_4c_Itens.Column4.Header1.Caption = "Pre" + CHR(231) + "o de Venda"
            THIS.grd_4c_Itens.Column5.Header1.Caption = "Moeda"
            THIS.grd_4c_Itens.Column6.Header1.Caption = "Comiss" + CHR(227) + "o"
            THIS.grd_4c_Itens.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeListasAfterRowColChange - Atualiza grd_4c_Itens ao trocar linha em grd_4c_Listas
    *--------------------------------------------------------------------------
    PROCEDURE GradeListasAfterRowColChange(par_nColIndex)
        LOCAL loc_cCursorListas, loc_cLPrecos

        loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas

        IF USED(loc_cCursorListas)
            SELECT (loc_cCursorListas)
            IF !EOF()
                loc_cLPrecos = ALLTRIM(lprecos)
                IF !EMPTY(loc_cLPrecos)
                    THIS.MontaGrade2(loc_cLPrecos)
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdAdicionarClick - Copia itens marcados para o cursor CrSigCdLpi do form pai
    *--------------------------------------------------------------------------
    PROCEDURE CmdAdicionarClick()
        LOCAL loc_lAplicarArredond, loc_cCursorDestino, loc_nAdicionados, loc_oErro

        IF VARTYPE(THIS.this_oParentForm) != "O" OR ISNULL(THIS.this_oParentForm)
            MsgAviso("Form pai n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
            RETURN
        ENDIF

        loc_lAplicarArredond = .F.
        IF PEMSTATUS(THIS.this_oParentForm, "CompVenda", 5)
            loc_lAplicarArredond = (THIS.this_oParentForm.CompVenda <> "C")
        ENDIF

        loc_cCursorDestino = "CrSigCdLpi"

        TRY
            loc_nAdicionados = THIS.this_oBusinessObject.AdicionarItensMarcados(;
                THIS.this_cLPrecoAtual, ;
                loc_cCursorDestino, ;
                loc_lAplicarArredond)

            IF loc_nAdicionados >= 0
                THIS.Release()
            ELSE
                MsgErro("Erro ao adicionar itens da lista de pre" + CHR(231) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao adicionar itens")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEncerrarClick - Fecha o dialogo sem adicionar itens
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSelTudoClick - Marca todos os itens de grd_4c_Itens
    *--------------------------------------------------------------------------
    PROCEDURE CmdSelTudoClick()
        THIS.this_oBusinessObject.MarcarTodos()
        THIS.grd_4c_Itens.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdApgaTudoClick - Desmarca todos os itens de grd_4c_Itens
    *--------------------------------------------------------------------------
    PROCEDURE CmdApgaTudoClick()
        THIS.this_oBusinessObject.DesmarcarTodos()
        THIS.grd_4c_Itens.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_p

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos e reativa o form pai
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
                THIS.this_oBusinessObject.LimparCursores()
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
                THIS.this_oParentForm.Enabled = .T.
                IF PEMSTATUS(THIS.this_oParentForm, "Refresh", 5)
                    THIS.this_oParentForm.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar di" + CHR(225) + "logo")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - Define foco inicial no grd_4c_Listas ao exibir o dialogo
    * Equivale ao ThisForm.GradeLista.Column1.SetFocus do Init legado
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
            THIS.grd_4c_Listas.SetFocus()
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCheck1When - Controla se o CheckBox pode ser interagido
    * Replica o When event original: Return(CsSigCdLpi.lMarcas = 0)
    * Itens ja marcados NAO podem ser desmarcados individualmente;
    * para desmarcar usar cmd_4c_ApgaTudo (Desmarcar Tudo)
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCheck1When()
        LOCAL loc_cCursor, loc_lPermitir

        loc_lPermitir = .T.
        loc_cCursor   = THIS.this_oBusinessObject.this_cCursorItens

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            IF !EOF()
                loc_lPermitir = (lMarcas = 0)
            ENDIF
        ENDIF

        RETURN loc_lPermitir
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Adiciona os itens marcados a lista de preco atual do
    * form pai. Neste dialogo OPERACIONAL "incluir" significa incluir itens
    * marcados no cursor CrSigCdLpi do form pai (mesma acao do Command1 do SCX
    * original "Adiciona os itens marcados a Lista atual").
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.CmdAdicionarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Move o foco para grd_4c_Itens permitindo ao usuario
    * alterar (marcar/desmarcar) os itens da lista de preco selecionada. Como
    * este eh um dialogo de selecao, "alterar" corresponde a editar quais
    * itens estao marcados para inclusao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCursor

        IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            GO TOP
            THIS.grd_4c_Itens.Refresh()
            THIS.grd_4c_Itens.SetFocus()
        ELSE
            MsgAviso("Nenhuma lista de pre" + CHR(231) + "o selecionada.", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Move o foco para grd_4c_Listas permitindo ao
    * usuario visualizar as listas de preco disponiveis para importacao.
    * Neste dialogo de selecao, "visualizar" corresponde a navegar entre as
    * listas de preco de origem (o SCX original faz isso via GradeLista).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCursor

        IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            GO TOP
            THIS.grd_4c_Listas.Refresh()
            THIS.grd_4c_Listas.SetFocus()
        ELSE
            MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Desmarca todos os itens marcados de grd_4c_Itens.
    * Neste dialogo de selecao, "excluir" corresponde a remover as marcacoes
    * feitas pelo usuario (mesma acao do CmdApgTudo do SCX original), com
    * confirmacao previa se houver itens marcados.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCursor, loc_nMarcados

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        COUNT FOR lMarcas = 1 TO loc_nMarcados

        IF loc_nMarcados = 0
            MsgAviso("Nenhum item marcado para remover.", "Aviso")
            RETURN
        ENDIF

        IF MsgConfirma("Desmarcar todos os " + TRANSFORM(loc_nMarcados) + ;
                       " itens marcados?", "Confirma" + CHR(231) + CHR(227) + "o")
            THIS.CmdApgaTudoClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega o grid de listas de preco disponiveis
    * Alias para CarregarGradeLista() - compatibilidade com API padrao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarGradeLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o dialogo sem adicionar itens
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Adiciona itens marcados e fecha o dialogo
    * Alias para CmdAdicionarClick() - compatibilidade com API padrao
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdAdicionarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e fecha o dialogo sem adicionar itens
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Refoca grd_4c_Listas para navegar entre listas disponiveis
    * Se o cursor de listas nao existe, recarrega via CarregarGradeLista()
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cCursor

        IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            GO TOP
            THIS.grd_4c_Listas.Refresh()
            THIS.grd_4c_Listas.SetFocus()
        ELSE
            IF !THIS.CarregarGradeLista()
                MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia dados do form para o Business Object
    * Neste dialogo OPERACIONAL, popula this_cLprecos com a lista selecionada
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            IF !EOF()
                THIS.this_oBusinessObject.this_cLprecos = ALLTRIM(lprecos)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza o form com dados do Business Object
    * Refresca os grids com os cursores atuais do BO
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_cCursorListas, loc_cCursorItens

        loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
        loc_cCursorItens  = THIS.this_oBusinessObject.this_cCursorItens

        IF USED(loc_cCursorListas) AND PEMSTATUS(THIS, "grd_4c_Listas", 5)
            THIS.grd_4c_Listas.Refresh()
        ENDIF

        IF USED(loc_cCursorItens) AND PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles editaveis do dialogo
    * par_lHabilitar: .T. habilita, .F. desabilita
    * OBS: cmd_4c_SelTudo e cmd_4c_ApgaTudo sao icone-only (Caption="") -
    *      NUNCA setar .Enabled neles (botao fica caixa vazia sem icone)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
            THIS.grd_4c_Listas.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Adicionar", 5)
            THIS.cmd_4c_Adicionar.Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Desvincula grids e fecha cursores do BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
            THIS.grd_4c_Itens.RecordSource = ""
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
            THIS.grd_4c_Listas.RecordSource = ""
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject.LimparCursores()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado do botao Adicionar conforme marcacoes
    * Conta itens marcados: habilita Adicionar se ha ao menos 1 marcado
    * OBS: cmd_4c_SelTudo e cmd_4c_ApgaTudo sao icone-only - nao alterar .Enabled
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_cCursor, loc_nMarcados

        loc_nMarcados = 0
        loc_cCursor   = THIS.this_oBusinessObject.this_cCursorItens

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            COUNT FOR lMarcas = 1 TO loc_nMarcados
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Adicionar", 5)
            THIS.cmd_4c_Adicionar.Enabled = (loc_nMarcados > 0)
        ENDIF
    ENDPROC

ENDDEFINE
