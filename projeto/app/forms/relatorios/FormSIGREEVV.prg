*==============================================================================
* FORMSIGREEVV.PRG
* Relat" + CHR(243) + "rio Estoque Por Valor de Venda
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREEVV.SCX (frmrelatorio)
*
* Filtros:
*   - Tabela de desconto (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o + percentual - SigOpTdz)
*   - Grupo cont" + CHR(225) + "bil    (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o)
*   - Conta cont" + CHR(225) + "bil    (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o)
*   - Faixa de valor    (valor inicial / valor final)
*   - Incluir Franquias (checkbox)
*   - Incluir Zerados   (checkbox)
*
* FASES 3-7/8 - Estrutura base + corre" + CHR(231) + CHR(245) + "es visuais PILAR 1 + Eventos
*   * Propriedades visuais do form (Closable=.F. adicionado - Fase 5)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho()  (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)
*   * ConfigurarBotoes()     (Visualizar / Imprimir / Excel / Encerrar)
*   * ConfigurarPageFrame()  (PageFrame com 1 p" + CHR(225) + "gina - "Filtros")
*   * ConfigurarPaginaFiltros() (todos os campos de filtro - Fase 4)
*   * ConfigurarPaginaDados()   (corre" + CHR(231) + CHR(245) + "es InputMask/Alignment/MaxLength - Fase 5)
*   * VincularEventosBotoes()   (BINDEVENT do CommandGroup - Fase 7)
*   * BotoesClick()             (dispatcher central Value=1..4 - Fase 7)
*   * ValidarFiltrosForm()      (replica validacoes do Click legado - Fase 7)
*   * FormParaRelatorio()       (copia filtros do form para o BO - Fase 7)
*   * BotaoVisualizarClick()    (preview em tela - Fase 7)
*   * BotaoImprimirClick()      (enviar para impressora - Fase 7)
*   * BotaoExcelClick()         (exportar para XLS - Fase 7)
*   * BotaoEncerrarClick()      (fechar o formulario - Fase 7)
*
* FASE 8/8 - Eventos auxiliares e consolidacao final
*   * BtnBuscarClick()          (preview do relatorio - Fase 8)
*   * BtnEncerrarClick()        (fechar form - Fase 8)
*   * BtnSalvarClick()          (imprimir - Fase 8)
*   * BtnCancelarClick()        (fechar form - Fase 8)
*   * FormParaBO()              (alias de FormParaRelatorio - Fase 8)
*   * BOParaForm()              (restaura filtros do BO para o form - Fase 8)
*   * HabilitarCampos()         (habilita/desabilita campos de filtro - Fase 8)
*   * CarregarLista()           (stub - nao aplicavel para REPORT - Fase 8)
*   * AjustarBotoesPorModo()    (stub - nao aplicavel para REPORT - Fase 8)
*==============================================================================

