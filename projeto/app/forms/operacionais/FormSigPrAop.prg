*============================================================================
* FormSigPrAop.prg - Alteracao de Quantidade da O.P.
* Tipo: OPERACIONAL - Altera quantidades de divisoes de Ordens de Producao
* Tabelas: SigOpPic, SigCdNec, SigPdMvf, SigCdPam
*============================================================================
DEFINE CLASS FormSigPrAop AS FormBase

    *-- Layout (pixel-perfect do legado, escalado de 702x436 para 1000x600)
    Width       = 1000
    Height      = 600
    AutoCenter  = .T.
    BorderStyle = 2
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 1
    DataSession = 2
    Themes      = .F.
    ShowWindow  = 1

    *-- Propriedades de negocio
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *==========================================================================
    * Init - Apenas delega para FormBase que chama InicializarForm
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Construcao completa do form operacional
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrAopBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrAop.", "Erro")
            ELSE
                *-- Carregar parametros do sistema (DoppPads, MascNums de SigCdPam)
                IF gnConnHandle > 0
                    THIS.this_oBusinessObject.CarregarParametros()
                ENDIF

                *-- Criar cursor de trabalho das divisoes da O.P.
                *-- Estrutura identica ao Temp_DivOp do legado (evento Load)
                SET NULL ON
                CREATE CURSOR cursor_4c_DivOp ;
                    (Qtds    N(12,3) NULL, QtdDivs N(12,3) NULL, ;
                     Dopes   C(20),        Numes   N(6,0)  NULL, ;
                     Dataes  D      NULL,  Obss    M       NULL, ;
                     Nops    N(10,0)NULL,  SeqDivs N(3,0)  NULL, ;
                     Cpros   C(10),        CodCors C(4),          ;
                     CodTams C(4),         cItens  N(10,0) NULL)
                SET NULL OFF

                *-- Construir controles visuais do form
                THIS.ConfigurarPageFrame()
                THIS.Caption = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propagar Caption correto para labels do cabecalho
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Imagem de fundo + container cabecalho (cnt_4c_Sombra)
    * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo cria apenas
    * o background e o cabecalho cinza superior com labels de titulo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Imagem de fundo (forms OPERACIONAIS usam new_background.jpg)
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        *-- Container cabecalho: fundo cinza + labels sombra e titulo
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Caption   = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Caption   = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        IF VARTYPE(par_oContainer) # "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Grid (5 colunas), EditBox e CommandGroup.
    * Chamado antes de ConfigurarPaginaDados pois os handlers de txt_4c_OP
    * referenciam grd_4c_Dados e cmg_4c_Conf criados aqui.
    * Escala: original 702x436 -> novo 1000x600 (ScaleX=1.424, ScaleY=1.376)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Grid de divisoes da O.P. com 5 colunas (Pedido, Cor, Tam, Qtd.Atual, Quantidade)
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top           = 195
            .Left          = 71
            .Width         = 629
            .Height        = 285
            .FontName      = "Arial"
            .FontSize      = 8
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLines     = 3
            .GridLineWidth = 1
            .HeaderHeight  = 17
            .RowHeight     = 17
            .ScrollBars    = 2
            .ColumnCount   = 5

            *-- Column1: Pedido (Dopes + Numes - equivale a fGerMascara(Numes) do legado)
            WITH .Column1
                .Width             = 256
                .Alignment         = 0
                .ControlSource     = "ALLTRIM(cursor_4c_DivOp.Dopes) + ' ' + TRANSFORM(cursor_4c_DivOp.Numes)"
                .ReadOnly          = .T.
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Arial"
                .FontSize          = 8
                .ForeColor         = RGB(0, 0, 0)
                .Header1.Caption   = "Pedido"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Column2: Cor (CodCors)
            WITH .Column2
                .Width             = 54
                .Alignment         = 0
                .ControlSource     = "cursor_4c_DivOp.CodCors"
                .ReadOnly          = .T.
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Arial"
                .FontSize          = 8
                .Header1.Caption   = "Cor"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Column3: Tam (CodTams)
            WITH .Column3
                .Width             = 54
                .Alignment         = 0
                .ControlSource     = "cursor_4c_DivOp.CodTams"
                .ReadOnly          = .T.
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Arial"
                .FontSize          = 8
                .Header1.Caption   = "Tam"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Column4: Qtd.Atual (Qtds - quantidade original, readonly)
            WITH .Column4
                .Width             = 114
                .Alignment         = 1
                .ControlSource     = "cursor_4c_DivOp.Qtds"
                .ReadOnly          = .T.
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Arial"
                .FontSize          = 8
                .InputMask         = "999,999.999"
                .Header1.Caption   = "Qtd.Atual"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
            ENDWITH

            *-- Column5: Quantidade nova (QtdDivs - editavel pelo usuario, Format=K limpa zeros)
            WITH .Column5
                .Width             = 114
                .Alignment         = 1
                .ControlSource     = "cursor_4c_DivOp.QtdDivs"
                .ReadOnly          = .F.
                .Format            = "K"
                .Movable           = .F.
                .Resizable         = .F.
                .FontName          = "Arial"
                .FontSize          = 8
                .Header1.Caption   = "Quantidade"
                .Header1.FontName  = "Arial"
                .Header1.FontSize  = 8
                .Header1.Alignment = 2
            ENDWITH
        ENDWITH
        *-- RecordSource FORA do WITH: evita auto-bind sobrescrever ControlSources acima
        THIS.grd_4c_Dados.ColumnCount = 5
        THIS.grd_4c_Dados.RecordSource = "cursor_4c_DivOp"
        *-- Re-definir ControlSources apos auto-bind do RecordSource (VFP9 mapeia por ordem de campo)
        THIS.grd_4c_Dados.Column1.ControlSource = "ALLTRIM(cursor_4c_DivOp.Dopes) + ' ' + TRANSFORM(cursor_4c_DivOp.Numes)"
        THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_DivOp.CodCors"
        THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_DivOp.CodTams"
        THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_DivOp.Qtds"
        THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_DivOp.QtdDivs"
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        THIS.FormatarGridLista(THIS.grd_4c_Dados)

        *-- EditBox de observacoes da divisao selecionada (readonly, vinculada ao cursor)
        THIS.AddObject("edt_4c_Obss", "EditBox")
        WITH THIS.edt_4c_Obss
            .Top               = 490
            .Left              = 68
            .Width             = 632
            .Height            = 96
            .ReadOnly          = .T.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ControlSource     = "cursor_4c_DivOp.Obss"
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- CommandGroup: Confirmar (inicia desabilitado) + Encerrar
        THIS.AddObject("cmg_4c_Conf", "CommandGroup")
        WITH THIS.cmg_4c_Conf
            .Top           = 0
            .Left          = 775
            .Width         = 160
            .Height        = 85
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .ButtonCount   = 2
            .Themes        = .F.
            .AutoSize      = .F.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Confirmar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Enabled         = .F.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .WordWrap        = .T.
                .AutoSize        = .F.
                .MousePointer    = 15
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Conf.Buttons(1), "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmg_4c_Conf.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid (fonte e tamanho por coluna)
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Arial"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - Reseta o formulario operacional ao estado inicial.
    * Forms OPERACIONAIS nao tem PageFrame CRUD (Lista/Dados); esta rotina
    * limpa os inputs, zera o cursor de trabalho, desabilita Confirmar e
    * devolve o foco ao campo O.P. Usada apos Confirmar/Encerrar e para reset
    * manual do fluxo entre alteracoes de diferentes O.P.s.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF USED("cursor_4c_DivOp")
            SELECT cursor_4c_DivOp
            ZAP
        ENDIF

        IF VARTYPE(THIS.txt_4c_OP) = "O"
            THIS.txt_4c_OP.Value = ""
        ENDIF

        IF VARTYPE(THIS.txt_4c_Produto) = "O"
            THIS.txt_4c_Produto.Value = ""
        ENDIF

        IF VARTYPE(THIS.cmg_4c_Conf) = "O"
            THIS.cmg_4c_Conf.Buttons(1).Enabled = .F.
        ENDIF

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh
        ENDIF

        IF VARTYPE(THIS.edt_4c_Obss) = "O"
            THIS.edt_4c_Obss.Refresh
        ENDIF

        IF VARTYPE(THIS.txt_4c_OP) = "O"
            THIS.txt_4c_OP.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtOPGotFocus - Desabilita Confirmar ao entrar no campo O.P.
    * Equivalente ao Get_OP.When do legado: impede confirmar com OP anterior
    *==========================================================================
    PROCEDURE TxtOPGotFocus()
        IF VARTYPE(THIS.cmg_4c_Conf) = "O"
            THIS.cmg_4c_Conf.Buttons(1).Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtOPKeyPress - Carrega divisoes da O.P. ao pressionar ENTER/TAB/F4
    * Equivalente ao Get_OP.Valid do legado
    *==========================================================================
    PROCEDURE TxtOPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nNops

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(THIS.txt_4c_OP.Value))
            IF USED("cursor_4c_DivOp")
                SELECT cursor_4c_DivOp
                ZAP
            ENDIF
            THIS.txt_4c_Produto.Value = ""
            THIS.grd_4c_Dados.Refresh
            RETURN
        ENDIF

        loc_nNops = VAL(ALLTRIM(THIS.txt_4c_OP.Value))
        IF loc_nNops = 0
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarOP(loc_nNops)
            THIS.txt_4c_Produto.Value               = THIS.this_oBusinessObject.this_cCodPds
            THIS.cmg_4c_Conf.Buttons(1).Enabled     = .T.

            IF USED("cursor_4c_DivOp") AND !EOF("cursor_4c_DivOp")
                *-- Foca Column5 (Quantidade editavel) equivalente ao Grade.Column2.Text1.SetFocus do legado
                THIS.grd_4c_Dados.ActiveColumn = 5
                THIS.grd_4c_Dados.SetFocus
            ENDIF
        ELSE
            THIS.txt_4c_OP.Value      = ""
            THIS.txt_4c_Produto.Value = ""
        ENDIF

        THIS.grd_4c_Dados.Refresh
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Atualiza EditBox de Observacoes ao navegar
    * Equivalente ao Grade.AfterRowColChange do legado
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        IF VARTYPE(THIS.edt_4c_Obss) = "O"
            THIS.edt_4c_Obss.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Grava quantidades alteradas no servidor SQL
    * Equivalente ao Grupo_Conf.Salva.Click do legado
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_nNops, loc_lSucesso

        loc_nNops    = VAL(ALLTRIM(THIS.txt_4c_OP.Value))
        loc_lSucesso = .F.

        IF loc_nNops = 0
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_nNops    = loc_nNops
        THIS.this_oBusinessObject.this_cEmpDNps = THIS.this_oBusinessObject.this_cEmps + ;
                                                  THIS.this_oBusinessObject.this_cDoppPads + ;
                                                  STR(loc_nNops, 10)

        loc_lSucesso = THIS.this_oBusinessObject.SalvarAlteracoes(loc_nNops)

        IF loc_lSucesso
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * Equivalente ao Grupo_Conf.Conf_Sair.Click do legado
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia nova operacao de alteracao de O.P.
    * Form operacional: "Incluir" = resetar estado para digitar nova O.P.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Grava as quantidades alteradas (acao principal do form).
    * Form operacional: "Alterar" = confirmar mudancas no grid (delega ao Confirmar).
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Recarrega dados da O.P. digitada para visualizacao.
    * Equivale a executar novamente Get_OP.Valid do legado atualizando o grid.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nNops

        IF EMPTY(ALLTRIM(THIS.txt_4c_OP.Value))
            MsgAviso("Informe o n" + CHR(250) + "mero da O.P. para visualizar.", "Aviso")
            THIS.txt_4c_OP.SetFocus
            RETURN
        ENDIF

        loc_nNops = VAL(ALLTRIM(THIS.txt_4c_OP.Value))
        IF loc_nNops = 0
            MsgAviso("N" + CHR(250) + "mero de O.P. inv" + CHR(225) + "lido.", "Aviso")
            THIS.txt_4c_OP.SetFocus
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarOP(loc_nNops)
            THIS.txt_4c_Produto.Value           = THIS.this_oBusinessObject.this_cCodPds
            THIS.cmg_4c_Conf.Buttons(1).Enabled = .T.
            THIS.grd_4c_Dados.Refresh
            THIS.edt_4c_Obss.Refresh
        ELSE
            THIS.txt_4c_Produto.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Descarta alteracoes locais recarregando dados do servidor.
    * Form operacional: "Excluir" = cancelar mudancas no grid antes de confirmar.
    * Se nao houver O.P. carregada, apenas reseta o formulario.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nNops, loc_lConfirma

        IF EMPTY(ALLTRIM(THIS.txt_4c_OP.Value))
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        loc_nNops = VAL(ALLTRIM(THIS.txt_4c_OP.Value))
        IF loc_nNops = 0
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Descartar as altera" + CHR(231) + CHR(245) + "es e recarregar dados originais da O.P.?", "Confirma" + CHR(231) + CHR(227) + "o")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarOP(loc_nNops)
            THIS.grd_4c_Dados.Refresh
            THIS.edt_4c_Obss.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Controles de entrada de dados:
    * Labels identificadores e TextBoxes para O.P. e Produto.
    * Chamado apos ConfigurarPaginaLista pois os handlers de BINDEVENT
    * referenciam grd_4c_Dados (criado naquele metodo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Label "O.P.:"
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 128
            .Left      = 100
            .Width     = 44
            .Height    = 18
            .Caption   = "O.P. :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox numero da O.P. (entrada principal do usuario)
        THIS.AddObject("txt_4c_OP", "TextBox")
        WITH THIS.txt_4c_OP
            .Top       = 124
            .Left      = 152
            .Width     = 137
            .Height    = 23
            .InputMask = "999999999999"
            .MaxLength = 12
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_OP, "GotFocus", THIS, "TxtOPGotFocus")
        BINDEVENT(THIS.txt_4c_OP, "KeyPress", THIS, "TxtOPKeyPress")

        *-- Label "Produto:"
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 161
            .Left      = 71
            .Width     = 67
            .Height    = 18
            .Caption   = "Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox codigo do produto (preenchido ao carregar OP, readonly)
        THIS.AddObject("txt_4c_Produto", "TextBox")
        WITH THIS.txt_4c_Produto
            .Top      = 157
            .Left     = 152
            .Width    = 137
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Value    = ""
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarLista - Form OPERACIONAL nao tem lista inicial para carregar.
    * Reseta o estado do form para entrada de nova O.P.
    *==========================================================================
    PROCEDURE CarregarLista()
        THIS.LimparCampos()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormParaBO - Popula propriedades do BO com valores da tela
    *==========================================================================
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nNops  = ALLTRIM(THIS.txt_4c_OP.Value)
            THIS.this_oBusinessObject.this_cCodPds = ALLTRIM(THIS.txt_4c_Produto.Value)
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula campos da tela com valores do BO
    *==========================================================================
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cCodPds
            IF THIS.this_oBusinessObject.this_nNops > 0
                THIS.txt_4c_OP.Value = TRANSFORM(THIS.this_oBusinessObject.this_nNops)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Controla estado dos controles conforme situacao corrente
    *==========================================================================
    PROCEDURE HabilitarCampos()
        LOCAL loc_lOpCarregada

        loc_lOpCarregada = (VARTYPE(THIS.this_oBusinessObject) = "O") AND ;
                           (THIS.this_oBusinessObject.this_nNops > 0)

        IF VARTYPE(THIS.txt_4c_OP) = "O"
            THIS.txt_4c_OP.Enabled = .T.
        ENDIF

        IF VARTYPE(THIS.txt_4c_Produto) = "O"
            THIS.txt_4c_Produto.ReadOnly = .T.
        ENDIF

        IF VARTYPE(THIS.cmg_4c_Conf) = "O"
            THIS.cmg_4c_Conf.Buttons(1).Enabled = loc_lOpCarregada
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera todos os controles e cursor de trabalho
    *==========================================================================
    PROCEDURE LimparCampos()
        IF USED("cursor_4c_DivOp")
            SELECT cursor_4c_DivOp
            ZAP
        ENDIF

        IF VARTYPE(THIS.txt_4c_OP) = "O"
            THIS.txt_4c_OP.Value = ""
        ENDIF

        IF VARTYPE(THIS.txt_4c_Produto) = "O"
            THIS.txt_4c_Produto.Value = ""
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nNops  = 0
            THIS.this_oBusinessObject.this_cCodPds = ""
            THIS.this_oBusinessObject.this_cEmpDNps = ""
        ENDIF

        THIS.AjustarBotoesPorModo()

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh
        ENDIF

        IF VARTYPE(THIS.edt_4c_Obss) = "O"
            THIS.edt_4c_Obss.Refresh
        ENDIF

        IF VARTYPE(THIS.txt_4c_OP) = "O"
            THIS.txt_4c_OP.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme O.P. carregada
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lOpCarregada

        loc_lOpCarregada = (VARTYPE(THIS.this_oBusinessObject) = "O") AND ;
                           (THIS.this_oBusinessObject.this_nNops > 0)

        IF VARTYPE(THIS.cmg_4c_Conf) = "O"
            THIS.cmg_4c_Conf.Buttons(1).Enabled = loc_lOpCarregada
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Carrega a O.P. digitada no campo txt_4c_OP.
    * Form OPERACIONAL: "Buscar" = carregar divisoes da O.P. informada.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_nNops

        IF EMPTY(ALLTRIM(THIS.txt_4c_OP.Value))
            MsgAviso("Informe o n" + CHR(250) + "mero da O.P.", "Aviso")
            THIS.txt_4c_OP.SetFocus
            RETURN
        ENDIF

        loc_nNops = VAL(ALLTRIM(THIS.txt_4c_OP.Value))
        IF loc_nNops = 0
            MsgAviso("N" + CHR(250) + "mero de O.P. inv" + CHR(225) + "lido.", "Aviso")
            THIS.txt_4c_OP.SetFocus
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarOP(loc_nNops)
            THIS.txt_4c_Produto.Value           = THIS.this_oBusinessObject.this_cCodPds
            THIS.cmg_4c_Conf.Buttons(1).Enabled = .T.
            IF !EOF("cursor_4c_DivOp")
                THIS.grd_4c_Dados.ActiveColumn = 5
                THIS.grd_4c_Dados.SetFocus
            ENDIF
        ELSE
            THIS.txt_4c_OP.Value      = ""
            THIS.txt_4c_Produto.Value = ""
            THIS.cmg_4c_Conf.Buttons(1).Enabled = .F.
        ENDIF

        THIS.grd_4c_Dados.Refresh
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias de BtnConfirmarClick para compatibilidade FormBase
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela operacao corrente e reseta o form
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * Destroy - Libera cursores e recursos ao fechar o form
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aAliases[11], loc_i
        loc_aAliases[1]  = "cursor_4c_DivOp"
        loc_aAliases[2]  = "cursor_4c_Nec"
        loc_aAliases[3]  = "cursor_4c_Mvf"
        loc_aAliases[4]  = "cursor_4c_Pam"
        loc_aAliases[5]  = "cursor_4c_OpPicTemp"
        loc_aAliases[6]  = "cursor_4c_OpPicSave"
        loc_aAliases[7]  = "cursor_4c_Upd0"
        loc_aAliases[8]  = "cursor_4c_Upd1"
        loc_aAliases[9]  = "cursor_4c_Upd2"
        loc_aAliases[10] = "cursor_4c_MvfSave"
        loc_aAliases[11] = "cursor_4c_Soma"

        FOR loc_i = 1 TO ALEN(loc_aAliases)
            IF USED(loc_aAliases[loc_i])
                USE IN (loc_aAliases[loc_i])
            ENDIF
        ENDFOR

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
