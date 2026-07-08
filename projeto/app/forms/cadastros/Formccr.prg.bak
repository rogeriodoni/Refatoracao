*==============================================================================
* Formccr.prg - Formulario de Cadastro de Grupos de Contas Corrente
* Data: 2026-04-14
* Tabela: SigCdGcr | PK: Codigos
* Legado: SIGCDCCR.SCX (frmcadastro)
* FASE 9 - Completo (Fases 3-9 concluidas)
*   Page1 (Lista): Header, botoes CRUD, grid 5 colunas
*   Page2 (Dados): Identificacao + inner PageFrame 4 abas
*   4 abas: Geral / Cadastro / Estoque+Industria / Faturamento+Fiscal
*   Lookups: Classes(SigCdCss), Situas(SigCdCst), Moeda(SigCdMoe),
*            GrupoGeral/GrupoEst/GrupoFalha/ContaFalha/ContaPdr/Contint(SigCdGcr)
*            Fiscal CdGrupos/CdContas (9 containers: ICMS/IPI/II/ISS/IRRF/INSS/PIS/CSSL/COFINS)
*   FASE 7: BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick completos
*           HabilitarCampos completo, visibilidade TpCods/TpEmps/Digito
*   FASE 8: Menu e config integration
*   FASE 9: LostFocus/GotFocus handlers fiscais, AtualizarEstadoFiscal (When logic),
*           estados Enabled corretos para CdContas/DsContas/PctAliqs/Receitas
*==============================================================================

