*===============================================================================
* FormSigPrCar.prg - Sub-form modal: Caracter" + CHR(237) + "sticas do Produto
* Legado: SigPrCar.SCX (OPERACIONAL sub-form)
* Herda de FormBase
* Chamado por: FormSigPrAop / FormSigPrApr com produto selecionado
* Interface: CREATEOBJECT("FormSigPrCar", oParentForm, cCpros, cCgrus, cPcEscolha)
*
* MIGRACAO COMPLETA (8/8 fases)
*   - Init(4 params): armazena ParentForm, CPros, CGrus, PcEscolha
*   - ConfigurarPageFrame: fundo new_background.jpg (form plano OPERACIONAL)
*   - ConfigurarCabecalho: cnt_4c_Cabecalho cinza com lbl_4c_Sombra/Titulo
*   - ConfigurarBotoes: Shape1 + cmd_4c_Inserir/Excluir/Sair
*   - ConfigurarGrade: grd_4c_Grade (2 colunas Codigos+Descrs) + cursor placeholder
*   - CarregarGrid: SQLEXEC sigprcar filtrado por CPros (cursor temp + ZAP/APPEND)
*   - AjustarBotoesVisibilidade: Inserir/Excluir visiveis apenas em INSERIR/ALTERAR
*   - RegistrarBINDEVENTs: Click e KeyPress bindados
*   - CmdInserirClick: insere linha vazia, foca Column1
*   - CmdExcluirClick: deleta linha corrente (guard CPros)
*   - CmdSairClick: limpa linhas vazias, reabilita form pai, Release
*   - GrdCol1/2KeyPress: guard ENTER/TAB/F4 + ValidarCodigo/Descricao
*   - ValidarCodigo/Descricao: match exato + duplicidade + picker
*   - AbrirPickerCodigo/Descricao: FormBuscaAuxiliar com filtro CGrus em SIGCRRAP
*   - Destroy: cursor + BO liberados
*===============================================================================

DEFINE CLASS FormSigPrCar AS FormBase

    *-- Dimensoes identicas ao original (sub-form pequeno, NAO 1000x600)
    Width       = 480
    Height      = 540

    Caption     = ""
    TitleBar    = 0
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    AutoCenter  = .T.
    BorderStyle = 2
    Themes      = .F.
    DataSession = 1
    ShowTips    = .T.
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Referencia ao form chamador (recebida em Init)
    this_oParentForm  = .NULL.

    *-- Dados do produto passados pelo form pai
    this_cCpros      = ""    && codigo do produto (CPros de SigCdPro)
    this_cCgrus      = ""    && grupo do produto  (CGrus - filtro do lookup SIGCRRAP)

    *-- Modo de operacao herdado do form pai (INSERIR/ALTERAR/CONSULTAR)
    this_cPcEscolha  = "CONSULTAR"

    *-- Flags consultadas pelo form pai apos fechar o sub-form
    this_lHouveIncl  = .F.
    this_lHouveExcl  = .F.

    *-- Alias do cursor local de caracteristicas
    this_cCursorCarac = "cursor_4c_CaracProd"

    *===========================================================================
    PROCEDURE Init(par_oParentForm, par_cCpros, par_cCgrus, par_cPcEscolha)
    *-- Armazena parametros do form pai ANTES de InicializarForm().
    *-- DODEFAULT() chama FormBase.Init() -> THIS.InicializarForm()
    *===========================================================================
        THIS.Caption          = "Caracter" + CHR(237) + "sticas do Produto"
        THIS.this_oParentForm = par_oParentForm
        THIS.this_cCpros      = IIF(VARTYPE(par_cCpros)     = "C", ALLTRIM(par_cCpros),     "")
        THIS.this_cCgrus      = IIF(VARTYPE(par_cCgrus)     = "C", ALLTRIM(par_cCgrus),     "")
        THIS.this_cPcEscolha  = IIF(VARTYPE(par_cPcEscolha) = "C", UPPER(par_cPcEscolha),   "CONSULTAR")

        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *-- Configuracao base do form plano OPERACIONAL (sem PageFrame real).
    *-- Aplica imagem de fundo identica ao legado new_background.jpg.
    *===========================================================================
        LOCAL loc_cImgFundo

        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF

        THIS.ScrollBars = 0
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *-- Cria estrutura visual do sub-form.
    *-- FASE 3: PageFrame (background) + Cabecalho.
    *-- FASE 4: ConfigurarBotoes (Shape1 + cmdInserir/Excluir/Sair) + ConfigurarGrade.
    *-- Fases 5+: CarregarGrid, AjustarBotoesVisibilidade, BINDEVENTs.
    *===========================================================================
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.TornarControlesVisiveis(THIS)
                THIS.AjustarBotoesVisibilidade()
                loc_lSucesso = .T.
            ELSE
                IF gnConnHandle <= 0
                    MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + ;
                            CHR(227) + "o estabelecida.", "Erro de Conex" + CHR(227) + "o")
                ELSE
                    THIS.this_oBusinessObject = CREATEOBJECT("SigPrCarBO")
                    IF VARTYPE(THIS.this_oBusinessObject) != "O"
                        MsgErro("Falha ao criar SigPrCarBO.", "Erro")
                    ELSE
                        THIS.ConfigurarPageFrame()
                        THIS.ConfigurarCabecalho()
                        THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                        THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                        THIS.ConfigurarPaginaLista()
                        THIS.ConfigurarPaginaDados()
                        THIS.TornarControlesVisiveis(THIS)
                        THIS.AjustarBotoesVisibilidade()
                        THIS.CarregarGrid()
                        THIS.RegistrarBINDEVENTs()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro ao inicializar FormSigPrCar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *-- Container escuro no topo com labels sombra+titulo (cntSombra do legado).
    *-- Original: Top=0, Left=0, Width=800, Height=80 -> adaptado para Width=THIS.Width
    *===========================================================================
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

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 25
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(0, 0, 0)
                .Caption   = "Caracter" + CHR(237) + "sticas do Produto"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 24
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "Caracter" + CHR(237) + "sticas do Produto"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *-- Torna visiveis todos os controles criados por AddObject (Visible=.F. default).
    *===========================================================================
        LOCAL loc_i, loc_oControl

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

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *-- Convencao arquitetural: agrupa a "lista de acoes" do sub-form (Shape1 +
    *-- cmdInserir/cmdExcluir/cmdSair), botoes que operam sobre o conjunto de
    *-- caracteristicas. Chamado por InicializarForm ANTES de ConfigurarPaginaDados.
    *===========================================================================
        THIS.ConfigurarBotoes()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *-- Convencao arquitetural: agrupa a "area de dados" do sub-form. Neste
    *-- OPERACIONAL o unico elemento de entrada de dados eh o Grid de
    *-- caracteristicas (grd_4c_Grade + cursor_4c_CaracProd). Chamado por
    *-- InicializarForm APOS ConfigurarPaginaLista para garantir z-order correto
    *-- (grid renderiza abaixo dos botoes).
    *===========================================================================
        THIS.ConfigurarGrade()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
    *-- Cria Shape decorativo e botoes de acao do sub-form (Shape1 + cmdInserir/Excluir/Sair).
    *-- Visibilidade por modo (INSERIR/ALTERAR vs CONSULTAR) gerenciada em AjustarBotoesVisibilidade (Fase 5).
    *===========================================================================
        *-- Shape decorativo por tras dos botoes (Shape1 do legado: Top=-3, Left=239, W=250, H=38)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = -3
            .Left        = 239
            .Width       = 250
            .Height      = 38
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- cmd_4c_Inserir (cmdInserir do legado - Left=255, TabIndex=1)
        THIS.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH THIS.cmd_4c_Inserir
            .Top             = 3
            .Left            = 255
            .Width           = 70
            .Height          = 70
            .Caption         = "Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
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
            .TabIndex        = 1
            .Visible         = .T.
        ENDWITH

        *-- cmd_4c_Excluir (cmdExcluir do legado - Left=330, TabIndex=2)
        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top             = 3
            .Left            = 330
            .Width           = 70
            .Height          = 70
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
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
            .TabIndex        = 2
            .Visible         = .T.
        ENDWITH

        *-- cmd_4c_Sair/Encerrar (cmdSair do legado - Left=405, Cancel=.T., TabIndex=3)
        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top             = 3
            .Left            = 405
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
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
            .TabIndex        = 3
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
    *-- Cria cursor placeholder e grid de caracteristicas do produto.
    *-- Grade (legado): Top=103, Left=8, Width=463, Height=411, 2 colunas.
    *-- Dados carregados por CarregarGrid na Fase 5 (SQLEXEC SigPrCar por CPros).
    *===========================================================================
        LOCAL loc_oGrade

        *-- Cursor placeholder com estrutura de SigPrCar (dados carregados na Fase 5)
        IF USED(THIS.this_cCursorCarac)
            USE IN (THIS.this_cCursorCarac)
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_CaracProd ;
            (CPros C(15) NULL, Codigos C(20) NULL, Descrs C(50) NULL, pkChaves C(38) NULL)
        SET NULL OFF

        THIS.AddObject("grd_4c_Grade", "Grid")
        loc_oGrade = THIS.grd_4c_Grade

        loc_oGrade.ColumnCount  = 2

        WITH loc_oGrade
            .Top                = 103
            .Left               = 8
            .Width              = 463
            .Height             = 411
            .FontName           = "Tahoma"
            .FontSize           = 8
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 17
            .ScrollBars         = 2
            .GridLineColor      = RGB(238, 238, 238)
            .AllowCellSelection = .T.

            *-- Coluna 1: Codigos (Caracteristica)
            WITH .Column1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Width         = 150
                .Movable       = .F.
                .Resizable     = .F.
                .ControlSource = THIS.this_cCursorCarac + ".Codigos"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Caracter" + CHR(237) + "stica"
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
            ENDWITH

            *-- Coluna 2: Descrs (Descricao)
            WITH .Column2
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Width         = 290
                .Movable       = .F.
                .Resizable     = .F.
                .ControlSource = THIS.this_cCursorCarac + ".Descrs"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
            ENDWITH
        ENDWITH

        loc_oGrade.RecordSource = THIS.this_cCursorCarac
    ENDPROC

    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    *-- OPERACIONAL sem PageFrame - nao alterna paginas.
    *===========================================================================
        RETURN .T.
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE CarregarGrid()
    *-- Carrega sigprcar filtrado por CPros no cursor local via cursor temporario.
    *===========================================================================
        LOCAL loc_cSQL, loc_oErro, loc_lResultado

        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_CaracProdTemp")
                USE IN cursor_4c_CaracProdTemp
            ENDIF

            loc_cSQL = "SELECT cpros, codigos, descrs, pkchaves " + ;
                       "FROM sigprcar " + ;
                       "WHERE cpros = " + EscaparSQL(THIS.this_cCpros) + " " + ;
                       "ORDER BY codigos"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CaracProdTemp") > 0
                SELECT (THIS.this_cCursorCarac)
                ZAP
                APPEND FROM DBF("cursor_4c_CaracProdTemp")
                USE IN cursor_4c_CaracProdTemp
                SELECT (THIS.this_cCursorCarac)
                GO TOP
            ENDIF

            THIS.grd_4c_Grade.ColumnCount  = 2
            THIS.grd_4c_Grade.RecordSource = THIS.this_cCursorCarac
            WITH THIS.grd_4c_Grade
                .Column1.ControlSource   = THIS.this_cCursorCarac + ".Codigos"
                .Column2.ControlSource   = THIS.this_cCursorCarac + ".Descrs"
                .Column1.Header1.Caption = "Caracter" + CHR(237) + "stica"
                .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH

            THIS.grd_4c_Grade.Refresh()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro CarregarGrid")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesVisibilidade()
    *-- Exibe/oculta Inserir+Excluir conforme modo (INSERIR/ALTERAR vs CONSULTAR).
    *-- Em CONSULTAR: grid ReadOnly=.T. replica When=.F. do legado (celulas nao editaveis).
    *===========================================================================
        LOCAL loc_lVis

        loc_lVis = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

        THIS.cmd_4c_Inserir.Visible = loc_lVis
        THIS.cmd_4c_Inserir.Enabled = loc_lVis
        THIS.cmd_4c_Excluir.Visible = loc_lVis
        THIS.cmd_4c_Excluir.Enabled = loc_lVis

        THIS.grd_4c_Grade.ReadOnly = !loc_lVis

        IF !loc_lVis
            THIS.shp_4c_Shape1.Width = THIS.cmd_4c_Sair.Width + 10
            THIS.shp_4c_Shape1.Left  = THIS.cmd_4c_Sair.Left  - 5
        ENDIF
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE RegistrarBINDEVENTs()
    *-- Vincula eventos dos botoes e celulas do grid aos handlers PUBLIC.
    *===========================================================================
        BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")
        BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
        BINDEVENT(THIS.cmd_4c_Sair,    "Click", THIS, "CmdSairClick")
        BINDEVENT(THIS.grd_4c_Grade.Column1.Text1, "KeyPress", THIS, "GrdCol1KeyPress")
        BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "KeyPress", THIS, "GrdCol2KeyPress")
    ENDPROC

    *===========================================================================
    PROCEDURE CmdInserirClick()
    *-- Insere nova linha vazia no cursor para adicionar uma caracteristica.
    *===========================================================================
        THIS.this_lHouveIncl = .T.

        IF THIS.this_oBusinessObject.InserirNovaLinha(THIS.this_cCursorCarac, THIS.this_cCpros)
            SELECT (THIS.this_cCursorCarac)
            GO BOTTOM
            THIS.grd_4c_Grade.Refresh()
            THIS.grd_4c_Grade.Column1.SetFocus()
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE CmdExcluirClick()
    *-- Remove o registro corrente do cursor (com verificacao de CPros de seguranca).
    *===========================================================================
        IF THIS.this_oBusinessObject.ExcluirLinhaAtual(THIS.this_cCursorCarac, THIS.this_cCpros)
            THIS.this_lHouveExcl = .T.
            THIS.grd_4c_Grade.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE CmdSairClick()
    *-- Limpa linhas vazias (modo edicao), reabilita form pai e fecha sub-form.
    *===========================================================================
        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            THIS.this_oBusinessObject.LimparLinhasVazias(THIS.this_cCursorCarac)
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnIncluirClick()
    *-- Bridge CRUD -> semantica OPERACIONAL sub-form: troca modo para INSERIR,
    *-- reconfigura visibilidade dos botoes (Inserir/Excluir enabled) e insere
    *-- linha vazia no grid delegando para CmdInserirClick.
    *===========================================================================
        THIS.this_cPcEscolha = "INSERIR"
        THIS.AjustarBotoesVisibilidade()
        THIS.CmdInserirClick()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnAlterarClick()
    *-- Bridge CRUD -> semantica OPERACIONAL sub-form: troca modo para ALTERAR,
    *-- libera edicao do grid (ReadOnly=.F., Inserir/Excluir enabled) e posiciona
    *-- foco na Column1 (Codigos) do registro corrente para edicao.
    *===========================================================================
        LOCAL loc_oErro

        THIS.this_cPcEscolha = "ALTERAR"
        THIS.AjustarBotoesVisibilidade()

        IF USED(THIS.this_cCursorCarac)
            SELECT (THIS.this_cCursorCarac)
            IF RECCOUNT() = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                         " caracter" + CHR(237) + "sticas cadastradas para este produto." + ;
                         CHR(13) + "Utilize o bot" + CHR(227) + "o Inserir para adicionar.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF EOF()
                GO TOP
            ENDIF
        ENDIF

        TRY
            THIS.grd_4c_Grade.Refresh()
            THIS.grd_4c_Grade.SetFocus()
            THIS.grd_4c_Grade.ActivateCell(RECNO(THIS.this_cCursorCarac), 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    PROCEDURE BtnVisualizarClick()
    *-- Bridge CRUD -> semantica OPERACIONAL sub-form: troca modo para CONSULTAR,
    *-- bloqueia edicao do grid (ReadOnly=.T.), oculta Inserir/Excluir e posiciona
    *-- cursor no primeiro registro para exibicao read-only.
    *===========================================================================
        THIS.this_cPcEscolha = "CONSULTAR"
        THIS.AjustarBotoesVisibilidade()

        IF USED(THIS.this_cCursorCarac)
            SELECT (THIS.this_cCursorCarac)
            IF RECCOUNT() > 0
                GO TOP
            ENDIF
        ENDIF

        THIS.grd_4c_Grade.Refresh()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnExcluirClick()
    *-- Bridge CRUD -> semantica OPERACIONAL sub-form: valida modo editavel, pede
    *-- confirmacao e delega para CmdExcluirClick que remove a linha corrente.
    *===========================================================================
        IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            MsgAviso("Exclus" + CHR(227) + "o dispon" + CHR(237) + ;
                     "vel apenas em modo Inserir ou Alterar.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF !USED(THIS.this_cCursorCarac) OR RECCOUNT(THIS.this_cCursorCarac) = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                     " caracter" + CHR(237) + "stica selecionada para excluir.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da caracter" + ;
                       CHR(237) + "stica selecionada?", ;
                       "Confirma" + CHR(231) + CHR(227) + "o")
            THIS.CmdExcluirClick()
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE GrdCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *-- Handler KeyPress na coluna Codigos: dispara validacao em ENTER/TAB/F4.
    *===========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        THIS.ValidarCodigo()
    ENDPROC

    *===========================================================================
    PROCEDURE GrdCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *-- Handler KeyPress na coluna Descrs: valida somente se Column1 estiver vazio.
    *===========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.grd_4c_Grade.Column1.Text1.Value))
            RETURN
        ENDIF

        THIS.ValidarDescricao()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ValidarCodigo()
    *-- Valida codigo digitado em Column1 contra SIGCRRAP. Abre picker se nao encontrado.
    *===========================================================================
        LOCAL loc_cValor, loc_cPkAtual, loc_lEncontrado, loc_oErro
        LOCAL loc_cCodFinal, loc_cDescFinal

        TRY
            loc_cValor   = ALLTRIM(THIS.grd_4c_Grade.Column1.Text1.Value)
            loc_cPkAtual = ""

            IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                SELECT (THIS.this_cCursorCarac)
                loc_cPkAtual = ALLTRIM(pkchaves)
            ENDIF

            IF EMPTY(loc_cValor)
                IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                    SELECT (THIS.this_cCursorCarac)
                    REPLACE codigos WITH "", descrs WITH ""
                ENDIF
            ELSE
                loc_lEncontrado = THIS.this_oBusinessObject.BuscarCodigoExato(;
                    loc_cValor, THIS.this_cCgrus, "cursor_4c_PrCarBusca")

                IF !loc_lEncontrado
                    THIS.AbrirPickerCodigo(loc_cValor)
                ELSE
                    SELECT cursor_4c_PrCarBusca
                    loc_cCodFinal  = ALLTRIM(codigos)
                    loc_cDescFinal = ALLTRIM(descrs)
                    USE IN cursor_4c_PrCarBusca

                    IF THIS.this_oBusinessObject.VerificarDuplicidade(;
                        loc_cCodFinal, loc_cPkAtual, THIS.this_cCursorCarac)
                        MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
                                 " informada para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH "", descrs WITH ""
                        ENDIF
                    ELSE
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH loc_cCodFinal, descrs WITH loc_cDescFinal
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ValidarCodigo")
        ENDTRY

        THIS.grd_4c_Grade.Refresh()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ValidarDescricao()
    *-- Valida descricao digitada em Column2 contra SIGCRRAP. Abre picker se nao encontrado.
    *===========================================================================
        LOCAL loc_cValor, loc_cPkAtual, loc_lEncontrado, loc_oErro
        LOCAL loc_cCodFinal, loc_cDescFinal

        TRY
            loc_cValor   = ALLTRIM(THIS.grd_4c_Grade.Column2.Text1.Value)
            loc_cPkAtual = ""

            IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                SELECT (THIS.this_cCursorCarac)
                loc_cPkAtual = ALLTRIM(pkchaves)
            ENDIF

            IF EMPTY(loc_cValor)
                IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                    SELECT (THIS.this_cCursorCarac)
                    REPLACE codigos WITH "", descrs WITH ""
                ENDIF
            ELSE
                loc_lEncontrado = THIS.this_oBusinessObject.BuscarDescricaoExata(;
                    loc_cValor, THIS.this_cCgrus, "cursor_4c_PrCarBusca")

                IF !loc_lEncontrado
                    THIS.AbrirPickerDescricao(loc_cValor)
                ELSE
                    SELECT cursor_4c_PrCarBusca
                    loc_cCodFinal  = ALLTRIM(codigos)
                    loc_cDescFinal = ALLTRIM(descrs)
                    USE IN cursor_4c_PrCarBusca

                    IF THIS.this_oBusinessObject.VerificarDuplicidade(;
                        loc_cCodFinal, loc_cPkAtual, THIS.this_cCursorCarac)
                        MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
                                 " informada para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH "", descrs WITH ""
                        ENDIF
                    ELSE
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH loc_cCodFinal, descrs WITH loc_cDescFinal
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ValidarDescricao")
        ENDTRY

        THIS.grd_4c_Grade.Refresh()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE AbrirPickerCodigo(par_cValor)
    *-- FormBuscaAuxiliar buscando SIGCRRAP.codigos filtrado por grupo do produto.
    *===========================================================================
        LOCAL loc_oPicker, loc_cFiltro, loc_oErro
        LOCAL loc_cCodSel, loc_cDescSel, loc_cPkAtual, loc_lDuplicado

        TRY
            loc_cFiltro = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ", '   ')"

            loc_oPicker = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, ;
                "SIGCRRAP", ;
                "cursor_4c_PrCarPicker", ;
                "codigos", ;
                par_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", ;
                .F., ;
                .T., ;
                loc_cFiltro)

            IF VARTYPE(loc_oPicker) = "O"
                loc_oPicker.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oPicker.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oPicker.Show()

                IF loc_oPicker.this_lSelecionou AND USED("cursor_4c_PrCarPicker")
                    SELECT cursor_4c_PrCarPicker
                    loc_cCodSel  = ALLTRIM(codigos)
                    loc_cDescSel = ALLTRIM(descrs)

                    loc_cPkAtual = ""
                    IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                        SELECT (THIS.this_cCursorCarac)
                        loc_cPkAtual = ALLTRIM(pkchaves)
                    ENDIF

                    loc_lDuplicado = THIS.this_oBusinessObject.VerificarDuplicidade(;
                        loc_cCodSel, loc_cPkAtual, THIS.this_cCursorCarac)

                    IF loc_lDuplicado
                        MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
                                 " informada para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH "", descrs WITH ""
                        ENDIF
                    ELSE
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH loc_cCodSel, descrs WITH loc_cDescSel
                        ENDIF
                    ENDIF
                ELSE
                    IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                        SELECT (THIS.this_cCursorCarac)
                        REPLACE codigos WITH "", descrs WITH ""
                    ENDIF
                ENDIF

                loc_oPicker = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro AbrirPickerCodigo")
        ENDTRY

        IF USED("cursor_4c_PrCarPicker")
            USE IN cursor_4c_PrCarPicker
        ENDIF

        THIS.grd_4c_Grade.Refresh()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE AbrirPickerDescricao(par_cValor)
    *-- FormBuscaAuxiliar buscando SIGCRRAP.descrs filtrado por grupo do produto.
    *===========================================================================
        LOCAL loc_oPicker, loc_cFiltro, loc_oErro
        LOCAL loc_cCodSel, loc_cDescSel, loc_cPkAtual, loc_lDuplicado

        TRY
            loc_cFiltro = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ", '   ')"

            loc_oPicker = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, ;
                "SIGCRRAP", ;
                "cursor_4c_PrCarPicker", ;
                "descrs", ;
                par_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", ;
                .F., ;
                .T., ;
                loc_cFiltro)

            IF VARTYPE(loc_oPicker) = "O"
                loc_oPicker.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oPicker.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oPicker.Show()

                IF loc_oPicker.this_lSelecionou AND USED("cursor_4c_PrCarPicker")
                    SELECT cursor_4c_PrCarPicker
                    loc_cCodSel  = ALLTRIM(codigos)
                    loc_cDescSel = ALLTRIM(descrs)

                    loc_cPkAtual = ""
                    IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                        SELECT (THIS.this_cCursorCarac)
                        loc_cPkAtual = ALLTRIM(pkchaves)
                    ENDIF

                    loc_lDuplicado = THIS.this_oBusinessObject.VerificarDuplicidade(;
                        loc_cCodSel, loc_cPkAtual, THIS.this_cCursorCarac)

                    IF loc_lDuplicado
                        MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
                                 " informada para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH "", descrs WITH ""
                        ENDIF
                    ELSE
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH loc_cCodSel, descrs WITH loc_cDescSel
                        ENDIF
                    ENDIF
                ELSE
                    IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                        SELECT (THIS.this_cCursorCarac)
                        REPLACE codigos WITH "", descrs WITH ""
                    ENDIF
                ENDIF

                loc_oPicker = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro AbrirPickerDescricao")
        ENDTRY

        IF USED("cursor_4c_PrCarPicker")
            USE IN cursor_4c_PrCarPicker
        ENDIF

        THIS.grd_4c_Grade.Refresh()
    ENDPROC

    *===========================================================================
    PROCEDURE CarregarLista()
    *-- Delega ao CarregarGrid (padrao FormBase -> forms OPERACIONAIS).
    *===========================================================================
        RETURN THIS.CarregarGrid()
    ENDPROC

    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
    *-- Delega ao AjustarBotoesVisibilidade (padrao FormBase -> forms OPERACIONAIS).
    *===========================================================================
        THIS.AjustarBotoesVisibilidade()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *-- Copia dados da linha corrente do cursor para o Business Object.
    *===========================================================================
        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
            SELECT (THIS.this_cCursorCarac)
            THIS.this_oBusinessObject.this_cCodigos  = ALLTRIM(NVL(codigos,  ""))
            THIS.this_oBusinessObject.this_cCpros    = ALLTRIM(NVL(cpros,    ""))
            THIS.this_oBusinessObject.this_cPkChaves = ALLTRIM(NVL(pkchaves, ""))
            IF TYPE("descrs") != "U"
                THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(NVL(descrs, ""))
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *-- Copia dados do Business Object para a linha corrente do cursor.
    *===========================================================================
        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
            SELECT (THIS.this_cCursorCarac)
            REPLACE codigos  WITH THIS.this_oBusinessObject.this_cCodigos, ;
                    descrs   WITH THIS.this_oBusinessObject.this_cDescrs,   ;
                    cpros    WITH THIS.this_oBusinessObject.this_cCpros,    ;
                    pkchaves WITH THIS.this_oBusinessObject.this_cPkChaves
        ENDIF
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *-- Habilita/desabilita edicao do grid conforme modo de operacao.
    *===========================================================================
        IF VARTYPE(THIS.grd_4c_Grade) = "O"
            THIS.grd_4c_Grade.ReadOnly = !par_lHabilitar
        ENDIF
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
    *-- Limpa campos da linha corrente do cursor (codigos e descrs).
    *===========================================================================
        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
            SELECT (THIS.this_cCursorCarac)
            REPLACE codigos WITH "", descrs WITH ""
        ENDIF
        IF VARTYPE(THIS.grd_4c_Grade) = "O"
            THIS.grd_4c_Grade.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE BtnBuscarClick()
    *-- Recarrega o grid com os dados atuais do produto (sem filtro adicional).
    *===========================================================================
        THIS.CarregarGrid()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnEncerrarClick()
    *-- Delega ao CmdSairClick: limpa vazios, reabilita pai, fecha sub-form.
    *===========================================================================
        THIS.CmdSairClick()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnSalvarClick()
    *-- Persiste todas as caracteristicas no SQL Server e fecha o sub-form.
    *-- Estrategia: LimparLinhasVazias + SalvarTodasCaracteristicas + Release.
    *===========================================================================
        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            THIS.this_oBusinessObject.LimparLinhasVazias(THIS.this_cCursorCarac)
            THIS.this_oBusinessObject.SalvarTodasCaracteristicas(;
                THIS.this_cCursorCarac, THIS.this_cCpros)
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnCancelarClick()
    *-- Cancela edicao sem persistir: reabilita form pai e fecha sub-form.
    *-- O original nao tem cancelar explicito - dados do cursor sao descartados.
    *===========================================================================
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *===========================================================================
    PROCEDURE Destroy()
    *-- Libera cursor de trabalho e Business Object ao fechar o sub-form.
    *===========================================================================
        IF USED(THIS.this_cCursorCarac)
            USE IN (THIS.this_cCursorCarac)
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
