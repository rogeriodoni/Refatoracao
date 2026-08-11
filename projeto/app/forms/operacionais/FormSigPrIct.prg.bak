*==============================================================================
* FormSigPrIct.prg - Integracao Contabil
* Tipo: OPERACIONAL (layout flat, sem PageFrame de conteudo)
* Herda de: FormBase
* Legado: SigPrIct.SCX / SIGPRICT.SCX
*
* Fluxo:
*   1. Usuario informa periodo (DataI/DataF) e clica Processar
*   2. SigPrIctBO.InicializarCursores() cria cursores temporarios
*   3. SigPrIctBO.Processar() processa SigMvCcr no periodo
*   4. Se this_lTemDiferencas: pergunta sobre FormSigReDif (diferencas)
*   5. Se this_lTemInconsistencias: mostra botoes Video/Imprimir/Gravar
*   6. SigPrIctBO.GerarArquivoContabil() gera CTPV*.EMP em DirContabv
*
* Dimensoes legado: Width=800 x Height=192
*==============================================================================

DEFINE CLASS FormSigPrIct AS FormBase

    *-- Dimensoes identicas ao legado
    Width        = 800
    Height       = 192
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    DataSession  = 2
    ClipControls = .F.
    Caption      = ""
    FontName     = "Tahoma"
    FontSize     = 8

    *==========================================================================
    PROCEDURE Init()
    *-- Seta Caption antes de DODEFAULT() -> FormBase.Init() -> InicializarForm()
    *==========================================================================
        THIS.Caption = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *-- Fundo identico ao legado (Picture = fundo_cadastro.jpg / new_background.jpg)
    *==========================================================================
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImg)
            THIS.Picture = loc_cImg
        ENDIF
        THIS.ScrollBars = 0
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *-- Container cabecalho cinza (equivalente ao cntSombra do legado)
    *==========================================================================
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
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = ""
                .Height        = 40
                .Left          = 10
                .Top           = 0
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize    = .F.
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = ""
                .Height      = 46
                .Left        = 10
                .Top         = 3
                .Width       = THIS.Width
                .ForeColor   = RGB(255,255,255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            ENDWITH
            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *-- Cria BO, carrega parametros e monta estrutura visual completa
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
            ELSE
                THIS.this_oBusinessObject = CREATEOBJECT("SigPrIctBO")
                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Falha ao criar SigPrIctBO.", "Erro")
                ELSE
                    IF NOT THIS.this_oBusinessObject.CarregarParametros()
                        MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema.", "Erro")
                    ELSE
                        THIS.ConfigurarPageFrame()
                        THIS.ConfigurarCabecalho()
                        THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                        THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                        THIS.ConfigurarCampos()
                        THIS.ConfigurarBotoes()
                        THIS.ConfigurarPosProcessamento()
                        THIS.PopularCamposIniciais()
                        THIS.TornarControlesVisiveis()
                        THIS.ConfigurarEventos()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
                    loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
    *-- Labels "Inicial :"/"Final :" e TextBoxes de data (legado: Label2/3 + Get_DataI/F)
    *==========================================================================
        THIS.AddObject("lbl_4c_LblIni", "Label")
        WITH THIS.lbl_4c_LblIni
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Inicial : "
            .Height    = 15
            .Left      = 186
            .Top       = 108
            .Width     = 43
            .ForeColor = RGB(90,90,90)
        ENDWITH

        THIS.AddObject("txt_4c_DataI", "TextBox")
        WITH THIS.txt_4c_DataI
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 227
            .Top           = 105
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
        ENDWITH

        THIS.AddObject("lbl_4c_LblFin", "Label")
        WITH THIS.lbl_4c_LblFin
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Final : "
            .Height    = 15
            .Left      = 191
            .Top       = 141
            .Width     = 36
            .ForeColor = RGB(90,90,90)
        ENDWITH

        THIS.AddObject("txt_4c_DataF", "TextBox")
        WITH THIS.txt_4c_DataF
            .Value         = {}
            .Format        = "K"
            .Height        = 23
            .Left          = 227
            .Top           = 137
            .Width         = 80
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
        ENDWITH

        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = " Per" + CHR(237) + "odo "
            .Height    = 15
            .Left      = 132
            .Top       = 141
            .Width     = 51
            .ForeColor = RGB(90,90,90)
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = " Per" + CHR(237) + "odo "
            .Height    = 15
            .Left      = 132
            .Top       = 108
            .Width     = 51
            .ForeColor = RGB(90,90,90)
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
    *-- Processar + Encerrar (equivalente ao btnReport principal do legado)
    *-- Processar: Left=321 Top=95 | Encerrar: Left=401 Top=95
    *==========================================================================
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 95
            .Left            = 321
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 95
            .Left            = 401
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPosProcessamento()
    *-- Container com botoes Video/Imprimir/Encerrar, visivel apenas apos
    *-- processamento com inconsistencias. Cobre area dos botoes principais.
    *-- Equivalente ao cntBotoes legado (Left=247 Top=88 Width=252 quando visivel)
    *==========================================================================
        THIS.AddObject("cnt_4c_PosProc", "Container")
        WITH THIS.cnt_4c_PosProc
            .Top         = 88
            .Left        = 247
            .Width       = 252
            .Height      = 90
            .BackStyle   = 1
            .BackColor   = RGB(214,222,233)
            .BorderWidth = 0
            .Visible     = .F.

            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Top             = 5
                .Left            = 5
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .Caption         = " V" + CHR(237) + "deo    "
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
            ENDWITH

            .AddObject("cmd_4c_Imprimir", "CommandButton")
            WITH .cmd_4c_Imprimir
                .Top             = 5
                .Left            = 80
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .Caption         = "Impressora"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .T.
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
            ENDWITH

            .AddObject("cmd_4c_Sair", "CommandButton")
            WITH .cmd_4c_Sair
                .Top             = 5
                .Left            = 163
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .WordWrap        = .T.
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .T.
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE PopularCamposIniciais()
    *-- Inicializa datas com data corrente (legado: .Get_Datai.Value = Date())
    *==========================================================================
        THIS.txt_4c_DataI.Value = DATE()
        THIS.txt_4c_DataF.Value = DATE()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
    *==========================================================================
        BINDEVENT(THIS.cmd_4c_Processar,                  "Click", THIS, "CmdProcessarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,                   "Click", THIS, "CmdEncerrarClick")
        BINDEVENT(THIS.cnt_4c_PosProc.cmd_4c_Visualizar,  "Click", THIS, "CmdVisualizarClick")
        BINDEVENT(THIS.cnt_4c_PosProc.cmd_4c_Imprimir,    "Click", THIS, "CmdImprimirClick")
        BINDEVENT(THIS.cnt_4c_PosProc.cmd_4c_Sair,        "Click", THIS, "CmdGravarEncerrarClick")
    ENDPROC

    *==========================================================================
    PROCEDURE CmdProcessarClick()
    *-- Valida datas, confirma e dispara ChamarProcessar
    *==========================================================================
        IF EMPTY(THIS.txt_4c_DataI.Value)
            MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!")
            THIS.txt_4c_DataI.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(THIS.txt_4c_DataF.Value)
            MsgAviso("Data Final Inv" + CHR(225) + "lida!!!")
            THIS.txt_4c_DataF.SetFocus()
            RETURN
        ENDIF
        IF THIS.txt_4c_DataF.Value < THIS.txt_4c_DataI.Value
            MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!")
            THIS.txt_4c_DataF.SetFocus()
            RETURN
        ENDIF
        IF NOT MsgConfirma("Confirma o Processamento ?")
            RETURN
        ENDIF
        THIS.ChamarProcessar()
    ENDPROC

    *==========================================================================
    PROCEDURE ChamarProcessar()
    *-- Executa InicializarCursores + Processar no BO e trata resultados
    *==========================================================================
        LOCAL loc_lResultado, loc_oErro, loc_oDifErro
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.InicializarCursores()

            loc_lResultado = THIS.this_oBusinessObject.Processar( ;
                THIS.txt_4c_DataI.Value, ;
                THIS.txt_4c_DataF.Value)

            IF loc_lResultado
                *-- Verifica diferencas entre debitos e creditos (legado: SigReDif)
                IF THIS.this_oBusinessObject.this_lTemDiferencas
                    IF MsgConfirma("Visualizar as diferen" + CHR(231) + "as na Tela?")
                        TRY
                            DO FORM FormSigReDif WITH THIS.DataSessionId
                        CATCH TO loc_oDifErro
                            MsgAviso("Formul" + CHR(225) + "rio SigReDif n" + CHR(227) + ;
                                     "o dispon" + CHR(237) + "vel.")
                        ENDTRY
                    ENDIF
                    THIS.this_oBusinessObject.this_lTemDiferencas = .F.
                ENDIF

                *-- Verifica inconsistencias (SemConta com contas sem mapeamento)
                IF THIS.this_oBusinessObject.this_lTemInconsistencias AND ;
                   USED("SemConta") AND RECCOUNT("SemConta") > 0
                    *-- Exibe container pos-processamento (Video/Imprimir/Encerrar)
                    *-- e bloqueia inputs ate decisao do usuario
                    THIS.cmd_4c_Processar.Enabled = .F.
                    THIS.txt_4c_DataI.Enabled     = .F.
                    THIS.txt_4c_DataF.Enabled     = .F.
                    THIS.cnt_4c_PosProc.Visible   = .T.
                ELSE
                    *-- Sem inconsistencias: avisa e vai direto para geracao do arquivo
                    IF USED("MovAux") AND RECCOUNT("MovAux") > 0
                        MsgAviso("Nenhuma Inconsist" + CHR(234) + "ncia Foi Encontrada!!!")
                    ELSE
                        MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + ;
                                 CHR(227) + "o no Per" + CHR(237) + "odo!!!")
                    ENDIF
                    THIS.ChamarGravar()
                ENDIF
            ELSE
                IF NOT EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro no processamento: " + loc_oErro.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE CmdVisualizarClick()
    *-- Exibe relatorio de inconsistencias em preview e chama ChamarGravar
    *==========================================================================
        THIS.ExecutarRelatorioInconsistencias("PREVIEW")
    ENDPROC

    *==========================================================================
    PROCEDURE CmdImprimirClick()
    *-- Imprime relatorio de inconsistencias e chama ChamarGravar
    *==========================================================================
        THIS.ExecutarRelatorioInconsistencias("PRINT")
    ENDPROC

    *==========================================================================
    PROCEDURE CmdGravarEncerrarClick()
    *-- Botao Encerrar do pos-processamento: apenas confirma geracao do arquivo
    *==========================================================================
        THIS.ChamarGravar()
    ENDPROC

    *==========================================================================
    PROCEDURE ChamarGravar()
    *-- Restaura UI, confirma e delega geracao do arquivo contabil ao BO
    *-- Equivalente ao PROCEDURE gravar do legado
    *==========================================================================
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        *-- Restaura interface (equivalente: cntBotoes.Visible=.F. + reenablecontrols)
        THIS.cnt_4c_PosProc.Visible   = .F.
        THIS.cmd_4c_Processar.Enabled = .T.
        THIS.txt_4c_DataI.Enabled     = .T.
        THIS.txt_4c_DataF.Enabled     = .T.

        IF MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo?")
            TRY
                loc_lResultado = THIS.this_oBusinessObject.GerarArquivoContabil()
                IF NOT loc_lResultado AND ;
                   NOT EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao gerar arquivo: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE ExecutarRelatorioInconsistencias(par_cModo)
    *-- Exibe relatorio SIGPRICT (inconsistencias de integracao contabil)
    *-- par_cModo: "PREVIEW" ou "PRINT"
    *-- Apos exibicao chama ChamarGravar() para confirmar geracao do arquivo
    *==========================================================================
        LOCAL loc_cFrx, loc_cSavedPoint, loc_cSavedSep
        LOCAL loc_nSavedBehavior, loc_oErro

        IF NOT USED("SemConta") OR RECCOUNT("SemConta") = 0
            MsgAviso("Nenhuma inconsist" + CHR(234) + "ncia para exibir.")
            THIS.ChamarGravar()
            RETURN
        ENDIF

        loc_cFrx = FULLPATH(gc_4c_CaminhoReports + "SIGPRICT.frx")
        IF NOT FILE(loc_cFrx)
            MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + ;
                    loc_cFrx, "Erro")
            THIS.ChamarGravar()
            RETURN
        ENDIF

        loc_cSavedPoint    = SET("POINT")
        loc_cSavedSep      = SET("SEPARATOR")
        loc_nSavedBehavior = _REPORTBEHAVIOR

        SET POINT TO "."
        SET SEPARATOR TO ","
        _REPORTBEHAVIOR = 80

        TRY
            IF UPPER(ALLTRIM(par_cModo)) = "PRINT"
                REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
            ELSE
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao exibir relat" + CHR(243) + "rio: " + loc_oErro.Message, "Erro")
        ENDTRY

        SET POINT TO (loc_cSavedPoint)
        SET SEPARATOR TO (loc_cSavedSep)
        _REPORTBEHAVIOR = loc_nSavedBehavior

        THIS.ChamarGravar()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *-- Form OPERACIONAL flat (Width=800 x Height=192): NAO existe PageFrame,
    *-- NAO existe grid de lista e NAO existe fluxo Page1=Lista/Page2=Dados.
    *-- Layout SCX legado (SigPrIct.SCX): cntSombra + Get_DataI/F + btnReport +
    *-- cntBotoes flutuante. Toda a estrutura visual e criada em ConfigurarCampos,
    *-- ConfigurarBotoes e ConfigurarPosProcessamento, chamados em InicializarForm.
    *-- Metodo mantido apenas para satisfazer contrato do pipeline multi-fase; nao
    *-- ha nada a configurar em uma "Page Lista" que nao existe neste form.
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *-- Form OPERACIONAL flat (Width=800 x Height=192): NAO existe Page2 de dados.
    *-- O SCX legado (SIGPRICT) nao tem PageFrame de conteudo; todos os campos
    *-- (Get_DataI, Get_DataF, labels de periodo) e botoes sao filhos diretos
    *-- do form. Toda a estrutura foi criada em ConfigurarCampos(), ConfigurarBotoes()
    *-- e ConfigurarPosProcessamento(), chamados em InicializarForm().
    *-- Metodo mantido apenas para satisfazer contrato do pipeline multi-fase.
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    *-- Form OPERACIONAL flat: NAO possui PageFrame nem multiplas pages para
    *-- alternar. A alternancia de UI se da via visibility toggle no container
    *-- cnt_4c_PosProc (metodos ChamarProcessar/ChamarGravar controlam Visible).
    *-- Assinatura preservada para satisfazer contrato do pipeline multi-fase.
    *==========================================================================
        LOCAL loc_nIgnorado
        loc_nIgnorado = par_nPagina
        RETURN
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
    *-- Torna visiveis todos os controles exceto containers/labels flutuantes:
    *-- cnt_4c_PosProc (visivel apenas apos processamento com inconsistencias)
    *-- lbl_4c_Label4 (oculto por design como no legado, Visible=.F.)
    *-- cnt_4c_Cabecalho (header fixo, ignorado completamente pelo loop)
    *==========================================================================
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oCtrl = THIS.Controls[loc_i]
            IF VARTYPE(loc_oCtrl) = "O"
                IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_CABECALHO")
                    IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                        THIS.TornarFilhosVisiveis(loc_oCtrl)
                    ENDIF
                    LOOP
                ENDIF
                IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_POSPROC", "LBL_4C_LABEL4")
                    IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                        THIS.TornarFilhosVisiveis(loc_oCtrl)
                    ENDIF
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarFilhosVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarFilhosVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls[loc_i]
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarFilhosVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *-- Form OPERACIONAL flat: NAO possui fluxo de inclusao de registro.
    *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *-- Form OPERACIONAL flat: NAO possui fluxo de alteracao de registro.
    *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *-- Form OPERACIONAL flat: a acao de visualizacao e CmdVisualizarClick()
    *-- (relatorio de inconsistencias pos-processamento). Stub mantido para
    *-- satisfazer contrato do pipeline multi-fase.
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *-- Form OPERACIONAL flat: NAO possui fluxo de exclusao de registro.
    *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *-- Form OPERACIONAL flat: NAO possui fluxo de busca de registro.
    *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick()
    *-- Form OPERACIONAL flat: NAO possui fluxo de gravacao CRUD.
    *-- Salvamento efetivo se da via ChamarGravar() apos processamento.
    *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *-- Form OPERACIONAL flat: NAO possui fluxo de cancelamento CRUD.
    *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *-- Transfere os campos de data informados pelo usuario para o BO.
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_dDataI = THIS.txt_4c_DataI.Value
            THIS.this_oBusinessObject.this_dDataF = THIS.txt_4c_DataF.Value
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *-- Restaura os campos de data a partir do estado do BO.
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        IF !EMPTY(THIS.this_oBusinessObject.this_dDataI)
            THIS.txt_4c_DataI.Value = THIS.this_oBusinessObject.this_dDataI
        ENDIF
        IF !EMPTY(THIS.this_oBusinessObject.this_dDataF)
            THIS.txt_4c_DataF.Value = THIS.this_oBusinessObject.this_dDataF
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *-- Habilita ou desabilita os campos de entrada e o botao Processar.
    *==========================================================================
        IF PEMSTATUS(THIS, "txt_4c_DataI", 5)
            THIS.txt_4c_DataI.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DataF", 5)
            THIS.txt_4c_DataF.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.cmd_4c_Processar.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
    *-- Redefine os campos de data para a data corrente (estado inicial).
    *==========================================================================
        THIS.txt_4c_DataI.Value = DATE()
        THIS.txt_4c_DataF.Value = DATE()
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista()
    *-- Form OPERACIONAL flat: NAO possui grade de registros para carregar.
    *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
    *==========================================================================
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    *-- Form OPERACIONAL flat: NAO possui modos INCLUIR/ALTERAR/VISUALIZAR.
    *-- O estado dos botoes e controlado diretamente em ChamarProcessar/Gravar.
    *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
    *==========================================================================
        RETURN
    ENDPROC

ENDDEFINE
