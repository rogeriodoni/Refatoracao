*==============================================================================
* FormSIGOPCGF.prg - Consulta Global Financeira (OPERACIONAL)
* Migrado de SIGOPCGF.SCX
*
* Form OPERACIONAL customizado (NAO segue padrao CRUD Page1=Lista/Page2=Dados):
* consulta financeira sobre titulos (SigCdPit) movimentados contra contas
* (SigCdCli), com filtros amplos de data/titulo/moeda/publicidade/empresa e
* grupos de contas selecionaveis em duas grades auxiliares. PageFrame com
* abas OCULTAS (Tabs=.F., como no legado) e navegacao via CommandGroup:
*
*   Page1 pgFiltros "Filtros" - cabecalho (cntSombra) + filtros de
*                   data/titulo/moeda/empresa + grades de selecao de
*                   contas/grupos + CommandGroup cmgFiltros (Filtrar/Fechar)
*   Page2 pgDados   "Dados"   - grade de resultado (LocalDados), botoes de
*                   acao (Movimento/Recebimento/FollowUp/Imprimir/Planilha)
*                   e CommandGroup cmgRetornar (volta para Page1)
*
* O cabecalho (cntSombra/lblSombra/lblTitulo) existe SO na Page1 no legado -
* a Page2 nao tem faixa de titulo (regra #11 do CLAUDE.md eh especifica de
* frmcadastro e nao se aplica a este form OPERACIONAL).
*
* Herda de: FormBase
* BO: SIGOPCGFBO (sem tabela/PK propria - consulta multi-tabela)
*
* Historico de fases:
*   Fase 1/2: SIGOPCGFBO.prg - propriedades e metodos de carga/consulta
*   Fase 3:   FormSIGOPCGF.prg - estrutura base (heranca, Init, PageFrame
*             com as 2 paginas Filtros/Dados)
*==============================================================================

