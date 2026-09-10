*==============================================================================
* FormTpa.prg - Formulario de Cadastro de Tipo de Acabamento
* Migrado de: SigCdTpa.SCX (frmcadastro)
* Tabela: SigCdAca
* Chave: cods char(3)
*
* FASE 6/8: Form - Campos Restantes e Lookups (Page2 - Parte 2)
* Inclui: PageFrame (Page1 Lista / Page2 Dados), cabecalhos das duas paginas,
*         Page1 completa (cnt_4c_Botoes com 5 botoes CRUD + cnt_4c_Saida com
*         cmd_4c_Encerrar + grd_4c_Lista), CarregarLista()/AlternarPagina()
*         (PUBLIC - chamados direto por TesteAutomatico.prg), FormatarGridLista()
*         e campos Codigo (lbl_4c_Label1 + txt_4c_Codigos) e Descricao
*         (lbl_4c_Label2 + txt_4c_Descrs) em Page2 - TODOS os campos do form
*         original ja migrados (SigCdTpa so tem Cods/Descrs, sem lookups).
* FASE 7/8: Form - Eventos Principais. BINDEVENT dos 4 botoes CRUD de Page1
*         (Incluir/Visualizar/Alterar/Excluir) + DblClick do grid -> Visualizar.
*         Metodos: BtnIncluirClick(), BtnVisualizarClick(), BtnAlterarClick(),
*         BtnExcluirClick() + auxiliares BOParaForm(), LimparCampos(),
*         HabilitarCampos() (necessarios para os 4 eventos serem funcionais).
* FASE 8/8: Form - Eventos Auxiliares e Consolidacao Final. Botoes Confirmar/
*         Cancelar criados em cnt_4c_BotoesAcao (Page2) + BINDEVENT dos botoes
*         Buscar (Page1) e Encerrar (Page1). Metodos: BtnBuscarClick()
*         (FormBuscaAuxiliar em SigCdAca), BtnEncerrarClick() (Release),
*         BtnSalvarClick(), BtnCancelarClick(), FormParaBO() e
*         AjustarBotoesPorModo(). Form COMPLETO e funcional.
*==============================================================================