DEFINE CLASS Formccr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Grupos de Contas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *-- Guardias LostFocus (evitar revalidacao duplicada)
    this_cUltClasses     = ""    && Ultimo classes validado (SigCdCss)
    this_cUltGrupoGeral  = ""    && Ultimo Get_grupo(Geral) validado
    this_cUltGrupoEst    = ""    && Ultimo Get_grupo(Est) validado
    this_cUltContint     = ""    && Ultimo contint validado
    this_cUltSituas      = ""    && Ultimo situas validado
    this_cUltContaFalha  = ""    && Ultimo GetContaFalha validado
    this_cUltGrupoFalha  = ""    && Ultimo GetGrupoFalha validado
    this_cUltContaPdr    = ""    && Ultimo getContaPdr validado
    this_cUltCdMoeda     = ""    && Ultimo get_cd_moeda validado
    this_oFiscalCntAtivo = .NULL.  && Container fiscal ativo (rastreado via GotFocus)

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial (chamado por FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ccrBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object ccrBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formccr:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame externo (Page1=Lista, Page2=Dados)
    * Top=-29 oculta abas, Width=1003 cobre toda a forma
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, saida, grid
    * Compensacao +29 aplicada (Top_original + 29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (Top=31, Width=1020, Height=80)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Grupos de Contas Corrente"
            .Top       = 20
            .Left      = 20
            .Width     = 400
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Left=542, Top=29, Width=400, Height=85)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 400
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Incluir (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Visualizar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 230
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 305
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container saida (Left=917, Top=29, Width=90, Height=85)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container filtros (Left=5, Top=29, vazio - busca via BtnBuscarClick)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 29
            .Left        = 5
            .Width       = 530
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Grid de lista (Top=121, Left=11, Width=938, Height=470)
        *-- 5 colunas: Codigos/Descrs/Internos/TpCods/DClasses
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top               = 121
            .Left              = 11
            .Width             = 938
            .Height            = 470
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .GridLines         = 3
            .ColumnCount       = 5
            .AllowHeaderSizing = .T.
            .Visible           = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: identificacao + inner PageFrame 4 abas
    * Compensacao +29 aplicada nos Tops
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Botoes Salvar/Cancelar (Top=38, Left=819, Width=165, Height=85)
        loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oPagina.cnt_4c_BotoesDados
            .Top         = 38
            .Left        = 819
            .Width       = 165
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 7
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 83
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        *-- ROW 1: Codigos | Descrs | Internos (Top=38)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_LblCodigos", "Label")
        WITH loc_oPagina.lbl_4c_LblCodigos
            .Caption   = "C" + CHR(243) + "digo :"
            .Left      = 5
            .Top       = 43
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value         = ""
            .Left          = 57
            .Top           = 38
            .Width         = 65
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 10
            .InputMask     = "XXXXXXXXXX"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
        WITH loc_oPagina.lbl_4c_LblDescrs
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Left      = 130
            .Top       = 43
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Value         = ""
            .Left          = 198
            .Top           = 38
            .Width         = 250
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 40
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblInterno", "Label")
        WITH loc_oPagina.lbl_4c_LblInterno
            .Caption   = "Interno :"
            .Left      = 456
            .Top       = 43
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Interno", "TextBox")
        WITH loc_oPagina.txt_4c_Interno
            .Value         = ""
            .Left          = 514
            .Top           = 38
            .Width         = 100
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 2: TpCods | Digito | Classes | DClasses | ChkLimCrds | ChkLimEsts (Top=68)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_LblTpCods", "Label")
        WITH loc_oPagina.lbl_4c_LblTpCods
            .Caption   = "Tipo :"
            .Left      = 5
            .Top       = 73
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- opt_4c_TpCods: 1=Empresa, 2=C/C
        loc_oPagina.AddObject("opt_4c_TpCods", "OptionGroup")
        WITH loc_oPagina.opt_4c_TpCods
            .ButtonCount  = 2
            .Left         = 48
            .Top          = 68
            .Width        = 130
            .Height       = 24
            .BorderStyle  = 0
            .Value        = 1
            .Visible      = .T.
            .Buttons(1).Caption  = "Empresa"
            .Buttons(1).Width    = 65
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "C/C"
            .Buttons(2).Width    = 55
            .Buttons(2).Left     = 65
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_TpCods, "InteractiveChange", THIS, "opt_4c_TpCods_InteractiveChange")

        *-- Digito (visivel somente quando TpCods=1)
        loc_oPagina.AddObject("lbl_4c_LblDigito", "Label")
        WITH loc_oPagina.lbl_4c_LblDigito
            .Caption   = "D" + CHR(237) + "gito :"
            .Left      = 183
            .Top       = 73
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Digito", "TextBox")
        WITH loc_oPagina.txt_4c_Digito
            .Value         = ""
            .Left          = 236
            .Top           = 68
            .Width         = 25
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        *-- Classes (lookup SigCdCss via F4/LostFocus)
        loc_oPagina.AddObject("lbl_4c_LblClasses", "Label")
        WITH loc_oPagina.lbl_4c_LblClasses
            .Caption   = "Classe :"
            .Left      = 267
            .Top       = 73
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Classes", "TextBox")
        WITH loc_oPagina.txt_4c_Classes
            .Value         = ""
            .Left          = 318
            .Top           = 68
            .Width         = 70
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Classes, "KeyPress", THIS, "txt_4c_Classes_KeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Classes, "KeyPress", THIS, "txt_4c_Classes_LostFocus")

        *-- DClasses (display-only, derivado do lookup)
        loc_oPagina.AddObject("txt_4c_DClasses", "TextBox")
        WITH loc_oPagina.txt_4c_DClasses
            .Value         = ""
            .Left          = 394
            .Top           = 68
            .Width         = 185
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- chk_4c_LimCrds - Verif. Limite Credito (chklimcrds N(1,0))
        loc_oPagina.AddObject("chk_4c_LimCrds", "CheckBox")
        WITH loc_oPagina.chk_4c_LimCrds
            .Caption   = "Verif. Limite Cr" + CHR(233) + "d."
            .Left      = 585
            .Top       = 68
            .Width     = 105
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- chk_4c_LimEsts - Verif. Limite Estoque (chklimests N(1,0))
        loc_oPagina.AddObject("chk_4c_LimEsts", "CheckBox")
        WITH loc_oPagina.chk_4c_LimEsts
            .Caption   = "Verif. Limite Est."
            .Left      = 695
            .Top       = 68
            .Width     = 115
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- ROW 2B: TpEmps (visivel somente TpCods=1) e TpCads (sempre visivel)
        *-- TpEmps: Left=353, Top=68 | TpCads: Left=5, Top=93
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_TpEmps", "Label")
        WITH loc_oPagina.lbl_4c_TpEmps
            .Caption   = "Incl. Empresa :"
            .Left      = 353
            .Top       = 73
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.  && controlado por TpCods
        ENDWITH

        loc_oPagina.AddObject("opt_4c_TpEmps", "OptionGroup")
        WITH loc_oPagina.opt_4c_TpEmps
            .ButtonCount  = 2
            .Left         = 447
            .Top          = 68
            .Width        = 98
            .Height       = 23
            .BorderStyle  = 0
            .Value        = 1
            .Visible      = .T.  && controlado por TpCods
            .Buttons(1).Caption  = "Sim"
            .Buttons(1).Width    = 49
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "N" + CHR(227) + "o"
            .Buttons(2).Width    = 49
            .Buttons(2).Left     = 49
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_TpCads", "Label")
        WITH loc_oPagina.lbl_4c_TpCads
            .Caption   = "Tp.Cad. :"
            .Left      = 5
            .Top       = 98
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_TpCads", "OptionGroup")
        WITH loc_oPagina.opt_4c_TpCads
            .ButtonCount  = 2
            .Left         = 63
            .Top          = 93
            .Width        = 150
            .Height       = 23
            .BorderStyle  = 0
            .Value        = 1
            .Visible      = .T.
            .Buttons(1).Caption  = "Empresa"
            .Buttons(1).Width    = 75
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "C/C"
            .Buttons(2).Width    = 75
            .Buttons(2).Left     = 75
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Inner PageFrame - 4 abas (Geral, Cadastro, Estoque, Faturamento)
        *-- (Top=120, Left=5, Width=985, Height=447)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("pgf_4c_AbaDados", "PageFrame")
        WITH loc_oPagina.pgf_4c_AbaDados
            .Top       = 120
            .Left      = 5
            .Width     = 985
            .Height    = 447
            .PageCount = 4
            .Tabs      = .T.
            .Visible   = .T.

            .Page1.Caption = "Geral"
            .Page2.Caption = "Cadastro"
            .Page3.Caption = "Estoque"
            .Page4.Caption = "Faturamento"
        ENDWITH

        THIS.ConfigurarAbaGeral()
        THIS.ConfigurarAbaCadastro()
        THIS.ConfigurarAbaEstoque()
        THIS.ConfigurarAbaFaturamento()

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarLabel - Helper: adiciona Label padrao ao container
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarLabel(par_oParent, par_cNome, par_cCaption, par_nLeft, par_nTop, par_nWidth)
        par_oParent.AddObject(par_cNome, "Label")
        WITH par_oParent.Controls(par_oParent.ControlCount)
            .Caption   = par_cCaption
            .Left      = par_nLeft
            .Top       = par_nTop
            .Width     = par_nWidth
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarOptSimNao - Helper: adiciona OptionGroup 2-botoes Sim/Nao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarOptSimNao(par_oParent, par_cNome, par_nLeft, par_nTop, par_nWidth, par_nDefault)
        LOCAL loc_nBtnW
        loc_nBtnW = INT(par_nWidth / 2)
        par_oParent.AddObject(par_cNome, "OptionGroup")
        WITH par_oParent.Controls(par_oParent.ControlCount)
            .ButtonCount  = 2
            .Left         = par_nLeft
            .Top          = par_nTop
            .Width        = par_nWidth
            .Height       = 23
            .BorderStyle  = 0
            .BackStyle    = 0
            .Value        = par_nDefault
            .Buttons(1).Caption  = "Sim"
            .Buttons(1).Width    = loc_nBtnW
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).FontName = "Tahoma"
            .Buttons(1).FontSize = 8
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "N" + CHR(227) + "o"
            .Buttons(2).Width    = par_nWidth - loc_nBtnW
            .Buttons(2).Left     = loc_nBtnW
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).FontName = "Tahoma"
            .Buttons(2).FontSize = 8
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarContainerFiscal - Helper: container com 5 campos fiscais
    * Estrutura: lbl_4c_TaxNome, txt_4c_CdGrupos, txt_4c_CdContas,
    *            txt_4c_DsContas(disabled), txt_4c_PctAliqs, txt_4c_Receitas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarContainerFiscal(par_oAba, par_cNome, par_cLabel, par_nTop)
        LOCAL loc_oCnt
        par_oAba.AddObject(par_cNome, "Container")
        loc_oCnt = par_oAba.Controls(par_oAba.ControlCount)
        WITH loc_oCnt
            .Top         = par_nTop
            .Left        = 18
            .Width       = 673
            .Height      = 25
            .BackStyle   = 0
            .BorderWidth = 0
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_TaxNome", "Label")
        WITH loc_oCnt.lbl_4c_TaxNome
            .Caption   = par_cLabel
            .Left      = 10
            .Top       = 5
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CdGrupos", "TextBox")
        WITH loc_oCnt.txt_4c_CdGrupos
            .Value         = ""
            .Left          = 66
            .Top           = 2
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CdContas", "TextBox")
        WITH loc_oCnt.txt_4c_CdContas
            .Value         = ""
            .Left          = 155
            .Top           = 2
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
            .Enabled       = .F.  && When: CdGrupos nao vazio
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DsContas", "TextBox")
        WITH loc_oCnt.txt_4c_DsContas
            .Value         = ""
            .Left          = 237
            .Top           = 2
            .Width         = 290
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.  && When: CdGrupos nao vazio E CdContas vazio
        ENDWITH

        loc_oCnt.AddObject("txt_4c_PctAliqs", "TextBox")
        WITH loc_oCnt.txt_4c_PctAliqs
            .Value         = 0
            .Left          = 536
            .Top           = 2
            .Width         = 42
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.  && When: CdGrupos e CdContas nao vazios
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Receitas", "TextBox")
        WITH loc_oCnt.txt_4c_Receitas
            .Value         = ""
            .Left          = 588
            .Top           = 2
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
            .Enabled       = .F.  && When: CdGrupos, CdContas e PctAliqs nao vazios
        ENDWITH

        *-- Lookups F4 para CdGrupos e CdContas + LostFocus para validacao
        BINDEVENT(loc_oCnt.txt_4c_CdGrupos, "GotFocus",  THIS, "FiscalGotFocus")
        BINDEVENT(loc_oCnt.txt_4c_CdGrupos, "KeyPress",  THIS, "FiscalCdGruposKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_CdGrupos, "KeyPress", THIS, "FiscalCdGruposLostFocus")
        BINDEVENT(loc_oCnt.txt_4c_CdContas, "GotFocus",  THIS, "FiscalGotFocus")
        BINDEVENT(loc_oCnt.txt_4c_CdContas, "KeyPress",  THIS, "FiscalCdContasKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_CdContas, "KeyPress", THIS, "FiscalCdContasLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAbaGeral - Controles da Aba 1 (Geral)
    * Col.Esq: Comple/Pessoais/RefBancs/FollowUp/Fiscais/DadosCom/Respos/LimCre/Comi
    * Col.Dir: Empresa/Contabs/Caracts/Perfil/Cargos/ChkLimCr/PreCad + Coletor
    * Inferior: GrupoGeral, VrLimCre, CdMoeda, DsMoeda, RodRelCC
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAbaGeral()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1

        *== Coluna Esquerda (labels left~27-103, opts left=128) ==================
        THIS.CriarLabel(loc_oAba, "lbl_4c_GComple",   "Complemento :",                   56, 22,  74)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptComple",   128, 18, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GPessoais", "Dados Pessoais :",                 47, 48,  83)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPessoais",  128, 44, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GRefBancs", "Ref. Banc" + CHR(225) + "rias :", 51, 74,  79)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRefBancs",  128, 70, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GFollowUp", "Follow-Up :",                     74, 101, 56)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFollowUp",  128, 97, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GFiscais",  "Dados Fiscais :",                 57, 127, 73)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFiscais",   128, 123, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GDadosCom", "Dados Comerciais :",              37, 153, 93)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptDadosCom",  128, 149, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GRespos", ;
            "Possui Respons" + CHR(225) + "vel :",             27, 178, 103)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRespos",    128, 174, 97, 2)

        *-- Limite de Credito (3 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_GLimCre", ;
            "Limite de Cr" + CHR(233) + "dito :",              41, 202, 89)
        loc_oAba.AddObject("opt_4c_OptLimCre", "OptionGroup")
        WITH loc_oAba.opt_4c_OptLimCre
            .ButtonCount  = 3
            .Left         = 126
            .Top          = 197
            .Width        = 225
            .Height       = 25
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "Sim"
            .Buttons(1).Width    = 70
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "N" + CHR(227) + "o"
            .Buttons(2).Width    = 70
            .Buttons(2).Left     = 70
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = "Sim-Saldo"
            .Buttons(3).Width    = 85
            .Buttons(3).Left     = 140
            .Buttons(3).Top      = 0
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
        ENDWITH

        THIS.CriarLabel(loc_oAba, "lbl_4c_GComi", ;
            "Comiss" + CHR(227) + "o :",                       76, 229, 54)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptComi",      128, 225, 97, 2)

        *== Coluna Direita (labels left~411-501, opts left=533) ==================
        THIS.CriarLabel(loc_oAba, "lbl_4c_GEmpresa",  "Dados da Empresa :",             436, 22,  98)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptEmpresa",   533, 18, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GContabs", ;
            "Dados Cont" + CHR(225) + "beis :",               444, 48,  90)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptContabs",   533, 44, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GCaract", ;
            "Caracter" + CHR(237) + "sticas :",               454, 74,  80)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCaract",    533, 70, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GPerfil",   "Perfil :",                       501, 127, 33)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPerfil",    533, 123, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GCargos",   "Cargos :",                       491, 153, 43)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCargos",    533, 149, 97, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_GChkLimCr", ;
            "Checa Limite Cr" + CHR(233) + "dito :",          427, 178, 107)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptChkLimCrG", 533, 174, 97, 2)

        *== Extrema Direita: Grupo Padrao (Coletor, 11 botoes) ==================
        THIS.CriarLabel(loc_oAba, "lbl_4c_GColetor", ;
            "Grupo Padr" + CHR(227) + "o :",                  706, 22,  75)
        loc_oAba.AddObject("opt_4c_OptColetor", "OptionGroup")
        WITH loc_oAba.opt_4c_OptColetor
            .ButtonCount  = 11
            .Left         = 780
            .Top          = 15
            .Width        = 141
            .Height       = 210
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = " 1"
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = " 2"
            .Buttons(2).Left     = 0
            .Buttons(2).Top      = 19
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = " 3"
            .Buttons(3).Left     = 0
            .Buttons(3).Top      = 38
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
            .Buttons(4).Caption  = " 4"
            .Buttons(4).Left     = 0
            .Buttons(4).Top      = 57
            .Buttons(4).AutoSize = .F.
            .Buttons(4).ForeColor = RGB(90, 90, 90)
            .Buttons(4).Themes   = .F.
            .Buttons(5).Caption  = " 5"
            .Buttons(5).Left     = 0
            .Buttons(5).Top      = 76
            .Buttons(5).AutoSize = .F.
            .Buttons(5).ForeColor = RGB(90, 90, 90)
            .Buttons(5).Themes   = .F.
            .Buttons(6).Caption  = " 6"
            .Buttons(6).Left     = 0
            .Buttons(6).Top      = 95
            .Buttons(6).AutoSize = .F.
            .Buttons(6).ForeColor = RGB(90, 90, 90)
            .Buttons(6).Themes   = .F.
            .Buttons(7).Caption  = " 7"
            .Buttons(7).Left     = 0
            .Buttons(7).Top      = 114
            .Buttons(7).AutoSize = .F.
            .Buttons(7).ForeColor = RGB(90, 90, 90)
            .Buttons(7).Themes   = .F.
            .Buttons(8).Caption  = " 8"
            .Buttons(8).Left     = 0
            .Buttons(8).Top      = 133
            .Buttons(8).AutoSize = .F.
            .Buttons(8).ForeColor = RGB(90, 90, 90)
            .Buttons(8).Themes   = .F.
            .Buttons(9).Caption  = " 9"
            .Buttons(9).Left     = 0
            .Buttons(9).Top      = 152
            .Buttons(9).AutoSize = .F.
            .Buttons(9).ForeColor = RGB(90, 90, 90)
            .Buttons(9).Themes   = .F.
            .Buttons(10).Caption  = "10"
            .Buttons(10).Left     = 0
            .Buttons(10).Top      = 171
            .Buttons(10).AutoSize = .F.
            .Buttons(10).ForeColor = RGB(90, 90, 90)
            .Buttons(10).Themes   = .F.
            .Buttons(11).Caption  = "11"
            .Buttons(11).Left     = 0
            .Buttons(11).Top      = 190
            .Buttons(11).AutoSize = .F.
            .Buttons(11).ForeColor = RGB(90, 90, 90)
            .Buttons(11).Themes   = .F.
        ENDWITH

        *-- Pre Cadastro
        THIS.CriarLabel(loc_oAba, "lbl_4c_GPreCad", ;
            "Pr" + CHR(233) + " Cadastro :",                  709, 229, 72)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPreCad",    780, 225, 97, 2)

        *== Secao inferior: Limite Credito Grupo/Vr/Moeda ========================
        THIS.CriarLabel(loc_oAba, "lbl_4c_GLimCrGVM", ;
            "Lim.Cr" + CHR(233) + "dito Grupo/Vr/Moeda :",   389, 204, 145)

        loc_oAba.AddObject("txt_4c_GrupoGeral", "TextBox")
        WITH loc_oAba.txt_4c_GrupoGeral
            .Value         = ""
            .Left          = 536
            .Top           = 199
            .Width         = 97
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_GrupoGeral, "KeyPress",  THIS, "txt_4c_GrupoGeral_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_GrupoGeral, "KeyPress", THIS, "txt_4c_GrupoGeral_LostFocus")

        loc_oAba.AddObject("txt_4c_VrLimCre", "TextBox")
        WITH loc_oAba.txt_4c_VrLimCre
            .Value         = 0
            .Left          = 636
            .Top           = 199
            .Width         = 110
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        THIS.CriarLabel(loc_oAba, "lbl_4c_GMoeda", ;
            "Moeda da Comiss" + CHR(227) + "o :",             430, 229, 107)

        loc_oAba.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oAba.txt_4c_CdMoeda
            .Value         = ""
            .Left          = 536
            .Top           = 225
            .Width         = 32
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 10
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_CdMoeda, "KeyPress",  THIS, "txt_4c_CdMoeda_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_CdMoeda, "KeyPress", THIS, "txt_4c_CdMoeda_LostFocus")

        loc_oAba.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oAba.txt_4c_DsMoeda
            .Value         = ""
            .Left          = 570
            .Top           = 225
            .Width         = 130
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
        ENDWITH

        *== Rodape Relatorio Conta Corrente =====================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_GRodape", ;
            "Rod" + CHR(225) + "p" + CHR(233) + " do Relat" + CHR(243) + ;
            "rio de Conta Corrente",                          165, 263, 220)

        loc_oAba.AddObject("edt_4c_RodRelCC", "EditBox")
        WITH loc_oAba.edt_4c_RodRelCC
            .Value         = ""
            .Left          = 165
            .Top           = 280
            .Width         = 788
            .Height        = 117
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ScrollBars    = 2
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAbaCadastro - Controles da Aba 2 (Cadastro/Financeiro)
    * Col.Esq: CPFObrig/RG/CEP/CalcIMeds/ObrMails/ObrNome/ObrSit/ObrTlm/
    *          ObrCla/ObrSeg/ObrIbge/FpublSobr/NascObrig
    * Col.Dir: RestEnd/CntVinc/DupEnd/MFotos/Observacao/CpfFixo/Situacao/
    *          CaracCad/AceJob/CCustoTit/LogAlt/InfSenha
    * Financeiro: Contint/IntegCont/PadPreench/VincContas/TitBaixado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAbaCadastro()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2

        THIS.CriarLabel(loc_oAba, "lbl_4c_CadHeader", ;
            "Cadastro de Contas",                              29, 14, 120)

        *-- CPF/CNPJ Obrigatorio (4 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCpfObrig", ;
            "CPF / CNPJ Obrigat" + CHR(243) + "rio :",        73, 32, 120)
        loc_oAba.AddObject("opt_4c_CpfObrig", "OptionGroup")
        WITH loc_oAba.opt_4c_CpfObrig
            .ButtonCount  = 4
            .Left         = 192
            .Top          = 29
            .Width        = 284
            .Height       = 23
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "N" + CHR(227) + "o"
            .Buttons(1).Width    = 64
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "Sim"
            .Buttons(2).Width    = 64
            .Buttons(2).Left     = 64
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = "Sim-Dupla"
            .Buttons(3).Width    = 80
            .Buttons(3).Left     = 128
            .Buttons(3).Top      = 0
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
            .Buttons(4).Caption  = "N" + CHR(227) + "o-Dupla"
            .Buttons(4).Width    = 76
            .Buttons(4).Left     = 208
            .Buttons(4).Top      = 0
            .Buttons(4).AutoSize = .F.
            .Buttons(4).ForeColor = RGB(90, 90, 90)
            .Buttons(4).Themes   = .F.
        ENDWITH

        *-- RG/IE Obrigatorio
        THIS.CriarLabel(loc_oAba, "lbl_4c_CRgObrig", ;
            "RG / IE Obrigat" + CHR(243) + "rio :",           93, 53, 100)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_RgObrig",       192, 50, 115, 2)

        *-- CEP Obrigatorio (3 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCepObrig", ;
            "CEP Obrigat" + CHR(243) + "rio :",               108, 76, 85)
        loc_oAba.AddObject("opt_4c_CepObrig", "OptionGroup")
        WITH loc_oAba.opt_4c_CepObrig
            .ButtonCount  = 3
            .Left         = 191
            .Top          = 70
            .Width        = 201
            .Height       = 25
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "N" + CHR(227) + "o"
            .Buttons(1).Width    = 60
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "Sim"
            .Buttons(2).Width    = 60
            .Buttons(2).Left     = 60
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = "Sim-Buscar"
            .Buttons(3).Width    = 81
            .Buttons(3).Left     = 120
            .Buttons(3).Top      = 0
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
        ENDWITH

        *-- Calc.IMedias
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCalcIMeds", ;
            "Calc. I.M" + CHR(233) + "dias :",                108, 95, 85)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_CalcIMeds",     191, 92, 97, 2)

        *-- eMail Obrigatorio
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrMails", ;
            "e-Mail Obrigat" + CHR(243) + "rio :",             99, 120, 94)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrMails",      191, 115, 97, 2)

        *-- Nome Obrigatorio
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrNome", ;
            "Nome Obrigat" + CHR(243) + "rio :",              100, 141, 93)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrNome",       191, 137, 97, 2)

        *-- Situacao Obrigatoria
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrSit", ;
            "Situa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria :", 86, 164, 107)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrSit",        191, 159, 97, 2)

        *-- Telemarketing Obrigatorio
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrTlm", ;
            "Telemarketing Obrigat" + CHR(243) + "rio :",      60, 186, 133)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrTlm",        190, 181, 97, 2)

        *-- Classificacao Obrigatoria
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrCla", ;
            "Classifica" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria :", 66, 208, 127)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrCla",        190, 203, 97, 2)

        *-- Segmento Obrigatorio
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrSeg", ;
            "Segmento Obrigat" + CHR(243) + "rio :",           79, 229, 114)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrSeg",        190, 224, 97, 2)

        *-- Cod IBGE Obrigatorio
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObrIbge", ;
            "Cod Ibge Obrigat" + CHR(243) + "rio :",           83, 249, 110)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrIbge",       190, 244, 97, 2)

        *-- F.Publicidade Obrigatoria
        THIS.CriarLabel(loc_oAba, "lbl_4c_CFpublSobr", ;
            "F. Publicidade Obrigat" + CHR(243) + "ria :",     46, 269, 147)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_FpublSobr",     189, 264, 97, 2)

        *-- Data Nascimento Obrigatoria
        THIS.CriarLabel(loc_oAba, "lbl_4c_CNascObrig", ;
            "Data Nascimento Obrigat" + CHR(243) + "ria :",    46, 291, 147)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_NascObrig",     189, 286, 97, 2)

        *== Coluna Direita (opts left=686-690) ===================================

        *-- Verifica Restricao Endereco (Fwoption9, top=24)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CRestEnd", ;
            "Verifica Restri" + CHR(231) + CHR(227) + "o de Endere" + CHR(231) + "o :", 533, 27, 155)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_RestEnd",       686, 24, 97, 2)

        *-- Conta Vinculada ao Grupo (Fwoption4, top=49)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCntVinc", ;
            "Conta Vinculada ao Grupo :",                      555, 52, 133)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_CntVinc",       688, 47, 115, 2)

        *-- Verifica Duplicidade Endereco (Fwoption5, top=70)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CDupEnd", ;
            "Verifica Duplicidade de Endere" + CHR(231) + "o :", 524, 73, 164)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_DupEnd",        688, 70, 115, 2)

        *-- Mostrar Foto
        THIS.CriarLabel(loc_oAba, "lbl_4c_CMFotos",   "Mostrar Foto :",             617, 93, 71)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_MFotos",        688, 90, 115, 2)

        *-- Observacao (3 botoes, height=63)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CObservacao", ;
            "Observa" + CHR(231) + CHR(227) + "o :",          621, 115, 67)
        loc_oAba.AddObject("opt_4c_Observacao", "OptionGroup")
        WITH loc_oAba.opt_4c_Observacao
            .ButtonCount  = 3
            .Left         = 689
            .Top          = 115
            .Width        = 115
            .Height       = 63
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "N" + CHR(227) + "o Mostrar"
            .Buttons(1).Width    = 112
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "Sempre"
            .Buttons(2).Width    = 112
            .Buttons(2).Left     = 0
            .Buttons(2).Top      = 21
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = "Mostrar Bot" + CHR(227) + "o"
            .Buttons(3).Width    = 112
            .Buttons(3).Left     = 0
            .Buttons(3).Top      = 42
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
        ENDWITH

        *-- CPF/CNPJ Fixo (3 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCpfFixo", ;
            "CPF / CNPJ Fixo :",                              602, 167, 86)
        loc_oAba.AddObject("opt_4c_CpfFixo", "OptionGroup")
        WITH loc_oAba.opt_4c_CpfFixo
            .ButtonCount  = 3
            .Left         = 690
            .Top          = 164
            .Width        = 167
            .Height       = 23
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "CPF"
            .Buttons(1).Width    = 50
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "CNPJ"
            .Buttons(2).Width    = 50
            .Buttons(2).Left     = 50
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = "Ambos"
            .Buttons(3).Width    = 67
            .Buttons(3).Left     = 100
            .Buttons(3).Top      = 0
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
        ENDWITH

        *-- Situacao Padrao (textbox + lookup)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CSituacao", ;
            "Situa" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :", 601, 189, 90)
        loc_oAba.AddObject("txt_4c_Situas", "TextBox")
        WITH loc_oAba.txt_4c_Situas
            .Value         = ""
            .Left          = 693
            .Top           = 185
            .Width         = 32
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 10
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_Situas, "KeyPress",  THIS, "txt_4c_Situas_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_Situas, "KeyPress", THIS, "txt_4c_Situas_LostFocus")

        *-- Caracteristica Cadastro
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCaracCad", ;
            "Caracter" + CHR(237) + "stica :",                613, 212, 75)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_CaracCad",      688, 208, 115, 2)

        *-- Acesso Job
        THIS.CriarLabel(loc_oAba, "lbl_4c_CAceJob",   "Acesso Job :",               625, 233, 63)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_AceJob",        688, 229, 115, 2)

        *-- Habilita Centro de Custos Titulos
        THIS.CriarLabel(loc_oAba, "lbl_4c_CCCustoTit", ;
            "Habilita Centro de Custos nos T" + CHR(237) + "tulos :", 503, 254, 185)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_CCustoTit",     687, 249, 97, 2)

        *-- Log de Alteracoes
        THIS.CriarLabel(loc_oAba, "lbl_4c_CLogAlt", ;
            "Log de Altera" + CHR(231) + CHR(245) + "es :",  593, 276, 95)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_LogAlt",        688, 272, 115, 2)

        *-- Informar Senha na Alteracao
        THIS.CriarLabel(loc_oAba, "lbl_4c_CInfSenha", ;
            "Informar senha na Altera" + CHR(231) + CHR(227) + "o :", 541, 296, 147)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_InfSenha",      688, 292, 115, 2)

        *== Separador Financeiro ================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_CFinHeader", "Financeiro", 29, 315, 60)

        *-- Conta Corrente Interna
        THIS.CriarLabel(loc_oAba, "lbl_4c_CContint",  "Conta :",                    152, 324, 40)
        loc_oAba.AddObject("txt_4c_Contint", "TextBox")
        WITH loc_oAba.txt_4c_Contint
            .Value         = ""
            .Left          = 192
            .Top           = 321
            .Width         = 73
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_Contint, "KeyPress",  THIS, "txt_4c_Contint_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_Contint, "KeyPress", THIS, "txt_4c_Contint_LostFocus")

        *-- Integracao Contabil (3 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CIntegCont", ;
            "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil :", 86, 348, 104)
        loc_oAba.AddObject("opt_4c_IntegCont", "OptionGroup")
        WITH loc_oAba.opt_4c_IntegCont
            .ButtonCount  = 3
            .Left         = 192
            .Top          = 345
            .Width        = 316
            .Height       = 23
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "N" + CHR(227) + "o"
            .Buttons(1).Width    = 80
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "Sim"
            .Buttons(2).Width    = 80
            .Buttons(2).Left     = 80
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = "Sem ContraPartida"
            .Buttons(3).Width    = 156
            .Buttons(3).Left     = 160
            .Buttons(3).Top      = 0
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
        ENDWITH

        *-- Padrao Preenchimento (4 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_CPadPreench", ;
            "Padr" + CHR(227) + "o de Preenchimento :",       58, 369, 132)
        loc_oAba.AddObject("opt_4c_PadPreench", "OptionGroup")
        WITH loc_oAba.opt_4c_PadPreench
            .ButtonCount  = 4
            .Left         = 192
            .Top          = 366
            .Width        = 353
            .Height       = 23
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "Nenhum"
            .Buttons(1).Width    = 70
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "Pagamentos"
            .Buttons(2).Width    = 90
            .Buttons(2).Left     = 70
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = "Recebimentos"
            .Buttons(3).Width    = 100
            .Buttons(3).Left     = 160
            .Buttons(3).Top      = 0
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
            .Buttons(4).Caption  = "Ambos"
            .Buttons(4).Width    = 93
            .Buttons(4).Left     = 260
            .Buttons(4).Top      = 0
            .Buttons(4).AutoSize = .F.
            .Buttons(4).ForeColor = RGB(90, 90, 90)
            .Buttons(4).Themes   = .F.
        ENDWITH

        *-- Vincula Contas no Pag/Rec
        THIS.CriarLabel(loc_oAba, "lbl_4c_CVincContas", ;
            "Vincula as Contas no Pag/Rec.:",                  38, 390, 152)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_VincContas",    192, 387, 181, 2)

        *-- Visualizar Titulos nao Baixados
        THIS.CriarLabel(loc_oAba, "lbl_4c_CTitBaixado", ;
            "Visualizar T" + CHR(237) + "tulos n" + CHR(227) + "o Baixados :", 36, 410, 154)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_TitBaixado",    192, 407, 181, 2)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAbaEstoque - Controles da Aba 3 (Estoque/Industria)
    * Estoque: LimEsto/VerEst/EstPAcab/ChkLimEst/CCusto + Saldo/Relevante/BlqConGV/Patrim/TipoInvs
    * Industria: GBals/DifPeso/Sinal/Tfalhas/GrupoEst + TrfPeso/GrupoFalha/ContaFalha
    *            UnifBal/ContaPdr/FalPers/BlqDivOp/OsAlFuns/OsPend/Compagru/ObjDupTit/GetAgrupa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAbaEstoque()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3

        THIS.CriarLabel(loc_oAba, "lbl_4c_EEstHeader", "Estoque", 21, 14, 47)

        *== Coluna Esquerda: Limite/Avalia/ProdAcabado/ChkLimEst/CCusto =========
        THIS.CriarLabel(loc_oAba, "lbl_4c_ELimEsto", ;
            "Limite de Estoque :",                             85, 35, 93)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptLimEsto",    174, 30, 92, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EVerEst",   "Avalia Estoque :",            99, 60, 80)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptVerEst",     174, 56, 92, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EEstPAcab", ;
            "Estoque Produto Acabado :",                       45, 84, 134)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptEstPAcab",   174, 80, 92, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EChkLimEst", ;
            "Checa Limite de Estoque:",                        55, 109, 124)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptChkLimEst",  174, 104, 92, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_ECCusto",   "Centro de Custos :",          86, 132, 93)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCCustoEst",  174, 128, 92, 2)

        *== Coluna Direita: Saldo/Relevante/BlqConGV/Patrim/TipoInvs ===========
        THIS.CriarLabel(loc_oAba, "lbl_4c_ESaldo", ;
            "C" + CHR(225) + "lculo de Saldo :",              386, 35, 87)
        loc_oAba.AddObject("opt_4c_OptSaldo", "OptionGroup")
        WITH loc_oAba.opt_4c_OptSaldo
            .ButtonCount  = 2
            .Left         = 469
            .Top          = 30
            .Width        = 149
            .Height       = 25
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "Online"
            .Buttons(1).Width    = 70
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "Background"
            .Buttons(2).Width    = 79
            .Buttons(2).Left     = 70
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
        ENDWITH

        THIS.CriarLabel(loc_oAba, "lbl_4c_ERelevante", ;
            "Empresa Relevante :",                            370, 60, 102)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRelevante",  469, 56, 113, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EBlqConGV", ;
            "Bloqueia Consulta Vendas :",                     342, 85, 132)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptBlqConGV",   469, 80, 113, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EPatrim", ;
            "Patrimonial por Etiqueta :",                     351, 109, 123)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPatrim",     469, 104, 113, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EInvTipo", ;
            "Invent" + CHR(225) + "rio :",                   415, 132, 55)
        loc_oAba.AddObject("opt_4c_OpTipoInvs", "OptionGroup")
        WITH loc_oAba.opt_4c_OpTipoInvs
            .ButtonCount  = 3
            .Left         = 470
            .Top          = 128
            .Width        = 371
            .Height       = 25
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "Pr" + CHR(243) + "prio"
            .Buttons(1).Width    = 100
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "Pr" + CHR(243) + "prio Poder 3p"
            .Buttons(2).Width    = 135
            .Buttons(2).Left     = 100
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = "Nos Meios 3p"
            .Buttons(3).Width    = 136
            .Buttons(3).Left     = 235
            .Buttons(3).Top      = 0
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
        ENDWITH

        *== DDR/DDF (far right) =================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EDdR", ;
            "Dias Bloqueio Retroativo :",                     723, 37, 127)
        loc_oAba.AddObject("txt_4c_DdR", "TextBox")
        WITH loc_oAba.txt_4c_DdR
            .Value         = 0
            .Left          = 852
            .Top           = 33
            .Width         = 45
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        THIS.CriarLabel(loc_oAba, "lbl_4c_EDdF", ;
            "Dias Bloqueio Futuro :",                        742, 61, 112)
        loc_oAba.AddObject("txt_4c_DdF", "TextBox")
        WITH loc_oAba.txt_4c_DdF
            .Value         = 0
            .Left          = 852
            .Top           = 57
            .Width         = 45
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        *== Separador Industria ==================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EIndHeader", ;
            "Ind" + CHR(250) + "stria",                       21, 174, 54)

        *== Balanco Fabrica + DifPeso + Sinal + Tfalhas ==========================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EGBals", ;
            "Balan" + CHR(231) + "o F" + CHR(225) + "brica :", 93, 199, 84)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptGBals",      174, 194, 92, 2)

        THIS.CriarLabel(loc_oAba, "lbl_4c_EDifPeso", ;
            "Diferen" + CHR(231) + "a de Peso :",            378, 199, 95)
        loc_oAba.AddObject("txt_4c_DifPeso", "TextBox")
        WITH loc_oAba.txt_4c_DifPeso
            .Value         = 0
            .Left          = 480
            .Top           = 194
            .Width         = 68
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
        ENDWITH

        loc_oAba.AddObject("cmb_4c_Sinal", "ComboBox")
        WITH loc_oAba.cmb_4c_Sinal
            .RowSourceType = 1
            .RowSource     = "+,-,P,Q"
            .Style         = 2
            .Left          = 550
            .Top           = 194
            .Width         = 48
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = "+"
        ENDWITH

        THIS.CriarLabel(loc_oAba, "lbl_4c_ETfalhasPQ", "( P/Q )", 621, 199, 40)
        loc_oAba.AddObject("txt_4c_Tfalhas", "TextBox")
        WITH loc_oAba.txt_4c_Tfalhas
            .Value         = ""
            .Left          = 601
            .Top           = 194
            .Width         = 17
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 1
        ENDWITH

        *== Grupo Dif. Balanco + Transfere Peso ==================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EGrupDif", ;
            "Grupo Dif. Balan" + CHR(231) + "o :",            78, 224, 98)
        loc_oAba.AddObject("txt_4c_GrupoEst", "TextBox")
        WITH loc_oAba.txt_4c_GrupoEst
            .Value         = ""
            .Left          = 179
            .Top           = 219
            .Width         = 90
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_GrupoEst, "KeyPress",  THIS, "txt_4c_GrupoEst_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_GrupoEst, "KeyPress", THIS, "txt_4c_GrupoEst_LostFocus")

        *-- Transfere Peso (5 botoes)
        THIS.CriarLabel(loc_oAba, "lbl_4c_ETrfPeso",  "Transfere Peso :",            395, 219, 82)
        loc_oAba.AddObject("opt_4c_ChkTrfPeso", "OptionGroup")
        WITH loc_oAba.opt_4c_ChkTrfPeso
            .ButtonCount  = 5
            .Left         = 474
            .Top          = 219
            .Width        = 186
            .Height       = 95
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "1"
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "2"
            .Buttons(2).Left     = 0
            .Buttons(2).Top      = 19
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = "3"
            .Buttons(3).Left     = 0
            .Buttons(3).Top      = 38
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
            .Buttons(4).Caption  = "4"
            .Buttons(4).Left     = 0
            .Buttons(4).Top      = 57
            .Buttons(4).AutoSize = .F.
            .Buttons(4).ForeColor = RGB(90, 90, 90)
            .Buttons(4).Themes   = .F.
            .Buttons(5).Caption  = "5"
            .Buttons(5).Left     = 0
            .Buttons(5).Top      = 76
            .Buttons(5).AutoSize = .F.
            .Buttons(5).ForeColor = RGB(90, 90, 90)
            .Buttons(5).Themes   = .F.
        ENDWITH

        *== Grupo/Conta Falha ====================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EGrupoFalha", ;
            "Grupo de Falha :",                              721, 199, 82)
        loc_oAba.AddObject("txt_4c_GrupoFalha", "TextBox")
        WITH loc_oAba.txt_4c_GrupoFalha
            .Value         = ""
            .Left          = 805
            .Top           = 195
            .Width         = 90
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_GrupoFalha, "KeyPress",  THIS, "txt_4c_GrupoFalha_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_GrupoFalha, "KeyPress", THIS, "txt_4c_GrupoFalha_LostFocus")

        THIS.CriarLabel(loc_oAba, "lbl_4c_EContaFalha", ;
            "Conta de Falha :",                              721, 224, 82)
        loc_oAba.AddObject("txt_4c_ContaFalha", "TextBox")
        WITH loc_oAba.txt_4c_ContaFalha
            .Value         = ""
            .Left          = 805
            .Top           = 220
            .Width         = 90
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_ContaFalha, "KeyPress",  THIS, "txt_4c_ContaFalha_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_ContaFalha, "KeyPress", THIS, "txt_4c_ContaFalha_LostFocus")

        loc_oAba.AddObject("txt_4c_DsContaFalha", "TextBox")
        WITH loc_oAba.txt_4c_DsContaFalha
            .Value         = ""
            .Left          = 897
            .Top           = 220
            .Width         = 59
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
        ENDWITH

        *== Balanco Unificado (4 botoes) =========================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EUnifBal", ;
            "Balan" + CHR(231) + "o Unificado :",             83, 249, 93)
        loc_oAba.AddObject("opt_4c_OptUnifBal", "OptionGroup")
        WITH loc_oAba.opt_4c_OptUnifBal
            .ButtonCount  = 4
            .Left         = 174
            .Top          = 245
            .Width        = 171
            .Height       = 43
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "N" + CHR(227) + "o"
            .Buttons(1).Width    = 42
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "Sim"
            .Buttons(2).Width    = 42
            .Buttons(2).Left     = 42
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = "Parcial"
            .Buttons(3).Width    = 43
            .Buttons(3).Left     = 84
            .Buttons(3).Top      = 0
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
            .Buttons(4).Caption  = "Total"
            .Buttons(4).Width    = 44
            .Buttons(4).Left     = 127
            .Buttons(4).Top      = 0
            .Buttons(4).AutoSize = .F.
            .Buttons(4).ForeColor = RGB(90, 90, 90)
            .Buttons(4).Themes   = .F.
        ENDWITH

        *== Conta Padrao =========================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EContaPdr", ;
            "Conta Padr" + CHR(227) + "o :",                 728, 250, 75)
        loc_oAba.AddObject("txt_4c_ContaPdr", "TextBox")
        WITH loc_oAba.txt_4c_ContaPdr
            .Value         = ""
            .Left          = 805
            .Top           = 246
            .Width         = 90
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH
        BINDEVENT(loc_oAba.txt_4c_ContaPdr, "KeyPress",  THIS, "txt_4c_ContaPdr_KeyPress")
        BINDEVENT(loc_oAba.txt_4c_ContaPdr, "KeyPress", THIS, "txt_4c_ContaPdr_LostFocus")

        loc_oAba.AddObject("txt_4c_DsContaPdr", "TextBox")
        WITH loc_oAba.txt_4c_DsContaPdr
            .Value         = ""
            .Left          = 896
            .Top           = 246
            .Width         = 59
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
        ENDWITH

        *== Balanco Falhas/Perdas ================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EFalPers", ;
            "Balan" + CHR(231) + "o Falhas/Perdas :",         61, 293, 117)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFalPers",    174, 288, 92, 2)

        *== Bloqueia Divisao OF ==================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EBlqDivOp", ;
            "Bloqueia Divis" + CHR(227) + "o de OF :",        59, 318, 118)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptBlqDivOp",   174, 314, 92, 2)

        *== Container Resumo de Composicao (Os/Alianca/Fundicao) ================
        loc_oAba.AddObject("cnt_4c_OsAlFuns", "Container")
        WITH loc_oAba.cnt_4c_OsAlFuns
            .Top         = 311
            .Left        = 324
            .Width       = 347
            .Height      = 27
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oAba.cnt_4c_OsAlFuns.AddObject("lbl_4c_ResComp", "Label")
        WITH loc_oAba.cnt_4c_OsAlFuns.lbl_4c_ResComp
            .Caption   = "Resumo de Composi" + CHR(231) + CHR(227) + "o :"
            .Left      = 30
            .Top       = 6
            .Width     = 122
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        loc_oAba.cnt_4c_OsAlFuns.AddObject("chk_4c_CheckOs", "CheckBox")
        WITH loc_oAba.cnt_4c_OsAlFuns.chk_4c_CheckOs
            .Caption   = "Os"
            .Left      = 158
            .Top       = 4
            .Width     = 31
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
        ENDWITH

        loc_oAba.cnt_4c_OsAlFuns.AddObject("chk_4c_CheckAlianca", "CheckBox")
        WITH loc_oAba.cnt_4c_OsAlFuns.chk_4c_CheckAlianca
            .Caption   = "Alian" + CHR(231) + "a"
            .Left      = 199
            .Top       = 4
            .Width     = 52
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
        ENDWITH

        loc_oAba.cnt_4c_OsAlFuns.AddObject("chk_4c_CheckFundicao", "CheckBox")
        WITH loc_oAba.cnt_4c_OsAlFuns.chk_4c_CheckFundicao
            .Caption   = "Fundi" + CHR(231) + CHR(227) + "o"
            .Left      = 266
            .Top       = 4
            .Width     = 61
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Value     = 0
        ENDWITH

        *== OsPend - Prazo de Entrega =============================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EOsPend", ;
            "OS Pendente Dt.Entrega :",                        49, 343, 128)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_GetOsPend",     174, 338, 92, 2)

        *== Agrupa Componentes (3 botoes) ========================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_ECompagru", ;
            "Agrupa Componentes :",                           364, 341, 109)
        loc_oAba.AddObject("opt_4c_OpCompagru", "OptionGroup")
        WITH loc_oAba.opt_4c_OpCompagru
            .ButtonCount  = 3
            .Left         = 474
            .Top          = 340
            .Width        = 186
            .Height       = 21
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "Sim"
            .Buttons(1).Width    = 55
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "N" + CHR(227) + "o"
            .Buttons(2).Width    = 55
            .Buttons(2).Left     = 55
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = "Mat. Principal"
            .Buttons(3).Width    = 76
            .Buttons(3).Left     = 110
            .Buttons(3).Top      = 0
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
        ENDWITH

        *== Checa Duplicidade de Titulo ==========================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EObjDupTit", ;
            "Checa Duplicidade de T" + CHR(237) + "tulo:",    41, 369, 137)
        THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObjDupTit",     174, 364, 92, 2)

        *== Agrupamento ==========================================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_EAgrupa",   "Agrupamento:",               406, 369, 75)
        loc_oAba.AddObject("txt_4c_GetAgrupa", "TextBox")
        WITH loc_oAba.txt_4c_GetAgrupa
            .Value         = ""
            .Left          = 480
            .Top           = 365
            .Width         = 150
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 20
        ENDWITH

        *== Controle de Lote (3 botoes) ==========================================
        THIS.CriarLabel(loc_oAba, "lbl_4c_ECtrlLote", ;
            "Controle de Lote :",                             388, 396, 88)
        loc_oAba.AddObject("opt_4c_CtrlLotes", "OptionGroup")
        WITH loc_oAba.opt_4c_CtrlLotes
            .ButtonCount  = 3
            .Left         = 474
            .Top          = 393
            .Width        = 164
            .Height       = 21
            .BorderStyle  = 0
            .Value        = 1
            .Buttons(1).Caption  = "Sim"
            .Buttons(1).Width    = 48
            .Buttons(1).Left     = 0
            .Buttons(1).Top      = 0
            .Buttons(1).AutoSize = .F.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Themes   = .F.
            .Buttons(2).Caption  = "N" + CHR(227) + "o"
            .Buttons(2).Width    = 48
            .Buttons(2).Left     = 48
            .Buttons(2).Top      = 0
            .Buttons(2).AutoSize = .F.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Themes   = .F.
            .Buttons(3).Caption  = "M" + CHR(250) + "ltiplos"
            .Buttons(3).Width    = 68
            .Buttons(3).Left     = 96
            .Buttons(3).Top      = 0
            .Buttons(3).AutoSize = .F.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Themes   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAbaFaturamento - Controles da Aba 4 (Faturamento/Fiscal)
    * 9 containers fiscais: ICMS/IPI/II/ISS/IRRF/INSS/PIS/CSSL/COFINS
    * Cada container: lbl(nome), CdGrupos, CdContas, DsContas, PctAliqs, Receitas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAbaFaturamento()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page4

        *-- Headers
        THIS.CriarLabel(loc_oAba, "lbl_4c_FImposto",  "Impostos",                    22, 33, 60)
        THIS.CriarLabel(loc_oAba, "lbl_4c_FGrupo",    "Grupo",                       104, 33, 40)
        THIS.CriarLabel(loc_oAba, "lbl_4c_FConta", ;
            "Conta e Descri" + CHR(231) + CHR(227) + "o",    301, 33, 120)
        THIS.CriarLabel(loc_oAba, "lbl_4c_FAliqs", ;
            "Al" + CHR(237) + "quota",                        552, 33, 50)
        THIS.CriarLabel(loc_oAba, "lbl_4c_FReceita",  "Receita",                     623, 33, 50)

        *-- 9 containers fiscais (mesma estrutura, tops sequenciais)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_ICMS", "ICMS",   52)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_IPI",  "IPI",    78)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_II",   "II",    104)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_ISS",  "ISS",   130)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_IRRF", "IRRF",  156)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_INSS", "INSS",  182)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_PIS",  "PIS",   207)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_CSL",  "CSSL",  233)
        THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_COF",  "COFINS",259)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega registros no grid da lista
    * Colunas: Codigos(80), Descrs(300), Internos(120), TpCods(60), DClasses(300)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid.ColumnCount = 5
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Internos"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.TpCods"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.DClasses"

                loc_oGrid.Column1.Width = 80
                loc_oGrid.Column2.Width = 300
                loc_oGrid.Column3.Width = 120
                loc_oGrid.Column4.Width = 60
                loc_oGrid.Column5.Width = 300

                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Interno"
                loc_oGrid.Column4.Header1.Caption = "Tipo"
                loc_oGrid.Column5.Header1.Caption = "Classe"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do formulario para o Business Object
    * NOTA: Controles das abas internas serao adicionados em FASE 4
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oPag2
        loc_oBO   = THIS.this_oBusinessObject
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *-- Identificacao (Page2 direto)
        loc_oBO.this_cCodigos = ALLTRIM(loc_oPag2.txt_4c_Codigos.Value)
        loc_oBO.this_cDescrs  = ALLTRIM(loc_oPag2.txt_4c_Descrs.Value)
        loc_oBO.this_cInterno = ALLTRIM(loc_oPag2.txt_4c_Interno.Value)
        loc_oBO.this_nTpCods  = loc_oPag2.opt_4c_TpCods.Value
        loc_oBO.this_nTpEmps  = IIF(loc_oPag2.opt_4c_TpEmps.Visible, loc_oPag2.opt_4c_TpEmps.Value, 2)
        loc_oBO.this_nTpCads  = loc_oPag2.opt_4c_TpCads.Value
        loc_oBO.this_cDigito  = ALLTRIM(loc_oPag2.txt_4c_Digito.Value)
        loc_oBO.this_cClasses = ALLTRIM(loc_oPag2.txt_4c_Classes.Value)

        *-- ChkLimCrds (CheckBox 1=checked -> this_nOptChkLimCr=1/Sim, 0=this_nOptChkLimCr=2/Nao)
        loc_oBO.this_nOptChkLimCr  = IIF(loc_oPag2.chk_4c_LimCrds.Value = 1, 1, 2)
        loc_oBO.this_nOptChkLimEst = IIF(loc_oPag2.chk_4c_LimEsts.Value = 1, 1, 2)

        LOCAL loc_oG, loc_oC, loc_oE, loc_oF
        loc_oG = loc_oPag2.pgf_4c_AbaDados.Page1
        loc_oC = loc_oPag2.pgf_4c_AbaDados.Page2
        loc_oE = loc_oPag2.pgf_4c_AbaDados.Page3
        loc_oF = loc_oPag2.pgf_4c_AbaDados.Page4

        *== ABA GERAL ===========================================================
        loc_oBO.this_nOptComple    = loc_oG.opt_4c_OptComple.Value
        loc_oBO.this_nOptPessoais  = loc_oG.opt_4c_OptPessoais.Value
        loc_oBO.this_nOptRefBancs  = loc_oG.opt_4c_OptRefBancs.Value
        loc_oBO.this_nOptFollowUp  = loc_oG.opt_4c_OptFollowUp.Value
        loc_oBO.this_nOptFiscais   = loc_oG.opt_4c_OptFiscais.Value
        loc_oBO.this_nOptDadosCom  = loc_oG.opt_4c_OptDadosCom.Value
        loc_oBO.this_nOptRespos    = loc_oG.opt_4c_OptRespos.Value
        loc_oBO.this_nOptLimCre    = loc_oG.opt_4c_OptLimCre.Value
        loc_oBO.this_nOptComi      = loc_oG.opt_4c_OptComi.Value
        loc_oBO.this_nOptEmpresa   = loc_oG.opt_4c_OptEmpresa.Value
        loc_oBO.this_nOptContabs   = loc_oG.opt_4c_OptContabs.Value
        loc_oBO.this_nOptCaract    = loc_oG.opt_4c_OptCaract.Value
        loc_oBO.this_nOptPerfil    = loc_oG.opt_4c_OptPerfil.Value
        loc_oBO.this_nOptCargos    = loc_oG.opt_4c_OptCargos.Value
        loc_oBO.this_nOptChkLimCr  = loc_oG.opt_4c_OptChkLimCrG.Value
        loc_oBO.this_nOptColetor   = loc_oG.opt_4c_OptColetor.Value
        loc_oBO.this_nOptPreCad    = loc_oG.opt_4c_OptPreCad.Value
        loc_oBO.this_cGrupoGeral   = ALLTRIM(loc_oG.txt_4c_GrupoGeral.Value)
        loc_oBO.this_nVrlimc       = loc_oG.txt_4c_VrLimCre.Value
        loc_oBO.this_cCdMoeda      = ALLTRIM(loc_oG.txt_4c_CdMoeda.Value)
        loc_oBO.this_cRodRelCC     = loc_oG.edt_4c_RodRelCC.Value

        *== ABA CADASTRO =========================================================
        loc_oBO.this_nCpfObrig     = loc_oC.opt_4c_CpfObrig.Value
        loc_oBO.this_nRgObrig      = loc_oC.opt_4c_RgObrig.Value
        loc_oBO.this_nCepObrig     = loc_oC.opt_4c_CepObrig.Value
        loc_oBO.this_nCalcIMeds    = loc_oC.opt_4c_CalcIMeds.Value
        loc_oBO.this_nObrMails     = loc_oC.opt_4c_ObrMails.Value
        loc_oBO.this_nObrNome      = loc_oC.opt_4c_ObrNome.Value
        loc_oBO.this_nObrSit       = loc_oC.opt_4c_ObrSit.Value
        loc_oBO.this_nObrTlm       = loc_oC.opt_4c_ObrTlm.Value
        loc_oBO.this_nObrCla       = loc_oC.opt_4c_ObrCla.Value
        loc_oBO.this_nObrSeg       = loc_oC.opt_4c_ObrSeg.Value
        loc_oBO.this_nObrIbge      = loc_oC.opt_4c_ObrIbge.Value
        loc_oBO.this_nFpublSobr    = loc_oC.opt_4c_FpublSobr.Value
        loc_oBO.this_nNascObrig    = loc_oC.opt_4c_NascObrig.Value
        loc_oBO.this_nRestEnd      = loc_oC.opt_4c_RestEnd.Value
        loc_oBO.this_nCntVinc      = loc_oC.opt_4c_CntVinc.Value
        loc_oBO.this_nDupEnd       = loc_oC.opt_4c_DupEnd.Value
        loc_oBO.this_nMFotos       = loc_oC.opt_4c_MFotos.Value
        loc_oBO.this_nObservacao   = loc_oC.opt_4c_Observacao.Value
        loc_oBO.this_nCpfFixo      = loc_oC.opt_4c_CpfFixo.Value
        loc_oBO.this_cSituas       = ALLTRIM(loc_oC.txt_4c_Situas.Value)
        loc_oBO.this_nCaracCad     = loc_oC.opt_4c_CaracCad.Value
        loc_oBO.this_nAceJob       = loc_oC.opt_4c_AceJob.Value
        loc_oBO.this_nCCustoTit    = loc_oC.opt_4c_CCustoTit.Value
        loc_oBO.this_nLogAlt       = loc_oC.opt_4c_LogAlt.Value
        loc_oBO.this_nInfSenha     = loc_oC.opt_4c_InfSenha.Value
        loc_oBO.this_cContint      = ALLTRIM(loc_oC.txt_4c_Contint.Value)
        loc_oBO.this_nIntegCont    = loc_oC.opt_4c_IntegCont.Value
        loc_oBO.this_nPadPreench   = loc_oC.opt_4c_PadPreench.Value
        loc_oBO.this_nVincContas   = loc_oC.opt_4c_VincContas.Value
        loc_oBO.this_nTitBaixado   = loc_oC.opt_4c_TitBaixado.Value

        *== ABA ESTOQUE ===========================================================
        loc_oBO.this_nOptLimEsto   = loc_oE.opt_4c_OptLimEsto.Value
        loc_oBO.this_nOptVerEst    = loc_oE.opt_4c_OptVerEst.Value
        loc_oBO.this_nOptEstPAcab  = loc_oE.opt_4c_OptEstPAcab.Value
        loc_oBO.this_nOptChkLimEst = loc_oE.opt_4c_OptChkLimEst.Value
        loc_oBO.this_nOptCCustoEst = loc_oE.opt_4c_OptCCustoEst.Value
        loc_oBO.this_nOptSaldo     = loc_oE.opt_4c_OptSaldo.Value
        loc_oBO.this_nOptRelevante = loc_oE.opt_4c_OptRelevante.Value
        loc_oBO.this_nOptBlqConGV  = loc_oE.opt_4c_OptBlqConGV.Value
        loc_oBO.this_nOptPatrim    = loc_oE.opt_4c_OptPatrim.Value
        loc_oBO.this_nOpTipoInvs   = loc_oE.opt_4c_OpTipoInvs.Value
        loc_oBO.this_nDdR          = loc_oE.txt_4c_DdR.Value
        loc_oBO.this_nDdF          = loc_oE.txt_4c_DdF.Value
        loc_oBO.this_nOptGBals     = loc_oE.opt_4c_OptGBals.Value
        loc_oBO.this_nDifPeso      = loc_oE.txt_4c_DifPeso.Value
        loc_oBO.this_cSinal        = ALLTRIM(loc_oE.cmb_4c_Sinal.Value)
        loc_oBO.this_cTfalhas      = ALLTRIM(loc_oE.txt_4c_Tfalhas.Value)
        loc_oBO.this_cGrupoEst     = ALLTRIM(loc_oE.txt_4c_GrupoEst.Value)
        loc_oBO.this_nChkTrfPeso   = loc_oE.opt_4c_ChkTrfPeso.Value
        loc_oBO.this_cGrupoFalha   = ALLTRIM(loc_oE.txt_4c_GrupoFalha.Value)
        loc_oBO.this_cContaFalha   = ALLTRIM(loc_oE.txt_4c_ContaFalha.Value)
        loc_oBO.this_nOptUnifBal   = loc_oE.opt_4c_OptUnifBal.Value
        loc_oBO.this_cContaPdr     = ALLTRIM(loc_oE.txt_4c_ContaPdr.Value)
        loc_oBO.this_nOptFalPers   = loc_oE.opt_4c_OptFalPers.Value
        loc_oBO.this_nOptBlqDivOp  = loc_oE.opt_4c_OptBlqDivOp.Value
        loc_oBO.this_lCheck1       = (loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckOs.Value = 1)
        loc_oBO.this_lCheck2       = (loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckAlianca.Value = 1)
        loc_oBO.this_lCheck3       = (loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckFundicao.Value = 1)
        loc_oBO.this_nGetOsPend    = loc_oE.opt_4c_GetOsPend.Value
        loc_oBO.this_nOpCompagru   = loc_oE.opt_4c_OpCompagru.Value
        loc_oBO.this_nObjDupTit    = loc_oE.opt_4c_ObjDupTit.Value
        loc_oBO.this_cGetAgrupa    = ALLTRIM(loc_oE.txt_4c_GetAgrupa.Value)
        loc_oBO.this_nFwoption1Est = loc_oE.opt_4c_CtrlLotes.Value

        *== ABA FATURAMENTO =======================================================
        loc_oBO.this_cGrupoICMS    = ALLTRIM(loc_oF.cnt_4c_ICMS.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaICMS    = ALLTRIM(loc_oF.cnt_4c_ICMS.txt_4c_CdContas.Value)
        loc_oBO.this_nPctICMS      = loc_oF.cnt_4c_ICMS.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecICMS      = ALLTRIM(loc_oF.cnt_4c_ICMS.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoIPI     = ALLTRIM(loc_oF.cnt_4c_IPI.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaIPI     = ALLTRIM(loc_oF.cnt_4c_IPI.txt_4c_CdContas.Value)
        loc_oBO.this_nPctIPI       = loc_oF.cnt_4c_IPI.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecIPI       = ALLTRIM(loc_oF.cnt_4c_IPI.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoII      = ALLTRIM(loc_oF.cnt_4c_II.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaII      = ALLTRIM(loc_oF.cnt_4c_II.txt_4c_CdContas.Value)
        loc_oBO.this_nPctII        = loc_oF.cnt_4c_II.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecII        = ALLTRIM(loc_oF.cnt_4c_II.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoISS     = ALLTRIM(loc_oF.cnt_4c_ISS.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaISS     = ALLTRIM(loc_oF.cnt_4c_ISS.txt_4c_CdContas.Value)
        loc_oBO.this_nPctISS       = loc_oF.cnt_4c_ISS.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecISS       = ALLTRIM(loc_oF.cnt_4c_ISS.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoIRRF    = ALLTRIM(loc_oF.cnt_4c_IRRF.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaIRRF    = ALLTRIM(loc_oF.cnt_4c_IRRF.txt_4c_CdContas.Value)
        loc_oBO.this_nPctIRRF      = loc_oF.cnt_4c_IRRF.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecIRRF      = ALLTRIM(loc_oF.cnt_4c_IRRF.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoINSS    = ALLTRIM(loc_oF.cnt_4c_INSS.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaINSS    = ALLTRIM(loc_oF.cnt_4c_INSS.txt_4c_CdContas.Value)
        loc_oBO.this_nPctINSS      = loc_oF.cnt_4c_INSS.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecINSS      = ALLTRIM(loc_oF.cnt_4c_INSS.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoPIS     = ALLTRIM(loc_oF.cnt_4c_PIS.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaPIS     = ALLTRIM(loc_oF.cnt_4c_PIS.txt_4c_CdContas.Value)
        loc_oBO.this_nPctPIS       = loc_oF.cnt_4c_PIS.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecPIS       = ALLTRIM(loc_oF.cnt_4c_PIS.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoCSL     = ALLTRIM(loc_oF.cnt_4c_CSL.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaCSL     = ALLTRIM(loc_oF.cnt_4c_CSL.txt_4c_CdContas.Value)
        loc_oBO.this_nPctCSL       = loc_oF.cnt_4c_CSL.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecCSL       = ALLTRIM(loc_oF.cnt_4c_CSL.txt_4c_Receitas.Value)

        loc_oBO.this_cGrupoCOF     = ALLTRIM(loc_oF.cnt_4c_COF.txt_4c_CdGrupos.Value)
        loc_oBO.this_cContaCOF     = ALLTRIM(loc_oF.cnt_4c_COF.txt_4c_CdContas.Value)
        loc_oBO.this_nPctCOF       = loc_oF.cnt_4c_COF.txt_4c_PctAliqs.Value
        loc_oBO.this_cRecCOF       = ALLTRIM(loc_oF.cnt_4c_COF.txt_4c_Receitas.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do Business Object para o formulario
    * NOTA: Controles das abas internas serao populados em FASE 4
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oPag2
        loc_oBO   = THIS.this_oBusinessObject
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *-- Identificacao
        loc_oPag2.txt_4c_Codigos.Value  = loc_oBO.this_cCodigos
        loc_oPag2.txt_4c_Descrs.Value   = loc_oBO.this_cDescrs
        loc_oPag2.txt_4c_Interno.Value  = loc_oBO.this_cInterno
        loc_oPag2.opt_4c_TpCods.Value   = IIF(loc_oBO.this_nTpCods > 0, loc_oBO.this_nTpCods, 1)
        loc_oPag2.txt_4c_Digito.Value   = loc_oBO.this_cDigito
        loc_oPag2.txt_4c_Classes.Value  = loc_oBO.this_cClasses
        loc_oPag2.txt_4c_DClasses.Value = loc_oBO.this_cDClasses

        *-- TpEmps / TpCads
        loc_oPag2.opt_4c_TpEmps.Value = IIF(loc_oBO.this_nTpEmps > 0, loc_oBO.this_nTpEmps, 1)
        loc_oPag2.opt_4c_TpCads.Value = IIF(loc_oBO.this_nTpCads > 0, loc_oBO.this_nTpCads, 1)

        *-- Visibilidade de Digito e TpEmps: controlada por TpCods=1
        loc_oPag2.txt_4c_Digito.Visible    = (loc_oBO.this_nTpCods = 1)
        loc_oPag2.lbl_4c_LblDigito.Visible = (loc_oBO.this_nTpCods = 1)
        loc_oPag2.lbl_4c_TpEmps.Visible    = (loc_oBO.this_nTpCods = 1)
        loc_oPag2.opt_4c_TpEmps.Visible    = (loc_oBO.this_nTpCods = 1)
        loc_oPag2.opt_4c_TpEmps.Enabled    = (loc_oBO.this_nTpCods = 1)

        *-- ChkLimCrds/ChkLimEsts
        loc_oPag2.chk_4c_LimCrds.Value = IIF(loc_oBO.this_nOptChkLimCr  = 1, 1, 0)
        loc_oPag2.chk_4c_LimEsts.Value = IIF(loc_oBO.this_nOptChkLimEst = 1, 1, 0)

        *-- Sincronizar guardia
        THIS.this_cUltClasses = ALLTRIM(loc_oBO.this_cClasses)

        LOCAL loc_oG, loc_oC, loc_oE, loc_oF
        loc_oG = loc_oPag2.pgf_4c_AbaDados.Page1
        loc_oC = loc_oPag2.pgf_4c_AbaDados.Page2
        loc_oE = loc_oPag2.pgf_4c_AbaDados.Page3
        loc_oF = loc_oPag2.pgf_4c_AbaDados.Page4

        *== ABA GERAL ===========================================================
        loc_oG.opt_4c_OptComple.Value    = IIF(loc_oBO.this_nOptComple  > 0, loc_oBO.this_nOptComple,  2)
        loc_oG.opt_4c_OptPessoais.Value  = IIF(loc_oBO.this_nOptPessoais > 0, loc_oBO.this_nOptPessoais, 2)
        loc_oG.opt_4c_OptRefBancs.Value  = IIF(loc_oBO.this_nOptRefBancs > 0, loc_oBO.this_nOptRefBancs, 2)
        loc_oG.opt_4c_OptFollowUp.Value  = IIF(loc_oBO.this_nOptFollowUp > 0, loc_oBO.this_nOptFollowUp, 2)
        loc_oG.opt_4c_OptFiscais.Value   = IIF(loc_oBO.this_nOptFiscais  > 0, loc_oBO.this_nOptFiscais,  2)
        loc_oG.opt_4c_OptDadosCom.Value  = IIF(loc_oBO.this_nOptDadosCom > 0, loc_oBO.this_nOptDadosCom, 2)
        loc_oG.opt_4c_OptRespos.Value    = IIF(loc_oBO.this_nOptRespos   > 0, loc_oBO.this_nOptRespos,   2)
        loc_oG.opt_4c_OptLimCre.Value    = IIF(loc_oBO.this_nOptLimCre   > 0, loc_oBO.this_nOptLimCre,   1)
        loc_oG.opt_4c_OptComi.Value      = IIF(loc_oBO.this_nOptComi     > 0, loc_oBO.this_nOptComi,     2)
        loc_oG.opt_4c_OptEmpresa.Value   = IIF(loc_oBO.this_nOptEmpresa  > 0, loc_oBO.this_nOptEmpresa,  2)
        loc_oG.opt_4c_OptContabs.Value   = IIF(loc_oBO.this_nOptContabs  > 0, loc_oBO.this_nOptContabs,  2)
        loc_oG.opt_4c_OptCaract.Value    = IIF(loc_oBO.this_nOptCaract   > 0, loc_oBO.this_nOptCaract,   2)
        loc_oG.opt_4c_OptPerfil.Value    = IIF(loc_oBO.this_nOptPerfil   > 0, loc_oBO.this_nOptPerfil,   2)
        loc_oG.opt_4c_OptCargos.Value    = IIF(loc_oBO.this_nOptCargos   > 0, loc_oBO.this_nOptCargos,   2)
        loc_oG.opt_4c_OptChkLimCrG.Value = IIF(loc_oBO.this_nOptChkLimCr > 0, loc_oBO.this_nOptChkLimCr, 2)
        loc_oG.opt_4c_OptColetor.Value   = IIF(loc_oBO.this_nOptColetor  > 0, loc_oBO.this_nOptColetor,  2)
        loc_oG.opt_4c_OptPreCad.Value    = IIF(loc_oBO.this_nOptPreCad   > 0, loc_oBO.this_nOptPreCad,   2)
        loc_oG.txt_4c_GrupoGeral.Value   = loc_oBO.this_cGrupoGeral
        loc_oG.txt_4c_VrLimCre.Value     = loc_oBO.this_nVrlimc
        loc_oG.txt_4c_CdMoeda.Value      = loc_oBO.this_cCdMoeda
        loc_oG.txt_4c_DsMoeda.Value      = loc_oBO.this_cDsMoeda
        loc_oG.edt_4c_RodRelCC.Value     = loc_oBO.this_cRodRelCC

        *== ABA CADASTRO =========================================================
        loc_oC.opt_4c_CpfObrig.Value     = IIF(loc_oBO.this_nCpfObrig   > 0, loc_oBO.this_nCpfObrig,   1)
        loc_oC.opt_4c_RgObrig.Value      = IIF(loc_oBO.this_nRgObrig    > 0, loc_oBO.this_nRgObrig,    2)
        loc_oC.opt_4c_CepObrig.Value     = IIF(loc_oBO.this_nCepObrig   > 0, loc_oBO.this_nCepObrig,   1)
        loc_oC.opt_4c_CalcIMeds.Value    = IIF(loc_oBO.this_nCalcIMeds  > 0, loc_oBO.this_nCalcIMeds,  2)
        loc_oC.opt_4c_ObrMails.Value     = IIF(loc_oBO.this_nObrMails   > 0, loc_oBO.this_nObrMails,   2)
        loc_oC.opt_4c_ObrNome.Value      = IIF(loc_oBO.this_nObrNome    > 0, loc_oBO.this_nObrNome,    2)
        loc_oC.opt_4c_ObrSit.Value       = IIF(loc_oBO.this_nObrSit     > 0, loc_oBO.this_nObrSit,     2)
        loc_oC.opt_4c_ObrTlm.Value       = IIF(loc_oBO.this_nObrTlm     > 0, loc_oBO.this_nObrTlm,     2)
        loc_oC.opt_4c_ObrCla.Value       = IIF(loc_oBO.this_nObrCla     > 0, loc_oBO.this_nObrCla,     2)
        loc_oC.opt_4c_ObrSeg.Value       = IIF(loc_oBO.this_nObrSeg     > 0, loc_oBO.this_nObrSeg,     2)
        loc_oC.opt_4c_ObrIbge.Value      = IIF(loc_oBO.this_nObrIbge    > 0, loc_oBO.this_nObrIbge,    2)
        loc_oC.opt_4c_FpublSobr.Value    = IIF(loc_oBO.this_nFpublSobr  > 0, loc_oBO.this_nFpublSobr,  2)
        loc_oC.opt_4c_NascObrig.Value    = IIF(loc_oBO.this_nNascObrig  > 0, loc_oBO.this_nNascObrig,  2)
        loc_oC.opt_4c_RestEnd.Value      = IIF(loc_oBO.this_nRestEnd    > 0, loc_oBO.this_nRestEnd,    2)
        loc_oC.opt_4c_CntVinc.Value      = IIF(loc_oBO.this_nCntVinc    > 0, loc_oBO.this_nCntVinc,    2)
        loc_oC.opt_4c_DupEnd.Value       = IIF(loc_oBO.this_nDupEnd     > 0, loc_oBO.this_nDupEnd,     2)
        loc_oC.opt_4c_MFotos.Value       = IIF(loc_oBO.this_nMFotos     > 0, loc_oBO.this_nMFotos,     2)
        loc_oC.opt_4c_Observacao.Value   = IIF(loc_oBO.this_nObservacao > 0, loc_oBO.this_nObservacao,  1)
        loc_oC.opt_4c_CpfFixo.Value      = IIF(loc_oBO.this_nCpfFixo    > 0, loc_oBO.this_nCpfFixo,    1)
        loc_oC.txt_4c_Situas.Value       = loc_oBO.this_cSituas
        loc_oC.opt_4c_CaracCad.Value     = IIF(loc_oBO.this_nCaracCad   > 0, loc_oBO.this_nCaracCad,   2)
        loc_oC.opt_4c_AceJob.Value       = IIF(loc_oBO.this_nAceJob     > 0, loc_oBO.this_nAceJob,     2)
        loc_oC.opt_4c_CCustoTit.Value    = IIF(loc_oBO.this_nCCustoTit  > 0, loc_oBO.this_nCCustoTit,  2)
        loc_oC.opt_4c_LogAlt.Value       = IIF(loc_oBO.this_nLogAlt     > 0, loc_oBO.this_nLogAlt,     2)
        loc_oC.opt_4c_InfSenha.Value     = IIF(loc_oBO.this_nInfSenha   > 0, loc_oBO.this_nInfSenha,   2)
        loc_oC.txt_4c_Contint.Value      = loc_oBO.this_cContint
        loc_oC.opt_4c_IntegCont.Value    = IIF(loc_oBO.this_nIntegCont  > 0, loc_oBO.this_nIntegCont,  1)
        loc_oC.opt_4c_PadPreench.Value   = IIF(loc_oBO.this_nPadPreench > 0, loc_oBO.this_nPadPreench,  1)
        loc_oC.opt_4c_VincContas.Value   = IIF(loc_oBO.this_nVincContas > 0, loc_oBO.this_nVincContas,  2)
        loc_oC.opt_4c_TitBaixado.Value   = IIF(loc_oBO.this_nTitBaixado > 0, loc_oBO.this_nTitBaixado,  2)

        *== ABA ESTOQUE ===========================================================
        loc_oE.opt_4c_OptLimEsto.Value   = IIF(loc_oBO.this_nOptLimEsto   > 0, loc_oBO.this_nOptLimEsto,   2)
        loc_oE.opt_4c_OptVerEst.Value    = IIF(loc_oBO.this_nOptVerEst    > 0, loc_oBO.this_nOptVerEst,    2)
        loc_oE.opt_4c_OptEstPAcab.Value  = IIF(loc_oBO.this_nOptEstPAcab  > 0, loc_oBO.this_nOptEstPAcab,  2)
        loc_oE.opt_4c_OptChkLimEst.Value = IIF(loc_oBO.this_nOptChkLimEst > 0, loc_oBO.this_nOptChkLimEst, 2)
        loc_oE.opt_4c_OptCCustoEst.Value = IIF(loc_oBO.this_nOptCCustoEst > 0, loc_oBO.this_nOptCCustoEst, 2)
        loc_oE.opt_4c_OptSaldo.Value     = IIF(loc_oBO.this_nOptSaldo     > 0, loc_oBO.this_nOptSaldo,     1)
        loc_oE.opt_4c_OptRelevante.Value = IIF(loc_oBO.this_nOptRelevante > 0, loc_oBO.this_nOptRelevante,  2)
        loc_oE.opt_4c_OptBlqConGV.Value  = IIF(loc_oBO.this_nOptBlqConGV  > 0, loc_oBO.this_nOptBlqConGV,  2)
        loc_oE.opt_4c_OptPatrim.Value    = IIF(loc_oBO.this_nOptPatrim    > 0, loc_oBO.this_nOptPatrim,    2)
        loc_oE.opt_4c_OpTipoInvs.Value   = IIF(loc_oBO.this_nOpTipoInvs   > 0, loc_oBO.this_nOpTipoInvs,   1)
        loc_oE.txt_4c_DdR.Value          = loc_oBO.this_nDdR
        loc_oE.txt_4c_DdF.Value          = loc_oBO.this_nDdF
        loc_oE.opt_4c_OptGBals.Value     = IIF(loc_oBO.this_nOptGBals    > 0, loc_oBO.this_nOptGBals,    2)
        loc_oE.txt_4c_DifPeso.Value      = loc_oBO.this_nDifPeso
        loc_oE.cmb_4c_Sinal.Value        = IIF(EMPTY(loc_oBO.this_cSinal), "+", loc_oBO.this_cSinal)
        loc_oE.txt_4c_Tfalhas.Value      = loc_oBO.this_cTfalhas
        loc_oE.txt_4c_GrupoEst.Value     = loc_oBO.this_cGrupoEst
        loc_oE.opt_4c_ChkTrfPeso.Value   = IIF(loc_oBO.this_nChkTrfPeso  > 0, loc_oBO.this_nChkTrfPeso,  1)
        loc_oE.txt_4c_GrupoFalha.Value   = loc_oBO.this_cGrupoFalha
        loc_oE.txt_4c_ContaFalha.Value   = loc_oBO.this_cContaFalha
        loc_oE.txt_4c_DsContaFalha.Value = loc_oBO.this_cDsContaFalha
        loc_oE.opt_4c_OptUnifBal.Value   = IIF(loc_oBO.this_nOptUnifBal  > 0, loc_oBO.this_nOptUnifBal,  1)
        loc_oE.txt_4c_ContaPdr.Value     = loc_oBO.this_cContaPdr
        loc_oE.txt_4c_DsContaPdr.Value   = loc_oBO.this_cDsContaPdr
        loc_oE.opt_4c_OptFalPers.Value   = IIF(loc_oBO.this_nOptFalPers  > 0, loc_oBO.this_nOptFalPers,  2)
        loc_oE.opt_4c_OptBlqDivOp.Value  = IIF(loc_oBO.this_nOptBlqDivOp > 0, loc_oBO.this_nOptBlqDivOp, 2)
        loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckOs.Value       = IIF(loc_oBO.this_lCheck1, 1, 0)
        loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckAlianca.Value  = IIF(loc_oBO.this_lCheck2, 1, 0)
        loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckFundicao.Value = IIF(loc_oBO.this_lCheck3, 1, 0)
        loc_oE.opt_4c_GetOsPend.Value    = IIF(loc_oBO.this_nGetOsPend   > 0, loc_oBO.this_nGetOsPend,   2)
        loc_oE.opt_4c_OpCompagru.Value   = IIF(loc_oBO.this_nOpCompagru  > 0, loc_oBO.this_nOpCompagru,  1)
        loc_oE.opt_4c_ObjDupTit.Value    = IIF(loc_oBO.this_nObjDupTit   > 0, loc_oBO.this_nObjDupTit,   2)
        loc_oE.txt_4c_GetAgrupa.Value    = loc_oBO.this_cGetAgrupa
        loc_oE.opt_4c_CtrlLotes.Value    = IIF(loc_oBO.this_nFwoption1Est > 0, loc_oBO.this_nFwoption1Est, 1)

        *== ABA FATURAMENTO =======================================================
        loc_oF.cnt_4c_ICMS.txt_4c_CdGrupos.Value = loc_oBO.this_cGrupoICMS
        loc_oF.cnt_4c_ICMS.txt_4c_CdContas.Value = loc_oBO.this_cContaICMS
        loc_oF.cnt_4c_ICMS.txt_4c_DsContas.Value = loc_oBO.this_cDsContaICMS
        loc_oF.cnt_4c_ICMS.txt_4c_PctAliqs.Value = loc_oBO.this_nPctICMS
        loc_oF.cnt_4c_ICMS.txt_4c_Receitas.Value = loc_oBO.this_cRecICMS

        loc_oF.cnt_4c_IPI.txt_4c_CdGrupos.Value  = loc_oBO.this_cGrupoIPI
        loc_oF.cnt_4c_IPI.txt_4c_CdContas.Value  = loc_oBO.this_cContaIPI
        loc_oF.cnt_4c_IPI.txt_4c_DsContas.Value  = loc_oBO.this_cDsContaIPI
        loc_oF.cnt_4c_IPI.txt_4c_PctAliqs.Value  = loc_oBO.this_nPctIPI
        loc_oF.cnt_4c_IPI.txt_4c_Receitas.Value  = loc_oBO.this_cRecIPI

        loc_oF.cnt_4c_II.txt_4c_CdGrupos.Value   = loc_oBO.this_cGrupoII
        loc_oF.cnt_4c_II.txt_4c_CdContas.Value   = loc_oBO.this_cContaII
        loc_oF.cnt_4c_II.txt_4c_DsContas.Value   = loc_oBO.this_cDsContaII
        loc_oF.cnt_4c_II.txt_4c_PctAliqs.Value   = loc_oBO.this_nPctII
        loc_oF.cnt_4c_II.txt_4c_Receitas.Value   = loc_oBO.this_cRecII

        loc_oF.cnt_4c_ISS.txt_4c_CdGrupos.Value  = loc_oBO.this_cGrupoISS
        loc_oF.cnt_4c_ISS.txt_4c_CdContas.Value  = loc_oBO.this_cContaISS
        loc_oF.cnt_4c_ISS.txt_4c_DsContas.Value  = loc_oBO.this_cDsContaISS
        loc_oF.cnt_4c_ISS.txt_4c_PctAliqs.Value  = loc_oBO.this_nPctISS
        loc_oF.cnt_4c_ISS.txt_4c_Receitas.Value  = loc_oBO.this_cRecISS

        loc_oF.cnt_4c_IRRF.txt_4c_CdGrupos.Value = loc_oBO.this_cGrupoIRRF
        loc_oF.cnt_4c_IRRF.txt_4c_CdContas.Value = loc_oBO.this_cContaIRRF
        loc_oF.cnt_4c_IRRF.txt_4c_DsContas.Value = loc_oBO.this_cDsContaIRRF
        loc_oF.cnt_4c_IRRF.txt_4c_PctAliqs.Value = loc_oBO.this_nPctIRRF
        loc_oF.cnt_4c_IRRF.txt_4c_Receitas.Value = loc_oBO.this_cRecIRRF

        loc_oF.cnt_4c_INSS.txt_4c_CdGrupos.Value = loc_oBO.this_cGrupoINSS
        loc_oF.cnt_4c_INSS.txt_4c_CdContas.Value = loc_oBO.this_cContaINSS
        loc_oF.cnt_4c_INSS.txt_4c_DsContas.Value = loc_oBO.this_cDsContaINSS
        loc_oF.cnt_4c_INSS.txt_4c_PctAliqs.Value = loc_oBO.this_nPctINSS
        loc_oF.cnt_4c_INSS.txt_4c_Receitas.Value = loc_oBO.this_cRecINSS

        loc_oF.cnt_4c_PIS.txt_4c_CdGrupos.Value  = loc_oBO.this_cGrupoPIS
        loc_oF.cnt_4c_PIS.txt_4c_CdContas.Value  = loc_oBO.this_cContaPIS
        loc_oF.cnt_4c_PIS.txt_4c_DsContas.Value  = loc_oBO.this_cDsContaPIS
        loc_oF.cnt_4c_PIS.txt_4c_PctAliqs.Value  = loc_oBO.this_nPctPIS
        loc_oF.cnt_4c_PIS.txt_4c_Receitas.Value  = loc_oBO.this_cRecPIS

        loc_oF.cnt_4c_CSL.txt_4c_CdGrupos.Value  = loc_oBO.this_cGrupoCSL
        loc_oF.cnt_4c_CSL.txt_4c_CdContas.Value  = loc_oBO.this_cContaCSL
        loc_oF.cnt_4c_CSL.txt_4c_DsContas.Value  = loc_oBO.this_cDsContaCSL
        loc_oF.cnt_4c_CSL.txt_4c_PctAliqs.Value  = loc_oBO.this_nPctCSL
        loc_oF.cnt_4c_CSL.txt_4c_Receitas.Value  = loc_oBO.this_cRecCSL

        loc_oF.cnt_4c_COF.txt_4c_CdGrupos.Value  = loc_oBO.this_cGrupoCOF
        loc_oF.cnt_4c_COF.txt_4c_CdContas.Value  = loc_oBO.this_cContaCOF
        loc_oF.cnt_4c_COF.txt_4c_DsContas.Value  = loc_oBO.this_cDsContaCOF
        loc_oF.cnt_4c_COF.txt_4c_PctAliqs.Value  = loc_oBO.this_nPctCOF
        loc_oF.cnt_4c_COF.txt_4c_Receitas.Value  = loc_oBO.this_cRecCOF

        *-- Atualizar estados Enabled dos campos fiscais conforme valores carregados
        THIS.AtualizarEstadoFiscalTodos(loc_oF)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        loc_oPag2.txt_4c_Codigos.Value  = ""
        loc_oPag2.txt_4c_Descrs.Value   = ""
        loc_oPag2.txt_4c_Interno.Value  = ""
        loc_oPag2.opt_4c_TpCods.Value   = 1
        loc_oPag2.opt_4c_TpEmps.Value   = 1
        loc_oPag2.opt_4c_TpCads.Value   = 1
        loc_oPag2.txt_4c_Digito.Value   = ""
        loc_oPag2.txt_4c_Classes.Value  = ""
        loc_oPag2.txt_4c_DClasses.Value = ""
        loc_oPag2.chk_4c_LimCrds.Value  = 0
        loc_oPag2.chk_4c_LimEsts.Value  = 0

        *-- Resetar visibilidade Digito e TpEmps (padrao TpCods=1 = Empresa)
        loc_oPag2.txt_4c_Digito.Visible    = .T.
        loc_oPag2.lbl_4c_LblDigito.Visible = .T.
        loc_oPag2.lbl_4c_TpEmps.Visible    = .T.
        loc_oPag2.opt_4c_TpEmps.Visible    = .T.
        loc_oPag2.opt_4c_TpEmps.Enabled    = .T.

        THIS.this_cUltClasses = ""

        LOCAL loc_oG, loc_oC, loc_oE, loc_oF
        loc_oG = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
        loc_oC = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
        loc_oE = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        loc_oF = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page4

        *== ABA GERAL ===========================================================
        loc_oG.opt_4c_OptComple.Value    = 2
        loc_oG.opt_4c_OptPessoais.Value  = 2
        loc_oG.opt_4c_OptRefBancs.Value  = 2
        loc_oG.opt_4c_OptFollowUp.Value  = 2
        loc_oG.opt_4c_OptFiscais.Value   = 2
        loc_oG.opt_4c_OptDadosCom.Value  = 2
        loc_oG.opt_4c_OptRespos.Value    = 2
        loc_oG.opt_4c_OptLimCre.Value    = 1
        loc_oG.opt_4c_OptComi.Value      = 2
        loc_oG.opt_4c_OptEmpresa.Value   = 2
        loc_oG.opt_4c_OptContabs.Value   = 2
        loc_oG.opt_4c_OptCaract.Value    = 2
        loc_oG.opt_4c_OptPerfil.Value    = 2
        loc_oG.opt_4c_OptCargos.Value    = 2
        loc_oG.opt_4c_OptChkLimCrG.Value = 2
        loc_oG.opt_4c_OptColetor.Value   = 2
        loc_oG.opt_4c_OptPreCad.Value    = 2
        loc_oG.txt_4c_GrupoGeral.Value   = ""
        loc_oG.txt_4c_VrLimCre.Value     = 0
        loc_oG.txt_4c_CdMoeda.Value      = ""
        loc_oG.txt_4c_DsMoeda.Value      = ""
        loc_oG.edt_4c_RodRelCC.Value     = ""

        *== ABA CADASTRO =========================================================
        loc_oC.opt_4c_CpfObrig.Value     = 1
        loc_oC.opt_4c_RgObrig.Value      = 2
        loc_oC.opt_4c_CepObrig.Value     = 1
        loc_oC.opt_4c_CalcIMeds.Value    = 2
        loc_oC.opt_4c_ObrMails.Value     = 2
        loc_oC.opt_4c_ObrNome.Value      = 2
        loc_oC.opt_4c_ObrSit.Value       = 2
        loc_oC.opt_4c_ObrTlm.Value       = 2
        loc_oC.opt_4c_ObrCla.Value       = 2
        loc_oC.opt_4c_ObrSeg.Value       = 2
        loc_oC.opt_4c_ObrIbge.Value      = 2
        loc_oC.opt_4c_FpublSobr.Value    = 2
        loc_oC.opt_4c_NascObrig.Value    = 2
        loc_oC.opt_4c_RestEnd.Value      = 2
        loc_oC.opt_4c_CntVinc.Value      = 2
        loc_oC.opt_4c_DupEnd.Value       = 2
        loc_oC.opt_4c_MFotos.Value       = 2
        loc_oC.opt_4c_Observacao.Value   = 1
        loc_oC.opt_4c_CpfFixo.Value      = 1
        loc_oC.txt_4c_Situas.Value       = ""
        loc_oC.opt_4c_CaracCad.Value     = 2
        loc_oC.opt_4c_AceJob.Value       = 2
        loc_oC.opt_4c_CCustoTit.Value    = 2
        loc_oC.opt_4c_LogAlt.Value       = 2
        loc_oC.opt_4c_InfSenha.Value     = 2
        loc_oC.txt_4c_Contint.Value      = ""
        loc_oC.opt_4c_IntegCont.Value    = 1
        loc_oC.opt_4c_PadPreench.Value   = 1
        loc_oC.opt_4c_VincContas.Value   = 2
        loc_oC.opt_4c_TitBaixado.Value   = 2

        *== ABA ESTOQUE ===========================================================
        loc_oE.opt_4c_OptLimEsto.Value   = 2
        loc_oE.opt_4c_OptVerEst.Value    = 2
        loc_oE.opt_4c_OptEstPAcab.Value  = 2
        loc_oE.opt_4c_OptChkLimEst.Value = 2
        loc_oE.opt_4c_OptCCustoEst.Value = 2
        loc_oE.opt_4c_OptSaldo.Value     = 1
        loc_oE.opt_4c_OptRelevante.Value = 2
        loc_oE.opt_4c_OptBlqConGV.Value  = 2
        loc_oE.opt_4c_OptPatrim.Value    = 2
        loc_oE.opt_4c_OpTipoInvs.Value   = 1
        loc_oE.txt_4c_DdR.Value          = 0
        loc_oE.txt_4c_DdF.Value          = 0
        loc_oE.opt_4c_OptGBals.Value     = 2
        loc_oE.txt_4c_DifPeso.Value      = 0
        loc_oE.cmb_4c_Sinal.Value        = "+"
        loc_oE.txt_4c_Tfalhas.Value      = ""
        loc_oE.txt_4c_GrupoEst.Value     = ""
        loc_oE.opt_4c_ChkTrfPeso.Value   = 1
        loc_oE.txt_4c_GrupoFalha.Value   = ""
        loc_oE.txt_4c_ContaFalha.Value   = ""
        loc_oE.txt_4c_DsContaFalha.Value = ""
        loc_oE.opt_4c_OptUnifBal.Value   = 1
        loc_oE.txt_4c_ContaPdr.Value     = ""
        loc_oE.txt_4c_DsContaPdr.Value   = ""
        loc_oE.opt_4c_OptFalPers.Value   = 2
        loc_oE.opt_4c_OptBlqDivOp.Value  = 2
        loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckOs.Value       = 0
        loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckAlianca.Value  = 0
        loc_oE.cnt_4c_OsAlFuns.chk_4c_CheckFundicao.Value = 0
        loc_oE.opt_4c_GetOsPend.Value    = 2
        loc_oE.opt_4c_OpCompagru.Value   = 1
        loc_oE.opt_4c_ObjDupTit.Value    = 2
        loc_oE.txt_4c_GetAgrupa.Value    = ""
        loc_oE.opt_4c_CtrlLotes.Value    = 1

        *== ABA FATURAMENTO =======================================================
        loc_oF.cnt_4c_ICMS.txt_4c_CdGrupos.Value = ""
        loc_oF.cnt_4c_ICMS.txt_4c_CdContas.Value = ""
        loc_oF.cnt_4c_ICMS.txt_4c_DsContas.Value = ""
        loc_oF.cnt_4c_ICMS.txt_4c_PctAliqs.Value = 0
        loc_oF.cnt_4c_ICMS.txt_4c_Receitas.Value = ""

        loc_oF.cnt_4c_IPI.txt_4c_CdGrupos.Value  = ""
        loc_oF.cnt_4c_IPI.txt_4c_CdContas.Value  = ""
        loc_oF.cnt_4c_IPI.txt_4c_DsContas.Value  = ""
        loc_oF.cnt_4c_IPI.txt_4c_PctAliqs.Value  = 0
        loc_oF.cnt_4c_IPI.txt_4c_Receitas.Value  = ""

        loc_oF.cnt_4c_II.txt_4c_CdGrupos.Value   = ""
        loc_oF.cnt_4c_II.txt_4c_CdContas.Value   = ""
        loc_oF.cnt_4c_II.txt_4c_DsContas.Value   = ""
        loc_oF.cnt_4c_II.txt_4c_PctAliqs.Value   = 0
        loc_oF.cnt_4c_II.txt_4c_Receitas.Value   = ""

        loc_oF.cnt_4c_ISS.txt_4c_CdGrupos.Value  = ""
        loc_oF.cnt_4c_ISS.txt_4c_CdContas.Value  = ""
        loc_oF.cnt_4c_ISS.txt_4c_DsContas.Value  = ""
        loc_oF.cnt_4c_ISS.txt_4c_PctAliqs.Value  = 0
        loc_oF.cnt_4c_ISS.txt_4c_Receitas.Value  = ""

        loc_oF.cnt_4c_IRRF.txt_4c_CdGrupos.Value = ""
        loc_oF.cnt_4c_IRRF.txt_4c_CdContas.Value = ""
        loc_oF.cnt_4c_IRRF.txt_4c_DsContas.Value = ""
        loc_oF.cnt_4c_IRRF.txt_4c_PctAliqs.Value = 0
        loc_oF.cnt_4c_IRRF.txt_4c_Receitas.Value = ""

        loc_oF.cnt_4c_INSS.txt_4c_CdGrupos.Value = ""
        loc_oF.cnt_4c_INSS.txt_4c_CdContas.Value = ""
        loc_oF.cnt_4c_INSS.txt_4c_DsContas.Value = ""
        loc_oF.cnt_4c_INSS.txt_4c_PctAliqs.Value = 0
        loc_oF.cnt_4c_INSS.txt_4c_Receitas.Value = ""

        loc_oF.cnt_4c_PIS.txt_4c_CdGrupos.Value  = ""
        loc_oF.cnt_4c_PIS.txt_4c_CdContas.Value  = ""
        loc_oF.cnt_4c_PIS.txt_4c_DsContas.Value  = ""
        loc_oF.cnt_4c_PIS.txt_4c_PctAliqs.Value  = 0
        loc_oF.cnt_4c_PIS.txt_4c_Receitas.Value  = ""

        loc_oF.cnt_4c_CSL.txt_4c_CdGrupos.Value  = ""
        loc_oF.cnt_4c_CSL.txt_4c_CdContas.Value  = ""
        loc_oF.cnt_4c_CSL.txt_4c_DsContas.Value  = ""
        loc_oF.cnt_4c_CSL.txt_4c_PctAliqs.Value  = 0
        loc_oF.cnt_4c_CSL.txt_4c_Receitas.Value  = ""

        loc_oF.cnt_4c_COF.txt_4c_CdGrupos.Value  = ""
        loc_oF.cnt_4c_COF.txt_4c_CdContas.Value  = ""
        loc_oF.cnt_4c_COF.txt_4c_DsContas.Value  = ""
        loc_oF.cnt_4c_COF.txt_4c_PctAliqs.Value  = 0
        loc_oF.cnt_4c_COF.txt_4c_Receitas.Value  = ""

        *-- Resetar estados Enabled: todos desabilitados enquanto CdGrupos estiver vazio
        THIS.AtualizarEstadoFiscalTodos(loc_oF)
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    * par_nPagina: 1=Lista, 2=Dados
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.Visible  = .T.
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.Visible   = .T.
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.Visible = .T.
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Visible   = .T.
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.Visible = .F.
        ELSE
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.Visible  = .F.
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.Visible   = .F.
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.Visible = .F.
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Visible   = .F.
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.Visible = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    * NOTA: Completar em FASE 7 para controles das abas internas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *-- Codigo: habilitado somente no modo INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            loc_oPag2.txt_4c_Codigos.Enabled = .T.
        ELSE
            loc_oPag2.txt_4c_Codigos.Enabled = .F.
        ENDIF

        loc_oPag2.txt_4c_Descrs.Enabled   = par_lHabilitar
        loc_oPag2.txt_4c_Interno.Enabled  = par_lHabilitar
        loc_oPag2.opt_4c_TpCods.Enabled   = par_lHabilitar
        loc_oPag2.txt_4c_Digito.Enabled   = par_lHabilitar
        loc_oPag2.txt_4c_Classes.Enabled  = par_lHabilitar
        loc_oPag2.chk_4c_LimCrds.Enabled = par_lHabilitar
        loc_oPag2.chk_4c_LimEsts.Enabled = par_lHabilitar
        loc_oPag2.opt_4c_TpEmps.Enabled  = par_lHabilitar
        loc_oPag2.opt_4c_TpCads.Enabled  = par_lHabilitar

        *-- Abas internas: habilitar/desabilitar como grupo
        loc_oPag2.pgf_4c_AbaDados.Enabled = par_lHabilitar
    ENDPROC

    *==========================================================================
    *-- HANDLERS: Botoes da lista
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado
    * Dependencias verificadas dentro de ccrBO.ExecutarExclusao (SigMvCcr/SigCdCli/SigMvCab)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado!")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo '" + loc_cCodigo + "'?")
                IF THIS.this_oBusinessObject.Excluir()
                    MsgSucesso("Grupo exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Busca por codigo via FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_Busca", "Codigos", "", ;
                "Buscar Grupo CCR")

            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Internos","", "Interno")

            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                loc_cCodigo = ALLTRIM(cursor_4c_Busca.Codigos)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    *-- HANDLERS: Botoes da pagina de dados
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar registro (validacao pelo BO)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar edicao e voltar para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    *-- EVENTOS: TpCods
    *==========================================================================

    *--------------------------------------------------------------------------
    * opt_4c_TpCods_InteractiveChange - Controla visibilidade de Digito
    * Legado: .Get_Digito.Visible = (CrSigCdGcr.TpCods = 1)
    *--------------------------------------------------------------------------
    PROCEDURE opt_4c_TpCods_InteractiveChange()
        LOCAL loc_lEmpresa
        loc_lEmpresa = (THIS.pgf_4c_Paginas.Page2.opt_4c_TpCods.Value = 1)

        THIS.pgf_4c_Paginas.Page2.txt_4c_Digito.Visible    = loc_lEmpresa
        THIS.pgf_4c_Paginas.Page2.lbl_4c_LblDigito.Visible = loc_lEmpresa

        IF !loc_lEmpresa
            THIS.pgf_4c_Paginas.Page2.txt_4c_Digito.Value = ""
            THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Value = 2
        ENDIF
        THIS.pgf_4c_Paginas.Page2.lbl_4c_TpEmps.Visible = loc_lEmpresa
        THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Visible = loc_lEmpresa
        THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Enabled = loc_lEmpresa
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: Classes (SigCdCss)
    *==========================================================================

    *--------------------------------------------------------------------------
    * txt_4c_Classes_KeyPress - F4 abre lookup de classes
    *--------------------------------------------------------------------------
    PROCEDURE txt_4c_Classes_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupClasses()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * txt_4c_Classes_LostFocus - Valida classe digitada
    *--------------------------------------------------------------------------
    PROCEDURE txt_4c_Classes_LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cClasses
        loc_cClasses = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Classes.Value)

        IF loc_cClasses = THIS.this_cUltClasses
            RETURN
        ENDIF

        IF EMPTY(loc_cClasses)
            THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ""
            THIS.this_cUltClasses = ""
            RETURN
        ENDIF

        THIS.ValidarClasses(loc_cClasses)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupClasses - Abre FormBuscaAuxiliar para SigCdCss
    * Legado: fwBuscaExt em SigCdCss, campoCodigo='classes'
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupClasses()
        LOCAL loc_oBusca, loc_cValor

        TRY
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Classes.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCss", "cursor_4c_Css", "Classes", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Classe")
            loc_oBusca.mAddColuna("Classes", "", "Classe")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Css")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Classes.Value  = ALLTRIM(cursor_4c_Css.Classes)
                THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ALLTRIM(cursor_4c_Css.Descrs)
                THIS.this_cUltClasses = ALLTRIM(cursor_4c_Css.Classes)
            ENDIF

            IF USED("cursor_4c_Css")
                USE IN cursor_4c_Css
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro no lookup de classes:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarClasses - Verifica classe digitada em SigCdCss (LostFocus)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarClasses(par_cClasses)
        LOCAL loc_cSQL, loc_nRes

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT Classes, Descrs FROM SigCdCss
                WHERE Classes = <<EscaparSQL(par_cClasses)>>
            ENDTEXT

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssVerif")

            IF loc_nRes >= 0
                IF RECCOUNT("cursor_4c_CssVerif") > 0
                    THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ;
                        ALLTRIM(cursor_4c_CssVerif.Descrs)
                    THIS.this_cUltClasses = par_cClasses
                ELSE
                    *-- Codigo nao encontrado: abrir lookup
                    THIS.AbrirLookupClasses()
                ENDIF

                IF USED("cursor_4c_CssVerif")
                    USE IN cursor_4c_CssVerif
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao validar classe:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *-- UTILIDADES
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            IF .ColumnCount > 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cBase

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cBase = UPPER(loc_oObjeto.BaseClass)

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    *-- Containers ocultos intencionalmente (Visible=.F.) nao devem
                    *-- ser forcados a Visible=.T. - preservar estado definido no setup
                    IF NOT INLIST(loc_cBase, "CONTAINER") OR loc_oObjeto.Visible
                        loc_oObjeto.Visible = .T.
                    ENDIF
                ENDIF

                IF loc_cBase = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    *-- Nao recursar dentro de containers ocultos
                    IF NOT INLIST(loc_cBase, "CONTAINER") OR loc_oObjeto.Visible
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: SigCdGcr - Metodos genericos compartilhados
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirLookupGcr - Abre FormBuscaAuxiliar para SigCdGcr (generico)
    * par_oTxt: TextBox do codigo | par_oTxtDesc: TextBox desc (ou .NULL.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupGcr(par_oTxt, par_oTxtDesc)
        LOCAL loc_oBusca
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_GcrLkp", "Codigos", ;
                ALLTRIM(par_oTxt.Value), ;
                "Selecionar Grupo C/C")
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GcrLkp")
                par_oTxt.Value = ALLTRIM(cursor_4c_GcrLkp.Codigos)
                IF VARTYPE(par_oTxtDesc) = "O"
                    par_oTxtDesc.Value = ALLTRIM(cursor_4c_GcrLkp.Descrs)
                ENDIF
            ENDIF
            IF USED("cursor_4c_GcrLkp")
                USE IN cursor_4c_GcrLkp
            ENDIF
            loc_oBusca.Release()
        CATCH TO loException
            MostrarErro("Erro no lookup Grupo C/C:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGcr - Verifica codigo SigCdGcr (generico); abre lookup se n/a
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarGcr(par_cCodigo, par_oTxt, par_oTxtDesc)
        LOCAL loc_nRes
        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(par_cCodigo), ;
                "cursor_4c_GcrVerif")
            IF loc_nRes >= 0
                IF RECCOUNT("cursor_4c_GcrVerif") > 0
                    IF VARTYPE(par_oTxtDesc) = "O"
                        par_oTxtDesc.Value = ALLTRIM(cursor_4c_GcrVerif.Descrs)
                    ENDIF
                ELSE
                    THIS.AbrirLookupGcr(par_oTxt, par_oTxtDesc)
                ENDIF
                IF USED("cursor_4c_GcrVerif")
                    USE IN cursor_4c_GcrVerif
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar Grupo C/C:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: GrupoGeral (Aba Geral)
    *==========================================================================

    PROCEDURE txt_4c_GrupoGeral_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoGeral()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_GrupoGeral_LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_GrupoGeral.Value)
        IF loc_cVal = THIS.this_cUltGrupoGeral
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            THIS.this_cUltGrupoGeral = ""
            RETURN
        ENDIF
        THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_GrupoGeral, .NULL.)
        THIS.this_cUltGrupoGeral = ALLTRIM(loc_oAba.txt_4c_GrupoGeral.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupGrupoGeral()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
        THIS.AbrirLookupGcr(loc_oAba.txt_4c_GrupoGeral, .NULL.)
        THIS.this_cUltGrupoGeral = ALLTRIM(loc_oAba.txt_4c_GrupoGeral.Value)
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: CdMoeda (Aba Geral / SigCdMoe)
    *==========================================================================

    PROCEDURE txt_4c_CdMoeda_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_CdMoeda_LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_CdMoeda.Value)
        IF loc_cVal = THIS.this_cUltCdMoeda
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            loc_oAba.txt_4c_DsMoeda.Value = ""
            THIS.this_cUltCdMoeda = ""
            RETURN
        ENDIF
        THIS.ValidarMoeda(loc_cVal)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oBusca, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_MoeLkp", "cmoes", ;
                ALLTRIM(loc_oAba.txt_4c_CdMoeda.Value), ;
                "Selecionar Moeda")
            loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MoeLkp")
                loc_oAba.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_MoeLkp.cmoes)
                loc_oAba.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_MoeLkp.dmoes)
                THIS.this_cUltCdMoeda = ALLTRIM(cursor_4c_MoeLkp.cmoes)
            ENDIF
            IF USED("cursor_4c_MoeLkp")
                USE IN cursor_4c_MoeLkp
            ENDIF
            loc_oBusca.Release()
        CATCH TO loException
            MostrarErro("Erro no lookup de Moeda:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ValidarMoeda(par_cCodigo)
        LOCAL loc_nRes, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCodigo), ;
                "cursor_4c_MoeVerif")
            IF loc_nRes >= 0
                IF RECCOUNT("cursor_4c_MoeVerif") > 0
                    loc_oAba.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_MoeVerif.dmoes)
                    THIS.this_cUltCdMoeda = par_cCodigo
                ELSE
                    THIS.AbrirLookupMoeda()
                ENDIF
                IF USED("cursor_4c_MoeVerif")
                    USE IN cursor_4c_MoeVerif
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar Moeda:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: Situas (Aba Cadastro / SigCdCst)
    *==========================================================================

    PROCEDURE txt_4c_Situas_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSituas()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_Situas_LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_Situas.Value)
        IF loc_cVal = THIS.this_cUltSituas
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            THIS.this_cUltSituas = ""
            RETURN
        ENDIF
        THIS.ValidarSituas(loc_cVal)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupSituas()
        LOCAL loc_oBusca, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCst", "cursor_4c_CstLkp", "codigos", ;
                ALLTRIM(loc_oAba.txt_4c_Situas.Value), ;
                "Selecionar Situa" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CstLkp")
                loc_oAba.txt_4c_Situas.Value = ALLTRIM(cursor_4c_CstLkp.codigos)
                THIS.this_cUltSituas = ALLTRIM(cursor_4c_CstLkp.codigos)
            ENDIF
            IF USED("cursor_4c_CstLkp")
                USE IN cursor_4c_CstLkp
            ENDIF
            loc_oBusca.Release()
        CATCH TO loException
            MostrarErro("Erro no lookup de Situa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE ValidarSituas(par_cCodigo)
        LOCAL loc_nRes, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT codigos FROM SigCdCst WHERE codigos = " + EscaparSQL(par_cCodigo), ;
                "cursor_4c_CstVerif")
            IF loc_nRes >= 0
                IF RECCOUNT("cursor_4c_CstVerif") > 0
                    THIS.this_cUltSituas = par_cCodigo
                ELSE
                    THIS.AbrirLookupSituas()
                ENDIF
                IF USED("cursor_4c_CstVerif")
                    USE IN cursor_4c_CstVerif
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar Situa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: Contint (Aba Cadastro)
    *==========================================================================

    PROCEDURE txt_4c_Contint_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContint()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_Contint_LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_Contint.Value)
        IF loc_cVal = THIS.this_cUltContint
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            THIS.this_cUltContint = ""
            RETURN
        ENDIF
        THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_Contint, .NULL.)
        THIS.this_cUltContint = ALLTRIM(loc_oAba.txt_4c_Contint.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupContint()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
        THIS.AbrirLookupGcr(loc_oAba.txt_4c_Contint, .NULL.)
        THIS.this_cUltContint = ALLTRIM(loc_oAba.txt_4c_Contint.Value)
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: GrupoEst (Aba Estoque)
    *==========================================================================

    PROCEDURE txt_4c_GrupoEst_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoEst()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_GrupoEst_LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_GrupoEst.Value)
        IF loc_cVal = THIS.this_cUltGrupoEst
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            THIS.this_cUltGrupoEst = ""
            RETURN
        ENDIF
        THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_GrupoEst, .NULL.)
        THIS.this_cUltGrupoEst = ALLTRIM(loc_oAba.txt_4c_GrupoEst.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupGrupoEst()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        THIS.AbrirLookupGcr(loc_oAba.txt_4c_GrupoEst, .NULL.)
        THIS.this_cUltGrupoEst = ALLTRIM(loc_oAba.txt_4c_GrupoEst.Value)
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: GrupoFalha (Aba Estoque)
    *==========================================================================

    PROCEDURE txt_4c_GrupoFalha_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoFalha()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_GrupoFalha_LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_GrupoFalha.Value)
        IF loc_cVal = THIS.this_cUltGrupoFalha
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            THIS.this_cUltGrupoFalha = ""
            RETURN
        ENDIF
        THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_GrupoFalha, .NULL.)
        THIS.this_cUltGrupoFalha = ALLTRIM(loc_oAba.txt_4c_GrupoFalha.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupGrupoFalha()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        THIS.AbrirLookupGcr(loc_oAba.txt_4c_GrupoFalha, .NULL.)
        THIS.this_cUltGrupoFalha = ALLTRIM(loc_oAba.txt_4c_GrupoFalha.Value)
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: ContaFalha (Aba Estoque -> com DsContaFalha)
    *==========================================================================

    PROCEDURE txt_4c_ContaFalha_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaFalha()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_ContaFalha_LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_ContaFalha.Value)
        IF loc_cVal = THIS.this_cUltContaFalha
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            loc_oAba.txt_4c_DsContaFalha.Value = ""
            THIS.this_cUltContaFalha = ""
            RETURN
        ENDIF
        THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_ContaFalha, loc_oAba.txt_4c_DsContaFalha)
        THIS.this_cUltContaFalha = ALLTRIM(loc_oAba.txt_4c_ContaFalha.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupContaFalha()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        THIS.AbrirLookupGcr(loc_oAba.txt_4c_ContaFalha, loc_oAba.txt_4c_DsContaFalha)
        THIS.this_cUltContaFalha = ALLTRIM(loc_oAba.txt_4c_ContaFalha.Value)
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: ContaPdr (Aba Estoque -> com DsContaPdr)
    *==========================================================================

    PROCEDURE txt_4c_ContaPdr_KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaPdr()
        ENDIF
    ENDPROC

    PROCEDURE txt_4c_ContaPdr_LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        loc_cVal = ALLTRIM(loc_oAba.txt_4c_ContaPdr.Value)
        IF loc_cVal = THIS.this_cUltContaPdr
            RETURN
        ENDIF
        IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
            loc_oAba.txt_4c_DsContaPdr.Value = ""
            THIS.this_cUltContaPdr = ""
            RETURN
        ENDIF
        THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_ContaPdr, loc_oAba.txt_4c_DsContaPdr)
        THIS.this_cUltContaPdr = ALLTRIM(loc_oAba.txt_4c_ContaPdr.Value)
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupContaPdr()
        LOCAL loc_oAba
        loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
        THIS.AbrirLookupGcr(loc_oAba.txt_4c_ContaPdr, loc_oAba.txt_4c_DsContaPdr)
        THIS.this_cUltContaPdr = ALLTRIM(loc_oAba.txt_4c_ContaPdr.Value)
    ENDPROC

    *==========================================================================
    *-- LOOKUPS: Containers Fiscais (CdGrupos + CdContas via F4 + LostFocus)
    *-- GotFocus rastreia container ativo em this_oFiscalCntAtivo
    *-- LostFocus usa this_oFiscalCntAtivo para saber qual container processar
    *==========================================================================

    *--------------------------------------------------------------------------
    * FiscalGotFocus - Rastreia container fiscal ativo quando campo ganha foco
    *--------------------------------------------------------------------------
    PROCEDURE FiscalGotFocus()
        LOCAL loc_oCtrl
        loc_oCtrl = _VFP.ActiveControl
        IF VARTYPE(loc_oCtrl) = "O"
            THIS.this_oFiscalCntAtivo = loc_oCtrl.Parent
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FiscalCdGruposKeyPress - Abre lookup F4 para campo CdGrupos fiscal
    *--------------------------------------------------------------------------
    PROCEDURE FiscalCdGruposKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            LOCAL loc_oCtrl
            loc_oCtrl = _VFP.ActiveControl
            IF VARTYPE(loc_oCtrl) = "O"
                THIS.AbrirLookupFiscalGrupos(loc_oCtrl.Parent)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FiscalCdGruposLostFocus - Valida CdGrupos; limpa campos subordinados se vazio
    * Legado: getCdGrupos.Valid - fAcessoContab / limpa getCdContas..Receitas
    *--------------------------------------------------------------------------
    PROCEDURE FiscalCdGruposLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cVal
        loc_oCnt = THIS.this_oFiscalCntAtivo
        IF VARTYPE(loc_oCnt) # "O"
            RETURN
        ENDIF
        IF gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oCnt.txt_4c_CdGrupos.Value)
        IF EMPTY(loc_cVal)
            *-- Limpar campos subordinados ao grupo quando CdGrupos e' esvaziado
            loc_oCnt.txt_4c_CdContas.Value = ""
            loc_oCnt.txt_4c_DsContas.Value = ""
            loc_oCnt.txt_4c_PctAliqs.Value = 0
            loc_oCnt.txt_4c_Receitas.Value = ""
        ELSE
            THIS.ValidarGcr(loc_cVal, loc_oCnt.txt_4c_CdGrupos, .NULL.)
        ENDIF
        THIS.AtualizarEstadoFiscal(loc_oCnt)
    ENDPROC

    *--------------------------------------------------------------------------
    * FiscalCdContasKeyPress - Abre lookup F4 para campo CdContas fiscal
    *--------------------------------------------------------------------------
    PROCEDURE FiscalCdContasKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            LOCAL loc_oCtrl
            loc_oCtrl = _VFP.ActiveControl
            IF VARTYPE(loc_oCtrl) = "O"
                THIS.AbrirLookupFiscalContas(loc_oCtrl.Parent)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FiscalCdContasLostFocus - Valida CdContas; preenche DsContas
    * Legado: getCdContas.Valid - fAcessoContas(grupoX, [C], valor, DsContas)
    *--------------------------------------------------------------------------
    PROCEDURE FiscalCdContasLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cVal
        loc_oCnt = THIS.this_oFiscalCntAtivo
        IF VARTYPE(loc_oCnt) # "O"
            RETURN
        ENDIF
        IF gb_4c_ValidandoUI
            RETURN
        ENDIF
        loc_cVal = ALLTRIM(loc_oCnt.txt_4c_CdContas.Value)
        IF EMPTY(loc_cVal)
            loc_oCnt.txt_4c_DsContas.Value = ""
        ELSE
            THIS.ValidarGcr(loc_cVal, loc_oCnt.txt_4c_CdContas, loc_oCnt.txt_4c_DsContas)
        ENDIF
        THIS.AtualizarEstadoFiscal(loc_oCnt)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupFiscalGrupos - Abre lookup para campo CdGrupos do container
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupFiscalGrupos(par_oCnt)
        THIS.AbrirLookupGcr(par_oCnt.txt_4c_CdGrupos, .NULL.)
        THIS.AtualizarEstadoFiscal(par_oCnt)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupFiscalContas - Abre lookup para campo CdContas do container
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupFiscalContas(par_oCnt)
        THIS.AbrirLookupGcr(par_oCnt.txt_4c_CdContas, par_oCnt.txt_4c_DsContas)
        THIS.AtualizarEstadoFiscal(par_oCnt)
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoFiscal - Atualiza Enabled dos campos condicionais no container
    * Legado: When() expressions de getCdContas/getDsContas/getPctAliqs/getReceitas
    * Apenas no modo INCLUIR/ALTERAR; VISUALIZAR: todos desabilitados (via pgf_4c_AbaDados.Enabled)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoFiscal(par_oCnt)
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            LOCAL loc_lTemGrupo, loc_lTemConta, loc_lTemPct
            loc_lTemGrupo = !EMPTY(ALLTRIM(par_oCnt.txt_4c_CdGrupos.Value))
            loc_lTemConta = !EMPTY(ALLTRIM(par_oCnt.txt_4c_CdContas.Value))
            loc_lTemPct   = (par_oCnt.txt_4c_PctAliqs.Value # 0)

            par_oCnt.txt_4c_CdContas.Enabled = loc_lTemGrupo
            par_oCnt.txt_4c_DsContas.Enabled = loc_lTemGrupo AND !loc_lTemConta
            par_oCnt.txt_4c_PctAliqs.Enabled = loc_lTemGrupo AND loc_lTemConta
            par_oCnt.txt_4c_Receitas.Enabled = loc_lTemGrupo AND loc_lTemConta AND loc_lTemPct
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoFiscalTodos - Chama AtualizarEstadoFiscal para os 9 containers
    * par_oF: referencia para Page4 (aba Faturamento)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoFiscalTodos(par_oF)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_ICMS)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_IPI)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_II)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_ISS)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_IRRF)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_INSS)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_PIS)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_CSL)
        THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_COF)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
