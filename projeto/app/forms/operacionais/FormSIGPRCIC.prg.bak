*==============================================================================
* FORMSIGPRCIC.PRG - Formulario Operacional: Escolha de Icones de Programas
* Tipo: OPERACIONAL (flat - sem PageFrame, popup modal pequeno)
* Migrado de SIGPRCIC.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (469x496 - popup modal)
*   BD   -> cursores crProg1/crProg2/crSigSyIco1 (datasession compartilhada)
*   CODE -> arquitetura em camadas (FormBase / SIGPRCICBO)
*
* CHAMADA:
*   loForm = CREATEOBJECT("FormSIGPRCIC", loFormPai, lcIdChave)
*   loForm.Show()
*   par_loForm1    = form pai (objeto) - DataSession compartilhada
*   par_lcIdChave1 = pkChaves do programa a ter icone alterado
*==============================================================================

DEFINE CLASS FormSIGPRCIC AS FormBase

    *-- Propriedades visuais (popup modal pequeno, identico ao legado)
    Height      = 496
    Width       = 469
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
    DataSession  = 1
    WindowType   = 1
    ClipControls = .F.

    *-- Propriedades customizadas herdadas do legado (RESERVED3)
    *-- pkChaves do programa cujo icone sera alterado
    pcIdChaves = ""
    *-- Referencia ao form pai (compartilhamento de DataSession)
    poForm1    = .NULL.

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        LPARAMETERS par_loForm1, par_lcIdChave1

        *-- Armazenar parametros ANTES de DODEFAULT() para que InicializarForm
        *-- tenha acesso ao form pai e a chave do programa
        IF VARTYPE(par_loForm1) = "O"
            THIS.poForm1 = par_loForm1
            *-- Compartilhar datasession com form pai: cursores crProg1/crProg2/crSigSyIco1
            *-- so existem na datasession do pai (critico para grid e REPLACE funcionarem)
            THIS.DataSessionId = par_loForm1.DataSessionId
        ELSE
            THIS.poForm1 = THIS
        ENDIF

        IF VARTYPE(par_lcIdChave1) = "C"
            THIS.pcIdChaves = ALLTRIM(par_lcIdChave1)
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Caption com acentos via CHR() (literal acentuado proibido em .prg)
            THIS.Caption = "Escolha de " + CHR(205) + "cones"

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCICBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SIGPRCICBO", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Carregar descricao do programa a partir de crProg2
            IF !EMPTY(THIS.pcIdChaves)
                THIS.this_oBusinessObject.CarregarPorChave(THIS.pcIdChaves)
            ENDIF

            *-- Guard para validacao UI sem conexao SQL
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ENDIF

            *-- Configurar picture de fundo do form
            THIS.ConfigurarPageFrame()

            *-- Configurar cabecalho cinza (cntSombra do legado)
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Configurar controles principais: grid de icones, preview, label, textbox
            THIS.ConfigurarPaginaLista()

            *-- Vincular eventos adicionais do grid (BeforeRowColChange)
            THIS.ConfigurarPaginaDados()

            *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis()

            *-- Carregar dados: vincular grid ao cursor e posicionar no icone atual
            THIS.CarregarDados()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSIGPRCIC: " + loc_oErro.Message + ;
                    " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
    *==========================================================================
        LOCAL loc_cImgFundo
        *-- Form OPERACIONAL flat (sem PageFrame) - configura picture de fundo
        loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF
        *-- Manter dimensoes originais do popup (469x496) - NAO reescalonar para 1000x600
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        LOCAL loc_nW
        loc_nW = THIS.Width

        *-- Container cabecalho cinza (cntSombra do legado)
        *-- Posicao: Top=0, Left=0, largura total do form, Height=80
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = loc_nW
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            *-- Label sombra (deslocada 1px para efeito de profundidade, texto escuro)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .Width     = loc_nW
                .Height    = 40
                .Top       = 18
                .Left      = 10
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH

            *-- Label titulo (branco sobre cinza)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Width     = loc_nW
                .Height    = 46
                .Top       = 17
                .Left      = 10
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH
        ENDWITH
        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis
    *==========================================================================
        LPARAMETERS par_oContainer
        LOCAL loc_oContainer, loc_i, loc_oControl

        IF VARTYPE(par_oContainer) = "O"
            loc_oContainer = par_oContainer
        ELSE
            loc_oContainer = THIS
        ENDIF

        FOR loc_i = 1 TO loc_oContainer.ControlCount
            loc_oControl = loc_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    IF !INLIST(LOWER(loc_oControl.Name), "cnt_4c_cabecalho", "img_4c_icone")
                        loc_oControl.Visible = .T.
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE KeyPress
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 27
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
    *==========================================================================
        LOCAL loc_oGrd

        *-- Grid de icones (Grid1 do legado)
        THIS.AddObject("grd_4c_Dados", "Grid")
        THIS.grd_4c_Dados.ColumnCount = 1
        WITH THIS.grd_4c_Dados
            .Top               = 131
            .Left              = 10
            .Width             = 242
            .Height            = 345
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .HeaderHeight      = 15
            .RowHeight         = 15
            .LinkMaster        = ""
            .RelationalExpr    = ""

            .FontName = "Courier New"
            .SetAll("FontName",   "Tahoma",      "Header")
            .SetAll("FontName",   "Courier New", "TextBox")
            .FontSize = 9
            .SetAll("FontSize",    8,             "Header")
            .SetAll("FontSize",    9,             "TextBox")
            .SetAll("Format",     "K",            "Column")
            .SetAll("Format",     "K",            "TextBox")
            .SetAll("Movable",    .F.,            "Column")
            .SetAll("ReadOnly",   .T.,            "Column")
            .SetAll("ReadOnly",   .T.,            "TextBox")
            .SetAll("Resizable",  .F.,            "Column")
            .Column1.Resizable = .T.
            .SetAll("Alignment",   3,             "Column")
            .SetAll("Alignment",   3,             "TextBox")
            .SetAll("Alignment",   2,             "Header")
            .SetAll("BorderStyle", 0,             "TextBox")
            .SetAll("Margin",      0,             "TextBox")
            .SetAll("Visible",    .T.,            "TextBox")

            .Column1.Width              = 211
            .Column1.Header1.Caption    = CHR(205) + "cones"
            .Column1.Header1.FontName   = "Tahoma"
            .Column1.Header1.FontSize   = 8
            .Column1.Header1.Alignment  = 2
            .Column1.Header1.ForeColor  = RGB(90, 90, 90)
        ENDWITH

        BINDEVENT(THIS.grd_4c_Dados,               "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Dados,               "Scrolled",          THIS, "GrdDadosScrolled")
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "DblClick",  THIS, "GrdText1DblClick")
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdText1KeyPress")

        *-- Moldura decorativa para area de preview (Shape1 do legado)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 184
            .Left        = 276
            .Width       = 169
            .Height      = 169
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        *-- Imagem de preview do icone selecionado (Icone do legado)
        THIS.AddObject("img_4c_Icone", "Image")
        WITH THIS.img_4c_Icone
            .Stretch = 1
            .Height  = 156
            .Left    = 282
            .Top     = 200
            .Width   = 156
            .Visible = .F.
        ENDWITH

        *-- Label "Programa" (Say2 do legado)
        THIS.AddObject("lbl_4c_Programa", "Label")
        WITH THIS.lbl_4c_Programa
            .Caption   = "Programa"
            .Left      = 12
            .Top       = 86
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- TextBox descricao do programa (Text1 do legado - somente leitura)
        THIS.AddObject("txt_4c_Descricao", "TextBox")
        WITH THIS.txt_4c_Descricao
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Height      = 24
            .Left        = 9
            .Top         = 103
            .Width       = 457
            .ForeColor   = RGB(90, 90, 90)
            .ReadOnly    = .T.
            .Value       = ""
            .BorderStyle = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
    *==========================================================================
        *-- Fase 5: completa configuracao do painel de preview (area direita)
        *-- e vincula BeforeRowColChange para manter preview sincronizado
        *-- enquanto o usuario navega ANTES da linha mudar (comportamento do legado)

        *-- BeforeRowColChange: atualiza preview ao iniciar movimento de linha
        *-- O legado tinha AfterRowColChange E BeforeRowColChange (identicos)
        BINDEVENT(THIS.grd_4c_Dados, "BeforeRowColChange", THIS, "GrdDadosBeforeRowColChange")

        *-- Garantir estado inicial correto do preview de icone
        WITH THIS.img_4c_Icone
            .Visible  = .F.
            .Picture  = ""
            .Stretch  = 1
        ENDWITH

        *-- Garantir estado inicial correto da moldura decorativa
        WITH THIS.shp_4c_Shape1
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDados
    *==========================================================================
        LOCAL loc_cArqIcone
        loc_cArqIcone = ""

        *-- Preencher descricao do programa no TextBox
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cPrograma
            loc_cArqIcone = PADR(LOWER(ALLTRIM(THIS.this_oBusinessObject.this_cArqIconeAtual)), 64)
        ENDIF

        *-- Fallback: se barrapict vazio, usar JustFname(pkChaves) como nome do icone
        *-- (replica logica do Init original do SCX legado)
        IF EMPTY(ALLTRIM(loc_cArqIcone)) AND !EMPTY(THIS.pcIdChaves)
            loc_cArqIcone = PADR(LOWER(ALLTRIM(JUSTFNAME(THIS.pcIdChaves))), 64)
        ENDIF

        *-- Configurar grid com cursor crSigSyIco1 da datasession compartilhada
        IF USED("crSigSyIco1")
            SET ORDER TO "carqicones" IN crSigSyIco1

            IF !EMPTY(loc_cArqIcone)
                IF !SEEK(loc_cArqIcone, "crSigSyIco1", "carqicones")
                    GO TOP IN crSigSyIco1
                ENDIF
            ELSE
                GO TOP IN crSigSyIco1
            ENDIF

            THIS.grd_4c_Dados.RecordSource = "crSigSyIco1"
            WITH THIS.grd_4c_Dados
                .Column1.ControlSource = "crSigSyIco1.carqicones"
                .Refresh()
            ENDWITH

            THIS.AtualizarPreviewIcone()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AtualizarPreviewIcone
    *==========================================================================
        LOCAL loc_cArqIcone
        loc_cArqIcone = ""

        IF USED("crSigSyIco1") AND !EOF("crSigSyIco1")
            loc_cArqIcone = ALLTRIM(crSigSyIco1.ctmpicones)
        ENDIF

        IF !EMPTY(loc_cArqIcone) AND FILE(loc_cArqIcone)
            THIS.img_4c_Icone.Picture = loc_cArqIcone
            THIS.img_4c_Icone.Visible = .T.
        ELSE
            THIS.img_4c_Icone.Visible = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE AlternarPagina
    *==========================================================================
        LPARAMETERS par_nPagina
        *-- Form flat sem PageFrame - alternancia de paginas nao se aplica
    ENDPROC

    *-- -----------------------------------------------------------------------
    *-- Handlers de eventos do Grid (PUBLIC - obrigatorio para BINDEVENT)
    *-- -----------------------------------------------------------------------

    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange
    *==========================================================================
        LPARAMETERS par_nColIndex
        THIS.AtualizarPreviewIcone()
    ENDPROC

    *==========================================================================
    PROCEDURE GrdDadosScrolled
    *==========================================================================
        LPARAMETERS par_nDirection
        THIS.AtualizarPreviewIcone()
    ENDPROC

    *==========================================================================
    PROCEDURE GrdDadosBeforeRowColChange
    *==========================================================================
        LPARAMETERS par_nColIndex
        THIS.AtualizarPreviewIcone()
    ENDPROC

    *==========================================================================
    PROCEDURE GrdText1DblClick
    *==========================================================================
        THIS.SelecionarIconeAtual()
    ENDPROC

    *==========================================================================
    PROCEDURE GrdText1KeyPress
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13
            THIS.SelecionarIconeAtual()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE SelecionarIconeAtual
    *==========================================================================
        LOCAL loc_cArqIcone
        loc_cArqIcone = ""

        IF USED("crSigSyIco1") AND !EOF("crSigSyIco1")
            loc_cArqIcone = ALLTRIM(crSigSyIco1.carqicones)
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.SelecionarIcone(loc_cArqIcone)
        ENDIF

        THIS.Release()
    ENDPROC

    *-- -----------------------------------------------------------------------
    *-- Eventos principais dos botoes (mapeados para acoes do seletor de icones)
    *-- Popup modal SEM botoes CRUD no legado; metodos existem para satisfazer
    *-- contrato da arquitetura e permitir integracao/testes automatizados.
    *-- Cada acao replica logica real do formulario:
    *--   Incluir/Alterar -> confirma icone selecionado (equivalente ao DblClick)
    *--   Visualizar      -> forca refresh do preview do icone corrente
    *--   Excluir         -> limpa vinculo de icone (equivalente a "< nenhum >")
    *-- -----------------------------------------------------------------------

    *==========================================================================
    PROCEDURE BtnIncluirClick
    *==========================================================================
        *-- Confirma icone corrente do grid e fecha o picker (equivalente ao
        *-- DblClick sobre o icone selecionado). Sem selecao valida, apenas
        *-- posiciona no primeiro registro do cursor de icones.
        IF USED("crSigSyIco1")
            IF EOF("crSigSyIco1") OR BOF("crSigSyIco1")
                GO TOP IN crSigSyIco1
                THIS.grd_4c_Dados.Refresh()
                THIS.AtualizarPreviewIcone()
                RETURN
            ENDIF
            THIS.SelecionarIconeAtual()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick
    *==========================================================================
        *-- Alterar tem semantica identica a Incluir neste picker: substitui o
        *-- icone atual do programa pelo icone posicionado no grid.
        IF USED("crSigSyIco1")
            IF EOF("crSigSyIco1") OR BOF("crSigSyIco1")
                GO TOP IN crSigSyIco1
                THIS.grd_4c_Dados.Refresh()
                THIS.AtualizarPreviewIcone()
                RETURN
            ENDIF
            THIS.SelecionarIconeAtual()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick
    *==========================================================================
        *-- Forca refresh do preview do icone posicionado (mesma logica do
        *-- AfterRowColChange). Util quando o grid re-renderiza mas o preview
        *-- fica dessincronizado (ex: apos scroll rapido).
        IF USED("crSigSyIco1") AND !EOF("crSigSyIco1")
            THIS.grd_4c_Dados.Refresh()
            THIS.AtualizarPreviewIcone()
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick
    *==========================================================================
        *-- Limpa o vinculo de icone do programa (equivalente a selecionar
        *-- "< nenhum >" no grid do legado). O BO grava string vazia em
        *-- barrapict e mantem barraforms, fechando o picker em seguida.
        LOCAL loc_lConfirma
        loc_lConfirma = MsgConfirma("Remover o " + CHR(237) + "cone atual do programa?", ;
                                    "Confirma" + CHR(231) + CHR(227) + "o")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.SelecionarIcone("")
        ENDIF

        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick
    *==========================================================================
        *-- Reposiciona o grid no icone atualmente vinculado ao programa.
        *-- Util quando o usuario navega e quer voltar ao icone original.
        LOCAL loc_cArqIcone
        loc_cArqIcone = ""

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cArqIcone = PADR(LOWER(ALLTRIM(THIS.this_oBusinessObject.this_cArqIconeAtual)), 64)
        ENDIF

        IF USED("crSigSyIco1")
            IF !EMPTY(ALLTRIM(loc_cArqIcone))
                IF !SEEK(loc_cArqIcone, "crSigSyIco1", "carqicones")
                    GO TOP IN crSigSyIco1
                ENDIF
            ELSE
                GO TOP IN crSigSyIco1
            ENDIF
            THIS.grd_4c_Dados.Refresh()
            THIS.AtualizarPreviewIcone()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick
    *==========================================================================
        *-- Fecha o picker sem selecionar icone (equivalente a ESC/Cancelar).
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick
    *==========================================================================
        *-- Confirma o icone posicionado no grid e persiste a selecao.
        *-- Equivalente ao DblClick/Enter sobre a linha do grid.
        IF USED("crSigSyIco1")
            IF EOF("crSigSyIco1") OR BOF("crSigSyIco1")
                GO TOP IN crSigSyIco1
                THIS.grd_4c_Dados.Refresh()
                THIS.AtualizarPreviewIcone()
                RETURN
            ENDIF
            THIS.SelecionarIconeAtual()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick
    *==========================================================================
        *-- Fecha o picker sem confirmar selecao de icone.
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE FormParaBO
    *==========================================================================
        *-- Sincroniza o icone posicionado no grid com as propriedades do BO.
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        LOCAL loc_cArqIcone
        loc_cArqIcone = ""

        IF USED("crSigSyIco1") AND !EOF("crSigSyIco1")
            loc_cArqIcone = LOWER(ALLTRIM(crSigSyIco1.carqicones))
            IF loc_cArqIcone == "< nenhum >"
                loc_cArqIcone = ""
            ENDIF
        ENDIF

        THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone
        THIS.this_oBusinessObject.this_cIdChaves = THIS.pcIdChaves
    ENDPROC

    *==========================================================================
    PROCEDURE BOParaForm
    *==========================================================================
        *-- Atualiza o TextBox de descricao do programa a partir do BO.
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
            THIS.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cPrograma
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos
    *==========================================================================
        LPARAMETERS par_lHabilitar
        *-- Form picker modal: txt_4c_Descricao e sempre ReadOnly (identico ao legado).
        *-- Nao ha campos editaveis para alternar por modo.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LimparCampos
    *==========================================================================
        *-- Reseta o TextBox de descricao e oculta o preview do icone.
        IF PEMSTATUS(THIS, "txt_4c_Descricao", 5)
            THIS.txt_4c_Descricao.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "img_4c_Icone", 5)
            THIS.img_4c_Icone.Visible = .F.
            THIS.img_4c_Icone.Picture = ""
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista
    *==========================================================================
        *-- Carrega (ou recarrega) a lista de icones no grid.
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo
    *==========================================================================
        LPARAMETERS par_cModo
        *-- Form picker flat sem modos CRUD (sem CommandGroups para ajustar).
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        THIS.poForm1 = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
