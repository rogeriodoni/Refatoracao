*==============================================================================
* FORMSIGPRDSC.PRG - Formulario Operacional: Montagem de Descricao de Produtos
* Tipo: OPERACIONAL (flat - sem PageFrame, layout direto no form)
* Migrado de SIGPRDSC.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (800->1000px proporcional)
*   BD   -> SigCdPro (UPDATE DscCompras/ObsCompras/DPros) + SigCdDic (dicionario)
*   CODE -> arquitetura em camadas (FormBase / SigPrDscBO)
*
* Layout original (800px) escalado para 1000px (fator 1.25)
* Estrutura flat:
*   cnt_4c_Cabecalho (Top=0, L=0, W=1000, H=80)
*   cmd_4c_Encerrar  (Top=3, L=910, W=75, H=75) - standalone sobre cabecalho
*   cmd_4c_Atualizar (Top=3, L=825, W=75, H=75) - standalone sobre cabecalho
*   Labels filtros + txt_4c_CProsI/F + txt_4c_CGrus + cmd_4c_Selecionar (Top=135)
*   grd_4c_Dados     (Top=164, L=15, W=960, H=343)
*==============================================================================

DEFINE CLASS FormSigPrDsc AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (identicas ao legado, width escalado 800->1000)
    *--------------------------------------------------------------------------
    Height      = 600
    Width       = 800
    Picture     = "..\framework\imagens\new_background.jpg"
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    TitleBar    = 0
    ShowWindow = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    KeyPreview  = .T.
    DataSession = 1
    WindowType  = 1

    *--------------------------------------------------------------------------
    * Propriedades customizadas
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "SELECIONAR"

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Caption com acentos via CHR()
            THIS.Caption = "Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos"

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrDscBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- Guard para validacao UI sem conexao SQL
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    loc_lSucesso = .T.
                ELSE

                    *-- Criar cursor placeholder para o grid
                    *-- Estrutura IDENTICA ao crProdutos do legado
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Produtos (;
                        CPros       C(14)   NULL, ;
                        Portugues   C(254)  NULL, ;
                        Traduzido   C(254)  NULL, ;
                        DscCompras  M(10)   NULL, ;
                        ObsCompras  M(10)   NULL  ;
                    )
                    SET NULL OFF

                    *-- Aparencia base do form (OPERACIONAL sem PageFrame Page1/Page2)
                    THIS.ConfigurarPageFrame()

                    *-- Configurar cabecalho cinza escuro (cntSombra do legado)
                    THIS.ConfigurarCabecalho()

                    *-- Propagar Caption para labels do cabecalho
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                    *-- Configurar botoes de acao no canto superior direito
                    THIS.ConfigurarBotoes()

                    *-- Configurar area de filtros/input (equivalente Page2 Dados em OPERACIONAL)
                    THIS.ConfigurarPaginaDados()

                    *-- Configurar grade de resultados (equivalente Page1 Lista em OPERACIONAL)
                    THIS.ConfigurarPaginaLista()

                    *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
                    THIS.TornarControlesVisiveis(THIS)

                    *-- Carrega dicionario de traducoes ao abrir
                    THIS.CarregarDados()

                    loc_lSucesso = .T.

                ENDIF && gb_4c_ValidandoUI
            ELSE
                MsgErro("Falha ao criar SigPrDscBO", "Erro")
            ENDIF && VARTYPE(this_oBusinessObject)

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigPrDsc: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Aparencia base do form (OPERACIONAL sem PageFrame)
    * Forms OPERACIONAIS nao tem PageFrame Page1/Page2 como CRUD.
    * Este metodo define propriedades visuais globais do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        LOCAL loc_cCaption
        loc_cCaption = "Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos"

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = 1000
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top      = 18
                .Left     = 10
                .Width    = THIS.Width
                .Height   = 40
                .Caption  = loc_cCaption
                .FontName = "Tahoma"
                .FontSize = 18
                .FontBold = .T.
                .BackStyle = 0
                .AutoSize  = .F.
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top      = 17
                .Left     = 10
                .Width    = THIS.Width
                .Height   = 46
                .Caption  = loc_cCaption
                .FontName = "Tahoma"
                .FontSize = 18
                .FontBold = .T.
                .BackStyle = 0
                .AutoSize  = .F.
                .ForeColor = RGB(255, 255, 255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
    *==========================================================================
        *-- btnSair (Encerrar): Top=3, Left=725 no legado 800px -> Left=905 em 1000px
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 905
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Themes          = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Cancel          = .T.
            .ZOrderSet       = 1
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- btnAtualizar: Top=3, Left=650 no legado 800px -> Left=820 em 1000px
        THIS.AddObject("cmd_4c_Atualizar", "CommandButton")
        WITH THIS.cmd_4c_Atualizar
            .Top             = 3
            .Left            = 820
            .Width           = 75
            .Height          = 75
            .Caption         = "Atualizar"
            .Picture         = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
            .Themes          = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Enabled         = .F.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Atualizar, "Click", THIS, "BtnAtualizarClick")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros
    *==========================================================================
        *-- "Produtos de :" Say3 - Left=155 em 800px -> Left=194 em 1000px
        THIS.AddObject("lbl_4c_LblProdutos", "Label")
        WITH THIS.lbl_4c_LblProdutos
            .Top      = 138
            .Left     = 194
            .Width    = 95
            .Height   = 18
            .Caption  = "Produtos de :"
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- getCProsI - Left=233 em 800px -> Left=291 em 1000px
        THIS.AddObject("txt_4c_CProsI", "TextBox")
        WITH THIS.txt_4c_CProsI
            .Top       = 135
            .Left      = 291
            .Width     = 135
            .Height    = 23
            .Value     = ""
            .MaxLength = 14
            .Format    = "K"
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(THIS.txt_4c_CProsI, "KeyPress", THIS, "TxtCProsIKeyPress")

        *-- "ate" label - Say1 Left=345 em 800px -> Left=431 em 1000px
        THIS.AddObject("lbl_4c_Ate", "Label")
        WITH THIS.lbl_4c_Ate
            .Top      = 138
            .Left     = 431
            .Width    = 26
            .Height   = 18
            .Caption  = "at" + CHR(233)
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- getCProsF - Left=370 em 800px -> Left=462 em 1000px
        THIS.AddObject("txt_4c_CProsF", "TextBox")
        WITH THIS.txt_4c_CProsF
            .Top       = 135
            .Left      = 462
            .Width     = 135
            .Height    = 23
            .Value     = ""
            .MaxLength = 14
            .Format    = "K"
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(THIS.txt_4c_CProsF, "KeyPress", THIS, "TxtCProsFKeyPress")

        *-- "Grupo de Produto :" - Say2 Left=505 em 800px -> Left=631 em 1000px
        THIS.AddObject("lbl_4c_LblGrupo", "Label")
        WITH THIS.lbl_4c_LblGrupo
            .Top      = 138
            .Left     = 631
            .Width    = 134
            .Height   = 18
            .Caption  = "Grupo de Produto :"
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- getCGrus - Left=614 em 800px -> Left=768 em 1000px
        THIS.AddObject("txt_4c_CGrus", "TextBox")
        WITH THIS.txt_4c_CGrus
            .Top       = 135
            .Left      = 768
            .Width     = 39
            .Height    = 23
            .Value     = ""
            .MaxLength = 3
            .Format    = "K"
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(THIS.txt_4c_CGrus, "KeyPress", THIS, "TxtCGrusKeyPress")

        *-- btnSelecionar (arrow/search) - Left=744 em 800px -> Left=818 em 1000px
        *-- Original: a_arrow6.bmp (nao portado) -> usar geral_procura_60.jpg
        THIS.AddObject("cmd_4c_Selecionar", "CommandButton")
        WITH THIS.cmd_4c_Selecionar
            .Top             = 116
            .Left            = 818
            .Width           = 75
            .Height          = 27
            .Caption         = "Selecionar"
            .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
            .Themes          = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Selecionar"
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Selecionar, "Click", THIS, "BtnSelecionarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - configura area de input/filtros (equivalente Page2 Dados)
    * Em OPERACIONAL flat, os TextBoxes de entrada (CProsI, CProsF, CGrus) e Labels
    * associados correspondem funcionalmente aos "campos da Page2 Dados" do padrao CRUD:
    * eh a area onde o usuario digita/seleciona parametros antes de acionar Selecionar.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        THIS.ConfigurarFiltros()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - configura grade de resultados (equivalente Page1 Lista)
    * Em OPERACIONAL flat, o grid grd_4c_Dados corresponde funcionalmente a Page1
    * Lista do padrao CRUD: eh o output visual dos registros processados.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        THIS.ConfigurarGrade()
    ENDPROC

    *==========================================================================
    * AlternarPagina - stub para OPERACIONAL (sem alternancia de paginas)
    * Forms OPERACIONAIS flat nao possuem Page1/Page2 como forms CRUD.
    *==========================================================================
    PROCEDURE AlternarPagina
        LPARAMETERS par_nPagina
        *-- Nao aplicavel: layout flat sem PageFrame de alternancia
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
    *==========================================================================
        *-- Grade - Top=164, Left=15, Width=769 em 800px -> Width=960 em 1000px
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 164
            .Left              = 15
            .Width             = 960
            .Height            = 343
            .RecordMark        = .F.
            .DeleteMark        = .F.
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .RowHeight         = 17
            .HeaderHeight      = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
            .FontName          = "Verdana"
            .FontSize          = 8
        ENDWITH
        THIS.grd_4c_Dados.ColumnCount  = 3
        THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
        THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.CPros"
        THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.Portugues"
        THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.Traduzido"

        WITH THIS.grd_4c_Dados.Column1
            .ControlSource     = "cursor_4c_Produtos.CPros"
            .Width             = 135
            .Header1.Caption   = "C" + CHR(243) + "digo"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
            .ReadOnly          = .T.
        ENDWITH

        WITH THIS.grd_4c_Dados.Column2
            .ControlSource     = "cursor_4c_Produtos.Portugues"
            .Width             = 363
            .ReadOnly          = .T.
            .Header1.Caption   = "Portugu" + CHR(234) + "s"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
        ENDWITH

        WITH THIS.grd_4c_Dados.Column3
            .ControlSource     = "cursor_4c_Produtos.Traduzido"
            .Width             = 424
            .ReadOnly          = .T.
            .Header1.Caption   = "Traduzido"
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Header1.Alignment = 2
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDados
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Carrega o dicionario de traducoes ao abrir o form
            *-- Os produtos sao carregados apenas quando usuario clicar Selecionar
            loc_lSucesso = THIS.this_oBusinessObject.BuscarDicionario()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LPARAMETERS par_oContainer
        LOCAL loc_i, loc_oControl

        IF VARTYPE(par_oContainer) != "O"
            par_oContainer = THIS
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_p
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * HANDLERS DE EVENTOS
    *==========================================================================

    PROCEDURE BtnEncerrarClick
        THIS.Release()
    ENDPROC

    PROCEDURE BtnAtualizarClick
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.cmd_4c_Atualizar.Enabled = .F.
            loc_lSucesso = THIS.this_oBusinessObject.GravarDescricoes()
            IF loc_lSucesso
                LOCAL loc_nTotal
                loc_nTotal = THIS.this_oBusinessObject.this_nTotalGravados
                MsgInfo("Foram gravados " + TRANSFORM(loc_nTotal) + " produto(s).", ;
                        "Processamento Conclu" + CHR(237) + "do")
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSelecionarClick
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Validar: ao menos um filtro deve ser preenchido
            IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value)) AND ;
               EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value)) AND ;
               EMPTY(ALLTRIM(THIS.txt_4c_CGrus.Value))
                MsgAviso("Nenhum filtro foi informado.", "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_CProsI.SetFocus()
            ELSE

                *-- Se apenas inicial preenchido, preencher final com mesmo valor
                IF !EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value)) AND EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
                    THIS.txt_4c_CProsF.Value = THIS.txt_4c_CProsI.Value
                    THIS.txt_4c_CProsF.Refresh()
                ENDIF
                IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value)) AND !EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
                    THIS.txt_4c_CProsI.Value = THIS.txt_4c_CProsF.Value
                    THIS.txt_4c_CProsI.Refresh()
                ENDIF

                THIS.AtualizarEstadoCampos()

                *-- Repassar filtros ao BO
                THIS.this_oBusinessObject.this_cCProsI = ALLTRIM(THIS.txt_4c_CProsI.Value)
                THIS.this_oBusinessObject.this_cCProsF = ALLTRIM(THIS.txt_4c_CProsF.Value)
                THIS.this_oBusinessObject.this_cCGrus  = ALLTRIM(THIS.txt_4c_CGrus.Value)

                *-- Processar traducoes e popular cursor_4c_Produtos
                loc_lSucesso = THIS.this_oBusinessObject.ProcessarTraducoes()

                IF loc_lSucesso
                    THIS.cmd_4c_Atualizar.Enabled = .T.
                ELSE
                    THIS.cmd_4c_Atualizar.Enabled = .F.
                ENDIF

                *-- Recarregar grid (ColumnCount ANTES de RecordSource - regra critica)
                THIS.grd_4c_Dados.ColumnCount  = 3
                THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
                THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.CPros"
                THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.Portugues"
                THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.Traduzido"
                THIS.grd_4c_Dados.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                THIS.grd_4c_Dados.Column2.Header1.Caption = "Portugu" + CHR(234) + "s"
                THIS.grd_4c_Dados.Column3.Header1.Caption = "Traduzido"
                SELECT cursor_4c_Produtos
                GO TOP
                THIS.grd_4c_Dados.Refresh()

            ENDIF && filtros preenchidos

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- KeyPress do txt_4c_CProsI: valida produto e abre picker se nao encontrado
    PROCEDURE TxtCProsIKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cCPros, loc_cSQL, loc_oErro

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cCPros = ALLTRIM(THIS.txt_4c_CProsI.Value)

        IF EMPTY(loc_cCPros)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
            IF USED("cursor_4c_ProBusca")
                USE IN cursor_4c_ProBusca
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProBusca") >= 1 AND ;
               RECCOUNT("cursor_4c_ProBusca") > 0
                *-- Produto encontrado: copiar para CProsF se vazio + limpar CGrus (logica legado)
                IF EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
                    THIS.txt_4c_CProsF.Value = loc_cCPros
                    THIS.txt_4c_CProsF.Refresh()
                ENDIF
                THIS.txt_4c_CGrus.Value = ""
                THIS.txt_4c_CGrus.Refresh()
            ELSE
                *-- Produto nao encontrado: abrir picker
                THIS.AbrirBuscaProduto("I")
            ENDIF
            IF USED("cursor_4c_ProBusca")
                USE IN cursor_4c_ProBusca
            ENDIF
            THIS.AtualizarEstadoCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- KeyPress do txt_4c_CProsF: valida produto e abre picker se nao encontrado
    PROCEDURE TxtCProsFKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cCPros, loc_cSQL, loc_oErro

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cCPros = ALLTRIM(THIS.txt_4c_CProsF.Value)

        IF EMPTY(loc_cCPros)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
            IF USED("cursor_4c_ProBusca")
                USE IN cursor_4c_ProBusca
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProBusca") >= 1 AND ;
               RECCOUNT("cursor_4c_ProBusca") > 0
                *-- Produto encontrado: copiar para CProsI se vazio + limpar CGrus (logica legado)
                IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value))
                    THIS.txt_4c_CProsI.Value = loc_cCPros
                    THIS.txt_4c_CProsI.Refresh()
                ENDIF
                THIS.txt_4c_CGrus.Value = ""
                THIS.txt_4c_CGrus.Refresh()
            ELSE
                *-- Produto nao encontrado: abrir picker
                THIS.AbrirBuscaProduto("F")
            ENDIF
            IF USED("cursor_4c_ProBusca")
                USE IN cursor_4c_ProBusca
            ENDIF
            THIS.AtualizarEstadoCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- AbrirBuscaProduto - picker de produto SigCdPro
    *-- par_cCampo: "I" para CProsI, "F" para CProsF
    PROCEDURE AbrirBuscaProduto
        LPARAMETERS par_cCampo
        LOCAL loc_oLookup, loc_cValor, loc_cCodSel, loc_oErro
        TRY
            IF par_cCampo = "I"
                loc_cValor = ALLTRIM(THIS.txt_4c_CProsI.Value)
            ELSE
                loc_cValor = ALLTRIM(THIS.txt_4c_CProsF.Value)
            ENDIF

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                          "SigCdPro", "cursor_4c_LookupPro", "CPros", loc_cValor, ;
                          "Sele" + CHR(231) + CHR(227) + "o", .F., .T., "")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.mAddColuna("CGrus", "", "Grupo")
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LookupPro")
                    SELECT cursor_4c_LookupPro
                    loc_cCodSel = ALLTRIM(cursor_4c_LookupPro.CPros)
                    IF par_cCampo = "I"
                        THIS.txt_4c_CProsI.Value = loc_cCodSel
                        THIS.txt_4c_CProsI.Refresh()
                        IF EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
                            THIS.txt_4c_CProsF.Value = loc_cCodSel
                            THIS.txt_4c_CProsF.Refresh()
                        ENDIF
                    ELSE
                        THIS.txt_4c_CProsF.Value = loc_cCodSel
                        THIS.txt_4c_CProsF.Refresh()
                        IF EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value))
                            THIS.txt_4c_CProsI.Value = loc_cCodSel
                            THIS.txt_4c_CProsI.Refresh()
                        ENDIF
                    ENDIF
                    THIS.txt_4c_CGrus.Value = ""
                    THIS.txt_4c_CGrus.Refresh()
                ENDIF
                IF USED("cursor_4c_LookupPro")
                    USE IN cursor_4c_LookupPro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- KeyPress do txt_4c_CGrus com lookup de grupo
    PROCEDURE TxtCGrusKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cCGrus, loc_cSQL, loc_oErro

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        loc_cCGrus = ALLTRIM(THIS.txt_4c_CGrus.Value)

        IF EMPTY(loc_cCGrus)
            *-- CGrus vazio: libera filtro por intervalo de produto
            THIS.txt_4c_CProsI.Value = ""
            THIS.txt_4c_CProsF.Value = ""
            THIS.txt_4c_CProsI.Refresh()
            THIS.txt_4c_CProsF.Refresh()
            RETURN
        ENDIF

        TRY
            *-- Verificar se grupo existe em SigCdGrp
            loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cCGrus)
            IF USED("cursor_4c_GruBusca")
                USE IN cursor_4c_GruBusca
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruBusca") >= 1 AND ;
               RECCOUNT("cursor_4c_GruBusca") > 0
                *-- Grupo encontrado: limpar intervalo de produto (logica legado)
                THIS.txt_4c_CProsI.Value = ""
                THIS.txt_4c_CProsF.Value = ""
                THIS.txt_4c_CProsI.Refresh()
                THIS.txt_4c_CProsF.Refresh()
            ELSE
                *-- Grupo nao encontrado: abrir picker
                THIS.AbrirBuscaGrupo()
            ENDIF
            IF USED("cursor_4c_GruBusca")
                USE IN cursor_4c_GruBusca
            ENDIF
            THIS.AtualizarEstadoCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaGrupo
        LOCAL loc_oLookup, loc_cValor, loc_oErro
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_CGrus.Value)

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                          "SigCdGrp", "cursor_4c_LookupGru", "CGrus", loc_cValor, ;
                          "Grupo de Produto", .F., .T., "")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LookupGru")
                    SELECT cursor_4c_LookupGru
                    THIS.txt_4c_CGrus.Value = ALLTRIM(cursor_4c_LookupGru.CGrus)
                    THIS.txt_4c_CGrus.Refresh()
                    THIS.txt_4c_CProsI.Value = ""
                    THIS.txt_4c_CProsF.Value = ""
                    THIS.txt_4c_CProsI.Refresh()
                    THIS.txt_4c_CProsF.Refresh()
                ENDIF
                IF USED("cursor_4c_LookupGru")
                    USE IN cursor_4c_LookupGru
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *-- Habilita/desabilita campos conforme preenchimento (equivalente ao When do legado)
    *-- CGrus e intervalo CPros sao mutuamente exclusivos (filtros alternativos)
    PROCEDURE AtualizarEstadoCampos
        LOCAL loc_lTemCGrus, loc_lTemCPros
        loc_lTemCGrus = !EMPTY(ALLTRIM(THIS.txt_4c_CGrus.Value))
        loc_lTemCPros = !EMPTY(ALLTRIM(THIS.txt_4c_CProsI.Value)) OR ;
                        !EMPTY(ALLTRIM(THIS.txt_4c_CProsF.Value))
        THIS.txt_4c_CProsI.Enabled = !loc_lTemCGrus
        THIS.txt_4c_CProsF.Enabled = !loc_lTemCGrus
        THIS.txt_4c_CGrus.Enabled  = !loc_lTemCPros
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS (mapeados para operacoes do form OPERACIONAL)
    *
    * O SIGPRDSC legado nao tem botoes CRUD (Incluir/Alterar/Visualizar/Excluir).
    * A funcionalidade real do form eh: (1) definir filtros, (2) Selecionar
    * (popula grid via ProcessarTraducoes), (3) Atualizar (grava DPros/DscCompras
    * /ObsCompras em SigCdPro via GravarDescricoes), (4) Encerrar.
    *
    * Os 4 handlers padrao abaixo mapeiam para essas operacoes de forma
    * funcional, sem stubs:
    *   BtnIncluirClick    -> Nova selecao (limpa filtros/grid e foca no 1o campo)
    *   BtnAlterarClick    -> Grava alteracoes (delega a BtnAtualizarClick)
    *   BtnVisualizarClick -> Executa selecao (delega a BtnSelecionarClick + foca grid)
    *   BtnExcluirClick    -> Remove linha corrente do cursor (nao afeta banco)
    *==========================================================================

    PROCEDURE BtnIncluirClick
        LOCAL loc_oErro
        TRY
            *-- Nova selecao: limpa filtros, grid e prepara para novo processamento
            THIS.txt_4c_CProsI.Value = ""
            THIS.txt_4c_CProsF.Value = ""
            THIS.txt_4c_CGrus.Value  = ""
            THIS.txt_4c_CProsI.Refresh()
            THIS.txt_4c_CProsF.Refresh()
            THIS.txt_4c_CGrus.Refresh()

            THIS.txt_4c_CProsI.Enabled = .T.
            THIS.txt_4c_CProsF.Enabled = .T.
            THIS.txt_4c_CGrus.Enabled  = .T.

            *-- Zera o cursor do grid
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                ZAP
                THIS.grd_4c_Dados.Refresh()
            ENDIF

            THIS.cmd_4c_Atualizar.Enabled = .F.
            THIS.this_cModoAtual = "SELECIONAR"

            *-- Foca no primeiro campo de filtro
            THIS.txt_4c_CProsI.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnAlterarClick
        *-- No form OPERACIONAL SigPrDsc, "Alterar" significa gravar as descricoes
        *-- editadas no grid de volta a tabela SigCdPro (mesma acao do btnAtualizar).
        THIS.BtnAtualizarClick()
    ENDPROC

    PROCEDURE BtnVisualizarClick
        LOCAL loc_oErro
        TRY
            *-- Visualizar: executa selecao (popula grid) e transfere foco para o grid
            THIS.BtnSelecionarClick()

            IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
                SELECT cursor_4c_Produtos
                GO TOP
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcluirClick
        LOCAL loc_lConfirma, loc_oErro
        TRY
            IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
                MsgAviso("Nenhum produto selecionado para remover.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma( ;
                "Remover o produto atual da lista de tradu" + CHR(231) + CHR(245) + "es?" + CHR(13) + ;
                "(A tabela SigCdPro n" + CHR(227) + "o ser" + CHR(225) + " alterada at" + CHR(233) + " que voc" + CHR(234) + " clique em Atualizar)", ;
                "Confirma" + CHR(231) + CHR(227) + "o")

            IF loc_lConfirma
                LOCAL loc_nRestantes
                SELECT cursor_4c_Produtos
                DELETE
                SET DELETED ON
                THIS.grd_4c_Dados.Refresh()

                *-- Conta registros nao-deletados restantes (COUNT nao aceita IN <alias> em VFP9)
                SELECT cursor_4c_Produtos
                COUNT FOR NOT DELETED() TO loc_nRestantes
                THIS.cmd_4c_Atualizar.Enabled = (loc_nRestantes > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * METODOS DE INTERFACE FORMBASE (OPERACIONAL)
    * Implementacao especifica do form OPERACIONAL SigPrDsc.
    * Substituem stubs do FormBase com logica real do form.
    *==========================================================================

    *-- BtnBuscarClick: executa selecao de produtos (equivalente a Buscar em CRUD)
    PROCEDURE BtnBuscarClick
        THIS.BtnSelecionarClick()
    ENDPROC

    *-- BtnSalvarClick: grava descricoes nos produtos (equivalente a Salvar em CRUD)
    PROCEDURE BtnSalvarClick
        THIS.BtnAtualizarClick()
    ENDPROC

    *-- BtnCancelarClick: cancela selecao e reseta form para estado inicial
    PROCEDURE BtnCancelarClick
        THIS.BtnIncluirClick()
    ENDPROC

    *-- FormParaBO: transfere filtros do form para o Business Object
    PROTECTED PROCEDURE FormParaBO
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.this_oBusinessObject.this_cCProsI = ALLTRIM(THIS.txt_4c_CProsI.Value)
        THIS.this_oBusinessObject.this_cCProsF = ALLTRIM(THIS.txt_4c_CProsF.Value)
        THIS.this_oBusinessObject.this_cCGrus  = ALLTRIM(THIS.txt_4c_CGrus.Value)
    ENDPROC

    *-- BOParaForm: restaura filtros do Business Object para os campos do form
    PROTECTED PROCEDURE BOParaForm
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.txt_4c_CProsI.Value = THIS.this_oBusinessObject.this_cCProsI
        THIS.txt_4c_CProsF.Value = THIS.this_oBusinessObject.this_cCProsF
        THIS.txt_4c_CGrus.Value  = THIS.this_oBusinessObject.this_cCGrus
        THIS.txt_4c_CProsI.Refresh()
        THIS.txt_4c_CProsF.Refresh()
        THIS.txt_4c_CGrus.Refresh()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *-- HabilitarCampos: habilita ou desabilita campos de filtro e botao Selecionar
    *-- par_lHabilitar: .T. = habilitar, .F. = desabilitar
    PROTECTED PROCEDURE HabilitarCampos
        LPARAMETERS par_lHabilitar
        IF VARTYPE(par_lHabilitar) != "L"
            par_lHabilitar = .T.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CProsI", 5)
            THIS.txt_4c_CProsI.Enabled = par_lHabilitar
            THIS.txt_4c_CProsF.Enabled = par_lHabilitar
            THIS.txt_4c_CGrus.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Selecionar", 5)
            THIS.cmd_4c_Selecionar.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *-- LimparCampos: limpa filtros de selecao e zera o grid de resultados
    PROTECTED PROCEDURE LimparCampos
        IF PEMSTATUS(THIS, "txt_4c_CProsI", 5)
            THIS.txt_4c_CProsI.Value = ""
            THIS.txt_4c_CProsF.Value = ""
            THIS.txt_4c_CGrus.Value  = ""
            THIS.txt_4c_CProsI.Refresh()
            THIS.txt_4c_CProsF.Refresh()
            THIS.txt_4c_CGrus.Refresh()
        ENDIF
        IF USED("cursor_4c_Produtos")
            SELECT cursor_4c_Produtos
            ZAP
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Atualizar", 5)
            THIS.cmd_4c_Atualizar.Enabled = .F.
        ENDIF
        THIS.HabilitarCampos(.T.)
        THIS.this_cModoAtual = "SELECIONAR"
    ENDPROC

    *-- CarregarLista: carrega dados iniciais (dicionario de traducoes SigCdDic)
    *-- Em OPERACIONAL SigPrDsc a "lista" eh o dicionario; produtos sao carregados
    *-- apenas ao acionar Selecionar.
    PROCEDURE CarregarLista
        RETURN THIS.CarregarDados()
    ENDPROC

    *-- AjustarBotoesPorModo: ajusta estado dos botoes conforme produtos no grid
    *-- Atualizar habilitado apenas quando ha produtos processados no cursor
    PROCEDURE AjustarBotoesPorModo
        LOCAL loc_lTemProdutos
        loc_lTemProdutos = USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
        IF PEMSTATUS(THIS, "cmd_4c_Atualizar", 5)
            THIS.cmd_4c_Atualizar.Enabled = loc_lTemProdutos
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF
        IF USED("cursor_4c_ProdTemp")
            USE IN cursor_4c_ProdTemp
        ENDIF
        IF USED("cursor_4c_Dicionario")
            USE IN cursor_4c_Dicionario
        ENDIF
        IF USED("cursor_4c_LocalPro")
            USE IN cursor_4c_LocalPro
        ENDIF
        IF USED("cursor_4c_GruBusca")
            USE IN cursor_4c_GruBusca
        ENDIF
        IF USED("cursor_4c_LookupGru")
            USE IN cursor_4c_LookupGru
        ENDIF
        IF USED("cursor_4c_ProBusca")
            USE IN cursor_4c_ProBusca
        ENDIF
        IF USED("cursor_4c_LookupPro")
            USE IN cursor_4c_LookupPro
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
