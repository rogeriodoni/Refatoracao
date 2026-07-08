*==============================================================================
* FormSIGPRCIC.prg - Dialog de Escolha de Icones para Programas
* Data: 2026-07-02
* Funcao: Dialog modal para selecionar icone de item de menu/programa
*
* Filosofia 3 Pilares:
*   UX     -> layout do SCX legado preservado (grid de icones + preview + campo Programa)
*   BANCO  -> opera sobre cursores crProg1/crProg2/crSigSyIco1 do form pai (sem SQL proprio)
*   CODE   -> arquitetura em camadas (FormBase / SIGPRCICBO), sufixo _4c_
*
* Obs: Compartilha datasession do form pai (DataSession=1); nao usa SQLEXEC direto.
*==============================================================================

DEFINE CLASS FormSIGPRCIC AS FormBase

    *-- Dimensoes e propriedades visuais (copiadas do SCX original)
    Width           = 469
    Height          = 496
    AutoCenter      = .T.
    TitleBar        = 0
    ShowWindow = 1
    ControlBox      = .F.
    Closable        = .F.
    MaxButton       = .F.
    MinButton       = .F.
    ClipControls    = .F.
    BorderStyle     = 2
    WindowType      = 1
    DataSession     = 1     && Compartilha datasession do form pai (acessa crProg1/crProg2/crSigSyIco1)

    *-- Business Object
    this_oBusinessObject    = .NULL.

    *-- Chave do programa recebida como parametro (pkChaves de crProg1/crProg2)
    this_cIdChaves          = ""

    *-- Referencia ao form pai (para compartilhar datasession)
    this_oFormPai           = .NULL.

    *--------------------------------------------------------------------------
    * Init - Recebe form pai e chave do programa; delega inicializacao a FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cIdChaves)
        *-- Armazena parametros ANTES do DODEFAULT para que InicializarForm os encontre
        IF TYPE("par_oFormPai") = "O"
            THIS.this_oFormPai = par_oFormPai
        ELSE
            THIS.this_oFormPai = THIS
        ENDIF

        IF TYPE("par_cIdChaves") = "C"
            THIS.this_cIdChaves = par_cIdChaves
        ELSE
            THIS.this_cIdChaves = ""
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    * Cria BO, constroi PageFrame + containers principais e prepara dados iniciais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Herdar datasession do form pai para acessar crProg1/crProg2/crSigSyIco1
            *-- Equivalente ao .DataSessionId = .poForm1.DataSessionId do legado
            IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
                THIS.DataSessionId = THIS.this_oFormPai.DataSessionId
            ENDIF

            *-- Caption com acento via CHR (regra: sem literais acentuados em PRG)
            THIS.Caption = "Escolha de " + CHR(205) + "cones"

            *-- Imagem de fundo do form (copiada do SCX legado)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Cria Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCICBO")

            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar SIGPRCICBO", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Construcao do form
            THIS.LockScreen = .T.
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarPageFrame()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.TornarControlesVisiveis(THIS)
            THIS.LockScreen = .F.

            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                THIS.CarregarDados()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria cnt_4c_Cabecalho (cntSombra do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize      = .F.
                .Top           = 18
                .Left          = 10
                .Width         = loc_oCab.Width
                .Height        = 40
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = "Escolha de " + CHR(237) + "cones"
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Top       = 17
                .Left      = 10
                .Width     = loc_oCab.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Escolha de " + CHR(237) + "cones"
                .ForeColor = RGB(255, 255, 255)
            ENDWITH
        ENDWITH

        *-- Torna cabecalho visivel explicitamente (TornarControlesVisiveis o filtra via INLIST)
        loc_oCab.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Constroi pgf_4c_Paginas com Page1 e Page2,
    * delegando a construcao dos controles a ConfigurarPaginaLista().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        *-- Cria PageFrame que ocupa area abaixo do cabecalho
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas
        loc_oPgf.PageCount = 2
        loc_oPgf.Top       = 80
        loc_oPgf.Left      = 0
        loc_oPgf.Width     = THIS.Width
        loc_oPgf.Height    = THIS.Height - 80
        loc_oPgf.TabIndex  = 1
        loc_oPgf.Tabs      = .F.

        loc_oPgf.Page1.Caption = "Lista"
        loc_oPgf.Page2.Caption = "Dados"

        *-- Constroi controles da Page1 (grid de icones + preview + campo Programa)
        THIS.ConfigurarPaginaLista()

        *-- Page2: dialog plano, sem campos adicionais no original
        THIS.ConfigurarPaginaDados()

        *-- Ativa Page1 por default (visao principal do dialog)
        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Constroi todos os controles de Page1:
    *   - lbl_4c_Programa + txt_4c_Programa (campo programa, somente leitura)
    *   - shp_4c_Preview (borda decorativa ao redor do preview)
    *   - img_4c_Icone (imagem preview do icone selecionado)
    *   - grd_4c_Dados (lista de icones - mapeado de Grid1 do legado)
    *   - BINDEVENTs para navegacao no grid e selecao de icone
    *
    * Posicoes: PageFrame.Top=80; controles em coords relativas a Page1
    * (Top_original - 80). RecordSource definido em CarregarDados().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Label "Programa" (Say2 do legado: Top=86 -> 86-80=6)
        loc_oPagina.AddObject("lbl_4c_Programa", "Label")
        WITH loc_oPagina.lbl_4c_Programa
            .Caption   = "Programa"
            .Left      = 12
            .Top       = 6
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
        ENDWITH

        *-- TextBox nome do programa - somente leitura (Text1 do legado: Top=103 -> 23)
        loc_oPagina.AddObject("txt_4c_Programa", "TextBox")
        WITH loc_oPagina.txt_4c_Programa
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Height    = 24
            .Left      = 9
            .Top       = 23
            .Width     = 457
            .ForeColor = RGB(90, 90, 90)
            .ReadOnly  = .T.
            .Value     = ""
        ENDWITH

        *-- Shape - borda decorativa ao redor do preview (Shape1 do legado: Top=184 -> 104)
        loc_oPagina.AddObject("shp_4c_Preview", "Shape")
        WITH loc_oPagina.shp_4c_Preview
            .Top         = 104
            .Left        = 276
            .Height      = 169
            .Width       = 169
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        *-- Image - preview do icone selecionado (Icone do legado: Top=200 -> 120)
        loc_oPagina.AddObject("img_4c_Icone", "Image")
        WITH loc_oPagina.img_4c_Icone
            .Stretch = 1
            .Height  = 156
            .Left    = 282
            .Top     = 120
            .Width   = 156
        ENDWITH

        *-- Grid de icones (Grid1 do legado: Top=131 -> 51)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Dados
        WITH loc_oGrid
            .ColumnCount       = 1
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .Height            = 345
            .Left              = 10
            .Top               = 51
            .Width             = 242
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .HeaderHeight      = 15
            .RowHeight         = 15

            *-- Formatacao via SetAll (espelhando Init() do legado)
            .FontName = "Courier New"
            .SetAll("FontName",    "Arial",        "Header")
            .SetAll("FontName",    "Courier New", "TextBox")
            .FontSize = 9
            .SetAll("FontSize",    8,              "Header")
            .SetAll("FontSize",    9,              "TextBox")
            .SetAll("Format",      "K",            "Column")
            .SetAll("Format",      "K",            "TextBox")
            .SetAll("Movable",     .F.,            "Column")
            .SetAll("ReadOnly",    .T.,            "Column")
            .SetAll("ReadOnly",    .T.,            "TextBox")
            .SetAll("Resizable",   .F.,            "Column")
            .SetAll("Alignment",   3,              "Column")
            .SetAll("Alignment",   3,              "TextBox")
            .SetAll("Alignment",   2,              "Header")
            .SetAll("BorderStyle", 0,              "TextBox")
            .SetAll("Margin",      0,              "TextBox")
            .SetAll("Visible",     .T.,            "TextBox")

            *-- Propriedades da coluna
            .Column1.Width    = 211
            .Column1.Movable  = .F.
            .Column1.ReadOnly = .T.
            .Column1.FontName = "Courier New"

            *-- Header (CHR(205) = I-agudo maiusculo)
            .Column1.Header1.Caption   = CHR(205) + "cones"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(90, 90, 90)

            *-- TextBox dentro da coluna
            .Column1.Text1.FontName    = "Courier New"
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ReadOnly    = .T.
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- BINDEVENTs para navegacao no grid e selecao de icone
        BINDEVENT(loc_oGrid, "AfterRowColChange",  THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(loc_oGrid, "BeforeRowColChange", THIS, "GrdDadosBeforeRowColChange")
        BINDEVENT(loc_oGrid, "Scrolled",           THIS, "GrdDadosScrolled")
        BINDEVENT(loc_oGrid.Column1.Text1, "DblClick",  THIS, "GrdDadosText1DblClick")
        BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress",  THIS, "GrdDadosText1KeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2 nao possui controles no form original
    * SIGPRCIC e um dialog flat: todos os campos estao em Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(240, 240, 240)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Le o icone atual do programa via BO e posiciona o cursor
    * de icones no arquivo correspondente.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_cArqIcone, loc_cArquivo, loc_oPagina, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_oPagina   = THIS.pgf_4c_Paginas.Page1
            loc_cArqIcone = THIS.this_oBusinessObject.BuscarIconeAtual(THIS.this_cIdChaves)

            *-- Popula campo Programa com descricao lida pelo BO (crProg2.descricaos)
            loc_oPagina.txt_4c_Programa.Value = THIS.this_oBusinessObject.this_cDescricao

            *-- Posiciona cursor de icones (aberto pelo form pai) no icone atual
            IF USED("crSigSyIco1")
                SET ORDER TO ("carqicones") IN ("crSigSyIco1")

                IF !SEEK(loc_cArqIcone, "crSigSyIco1", "carqicones")
                    SELECT crSigSyIco1
                    GO TOP
                ENDIF

                *-- RecordSource fora do WITH: Column1 pode ser acessado com seguranca em seguida
                loc_oPagina.grd_4c_Dados.RecordSource = "crSigSyIco1"
                WITH loc_oPagina.grd_4c_Dados
                    .Column1.ControlSource = "crSigSyIco1.carqicones"
                    .LinkMaster            = ""
                    .RelationalExpr        = ""
                ENDWITH

                *-- Atualiza preview com o icone da linha inicial
                loc_cArquivo = ALLTRIM(crSigSyIco1.ctmpicones)
                IF !EMPTY(loc_cArquivo)
                    loc_oPagina.img_4c_Icone.Picture = loc_cArquivo
                    loc_oPagina.img_4c_Icone.Visible = .T.
                ELSE
                    loc_oPagina.img_4c_Icone.Visible = .F.
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna sub-controles visiveis apos AddObject
    * AddObject cria com Visible=.F.; percorre Controls + Pages recursivamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                *-- Recursao ANTES do filtro: garante que filhos de containers ocultos
                *-- tambem se tornem visiveis (LOOP antecipado perderia os filhos)
                IF PEMSTATUS(loc_oObjeto, "PageCount", 5)
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF

                *-- cnt_4c_Cabecalho tem Visible gerenciado explicitamente em ConfigurarCabecalho
                IF INLIST(LOWER(loc_oObjeto.Name), "cnt_4c_cabecalho")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Muda a pagina ativa do PageFrame
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarPreviewIcone - Atualiza img_4c_Icone com o icone da linha atual
    * Chamado pelos handlers de navegacao do grid.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarPreviewIcone()
        LOCAL loc_cArquivo, loc_oImagem

        IF !USED("crSigSyIco1") OR EOF("crSigSyIco1")
            RETURN
        ENDIF

        loc_oImagem  = THIS.pgf_4c_Paginas.Page1.img_4c_Icone
        loc_cArquivo = ALLTRIM(crSigSyIco1.ctmpicones)

        IF !EMPTY(loc_cArquivo)
            loc_oImagem.Picture = loc_cArquivo
            loc_oImagem.Visible = .T.
        ELSE
            loc_oImagem.Visible = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Atualiza preview apos mover linha (BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        THIS.AtualizarPreviewIcone()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosBeforeRowColChange - Atualiza preview antes de mudar linha (BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosBeforeRowColChange(par_nColIndex)
        THIS.AtualizarPreviewIcone()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosScrolled - Atualiza preview ao rolar o grid (BINDEVENT)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosScrolled(par_nDirection)
        THIS.AtualizarPreviewIcone()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosText1DblClick - Seleciona icone e fecha dialog (BINDEVENT)
    * Mapeado de Grid1.Column1.Text1.DblClick do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosText1DblClick()
        LOCAL loc_cArqIcone
        loc_cArqIcone = LOWER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Column1.Text1.Value))
        THIS.this_oBusinessObject.SelecionarIcone(loc_cArqIcone, THIS.this_cIdChaves)
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosText1KeyPress - ENTER na celula aciona selecao (BINDEVENT)
    * Mapeado de Grid1.Column1.Text1.KeyPress do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosText1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            THIS.GrdDadosText1DblClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - ESC fecha o dialog sem salvar
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterIconeSelecionadoNoGrid - Retorna nome do arquivo de icone da linha ativa
    * Lida com marcador "< nenhum >" transformando em string vazia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterIconeSelecionadoNoGrid()
        LOCAL loc_cArqIcone

        IF !USED("crSigSyIco1") OR EOF("crSigSyIco1")
            RETURN ""
        ENDIF

        loc_cArqIcone = LOWER(ALLTRIM(NVL(crSigSyIco1.carqicones, "")))
        IF loc_cArqIcone == "< nenhum >"
            loc_cArqIcone = ""
        ENDIF

        RETURN loc_cArqIcone
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Atribui o icone selecionado ao programa
    * Le o icone da linha ativa do grid + chama BO.Inserir + fecha o dialog.
    * Equivalente ao Grid1.Column1.Text1.DblClick do legado quando nao havia icone.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cArqIcone, loc_lSucesso, loc_oErro

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                MsgAviso("Chave do programa n" + CHR(227) + "o informada.", "Aviso")
                RETURN
            ENDIF

            loc_cArqIcone = THIS.ObterIconeSelecionadoNoGrid()

            THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
            THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone

            loc_lSucesso = THIS.this_oBusinessObject.Salvar()

            IF loc_lSucesso
                THIS.Release()
            ELSE
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Troca o icone atribuido ao programa
    * Le o icone da linha ativa do grid + chama BO.Atualizar + fecha o dialog.
    * Equivalente ao Grid1.Column1.Text1.DblClick do legado quando ja havia icone.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cArqIcone, loc_lSucesso, loc_oErro

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                MsgAviso("Chave do programa n" + CHR(227) + "o informada.", "Aviso")
                RETURN
            ENDIF

            loc_cArqIcone = THIS.ObterIconeSelecionadoNoGrid()

            THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
            THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone

            IF THIS.this_oBusinessObject.SelecionarIcone(loc_cArqIcone, THIS.this_cIdChaves)
                THIS.Release()
            ELSE
                MsgAviso("Falha ao atualizar " + CHR(237) + "cone.", "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Atualiza preview do icone da linha ativa
    * Equivalente ao Grid1.AfterRowColChange do legado (que atualizava o preview).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("crSigSyIco1")
                MsgAviso("Lista de " + CHR(237) + "cones n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
                RETURN
            ENDIF

            THIS.AtualizarPreviewIcone()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Remove o icone atribuido ao programa
    * Chama BO.Excluir para zerar barrapict/barraforms em crProg1/crProg2 + fecha.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma, loc_lSucesso, loc_oErro

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                MsgAviso("Chave do programa n" + CHR(227) + "o informada.", "Aviso")
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma("Confirma a remo" + CHR(231) + CHR(227) + "o do " + CHR(237) + "cone atribu" + CHR(237) + "do?", "Confirma" + CHR(231) + CHR(227) + "o")

            IF !loc_lConfirma
                RETURN
            ENDIF

            THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
            loc_lSucesso = THIS.this_oBusinessObject.Excluir()

            IF loc_lSucesso
                THIS.Release()
            ELSE
                MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Reinicializa o grid com crSigSyIco1 e atualiza preview
    * Util para refresco apos mudanca de icone ou retorno ao dialog.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oPagina, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            IF USED("crSigSyIco1")
                *-- RecordSource fora do WITH: Column1 pode ser acessado com seguranca em seguida
                loc_oPagina.grd_4c_Dados.RecordSource = "crSigSyIco1"
                WITH loc_oPagina.grd_4c_Dados
                    .Column1.ControlSource = "crSigSyIco1.carqicones"
                    .LinkMaster            = ""
                    .RelationalExpr        = ""
                ENDWITH
                THIS.AtualizarPreviewIcone()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere o icone selecionado no grid para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_cArqIcone

        TRY
            loc_cArqIcone = THIS.ObterIconeSelecionadoNoGrid()
            THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
            THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza preview do form com o icone registrado no BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_cArquivo, loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cArquivo = ALLTRIM(THIS.this_oBusinessObject.this_cArqIcone)

            IF !EMPTY(loc_cArquivo)
                loc_oPagina.img_4c_Icone.Picture = loc_cArquivo
                loc_oPagina.img_4c_Icone.Visible = .T.
            ELSE
                loc_oPagina.img_4c_Icone.Visible = .F.
            ENDIF

            loc_oPagina.txt_4c_Programa.Value = THIS.this_oBusinessObject.this_cDescricao
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Neste dialog os campos sao sempre readonly (somente grid)
    * Implementado para compatibilidade com FormBase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina

        IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPagina, "txt_4c_Programa", 5)
                loc_oPagina.txt_4c_Programa.ReadOnly = .T.
            ENDIF
            IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
                loc_oPagina.grd_4c_Dados.ReadOnly = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa o preview e o campo de programa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oPagina.img_4c_Icone.Visible = .F.
            loc_oPagina.img_4c_Icone.Picture = ""
            loc_oPagina.txt_4c_Programa.Value = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Dialog plano sem modos CRUD; sem ajuste de botoes
    * Implementado para compatibilidade com FormBase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega o grid de icones e posiciona no icone atual
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro

        TRY
            THIS.CarregarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Seleciona o icone da linha atual e fecha o dialog
    * Equivalente ao DblClick/ENTER no grid; usa FormParaBO antes de salvar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oErro

        TRY
            THIS.FormParaBO()
            loc_lSucesso = THIS.this_oBusinessObject.SelecionarIcone( ;
                THIS.this_oBusinessObject.this_cArqIcone, ;
                THIS.this_cIdChaves)

            IF loc_lSucesso
                THIS.Release()
            ELSE
                MsgAviso("Falha ao atribuir " + CHR(237) + "cone.", "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o dialog sem salvar (mesmo comportamento do ESC)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o dialog (alias de Cancelar para compatibilidade)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera Business Object e delega restante ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar erros no Destroy (form ja esta sendo liberado)
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
