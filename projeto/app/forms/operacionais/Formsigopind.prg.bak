*=============================================================================
* Formsigopind.prg - Individual de Conta Corrente
* Migrado de: SIGOPIND.SCX (Tipo: OPERACIONAL)
* Fase 7/8: Eventos principais (FormKeyPress, PagActivate, date validation)
*=============================================================================

DEFINE CLASS Formsigopind AS FormBase
	ShowWindow = 1
	WindowType = 1

    *--------------------------------------------------------------------------
    * Propriedades visuais (copiadas do original)
    *--------------------------------------------------------------------------
    Width       = 1000
    Height      = 600
    Caption     = "Individual"
    BackColor   = RGB(255, 255, 255)
    FontName    = "Tahoma"
    FontSize    = 8
    TitleBar    = 0
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.

    *--------------------------------------------------------------------------
    * Propriedade obrigatoria (nao herdada de FormBase)
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Business Object
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Propriedades operacionais (espelho do legado)
    *--------------------------------------------------------------------------
    this_cGrupoOper    = ""
    this_cCliente      = ""
    this_lMatrizes     = .F.
    this_dDataConcilia = {}
    this_cOperacao     = ""
    this_cTxtDeb       = ""
    this_cTxtCre       = ""

    *==========================================================================
    * PROCEDURE Init
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * PROCEDURE InicializarForm
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("sigopindBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigopind.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Inicializar propriedades operacionais
            THIS.this_cGrupoOper    = ""
            THIS.this_cCliente      = SPACE(10)
            THIS.this_dDataConcilia = {}
            THIS.this_cOperacao     = ""

            *-- Criar cursor placeholder para grd_saldo (mesma estrutura do SQLEXEC)
            SET NULL ON
            CREATE CURSOR cursor_4c_Saldos ;
                (Emps C(3) NULL, Grupos C(10) NULL, Contas C(10) NULL, ;
                 Moedas C(3) NULL, Saldos N(14,2) NULL, Rclis C(60) NULL, ;
                 Situas C(4) NULL, Cpfs C(20) NULL, ContaMats C(10) NULL, ;
                 Matriz C(1) NULL)
            SET NULL OFF

            *-- Carregar labels de D/C a partir de SigCdPam (parametros)
            IF gnConnHandle > 0
                LOCAL loc_cSQLPam
                loc_cSQLPam = "SELECT Drivets FROM SigCdPam"
                IF SQLEXEC(gnConnHandle, loc_cSQLPam, "cursor_4c_PamTemp") >= 1
                    IF RECCOUNT("cursor_4c_PamTemp") > 0
                        SELECT cursor_4c_PamTemp
                        GO TOP
                        THIS.this_cTxtDeb = IIF(EMPTY(SUBSTR(cursor_4c_PamTemp.Drivets, 1, 3)), ;
                                                "D", SUBSTR(cursor_4c_PamTemp.Drivets, 1, 3))
                        THIS.this_cTxtCre = IIF(EMPTY(SUBSTR(cursor_4c_PamTemp.Drivets, 5, 3)), ;
                                                "C", SUBSTR(cursor_4c_PamTemp.Drivets, 5, 3))
                    ELSE
                        THIS.this_cTxtDeb = "D"
                        THIS.this_cTxtCre = "C"
                    ENDIF
                    IF USED("cursor_4c_PamTemp")
                        USE IN cursor_4c_PamTemp
                    ENDIF
                ELSE
                    THIS.this_cTxtDeb = "D"
                    THIS.this_cTxtCre = "C"
                ENDIF
            ELSE
                THIS.this_cTxtDeb = "D"
                THIS.this_cTxtCre = "C"
            ENDIF

            *-- Construir interface
            THIS.ConfigurarPageFrame()

            *-- Propagar Caption para labels de titulo/sombra
            THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

            *-- BINDEVENT: Form-level KeyPress (atalhos globais: F2-F11, CTRL+Enter)
            BINDEVENT(THIS, "KeyPress", THIS, "FormKeyPress")

            *-- BINDEVENT: Page Activate/Click (controla estado ao navegar entre abas)
            BINDEVENT(THIS.pgf_4c_1.Page1, "Activate", THIS, "PagSaldoActivate")
            BINDEVENT(THIS.pgf_4c_1.Page1, "Click", THIS, "PagSaldoClick")
            BINDEVENT(THIS.pgf_4c_1.Page2, "Activate", THIS, "PagHistActivate")
            BINDEVENT(THIS.pgf_4c_1.Page2, "Click", THIS, "PagHistClick")

            *-- Exibir PageFrame
            THIS.pgf_4c_1.Visible    = .T.
            THIS.pgf_4c_1.ActivePage = 1

            *-- Definir datas iniciais apos criar controles
            THIS.pgf_4c_1.Page1.txt_4c_Dt_inicial.Value = DATE() - 30
            THIS.pgf_4c_1.Page1.txt_4c_Dt_final.Value   = DATE()

            *-- Carregar dados iniciais se houver conexao
            IF gnConnHandle > 0
                THIS.MontaGrade(THIS.this_cGrupoOper)
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PROCEDURE ConfigurarPageFrame
    * Cria o PageFrame com 2 paginas: Page1=SALDO, Page2=HIST
    * Top=-28 para ocultar as abas (Tabs=.F.)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_1", "PageFrame")
        loc_oPgf = THIS.pgf_4c_1

        WITH loc_oPgf
            .Top       = -28
            .Left      = 0
            .Width     = 1004
            .Height    = 635
            .PageCount = 2
            .Tabs      = .F.
        ENDWITH

        THIS.ConfigurarPaginaSaldo()
        THIS.ConfigurarPaginaHist()
        *-- Tornar todos os controles de ambas as paginas visiveis
        THIS.TornarControlesVisiveis(THIS.pgf_4c_1)
    ENDPROC

    *==========================================================================
    * PROCEDURE ConfigurarPaginaSaldo - COMPLETO
    * Page1 - Consulta de Saldos de Conta Corrente
    * Contem: cabecalho, botoes de acao, filtros, grd_saldo,
    *         cntSaldo (flutuante relatorio), cntConsulta (flutuante busca)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaSaldo()
        LOCAL loc_oPagina, loc_oCnt, loc_oGrd, loc_oOpt

        loc_oPagina = THIS.pgf_4c_1.Page1
        WITH loc_oPagina
            .Caption   = "Saldo"
            .BackColor = RGB(212, 208, 200)
        ENDWITH

        *----------------------------------------------------------------------
        * Container cabecalho - efeito sombra + titulo
        * cntSombra: top=0, left=0, width=1000, height=80
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = loc_oPagina.cnt_4c_Sombra
        WITH loc_oCnt
            .Top           = 0
            .Left          = 0
            .Width         = 1000
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .Top       = 7
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .Top       = 10
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *----------------------------------------------------------------------
        * grp_operacao - CommandGroup transparente com botao Sair
        * top=-1, left=669, width=334, height=83, buttonCount=2
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("obj_4c_Grp_operacao", "CommandGroup")
        WITH loc_oPagina.obj_4c_Grp_operacao
            .Top           = -1
            .Left          = 669
            .Width         = 334
            .Height        = 83
            .ButtonCount   = 2
            .BorderStyle   = 0
            .SpecialEffect = 0
        ENDWITH
        WITH loc_oPagina.obj_4c_Grp_operacao.Buttons(1)
            .Caption   = "\<Consultar"
            .Width     = 75
            .Height    = 75
            .Left      = 178
            .Top       = 5
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .FontBold  = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90, 90, 90)
            .Picture   = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Grp_operacao.Buttons(2)
            .Caption   = "\<Encerrar"
            .Width     = 75
            .Height    = 75
            .Left      = 253
            .Top       = 5
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .FontBold  = .T.
            .FontItalic = .T.
            .ForeColor = RGB(90, 90, 90)
            .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel    = .T.
            .Themes    = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.obj_4c_Grp_operacao, "Click", THIS, "GrpOperacaoSaldoClick")

        *----------------------------------------------------------------------
        * cmd_procurar - Botao Procurar Conta
        * top=4, left=697, width=75, height=75
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cmd_4c_Cmd_procurar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Cmd_procurar
            .Top        = 4
            .Left       = 697
            .Width      = 75
            .Height     = 75
            .Caption    = "\<Procurar"
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Cmd_procurar, "Click", THIS, "BtnProcurarSaldoClick")

        *----------------------------------------------------------------------
        * Com_Imprimir2 - Botao Imprimir Relatorio de Saldos
        * top=4, left=772, width=75, height=75
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cmd_4c_Com_Imprimir2", "CommandButton")
        WITH loc_oPagina.cmd_4c_Com_Imprimir2
            .Top        = 4
            .Left       = 772
            .Width      = 75
            .Height     = 75
            .Caption    = "\<Imprimir"
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Com_Imprimir2, "Click", THIS, "BtnImprimirSaldoClick")

        *----------------------------------------------------------------------
        * Linha de filtro de periodo
        * Label1 "Periodo:": top=86, left=9, width=51, height=15
        * Dt_inicial: top=84, left=64, width=80, height=23
        * Say2 "ate": top=88, left=147
        * Dt_final: top=84, left=173, width=80, height=23
        * optFiltro: top=82, left=253, width=206, height=26, buttonCount=3
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Top       = 86
            .Left      = 9
            .Width     = 51
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dt_inicial", "TextBox")
        WITH loc_oPagina.txt_4c_Dt_inicial
            .Top      = 84
            .Left     = 64
            .Width    = 80
            .Height   = 23
            .Value    = {}
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Top       = 88
            .Left      = 147
            .Width     = 22
            .Height    = 15
            .Caption   = "at" + CHR(233)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dt_final", "TextBox")
        WITH loc_oPagina.txt_4c_Dt_final
            .Top      = 84
            .Left     = 173
            .Width    = 80
            .Height   = 23
            .Value    = {}
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- optFiltro: 3 botoes (Todos / Positivos / Negativos)
        loc_oPagina.AddObject("obj_4c_OptFiltro", "OptionGroup")
        loc_oOpt = loc_oPagina.obj_4c_OptFiltro
        WITH loc_oOpt
            .Top         = 82
            .Left        = 253
            .Width       = 206
            .Height      = 26
            .ButtonCount = 3
            .BorderStyle = 0
            .Value       = 1
        ENDWITH
        WITH loc_oOpt.Buttons(1)
            .Caption  = "Todos"
            .Width    = 68
            .Height   = 21
            .Left     = 0
            .Top      = 3
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        WITH loc_oOpt.Buttons(2)
            .Caption  = "Positivos"
            .Width    = 68
            .Height   = 21
            .Left     = 69
            .Top      = 3
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        WITH loc_oOpt.Buttons(3)
            .Caption  = "Negativos"
            .Width    = 68
            .Height   = 21
            .Left     = 138
            .Top      = 3
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oOpt, "InteractiveChange", THIS, "OptFiltroSaldoChange")

        *-- BINDEVENTs para validacao de datas (KeyPress simula Valid)
        BINDEVENT(loc_oPagina.txt_4c_Dt_inicial, "KeyPress", THIS, "TxtDtInicialKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Dt_final, "KeyPress", THIS, "TxtDtFinalKeyPress")

        *----------------------------------------------------------------------
        * Linha de filtro de grupo
        * lbl_grupo "Grupo:": top=114, left=18, width=42, height=15
        * Get_Grupo: top=110, left=64, width=80, height=23
        * Get_DGrupo: top=110, left=146, width=318, height=23
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_grupo
            .Top       = 114
            .Left      = 18
            .Width     = 42
            .Height    = 15
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Top       = 110
            .Left      = 64
            .Width     = 80
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 10
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "TxtGrupoKeyPress")

        loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupo
            .Top       = 110
            .Left      = 146
            .Width     = 318
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 60
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DGrupo, "KeyPress", THIS, "TxtDGrupoKeyPress")

        *----------------------------------------------------------------------
        * grd_saldo - Grid de saldos de conta corrente
        * top=137, left=8, width=980, height=454, columnCount=7
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Saldos", "Grid")
        loc_oGrd = loc_oPagina.grd_4c_Saldos
        WITH loc_oGrd
            .Top          = 137
            .Left         = 8
            .Width        = 980
            .Height       = 454
            .ReadOnly     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 8
            .GridLines    = 0
            .HeaderHeight = 20
            .RecordMark   = .F.
            .DeleteMark   = .F.
        ENDWITH
        loc_oGrd.ColumnCount  = 7
        loc_oGrd.RecordSource = "cursor_4c_Saldos"

        *-- Reconfigurar ControlSources e Headers apos RecordSource
        loc_oGrd.Column1.ControlSource    = "cursor_4c_Saldos.Contas"
        loc_oGrd.Column1.Width            = 100
        loc_oGrd.Column1.Header1.Caption  = "Conta"
        loc_oGrd.Column1.Header1.FontName = "Tahoma"
        loc_oGrd.Column1.Header1.FontBold = .T.

        loc_oGrd.Column2.ControlSource    = "cursor_4c_Saldos.Rclis"
        loc_oGrd.Column2.Width            = 280
        loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column2.Header1.FontName = "Tahoma"
        loc_oGrd.Column2.Header1.FontBold = .T.

        loc_oGrd.Column3.ControlSource    = "cursor_4c_Saldos.Moedas"
        loc_oGrd.Column3.Width            = 80
        loc_oGrd.Column3.Header1.Caption  = "Moeda"
        loc_oGrd.Column3.Header1.FontName = "Tahoma"
        loc_oGrd.Column3.Header1.FontBold = .T.

        loc_oGrd.Column4.ControlSource    = "cursor_4c_Saldos.Saldos"
        loc_oGrd.Column4.Width            = 140
        loc_oGrd.Column4.Alignment        = 2
        loc_oGrd.Column4.Header1.Caption  = "Saldo"
        loc_oGrd.Column4.Header1.FontName = "Tahoma"
        loc_oGrd.Column4.Header1.FontBold = .T.

        loc_oGrd.Column5.ControlSource    = "cursor_4c_Saldos.Emps"
        loc_oGrd.Column5.Width            = 50
        loc_oGrd.Column5.Header1.Caption  = "Emp"
        loc_oGrd.Column5.Header1.FontName = "Tahoma"
        loc_oGrd.Column5.Header1.FontBold = .T.

        loc_oGrd.Column6.ControlSource    = "cursor_4c_Saldos.Cpfs"
        loc_oGrd.Column6.Width            = 160
        loc_oGrd.Column6.Header1.Caption  = "CPF/CNPJ"
        loc_oGrd.Column6.Header1.FontName = "Tahoma"
        loc_oGrd.Column6.Header1.FontBold = .T.

        loc_oGrd.Column7.ControlSource    = "cursor_4c_Saldos.Situas"
        loc_oGrd.Column7.Width            = 80
        loc_oGrd.Column7.Header1.Caption  = "M/F"
        loc_oGrd.Column7.Header1.FontName = "Tahoma"
        loc_oGrd.Column7.Header1.FontBold = .T.

        BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdSaldoAfterRowColChange")

        *-- KeyPress em cada coluna: ENTER?Consultar, F5?Procurar, F6?Imprimir
        BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "GrdSaldoKeyPress")
        BINDEVENT(loc_oGrd.Column2.Text1, "KeyPress", THIS, "GrdSaldoKeyPress")
        BINDEVENT(loc_oGrd.Column3.Text1, "KeyPress", THIS, "GrdSaldoKeyPress")
        BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress", THIS, "GrdSaldoKeyPress")
        BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress", THIS, "GrdSaldoKeyPress")
        BINDEVENT(loc_oGrd.Column6.Text1, "KeyPress", THIS, "GrdSaldoKeyPress")
        BINDEVENT(loc_oGrd.Column7.Text1, "KeyPress", THIS, "GrdSaldoKeyPress")

        *----------------------------------------------------------------------
        * cntSaldo - Container flutuante: Relatorio de Saldos
        * top=231, left=344, width=312, height=212, Visible=.F.
        *----------------------------------------------------------------------
        THIS.ConfigurarCntSaldo(loc_oPagina)

        *----------------------------------------------------------------------
        * cntConsulta - Container flutuante: Busca por Conta/Descricao
        * top=263, left=310, width=379, height=149, Visible=.F.
        *----------------------------------------------------------------------
        THIS.ConfigurarCntConsulta(loc_oPagina)

        *-- Tornar controles visiveis (exceto containers flutuantes)
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * PROCEDURE ConfigurarCntSaldo
    * Container flutuante: opcoes de relatorio de saldos (cntSaldo)
    * top=231, left=344, width=312, height=212, Visible=.F.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCntSaldo(par_oPagina)
        LOCAL loc_oCnt, loc_oOpt

        par_oPagina.AddObject("cnt_4c_Saldo", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Saldo
        WITH loc_oCnt
            .Top           = 231
            .Left          = 344
            .Width         = 312
            .Height        = 212
            .Visible       = .F.
            .BackColor     = RGB(212, 208, 200)
            .BorderWidth   = 1
            .SpecialEffect = 1
        ENDWITH

        *-- Label titulo
        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top       = 4
            .Left      = 1
            .Width     = 310
            .Height    = 17
            .Caption   = "Relat" + CHR(243) + "rio de Saldos de Conta Corrente"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 128)
            .BackStyle = 0
        ENDWITH

        *-- Say1 "Moeda:"
        loc_oCnt.AddObject("lbl_4c_Label_moeda", "Label")
        WITH loc_oCnt.lbl_4c_Label_moeda
            .Top       = 28
            .Left      = 16
            .Width     = 41
            .Height    = 15
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- get_cd_moeda: top=25, left=59, width=33, height=23
        loc_oCnt.AddObject("txt_4c__cd_moeda", "TextBox")
        WITH loc_oCnt.txt_4c__cd_moeda
            .Top       = 25
            .Left      = 59
            .Width     = 33
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__cd_moeda, "KeyPress", THIS, "TxtCdMoedaSaldoKeyPress")

        *-- get_ds_moeda: top=25, left=94, width=126, height=23
        loc_oCnt.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH loc_oCnt.txt_4c__ds_moeda
            .Top      = 25
            .Left     = 94
            .Width    = 126
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__ds_moeda, "KeyPress", THIS, "TxtDsMoedaSaldoKeyPress")

        *-- lbl_periodo "Data:": top=55, left=25, width=32
        loc_oCnt.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_periodo
            .Top       = 55
            .Left      = 25
            .Width     = 32
            .Height    = 15
            .Caption   = "Data :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- get_dtlimite: top=50, left=59, width=80, height=23
        loc_oCnt.AddObject("txt_4c__dtlimite", "TextBox")
        WITH loc_oCnt.txt_4c__dtlimite
            .Top      = 50
            .Left     = 59
            .Width    = 80
            .Height   = 23
            .Value    = {}
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        *-- Say21 "Situacao:": top=54, left=168, width=50
        loc_oCnt.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oCnt.lbl_4c_Label21
            .Top       = 54
            .Left      = 168
            .Width     = 50
            .Height    = 15
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Get_Situa: top=50, left=224, width=31, height=23
        loc_oCnt.AddObject("txt_4c_Situa", "TextBox")
        WITH loc_oCnt.txt_4c_Situa
            .Top       = 50
            .Left      = 224
            .Width     = 31
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 4
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Situa, "KeyPress", THIS, "TxtSituacaoKeyPress")

        *-- Say2 "Ordem:": top=84, left=16, width=41
        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Top       = 84
            .Left      = 16
            .Width     = 41
            .Height    = 15
            .Caption   = "Ordem :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- optOrdem: top=79, left=54, width=199, height=27, buttonCount=3
        loc_oCnt.AddObject("obj_4c_OptOrdem", "OptionGroup")
        loc_oOpt = loc_oCnt.obj_4c_OptOrdem
        WITH loc_oOpt
            .Top         = 79
            .Left        = 54
            .Width       = 199
            .Height      = 27
            .ButtonCount = 3
            .BorderStyle = 0
            .Value       = 1
        ENDWITH
        WITH loc_oOpt.Buttons(1)
            .Caption  = "Conta"
            .Width    = 65
            .Height   = 21
            .Left     = 0
            .Top      = 3
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        WITH loc_oOpt.Buttons(2)
            .Caption  = "Moeda"
            .Width    = 65
            .Height   = 21
            .Left     = 66
            .Top      = 3
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        WITH loc_oOpt.Buttons(3)
            .Caption  = "Saldo"
            .Width    = 65
            .Height   = 21
            .Left     = 132
            .Top      = 3
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oOpt, "InteractiveChange", THIS, "OptOrdemSaldoChange")

        *-- chkAscendente: top=105, left=199, width=84, height=17, value=1
        loc_oCnt.AddObject("chk_4c_ChkAscendente", "CheckBox")
        WITH loc_oCnt.chk_4c_ChkAscendente
            .Top       = 105
            .Left      = 199
            .Width     = 84
            .Height    = 17
            .Caption   = "Ascendente"
            .Value     = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
        ENDWITH

        *-- CheckSaldo "Imprime Saldo Zero": top=103, left=14, width=110, height=15, value=0
        loc_oCnt.AddObject("chk_4c_CheckSaldo", "CheckBox")
        WITH loc_oCnt.chk_4c_CheckSaldo
            .Top       = 103
            .Left      = 14
            .Width     = 110
            .Height    = 15
            .Caption   = "Imprime Saldo Zero"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
        ENDWITH

        *-- lb_Aguarde (Visible=.F.): top=130, left=6, width=300, height=17
        loc_oCnt.AddObject("lbl_4c_Lb_Aguarde", "Label")
        WITH loc_oCnt.lbl_4c_Lb_Aguarde
            .Top       = 130
            .Left      = 6
            .Width     = 300
            .Height    = 17
            .Caption   = "Aguarde... Processando!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        *-- Command1 (Excel): top=160, left=125, width=45, height=45
        loc_oCnt.AddObject("cmd_4c_Command1", "CommandButton")
        WITH loc_oCnt.cmd_4c_Command1
            .Top      = 160
            .Left     = 125
            .Width    = 45
            .Height   = 45
            .Caption  = ""
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes   = .F.
            .Picture  = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Command1, "Click", THIS, "BtnSaldoExcelClick")

        *-- Cmd_Imprimir: top=160, left=170, width=44, height=45
        loc_oCnt.AddObject("cmd_4c_Cmd_Imprimir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Cmd_Imprimir
            .Top      = 160
            .Left     = 170
            .Width    = 44
            .Height   = 45
            .Caption  = ""
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes   = .F.
            .Picture  = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Cmd_Imprimir, "Click", THIS, "BtnSaldoImprimirClick")

        *-- Cmd_Visual: top=160, left=214, width=44, height=45
        loc_oCnt.AddObject("cmd_4c_Cmd_Visual", "CommandButton")
        WITH loc_oCnt.cmd_4c_Cmd_Visual
            .Top      = 160
            .Left     = 214
            .Width    = 44
            .Height   = 45
            .Caption  = ""
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes   = .F.
            .Picture  = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Cmd_Visual, "Click", THIS, "BtnSaldoVisualClick")

        *-- cmd_grupo (OK): top=155, left=255, width=50, height=50, buttonCount=1
        loc_oCnt.AddObject("obj_4c_Cmd_grupo", "CommandGroup")
        WITH loc_oCnt.obj_4c_Cmd_grupo
            .Top           = 155
            .Left          = 255
            .Width         = 50
            .Height        = 50
            .ButtonCount   = 1
            .BorderStyle   = 0
            .SpecialEffect = 0
        ENDWITH
        WITH loc_oCnt.obj_4c_Cmd_grupo.Buttons(1)
            .Caption   = "OK"
            .Width     = 50
            .Height    = 50
            .Left      = 0
            .Top       = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        BINDEVENT(loc_oCnt.obj_4c_Cmd_grupo, "Click", THIS, "BtnSaldoCntOKClick")
    ENDPROC

    *==========================================================================
    * PROCEDURE ConfigurarCntConsulta
    * Container flutuante: busca de conta por codigo/descricao (cntConsulta)
    * top=263, left=310, width=379, height=149, Visible=.F.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCntConsulta(par_oPagina)
        LOCAL loc_oCnt

        par_oPagina.AddObject("cnt_4c_Consulta", "Container")
        loc_oCnt = par_oPagina.cnt_4c_Consulta
        WITH loc_oCnt
            .Top           = 263
            .Left          = 310
            .Width         = 379
            .Height        = 149
            .Visible       = .F.
            .BackColor     = RGB(212, 208, 200)
            .BorderWidth   = 1
            .SpecialEffect = 1
        ENDWITH

        *-- Label1 "Procura por Conta/Descricao": top=3, left=1, width=377, height=18
        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top       = 3
            .Left      = 1
            .Width     = 377
            .Height    = 18
            .Caption   = "Procura por Conta/Descri" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 128)
            .BackStyle = 0
        ENDWITH

        *-- Say1 "Codigo:": top=42, left=35
        loc_oCnt.AddObject("lbl_4c_Label_cod", "Label")
        WITH loc_oCnt.lbl_4c_Label_cod
            .Top       = 42
            .Left      = 35
            .Width     = 41
            .Height    = 15
            .Caption   = "C" + CHR(243) + "digo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Get_Cd_Conta: top=37, left=80, width=82, height=23
        loc_oCnt.AddObject("txt_4c_Cd_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Cd_Conta
            .Top       = 37
            .Left      = 80
            .Width     = 82
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 10
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c_Cd_Conta, "KeyPress", THIS, "TxtCdContaKeyPress")

        *-- lbl_conta "Descricao:": top=66, left=22
        loc_oCnt.AddObject("lbl_4c_Lbl_conta", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_conta
            .Top       = 66
            .Left      = 22
            .Width     = 55
            .Height    = 15
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- get_ds_conta: top=62, left=80, width=290
        loc_oCnt.AddObject("txt_4c__ds_conta", "TextBox")
        WITH loc_oCnt.txt_4c__ds_conta
            .Top      = 62
            .Left     = 80
            .Width    = 290
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oCnt.txt_4c__ds_conta, "KeyPress", THIS, "TxtDsContaKeyPress")

        *-- cmd_grupo (OK/Cancelar): top=99, left=284, width=88, height=43, buttonCount=2
        loc_oCnt.AddObject("obj_4c_Cmd_grupo", "CommandGroup")
        WITH loc_oCnt.obj_4c_Cmd_grupo
            .Top           = 99
            .Left          = 284
            .Width         = 88
            .Height        = 43
            .ButtonCount   = 2
            .BorderStyle   = 0
            .SpecialEffect = 0
        ENDWITH
        WITH loc_oCnt.obj_4c_Cmd_grupo.Buttons(1)
            .Caption  = "OK"
            .Width    = 44
            .Height   = 43
            .Left     = 0
            .Top      = 0
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        WITH loc_oCnt.obj_4c_Cmd_grupo.Buttons(2)
            .Caption  = "Cancelar"
            .Width    = 44
            .Height   = 43
            .Left     = 44
            .Top      = 0
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
        BINDEVENT(loc_oCnt.obj_4c_Cmd_grupo, "Click", THIS, "BtnConsultaCntClick")
    ENDPROC

    *==========================================================================
    * PROCEDURE ConfigurarPaginaHist
    * Page2 - Historico de Lancamentos e Operacoes
    * Fase 5/8: Header + botoes de acao + filtros + faixa inferior
    * Fase 6/8: grd_lancamento (adicionado depois)
    * Fase 7/8: cntImprime + cntQuitas (adicionados depois)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaHist()
        LOCAL loc_oPagina, loc_oCnt, loc_oGrd

        loc_oPagina = THIS.pgf_4c_1.Page2
        WITH loc_oPagina
            .Caption   = "Hist" + CHR(243) + "rico"
            .BackColor = RGB(212, 208, 200)
        ENDWITH

        *----------------------------------------------------------------------
        * Container cabecalho - fundo escuro (espelho do SALDO)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = loc_oPagina.cnt_4c_Sombra
        WITH loc_oCnt
            .Top           = 0
            .Left          = 0
            .Width         = 1000
            .Height        = 90
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
        ENDWITH

        *----------------------------------------------------------------------
        * Container1 - barra separadora visual: top=6, left=69, width=14, height=84
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Container1", "Container")
        WITH loc_oPagina.cnt_4c_Container1
            .Top           = 6
            .Left          = 69
            .Width         = 14
            .Height        = 84
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Botoes de acao principais - top=11, height=75
        *----------------------------------------------------------------------

        *-- Cmd_Consulta "Visualizar": left=96
        loc_oPagina.AddObject("cmd_4c_Cmd_Consulta", "CommandButton")
        WITH loc_oPagina.cmd_4c_Cmd_Consulta
            .Top        = 11
            .Left       = 96
            .Width      = 75
            .Height     = 75
            .Caption    = "\<Visualizar"
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Cmd_Consulta, "Click", THIS, "BtnConsultaHistClick")

        *-- Cmd_Alterar "Alterar": left=171
        loc_oPagina.AddObject("cmd_4c_Cmd_Alterar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Cmd_Alterar
            .Top        = 11
            .Left       = 171
            .Width      = 75
            .Height     = 75
            .Caption    = "Alterar"
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Cmd_Alterar, "Click", THIS, "BtnAlterarHistClick")

        *-- Cmd_Excluir "Excluir": left=246
        loc_oPagina.AddObject("cmd_4c_Cmd_Excluir", "CommandButton")
        WITH loc_oPagina.cmd_4c_Cmd_Excluir
            .Top        = 11
            .Left       = 246
            .Width      = 75
            .Height     = 75
            .Caption    = "Excluir"
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Cmd_Excluir, "Click", THIS, "BtnExcluirHistClick")

        *-- cmd_impressao "Imprimir": left=321
        loc_oPagina.AddObject("cmd_4c_Cmd_impressao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Cmd_impressao
            .Top        = 11
            .Left       = 321
            .Width      = 75
            .Height     = 75
            .Caption    = "Imprimir"
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Cmd_impressao, "Click", THIS, "BtnImpressaoHistClick")

        *-- Anexa "Movimento": left=396
        loc_oPagina.AddObject("cmd_4c_Anexa", "CommandButton")
        WITH loc_oPagina.cmd_4c_Anexa
            .Top        = 11
            .Left       = 396
            .Width      = 75
            .Height     = 75
            .Caption    = "Movimento"
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Anexa, "Click", THIS, "BtnAnexaHistClick")

        *-- Chk_Quitacao "Receber" (commandbutton): left=471
        loc_oPagina.AddObject("cmd_4c_Chk_Quitacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Chk_Quitacao
            .Top        = 11
            .Left       = 471
            .Width      = 75
            .Height     = 75
            .Caption    = "Receber"
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Chk_Quitacao, "Click", THIS, "BtnQuitacaoHistClick")

        *-- Chk_Concilia "Conciliar" (checkbox): left=547
        loc_oPagina.AddObject("chk_4c_Chk_Concilia", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_Concilia
            .Top        = 11
            .Left       = 547
            .Width      = 75
            .Height     = 75
            .Caption    = "Conciliar"
            .Value      = 0
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .Style      = 1
            .Alignment  = 2
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.chk_4c_Chk_Concilia, "InteractiveChange", THIS, "BtnConciliaHistClick")

        *-- Chk_Auditoria "Auditar" (checkbox): left=622
        loc_oPagina.AddObject("chk_4c_Chk_Auditoria", "CheckBox")
        WITH loc_oPagina.chk_4c_Chk_Auditoria
            .Top        = 11
            .Left       = 622
            .Width      = 75
            .Height     = 75
            .Caption    = "Auditar"
            .Value      = 0
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .Style      = 1
            .Alignment  = 2
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "geral_lapis_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.chk_4c_Chk_Auditoria, "InteractiveChange", THIS, "BtnAuditoriaHistClick")

        *-- Chk_Follow "Follow-up Conciliacao" (commandbutton): left=697
        loc_oPagina.AddObject("cmd_4c_Chk_Follow", "CommandButton")
        WITH loc_oPagina.cmd_4c_Chk_Follow
            .Top        = 11
            .Left       = 697
            .Width      = 75
            .Height     = 75
            .Caption    = "Follow-\<up Concilia" + CHR(231) + CHR(227) + "o"
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "geral_pasta_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Chk_Follow, "Click", THIS, "BtnFollowConciliaHistClick")

        *-- FollowUp "Follow-up Conta": left=772
        loc_oPagina.AddObject("cmd_4c_FollowUp", "CommandButton")
        WITH loc_oPagina.cmd_4c_FollowUp
            .Top        = 11
            .Left       = 772
            .Width      = 75
            .Height     = 75
            .Caption    = "Follow-up Conta"
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_FollowUp, "Click", THIS, "BtnFollowUpHistClick")

        *-- FollowUpI "Follow-up Lancamento": left=847
        loc_oPagina.AddObject("cmd_4c_FollowLancto", "CommandButton")
        WITH loc_oPagina.cmd_4c_FollowLancto
            .Top        = 11
            .Left       = 847
            .Width      = 75
            .Height     = 75
            .Caption    = "Follow-up Lan" + CHR(231) + "amento"
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Picture    = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_FollowLancto, "Click", THIS, "BtnFollowUpIHistClick")

        *-- grp_operacao "Sair": top=6, left=917, width=85, height=85, buttonCount=1
        loc_oPagina.AddObject("obj_4c_Grp_operacao", "CommandGroup")
        WITH loc_oPagina.obj_4c_Grp_operacao
            .Top           = 6
            .Left          = 917
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BorderStyle   = 0
            .SpecialEffect = 0
        ENDWITH
        WITH loc_oPagina.obj_4c_Grp_operacao.Buttons(1)
            .Caption    = "Encerrar"
            .Width      = 75
            .Height     = 75
            .Left       = 5
            .Top        = 5
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Cancel     = .T.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.obj_4c_Grp_operacao, "Click", THIS, "BtnSairHistClick")

        *----------------------------------------------------------------------
        * Faixa de filtros - top=90-140
        *----------------------------------------------------------------------

        *-- lbl_lancamentos "Filtro": top=100, left=10, width=31, height=15
        loc_oPagina.AddObject("lbl_4c_Lbl_lancamentos", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_lancamentos
            .Top       = 100
            .Left      = 10
            .Width     = 31
            .Height    = 15
            .Caption   = "Filtro"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Cmb_Concilia: top=114, left=10, width=256, height=24
        loc_oPagina.AddObject("cmb_4c_Concilia", "ComboBox")
        WITH loc_oPagina.cmb_4c_Concilia
            .Top    = 114
            .Left   = 10
            .Width  = 256
            .Height = 24
            .FontName = "Tahoma"
            .FontSize = 8
            .Style  = 2
        ENDWITH
        BINDEVENT(loc_oPagina.cmb_4c_Concilia, "InteractiveChange", THIS, "CmbConciliaHistChange")

        *-- Label1 "Moeda": top=100, left=276, width=40, height=15
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Top       = 100
            .Left      = 276
            .Width     = 40
            .Height    = 15
            .Caption   = "Moeda"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Get_MOEDA: top=115, left=276, width=44
        loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPagina.txt_4c_Moeda
            .Top      = 115
            .Left     = 276
            .Width    = 44
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 3
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaHistKeyPress")

        *-- lbl_grupo_conta "Grupo": top=100, left=329, width=36, height=15
        loc_oPagina.AddObject("lbl_4c_LblHistGrupo", "Label")
        WITH loc_oPagina.lbl_4c_LblHistGrupo
            .Top       = 100
            .Left      = 329
            .Width     = 36
            .Height    = 15
            .Caption   = "Grupo"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Get_GRUPO: top=115, left=329, width=80
        loc_oPagina.AddObject("txt_4c_GrupoHist", "TextBox")
        WITH loc_oPagina.txt_4c_GrupoHist
            .Top      = 115
            .Left     = 329
            .Width    = 80
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 10
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_GrupoHist, "KeyPress", THIS, "TxtGrupoHistKeyPress")

        *-- Label4 "Conta": top=100, left=418, width=35, height=15
        loc_oPagina.AddObject("lbl_4c_Lbl_Conta", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_Conta
            .Top       = 100
            .Left      = 418
            .Width     = 35
            .Height    = 15
            .Caption   = "Conta"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Get_Hconta: top=115, left=418, width=80
        loc_oPagina.AddObject("txt_4c_Hconta", "TextBox")
        WITH loc_oPagina.txt_4c_Hconta
            .Top      = 115
            .Left     = 418
            .Width    = 80
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 10
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Hconta, "KeyPress", THIS, "TxtHcontaHistKeyPress")

        *-- Get_Hdconta (descricao da conta, ReadOnly): top=115, left=500, width=349, height=23
        loc_oPagina.AddObject("txt_4c_Hdconta", "TextBox")
        WITH loc_oPagina.txt_4c_Hdconta
            .Top      = 115
            .Left     = 500
            .Width    = 349
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Procura button: top=93, left=853, width=45, height=45
        loc_oPagina.AddObject("cmd_4c_Procura", "CommandButton")
        WITH loc_oPagina.cmd_4c_Procura
            .Top     = 93
            .Left    = 853
            .Width   = 45
            .Height  = 45
            .Caption = "..."
            .FontName = "Tahoma"
            .FontSize = 8
            .Picture = gc_4c_CaminhoIcones + "geral_procura_45.jpg"
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Procura, "Click", THIS, "BtnProcuraHistClick")

        *----------------------------------------------------------------------
        * Labels e indicadores de status lateral - top=89-127, left=926
        * (legendas do container Botoes de cores)
        *----------------------------------------------------------------------

        *-- Label5 "Baixado": top=89, left=926
        loc_oPagina.AddObject("lbl_4c_Lbl5", "Label")
        WITH loc_oPagina.lbl_4c_Lbl5
            .Top       = 89
            .Left      = 926
            .Width     = 40
            .Height    = 15
            .Caption   = "Baixado"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Label6 "Cancelado": top=102, left=926
        loc_oPagina.AddObject("lbl_4c_Lbl6", "Label")
        WITH loc_oPagina.lbl_4c_Lbl6
            .Top       = 102
            .Left      = 926
            .Width     = 52
            .Height    = 15
            .Caption   = "Cancelado"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Label7 "Conciliado": top=114, left=926
        loc_oPagina.AddObject("lbl_4c_Lbl7", "Label")
        WITH loc_oPagina.lbl_4c_Lbl7
            .Top       = 114
            .Left      = 926
            .Width     = 50
            .Height    = 15
            .Caption   = "Conciliado"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Label9 "Prorrogado": top=127, left=926
        loc_oPagina.AddObject("lbl_4c_Lbl9", "Label")
        WITH loc_oPagina.lbl_4c_Lbl9
            .Top       = 127
            .Left      = 926
            .Width     = 56
            .Height    = 15
            .Caption   = "Prorrogado"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Botoes container - marcadores de status coloridos: top=90, left=906, width=17, height=50
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        loc_oCnt = loc_oPagina.cnt_4c_Botoes
        WITH loc_oCnt
            .Top           = 90
            .Left          =  542
            .Width         = 17
            .Height        = 50
            .BackColor     = RGB(212, 208, 200)
            .BorderWidth   = 0
            .SpecialEffect = 0
        ENDWITH

        *-- Botao1 verde (Baixado): top=1
        loc_oCnt.AddObject("txt_4c_Botao1", "TextBox")
        WITH loc_oCnt.txt_4c_Botao1
            .Top         = 1
            .Left        = 0
            .Width       = 17
            .Height      = 12
            .ReadOnly    = .T.
            .BackColor   = RGB(0, 128, 0)
            .BorderStyle = 0
        ENDWITH

        *-- Botao2 vermelho (Cancelado): top=13
        loc_oCnt.AddObject("txt_4c_Botao2", "TextBox")
        WITH loc_oCnt.txt_4c_Botao2
            .Top         = 13
            .Left        = 0
            .Width       = 17
            .Height      = 12
            .ReadOnly    = .T.
            .BackColor   = RGB(255, 0, 0)
            .BorderStyle = 0
        ENDWITH

        *-- Botao3 azul (Conciliado): top=25
        loc_oCnt.AddObject("txt_4c_Botao3", "TextBox")
        WITH loc_oCnt.txt_4c_Botao3
            .Top         = 25
            .Left        = 0
            .Width       = 17
            .Height      = 12
            .ReadOnly    = .T.
            .BackColor   = RGB(0, 0, 255)
            .BorderStyle = 0
        ENDWITH

        *-- Text4 laranja (Prorrogado): top=37
        loc_oCnt.AddObject("txt_4c_Text4", "TextBox")
        WITH loc_oCnt.txt_4c_Text4
            .Top         = 37
            .Left        = 0
            .Width       = 17
            .Height      = 12
            .ReadOnly    = .T.
            .BackColor   = RGB(255, 128, 0)
            .BorderStyle = 0
        ENDWITH

        *----------------------------------------------------------------------
        * Faixa inferior - informacoes do lancamento selecionado (top=538-580)
        *----------------------------------------------------------------------

        *-- Label2 "Historico": top=538, left=8, width=52, height=15
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Top       = 538
            .Left      = 8
            .Width     = 52
            .Height    = 15
            .Caption   = "Hist" + CHR(243) + "rico"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Get_HIST: top=553, left=8, width=290, height=20
        loc_oPagina.AddObject("txt_4c_HIST", "TextBox")
        WITH loc_oPagina.txt_4c_HIST
            .Top      = 553
            .Left     = 8
            .Width    = 290
            .Height   = 20
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Get_Hist2: top=574, left=8, width=290, height=20
        loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
        WITH loc_oPagina.txt_4c_Hist2
            .Top      = 574
            .Left     = 8
            .Width    = 290
            .Height   = 20
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Label3 "Usuario": top=538, left=310, width=45, height=15
        loc_oPagina.AddObject("lbl_4c_Lbl3", "Label")
        WITH loc_oPagina.lbl_4c_Lbl3
            .Top       = 538
            .Left      = 310
            .Width     = 45
            .Height    = 15
            .Caption   = "Usu" + CHR(225) + "rio"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Get1: top=553, left=308, width=89, height=20
        loc_oPagina.AddObject("txt_4c_Get1", "TextBox")
        WITH loc_oPagina.txt_4c_Get1
            .Top      = 553
            .Left     = 308
            .Width    = 89
            .Height   = 20
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Label8 "Cobranca": top=538, left=408, width=55, height=15
        loc_oPagina.AddObject("lbl_4c_Lbl8", "Label")
        WITH loc_oPagina.lbl_4c_Lbl8
            .Top       = 538
            .Left      = 408
            .Width     = 55
            .Height    = 15
            .Caption   = "Cobran" + CHR(231) + CHR(97) + ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- getCtaCob: top=553, left=406, width=89, height=20
        loc_oPagina.AddObject("txt_4c_CtaCob", "TextBox")
        WITH loc_oPagina.txt_4c_CtaCob
            .Top      = 553
            .Left     = 406
            .Width    = 89
            .Height   = 20
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- getNomCob: top=553, left=496, width=327, height=20
        loc_oPagina.AddObject("txt_4c_NomCob", "TextBox")
        WITH loc_oPagina.txt_4c_NomCob
            .Top      = 553
            .Left     = 496
            .Width    = 327
            .Height   = 20
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Label10 "Job:": top=578, left=370, width=28, height=15
        loc_oPagina.AddObject("lbl_4c_Lbl10", "Label")
        WITH loc_oPagina.lbl_4c_Lbl10
            .Top       = 578
            .Left      = 370
            .Width     = 28
            .Height    = 15
            .Caption   = "Job :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- getjob: top=574, left=406, width=89, height=20
        loc_oPagina.AddObject("txt_4c_job", "TextBox")
        WITH loc_oPagina.txt_4c_job
            .Top      = 574
            .Left     = 406
            .Width    = 89
            .Height   = 20
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- getdjob: top=574, left=496, width=327, height=20
        loc_oPagina.AddObject("txt_4c_djob", "TextBox")
        WITH loc_oPagina.txt_4c_djob
            .Top      = 574
            .Left     = 496
            .Width    = 327
            .Height   = 20
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Say_Data "Conciliacao": top=538, left=833, width=68, height=15
        loc_oPagina.AddObject("lbl_4c_SayData", "Label")
        WITH loc_oPagina.lbl_4c_SayData
            .Top       = 538
            .Left      = 833
            .Width     = 68
            .Height    = 15
            .Caption   = "Concilia" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Get_Data (data de conciliacao): top=553, left=833, width=73, height=20
        loc_oPagina.AddObject("txt_4c_DataConcilia", "TextBox")
        WITH loc_oPagina.txt_4c_DataConcilia
            .Top      = 553
            .Left     = 833
            .Width    = 73
            .Height   = 20
            .Value    = {}
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DataConcilia, "KeyPress", THIS, "TxtDataConciliaKeyPress")

        *-- Get3: top=574, left=833, width=73, height=20
        loc_oPagina.AddObject("txt_4c_Get3", "TextBox")
        WITH loc_oPagina.txt_4c_Get3
            .Top      = 574
            .Left     = 833
            .Width    = 73
            .Height   = 20
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Lbl_Auditoria "Auditoria": top=538, left=916, width=54, height=15
        loc_oPagina.AddObject("lbl_4c_LblAuditoria", "Label")
        WITH loc_oPagina.lbl_4c_LblAuditoria
            .Top       = 538
            .Left      = 916
            .Width     = 54
            .Height    = 15
            .Caption   = "Auditoria"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
        ENDWITH

        *-- Get_DtAudits: top=553, left=916, width=73, height=20
        loc_oPagina.AddObject("txt_4c_DtAudits", "TextBox")
        WITH loc_oPagina.txt_4c_DtAudits
            .Top      = 553
            .Left     = 916
            .Width    = 73
            .Height   = 20
            .Value    = {}
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *-- Get_Auditors: top=574, left=916, width=73, height=20
        loc_oPagina.AddObject("txt_4c_Auditors", "TextBox")
        WITH loc_oPagina.txt_4c_Auditors
            .Top      = 574
            .Left     = 916
            .Width    = 73
            .Height   = 20
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Cursor placeholder para grd_4c_Lancamento
        * (sera populado por BtnConsultarSaldoClick via SQLEXEC)
        *----------------------------------------------------------------------
        IF !USED("CrSigMvCcr")
            SET NULL ON
            CREATE CURSOR CrSigMvCcr ( ;
                Emps        C(3),    ;
                Grupos      C(10),   ;
                Contas      C(10),   ;
                Moedas      C(3),    ;
                Datas       D,       ;
                DataConcs   D,       ;
                Hists       C(60),   ;
                Hist2s      C(80),   ;
                Valors      N(11,2), ;
                Saldos      N(15,2), ;
                Opers       C(1),    ;
                Nopers      N(7),    ;
                Numes       N(6),    ;
                Dopes       C(20),   ;
                Dopcs       C(20),   ;
                Numcs       N(6),    ;
                Concs       L,       ;
                Usuconcs    C(10),   ;
                Usualts     C(10),   ;
                Auditors    C(10),   ;
                DtAudits    D,       ;
                Tipos       C(1),    ;
                Vopers      C(13),   ;
                Titulos     C(10),   ;
                NFs         C(10),   ;
                Docus       C(10),   ;
                Empos       C(3),    ;
                SGrupos     C(10),   ;
                Nlancs      N(6),    ;
                GruConMoes  C(23),   ;
                CidChaves   C(20),   ;
                EmpCCs      C(3),    ;
                Pagos       C(1),    ;
                TitCancs    N(1),    ;
                Jobs        C(10),   ;
                Saldocs     N(15,2), ;
                RClis       C(40),   ;
                Situas      C(10),   ;
                Concilias   N(1),    ;
                Tipo        C(1),    ;
                Prorrogados L )
            SET NULL OFF
        ENDIF

        *----------------------------------------------------------------------
        * grd_4c_Lancamento - grade historico de lancamentos (10 colunas)
        * top=142, left=10, width=981, height=389
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lancamento", "Grid")
        loc_oGrd = loc_oPagina.grd_4c_Lancamento
        WITH loc_oGrd
            .Top        = 142
            .Left       = 10
            .Width      = 981
            .Height     = 389
            .FontName   = "Tahoma"
            .FontSize   = 8
            .GridLines  = 0
            .RecordMark = .F.
            .DeleteMark = .F.
            .ReadOnly   = .T.
        ENDWITH
        loc_oGrd.ColumnCount = 10

        *-- Column1: Datas (Data)
        WITH loc_oGrd.Column1
            .Header1.Caption = "Data"
            .ControlSource   = "CrSigMvCcr.Datas"
            .Width           = 72
            .Alignment       = 0
            .Text1.FontName  = "Tahoma"
            .Text1.FontSize  = 8
        ENDWITH

        *-- Column2: Hists (Historico)
        WITH loc_oGrd.Column2
            .Header1.Caption = "Hist" + CHR(243) + "rico"
            .ControlSource   = "CrSigMvCcr.Hists"
            .Width           = 240
            .Alignment       = 0
            .Text1.FontName  = "Tahoma"
            .Text1.FontSize  = 8
        ENDWITH

        *-- Column3: Valors (Valor)
        WITH loc_oGrd.Column3
            .Header1.Caption = "Valor"
            .ControlSource   = "CrSigMvCcr.Valors"
            .Width           = 90
            .Alignment       = 1
            .Text1.FontName  = "Tahoma"
            .Text1.FontSize  = 8
        ENDWITH

        *-- Column4: Opers (Mov)
        WITH loc_oGrd.Column4
            .Header1.Caption = "Mov"
            .ControlSource   = "CrSigMvCcr.Opers"
            .Width           = 40
            .Alignment       = 2
            .Text1.FontName  = "Tahoma"
            .Text1.FontSize  = 8
        ENDWITH

        *-- Column5: Emps (Emp)
        WITH loc_oGrd.Column5
            .Header1.Caption = "Emp"
            .ControlSource   = "CrSigMvCcr.Emps"
            .Width           = 40
            .Alignment       = 2
            .Text1.FontName  = "Tahoma"
            .Text1.FontSize  = 8
        ENDWITH

        *-- Column6: Saldos (Saldo)
        WITH loc_oGrd.Column6
            .Header1.Caption = "Saldo"
            .ControlSource   = "CrSigMvCcr.Saldos"
            .Width           = 90
            .Alignment       = 1
            .Text1.FontName  = "Tahoma"
            .Text1.FontSize  = 8
        ENDWITH

        *-- Column7: Docus (Documento)
        WITH loc_oGrd.Column7
            .Header1.Caption = "Documento"
            .ControlSource   = "CrSigMvCcr.Docus"
            .Width           = 110
            .Alignment       = 0
            .Text1.FontName  = "Tahoma"
            .Text1.FontSize  = 8
        ENDWITH

        *-- Column8: NFs (Nota)
        WITH loc_oGrd.Column8
            .Header1.Caption = "Nota"
            .ControlSource   = "CrSigMvCcr.NFs"
            .Width           = 80
            .Alignment       = 0
            .Text1.FontName  = "Tahoma"
            .Text1.FontSize  = 8
        ENDWITH

        *-- Column9: Titulos (Titulo)
        WITH loc_oGrd.Column9
            .Header1.Caption = "T" + CHR(237) + "tulo"
            .ControlSource   = "CrSigMvCcr.Titulos"
            .Width           = 115
            .Alignment       = 0
            .Text1.FontName  = "Tahoma"
            .Text1.FontSize  = 8
        ENDWITH

        *-- Column10: Tipo (T)
        WITH loc_oGrd.Column10
            .Header1.Caption = "T"
            .ControlSource   = "CrSigMvCcr.Tipo"
            .Width           = 40
            .Alignment       = 2
            .Text1.FontName  = "Tahoma"
            .Text1.FontSize  = 8
        ENDWITH

        *-- RecordSource APOS configurar todas as colunas
        loc_oGrd.RecordSource = "CrSigMvCcr"

        *-- Reconfirmar TODOS ControlSources apos RecordSource (auto-bind pode reordenar)
        loc_oGrd.Column1.ControlSource  = "CrSigMvCcr.Datas"
        loc_oGrd.Column2.ControlSource  = "CrSigMvCcr.Hists"
        loc_oGrd.Column3.ControlSource  = "CrSigMvCcr.Valors"
        loc_oGrd.Column4.ControlSource  = "CrSigMvCcr.Opers"
        loc_oGrd.Column5.ControlSource  = "CrSigMvCcr.Emps"
        loc_oGrd.Column6.ControlSource  = "CrSigMvCcr.Saldos"
        loc_oGrd.Column7.ControlSource  = "CrSigMvCcr.Docus"
        loc_oGrd.Column8.ControlSource  = "CrSigMvCcr.NFs"
        loc_oGrd.Column9.ControlSource  = "CrSigMvCcr.Titulos"
        loc_oGrd.Column10.ControlSource = "CrSigMvCcr.Tipo"

        *-- BINDEVENT: AfterRowColChange + KeyPress em todas as 10 colunas
        BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdLancamentoAfterRowColChange")
        BINDEVENT(loc_oGrd.Column1.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
        BINDEVENT(loc_oGrd.Column2.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
        BINDEVENT(loc_oGrd.Column3.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
        BINDEVENT(loc_oGrd.Column4.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
        BINDEVENT(loc_oGrd.Column5.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
        BINDEVENT(loc_oGrd.Column6.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
        BINDEVENT(loc_oGrd.Column7.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
        BINDEVENT(loc_oGrd.Column8.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
        BINDEVENT(loc_oGrd.Column9.Text1,  "KeyPress", THIS, "GrdLancamentoKeyPress")
        BINDEVENT(loc_oGrd.Column10.Text1, "KeyPress", THIS, "GrdLancamentoKeyPress")

        *-- Containers flutuantes (Visible=.F., toggled por botoes)
        THIS.ConfigurarCntImprime(loc_oPagina)
        THIS.ConfigurarCntQuitas(loc_oPagina)
    ENDPROC

    *==========================================================================
    * PROCEDURE ConfigurarCntImprime
    * Cria container flutuante cnt_4c_Imprime (Relatorio de Conta Corrente)
    * Equivale ao cntImprime do legado: top=187, left=145, width=709, height=231
    * Visible=.F. - exibido por BtnImpressaoHistClick
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCntImprime(par_oPagina)
        LOCAL loc_oCnt, loc_oGrp, loc_oOpt, loc_oErro
        TRY
            par_oPagina.AddObject("cnt_4c_Imprime", "Container")
            loc_oCnt = par_oPagina.cnt_4c_Imprime
            WITH loc_oCnt
                .Top           = 187
                .Left          = 145
                .Width         = 709
                .Height        = 231
                .Visible       = .F.
                .BackColor     = RGB(212, 208, 200)
                .BorderWidth   = 1
                .SpecialEffect = 0
            ENDWITH

            *-- Shape1 (fundo/borda superior): top=2, left=1, width=708, height=80
            loc_oCnt.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oCnt.shp_4c_Shape1
                .Top           = 2
                .Left          = 1
                .Width         = 708
                .Height        = 80
                .BackColor     = RGB(212, 208, 200)
                .BorderColor   = RGB(128, 128, 128)
                .SpecialEffect = 0
            ENDWITH

            *-- Sombra titulo (Label2 shadow): top=35, left=16
            loc_oCnt.AddObject("lbl_4c_ImpSombra", "Label")
            WITH loc_oCnt.lbl_4c_ImpSombra
                .Top       = 35
                .Left      = 16
                .Width     = 291
                .Height    = 22
                .Caption   = "Relat" + CHR(243) + "rio de Conta Corrente"
                .FontName  = "Tahoma"
                .FontSize  = 10
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
            ENDWITH

            *-- Titulo (Label1): top=33, left=16
            loc_oCnt.AddObject("lbl_4c_TituloImprime", "Label")
            WITH loc_oCnt.lbl_4c_TituloImprime
                .Top       = 33
                .Left      = 16
                .Width     = 291
                .Height    = 22
                .Caption   = "Relat" + CHR(243) + "rio de Conta Corrente"
                .FontName  = "Tahoma"
                .FontSize  = 10
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 128)
                .BackStyle = 0
            ENDWITH

            *-- Botao Voltar (CommandGroup top=0, left=627, width=85, height=85)
            loc_oCnt.AddObject("obj_4c_CntImpVoltar", "CommandGroup")
            WITH loc_oCnt.obj_4c_CntImpVoltar
                .Top         = 0
                .Left        = 627
                .Width       = 85
                .Height      = 85
                .ButtonCount = 1
                .BorderStyle = 0
                .SpecialEffect = 0
            ENDWITH
            WITH loc_oCnt.obj_4c_CntImpVoltar.Buttons(1)
                .Caption    = "Encerrar"
                .Width      = 75
                .Height     = 75
                .Left       = 5
                .Top        = 5
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Cancel     = .T.
                .Picture    = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            ENDWITH
            BINDEVENT(loc_oCnt.obj_4c_CntImpVoltar, "Click", THIS, "BtnCntImpVoltarClick")

            *-- Botao Excel (Command1): top=11, left=557, width=75, height=75
            loc_oCnt.AddObject("cmd_4c_ImpExcel", "CommandButton")
            WITH loc_oCnt.cmd_4c_ImpExcel
                .Top              = 5
                .Left             = 557
                .Width            = 75
                .Height           = 75
                .Caption          = "   E\<xcel             "
                .FontName         = "Comic Sans MS"
                .FontSize         = 8
                .FontBold         = .T.
                .FontItalic       = .T.
                .ForeColor        = RGB(90, 90, 90)
                .BackColor        = RGB(255, 255, 255)
                .Themes           = .F.
                .PicturePosition  = 13
                .Picture          = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_ImpExcel, "Click", THIS, "BtnCntImpExcelClick")

            *-- Botao Impressora (Cmd_Imprimir): top=11, left=482, width=75, height=75
            loc_oCnt.AddObject("cmd_4c_ImpPrint", "CommandButton")
            WITH loc_oCnt.cmd_4c_ImpPrint
                .Top              = 5
                .Left             = 482
                .Width            = 75
                .Height           = 75
                .Caption          = "\<Impressora"
                .FontName         = "Comic Sans MS"
                .FontSize         = 8
                .FontBold         = .T.
                .FontItalic       = .T.
                .ForeColor        = RGB(90, 90, 90)
                .BackColor        = RGB(255, 255, 255)
                .Themes           = .F.
                .PicturePosition  = 13
                .Picture          = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_ImpPrint, "Click", THIS, "BtnCntImpImprimirClick")

            *-- Botao Video/Preview (Cmd_Visual): top=11, left=407, width=75, height=75
            loc_oCnt.AddObject("cmd_4c_ImpVideo", "CommandButton")
            WITH loc_oCnt.cmd_4c_ImpVideo
                .Top              = 5
                .Left             = 407
                .Width            = 75
                .Height           = 75
                .Caption          = "\<V" + CHR(237) + "deo"
                .FontName         = "Comic Sans MS"
                .FontSize         = 8
                .FontBold         = .T.
                .FontItalic       = .T.
                .ForeColor        = RGB(90, 90, 90)
                .BackColor        = RGB(255, 255, 255)
                .Themes           = .F.
                .PicturePosition  = 13
                .Picture          = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            ENDWITH
            BINDEVENT(loc_oCnt.cmd_4c_ImpVideo, "Click", THIS, "BtnCntImpVisualClick")

            *-- lbl_periodo "Periodo :": top=103, left=32, width=45
            loc_oCnt.AddObject("lbl_4c_ImpPeriodo", "Label")
            WITH loc_oCnt.lbl_4c_ImpPeriodo
                .Top      = 103
                .Left     = 32
                .Width    = 45
                .Caption  = "Per" + CHR(237) + "odo :"
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
            ENDWITH

            *-- get_dt_inicial: top=98, left=80, width=80
            loc_oCnt.AddObject("txt_4c_Dt_inicial", "TextBox")
            WITH loc_oCnt.txt_4c_Dt_inicial
                .Top      = 98
                .Left     = 80
                .Width    = 80
                .Height   = 23
                .Value    = {}
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- lbl_periodo_a "a": top=103, left=163
            loc_oCnt.AddObject("lbl_4c_A", "Label")
            WITH loc_oCnt.lbl_4c_A
                .Top      = 103
                .Left     = 163
                .Width    = 8
                .Caption  = CHR(224)
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
            ENDWITH

            *-- get_dt_final: top=98, left=174, width=80
            loc_oCnt.AddObject("txt_4c_Dt_final", "TextBox")
            WITH loc_oCnt.txt_4c_Dt_final
                .Top      = 98
                .Left     = 174
                .Width    = 80
                .Height   = 23
                .Value    = {}
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- Say2 "D/C:": top=102, left=266
            loc_oCnt.AddObject("lbl_4c_DC", "Label")
            WITH loc_oCnt.lbl_4c_DC
                .Top      = 102
                .Left     = 266
                .Width    = 24
                .Caption  = "D/C:"
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
            ENDWITH

            *-- Get_Oper: top=98, left=298, width=17
            loc_oCnt.AddObject("txt_4c_Oper", "TextBox")
            WITH loc_oCnt.txt_4c_Oper
                .Top       = 98
                .Left      = 298
                .Width     = 17
                .Height    = 23
                .Value     = ""
                .MaxLength = 1
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            BINDEVENT(loc_oCnt.txt_4c_Oper, "KeyPress", THIS, "TxtOperImpKeyPress")

            *-- Say1 "Moeda :": top=127, left=36
            loc_oCnt.AddObject("lbl_4c_MoedaImp", "Label")
            WITH loc_oCnt.lbl_4c_MoedaImp
                .Top      = 127
                .Left     = 36
                .Width    = 41
                .Caption  = "Moeda :"
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
            ENDWITH

            *-- get_cd_moeda: top=123, left=80, width=31
            loc_oCnt.AddObject("txt_4c_CdMoeda", "TextBox")
            WITH loc_oCnt.txt_4c_CdMoeda
                .Top       = 123
                .Left      = 80
                .Width     = 31
                .Height    = 23
                .Value     = ""
                .MaxLength = 3
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            BINDEVENT(loc_oCnt.txt_4c_CdMoeda, "KeyPress", THIS, "TxtCdMoedaImpKeyPress")

            *-- get_ds_moeda: top=123, left=113, width=202, height=23
            loc_oCnt.AddObject("txt_4c_DsMoeda", "TextBox")
            WITH loc_oCnt.txt_4c_DsMoeda
                .Top      = 123
                .Left     = 113
                .Width    = 202
                .Height   = 23
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oCnt.txt_4c_DsMoeda, "KeyPress", THIS, "TxtDsMoedaImpKeyPress")

            *-- Say3 "Empresa :": top=152, left=27
            loc_oCnt.AddObject("lbl_4c_EmpresaImp", "Label")
            WITH loc_oCnt.lbl_4c_EmpresaImp
                .Top      = 152
                .Left     = 27
                .Width    = 50
                .Caption  = "Empresa :"
                .FontName = "Tahoma"
                .FontSize = 8
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
            ENDWITH

            *-- getEmps: top=148, left=80, width=31
            loc_oCnt.AddObject("txt_4c_Emps", "TextBox")
            WITH loc_oCnt.txt_4c_Emps
                .Top       = 148
                .Left      = 80
                .Width     = 31
                .Height    = 23
                .Value     = ""
                .MaxLength = 3
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            BINDEVENT(loc_oCnt.txt_4c_Emps, "KeyPress", THIS, "TxtEmpsImpKeyPress")

            *-- getDEmps: top=148, left=113, width=202, height=23
            loc_oCnt.AddObject("txt_4c_DEmps", "TextBox")
            WITH loc_oCnt.txt_4c_DEmps
                .Top      = 148
                .Left     = 113
                .Width    = 202
                .Height   = 23
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oCnt.txt_4c_DEmps, "KeyPress", THIS, "TxtDEmpsImpKeyPress")

            *-- Chk_Grupo: top=97, left=321, width=143, height=15
            loc_oCnt.AddObject("chk_4c_Grupo", "CheckBox")
            WITH loc_oCnt.chk_4c_Grupo
                .Top      = 97
                .Left     = 321
                .Width    = 143
                .Height   = 15
                .Caption  = "Todas as contas do Grupo"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- Check_Salto: top=115, left=321, width=138, height=15
            loc_oCnt.AddObject("chk_4c_Salto", "CheckBox")
            WITH loc_oCnt.chk_4c_Salto
                .Top      = 115
                .Left     = 321
                .Width    = 138
                .Height   = 15
                .Caption  = "Quebra p" + CHR(225) + "gina por conta"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- Check_sAnt: top=133, left=321, width=109, height=15
            loc_oCnt.AddObject("chk_4c_Sant", "CheckBox")
            WITH loc_oCnt.chk_4c_Sant
                .Top      = 133
                .Left     = 321
                .Width    = 109
                .Height   = 15
                .Caption  = "Sem Saldo Anterior"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- Check_Comissao: top=152, left=321, width=63, height=15
            loc_oCnt.AddObject("chk_4c_Comissao", "CheckBox")
            WITH loc_oCnt.chk_4c_Comissao
                .Top      = 152
                .Left     = 321
                .Width    = 63
                .Height   = 15
                .Caption  = "Comiss" + CHR(227) + "o"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- Check_Saldoa: top=152, left=407, width=67, height=15
            loc_oCnt.AddObject("chk_4c_Saldoa", "CheckBox")
            WITH loc_oCnt.chk_4c_Saldoa
                .Top      = 152
                .Left     = 407
                .Width    = 67
                .Height   = 15
                .Caption  = "Sem Saldo"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- chkTaxas: top=170, left=321, width=79, height=15
            loc_oCnt.AddObject("chk_4c_Taxas", "CheckBox")
            WITH loc_oCnt.chk_4c_Taxas
                .Top      = 170
                .Left     = 321
                .Width    = 79
                .Height   = 15
                .Caption  = "Incluir Taxas"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- chkOcultaCta: top=188, left=321, width=149, height=15
            loc_oCnt.AddObject("chk_4c_OcultaCta", "CheckBox")
            WITH loc_oCnt.chk_4c_OcultaCta
                .Top      = 188
                .Left     = 321
                .Width    = 149
                .Height   = 15
                .Caption  = "Ocultar Descri" + CHR(231) + CHR(227) + "o da Conta"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH

            *-- Check_RazaoCP: top=97, left=521, width=148, height=15
            loc_oCnt.AddObject("chk_4c_RazaoCp", "CheckBox")
            WITH loc_oCnt.chk_4c_RazaoCp
                .Top      = 97
                .Left     = 521
                .Width    = 148
                .Height   = 15
                .Caption  = "Rela" + CHR(231) + CHR(227) + "o com Contrapartida"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oCnt.chk_4c_RazaoCp, "InteractiveChange", THIS, "ChkRazaoCPChange")

            *-- Check_RazaoDoc: top=115, left=521, width=135, height=15
            loc_oCnt.AddObject("chk_4c_RazaoDoc", "CheckBox")
            WITH loc_oCnt.chk_4c_RazaoDoc
                .Top      = 115
                .Left     = 521
                .Width    = 135
                .Height   = 15
                .Caption  = "Rela" + CHR(231) + CHR(227) + "o com Documento"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oCnt.chk_4c_RazaoDoc, "InteractiveChange", THIS, "ChkRazaoDocChange")

            *-- chkRelDets: top=133, left=521, width=108, height=15
            loc_oCnt.AddObject("chk_4c_RelDets", "CheckBox")
            WITH loc_oCnt.chk_4c_RelDets
                .Top      = 133
                .Left     = 521
                .Width    = 108
                .Height   = 15
                .Caption  = "Rela" + CHR(231) + CHR(227) + "o Detalhada"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            BINDEVENT(loc_oCnt.chk_4c_RelDets, "InteractiveChange", THIS, "ChkRelDetsChange")

            *-- optSNA (S/N/A): top=147, left=520, width=160, height=27, buttonCount=3
            loc_oCnt.AddObject("obj_4c_OptSNA", "OptionGroup")
            WITH loc_oCnt.obj_4c_OptSNA
                .Top         = 147
                .Left        = 520
                .Width       = 160
                .Height      = 27
                .ButtonCount = 3
                .BorderStyle = 0
                .Value       = 1
            ENDWITH
            WITH loc_oCnt.obj_4c_OptSNA.Buttons(1)
                .Caption   = "S"
                .BackStyle = 0
                .Top       = 3
                .Left      = 3
                .Width     = 40
                .Height    = 20
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            WITH loc_oCnt.obj_4c_OptSNA.Buttons(2)
                .Caption   = "N"
                .BackStyle = 0
                .Top       = 3
                .Left      = 50
                .Width     = 40
                .Height    = 20
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            WITH loc_oCnt.obj_4c_OptSNA.Buttons(3)
                .Caption   = "A"
                .BackStyle = 0
                .Top       = 3
                .Left      = 97
                .Width     = 40
                .Height    = 20
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ConfigurarCntImprime")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE ConfigurarCntQuitas
    * Cria container flutuante cnt_4c_Quitas (Recebimento de Parcelas)
    * top=198, left=252, width=496, height=272 - Visible=.F.
    * Exibido por BtnQuitacaoHistClick
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCntQuitas(par_oPagina)
        LOCAL loc_oCnt, loc_oGrd, loc_oErro
        TRY
            par_oPagina.AddObject("cnt_4c_Quitas", "Container")
            loc_oCnt = par_oPagina.cnt_4c_Quitas
            WITH loc_oCnt
                .Top           = 198
                .Left          = 252
                .Width         = 496
                .Height        = 272
                .Visible       = .F.
                .BackColor     = RGB(212, 208, 200)
                .BorderWidth   = 1
                .SpecialEffect = 0
            ENDWITH

            *-- Label1 "Recebimento de Parcelas": top=5, left=39, width=418, height=20
            loc_oCnt.AddObject("lbl_4c_LblQuitasTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblQuitasTitulo
                .Top       = 5
                .Left      = 39
                .Width     = 418
                .Height    = 20
                .Caption   = "Recebimento de Parcelas"
                .FontName  = "Tahoma"
                .FontSize  = 10
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 128)
                .BackStyle = 0
            ENDWITH

            *-- grade (grid): top=34, left=13, width=469, height=180, columnCount=6
            SET NULL ON
            CREATE CURSOR cursor_4c_Baixas ;
                (Emps C(3) NULL, Dopes C(20) NULL, Numes C(6) NULL, ;
                 Valos N(12,2) NULL, Moedas C(3) NULL, Datarcs D NULL)
            SET NULL OFF

            loc_oCnt.AddObject("grd_4c_Grade", "Grid")
            loc_oGrd = loc_oCnt.grd_4c_Grade
            WITH loc_oGrd
                .Top      = 34
                .Left     = 13
                .Width    = 469
                .Height   = 180
                .ReadOnly = .T.
                .FontName = "Tahoma"
                .FontSize = 8
                .RecordMark   = .F.
                .DeleteMark   = .F.
            ENDWITH
            loc_oGrd.ColumnCount  = 6
            loc_oGrd.RecordSource = "cursor_4c_Baixas"

            *-- Reconfigurar ControlSources e Headers apos RecordSource
            loc_oGrd.Column1.ControlSource   = "cursor_4c_Baixas.Emps"
            loc_oGrd.Column2.ControlSource   = "cursor_4c_Baixas.Dopes"
            loc_oGrd.Column3.ControlSource   = "cursor_4c_Baixas.Numes"
            loc_oGrd.Column4.ControlSource   = "cursor_4c_Baixas.Valos"
            loc_oGrd.Column5.ControlSource   = "cursor_4c_Baixas.Moedas"
            loc_oGrd.Column6.ControlSource   = "cursor_4c_Baixas.Datarcs"
            loc_oGrd.Column1.Header1.Caption = "Emp"
            loc_oGrd.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
            loc_oGrd.Column3.Header1.Caption = "C" + CHR(243) + "digo"
            loc_oGrd.Column4.Header1.Caption = "Valor"
            loc_oGrd.Column5.Header1.Caption = "Moe"
            loc_oGrd.Column6.Header1.Caption = "Data"
            loc_oGrd.Column1.Width = 35
            loc_oGrd.Column2.Width = 120
            loc_oGrd.Column3.Width = 60
            loc_oGrd.Column4.Width = 80
            loc_oGrd.Column5.Width = 35
            loc_oGrd.Column6.Width = 70

            *-- cmd_grupo (Voltar): top=214, left=432, width=50, height=50, buttonCount=1
            loc_oCnt.AddObject("obj_4c_QuitasVoltar", "CommandGroup")
            WITH loc_oCnt.obj_4c_QuitasVoltar
                .Top         = 214
                .Left        = 432
                .Width       = 50
                .Height      = 50
                .ButtonCount = 1
                .BorderStyle = 0
                .SpecialEffect = 0
            ENDWITH
            WITH loc_oCnt.obj_4c_QuitasVoltar.Buttons(1)
                .Caption   = "OK"
                .Width     = 45
                .Height    = 45
                .Left      = 2
                .Top       = 2
                .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(loc_oCnt.obj_4c_QuitasVoltar, "Click", THIS, "BtnCntQuitasVoltarClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ConfigurarCntQuitas")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE TornarControlesVisiveis
    * Torna controles visiveis recursivamente.
    * EXCETO containers flutuantes alternados por botoes:
    *   - cnt_4c_Saldo, cnt_4c_Consulta, cnt_4c_Imprime, cnt_4c_Quitas
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_cNome, loc_p

        *-- PageFrame nao tem ControlCount, tem PageCount
        IF UPPER(par_oContainer.BaseClass) = "PAGEFRAME"
            FOR loc_p = 1 TO par_oContainer.PageCount
                THIS.TornarControlesVisiveis(par_oContainer.Pages(loc_p))
            ENDFOR
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) # "O"
                LOOP
            ENDIF

            loc_cNome = UPPER(loc_oControl.Name)

            *-- Pular containers flutuantes (Visible=.F. gerenciado por botoes)
            IF INLIST(loc_cNome, ;
                      "CNT_4C_SALDO",    ;
                      "CNT_4C_CONSULTA", ;
                      "CNT_4C_IMPRIME",  ;
                      "CNT_4C_QUITAS")
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                FOR loc_p = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                ENDFOR
            ELSE
                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF

        ENDFOR
    ENDPROC

    *==========================================================================
    * PROCEDURE AlternarPagina
    * Alterna entre Page1 (SALDO=1) e Page2 (HIST=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        TRY
            THIS.pgf_4c_1.ActivePage = par_nPagina
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE MontaGrade
    * Carrega dados de saldos de conta corrente no grd_saldo.
    * Equivale ao MontaGrade() do legado: query SigMvSlc+SigCdCli, aplica
    * filtro do optFiltro, reconfigura RecordSource e headers do grid.
    * par_cGrupo: codigo do grupo de contas (vazio = limpar grid)
    *==========================================================================
    PROCEDURE MontaGrade(par_cGrupo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oGrd, loc_nFiltro, loc_oErro

        loc_lSucesso = .F.

        IF gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_oGrd    = THIS.pgf_4c_1.Page1.grd_4c_Saldos
            loc_nFiltro = THIS.pgf_4c_1.Page1.obj_4c_OptFiltro.Value

            *-- Limpar RecordSource para proteger colunas durante recarga
            loc_oGrd.RecordSource = ""

            IF EMPTY(TRIM(par_cGrupo))
                *-- Sem grupo selecionado: apenas zerar grid
                SELECT cursor_4c_Saldos
                ZAP
            ELSE
                *-- Montar query SQL identica ao MontaGrade original
                loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
                           "a.Saldos, b.RClis, b.Situas, b.Cpfs, " + ;
                           "b.ContaMats, ' ' AS Matriz " + ;
                           "FROM SigMvSlc a, SigCdCli b " + ;
                           "WHERE a.Grupos = " + EscaparSQL(TRIM(par_cGrupo)) + ;
                           " AND a.Contas = b.IClis " + ;
                           "ORDER BY a.Contas, a.Moedas"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SaldosTemp") >= 1
                    SELECT cursor_4c_Saldos
                    ZAP
                    APPEND FROM DBF("cursor_4c_SaldosTemp")

                    IF USED("cursor_4c_SaldosTemp")
                        USE IN cursor_4c_SaldosTemp
                    ENDIF

                    *-- Aplicar filtro do optFiltro
                    SELECT cursor_4c_Saldos
                    DO CASE
                        CASE loc_nFiltro = 2
                            SET FILTER TO Saldos > 0
                        CASE loc_nFiltro = 3
                            SET FILTER TO Saldos < 0
                        OTHERWISE
                            SET FILTER TO
                    ENDCASE
                    GO TOP
                ELSE
                    MsgErro("Erro ao carregar saldos. Verifique a conex" + ;
                            CHR(227) + "o.", "Erro")
                ENDIF
            ENDIF

            *-- Reconfigurar RecordSource apos recarga
            loc_oGrd.ColumnCount = 7
            loc_oGrd.RecordSource = "cursor_4c_Saldos"

            *-- Reconfigurar ControlSources (RecordSource os redefine)
            loc_oGrd.Column1.ControlSource = "cursor_4c_Saldos.Contas"
            loc_oGrd.Column2.ControlSource = "cursor_4c_Saldos.Rclis"
            loc_oGrd.Column3.ControlSource = "cursor_4c_Saldos.Moedas"
            loc_oGrd.Column4.ControlSource = "cursor_4c_Saldos.Saldos"
            loc_oGrd.Column5.ControlSource = "cursor_4c_Saldos.Emps"
            loc_oGrd.Column6.ControlSource = "cursor_4c_Saldos.Cpfs"
            loc_oGrd.Column7.ControlSource = "cursor_4c_Saldos.Situas"

            *-- Reconfigurar headers (RecordSource os reseta)
            loc_oGrd.Column1.Header1.Caption = "Conta"
            loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oGrd.Column3.Header1.Caption = "Moeda"
            loc_oGrd.Column4.Header1.Caption = "Saldo"
            loc_oGrd.Column5.Header1.Caption = "Emp"
            loc_oGrd.Column6.Header1.Caption = "CPF/CNPJ"
            loc_oGrd.Column7.Header1.Caption = "M/F"

            SELECT cursor_4c_Saldos
            GO TOP
            loc_oGrd.Refresh()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em MontaGrade")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PROCEDURE ProcessaSaldo
    * Gera relatorio de saldos de conta corrente.
    * par_cTipo: 'E'=Excel, 'I'=Impressora, 'V'=Video (preview)
    * Equivale ao ProcessaSaldo() do legado (metodo Procedure 301 linhas).
    *==========================================================================
    PROCEDURE ProcessaSaldo(par_cTipo)
        LOCAL loc_cSQL, loc_cMoeda, loc_dDataLimite, loc_nOrdem
        LOCAL loc_lAscen, loc_cSitua, loc_lSaldoZero, loc_cImprime
        LOCAL loc_cArqXls, loc_dDataIni, loc_dDataFim, loc_oCnt, loc_oErro

        loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Saldo

        *-- Ler parametros do container cntSaldo
        loc_cMoeda      = TRIM(loc_oCnt.txt_4c__cd_moeda.Value)
        loc_dDataLimite = loc_oCnt.txt_4c__dtlimite.Value
        loc_nOrdem      = loc_oCnt.obj_4c_OptOrdem.Value
        loc_lAscen      = (loc_oCnt.chk_4c_ChkAscendente.Value = 1)
        loc_cSitua      = TRIM(loc_oCnt.txt_4c_Situa.Value)
        loc_lSaldoZero  = (loc_oCnt.chk_4c_CheckSaldo.Value = 1)
        loc_dDataIni    = THIS.pgf_4c_1.Page1.txt_4c_Dt_inicial.Value
        loc_dDataFim    = THIS.pgf_4c_1.Page1.txt_4c_Dt_final.Value

        *-- Validar moeda obrigatoria para ordenacao por moeda
        IF EMPTY(loc_cMoeda) AND loc_nOrdem = 3
            MsgAviso("A Moeda N" + CHR(227) + "o Foi Informada!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o!!!")
            RETURN
        ENDIF

        IF gnConnHandle <= 0
            MsgAviso("Sem conex" + CHR(227) + "o com o banco de dados.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        TRY
            *-- Mostrar indicador de processamento
            loc_oCnt.lbl_4c_Lb_Aguarde.Visible = .T.
            loc_oCnt.Refresh()

            *-- Montar SQL para relatorio
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, " + ;
                       "a.Saldos, b.RClis, b.Situas, b.Cpfs, b.ContaMats " + ;
                       "FROM SigMvSlc a, SigCdCli b " + ;
                       "WHERE a.Grupos = " + EscaparSQL(THIS.this_cGrupoOper) + ;
                       " AND a.Contas = b.IClis"

            IF !EMPTY(loc_cMoeda)
                loc_cSQL = loc_cSQL + " AND a.Moedas = " + EscaparSQL(loc_cMoeda)
            ENDIF

            IF !EMPTY(loc_cSitua)
                loc_cSQL = loc_cSQL + " AND b.Situas = " + EscaparSQL(loc_cSitua)
            ENDIF

            IF !loc_lSaldoZero
                loc_cSQL = loc_cSQL + " AND a.Saldos <> 0"
            ENDIF

            DO CASE
                CASE loc_nOrdem = 1
                    loc_cSQL = loc_cSQL + " ORDER BY a.Contas" + IIF(loc_lAscen, " ASC", " DESC")
                CASE loc_nOrdem = 2
                    loc_cSQL = loc_cSQL + " ORDER BY a.Moedas" + IIF(loc_lAscen, " ASC", " DESC")
                CASE loc_nOrdem = 3
                    loc_cSQL = loc_cSQL + " ORDER BY a.Saldos" + IIF(loc_lAscen, " ASC", " DESC")
                OTHERWISE
                    loc_cSQL = loc_cSQL + " ORDER BY a.Contas ASC"
            ENDCASE

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RelSaldos") >= 1
                DO CASE
                    CASE par_cTipo = "E"
                        *-- Exportar para Excel
                        loc_cArqXls = gc_4c_CaminhoBase + "relatorio_saldos.xls"
                        SELECT cursor_4c_RelSaldos
                        COPY TO (loc_cArqXls) TYPE XL5
                        MsgInfo("Arquivo Excel gerado: " + loc_cArqXls, "Excel")
                    CASE par_cTipo = "I" OR par_cTipo = "V"
                        *-- Relatorio visual ou impressao
                        loc_cImprime = IIF(par_cTipo = "I", "TO PRINT PROMPT", "PREVIEW")
                        REPORT FORM (gc_4c_CaminhoReports + "RelSaldos.frx") &loc_cImprime
                    OTHERWISE
                        *-- Nada
                ENDCASE

                IF USED("cursor_4c_RelSaldos")
                    USE IN cursor_4c_RelSaldos
                ENDIF
            ELSE
                MsgErro("Erro ao gerar relat" + CHR(243) + "rio de saldos.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ProcessaSaldo")
        ENDTRY

        loc_oCnt.lbl_4c_Lb_Aguarde.Visible = .F.
    ENDPROC

    *==========================================================================
    * Handlers de eventos - Pagina SALDO
    *==========================================================================

    *-- grp_operacao Click -> dispatcher por Value (1=Consultar, 2=Sair)
    PROCEDURE GrpOperacaoSaldoClick()
        LOCAL loc_nValue
        loc_nValue = THIS.pgf_4c_1.Page1.obj_4c_Grp_operacao.Value
        DO CASE
            CASE loc_nValue = 1
                THIS.BtnConsultarSaldoClick()
            CASE loc_nValue = 2
                THIS.Release()
        ENDCASE
    ENDPROC

    *==========================================================================
    * PROCEDURE BtnConsultarSaldoClick
    * Navega de SALDO (Page1) para HIST (Page2).
    * Constroi cursor CrSigMvCcr a partir de SigMvCcr + SigMvCpv com
    * intervalo de datas. Trata Matrizes. Configura grd_lancamento e
    * Cmb_Concilia. Equivale ao cmd_consulta.Click do legado (234 linhas).
    *==========================================================================
    PROCEDURE BtnConsultarSaldoClick()
        LOCAL loc_cCliente, loc_cGrupo, loc_cMoeda, loc_cGCM
        LOCAL loc_dDataI, loc_dDataF, loc_cDataI, loc_cDataF
        LOCAL loc_cSQL, loc_nRet, loc_lMatrizes, loc_nSal
        LOCAL loc_oPagHist, loc_oGrd, loc_oErro

        TRY
            IF !USED("cursor_4c_Saldos") OR RECCOUNT("cursor_4c_Saldos") = 0
                MsgAviso("Nenhum Registro Selecionado. Verifique Per" + CHR(237) + ;
                         "odo Informado...", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            SELECT cursor_4c_Saldos
            IF EOF()
                GO TOP
            ENDIF

            loc_cCliente = TRIM(cursor_4c_Saldos.Contas)
            loc_cGrupo   = TRIM(cursor_4c_Saldos.Grupos)
            loc_cMoeda   = TRIM(cursor_4c_Saldos.Moedas)

            IF EMPTY(loc_cCliente)
                MsgAviso("Nenhuma Conta/Saldo foi escolhida para consulta!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            THIS.this_cCliente   = loc_cCliente
            THIS.this_cGrupoOper = loc_cGrupo
            THIS.this_cOperacao  = "CONSULTA"

            *-- Copiar filtros para Page2
            loc_oPagHist = THIS.pgf_4c_1.Page2
            loc_oPagHist.txt_4c_GrupoHist.Value = THIS.pgf_4c_1.Page1.txt_4c_Grupo.Value
            loc_oPagHist.txt_4c_Moeda.Value     = loc_cMoeda
            loc_oPagHist.txt_4c_Hconta.Value    = loc_cCliente
            loc_oPagHist.txt_4c_Hdconta.Value   = TRIM(cursor_4c_Saldos.Rclis)
            loc_oPagHist.Refresh()

            *-- Preparar datas do periodo (inicio e fim)
            loc_dDataI = THIS.pgf_4c_1.Page1.txt_4c_Dt_inicial.Value
            loc_dDataF = THIS.pgf_4c_1.Page1.txt_4c_Dt_final.Value
            IF EMPTY(loc_dDataI) OR loc_dDataI < CTOD("01/01/1900")
                loc_dDataI = CTOD("01/01/1900")
            ENDIF
            IF EMPTY(loc_dDataF) OR loc_dDataF < CTOD("01/01/1900")
                loc_dDataF = CTOD("01/01/1900")
            ENDIF

            *-- Formatar datas para SQL (datetime range)
            loc_cDataI = "'" + TRANSFORM(DTOS(loc_dDataI), "@R 9999-99-99") + " 00:00:00'"
            loc_cDataF = "'" + TRANSFORM(DTOS(loc_dDataF), "@R 9999-99-99") + " 23:59:59'"

            *-- Limpar cursor anterior se existir
            IF USED("CrSigMvCcr")
                IF PEMSTATUS(THIS.pgf_4c_1.Page2, "grd_4c_Lancamento", 5)
                    THIS.pgf_4c_1.Page2.grd_4c_Lancamento.RecordSource = ""
                ENDIF
                USE IN CrSigMvCcr
            ENDIF

            *-- Criar cursor de matrizes (grupo/conta/moeda a processar)
            SET NULL ON
            CREATE CURSOR cursor_4c_Matrizes (Grupos C(10), Contas C(10), Moedas C(3))
            SET NULL OFF
            INSERT INTO cursor_4c_Matrizes (Grupos, Contas, Moedas) ;
                VALUES (loc_cGrupo, loc_cCliente, loc_cMoeda)

            *-- Verificar se a conta pertence a grupo de cobranca (Matriz/Filial)
            loc_lMatrizes = .F.
            IF TRIM(cursor_4c_Saldos.Matriz) # " " AND !EMPTY(cursor_4c_Saldos.Matriz)
                loc_lMatrizes = MsgConfirma( ;
                    "Esta Conta Pertence a Um Grupo de Cobran" + CHR(231) + "a." + CHR(13) + ;
                    "Deseja Processar Todas Contas do Grupo?", ;
                    "Empresa " + IIF(cursor_4c_Saldos.Matriz = "M", "Matriz", "Filial"))
            ENDIF
            THIS.this_lMatrizes = loc_lMatrizes

            IF loc_lMatrizes
                IF cursor_4c_Saldos.Matriz = "M"
                    loc_cSQL = "SELECT IClis, Grupos FROM SigCdCli " + ;
                               "WHERE ContaMats = " + EscaparSQL(loc_cCliente) + ;
                               " AND IClis <> " + EscaparSQL(loc_cCliente)
                ELSE
                    loc_cSQL = "SELECT IClis, Grupos FROM SigCdCli " + ;
                               "WHERE ContaMats = " + EscaparSQL(TRIM(cursor_4c_Saldos.ContaMats)) + ;
                               " AND IClis <> " + EscaparSQL(loc_cCliente)
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMat") < 1
                    MsgErro("Favor Reinicializar o Processo!", "Falha na Conex" + CHR(227) + "o (TmpMat)")
                    RETURN
                ENDIF
                SELECT cursor_4c_TmpMat
                SCAN
                    INSERT INTO cursor_4c_Matrizes (Grupos, Contas, Moedas) ;
                        VALUES (cursor_4c_TmpMat.Grupos, cursor_4c_TmpMat.IClis, loc_cMoeda)
                ENDSCAN
                IF USED("cursor_4c_TmpMat")
                    USE IN cursor_4c_TmpMat
                ENDIF
            ENDIF

            *-- Criar cursor base vazio com estrutura de SigMvCcr + campos extras
            loc_cSQL = "SELECT ' ' AS Tipo, a.Saldos AS SaldosP, a.* " + ;
                       "FROM SigMvCcr a " + ;
                       "WHERE 0 = 1"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccr") < 1
                MsgErro("Favor Reinicializar o Processo!", ;
                        "Falha na Conex" + CHR(227) + "o (TmpMccr)")
                RETURN
            ENDIF

            *-- Para cada conta/grupo/moeda, buscar lancamentos de SigMvCcr e SigMvCpv
            SELECT cursor_4c_Matrizes
            SCAN
                loc_cGCM = cursor_4c_Matrizes.Grupos + ;
                           cursor_4c_Matrizes.Contas + ;
                           cursor_4c_Matrizes.Moedas

                *-- Lancamentos realizados (SigMvCcr)
                loc_cSQL = "SELECT 'R' AS Tipo, a.Saldos AS SaldosP, a.* " + ;
                           "FROM SigMvCcr a " + ;
                           "WHERE a.GruConMoes = " + EscaparSQL(loc_cGCM) + ;
                           " AND a.Datas BETWEEN " + loc_cDataI + " AND " + loc_cDataF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMcc1") < 1
                    MsgErro("Favor Reinicializar o Processo!", ;
                            "Falha na Conex" + CHR(227) + "o (TmpMcc1)")
                    RETURN
                ENDIF

                *-- Previsoes (SigMvCpv)
                loc_cSQL = "SELECT 'P' AS Tipo, b.Saldos AS SaldosP, b.* " + ;
                           "FROM SigMvCpv b " + ;
                           "WHERE b.GruConMoes = " + EscaparSQL(loc_cGCM) + ;
                           " AND b.Datas BETWEEN " + loc_cDataI + " AND " + loc_cDataF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMcpv") < 1
                    MsgErro("Favor Reinicializar o Processo!", ;
                            "Falha na Conex" + CHR(227) + "o (TmpMcpv)")
                    RETURN
                ENDIF

                *-- Inserir lancamentos realizados no cursor base
                SELECT cursor_4c_TmpMcc1
                SCAN
                    SCATTER MEMVAR MEMO
                    INSERT INTO cursor_4c_TmpMccr FROM MEMVAR
                ENDSCAN

                *-- Inserir previsoes no cursor base
                SELECT cursor_4c_TmpMcpv
                SCAN
                    SCATTER MEMVAR MEMO
                    INSERT INTO cursor_4c_TmpMccr FROM MEMVAR
                ENDSCAN
            ENDSCAN

            *-- Limpar cursores temporarios
            IF USED("cursor_4c_TmpMcc1")
                USE IN cursor_4c_TmpMcc1
            ENDIF
            IF USED("cursor_4c_TmpMcpv")
                USE IN cursor_4c_TmpMcpv
            ENDIF
            IF USED("cursor_4c_Matrizes")
                USE IN cursor_4c_Matrizes
            ENDIF

            *-- Ordenar e criar cursor final CrSigMvCcr com campo Prorrogados
            GO TOP IN cursor_4c_TmpMccr

            SELECT *, .F. AS Prorrogados FROM cursor_4c_TmpMccr ;
                INTO CURSOR cursor_4c_TmpOrdenado ;
                ORDER BY Grupos, Contas, Moedas, Datas, Nopers

            SELECT cursor_4c_TmpOrdenado
            USE DBF("cursor_4c_TmpOrdenado") IN 0 ALIAS CrSigMvCcr AGAIN
            USE IN cursor_4c_TmpOrdenado

            USE IN cursor_4c_TmpMccr

            *-- Se Matrizes: consolidar contas e recalcular saldos
            IF THIS.this_lMatrizes
                LOCAL loc_cMat
                loc_cMat = PADR(IIF(cursor_4c_Saldos.Matriz = "M", ;
                                    loc_cCliente, ;
                                    TRIM(cursor_4c_Saldos.ContaMats)), 10)
                UPDATE CrSigMvCcr ;
                    SET Contas = loc_cMat, ;
                        GruConMoes = CrSigMvCcr.Grupos + loc_cMat + CrSigMvCcr.Moedas
            ENDIF

            *-- Marcar titulos Prorrogados (verificar SigOpMvv)
            SELECT CrSigMvCcr
            SCAN
                loc_cSQL = "SELECT * FROM SigOpMvv " + ;
                           "WHERE EmpDopNcs = " + EscaparSQL(CrSigMvCcr.EmpDopNcs)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpMvv") < 1
                    MsgErro("Favor Reinicializar o Processo!", ;
                            "Falha na Conex" + CHR(227) + "o (LocalOpMvv)")
                    RETURN
                ENDIF
                IF RECCOUNT("cursor_4c_LocalOpMvv") > 0
                    REPLACE Prorrogados WITH .T. IN CrSigMvCcr
                ENDIF
            ENDSCAN
            IF USED("cursor_4c_LocalOpMvv")
                USE IN cursor_4c_LocalOpMvv
            ENDIF

            *-- Criar indices para navegacao e filtros
            SELECT CrSigMvCcr
            INDEX ON Datas TAG Vencs
            INDEX ON Valors TAG Valor
            INDEX ON Hists TAG Historico
            INDEX ON GruConMoes + DTOS(Datas) + CidChaves TAG GruConMoe FOR Tipo = "R"
            INDEX ON GruConMoes + DTOS(DataConcs) + CidChaves TAG GruConMoec FOR Concs
            INDEX ON GruConMoes + DTOS(Datas) + CidChaves TAG GruConMoen FOR !Concs
            INDEX ON GruConMoes + DTOS(Datas) + CidChaves TAG GruConMoeP
            SET ORDER TO GruConMoe
            GO BOTTOM

            IF RECCOUNT() > 0
                *-- Se Matrizes: recalcular saldos acumulados
                IF THIS.this_lMatrizes
                    SELECT CrSigMvCcr
                    GO TOP
                    loc_nSal = 0
                    SCAN
                        IF CrSigMvCcr.Opers = "D"
                            loc_nSal = loc_nSal + ABS(CrSigMvCcr.Valors)
                        ELSE
                            loc_nSal = loc_nSal - ABS(CrSigMvCcr.Valors)
                        ENDIF
                        REPLACE Saldos WITH loc_nSal
                    ENDSCAN
                ENDIF

                *-- Configurar grd_4c_Lancamento com novo cursor
                IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                    loc_oGrd = loc_oPagHist.grd_4c_Lancamento
                    loc_oGrd.RecordSource = "CrSigMvCcr"

                    *-- Reconfirmar TODOS os ControlSources apos RecordSource
                    loc_oGrd.Column1.ControlSource  = "CrSigMvCcr.Datas"
                    loc_oGrd.Column2.ControlSource  = "CrSigMvCcr.Hists"
                    loc_oGrd.Column3.ControlSource  = "CrSigMvCcr.Valors"
                    loc_oGrd.Column4.ControlSource  = "CrSigMvCcr.Opers"
                    loc_oGrd.Column5.ControlSource  = "CrSigMvCcr.Emps"
                    loc_oGrd.Column6.ControlSource  = "CrSigMvCcr.Saldos"
                    loc_oGrd.Column7.ControlSource  = "CrSigMvCcr.Docus"
                    loc_oGrd.Column8.ControlSource  = "CrSigMvCcr.NFs"
                    loc_oGrd.Column9.ControlSource  = "CrSigMvCcr.Titulos"
                    loc_oGrd.Column10.ControlSource = "CrSigMvCcr.Tipo"

                    *-- DynamicForeColor: Cancelado=Vermelho, Conciliado=Azul, Baixado=Verde, Prorrogado=Laranja, Normal=Preto
                    LOCAL loc_i, loc_cForeExpr, loc_cBackExpr
                    loc_cForeExpr = "IIF(CrSigMvCcr.TitCancs=1,RGB(255,0,0)," + ;
                                    "IIF(CrSigMvCcr.Concs,RGB(0,0,255)," + ;
                                    "IIF(CrSigMvCcr.Pagos='0',RGB(0,128,0)," + ;
                                    "IIF(CrSigMvCcr.Prorrogados,RGB(255,128,0)," + ;
                                    "RGB(0,0,0)))))"
                    loc_cBackExpr = "IIF(CrSigMvCcr.Tipo='P',RGB(245,251,136)," + ;
                                    "IIF(!EMPTY(CrSigMvCcr.DtAudits),RGB(220,255,220)," + ;
                                    "RGB(255,255,255)))"
                    FOR loc_i = 1 TO loc_oGrd.ColumnCount
                        loc_oGrd.Columns(loc_i).DynamicForeColor = loc_cForeExpr
                        loc_oGrd.Columns(loc_i).DynamicBackColor = loc_cBackExpr
                    ENDFOR

                    loc_oGrd.Refresh()
                    loc_oGrd.SetFocus()
                ENDIF

                *-- Configurar Cmb_Concilia com opcoes de filtro
                WITH loc_oPagHist.cmb_4c_Concilia
                    .Clear()
                    .AddItem("Lan" + CHR(231) + "amentos Realizados")
                    .AddItem("S" + CHR(243) + " Conciliados")
                    .AddItem("N" + CHR(227) + "o Conciliados")
                    .AddItem("Saldo Di" + CHR(225) + "rio - Todos")
                    .AddItem("Saldo Di" + CHR(225) + "rio - Conciliados")
                    .AddItem("Saldo Di" + CHR(225) + "rio - N" + CHR(227) + "o Conciliados")
                    .AddItem("Realizado e Previs" + CHR(227) + "o")
                    .Value = "Lan" + CHR(231) + "amentos Realizados"
                ENDWITH

                *-- Habilitar Page2 e navegar para ela
                loc_oPagHist.Enabled = .T.
                THIS.pgf_4c_1.ActivePage = 2
            ELSE
                MsgAviso("Nenhum Registro Selecionado. Verifique Per" + CHR(237) + ;
                         "odo Informado...", "Aten" + CHR(231) + CHR(227) + "o")
                THIS.pgf_4c_1.Page1.grd_4c_Saldos.SetFocus()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnConsultarSaldoClick")
        ENDTRY
    ENDPROC

    *-- Grid KeyPress: ENTER?Consultar, F5?Procurar, F6?Imprimir
    PROCEDURE GrdSaldoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        DO CASE
            CASE par_nKeyCode = 13
                THIS.BtnConsultarSaldoClick()
            CASE par_nKeyCode = -4
                THIS.BtnProcurarSaldoClick()
            CASE par_nKeyCode = -5
                THIS.BtnImprimirSaldoClick()
        ENDCASE
    ENDPROC

    *-- cmd_procurar Click -> Mostrar cntConsulta (busca por conta)
    *   Equivale ao cmd_procurar.Click do legado
    PROCEDURE BtnProcurarSaldoClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_1.Page1
        loc_oPag.cmd_4c_Cmd_procurar.Enabled  = .F.
        loc_oPag.cmd_4c_Com_Imprimir2.Enabled = .F.
        loc_oPag.obj_4c_Grp_operacao.Enabled  = .F.
        loc_oPag.grd_4c_Saldos.Enabled        = .F.
        loc_oPag.cnt_4c_Consulta.txt_4c__ds_conta.Value = ""
        loc_oPag.cnt_4c_Consulta.Visible      = .T.
        loc_oPag.cnt_4c_Consulta.ZOrder(0)
        loc_oPag.cnt_4c_Consulta.Refresh()
        loc_oPag.cnt_4c_Consulta.txt_4c_Cd_Conta.SetFocus()
    ENDPROC

    *-- Com_Imprimir2 Click -> Mostrar cntSaldo (opcoes de impressao)
    *   Equivale ao Com_Imprimir2.Click do legado
    PROCEDURE BtnImprimirSaldoClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_1.Page1
        loc_oPag.cmd_4c_Cmd_procurar.Enabled  = .F.
        loc_oPag.cmd_4c_Com_Imprimir2.Enabled = .F.
        loc_oPag.obj_4c_Grp_operacao.Enabled  = .F.
        loc_oPag.grd_4c_Saldos.Enabled        = .F.
        loc_oPag.cnt_4c_Saldo.Visible         = .T.
        loc_oPag.cnt_4c_Saldo.ZOrder(0)
        loc_oPag.cnt_4c_Saldo.Refresh()
        loc_oPag.cnt_4c_Saldo.txt_4c__dtlimite.Value = CTOD("  /  /  ")
        loc_oPag.cnt_4c_Saldo.txt_4c__cd_moeda.SetFocus()
    ENDPROC

    *-- optFiltro InteractiveChange -> recarregar grid com novo filtro
    *   Equivale ao optFiltro.InteractiveChange do legado
    PROCEDURE OptFiltroSaldoChange()
        TRY
            THIS.MontaGrade(TRIM(THIS.pgf_4c_1.Page1.txt_4c_Grupo.Value))
            IF USED("cursor_4c_Saldos")
                SELECT cursor_4c_Saldos
                GO TOP
            ENDIF
            THIS.pgf_4c_1.Page1.grd_4c_Saldos.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em OptFiltroSaldoChange")
        ENDTRY
    ENDPROC

    *-- TxtGrupo KeyPress -> ENTER/TAB carrega grade pelo codigo de grupo
    *   Equivale ao Get_Grupo.Valid do legado (via KeyPress)
    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_cGrupo = TRIM(THIS.pgf_4c_1.Page1.txt_4c_Grupo.Value)
            THIS.this_cGrupoOper = loc_cGrupo
            THIS.MontaGrade(loc_cGrupo)
            THIS.pgf_4c_1.Page1.grd_4c_Saldos.Refresh()
        ENDIF
    ENDPROC

    *-- TxtDGrupo KeyPress -> ENTER/TAB recarrega grade (descricao apenas leitura)
    *   Equivale ao Get_DGrupo.Valid do legado (via KeyPress)
    PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.MontaGrade(TRIM(THIS.pgf_4c_1.Page1.txt_4c_Grupo.Value))
            THIS.pgf_4c_1.Page1.grd_4c_Saldos.Refresh()
        ENDIF
    ENDPROC

    *-- GrdSaldo AfterRowColChange -> capturar conta e grupo selecionados
    *   Necessario para passagem de contexto para Page2 (HIST)
    PROCEDURE GrdSaldoAfterRowColChange(par_nColIndex)
        TRY
            IF USED("cursor_4c_Saldos") AND !EOF("cursor_4c_Saldos")
                SELECT cursor_4c_Saldos
                THIS.this_cCliente   = TRIM(cursor_4c_Saldos.Contas)
                THIS.this_cGrupoOper = TRIM(cursor_4c_Saldos.Grupos)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GrdSaldoAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Handlers - Container cntSaldo (relatorio de saldos)
    *==========================================================================

    *-- TxtCdMoeda KeyPress -> lookup moeda pelo codigo
    PROCEDURE TxtCdMoedaSaldoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cMoeda
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oCnt  = THIS.pgf_4c_1.Page1.cnt_4c_Saldo
            loc_cMoeda = TRIM(loc_oCnt.txt_4c__cd_moeda.Value)
            IF !EMPTY(loc_cMoeda) AND gnConnHandle > 0
                THIS.AbrirLookupMoedaSaldo(loc_oCnt, loc_cMoeda, "cmoes")
            ELSE
                loc_oCnt.txt_4c__ds_moeda.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *-- TxtDsMoeda KeyPress -> lookup moeda pela descricao
    PROCEDURE TxtDsMoedaSaldoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cDesc
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oCnt  = THIS.pgf_4c_1.Page1.cnt_4c_Saldo
            loc_cDesc = TRIM(loc_oCnt.txt_4c__ds_moeda.Value)
            IF !EMPTY(loc_cDesc) AND gnConnHandle > 0
                THIS.AbrirLookupMoedaSaldo(loc_oCnt, loc_cDesc, "dmoes")
            ELSE
                loc_oCnt.txt_4c__cd_moeda.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *-- AbrirLookupMoedaSaldo - abre FormBuscaAuxiliar para SigCdMoe
    PROCEDURE AbrirLookupMoedaSaldo(par_oCnt, par_cValor, par_cCampoBusca)
        LOCAL loc_oBusca, loc_oErro
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
                "cursor_4c_Busca", par_cCampoBusca, par_cValor, "Moeda")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    GO TOP
                    par_oCnt.txt_4c__cd_moeda.Value = TRIM(cursor_4c_Busca.cmoes)
                    par_oCnt.txt_4c__ds_moeda.Value = TRIM(cursor_4c_Busca.dmoes)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AbrirLookupMoedaSaldo")
        ENDTRY
    ENDPROC

    *-- TxtSituacao KeyPress -> lookup SigCdCst (Situacao de Conta)
    *   Equivale ao Get_Situa.Valid do legado que usa fwBuscaExt em SigCdCst
    PROCEDURE TxtSituacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oCnt
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Saldo
            loc_cVal = TRIM(loc_oCnt.txt_4c_Situa.Value)
            IF !EMPTY(loc_cVal)
                THIS.AbrirLookupSituacao(loc_oCnt, loc_cVal)
            ELSE
                loc_oCnt.txt_4c_Situa.Value = ""
            ENDIF
            loc_oCnt.txt_4c_Situa.Refresh()
        ENDIF
    ENDPROC

    *-- AbrirLookupSituacao - abre FormBuscaAuxiliar para SigCdCst (situacao)
    *   Legado: fwBuscaExt com SigCdCst, campo Codigos, colunas Codigos+Descrs
    PROCEDURE AbrirLookupSituacao(par_oCnt, par_cValor)
        LOCAL loc_oBusca, loc_oErro
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCst", ;
                "cursor_4c_Busca", "Codigos", par_cValor, ;
                "Situa" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    GO TOP
                    par_oCnt.txt_4c_Situa.Value = TRIM(cursor_4c_Busca.Codigos)
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AbrirLookupSituacao")
        ENDTRY
    ENDPROC

    *-- OptOrdem InteractiveChange -> habilitar/desabilitar chkAscendente
    PROCEDURE OptOrdemSaldoChange()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Saldo
        loc_oCnt.chk_4c_ChkAscendente.Enabled = (loc_oCnt.obj_4c_OptOrdem.Value = 3)
    ENDPROC

    *-- BtnSaldoCntOK Click -> fechar cntSaldo e reabilitar controles da pagina
    PROCEDURE BtnSaldoCntOKClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_1.Page1
        loc_oPag.cnt_4c_Saldo.Visible         = .F.
        loc_oPag.cmd_4c_Cmd_procurar.Enabled  = .T.
        loc_oPag.cmd_4c_Com_Imprimir2.Enabled = .T.
        loc_oPag.obj_4c_Grp_operacao.Enabled  = .T.
        loc_oPag.grd_4c_Saldos.Enabled        = .T.
        loc_oPag.grd_4c_Saldos.SetFocus()
    ENDPROC

    *-- BtnSaldoExcel -> gerar Excel
    PROCEDURE BtnSaldoExcelClick()
        THIS.ProcessaSaldo("E")
    ENDPROC

    *-- BtnSaldoImprimir -> imprimir
    PROCEDURE BtnSaldoImprimirClick()
        THIS.ProcessaSaldo("I")
    ENDPROC

    *-- BtnSaldoVisual -> visualizar em tela
    PROCEDURE BtnSaldoVisualClick()
        THIS.ProcessaSaldo("V")
    ENDPROC

    *==========================================================================
    * Handlers - Container cntConsulta (busca por conta)
    *==========================================================================

    *-- TxtCdConta KeyPress -> verificar conta no grupo atual
    *   Equivale ao Get_Cd_Conta.Valid do legado (via KeyPress)
    PROCEDURE TxtCdContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cConta, loc_cSQL, loc_nRet, loc_oErro
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oCnt   = THIS.pgf_4c_1.Page1.cnt_4c_Consulta
            loc_cConta = TRIM(loc_oCnt.txt_4c_Cd_Conta.Value)

            IF !EMPTY(loc_cConta) AND gnConnHandle > 0
                TRY
                    *-- Verificar se conta existe no grupo
                    loc_cSQL = "SELECT a.grupos, a.contas " + ;
                               "FROM SigMvSlc a " + ;
                               "WHERE a.grupos = " + EscaparSQL(THIS.this_cGrupoOper) + ;
                               " AND a.Contas = " + EscaparSQL(loc_cConta)

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaTemp")
                    IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_ContaTemp") > 0
                        *-- Buscar descricao na tabela de clientes
                        loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
                                   "WHERE IClis = " + EscaparSQL(loc_cConta)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliTemp") >= 1
                            IF RECCOUNT("cursor_4c_CliTemp") > 0
                                SELECT cursor_4c_CliTemp
                                GO TOP
                                loc_oCnt.txt_4c__ds_conta.Value = TRIM(cursor_4c_CliTemp.RClis)
                            ENDIF
                            IF USED("cursor_4c_CliTemp")
                                USE IN cursor_4c_CliTemp
                            ENDIF
                        ENDIF
                    ELSE
                        MsgAviso("Acesso Negado...", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_oCnt.txt_4c_Cd_Conta.Value  = " "
                        loc_oCnt.txt_4c__ds_conta.Value = ""
                    ENDIF
                    IF USED("cursor_4c_ContaTemp")
                        USE IN cursor_4c_ContaTemp
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro(loc_oErro.Message, "Erro em TxtCdContaKeyPress")
                ENDTRY
            ELSE
                loc_oCnt.txt_4c__ds_conta.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *-- TxtDsConta KeyPress -> busca conta por descricao
    *   Equivale ao get_ds_conta.Valid do legado (via KeyPress)
    PROCEDURE TxtDsContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cDesc, loc_cSQL, loc_nRet, loc_oErro
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oCnt  = THIS.pgf_4c_1.Page1.cnt_4c_Consulta
            loc_cDesc = TRIM(loc_oCnt.txt_4c__ds_conta.Value)

            IF !EMPTY(loc_cDesc) AND gnConnHandle > 0
                TRY
                    loc_cSQL = "SELECT a.grupos, a.contas, b.RClis " + ;
                               "FROM SigMvSlc a, SigCdCli b " + ;
                               "WHERE a.grupos = " + EscaparSQL(THIS.this_cGrupoOper) + ;
                               " AND a.Contas = b.IClis " + ;
                               " AND b.RClis LIKE " + EscaparSQL("%" + loc_cDesc + "%")

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DsContaTemp")
                    IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_DsContaTemp") > 0
                        SELECT cursor_4c_DsContaTemp
                        GO TOP
                        loc_oCnt.txt_4c_Cd_Conta.Value  = TRIM(cursor_4c_DsContaTemp.contas)
                        loc_oCnt.txt_4c__ds_conta.Value = TRIM(cursor_4c_DsContaTemp.RClis)
                    ELSE
                        MsgAviso("Acesso Negado...", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_oCnt.txt_4c_Cd_Conta.Value  = ""
                        loc_oCnt.txt_4c__ds_conta.Value = ""
                    ENDIF
                    IF USED("cursor_4c_DsContaTemp")
                        USE IN cursor_4c_DsContaTemp
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro(loc_oErro.Message, "Erro em TxtDsContaKeyPress")
                ENDTRY
            ENDIF
        ENDIF
    ENDPROC

    *-- BtnConsultaCnt Click -> OK (posicionar no registro) ou Cancelar
    *   Equivale ao cntConsulta.cmd_grupo.Click do legado (2 handlers: OK e Cancelar)
    PROCEDURE BtnConsultaCntClick()
        LOCAL loc_oPag, loc_oCnt, loc_cConta
        loc_oPag   = THIS.pgf_4c_1.Page1
        loc_oCnt   = loc_oPag.cnt_4c_Consulta
        loc_cConta = TRIM(loc_oCnt.txt_4c_Cd_Conta.Value)

        IF !EMPTY(loc_cConta)
            *-- Posicionar cursor no registro da conta (botao OK)
            IF USED("cursor_4c_Saldos")
                SELECT cursor_4c_Saldos
                LOCATE FOR TRIM(Contas) = loc_cConta
            ENDIF
        ENDIF

        *-- Fechar container e reabilitar controles da pagina
        loc_oPag.cmd_4c_Cmd_procurar.Enabled  = .T.
        loc_oPag.cmd_4c_Com_Imprimir2.Enabled = .T.
        loc_oPag.obj_4c_Grp_operacao.Enabled  = .T.
        loc_oPag.grd_4c_Saldos.Enabled        = .T.
        loc_oCnt.Visible = .F.
        loc_oPag.grd_4c_Saldos.SetFocus()
    ENDPROC

    *==========================================================================
    * Handlers de eventos - Pagina HIST (Page2)
    * Fase 5: implementacao completa de todos os handlers.
    *==========================================================================

    *-- Cmd_Consulta Click -> validar acesso e abrir SigOpAcc em modo CONSULTAR
    PROCEDURE BtnConsultaHistClick()
        LOCAL loc_oErro, loc_oPagHist, loc_cSQL, loc_lOk
        PRIVATE pEmp, pNoper
        loc_lOk = .F.
        TRY
            IF USED("CrSigMvCcr") AND !EOF("CrSigMvCcr")
                pEmp   = CrSigMvCcr.Emps
                pNoper = CrSigMvCcr.Nopers

                *-- Requery CrAltcc: todas as pernas do lancamento
                loc_cSQL = "SELECT * FROM SigMvCcr WHERE Emps = " + EscaparSQL(pEmp) + ;
                           " AND Nopers = " + STR(pNoper)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Altcc") >= 1
                    *-- Verificar acesso contabil e a conta
                    SELECT cursor_4c_Altcc
                    GO TOP
                    IF fAcessoContab(gc_4c_UsuarioLogado, "C", cursor_4c_Altcc.SGrupos)
                        IF USED("cursor_4c_Saldos") AND ;
                           fAcessoContas(gc_4c_UsuarioLogado, ;
                                         TRIM(cursor_4c_Saldos.Grupos), "C", ;
                                         TRIM(cursor_4c_Saldos.Contas))
                            loc_lOk = .T.
                        ELSE
                            IF USED("cursor_4c_Saldos")
                                MsgAviso("Acesso a conta Negado...", "")
                            ENDIF
                        ENDIF
                    ELSE
                        MsgAviso("Acesso ao Grupo Negado...", "")
                    ENDIF
                ELSE
                    MsgErro("Favor Reinicializar o Processo!", ;
                            "Falha na Conex" + CHR(227) + "o (CrAltcc)")
                ENDIF
            ENDIF

            IF loc_lOk
                *-- Abrir form de visualizacao
                SELECT cursor_4c_Altcc
                GO TOP
                SCATTER MEMVAR MEMO
                DO FORM SigOpAcc WITH THIS, "CONSULTAR"

                *-- Refresh grade apos retorno
                SELECT CrSigMvCcr
                loc_oPagHist = THIS.pgf_4c_1.Page2
                IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                    loc_oPagHist.grd_4c_Lancamento.Refresh()
                    loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnConsultaHistClick")
        ENDTRY
    ENDPROC

    *-- Cmd_Alterar Click -> validar todas as regras e abrir SigOpAcc em modo ALTERAR
    PROCEDURE BtnAlterarHistClick()
        LOCAL loc_oErro, loc_oPagHist, loc_cSQL, loc_lSaida, loc_cComple
        LOCAL loc_nTpAltera, loc_lOkDt, loc_lProsseguir
        PRIVATE pEmp, pNoper
        TRY
            loc_lProsseguir = .F.
            loc_lSaida      = .F.
            loc_nTpAltera   = 0

            IF USED("CrSigMvCcr") AND !EOF("CrSigMvCcr") AND CrSigMvCcr.Tipo # "P"
                THIS.DesabContainer()
                SELECT CrSigMvCcr

                IF !EOF()
                    pEmp   = CrSigMvCcr.Emps
                    pNoper = CrSigMvCcr.Nopers

                    *-- Requery CrAltcc: todas as pernas do lancamento
                    loc_cSQL = "SELECT * FROM SigMvCcr WHERE Emps = " + EscaparSQL(pEmp) + ;
                               " AND Nopers = " + STR(pNoper)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Altcc") >= 1
                        loc_lProsseguir = .T.
                    ELSE
                        MsgErro("Favor Reinicializar o Processo!", ;
                                "Falha na Conex" + CHR(227) + "o (CrAltcc)")
                    ENDIF
                ENDIF
            ENDIF

            *-- Validar TODAS as pernas do lancamento
            IF loc_lProsseguir
                SELECT cursor_4c_Altcc
                GO TOP
                DO WHILE !EOF() AND !loc_lSaida
                    IF cursor_4c_Altcc.Opers # CrSigMvCcr.Opers
                        loc_cComple = "( Contra Partida )"
                    ELSE
                        loc_cComple = " "
                    ENDIF

                    IF cursor_4c_Altcc.Autos
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
                                 "lida !! Movimenta" + CHR(231) + CHR(227) + ;
                                 "o Autom" + CHR(225) + "tica !" + loc_cComple, "")
                        loc_lSaida = .T.
                    ENDIF
                    IF cursor_4c_Altcc.Concs AND !loc_lSaida
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
                                 "lida !! Movimenta" + CHR(231) + CHR(227) + ;
                                 "o Conciliada !" + loc_cComple, "")
                        loc_lSaida = .T.
                    ENDIF
                    loc_lOkDt = fVerificaBloqueio(cursor_4c_Altcc.Datas, gnConnHandle) <= 0
                    IF !loc_lOkDt AND !loc_lSaida
                        MsgAviso("Periodo Bloqueado!", "")
                        loc_lSaida = .T.
                    ENDIF
                    IF !fAcessoContab(gc_4c_UsuarioLogado, "C", cursor_4c_Altcc.SGrupos) AND !loc_lSaida
                        MsgAviso("Acesso ao Grupo Negado..." + loc_cComple, "")
                        loc_lSaida = .T.
                    ENDIF
                    IF !fAcessoContas(gc_4c_UsuarioLogado, cursor_4c_Altcc.SGrupos, "C", cursor_4c_Altcc.SContas) AND !loc_lSaida
                        MsgAviso("Acesso a Conta Negado..." + loc_cComple, "")
                        loc_lSaida = .T.
                    ENDIF
                    IF cursor_4c_Altcc.ContaPgs = 1 AND cursor_4c_Altcc.ValPags # 0 AND !loc_lSaida
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
                                 "lida !! Movimenta" + CHR(231) + CHR(227) + ;
                                 "o j" + CHR(225) + " foi Baixada!" + loc_cComple, "")
                        loc_lSaida = .T.
                    ENDIF
                    IF !EMPTY(cursor_4c_Altcc.Auditors) AND !loc_lSaida
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
                                 "lida !! Movimenta" + CHR(231) + CHR(227) + ;
                                 "o Auditada!", "")
                        loc_lSaida = .T.
                    ENDIF
                    SELECT cursor_4c_Altcc
                    SKIP
                ENDDO

                *-- Verificar se contra-partida ja foi baixada -> altera parcial
                SELECT cursor_4c_Altcc
                GO TOP
                SKIP
                IF !EOF() AND cursor_4c_Altcc.ContaPgs = 1 AND cursor_4c_Altcc.ValPags # 0
                    loc_nTpAltera = 1
                ENDIF

                IF !loc_lSaida
                    SELECT cursor_4c_Altcc
                    GO TOP
                    SCATTER MEMVAR MEMO
                    DO FORM SigOpAcc WITH THIS, "ALTERAR", loc_nTpAltera
                    THIS.CmbConciliaHistChange()
                ENDIF

                SELECT CrSigMvCcr
                LOCATE FOR Nopers = pNoper
                loc_oPagHist = THIS.pgf_4c_1.Page2
                IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                    loc_oPagHist.grd_4c_Lancamento.Refresh()
                    loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnAlterarHistClick")
        ENDTRY
    ENDPROC

    *-- Cmd_Excluir Click -> validar todas as regras e abrir SigOpAcc em modo EXCLUIR
    PROCEDURE BtnExcluirHistClick()
        LOCAL loc_oErro, loc_oPagHist, loc_cSQL, loc_lOk, loc_cComple, loc_lOkDt
        LOCAL loc_lProsseguir
        PRIVATE pEmp, pNoper
        TRY
            loc_lProsseguir = .F.
            loc_lOk = .T.

            IF USED("CrSigMvCcr") AND !EOF("CrSigMvCcr") AND CrSigMvCcr.Tipo # "P"
                SELECT CrSigMvCcr
                THIS.DesabContainer()

                IF !EOF()
                    pEmp   = CrSigMvCcr.Emps
                    pNoper = CrSigMvCcr.Nopers

                    *-- Requery CrAltcc: todas as pernas do lancamento
                    loc_cSQL = "SELECT * FROM SigMvCcr WHERE Emps = " + EscaparSQL(pEmp) + ;
                               " AND Nopers = " + STR(pNoper)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Altcc") >= 1
                        loc_lProsseguir = .T.
                    ELSE
                        MsgErro("Favor Reinicializar o Processo!", ;
                                "Falha na Conex" + CHR(227) + "o (CrAltcc)")
                    ENDIF
                ENDIF
            ENDIF

            *-- Validar TODAS as pernas
            IF loc_lProsseguir
                SELECT cursor_4c_Altcc
                GO TOP
                DO WHILE !EOF() AND loc_lOk
                    IF cursor_4c_Altcc.Opers # CrSigMvCcr.Opers
                        loc_cComple = "( Contra Partida )"
                    ELSE
                        loc_cComple = " "
                    ENDIF

                    loc_lOkDt = fVerificaBloqueio(cursor_4c_Altcc.Datas, gnConnHandle) <= 0
                    IF !loc_lOkDt
                        MsgAviso("Periodo Bloqueado!", "")
                        loc_lOk = .F.
                    ENDIF
                    IF cursor_4c_Altcc.Autos AND loc_lOk
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
                                 "lida !! Movimenta" + CHR(231) + CHR(227) + ;
                                 "o Autom" + CHR(225) + "tica !" + loc_cComple, "")
                        loc_lOk = .F.
                    ENDIF
                    IF cursor_4c_Altcc.Concs AND loc_lOk
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
                                 "lida !! Movimenta" + CHR(231) + CHR(227) + ;
                                 "o Conciliada !" + loc_cComple, "")
                        loc_lOk = .F.
                    ENDIF
                    IF !fAcessoContab(gc_4c_UsuarioLogado, "C", cursor_4c_Altcc.SGrupos) AND loc_lOk
                        MsgAviso("Acesso ao grupo Negado...", "")
                        loc_lOk = .F.
                    ENDIF
                    IF !fAcessoContas(gc_4c_UsuarioLogado, cursor_4c_Altcc.SGrupos, "C", cursor_4c_Altcc.SContas) AND loc_lOk
                        MsgAviso("Acesso a conta Negado...", "")
                        loc_lOk = .F.
                    ENDIF
                    IF cursor_4c_Altcc.ContaPgs = 1 AND cursor_4c_Altcc.ValPags # 0 AND loc_lOk
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
                                 "lida !! Movimenta" + CHR(231) + CHR(227) + ;
                                 "o j" + CHR(225) + " foi Baixada!" + loc_cComple, "")
                        loc_lOk = .F.
                    ENDIF
                    IF !EMPTY(cursor_4c_Altcc.Auditors) AND loc_lOk
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
                                 "lida !! Movimenta" + CHR(231) + CHR(227) + ;
                                 "o Auditada!", "")
                        loc_lOk = .F.
                    ENDIF
                    SELECT cursor_4c_Altcc
                    SKIP
                ENDDO

                SELECT cursor_4c_Altcc
                GO TOP
                IF loc_lOk AND !EOF()
                    SCATTER MEMVAR MEMO
                    DO FORM SigOpAcc WITH THIS, "EXCLUIR"
                    THIS.CmbConciliaHistChange()
                ENDIF

                SELECT CrSigMvCcr
                LOCATE FOR Nopers = pNoper
                loc_oPagHist = THIS.pgf_4c_1.Page2
                IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                    loc_oPagHist.grd_4c_Lancamento.Refresh()
                    loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnExcluirHistClick")
        ENDTRY
    ENDPROC

    *-- cmd_impressao Click -> configurar e exibir cnt_4c_Imprime
    PROCEDURE BtnImpressaoHistClick()
        LOCAL loc_oErro, loc_oPagHist, loc_oCnt
        TRY
            THIS.DesabContainer()
            loc_oPagHist = THIS.pgf_4c_1.Page2

            *-- Desabilitar Sair durante impressao
            IF PEMSTATUS(loc_oPagHist, "obj_4c_Grp_operacao", 5)
                loc_oPagHist.obj_4c_Grp_operacao.Buttons(1).Enabled = .F.
            ENDIF

            *-- Configurar e exibir cnt_4c_Imprime
            IF PEMSTATUS(loc_oPagHist, "cnt_4c_Imprime", 5)
                loc_oCnt = loc_oPagHist.cnt_4c_Imprime
                WITH loc_oCnt
                    IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_final", 5)
                        .txt_4c_Dt_final.Value = DATE()
                    ENDIF
                    IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_inicial", 5)
                        .txt_4c_Dt_inicial.Refresh()
                    ENDIF
                    IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_final", 5)
                        .txt_4c_Dt_final.Refresh()
                    ENDIF
                    IF PEMSTATUS(loc_oCnt, "chk_4c_Grupo", 5)
                        .chk_4c_Grupo.Value = 0
                    ENDIF
                    IF PEMSTATUS(loc_oCnt, "chk_4c_Salto", 5)
                        .chk_4c_Salto.Value = 0
                    ENDIF
                    IF PEMSTATUS(loc_oCnt, "chk_4c_Sant", 5)
                        .chk_4c_Sant.Value = IIF(THIS.this_lMatrizes, 1, 0)
                    ENDIF
                    IF PEMSTATUS(loc_oCnt, "chk_4c_RazaoCp", 5)
                        .chk_4c_RazaoCp.Value = 0
                        IF PEMSTATUS(loc_oCnt, "txt_4c_CdMoeda", 5)
                            .chk_4c_RazaoCp.Enabled = !EMPTY(.txt_4c_CdMoeda.Value)
                        ENDIF
                    ENDIF
                    IF PEMSTATUS(loc_oCnt, "chk_4c_RazaoDoc", 5)
                        .chk_4c_RazaoDoc.Value = 0
                        IF PEMSTATUS(loc_oCnt, "txt_4c_CdMoeda", 5)
                            .chk_4c_RazaoDoc.Enabled = !EMPTY(.txt_4c_CdMoeda.Value)
                        ENDIF
                    ENDIF
                    .Visible = .T.
                    IF PEMSTATUS(loc_oCnt, "txt_4c_Dt_inicial", 5)
                        .txt_4c_Dt_inicial.SetFocus()
                    ENDIF
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnImpressaoHistClick")
        ENDTRY
    ENDPROC

    *-- Anexa Click -> lookup movimentacao vinculada e abrir form apropriado
    PROCEDURE BtnAnexaHistClick()
        LOCAL loc_oErro, loc_cEmpr, loc_cDope, loc_nNume, loc_cDopc
        LOCAL loc_nNumc, loc_cVoper, loc_nOper, loc_cEmpo, loc_nVope
        LOCAL loc_cSQL, loc_nRet, loc_oPagHist, loc_lProsseguir
        PRIVATE lcDopc
        TRY
            loc_lProsseguir = .F.

            IF USED("CrSigMvCcr") AND !EOF("CrSigMvCcr") AND CrSigMvCcr.Tipo # "P"
                THIS.DesabContainer()

                loc_cEmpr  = CrSigMvCcr.Emps
                loc_cDope  = CrSigMvCcr.Dopes
                loc_nNume  = CrSigMvCcr.Numes
                lcDopc     = CrSigMvCcr.Dopcs
                loc_nNumc  = CrSigMvCcr.Numcs
                loc_cVoper = CrSigMvCcr.VOpers
                loc_nOper  = CrSigMvCcr.Nopers
                loc_cEmpo  = LEFT(CrSigMvCcr.VOpers, 3)
                loc_nVope  = VAL(PADL(ALLTRIM(SUBSTR(CrSigMvCcr.VOpers, 4)), 7))

                *-- Buscar operacao para determinar tipo de documento
                loc_cSQL = "SELECT NDopes, RealPrevs FROM SigOpOpe WHERE Dopes = " + EscaparSQL(lcDopc)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpOpe") >= 1
                    SELECT CrSigMvCcr
                    IF !EOF()
                        loc_lProsseguir = .T.
                    ENDIF
                ELSE
                    MsgErro("Favor Reinicializar o Processo!", ;
                            "Falha na Conex" + CHR(227) + "o (SigOpOpe)")
                ENDIF
            ENDIF

            *-- Determinar qual form abrir baseado nos registros vinculados
            LOCAL loc_lEncontrou
            loc_lEncontrou = .F.

            IF loc_lProsseguir

            *-- 1) Verificar SigCdPgr (programacao)
            loc_cSQL = "SELECT TOP 1 1 AS Achou FROM SigCdPgr " + ;
                       "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
                       " AND Dopes = " + EscaparSQL(loc_cDope) + ;
                       " AND Numes = " + STR(loc_nNume)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") >= 1
                IF RECCOUNT("cursor_4c_ChkReg") > 0
                    DO FORM SigCdPgr WITH LEFT(CrSigMvCcr.Dopes, 1), .T., ;
                        CrSigMvCcr.Emps, CrSigMvCcr.Dopes, CrSigMvCcr.Numes
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF

            *-- 2) Verificar SigMvCab (movimentacao de estoque)
            IF !loc_lEncontrou
                loc_cSQL = "SELECT TOP 1 1 AS Achou FROM SigMvCab " + ;
                           "WHERE EmpDopNums = " + ;
                           EscaparSQL(loc_cEmpr + loc_cDope + STR(loc_nNume, 6))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") >= 1
                    IF RECCOUNT("cursor_4c_ChkReg") > 0
                        IF fChecaAcesso("SIGOPIND", "ALTMOV")
                            DO FORM SigMvCab WITH CrSigMvCcr.Dopes, CrSigMvCcr.Numes, ;
                                CrSigMvCcr.Emps, .T., 3, THIS
                        ELSE
                            DO FORM SigMvExp WITH CrSigMvCcr.Dopes, "C", ;
                                CrSigMvCcr.Numes, CrSigMvCcr.Emps, .T.
                        ENDIF
                        loc_lEncontrou = .T.
                    ENDIF
                ENDIF
            ENDIF

            *-- 3) Verificar titulo de pagamento (SigPgTit)
            IF !loc_lEncontrou AND ;
               !EMPTY(CrSigMvCcr.Emps) AND !EMPTY(CrSigMvCcr.Dopcs) AND ;
               !EMPTY(CrSigMvCcr.Numcs)
                IF USED("cursor_4c_SigOpOpe") AND RECCOUNT("cursor_4c_SigOpOpe") > 0
                    SELECT cursor_4c_SigOpOpe
                    GO TOP
                    IF fChecaAcesso("C" + PADL(cursor_4c_SigOpOpe.NDopes, 8, "0"))
                        DO FORM SigPgTit WITH CrSigMvCcr.Dopcs, "CONSULTAR", ;
                            CrSigMvCcr.Emps, STR(CrSigMvCcr.Numcs, 6), ;
                            (cursor_4c_SigOpOpe.RealPrevs = 2)
                        loc_lEncontrou = .T.
                    ELSE
                        MsgAviso("Usu" + CHR(225) + "rio n" + CHR(227) + ;
                                 "o tem acesso a Consultar T" + CHR(237) + "tulos!", "")
                        loc_lEncontrou = .T.
                    ENDIF
                ENDIF
            ENDIF

            *-- 4) Verificar sigCcchm (carteira de cheques)
            IF !loc_lEncontrou
                loc_cSQL = "SELECT TOP 1 1 AS Achou FROM sigCcchm " + ;
                           "WHERE Emps = " + EscaparSQL(loc_cEmpo) + ;
                           " AND Numos = " + STR(loc_nVope)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") >= 1
                    IF RECCOUNT("cursor_4c_ChkReg") > 0
                        DO FORM SigCdChe WITH .T., LEFT(CrSigMvCcr.VOpers, 3), ;
                            VAL(ALLTRIM(SUBSTR(CrSigMvCcr.VOpers, 4)))
                        loc_lEncontrou = .T.
                    ENDIF
                ENDIF
            ENDIF

            *-- 5) Verificar SigCqChm (cheques a cobrar)
            IF !loc_lEncontrou
                loc_cSQL = "SELECT TOP 1 1 AS Achou FROM SigCqChm " + ;
                           "WHERE Emps = " + EscaparSQL(loc_cEmpo) + ;
                           " AND Numos = " + STR(loc_nVope)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") >= 1
                    IF RECCOUNT("cursor_4c_ChkReg") > 0
                        DO FORM SigCdLch WITH .T., LEFT(CrSigMvCcr.VOpers, 3), ;
                            VAL(ALLTRIM(SUBSTR(CrSigMvCcr.VOpers, 4)))
                        loc_lEncontrou = .T.
                    ENDIF
                ENDIF
            ENDIF

            *-- 6) Verificar SigPrCtb (provisoes contabeis)
            IF !loc_lEncontrou
                loc_cSQL = "SELECT TOP 1 1 AS Achou FROM SigPrCtb " + ;
                           "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
                           " AND Dopes = " + EscaparSQL(loc_cDope) + ;
                           " AND Numes = " + STR(loc_nNume)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") >= 1
                    IF RECCOUNT("cursor_4c_ChkReg") > 0
                        DO FORM SigCdPgb WITH CrSigMvCcr.Emps, CrSigMvCcr.Dopes, ;
                            CrSigMvCcr.Numes
                        loc_lEncontrou = .T.
                    ENDIF
                ENDIF
            ENDIF

            *-- 7) Verificar SigCdNec (notas de entrada)
            IF !loc_lEncontrou
                loc_cSQL = "SELECT TOP 1 1 AS Achou FROM SigCdNec " + ;
                           "WHERE EmpDnPs = " + ;
                           EscaparSQL(CrSigMvCcr.Emps + CrSigMvCcr.Dopes + STR(CrSigMvCcr.Numes, 10))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") >= 1
                    IF RECCOUNT("cursor_4c_ChkReg") > 0
                        DO FORM SigMvPdt WITH CrSigMvCcr.Dopes, "C", ;
                            CrSigMvCcr.Numes, CrSigMvCcr.Emps, .T.
                        loc_lEncontrou = .T.
                    ENDIF
                ENDIF
            ENDIF

            ENDIF && loc_lProsseguir

            *-- Cleanup cursor temporario
            IF USED("cursor_4c_ChkReg")
                USE IN cursor_4c_ChkReg
            ENDIF
            IF USED("cursor_4c_SigOpOpe")
                USE IN cursor_4c_SigOpOpe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnAnexaHistClick")
        ENDTRY
    ENDPROC

    *-- Chk_Quitacao Click -> query SigCdPbx, popular xTmpBaixa, exibir cnt_4c_Quitas
    PROCEDURE BtnQuitacaoHistClick()
        LOCAL loc_oErro, loc_oPagHist, loc_cEmpr, loc_nNope, loc_cSQL, loc_lProsseguir
        TRY
            loc_lProsseguir = .F.

            IF USED("CrSigMvCcr") AND !EOF("CrSigMvCcr") AND CrSigMvCcr.Tipo # "P"
                THIS.DesabContainer()

                *-- Criar cursor xTmpBaixa se nao existe
                IF !USED("xTmpBaixa")
                    CREATE CURSOR xTmpBaixa ;
                        (Emps C(3), Dopes C(20), Numes C(6), Valos N(12,2), Moedas C(3), Datarcs D)
                    INDEX ON Emps + Dopes + Numes TAG EmpDopNum
                ELSE
                    SELECT xTmpBaixa
                    DELETE ALL
                    PACK
                ENDIF

                loc_cEmpr = CrSigMvCcr.Emps
                loc_nNope = CrSigMvCcr.Nopers

                loc_cSQL = "SELECT a.*, b.Datarcs FROM SigCdPbx a " + ;
                           "JOIN SigCdPgr b ON a.EmpDopNums = b.EmpDopNums " + ;
                           "WHERE a.Empos = " + EscaparSQL(loc_cEmpr) + ;
                           " AND (a.Nopers = " + STR(loc_nNope) + ;
                           " OR a.Nopercs = " + STR(loc_nNope) + ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CrSigCdPbx") >= 1
                    loc_lProsseguir = .T.
                ELSE
                    MsgErro("Favor Reinicializar o Processo!", ;
                            "Falha na Conex" + CHR(227) + "o (CrSigCdPbx)")
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_CrSigCdPbx
                SCAN
                    INSERT INTO xTmpBaixa (Emps, Dopes, Numes, Valos, Moedas, Datarcs) ;
                        VALUES (cursor_4c_CrSigCdPbx.Emps, ;
                                cursor_4c_CrSigCdPbx.Dopes, ;
                                fGerMascara(cursor_4c_CrSigCdPbx.Numes), ;
                                cursor_4c_CrSigCdPbx.Valos, ;
                                cursor_4c_CrSigCdPbx.Moedas, ;
                                cursor_4c_CrSigCdPbx.Datarcs)
                ENDSCAN

                IF USED("cursor_4c_CrSigCdPbx")
                    USE IN cursor_4c_CrSigCdPbx
                ENDIF

                SELECT xTmpBaixa
                IF !EOF("xTmpBaixa")
                    GO TOP
                    loc_oPagHist = THIS.pgf_4c_1.Page2

                    *-- Desabilitar Sair
                    IF PEMSTATUS(loc_oPagHist, "obj_4c_Grp_operacao", 5)
                        loc_oPagHist.obj_4c_Grp_operacao.Buttons(1).Enabled = .F.
                    ENDIF

                    *-- Exibir cnt_4c_Quitas
                    IF PEMSTATUS(loc_oPagHist, "cnt_4c_Quitas", 5)
                        loc_oPagHist.cnt_4c_Quitas.grd_4c_Grade.Refresh()
                        loc_oPagHist.cnt_4c_Quitas.Visible = .T.
                        loc_oPagHist.cnt_4c_Quitas.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnQuitacaoHistClick")
        ENDTRY
    ENDPROC

    *-- grp_operacao Sair Click -> retornar para Page1 (SALDO)
    PROCEDURE BtnSairHistClick()
        LOCAL loc_oErro
        TRY
            THIS.pgf_4c_1.Page2.Enabled  = .F.
            THIS.this_cOperacao          = ""
            THIS.pgf_4c_1.ActivePage     = 1
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnSairHistClick")
        ENDTRY
    ENDPROC

    *-- Chk_Follow Click -> Follow-up de conciliacao (query SigCqOch + DO FORM SigOpOch)
    PROCEDURE BtnFollowConciliaHistClick()
        LOCAL loc_oErro, loc_oPagHist, loc_cSQL, loc_lProsseguir
        TRY
            loc_lProsseguir = .F.

            IF USED("CrSigMvCcr") AND !EOF("CrSigMvCcr") AND CrSigMvCcr.Tipo # "P"
                loc_cSQL = "SELECT * FROM SigCqOch WHERE Nopers = " + STR(CrSigMvCcr.Nopers)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lancto") >= 1
                    loc_lProsseguir = .T.
                ELSE
                    MsgErro("Favor Reinicializar o Processo!", ;
                            "Falha na Conex" + CHR(227) + "o (SigCqOch)")
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_Lancto
                IF RECCOUNT() = 0
                    MsgAviso("Nenhum lan" + CHR(231) + "amento de Follow-up Conciliado/Auditado!", "")
                ELSE
                    THIS.DesabContainer()
                    DO FORM SigOpOch WITH THIS, CrSigMvCcr.Nopers, CrSigMvCcr.Opers
                ENDIF

                IF USED("cursor_4c_Lancto")
                    USE IN cursor_4c_Lancto
                ENDIF

                SELECT CrSigMvCcr
                loc_oPagHist = THIS.pgf_4c_1.Page2
                IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                    loc_oPagHist.grd_4c_Lancamento.Refresh()
                    loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnFollowConciliaHistClick")
        ENDTRY
    ENDPROC

    *-- FollowUp Click -> Follow-up de conta (DO FORM SigOpFlp com conta)
    PROCEDURE BtnFollowUpHistClick()
        LOCAL loc_oErro, loc_oPagHist
        TRY
            THIS.DesabContainer()
            loc_oPagHist = THIS.pgf_4c_1.Page2
            IF PEMSTATUS(loc_oPagHist, "txt_4c_Hconta", 5)
                DO FORM SigOpFlp WITH loc_oPagHist.txt_4c_Hconta.Value, THIS.DataSessionId
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5) AND USED("CrSigMvCcr")
                loc_oPagHist.grd_4c_Lancamento.Refresh()
                loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnFollowUpHistClick")
        ENDTRY
    ENDPROC

    *-- FollowUpI Click -> Follow-up de lancamento (DO FORM SigOpFlp com Nopers)
    PROCEDURE BtnFollowUpIHistClick()
        LOCAL loc_oErro, loc_oPagHist
        TRY
            IF USED("CrSigMvCcr") AND !EOF("CrSigMvCcr") AND CrSigMvCcr.Tipo # "P"
                THIS.DesabContainer()
                loc_oPagHist = THIS.pgf_4c_1.Page2
                IF PEMSTATUS(loc_oPagHist, "txt_4c_Hconta", 5)
                    DO FORM SigOpFlp WITH loc_oPagHist.txt_4c_Hconta.Value, THIS.DataSessionId, CrSigMvCcr.Nopers
                ENDIF
                IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                    loc_oPagHist.grd_4c_Lancamento.Refresh()
                    loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnFollowUpIHistClick")
        ENDTRY
    ENDPROC

    *-- Procura Click -> DO FORM SigOpCrp + refresh grd_4c_Lancamento
    PROCEDURE BtnProcuraHistClick()
        LOCAL loc_oErro, loc_oPagHist, loc_oGrd
        TRY
            DO FORM SigOpCrp WITH THIS.DataSessionId, THIS
            loc_oPagHist = THIS.pgf_4c_1.Page2
            IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5) AND USED("CrSigMvCcr")
                loc_oGrd = loc_oPagHist.grd_4c_Lancamento
                loc_oGrd.Refresh()
                loc_oGrd.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnProcuraHistClick")
        ENDTRY
    ENDPROC

    *-- Cmb_Concilia InteractiveChange -> filtrar grd_4c_Lancamento por modo
    *   Opcoes: 0=Realizados, 1=Conciliados, 2=NaoConciliados,
    *           3=SaldoDiario-Todos, 4=SaldoDiario-Conc, 5=SaldoDiario-NaoConc,
    *           6=Realizado+Previsao
    PROCEDURE CmbConciliaHistChange()
        LOCAL loc_oErro, loc_oPagHist, loc_oGrd, loc_nItem, loc_cTag, loc_cFor
        TRY
            IF !USED("CrSigMvCcr") OR RECCOUNT("CrSigMvCcr") = 0
                RETURN
            ENDIF

            loc_oPagHist = THIS.pgf_4c_1.Page2
            IF !PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                RETURN
            ENDIF
            loc_oGrd = loc_oPagHist.grd_4c_Lancamento

            loc_nItem = loc_oPagHist.cmb_4c_Concilia.ListIndex

            SELECT CrSigMvCcr
            DO CASE
                CASE loc_nItem = 0  && Lancamentos Realizados
                    SET ORDER TO GruConMoe
                    SET FILTER TO Tipo = "R"
                CASE loc_nItem = 1  && So Conciliados
                    SET ORDER TO GruConMoec
                    SET FILTER TO Concs
                CASE loc_nItem = 2  && Nao Conciliados
                    SET ORDER TO GruConMoen
                    SET FILTER TO !Concs
                CASE loc_nItem = 3  && Saldo Diario - Todos
                    SET ORDER TO GruConMoe
                    SET FILTER TO
                CASE loc_nItem = 4  && Saldo Diario - Conciliados
                    SET ORDER TO GruConMoec
                    SET FILTER TO Concs
                CASE loc_nItem = 5  && Saldo Diario - Nao Conciliados
                    SET ORDER TO GruConMoen
                    SET FILTER TO !Concs
                CASE loc_nItem = 6  && Realizado e Previsao
                    SET ORDER TO GruConMoeP
                    SET FILTER TO
                OTHERWISE
                    SET ORDER TO GruConMoe
                    SET FILTER TO
            ENDCASE
            GO TOP

            *-- Reatribuir RecordSource e reconfirmar todos ControlSources
            loc_oGrd.RecordSource = "CrSigMvCcr"
            loc_oGrd.Column1.ControlSource  = "CrSigMvCcr.Datas"
            loc_oGrd.Column2.ControlSource  = "CrSigMvCcr.Hists"
            loc_oGrd.Column3.ControlSource  = "CrSigMvCcr.Valors"
            loc_oGrd.Column4.ControlSource  = "CrSigMvCcr.Opers"
            loc_oGrd.Column5.ControlSource  = "CrSigMvCcr.Emps"
            loc_oGrd.Column6.ControlSource  = "CrSigMvCcr.Saldos"
            loc_oGrd.Column7.ControlSource  = "CrSigMvCcr.Docus"
            loc_oGrd.Column8.ControlSource  = "CrSigMvCcr.NFs"
            loc_oGrd.Column9.ControlSource  = "CrSigMvCcr.Titulos"
            loc_oGrd.Column10.ControlSource = "CrSigMvCcr.Tipo"
            loc_oGrd.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em CmbConciliaHistChange")
        ENDTRY
    ENDPROC

    *-- TxtMoeda KeyPress -> ENTER/TAB move foco para proximo campo
    PROCEDURE TxtMoedaHistKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro, loc_oPagHist
        TRY
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                loc_oPagHist = THIS.pgf_4c_1.Page2
                IF PEMSTATUS(loc_oPagHist, "txt_4c_HConta", 5)
                    loc_oPagHist.txt_4c_HConta.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em TxtMoedaHistKeyPress")
        ENDTRY
    ENDPROC

    *-- TxtGrupoHist KeyPress -> ENTER/TAB move foco para proximo campo
    PROCEDURE TxtGrupoHistKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro, loc_oPagHist
        TRY
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                loc_oPagHist = THIS.pgf_4c_1.Page2
                IF PEMSTATUS(loc_oPagHist, "txt_4c_HConta", 5)
                    loc_oPagHist.txt_4c_HConta.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em TxtGrupoHistKeyPress")
        ENDTRY
    ENDPROC

    *-- TxtHconta KeyPress -> ENTER/TAB aciona procura ou move foco
    PROCEDURE TxtHcontaHistKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        TRY
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.BtnProcuraHistClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em TxtHcontaHistKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE DesabContainer
    * Oculta os containers flutuantes da Page2 (cntImprime e cntQuitas).
    * Equivale ao DesabContainer() do legado.
    *==========================================================================
    PROCEDURE DesabContainer()
        LOCAL loc_oErro, loc_oPagHist
        TRY
            loc_oPagHist = THIS.pgf_4c_1.Page2
            IF PEMSTATUS(loc_oPagHist, "cnt_4c_Imprime", 5)
                loc_oPagHist.cnt_4c_Imprime.Visible = .F.
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "cnt_4c_Quitas", 5)
                loc_oPagHist.cnt_4c_Quitas.Visible = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em DesabContainer")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE GrdLancamentoAfterRowColChange
    * Preenche campos inferiores da Page2 com dados do registro atual do
    * grd_4c_Lancamento (CrSigMvCcr). Habilita/desabilita botoes de acao
    * conforme Tipo='P' (previsao).
    * par_nColIndex: indice da coluna atual (obrigatorio pelo BINDEVENT)
    *==========================================================================
    PROCEDURE GrdLancamentoAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro, loc_oPagHist, loc_lEhPrevisao
        TRY
            THIS.DesabContainer()

            IF !USED("CrSigMvCcr") OR RECCOUNT("CrSigMvCcr") = 0 OR EOF("CrSigMvCcr")
                RETURN
            ENDIF

            loc_oPagHist = THIS.pgf_4c_1.Page2
            loc_lEhPrevisao = (CrSigMvCcr.Tipo = "P")

            *-- Preencher campos de detalhe (faixa inferior)
            IF PEMSTATUS(loc_oPagHist, "txt_4c_HIST", 5)
                loc_oPagHist.txt_4c_HIST.Value = CrSigMvCcr.Hists
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_Get1", 5)
                loc_oPagHist.txt_4c_Get1.Value = CrSigMvCcr.Usualts
            ENDIF
            *-- Cobran" + CHR(231) + "a: busca Contas/RClis via CidChaves (como no original)
            IF PEMSTATUS(loc_oPagHist, "txt_4c_CtaCob", 5)
                loc_oPagHist.txt_4c_CtaCob.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_NomCob", 5)
                loc_oPagHist.txt_4c_NomCob.Value = ""
            ENDIF
            IF gnConnHandle > 0 AND !EMPTY(CrSigMvCcr.CidChaves)
                LOCAL loc_cSqlCob, loc_nRetCob
                loc_cSqlCob = "SELECT a.Contas, b.RClis " + ;
                              "FROM SigMvCcr a INNER JOIN SigCdCli b ON a.Contas = b.IClis " + ;
                              "WHERE a.CidChaves = " + EscaparSQL(ALLTRIM(CrSigMvCcr.CidChaves))
                loc_nRetCob = SQLEXEC(gnConnHandle, loc_cSqlCob, "cursor_4c_LocalCta")
                IF loc_nRetCob > 0 AND RECCOUNT("cursor_4c_LocalCta") > 0
                    GO TOP IN cursor_4c_LocalCta
                    IF PEMSTATUS(loc_oPagHist, "txt_4c_CtaCob", 5)
                        loc_oPagHist.txt_4c_CtaCob.Value = cursor_4c_LocalCta.Contas
                    ENDIF
                    IF PEMSTATUS(loc_oPagHist, "txt_4c_NomCob", 5)
                        loc_oPagHist.txt_4c_NomCob.Value = cursor_4c_LocalCta.RClis
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalCta")
                    USE IN cursor_4c_LocalCta
                ENDIF
                SELECT CrSigMvCcr
            ENDIF

            *-- Job: busca RClis via Jobs (como no original)
            IF PEMSTATUS(loc_oPagHist, "txt_4c_job", 5)
                loc_oPagHist.txt_4c_job.Value = CrSigMvCcr.Jobs
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_djob", 5)
                loc_oPagHist.txt_4c_djob.Value = ""
                IF gnConnHandle > 0 AND !EMPTY(CrSigMvCcr.Jobs)
                    LOCAL loc_cSqlJob, loc_nRetJob
                    loc_cSqlJob = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                                  EscaparSQL(ALLTRIM(CrSigMvCcr.Jobs))
                    loc_nRetJob = SQLEXEC(gnConnHandle, loc_cSqlJob, "cursor_4c_LocalJob")
                    IF loc_nRetJob > 0 AND RECCOUNT("cursor_4c_LocalJob") > 0
                        GO TOP IN cursor_4c_LocalJob
                        loc_oPagHist.txt_4c_djob.Value = cursor_4c_LocalJob.RClis
                    ENDIF
                    IF USED("cursor_4c_LocalJob")
                        USE IN cursor_4c_LocalJob
                    ENDIF
                    SELECT CrSigMvCcr
                ENDIF
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_Auditors", 5)
                loc_oPagHist.txt_4c_Auditors.Value = CrSigMvCcr.Auditors
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5)
                loc_oPagHist.txt_4c_DataConcilia.Value = CrSigMvCcr.DataConcs
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_DtAudits", 5)
                loc_oPagHist.txt_4c_DtAudits.Value = CrSigMvCcr.DtAudits
            ENDIF

            *-- Habilitar/desabilitar botoes de acao conforme Tipo
            *   Previsao (Tipo='P'): desabilita Concilia/Audita/Quita; habilita Alterar/Excluir
            IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Alterar", 5)
                loc_oPagHist.cmd_4c_Cmd_Alterar.Enabled = .T.
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Excluir", 5)
                loc_oPagHist.cmd_4c_Cmd_Excluir.Enabled = .T.
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "chk_4c_Concilia", 5)
                loc_oPagHist.chk_4c_Concilia.Enabled = !loc_lEhPrevisao
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "chk_4c_Auditoria", 5)
                loc_oPagHist.chk_4c_Auditoria.Enabled = !loc_lEhPrevisao
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "chk_4c_Quitacao", 5)
                loc_oPagHist.chk_4c_Quitacao.Enabled = !loc_lEhPrevisao
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "chk_4c_Follow", 5)
                loc_oPagHist.chk_4c_Follow.Enabled = !loc_lEhPrevisao
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GrdLancamentoAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE GrdLancamentoKeyPress
    * Teclas de acao na grade de lancamentos (Page2).
    * F2(-2)=Alterar, F3(-3)=Excluir, F4(-4)=Procurar, F5(-5)=Impressao
    *==========================================================================
    PROCEDURE GrdLancamentoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro, loc_oPagHist
        TRY
            loc_oPagHist = THIS.pgf_4c_1.Page2
            DO CASE
                CASE par_nKeyCode = -2
                    IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Alterar", 5)
                        IF loc_oPagHist.cmd_4c_Cmd_Alterar.Enabled
                            loc_oPagHist.cmd_4c_Cmd_Alterar.SetFocus()
                            THIS.BtnAlterarHistClick()
                        ENDIF
                    ENDIF
                CASE par_nKeyCode = -3
                    IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Excluir", 5)
                        IF loc_oPagHist.cmd_4c_Cmd_Excluir.Enabled
                            loc_oPagHist.cmd_4c_Cmd_Excluir.SetFocus()
                            THIS.BtnExcluirHistClick()
                        ENDIF
                    ENDIF
                CASE par_nKeyCode = -4
                    THIS.BtnProcuraHistClick()
                CASE par_nKeyCode = -5
                    THIS.BtnImpressaoHistClick()
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GrdLancamentoKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Handlers - Container cntImprime (Relatorio de Conta Corrente)
    *==========================================================================

    *-- TxtCdMoeda KeyPress -> lookup moeda pelo codigo (cntImprime)
    PROCEDURE TxtCdMoedaImpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cMoeda
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oCnt   = THIS.pgf_4c_1.Page2.cnt_4c_Imprime
            loc_cMoeda = TRIM(loc_oCnt.txt_4c_CdMoeda.Value)
            IF !EMPTY(loc_cMoeda) AND gnConnHandle > 0
                THIS.AbrirLookupMoedaImp(loc_oCnt, loc_cMoeda, "cmoes")
            ELSE
                loc_oCnt.txt_4c_DsMoeda.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *-- TxtDsMoeda KeyPress -> lookup moeda pela descricao (cntImprime)
    PROCEDURE TxtDsMoedaImpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cDesc
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oCnt  = THIS.pgf_4c_1.Page2.cnt_4c_Imprime
            loc_cDesc = TRIM(loc_oCnt.txt_4c_DsMoeda.Value)
            IF !EMPTY(loc_cDesc) AND gnConnHandle > 0
                THIS.AbrirLookupMoedaImp(loc_oCnt, loc_cDesc, "dmoes")
            ELSE
                loc_oCnt.txt_4c_CdMoeda.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *-- AbrirLookupMoedaImp - abre FormBuscaAuxiliar para SigCdMoe (cntImprime)
    PROCEDURE AbrirLookupMoedaImp(par_oCnt, par_cValor, par_cCampoBusca)
        LOCAL loc_oBusca, loc_oErro
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
                "cursor_4c_Busca", par_cCampoBusca, par_cValor, "Moeda")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    GO TOP
                    par_oCnt.txt_4c_CdMoeda.Value = TRIM(cursor_4c_Busca.cmoes)
                    par_oCnt.txt_4c_DsMoeda.Value = TRIM(cursor_4c_Busca.dmoes)
                    *-- Habilitar chkRazaoCp/chkRazaoDoc quando moeda preenchida
                    IF PEMSTATUS(par_oCnt, "chk_4c_RazaoCp", 5)
                        par_oCnt.chk_4c_RazaoCp.Enabled = .T.
                    ENDIF
                    IF PEMSTATUS(par_oCnt, "chk_4c_RazaoDoc", 5)
                        par_oCnt.chk_4c_RazaoDoc.Enabled = .T.
                    ENDIF
                ELSE
                    IF EMPTY(par_oCnt.txt_4c_CdMoeda.Value)
                        par_oCnt.txt_4c_DsMoeda.Value = ""
                        IF PEMSTATUS(par_oCnt, "chk_4c_RazaoCp", 5)
                            par_oCnt.chk_4c_RazaoCp.Enabled = .F.
                            par_oCnt.chk_4c_RazaoCp.Value   = 0
                        ENDIF
                        IF PEMSTATUS(par_oCnt, "chk_4c_RazaoDoc", 5)
                            par_oCnt.chk_4c_RazaoDoc.Enabled = .F.
                            par_oCnt.chk_4c_RazaoDoc.Value   = 0
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AbrirLookupMoedaImp")
        ENDTRY
    ENDPROC

    *-- TxtEmps KeyPress -> lookup empresa pelo codigo (cntImprime)
    PROCEDURE TxtEmpsImpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cEmp
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oCnt = THIS.pgf_4c_1.Page2.cnt_4c_Imprime
            loc_cEmp = TRIM(loc_oCnt.txt_4c_Emps.Value)
            IF !EMPTY(loc_cEmp) AND gnConnHandle > 0
                THIS.AbrirLookupEmps(loc_oCnt, loc_cEmp, "Cemps")
            ELSE
                loc_oCnt.txt_4c_DEmps.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *-- TxtDEmps KeyPress -> lookup empresa pela razao social (cntImprime)
    PROCEDURE TxtDEmpsImpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cRazao
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oCnt  = THIS.pgf_4c_1.Page2.cnt_4c_Imprime
            loc_cRazao = TRIM(loc_oCnt.txt_4c_DEmps.Value)
            IF !EMPTY(loc_cRazao) AND gnConnHandle > 0
                THIS.AbrirLookupEmps(loc_oCnt, loc_cRazao, "Razas")
            ELSE
                loc_oCnt.txt_4c_Emps.Value = ""
            ENDIF
        ENDIF
    ENDPROC

    *-- AbrirLookupEmps - abre FormBuscaAuxiliar para SigCdEmp (cntImprime)
    PROCEDURE AbrirLookupEmps(par_oCnt, par_cValor, par_cCampoBusca)
        LOCAL loc_oBusca, loc_oErro
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
                "cursor_4c_Busca", par_cCampoBusca, par_cValor, "Empresa")
            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "XXX", "Emp")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    GO TOP
                    par_oCnt.txt_4c_Emps.Value  = TRIM(cursor_4c_Busca.Cemps)
                    par_oCnt.txt_4c_DEmps.Value = TRIM(cursor_4c_Busca.Razas)
                ELSE
                    IF EMPTY(par_oCnt.txt_4c_Emps.Value)
                        par_oCnt.txt_4c_DEmps.Value = ""
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AbrirLookupEmps")
        ENDTRY
    ENDPROC

    *-- TxtOper KeyPress -> validar D/C/espaco (cntImprime)
    PROCEDURE TxtOperImpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cVal
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oCnt = THIS.pgf_4c_1.Page2.cnt_4c_Imprime
            loc_cVal = UPPER(TRIM(loc_oCnt.txt_4c_Oper.Value))
            IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "D", "C")
                MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + ;
                         "lida!!! Informe D/C/  ", "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_oCnt.txt_4c_Oper.Value = ""
                loc_oCnt.txt_4c_Oper.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *-- ChkRazaoCP InteractiveChange -> mutuamente exclusivo com RazaoDoc e RelDets
    *   Origem: Check_RazaoCP.InteractiveChange do legado
    PROCEDURE ChkRazaoCPChange()
        LOCAL loc_oCnt, loc_oErro
        TRY
            loc_oCnt = THIS.pgf_4c_1.Page2.cnt_4c_Imprime
            IF loc_oCnt.chk_4c_RazaoCp.Value = 1
                IF PEMSTATUS(loc_oCnt, "chk_4c_RazaoDoc", 5)
                    loc_oCnt.chk_4c_RazaoDoc.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oCnt, "chk_4c_RelDets", 5)
                    loc_oCnt.chk_4c_RelDets.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oCnt, "chk_4c_Salto", 5)
                    loc_oCnt.chk_4c_Salto.Value = 0
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ChkRazaoCPChange")
        ENDTRY
    ENDPROC

    *-- ChkRazaoDoc InteractiveChange -> mutuamente exclusivo com RazaoCP e RelDets
    *   Origem: Check_RazaoDoc.InteractiveChange do legado
    PROCEDURE ChkRazaoDocChange()
        LOCAL loc_oCnt, loc_oErro
        TRY
            loc_oCnt = THIS.pgf_4c_1.Page2.cnt_4c_Imprime
            IF loc_oCnt.chk_4c_RazaoDoc.Value = 1
                IF PEMSTATUS(loc_oCnt, "chk_4c_RazaoCp", 5)
                    loc_oCnt.chk_4c_RazaoCp.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oCnt, "chk_4c_RelDets", 5)
                    loc_oCnt.chk_4c_RelDets.Value = 0
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ChkRazaoDocChange")
        ENDTRY
    ENDPROC

    *-- ChkRelDets InteractiveChange -> mutuamente exclusivo com RazaoCP/RazaoDoc
    *   Origem: chkRelDets.InteractiveChange do legado
    PROCEDURE ChkRelDetsChange()
        LOCAL loc_oCnt, loc_oErro
        TRY
            loc_oCnt = THIS.pgf_4c_1.Page2.cnt_4c_Imprime
            IF loc_oCnt.chk_4c_RelDets.Value = 1
                IF PEMSTATUS(loc_oCnt, "chk_4c_RazaoCp", 5)
                    loc_oCnt.chk_4c_RazaoCp.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oCnt, "chk_4c_RazaoDoc", 5)
                    loc_oCnt.chk_4c_RazaoDoc.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oCnt, "chk_4c_Salto", 5)
                    loc_oCnt.chk_4c_Salto.Value = 0
                ENDIF
            ELSE
                *-- Se desmarcado, resetar optSNA para S (opcao 1)
                IF PEMSTATUS(loc_oCnt, "obj_4c_OptSNA", 5)
                    loc_oCnt.obj_4c_OptSNA.Value = 1
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ChkRelDetsChange")
        ENDTRY
    ENDPROC

    *-- BtnCntImpVoltar Click -> fechar cntImprime e reabilitar botao Sair
    PROCEDURE BtnCntImpVoltarClick()
        LOCAL loc_oErro, loc_oPagHist
        TRY
            loc_oPagHist = THIS.pgf_4c_1.Page2
            *-- Ocultar container
            IF PEMSTATUS(loc_oPagHist, "cnt_4c_Imprime", 5)
                loc_oPagHist.cnt_4c_Imprime.Visible = .F.
            ENDIF
            *-- Reabilitar botao Sair
            IF PEMSTATUS(loc_oPagHist, "obj_4c_Grp_operacao", 5)
                loc_oPagHist.obj_4c_Grp_operacao.Buttons(1).Enabled = .T.
            ENDIF
            *-- Refoco na grade
            IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5) AND USED("CrSigMvCcr")
                loc_oPagHist.grd_4c_Lancamento.Refresh()
                loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnCntImpVoltarClick")
        ENDTRY
    ENDPROC

    *-- BtnCntImpExcel Click -> gerar relatorio em Excel via ProcessaHist('E')
    PROCEDURE BtnCntImpExcelClick()
        LOCAL loc_oErro, loc_oCnt, loc_oPagHist
        TRY
            loc_oPagHist = THIS.pgf_4c_1.Page2
            loc_oCnt     = loc_oPagHist.cnt_4c_Imprime
            THIS.this_oBusinessObject.ProcessaHist("E", ;
                THIS.this_cGrupoOper, ;
                THIS.this_cCliente, ;
                TRIM(loc_oCnt.txt_4c_CdMoeda.Value), ;
                loc_oCnt.txt_4c_Dt_inicial.Value, ;
                loc_oCnt.txt_4c_Dt_final.Value, ;
                TRIM(loc_oCnt.txt_4c_Emps.Value), ;
                UPPER(TRIM(loc_oCnt.txt_4c_Oper.Value)), ;
                loc_oPagHist.cmb_4c_Concilia.ListIndex, ;
                (loc_oCnt.chk_4c_Grupo.Value    = 1), ;
                (loc_oCnt.chk_4c_Salto.Value    = 1), ;
                (loc_oCnt.chk_4c_Sant.Value     = 1), ;
                (loc_oCnt.chk_4c_RazaoCp.Value  = 1), ;
                (loc_oCnt.chk_4c_RazaoDoc.Value = 1), ;
                (loc_oCnt.chk_4c_Comissao.Value = 1), ;
                (loc_oCnt.chk_4c_Saldoa.Value   = 1), ;
                (loc_oCnt.chk_4c_Taxas.Value    = 1), ;
                (loc_oCnt.chk_4c_RelDets.Value  = 1), ;
                loc_oCnt.obj_4c_OptSNA.Value, ;
                (loc_oCnt.chk_4c_OcultaCta.Value = 1))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnCntImpExcelClick")
        ENDTRY
    ENDPROC

    *-- BtnCntImpImprimir Click -> imprimir relatorio via ProcessaHist('I')
    PROCEDURE BtnCntImpImprimirClick()
        LOCAL loc_oErro, loc_oCnt, loc_oPagHist
        TRY
            loc_oPagHist = THIS.pgf_4c_1.Page2
            loc_oCnt     = loc_oPagHist.cnt_4c_Imprime
            THIS.this_oBusinessObject.ProcessaHist("I", ;
                THIS.this_cGrupoOper, ;
                THIS.this_cCliente, ;
                TRIM(loc_oCnt.txt_4c_CdMoeda.Value), ;
                loc_oCnt.txt_4c_Dt_inicial.Value, ;
                loc_oCnt.txt_4c_Dt_final.Value, ;
                TRIM(loc_oCnt.txt_4c_Emps.Value), ;
                UPPER(TRIM(loc_oCnt.txt_4c_Oper.Value)), ;
                loc_oPagHist.cmb_4c_Concilia.ListIndex, ;
                (loc_oCnt.chk_4c_Grupo.Value    = 1), ;
                (loc_oCnt.chk_4c_Salto.Value    = 1), ;
                (loc_oCnt.chk_4c_Sant.Value     = 1), ;
                (loc_oCnt.chk_4c_RazaoCp.Value  = 1), ;
                (loc_oCnt.chk_4c_RazaoDoc.Value = 1), ;
                (loc_oCnt.chk_4c_Comissao.Value = 1), ;
                (loc_oCnt.chk_4c_Saldoa.Value   = 1), ;
                (loc_oCnt.chk_4c_Taxas.Value    = 1), ;
                (loc_oCnt.chk_4c_RelDets.Value  = 1), ;
                loc_oCnt.obj_4c_OptSNA.Value, ;
                (loc_oCnt.chk_4c_OcultaCta.Value = 1))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnCntImpImprimirClick")
        ENDTRY
    ENDPROC

    *-- BtnCntImpVisual Click -> visualizar relatorio em tela via ProcessaHist('V')
    PROCEDURE BtnCntImpVisualClick()
        LOCAL loc_oErro, loc_oCnt, loc_oPagHist
        TRY
            loc_oPagHist = THIS.pgf_4c_1.Page2
            loc_oCnt     = loc_oPagHist.cnt_4c_Imprime
            THIS.this_oBusinessObject.ProcessaHist("V", ;
                THIS.this_cGrupoOper, ;
                THIS.this_cCliente, ;
                TRIM(loc_oCnt.txt_4c_CdMoeda.Value), ;
                loc_oCnt.txt_4c_Dt_inicial.Value, ;
                loc_oCnt.txt_4c_Dt_final.Value, ;
                TRIM(loc_oCnt.txt_4c_Emps.Value), ;
                UPPER(TRIM(loc_oCnt.txt_4c_Oper.Value)), ;
                loc_oPagHist.cmb_4c_Concilia.ListIndex, ;
                (loc_oCnt.chk_4c_Grupo.Value    = 1), ;
                (loc_oCnt.chk_4c_Salto.Value    = 1), ;
                (loc_oCnt.chk_4c_Sant.Value     = 1), ;
                (loc_oCnt.chk_4c_RazaoCp.Value  = 1), ;
                (loc_oCnt.chk_4c_RazaoDoc.Value = 1), ;
                (loc_oCnt.chk_4c_Comissao.Value = 1), ;
                (loc_oCnt.chk_4c_Saldoa.Value   = 1), ;
                (loc_oCnt.chk_4c_Taxas.Value    = 1), ;
                (loc_oCnt.chk_4c_RelDets.Value  = 1), ;
                loc_oCnt.obj_4c_OptSNA.Value, ;
                (loc_oCnt.chk_4c_OcultaCta.Value = 1))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnCntImpVisualClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Handlers - Container cntQuitas (Recebimento de Parcelas)
    *==========================================================================

    *-- BtnCntQuitasVoltar Click -> fechar cntQuitas e reabilitar botao Sair
    PROCEDURE BtnCntQuitasVoltarClick()
        LOCAL loc_oErro, loc_oPagHist
        TRY
            loc_oPagHist = THIS.pgf_4c_1.Page2
            *-- Ocultar container
            IF PEMSTATUS(loc_oPagHist, "cnt_4c_Quitas", 5)
                loc_oPagHist.cnt_4c_Quitas.Visible = .F.
            ENDIF
            *-- Reabilitar botao Sair
            IF PEMSTATUS(loc_oPagHist, "obj_4c_Grp_operacao", 5)
                loc_oPagHist.obj_4c_Grp_operacao.Buttons(1).Enabled = .T.
            ENDIF
            *-- Refoco na grade
            IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5) AND USED("CrSigMvCcr")
                loc_oPagHist.grd_4c_Lancamento.Refresh()
                loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnCntQuitasVoltarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE BtnConciliaHistClick
    * Conciliar/Desconciliar lancamento selecionado no grd_4c_Lancamento
    * Equivale ao Chk_Concilia.Click (152 linhas) do legado
    *==========================================================================
    PROCEDURE BtnConciliaHistClick()
        LOCAL loc_oErro, loc_oPagHist, loc_lOk, loc_cSQL, loc_lPValue
        LOCAL loc_cUpdate, loc_cTipo, loc_cCidChaves, loc_cDataSQL, loc_cInsert
        LOCAL loc_nResultIns, loc_nResultUpd, loc_dData
        PRIVATE llData, llConc

        TRY
            loc_oPagHist = THIS.pgf_4c_1.Page2

            *-- Ignorar se checkbox desabilitado ou lancamento provisorio
            IF !PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Concilia", 5)
                RETURN
            ENDIF
            IF !loc_oPagHist.chk_4c_Chk_Concilia.Enabled
                RETURN
            ENDIF
            IF USED("CrSigMvCcr") AND CrSigMvCcr.Tipo = "P"
                RETURN
            ENDIF

            loc_lPValue = (loc_oPagHist.chk_4c_Chk_Concilia.Value = 1)

            THIS.DesabContainer()

            IF !USED("CrSigMvCcr") OR EOF("CrSigMvCcr") OR BOF("CrSigMvCcr")
                RETURN
            ENDIF

            SELECT CrSigMvCcr
            loc_lOk = .T.

            *-- Verificar se conciliacao feita por outro usuario e sem permissao master
            IF CrSigMvCcr.Concs AND TRIM(CrSigMvCcr.UsuConcs) # TRIM(gc_4c_UsuarioLogado)
                IF !fChecaAcesso("SIGOPIND", "CONCMASTER")
                    MsgAviso("Concilia" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
                             "o Pode Ser Desfeita Por Este Usu" + CHR(225) + "rio!!!" + ;
                             CHR(13) + "Ela Foi Executada Por " + ;
                             ALLTRIM(CrSigMvCcr.UsuConcs) + "!!!", "")
                    loc_oPagHist.chk_4c_Chk_Concilia.Value = 1
                    loc_lOk = .F.
                ENDIF
            ENDIF

            *-- Verificar data da conciliacao informada
            IF PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5) AND loc_lOk
                IF EMPTY(loc_oPagHist.txt_4c_DataConcilia.Value)
                    MsgAviso("Data da Concilia" + CHR(231) + CHR(227) + ;
                             "o N" + CHR(227) + "o Informada...", "")
                    loc_oPagHist.txt_4c_DataConcilia.SetFocus()
                    loc_lOk = .F.
                ENDIF
            ENDIF

            *-- Verificar bloqueio de periodo (SigSyBlq)
            IF loc_lOk AND gnConnHandle > 0
                loc_cSQL = "SELECT * FROM SigSyBlq"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpBloq2") >= 1
                    IF RECCOUNT("cursor_4c_TmpBloq2") > 0
                        SELECT cursor_4c_TmpBloq2
                        GO TOP
                        IF cursor_4c_TmpBloq2.ChkConcs = 1 AND ;
                           PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5) AND ;
                           fVerificaBloqueio(loc_oPagHist.txt_4c_DataConcilia.Value, gnConnHandle) >= 0
                            MsgAviso("Per" + CHR(237) + "odo Bloqueado !!!", "")
                            loc_lOk = .F.
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_TmpBloq2")
                        USE IN cursor_4c_TmpBloq2
                    ENDIF
                ENDIF
            ENDIF

            SELECT CrSigMvCcr

            *-- Verificar data conciliacao >= data lancamento (somente ao conciliar)
            IF !CrSigMvCcr.Concs AND loc_lOk AND PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5)
                IF loc_oPagHist.txt_4c_DataConcilia.Value < CrSigMvCcr.Datas
                    MsgAviso("A Data da Concilia" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
                             "o Pode Ser Menor Que a Do Lan" + CHR(231) + "amento!!!", "")
                    loc_oPagHist.chk_4c_Chk_Concilia.Value = 0
                    loc_lOk = .F.
                ENDIF
            ENDIF

            *-- Confirmar desconciliacao
            IF CrSigMvCcr.Concs AND loc_lOk
                IF !MsgConfirma("Confirma a Desconcilia" + CHR(231) + CHR(227) + ;
                                "o do Lan" + CHR(231) + "amento?", ;
                                "Confirma" + CHR(231) + CHR(227) + "o")
                    loc_oPagHist.chk_4c_Chk_Concilia.Value = 1
                    loc_lOk = .F.
                ENDIF
            ENDIF

            IF !loc_lOk
                IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                    loc_oPagHist.grd_4c_Lancamento.Refresh()
                    loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
                ENDIF
                RETURN
            ENDIF

            *-- Verificar estado atual no banco (evitar race condition)
            loc_cSQL = "SELECT DataConcs, Concs, UsuConcs, CidChaves FROM SigMvCcr " + ;
                       "WHERE CidChaves = " + EscaparSQL(CrSigMvCcr.CidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccr3") > 0 AND ;
               RECCOUNT("cursor_4c_TmpMccr3") > 0

                SELECT cursor_4c_TmpMccr3
                IF loc_lPValue
                    IF cursor_4c_TmpMccr3.Concs
                        MsgAviso("Lan" + CHR(231) + "amento j" + CHR(225) + ;
                                 " conciliado Por " + ALLTRIM(cursor_4c_TmpMccr3.UsuConcs) + ;
                                 "!!!", "")
                        loc_oPagHist.chk_4c_Chk_Concilia.Value = 1
                        IF USED("cursor_4c_TmpMccr3")
                            USE IN cursor_4c_TmpMccr3
                        ENDIF
                        IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                            loc_oPagHist.grd_4c_Lancamento.Refresh()
                            loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
                        ENDIF
                        RETURN
                    ENDIF
                ELSE
                    IF !cursor_4c_TmpMccr3.Concs
                        MsgAviso("Lan" + CHR(231) + "amento j" + CHR(225) + ;
                                 " desconciliado !!!", "")
                        loc_oPagHist.chk_4c_Chk_Concilia.Value = 1
                        IF USED("cursor_4c_TmpMccr3")
                            USE IN cursor_4c_TmpMccr3
                        ENDIF
                        IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                            loc_oPagHist.grd_4c_Lancamento.Refresh()
                            loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
                        ENDIF
                        RETURN
                    ENDIF
                ENDIF

                loc_cCidChaves = TRIM(cursor_4c_TmpMccr3.CidChaves)
                IF USED("cursor_4c_TmpMccr3")
                    USE IN cursor_4c_TmpMccr3
                ENDIF

                SELECT CrSigMvCcr

                *-- Montar data para SQL Server
                loc_dData = IIF(PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5), ;
                                loc_oPagHist.txt_4c_DataConcilia.Value, DATE())
                loc_cDataSQL = TRANSFORM(YEAR(loc_dData), "9999") + "-" + ;
                               PADL(TRANSFORM(MONTH(loc_dData)), 2, "0") + "-" + ;
                               PADL(TRANSFORM(DAY(loc_dData)), 2, "0") + " 23:59:59"

                IF loc_lPValue
                    loc_cTipo   = "Conciliado"
                    loc_cUpdate = "UPDATE SigMvCcr SET DataConcs = '" + loc_cDataSQL + ;
                                  "', Concs = 1, UsuConcs = " + ;
                                  EscaparSQL(gc_4c_UsuarioLogado) + ;
                                  " WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)
                ELSE
                    loc_cTipo   = "DesConciliado"
                    loc_cUpdate = "UPDATE SigMvCcr SET DataConcs = NULL, " + ;
                                  "Concs = 0, UsuConcs = ' ' " + ;
                                  " WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)
                ENDIF

                *-- Inserir log em SigCqOch
                loc_cInsert = "INSERT INTO SigCqOch " + ;
                              "(Nopers, Datars, TpLancs, Datas, Usuars, CidChaves) " + ;
                              "VALUES (" + STR(CrSigMvCcr.Nopers) + ", GETDATE(), " + ;
                              EscaparSQL(loc_cTipo) + ", " + ;
                              IIF(loc_lPValue, "'" + loc_cDataSQL + "'", "NULL") + ", " + ;
                              EscaparSQL(gc_4c_UsuarioLogado) + ", NEWID())"

                loc_nResultIns = SQLEXEC(gnConnHandle, loc_cInsert)
                IF loc_nResultIns > 0
                    loc_nResultUpd = SQLEXEC(gnConnHandle, loc_cUpdate)
                    IF loc_nResultUpd > 0
                        *-- Atualizar cursor local CrSigMvCcr
                        SELECT CrSigMvCcr
                        IF loc_lPValue
                            REPLACE Concs     WITH .T., ;
                                    UsuConcs  WITH gc_4c_UsuarioLogado, ;
                                    DataConcs WITH loc_dData
                        ELSE
                            REPLACE Concs     WITH .F., ;
                                    UsuConcs  WITH " ", ;
                                    DataConcs WITH CTOD("  /  /  ")
                        ENDIF
                    ELSE
                        MsgErro("Falha ao atualizar SigMvCcr.", ;
                                "Erro em Concilia" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ELSE
                    MsgErro("Falha ao registrar log de concilia" + CHR(231) + ;
                            CHR(227) + "o.", "Erro em SigCqOch")
                ENDIF
            ELSE
                IF USED("cursor_4c_TmpMccr3")
                    USE IN cursor_4c_TmpMccr3
                ENDIF
                MsgErro("Favor Reinicializar o Processo!", ;
                        "Falha na Conex" + CHR(227) + "o (SigMvCcr)")
            ENDIF

            *-- Atualizar UI
            IF USED("CrSigMvCcr") AND !EOF("CrSigMvCcr")
                loc_oPagHist.chk_4c_Chk_Concilia.Value = IIF(CrSigMvCcr.Concs, 1, 0)
                loc_oPagHist.chk_4c_Chk_Concilia.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5)
                loc_oPagHist.txt_4c_DataConcilia.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                loc_oPagHist.grd_4c_Lancamento.Refresh()
                loc_oPagHist.grd_4c_Lancamento.SetFocus()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnConciliaHistClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE BtnAuditoriaHistClick
    * Auditar/DesAuditar lancamento selecionado no grd_4c_Lancamento
    * Equivale ao Chk_Auditoria.Click (100 linhas) do legado
    *==========================================================================
    PROCEDURE BtnAuditoriaHistClick()
        LOCAL loc_oErro, loc_oPagHist, loc_lTval, loc_cSQL, loc_cUpdate, loc_cTipo
        LOCAL loc_cCidChaves, loc_cDataSQL, loc_cInsert, loc_nErro
        LOCAL loc_dDataAudit
        PRIVATE llData

        TRY
            loc_oPagHist = THIS.pgf_4c_1.Page2

            *-- Ignorar se checkbox desabilitado ou lancamento provisorio
            IF !PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Auditoria", 5)
                RETURN
            ENDIF
            IF !loc_oPagHist.chk_4c_Chk_Auditoria.Enabled
                RETURN
            ENDIF
            IF USED("CrSigMvCcr") AND CrSigMvCcr.Tipo = "P"
                RETURN
            ENDIF

            THIS.DesabContainer()

            IF !USED("CrSigMvCcr") OR EOF("CrSigMvCcr") OR BOF("CrSigMvCcr")
                RETURN
            ENDIF

            loc_lTval = (loc_oPagHist.chk_4c_Chk_Auditoria.Value = 1)

            SELECT CrSigMvCcr

            *-- Verificar se auditoria feita por outro usuario sem permissao master
            IF !EMPTY(CrSigMvCcr.Auditors) AND ;
               (TRIM(CrSigMvCcr.Auditors) # TRIM(gc_4c_UsuarioLogado))
                IF !fChecaAcesso("SIGOPIND", "AUDMASTER")
                    MsgAviso("Auditoria N" + CHR(227) + "o Pode Ser Desfeita Por Este Usu" + ;
                             CHR(225) + "rio!!!" + CHR(13) + ;
                             "Ela Foi Executada Por " + ALLTRIM(CrSigMvCcr.Auditors) + ;
                             "!!!", "")
                    loc_oPagHist.chk_4c_Chk_Auditoria.Value = 1
                    IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                        loc_oPagHist.grd_4c_Lancamento.Refresh()
                        loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
                    ENDIF
                    RETURN
                ENDIF
            ENDIF

            *-- Sincronizar Chk_Concilia se acesso habilitado
            IF fChecaAcesso("SIGOPIND", "CONCILIA") AND ;
               PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Concilia", 5)
                IF USED("CrSigMvCcr") AND !EOF("CrSigMvCcr")
                    loc_oPagHist.chk_4c_Chk_Concilia.Value = IIF(CrSigMvCcr.Concs, 1, 0)
                ENDIF
            ENDIF

            *-- Calcular data de auditoria (hoje 23:59:59)
            loc_dDataAudit = DATE()
            loc_cDataSQL   = TRANSFORM(YEAR(loc_dDataAudit), "9999") + "-" + ;
                             PADL(TRANSFORM(MONTH(loc_dDataAudit)), 2, "0") + "-" + ;
                             PADL(TRANSFORM(DAY(loc_dDataAudit)), 2, "0") + " 23:59:59"

            *-- Verificar estado atual no banco
            LOCAL loc_cCta
            loc_cCta = IIF(!EMPTY(TRIM(loc_oPagHist.txt_4c_CtaCob.Value)), ;
                           PADR(TRIM(loc_oPagHist.txt_4c_CtaCob.Value), 10), ;
                           CrSigMvCcr.Contas)

            loc_cSQL = "SELECT DtAudits, Auditors, CidChaves FROM SigMvCcr " + ;
                       "WHERE GruConMoes = " + ;
                       EscaparSQL(CrSigMvCcr.Grupos + loc_cCta + CrSigMvCcr.Moedas) + ;
                       " AND Nopers = " + STR(CrSigMvCcr.Nopers) + ;
                       " AND Opers = " + EscaparSQL(CrSigMvCcr.Opers)

            loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccr4")
            IF loc_nErro > 0
                SELECT cursor_4c_TmpMccr4

                *-- Verificar estado atual de auditoria
                IF loc_lTval
                    IF !EMPTY(TRIM(cursor_4c_TmpMccr4.Auditors))
                        MsgAviso("Lan" + CHR(231) + "amento j" + CHR(225) + " Auditado Por " + ;
                                 ALLTRIM(cursor_4c_TmpMccr4.Auditors) + "!!!", "")
                        loc_oPagHist.chk_4c_Chk_Auditoria.Value = 1
                        IF USED("cursor_4c_TmpMccr4")
                            USE IN cursor_4c_TmpMccr4
                        ENDIF
                        IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                            loc_oPagHist.grd_4c_Lancamento.Refresh()
                            loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
                        ENDIF
                        RETURN
                    ENDIF
                ELSE
                    IF EMPTY(TRIM(cursor_4c_TmpMccr4.Auditors))
                        MsgAviso("Lan" + CHR(231) + "amento n" + CHR(227) + "o Auditado !!!", "")
                        loc_oPagHist.chk_4c_Chk_Auditoria.Value = 1
                        IF USED("cursor_4c_TmpMccr4")
                            USE IN cursor_4c_TmpMccr4
                        ENDIF
                        IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                            loc_oPagHist.grd_4c_Lancamento.Refresh()
                            loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
                        ENDIF
                        RETURN
                    ENDIF
                ENDIF

                loc_cCidChaves = TRIM(cursor_4c_TmpMccr4.CidChaves)
                IF USED("cursor_4c_TmpMccr4")
                    USE IN cursor_4c_TmpMccr4
                ENDIF

                IF loc_lTval
                    loc_cTipo   = "Auditado"
                    loc_cUpdate = "UPDATE SigMvCcr SET DtAudits = '" + loc_cDataSQL + ;
                                  "', Auditors = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                                  " WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)
                ELSE
                    loc_cTipo   = "DesAuditado"
                    loc_cUpdate = "UPDATE SigMvCcr SET DtAudits = NULL, " + ;
                                  "Auditors = '          ' " + ;
                                  " WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)
                ENDIF

                *-- Inserir log em SigCqOch
                SELECT CrSigMvCcr
                loc_cInsert = "INSERT INTO SigCqOch " + ;
                              "(Nopers, Datars, TpLancs, Datas, Usuars, CidChaves, DtLancs) " + ;
                              "VALUES (" + STR(CrSigMvCcr.Nopers) + ", GETDATE(), " + ;
                              EscaparSQL(loc_cTipo) + ", " + ;
                              IIF(loc_lTval, "'" + loc_cDataSQL + "'", "NULL") + ", " + ;
                              EscaparSQL(gc_4c_UsuarioLogado) + ", NEWID(), " + ;
                              FormatarDataSQL(CrSigMvCcr.Datas) + ")"

                IF SQLEXEC(gnConnHandle, loc_cInsert) > 0
                    loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate)
                    IF loc_nErro > 0
                        *-- Atualizar cursor local CrSigMvCcr
                        SELECT CrSigMvCcr
                        IF loc_lTval
                            REPLACE DtAudits WITH DATETIME(), ;
                                    Auditors WITH gc_4c_UsuarioLogado
                        ELSE
                            REPLACE DtAudits WITH {}, ;
                                    Auditors WITH " "
                        ENDIF
                    ELSE
                        MsgErro("Falha ao atualizar SigMvCcr.", ;
                                "Erro em Auditoria")
                    ENDIF
                ELSE
                    MsgErro("Falha ao registrar log de auditoria.", ;
                            "Erro em SigCqOch")
                ENDIF
            ELSE
                IF USED("cursor_4c_TmpMccr4")
                    USE IN cursor_4c_TmpMccr4
                ENDIF
                MsgErro("Favor Reinicializar o Processo!", ;
                        "Falha na Conex" + CHR(227) + "o (SigMvCcr Auditoria)")
            ENDIF

            *-- Atualizar UI
            IF PEMSTATUS(loc_oPagHist, "txt_4c_DtAudits", 5)
                loc_oPagHist.txt_4c_DtAudits.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_Auditors", 5)
                loc_oPagHist.txt_4c_Auditors.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "grd_4c_Lancamento", 5)
                loc_oPagHist.grd_4c_Lancamento.Refresh()
                loc_oPagHist.grd_4c_Lancamento.Column1.SetFocus()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnAuditoriaHistClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE FormKeyPress
    * Atalhos globais do form (equivale a SIGOPIND.KeyPress do legado, 75 linhas)
    * CTRL+Enter=Consultar, F2=FollowUp, CTRL+F2=FollowUpI, F3=Alterar,
    * F4=Excluir, F5=Procurar, F6=Imprimir, F7=Movimento, F8=Conciliar,
    * F9=Quitacao, F11=Auditoria
    *==========================================================================
    PROCEDURE FormKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagSaldo, loc_oPagHist, loc_nPagina
        TRY
            loc_oPagSaldo = THIS.pgf_4c_1.Page1
            loc_oPagHist  = THIS.pgf_4c_1.Page2
            loc_nPagina   = THIS.pgf_4c_1.ActivePage

            DO CASE
                CASE par_nKeyCode = 10 AND loc_nPagina = 2
                    *-- CTRL+Enter -> Consultar (volta para SALDO e dispara consulta)
                    NODEFAULT
                    THIS.BtnConsultarSaldoClick()

                CASE par_nKeyCode = -2 AND loc_nPagina = 2
                    *-- F3 -> Alterar
                    IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Alterar", 5) AND ;
                       loc_oPagHist.cmd_4c_Cmd_Alterar.Enabled
                        NODEFAULT
                        THIS.BtnAlterarHistClick()
                    ENDIF

                CASE par_nKeyCode = -3 AND loc_nPagina = 2
                    *-- F4 -> Excluir
                    IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_Excluir", 5) AND ;
                       loc_oPagHist.cmd_4c_Cmd_Excluir.Enabled
                        NODEFAULT
                        THIS.BtnExcluirHistClick()
                    ENDIF

                CASE par_nKeyCode = -5 AND loc_nPagina = 2
                    *-- F6 -> Imprimir (na pagina HIST)
                    IF PEMSTATUS(loc_oPagHist, "cmd_4c_Cmd_impressao", 5) AND ;
                       loc_oPagHist.cmd_4c_Cmd_impressao.Enabled
                        NODEFAULT
                        THIS.BtnImpressaoHistClick()
                    ENDIF

                CASE par_nKeyCode = -6 AND loc_nPagina = 2
                    *-- F7 -> Movimento (Anexa)
                    IF PEMSTATUS(loc_oPagHist, "cmd_4c_Anexa", 5) AND ;
                       loc_oPagHist.cmd_4c_Anexa.Enabled
                        NODEFAULT
                        THIS.BtnAnexaHistClick()
                    ENDIF

                CASE par_nKeyCode = -7 AND loc_nPagina = 2
                    *-- F8 -> Conciliar (toggle checkbox)
                    IF PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Concilia", 5) AND ;
                       loc_oPagHist.chk_4c_Chk_Concilia.Enabled
                        NODEFAULT
                        IF loc_oPagHist.chk_4c_Chk_Concilia.Value = 1
                            loc_oPagHist.chk_4c_Chk_Concilia.Value = 0
                        ELSE
                            loc_oPagHist.chk_4c_Chk_Concilia.Value = 1
                        ENDIF
                        THIS.BtnConciliaHistClick()
                    ENDIF

                CASE par_nKeyCode = 133 AND loc_nPagina = 2
                    *-- F11 -> Auditar (toggle checkbox)
                    IF PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Auditoria", 5) AND ;
                       loc_oPagHist.chk_4c_Chk_Auditoria.Enabled
                        NODEFAULT
                        IF loc_oPagHist.chk_4c_Chk_Auditoria.Value = 1
                            loc_oPagHist.chk_4c_Chk_Auditoria.Value = 0
                        ELSE
                            loc_oPagHist.chk_4c_Chk_Auditoria.Value = 1
                        ENDIF
                        THIS.BtnAuditoriaHistClick()
                    ENDIF

                CASE par_nKeyCode = -8 AND loc_nPagina = 2
                    *-- F9 -> Quitacao (Receber)
                    IF PEMSTATUS(loc_oPagHist, "cmd_4c_Chk_Quitacao", 5) AND ;
                       loc_oPagHist.cmd_4c_Chk_Quitacao.Enabled
                        NODEFAULT
                        THIS.BtnQuitacaoHistClick()
                    ENDIF

                CASE par_nKeyCode = -4 AND loc_nPagina = 2
                    *-- F5 -> Follow-up (Chk_Follow na pagina HIST)
                    IF PEMSTATUS(loc_oPagHist, "cmd_4c_Chk_Follow", 5) AND ;
                       loc_oPagHist.cmd_4c_Chk_Follow.Enabled
                        NODEFAULT
                        THIS.BtnFollowConciliaHistClick()
                    ENDIF

                CASE par_nKeyCode = -1 AND loc_nPagina = 2
                    *-- F2 -> Follow-up Conta
                    IF PEMSTATUS(loc_oPagHist, "cmd_4c_FollowUp", 5) AND ;
                       loc_oPagHist.cmd_4c_FollowUp.Enabled
                        NODEFAULT
                        THIS.BtnFollowUpHistClick()
                    ENDIF

                CASE par_nKeyCode = 95 AND loc_nPagina = 2
                    *-- CTRL+F2 -> Follow-up Lancamento
                    IF PEMSTATUS(loc_oPagHist, "cmd_4c_FollowLancto", 5) AND ;
                       loc_oPagHist.cmd_4c_FollowLancto.Enabled
                        NODEFAULT
                        THIS.BtnFollowUpIHistClick()
                    ENDIF

                CASE par_nKeyCode = -4 AND loc_nPagina = 1
                    *-- F5 -> Procurar (na pagina SALDO)
                    IF PEMSTATUS(loc_oPagSaldo, "cmd_4c_Cmd_procurar", 5) AND ;
                       loc_oPagSaldo.cmd_4c_Cmd_procurar.Enabled
                        NODEFAULT
                        THIS.BtnProcurarSaldoClick()
                    ENDIF

                CASE par_nKeyCode = -5 AND loc_nPagina = 1
                    *-- F6 -> Imprimir (na pagina SALDO)
                    IF PEMSTATUS(loc_oPagSaldo, "cmd_4c_Com_Imprimir2", 5) AND ;
                       loc_oPagSaldo.cmd_4c_Com_Imprimir2.Enabled
                        NODEFAULT
                        THIS.BtnImprimirSaldoClick()
                    ENDIF
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE PagSaldoActivate
    * Ao ativar Page1 (SALDO): desabilita HIST e limpa operacao
    *==========================================================================
    PROCEDURE PagSaldoActivate()
        TRY
            THIS.pgf_4c_1.Page2.Enabled = .F.
            THIS.this_cOperacao = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em PagSaldoActivate")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE PagSaldoClick
    * Ao clicar em Page1 (SALDO): desabilita HIST, limpa operacao, sai do hist
    *==========================================================================
    PROCEDURE PagSaldoClick()
        TRY
            THIS.pgf_4c_1.Page2.Enabled = .F.
            THIS.this_cOperacao = ""
            THIS.BtnSairHistClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em PagSaldoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE PagHistActivate
    * Ao ativar Page2 (HIST): verifica permissoes e configura controles
    * Equivale ao HIST.Activate do legado (33 linhas)
    *==========================================================================
    PROCEDURE PagHistActivate()
        LOCAL loc_oErro, loc_oPagHist, loc_lConcilia, loc_lAudita
        TRY
            loc_oPagHist = THIS.pgf_4c_1.Page2

            *-- Se nenhuma operacao ativa, forcar consulta
            IF EMPTY(THIS.this_cOperacao)
                THIS.BtnConsultarSaldoClick()
            ENDIF

            THIS.LockScreen = .T.

            *-- Verificar permissoes de conciliacao e auditoria
            loc_lConcilia = .F.
            loc_lAudita   = .F.
            IF USED("CrSigCdCli") AND !EOF("CrSigCdCli")
                loc_lConcilia = (fChecaAcesso("SIGOPIND", "CONCILIA") AND CrSigCdCli.Concilias = 1)
                loc_lAudita   = (fChecaAcesso("SIGOPIND", "AUDITORIA") AND CrSigCdCli.Concilias = 1)
            ENDIF

            *-- Habilitar/desabilitar controles de conciliacao
            IF PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Concilia", 5)
                loc_oPagHist.chk_4c_Chk_Concilia.Enabled = loc_lConcilia
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "cmb_4c_Concilia", 5)
                loc_oPagHist.cmb_4c_Concilia.Enabled = .T.
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5)
                loc_oPagHist.txt_4c_DataConcilia.Visible = loc_lConcilia
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "lbl_4c_SayData", 5)
                loc_oPagHist.lbl_4c_SayData.Visible = loc_lConcilia
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_Get3", 5)
                loc_oPagHist.txt_4c_Get3.Visible = loc_lConcilia
            ENDIF

            *-- Habilitar/desabilitar controles de auditoria
            IF PEMSTATUS(loc_oPagHist, "chk_4c_Chk_Auditoria", 5)
                loc_oPagHist.chk_4c_Chk_Auditoria.Enabled = loc_lAudita
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "lbl_4c_LblAuditoria", 5)
                loc_oPagHist.lbl_4c_LblAuditoria.Visible = loc_lAudita
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_DtAudits", 5)
                loc_oPagHist.txt_4c_DtAudits.Visible = loc_lAudita
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_Auditors", 5)
                loc_oPagHist.txt_4c_Auditors.Visible = loc_lAudita
            ENDIF

            *-- Refresh campos de info
            IF PEMSTATUS(loc_oPagHist, "txt_4c_HIST", 5)
                loc_oPagHist.txt_4c_HIST.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_Hist2", 5)
                loc_oPagHist.txt_4c_Hist2.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_1", 5)
                loc_oPagHist.txt_4c_1.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_Get3", 5)
                loc_oPagHist.txt_4c_Get3.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_Auditors", 5)
                loc_oPagHist.txt_4c_Auditors.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPagHist, "txt_4c_DtAudits", 5)
                loc_oPagHist.txt_4c_DtAudits.Refresh()
            ENDIF

            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro em PagHistActivate")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE PagHistClick
    * Ao clicar em Page2 (HIST): se nenhuma operacao ativa, forcar consulta
    *==========================================================================
    PROCEDURE PagHistClick()
        TRY
            IF EMPTY(THIS.this_cOperacao) OR !THIS.pgf_4c_1.Page2.Enabled
                THIS.BtnConsultarSaldoClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em PagHistClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE TxtDtInicialKeyPress
    * Valida data inicial: se > data final, ajusta data final
    * Equivale ao Dt_inicial.Valid do legado
    *==========================================================================
    PROCEDURE TxtDtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagSaldo
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            TRY
                loc_oPagSaldo = THIS.pgf_4c_1.Page1
                IF PEMSTATUS(loc_oPagSaldo, "txt_4c_Dt_inicial", 5) AND ;
                   PEMSTATUS(loc_oPagSaldo, "txt_4c_Dt_final", 5)
                    IF loc_oPagSaldo.txt_4c_Dt_inicial.Value > loc_oPagSaldo.txt_4c_Dt_final.Value
                        loc_oPagSaldo.txt_4c_Dt_final.Value = loc_oPagSaldo.txt_4c_Dt_inicial.Value
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro em TxtDtInicialKeyPress")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * PROCEDURE TxtDtFinalKeyPress
    * Valida data final: se < data inicial, ajusta data inicial
    * Equivale ao Dt_final.Valid do legado
    *==========================================================================
    PROCEDURE TxtDtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagSaldo
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            TRY
                loc_oPagSaldo = THIS.pgf_4c_1.Page1
                IF PEMSTATUS(loc_oPagSaldo, "txt_4c_Dt_final", 5) AND ;
                   PEMSTATUS(loc_oPagSaldo, "txt_4c_Dt_inicial", 5)
                    IF loc_oPagSaldo.txt_4c_Dt_final.Value < loc_oPagSaldo.txt_4c_Dt_inicial.Value
                        loc_oPagSaldo.txt_4c_Dt_inicial.Value = loc_oPagSaldo.txt_4c_Dt_final.Value
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro em TxtDtFinalKeyPress")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * PROCEDURE TxtDataConciliaKeyPress
    * Valida data de conciliacao (Get_Data.Valid do legado):
    * Se vazio, define como Date(). Senao, salva em this_dDataConcilia.
    * Get_Data.When do legado: habilitado somente se lancamento NAO conciliado.
    *==========================================================================
    PROCEDURE TxtDataConciliaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagHist
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            TRY
                loc_oPagHist = THIS.pgf_4c_1.Page2
                IF PEMSTATUS(loc_oPagHist, "txt_4c_DataConcilia", 5)
                    IF EMPTY(loc_oPagHist.txt_4c_DataConcilia.Value)
                        loc_oPagHist.txt_4c_DataConcilia.Value = DATE()
                    ELSE
                        THIS.this_dDataConcilia = loc_oPagHist.txt_4c_DataConcilia.Value
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro em TxtDataConciliaKeyPress")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * PROCEDURE FormParaBO
    * Transfere valores dos controles do formulario para as propriedades do BO.
    * Cobre filtros de cntSaldo (relatorio saldos) e cntImprime (historico).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag1, loc_oPag2, loc_oCntSaldo, loc_oCntImprime, loc_oErro

        TRY
            loc_oPag1       = THIS.pgf_4c_1.Page1
            loc_oPag2       = THIS.pgf_4c_1.Page2
            loc_oCntSaldo   = loc_oPag1.cnt_4c_Saldo
            loc_oCntImprime = loc_oPag2.cnt_4c_Imprime

            *-- Filtros de periodo da pagina SALDO
            IF PEMSTATUS(loc_oPag1, "txt_4c_Dt_inicial", 5)
                THIS.this_oBusinessObject.this_dDataInicialSaldo = loc_oPag1.txt_4c_Dt_inicial.Value
            ENDIF
            IF PEMSTATUS(loc_oPag1, "txt_4c_Dt_final", 5)
                THIS.this_oBusinessObject.this_dDataFinalSaldo = loc_oPag1.txt_4c_Dt_final.Value
            ENDIF
            IF PEMSTATUS(loc_oPag1, "txt_4c_Grupo", 5)
                THIS.this_oBusinessObject.this_cGrupos = TRIM(loc_oPag1.txt_4c_Grupo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPag1, "obj_4c_OptFiltro", 5)
                THIS.this_oBusinessObject.this_nOptFiltro = loc_oPag1.obj_4c_OptFiltro.Value
            ENDIF

            *-- Filtros do container cntSaldo (relatorio saldos)
            IF PEMSTATUS(loc_oCntSaldo, "txt_4c__cd_moeda", 5)
                THIS.this_oBusinessObject.this_cMoedaCodFiltro = TRIM(loc_oCntSaldo.txt_4c__cd_moeda.Value)
            ENDIF
            IF PEMSTATUS(loc_oCntSaldo, "txt_4c__ds_moeda", 5)
                THIS.this_oBusinessObject.this_cMoedaDescFiltro = TRIM(loc_oCntSaldo.txt_4c__ds_moeda.Value)
            ENDIF
            IF PEMSTATUS(loc_oCntSaldo, "txt_4c__dtlimite", 5)
                THIS.this_oBusinessObject.this_dDataLimiteFiltro = loc_oCntSaldo.txt_4c__dtlimite.Value
            ENDIF
            IF PEMSTATUS(loc_oCntSaldo, "obj_4c_OptOrdem", 5)
                THIS.this_oBusinessObject.this_nOrdemFiltro = loc_oCntSaldo.obj_4c_OptOrdem.Value
            ENDIF
            IF PEMSTATUS(loc_oCntSaldo, "chk_4c_ChkAscendente", 5)
                THIS.this_oBusinessObject.this_lAscendente = (loc_oCntSaldo.chk_4c_ChkAscendente.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oCntSaldo, "txt_4c_Situa", 5)
                THIS.this_oBusinessObject.this_cSituacaoFiltro = TRIM(loc_oCntSaldo.txt_4c_Situa.Value)
            ENDIF
            IF PEMSTATUS(loc_oCntSaldo, "chk_4c_CheckSaldo", 5)
                THIS.this_oBusinessObject.this_lImprimeSaldoZero = (loc_oCntSaldo.chk_4c_CheckSaldo.Value = 1)
            ENDIF

            *-- Filtros do container cntImprime (relatorio historico)
            IF PEMSTATUS(loc_oCntImprime, "txt_4c__dt_inicial", 5)
                THIS.this_oBusinessObject.this_dDtInicial = loc_oCntImprime.txt_4c__dt_inicial.Value
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "txt_4c__dt_final", 5)
                THIS.this_oBusinessObject.this_dDtFinal = loc_oCntImprime.txt_4c__dt_final.Value
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "txt_4c_CdMoeda", 5)
                THIS.this_oBusinessObject.this_cMoedaHistCod = TRIM(loc_oCntImprime.txt_4c_CdMoeda.Value)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "txt_4c_DsMoeda", 5)
                THIS.this_oBusinessObject.this_cMoedaHistDesc = TRIM(loc_oCntImprime.txt_4c_DsMoeda.Value)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "txt_4c_Emps", 5)
                THIS.this_oBusinessObject.this_cEmpsCod = TRIM(loc_oCntImprime.txt_4c_Emps.Value)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "txt_4c_DEmps", 5)
                THIS.this_oBusinessObject.this_cEmpsDesc = TRIM(loc_oCntImprime.txt_4c_DEmps.Value)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "txt_4c_Oper", 5)
                THIS.this_oBusinessObject.this_cGetOper = TRIM(loc_oCntImprime.txt_4c_Oper.Value)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_Chk_Grupo", 5)
                THIS.this_oBusinessObject.this_lChkGrupo = (loc_oCntImprime.chk_4c_Chk_Grupo.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_Check_Salto", 5)
                THIS.this_oBusinessObject.this_lCheckSalto = (loc_oCntImprime.chk_4c_Check_Salto.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_Check_sAnt", 5)
                THIS.this_oBusinessObject.this_lCheckSAnt = (loc_oCntImprime.chk_4c_Check_sAnt.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_RazaoCp", 5)
                THIS.this_oBusinessObject.this_lCheckRazaoCP = (loc_oCntImprime.chk_4c_RazaoCp.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_RazaoDoc", 5)
                THIS.this_oBusinessObject.this_lCheckRazaoDoc = (loc_oCntImprime.chk_4c_RazaoDoc.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_Check_Comissao", 5)
                THIS.this_oBusinessObject.this_lCheckComissao = (loc_oCntImprime.chk_4c_Check_Comissao.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_Check_Saldoa", 5)
                THIS.this_oBusinessObject.this_lCheckSaldoa = (loc_oCntImprime.chk_4c_Check_Saldoa.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_ChkTaxas", 5)
                THIS.this_oBusinessObject.this_lChkTaxas = (loc_oCntImprime.chk_4c_ChkTaxas.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_RelDets", 5)
                THIS.this_oBusinessObject.this_lChkRelDets = (loc_oCntImprime.chk_4c_RelDets.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "obj_4c_OptSNA", 5)
                THIS.this_oBusinessObject.this_nOptSNA = loc_oCntImprime.obj_4c_OptSNA.Value
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_ChkOcultaCta", 5)
                THIS.this_oBusinessObject.this_lChkOcultaCta = (loc_oCntImprime.chk_4c_ChkOcultaCta.Value = 1)
            ENDIF
            *-- Cmb_Concilia esta na Page2 (HIST), nao no cntImprime
            IF PEMSTATUS(loc_oPag2, "cmb_4c_Concilia", 5)
                THIS.this_oBusinessObject.this_nCmbConcilia = loc_oPag2.cmb_4c_Concilia.ListIndex
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE BOParaForm
    * Transfere propriedades do BO de volta para os controles do formulario.
    * Usado apos carga ou cancelamento.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag1, loc_oPag2, loc_oCntSaldo, loc_oCntImprime, loc_oErro

        TRY
            loc_oPag1       = THIS.pgf_4c_1.Page1
            loc_oPag2       = THIS.pgf_4c_1.Page2
            loc_oCntSaldo   = loc_oPag1.cnt_4c_Saldo
            loc_oCntImprime = loc_oPag2.cnt_4c_Imprime

            *-- Periodo da pagina SALDO
            IF PEMSTATUS(loc_oPag1, "txt_4c_Dt_inicial", 5)
                loc_oPag1.txt_4c_Dt_inicial.Value = THIS.this_oBusinessObject.this_dDataInicialSaldo
            ENDIF
            IF PEMSTATUS(loc_oPag1, "txt_4c_Dt_final", 5)
                loc_oPag1.txt_4c_Dt_final.Value = THIS.this_oBusinessObject.this_dDataFinalSaldo
            ENDIF
            IF PEMSTATUS(loc_oPag1, "txt_4c_Grupo", 5)
                loc_oPag1.txt_4c_Grupo.Value = THIS.this_oBusinessObject.this_cGrupos
            ENDIF
            IF PEMSTATUS(loc_oPag1, "obj_4c_OptFiltro", 5)
                loc_oPag1.obj_4c_OptFiltro.Value = THIS.this_oBusinessObject.this_nOptFiltro
            ENDIF

            *-- Container cntSaldo
            IF PEMSTATUS(loc_oCntSaldo, "txt_4c__cd_moeda", 5)
                loc_oCntSaldo.txt_4c__cd_moeda.Value = THIS.this_oBusinessObject.this_cMoedaCodFiltro
            ENDIF
            IF PEMSTATUS(loc_oCntSaldo, "txt_4c__ds_moeda", 5)
                loc_oCntSaldo.txt_4c__ds_moeda.Value = THIS.this_oBusinessObject.this_cMoedaDescFiltro
            ENDIF
            IF PEMSTATUS(loc_oCntSaldo, "txt_4c__dtlimite", 5)
                loc_oCntSaldo.txt_4c__dtlimite.Value = THIS.this_oBusinessObject.this_dDataLimiteFiltro
            ENDIF
            IF PEMSTATUS(loc_oCntSaldo, "obj_4c_OptOrdem", 5)
                loc_oCntSaldo.obj_4c_OptOrdem.Value = THIS.this_oBusinessObject.this_nOrdemFiltro
            ENDIF
            IF PEMSTATUS(loc_oCntSaldo, "chk_4c_ChkAscendente", 5)
                loc_oCntSaldo.chk_4c_ChkAscendente.Value = IIF(THIS.this_oBusinessObject.this_lAscendente, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oCntSaldo, "txt_4c_Situa", 5)
                loc_oCntSaldo.txt_4c_Situa.Value = THIS.this_oBusinessObject.this_cSituacaoFiltro
            ENDIF
            IF PEMSTATUS(loc_oCntSaldo, "chk_4c_CheckSaldo", 5)
                loc_oCntSaldo.chk_4c_CheckSaldo.Value = IIF(THIS.this_oBusinessObject.this_lImprimeSaldoZero, 1, 0)
            ENDIF

            *-- Container cntImprime
            IF PEMSTATUS(loc_oCntImprime, "txt_4c__dt_inicial", 5)
                loc_oCntImprime.txt_4c__dt_inicial.Value = THIS.this_oBusinessObject.this_dDtInicial
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "txt_4c__dt_final", 5)
                loc_oCntImprime.txt_4c__dt_final.Value = THIS.this_oBusinessObject.this_dDtFinal
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "txt_4c_CdMoeda", 5)
                loc_oCntImprime.txt_4c_CdMoeda.Value = THIS.this_oBusinessObject.this_cMoedaHistCod
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "txt_4c_DsMoeda", 5)
                loc_oCntImprime.txt_4c_DsMoeda.Value = THIS.this_oBusinessObject.this_cMoedaHistDesc
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "txt_4c_Emps", 5)
                loc_oCntImprime.txt_4c_Emps.Value = THIS.this_oBusinessObject.this_cEmpsCod
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "txt_4c_DEmps", 5)
                loc_oCntImprime.txt_4c_DEmps.Value = THIS.this_oBusinessObject.this_cEmpsDesc
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "txt_4c_Oper", 5)
                loc_oCntImprime.txt_4c_Oper.Value = THIS.this_oBusinessObject.this_cGetOper
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_Chk_Grupo", 5)
                loc_oCntImprime.chk_4c_Chk_Grupo.Value = IIF(THIS.this_oBusinessObject.this_lChkGrupo, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_Check_Salto", 5)
                loc_oCntImprime.chk_4c_Check_Salto.Value = IIF(THIS.this_oBusinessObject.this_lCheckSalto, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_Check_sAnt", 5)
                loc_oCntImprime.chk_4c_Check_sAnt.Value = IIF(THIS.this_oBusinessObject.this_lCheckSAnt, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_RazaoCp", 5)
                loc_oCntImprime.chk_4c_RazaoCp.Value = IIF(THIS.this_oBusinessObject.this_lCheckRazaoCP, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_RazaoDoc", 5)
                loc_oCntImprime.chk_4c_RazaoDoc.Value = IIF(THIS.this_oBusinessObject.this_lCheckRazaoDoc, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_Check_Comissao", 5)
                loc_oCntImprime.chk_4c_Check_Comissao.Value = IIF(THIS.this_oBusinessObject.this_lCheckComissao, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_Check_Saldoa", 5)
                loc_oCntImprime.chk_4c_Check_Saldoa.Value = IIF(THIS.this_oBusinessObject.this_lCheckSaldoa, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_ChkTaxas", 5)
                loc_oCntImprime.chk_4c_ChkTaxas.Value = IIF(THIS.this_oBusinessObject.this_lChkTaxas, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_RelDets", 5)
                loc_oCntImprime.chk_4c_RelDets.Value = IIF(THIS.this_oBusinessObject.this_lChkRelDets, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "obj_4c_OptSNA", 5)
                loc_oCntImprime.obj_4c_OptSNA.Value = THIS.this_oBusinessObject.this_nOptSNA
            ENDIF
            IF PEMSTATUS(loc_oCntImprime, "chk_4c_ChkOcultaCta", 5)
                loc_oCntImprime.chk_4c_ChkOcultaCta.Value = IIF(THIS.this_oBusinessObject.this_lChkOcultaCta, 1, 0)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE LimparCampos
    * Restaura campos de filtro da pagina SALDO para estado inicial.
    * Equivale ao comportamento de "novo ciclo" no legado.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag1, loc_oCntSaldo, loc_oCntConsulta, loc_oErro

        TRY
            loc_oPag1 = THIS.pgf_4c_1.Page1

            *-- Limpar campos de periodo
            IF PEMSTATUS(loc_oPag1, "txt_4c_Dt_inicial", 5)
                loc_oPag1.txt_4c_Dt_inicial.Value = DATE() - 30
            ENDIF
            IF PEMSTATUS(loc_oPag1, "txt_4c_Dt_final", 5)
                loc_oPag1.txt_4c_Dt_final.Value = DATE()
            ENDIF

            *-- Limpar campos de grupo
            IF PEMSTATUS(loc_oPag1, "txt_4c_Grupo", 5)
                loc_oPag1.txt_4c_Grupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPag1, "txt_4c_DGrupo", 5)
                loc_oPag1.txt_4c_DGrupo.Value = ""
            ENDIF

            *-- Resetar optFiltro para "Todos" (1)
            IF PEMSTATUS(loc_oPag1, "obj_4c_OptFiltro", 5)
                loc_oPag1.obj_4c_OptFiltro.Value = 1
            ENDIF

            *-- Limpar cntConsulta
            IF PEMSTATUS(loc_oPag1, "cnt_4c_Consulta", 5)
                loc_oCntConsulta = loc_oPag1.cnt_4c_Consulta
                IF PEMSTATUS(loc_oCntConsulta, "txt_4c_Cd_Conta", 5)
                    loc_oCntConsulta.txt_4c_Cd_Conta.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oCntConsulta, "txt_4c__ds_conta", 5)
                    loc_oCntConsulta.txt_4c__ds_conta.Value = ""
                ENDIF
                loc_oCntConsulta.Visible = .F.
            ENDIF

            *-- Limpar cntSaldo e ocult-lo
            IF PEMSTATUS(loc_oPag1, "cnt_4c_Saldo", 5)
                loc_oCntSaldo = loc_oPag1.cnt_4c_Saldo
                IF PEMSTATUS(loc_oCntSaldo, "txt_4c__cd_moeda", 5)
                    loc_oCntSaldo.txt_4c__cd_moeda.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oCntSaldo, "txt_4c__ds_moeda", 5)
                    loc_oCntSaldo.txt_4c__ds_moeda.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oCntSaldo, "txt_4c__dtlimite", 5)
                    loc_oCntSaldo.txt_4c__dtlimite.Value = {}
                ENDIF
                IF PEMSTATUS(loc_oCntSaldo, "obj_4c_OptOrdem", 5)
                    loc_oCntSaldo.obj_4c_OptOrdem.Value = 1
                ENDIF
                IF PEMSTATUS(loc_oCntSaldo, "chk_4c_ChkAscendente", 5)
                    loc_oCntSaldo.chk_4c_ChkAscendente.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oCntSaldo, "txt_4c_Situa", 5)
                    loc_oCntSaldo.txt_4c_Situa.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oCntSaldo, "chk_4c_CheckSaldo", 5)
                    loc_oCntSaldo.chk_4c_CheckSaldo.Value = 0
                ENDIF
                loc_oCntSaldo.Visible = .F.
            ENDIF

            *-- Limpar cursor de saldos
            IF USED("cursor_4c_Saldos")
                SELECT cursor_4c_Saldos
                ZAP
            ENDIF

            *-- Resetar propriedades internas
            THIS.this_cGrupoOper    = ""
            THIS.this_cCliente      = SPACE(10)
            THIS.this_cOperacao     = ""
            THIS.this_dDataConcilia = {}

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE CarregarLista
    * Carrega o grid de saldos (grd_saldo na pagina SALDO) usando MontaGrade.
    * Equivale ao comportamento de carga inicial do legado.
    * Apenas executa se houver grupo definido e conexao ativa.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cGrupo, loc_oPag1, loc_oErro

        TRY
            IF gnConnHandle <= 0
                RETURN
            ENDIF
            loc_oPag1  = THIS.pgf_4c_1.Page1
            loc_cGrupo = ""
            IF PEMSTATUS(loc_oPag1, "txt_4c_Grupo", 5)
                loc_cGrupo = TRIM(loc_oPag1.txt_4c_Grupo.Value)
            ENDIF
            IF !EMPTY(loc_cGrupo)
                THIS.MontaGrade(loc_cGrupo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em CarregarLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE HabilitarCampos
    * Habilita ou desabilita os controles de filtro da pagina SALDO conforme
    * o estado operacional (se ja ha operacao em andamento ou nao).
    * par_lHabilitar: .T. = habilitar, .F. = desabilitar
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag1, loc_oErro
        LOCAL loc_lHab

        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        TRY
            loc_oPag1 = THIS.pgf_4c_1.Page1

            *-- Filtros de periodo e grupo habilitados apenas sem operacao ativa
            IF PEMSTATUS(loc_oPag1, "txt_4c_Dt_inicial", 5)
                loc_oPag1.txt_4c_Dt_inicial.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPag1, "txt_4c_Dt_final", 5)
                loc_oPag1.txt_4c_Dt_final.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPag1, "txt_4c_Grupo", 5)
                loc_oPag1.txt_4c_Grupo.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPag1, "txt_4c_DGrupo", 5)
                loc_oPag1.txt_4c_DGrupo.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPag1, "obj_4c_OptFiltro", 5)
                loc_oPag1.obj_4c_OptFiltro.Enabled = loc_lHab
            ENDIF

            *-- Botoes de acao e navegacao da pagina SALDO
            IF PEMSTATUS(loc_oPag1, "obj_4c_Grp_operacao", 5)
                loc_oPag1.obj_4c_Grp_operacao.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPag1, "cmd_4c_Cmd_procurar", 5)
                loc_oPag1.cmd_4c_Cmd_procurar.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPag1, "cmd_4c_Com_Imprimir2", 5)
                loc_oPag1.cmd_4c_Com_Imprimir2.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPag1, "grd_4c_Dados", 5)
                loc_oPag1.grd_4c_Dados.Enabled = loc_lHab
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE AjustarBotoesPorModo
    * Ajusta estado dos botoes da pagina HIST conforme o modo corrente.
    * Chamado apos carregar lancamento, alterar ou excluir.
    * Quando operacao = "" (sem conta selecionada): desabilita botoes de edicao.
    * Quando operacao # "" (conta ativa): habilita botoes conforme acesso.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPag2, loc_lTemRegistro, loc_lNaoProvisorio, loc_oErro

        TRY
            loc_oPag2       = THIS.pgf_4c_1.Page2
            loc_lTemRegistro   = USED("CrSigMvCcr") AND !EOF("CrSigMvCcr") AND !EMPTY(THIS.this_cOperacao)
            loc_lNaoProvisorio = .T.

            *-- Verificar se lancamento corrente e provisorio (Tipo = "P")
            IF loc_lTemRegistro AND USED("CrSigMvCcr")
                IF !EOF("CrSigMvCcr")
                    loc_lNaoProvisorio = (CrSigMvCcr.Tipo # "P")
                ENDIF
            ENDIF

            *-- Botoes de acao da pagina HIST
            IF PEMSTATUS(loc_oPag2, "cmd_4c_Cmd_Consulta", 5)
                loc_oPag2.cmd_4c_Cmd_Consulta.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
            ENDIF
            IF PEMSTATUS(loc_oPag2, "cmd_4c_Cmd_Alterar", 5)
                loc_oPag2.cmd_4c_Cmd_Alterar.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
            ENDIF
            IF PEMSTATUS(loc_oPag2, "cmd_4c_Cmd_Excluir", 5)
                loc_oPag2.cmd_4c_Cmd_Excluir.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
            ENDIF
            IF PEMSTATUS(loc_oPag2, "cmd_4c_Cmd_impressao", 5)
                loc_oPag2.cmd_4c_Cmd_impressao.Enabled = loc_lTemRegistro
            ENDIF
            IF PEMSTATUS(loc_oPag2, "cmd_4c_Anexa", 5)
                loc_oPag2.cmd_4c_Anexa.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
            ENDIF
            IF PEMSTATUS(loc_oPag2, "cmd_4c_Chk_Quitacao", 5)
                loc_oPag2.cmd_4c_Chk_Quitacao.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
            ENDIF
            IF PEMSTATUS(loc_oPag2, "cmd_4c_Chk_Follow", 5)
                loc_oPag2.cmd_4c_Chk_Follow.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
            ENDIF
            IF PEMSTATUS(loc_oPag2, "cmd_4c_FollowUp", 5)
                loc_oPag2.cmd_4c_FollowUp.Enabled = loc_lTemRegistro
            ENDIF
            IF PEMSTATUS(loc_oPag2, "cmd_4c_FollowLancto", 5)
                loc_oPag2.cmd_4c_FollowLancto.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
            ENDIF
            IF PEMSTATUS(loc_oPag2, "cmd_4c_Procura", 5)
                loc_oPag2.cmd_4c_Procura.Enabled = loc_lTemRegistro
            ENDIF

            *-- CheckBoxes de conciliacao e auditoria: habilitados conforme acesso
            IF PEMSTATUS(loc_oPag2, "chk_4c_Chk_Concilia", 5)
                loc_oPag2.chk_4c_Chk_Concilia.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
            ENDIF
            IF PEMSTATUS(loc_oPag2, "chk_4c_Chk_Auditoria", 5)
                loc_oPag2.chk_4c_Chk_Auditoria.Enabled = loc_lTemRegistro AND loc_lNaoProvisorio
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PROCEDURE Destroy
    *==========================================================================
    PROCEDURE Destroy()
        *-- Liberar cursores
        IF USED("cursor_4c_Saldos")
            USE IN cursor_4c_Saldos
        ENDIF
        IF USED("CrSigMvCcr")
            USE IN CrSigMvCcr
        ENDIF
        IF USED("cursor_4c_Matrizes")
            USE IN cursor_4c_Matrizes
        ENDIF
        IF USED("cursor_4c_TmpMccr")
            USE IN cursor_4c_TmpMccr
        ENDIF
        IF USED("cursor_4c_Baixas")
            USE IN cursor_4c_Baixas
        ENDIF
        IF USED("xTmpBaixa")
            USE IN xTmpBaixa
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
