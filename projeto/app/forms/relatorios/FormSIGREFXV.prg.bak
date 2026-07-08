*==============================================================================
* FORMSIGREFXV.PRG
* Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + "o de Estoque por Grupo de Produto/Faixa de Valor
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREFXV.SCX (frmrelatorio)
*
* Filtros (Page1):
*   - Posi" + CHR(231) + CHR(227) + "o: Atual ou Retroativa (data)
*   - Moeda: c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o (SigCdMoe)
*   - Complemento Caracter" + CHR(237) + "stica: c" + CHR(243) + "digo (SigPrCpP)
*   - Grande Grupo: c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o (SigCdGpr)
*   - Grupo de Produto: c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o (SigCdGrp) - opcional
*   - Grid de Estoques: pares Empresa/Grupo (cursor CsEstoque)
*
* FASE 7/8 - CONCLUIDA (fases 3-7 implementadas em conjunto)
*   * Propriedades visuais do form (Width=761, Height=398 - EXATOS do original)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho()        (cabecalho escuro com titulo)
*   * ConfigurarBotoes()           (Visualizar / Imprimir / Excel / Encerrar)
*   * ConfigurarPageFrame()        (PageFrame com 1 pagina - "Filtros")
*   * ConfigurarCamposFiltro()     (todos os controles de filtro + grid + Aguarde)
*   * ConfigurarGridEstoques()     (grid CsEstoque - pares Empresa/Grupo)
*   * ConfigurarPaginaDados()      (bind de teclado no grid CsEstoque)
*   * ConfigurarBotoesBind()       (bind dos 4 botoes de relatorio)
*   * BtnVisualizarClick()         (preview em video)
*   * BtnImprimirClick()           (impressora com dialogo)
*   * BtnExcelClick()              (exportar para XLS)
*   * BtnEncerrarClick()           (fechar form)
*   * Lookups completos            (Moeda, Caracteristica, Grande Grupo, Grupo)
*   * ValidarFormulario()          (campos obrigatorios: Moeda + Grande Grupo)
*   * FormParaRelatorio()          (transfere filtros para o BO)
*   * LimparCampos()               (reset de todos os filtros)
*==============================================================================

