*==============================================================================
* FORMSIGREEQR.PRG
* Relatorio de Posicao de Estoque Retroativo
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREEQR.SCX (frmrelatorio)
*
* Filtros:
*   - Empresa (codigo + descricao) - campo obrigatorio
*   - Grupo de Produto (codigo + descricao)
*   - Referencia de Estoque: 1=Atual / 2=Retroativo (data especifica)
*   - Moeda para Conversao
*   - Calculo de Custo: 1=Total / 2=por Grupo
*   - Grupo de Calculo de Custo (visivel somente quando calcusto=2)
*   - Grade Selecao: grupos/contas de estoque para incluir no relatorio
*
* FASES CONCLUIDAS:
*   Fase 1/8 - BO - Propriedades e Init
*   Fase 2/8 - BO - Metodos completos (PrepararDados, Imprimir, Visualizar, etc.)
*   Fase 3/8 - Form - Estrutura Base
*     * Propriedades visuais (Width=800, Height=600, DataSession=2)
*     * Init() / InicializarForm() / Destroy()
*     * ConfigurarCabecalho() / ConfigurarBotoes() / ConfigurarPageFrame()
*     * Inicializacao do cursor Selecao via BO.InicializarSelecao()
*   Fase 4/8 - Form - Grid e controles de filtro na Page1
*     * ConfigurarPaginaFiltros() - todos os filtros + grade Selecao
*     * LimparCampos() / FormParaRelatorio()
*     * Handlers: botoes CommandGroup, optiongroups, lookups, grade
*   Fase 5/8 - Form - Campos Principais (Parte 1) - COMPLETO
*     * Form RELATORIO (layout flat) nao tem Page2 separada de edicao.
*     * ConfigurarPaginaDados() delega para ConfigurarPaginaFiltros().
*     * Todos os campos (cnt_4c_Cabecalho, TextBoxes, Labels) ja estavam
*       implementados na Fase 4 dentro de ConfigurarPaginaFiltros().
*     * Sem codigo adicional necessario para esta fase.
*   Fase 6/8 - Form - Campos Restantes e Lookups - COMPLETO
*     * Form RELATORIO (layout flat): ConfigurarPaginaDados() ja delegava para
*       ConfigurarPaginaFiltros() que tinha todos os campos desde a Fase 4.
*     * Adicionados BINDEVENTs DblClick para todos os 8 campos de lookup
*       (CdEmpresa, DsEmpresa, CdGrupo, DsGrupo, CdMoeda, DsMoeda,
*        CdGrupoCalc, DsGrupoCalc) com respectivos handlers Txt*DblClick().
*     * cnt_4c_BotoesAcao (Salvar/Cancelar): NAO aplicavel em form REPORT.
*   Fase 7/8 - Form - Eventos Principais - COMPLETO
*     * Validar*() e AbrirBusca*() para todos os pares codigo/descricao.
*     * AjustarCamposPorRefEstoque() / AjustarCamposPorCalcusto().
*     * CmgVisualizarClick / CmgImprimirClick: SetFocus no campo invalido
*       apos falha de validacao (fidelidade UX ao original).
*   Fase 8/8 - Integracao (config.prg + menu.prg) - CONCLUIDO
*==============================================================================

