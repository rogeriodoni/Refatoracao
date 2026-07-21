*==============================================================================
* FormSigPrItb.prg - Integracao Contabil Total (OPERACIONAL)
* Herda de: FormBase
* Origem: SIGPRITB.SCX
* BO: SigPrItbBO
* Layout: flat (sem PageFrame) - proporcional 800x229 x 1.25 = 1000x300
*==============================================================================

DEFINE CLASS FormSigPrItb AS FormBase

    *-- Business Object e estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = ""

    *-- Propriedades visuais (Pilar 1 - preserva TitleBar=0/ControlBox=.F. do original)
    Caption       = ""
    Width         = 1000
    Height        = 300
    TitleBar      = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox    = .F.
    Closable      = .F.
    MinButton     = .F.
    ClipControls  = .F.
    AutoCenter    = .T.

    *==========================================================================
    * Init - FormBase.Init() chama InicializarForm() automaticamente
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Criacao e configuracao de todos os objetos do form
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Integra" + CHR(231) + CHR(227) + ;
                           "o Cont" + CHR(225) + "bil Total"

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrItbBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrItbBO.", "Erro")
            ELSE
                THIS.CriarCursorMovAux()
                THIS.ConfigurarInterface()
                THIS.TornarControlesVisiveis(THIS)

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.InicializarDados()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CriarCursorMovAux - Cursor de saida para arquivo contabil
    * Estrutura identica ao CREATE CURSOR MovAux do PROCEDURE Load original
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorMovAux()
        SET NULL ON
        IF USED("MovAux")
            SELECT MovAux
            ZAP
        ELSE
            CREATE CURSOR MovAux (AnoFis  C(04) NULL, ;
                                   Datas   C(08) NULL, ;
                                   Contas  C(09) NULL, ;
                                   Debs    C(12) NULL, ;
                                   Creds   C(12) NULL, ;
                                   Docto   C(10) NULL, ;
                                   Hists   C(70) NULL, ;
                                   EmpCont C(03) NULL)
            INDEX ON EmpCont + Datas TAG EmpCont
            SET ORDER TO "" IN MovAux
        ENDIF
        SET NULL OFF
    ENDPROC

    *==========================================================================
    * ConfigurarInterface - Orquestra criacao de todos os containers
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarInterface()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarContainerBotoes()
        THIS.ConfigurarContainerSaida()
        THIS.ConfigurarContainerAguarde()
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Nao aplicavel a este form OPERACIONAL
    * SIGPRITB e um dialog flat (sem PageFrame) - orquestracao real ocorre em
    * ConfigurarInterface(). Metodo mantido para satisfazer contrato multi-fase.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        RETURN
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza escuro com titulo (cntSombra)
    * Escalonado: Height=80 x 1.25 = 100; Width=800 x 1.25 = 1000
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cTitulo, loc_oCab
        loc_cTitulo = "Integra" + CHR(231) + CHR(227) + ;
                      "o Cont" + CHR(225) + "bil Total"

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 100
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .BackStyle = 0
            .Caption   = loc_cTitulo
            .Height    = 50
            .Left      = 10
            .Top       = 22
            .Width     = loc_oCab.Width - 20
            .ForeColor = RGB(0,0,0)
            .WordWrap  = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .BackStyle = 0
            .Caption   = loc_cTitulo
            .Height    = 58
            .Left      = 10
            .Top       = 21
            .Width     = loc_oCab.Width - 20
            .ForeColor = RGB(255,255,255)
            .WordWrap  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Container de parametros de entrada (periodo + empresa)
    * Equivalente logico da "Page Dados" CRUD para este form OPERACIONAL flat.
    * Fase 5: cria cnt_4c_Mvt1 + primeira metade dos controles (secao periodo:
    *         lbl_4c_Periodo, txt_4c_Data1, lbl_4c_PeriodoA, txt_4c_Data2).
    * Escalonado 1.25x: Top=94->118; Left=132->165; Width=389->486; Height=60->75
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Mvt1", "Container")
        loc_oCnt = THIS.cnt_4c_Mvt1
        WITH loc_oCnt
            .Top           = 118
            .Left          = 165
            .Width         = 486
            .Height        = 75
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
        ENDWITH

        *-- Label "Periodo :"
        loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oCnt.lbl_4c_Periodo
            .AutoSize  = .F.
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Height    = 19
            .Left      = 16
            .Top       = 12
            .Width     = 56
        ENDWITH

        *-- TextBox Data Inicial (getData1 original)
        loc_oCnt.AddObject("txt_4c_Data1", "TextBox")
        WITH loc_oCnt.txt_4c_Data1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "DK"
            .Height        = 31
            .Left          = 79
            .Top           = 6
            .Width         = 99
            .ForeColor     = RGB(90,90,90)
            .SpecialEffect = 1
            .Value         = DATE()
        ENDWITH

        *-- Label "a" (separador de periodo - original Caption = CHR(224))
        loc_oCnt.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oCnt.lbl_4c_PeriodoA
            .AutoSize  = .F.
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Height    = 19
            .Left      = 182
            .Top       = 11
            .Width     = 14
        ENDWITH

        *-- TextBox Data Final (getData2 original)
        loc_oCnt.AddObject("txt_4c_Data2", "TextBox")
        WITH loc_oCnt.txt_4c_Data2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "DK"
            .Height        = 31
            .Left          = 199
            .Top           = 6
            .Width         = 99
            .ForeColor     = RGB(90,90,90)
            .SpecialEffect = 1
            .Value         = DATE()
        ENDWITH

        *-- Label "Empresa :" (lbl_empresa original: top=37->46, left=8->10, width=50->62)
        loc_oCnt.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oCnt.lbl_4c_Empresa
            .AutoSize  = .F.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Height    = 19
            .Left      = 10
            .Top       = 46
            .Width     = 62
        ENDWITH

        *-- TextBox Codigo Empresa (getEmp1 original - MaxLength=3 OBRIGATORIO SigCdEmp.Cemps)
        loc_oCnt.AddObject("txt_4c_Emp1", "TextBox")
        WITH loc_oCnt.txt_4c_Emp1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 31
            .Left          = 79
            .Top           = 40
            .Width         = 39
            .MaxLength     = 3
            .ForeColor     = RGB(90,90,90)
            .SpecialEffect = 0
            .Value         = SPACE(3)
        ENDWITH

        *-- TextBox Descricao Empresa (getDsemp1 original: left=94->118, width=290->362)
        loc_oCnt.AddObject("txt_4c_Dsemp1", "TextBox")
        WITH loc_oCnt.txt_4c_Dsemp1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 31
            .Left          = 118
            .Top           = 40
            .Width         = 362
            .MaxLength     = 40
            .ForeColor     = RGB(90,90,90)
            .SpecialEffect = 1
            .Value         = SPACE(40)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerBotoes - Container dos botoes de relatorio (cntBotoes)
    * Escalonado: Left=496->620; Width=156->195; Height=84->105
    * CommandGroup interno adicionado na Fase 4
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerBotoes()
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top         = 1
            .Left        =  542
            .Width       = 195
            .Height      = 105
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerSaida - Botao Encerrar canonico
    * Padrao: Left=917, Width=90, Height=85 (CLAUDE.md Regra #10)
    * cmd_4c_Encerrar adicionado na Fase 4
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerSaida()
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top         = 0
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerAguarde - Painel de progresso (inicia oculto)
    * Escalonado: Top=163->204; Left=284->355; Width=207->259; Height=49->61
    * TornarControlesVisiveis filtra este container (Visible=.F. por design)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerAguarde()
        LOCAL loc_oAgu
        THIS.AddObject("cnt_4c_Aguarde", "Container")
        loc_oAgu = THIS.cnt_4c_Aguarde
        WITH loc_oAgu
            .Top           = 204
            .Left          = 355
            .Width         = 259
            .Height        = 61
            .BorderWidth   = 6
            .SpecialEffect = 0
            .BackStyle     = 1
            .BackColor     = RGB(255,255,255)
            .Visible       = .F.
        ENDWITH

        loc_oAgu.AddObject("lbl_4c_Aguarde", "Label")
        WITH loc_oAgu.lbl_4c_Aguarde
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Verdana"
            .FontSize  = 10
            .BackStyle = 0
            .Caption   = "Aguarde..."
            .Height    = 23
            .Left      = 85
            .Top       = 9
            .Width     = 98
            .ForeColor = RGB(255,0,0)
        ENDWITH

        loc_oAgu.AddObject("lbl_4c_Processando", "Label")
        WITH loc_oAgu.lbl_4c_Processando
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 9
            .BackStyle = 0
            .Caption   = "Processando Dados..."
            .Height    = 20
            .Left      = 48
            .Top       = 30
            .Width     = 166
            .ForeColor = RGB(90,90,90)
        ENDWITH
    ENDPROC

    *==========================================================================
    * InicializarDados - Inicializa valores dos campos e carrega SigCdPam
    *==========================================================================
    PROTECTED PROCEDURE InicializarDados()
        LOCAL loc_cSQL, loc_oErro
        TRY
            *-- Inicializar campos de periodo com data corrente (equivalente ao Init legado)
            IF PEMSTATUS(THIS.cnt_4c_Mvt1, "txt_4c_Data1", 5)
                THIS.cnt_4c_Mvt1.txt_4c_Data1.Value = DATE()
                THIS.cnt_4c_Mvt1.txt_4c_Data2.Value = DATE()
            ENDIF

            *-- Carregar diretorio contabil de SigCdPam
            loc_cSQL = "SELECT DirContabv FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND !EOF("cursor_4c_Pam")
                    THIS.this_oBusinessObject.this_cDirContab = ;
                        ALLTRIM(NVL(cursor_4c_Pam.DirContabv, ""))
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar dados: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Recursivo; FILTRO: cnt_4c_Aguarde inicia oculto
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) != "O"
                LOOP
            ENDIF

            IF UPPER(loc_oControl.Name) = "CNT_4C_AGUARDE"
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
               loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Para form OPERACIONAL: configura botoes de acao
    * Equivalente logico do fase-4 CRUD: adiciona controles interativos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotoesRelatorio()
        THIS.ConfigurarBotaoProcessar()
        THIS.ConfigurarBotaoEncerrar()
        THIS.ConfigurarEventos()
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesRelatorio - Visualizar + Imprimir em cnt_4c_Botoes
    * Iniciam DESABILITADOS; habilitam apos ProcessarIntegracao com inconsistencias
    * Icones: relatorio_video_26.jpg / relatorio_impressora_26.jpg
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Botoes

        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
            .Top             = 5
            .Left            = 6
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "V" + CHR(237) + "deo"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Imprimir
            .Top             = 5
            .Left            = 100
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .WordWrap        = .T.
            .Caption         = "Impressora"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 13
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoProcessar - Adiciona cmd_4c_Processar ao form
    * Posicao proporcional ao original (Left=649/3 em 800px -> 811/4 em 1000px)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoProcessar()
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 4
            .Left            = 811
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
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
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoEncerrar - Adiciona cmd_4c_Encerrar ao cnt_4c_Saida
    * Padrao canonico: Left=5, Top=5, Width=75, Height=75 (CLAUDE.md #10)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
        LOCAL loc_oSaida
        loc_oSaida = THIS.cnt_4c_Saida

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Top             = 5
            .Left            = 5
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
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
    * ConfigurarEventos - Vincula handlers via BINDEVENT (metodos PUBLIC obrigatorio)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmd_4c_Processar,                 "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(THIS.cnt_4c_Mvt1.txt_4c_Emp1,         "KeyPress", THIS, "TxtEmp1KeyPress")
        BINDEVENT(THIS.cnt_4c_Mvt1.txt_4c_Emp1,         "DblClick", THIS, "TxtEmp1DblClick")
        BINDEVENT(THIS.cnt_4c_Mvt1.txt_4c_Dsemp1,       "KeyPress", THIS, "TxtDsemp1KeyPress")
        BINDEVENT(THIS.cnt_4c_Mvt1.txt_4c_Dsemp1,       "DblClick", THIS, "TxtDsemp1DblClick")
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna estado visual do form OPERACIONAL
    *   "PROCESSANDO" : exibe Aguarde, bloqueia inputs e Processar
    *   "RESULTADO"   : habilita Imprimir/Visualizar, bloqueia inputs
    *   "INICIAL"     : restaura estado inicial (todos inputs habilitados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_cEstado)
        LOCAL loc_lInputsExistem
        loc_lInputsExistem = PEMSTATUS(THIS.cnt_4c_Mvt1, "txt_4c_Data1", 5)

        DO CASE
        CASE par_cEstado = "PROCESSANDO"
            THIS.cnt_4c_Aguarde.Visible       = .T.
            THIS.cmd_4c_Processar.Enabled     = .F.
            IF loc_lInputsExistem
                THIS.cnt_4c_Mvt1.txt_4c_Data1.Enabled  = .F.
                THIS.cnt_4c_Mvt1.txt_4c_Data2.Enabled  = .F.
                THIS.cnt_4c_Mvt1.txt_4c_Emp1.Enabled   = .F.
                THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Enabled = .F.
            ENDIF
            THIS.Refresh()

        CASE par_cEstado = "RESULTADO"
            THIS.cnt_4c_Aguarde.Visible                   = .F.
            THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
            THIS.cnt_4c_Botoes.cmd_4c_Imprimir.Enabled   = .T.
            THIS.cmd_4c_Processar.Enabled                 = .F.
            IF loc_lInputsExistem
                THIS.cnt_4c_Mvt1.txt_4c_Data1.Enabled  = .F.
                THIS.cnt_4c_Mvt1.txt_4c_Data2.Enabled  = .F.
                THIS.cnt_4c_Mvt1.txt_4c_Emp1.Enabled   = .F.
                THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Enabled = .F.
            ENDIF
            THIS.Refresh()

        CASE par_cEstado = "INICIAL"
            THIS.cnt_4c_Aguarde.Visible                   = .F.
            THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .F.
            THIS.cnt_4c_Botoes.cmd_4c_Imprimir.Enabled   = .F.
            THIS.cmd_4c_Processar.Enabled                 = .T.
            IF loc_lInputsExistem
                THIS.cnt_4c_Mvt1.txt_4c_Data1.Enabled  = .T.
                THIS.cnt_4c_Mvt1.txt_4c_Data2.Enabled  = .T.
                THIS.cnt_4c_Mvt1.txt_4c_Emp1.Enabled   = .T.
                THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Enabled = .T.
            ENDIF
            THIS.Refresh()
        ENDCASE
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Valida entradas e dispara ProcessarIntegracao
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        IF !PEMSTATUS(THIS.cnt_4c_Mvt1, "txt_4c_Data1", 5)
            MsgAviso("Campos de per" + CHR(237) + "odo ainda n" + CHR(227) + ;
                     "o inicializados.")
            RETURN
        ENDIF

        IF EMPTY(THIS.cnt_4c_Mvt1.txt_4c_Data1.Value)
            MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!")
            THIS.cnt_4c_Mvt1.txt_4c_Data1.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(THIS.cnt_4c_Mvt1.txt_4c_Data2.Value)
            MsgAviso("Data Final Inv" + CHR(225) + "lida!!!")
            THIS.cnt_4c_Mvt1.txt_4c_Data2.SetFocus()
            RETURN
        ENDIF

        IF THIS.cnt_4c_Mvt1.txt_4c_Data2.Value < THIS.cnt_4c_Mvt1.txt_4c_Data1.Value
            MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!")
            THIS.cnt_4c_Mvt1.txt_4c_Data2.SetFocus()
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma o Processamento ?")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_dDataIni   = THIS.cnt_4c_Mvt1.txt_4c_Data1.Value
        THIS.this_oBusinessObject.this_dDataFim   = THIS.cnt_4c_Mvt1.txt_4c_Data2.Value
        THIS.this_oBusinessObject.this_cEmpresa   = ALLTRIM(NVL(THIS.cnt_4c_Mvt1.txt_4c_Emp1.Value,   ""))
        THIS.this_oBusinessObject.this_cDsEmpresa = ALLTRIM(NVL(THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Value, ""))

        THIS.AlternarPagina("PROCESSANDO")

        TRY
            loc_lResultado = THIS.this_oBusinessObject.ProcessarIntegracao()
        CATCH TO loc_oErro
            MsgErro("Erro no processamento: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF loc_lResultado
            IF THIS.this_oBusinessObject.this_lTemInconsistencias
                THIS.AlternarPagina("RESULTADO")
                MsgAviso("Existem Inconsist" + CHR(234) + "ncia(s), " + ;
                         "Favor Checar Pelo Relat" + CHR(243) + "rio Gerado.")
            ELSE
                THIS.cnt_4c_Aguarde.Visible = .F.
                IF USED("MovAux") AND RECCOUNT("MovAux") > 0
                    MsgAviso("Nenhuma Inconsist" + CHR(234) + "ncia Foi Encontrada.")
                    THIS.BtnGravarClick()
                ELSE
                    MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + ;
                             CHR(227) + "o no Per" + CHR(237) + "odo.")
                    THIS.AlternarPagina("INICIAL")
                ENDIF
            ENDIF
        ELSE
            THIS.AlternarPagina("INICIAL")
            IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnGravarClick - Confirma e gera os arquivos contabeis SDF
    * Chamado de BtnProcessarClick quando nao ha inconsistencias em SemConta
    *==========================================================================
    PROCEDURE BtnGravarClick()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        IF !MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo?")
            THIS.AlternarPagina("INICIAL")
            RETURN
        ENDIF

        TRY
            loc_lResultado = THIS.this_oBusinessObject.GravarArquivos()
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar arquivo: " + loc_oErro.Message, "Erro")
        ENDTRY

        THIS.AlternarPagina("INICIAL")
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe relatorio de inconsistencias em preview
    * FRX: SigPrIct.frx (relatorio de integracao contabil, mesmo do FormSigPrIct)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.ExecutarReportForm("SigPrIct", "PREVIEW", "SemConta")
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - Imprime relatorio de inconsistencias
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        THIS.ExecutarReportForm("SigPrIct", "PRINTER_PROMPT", "SemConta")
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia nova execucao da integracao contabil
    * Form OPERACIONAL: mapeia semantica CRUD "Incluir" para "iniciar nova
    * integracao" - restaura estado inicial e reabre inputs para novo processamento.
    * Delega para AlternarPagina + limpeza dos cursores de trabalho.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lPodeReset, loc_lTemDados

        loc_lTemDados = (USED("SemConta") AND RECCOUNT("SemConta") > 0) OR ;
                       (USED("MovAux")   AND RECCOUNT("MovAux")   > 0)

        loc_lPodeReset = .T.
        IF loc_lTemDados
            loc_lPodeReset = MsgConfirma("Descartar a integra" + CHR(231) + CHR(227) + ;
                                         "o atual e iniciar uma nova?")
        ENDIF

        IF !loc_lPodeReset
            RETURN
        ENDIF

        IF USED("MovAux")
            SELECT MovAux
            ZAP
        ENDIF
        IF USED("SemConta")
            SELECT SemConta
            ZAP
        ENDIF
        IF USED("Cabecalho")
            SELECT Cabecalho
            ZAP
        ENDIF

        THIS.this_oBusinessObject.this_lTemInconsistencias = .F.
        THIS.this_oBusinessObject.this_cMensagemErro       = ""

        IF PEMSTATUS(THIS.cnt_4c_Mvt1, "txt_4c_Data1", 5)
            THIS.cnt_4c_Mvt1.txt_4c_Data1.Value  = DATE()
            THIS.cnt_4c_Mvt1.txt_4c_Data2.Value  = DATE()
            THIS.cnt_4c_Mvt1.txt_4c_Emp1.Value   = SPACE(3)
            THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Value = SPACE(40)
        ENDIF

        THIS.AlternarPagina("INICIAL")

        IF PEMSTATUS(THIS.cnt_4c_Mvt1, "txt_4c_Data1", 5)
            THIS.cnt_4c_Mvt1.txt_4c_Data1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Reexecuta a integracao mantendo o periodo/empresa atuais
    * Form OPERACIONAL: mapeia semantica CRUD "Alterar" para "reprocessar" -
    * reabre inputs, permite ajustar parametros e dispara BtnProcessarClick.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        IF !PEMSTATUS(THIS.cnt_4c_Mvt1, "txt_4c_Data1", 5)
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_lTemInconsistencias = .F.
        THIS.this_oBusinessObject.this_cMensagemErro       = ""

        THIS.AlternarPagina("INICIAL")

        IF EMPTY(THIS.cnt_4c_Mvt1.txt_4c_Data1.Value) OR ;
           EMPTY(THIS.cnt_4c_Mvt1.txt_4c_Data2.Value)
            THIS.cnt_4c_Mvt1.txt_4c_Data1.SetFocus()
            RETURN
        ENDIF

        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Descarta dados processados e cancela a operacao atual
    * Form OPERACIONAL: mapeia semantica CRUD "Excluir" para "cancelar/limpar" -
    * apaga cursores MovAux/SemConta/Cabecalho populados por ProcessarIntegracao
    * e retorna a UI para estado INICIAL. Nao remove dados da base (SigPrMov).
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lTemDados

        loc_lTemDados = (USED("SemConta") AND RECCOUNT("SemConta") > 0) OR ;
                       (USED("MovAux")   AND RECCOUNT("MovAux")   > 0)

        IF !loc_lTemDados
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                     " dados de integra" + CHR(231) + CHR(227) + "o para descartar.")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma o descarte dos dados processados?" + CHR(13) + ;
                        "Os arquivos cont" + CHR(225) + "beis j" + CHR(225) + ;
                        " gerados N" + CHR(195) + "O ser" + CHR(227) + "o afetados.")
            RETURN
        ENDIF

        IF USED("MovAux")
            SELECT MovAux
            ZAP
        ENDIF
        IF USED("SemConta")
            SELECT SemConta
            ZAP
        ENDIF
        IF USED("Cabecalho")
            SELECT Cabecalho
            ZAP
        ENDIF

        THIS.this_oBusinessObject.this_lTemInconsistencias = .F.
        THIS.this_oBusinessObject.this_cMensagemErro       = ""

        THIS.AlternarPagina("INICIAL")
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - Helper canonico para REPORT FORM com guards
    * Pattern #117: guard FILE + guard cursor vazio + isolamento locale/REPORTBEHAVIOR
    *   par_cBase        : nome base do FRX (sem path e sem .frx)
    *   par_cModo        : "PREVIEW", "PRINTER_PROMPT" ou "PRINTER"
    *   par_cCursorDados : alias do cursor de dados (vazio = sem guard de cursor)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_lSucesso, loc_oErro
        LOCAL loc_cOldPoint, loc_cOldSep, loc_nOldBehavior
        loc_lSucesso     = .F.
        loc_cOldPoint    = SET("POINT")
        loc_cOldSep      = SET("SEPARATOR")
        loc_nOldBehavior = SET("REPORTBEHAVIOR")
        loc_cFRX         = gc_4c_CaminhoReports + par_cBase + ".frx"

        IF !FILE(FULLPATH(loc_cFRX))
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                    "o encontrado: " + par_cBase + ".frx", "Erro")
            RETURN .F.
        ENDIF

        IF !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum dado encontrado para o relat" + CHR(243) + "rio.")
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80

            DO CASE
            CASE par_cModo = "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            CASE par_cModo = "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            CASE par_cModo = "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro("Erro ao emitir relat" + CHR(243) + "rio: " + loc_oErro.Message, "Erro")
        ENDTRY

        SET POINT TO (loc_cOldPoint)
        SET SEPARATOR TO (loc_cOldSep)
        SET REPORTBEHAVIOR (loc_nOldBehavior)

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TxtEmp1KeyPress - Dispara lookup de empresa por codigo ao pressionar Enter/Tab/F4
    *==========================================================================
    PROCEDURE TxtEmp1KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupEmpresaCod()
    ENDPROC

    *==========================================================================
    * TxtEmp1DblClick - Abre lookup de empresa por codigo ao dar duplo clique
    *==========================================================================
    PROCEDURE TxtEmp1DblClick
        THIS.AbrirLookupEmpresaCod()
    ENDPROC

    *==========================================================================
    * TxtDsemp1KeyPress - Dispara lookup de empresa por nome ao pressionar Enter/Tab/F4
    * Somente dispara quando txt_4c_Emp1 esta vazio (getDsemp1.When original)
    *==========================================================================
    PROCEDURE TxtDsemp1KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirLookupEmpresaNome()
    ENDPROC

    *==========================================================================
    * TxtDsemp1DblClick - Abre lookup de empresa por nome ao dar duplo clique
    *==========================================================================
    PROCEDURE TxtDsemp1DblClick
        THIS.AbrirLookupEmpresaNome()
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresaCod - Busca empresa por codigo (Cemps) em SigCdEmp
    * Popula txt_4c_Emp1 (Cemps char3) e txt_4c_Dsemp1 (Razas char40)
    * Tentativa de match exato primeiro; se falhar, abre picker
    *==========================================================================
    PROCEDURE AbrirLookupEmpresaCod()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_cValor, loc_cSQL, loc_oErro
        loc_cCodigo    = ""
        loc_cDescricao = ""

        IF !PEMSTATUS(THIS.cnt_4c_Mvt1, "txt_4c_Emp1", 5)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(NVL(THIS.cnt_4c_Mvt1.txt_4c_Emp1.Value, ""))

        TRY
            *-- Tenta match exato por Cemps
            IF !EMPTY(loc_cValor)
                loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                           EscaparSQL(LEFT(loc_cValor, 3))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpCod") > 0
                    IF USED("cursor_4c_BuscaEmpCod") AND !EOF("cursor_4c_BuscaEmpCod")
                        THIS.cnt_4c_Mvt1.txt_4c_Emp1.Value   = ALLTRIM(cursor_4c_BuscaEmpCod.Cemps)
                        THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Value = ALLTRIM(cursor_4c_BuscaEmpCod.Razas)
                        IF USED("cursor_4c_BuscaEmpCod")
                            USE IN cursor_4c_BuscaEmpCod
                        ENDIF
                        RETURN
                    ENDIF
                    IF USED("cursor_4c_BuscaEmpCod")
                        USE IN cursor_4c_BuscaEmpCod
                    ENDIF
                ENDIF
            ENDIF

            *-- Match exato falhou: abre picker
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmpCod", ;
                "Cemps", ;
                loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa")
            loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "",    "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaEmpCod")
                    loc_cCodigo    = ALLTRIM(cursor_4c_BuscaEmpCod.Cemps)
                    loc_cDescricao = ALLTRIM(cursor_4c_BuscaEmpCod.Razas)
                    THIS.cnt_4c_Mvt1.txt_4c_Emp1.Value   = loc_cCodigo
                    THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Value = loc_cDescricao
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaEmpCod")
                USE IN cursor_4c_BuscaEmpCod
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar empresa: " + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaEmpCod")
                USE IN cursor_4c_BuscaEmpCod
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresaNome - Busca empresa por descricao (Razas) em SigCdEmp
    * Popula txt_4c_Emp1 (Cemps char3) e txt_4c_Dsemp1 (Razas char40)
    * Rejeita chamada quando txt_4c_Emp1 nao esta vazio (getDsemp1.When original)
    * Tentativa de match unico starts-with; se ambiguo/vazio, abre picker
    *==========================================================================
    PROCEDURE AbrirLookupEmpresaNome()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_cValor, loc_cSQL, loc_oErro
        loc_cCodigo    = ""
        loc_cDescricao = ""

        IF !PEMSTATUS(THIS.cnt_4c_Mvt1, "txt_4c_Dsemp1", 5)
            RETURN
        ENDIF

        *-- Respeita getDsemp1.When original: editavel apenas quando Emp1 esta vazio
        IF !EMPTY(ALLTRIM(NVL(THIS.cnt_4c_Mvt1.txt_4c_Emp1.Value, "")))
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(NVL(THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Value, ""))

        TRY
            *-- Tenta match unico por Razas (starts-with) - TOP 2 para detectar ambiguidade
            IF !EMPTY(loc_cValor)
                loc_cSQL = "SELECT TOP 2 Cemps, Razas FROM SigCdEmp " + ;
                           "WHERE RTRIM(Razas) LIKE '" + ;
                           STRTRAN(loc_cValor, "'", "''") + "%'"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpNome") > 0
                    IF USED("cursor_4c_BuscaEmpNome") AND !EOF("cursor_4c_BuscaEmpNome") AND ;
                       RECCOUNT("cursor_4c_BuscaEmpNome") = 1
                        THIS.cnt_4c_Mvt1.txt_4c_Emp1.Value   = ALLTRIM(cursor_4c_BuscaEmpNome.Cemps)
                        THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Value = ALLTRIM(cursor_4c_BuscaEmpNome.Razas)
                        IF USED("cursor_4c_BuscaEmpNome")
                            USE IN cursor_4c_BuscaEmpNome
                        ENDIF
                        RETURN
                    ENDIF
                    IF USED("cursor_4c_BuscaEmpNome")
                        USE IN cursor_4c_BuscaEmpNome
                    ENDIF
                ENDIF
            ENDIF

            *-- Match unico falhou ou campo vazio: abre picker por nome
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmpNome", ;
                "Razas", ;
                loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa")
            loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "",    "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaEmpNome")
                    loc_cCodigo    = ALLTRIM(cursor_4c_BuscaEmpNome.Cemps)
                    loc_cDescricao = ALLTRIM(cursor_4c_BuscaEmpNome.Razas)
                    THIS.cnt_4c_Mvt1.txt_4c_Emp1.Value   = loc_cCodigo
                    THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Value = loc_cDescricao
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaEmpNome")
                USE IN cursor_4c_BuscaEmpNome
            ENDIF
            loc_oBusca.Release()

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar empresa: " + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaEmpNome")
                USE IN cursor_4c_BuscaEmpNome
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia valores dos campos do form para propriedades do BO
    *==========================================================================
    PROCEDURE FormParaBO()
        IF !PEMSTATUS(THIS.cnt_4c_Mvt1, "txt_4c_Data1", 5)
            RETURN
        ENDIF
        THIS.this_oBusinessObject.this_dDataIni   = NVL(THIS.cnt_4c_Mvt1.txt_4c_Data1.Value, {})
        THIS.this_oBusinessObject.this_dDataFim   = NVL(THIS.cnt_4c_Mvt1.txt_4c_Data2.Value, {})
        THIS.this_oBusinessObject.this_cEmpresa   = ALLTRIM(NVL(THIS.cnt_4c_Mvt1.txt_4c_Emp1.Value,   ""))
        THIS.this_oBusinessObject.this_cDsEmpresa = ALLTRIM(NVL(THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Value, ""))
    ENDPROC

    *==========================================================================
    * BOParaForm - Copia propriedades do BO de volta para os campos do form
    *==========================================================================
    PROCEDURE BOParaForm()
        IF !PEMSTATUS(THIS.cnt_4c_Mvt1, "txt_4c_Data1", 5)
            RETURN
        ENDIF
        THIS.cnt_4c_Mvt1.txt_4c_Data1.Value  = THIS.this_oBusinessObject.this_dDataIni
        THIS.cnt_4c_Mvt1.txt_4c_Data2.Value  = THIS.this_oBusinessObject.this_dDataFim
        THIS.cnt_4c_Mvt1.txt_4c_Emp1.Value   = THIS.this_oBusinessObject.this_cEmpresa
        THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Value = THIS.this_oBusinessObject.this_cDsEmpresa
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita todos os campos de entrada
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF !PEMSTATUS(THIS.cnt_4c_Mvt1, "txt_4c_Data1", 5)
            RETURN
        ENDIF
        THIS.cnt_4c_Mvt1.txt_4c_Data1.Enabled  = par_lHabilitar
        THIS.cnt_4c_Mvt1.txt_4c_Data2.Enabled  = par_lHabilitar
        THIS.cnt_4c_Mvt1.txt_4c_Emp1.Enabled   = par_lHabilitar
        THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Enabled = par_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Restaura campos de entrada para valores iniciais
    *==========================================================================
    PROCEDURE LimparCampos()
        IF !PEMSTATUS(THIS.cnt_4c_Mvt1, "txt_4c_Data1", 5)
            RETURN
        ENDIF
        THIS.cnt_4c_Mvt1.txt_4c_Data1.Value  = DATE()
        THIS.cnt_4c_Mvt1.txt_4c_Data2.Value  = DATE()
        THIS.cnt_4c_Mvt1.txt_4c_Emp1.Value   = SPACE(3)
        THIS.cnt_4c_Mvt1.txt_4c_Dsemp1.Value = SPACE(40)
    ENDPROC

    *==========================================================================
    * CarregarLista - Nao aplicavel a form OPERACIONAL flat sem grid de lista
    * Presente para satisfazer contrato multi-fase e compatibilidade FormBase
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo do form
    * Delega para AlternarPagina que centraliza toda logica de estado
    *   "INICIAL"     : inputs habilitados, Processar ativo, Video/Impressora off
    *   "PROCESSANDO" : todos inputs off, Aguarde visivel
    *   "RESULTADO"   : inputs off, Video/Impressora ativos
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cEstado)
        THIS.AlternarPagina(par_cEstado)
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma e grava arquivos contabeis
    * Mapeia semantica CRUD "Salvar" para GravarArquivos no contexto OPERACIONAL
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnGravarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela operacao e restaura estado inicial
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina("INICIAL")
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Nao aplicavel (form nao tem pesquisa de registros)
    * Presente para satisfazer contrato multi-fase
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *==========================================================================
    * Destroy - Libera cursores e Business Object
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("MovAux")
            USE IN MovAux
        ENDIF
        IF USED("SemConta")
            USE IN SemConta
        ENDIF
        IF USED("Cabecalho")
            USE IN Cabecalho
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