DEFINE CLASS FormSIGREEVV AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=300)
    Height      = 300
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Closable    = .F.
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
    *   2. Cria SIGREEVVBO
    *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es do relat" + CHR(243) + "rio + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Estoque Por Valor de Venda"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relat" + CHR(243) + "rio
            THIS.this_oRelatorio = CREATEOBJECT("SIGREEVVBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREEVVBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente a cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com p" + CHR(225) + "gina de filtros
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaFiltros()
                THIS.ConfigurarPaginaDados()
                THIS.LimparCampos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Vincular Click do CommandGroup (equivale ao Click do legado)
                THIS.VincularEventosBotoes()

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
                .Caption   = "Estoque Por Valor de Venda"
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
                .Caption   = "Estoque Por Valor de Venda"
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
    * ConfigurarBotoes - CommandGroup com bot" + CHR(245) + "es de relat" + CHR(243) + "rio
    *   Geometria EXATA do framework frmrelatorio (btnReport).
    *   Original: btnReport.Left=526, Top=3, Width~273, Height=80
    *   Lefts dos bot" + CHR(245) + "es: 5 / 71 / 137 / 203 (incrementos de 66)
    *   Eventos Click vinculados nas fases seguintes (Fase 7).
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
    *   O form SIGREEVV " + CHR(233) + " FLAT (sem PageFrame CRUD), mas no novo padr" + CHR(227) + "o
    *   os campos s" + CHR(227) + "o agrupados em um PageFrame de 1 p" + CHR(225) + "gina para consist" + CHR(234) + "ncia
    *   com o restante do sistema.
    *   Os campos de filtro s" + CHR(227) + "o adicionados a Page1 nas fases seguintes (5-6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form
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
    * Destroy - Libera refer" + CHR(234) + "ncia ao BO (NUNCA chamar .Release em Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Cria todos os controles de filtro em Page1
    * Posicoes relativas a Page1 = posicao original no form - PageFrame.Top (85)
    * Mapeamento: Say3=lbl_4c_Label3, getTabela=txt_4c_Tabela, etc.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            *-- Rotulo: Tab. Desconto : (Say3 original: top=111 -> 111-85=26)
            loc_oPag.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPag.lbl_4c_Label3
                .Top       = 26
                .Left      = 194
                .Width     = 79
                .Height    = 18
                .Caption   = "Tab. Desconto :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Codigo da tabela de desconto (getTabela: top=108 -> 23)
            loc_oPag.AddObject("txt_4c_Tabela", "TextBox")
            WITH loc_oPag.txt_4c_Tabela
                .Top         = 23
                .Left        = 278
                .Width       = 80
                .Height      = 23
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(0, 0, 0)
                .ToolTipText = "[F4] Pesquisar tabela de desconto"
                .Visible     = .T.
            ENDWITH
            BINDEVENT(loc_oPag.txt_4c_Tabela, "KeyPress", THIS, "TeclaTabela")
            BINDEVENT(loc_oPag.txt_4c_Tabela, "DblClick", THIS, "TabelaDblClick")

            *-- Descricao da tabela de desconto (getDTabela: top=108 -> 23)
            loc_oPag.AddObject("txt_4c_DTabela", "TextBox")
            WITH loc_oPag.txt_4c_DTabela
                .Top         = 23
                .Left        = 360
                .Width       = 255
                .Height      = 23
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(0, 0, 0)
                .ToolTipText = "[F4] Pesquisar por descri" + CHR(231) + CHR(227) + "o"
                .Visible     = .T.
            ENDWITH
            BINDEVENT(loc_oPag.txt_4c_DTabela, "KeyPress", THIS, "TeclaDTabela")
            BINDEVENT(loc_oPag.txt_4c_DTabela, "DblClick", THIS, "DTabelaDblClick")

            *-- Rotulo: Grupo : (Say4 original: top=137 -> 52)
            loc_oPag.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPag.lbl_4c_Label4
                .Top       = 52
                .Left      = 235
                .Width     = 38
                .Height    = 18
                .Caption   = "Grupo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Codigo do grupo contabil (getGrupo: top=133 -> 48)
            loc_oPag.AddObject("txt_4c_Grupo", "TextBox")
            WITH loc_oPag.txt_4c_Grupo
                .Top         = 48
                .Left        = 278
                .Width       = 80
                .Height      = 25
                .Value       = ""
                .MaxLength   = 10
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(0, 0, 0)
                .ToolTipText = "[F4] Pesquisar grupo cont" + CHR(225) + "bil"
                .Visible     = .T.
            ENDWITH
            BINDEVENT(loc_oPag.txt_4c_Grupo, "KeyPress", THIS, "TeclaGrupo")
            BINDEVENT(loc_oPag.txt_4c_Grupo, "DblClick", THIS, "GrupoDblClick")

            *-- Descricao do grupo contabil (getDGrupo: top=133 -> 48)
            *-- Editavel: usuario digita descricao p/ busca reversa (replica getDGrupo.Valid + fAcessoContab)
            loc_oPag.AddObject("txt_4c_DGrupo", "TextBox")
            WITH loc_oPag.txt_4c_DGrupo
                .Top         = 48
                .Left        = 360
                .Width       = 150
                .Height      = 25
                .Value       = ""
                .MaxLength   = 20
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(0, 0, 0)
                .ToolTipText = "[F4] Pesquisar grupo por descri" + CHR(231) + CHR(227) + "o"
                .Visible     = .T.
            ENDWITH
            BINDEVENT(loc_oPag.txt_4c_DGrupo, "KeyPress", THIS, "TeclaDGrupo")
            BINDEVENT(loc_oPag.txt_4c_DGrupo, "DblClick", THIS, "DGrupoDblClick")

            *-- Rotulo: Conta : (lbl_estoque original: top=165 -> 80)
            loc_oPag.AddObject("lbl_4c_Lbl_estoque", "Label")
            WITH loc_oPag.lbl_4c_Lbl_estoque
                .Top       = 80
                .Left      = 235
                .Width     = 38
                .Height    = 18
                .Caption   = "Conta :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Codigo da conta contabil (getConta: top=160 -> 75)
            loc_oPag.AddObject("txt_4c_Conta", "TextBox")
            WITH loc_oPag.txt_4c_Conta
                .Top         = 75
                .Left        = 278
                .Width       = 80
                .Height      = 25
                .Value       = ""
                .MaxLength   = 10
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(0, 0, 0)
                .ToolTipText = "[F4] Pesquisar conta cont" + CHR(225) + "bil"
                .Visible     = .T.
            ENDWITH
            BINDEVENT(loc_oPag.txt_4c_Conta, "KeyPress", THIS, "TeclaConta")
            BINDEVENT(loc_oPag.txt_4c_Conta, "DblClick", THIS, "ContaDblClick")

            *-- Descricao da conta contabil (getDConta: top=160 -> 75) - somente leitura
            loc_oPag.AddObject("txt_4c_DConta", "TextBox")
            WITH loc_oPag.txt_4c_DConta
                .Top         = 75
                .Left        = 360
                .Width       = 298
                .Height      = 25
                .Value       = ""
                .MaxLength   = 40
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(0, 0, 0)
                .ReadOnly    = .T.
                .ToolTipText = "[DblClique] Abrir busca de conta"
                .Visible     = .T.
            ENDWITH
            BINDEVENT(loc_oPag.txt_4c_DConta, "DblClick", THIS, "DContaDblClick")

            *-- Rotulo: Faixa de Valor : (Say1 original: top=190 -> 105)
            loc_oPag.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPag.lbl_4c_Label1
                .Top       = 105
                .Left      = 196
                .Width     = 77
                .Height    = 18
                .Caption   = "Faixa de Valor :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Valor inicial da faixa (getValorIni: top=187 -> 102)
            loc_oPag.AddObject("txt_4c_ValorIni", "TextBox")
            WITH loc_oPag.txt_4c_ValorIni
                .Top       = 102
                .Left      = 278
                .Width     = 80
                .Height    = 23
                .Value     = 0
                .InputMask = "9999999.99"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- Separador de faixa (Say2 original: top=190 -> 105, CHR(224)=a-grave="a")
            loc_oPag.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPag.lbl_4c_Label2
                .Top       = 105
                .Left      = 364
                .Width     = 8
                .Height    = 18
                .Caption   = CHR(224)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Valor final da faixa (getValorFin: top=187 -> 102)
            loc_oPag.AddObject("txt_4c_ValorFin", "TextBox")
            WITH loc_oPag.txt_4c_ValorFin
                .Top       = 102
                .Left      = 374
                .Width     = 80
                .Height    = 23
                .Value     = 0
                .InputMask = "9999999.99"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            *-- Checkbox: Incluir Franquias (chkFranquias: top=213 -> 128)
            loc_oPag.AddObject("chk_4c_ChkFranquias", "CheckBox")
            WITH loc_oPag.chk_4c_ChkFranquias
                .Top      = 128
                .Left     = 278
                .Width    = 130
                .Height   = 20
                .Caption  = "Incluir Franquias"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Checkbox: Incluir Zerados (chkZerados: top=213 -> 128)
            loc_oPag.AddObject("chk_4c_ChkZerados", "CheckBox")
            WITH loc_oPag.chk_4c_ChkZerados
                .Top      = 128
                .Left     = 418
                .Width    = 130
                .Height   = 20
                .Caption  = "Incluir Zerados"
                .Value    = 0
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Container de mensagem (cntMensagem original: top=510, left=152, width=473, height=56, specialeffect=0)
            loc_oPag.AddObject("cnt_4c_Mensagem", "Container")
            WITH loc_oPag.cnt_4c_Mensagem
                .Top           = 510
                .Left          = 152
                .Width         = 473
                .Height        = 56
                .SpecialEffect = 0
                .BackStyle     = 1
                .BackColor     = RGB(255, 255, 200)
                .BorderWidth   = 1
                .Visible       = .F.

                .AddObject("lbl_4c_LblMensagem", "Label")
                WITH .lbl_4c_LblMensagem
                    .Top       = 18
                    .Left      = 20
                    .Width     = 445
                    .Height    = 22
                    .Caption   = "Aguarde!!!"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "ConfigurarPaginaFiltros")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaTabela - Lookup de tabela de desconto em SigOpTdz (por codigo)
    * Preenche txt_4c_Tabela, txt_4c_DTabela e this_nPercentual do BO
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaTabela()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_lSelecionou
        loc_oPag        = THIS.pgf_4c_Paginas.Page1
        loc_cValor      = ALLTRIM(loc_oPag.txt_4c_Tabela.Value)
        loc_lSelecionou = .F.

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpTdz", "cursor_4c_BuscaTab", "Codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o - Tabela de Desconto")

        IF ISNULL(loc_oForm)
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            loc_lSelecionou = .T.
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Codigos", "", "Tabela")
            loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.mAddColuna("Descos",  "9999.99", "%")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                loc_lSelecionou = .T.
            ENDIF
            ENDIF
        ENDIF

        IF loc_lSelecionou AND USED("cursor_4c_BuscaTab")
            SELECT cursor_4c_BuscaTab
            IF !EOF()
                loc_oPag.txt_4c_Tabela.Value  = ALLTRIM(cursor_4c_BuscaTab.Codigos)
                loc_oPag.txt_4c_DTabela.Value = ALLTRIM(cursor_4c_BuscaTab.Descrs)
                THIS.this_oRelatorio.this_nPercentual = cursor_4c_BuscaTab.Descos
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaTab")
            USE IN cursor_4c_BuscaTab
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTabela - Valida codigo digitado em txt_4c_Tabela (ENTER/TAB)
    * Se encontrado: preenche descricao e percentual.
    * Se nao encontrado: abre lookup.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTabela()
        LOCAL loc_oPag, loc_cValor, loc_nResult, loc_oErro
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Tabela.Value)
        TRY
            IF EMPTY(loc_cValor)
                loc_oPag.txt_4c_DTabela.Value = ""
                THIS.this_oRelatorio.this_nPercentual = 0
                RETURN
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs, Descos FROM SigOpTdz WHERE Codigos = " + ;
                EscaparSQL(loc_cValor), ;
                "cursor_4c_ValTab")
            IF loc_nResult > 0
                SELECT cursor_4c_ValTab
                IF !EOF()
                    loc_oPag.txt_4c_Tabela.Value  = ALLTRIM(cursor_4c_ValTab.Codigos)
                    loc_oPag.txt_4c_DTabela.Value = ALLTRIM(cursor_4c_ValTab.Descrs)
                    THIS.this_oRelatorio.this_nPercentual = cursor_4c_ValTab.Descos
                    USE IN cursor_4c_ValTab
                    RETURN
                ENDIF
                USE IN cursor_4c_ValTab
            ENDIF
            THIS.AbrirBuscaTabela()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarTabela")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDTabela - Lookup de tabela de desconto em SigOpTdz (por descricao)
    * Preenche txt_4c_Tabela, txt_4c_DTabela e this_nPercentual do BO
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDTabela()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_lSelecionou
        loc_oPag        = THIS.pgf_4c_Paginas.Page1
        loc_cValor      = ALLTRIM(loc_oPag.txt_4c_DTabela.Value)
        loc_lSelecionou = .F.

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpTdz", "cursor_4c_BuscaDTab", "Descrs", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o - Tabela de Desconto (por Descri" + ;
            CHR(231) + CHR(227) + "o)")

        IF ISNULL(loc_oForm)
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            loc_lSelecionou = .T.
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Codigos", "", "Tabela")
            loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.mAddColuna("Descos",  "9999.99", "%")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                loc_lSelecionou = .T.
            ENDIF
            ENDIF
        ENDIF

        IF loc_lSelecionou AND USED("cursor_4c_BuscaDTab")
            SELECT cursor_4c_BuscaDTab
            IF !EOF()
                loc_oPag.txt_4c_Tabela.Value  = ALLTRIM(cursor_4c_BuscaDTab.Codigos)
                loc_oPag.txt_4c_DTabela.Value = ALLTRIM(cursor_4c_BuscaDTab.Descrs)
                THIS.this_oRelatorio.this_nPercentual = cursor_4c_BuscaDTab.Descos
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaDTab")
            USE IN cursor_4c_BuscaDTab
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaTabela - Handler KeyPress de txt_4c_Tabela
    * F4/F5: abre lookup direto. ENTER/TAB: valida codigo digitado.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaTabela(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaTabela()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarTabela()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDTabela - Handler KeyPress de txt_4c_DTabela
    * F4/F5/ENTER/TAB: abre lookup por descricao.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDTabela(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116, 13, 9)
            THIS.AbrirBuscaDTabela()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupo - Lookup de grupo em SigCdGcr
    * Preenche txt_4c_Grupo e txt_4c_DGrupo
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_lSelecionou
        loc_oPag        = THIS.pgf_4c_Paginas.Page1
        loc_cValor      = ALLTRIM(loc_oPag.txt_4c_Grupo.Value)
        loc_lSelecionou = .F.

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrupo", "codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o - Grupo")

        IF ISNULL(loc_oForm)
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            loc_lSelecionou = .T.
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                loc_lSelecionou = .T.
            ENDIF
            ENDIF
        ENDIF

        IF loc_lSelecionou AND USED("cursor_4c_BuscaGrupo")
            SELECT cursor_4c_BuscaGrupo
            IF !EOF()
                loc_oPag.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
                loc_oPag.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida codigo digitado em txt_4c_Grupo (ENTER/TAB)
    * Se encontrado: preenche descricao. Se nao encontrado: abre lookup.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo()
        LOCAL loc_oPag, loc_cValor, loc_nResult, loc_oErro
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Grupo.Value)
        TRY
            IF EMPTY(loc_cValor)
                loc_oPag.txt_4c_DGrupo.Value = ""
                RETURN
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                EscaparSQL(loc_cValor), ;
                "cursor_4c_ValGrupo")
            IF loc_nResult > 0
                SELECT cursor_4c_ValGrupo
                IF !EOF()
                    loc_oPag.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_ValGrupo.codigos)
                    loc_oPag.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ValGrupo.descrs)
                    USE IN cursor_4c_ValGrupo
                    RETURN
                ENDIF
                USE IN cursor_4c_ValGrupo
            ENDIF
            THIS.AbrirBuscaGrupo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGrupo - Handler KeyPress de txt_4c_Grupo
    * F4/F5: abre lookup direto. ENTER/TAB: valida codigo digitado.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaGrupo()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarGrupo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaConta - Lookup de conta contabil em SigReCtb
    * Preenche txt_4c_Conta e txt_4c_DConta
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaConta()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_lSelecionou
        loc_oPag        = THIS.pgf_4c_Paginas.Page1
        loc_cValor      = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
        loc_lSelecionou = .F.

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigReCtb", "cursor_4c_BuscaConta", "contas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o - Conta")

        IF ISNULL(loc_oForm)
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            loc_lSelecionou = .T.
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("contas", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                loc_lSelecionou = .T.
            ENDIF
            ENDIF
        ENDIF

        IF loc_lSelecionou AND USED("cursor_4c_BuscaConta")
            SELECT cursor_4c_BuscaConta
            IF !EOF()
                loc_oPag.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.contas)
                loc_oPag.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.descs)
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - Valida codigo digitado em txt_4c_Conta (ENTER/TAB)
    * Se encontrado: preenche descricao. Se nao encontrado: abre lookup.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConta()
        LOCAL loc_oPag, loc_cValor, loc_nResult, loc_oErro
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
        TRY
            IF EMPTY(loc_cValor)
                loc_oPag.txt_4c_DConta.Value = ""
                RETURN
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT contas, descs FROM SigReCtb WHERE contas = " + ;
                EscaparSQL(loc_cValor), ;
                "cursor_4c_ValConta")
            IF loc_nResult > 0
                SELECT cursor_4c_ValConta
                IF !EOF()
                    loc_oPag.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ValConta.contas)
                    loc_oPag.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValConta.descs)
                    USE IN cursor_4c_ValConta
                    RETURN
                ENDIF
                USE IN cursor_4c_ValConta
            ENDIF
            THIS.AbrirBuscaConta()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaConta - Handler KeyPress de txt_4c_Conta
    * F4/F5: abre lookup direto. ENTER/TAB: valida codigo digitado.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaConta(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaConta()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarConta()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta todos os campos de filtro para valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            loc_oPag.txt_4c_Tabela.Value          = ""
            loc_oPag.txt_4c_DTabela.Value          = ""
            loc_oPag.txt_4c_Grupo.Value            = ""
            loc_oPag.txt_4c_DGrupo.Value           = ""
            loc_oPag.txt_4c_Conta.Value            = ""
            loc_oPag.txt_4c_DConta.Value           = ""
            loc_oPag.txt_4c_ValorIni.Value         = 0
            loc_oPag.txt_4c_ValorFin.Value         = 0
            loc_oPag.chk_4c_ChkFranquias.Value     = 0
            loc_oPag.chk_4c_ChkZerados.Value       = 0
            THIS.this_oRelatorio.this_nPercentual  = 0
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos filtros para o BO antes de imprimir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cCodTab    = ALLTRIM(loc_oPag.txt_4c_Tabela.Value)
            .this_cDsTab     = ALLTRIM(loc_oPag.txt_4c_DTabela.Value)
            .this_cGrupo     = ALLTRIM(loc_oPag.txt_4c_Grupo.Value)
            .this_cDGrupo    = ALLTRIM(loc_oPag.txt_4c_DGrupo.Value)
            .this_cConta     = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
            .this_cDConta    = ALLTRIM(loc_oPag.txt_4c_DConta.Value)
            .this_nValorIni  = loc_oPag.txt_4c_ValorIni.Value
            .this_nValorFin  = loc_oPag.txt_4c_ValorFin.Value
            .this_lFranquias = (loc_oPag.chk_4c_ChkFranquias.Value = 1)
            .this_lZerados   = (loc_oPag.chk_4c_ChkZerados.Value = 1)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularEventosBotoes - Faz BINDEVENT do Click do CommandGroup
    * O legado SIGREEVV.SCX tinha um unico Click no grupo que tratava todos os
    * 4 bot" + CHR(245) + "es testando This.Value (1=Visualizar, 2=Imprimir, 3=Excel, 4=Sair).
    * Aqui usamos o mesmo padr" + CHR(227) + "o: um " + CHR(250) + "nico handler BotoesClick
    * que consulta cmg_4c_Botoes.Value e despacha para o m" + CHR(233) + "todo correto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularEventosBotoes()
        BINDEVENT(THIS.cmg_4c_Botoes, "Click", THIS, "BotoesClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BotoesClick - Dispatcher central do CommandGroup cmg_4c_Botoes
    * Replica a l" + CHR(243) + "gica do Click do legado (PROCEDURE Click do bot" + CHR(227) + "o no SCX):
    *   1. Se for Sair (Value=4) -> fecha o form
    *   2. Caso contr" + CHR(225) + "rio -> valida filtros, copia para BO e despacha
    *      - Value=1 -> Visualizar (preview)
    *      - Value=2 -> Imprimir (impressora padr" + CHR(227) + "o)
    *      - Value=3 -> Excel (exportar dados)
    *--------------------------------------------------------------------------
    PROCEDURE BotoesClick()
        LOCAL loc_nBotao
        loc_nBotao = THIS.cmg_4c_Botoes.Value

        *-- Bot" + CHR(227) + "o 4 = Encerrar/Sair (sem valida" + CHR(231) + CHR(227) + "o de filtros)
        IF loc_nBotao = 4
            THIS.BotaoEncerrarClick()
            RETURN
        ENDIF

        *-- Para os demais: valida filtros antes de gerar relat" + CHR(243) + "rio
        IF !THIS.ValidarFiltrosForm()
            RETURN
        ENDIF

        *-- Copiar filtros do form para o BO
        THIS.FormParaRelatorio()

        DO CASE
            CASE loc_nBotao = 1
                THIS.BotaoVisualizarClick()
            CASE loc_nBotao = 2
                THIS.BotaoImprimirClick()
            CASE loc_nBotao = 3
                THIS.BotaoExcelClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltrosForm - Aplica as mesmas valida" + CHR(231) + CHR(245) + "es do Click legado,
    * exibindo a mensagem e devolvendo o foco para o campo problem" + CHR(225) + "tico.
    * Retorna .T. se filtros est" + CHR(227) + "o v" + CHR(225) + "lidos, .F. caso contr" + CHR(225) + "rio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltrosForm()
        LOCAL loc_oPag, loc_lValido
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Tabela.Value))
            MsgAviso("Tabela de Desconto Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_Tabela.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND loc_oPag.txt_4c_ValorIni.Value < 0
            MsgAviso("Faixa Inicial de Valor Inv" + CHR(225) + "lida!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_ValorIni.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND loc_oPag.txt_4c_ValorIni.Value > loc_oPag.txt_4c_ValorFin.Value
            MsgAviso("Faixa Inicial de Valor Maior do Que a Final!!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_ValorIni.SetFocus()
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BotaoVisualizarClick - Gera o relat" + CHR(243) + "rio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE BotaoVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao visualizar relat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BotaoVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BotaoImprimirClick - Envia o relat" + CHR(243) + "rio para a impressora
    *--------------------------------------------------------------------------
    PROCEDURE BotaoImprimirClick()
        LOCAL loc_oErro
        TRY
            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao imprimir relat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BotaoImprimirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BotaoExcelClick - Exporta os dados do relat" + CHR(243) + "rio para uma planilha XLS
    * 1. Chama PrepararDados() do BO para popular o cursor crImprimir
    * 2. Solicita destino via GETFILE
    * 3. Faz COPY TO ... TYPE XL5 do cursor
    *--------------------------------------------------------------------------
    PROCEDURE BotaoExcelClick()
        LOCAL loc_cArquivo, loc_cAlias, loc_oErro
        TRY
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao preparar dados para exporta" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            loc_cAlias = THIS.this_oRelatorio.this_cCursorDados
            IF !USED(loc_cAlias)
                MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para exporta" + ;
                    CHR(231) + CHR(227) + "o.", "Excel")
                RETURN
            ENDIF

            loc_cArquivo = PUTFILE("Salvar como:", "EstoqueValorVenda.xls", "xls")
            IF EMPTY(loc_cArquivo)
                RETURN
            ENDIF

            SELECT (loc_cAlias)
            COPY TO (loc_cArquivo) TYPE XL5
            MsgInfo("Arquivo exportado com sucesso para:" + CHR(13) + loc_cArquivo, "Excel")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BotaoExcelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BotaoEncerrarClick - Fecha o formul" + CHR(225) + "rio (equivale ao bot" + CHR(227) + "o Sair do legado)
    * O cmg_4c_Botoes.Buttons(4) j" + CHR(225) + " tem .Cancel=.T., ent" + CHR(227) + "o ESC tamb" + CHR(233) + "m dispara aqui.
    *--------------------------------------------------------------------------
    PROCEDURE BotaoEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TabelaDblClick - DblClick em txt_4c_Tabela abre lookup de tabela de desconto
    *--------------------------------------------------------------------------
    PROCEDURE TabelaDblClick()
        THIS.AbrirBuscaTabela()
    ENDPROC

    *--------------------------------------------------------------------------
    * DTabelaDblClick - DblClick em txt_4c_DTabela abre lookup por descricao
    *--------------------------------------------------------------------------
    PROCEDURE DTabelaDblClick()
        THIS.AbrirBuscaDTabela()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrupoDblClick - DblClick em txt_4c_Grupo abre lookup de grupo contabil
    *--------------------------------------------------------------------------
    PROCEDURE GrupoDblClick()
        THIS.AbrirBuscaGrupo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDGrupo - Lookup reverso em SigCdGcr por descricao
    * Replica getDGrupo.Valid + fAcessoContab('D'): usuario digita descricao,
    * sistema busca o codigo correspondente e preenche txt_4c_Grupo.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDGrupo()
        LOCAL loc_oPag, loc_cValor, loc_oForm, loc_lSelecionou, loc_oErro
        loc_oPag        = THIS.pgf_4c_Paginas.Page1
        loc_cValor      = ALLTRIM(loc_oPag.txt_4c_DGrupo.Value)
        loc_lSelecionou = .F.

        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaDGrupo", "descrs", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o - Grupo (por Descri" + CHR(231) + CHR(227) + "o)")

            IF ISNULL(loc_oForm)
                RETURN
            ENDIF

            IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                loc_lSelecionou = .T.
            ELSE
                IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou
                    loc_lSelecionou = .T.
                ENDIF
                ENDIF
            ENDIF

            IF loc_lSelecionou AND USED("cursor_4c_BuscaDGrupo")
                SELECT cursor_4c_BuscaDGrupo
                IF !EOF()
                    loc_oPag.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaDGrupo.codigos)
                    loc_oPag.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaDGrupo.descrs)
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaDGrupo")
                USE IN cursor_4c_BuscaDGrupo
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDGrupo - Handler KeyPress de txt_4c_DGrupo
    * F4/F5/ENTER/TAB: abre lookup reverso por descricao (replica fAcessoContab 'D').
    * Se campo vazio ao confirmar: limpa codigo do grupo.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        IF INLIST(par_nKeyCode, 115, 116, 13, 9)
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_DGrupo.Value))
                loc_oPag.txt_4c_Grupo.Value = ""
            ELSE
                THIS.AbrirBuscaDGrupo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DGrupoDblClick - DblClick em txt_4c_DGrupo abre lookup reverso de grupo
    *--------------------------------------------------------------------------
    PROCEDURE DGrupoDblClick()
        THIS.AbrirBuscaDGrupo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaDblClick - DblClick em txt_4c_Conta abre lookup de conta contabil
    *--------------------------------------------------------------------------
    PROCEDURE ContaDblClick()
        THIS.AbrirBuscaConta()
    ENDPROC

    *--------------------------------------------------------------------------
    * DContaDblClick - DblClick em txt_4c_DConta (campo descricao read-only)
    * Abre o mesmo lookup de conta, permitindo busca a partir do campo descricao.
    * Replica o comportamento de getDConta.When: abertura facilitada para o usuario.
    *--------------------------------------------------------------------------
    PROCEDURE DContaDblClick()
        THIS.AbrirBuscaConta()
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS - FASE 7
    *
    * Forms REPORT nao tem CRUD; o pipeline padroniza nomes (BtnXxxClick)
    * para todos os tipos de form. Aqui mapeamos os 4 handlers padrao para
    * as 4 acoes reais de um relatorio (Visualizar/Imprimir/Excel/Encerrar).
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Acao "Visualizar" do form REPORT
    * Valida filtros, copia para o BO e gera preview em tela.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !THIS.ValidarFiltrosForm()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.BotaoVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT nao ha Incluir CRUD; alias para Imprimir.
    * Gera o relatorio e envia para a impressora padrao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF !THIS.ValidarFiltrosForm()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.BotaoImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT nao ha Alterar CRUD; alias para Exportar Excel.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF !THIS.ValidarFiltrosForm()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.BotaoExcelClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT nao ha Excluir CRUD; alias para Encerrar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.BotaoEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - FASE 5/8: corre" + CHR(231) + CHR(245) + "es de fidelidade PILAR 1
    * Para form REPORT (layout FLAT sem Page2): aplica propriedades do original
    * que n" + CHR(227) + "o foram capturadas em ConfigurarPaginaFiltros():
    *   - InputMask dos campos numericos ("99,999,999" conforme original)
    *   - Alignment=3 (direita) nos campos numericos
    *   - MaxLength em campos de descricao de grupo e conta
    *   - getConta.FontSize=9 (original usa fonte 9, diferente dos demais=8)
    *   - lblMensagem: FontBold, FontSize=12, Alignment=2, ForeColor azul marinho
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            *-- Campos numericos: InputMask e alinhamento a direita (original: "99,999,999", Alignment=3)
            WITH loc_oPag.txt_4c_ValorIni
                .InputMask = "99,999,999"
                .Alignment = 3
            ENDWITH

            WITH loc_oPag.txt_4c_ValorFin
                .InputMask = "99,999,999"
                .Alignment = 3
            ENDWITH

            *-- MaxLength para campos de descri" + CHR(231) + CHR(227) + "o (original: getDGrupo=20, getDConta=40)
            loc_oPag.txt_4c_DGrupo.MaxLength = 20
            loc_oPag.txt_4c_DConta.MaxLength = 40

            *-- getConta usa FontSize=9 no original (diferente dos demais campos que usam 8)
            loc_oPag.txt_4c_Conta.FontSize = 9

            *-- lblMensagem: propriedades originais (FontBold=.T., FontSize=12, Alignment=2 centralizado, ForeColor azul)
            WITH loc_oPag.cnt_4c_Mensagem.lbl_4c_LblMensagem
                .FontBold  = .T.
                .FontSize  = 12
                .Alignment = 2
                .ForeColor = RGB(0, 0, 128)
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Para form REPORT: preview do relatorio na tela
    * Equivalente a Visualizar - acao principal de consulta de dados
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        IF !THIS.ValidarFiltrosForm()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.BotaoVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BotaoEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Para form REPORT: imprime o relatorio
    * Equivalente a Imprimir - acao de producao do documento impresso
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        IF !THIS.ValidarFiltrosForm()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.BotaoImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario sem gerar relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BotaoEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de FormParaRelatorio para compatibilidade com FormBase
    * Transfere valores dos filtros do form para o BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Restaura filtros do BO para os controles do form
    * Util para reexibir parametros carregados via CarregarDoCursor()
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            loc_oPag.txt_4c_Tabela.Value        = ALLTRIM(THIS.this_oRelatorio.this_cCodTab)
            loc_oPag.txt_4c_DTabela.Value        = ALLTRIM(THIS.this_oRelatorio.this_cDsTab)
            loc_oPag.txt_4c_Grupo.Value          = ALLTRIM(THIS.this_oRelatorio.this_cGrupo)
            loc_oPag.txt_4c_DGrupo.Value         = ALLTRIM(THIS.this_oRelatorio.this_cDGrupo)
            loc_oPag.txt_4c_Conta.Value          = ALLTRIM(THIS.this_oRelatorio.this_cConta)
            loc_oPag.txt_4c_DConta.Value         = ALLTRIM(THIS.this_oRelatorio.this_cDConta)
            loc_oPag.txt_4c_ValorIni.Value       = THIS.this_oRelatorio.this_nValorIni
            loc_oPag.txt_4c_ValorFin.Value       = THIS.this_oRelatorio.this_nValorFin
            loc_oPag.chk_4c_ChkFranquias.Value   = IIF(THIS.this_oRelatorio.this_lFranquias = .T., 1, 0)
            loc_oPag.chk_4c_ChkZerados.Value     = IIF(THIS.this_oRelatorio.this_lZerados   = .T., 1, 0)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita todos os campos de filtro
    * par_lHabilitar: .T. para habilitar, .F. para desabilitar durante geracao
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag, loc_oErro
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1
            loc_oPag.txt_4c_Tabela.Enabled       = par_lHabilitar
            loc_oPag.txt_4c_DTabela.Enabled       = par_lHabilitar
            loc_oPag.txt_4c_Grupo.Enabled         = par_lHabilitar
            loc_oPag.txt_4c_DGrupo.Enabled        = par_lHabilitar
            loc_oPag.txt_4c_Conta.Enabled         = par_lHabilitar
            loc_oPag.txt_4c_ValorIni.Enabled      = par_lHabilitar
            loc_oPag.txt_4c_ValorFin.Enabled      = par_lHabilitar
            loc_oPag.chk_4c_ChkFranquias.Enabled  = par_lHabilitar
            loc_oPag.chk_4c_ChkZerados.Enabled    = par_lHabilitar
            THIS.cmg_4c_Botoes.Enabled            = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel para form REPORT (sem grid de lista CRUD)
    * Retorna .T. para compatibilidade com o contrato de FormBase
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel para form REPORT
    * Botoes do relatorio nao mudam de estado por modo CRUD
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Enabled = .T.
        ENDIF
    ENDPROC

ENDDEFINE
