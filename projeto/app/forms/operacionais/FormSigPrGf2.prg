*==============================================================================
* FormSigPrGf2.prg - Gr" + CHR(225) + "fico de Falha X Recupera" + CHR(231) + CHR(227) + "o Mensal
* Herda de: FormBase (app/classes/formbase.prg)
* Form OPERACIONAL - visualiza" + CHR(231) + CHR(227) + "o de gr" + CHR(225) + "fico MSGraph
* Migrado de: SIGPRGF2.SCX
* Fase 3/8: Estrutura base (containers principais)
*==============================================================================
DEFINE CLASS FormSigPrGf2 AS FormBase

    *-- Referencia ao form chamador (compartilha datasession para acessar crRel1)
    poForm1         = .NULL.
    *-- Modo operacional
    this_cModoAtual = "OPERACIONAL"

    *-- Propriedades visuais (copiadas do original SIGPRGF2.SCX)
    Width       = 800
    Height      = 600
    DataSession = 2
    ShowWindow = 1
    AutoCenter  = .T.
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    FontName    = "Arial"
    FontSize    = 9

    *==========================================================================
    * Init - Inicializa form; recebe referencia ao form chamador (tem crRel1)
    * par_loForm1: form pai que preparou o cursor crRel1 com dados do gr" + CHR(225) + "fico
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_loForm1

        *-- Compartilha datasession com form chamador para acessar crRel1
        IF VARTYPE(par_loForm1) = "O"
            THIS.poForm1       = par_loForm1
            THIS.DataSessionId = par_loForm1.DataSessionId
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO e estrutura base de containers
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGf2BO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrGf2BO", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Propriedades do form que exigem CHR() (nao permitidas em literais .prg)
            THIS.Caption = "Gr" + CHR(225) + "fico de Falha X Recupera" + CHR(231) + CHR(227) + "o Mensal"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Estrutura de containers
            THIS.ConfigurarCabecalho()
            THIS.AdicionarContainerGrafico()
            THIS.AdicionarContainerAguarde()
            THIS.AdicionarContainerCombo()

            *-- Torna controles visiveis; skip containers flutuantes (ocultos por design)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - container cinza com t" + CHR(237) + "tulo sombreado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption

        loc_cCaption = "Gr" + CHR(225) + "fico de Falha X Recupera" + CHR(231) + CHR(227) + "o Mensal"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .AutoSize  = .F.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = loc_cCaption
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .AutoSize  = .F.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = loc_cCaption
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * AdicionarContainerGrafico - area onde OLEBoundControl sera inserido
    * Fase 5 adiciona obj_4c_OleGrafico1 dentro deste container
    * Inicia oculto; exibido apos mGeraGrafico() em Fase 7
    *==========================================================================
    PROTECTED PROCEDURE AdicionarContainerGrafico()
        THIS.AddObject("cnt_4c_Grf1", "Container")
        WITH THIS.cnt_4c_Grf1
            .Top           = 120
            .Left          = 17
            .Width         = 770
            .Height        = 429
            .BackStyle     = 1
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .BorderWidth   = 0
            .Visible       = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AdicionarContainerAguarde - indicador visual de carregamento
    * Inicia oculto; exibido via .Visible=.T. antes de mGeraGrafico()
    *==========================================================================
    PROTECTED PROCEDURE AdicionarContainerAguarde()
        THIS.AddObject("cnt_4c_Aguarde", "Container")
        WITH THIS.cnt_4c_Aguarde
            .Top           = 288
            .Left          = 312
            .Width         = 207
            .Height        = 49
            .BorderWidth   = 5
            .SpecialEffect = 0
            .BackStyle     = 1
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .F.

            .AddObject("lbl_4c_Aguarde1", "Label")
            WITH .lbl_4c_Aguarde1
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Verdana"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Aguarde..."
                .Height    = 18
                .Left      = 69
                .Top       = 7
                .Width     = 78
                .ForeColor = RGB(255, 0, 0)
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Aguarde2", "Label")
            WITH .lbl_4c_Aguarde2
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Verdana"
                .FontSize  = 10
                .BackStyle = 0
                .Caption   = "Processando Dados..."
                .Height    = 18
                .Left      = 34
                .Top       = 24
                .Width     = 159
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * AdicionarContainerCombo - container do ComboBox de navega" + CHR(231) + CHR(227) + "o entre grupos
    * Fase 6 adiciona cbo_4c_CmbChave1 e lbl_4c_LblChave1 dentro deste container
    * Inicia oculto; exibido apos primeiro grafico ser gerado em Fase 7
    *==========================================================================
    PROTECTED PROCEDURE AdicionarContainerCombo()
        THIS.AddObject("cnt_4c_Grf2", "Container")
        WITH THIS.cnt_4c_Grf2
            .Top           = 558
            .Left          = 559
            .Width         = 228
            .Height        = 35
            .BackStyle     = 1
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .BorderWidth   = 0
            .Visible       = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna controles visiveis recursivamente
    * SKIP: containers flutuantes que iniciam ocultos por design de negocio:
    *   - cnt_4c_Grf1: mostrado apos grafico ser gerado
    *   - cnt_4c_Aguarde: mostrado durante processamento
    *   - cnt_4c_Grf2: mostrado apos grafico ser gerado (se >1 chave)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oCtrl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oCtrl) != "O"
                LOOP
            ENDIF

            *-- Containers flutuantes: tornar filhos visiveis, mas manter container oculto
            IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_GRF1", "CNT_4C_AGUARDE", "CNT_4C_GRF2")
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF

            IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
                LOCAL loc_nP
                FOR loc_nP = 1 TO loc_oCtrl.PageCount
                    THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_nP))
                ENDFOR
            ENDIF

            IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oCtrl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - libera recursos ao fechar o form
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            *-- Desativa ControlSource do OLE antes de fechar cursor (evita erro)
            IF VARTYPE(THIS.cnt_4c_Grf1) = "O"
                IF PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
                    THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
                ENDIF
            ENDIF

            IF USED("crGrafico1")
                USE IN crGrafico1
            ENDIF

            IF USED("cursor_4c_Chaves")
                USE IN cursor_4c_Chaves
            ENDIF

            THIS.poForm1 = .NULL.

        CATCH TO loc_oErro
            *-- Erros em Destroy sao ignorados; form ja esta fechando
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
