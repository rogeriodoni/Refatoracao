*==============================================================================
* FormSigPrGlx.prg - Previa da Globalizacao / Reserva Automatica
* Tipo: OPERACIONAL (layout customizado, form filho recebe ParentForm)
* Herda de: FormBase
* Legado: SigPrGlx.SCX
*
* Fase 3/8: Form - Estrutura Base
*   DEFINE CLASS, Init, InicializarForm, ConfigurarPageFrame,
*   ConfigurarCabecalho, ConfigurarAguarde, TornarControlesVisiveis, Destroy
*==============================================================================

DEFINE CLASS FormSigPrGlx AS FormBase

    *-- Dimensoes e aparencia (PILAR 1: Width=800, Height=600 do legado)
    Width        = 800
    Height       = 600
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
    Themes       = .F.
    Caption      = "Previa da Globalizacao"
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Referencias e estado operacional
    this_oBusinessObject = .NULL.
    this_oParentForm     = .NULL.

    *-- Flags de modo de operacao (recebidos via Init do form pai)
    this_lReserva    = .F.
    this_nEmphPdr    = 0
    this_lAutomatico = .F.
    this_nNumeroOp   = 0
    this_lPorDestino = .F.

    *-- Estado de edicao interativa nas grades (equivalentes a Liberado/OldValue/AntValue do legado)
    this_lLiberado   = .F.
    this_nOldValue   = 0
    this_nAntValue   = 0

    *--------------------------------------------------------------------------
    * Init - Recebe parametros do form pai, compartilha datasession e prepara execucao
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_dData, par_lReservaAuto, par_nGerEmphPdr, par_lAutom, par_nNumeroOp, par_lPorDestino)

        *-- Guardar referencia ao form pai
        THIS.this_oParentForm = par_oParentForm

        *-- Compartilhar datasession com o form pai para acessar TmpFinalg/TmpFinal/etc.
        IF VARTYPE(par_oParentForm) = "O"
            THIS.DataSessionId = par_oParentForm.DataSessionId
        ENDIF

        *-- Salvar parametros operacionais
        THIS.this_lReserva    = IIF(VARTYPE(par_lReservaAuto) = "L", par_lReservaAuto, .F.)
        THIS.this_nEmphPdr    = IIF(VARTYPE(par_nGerEmphPdr)  = "N", par_nGerEmphPdr,  0)
        THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)       = "L", par_lAutom,       .F.)
        THIS.this_nNumeroOp   = IIF(VARTYPE(par_nNumeroOp)    = "N", par_nNumeroOp,    0)
        THIS.this_lPorDestino = IIF(VARTYPE(par_lPorDestino)  = "L", par_lPorDestino,  .F.)

        *-- Caption dinamico conforme modo de operacao
        THIS.Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
        IF THIS.this_lReserva
            THIS.Caption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO e monta estrutura visual base do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            SET DATE TO BRITISH
            SET CENTURY ON

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlxBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGlxBO.", "Erro")
            ELSE
                *-- Repassar flags de modo ao BO
                WITH THIS.this_oBusinessObject
                    .this_lReserva    = THIS.this_lReserva
                    .this_nEmphPdr    = THIS.this_nEmphPdr
                    .this_lAutomatico = THIS.this_lAutomatico
                    .this_nNumeroOp   = THIS.this_nNumeroOp
                    .this_lPorDestino = THIS.this_lPorDestino
                ENDWITH

                *-- Montar estrutura visual
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarAguarde()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Definir caption do cabecalho na Page1 e Page2
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = ;
                    "Opera" + CHR(231) + CHR(245) + "es Detalhadas"
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
                    "Opera" + CHR(231) + CHR(245) + "es Detalhadas"

                *-- Ativar PageFrame
                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio FormSigPrGlx: " + ;
                    loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc:" + loc_oErro.Procedure + "]", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 6 paginas operacionais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount   = 6
            .Top         = -27
            .Left        = -1
            .Width       = 804
            .Height      = 635
            .Tabs        = .F.
            .BorderWidth = 0
            .Themes      = .F.

            .Page1.Caption   = "Dados"
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page1.ForeColor = RGB(0,128,192)

            .Page2.Caption   = "Opera" + CHR(231) + CHR(245) + "es Detalhadas"
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.ForeColor = RGB(0,128,192)

            .Page3.Caption   = "Totais por Linha"
            .Page3.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page3.ForeColor = RGB(0,128,192)
            .Page3.Enabled   = .F.

            .Page4.Caption   = "Selecionar Estoque"
            .Page4.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page4.ForeColor = RGB(0,128,192)
            .Page4.Enabled   = .F.

            .Page5.Caption   = "Disponivel/Tamanho"
            .Page5.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page5.ForeColor = RGB(0,128,192)
            .Page5.Enabled   = .F.

            .Page6.Caption   = "Requisi" + CHR(231) + CHR(227) + "o"
            .Page6.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page6.ForeColor = RGB(0,128,192)
            .Page6.Enabled   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Header escuro na Page1 com titulo do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = -1
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
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = ""
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width
                .ForeColor     = RGB(255,255,255)
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAguarde - Container de espera durante processamento
    * Fica no form raiz (nao dentro de Page) com Visible=.F.
    * Tornado visivel em MostrarAguarde() e oculto em OcultarAguarde()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAguarde()
        THIS.AddObject("cnt_4c_Aguarde", "Container")
        WITH THIS.cnt_4c_Aguarde
            .Top         = 251
            .Left        = 142
            .Width       = 516
            .Height      = 98
            .Visible     = .F.
            .BackStyle   = 1
            .BackColor   = RGB(255,255,255)
            .BorderWidth = 0

            .AddObject("lbl_4c_AguardeMsg", "Label")
            WITH .lbl_4c_AguardeMsg
                .AutoSize  = .F.
                .Caption   = "Aguarde..."
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 12
                .BackStyle = 0
                .Top       = 18
                .Left      = 208
                .Width     = 105
                .Height    = 29
            ENDWITH

            .AddObject("lbl_4c_Processando", "Label")
            WITH .lbl_4c_Processando
                .AutoSize  = .F.
                .Caption   = "Processando Dados ......"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Top       = 52
                .Left      = 137
                .Width     = 242
                .Height    = 27
            ENDWITH

            .AddObject("lbl_4c_Mensagem", "Label")
            WITH .lbl_4c_Mensagem
                .AutoSize  = .F.
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Top       = 93
                .Left      = 131
                .Width     = 233
                .Height    = 25
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * MostrarAguarde - Exibe container de espera com mensagem opcional
    *--------------------------------------------------------------------------
    PROCEDURE MostrarAguarde(par_cMensagem)
        THIS.cnt_4c_Aguarde.lbl_4c_Mensagem.Caption = IIF(VARTYPE(par_cMensagem) = "C", par_cMensagem, "")
        THIS.cnt_4c_Aguarde.Visible = .T.
        THIS.cnt_4c_Aguarde.ZOrder(0)
        THIS.LockScreen = .T.
        THIS.LockScreen = .F.
        DOEVENTS
    ENDPROC

    *--------------------------------------------------------------------------
    * OcultarAguarde - Oculta container de espera
    *--------------------------------------------------------------------------
    PROCEDURE OcultarAguarde()
        THIS.cnt_4c_Aguarde.Visible = .F.
        THIS.LockScreen = .T.
        THIS.LockScreen = .F.
        DOEVENTS
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis pos-AddObject
    * FILTRO: cnt_4c_Aguarde permanece Visible=.F. (toggleado por MostrarAguarde)
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_p

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) != "O"
                LOOP
            ENDIF

            *-- Containers flutuantes: recursao nos filhos mas sem alterar Visible do container
            IF UPPER(loc_oControl.Name) = "CNT_4C_AGUARDE"
                THIS.TornarControlesVisiveis(loc_oControl)
                LOOP
            ENDIF

            *-- Controles com visibilidade gerenciada por logica operacional
            IF INLIST(UPPER(loc_oControl.Name), "BTN_4C_PEDRAS", "BTN_4C_SELESTOQUE", ;
                      "BTN_4C_DISPONIVEL", "IMG_4C_FIGJPG", "IMG_4C_FIGOPE")
                *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            *-- Trata PageFrame: itera Pages
            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                FOR loc_p = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                ENDFOR
            ENDIF

            *-- Trata containers/pages com filhos
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta controles de todas as Pages operacionais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag1, loc_oPag2, loc_oPag3, loc_oPag4, loc_oPag5, loc_oPag6
        LOCAL loc_oGrade, loc_oErr

        TRY
            *-- ===== PAGE 1: Grade principal e controles operacionais =====
            loc_oPag1 = THIS.pgf_4c_Paginas.Page1

            *-- Shapes decorativos (bordas informativas)
            loc_oPag1.AddObject("shp_4c_BoxInfo", "Shape")
            WITH loc_oPag1.shp_4c_BoxInfo
                .Top = 12
                .Left = 10
                .Width = 342
                .Height = 110
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("shp_4c_BoxEmpresa", "Shape")
            WITH loc_oPag1.shp_4c_BoxEmpresa
                .Top = 9
                .Left = 605
                .Width = 173
                .Height = 38
                .BackStyle = 0
            ENDWITH

            *-- Container5 legado: barra de informacoes do produto
            loc_oPag1.AddObject("cnt_4c_BarraInfo", "Container")
            WITH loc_oPag1.cnt_4c_BarraInfo
                .Top = 129
                .Left = 36
                .Width = 727
                .Height = 40
                .BackStyle = 1
                .BackColor = RGB(220,220,220)
                .BorderWidth = 0

                .AddObject("lbl_4c_Periodo", "Label")
                WITH .lbl_4c_Periodo
                    .AutoSize = .F.
                    .Caption = "Per"+CHR(237)+"odo: xx meses"
                    .Top = 2
                    .Left = 8
                    .Width = 105
                    .Height = 15
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("lbl_4c_RefAnalisada", "Label")
                WITH .lbl_4c_RefAnalisada
                    .AutoSize = .F.
                    .Caption = "Referencia Analisada :"
                    .Top = 18
                    .Left = 8
                    .Width = 127
                    .Height = 15
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_CodProd", "TextBox")
                WITH .txt_4c_CodProd
                    .Top = 16
                    .Left = 141
                    .Width = 108
                    .Height = 19
                    .ReadOnly = .T.
                    .BackColor = RGB(220,220,220)
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("lbl_4c_QVendida", "Label")
                WITH .lbl_4c_QVendida
                    .AutoSize = .F.
                    .Caption = "Qtde Vendida :"
                    .Top = 18
                    .Left = 269
                    .Width = 83
                    .Height = 15
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_TotVenda", "TextBox")
                WITH .txt_4c_TotVenda
                    .Top = 17
                    .Left = 349
                    .Width = 80
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .BackColor = RGB(220,220,220)
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("lbl_4c_QtdMinima", "Label")
                WITH .lbl_4c_QtdMinima
                    .AutoSize = .F.
                    .Caption = "Qtde M"+CHR(237)+"nima Para Produ"+CHR(231)+CHR(227)+"o :"
                    .Top = 18
                    .Left = 448
                    .Width = 164
                    .Height = 15
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_MinProd", "TextBox")
                WITH .txt_4c_MinProd
                    .Top = 17
                    .Left = 623
                    .Width = 80
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .BackColor = RGB(220,220,220)
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH
            ENDWITH

            *-- Grade principal: GradeItens com 10 colunas
            loc_oPag1.AddObject("grd_4c_GradeItens", "Grid")
            loc_oGrade = loc_oPag1.grd_4c_GradeItens
            WITH loc_oGrade
                .Top = 173
                .Left = 52
                .Width = 586
                .Height = 173
                .ColumnCount = 10
                .ReadOnly = .F.
                .GridLines = 1
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8

                WITH .Column1
                    .Header1.Caption = "Produto"
                    .Width = 70
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.Cpros"
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Cor"
                    .Width = 35
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.CodCors"
                ENDWITH
                WITH .Column3
                    .Header1.Caption = ""
                    .Width = 18
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.Linhas"
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "N"+CHR(250)+"mero"
                    .Width = 55
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.Nopes"
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Qtde Pedido"
                    .Width = 65
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.Saldo"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column6
                    .Header1.Caption = "Produzir"
                    .Width = 65
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.Fabrs"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column7
                    .Header1.Caption = "Qtd Produ"+CHR(231)+CHR(227)+"o"
                    .Width = 65
                    .ReadOnly = .F.
                    .ControlSource = "TmpFinalg.Produzir"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column8
                    .Header1.Caption = "Produzir Estq"
                    .Width = 65
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.Produzir2"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column9
                    .Header1.Caption = "Tam"
                    .Width = 30
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinalg.CodTams"
                ENDWITH
                WITH .Column10
                    .Header1.Caption = "Qtd Estoque"
                    .Width = 65
                    .ReadOnly = .F.
                    .ControlSource = "TmpFinalg.Estoque"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH

                .RecordSource = "TmpFinalg"
            ENDWITH

            *-- Totais da grade principal (abaixo do grid)
            loc_oPag1.AddObject("lbl_4c_TotaisGrd", "Label")
            WITH loc_oPag1.lbl_4c_TotaisGrd
                .AutoSize = .F.
                .Caption = "Totais :"
                .Top = 348
                .Left = 224
                .Width = 42
                .Height = 17
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("txt_4c_TotQtd", "TextBox")
            WITH loc_oPag1.txt_4c_TotQtd
                .Top = 346
                .Left = 271
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("txt_4c_TotPrdc", "TextBox")
            WITH loc_oPag1.txt_4c_TotPrdc
                .Top = 346
                .Left = 339
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("txt_4c_TotEst", "TextBox")
            WITH loc_oPag1.txt_4c_TotEst
                .Top = 346
                .Left = 407
                .Width = 68
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("txt_4c_TotPrz", "TextBox")
            WITH loc_oPag1.txt_4c_TotPrz
                .Top = 346
                .Left = 476
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("txt_4c_TotPrze", "TextBox")
            WITH loc_oPag1.txt_4c_TotPrze
                .Top = 346
                .Left = 543
                .Width = 75
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- Container3 legado: Estoque Disponivel (grid TmpSaldG filtrado por SET KEY)
            loc_oPag1.AddObject("cnt_4c_GradeDisp", "Container")
            WITH loc_oPag1.cnt_4c_GradeDisp
                .Top = 371
                .Left = 50
                .Width = 363
                .Height = 186
                .BackStyle = 1
                .BackColor = RGB(255,255,255)
                .BorderWidth = 1

                .AddObject("lbl_4c_TituloDisp", "Label")
                WITH .lbl_4c_TituloDisp
                    .AutoSize = .F.
                    .Caption = "Estoque Dispon"+CHR(237)+"vel"
                    .Top = 1
                    .Left = 0
                    .Width = 363
                    .Height = 16
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .FontBold = .T.
                ENDWITH

                .AddObject("grd_4c_GradeDisp", "Grid")
                WITH .grd_4c_GradeDisp
                    .Top = 15
                    .Left = 3
                    .Width = 358
                    .Height = 147
                    .ColumnCount = 6
                    .ReadOnly = .T.
                    .GridLines = 1
                    .Themes = .F.
                    .FontName = "Tahoma"
                    .FontSize = 8

                    WITH .Column1
                        .Header1.Caption = "Grupo"
                        .ControlSource = "TmpSaldG.Grupos"
                        .RecordMark   = .F.
                        .DeleteMark   = .F.
                    ENDWITH
                    WITH .Column2
                        .Header1.Caption = "Conta"
                        .ControlSource = "TmpSaldG.Estos"
                    ENDWITH
                    WITH .Column3
                        .Header1.Caption = "Atual"
                        .ControlSource = "TmpSaldG.Saldo"
                        .Text1.Format = "@Z 9999999.999"
                    ENDWITH
                    WITH .Column4
                        .Header1.Caption = "Utilizado"
                    ENDWITH
                    WITH .Column5
                        .Header1.Caption = "Dispon"+CHR(237)+"vel"
                        .ControlSource = "TmpSaldG.Disps"
                        .Text1.Format = "@Z 9999999.999"
                    ENDWITH
                    WITH .Column6
                        .Header1.Caption = "Prior"
                        .ControlSource = "TmpSaldG.Priors"
                    ENDWITH

                    .RecordSource = "TmpSaldG"
                ENDWITH

                .AddObject("lbl_4c_TotDisp", "Label")
                WITH .lbl_4c_TotDisp
                    .AutoSize = .F.
                    .Caption = "Totais :"
                    .Top = 163
                    .Left = 128
                    .Width = 42
                    .Height = 17
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_DispQtd", "TextBox")
                WITH .txt_4c_DispQtd
                    .Top = 161
                    .Left = 174
                    .Width = 58
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_DispEst", "TextBox")
                WITH .txt_4c_DispEst
                    .Top = 161
                    .Left = 234
                    .Width = 58
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_DispPrz", "TextBox")
                WITH .txt_4c_DispPrz
                    .Top = 161
                    .Left = 292
                    .Width = 58
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH
            ENDWITH

            *-- Container1 legado: Estoque Em Producao
            loc_oPag1.AddObject("cnt_4c_GradeProd", "Container")
            WITH loc_oPag1.cnt_4c_GradeProd
                .Top = 371
                .Left = 418
                .Width = 308
                .Height = 136
                .BackStyle = 1
                .BackColor = RGB(255,255,255)
                .BorderWidth = 1

                .AddObject("lbl_4c_TituloProd", "Label")
                WITH .lbl_4c_TituloProd
                    .AutoSize = .F.
                    .Caption = "Estoque Em Produ"+CHR(231)+CHR(227)+"o"
                    .Top = 1
                    .Left = 1
                    .Width = 305
                    .Height = 16
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .FontBold = .T.
                ENDWITH

                .AddObject("grd_4c_GradeProd", "Grid")
                WITH .grd_4c_GradeProd
                    .Top = 15
                    .Left = 2
                    .Width = 303
                    .Height = 99
                    .ColumnCount = 5
                    .ReadOnly = .T.
                    .GridLines = 1
                    .Themes = .F.
                    .FontName = "Tahoma"
                    .FontSize = 8

                    WITH .Column1
                        .Header1.Caption = "Fase"
                        .ControlSource = "TmpSaldG.Grupos"
                        .RecordMark   = .F.
                        .DeleteMark   = .F.
                    ENDWITH
                    WITH .Column2
                        .Header1.Caption = "Disponivel"
                        .ControlSource = "TmpSaldG.Disps"
                        .Text1.Format = "@Z 9999999.999"
                    ENDWITH
                    WITH .Column3
                        .Header1.Caption = "Utilizado"
                        .ControlSource = "TmpSaldG.Saldo"
                        .Text1.Format = "@Z 9999999.999"
                    ENDWITH
                    WITH .Column4
                        .Header1.Caption = "Prior"
                        .ControlSource = "TmpSaldG.Priors"
                    ENDWITH
                    WITH .Column5
                        .Header1.Caption = "Nop"
                    ENDWITH

                    .RecordSource = "TmpSaldU"
                ENDWITH

                .AddObject("lbl_4c_TotProd", "Label")
                WITH .lbl_4c_TotProd
                    .AutoSize = .F.
                    .Caption = "Totais :"
                    .Top = 115
                    .Left = 102
                    .Width = 42
                    .Height = 17
                    .BackStyle = 0
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_ProdQtd", "TextBox")
                WITH .txt_4c_ProdQtd
                    .Top = 113
                    .Left = 145
                    .Width = 61
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH

                .AddObject("txt_4c_ProdEst", "TextBox")
                WITH .txt_4c_ProdEst
                    .Top = 113
                    .Left = 207
                    .Width = 61
                    .Height = 19
                    .ReadOnly = .T.
                    .Format = "@Z 9999999.999"
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH
            ENDWITH

            *-- Imagem do produto (oculta ate click ou AfterRowColChange)
            loc_oPag1.AddObject("img_4c_FigJpg", "Image")
            WITH loc_oPag1.img_4c_FigJpg
                .Top = 255
                .Left = 646
                .Width = 122
                .Height = 89
                .Visible = .F.
                .Stretch = 2
            ENDWITH

            *-- Botoes operacionais (top=2, alinhados a direita)
            loc_oPag1.AddObject("btn_4c_Pedras", "CommandButton")
            WITH loc_oPag1.btn_4c_Pedras
                .Top = 2
                .Left = 348
                .Width = 75
                .Height = 75
                .Caption = "Requisi"+CHR(231)+CHR(245)+"es"
                .Visible = .F.
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("btn_4c_SelEstoque", "CommandButton")
            WITH loc_oPag1.btn_4c_SelEstoque
                .Top = 2
                .Left = 423
                .Width = 75
                .Height = 75
                .Caption = "Estoques"
                .Visible = .F.
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("btn_4c_Disponivel", "CommandButton")
            WITH loc_oPag1.btn_4c_Disponivel
                .Top = 2
                .Left = 498
                .Width = 75
                .Height = 75
                .Caption = "Dispon"+CHR(237)+"veis"
                .Visible = .F.
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("btn_4c_TotLinha", "CommandButton")
            WITH loc_oPag1.btn_4c_TotLinha
                .Top = 2
                .Left = 573
                .Width = 75
                .Height = 75
                .Caption = "Total/Linhas"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("btn_4c_Processar", "CommandButton")
            WITH loc_oPag1.btn_4c_Processar
                .Top = 2
                .Left = 648
                .Width = 75
                .Height = 75
                .Caption = "Processar"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag1.AddObject("btn_4c_Cancelar", "CommandButton")
            WITH loc_oPag1.btn_4c_Cancelar
                .Top = 2
                .Left = 723
                .Width = 75
                .Height = 75
                .Caption = "Encerrar"
                .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- Botao icone-only: autorizar alteracao de quantidade (requer Themes=.T.)
            loc_oPag1.AddObject("btn_4c_Alteraqtd", "CommandButton")
            WITH loc_oPag1.btn_4c_Alteraqtd
                .Top = 189
                .Left = 687
                .Width = 40
                .Height = 40
                .Caption = ""
                .Themes = .T.
                .Picture         = gc_4c_CaminhoIcones + "operacional_liberar_40.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "operacional_liberar_40.jpg"
                .ToolTipText = "Autorizar Altera"+CHR(231)+CHR(227)+"o de Quantidade"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- BINDEVENTs: grade principal e botoes Page1
            loc_oGrade = loc_oPag1.grd_4c_GradeItens
            BINDEVENT(loc_oGrade,               "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
            BINDEVENT(loc_oGrade.Column3.Text1,  "Click",            THIS, "GradeItensCol3Click")
            BINDEVENT(loc_oGrade.Column7.Text1,  "GotFocus",         THIS, "GradeItensCol7GotFocus")
            BINDEVENT(loc_oGrade.Column7.Text1,  "Valid",            THIS, "GradeItensCol7Valid")
            BINDEVENT(loc_oGrade.Column7.Text1,  "KeyPress",       THIS, "GradeItensCol7LostFocus")
            BINDEVENT(loc_oGrade.Column8.Text1,  "KeyPress",       THIS, "GradeItensCol8LostFocus")
            BINDEVENT(loc_oGrade.Column10.Text1, "GotFocus",         THIS, "GradeItensCol10GotFocus")
            BINDEVENT(loc_oGrade.Column10.Text1, "Valid",            THIS, "GradeItensCol10Valid")
            BINDEVENT(loc_oGrade.Column10.Text1, "KeyPress",       THIS, "GradeItensCol10LostFocus")

            BINDEVENT(loc_oPag1.img_4c_FigJpg,    "Click", THIS, "ImgFigJpgClick")
            BINDEVENT(loc_oPag1.btn_4c_Pedras,     "Click", THIS, "BtnPedrasClick")
            BINDEVENT(loc_oPag1.btn_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
            BINDEVENT(loc_oPag1.btn_4c_Disponivel, "Click", THIS, "BtnDisponivelClick")
            BINDEVENT(loc_oPag1.btn_4c_TotLinha,   "Click", THIS, "BtnTotLinhaClick")
            BINDEVENT(loc_oPag1.btn_4c_Processar,  "Click", THIS, "BtnProcessarClick")
            BINDEVENT(loc_oPag1.btn_4c_Cancelar,   "Click", THIS, "BtnCancelarClick")
            BINDEVENT(loc_oPag1.btn_4c_Alteraqtd,  "Click", THIS, "BtnAlteraqtdClick")

            *-- ===== PAGE 2: Operacoes Detalhadas =====
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            loc_oPag2.AddObject("lbl_4c_QtdSel", "Label")
            WITH loc_oPag2.lbl_4c_QtdSel
                .AutoSize = .F.
                .Caption = "Qtd Selecionada :"
                .Top = 164
                .Left = 383
                .Width = 119
                .Height = 15
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("txt_4c_TotSEst", "TextBox")
            WITH loc_oPag2.txt_4c_TotSEst
                .Top = 162
                .Left = 501
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("txt_4c_TotSPrc", "TextBox")
            WITH loc_oPag2.txt_4c_TotSPrc
                .Top = 162
                .Left = 567
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("grd_4c_GradeOpe", "Grid")
            WITH loc_oPag2.grd_4c_GradeOpe
                .Top = 181
                .Left = 53
                .Width = 703
                .Height = 189
                .ColumnCount = 10
                .ReadOnly = .F.
                .GridLines = 1
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8

                WITH .Column1
                    .Header1.Caption = "Produto"
                    .Width = 70
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.Cpros"
                    .RecordMark   = .F.
                    .DeleteMark   = .F.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Cor"
                    .Width = 35
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.CodCors"
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Opera"+CHR(231)+CHR(227)+"o"
                    .Width = 60
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.Dopes"
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "N"+CHR(250)+"mero"
                    .Width = 55
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.Nops"
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Quantidade"
                    .Width = 65
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.Saldo"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column6
                    .Header1.Caption = "Produzir"
                    .Width = 65
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.Produzir"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column7
                    .Header1.Caption = "Estoque"
                    .Width = 65
                    .ReadOnly = .F.
                    .ControlSource = "TmpFinal.Estoque"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column8
                    .Header1.Caption = "Obs"
                    .Width = 55
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.UsuLibs"
                ENDWITH
                WITH .Column9
                    .Header1.Caption = "Tam"
                    .Width = 30
                    .ReadOnly = .T.
                    .ControlSource = "TmpFinal.CodTams"
                ENDWITH
                WITH .Column10
                    .Header1.Caption = "Produ"+CHR(231)+CHR(227)+"o"
                    .Width = 65
                    .ReadOnly = .F.
                    .ControlSource = "TmpFinal.Fabrs"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH

                .RecordSource = "TmpFinal"
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_TotP2Lbl", "Label")
            WITH loc_oPag2.lbl_4c_TotP2Lbl
                .AutoSize = .F.
                .Caption = "Totais :"
                .Top = 372
                .Left = 403
                .Width = 42
                .Height = 17
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("txt_4c_P2TotQtd", "TextBox")
            WITH loc_oPag2.txt_4c_P2TotQtd
                .Top = 370
                .Left = 449
                .Width = 68
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("txt_4c_P2TotEst", "TextBox")
            WITH loc_oPag2.txt_4c_P2TotEst
                .Top = 370
                .Left = 516
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("txt_4c_P2TotPrc", "TextBox")
            WITH loc_oPag2.txt_4c_P2TotPrc
                .Top = 370
                .Left = 581
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("txt_4c_P2TotPrz", "TextBox")
            WITH loc_oPag2.txt_4c_P2TotPrz
                .Top = 370
                .Left = 648
                .Width = 67
                .Height = 19
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_ObsItem", "Label")
            WITH loc_oPag2.lbl_4c_ObsItem
                .AutoSize = .F.
                .Caption = "Observa"+CHR(231)+CHR(227)+"o do Item :"
                .Top = 400
                .Left = 221
                .Width = 119
                .Height = 17
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("edt_4c_ObsItens", "EditBox")
            WITH loc_oPag2.edt_4c_ObsItens
                .Top = 415
                .Left = 221
                .Width = 396
                .Height = 69
                .ReadOnly = .T.
                .ScrollBars = 2
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag2.AddObject("img_4c_FigOpe", "Image")
            WITH loc_oPag2.img_4c_FigOpe
                .Top = 394
                .Left = 73
                .Width = 135
                .Height = 92
                .Visible = .F.
                .Stretch = 2
            ENDWITH

            loc_oPag2.AddObject("btn_4c_VoltarP2", "CommandButton")
            WITH loc_oPag2.btn_4c_VoltarP2
                .Top = 12
                .Left = 704
                .Width = 75
                .Height = 75
                .Caption = "Voltar"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oPag2.btn_4c_VoltarP2, "Click", THIS, "BtnVoltarPage2Click")

            *-- BINDEVENTs: grade de operacoes detalhadas (Page2) - colunas ReadOnly redirecionam foco p/ Col7
            LOCAL loc_oGradeOpe
            loc_oGradeOpe = loc_oPag2.grd_4c_GradeOpe
            BINDEVENT(loc_oGradeOpe,                "AfterRowColChange", THIS, "GradeOpeAfterRowColChange")
            BINDEVENT(loc_oGradeOpe.Column1.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column2.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column3.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column4.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column5.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column6.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column8.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column9.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
            BINDEVENT(loc_oGradeOpe.Column7.Text1,  "GotFocus", THIS, "GradeOpeCol7GotFocus")
            BINDEVENT(loc_oGradeOpe.Column7.Text1,  "Valid",    THIS, "GradeOpeCol7Valid")
            BINDEVENT(loc_oGradeOpe.Column7.Text1,  "KeyPress",THIS, "GradeOpeCol7LostFocus")
            BINDEVENT(loc_oGradeOpe.Column10.Text1, "GotFocus", THIS, "GradeOpeCol10GotFocus")
            BINDEVENT(loc_oGradeOpe.Column10.Text1, "Valid",    THIS, "GradeOpeCol10Valid")
            BINDEVENT(loc_oGradeOpe.Column10.Text1, "KeyPress",THIS, "GradeOpeCol10LostFocus")

            *-- ===== PAGE 3: Totais por Linha =====
            loc_oPag3 = THIS.pgf_4c_Paginas.Page3

            loc_oPag3.AddObject("lbl_4c_TitLinha", "Label")
            WITH loc_oPag3.lbl_4c_TitLinha
                .AutoSize = .F.
                .Caption = "Totais por Linha"
                .Top = 147
                .Left = 173
                .Width = 157
                .Height = 25
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 10
                .FontBold = .T.
            ENDWITH

            loc_oPag3.AddObject("grd_4c_GradeLinhas", "Grid")
            WITH loc_oPag3.grd_4c_GradeLinhas
                .Top = 181
                .Left = 167
                .Width = 438
                .Height = 292
                .ColumnCount = 5
                .ReadOnly = .T.
                .GridLines = 1
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8

                WITH .Column1
                    .Header1.Caption = "Linha"
                    .ControlSource = "TmpLinha.Linhas"
                    .RecordMark   = .F.
                    .DeleteMark   = .F.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Quantidade"
                    .ControlSource = "TmpLinha.Saldo"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Estoque"
                    .ControlSource = "TmpLinha.Estoque"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "Produ"+CHR(231)+CHR(227)+"o"
                    .ControlSource = "TmpLinha.Fabrs"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Produzir"
                    .ControlSource = "TmpLinha.Produzir"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
            ENDWITH

            loc_oPag3.AddObject("btn_4c_VoltarP3", "CommandButton")
            WITH loc_oPag3.btn_4c_VoltarP3
                .Top = 12
                .Left = 704
                .Width = 75
                .Height = 75
                .Caption = "Voltar"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oPag3.btn_4c_VoltarP3, "Click", THIS, "BtnVoltarPage3Click")

            *-- ===== PAGE 4: Selecionar Estoque =====
            loc_oPag4 = THIS.pgf_4c_Paginas.Page4

            loc_oPag4.AddObject("lbl_4c_TitSelEst", "Label")
            WITH loc_oPag4.lbl_4c_TitSelEst
                .AutoSize = .F.
                .Caption = "Selecionar Estoque"
                .Top = 138
                .Left = 197
                .Width = 184
                .Height = 25
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 10
                .FontBold = .T.
            ENDWITH

            loc_oPag4.AddObject("txt_4c_P4CodProd", "TextBox")
            WITH loc_oPag4.txt_4c_P4CodProd
                .Top = 138
                .Left = 479
                .Width = 80
                .Height = 19
                .ReadOnly = .T.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag4.AddObject("grd_4c_GradeSelEst", "Grid")
            WITH loc_oPag4.grd_4c_GradeSelEst
                .Top = 169
                .Left = 191
                .Width = 370
                .Height = 244
                .ColumnCount = 5
                .ReadOnly = .F.
                .GridLines = 1
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8

                WITH .Column1
                    .Header1.Caption = "Grupo"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.Grupos"
                    .RecordMark   = .F.
                    .DeleteMark   = .F.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Conta"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.Estos"
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Prior"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.Priors"
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "Disponivel"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.Disps"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Utilizar"
                    .ReadOnly = .F.
                    .ControlSource = "TmpDisp.Utilizar"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
            ENDWITH

            loc_oPag4.AddObject("lbl_4c_P4QtPed", "Label")
            WITH loc_oPag4.lbl_4c_P4QtPed
                .AutoSize = .F.
                .Caption = "Qtde Pedida :"
                .Top = 418
                .Left = 220
                .Width = 82
                .Height = 16
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag4.AddObject("txt_4c_P4QtPedida", "TextBox")
            WITH loc_oPag4.txt_4c_P4QtPedida
                .Top = 413
                .Left = 312
                .Width = 67
                .Height = 23
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag4.AddObject("lbl_4c_P4QtSel", "Label")
            WITH loc_oPag4.lbl_4c_P4QtSel
                .AutoSize = .F.
                .Caption = "Qtde Selecionada :"
                .Top = 437
                .Left = 192
                .Width = 110
                .Height = 16
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag4.AddObject("txt_4c_P4QtSelec", "TextBox")
            WITH loc_oPag4.txt_4c_P4QtSelec
                .Top = 436
                .Left = 312
                .Width = 67
                .Height = 23
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag4.AddObject("btn_4c_VoltarP4", "CommandButton")
            WITH loc_oPag4.btn_4c_VoltarP4
                .Top = 12
                .Left = 704
                .Width = 75
                .Height = 75
                .Caption = "Voltar"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oPag4.btn_4c_VoltarP4, "Click", THIS, "BtnVoltarPage4Click")
            *-- BINDEVENTs: Page4 grade editavel (Column5 Utilizar)
            BINDEVENT(loc_oPag4.grd_4c_GradeSelEst.Column5.Text1, "Valid",     THIS, "GradeSelEstCol5Valid")
            BINDEVENT(loc_oPag4.grd_4c_GradeSelEst.Column5.Text1, "KeyPress", THIS, "GradeSelEstCol5LostFocus")

            *-- ===== PAGE 5: Disponivel/Tamanho =====
            loc_oPag5 = THIS.pgf_4c_Paginas.Page5

            loc_oPag5.AddObject("lbl_4c_TitDisp", "Label")
            WITH loc_oPag5.lbl_4c_TitDisp
                .AutoSize = .F.
                .Caption = "Selecionar Tamanhos"
                .Top = 150
                .Left = 246
                .Width = 205
                .Height = 25
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 10
                .FontBold = .T.
            ENDWITH

            loc_oPag5.AddObject("txt_4c_P5CodProd", "TextBox")
            WITH loc_oPag5.txt_4c_P5CodProd
                .Top = 151
                .Left = 486
                .Width = 80
                .Height = 19
                .ReadOnly = .T.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag5.AddObject("grd_4c_GradeDisp", "Grid")
            WITH loc_oPag5.grd_4c_GradeDisp
                .Top = 181
                .Left = 239
                .Width = 327
                .Height = 228
                .ColumnCount = 5
                .ReadOnly = .F.
                .GridLines = 1
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8

                WITH .Column1
                    .Header1.Caption = "Produto"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.Cpros"
                    .RecordMark   = .F.
                    .DeleteMark   = .F.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Cor"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.CodCors"
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Tam"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.CodTams"
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "Disponivel"
                    .ReadOnly = .T.
                    .ControlSource = "TmpDisp.Disps"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Utilizar"
                    .ReadOnly = .F.
                    .ControlSource = "TmpDisp.Utilizar"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
            ENDWITH

            loc_oPag5.AddObject("lbl_4c_P5QtPed", "Label")
            WITH loc_oPag5.lbl_4c_P5QtPed
                .AutoSize = .F.
                .Caption = "Qtde Pedida :"
                .Top = 415
                .Left = 289
                .Width = 82
                .Height = 16
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag5.AddObject("txt_4c_P5QtPedida", "TextBox")
            WITH loc_oPag5.txt_4c_P5QtPedida
                .Top = 410
                .Left = 379
                .Width = 67
                .Height = 23
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag5.AddObject("lbl_4c_P5QtSel", "Label")
            WITH loc_oPag5.lbl_4c_P5QtSel
                .AutoSize = .F.
                .Caption = "Qtde Selecionada :"
                .Top = 434
                .Left = 261
                .Width = 110
                .Height = 16
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag5.AddObject("txt_4c_P5QtSelec", "TextBox")
            WITH loc_oPag5.txt_4c_P5QtSelec
                .Top = 433
                .Left = 379
                .Width = 67
                .Height = 23
                .ReadOnly = .T.
                .Format = "@Z 9999999.999"
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag5.AddObject("btn_4c_VoltarP5", "CommandButton")
            WITH loc_oPag5.btn_4c_VoltarP5
                .Top = 12
                .Left = 704
                .Width = 75
                .Height = 75
                .Caption = "Voltar"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oPag5.btn_4c_VoltarP5, "Click", THIS, "BtnVoltarPage5Click")
            *-- BINDEVENTs: Page5 grade editavel (Cols 1-4 redirecionam foco; Col5 valida)
            BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column1.Text1, "GotFocus", THIS, "GradeDispColsGotFocus")
            BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column2.Text1, "GotFocus", THIS, "GradeDispColsGotFocus")
            BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column3.Text1, "GotFocus", THIS, "GradeDispColsGotFocus")
            BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column4.Text1, "GotFocus", THIS, "GradeDispColsGotFocus")
            BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column5.Text1, "Valid",    THIS, "GradeDispCol5Valid")

            *-- ===== PAGE 6: Requisicoes de Material =====
            loc_oPag6 = THIS.pgf_4c_Paginas.Page6

            loc_oPag6.AddObject("lbl_4c_TitReq", "Label")
            WITH loc_oPag6.lbl_4c_TitReq
                .AutoSize = .F.
                .Caption = "Requisi"+CHR(231)+CHR(227)+"o Manual de Material"
                .Top = 168
                .Left = 132
                .Width = 294
                .Height = 25
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 10
                .FontBold = .T.
            ENDWITH

            loc_oPag6.AddObject("txt_4c_P6CodProd", "TextBox")
            WITH loc_oPag6.txt_4c_P6CodProd
                .Top = 169
                .Left = 487
                .Width = 80
                .Height = 19
                .ReadOnly = .T.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            loc_oPag6.AddObject("grd_4c_GradePedra", "Grid")
            WITH loc_oPag6.grd_4c_GradePedra
                .Top = 197
                .Left = 119
                .Width = 500
                .Height = 261
                .ColumnCount = 5
                .ReadOnly = .F.
                .GridLines = 1
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8

                WITH .Column1
                    .Header1.Caption = "Produto"
                    .ReadOnly = .F.
                    .ControlSource = "SelPedra.Cpros"
                    .RecordMark   = .F.
                    .DeleteMark   = .F.
                ENDWITH
                WITH .Column2
                    .Header1.Caption = "Descri"+CHR(231)+CHR(227)+"o"
                    .ReadOnly = .T.
                    .ControlSource = "SelPedra.Dpros"
                ENDWITH
                WITH .Column3
                    .Header1.Caption = "Uni"
                    .ReadOnly = .T.
                    .ControlSource = "SelPedra.Cunis"
                ENDWITH
                WITH .Column4
                    .Header1.Caption = "Qtde"
                    .ReadOnly = .F.
                    .ControlSource = "SelPedra.Qtds"
                    .Text1.Format = "@Z 9999999.999"
                ENDWITH
                WITH .Column5
                    .Header1.Caption = "Produto"
                    .ReadOnly = .F.
                    .ControlSource = "SelPedra.Cpro2s"
                ENDWITH
            ENDWITH

            loc_oPag6.AddObject("btn_4c_VoltarP6", "CommandButton")
            WITH loc_oPag6.btn_4c_VoltarP6
                .Top = 12
                .Left = 704
                .Width = 75
                .Height = 75
                .Caption = "Voltar"
                .Themes = .F.
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oPag6.btn_4c_VoltarP6, "Click", THIS, "BtnVoltarPage6Click")

            *-- BINDEVENTs: Page6 GradePedra - lookup produto e edicao condicional
            BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column1.Text1, "Valid",     THIS, "GradePedraCol1Valid")
            BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column4.Text1, "When",      THIS, "GradePedraCol4When")
            BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column5.Text1, "When",      THIS, "GradePedraCol5When")
            BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column5.Text1, "Valid",     THIS, "GradePedraCol5Valid")
            BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column5.Text1, "KeyPress", THIS, "GradePedraCol5LostFocus")

        CATCH TO loc_oErr
            MsgErro("Erro em ConfigurarPaginaLista: " + loc_oErr.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;
                    " Proc:" + loc_oErr.Procedure + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2 (Operacoes Detalhadas): cabecalho + primeiros
    * 50% dos campos auxiliares (info do produto selecionado, painel de selecao).
    * Page2 ja possui grid principal e totais (montados em ConfigurarPaginaLista);
    * este metodo COMPLEMENTA com o header cinza padrao do sistema e o painel de
    * informacoes do produto ativo (codigo/descricao/cor/tamanho + qtde do pedido).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag2, loc_oErr

        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2

            *-- ===== Cabecalho cinza padrao (equivalente ao cntSombra do framework) =====
            loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag2.cnt_4c_Cabecalho
                .Top         = -1
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
                    .Top           = 18
                    .Width         = THIS.Width
                    .ForeColor     = RGB(0,0,0)
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .AutoSize      = .F.
                    .FontBold      = .T.
                    .FontName      = "Tahoma"
                    .FontSize      = 18
                    .WordWrap      = .T.
                    .Alignment     = 0
                    .BackStyle     = 0
                    .Caption       = ""
                    .Height        = 46
                    .Left          = 10
                    .Top           = 17
                    .Width         = THIS.Width
                    .ForeColor     = RGB(255,255,255)
                ENDWITH
            ENDWITH

            *-- ===== Painel de informacoes do produto ativo (parte 1: identificacao) =====
            *-- Container branco a esquerda com os dados do produto selecionado na Page1
            *-- (equivalente ao BarraInfo da Page1, mas focado nas Operacoes desta pagina)
            loc_oPag2.AddObject("cnt_4c_InfoProd", "Container")
            WITH loc_oPag2.cnt_4c_InfoProd
                .Top         = 100
                .Left        = 53
                .Width       = 703
                .Height      = 55
                .BackStyle   = 1
                .BackColor   = RGB(240,240,240)
                .BorderWidth = 1

                *-- Rotulo: Produto
                .AddObject("lbl_4c_LblProduto", "Label")
                WITH .lbl_4c_LblProduto
                    .AutoSize  = .F.
                    .Caption   = "Produto :"
                    .Top       = 6
                    .Left      = 8
                    .Width     = 55
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                ENDWITH

                *-- Codigo do produto selecionado (readonly, alimentado por AfterRowColChange)
                .AddObject("txt_4c_DadosCodProd", "TextBox")
                WITH .txt_4c_DadosCodProd
                    .Top         = 4
                    .Left        = 66
                    .Width       = 108
                    .Height      = 19
                    .ReadOnly    = .T.
                    .BackColor   = RGB(255,255,255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Value       = ""
                ENDWITH

                *-- Descricao do produto (readonly)
                .AddObject("lbl_4c_LblDescricao", "Label")
                WITH .lbl_4c_LblDescricao
                    .AutoSize  = .F.
                    .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                    .Top       = 6
                    .Left      = 180
                    .Width     = 65
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                ENDWITH

                .AddObject("txt_4c_DadosDescProd", "TextBox")
                WITH .txt_4c_DadosDescProd
                    .Top         = 4
                    .Left        = 248
                    .Width       = 220
                    .Height      = 19
                    .ReadOnly    = .T.
                    .BackColor   = RGB(255,255,255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Value       = ""
                ENDWITH

                *-- Cor selecionada
                .AddObject("lbl_4c_LblCor", "Label")
                WITH .lbl_4c_LblCor
                    .AutoSize  = .F.
                    .Caption   = "Cor :"
                    .Top       = 6
                    .Left      = 476
                    .Width     = 30
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                ENDWITH

                .AddObject("txt_4c_DadosCodCor", "TextBox")
                WITH .txt_4c_DadosCodCor
                    .Top         = 4
                    .Left        = 508
                    .Width       = 50
                    .Height      = 19
                    .ReadOnly    = .T.
                    .BackColor   = RGB(255,255,255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Value       = ""
                ENDWITH

                *-- Tamanho selecionado
                .AddObject("lbl_4c_LblTam", "Label")
                WITH .lbl_4c_LblTam
                    .AutoSize  = .F.
                    .Caption   = "Tam :"
                    .Top       = 6
                    .Left      = 566
                    .Width     = 32
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                ENDWITH

                .AddObject("txt_4c_DadosCodTam", "TextBox")
                WITH .txt_4c_DadosCodTam
                    .Top         = 4
                    .Left        = 600
                    .Width       = 50
                    .Height      = 19
                    .ReadOnly    = .T.
                    .BackColor   = RGB(255,255,255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Value       = ""
                ENDWITH

                *-- Segunda linha: quantidade solicitada + quantidade selecionada + status
                .AddObject("lbl_4c_LblQtdSol", "Label")
                WITH .lbl_4c_LblQtdSol
                    .AutoSize  = .F.
                    .Caption   = "Qtde Solicitada :"
                    .Top       = 30
                    .Left      = 8
                    .Width     = 100
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                ENDWITH

                .AddObject("txt_4c_DadosQtdSol", "TextBox")
                WITH .txt_4c_DadosQtdSol
                    .Top         = 28
                    .Left        = 112
                    .Width       = 80
                    .Height      = 19
                    .ReadOnly    = .T.
                    .Format      = "@Z 9999999.999"
                    .BackColor   = RGB(255,255,255)
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .Value       = 0
                ENDWITH

                *-- Status da selecao: aguardando, em andamento ou concluida
                .AddObject("lbl_4c_LblStatus", "Label")
                WITH .lbl_4c_LblStatus
                    .AutoSize  = .F.
                    .Caption   = "Status :"
                    .Top       = 30
                    .Left      = 210
                    .Width     = 48
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .FontBold  = .T.
                ENDWITH

                .AddObject("lbl_4c_DadosStatus", "Label")
                WITH .lbl_4c_DadosStatus
                    .AutoSize  = .F.
                    .Caption   = "Aguardando sele" + CHR(231) + CHR(227) + "o"
                    .Top       = 30
                    .Left      = 260
                    .Width     = 208
                    .Height    = 17
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90,90,90)
                ENDWITH
            ENDWITH

        CATCH TO loc_oErr
            MsgErro("Erro em ConfigurarPaginaDados: " + loc_oErr.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;
                    " Proc:" + loc_oErr.Procedure + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Controla navegacao entre as 6 pages operacionais
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        WITH THIS.pgf_4c_Paginas
            .Page1.Enabled = .T.
            .Page2.Enabled = .T.
            .Page3.Enabled = .F.
            .Page4.Enabled = .F.
            .Page5.Enabled = .F.
            .Page6.Enabled = .F.

            DO CASE
                CASE par_nPagina = 1
                    .ActivePage = 1
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
                        THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
                    ENDIF
                CASE par_nPagina = 2
                    .ActivePage = 2
                CASE par_nPagina = 3
                    .Page1.Enabled = .F.
                    .Page2.Enabled = .F.
                    .Page3.Enabled = .T.
                    .ActivePage = 3
                CASE par_nPagina = 4
                    .Page1.Enabled = .F.
                    .Page2.Enabled = .F.
                    .Page4.Enabled = .T.
                    .ActivePage = 4
                CASE par_nPagina = 5
                    .Page1.Enabled = .F.
                    .Page2.Enabled = .F.
                    .Page5.Enabled = .T.
                    .ActivePage = 5
                CASE par_nPagina = 6
                    .Page1.Enabled = .F.
                    .Page2.Enabled = .F.
                    .Page6.Enabled = .T.
                    .ActivePage = 6
            ENDCASE
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensAfterRowColChange - Atualiza paineis ao mudar linha na grade
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_lcSql, loc_lcArquivo, loc_lcFoto

        IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        *-- Posicionar TmpSaldo na linha atual
        IF USED("TmpSaldo")
            =SEEK(TmpFinalg.Cpros + TmpFinalg.CodCors + TmpFinalg.CodTams, "TmpSaldo")
        ENDIF

        *-- Filtrar TmpSaldG para linha atual
        IF USED("TmpSaldG")
            SELECT TmpSaldG
            SET ORDER TO Cpros
            SET KEY TO TmpFinalg.Cpros + TmpFinalg.CodCors + TmpFinalg.CodTams
            GO TOP
        ENDIF

        *-- Atualizar Container3 (Estoque Disponivel)
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_GradeDisp
            IF USED("TmpSaldo") AND NOT EOF("TmpSaldo")
                .txt_4c_DispQtd.Value = TmpSaldo.Saldo
                .txt_4c_DispEst.Value = TmpSaldo.Saldo - TmpSaldo.Disps
                .txt_4c_DispPrz.Value = TmpSaldo.Disps
            ELSE
                .txt_4c_DispQtd.Value = 0
                .txt_4c_DispEst.Value = 0
                .txt_4c_DispPrz.Value = 0
            ENDIF
            .lbl_4c_TituloDisp.Caption = "Estoque Dispon"+CHR(237)+"vel " + ;
                ALLTRIM(TmpFinalg.Cpros) + ;
                IIF(NOT EMPTY(TmpFinalg.CodCors), " Cor:"+ALLTRIM(TmpFinalg.CodCors), "") + ;
                IIF(NOT EMPTY(TmpFinalg.CodTams), " Tam:"+ALLTRIM(TmpFinalg.CodTams), "")
            .grd_4c_GradeDisp.Refresh
            .Visible     = .T.
        ENDWITH

        *-- Atualizar barra de informacoes (Container5)
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_BarraInfo
            .txt_4c_CodProd.Value = ALLTRIM(TmpFinalg.Cpros)
            .txt_4c_MinProd.Value = TmpFinalg.QtdMins
            .Visible     = .T.
        ENDWITH

        *-- Atualizar Container1 (Producao em andamento)
        THIS.pgf_4c_Paginas.Page1.cnt_4c_GradeProd.grd_4c_GradeProd.Refresh

        *-- Carregar imagem do produto
        loc_lcSql = [SELECT cpros, figjpgs FROM SigCdPro WHERE Cpros = ] + ;
                    EscaparSQL(TmpFinalg.Cpros)
        IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_ProdFig") >= 1
            WITH THIS.pgf_4c_Paginas.Page1.img_4c_FigJpg
                IF NOT EMPTY(cursor_4c_ProdFig.FigJpgs) AND NOT ISNULL(cursor_4c_ProdFig.FigJpgs)
                    loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                    loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ProdFig.FigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    =STRTOFILE(loc_lcFoto, loc_lcArquivo)
                    .Picture = loc_lcArquivo
                    .Visible = .T.
                ELSE
                    .Picture = ""
                    .Visible = .F.
                ENDIF
            ENDWITH
            USE IN cursor_4c_ProdFig
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol3Click - Click na coluna 3 navega para Page2 (Operacoes)
    * Equivalente ao PageDados.Activate do legado: filtra TmpFinal e inicializa totais
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol3Click
        LOCAL loc_oPag2

        *-- Filtrar TmpFinal para o produto/cor/tam corrente (SET KEY dinamico)
        IF USED("TmpFinal") AND USED("TmpFinalg") AND NOT EOF("TmpFinalg")
            SELECT TmpFinal
            SET ORDER TO Cpros
            SET KEY TO TmpFinalg.Cpros + TmpFinalg.CodCors + TmpFinalg.CodTams
            GO TOP
        ENDIF

        *-- Inicializar totais da secao "Qtd Selecionada" em Page2
        IF USED("TmpFinalg") AND NOT EOF("TmpFinalg")
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2
            loc_oPag2.txt_4c_TotSEst.Value = TmpFinalg.Estoque
            loc_oPag2.txt_4c_TotSPrc.Value = TmpFinalg.Fabrs
            THIS.AtualizarTotaisPage2()
        ENDIF

        THIS.pgf_4c_Paginas.Page2.Enabled = .T.
        THIS.pgf_4c_Paginas.ActivePage = 2
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_GradeOpe", 5)
            THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol7GotFocus - Salva valor anterior de Produzir
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol7GotFocus
        THIS.this_nOldValue = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol7Valid - Valida e aplica nova quantidade de Producao
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol7Valid
        LOCAL loc_lResultado, loc_nNewVal, loc_nMaxProd, loc_nQtdMin
        loc_lResultado = .T.
        loc_nNewVal    = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value

        *-- Garantir registro em TmpSaldU para este produto
        IF USED("TmpSaldU") AND NOT SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
        ENDIF

        *-- Checar se produto usa selecao manual de OP
        IF USED("TmpSaldU") AND loc_nNewVal <> THIS.this_nOldValue AND TmpSaldU.KeySelmp
            IF NOT MsgConfirma("Produto com Sele"+CHR(231)+CHR(227)+"o Manual de OP. "+CHR(13)+ ;
                    "O sistema ir"+CHR(225)+" acionar o modo autom"+CHR(225)+"tico. Deseja Continuar?")
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value = THIS.this_nOldValue
                RETURN .F.
            ENDIF
        ENDIF

        loc_nMaxProd = IIF(USED("TmpFinalg") AND NOT EOF("TmpFinalg"), ;
                           TmpFinalg.Saldo - TmpFinalg.Estoque, 0)
        loc_nQtdMin  = IIF(USED("TmpFinalg") AND NOT EOF("TmpFinalg"), TmpFinalg.QtdMins, 0)

        DO CASE
            CASE loc_nNewVal = THIS.this_nOldValue
                *-- Sem alteracao: aceitar
            CASE loc_nNewVal < 0
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser um valor negativo...")
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.
            CASE loc_nNewVal > loc_nMaxProd
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade dispon"+CHR(237)+"vel para produ"+CHR(231)+CHR(227)+"o...")
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.
            OTHERWISE
                *-- Atualizar TmpFinalg: Produzir, UsuLibs, Produzir2
                REPLACE Produzir  WITH loc_nNewVal, ;
                        UsuLibs   WITH " ", ;
                        Produzir2 WITH IIF(loc_nQtdMin > 0 AND loc_nNewVal < loc_nQtdMin AND loc_nNewVal > 0, ;
                                         loc_nQtdMin - loc_nNewVal, 0) ;
                IN TmpFinalg
                *-- Resetar flag de selecao manual de OP
                IF USED("TmpSaldU") AND NOT EOF("TmpSaldU")
                    REPLACE KeySelmp WITH .F. IN TmpSaldU
                ENDIF
                *-- Atualizar disponibilidade em TmpSaldG
                IF USED("TmpSaldo") AND NOT EOF("TmpSaldo") AND USED("TmpSaldG")
                    LOCAL loc_nDisps
                    loc_nDisps = TmpSaldo.Disps
                    SELECT TmpSaldG
                    SCAN
                        REPLACE Disps WITH loc_nDisps IN TmpSaldG
                    ENDSCAN
                ENDIF
        ENDCASE

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol7LostFocus - Atualiza totais apos edicao de Producao
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol7LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        THIS.AtualizarTotaisGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol8LostFocus - Fecha janela de edicao de Produzir Estq
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol8LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        THIS.this_lLiberado = .F.
        THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column8.ReadOnly = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol10GotFocus - Salva valor anterior de Estoque e trata Disponivel
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol10GotFocus
        LOCAL loc_lcSql
        THIS.this_nOldValue = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value
        THIS.pgf_4c_Paginas.Page1.btn_4c_Disponivel.Visible = .F.

        *-- Mostrar botao Disponivel apenas para reserva de produtos tipo 3 ou 4
        IF THIS.this_lReserva AND USED("TmpFinalg") AND NOT EOF("TmpFinalg") AND TmpFinalg.Estoque = 0
            loc_lcSql = [SELECT g.TipoEstos FROM SigCdPro p ] + ;
                        [INNER JOIN SigCdGrp g ON g.CGrus = p.CGrus ] + ;
                        [WHERE p.CPros = ] + EscaparSQL(TmpFinalg.Cpros)
            IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_TipoEsto") >= 1
                IF INLIST(cursor_4c_TipoEsto.TipoEstos, 3, 4)
                    THIS.pgf_4c_Paginas.Page1.btn_4c_Disponivel.Visible = .T.
                ENDIF
                USE IN cursor_4c_TipoEsto
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol10Valid - Valida e aplica nova quantidade de Estoque
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol10Valid
        LOCAL loc_lResultado, loc_nNewVal, loc_nMaxEst, loc_nDelta, loc_nNovoProd, loc_nQtdMin
        loc_lResultado = .T.
        loc_nNewVal    = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value

        *-- Garantir registro em TmpSaldU para este produto
        IF USED("TmpSaldU") AND NOT SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
        ENDIF

        *-- Checar se produto usa selecao manual de estoque
        IF USED("TmpSaldU") AND loc_nNewVal <> THIS.this_nOldValue AND TmpSaldU.KeySelm
            IF NOT MsgConfirma("Produto com Sele"+CHR(231)+CHR(227)+"o Manual de estoque. "+CHR(13)+ ;
                    "O sistema ir"+CHR(225)+" acionar o modo autom"+CHR(225)+"tico. Deseja Continuar?")
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value = THIS.this_nOldValue
                RETURN .F.
            ENDIF
        ENDIF

        loc_nMaxEst = IIF(USED("TmpSaldo") AND NOT EOF("TmpSaldo"), TmpSaldo.Disps, 0)
        loc_nQtdMin = IIF(USED("TmpFinalg") AND NOT EOF("TmpFinalg"), TmpFinalg.QtdMins, 0)

        DO CASE
            CASE loc_nNewVal = THIS.this_nOldValue
                *-- Sem alteracao: aceitar
            CASE loc_nNewVal < 0
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser um valor negativo...")
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.
            CASE loc_nNewVal > loc_nMaxEst
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que o estoque dispon"+CHR(237)+"vel...")
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.
            OTHERWISE
                *-- Calcular delta e balancear Estoque x Producao
                loc_nDelta    = loc_nNewVal - TmpFinalg.Estoque
                loc_nNovoProd = TmpFinalg.Produzir - loc_nDelta
                IF loc_nNovoProd < 0
                    loc_nNovoProd = 0
                ENDIF
                *-- Atualizar TmpFinalg: Estoque, Produzir, Produzir2
                REPLACE Estoque   WITH loc_nNewVal, ;
                        Produzir  WITH loc_nNovoProd, ;
                        Produzir2 WITH IIF(loc_nQtdMin > 0 AND loc_nNovoProd < loc_nQtdMin AND loc_nNovoProd > 0, ;
                                         loc_nQtdMin - loc_nNovoProd, 0) ;
                IN TmpFinalg
                *-- Resetar flag de selecao manual de estoque
                IF USED("TmpSaldU") AND NOT EOF("TmpSaldU")
                    REPLACE KeySelm WITH .F. IN TmpSaldU
                ENDIF
        ENDCASE

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensCol10LostFocus - Atualiza totais apos edicao de Estoque
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensCol10LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        THIS.AtualizarTotaisGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotaisGrade - Recalcula e exibe totais de TmpFinalg
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarTotaisGrade()
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze

        IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        SELECT TmpFinalg
        loc_nRecno = RECNO()
        SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 ;
            TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
        GO loc_nRecno

        WITH THIS.pgf_4c_Paginas.Page1
            .txt_4c_TotQtd.Value  = loc_nSal
            .txt_4c_TotEst.Value  = loc_nEst
            .txt_4c_TotPrdc.Value = loc_nPrc
            .txt_4c_TotPrz.Value  = loc_nPrz
            .txt_4c_TotPrze.Value = loc_nPrze
            .txt_4c_TotQtd.Refresh
            .txt_4c_TotEst.Refresh
            .txt_4c_TotPrdc.Refresh
            .txt_4c_TotPrz.Refresh
            .txt_4c_TotPrze.Refresh
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgFigJpgClick - Exibe/recarrega foto do produto ao clicar na imagem
    *--------------------------------------------------------------------------
    PROCEDURE ImgFigJpgClick
        LOCAL loc_lcSql, loc_lcArquivo, loc_lcFoto

        IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN
        ENDIF

        loc_lcSql = [SELECT a.cpros, a.dpros, a.figjpgs FROM SigCdPro a WHERE a.cpros = ] + ;
                    EscaparSQL(TmpFinalg.Cpros)

        IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_LocalPro") >= 1
            WITH THIS.pgf_4c_Paginas.Page1.img_4c_FigJpg
                IF NOT EMPTY(cursor_4c_LocalPro.FigJpgs) AND NOT ISNULL(cursor_4c_LocalPro.FigJpgs)
                    loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                    loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_LocalPro.FigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    =STRTOFILE(loc_lcFoto, loc_lcArquivo)
                    .Picture = loc_lcArquivo
                    .Visible = .T.
                ELSE
                    MsgAviso("Nenhuma imagem cadastrada para este produto.")
                ENDIF
            ENDWITH
            USE IN cursor_4c_LocalPro
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Delega processamento da globalizacao ao BO
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        IF NOT MsgConfirma("Confirma o processamento da Globaliza"+CHR(231)+CHR(227)+"o?")
            RETURN
        ENDIF

        THIS.MostrarAguarde("Processando...")

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.Processar()
        CATCH TO loc_oErr
            MsgErro("Erro ao processar: " + loc_oErr.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErr.LineNo) + "]", "Erro")
        ENDTRY

        THIS.OcultarAguarde()

        IF loc_lSucesso
            MsgInfo("Processamento conclu"+CHR(237)+"do com sucesso!")
            THIS.BtnCancelarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnTotLinhaClick - Calcula totais por linha e navega para Page3
    *--------------------------------------------------------------------------
    PROCEDURE BtnTotLinhaClick
        IF USED("TmpLinha")
            THIS.pgf_4c_Paginas.Page3.grd_4c_GradeLinhas.RecordSource = ""
            USE IN TmpLinha
        ENDIF

        SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, ;
               SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
        FROM TmpFinalg GROUP BY 1 ;
        UNION ALL ;
        SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, ;
               SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
        FROM TmpFinalg GROUP BY 1 ;
        INTO CURSOR TmpLinha ORDER BY 2, 1

        WITH THIS.pgf_4c_Paginas.Page3.grd_4c_GradeLinhas
            .RecordSource = "TmpLinha"
            .Refresh
        ENDWITH

        THIS.AlternarPagina(3)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Encerra o form e reativa o form pai
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDisponivelClick - Selecao por disponibilidade de tamanhos (Page5)
    *--------------------------------------------------------------------------
    PROCEDURE BtnDisponivelClick
        LOCAL loc_lcCpro, loc_lcCor

        IF TmpFinalg.Estoque <> 0 OR TmpFinalg.Fabrs <> 0
            MsgAviso("Quantidade de Estoque e Produ"+CHR(231)+CHR(227)+"o tem estar Zero antes deste Processo!!!")
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
            RETURN
        ENDIF

        loc_lcCpro = TmpFinalg.Cpros
        loc_lcCor  = TmpFinalg.CodCors

        IF USED("TmpDisp")
            THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.RecordSource = ""
            USE IN TmpDisp
        ENDIF

        SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
        FROM TmpSaldo ;
        WHERE Cpros = loc_lcCpro AND CodCors = loc_lcCor AND Disps > 0 ;
        INTO CURSOR Resultado ORDER BY 1, 2, 3

        SELECT 0
        USE DBF("Resultado") ALIAS TmpDisp AGAIN
        USE IN Resultado

        IF RECCOUNT("TmpDisp") = 0
            MsgAviso("Nenhum tamanho dispon"+CHR(237)+"vel para esta refer"+CHR(234)+"ncia.")
            IF USED("TmpDisp")
                USE IN TmpDisp
            ENDIF
            RETURN
        ENDIF

        WITH THIS.pgf_4c_Paginas.Page5
            .txt_4c_P5CodProd.Value  = ALLTRIM(loc_lcCpro) + ;
                IIF(NOT EMPTY(loc_lcCor), "/"+ALLTRIM(loc_lcCor), "")
            .txt_4c_P5QtPedida.Value = TmpFinalg.Saldo
            .txt_4c_P5QtSelec.Value  = 0
            .grd_4c_GradeDisp.RecordSource = "TmpDisp"
            .grd_4c_GradeDisp.Refresh
        ENDWITH

        THIS.AlternarPagina(5)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelEstoqueClick - Selecao de estoque por conta/grupo (Page4)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelEstoqueClick
        LOCAL loc_lcCpro, loc_lcCor, loc_lcTam

        loc_lcCpro = TmpFinalg.Cpros
        loc_lcCor  = TmpFinalg.CodCors
        loc_lcTam  = TmpFinalg.CodTams

        IF USED("TmpDisp")
            THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.RecordSource = ""
            USE IN TmpDisp
        ENDIF

        SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
        FROM TmpSaldG ;
        WHERE Cpros = loc_lcCpro AND CodCors = loc_lcCor AND CodTams = loc_lcTam AND Disps > 0 ;
        INTO CURSOR Resultado ORDER BY 1, 2, 3, 4

        SELECT 0
        USE DBF("Resultado") ALIAS TmpDisp AGAIN
        USE IN Resultado

        IF RECCOUNT("TmpDisp") = 0
            MsgAviso("Nenhum estoque dispon"+CHR(237)+"vel para esta refer"+CHR(234)+"ncia.")
            IF USED("TmpDisp")
                USE IN TmpDisp
            ENDIF
            RETURN
        ENDIF

        WITH THIS.pgf_4c_Paginas.Page4
            .txt_4c_P4CodProd.Value  = ALLTRIM(loc_lcCpro) + ;
                IIF(NOT EMPTY(loc_lcCor), "/"+ALLTRIM(loc_lcCor), "") + ;
                IIF(NOT EMPTY(loc_lcTam), "/"+ALLTRIM(loc_lcTam), "")
            .txt_4c_P4QtPedida.Value = TmpFinalg.Saldo - TmpFinalg.Estoque
            .txt_4c_P4QtSelec.Value  = 0
            .grd_4c_GradeSelEst.RecordSource = "TmpDisp"
            .grd_4c_GradeSelEst.Refresh
        ENDWITH

        THIS.AlternarPagina(4)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnPedrasClick - Configura grade de requisicoes e navega para Page6
    *--------------------------------------------------------------------------
    PROCEDURE BtnPedrasClick
        WITH THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra
            IF USED("SelPedra")
                .RecordSource = ""
            ENDIF
            .RecordSource          = "SelPedra"
            .ColumnCount           = 5
            .Column1.ControlSource = "SelPedra.Cpros"
            .Column2.ControlSource = "SelPedra.Dpros"
            .Column3.ControlSource = "SelPedra.Cunis"
            .Column4.ControlSource = "SelPedra.Qtds"
            .Column5.ControlSource = "SelPedra.Cpro2s"
            .Refresh
        ENDWITH

        THIS.pgf_4c_Paginas.Page6.txt_4c_P6CodProd.Value = ALLTRIM(TmpFinalg.Cpros)
        THIS.AlternarPagina(6)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlteraqtdClick - Autoriza alteracao de Produzir2 via SigOpSen
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlteraqtdClick
        LOCAL loc_lcString, loc_lcRetorno

        IF TmpFinalg.Produzir2 = 0
            MsgAviso("Referencia Sem Quantidade a Produzir para Estoque!!!")
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
            RETURN
        ENDIF

        loc_lcString = ALLTRIM(TmpFinalg.Cpros) + " Qt.Min:" + ;
            ALLTRIM(TRANSFORM(TmpFinalg.QtdMins,  "@Z 99999.999")) + " " + ;
            "Qt.Est:" + ALLTRIM(TRANSFORM(TmpFinalg.Produzir2, "@Z 99999.999"))

        DO FORM SigOpSen WITH "PRDZRISCO", loc_lcString, "" TO loc_lcRetorno

        CLEAR TYPEAHEAD
        IF LEFT(loc_lcRetorno, 1) = "*"
            THIS.this_lLiberado = .T.
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column8.ReadOnly = .F.
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column8.Text1.SetFocus
        ELSE
            MsgAviso("Altera"+CHR(231)+CHR(227)+"o n"+CHR(227)+"o autorizada!")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage2Click - Valida e retorna de Operacoes Detalhadas para Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage2Click
        LOCAL loc_nSumEst, loc_nSumPrc

        IF USED("TmpFinal") AND USED("TmpFinalg") AND NOT EOF("TmpFinalg")
            SELECT TmpFinal
            SUM TmpFinal.Estoque, TmpFinal.Fabrs TO loc_nSumEst, loc_nSumPrc

            IF loc_nSumEst <> TmpFinalg.Estoque
                MsgAviso("A quantidade de Estoque n"+CHR(227)+"o confere com a Quantidade Selecionada!!!")
                RETURN
            ENDIF
            IF loc_nSumPrc <> TmpFinalg.Fabrs
                MsgAviso("A quantidade de Produ"+CHR(231)+CHR(227)+"o n"+CHR(227)+"o confere com a Quantidade Selecionada!!!")
                RETURN
            ENDIF
        ENDIF

        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage3Click - Retorna de Totais por Linha para Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage3Click
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage4Click - Aplica selecoes de estoque (TmpDisp) e retorna para Page1
    * Logica: Page4.CancelaDisp.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage4Click
        LOCAL loc_nQtdUti, loc_nQtUtil, loc_nXBaixa, loc_oErr
        loc_nQtdUti = 0
        loc_nQtUtil = 0
        loc_nXBaixa = 0

        TRY
            IF USED("TmpDisp")

                SELECT TmpDisp
                SUM Utilizar TO loc_nQtdUti

                IF loc_nQtdUti > 0

                    SELECT TmpDisp
                    SCAN
                        IF TmpDisp.Utilizar = 0
                            LOOP
                        ENDIF
                        loc_nQtUtil = TmpDisp.Utilizar

                        =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo')

                        SELECT TmpFinalg
                        REPLACE Produzir  WITH Produzir - loc_nQtUtil, ;
                                Estoque   WITH Estoque + loc_nQtUtil, ;
                                UsuLibs   WITH ' ' IN TmpFinalg
                        REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
                                                  QtdMins - Produzir, 0) IN TmpFinalg

                        SELECT TmpSaldo
                        REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nQtUtil IN TmpSaldo

                        *-- Registrar selecao manual de estoque em TmpSaldU
                        IF NOT SEEK(TmpFinalg.Cpros, 'TmpSaldU', 'Cpros')
                            INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
                        ENDIF
                        REPLACE keySelm WITH .T. IN TmpSaldU

                        *-- Atualizar disponivel no grupo/conta especifico em TmpSaldG
                        SELECT TmpSaldG
                        SET ORDER TO Cpros
                        =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + ;
                              STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
                        REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nQtUtil

                    ENDSCAN

                    *-- Redistribuir Estoque acumulado pelas operacoes em TmpFinal
                    =SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, 'TmpSaldo')
                    loc_nXBaixa = TmpFinalg.Estoque

                    SELECT TmpFinal
                    SET ORDER TO
                    SET ORDER TO Cpros
                    =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    REPLACE Estoque WITH 0 ;
                        WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND ;
                              CodTams = TmpSaldo.CodTams
                    =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND ;
                               CodTams = TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF TmpFinal.Saldo - TmpFinal.Fabrs >= loc_nXBaixa
                            REPLACE TmpFinal.Estoque WITH TmpFinal.Estoque + loc_nXBaixa IN TmpFinal
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - ( TmpFinal.Saldo - TmpFinal.Fabrs )
                            REPLACE TmpFinal.Estoque WITH ( TmpFinal.Saldo - TmpFinal.Fabrs ) IN TmpFinal
                        ENDIF
                        REPLACE Produzir WITH Saldo - Estoque - Fabrs IN TmpFinal
                    ENDSCAN

                ENDIF

                THIS.AtualizarTotaisGrade()

            ENDIF

            THIS.AlternarPagina(1)

        CATCH TO loc_oErr
            MsgErro("Erro em BtnVoltarPage4Click: " + loc_oErr.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;
                    " Proc:" + loc_oErr.Procedure + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage5Click - Aplica selecoes por tamanho (TmpDisp) e retorna para Page1
    * Logica: Page5.CancelaDisp.Click do legado ? quebra TmpFinal por tamanho
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage5Click
        LOCAL loc_nRegFinal, loc_nQtdUti, loc_nQtUtil, loc_nXBaixa, loc_oErr
        LOCAL ARRAY loc_aFinal[1], loc_aMemvar[1]
        loc_nRegFinal = 0
        loc_nQtdUti   = 0
        loc_nQtUtil   = 0
        loc_nXBaixa   = 0

        TRY
            IF USED("TmpDisp") AND USED("TmpFinal")

                SELECT TmpFinal
                SET ORDER TO
                loc_nRegFinal = RECNO()

                SELECT TmpDisp
                SUM Utilizar TO loc_nQtdUti

            IF loc_nQtdUti > 0

                *-- Criar cursor Temporario com mesma estrutura de TmpFinal para staging
                SELECT TmpFinal
                =AFIELDS(loc_aFinal)
                CREATE CURSOR Temporario FROM ARRAY loc_aFinal

                SELECT TmpDisp
                SCAN
                    IF TmpDisp.Utilizar = 0
                        LOOP
                    ENDIF
                    loc_nQtUtil = TmpDisp.Utilizar

                    =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo')

                    *-- Copiar linha TmpFinal para Temporario, ajustando tamanho e quantidade
                    SELECT TmpFinal
                    SCATTER TO loc_aMemvar
                    SELECT Temporario
                    APPEND FROM ARRAY loc_aMemvar
                    REPLACE Temporario.Saldo    WITH loc_nQtUtil, ;
                            Temporario.CodTams  WITH TmpDisp.CodTams, ;
                            Temporario.Estoque  WITH loc_nQtUtil, ;
                            Temporario.Produzir WITH 0

                    *-- Reduzir TmpFinal e TmpFinalg pelo que foi alocado neste tamanho
                    SELECT TmpFinal
                    REPLACE TmpFinal.Saldo    WITH TmpFinal.Saldo    - loc_nQtUtil, ;
                            TmpFinal.Produzir WITH TmpFinal.Produzir - loc_nQtUtil IN TmpFinal

                    REPLACE Saldo    WITH Saldo    - loc_nQtUtil, ;
                            Produzir WITH Produzir - loc_nQtUtil IN TmpFinalg

                    SELECT TmpFinalg
                    REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
                                              QtdMins - Produzir, 0) IN TmpFinalg

                    *-- Atualizar TmpSaldo: reduzir Disps
                    SELECT TmpSaldo
                    REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nQtUtil

                    *-- Redistribuir Disps em TmpSaldG: reset ao Saldo, depois debitar xBaixa
                    loc_nXBaixa = TmpSaldo.Saldo - TmpSaldo.Disps
                    SELECT TmpSaldG
                    SET ORDER TO Cpros
                    =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    REPLACE Disps WITH Saldo ;
                        WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND ;
                              CodTams = TmpSaldo.CodTams
                    =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
                    SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND ;
                               CodTams = TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF TmpSaldG.Disps >= loc_nXBaixa
                            REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_nXBaixa
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - TmpSaldG.Disps
                            REPLACE TmpSaldG.Disps WITH 0
                        ENDIF
                    ENDSCAN

                    *-- Quebrar SigMvIts: dividir linha sem tamanho pelo tamanho selecionado
                    IF USED("SigMvIts")
                        SELECT SigMvIts
                        SET ORDER TO EmpDopnPro
                        SEEK(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6) + TmpFinal.Cpros)
                        SCAN WHILE Emps + Dopes + STR(Numes, 6) + Cpros = ;
                                   TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6) + TmpFinal.Cpros
                            IF Citens <> TmpFinal.Citens
                                LOOP
                            ENDIF
                            IF CodCors = TmpFinal.CodCors AND CodTams = SPACE(4)
                                *-- Captura registro original; ajusta registro atual com novo tamanho
                                SCATTER TO loc_aMemvar
                                REPLACE CodTams WITH TmpDisp.CodTams
                                REPLACE Qtds    WITH loc_nQtUtil
                                REPLACE Aqtds   WITH Qtds
                                *-- Readiciona registro original com quantidade reduzida
                                APPEND FROM ARRAY loc_aMemvar
                                REPLACE Qtds  WITH Qtds - loc_nQtUtil
                                REPLACE Aqtds WITH Qtds
                                IF Qtds = 0
                                    DELETE
                                ENDIF
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                ENDSCAN

                *-- Incorporar registros de Temporario em TmpFinal e limpar zerados
                SELECT TmpFinal
                APPEND FROM DBF('Temporario')
                GO loc_nRegFinal
                IF TmpFinal.Saldo = 0
                    DELETE
                ENDIF

                SELECT TmpFinalg
                IF TmpFinalg.Saldo = 0
                    DELETE
                ENDIF

                =SEEK(TmpFinalg.CPros + TmpFinalg.CodCors + TmpFinalg.CodTams, 'TmpSaldo')

            ENDIF

                THIS.AtualizarTotaisGrade()

            ENDIF

            THIS.AlternarPagina(1)

        CATCH TO loc_oErr
            MsgErro("Erro em BtnVoltarPage5Click: " + loc_oErr.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;
                    " Proc:" + loc_oErr.Procedure + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeSelEstCol5Valid - Valida quantidade Utilizar na grade de Page4 (Sel.Estoque)
    *--------------------------------------------------------------------------
    PROCEDURE GradeSelEstCol5Valid
        LOCAL loc_nVal, loc_nPedida, loc_nRegDisp, loc_nQtdUti, loc_lResultado
        loc_lResultado = .T.
        loc_nVal       = 0
        loc_nPedida    = 0
        loc_nRegDisp   = 0
        loc_nQtdUti    = 0

        IF NOT USED("TmpDisp") OR NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            RETURN loc_lResultado
        ENDIF

        loc_nVal    = THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value
        loc_nPedida = TmpFinalg.Saldo - TmpFinalg.Estoque

        IF loc_nVal > TmpDisp.Disps
            MsgAviso("A quantidade a utilizar n"+CHR(227)+"o pode ser maior que Qtde Dispon"+CHR(237)+"vel...")
            THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value = 0
            THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
            loc_lResultado = .F.
        ELSE
            IF loc_nVal < 0
                MsgAviso("A quantidade a utilizar n"+CHR(227)+"o pode ser menor que zero...")
                THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value = 0
                THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
                loc_lResultado = .F.
            ELSE
                loc_nRegDisp = RECNO("TmpDisp")
                SELECT TmpDisp
                SUM TmpDisp.Utilizar TO loc_nQtdUti
                GO loc_nRegDisp IN TmpDisp
                IF loc_nQtdUti > loc_nPedida
                    MsgAviso("Qtde Selecionada n"+CHR(227)+"o pode ser maior que Qtde Solicitada...")
                    THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value = 0
                    THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
                    loc_lResultado = .F.
                ELSE
                    WITH THIS.pgf_4c_Paginas.Page4
                        .txt_4c_P4QtSelec.Value = loc_nQtdUti
                        .txt_4c_P4QtSelec.Refresh
                    ENDWITH
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeSelEstCol5LostFocus - Avanca linha ao Enter na grade de Page4
    *--------------------------------------------------------------------------
    PROCEDURE GradeSelEstCol5LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF LASTKEY() = 13
            KEYBOARD "{DNARROW}"
        ENDIF
        THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDispColsGotFocus - Colunas ReadOnly de Page5 redirecionam foco para Col5
    *--------------------------------------------------------------------------
    PROCEDURE GradeDispColsGotFocus
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page5, "grd_4c_GradeDisp", 5)
            THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeDispCol5Valid - Valida quantidade Utilizar na grade de Page5 (Disponivel/Tam)
    *--------------------------------------------------------------------------
    PROCEDURE GradeDispCol5Valid
        LOCAL loc_nVal, loc_nPedida, loc_nRegDisp, loc_nQtdUti, loc_lResultado
        loc_lResultado = .T.
        loc_nVal       = 0
        loc_nPedida    = 0
        loc_nRegDisp   = 0
        loc_nQtdUti    = 0

        IF NOT USED("TmpDisp") OR NOT PEMSTATUS(THIS.pgf_4c_Paginas.Page5, "txt_4c_P5QtPedida", 5)
            RETURN loc_lResultado
        ENDIF

        loc_nVal    = THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Value
        loc_nPedida = THIS.pgf_4c_Paginas.Page5.txt_4c_P5QtPedida.Value

        IF loc_nVal > TmpDisp.Disps
            MsgAviso("A quantidade a utilizar n"+CHR(227)+"o pode ser maior que Qtde Dispon"+CHR(237)+"vel...")
            THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
            THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Refresh
            loc_lResultado = .F.
        ELSE
            loc_nRegDisp = RECNO("TmpDisp")
            SELECT TmpDisp
            SUM TmpDisp.Utilizar TO loc_nQtdUti
            GO loc_nRegDisp IN TmpDisp
            IF loc_nQtdUti > loc_nPedida
                MsgAviso("Qtde Selecionada n"+CHR(227)+"o pode ser maior que Qtde Pedida...")
                THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
                THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Refresh
                loc_lResultado = .F.
            ELSE
                WITH THIS.pgf_4c_Paginas.Page5
                    .txt_4c_P5QtSelec.Value = loc_nQtdUti
                    .txt_4c_P5QtSelec.Refresh
                ENDWITH
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVoltarPage6Click - Retorna de Requisicoes para Page1
    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarPage6Click
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOpeAfterRowColChange - Atualiza label obs e imagem ao mudar linha na Page2
    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeAfterRowColChange
        LPARAMETERS par_nColIndex
        LOCAL loc_lcSql, loc_lcArquivo, loc_lcFoto, loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        IF NOT USED("TmpFinal") OR EOF("TmpFinal")
            RETURN
        ENDIF

        loc_oPag2.lbl_4c_ObsItem.Caption = "Observa"+CHR(231)+CHR(227)+"o do Item " + ALLTRIM(TmpFinal.Cpros)
        loc_oPag2.edt_4c_ObsItens.Refresh

        loc_lcSql = [SELECT cpros, figjpgs FROM SigCdPro WHERE Cpros = ] + ;
                    EscaparSQL(TmpFinal.Cpros)
        IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_ProdFig2") >= 1
            WITH loc_oPag2.img_4c_FigOpe
                IF NOT EMPTY(cursor_4c_ProdFig2.FigJpgs) AND NOT ISNULL(cursor_4c_ProdFig2.FigJpgs)
                    loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                    loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ProdFig2.FigJpgs, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    =STRTOFILE(loc_lcFoto, loc_lcArquivo)
                    .Picture = loc_lcArquivo
                    .Visible = .T.
                ELSE
                    .Picture = ""
                    .Visible = .F.
                ENDIF
            ENDWITH
            USE IN cursor_4c_ProdFig2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOpeColsGotFocus - Colunas ReadOnly de Page2 redirecionam foco para Col7
    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeColsGotFocus
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_GradeOpe", 5)
            THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.SetFocus
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOpeCol7GotFocus - Salva valor anterior de Estoque (Col7 Page2)
    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeCol7GotFocus
        THIS.this_nOldValue = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOpeCol7Valid - Valida nova quantidade de Estoque na Page2
    * Limites: nao negativo, nao excede Saldo da operacao, nao excede Tot_sEst selecionado
    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeCol7Valid
        LOCAL loc_lResultado, loc_nNewVal, loc_nPSaldo
        loc_lResultado = .T.
        loc_nNewVal    = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value
        loc_nPSaldo    = THIS.pgf_4c_Paginas.Page2.txt_4c_TotSEst.Value

        DO CASE
            CASE loc_nNewVal = THIS.this_nOldValue
                *-- Sem alteracao: aceitar

            CASE loc_nNewVal < 0
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser um valor negativo...")
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.

            CASE USED("TmpFinal") AND NOT EOF("TmpFinal") AND loc_nNewVal > TmpFinal.Saldo
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade da Opera"+CHR(231)+CHR(227)+"o...")
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.

            CASE loc_nNewVal > loc_nPSaldo
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade Selecionada...")
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value = THIS.this_nOldValue
                loc_lResultado = .F.

            OTHERWISE
                IF USED("TmpFinal") AND NOT EOF("TmpFinal")
                    REPLACE TmpFinal.Estoque WITH loc_nNewVal IN TmpFinal
                ENDIF
        ENDCASE

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOpeCol7LostFocus - Atualiza totais de Page2 apos edicao de Estoque
    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeCol7LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        THIS.AtualizarTotaisPage2()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotaisPage2 - Recalcula e exibe totais de TmpFinal na Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarTotaisPage2()
        LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc

        IF NOT USED("TmpFinal") OR EOF("TmpFinal")
            RETURN
        ENDIF

        SELECT TmpFinal
        loc_nRecno = RECNO()
        SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
        GO loc_nRecno

        WITH THIS.pgf_4c_Paginas.Page2
            .txt_4c_P2TotQtd.Value = loc_nSal
            .txt_4c_P2TotEst.Value = loc_nEst
            .txt_4c_P2TotPrc.Value = loc_nPrc
            .txt_4c_P2TotPrz.Value = loc_nPrz
            .txt_4c_P2TotQtd.Refresh
            .txt_4c_P2TotEst.Refresh
            .txt_4c_P2TotPrc.Refresh
            .txt_4c_P2TotPrz.Refresh
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeCol10GotFocus
        THIS.this_nAntValue = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeCol10Valid
        LOCAL loc_lResultado, loc_nNewVal, loc_nPSaldo
        loc_lResultado = .T.
        loc_nNewVal    = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value
        loc_nPSaldo    = THIS.pgf_4c_Paginas.Page2.txt_4c_TotSPrc.Value

        DO CASE
            CASE loc_nNewVal = THIS.this_nAntValue
                *-- sem alteracao, nada a fazer
            CASE loc_nNewVal < 0
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser um valor negativo...")
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value = THIS.this_nAntValue
                loc_lResultado = .F.
            CASE USED("TmpFinal") AND NOT EOF("TmpFinal") AND loc_nNewVal > TmpFinal.Saldo
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade da Opera"+CHR(231)+CHR(227)+"o...")
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value = THIS.this_nAntValue
                loc_lResultado = .F.
            CASE loc_nNewVal > loc_nPSaldo
                MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade Selecionada...")
                THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value = THIS.this_nAntValue
                loc_lResultado = .F.
            OTHERWISE
                IF USED("TmpFinal") AND NOT EOF("TmpFinal")
                    REPLACE TmpFinal.Fabrs WITH loc_nNewVal IN TmpFinal
                ENDIF
        ENDCASE

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE GradeOpeCol10LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        THIS.AtualizarTotaisPage2()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradePedraCol1Valid - Lookup de produto principal na grade de Requisicao (Page6)
    * Busca em SigCdPro e preenche Dpros e Cunis no cursor SelPedra
    *--------------------------------------------------------------------------
    PROCEDURE GradePedraCol1Valid
        LOCAL loc_cCodPro, loc_oBusca, loc_oErr, loc_lcSql, loc_lcSql2
        loc_cCodPro = ""

        IF NOT USED("SelPedra") OR EOF("SelPedra")
            RETURN .T.
        ENDIF

        loc_cCodPro = ALLTRIM(THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Column1.Text1.Value)

        IF EMPTY(loc_cCodPro)
            REPLACE SelPedra.Dpros WITH "" IN SelPedra
            REPLACE SelPedra.Cunis WITH "" IN SelPedra
            RETURN .T.
        ENDIF

        TRY
            loc_lcSql = [SELECT a.CPros, a.DPros, a.Cunis FROM SigCdPro a WHERE a.CPros = ] + ;
                        EscaparSQL(loc_cCodPro)
            IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_BPPedra") >= 1 AND ;
               NOT EOF("cursor_4c_BPPedra")
                REPLACE SelPedra.Cpros  WITH ALLTRIM(cursor_4c_BPPedra.CPros) IN SelPedra
                REPLACE SelPedra.Dpros  WITH ALLTRIM(cursor_4c_BPPedra.DPros) IN SelPedra
                REPLACE SelPedra.Cunis  WITH ALLTRIM(cursor_4c_BPPedra.Cunis) IN SelPedra
                USE IN cursor_4c_BPPedra
            ELSE
                IF USED("cursor_4c_BPPedra")
                    USE IN cursor_4c_BPPedra
                ENDIF
                *-- Produto nao encontrado: abrir picker
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", "cursor_4c_BPPedra2", "CPros", loc_cCodPro, ;
                    "Selecionar Produto", .T., .T., "")
                loc_oBusca.mAddColuna("CPros", "", "C"+CHR(243)+"digo")
                loc_oBusca.mAddColuna("DPros", "", "Descri"+CHR(231)+CHR(227)+"o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BPPedra2")
                    REPLACE SelPedra.Cpros WITH ALLTRIM(cursor_4c_BPPedra2.CPros) IN SelPedra
                    REPLACE SelPedra.Dpros WITH ALLTRIM(cursor_4c_BPPedra2.DPros) IN SelPedra
                    *-- Buscar unidade complementar
                    loc_lcSql2 = [SELECT Cunis FROM SigCdPro WHERE CPros = ] + ;
                                 EscaparSQL(ALLTRIM(cursor_4c_BPPedra2.CPros))
                    IF SQLEXEC(gnConnHandle, loc_lcSql2, "cursor_4c_BPUni") >= 1
                        REPLACE SelPedra.Cunis WITH ALLTRIM(cursor_4c_BPUni.Cunis) IN SelPedra
                        USE IN cursor_4c_BPUni
                    ENDIF
                ELSE
                    REPLACE SelPedra.Cpros WITH "" IN SelPedra
                    REPLACE SelPedra.Dpros WITH "" IN SelPedra
                    REPLACE SelPedra.Cunis WITH "" IN SelPedra
                ENDIF
                IF USED("cursor_4c_BPPedra2")
                    USE IN cursor_4c_BPPedra2
                ENDIF
                loc_oBusca.Release()
            ENDIF

            THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Refresh

        CATCH TO loc_oErr
            MsgErro("Erro no lookup de produto (Grade Pedra): " + loc_oErr.Message, "Erro")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GradePedraCol4When - Coluna 4 (Qtde) so editavel se Produto preenchido
    *--------------------------------------------------------------------------
    PROCEDURE GradePedraCol4When
        IF NOT USED("SelPedra") OR EOF("SelPedra")
            RETURN .F.
        ENDIF
        RETURN NOT EMPTY(ALLTRIM(SelPedra.Cpros))
    ENDPROC

    *--------------------------------------------------------------------------
    * GradePedraCol5When - Coluna 5 (Produto Ref) so editavel se Produto preenchido
    *--------------------------------------------------------------------------
    PROCEDURE GradePedraCol5When
        IF NOT USED("SelPedra") OR EOF("SelPedra")
            RETURN .F.
        ENDIF
        RETURN NOT EMPTY(ALLTRIM(SelPedra.Cpros))
    ENDPROC

    *--------------------------------------------------------------------------
    * GradePedraCol5Valid - Lookup de produto referencia (Cpro2s) na grade Page6
    *--------------------------------------------------------------------------
    PROCEDURE GradePedraCol5Valid
        LOCAL loc_cCodRef, loc_oBusca, loc_oErr, loc_lcSql
        loc_cCodRef = ""

        IF NOT USED("SelPedra") OR EOF("SelPedra")
            RETURN .T.
        ENDIF

        loc_cCodRef = ALLTRIM(THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Column5.Text1.Value)

        IF EMPTY(loc_cCodRef)
            REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
            THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Refresh
            RETURN .T.
        ENDIF

        TRY
            loc_lcSql = [SELECT CPros FROM SigCdPro WHERE CPros = ] + EscaparSQL(loc_cCodRef)
            IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_BPro2") >= 1 AND ;
               NOT EOF("cursor_4c_BPro2")
                REPLACE SelPedra.Cpro2s WITH ALLTRIM(cursor_4c_BPro2.CPros) IN SelPedra
                USE IN cursor_4c_BPro2
            ELSE
                IF USED("cursor_4c_BPro2")
                    USE IN cursor_4c_BPro2
                ENDIF
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", "cursor_4c_BPro2b", "CPros", loc_cCodRef, ;
                    "Produto Refer"+CHR(234)+"ncia", .T., .T., "")
                loc_oBusca.mAddColuna("CPros", "", "C"+CHR(243)+"digo")
                loc_oBusca.mAddColuna("DPros", "", "Descri"+CHR(231)+CHR(227)+"o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BPro2b")
                    REPLACE SelPedra.Cpro2s WITH ALLTRIM(cursor_4c_BPro2b.CPros) IN SelPedra
                ELSE
                    REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
                ENDIF
                IF USED("cursor_4c_BPro2b")
                    USE IN cursor_4c_BPro2b
                ENDIF
                loc_oBusca.Release()
            ENDIF

            THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Refresh

        CATCH TO loc_oErr
            MsgErro("Erro no lookup de produto refer"+CHR(234)+"ncia: " + loc_oErr.Message, "Erro")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GradePedraCol5LostFocus - Adiciona nova linha quando usuario sai da ultima linha preenchida
    *--------------------------------------------------------------------------
    PROCEDURE GradePedraCol5LostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nPosicao
        IF NOT USED("SelPedra") OR EOF("SelPedra")
            RETURN
        ENDIF

        loc_nPosicao = RECNO("SelPedra")
        GO BOTTOM IN SelPedra
        IF NOT EMPTY(ALLTRIM(SelPedra.Cpros)) AND RECNO("SelPedra") = loc_nPosicao
            APPEND BLANK IN SelPedra
        ENDIF
        GO loc_nPosicao IN SelPedra
        KEYBOARD "{DNARROW}"
    ENDPROC

    *==========================================================================
    * ADAPTADORES CRUD PARA FORM OPERACIONAL
    * SIGPRGLX eh operacional (Previa da Globalizacao) e nao possui CRUD.
    * Os handlers abaixo mapeiam a interface CRUD padrao para as operacoes
    * reais do form: Processar (main action), Alterar Qtd (autorizacao),
    * Visualizar Imagem, e Cancelar/Encerrar.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Executa o processamento da globalizacao (acao principal)
    * Em forms operacionais de preview, "incluir" == confirmar e processar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick
        IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            MsgAviso("N"+CHR(227)+"o h"+CHR(225)+" itens dispon"+CHR(237)+"veis para processar.")
            RETURN
        ENDIF
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Autoriza alteracao da quantidade de producao para estoque
    * Delega para BtnAlteraqtdClick que abre SigOpSen para validar senha.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick
        IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            MsgAviso("Selecione um item da grade antes de alterar.")
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
            ENDIF
            RETURN
        ENDIF
        THIS.BtnAlteraqtdClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe a imagem do produto da linha corrente
    * Reproduz o mesmo SQL de ImgFigJpg.Click (SigCdPro.FigJpgs) e renderiza
    * em arquivo temporario alimentando o Image control da Page1.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick
        LOCAL loc_lcCodPro, loc_lcSql, loc_lcArquivo, loc_lcFoto, loc_oErr

        IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
            MsgAviso("Selecione um item da grade para visualizar a imagem.")
            RETURN
        ENDIF

        loc_lcCodPro  = TmpFinalg.Cpros
        loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
        loc_lcSql     = "SELECT a.cpros, a.dpros, a.FigJpgs FROM SigCdPro a " + ;
                        "WHERE a.cpros = " + EscaparSQL(loc_lcCodPro)

        TRY
            IF USED("cursor_4c_LocalPro")
                USE IN cursor_4c_LocalPro
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_LocalPro") < 1
                MsgAviso("N"+CHR(227)+"o foi poss"+CHR(237)+"vel carregar a imagem do produto.")
                RETURN
            ENDIF

            IF NOT EMPTY(NVL(cursor_4c_LocalPro.FigJpgs, "")) AND ;
               NOT ISNULL(cursor_4c_LocalPro.FigJpgs)

                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                    cursor_4c_LocalPro.FigJpgs, ;
                    "data:image/png;base64,",  ""), ;
                    "data:image/jpeg;base64,", ""), ;
                    "data:image/jpg;base64,",  ""), 14)
                =STRTOFILE(loc_lcFoto, loc_lcArquivo)

                WITH THIS.pgf_4c_Paginas.Page1.img_4c_FigJpg
                    .Picture = loc_lcArquivo
                    .Visible = .T.
                ENDWITH
            ELSE
                MsgAviso("Nenhuma imagem cadastrada para este produto.")
            ENDIF

            IF USED("cursor_4c_LocalPro")
                USE IN cursor_4c_LocalPro
            ENDIF
        CATCH TO loc_oErr
            MsgErro("Erro ao visualizar imagem: " + loc_oErr.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErr.LineNo) + "]", "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Encerra o form sem processar (equivale a cancelar)
    * Em preview de globalizacao, "excluir" == abandonar as alteracoes.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick
        IF NOT MsgConfirma("Confirma o cancelamento da Globaliza"+CHR(231)+CHR(227)+"o?" + ;
                           CHR(13) + "Todas as sele"+CHR(231)+CHR(245)+"es ser"+CHR(227)+"o descartadas.")
            RETURN
        ENDIF
        THIS.BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Acao principal do form operacional (delega para Processar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick
        THIS.BtnProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Atualiza exibicao dos dados das grades operacionais
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick
        IF USED("TmpFinalg") AND RECCOUNT("TmpFinalg") > 0
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
                THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Refresh
            ENDIF
            THIS.AtualizarTotaisGrade()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o form (mesma logica que BtnCancelarClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick
        THIS.BtnCancelarClick()
    ENDPROC

    *==========================================================================
    * METODOS DE SUPORTE (FASE 8)
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarLista - Vincula grades aos cursores operacionais (TmpFinalg etc.)
    * Para form operacional, os cursores sao passados via datasession do form pai;
    * este metodo apenas atualiza a exibicao apos os cursores estarem populados.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF NOT USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
            RETURN loc_lSucesso
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Refresh
        ENDIF

        THIS.AtualizarTotaisGrade()
        loc_lSucesso = .T.

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita controles conforme disponibilidade de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos()
        LOCAL loc_lTemDados

        IF NOT PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        loc_lTemDados = USED("TmpFinalg") AND RECCOUNT("TmpFinalg") > 0

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
            THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.ReadOnly = !loc_lTemDados
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "btn_4c_Processar", 5)
            THIS.pgf_4c_Paginas.Page1.btn_4c_Processar.Enabled = loc_lTemDados
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "btn_4c_TotLinha", 5)
            THIS.pgf_4c_Paginas.Page1.btn_4c_TotLinha.Enabled = loc_lTemDados
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "btn_4c_Alteraqtd", 5)
            THIS.pgf_4c_Paginas.Page1.btn_4c_Alteraqtd.Enabled = loc_lTemDados
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera campos de totalizacao da Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag1

        IF NOT PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        loc_oPag1 = THIS.pgf_4c_Paginas.Page1

        IF PEMSTATUS(loc_oPag1, "txt_4c_TotQtd", 5)
            loc_oPag1.txt_4c_TotQtd.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag1, "txt_4c_TotPrdc", 5)
            loc_oPag1.txt_4c_TotPrdc.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag1, "txt_4c_TotEst", 5)
            loc_oPag1.txt_4c_TotEst.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag1, "txt_4c_TotPrz", 5)
            loc_oPag1.txt_4c_TotPrz.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPag1, "txt_4c_TotPrze", 5)
            loc_oPag1.txt_4c_TotPrze.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme pagina ativa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_nPaginaAtiva

        IF NOT PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        loc_nPaginaAtiva = THIS.pgf_4c_Paginas.ActivePage

        DO CASE
            CASE loc_nPaginaAtiva = 1
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "btn_4c_Processar", 5)
                    THIS.pgf_4c_Paginas.Page1.btn_4c_Processar.Visible = .T.
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "btn_4c_Cancelar", 5)
                    THIS.pgf_4c_Paginas.Page1.btn_4c_Cancelar.Visible = .T.
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "btn_4c_TotLinha", 5)
                    THIS.pgf_4c_Paginas.Page1.btn_4c_TotLinha.Visible = .T.
                ENDIF
            CASE loc_nPaginaAtiva = 2
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "btn_4c_VoltarP2", 5)
                    THIS.pgf_4c_Paginas.Page2.btn_4c_VoltarP2.Visible = .T.
                ENDIF
            CASE loc_nPaginaAtiva = 3
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page3, "btn_4c_VoltarP3", 5)
                    THIS.pgf_4c_Paginas.Page3.btn_4c_VoltarP3.Visible = .T.
                ENDIF
            CASE loc_nPaginaAtiva = 4
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "btn_4c_VoltarP4", 5)
                    THIS.pgf_4c_Paginas.Page4.btn_4c_VoltarP4.Visible = .T.
                ENDIF
            CASE loc_nPaginaAtiva = 5
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page5, "btn_4c_VoltarP5", 5)
                    THIS.pgf_4c_Paginas.Page5.btn_4c_VoltarP5.Visible = .T.
                ENDIF
            CASE loc_nPaginaAtiva = 6
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page6, "btn_4c_VoltarP6", 5)
                    THIS.pgf_4c_Paginas.Page6.btn_4c_VoltarP6.Visible = .T.
                ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere flags operacionais para o BO antes do Processar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oBusinessObject
            .this_lReserva    = THIS.this_lReserva
            .this_nEmphPdr    = THIS.this_nEmphPdr
            .this_lAutomatico = THIS.this_lAutomatico
            .this_nNumeroOp   = THIS.this_nNumeroOp
            .this_lPorDestino = THIS.this_lPorDestino
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza exibicao apos processamento do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF USED("TmpFinalg") AND RECCOUNT("TmpFinalg") > 0
            THIS.AtualizarTotaisGrade()
        ENDIF
    ENDPROC

ENDDEFINE