DEFINE CLASS FormSIGREEQR AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=600)
    Height      = 600
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

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura completa do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + ;
                           CHR(227) + "o de Estoque Retroativo"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGREEQRBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREEQRBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Carrega cursor Selecao (grupos/contas de estoque para o grid)
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    THIS.this_oRelatorio.InicializarSelecao()
                ENDIF

                *-- Cabecalho escuro com titulo
                THIS.ConfigurarCabecalho()

                *-- Botoes do relatorio (Visualizar/Imprimir/Excel/Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com pagina de filtros e grade de selecao
                THIS.ConfigurarPageFrame()

                *-- Popula Page1 com todos os controles de filtro e grade
                THIS.ConfigurarPaginaFiltros()

                *-- Inicializa campos com valores padrao (empresa corrente)
                THIS.LimparCampos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.Visible   = .T.
                loc_lSucesso   = .T.
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
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
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

            *-- Sombra deslocada (efeito 3D)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + ;
                             CHR(227) + "o de Estoque Retroativo"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco sobre fundo escuro
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + ;
                             CHR(227) + "o de Estoque Retroativo"
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
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Posicao: cmg_4c_Botoes.Left=529, seguindo geometria do framework.vcx
    *   Buttons(2)=Imprimir tem Visible=.F. conforme original (ocultado no legado)
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

            *-- Visualizar (ToolTipText="Processar" conforme original)
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
                .ToolTipText     = "Processar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Imprimir (Visible=.F. conforme original)
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
                .Visible         = .F.
            ENDWITH

            *-- Excel
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

            *-- Encerrar - Cancel=.T. garante que ESC fecha o form
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

        *-- BINDEVENTs para botoes do CommandGroup
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "CmgVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "CmgImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "CmgExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "CmgEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame abaixo do cabecalho para filtros e grade
    *   Page1 ("Filtros"): todos os campos de filtro + grade interativa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1

        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

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
    * ConfigurarPaginaFiltros - Popula Page1 com filtros e grade interativa
    *
    *   Coordenadas relativas a Page1 (= coordenada_original - 85):
    *     optRfestoque:     top=62,  left=195  w=142 h=52
    *     getDataSaldo:     top=82,  left=301  w=79  h=25
    *     get_cd_empresa:   top=109, left=301  w=33  h=25
    *     get_ds_empresa:   top=109, left=336  w=290 h=25
    *     get_cd_grupo:     top=136, left=301  w=33  h=25
    *     get_ds_grupo:     top=136, left=336  w=290 h=25
    *     get_cd_moeda:     top=163, left=301  w=33  h=25
    *     get_ds_moeda:     top=163, left=336  w=107 h=23
    *     get_cd_grupo_calc:top=188, left=301  w=33  h=25 (oculto)
    *     get_ds_grupo_calc:top=188, left=336  w=290 h=25 (oculto)
    *     opt_calcusto:     top=213, left=300  w=108 h=25
    *     Grade:            top=246, left=302  w=244 h=167
    *     SelTudo:          top=289, left=549  w=45  h=45
    *     apaga:            top=334, left=549  w=45  h=45
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPag, loc_oGrd
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Sec 1: Referencia de Estoque + Data Saldo
        loc_oPag.AddObject("lbl_4c_RefEstoque", "Label")
        WITH loc_oPag.lbl_4c_RefEstoque
            .Top       = 62
            .Left      = 82
            .Width     = 110
            .Height    = 18
            .Caption   = "Refer. Estoque :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("obj_4c_OptRfestoque", "OptionGroup")
        WITH loc_oPag.obj_4c_OptRfestoque
            .Top         = 147
            .Left        = 195
            .Width       = 147
            .Height      = 52
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPag.obj_4c_OptRfestoque.Buttons(1)
            .Top       = 2
            .Left      = 5
            .Width     = 132
            .Height    = 22
            .Caption   = "Atual"
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPag.obj_4c_OptRfestoque.Buttons(2)
            .Top       = 28
            .Left      = 5
            .Width     = 132
            .Height    = 22
            .Caption   = "Retroativo"
            .BackStyle = 0
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        BINDEVENT(loc_oPag.obj_4c_OptRfestoque, "Click", THIS, "OptRfestoqueClick")

        loc_oPag.AddObject("lbl_4c_DataSaldo", "Label")
        WITH loc_oPag.lbl_4c_DataSaldo
            .Top       = 86
            .Left      = 220
            .Width     = 78
            .Height    = 18
            .Caption   = "Data Saldo:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DataSaldo", "TextBox")
        WITH loc_oPag.txt_4c_DataSaldo
            .Top      = 82
            .Left     = 301
            .Width    = 79
            .Height   = 25
            .Value    = {}
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Visible  = .T.
        ENDWITH

        *-- Sec 2: Empresa (codigo + descricao)
        loc_oPag.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPag.lbl_4c_Empresa
            .Top       = 114
            .Left      = 247
            .Width     = 50
            .Height    = 18
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH loc_oPag.txt_4c_CdEmpresa
            .Top      = 109
            .Left     = 301
            .Width    = 33
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_CdEmpresa, "KeyPress", THIS, "TxtCdEmpresaKeyPress")
        BINDEVENT(loc_oPag.txt_4c_CdEmpresa, "DblClick", THIS, "TxtCdEmpresaDblClick")

        loc_oPag.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH loc_oPag.txt_4c_DsEmpresa
            .Top      = 109
            .Left     = 336
            .Width    = 290
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_DsEmpresa, "KeyPress", THIS, "TxtDsEmpresaKeyPress")
        BINDEVENT(loc_oPag.txt_4c_DsEmpresa, "DblClick", THIS, "TxtDsEmpresaDblClick")

        *-- Sec 3: Grupo de Produto (codigo + descricao)
        loc_oPag.AddObject("lbl_4c_GrupoProd", "Label")
        WITH loc_oPag.lbl_4c_GrupoProd
            .Top       = 141
            .Left      = 221
            .Width     = 77
            .Height    = 18
            .Caption   = "Grupo Produto:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_CdGrupo", "TextBox")
        WITH loc_oPag.txt_4c_CdGrupo
            .Top      = 136
            .Left     = 301
            .Width    = 33
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_CdGrupo, "KeyPress", THIS, "TxtCdGrupoKeyPress")
        BINDEVENT(loc_oPag.txt_4c_CdGrupo, "DblClick", THIS, "TxtCdGrupoDblClick")

        loc_oPag.AddObject("txt_4c_DsGrupo", "TextBox")
        WITH loc_oPag.txt_4c_DsGrupo
            .Top      = 136
            .Left     = 336
            .Width    = 290
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_DsGrupo, "KeyPress", THIS, "TxtDsGrupoKeyPress")
        BINDEVENT(loc_oPag.txt_4c_DsGrupo, "DblClick", THIS, "TxtDsGrupoDblClick")

        *-- Sec 4: Moeda para Conversao (codigo + descricao)
        loc_oPag.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPag.lbl_4c_Moeda
            .Top       = 168
            .Left      = 191
            .Width     = 108
            .Height    = 18
            .Caption   = "Moeda p/Convers" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oPag.txt_4c_CdMoeda
            .Top      = 163
            .Left     = 301
            .Width    = 33
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_CdMoeda, "KeyPress", THIS, "TxtCdMoedaKeyPress")
        BINDEVENT(loc_oPag.txt_4c_CdMoeda, "DblClick", THIS, "TxtCdMoedaDblClick")

        loc_oPag.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oPag.txt_4c_DsMoeda
            .Top      = 163
            .Left     = 336
            .Width    = 107
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_DsMoeda, "KeyPress", THIS, "TxtDsMoedaKeyPress")
        BINDEVENT(loc_oPag.txt_4c_DsMoeda, "DblClick", THIS, "TxtDsMoedaDblClick")

        *-- Sec 5: Grupo de Calculo de Custo - inicialmente oculto
        loc_oPag.AddObject("lbl_4c_GrupoCalc", "Label")
        WITH loc_oPag.lbl_4c_GrupoCalc
            .Top       = 193
            .Left      = 259
            .Width     = 40
            .Height    = 18
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        loc_oPag.AddObject("txt_4c_CdGrupoCalc", "TextBox")
        WITH loc_oPag.txt_4c_CdGrupoCalc
            .Top      = 188
            .Left     = 301
            .Width    = 33
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .F.
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_CdGrupoCalc, "KeyPress", THIS, "TxtCdGrupoCalcKeyPress")
        BINDEVENT(loc_oPag.txt_4c_CdGrupoCalc, "DblClick", THIS, "TxtCdGrupoCalcDblClick")

        loc_oPag.AddObject("txt_4c_DsGrupoCalc", "TextBox")
        WITH loc_oPag.txt_4c_DsGrupoCalc
            .Top      = 188
            .Left     = 336
            .Width    = 290
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .F.
        ENDWITH
        BINDEVENT(loc_oPag.txt_4c_DsGrupoCalc, "KeyPress", THIS, "TxtDsGrupoCalcKeyPress")
        BINDEVENT(loc_oPag.txt_4c_DsGrupoCalc, "DblClick", THIS, "TxtDsGrupoCalcDblClick")

        *-- Sec 6: Calculo de Custo (Total / Por Grupo)
        loc_oPag.AddObject("lbl_4c_CalcCusto", "Label")
        WITH loc_oPag.lbl_4c_CalcCusto
            .Top       = 218
            .Left      = 211
            .Width     = 86
            .Height    = 18
            .Caption   = "C" + CHR(225) + "lculo de Custo:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("obj_4c_OptCalcusto", "OptionGroup")
        WITH loc_oPag.obj_4c_OptCalcusto
            .Top         = 213
            .Left        = 300
            .Width       = 108
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Top       = 2
                .Left      = 0
                .Width     = 53
                .Height    = 21
                .Caption   = "Total"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Top       = 2
                .Left      = 55
                .Width     = 53
                .Height    = 21
                .Caption   = "Por Grupo"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPag.obj_4c_OptCalcusto, "Click", THIS, "OptCalcustoClick")

        *-- Sec 7: Grade interativa de grupos/contas de estoque
        *   Column1: CheckBox marcas | Column2: grupos (RO) | Column3: contas (RO)
        loc_oPag.AddObject("grd_4c_Grade", "Grid")
        loc_oGrd = loc_oPag.grd_4c_Grade
        loc_oGrd.ColumnCount = 3
        WITH loc_oGrd
            .Top                = 246
            .Left               = 302
            .Width              = 244
            .Height             = 167
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
            .Visible            = .T.
        ENDWITH

        *-- Garante que cursor Selecao existe antes de definir ControlSource
        IF !USED("Selecao")
            CREATE CURSOR Selecao (marcas n(1), grupos c(10), contas c(10))
        ENDIF

        *-- Column1: CheckBox para marcar/desmarcar grupos e contas
        loc_oGrd.Column1.AddObject("Check1", "CheckBox")
        loc_oGrd.Column1.Check1.Caption  = ""
        loc_oGrd.Column1.CurrentControl  = "Check1"
        loc_oGrd.Column1.ControlSource   = "Selecao.marcas"
        loc_oGrd.Column1.Width           = 30
        loc_oGrd.Column1.Header1.Caption = ""

        *-- Column2: Grupo (somente leitura)
        loc_oGrd.Column2.ControlSource   = "Selecao.grupos"
        loc_oGrd.Column2.Width           = 107
        loc_oGrd.Column2.ReadOnly        = .T.
        loc_oGrd.Column2.Header1.Caption = "Grupo"

        *-- Column3: Conta (somente leitura)
        loc_oGrd.Column3.ControlSource   = "Selecao.contas"
        loc_oGrd.Column3.Width           = 107
        loc_oGrd.Column3.ReadOnly        = .T.
        loc_oGrd.Column3.Header1.Caption = "Conta"

        *-- RecordSource apenas se cursor Selecao foi populado
        IF USED("Selecao")
            loc_oGrd.RecordSource     = "Selecao"
            loc_oGrd.RecordSourceType = 1
        ENDIF

        BINDEVENT(loc_oGrd.Column1.Check1, "Click", THIS, "ChkGradeClick")
        TRY
            BINDEVENT(loc_oGrd.Column3.Text1, "GotFocus", THIS, "GradeRedirecionarFoco")
        CATCH
        ENDTRY

        *-- Sec 8: Botoes de selecao da grade (ao lado direito da grade)
        loc_oPag.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH loc_oPag.cmd_4c_SelTudo
            .Top           = 374
            .Left          = 549
            .Width         = 45
            .Height        = 45
            .Caption       = "Todos"
            .FontName      = "Tahoma"
            .FontSize      = 7
            .FontBold      = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .MousePointer  = 15
            .ToolTipText   = "Selecionar Todos"
            .Themes        = .F.
            .WordWrap      = .T.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")

        loc_oPag.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH loc_oPag.cmd_4c_Apaga
            .Top           = 419
            .Left          = 549
            .Width         = 45
            .Height        = 45
            .Caption       = "Limpar"
            .FontName      = "Tahoma"
            .FontSize      = 7
            .FontBold      = .T.
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .MousePointer  = 15
            .ToolTipText   = "Desmarcar Todos"
            .Themes        = .F.
            .WordWrap      = .T.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPag.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Alias canonico do pipeline (delega para filtros)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarPaginaFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Alias canonico do pipeline (delega para filtros)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarPaginaFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre paginas do PageFrame
    *   Form REPORT tem apenas Page1; mantido para compatibilidade de pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            RETURN
        ENDIF
        IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            THIS.pgf_4c_Paginas.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores do form para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cCdEmpresa   = ALLTRIM(loc_oPag.txt_4c_CdEmpresa.Value)
            .this_cDsEmpresa   = ALLTRIM(loc_oPag.txt_4c_DsEmpresa.Value)
            .this_cCdGrupo     = ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value)
            .this_cDsGrupo     = ALLTRIM(loc_oPag.txt_4c_DsGrupo.Value)
            .this_cCdMoeda     = ALLTRIM(loc_oPag.txt_4c_CdMoeda.Value)
            .this_cDsMoeda     = ALLTRIM(loc_oPag.txt_4c_DsMoeda.Value)
            .this_cCdGrupoCalc = ALLTRIM(loc_oPag.txt_4c_CdGrupoCalc.Value)
            .this_cDsGrupoCalc = ALLTRIM(loc_oPag.txt_4c_DsGrupoCalc.Value)
            .this_nRfEstoque   = loc_oPag.obj_4c_OptRfestoque.Value
            .this_nCalcusto    = loc_oPag.obj_4c_OptCalcusto.Value
            .this_dDataSaldo   = loc_oPag.txt_4c_DataSaldo.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos com valores padrao
    *   Empresa: codigo da empresa corrente (go_4c_Sistema.cCodEmpresa)
    *   Demais filtros: vazios / opcoes no valor 1 (Atual / Total)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag, loc_cCodEmp, loc_cSQL, loc_nResult
        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cCodEmp = ""

        IF TYPE("go_4c_Sistema") = "O" AND VARTYPE(go_4c_Sistema) = "O"
            IF PEMSTATUS(go_4c_Sistema, "cCodEmpresa", 5)
                loc_cCodEmp = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF
        ENDIF

        loc_oPag.txt_4c_CdEmpresa.Value = loc_cCodEmp
        loc_oPag.txt_4c_DsEmpresa.Value = ""

        IF !EMPTY(loc_cCodEmp) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                       EscaparSQL(loc_cCodEmp)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpInit")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_EmpInit") > 0
                SELECT cursor_4c_EmpInit
                loc_oPag.txt_4c_DsEmpresa.Value = ALLTRIM(razas)
            ENDIF
            IF USED("cursor_4c_EmpInit")
                USE IN cursor_4c_EmpInit
            ENDIF
        ENDIF

        loc_oPag.txt_4c_CdGrupo.Value     = ""
        loc_oPag.txt_4c_DsGrupo.Value     = ""
        loc_oPag.txt_4c_CdMoeda.Value     = ""
        loc_oPag.txt_4c_DsMoeda.Value     = ""
        loc_oPag.txt_4c_CdGrupoCalc.Value = ""
        loc_oPag.txt_4c_DsGrupoCalc.Value = ""
        loc_oPag.txt_4c_DataSaldo.Value   = {}

        loc_oPag.obj_4c_OptRfestoque.Value = 1
        loc_oPag.obj_4c_OptCalcusto.Value  = 1

        THIS.AjustarCamposPorRefEstoque()
        THIS.AjustarCamposPorCalcusto()
    ENDPROC

    *==========================================================================
    * HANDLERS: botoes CommandGroup
    *==========================================================================

    *--------------------------------------------------------------------------
    * CmgVisualizarClick - Transfere filtros para BO e exibe relatorio em preview
    *   Apos falha de validacao: redireciona foco para o campo invalido
    *   (fidelidade ao original que chamava SetFocus no campo problematico)
    *--------------------------------------------------------------------------
    PROCEDURE CmgVisualizarClick()
        LOCAL loc_oPag
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Atualizar()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Erro ao Visualizar")
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CdEmpresa.Value))
                loc_oPag.txt_4c_CdEmpresa.SetFocus()
            ELSE
                IF loc_oPag.obj_4c_OptCalcusto.Value = 2 AND ;
                   EMPTY(ALLTRIM(loc_oPag.txt_4c_CdGrupoCalc.Value))
                loc_oPag.txt_4c_CdGrupoCalc.SetFocus()
            ELSE
                IF loc_oPag.obj_4c_OptRfestoque.Value = 2 AND ;
                   EMPTY(loc_oPag.txt_4c_DataSaldo.Value)
                loc_oPag.txt_4c_DataSaldo.SetFocus()
                ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgImprimirClick - Transfere filtros para BO e envia relatorio para impressora
    *   Apos falha de validacao: redireciona foco para o campo invalido
    *--------------------------------------------------------------------------
    PROCEDURE CmgImprimirClick()
        LOCAL loc_oPag
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Inserir()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Erro ao Imprimir")
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CdEmpresa.Value))
                loc_oPag.txt_4c_CdEmpresa.SetFocus()
            ELSE
                IF loc_oPag.obj_4c_OptCalcusto.Value = 2 AND ;
                   EMPTY(ALLTRIM(loc_oPag.txt_4c_CdGrupoCalc.Value))
                loc_oPag.txt_4c_CdGrupoCalc.SetFocus()
            ELSE
                IF loc_oPag.obj_4c_OptRfestoque.Value = 2 AND ;
                   EMPTY(loc_oPag.txt_4c_DataSaldo.Value)
                loc_oPag.txt_4c_DataSaldo.SetFocus()
                ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgExcelClick - Exportar para Excel (nao disponivel nesta versao)
    *--------------------------------------------------------------------------
    PROCEDURE CmgExcelClick()
        MsgAviso("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + ;
            CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Excel")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE CmgEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS - aliases canonicos do pipeline (CRUD -> REPORT)
    *   Este form e do tipo frmrelatorio (filtros + visualizar/imprimir).
    *   Os eventos abaixo mapeiam os nomes CRUD canonicos do pipeline para as
    *   acoes equivalentes em um formulario de relatorio:
    *     Btn_Incluir   -> Imprimir   (acao primaria: gerar relatorio fisico)
    *     Btn_Alterar   -> Visualizar (acao secundaria: preview em tela)
    *     Btn_Visualizar-> Visualizar (preview em tela)
    *     Btn_Excluir   -> Limpar selecao (acao destrutiva no contexto report)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Acao primaria do relatorio: Imprimir
    *   Replica o comportamento original: valida filtros via FormParaRelatorio,
    *   chama o BO para preparar dados e enviar a impressora; se houver falha
    *   de validacao redireciona foco para o campo problematico.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPag
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Inserir()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Erro ao Imprimir")
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CdEmpresa.Value))
                loc_oPag.txt_4c_CdEmpresa.SetFocus()
            ELSE
                IF loc_oPag.obj_4c_OptCalcusto.Value = 2 AND ;
                   EMPTY(ALLTRIM(loc_oPag.txt_4c_CdGrupoCalc.Value))
                loc_oPag.txt_4c_CdGrupoCalc.SetFocus()
            ELSE
                IF loc_oPag.obj_4c_OptRfestoque.Value = 2 AND ;
                   EMPTY(loc_oPag.txt_4c_DataSaldo.Value)
                loc_oPag.txt_4c_DataSaldo.SetFocus()
                ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Acao secundaria do relatorio: Visualizar (preview)
    *   Mesmo comportamento de Visualizar; em forms CRUD seria "alterar
    *   registro", mas em um relatorio o equivalente proximo e regerar/refazer
    *   o preview com os filtros atualmente preenchidos.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPag
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Atualizar()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Erro ao Visualizar")
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CdEmpresa.Value))
                loc_oPag.txt_4c_CdEmpresa.SetFocus()
            ELSE
                IF loc_oPag.obj_4c_OptCalcusto.Value = 2 AND ;
                   EMPTY(ALLTRIM(loc_oPag.txt_4c_CdGrupoCalc.Value))
                loc_oPag.txt_4c_CdGrupoCalc.SetFocus()
            ELSE
                IF loc_oPag.obj_4c_OptRfestoque.Value = 2 AND ;
                   EMPTY(loc_oPag.txt_4c_DataSaldo.Value)
                loc_oPag.txt_4c_DataSaldo.SetFocus()
                ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar relatorio em preview
    *   Mapeia diretamente para CmgVisualizarClick (botao Visualizar do
    *   CommandGroup superior do form).
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oPag
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Atualizar()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                "Erro ao Visualizar")
            ENDIF
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_CdEmpresa.Value))
                loc_oPag.txt_4c_CdEmpresa.SetFocus()
            ELSE
                IF loc_oPag.obj_4c_OptCalcusto.Value = 2 AND ;
                   EMPTY(ALLTRIM(loc_oPag.txt_4c_CdGrupoCalc.Value))
                loc_oPag.txt_4c_CdGrupoCalc.SetFocus()
            ELSE
                IF loc_oPag.obj_4c_OptRfestoque.Value = 2 AND ;
                   EMPTY(loc_oPag.txt_4c_DataSaldo.Value)
                loc_oPag.txt_4c_DataSaldo.SetFocus()
                ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Acao destrutiva no contexto report: limpa selecoes
    *   Em um cadastro CRUD excluiria o registro corrente; em um relatorio o
    *   equivalente proximo e limpar as selecoes da grade de contas/grupos
    *   (mesma logica do botao cmd_4c_Apaga do legado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF !USED("Selecao")
            MsgAviso("Nenhuma sele" + CHR(231) + CHR(227) + "o para limpar.", ;
                "Sem Sele" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        IF !MsgConfirma("Limpar todas as sele" + CHR(231) + CHR(245) + ;
                "es da grade?", "Confirmar")
            RETURN
        ENDIF
        SELECT Selecao
        REPLACE ALL marcas WITH 0
        GO TOP
        IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS: OptionGroups
    *==========================================================================

    *--------------------------------------------------------------------------
    * OptRfestoqueClick - Habilita/desabilita campo Data Saldo
    *--------------------------------------------------------------------------
    PROCEDURE OptRfestoqueClick()
        THIS.AjustarCamposPorRefEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * OptCalcustoClick - Exibe/oculta campos de Grupo de Calculo de Custo
    *--------------------------------------------------------------------------
    PROCEDURE OptCalcustoClick()
        THIS.AjustarCamposPorCalcusto()
    ENDPROC

    *==========================================================================
    * HANDLERS: KeyPress dos campos de filtro (F4=115, ENTER=13, TAB=9)
    *==========================================================================

    PROCEDURE TxtCdEmpresaKeyPress(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TxtDsEmpresaKeyPress(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TxtCdGrupoKeyPress(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.ValidarCdGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TxtDsGrupoKeyPress(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaGrupo("dgrus")
        ENDIF
    ENDPROC

    PROCEDURE TxtCdMoedaKeyPress(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.ValidarCdMoeda()
        ENDIF
    ENDPROC

    PROCEDURE TxtDsMoedaKeyPress(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaMoeda("dmoes")
        ENDIF
    ENDPROC

    PROCEDURE TxtCdGrupoCalcKeyPress(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.ValidarCdGrupoCalc()
        ENDIF
    ENDPROC

    PROCEDURE TxtDsGrupoCalcKeyPress(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirBuscaGrupoCalc("dgrus")
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS: DblClick dos campos de filtro (abre lookup diretamente)
    *==========================================================================

    PROCEDURE TxtCdEmpresaDblClick()
        THIS.AbrirBuscaEmpresa()
    ENDPROC

    PROCEDURE TxtDsEmpresaDblClick()
        THIS.AbrirBuscaEmpresa()
    ENDPROC

    PROCEDURE TxtCdGrupoDblClick()
        THIS.AbrirBuscaGrupo("cgrus")
    ENDPROC

    PROCEDURE TxtDsGrupoDblClick()
        THIS.AbrirBuscaGrupo("dgrus")
    ENDPROC

    PROCEDURE TxtCdMoedaDblClick()
        THIS.AbrirBuscaMoeda("cmoes")
    ENDPROC

    PROCEDURE TxtDsMoedaDblClick()
        THIS.AbrirBuscaMoeda("dmoes")
    ENDPROC

    PROCEDURE TxtCdGrupoCalcDblClick()
        THIS.AbrirBuscaGrupoCalc("cgrus")
    ENDPROC

    PROCEDURE TxtDsGrupoCalcDblClick()
        THIS.AbrirBuscaGrupoCalc("dgrus")
    ENDPROC

    *==========================================================================
    * HANDLERS: Grade interativa de selecao
    *==========================================================================

    *--------------------------------------------------------------------------
    * ChkGradeClick - Selecao de grupos na grade
    *   Ao marcar cabecalho de grupo (contas vazia): propaga marcas para contas
    *   O proprio cabecalho fica desmarcado (apenas contas sao contabilizadas)
    *--------------------------------------------------------------------------
    PROCEDURE ChkGradeClick()
        LOCAL loc_lGrupo, loc_cGrupo
        loc_lGrupo = .F.
        loc_cGrupo = ""

        IF !USED("Selecao")
            RETURN
        ENDIF

        SELECT Selecao

        IF Selecao.marcas = 1 AND EMPTY(ALLTRIM(Selecao.contas))
            loc_cGrupo = Selecao.grupos
            SCAN WHILE Selecao.grupos = loc_cGrupo
                REPLACE Selecao.marcas WITH 1
                loc_lGrupo = .T.
            ENDSCAN
        ENDIF

        IF loc_lGrupo AND !EMPTY(loc_cGrupo)
            SELECT Selecao
            GO TOP
            LOCATE FOR Selecao.grupos = loc_cGrupo AND EMPTY(ALLTRIM(Selecao.contas))
            IF !EOF("Selecao")
                REPLACE Selecao.marcas WITH 0
            ENDIF
        ENDIF

        SELECT Selecao
        GO TOP
        THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdApagaClick - Desmarca todas as selecoes da grade
    *--------------------------------------------------------------------------
    PROCEDURE CmdApagaClick()
        IF !USED("Selecao")
            RETURN
        ENDIF
        SELECT Selecao
        REPLACE ALL marcas WITH 0
        GO TOP
        THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSelTudoClick - Marca todas as contas (nao os cabecalhos de grupo)
    *   Logica original: para cada conta filha marcada, o cabecalho de grupo
    *   correspondente e desmarcado (somente contas entram no relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE CmdSelTudoClick()
        LOCAL loc_cGrpSel, loc_cCntSel
        IF !USED("Selecao")
            RETURN
        ENDIF

        SELECT Selecao
        GO TOP
        DO WHILE !EOF("Selecao")
            REPLACE Selecao.marcas WITH 1
            loc_cGrpSel = Selecao.grupos
            loc_cCntSel = Selecao.contas

            IF !EMPTY(ALLTRIM(loc_cCntSel))
                SELECT Selecao
                GO TOP
                LOCATE FOR Selecao.grupos = loc_cGrpSel AND EMPTY(ALLTRIM(Selecao.contas))
                IF !EOF("Selecao")
                    REPLACE Selecao.marcas WITH 0
                ENDIF
            ENDIF

            SELECT Selecao
            GO TOP
            LOCATE FOR Selecao.grupos = loc_cGrpSel AND Selecao.contas = loc_cCntSel
            SKIP
        ENDDO

        SELECT Selecao
        GO TOP
        THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeRedirecionarFoco - Redireciona foco da Column3 de volta para Column1
    *--------------------------------------------------------------------------
    PROCEDURE GradeRedirecionarFoco()
        IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
            THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * METODOS PROTEGIDOS: ajuste de visibilidade
    *==========================================================================

    *--------------------------------------------------------------------------
    * AjustarCamposPorRefEstoque - Habilita/desabilita Data Saldo conforme opcao
    *   optRfestoque=1 (Atual): Data Saldo desabilitada e limpa
    *   optRfestoque=2 (Retroativo): Data Saldo habilitada (default=hoje)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarCamposPorRefEstoque()
        LOCAL loc_oPag, loc_lRetroativo
        loc_oPag        = THIS.pgf_4c_Paginas.Page1
        loc_lRetroativo = (loc_oPag.obj_4c_OptRfestoque.Value = 2)
        loc_oPag.txt_4c_DataSaldo.Enabled = loc_lRetroativo
        IF !loc_lRetroativo
            loc_oPag.txt_4c_DataSaldo.Value = {}
        ELSE
            IF EMPTY(loc_oPag.txt_4c_DataSaldo.Value)
                loc_oPag.txt_4c_DataSaldo.Value = DATE()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarCamposPorCalcusto - Exibe/oculta campos de grupo de calculo
    *   opt_calcusto=1 (Total): campos ocultos e limpos
    *   opt_calcusto=2 (Por Grupo): campos visiveis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarCamposPorCalcusto()
        LOCAL loc_oPag, loc_lPorGrupo
        loc_oPag      = THIS.pgf_4c_Paginas.Page1
        loc_lPorGrupo = (loc_oPag.obj_4c_OptCalcusto.Value = 2)
        loc_oPag.lbl_4c_GrupoCalc.Visible   = loc_lPorGrupo
        loc_oPag.txt_4c_CdGrupoCalc.Visible = loc_lPorGrupo
        loc_oPag.txt_4c_DsGrupoCalc.Visible = loc_lPorGrupo
        IF !loc_lPorGrupo
            loc_oPag.txt_4c_CdGrupoCalc.Value = ""
            loc_oPag.txt_4c_DsGrupoCalc.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * METODOS PROTEGIDOS: validacoes de campo (codigo ? descricao)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCdEmpresa - Valida codigo digitado e preenche descricao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdEmpresa()
        LOCAL loc_oPag, loc_cCod, loc_cSQL, loc_nResult
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cCod = ALLTRIM(loc_oPag.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cCod)
            loc_oPag.txt_4c_DsEmpresa.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                   EscaparSQL(loc_cCod)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0 AND RECCOUNT("cursor_4c_EmpVal") > 0
            SELECT cursor_4c_EmpVal
            loc_oPag.txt_4c_CdEmpresa.Value = ALLTRIM(cemps)
            loc_oPag.txt_4c_DsEmpresa.Value = ALLTRIM(razas)
        ELSE
            loc_oPag.txt_4c_DsEmpresa.Value = ""
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdGrupo - Valida codigo de grupo de produto e preenche descricao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdGrupo()
        LOCAL loc_oPag, loc_cCod, loc_cSQL, loc_nResult
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cCod = ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value)
        IF EMPTY(loc_cCod)
            loc_oPag.txt_4c_DsGrupo.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus = " + ;
                   EscaparSQL(loc_cCod)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruVal")
        IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruVal") > 0
            SELECT cursor_4c_GruVal
            loc_oPag.txt_4c_CdGrupo.Value = ALLTRIM(cgrus)
            loc_oPag.txt_4c_DsGrupo.Value = ALLTRIM(dgrus)
        ELSE
            loc_oPag.txt_4c_DsGrupo.Value = ""
            THIS.AbrirBuscaGrupo("cgrus")
        ENDIF
        IF USED("cursor_4c_GruVal")
            USE IN cursor_4c_GruVal
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoeda - Valida codigo de moeda e preenche descricao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdMoeda()
        LOCAL loc_oPag, loc_cCod
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cCod = ALLTRIM(loc_oPag.txt_4c_CdMoeda.Value)
        IF EMPTY(loc_cCod)
            loc_oPag.txt_4c_DsMoeda.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaMoeda("cmoes")
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdGrupoCalc - Valida codigo de grupo de calculo e preenche descricao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdGrupoCalc()
        LOCAL loc_oPag, loc_cCod, loc_cSQL, loc_nResult
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_cCod = ALLTRIM(loc_oPag.txt_4c_CdGrupoCalc.Value)
        IF EMPTY(loc_cCod)
            loc_oPag.txt_4c_DsGrupoCalc.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus = " + ;
                   EscaparSQL(loc_cCod)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrcVal")
        IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GrcVal") > 0
            SELECT cursor_4c_GrcVal
            loc_oPag.txt_4c_CdGrupoCalc.Value = ALLTRIM(cgrus)
            loc_oPag.txt_4c_DsGrupoCalc.Value = ALLTRIM(dgrus)
        ELSE
            loc_oPag.txt_4c_DsGrupoCalc.Value = ""
            THIS.AbrirBuscaGrupoCalc("cgrus")
        ENDIF
        IF USED("cursor_4c_GrcVal")
            USE IN cursor_4c_GrcVal
        ENDIF
    ENDPROC

    *==========================================================================
    * METODOS PROTEGIDOS: lookups via FormBuscaAuxiliar
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - Abre FormBuscaAuxiliar para selecao de empresa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oPag, loc_cCod, loc_oForm
        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_cCod  = ALLTRIM(loc_oPag.txt_4c_CdEmpresa.Value)
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "cemps", loc_cCod, "Empresa")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            loc_oPag.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cemps)
            loc_oPag.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.razas)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("razas", "", "Empresa")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                loc_oPag.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cemps)
                loc_oPag.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.razas)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para selecao de grupo de produto
    *   par_cCampo: "cgrus" (por codigo) ou "dgrus" (por descricao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaGrupo(par_cCampo)
        LOCAL loc_oPag, loc_cVal, loc_oForm
        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_cVal  = IIF(par_cCampo = "cgrus", ;
            ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value), ;
            ALLTRIM(loc_oPag.txt_4c_DsGrupo.Value))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_BuscaGru", par_cCampo, loc_cVal, ;
            "Grupo de Produto")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            loc_oPag.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGru.cgrus)
            loc_oPag.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGru.dgrus)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGru")
                loc_oPag.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGru.cgrus)
                loc_oPag.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGru.dgrus)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaGru")
            USE IN cursor_4c_BuscaGru
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - Abre FormBuscaAuxiliar para selecao de moeda
    *   par_cCampo: "cmoes" (por codigo) ou "dmoes" (por descricao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaMoeda(par_cCampo)
        LOCAL loc_oPag, loc_cVal, loc_oForm
        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_cVal  = IIF(par_cCampo = "cmoes", ;
            ALLTRIM(loc_oPag.txt_4c_CdMoeda.Value), ;
            ALLTRIM(loc_oPag.txt_4c_DsMoeda.Value))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", par_cCampo, loc_cVal, "Moeda")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            loc_oPag.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
            loc_oPag.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                loc_oPag.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                loc_oPag.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupoCalc - Abre FormBuscaAuxiliar para selecao de grupo de calculo
    *   par_cCampo: "cgrus" (por codigo) ou "dgrus" (por descricao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaGrupoCalc(par_cCampo)
        LOCAL loc_oPag, loc_cVal, loc_oForm
        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_cVal  = IIF(par_cCampo = "cgrus", ;
            ALLTRIM(loc_oPag.txt_4c_CdGrupoCalc.Value), ;
            ALLTRIM(loc_oPag.txt_4c_DsGrupoCalc.Value))
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_BuscaGrc", par_cCampo, loc_cVal, ;
            "Grupo de C" + CHR(225) + "lculo")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF
        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            loc_oPag.txt_4c_CdGrupoCalc.Value = ALLTRIM(cursor_4c_BuscaGrc.cgrus)
            loc_oPag.txt_4c_DsGrupoCalc.Value = ALLTRIM(cursor_4c_BuscaGrc.dgrus)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrc")
                loc_oPag.txt_4c_CdGrupoCalc.Value = ALLTRIM(cursor_4c_BuscaGrc.cgrus)
                loc_oPag.txt_4c_DsGrupoCalc.Value = ALLTRIM(cursor_4c_BuscaGrc.dgrus)
            ENDIF
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaGrc")
            USE IN cursor_4c_BuscaGrc
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * EVENTOS AUXILIARES - aliases canonicos do pipeline
    *   BtnBuscarClick / BtnEncerrarClick / BtnSalvarClick / BtnCancelarClick
    *   FormParaBO / BOParaForm / HabilitarCampos / CarregarLista
    *   AjustarBotoesPorModo
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega o cursor Selecao e atualiza a grade
    *   Em um relatorio o equivalente de "Buscar" e recarregar os grupos/contas
    *   de estoque disponiveis para selecao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            THIS.this_oRelatorio.InicializarSelecao()
            IF USED("Selecao") AND PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
                LOCAL loc_oGrade
                loc_oGrade = THIS.pgf_4c_Paginas.Page1.grd_4c_Grade
                loc_oGrade.RecordSource     = "Selecao"
                loc_oGrade.RecordSourceType = 1
                loc_oGrade.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (alias de CmgEncerrarClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.CmgEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Visualiza o relatorio em preview (acao principal)
    *   Em um relatorio "Salvar" equivale a processar/visualizar os dados.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmgVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa os campos de filtro e restaura valores padrao
    *   Em um relatorio "Cancelar" equivale a limpar a selecao de filtros.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere campos do form para o BO (alias de FormParaRelatorio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Restaura campos do form a partir das propriedades do BO
    *   Operacao inversa de FormParaRelatorio: recarga visual dos filtros.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            loc_oPag.txt_4c_CdEmpresa.Value    = .this_cCdEmpresa
            loc_oPag.txt_4c_DsEmpresa.Value    = .this_cDsEmpresa
            loc_oPag.txt_4c_CdGrupo.Value      = .this_cCdGrupo
            loc_oPag.txt_4c_DsGrupo.Value      = .this_cDsGrupo
            loc_oPag.txt_4c_CdMoeda.Value      = .this_cCdMoeda
            loc_oPag.txt_4c_DsMoeda.Value      = .this_cDsMoeda
            loc_oPag.txt_4c_CdGrupoCalc.Value  = .this_cCdGrupoCalc
            loc_oPag.txt_4c_DsGrupoCalc.Value  = .this_cDsGrupoCalc
            loc_oPag.obj_4c_OptRfestoque.Value = .this_nRfEstoque
            loc_oPag.obj_4c_OptCalcusto.Value  = .this_nCalcusto
            loc_oPag.txt_4c_DataSaldo.Value    = .this_dDataSaldo
        ENDWITH
        THIS.AjustarCamposPorRefEstoque()
        THIS.AjustarCamposPorCalcusto()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita todos os campos de filtro
    *   par_lHabilitar: .T. habilita, .F. desabilita todos os controles
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oPag.txt_4c_CdEmpresa.Enabled     = par_lHabilitar
        loc_oPag.txt_4c_DsEmpresa.Enabled     = par_lHabilitar
        loc_oPag.txt_4c_CdGrupo.Enabled       = par_lHabilitar
        loc_oPag.txt_4c_DsGrupo.Enabled       = par_lHabilitar
        loc_oPag.txt_4c_CdMoeda.Enabled       = par_lHabilitar
        loc_oPag.txt_4c_DsMoeda.Enabled       = par_lHabilitar
        loc_oPag.txt_4c_CdGrupoCalc.Enabled   = par_lHabilitar
        loc_oPag.txt_4c_DsGrupoCalc.Enabled   = par_lHabilitar
        loc_oPag.obj_4c_OptRfestoque.Enabled  = par_lHabilitar
        loc_oPag.obj_4c_OptCalcusto.Enabled   = par_lHabilitar
        IF par_lHabilitar
            THIS.AjustarCamposPorRefEstoque()
        ELSE
            loc_oPag.txt_4c_DataSaldo.Enabled = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega o cursor Selecao e atualiza a grade
    *   Equivalente a "Buscar" no pipeline CRUD; em relatorio recarga os
    *   grupos/contas de estoque disponiveis para selecao.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN .F.
        ENDIF
        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            THIS.this_oRelatorio.InicializarSelecao()
            IF USED("Selecao") AND PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
                LOCAL loc_oGrade
                loc_oGrade = THIS.pgf_4c_Paginas.Page1.grd_4c_Grade
                loc_oGrade.RecordSource     = "Selecao"
                loc_oGrade.RecordSourceType = 1
                loc_oGrade.Refresh()
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita botoes de acao conforme disponibilidade do BO
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lAtivo
        loc_lAtivo = (VARTYPE(THIS.this_oRelatorio) = "O")
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lAtivo
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = loc_lAtivo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO de relatorio e chama destrutor da base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
