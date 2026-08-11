*==============================================================================
* Formsigpdmp7.prg - Formulario de Movimentacao por Funcionario
* Tabela: SigCdNec | PK: cidchaves
* Legado: SIGPDMP7.SCX (frmcadastro)
* Fase 3/8: Estrutura Base - PageFrame, containers principais, metodos base
*==============================================================================

DEFINE CLASS Formsigpdmp7 AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .T.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    ForeColor    = RGB(90, 90, 90)
    DataSession  = 2

    *-- Business Object e mensagem de erro
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *-- Estado do movimento corrente
    this_cDopp        = ""    && Operacao/documento corrente (legado: _Dopp)
    this_cPQuery      = ""    && Filtro/query recebido no Init (legado: pQuery)
    this_oParentForm  = .NULL. && Referencia ao form pai (legado: ParentForm)
    this_cPcEscolha   = ""    && Modo: INSERIR/CONSULTAR/ALTERAR/EXCLUIR/PROCURAR
    this_lEditaOrig   = .T.   && Permite editar conta de origem (legado: editaorigem)
    this_lAtFoco      = .F.   && Controla SetFocus no Activate (legado: AtFoco)
    this_cTitulo      = ""    && Titulo da operacao corrente (legado: Titulo)
    this_cPEmps       = ""    && Empresa selecionada no filtro

    *-- Cache de nomes dos containers Origem/Destino/Responsavel
    this_cNomeContaos = ""    && Nome da conta de Origem (legado: TmpCli.RClis via Origem)
    this_cNomeContads = ""    && Nome da conta de Destino
    this_cNomeVends   = ""    && Nome da conta do Responsavel

    *--------------------------------------------------------------------------
    * Init - Captura parametros opcionais (legado: LParameters pQuery, pForm)
    * pQuery : filtro/query para a lista (WHERE livre ou valor de busca)
    * pForm  : referencia ao formulario pai que abriu este form
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cQuery, par_oFormPai)
        THIS.this_cPQuery    = IIF(VARTYPE(par_cQuery)   = "C", ALLTRIM(par_cQuery), "")
        THIS.this_oParentForm = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        IF VARTYPE(par_oFormPai) = "O" AND PEMSTATUS(par_oFormPai, "cCodEmpresa", 5)
            THIS.this_cPEmps = ALLTRIM(par_oFormPai.cCodEmpresa)
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado pelo FormBase.Init()
    * Cria BO, cursores de trabalho, monta PageFrame e carrega lista inicial
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Movimenta" + CHR(231) + CHR(227) + "o por Funcion" + CHR(225) + "rio"

            THIS.this_oBusinessObject = CREATEOBJECT("sigpdmp7BO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar sigpdmp7BO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                *-- Cursor placeholder para grid de lista (SigCdNec - colunas do SELECT do BO)
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (;
                        cidchaves C(20), empdnps C(33), emps C(3),;
                        dopps C(20), numps N(10,0), datas D,;
                        totpesos N(11,3), usuars C(10),;
                        grupoos C(10), contaos C(10),;
                        grupods C(10), contads C(10))
                    SET NULL OFF
                ENDIF

                *-- Cursor placeholder para GradeOperacao (TmpOperacao - legado: criacursor)
                IF !USED("TmpOperacao")
                    SET NULL ON
                    CREATE CURSOR TmpOperacao (Codigos N(12,0))
                    SET NULL OFF
                ENDIF

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption

                *-- Inicializar empresa via sistema global se nao recebida via parametro
                IF EMPTY(THIS.this_cPEmps) AND VARTYPE(go_4c_Sistema) = "O"
                    THIS.this_cPEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                *-- Nao executar SQL durante validacao de UI (sem conexao)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao inicializar Formsigpdmp7:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura PageFrame principal com 2 paginas
    * Top=-29 oculta abas do PageFrame; todos os controles nas Pages: Top += 29
    * Legado: Pagina.Top=-29, Left=-1, Width=1005, Height=635
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = -1
            .Width     = 1005
            .Height    = 631   && 635-4: Tabs=.F. via AddObject adiciona +4 ao Page.Height em runtime
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, container botoes CRUD (vazio),
    *   container saida com Encerrar
    * Compensacao PageFrame.Top=-29: controles de topo: Top += 29
    * Botoes CRUD e grid adicionados na Fase 4
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (fundo cinza escuro com titulo)
        *-- Legado: cntSombra.Top=2->31 (comp.); Width=1100; BackColor=RGB(100,100,100)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD com 5 botoes de acao
        *-- Legado: Grupo_op.Left=542, Top=-1+29=28, Width=385, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 385
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *-- Container de saida (padrao canonico - CLAUDE.md regra #10)
        *-- cnt_4c_Saida transparente flutuante; Left=917, Width=90
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *-- Grid de lista (Top=88+29=117; Left=26; Width=888; 9 colunas de SigCdNec)
        *-- ColumnCount fora do WITH para garantir criacao imediata das colunas (Problema 36)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 9

        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 888
            .Height             = 498
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .Column1.Width      = 70
            .Column2.Width      = 80
            .Column3.Width      = 80
            .Column4.Width      = 120
            .Column5.Width      = 100
            .Column6.Width      = 80
            .Column7.Width      = 80
            .Column8.Width      = 80
            .Column9.Width      = 80
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column2.Header1.Caption = "Data"
            .Column3.Header1.Caption = "Peso"
            .Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Column5.Header1.Caption = "Usu" + CHR(225) + "rio"
            .Column6.Header1.Caption = "Gr.Origem"
            .Column7.Header1.Caption = "Ct.Origem"
            .Column8.Header1.Caption = "Gr.Destino"
            .Column9.Header1.Caption = "Ct.Destino"
            .Visible            = .T.
        ENDWITH

        *-- Vincular eventos dos botoes e do grid da Page1
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GridListaAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: todos os controles de edicao
    * Fase 5: cnt_4c_Dados (Codigo/Data/NomeOperacao) + cnt_4c_Origem (Grupo/Conta/Nome)
    * Fase 6: cnt_4c_Destino, cnt_4c_Responsavel, botoes de acao, grid, memo
    * Compensacao PageFrame.Top=-29: controles diretos na Page: Top += 29
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        *-- Container central de dados (cntDados - Top=117+29=146, Left=8)
        *-- Contem: Codigo, Data, label NomeOperacao
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Dados", "Container")
        WITH loc_oPagina.cnt_4c_Dados
            .Top         = 146
            .Left        = 8
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Linha separadora horizontal
        loc_oPagina.cnt_4c_Dados.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.cnt_4c_Dados.lin_4c_Line1
            .Top     = 22
            .Left    = 11
            .Width   = 340
            .Height  = 0
            .Visible = .T.
        ENDWITH

        *-- Label "C?digo " (Say2)
        loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Label2
            .Caption   = "C" + CHR(243) + "digo "
            .Top       = 6
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (Get_codigo)
        *-- When legado: edita somente em PROCURAR ou INSERIR c/ numeras=1 e EditaOrigem
        loc_oPagina.cnt_4c_Dados.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.cnt_4c_Dados.txt_4c_Codigo
            .Value     = ""
            .Top       = 28
            .Left      = 11
            .Width     = 81
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .ReadOnly  = .T.
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *-- Label "Data " (Say3)
        loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Label3
            .Caption   = "Data "
            .Top       = 6
            .Left      = 101
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data da Movimentacao (Dt_data)
        *-- When legado: somente INSERIR/ALTERAR e sem envelopes no TmpOperacao
        *-- Valid legado: verifica periodo bloqueado (fVerificaBloqueio / fBloqueioPorPeriodo)
        loc_oPagina.cnt_4c_Dados.AddObject("txt_4c_Dt_data", "TextBox")
        WITH loc_oPagina.cnt_4c_Dados.txt_4c_Dt_data
            .Value     = DATE()
            .Top       = 28
            .Left      = 101
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *-- Label nome da operacao corrente (Nom_Operacao)
        *-- Preenchido via BOParaForm() / BtnIncluirClick() com nome da operacao
        loc_oPagina.cnt_4c_Dados.AddObject("lbl_4c_Nom_Operacao", "Label")
        WITH loc_oPagina.cnt_4c_Dados.lbl_4c_Nom_Operacao
            .Caption   = ""
            .Top       = 36
            .Left      = 319
            .Width     = 56
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENT: Valid da data valida periodo bloqueado (LostFocus no lugar do Valid do legado)
        BINDEVENT(loc_oPagina.cnt_4c_Dados.txt_4c_Dt_data, "LostFocus", THIS, "ValidarDataMov")

        *----------------------------------------------------------------------
        *-- Container Origem (Origem.Top=198+29=227, Left=7, Width=571, Height=75)
        *-- Todos os campos sao somente leitura (When=Return .F. no legado)
        *-- Preenchidos automaticamente ao selecionar operacao
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPagina.cnt_4c_Origem
            .Top         = 227
            .Left        = 7
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label "Origem" (Say4)
        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Label4
            .Caption   = "Origem"
            .Top       = 6
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Linha separadora Origem
        loc_oPagina.cnt_4c_Origem.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.cnt_4c_Origem.lin_4c_Line1
            .Top     = 22
            .Left    = 11
            .Width   = 340
            .Height  = 0
            .Visible = .T.
        ENDWITH

        *-- Label "Grupo" (Say1)
        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Label1
            .Caption   = "Grupo"
            .Top       = 27
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Conta" (Say2)
        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Label2
            .Caption   = "Conta"
            .Top       = 27
            .Left      = 96
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Label "Nome" (Say3)
        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_Label3
            .Caption   = "Nome"
            .Top       = 27
            .Left      = 180
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- TextBox Grupo de Origem (Get_grupo) - somente leitura
        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_Grupo
            .Value     = ""
            .Top       = 42
            .Left      = 11
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Conta de Origem (Get_conta) - somente leitura
        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_Conta
            .Value     = ""
            .Top       = 42
            .Left      = 96
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Nome da Conta de Origem (Get_dconta) - somente leitura
        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_Dconta
            .Value     = ""
            .Top       = 42
            .Left      = 180
            .Width     = 302
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container de botoes Confirmar/Cancelar
        *-- Legado: Grupo_Salva.Left=842, Top=-1+29=28
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 28
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container Destino (Destino.Top=278+29=307, Left=7, Width=571, Height=75)
        *-- Campos somente leitura: preenchidos ao selecionar operacao (When=.F. no legado)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Destino", "Container")
        WITH loc_oPagina.cnt_4c_Destino
            .Top         = 307
            .Left        = 7
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Label4
            .Caption   = "Destino"
            .Top       = 6
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.cnt_4c_Destino.lin_4c_Line1
            .Top         = 22
            .Left        = 11
            .Width       = 340
            .Height      = 0
            .BorderWidth = 2
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Label1
            .Caption   = "Grupo"
            .Top       = 27
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Label2
            .Caption   = "Conta"
            .Top       = 27
            .Left      = 96
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.cnt_4c_Destino.lbl_4c_Label3
            .Caption   = "Nome"
            .Top       = 27
            .Left      = 180
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.cnt_4c_Destino.txt_4c_Grupo
            .Value     = ""
            .Top       = 42
            .Left      = 11
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.cnt_4c_Destino.txt_4c_Conta
            .Value     = ""
            .Top       = 42
            .Left      = 96
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Destino.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPagina.cnt_4c_Destino.txt_4c_Dconta
            .Value     = ""
            .Top       = 42
            .Left      = 180
            .Width     = 302
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Container Responsavel (Responsavel.Top=357+29=386, Left=7, Width=571, Height=75)
        *-- Campos somente leitura: preenchidos ao selecionar operacao
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Responsavel", "Container")
        WITH loc_oPagina.cnt_4c_Responsavel
            .Top         = 386
            .Left        = 7
            .Width       = 571
            .Height      = 75
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Label4
            .Caption   = "Respons" + CHR(225) + "vel"
            .Top       = 6
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.cnt_4c_Responsavel.lin_4c_Line1
            .Top         = 22
            .Left        = 11
            .Width       = 340
            .Height      = 0
            .BorderWidth = 2
            .BorderColor = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Label1
            .Caption   = "Grupo"
            .Top       = 27
            .Left      = 11
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Label2
            .Caption   = "Conta"
            .Top       = 27
            .Left      = 96
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.cnt_4c_Responsavel.lbl_4c_Label3
            .Caption   = "Nome"
            .Top       = 27
            .Left      = 180
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.cnt_4c_Responsavel.txt_4c_Grupo
            .Value     = ""
            .Top       = 42
            .Left      = 11
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.cnt_4c_Responsavel.txt_4c_Conta
            .Value     = ""
            .Top       = 42
            .Left      = 96
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Responsavel.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPagina.cnt_4c_Responsavel.txt_4c_Dconta
            .Value     = ""
            .Top       = 42
            .Left      = 180
            .Width     = 302
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Botoes de acao na Page2 (Top=4+29=33) - abrem sub-formularios especificos
        *-- Legado: classe fwbtng. Visivel somente nos modos INSERIR/ALTERAR/CONSULTAR.
        *-- Posicoes: Left=397,472,547,622,697,772 (gap de 75px entre cada um)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cmd_4c_Operacao", "CommandButton")
        WITH loc_oPagina.cmd_4c_Operacao
            .Top             = 33
            .Left            = 397
            .Width           = 70
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Opera" + CHR(231) + CHR(245) + "es"
            .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_Componentes", "CommandButton")
        WITH loc_oPagina.cmd_4c_Componentes
            .Top             = 33
            .Left            = 472
            .Width           = 70
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Componen."
            .Picture         = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .ToolTipText     = "Componentes"
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_Etiquetas", "CommandButton")
        WITH loc_oPagina.cmd_4c_Etiquetas
            .Top             = 33
            .Left            = 547
            .Width           = 70
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Etiquetas"
            .Picture         = gc_4c_CaminhoIcones + "geral_etiqueta_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .ToolTipText     = "Etiquetas"
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_Dados", "CommandButton")
        WITH loc_oPagina.cmd_4c_Dados
            .Top             = 33
            .Left            = 622
            .Width           = 70
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Complem."
            .Picture         = gc_4c_CaminhoIcones + "geral_adicao_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .ToolTipText     = "Complemento"
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_Boleto", "CommandButton")
        WITH loc_oPagina.cmd_4c_Boleto
            .Top             = 33
            .Left            = 697
            .Width           = 70
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Boleto"
            .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_Documento", "CommandButton")
        WITH loc_oPagina.cmd_4c_Documento
            .Top             = 33
            .Left            = 772
            .Width           = 70
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Documento"
            .Picture         = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Shape de fundo para area dos botoes de acao
        *-- Legado: shpBtnGs.Top=150+29=179, Left=6, Width=484, Height=110
        *-- BackStyle=0 (transparente), BorderStyle=0 (sem borda)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("shp_4c_ShpBtnGs", "Shape")
        WITH loc_oPagina.shp_4c_ShpBtnGs
            .Top         = 179
            .Left        = 6
            .Width       = 484
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(36, 84, 155)
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Label "Observacao :" (Say3 na raiz de Page2 - Top=337+29=366, Left=592)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o : "
            .Top       = 366
            .Left      = 592
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- EditBox Observacao (Mm_obs - Top=353+29=382, Left=592, Width=397, Height=205)
        *-- Legado: ControlSource = "TmpNens.Obss"
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("obj_4c_Mm_obs", "EditBox")
        WITH loc_oPagina.obj_4c_Mm_obs
            .Value     = ""
            .Top       = 382
            .Left      = 592
            .Width     = 397
            .Height    = 205
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grid GradeOperacao (Top=4+29=33, Left=592, Width=171, Height=218)
        *-- Legado: RecordSource=TmpOperacao; Column1 oculto; grid inicia Visible=.F.
        *-- Preenchido pelos sub-formularios de operacao via cursor TmpOperacao
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oPagina.grd_4c_Dados.ColumnCount = 1

        WITH loc_oPagina.grd_4c_Dados
            .Top                = 33
            .Left               = 592
            .Width              = 171
            .Height             = 218
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ReadOnly           = .T.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .HeaderHeight       = 17
            .Column1.Width      = 94
            .Column1.Movable    = .F.
            .Column1.Resizable  = .F.
            .Column1.FontName   = "Courier New"
            .Column1.Format     = "KLZ"
            .Column1.InputMask  = "999999999999"
            .Column1.Visible    = .F.
            .Column1.Header1.Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Visible            = .F.  && Inicia oculto (preenchido pelos sub-forms)
        ENDWITH

        *-- Vincular RecordSource do grid ao cursor TmpOperacao (criado em InicializarForm)
        IF USED("TmpOperacao")
            loc_oPagina.grd_4c_Dados.RecordSource = "TmpOperacao"
            loc_oPagina.grd_4c_Dados.Column1.ControlSource = "TmpOperacao.Codigos"
        ENDIF

        *-- BINDEVENTs para botoes de acao da Page2
        BINDEVENT(loc_oPagina.cmd_4c_Operacao,    "Click", THIS, "BtnOperacaoClick")
        BINDEVENT(loc_oPagina.cmd_4c_Componentes, "Click", THIS, "BtnComponentesClick")
        BINDEVENT(loc_oPagina.cmd_4c_Etiquetas,   "Click", THIS, "BtnEtiquetasClick")
        BINDEVENT(loc_oPagina.cmd_4c_Dados,       "Click", THIS, "BtnDadosClick")
        BINDEVENT(loc_oPagina.cmd_4c_Boleto,      "Click", THIS, "BtnBoletoClick")
        BINDEVENT(loc_oPagina.cmd_4c_Documento,   "Click", THIS, "BtnDocumentoClick")

        *-- Vincular eventos dos botoes da Page2
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- Restaurar Visible=.F. do grid apos TornarControlesVisiveis (que seta tudo para .T.)
        IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
            loc_oPagina.grd_4c_Dados.Visible = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Executa Buscar() no BO e atualiza o grid de lista
    * O grid (grd_4c_Lista) e adicionado na Fase 4; usa PEMSTATUS para nao
    * crashar quando chamado antes da Fase 4 ser aplicada
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (;
                        cidchaves C(20), empdnps C(33), emps C(3),;
                        dopps C(20), numps N(10,0), datas D,;
                        totpesos N(11,3), usuars C(10),;
                        grupoos C(10), contaos C(10),;
                        grupods C(10), contads C(10))
                    SET NULL OFF
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar(THIS.this_cPQuery)
                    loc_lResultado = .F.
                ELSE
                    *-- Configurar grid quando existir (adicionado na Fase 4)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        loc_oGrid.ColumnCount = 9
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numps"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.totpesos"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.dopps"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.usuars"
                        loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.grupoos"
                        loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.contaos"
                        loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.grupods"
                        loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.contads"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            loc_lResultado = .F.
        ELSE
            TRY
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            CATCH TO loException
                MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao visual padrao ao grid de lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Itera Pages de PageFrames e Controls de Containers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND ;
                   !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * GridListaAfterRowColChange - Atualiza this_cDopp ao mover linha no grid
    *--------------------------------------------------------------------------
    PROCEDURE GridListaAfterRowColChange(par_nColIndex)
        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            THIS.this_cDopp = ALLTRIM(cursor_4c_Dados.dopps)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cPcEscolha  = "INSERIR"
        THIS.this_cModoAtual  = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para visualizar.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para visualizar.", "")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cDopp      = ALLTRIM(cursor_4c_Dados.dopps)
            THIS.this_cPcEscolha = "CONSULTAR"
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para alterar.", "")
            RETURN
        ENDIF
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cDopp      = ALLTRIM(cursor_4c_Dados.dopps)
            THIS.this_cPcEscolha = "ALTERAR"
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.", "")
            RETURN
        ENDIF
        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Confirmar Exclus" + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
                    THIS.CarregarLista()
                ELSE
                    MsgErro("Erro ao excluir o registro.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o.", "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra lista por codigo, operacao ou usuario
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro
        loc_cFiltro = INPUTBOX("Informe o c" + CHR(243) + "digo, opera" + CHR(231) + ;
            CHR(227) + "o ou usu" + CHR(225) + "rio:", "Buscar")
        IF VARTYPE(loc_cFiltro) = "C"
            THIS.this_cPQuery = ALLTRIM(loc_cFiltro)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Transfere Form->BO e chama Salvar(); volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao salvar o registro.", "Erro")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para lista recarregada
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do formulario para o Business Object
    * Usa PEMSTATUS para acessar controles da Page2 com seguranca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        *-- Empresa e operacao
        loc_oBO.this_cEmps  = THIS.this_cPEmps
        loc_oBO.this_cDopps = THIS.this_cDopp

        *-- Container central de dados (cntDados)
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
                loc_oBO.this_cCidchaves = ALLTRIM(loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
                loc_oBO.this_dDatas = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value
            ENDIF
        ENDIF

        *-- Origem
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
                loc_oBO.this_cGrupoos = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
                loc_oBO.this_cContaos = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value)
            ENDIF
        ENDIF

        *-- Destino
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
                loc_oBO.this_cGrupods = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
                loc_oBO.this_cContads = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value)
            ENDIF
        ENDIF

        *-- Responsavel
        IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Grupo", 5)
                loc_oBO.this_cGrvends = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Grupo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Conta", 5)
                loc_oBO.this_cVends = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Conta.Value)
            ENDIF
        ENDIF

        *-- Observacao
        IF PEMSTATUS(loc_oPg2, "obj_4c_Mm_obs", 5)
            loc_oBO.this_cObss = loc_oPg2.obj_4c_Mm_obs.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do Business Object para o formulario
    * Usa PEMSTATUS para acessar controles da Page2 com seguranca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
                loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value = ALLTRIM(loc_oBO.this_cCidchaves)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
                loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = loc_oBO.this_dDatas
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "lbl_4c_Nom_Operacao", 5)
                loc_oPg2.cnt_4c_Dados.lbl_4c_Nom_Operacao.Caption = ALLTRIM(loc_oBO.this_cDopps)
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupoos)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContaos)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Dconta", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Dconta.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupods)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContads)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Dconta", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Dconta.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrvends)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cVends)
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Dconta", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Dconta.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_Mm_obs", 5)
            loc_oPg2.obj_4c_Mm_obs.Value = ALLTRIM(loc_oBO.this_cObss)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita controles editaveis da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
                loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Enabled = ;
                    par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
                loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Enabled = par_lHabilitar
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.ReadOnly = !par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Conta.ReadOnly = !par_lHabilitar
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.ReadOnly = !par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Conta.ReadOnly = !par_lHabilitar
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Grupo.ReadOnly = !par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Conta.ReadOnly = !par_lHabilitar
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_Mm_obs", 5)
            loc_oPg2.obj_4c_Mm_obs.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos controles da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
                loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
                loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Dados, "lbl_4c_Nom_Operacao", 5)
                loc_oPg2.cnt_4c_Dados.lbl_4c_Nom_Operacao.Caption = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Origem", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Grupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Conta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Origem, "txt_4c_Dconta", 5)
                loc_oPg2.cnt_4c_Origem.txt_4c_Dconta.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Destino", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Destino, "txt_4c_Dconta", 5)
                loc_oPg2.cnt_4c_Destino.txt_4c_Dconta.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Responsavel", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Grupo", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Grupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Conta", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Conta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_Responsavel, "txt_4c_Dconta", 5)
                loc_oPg2.cnt_4c_Responsavel.txt_4c_Dconta.Value = ""
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "obj_4c_Mm_obs", 5)
            loc_oPg2.obj_4c_Mm_obs.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo corrente
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lLista, loc_lEditar
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lLista  = (THIS.this_cModoAtual = "LISTA")
        loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lLista
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lLista
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lLista
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lLista
            ENDIF
            IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
                loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lLista
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
            ENDIF
            IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDataMov - Valida data da movimentacao ao sair do campo
    * Legado: Dt_data.Valid - verifica fVerificaBloqueio e fBloqueioPorPeriodo
    * No novo sistema: verifica se a data esta dentro do periodo permitido pelo BO
    * Tambem bloqueia alteracao de data quando ja existem envelopes (TmpOperacao)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDataMov()
        LOCAL loc_oPg2, loc_dData, loc_lBloqueado, loc_nContEnv
        loc_lBloqueado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF !PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
                RETURN
            ENDIF
            IF !PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Dt_data", 5)
                RETURN
            ENDIF

            loc_dData = loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value

            IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
                RETURN
            ENDIF

            IF EMPTY(loc_dData)
                MsgAviso("Informe uma data v" + CHR(225) + "lida.", "")
                loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
                RETURN
            ENDIF

            *-- Verifica se ja existem envelopes/ops lancados (TmpOperacao)
            *-- Legado: Count to _LnCont For Codigos > 0
            IF USED("TmpOperacao")
                SELECT TmpOperacao
                COUNT TO loc_nContEnv FOR Codigos > 0
                IF loc_nContEnv > 0
                    MsgAviso("A Data s" + CHR(243) + "mente pode ser alterada antes de Informar Envelopes/Ops", "")
                    loc_lBloqueado = .T.
                ENDIF
            ENDIF

            *-- Verifica bloqueio de periodo no BO
            IF !loc_lBloqueado
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    IF THIS.this_oBusinessObject.VerificarPeriodoBloqueado(loc_dData)
                        MsgAviso("Per" + CHR(237) + "odo Bloqueado!!!", "")
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lBloqueado
                loc_oPg2.cnt_4c_Dados.txt_4c_Dt_data.Value = DATE()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar data:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOperacaoClick - Abre sub-formulario de operacoes (legado: SigPdMp5)
    * Legado: If pcEscolha<>'PROCURAR' -> Disable form -> Select xMfas -> Do Form SigPdMp5
    *--------------------------------------------------------------------------
    PROCEDURE BtnOperacaoClick()
        LOCAL loc_cFormPath
        IF THIS.this_cPcEscolha = "PROCURAR"
            RETURN
        ENDIF
        TRY
            THIS.Enabled = .F.
            IF USED("xMfas")
                SELECT xMfas
                SET ORDER TO
            ENDIF
            loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp5.scx"
            IF FILE(loc_cFormPath)
                DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
            ELSE
                MsgAviso("Subformul" + CHR(225) + "rio de Opera" + CHR(231) + CHR(245) + "es (SigPdMp5) n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel.", "")
            ENDIF
            THIS.Enabled = .T.
        CATCH TO loException
            THIS.Enabled = .T.
            MostrarErro("Erro ao abrir Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnComponentesClick - Abre sub-formulario de componentes (legado: SigPdMp2)
    * Legado: If pcEscolha<>'PROCURAR' -> Disable form -> Select xNensi -> Do Form SigPdMp2
    *--------------------------------------------------------------------------
    PROCEDURE BtnComponentesClick()
        LOCAL loc_cFormPath
        IF THIS.this_cPcEscolha = "PROCURAR"
            RETURN
        ENDIF
        TRY
            THIS.Enabled = .F.
            IF USED("xNensi")
                SELECT xNensi
                SET ORDER TO
            ENDIF
            loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp2.scx"
            IF FILE(loc_cFormPath)
                DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
            ELSE
                MsgAviso("Subformul" + CHR(225) + "rio de Componentes (SigPdMp2) n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel.", "")
            ENDIF
            THIS.Enabled = .T.
        CATCH TO loException
            THIS.Enabled = .T.
            MostrarErro("Erro ao abrir Componentes:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEtiquetasClick - Abre sub-formulario de etiquetas/pesagem
    * Legado: If pcEscolha<>'PROCURAR':
    *   If crSigCdPam.AltPesas=1 -> Select xOpi -> Do Form SigPdMp3
    *   Else -> Select xPesa -> Do Form SigPdMp9
    *--------------------------------------------------------------------------
    PROCEDURE BtnEtiquetasClick()
        LOCAL loc_cFormPath, loc_lAltPesas
        IF THIS.this_cPcEscolha = "PROCURAR"
            RETURN
        ENDIF
        TRY
            THIS.Enabled = .F.
            loc_lAltPesas = .F.

            *-- Verifica flag AltPesas no cursor de parametros (crSigCdPam)
            IF USED("crSigCdPam") AND PEMSTATUS(crSigCdPam, "AltPesas", 8)
                loc_lAltPesas = (crSigCdPam.AltPesas = 1)
            ENDIF

            IF loc_lAltPesas
                IF USED("xOpi")
                    SELECT xOpi
                    GO TOP
                ENDIF
                loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp3.scx"
                IF FILE(loc_cFormPath)
                    DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
                ELSE
                    MsgAviso("Subformul" + CHR(225) + "rio de Etiquetas (SigPdMp3) n" + ;
                        CHR(227) + "o dispon" + CHR(237) + "vel.", "")
                ENDIF
            ELSE
                IF USED("xPesa")
                    SELECT xPesa
                    GO TOP
                ENDIF
                loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigPdMp9.scx"
                IF FILE(loc_cFormPath)
                    DO FORM (loc_cFormPath) WITH THIS
                ELSE
                    MsgAviso("Subformul" + CHR(225) + "rio de Etiquetas (SigPdMp9) n" + ;
                        CHR(227) + "o dispon" + CHR(237) + "vel.", "")
                ENDIF
            ENDIF
            THIS.Enabled = .T.
        CATCH TO loException
            THIS.Enabled = .T.
            MostrarErro("Erro ao abrir Etiquetas:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDadosClick - Abre sub-formulario de complemento de dados (legado: SigOpInf)
    * Legado: Do Form SigOpInf With ThisForm, ThisForm.DataSessionId
    *--------------------------------------------------------------------------
    PROCEDURE BtnDadosClick()
        LOCAL loc_cFormPath
        TRY
            loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigOpInf.scx"
            IF FILE(loc_cFormPath)
                DO FORM (loc_cFormPath) WITH THIS, THIS.DataSessionId
            ELSE
                MsgAviso("Subformul" + CHR(225) + "rio de Complemento (SigOpInf) n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel.", "")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao abrir Complemento:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBoletoClick - Impressao de boleto se operacao permite
    * Legado: Seek(ThisForm._Dopp,'crSigCdOpd','Dopps') -> If Boletos=1 -> ImpBol()
    *--------------------------------------------------------------------------
    PROCEDURE BtnBoletoClick()
        LOCAL loc_lPermite
        loc_lPermite = .F.
        TRY
            IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
                SELECT crSigCdOpd
                SET NEAR ON
                SEEK THIS.this_cDopp ORDER TAG Dopps
                SET NEAR OFF
                IF FOUND() AND !EOF("crSigCdOpd")
                    loc_lPermite = (crSigCdOpd.Boletos = 1)
                ENDIF
            ENDIF
            IF loc_lPermite
                THIS.ImpBol()
            ELSE
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o atual n" + CHR(227) + ;
                    "o permite impress" + CHR(227) + "o de boleto.", "")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao imprimir boleto:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Impressao de documento se operacao permite
    * Legado: Seek(ThisForm._Dopp,'crSigCdOpd','Dopps') -> If Docus=1 -> Do SigPrIdc
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_lPermite, loc_cPrgPath
        loc_lPermite = .F.
        TRY
            IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
                SELECT crSigCdOpd
                SET NEAR ON
                SEEK THIS.this_cDopp ORDER TAG Dopps
                SET NEAR OFF
                IF FOUND() AND !EOF("crSigCdOpd")
                    loc_lPermite = (crSigCdOpd.Docus = 1)
                ENDIF
            ENDIF
            IF loc_lPermite AND USED("TmpNens") AND !EOF("TmpNens")
                SELECT TmpNens

                *-- Atualiza cursor crSigCdNec para registro corrente
                IF USED("crSigCdOpd")
                    SELECT crSigCdOpd
                    SET NEAR ON
                    SEEK ALLTRIM(TmpNens.Dopps) ORDER TAG Dopps
                    SET NEAR OFF
                ENDIF

                loc_cPrgPath = gc_4c_CaminhoBase + "..\Framework\SigPrIdc.prg"
                IF FILE(loc_cPrgPath)
                    DO (loc_cPrgPath) WITH ;
                        ALLTRIM(TmpNens.Emps), ALLTRIM(TmpNens.Dopps), TmpNens.Numps, ;
                        0, crSigCdOpd.QtdDocs, .F., .F., .F., .F., .F., .F., THIS
                ELSE
                    MsgAviso("Rotina de impress" + CHR(227) + "o de documento (SigPrIdc) n" + ;
                        CHR(227) + "o dispon" + CHR(237) + "vel.", "")
                ENDIF
            ELSE
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o atual n" + CHR(227) + ;
                    "o permite impress" + CHR(227) + "o de documento.", "")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao imprimir documento:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ImpBol - Impressao de boleto via sub-formulario SigOpIbo
    * Legado: Do Form SigOpIbo With Thisform, 2, This.Titulo
    *--------------------------------------------------------------------------
    PROCEDURE ImpBol()
        LOCAL loc_cFormPath
        TRY
            loc_cFormPath = gc_4c_CaminhoBase + "..\Framework\SigOpIbo.scx"
            IF FILE(loc_cFormPath)
                DO FORM (loc_cFormPath) WITH THIS, 2, THIS.this_cTitulo
            ELSE
                MsgAviso("Subformul" + CHR(225) + "rio de boleto (SigOpIbo) n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel.", "")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao imprimir boleto (ImpBol):" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - Gerencia foco automatico ao ativar o formulario
    * Legado: Activate -> Seek(Dopp, crSigCdOpd, Dopps) + SetFocus nos campos
    * this_lAtFoco controla se deve setar foco (evita loop na 1a abertura)
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        LOCAL loc_oPg2
        TRY
            DODEFAULT()

            *-- Posiciona cursor de operacoes no Dopp corrente
            IF !EMPTY(THIS.this_cDopp) AND USED("crSigCdOpd")
                SELECT crSigCdOpd
                SET NEAR ON
                SEEK THIS.this_cDopp ORDER TAG Dopps
                SET NEAR OFF
            ENDIF

            *-- Coloca foco no campo adequado conforme modo
            IF THIS.this_lAtFoco
                THIS.this_lAtFoco = .F.
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2

                DO CASE
                    CASE THIS.this_cPcEscolha = "PROCURAR"
                        IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5) AND ;
                           PEMSTATUS(loc_oPg2.cnt_4c_Dados, "txt_4c_Codigo", 5)
                            loc_oPg2.cnt_4c_Dados.txt_4c_Codigo.SetFocus
                        ENDIF

                    CASE INLIST(THIS.this_cPcEscolha, "CONSULTAR", "EXCLUIR")
                        IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5) AND ;
                           PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
                        ENDIF
                ENDCASE
            ENDIF

            *-- Garantir cursor TmpNens no topo se disponivel
            IF USED("TmpNens")
                SELECT TmpNens
                GO TOP
            ENDIF

        CATCH TO loException
            *-- Erros de foco nao devem travar a interface
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("TmpOperacao")
                USE IN TmpOperacao
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar erros no Destroy para nao bloquear fechamento
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
