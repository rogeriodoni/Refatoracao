*==============================================================================
* FormSigPrGl2.prg - Operacoes Selecionadas (dialogo de processamento de OPs)
* Form operacional MODAL, aberto pelo formulario pai que lista as operacoes
* em aberto (equivalente ao "Do Form SigPrGl2 With ThisForm, ..." do legado).
* Original: SigPrGl2.SCX (form generico, layout FLAT - sem PageFrame
* Page1=Lista/Page2=Dados; duas grades empilhadas + campos de observacao)
*
*------------------------------------------------------------------------------
* CONSOLIDACAO (Fase 8) - superficie de metodos desta classe
*
* SIGPRGL2 e um DIALOGO MODAL de selecao e processamento, NAO um cadastro.
* O SCX legado herda de "form" generico (nao de frmcadastro) e tem
* exatamente 4 botoes: Processar, Encerrar, "apaga" (desmarca tudo) e
* SelTudo (marca tudo) - ver SECAO 1 do dump e analise.json
* (formType = OPERACIONAL). Por isso a superficie canonica de CRUD nao se
* aplica aqui, e cada ausencia abaixo corresponde a algo que o legado
* tambem nao possui:
*
*   BtnIncluir/BtnAlterar/BtnExcluir/BtnVisualizar/BtnBuscarClick
*       o dialogo nao cadastra nem pesquisa registro nenhum - a lista de
*       operacoes ja chega pronta do formulario pai, nos cursores
*       TmpCabec/TmpItens. Nao ha esses botoes no SCX.
*   BtnSalvarClick / FormParaBO
*       nao ha gravacao de entidade por tela. A unica escrita do legado
*       (INSERT em SigTempD + montagem de TmpFinal/TmpFinalg) vive em
*       SigPrGl2BO.ExecutarProcessamento, acionada por BtnProcessarClick.
*   BOParaForm
*       todos os controles de dados sao ligados por ControlSource DIRETO
*       aos cursores (o proprio Init legado faz isso), entao o VFP cobre
*       as duas direcoes do transporte. O unico estado que ainda precisa
*       de transporte explicito e o da LINHA corrente para as properties
*       do BO - feito em SincronizarBOComLinhaCorrente().
*   AlternarPagina / CarregarLista / AjustarBotoesPorModo / HabilitarCampos
*       nao ha PageFrame (layout FLAT) nem modos INCLUIR/ALTERAR/
*       VISUALIZAR. A carga inicial e CarregarDados() (trecho final do
*       Init legado) e a unica troca de estado de botao do legado esta na
*       cauda do Processar.Click (ThisForm.Enabled = .f. e, com reserva
*       automatica, Processar.Enabled = .f.), ja reproduzida em
*       BtnProcessarClick().
*   LimparCampos
*       os campos sao espelho dos cursores; o dialogo fecha ao terminar e
*       nao volta a um estado "em branco".
*
* BtnEncerrarClick e o handler do botao "Cancelar" do SCX (property
* Cancel = .T., ESC aciona), cuja Caption legada e "Encerrar" - nome
* alinhado com a ACAO exibida ao usuario, nao com o nome do objeto
* legado (mesmo criterio ja usado em outros handlers do projeto).
*------------------------------------------------------------------------------
*==============================================================================
DEFINE CLASS FormSigPrGl2 AS FormBase

    *-- Contexto recebido do formulario pai (equivalente as properties
    *-- customizadas ParentForm/Datasessionid/Reserva/Emphpdr/Automatico/
    *-- Numerodaop/Pordestino do SIGPRGL2.SCX legado). Espelhadas tambem
    *-- aqui no Form (alem do BO) para os handlers de UI das proximas fases.
    this_oParentForm    = .NULL.  && Referencia ao form pai (lista de operacoes)
    this_nDataSessionId = 0       && DataSessionId do form pai (cursores TmpCabec/TmpItens vivem la)
    this_lReservaAuto   = .F.     && .T. quando a reserva de estoque e automatica
    this_nEmpHpdr        = 0      && Codigo do grupo/empresa padrao de geracao (Emphpdr)
    this_lAutomatico     = .F.    && .T. quando o processamento e automatico (sem interacao)
    this_cNumeroDaOp     = ""     && Numero da operacao de origem (Numerodaop)
    this_cPorDestino     = ""     && Destino da operacao (PorDestino)

    *-- Propriedades visuais (replicadas do SIGPRGL2.SCX - dialogo modal
    *-- sem barra de titulo, sem redimensionamento, sem botoes de sistema)
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    Height       = 600
    Width        = 800
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    BorderStyle  = 2

    *--------------------------------------------------------------------------
    * Init - Recebe o contexto do formulario pai (mesma ordem de parametros
    * do PROCEDURE Init do legado, exceto pCnx: a conexao agora vem do
    * global gnConnHandle - regra "Global Variables" do projeto)
    *
    * par_oParentForm    : referencia ao form pai (equivalente a _ParentForm)
    * par_nDataSessionId : datasession do pai onde TmpCabec/TmpItens existem (_Data)
    * par_lReservaAuto   : .T. quando a reserva de estoque e automatica (_ReservaAuto)
    * par_nEmpHpdr       : grupo/empresa padrao de geracao (_nGerEmphPdr)
    * par_lAutomatico    : .T. quando o processamento e automatico (_Autom)
    * par_cNumeroDaOp    : numero da operacao de origem (_NumeroOp)
    * par_cPorDestino    : destino da operacao (ThisForm.ParentForm.PorDestino no legado)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_nDataSessionId, par_lReservaAuto, ;
            par_nEmpHpdr, par_lAutomatico, par_cNumeroDaOp, par_cPorDestino)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oParentForm) = "O" AND !ISNULL(par_oParentForm)
                THIS.this_oParentForm         = par_oParentForm
                THIS.this_oParentForm.Enabled = .F.
            ENDIF

            THIS.this_nDataSessionId = IIF(VARTYPE(par_nDataSessionId) = "N", par_nDataSessionId, 0)
            THIS.this_lReservaAuto   = IIF(VARTYPE(par_lReservaAuto) = "L", par_lReservaAuto, .F.)
            THIS.this_nEmpHpdr       = IIF(VARTYPE(par_nEmpHpdr) = "N", par_nEmpHpdr, 0)
            THIS.this_lAutomatico    = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)
            THIS.this_cNumeroDaOp    = IIF(VARTYPE(par_cNumeroDaOp) = "C", par_cNumeroDaOp, "")
            THIS.this_cPorDestino    = IIF(VARTYPE(par_cPorDestino) = "C", par_cPorDestino, "")

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGl2BO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrGl2BO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro")
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .T.
                ENDIF
            ELSE
                *-- Repassa o contexto recebido do pai para o BO (properties
                *-- ja declaradas em SigPrGl2BO, consumidas em ExecutarProcessamento)
                THIS.this_oBusinessObject.this_oParentForm    = THIS.this_oParentForm
                THIS.this_oBusinessObject.this_nDataSessionId = THIS.this_nDataSessionId
                THIS.this_oBusinessObject.this_lReservaAuto   = THIS.this_lReservaAuto
                THIS.this_oBusinessObject.this_nEmpHpdr       = THIS.this_nEmpHpdr
                THIS.this_oBusinessObject.this_lAutomatico    = THIS.this_lAutomatico
                THIS.this_oBusinessObject.this_cNumeroDaOp    = THIS.this_cNumeroDaOp
                THIS.this_oBusinessObject.this_cPorDestino    = THIS.this_cPorDestino

                *-- DODEFAULT chama FormBase.Init (fix datas DataSession=2) + InicializarForm
                loc_lSucesso = DODEFAULT()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao abrir Opera" + CHR(231) + CHR(245) + "es Selecionadas")
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria a interface do usuario (chamado por FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es Selecionadas"

            *-- Fundo do form (new_background.jpg do legado)
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            *-- Cria os containers base (Fase 3: apenas cabecalho)
            THIS.ConfigurarPageFrame()

            *-- Setar caption nos labels do cabecalho
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Fase 4: grades (GradeOperacao/GradeItens) e botoes reais do
            *-- form (Processar/Encerrar/Apaga/SelTudo). Este form OPERACIONAL
            *-- e FLAT (sem PageFrame Page1=Lista/Page2=Dados no legado - ver
            *-- analise.json formType=OPERACIONAL), por isso nao ha
            *-- ConfigurarPaginaLista/AlternarPagina nem botoes Incluir/
            *-- Alterar/Excluir/Visualizar/Buscar - o legado nao tem.
            THIS.ConfigurarGrids()
            THIS.ConfigurarBotoes()
            THIS.ConfigurarCampos()

            *-- Tornar controles visiveis
            THIS.TornarControlesVisiveis(THIS)

            *-- Fase 8: carga/sincronizacao inicial dos cursores (trecho
            *-- final do Init legado: filtro de TmpItens por EmpDopNum,
            *-- TmpCabec no topo e ThisForm.Refresh). Falha aqui NAO impede
            *-- a abertura do dialogo - CarregarDados ja reporta o erro.
            THIS.CarregarDados()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria os containers base do form operacional
    * Form OPERACIONAL sem PageFrame (SIGPRGL2 legado eh single-page, layout
    * FLAT com duas grades empilhadas - grades e botoes entram na Fase 4,
    * campos de observacao/cliente entram nas Fases 5-6)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro

        TRY
            *-- Cabecalho escuro (cntSombra do legado: Top=0, W=800, H=80)
            THIS.AddObject("cnt_4c_Cabecalho", "Container")
            WITH THIS.cnt_4c_Cabecalho
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100,100,100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = ""
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = 769
                .ForeColor = RGB(0,0,0)
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = ""
                .Height    = 46
                .Left      = 10
                .Top       = 17
                .Width     = 769
                .ForeColor = RGB(255,255,255)
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrids - Cria as duas grades do dialogo (GradeOperacao/
    * GradeItens do legado). Posicoes/tamanhos copiados de layout.json.
    *
    * TmpCabec/TmpItens sao cursores preparados pelo formulario PAI antes de
    * abrir este dialogo (equivalente ao AddCursor sem query do legado) - o
    * BO (SigPrGl2BO) ja assume acesso direto por alias (this_cCursorCabecalho
    * = "TmpCabec"/this_cCursorItens = "TmpItens"), sem SET DATASESSION, no
    * mesmo padrao ja usado no restante do projeto (ver Formsigmvitn.prg).
    * Se os cursores ainda nao existirem na sessao corrente (instanciacao
    * direta/teste sem o form pai que os popula), criamos versoes vazias com
    * a estrutura inferida dos campos ja referenciados em SigPrGl2BO
    * (CarregarDoCursor/ExecutarProcessamento) para a grade nao derrubar o
    * Init (regra CLAUDE.md #41 - ControlSource de cursor inexistente).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrids()
        LOCAL loc_oGrid, loc_oErro

        TRY
            IF !USED("TmpCabec")
                CREATE CURSOR TmpCabec (Flag L, Emps C(3), Dopes C(20), Numes N(6), ;
                    Datas D, Entregas D, Peso N(9,3), Contav C(10), Conta C(10), ;
                    DConta C(50), Obs M NULL, Notas C(6), GrupoOs C(10), ContaOs C(10), ;
                    GrupoDs C(10), ContaDs C(10), Jobs C(10))
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes, 6) TAG Entrega
                SET ORDER TO EmpDopNum
            ENDIF

            IF !USED("TmpItens")
                CREATE CURSOR TmpItens (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), ;
                    CodCors C(4), CodTams C(4), Linhas C(10), Citens N(10), Qtds N(10,3), ;
                    Saldo N(10,3), Peso N(9,3), Obs M NULL, Notas C(6), Dpros C(40), Reffs C(40))
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                INDEX ON CPros TAG CPros
                SET ORDER TO EmpDopNum
            ENDIF

            *-- Ordem inicial da grade de cabecalho (equivalente ao Init de
            *-- Thisform.cOrdConta do legado) + cor default dos headers
            THIS.this_oBusinessObject.DefinirOrdemConta("")

            *----------------------------------------------------------------
            * grd_4c_Operacoes (GradeOperacao) - Top=155, Left=5, W=789, H=156
            *----------------------------------------------------------------
            THIS.AddObject("grd_4c_Operacoes", "Grid")
            loc_oGrid = THIS.grd_4c_Operacoes
            WITH loc_oGrid
                .Top          = 155
                .Left         = 5
                .Width        = 789
                .Height       = 156
                .ScrollBars   = 2
                .GridLineColor = RGB(238, 238, 238)
                *-- AllowHeaderSizing/AllowRowSizing/Panel/TabIndex
                *-- transcritos do SCX (a grade legada nao permite o usuario
                *-- redimensionar linha nem cabecalho). RowHeight vai DEPOIS
                *-- de FontName/FontSize - medido no VFP9: mexer na fonte do
                *-- Grid RECALCULA a RowHeight e descarta o valor do SCX
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .Panel        = 1
                .TabIndex     = 2
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle = 2
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .FontName     = "Verdana"
                .FontSize     = 8
                .RowHeight    = 17
                .ColumnCount  = 10
                .RecordSource = "TmpCabec"
            ENDWITH

            *-- Column1: Flag (logical) - ControlSource logico faz o VFP9
            *-- gerar sozinho o Check1 da coluna (mesmo padrao ja usado em
            *-- FormCLC.prg CarregarGridOperacoes/Column8.Agrupar - NAO
            *-- criar CheckBox por AddObject aqui, o proprio VFP substitui
            *-- o Text1 por Check1 quando o campo ligado e logico)
            *-- ControlSource transcrito LITERALMENTE do With ThisForm.
            *-- GradeOperacao do Init legado. Tres colunas NAO sao ligacao
            *-- direta a coluna do cursor e por isso eram alvo facil de
            *-- "simplificacao" na migracao:
            *--   Column5 (Entrega) : Iif(IsNull(...), {}, ...) - a coluna
            *--       Entregas aceita NULL; sem o guard a celula exibe .NULL.
            *--   Column8 (Cliente) : liga em TmpCabec.Conta (CODIGO da
            *--       conta). Quem exibe a DESCRICAO e o getCliente/
            *--       txt_4c_Cliente, ligado em TmpCabec.DConta - as duas
            *--       ligacoes sao diferentes DE PROPOSITO.
            *--   Column9 (Obs)     : coluna MARCADORA - mostra "*" quando ha
            *--       observacao e " " quando nao ha (Verdana 12 bold
            *--       centralizado). O texto em si vai no edt_4c_ObsOperacao.
            loc_oGrid.Column1.ControlSource  = "TmpCabec.Flag"
            loc_oGrid.Column1.Sparse         = .F.
            loc_oGrid.Column2.ControlSource  = "TmpCabec.Dopes"
            loc_oGrid.Column3.ControlSource  = "TmpCabec.Numes"
            loc_oGrid.Column4.ControlSource  = "TmpCabec.Datas"
            loc_oGrid.Column5.ControlSource  = "IIF(ISNULL(TmpCabec.Entregas), {}, TmpCabec.Entregas)"
            loc_oGrid.Column6.ControlSource  = "TmpCabec.Peso"
            loc_oGrid.Column7.ControlSource  = "TmpCabec.Contav"
            loc_oGrid.Column8.ControlSource  = "TmpCabec.Conta"
            loc_oGrid.Column9.ControlSource  = "IIF(EMPTY(TmpCabec.Obs), ' ', '*')"
            loc_oGrid.Column10.ControlSource = "TmpCabec.Notas"

            *-- Width + Header DEPOIS do ControlSource (RecordSource/
            *-- ControlSource resetam para o default 90/"Header1").
            *-- Larguras/Movable/Resizable/ReadOnly transcritos do SCX.
            loc_oGrid.Column1.Width           = 17
            loc_oGrid.Column1.ReadOnly        = .F.
            loc_oGrid.Column1.Header1.Caption = ""
            loc_oGrid.Column2.Width           = 156
            loc_oGrid.Column2.ReadOnly        = .T.
            loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
            loc_oGrid.Column3.Width           = 70
            loc_oGrid.Column3.ReadOnly        = .T.
            loc_oGrid.Column3.Header1.Caption = "N" + CHR(250) + "mero"
            loc_oGrid.Column4.Width           = 70
            loc_oGrid.Column4.ReadOnly        = .T.
            loc_oGrid.Column4.Header1.Caption = "Emiss" + CHR(227) + "o"
            loc_oGrid.Column5.Width           = 70
            loc_oGrid.Column5.ReadOnly        = .T.
            loc_oGrid.Column5.Header1.Caption = "Entrega"
            loc_oGrid.Column6.Width           = 90
            loc_oGrid.Column6.ReadOnly        = .T.
            loc_oGrid.Column6.InputMask       = "999,999.99"
            loc_oGrid.Column6.Header1.Caption = "Peso"
            loc_oGrid.Column7.Width           = 90
            loc_oGrid.Column7.ReadOnly        = .T.
            loc_oGrid.Column7.Header1.Caption = "Respons" + CHR(225) + "vel"
            loc_oGrid.Column8.Width           = 90
            loc_oGrid.Column8.ReadOnly        = .T.
            loc_oGrid.Column8.Header1.Caption = "Cliente"
            loc_oGrid.Column9.Width           = 44
            loc_oGrid.Column9.ReadOnly        = .T.
            loc_oGrid.Column9.Alignment       = 2
            loc_oGrid.Column9.FontBold        = .T.
            loc_oGrid.Column9.FontSize        = 12
            loc_oGrid.Column9.Header1.Caption = "Obs"
            loc_oGrid.Column10.Width          = 52
            loc_oGrid.Column10.Header1.Caption = "Doc."

            *-- Colunas nao redimensionaveis/moveis (SCX: Movable=.F. +
            *-- Resizable=.F. em TODAS as colunas das duas grades)
            loc_oGrid.SetAll("Movable", .F., "Column")
            loc_oGrid.SetAll("Resizable", .F., "Column")

            *-- Header/Text1 das colunas (SCX declara Verdana 8, Alignment=2
            *-- e ForeColor 36,84,155 nos headers; Text1 sem borda/margem)
            loc_oGrid.SetAll("FontName", "Verdana", "Header")
            loc_oGrid.SetAll("FontSize", 8, "Header")
            loc_oGrid.SetAll("Alignment", 2, "Header")
            loc_oGrid.SetAll("ForeColor", RGB(36, 84, 155), "Header")
            loc_oGrid.SetAll("BorderStyle", 0, "TextBox")
            loc_oGrid.SetAll("Margin", 0, "TextBox")
            loc_oGrid.SetAll("ForeColor", RGB(0, 0, 0), "TextBox")
            loc_oGrid.SetAll("BackColor", RGB(255, 255, 255), "TextBox")

            *-- Column9.Text1 e a celula do marcador "*" (Verdana 12 bold
            *-- centralizado no SCX); Column10.Header1 e o unico header que
            *-- o SCX NAO declara com Verdana/ForeColor - fica no default
            loc_oGrid.Column9.Text1.FontBold  = .T.
            loc_oGrid.Column9.Text1.FontSize  = 12
            loc_oGrid.Column9.Text1.Alignment = 2
            loc_oGrid.Column10.Header1.FontName  = "Tahoma"
            loc_oGrid.Column10.Header1.FontSize  = 8
            loc_oGrid.Column10.Header1.ForeColor = RGB(0, 0, 0)

            *-- Cor inicial dos headers de ordenacao (EMPDOPNUM e o default)
            loc_oGrid.Column2.Header1.BackColor = RGB(220, 255, 220)
            loc_oGrid.Column5.Header1.BackColor = RGB(192, 192, 192)

            IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
                loc_oGrid.Column1.Check1.Alignment = 2
                loc_oGrid.Column1.Check1.ReadOnly  = .F.
                loc_oGrid.Column1.Check1.Visible   = .T.
                BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "FlagCheckKeyPress")
                BINDEVENT(loc_oGrid.Column1.Check1, "MouseDown", THIS, "FlagCheckMouseDown")
            ENDIF
            BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "Column2HeaderClick")
            BINDEVENT(loc_oGrid.Column5.Header1, "Click", THIS, "Column5HeaderClick")
            BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeOperacoesAfterRowColChange")

            *----------------------------------------------------------------
            * grd_4c_Itens (GradeItens) - Top=339, Left=5, W=737, H=191
            *----------------------------------------------------------------
            THIS.AddObject("grd_4c_Itens", "Grid")
            loc_oGrid = THIS.grd_4c_Itens
            WITH loc_oGrid
                .Top          = 339
                .Left         = 5
                .Width        = 737
                .Height       = 191
                .ScrollBars   = 2
                .GridLineColor = RGB(238, 238, 238)
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .Panel        = 1
                .TabIndex     = 3
                .ForeColor    = RGB(90, 90, 90)
                .BackColor    = RGB(255, 255, 255)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle = 2
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .FontName     = "Verdana"
                .FontSize     = 8
                *-- RowHeight DEPOIS da fonte (ver nota na grade de cabecalho)
                .RowHeight    = 17
                .ReadOnly     = .T.
                .ColumnCount  = 8
                .RecordSource = "TmpItens"
            ENDWITH

            *-- ControlSource transcrito do With ThisForm.GradeItens do Init
            *-- legado. Column1 liga em Cpros (CODIGO do produto, nao a
            *-- descricao Dpros) e Column5 e a coluna MARCADORA de
            *-- observacao (mesmo padrao da Column9 da grade de cabecalho)
            loc_oGrid.Column1.ControlSource = "TmpItens.Cpros"
            loc_oGrid.Column2.ControlSource = "TmpItens.Qtds"
            loc_oGrid.Column3.ControlSource = "TmpItens.Saldo"
            loc_oGrid.Column4.ControlSource = "TmpItens.Peso"
            loc_oGrid.Column5.ControlSource = "IIF(EMPTY(TmpItens.Obs), ' ', '*')"
            loc_oGrid.Column6.ControlSource = "TmpItens.CodCors"
            loc_oGrid.Column7.ControlSource = "TmpItens.CodTams"
            loc_oGrid.Column8.ControlSource = "TmpItens.Reffs"

            *-- Larguras do SCX. ColumnOrder tambem vem do SCX: a ordem
            *-- VISUAL do legado nao e a ordem de declaracao -
            *-- Produto, Ref. Fornecedor, Cor, Tam, Quantidade, Saldo,
            *-- Peso, Obs (Column1, 8, 6, 7, 2, 3, 4, 5)
            loc_oGrid.Column1.Width           = 120
            loc_oGrid.Column1.ReadOnly        = .T.
            loc_oGrid.Column1.Header1.Caption = "Produto"
            loc_oGrid.Column2.Width           = 90
            loc_oGrid.Column2.ReadOnly        = .T.
            loc_oGrid.Column2.Header1.Caption = "Quantidade"
            loc_oGrid.Column3.Width           = 118
            loc_oGrid.Column3.ReadOnly        = .T.
            loc_oGrid.Column3.Header1.Caption = "Saldo"
            loc_oGrid.Column4.Width           = 100
            loc_oGrid.Column4.ReadOnly        = .T.
            loc_oGrid.Column4.Header1.Caption = "Peso"
            loc_oGrid.Column5.Width           = 44
            loc_oGrid.Column5.ReadOnly        = .T.
            loc_oGrid.Column5.Alignment       = 2
            loc_oGrid.Column5.FontBold        = .T.
            loc_oGrid.Column5.FontSize        = 12
            loc_oGrid.Column5.Header1.Caption = "Obs"
            loc_oGrid.Column6.Width           = 38
            loc_oGrid.Column6.ReadOnly        = .T.
            loc_oGrid.Column6.Header1.Caption = "Cor"
            loc_oGrid.Column7.Width           = 38
            loc_oGrid.Column7.ReadOnly        = .T.
            loc_oGrid.Column7.Header1.Caption = "Tam"
            loc_oGrid.Column8.Width           = 150
            loc_oGrid.Column8.ReadOnly        = .T.
            loc_oGrid.Column8.Header1.Caption = "Ref. Fornecedor"

            loc_oGrid.Column8.ColumnOrder = 2
            loc_oGrid.Column6.ColumnOrder = 3
            loc_oGrid.Column7.ColumnOrder = 4
            loc_oGrid.Column2.ColumnOrder = 5
            loc_oGrid.Column3.ColumnOrder = 6
            loc_oGrid.Column4.ColumnOrder = 7
            loc_oGrid.Column5.ColumnOrder = 8

            loc_oGrid.SetAll("Movable", .F., "Column")
            loc_oGrid.SetAll("Resizable", .F., "Column")

            loc_oGrid.SetAll("FontName", "Verdana", "Header")
            loc_oGrid.SetAll("FontSize", 8, "Header")
            loc_oGrid.SetAll("Alignment", 2, "Header")
            loc_oGrid.SetAll("ForeColor", RGB(36, 84, 155), "Header")
            loc_oGrid.SetAll("BorderStyle", 0, "TextBox")
            loc_oGrid.SetAll("Margin", 0, "TextBox")
            loc_oGrid.SetAll("ForeColor", RGB(0, 0, 0), "TextBox")
            loc_oGrid.SetAll("BackColor", RGB(255, 255, 255), "TextBox")

            *-- Celula do marcador "*" e o unico header que o SCX nao
            *-- declara com Verdana/ForeColor (Column8 - "Ref. Fornecedor")
            loc_oGrid.Column5.Text1.FontBold  = .T.
            loc_oGrid.Column5.Text1.FontSize  = 12
            loc_oGrid.Column5.Text1.Alignment = 2
            loc_oGrid.Column8.Header1.FontName  = "Tahoma"
            loc_oGrid.Column8.Header1.FontSize  = 8
            loc_oGrid.Column8.Header1.ForeColor = RGB(0, 0, 0)

            BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ConfigurarGrids")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Cria o Shape decorativo e os 4 botoes reais do
    * dialogo (Processar/Cancelar-Encerrar/Apaga/SelTudo). SIGPRGL2.SCX nao
    * tem CommandGroup nenhum aqui - os 4 sao CommandButton soltos, filhos
    * diretos do form (mapeamento.json). Por isso levam Themes=.T. +
    * DisabledPicture (regra standalone CommandButton com Picture).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            *-- Shape3 (decorativo, sem cor especial no dump) - Top=7,
            *-- Left=732, W=60, H=29
            THIS.AddObject("shp_4c_Shape3", "Shape")
            WITH THIS.shp_4c_Shape3
                .Top        = 7
                .Left       = 732
                .Width      = 60
                .Height     = 29
                *-- SCX: BackStyle=0 (transparente), BorderStyle=0 e
                *-- BorderColor=136,189,188. Shape NAO tem ForeColor - a cor
                *-- mora em BorderColor/FillColor (CLAUDE.md regra #33)
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            *-- Processar - Top=3, Left=648, W=75, H=75
            THIS.AddObject("cmd_4c_Processar", "CommandButton")
            WITH THIS.cmd_4c_Processar
                .Top        = 3
                .Left       = 648
                .Width      = 75
                .Height     = 75
                .TabIndex   = 9
                .Caption    = "\<Processar"
                .FontName   = "Comic Sans MS"
                .FontBold   = .T.
                .FontItalic = .T.
                .FontSize   = 8
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .T.
                .SpecialEffect = 0
                .PicturePosition = 13
                .MousePointer = 15
                .WordWrap   = .T.
                .AutoSize   = .F.
                IF FILE(gc_4c_CaminhoIcones + "geral_processar_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                ENDIF
                .Visible    = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")

            *-- Cancelar (Encerrar) - Top=3, Left=723, W=75, H=75
            THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH THIS.cmd_4c_Cancelar
                .Top        = 3
                .Left       = 723
                .Width      = 75
                .Height     = 75
                .TabIndex   = 10
                *-- SCX: Cancel = .T. (ESC fecha o dialogo pelo Encerrar)
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .FontName   = "Comic Sans MS"
                .FontBold   = .T.
                .FontItalic = .T.
                .FontSize   = 8
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .T.
                .SpecialEffect = 0
                .PicturePosition = 13
                .MousePointer = 15
                .WordWrap   = .T.
                .AutoSize   = .F.
                IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
                    .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                ENDIF
                .Visible    = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnEncerrarClick")

            *-- apaga (Desmarcar Todos) - icone-only, Top=358, Left=748, 40x40
            THIS.AddObject("cmd_4c_Apaga", "CommandButton")
            WITH THIS.cmd_4c_Apaga
                .Top        = 358
                .Left       = 748
                .Width      = 40
                .Height     = 40
                .Caption    = ""
                .TabIndex   = 8
                .ToolTipText = "Desmarca Tudo"
                .ForeColor  = RGB(36, 84, 155)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .T.
                .SpecialEffect = 0
                .MousePointer = 15
                IF FILE(gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg")
                    .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                ENDIF
                .Visible    = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")

            *-- SelTudo (Selecionar Todas) - icone-only, Top=400, Left=748, 40x40
            THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
            WITH THIS.cmd_4c_SelTudo
                .Top        = 400
                .Left       = 748
                .Width      = 40
                .Height     = 40
                .Caption    = ""
                .TabIndex   = 7
                .ToolTipText = "Seleciona Tudo"
                .ForeColor  = RGB(36, 84, 155)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .T.
                .SpecialEffect = 0
                .MousePointer = 15
                IF FILE(gc_4c_CaminhoIcones + "geral_selecionar_26.jpg")
                    .Picture = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
                    .DisabledPicture = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
                ENDIF
                .Visible    = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Campos soltos do form (fora das grades): observacao
    * da operacao (ObsOperacao), campo de cliente (getCliente), label
    * "Cliente :" (Label6), label "Observacao do Item :" (Txt_ObsItens) e
    * observacao do item corrente (ObsItens). Nao ha lookup neste form -
    * getCliente e so leitura (When retorna .f. no legado, campo nunca
    * recebe foco/digitacao) e nenhum outro campo usa fwbuscaext/sigacess.
    * Posicoes/tamanhos copiados de layout.json. Controles ficam DIRETO no
    * form (SIGPRGL2 e FLAT - sem PageFrame/Page), refresh ja cabeado nos
    * handlers AfterRowColChange das duas grades (Fase 4).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_oErro

        TRY
            *----------------------------------------------------------------
            * obj_4c_ObsOperacao (ObsOperacao) - Top=82, Left=5, W=602, H=70
            * Observacao do cabecalho da operacao corrente (TmpCabec.Obs)
            *----------------------------------------------------------------
            THIS.AddObject("edt_4c_ObsOperacao", "EditBox")
            WITH THIS.edt_4c_ObsOperacao
                .Top           = 82
                .Left          = 5
                .Width         = 602
                .Height        = 70
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .TabIndex      = 4
                .ControlSource = "TmpCabec.Obs"
                *-- SCX: NullDisplay = " ". TmpCabec.Obs aceita NULL e sem
                *-- isso a caixa exibe o literal .NULL. para o usuario
                .NullDisplay   = " "
                .Visible       = .T.
            ENDWITH

            *----------------------------------------------------------------
            * Label6 "Cliente :" - Top=317, Left=5, W=42, H=15
            *----------------------------------------------------------------
            THIS.AddObject("lbl_4c_Cliente", "Label")
            WITH THIS.lbl_4c_Cliente
                .Top       = 317
                .Left      = 5
                .Width     = 42
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .TabIndex  = 13
                .Caption   = "Cliente :"
                .Visible   = .T.
            ENDWITH

            *----------------------------------------------------------------
            * getCliente (txt_4c_Cliente) - Top=313, Left=59, W=345, H=23
            * Espelha a descricao da conta da operacao corrente
            * (TmpCabec.DConta, mesma coluna da Column8 da grade). Legado
            * tem When retornando .f. (campo nunca recebe foco/digitacao) -
            * ReadOnly reproduz o mesmo comportamento sem bloquear o Refresh
            * feito em GradeOperacoesAfterRowColChange (Fase 4).
            *----------------------------------------------------------------
            THIS.AddObject("txt_4c_Cliente", "TextBox")
            WITH THIS.txt_4c_Cliente
                .Top           = 313
                .Left          = 59
                .Width         = 345
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 1
                .TabIndex      = 3
                .ControlSource = "TmpCabec.DConta"
                .ReadOnly      = .T.
                .TabStop       = .F.
                .Visible       = .T.
            ENDWITH

            *----------------------------------------------------------------
            * Txt_ObsItens "Observacao do Item : " - Top=532, Left=5, W=146,
            * H=15. Classe label pura no legado (AutoSize=.T. sem WordWrap) -
            * regra CLAUDE.md #23: AutoSize=.T. e no-op em Label criado por
            * AddObject, entao fixamos Width/Height explicitos do SCX em vez
            * de confiar no AutoSize.
            *----------------------------------------------------------------
            THIS.AddObject("lbl_4c_ObsItens", "Label")
            WITH THIS.lbl_4c_ObsItens
                .Top       = 532
                .Left      = 5
                .Width     = 146
                .Height    = 15
                .FontName  = "Verdana"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 0
                .TabIndex  = 1
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item : "
                .Visible   = .T.
            ENDWITH

            *----------------------------------------------------------------
            * obj_4c_ObsItens (ObsItens) - Top=548, Left=5, W=737, H=47
            * Observacao do item corrente da grade de itens (TmpItens.Obs) -
            * ja referenciado via PEMSTATUS em GradeOperacoesAfterRowColChange
            * e GradeItensAfterRowColChange (Fase 4)
            *----------------------------------------------------------------
            THIS.AddObject("edt_4c_ObsItens", "EditBox")
            WITH THIS.edt_4c_ObsItens
                .Top           = 548
                .Left          = 5
                .Width         = 737
                .Height        = 47
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .TabIndex      = 6
                .ControlSource = "TmpItens.Obs"
                *-- SCX: NullDisplay = " " (TmpItens.Obs aceita NULL)
                .NullDisplay   = " "
                .Visible       = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ConfigurarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FlagCheckKeyPress/FlagCheckMouseDown - Column1 (Flag) do grd_4c_Operacoes.
    * Mesmo padrao ja comprovado em FormCLC.prg (OpeGerACheckKeyPress/
    * OpeGerACheckMouseDown): o Check1 e gerado automaticamente pelo VFP9
    * quando o ControlSource e logico, e o clique do mouse ja alterna o
    * valor nativamente - KeyPress cobre Enter/Espaco, MouseDown so garante
    * o Refresh apos o clique.
    *--------------------------------------------------------------------------
    PROCEDURE FlagCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32) AND USED("TmpCabec") AND !EOF("TmpCabec")
            IF par_nKeyCode = 13
                REPLACE Flag WITH .NOT. Flag IN TmpCabec
            ENDIF
            THIS.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE FlagCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        IF USED("TmpCabec") AND !EOF("TmpCabec")
            THIS.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Column2HeaderClick/Column5HeaderClick - alterna a ordem da grade de
    * cabecalho entre EMPDOPNUM (Column2 "Movimentacao") e ENTREGA (Column5
    * "Entrega"), colorindo o header ativo (transcrito de comportamento.json)
    *--------------------------------------------------------------------------
    PROCEDURE Column2HeaderClick()
        IF UPPER(ORDER("TmpCabec")) != "EMPDOPNUM"
            SELECT TmpCabec
            SET ORDER TO EmpDopNum
            GO TOP
            THIS.this_oBusinessObject.this_cOrdConta = UPPER(ORDER("TmpCabec"))
            WITH THIS.grd_4c_Operacoes
                .Column2.Header1.BackColor = RGB(220, 255, 220)
                .Column5.Header1.BackColor = RGB(192, 192, 192)
                .Refresh()
            ENDWITH
        ENDIF
    ENDPROC

    PROCEDURE Column5HeaderClick()
        IF UPPER(ORDER("TmpCabec")) != "ENTREGA"
            SELECT TmpCabec
            SET ORDER TO Entrega
            GO TOP
            THIS.this_oBusinessObject.this_cOrdConta = UPPER(ORDER("TmpCabec"))
            WITH THIS.grd_4c_Operacoes
                .Column2.Header1.BackColor = RGB(192, 192, 192)
                .Column5.Header1.BackColor = RGB(220, 255, 220)
                .Refresh()
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * mOrdemConta - Equivalente ao metodo legado chamado no Click/Activate do
    * PROPRIO form (comportamento.json). Reaplica a ordem corrente de
    * TmpCabec (via BO.DefinirOrdemConta) e, quando par_lTipo e .T., repinta
    * os headers de ordenacao (mesma paleta das Column*HeaderClick acima -
    * o dump original truncava a 2a metade do Do Case, mas a simetria com os
    * dois handlers de Header1.Click confirma as duas cores).
    *--------------------------------------------------------------------------
    PROCEDURE mOrdemConta(par_lTipo)
        THIS.this_oBusinessObject.DefinirOrdemConta(THIS.this_oBusinessObject.this_cOrdConta)

        IF par_lTipo
            WITH THIS.grd_4c_Operacoes
                IF UPPER(THIS.this_oBusinessObject.this_cOrdConta) = "EMPDOPNUM"
                    .Column2.Header1.BackColor = RGB(220, 255, 220)
                    .Column5.Header1.BackColor = RGB(192, 192, 192)
                ELSE
                    .Column2.Header1.BackColor = RGB(192, 192, 192)
                    .Column5.Header1.BackColor = RGB(220, 255, 220)
                ENDIF
                .Refresh()
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate/Click (eventos NATIVOS do form) - legado chama
    * Thisform.mOrdemConta(.t.) + GradeOperacao.Refresh nos dois eventos
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        DODEFAULT()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
            THIS.mOrdemConta(.T.)
            THIS.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE Click()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
            THIS.mOrdemConta(.T.)
            THIS.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeOperacoesAfterRowColChange - ao trocar de linha na grade de
    * cabecalho, refiltra TmpItens pela chave EmpDopNum da linha corrente e
    * atualiza os controles relacionados (transcrito de comportamento.json).
    * getCliente/ObsOperacao/ObsItens sao criados na Fase 5 (Campos) - os
    * PEMSTATUS evitam "Property nao encontrada" ate la.
    *--------------------------------------------------------------------------
    PROCEDURE GradeOperacoesAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro

        TRY
            IF USED("TmpItens") AND USED("TmpCabec")
                SELECT TmpItens
                SET ORDER TO EmpDopNum
                SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
                GO TOP
                IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
                    THIS.grd_4c_Itens.Refresh()
                ENDIF

                *-- Espelha a nova linha corrente de TmpCabec nas properties
                *-- do BO (equivalente de BOParaForm neste dialogo - ver
                *-- SincronizarBOComLinhaCorrente). Nao altera a area de
                *-- trabalho: o legado termina este handler com TmpItens
                *-- selecionado.
                THIS.SincronizarBOComLinhaCorrente()
            ENDIF

            IF PEMSTATUS(THIS, "txt_4c_Cliente", 5)
                THIS.txt_4c_Cliente.Refresh()
            ENDIF
            IF PEMSTATUS(THIS, "edt_4c_ObsOperacao", 5)
                THIS.edt_4c_ObsOperacao.Refresh()
            ENDIF
            IF PEMSTATUS(THIS, "edt_4c_ObsItens", 5)
                THIS.edt_4c_ObsItens.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GradeOperacoesAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeItensAfterRowColChange - ao trocar de linha na grade de itens,
    * atualiza a observacao do item corrente (transcrito de comportamento.json)
    *--------------------------------------------------------------------------
    PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
        IF PEMSTATUS(THIS, "edt_4c_ObsItens", 5)
            THIS.edt_4c_ObsItens.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSelecaoOperacoes - Guarda de UI do botao Processar.
    *
    * O CRITERIO de negocio (ao menos 1 operacao marcada + todas as marcadas
    * pertencendo ao MESMO Job) mora em
    * SigPrGl2BO.ValidarSelecaoParaProcessamento, fonte UNICA da contagem.
    * O que este metodo acrescenta e o comportamento DE TELA que o legado
    * tinha no inicio do Processar.Click e que so existe no form:
    *
    *   Scan For Flag
    *       If lcJob <> TmpCabec.Jobs
    *           Messagebox([N..o e permitido gerar OPs de opera..es com Jobs
    *                       diferentes.],48,[Aviso])        && so avisa
    *           Return .f.
    *   EndScan
    *   If (_Contador = 0)
    *       =Messagebox('Nenhuma Opera..o Foi Selecionada!!!', 32, '')
    *       ThisForm.GradeOpera..o.Column1.SetFocus         && avisa E foca
    *       Return 0
    *   EndIf
    *
    * Os DOIS ramos avisam, mas so o da selecao vazia devolve o foco a coluna
    * do Flag - por isso consultamos THIS.this_oBusinessObject.
    * this_nOperacoesMarcadas (contagem ja apurada pelo BO) em vez de recontar
    * aqui ou de inferir o ramo pelo texto da mensagem.
    *
    * Retorna .T. quando a selecao esta valida e o processamento pode seguir.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSelecaoOperacoes()
        LOCAL loc_lValido, loc_cCursor, loc_oErro

        loc_lValido = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgAviso("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF THIS.this_oBusinessObject.ValidarSelecaoParaProcessamento()
                    loc_lValido = .T.
                ELSE
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF

                    *-- Legado: so o ramo "Nenhuma Opera..o Foi Selecionada"
                    *-- devolve o foco a Column1 (coluna do Flag) da grade.
                    IF THIS.this_oBusinessObject.this_nOperacoesMarcadas = 0
                        *-- Transcricao literal do legado: Column1.SetFocus (foca
                        *-- a coluna do Flag NA LINHA CORRENTE - nao usar
                        *-- ActivateCell(1,1), que tambem moveria a linha).
                        *-- Grade sem linha nenhuma tambem cai neste ramo (zero
                        *-- marcadas): ali nao ha celula para focar, e insistir
                        *-- no SetFocus so trocaria o aviso do legado por um
                        *-- erro de runtime.
                        loc_cCursor = THIS.this_oBusinessObject.this_cCursorCabecalho
                        IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5) AND ;
                                USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                            IF THIS.grd_4c_Operacoes.Visible AND ;
                                    THIS.grd_4c_Operacoes.Enabled AND ;
                                    THIS.grd_4c_Operacoes.ColumnCount >= 1
                                THIS.grd_4c_Operacoes.Column1.SetFocus()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarSelecaoOperacoes")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Click do botao Processar (equivalente ao Click de
    * 390 linhas do legado, ja reproduzido em SigPrGl2BO.ExecutarProcessamento
    * apos a validacao de SigPrGl2BO.ValidarSelecaoParaProcessamento).
    *
    * Cauda transcrita do legado (fim do Processar.Click):
    *   ThisForm.Enabled = .f.
    *   If ThisForm.Reserva
    *       ThisForm.Processar.Enabled = .f.
    *   EndIf
    *   If Not Empty(crSigCdPac.DopEsts)
    *       Do Form SigPrGlx With ThisForm, ThisForm.Datasessionid, ...
    *   Else
    *       Do Form SigPrGlp With ThisForm, ThisForm.Datasessionid, ...
    *   Endif
    *
    * SigPrGl2 NAO se libera aqui (so o Cancelar/Encerrar libera) - o dialogo
    * fica desabilitado atras da tela filha e e reabilitado por ela no
    * Destroy (mesmo padrao ja usado no proprio this_oParentForm.Enabled=.T.
    * do Destroy desta classe). this_lPossuiFabricacao (populado por
    * ExecutarProcessamento a partir de crSigCdPac.DopEsts) decide qual tela
    * filha abre. FormSigPrGlx/FormSigPrGlp compartilham a mesma DataSession
    * do pai e leem os cursores TmpFinal/TmpFinalg pelo nome LITERAL (por
    * isso SigPrGl2BO.ExecutarProcessamento monta esses cursores sem prefixo
    * cursor_4c_ - mesmo padrao ja usado em TmpCabec/TmpItens).
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oErro, loc_lProsseguir, loc_oFilho

        loc_lProsseguir = .T.
        loc_oFilho      = .NULL.

        TRY
            *-- Guarda de entrada do legado (selecao vazia / Jobs diferentes),
            *-- incluindo o retorno de foco a Column1 no ramo da selecao vazia
            IF !THIS.ValidarSelecaoOperacoes()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF THIS.this_oBusinessObject.ExecutarProcessamento()
                    THIS.Enabled = .F.
                    IF THIS.this_lReservaAuto
                        THIS.cmd_4c_Processar.Enabled = .F.
                    ENDIF

                    IF THIS.this_oBusinessObject.this_lPossuiFabricacao
                        loc_oFilho = CREATEOBJECT("FormSigPrGlx", THIS, ;
                            THIS.this_nDataSessionId, THIS.this_lReservaAuto, ;
                            THIS.this_nEmpHpdr, THIS.this_lAutomatico, ;
                            VAL(THIS.this_cNumeroDaOp), THIS.this_cPorDestino)
                    ELSE
                        loc_oFilho = CREATEOBJECT("FormSigPrGlp", THIS, ;
                            THIS.this_nDataSessionId, THIS.this_lReservaAuto, ;
                            THIS.this_nEmpHpdr, THIS.this_lAutomatico, ;
                            VAL(THIS.this_cNumeroDaOp))
                    ENDIF

                    IF VARTYPE(loc_oFilho) = "O"
                        loc_oFilho.Show()
                    ELSE
                        *-- Falha ao criar a tela filha: devolve o dialogo ao
                        *-- usuario em vez de deixa-lo desabilitado para sempre
                        THIS.Enabled = .T.
                        IF THIS.this_lReservaAuto
                            THIS.cmd_4c_Processar.Enabled = .T.
                        ENDIF
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela de gera" + CHR(231) + CHR(227) + "o de OPs.", "Erro ao Processar")
                    ENDIF
                ELSE
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Processar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnProcessarClick")
            THIS.Enabled = .T.
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Click do botao Cancelar/Encerrar (legado: reabilita
    * o form pai e libera. Destroy() ja cobre a reabilitacao do pai - regra
    * "cobrir TODO caminho de fechamento, nao so o botao Cancelar")
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnApagaClick - Click do botao "apaga" (Desmarcar Todas): Replace All
    * Flag With .f. In TmpCabec, via SigPrGl2BO.MarcarTodasOperacoes(.F.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnApagaClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.MarcarTodasOperacoes(.F.)
        ENDIF
        THIS.grd_4c_Operacoes.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelTudoClick - Click do botao "SelTudo" (Selecionar Todas): Replace
    * All Flag With .t. In TmpCabec, via SigPrGl2BO.MarcarTodasOperacoes(.T.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelTudoClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.MarcarTodasOperacoes(.T.)
        ENDIF
        THIS.grd_4c_Operacoes.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carga/sincronizacao inicial dos cursores de trabalho.
    *
    * Transcricao LITERAL do trecho final do PROCEDURE Init do legado, que
    * roda depois de atribuir todos os ControlSource e e o que deixa a tela
    * utilizavel na abertura:
    *
    *   Select TmpItens
    *   Set Order To EmpDopNum
    *   Set Key To TmpCabec.Emps + TmpCabec.Dopes + Str(TmpCabec.Numes, 6)
    *   Go Top
    *
    *   Select TmpCabec
    *   Go Top
    *
    *   ThisForm.Refresh
    *
    * Sem esta carga as duas grades abrem ligadas aos cursores mas SEM o
    * filtro de itens aplicado e sem repintura - o sintoma seria "a grade de
    * itens mostra itens de outra operacao" / "a tela nao traz dados".
    *
    * Duas observacoes sobre a ORDEM, que e do legado e foi preservada:
    *  (a) SET KEY TO <expr> CONGELA o valor no momento do comando - nao
    *      reavalia a expressao quando TmpCabec se move. Medido no VFP9
    *      (2026-09-29, automation\ProbeGl2SetKey.prg): com TmpCabec na
    *      linha 2 no instante do SET KEY, o "Select TmpCabec / Go Top"
    *      seguinte leva o cabecalho para a linha 1 mas a grade de itens
    *      CONTINUA filtrada pela linha 2; e mover TmpCabec depois, sem
    *      refazer o SET KEY, nao muda o filtro. Ou seja, o filtro inicial
    *      depende de onde o formulario PAI deixou TmpCabec. Isso e
    *      comportamento do legado e foi mantido de proposito (PILAR 1):
    *      quem realinha o filtro com a linha efetivamente selecionada e o
    *      GradeOperacoesAfterRowColChange, na primeira troca de linha/
    *      coluna da grade. "Corrigir" aqui divergiria da tela legada.
    *  (b) a chave e POSICIONAL (Emps char(3) + Dopes char(20) + STR(Numes,6)
    *      = 29 caracteres): NAO usar ALLTRIM nas partes, senao a chave
    *      encurta, o SET KEY nunca casa e a grade de itens fica vazia SEM
    *      erro nenhum (CLAUDE.md regra #42).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("TmpItens") AND USED("TmpCabec")
                SELECT TmpItens
                SET ORDER TO EmpDopNum
                SET KEY TO TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)
                GO TOP

                SELECT TmpCabec
                GO TOP

                *-- Espelha a linha corrente de TmpCabec nas properties do BO
                *-- (ObterChavePrimaria/auditoria dependem delas)
                THIS.SincronizarBOComLinhaCorrente()

                THIS.Refresh()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SincronizarBOComLinhaCorrente - Equivalente de BOParaForm/FormParaBO
    * neste dialogo.
    *
    * SIGPRGL2 nao tem o par FormParaBO/BOParaForm classico: TODOS os
    * controles de dados (as 10 colunas da grade de cabecalho, as 8 da grade
    * de itens, getCliente e as duas caixas de observacao) sao ligados por
    * ControlSource DIRETO aos cursores TmpCabec/TmpItens, exatamente como no
    * Init do legado - o proprio VFP faz as duas direcoes do transporte, e
    * nao ha campo digitavel cujo valor precise ser empurrado para o BO.
    *
    * O que ainda precisa de transporte explicito e o ESTADO DE LINHA do BO:
    * SigPrGl2BO.CarregarDoCursor mapeia a linha corrente de TmpCabec para as
    * properties this_cEmps/this_cDopes/this_nNumes/... e e delas que
    * ObterChavePrimaria() monta a chave EmpDopNum usada na auditoria. Sem
    * esta chamada essas properties ficariam nos valores iniciais e a chave
    * sairia em branco.
    *
    * Preserva a area de trabalho corrente: CarregarDoCursor faz SELECT no
    * cursor de cabecalho, e os chamadores (CarregarDados e o
    * AfterRowColChange da grade de operacoes) dependem de terminar com
    * TmpItens/TmpCabec selecionado como o legado deixava.
    *--------------------------------------------------------------------------
    PROCEDURE SincronizarBOComLinhaCorrente()
        LOCAL loc_lSucesso, loc_cAliasAnterior, loc_cCursor, loc_oErro
        loc_lSucesso      = .F.
        loc_cAliasAnterior = ALIAS()

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorCabecalho
                IF !EMPTY(loc_cCursor) AND USED(loc_cCursor) AND ;
                        !EOF(loc_cCursor) AND !BOF(loc_cCursor)
                    loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SincronizarBOComLinhaCorrente")
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (SIGPRGL2 nao possui containers flutuantes - sem filtros por nome)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
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

    *--------------------------------------------------------------------------
    * Destroy - Reabilita o form pai e libera o Business Object ao fechar
    * (equivalente ao "ThisForm.ParentForm.Enabled = .t." do Cancelar.Click
    * legado, reproduzido aqui para cobrir TODO caminho de fechamento, nao
    * so o botao Cancelar)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
            THIS.this_oParentForm         = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
