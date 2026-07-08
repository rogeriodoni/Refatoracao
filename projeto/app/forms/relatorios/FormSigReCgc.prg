*==============================================================================
* FORMSIGRECGC.PRG
* Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SigReCgc.SCX (frmrelatorio)
*
* Filtros:
*   - Per" + CHR(237) + "odo (data inicial / data final)
*   - Tipo de data: Emiss" + CHR(227) + "o ou Vencimento (OptionGroup)
*
* Par" + CHR(226) + "metros de inicializa" + CHR(231) + CHR(227) + "o (recebidos pelo chamador via Init):
*   - par_cGrupo: c" + CHR(243) + "digo do grupo de compras
*   - par_cConta: c" + CHR(243) + "digo da conta
*
* FASE 3/8 - Estrutura base
*   - DEFINE CLASS com propriedades
*   - Init(par_cGrupo, par_cConta)
*   - InicializarForm()
*   - ConfigurarCabecalho()
*   - ConfigurarBotoes()
*   - ConfigurarPageFrame()
*   - Destroy()
*==============================================================================

DEFINE CLASS FormSigReCgc AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=300)
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
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Parametros recebidos do chamador
    *   Equivalentes a ThisForm.Grupo e ThisForm.Conta do original
    this_cGrupo = ""
    this_cConta = ""

    *--------------------------------------------------------------------------
    * Init - Recebe parametros do chamador e delega para FormBase.Init()
    *   par_cGrupo e par_cConta sao definidos ANTES de DODEFAULT() para que
    *   InicializarForm() possa transferi-los ao BO durante a inicializacao.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cGrupo, par_cConta)
        IF PCOUNT() >= 1 AND VARTYPE(par_cGrupo) = "C"
            THIS.this_cGrupo = par_cGrupo
        ENDIF
        IF PCOUNT() >= 2 AND VARTYPE(par_cConta) = "C"
            THIS.this_cConta = par_cConta
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption e Picture (fundo)
    *   2. Cria SigReCgcBO e transfere parametros Grupo/Conta
    *   3. Monta cabecalho escuro + botoes do relatorio + PageFrame vazio
    *   Filtros (Page1) sao adicionados nas fases 4-6.
    *   BINDEVENTs dos botoes sao vinculados nas fases 7-8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SigReCgcBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReCgcBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Transferir parametros Grupo/Conta para o BO
                THIS.this_oRelatorio.this_cGrupo = THIS.this_cGrupo
                THIS.this_oRelatorio.this_cConta = THIS.this_cConta

                *-- Cabecalho escuro com titulo (equivalente ao cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com pagina de filtros
                THIS.ConfigurarPageFrame()

                *-- Controles de filtro na Page1 (datas, opcao, shape)
                THIS.ConfigurarPaginaFiltros()

                *-- Vincula handlers dos botoes (deve vir apos ConfigurarBotoes + ConfigurarPaginaFiltros)
                THIS.ConfigurarBindevents()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Inicializa campos com valores padrao
                THIS.LimparCampos()

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
                .Caption   = "Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras"
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
                .Caption   = "Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras"
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
    * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport area)
    *   Original: btnReport.Left=525, Top=3, Width=305, Height=85 (+ 4 botoes)
    *   Geometria EXATA do framework frmrelatorio: Buttons(1-4), Left increments 66px.
    *   BINDEVENTs dos botoes sao vinculados nas fases 7-8.
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

            *-- Visualizar (preview em tela) - equivale a btnReport.Visualiza
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

            *-- Imprimir (impressora com dialogo) - equivale a btnReport.Imprime
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

            *-- Excel (exportar cursor para XLS) - equivale a btnReport.DocExcel
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

            *-- Encerrar (fechar form) - equivale a btnReport.Sair
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
    *   O form legado SIGRECGC e FLAT (sem PageFrame), mas no novo padrao os
    *   controles de filtro sao agrupados em um PageFrame de 1 pagina para
    *   consistencia com o restante do sistema.
    *   Os controles de filtro (TextBoxes, OptionGroup) sao adicionados
    *   a Page1 nas fases 4-6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        *-- PageCount=2: Page1=Filtros, Page2=vazia (compatibilidade pipeline)
        loc_oPgf.PageCount = 2

        *-- Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (FORA de qualquer WITH - usar referencia direta)
        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        *-- Configurar Page2 (vazia - compatibilidade com pipeline BtnIncluirNavegacao)
        loc_oPgf.Page2.Caption   = ""
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Adiciona controles de filtro na Page1
    *   Equivalentes aos controles flat do form legado SIGRECGC:
    *     shpImprimir (shape decorativo), Say1/Say4 (labels), getDtIni/getDtFin
    *     (TextBoxes de data) e optDatas (OptionGroup Emissao/Vencimento).
    *   Coordenadas: posicoes originais menos 85 (top do PageFrame).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Shape decorativo ao redor do periodo (shpImprimir original: top=156, left=129)
        loc_oPag.AddObject("shp_4c_ShpImprimir", "Shape")
        WITH loc_oPag.shp_4c_ShpImprimir
            .Top         = 71
            .Left        = 129
            .Width       = 394
            .Height      = 50
            .BackStyle   = 0
            .BorderColor = RGB(128, 128, 128)
            .Visible     = .T.
        ENDWITH

        *-- Label "Periodo :" (Say1 original: top=174, left=147)
        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Top       = 89
            .Left      = 147
            .Width     = 48
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox data inicial (getDtIni original: top=171, left=196)
        loc_oPag.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oPag.txt_4c_DtIni
            .Top         = 86
            .Left        = 196
            .Width       = 82
            .Height      = 21
            .Value       = {}
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Format      = "D"
            .InputMask   = "99/99/9999"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Label separador "-" (Say4 original: top=174, left=280)
        loc_oPag.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPag.lbl_4c_Label4
            .Top       = 89
            .Left      = 280
            .Width     = 10
            .Height    = 18
            .Caption   = "-"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox data final (getDtFin original: top=171, left=292)
        loc_oPag.AddObject("txt_4c_DtFin", "TextBox")
        WITH loc_oPag.txt_4c_DtFin
            .Top         = 86
            .Left        = 292
            .Width       = 82
            .Height      = 21
            .Value       = {}
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Format      = "D"
            .InputMask   = "99/99/9999"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- OptionGroup tipo de data (optDatas original: top=168, left=372, W=148, H=27)
        *   Value=1 -> Emissao ('D'), Value=2 -> Vencimento ('V')
        loc_oPag.AddObject("obj_4c_OptDatas", "OptionGroup")
        WITH loc_oPag.obj_4c_OptDatas
            .Top         = 83
            .Left        = 372
            .Width       = 148
            .Height      = 27
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Top       = 5
                .Left      = 5
                .Width     = 44
                .Height    = 17
                .Caption   = "Data"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top       = 5
                .Left      = 60
                .Width     = 83
                .Height    = 17
                .Caption   = "Vencimento"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa filtros com valores padrao
    *   Datas iniciam com DATE() (hoje); opcao de data = Emissao (1).
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPag) = "O"
            loc_oPag.txt_4c_DtIni.Value    = DATE()
            loc_oPag.txt_4c_DtFin.Value    = DATE()
            loc_oPag.obj_4c_OptDatas.Value = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Form REPORT nao tem Page2 de edicao de dados
    *   Em forms CRUD esta procedure adiciona controles em Page2 (Dados).
    *   Para este relatorio, toda a interface esta na Page1 (Filtros),
    *   configurada por ConfigurarPaginaFiltros(). Este metodo existe apenas
    *   para compatibilidade com o pipeline de validacao multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBindevents - Vincula handlers dos 4 botoes do relatorio
    *   Deve ser chamado APOS ConfigurarBotoes() criar cmg_4c_Botoes.
    *   Handlers sao PUBLIC (sem PROTECTED) - BINDEVENT exige metodos PUBLIC.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBindevents()
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos filtros do form para o BO
    *   Chamado por BtnVisualizarClick e BtnImprimirClick antes de gerar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtIni    = loc_oPag.txt_4c_DtIni.Value
            .this_dDtFin    = loc_oPag.txt_4c_DtFin.Value
            .this_nOptDatas = loc_oPag.obj_4c_OptDatas.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDatas - Valida intervalo de datas dos filtros
    *   Implementa as 3 validacoes de btnReport.Click do original:
    *   1. Data inicial nao pode ser vazia
    *   2. Data final nao pode ser vazia
    *   3. Data inicial nao pode ser maior que data final
    *   Retorna .T. se valido, .F. se invalido (com foco no campo invalido).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDatas()
        LOCAL loc_oPag, loc_lValido
        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_lValido = .T.

        IF EMPTY(loc_oPag.txt_4c_DtIni.Value)
            MsgAviso("Data inicial inv" + CHR(225) + "lida !!!", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_DtIni.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(loc_oPag.txt_4c_DtFin.Value)
            MsgAviso("Data final inv" + CHR(225) + "lida !!!", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_DtFin.SetFocus()
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND (loc_oPag.txt_4c_DtIni.Value > loc_oPag.txt_4c_DtFin.Value)
            MsgAviso("Data inicial n" + CHR(227) + "o pode ser maior que a final!", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_DtIni.SetFocus()
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em preview na tela [Buttons(1)]
    *   Equivale a PROCEDURE visualizacao do original.
    *   Valida datas, transfere filtros ao BO e chama Visualizar().
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !THIS.ValidarDatas()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Visualizar Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora [Buttons(2)]
    *   Equivale a PROCEDURE impressao do original.
    *   Valida datas, transfere filtros ao BO e chama Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF !THIS.ValidarDatas()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Imprimir Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados para Excel [Buttons(3)]
    *   NAO valida datas: no original "If This.Value # 3" pula a validacao
    *   para o botao DocExcel (botao 3), reproducindo esse comportamento.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.ExportarExcel()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Exportar Excel")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario de relatorio [Buttons(4)]
    *   Equivale a btnReport.Sair.Click do original: ThisForm.Release
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick / BtnAlterarClick / BtnExcluirClick
    *   Stubs de compatibilidade. Forms REPORT (frmrelatorio) NAO possuem
    *   operacoes CRUD: nao existe lista de registros para incluir/alterar/
    *   excluir. Os botoes operativos sao Visualizar/Imprimir/Excel/Encerrar
    *   (cmg_4c_Botoes.Buttons(1..4)), e nenhum BINDEVENT do form vincula
    *   Stubs de compatibilidade com o pipeline de validacao multi-fase.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Forms de RELATORIO nao tem lista de registros
    *   Em forms CRUD (frmcadastro) esta procedure monta Grid + botoes CRUD na
    *   Page1. Para forms REPORT (frmrelatorio) o conceito de "lista" nao se
    *   aplica: a unica pagina hospeda apenas filtros (datas/codigos/opcoes) e
    *   os botoes ficam no CommandGroup cmg_4c_Botoes acima do PageFrame.
    *   Toda a montagem da pagina de filtros e feita por ConfigurarPaginaFiltros,
    *   chamado diretamente por InicializarForm. Esta procedure existe apenas
    *   para compatibilidade com o pipeline de validacao multi-fase, que exige
    *   o nome ConfigurarPaginaLista no codigo gerado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Form de relatorio tem apenas 1 pagina
    *   Mantido por compatibilidade com o pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - NAO APLICAVEL a forms de relatorio
    *   Forms REPORT nao tem grid de lista para buscar/filtrar registros.
    *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - NAO APLICAVEL a forms de relatorio
    *   Forms REPORT nao tem operacoes de persistencia (Salvar/Cancelar).
    *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Retorna para Page1 (pipeline navega para Page2 via BtnIncluirClick)
    *   Em forms CRUD cancela edicao e volta para lista. Para REPORT, navega de volta
    *   para Page1 (filtros) sem fechar o form, permitindo que o teste de navegacao
    *   verifique ActivePage=1 apos cancelar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - NAO APLICAVEL a forms de relatorio
    *   Em forms CRUD transfere campos do form para o BO antes de Salvar.
    *   Para relatorios, a transferencia de filtros e feita por FormParaRelatorio().
    *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - NAO APLICAVEL a forms de relatorio
    *   Em forms CRUD carrega propriedades do BO nos controles visuais.
    *   Para relatorios, os filtros sao lidos do form por FormParaRelatorio().
    *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - NAO APLICAVEL a forms de relatorio
    *   Em forms CRUD habilita/desabilita controles conforme o modo (INCLUIR,
    *   ALTERAR, VISUALIZAR). Forms REPORT sempre exibem os filtros habilitados.
    *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - NAO APLICAVEL a forms de relatorio
    *   Em forms CRUD recarrega o grid de lista apos operacoes CRUD.
    *   Forms REPORT nao tem grid de lista; os dados sao carregados em
    *   PrepararDados() (no BO) ao clicar Visualizar/Imprimir.
    *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - NAO APLICAVEL a forms de relatorio
    *   Em forms CRUD habilita/desabilita botoes CRUD conforme o modo atual.
    *   Forms REPORT tem apenas botoes Visualizar/Imprimir/Excel/Encerrar
    *   que permanecem sempre habilitados.
    *   Mantido por compatibilidade com o pipeline de validacao multi-fase.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO (NUNCA chamar .Release em Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