DEFINE CLASS FormSIGOPCGF AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - valores exatos do SCX original)
    *--------------------------------------------------------------------------
    Width        = 1000
    Height       = 700
    DataSession  = 2
    AutoCenter   = .T.
    Caption      = "Consulta Global Financeira"
    ShowTips     = .T.
    ShowWindow   = 1
    WindowType   = 1
    ClipControls = .F.
    Themes       = .F.
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Business Object
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Controle de pagina ativa: FILTROS / DADOS
    *--------------------------------------------------------------------------
    this_cModoAtual = "FILTROS"

    *--------------------------------------------------------------------------
    * Guarda de reentrancia dos lookups de Page1 (regra #37/#47 do CLAUDE.md) -
    * o picker (FormBuscaAuxiliar) eh MODAL e tira o foco do campo, o que
    * redispara o proprio LostFocus; a flag eh ligada dentro de cada
    * AbrirLookup*, que eh o funil de todas as entradas daquele campo.
    *--------------------------------------------------------------------------
    this_lEmLookup = .F.

    *--------------------------------------------------------------------------
    * Guarda de "valor nao mudou" dos lookups de LostFocus de Page1 - no
    * legado o Valid so dispara quando o valor MUDA, mas LostFocus dispara
    * SEMPRE que o campo perde o foco (ex.: usuario so navega com Tab sem
    * alterar nada). Sem isto, cada LostFocus reabre a consulta ao SQL
    * Server mesmo sem mudanca no campo.
    *--------------------------------------------------------------------------
    this_cUltimoValidarCMoesValidado           = ""
    this_cUltimoValidarDMoesValidado           = ""
    this_cUltimoValidarCMoesCValidado          = ""
    this_cUltimoValidarDMoesCValidado          = ""
    this_cUltimoValidarMoeSaldoValidado        = ""
    this_cUltimoValidarCFPublisValidado        = ""
    this_cUltimoValidarDFPublisValidado        = ""
    this_cUltimoValidarEspecieNfsFiltroValidado = ""
    this_cUltimoValidarTitBansFiltroValidado   = ""

    *--------------------------------------------------------------------------
    * Init - Chama FormBase.Init() que dispara InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object e monta a estrutura base
    * (PageFrame com as 2 paginas). Grid, filtros, botoes e eventos sao
    * adicionados nas fases seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPCGFBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SIGOPCGFBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.CriarCursoresFiltros()
                THIS.ConfigurarPaginaFiltros()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "FILTROS"

                THIS.TornarControlesVisiveis(THIS)

                *-- Aplica o contrato de digitacao dos PROCEDURE When do
                *-- legado (filtros digitaveis na Page1; campos de detalhe da
                *-- Page2 somente exibicao) - ver HabilitarCampos().
                THIS.HabilitarCampos(.T.)

                *-- SQL de carga (tipos de operacao + filtros nomeados salvos)
                *-- fica fora do modo de validacao de UI/teste automatizado,
                *-- igual ao padrao CarregarLista() dos forms CRUD.
                IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
                   (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
                    THIS.CarregarTiposOperacao()
                    THIS.CarregarFiltrosSalvos()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria o PageFrame com as 2 paginas (Filtros/Dados).
    * Abas OCULTAS (Tabs = .F., como no legado) - a navegacao entre paginas eh
    * feita pelos CommandGroups cmgFiltros/cmgRetornar, criados na Fase 4.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height
            .BorderWidth = 0
            .PageCount   = 2
            .Tabs        = .F.
            .Visible   = .F.

            .Page1.Caption   = "Filtros"
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page1.FontName  = "Verdana"
            .Page1.FontSize  = 8
            .Page1.FontBold  = .T.
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.ForeColor = RGB(36, 84, 155)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.FontName  = "Verdana"
            .Page2.FontSize  = 8
            .Page2.FontBold  = .T.
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.ForeColor = RGB(36, 84, 155)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis, recursivamente, todos os
    * controles filhos (Pages de PageFrame + Controls de Container). AddObject
    * cria os controles com Visible=.F. por padrao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                *-- Controles deliberadamente ocultos no Init (toggle de UI
                *-- do legado - txt_4c_NewFiltro so aparece apos CmdAddFiltroClick,
                *-- no mesmo Top/Left de txt_4c_Filtros) NAO podem ser forcados a
                *-- Visible=.T. por este metodo recursivo, senao os dois ficam
                *-- sobrepostos e visiveis desde a abertura do form.
                IF !INLIST(UPPER(loc_oControl.Name), "TXT_4C_NEWFILTRO")
                    IF PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FASE 4 - Page1 (pgFiltros): cursores de trabalho, grid completo
    * (grdTipo + Grd_Clientes + Grd_Clientes2) e botoes CRUD de linha/filtro.
    * Nomes e geometria transcritos de tasks\task691\SIGOPCGF_form_codigo_
    * fonte.txt (SECAO 2: PROPRIEDADES CUSTOMIZADAS). AlternarPagina() navega
    * entre Filtros/Dados; a consulta financeira completa (LocalDados) e o
    * grid/botoes da Page2 ficam para a fase seguinte.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CriarCursoresFiltros - Cria os cursores placeholder da Page1 ANTES do
    * ConfigurarPaginaFiltros() poder bindar os Grids (regra #41 - Column.
    * ControlSource exige que o cursor ja exista). Estrutura IDENTICA a que
    * CarregarTiposOperacao()/CarregarFiltrosSalvos() (SQLEXEC + SELECT INTO
    * CURSOR) recriam depois ("cursor placeholder = cursor real").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursoresFiltros()
        LOCAL loc_cTipos, loc_cClientes, loc_cClientes2, loc_cFiltros

        loc_cTipos     = THIS.this_oBusinessObject.this_cCursorTipos
        loc_cClientes  = THIS.this_oBusinessObject.this_cCursorClientes
        loc_cClientes2 = THIS.this_oBusinessObject.this_cCursorClientes2
        loc_cFiltros   = THIS.this_oBusinessObject.this_cCursorFiltros

        IF !USED(loc_cTipos)
            CREATE CURSOR (loc_cTipos) (Imps N(1,0), Dopes C(20), Opers C(2), RealPrevs N(1,0))
            INDEX ON Dopes TAG Dopes
        ENDIF

        IF !USED(loc_cClientes)
            CREATE CURSOR (loc_cClientes) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
                CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
            SELECT (loc_cClientes)
            APPEND BLANK
        ENDIF

        IF !USED(loc_cClientes2)
            CREATE CURSOR (loc_cClientes2) (Grupo C(10), NomeGrupo C(20), Conta C(10), Nome C(50), ;
                CheckE N(1,0), CheckP N(1,0), CheckC N(1,0), CheckA N(1,0))
            SELECT (loc_cClientes2)
            APPEND BLANK
        ENDIF

        IF !USED(loc_cFiltros)
            CREATE CURSOR (loc_cFiltros) (Cidparams C(64), Ctpparams C(1), Mxmls M, Descrs C(40))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Monta todo o conteudo da Page1 (cabecalho,
    * campos de filtro, OptionGroups, grades e botoes).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        THIS.ConfigurarCabecalhoFiltros(loc_oPag)
        THIS.ConfigurarCamposFiltros(loc_oPag)
        THIS.ConfigurarOptionGroupsFiltros(loc_oPag)
        THIS.ConfigurarGradesFiltros(loc_oPag)
        THIS.ConfigurarBotoesFiltros(loc_oPag)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalhoFiltros - Faixa de titulo (cntSombra) + CommandGroup
    * de navegacao (cmgFiltros: Consultar/Sair). SCX: Top=-3,Left=835,W=173,
    * H=110, Buttons 75x75 (Comic Sans MS), icones cadastro_procurar_60.jpg /
    * cadastro_sair_60.jpg.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalhoFiltros(par_oPag)
        par_oPag.AddObject("cnt_4c_Sombra", "Container")
        WITH par_oPag.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 25
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .BackStyle = 0
                .WordWrap  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_TituloCabecalho", "Label")
            WITH .lbl_4c_TituloCabecalho
                .Top       = 24
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .BackStyle = 0
                .WordWrap  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmg_4c_Filtros", "CommandGroup")
        WITH par_oPag.cmg_4c_Filtros
            .Top           = -3
            .Left          = 835
            .Width         = 173
            .Height        = 110
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.

            WITH .Buttons(1)
                .Top         = 5
                .Left        = 11
                .Width       = 75
                .Height      = 75
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .Caption     = "\<Consultar"
                .ToolTipText = "Consultar Usando os Filtros Informados"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top         = 5
                .Left        = 87
                .Width       = 75
                .Height      = 75
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel      = .T.
                .Caption     = "\<Sair"
                .ToolTipText = "[ESC] Sair"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH

            .Visible = .T.
        ENDWITH

        BINDEVENT(par_oPag.cmg_4c_Filtros, "Click", THIS, "CmgFiltrosClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposFiltros - Labels + TextBoxes/CheckBoxes de filtro (datas,
    * titulo, titulo banco, especie NF, NF, moedas, saldo, publicidade,
    * empresa, filtro nomeado). Geometria e Format/InputMask transcritos do
    * dump do SCX legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFiltros(par_oPag)
        LOCAL loc_cAte
        loc_cAte = "at" + CHR(233)

        *-- Emissao
        par_oPag.AddObject("lbl_4c_SayPed", "Label")
        WITH par_oPag.lbl_4c_SayPed
            .Top = 132
            .Left = 139
            .Width = 47
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Emiss" + CHR(227) + "o :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DtEmiI", "TextBox")
        WITH par_oPag.txt_4c_DtEmiI
            .Top = 128
            .Left = 190
            .Width = 80
            .Height = 23
            .Alignment = 3
            .Value = {}
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH par_oPag.lbl_4c_Label2
            .Top = 132
            .Left = 275
            .Width = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = loc_cAte
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DtEmiF", "TextBox")
        WITH par_oPag.txt_4c_DtEmiF
            .Top = 129
            .Left = 299
            .Width = 80
            .Height = 23
            .Alignment = 3
            .Value = {}
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Vencimento
        par_oPag.AddObject("lbl_4c_Say1", "Label")
        WITH par_oPag.lbl_4c_Say1
            .Top = 158
            .Left = 122
            .Width = 64
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Vencimento :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_VencsI", "TextBox")
        WITH par_oPag.txt_4c_VencsI
            .Top = 154
            .Left = 190
            .Width = 80
            .Height = 23
            .Alignment = 3
            .Value = {}
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPag.lbl_4c_Label1
            .Top = 158
            .Left = 275
            .Width = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = loc_cAte
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_VencsF", "TextBox")
        WITH par_oPag.txt_4c_VencsF
            .Top = 154
            .Left = 299
            .Width = 80
            .Height = 23
            .Alignment = 3
            .Value = {}
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Lancamento
        par_oPag.AddObject("lbl_4c_Say2", "Label")
        WITH par_oPag.lbl_4c_Say2
            .Top = 184
            .Left = 119
            .Width = 67
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Lan" + CHR(231) + "amento :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DatasI", "TextBox")
        WITH par_oPag.txt_4c_DatasI
            .Top = 180
            .Left = 190
            .Width = 80
            .Height = 23
            .Alignment = 3
            .Value = {}
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("lbl_4c_Label3", "Label")
        WITH par_oPag.lbl_4c_Label3
            .Top = 184
            .Left = 275
            .Width = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = loc_cAte
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DatasF", "TextBox")
        WITH par_oPag.txt_4c_DatasF
            .Top = 180
            .Left = 299
            .Width = 80
            .Height = 23
            .Alignment = 3
            .Value = {}
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Acerto (Baixa)
        par_oPag.AddObject("lbl_4c_Say13", "Label")
        WITH par_oPag.lbl_4c_Say13
            .Top = 210
            .Left = 145
            .Width = 41
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Acerto :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DtBxI", "TextBox")
        WITH par_oPag.txt_4c_DtBxI
            .Top = 206
            .Left = 190
            .Width = 80
            .Height = 23
            .Alignment = 3
            .Value = {}
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("lbl_4c_Label4", "Label")
        WITH par_oPag.lbl_4c_Label4
            .Top = 210
            .Left = 275
            .Width = 18
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption = loc_cAte
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DtBxF", "TextBox")
        WITH par_oPag.txt_4c_DtBxF
            .Top = 206
            .Left = 299
            .Width = 80
            .Height = 23
            .Alignment = 3
            .Value = {}
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Branco (checkbox ao lado da faixa de Emissao)
        par_oPag.AddObject("chk_4c_Brancos", "CheckBox")
        WITH par_oPag.chk_4c_Brancos
            .Top = 134
            .Left = 382
            .Width = 46
            .Height = 13
            .FontSize = 7
            .Alignment = 0
            .Caption = "Branco"
            .Value = 0
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Titulo
        par_oPag.AddObject("lbl_4c_Say4", "Label")
        WITH par_oPag.lbl_4c_Say4
            .Top = 133
            .Left = 466
            .Width = 35
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption = "T" + CHR(237) + "tulo :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_Titulos", "TextBox")
        WITH par_oPag.txt_4c_Titulos
            .Top = 129
            .Left = 504
            .Width = 80
            .Height = 23
            .Alignment = 3
            .Value = ""
            .MaxLength = 10
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Nota Fiscal
        par_oPag.AddObject("lbl_4c_Say20", "Label")
        WITH par_oPag.lbl_4c_Say20
            .Top = 158
            .Left = 440
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Nota Fiscal :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_NFs", "TextBox")
        WITH par_oPag.txt_4c_NFs
            .Top = 154
            .Left = 504
            .Width = 80
            .Height = 23
            .Value = ""
            .Format = "K!"
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Titulo Banco
        par_oPag.AddObject("lbl_4c_Say12", "Label")
        WITH par_oPag.lbl_4c_Say12
            .Top = 184
            .Left = 434
            .Width = 67
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "T" + CHR(237) + "tulo Banco :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_TitBans", "TextBox")
        WITH par_oPag.txt_4c_TitBans
            .Top = 180
            .Left = 504
            .Width = 80
            .Height = 23
            .Value = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Especie da NF
        par_oPag.AddObject("lbl_4c_Say25", "Label")
        WITH par_oPag.lbl_4c_Say25
            .Top = 210
            .Left = 456
            .Width = 45
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Esp" + CHR(233) + "cie :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_EspecieNfs", "TextBox")
        WITH par_oPag.txt_4c_EspecieNfs
            .Top = 206
            .Left = 504
            .Width = 52
            .Height = 23
            .Value = ""
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Moeda Filtro
        par_oPag.AddObject("lbl_4c_LblFator", "Label")
        WITH par_oPag.lbl_4c_LblFator
            .Top = 236
            .Left = 118
            .Width = 68
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Moeda Filtro :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_CMoes", "TextBox")
        WITH par_oPag.txt_4c_CMoes
            .Top = 232
            .Left = 190
            .Width = 31
            .Height = 23
            .Value = ""
            .Format = "K"
            .MaxLength = 3
            .FontName = "Tahoma"
            .FontSize = 9
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DMoes", "TextBox")
        WITH par_oPag.txt_4c_DMoes
            .Top = 232
            .Left = 225
            .Width = 154
            .Height = 23
            .Value = ""
            .Format = "K"
            .MaxLength = 15
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Saldo Inicial + Moeda do Saldo
        par_oPag.AddObject("lbl_4c_Say11", "Label")
        WITH par_oPag.lbl_4c_Say11
            .Top = 236
            .Left = 436
            .Width = 65
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Saldo Inicial :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_Saldo", "TextBox")
        WITH par_oPag.txt_4c_Saldo
            .Top = 232
            .Left = 504
            .Width = 80
            .Height = 23
            .Alignment = 1
            .Value = 0
            .Format = "K"
            .InputMask = "9999999.99"
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Themes = .F.
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_MoeSaldo", "TextBox")
        WITH par_oPag.txt_4c_MoeSaldo
            .Top = 232
            .Left = 587
            .Width = 31
            .Height = 23
            .Value = ""
            .Format = "K"
            .MaxLength = 3
            .FontName = "Tahoma"
            .FontSize = 9
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Moeda Conversao
        par_oPag.AddObject("lbl_4c_Say6", "Label")
        WITH par_oPag.lbl_4c_Say6
            .Top = 262
            .Left = 90
            .Width = 96
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Moeda Convers" + CHR(227) + "o :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_CMoesC", "TextBox")
        WITH par_oPag.txt_4c_CMoesC
            .Top = 258
            .Left = 190
            .Width = 31
            .Height = 23
            .Value = ""
            .Format = "K"
            .MaxLength = 3
            .FontName = "Tahoma"
            .FontSize = 9
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DMoesC", "TextBox")
        WITH par_oPag.txt_4c_DMoesC
            .Top = 258
            .Left = 225
            .Width = 154
            .Height = 23
            .Value = ""
            .Format = "K"
            .MaxLength = 15
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Empresa
        par_oPag.AddObject("lbl_4c_Say17", "Label")
        WITH par_oPag.lbl_4c_Say17
            .Top = 262
            .Left = 451
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Empresa :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_Empresa", "TextBox")
        WITH par_oPag.txt_4c_Empresa
            .Top = 258
            .Left = 504
            .Width = 33
            .Height = 23
            .Value = ""
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Themes = .F.
            .Visible = .T.
            .MaxLength   = 3
        ENDWITH

        *-- F.Publicidade
        par_oPag.AddObject("lbl_4c_Say18", "Label")
        WITH par_oPag.lbl_4c_Say18
            .Top = 404
            .Left = 548
            .Width = 72
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "F.Publicidade :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_CFPublis", "TextBox")
        WITH par_oPag.txt_4c_CFPublis
            .Top = 400
            .Left = 624
            .Width = 31
            .Height = 23
            .Value = ""
            .Format = "K"
            .MaxLength = 3
            .FontName = "Tahoma"
            .FontSize = 9
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DFPublis", "TextBox")
        WITH par_oPag.txt_4c_DFPublis
            .Top = 400
            .Left = 658
            .Width = 181
            .Height = 23
            .Value = ""
            .Format = "K"
            .MaxLength = 15
            .FontName = "Tahoma"
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- chkValpags "Valor em aberto" (checkbox ao lado das OptionGroups)
        par_oPag.AddObject("chk_4c_ValPends", "CheckBox")
        WITH par_oPag.chk_4c_ValPends
            .Top = 309
            .Left = 409
            .Width = 82
            .Height = 13
            .FontSize = 7
            .Alignment = 0
            .Caption = "Valor Pendente"
            .Value = 0
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        *-- Filtros nomeados (Say14 + getFiltros visivel / getNewFiltro oculto)
        par_oPag.AddObject("lbl_4c_Say14", "Label")
        WITH par_oPag.lbl_4c_Say14
            .Top = 103
            .Left = 148
            .Width = 38
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Filtros :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_Filtros", "TextBox")
        WITH par_oPag.txt_4c_Filtros
            .Top = 99
            .Left = 190
            .Width = 312
            .Height = 23
            .Value = ""
            .Format = "K!"
            .BackStyle = 1
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_NewFiltro", "TextBox")
        WITH par_oPag.txt_4c_NewFiltro
            .Top = 99
            .Left = 190
            .Width = 312
            .Height = 23
            .Value = ""
            .Format = "K!"
            .BackStyle = 1
            .FontName = "Tahoma"
            .FontSize = 8
            .SpecialEffect = 1
            .Visible = .F.
        ENDWITH

        BINDEVENT(par_oPag.txt_4c_Filtros, "LostFocus", THIS, "GetFiltrosLostFocus")

        *-- Lookups (regra #47 - LostFocus, nao KeyPress, para nao abrir o
        *-- picker a cada tecla). Implementados em AbrirLookup* mais abaixo.
        BINDEVENT(par_oPag.txt_4c_CMoes,      "LostFocus", THIS, "ValidarCMoes")
        BINDEVENT(par_oPag.txt_4c_DMoes,      "LostFocus", THIS, "ValidarDMoes")
        BINDEVENT(par_oPag.txt_4c_CMoesC,     "LostFocus", THIS, "ValidarCMoesC")
        BINDEVENT(par_oPag.txt_4c_DMoesC,     "LostFocus", THIS, "ValidarDMoesC")
        BINDEVENT(par_oPag.txt_4c_MoeSaldo,   "LostFocus", THIS, "ValidarMoeSaldo")
        BINDEVENT(par_oPag.txt_4c_CFPublis,   "LostFocus", THIS, "ValidarCFPublis")
        BINDEVENT(par_oPag.txt_4c_DFPublis,   "LostFocus", THIS, "ValidarDFPublis")
        BINDEVENT(par_oPag.txt_4c_EspecieNfs, "LostFocus", THIS, "ValidarEspecieNfsFiltro")
        BINDEVENT(par_oPag.txt_4c_TitBans,    "LostFocus", THIS, "ValidarTitBansFiltro")

        *-- Textos fixos sobre as duas grades de clientes
        par_oPag.AddObject("lbl_4c_Say15", "Label")
        WITH par_oPag.lbl_4c_Say15
            .Top = 410
            .Left = 81
            .Width = 351
            .FontBold = .T.
            .FontSize = 8
            .Caption = "Filtrar lan" + CHR(231) + "amento que contenham uma das condi" + CHR(231) + CHR(245) + "es abaixo:"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("lbl_4c_Say16", "Label")
        WITH par_oPag.lbl_4c_Say16
            .Top = 559
            .Left = 81
            .Width = 574
            .FontBold = .T.
            .FontSize = 8
            .ForeColor = RGB(255, 255, 255)
            .Caption = "Filtrar lan" + CHR(231) + "amento que contenham uma das condi" + CHR(231) + CHR(245) + "es da grade acima e da grade abaixo contenham :"
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOptionGroupsFiltros - optPagos/optOpcao/optCotEm/optCancs/
    * optConcs/optProrrogs/optFilGrd2. Legendas/ordem transcritas do dump
    * (regra #45) - a ORDEM do botao e o valor gravado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOptionGroupsFiltros(par_oPag)
        LOCAL loc_cNao
        loc_cNao = "N" + CHR(227) + "o"

        *-- Pagamento
        par_oPag.AddObject("lbl_4c_Say3", "Label")
        WITH par_oPag.lbl_4c_Say3
            .Top = 308
            .Left = 123
            .Width = 63
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Pagamento :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("opt_4c_Pagos", "OptionGroup")
        WITH par_oPag.opt_4c_Pagos
            .Top = 303
            .Left = 185
            .Width = 217
            .Height = 25
            .ButtonCount = 3
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            WITH .Buttons(1)
                .Top = 5
                .Left = 5
                .Width = 43
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Geral"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Top = 5
                .Left = 85
                .Width = 34
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Sim"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Top = 5
                .Left = 175
                .Width = 37
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = loc_cNao
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- Opcao
        par_oPag.AddObject("lbl_4c_Say5", "Label")
        WITH par_oPag.lbl_4c_Say5
            .Top = 329
            .Left = 146
            .Width = 40
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Op" + CHR(231) + CHR(227) + "o :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("opt_4c_Opcao", "OptionGroup")
        WITH par_oPag.opt_4c_Opcao
            .Top = 324
            .Left = 185
            .Width = 217
            .Height = 25
            .ButtonCount = 3
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            WITH .Buttons(1)
                .Top = 5
                .Left = 5
                .Width = 43
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Geral"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Top = 5
                .Left = 85
                .Width = 34
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Sim"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Top = 5
                .Left = 175
                .Width = 37
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = loc_cNao
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- Conversao em
        par_oPag.AddObject("lbl_4c_Say7", "Label")
        WITH par_oPag.lbl_4c_Say7
            .Top = 287
            .Left = 108
            .Width = 78
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Convers" + CHR(227) + "o em :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("opt_4c_CotEm", "OptionGroup")
        WITH par_oPag.opt_4c_CotEm
            .Top = 282
            .Left = 185
            .Width = 405
            .Height = 25
            .ButtonCount = 5
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            WITH .Buttons(1)
                .Top = 5
                .Left = 5
                .Width = 56
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Emiss" + CHR(227) + "o"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Top = 5
                .Left = 85
                .Width = 73
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Vencimento"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Top = 5
                .Left = 175
                .Width = 76
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Lan" + CHR(231) + "amento"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Top = 5
                .Left = 281
                .Width = 43
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Atual"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(5)
                .Top = 5
                .Left = 350
                .Width = 50
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Acerto"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- Cancelamento
        par_oPag.AddObject("lbl_4c_Say8", "Label")
        WITH par_oPag.lbl_4c_Say8
            .Top = 349
            .Left = 109
            .Width = 77
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Cancelamento :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("opt_4c_Cancs", "OptionGroup")
        WITH par_oPag.opt_4c_Cancs
            .Top = 344
            .Left = 185
            .Width = 217
            .Height = 25
            .ButtonCount = 3
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            WITH .Buttons(1)
                .Top = 5
                .Left = 5
                .Width = 43
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Geral"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Top = 5
                .Left = 85
                .Width = 34
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Sim"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Top = 5
                .Left = 175
                .Width = 37
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = loc_cNao
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- Conciliacao
        par_oPag.AddObject("lbl_4c_Say9", "Label")
        WITH par_oPag.lbl_4c_Say9
            .Top = 369
            .Left = 124
            .Width = 62
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Concilia" + CHR(231) + CHR(227) + "o :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("opt_4c_Concs", "OptionGroup")
        WITH par_oPag.opt_4c_Concs
            .Top = 364
            .Left = 185
            .Width = 217
            .Height = 25
            .ButtonCount = 3
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            WITH .Buttons(1)
                .Top = 5
                .Left = 5
                .Width = 43
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Geral"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Top = 5
                .Left = 85
                .Width = 34
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Sim"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Top = 5
                .Left = 175
                .Width = 37
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = loc_cNao
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- Prorrogacao
        par_oPag.AddObject("lbl_4c_Say10", "Label")
        WITH par_oPag.lbl_4c_Say10
            .Top = 388
            .Left = 118
            .Width = 68
            .FontName = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption = "Prorroga" + CHR(231) + CHR(227) + "o :"
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("opt_4c_Prorrogs", "OptionGroup")
        WITH par_oPag.opt_4c_Prorrogs
            .Top = 383
            .Left = 185
            .Width = 217
            .Height = 25
            .ButtonCount = 3
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            WITH .Buttons(1)
                .Top = 5
                .Left = 5
                .Width = 43
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Geral"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Top = 5
                .Left = 85
                .Width = 34
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = "Sim"
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Top = 5
                .Left = 175
                .Width = 37
                .FontName = "Tahoma"
                .FontSize = 8
                .BackStyle = 0
                .Caption = loc_cNao
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- Filtro da grade 2 (Todas/Alguma) - sobre fundo escuro, texto branco
        par_oPag.AddObject("opt_4c_FilGrd2", "OptionGroup")
        WITH par_oPag.opt_4c_FilGrd2
            .Top = 557
            .Left = 748
            .Width = 139
            .Height = 17
            .ButtonCount = 2
            .AutoSize = .F.
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1
            WITH .Buttons(1)
                .Top = 1
                .Left = 5
                .Width = 58
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .T.
                .BackStyle = 0
                .Caption = "Todas"
                .ForeColor = RGB(255, 255, 255)
            ENDWITH
            WITH .Buttons(2)
                .Top = 1
                .Left = 68
                .Width = 68
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .T.
                .BackStyle = 0
                .Caption = "Alguma"
                .ForeColor = RGB(255, 255, 255)
            ENDWITH
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradesFiltros - grdTipo (Column1=Imps checkbox + Column2=Dopes
    * texto, bound a cursor_4c_Tipos) e as duas grades de Grupo/Conta
    * (Grd_Clientes/Grd_Clientes2, 8 colunas: Grupo/NomeGrupo/Conta/Nome +
    * CheckE/CheckP/CheckC/CheckA). ColumnOrder transcrito do dump (a ordem
    * visual NAO segue a ordem numerica das colunas).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradesFiltros(par_oPag)
        LOCAL loc_cTipos, loc_cClientes, loc_cClientes2
        loc_cTipos     = THIS.this_oBusinessObject.this_cCursorTipos
        loc_cClientes  = THIS.this_oBusinessObject.this_cCursorClientes
        loc_cClientes2 = THIS.this_oBusinessObject.this_cCursorClientes2

        *-- grdTipo
        par_oPag.AddObject("grd_4c_Tipos", "Grid")
        WITH par_oPag.grd_4c_Tipos
            .Top = 100
            .Left = 624
            .Width = 259
            .Height = 275
            .FontName = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing = .F.
            .DeleteMark = .F.
            .RecordMark = .F.
            .HeaderHeight = 17
            .RowHeight = 17
            .ScrollBars = 2
            .GridLineColor = RGB(238, 238, 238)
        ENDWITH

        *-- GRID-WITH: ColumnCount/RecordSource FORA do WITH que acessa
        *-- .Column1/.Column2 - evita 'Unknown member COLUMN1'.
        par_oPag.grd_4c_Tipos.ColumnCount  = 2
        par_oPag.grd_4c_Tipos.RecordSource = loc_cTipos

        WITH par_oPag.grd_4c_Tipos
            .Column1.ControlSource = loc_cTipos + ".Imps"
            .Column1.Width = 17
            .Column1.Alignment = 0
            .Column1.Sparse = .F.
            .Column1.Header1.Caption = ""
            .Column1.AddObject("Check1", "CheckBox")
            .Column1.Check1.Top = 23
            .Column1.Check1.Left = 35
            .Column1.Check1.Width = 60
            .Column1.Check1.Height = 17
            .Column1.Check1.Caption = ""
            .Column1.CurrentControl = "Check1"

            .Column2.ControlSource = loc_cTipos + ".Dopes"
            .Column2.Width = 220
            .Column2.Movable = .F.
            .Column2.Resizable = .F.
            .Column2.ReadOnly = .T.
            .Column2.Text1.ReadOnly = .T.
            .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o de T" + CHR(237) + "tulos"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(90, 90, 90)

            .Visible = .T.
        ENDWITH

        BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "KeyPress", THIS, "ChkTipoKeyPress")
        BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseUp", THIS, "ChkTipoMouseUp")
        BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "MouseDown", THIS, "ChkTipoMouseDown")
        BINDEVENT(par_oPag.grd_4c_Tipos.Column1.Check1, "Click", THIS, "ChkTipoClick")

        *-- Grd_Clientes / Grd_Clientes2 (mesma estrutura)
        THIS.ConfigurarGradeClientes(par_oPag, "grd_4c_Clientes", loc_cClientes, 426, 130)
        THIS.ConfigurarGradeClientes(par_oPag, "grd_4c_Clientes2", loc_cClientes2, 575, 112)

        BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "KeyPress",   THIS, "ChkCliEKeyPress")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "MouseUp",    THIS, "ChkCliEMouseUp")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "MouseDown",  THIS, "ChkCliEMouseDown")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column5.Check1,  "Click",      THIS, "ChkCliEClick")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "KeyPress",   THIS, "ChkCliPKeyPress")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "MouseUp",    THIS, "ChkCliPMouseUp")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "MouseDown",  THIS, "ChkCliPMouseDown")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column6.Check1,  "Click",      THIS, "ChkCliPClick")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "KeyPress",   THIS, "ChkCliCKeyPress")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "MouseUp",    THIS, "ChkCliCMouseUp")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "MouseDown",  THIS, "ChkCliCMouseDown")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column7.Check1,  "Click",      THIS, "ChkCliCClick")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "KeyPress",   THIS, "ChkCliAKeyPress")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "MouseUp",    THIS, "ChkCliAMouseUp")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "MouseDown",  THIS, "ChkCliAMouseDown")
        BINDEVENT(par_oPag.grd_4c_Clientes.Column8.Check1,  "Click",      THIS, "ChkCliAClick")

        BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "KeyPress",   THIS, "ChkCli2EKeyPress")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "MouseUp",    THIS, "ChkCli2EMouseUp")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "MouseDown",  THIS, "ChkCli2EMouseDown")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column5.Check1, "Click",      THIS, "ChkCli2EClick")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "KeyPress",   THIS, "ChkCli2PKeyPress")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "MouseUp",    THIS, "ChkCli2PMouseUp")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "MouseDown",  THIS, "ChkCli2PMouseDown")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column6.Check1, "Click",      THIS, "ChkCli2PClick")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "KeyPress",   THIS, "ChkCli2CKeyPress")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "MouseUp",    THIS, "ChkCli2CMouseUp")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "MouseDown",  THIS, "ChkCli2CMouseDown")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column7.Check1, "Click",      THIS, "ChkCli2CClick")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "KeyPress",   THIS, "ChkCli2AKeyPress")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "MouseUp",    THIS, "ChkCli2AMouseUp")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "MouseDown",  THIS, "ChkCli2AMouseDown")
        BINDEVENT(par_oPag.grd_4c_Clientes2.Column8.Check1, "Click",      THIS, "ChkCli2AClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeClientes - helper compartilhado por Grd_Clientes e
    * Grd_Clientes2 (mesma estrutura de 8 colunas no legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeClientes(par_oPag, par_cNomeGrid, par_cCursor, par_nTop, par_nHeight)
        LOCAL loc_oGrid

        par_oPag.AddObject(par_cNomeGrid, "Grid")
        loc_oGrid = EVALUATE("par_oPag." + par_cNomeGrid)

        WITH loc_oGrid
            .Top = par_nTop
            .Left = 81
            .Width = 802
            .Height = par_nHeight
            .FontName = "Tahoma"
            .AllowHeaderSizing = .F.
            .AllowRowSizing = .F.
            .DeleteMark = .F.
            .RecordMark = .F.
            .ScrollBars = 2
            .GridLineColor = RGB(238, 238, 238)
        ENDWITH

        *-- GRID-WITH: ColumnCount/RecordSource FORA do WITH que acessa
        *-- .Column1..8 - evita 'Unknown member COLUMN1'.
        loc_oGrid.ColumnCount  = 8
        loc_oGrid.RecordSource = par_cCursor

        WITH loc_oGrid
            .Column1.ControlSource = par_cCursor + ".Grupo"
            .Column1.Width = 90
            .Column1.Movable = .F.
            .Column1.Resizable = .F.
            .Column1.Text1.MaxLength = 10
            .Column1.Header1.Caption = "Grupo"
            .Column1.Header1.Alignment = 2
            .Column1.Header1.ForeColor = RGB(90, 90, 90)

            .Column4.ColumnOrder = 2
            .Column4.ControlSource = par_cCursor + ".NomeGrupo"
            .Column4.Width = 166
            .Column4.Text1.MaxLength = 20
            .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column4.Header1.Alignment = 2
            .Column4.Header1.ForeColor = RGB(90, 90, 90)

            .Column2.ColumnOrder = 3
            .Column2.ControlSource = par_cCursor + ".Conta"
            .Column2.Width = 90
            .Column2.Movable = .F.
            .Column2.Resizable = .F.
            .Column2.Text1.MaxLength = 10
            .Column2.Header1.Caption = "Conta"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.ForeColor = RGB(90, 90, 90)

            .Column3.ColumnOrder = 4
            .Column3.ControlSource = par_cCursor + ".Nome"
            .Column3.Width = 360
            .Column3.Movable = .F.
            .Column3.Resizable = .F.
            .Column3.Text1.MaxLength = 50
            .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.ForeColor = RGB(90, 90, 90)

            .Column5.ControlSource = par_cCursor + ".CheckE"
            .Column5.Width = 17
            .Column5.Sparse = .F.
            .Column5.ToolTipText = "Emitente"
            .Column5.Header1.Caption = "E"
            .Column5.Header1.Alignment = 2
            .Column5.Header1.ForeColor = RGB(90, 90, 90)
            .Column5.Header1.ToolTipText = "Emitente"
            .Column5.AddObject("Check1", "CheckBox")
            .Column5.Check1.Top = 31
            .Column5.Check1.Left = 9
            .Column5.Check1.Width = 60
            .Column5.Check1.Height = 17
            .Column5.Check1.Caption = ""
            .Column5.Check1.ToolTipText = "Emitente"
            .Column5.CurrentControl = "Check1"

            .Column6.ControlSource = par_cCursor + ".CheckP"
            .Column6.Width = 17
            .Column6.Sparse = .F.
            .Column6.ToolTipText = "Portador"
            .Column6.Header1.Caption = "P"
            .Column6.Header1.Alignment = 2
            .Column6.Header1.ForeColor = RGB(90, 90, 90)
            .Column6.Header1.ToolTipText = "Portador"
            .Column6.AddObject("Check1", "CheckBox")
            .Column6.Check1.Top = 31
            .Column6.Check1.Left = 9
            .Column6.Check1.Width = 60
            .Column6.Check1.Height = 17
            .Column6.Check1.Caption = ""
            .Column6.Check1.ToolTipText = "Portador"
            .Column6.CurrentControl = "Check1"

            .Column7.ControlSource = par_cCursor + ".CheckC"
            .Column7.Width = 17
            .Column7.Sparse = .F.
            .Column7.ToolTipText = "Centro de Custo"
            .Column7.Header1.Caption = "C"
            .Column7.Header1.Alignment = 2
            .Column7.Header1.ForeColor = RGB(90, 90, 90)
            .Column7.Header1.ToolTipText = "Centro de Custo"
            .Column7.AddObject("Check1", "CheckBox")
            .Column7.Check1.Top = 30
            .Column7.Check1.Left = 9
            .Column7.Check1.Width = 60
            .Column7.Check1.Height = 17
            .Column7.Check1.Caption = ""
            .Column7.Check1.ToolTipText = "Centro de Custo"
            .Column7.CurrentControl = "Check1"

            .Column8.ControlSource = par_cCursor + ".CheckA"
            .Column8.Width = 17
            .Column8.Sparse = .F.
            .Column8.ToolTipText = "Agente Cobrador"
            .Column8.Header1.Caption = "A"
            .Column8.Header1.Alignment = 2
            .Column8.Header1.ForeColor = RGB(90, 90, 90)
            .Column8.Header1.ToolTipText = "Agente Cobrador"
            .Column8.AddObject("Check1", "CheckBox")
            .Column8.Check1.Top = 33
            .Column8.Check1.Left = 11
            .Column8.Check1.Width = 60
            .Column8.Check1.Height = 17
            .Column8.Check1.Caption = ""
            .Column8.Check1.ToolTipText = "Agente Cobrador"
            .Column8.CurrentControl = "Check1"

            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesFiltros - botoes auxiliares das grades (Inserir/Excluir/
    * SelTudo/Apaga/ApagaG1/G2) e do filtro nomeado (AddFiltro/DelFiltro/
    * RecFiltro/Carregar). Icones e ToolTip transcritos do dump do SCX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesFiltros(par_oPag)
        *-- grdTipo: Apaga (desmarca tudo) / SelTudo (marca tudo)
        par_oPag.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH par_oPag.cmd_4c_SelTudo
            .Top = 295
            .Left = 892
            .Width = 40
            .Height = 40
            .FontName = "Verdana"
            .FontSize = 8
            .WordWrap = .T.
            .Caption = ""
            .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
            .ToolTipText = "Seleciona Tudo"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes = .T.
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH par_oPag.cmd_4c_Apaga
            .Top = 335
            .Left = 892
            .Width = 40
            .Height = 40
            .FontName = "Verdana"
            .FontSize = 8
            .WordWrap = .T.
            .Caption = ""
            .Picture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .ToolTipText = "Apaga Tudo"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes = .T.
            .Visible = .T.
        ENDWITH

        *-- Grd_Clientes: Inserir/Excluir/ApagaG1
        par_oPag.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH par_oPag.cmd_4c_Inserir
            .Top = 436
            .Left = 892
            .Width = 40
            .Height = 40
            .FontName = "Verdana"
            .FontSize = 8
            .WordWrap = .T.
            .Caption = ""
            .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .ToolTipText = "Insere Linha Em Branco na Grade"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes = .T.
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH par_oPag.cmd_4c_Excluir
            .Top = 476
            .Left = 892
            .Width = 40
            .Height = 40
            .FontName = "Verdana"
            .FontSize = 8
            .WordWrap = .T.
            .Caption = ""
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Apaga Linha da Grade"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes = .T.
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_ApagaG1", "CommandButton")
        WITH par_oPag.cmd_4c_ApagaG1
            .Top = 516
            .Left = 892
            .Width = 40
            .Height = 40
            .FontName = "Verdana"
            .FontSize = 8
            .WordWrap = .T.
            .Caption = ""
            .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
            .ToolTipText = "Apaga TODAS as Linhas da Grade"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes = .T.
            .Visible = .T.
        ENDWITH

        *-- Grd_Clientes2: Inserir/Excluir/ApagaG2
        par_oPag.AddObject("cmd_4c_Inserir2", "CommandButton")
        WITH par_oPag.cmd_4c_Inserir2
            .Top = 568
            .Left = 892
            .Width = 40
            .Height = 40
            .FontName = "Verdana"
            .FontSize = 8
            .WordWrap = .T.
            .Caption = ""
            .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .ToolTipText = "Insere Linha Em Branco na Grade"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes = .T.
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_Excluir2", "CommandButton")
        WITH par_oPag.cmd_4c_Excluir2
            .Top = 608
            .Left = 892
            .Width = 40
            .Height = 40
            .FontName = "Verdana"
            .FontSize = 8
            .WordWrap = .T.
            .Caption = ""
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Apaga Linha da Grade"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes = .T.
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_ApagaG2", "CommandButton")
        WITH par_oPag.cmd_4c_ApagaG2
            .Top = 648
            .Left = 892
            .Width = 40
            .Height = 40
            .FontName = "Verdana"
            .FontSize = 8
            .WordWrap = .T.
            .Caption = ""
            .Picture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_sel_pasta_26.jpg"
            .ToolTipText = "Apaga TODAS as Linhas da Grade"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes = .T.
            .Visible = .T.
        ENDWITH

        *-- Filtro nomeado: AddFiltro/DelFiltro/RecFiltro
        par_oPag.AddObject("cmd_4c_AddFiltro", "CommandButton")
        WITH par_oPag.cmd_4c_AddFiltro
            .Top = 95
            .Left = 505
            .Width = 32
            .Height = 32
            .FontName = "Verdana"
            .FontSize = 8
            .WordWrap = .T.
            .Caption = ""
            .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .ToolTipText = "Adicionar Filtro"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes = .T.
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_DelFiltro", "CommandButton")
        WITH par_oPag.cmd_4c_DelFiltro
            .Top = 95
            .Left = 537
            .Width = 32
            .Height = 32
            .FontName = "Verdana"
            .FontSize = 8
            .WordWrap = .T.
            .Caption = ""
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Apagar Filtro"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes = .T.
            .Visible = .T.
        ENDWITH

        par_oPag.AddObject("cmd_4c_RecFiltro", "CommandButton")
        WITH par_oPag.cmd_4c_RecFiltro
            .Top = 95
            .Left = 569
            .Width = 32
            .Height = 32
            .FontName = "Verdana"
            .FontSize = 8
            .WordWrap = .T.
            .Caption = ""
            .Picture = gc_4c_CaminhoIcones + "geral_disco2_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_26.jpg"
            .ToolTipText = "Gravar Filtro"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes = .T.
            .Visible = .T.
        ENDWITH

        *-- F.Publicidade: Carregar clientes para a grade 1
        par_oPag.AddObject("cmd_4c_Carregar", "CommandButton")
        WITH par_oPag.cmd_4c_Carregar
            .Top = 384
            .Left = 843
            .Width = 40
            .Height = 40
            .FontName = "Verdana"
            .FontSize = 8
            .WordWrap = .T.
            .Caption = ""
            .Picture = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_seta_baixo_20.jpg"
            .ToolTipText = "Insere Linha Em Branco na Grade"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes = .T.
            .Visible = .T.
        ENDWITH

        BINDEVENT(par_oPag.cmd_4c_SelTudo,   "Click", THIS, "SelTudoClick")
        BINDEVENT(par_oPag.cmd_4c_Apaga,     "Click", THIS, "ApagaClick")
        BINDEVENT(par_oPag.cmd_4c_Inserir,   "Click", THIS, "BtnInserirClick")
        BINDEVENT(par_oPag.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
        BINDEVENT(par_oPag.cmd_4c_ApagaG1,   "Click", THIS, "BtnApagaG1Click")
        BINDEVENT(par_oPag.cmd_4c_Inserir2,  "Click", THIS, "BtnInserir2Click")
        BINDEVENT(par_oPag.cmd_4c_Excluir2,  "Click", THIS, "BtnExcluir2Click")
        BINDEVENT(par_oPag.cmd_4c_ApagaG2,   "Click", THIS, "BtnApagaG2Click")
        BINDEVENT(par_oPag.cmd_4c_AddFiltro, "Click", THIS, "CmdAddFiltroClick")
        BINDEVENT(par_oPag.cmd_4c_DelFiltro, "Click", THIS, "CmdDelFiltroClick")
        BINDEVENT(par_oPag.cmd_4c_RecFiltro, "Click", THIS, "BtnRecFiltroClick")
        BINDEVENT(par_oPag.cmd_4c_Carregar,  "Click", THIS, "BtnCarregarClick")
    ENDPROC

    *==========================================================================
    * FASE 6 - Lookups de Page1 (Moeda Filtro/Conversao/Saldo, Forma de
    * Publicidade, Especie da NF, Titulo Banco). Transcritos dos PROCEDURE
    * Valid originais (fwbuscaext/fwBuscaSel) - ligados em "LostFocus" (regra
    * #47 do CLAUDE.md), nunca em "KeyPress" sem testar a tecla, para nao
    * abrir o picker a cada caractere digitado. Guarda de reentrancia
    * (this_lEmLookup) porque o picker eh MODAL e redispara o proprio
    * LostFocus ao tirar o foco do campo (regra #37).
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCMoes/ValidarDMoes - Moeda Filtro (SigCdMoe.CMoes/DMoes)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCMoes()
        LOCAL loc_oPag, loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_CMoes.Value)
        IF loc_cValor == THIS.this_cUltimoValidarCMoesValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarCMoesValidado = loc_cValor
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DMoes.Value = ""
            RETURN
        ENDIF
        THIS.AbrirLookupMoeda("CMoes", loc_cValor, loc_oPag.txt_4c_CMoes, loc_oPag.txt_4c_DMoes)
    ENDPROC

    PROCEDURE ValidarDMoes()
        LOCAL loc_oPag, loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_DMoes.Value)
        IF loc_cValor == THIS.this_cUltimoValidarDMoesValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarDMoesValidado = loc_cValor
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_CMoes.Value = ""
            RETURN
        ENDIF
        THIS.AbrirLookupMoeda("DMoes", loc_cValor, loc_oPag.txt_4c_CMoes, loc_oPag.txt_4c_DMoes)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCMoesC/ValidarDMoesC - Moeda Conversao (SigCdMoe.CMoes/DMoes)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCMoesC()
        LOCAL loc_oPag, loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_CMoesC.Value)
        IF loc_cValor == THIS.this_cUltimoValidarCMoesCValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarCMoesCValidado = loc_cValor
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DMoesC.Value = ""
            RETURN
        ENDIF
        THIS.AbrirLookupMoeda("CMoes", loc_cValor, loc_oPag.txt_4c_CMoesC, loc_oPag.txt_4c_DMoesC)
    ENDPROC

    PROCEDURE ValidarDMoesC()
        LOCAL loc_oPag, loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_DMoesC.Value)
        IF loc_cValor == THIS.this_cUltimoValidarDMoesCValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarDMoesCValidado = loc_cValor
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_CMoesC.Value = ""
            RETURN
        ENDIF
        THIS.AbrirLookupMoeda("DMoes", loc_cValor, loc_oPag.txt_4c_CMoesC, loc_oPag.txt_4c_DMoesC)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeda - Funil compartilhado pelas 2 moedas (Filtro/
    * Conversao). par_cCampoBusca indica qual coluna buscar (CMoes se o
    * usuario editou o codigo, DMoes se editou a descricao) - igual ao par
    * de PROCEDURE Valid simetricos do legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupMoeda(par_cCampoBusca, par_cValor, par_oTxtCod, par_oTxtDesc)
        LOCAL loc_oBusca, loc_oErro

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeda", par_cCampoBusca, par_cValor, ;
                "Moedas")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaMoeda")
                        par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
                        par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                            par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
                            par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar moeda: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoeSaldo/AbrirLookupMoedaSaldo - Moeda do Saldo Inicial (so o
    * codigo, sem campo de descricao ao lado - igual ao legado).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMoeSaldo()
        LOCAL loc_oPag, loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_MoeSaldo.Value)
        IF loc_cValor == THIS.this_cUltimoValidarMoeSaldoValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarMoeSaldoValidado = loc_cValor
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        THIS.AbrirLookupMoedaSaldo(loc_cValor)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupMoedaSaldo(par_cValor)
        LOCAL loc_oBusca, loc_oErro

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeSaldo", "CMoes", par_cValor, ;
                "Moedas")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaMoeSaldo")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_MoeSaldo.Value = ALLTRIM(cursor_4c_BuscaMoeSaldo.CMoes)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeSaldo")
                            THIS.pgf_4c_Paginas.Page1.txt_4c_MoeSaldo.Value = ALLTRIM(cursor_4c_BuscaMoeSaldo.CMoes)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar moeda: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        IF USED("cursor_4c_BuscaMoeSaldo")
            USE IN cursor_4c_BuscaMoeSaldo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCFPublis/ValidarDFPublis - Forma de Publicidade (SigCdFpb.Cods/
    * Descs)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCFPublis()
        LOCAL loc_oPag, loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_CFPublis.Value)
        IF loc_cValor == THIS.this_cUltimoValidarCFPublisValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarCFPublisValidado = loc_cValor
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DFPublis.Value = ""
            RETURN
        ENDIF
        THIS.AbrirLookupPublicidade("Cods", loc_cValor)
    ENDPROC

    PROCEDURE ValidarDFPublis()
        LOCAL loc_oPag, loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_DFPublis.Value)
        IF loc_cValor == THIS.this_cUltimoValidarDFPublisValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarDFPublisValidado = loc_cValor
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_CFPublis.Value = ""
            RETURN
        ENDIF
        THIS.AbrirLookupPublicidade("Descs", loc_cValor)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupPublicidade(par_cCampoBusca, par_cValor)
        LOCAL loc_oBusca, loc_oPag, loc_oErro
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdFpb", "cursor_4c_BuscaPublis", par_cCampoBusca, par_cValor, ;
                "Forma de Publicidade")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaPublis")
                        loc_oPag.txt_4c_CFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Cods)
                        loc_oPag.txt_4c_DFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Descs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPublis")
                            loc_oPag.txt_4c_CFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Cods)
                            loc_oPag.txt_4c_DFPublis.Value = ALLTRIM(cursor_4c_BuscaPublis.Descs)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar forma de publicidade: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        IF USED("cursor_4c_BuscaPublis")
            USE IN cursor_4c_BuscaPublis
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEspecieNfsFiltro/AbrirLookupEspecieFiltro - Especie da Nota
    * Fiscal (SigCdEsp.Especies), campo unico (sem descricao ao lado).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEspecieNfsFiltro()
        LOCAL loc_oPag, loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_EspecieNfs.Value)
        IF loc_cValor == THIS.this_cUltimoValidarEspecieNfsFiltroValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarEspecieNfsFiltroValidado = loc_cValor
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        THIS.AbrirLookupEspecieFiltro(loc_cValor)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupEspecieFiltro(par_cValor)
        LOCAL loc_oBusca, loc_oErro

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEsp", "cursor_4c_BuscaEspecie", "Especies", par_cValor, ;
                "Esp" + CHR(233) + "cie da Nota Fiscal")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaEspecie")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_EspecieNfs.Value = ALLTRIM(cursor_4c_BuscaEspecie.Especies)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Especies", "", "Esp" + CHR(233) + "cie")
                        loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEspecie")
                            THIS.pgf_4c_Paginas.Page1.txt_4c_EspecieNfs.Value = ALLTRIM(cursor_4c_BuscaEspecie.Especies)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar esp" + CHR(233) + "cie da nota fiscal: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        IF USED("cursor_4c_BuscaEspecie")
            USE IN cursor_4c_BuscaEspecie
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTitBansFiltro/AbrirLookupTitBans - Titulo Banco. Legado busca em
    * GradeOpOpe (cursor local carregado de SigOpFp no Init, Where Situas In
    * ('P','R','A') And Infos='K') via fwBuscaSel; aqui a mesma fonte e
    * filtro vao direto no FormBuscaAuxiliar (SQLEXEC sobre a tabela, regra
    * #36 - 1o argumento eh SEMPRE o handle de conexao).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTitBansFiltro()
        LOCAL loc_oPag, loc_cValor
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_TitBans.Value)
        IF loc_cValor == THIS.this_cUltimoValidarTitBansFiltroValidado
            RETURN
        ENDIF
        THIS.this_cUltimoValidarTitBansFiltroValidado = loc_cValor
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        THIS.AbrirLookupTitBans(loc_cValor)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupTitBans(par_cValor)
        LOCAL loc_oBusca, loc_oErro

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpFp", "cursor_4c_BuscaTitBan", "Fpags", par_cValor, ;
                "T" + CHR(237) + "tulo Banco", .F., .T., ;
                "Situas IN ('P','R','A') AND Infos = " + EscaparSQL("K"))

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaTitBan")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTitBan")
                            THIS.pgf_4c_Paginas.Page1.txt_4c_TitBans.Value = ALLTRIM(cursor_4c_BuscaTitBan.Fpags)
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar t" + CHR(237) + "tulo banco: " + loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        IF USED("cursor_4c_BuscaTitBan")
            USE IN cursor_4c_BuscaTitBan
        ENDIF
    ENDPROC

    *==========================================================================
    * FASE 5 - Page2 (pgDados): fileira de botoes de acao (Movimento/
    * Recebimento/FollowUp/Impressao/Planilha) + CommandGroup cmgRetornar +
    * PRIMEIRA METADE dos campos de detalhe do registro selecionado na grade
    * (Ordem/Nota Fiscal/Especie/Empresa/Emitente/Portador). A segunda metade
    * dos campos (Centro de Custo/Agente Cobrador/Titulo Banco/Historico/
    * Saldo Inicial/grupos/checkbox Totais/memo de filtros) e o grid
    * grdDados1 ficam para a fase seguinte. Nomes e geometria transcritos de
    * tasks\task691\SIGOPCGF_form_codigo_fonte.txt (SECAO 2).
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Monta o conteudo da Page2 (resultado da
    * consulta). Chamada a partir de InicializarForm(), apos a Page1.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page2

        THIS.ConfigurarBotoesAcaoDados(loc_oPag)
        THIS.ConfigurarCamposDados1(loc_oPag)
        THIS.ConfigurarCamposDados2(loc_oPag)
        THIS.ConfigurarGradeDados(loc_oPag)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcaoDados - Shape1 (moldura ao redor da fileira de
    * botoes), CommandGroup cmgRetornar (volta para a Page1) e os 6 botoes de
    * acao (Recebimento/Movimento/FollowUp Conta/FollowUp Lancamento/
    * Impressao/Planilha). SCX: Shape1 Top=83,Left=6,W=462,H=88; botoes
    * Top=88, H=75 W=75, FontName="Comic Sans MS".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcaoDados(par_oPag)
        par_oPag.AddObject("shp_4c_Shape1", "Shape")
        WITH par_oPag.shp_4c_Shape1
            .Top         = 83
            .Left        = 6
            .Width       = 462
            .Height      = 88
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- cmgRetornar - CommandGroup com 1 botao, volta para a Page1 (Filtros)
        par_oPag.AddObject("obj_4c_CmgRetornar", "CommandGroup")
        WITH par_oPag.obj_4c_CmgRetornar
            .Top         = -2
            .Left        = 918
            .Width       = 85
            .Height      = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top         = 5
                .Left        = 5
                .Width       = 75
                .Height      = 75
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .Caption     = "Retornar"
                .ToolTipText = "Retornar aos Filtros"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
                .Cancel      = .T.
                .Picture     = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
            ENDWITH
        ENDWITH
        BINDEVENT(par_oPag.obj_4c_CmgRetornar, "Click", THIS, "CmgRetornarClick")

        *-- Recebimento
        par_oPag.AddObject("cmd_4c_BtnRecebe", "CommandButton")
        WITH par_oPag.cmd_4c_BtnRecebe
            .Top             = 88
            .Left            = 12
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Caption         = "\<Recebimento"
            .ToolTipText     = "Recebimentos"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPag.cmd_4c_BtnRecebe, "Click", THIS, "BtnRecebeClick")

        *-- Movimento
        par_oPag.AddObject("cmd_4c_BtnMovimento", "CommandButton")
        WITH par_oPag.cmd_4c_BtnMovimento
            .Top             = 88
            .Left            = 87
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Caption         = "\<Movimento"
            .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pendencia_60.jpg"
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPag.cmd_4c_BtnMovimento, "Click", THIS, "BtnMovimentoClick")

        *-- Follow-up da Conta
        par_oPag.AddObject("cmd_4c_BtnFollowUpC", "CommandButton")
        WITH par_oPag.cmd_4c_BtnFollowUpC
            .Top             = 88
            .Left            = 162
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Caption         = "Follo\<w-up Conta"
            .ToolTipText     = "Follow-up da Conta "
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPag.cmd_4c_BtnFollowUpC, "Click", THIS, "BtnFollowUpCClick")

        *-- Follow-up do Lancamento (Titulo)
        par_oPag.AddObject("cmd_4c_BtnFollowUpL", "CommandButton")
        WITH par_oPag.cmd_4c_BtnFollowUpL
            .Top             = 88
            .Left            = 237
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Caption         = "Follow-\<up Lan" + CHR(231) + "amento"
            .ToolTipText     = "Follow-up do T" + CHR(237) + "tulo"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPag.cmd_4c_BtnFollowUpL, "Click", THIS, "BtnFollowUpLClick")

        *-- Impressao
        par_oPag.AddObject("cmd_4c_BtnImprimir", "CommandButton")
        WITH par_oPag.cmd_4c_BtnImprimir
            .Top             = 88
            .Left            = 312
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Caption         = "Im\<press" + CHR(227) + "o"
            .ToolTipText     = "Impress" + CHR(227) + "o"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPag.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")

        *-- Planilha (Excel)
        par_oPag.AddObject("cmd_4c_BtnPlanilha", "CommandButton")
        WITH par_oPag.cmd_4c_BtnPlanilha
            .Top             = 88
            .Left            = 387
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Caption         = "Pla\<nilha"
            .ToolTipText     = "Impress" + CHR(227) + "o"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPag.cmd_4c_BtnPlanilha, "Click", THIS, "BtnPlanilhaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposDados1 - PRIMEIRA METADE dos campos de detalhe:
    * combo de ordem da grade, Nota Fiscal, Especie, Empresa, Emitente e
    * Portador (cada um com codigo + descricao). SCX: faixa Top=152..594,
    * Left=17..992 (abaixo do grdDados1, que fica para a fase seguinte).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposDados1(par_oPag)
        *-- Ordem da Grade (Moeda + ...)
        par_oPag.AddObject("lbl_4c_Ordem", "Label")
        WITH par_oPag.lbl_4c_Ordem
            .Top       = 152
            .Left      = 511
            .Width     = 153
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "\<Ordem da Grade (Moeda + ...) "
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("cbo_4c_Ordem", "ComboBox")
        WITH par_oPag.cbo_4c_Ordem
            .Top               = 170
            .Left              = 510
            .Width             = 182
            .Height            = 23
            .Style             = 2
            .RowSourceType     = 1
            .RowSource         = "Emiss" + CHR(227) + "o,Vencimento,Lan" + CHR(231) + "amento,Baixa,Titulo,Historico,Emitente,Portador"
            .Value             = 1
            .FontName          = "Courier New"
            .SpecialEffect     = 1
            .BorderColor       = RGB(36, 84, 155)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(36, 84, 155)
            .ToolTipText       = "Ordem dos Dados da Grade (Sempre Moeda + Ordem Selecionada)"
            .Visible           = .T.
        ENDWITH
        BINDEVENT(par_oPag.cbo_4c_Ordem, "InteractiveChange", THIS, "CboOrdemInteractiveChange")

        *-- Nota Fiscal
        par_oPag.AddObject("lbl_4c_NotaFiscal", "Label")
        WITH par_oPag.lbl_4c_NotaFiscal
            .Top       = 594
            .Left      = 23
            .FontName  = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nota Fiscal :"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_NFs", "TextBox")
        WITH par_oPag.txt_4c_NFs
            .Top           = 590
            .Left          = 89
            .Width         = 100
            .Height        = 23
            .Value         = ""
            .Format        = "K!"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            *-- legado getNFs: PROCEDURE When -> Return .f. (campo de exibicao)
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Especie (da Nota Fiscal)
        par_oPag.AddObject("lbl_4c_Especie", "Label")
        WITH par_oPag.lbl_4c_Especie
            .Top       = 594
            .Left      = 212
            .Width     = 45
            .FontName  = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Esp" + CHR(233) + "cie :"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_EspecieNfs", "TextBox")
        WITH par_oPag.txt_4c_EspecieNfs
            .Top           = 590
            .Left          = 262
            .Width         = 52
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            *-- legado getEspecieNfs (pgDados): When -> Return .f.
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Empresa
        par_oPag.AddObject("lbl_4c_Empresa", "Label")
        WITH par_oPag.lbl_4c_Empresa
            .Top       = 621
            .Left      = 207
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Empresa :"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_Emps", "TextBox")
        WITH par_oPag.txt_4c_Emps
            .Top           = 617
            .Left          = 262
            .Width         = 52
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            *-- legado getEmps: When -> Return .f.
            .ReadOnly      = .T.
            .Visible       = .T.
            .MaxLength   = 3
        ENDWITH

        *-- Emitente (codigo + razao social)
        par_oPag.AddObject("lbl_4c_Emitente", "Label")
        WITH par_oPag.lbl_4c_Emitente
            .Top       = 568
            .Left      = 403
            .FontName  = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Emitente :"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_ContEms", "TextBox")
        WITH par_oPag.txt_4c_ContEms
            .Top           = 564
            .Left          = 550
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            *-- FIEL ao legado: getContEms eh o UNICO campo de detalhe da
            *-- pgDados que NAO declara "PROCEDURE When -> Return .f." no SCX,
            *-- entao continua focavel. Nao transformar em ReadOnly.
            .Visible       = .T.
        ENDWITH

        par_oPag.AddObject("lbl_4c_BarraEmitente", "Label")
        WITH par_oPag.lbl_4c_BarraEmitente
            .Top       = 566
            .Left      = 540
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "/"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DContEms", "TextBox")
        WITH par_oPag.txt_4c_DContEms
            .Top           = 564
            .Left          = 632
            .Width         = 360
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            *-- legado getDContEms: When -> Return .f.
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Portador (codigo + razao social)
        par_oPag.AddObject("lbl_4c_Portador", "Label")
        WITH par_oPag.lbl_4c_Portador
            .Top       = 594
            .Left      = 403
            .FontName  = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Portador :"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_Contas", "TextBox")
        WITH par_oPag.txt_4c_Contas
            .Top           = 590
            .Left          = 550
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            *-- legado getContas (pgDados): When -> Return .f.
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        par_oPag.AddObject("lbl_4c_BarraPortador", "Label")
        WITH par_oPag.lbl_4c_BarraPortador
            .Top       = 592
            .Left      = 540
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "/"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DContas", "TextBox")
        WITH par_oPag.txt_4c_DContas
            .Top           = 590
            .Left          = 632
            .Width         = 360
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            *-- legado getDContas: When -> Return .f.
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposDados2 - SEGUNDA METADE dos campos de detalhe: Grupo do
    * Emitente/Portador (ao lado dos codigos ja criados em
    * ConfigurarCamposDados1), Centro de Custo, Agente Cobrador, Historico,
    * Titulo Banco, Saldo Inicial, checkbox Totais e memo de filtros
    * aplicados. Todos espelham a linha selecionada em grd_4c_Dados (grid
    * ainda nao criado - PROCEDURE When do legado retorna .F. em TODOS estes
    * campos, ou seja, nunca sao digitaveis pelo usuario) - por isso
    * ReadOnly = .T.. O grid grdDados1 e o preenchimento destes campos
    * (AfterRowColChange) ficam para a fase de eventos/acoes, junto com
    * Processamento/MontaGraded/CalcSaldo/Imprimir/Planilha (regra do SCX:
    * esses sao os metodos customizados do form, listados no ClassInfo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposDados2(par_oPag)
        *-- Grupo do Emitente (ao lado de txt_4c_ContEms, ja criado)
        par_oPag.AddObject("txt_4c_GrupEms", "TextBox")
        WITH par_oPag.txt_4c_GrupEms
            .Top           = 564
            .Left          = 459
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .Format        = "K!"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Grupo do Portador (ao lado de txt_4c_Contas, ja criado)
        par_oPag.AddObject("txt_4c_Grupo", "TextBox")
        WITH par_oPag.txt_4c_Grupo
            .Top           = 590
            .Left          = 459
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .Format        = "K!"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Centro de Custo (Grupo + codigo + "/" + descricao)
        par_oPag.AddObject("lbl_4c_CentroCusto", "Label")
        WITH par_oPag.lbl_4c_CentroCusto
            .Top       = 621
            .Left      = 366
            .FontName  = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Centro de Custo :"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_SGrupos", "TextBox")
        WITH par_oPag.txt_4c_SGrupos
            .Top           = 617
            .Left          = 459
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .Format        = "K!"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_SContas", "TextBox")
        WITH par_oPag.txt_4c_SContas
            .Top           = 617
            .Left          = 550
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        par_oPag.AddObject("lbl_4c_BarraCentroCusto", "Label")
        WITH par_oPag.lbl_4c_BarraCentroCusto
            .Top       = 619
            .Left      = 540
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "/"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DSContas", "TextBox")
        WITH par_oPag.txt_4c_DSContas
            .Top           = 617
            .Left          = 632
            .Width         = 360
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Agente Cobrador (Grupo + codigo + "/" + descricao)
        par_oPag.AddObject("lbl_4c_AgenteCobrador", "Label")
        WITH par_oPag.lbl_4c_AgenteCobrador
            .Top       = 648
            .Left      = 362
            .FontName  = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Agente Cobrador :"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_GrupAges", "TextBox")
        WITH par_oPag.txt_4c_GrupAges
            .Top           = 644
            .Left          = 459
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .Format        = "K!"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_ContAges", "TextBox")
        WITH par_oPag.txt_4c_ContAges
            .Top           = 644
            .Left          = 550
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        par_oPag.AddObject("lbl_4c_BarraAgenteCobrador", "Label")
        WITH par_oPag.lbl_4c_BarraAgenteCobrador
            .Top       = 646
            .Left      = 540
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "/"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_DContAges", "TextBox")
        WITH par_oPag.txt_4c_DContAges
            .Top           = 644
            .Left          = 632
            .Width         = 360
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Historico
        par_oPag.AddObject("lbl_4c_Historico", "Label")
        WITH par_oPag.lbl_4c_Historico
            .Top       = 568
            .Left      = 34
            .Width     = 50
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Hist" + CHR(243) + "rico :"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_Hist2s", "TextBox")
        WITH par_oPag.txt_4c_Hist2s
            .Top           = 564
            .Left          = 89
            .Width         = 290
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Titulo Banco
        par_oPag.AddObject("lbl_4c_TituloBanco", "Label")
        WITH par_oPag.lbl_4c_TituloBanco
            .Top       = 621
            .Left      = 17
            .Width     = 67
            .Height    = 15
            .FontName  = "Tahoma"
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "T" + CHR(237) + "tulo Banco :"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_TitBans", "TextBox")
        WITH par_oPag.txt_4c_TitBans
            .Top           = 617
            .Left          = 89
            .Width         = 100
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Saldo Inicial
        par_oPag.AddObject("lbl_4c_SaldoInicial", "Label")
        WITH par_oPag.lbl_4c_SaldoInicial
            .Top       = 648
            .Left      = 19
            .Width     = 65
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Saldo Inicial :"
            .Visible   = .T.
        ENDWITH

        par_oPag.AddObject("txt_4c_ValOcurs", "TextBox")
        WITH par_oPag.txt_4c_ValOcurs
            .Top           = 644
            .Left          = 89
            .Width         = 100
            .Height        = 23
            .Alignment     = 1
            .Value         = 0
            .Format        = "K"
            .InputMask     = "999999999.99"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Exibir Totalizadores (chkTotais) - liga/desliga totalizadores na
        *-- ordenacao da grade (OrdenaGrade, fase de eventos/acoes)
        par_oPag.AddObject("chk_4c_Totais", "CheckBox")
        WITH par_oPag.chk_4c_Totais
            .Top         = 174
            .Left        = 697
            .Caption     = "E\<xibir Totalizadores"
            .Value       = 1
            .FontName    = "Tahoma"
            .ForeColor   = RGB(90, 90, 90)
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(par_oPag.chk_4c_Totais, "Click", THIS, "ChkTotaisClick")

        *-- Memo com a descricao dos filtros aplicados na consulta (somente
        *-- exibicao - alterna altura 66/200 ao clicar, igual ao legado)
        par_oPag.AddObject("obj_4c_GetFiltros", "EditBox")
        WITH par_oPag.obj_4c_GetFiltros
            .Top           = 83
            .Left          = 510
            .Width         = 381
            .Height        = 66
            .Value         = ""
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 7
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(par_oPag.obj_4c_GetFiltros, "Click", THIS, "GetFiltrosDadosClick")

        *-- Botoes (indicadores de status do titulo - Cancelado/Baixado/
        *-- Conciliado/Prorrogado). TextBoxes read-only coloridos, nunca
        *-- digitaveis (PROCEDURE When do legado retorna .f. nos 4).
        par_oPag.AddObject("cnt_4c_Botoes", "Container")
        WITH par_oPag.cnt_4c_Botoes
            .Top         = 643
            .Left        =  542
            .Width       = 115
            .Height      = 24
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("txt_4c_Botao1", "TextBox")
            WITH .txt_4c_Botao1
                .Top         = 1
                .Left        = 1
                .Width       = 29
                .Height      = 23
                .Alignment   = 0
                .Value       = ""
                .FontBold    = .T.
                .FontSize    = 12
                .BackColor   = RGB(255, 0, 0)
                .SpecialEffect = 1
                .ToolTipText = "T" + CHR(237) + "tulo Cancelado"
                .ReadOnly    = .T.
                .TabStop     = .F.
                .Themes      = .F.
                .Visible     = .T.
            ENDWITH

            .AddObject("txt_4c_Botao2", "TextBox")
            WITH .txt_4c_Botao2
                .Top         = 1
                .Left        = 29
                .Width       = 29
                .Height      = 23
                .Alignment   = 0
                .Value       = ""
                .FontBold    = .T.
                .FontSize    = 12
                .BackColor   = RGB(0, 128, 0)
                .SpecialEffect = 1
                .ToolTipText = "T" + CHR(237) + "tulo Baixado"
                .ReadOnly    = .T.
                .TabStop     = .F.
                .Themes      = .F.
                .Visible     = .T.
            ENDWITH

            .AddObject("txt_4c_Botao3", "TextBox")
            WITH .txt_4c_Botao3
                .Top         = 1
                .Left        = 57
                .Width       = 29
                .Height      = 23
                .Alignment   = 0
                .Value       = ""
                .FontBold    = .T.
                .FontSize    = 12
                .BackColor   = RGB(0, 0, 255)
                .SpecialEffect = 1
                .ToolTipText = "T" + CHR(237) + "tulo Conciliado"
                .ReadOnly    = .T.
                .TabStop     = .F.
                .Themes      = .F.
                .Visible     = .T.
            ENDWITH

            .AddObject("txt_4c_Botao4", "TextBox")
            WITH .txt_4c_Botao4
                .Top         = 1
                .Left        = 86
                .Width       = 29
                .Height      = 23
                .Alignment   = 0
                .Value       = ""
                .FontBold    = .T.
                .FontSize    = 12
                .BackColor   = RGB(255, 128, 0)
                .SpecialEffect = 1
                .ToolTipText = "T" + CHR(237) + "tulo Prorrogado"
                .ReadOnly    = .T.
                .TabStop     = .F.
                .Themes      = .F.
                .Visible     = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * GetFiltrosDadosClick - Expande/retrai o memo de filtros aplicados
    * (igual ao Click original do getFiltros da Page2 - alterna Height).
    *--------------------------------------------------------------------------
    PROCEDURE GetFiltrosDadosClick()
        LOCAL loc_oMemo
        loc_oMemo = THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros

        IF loc_oMemo.Height = 66
            loc_oMemo.Height = 200
        ELSE
            loc_oMemo.Height = 66
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgRetornarClick / Btn*Click (Page2) - navegacao e acoes. A logica
    * completa (abrir SigCdPgr/SigCdLch, montar relatorio/planilha) e
    * implementada na fase de eventos; aqui o botao ja volta para a Page1
    * (unico comportamento que nao depende de registro selecionado na grade).
    *--------------------------------------------------------------------------
    PROCEDURE CmgRetornarClick()
        *-- cmgRetornar do legado volta para a pagina de filtros. Delega ao
        *-- funil unico de "abandonar a pagina corrente" (BtnCancelarClick).
        THIS.BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - FUNIL de navegacao entre Filtros/Dados. Alem de trocar
    * o ActivePage e o modo, repoe o estado que depende da pagina ativa:
    *
    *   - HabilitarCampos(): aplica o contrato de edicao de cada pagina
    *     (filtros editaveis na Page1; campos de exibicao da Page2 sempre
    *     somente-leitura, como os "PROCEDURE When -> Return .f." do legado).
    *   - CarregarLista(): REPINTA a grade de resultado. Processamento()
    *     popula cursor_4c_Dados com a Page2 ainda OCULTA e Refresh em pagina
    *     oculta NAO pinta (regra #21/#46 do CLAUDE.md) - por isso a
    *     repintura tem de acontecer AQUI, DEPOIS do ActivePage.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        DO CASE
        CASE par_nPagina = 1
            THIS.this_cModoAtual = "FILTROS"
            THIS.HabilitarCampos(.T.)
        CASE par_nPagina = 2
            THIS.this_cModoAtual = "DADOS"
            THIS.HabilitarCampos(.F.)
            THIS.CarregarLista()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgFiltrosClick - Buttons(1)=Consultar valida as 4 faixas de data e
    * segue para a Page2; Buttons(2)=Sair fecha o form (Cancel=.T., tambem
    * dispara por ESC).
    *--------------------------------------------------------------------------
    PROCEDURE CmgFiltrosClick()
        LOCAL loc_oGrupo, loc_nBotao

        loc_oGrupo = THIS.pgf_4c_Paginas.Page1.cmg_4c_Filtros
        loc_nBotao = loc_oGrupo.Value

        DO CASE
        CASE loc_nBotao = 1
            THIS.BtnBuscarClick()
        CASE loc_nBotao = 2
            THIS.BtnCancelarClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltrosData - Transcricao literal das 4 checagens "Inicial nao
    * pode ser maior que a Final" do Click original (Emissao/Vencimento
    * confirmados no dump; Lancamento/Acerto seguem o MESMO padrao simetrico).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltrosData()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF !EMPTY(loc_oPag.txt_4c_DtEmiI.Value) AND !EMPTY(loc_oPag.txt_4c_DtEmiF.Value) AND ;
           (loc_oPag.txt_4c_DtEmiI.Value > loc_oPag.txt_4c_DtEmiF.Value)
            MsgAviso("A Data de Emiss" + CHR(227) + "o Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oPag.txt_4c_DtEmiI.SetFocus()
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_oPag.txt_4c_VencsI.Value) AND !EMPTY(loc_oPag.txt_4c_VencsF.Value) AND ;
           (loc_oPag.txt_4c_VencsI.Value > loc_oPag.txt_4c_VencsF.Value)
            MsgAviso("A Data de Vencimento Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oPag.txt_4c_VencsI.SetFocus()
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_oPag.txt_4c_DatasI.Value) AND !EMPTY(loc_oPag.txt_4c_DatasF.Value) AND ;
           (loc_oPag.txt_4c_DatasI.Value > loc_oPag.txt_4c_DatasF.Value)
            MsgAviso("A Data de Lan" + CHR(231) + "amento Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oPag.txt_4c_DatasI.SetFocus()
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_oPag.txt_4c_DtBxI.Value) AND !EMPTY(loc_oPag.txt_4c_DtBxF.Value) AND ;
           (loc_oPag.txt_4c_DtBxI.Value > loc_oPag.txt_4c_DtBxF.Value)
            MsgAviso("A Data de Acerto Inicial N" + CHR(227) + "o Pode Ser Maior Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oPag.txt_4c_DtBxI.SetFocus()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ApagaClick/SelTudoClick - grdTipo: desmarca/marca todos os tipos de
    * operacao (equivalente ao Update crSigOpOpe Set Imps=.. do legado).
    *--------------------------------------------------------------------------
    PROCEDURE ApagaClick()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            REPLACE ALL Imps WITH 0
            GO TOP
            THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE SelTudoClick()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            REPLACE ALL Imps WITH 1 FOR !EMPTY(Dopes)
            GO TOP
            THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinhaGrade/ExcluirLinhaGrade/LimparGrade - CRUD de linha
    * compartilhado pelas duas grades de Grupo/Conta (equivalente aos
    * btnInserir*/btnExcluir*/btnApagaG* do legado sobre TmpCliente/
    * TmpCliente2).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InserirLinhaGrade(par_cCursor, par_oGrid)
        IF !USED(par_cCursor)
            RETURN
        ENDIF

        SELECT (par_cCursor)
        GO TOP
        LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
        IF EOF()
            APPEND BLANK
            GO BOTTOM
        ENDIF

        par_oGrid.Refresh()
        par_oGrid.SetFocus()
        par_oGrid.Column1.SetFocus()
    ENDPROC

    PROTECTED PROCEDURE ExcluirLinhaGrade(par_cCursor, par_oGrid)
        IF !USED(par_cCursor)
            RETURN
        ENDIF

        SELECT (par_cCursor)
        IF !EMPTY(Grupo) OR !EMPTY(Conta)
            DELETE
        ENDIF

        GO TOP
        LOCATE FOR EMPTY(Grupo) AND EMPTY(Conta)
        IF EOF()
            APPEND BLANK
            GO BOTTOM
        ENDIF

        par_oGrid.Refresh()
        par_oGrid.SetFocus()
        par_oGrid.Column1.SetFocus()
    ENDPROC

    PROTECTED PROCEDURE LimparGrade(par_cCursor, par_oGrid)
        IF !USED(par_cCursor)
            RETURN
        ENDIF

        ZAP IN (par_cCursor)
        SELECT (par_cCursor)
        APPEND BLANK
        par_oGrid.Refresh()
    ENDPROC

    PROCEDURE BtnInserirClick()
        THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.ExcluirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
    ENDPROC

    PROCEDURE BtnInserir2Click()
        THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
    ENDPROC

    PROCEDURE BtnExcluir2Click()
        THIS.ExcluirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
    ENDPROC

    PROCEDURE BtnApagaG1Click()
        IF MsgConfirma("Confirma a Limpeza de TODOS os Dados Informados na Grade?", "Exclus" + CHR(227) + "o de Linhas da Grade")
            THIS.LimparGrade(THIS.this_oBusinessObject.this_cCursorClientes, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
        ENDIF
    ENDPROC

    PROCEDURE BtnApagaG2Click()
        IF MsgConfirma("Confirma a Limpeza de TODOS os Dados Informados na Grade?", "Exclus" + CHR(227) + "o de Linhas da Grade")
            THIS.LimparGrade(THIS.this_oBusinessObject.this_cCursorClientes2, THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarFlagGrade - Alterna (0<->1) a coluna de flag de uma linha de
    * grade (equivalente ao padrao de checkbox de Column regra #46/#185 -
    * toggle feito por codigo, nunca pelo binding nativo do CheckBox).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarFlagGrade(par_cCursor, par_cCampo, par_oGrid)
        IF USED(par_cCursor)
            SELECT (par_cCursor)
            IF !EOF()
                REPLACE (par_cCampo) WITH IIF(EVALUATE(par_cCampo) = 0, 1, 0)
            ENDIF
        ENDIF
        par_oGrid.Refresh()
    ENDPROC

    *-- grdTipo.Column1.Check1 (Imps)
    PROCEDURE ChkTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorTipos, "Imps", THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos)
            NODEFAULT
        ENDIF
    ENDPROC
    PROCEDURE ChkTipoMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.ChkTipoKeyPress(13, 0)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkTipoMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkTipoClick()
        NODEFAULT
    ENDPROC

    *-- Grd_Clientes.Column5..8 (CheckE/CheckP/CheckC/CheckA)
    PROCEDURE ChkCliEKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckE", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
            NODEFAULT
        ENDIF
    ENDPROC
    PROCEDURE ChkCliEMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.ChkCliEKeyPress(13, 0)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCliEMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCliEClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCliPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckP", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
            NODEFAULT
        ENDIF
    ENDPROC
    PROCEDURE ChkCliPMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.ChkCliPKeyPress(13, 0)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCliPMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCliPClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCliCKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckC", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
            NODEFAULT
        ENDIF
    ENDPROC
    PROCEDURE ChkCliCMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.ChkCliCKeyPress(13, 0)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCliCMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCliCClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCliAKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes, "CheckA", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes)
            NODEFAULT
        ENDIF
    ENDPROC
    PROCEDURE ChkCliAMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.ChkCliAKeyPress(13, 0)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCliAMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCliAClick()
        NODEFAULT
    ENDPROC

    *-- Grd_Clientes2.Column5..8 (CheckE/CheckP/CheckC/CheckA)
    PROCEDURE ChkCli2EKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckE", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
            NODEFAULT
        ENDIF
    ENDPROC
    PROCEDURE ChkCli2EMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.ChkCli2EKeyPress(13, 0)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCli2EMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCli2EClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCli2PKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckP", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
            NODEFAULT
        ENDIF
    ENDPROC
    PROCEDURE ChkCli2PMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.ChkCli2PKeyPress(13, 0)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCli2PMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCli2PClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCli2CKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckC", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
            NODEFAULT
        ENDIF
    ENDPROC
    PROCEDURE ChkCli2CMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.ChkCli2CKeyPress(13, 0)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCli2CMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCli2CClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkCli2AKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarFlagGrade(THIS.this_oBusinessObject.this_cCursorClientes2, "CheckA", THIS.pgf_4c_Paginas.Page1.grd_4c_Clientes2)
            NODEFAULT
        ENDIF
    ENDPROC
    PROCEDURE ChkCli2AMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        THIS.ChkCli2AKeyPress(13, 0)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCli2AMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC
    PROCEDURE ChkCli2AClick()
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdAddFiltroClick - Abre o campo de digitacao do nome de um filtro novo
    * (equivalente ao legado: esconde getFiltros, mostra getNewFiltro).
    *--------------------------------------------------------------------------
    PROCEDURE CmdAddFiltroClick()
        WITH THIS.pgf_4c_Paginas.Page1
            .txt_4c_Filtros.Visible   = .F.
            .txt_4c_NewFiltro.Visible = .T.
            .txt_4c_NewFiltro.Value   = ""
            .txt_4c_NewFiltro.SetFocus()
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnRecFiltroClick/CmdDelFiltroClick - Gravar/Apagar filtro nomeado em
    * SigSyPar (cidparams = "SIGOPCGF" + nome, padrao determinado para
    * permitir localizar e regravar o mesmo filtro). Substitui o
    * ThisForm.poSigSyPar.fGravaUserCfg() do Framework legado (objeto nao
    * portado) por SQL direto; mxmls guarda os valores atuais dos campos de
    * filtro (SerializarFiltros/RestaurarFiltros), nao o XML original.
    *--------------------------------------------------------------------------
    PROCEDURE BtnRecFiltroClick()
        LOCAL loc_oPag, loc_cNome, loc_cId, loc_cValores, loc_nExiste, loc_cSQL, loc_oErro

        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_cNome = IIF(loc_oPag.txt_4c_NewFiltro.Visible, ALLTRIM(loc_oPag.txt_4c_NewFiltro.Value), ALLTRIM(loc_oPag.txt_4c_Filtros.Value))

        IF EMPTY(loc_cNome)
            MsgAviso("Informe o nome do filtro antes de grav" + CHR(225) + "-lo.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            loc_cId      = PADR("SIGOPCGF", 8) + PADR(loc_cNome, 40)
            loc_cValores = THIS.SerializarFiltros()
            loc_nExiste  = 0

            IF SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId), "cursor_4c_FiltroExiste") > 0
                loc_nExiste = cursor_4c_FiltroExiste.nExiste
                USE IN cursor_4c_FiltroExiste
            ENDIF

            IF loc_nExiste > 0
                loc_cSQL = "UPDATE SigSyPar SET mxmls = " + EscaparSQL(loc_cValores) + ;
                           " WHERE cidparams = " + EscaparSQL(loc_cId)
            ELSE
                loc_cSQL = "INSERT INTO SigSyPar (cidparams, ctpparams, descrs, mxmls) VALUES (" + ;
                           EscaparSQL(loc_cId) + ", " + EscaparSQL("F") + ", " + ;
                           EscaparSQL(LEFT(loc_cNome, 40)) + ", " + EscaparSQL(loc_cValores) + ")"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_oPag.txt_4c_NewFiltro.Visible = .F.
                loc_oPag.txt_4c_Filtros.Visible   = .T.
                loc_oPag.txt_4c_Filtros.Value     = loc_cNome
                THIS.CarregarFiltrosSalvos()
                MsgInfo("Filtro grav" + CHR(225) + "do com sucesso!", "Confirmar")
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE CmdDelFiltroClick()
        LOCAL loc_oPag, loc_cNome, loc_cId, loc_cSQL, loc_oErro

        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_cNome = ALLTRIM(loc_oPag.txt_4c_Filtros.Value)

        IF EMPTY(loc_cNome)
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do filtro [" + loc_cNome + "]?", "Excluir Filtro")
            RETURN
        ENDIF

        IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        TRY
            loc_cId  = PADR("SIGOPCGF", 8) + PADR(loc_cNome, 40)
            loc_cSQL = "DELETE FROM SigSyPar WHERE cidparams = " + EscaparSQL(loc_cId)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_oPag.txt_4c_Filtros.Value = ""
                THIS.CarregarFiltrosSalvos()
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o filtro." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GetFiltrosLostFocus - Ao sair do campo com um nome existente em
    * cursor_4c_Filtros, restaura os valores salvos nos campos de filtro
    * (equivalente ao mLerCfg() do Framework legado).
    *--------------------------------------------------------------------------
    PROCEDURE GetFiltrosLostFocus()
        LOCAL loc_oPag, loc_cNome, loc_cCursor

        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNome  = ALLTRIM(loc_oPag.txt_4c_Filtros.Value)
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorFiltros

        IF EMPTY(loc_cNome) OR !USED(loc_cCursor)
            RETURN
        ENDIF

        SELECT (loc_cCursor)
        LOCATE FOR ALLTRIM(Descrs) == loc_cNome

        IF FOUND()
            THIS.RestaurarFiltros(ALLTRIM(Mxmls))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * SerializarFiltros/RestaurarFiltros - Serializacao plana (CHR(9) como
    * separador) dos campos de filtro para gravar/recarregar um filtro
    * nomeado em SigSyPar.Mxmls.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SerializarFiltros()
        LOCAL loc_oBO

        *-- FONTE UNICA: captura a tela nas propriedades do BO e serializa a
        *-- partir DELAS, para nao haver duas leituras divergentes dos mesmos
        *-- controles. Ordem e formato das 27 posicoes inalterados.
        THIS.FormParaBO()
        loc_oBO = THIS.this_oBusinessObject

        RETURN ;
            TRANSFORM(loc_oBO.this_dDtEmiI)    + CHR(9) + ;
            TRANSFORM(loc_oBO.this_dDtEmiF)    + CHR(9) + ;
            TRANSFORM(loc_oBO.this_dVencsI)    + CHR(9) + ;
            TRANSFORM(loc_oBO.this_dVencsF)    + CHR(9) + ;
            TRANSFORM(loc_oBO.this_dDatasI)    + CHR(9) + ;
            TRANSFORM(loc_oBO.this_dDatasF)    + CHR(9) + ;
            TRANSFORM(loc_oBO.this_dDtBxI)     + CHR(9) + ;
            TRANSFORM(loc_oBO.this_dDtBxF)     + CHR(9) + ;
            ALLTRIM(loc_oBO.this_cTitulos)     + CHR(9) + ;
            ALLTRIM(loc_oBO.this_cTitBans)     + CHR(9) + ;
            ALLTRIM(loc_oBO.this_cEspecieNfs)  + CHR(9) + ;
            ALLTRIM(loc_oBO.this_cNFs)         + CHR(9) + ;
            ALLTRIM(loc_oBO.this_cCMoes)       + CHR(9) + ;
            ALLTRIM(loc_oBO.this_cCMoesC)      + CHR(9) + ;
            ALLTRIM(loc_oBO.this_cMoeSaldo)    + CHR(9) + ;
            TRANSFORM(loc_oBO.this_nSaldo)     + CHR(9) + ;
            ALLTRIM(loc_oBO.this_cCFPublis)    + CHR(9) + ;
            ALLTRIM(loc_oBO.this_cEmpresa)     + CHR(9) + ;
            TRANSFORM(IIF(loc_oBO.this_lBrancos, 1, 0))  + CHR(9) + ;
            TRANSFORM(IIF(loc_oBO.this_lValPends, 1, 0)) + CHR(9) + ;
            TRANSFORM(loc_oBO.this_nPagos)     + CHR(9) + ;
            TRANSFORM(loc_oBO.this_nOpcao)     + CHR(9) + ;
            TRANSFORM(loc_oBO.this_nCotEm)     + CHR(9) + ;
            TRANSFORM(loc_oBO.this_nCancs)     + CHR(9) + ;
            TRANSFORM(loc_oBO.this_nConcs)     + CHR(9) + ;
            TRANSFORM(loc_oBO.this_nProrrogs)  + CHR(9) + ;
            TRANSFORM(loc_oBO.this_nFilGrd2)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterTokenSerializado - Devolve a par_nPos-esima posicao de uma string
    * separada por CHR(9), PRESERVANDO posicao vazia.
    *
    * GETWORDNUM() NAO serve aqui: ela trata delimitadores adjacentes como UM
    * so e descarta a posicao vazia, deslocando todos os campos seguintes.
    * Como filtro em branco e o caso COMUM (o blob de SerializarFiltros tem
    * uma posicao vazia por filtro nao preenchido), usar GETWORDNUM faz o
    * filtro nomeado voltar com os valores nos campos ERRADOS, em silencio -
    * medido no VFP9 em 2026-10-24: com 4 posicoes vazias antes dele, o
    * "Titulo" recebia o valor do 21o campo (indice do OptionGroup Pagamento).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterTokenSerializado(par_cTexto, par_nPos)
        LOCAL loc_nIni, loc_nFim, loc_cToken
        loc_cToken = ""

        IF par_nPos <= 1
            loc_nIni = 1
        ELSE
            loc_nFim = AT(CHR(9), par_cTexto, par_nPos - 1)
            loc_nIni = IIF(loc_nFim = 0, 0, loc_nFim + 1)
        ENDIF

        IF loc_nIni > 0
            loc_nFim = AT(CHR(9), par_cTexto, par_nPos)
            IF loc_nFim = 0
                loc_cToken = SUBSTR(par_cTexto, loc_nIni)
            ELSE
                loc_cToken = SUBSTR(par_cTexto, loc_nIni, loc_nFim - loc_nIni)
            ENDIF
        ENDIF

        RETURN loc_cToken
    ENDFUNC

    PROTECTED PROCEDURE RestaurarFiltros(par_cSerializado)
        LOCAL loc_oBO, loc_nI
        LOCAL ARRAY loc_aPartes[27]

        IF EMPTY(par_cSerializado)
            RETURN
        ENDIF

        FOR loc_nI = 1 TO 27
            loc_aPartes[loc_nI] = THIS.ObterTokenSerializado(par_cSerializado, loc_nI)
        ENDFOR

        *-- Captura a tela ANTES de sobrescrever: o blob guarda SO as 27
        *-- posicoes de filtro, e o que nao esta nele (descricoes dos lookups,
        *-- nome do filtro, ordem/totalizadores da Page2) tem de voltar ao
        *-- BOParaForm com o valor que ja estava na tela, nao com um residuo.
        THIS.FormParaBO()
        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_dDtEmiI    = ConverterParaData(loc_aPartes[1])
        loc_oBO.this_dDtEmiF    = ConverterParaData(loc_aPartes[2])
        loc_oBO.this_dVencsI    = ConverterParaData(loc_aPartes[3])
        loc_oBO.this_dVencsF    = ConverterParaData(loc_aPartes[4])
        loc_oBO.this_dDatasI    = ConverterParaData(loc_aPartes[5])
        loc_oBO.this_dDatasF    = ConverterParaData(loc_aPartes[6])
        loc_oBO.this_dDtBxI     = ConverterParaData(loc_aPartes[7])
        loc_oBO.this_dDtBxF     = ConverterParaData(loc_aPartes[8])
        loc_oBO.this_cTitulos   = loc_aPartes[9]
        loc_oBO.this_cTitBans   = loc_aPartes[10]
        loc_oBO.this_cEspecieNfs = loc_aPartes[11]
        loc_oBO.this_cNFs       = loc_aPartes[12]
        loc_oBO.this_cCMoes     = loc_aPartes[13]
        loc_oBO.this_cCMoesC    = loc_aPartes[14]
        loc_oBO.this_cMoeSaldo  = loc_aPartes[15]
        loc_oBO.this_nSaldo     = VAL(loc_aPartes[16])
        loc_oBO.this_cCFPublis  = loc_aPartes[17]
        loc_oBO.this_cEmpresa   = loc_aPartes[18]
        loc_oBO.this_lBrancos   = (VAL(loc_aPartes[19]) = 1)
        loc_oBO.this_lValPends  = (VAL(loc_aPartes[20]) = 1)
        loc_oBO.this_nPagos     = IIF(BETWEEN(VAL(loc_aPartes[21]), 1, 3), VAL(loc_aPartes[21]), 1)
        loc_oBO.this_nOpcao     = IIF(BETWEEN(VAL(loc_aPartes[22]), 1, 3), VAL(loc_aPartes[22]), 1)
        loc_oBO.this_nCotEm     = IIF(BETWEEN(VAL(loc_aPartes[23]), 1, 5), VAL(loc_aPartes[23]), 1)
        loc_oBO.this_nCancs     = IIF(BETWEEN(VAL(loc_aPartes[24]), 1, 3), VAL(loc_aPartes[24]), 1)
        loc_oBO.this_nConcs     = IIF(BETWEEN(VAL(loc_aPartes[25]), 1, 3), VAL(loc_aPartes[25]), 1)
        loc_oBO.this_nProrrogs  = IIF(BETWEEN(VAL(loc_aPartes[26]), 1, 3), VAL(loc_aPartes[26]), 1)
        loc_oBO.this_nFilGrd2   = IIF(BETWEEN(VAL(loc_aPartes[27]), 1, 2), VAL(loc_aPartes[27]), 1)

        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposOperacao - Popula cursor_4c_Tipos a partir de SigOpOpe
    * (equivalente ao Select 1 as Imps, Dopes, Opers, RealPrevs From SigOpOpe
    * Order By Dopes + Insert Into ...(0, Space(20), 'C') do legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarTiposOperacao()
        LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL

        IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        loc_cCursor    = THIS.this_oBusinessObject.this_cCursorTipos
        loc_cCursorTmp = loc_cCursor + "Tmp"
        loc_cSQL       = "SELECT 1 AS Imps, Dopes, Opers, RealPrevs FROM SigOpOpe ORDER BY Dopes"

        *-- cursor_4c_Tipos esta ligado a grd_4c_Tipos.RecordSource - SQLEXEC
        *-- direto nele zeraria o ColumnCount (regra do Grid/SQLEXEC). O
        *-- SQLEXEC vai para um cursor TEMPORARIO e o placeholder (criado em
        *-- CriarCursoresFiltros, com a MESMA estrutura/indice) e recarregado
        *-- com ZAP + APPEND FROM DBF, preservando a estrutura do Grid.
        IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
            SELECT (loc_cCursor)
            ZAP
            APPEND FROM DBF(loc_cCursorTmp)
            IF USED(loc_cCursorTmp)
                USE IN (loc_cCursorTmp)
            ENDIF

            SELECT (loc_cCursor)
            APPEND BLANK
            REPLACE Imps WITH 0, Dopes WITH SPACE(20), Opers WITH "C", RealPrevs WITH 0
            GO TOP

            THIS.pgf_4c_Paginas.Page1.grd_4c_Tipos.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFiltrosSalvos - Popula cursor_4c_Filtros com os filtros
    * nomeados ja gravados em SigSyPar para este form (cidparams iniciando
    * por "SIGOPCGF").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarFiltrosSalvos()
        LOCAL loc_cCursor, loc_cCursorTmp, loc_cSQL, loc_cId

        IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        loc_cCursor    = THIS.this_oBusinessObject.this_cCursorFiltros
        loc_cCursorTmp = loc_cCursor + "Tmp"
        loc_cId        = PADR("SIGOPCGF", 8)

        loc_cSQL = "SELECT cidparams, ctpparams, descrs, mxmls FROM SigSyPar WHERE LEFT(cidparams, 8) = " + ;
                   EscaparSQL(loc_cId) + " ORDER BY descrs"

        IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
            SELECT (loc_cCursor)
            ZAP
            APPEND FROM DBF(loc_cCursorTmp)
            IF USED(loc_cCursorTmp)
                USE IN (loc_cCursorTmp)
            ENDIF
            SELECT (loc_cCursor)
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCarregarClick/CarregarFPubs - Carrega em grd_4c_Clientes os pares
    * Grupo/Conta vinculados a Forma de Publicidade digitada (equivalente ao
    * ThisForm.CarregarFPubs do legado). A checagem extra de acesso por
    * usuario/conta (fAcessoContas/fChecarInativas no legado) depende de
    * tabelas de controle de acesso do Framework (SigSyAgc/SigCdAcG/
    * SigSyAcc) fora do escopo desta tela de filtro - o filtro principal
    * (FPubls = codigo informado) e o mesmo usado pelo legado para
    * restringir o universo de clientes.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCarregarClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF EMPTY(loc_oPag.txt_4c_CFPublis.Value)
            MsgAviso("Forma de Publicidade Para Filtro N" + CHR(227) + "o foi Preenchida!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_oPag.txt_4c_CFPublis.SetFocus()
            RETURN
        ENDIF

        THIS.CarregarFPubs()
        THIS.InserirLinhaGrade(THIS.this_oBusinessObject.this_cCursorClientes, loc_oPag.grd_4c_Clientes)
    ENDPROC

    PROTECTED PROCEDURE CarregarFPubs()
        LOCAL loc_oPag, loc_cPub, loc_cCursor, loc_cCursorTmp, loc_cSQL

        IF VARTYPE(gnConnHandle) != "N" OR gnConnHandle <= 0
            RETURN
        ENDIF

        loc_oPag       = THIS.pgf_4c_Paginas.Page1
        loc_cPub       = ALLTRIM(loc_oPag.txt_4c_CFPublis.Value)
        loc_cCursor    = THIS.this_oBusinessObject.this_cCursorClientes
        loc_cCursorTmp = loc_cCursor + "Tmp"

        loc_cSQL = "SELECT a.Grupos AS Grupo, b.Descrs AS NomeGrupo, a.IClis AS Conta, " + ;
                   "a.RClis AS Nome, 0 AS CheckE, 0 AS CheckP, 0 AS CheckC, 0 AS CheckA " + ;
                   "FROM SigCdCli a, SigCdGcr b " + ;
                   "WHERE a.Grupos = b.Codigos AND a.FPubls = " + EscaparSQL(loc_cPub)

        *-- cursor_4c_Clientes esta ligado a grd_4c_Clientes.RecordSource -
        *-- ZAP + APPEND FROM DBF preserva a estrutura/binding do Grid.
        IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) > 0
            SELECT (loc_cCursor)
            ZAP
            APPEND FROM DBF(loc_cCursorTmp)
            IF USED(loc_cCursorTmp)
                USE IN (loc_cCursorTmp)
            ENDIF
            SELECT (loc_cCursor)
            GO TOP
            loc_oPag.grd_4c_Clientes.Refresh()
        ELSE
            MsgAviso("Nenhum cliente encontrado para a Forma de Publicidade [" + loc_cPub + "].", "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGradeDados - cria grd_4c_Dados (grade de resultado da
    * consulta, equivalente a grdDados1/LocalDados do legado). SO estrutura
    * estatica (posicao/tamanho/propriedades de grade) - ColumnCount/
    * RecordSource/ControlSource ficam em MontarGradeDados(), chamado DEPOIS
    * de Processamento() povoar cursor_4c_Dados (regra #41 do CLAUDE.md:
    * ControlSource de cursor que ainda nao existe derruba o Init).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGradeDados(par_oPag)
        par_oPag.AddObject("grd_4c_Dados", "Grid")
        WITH par_oPag.grd_4c_Dados
            .Top               = 202
            .Left              = 7
            .Width             = 986
            .Height            = 355
            .FontName          = "Tahoma"
            .FontSize          = 8
            .RowHeight         = 16
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .GridLineColor     = RGB(238, 238, 238)
            .ScrollBars        = 2
            .Visible           = .T.
        ENDWITH
        BINDEVENT(par_oPag.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarGradeDados - Equivalente a ThisForm.MontaGradeD do legado. Religa
    * as 12 colunas a cursor_4c_Dados. RecordSource reseta Column.Width e
    * Header1.Caption (regra #48) - por isso TUDO e refeito aqui, sempre
    * chamado depois de Processamento() repovoar o cursor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarGradeDados()
        LOCAL loc_oGrid, loc_cCursor, loc_cCor

        loc_oGrid   = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        loc_cCor = "IIF(" + loc_cCursor + ".Nopers=9999998, RGB(255,253,179), " + ;
                   "IIF(" + loc_cCursor + ".Nopers=9999999, RGB(221,252,255), " + ;
                   "IIF(" + loc_cCursor + ".SInis=1, RGB(255,202,205), RGB(255,255,255))))"

        *-- GRID-WITH: ColumnCount/RecordSource FORA do WITH que acessa
        *-- .Column1..12 - evita 'Unknown member COLUMN1'.
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 12
        loc_oGrid.RecordSource = loc_cCursor

        WITH loc_oGrid
            .Column1.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtEmis)))"
            .Column1.Width           = 64
            .Column1.Header1.Caption = "Emiss" + CHR(227) + "o"

            .Column2.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Vencs)))"
            .Column2.Width           = 64
            .Column2.Header1.Caption = "Vencto."

            .Column3.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".Datas)))"
            .Column3.Width           = 64
            .Column3.Header1.Caption = "Lancto."

            .Column4.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', DTOC(TTOD(" + loc_cCursor + ".DtBaixa)))"
            .Column4.Width           = 64
            .Column4.Header1.Caption = "Baixa"

            .Column5.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997 OR " + loc_cCursor + ".SInis=1, '', " + loc_cCursor + ".Titulos)"
            .Column5.Width           = 70
            .Column5.Header1.Caption = "T" + CHR(237) + "tulo"

            .Column6.ControlSource   = loc_cCursor + ".Hists"
            .Column6.Width           = 240
            .Column6.Header1.Caption = "Hist" + CHR(243) + "rico"

            .Column7.ControlSource   = "IIF(" + loc_cCursor + ".Nopers > 9999997, '', " + loc_cCursor + ".Moedas)"
            .Column7.Width           = 20
            .Column7.Header1.Caption = "$"

            .Column8.ControlSource   = loc_cCursor + ".Valors"
            .Column8.Width           = 68
            .Column8.Header1.Caption = "Valor"

            *-- Legado usa goSistema.TxtDebito/TxtCredito (rotulo customizavel
            *-- por cliente) - essa customizacao NAO foi portada; caption fixo.
            .Column9.ControlSource   = loc_cCursor + ".Debitos"
            .Column9.Width           = 68
            .Column9.Header1.Caption = "D" + CHR(233) + "bito"

            .Column10.ControlSource   = loc_cCursor + ".Creditos"
            .Column10.Width           = 68
            .Column10.Header1.Caption = "Cr" + CHR(233) + "dito"

            .Column11.ControlSource   = loc_cCursor + ".SaldoDia"
            .Column11.Width           = 82
            .Column11.Header1.Caption = "Saldo"

            .Column12.ControlSource   = loc_cCursor + ".SaldoTot"
            .Column12.Width           = 82
            .Column12.Header1.Caption = "Acumulado"

            .SetAll("DynamicBackColor", loc_cCor, "Column")
            .FontName = "Arial"
            .SetAll("Movable", .F., "Column")
            .SetAll("Resizable", .F., "Column")
            .SetAll("ReadOnly", .T., "Column")
        ENDWITH

        GO TOP IN (loc_cCursor)
        loc_oGrid.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - equivalente ao AfterRowColChange de
    * grdDados1: carrega a linha corrente (via BO.CarregarDoCursor), espelha
    * os campos de detalhe da Page2 e os 4 indicadores de status (Botao1..4),
    * e habilita/desabilita os botoes de acao conforme o PROCEDURE When do
    * legado (linha "real" x linha sintetica de totalizador).
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_oPag, loc_oBO, loc_lTot

        IF !USED(THIS.this_oBusinessObject.this_cCursorDados)
            RETURN
        ENDIF
        IF !THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_oBusinessObject.this_cCursorDados)
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        *-- Bloco de limpeza do AfterRowColChange legado, extraido para o funil
        *-- unico LimparCampos(). O legado limpa SEMPRE as 4 descricoes e, SO
        *-- quando a linha e sintetica (llTot), os outros 14 campos; como o
        *-- ramo "IF !loc_lTot" abaixo reatribui TODOS os 18, limpar os 18 de
        *-- uma vez produz exatamente o mesmo resultado nos dois caminhos.
        THIS.LimparCampos()

        loc_lTot = (loc_oBO.this_nLinNopers > 9999997) OR (loc_oBO.this_nLinSInis = 1)

        loc_oPag.cnt_4c_Botoes.txt_4c_Botao1.Value = IIF(!loc_lTot AND loc_oBO.this_nLinTitCancs = 1, " X", "")
        loc_oPag.cnt_4c_Botoes.txt_4c_Botao2.Value = IIF(!loc_lTot AND loc_oBO.this_cLinPagos = "0", " X", "")
        loc_oPag.cnt_4c_Botoes.txt_4c_Botao3.Value = IIF(!loc_lTot AND loc_oBO.this_lLinConcs, " X", "")
        loc_oPag.cnt_4c_Botoes.txt_4c_Botao4.Value = IIF(!loc_lTot AND !EMPTY(loc_oBO.this_dLinProrrogs), " X", "")

        IF !loc_lTot
            loc_oPag.txt_4c_NFs.Value        = loc_oBO.this_cLinNFs
            loc_oPag.txt_4c_TitBans.Value    = loc_oBO.this_cLinTitBans
            loc_oPag.txt_4c_EspecieNfs.Value = loc_oBO.this_cLinEspecieNfs
            loc_oPag.txt_4c_Hist2s.Value     = loc_oBO.this_cLinHist2s
            loc_oPag.txt_4c_Emps.Value       = loc_oBO.this_cLinEmps
            loc_oPag.txt_4c_ValOcurs.Value   = loc_oBO.this_nLinValOcurs
            loc_oPag.txt_4c_GrupEms.Value    = loc_oBO.this_cLinGrupEms
            loc_oPag.txt_4c_ContEms.Value    = loc_oBO.this_cLinContEms
            loc_oPag.txt_4c_Grupo.Value      = loc_oBO.this_cLinGrupos
            loc_oPag.txt_4c_Contas.Value     = loc_oBO.this_cLinContas
            loc_oPag.txt_4c_SGrupos.Value    = loc_oBO.this_cLinSGrupos
            loc_oPag.txt_4c_SContas.Value    = loc_oBO.this_cLinSContas
            loc_oPag.txt_4c_GrupAges.Value   = loc_oBO.this_cLinGrupAges
            loc_oPag.txt_4c_ContAges.Value   = loc_oBO.this_cLinContAges

            loc_oPag.txt_4c_DContEms.Value  = THIS.ObterRazaoSocial(loc_oBO.this_cLinContEms)
            loc_oPag.txt_4c_DContas.Value   = THIS.ObterRazaoSocial(loc_oBO.this_cLinContas)
            loc_oPag.txt_4c_DSContas.Value  = THIS.ObterRazaoSocial(loc_oBO.this_cLinSContas)
            loc_oPag.txt_4c_DContAges.Value = THIS.ObterRazaoSocial(loc_oBO.this_cLinContAges)
        ENDIF

        *-- PROCEDURE When dos botoes de acao, extraido para o funil unico
        *-- AjustarBotoesPorModo() (tambem chamado por CarregarLista, para a
        *-- PRIMEIRA linha exibida, que nunca dispara AfterRowColChange).
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterRazaoSocial - cache de razao social (IClis/RClis), equivalente ao
    * cursor TmpContas do legado. Consulta SigCdCli SO na primeira vez que o
    * codigo aparece; demais chamadas usam o SEEK no cache local.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterRazaoSocial(par_cCodigo)
        LOCAL loc_cCursor, loc_cCodigo, loc_cSQL, loc_cResultado
        loc_cResultado = ""
        loc_cCodigo    = ALLTRIM(NVL(par_cCodigo, ""))

        IF EMPTY(loc_cCodigo)
            RETURN loc_cResultado
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorContas
        IF !USED(loc_cCursor)
            CREATE CURSOR (loc_cCursor) (IClis C(10), RClis C(50))
            INDEX ON IClis TAG IClis
        ENDIF

        SELECT (loc_cCursor)
        IF SEEK(PADR(loc_cCodigo, 10), loc_cCursor, "IClis")
            RETURN ALLTRIM(RClis)
        ENDIF

        loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RazaoTmp") > 0
            IF !EOF("cursor_4c_RazaoTmp")
                INSERT INTO (loc_cCursor) (IClis, RClis) VALUES ;
                    (PADR(ALLTRIM(cursor_4c_RazaoTmp.IClis), 10), cursor_4c_RazaoTmp.RClis)
                loc_cResultado = ALLTRIM(cursor_4c_RazaoTmp.RClis)
            ENDIF
            IF USED("cursor_4c_RazaoTmp")
                USE IN cursor_4c_RazaoTmp
            ENDIF
        ENDIF

        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CboOrdemInteractiveChange / ChkTotaisClick - equivalentes ao
    * InteractiveChange de cmbOrdem e ao Valid de chkTotais: atualizam
    * this_cOrdem/this_nOrdem e reordenam a grade (OrdenaGrade).
    *--------------------------------------------------------------------------
    PROCEDURE CboOrdemInteractiveChange()
        LOCAL loc_oCbo, loc_oBO
        loc_oCbo = THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem
        loc_oBO  = THIS.this_oBusinessObject

        DO CASE
        CASE loc_oCbo.Value = 1
            loc_oBO.this_cOrdem = "DtEmis"
        CASE loc_oCbo.Value = 2
            loc_oBO.this_cOrdem = "Vencs"
        CASE loc_oCbo.Value = 3
            loc_oBO.this_cOrdem = "Datas"
        CASE loc_oCbo.Value = 4
            loc_oBO.this_cOrdem = "DtBaixa"
        CASE loc_oCbo.Value = 5
            loc_oBO.this_cOrdem = "Titulos"
        CASE loc_oCbo.Value = 6
            loc_oBO.this_cOrdem = "Hists"
        CASE loc_oCbo.Value = 7
            loc_oBO.this_cOrdem = "ContEms"
        CASE loc_oCbo.Value = 8
            loc_oBO.this_cOrdem = "Contas"
        ENDCASE
        loc_oBO.this_nOrdem = loc_oCbo.Value

        THIS.OrdenaGrade()

        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.SetFocus()
    ENDPROC

    PROCEDURE ChkTotaisClick()
        THIS.OrdenaGrade()
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenaGrade - equivalente a ThisForm.OrdenaGrade: alterna entre o TAG
    * filtrado (exclui linhas sinteticas) e o TAG cheio conforme
    * chk_4c_Totais, recalcula os saldos (CalcSaldo/CalcSaldoCta conforme a
    * ordem corrente) e repinta a grade.
    *--------------------------------------------------------------------------
    PROCEDURE OrdenaGrade()
        LOCAL loc_cCursor, loc_cOrd, loc_oBO
        loc_oBO     = THIS.this_oBusinessObject
        loc_cCursor = loc_oBO.this_cCursorDados

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        loc_cOrd = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "", "_") + loc_oBO.this_cOrdem

        SELECT (loc_cCursor)
        SET ORDER TO TAG (loc_cOrd)

        IF INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
            THIS.CalcSaldoCta()
        ELSE
            THIS.CalcSaldo()
        ENDIF

        GO TOP IN (loc_cCursor)
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcSaldo - transcricao literal de ThisForm.CalcSaldo: recalcula
    * Debitos/Creditos/SaldoDia/SaldoTot linha a linha e insere as linhas
    * sinteticas de "Saldo Inicial"/"Saldo da Moeda"/"Saldo do dia" conforme
    * a troca de moeda/data na ordenacao corrente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcSaldo()
        LOCAL loc_oPag1, loc_cCursor, loc_cTotais, loc_cOrdem
        LOCAL loc_nSdD, loc_nSD1, loc_nSC1, loc_nSD2, loc_nSC2, loc_nSdT
        LOCAL loc_cMsd, loc_nOrd, loc_dDat, loc_dRla, loc_cMoe, loc_nVal

        loc_oPag1   = THIS.pgf_4c_Paginas.Page1
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
        loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
        loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem

        SELECT (loc_cCursor)
        REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0

        loc_nSdD = 0
        loc_nSD1 = 0
        loc_nSC1 = 0
        loc_nSD2 = 0
        loc_nSC2 = 0
        loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
        loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
        loc_nOrd = THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.Value

        IF USED(loc_cTotais)
            USE IN (loc_cTotais)
        ENDIF
        SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE

        DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)

        SELECT (loc_cCursor)
        GO TOP
        loc_dDat = TTOD(DtEmis)
        DO CASE
        CASE loc_nOrd = 2
            loc_dDat = TTOD(Vencs)
        CASE loc_nOrd = 3
            loc_dDat = TTOD(Datas)
        CASE loc_nOrd = 4
            loc_dDat = TTOD(DtBaixa)
        ENDCASE

        loc_cMoe = ALLTRIM(Moedas)

        IF !EMPTY(loc_nSdT)
            IF (loc_cMsd <> loc_cMoe)
                loc_nSdT = (loc_nSdT / fBuscarCotacao(loc_cMsd, loc_dDat, gnConnHandle)) * ;
                           fBuscarCotacao(loc_cMoe, loc_dDat, gnConnHandle)
            ENDIF
            loc_nSdD = loc_nSdT

            SCATTER MEMVAR
            m.Nopers   = 0
            m.Valors   = 0
            m.DtEmis   = loc_dDat
            m.Vencs    = loc_dDat
            m.Datas    = loc_dDat
            m.DtBaixa  = loc_dDat
            m.Hists    = "Saldo Inicial :"
            m.Debitos  = 0
            m.Creditos = 0
            m.SaldoDia = loc_nSdT
            m.SaldoTot = loc_nSdT
            m.Moedas   = loc_cMoe
            m.OrdHs    = "1"
            m.Titulos  = ""

            INSERT INTO (loc_cTotais) FROM MEMVAR
            REPLACE SInis WITH 1 IN (loc_cTotais)
        ENDIF

        SELECT (loc_cCursor)
        SCAN
            loc_dRla = TTOD(DtEmis)
            DO CASE
            CASE loc_nOrd = 2
                loc_dRla = TTOD(Vencs)
            CASE loc_nOrd = 3
                loc_dRla = TTOD(Datas)
            CASE loc_nOrd = 4
                loc_dRla = TTOD(DtBaixa)
            ENDCASE

            IF (loc_cMoe <> ALLTRIM(Moedas))
                SCATTER MEMVAR
                m.Nopers   = 9999999
                m.Valors   = 0
                m.DtEmis   = loc_dDat
                m.Vencs    = loc_dDat
                m.Datas    = loc_dDat
                m.DtBaixa  = loc_dDat
                m.Hists    = "Saldo da Moeda " + loc_cMoe + ":"
                m.Debitos  = loc_nSD1
                m.Creditos = loc_nSC1
                m.SaldoDia = loc_nSdD
                m.SaldoTot = loc_nSdT
                m.Moedas   = loc_cMoe
                m.OrdHs    = CHR(254)
                m.Titulos  = REPLICATE(CHR(254), 10)
                INSERT INTO (loc_cTotais) FROM MEMVAR
                loc_nSD1 = 0
                loc_nSC1 = 0

                IF INLIST(loc_cOrdem, "Titulos", "Hists")
                    loc_nSdT = IIF(loc_cMoe <> ALLTRIM(Moedas), 0, loc_nSdT)
                    loc_nSdD = 0
                ENDIF
            ENDIF

            IF !INLIST(loc_cOrdem, "Titulos", "Hists")
                IF ((loc_dDat <> loc_dRla) OR (loc_cMoe <> ALLTRIM(Moedas))) AND INLIST(loc_nOrd, 1, 2, 3, 4)
                    SCATTER MEMVAR
                    m.Nopers   = 9999998
                    m.Valors   = 0
                    m.DtEmis   = loc_dDat
                    m.Vencs    = loc_dDat
                    m.Datas    = loc_dDat
                    m.DtBaixa  = loc_dDat
                    m.Hists    = "Saldo do dia " + DTOC(loc_dDat) + ":"
                    m.Debitos  = loc_nSD2
                    m.Creditos = loc_nSC2
                    m.SaldoDia = loc_nSdD
                    m.SaldoTot = loc_nSdT
                    m.Moedas   = loc_cMoe
                    INSERT INTO (loc_cTotais) FROM MEMVAR

                    loc_nSdT = IIF(loc_cMoe <> ALLTRIM(Moedas), 0, loc_nSdT)
                    loc_nSdD = 0
                    loc_nSD2 = 0
                    loc_nSC2 = 0
                ENDIF
            ENDIF

            loc_dDat = loc_dRla
            loc_cMoe = ALLTRIM(Moedas)
            loc_nVal = ABS(Valors)

            loc_nSdD = loc_nSdD + (loc_nVal * IIF(Opers = "D", 1, -1))
            loc_nSdT = loc_nSdT + (loc_nVal * IIF(Opers = "D", 1, -1))

            loc_nSD1 = loc_nSD1 + IIF(Opers = "D", loc_nVal, 0)
            loc_nSC1 = loc_nSC1 + IIF(Opers = "C", loc_nVal, 0)
            loc_nSD2 = loc_nSD2 + IIF(Opers = "D", loc_nVal, 0)
            loc_nSC2 = loc_nSC2 + IIF(Opers = "C", loc_nVal, 0)

            REPLACE Debitos  WITH IIF(Opers = "D", loc_nVal, 0), ;
                    Creditos WITH IIF(Opers = "C", loc_nVal, 0), ;
                    SaldoDia WITH loc_nSdD, ;
                    SaldoTot WITH loc_nSdT
        ENDSCAN

        SELECT (loc_cCursor)
        SKIP -1
        IF !BOF() AND (RECCOUNT(loc_cCursor) > 1)
            IF !INLIST(loc_cOrdem, "Titulos", "Hists")
                SCATTER MEMVAR
                m.Nopers   = 9999998
                m.Valors   = 0
                m.DtEmis   = loc_dDat
                m.Vencs    = loc_dDat
                m.Datas    = loc_dDat
                m.DtBaixa  = loc_dDat
                m.Hists    = "Saldo do dia " + DTOC(loc_dDat) + ":"
                m.Debitos  = loc_nSD2
                m.Creditos = loc_nSC2
                m.SaldoDia = loc_nSdD
                m.SaldoTot = loc_nSdT
                m.Moedas   = loc_cMoe
                INSERT INTO (loc_cTotais) FROM MEMVAR
            ENDIF

            SCATTER MEMVAR
            m.Nopers   = 9999999
            m.Valors   = 0
            m.DtEmis   = loc_dDat
            m.Vencs    = loc_dDat
            m.Datas    = loc_dDat
            m.DtBaixa  = loc_dDat
            m.Hists    = "Saldo da Moeda " + loc_cMoe + ":"
            m.Debitos  = loc_nSD1
            m.Creditos = loc_nSC1
            m.SaldoDia = loc_nSdD
            m.SaldoTot = loc_nSdT
            m.Moedas   = loc_cMoe
            m.OrdHs    = CHR(254)
            m.Titulos  = REPLICATE(CHR(254), 10)
            INSERT INTO (loc_cTotais) FROM MEMVAR
        ENDIF

        SELECT (loc_cTotais)
        SCAN
            SCATTER MEMVAR
            INSERT INTO (loc_cCursor) FROM MEMVAR
        ENDSCAN

        GO TOP IN (loc_cCursor)
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcSaldoCta - transcricao literal de ThisForm.CalcSaldoCta: mesma
    * logica de CalcSaldo, mas agrupando por Emitente (ContEms) ou Portador
    * (Contas) em vez de por data, com a razao social (ObterRazaoSocial)
    * compondo a linha sintetica de saldo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcSaldoCta()
        LOCAL loc_oPag1, loc_cCursor, loc_cTotais, loc_cOrdem
        LOCAL loc_nSdD, loc_nSD1, loc_nSC1, loc_nSD2, loc_nSC2, loc_nSdT
        LOCAL loc_cMsd, loc_dDat, loc_cMoe, loc_cEmi, loc_cPor, loc_nVal

        loc_oPag1   = THIS.pgf_4c_Paginas.Page1
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
        loc_cTotais = THIS.this_oBusinessObject.this_cCursorTotais
        loc_cOrdem  = THIS.this_oBusinessObject.this_cOrdem

        SELECT (loc_cCursor)
        REPLACE ALL SaldoDia WITH 0, SaldoTot WITH 0, Debitos WITH 0, Creditos WITH 0

        loc_nSdD = 0
        loc_nSD1 = 0
        loc_nSC1 = 0
        loc_nSD2 = 0
        loc_nSC2 = 0
        loc_nSdT = loc_oPag1.txt_4c_Saldo.Value
        loc_cMsd = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)

        IF USED(loc_cTotais)
            USE IN (loc_cTotais)
        ENDIF
        SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cTotais) READWRITE

        DELETE FROM (loc_cCursor) WHERE (Nopers > 9999997) OR (SInis = 1)

        SELECT (loc_cCursor)
        GO TOP
        loc_dDat = TTOD(DtEmis)
        loc_cMoe = ALLTRIM(Moedas)
        loc_cEmi = ALLTRIM(ContEms)
        loc_cPor = ALLTRIM(Contas)

        SCAN
            IF (loc_cMoe <> ALLTRIM(Moedas)) OR ;
               (loc_cOrdem = "ContEms" AND ALLTRIM(ContEms) <> loc_cEmi) OR ;
               (loc_cOrdem = "Contas"  AND ALLTRIM(Contas)  <> loc_cPor)

                SCATTER MEMVAR
                m.Nopers   = 9999999
                m.Valors   = 0
                m.DtEmis   = loc_dDat
                m.Vencs    = loc_dDat
                m.Datas    = loc_dDat
                m.DtBaixa  = loc_dDat
                m.Hists    = ""
                IF (loc_cOrdem = "ContEms")
                    m.Hists = "Saldo " + ALLTRIM(loc_cMoe)
                    IF !EMPTY(loc_cEmi)
                        m.Hists = m.Hists + " / " + loc_cEmi + " " + ALLTRIM(THIS.ObterRazaoSocial(loc_cEmi))
                    ENDIF
                    m.Hists = m.Hists + ":"
                ENDIF
                IF (loc_cOrdem = "Contas")
                    m.Hists = "Saldo " + ALLTRIM(loc_cMoe)
                    IF !EMPTY(loc_cPor)
                        m.Hists = m.Hists + " / " + loc_cPor + " " + ALLTRIM(THIS.ObterRazaoSocial(loc_cPor))
                    ENDIF
                    m.Hists = m.Hists + ":"
                ENDIF
                m.Debitos  = loc_nSD1
                m.Creditos = loc_nSC1
                m.SaldoDia = loc_nSdD
                m.SaldoTot = loc_nSdT
                m.Moedas   = loc_cMoe
                m.ContEms  = loc_cEmi
                m.Contas   = loc_cPor
                m.OrdHs    = CHR(254)
                m.Titulos  = REPLICATE(CHR(254), 10)
                INSERT INTO (loc_cTotais) FROM MEMVAR
                loc_nSD1 = 0
                loc_nSC1 = 0

                IF INLIST(loc_cOrdem, "Titulos", "Hists", "ContEms", "Contas")
                    loc_nSdT = IIF(loc_cMoe <> ALLTRIM(Moedas) OR ;
                                   (loc_cOrdem = "ContEms" AND ALLTRIM(ContEms) <> loc_cEmi) OR ;
                                   (loc_cOrdem = "Contas"  AND ALLTRIM(Contas)  <> loc_cPor), 0, loc_nSdT)
                    loc_nSdD = 0
                ENDIF
            ENDIF

            loc_cMoe = ALLTRIM(Moedas)
            loc_cEmi = ALLTRIM(ContEms)
            loc_cPor = ALLTRIM(Contas)
            loc_nVal = ABS(Valors)

            loc_nSdD = loc_nSdD + (loc_nVal * IIF(Opers = "D", 1, -1))
            loc_nSdT = loc_nSdT + (loc_nVal * IIF(Opers = "D", 1, -1))

            loc_nSD1 = loc_nSD1 + IIF(Opers = "D", loc_nVal, 0)
            loc_nSC1 = loc_nSC1 + IIF(Opers = "C", loc_nVal, 0)
            loc_nSD2 = loc_nSD2 + IIF(Opers = "D", loc_nVal, 0)
            loc_nSC2 = loc_nSC2 + IIF(Opers = "C", loc_nVal, 0)

            REPLACE Debitos  WITH IIF(Opers = "D", loc_nVal, 0), ;
                    Creditos WITH IIF(Opers = "C", loc_nVal, 0), ;
                    SaldoDia WITH loc_nSdD, ;
                    SaldoTot WITH loc_nSdT
        ENDSCAN

        SELECT (loc_cCursor)
        SKIP -1
        IF !BOF() AND (RECCOUNT(loc_cCursor) > 1)
            SCATTER MEMVAR
            m.Nopers   = 9999999
            m.Valors   = 0
            m.DtEmis   = loc_dDat
            m.Vencs    = loc_dDat
            m.Datas    = loc_dDat
            m.DtBaixa  = loc_dDat
            m.Hists    = ""
            IF (loc_cOrdem = "ContEms")
                m.Hists = "Saldo " + ALLTRIM(loc_cMoe)
                IF !EMPTY(loc_cEmi)
                    m.Hists = m.Hists + " / " + loc_cEmi + " " + ALLTRIM(THIS.ObterRazaoSocial(loc_cEmi))
                ENDIF
                m.Hists = m.Hists + ":"
            ENDIF
            IF (loc_cOrdem = "Contas")
                m.Hists = "Saldo " + ALLTRIM(loc_cMoe)
                IF !EMPTY(loc_cPor)
                    m.Hists = m.Hists + " / " + loc_cPor + " " + ALLTRIM(THIS.ObterRazaoSocial(loc_cPor))
                ENDIF
                m.Hists = m.Hists + ":"
            ENDIF
            m.Debitos  = loc_nSD1
            m.Creditos = loc_nSC1
            m.SaldoDia = loc_nSdD
            m.SaldoTot = loc_nSdT
            m.Moedas   = loc_cMoe
            m.OrdHs    = CHR(254)
            m.Titulos  = REPLICATE(CHR(254), 10)
            INSERT INTO (loc_cTotais) FROM MEMVAR
        ENDIF

        SELECT (loc_cTotais)
        SCAN
            SCATTER MEMVAR
            INSERT INTO (loc_cCursor) FROM MEMVAR
        ENDSCAN

        GO TOP IN (loc_cCursor)
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarFiltroGrupoContaManter / AplicarFiltroGrupoContaExcluirTodas -
    * helpers do filtro de Grupo/Conta informado nas duas grades de
    * selecao (cursor_4c_Clientes/cursor_4c_Clientes2), transcritos do Do
    * Case do Processamento legado. A versao "ExcluirTodas" preserva, de
    * proposito, a assimetria do dump original (quando os DOIS campos estao
    * preenchidos, o grupo usa "<>" e a conta usa "=" em vez de "<>") -
    * regra #17 do CLAUDE.md: transcrever, nunca reescrever.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarFiltroGrupoContaManter(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)
        LOCAL loc_cWhere

        IF EMPTY(par_cColGrupo)
            RETURN
        ENDIF

        DO CASE
        CASE !EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
            loc_cWhere = par_cColGrupo + " = '" + ALLTRIM(par_cGrupo) + "' AND " + par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
        CASE !EMPTY(par_cGrupo) AND EMPTY(par_cConta)
            loc_cWhere = par_cColGrupo + " = '" + ALLTRIM(par_cGrupo) + "'"
        CASE EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
            loc_cWhere = par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
        OTHERWISE
            RETURN
        ENDCASE

        UPDATE (par_cCursorDados) SET ManterDados = 1 WHERE &loc_cWhere.
    ENDPROC

    PROTECTED PROCEDURE AplicarFiltroGrupoContaExcluirTodas(par_cCursorDados, par_cColGrupo, par_cColConta, par_cGrupo, par_cConta)
        LOCAL loc_cWhere

        IF EMPTY(par_cColGrupo)
            RETURN
        ENDIF

        DO CASE
        CASE !EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
            loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "' OR " + par_cColConta + " = '" + ALLTRIM(par_cConta) + "'"
        CASE !EMPTY(par_cGrupo) AND EMPTY(par_cConta)
            loc_cWhere = par_cColGrupo + " <> '" + ALLTRIM(par_cGrupo) + "'"
        CASE EMPTY(par_cGrupo) AND !EMPTY(par_cConta)
            loc_cWhere = par_cColConta + " <> '" + ALLTRIM(par_cConta) + "'"
        OTHERWISE
            RETURN
        ENDCASE

        UPDATE (par_cCursorDados) SET ManterDados = 0 WHERE &loc_cWhere.
    ENDPROC

    *--------------------------------------------------------------------------
    * DataFimDiaSQL - monta o literal SQL Server do limite SUPERIOR de uma
    * faixa de data (23:59:59), equivalente a fDtoSql(valor, [23:59:59]) do
    * legado. Data vazia usa o sentinela 31/12/2099 (igual ao legado).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION DataFimDiaSQL(par_dData)
        LOCAL loc_dData
        loc_dData = par_dData
        IF EMPTY(loc_dData)
            loc_dData = {^2099-12-31}
        ENDIF
        RETURN "'" + PADL(YEAR(loc_dData), 4, "0") + "-" + PADL(MONTH(loc_dData), 2, "0") + "-" + ;
               PADL(DAY(loc_dData), 2, "0") + " 23:59:59'"
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processamento - transcricao do Processamento/ThisForm.Processamento do
    * legado: monta a consulta financeira (SigMvCcr + filtros de Page1),
    * aplica os filtros de Grupo/Conta das duas grades auxiliares, preenche
    * a Data de Baixa e converte moeda quando necessario, cria os indices de
    * ordenacao e deixa cursor_4c_Dados pronto para a Page2. Retorna .T. se
    * encontrou dados (e so nesse caso o CmgFiltrosClick avanca para a
    * Page2); .F. mantem o usuario na Page1 (igual ao ActivePage=1 do
    * legado nos dois pontos de "Dados Nao Encontrados").
    *--------------------------------------------------------------------------
    PROCEDURE Processamento()
        LOCAL loc_oPag1, loc_oBO, loc_cCursor, loc_cCursorTmp, loc_cSQL, loc_cRes
        LOCAL loc_cEmp, loc_cDem, loc_cDvc, loc_cDla, loc_cMoe, loc_cPag, loc_cOpc
        LOCAL loc_cCan, loc_cCcl, loc_cTit, loc_cNfs, loc_cTba, loc_cEsp, loc_cOpT
        LOCAL loc_cCodEmp, loc_dDeI, loc_dDeF, loc_dDvI, loc_dDvF, loc_dDlI, loc_dDlF
        LOCAL loc_nFl2, loc_nOpe, loc_lPrimeira, loc_nNop, loc_dPbI, loc_dPbF
        LOCAL loc_cMdO, loc_dTDat, loc_nCtO, loc_nCtD, loc_nVlD, loc_nVlO, loc_nVlP, loc_nVlA

        loc_oPag1   = THIS.pgf_4c_Paginas.Page1
        loc_oBO     = THIS.this_oBusinessObject
        loc_cCursor = loc_oBO.this_cCursorDados
        loc_cRes    = ""

        *-- Espelha os filtros da tela nas propriedades do BO ANTES de montar
        *-- a consulta, para que o BO reflita exatamente os criterios que
        *-- foram aplicados (consumido por Imprimir/Planilha e pela
        *-- serializacao do filtro nomeado).
        THIS.FormParaBO()

        *-- Empresa (EmpCcs tem precedencia sobre Emps - ajuste do legado
        *-- para checar lancamento em outra empresa gravado no EmpCcs)
        loc_cEmp = ""
        IF !EMPTY(loc_oPag1.txt_4c_Empresa.Value)
            loc_cCodEmp = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)
            loc_cRes = loc_cRes + " / Empresa: " + loc_cCodEmp
            loc_cEmp = " AND (CASE WHEN a.EmpCcs <> '' AND a.EmpCcs = " + EscaparSQL(loc_cCodEmp) + " THEN 1 " + ;
                       "ELSE CASE WHEN a.EmpCcs = '' AND a.Emps = " + EscaparSQL(loc_cCodEmp) + " THEN 1 ELSE 0 END END) = 1"
        ENDIF

        *-- Emissao
        loc_cDem = ""
        IF !EMPTY(loc_oPag1.txt_4c_DtEmiI.Value)
            loc_dDeI = loc_oPag1.txt_4c_DtEmiI.Value
            loc_dDeF = loc_oPag1.txt_4c_DtEmiF.Value
            loc_cDem = " AND (a.DtEmis BETWEEN " + FormatarDataSQL(loc_dDeI) + " AND " + THIS.DataFimDiaSQL(loc_dDeF) + ;
                       IIF(loc_oPag1.chk_4c_Brancos.Value = 0, "", " OR a.DtEmis IS NULL") + ")"
            loc_cRes = loc_cRes + " / Emiss" + CHR(227) + "o: " + DTOC(loc_dDeI) + " a " + ;
                       DTOC(IIF(EMPTY(loc_dDeF), {^2099-12-31}, loc_dDeF))
        ENDIF

        *-- Vencimento
        loc_cDvc = ""
        IF !EMPTY(loc_oPag1.txt_4c_VencsI.Value)
            loc_dDvI = loc_oPag1.txt_4c_VencsI.Value
            loc_dDvF = loc_oPag1.txt_4c_VencsF.Value
            loc_cDvc = " AND a.Vencs BETWEEN " + FormatarDataSQL(loc_dDvI) + " AND " + THIS.DataFimDiaSQL(loc_dDvF)
            loc_cRes = loc_cRes + " / Vencimento: " + DTOC(loc_dDvI) + " a " + ;
                       DTOC(IIF(EMPTY(loc_dDvF), {^2099-12-31}, loc_dDvF))
        ENDIF

        *-- Lancamento
        loc_cDla = ""
        IF !EMPTY(loc_oPag1.txt_4c_DatasI.Value)
            loc_dDlI = loc_oPag1.txt_4c_DatasI.Value
            loc_dDlF = loc_oPag1.txt_4c_DatasF.Value
            loc_cDla = " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDlI) + " AND " + THIS.DataFimDiaSQL(loc_dDlF)
            loc_cRes = loc_cRes + " / Lan" + CHR(231) + "amento: " + DTOC(loc_dDlI) + " a " + ;
                       DTOC(IIF(EMPTY(loc_dDlF), {^2099-12-31}, loc_dDlF))
        ENDIF

        *-- Acerto (data de baixa) - o legado comenta o fragmento no WHERE
        *-- (lcDbx fica so na descricao); o filtro real roda DEPOIS do
        *-- preenchimento da Data de Baixa, mais abaixo neste metodo.
        IF !EMPTY(loc_oPag1.txt_4c_DtBxI.Value)
            loc_cRes = loc_cRes + " / Acerto: " + DTOC(loc_oPag1.txt_4c_DtBxI.Value) + " a " + ;
                       DTOC(IIF(EMPTY(loc_oPag1.txt_4c_DtBxF.Value), {^2099-12-31}, loc_oPag1.txt_4c_DtBxF.Value))
        ENDIF

        *-- Moeda filtro
        loc_cMoe = ""
        IF !EMPTY(loc_oPag1.txt_4c_CMoes.Value)
            loc_cMoe = " AND a.Moedas = " + EscaparSQL(ALLTRIM(loc_oPag1.txt_4c_CMoes.Value))
            loc_cRes = loc_cRes + " / Moeda Filtro: " + ALLTRIM(loc_oPag1.txt_4c_CMoes.Value)
        ENDIF

        IF !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
            loc_cRes = loc_cRes + " / Moeda Convers" + CHR(227) + "o: " + ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value) + " (" + ;
                       IIF(loc_oPag1.opt_4c_CotEm.Value = 1, "Emiss" + CHR(227) + "o", ;
                       IIF(loc_oPag1.opt_4c_CotEm.Value = 2, "Vencimento", ;
                       IIF(loc_oPag1.opt_4c_CotEm.Value = 3, "Lan" + CHR(231) + "amento", ;
                       IIF(loc_oPag1.opt_4c_CotEm.Value = 4, "Data Atual", "Data Acerto")))) + ")"
        ENDIF

        *-- Pagamento
        loc_cPag = ""
        IF loc_oPag1.opt_4c_Pagos.Value <> 1
            loc_cPag = " AND a.Pagos = " + IIF(loc_oPag1.opt_4c_Pagos.Value = 2, "'0'", "'1'")
            loc_cRes = loc_cRes + " / Pagamento: " + IIF(loc_oPag1.opt_4c_Pagos.Value = 2, "Sim", "N" + CHR(227) + "o")
        ENDIF

        *-- Opcao (NFs preenchida ou nao)
        loc_cOpc = ""
        IF loc_oPag1.opt_4c_Opcao.Value <> 1
            loc_cOpc = " AND " + IIF(loc_oPag1.opt_4c_Opcao.Value = 2, "LTRIM(RTRIM(a.NFs)) <> ''", "LTRIM(RTRIM(a.NFs)) = ''")
            loc_cRes = loc_cRes + " / Op" + CHR(231) + CHR(227) + "o: " + IIF(loc_oPag1.opt_4c_Opcao.Value = 2, "Sim", "N" + CHR(227) + "o")
        ENDIF

        *-- Cancelamento
        loc_cCan = ""
        IF loc_oPag1.opt_4c_Cancs.Value <> 1
            loc_cCan = " AND " + IIF(loc_oPag1.opt_4c_Cancs.Value = 2, "", "NOT ") + "a.TitCancs = 1"
            loc_cRes = loc_cRes + " / Cancelamento: " + IIF(loc_oPag1.opt_4c_Cancs.Value = 2, "Sim", "N" + CHR(227) + "o")
        ENDIF

        *-- Conciliacao - o legado testa optCancs.Value=3 (nao optConcs) no
        *-- IIF interno; preservado literalmente (regra #17).
        loc_cCcl = ""
        IF loc_oPag1.opt_4c_Concs.Value <> 1
            loc_cCcl = " AND " + IIF(loc_oPag1.opt_4c_Cancs.Value = 3, "", "NOT ") + "a.Concs = 1"
            loc_cRes = loc_cRes + " / Concilia" + CHR(231) + CHR(227) + "o: " + IIF(loc_oPag1.opt_4c_Concs.Value = 2, "Sim", "N" + CHR(227) + "o")
        ENDIF

        IF loc_oPag1.opt_4c_Prorrogs.Value <> 1
            loc_cRes = loc_cRes + " / Prorroga" + CHR(231) + CHR(227) + "o: " + IIF(loc_oPag1.opt_4c_Prorrogs.Value = 2, "Sim", "N" + CHR(227) + "o")
        ENDIF

        *-- Titulo / Nota Fiscal / Titulo Banco / Especie
        loc_cTit = ""
        IF !EMPTY(loc_oPag1.txt_4c_Titulos.Value)
            loc_cTit = " AND a.Titulos = " + EscaparSQL(loc_oPag1.txt_4c_Titulos.Value)
            loc_cRes = loc_cRes + " / T" + CHR(237) + "tulo: " + ALLTRIM(loc_oPag1.txt_4c_Titulos.Value)
        ENDIF

        loc_cNfs = ""
        IF !EMPTY(loc_oPag1.txt_4c_NFs.Value)
            loc_cNfs = " AND a.NFs = " + EscaparSQL(loc_oPag1.txt_4c_NFs.Value)
            loc_cRes = loc_cRes + " / Nota Fiscal: " + ALLTRIM(loc_oPag1.txt_4c_NFs.Value)
        ENDIF

        loc_cTba = ""
        IF !EMPTY(loc_oPag1.txt_4c_TitBans.Value)
            loc_cTba = " AND a.TitBans = " + EscaparSQL(loc_oPag1.txt_4c_TitBans.Value)
            loc_cRes = loc_cRes + " / T" + CHR(237) + "tulo Banco: " + ALLTRIM(loc_oPag1.txt_4c_TitBans.Value)
        ENDIF

        loc_cEsp = ""
        IF !EMPTY(loc_oPag1.txt_4c_EspecieNfs.Value)
            loc_cEsp = " AND a.EspecieNfs = " + EscaparSQL(loc_oPag1.txt_4c_EspecieNfs.Value)
            loc_cRes = loc_cRes + " / Esp" + CHR(233) + "cie: " + ALLTRIM(loc_oPag1.txt_4c_EspecieNfs.Value)
        ENDIF

        IF !EMPTY(loc_oPag1.txt_4c_Saldo.Value)
            loc_cRes = loc_cRes + " / Saldo Inicial: " + ALLTRIM(TRANSFORM(loc_oPag1.txt_4c_Saldo.Value, "999999999999.99")) + ;
                       " " + ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)
        ENDIF

        *-- Filtro de Movimentacao de Titulos (grd_4c_Tipos - cursor_4c_Tipos.Imps=1)
        loc_cOpT = ""
        SELECT (loc_oBO.this_cCursorTipos)
        GO TOP
        COUNT FOR Imps = 1 TO loc_nOpe

        DO CASE
        CASE loc_nOpe = 1
            GO TOP
            LOCATE FOR Imps = 1
            loc_cOpT = " AND a.Dopcs = " + EscaparSQL(ALLTRIM(Dopes))
            loc_cRes = loc_cRes + " / Movimenta" + CHR(231) + CHR(227) + "o: " + ALLTRIM(Dopes)
        CASE loc_nOpe > 1
            loc_cRes = loc_cRes + " / Movimenta" + CHR(231) + CHR(227) + "o: "
            loc_lPrimeira = .T.
            loc_cOpT = " AND a.Dopcs IN ("
            SCAN
                IF Imps = 1
                    loc_cOpT = loc_cOpT + IIF(loc_lPrimeira, "", ",") + EscaparSQL(ALLTRIM(Dopes))
                    loc_cRes = loc_cRes + IIF(loc_lPrimeira, "", ", ") + ALLTRIM(Dopes)
                    loc_lPrimeira = .F.
                ENDIF
            ENDSCAN
            loc_cOpT = loc_cOpT + ")"
        OTHERWISE
            *-- Nao faz nada: carrega todos os lancamentos
        ENDCASE

        *-- Consulta principal (SigMvCcr + SigCdPit + SigOpMvv)
        loc_cCursorTmp = loc_cCursor + "Tmp"
        loc_cSQL = "SELECT a.Nopers, a.Titulos, a.NFs, a.TitBans, a.EspecieNfs, a.Dopes, a.DtEmis, a.Vencs, a.Datas, " + ;
                   "a.GrupEms, a.ContEms, a.Grupos, a.Contas, a.SGrupos, a.SContas, a.GrupAges, a.ContAges, " + ;
                   "a.Pagos, a.ValPrev, a.Valors, a.Moedas, a.Moedas AS MoeOrigs, a.Cotacaos, a.ValOcurs, " + ;
                   "a.Saldos, a.ValPags, a.UsuAlts, a.Opers, a.Hists, a.Hist2s, a.Tipos, a.TitCancs, a.Concs, " + ;
                   "a.Emps, a.Dopcs, a.EmpDopNums, a.EmpDopNcs, 1 AS ManterDados, a.DtEmis AS DtBaixa, " + ;
                   "CAST(9999999999.99 AS NUMERIC(15,2)) AS SaldoDia, CAST(9999999999.99 AS NUMERIC(15,2)) AS Debitos, " + ;
                   "'8' AS OrdHs, a.Numes, a.Numcs, a.VOpers, " + ;
                   "CAST(9999999999.99 AS NUMERIC(15,2)) AS SaldoTot, CAST(9999999999.99 AS NUMERIC(15,2)) AS Creditos, " + ;
                   "MAX(d.Vencs) AS Prorrogs, 0 AS SInis " + ;
                   "FROM SigMvCcr a " + ;
                   "LEFT JOIN SigCdPit b ON a.Nopers = b.Nopers " + ;
                   "LEFT JOIN SigOpMvv d ON a.EmpDopNcs = d.EmpDopNcs " + ;
                   "WHERE 0 = 0 " + loc_cEmp + loc_cDem + loc_cDvc + loc_cDla + loc_cMoe + loc_cPag + loc_cOpc + ;
                   loc_cTit + loc_cNfs + loc_cTba + loc_cEsp + loc_cCan + loc_cCcl + loc_cOpT + " " + ;
                   "GROUP BY a.Nopers, a.Titulos, a.NFs, a.TitBans, a.EspecieNfs, a.Dopes, a.DtEmis, a.Vencs, a.Datas, " + ;
                   "a.GrupEms, a.ContEms, a.Grupos, a.Contas, a.SGrupos, a.SContas, a.GrupAges, a.ContAges, " + ;
                   "a.Pagos, a.ValPrev, a.Valors, a.Moedas, a.Cotacaos, a.ValOcurs, a.Saldos, a.ValPags, " + ;
                   "a.UsuAlts, a.Opers, a.Hists, a.Hist2s, a.Tipos, a.TitCancs, a.Concs, a.Emps, a.Dopcs, " + ;
                   "a.EmpDopNums, a.EmpDopNcs, a.Numes, a.Numcs, a.VOpers"

        IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
            RETURN .F.
        ENDIF

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        SELECT * FROM (loc_cCursorTmp) INTO CURSOR (loc_cCursor) READWRITE
        IF USED(loc_cCursorTmp)
            USE IN (loc_cCursorTmp)
        ENDIF

        SELECT (loc_cCursor)
        REPLACE ALL Saldos   WITH 0, ;
                    DtBaixa  WITH CTOT(""), ;
                    DtEmis   WITH TratarNulo(DtEmis, CTOT("")), ;
                    Vencs    WITH TratarNulo(Vencs, CTOT("")), ;
                    Datas    WITH TratarNulo(Datas, CTOT("")), ;
                    Prorrogs WITH TratarNulo(Prorrogs, CTOT(""))

        SELECT (loc_cCursor)
        GO TOP
        IF EOF()
            MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
                      "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
            RETURN .F.
        ENDIF

        IF loc_oPag1.chk_4c_ValPends.Value = 1
            REPLACE ALL Valors WITH Valors - ValPags
        ENDIF

        *-- Filtrando Grupos/Contas informados na grade 1 (cursor_4c_Clientes)
        SELECT (loc_oBO.this_cCursorClientes)
        LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
        IF FOUND()
            UPDATE (loc_cCursor) SET ManterDados = 0

            SELECT (loc_oBO.this_cCursorClientes)
            SCAN
                IF CheckE = 1
                    THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
                ENDIF
                IF CheckP = 1
                    THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
                ENDIF
                IF CheckC = 1
                    THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "SGrupos", "SContas", Grupo, Conta)
                ENDIF
                IF CheckA = 1
                    THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupAges", "ContAges", Grupo, Conta)
                ENDIF
            ENDSCAN

            loc_cRes = loc_cRes + " / Grupos-Contas: "
            SELECT (loc_oBO.this_cCursorClientes)
            SCAN
                loc_cRes = loc_cRes + IIF(EMPTY(Grupo), "N/I", ALLTRIM(Grupo)) + "-" + ;
                           IIF(EMPTY(Conta), "N/I", ALLTRIM(Conta)) + " (" + ;
                           IIF(CheckE = 1, "E,", "") + IIF(CheckP = 1, "P,", "") + ;
                           IIF(CheckC = 1, "C,", "") + IIF(CheckA = 1, "A,", "")
                loc_cRes = LEFT(ALLTRIM(loc_cRes), LEN(ALLTRIM(loc_cRes)) - 1) + ")"
            ENDSCAN

            DELETE FROM (loc_cCursor) WHERE ManterDados = 0
        ENDIF

        *-- Filtrando Grupos/Contas informados na grade 2 (Todas/Alguma)
        loc_nFl2 = loc_oPag1.opt_4c_FilGrd2.Value
        SELECT (loc_oBO.this_cCursorClientes2)
        LOCATE FOR !EMPTY(Grupo) OR !EMPTY(Conta)
        IF FOUND()
            UPDATE (loc_cCursor) SET ManterDados = IIF(loc_nFl2 = 1, 1, 0)

            SELECT (loc_oBO.this_cCursorClientes2)
            SCAN
                IF loc_nFl2 = 1
                    IF CheckE = 1
                        THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
                    ENDIF
                    IF CheckP = 1
                        THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
                    ENDIF
                    IF CheckC = 1
                        THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "SGrupos", "SContas", Grupo, Conta)
                    ENDIF
                    IF CheckA = 1
                        THIS.AplicarFiltroGrupoContaExcluirTodas(loc_cCursor, "GrupAges", "ContAges", Grupo, Conta)
                    ENDIF
                ELSE
                    IF CheckE = 1
                        THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupEms", "ContEms", Grupo, Conta)
                    ENDIF
                    IF CheckP = 1
                        THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "Grupos", "Contas", Grupo, Conta)
                    ENDIF
                    IF CheckC = 1
                        THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "SGrupos", "SContas", Grupo, Conta)
                    ENDIF
                    IF CheckA = 1
                        THIS.AplicarFiltroGrupoContaManter(loc_cCursor, "GrupAges", "ContAges", Grupo, Conta)
                    ENDIF
                ENDIF
            ENDSCAN

            loc_cRes = loc_cRes + " / Grupos-Contas (" + IIF(loc_nFl2 = 1, "Todas", "Alguma") + "): "
            SELECT (loc_oBO.this_cCursorClientes2)
            SCAN
                loc_cRes = loc_cRes + IIF(EMPTY(Grupo), "N/I", ALLTRIM(Grupo)) + "-" + ;
                           IIF(EMPTY(Conta), "N/I", ALLTRIM(Conta)) + " (" + ;
                           IIF(CheckE = 1, "E,", "") + IIF(CheckP = 1, "P,", "") + ;
                           IIF(CheckC = 1, "C,", "") + IIF(CheckA = 1, "A,", "")
                loc_cRes = LEFT(ALLTRIM(loc_cRes), LEN(ALLTRIM(loc_cRes)) - 1) + ")"
            ENDSCAN

            DELETE FROM (loc_cCursor) WHERE ManterDados = 0
        ENDIF

        *-- Filtrando os Titulos Prorrogados
        IF loc_oPag1.opt_4c_Prorrogs.Value <> 1
            IF loc_oPag1.opt_4c_Prorrogs.Value = 2
                DELETE FROM (loc_cCursor) WHERE EMPTY(Prorrogs)
            ELSE
                DELETE FROM (loc_cCursor) WHERE !EMPTY(Prorrogs)
            ENDIF
        ENDIF

        *-- Preenchendo a Data da Baixa (titulos em aberto, Pagos = "0")
        SELECT (loc_cCursor)
        SCAN FOR Pagos = "0"
            loc_nNop = Nopers
            loc_cSQL = "SELECT b.DatarCs FROM SigCdPit a, SigCdPgr b " + ;
                       "WHERE a.Nopers = " + FormatarNumeroSQL(loc_nNop, 0) + " AND a.EmpDopNums = b.EmpDopNums " + ;
                       "ORDER BY b.DatarCs DESC"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgtDtBx") < 1
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")
                RETURN .F.
            ENDIF
            IF !EOF("cursor_4c_ConsPgtDtBx")
                REPLACE DtBaixa WITH cursor_4c_ConsPgtDtBx.DatarCs IN (loc_cCursor)
            ELSE
                IF USED("cursor_4c_ConsPgtDtBx")
                    USE IN cursor_4c_ConsPgtDtBx
                ENDIF
                loc_cSQL = "SELECT Datas AS DataRcs FROM SigTtCcr WHERE NOpers = " + FormatarNumeroSQL(loc_nNop, 0) + " " + ;
                           "ORDER BY Datas DESC"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgtDtBx") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 2)")
                    RETURN .F.
                ENDIF
                IF !EOF("cursor_4c_ConsPgtDtBx")
                    REPLACE DtBaixa WITH cursor_4c_ConsPgtDtBx.DataRcs IN (loc_cCursor)
                ENDIF
            ENDIF
            IF USED("cursor_4c_ConsPgtDtBx")
                USE IN cursor_4c_ConsPgtDtBx
            ENDIF
            SELECT (loc_cCursor)
        ENDSCAN

        *-- Filtro de Acerto (Data de Baixa), aplicado SO depois do
        *-- preenchimento acima - igual ao legado.
        IF !EMPTY(loc_oPag1.txt_4c_DtBxI.Value)
            loc_dPbI = loc_oPag1.txt_4c_DtBxI.Value
            loc_dPbF = IIF(EMPTY(loc_oPag1.txt_4c_DtBxF.Value), {^2099-12-31}, loc_oPag1.txt_4c_DtBxF.Value)
            DELETE FROM (loc_cCursor) WHERE !BETWEEN(TTOD(DtBaixa), loc_dPbI, loc_dPbF)
        ENDIF

        *-- Convertendo valores para a moeda de conversao
        IF !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
            loc_cMdO = ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value)

            SELECT (loc_cCursor)
            SCAN
                IF ALLTRIM(Moedas) <> loc_cMdO
                    loc_dTDat = TTOD(DtEmis)
                    DO CASE
                    CASE loc_oPag1.opt_4c_CotEm.Value = 2
                        loc_dTDat = TTOD(Vencs)
                    CASE loc_oPag1.opt_4c_CotEm.Value = 3
                        loc_dTDat = TTOD(Datas)
                    CASE loc_oPag1.opt_4c_CotEm.Value = 4
                        loc_dTDat = DATE()
                    CASE loc_oPag1.opt_4c_CotEm.Value = 5
                        IF !EMPTY(DtBaixa)
                            loc_dTDat = TTOD(DtBaixa)
                        ENDIF
                    ENDCASE
                    IF EMPTY(loc_dTDat)
                        loc_dTDat = TTOD(Datas)
                    ENDIF

                    loc_nCtO = fBuscarCotacao(loc_cMdO, loc_dTDat, gnConnHandle)
                    loc_nCtD = fBuscarCotacao(ALLTRIM(Moedas), loc_dTDat, gnConnHandle)
                    loc_nVlD = (Valors   / loc_nCtO) * loc_nCtD
                    loc_nVlO = (ValOcurs / loc_nCtO) * loc_nCtD
                    loc_nVlP = (ValPrev  / loc_nCtO) * loc_nCtD
                    loc_nVlA = (ValPags  / loc_nCtO) * loc_nCtD

                    REPLACE Moedas   WITH loc_cMdO, ;
                            Valors   WITH loc_nVlD, ;
                            ValOcurs WITH loc_nVlO, ;
                            ValPrev  WITH loc_nVlP, ;
                            ValPags  WITH loc_nVlA
                ENDIF
            ENDSCAN
        ENDIF

        SELECT (loc_cCursor)
        GO TOP
        IF EOF()
            MsgAviso("N" + CHR(227) + "o Existem Dados Com os Crit" + CHR(233) + "rios Informados!" + CHR(13) + ;
                      "Verifique os Filtros e Realize Uma Nova Consulta!", "Dados N" + CHR(227) + "o Encontrados")
            RETURN .F.
        ENDIF

        SELECT (loc_cCursor)
        INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR (Nopers < 9999997) AND (SInis <> 1)
        INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR (Nopers < 9999997) AND (SInis <> 1)
        INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR (Nopers < 9999997) AND (SInis <> 1)
        INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR (Nopers < 9999997) AND (SInis <> 1)
        INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR (Nopers < 9999997) AND (SInis <> 1)
        INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR (Nopers < 9999997) AND (SInis <> 1)
        INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR (Nopers < 9999997) AND (SInis <> 1)
        INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR (Nopers < 9999997) AND (SInis <> 1)

        INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG DtEmis
        INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG Vencs
        INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG Datas
        INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG DtBaixa
        INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG Titulos
        INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG Hists
        INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG ContEms
        INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG Contas

        loc_oBO.this_cOrdem = "DtEmis"
        loc_oBO.this_nOrdem = 1
        THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.Value = 1

        THIS.MontarGradeDados()
        THIS.OrdenaGrade()

        THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value = loc_cRes
        THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Refresh()

        SELECT (loc_cCursor)
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMovimentoClick - equivalente ao Click de btnMovimento: identifica em
    * qual tabela a movimentacao do titulo esta registrada (ChkRegister nao
    * existe em BusinessBase - regra do CLAUDE.md - substituido por
    * SELECT COUNT(*)) e abre a tela legada correspondente via DO FORM.
    *--------------------------------------------------------------------------
    PROCEDURE BtnMovimentoClick()
        LOCAL loc_oBO, loc_cEmpDopNums, loc_nQtd, loc_cSQL

        loc_oBO = THIS.this_oBusinessObject

        IF loc_oBO.this_cLinTipos = "P" OR EMPTY(loc_oBO.this_nLinNopers)
            RETURN
        ENDIF

        loc_cEmpDopNums = PADR(loc_oBO.this_cLinEmps, 3) + PADR(loc_oBO.this_cLinDopes, 20) + STR(loc_oBO.this_nLinNumes, 6)

        *-- SigCdPgr (titulo em carteira de pagamento)
        loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdPgr WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
                   " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
                   " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
        loc_nQtd = 0
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPgr") > 0
            loc_nQtd = cursor_4c_ChkPgr.Nreg
            USE IN cursor_4c_ChkPgr
        ENDIF
        IF loc_nQtd > 0
            DO FORM SigCdPgr WITH LEFT(loc_oBO.this_cLinDopes, 1), .T., loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
            RETURN
        ENDIF

        *-- SigMvCab (movimento de estoque)
        loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums)
        loc_nQtd = 0
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCab") > 0
            loc_nQtd = cursor_4c_ChkMvCab.Nreg
            USE IN cursor_4c_ChkMvCab
        ENDIF
        IF loc_nQtd > 0
            IF WEXIST("FORM_")
                MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Consultar o Movimento" + CHR(13) + ;
                          "Existe Outra Movimenta" + CHR(231) + CHR(227) + "o Aberta!!!", "Movimento de Estoque Em Uso")
            ELSE
                DO FORM SigMvExp WITH loc_oBO.this_cLinDopes, "C", loc_oBO.this_nLinNumes, loc_oBO.this_cLinEmps, .T.
            ENDIF
            RETURN
        ENDIF

        *-- SigOpOpe (titulo vinculado a movimentacao de titulo bancario)
        IF !EMPTY(loc_oBO.this_cLinEmps) AND !EMPTY(loc_oBO.this_cLinDopes) AND !EMPTY(loc_oBO.this_nLinNumes)
            loc_cSQL = "SELECT NDopes, RealPrevs FROM SigOpOpe WHERE Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpOpe") < 1
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (cursor_4c_ChkOpOpe)")
                RETURN
            ENDIF
            IF !EOF("cursor_4c_ChkOpOpe")
                IF fChecaAcesso("C" + PADL(ALLTRIM(TRANSFORM(cursor_4c_ChkOpOpe.NDopes)), 8, "0"), "CONSULTAR")
                    DO FORM SigPgTit WITH loc_oBO.this_cLinDopes, "CONSULTAR", loc_oBO.this_cLinEmps, ;
                             STR(loc_oBO.this_nLinNumes, 6), (cursor_4c_ChkOpOpe.RealPrevs = 2)
                ELSE
                    MsgAviso("Usu" + CHR(225) + "rio N" + CHR(227) + "o Possui Acesso a Consultar T" + CHR(237) + "tulos!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
                ENDIF
                IF USED("cursor_4c_ChkOpOpe")
                    USE IN cursor_4c_ChkOpOpe
                ENDIF
                RETURN
            ENDIF
            IF USED("cursor_4c_ChkOpOpe")
                USE IN cursor_4c_ChkOpOpe
            ENDIF
        ENDIF

        *-- SigCqChm (cheque)
        loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCqChm WHERE Emps = " + EscaparSQL(LEFT(loc_oBO.this_cLinVOpers, 3)) + ;
                   " AND Numos = " + FormatarNumeroSQL(VAL(PADL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)), 9)), 0)
        loc_nQtd = 0
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkChm") > 0
            loc_nQtd = cursor_4c_ChkChm.Nreg
            USE IN cursor_4c_ChkChm
        ENDIF
        IF loc_nQtd > 0
            DO FORM SigCdLch WITH .T., LEFT(loc_oBO.this_cLinVOpers, 3), VAL(ALLTRIM(SUBSTR(loc_oBO.this_cLinVOpers, 4)))
            RETURN
        ENDIF

        *-- SigPrCtb (contabilizacao)
        loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigPrCtb WHERE Emps = " + EscaparSQL(loc_oBO.this_cLinEmps) + ;
                   " AND Dopes = " + EscaparSQL(loc_oBO.this_cLinDopes) + ;
                   " AND Numes = " + FormatarNumeroSQL(loc_oBO.this_nLinNumes, 0)
        loc_nQtd = 0
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCtb") > 0
            loc_nQtd = cursor_4c_ChkCtb.Nreg
            USE IN cursor_4c_ChkCtb
        ENDIF
        IF loc_nQtd > 0
            DO FORM SigCdPgb WITH loc_oBO.this_cLinEmps, loc_oBO.this_cLinDopes, loc_oBO.this_nLinNumes
            RETURN
        ENDIF

        *-- SigCdNec (necessidade de material vinculada ao movimento)
        loc_cSQL = "SELECT COUNT(*) AS Nreg FROM SigCdNec WHERE EmpDnPs = " + ;
                   EscaparSQL(loc_oBO.this_cLinEmps + loc_oBO.this_cLinDopes + STR(loc_oBO.this_nLinNumes, 10))
        loc_nQtd = 0
        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkNec") > 0
            loc_nQtd = cursor_4c_ChkNec.Nreg
            USE IN cursor_4c_ChkNec
        ENDIF
        IF loc_nQtd > 0
            DO FORM SigMvPdt WITH loc_oBO.this_cLinDopes, "C", loc_oBO.this_nLinNumes, loc_oBO.this_cLinEmps, .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnRecebeClick - equivalente ao Click de btnRecebe: busca o(s)
    * recebimento(s) do titulo corrente (SigCdPit/SigCdPgr/SigCdPbx) e, se
    * nao achar, cai no fallback de SigTtCcr - igual ao legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnRecebeClick()
        LOCAL loc_oBO, loc_cSQL

        loc_oBO = THIS.this_oBusinessObject

        loc_cSQL = "SELECT DISTINCT a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques " + ;
                   "FROM SigCdPit a, SigCdPgr b, SigCdPbx c " + ;
                   "WHERE a.Nopers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + ;
                   " AND a.EmpDopNums = b.EmpDopNums AND a.EmpDopNums = c.EmpDopNums " + ;
                   "ORDER BY a.Emps, a.Dopes, a.Numes, a.Nopers, b.DatarCs, a.Acertos, a.Moedas, c.Fpags, c.NCheques"

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 1)")
            RETURN
        ENDIF

        IF !EOF("cursor_4c_ConsPgt")
            IF USED("cursor_4c_ConsPgt")
                USE IN cursor_4c_ConsPgt
            ENDIF
            DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
            RETURN
        ENDIF
        IF USED("cursor_4c_ConsPgt")
            USE IN cursor_4c_ConsPgt
        ENDIF

        loc_cSQL = "SELECT Emps, Dopcs AS Dopes, Numcs AS Numes, Nopers, Datas AS DataRcs, 0 AS Acertos, " + ;
                   "'   ' AS Moedas, Dopcs AS Fpags, ' ' AS NCheques " + ;
                   "FROM SigTtCcr " + ;
                   "WHERE NOpers = " + FormatarNumeroSQL(loc_oBO.this_nLinNopers, 0) + " " + ;
                   "ORDER BY Emps, Dopcs, Numcs, Nopers, Datas"

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPgt") < 1
            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ConsPgt 2)")
            RETURN
        ENDIF

        IF !EOF("cursor_4c_ConsPgt")
            IF USED("cursor_4c_ConsPgt")
                USE IN cursor_4c_ConsPgt
            ENDIF
            DO FORM SIGTTPAG WITH THIS.DataSessionId, THIS
        ELSE
            IF USED("cursor_4c_ConsPgt")
                USE IN cursor_4c_ConsPgt
            ENDIF
            MsgAviso("Nenhum Recebimento Localizado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnFollowUpCClick/BtnFollowUpLClick - equivalentes aos Click de
    * btnFollowUpC/btnFollowUpL: abrem o follow-up da conta (so o emitente)
    * ou do lancamento (emitente + numero da operacao).
    *--------------------------------------------------------------------------
    PROCEDURE BtnFollowUpCClick()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        IF !EMPTY(loc_oBO.this_cLinContEms)
            DO FORM SigOpFlp WITH loc_oBO.this_cLinContEms, THIS.DataSessionId
        ENDIF
    ENDPROC

    PROCEDURE BtnFollowUpLClick()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        IF !EMPTY(loc_oBO.this_cLinContEms) AND !EMPTY(loc_oBO.this_nLinNopers)
            DO FORM SigOpFlp WITH loc_oBO.this_cLinContEms, THIS.DataSessionId, loc_oBO.this_nLinNopers
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick/BtnPlanilhaClick - delegam para Imprimir()/Planilha(),
    * igual ao Click original (ThisForm.Imprimir / ThisForm.Planilha).
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.Imprimir()
    ENDPROC

    PROCEDURE BtnPlanilhaClick()
        THIS.Planilha()
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - transcricao de ThisForm.Imprimir: monta um cursor reduzido
    * (equivalente a crMccr) com os campos do relatorio, indexa pela ordem
    * corrente e dispara REPORT FORM SigReCgf. O FRX legado nao foi portado
    * para o acervo (nao existe em nenhuma pasta do projeto) - o guard de
    * arquivo abaixo documenta essa pendencia em vez de falhar calado.
    *--------------------------------------------------------------------------
    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117)
    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
    *-- exibe MostrarErro descritivo com o path faltante.
    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
    *-- fontes em runtime e mostra asteriscos em campos numericos.
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- par_cCursorDados: opcional. Se informado e cursor estiver vazio,
    *--   mostra MsgAviso e retorna .F. sem abrir preview vazio.
    *-- ============================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        *-- Isolamento de locale + modo de renderizacao (Pattern #117 / Erro28)
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        *-- Restaurar menu (Erro63): REPORT FORM PREVIEW abre toolbar propria
        *-- que corrompe cache visual do _MSYSMENU. Sem RELEASE + Criar aqui,
        *-- popups renderizam encolhidos apos preview fechar. Mesmo fix do
        *-- FormBase.Destroy (Erro58) precisa rodar no path REPORT PREVIEW.
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    PROCEDURE Imprimir()
        LOCAL loc_cCursor, loc_cFrx, loc_cTit, loc_cSub, loc_cRes, loc_cFor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        IF USED("cursor_4c_RelFin")
            USE IN cursor_4c_RelFin
        ENDIF
        SELECT 9999999999 AS Ordem, Nopers, SPACE(1) AS Tipo, SaldoDia AS Saldos, SaldoTot AS SaldosP, Debitos, ;
               Creditos, SPACE(10) AS ContaCobs, Grupos, Contas, ContEms, OrdHs, Hists, Hist2s, NFs, Datas, ;
               Vencs, DtEmis, DtBaixa, Titulos, Moedas, SInis, SPACE(50) AS RClis ;
          FROM (loc_cCursor) ;
          INTO CURSOR cursor_4c_RelFin READWRITE

        SELECT cursor_4c_RelFin
        GO TOP
        IF EOF()
            MsgAviso("N" + CHR(227) + "o Foram Encontrados Dados Para Impress" + CHR(227) + "o!!!", "Impress" + CHR(227) + "o")
            USE IN cursor_4c_RelFin
            RETURN
        ENDIF

        loc_cTit = "Relat" + CHR(243) + "rio Financeiro"
        loc_cSub = PROPER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Filtros.Value)) + " - Ordem: " + ;
                   PROPER(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.List(THIS.pgf_4c_Paginas.Page2.cbo_4c_Ordem.ListIndex))
        loc_cRes = ALLTRIM(SUBSTR(ALLTRIM(THIS.pgf_4c_Paginas.Page2.obj_4c_GetFiltros.Value), 2))

        IF USED("cursor_4c_RelFinCab")
            USE IN cursor_4c_RelFinCab
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_RelFinCab (Titulo C(80), SubTitulo C(80), Moeda1 C(80), RodRelCC M(4))
        SET NULL OFF
        INSERT INTO cursor_4c_RelFinCab (Titulo, SubTitulo, RodRelCC) VALUES (loc_cTit, loc_cSub, loc_cRes)
        GO TOP IN cursor_4c_RelFinCab

        loc_cFor = IIF(THIS.pgf_4c_Paginas.Page2.chk_4c_Totais.Value = 1, "0=0", "(Nopers < 9999997) AND (SInis <> 1)")

        SELECT cursor_4c_RelFin
        DO CASE
        CASE THIS.this_oBusinessObject.this_cOrdem = "DtEmis"
            INDEX ON Moedas + DTOS(DtEmis)  + STR(Nopers, 10) TAG _DtEmis  FOR &loc_cFor.
        CASE THIS.this_oBusinessObject.this_cOrdem = "Vencs"
            INDEX ON Moedas + DTOS(Vencs)   + STR(Nopers, 10) TAG _Vencs   FOR &loc_cFor.
        CASE THIS.this_oBusinessObject.this_cOrdem = "Datas"
            INDEX ON Moedas + DTOS(Datas)   + STR(Nopers, 10) TAG _Datas   FOR &loc_cFor.
        CASE THIS.this_oBusinessObject.this_cOrdem = "DtBaixa"
            INDEX ON Moedas + DTOS(DtBaixa) + STR(Nopers, 10) TAG _DtBaixa FOR &loc_cFor.
        CASE THIS.this_oBusinessObject.this_cOrdem = "Titulos"
            INDEX ON Moedas + Titulos       + STR(Nopers, 10) TAG _Titulos FOR &loc_cFor.
        CASE THIS.this_oBusinessObject.this_cOrdem = "Hists"
            INDEX ON Moedas + OrdHs + Hists + STR(Nopers, 10) TAG _Hists   FOR &loc_cFor.
        CASE THIS.this_oBusinessObject.this_cOrdem = "ContEms"
            INDEX ON Moedas + ContEms       + STR(Nopers, 10) TAG _ContEms FOR &loc_cFor.
        CASE THIS.this_oBusinessObject.this_cOrdem = "Contas"
            INDEX ON Moedas + Contas        + STR(Nopers, 10) TAG _Contas  FOR &loc_cFor.
        ENDCASE

        SELECT cursor_4c_RelFin
        GO TOP

        IF !FILE(FULLPATH(loc_cFrx + ".frx"))
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + FULLPATH(loc_cFrx + ".frx"), "Erro")
        ELSE
            THIS.ExecutarReportForm("SigReCgf", "PREVIEW")
        ENDIF

        USE IN cursor_4c_RelFinCab
        USE IN cursor_4c_RelFin

        SELECT (loc_cCursor)
        GO TOP
    ENDPROC

    *--------------------------------------------------------------------------
    * Planilha - transcricao de ThisForm.Planilha: exporta cursor_4c_Dados
    * para XLS/TXT via PUTFILE + COPY TO, igual ao legado (fVerificaPasta/
    * fLimpaTexto ja portadas em utils/functions.prg).
    *--------------------------------------------------------------------------
    PROCEDURE Planilha()
        LOCAL loc_cCursor, loc_cArq, loc_cDeb, loc_cCrd

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        loc_cArq = PUTFILE("Nome da Planilha", "", "XLS;TXT")

        IF EMPTY(loc_cArq)
            RETURN
        ENDIF

        IF fVerificaPasta(loc_cArq, 2)
            loc_cDeb = fLimpaTexto(STRTRAN(PROPER("D" + CHR(233) + "bito"), " ", "_"))
            loc_cCrd = fLimpaTexto(STRTRAN(PROPER("Cr" + CHR(233) + "dito"), " ", "_"))

            IF USED("cursor_4c_RelExcel")
                USE IN cursor_4c_RelExcel
            ENDIF
            SELECT IIF((Nopers < 9999997) AND (SInis <> 1), SPACE(5), "TOTAL") AS Linhas, ;
                   TTOD(DtEmis) AS Emissao, TTOD(Vencs) AS Vencimento, TTOD(Datas) AS Lancamento, ;
                   TTOD(DtBaixa) AS Baixa, Titulos AS Titulo, NFs AS NF, TitBans AS Bancos, ;
                   EspecieNfs AS Especie, IIF(Pagos = "1", "Baixado ", "Pendente") AS Situacao, ;
                   Hists AS Historico, Hist2s AS Historico2, Moedas AS Moeda, Valors AS Valor, ;
                   Debitos AS Debito, Creditos AS Credito, SaldoDia AS Saldo, SaldoTot AS Acumulado, ;
                   GrupEms AS Grp_Emitente, ContEms AS Cta_Emitente, Grupos AS Grp_Portador, Contas AS Cta_Portador, ;
                   SGrupos AS Grp_CCusto, SContas AS Cta_CCusto, GrupAges AS Grp_Agente, ContAges AS Cta_Agente ;
              FROM (loc_cCursor) ;
              INTO CURSOR cursor_4c_RelExcel

            SELECT cursor_4c_RelExcel
            GO TOP

            IF LOWER(ALLTRIM(JUSTEXT(loc_cArq))) = "xls"
                COPY TO (loc_cArq) TYPE XLS
            ELSE
                COPY TO (loc_cArq) DELIMITED WITH "" WITH CHARACTER ";"
            ENDIF

            IF FILE(loc_cArq)
                MsgInfo("Planilha Gerada Com Sucesso!!!", "Gera" + CHR(231) + CHR(227) + "o de Planilha")
            ENDIF

            USE IN cursor_4c_RelExcel
        ELSE
            MsgAviso("Ocorreu Um Erro na Gera" + CHR(231) + CHR(227) + "o da Planilha, Verifique" + CHR(10) + ;
                      "O Diret" + CHR(243) + "rio Ou Se a Planilha Se Encontra Em Uso!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
        ENDIF

        SELECT (loc_cCursor)
        GO TOP
    ENDPROC

    *==========================================================================
    * FASE 8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
    *
    * Os metodos abaixo sao os FUNIS unicos das acoes que o legado espalha
    * entre os Click/When dos CommandGroups e o AfterRowColChange da grade.
    * NENHUM botao novo foi criado (PILAR 1 / "NUNCA inventar"): cada funil e
    * acionado pelo handler do controle que o SCX legado realmente tem.
    *
    *   BtnBuscarClick       <- cmgFiltros.Buttons(1) "Consultar"
    *   BtnCancelarClick     <- cmgRetornar (volta da Page2) e, na Page1,
    *                           cmgFiltros.Buttons(2) "Sair"
    *   BtnEncerrarClick     <- cmgFiltros.Buttons(2) "Sair" (ThisForm.Release)
    *   CarregarLista        <- repintura da grade de resultado (grdDados1)
    *   LimparCampos         <- bloco de limpeza do AfterRowColChange legado
    *   AjustarBotoesPorModo <- PROCEDURE When de btnMovimento / btnRecebe /
    *                           btnFollowUpC / btnFollowUpL / btnImprimir
    *   HabilitarCampos      <- PROCEDURE When "Return .f." dos campos de
    *                           exibicao da pgDados e "Return Empty(<codigo>)"
    *                           dos campos de descricao dos lookups da pgFiltros
    *   FormParaBO/BOParaForm<- transferencia dos filtros da pgFiltros para as
    *                           propriedades do BO e de volta
    *
    * Esta tela NAO tem botao de gravar: o SCX legado nao declara btnSalvar /
    * btnGravar nem mGravaDados - "Consulta Global Financeira" apura o
    * resultado so no cursor local (LocalDados) e os registros que ela abre
    * pertencem a outras entidades, cada uma com seu proprio BO (ver o
    * cabecalho de SIGOPCGFBO.prg). Por isso nao existe BtnSalvarClick aqui.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Acao principal da tela (cmgFiltros.Buttons(1),
    * "Consultar"): valida as faixas de data, executa a consulta e, so com
    * resultado, passa para a pagina de Dados. AlternarPagina(2) e quem
    * repinta a grade (ver CarregarLista).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF THIS.ValidarFiltrosData()
            IF THIS.Processamento()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Funil unico de "abandonar a pagina corrente", com o
    * comportamento que o legado da a cada pagina:
    *   Page2 (Dados)   -> volta para os Filtros   (cmgRetornar.Click)
    *   Page1 (Filtros) -> fecha o form            (cmgFiltros.Buttons(2))
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.AlternarPagina(1)
        ELSE
            THIS.BtnEncerrarClick()
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra a tela (ThisForm.Release do Click de
    * cmgFiltros.Buttons(2) "Sair"). FormBase.Destroy() cuida da liberacao do
    * BO e da restauracao dos popups do menu.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - FUNIL unico de repintura da grade de resultado.
    *
    * Processamento() popula cursor_4c_Dados e chama MontarGradeDados()/
    * OrdenaGrade() com a Page2 ainda OCULTA, e Refresh em pagina oculta NAO
    * pinta (regra #21/#46 do CLAUDE.md) - por isso AlternarPagina(2) chama
    * este metodo DEPOIS de trocar o ActivePage.
    *
    * Tambem sincroniza os campos de detalhe e os botoes de acao com a linha
    * corrente: a PRIMEIRA linha exibida nunca dispara AfterRowColChange, e
    * sem isso ela ficaria com os campos/botoes da consulta anterior.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_cCursor, loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF !USED(loc_cCursor)
            RETURN .F.
        ENDIF

        SELECT (loc_cCursor)
        GO TOP
        THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()

        IF EOF(loc_cCursor)
            THIS.LimparCampos()
            THIS.AjustarBotoesPorModo()
        ELSE
            THIS.GrdDadosAfterRowColChange(1)
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Reproduz os PROCEDURE When dos botoes de acao da
    * pgDados, que no legado sao reavaliados a cada troca de linha:
    *
    *   btnMovimento / btnRecebe / btnFollowUpC / btnFollowUpL
    *       Return (LocalDados.Nopers < 9999998) And (LocalDados.SInis = 0)
    *   btnImprimir
    *       Return (LocalDados.Nopers < 9999998) And (LocalDados.SInis = 0) ;
    *              Or InList(ThisForm.Ordem, [ContEms], [Contas])
    *
    * Sem linha corrente (cursor vazio) os When do legado leem um registro
    * que nao existe - aqui isso equivale a desabilitar as acoes.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPag, loc_oBO, loc_cCursor, loc_lHabilita

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_oBO     = THIS.this_oBusinessObject
        loc_oPag    = THIS.pgf_4c_Paginas.Page2
        loc_cCursor = loc_oBO.this_cCursorDados

        IF !USED(loc_cCursor) OR EOF(loc_cCursor)
            loc_lHabilita = .F.
        ELSE
            loc_lHabilita = (loc_oBO.this_nLinNopers < 9999998) AND (loc_oBO.this_nLinSInis = 0)
        ENDIF

        loc_oPag.cmd_4c_BtnMovimento.Enabled = loc_lHabilita
        loc_oPag.cmd_4c_BtnRecebe.Enabled    = loc_lHabilita
        loc_oPag.cmd_4c_BtnFollowUpC.Enabled = loc_lHabilita
        loc_oPag.cmd_4c_BtnFollowUpL.Enabled = loc_lHabilita

        *-- O When do Imprimir tambem libera quando a ordem corrente e por
        *-- Emitente/Portador (saldo por conta), mesmo em linha sintetica.
        loc_oPag.cmd_4c_BtnImprimir.Enabled = loc_lHabilita OR ;
            INLIST(loc_oBO.this_cOrdem, "ContEms", "Contas")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Bloco de limpeza que o legado executa no inicio do
    * AfterRowColChange de grdDados1: zera os campos de detalhe da pgDados e
    * os quatro indicadores de status (Botao1..Botao4).
    *
    * O legado limpa SEMPRE as 4 descricoes (getDContEms/getDContas/
    * getDSContas/getDContAges) e, SO quando a linha e sintetica (llTot), os
    * outros 14 campos; como o ramo "If Not llTot" reatribui TODOS os 18,
    * limpar os 18 de uma vez produz o MESMO resultado nos dois caminhos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag

        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page2

        loc_oPag.txt_4c_DContEms.Value   = ""
        loc_oPag.txt_4c_DContas.Value    = ""
        loc_oPag.txt_4c_DSContas.Value   = ""
        loc_oPag.txt_4c_DContAges.Value  = ""

        loc_oPag.txt_4c_NFs.Value        = ""
        loc_oPag.txt_4c_TitBans.Value    = ""
        loc_oPag.txt_4c_EspecieNfs.Value = ""
        loc_oPag.txt_4c_Hist2s.Value     = ""
        loc_oPag.txt_4c_Emps.Value       = ""
        loc_oPag.txt_4c_ValOcurs.Value   = 0
        loc_oPag.txt_4c_GrupEms.Value    = ""
        loc_oPag.txt_4c_ContEms.Value    = ""
        loc_oPag.txt_4c_Grupo.Value      = ""
        loc_oPag.txt_4c_Contas.Value     = ""
        loc_oPag.txt_4c_SGrupos.Value    = ""
        loc_oPag.txt_4c_SContas.Value    = ""
        loc_oPag.txt_4c_GrupAges.Value   = ""
        loc_oPag.txt_4c_ContAges.Value   = ""

        loc_oPag.cnt_4c_Botoes.txt_4c_Botao1.Value = ""
        loc_oPag.cnt_4c_Botoes.txt_4c_Botao2.Value = ""
        loc_oPag.cnt_4c_Botoes.txt_4c_Botao3.Value = ""
        loc_oPag.cnt_4c_Botoes.txt_4c_Botao4.Value = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Aplica, num lugar so, o contrato de digitacao que o
    * legado expressa nos PROCEDURE When de cada campo:
    *
    *   pgDados : TODOS os campos de detalhe declaram "Return .f." no SCX, ou
    *             seja sao SOMENTE EXIBICAO. UNICA excecao fiel: getContEms,
    *             que NAO declara When e por isso continua focavel.
    *   pgFiltros: os campos de DESCRICAO dos lookups declaram
    *             "Return Empty(This.Parent.get<Codigo>.Value)" - a descricao
    *             so aceita digitacao enquanto o CODIGO esta vazio.
    *
    * par_lHabilitar = .T. na pagina de Filtros (filtros digitaveis) e .F. na
    * pagina de Dados (nada a digitar). Chamado pelo funil AlternarPagina().
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag1, loc_oPag2, loc_lFiltros

        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF

        loc_lFiltros = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        loc_oPag1    = THIS.pgf_4c_Paginas.Page1
        loc_oPag2    = THIS.pgf_4c_Paginas.Page2

        *-- pgFiltros: campos de filtro digitaveis
        loc_oPag1.txt_4c_DtEmiI.ReadOnly     = !loc_lFiltros
        loc_oPag1.txt_4c_DtEmiF.ReadOnly     = !loc_lFiltros
        loc_oPag1.txt_4c_VencsI.ReadOnly     = !loc_lFiltros
        loc_oPag1.txt_4c_VencsF.ReadOnly     = !loc_lFiltros
        loc_oPag1.txt_4c_DatasI.ReadOnly     = !loc_lFiltros
        loc_oPag1.txt_4c_DatasF.ReadOnly     = !loc_lFiltros
        loc_oPag1.txt_4c_DtBxI.ReadOnly      = !loc_lFiltros
        loc_oPag1.txt_4c_DtBxF.ReadOnly      = !loc_lFiltros
        loc_oPag1.txt_4c_Titulos.ReadOnly    = !loc_lFiltros
        loc_oPag1.txt_4c_TitBans.ReadOnly    = !loc_lFiltros
        loc_oPag1.txt_4c_EspecieNfs.ReadOnly = !loc_lFiltros
        loc_oPag1.txt_4c_NFs.ReadOnly        = !loc_lFiltros
        loc_oPag1.txt_4c_CMoes.ReadOnly      = !loc_lFiltros
        loc_oPag1.txt_4c_CMoesC.ReadOnly     = !loc_lFiltros
        loc_oPag1.txt_4c_MoeSaldo.ReadOnly   = !loc_lFiltros
        loc_oPag1.txt_4c_Saldo.ReadOnly      = !loc_lFiltros
        loc_oPag1.txt_4c_CFPublis.ReadOnly   = !loc_lFiltros
        loc_oPag1.txt_4c_Empresa.ReadOnly    = !loc_lFiltros
        loc_oPag1.txt_4c_Filtros.ReadOnly    = !loc_lFiltros
        loc_oPag1.txt_4c_NewFiltro.ReadOnly  = !loc_lFiltros

        *-- pgFiltros: When "Return Empty(<codigo>)" dos campos de descricao
        loc_oPag1.txt_4c_DMoes.ReadOnly    = !loc_lFiltros OR !EMPTY(loc_oPag1.txt_4c_CMoes.Value)
        loc_oPag1.txt_4c_DMoesC.ReadOnly   = !loc_lFiltros OR !EMPTY(loc_oPag1.txt_4c_CMoesC.Value)
        loc_oPag1.txt_4c_DFPublis.ReadOnly = !loc_lFiltros OR !EMPTY(loc_oPag1.txt_4c_CFPublis.Value)

        *-- pgDados: "Return .f." em todo campo de detalhe (somente exibicao).
        *-- txt_4c_ContEms fica FORA desta lista de proposito - getContEms e o
        *-- unico campo da pgDados que nao declara When no SCX legado.
        loc_oPag2.txt_4c_NFs.ReadOnly        = .T.
        loc_oPag2.txt_4c_EspecieNfs.ReadOnly = .T.
        loc_oPag2.txt_4c_Emps.ReadOnly       = .T.
        loc_oPag2.txt_4c_DContEms.ReadOnly   = .T.
        loc_oPag2.txt_4c_Contas.ReadOnly     = .T.
        loc_oPag2.txt_4c_DContas.ReadOnly    = .T.
        loc_oPag2.txt_4c_GrupEms.ReadOnly    = .T.
        loc_oPag2.txt_4c_Grupo.ReadOnly      = .T.
        loc_oPag2.txt_4c_SGrupos.ReadOnly    = .T.
        loc_oPag2.txt_4c_SContas.ReadOnly    = .T.
        loc_oPag2.txt_4c_DSContas.ReadOnly   = .T.
        loc_oPag2.txt_4c_GrupAges.ReadOnly   = .T.
        loc_oPag2.txt_4c_ContAges.ReadOnly   = .T.
        loc_oPag2.txt_4c_DContAges.ReadOnly  = .T.
        loc_oPag2.txt_4c_Hist2s.ReadOnly     = .T.
        loc_oPag2.txt_4c_TitBans.ReadOnly    = .T.
        loc_oPag2.txt_4c_ValOcurs.ReadOnly   = .T.

        loc_oPag2.cnt_4c_Botoes.txt_4c_Botao1.ReadOnly = .T.
        loc_oPag2.cnt_4c_Botoes.txt_4c_Botao2.ReadOnly = .T.
        loc_oPag2.cnt_4c_Botoes.txt_4c_Botao3.ReadOnly = .T.
        loc_oPag2.cnt_4c_Botoes.txt_4c_Botao4.ReadOnly = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Espelha TODOS os filtros da tela nas propriedades do
    * Business Object. E a fonte unica de leitura dos controles de filtro:
    * chamado por Processamento() (antes de montar a consulta), por
    * SerializarFiltros() (gravacao do filtro nomeado em SigSyPar) e por
    * RestaurarFiltros() (para preservar o que nao esta no blob salvo).
    *
    * Conversoes explicitas obrigatorias: CheckBox.Value e NUMERICO (0/1) e
    * nao pode ser atribuido direto a property LOGICA; OptionGroup.Value e o
    * INDICE 1-based e vai para property NUMERICA; o TextBox de valor pode
    * trazer CARACTERE conforme o InputMask, dai o VARTYPE antes de usar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag1, loc_oPag2, loc_oBO, loc_xSaldo

        IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN .F.
        ENDIF

        loc_oBO   = THIS.this_oBusinessObject
        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *-- Faixas de data (ConverterParaData normaliza DATE/DATETIME/CHAR)
        loc_oBO.this_dDtEmiI = ConverterParaData(loc_oPag1.txt_4c_DtEmiI.Value)
        loc_oBO.this_dDtEmiF = ConverterParaData(loc_oPag1.txt_4c_DtEmiF.Value)
        loc_oBO.this_dVencsI = ConverterParaData(loc_oPag1.txt_4c_VencsI.Value)
        loc_oBO.this_dVencsF = ConverterParaData(loc_oPag1.txt_4c_VencsF.Value)
        loc_oBO.this_dDatasI = ConverterParaData(loc_oPag1.txt_4c_DatasI.Value)
        loc_oBO.this_dDatasF = ConverterParaData(loc_oPag1.txt_4c_DatasF.Value)
        loc_oBO.this_dDtBxI  = ConverterParaData(loc_oPag1.txt_4c_DtBxI.Value)
        loc_oBO.this_dDtBxF  = ConverterParaData(loc_oPag1.txt_4c_DtBxF.Value)

        *-- Titulo / Titulo Banco / Especie / Nota Fiscal
        loc_oBO.this_cTitulos    = ALLTRIM(loc_oPag1.txt_4c_Titulos.Value)
        loc_oBO.this_cTitBans    = ALLTRIM(loc_oPag1.txt_4c_TitBans.Value)
        loc_oBO.this_cEspecieNfs = ALLTRIM(loc_oPag1.txt_4c_EspecieNfs.Value)
        loc_oBO.this_cNFs        = ALLTRIM(loc_oPag1.txt_4c_NFs.Value)

        *-- Moeda de filtro / de conversao / do saldo inicial
        loc_oBO.this_cCMoes    = ALLTRIM(loc_oPag1.txt_4c_CMoes.Value)
        loc_oBO.this_cDMoes    = ALLTRIM(loc_oPag1.txt_4c_DMoes.Value)
        loc_oBO.this_cCMoesC   = ALLTRIM(loc_oPag1.txt_4c_CMoesC.Value)
        loc_oBO.this_cDMoesC   = ALLTRIM(loc_oPag1.txt_4c_DMoesC.Value)
        loc_oBO.this_cMoeSaldo = ALLTRIM(loc_oPag1.txt_4c_MoeSaldo.Value)

        loc_xSaldo          = loc_oPag1.txt_4c_Saldo.Value
        loc_oBO.this_nSaldo = IIF(VARTYPE(loc_xSaldo) = "N", loc_xSaldo, VAL(TRANSFORM(loc_xSaldo)))

        *-- Forma de Publicidade / Empresa
        loc_oBO.this_cCFPublis = ALLTRIM(loc_oPag1.txt_4c_CFPublis.Value)
        loc_oBO.this_cDFPublis = ALLTRIM(loc_oPag1.txt_4c_DFPublis.Value)
        loc_oBO.this_cEmpresa  = ALLTRIM(loc_oPag1.txt_4c_Empresa.Value)

        *-- CheckBox.Value e NUMERICO - converter antes de ir para property logica
        loc_oBO.this_lBrancos  = (loc_oPag1.chk_4c_Brancos.Value = 1)
        loc_oBO.this_lValPends = (loc_oPag1.chk_4c_ValPends.Value = 1)
        loc_oBO.this_lTotais   = (loc_oPag2.chk_4c_Totais.Value = 1)

        *-- OptionGroup.Value e o INDICE 1-based do botao selecionado
        loc_oBO.this_nPagos    = loc_oPag1.opt_4c_Pagos.Value
        loc_oBO.this_nOpcao    = loc_oPag1.opt_4c_Opcao.Value
        loc_oBO.this_nCotEm    = loc_oPag1.opt_4c_CotEm.Value
        loc_oBO.this_nCancs    = loc_oPag1.opt_4c_Cancs.Value
        loc_oBO.this_nConcs    = loc_oPag1.opt_4c_Concs.Value
        loc_oBO.this_nProrrogs = loc_oPag1.opt_4c_Prorrogs.Value
        loc_oBO.this_nFilGrd2  = loc_oPag1.opt_4c_FilGrd2.Value

        *-- Filtro nomeado (SigSyPar) e ordem corrente da grade.
        *-- this_cOrdem NAO e escrito aqui: a fonte unica dele e
        *-- CboOrdemInteractiveChange(), que traduz o indice do combo no nome
        *-- da coluna usada pelo SET ORDER TO TAG.
        loc_oBO.this_cFiltros   = ALLTRIM(loc_oPag1.txt_4c_Filtros.Value)
        loc_oBO.this_cNewFiltro = ALLTRIM(loc_oPag1.txt_4c_NewFiltro.Value)
        loc_oBO.this_nOrdem     = loc_oPag2.cbo_4c_Ordem.Value

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Caminho inverso de FormParaBO: repoe na tela os filtros
    * guardados nas propriedades do BO. Usado por RestaurarFiltros() ao
    * carregar um filtro nomeado de SigSyPar.
    *
    * OptionGroup/ComboBox sao 1-based: o valor e sempre validado com BETWEEN
    * para nunca atribuir 0 a um controle de indice (regra dos controles
    * 1-based do CLAUDE.md). CheckBox recebe NUMERICO (1/0), nunca .T./.F.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag1, loc_oPag2, loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN .F.
        ENDIF

        loc_oBO   = THIS.this_oBusinessObject
        loc_oPag1 = THIS.pgf_4c_Paginas.Page1
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        loc_oPag1.txt_4c_DtEmiI.Value = ConverterParaData(loc_oBO.this_dDtEmiI)
        loc_oPag1.txt_4c_DtEmiF.Value = ConverterParaData(loc_oBO.this_dDtEmiF)
        loc_oPag1.txt_4c_VencsI.Value = ConverterParaData(loc_oBO.this_dVencsI)
        loc_oPag1.txt_4c_VencsF.Value = ConverterParaData(loc_oBO.this_dVencsF)
        loc_oPag1.txt_4c_DatasI.Value = ConverterParaData(loc_oBO.this_dDatasI)
        loc_oPag1.txt_4c_DatasF.Value = ConverterParaData(loc_oBO.this_dDatasF)
        loc_oPag1.txt_4c_DtBxI.Value  = ConverterParaData(loc_oBO.this_dDtBxI)
        loc_oPag1.txt_4c_DtBxF.Value  = ConverterParaData(loc_oBO.this_dDtBxF)

        loc_oPag1.txt_4c_Titulos.Value    = loc_oBO.this_cTitulos
        loc_oPag1.txt_4c_TitBans.Value    = loc_oBO.this_cTitBans
        loc_oPag1.txt_4c_EspecieNfs.Value = loc_oBO.this_cEspecieNfs
        loc_oPag1.txt_4c_NFs.Value        = loc_oBO.this_cNFs

        loc_oPag1.txt_4c_CMoes.Value    = loc_oBO.this_cCMoes
        loc_oPag1.txt_4c_DMoes.Value    = loc_oBO.this_cDMoes
        loc_oPag1.txt_4c_CMoesC.Value   = loc_oBO.this_cCMoesC
        loc_oPag1.txt_4c_DMoesC.Value   = loc_oBO.this_cDMoesC
        loc_oPag1.txt_4c_MoeSaldo.Value = loc_oBO.this_cMoeSaldo
        loc_oPag1.txt_4c_Saldo.Value    = loc_oBO.this_nSaldo

        loc_oPag1.txt_4c_CFPublis.Value = loc_oBO.this_cCFPublis
        loc_oPag1.txt_4c_DFPublis.Value = loc_oBO.this_cDFPublis
        loc_oPag1.txt_4c_Empresa.Value  = loc_oBO.this_cEmpresa

        loc_oPag1.chk_4c_Brancos.Value  = IIF(loc_oBO.this_lBrancos, 1, 0)
        loc_oPag1.chk_4c_ValPends.Value = IIF(loc_oBO.this_lValPends, 1, 0)
        loc_oPag2.chk_4c_Totais.Value   = IIF(loc_oBO.this_lTotais, 1, 0)

        loc_oPag1.opt_4c_Pagos.Value    = IIF(BETWEEN(loc_oBO.this_nPagos, 1, 3), loc_oBO.this_nPagos, 1)
        loc_oPag1.opt_4c_Opcao.Value    = IIF(BETWEEN(loc_oBO.this_nOpcao, 1, 3), loc_oBO.this_nOpcao, 1)
        loc_oPag1.opt_4c_CotEm.Value    = IIF(BETWEEN(loc_oBO.this_nCotEm, 1, 5), loc_oBO.this_nCotEm, 1)
        loc_oPag1.opt_4c_Cancs.Value    = IIF(BETWEEN(loc_oBO.this_nCancs, 1, 3), loc_oBO.this_nCancs, 1)
        loc_oPag1.opt_4c_Concs.Value    = IIF(BETWEEN(loc_oBO.this_nConcs, 1, 3), loc_oBO.this_nConcs, 1)
        loc_oPag1.opt_4c_Prorrogs.Value = IIF(BETWEEN(loc_oBO.this_nProrrogs, 1, 3), loc_oBO.this_nProrrogs, 1)
        loc_oPag1.opt_4c_FilGrd2.Value  = IIF(BETWEEN(loc_oBO.this_nFilGrd2, 1, 2), loc_oBO.this_nFilGrd2, 1)

        loc_oPag1.txt_4c_Filtros.Value   = loc_oBO.this_cFiltros
        loc_oPag1.txt_4c_NewFiltro.Value = loc_oBO.this_cNewFiltro
        loc_oPag2.cbo_4c_Ordem.Value     = IIF(BETWEEN(loc_oBO.this_nOrdem, 1, 8), loc_oBO.this_nOrdem, 1)

        *-- O When "Return Empty(<codigo>)" dos campos de descricao depende do
        *-- codigo que acabou de ser reposto - reavaliar o contrato.
        THIS.HabilitarCampos(THIS.pgf_4c_Paginas.ActivePage = 1)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - FormBase.Destroy() cuida da liberacao do BusinessObject e da
    * restauracao dos popups do menu (Erro58). DODEFAULT() SEMPRE por ultimo.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