DEFINE CLASS FormTpa AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Tipo de Acabamento"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - Apenas RETURN DODEFAULT()
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTpa.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("TpaBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar TpaBO", "FormTpa.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTpa.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 esconde abas; todos os controles internos compensam +29 no Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 (Lista): cabecalho + container
    * de botoes CRUD + container de saida + Grid completo (FASE 4/8)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Faixa do cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
        *-- Original Top=2, compensacao PageFrame +29 = 31 (CLAUDE.md regra #11)
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op no legado)
        *-- Canonico: Top=29, Left=542, Width=390 (lado direito, framework_frmcadastro_layout.md)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida (Grupo_Saida no legado) - PADRAO CANONICO
        *-- PREVALECE sobre PILAR 1 (CLAUDE.md regra #10): Left=917, Width=90
        *-- Flutuante/transparente sobre a Page (BackStyle=0)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Grade no legado)
        *-- Original Top=88, Left=26, compensacao PageFrame +29 = 117 (framework_frmcadastro_layout.md)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista
        WITH loc_oGrid
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .ColumnCount        = 2
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        loc_oGrid.Column1.Width = 100
        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
        loc_oGrid.Column2.Width = 780
        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

        BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados): cabecalho + container
    * de botoes de acao + campo Codigo (FASE 5/8 - primeiros 50% dos campos).
    * Campo Descricao sera adicionado na Fase 6; botoes Confirmar/Cancelar na
    * Fase 7/8.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oCab, loc_oBotoesAcao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Faixa do cabecalho identica a da pagina Lista - PRIMEIRO AddObject da pagina
        *-- (CLAUDE.md regra #11 / Erro152 - faixa nas DUAS paginas)
        loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg2.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes de acao (Grupo_Salva no legado)
        *-- Canonico: Top=33 (4+29), Left=842, Width=160 (framework_frmcadastro_layout.md)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackColor   = RGB(255, 255, 255)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salvar) - icone cadastro_salvar_60.jpg (Problema 16: NAO confirmar_60)
        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar
        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Campo Codigo (Say1/getCodigos no legado) - FASE 5/8
        *-- Original: Say1.Top=134/Left=408/Width=42, getCodigos.Top=131/Left=454/Width=31/Height=23
        *-- Compensacao PageFrame +29 (CLAUDE.md regra #11 / Problema #1)
        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .AutoSize  = .F.
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 163
            .Left      = 408
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPg2.txt_4c_Codigos
            .Value         = ""
            .Top           = 160
            .Left          = 454
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "K!"
            .BorderStyle   = 1
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .TabIndex      = 1
            .Visible       = .T.
        ENDWITH

        *-- Campo Descricao (Say2/getDescrs no legado) - FASE 6/8
        *-- Original: Say2.Top=160/Left=395 (sem Width explicito - alinhado a
        *-- direita ate Left=454, mesmo ponto de getCodigos), getDescrs.Top=157/
        *-- Left=454/Width=150/MaxLength=20 (compensacao PageFrame +29)
        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .AutoSize  = .F.
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 189
            .Left      = 395
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPg2.txt_4c_Descrs
            .Value         = ""
            .Top           = 186
            .Left          = 454
            .Width         = 150
            .Height        = 23
            .MaxLength     = 20
            .Format        = "K!"
            .BorderStyle   = 1
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .TabIndex      = 4
            .Visible       = .T.
        ENDWITH

        *-- NOTA: SigCdTpa NAO possui lookups no codigo original (nenhuma ocorrencia
        *-- de fwbuscaext/fwBuscaSel/sigacess/CreateObject em getCodigos/getDescrs -
        *-- ver tasks\task540\SigCdTpa_form_codigo_fonte.txt). getCodigos.When apenas
        *-- controla foco condicional (pcEscolha PROCURAR/INSERIR), sem lookup externo.
        *-- Portanto nenhum BINDEVENT de F4/DblClick eh necessario para este form.

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1 (PUBLIC - CLAUDE.md #3:
    * TesteAutomatico.prg chama este metodo direto de fora da classe)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    *-- RecordSource reseta ControlSource/Headers - redefinir SEMPRE apos (CLAUDE.md/Problema #2/#48)
                    loc_oGrid.RecordSource = ""
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"

                    loc_oGrid.Column1.Width = 100
                    loc_oGrid.Column2.Width = 780

                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    THIS.FormatarGridLista(loc_oGrid)

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTpa.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados) (PUBLIC -
    * CLAUDE.md #3: TesteAutomatico.prg chama este metodo direto de fora da classe)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
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

    *==========================================================================
    * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
    * PUBLIC (sem PROTECTED): BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    * this_cModoAtual DEVE ser setado ANTES de HabilitarCampos (Problema 19)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTpa.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega o registro selecionado (linha do grid) e
    * navega para Page2 em modo somente-leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um Tipo de Acabamento para visualizar!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTpa.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega o registro selecionado (linha do grid) e
    * navega para Page2 em modo edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um Tipo de Acabamento para alterar!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTpa.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Confirma e exclui o registro selecionado (linha do grid)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDescricao

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um Tipo de Acabamento para excluir!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cods)
                loc_cDescricao = ALLTRIM(cursor_4c_Dados.descrs)

                IF MsgConfirma("Confirma exclus" + CHR(227) + "o do Tipo de Acabamento:" + CHR(13) + ;
                        loc_cCodigo + " - " + loc_cDescricao, "Excluir Tipo de Acabamento")
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Tipo de Acabamento exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTpa.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre picker (FormBuscaAuxiliar) para localizar registro
    * na lista. Apos selecao, posiciona o cursor no registro encontrado
    * (PUBLIC: BINDEVENT exige metodo publico - CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdAca", "cursor_4c_BuscaTpa", "cods", "", ;
                "Buscar Tipo de Acabamento")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpa")
                    SELECT cursor_4c_BuscaTpa
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaTpa.cods)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaTpa")
                USE IN cursor_4c_BuscaTpa
            ENDIF

            IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(cods) == loc_cCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTpa.BtnBuscarClick")
            IF USED("cursor_4c_BuscaTpa")
                USE IN cursor_4c_BuscaTpa
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * (PUBLIC: BINDEVENT exige metodo publico - CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do Form para o Business Object
    * (executado antes de Salvar())
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do Business Object para o Form
    * (executado apos CarregarPorCodigo())
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigos.Value = THIS.this_oBusinessObject.this_cCodigo
        loc_oPg2.txt_4c_Descrs.Value  = THIS.this_oBusinessObject.this_cDescricao

        RETURN .T.
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2 (valores default)
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigos.Value = ""
        loc_oPg2.txt_4c_Descrs.Value  = ""
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
    * Codigo (chave primaria): editavel apenas em INCLUIR (espelha
    * comportamento.json getCodigos.When: InList(pcEscolha,'INSERIR','PROCURAR'))
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Codigos.Enabled = par_lHabilitar AND THIS.this_cModoAtual == "INCLUIR"
            loc_oPg2.txt_4c_Descrs.Enabled  = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTpa.HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma e salva o registro atual (INCLUIR/ALTERAR)
    * Salvar() SEM parametro - BusinessBase decide INSERT/UPDATE via
    * this_lNovoRegistro (CLAUDE.md Problema 4). Validacoes (codigo obrigatorio
    * + duplicidade) ficam em TpaBO.ValidarDados(), chamado dentro de Salvar().
    * (PUBLIC: BINDEVENT exige metodo publico - CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                MsgAviso("Nenhuma altera" + CHR(231) + CHR(227) + "o pendente para salvar!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.FormParaBO()

                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Tipo de Acabamento salvo com sucesso!", "Sucesso")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTpa.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista, sem salvar
    * (PUBLIC: BINDEVENT exige metodo publico - CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de acao da Page2
    * conforme o modo atual: INCLUIR/ALTERAR habilita Confirmar,
    * VISUALIZAR desabilita Confirmar (mantendo Cancelar sempre habilitado
    * para permitir voltar a lista)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao, loc_lEditando
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
        loc_lEditando   = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oBotoesAcao, "cmd_4c_Confirmar", 5)
            loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
        ENDIF
        IF PEMSTATUS(loc_oBotoesAcao, "cmd_4c_Cancelar", 5)
            loc_oBotoesAcao.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        IF USED("cursor_4c_BuscaTpa")
            USE IN cursor_4c_BuscaTpa
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
