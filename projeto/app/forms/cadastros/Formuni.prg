*==============================================================================
* Formuni.prg - Formulario de Cadastro de Unidades
* Migrado de: SIGCDUNI.SCX (frmcadastro)
*
* FASE 3/8 - Form: Estrutura Base
*   Inclui: DEFINE CLASS, Init(), InicializarForm(), ConfigurarPageFrame()
*   (PageFrame com Page1/Page2), containers principais vazios
*   (cnt_4c_Cabecalho, cnt_4c_Botoes, cnt_4c_BotoesAcao) e Destroy().
*
* FASE 4/8 - Form: Grid e Botoes CRUD (Page1)
*   Adicionados: 5 botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar)
*   em cnt_4c_Botoes, container cnt_4c_Saida + cmd_4c_Encerrar (padrao
*   canonico CLAUDE.md #10), grd_4c_Lista (colunas cunis/dunis),
*   CarregarLista(), FormatarGridLista() e AlternarPagina().
*
* FASE 5/8 - Form: Campos Principais (Page2 - Parte 1)
*   Adicionados primeiros 50% dos campos de Page2 (Dados): Unidade,
*   Descricao, Etiqueta Individual, Valor na Etiqueta, Pergunta Qtd
*   Etiq, Opc_Distrib (Movimentacao/Preco Atual), Preenche Peso,
*   Qtde Desmembrada, Controle de Estoque. Compensacao +29 no Top
*   (PageFrame.Top=-29). Restante dos campos e eventos Btn*Click
*   sao adicionados nas fases seguintes (6-8).
*
* FASE 6/8 - Form: Campos Restantes e Lookups (Page2 - Parte 2)
*   Adicionados os ultimos 50% dos campos de Page2 (Dados): Fator de
*   Conversao p/ GR, Fator Divisor p/ CT, % Custo/Venda Qtde, Peso
*   Igual Quantidade, Medicao de Tempo, Etiqueta Duplicada (checkbox),
*   Nao Recalcula Qtde (checkbox), Bloqueia Qtde Fracionada, Nao
*   Imprime Etiqueta no Cadastro do Produto (checkbox). Botoes
*   Confirmar/Cancelar adicionados em cnt_4c_BotoesAcao (BINDEVENT
*   para BtnSalvarClick/BtnCancelarClick, implementados em fase
*   posterior). SIGCDUNI nao possui lookups (fwbuscaext/sigacess) no
*   codigo fonte original - comportamento.json confirma ausencia.
*
* FASE 7/8 - Form: Eventos Principais
*   Adicionados BOParaForm(), LimparCampos(), HabilitarCampos(),
*   AjustarBotoesPorModo() (foco por modo + chkEtiqDups.Visible
*   restrito a usuario 4CONTROL, transcrito do legado) e os 4 eventos
*   principais: BtnIncluirClick(), BtnVisualizarClick(),
*   BtnAlterarClick(), BtnExcluirClick(). BtnSalvarClick(),
*   BtnCancelarClick(), BtnBuscarClick() e BtnEncerrarClick() (ja
*   vinculados via BINDEVENT nas fases 4/6) sao implementados na
*   fase seguinte (8/8).
*
* FASE 8/8 - Form: Eventos Auxiliares e Consolidacao Final
*   Adicionados FormParaBO() (inverso de BOParaForm, com TODOS os
*   campos de Page2) e os 4 eventos finais: BtnBuscarClick() (localiza
*   na lista por codigo/descricao, transcrito do metodo lcBusca do
*   legado - LocateCursor por cunis/dunis), BtnEncerrarClick()
*   (THIS.Release()), BtnSalvarClick() (FormParaBO + Salvar(), sem
*   ELSE incondicional - CLAUDE.md regra #20) e BtnCancelarClick()
*   (AlternarPagina(1)). Formulario e BO completos e funcionais.
*==============================================================================

DEFINE CLASS Formuni AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Unidades"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual       = "LISTA"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("uniBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar uniBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formuni.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formuni:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formuni.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
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

    *===========================================================================
    * ConfigurarPaginaLista - Configura Page1 (Lista): cabecalho, 5 botoes CRUD
    * (Incluir/Visualizar/Alterar/Excluir/Buscar), cnt_4c_Saida+cmd_4c_Encerrar
    * e grd_4c_Lista (colunas cunis/dunis)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
        *-- Original: Top=2. Com compensacao +29: Top=31
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

        *-- Container Botoes CRUD (Grupo_op no legado: Left=543, Top=-1, Width=389, Height=85)
        *-- Canonico: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
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

        *-- Botao Incluir (legado Grupo_op.Inserir: Left=5,Top=5)
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

        *-- Botao Visualizar (legado Grupo_op.Consultar: Left=80,Top=5)
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

        *-- Botao Alterar (legado Grupo_op.Alterar: Left=155,Top=5)
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

        *-- Botao Excluir (legado Grupo_op.Excluir: Left=230,Top=5)
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

        *-- Botao Buscar (legado Grupo_op.Procurar: Left=305,Top=5)
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

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
        *-- Legado: Grupo_Saida.Left=918, Top=-1. Canonico: Left=917, Top=29, Width=90
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

        *-- Grid de listagem de unidades
        *-- Original: Grade.Top=121, Left=12, Width=940, Height=470
        *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
        *-- Width=880: nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 2
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
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
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
    * Fase 3: apenas cabecalho + container de botoes de acao VAZIO.
    * Campos (TextBox/Labels/Lookups) entram nas Fases 5-6.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - PRIMEIRO AddObject da pagina
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
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
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
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
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container BotoesAcao (Grupo_Salva legado: Left=819, Top=9, Width=160, Height=85)
        *-- Com compensacao PageFrame +29: Top=33 (4+29), Left=842
        *-- VAZIO nesta fase - botoes (Confirmar/Cancelar) entram em fase posterior
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

        *-- Botao Confirmar (legado Grupo_Salva.Salva: Left=5,Top=5)
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

        *-- Botao Cancelar (legado Grupo_Salva.Cancela: Left=80,Top=5)
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

        *-- FASE 5/8: Campos principais - PARTE 1 (primeiros 50%)
        *-- Compensacao PageFrame.Top=-29: Top_migrado = Top_original + 29

        *-- Say1 "Unidade :" (original Top=99,Left=401)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Unidade :"
            .Top       = 128
            .Left      = 401
            .Width     = 50
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_unid -> txt_4c_Unid (cunis char(3), PK) - original Top=96,Left=455,Width=31
        loc_oPagina.AddObject("txt_4c_Unid", "TextBox")
        WITH loc_oPagina.txt_4c_Unid
            .Top           = 125
            .Left          = 455
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say2 "Descricao :" (original Top=124,Left=394)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 153
            .Left      = 394
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_desc -> txt_4c_Desc (dunis char(20)) - original Top=121,Left=455,Width=150
        loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPagina.txt_4c_Desc
            .Top           = 150
            .Left          = 455
            .Width         = 150
            .Height        = 23
            .MaxLength     = 20
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say3 "Etiqueta Individual :" (original Top=149,Left=351)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Etiqueta Individual :"
            .Top       = 178
            .Left      = 351
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_etiq -> txt_4c_Etiq (etiqs char(1) S/N) - original Top=146,Left=455,Width=20
        *-- Format="M" + InputMask="N,S" transcritos literalmente do legado (CLAUDE.md #24)
        loc_oPagina.AddObject("txt_4c_Etiq", "TextBox")
        WITH loc_oPagina.txt_4c_Etiq
            .Top           = 175
            .Left          = 455
            .Width         = 20
            .Height        = 23
            .MaxLength     = 1
            .Format        = "M"
            .InputMask     = "N,S"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say4 "[S/N]" (original Top=149,Left=479)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "[S/N]"
            .Top       = 178
            .Left      = 479
            .Width     = 35
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say5 "Pergunta Qtd Etiq. :" (original Top=174,Left=350)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Pergunta Qtd Etiq. :"
            .Top       = 203
            .Left      = 350
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_qtd -> txt_4c_Qtd (pqtds char(1) S/N) - original Top=171,Left=455,Width=20
        loc_oPagina.AddObject("txt_4c_Qtd", "TextBox")
        WITH loc_oPagina.txt_4c_Qtd
            .Top           = 200
            .Left          = 455
            .Width         = 20
            .Height        = 23
            .MaxLength     = 1
            .Format        = "M"
            .InputMask     = "N,S"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say6 "[S/N]" (original Top=174,Left=479)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "[S/N]"
            .Top       = 203
            .Left      = 479
            .Width     = 35
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say19 "Valor na Etiqueta :" (original Top=418,Left=358,Width=91,Height=15)
        loc_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPagina.lbl_4c_Label19
            .Caption   = "Valor na Etiqueta :"
            .Top       = 447
            .Left      = 358
            .Width     = 91
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Opc_Distrib -> obj_4c_Opc_Distrib (distribs numeric(1,0): 1=Movimentacao 2=Preco Atual)
        *-- original Top=413,Left=451,Width=189,Height=25,ButtonCount=2
        loc_oPagina.AddObject("obj_4c_Opc_Distrib", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_Distrib
            .ButtonCount = 2
            .Top         = 442
            .Left        = 451
            .Width       = 189
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Distrib.Buttons(1)
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Left      = 5
            .Top       = 5
            .Width     = 87
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.obj_4c_Opc_Distrib.Buttons(2)
            .Caption   = "Pre" + CHR(231) + "o Atual"
            .Left      = 111
            .Top       = 5
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Say7 "Preenche Peso :" (original Top=199,Left=369)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Preenche Peso :"
            .Top       = 228
            .Left      = 369
            .Width     = 90
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say8 "[S/N]" (original Top=199,Left=479)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "[S/N]"
            .Top       = 228
            .Left      = 479
            .Width     = 35
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_peso -> txt_4c_Peso (ppesos char(1) S/N) - original Top=196,Left=455,Width=20
        loc_oPagina.AddObject("txt_4c_Peso", "TextBox")
        WITH loc_oPagina.txt_4c_Peso
            .Top           = 225
            .Left          = 455
            .Width         = 20
            .Height        = 23
            .MaxLength     = 1
            .Format        = "M"
            .InputMask     = "N,S"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say9 "Qtde. Desmembrada :" (original Top=224,Left=341)
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Qtde. Desmembrada :"
            .Top       = 253
            .Left      = 341
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say10 "[S/N]" (original Top=224,Left=479)
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "[S/N]"
            .Top       = 253
            .Left      = 479
            .Width     = 35
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_Desmemb -> txt_4c_Desmemb (desmembs char(1) S/N) - original Top=221,Left=455,Width=20
        loc_oPagina.AddObject("txt_4c_Desmemb", "TextBox")
        WITH loc_oPagina.txt_4c_Desmemb
            .Top           = 250
            .Left          = 455
            .Width         = 20
            .Height        = 23
            .MaxLength     = 1
            .Format        = "M"
            .InputMask     = "N,S"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say12 "Controle de Estoque :" (original Top=247,Left=342)
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Controle de Estoque :"
            .Top       = 276
            .Left      = 342
            .Width     = 112
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_CEstos -> txt_4c_CEstos (cestos char(1): 1/2/3) - original Top=245,Left=455,Width=20
        *-- InputMask="1,2,3" transcrito literalmente do legado (CLAUDE.md #24)
        loc_oPagina.AddObject("txt_4c_CEstos", "TextBox")
        WITH loc_oPagina.txt_4c_CEstos
            .Top           = 274
            .Left          = 455
            .Width         = 20
            .Height        = 23
            .MaxLength     = 1
            .Format        = "M"
            .InputMask     = "1,2,3"
            .ToolTipText   = "<1> por Quantidade <2> por Quantidade x Peso"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- FASE 6/8: Campos principais - PARTE 2 (ultimos 50%)

        *-- Say11 "[1] Qtde / [2] Qtde x Peso / [3] Qtde e peso" (original Top=248,Left=479)
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "[1] Qtde / [2] Qtde x Peso / [3] Qtde e peso"
            .Top       = 277
            .Left      = 479
            .Width     = 290
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say13 "Fator de Conversao para GR :" (original Top=272,Left=302,Width=147,Height=15)
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Fator de Convers" + CHR(227) + "o para GR :"
            .Top       = 301
            .Left      = 302
            .Width     = 147
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_Fator -> txt_4c_Fator (fators numeric(7,4)) - original Top=270,Left=455,Width=72,Height=23
        loc_oPagina.AddObject("txt_4c_Fator", "TextBox")
        WITH loc_oPagina.txt_4c_Fator
            .Value         = 0
            .Top           = 299
            .Left          = 455
            .Width         = 72
            .Height        = 23
            .Format        = "K"
            .InputMask     = "999.9999"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say14 "Fator Divisor p/ CT :" (original Top=296,Left=350,Width=99,Height=15)
        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = "Fator Divisor p/ CT :"
            .Top       = 325
            .Left      = 350
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_Fatd -> txt_4c_Fatd (fatdivs numeric(5,2)) - original Top=294,Left=455,Width=72,Height=23
        loc_oPagina.AddObject("txt_4c_Fatd", "TextBox")
        WITH loc_oPagina.txt_4c_Fatd
            .Value         = 0
            .Top           = 323
            .Left          = 455
            .Width         = 72
            .Height        = 23
            .Format        = "K"
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say15 "% Custo/Venda Qtde :" (original Top=320,Left=337,Width=112,Height=15)
        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Caption   = "% Custo/Venda Qtde :"
            .Top       = 349
            .Left      = 337
            .Width     = 112
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_PCV -> txt_4c_PCV (pcustvens numeric(5,2)) - original Top=318,Left=455,Width=72,Height=23
        loc_oPagina.AddObject("txt_4c_PCV", "TextBox")
        WITH loc_oPagina.txt_4c_PCV
            .Value         = 0
            .Top           = 347
            .Left          = 455
            .Width         = 72
            .Height        = 23
            .Format        = "K"
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Say16 "Peso Igual Quantidade :" (original Top=345,Left=331)
        loc_oPagina.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPagina.lbl_4c_Label16
            .Caption   = "Peso Igual Quantidade :"
            .Top       = 374
            .Left      = 331
            .Width     = 125
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say17 "[S/N]" (original Top=345,Left=479)
        loc_oPagina.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPagina.lbl_4c_Label17
            .Caption   = "[S/N]"
            .Top       = 374
            .Left      = 479
            .Width     = 35
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Get_PesQt -> txt_4c_PesQt (qtequalps char(1) S/N) - original Top=342,Left=455,Width=20
        loc_oPagina.AddObject("txt_4c_PesQt", "TextBox")
        WITH loc_oPagina.txt_4c_PesQt
            .Top           = 371
            .Left          = 455
            .Width         = 20
            .Height        = 23
            .MaxLength     = 1
            .Format        = "M"
            .InputMask     = "N,S"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say20 "Medicao de Tempo :" (original Top=369,Left=351)
        loc_oPagina.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPagina.lbl_4c_Label20
            .Caption   = "Medi" + CHR(231) + CHR(227) + "o de Tempo :"
            .Top       = 398
            .Left      = 351
            .Width     = 110
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say21 "[S/N]" (original Top=369,Left=479)
        loc_oPagina.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oPagina.lbl_4c_Label21
            .Caption   = "[S/N]"
            .Top       = 398
            .Left      = 479
            .Width     = 35
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- fwget1 -> txt_4c_Fwget1 (medtmps char(1) S/N) - original Top=366,Left=455,Width=20
        loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget1
            .Top           = 395
            .Left          = 455
            .Width         = 20
            .Height        = 23
            .MaxLength     = 1
            .Format        = "M"
            .InputMask     = "N,S"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Say18 "Bloqueia Qtde. Fracionada :" (original Top=393,Left=313)
        loc_oPagina.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPagina.lbl_4c_Label18
            .Caption   = "Bloqueia Qtde. Fracionada :"
            .Top       = 422
            .Left      = 313
            .Width     = 140
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say22 "[S/N]" (original Top=393,Left=479)
        loc_oPagina.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oPagina.lbl_4c_Label22
            .Caption   = "[S/N]"
            .Top       = 422
            .Left      = 479
            .Width     = 35
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- get_BlqQtdFrac -> txt_4c__BlqQtdFrac (blqqtdfrac char(1) S/N) - original Top=390,Left=455,Width=20
        loc_oPagina.AddObject("txt_4c__BlqQtdFrac", "TextBox")
        WITH loc_oPagina.txt_4c__BlqQtdFrac
            .Top           = 419
            .Left          = 455
            .Width         = 20
            .Height        = 23
            .MaxLength     = 1
            .Format        = "M"
            .InputMask     = "N,S"
            .FontName      = "Tahoma"
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- chkEtiqDups -> chk_4c_ChkEtiqDups (etiqdups numeric(1,0)) - original Top=150,Left=517
        loc_oPagina.AddObject("chk_4c_ChkEtiqDups", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkEtiqDups
            .Caption   = "Permite Imprimir Por Refer" + CHR(234) + "ncia"
            .Top       = 179
            .Left      = 517
            .Width     = 220
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Fwcheckbox1 -> chk_4c_Fwcheckbox1 (recqtd numeric(1,0)) - original Top=439,Left=458
        loc_oPagina.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox1
            .Caption   = "N" + CHR(227) + "o recalcula Qtde"
            .Top       = 468
            .Left      = 458
            .Width     = 160
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Fwcheckbox2 -> chk_4c_Fwcheckbox2 (etiqcdpro numeric(1,0)) - original Top=455,Left=458
        loc_oPagina.AddObject("chk_4c_Fwcheckbox2", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox2
            .Caption   = "N" + CHR(227) + "o Imprime Etiqueta no Cadastro do Produto"
            .Top       = 484
            .Left      = 458
            .Width     = 280
            .Height    = 17
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
    * OBRIGATORIO: RecordSource/ColumnCount FORA do WITH (Problema 36)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- PROBLEMA 48: RecordSource ANTES de ControlSource
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cunis"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dunis"

                loc_oGrid.Column1.Width = 80
                loc_oGrid.Column2.Width = 337

                *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO)
                loc_oGrid.Column1.Header1.Caption = "Unidade"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                THIS.FormatarGridLista(loc_oGrid)

                GO TOP IN cursor_4c_Dados
                loc_oGrid.Refresh()

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formuni.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "Formuni.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista
    *===========================================================================
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
                "Formuni.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do BusinessObject para os campos de Page2
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPg2.txt_4c_Unid.Value        = .this_cCodigo
            loc_oPg2.txt_4c_Desc.Value        = .this_cDescricao
            loc_oPg2.txt_4c_Etiq.Value        = .this_cEtiquetaIndividual
            loc_oPg2.txt_4c_Qtd.Value         = .this_cPerguntaQtdEtiq
            loc_oPg2.obj_4c_Opc_Distrib.Value = IIF(.this_nDistribuicao = 2, 2, 1)
            loc_oPg2.txt_4c_Peso.Value        = .this_cPreenchePeso
            loc_oPg2.txt_4c_Desmemb.Value     = .this_cQtdDesmembrada
            loc_oPg2.txt_4c_CEstos.Value      = .this_cControleEstoque
            loc_oPg2.txt_4c_Fator.Value       = .this_nFatorConversaoGR
            loc_oPg2.txt_4c_Fatd.Value        = .this_nFatorDivisorCT
            loc_oPg2.txt_4c_PCV.Value         = .this_nPercCustoVendaQtde
            loc_oPg2.txt_4c_PesQt.Value       = .this_cPesoIgualQtde
            loc_oPg2.txt_4c_Fwget1.Value      = .this_cMedicaoTempo
            loc_oPg2.txt_4c__BlqQtdFrac.Value = .this_cBloqueiaQtdFracionada
            loc_oPg2.chk_4c_ChkEtiqDups.Value = .this_nEtiquetaDuplicada
            loc_oPg2.chk_4c_Fwcheckbox1.Value = .this_nNaoRecalculaQtde
            loc_oPg2.chk_4c_Fwcheckbox2.Value = .this_nNaoImprimeEtiquetaCadProduto
        ENDWITH
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados dos campos de Page2 para o BusinessObject
    * (inverso de BOParaForm) - chamado antes de Salvar()
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_cCodigo                       = ALLTRIM(loc_oPg2.txt_4c_Unid.Value)
            .this_cDescricao                    = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)
            .this_cEtiquetaIndividual            = loc_oPg2.txt_4c_Etiq.Value
            .this_cPerguntaQtdEtiq               = loc_oPg2.txt_4c_Qtd.Value
            .this_nDistribuicao                  = loc_oPg2.obj_4c_Opc_Distrib.Value
            .this_cPreenchePeso                  = loc_oPg2.txt_4c_Peso.Value
            .this_cQtdDesmembrada                = loc_oPg2.txt_4c_Desmemb.Value
            .this_cControleEstoque               = loc_oPg2.txt_4c_CEstos.Value
            .this_nFatorConversaoGR              = loc_oPg2.txt_4c_Fator.Value
            .this_nFatorDivisorCT                = loc_oPg2.txt_4c_Fatd.Value
            .this_nPercCustoVendaQtde            = loc_oPg2.txt_4c_PCV.Value
            .this_cPesoIgualQtde                 = loc_oPg2.txt_4c_PesQt.Value
            .this_cMedicaoTempo                  = loc_oPg2.txt_4c_Fwget1.Value
            .this_nEtiquetaDuplicada             = loc_oPg2.chk_4c_ChkEtiqDups.Value
            .this_nNaoRecalculaQtde              = loc_oPg2.chk_4c_Fwcheckbox1.Value
            .this_cBloqueiaQtdFracionada         = loc_oPg2.txt_4c__BlqQtdFrac.Value
            .this_nNaoImprimeEtiquetaCadProduto  = loc_oPg2.chk_4c_Fwcheckbox2.Value
        ENDWITH
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos de Page2 (usado antes de INCLUIR)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Unid.Value        = ""
        loc_oPg2.txt_4c_Desc.Value        = ""
        loc_oPg2.txt_4c_Etiq.Value        = ""
        loc_oPg2.txt_4c_Qtd.Value         = ""
        loc_oPg2.obj_4c_Opc_Distrib.Value = 1
        loc_oPg2.txt_4c_Peso.Value        = ""
        loc_oPg2.txt_4c_Desmemb.Value     = ""
        loc_oPg2.txt_4c_CEstos.Value      = ""
        loc_oPg2.txt_4c_Fator.Value       = 0
        loc_oPg2.txt_4c_Fatd.Value        = 0
        loc_oPg2.txt_4c_PCV.Value         = 0
        loc_oPg2.txt_4c_PesQt.Value       = ""
        loc_oPg2.txt_4c_Fwget1.Value      = ""
        loc_oPg2.txt_4c__BlqQtdFrac.Value = ""
        loc_oPg2.chk_4c_ChkEtiqDups.Value = 0
        loc_oPg2.chk_4c_Fwcheckbox1.Value = 0
        loc_oPg2.chk_4c_Fwcheckbox2.Value = 0
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos de Page2 conforme o modo
    * Unidade (PK) so editavel em modo INCLUIR (legado: Get_unid.When retorna
    * InList(pcEscolha,'INSERIR','PROCURAR'))
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Unid.Enabled        = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        loc_oPg2.txt_4c_Desc.Enabled        = par_lHabilitar
        loc_oPg2.txt_4c_Etiq.Enabled        = par_lHabilitar
        loc_oPg2.txt_4c_Qtd.Enabled         = par_lHabilitar
        loc_oPg2.obj_4c_Opc_Distrib.Enabled = par_lHabilitar
        loc_oPg2.txt_4c_Peso.Enabled        = par_lHabilitar
        loc_oPg2.txt_4c_Desmemb.Enabled     = par_lHabilitar
        loc_oPg2.txt_4c_CEstos.Enabled      = par_lHabilitar
        loc_oPg2.txt_4c_Fator.Enabled       = par_lHabilitar
        loc_oPg2.txt_4c_Fatd.Enabled        = par_lHabilitar
        loc_oPg2.txt_4c_PCV.Enabled         = par_lHabilitar
        loc_oPg2.txt_4c_PesQt.Enabled       = par_lHabilitar
        loc_oPg2.txt_4c_Fwget1.Enabled      = par_lHabilitar
        loc_oPg2.txt_4c__BlqQtdFrac.Enabled = par_lHabilitar
        loc_oPg2.chk_4c_ChkEtiqDups.Enabled = par_lHabilitar
        loc_oPg2.chk_4c_Fwcheckbox1.Enabled = par_lHabilitar
        loc_oPg2.chk_4c_Fwcheckbox2.Enabled = par_lHabilitar
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta foco/Confirmar/visibilidade conforme o modo
    * Transcrito do legado (Grupo_op.Click, apos DoDefault): INSERIR/PROCURAR
    * foca Unidade, ALTERAR foca Descricao, demais casos focam Confirmar/Cancelar.
    * chkEtiqDups.Visible = (Usuar = "4CONTROL") transcrito literalmente.
    * PUBLIC: chamado diretamente por TesteAutomatico.prg (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.chk_4c_ChkEtiqDups.Visible = (UPPER(ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))) = "4CONTROL")

            DO CASE
                CASE THIS.this_cModoAtual = "INCLUIR"
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                    IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                        loc_oPg2.txt_4c_Unid.SetFocus()
                    ENDIF
                CASE THIS.this_cModoAtual = "ALTERAR"
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                    IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                        loc_oPg2.txt_4c_Desc.SetFocus()
                    ENDIF
                OTHERWISE
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                    IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
                    ENDIF
            ENDCASE
        CATCH TO loException
            MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
                "Formuni.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara Page2 para inclusao de novo registro
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3/#8 - Problema 17)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega a Unidade selecionada em modo somente leitura
    * Tambem vinculado ao DblClick do grd_4c_Lista (ConfigurarPaginaLista)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione uma Unidade na lista.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cunis)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione uma Unidade na lista.", "Visualizar")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            RETURN
        ENDIF

        THIS.BOParaForm()
        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.HabilitarCampos(.F.)
        THIS.AlternarPagina(2)
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega a Unidade selecionada para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione uma Unidade na lista.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cunis)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione uma Unidade na lista.", "Alterar")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            RETURN
        ENDIF

        THIS.this_oBusinessObject.EditarRegistro()
        THIS.BOParaForm()
        THIS.this_cModoAtual = "ALTERAR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui a Unidade selecionada na lista (com confirmacao)
    * BusinessBase.Excluir() ja exibe a mensagem de erro caso falhe - o form
    * NAO precisa de ELSE (CLAUDE.md regra #20)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione uma Unidade na lista.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cunis)

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione uma Unidade na lista.", "Excluir")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da Unidade '" + loc_cCodigo + "'?", "Excluir")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Excluir()
            MsgInfo("Unidade exclu" + CHR(237) + "da com sucesso!", "Excluir")
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Localiza uma Unidade na lista pelo Codigo ou Descricao
    * Transcrito do legado (metodo lcBusca): busca primeiro por cunis (codigo);
    * se nao encontrar, busca por dunis (descricao) - LocateCursor('crSigCdUni', ...)
    * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3/#8)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBusca, loc_lAchou
        loc_lAchou = .F.

        IF !USED("cursor_4c_Dados")
            RETURN loc_lAchou
        ENDIF

        loc_cBusca = INPUTBOX("Digite o C" + CHR(243) + "digo ou a Descri" + CHR(231) + CHR(227) + "o da Unidade:", "Buscar Unidade")

        IF EMPTY(ALLTRIM(loc_cBusca))
            RETURN loc_lAchou
        ENDIF

        SELECT cursor_4c_Dados
        LOCATE FOR ALLTRIM(cunis) = ALLTRIM(UPPER(loc_cBusca))

        IF !FOUND()
            LOCATE FOR UPPER(ALLTRIM(dunis)) = UPPER(ALLTRIM(loc_cBusca))
        ENDIF

        IF FOUND()
            loc_lAchou = .T.
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
        ELSE
            MsgAviso("Unidade n" + CHR(227) + "o encontrada!", "Buscar")
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT exige metodo publico
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Grava a Unidade (INSERT ou UPDATE conforme this_lNovoRegistro)
    * BusinessBase.Salvar() ja chama ValidarDados() e exibe erro se falhar - o
    * form NAO precisa de ELSE incondicional (CLAUDE.md regra #20)
    * PUBLIC: BINDEVENT exige metodo publico
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Unidade salva com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao/inclusao e volta para a lista
    * AlternarPagina(1) ja seta this_cModoAtual="LISTA" e chama CarregarLista()
    * PUBLIC: BINDEVENT exige metodo publico
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Controls E Pages (para PageFrames aninhados)
    *===========================================================================
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

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
