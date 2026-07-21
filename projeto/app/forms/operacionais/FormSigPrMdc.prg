*==============================================================================
* Classe  : FormSigPrMdc
* Herda de: FormBase
* Descricao: Formulario operacional Muda Conta - altera codigos de conta
*            em multiplas tabelas do banco conforme catalogo ArqDBF.
*            Form OPERACIONAL - layout flat sem PageFrame.
*==============================================================================
DEFINE CLASS FormSigPrMdc AS FormBase

    Caption      = "Muda Conta"
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    KeyPreview   = .T.
    DataSession  = 2
    WindowType   = 1

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Flag: nao validar conta contra SigCdCli (parametro pCheckCad do legado)
    this_lCheckCadPro    = .F.

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame
    * Configura aparencia base do form (fundo, fontes, cores).
    * Para forms OPERACIONAIS sem PageFrame, este metodo define o Picture
    * e propriedades globais do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .F.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm
    * Chamado por FormBase.Init() - cria BO, monta layout de containers base.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Configurar aparencia base do form
            THIS.ConfigurarPageFrame()

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrMdcBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_lCheckCadPro = THIS.this_lCheckCadPro
                IF THIS.this_oBusinessObject.InicializarCursorContas()
                    THIS.ConfigurarCabecalho()
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.ConfigurarBotoes()
                    THIS.ConfigurarContainerResultado()
                    THIS.ConfigurarPaginaLista()

                    *-- Tornar controles visiveis (exceto cnt_4c_Resultado que eh flutuante)
                    THIS.TornarControlesVisiveis(THIS)

                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inicializar cursor de contas.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao criar SigPrMdcBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cabecalho cinza com titulo (cntSombra do legado)
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
        ENDWITH
        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .Caption   = THIS.Caption
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top       = 17
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .BackStyle = 0
            .Caption   = THIS.Caption
            .ForeColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes
    * Container para os botoes de acao (Incluir, Excluir, Importar, Processar,
    * Encerrar). Fica logo abaixo do cabecalho, cobrindo toda a largura.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Botoes", "Container")
        loc_oCnt = THIS.cnt_4c_Botoes
        WITH loc_oCnt
            .Top         = 80
            .Left        =  542
            .Width       = THIS.Width
            .Height      = 90
            .BackStyle   = 0
            .BorderWidth = 0
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerResultado
    * Painel de progresso de processamento (cntResult do legado).
    * Inicialmente oculto; exibido durante btnProcessar quando chkReps=.F.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerResultado()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Resultado", "Container")
        loc_oCnt = THIS.cnt_4c_Resultado
        WITH loc_oCnt
            .Top         = 170
            .Left        = 490
            .Width       = 297
            .Height      = 183
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .SpecialEffect = 0
            .BorderWidth = 1
            .Visible     = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarProgresso
    * Chamado pelo BO (ProcessarMudancaContas) para atualizar a UI em tempo
    * real durante o processamento.
    * par_cArquivo: nome do arquivo/campo em processamento
    * par_nPct    : percentual concluido 0-100
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
        LOCAL loc_nLargura
        loc_nLargura = 0
        TRY
            IF VARTYPE(THIS.cnt_4c_Resultado) = "O" AND THIS.cnt_4c_Resultado.Visible
                THIS.cnt_4c_Resultado.txt_4c_Arquivo.Value = par_cArquivo
                THIS.cnt_4c_Resultado.txt_4c_Arquivo.Refresh
                loc_nLargura = INT((par_nPct * 275) / 100)
                THIS.cnt_4c_Resultado.cnt_4c_Barra.shp_4c_Barra.Width = loc_nLargura
                THIS.cnt_4c_Resultado.cnt_4c_Barra.lbl_4c_Porcento.Caption = ;
                    ALLTRIM(TRANSFORM(par_nPct)) + " %"
                THIS.cnt_4c_Resultado.cnt_4c_Barra.Refresh
            ENDIF
        CATCH TO loc_oErro
            *-- progresso nao e critico, pular silenciosamente
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis
    * Torna controles Visible=.T. apos AddObject (que cria com Visible=.F.).
    * EXCECAO: containers ocultos por design (cnt_4c_Resultado, cnt_4c_Cabecalho,
    * cnt_4c_Barra) nao sao forcados a .T.; seus filhos sao visitados
    * recursivamente para render correto ao exibir o container pai.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_RESULTADO", "CNT_4C_CABECALHO", "CNT_4C_BARRA")
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) .AND. ;
                   loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - foca o grid quando o form e exibido (padrao legado Init SetFocus)
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        DODEFAULT()
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF
            THIS.this_oBusinessObject = .NULL.
        CATCH TO loc_oErro
            *-- ignorar erros de cleanup
        ENDTRY
        DODEFAULT()
    ENDPROC


    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista
    * Configura o corpo principal do form OPERACIONAL: botoes de acao, grid
    * de pares de contas, checkboxes e internos do painel de progresso.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotoesAcao()
        THIS.ConfigurarGrid()
        THIS.ConfigurarCheckboxes()
        THIS.ConfigurarResultadoInternos()
        THIS.VincularEventos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao
    * Adiciona os botoes de acao ao container cnt_4c_Botoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Botoes

        loc_oCnt.AddObject("cmd_4c_BtnIncluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnIncluir
            .Top             = 7
            .Left            = 425
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_BtnExcluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnExcluir
            .Top             = 7
            .Left            = 500
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Exporta", "CommandButton")
        WITH loc_oCnt.cmd_4c_Exporta
            .Top             = 7
            .Left            = 575
            .Width           = 75
            .Height          = 75
            .Caption         = "I\<mportar"
            .Picture         = gc_4c_CaminhoIcones + "geral_multiplos_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_multiplos_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_BtnProcessar", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnProcessar
            .Top             = 7
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_BtnSair", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnSair
            .Top             = 7
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid
    * Cria grd_4c_Dados com 2 colunas (Conta Antiga / Conta Nova).
    * RecordSource: cursor_4c_Contas criado pelo BO em InicializarCursorContas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top               = 170
            .Left              = 12
            .Width             = 460
            .Height            = 400
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 18
            .RowHeight         = 18
            .ScrollBars        = 2
            .FontName          = "Verdana"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightStyle    = 2
        ENDWITH
        loc_oGrid.ColumnCount  = 2
        loc_oGrid.RecordSource = "cursor_4c_Contas"
        loc_oGrid.Column1.ControlSource = "cursor_4c_Contas.ContaAnt"
        loc_oGrid.Column1.Width         = 220
        loc_oGrid.Column1.Sparse        = .F.
        loc_oGrid.Column2.ControlSource = "cursor_4c_Contas.ContaNov"
        loc_oGrid.Column2.Width         = 220
        loc_oGrid.Column2.Sparse        = .F.
        *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
        loc_oGrid.Column1.Header1.Caption   = "Conta Antiga"
        loc_oGrid.Column1.Header1.Alignment = 2
        loc_oGrid.Column1.Header1.FontName  = "Tahoma"
        loc_oGrid.Column1.Header1.FontSize  = 8
        loc_oGrid.Column1.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column2.Header1.Caption   = "Conta Nova"
        loc_oGrid.Column2.Header1.Alignment = 2
        loc_oGrid.Column2.Header1.FontName  = "Tahoma"
        loc_oGrid.Column2.Header1.FontSize  = 8
        loc_oGrid.Column2.Header1.ForeColor = RGB(0, 0, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCheckboxes
    * Adiciona checkboxes de controle ao form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCheckboxes()
        THIS.AddObject("chk_4c_ChkReps", "CheckBox")
        WITH THIS.chk_4c_ChkReps
            .Top       = 297
            .Left      = 393
            .Height    = 20
            .Width     = 240
            .Caption   = "Trocar Apenas Representantes"
            .Value     = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        THIS.AddObject("chk_4c_Chk_DelCT", "CheckBox")
        WITH THIS.chk_4c_Chk_DelCT
            .Top       = 278
            .Left      = 393
            .Height    = 20
            .Width     = 260
            .Caption   = "Apagar a Conta Antiga do Cadastro"
            .Value     = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarResultadoInternos
    * Adiciona controles internos ao painel de progresso cnt_4c_Resultado.
    * Nomes devem bater exatamente com as referencias em AtualizarProgresso().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarResultadoInternos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Resultado

        loc_oCnt.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCnt.lbl_4c_Label5
            .Caption   = "Arquivo/Campo :"
            .Left      = 7
            .Top       = 9
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Arquivo", "TextBox")
        WITH loc_oCnt.txt_4c_Arquivo
            .Top               = 26
            .Left              = 7
            .Width             = 278
            .Height            = 24
            .Enabled           = .F.
            .Value             = ""
            .Alignment         = 3
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 0)
            .BorderColor       = RGB(100, 100, 100)
            .FontName          = "Tahoma"
            .FontSize          = 8
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Caption   = "Progresso :"
            .Left      = 7
            .Top       = 100
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        loc_oCnt.AddObject("cnt_4c_Barra", "Container")
        WITH loc_oCnt.cnt_4c_Barra
            .Top         = 116
            .Left        = 5
            .Width       = 280
            .Height      = 21
            .BorderWidth = 1
            .BackStyle   = 1
            .BackColor   = RGB(200, 200, 200)
            .Visible     = .T.
        ENDWITH

        loc_oCnt.cnt_4c_Barra.AddObject("shp_4c_Barra", "Shape")
        WITH loc_oCnt.cnt_4c_Barra.shp_4c_Barra
            .Top         = 1
            .Left        = 1
            .Height      = 19
            .Width       = 0
            .BackColor   = RGB(0, 128, 255)
            .BorderColor = RGB(100, 100, 100)
        ENDWITH

        loc_oCnt.cnt_4c_Barra.AddObject("lbl_4c_Porcento", "Label")
        WITH loc_oCnt.cnt_4c_Barra.lbl_4c_Porcento
            .Caption   = "0 %"
            .Left      = 120
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados
    * NAO APLICAVEL para este form OPERACIONAL de layout plano (sem PageFrame).
    * Todos os controles de dados foram criados em ConfigurarPaginaLista():
    *   grd_4c_Dados      - grade de pares ContaAnt/ContaNov
    *   chk_4c_ChkReps    - checkbox "Trocar Apenas Representantes"
    *   chk_4c_Chk_DelCT  - checkbox "Apagar a Conta Antiga do Cadastro"
    *   cnt_4c_Resultado  - painel de progresso (flutuante)
    * Metodo mantido para compatibilidade com o template multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Form OPERACIONAL plano: nao ha Page2 separada de edicao de dados.
        *-- Todos os controles foram configurados em ConfigurarPaginaLista().
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularEventos
    * Vincula eventos dos controles aos handlers do form via BINDEVENT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularEventos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Botoes
        BINDEVENT(loc_oCnt.cmd_4c_BtnIncluir,  "Click", THIS, "CmdIncluirClick")
        BINDEVENT(loc_oCnt.cmd_4c_BtnExcluir,  "Click", THIS, "CmdExcluirClick")
        BINDEVENT(loc_oCnt.cmd_4c_Exporta,     "Click", THIS, "CmdExportaClick")
        BINDEVENT(loc_oCnt.cmd_4c_BtnProcessar,"Click", THIS, "CmdProcessarClick")
        BINDEVENT(loc_oCnt.cmd_4c_BtnSair,     "Click", THIS, "CmdSairClick")
        BINDEVENT(THIS.chk_4c_ChkReps, "Click", THIS, "ChkRepsClick")
        BINDEVENT(THIS.grd_4c_Dados, "KeyPress",          THIS, "GrdDadosKeyPress")
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina
    * Exibe ou oculta o painel de progresso (cnt_4c_Resultado).
    * par_lMostrar: .T. para exibir, .F. para ocultar, omitir para alternar.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_lMostrar)
        TRY
            IF VARTYPE(par_lMostrar) = "L"
                THIS.cnt_4c_Resultado.Visible = par_lMostrar
            ELSE
                THIS.cnt_4c_Resultado.Visible = !THIS.cnt_4c_Resultado.Visible
            ENDIF
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdIncluirClick - Incluir nova linha em branco no grid
    *--------------------------------------------------------------------------
    PROCEDURE CmdIncluirClick()
        TRY
            THIS.this_oBusinessObject.IncluirParConta()
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Incluir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExcluirClick - Excluir linha corrente do grid
    *--------------------------------------------------------------------------
    PROCEDURE CmdExcluirClick()
        TRY
            THIS.this_oBusinessObject.ExcluirParConta()
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Excluir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdExportaClick - Importar pares de contas de arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE CmdExportaClick()
        LOCAL loc_cArquivo
        loc_cArquivo = ""
        TRY
            loc_cArquivo = GETFILE("XLS")
            IF EMPTY(loc_cArquivo)
                MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o informado!!!", "Aviso")
                RETURN
            ENDIF
            IF THIS.this_oBusinessObject.ImportarDeXLS(loc_cArquivo)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Importar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdProcessarClick - Processar troca de contas em todas as tabelas
    *--------------------------------------------------------------------------
    PROCEDURE CmdProcessarClick()
        LOCAL loc_lSucesso, loc_cMensagem, loc_lApagarContaAntiga, loc_lTrocarReps
        loc_lSucesso           = .F.
        loc_cMensagem          = ""
        loc_lApagarContaAntiga = .F.
        loc_lTrocarReps        = .F.
        TRY
            *-- Validar pares antes de processar
            IF NOT THIS.this_oBusinessObject.ValidarParesContas(@loc_cMensagem)
                MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
                THIS.grd_4c_Dados.SetFocus()
                RETURN
            ENDIF

            *-- Confirmar com usuario
            IF NOT MsgConfirma("Confirma a Troca das Contas ?", ;
                "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
                THIS.cnt_4c_Botoes.cmd_4c_BtnSair.SetFocus()
                RETURN
            ENDIF

            loc_lTrocarReps        = (THIS.chk_4c_ChkReps.Value   = 1)
            loc_lApagarContaAntiga = (THIS.chk_4c_Chk_DelCT.Value = 1)

            IF loc_lTrocarReps
                *-- Troca apenas ContaVens em SigCdCli (representantes)
                loc_lSucesso = THIS.this_oBusinessObject.TrocarContaRepresentantes()
            ELSE
                *-- Processamento completo via catalogo ArqDBF
                THIS.cnt_4c_Resultado.Visible = .T.
                THIS.cnt_4c_Resultado.cnt_4c_Barra.shp_4c_Barra.Width   = 0
                THIS.cnt_4c_Resultado.cnt_4c_Barra.lbl_4c_Porcento.Caption = "0 %"
                THIS.cnt_4c_Resultado.Refresh()
                loc_lSucesso = THIS.this_oBusinessObject.ProcessarMudancaContas( ;
                    loc_lApagarContaAntiga, THIS)
                THIS.cnt_4c_Resultado.Visible = .F.
                THIS.Refresh()
            ENDIF

            *-- Informar resultado
            IF loc_lSucesso
                MsgAviso("Todas as Contas Foram Alteradas!!!", ;
                    "Processamento Encerrado!!!")
            ELSE
                MsgAviso("As Contas N" + CHR(227) + "o Foram Alteradas!!!", ;
                    "Processamento Encerrado!!!")
            ENDIF

            *-- Reiniciar cursor para nova rodada
            IF USED("cursor_4c_Contas")
                SELECT cursor_4c_Contas
                SET ORDER TO
                ZAP
                APPEND BLANK
            ENDIF
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Processamento")
            TRY
                THIS.cnt_4c_Resultado.Visible = .F.
                THIS.Refresh()
            CATCH TO loc_oErroVis
                *-- ignorar
            ENDTRY
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSairClick - Fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE CmdSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkRepsClick
    * Quando "Trocar Apenas Representantes" e marcado, desabilitar e limpar
    * "Apagar Conta Antiga" (legado: When = chkReps.Value = 0).
    *--------------------------------------------------------------------------
    PROCEDURE ChkRepsClick()
        IF THIS.chk_4c_ChkReps.Value = 1
            THIS.chk_4c_Chk_DelCT.Value   = 0
            THIS.chk_4c_Chk_DelCT.Enabled = .F.
        ELSE
            THIS.chk_4c_Chk_DelCT.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosKeyPress - F4 abre lookup para a coluna ativa (Conta Antiga/Nova)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 115  && Apenas F4
            RETURN
        ENDIF
        LOCAL loc_nColAtiva
        loc_nColAtiva = 0
        TRY
            loc_nColAtiva = THIS.grd_4c_Dados.ActiveColumn
        CATCH TO loc_oErro
            *-- ignorar
        ENDTRY
        IF loc_nColAtiva = 1
            THIS.AbrirLookupContaAnt()
        ELSE
            IF loc_nColAtiva = 2
            THIS.AbrirLookupContaNov()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange
    * Ao mover para Coluna 2, valida ContaAnt do registro corrente.
    * Ao mover para Coluna 1 com ContaNov preenchida, valida ContaNov.
    * (Equivale aos Valid de Column1.Text1 e Column2.Text1 do legado.)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        IF THIS.this_lCheckCadPro
            RETURN
        ENDIF
        IF par_nColIndex = 2
            THIS.ValidarContaAnt()
        ELSE
            IF par_nColIndex = 1
            *-- Validar ContaNov apenas se tiver valor (usuario saiu da col 2)
            IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
                IF NOT EMPTY(NVL(cursor_4c_Contas.ContaNov, ""))
                    THIS.ValidarContaNov()
                ENDIF
            ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaAnt
    * Valida ContaAnt do registro corrente contra SigCdCli. Se nao encontrado,
    * abre picker para selecao.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaAnt()
        LOCAL loc_cValor, loc_cEncontrado
        loc_cValor      = ""
        loc_cEncontrado = ""
        TRY
            IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
                loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, ""))
            ENDIF
            IF EMPTY(loc_cValor)
                RETURN
            ENDIF
            loc_cEncontrado = THIS.this_oBusinessObject.ValidarCodigoConta(loc_cValor)
            IF EMPTY(loc_cEncontrado)
                THIS.AbrirLookupContaAnt()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Conta Antiga")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaNov
    * Valida ContaNov do registro corrente contra SigCdCli. Se nao encontrado,
    * abre picker para selecao.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaNov()
        LOCAL loc_cValor, loc_cEncontrado
        loc_cValor      = ""
        loc_cEncontrado = ""
        TRY
            IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
                loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))
            ENDIF
            IF EMPTY(loc_cValor)
                RETURN
            ENDIF
            loc_cEncontrado = THIS.this_oBusinessObject.ValidarCodigoConta(loc_cValor)
            IF EMPTY(loc_cEncontrado)
                THIS.AbrirLookupContaNov()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Conta Nova")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupContaAnt
    * Abre FormBuscaAuxiliar para selecao de Conta Antiga (SigCdCli.Iclis).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupContaAnt()
        LOCAL loc_oLista, loc_cValor
        loc_cValor = ""
        TRY
            IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
                loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, ""))
            ENDIF
            loc_oLista = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "Iclis", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
            loc_oLista.mAddColuna("Iclis",  "", "C" + CHR(243) + "digo")
            loc_oLista.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oLista.mAddColuna("Grupos", "", "Grupo")
            loc_oLista.Show()
            IF loc_oLista.this_lSelecionou .AND. USED("cursor_4c_BuscaCli") .AND. ;
               RECCOUNT("cursor_4c_BuscaCli") > 0
                SELECT cursor_4c_BuscaCli
                IF NOT EOF()
                    SELECT cursor_4c_Contas
                    IF NOT EOF()
                        REPLACE cursor_4c_Contas.ContaAnt WITH ;
                            ALLTRIM(cursor_4c_BuscaCli.Iclis)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Conta Antiga")
        ENDTRY
        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupContaNov
    * Abre FormBuscaAuxiliar para selecao de Conta Nova (SigCdCli.Iclis).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupContaNov()
        LOCAL loc_oLista, loc_cValor
        loc_cValor = ""
        TRY
            IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
                loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))
            ENDIF
            loc_oLista = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "Iclis", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
            loc_oLista.mAddColuna("Iclis",  "", "C" + CHR(243) + "digo")
            loc_oLista.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oLista.mAddColuna("Grupos", "", "Grupo")
            loc_oLista.Show()
            IF loc_oLista.this_lSelecionou .AND. USED("cursor_4c_BuscaCli") .AND. ;
               RECCOUNT("cursor_4c_BuscaCli") > 0
                SELECT cursor_4c_BuscaCli
                IF NOT EOF()
                    SELECT cursor_4c_Contas
                    IF NOT EOF()
                        REPLACE cursor_4c_Contas.ContaNov WITH ;
                            ALLTRIM(cursor_4c_BuscaCli.Iclis)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar Conta Nova")
        ENDTRY
        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick
    * Adiciona novo par de contas em branco no grid (equivalente CRUD Incluir).
    * Roteia para CmdIncluirClick (mesmo handler do botao [Incluir] visivel).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.CmdIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick
    * Coloca foco na Conta Antiga da linha corrente para edicao inline no grid.
    * Form OPERACIONAL: grid eh sempre editavel, nao ha modo separado ALTERAR.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        TRY
            IF NOT USED("cursor_4c_Contas") OR RECCOUNT("cursor_4c_Contas") = 0
                MsgAviso("N" + CHR(227) + "o existem pares de contas para alterar.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.ActiveColumn = 1
                IF VARTYPE(THIS.grd_4c_Dados.Column1.Text1) = "O"
                    THIS.grd_4c_Dados.Column1.Text1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alterar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick
    * Exibe as descricoes das Contas Antiga/Nova da linha corrente do grid.
    * Form OPERACIONAL: nao ha modo VISUALIZAR separado; consulta on-demand.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cContaAnt, loc_cContaNov, loc_cDescAnt, loc_cDescNov, loc_cMsg
        loc_cContaAnt = ""
        loc_cContaNov = ""
        loc_cDescAnt  = ""
        loc_cDescNov  = ""
        TRY
            IF NOT USED("cursor_4c_Contas") OR EOF("cursor_4c_Contas")
                MsgAviso("N" + CHR(227) + "o existem pares de contas para visualizar.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            SELECT cursor_4c_Contas
            loc_cContaAnt = ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, ""))
            loc_cContaNov = ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))
            IF EMPTY(loc_cContaAnt) AND EMPTY(loc_cContaNov)
                MsgAviso("Linha corrente n" + CHR(227) + "o tem contas preenchidas.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF NOT EMPTY(loc_cContaAnt)
                loc_cDescAnt = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cContaAnt)
            ENDIF
            IF NOT EMPTY(loc_cContaNov)
                loc_cDescNov = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cContaNov)
            ENDIF
            loc_cMsg = "Conta Antiga: " + loc_cContaAnt + CHR(13) + ;
                       "Descri" + CHR(231) + CHR(227) + "o.: " + loc_cDescAnt + CHR(13) + CHR(13) + ;
                       "Conta Nova..: " + loc_cContaNov + CHR(13) + ;
                       "Descri" + CHR(231) + CHR(227) + "o.: " + loc_cDescNov
            MsgInfo(loc_cMsg, "Visualizar Par de Contas")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Visualizar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick
    * Remove par de contas da linha corrente do grid (equivalente CRUD Excluir).
    * Roteia para CmdExcluirClick (mesmo handler do botao [Excluir] visivel).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF NOT USED("cursor_4c_Contas") OR RECCOUNT("cursor_4c_Contas") = 0
            MsgAviso("N" + CHR(227) + "o existem pares de contas para excluir.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        IF NOT MsgConfirma("Confirma a exclus" + CHR(227) + "o da linha corrente?", ;
            "Confirma" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        THIS.CmdExcluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar o formulario (alias canonico para cmd Encerrar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.CmdSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Focar grid para edicao inline (busca e via F4 no grid)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        TRY
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.SetFocus()
                THIS.grd_4c_Dados.ActiveColumn = 1
            ENDIF
        CATCH TO loc_oErro
            *-- ignorar
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Aciona o processamento principal (semantica CRUD Salvar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa a lista de pares (semantica CRUD Cancelar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO
    * Transfere estado dos controles do form para propriedades do BO.
    * Para este OPERACIONAL: repassa flags dos checkboxes.
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        TRY
            THIS.this_oBusinessObject.this_lCheckCadPro       = THIS.this_lCheckCadPro
            THIS.this_oBusinessObject.this_lTrocarReps        = (THIS.chk_4c_ChkReps.Value = 1)
            THIS.this_oBusinessObject.this_lApagarContaAntiga = (THIS.chk_4c_Chk_DelCT.Value = 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm
    * Carrega propriedades do BO nos controles do form.
    * Para este OPERACIONAL: reflete flags de configuracao nos checkboxes.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        TRY
            THIS.chk_4c_ChkReps.Value   = IIF(THIS.this_oBusinessObject.this_lTrocarReps, 1, 0)
            THIS.chk_4c_Chk_DelCT.Value = IIF(THIS.this_oBusinessObject.this_lApagarContaAntiga, 1, 0)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos
    * Habilita ou desabilita os botoes de acao do formulario.
    * par_lHabilitar: .T. para habilitar, .F. para desabilitar (default .T.)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lAtivar
        loc_lAtivar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        TRY
            WITH THIS.cnt_4c_Botoes
                .cmd_4c_BtnIncluir.Enabled   = loc_lAtivar
                .cmd_4c_BtnExcluir.Enabled   = loc_lAtivar
                .cmd_4c_Exporta.Enabled      = loc_lAtivar
                .cmd_4c_BtnProcessar.Enabled = loc_lAtivar
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            *-- ignorar erro de habilitacao
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos
    * Reinicia cursor_4c_Contas com um registro em branco e limpa checkboxes.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        TRY
            IF USED("cursor_4c_Contas")
                SELECT cursor_4c_Contas
                SET ORDER TO
                ZAP
                APPEND BLANK
            ENDIF
            THIS.chk_4c_ChkReps.Value    = 0
            THIS.chk_4c_Chk_DelCT.Value  = 0
            THIS.chk_4c_Chk_DelCT.Enabled = .T.
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista
    * Atualiza a exibicao do grid com o estado corrente do cursor_4c_Contas.
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar lista")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo
    * Ajusta estado dos botoes conforme conteudo do cursor.
    * Excluir e Processar so ficam ativos se houver pares cadastrados.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_lTemRegistros
        loc_lTemRegistros = USED("cursor_4c_Contas") AND ;
                            NOT EOF("cursor_4c_Contas") AND ;
                            NOT EMPTY(NVL(cursor_4c_Contas.ContaAnt, ""))
        TRY
            WITH THIS.cnt_4c_Botoes
                .cmd_4c_BtnExcluir.Enabled   = loc_lTemRegistros
                .cmd_4c_BtnProcessar.Enabled = loc_lTemRegistros
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            *-- ignorar erro de ajuste
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista
    * Aplica formatacao visual padrao ao grid de pares de contas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

ENDDEFINE
