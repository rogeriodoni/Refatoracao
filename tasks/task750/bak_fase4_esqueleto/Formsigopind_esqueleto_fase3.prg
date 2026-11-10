*==============================================================================
* Formsigopind.prg - Individual (Conciliacao / Extrato Individual de Conta
* Corrente - Contas a Receber/Pagar)
*==============================================================================
* Herda de: FormBase
* BO: sigopindBO
* Legado: SIGOPIND.SCX (tasks/task750/sigopind_form_codigo_fonte.txt)
* Tipo: OPERACIONAL (form com PageFrame de 2 paginas REAIS com abas
*       visiveis: "Saldo" (Page1/SALDO) e "Historico" (Page2/HIST) - NAO
*       segue o padrao Page1=Lista/Page2=Dados de CRUD). SIGOPIND herda de
*       "form" puro no legado (Class=BaseClass="form"), sem VCX customizado,
*       logo as abas do PageFrame NAO sao escondidas (regra CLAUDE.md #11 -
*       faixa/compensacao +29 - NAO se aplica aqui; essa regra eh exclusiva
*       do PageFrame oculto do framework clsCadastro usado pelos forms CRUD).
*
* Dump legado (SECAO 2 do dump, linhas 960-1004):
*   SIGOPIND:      DataSession=2, BorderStyle=2, Height=600, Width=1000,
*                  AutoCenter=.T., ShowTips=.T., Caption="Individual",
*                  ControlBox=.F., MaxButton=.F., MinButton=.F., TitleBar=0,
*                  BackColor=255,255,255. Properties customizadas
*                  (cidchaves/grupooper/matrizes/txtcre/txtdeb/reg) ja
*                  migradas para o BO na Fase 1 (this_cCidChaves/
*                  this_cGrupoOper/this_lMatrizes/this_cTxtCre/this_cTxtDeb/
*                  this_nReg).
*   SIGOPIND.Page: ErasePage=.T., PageCount=2, Top=-28, Left=0, Width=1004,
*                  Height=635. Page1.Caption="Saldo" / Page1.Name="SALDO" /
*                  Page1.Picture=new_background.jpg / Page1.ForeColor=0,0,0.
*                  Page2.Caption="Historico" / Page2.Name="HIST" /
*                  Page2.Picture=new_background.jpg (sem ForeColor no dump -
*                  nao inventar).
*   SIGOPIND.Page.SALDO.cntSombra: Top=0, Left=0, Width=1100 (THIS.Width no
*                  migrado - regra do projeto, nao 1100 literal), Height=80,
*                  BorderWidth=0, BackColor=100,100,100. lblSombra/
*                  lblTitulo recebem o Caption do form no Init legado
*                  ("ThisForm.Page.SALDO.cntSombra.lblSombra.Caption =
*                  ThisForm.Caption"). A pagina Historico NAO tem cntSombra
*                  propria no legado - transcrito literal (PILAR 1), NAO
*                  duplicar a faixa na 2a pagina (essa duplicacao so eh
*                  regra para o frmcadastro CRUD - CLAUDE.md #11).
*
* Montagem (migracao multi-fase):
*   Fase 1/2 (feitas) - sigopindBO.prg: propriedades + Init + CarregarDoCursor
*                       + ObterChavePrimaria + Inserir (recusa - tabela nao
*                       aceita INCLUIR nesta tela) + Atualizar.
*   Fase 3 (esta)     - DEFINE CLASS, propriedades, Init/Destroy/
*                       InicializarForm, ConfigurarPageFrame() com
*                       ConfigurarPgfPaginas() (pgf_4c_1, Page1="Saldo",
*                       Page2="Historico") + ConfigurarCabecalho() (cnt_4c_
*                       Sombra dentro de Page1, com lbl_4c_LblSombra/
*                       lbl_4c_LblTitulo), TornarControlesVisiveis().
*   Fase 4            - Grid grd_4c_Dados (Page1/Saldo) + CommandGroup de
*                       navegacao/saida (Grupo_op, em cada pagina) +
*                       containers flutuantes SigCcrConsulta/SigCcrSaldos
*                       (Page1, Visible=.F.) - TornarControlesVisiveis()
*                       tera de EXCLUIR esses dois do passo recursivo
*                       (regra da task: filtrar por nome).
*   Fase 5/6          - Grid grd_4c_Lancamento (Page2/Historico), campos de
*                       filtro/periodo, botoes de acao da grade de Historico
*                       + containers flutuantes SigCcrimpressao/
*                       SigCcrQuitacao (Page2, Visible=.F. - mesmo filtro).
*   Fase 7/8          - Eventos (Conciliar/Auditar/Excluir/FollowUp/
*                       Impressao), FormParaBO()/BOParaForm(), carga via
*                       SQLEXEC dos cursores de apoio (SigCdGcr/SigCdEmp/
*                       SigCdMoe/SigCdPam/SigCdCli) do Init legado.
*
* Nomes de objeto conforme tasks/task750/mapeamento.json.
*==============================================================================

DEFINE CLASS Formsigopind AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form (SIGOPIND.SCX: DataSession=2, BorderStyle=2,
    * Height=600, Width=1000, AutoCenter=.T., ShowTips=.T., ControlBox=.F.,
    * MaxButton=.F., MinButton=.F., TitleBar=0, BackColor=255,255,255 - dump
    * linhas 960-983). ShowWindow/WindowType NAO constam do dump - seguem o
    * padrao canonico do projeto (modal, igual FormCor/Formsigopfis).
    *--------------------------------------------------------------------------
    Width        = 1000
    Height       = 600
    DataSession  = 2
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    BackColor    = RGB(255, 255, 255)
    FontName     = "Tahoma"
    FontSize     = 8

    Caption = "Individual"

    *--------------------------------------------------------------------------
    * Init - cria o Business Object ANTES do DODEFAULT(), para que
    * InicializarForm() (chamado por FormBase.Init() via DODEFAULT) ja o
    * encontre pronto. SIGOPIND nao recebe parametros no Init legado
    * (abre direto pelo menu, sem form pai).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopindBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = DODEFAULT()
            ELSE
                MsgErro("Falha ao criar sigopindBO.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Individual: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - encadeia direto para FormBase.Destroy() (libera
    * this_oBusinessObject e restaura o menu principal). SIGOPIND nao tem
    * form pai (abre direto pelo menu) - nao ha referencia externa a
    * reabilitar.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a tela via ConfigurarPageFrame(): PageFrame de
    * 2 abas + cabecalho nesta fase; grids/campos/botoes nas fases
    * seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("sigopindBO n" + CHR(227) + "o foi inicializado.", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                *-- Grade de Saldo nasce VAZIA - o legado (MontaGrade) so
                *-- popula crSigMvSlc quando o usuario informa o Grupo
                *-- (Get_Grupo/Get_DGrupo entram na Fase 5); filtro 1 =
                *-- Global, mesma semantica de optFiltro.Value.
                THIS.CarregarLista("", 1)

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopind.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de montagem visual.
    *   Fase 3        - ConfigurarPgfPaginas() (pgf_4c_1, paginas vazias) +
    *                   ConfigurarCabecalho() (cnt_4c_Sombra dentro de Page1
    *                   - tem de rodar DEPOIS de ConfigurarPgfPaginas(), pois
    *                   depende de THIS.pgf_4c_1.Page1 ja existir).
    *   Fase 4 (esta) - ConfigurarGridSaldo() (grd_4c_Dados, ligado ao
    *                   cursor_4c_Saldo) + ConfigurarBotoesSaldo()
    *                   (obj_4c_Grp_operacao: Consultar/Encerrar). Os
    *                   botoes cmd_procurar/Com_Imprimir2 e os containers
    *                   flutuantes SigCcrConsulta/SigCcrSaldos (Page1)
    *                   ficam para a Fase 5/6, junto dos campos de filtro
    *                   (Get_Grupo/Get_DGrupo/Dt_inicial/Dt_final/
    *                   optFiltro) que os acompanham.
    *   Fase 5/6      - campos de filtro de Page1 + grid/campos de Page2 +
    *                   containers flutuantes de Page1 e Page2.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarPgfPaginas()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGridSaldo()
        THIS.ConfigurarBotoesSaldo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgfPaginas - PageFrame com 2 abas REAIS e visiveis (dump
    * legado linhas 989-1003: ErasePage=.T., PageCount=2, Top=-28, Left=0,
    * Width=1004, Height=635). Page1="Saldo" (Name="SALDO"), Page2=
    * "Historico" (Name="HIST"). Ambas as paginas usam o mesmo Picture de
    * fundo do framework legado (new_background.jpg); so Page1 declara
    * ForeColor=RGB(0,0,0) no dump - Page2 fica sem override (nao inventar).
    * Paginas ficam vazias de controles nesta fase - grid/campos/botoes
    * entram nas Fases 4/5/6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgfPaginas()
        LOCAL loc_cPicture, loc_oErro

        TRY
            loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            THIS.AddObject("pgf_4c_1", "PageFrame")
            WITH THIS.pgf_4c_1
                .PageCount  = 2
                .Top        = -28
                .Left       = 0
                .Width      = 1004
                .Height     = 635
                .Visible    = .T.
                .ActivePage = 1
            ENDWITH

            WITH THIS.pgf_4c_1.Page1
                .Caption   = "Saldo"
                .ForeColor = RGB(0, 0, 0)
                IF FILE(loc_cPicture)
                    .Picture = loc_cPicture
                ENDIF
            ENDWITH

            WITH THIS.pgf_4c_1.Page2
                .Caption = "Hist" + CHR(243) + "rico"
                IF FILE(loc_cPicture)
                    .Picture = loc_cPicture
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPgfPaginas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do form,
    * criado DENTRO de Page1 (pgf_4c_1.Page1), igual ao legado (cntSombra
    * eh filho de SIGOPIND.Page.SALDO, nao do form direto - a pagina
    * Historico nao tem faixa propria, transcrito literal do dump).
    * Original: cntSombra Top=0, Left=0, Width=1100, Height=80,
    * BackColor=RGB(100,100,100) - Width usa THIS.Width (canonico do
    * projeto) em vez do literal 1100 do dump. lblSombra/lblTitulo recebem
    * o Caption do form (equivalente ao Init legado que faz
    * "ThisForm.Page.SALDO.cntSombra.lblSombra.Caption = ThisForm.Caption").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
            THIS.pgf_4c_1.Page1.AddObject("cnt_4c_Sombra", "Container")
            loc_oCnt = THIS.pgf_4c_1.Page1.cnt_4c_Sombra
            WITH loc_oCnt
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackColor   = RGB(100, 100, 100)
                .Visible     = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCnt.lbl_4c_LblSombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = 769
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = 769
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridSaldo - Grid de saldos por conta/moeda (Page1/Saldo),
    * ligado ao cursor_4c_Saldo (mesmo nome de this_oBusinessObject.
    * this_cCursorSaldo). O cursor nasce VAZIO - o legado so popula
    * crSigMvSlc via MontaGrade(pGru) quando o usuario informa o Grupo.
    * Estrutura/ControlSource/Header/Width/ColumnOrder transcritos do dump
    * legado (SIGOPIND.Page.SALDO.grd_saldo, linhas 1059-1145):
    * Column1=Contas(100,ordem1) Column2=Rclis(433,ordem2)
    * Column3=Moedas(43,ordem5) Column4=Saldos(140,ordem4)
    * Column5=Emps(41,ordem6) Column6=Cpfs(136,ordem3) Column7=Matriz(28,
    * ordem7). DynamicBackColor reproduz o
    * "SetAll('DynamicBackColor', IIf Matriz=M verde / F amarelo)" do
    * legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridSaldo()
        LOCAL loc_oGrid, loc_cCursor, loc_oErro

        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldo

            IF !USED(loc_cCursor)
                SET NULL ON
                CREATE CURSOR (loc_cCursor) ;
                    (Emps C(3), Grupos C(10), Contas C(10), Moedas C(3), ;
                     Saldos N(13,2), Rclis C(50), Situas C(3), Cpfs C(20), ;
                     Contamats C(10), Matriz C(1))
                SET NULL OFF

                SELECT (loc_cCursor)
                INDEX ON Contas TAG Contas ADDITIVE
                INDEX ON Rclis  TAG Rclis  ADDITIVE
                INDEX ON Cpfs   TAG Cpfs   ADDITIVE
            ENDIF

            THIS.pgf_4c_1.Page1.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = THIS.pgf_4c_1.Page1.grd_4c_Dados
            WITH loc_oGrid
                .Top           = 140
                .Left          = 10
                .Width         = 980
                .Height        = 453
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ReadOnly      = .T.
                .RecordMark    = .T.
                .DeleteMark    = .F.
                .ScrollBars    = 2
                .GridLineColor = RGB(238, 238, 238)
                .Themes        = .F.

                .RecordSource  = ""
                .ColumnCount   = 7
                .RecordSource  = loc_cCursor

                .Column1.ControlSource     = loc_cCursor + ".Contas"
                .Column1.ColumnOrder       = 1
                .Column1.Width             = 100
                .Column1.Movable           = .F.
                .Column1.Resizable         = .F.
                .Column1.ReadOnly          = .T.
                .Column1.Header1.Caption   = "Conta "
                .Column1.Header1.Alignment = 2
                .Column1.Header1.ForeColor = RGB(90, 90, 90)
                .Column1.Header1.BackColor = RGB(255, 255, 255)

                .Column2.ControlSource     = loc_cCursor + ".Rclis"
                .Column2.ColumnOrder       = 2
                .Column2.Width             = 433
                .Column2.Movable           = .F.
                .Column2.Resizable         = .F.
                .Column2.ReadOnly          = .T.
                .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Column2.Header1.Alignment = 2
                .Column2.Header1.ForeColor = RGB(90, 90, 90)
                .Column2.Header1.BackColor = RGB(255, 255, 255)

                .Column3.ControlSource     = loc_cCursor + ".Moedas"
                .Column3.ColumnOrder       = 5
                .Column3.Width             = 43
                .Column3.Movable           = .F.
                .Column3.Resizable         = .F.
                .Column3.ReadOnly          = .T.
                .Column3.Text1.Alignment   = 3
                .Column3.Header1.Caption   = "Moeda"
                .Column3.Header1.Alignment = 2
                .Column3.Header1.ForeColor = RGB(90, 90, 90)
                .Column3.Header1.BackColor = RGB(255, 255, 255)

                .Column4.ControlSource      = loc_cCursor + ".Saldos"
                .Column4.ColumnOrder        = 4
                .Column4.Width              = 140
                .Column4.Movable            = .F.
                .Column4.Resizable          = .F.
                .Column4.ReadOnly           = .T.
                .Column4.Text1.InputMask    = "99,999,999,999.99"
                .Column4.Header1.Caption    = "Saldo"
                .Column4.Header1.Alignment  = 2
                .Column4.Header1.ForeColor  = RGB(90, 90, 90)
                .Column4.Header1.BackColor  = RGB(255, 255, 255)

                .Column5.ControlSource     = loc_cCursor + ".Emps"
                .Column5.ColumnOrder       = 6
                .Column5.Width             = 41
                .Column5.ReadOnly          = .T.
                .Column5.Header1.Caption   = "Emp"
                .Column5.Header1.Alignment = 2
                .Column5.Header1.ForeColor = RGB(90, 90, 90)
                .Column5.Header1.BackColor = RGB(255, 255, 255)

                .Column6.ControlSource     = loc_cCursor + ".Cpfs"
                .Column6.ColumnOrder       = 3
                .Column6.Width             = 136
                .Column6.Movable           = .F.
                .Column6.Resizable         = .F.
                .Column6.ReadOnly          = .T.
                .Column6.Header1.Caption   = "CPF/CNPJ"
                .Column6.Header1.Alignment = 2
                .Column6.Header1.ForeColor = RGB(90, 90, 90)
                .Column6.Header1.BackColor = RGB(255, 255, 255)

                .Column7.ControlSource   = loc_cCursor + ".Matriz"
                .Column7.ColumnOrder     = 7
                .Column7.Width           = 28
                .Column7.ReadOnly        = .T.
                .Column7.Text1.Alignment = 2
                .Column7.Header1.Caption = "M/F"
                .Column7.Header1.ForeColor = RGB(90, 90, 90)

                .SetAll("DynamicBackColor", ;
                    "IIF(" + loc_cCursor + ".Matriz = 'M', RGB(220,255,220), " + ;
                    "IIF(" + loc_cCursor + ".Matriz = 'F', RGB(245,251,136), RGB(255,255,255)))", "Column")

                .Visible = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGridSaldo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesSaldo - CommandGroup de navegacao/saida da pagina
    * Saldo (legado: SIGOPIND.Page.SALDO.grp_operacao - Top=-2, Left=832,
    * Width=180, Height=96, ButtonCount=2, BackStyle=0, BorderStyle=0,
    * SpecialEffect=1, BorderColor=RGB(136,189,188)). Command1="Consultar"
    * navega para a pagina Historico com a conta selecionada na grade;
    * Command2="Encerrar" fecha o form (legado: "ThisForm.Release").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesSaldo()
        LOCAL loc_oGrp, loc_oErro

        TRY
            THIS.pgf_4c_1.Page1.AddObject("obj_4c_Grp_operacao", "CommandGroup")
            loc_oGrp = THIS.pgf_4c_1.Page1.obj_4c_Grp_operacao
            WITH loc_oGrp
                .Top           = -2
                .Left          = 832
                .Width         = 180
                .Height        = 96
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136, 189, 188)
                .Themes        = .F.
                .Value         = 1
            ENDWITH

            WITH loc_oGrp.Buttons(1)
                .Top        = 5
                .Left       = 16
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Caption    = "\<Consultar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                IF FILE(gc_4c_CaminhoIcones + "geral_procura_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
                ENDIF
            ENDWITH

            WITH loc_oGrp.Buttons(2)
                .Top         = 5
                .Left        = 91
                .Width       = 75
                .Height      = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Cancel      = .T.
                .Caption     = "\<Encerrar"
                .ToolTipText = "[ESC] Sair"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                ENDIF
            ENDWITH

            BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "GrpOperacaoConsultarClick")
            BINDEVENT(loc_oGrp.Buttons(2), "Click", THIS, "GrpOperacaoEncerrarClick")

            loc_oGrp.Visible = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesSaldo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrpOperacaoConsultarClick - Navega para a pagina Historico com a
    * conta selecionada na grade de Saldo (legado: Grupo_op.Click, inicio
    * do bloco "Consultar" - "ThisForm.Operacao = 'CONSULTA'" + ="
    * ThisForm.Cliente = CrSigMvSlc.Contas"). BINDEVENT exige metodo
    * PUBLIC (sem PROTECTED).
    *
    * A copia dos campos para a pagina Historico (Get_Grupo/Get_Moeda/
    * Get_HConta/Get_HDConta - "ThisForm.page.hist.get_*") so acontece
    * quando esses controles existirem (Page2/Historico ainda nao tem
    * nenhum controle nesta fase).
    *--------------------------------------------------------------------------
    PROCEDURE GrpOperacaoConsultarClick()
        LOCAL loc_cCursor, loc_oGrid

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldo
        loc_oGrid   = THIS.pgf_4c_1.Page1.grd_4c_Dados

        IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0 OR EOF(loc_cCursor)
            MsgAviso("Selecione uma conta na grade de saldos antes de consultar.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oGrid.SetFocus()
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_cOperacao = "CONSULTA"
        THIS.this_oBusinessObject.this_cCliente  = EVALUATE(loc_cCursor + ".Contas")

        THIS.pgf_4c_1.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * GrpOperacaoEncerrarClick - Encerra o formulario (legado: grp_operacao
    * Command2 "Encerrar", "ThisForm.Release"). BINDEVENT exige metodo
    * PUBLIC (sem PROTECTED).
    *--------------------------------------------------------------------------
    PROCEDURE GrpOperacaoEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - (Re)carrega a grade de saldos (grd_4c_Dados) a partir
    * do Grupo informado. Com par_cGrupo vazio a grade fica vazia de
    * proposito - o legado (MontaGrade) so popula crSigMvSlc quando o
    * usuario informa o Grupo (regra do projeto para Lista de OPERACIONAL:
    * filtro aplicado sempre, inclusive vazio). par_nFiltro espelha
    * optFiltro.Value (1=Global, 2=Positivos, 3=Negativos).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista(par_cGrupo, par_nFiltro)
        LOCAL loc_cCursor, loc_oGrid

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorSaldo
        loc_oGrid   = THIS.pgf_4c_1.Page1.grd_4c_Dados

        IF EMPTY(par_cGrupo)
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                ZAP
            ENDIF
        ELSE
            THIS.this_oBusinessObject.BuscarSaldos(par_cGrupo, par_nFiltro)
        ENDIF

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            GO TOP
        ENDIF

        loc_oGrid.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao; percorre recursivamente Controls (containers/PageFrame) para
    * garantir que tudo fique visivel apos a montagem. PageFrame.Controls()
    * inclui as Pages, e Page.Controls() inclui os filhos delas - a mesma
    * recursao cobre os dois niveis sem tratamento especial.
    *
    * ATENCAO (Fase 4/5/6): quando os containers flutuantes SigCcrConsulta/
    * SigCcrSaldos (Page1) e SigCcrimpressao/SigCcrQuitacao (Page2) forem
    * criados com Visible=.F. (paineis que so aparecem ao clicar um botao -
    * no legado: cmd_procurar.Click/Com_Imprimir2.Click), este metodo TEM
    * de passar a filtrar esses nomes (INLIST/IF...LOOP), senao a recursao
    * os torna visiveis incondicionalmente e eles aparecem abertos desde a
    * primeira tela.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE
