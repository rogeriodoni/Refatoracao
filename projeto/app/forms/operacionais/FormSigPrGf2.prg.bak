*==============================================================================
* FormSigPrGf2.prg - Gr??fico de Falha X Recupera????o Mensal
* Tipo: OPERACIONAL - Visualiza????o de gr??fico OLE (MSGraph)
* Fase 8/8 - COMPLETO
*==============================================================================

DEFINE CLASS FormSigPrGf2 AS FormBase

    *-- Propriedades do legado (CLASSINFO: poform1, pnnumgrf)
    poform1  = .NULL.
    pnnumgrf = 0

    *-- Propriedades do novo sistema
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "OPERACIONAL"

    *-- Configura????es visuais (classe-level - iguais ao legado PILAR 1)
    Width       = 800
    Height      = 600
    AutoCenter  = .T.
    TitleBar    = 0
    BorderStyle = 1
    Caption     = "\"
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 0
    DataSession = 2

    *--------------------------------------------------------------------------
    * Init - Recebe ref do form pai, compartilha datasession e inicializa
    * DataSessionId ?? compartilhado ANTES do DODEFAULT para que
    * InicializarForm acesse crRel1 (cursor populado pelo form pai)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_loForm1)
        IF VARTYPE(par_loForm1) = "O"
            THIS.poform1       = par_loForm1
            THIS.DataSessionId = par_loForm1.DataSessionId
        ELSE
            THIS.poform1 = THIS
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura form, cria containers e prepara exibi????o
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGf2BO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Propriedades visuais do form
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- Inicializar cursor de cache do gr??fico (via BO)
                THIS.this_oBusinessObject.InicializarCursorGrafico()

                *-- Criar containers do layout
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Sincronizar caption do cabecalho com o form
                LOCAL loc_cTitulo
                loc_cTitulo = "Gr" + CHR(225) + "fico de Falha X Recupera" + ;
                              CHR(231) + CHR(227) + "o Mensal"
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo

                *-- Estado inicial: aguarde visivel, grafico oculto
                THIS.AlternarPagina("AGUARDE")

                *-- Exibir form com aguarde enquanto carrega o grafico
                THIS.Refresh()
                THIS.Show()

                *-- Gerar grafico inicial (popula combo + gera chart para item 1)
                THIS.LockScreen = .T.
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
                THIS.GerarGrafico(1)

                *-- Transicionar para estado de exibicao do grafico
                THIS.AlternarPagina("GRAFICO")
                IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
                    THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 1
                ENDIF
                THIS.LockScreen = .F.

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrGf2BO. " + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro InicializarForm")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria containers e controles do form
    * Form OPERACIONAL sem PageFrame: nome mantido por convencao do pipeline;
    * o layout eh custom (cabecalho + grafico OLE + controles inferiores).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- === Cabe??alho cinza escuro (cntSombra do legado) ===
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- === CommandGroup: Imprimir + Encerrar (bot??es configurados na fase 4) ===
        THIS.AddObject("obj_4c_CmdgGrafico", "CommandGroup")
        WITH THIS.obj_4c_CmdgGrafico
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Top           = -3
            .Left          = 644
            .Width         = 160
            .Height        = 85
            .Visible       = .T.
        ENDWITH

        *-- === Container do gr??fico OLE (oleGrafico1 adicionado na fase 4) ===
        THIS.AddObject("cnt_4c_Grf1", "Container")
        WITH THIS.cnt_4c_Grf1
            .Top           = 120
            .Left          = 17
            .Width         = 770
            .Height        = 429
            .BackColor     = RGB(255, 255, 255)
            .BackStyle     = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- === Container de espera (vis??vel durante inicializa????o e processamento) ===
        THIS.AddObject("cnt_4c_Aguarde", "Container")
        WITH THIS.cnt_4c_Aguarde
            .Top           = 288
            .Left          = 312
            .Width         = 207
            .Height        = 49
            .BackColor     = RGB(255, 255, 255)
            .BackStyle     = 1
            .BorderWidth   = 5
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top       = 7
                .Left      = 69
                .Width     = 78
                .Height    = 18
                .FontName  = "Verdana"
                .FontSize  = 10
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 0, 0)
                .Caption   = "Aguarde..."
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top       = 24
                .Left      = 34
                .Width     = 159
                .Height    = 18
                .FontName  = "Verdana"
                .FontSize  = 10
                .FontBold  = .T.
                .BackStyle = 0
                .Caption   = "Processando Dados..."
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- === Container inferior: Label + ComboBox (conte??do adicionado na fase 5) ===
        THIS.AddObject("cnt_4c_Grf2", "Container")
        WITH THIS.cnt_4c_Grf2
            .Top           = 558
            .Left          = 559
            .Width         = 228
            .Height        = 35
            .BackColor     = RGB(255, 255, 255)
            .BackStyle     = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            *-- Limpar cursor de cache do gr??fico
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparCursorGrafico()
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            *-- Reabilitar form pai (form era modeless e desabilitava o pai)
            IF VARTYPE(THIS.poform1) = "O" AND THIS.poform1 != THIS
                THIS.poform1.LockScreen = .T.
                THIS.poform1.Enabled   = .T.
                THIS.poform1.LockScreen = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Destroy FormSigPrGf2")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona OLE e configura botoes do CommandGroup
    * OLEBoundControl criado lazy em GerarGrafico() para evitar dialog COM
    * "Insert Object" no init sem dados (SYS(2335) nao intercepta dialogs OS)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Botao 1: Grafico (geral_grafico_pizza_60.jpg - icone do legado)
        WITH THIS.obj_4c_CmdgGrafico
            WITH .Buttons(1)
                .Caption         = "Gr" + CHR(225) + "fico"
                .Left            = 5
                .Top             = 5
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
                .WordWrap        = .T.
                .MousePointer    = 15
            ENDWITH
            WITH .Buttons(2)
                .Caption         = "Encerrar"
                .Left            = 80
                .Top             = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .WordWrap        = .T.
                .MousePointer    = 15
            ENDWITH
        ENDWITH

        *-- BINDEVENT: CommandGroup Click -> CmdGraficoClick (PUBLIC)
        BINDEVENT(THIS.obj_4c_CmdgGrafico, "Click", THIS, "CmdGraficoClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Popula cnt_4c_Grf2 com Label e ComboBox
    * (cntGrf2.lblChave1 + cntGrf2.cmbChave1 do legado)
    * Items do combo sao populados em GerarGrafico() na primeira chamada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oGrf2
        loc_oGrf2 = THIS.cnt_4c_Grf2

        *-- Label "Grupo / Vendedor :" (lblChave1 do legado)
        loc_oGrf2.AddObject("lbl_4c_LblChave1", "Label")
        WITH loc_oGrf2.lbl_4c_LblChave1
            .Top       = 9
            .Left      = 7
            .Width     = 94
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo / Vendedor :"
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- ComboBox de selecao de grupo/vendedor (cmbChave1 do legado)
        *-- Items populados em GerarGrafico() ao inicializar
        loc_oGrf2.AddObject("cbo_4c_CmbChave1", "ComboBox")
        WITH loc_oGrf2.cbo_4c_CmbChave1
            .Top               = 4
            .Left              = 129
            .Width             = 86
            .Height            = 25
            .FontName          = "Courier New"
            .FontSize          = 9
            .ColumnCount       = 1
            .ColumnLines       = .F.
            .IncrementalSearch = .T.
            .Style             = 2
            .ReadOnly          = .T.
            .Format            = "K"
            .Sorted            = .F.
            .SpecialEffect     = 0
            .Alignment         = 0
            .Visible           = .T.
        ENDWITH

        *-- BINDEVENTs: Click e GotFocus no ComboBox (PUBLIC handlers exigidos)
        BINDEVENT(loc_oGrf2.cbo_4c_CmbChave1, "Click",    THIS, "CboChave1Click")
        BINDEVENT(loc_oGrf2.cbo_4c_CmbChave1, "GotFocus", THIS, "CboChave1GotFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * CboChave1Click - Regera grafico para grupo/vendedor selecionado no combo
    *--------------------------------------------------------------------------
    PROCEDURE CboChave1Click()
        LOCAL loc_oErro

        TRY
            THIS.cnt_4c_Aguarde.Visible = .T.
            THIS.Refresh()
            THIS.LockScreen = .T.
            THIS.SetAll("Enabled", .F., "OLEBoundControl")

            THIS.GerarGrafico(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)

            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
            THIS.cnt_4c_Aguarde.Visible = .F.
            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro CboChave1Click")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CboChave1GotFocus - Desabilita controles OLE quando combo recebe foco
    *--------------------------------------------------------------------------
    PROCEDURE CboChave1GotFocus()
        THIS.SetAll("Enabled", .F., "OLEBoundControl")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre estado de espera e exibicao do grafico
    * par_cEstado: "AGUARDE" ou "GRAFICO"
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_cEstado)
        LOCAL loc_cEstado
        loc_cEstado = UPPER(ALLTRIM(IIF(VARTYPE(par_cEstado) = "C", par_cEstado, "AGUARDE")))

        DO CASE
        CASE loc_cEstado = "AGUARDE"
            THIS.cnt_4c_Aguarde.Visible     = .T.
            THIS.cnt_4c_Grf1.Visible        = .F.
            THIS.cnt_4c_Grf2.Visible        = .F.
            THIS.obj_4c_CmdgGrafico.Visible = .F.
        CASE loc_cEstado = "GRAFICO"
            THIS.cnt_4c_Aguarde.Visible     = .F.
            THIS.cnt_4c_Grf1.Visible        = .T.
            THIS.cnt_4c_Grf2.Visible        = .T.
            THIS.obj_4c_CmdgGrafico.Visible = .T.
        ENDCASE

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdGraficoClick - Handler do CommandGroup (despachante por .Value)
    *--------------------------------------------------------------------------
    PROCEDURE CmdGraficoClick()
        DO CASE
        CASE THIS.obj_4c_CmdgGrafico.Value = 1
            THIS.BtnGraficoClick()
        CASE THIS.obj_4c_CmdgGrafico.Value = 2
            THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGraficoClick - Imprime grafico atual na impressora via SigPrGf1.frx
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnGraficoClick()
        LOCAL loc_oErro, loc_cRelatorio, loc_nRecno
        LOCAL loc_cPoint, loc_cSep

        TRY
            THIS.LockScreen = .T.

            loc_cRelatorio = FULLPATH(gc_4c_CaminhoReports + "SigPrGf1.frx")

            IF NOT FILE(loc_cRelatorio)
                MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                        CHR(13) + loc_cRelatorio, ;
                        "Gr" + CHR(225) + "fico")
            ELSE
                IF USED("crGrafico1") AND RECCOUNT("crGrafico1") > 0
                    loc_nRecno = RECNO("crGrafico1")
                    loc_cPoint = SET("POINT")
                    loc_cSep   = SET("SEPARATOR")

                    SET POINT TO "."
                    SET SEPARATOR TO ","
                    SET REPORTBEHAVIOR 80

                    SELECT crGrafico1
                    REPORT FORM (FULLPATH(gc_4c_CaminhoReports + "SigPrGf1")) ;
                        NEXT 1 TO PRINTER PROMPT NOCONSOLE

                    SET POINT TO (loc_cPoint)
                    SET SEPARATOR TO (loc_cSep)
                    SET REPORTBEHAVIOR 90

                    IF BETWEEN(loc_nRecno, 1, RECCOUNT("crGrafico1"))
                        GOTO loc_nRecno IN crGrafico1
                    ENDIF

                    THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
                ELSE
                    MsgAviso("Nenhum gr" + CHR(225) + "fico dispon" + CHR(237) + ;
                             "vel para impress" + CHR(227) + "o.", ;
                             "Impress" + CHR(227) + "o")
                ENDIF
            ENDIF

            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnGraficoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Limpa OLE, fecha cursor de cache e libera o form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro

        TRY
            THIS.LockScreen = .T.

            IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
                THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
            ENDIF

            IF USED("crGrafico1")
                USE IN crGrafico1
            ENDIF

            THIS.Release()

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarGrafico - Gera/exibe grafico OLE para o grupo/vendedor selecionado
    *   par_nLinha - Indice 1-based no ComboBox (0 ou omitido = usar primeiro)
    *   Equivale ao mgeragrafico do legado: popula combo na 1a chamada,
    *   gera dados via BO, configura objeto MSGraph.Chart no OLE Bound Control.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarGrafico(par_nLinha)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nLinha, loc_cChave1
        LOCAL loc_nCount, loc_nTmStr
        LOCAL loc_lCacheMiss
        LOCAL loc_cPoint, loc_cSep
        LOCAL loc_i, loc_nGrupo, loc_nMes
        LOCAL loc_oOle
        LOCAL ARRAY loc_aChaves(1)

        loc_lSucesso  = .F.
        loc_lCacheMiss = .F.

        *-- Salvar locale antes de qualquer RETURN/CATCH
        loc_cPoint = SET("POINT")
        loc_cSep   = SET("SEPARATOR")
        SET POINT TO ","
        SET SEPARATOR TO "."

        TRY
            loc_nLinha = IIF(VARTYPE(par_nLinha) = "N" .AND. par_nLinha > 0, par_nLinha, 1)

            *-- === 1. Populacao inicial do ComboBox (apenas na primeira chamada) ===
            IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount = 0
                DIMENSION loc_aChaves(1)
                loc_nCount = THIS.this_oBusinessObject.ObterChavesGrafico(@loc_aChaves)

                IF loc_nCount > 0
                    loc_nTmStr = LEN(ALLTRIM(loc_aChaves(1)))

                    WITH THIS.cnt_4c_Grf2.cbo_4c_CmbChave1
                        .Clear()
                        .RowSourceType = 0
                        .RowSource     = ""
                        .Width         = (loc_nTmStr * 7 + 9) + 20
                        .Height        = 25
                        .Top           = 5
                        .Left          = 5 + THIS.cnt_4c_Grf2.lbl_4c_LblChave1.Width
                        FOR loc_i = 1 TO loc_nCount
                            .AddItem(PADR(loc_aChaves(loc_i), loc_nTmStr))
                        ENDFOR
                    ENDWITH

                    WITH THIS.cnt_4c_Grf2
                        .Height = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Height + 10
                        .Width  = THIS.cnt_4c_Grf2.lbl_4c_LblChave1.Width + ;
                                  THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Width + 10
                        .Visible     = .T.
                    ENDWITH
                ENDIF
            ENDIF

            *-- === 2. Gerar grafico se ha itens no combo ===
            IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
                *-- Obter chave selecionada do combo
                loc_cChave1 = ALLTRIM(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(loc_nLinha))

                *-- Montar array de 1 elemento para passar ao BO
                DIMENSION loc_aChaves(1)
                loc_aChaves(1) = loc_cChave1

                *-- Verificar cache ANTES de chamar BO (para saber se precisa configurar OLE)
                IF USED("crGrafico1")
                    SELECT crGrafico1
                    LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave1, 100)
                    loc_lCacheMiss = EOF("crGrafico1")
                ELSE
                    loc_lCacheMiss = .T.
                ENDIF

                *-- BO: cache miss -> INSERT + APPEND GENERAL; cache hit -> apenas posiciona
                IF THIS.this_oBusinessObject.CarregarDadosGrafico(1, @loc_aChaves)
                    *-- Criacao lazy: evita dialog COM "Insert Object" no init sem dados
                    IF !PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
                        THIS.cnt_4c_Grf1.AddObject("obj_4c_OleGrafico1", "OLEBoundControl")
                        WITH THIS.cnt_4c_Grf1.obj_4c_OleGrafico1
                            .Top     = 19
                            .Left    = 5
                            .Height  = 390
                            .Width   = 760
                            .Visible = .T.
                        ENDWITH
                    ENDIF
                    loc_oOle = THIS.cnt_4c_Grf1.obj_4c_OleGrafico1

                    IF loc_lCacheMiss
                        *-- Cache miss: configurar propriedades do grafico OLE
                        TRY
                            WITH loc_oOle
                                .ControlSource   = "crGrafico1.gGrafico1s"
                                .AutoActivate    = 0
                                .AutoSize        = .T.
                                .Sizable         = .T.
                                .Stretch         = 2
                                .HasLegend       = .T.
                                .HasTitle        = .T.
                                .DisplayBlanksAs = 1
                                .HasAxis(2)      = .T.
                                .Type            = -4100
                                .SubType         = 1

                                WITH .ChartArea
                                    .Font.Name        = "Arial"
                                    .Font.Size        = 8
                                    .Font.Bold        = .T.
                                    .Font.Italic      = .F.
                                    .Interior.Color   = RGB(255, 255, 255)
                                    .Border.Color     = RGB(0, 0, 0)
                                    .Border.LineStyle = 1
                                    .Border.Weight    = 2
                                    .Shadow           = .T.
                                ENDWITH

                                WITH .PlotArea
                                    .Interior.Color = RGB(255, 255, 255)
                                    .Border.Color   = RGB(0, 0, 0)
                                ENDWITH

                                WITH .ChartTitle
                                    .Font.Name   = "Arial"
                                    .Font.Size   = 9
                                    .Font.Bold   = .T.
                                    .Font.Italic = .F.
                                    .Text        = THIS.this_oBusinessObject.this_cTitulo1
                                ENDWITH

                                WITH .Legend
                                    .Font.Name   = "Arial"
                                    .Font.Size   = 8
                                    .Font.Bold   = .T.
                                    .Font.Italic = .F.
                                    .Position    = 1
                                    .Shadow      = .T.
                                ENDWITH

                                WITH .Axes(1)
                                    .HasTitle               = .T.
                                    .AxisTitle.Caption      = "Meses"
                                    .AxisTitle.Font.Name    = "Arial"
                                    .AxisTitle.Font.Size    = 8
                                    .AxisTitle.Font.Bold    = .T.
                                    .AxisTitle.Font.Italic  = .F.
                                    .AxisTitle.Orientation  = 0
                                    .ReversePlotOrder       = .F.
                                    .TickLabels.Orientation = 0
                                    WITH .TickLabels.Font
                                        .Name          = "Small Fonts"
                                        .Bold          = .F.
                                        .Size          = 7
                                        .Strikethrough = .F.
                                        .Superscript   = .F.
                                        .Subscript     = .F.
                                        .OutlineFont   = .F.
                                        .Shadow        = .F.
                                    ENDWITH
                                ENDWITH

                                WITH .Axes(2)
                                    .HasTitle               = .F.
                                    .ReversePlotOrder       = .F.
                                    .HasMajorGridLines      = .T.
                                    .HasMinorGridlines      = .F.
                                    .MinimumScaleIsAuto     = .T.
                                    .MaximumScaleIsAuto     = .T.
                                    .TickLabels.Orientation  = 0
                                    .TickLabels.NumberFormat = "###,###,##0.00"
                                    WITH .TickLabels.Font
                                        .Name          = "Arial"
                                        .Bold          = .T.
                                        .Size          = 8
                                        .Strikethrough = .F.
                                        .Superscript   = .F.
                                        .Subscript     = .F.
                                        .OutlineFont   = .F.
                                        .Shadow        = .F.
                                    ENDWITH
                                ENDWITH

                                WITH .ChartGroups(1)
                                    .HasSeriesLines = .F.
                                    .GapWidth       = 10
                                    .Overlap        = (.GapWidth / 2 * -1)

                                    FOR loc_nGrupo = 1 TO THIS.this_oBusinessObject.this_nNgrupos
                                        IF TYPE("THIS.cnt_4c_Grf1.obj_4c_OleGrafico1" + ;
                                                ".ChartGroups(1).SeriesCollection(" + ;
                                                TRANSFORM(loc_nGrupo) + ")") = "O"
                                            WITH .SeriesCollection(loc_nGrupo)
                                                .ApplyDataLabels      = .T.
                                                .ApplyDataLabels.Type = 2
                                                FOR loc_nMes = 1 TO THIS.this_oBusinessObject.this_nNmeses
                                                    IF TYPE("THIS.cnt_4c_Grf1.obj_4c_OleGrafico1" + ;
                                                            ".ChartGroups(1).SeriesCollection(" + ;
                                                            TRANSFORM(loc_nGrupo) + ").Points(" + ;
                                                            TRANSFORM(loc_nMes) + ").DataLabel") = "O"
                                                        WITH .PointsDataLabel
                                                            .Top          = (.Top - 10)
                                                            .NumberFormat = "###,###,##0.00"
                                                            .Font.Name    = "Arial"
                                                            .Font.Size    = 8
                                                            .Font.Bold    = .T.
                                                            .Font.Shadow  = .F.
                                                        ENDWITH
                                                    ENDIF
                                                ENDFOR
                                            ENDWITH
                                        ENDIF
                                    ENDFOR
                                ENDWITH

                                .Refresh()
                            ENDWITH
                        CATCH TO loc_oErro
                            *-- Erros OLE nao sao fatais; grafico pode exibir parcialmente
                        ENDTRY
                    ELSE
                        *-- Cache hit: cursor ja posicionado, reforcar ControlSource e refresh
                        TRY
                            loc_oOle.ControlSource = "crGrafico1.gGrafico1s"
                            loc_oOle.Refresh()
                        CATCH TO loc_oErro
                            *-- Erros OLE nao sao fatais
                        ENDTRY
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro GerarGrafico")
        ENDTRY

        SET POINT TO (loc_cPoint)
        SET SEPARATOR TO (loc_cSep)

        THIS.Refresh()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Reseta a selecao do combo para o primeiro item e
    * regenera o grafico. Em SigPrGf2 (form OPERACIONAL de visualizacao de
    * grafico MSGraph) nao ha INSERT persistente ??? "Incluir" corresponde a
    * "nova consulta/processamento" do grafico com a chave inicial.
    * Existe para atender ao contrato da pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            THIS.cnt_4c_Aguarde.Visible = .T.
            THIS.Refresh()
            THIS.LockScreen = .T.
            THIS.SetAll("Enabled", .F., "OLEBoundControl")

            *-- Regenera o grafico a partir do primeiro item do combo
            THIS.GerarGrafico(1)

            IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 1
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
            ENDIF

            THIS.cnt_4c_Aguarde.Visible = .F.
            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Habilita edicao interativa da chave: garante que o
    * ComboBox esteja habilitado e devolve foco ao combo para permitir troca
    * do grupo/vendedor. Nao ha UPDATE persistente em SigPrGf2 (form
    * OPERACIONAL sem entidade CRUD). Existe para atender ao contrato da
    * pipeline e como atalho equivalente a "editar selecao".
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled  = .T.
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ReadOnly = .F.

                IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
                    THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
                ENDIF
            ENDIF

            THIS.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Executa a regeracao/exibicao do grafico para a
    * chave atualmente selecionada no combo. Em forms OPERACIONAIS de
    * consulta/relatorio, "Visualizar" corresponde a executar a consulta e
    * exibir o resultado ??? delegamos para CboChave1Click para reaproveitar
    * o indicador cnt_4c_Aguarde, a chamada a GerarGrafico e o tratamento
    * de erros.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.CboChave1Click()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Limpa o cache do grafico e reseta o OLE Bound Control:
    * apaga registros do cursor crGrafico1, desvincula a ControlSource do OLE
    * e sinaliza o container de espera. Nao existe DELETE em SigPrGf2 (form
    * OPERACIONAL sem entidade persistida) ??? este evento existe para atender
    * ao contrato da pipeline e como atalho equivalente a "limpar consulta".
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro

        TRY
            THIS.LockScreen = .T.

            *-- Desvincula o OLE Bound Control (para o grafico deixar de refletir cache)
            IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
                TRY
                    THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
                CATCH TO loc_oErro
                    *-- Erros OLE nao sao fatais aqui
                ENDTRY
            ENDIF

            *-- Limpa cache do BO (ZAP em crGrafico1)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparCursorGrafico()
                THIS.this_oBusinessObject.InicializarCursorGrafico()
            ENDIF

            *-- Estado de espera: grafico oculto, combo mantido para reselecao
            THIS.cnt_4c_Grf1.Visible    = .F.
            THIS.cnt_4c_Aguarde.Visible = .T.

            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Regenera grafico OLE para o item atualmente selecionado
    * no ComboBox. Em form OPERACIONAL de visualizacao de grafico, nao ha lista
    * de registros para carregar ??? "CarregarLista" equivale a "regenerar grafico".
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_nIdx
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
                loc_nIdx = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
                IF loc_nIdx < 1
                    loc_nIdx = 1
                ENDIF
                loc_lSucesso = THIS.GerarGrafico(loc_nIdx)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia o estado atual do form (selecao do combo) para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_nIdx, loc_cChave

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cChave = ""

        IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
           PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
            loc_nIdx = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
            IF loc_nIdx > 0
                loc_cChave = ALLTRIM(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(loc_nIdx))
            ENDIF
        ENDIF

        THIS.this_oBusinessObject.this_cChave1 = loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza o form a partir do estado do BO
    * Sincroniza titulo do cabecalho com this_cCaption do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF !EMPTY(THIS.this_oBusinessObject.this_cCaption)
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.this_oBusinessObject.this_cCaption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.this_oBusinessObject.this_cCaption
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles do form
    * par_lHabilitar: .T. = habilitar, .F. = desabilitar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
           PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled  = loc_lHabilitar
            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ReadOnly = !loc_lHabilitar
        ENDIF

        IF VARTYPE(THIS.obj_4c_CmdgGrafico) = "O"
            THIS.obj_4c_CmdgGrafico.Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta combo, limpa cache do grafico e volta ao estado
    * de espera (cnt_4c_Aguarde). Equivalente a "limpar consulta".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            *-- Desvincula o OLE antes de zerar cursor (evita acesso a dados liberados)
            IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
                TRY
                    THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
                CATCH
                ENDTRY
            ENDIF

            *-- Limpa e recria cursor de cache via BO
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparCursorGrafico()
                THIS.this_oBusinessObject.InicializarCursorGrafico()
            ENDIF

            *-- Resetar combo
            IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
            ENDIF

            *-- Exibir estado de espera
            THIS.AlternarPagina("AGUARDE")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta visibilidade do CommandGroup conforme estado
    * Form OPERACIONAL sem modo CRUD: apenas garante que o CmdGroup esta visivel
    * quando o grafico foi gerado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemGrafico
        loc_lTemGrafico = USED("crGrafico1") AND RECCOUNT("crGrafico1") > 0

        IF VARTYPE(THIS.obj_4c_CmdgGrafico) = "O"
            THIS.obj_4c_CmdgGrafico.Visible = loc_lTemGrafico
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Dispara geracao/atualizacao do grafico para a selecao
    * atual do ComboBox. Em form OPERACIONAL de grafico, "Buscar" equivale a
    * "visualizar grafico para chave selecionada".
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CboChave1Click()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Form OPERACIONAL sem persistencia em banco de dados.
    * Dados sao gerados dinamicamente a partir do cursor crRel1 do form pai
    * e mantidos em memoria (crGrafico1). Nao ha operacao de salvamento.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro, loc_nIdx
        loc_nIdx = 1

        TRY
            IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
                loc_nIdx = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
                IF loc_nIdx < 1
                    loc_nIdx = 1
                ENDIF
            ENDIF

            THIS.GerarGrafico(loc_nIdx)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Encerra o form (equivalente a Encerrar para este
    * form OPERACIONAL que nao tem estado editavel a cancelar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Percorre Controls e sub-containers. Estado de exibicao dos containers
    * principais (cnt_4c_Grf1/Grf2/CmdgGrafico) e gerenciado por AlternarPagina,
    * portanto este metodo e chamado antes da primeira chamada a AlternarPagina.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE
