*==============================================================================
* FormSigPrEop.prg - Selecao de Operacoes de Producao
* Tipo       : OPERACIONAL (popup modal de selecao)
* Legado     : SIGPREOP.SCX
* BO         : SigPrEopBO
*==============================================================================
DEFINE CLASS FormSigPrEop AS FormBase

    *-- Dimensoes (original 740x431 mantido - popup modal sobre form pai)
    Width        = 740
    Height       = 431

    *-- Aparencia (reproduz propriedades do SCX legado)
    Caption      = "Opera" + CHR(231) + CHR(245) + "es"
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    AlwaysOnTop  = .T.
    AutoCenter   = .T.
    BorderStyle  = 2
    WindowType   = 1
    Themes       = .F.
    ClipControls = .F.
    DataSession  = 1

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Referencia ao form pai (sera re-habilitado ao fechar)
    this_oFormPai        = .NULL.

    *-- Titulo da coluna 4 do grid (par_cCabData do legado: ex "Prev. Entrega")
    this_cCabData        = "Prev. Entrega"

    *-- Cursor de origem com operacoes carregadas (crTprMvCab no legado)
    this_cCursorOrigem   = "crTprMvCab"

    *-- Cursor destino para operacoes selecionadas (crFilOper no legado)
    this_cCursorDestino  = "crFilOper"

    *--------------------------------------------------------------------------
    * Init - Captura parametros ANTES de DODEFAULT() chamar InicializarForm()
    * par_oFormPai    : referencia ao form que abriu este popup (obrigatorio)
    * par_cCabData    : titulo da 4a coluna do grid (ex: "Prev. Entrega")
    * par_cCursorOrig : nome do cursor de origem (default: crTprMvCab)
    * par_cCursorDest : nome do cursor destino (default: crFilOper)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cCabData, par_cCursorOrig, par_cCursorDest)
        *-- Armazenar referencia ao pai e desabilita-lo antes de DODEFAULT
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
            THIS.this_oFormPai.Enabled = .F.
        ENDIF

        IF VARTYPE(par_cCabData) = "C" AND !EMPTY(par_cCabData)
            THIS.this_cCabData = par_cCabData
        ENDIF

        IF VARTYPE(par_cCursorOrig) = "C" AND !EMPTY(par_cCursorOrig)
            THIS.this_cCursorOrigem = par_cCursorOrig
        ENDIF

        IF VARTYPE(par_cCursorDest) = "C" AND !EMPTY(par_cCursorDest)
            THIS.this_cCursorDestino = par_cCursorDest
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Aparencia base do form (sem PageFrame real)
    * Chamado por InicializarForm() antes de criar controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta o form: BO -> cursor -> layout -> visibilidade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Aparencia base
            THIS.ConfigurarPageFrame()

            *-- Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrEopBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrEopBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Inicializar cursor de operacoes a partir do cursor de origem
            IF !THIS.this_oBusinessObject.InicializarOperacoes(THIS.this_cCursorOrigem)
                MsgErro("Falha ao inicializar cursor de opera" + CHR(231) + CHR(245) + ;
                        "es a partir de '" + THIS.this_cCursorOrigem + "'", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Montar estrutura visual (dispatcher unico da tela de lista)
            THIS.ConfigurarPaginaLista()

            *-- Propagar Caption do form para os labels do cabecalho
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- BINDEVENTs
            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdAfterRowColChange")
            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "Click",     THIS, "ChkSelecaoClick")
            BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Check1, "KeyPress",  THIS, "ChkSelecaoKeyPress")
            BINDEVENT(THIS.chk_4c_Ck_Marca,                    "Click",     THIS, "ChkMarcaClick")
            BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Confirmar,      "Click",     THIS, "CmdConfirmarClick")

            *-- Tornar controles visiveis apos AddObject (que cria com Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Dispatcher da tela unica deste popup OPERACIONAL
    * Este form nao tem PageFrame Page1/Page2 (CRUD) porque eh um popup modal
    * de selecao. A "pagina de lista" corresponde a montagem completa da tela:
    * cabecalho cinza, botao de confirmacao, grid de operacoes e controles de
    * status (checkbox marcar-todos + textboxes operacao/numero).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarSaida()
        THIS.ConfigurarGrade()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Controles de status/detalhe da selecao
    * Checkbox marcar-todos (ck_Marca), label+textbox da operacao corrente
    * (lbl_descricao + get_Operacao) e label+textbox do numero da operacao
    * (Say1 + get_Numes) ? todos na faixa inferior do popup (Top >= 398).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.AddObject("chk_4c_Ck_Marca", "CheckBox")
        WITH THIS.chk_4c_Ck_Marca
            .Top         = 123
            .Left        = 15
            .Width       = 13
            .Height      = 17
            .Caption     = ""
            .Value       = 1
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ToolTipText = "Marcar/Desmarcar todas as opera" + CHR(231) + CHR(245) + "es"
        ENDWITH

        THIS.AddObject("lbl_4c_Lbl_descricao", "Label")
        WITH THIS.lbl_4c_Lbl_descricao
            .AutoSize  = .T.
            .FontSize  = 8
            .FontName  = "Tahoma"
            .Alignment = 0
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Height    = 15
            .Left      = 19
            .Top       = 402
            .Width     = 56
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_Operacao", "TextBox")
        WITH THIS.txt_4c_Operacao
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .Value         = ""
            .ControlSource = "cursor_4c_Operacoes.Dopes"
            .Format        = "K!"
            .Height        = 25
            .MaxLength     = 40
            .SpecialEffect = 0
            .Left          = 87
            .Top           = 398
            .Width         = 150
            .ForeColor     = RGB(0,0,0)
            .BackColor     = RGB(255,255,255)
            .ReadOnly      = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .T.
            .FontSize  = 8
            .FontName  = "Tahoma"
            .Alignment = 0
            .Caption   = "N" + CHR(186) + " :"
            .Height    = 15
            .Left      = 249
            .Top       = 402
            .Width     = 21
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_Numes", "TextBox")
        WITH THIS.txt_4c_Numes
            .FontName      = "Tahoma"
            .FontSize      = 9
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .Value         = 0
            .ControlSource = "cursor_4c_Operacoes.Numes"
            .Height        = 25
            .SpecialEffect = 0
            .Left          = 276
            .Top           = 398
            .Width         = 50
            .ForeColor     = RGB(0,0,0)
            .BackColor     = RGB(255,255,255)
            .ReadOnly      = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Refresh do popup: vai ao topo do cursor e sincroniza grid
    * e textboxes de status. Parametro par_nPagina aceito para compatibilidade
    * com o contrato de forms CRUD; qualquer valor invoca o mesmo refresh.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lTemDados
        loc_lTemDados = USED("cursor_4c_Operacoes") ;
                        AND RECCOUNT("cursor_4c_Operacoes") > 0

        IF loc_lTemDados
            SELECT cursor_4c_Operacoes
            GO TOP IN cursor_4c_Operacoes
        ENDIF

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
            IF loc_lTemDados
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        ENDIF

        IF VARTYPE(THIS.txt_4c_Operacao) = "O"
            THIS.txt_4c_Operacao.Refresh()
        ENDIF

        IF VARTYPE(THIS.txt_4c_Numes) = "O"
            THIS.txt_4c_Numes.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza com titulo (cntSombra do legado)
    * Top=0/Left=0/Width=Form.Width/Height=80 | BackColor=RGB(100,100,100)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cTitulo
        loc_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = loc_cTitulo
                .Height    = 40
                .Left      = 10
                .Top       = 25
                .Width     = THIS.Width
                .ForeColor = RGB(0,0,0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = loc_cTitulo
                .Height    = 46
                .Left      = 10
                .Top       = 24
                .Width     = THIS.Width
                .ForeColor = RGB(255,255,255)
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarSaida - Container transparente com botao OK (cmdSair do legado)
    * Shape1 original era o fundo visual; aqui unificado no container
    * Posicao original: Shape1 Top=7/Left=634/W=90/H=110, cmdSair Left=663
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarSaida()
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top         = 7
            .Left        = 917
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderWidth = 0

            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
                .Top             = 5
                .Left            = 917
                .Width           = 90
                .Height          = 75
                .Caption         = "OK"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .ToolTipText     = "OK - Confirmar sele" + CHR(231) + CHR(227) + "o"
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * AddObject() cria com Visible=.F. por default
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - Grid de selecao de operacoes (grdOperacoes do legado)
    * 7 colunas: selecao (checkbox), data, empresa, prev. entrega, cliente, nome, conjugue
    * Regras criticas: AddObject chk_4c_Check1 ANTES de CurrentControl,
    *   CurrentControl ANTES de ControlSource, Sparse=.F. obrigatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top               = 121
            .Left              = 3
            .Width             = 732
            .Height            = 275
            .ColumnCount       = 7
            .FontName          = "Tahoma"
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .HeaderHeight      = 19
            .ReadOnly          = .F.
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .GridLineColor     = RGB(238,238,238)

            WITH .Column1
                .Width     = 15
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .F.
                .Sparse    = .F.
                .AddObject("chk_4c_Check1", "CheckBox")
                WITH .chk_4c_Check1
                    .Caption  = ""
                    .Value    = 0
                    .AutoSize = .T.
                ENDWITH
                .CurrentControl    = "chk_4c_Check1"
                .ControlSource     = "cursor_4c_Operacoes.Selecionada"
                .Header1.Caption   = ""
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
            ENDWITH

            WITH .Column2
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .ControlSource     = "cursor_4c_Operacoes.Datas"
                .Header1.Caption   = "Data"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
            ENDWITH

            WITH .Column3
                .Width             = 35
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .ControlSource     = "cursor_4c_Operacoes.Emps"
                .Header1.Caption   = "Emp"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
            ENDWITH

            WITH .Column4
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .ControlSource     = "cursor_4c_Operacoes.PrazoEnts"
                .Header1.Caption   = THIS.this_cCabData
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
            ENDWITH

            WITH .Column5
                .Width             = 80
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .ControlSource     = "cursor_4c_Operacoes.Contas"
                .Header1.Caption   = "Cliente"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
            ENDWITH

            WITH .Column6
                .Width             = 200
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .ControlSource     = "cursor_4c_Operacoes.RClis"
                .Header1.Caption   = "Nome do Cliente"
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
            ENDWITH

            WITH .Column7
                .Width             = 205
                .Movable           = .F.
                .Resizable         = .F.
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 9
                .ControlSource     = "cursor_4c_Operacoes.Conjuges"
                .Header1.Caption   = "Conjug" + CHR(233)
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90,90,90)
                .Header1.FontName  = "Tahoma"
                .Header1.FontSize  = 8
            ENDWITH

            .RecordSource = "cursor_4c_Operacoes"
            *-- Re-definir ControlSource apos RecordSource (VFP auto-bind por ordem de campo quebra bindings anteriores)
            .Column1.ControlSource = "cursor_4c_Operacoes.Selecionada"
            .Column2.ControlSource = "cursor_4c_Operacoes.Datas"
            .Column3.ControlSource = "cursor_4c_Operacoes.Emps"
            .Column4.ControlSource = "cursor_4c_Operacoes.PrazoEnts"
            .Column5.ControlSource = "cursor_4c_Operacoes.Contas"
            .Column6.ControlSource = "cursor_4c_Operacoes.RClis"
            .Column7.ControlSource = "cursor_4c_Operacoes.Conjuges"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdAfterRowColChange - Atualiza textboxes de status ao navegar no grid
    * (equivalente ao grdOperacoes.AfterRowColChange do legado)
    *--------------------------------------------------------------------------
    PROCEDURE GrdAfterRowColChange
        LPARAMETERS par_nColIndex
        IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
            THIS.txt_4c_Operacao.Refresh()
            THIS.txt_4c_Numes.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkSelecaoClick - Refresca grid apos toggle automatico via ControlSource
    * Cursor ja foi atualizado pelo binding antes de Click disparar
    *--------------------------------------------------------------------------
    PROCEDURE ChkSelecaoClick
        IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkSelecaoKeyPress - Inverte selecao ao pressionar ENTER ou SPACE
    * Original: InList(nKeyCode, 13, 32) -> GATHER MEMVAR Fields Selecionada
    * ENTER e SPACE ambos alternam; ControlSource nao suprime default, por isso
    * usamos AlternarSelecao (toggle via GATHER MEMVAR como o legado) para ambos.
    *--------------------------------------------------------------------------
    PROCEDURE ChkSelecaoKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF INLIST(par_nKeyCode, 13, 32)
            IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
                THIS.this_oBusinessObject.AlternarSelecao("cursor_4c_Operacoes")
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaClick - Marca ou desmarca todas as operacoes (ck_Marca do legado)
    * Value ja esta no novo estado (VFP9 togglou antes de Click disparar)
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaClick
        IF USED("cursor_4c_Operacoes")
            THIS.this_oBusinessObject.MarcarDesmarcarTodos( ;
                THIS.chk_4c_Ck_Marca.Value, "cursor_4c_Operacoes")
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdConfirmarClick - Popula cursor destino com operacoes selecionadas e fecha
    * Equivalente ao cmdSair.Click do legado: ZAP + SCAN(Selecionada=1) + Release
    *--------------------------------------------------------------------------
    PROCEDURE CmdConfirmarClick
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.this_oBusinessObject.PopularFilOper( ;
                THIS.this_cCursorDestino, "cursor_4c_Operacoes")
            IF !loc_lSucesso
                MsgErro("Falha ao processar sele" + CHR(231) + CHR(227) + ;
                        "o de opera" + CHR(231) + CHR(245) + "es", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        IF loc_lSucesso
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Popup OPERACIONAL: mapeia p/ marcar TODAS as operacoes
    * Legado SIGPREOP nao tem botao Incluir - contrato do pipeline exige metodo.
    * Semantica: incluir todas as operacoes na selecao (equivalente ao ck_Marca
    * do legado quando Value=1). Reusa BO.MarcarDesmarcarTodos + sincroniza UI.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Operacoes") OR RECCOUNT("cursor_4c_Operacoes") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " opera" + ;
                        CHR(231) + CHR(245) + "es para incluir na sele" + ;
                        CHR(231) + CHR(227) + "o.", "Aviso")
                RETURN
            ENDIF
            THIS.this_oBusinessObject.MarcarDesmarcarTodos(1, "cursor_4c_Operacoes")
            IF VARTYPE(THIS.chk_4c_Ck_Marca) = "O"
                THIS.chk_4c_Ck_Marca.Value = 1
            ENDIF
            THIS.grd_4c_Dados.Refresh()
            THIS.txt_4c_Operacao.Refresh()
            THIS.txt_4c_Numes.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Popup OPERACIONAL: mapeia p/ alternar selecao corrente
    * Legado SIGPREOP nao tem botao Alterar - contrato do pipeline exige metodo.
    * Semantica: alterna Selecionada do registro corrente (equivalente ao
    * chk_4c_Check1.KeyPress ENTER/SPACE do legado). Reusa BO.AlternarSelecao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Operacoes") OR RECCOUNT("cursor_4c_Operacoes") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " opera" + ;
                        CHR(231) + CHR(227) + "o corrente para alterar.", "Aviso")
                RETURN
            ENDIF
            THIS.this_oBusinessObject.AlternarSelecao("cursor_4c_Operacoes")
            THIS.grd_4c_Dados.Refresh()
            THIS.txt_4c_Operacao.Refresh()
            THIS.txt_4c_Numes.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Popup OPERACIONAL: mapeia p/ sincronizar visualizacao
    * Legado SIGPREOP nao tem botao Visualizar - contrato do pipeline exige metodo.
    * Semantica: reposiciona no topo, refresca grid e textboxes de status
    * (equivalente a AlternarPagina em forms CRUD - refresh completo da lista).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Operacoes") OR RECCOUNT("cursor_4c_Operacoes") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " opera" + ;
                        CHR(231) + CHR(245) + "es para visualizar.", "Aviso")
                RETURN
            ENDIF
            SELECT cursor_4c_Operacoes
            GO TOP IN cursor_4c_Operacoes
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.SetFocus()
            THIS.txt_4c_Operacao.Refresh()
            THIS.txt_4c_Numes.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Popup OPERACIONAL: mapeia p/ excluir todas da selecao
    * Legado SIGPREOP nao tem botao Excluir - contrato do pipeline exige metodo.
    * Semantica: remove todas as operacoes da selecao (desmarca Selecionada=0).
    * Reusa BO.MarcarDesmarcarTodos(0) + sincroniza UI.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro, loc_lConfirmar
        TRY
            IF !USED("cursor_4c_Operacoes") OR RECCOUNT("cursor_4c_Operacoes") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " opera" + ;
                        CHR(231) + CHR(245) + "es para excluir da sele" + ;
                        CHR(231) + CHR(227) + "o.", "Aviso")
                RETURN
            ENDIF
            loc_lConfirmar = MsgConfirma("Confirma excluir todas as opera" + ;
                CHR(231) + CHR(245) + "es da sele" + CHR(231) + CHR(227) + ;
                "o corrente?", "Confirma" + CHR(231) + CHR(227) + "o")
            IF !loc_lConfirmar
                RETURN
            ENDIF
            THIS.this_oBusinessObject.MarcarDesmarcarTodos(0, "cursor_4c_Operacoes")
            IF VARTYPE(THIS.chk_4c_Ck_Marca) = "O"
                THIS.chk_4c_Ck_Marca.Value = 0
            ENDIF
            THIS.grd_4c_Dados.Refresh()
            THIS.txt_4c_Operacao.Refresh()
            THIS.txt_4c_Numes.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Refresca o grid reposicionando no topo do cursor
    * OPERACIONAL: cursor ja foi inicializado por InicializarOperacoes()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
                SELECT cursor_4c_Operacoes
                GO TOP
            ENDIF
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            IF VARTYPE(THIS.txt_4c_Operacao) = "O"
                THIS.txt_4c_Operacao.Refresh()
            ENDIF
            IF VARTYPE(THIS.txt_4c_Numes) = "O"
                THIS.txt_4c_Numes.Refresh()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Reposiciona no topo e refresca o grid de operacoes
    * OPERACIONAL: popup recebe cursor pre-populado (sem busca por texto)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
        IF VARTYPE(THIS.grd_4c_Dados) = "O" AND USED("cursor_4c_Operacoes") ;
                AND RECCOUNT("cursor_4c_Operacoes") > 0
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirma selecao e fecha popup (equivalente ao OK)
    * Popula cursor destino com operacoes marcadas (Selecionada = 1)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela sem processar: reabilita pai e fecha popup
    * Nao popula crFilOper - pai interpretara cursor destino intacto como cancelamento
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
        ENDTRY
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha popup sem processar (Encerrar/ESC do sistema)
    * Equivalente a BtnCancelarClick neste popup de selecao
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza BO com a linha corrente do cursor de operacoes
    * OPERACIONAL: sem campos editaveis no form - le posicao corrente do grid
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Operacoes") ;
                AND !EOF("cursor_4c_Operacoes") AND !BOF("cursor_4c_Operacoes")
            THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Operacoes")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Refresca controles de status com dados da linha corrente
    * OPERACIONAL: ControlSource ja faz binding; apenas refresca displays
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.txt_4c_Operacao) = "O"
            THIS.txt_4c_Operacao.Refresh()
        ENDIF
        IF VARTYPE(THIS.txt_4c_Numes) = "O"
            THIS.txt_4c_Numes.Refresh()
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Controla habilitacao de controles interativos
    * OPERACIONAL: grid e checkbox sao sempre interativos neste popup modal
    * par_lHabilitar: .T. = habilitar, .F. = desabilitar (default .T.)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF VARTYPE(THIS.chk_4c_Ck_Marca) = "O"
            THIS.chk_4c_Ck_Marca.Enabled = loc_lHabilitar
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Enabled = loc_lHabilitar
        ENDIF
        IF VARTYPE(THIS.cnt_4c_Saida) = "O"
            THIS.cnt_4c_Saida.cmd_4c_Confirmar.Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Desmarca todas as operacoes (zera Selecionada no cursor)
    * OPERACIONAL: LimparCampos = desmarcar toda a selecao corrente
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("cursor_4c_Operacoes")
            THIS.this_oBusinessObject.MarcarDesmarcarTodos(0, "cursor_4c_Operacoes")
            IF VARTYPE(THIS.chk_4c_Ck_Marca) = "O"
                THIS.chk_4c_Ck_Marca.Value = 0
            ENDIF
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - OPERACIONAL: popup nao tem modos CRUD
    * Mantido para compatibilidade com contrato do pipeline de migracao.
    * Garante botao OK habilitado apenas se ha operacoes carregadas.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cnt_4c_Saida) = "O"
            THIS.cnt_4c_Saida.cmd_4c_Confirmar.Enabled = ;
                USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Reabilita form pai e libera cursor de operacoes
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oFormPai) = "O"
                THIS.this_oFormPai.Enabled = .T.
            ENDIF
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
