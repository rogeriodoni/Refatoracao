*==============================================================================
* FormFornecedor.prg - Formulario de Cadastro de Formas de Pagamento
* Migrado de: SigCdFor.SCX (frmcadastro)
* Tabela: SigCdFrm (formas PK C12, infos C1 FK->SigPrInf)
*==============================================================================

DEFINE CLASS FormFornecedor AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Caption EXATO do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Formas de Pagamento"
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

    *=========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *=========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *=========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *=========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("FornecedorBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar FornecedorBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormFornecedor.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormFornecedor:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormFornecedor.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *=========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *=========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *=========================================================================
    * ConfigurarPaginaLista - Configura Page1 com containers principais
    * Fase 3: cnt_4c_Cabecalho (com labels), cnt_4c_Botoes (vazio), cnt_4c_Saida
    * Fase 4 adiciona: grid grd_4c_Lista + botoes CRUD em cnt_4c_Botoes
    *=========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original: Top=1. Com compensacao PageFrame +29: Top=31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
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
            .AutoSize  = .F.
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
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op no legado: Left=344, Top=-1, Width=385, Height=85)
        *-- Canonico framework: Left=542, Top=29 (-1+29), Width=390, Height=85
        *-- Botoes Incluir/Visualizar/Alterar/Excluir/Buscar adicionados na Fase 4
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botoes CRUD dentro de cnt_4c_Botoes (framework: Left=5/80/155/230/305, Top=5)
        *-- FontName="Comic Sans MS" conforme framework_frmcadastro_layout.md
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
        *-- Legado: Grupo_Saida.Left=719, Top=-1. Canonico: Left=917, Top=29, Width=90
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (grade no legado: Top=121, Left=12, 1 coluna Formas w=94)
        *-- Framework canonico: Top=117(88+29), Left=26, Width=890, Height=498
        *-- Problema 36: ColumnCount FORA do WITH; ControlSource definido em CarregarLista()
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 2
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
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
            .Visible            = .T.
            .Column1.Width      = 200
            .Column2.Width      = 400
            .Column1.Header1.Caption = "Forma de Pagamento"
            .Column2.Header1.Caption = "Inf. Complementar"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *=========================================================================
    * ConfigurarPaginaDados - Configura Page2 com containers principais
    * Fase 3: cnt_4c_BotoesAcao (vazio)
    * Fase 4 adiciona: botoes Confirmar/Cancelar em cnt_4c_BotoesAcao
    * Fases 5-6 adicionam: txt_4c_Formas, lbl_4c_FormasPgto,
    *                       txt_4c_Infos, lbl_4c_InfComplementar
    *=========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao (Grupo_Salva no legado: Salva.Left=5, Cancelar.Left=81)
        *-- Canonico framework: Top=4+29=33, Left=842, Width=160, Height=85
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salvar) - Left=5 conforme legado Grupo_Salva
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar - Left=80 conforme legado Grupo_Salva
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label "Forma de Pagamento : " (Say8 original: Top=173, Left=196; +29 compensacao)
        *-- ForeColor=RGB(90,90,90) copiado do original
        loc_oPagina.AddObject("lbl_4c_FormasPgto", "Label")
        WITH loc_oPagina.lbl_4c_FormasPgto
            .Caption   = "Forma de Pagamento : "
            .Top       = 202
            .Left      = 196
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Forma de Pagamento - PK C12 (Get_formas original: Top=169, Left=311, Width=94; +29)
        *-- When do legado: retorna .F. se nao em INSERIR/PROCURAR -> gerenciado por HabilitarCampos
        loc_oPagina.AddObject("txt_4c_Formas", "TextBox")
        WITH loc_oPagina.txt_4c_Formas
            .Value         = ""
            .Top           = 198
            .Left          = 311
            .Width         = 94
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .MaxLength     = 12
            .TabIndex      = 1
            .Visible       = .T.
        ENDWITH

        *-- Label "Inf. Complementar : " (Say7 original: Top=197, Left=208; +29 compensacao)
        *-- ForeColor=RGB(90,90,90) copiado do original
        loc_oPagina.AddObject("lbl_4c_InfComplementar", "Label")
        WITH loc_oPagina.lbl_4c_InfComplementar
            .Caption   = "Inf. Complementar : "
            .Top       = 226
            .Left      = 208
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Inf. Complementar (Get_INFO original: Top=194, Left=311, Width=24; +29)
        *-- C(1) FK SigPrInf.Infos; Valid legado -> LostFocus + F4 no novo sistema
        loc_oPagina.AddObject("txt_4c_Infos", "TextBox")
        WITH loc_oPagina.txt_4c_Infos
            .Value       = ""
            .Top         = 223
            .Left        = 311
            .Width       = 24
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
            .MaxLength   = 1
            .ToolTipText = "<C>Cheque <T>Cart" + CHR(227) + "o Cr" + CHR(233) + "dito <N>Carne <O>Outras  <R>Conta Corrente"
            .TabIndex    = 2
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Infos, "KeyPress", THIS, "txt_4c_InfosLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Infos, "KeyPress",  THIS, "txt_4c_InfosKeyPress")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *=========================================================================
    * CarregarLista - Carrega dados no grid da Page1 via FornecedorBO.Buscar
    * Grid (grd_4c_Lista) adicionado na Fase 4; usa PEMSTATUS para compatibilidade
    * Colunas: formas (Forma de Pagamento), descrs (Inf. Complementar via JOIN)
    *=========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oPagina, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oPagina = THIS.pgf_4c_Paginas.Page1

                IF PEMSTATUS(loc_oPagina, "grd_4c_Lista", 5)
                    loc_oGrid = loc_oPagina.grd_4c_Lista

                    *-- Problema 36: RecordSource e ColumnCount FORA do WITH
                    *-- Problema 48: ControlSource APOS RecordSource
                    loc_oGrid.ColumnCount  = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.formas"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"

                    loc_oGrid.Column1.Width = 200
                    loc_oGrid.Column2.Width = 400

                    *-- Problema 2/32: Headers APOS RecordSource (RecordSource reseta captions)
                    loc_oGrid.Column1.Header1.Caption = "Forma de Pagamento"
                    loc_oGrid.Column2.Header1.Caption = "Inf. Complementar"

                    THIS.FormatarGridLista(loc_oGrid)
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormFornecedor.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *=========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista automaticamente
    *=========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
                "FormFornecedor.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *=========================================================================
    * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
    *=========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "FormFornecedor.FormatarGridLista")
        ENDTRY
    ENDPROC

    *=========================================================================
    * BtnIncluirClick - Abre Page2 para incluir nova forma de pagamento
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *=========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *=========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *=========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cFormas
        loc_cFormas = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cFormas = ALLTRIM(cursor_4c_Dados.formas)
        ENDIF

        IF EMPTY(loc_cFormas)
            MsgAviso("Selecione uma forma de pagamento para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFormas)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *=========================================================================
    * BtnAlterarClick - Abre Page2 para alterar forma de pagamento selecionada
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *=========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cFormas
        loc_cFormas = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cFormas = ALLTRIM(cursor_4c_Dados.formas)
        ENDIF

        IF EMPTY(loc_cFormas)
            MsgAviso("Selecione uma forma de pagamento para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFormas)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *=========================================================================
    * BtnExcluirClick - Exclui forma de pagamento selecionada com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *=========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cFormas
        loc_cFormas = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cFormas = ALLTRIM(cursor_4c_Dados.formas)
        ENDIF

        IF EMPTY(loc_cFormas)
            MsgAviso("Selecione uma forma de pagamento para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFormas)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da forma [" + loc_cFormas + "]?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *=========================================================================
    * BtnBuscarClick - Abre picker para localizar forma de pagamento na lista
    * Apos selecao, posiciona cursor no registro encontrado
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *=========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cFormas
        loc_cFormas = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdFrm", "cursor_4c_BuscaFor", "formas", "", ;
                "Buscar Forma de Pagamento")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("formas", "", "Forma de Pagamento")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFor")
                    SELECT cursor_4c_BuscaFor
                    loc_cFormas = ALLTRIM(cursor_4c_BuscaFor.formas)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaFor")
                USE IN cursor_4c_BuscaFor
            ENDIF

            IF !EMPTY(loc_cFormas) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(formas) == loc_cFormas
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
                "FormFornecedor.BtnBuscarClick")
            IF USED("cursor_4c_BuscaFor")
                USE IN cursor_4c_BuscaFor
            ENDIF
        ENDTRY
    ENDPROC

    *=========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *=========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *=========================================================================
    * BtnSalvarClick - Confirma e salva o registro atual
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *=========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
        ELSE
            *-- Replica legado: focar em Formas apos falha de validacao (vazio ou duplicado)
            IF PEMSTATUS(loc_oPagina, "txt_4c_Formas", 5) AND loc_oPagina.txt_4c_Formas.Enabled
                loc_oPagina.txt_4c_Formas.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *=========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *=========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *=========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *=========================================================================
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

    *=========================================================================
    * FormParaBO - Transfere dados do Form para o BO antes de salvar
    * Campos: formas (PK C12), infos (Inf. Complementar C1)
    * PEMSTATUS: campos adicionados na Fase 5; guards garantem compatibilidade
    *=========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Formas", 5)
            THIS.this_oBusinessObject.this_cFormas = ALLTRIM(loc_oPagina.txt_4c_Formas.Value)
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Infos", 5)
            THIS.this_oBusinessObject.this_cInfos  = ALLTRIM(loc_oPagina.txt_4c_Infos.Value)
        ENDIF
    ENDPROC

    *=========================================================================
    * BOParaForm - Transfere dados do BO para o Form apos carregar registro
    * Campos: formas (PK C12), infos (Inf. Complementar C1)
    *=========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Formas", 5)
            loc_oPagina.txt_4c_Formas.Value = THIS.this_oBusinessObject.this_cFormas
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Infos", 5)
            loc_oPagina.txt_4c_Infos.Value  = THIS.this_oBusinessObject.this_cInfos
        ENDIF
    ENDPROC

    *=========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
    * formas (PK): somente leitura no Alterar/Visualizar (legado: When do Get_formas
    *   retorna .F. exceto em INSERIR/PROCURAR)
    * infos: editavel em INCLUIR e ALTERAR
    *=========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lFormasReadOnly
        loc_oPagina         = THIS.pgf_4c_Paginas.Page2
        loc_lFormasReadOnly = (THIS.this_cModoAtual != "INCLUIR")

        IF PEMSTATUS(loc_oPagina, "txt_4c_Formas", 5)
            loc_oPagina.txt_4c_Formas.Enabled = par_lHabilitar AND !loc_lFormasReadOnly
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Infos", 5)
            loc_oPagina.txt_4c_Infos.Enabled  = par_lHabilitar
        ENDIF
    ENDPROC

    *=========================================================================
    * LimparCampos - Limpa todos os campos da Page2 para novo registro
    *=========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Formas", 5)
            loc_oPagina.txt_4c_Formas.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_Infos", 5)
            loc_oPagina.txt_4c_Infos.Value  = ""
        ENDIF
    ENDPROC

    *=========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
    * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
    *=========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditando
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
            ENDIF
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *=========================================================================
    * txt_4c_InfosLostFocus - Handler LostFocus de txt_4c_Infos
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    * Replica PROCEDURE Valid do Get_INFO legado: valida SigPrInf ao sair do campo
    *=========================================================================
    PROCEDURE txt_4c_InfosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = ""

        IF PEMSTATUS(loc_oPagina, "txt_4c_Infos", 5)
            loc_cValor = ALLTRIM(loc_oPagina.txt_4c_Infos.Value)
        ENDIF

        IF !EMPTY(loc_cValor)
            THIS.AbrirLookupInfos()
        ENDIF
    ENDPROC

    *=========================================================================
    * txt_4c_InfosKeyPress - Handler KeyPress de txt_4c_Infos (F4=28 abre lookup)
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *=========================================================================
    PROCEDURE txt_4c_InfosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28    && F4
            THIS.AbrirLookupInfos()
        ENDIF
    ENDPROC

    *=========================================================================
    * AbrirLookupInfos - Lookup para campo Infos (Inf. Complementar) em SigPrInf
    * Replica logica do Get_INFO.Valid legado (fwBuscaExt para SigPrInf)
    * SigPrInf colunas: Infos (C1 PK codigo), descrs (descricao)
    *=========================================================================
    PROTECTED PROCEDURE AbrirLookupInfos()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_Infos", 5)
            RETURN
        ENDIF

        IF !loc_oPagina.txt_4c_Infos.Enabled
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(loc_oPagina.txt_4c_Infos.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            *-- FormBuscaAuxiliar: busca match exato em SigPrInf.Infos
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrInf", "cursor_4c_BuscaInf", "Infos", loc_cValor, ;
                "Inf. Complementares")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Se nao achou match exato: mostrar picker (replica legado !plAchouRegistro -> Show())
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Infos",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                *-- Achou exato OU usuario selecionou no picker: usar valor do cursor
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaInf")
                    SELECT cursor_4c_BuscaInf
                    loc_oPagina.txt_4c_Infos.Value = ALLTRIM(cursor_4c_BuscaInf.Infos)
                ELSE
                    *-- ESC no picker ou nao encontrou: limpar campo (replica legado This.Value='')
                    loc_oPagina.txt_4c_Infos.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaInf")
                USE IN cursor_4c_BuscaInf
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir lookup Inf. Complementar:" + CHR(13) + ;
                loException.Message, "FormFornecedor.AbrirLookupInfos")
            IF USED("cursor_4c_BuscaInf")
                USE IN cursor_4c_BuscaInf
            ENDIF
        ENDTRY
    ENDPROC

    *=========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *=========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_BuscaFor")
            USE IN cursor_4c_BuscaFor
        ENDIF

        IF USED("cursor_4c_BuscaInf")
            USE IN cursor_4c_BuscaInf
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
