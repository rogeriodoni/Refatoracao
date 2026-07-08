*==============================================================================
* FORMSIGRECNT.PRG
* Rela" + CHR(231) + CHR(227) + "o de Contagem por Localiza" + CHR(231) + CHR(227) + "o
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECNT.SCX (frmrelatorio)
*
* Form: 800 x 350 (EXATO do original layout.json)
* Filtros: Data, Vendedor/Conta, Localiza" + CHR(231) + CHR(245) + "es (Base/N" + CHR(237) + "vel 2/3/4),
*          C" + CHR(243) + "digo, OptionGroups Local e Ordena" + CHR(231) + CHR(227) + "o
*
* FASE 7/8 - Form - Eventos Principais (REPORT: conclu" + CHR(237) + "do na Fase 6)
*   Forms REPORT nao tem BtnIncluirClick/BtnAlterarClick/BtnExcluirClick.
*   Todos os eventos de bot" + CHR(245) + "es ja foram implementados na Fase 6:
*   BtnVisualizarClick / BtnImprimirClick / BtnExcelClick / BtnEncerrarClick
*
* FASE 3/8 - Form - Estrutura Base
*   * Propriedades visuais do form (Width=800, Height=350)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho()  (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)
*   * ConfigurarBotoes()     (cmg_4c_Botoes: Visualizar/Imprimir/Excel/Encerrar)
*   * ConfigurarPageFrame()  (PageFrame com 1 p" + CHR(225) + "gina - "Filtros")
*
* FASE 5/8 - Form - BINDEVENTs dos campos de filtro (primeira metade)
*   * ConfigurarPaginaDados() com BINDEVENT para Conta, DConta, Base, Nvl2
*   * TeclaVendedor / ValidarVendedor / AbrirBuscaVendedor
*   * TeclaDescVendedor / ValidarDescVendedor
*   * TeclaBase / ValidarBase / AbrirBuscaBase / LimparBaseDescendentes
*   * TeclaNvl2 / ValidarNvl2 / AbrirBuscaNvl2 / LimparNvl2Descendentes
*
* FASE 6/8 - Form - Campos Restantes e Lookups (segunda metade)
*   * BINDEVENTs para Nvl3, Nvl4 e botoes do relatorio (cmg_4c_Botoes)
*   * TeclaNvl3 / ValidarNvl3 / AbrirBuscaNvl3 / LimparNvl3Descendentes
*   * TeclaNvl4 / ValidarNvl4 / AbrirBuscaNvl4 / LimparNvl4Descendentes
*   * ValidarDataParaRelatorio (guard clause pre-execucao)
*   * BtnVisualizarClick / BtnImprimirClick / BtnExcelClick / BtnEncerrarClick
*
* FASE 4/8 - Form - Conte" + CHR(250) + "do da Page1 + Alterna" + CHR(231) + CHR(227) + "o de p" + CHR(225) + "gina
*   * ConfigurarPaginaLista() - Adiciona 20 controles de filtro " + CHR(224) + " Page1:
*       - Labels e TextBoxes para Data, C" + CHR(243) + "digo, Vendedor (cod+desc),
*         Base, N" + CHR(237) + "vel 2/3/4 (cada um com cod+desc), totalizando 16 fields.
*       - 2 OptionGroups: OptLocal (4 op: Todos/Contados/N" + CHR(227) + "o Contados/Divergentes)
*         e OptOrdem (4 op: Local/N" + CHR(237) + "vel 2/N" + CHR(237) + "vel 3/N" + CHR(237) + "vel 4).
*       - Campos de descri" + CHR(231) + CHR(227) + "o ReadOnly=.T. com fundo cinza claro.
*   * AlternarPagina(par_nPagina) - Alterna ActivePage do PageFrame.
*   * LimparCampos() - Redefine filtros para valores padr" + CHR(227) + "o.
*   * FormParaRelatorio() - Transfere filtros do form para o BO.
*
*   NOTA: Este " + CHR(233) + " um form REPORT, ent" + CHR(227) + "o cnt_4c_Botoes (CRUD) N" + CHR(195) + "O existe.
*   Os bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar/Imprimir/Excel/Encerrar) j" + CHR(225) + " est" + CHR(227) + "o
*   no cmg_4c_Botoes criado na Fase 3 (padr" + CHR(227) + "o frmrelatorio framework.vcx).
*==============================================================================

