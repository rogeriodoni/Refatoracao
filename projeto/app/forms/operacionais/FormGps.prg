*==============================================================================
* FormGps.prg - Formulario de Grupos de Produtos (Sub-nivel)
* Form OPERACIONAL (dialogo modal) - Edita grupos vinculados a uma operacao SigCdOpe
* Tabelas: SigCdGgp (tipoggp=.T.) / SigCdGps (tipoggp=.F.) + SigCdGrp
* Fase 7/8 - Eventos principais: CmdInserirClick, CmdExcluirClick, CmdConfirmarClick, CmdCancelarClick
*==============================================================================

DEFINE CLASS FormGps AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (espelho do legado SIGCDGPS)
    *--------------------------------------------------------------------------
    Width           = 800
    Height          = 461
    AutoCenter      = .T.
    TitleBar        = 0
    ShowWindow = 0
    WindowType = 0
    ShowWindow = 1
    ControlBox      = .F.
    Movable         = .F.
    ClipControls    = .F.
    BorderStyle     = 2
    DataSession     = 2

    *--------------------------------------------------------------------------
    * Propriedades da instancia
    *--------------------------------------------------------------------------

    *-- Referencia ao form pai (para re-habilitar ao fechar)
    this_oParentForm    = .NULL.

    *-- Flag: houve alteracao de dados no grid
    this_lGravaDados    = .F.

    *-- Tipo: .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    this_lTipoggp       = .F.

    *-- Modo de edicao recebido do pai: 'INSERIR', 'ALTERAR', etc.
    this_cEscolha       = ""

    *-- Dopes da operacao (SigCdOpe.Dopes) passado pelo form pai
    this_cDopes         = ""

    *-- Valor anterior da celula do grid (antvalue do legado)
    this_cAntValue      = ""

    *--------------------------------------------------------------------------
    * Init - Recebe parametros do form pai e inicia
    * par_oParentForm : referencia ao form que abriu este dialog
    * par_cDopes      : Dopes da operacao (SigCdOpe.Dopes)
    * par_lTipoggp    : .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    * par_cEscolha    : modo ('INSERIR', 'ALTERAR', ...)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_cDopes, par_lTipoggp, par_cEscolha)
        *-- Armazenar parametros ANTES de DODEFAULT() (que chama InicializarForm)
        *-- IIF(VARTYPE=) protege contra parametros nao passados (default VFP9 = .F. logico)
        THIS.this_oParentForm   = IIF(VARTYPE(par_oParentForm) = "O", par_oParentForm, .NULL.)
        THIS.this_cDopes        = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")
        THIS.this_lTipoggp      = IIF(VARTYPE(par_lTipoggp) = "L", par_lTipoggp, .F.)
        THIS.this_cEscolha      = IIF(VARTYPE(par_cEscolha) = "C", ALLTRIM(par_cEscolha), "")

        *-- Desabilitar form pai enquanto dialogo estiver aberto
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .F.
        ENDIF

        *-- Criar BO antes de InicializarForm (usa this_oBusinessObject)
        THIS.this_oBusinessObject = CREATEOBJECT("GpsBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar GpsBO.", "Erro em Init")
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria todos os controles do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- DataSession=2: restaurar configuracoes de data/locale (CLAUDE.md #9.4)
            SET DATE TO BRITISH
            SET CENTURY ON

            *-- Monta layout do dialogo (form-level + containers + grid + botoes)
            THIS.ConfigurarPageFrame()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Carrega grupos ja vinculados a operacao no cursor de trabalho
            THIS.CarregarDados()

            *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestra layout do dialogo flat (sem PageFrame
    * explicito, pois SIGCDGPS eh dialogo modal de pagina unica).
    * Define propriedades visuais do form e adiciona os 3 blocos de controles:
    * cabecalho (cnt_4c_Cabecalho), grade de grupos (grd_4c_Dados) e botoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Imagem de fundo
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        *-- Caption dinamico baseado na operacao (Dopes vindo do form pai)
        THIS.Caption = "Grupos de Produtos " + ALLTRIM(THIS.this_cDopes)

        *-- Bloco superior escuro com titulo
        THIS.ConfigurarCabecalho()

        *-- Grade de edicao dos grupos (unico bloco de dados do dialogo)
        THIS.ConfigurarPaginaLista()

        *-- Propriedades adicionais dos Text1 do grid + handler When
        THIS.ConfigurarPaginaDados()

        *-- Barra de acoes: Inserir / Excluir / Confirmar / Cancelar
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container header escuro com titulo da operacao
    * Original: cntSombra Top=-2, Left=0, Width=800, Height=80
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BackStyle  = 1
            .BackColor  = RGB(100,100,100)
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top        = 18
            .Left       = 10
            .Width      = 769
            .Height     = 40
            .AutoSize   = .F.
            .BackStyle  = 0
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .ForeColor  = RGB(0,0,0)
            .WordWrap   = .T.
            .Alignment  = 0
            .Caption    = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top        = 17
            .Left       = 10
            .Width      = 769
            .Height     = 46
            .AutoSize   = .F.
            .BackStyle  = 0
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .ForeColor  = RGB(255,255,255)
            .WordWrap   = .T.
            .Alignment  = 0
            .Caption    = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Grid de grupos (GradeOpe no legado)
    * Original: Top=87, Left=236, Width=264, Height=364, ColumnCount=2
    * Column1: Cgrus (char 3), Width=50 - EDITAVEL com lookup F4
    * Column2: Dgrus (char 20), Width=180 - SOMENTE LEITURA (When=.F. no legado)
    * Nota: form plano sem PageFrame - equivale a Page1 do padrao CRUD
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oGrid

        *-- Criar cursor de trabalho local (xOpe no legado)
        *-- Campos: Dopes c(20), Cgrus c(3) conforme SigCdGrp, Dgrus c(20) conforme schema
        SET NULL ON
        IF USED("cursor_4c_Operacao")
            USE IN cursor_4c_Operacao
        ENDIF
        CREATE CURSOR cursor_4c_Operacao (Dopes C(20), Cgrus C(3), Dgrus C(20))
        SET NULL OFF
        INDEX ON Cgrus TAG Cgrus
        SET ORDER TO

        *-- Criar grid
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top            = 87
            .Left           = 236
            .Width          = 264
            .Height         = 364
            .ColumnCount    = 2
            .FontName       = "Tahoma"
            .DeleteMark     = .F.
            .RecordMark     = .F.
            .ScrollBars     = 2
            .GridLineColor  = RGB(238,238,238)
            .HighlightStyle = 2
            .TabIndex       = 1
        ENDWITH

        WITH loc_oGrid.Column1
            .FontName   = "Tahoma"
            .Width      = 50
            .Movable    = .F.
            .Resizable  = .F.
            .BackColor  = RGB(255,255,255)
            WITH .Header1
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Alignment  = 2
                .Caption    = "Grupo"
                .ForeColor  = RGB(36,84,155)
            ENDWITH
        ENDWITH

        WITH loc_oGrid.Column2
            .FontName   = "Tahoma"
            .Width      = 180
            .Movable    = .F.
            .Resizable  = .F.
            .ReadOnly   = .T.
            WITH .Header1
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Alignment  = 2
                .Caption    = "Descri" + CHR(231) + CHR(227) + "o"
                .ForeColor  = RGB(36,84,155)
            ENDWITH
        ENDWITH

        *-- Vincular grid ao cursor
        loc_oGrid.ColumnCount = 2
        loc_oGrid.RecordSource          = "cursor_4c_Operacao"
        loc_oGrid.Column1.ControlSource = "cursor_4c_Operacao.Cgrus"
        loc_oGrid.Column2.ControlSource = "cursor_4c_Operacao.Dgrus"

        *-- Reconfigurar headers apos RecordSource (VFP reseta headers)
        WITH loc_oGrid.Column1.Header1
            .Caption = "Grupo"
        ENDWITH
        WITH loc_oGrid.Column2.Header1
            .Caption = "Descri" + CHR(231) + CHR(227) + "o"
        ENDWITH

        *-- Bindar KeyPress da Column1 para lookup de Cgrus
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdDadosCol1KeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura propriedades visuais dos Text1 do grid
    * e registra o handler When da Column1 para captura do valor anterior.
    * Legado: Text1.When salva AntValue; Text1.BorderStyle=0; Margin=0
    * Neste form OPERACIONAL sem Page2, esta fase complementa a configuracao
    * dos controles de entrada de dados (os Text1 das colunas do grid).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oGrid, loc_oErro
        TRY
            loc_oGrid = THIS.grd_4c_Dados

            *-- Text1 da Column1 (Cgrus - editavel)
            WITH loc_oGrid.Column1.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0,0,0)
                .BackColor   = RGB(255,255,255)
            ENDWITH

            *-- Text1 da Column2 (Dgrus - somente leitura)
            WITH loc_oGrid.Column2.Text1
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0,0,0)
                .BackColor   = RGB(240,240,240)
            ENDWITH

            *-- Registrar When da Column1.Text1 para salvar AntValue antes de editar
            BINDEVENT(loc_oGrid.Column1.Text1, "When", THIS, "GrdDadosCol1When")

            *-- Registrar When da Column2.Text1 para bloquear edicao (legado: Return .f.)
            BINDEVENT(loc_oGrid.Column2.Text1, "When", THIS, "GrdDadosCol2When")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navegacao entre estados do dialogo
    * Form plano sem PageFrame: apenas atualiza o grid (sem alternancia real de paginas)
    * Mantem assinatura padrao do pipeline multi-fase para compatibilidade
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.grd_4c_Dados) = "O" AND THIS.Visible
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - 4 botoes da barra superior
    * Original: cmdInserir(500), cmdExcluir(575), cmdSair/Confirmar(650), Cancela(725)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_lPermiteEdicao
        loc_lPermiteEdicao = INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")

        *-- Inserir (Tab=4)
        THIS.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH THIS.cmd_4c_Inserir
            .Top            = 2
            .Left           = 500
            .Width          = 75
            .Height         = 75
            .Caption        = "\<Inserir"
            .Picture        = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .FontName       = "Tahoma"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontSize       = 8
            .ForeColor      = RGB(90,90,90)
            .BackColor      = RGB(255,255,255)
            .Themes         = .T.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .AutoSize       = .F.
            .Enabled        = loc_lPermiteEdicao
            .TabIndex       = 4
        ENDWITH

        *-- Excluir (Tab=2)
        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top            = 2
            .Left = 230
            .Width          = 75
            .Height         = 75
            .Caption        = "\<Excluir"
            .Picture        = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .FontName       = "Tahoma"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontSize       = 8
            .ForeColor      = RGB(90,90,90)
            .BackColor      = RGB(255,255,255)
            .Themes         = .T.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .AutoSize       = .F.
            .Enabled        = loc_lPermiteEdicao
            .TabIndex       = 2
        ENDWITH

        *-- Confirmar / cmdSair no legado (Tab=7)
        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top            = 2
            .Left           = 650
            .Width          = 75
            .Height         = 75
            .Caption        = "\<Confirmar"
            .Picture        = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName       = "Tahoma"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontSize       = 8
            .ForeColor      = RGB(90,90,90)
            .BackColor      = RGB(255,255,255)
            .Themes         = .T.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .AutoSize       = .F.
            .TabIndex       = 7
        ENDWITH

        *-- Cancelar / Cancela no legado (Tab=8, Cancel=.T.)
        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top            = 2
            .Left           = 725
            .Width          = 75
            .Height         = 75
            .Caption        = "Encerrar"
            .Picture        = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .FontName       = "Tahoma"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontSize       = 8
            .ForeColor      = RGB(90,90,90)
            .BackColor      = RGB(255,255,255)
            .Themes         = .T.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .AutoSize       = .F.
            .Cancel         = .T.
            .TabIndex       = 8
        ENDWITH

        *-- Bindar eventos dos botoes
        BINDEVENT(THIS.cmd_4c_Inserir,   "Click", THIS, "CmdInserirClick")
        BINDEVENT(THIS.cmd_4c_Excluir,   "Click", THIS, "CmdExcluirClick")
        BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "CmdConfirmarClick")
        BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega grupos do SQL Server no cursor de trabalho
    * Equivale ao SQLEXEC + Scan/Append Blank/Gather do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_oErro
        TRY
            IF !EMPTY(THIS.this_cDopes) AND THIS.this_oBusinessObject.CarregarGrupos(THIS.this_cDopes, THIS.this_lTipoggp)
                IF USED("cursor_4c_GruposTemp")
                    SELECT cursor_4c_Operacao
                    ZAP
                    APPEND FROM DBF("cursor_4c_GruposTemp")
                    USE IN cursor_4c_GruposTemp
                ENDIF
            ENDIF

            IF USED("cursor_4c_Operacao")
                SELECT cursor_4c_Operacao
                SET ORDER TO
                GO TOP
            ENDIF

            IF VARTYPE(THIS.grd_4c_Dados) = "O" AND THIS.Visible
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
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

    *==========================================================================
    * HANDLERS DOS BOTOES
    *==========================================================================

    *--------------------------------------------------------------------------
    * CmdInserirClick - Insere linha em branco no grid
    * Original: Insert Into xOpe (Cgrus) Values (Space(20))
    *--------------------------------------------------------------------------
    PROCEDURE CmdInserirClick()
        LOCAL loc_oErro
        TRY
            SELECT cursor_4c_Operacao
            INSERT INTO cursor_4c_Operacao (Dopes, Cgrus, Dgrus) VALUES ;
                (THIS.this_cDopes, SPACE(3), SPACE(20))
            THIS.this_lGravaDados = .T.
            THIS.grd_4c_Dados.Column1.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdInserirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExcluirClick - Exclui linha corrente do grid
    * Original: Delete + Skip, Go Bott se EOF()
    *--------------------------------------------------------------------------
    PROCEDURE CmdExcluirClick()
        LOCAL loc_oErro
        TRY
            SELECT cursor_4c_Operacao
            IF !EOF()
                DELETE
                SKIP
                IF EOF()
                    GO BOTTOM
                ENDIF
            ENDIF
            THIS.this_lGravaDados = .T.
            THIS.grd_4c_Dados.SetFocus()
            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdConfirmarClick - Valida e salva grupos no SQL Server
    * Original: cmdSair.Click - valida duplicidade, DELETE+INSERT em transacao
    *--------------------------------------------------------------------------
    PROCEDURE CmdConfirmarClick()
        LOCAL loc_lSucesso, loc_lPodeFechar, loc_oErro
        loc_lSucesso    = .F.
        loc_lPodeFechar = .T.
        TRY
            IF THIS.this_lGravaDados
                *-- Validar duplicidade de Cgrus no cursor
                IF !THIS.this_oBusinessObject.ValidarDuplicados("cursor_4c_Operacao")
                    loc_lPodeFechar = .F.
                ENDIF

                IF loc_lPodeFechar
                    *-- Salvar: DELETE todos existentes + INSERT novos em transacao
                    loc_lSucesso = THIS.this_oBusinessObject.SalvarGrupos( ;
                        THIS.this_cDopes, ;
                        THIS.this_lTipoggp, ;
                        "cursor_4c_Operacao" ;
                    )

                    IF !loc_lSucesso
                        MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados!!!", "Erro")
                        loc_lPodeFechar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lPodeFechar
                *-- Re-habilitar form pai e fechar
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .T.
                ENDIF
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdConfirmarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCancelarClick - Fecha sem salvar (Cancela no legado)
    *--------------------------------------------------------------------------
    PROCEDURE CmdCancelarClick()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS DA BARRA DE BOTOES (Btn*Click - padrao pipeline)
    * Este form OPERACIONAL nao tem Alterar/Visualizar semanticos no legado,
    * mas mantem-se os handlers Btn* para compatibilidade com o validador.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Insere nova linha em branco no grid
    * Legado: cmdInserir.Click -> Insert Into xOpe (Cgrus) Values (Space(20))
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
                MsgAviso("Modo somente leitura n" + CHR(227) + "o permite inclus" + CHR(227) + "o.", "Aviso")
                RETURN
            ENDIF

            IF !USED("cursor_4c_Operacao")
                MsgErro("Cursor de trabalho n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel.", "Erro em BtnIncluirClick")
                RETURN
            ENDIF

            SELECT cursor_4c_Operacao
            INSERT INTO cursor_4c_Operacao (Dopes, Cgrus, Dgrus) VALUES ;
                (THIS.this_cDopes, SPACE(3), SPACE(20))
            THIS.this_lGravaDados = .T.

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Coloca foco no grid para editar registro corrente
    * Legado: sem equivalente direto (dialogo ja abre em modo edicao).
    * Comportamento: valida modo, vai para o registro corrente e da foco na
    * Column1 (Cgrus) para permitir edicao / lookup.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
                MsgAviso("Modo somente leitura n" + CHR(227) + "o permite altera" + CHR(231) + CHR(227) + "o.", "Aviso")
                RETURN
            ENDIF

            IF !USED("cursor_4c_Operacao") OR RECCOUNT("cursor_4c_Operacao") = 0
                MsgAviso("Nenhum registro para alterar.", "Aviso")
                RETURN
            ENDIF

            SELECT cursor_4c_Operacao
            IF EOF()
                GO BOTTOM
            ENDIF

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Recarrega grupos do SQL Server no grid
    * Legado: sem equivalente direto. Aqui recarrega os dados da operacao
    * do banco para o cursor de trabalho (descarta edicoes nao confirmadas).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lConfirma, loc_oErro
        TRY
            IF EMPTY(THIS.this_cDopes)
                MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada para visualizar.", "Aviso")
                RETURN
            ENDIF

            IF THIS.this_lGravaDados
                loc_lConfirma = MsgConfirma("H" + CHR(225) + " altera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o gravadas. Recarregar mesmo assim?", "Confirma" + CHR(231) + CHR(227) + "o")
                IF !loc_lConfirma
                    RETURN
                ENDIF
            ENDIF

            *-- Recarrega dados do SQL Server no cursor de trabalho
            THIS.CarregarDados()
            THIS.this_lGravaDados = .F.

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro corrente do grid
    * Legado: cmdExcluir.Click -> Delete + Skip + Go Bott se EOF
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma, loc_oErro
        TRY
            IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
                MsgAviso("Modo somente leitura n" + CHR(227) + "o permite exclus" + CHR(227) + "o.", "Aviso")
                RETURN
            ENDIF

            IF !USED("cursor_4c_Operacao") OR RECCOUNT("cursor_4c_Operacao") = 0
                MsgAviso("Nenhum registro para excluir.", "Aviso")
                RETURN
            ENDIF

            SELECT cursor_4c_Operacao
            IF EOF()
                MsgAviso("Posicione em um registro para excluir.", "Aviso")
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo selecionado?", "Confirma" + CHR(231) + CHR(227) + "o")
            IF !loc_lConfirma
                RETURN
            ENDIF

            DELETE
            SKIP
            IF EOF()
                GO BOTTOM
            ENDIF
            THIS.this_lGravaDados = .T.

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLER DO GRID - Column1 (Cgrus) KeyPress com lookup F4/ENTER/TAB
    *==========================================================================

    *--------------------------------------------------------------------------
    * GrdDadosCol1When - Salva valor anterior antes de entrar na celula (Column1)
    * Original: PROCEDURE When / Thisform.AntValue = This.Value
    * Necessario para recuperacao de valor caso o lookup seja cancelado
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosCol1When()
        THIS.this_cAntValue = ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, ""))
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosCol1KeyPress - Lookup de Cgrus na coluna 1 do grid
    * Dispara em ENTER(13), TAB(9), F4(115)
    * Original: Text1.Valid no Column1 com fwbuscaext para SigCdGrp
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCgrus, loc_cSQL, loc_cDgrus, loc_oErro

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        TRY
            loc_cCgrus = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)

            IF !EMPTY(loc_cCgrus)
                *-- Busca exata em SigCdGrp
                loc_cDgrus = ""
                loc_cSQL = "SELECT TOP 1 dgrus FROM SigCdGrp WHERE RTRIM(cgrus) = " + ;
                           EscaparSQL(loc_cCgrus)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpBusca") > 0 AND ;
                   RECCOUNT("cursor_4c_GrpBusca") > 0
                    SELECT cursor_4c_GrpBusca
                    loc_cDgrus = ALLTRIM(dgrus)
                    USE IN cursor_4c_GrpBusca

                    *-- Atualizar Dgrus na linha corrente do cursor de trabalho
                    SELECT cursor_4c_Operacao
                    REPLACE Dgrus WITH loc_cDgrus
                    THIS.this_lGravaDados = .T.
                ELSE
                    IF USED("cursor_4c_GrpBusca")
                        USE IN cursor_4c_GrpBusca
                    ENDIF
                    *-- Nao encontrou: abrir picker (nao exibir aviso antes, conforme CLAUDE.md)
                    THIS.AbrirLookupGrupo(loc_cCgrus)
                ENDIF
            ELSE
                *-- Limpar descricao quando codigo em branco
                SELECT cursor_4c_Operacao
                REPLACE Cgrus WITH SPACE(3), Dgrus WITH SPACE(20)
                THIS.grd_4c_Dados.Column1.Text1.Value = ""
            ENDIF

            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em GrdDadosCol1KeyPress")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Abre FormBuscaAuxiliar para SigCdGrp
    * Original: fwbuscaext com Cgrus/Dgrus
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo(par_cValorInicial)
        LOCAL loc_oBusca, loc_oErro
        TRY
            IF USED("cursor_4c_GrpLookup")
                USE IN cursor_4c_GrpLookup
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, ;
                "SigCdGrp", ;
                "cursor_4c_GrpLookup", ;
                "cgrus", ;
                par_cValorInicial, ;
                "Grupo de Produto", ;
                .T., ;
                .T., ;
                "" ;
            )

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cgrus", "", "Grupo")
                loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF USED("cursor_4c_GrpLookup") AND RECCOUNT("cursor_4c_GrpLookup") > 0
                    SELECT cursor_4c_GrpLookup
                    LOCAL loc_cCgrusOk, loc_cDgrusOk
                    loc_cCgrusOk = ALLTRIM(cgrus)
                    loc_cDgrusOk = ALLTRIM(dgrus)
                    USE IN cursor_4c_GrpLookup

                    SELECT cursor_4c_Operacao
                    REPLACE Cgrus WITH loc_cCgrusOk, Dgrus WITH loc_cDgrusOk
                    THIS.grd_4c_Dados.Column1.Text1.Value = loc_cCgrusOk
                    THIS.this_lGravaDados = .T.
                ENDIF
            ENDIF

            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosCol2When - Bloqueia edicao da Column2 (Dgrus - somente leitura)
    * Original: Column2.Text1.When = Return .f.
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosCol2When()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * METODOS PADRAO DO PIPELINE (Fase 8/8 - Consolidacao)
    * Este form OPERACIONAL usa padroes adaptados ao dialogo modal:
    * dados residem em cursor_4c_Operacao, nao em campos individuais.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega lista de grupos do SQL Server no grid
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lConfirma, loc_oErro
        TRY
            IF THIS.this_lGravaDados
                loc_lConfirma = MsgConfirma("H" + CHR(225) + " altera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o gravadas. Recarregar mesmo assim?", "Confirma" + CHR(231) + CHR(227) + "o")
                IF !loc_lConfirma
                    RETURN
                ENDIF
            ENDIF
            THIS.CarregarDados()
            THIS.this_lGravaDados = .F.
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha dialogo sem salvar e re-habilita form pai
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e salva grupos (delega ao CmdConfirmarClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha sem salvar (delega ao CmdCancelarClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere estado do form para o BO
    * Dialogo modal: popula identificadores de contexto no BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cDopes      = THIS.this_cDopes
        THIS.this_oBusinessObject.this_lTipoggp    = THIS.this_lTipoggp
        THIS.this_oBusinessObject.this_cEscolha    = THIS.this_cEscolha
        THIS.this_oBusinessObject.this_lGravaDados = THIS.this_lGravaDados
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere propriedades do BO para o form
    * Dialogo modal: sincroniza flags de estado
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        THIS.this_cDopes      = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDopes, ""))
        THIS.this_lTipoggp    = THIS.this_oBusinessObject.this_lTipoggp
        THIS.this_cEscolha    = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cEscolha, ""))
        THIS.this_lGravaDados = THIS.this_oBusinessObject.this_lGravaDados
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita botoes de edicao conforme modo
    * par_lHabilitar: .T. habilita, .F. desabilita; sem param: usa this_cEscolha
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lPermiteEdicao
        IF VARTYPE(par_lHabilitar) = "L"
            loc_lPermiteEdicao = par_lHabilitar
        ELSE
            loc_lPermiteEdicao = INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Inserir) = "O"
            THIS.cmd_4c_Inserir.Enabled = loc_lPermiteEdicao
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Excluir) = "O"
            THIS.cmd_4c_Excluir.Enabled = loc_lPermiteEdicao
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera o cursor de trabalho (limpa grade de grupos)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF USED("cursor_4c_Operacao")
            SELECT cursor_4c_Operacao
            ZAP
            THIS.this_lGravaDados = .T.
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega grupos da operacao no grid
    * Wrapper sobre CarregarDados para compatibilidade com o pipeline
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF !EMPTY(THIS.this_cDopes)
            THIS.CarregarDados()
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Atualiza estado dos botoes conforme this_cEscolha
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos(INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR"))
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa cursores e re-habilita form pai
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Operacao")
            USE IN cursor_4c_Operacao
        ENDIF
        IF USED("cursor_4c_GruposTemp")
            USE IN cursor_4c_GruposTemp
        ENDIF
        IF USED("cursor_4c_GrpLookup")
            USE IN cursor_4c_GrpLookup
        ENDIF
        IF USED("cursor_4c_GrpBusca")
            USE IN cursor_4c_GrpBusca
        ENDIF
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