DEFINE CLASS FormSIGREFXV AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=761, Height=398)
    Height      = 398
    Width       = 761
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
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria SIGREFXVBO
    *   3. Cria cursor CsEstoque para o grid de estoques
    *   4. Monta cabecalho escuro + botoes do relatorio + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + ;
                           "o de Estoque  por Grupo de Produto/Faixa de Valor"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGREFXVBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREFXVBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Criar cursor CsEstoque para o grid de pares Empresa/Grupo
                *   (replica o Create Cursor CsEstoque do procedimento "fConfigGeral"
                *    do form legado - cursor gerenciado pelo form, referenciado pelo BO)
                IF USED("CsEstoque")
                    USE IN CsEstoque
                ENDIF
                CREATE CURSOR CsEstoque (Emps C(3), Grupos C(10))
                INSERT INTO CsEstoque (Emps, Grupos) VALUES ("", "")

                *-- Cabecalho escuro com titulo (equivalente ao cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com pagina de filtros
                THIS.ConfigurarPageFrame()

                *-- Campos de filtro, grid e container Aguarde na Page1
                THIS.ConfigurarCamposFiltro()

                *-- Vincular eventos de validacao do grid CsEstoque (Empresa/Grupo)
                THIS.ConfigurarPaginaDados()

                *-- Vincular eventos Click dos botoes de relatorio
                THIS.ConfigurarBotoesBind()

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
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura = Width do form (761px) - cobre toda a faixa superior.
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
                .Caption   = THIS.Caption
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = THIS.Caption
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
    * ConfigurarBotoes - CommandGroup de botoes de relatorio (btnReport area)
    *   Original: btnReport.Left=408, Width=348, Height=75 por botao
    *   Novo: cmg_4c_Botoes alinhado a direita do form (Width=761)
    *   Botoes: Visualizar(5), Imprimir(71), Excel(137), Encerrar(203) - W=65
    *   Eventos Click sao vinculados nas fases seguintes (Fase 7).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Alinhar a direita com margem de 5px
        LOCAL loc_nLeft
        loc_nLeft = THIS.Width - 273 - 5

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = loc_nLeft
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

            *-- Imprimir (com dialogo de impressora)
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

            *-- Encerrar (fechar form - ESC)
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
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   O form legado SIGREFXV e FLAT (sem PageFrame), mas no novo padrao
    *   os campos sao agrupados em um PageFrame de 1 pagina para consistencia.
    *   Posicionado logo abaixo do cabecalho (80px) ate o fim do form (398px).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: logo abaixo do cabecalho ate o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 - pagina de filtros
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
    * Destroy - Limpeza de recursos
    *   NAO usar .Release() no BO (Custom nao tem Release).
    *   NAO fechar CsEstoque aqui - BO.Destroy() cuida dos cursores do relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        IF USED("CsEstoque")
            USE IN CsEstoque
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    *-- FASE 4: Campos de Filtro + Grid + Botoes
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarCamposFiltro - Adiciona todos os controles de filtro a Page1
    * Posicoes relativas a Page1 = posicao_original - 85 (offset do PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFiltro()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Posicao :"
        loc_oPg.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg.lbl_4c_Label7
            .Top       = 44
            .Left      = 112
            .Width     = 45
            .Height    = 15
            .Caption   = "Posi" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup: Atual (1) / Retroativa (2)
        loc_oPg.AddObject("obj_4c_OptRfEstoque", "OptionGroup")
        WITH loc_oPg.obj_4c_OptRfEstoque
            .Top         = 41
            .Left        = 162
            .Width       = 143
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Themes      = .F.
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Atual"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top       = 0
                .Left      = 0
                .Width     = 60
                .Height    = 25
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Retroativa"
                .Top       = 0
                .Left      = 63
                .Width     = 80
                .Height    = 25
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_OptRfEstoque, "InteractiveChange", THIS, "OptRfEstoqueChange")

        *-- Label "em" (oculto - aparece quando Retroativa selecionada)
        loc_oPg.AddObject("lbl_4c_EstoqueEm", "Label")
        WITH loc_oPg.lbl_4c_EstoqueEm
            .Top       = 65
            .Left      = 225
            .Width     = 16
            .Height    = 15
            .Caption   = "em"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        *-- txt_4c_DataSaldo (data da posicao retroativa - oculto inicialmente)
        loc_oPg.AddObject("txt_4c_DataSaldo", "TextBox")
        WITH loc_oPg.txt_4c_DataSaldo
            .Top      = 61
            .Left     = 244
            .Width    = 79
            .Height   = 25
            .Value    = {}
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .F.
        ENDWITH

        *-- Label "Moeda :"
        loc_oPg.AddObject("lbl_4c_Lbl_moeda", "Label")
        WITH loc_oPg.lbl_4c_Lbl_moeda
            .Top       = 104
            .Left      = 116
            .Width     = 41
            .Height    = 15
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c__cd_moeda (codigo da moeda)
        loc_oPg.AddObject("txt_4c__cd_moeda", "TextBox")
        WITH loc_oPg.txt_4c__cd_moeda
            .Top      = 101
            .Left     = 165
            .Width    = 31
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c__cd_moeda, "KeyPress", THIS, "TeclaCdMoeda")

        *-- txt_4c__ds_moeda (descricao da moeda)
        loc_oPg.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH loc_oPg.txt_4c__ds_moeda
            .Top      = 101
            .Left     = 198
            .Width    = 117
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c__ds_moeda, "KeyPress", THIS, "TeclaDsMoeda")

        *-- Label "Complemento Caracteristica :"
        loc_oPg.AddObject("lbl_4c_LblComplementoCarac", "Label")
        WITH loc_oPg.lbl_4c_LblComplementoCarac
            .Top       = 124
            .Left      = 82
            .Width     = 75
            .Height    = 28
            .Caption   = "Complemento" + CHR(13) + "Caracter" + CHR(237) + "stica :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .WordWrap  = .T.
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_FichaT (codigo do titulo de caracteristica - SigPrCpP.Codigos)
        loc_oPg.AddObject("txt_4c_FichaT", "TextBox")
        WITH loc_oPg.txt_4c_FichaT
            .Top      = 128
            .Left     = 165
            .Width    = 150
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_FichaT, "KeyPress", THIS, "TeclaFichaT")

        *-- Label "Grande Grupo :"
        loc_oPg.AddObject("lbl_4c_LblGrandeGrupo", "Label")
        WITH loc_oPg.lbl_4c_LblGrandeGrupo
            .Top       = 158
            .Left      = 81
            .Width     = 76
            .Height    = 15
            .Caption   = "Grande Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_GGrus (codigo do grande grupo - SigCdGpr.Codigos)
        loc_oPg.AddObject("txt_4c_GGrus", "TextBox")
        WITH loc_oPg.txt_4c_GGrus
            .Top      = 155
            .Left     = 165
            .Width    = 35
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_GGrus, "KeyPress", THIS, "TeclaGGrus")

        *-- txt_4c_DGRus (descricao do grande grupo - SigCdGpr.Descs)
        loc_oPg.AddObject("txt_4c_DGRus", "TextBox")
        WITH loc_oPg.txt_4c_DGRus
            .Top      = 155
            .Left     = 202
            .Width    = 146
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_DGRus, "KeyPress", THIS, "TeclaDGRus")

        *-- Label "Grupo :"
        loc_oPg.AddObject("lbl_4c_Lbl_grupo", "Label")
        WITH loc_oPg.lbl_4c_Lbl_grupo
            .Top       = 185
            .Left      = 119
            .Width     = 38
            .Height    = 15
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c__cd_grupo (codigo do grupo de produto - SigCdGrp.CGrus)
        loc_oPg.AddObject("txt_4c__cd_grupo", "TextBox")
        WITH loc_oPg.txt_4c__cd_grupo
            .Top      = 182
            .Left     = 165
            .Width    = 35
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c__cd_grupo, "KeyPress", THIS, "TeclaCdGrupo")

        *-- txt_4c__ds_grupo (descricao do grupo - SigCdGrp.DGrus)
        loc_oPg.AddObject("txt_4c__ds_grupo", "TextBox")
        WITH loc_oPg.txt_4c__ds_grupo
            .Top      = 182
            .Left     = 202
            .Width    = 146
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c__ds_grupo, "KeyPress", THIS, "TeclaDsGrupo")

        *-- Label "Estoques" (cabecalho da grade) - corresponde ao Label1 original (Left=414)
        loc_oPg.AddObject("lbl_4c_Estoques", "Label")
        WITH loc_oPg.lbl_4c_Estoques
            .Top       = 39
            .Left      = 414
            .Width     = 53
            .Height    = 15
            .Caption   = "Estoques"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid de selecao de pares Empresa/Grupo
        THIS.ConfigurarGridEstoques(loc_oPg)

        *-- Container de aguarde (visivel durante processamento)
        THIS.ConfigurarContainerAguarde(loc_oPg)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGridEstoques - Grid de pares Empresa/Grupo (grdEstoque legado)
    * Cursor: CsEstoque (Emps C(3), Grupos C(10)) - gerenciado pelo form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGridEstoques(par_oPg)
        par_oPg.AddObject("grd_4c_Dados", "Grid")
        WITH par_oPg.grd_4c_Dados
            .Top               = 56
            .Left              = 360
            .Width             = 182
            .Height            = 224
            .ColumnCount       = 2
            .RecordSource      = "CsEstoque"
            .RecordMark        = .F.
            .DeleteMark        = .F.
            .ScrollBars        = 2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
            .Visible           = .T.

            WITH .Column1
                .ControlSource    = "CsEstoque.Emps"
                .Width            = 80
                .HeaderHeight       = 0
                .Header1.Caption  = "Empresa"
            ENDWITH

            WITH .Column2
                .ControlSource    = "CsEstoque.Grupos"
                .Width            = 100
                .Header1.Caption  = "Grupo Estoque"
            ENDWITH
        ENDWITH
        BINDEVENT(par_oPg.grd_4c_Dados, "AfterRowColChange", THIS, ;
            "GrdEstoquesAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerAguarde - Container visivel durante processamento
    * Equivalente ao Aguarde do legado (top=190, left=261 no form original)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerAguarde(par_oPg)
        par_oPg.AddObject("cnt_4c_Aguarde", "Container")
        WITH par_oPg.cnt_4c_Aguarde
            .Top         = 105
            .Left        = 261
            .Width       = 350
            .Height      = 110
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 204)
            .BorderWidth = 1
            .Visible     = .F.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top       = 13
                .Left      = 12
                .Width     = 326
                .Height    = 27
                .Caption   = "Aguarde..."
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top       = 47
                .Left      = 9
                .Width     = 332
                .Height    = 27
                .Caption   = "Processando Dados"
                .FontName  = "Tahoma"
                .FontSize  = 12
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesBind - Vincula eventos Click dos 4 botoes de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesBind()
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Compatibilidade (form de relatorio tem 1 pagina de filtros)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) = "N" AND par_nPagina = 1
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Wrapper compatibilidade com pipeline CRUD
    *   Forms REPORT nao tem Page de lista CRUD. A Page1 e a unica pagina e
    *   hospeda os campos de filtro + grid de estoques (configurados em
    *   ConfigurarCamposFiltro / ConfigurarGridEstoques na Fase 4).
    *   Este wrapper garante idempotencia caso o pipeline o invoque.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF !PEMSTATUS(loc_oPg, "grd_4c_Dados", 5)
            THIS.ConfigurarCamposFiltro()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reinicia todos os campos de filtro ao estado inicial
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.obj_4c_OptRfEstoque.Value = 1
        loc_oPg.txt_4c_DataSaldo.Value    = {}
        loc_oPg.lbl_4c_EstoqueEm.Visible  = .F.
        loc_oPg.txt_4c_DataSaldo.Visible   = .F.
        loc_oPg.txt_4c__cd_moeda.Value    = ""
        loc_oPg.txt_4c__ds_moeda.Value    = ""
        loc_oPg.txt_4c_FichaT.Value       = ""
        loc_oPg.txt_4c_GGrus.Value        = ""
        loc_oPg.txt_4c_DGRus.Value        = ""
        loc_oPg.txt_4c__cd_grupo.Value    = ""
        loc_oPg.txt_4c__ds_grupo.Value    = ""

        IF USED("CsEstoque")
            SELECT CsEstoque
            ZAP
            INSERT INTO CsEstoque (Emps, Grupos) VALUES ("", "")
            loc_oPg.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores do form para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            .this_nNrPeriodo = loc_oPg.obj_4c_OptRfEstoque.Value
            .this_dDataSaldo  = loc_oPg.txt_4c_DataSaldo.Value
            .this_cCdMoeda    = ALLTRIM(loc_oPg.txt_4c__cd_moeda.Value)
            .this_cDsMoeda    = ALLTRIM(loc_oPg.txt_4c__ds_moeda.Value)
            .this_cFichaT     = ALLTRIM(loc_oPg.txt_4c_FichaT.Value)
            .this_cGGrus      = ALLTRIM(loc_oPg.txt_4c_GGrus.Value)
            .this_cDGRus      = ALLTRIM(loc_oPg.txt_4c_DGRus.Value)
            .this_cCdGrupo    = ALLTRIM(loc_oPg.txt_4c__cd_grupo.Value)
            .this_cDsGrupo    = ALLTRIM(loc_oPg.txt_4c__ds_grupo.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFormulario - Valida campos obrigatorios antes de gerar relatorio
    * Replica validacoes do Click legado: moeda e grande grupo obrigatorios
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFormulario()
        LOCAL loc_oPg, loc_lValido
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(loc_oPg.txt_4c__cd_moeda.Value))
            MsgAviso("Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c__cd_moeda.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(loc_oPg.txt_4c_GGrus.Value))
            MsgAviso("Grande Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_GGrus.SetFocus()
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - "Gerar Relatorio" no contexto REPORT
    *   Em forms CRUD esse evento abriria a Page2 para inclusao de novo
    *   registro. Em forms REPORT a acao equivalente eh produzir uma nova
    *   saida do relatorio: valida filtros e exibe o preview em video.
    *   Delega para BtnVisualizarClick (mesma semantica de "gerar saida").
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - "Limpar Filtros" no contexto REPORT
    *   Em forms CRUD esse evento abriria Page2 com registro selecionado
    *   para edicao. Em REPORT a acao equivalente eh resetar todos os
    *   filtros (moeda, caracteristica, grande grupo, grupo, posicao,
    *   data retroativa e grid CsEstoque) para que o usuario monte uma
    *   nova combinacao de criterios. Devolve foco ao primeiro campo
    *   obrigatorio (codigo da moeda).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPg
        THIS.LimparCampos()
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_oPg.txt_4c__cd_moeda.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - "Encerrar" no contexto REPORT
    *   Em forms CRUD esse evento confirmaria e removeria o registro
    *   selecionado. Em REPORT nao ha registro a remover, entao a
    *   semantica equivalente eh "abandonar o relatorio" - fecha o
    *   formulario (mesmo efeito do botao Encerrar Buttons(4) e do ESC).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Gera relatorio em preview de video
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        IF !THIS.ValidarFormulario()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        loc_oPg.cnt_4c_Aguarde.Visible = .T.
        loc_oPg.cnt_4c_Aguarde.Refresh()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
        loc_oPg.cnt_4c_Aguarde.Visible = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Gera relatorio e envia para impressora (com dialogo)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        IF !THIS.ValidarFormulario()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        loc_oPg.cnt_4c_Aguarde.Visible = .T.
        loc_oPg.cnt_4c_Aguarde.Refresh()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
        loc_oPg.cnt_4c_Aguarde.Visible = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_oPg, loc_cArquivo, loc_lSucesso, loc_oErro
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_lSucesso = .F.

        IF !THIS.ValidarFormulario()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        loc_oPg.cnt_4c_Aguarde.Visible = .T.
        loc_oPg.cnt_4c_Aguarde.Refresh()

        TRY
            IF THIS.this_oRelatorio.PrepararDados()
                IF USED("CsRelatorio")
                    loc_cArquivo = gc_4c_CaminhoBase + "reports\SigReFxv_" + ;
                                   STRTRAN(DTOC(DATE(), 1), "-", "") + ".xls"
                    SELECT CsRelatorio
                    COPY TO (loc_cArquivo) TYPE XL5
                    MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo, "Excel")
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Nenhum dado para exportar.", "Aviso")
                ENDIF
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao exportar Excel")
        ENDTRY

        loc_oPg.cnt_4c_Aguarde.Visible = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * OptRfEstoqueChange - Trata mudanca na opcao de periodo
    * Dispara em InteractiveChange do obj_4c_OptRfEstoque
    * Valor 1=Atual (oculta data), Valor 2=Retroativa (exibe data)
    *--------------------------------------------------------------------------
    PROCEDURE OptRfEstoqueChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        IF loc_oPg.obj_4c_OptRfEstoque.Value = 1
            loc_oPg.lbl_4c_EstoqueEm.Visible = .F.
            loc_oPg.txt_4c_DataSaldo.Visible  = .F.
            loc_oPg.txt_4c_DataSaldo.Value    = {}
        ELSE
            loc_oPg.lbl_4c_EstoqueEm.Visible = .T.
            loc_oPg.txt_4c_DataSaldo.Visible  = .T.
            IF EMPTY(loc_oPg.txt_4c_DataSaldo.Value)
                loc_oPg.txt_4c_DataSaldo.Value = DATE()
            ENDIF
        ENDIF
        loc_oPg.txt_4c_DataSaldo.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoeda - F4/Enter/Tab em txt_4c__cd_moeda abre busca por codigo
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.AbrirBuscaMoedaCodigo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoeda - F4/Enter/Tab em txt_4c__ds_moeda abre busca por descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.AbrirBuscaMoedaDesc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaFichaT - F4/Enter/Tab em txt_4c_FichaT abre busca de caracteristica
    *--------------------------------------------------------------------------
    PROCEDURE TeclaFichaT(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.AbrirBuscaCaracteristica()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGGrus - F4/Enter/Tab em txt_4c_GGrus abre busca de grande grupo (cod)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGGrus(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.AbrirBuscaGrandeGrupoCodigo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDGRus - F4/Enter/Tab em txt_4c_DGRus abre busca de grande grupo (desc)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDGRus(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.AbrirBuscaGrandeGrupoDesc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdGrupo - F4/Enter/Tab em txt_4c__cd_grupo abre busca de grupo (cod)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdGrupo(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.AbrirBuscaGrupoCodigo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsGrupo - F4/Enter/Tab em txt_4c__ds_grupo abre busca de grupo (desc)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsGrupo(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.AbrirBuscaGrupoDesc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoedaCodigo - Lookup SigCdMoe pelo codigo (CMoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaMoedaCodigo()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__cd_moeda.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_Moeda", "CMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda")

        IF ISNULL(loc_oForm)
            RETURN
        ENDIF

        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Moeda")
            SELECT cursor_4c_Moeda
            IF !EOF()
                loc_oPg.txt_4c__cd_moeda.Value = ALLTRIM(CMoes)
                loc_oPg.txt_4c__ds_moeda.Value = ALLTRIM(DMoes)
            ENDIF
        ENDIF

        IF USED("cursor_4c_Moeda")
            USE IN cursor_4c_Moeda
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoedaDesc - Lookup SigCdMoe pela descricao (DMoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaMoedaDesc()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__ds_moeda.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_Moeda", "DMoes", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda")

        IF ISNULL(loc_oForm)
            RETURN
        ENDIF

        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Moeda")
            SELECT cursor_4c_Moeda
            IF !EOF()
                loc_oPg.txt_4c__cd_moeda.Value = ALLTRIM(CMoes)
                loc_oPg.txt_4c__ds_moeda.Value = ALLTRIM(DMoes)
            ENDIF
        ENDIF

        IF USED("cursor_4c_Moeda")
            USE IN cursor_4c_Moeda
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCaracteristica - Lookup SigPrCpP pelo codigo do titulo (Codigos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaCaracteristica()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_FichaT.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrCpP", "cursor_4c_Carac", "Codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Caracter" + CHR(237) + "stica")

        IF ISNULL(loc_oForm)
            RETURN
        ENDIF

        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Codigos", "", "T" + CHR(237) + "tulo Caracter" + CHR(237) + "sticas")
            loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Carac")
            SELECT cursor_4c_Carac
            IF !EOF()
                loc_oPg.txt_4c_FichaT.Value = ALLTRIM(Codigos)
            ENDIF
        ENDIF

        IF USED("cursor_4c_Carac")
            USE IN cursor_4c_Carac
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrandeGrupoCodigo - Lookup SigCdGpr pelo codigo (Codigos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaGrandeGrupoCodigo()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_GGrus.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGpr", "cursor_4c_GGrp", "Codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grande Grupo")

        IF ISNULL(loc_oForm)
            RETURN
        ENDIF

        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GGrp")
            SELECT cursor_4c_GGrp
            IF !EOF()
                loc_oPg.txt_4c_GGrus.Value = ALLTRIM(Codigos)
                loc_oPg.txt_4c_DGRus.Value = ALLTRIM(Descs)
            ENDIF
        ENDIF

        IF USED("cursor_4c_GGrp")
            USE IN cursor_4c_GGrp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrandeGrupoDesc - Lookup SigCdGpr pela descricao (Descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaGrandeGrupoDesc()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DGRus.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGpr", "cursor_4c_GGrp", "Descs", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grande Grupo")

        IF ISNULL(loc_oForm)
            RETURN
        ENDIF

        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GGrp")
            SELECT cursor_4c_GGrp
            IF !EOF()
                loc_oPg.txt_4c_GGrus.Value = ALLTRIM(Codigos)
                loc_oPg.txt_4c_DGRus.Value = ALLTRIM(Descs)
            ENDIF
        ENDIF

        IF USED("cursor_4c_GGrp")
            USE IN cursor_4c_GGrp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupoCodigo - Lookup SigCdGrp pelo codigo (CGrus)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaGrupoCodigo()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__cd_grupo.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_Grp", "CGrus", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo de Produto")

        IF ISNULL(loc_oForm)
            RETURN
        ENDIF

        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Grp")
            SELECT cursor_4c_Grp
            IF !EOF()
                loc_oPg.txt_4c__cd_grupo.Value = ALLTRIM(CGrus)
                loc_oPg.txt_4c__ds_grupo.Value = ALLTRIM(DGrus)
            ENDIF
        ENDIF

        IF USED("cursor_4c_Grp")
            USE IN cursor_4c_Grp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupoDesc - Lookup SigCdGrp pela descricao (DGrus)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaGrupoDesc()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__ds_grupo.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_Grp", "DGrus", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo de Produto")

        IF ISNULL(loc_oForm)
            RETURN
        ENDIF

        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.mAddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Grp")
            SELECT cursor_4c_Grp
            IF !EOF()
                loc_oPg.txt_4c__cd_grupo.Value = ALLTRIM(CGrus)
                loc_oPg.txt_4c__ds_grupo.Value = ALLTRIM(DGrus)
            ENDIF
        ENDIF

        IF USED("cursor_4c_Grp")
            USE IN cursor_4c_Grp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdEstoquesAfterRowColChange - Mantem linha em branco ao final do grid
    * Replica logica do LostFocus do Column2.Text1 do legado SIGREFXV
    * par_nColIndex: indice da coluna que perdeu o foco
    *--------------------------------------------------------------------------
    PROCEDURE GrdEstoquesAfterRowColChange(par_nColIndex)
        IF !USED("CsEstoque")
            RETURN
        ENDIF
        SELECT CsEstoque
        LOCATE FOR EMPTY(Emps) AND EMPTY(Grupos)
        IF EOF()
            APPEND BLANK
        ENDIF
    ENDPROC

    *==========================================================================
    *-- FASE 5: Validacao do Grid CsEstoque (ConfigurarPaginaDados)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Vincula eventos de validacao dos Text1 do grid
    *   Para forms REPORT (sem Page2 CRUD), este metodo configura os handlers
    *   de teclado para os campos editaveis do grid CsEstoque:
    *   - Column1.Text1: replica fAcessoEmpresa do legado (valida Emps)
    *   - Column2.Text1: replica fAcessoContab do legado (valida Grupos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oGrd
        loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

        BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "TeclaEmpresaGrid")
        BINDEVENT(loc_oGrd.Column2.Text1, "KeyPress", THIS, "TeclaGrupoEstoqueGrid")
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresaGrid - F4/Enter/Tab no campo Empresa do grid CsEstoque
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresaGrid(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarEmpresaGrid()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGrupoEstoqueGrid - F4/Enter/Tab no campo Grupo do grid CsEstoque
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupoEstoqueGrid(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 13, 9)
            THIS.ValidarGrupoEstoqueGrid()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresaGrid - Lookup de empresa para a coluna Emps do grid
    *   Replica fAcessoEmpresa(Usuar, 'C', This.Value, This, '') do legado.
    *   Se o codigo digitado nao existir em SigCdEmp, abre FormBuscaAuxiliar.
    *   Ao selecionar, substitui o registro corrente do CsEstoque.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarEmpresaGrid()
        LOCAL loc_cValor, loc_oForm, loc_oGrd
        loc_oGrd   = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
        loc_cValor = ALLTRIM(loc_oGrd.Column1.Text1.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_Emp", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa")

        IF ISNULL(loc_oForm)
            RETURN
        ENDIF

        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Demps", "", "Nome")
            loc_oForm.Show()
        ENDIF

        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_Emp")
            SELECT cursor_4c_Emp
            IF !EOF() AND USED("CsEstoque")
                SELECT CsEstoque
                REPLACE Emps WITH ALLTRIM(Cemps)
                loc_oGrd.Refresh()
            ENDIF
        ENDIF

        IF USED("cursor_4c_Emp")
            USE IN cursor_4c_Emp
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoEstoqueGrid - Lookup de grupo de estoque para coluna Grupos
    *   Replica fAcessoContab(Usuar, 'C', This.Value, This, '') do legado.
    *   Valida CGrus em SigCdGrp; se nao encontrado, abre FormBuscaAuxiliar.
    *   Ao selecionar, atualiza o registro corrente do CsEstoque.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarGrupoEstoqueGrid()
        LOCAL loc_cValor, loc_oForm, loc_oGrd, loc_cSQL, loc_nResult
        loc_oGrd   = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
        loc_cValor = ALLTRIM(loc_oGrd.Column2.Text1.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal")

        IF loc_nResult > 0
            SELECT cursor_4c_GrpVal
            IF EOF()
                *-- Codigo nao encontrado - abrir busca visual
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGrp", "cursor_4c_GrpSel", "CGrus", loc_cValor, ;
                    "Sele" + CHR(231) + CHR(227) + "o de Grupo de Estoque")

                IF !ISNULL(loc_oForm)
                    IF !loc_oForm.this_lAchouRegistro
                        loc_oForm.mAddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
                        loc_oForm.mAddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oForm.Show()
                    ENDIF

                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_GrpSel")
                        SELECT cursor_4c_GrpSel
                        IF !EOF() AND USED("CsEstoque")
                            SELECT CsEstoque
                            REPLACE Grupos WITH ALLTRIM(CGrus)
                            loc_oGrd.Refresh()
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_GrpSel")
                        USE IN cursor_4c_GrpSel
                    ENDIF
                    loc_oForm.Release()
                ENDIF
            ENDIF
            IF USED("cursor_4c_GrpVal")
                USE IN cursor_4c_GrpVal
            ENDIF
        ENDIF
    ENDPROC


    *==========================================================================
    *-- FASE 8: Eventos Auxiliares e Consolidacao Final
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - "Buscar" no contexto REPORT
    *   Em forms CRUD abre tela de consulta/visualizacao do registro selecionado.
    *   Em REPORT a semantica equivalente eh gerar o relatorio para visualizacao
    *   (preview em video) com os filtros preenchidos.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - "Salvar/Confirmar" no contexto REPORT
    *   Em forms CRUD persiste o registro editado.
    *   Em REPORT a semantica equivalente eh "confirmar os filtros e gerar"
    *   o relatorio, delegando para Visualizar (preview em video).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - "Cancelar" no contexto REPORT
    *   Em forms CRUD descarta edicao e volta para lista.
    *   Em REPORT a semantica equivalente eh limpar todos os filtros
    *   e devolver foco ao primeiro campo obrigatorio (Moeda).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oPg
        THIS.LimparCampos()
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_oPg.txt_4c__cd_moeda.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Wrapper de compatibilidade com pipeline CRUD
    *   Em forms CRUD sincroniza campos da Page2 para o BO (BusinessBase).
    *   Em REPORT o BO equivalente eh o RelatorioBase; delega para
    *   FormParaRelatorio() que ja mapeia todos os filtros para o BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Wrapper de compatibilidade com pipeline CRUD
    *   Em forms CRUD popula campos do form a partir do BO (modo edicao).
    *   Em REPORT o fluxo eh unidirecional (form -> BO -> relatorio);
    *   nao ha necessidade de repopular campos a partir do BO, portanto
    *   este metodo e intencionalmente no-op para este tipo de form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        *-- Sem acao: forms REPORT nao recebem dados de volta do BO
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/Desabilita campos de filtro conforme estado
    *   Em forms CRUD controla quais TextBoxes sao editaveis por modo (INCLUIR,
    *   ALTERAR, VISUALIZAR). Em REPORT todos os filtros sao sempre editaveis;
    *   o unico campo que muda visibilidade e txt_4c_DataSaldo (controlado pelo
    *   OptionGroup via OptRfEstoqueChange). O parametro par_lHabilitar e
    *   aceito por compatibilidade mas nao altera o comportamento do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lEnabled
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_lEnabled = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        loc_oPg.obj_4c_OptRfEstoque.Enabled = loc_lEnabled
        loc_oPg.txt_4c__cd_moeda.Enabled    = loc_lEnabled
        loc_oPg.txt_4c__ds_moeda.Enabled    = loc_lEnabled
        loc_oPg.txt_4c_FichaT.Enabled       = loc_lEnabled
        loc_oPg.txt_4c_GGrus.Enabled        = loc_lEnabled
        loc_oPg.txt_4c_DGRus.Enabled        = loc_lEnabled
        loc_oPg.txt_4c__cd_grupo.Enabled    = loc_lEnabled
        loc_oPg.txt_4c__ds_grupo.Enabled    = loc_lEnabled
        loc_oPg.grd_4c_Dados.Enabled        = loc_lEnabled

        *-- DataSaldo so habilitada se periodo = Retroativa (Value=2)
        IF loc_lEnabled
            loc_oPg.txt_4c_DataSaldo.Enabled = (loc_oPg.obj_4c_OptRfEstoque.Value = 2)
        ELSE
            loc_oPg.txt_4c_DataSaldo.Enabled = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Wrapper de compatibilidade com pipeline CRUD
    *   Em forms CRUD (re)carrega o grid da Page1 (lista de registros).
    *   Em REPORT nao ha grid de lista CRUD; o grid grd_4c_Dados e de
    *   selecao de pares Empresa/Grupo, nao de listagem de registros.
    *   Retorna .T. para indicar sucesso ao pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Wrapper de compatibilidade com pipeline CRUD
    *   Em forms CRUD habilita/desabilita botoes conforme o modo corrente
    *   (LISTA, INCLUIR, ALTERAR, VISUALIZAR). Em REPORT nao ha modos CRUD;
    *   os 4 botoes do CommandGroup (Visualizar/Imprimir/Excel/Encerrar)
    *   permanecem sempre habilitados.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        *-- Sem acao: forms REPORT nao tem modos CRUD
        RETURN
    ENDPROC

ENDDEFINE
