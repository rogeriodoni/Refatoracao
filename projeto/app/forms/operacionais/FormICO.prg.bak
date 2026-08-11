*==============================================================================
* FormICO.prg - Cadastro de Icones (SigSyIco)
* Form OPERACIONAL - Grid de icones + preview da imagem selecionada
* Herda de: FormBase
* Legado: SIGCDICO.SCX
*==============================================================================
DEFINE CLASS FormICO AS FormBase

    Width        = 800
    Height       = 620
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    ShowWindow = 0
    WindowType = 0
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .T.
    ShowTips     = .T.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Diretorio temporario para arquivos de icone extraidos do banco
    this_cDirTemp = ""

    *--------------------------------------------------------------------------
    FUNCTION Load()
    *--------------------------------------------------------------------------
        *-- Em modo teste: pular Form.Load() builtin. Com ShowWindow=0 (MDI child)
        *-- na definicao da classe, Form.Load() tenta registrar o form no MDI pai
        *-- que nao existe em VFP9 -T headless, travando 300s ANTES de Init() rodar.
        *-- Fixes t1-t8 focaram em Init() -- tarde demais. Load() roda primeiro.
        *-- RETURN .T. explicito obrigatorio: RETURN bare em FUNCTION retorna .F.,
        *-- cancela CREATEOBJECT mesmo sem DataSession=2.
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF
        RETURN DODEFAULT()
    ENDFUNC

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            THIS.ShowWindow = 2
            THIS.Visible    = .F.
            RETURN DODEFAULT()
        ENDIF
        THIS.WindowType = 1
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *--------------------------------------------------------------------------
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("ICOBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar ICOBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE

                *-- Propriedades dinamicas do form (Caption e Picture requerem CHR/FILE)
                THIS.Caption = "Cadastro de " + CHR(205) + "cones"
                IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                    THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                ENDIF

                THIS.LockScreen = .T.

                *-- Orquestra a composicao do layout (cabecalho + area de lista + area de acoes)
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar icones do SQL Server para cursor crTmpcdico
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.this_cDirTemp = ADDBS(SYS(2023))
                    THIS.this_oBusinessObject.CarregarIcones(THIS.this_cDirTemp)
                    IF USED("crTmpcdico")
                        THIS.grd_4c_Dados.ColumnCount              = 1
                        THIS.grd_4c_Dados.RecordSource             = "crTmpcdico"
                        THIS.grd_4c_Dados.Column1.ControlSource    = "crTmpcdico.carqicones"
                        THIS.grd_4c_Dados.Column1.Header1.Caption  = CHR(205) + "cones"
                        THIS.grd_4c_Dados.Visible = .T.
                        THIS.grd_4c_Dados.Refresh()
                        THIS.AtualizarPreview()
                        THIS.grd_4c_Dados.SetFocus()
                    ENDIF
                ENDIF

                THIS.LockScreen = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Inicializar FormICO")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *--------------------------------------------------------------------------
    * OPERACIONAL flat layout - o legado SIGCDICO nao usa PageFrame; controles
    * (Grid1 de icones, Icone/Image de preview, Commandgroup1 de acoes) ficam
    * diretamente sobre o Form. Este metodo orquestra a composicao das regioes:
    * cabecalho cinza (cntSombra), area de listagem (Grid1 + Image), area de
    * acoes (CommandGroup Novo/Excluir/Fechar). Nome preservado para
    * compatibilidade com o pipeline de migracao multi-fase.
    *--------------------------------------------------------------------------
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = -1
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = "Cadastro de " + CHR(205) + "cones"
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Cadastro de " + CHR(205) + "cones"
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        IF USED("crTmpcdico")
            USE IN crTmpcdico
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *--------------------------------------------------------------------------
        *-- Grid de icones (grd_4c_Dados) - Grid1 do legado
        THIS.AddObject("grd_4c_Dados", "Grid")
        THIS.grd_4c_Dados.ColumnCount = 1
        WITH THIS.grd_4c_Dados
            .Top               = 85
            .Left              = 30
            .Width             = 414
            .Height            = 526
            .ReadOnly          = .T.
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .HeaderHeight      = 15
            .RowHeight         = 15

            .FontName = "Courier New"
            .SetAll("FontName",    "Verdana",           "Header")
            .SetAll("FontName",    "Courier New",       "TextBox")
            .FontSize = 9
            .SetAll("FontSize",    8,                   "Header")
            .SetAll("FontSize",    9,                   "TextBox")
            .SetAll("Format",      "K",                 "Column")
            .SetAll("Format",      "K",                 "TextBox")
            .SetAll("Movable",     .F.,                 "Column")
            .SetAll("ReadOnly",    .T.,                 "Column")
            .SetAll("ReadOnly",    .T.,                 "TextBox")
            .SetAll("Resizable",   .F.,                 "Column")
            .SetAll("Alignment",   3,                   "Column")
            .SetAll("Alignment",   3,                   "TextBox")
            .SetAll("Alignment",   2,                   "Header")
            .SetAll("BorderStyle", 0,                   "TextBox")
            .SetAll("Margin",      0,                   "TextBox")
            .SetAll("Visible",     .T.,                 "TextBox")
            .SetAll("ForeColor",   RGB(36, 84, 155),   "Header")

            .Column1.Width = 383
        ENDWITH

        *-- Imagem de preview do icone selecionado (img_4c_Icone) - "Icone" do legado
        THIS.AddObject("img_4c_Icone", "Image")
        WITH THIS.img_4c_Icone
            .Top         = 220
            .Left        = 456
            .Width       = 305
            .Height      = 247
            .Stretch     = 1
            .BackStyle   = 1
            .BorderStyle = 1
            .Visible     = .F.
        ENDWITH

        *-- CommandGroup de acoes (obj_4c_Commandgroup1) - Commandgroup1 do legado
        THIS.AddObject("obj_4c_Commandgroup1", "CommandGroup")
        WITH THIS.obj_4c_Commandgroup1
            .Top           = -2
            .Left          = 567
            .Width         = 237
            .Height        = 85
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        WITH THIS.obj_4c_Commandgroup1.Buttons(1)
            .AutoSize        = .F.
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Incluir"
            .ToolTipText     = "Inserir"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
        ENDWITH

        WITH THIS.obj_4c_Commandgroup1.Buttons(2)
            .AutoSize        = .F.
            .Top             = 5
            .Left            = 81
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .ToolTipText     = "Excluir"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
        ENDWITH

        WITH THIS.obj_4c_Commandgroup1.Buttons(3)
            .Top             = 5
            .Left            = 157
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .ToolTipText     = "[ESC] Sair"
            .Cancel          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
        ENDWITH

        *-- BINDEVENTs para eventos do grid (atualizar preview ao navegar)
        BINDEVENT(THIS.grd_4c_Dados, "Scrolled",           THIS, "GrdDadosScrolled")
        BINDEVENT(THIS.grd_4c_Dados, "BeforeRowColChange",  THIS, "GrdDadosBeforeRowColChange")
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange",   THIS, "GrdDadosAfterRowColChange")

        *-- BINDEVENTs para botoes de acao
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnIncluirClick")
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnExcluirClick")
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(3), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
    *--------------------------------------------------------------------------
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarPreview()
    *--------------------------------------------------------------------------
        LOCAL loc_cArquivo, loc_cNomeArq
        loc_cArquivo = ""
        loc_cNomeArq = ""
        IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
            SELECT crTmpcdico
            loc_cArquivo = ALLTRIM(crTmpcdico.ctmpicones)
            loc_cNomeArq = ALLTRIM(crTmpcdico.carqicones)
        ENDIF
        IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
            THIS.img_4c_Icone.Picture = loc_cArquivo
            THIS.img_4c_Icone.Visible = .T.
        ELSE
            THIS.img_4c_Icone.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
            THIS.lbl_4c_NomeIcone.Caption = loc_cNomeArq
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosScrolled - Atualiza preview ao rolar o grid (Grid1.Scrolled do legado)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosScrolled(par_nDirection)
        THIS.AtualizarPreview()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosBeforeRowColChange - Atualiza preview antes de mudar linha
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosBeforeRowColChange(par_nColIndex)
        THIS.AtualizarPreview()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Atualiza preview apos mudar linha
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        THIS.AtualizarPreview()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inclui novo icone via seletor de arquivo (cmdInserir.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cArqIcone, loc_oErro
        loc_cArqIcone = ""
        TRY
            loc_cArqIcone = GETPICT("ico;gif;jpg;bmp;pic", "", "OK")

            IF EMPTY(loc_cArqIcone)
                RETURN
            ENDIF

            IF !FILE(loc_cArqIcone)
                MsgAviso("Nome do arquivo inv" + CHR(225) + "lido.", "Aviso")
                RETURN
            ENDIF

            THIS.LockScreen = .T.

            LOCAL loc_cDirTmp, loc_cArqTemp, loc_cNomeArq
            loc_cDirTmp  = ADDBS(SYS(2023))
            loc_cArqTemp = loc_cDirTmp + "ArqIcone" + SYS(2015) + ".ico"
            loc_cNomeArq = LOWER(JUSTFNAME(loc_cArqIcone))

            LOCAL loc_lExiste
            loc_lExiste = .F.
            IF USED("crTmpcdico")
                SELECT crTmpcdico
                LOCATE FOR ALLTRIM(carqicones) == loc_cNomeArq
                loc_lExiste = FOUND()
            ENDIF

            IF !loc_lExiste
                SELECT crTmpcdico
                APPEND BLANK
            ELSE
                SELECT crTmpcdico
            ENDIF

            REPLACE carqicones WITH loc_cNomeArq
            REPLACE marqicones WITH FILETOSTR(loc_cArqIcone)
            REPLACE ctmpicones WITH loc_cArqTemp

            LOCAL loc_nBytes
            loc_nBytes = STRTOFILE(crTmpcdico.marqicones, loc_cArqTemp)

            THIS.this_oBusinessObject.this_cCarqIcones = loc_cNomeArq
            THIS.this_oBusinessObject.this_cMarqIcones = crTmpcdico.marqicones

            LOCAL loc_lSucesso
            IF !loc_lExiste
                loc_lSucesso = THIS.this_oBusinessObject.Inserir()
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            SELECT crTmpcdico
            GO TOP
            LOCATE FOR carqicones == loc_cNomeArq
            THIS.AtualizarPreview()
            THIS.Refresh()
            THIS.LockScreen = .F.
            THIS.grd_4c_Dados.SetFocus()
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Incluir " + CHR(205) + "cone")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui icone selecionado (cmdExcluir.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("crTmpcdico") OR RECCOUNT("crTmpcdico") = 0
                RETURN
            ENDIF

            SELECT crTmpcdico
            LOCAL loc_cRegistro
            loc_cRegistro = ALLTRIM(crTmpcdico.carqicones)

            IF EMPTY(loc_cRegistro)
                RETURN
            ENDIF

            IF !MsgConfirma("Tem certeza que deseja Excluir?", "Excluir")
                RETURN
            ENDIF

            THIS.LockScreen = .T.

            IF THIS.this_oBusinessObject.VerificarUsoIcone(loc_cRegistro)
                MsgAviso("Existem " + CHR(237) + "tens cadastrados que est" + CHR(227) + ;
                    "o utilizando esse Registro!", ;
                    "Exclus" + CHR(227) + "o n" + CHR(227) + "o permitida")
                THIS.LockScreen = .F.
                RETURN
            ENDIF

            THIS.this_oBusinessObject.this_cCarqIcones = loc_cRegistro
            IF THIS.this_oBusinessObject.Excluir()
                DELETE FROM crTmpcdico WHERE ALLTRIM(carqicones) = loc_cRegistro
                THIS.grd_4c_Dados.Refresh()
                SELECT crTmpcdico
                GO TOP
                LOCATE FOR carqicones > loc_cRegistro
                IF EOF()
                    GO BOTTOM
                ENDIF
                THIS.AtualizarPreview()
                THIS.Refresh()
                THIS.grd_4c_Dados.SetFocus()
            ENDIF

            THIS.LockScreen = .F.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Excluir " + CHR(205) + "cone")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (cmdSair.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Substitui o conteudo binario do icone selecionado por
    * um novo arquivo (mantem o carqicones/PK, atualiza marqicones/ctmpicones).
    * O legado nao expoe botao Alterar; a semantica adotada segue o mesmo
    * fluxo de Incluir quando SEEK() encontra o registro (chama Atualizar()).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cArqIcone, loc_oErro
        loc_cArqIcone = ""
        TRY
            IF !USED("crTmpcdico") OR RECCOUNT("crTmpcdico") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " " + CHR(237) + ;
                    "cones cadastrados para alterar.", "Aviso")
                RETURN
            ENDIF

            SELECT crTmpcdico
            LOCAL loc_cNomeAtual
            loc_cNomeAtual = ALLTRIM(crTmpcdico.carqicones)

            IF EMPTY(loc_cNomeAtual)
                MsgAviso("Selecione um " + CHR(237) + "cone na lista para alterar.", "Aviso")
                RETURN
            ENDIF

            loc_cArqIcone = GETPICT("ico;gif;jpg;bmp;pic", "", "OK")

            IF EMPTY(loc_cArqIcone)
                RETURN
            ENDIF

            IF !FILE(loc_cArqIcone)
                MsgAviso("Nome do arquivo inv" + CHR(225) + "lido.", "Aviso")
                RETURN
            ENDIF

            IF !MsgConfirma("Substituir o conte" + CHR(250) + "do do " + CHR(237) + ;
                    "cone selecionado?", "Alterar")
                RETURN
            ENDIF

            THIS.LockScreen = .T.

            LOCAL loc_cDirTmp, loc_cArqTemp, loc_mConteudo
            loc_cDirTmp   = ADDBS(SYS(2023))
            loc_cArqTemp  = loc_cDirTmp + "ArqIcone" + SYS(2015) + ".ico"
            loc_mConteudo = FILETOSTR(loc_cArqIcone)

            SELECT crTmpcdico
            REPLACE marqicones WITH loc_mConteudo
            REPLACE ctmpicones WITH loc_cArqTemp

            STRTOFILE(loc_mConteudo, loc_cArqTemp)

            THIS.this_oBusinessObject.this_cCarqIcones = loc_cNomeAtual
            THIS.this_oBusinessObject.this_cMarqIcones = loc_mConteudo

            LOCAL loc_lSucesso
            loc_lSucesso = THIS.this_oBusinessObject.Atualizar()

            THIS.grd_4c_Dados.Refresh()
            SELECT crTmpcdico
            LOCATE FOR ALLTRIM(carqicones) == loc_cNomeAtual
            THIS.AtualizarPreview()
            THIS.Refresh()
            THIS.LockScreen = .F.
            THIS.grd_4c_Dados.SetFocus()
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Alterar " + CHR(205) + "cone")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Reforca a exibicao da imagem do icone selecionado
    * no painel de preview (img_4c_Icone) e devolve o foco ao grid. Espelha o
    * comportamento de navegacao do legado (Grid1.Scrolled/AfterRowColChange)
    * quando invocado explicitamente pelo usuario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF !USED("crTmpcdico") OR RECCOUNT("crTmpcdico") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " " + CHR(237) + ;
                    "cones cadastrados para visualizar.", "Aviso")
                RETURN
            ENDIF

            SELECT crTmpcdico
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(crTmpcdico.carqicones)

            IF EMPTY(loc_cNome)
                MsgAviso("Selecione um " + CHR(237) + "cone na lista para visualizar.", "Aviso")
                RETURN
            ENDIF

            *-- Se o arquivo temporario foi removido, regenerar a partir do MEMO
            LOCAL loc_cArqTemp
            loc_cArqTemp = ALLTRIM(crTmpcdico.ctmpicones)
            IF EMPTY(loc_cArqTemp) OR !FILE(loc_cArqTemp)
                loc_cArqTemp = ADDBS(SYS(2023)) + "ArqIcone" + SYS(2015) + ".ico"
                IF !EMPTY(crTmpcdico.marqicones)
                    STRTOFILE(crTmpcdico.marqicones, loc_cArqTemp)
                    REPLACE ctmpicones WITH loc_cArqTemp
                ELSE
                    loc_cArqTemp = ""
                ENDIF
            ENDIF

            THIS.AtualizarPreview()
            THIS.Refresh()
            THIS.grd_4c_Dados.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Visualizar " + CHR(205) + "cone")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *--------------------------------------------------------------------------
    * Painel direito do form (x=456+): labels informativos acima da preview
    * Area entre cabecalho (bottom=79) e imagem (top=220) ~ 140px disponiveis
    *--------------------------------------------------------------------------
        *-- Instrucao: orienta o usuario a selecionar um icone na lista
        THIS.AddObject("lbl_4c_Instrucao", "Label")
        WITH THIS.lbl_4c_Instrucao
            .Top       = 95
            .Left      = 456
            .Width     = 320
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Selecione um " + CHR(237) + "cone da lista:"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Exibe o nome do arquivo do icone correntemente selecionado no grid
        THIS.AddObject("lbl_4c_NomeIcone", "Label")
        WITH THIS.lbl_4c_NomeIcone
            .Top       = 120
            .Left      = 456
            .Width     = 320
            .Height    = 75
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .WordWrap  = .T.
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = ""
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- Titulo da secao de preview (imagem do icone selecionado)
        THIS.AddObject("lbl_4c_Preview", "Label")
        WITH THIS.lbl_4c_Preview
            .Top       = 200
            .Left      = 456
            .Width     = 320
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Pr" + CHR(233) + "via:"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega a lista de icones do SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oErro
        TRY
            THIS.LockScreen = .T.
            THIS.this_oBusinessObject.CarregarIcones(THIS.this_cDirTemp)
            IF USED("crTmpcdico")
                THIS.grd_4c_Dados.ColumnCount             = 1
                THIS.grd_4c_Dados.RecordSource            = "crTmpcdico"
                THIS.grd_4c_Dados.Column1.ControlSource   = "crTmpcdico.carqicones"
                THIS.grd_4c_Dados.Column1.Header1.Caption = CHR(205) + "cones"
                THIS.grd_4c_Dados.Visible = .T.
                THIS.grd_4c_Dados.Refresh()
                THIS.AtualizarPreview()
                THIS.HabilitarCampos()
            ENDIF
            THIS.LockScreen = .F.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Carregar Lista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega a lista de icones (refresh)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Form OPERACIONAL: delega ao fluxo de Incluir
    * (nao ha modo de edicao separado; o Incluir ja persiste diretamente)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa preview e volta ao topo da lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
            SELECT crTmpcdico
            GO TOP
            THIS.AtualizarPreview()
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza o registro selecionado no grid com o BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
            SELECT crTmpcdico
            THIS.this_oBusinessObject.this_cCarqIcones = ALLTRIM(crTmpcdico.carqicones)
            THIS.this_oBusinessObject.this_cMarqIcones = crTmpcdico.marqicones
            IF TYPE("crTmpcdico.ctmpicones") != "U"
                THIS.this_oBusinessObject.this_cCtmpIcones = ALLTRIM(crTmpcdico.ctmpicones)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza o BO com a area de preview e label de nome
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
            THIS.lbl_4c_NomeIcone.Caption = ALLTRIM(THIS.this_oBusinessObject.this_cCarqIcones)
        ENDIF
        IF PEMSTATUS(THIS, "img_4c_Icone", 5)
            LOCAL loc_cArq
            loc_cArq = ALLTRIM(THIS.this_oBusinessObject.this_cCtmpIcones)
            IF !EMPTY(loc_cArq) AND FILE(loc_cArq)
                THIS.img_4c_Icone.Picture = loc_cArq
                THIS.img_4c_Icone.Visible = .T.
            ELSE
                THIS.img_4c_Icone.Visible = .F.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita botoes conforme disponibilidade de dados
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_lTemRegistros
        loc_lTemRegistros = USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
        IF PEMSTATUS(THIS, "obj_4c_Commandgroup1", 5)
            THIS.obj_4c_Commandgroup1.Buttons(2).Enabled = loc_lTemRegistros
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa a area de preview e o label de nome do icone
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "img_4c_Icone", 5)
            THIS.img_4c_Icone.Picture = ""
            THIS.img_4c_Icone.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
            THIS.lbl_4c_NomeIcone.Caption = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Form OPERACIONAL flat: delega para HabilitarCampos
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles de um container visiveis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_p
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    IF !INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO")
                        loc_oControl.Visible = .T.
                    ENDIF
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
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

ENDDEFINE