DEFINE CLASS Formsigrecnt AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=350)
    Height      = 350
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria sigrecntBO e carrega par" + CHR(226) + "metros iniciais (pula em modo UI)
    *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es do relat" + CHR(243) + "rio + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
                           "Localiza" + CHR(231) + CHR(227) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relat" + CHR(243) + "rio
            THIS.this_oRelatorio = CREATEOBJECT("sigrecntBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecntBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Carregar par" + CHR(226) + "metros iniciais (GrPadVens e cursores de n" + CHR(237) + "vel).
            *   Pulado em modo de valida" + CHR(231) + CHR(227) + "o de UI (sem conex" + CHR(227) + "o SQL).
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.CarregarParametros()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente a cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com p" + CHR(225) + "gina de filtros
                THIS.ConfigurarPageFrame()

                *-- Controles de filtro na Page1 (m" + CHR(233) + "todo " + CHR(233) + " "ConfigurarPaginaLista"
                *-- por compatibilidade com o esqueleto, embora a Page1 deste
                *-- form REPORT contenha filtros e n" + CHR(227) + "o uma lista CRUD).
                THIS.ConfigurarPaginaLista()

                *-- BINDEVENT dos campos de filtro interativos (Fase 5/6)
                THIS.ConfigurarPaginaDados()

                *-- Redefine filtros para valores padr" + CHR(227) + "o
                THIS.LimparCampos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo do relat" + CHR(243) + "rio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura = Width do form (cobre toda a faixa superior).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Sombra (deslocada 2px para efeito 3D do texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
                             "Localiza" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
                             "Localiza" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com bot" + CHR(245) + "es de relat" + CHR(243) + "rio (btnReport " + CHR(225) + "rea)
    *   Original: btnReport.Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *   Bot" + CHR(245) + "es: Visualizar(5), Imprimir(71), Excel(137), Encerrar(203) - W=65
    *   Eventos Click vinculados em InicializarForm (Fase 7).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            *-- Visualizar (preview em tela)
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Imprimir (impressora padr" + CHR(227) + "o)
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Excel (exportar dados)
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Encerrar (fechar form)
            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .WordWrap        = .T.
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 p" + CHR(225) + "gina ("Filtros")
    *   O form legado SIGRECNT " + CHR(233) + " FLAT (sem PageFrame), mas no novo padr" + CHR(227) + "o
    *   os campos s" + CHR(227) + "o agrupados em um PageFrame de 1 p" + CHR(225) + "gina para consist" + CHR(234) + "ncia
    *   com o restante do sistema.
    *
    *   Posicionado logo abaixo do cabe" + CHR(231) + "alho (80px + 5px gap = Top=85)
    *   at" + CHR(233) + " o fim do form.
    *   Os campos de filtro s" + CHR(227) + "o adicionados " + CHR(224) + " Page1 nas fases seguintes (4-6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona todos os controles de filtro ao Page1
    *
    *   Form REPORT: a "Page1" deste relat" + CHR(243) + "rio cont" + CHR(233) + "m FILTROS, n" + CHR(227) + "o uma lista
    *   CRUD. O nome ConfigurarPaginaLista() " + CHR(233) + " mantido para compatibilidade
    *   com o esqueleto/valida" + CHR(231) + CHR(227) + "o multi-fase, mas o conte" + CHR(250) + "do " + CHR(233) + " formado
    *   pelos campos de filtro do legado SIGRECNT (Data, C" + CHR(243) + "digo, Vendedor,
    *   Base, N" + CHR(237) + "veis 2/3/4 e OptionGroups Local/Ordem).
    *
    *   Posi" + CHR(231) + CHR(245) + "es: layout.json original top - 85 (offset do PageFrame).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Data
        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Top       = 106
            .Left      = 199
            .Width     = 32
            .Height    = 15
            .Caption   = "Data :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oPag.txt_4c_Datas
            .Top      = 102
            .Left     = 235
            .Width    = 80
            .Height   = 24
            .Value    = {}
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- C" + CHR(243) + "digo
        loc_oPag.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag.lbl_4c_Label3
            .Top       = 105
            .Left      = 366
            .Width     = 42
            .Height    = 15
            .Caption   = "C" + CHR(243) + "digo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPag.txt_4c_Codigo
            .Top      = 101
            .Left     = 411
            .Width    = 54
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Vendedor
        loc_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag.lbl_4c_Label2
            .Top       = 134
            .Left      = 176
            .Width     = 55
            .Height    = 15
            .Caption   = "Vendedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPag.txt_4c_Conta
            .Top      = 129
            .Left     = 235
            .Width    = 80
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPag.txt_4c_DConta
            .Top       = 129
            .Left      = 317
            .Width     = 290
            .Height    = 24
            .Value     = ""
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(235, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Base (N" + CHR(237) + "vel 1)
        loc_oPag.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPag.lbl_4c_Label7
            .Top       = 162
            .Left      = 199
            .Width     = 32
            .Height    = 15
            .Caption   = "Base :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Base", "TextBox")
        WITH loc_oPag.txt_4c_Base
            .Top      = 157
            .Left     = 235
            .Width    = 54
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DBase", "TextBox")
        WITH loc_oPag.txt_4c_DBase
            .Top       = 157
            .Left      = 291
            .Width     = 174
            .Height    = 24
            .Value     = ""
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(235, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Segundo N" + CHR(237) + "vel
        loc_oPag.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPag.lbl_4c_Label6
            .Top       = 190
            .Left      = 154
            .Width     = 77
            .Height    = 15
            .Caption   = "Segundo N" + CHR(237) + "vel :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Nvl2", "TextBox")
        WITH loc_oPag.txt_4c_Nvl2
            .Top      = 185
            .Left     = 235
            .Width    = 54
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DNvl2", "TextBox")
        WITH loc_oPag.txt_4c_DNvl2
            .Top       = 185
            .Left      = 291
            .Width     = 174
            .Height    = 24
            .Value     = ""
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(235, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Terceiro N" + CHR(237) + "vel
        loc_oPag.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPag.lbl_4c_Label5
            .Top       = 218
            .Left      = 157
            .Width     = 74
            .Height    = 15
            .Caption   = "Terceiro N" + CHR(237) + "vel :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Nvl3", "TextBox")
        WITH loc_oPag.txt_4c_Nvl3
            .Top      = 213
            .Left     = 235
            .Width    = 54
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DNvl3", "TextBox")
        WITH loc_oPag.txt_4c_DNvl3
            .Top       = 213
            .Left      = 291
            .Width     = 174
            .Height    = 24
            .Value     = ""
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(235, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Quarto N" + CHR(237) + "vel
        loc_oPag.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPag.lbl_4c_Label8
            .Top       = 246
            .Left      = 162
            .Width     = 69
            .Height    = 15
            .Caption   = "Quarto N" + CHR(237) + "vel :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Nvl4", "TextBox")
        WITH loc_oPag.txt_4c_Nvl4
            .Top      = 241
            .Left     = 235
            .Width    = 54
            .Height   = 24
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DNvl4", "TextBox")
        WITH loc_oPag.txt_4c_DNvl4
            .Top       = 241
            .Left      = 291
            .Width     = 174
            .Height    = 24
            .Value     = ""
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(235, 235, 235)
            .Visible   = .T.
        ENDWITH

        *-- Label Localiza" + CHR(231) + CHR(245) + "es (ao lado do OptionGroup Local)
        loc_oPag.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPag.lbl_4c_Label4
            .Top       = 270
            .Left      = 163
            .Width     = 68
            .Height    = 15
            .Caption   = "Localiza" + CHR(231) + CHR(245) + "es :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup - Tipo de localiza" + CHR(231) + CHR(227) + "o
        loc_oPag.AddObject("obj_4c_OptLocal", "OptionGroup")
        WITH loc_oPag.obj_4c_OptLocal
            .Width       = 347
            .Height      = 26
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Todos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Width     = 82
                .Height    = 18
                .Top       = 4
                .Left      = 2
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Contados"
                .Width     = 82
                .Height    = 18
                .Top       = 4
                .Left      = 87
                .AutoSize  = .F.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "N" + CHR(227) + "o Contados"
                .WordWrap        = .T.
                .Width     = 90
                .Height    = 18
                .Top       = 4
                .Left      = 172
                .AutoSize  = .F.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Divergentes"
                .WordWrap        = .T.
                .Width     = 82
                .Height    = 18
                .Top       = 4
                .Left      = 265
                .AutoSize  = .F.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            .Top         = 265
            .Left        = 231
        ENDWITH

        *-- Label Ordena" + CHR(231) + CHR(227) + "o (ao lado do OptionGroup Ordem)
        loc_oPag.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPag.lbl_4c_Label9
            .Top       = 294
            .Left      = 169
            .Width     = 62
            .Height    = 15
            .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup - Crit" + CHR(233) + "rio de ordena" + CHR(231) + CHR(227) + "o
        loc_oPag.AddObject("obj_4c_OptOrdem", "OptionGroup")
        WITH loc_oPag.obj_4c_OptOrdem
            .Width       = 432
            .Height      = 26
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Local"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Width     = 104
                .Height    = 18
                .Top       = 4
                .Left      = 2
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(237) + "vel 2"
                .Width     = 104
                .Height    = 18
                .Top       = 4
                .Left      = 109
                .AutoSize  = .F.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "N" + CHR(237) + "vel 3"
                .WordWrap        = .T.
                .Width     = 104
                .Height    = 18
                .Top       = 4
                .Left      = 216
                .AutoSize  = .F.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "N" + CHR(237) + "vel 4"
                .WordWrap        = .T.
                .Width     = 104
                .Height    = 18
                .Top       = 4
                .Left      = 323
                .AutoSize  = .F.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            .Top         = 289
            .Left        = 231
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna a p" + CHR(225) + "gina ativa do PageFrame
    *
    *   Form REPORT: este formul" + CHR(225) + "rio possui apenas 1 p" + CHR(225) + "gina (Filtros), ent" + CHR(227) + "o
    *   AlternarPagina sempre retorna para Page1. Mantido para compatibilidade
    *   com a interface padr" + CHR(227) + "o da fase 4 (esqueleto CRUD).
    *
    *   par_nPagina : n" + CHR(250) + "mero da p" + CHR(225) + "gina destino (1 = Filtros)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = par_nPagina

        *-- Sanitiza" + CHR(231) + CHR(227) + "o: somente Page1 existe neste form REPORT
        IF VARTYPE(loc_nPagina) != "N" OR loc_nPagina < 1 OR ;
           loc_nPagina > THIS.pgf_4c_Paginas.PageCount
            loc_nPagina = 1
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = loc_nPagina

        *-- Refresh dos controles ap" + CHR(243) + "s alternar p" + CHR(225) + "gina
        THIS.pgf_4c_Paginas.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Redefine todos os filtros para os valores padr" + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_Datas.Value    = DATE()
        loc_oPag.txt_4c_Codigo.Value   = ""
        loc_oPag.txt_4c_Conta.Value    = ""
        loc_oPag.txt_4c_DConta.Value   = ""
        loc_oPag.txt_4c_Base.Value     = ""
        loc_oPag.txt_4c_DBase.Value    = ""
        loc_oPag.txt_4c_Nvl2.Value     = ""
        loc_oPag.txt_4c_DNvl2.Value    = ""
        loc_oPag.txt_4c_Nvl3.Value     = ""
        loc_oPag.txt_4c_DNvl3.Value    = ""
        loc_oPag.txt_4c_Nvl4.Value     = ""
        loc_oPag.txt_4c_DNvl4.Value    = ""
        loc_oPag.obj_4c_OptLocal.Value = 1
        loc_oPag.obj_4c_OptOrdem.Value = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dData     = loc_oPag.txt_4c_Datas.Value
            .this_cCods     = ALLTRIM(loc_oPag.txt_4c_Codigo.Value)
            .this_cConta    = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
            .this_cDConta   = ALLTRIM(loc_oPag.txt_4c_DConta.Value)
            .this_cBase     = ALLTRIM(loc_oPag.txt_4c_Base.Value)
            .this_cNvl2     = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
            .this_cNvl3     = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
            .this_cNvl4     = ALLTRIM(loc_oPag.txt_4c_Nvl4.Value)
            .this_nOptLocal = loc_oPag.obj_4c_OptLocal.Value
            .this_nOptOrdem = loc_oPag.obj_4c_OptOrdem.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Vincula eventos (BINDEVENT) dos campos de filtro
    *   interativos da Page1 - primeira metade (Fase 5/8):
    *   Conta (Vendedor), DConta (descricao), Base (nivel 1) e Nvl2 (nivel 2).
    *   BINDEVENT exige metodos PUBLIC - handlers abaixo sem PROTECTED.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        BINDEVENT(loc_oPag.txt_4c_Conta,  "KeyPress", THIS, "TeclaVendedor")
        BINDEVENT(loc_oPag.txt_4c_DConta, "KeyPress", THIS, "TeclaDescVendedor")
        BINDEVENT(loc_oPag.txt_4c_Base,   "KeyPress", THIS, "TeclaBase")
        BINDEVENT(loc_oPag.txt_4c_Base,   "InteractiveChange", THIS, "LimparBaseDescendentes")
        BINDEVENT(loc_oPag.txt_4c_Nvl2,   "KeyPress", THIS, "TeclaNvl2")
        BINDEVENT(loc_oPag.txt_4c_Nvl2,   "InteractiveChange", THIS, "LimparNvl2Descendentes")
        BINDEVENT(loc_oPag.txt_4c_Nvl3,   "KeyPress", THIS, "TeclaNvl3")
        BINDEVENT(loc_oPag.txt_4c_Nvl3,   "InteractiveChange", THIS, "LimparNvl3Descendentes")
        BINDEVENT(loc_oPag.txt_4c_Nvl4,   "KeyPress", THIS, "TeclaNvl4")
        BINDEVENT(loc_oPag.txt_4c_Nvl4,   "InteractiveChange", THIS, "LimparNvl4Descendentes")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaVendedor - Handler KeyPress de txt_4c_Conta (codigo do vendedor)
    *   ENTER(13) / TAB(9) / F4(115): valida ou abre busca de vendedor.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaVendedor(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarVendedor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVendedor - Verifica codigo digitado; abre busca se necessario
    *--------------------------------------------------------------------------
    PROCEDURE ValidarVendedor()
        LOCAL loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaVendedor()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaVendedor - Lista vendedores com controle de acesso (SigCdAcJ)
    *   Equivalente ao getConta.Valid / getDConta.Valid do legado.
    *   SQL filtra SigCdCli pelo grupo padrao de vendedores e pelos jobs
    *   acessiveis ao usuario logado em SigCdAcJ.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaVendedor()
        LOCAL loc_cGrPadVens, loc_cSQL, loc_nResult, loc_oLookup, loc_oPag
        loc_oPag       = THIS.pgf_4c_Paginas.Page1
        loc_cGrPadVens = ""
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_cGrPadVens = ALLTRIM(THIS.this_oRelatorio.this_cGrPadVens)
        ENDIF

        loc_cSQL = "SELECT a.iclis AS Cods, a.rclis AS Descs " + ;
                   "FROM SigCdCli a " + ;
                   "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
                   "AND (b.Coletors <> 10 " + ;
                   "OR (b.Coletors = 10 " + ;
                   "AND a.IClis NOT IN (" + ;
                   "SELECT DISTINCT c.Jobs FROM SigCdAcJ c " + ;
                   "WHERE c.Jobs NOT IN (" + ;
                   "SELECT DISTINCT d.Jobs FROM SigCdAcJ d " + ;
                   "WHERE d.Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + "))))"
        IF !EMPTY(loc_cGrPadVens)
            loc_cSQL = loc_cSQL + " AND a.grupos = " + EscaparSQL(loc_cGrPadVens)
        ENDIF
        loc_cSQL = loc_cSQL + " ORDER BY a.rclis"

        IF USED("cursor_4c_BuscaVend")
            USE IN SELECT("cursor_4c_BuscaVend")
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaVend")
        IF loc_nResult > 0
            IF RECCOUNT("cursor_4c_BuscaVend") > 0
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaVend"
                    loc_oLookup.DefinirCursor("cursor_4c_BuscaVend", "Cods", "Descs", ;
                        "Sele" + CHR(231) + CHR(227) + "o de Vendedor")
                    IF loc_oLookup.Mostrar()
                        loc_oPag.txt_4c_Conta.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                        loc_oPag.txt_4c_DConta.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Nenhum vendedor encontrado.", "Aviso")
            ENDIF
            IF USED("cursor_4c_BuscaVend")
                USE IN SELECT("cursor_4c_BuscaVend")
            ENDIF
        ELSE
            MsgErro("Erro ao buscar vendedores.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDescVendedor - Handler KeyPress de txt_4c_DConta (nome do vendedor)
    *   getDConta.When legado: campo habilitado apenas quando getConta eh vazio.
    *   ENTER(13) / TAB(9) / F4(115): abre busca de vendedor por nome.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDescVendedor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_Conta.Value))
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarDescVendedor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDescVendedor - Valida descricao e abre busca de vendedor
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDescVendedor()
        LOCAL loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_DConta.Value)
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_Conta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaVendedor()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaBase - Handler KeyPress de txt_4c_Base (nivel 1 da localizacao)
    *   ENTER(13) / TAB(9) / F4(115): valida codigo ou abre busca de base.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaBase(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarBase()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarBase - Valida codigo de base contra cursor_4c_SigLcNv1 do BO
    *   Equivalente ao getBase.Valid (fwbuscaext em SigLcNv1) do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarBase()
        LOCAL loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Base.Value)
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DBase.Value = ""
            RETURN
        ENDIF
        IF USED("cursor_4c_SigLcNv1")
            SELECT cursor_4c_SigLcNv1
            LOCATE FOR ALLTRIM(Cods) = loc_cValor
            IF FOUND()
                loc_oPag.txt_4c_DBase.Value = ALLTRIM(Descs)
            ELSE
                THIS.AbrirBuscaBase()
            ENDIF
        ELSE
            THIS.AbrirBuscaBase()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaBase - Lista opcoes de base (nivel 1 de localizacao)
    *   Usa cursor_4c_SigLcNv1 do BO; fallback para SQLEXEC se nao disponivel.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaBase()
        LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF USED("cursor_4c_BuscaBase")
            USE IN SELECT("cursor_4c_BuscaBase")
        ENDIF
        IF USED("cursor_4c_SigLcNv1")
            SELECT Cods, Descs FROM cursor_4c_SigLcNv1 ;
                ORDER BY Cods ;
                INTO CURSOR cursor_4c_BuscaBase READWRITE
        ELSE
            loc_cSQL    = "SELECT Cods, Descs FROM SigLcNv1 ORDER BY Cods"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaBase")
            IF loc_nResult < 1
                MsgErro("Erro ao buscar bases de localiza" + CHR(231) + ;
                    CHR(227) + "o.", "Erro")
                RETURN
            ENDIF
        ENDIF
        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
        IF VARTYPE(loc_oLookup) = "O"
            loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaBase"
            loc_oLookup.DefinirCursor("cursor_4c_BuscaBase", "Cods", "Descs", ;
                "Localiza" + CHR(231) + CHR(227) + "o Base")
            IF loc_oLookup.Mostrar()
                loc_oPag.txt_4c_Base.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                loc_oPag.txt_4c_DBase.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                THIS.LimparBaseDescendentes()
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaBase")
            USE IN SELECT("cursor_4c_BuscaBase")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparBaseDescendentes - Limpa todos os niveis filhos de Base
    *   Equivalente ao getBase.InteractiveChange do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparBaseDescendentes()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DBase.Value  = ""
        loc_oPag.txt_4c_Nvl2.Value   = ""
        loc_oPag.txt_4c_DNvl2.Value  = ""
        loc_oPag.txt_4c_Nvl3.Value   = ""
        loc_oPag.txt_4c_DNvl3.Value  = ""
        loc_oPag.txt_4c_Nvl4.Value   = ""
        loc_oPag.txt_4c_DNvl4.Value  = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaNvl2 - Handler KeyPress de txt_4c_Nvl2 (segundo nivel localizacao)
    *   getNvl2.When legado: bloqueia entrada se Base estiver vazio.
    *   ENTER(13) / TAB(9) / F4(115): valida ou abre busca de nivel 2.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaNvl2(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Base.Value))
            MsgAviso("N" + CHR(237) + "vel anterior n" + CHR(227) + "o informado.", "Aviso")
            loc_oPag.txt_4c_Nvl2.Value = ""
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarNvl2()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNvl2 - Valida codigo de nivel 2 contra cursor_4c_SigLcNv2 do BO
    *   Filtra por Cods = Base atual; equivalente ao getNvl2.Valid do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNvl2()
        LOCAL loc_cNivel, loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Base.Value)
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DNvl2.Value = ""
            RETURN
        ENDIF
        IF USED("cursor_4c_SigLcNv2")
            SELECT cursor_4c_SigLcNv2
            LOCATE FOR ALLTRIM(Cods) = loc_cNivel AND ALLTRIM(Codigo) = loc_cValor
            IF FOUND()
                loc_oPag.txt_4c_DNvl2.Value = ALLTRIM(Descs)
            ELSE
                THIS.AbrirBuscaNvl2()
            ENDIF
        ELSE
            THIS.AbrirBuscaNvl2()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaNvl2 - Lista opcoes de nivel 2 filtradas pela Base atual
    *   Equivalente ao fwBuscaSel em CrSigLcNv2 do legado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaNvl2()
        LOCAL loc_cNivel, loc_oLookup, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Base.Value)
        IF USED("cursor_4c_BuscaNvl2")
            USE IN SELECT("cursor_4c_BuscaNvl2")
        ENDIF
        IF USED("cursor_4c_SigLcNv2")
            SELECT Codigo, Descs FROM cursor_4c_SigLcNv2 ;
                WHERE ALLTRIM(Cods) = m.loc_cNivel ;
                ORDER BY Codigo ;
                INTO CURSOR cursor_4c_BuscaNvl2 READWRITE
        ELSE
            MsgErro("Cursor de n" + CHR(237) + "vel 2 n" + CHR(227) + ;
                "o dispon" + CHR(237) + "vel.", "Erro")
            RETURN
        ENDIF
        IF RECCOUNT("cursor_4c_BuscaNvl2") > 0
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaNvl2"
                loc_oLookup.DefinirCursor("cursor_4c_BuscaNvl2", "Codigo", "Descs", ;
                    "Segundo N" + CHR(237) + "vel de Localiza" + CHR(231) + CHR(227) + "o")
                IF loc_oLookup.Mostrar()
                    loc_oPag.txt_4c_Nvl2.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                    loc_oPag.txt_4c_DNvl2.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                    THIS.LimparNvl2Descendentes()
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Nenhum segundo n" + CHR(237) + "vel encontrado " + ;
                "para a base informada.", "Aviso")
        ENDIF
        IF USED("cursor_4c_BuscaNvl2")
            USE IN SELECT("cursor_4c_BuscaNvl2")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparNvl2Descendentes - Limpa niveis filhos de Nvl2
    *   Equivalente ao getNvl2.InteractiveChange do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparNvl2Descendentes()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DNvl2.Value = ""
        loc_oPag.txt_4c_Nvl3.Value  = ""
        loc_oPag.txt_4c_DNvl3.Value = ""
        loc_oPag.txt_4c_Nvl4.Value  = ""
        loc_oPag.txt_4c_DNvl4.Value = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaNvl3 - Handler KeyPress de txt_4c_Nvl3 (terceiro nivel localizacao)
    *   getNvl3.When legado: bloqueia entrada se Nvl2 estiver vazio.
    *   ENTER(13) / TAB(9) / F4(115): valida ou abre busca de nivel 3.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaNvl3(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Nvl2.Value))
            MsgAviso("N" + CHR(237) + "vel anterior n" + CHR(227) + "o informado.", "Aviso")
            loc_oPag.txt_4c_Nvl3.Value = ""
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarNvl3()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNvl3 - Valida codigo de nivel 3 contra cursor_4c_SigLcNv3 do BO
    *   Filtra por Cods = Nvl2 atual; equivalente ao getNvl3.Valid do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNvl3()
        LOCAL loc_cNivel, loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DNvl3.Value = ""
            RETURN
        ENDIF
        IF USED("cursor_4c_SigLcNv3")
            SELECT cursor_4c_SigLcNv3
            LOCATE FOR ALLTRIM(Cods) = loc_cNivel AND ALLTRIM(Codigo) = loc_cValor
            IF FOUND()
                loc_oPag.txt_4c_DNvl3.Value = ALLTRIM(Descs)
            ELSE
                THIS.AbrirBuscaNvl3()
            ENDIF
        ELSE
            THIS.AbrirBuscaNvl3()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaNvl3 - Lista opcoes de nivel 3 filtradas pelo Nvl2 atual
    *   Equivalente ao fwBuscaSel em CrSigLcNv3 do legado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaNvl3()
        LOCAL loc_cNivel, loc_oLookup, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
        IF USED("cursor_4c_BuscaNvl3")
            USE IN SELECT("cursor_4c_BuscaNvl3")
        ENDIF
        IF USED("cursor_4c_SigLcNv3")
            SELECT Codigo, Descs FROM cursor_4c_SigLcNv3 ;
                WHERE ALLTRIM(Cods) = m.loc_cNivel ;
                ORDER BY Codigo ;
                INTO CURSOR cursor_4c_BuscaNvl3 READWRITE
        ELSE
            MsgErro("Cursor de n" + CHR(237) + "vel 3 n" + CHR(227) + ;
                "o dispon" + CHR(237) + "vel.", "Erro")
            RETURN
        ENDIF
        IF RECCOUNT("cursor_4c_BuscaNvl3") > 0
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaNvl3"
                loc_oLookup.DefinirCursor("cursor_4c_BuscaNvl3", "Codigo", "Descs", ;
                    "Terceiro N" + CHR(237) + "vel de Localiza" + CHR(231) + CHR(227) + "o")
                IF loc_oLookup.Mostrar()
                    loc_oPag.txt_4c_Nvl3.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                    loc_oPag.txt_4c_DNvl3.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                    THIS.LimparNvl3Descendentes()
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Nenhum terceiro n" + CHR(237) + "vel encontrado " + ;
                "para o segundo n" + CHR(237) + "vel informado.", "Aviso")
        ENDIF
        IF USED("cursor_4c_BuscaNvl3")
            USE IN SELECT("cursor_4c_BuscaNvl3")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparNvl3Descendentes - Limpa niveis filhos de Nvl3
    *   Equivalente ao getNvl3.InteractiveChange do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparNvl3Descendentes()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DNvl3.Value = ""
        loc_oPag.txt_4c_Nvl4.Value  = ""
        loc_oPag.txt_4c_DNvl4.Value = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaNvl4 - Handler KeyPress de txt_4c_Nvl4 (quarto nivel localizacao)
    *   getNvl4.When legado: bloqueia entrada se Nvl3 estiver vazio.
    *   ENTER(13) / TAB(9) / F4(115): valida ou abre busca de nivel 4.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaNvl4(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Nvl3.Value))
            MsgAviso("N" + CHR(237) + "vel anterior n" + CHR(227) + "o informado.", "Aviso")
            loc_oPag.txt_4c_Nvl4.Value = ""
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.ValidarNvl4()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNvl4 - Valida codigo de nivel 4 contra cursor_4c_SigLcNv4 do BO
    *   Filtra por Cods = Nvl3 atual; equivalente ao getNvl4.Valid do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNvl4()
        LOCAL loc_cNivel, loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Nvl4.Value)
        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DNvl4.Value = ""
            RETURN
        ENDIF
        IF USED("cursor_4c_SigLcNv4")
            SELECT cursor_4c_SigLcNv4
            LOCATE FOR ALLTRIM(Cods) = loc_cNivel AND ALLTRIM(Codigo) = loc_cValor
            IF FOUND()
                loc_oPag.txt_4c_DNvl4.Value = ALLTRIM(Descs)
            ELSE
                THIS.AbrirBuscaNvl4()
            ENDIF
        ELSE
            THIS.AbrirBuscaNvl4()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaNvl4 - Lista opcoes de nivel 4 filtradas pelo Nvl3 atual
    *   Equivalente ao fwBuscaSel em CrSigLcNv4 do legado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaNvl4()
        LOCAL loc_cNivel, loc_oLookup, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
        IF USED("cursor_4c_BuscaNvl4")
            USE IN SELECT("cursor_4c_BuscaNvl4")
        ENDIF
        IF USED("cursor_4c_SigLcNv4")
            SELECT Codigo, Descs FROM cursor_4c_SigLcNv4 ;
                WHERE ALLTRIM(Cods) = m.loc_cNivel ;
                ORDER BY Codigo ;
                INTO CURSOR cursor_4c_BuscaNvl4 READWRITE
        ELSE
            MsgErro("Cursor de n" + CHR(237) + "vel 4 n" + CHR(227) + ;
                "o dispon" + CHR(237) + "vel.", "Erro")
            RETURN
        ENDIF
        IF RECCOUNT("cursor_4c_BuscaNvl4") > 0
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaNvl4"
                loc_oLookup.DefinirCursor("cursor_4c_BuscaNvl4", "Codigo", "Descs", ;
                    "Quarto N" + CHR(237) + "vel de Localiza" + CHR(231) + CHR(227) + "o")
                IF loc_oLookup.Mostrar()
                    loc_oPag.txt_4c_Nvl4.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                    loc_oPag.txt_4c_DNvl4.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                ENDIF
            ENDIF
        ELSE
            MsgAviso("Nenhum quarto n" + CHR(237) + "vel encontrado " + ;
                "para o terceiro n" + CHR(237) + "vel informado.", "Aviso")
        ENDIF
        IF USED("cursor_4c_BuscaNvl4")
            USE IN SELECT("cursor_4c_BuscaNvl4")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparNvl4Descendentes - Limpa descricao de nivel 4
    *   Equivalente ao getNvl4.InteractiveChange do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparNvl4Descendentes()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_DNvl4.Value = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDataParaRelatorio - Valida se data foi informada (obrigatoria)
    *   Equivalente ao guard clause do btnReport.Click legado:
    *     If Empty(ThisForm.getDatas.Value) -> Messagebox + Return 0
    *   Retorna .T. se data valida, .F. se invalida (exibe aviso).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDataParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPag.txt_4c_Datas.Value)
            MsgAviso("Data inv" + CHR(225) + "lida!", "Aviso")
            loc_oPag.txt_4c_Datas.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em tela (preview)
    *   Botao 1 do cmg_4c_Botoes. Requer data valida.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !THIS.ValidarDataParaRelatorio()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            LOCAL loc_cMsg
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de impressora
    *   Botao 2 do cmg_4c_Botoes. Requer data valida.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF !THIS.ValidarDataParaRelatorio()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            LOCAL loc_cMsg
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para Excel
    *   Botao 3 do cmg_4c_Botoes. Requer data valida.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        IF !THIS.ValidarDataParaRelatorio()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.GerarExcel()
            LOCAL loc_cMsg
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario de relatorio
    *   Botao 4 (Cancel=.T.) do cmg_4c_Botoes. Sem validacao de data.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os controles de filtro
    *   par_lHabilitar: .T. = habilita edicao, .F. = somente leitura
    *   Forms REPORT chamam com .T. no InicializarForm (estado normal).
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oPag
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_Datas.ReadOnly    = !loc_lHab
        loc_oPag.txt_4c_Codigo.ReadOnly   = !loc_lHab
        loc_oPag.txt_4c_Conta.ReadOnly    = !loc_lHab
        loc_oPag.txt_4c_Base.ReadOnly     = !loc_lHab
        loc_oPag.txt_4c_Nvl2.ReadOnly     = !loc_lHab
        loc_oPag.txt_4c_Nvl3.ReadOnly     = !loc_lHab
        loc_oPag.txt_4c_Nvl4.ReadOnly     = !loc_lHab
        loc_oPag.obj_4c_OptLocal.Enabled  = loc_lHab
        loc_oPag.obj_4c_OptOrdem.Enabled  = loc_lHab
        THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHab
        THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lHab
        THIS.cmg_4c_Botoes.Buttons(3).Enabled = loc_lHab
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
