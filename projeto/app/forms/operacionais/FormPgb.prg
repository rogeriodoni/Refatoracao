*==============================================================================
* FormPgb.prg - Historico dos Barras (OPERACIONAL, somente leitura)
* Form modal popup aberto por outro form com parametros de consulta.
* Chamada: CREATEOBJECT("FormPgb", cEmps, cDopes, nNumes)
* Herda de: FormBase
*
* Historico de fases:
*   Fase 1/2: PgbBO.prg (propriedades + CarregarHistorico via SP SigPrCtb)
*   Fase 3:   FormPgb.prg - estrutura base (Init, InicializarForm, ConfigurarLayout)
*             Cabecalho, Encerrar, Shape1, txt_4c_Texto, Shape2
*   Fase 4:   Grid grd_4c_Dados (7 colunas) + AfterRowColChange + CarregarDados bind
*   Fase 5/6: Form OPERACIONAL read-only sem Page2 nem campos de entrada.
*             Completado com propriedades visuais do grid (HighlightColors, ForeColor/
*             BackColor por coluna) equivalentes ao fCarregaGrade do legado.
*==============================================================================
DEFINE CLASS FormPgb AS FormBase

    *-- Parametros de entrada recebidos no Init
    this_cEmps  = ""
    this_cDopes = ""
    this_nNumes = 0

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SIGCDPGB)
    Width        = 650
    Height       = 450
    AutoCenter   = .T.
    TitleBar     = 0
    WindowType   = 1
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Init - Armazena parametros, cria BO e dispara FormBase.Init
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cEmps  = IIF(VARTYPE(par_cEmps)  = "C", ALLTRIM(par_cEmps),  "")
            THIS.this_cDopes = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")
            THIS.this_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes,           0)

            THIS.this_oBusinessObject = CREATEOBJECT("PgbBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar PgbBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormPgb.Init")
            ELSE
                *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormPgb.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta estrutura visual e carrega dados
    * (chamado automaticamente por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo do form (imagem do Framework Fortyus legado)
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Caption via CHR() (proibido literal acentuado em .PRG)
            THIS.Caption = "Hist" + CHR(243) + "rico dos barras"

            *-- Cursor placeholder identico ao populado por CarregarHistorico
            *-- Precisa existir antes de ConfigurarLayout (ControlSource do txt_4c_Texto)
            SET NULL ON
            IF USED("cursor_4c_HistoricoPgb")
                USE IN cursor_4c_HistoricoPgb
            ENDIF
            CREATE CURSOR cursor_4c_HistoricoPgb ;
                (Datas    D     NULL, ;
                 Etiqs    C(30) NULL, ;
                 Ccustos  C(20) NULL, ;
                 Ccusto2s C(20) NULL, ;
                 Tpoperas C(40) NULL, ;
                 Tplancs  C(10) NULL, ;
                 Dtbases  D     NULL, ;
                 Dpros    C(60) NULL)
            SET NULL OFF

            *-- Monta controles visuais (sem grid - Fase 4 adiciona grd_4c_Dados)
            *-- Nome ConfigurarPageFrame mantido por convencao do orquestrador,
            *-- mas este form OPERACIONAL nao usa PageFrame (layout customizado).
            THIS.ConfigurarPageFrame()

            *-- Propaga titulo para labels do cabecalho
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Carrega dados via SP SigPrCtb (sem conexao em modo teste)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.CarregarDados()
            ENDIF

            *-- Torna arvore de controles visivel (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormPgb.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria controles visuais do form (sem grid - Fase 4)
    *   Form OPERACIONAL sem PageFrame real (layout customizado do original).
    *   Nome mantido por convencao do orquestrador de migracao.
    *   cnt_4c_Cabecalho: cabecalho escuro com shadow + titulo branco
    *   shp_4c_Shape2:    separador decorativo no canto superior direito
    *   cmd_4c_Encerrar:  botao Encerrar (Cancel=.T. vincula ao ESC)
    *   shp_4c_Shape1:    borda do rodape (Shape1 original)
    *   txt_4c_Texto:     rodape exibindo campo Dpros do registro corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oCab, loc_oErro
        TRY
            *-- Cabecalho escuro (cntSombra original: Top=0 Left=0 W=800 H=80)
            THIS.AddObject("cnt_4c_Cabecalho", "Container")
            loc_oCab = THIS.cnt_4c_Cabecalho
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
            ENDWITH

            *-- Labels dentro do cabecalho (adicionar FORA do WITH para evitar bug
            *-- de WITH aninhado com AddObject que ignora props silenciosamente)
            loc_oCab.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCab.lbl_4c_Sombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = ""
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = 769
                .ForeColor = RGB(0, 0, 0)
            ENDWITH

            loc_oCab.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCab.lbl_4c_Titulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = ""
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = 769
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            ENDWITH

            *-- Shape2 decorativo (Top=7, Left=546, H=53, W=18)
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top         = 7
                .Left        = 546
                .Height      = 53
                .Width       = 18
                .BackStyle   = 0
                .BorderStyle = 0
            ENDWITH

            *-- Botao Encerrar (Sa?da original: Top=3, Left=575, W=75, H=75)
            *-- Form 650px - botao diretamente no form (sem cnt_4c_Saida container)
            THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH THIS.cmd_4c_Encerrar
                .Top        = 3
                .Left       = 575
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")

            *-- Shape1 borda do rodape (Top=403, Left=81, H=29, W=406)
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 403
                .Left        = 81
                .Height      = 29
                .Width       = 406
                .BackStyle   = 0
                .BorderStyle = 1
            ENDWITH

            *-- Text1 rodape - exibe descricao (Dpros) do registro corrente do grid
            *-- ControlSource aponta para cursor placeholder criado em InicializarForm
            THIS.AddObject("txt_4c_Texto", "TextBox")
            WITH THIS.txt_4c_Texto
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "cursor_4c_HistoricoPgb.Dpros"
                .Height        = 25
                .Left          = 80
                .Top           = 405
                .Width         = 400
                .ReadOnly      = .T.
                .BorderStyle   = 0
            ENDWITH

            THIS.ConfigurarPaginaLista()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormPgb.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria grd_4c_Dados com 7 colunas do historico
    *   Layout exato do SCX original (Top=107, Left=80, Width=490, Height=292)
    *   RecordSource/ControlSources sao rebindados em CarregarDados pois o BO
    *   fecha e recria o cursor em CarregarHistorico (USE IN + CREATE CURSOR).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oGrd, loc_oErro
        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            loc_oGrd = THIS.grd_4c_Dados
            WITH loc_oGrd
                .Top                 = 107
                .Left                = 80
                .Height              = 292
                .Width               = 490
                .ColumnCount         = 7
                .FontName            = "Tahoma"
                .FontSize            = 8
                .AllowHeaderSizing   = .F.
                .AllowRowSizing      = .F.
                .DeleteMark          = .F.
                .RecordMark          = .F.
                .ReadOnly            = .T.
                .RowHeight           = 17
                .ScrollBars          = 2
                .GridLineColor       = RGB(238, 238, 238)
                .HighlightBackColor  = RGB(255, 255, 255)
                .HighlightForeColor  = RGB(15, 41, 104)
                .HighlightStyle      = 2
                .RecordSource        = "cursor_4c_HistoricoPgb"
            ENDWITH

            *-- Column1: Data
            WITH loc_oGrd.Column1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Width         = 66
                .Movable       = .F.
                .Resizable     = .T.
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .ControlSource = "cursor_4c_HistoricoPgb.Datas"
            ENDWITH
            loc_oGrd.Column1.Header1.Caption   = "Data"
            loc_oGrd.Column1.Header1.Alignment = 2

            *-- Column2: Barra (Etiqs)
            WITH loc_oGrd.Column2
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Width         = 66
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .ControlSource = "cursor_4c_HistoricoPgb.Etiqs"
            ENDWITH
            loc_oGrd.Column2.Header1.Caption   = "Barra"
            loc_oGrd.Column2.Header1.Alignment = 2

            *-- Column3: C.Custo (Ccustos)
            WITH loc_oGrd.Column3
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Width         = 73
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .ControlSource = "cursor_4c_HistoricoPgb.Ccustos"
            ENDWITH
            loc_oGrd.Column3.Header1.Caption   = "C.Custo"
            loc_oGrd.Column3.Header1.Alignment = 2

            *-- Column4: C.Custo2 (Ccusto2s)
            WITH loc_oGrd.Column4
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Width         = 73
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .ControlSource = "cursor_4c_HistoricoPgb.Ccusto2s"
            ENDWITH
            loc_oGrd.Column4.Header1.Caption   = "C.Custo2"
            loc_oGrd.Column4.Header1.Alignment = 2

            *-- Column5: Ocorrencia (Tpoperas) - CHR(234) = e-circunflexo
            WITH loc_oGrd.Column5
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Width         = 80
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .ControlSource = "cursor_4c_HistoricoPgb.Tpoperas"
            ENDWITH
            loc_oGrd.Column5.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
            loc_oGrd.Column5.Header1.Alignment = 2

            *-- Column6: Oper (Tplancs - plano de contas/lancamento)
            WITH loc_oGrd.Column6
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Alignment     = 3
                .Width         = 30
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .ControlSource = "cursor_4c_HistoricoPgb.Tplancs"
            ENDWITH
            loc_oGrd.Column6.Header1.Caption   = "Oper"
            loc_oGrd.Column6.Header1.Alignment = 2

            *-- Column7: Dt.Base (Dtbases)
            WITH loc_oGrd.Column7
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Width         = 66
                .ReadOnly      = .T.
                .ForeColor     = RGB(0, 0, 0)
                .BackColor     = RGB(255, 255, 255)
                .ControlSource = "cursor_4c_HistoricoPgb.Dtbases"
            ENDWITH
            loc_oGrd.Column7.Header1.Caption   = "Dt.Base"
            loc_oGrd.Column7.Header1.Alignment = 2

            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormPgb.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Executa SP SigPrCtb via BO e posiciona no ultimo registro
    *   O cursor cursor_4c_HistoricoPgb e populado pelo BO; o grid e rebindado
    *   aqui porque o BO fecha e recria o cursor (USE IN + CREATE CURSOR).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados()
        LOCAL loc_lOk, loc_oErro
        loc_lOk = .F.

        TRY
            loc_lOk = THIS.this_oBusinessObject.CarregarHistorico( ;
                THIS.this_cEmps,  ;
                THIS.this_cDopes, ;
                THIS.this_nNumes)

            IF loc_lOk AND USED("cursor_4c_HistoricoPgb")
                *-- Rebind grid: BO fecha e recria cursor em CarregarHistorico
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.ColumnCount             = 7
                    THIS.grd_4c_Dados.RecordSource            = "cursor_4c_HistoricoPgb"
                    THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_HistoricoPgb.Datas"
                    THIS.grd_4c_Dados.Column2.ControlSource   = "cursor_4c_HistoricoPgb.Etiqs"
                    THIS.grd_4c_Dados.Column3.ControlSource   = "cursor_4c_HistoricoPgb.Ccustos"
                    THIS.grd_4c_Dados.Column4.ControlSource   = "cursor_4c_HistoricoPgb.Ccusto2s"
                    THIS.grd_4c_Dados.Column5.ControlSource   = "cursor_4c_HistoricoPgb.Tpoperas"
                    THIS.grd_4c_Dados.Column6.ControlSource   = "cursor_4c_HistoricoPgb.Tplancs"
                    THIS.grd_4c_Dados.Column7.ControlSource   = "cursor_4c_HistoricoPgb.Dtbases"
                    THIS.grd_4c_Dados.Column1.Header1.Caption = "Data"
                    THIS.grd_4c_Dados.Column2.Header1.Caption = "Barra"
                    THIS.grd_4c_Dados.Column3.Header1.Caption = "C.Custo"
                    THIS.grd_4c_Dados.Column4.Header1.Caption = "C.Custo2"
                    THIS.grd_4c_Dados.Column5.Header1.Caption = "Ocorr" + CHR(234) + "ncia"
                    THIS.grd_4c_Dados.Column6.Header1.Caption = "Oper"
                    THIS.grd_4c_Dados.Column7.Header1.Caption = "Dt.Base"
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_Texto", 5)
                    THIS.txt_4c_Texto.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormPgb.CarregarDados")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (AddObject cria controles com Visible=.F. por padrao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_p
                    FOR loc_p = 1 TO loc_oCtrl.PageCount
                        THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_p))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEncerrarClick - Fecha o form (ESC tambem aciona via Cancel=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - No-op deliberado
    *   Form OPERACIONAL (popup modal de historico) sem PageFrame nem paginas
    *   alternaveis: o SCX original SIGCDPGB tem apenas Grade + Sair + Text1
    *   diretamente sobre o form. Metodo existe apenas para compatibilidade
    *   com contratos comuns de forms CRUD (que alternam Lista/Dados).
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - No-op deliberado (form OPERACIONAL sem campos)
    *   O SCX original SIGCDPGB (Historico dos barras) e popup modal read-only:
    *   nao tem PageFrame, nao tem Page Dados, nao tem TextBoxes/Labels de
    *   entrada de dados. Toda a UI (cabecalho, grid, botao Encerrar, rodape)
    *   ja foi criada em ConfigurarPageFrame + ConfigurarPaginaLista (Fases 3-4).
    *   Metodo existe apenas para compatibilidade com o pipeline multi-fase
    *   (Fases 5-6 esperam ConfigurarPaginaDados em forms CRUD). Adicionar
    *   TextBoxes/Labels aqui violaria PILAR 1 (UX identica ao legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Atualiza rodape ao navegar no grid
    *   Vinculado via BINDEVENT em ConfigurarPaginaLista
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        IF PEMSTATUS(THIS, "txt_4c_Texto", 5)
            THIS.txt_4c_Texto.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - No-op deliberado (form OPERACIONAL sem CRUD)
    *   SIGCDPGB eh popup modal read-only de historico de barras.
    *   Nao tem botao Incluir nem operacao de inclusao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - No-op deliberado (form OPERACIONAL sem CRUD)
    *   SIGCDPGB eh popup modal read-only de historico de barras.
    *   Nao tem botao Alterar nem operacao de alteracao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - No-op deliberado (form OPERACIONAL sem CRUD)
    *   SIGCDPGB eh popup modal read-only de historico de barras.
    *   Nao tem botao Visualizar nem modo de consulta separado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - No-op deliberado (form OPERACIONAL sem CRUD)
    *   SIGCDPGB eh popup modal read-only de historico de barras.
    *   Nao tem botao Excluir nem operacao de exclusao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - No-op deliberado (form OPERACIONAL sem busca)
    *   SIGCDPGB recebe os parametros no Init e carrega automaticamente.
    *   Nao ha campo de busca interativo.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o form (alias canonico de CmdEncerrarClick)
    *   Padrao CRUD usa BtnEncerrarClick; form OPERACIONAL expoe ambos.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - No-op deliberado (form OPERACIONAL somente leitura)
    *   Historico de barras eh populado por SP SigPrCtb; sem edicao manual.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - No-op deliberado (form OPERACIONAL somente leitura)
    *   Nao ha operacoes de edicao que possam ser canceladas.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - No-op deliberado (form OPERACIONAL somente leitura)
    *   Nao ha campos de entrada de dados para transferir ao BO.
    *   Os parametros (Emps/Dopes/Numes) ja estao nas props this_* do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cEmps  = THIS.this_cEmps
        THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
        THIS.this_oBusinessObject.this_nNumes = THIS.this_nNumes
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza rodape com descricao do registro corrente
    *   O cursor cursor_4c_HistoricoPgb ja esta bindado ao grid e ao txt_4c_Texto
    *   via ControlSource; apenas forca refresh dos controles visuais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Texto", 5)
            THIS.txt_4c_Texto.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - No-op deliberado (form OPERACIONAL somente leitura)
    *   Todos os controles sao ReadOnly por definicao; nao ha modo de edicao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - No-op deliberado (form OPERACIONAL somente leitura)
    *   Nao ha campos de entrada de dados para limpar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega historico de barras (delega a CarregarDados)
    *   Usada quando o form precisa refrescar os dados, ex: apos mudanca de
    *   parametros externos. Na pratica SIGCDPGB carrega uma unica vez no Init.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
            THIS.CarregarDados()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - No-op deliberado (form OPERACIONAL sem modos)
    *   SIGCDPGB nao tem modos INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR.
    *   O unico controle disponivel ao usuario e o botao Encerrar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursor e restaura menu (DODEFAULT obrigatorio)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_HistoricoPgb")
            USE IN cursor_4c_HistoricoPgb
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
