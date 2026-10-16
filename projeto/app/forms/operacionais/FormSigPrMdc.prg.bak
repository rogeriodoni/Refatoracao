*==============================================================================
* FormSigPrMdc.prg - Muda Conta (substituicao de codigo de conta/cliente em
* lote, com opcao de trocar apenas o campo ContaVens dos representantes ou
* processar todas as tabelas que referenciam o codigo)
* Equivalente ao SIGPRMDC.SCX do legado
* Tipo: OPERACIONAL (layout proprio, sem PageFrame)
* Herda de FormBase
*==============================================================================
* FASE 4: Grid e Botoes CRUD
*
* FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES. O legado NAO eh um cadastro CRUD:
* herda de `form` (nao de `frmcadastro`), nao tem Grupo_Op nem pcEscolha, e os
* cinco botoes dele sao btnIncluir / btnExcluir / Exporta / btnProcessar /
* btnSair. Os dois primeiros NAO sao a barra CRUD: sao a toolbar de LINHA da
* grade - btnIncluir.Click do SCX eh "Select cursor_4c_Contas / If !Empty(ContaAnt) And
* !Empty(ContaNov) / Append Blank / Endif / ThisForm.Grade.Refresh /
* ThisForm.Grade.Column1.Text1.SetFocus" (acrescenta UMA LINHA ao cursor local
* que alimenta a Grade, sem tabela e sem SQL) e btnExcluir.Click eh "Select
* cursor_4c_Contas / Delete / ThisForm.Grade.Refresh / ...". Logo NAO existe
* BtnAlterarClick nem BtnVisualizarClick: inventa-los violaria o PILAR 1 ("NUNCA
* inventar botao que o legado nao tem") e criar os dois vazios violaria a regra
* de completude. Handlers entregues, um por botao do legado:
*   - BtnIncluirClick   -> btnIncluir.Click   (APPEND BLANK guardado pelo par completo)
*   - BtnExcluirClick   -> btnExcluir.Click   (DELETE da linha corrente)
*   - BtnExportaClick   -> Exporta.Click      (IMPORTA planilha XLS - nome legado)
*   - BtnProcessarClick -> btnProcessar.Click (troca em lote / so representantes)
*   - BtnSairClick      -> btnSair.Click      (ThisForm.Release)
* Todos PUBLIC (regra #3/#51: BINDEVENT e chamada externa falham em PROTECTED) e
* ligados por BINDEVENT em ConfigurarBotoes(). O DELETE local da grade depende do
* `SET DELETED ON` reposto em InicializarForm (regra #9.4: DataSession = 2 nasce
* no default do VFP e nao herda o SET do config.prg).
*==============================================================================

DEFINE CLASS FormSigPrMdc AS FormBase

    Width       = 800
    Height      = 340
    Caption     = "Muda Conta"
    ShowWindow  = 1
    WindowType  = 1
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    AutoCenter  = .T.
    BorderStyle = 2
    Themes      = .F.
    DataSession = 2
    KeyPreview  = .T.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Flag de controle (legado: Lparameters pCheckCad / ThisForm.Checkcadpro)
    this_lCheckCadPro = .F.

    *-- Caminho do ArqDBF (tabela FoxPro de catalogo de campos usada no
    *-- processamento em lote)
    this_cArqDBFPath = ""

    *-- Estado da tela. O legado NAO tem pcEscolha (nao herda de frmcadastro e
    *-- nao tem modos CRUD): os unicos dois estados reais sao "EDICAO" (usuario
    *-- monta a lista de pares) e "PROCESSANDO" (SCAN multi-tabela em curso, com
    *-- grade e botoes travados). AjustarBotoesPorModo eh o funil desses dois.
    this_cModoAtual = "EDICAO"

    *==========================================================================
    * Init - Legado: "Lparameters pCheckCad / ThisForm.Checkcadpro = pCheckCad".
    * O parametro vem de quem abre a tela e decide se os codigos digitados sao
    * conferidos contra SigCdCli: com .T. o lookup da coluna "Conta Antiga" eh
    * pulado e a importacao de planilha aceita conta que nao existe no cadastro.
    * Tem de ser atribuido ANTES do DODEFAULT: eh dentro dele que FormBase.Init
    * chama InicializarForm, que ja leva o valor para o BO via FormParaBO.
    *==========================================================================
    PROCEDURE Init(par_lCheckCad)
    *==========================================================================
        THIS.this_lCheckCadPro = IIF(VARTYPE(par_lCheckCad) = "L", par_lCheckCad, .F.)

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cArquivo
        loc_lSucesso = .F.

        TRY
            THIS.ConfigurarPageFrame()

            *-- DataSession=2 nasce no default do VFP (regra #9.4 / DELETED e
            *-- EXACT nao herdam o SET DELETED ON do config.prg): sem isto o
            *-- DELETE local em cursor_4c_Contas nao some da grade em BtnExcluirClick
            SET DELETED ON

            *-- Legado: primeira linha do Load eh "=fConfigGeral()" (carrega os
            *-- parametros gerais do sistema que o processamento consome).
            *-- Wrapper portado em projeto\app\utils\fconfiggeral.prg
            TRY
                = fConfigGeral()
            CATCH TO loc_oErro
                MsgAviso("Falha ao carregar a configura" + CHR(231) + CHR(227) + ;
                    "o geral: " + loc_oErro.Message, "Aten" + CHR(231) + CHR(227) + "o")
            ENDTRY

            *-- Verificar existencia do ArqDBF (catalogo de campos do
            *-- processamento em lote): aviso informativo, nao bloqueia o Init
            loc_cArquivo = SYS(5) + SYS(2003) + "\ArqDBF"
            IF FILE(loc_cArquivo + ".dbf")
                THIS.this_cArqDBFPath = loc_cArquivo
            ELSE
                MsgAviso("O ArqDBF n" + CHR(227) + "o est" + CHR(225) + " no diret" + CHR(243) + "rio do Sistema!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrMdcBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrMdcBO.", "Erro InicializarForm")
            ELSE
                IF !THIS.this_oBusinessObject.InicializarCursorContas()
                    MsgErro("Falha ao inicializar cursor de substitui" + CHR(231) + CHR(245) + "es.", ;
                        "Erro InicializarForm")
                ELSE
                    THIS.ConfigurarCabecalho()
                    THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                    THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                    THIS.ConfigurarBotoes()
                    THIS.ConfigurarGrid()
                    THIS.ConfigurarCheckboxes()
                    THIS.ConfigurarPainelResultado()
                    THIS.ConfigurarTabIndex()

                    THIS.TornarControlesVisiveis(THIS)

                    *-- Pintura inicial da grade pelo mesmo funil usado pelos
                    *-- demais caminhos (cursor ja populado por
                    *-- InicializarCursorContas, chamado acima)
                    THIS.CarregarLista("TOPO")

                    *-- Estado inicial pelo funil: aplica tambem a dependencia do
                    *-- Chk_DelCT.When do legado (so clicavel com chkReps = 0)
                    THIS.this_cModoAtual = "EDICAO"
                    THIS.AjustarBotoesPorModo()

                    *-- Sincroniza o BO com o estado inicial da tela (os dois
                    *-- flags de processamento, CheckCadPro e o caminho do ArqDBF)
                    THIS.FormParaBO()

                    *-- Legado: "ThisForm.Grade.Column1.SetFocus" no fim do Init.
                    *-- O Init roda ANTES do Show, entao a janela ainda pode nao
                    *-- estar visivel e o VFP9 recusa o foco ("Cannot SetFocus to
                    *-- an invisible or disabled object"). Falhar aqui eh inocuo -
                    *-- o foco certo vem do TabIndex = 1 da grade - e NAO deve
                    *-- abrir dialogo de erro na abertura da tela
                    TRY
                        THIS.grd_4c_Dados.Column1.SetFocus
                    CATCH TO loc_oErro
                        *-- foco inicial indisponivel antes do Show: ignorado de
                        *-- proposito (TabIndex = 1 ja poe o cursor na grade)
                    ENDTRY

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro InicializarForm FormSigPrMdc")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado), com os
    * dois labels empilhados (lblSombra = sombra / lblTitulo = texto visivel)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        LOCAL loc_oErro

        TRY
            *-- Container do cabecalho (cntSombra do legado)
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- Label sombra - efeito de sombra no titulo (lblSombra do legado)
            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.cnt_4c_Sombra.Width
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            *-- Label titulo - texto visivel sobre a sombra (lblTitulo do legado)
            THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
            WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
                .AutoSize    = .F.
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = THIS.Caption
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.cnt_4c_Sombra.Width
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo"
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarCabecalho FormSigPrMdc")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Molduras decorativas (Commandgroup1/3 do legado, sem
    * botoes internos - ButtonCount=0 no SCX) + os 5 CommandButtons standalone
    * (btnIncluir/btnExcluir/Exporta/btnProcessar/btnSair do legado), todos
    * filhos diretos do form, posicionados sobre as molduras
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
    *==========================================================================
        LOCAL loc_oErro

        TRY
            *-- Moldura decorativa em volta de Incluir/Excluir/Importar/Processar
            THIS.AddObject("obj_4c_Commandgroup1", "Container")
            WITH THIS.obj_4c_Commandgroup1
                .Top         = 8
                .Left        = 329
                .Width       = 331
                .Height      = 110
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- Moldura decorativa em volta do Sair/Encerrar
            THIS.AddObject("obj_4c_Commandgroup3", "Container")
            WITH THIS.obj_4c_Commandgroup3
                .Top         = 8
                .Left        = 703
                .Width       = 90
                .Height      = 110
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnIncluir", "CommandButton")
            WITH THIS.cmd_4c_BtnIncluir
                .Top        = 3
                .Left       = 425
                .Width      = 80
                .Height     = 100
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .MousePointer = 15
                .Themes           = .T.
                .Caption    = "\<Incluir"
                .Picture    = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnExcluir", "CommandButton")
            WITH THIS.cmd_4c_BtnExcluir
                .Top        = 3
                .Left       = 500
                .Width      = 80
                .Height     = 100
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .MousePointer = 15
                .Themes           = .T.
                .Caption    = "\<Excluir"
                .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Exporta", "CommandButton")
            WITH THIS.cmd_4c_Exporta
                .Top        = 3
                .Left       = 575
                .Width      = 80
                .Height     = 100
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .MousePointer = 15
                .Themes           = .T.
                .Caption    = "I\<mportar"
                .Picture    = gc_4c_CaminhoIcones + "geral_multiplos_60.jpg"
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnProcessar", "CommandButton")
            WITH THIS.cmd_4c_BtnProcessar
                .Top        = 3
                .Left       = 650
                .Width      = 80
                .Height     = 100
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .MousePointer = 15
                .Themes           = .T.
                .Caption    = "\<Processar"
                .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
            WITH THIS.cmd_4c_BtnSair
                .Top        = 3
                .Left       = 725
                .Width      = 80
                .Height     = 100
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .MousePointer = 15
                .Themes           = .T.
                .Caption    = "Encerrar"
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Visible    = .T.
            ENDWITH

            BINDEVENT(THIS.cmd_4c_BtnIncluir,   "Click", THIS, "BtnIncluirClick")
            BINDEVENT(THIS.cmd_4c_BtnExcluir,   "Click", THIS, "BtnExcluirClick")
            BINDEVENT(THIS.cmd_4c_Exporta,      "Click", THIS, "BtnExportaClick")
            BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "BtnProcessarClick")
            BINDEVENT(THIS.cmd_4c_BtnSair,      "Click", THIS, "BtnSairClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarBotoes FormSigPrMdc")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grade de pares Conta Antiga/Conta Nova (Grade do legado),
    * ligada ao cursor cursor_4c_Contas criado por SigPrMdcBO.InicializarCursorContas()
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
    *==========================================================================
        LOCAL loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top                = 111
                .Left               = 170
                .Width              = 213
                .Height             = 201
                .ColumnCount        = 2
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .HeaderHeight       = 18
                .RowHeight          = 18
                .ScrollBars         = 2
                .FontName           = "Tahoma"
                .FontSize           = 8
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(90, 90, 90)
                .RecordSource       = "cursor_4c_Contas"

                WITH .Column1
                    .ControlSource = "cursor_4c_Contas.ContaAnt"
                    .Width         = 90
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Conta Antiga"
                        .ForeColor = RGB(0, 0, 0)
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                WITH .Column2
                    .ControlSource = "cursor_4c_Contas.ContaNov"
                    .Width         = 90
                    WITH .Header1
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .Alignment = 2
                        .Caption   = "Conta Nova"
                        .ForeColor = RGB(0, 0, 0)
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .Margin      = 0
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                    ENDWITH
                ENDWITH

                .Visible = .T.
            ENDWITH

            BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "TxtContaAntKeyPress")
            BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "TxtContaNovKeyPress")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarGrid FormSigPrMdc")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCheckboxes - Chk_DelCT (apagar conta antiga) e chkReps (trocar
    * so representantes) do legado. AutoSize=.T. no SCX e no-op em CheckBox
    * criado por AddObject - Width/Height ja sao os valores auto-calculados
    * pelo Form Designer, transcritos literalmente.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCheckboxes()
    *==========================================================================
        LOCAL loc_oErro

        TRY
            THIS.AddObject("chk_4c_Chk_DelCT", "CheckBox")
            WITH THIS.chk_4c_Chk_DelCT
                .Top       = 278
                .Left      = 393
                .Width     = 190
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Apagar a Conta Antiga do Cadastro"
                .Value     = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("chk_4c_ChkReps", "CheckBox")
            WITH THIS.chk_4c_ChkReps
                .Top       = 297
                .Left      = 393
                .Width     = 168
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Trocar Apenas Representantes"
                .Value     = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            BINDEVENT(THIS.chk_4c_ChkReps, "Click", THIS, "ChkRepsClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarCheckboxes FormSigPrMdc")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPainelResultado - Painel de progresso (cntResult do legado),
    * oculto por padrao (regra containers flutuantes) e exibido so durante
    * BtnProcessarClick
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPainelResultado()
    *==========================================================================
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Result", "Container")
            WITH THIS.cnt_4c_Result
                .Top           = 112
                .Left          = 393
                .Width         = 237
                .Height        = 146
                .SpecialEffect = 0
                .BackStyle     = 1
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .F.
            ENDWITH

            THIS.cnt_4c_Result.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.cnt_4c_Result.lbl_4c_Label5
                .Top       = 9
                .Left      = 7
                .Width     = 110
                .Height    = 14
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Arquivo/Campo :"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            THIS.cnt_4c_Result.AddObject("txt_4c_Arquivo", "TextBox")
            WITH THIS.cnt_4c_Result.txt_4c_Arquivo
                .Top               = 26
                .Left              = 7
                .Width             = 222
                .Height            = 24
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Enabled           = .F.
                .Format            = "K!"
                .SpecialEffect     = 1
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            THIS.cnt_4c_Result.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_Result.lbl_4c_Label1
                .Top       = 100
                .Left      = 7
                .Width     = 70
                .Height    = 14
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Progresso :"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            THIS.cnt_4c_Result.AddObject("cnt_4c_Barra", "Container")
            WITH THIS.cnt_4c_Result.cnt_4c_Barra
                .Top         = 116
                .Left        = 5
                .Width       = 224
                .Height      = 21
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Result.cnt_4c_Barra.AddObject("shp_4c_ShpBarra", "Shape")
            WITH THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra
                .Top         = 1
                .Left        = 1
                .Width       = 222
                .Height      = 19
                .BackColor   = RGB(0, 128, 255)
                .BorderColor = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Result.cnt_4c_Barra.AddObject("lbl_4c_LblPorcento", "Label")
            WITH THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento
                .Top       = 4
                .Left      = 104
                .Width     = 40
                .Height    = 14
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "0 %"
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConfigurarPainelResultado FormSigPrMdc")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarTabIndex - TabIndex eh gravavel em runtime; atribuir em ordem
    * ASCENDENTE depois de TODOS os AddObject reproduz a ordem de tabulacao do
    * legado (Grade primeiro - mesmo foco inicial do Init legado - depois a
    * barra de botoes esquerda->direita, depois os checkboxes de cima->baixo)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarTabIndex()
    *==========================================================================
        THIS.grd_4c_Dados.TabIndex        = 1
        THIS.cmd_4c_BtnIncluir.TabIndex    = 2
        THIS.cmd_4c_BtnExcluir.TabIndex    = 3
        THIS.cmd_4c_Exporta.TabIndex       = 4
        THIS.cmd_4c_BtnProcessar.TabIndex  = 5
        THIS.cmd_4c_BtnSair.TabIndex       = 6
        THIS.chk_4c_Chk_DelCT.TabIndex     = 7
        THIS.chk_4c_ChkReps.TabIndex       = 8
    ENDPROC

    *==========================================================================
    * CarregarLista - FUNIL UNICO de (re)vinculo e repintura da grade de pares.
    * Popular/alterar o cursor NAO repinta a grade sozinho: o legado fecha todo
    * caminho que mexe em cursor_4c_Contas com Grade.Refresh (btnIncluir/btnExcluir/
    * Exporta/btnProcessar). Centralizado aqui para que nenhum caminho fique
    * sem repintura - os Valid de Column1/Column2.Text1 do legado faziam
    * REPLACE no cursor e dependiam da repintura da grade para o valor
    * resolvido aparecer na celula.
    *
    * Reaplica ControlSource/Width/Header1.Caption DEPOIS do RecordSource:
    * atribuir RecordSource recalcula as larguras para o default 90 e zera os
    * captions para "Header1" (Problema 48), entao a apresentacao canonica tem
    * de ser restaurada no MESMO lugar, na ordem RecordSource -> ControlSource
    * -> Width -> Header1.Caption.
    *
    * ColumnCount NAO eh reatribuido aqui: qualquer atribuicao a ColumnCount
    * recria os objetos Column e derrubaria os BINDEVENT instalados em
    * Column1.Text1/Column2.Text1 por ConfigurarGrid (os lookups de celula).
    *
    * par_cPosicao reproduz o posicionamento de CADA caminho do legado:
    *   "TOPO" -> Go Top  (reset do lote em btnProcessar.Click)
    *   "FIM"  -> Go Bott (fim da importacao de planilha, Exporta.Click)
    *   ""     -> mantem o registro corrente (btnIncluir/btnExcluir/Valid, que
    *             no legado chamam Grade.Refresh sem reposicionar - um Go Top
    *             indevido tiraria o foco da linha recem-incluida)
    *==========================================================================
    PROCEDURE CarregarLista(par_cPosicao)
    *==========================================================================
        LOCAL loc_lSucesso, loc_cPos, loc_oGrid, loc_oErro
        loc_lSucesso = .F.

        loc_cPos = IIF(VARTYPE(par_cPosicao) = "C", UPPER(ALLTRIM(par_cPosicao)), "")

        TRY
            *-- Cursor ausente (form reaberto / alias fechado por outro fluxo):
            *-- recriar pelo BO, que eh quem detem a estrutura e os indices
            IF !USED("cursor_4c_Contas")
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.InicializarCursorContas()
                ENDIF
            ENDIF

            IF USED("cursor_4c_Contas")
                loc_oGrid = THIS.grd_4c_Dados

                loc_oGrid.RecordSource = "cursor_4c_Contas"

                loc_oGrid.Column1.ControlSource   = "cursor_4c_Contas.ContaAnt"
                loc_oGrid.Column1.Width           = 90
                loc_oGrid.Column1.Header1.Caption = "Conta Antiga"

                loc_oGrid.Column2.ControlSource   = "cursor_4c_Contas.ContaNov"
                loc_oGrid.Column2.Width           = 90
                loc_oGrid.Column2.Header1.Caption = "Conta Nova"

                SELECT cursor_4c_Contas
                DO CASE
                    CASE loc_cPos == "TOPO"
                        GO TOP
                    CASE loc_cPos == "FIM"
                        GO BOTTOM
                ENDCASE

                loc_oGrid.Refresh
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro CarregarLista FormSigPrMdc")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Acrescenta uma linha vazia ao cursor de pares (so se o
    * ultimo par ja estiver completo), e foca a primeira coluna da nova linha
    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *==========================================================================
        LOCAL loc_oErro, loc_nRec

        TRY
            loc_nRec = 0

            IF USED("cursor_4c_Contas")
                SELECT cursor_4c_Contas
                IF !EMPTY(ALLTRIM(NVL(ContaAnt, ""))) AND !EMPTY(ALLTRIM(NVL(ContaNov, "")))
                    APPEND BLANK
                ENDIF
                *-- O legado fecha com "Grade.Refresh", que NAO move o ponteiro:
                *-- depois do APPEND BLANK ele fica na linha NOVA, e eh nela que o
                *-- SetFocus abaixo poe o usuario para digitar. CarregarLista
                *-- reatribui o RecordSource, e isso devolve o ponteiro ao registro
                *-- 1 (medido no VFP9) - sem guardar/repor o RECNO o usuario clica
                *-- Incluir e cai na PRIMEIRA linha, ja preenchida, em vez da nova.
                *-- Vale nos dois ramos: quando a guarda acima bloqueia o APPEND, o
                *-- legado tambem deixa o ponteiro onde estava.
                loc_nRec = RECNO()
            ENDIF

            THIS.CarregarLista("")

            IF loc_nRec > 0 AND USED("cursor_4c_Contas")
                SELECT cursor_4c_Contas
                IF BETWEEN(loc_nRec, 1, RECCOUNT())
                    GO loc_nRec
                ENDIF
            ENDIF

            THIS.grd_4c_Dados.Column1.Text1.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao incluir linha")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Remove a linha corrente do cursor de pares
    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *==========================================================================
        LOCAL loc_oErro, loc_nRec

        TRY
            loc_nRec = 0

            IF USED("cursor_4c_Contas")
                SELECT cursor_4c_Contas
                IF !EOF()
                    DELETE
                ENDIF
                *-- Mesma razao do BtnIncluirClick: o "Grade.Refresh" do legado
                *-- nao move o ponteiro, mas CarregarLista reatribui o
                *-- RecordSource e o devolve ao registro 1. Repor o RECNO mantem
                *-- o usuario na vizinhanca da linha que ele acabou de apagar
                *-- (com SET DELETED ON a propria linha apagada ja nao eh
                *-- navegavel, e a grade passa a mostrar a seguinte)
                loc_nRec = RECNO()
            ENDIF

            THIS.CarregarLista("")

            IF loc_nRec > 0 AND USED("cursor_4c_Contas")
                SELECT cursor_4c_Contas
                IF BETWEEN(loc_nRec, 1, RECCOUNT())
                    GO loc_nRec
                ENDIF
            ENDIF

            THIS.grd_4c_Dados.Column1.Text1.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir linha")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSairClick - Encerra o form (btnSair.Click do legado)
    *==========================================================================
    PROCEDURE BtnSairClick()
    *==========================================================================
        THIS.Release
    ENDPROC

    *==========================================================================
    * ChkRepsClick - Ligar "Trocar Apenas Representantes" desliga e desabilita
    * "Apagar a Conta Antiga do Cadastro" (chkReps.Click + Chk_DelCT.When do
    * legado: Chk_DelCT so pode ser marcado quando chkReps = 0)
    *==========================================================================
    PROCEDURE ChkRepsClick()
    *==========================================================================
        IF THIS.chk_4c_ChkReps.Value = 1
            THIS.chk_4c_Chk_DelCT.Value = 0
        ENDIF
        THIS.chk_4c_Chk_DelCT.Enabled = (THIS.chk_4c_ChkReps.Value = 0)
    ENDPROC

    *==========================================================================
    * TxtContaAntKeyPress - Lookup de conta na coluna "Conta Antiga" (Column1).
    * Legado: Valid do Column1.Text1, pulado quando this_lCheckCadPro = .T.
    *==========================================================================
    PROCEDURE TxtContaAntKeyPress
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
            RETURN
        ENDIF

        IF THIS.this_lCheckCadPro
            RETURN
        ENDIF

        THIS.ValidarCelulaConta(1)
    ENDPROC

    *==========================================================================
    * TxtContaNovKeyPress - Lookup de conta na coluna "Conta Nova" (Column2).
    * Legado: Valid do Column2.Text1, sempre executa (sem guarda de CheckCadPro)
    *==========================================================================
    PROCEDURE TxtContaNovKeyPress
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
            RETURN
        ENDIF

        THIS.ValidarCelulaConta(2)
    ENDPROC

    *==========================================================================
    * ValidarCelulaConta - Valida o codigo digitado na celula (1=ContaAnt,
    * 2=ContaNov) contra SigCdCli; achando, grava no cursor; nao achando, abre
    * o picker (FormBuscaAuxiliar) com o digitado como prefixo
    *==========================================================================
    PROCEDURE ValidarCelulaConta(par_nColuna)
    *==========================================================================
        LOCAL loc_cVal, loc_oErro, loc_oColuna, loc_cCampo

        IF par_nColuna = 1
            loc_oColuna = THIS.grd_4c_Dados.Column1
            loc_cCampo  = "ContaAnt"
        ELSE
            loc_oColuna = THIS.grd_4c_Dados.Column2
            loc_cCampo  = "ContaNov"
        ENDIF

        loc_cVal = ALLTRIM(NVL(loc_oColuna.Text1.Value, ""))

        TRY
            IF EMPTY(loc_cVal)
                SELECT cursor_4c_Contas
                REPLACE (loc_cCampo) WITH ""
            ELSE
                *-- ValidarCodigoConta devolve o CODIGO achado (string) ou "",
                *-- nunca um logico: usar o retorno direto num IF estouraria
                *-- "Operator/operand type mismatch"
                IF !EMPTY(THIS.this_oBusinessObject.ValidarCodigoConta(loc_cVal))
                    SELECT cursor_4c_Contas
                    REPLACE (loc_cCampo) WITH loc_cVal
                ELSE
                    *-- Universo vazio / codigo inexistente NAO eh erro: o legado
                    *-- nao avisa nem apaga o digitado, so abre o browse com o
                    *-- valor como prefixo (regra #50)
                    THIS.AbrirBuscaConta(par_nColuna)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar conta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaConta - Abre FormBuscaAuxiliar para selecao de conta (SigCdCli),
    * equivalente ao fwBuscaExt do Valid de Column1/Column2.Text1 do legado
    *==========================================================================
    PROCEDURE AbrirBuscaConta(par_nColuna)
    *==========================================================================
        LOCAL loc_oLookup, loc_cVal, loc_oErro, loc_oColuna, loc_cCampo

        IF par_nColuna = 1
            loc_oColuna = THIS.grd_4c_Dados.Column1
            loc_cCampo  = "ContaAnt"
        ELSE
            loc_oColuna = THIS.grd_4c_Dados.Column2
            loc_cCampo  = "ContaNov"
        ENDIF

        loc_cVal = ALLTRIM(NVL(loc_oColuna.Text1.Value, ""))

        TRY
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
                "cursor_4c_BuscaConta", "Iclis", loc_cVal, ;
                "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")

            IF VARTYPE(loc_oLookup) <> "O"
                MsgErro("Erro ao abrir busca de conta.", "Erro")
            ELSE
                loc_oLookup.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.mAddColuna("Grupos", "", "Grupo")
                loc_oLookup.Show()

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                    SELECT cursor_4c_BuscaConta
                    loc_cVal = ALLTRIM(NVL(cursor_4c_BuscaConta.Iclis, ""))
                    USE IN cursor_4c_BuscaConta

                    SELECT cursor_4c_Contas
                    REPLACE (loc_cCampo) WITH loc_cVal
                    loc_oColuna.Text1.Value = loc_cVal
                ELSE
                    IF USED("cursor_4c_BuscaConta")
                        USE IN cursor_4c_BuscaConta
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            MsgErro(loc_oErro.Message, "Erro ao buscar conta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExportaClick - Importa pares Conta Antiga/Conta Nova de planilha XLS
    * para cursor_4c_Contas (Exporta.Click do legado - nome legado, funcao de import)
    *==========================================================================
    PROCEDURE BtnExportaClick()
    *==========================================================================
        LOCAL loc_cArquivo, loc_nImportados, loc_oErro, loc_nAntes, loc_lOk

        loc_nImportados = 0
        loc_nAntes      = 0
        loc_lOk         = .F.

        TRY
            loc_cArquivo = GETFILE("XLS")

            IF EMPTY(loc_cArquivo)
                MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                    "o informado!!!", "Aviso")
            ELSE
                IF !FILE(loc_cArquivo)
                    MsgErro("O Arquivo [" + ALLTRIM(loc_cArquivo) + "]" + CHR(13) + ;
                        "N" + CHR(227) + "o Foi Encontrado ou o Acesso Foi Negado!!! Verifique!!!", "Erro")
                ELSE
                    *-- FormParaBO leva CheckCadPro (que decide se a importacao
                    *-- valida ContaAnt contra SigCdCli) e os dois checkboxes
                    THIS.FormParaBO()

                    *-- ImportarDeXLS devolve LOGICO, nao a contagem: o numero de
                    *-- pares aceitos eh a variacao do RECCOUNT do cursor, que eh
                    *-- onde o BO deduplica via TAG Duplica
                    loc_nAntes = IIF(USED("cursor_4c_Contas"), RECCOUNT("cursor_4c_Contas"), 0)

                    loc_lOk = THIS.this_oBusinessObject.ImportarDeXLS(loc_cArquivo)

                    loc_nImportados = IIF(USED("cursor_4c_Contas"), ;
                        RECCOUNT("cursor_4c_Contas") - loc_nAntes, 0)

                    *-- Legado fecha com "Go bott / Grade.Refresh"
                    THIS.CarregarLista("FIM")

                    IF loc_lOk AND loc_nImportados > 0
                        MsgInfo(TRANSFORM(loc_nImportados) + " par(es) importado(s) com sucesso.", ;
                            "Importa" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF loc_lOk
                            MsgAviso("Nenhum par v" + CHR(225) + "lido encontrado na planilha.", ;
                                "Importa" + CHR(231) + CHR(227) + "o")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro BtnExportaClick FormSigPrMdc")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Processa a troca de contas (btnProcessar.Click do
    * legado). Com chkReps=1 troca so SigCdCli.ContaVens (representantes); caso
    * contrario percorre o catalogo ArqDBF e atualiza/exclui em todos os
    * arquivos elegiveis. fRecalculaP/fRecalculaC nao portadas (regra #27 -
    * funcoes de CALCULO de saldo nunca recebem stub; recalculo omitido, igual
    * ao padrao ja adotado em Formsigprmdp.prg/sigprmdpBO.prg).
    *==========================================================================
    PROCEDURE BtnProcessarClick()
    *==========================================================================
        LOCAL loc_cMensagem, loc_oErro, loc_lOk, loc_lManual
        LOCAL loc_nErro, loc_nRec, loc_nCnt, loc_nPct
        LOCAL loc_cArq, loc_cCpo, loc_cSql, loc_cWhere, loc_lContaNovaExiste
        LOCAL loc_lReiniciar

        loc_cMensagem = ""

        *-- A conexao do projeto nasce com Transactions = 2 (MANUAL), e eh por
        *-- isso que o COMMIT/ROLLBACK abaixo tem de ser feito com SQLCOMMIT/
        *-- SQLROLLBACK do VFP e nao com "COMMIT TRANSACTION" via SQLEXEC (que
        *-- so aninharia @@TRANCOUNT sem efetivar nada). Handle invalido faz
        *-- SQLGETPROP estourar FORA de TRY - dai a guarda, senao o usuario
        *-- veria o Program Error cru do VFP ao clicar Processar.
        loc_lManual = .F.
        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            CATCH TO loc_oErro
                loc_lManual = .F.
            ENDTRY
        ENDIF

        *-- loc_lReiniciar reproduz o "Return 0" do legado no ramo de falha do
        *-- processamento de arquivos: ali o legado NAO exibe a mensagem final e
        *-- NAO reseta a lista de pares (deixa o painel visivel com a barra em 0
        *-- e a mensagem "Favor reinicializar o processo"), para o usuario poder
        *-- corrigir e tentar de novo sem redigitar tudo. Como RETURN dentro de
        *-- TRY/CATCH eh proibido (regra #1), o early-exit vira esta flag.
        loc_lReiniciar = .F.

        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro")
            RETURN
        ENDIF

        *-- ValidarParesContas devolve LOGICO e escreve a mensagem no parametro:
        *-- VFP9 passa por VALOR em chamada de metodo, entao o @ eh OBRIGATORIO
        *-- (sem ele loc_cMensagem volta vazia e o aviso do legado desaparece)
        IF !THIS.this_oBusinessObject.ValidarParesContas(@loc_cMensagem)
            IF EMPTY(loc_cMensagem)
                loc_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
            ENDIF
            MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o!!!")
            THIS.grd_4c_Dados.Column1.SetFocus
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a Troca das Contas ?", ;
                "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
            THIS.cmd_4c_BtnSair.SetFocus
            RETURN
        ENDIF

        *-- Leva os dois checkboxes e o CheckCadPro para o BO antes de processar
        THIS.FormParaBO()

        loc_lOk = .T.

        IF THIS.chk_4c_ChkReps.Value = 1
            *-- Trocar Apenas Representantes (ThisForm.TrocarReps() do legado):
            *-- o BO percorre o proprio cursor_4c_Contas, sem parametro
            loc_lOk = THIS.this_oBusinessObject.TrocarContaRepresentantes()
        ELSE
            *-- Catalogo de campos: quem resolve e valida o caminho eh o BO
            *-- (ValidarArqDBF ja exibe o aviso do legado "O ArqDBF nao esta no
            *-- diretorio do Sistema!!!"); BOParaForm traz o caminho resolvido
            *-- de volta para this_cArqDBFPath, usado no USE ... ALIAS ArqDBF
            IF !THIS.this_oBusinessObject.ValidarArqDBF()
                RETURN
            ENDIF

            THIS.BOParaForm()

            IF EMPTY(THIS.this_cArqDBFPath) OR !FILE(THIS.this_cArqDBFPath + ".dbf")
                MsgErro("ArqDBF n" + CHR(227) + "o localizado para processamento.", ;
                    "Erro de Configura" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            loc_nErro = 1

            *-- Funil unico de estado: PROCESSANDO desabilita grade e botoes para
            *-- o usuario nao reentrar no SCAN multi-tabela (regra #40 - quem
            *-- desabilita reabilita no caminho de volta, feito no fim do metodo)
            THIS.this_cModoAtual = "PROCESSANDO"
            THIS.AjustarBotoesPorModo()

            THIS.cnt_4c_Result.Visible = .T.
            THIS.AtualizarProgresso("", 0)

            TRY
                IF !USED("ArqDBF")
                    USE (THIS.this_cArqDBFPath) IN 0 ALIAS ArqDBF
                ENDIF

                *-- Campos elegiveis: tamanho 10 ou CLIFORS, tipo C, com Dbcs
                *-- preenchido, arquivos SIG*, excluindo catalogos auxiliares
                SELECT Arquivos, Campos ;
                    FROM ArqDBF ;
                    WHERE (Tamanhos = 10 OR UPPER(Campos) = "CLIFORS") AND ;
                        UPPER(Tipos) = "C" AND ;
                        !EMPTY(Dbcs) AND ;
                        ALLTRIM(Arquivos) <> "ArqDBF.DBF" AND ;
                        UPPER(ALLTRIM(Arquivos)) <> "SIGTEMPC.DBF" AND ;
                        UPPER(ALLTRIM(Arquivos)) <> "SIGCDCE.DBF" AND ;
                        UPPER(ALLTRIM(Arquivos)) <> "SIGCDCEE.DBF" AND ;
                        UPPER(ALLTRIM(Arquivos)) <> "SIGALERT.DBF" AND ;
                        UPPER(SUBSTR(ALLTRIM(Arquivos), 1, 3)) = "SIG" AND ;
                        (AT("CON", UPPER(Campos)) <> 0 OR ;
                         AT("IFOR", UPPER(Campos)) <> 0 OR ;
                         AT("ESTOS", UPPER(Campos)) <> 0 OR ;
                         AT("CLI", UPPER(Campos)) <> 0 OR ;
                         AT("VEN", UPPER(Campos)) <> 0 OR ;
                         AT("RESP", UPPER(Campos)) <> 0) AND ;
                        AT("USU", UPPER(Campos)) = 0 AND ;
                        AT("GR", UPPER(Campos)) = 0 AND ;
                        AT("NCONTAS", UPPER(Campos)) = 0 AND ;
                        AT("NRCONS", UPPER(Campos)) = 0 AND ;
                        AT("CCUSTOS", UPPER(Campos)) = 0 ;
                    ORDER BY Arquivos ;
                    INTO CURSOR csCampos READWRITE
                INDEX ON Arquivos + Campos TAG ArqCpo

                SELECT DISTINCT Arquivos FROM csCampos ;
                    INTO CURSOR csArquivos READWRITE ;
                    ORDER BY Arquivos
                loc_nCnt = RECCOUNT("csArquivos")
                IF loc_nCnt < 1
                    loc_nCnt = 1
                ENDIF

                loc_nRec = 0
                SELECT csArquivos
                SCAN  && cada arquivo elegivel
                    loc_cArq = UPPER(ALLTRIM(STRTRAN(csArquivos.Arquivos, ".DBF", "")))
                    THIS.AtualizarProgresso(loc_cArq, -1)

                    SELECT csCampos
                    SEEK csArquivos.Arquivos
                    SCAN WHILE ALLTRIM(csArquivos.Arquivos) == ALLTRIM(csCampos.Arquivos) AND !EOF("csCampos")
                        loc_cCpo = ALLTRIM(csCampos.Campos)
                        THIS.AtualizarProgresso(loc_cArq + " / " + loc_cCpo, -1)

                        SELECT cursor_4c_Contas
                        SCAN  && cada par conta antiga/nova
                            IF loc_cArq == "SIGMVCCR" AND loc_cCpo == "CONTAS"
                                loc_cWhere = "SELECT DISTINCT Emps, Grupos, Contas, Moedas FROM SigMvCcr WHERE " + ;
                                    loc_cCpo + " = " + EscaparSQL(PADR(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")), 10))
                                IF SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_Mccr") > 0 AND USED("cursor_4c_Mccr")
                                    SELECT cursor_4c_Mccr
                                    SCAN
                                        fRecalculaS(cursor_4c_Mccr.Grupos, ALLTRIM(NVL(cursor_4c_Contas.ContaNov, "")), ;
                                            {^1900-01-01}, cursor_4c_Mccr.Moedas, gnConnHandle)
                                    ENDSCAN
                                    USE IN cursor_4c_Mccr
                                ENDIF
                                SELECT cursor_4c_Contas
                            ENDIF

                            *-- Legado: a exclusao so substitui a renomeacao (abaixo, no
                            *-- bloco ELSE generico) QUANDO a conta nova JA existe em
                            *-- SigCdCli (CursorQuery('SigCdCli','CrTmpCli','Iclis',
                            *-- ContaNov,'Iclis') do Click original) - sem essa conferencia
                            *-- o UPDATE que renomeia Iclis de ContaAnt para ContaNov
                            *-- (bloco ELSE generico, mais abaixo) nunca rodaria para
                            *-- SIGCDCLI, mesmo quando a conta nova ainda nao existe
                            IF loc_cArq == "SIGCDCLI" AND loc_cCpo == "ICLIS"
                                loc_lContaNovaExiste = .F.
                                IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Iclis FROM SigCdCli WHERE Iclis = " + ;
                                        EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))), "cursor_4c_TmpCli") > 0 AND ;
                                        USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
                                    loc_lContaNovaExiste = .T.
                                ENDIF
                                IF USED("cursor_4c_TmpCli")
                                    USE IN cursor_4c_TmpCli
                                ENDIF
                                SELECT cursor_4c_Contas

                                IF loc_lContaNovaExiste
                                    IF THIS.chk_4c_Chk_DelCT.Value = 1
                                        THIS.this_oBusinessObject.ExcluirContaAntiga(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")))
                                    ENDIF
                                    SELECT cursor_4c_Contas
                                    LOOP
                                ENDIF
                            ENDIF

                            IF loc_cArq == "SIGMVSLC" OR loc_cArq == "SIGMVEST"
                                loc_cSql = "DELETE FROM " + loc_cArq + " WHERE " + loc_cCpo + " = " + ;
                                    EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")))
                                loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
                                SELECT cursor_4c_Contas
                                IF loc_nErro < 1
                                    EXIT
                                ENDIF
                                LOOP
                            ENDIF

                            IF loc_cArq == "SIGMVCCR" AND loc_cCpo == "CONTAS"
                                loc_cSql = "UPDATE " + loc_cArq + " SET " + loc_cCpo + " = " + ;
                                    EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
                                    ", GruConMoes = Grupos + " + ;
                                    EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
                                    " + Moedas WHERE " + loc_cCpo + " = " + ;
                                    EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")))
                            ELSE
                                IF loc_cArq == "SIGMVHST" AND loc_cCpo == "ESTOS"
                                    loc_cWhere = "SELECT DISTINCT Emps, Grupos, Estos, Cpros, CodCors, CodTams " + ;
                                        "FROM SigMvHst WHERE " + loc_cCpo + " = " + ;
                                        EscaparSQL(PADR(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")), 10))
                                    IF SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_His") > 0 AND USED("cursor_4c_His")
                                        *-- fRecalculaP/fRecalculaC nao portadas - recalculo de saldo omitido
                                        USE IN cursor_4c_His
                                    ENDIF
                                    SELECT cursor_4c_Contas
                                    loc_cSql = "UPDATE " + loc_cArq + " SET " + loc_cCpo + " = " + ;
                                        EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
                                        ", EmpGruEsts = Emps + Grupos + " + ;
                                        EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
                                        " WHERE " + loc_cCpo + " = " + ;
                                        EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")))
                                ELSE
                                    IF loc_cArq == "SIGCDCLH" AND loc_cCpo == "ICLIS"
                                        loc_cSql = "UPDATE " + loc_cArq + " SET " + loc_cCpo + " = " + ;
                                            EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
                                            ", GruContas = Grupos + " + ;
                                            EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
                                            " WHERE " + loc_cCpo + " = " + ;
                                            EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")))
                                    ELSE
                                        loc_cSql = "UPDATE " + loc_cArq + " SET " + loc_cCpo + " = " + ;
                                            EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))) + ;
                                            " WHERE " + loc_cCpo + " = " + ;
                                            EscaparSQL(ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, "")))
                                    ENDIF
                                ENDIF
                            ENDIF

                            loc_nErro = SQLEXEC(gnConnHandle, loc_cSql)
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!!, Tentar Novamente?", ;
                                        "Aten" + CHR(231) + CHR(227) + "o!!!")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF

                            SELECT cursor_4c_Contas
                        ENDSCAN  && cursor_4c_Contas

                        SELECT csCampos
                        IF loc_nErro < 1
                            EXIT
                        ENDIF
                    ENDSCAN  && csCampos

                    IF loc_nErro < 1
                        EXIT
                    ENDIF

                    SELECT csArquivos
                    loc_nRec = loc_nRec + 1
                    loc_nPct = INT((loc_nRec * 100) / loc_nCnt)
                    THIS.AtualizarProgresso("", loc_nPct)
                ENDSCAN  && csArquivos

                *-- Legado: fRecalculaS/fRecalculaP/fRecalculaC em "modo
                *-- processamento" (1o parametro logico) apos o SCAN de
                *-- arquivos, fechando o lote registrado pelas chamadas em
                *-- "modo registro" dentro do SIGMVCCR acima. fRecalculaS esta
                *-- portada (utils\functions.prg) - chamar de verdade.
                *-- fRecalculaP/fRecalculaC NAO portadas (regra #27 - funcoes
                *-- de CALCULO de saldo nunca recebem stub) - omitidas, mesmo
                *-- padrao de Formsigprmdp.prg/sigprmdpBO.prg.
                IF loc_nErro > 0 AND !fRecalculaS(.T., gnConnHandle, .T.)
                    loc_nErro = -1
                ENDIF

                IF loc_nErro < 1
                    *-- Legado: MessageBox('Favor reinicializar o processo.') +
                    *-- RollBack + cntResult.Visible = .t. + barra em 0 +
                    *-- "Return 0" - sai SEM a mensagem final e SEM resetar a
                    *-- lista de pares (loc_lReiniciar abaixo reproduz isso)
                    IF loc_lManual
                        = SQLROLLBACK(gnConnHandle)
                    ENDIF
                    MsgErro("Favor reinicializar o processo.", ;
                        "Falha na Conex" + CHR(227) + "o")
                    loc_lOk        = .F.
                    loc_lReiniciar = .T.
                ELSE
                    IF loc_lManual
                        = SQLCOMMIT(gnConnHandle)
                    ENDIF

                    SELECT cursor_4c_Contas
                    SCAN
                        THIS.this_oBusinessObject.this_cContaAnt = TratarNulo(cursor_4c_Contas.ContaAnt, "")
                        THIS.this_oBusinessObject.this_cContaNov = TratarNulo(cursor_4c_Contas.ContaNov, "")
                        THIS.this_oBusinessObject.RegistrarAuditoria("UPDATE")
                    ENDSCAN

                    loc_lOk = .T.
                ENDIF

                IF USED("csCampos")
                    USE IN csCampos
                ENDIF
                IF USED("csArquivos")
                    USE IN csArquivos
                ENDIF
                IF USED("ArqDBF")
                    USE IN ArqDBF
                ENDIF
            CATCH TO loc_oErro
                IF loc_lManual
                    = SQLROLLBACK(gnConnHandle)
                ENDIF
                MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnProcessarClick FormSigPrMdc")
                loc_lOk        = .F.
                loc_lReiniciar = .T.
            ENDTRY

            *-- Caminho de VOLTA (regra #40): o modo e os botoes voltam SEMPRE,
            *-- em sucesso e em falha. No ramo de reinicializacao o painel fica
            *-- VISIVEL com a barra em 0, como no legado
            IF loc_lReiniciar
                THIS.AtualizarProgresso("", 0)
            ELSE
                THIS.cnt_4c_Result.Visible = .F.
            ENDIF

            THIS.this_cModoAtual = "EDICAO"
            THIS.AjustarBotoesPorModo()
        ENDIF

        IF !loc_lReiniciar
            IF loc_lOk
                MsgInfo("Todas as Contas Foram Alteradas!!!", "Processamento Encerrado!!!")
            ELSE
                MsgAviso("As Contas N" + CHR(227) + "o Foram Alteradas!!!", ;
                    "Processamento Encerrado!!!")
            ENDIF

            *-- Reseta a lista de pares para o proximo lote (Zap + Append Blank
            *-- do legado). NAO roda no ramo de reinicializacao: ali o legado
            *-- preserva os pares para o usuario corrigir e reprocessar
            THIS.LimparCampos()
        ENDIF

        THIS.grd_4c_Dados.Column1.SetFocus
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita grid e botoes durante processamento,
    * para evitar cliques enquanto o SCAN multi-tabela esta em andamento.
    * O botao Encerrar NAO entra: o legado nunca o desabilita, e trava-lo
    * deixaria a tela sem saida durante um lote longo.
    *
    * Chk_DelCT carrega tambem a dependencia do Chk_DelCT.When do legado
    * ("Return (ThisForm.chkReps.Value = 0)"): ele so eh clicavel enquanto
    * "Trocar Apenas Representantes" estiver desmarcado.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
    *==========================================================================
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        THIS.grd_4c_Dados.Enabled        = loc_lHab
        THIS.cmd_4c_BtnIncluir.Enabled   = loc_lHab
        THIS.cmd_4c_BtnExcluir.Enabled   = loc_lHab
        THIS.cmd_4c_Exporta.Enabled      = loc_lHab
        THIS.cmd_4c_BtnProcessar.Enabled = loc_lHab
        THIS.chk_4c_ChkReps.Enabled      = loc_lHab
        THIS.chk_4c_Chk_DelCT.Enabled    = loc_lHab AND (THIS.chk_4c_ChkReps.Value = 0)
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - FUNIL UNICO do estado da tela. Chamado tanto na
    * IDA (BtnProcessarClick, modo "PROCESSANDO") quanto na VOLTA (fim do
    * processamento e LimparCampos, modo "EDICAO"): regra #40 - quem desabilita
    * botao tem de reabilitar no funil de volta, senao a tela fica inutilizavel
    * depois do primeiro processamento e so volta ao normal se for reaberta.
    *
    * NAO existem modos CRUD aqui: o legado herda de `form` (nao de
    * frmcadastro), nao tem pcEscolha nem os botoes Incluir/Alterar/Visualizar/
    * Excluir/Buscar de cadastro - inventa-los violaria o PILAR 1.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
    *==========================================================================
        LOCAL loc_lEdicao

        *-- Qualquer valor que nao seja "PROCESSANDO" eh tratado como edicao:
        *-- assim um modo nao previsto nunca deixa a tela travada
        loc_lEdicao = !(UPPER(ALLTRIM(THIS.this_cModoAtual)) == "PROCESSANDO")

        THIS.HabilitarCampos(loc_lEdicao)
    ENDPROC

    *==========================================================================
    * AtualizarProgresso - FUNIL UNICO do painel de progresso (cntResult do
    * legado). Tambem eh o metodo que o SigPrMdcBO.ProcessarMudancaContas
    * espera encontrar no form que recebe por par_oForm - sem ele aquela
    * chamada estoura "Property ATUALIZARPROGRESSO is not found" em runtime.
    *
    * par_cArquivo: texto do campo "Arquivo/Campo" ("" mantem o atual)
    * par_nPct    : 0..100 reposiciona a barra; valor negativo (ou ausente)
    *               mantem a barra como esta - usado nos dois SCAN internos,
    *               que no legado atualizam SO o texto do arquivo/campo
    * PUBLIC de proposito: chamado de fora da classe pelo BO (regra #3/#51).
    *==========================================================================
    PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
    *==========================================================================
        LOCAL loc_cArq, loc_nPct, loc_oErro

        loc_cArq = IIF(VARTYPE(par_cArquivo) = "C", par_cArquivo, "")
        loc_nPct = IIF(VARTYPE(par_nPct) = "N", par_nPct, -1)

        TRY
            IF !EMPTY(loc_cArq)
                THIS.cnt_4c_Result.txt_4c_Arquivo.Value = loc_cArq
                THIS.cnt_4c_Result.txt_4c_Arquivo.Refresh
            ENDIF

            IF loc_nPct >= 0
                IF loc_nPct > 100
                    loc_nPct = 100
                ENDIF
                *-- Barra interna tem 222px uteis: 2px por ponto percentual,
                *-- como no legado (Int((lnRec*100)/lnCnt) * 2)
                THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = loc_nPct * 2
                THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = ;
                    ALLTRIM(STR(loc_nPct)) + " %"
                THIS.cnt_4c_Result.cnt_4c_Barra.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AtualizarProgresso FormSigPrMdc")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta a lista de pares para o proximo lote ("Select
    * csContas / Set Order To / Zap / Append Blank" do fim do btnProcessar.Click
    * legado) e devolve a tela ao estado de edicao.
    *
    * Os dois checkboxes NAO sao zerados: o legado tambem nao os zera no fim do
    * processamento, e mexer neles mudaria o comportamento que o usuario ve
    * (PILAR 1). Quem precisa dos valores sincronizados chama FormParaBO.
    *
    * PROTECTED EXPLICITO: FormBase declara LimparCampos / FormParaBO /
    * BOParaForm como PROTECTED e o VFP9 NAO deixa a subclasse alargar o escopo
    * - escrever "PROCEDURE" sem o modificador nao torna o metodo publico, so
    * esconde que ele continua protegido (medido: chamada de fora estoura
    * "Property LIMPARCAMPOS is not found", mas PEMSTATUS(...,5) devolve .T. e
    * mente). Chamar SEMPRE por THIS. de dentro da classe. Metodo que precise
    * ser alcancado de fora nao pode usar um desses tres nomes - eh por isso que
    * o funil do painel de progresso se chama AtualizarProgresso (nome ausente
    * em FormBase, logo publico de verdade) e eh ele que o BO recebe em par_oForm.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
    *==========================================================================
        LOCAL loc_cSafety, loc_oErro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Contas")
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.InicializarCursorContas()
                ENDIF
            ELSE
                *-- DataSession privada (=2) nasce com SET SAFETY ON (nao herda o
                *-- OFF do main.prg): sem a guarda o ZAP abre dialogo modal de
                *-- confirmacao e congela o processo em execucao desassistida
                loc_cSafety = SET("SAFETY")
                SET SAFETY OFF
                SELECT cursor_4c_Contas
                SET ORDER TO
                ZAP
                APPEND BLANK
                IF loc_cSafety == "ON"
                    SET SAFETY ON
                ENDIF
            ENDIF

            *-- Zerar o cursor NAO repinta a grade (regra #21): repintura pelo
            *-- mesmo funil usado por todos os outros caminhos
            THIS.CarregarLista("TOPO")

            THIS.this_cModoAtual = "EDICAO"
            THIS.AjustarBotoesPorModo()

            *-- Par corrente do BO acompanha o cursor recem-zerado
            THIS.FormParaBO()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro LimparCampos FormSigPrMdc")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere para o BO TODO estado da tela que ele consome.
    * Form OPERACIONAL: nao ha aba de campos, mas as propriedades existem e sao
    * lidas de verdade pelo BO, entao a transferencia tem de ser completa.
    *
    *   chk_4c_ChkReps     -> this_lTrocarReps        (TrocarContaRepresentantes)
    *   chk_4c_Chk_DelCT   -> this_lApagarContaAntiga (ProcessarMudancaContas)
    *   this_lCheckCadPro  -> this_lCheckCadPro       (ImportarDeXLS / lookups)
    *   linha corrente da grade -> this_cContaAnt / this_cContaNov
    *                             (ObterChavePrimaria / RegistrarAuditoria /
    *                              Inserir / Atualizar)
    *
    * CheckBox.Value eh NUMERICO (0/1) e as tres properties do BO sao LOGICAS:
    * atribuir direto trocaria o tipo da property e estouraria "Data type
    * mismatch" no primeiro AND do BO - a conversao "= 1" eh obrigatoria.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_oBO
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro FormParaBO")
        ELSE
            TRY
                loc_oBO = THIS.this_oBusinessObject

                loc_oBO.this_lTrocarReps        = (THIS.chk_4c_ChkReps.Value = 1)
                loc_oBO.this_lApagarContaAntiga = (THIS.chk_4c_Chk_DelCT.Value = 1)
                loc_oBO.this_lCheckCadPro       = THIS.this_lCheckCadPro
                loc_oBO.this_cArqDBFPath        = THIS.this_cArqDBFPath

                *-- Par corrente (a grade eh a unica "entrada de dados" da tela)
                IF USED("cursor_4c_Contas") AND !EOF("cursor_4c_Contas")
                    loc_oBO.this_cContaAnt = TratarNulo(cursor_4c_Contas.ContaAnt, "")
                    loc_oBO.this_cContaNov = TratarNulo(cursor_4c_Contas.ContaNov, "")
                ELSE
                    loc_oBO.this_cContaAnt = ""
                    loc_oBO.this_cContaNov = ""
                ENDIF

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro FormParaBO FormSigPrMdc")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Caminho inverso do FormParaBO: reflete na tela o estado que
    * o BO detem. Usado quando o BO decide o estado (ex.: ValidarArqDBF, que
    * resolve o caminho do catalogo, e os dois flags de processamento).
    *
    * O par de contas NAO eh escrito de volta na grade: a linha corrente eh do
    * cursor, e sobrescrever a celula aqui apagaria o que o usuario digitou e
    * ainda nao confirmou. Quem grava no cursor eh ValidarCelulaConta/
    * AbrirBuscaConta, que tem o valor resolvido.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_oBO
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro BOParaForm")
        ELSE
            TRY
                loc_oBO = THIS.this_oBusinessObject

                *-- Propriedade LOGICA do BO -> CheckBox.Value NUMERICO
                THIS.chk_4c_ChkReps.Value   = IIF(loc_oBO.this_lTrocarReps, 1, 0)
                THIS.chk_4c_Chk_DelCT.Value = IIF(loc_oBO.this_lApagarContaAntiga, 1, 0)

                THIS.this_lCheckCadPro = loc_oBO.this_lCheckCadPro

                IF !EMPTY(loc_oBO.this_cArqDBFPath)
                    THIS.this_cArqDBFPath = loc_oBO.this_cArqDBFPath
                ENDIF

                *-- Dependencia do Chk_DelCT.When do legado tem de ser reaplicada
                *-- depois de mexer no Value dos dois checkboxes
                THIS.ChkRepsClick()

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BOParaForm FormSigPrMdc")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles criados por
    * AddObject (nascem com Visible=.F.), recursando em Pages e Containers.
    * cnt_4c_Result eh container flutuante (painel de progresso oculto por
    * padrao) - recursa nos filhos mas NAO forca Visible=.T. no proprio
    * container, preservando o estado definido em ConfigurarPainelResultado.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_oControle

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) != "O"
                LOOP
            ENDIF

            IF UPPER(loc_oControle.Name) = "CNT_4C_RESULT"
                IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oControle)
                ENDIF
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControle, "Visible", 5)
                loc_oControle.Visible = .T.
            ENDIF

            IF UPPER(loc_oControle.BaseClass) = "PAGEFRAME"
                LOCAL loc_nP
                FOR loc_nP = 1 TO loc_oControle.PageCount
                    THIS.TornarControlesVisiveis(loc_oControle.Pages(loc_nP))
                ENDFOR
            ENDIF

            IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                THIS.TornarControlesVisiveis(loc_oControle)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Contas")
            USE IN cursor_4c_Contas
        ENDIF
        IF USED("csCampos")
            USE IN csCampos
        ENDIF
        IF USED("csArquivos")
            USE IN csArquivos
        ENDIF
        IF USED("ArqDBF")
            USE IN ArqDBF
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
