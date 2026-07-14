*==============================================================================
* FormSigPrAop.prg - Formulario OPERACIONAL: Alteracao de Quantidade da O.P.
* Equivalente ao SIGPRAOP.SCX do legado
* Herda de FormBase
*==============================================================================

DEFINE CLASS FormSigPrAop AS FormBase

    *-- Dimensoes (proporcional ao original 702x436 escalado para 1000x600)
    Width         = 1000
    Height        = 600

    *-- Aparencia (reproduz propriedades visuais do SCX legado)
    Caption       = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
    TitleBar      = 0
    ControlBox    = .F.
    Closable      = .F.
    MaxButton     = .F.
    MinButton     = .F.
    AutoCenter    = .T.
    BorderStyle   = 2
    Themes        = .F.

    *-- Sessao privada (DataSession=2 no original - fix de locale em FormBase.Init)
    DataSession   = 2

    *-- Nome do cursor de trabalho (espelho do Temp_DivOp do legado)
    this_cCursorDivOp = "cursor_4c_DivOp"

    *---------------------------------------------------------------------------
    PROCEDURE Init()
    *-- FormBase.Init() faz SET DATE BRITISH/CENTURY ON e chama InicializarForm()
    *---------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *-- Para form OPERACIONAL plano (sem PageFrame): define aparencia base do form
    *---------------------------------------------------------------------------
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .F.
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Aparencia base do form
            THIS.ConfigurarPageFrame()

            *-- Inicializar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrAopBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Carregar parametros do sistema (SigCdPam: DoppPads, MascNums)
                THIS.this_oBusinessObject.CarregarParametros()

                *-- Criar cursor de trabalho (estrutura identica ao Temp_DivOp do legado)
                IF USED(THIS.this_cCursorDivOp)
                    USE IN (THIS.this_cCursorDivOp)
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_DivOp ;
                    (Dopes    C(20)    NULL, ;
                     Numes    N(6,0)   NULL, ;
                     Qtds     N(12,3)  NULL, ;
                     QtdDivs  N(12,3)  NULL, ;
                     Dataes   D        NULL, ;
                     Obss     M        NULL, ;
                     SeqDivs  N(3,0)   NULL, ;
                     Cpros    C(10)    NULL, ;
                     CodCors  C(4)     NULL, ;
                     CodTams  C(4)     NULL, ;
                     Citens   N(10,0)  NULL, ;
                     cIdChaves C(50)   NULL, ;
                     Nops     N(10,0)  NULL)
                SET NULL OFF

                *-- Criar componentes visuais
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoesConf()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaLista()

                *-- Vincular eventos dos botoes Confirmar/Encerrar do CommandGroup
                BINDEVENT(THIS.cmg_4c_BotoesConf.Buttons(1), "Click", THIS, "BtnConfirmarClick")
                BINDEVENT(THIS.cmg_4c_BotoesConf.Buttons(2), "Click", THIS, "BtnEncerrarClick")

                *-- Tornar todos os controles visiveis (AddObject cria com Visible=.F.)
                THIS.TornarControlesVisiveis(THIS)

                *-- Foco inicial no campo O.P.
                IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
                    THIS.txt_4c_OP.SetFocus()
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrAopBO.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro ao inicializar FormSigPrAop")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *-- Container escuro no topo com labels sombra+titulo (equivale ao cntSombra)
    *---------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
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
                .AutoSize = .F.
                .FontName = "Tahoma"
                .FontSize = 18
                .FontBold = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption  = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top      = 17
                .Left     = 10
                .Width    = THIS.Width
                .Height   = 46
                .AutoSize = .F.
                .FontName = "Tahoma"
                .FontSize = 18
                .FontBold = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption  = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
            ENDWITH
        ENDWITH
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesConf()
    *-- CommandGroup com botoes Confirmar e Encerrar (equivale ao Grupo_Conf)
    *-- Posicionado no canto superior direito
    *---------------------------------------------------------------------------
        THIS.AddObject("cmg_4c_BotoesConf", "CommandGroup")
        WITH THIS.cmg_4c_BotoesConf
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .AutoSize      = .T.
            .Themes        = .F.
            .Top           = 0
            .Left          = 840
            .Width         = 160
            .Height        = 85

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Caption    = "\<Confirmar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Enabled    = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
    *-- Grid principal com divisoes da O.P. (equivale ao Grade do legado)
    *-- 5 colunas: Pedido (expr), Cor, Tam, Quantidade (RO), Qtd.Atual (editavel)
    *---------------------------------------------------------------------------
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top           = 195
            .Left          = 50
            .Width         = 700
            .Height        = 285
            .ColumnCount   = 5
            .FontName      = "Arial"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLines     = 3
            .GridLineWidth = 1
            .HeaderHeight  = 17
            .RowHeight     = 17
            .ScrollBars    = 2
            .RecordSource  = THIS.this_cCursorDivOp

            *-- Coluna 1: Pedido (expressao Dopes + Numes, ReadOnly)
            WITH .Column1
                .ControlSource = "RTRIM(cursor_4c_DivOp.Dopes) + ' ' + LTRIM(STR(cursor_4c_DivOp.Numes, 6))"
                .Width         = 280
                .FontName      = "Arial"
                .FontSize      = 8
                .Alignment     = 0
                .ForeColor     = RGB(0, 0, 0)
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .Header1.Caption   = "Pedido"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.FontBold  = .F.
                .Header1.Alignment = 2
            ENDWITH

            *-- Coluna 2: Cor (CodCors, ReadOnly)
            WITH .Column2
                .ControlSource = "cursor_4c_DivOp.CodCors"
                .Width         = 60
                .FontName      = "Arial"
                .FontSize      = 8
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .Header1.Caption   = "Cor"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.FontBold  = .F.
                .Header1.Alignment = 2
            ENDWITH

            *-- Coluna 3: Tam (CodTams, ReadOnly)
            WITH .Column3
                .ControlSource = "cursor_4c_DivOp.CodTams"
                .Width         = 60
                .FontName      = "Arial"
                .FontSize      = 8
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .Header1.Caption   = "Tam"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.FontBold  = .F.
                .Header1.Alignment = 2
            ENDWITH

            *-- Coluna 4: Quantidade planejada (Qtds, ReadOnly)
            WITH .Column4
                .ControlSource = "cursor_4c_DivOp.Qtds"
                .Width         = 130
                .FontName      = "Arial"
                .FontSize      = 8
                .Alignment     = 1
                .InputMask     = "999,999.999"
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .Header1.Caption   = "Quantidade"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.FontBold  = .F.
                .Header1.Alignment = 2
            ENDWITH

            *-- Coluna 5: Qtd.Atual (QtdDivs, editavel — Format K preserva valor atual)
            WITH .Column5
                .ControlSource = "cursor_4c_DivOp.QtdDivs"
                .Width         = 130
                .FontName      = "Arial"
                .FontSize      = 8
                .Alignment     = 1
                .Format        = "K"
                .Movable       = .F.
                .Resizable     = .F.
                .Header1.Caption   = "Qtd.Atual"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.FontBold  = .F.
                .Header1.Alignment = 2
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
    *-- Atualiza EditBox de observacoes ao mudar de linha no grid (equivale
    *-- ao AfterRowColChange do Grade legado: ThisForm.Get_obss.Refresh)
    *---------------------------------------------------------------------------
        IF PEMSTATUS(THIS, "edt_4c_Obss", 5) AND VARTYPE(THIS.edt_4c_Obss) = "O"
            THIS.edt_4c_Obss.Refresh()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *-- Area de entrada de dados do form OPERACIONAL: rotulos e textboxes de
    *-- identificacao (O.P. e Produto). Equivale semanticamente ao "Page2 -
    *-- Dados" dos CRUDs, adaptado para o layout plano de SIGPRAOP.
    *-- Nao contem PageFrame: os controles sao filhos diretos do form.
    *---------------------------------------------------------------------------
        *-- Label "O.P. :"
        THIS.AddObject("lbl_4c_OP", "Label")
        WITH THIS.lbl_4c_OP
            .Top       = 108
            .Left      = 70
            .Width     = 45
            .Height    = 18
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 9
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = "O.P. :"
        ENDWITH

        *-- TextBox Get_OP (numero da ordem de producao)
        THIS.AddObject("txt_4c_OP", "TextBox")
        WITH THIS.txt_4c_OP
            .Top        = 105
            .Left       = 120
            .Width      = 120
            .Height     = 23
            .FontName   = "Tahoma"
            .FontSize   = 9
            .Alignment  = 1
            .Format     = "K"
            .InputMask  = "999999"
            .MaxLength  = 10
            .Value      = 0
            .ToolTipText = "Informe o n" + CHR(250) + "mero da Ordem de Produ" + CHR(231) + CHR(227) + "o e pressione ENTER"
        ENDWITH

        *-- Label "Produto :"
        THIS.AddObject("lbl_4c_Produto", "Label")
        WITH THIS.lbl_4c_Produto
            .Top       = 138
            .Left      = 50
            .Width     = 65
            .Height    = 18
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 9
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = "Produto :"
        ENDWITH

        *-- TextBox Get_Produto (codigo do produto - somente leitura, preenchido apos validar OP)
        THIS.AddObject("txt_4c_Produto", "TextBox")
        WITH THIS.txt_4c_Produto
            .Top        = 135
            .Left       = 120
            .Width      = 120
            .Height     = 23
            .FontName   = "Tahoma"
            .FontSize   = 9
            .Alignment  = 0
            .MaxLength  = 10
            .ReadOnly   = .T.
            .Enabled    = .F.
            .BackColor  = RGB(240, 240, 240)
            .Value      = ""
            .ToolTipText = "C" + CHR(243) + "digo do produto da O.P. (preenchido automaticamente)"
        ENDWITH

        *-- Vincular eventos do TextBox de O.P.
        BINDEVENT(THIS.txt_4c_OP, "GotFocus",  THIS, "TxtOPGotFocus")
        BINDEVENT(THIS.txt_4c_OP, "KeyPress",  THIS, "TxtOPKeyPress")
        BINDEVENT(THIS.txt_4c_OP, "LostFocus", THIS, "TxtOPLostFocus")
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *-- Area de visualizacao/lista do form OPERACIONAL: Grid de divisoes da
    *-- O.P. (5 colunas) e EditBox de observacoes da linha selecionada.
    *-- Equivale semanticamente ao "Page1 - Lista" dos CRUDs.
    *---------------------------------------------------------------------------
        *-- Grid de divisoes (5 colunas)
        THIS.ConfigurarGrade()

        *-- EditBox de observacoes (Get_obss) - abaixo do grid (ReadOnly, so exibe)
        THIS.AddObject("edt_4c_Obss", "EditBox")
        WITH THIS.edt_4c_Obss
            .Top              = 490
            .Left             = 50
            .Width            = 700
            .Height           = 90
            .FontName         = "Tahoma"
            .FontSize         = 9
            .BackColor        = RGB(255, 255, 255)
            .ForeColor        = RGB(0, 0, 0)
            .ScrollBars       = 2
            .ReadOnly         = .T.
            .ControlSource    = "cursor_4c_DivOp.Obss"
            .ToolTipText      = "Observa" + CHR(231) + CHR(245) + "es do item selecionado no grid"
        ENDWITH
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    *-- Form OPERACIONAL nao possui PageFrame (layout plano). Metodo mantido por
    *-- compatibilidade com padrao dos forms CRUD e para uso futuro caso o form
    *-- evolua para multi-pagina. Devolve foco ao campo O.P. quando invocado.
    *---------------------------------------------------------------------------
        LOCAL loc_nPagina
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        DO CASE
            CASE loc_nPagina = 1
                IF PEMSTATUS(THIS, "txt_4c_OP", 5) AND VARTYPE(THIS.txt_4c_OP) = "O"
                    IF THIS.txt_4c_OP.Enabled
                        THIS.txt_4c_OP.SetFocus()
                    ENDIF
                ENDIF
            OTHERWISE
                *-- Reservado para expansao futura
        ENDCASE

        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE TxtOPGotFocus()
    *-- Ao ganhar foco, desabilita Confirmar ate que nova O.P. seja validada
    *-- (equivale ao When do Get_OP no legado: Grupo_Conf.Salva.Enabled = .F.)
    *---------------------------------------------------------------------------
        THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE TxtOPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *-- ENTER(13) ou TAB(9) sobre o campo O.P. dispara a carga do cursor de
    *-- divisoes (equivale ao Valid do Get_OP no legado).
    *---------------------------------------------------------------------------
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.CarregarDivisoesOP()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE TxtOPLostFocus()
    *-- Ao sair do campo O.P., se ha divisoes carregadas transfere foco para o
    *-- grid (equivale ao LostFocus do Get_OP no legado).
    *---------------------------------------------------------------------------
        IF USED(THIS.this_cCursorDivOp) AND RECCOUNT(THIS.this_cCursorDivOp) > 0
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE CarregarDivisoesOP()
    *-- Valida O.P. digitada e carrega divisoes (SigOpPic) no cursor de trabalho.
    *---------------------------------------------------------------------------
        LOCAL loc_nOP, loc_lSucesso
        loc_lSucesso = .F.

        *-- Zerar cursor de trabalho antes de qualquer carga
        IF USED(THIS.this_cCursorDivOp)
            SELECT (THIS.this_cCursorDivOp)
            ZAP
        ENDIF

        *-- Desabilitar botao Confirmar enquanto O.P. nao for validada
        THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.
        THIS.txt_4c_Produto.Value = ""

        loc_nOP = INT(NVL(THIS.txt_4c_OP.Value, 0))
        IF loc_nOP <= 0
            THIS.grd_4c_Dados.Refresh()
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF

        loc_lSucesso = THIS.this_oBusinessObject.CarregarDivOp(loc_nOP, THIS.this_cCursorDivOp)

        IF loc_lSucesso
            THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cCodPds
            THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .T.
            THIS.grd_4c_Dados.Refresh()
            IF PEMSTATUS(THIS, "edt_4c_Obss", 5) AND VARTYPE(THIS.edt_4c_Obss) = "O"
                THIS.edt_4c_Obss.Refresh()
            ENDIF
        ELSE
            THIS.grd_4c_Dados.Refresh()
            THIS.txt_4c_OP.SetFocus()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
    *-- Grava alteracoes das divisoes (equivale ao Grupo_Conf.Salva.Click do legado).
    *-- A logica SQL completa esta em SigPrAopBO.Inserir().
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF

        IF INT(NVL(THIS.txt_4c_OP.Value, 0)) <= 0
            MsgAviso("Informe uma O.P. v" + CHR(225) + "lida antes de confirmar.", "Aviso")
            THIS.txt_4c_OP.SetFocus()
            RETURN
        ENDIF

        IF !USED(THIS.this_cCursorDivOp) OR RECCOUNT(THIS.this_cCursorDivOp) = 0
            MsgAviso("Nenhuma divis" + CHR(227) + "o carregada para gravar.", "Aviso")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a altera" + CHR(231) + CHR(227) + ;
                        "o das quantidades desta O.P.?", "Confirma" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_lSucesso = THIS.this_oBusinessObject.Inserir()

        IF loc_lSucesso
            MsgInfo("Altera" + CHR(231) + CHR(245) + "es gravadas com sucesso.", ;
                    "Sucesso")
            *-- Reset para nova operacao
            IF USED(THIS.this_cCursorDivOp)
                SELECT (THIS.this_cCursorDivOp)
                ZAP
            ENDIF
            THIS.txt_4c_OP.Value      = 0
            THIS.txt_4c_Produto.Value = ""
            THIS.cmg_4c_BotoesConf.Buttons(1).Enabled = .F.
            THIS.grd_4c_Dados.Refresh()
            THIS.txt_4c_OP.SetFocus()
        ENDIF
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
    *-- Encerra o formulario (equivale ao Grupo_Conf.Sair.Click do legado).
    *---------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *-- Torna Visible=.T. recursivamente (AddObject cria controles ocultos)
    *---------------------------------------------------------------------------
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE Destroy()
    *---------------------------------------------------------------------------
        IF USED(THIS.this_cCursorDivOp)
            USE IN (THIS.this_cCursorDivOp)
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
