*==============================================================================
* Formsigoplin.prg - Formulario de Cadastro de Lote de Instrucoes
* Migrado de: SIGOPLIN.SCX (frmcadastro)
*
* FASE 4/8 - Grid e Botoes CRUD (Page1): grd_4c_Lista ligado a
* cursor_4c_Dados (sigoplinBO.Buscar), cnt_4c_Botoes com 5 botoes CRUD
* (Incluir/Visualizar/Alterar/Excluir/Buscar), cnt_4c_Saida com
* cmd_4c_Encerrar (CLAUDE.md regra #10), CarregarLista() e
* AlternarPagina().
*
* FASE 5/8 - Campos principais (Page2 - Parte 1): identificacao do
* lote (Lote, Usuario, Data, Instrucao).
*
* FASE 6/8 - Campos restantes e lookups (Page2 - Parte 2): Grupo/Conta/
* Descricao de estoque (getCdGrEstoque/getCdEstoque/getDsEstoque) com
* lookups em SigCdGcr/SigCdCli (fAcessoContab/fAcessoContas do legado
* substituidos por FormBuscaAuxiliar - memoria facessocontas_lookup_ux:
* fAcessoContas auto-preenche sem selecao, nao eh UX adequada), lookup
* de Instrucao (SigOpIns) e container cnt_4c_BotoesAcao (Confirmar/
* Cancelar). Grades Cheques/Titulos e demais eventos/Click handlers
* sao completados nas proximas fases.
*
* FASE 7/8 - Eventos principais: BtnIncluirClick/BtnVisualizarClick/
* BtnAlterarClick/BtnExcluirClick (ligados via BINDEVENT aos botoes de
* cnt_4c_Botoes criados na Fase 4), FormParaBO/BOParaForm preenchidos
* para os campos existentes (Lote/Usuario/Data/Instrucao/Grupo/Conta/
* Descricao de estoque), e os auxiliares LimparCampos/HabilitarCampos/
* AjustarBotoesPorModo. Selecao de linha usa cursor_4c_Dados.cidchaves
* (PK Fortyus - nao exibida no grid, mas presente no cursor desde a
* Fase 4/sigoplinBO.Buscar).
*
* FASE 8/8 - Eventos auxiliares e consolidacao final: BtnBuscarClick
* (FormBuscaAuxiliar por numlotes, posiciona cursor_4c_Dados no lote
* achado), BtnEncerrarClick (THIS.Release(), ligado a cmd_4c_Encerrar
* de cnt_4c_Saida), BtnSalvarClick (FormParaBO + Salvar() - sem ELSE,
* BusinessBase ja reporta falha) e BtnCancelarClick (AlternarPagina(1)
* + CarregarLista()), ligados via BINDEVENT aos botoes cmd_4c_Buscar
* (Page1) e cmd_4c_Confirmar/cmd_4c_Cancelar (cnt_4c_BotoesAcao, Page2)
* criados nas Fases 4 e 6.
*
* DECISAO DE PROJETO: as grades de detalhe (cntGradeCheques/
* cntGradeTitulos do legado - itens de cheque/titulo do lote, tabela
* SigPrLii) e os paineis de busca por Cheque/Titulo da Page1
* (cntBuscaCheques/cntBuscaTitulos) NAO foram portados nesta migracao.
* sigoplinBO ja documenta essa decisao (ver comentario antes do
* ENDDEFINE do BO) - o CRUD do mestre (SigPrLit) esta completo e
* funcional; o detalhe fica para uma tarefa de migracao dedicada.
*==============================================================================

DEFINE CLASS Formsigoplin AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Lote de Instru" + CHR(231) + CHR(245) + "es"
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
    this_lEmLookup        = .F.    && guarda de reentrancia de lookups (regra #37)

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
            THIS.this_oBusinessObject = CREATEOBJECT("sigoplinBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar sigoplinBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigoplin.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                THIS.CarregarLista()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formsigoplin:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formsigoplin.InicializarForm")
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
    * ConfigurarPaginaLista - Page1 (Lista): cabecalho + container de botoes
    * CRUD (Grupo_op legado: Left=344, Top=-1, Width=385, Height=85) + Saida
    * (Grupo_Saida/CLAUDE.md regra #10) + Grid de lotes de instrucoes.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - faixa do titulo
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
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

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
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

        *-- Container Botoes CRUD (Grupo_op legado: Left=344, Top=-1, Width=385, Height=85)
        *-- Canonico: Top=29 (-1+29 compensacao), Left=542, Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Container Saida - valores canonicos CLAUDE.md regra #10
        *-- Transparente sobre a Page; Page.Width NAO subtrai espaco por este container
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

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- Grid de lista (lotes de instrucoes - cursor_4c_Dados, ver sigoplinBO.Buscar)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 12
            .Width              = 895
            .Height             = 455
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
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- ColumnCount FORA do WITH para criar colunas imediatamente (Problema 36)
        loc_oPagina.grd_4c_Lista.ColumnCount = 8

        WITH loc_oPagina.grd_4c_Lista
            .Column1.Header1.Caption = "Tipo"
            .Column1.Width           = 60
            .Column1.Alignment       = 2

            .Column2.Header1.Caption = "N" + CHR(186) + " Lote"
            .Column2.Width           = 90
            .Column2.Alignment       = 1

            .Column3.Header1.Caption = "Instru" + CHR(231) + CHR(227) + "o"
            .Column3.Width           = 90
            .Column3.Alignment       = 0

            .Column4.Header1.Caption = "Data"
            .Column4.Width           = 90
            .Column4.Alignment       = 0

            .Column5.Header1.Caption = "Grupo"
            .Column5.Width           = 100
            .Column5.Alignment       = 0

            .Column6.Header1.Caption = "Conta"
            .Column6.Width           = 100
            .Column6.Alignment       = 0

            .Column7.Header1.Caption = "Valor"
            .Column7.Width           = 120
            .Column7.Alignment       = 1

            .Column8.Header1.Caption = "Moeda"
            .Column8.Width           = 60
            .Column8.Alignment       = 0
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2 (Dados): cabecalho + container de botoes
    * de acao (Grupo_Salva legado: Left=819, Top=9, Width=160, Height=85) com
    * cmd_4c_Confirmar/cmd_4c_Cancelar + campos completos (Lote/Usuario/Data/
    * Instrucao - Fase 5; Grupo/Conta/Descricao de estoque - Fase 6) com seus
    * lookups. Grades Cheques/Titulos sao preenchidas nas proximas fases.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista - CLAUDE.md regra #11)
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

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
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

        *-- FASE 5/8 - Campos principais Parte 1 (identificacao do lote)
        *-- Legado (SIGOPLIN.Pagina.Dados): Shape1 Top=143 Left=65 W=670 H=33;
        *-- Say3/Say13/Say2/Say1 Top=152; getLote/getUsuar/getData/getInstrucao Top=148.
        *-- Compensacao PageFrame +29: Shape1 Top=172; labels Top=181; campos Top=177.
        loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPagina.shp_4c_Shape1
            .Top         = 172
            .Left        = 65
            .Width       = 670
            .Height      = 33
            .BorderColor = RGB(90, 90, 90)
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "N" + CHR(186) + " do Lote :"
            .Top       = 181
            .Left      = 112
            .Width     = 65
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Lote", "TextBox")
        WITH loc_oPagina.txt_4c_Lote
            .Value         = 0
            .Top           = 177
            .Left          = 180
            .Width         = 66
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99999999"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Top       = 181
            .Left      = 271
            .Width     = 50
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Usuar", "TextBox")
        WITH loc_oPagina.txt_4c_Usuar
            .Value         = ""
            .Top           = 177
            .Left          = 324
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Data :"
            .Top       = 181
            .Left      = 428
            .Width     = 34
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Data", "TextBox")
        WITH loc_oPagina.txt_4c_Data
            .Value         = {}
            .Top           = 177
            .Left          = 465
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Instru" + CHR(231) + CHR(227) + "o :"
            .Top       = 181
            .Left      = 568
            .Width     = 62
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Instrucao", "TextBox")
        WITH loc_oPagina.txt_4c_Instrucao
            .Value         = ""
            .Top           = 177
            .Left          = 633
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Instrucao, "LostFocus", THIS, "ValidarInstrucao")

        *-- FASE 6/8 - Campos restantes (Grupo/Conta/Descricao de estoque)
        *-- Legado (SIGOPLIN.Pagina.Dados): Shape2 Top=180 Left=65 W=670 H=33;
        *-- Say5 "Grupo / Conta :" Top=189 Left=92; Say4 "/" Top=189 Left=262;
        *-- getCdGrEstoque/getCdEstoque/getDsEstoque Top=185.
        *-- Compensacao PageFrame +29: Shape2 Top=209; labels Top=218; campos Top=214.
        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top         = 209
            .Left        = 65
            .Width       = 670
            .Height      = 33
            .BorderColor = RGB(90, 90, 90)
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Grupo / Conta :"
            .Top       = 218
            .Left      = 92
            .Width     = 84
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdGrEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdGrEstoque
            .Value         = ""
            .Top           = 214
            .Left          = 180
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdGrEstoque, "LostFocus", THIS, "ValidarGrupoEstoque")

        loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdEstoque
            .Value         = ""
            .Top           = 214
            .Left          = 271
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque, "LostFocus", THIS, "ValidarContaEstoque")

        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "/"
            .Top       = 218
            .Left      = 262
            .Width     = 10
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_DsEstoque
            .Value         = ""
            .Top           = 214
            .Left          = 353
            .Width         = 360
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 50
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque, "LostFocus", THIS, "ValidarDescEstoque")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados do Form (Page2) para o Business Object.
    * this_nTipos/this_nValors/this_cMoedas/this_cEmps/this_cObs nao tem
    * controle na Page2 ainda (grades Cheques/Titulos - proximas fases);
    * this_cEmps/this_cUsuarios/this_dDatas tem fallback em sigoplinBO.Inserir()
    * quando vazios.
    *===========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            THIS.this_oBusinessObject.this_nNumlotes = loc_oPg2.txt_4c_Lote.Value
            THIS.this_oBusinessObject.this_cUsuarios = ALLTRIM(loc_oPg2.txt_4c_Usuar.Value)
            THIS.this_oBusinessObject.this_dDatas    = ConverterParaData(loc_oPg2.txt_4c_Data.Value)
            THIS.this_oBusinessObject.this_cCods     = ALLTRIM(loc_oPg2.txt_4c_Instrucao.Value)
            THIS.this_oBusinessObject.this_cGrupos   = ALLTRIM(loc_oPg2.txt_4c_CdGrEstoque.Value)
            THIS.this_oBusinessObject.this_cContas   = ALLTRIM(loc_oPg2.txt_4c_CdEstoque.Value)
            THIS.this_oBusinessObject.this_cDContas  = ALLTRIM(loc_oPg2.txt_4c_DsEstoque.Value)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigoplin.FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do Business Object para o Form (Page2)
    *===========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Lote.Value        = THIS.this_oBusinessObject.this_nNumlotes
            loc_oPg2.txt_4c_Usuar.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cUsuarios)
            loc_oPg2.txt_4c_Data.Value        = ConverterParaData(THIS.this_oBusinessObject.this_dDatas)
            loc_oPg2.txt_4c_Instrucao.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cCods)
            loc_oPg2.txt_4c_CdGrEstoque.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
            loc_oPg2.txt_4c_CdEstoque.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cContas)
            loc_oPg2.txt_4c_DsEstoque.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDContas)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigoplin.BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa valores dos campos da Page2 (modo INCLUIR)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Lote.Value        = 0
            loc_oPg2.txt_4c_Usuar.Value       = ""
            loc_oPg2.txt_4c_Data.Value        = {}
            loc_oPg2.txt_4c_Instrucao.Value   = ""
            loc_oPg2.txt_4c_CdGrEstoque.Value = ""
            loc_oPg2.txt_4c_CdEstoque.Value   = ""
            loc_oPg2.txt_4c_DsEstoque.Value   = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigoplin.LimparCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos da Page2 conforme o modo.
    * Legado: Get_Usuar.When sempre Return .f. (nunca digitavel); Get_Lote.When
    * so habilita em pcEscolha='PROCURAR' (modo de busca, ainda nao migrado -
    * ate existir, permanece sempre .F.); Get_Data.When Return
    * (pcEscolha='INSERIR') - Data so digitavel no INCLUIR.
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Lote.Enabled  = .F.
            loc_oPg2.txt_4c_Usuar.Enabled = .F.
            loc_oPg2.txt_4c_Data.Enabled  = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")

            loc_oPg2.txt_4c_Instrucao.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_CdGrEstoque.Enabled = par_lHabilitar
            loc_oPg2.txt_4c_CdEstoque.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_DsEstoque.Enabled   = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigoplin.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita cmd_4c_Confirmar/Cancelar
    * (cnt_4c_BotoesAcao) conforme this_cModoAtual
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        TRY
            loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigoplin.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara BO/form para um novo lote de instrucoes
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigoplin.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre o lote selecionado em modo somente leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidchaves, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigoplin.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre o lote selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidchaves, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigoplin.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o lote selecionado (e seus itens - SigPrLii)
    * apos confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidchaves, loc_nNumlotes, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
        loc_nNumlotes  = cursor_4c_Dados.numlotes

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do lote " + TRANSFORM(loc_nNumlotes) + "?", "Excluir")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Lote de instru" + CHR(231) + CHR(245) + "es exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigoplin.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre picker (FormBuscaAuxiliar) para localizar um lote
    * pelo numero (numlotes) e posiciona o grid da Page1 no registro achado.
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17).
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCidchaves

        loc_cCidchaves = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrLit", "cursor_4c_BuscaLote", "numlotes", "", ;
                "Buscar Lote de Instru" + CHR(231) + CHR(245) + "es")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("numlotes", "", "Lote")
                loc_oBusca.mAddColuna("cods",     "", "Instru" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("datas",    "", "Data")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLote")
                    SELECT cursor_4c_BuscaLote
                    loc_cCidchaves = ALLTRIM(cursor_4c_BuscaLote.cidchaves)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaLote")
                USE IN cursor_4c_BuscaLote
            ENDIF

            IF !EMPTY(loc_cCidchaves) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(cidchaves) == loc_cCidchaves
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "Formsigoplin.BtnBuscarClick")
            IF USED("cursor_4c_BuscaLote")
                USE IN cursor_4c_BuscaLote
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17).
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma e grava o lote atual (INCLUIR/ALTERAR).
    * FormParaBO() + Salvar(): BusinessBase.Salvar() decide INSERT/UPDATE
    * via this_lNovoRegistro e ja chama ExibirFalha() em qualquer caminho de
    * falha - NAO precisa de ELSE aqui (memoria SalvarsemELSE).
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17).
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Lote de instru" + CHR(231) + CHR(245) + "es salvo com sucesso!")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao/visualizacao e volta para a Lista
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17).
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * ValidarInstrucao - LostFocus de txt_4c_Instrucao. Lookup em SigOpIns
    * (Cods/Descrs). Legado: Get_Instrucao.Valid -
    * "If Not Empty(This.Value) And Not Seek(This.Value,'crSigOpIns','Cods')
    *  loBrowse = CreateObject('fwBuscaSel','crSigOpIns','Cods',...)".
    * Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
    * campo, o que redispara este proprio LostFocus. O corpo vive em
    * ValidarInstrucaoExec para que a flag seja SEMPRE liberada.
    *===========================================================================
    PROCEDURE ValidarInstrucao()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarInstrucaoExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarInstrucaoExec()
        LOCAL loc_cInstrucao, loc_oPg2, loc_oBusca
        TRY
            loc_oPg2      = THIS.pgf_4c_Paginas.Page2
            loc_cInstrucao = ALLTRIM(loc_oPg2.txt_4c_Instrucao.Value)

            IF !EMPTY(loc_cInstrucao)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigOpIns", "cursor_4c_BuscaInstrucao", "Cods", loc_cInstrucao, ;
                    "Instru" + CHR(231) + CHR(245) + "es")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaInstrucao")
                            loc_oPg2.txt_4c_Instrucao.Value = ALLTRIM(cursor_4c_BuscaInstrucao.Cods)
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaInstrucao")
                                loc_oPg2.txt_4c_Instrucao.Value = ALLTRIM(cursor_4c_BuscaInstrucao.Cods)
                            ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Formsigoplin.ValidarInstrucaoExec: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaInstrucao")
            USE IN cursor_4c_BuscaInstrucao
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarGrupoEstoque - LostFocus de txt_4c_CdGrEstoque. Lookup em
    * SigCdGcr (Codigos/Descrs). Legado: Get_CdGrEstoque.Valid chamava
    * fAcessoContab(Usuar, 'C', This.Value, This) - substituido por
    * FormBuscaAuxiliar (memoria facessocontas_lookup_ux: fAcessoContab/
    * fAcessoContas auto-preenchem sem selecao do usuario).
    *===========================================================================
    PROCEDURE ValidarGrupoEstoque()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarGrupoEstoqueExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarGrupoEstoqueExec()
        LOCAL loc_cGrupo, loc_oPg2, loc_oBusca
        TRY
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2
            loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_CdGrEstoque.Value)

            IF !EMPTY(loc_cGrupo)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGcr", "cursor_4c_BuscaGrEstoque", "Codigos", loc_cGrupo, ;
                    "Grupo Cont" + CHR(225) + "bil / Estoque")

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaGrEstoque")
                            loc_oPg2.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEstoque.Codigos)
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEstoque")
                                loc_oPg2.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEstoque.Codigos)
                            ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Formsigoplin.ValidarGrupoEstoqueExec: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrEstoque")
            USE IN cursor_4c_BuscaGrEstoque
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarContaEstoque - LostFocus de txt_4c_CdEstoque. Lookup em SigCdCli
    * (Iclis/Rclis), filtrado pelo grupo quando preenchido (SigCdCli.grupos -
    * memoria sigcdcli_grupos_nao_grclis: grupos, NUNCA grclis). Legado:
    * Get_CdEstoque.Valid chamava fAcessoContas(Usuar, CdGrEstoque, 'C',
    * This.Value, CdEstoque, DsEstoque) - ao selecionar, preenche tambem a
    * descricao (txt_4c_DsEstoque), igual ao legado.
    *===========================================================================
    PROCEDURE ValidarContaEstoque()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarContaEstoqueExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarContaEstoqueExec()
        LOCAL loc_cConta, loc_cGrupo, loc_cFiltro, loc_oPg2, loc_oBusca
        TRY
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2
            loc_cConta = ALLTRIM(loc_oPg2.txt_4c_CdEstoque.Value)
            loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_CdGrEstoque.Value)

            IF !EMPTY(loc_cConta)
                loc_cFiltro = ""
                IF !EMPTY(loc_cGrupo)
                    loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaCtEstoque", "Iclis", loc_cConta, ;
                    "Contas de Estoque", .F., .F., loc_cFiltro)

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaCtEstoque")
                            loc_oPg2.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaCtEstoque.Iclis)
                            loc_oPg2.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaCtEstoque.Rclis)
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("Iclis", "", "Conta")
                            loc_oBusca.mAddColuna("Rclis", "", "Nome")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtEstoque")
                                loc_oPg2.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaCtEstoque.Iclis)
                                loc_oPg2.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaCtEstoque.Rclis)
                            ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Formsigoplin.ValidarContaEstoqueExec: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaCtEstoque")
            USE IN cursor_4c_BuscaCtEstoque
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarDescEstoque - LostFocus de txt_4c_DsEstoque. Lookup em SigCdCli
    * pela DESCRICAO (Rclis), entrada alternativa ao codigo - legado:
    * Get_DsEstoque.Valid chamava fAcessoContas(Usuar, CdGrEstoque, 'D',
    * This.Value, CdEstoque, DsEstoque). Preenche tambem txt_4c_CdEstoque.
    *===========================================================================
    PROCEDURE ValidarDescEstoque()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDescEstoqueExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarDescEstoqueExec()
        LOCAL loc_cDesc, loc_cGrupo, loc_cFiltro, loc_oPg2, loc_oBusca
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_cDesc  = ALLTRIM(loc_oPg2.txt_4c_DsEstoque.Value)
            loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_CdGrEstoque.Value)

            IF !EMPTY(loc_cDesc)
                loc_cFiltro = ""
                IF !EMPTY(loc_cGrupo)
                    loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdCli", "cursor_4c_BuscaCtEstoque", "Rclis", loc_cDesc, ;
                    "Contas de Estoque", .F., .F., loc_cFiltro)

                IF VARTYPE(loc_oBusca) = "O"
                    IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                        IF USED("cursor_4c_BuscaCtEstoque")
                            loc_oPg2.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaCtEstoque.Rclis)
                            loc_oPg2.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaCtEstoque.Iclis)
                        ENDIF
                    ELSE
                        IF !loc_oBusca.this_lAchouRegistro
                            loc_oBusca.mAddColuna("Rclis", "", "Nome")
                            loc_oBusca.mAddColuna("Iclis", "", "Conta")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtEstoque")
                                loc_oPg2.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaCtEstoque.Rclis)
                                loc_oPg2.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaCtEstoque.Iclis)
                            ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Formsigoplin.ValidarDescEstoqueExec: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaCtEstoque")
            USE IN cursor_4c_BuscaCtEstoque
        ENDIF
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles de um container,
    * percorrendo recursivamente Controls (e Pages, no caso de PageFrame)
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

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
    * FormatarGridLista - Formata visual do grid da lista (fonte/tamanho)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        par_oGrid.FontName = "Verdana"
        par_oGrid.FontSize = 8
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    * par_nPagina: 1=Lista, 2=Dados
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND BETWEEN(par_nPagina, 1, 2)
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega lotes de instrucoes (SigPrLit) no Grid da Page1
    * Chama sigoplinBO.Buscar("") e vincula cursor_4c_Dados ao grid
    * Colunas: tipos, numlotes, cods, datas, grupos, contas, valors, moedas
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid.ColumnCount = 8
                loc_oGrid.RecordSource          = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.numlotes"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cods"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.datas"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupos"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contas"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.valors"
                loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.moedas"

                *-- Reconfigurar headers e larguras APOS RecordSource (reseta captions/Width)
                loc_oGrid.Column1.Header1.Caption = "Tipo"
                loc_oGrid.Column2.Header1.Caption = "N" + CHR(186) + " Lote"
                loc_oGrid.Column3.Header1.Caption = "Instru" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column4.Header1.Caption = "Data"
                loc_oGrid.Column5.Header1.Caption = "Grupo"
                loc_oGrid.Column6.Header1.Caption = "Conta"
                loc_oGrid.Column7.Header1.Caption = "Valor"
                loc_oGrid.Column8.Header1.Caption = "Moeda"

                loc_oGrid.Column1.Width = 60
                loc_oGrid.Column2.Width = 90
                loc_oGrid.Column3.Width = 90
                loc_oGrid.Column4.Width = 90
                loc_oGrid.Column5.Width = 100
                loc_oGrid.Column6.Width = 100
                loc_oGrid.Column7.Width = 120
                loc_oGrid.Column8.Width = 60

                loc_oGrid.Column1.Alignment = 2
                loc_oGrid.Column2.Alignment = 1
                loc_oGrid.Column7.Alignment = 1

                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
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
