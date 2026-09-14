*==============================================================================
* FormTop.prg - Formulario de Cadastro de Tipos de Operacoes
* Migrado de: SigCdTop.SCX (frmcadastro)
* Tabela: SigCdTom
* Chave: codigos numeric(2,0)
*
* FASE 6/8: Form - Campos Restantes e Lookups (Page2 - Parte 2)
* Sem lookups F4/DblClick neste form (confirmado via comportamento.json:
* funcoesExternas=[fCarregaGrade] e analise.json: lookups=[])
*==============================================================================

DEFINE CLASS FormTop AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Tipos de Opera" + CHR(231) + CHR(245) + "es"
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
            THIS.this_oBusinessObject = CREATEOBJECT("TopBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar TopBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormTop.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                THIS.CarregarLista()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormTop:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTop.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * REGRA CLAUDE.md #11: a faixa do cabecalho DEVE ser o PRIMEIRO AddObject
    * da pagina - os containers de botao ficam em Top=29..33, dentro da area
    * da faixa, e precisam ser criados DEPOIS para desenhar por cima.
    * Grid com colunas Codigo/Descricao e botoes CRUD (Incluir/Visualizar/
    * Alterar/Excluir/Buscar/Encerrar).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Faixa do Cabecalho (PRIMEIRO AddObject da pagina - CLAUDE.md #11)
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

        *-- Container Botoes CRUD (Grupo_op no legado)
        *-- Canonico: Left=542, Top=29, Width=390, Height=85 (framework_frmcadastro_layout.md)
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

        *-- Container Saida - valores canonicos CLAUDE.md regra #10 (PREVALECE sobre legado)
        *-- Transparente/flutuante sobre a Page; Page.Width NAO subtrai espaco por este container
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

        *-- Grid de lista (Grade no legado) - AddCursor('SigCdTom','Codigos','CrSigCdTom')
        *-- pColuna('Codigos',...,44) + pColuna('Descrs',...,279)
        *-- Original: Grade.Top=88. Com compensacao +29: Top=117
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
        loc_oPagina.grd_4c_Lista.ColumnCount = 2

        WITH loc_oPagina.grd_4c_Lista
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column1.Width           = 120
            .Column1.Alignment       = 1

            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width           = 770
            .Column2.Alignment       = 0
        ENDWITH

        *-- BINDEVENTs - metodos devem ser PUBLIC (sem PROTECTED) para funcionar
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * REGRA CLAUDE.md #11: faixa do cabecalho tambem na pagina Dados
    * (decisao do time - diverge do legado frmcadastro que so tem na Lista).
    * TextBoxes/Labels/OptionGroups de dados sao adicionados nas proximas fases.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Faixa do Cabecalho (PRIMEIRO AddObject da pagina - CLAUDE.md #11)
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

        *-- Container Botoes de Acao (Confirmar/Cancelar)
        *-- Posicao base equivalente ao Grupo_Salva do framework (Top=33, Left=842)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
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

        *-- BINDEVENTs dos botoes de acao (metodos PUBLIC implementados em fase posterior)
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Campos principais - Page2 (FASE 5/8 - primeira metade)
        *-- Original: SIGCDTOP.Pagina.Dados.* -- Top_novo = Top_original + 72
        *-- (compensa PageFrame.Top=-29 [+29] e a faixa de cabecalho canonica
        *-- Top=29/Height=80 [+43], ficando o 1o controle em Top=115 - CLAUDE.md #11)
        THIS.AdicionarCamposPrincipais1(loc_oPagina)

        *-- Campos restantes - Page2 (FASE 6/8 - segunda metade)
        THIS.AdicionarCamposPrincipais2(loc_oPagina)

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * AdicionarCamposPrincipais1 - Page2, primeira metade dos campos (FASE 5/8)
    * Codigo/Descricao + Gravacao Movimentacao + Vendedor + Situacao +
    * Mercadoria + Cancelamento de Pedido + Tipo de Operacao + Atualiza
    * Compras + Buscar Valor Total Pelo Notas + Exibe no limites de entregas
    * Mapeamento (ControlSource legado -> propriedade TopBO):
    *   Get_Codigos (crSigCdTom.Codigos)    -> this_nCodigos
    *   Get_Descrs  (crSigCdTom.Descrs)     -> this_cDescrs
    *   Op_Gdmi     (crSigCdTom.gergdmis)   -> this_nGergdmis
    *   fwoption8   (crSigCdTom.GerVds)     -> this_nGerVds
    *   Op_Situacao (crSigCdTom.Flagpgs)    -> this_nFlagpgs
    *   optTpMercs  (crSigCdTom.TpMercs)    -> this_nTpMercs
    *   ObjCancPdv  (crSigCdTom.cancPeds)   -> this_nCancPeds
    *   fwoption1   (crSigCdTom.TpGdmis)    -> this_nTpGdmis
    *   fwoption3   (crSigCdTom.AtuCompras) -> this_nAtuCompras
    *   fwoption2   (crSigCdTom.OpVlUnis)   -> this_nOpVlUnis
    *   fwoption4   (crSigCdTom.ExibLims)   -> this_nExibLims
    *===========================================================================
    PROTECTED PROCEDURE AdicionarCamposPrincipais1(par_oPagina)

        *-- Codigo (PK - crSigCdTom.Codigos - numeric(2,0) - InputMask "99")
        par_oPagina.AddObject("lbl_4c_Codigos", "Label")
        WITH par_oPagina.lbl_4c_Codigos
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 118
            .Left      = 210
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH par_oPagina.txt_4c_Codigos
            .Top           = 115
            .Left          = 257
            .Width         = 25
            .Height        = 23
            .MaxLength     = 2
            .InputMask     = "99"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Descricao (crSigCdTom.Descrs - char(30))
        par_oPagina.AddObject("lbl_4c_Descrs", "Label")
        WITH par_oPagina.lbl_4c_Descrs
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 118
            .Left      = 304
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH par_oPagina.txt_4c_Descrs
            .Top           = 115
            .Left          = 373
            .Width         = 220
            .Height        = 23
            .MaxLength     = 30
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Gravacao de Movimentacao (crSigCdTom.gergdmis - Op_Gdmi - 6 opcoes)
        par_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPagina.lbl_4c_Label1
            .Caption   = "Grava" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(227) + "o: "
            .Top       = 146
            .Left      = 110
            .Width     = 142
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_OpGdmi", "OptionGroup")
        WITH par_oPagina.obj_4c_OpGdmi
            .ButtonCount = 6
            .Top         = 143
            .Left        = 257
            .Width       = 251
            .Height      = 44
            .BackStyle   = 0
            .BorderStyle = 1
            .SpecialEffect = 1
            .Themes      = .F.
            .Value       = 5
            .Visible     = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_OpGdmi.Buttons(1)
            .Caption   = "Venda"
            .Left      = 3
            .Top       = 4
            .Width     = 64
            .Height    = 16
            .Style     = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OpGdmi.Buttons(2)
            .Caption   = "Compra"
            .Left      = 67
            .Top       = 4
            .Width     = 64
            .Height    = 16
            .Style     = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OpGdmi.Buttons(3)
            .Caption   = "Pedido de Venda"
            .Left      = 136
            .Top       = 4
            .Width     = 98
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OpGdmi.Buttons(4)
            .Caption   = "Estoque"
            .Left      = 3
            .Top       = 22
            .Width     = 64
            .Height    = 16
            .Style     = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OpGdmi.Buttons(5)
            .Caption   = "Nenhum"
            .Left      = 67
            .Top       = 22
            .Width     = 64
            .Height    = 16
            .Style     = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OpGdmi.Buttons(6)
            .Caption   = "Pedido de Compra"
            .Left      = 136
            .Top       = 22
            .Width     = 105
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Vendedor (crSigCdTom.GerVds - fwoption8 - 2 opcoes)
        par_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH par_oPagina.lbl_4c_Label10
            .Caption   = "Vendedor :"
            .Top       = 197
            .Left      = 197
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Fwoption8", "OptionGroup")
        WITH par_oPagina.obj_4c_Fwoption8
            .ButtonCount   = 2
            .Top           = 193
            .Left          = 257
            .Width         = 251
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption8.Buttons(1)
            .Caption   = "Pr" + CHR(243) + "pria Opera" + CHR(231) + CHR(227) + "o"
            .Left      = 3
            .Top       = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption8.Buttons(2)
            .Caption   = "SubNivel"
            .Left      = 137
            .Top       = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Situacao (crSigCdTom.Flagpgs - Op_Situacao - 3 opcoes)
        par_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH par_oPagina.lbl_4c_Label2
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 226
            .Left      = 202
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_OpSituacao", "OptionGroup")
        WITH par_oPagina.obj_4c_OpSituacao
            .ButtonCount   = 3
            .Top           = 222
            .Left          = 257
            .Width         = 251
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 3
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_OpSituacao.Buttons(1)
            .Caption   = "Pagos"
            .Left      = 3
            .Top       = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OpSituacao.Buttons(2)
            .Caption   = "N" + CHR(227) + "o Pagos"
            .Left      = 63
            .Top       = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OpSituacao.Buttons(3)
            .Caption   = "Todos"
            .Left      = 136
            .Top       = 5
            .Width     = 47
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Mercadoria (crSigCdTom.TpMercs - optTpMercs - 3 opcoes)
        par_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH par_oPagina.lbl_4c_Label8
            .Caption   = "Mercadoria :"
            .Top       = 255
            .Left      = 190
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_OptTpMercs", "OptionGroup")
        WITH par_oPagina.obj_4c_OptTpMercs
            .ButtonCount   = 3
            .Top           = 251
            .Left          = 257
            .Width         = 251
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_OptTpMercs.Buttons(1)
            .Caption   = "Nenhuma"
            .Left      = 3
            .Top       = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OptTpMercs.Buttons(2)
            .Caption   = "Separada"
            .Left      = 68
            .Top       = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OptTpMercs.Buttons(3)
            .Caption   = "N" + CHR(227) + "o Separada"
            .Left      = 135
            .Top       = 5
            .Width     = 86
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Cancelamento de Pedido (crSigCdTom.cancPeds - ObjCancPdv - 3 opcoes)
        par_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH par_oPagina.lbl_4c_Label3
            .Caption   = "Cancelamento de Pedido :"
            .Top       = 283
            .Left      = 125
            .Width     = 127
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_ObjCancPdv", "OptionGroup")
        WITH par_oPagina.obj_4c_ObjCancPdv
            .ButtonCount   = 3
            .Top           = 280
            .Left          = 257
            .Width         = 249
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_ObjCancPdv.Buttons(1)
            .Caption   = "Sim"
            .Left      = 3
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_ObjCancPdv.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 63
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_ObjCancPdv.Buttons(3)
            .Caption   = "Excluir Opera" + CHR(231) + CHR(227) + "o"
            .Left      = 120
            .Top       = 4
            .Width     = 99
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Tipo de Operacao (crSigCdTom.TpGdmis - fwoption1 - Soma/Subtrai)
        par_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH par_oPagina.lbl_4c_Label4
            .Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 312
            .Left      = 158
            .Width     = 94
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Fwoption1", "OptionGroup")
        WITH par_oPagina.obj_4c_Fwoption1
            .ButtonCount   = 2
            .Top           = 309
            .Left          = 257
            .Width         = 125
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption1.Buttons(1)
            .Caption   = "Soma"
            .Left      = 3
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption1.Buttons(2)
            .Caption   = "Subtrai"
            .Left      = 63
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Atualiza Data/Valor Ult Compra (crSigCdTom.AtuCompras - fwoption3 - Sim/Nao/Peso-Custo)
        par_oPagina.AddObject("lbl_4c_Say1", "Label")
        WITH par_oPagina.lbl_4c_Say1
            .Caption   = "Atualiza Data/Valor Ult Compra :"
            .Top       = 312
            .Left      = 422
            .Width     = 157
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Fwoption3", "OptionGroup")
        WITH par_oPagina.obj_4c_Fwoption3
            .ButtonCount   = 3
            .Top           = 309
            .Left          = 584
            .Width         = 201
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption3.Buttons(1)
            .Caption   = "Sim"
            .Left      = 3
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption3.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 55
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption3.Buttons(3)
            .Caption   = "Peso/Custo"
            .Left      = 107
            .Top       = 3
            .Width     = 84
            .Height    = 17
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Buscar Valor Total Pelo Notas (crSigCdTom.OpVlUnis - fwoption2 - Sim/Nao)
        par_oPagina.AddObject("lbl_4c_Say2", "Label")
        WITH par_oPagina.lbl_4c_Say2
            .Caption   = "Buscar Valor Total  Pelo Notas :"
            .Top       = 342
            .Left      = 100
            .Width     = 152
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Fwoption2", "OptionGroup")
        WITH par_oPagina.obj_4c_Fwoption2
            .ButtonCount   = 2
            .Top           = 338
            .Left          = 257
            .Width         = 125
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption2.Buttons(1)
            .Caption   = "Sim"
            .Left      = 3
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption2.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 63
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Exibe no limites de entregas (crSigCdTom.ExibLims - fwoption4 - Sim/Nao)
        par_oPagina.AddObject("lbl_4c_Say5", "Label")
        WITH par_oPagina.lbl_4c_Say5
            .Caption   = "Exibe no limites de entregas:"
            .Top       = 342
            .Left      = 439
            .Width     = 140
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Fwoption4", "OptionGroup")
        WITH par_oPagina.obj_4c_Fwoption4
            .ButtonCount   = 2
            .Top           = 338
            .Left          = 584
            .Width         = 121
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption4.Buttons(1)
            .Caption   = "Sim"
            .Left      = 3
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption4.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 63
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

    ENDPROC

    *===========================================================================
    * AdicionarCamposPrincipais2 - Page2, segunda metade dos campos (FASE 6/8)
    * Implementa os campos: Baixa de Estoque, Calcular Rel. de Comissao,
    * marcacao de exibicao como registro em espera de processamento,
    * Fluxo de Caixa, Gera CMV, Quantidade Maxima de Entregas (Dias Uteis,
    * Sabados, Domingos e Feriados), Geracao de Reposicao e linhas divisorias
    * Mapeamento (ControlSource legado -> propriedade TopBO):
    *   fwoption6    (crSigCdTom.BxVendas)   -> this_nBxVendas
    *   fwoption5    (crSigCdTom.nChkSDFs)   -> this_nChkSDFs
    *   getEntPends  (crSigCdTom.EntPends)   -> this_nEntPends
    *   fwoption7    (crSigCdTom.nFlxCaixa)  -> this_nFlxCaixa
    *   Fwoption9    (crSigCdTom.GeraCmvs)   -> this_nGeraCmvs
    *   getMaxEnts   (crSigCdTom.MaxEnts)    -> this_nMaxEnts
    *   getMaxEnt2s  (crSigCdTom.MaxEnt2s)   -> this_nMaxEnt2s
    *   getMaxEnt3s  (crSigCdTom.MaxEnt3s)   -> this_nMaxEnt3s
    *   optReposicaos(crSigCdTom.Reposicaos) -> this_nReposicaos
    * Nao ha lookups (F4/DblClick) neste form - confirmado via comportamento.json
    * (funcoesExternas = fCarregaGrade) e analise.json (lookups = []).
    * Top_novo = Top_original + 72 (mesma compensacao da Fase 5)
    *===========================================================================
    PROTECTED PROCEDURE AdicionarCamposPrincipais2(par_oPagina)

        *-- Baixa de Estoque (crSigCdTom.BxVendas - fwoption6 - 2 opcoes)
        par_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH par_oPagina.lbl_4c_Label9
            .Caption   = "Baixa de Estoque :"
            .Top       = 370
            .Left      = 160
            .Width     = 92
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Fwoption6", "OptionGroup")
        WITH par_oPagina.obj_4c_Fwoption6
            .ButtonCount   = 2
            .Top           = 367
            .Left          = 257
            .Width         = 125
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption6.Buttons(1)
            .Caption   = "Sim"
            .Left      = 3
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption6.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 63
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Calcular Rel. de Comissao (crSigCdTom.nChkSDFs - fwoption5 - 2 opcoes)
        par_oPagina.AddObject("lbl_4c_Say6", "Label")
        WITH par_oPagina.lbl_4c_Say6
            .Caption   = "Calcular Rel. de Comiss" + CHR(227) + "o :"
            .Top       = 371
            .Left      = 447
            .Width     = 132
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Fwoption5", "OptionGroup")
        WITH par_oPagina.obj_4c_Fwoption5
            .ButtonCount   = 2
            .Top           = 367
            .Left          = 584
            .Width         = 121
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .ToolTipText   = "Entra no Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o"
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption5.Buttons(1)
            .Caption   = "Sim"
            .Left      = 3
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption5.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 63
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Marcacao de registro em espera de processamento (crSigCdTom.EntPends - getEntPends - 2 opcoes)
        par_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH par_oPagina.lbl_4c_Label11
            .Caption   = "Exibir como entrada pendente na consulta gen" + CHR(233) + "rica de produtos :"
            .Top       = 394
            .Left      = 57
            .Width     = 195
            .Height    = 28
            .FontName  = "Tahoma"
            .FontSize  = 8
            .WordWrap  = .T.
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_GetEntPends", "OptionGroup")
        WITH par_oPagina.obj_4c_GetEntPends
            .ButtonCount   = 2
            .Top           = 396
            .Left          = 257
            .Width         = 125
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_GetEntPends.Buttons(1)
            .Caption   = "Sim"
            .Left      = 3
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_GetEntPends.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 63
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Fluxo de Caixa (crSigCdTom.nFlxCaixa - fwoption7 - 3 opcoes)
        par_oPagina.AddObject("lbl_4c_Say7", "Label")
        WITH par_oPagina.lbl_4c_Say7
            .Caption   = "Fluxo de Caixa :"
            .Top       = 400
            .Left      = 499
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Fwoption7", "OptionGroup")
        WITH par_oPagina.obj_4c_Fwoption7
            .ButtonCount   = 3
            .Top           = 396
            .Left          = 584
            .Width         = 184
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption7.Buttons(1)
            .Caption   = "Sim"
            .Left      = 3
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption7.Buttons(2)
            .Caption   = "Sim-Pago"
            .Left      = 59
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption7.Buttons(3)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 137
            .Top       = 4
            .Width     = 37
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Gera CMV (crSigCdTom.GeraCmvs - Fwoption9 - 2 opcoes)
        par_oPagina.AddObject("lbl_4c_Say8", "Label")
        WITH par_oPagina.lbl_4c_Say8
            .Caption   = "Gera CMV :"
            .Top       = 428
            .Left      = 523
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("obj_4c_Fwoption9", "OptionGroup")
        WITH par_oPagina.obj_4c_Fwoption9
            .ButtonCount   = 2
            .Top           = 425
            .Left          = 584
            .Width         = 121
            .Height        = 24
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption9.Buttons(1)
            .Caption   = "Sim"
            .Left      = 3
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_Fwoption9.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 63
            .Top       = 4
            .AutoSize  = .T.
            .BackStyle = 0
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Linha divisoria acima da secao "Quantidade Maxima de Entregas"
        par_oPagina.AddObject("shp_4c_Shape1", "Shape")
        WITH par_oPagina.shp_4c_Shape1
            .Top           = 461
            .Left          = 54
            .Width         = 652
            .Height        = 2
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Quantidade Maxima de Entregas (titulo)
        par_oPagina.AddObject("lbl_4c_Say4", "Label")
        WITH par_oPagina.lbl_4c_Say4
            .Caption   = " Quantidade M" + CHR(225) + "xima de Entregas "
            .Top       = 447
            .Left      = 54
            .Width     = 191
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Dias Uteis (crSigCdTom.MaxEnts - getMaxEnts)
        par_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH par_oPagina.lbl_4c_Label5
            .Caption   = "Dias " + CHR(218) + "teis :"
            .Top       = 471
            .Left      = 161
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_MaxEnts", "TextBox")
        WITH par_oPagina.txt_4c_MaxEnts
            .Top           = 468
            .Left          = 223
            .Width         = 38
            .Height        = 24
            .InputMask     = "9999"
            .Alignment     = 3
            .FontName      = "Courier New"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Sabados (crSigCdTom.MaxEnt2s - getMaxEnt2s)
        par_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH par_oPagina.lbl_4c_Label6
            .Caption   = "S" + CHR(225) + "bados :"
            .Top       = 471
            .Left      = 297
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_MaxEnt2s", "TextBox")
        WITH par_oPagina.txt_4c_MaxEnt2s
            .Top           = 468
            .Left          = 349
            .Width         = 38
            .Height        = 24
            .InputMask     = "9999"
            .Alignment     = 3
            .FontName      = "Courier New"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Domingos / Feriados (crSigCdTom.MaxEnt3s - getMaxEnt3s)
        par_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH par_oPagina.lbl_4c_Label7
            .Caption   = "Domigos / Feriados :"
            .Top       = 471
            .Left      = 432
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_MaxEnt3s", "TextBox")
        WITH par_oPagina.txt_4c_MaxEnt3s
            .Top           = 468
            .Left          = 547
            .Width         = 38
            .Height        = 24
            .InputMask     = "9999"
            .Alignment     = 3
            .FontName      = "Courier New"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Linha divisoria acima da secao "Geracao de Reposicao"
        par_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH par_oPagina.shp_4c_Shape2
            .Top           = 526
            .Left          = 54
            .Width         = 652
            .Height        = 2
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Geracao de Reposicao (titulo)
        par_oPagina.AddObject("lbl_4c_Say3", "Label")
        WITH par_oPagina.lbl_4c_Say3
            .Caption   = " Gera" + CHR(231) + CHR(227) + "o de Reposi" + CHR(231) + CHR(227) + "o "
            .Top       = 512
            .Left      = 54
            .Width     = 133
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 1
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Geracao de Reposicao (crSigCdTom.Reposicaos - optReposicaos - 8 opcoes)
        par_oPagina.AddObject("obj_4c_OptReposicaos", "OptionGroup")
        WITH par_oPagina.obj_4c_OptReposicaos
            .ButtonCount   = 8
            .Top           = 514
            .Left          = 54
            .Width         = 506
            .Height        = 62
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH par_oPagina.obj_4c_OptReposicaos.Buttons(1)
            .Caption   = "Nenhum"
            .Left      = 35
            .Top       = 19
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OptReposicaos.Buttons(2)
            .Caption   = "Solicitado"
            .Left      = 150
            .Top       = 19
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OptReposicaos.Buttons(3)
            .Caption   = "Tr" + CHR(226) + "nsito"
            .Left      = 282
            .Top       = 19
            .Width     = 57
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OptReposicaos.Buttons(4)
            .Caption   = "Pedido Geral"
            .Left      = 382
            .Top       = 19
            .Width     = 78
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OptReposicaos.Buttons(5)
            .Caption   = "Pedido Empresa"
            .Left      = 35
            .Top       = 39
            .Width     = 94
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OptReposicaos.Buttons(6)
            .Caption   = "Pedido de Compra"
            .Left      = 150
            .Top       = 39
            .Width     = 105
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OptReposicaos.Buttons(7)
            .Caption   = "Entrada"
            .Left      = 282
            .Top       = 39
            .Width     = 56
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH par_oPagina.obj_4c_OptReposicaos.Buttons(8)
            .Caption   = "Sa" + CHR(237) + "da"
            .Left      = 382
            .Top       = 39
            .Width     = 44
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

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
    * CarregarLista - Carrega dados no Grid da Page1
    * Chama TopBO.Buscar() e vincula cursor_4c_Dados ao grid
    * Colunas exibidas: codigos (Codigo) e descrs (Descricao), espelhando
    * o AddCursor/pColuna do legado (SigCdTom.SCX Init)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (codigos N(2,0), descrs C(30))
                SET NULL OFF
            ENDIF
            loc_lResultado = .T.
        ELSE
            TRY
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"

                    *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    loc_oGrid.Column1.Width     = 120
                    loc_oGrid.Column1.Alignment = 1
                    loc_oGrid.Column2.Width     = 770
                    loc_oGrid.Column2.Alignment = 0

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara o BO/Form para inclusao de novo registro
    * PUBLIC (sem PROTECTED) - obrigatorio para funcionar com BINDEVENT (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(THIS.this_cModoAtual)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega o registro selecionado na lista e habilita
    * edicao (Descricao + opcoes). Codigo permanece somente-leitura (legado
    * Get_Codigos.When = INSERIR/PROCURAR - nao inclui ALTERAR).
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista para alterar!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            MsgAviso("Selecione um registro na lista para alterar!")
            RETURN
        ENDIF
        loc_nCodigo = cursor_4c_Dados.codigos

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(THIS.this_cModoAtual)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega o registro selecionado em modo somente-leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista para visualizar!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            MsgAviso("Selecione um registro na lista para visualizar!")
            RETURN
        ENDIF
        loc_nCodigo = cursor_4c_Dados.codigos

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(THIS.this_cModoAtual)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o registro selecionado na lista (apos confirmar)
    * Legado (Click, 30 linhas): checagem de lAlts (registro automatico) esta
    * COMENTADA no codigo original (*!*), portanto NAO reproduzida aqui - a
    * exclusao vale para qualquer registro, igual ao comportamento legado ativo.
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCodigo, loc_cDescricao, loc_lConfirma, loc_lSucesso

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista para excluir!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            MsgAviso("Selecione um registro na lista para excluir!")
            RETURN
        ENDIF
        loc_nCodigo    = cursor_4c_Dados.codigos
        loc_cDescricao = ALLTRIM(cursor_4c_Dados.descrs)

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do Tipo de Opera" + CHR(231) + CHR(227) + "o " + ;
            TRANSFORM(loc_nCodigo) + " - " + loc_cDescricao + "?", ;
            "Confirma Exclus" + CHR(227) + "o")

        IF loc_lConfirma
            loc_lSucesso = .F.

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                loc_lSucesso = THIS.this_oBusinessObject.Excluir()
            ENDIF

            IF loc_lSucesso
                MsgExcluidoSucesso()
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere propriedades do TopBO para os controles da Page2
    * Mapeamento identico ao TopBO.CarregarDoCursor (comentado em cada linha
    * na AdicionarCamposPrincipais1/2)
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPg2.txt_4c_Codigos.Value       = .this_nCodigos
            loc_oPg2.txt_4c_Descrs.Value        = .this_cDescrs
            loc_oPg2.obj_4c_OpGdmi.Value        = .this_nGergdmis
            loc_oPg2.obj_4c_Fwoption8.Value     = .this_nGerVds
            loc_oPg2.obj_4c_OpSituacao.Value    = .this_nFlagpgs
            loc_oPg2.obj_4c_OptTpMercs.Value    = .this_nTpMercs
            loc_oPg2.obj_4c_ObjCancPdv.Value    = .this_nCancPeds
            loc_oPg2.obj_4c_Fwoption1.Value     = .this_nTpGdmis
            loc_oPg2.obj_4c_Fwoption3.Value     = .this_nAtuCompras
            loc_oPg2.obj_4c_Fwoption2.Value     = .this_nOpVlUnis
            loc_oPg2.obj_4c_Fwoption4.Value     = .this_nExibLims
            loc_oPg2.obj_4c_Fwoption6.Value     = .this_nBxVendas
            loc_oPg2.obj_4c_Fwoption5.Value     = .this_nChkSDFs
            loc_oPg2.obj_4c_GetEntPends.Value   = .this_nEntPends
            loc_oPg2.obj_4c_Fwoption7.Value     = .this_nFlxCaixa
            loc_oPg2.obj_4c_Fwoption9.Value     = .this_nGeraCmvs
            loc_oPg2.obj_4c_OptReposicaos.Value = .this_nReposicaos
            loc_oPg2.txt_4c_MaxEnts.Value       = .this_nMaxEnts
            loc_oPg2.txt_4c_MaxEnt2s.Value      = .this_nMaxEnt2s
            loc_oPg2.txt_4c_MaxEnt3s.Value      = .this_nMaxEnt3s
        ENDWITH
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere os controles da Page2 para as propriedades do TopBO
    * Mapeamento identico (invertido) ao BOParaForm. this_lLalts e
    * this_nOpIgnRelFc NAO sao tocados aqui - nao existem campo na tela
    * (this_lLalts e setado por TopBO.InicializarValoresPadrao/CarregarDoCursor;
    * this_nOpIgnRelFc mantem o valor carregado ou o default 0 do INCLUIR).
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_nCodigos    = loc_oPg2.txt_4c_Codigos.Value
            .this_cDescrs     = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
            .this_nGergdmis   = loc_oPg2.obj_4c_OpGdmi.Value
            .this_nGerVds     = loc_oPg2.obj_4c_Fwoption8.Value
            .this_nFlagpgs    = loc_oPg2.obj_4c_OpSituacao.Value
            .this_nTpMercs    = loc_oPg2.obj_4c_OptTpMercs.Value
            .this_nCancPeds   = loc_oPg2.obj_4c_ObjCancPdv.Value
            .this_nTpGdmis    = loc_oPg2.obj_4c_Fwoption1.Value
            .this_nAtuCompras = loc_oPg2.obj_4c_Fwoption3.Value
            .this_nOpVlUnis   = loc_oPg2.obj_4c_Fwoption2.Value
            .this_nExibLims   = loc_oPg2.obj_4c_Fwoption4.Value
            .this_nBxVendas   = loc_oPg2.obj_4c_Fwoption6.Value
            .this_nChkSDFs    = loc_oPg2.obj_4c_Fwoption5.Value
            .this_nEntPends   = loc_oPg2.obj_4c_GetEntPends.Value
            .this_nFlxCaixa   = loc_oPg2.obj_4c_Fwoption7.Value
            .this_nGeraCmvs   = loc_oPg2.obj_4c_Fwoption9.Value
            .this_nReposicaos = loc_oPg2.obj_4c_OptReposicaos.Value
            .this_nMaxEnts    = loc_oPg2.txt_4c_MaxEnts.Value
            .this_nMaxEnt2s   = loc_oPg2.txt_4c_MaxEnt2s.Value
            .this_nMaxEnt3s   = loc_oPg2.txt_4c_MaxEnt3s.Value
        ENDWITH
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes de Page1 conforme o modo
    * PUBLIC (sem PROTECTED) - TesteAutomatico.prg chama direto de fora da classe
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_lLista
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_lLista = (THIS.this_cModoAtual = "LISTA")

        TRY
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lLista
            loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lLista
        CATCH TO loException
            MostrarErro("Erro em FormTop.AjustarBotoesPorModo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e grava o registro (Confirmar)
    * Validacoes espelham comportamento.json (SIGCDTOP.Click, 32 linhas):
    *   - INCLUIR/ALTERAR: Codigos >= 90 -> bloqueia (limite de codigos do tipo)
    *   - INCLUIR: Codigos vazio -> bloqueia
    *   - INCLUIR: Descrs vazio -> bloqueia
    *   - INCLUIR: ChkRegister (duplicidade de codigo) -> bloqueia
    * PUBLIC (sem PROTECTED) - obrigatorio para funcionar com BINDEVENT (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_nCodigo, loc_cDescricao, loc_nChk

        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_nCodigo    = loc_oPagina.txt_4c_Codigos.Value
        loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)

        *-- Validacoes FORA do TRY (permitem RETURN direto)
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF loc_nCodigo >= 90
                MsgAviso("Os Tipos Devem Ser Cadastrados Com C" + CHR(243) + "digos Inferiores a 90!!!", "Campo Inv" + CHR(225) + "lido")
                loc_oPagina.txt_4c_Codigos.SetFocus
                RETURN
            ENDIF
        ENDIF

        IF THIS.this_cModoAtual = "INCLUIR"
            IF EMPTY(loc_nCodigo)
                MsgAviso("Tipo Inv" + CHR(225) + "lido !!!", "Campo Obrigat" + CHR(243) + "rio")
                loc_oPagina.txt_4c_Codigos.SetFocus
                RETURN
            ENDIF

            IF EMPTY(loc_cDescricao)
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
                loc_oPagina.txt_4c_Descrs.SetFocus
                RETURN
            ENDIF
        ENDIF

        TRY
            *-- Verificar duplicidade do codigo (apenas no INCLUIR) - espelha ChkRegister('SigCdTom',...)
            IF THIS.this_cModoAtual = "INCLUIR"
                loc_nChk = SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigCdTom WHERE codigos = " + ;
                    FormatarNumeroSQL(loc_nCodigo, 0), "cursor_4c_ChkCod")
                IF loc_nChk >= 0 AND RECCOUNT("cursor_4c_ChkCod") > 0
                    SELECT cursor_4c_ChkCod
                    IF cursor_4c_ChkCod.nExiste > 0
                        IF USED("cursor_4c_ChkCod")
                            USE IN cursor_4c_ChkCod
                        ENDIF
                        MsgAviso("C" + CHR(243) + "digo do Tipo de Opera" + CHR(231) + CHR(227) + "o j" + CHR(225) + " Cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
                        loc_oPagina.txt_4c_Codigos.SetFocus
                        RETURN
                    ENDIF
                ENDIF
                IF USED("cursor_4c_ChkCod")
                    USE IN cursor_4c_ChkCod
                ENDIF
            ENDIF

            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgSucesso("Tipo de Opera" + CHR(231) + CHR(227) + "o salvo com sucesso!")
                THIS.AlternarPagina(1)
                THIS.this_cModoAtual = "LISTA"
                THIS.AjustarBotoesPorModo()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormTop.BtnSalvarClick:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao/visualizacao e retorna para a lista
    * PUBLIC (sem PROTECTED) - TesteAutomatico.prg chama direto de fora da classe
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.AlternarPagina(1)
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        CATCH TO loException
            MostrarErro("Erro em FormTop.BtnCancelarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Procura um Tipo de Operacao por codigo/descricao e
    * posiciona o grid da lista no registro encontrado.
    * Legado (SIGCDTOP.Procedure, 23 linhas): SEEK direto no cursor local pelos
    * campos Get_Codigos/Get_Descrs. Aqui, mesma intencao via FormBuscaAuxiliar
    * (padrao unificado de lookup do novo sistema) + LOCATE no grid da lista.
    * PUBLIC (sem PROTECTED) - obrigatorio para funcionar com BINDEVENT (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo

        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTom", "cursor_4c_BuscaTop", "codigos", loc_cCodigo, ;
                "Buscar Tipo de Opera" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTop")
                    SELECT cursor_4c_BuscaTop
                    loc_cCodigo = ALLTRIM(TRANSFORM(cursor_4c_BuscaTop.codigos))

                    *-- Posicionar grid na linha correspondente
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(TRANSFORM(cursor_4c_Dados.codigos)) = loc_cCodigo
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaTop")
                USE IN cursor_4c_BuscaTop
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormTop.BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_BuscaTop")
                USE IN cursor_4c_BuscaTop
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC (sem PROTECTED) - obrigatorio para funcionar com BINDEVENT (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MostrarErro("Erro em FormTop.BtnEncerrarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparCampos - Reseta os controles da Page2 para os valores default
    * (mesmos defaults declarados em AdicionarCamposPrincipais1/2 na criacao)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigos.Value       = 0
        loc_oPg2.txt_4c_Descrs.Value        = ""
        loc_oPg2.obj_4c_OpGdmi.Value        = 5
        loc_oPg2.obj_4c_Fwoption8.Value     = 1
        loc_oPg2.obj_4c_OpSituacao.Value    = 3
        loc_oPg2.obj_4c_OptTpMercs.Value    = 1
        loc_oPg2.obj_4c_ObjCancPdv.Value    = 1
        loc_oPg2.obj_4c_Fwoption1.Value     = 1
        loc_oPg2.obj_4c_Fwoption3.Value     = 1
        loc_oPg2.obj_4c_Fwoption2.Value     = 1
        loc_oPg2.obj_4c_Fwoption4.Value     = 1
        loc_oPg2.obj_4c_Fwoption6.Value     = 1
        loc_oPg2.obj_4c_Fwoption5.Value     = 1
        loc_oPg2.obj_4c_GetEntPends.Value   = 1
        loc_oPg2.obj_4c_Fwoption7.Value     = 1
        loc_oPg2.obj_4c_Fwoption9.Value     = 1
        loc_oPg2.obj_4c_OptReposicaos.Value = 1
        loc_oPg2.txt_4c_MaxEnts.Value       = 0
        loc_oPg2.txt_4c_MaxEnt2s.Value      = 0
        loc_oPg2.txt_4c_MaxEnt3s.Value      = 0
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os controles da Page2 conforme o modo
    * Replica os eventos When/Procedure do legado (comportamento.json):
    *   Get_Codigos.When    -> INSERIR/PROCURAR (aqui: somente INCLUIR)
    *   Get_Descrs.When     -> INSERIR/ALTERAR
    *   Demais OptionGroups -> INSERIR/ALTERAR (Procedure "Inlist(pcEscolha,'INSERIR','ALTERAR')")
    * par_cModo: "INCLUIR", "ALTERAR" ou "VISUALIZAR"
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_cModo)
        LOCAL loc_oPg2, loc_lEditavel
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_lEditavel = INLIST(par_cModo, "INCLUIR", "ALTERAR")

        loc_oPg2.txt_4c_Codigos.Enabled = (par_cModo = "INCLUIR")
        loc_oPg2.txt_4c_Descrs.Enabled  = loc_lEditavel

        loc_oPg2.obj_4c_OpGdmi.Enabled        = loc_lEditavel
        loc_oPg2.obj_4c_Fwoption8.Enabled     = loc_lEditavel
        loc_oPg2.obj_4c_OpSituacao.Enabled    = loc_lEditavel
        loc_oPg2.obj_4c_OptTpMercs.Enabled    = loc_lEditavel
        loc_oPg2.obj_4c_ObjCancPdv.Enabled    = loc_lEditavel
        loc_oPg2.obj_4c_Fwoption1.Enabled     = loc_lEditavel
        loc_oPg2.obj_4c_Fwoption3.Enabled     = loc_lEditavel
        loc_oPg2.obj_4c_Fwoption2.Enabled     = loc_lEditavel
        loc_oPg2.obj_4c_Fwoption4.Enabled     = loc_lEditavel
        loc_oPg2.obj_4c_Fwoption6.Enabled     = loc_lEditavel
        loc_oPg2.obj_4c_Fwoption5.Enabled     = loc_lEditavel
        loc_oPg2.obj_4c_GetEntPends.Enabled   = loc_lEditavel
        loc_oPg2.obj_4c_Fwoption7.Enabled     = loc_lEditavel
        loc_oPg2.obj_4c_Fwoption9.Enabled     = loc_lEditavel
        loc_oPg2.obj_4c_OptReposicaos.Enabled = loc_lEditavel
        loc_oPg2.txt_4c_MaxEnts.Enabled       = loc_lEditavel
        loc_oPg2.txt_4c_MaxEnt2s.Enabled      = loc_lEditavel
        loc_oPg2.txt_4c_MaxEnt3s.Enabled      = loc_lEditavel

        *-- Confirmar so fica habilitado quando ha algo para gravar (INCLUIR/ALTERAR)
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditavel OR (THIS.this_cModoAtual = "EXCLUIR")
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
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
    * FormatarGridLista - Formata visual do grid da lista
    * Fonte Verdana (padrao do framework Grade), tamanho 8
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos do formulario
    *===========================================================================
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

        IF USED("cursor_4c_ChkCod")
            USE IN cursor_4c_ChkCod
        ENDIF

        IF USED("cursor_4c_BuscaTop")
            USE IN cursor_4c_BuscaTop
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
