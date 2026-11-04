*******************************************************************************
* Formmtz.prg - Cadastro: Matriz de Saldos por Centro de Custo
* Legado  : SIGCDMTZ.SCX / frmcadastro
* Tabelas : SigCdMtz (cabecalho) + SigCdMtI (linhas mensais)
* Herda de: FormBase
*******************************************************************************

DEFINE CLASS Formmtz AS FormBase

    *-- =========================================================================
    *-- PROPRIEDADES VISUAIS (PILAR 1 - UX fidelity)
    *-- =========================================================================
    Height      = 600
    Width       = 1105
    Caption     = "Matriz de Saldos por Centro de Custo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    MinButton   = .F.
    MaxButton   = .F.

    *-- =========================================================================
    *-- PROPRIEDADES DO FORM
    *-- =========================================================================
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    *-- Guarda de reentrancia dos lookups abertos de LostFocus (regra #37, Erro195)
    this_lEmLookup = .F.
    *-- Guarda do ValidarAnoMtz: o SetFocus redispara o proprio LostFocus (Erro297)
    this_lEmValidacaoAno = .F.

    *-- =========================================================================
    *-- INIT - Apenas DODEFAULT (FormBase.Init chama InicializarForm)
    *-- =========================================================================

    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- INICIALIZAR FORM - Chamado pelo FormBase.Init()
    *-- =========================================================================

    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Instancia o Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("mtzBO")

            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao instanciar mtzBO", "Formmtz.InicializarForm")
                loc_lResultado = .F.
            ENDIF

            *-- Configura estrutura de paginas
            THIS.ConfigurarPageFrame()
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Carrega lista inicial (pula se validando UI)
            IF TYPE("gb_4c_ValidandoUI") # "L" OR !gb_4c_ValidandoUI
                THIS.CarregarLista()
            ENDIF

            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- CONFIGURAR PAGE FRAME - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *-- =========================================================================

    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Cria PageFrame principal
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .Tabs       = .F.
            .Visible    = .T.

            *-- Imagens de fundo nas duas paginas
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            .Page1.Caption = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        *-- Configura cada pagina
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *-- =========================================================================
    *-- CONFIGURAR PAGINA LISTA (Page1) - Cabecalho + Botoes CRUD + area grid
    *-- =========================================================================

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *--------------------------------------------------------------------------
        *-- Container cabecalho (fundo escuro com titulo)
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            *-- Legado: Pagina.Lista.cntSombra.Top = 1 (+29 do PageFrame.Top = -29)
            *-- Canonico (regra #11 / FormCor / Formcfo): Top = 31. Top = 2 deixava a
            *-- faixa em -27 na tela e cortava o titulo pela metade.
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
            .Caption   = "Matriz de Saldos por Centro de Custo"
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Matriz de Saldos por Centro de Custo"
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Container botoes CRUD (lado direito)
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            *-- Legado: Pagina.Lista.Grupo_op.Top = -1 / Width = 385
            *-- Canonico: Top = 29 (Top = 0 jogava os botoes para -29 e cortava o topo).
            *-- Width 390 para o container nao invadir o cnt_4c_Saida (Left = 917).
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
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

        *-- Botao Visualizar
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

        *-- Botao Alterar
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

        *-- Botao Excluir
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

        *-- Botao Buscar
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

        *--------------------------------------------------------------------------
        *-- Container Saida (canonico: Left=917, Width=90)
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            *-- Canonico: container de saida eh FLUTUANTE/TRANSPARENTE sobre a faixa.
            *-- BackStyle = 1 branco pintava um retangulo branco por cima do cinza.
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

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

        *--------------------------------------------------------------------------
        *-- Grid lista de matrizes - cursor_4c_Dados
        *-- Legado: Pagina.Lista.Grade Top=121 (+29) Left=11 Width=1044 Height=475
        *--         Tahoma 8, RowHeight 16, ForeColor 90,90,90
        *-- Colunas: 6, conforme pColuna() do Init legado (NAO ha coluna "Valida"
        *-- na pagina Lista - regra #35b). Caption/Width sao aplicados em
        *-- VincularGradeLista(), DEPOIS do RecordSource (regra #35c).
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 6

        WITH loc_oPagina.grd_4c_Lista
            .Top                = 150
            .Left               = 11
            .Width              = 1044
            .Height             = 475
            .FontName           = "Tahoma"
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

        *-- Vincular eventos da Page1
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *-- =========================================================================
    *-- CONFIGURAR PAGINA DADOS (Page2) - Cabecalho fields + Grid mensal + Botoes Salvar/Cancelar
    *-- =========================================================================

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
        *-- conteudo da pagina deslocado +41 para nao ficar sob a faixa
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


        *--------------------------------------------------------------------------
        *-- Container botoes Salvar/Cancelar (lado direito topo)
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            *-- Erro299: Top = 33 deixava o botao em 9..84 na tela, com a faixa
            *-- da Dados em 0..80 - 9px de folga em cima e 4px TRANSBORDANDO por
            *-- baixo da faixa, invadindo a linha do Codigo. A faixa da Dados
            *-- comeca em 29 (e nao em 31 como a da Lista, porque aqui o fundo
            *-- dela tem de encostar em 109, onde comeca a 1a linha de campos),
            *-- entao o alinhamento se acerta no Top do BOTAO, abaixo.
            *-- Top = 29, igual ao cnt_4c_Saida da Lista.
            .Top         = 29
            .Left        = 842
            .Width       = 160
            .Height      = 85
            *-- Erro298: com BackStyle = 1 branco o container pintava um
            *-- retangulo por cima da faixa cinza e "cortava" a borda escura
            *-- superior. O container de botoes eh FLUTUANTE/TRANSPARENTE sobre
            *-- a faixa (igual ao cnt_4c_Saida da Lista e ao Formcfo); quem tem
            *-- fundo branco sao os botoes, nao a caixa.
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salvar)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            *-- Top = 3 (e nao os 5 canonicos): a faixa da Dados fica 2px mais
            *-- alta que a da Lista, entao 3 reproduz a MESMA folga visual da
            *-- Lista - 3px de cinza acima do botao e 2px abaixo (Erro299).
            .Top             = 3
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

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 3     && mesma folga do cmd_4c_Confirmar (Erro299)
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

        *--------------------------------------------------------------------------
        *-- Label "Codigo :" + TextBox Codigo (getCodigo)
        *-- Original: lbl_grupo.Top=43,Left=334 / getCodigo.Top=39,Left=382
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_grupo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 113
            .Left      = 334
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Format = "K!"
            .MaxLength = 10
            .Top       = 109
            .Left      = 382
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- CheckBox "Inativa" (Check1)
        *-- Original: Top=43, Left=440
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("chk_4c_Inativa", "CheckBox")
        WITH loc_oPagina.chk_4c_Inativa
            .Caption   = "Inativa"
            .Value     = 0
            .Top       = 113
            .Left      = 440
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Label "Moeda :" + TextBox Moeda (getMoeda)
        *-- Original: Say2.Top=43,Left=718 / getMoeda.Top=39,Left=764
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Moeda :"
            .Top       = 113
            .Left      = 718
            .Width     = 41
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPagina.txt_4c_Moeda
            .Value     = ""
            .Format = "K!"
            .MaxLength = 3
            .Top       = 109
            .Left      = 764
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Label "Ano Competencia :" + TextBox Ano (getAno)
        *-- Original: lbl_Ano.Top=70,Left=283 / getAno.Top=66,Left=382
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_Ano", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_Ano
            .Caption   = "Ano Compet" + CHR(234) + "ncia :"
            .Top       = 140
            .Left      = 283
            .Width     = 93
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ano", "TextBox")
        *-- Legado getAno: Alignment=3, Format="K!", MaxLength=4, SpecialEffect=1
        WITH loc_oPagina.txt_4c_Ano
            .Value     = ""
            .Format = "K!"
            .MaxLength = 4
            .Alignment     = 3
            .SpecialEffect = 1
            .Top       = 136
            .Left      = 382
            .Width     = 51
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Label "Valor Acumulado :" + TextBox ValorTotal (readonly/calculado)
        *-- Original: Say1.Top=70,Left=671 / getValorTotal.Top=66,Left=764
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Valor Acumulado :"
            .Top       = 140
            .Left      = 671
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ValorTotal", "TextBox")
        WITH loc_oPagina.txt_4c_ValorTotal
            .Value     = 0
            .Top       = 136
            .Left      = 764
            .Width     = 108
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- "Centro de Custo :" + Grupo + "/" + Conta + Desc + Class3
        *-- Original: lblCentroCusto.Top=97,Left=288 / Get_sgrupo.Top=93,Left=382
        *--   Say14("/").Top=97,Left=466 / Get_sconta.Top=93,Left=473
        *--   Get_sdconta.Top=93,Left=554,Width=290 / Get_class3.Top=93,Left=845
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_LblCentroCusto", "Label")
        WITH loc_oPagina.lbl_4c_LblCentroCusto
            .Caption   = "Centro de Custo :"
            .Top       = 167
            .Left      = 288
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Sgrupo", "TextBox")
        WITH loc_oPagina.txt_4c_Sgrupo
            .Value     = ""
            .MaxLength = 10
            .Top       = 163
            .Left      = 382
            .Width     = 82
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = "/"
            .Top       = 167
            .Left      = 466
            .Width     = 10
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Sconta", "TextBox")
        WITH loc_oPagina.txt_4c_Sconta
            .Value     = ""
            .MaxLength = 20
            .Top       = 163
            .Left      = 473
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Sdconta", "TextBox")
        WITH loc_oPagina.txt_4c_Sdconta
            .Value     = ""
            .Top       = 163
            .Left      = 554
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Class3", "TextBox")
        WITH loc_oPagina.txt_4c_Class3
            .Value     = ""
            .MaxLength = 3
            .Top       = 163
            .Left      = 845
            .Width     = 27
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- getSaldo - exibe total saldo do registro (readonly, acima do grid)
        *-- Original: getSaldo.Top=109, Left=11, Width=100, Height=17
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Saldo", "TextBox")
        WITH loc_oPagina.txt_4c_Saldo
            .Value     = 0
            .Top       = 179
            .Left      = 11
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Grade grd_4c_Dados (grdSaldos) - 28 colunas
        *-- Original: grdSaldos.Top=129, Left=11, Width=1045, Height=419
        *--------------------------------------------------------------------------
        LOCAL loc_oGrid
        loc_oGrid = .NULL.

        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            *-- Erro298: a grade era o UNICO controle da pagina ainda em +29
            *-- (129+29=158) enquanto todo o bloco de campos levou +70 (+29 do
            *-- PageFrame +41 para sair de baixo da faixa). Resultado: a grade
            *-- comecava em 158 e COBRIA a linha "Centro de Custo :" (Grupo /
            *-- Conta / Descricao / Classe, Top = 163) e o getSaldo (179) - o
            *-- usuario nao via nem conseguia preencher o Grupo, e o Salvar
            *-- acusava "Grupo e obrigatorio" (regra #39).
            *-- Top = 129+70. Height encolhe os mesmos 41 porque a grade eh
            *-- controle FOLHA e o rodape (Top = 582) nao se mexe (regra #11):
            *-- 199+378 = 577, logo abaixo do "Data / Usuario".
            .Top         = 199     && 129+70
            .Left        = 11
            .Width       = 1045
            .Height      = 378     && 419-41 (encolhe no rodape, regra #11)
            .ColumnCount = 28
            .ReadOnly    = .T.     && HabilitarCampos gerencia
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Visible     = .T.
            *-- Legado: RecordMark = .T. / DeleteMark = .F. / ScrollBars = 3 /
            *-- RowHeight = 16 / GridLineColor = 238,238,238
            .RecordMark    = .T.
            .DeleteMark    = .F.
            .ScrollBars    = 3
            .RowHeight     = 16
            .GridLineColor = RGB(238, 238, 238)
        ENDWITH

        loc_oGrid = loc_oPagina.grd_4c_Dados

        *-- Coluna 1 - Grupos
        WITH loc_oGrid.Column1
            .Header1.Caption = "Grupo"
            .Width           = 90
        ENDWITH

        *-- Coluna 2 - Contas
        WITH loc_oGrid.Column2
            .Header1.Caption = "Conta"
            .Width           = 90
        ENDWITH

        *-- Coluna 3 - Janeiro
        WITH loc_oGrid.Column3
            .Header1.Caption = "Janeiro"
            .Width           = 85
        ENDWITH

        *-- Coluna 4 - Fevereiro
        WITH loc_oGrid.Column4
            .Header1.Caption = "Fevereiro"
            .Width           = 85
        ENDWITH

        *-- Coluna 5 - Marco
        WITH loc_oGrid.Column5
            .Header1.Caption = "Mar" + CHR(231) + "o"
            .Width           = 85
        ENDWITH

        *-- Coluna 6 - Abril
        WITH loc_oGrid.Column6
            .Header1.Caption = "Abril"
            .Width           = 85
        ENDWITH

        *-- Coluna 7 - Maio
        WITH loc_oGrid.Column7
            .Header1.Caption = "Maio"
            .Width           = 85
        ENDWITH

        *-- Coluna 8 - Junho
        WITH loc_oGrid.Column8
            .Header1.Caption = "Junho"
            .Width           = 85
        ENDWITH

        *-- Coluna 9 - Julho
        WITH loc_oGrid.Column9
            .Header1.Caption = "Julho"
            .Width           = 85
        ENDWITH

        *-- Coluna 10 - Agosto
        WITH loc_oGrid.Column10
            .Header1.Caption = "Agosto"
            .Width           = 85
        ENDWITH

        *-- Coluna 11 - Setembro
        WITH loc_oGrid.Column11
            .Header1.Caption = "Setembro"
            .Width           = 85
        ENDWITH

        *-- Coluna 12 - Outubro
        WITH loc_oGrid.Column12
            .Header1.Caption = "Outubro"
            .Width           = 85
        ENDWITH

        *-- Coluna 13 - Novembro
        WITH loc_oGrid.Column13
            .Header1.Caption = "Novembro"
            .Width           = 85
        ENDWITH

        *-- Coluna 14 - Dezembro
        WITH loc_oGrid.Column14
            .Header1.Caption = "Dezembro"
            .Width           = 85
        ENDWITH

        *-- Coluna 15 - Total (calculado, readonly)
        WITH loc_oGrid.Column15
            .Header1.Caption = "Total"
            .Width           = 90
            .ReadOnly        = .T.
        ENDWITH

        *-- Colunas 16-27: Acumulados mensais (readonly)
        WITH loc_oGrid.Column16
            .Header1.Caption = "Janeiro"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column17
            .Header1.Caption = "Fevereiro"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column18
            .Header1.Caption = "Mar" + CHR(231) + "o"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column19
            .Header1.Caption = "Abril"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column20
            .Header1.Caption = "Maio"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column21
            .Header1.Caption = "Junho"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column22
            .Header1.Caption = "Julho"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column23
            .Header1.Caption = "Agosto"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column24
            .Header1.Caption = "Setembro"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column25
            .Header1.Caption = "Outubro"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column26
            .Header1.Caption = "Novembro"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        WITH loc_oGrid.Column27
            .Header1.Caption = "Dezembro"
            .Width           = 85
            .ReadOnly        = .T.
        ENDWITH

        *-- Coluna 28 - Valida (CheckBox)
        *-- Legado: Column28.Width = 43 / Sparse = .F. / CurrentControl = "Check1"
        WITH loc_oGrid.Column28
            .Header1.Caption = "Valida"
            .Width           = 43
            .Sparse          = .F.
        ENDWITH

        *-- A instalacao mora num metodo proprio e IDEMPOTENTE porque fechar o
        *-- alias do grid destroi as Columns (ver InstalarCelulaValida).
        THIS.InstalarCelulaValida(loc_oGrid)

        *--------------------------------------------------------------------------
        *-- Container botoes Inserir/Excluir linha (cmdInsFtc)
        *-- Original: cmdInsFtc.Top=253, Left=1055, Width=50, Height=90
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_InsFtc", "Container")
        WITH loc_oPagina.cnt_4c_InsFtc
            *-- Mesmo deslocamento da grade, para os botoes manterem a posicao
            *-- relativa as linhas dela (legado: cmdInsFtc.Top = 253).
            .Top         = 323     && 253+70
            .Left        = 1055
            .Width       = 45
            .Height      = 90
            *-- Legado declara EXPLICITAMENTE cmdInsFtc.BackStyle = 0 /
            *-- BorderStyle = 0: o grupo eh transparente, sem caixa branca.
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_InsFtc.AddObject("cmd_4c_InserirLinha", "CommandButton")
        WITH loc_oPagina.cnt_4c_InsFtc.cmd_4c_InserirLinha
            .Caption       = "+"
            .Top           = 5
            .Left          = 2
            .Width         = 40
            .Height        = 36
            .FontName      = "Tahoma"
            .FontSize      = 12
            .FontBold      = .T.
            .ForeColor     = RGB(0, 128, 0)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_InsFtc.AddObject("cmd_4c_ExcluirLinha", "CommandButton")
        WITH loc_oPagina.cnt_4c_InsFtc.cmd_4c_ExcluirLinha
            .Caption       = "-"
            .Top           = 49
            .Left          = 2
            .Width         = 40
            .Height        = 36
            .FontName      = "Tahoma"
            .FontSize      = 14
            .FontBold      = .T.
            .ForeColor     = RGB(192, 0, 0)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Shape separador (Shape3)
        *-- Original: Shape3.Top=569, Left=5, Width=504, Height=2
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top         = 598     && 569+29
            .Left        = 5
            .Width       = 504
            .Height      = 2
            .BackStyle   = 1
            .BackColor   = RGB(128, 128, 128)
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Campos de Auditoria (readonly)
        *-- Original: Say20.Top=553, Say24/Say25.Top=578, Get_DtIncs/etc.Top=574
        *--------------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPagina.lbl_4c_Label20
            .Caption   = "Data / Usu" + CHR(225) + "rio"
            .Top       = 582     && 553+29
            .Left      = 11
            .Width     = 84
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPagina.lbl_4c_Label24
            .Caption   = "Inclus" + CHR(227) + "o :"
            .Top       = 607     && 578+29
            .Left      = 10
            .Width     = 49
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtIncs", "TextBox")
        WITH loc_oPagina.txt_4c_DtIncs
            .Value     = {}
            .Top       = 603     && 574+29
            .Left      = 67
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
        WITH loc_oPagina.txt_4c_Usuario
            .Value     = ""
            .MaxLength = 20
            .Top       = 603     && 574+29
            .Left      = 148
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPagina.lbl_4c_Label25
            .Caption   = "Altera" + CHR(231) + CHR(227) + "o :"
            .Top       = 607     && 578+29
            .Left      = 251
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DataAlts", "TextBox")
        WITH loc_oPagina.txt_4c_DataAlts
            .Value     = {}
            .Top       = 603     && 574+29
            .Left      = 319
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_UsuaAlts", "TextBox")
        WITH loc_oPagina.txt_4c_UsuaAlts
            .Value     = ""
            .MaxLength = 20
            .Top       = 603     && 574+29
            .Left      = 400
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Vincular eventos Page2 (botoes Salvar/Cancelar)
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Vincular validacao/lookup campos header
        *-- Legado valida no getAno.Valid, ou seja ao SAIR do campo. Ligado a
        *-- "KeyPress" a mensagem saltava a CADA TECLA e o usuario nao conseguia
        *-- terminar de digitar o ano (Erro297 / regra #47).
        BINDEVENT(loc_oPagina.txt_4c_Ano,    "LostFocus", THIS, "ValidarAnoMtz")
        BINDEVENT(loc_oPagina.txt_4c_Sgrupo, "LostFocus", THIS, "ValidarGrupoMtz")
        BINDEVENT(loc_oPagina.txt_4c_Sconta, "LostFocus", THIS, "ValidarContaMtz")
        BINDEVENT(loc_oPagina.txt_4c_Moeda,  "LostFocus", THIS, "ValidarMoedaMtz")
        BINDEVENT(loc_oPagina.txt_4c_Sgrupo, "KeyPress",  THIS, "TeclaF4Sgrupo")
        BINDEVENT(loc_oPagina.txt_4c_Sconta, "KeyPress",  THIS, "TeclaF4Sconta")
        BINDEVENT(loc_oPagina.txt_4c_Moeda,  "KeyPress",  THIS, "TeclaF4Moeda")

        *-- Vincular eventos da grade e botoes de linha
        BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
        BINDEVENT(loc_oPagina.cnt_4c_InsFtc.cmd_4c_InserirLinha, "Click", THIS, "BtnInserirLinhaClick")
        BINDEVENT(loc_oPagina.cnt_4c_InsFtc.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *-- =========================================================================
    *-- VINCULAR GRADE LISTA - Funil unico de bind da grade da Page1
    *-- Ordem obrigatoria (regra #35c / FormCor): ColumnCount -> RecordSource ->
    *-- ControlSource -> Width -> Header1.Caption. RecordSource RESETA Width e
    *-- Caption, por isso os dois vem no fim.
    *-- Colunas e larguras transcritas do pColuna() do Init legado.
    *-- =========================================================================

    PROCEDURE VincularGradeLista()
        LOCAL loc_oGrid, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF VARTYPE(loc_oGrid) = "O" AND USED("cursor_4c_Dados")
                loc_oGrid.ColumnCount  = 6
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigo"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Ano"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.sGrupos"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sContas"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.sDContas"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Moeda"

                loc_oGrid.Column1.Width = 80
                loc_oGrid.Column2.Width = 80
                loc_oGrid.Column3.Width = 100
                loc_oGrid.Column4.Width = 100
                loc_oGrid.Column5.Width = 250
                loc_oGrid.Column6.Width = 60

                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Ano"
                loc_oGrid.Column3.Header1.Caption = "Grupo"
                loc_oGrid.Column4.Header1.Caption = "Conta"
                loc_oGrid.Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column6.Header1.Caption = "Moeda"

                THIS.FormatarGridLista(loc_oGrid)

                *-- Popular cursor NAO repinta a grade (regra #21a)
                SELECT cursor_4c_Dados
                GO TOP
                loc_oGrid.Refresh()

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.VincularGradeLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- CARREGAR LISTA - Carrega cursor_4c_Dados no Grid da Page1
    *-- =========================================================================

    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (Codigo C(3), Ano C(4), sGrupos C(10), sContas C(10), sDContas C(80), Moeda C(4), Inativas L)
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = THIS.VincularGradeLista()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- ALTERNAR PAGINA - Navega entre Page1 (1=Lista) e Page2 (2=Dados)
    *-- =========================================================================

    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) # "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- FORM PARA BO - Transfere dados do Form para o BO
    *-- =========================================================================

    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            THIS.this_oBusinessObject.this_cCodigo   = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
            THIS.this_oBusinessObject.this_cAno      = ALLTRIM(loc_oPagina.txt_4c_Ano.Value)
            THIS.this_oBusinessObject.this_cSGrupos  = ALLTRIM(loc_oPagina.txt_4c_Sgrupo.Value)
            THIS.this_oBusinessObject.this_cSContas  = ALLTRIM(loc_oPagina.txt_4c_Sconta.Value)
            THIS.this_oBusinessObject.this_cMoeda    = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)
            THIS.this_oBusinessObject.this_lInativas = (loc_oPagina.chk_4c_Inativa.Value = 1)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BO PARA FORM - Transfere dados do BO para o Form
    *-- =========================================================================

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            loc_oPagina.txt_4c_Codigo.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
            loc_oPagina.txt_4c_Ano.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cAno)
            loc_oPagina.txt_4c_Sgrupo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cSGrupos)
            loc_oPagina.txt_4c_Sconta.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cSContas)
            loc_oPagina.txt_4c_Sdconta.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cSDesconta)
            loc_oPagina.txt_4c_Moeda.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cMoeda)
            loc_oPagina.chk_4c_Inativa.Value    = IIF(THIS.this_oBusinessObject.this_lInativas, 1, 0)
            loc_oPagina.txt_4c_ValorTotal.Value = THIS.this_oBusinessObject.this_nValorTotal

            *-- Datas auditoria (readonly)
            IF !EMPTY(THIS.this_oBusinessObject.this_tDtIncs)
                loc_oPagina.txt_4c_DtIncs.Value  = THIS.this_oBusinessObject.this_tDtIncs
            ENDIF
            IF !EMPTY(THIS.this_oBusinessObject.this_cUsuIncs)
                loc_oPagina.txt_4c_Usuario.Value = ALLTRIM(THIS.this_oBusinessObject.this_cUsuIncs)
            ENDIF
            IF !EMPTY(THIS.this_oBusinessObject.this_tDtAlts)
                loc_oPagina.txt_4c_DataAlts.Value = THIS.this_oBusinessObject.this_tDtAlts
            ENDIF
            IF !EMPTY(THIS.this_oBusinessObject.this_cUsuAlts)
                loc_oPagina.txt_4c_UsuaAlts.Value = ALLTRIM(THIS.this_oBusinessObject.this_cUsuAlts)
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- LIMPAR CAMPOS - Zera todos os campos da Page2
    *-- =========================================================================

    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            loc_oPagina.txt_4c_Codigo.Value     = ""
            loc_oPagina.txt_4c_Ano.Value         = ""
            loc_oPagina.txt_4c_Sgrupo.Value      = ""
            loc_oPagina.txt_4c_Sconta.Value      = ""
            loc_oPagina.txt_4c_Sdconta.Value     = ""
            loc_oPagina.txt_4c_Moeda.Value       = ""
            loc_oPagina.txt_4c_ValorTotal.Value  = 0
            loc_oPagina.chk_4c_Inativa.Value      = 0
            loc_oPagina.txt_4c_DtIncs.Value      = {}
            loc_oPagina.txt_4c_Usuario.Value     = ""
            loc_oPagina.txt_4c_DataAlts.Value    = {}
            loc_oPagina.txt_4c_UsuaAlts.Value    = ""

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.LimparCampos")
        ENDTRY
    ENDPROC

    *-- =========================================================================
    *-- HABILITAR CAMPOS - Habilita/desabilita campos editaveis por modo
    *-- =========================================================================

    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lEdicao

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_lEdicao = par_lHabilitar AND THIS.this_cModoAtual # "VISUALIZAR"

            *-- Codigo: editavel apenas no INCLUIR
            loc_oPagina.txt_4c_Codigo.Enabled  = (THIS.this_cModoAtual = "INCLUIR")
            loc_oPagina.txt_4c_Codigo.ReadOnly = (THIS.this_cModoAtual # "INCLUIR")

            *-- Campos editaveis em INCLUIR e ALTERAR
            loc_oPagina.txt_4c_Ano.Enabled      = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
            loc_oPagina.txt_4c_Ano.ReadOnly     = !(THIS.this_cModoAtual = "INCLUIR")
            loc_oPagina.txt_4c_Sgrupo.Enabled   = loc_lEdicao
            loc_oPagina.txt_4c_Sgrupo.ReadOnly  = !loc_lEdicao
            loc_oPagina.txt_4c_Sconta.Enabled   = loc_lEdicao
            loc_oPagina.txt_4c_Sconta.ReadOnly  = !loc_lEdicao
            loc_oPagina.txt_4c_Moeda.Enabled    = loc_lEdicao
            loc_oPagina.txt_4c_Moeda.ReadOnly   = !loc_lEdicao
            loc_oPagina.chk_4c_Inativa.Enabled   = loc_lEdicao

            *-- Grade de saldos: editavel em INCLUIR e ALTERAR
            IF VARTYPE(loc_oPagina.grd_4c_Dados) = "O"
                loc_oPagina.grd_4c_Dados.ReadOnly = !loc_lEdicao
            ENDIF

            *-- Botoes Confirmar/Cancelar
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = par_lHabilitar

            *-- Campos readonly sempre
            loc_oPagina.txt_4c_Sdconta.ReadOnly    = .T.
            loc_oPagina.txt_4c_ValorTotal.ReadOnly = .T.
            loc_oPagina.txt_4c_DtIncs.ReadOnly     = .T.
            loc_oPagina.txt_4c_Usuario.ReadOnly     = .T.
            loc_oPagina.txt_4c_DataAlts.ReadOnly   = .T.
            loc_oPagina.txt_4c_UsuaAlts.ReadOnly   = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.HabilitarCampos")
        ENDTRY
    ENDPROC

    *-- =========================================================================
    *-- AJUSTAR BOTOES POR MODO
    *-- =========================================================================

    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            IF THIS.this_cModoAtual = "VISUALIZAR"
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ELSE
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *-- =========================================================================
    *-- BTN INCLUIR CLICK
    *-- =========================================================================

    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                THIS.LimparCampos()
                THIS.this_cModoAtual = "INCLUIR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPaginaDados()
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.NovoRegistro()
                loc_lResultado = .F.
            ELSE
                THIS.LimparCampos()
                THIS.this_cModoAtual = "INCLUIR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.this_oBusinessObject.CriarCursorDetalheVazio(THIS.this_oBusinessObject.this_cCodigo)
                THIS.AlternarGradeDetalhe()
                THIS.AlternarPaginaDados()
                loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN VISUALIZAR CLICK
    *-- =========================================================================

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.this_oBusinessObject.CarregarDetalhe(loc_cCodigo)
                THIS.AlternarGradeDetalhe()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPaginaDados()
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN ALTERAR CLICK
    *-- =========================================================================

    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.this_oBusinessObject.CarregarDetalhe(loc_cCodigo)
                THIS.AlternarGradeDetalhe()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPaginaDados()
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN EXCLUIR CLICK
    *-- =========================================================================

    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigo)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da Matriz " + loc_cCodigo + "?", "Excluir")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
                    THIS.CarregarLista()
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN BUSCAR CLICK
    *-- =========================================================================

    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMtz", "cursor_4c_BuscaMtz", "Codigo", "", ;
                "Buscar Matriz de Saldos")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigo", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Ano",    "", "Ano")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtz")
                    SELECT cursor_4c_BuscaMtz
                    IF !EOF()
                        THIS.this_oBusinessObject.Buscar( ;
                            "a.Codigo = " + EscaparSQL(ALLTRIM(cursor_4c_BuscaMtz.Codigo)))
                        THIS.VincularGradeLista()
                    ENDIF
                ENDIF

                loc_oBusca.Release()
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaMtz")
            USE IN cursor_4c_BuscaMtz
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN ENCERRAR CLICK
    *-- =========================================================================

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *-- =========================================================================
    *-- BTN SALVAR CLICK
    *-- =========================================================================

    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- Validacoes fora do TRY (CLAUDE.md regra #1)
        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value))
            MsgAviso("Ano de Compet" + CHR(234) + "ncia " + CHR(233) + " obrigat" + CHR(243) + "rio.")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value))
            MsgAviso("Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.SetFocus()
            RETURN .F.
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarDuplicatas()
            RETURN .F.
        ENDIF

        TRY
            IF THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Registro salvo com sucesso.")
                    THIS.AlternarPagina(1)
                    THIS.this_cModoAtual = "LISTA"
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN CANCELAR CLICK
    *-- =========================================================================

    PROCEDURE BtnCancelarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.AlternarPagina(1)
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnCancelarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- ALTERNAR PAGINA DADOS - Navega para Page2 sem recarregar lista
    *-- =========================================================================

    PROTECTED PROCEDURE AlternarPaginaDados()
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *-- =========================================================================
    *-- ALTERNAR GRADE DETALHE - Vincula cursor_4c_MtI ao grid da Page2
    *-- (sera completado na Fase 4 quando o grid for criado)
    *-- =========================================================================

    PROTECTED PROCEDURE AlternarGradeDetalhe()
        LOCAL loc_oGrid, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
            IF VARTYPE(loc_oGrid) = "O" AND USED("cursor_4c_MtI")
                loc_oGrid.ColumnCount = 28
                loc_oGrid.RecordSource = "cursor_4c_MtI"

                *-- Wires ControlSources apos RecordSource estar definido
                loc_oGrid.Column1.ControlSource  = "cursor_4c_MtI.Grupos"
                loc_oGrid.Column2.ControlSource  = "cursor_4c_MtI.Contas"
                loc_oGrid.Column3.ControlSource  = "cursor_4c_MtI.Val_Jan"
                loc_oGrid.Column4.ControlSource  = "cursor_4c_MtI.Val_Fev"
                loc_oGrid.Column5.ControlSource  = "cursor_4c_MtI.Val_Mar"
                loc_oGrid.Column6.ControlSource  = "cursor_4c_MtI.Val_Abr"
                loc_oGrid.Column7.ControlSource  = "cursor_4c_MtI.Val_Mai"
                loc_oGrid.Column8.ControlSource  = "cursor_4c_MtI.Val_Jun"
                loc_oGrid.Column9.ControlSource  = "cursor_4c_MtI.Val_Jul"
                loc_oGrid.Column10.ControlSource = "cursor_4c_MtI.Val_Ago"
                loc_oGrid.Column11.ControlSource = "cursor_4c_MtI.Val_Set"
                loc_oGrid.Column12.ControlSource = "cursor_4c_MtI.Val_Out"
                loc_oGrid.Column13.ControlSource = "cursor_4c_MtI.Val_Nov"
                loc_oGrid.Column14.ControlSource = "cursor_4c_MtI.Val_Dez"
                loc_oGrid.Column15.ControlSource = "cursor_4c_MtI.Total"
                loc_oGrid.Column16.ControlSource = "cursor_4c_MtI.Acm_Jan"
                loc_oGrid.Column17.ControlSource = "cursor_4c_MtI.Acm_Fev"
                loc_oGrid.Column18.ControlSource = "cursor_4c_MtI.Acm_Mar"
                loc_oGrid.Column19.ControlSource = "cursor_4c_MtI.Acm_Abr"
                loc_oGrid.Column20.ControlSource = "cursor_4c_MtI.Acm_Mai"
                loc_oGrid.Column21.ControlSource = "cursor_4c_MtI.Acm_Jun"
                loc_oGrid.Column22.ControlSource = "cursor_4c_MtI.Acm_Jul"
                loc_oGrid.Column23.ControlSource = "cursor_4c_MtI.Acm_Ago"
                loc_oGrid.Column24.ControlSource = "cursor_4c_MtI.Acm_Set"
                loc_oGrid.Column25.ControlSource = "cursor_4c_MtI.Acm_Out"
                loc_oGrid.Column26.ControlSource = "cursor_4c_MtI.Acm_Nov"
                loc_oGrid.Column27.ControlSource = "cursor_4c_MtI.Acm_Dez"
                *-- O ControlSource do CheckBox mora na COLUNA, nunca no controle:
                *-- Column28.chk_4c_Check1.ControlSource dispara
                *-- "Parent object will not allow this property setting" (Erro296).
                *-- Legado: grdSaldos.column28.ControlSource = [csSigCdMtI.ChkValida]
                loc_oGrid.Column28.ControlSource = "cursor_4c_MtI.ChkValida"

                *-- A FONTE vem ANTES das larguras. Medido no VFP9 (Erro297):
                *-- Grid.FontSize REESCALA Column.Width - 90/85/0 virou 74/64/64,
                *-- ou seja ate a coluna ESCONDIDA (Width = 0) reaparece. Por isso
                *-- FormatarGradeDetalhe() tem de ser a ULTIMA coisa (regra #35c).
                loc_oGrid.FontName = "Tahoma"
                loc_oGrid.FontSize = 8

                *-- Largura/caption/ordem APOS o RecordSource E a fonte (regra #35c)
                THIS.FormatarGradeDetalhe()

                *-- Popular cursor NAO repinta a grade (regra #21a)
                SELECT cursor_4c_MtI
                GO TOP
                loc_oGrid.Refresh()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AlternarGradeDetalhe")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- FORMATAR GRADE DETALHE - Largura, caption, mascara e ORDEM das colunas
    *-- Chamado SEMPRE depois do RecordSource (que reseta Width e Caption).
    *-- Transcrito do SCX legado (grdSaldos): as colunas Val_<mes> e Acm_<mes>
    *-- ficam INTERCALADAS na tela via ColumnOrder - Grupo, Conta, Valida,
    *-- Jan(valor), Jan(acum.), Fev(valor), Fev(acum.) ... Dez, Total.
    *-- As 12 colunas de acumulado so aparecem em ALTERAR; no legado
    *-- Width = IIF(INLIST(pcEscolha,[INSERIR],[EXCLUIR],[PROCURAR]), 0, 85)
    *-- =========================================================================

    PROCEDURE FormatarGradeDetalhe()
        LOCAL loc_oGrid, loc_nI, loc_nLargAcm

        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados

        *-- Guarda FORA do TRY (regra #1: nunca RETURN dentro de TRY/CATCH).
        *-- ColumnCount < 28 acontece de verdade: fechar o alias do grid zera o
        *-- ColumnCount para 0 (Erro301), e ai nem Column1 existe.
        IF VARTYPE(loc_oGrid) # "O" OR loc_oGrid.ColumnCount < 28
            RETURN
        ENDIF

        TRY
            *-- Largura (legado: 90/90 nos codigos, 85 nos meses, 90 no total, 43 no check)
            loc_oGrid.Column1.Width  = 90
            loc_oGrid.Column2.Width  = 90
            FOR loc_nI = 3 TO 14
                STORE 85 TO ("loc_oGrid.Column" + TRANSFORM(loc_nI) + ".Width")
            ENDFOR
            loc_oGrid.Column15.Width = 90
            loc_oGrid.Column28.Width = 43

            *-- Acumulados: visiveis apenas no modo ALTERAR
            loc_nLargAcm = IIF(THIS.this_cModoAtual = "ALTERAR", 85, 0)
            FOR loc_nI = 16 TO 27
                STORE loc_nLargAcm TO ("loc_oGrid.Column" + TRANSFORM(loc_nI) + ".Width")
            ENDFOR

            *-- Caption (RecordSource zera os headers)
            loc_oGrid.Column1.Header1.Caption  = "Grupo"
            loc_oGrid.Column2.Header1.Caption  = "Conta"
            loc_oGrid.Column3.Header1.Caption  = "Janeiro"
            loc_oGrid.Column4.Header1.Caption  = "Fevereiro"
            loc_oGrid.Column5.Header1.Caption  = "Mar" + CHR(231) + "o"
            loc_oGrid.Column6.Header1.Caption  = "Abril"
            loc_oGrid.Column7.Header1.Caption  = "Maio"
            loc_oGrid.Column8.Header1.Caption  = "Junho"
            loc_oGrid.Column9.Header1.Caption  = "Julho"
            loc_oGrid.Column10.Header1.Caption = "Agosto"
            loc_oGrid.Column11.Header1.Caption = "Setembro"
            loc_oGrid.Column12.Header1.Caption = "Outubro"
            loc_oGrid.Column13.Header1.Caption = "Novembro"
            loc_oGrid.Column14.Header1.Caption = "Dezembro"
            loc_oGrid.Column15.Header1.Caption = "Total"
            loc_oGrid.Column16.Header1.Caption = "Janeiro"
            loc_oGrid.Column17.Header1.Caption = "Fevereiro"
            loc_oGrid.Column18.Header1.Caption = "Mar" + CHR(231) + "o"
            loc_oGrid.Column19.Header1.Caption = "Abril"
            loc_oGrid.Column20.Header1.Caption = "Maio"
            loc_oGrid.Column21.Header1.Caption = "Junho"
            loc_oGrid.Column22.Header1.Caption = "Julho"
            loc_oGrid.Column23.Header1.Caption = "Agosto"
            loc_oGrid.Column24.Header1.Caption = "Setembro"
            loc_oGrid.Column25.Header1.Caption = "Outubro"
            loc_oGrid.Column26.Header1.Caption = "Novembro"
            loc_oGrid.Column27.Header1.Caption = "Dezembro"
            loc_oGrid.Column28.Header1.Caption = "Valida"

            FOR loc_nI = 1 TO 28
                STORE 2 TO ("loc_oGrid.Column" + TRANSFORM(loc_nI) + ".Header1.Alignment")
            ENDFOR

            *-- Mascara numerica (legado: InputMask das colunas de valor)
            FOR loc_nI = 3 TO 14
                STORE "999,999,999.99" TO ("loc_oGrid.Column" + TRANSFORM(loc_nI) + ".InputMask")
            ENDFOR
            FOR loc_nI = 16 TO 27
                STORE "999,999,999.99" TO ("loc_oGrid.Column" + TRANSFORM(loc_nI) + ".InputMask")
            ENDFOR
            loc_oGrid.Column15.InputMask = "999,999,999,999.99"

            *-- ColumnOrder: atribuir na ORDEM DA POSICAO DE DESTINO (1..28),
            *-- senao cada atribuicao empurra as demais e a permutacao se perde.
            loc_oGrid.Column1.ColumnOrder  = 1     && Grupos
            loc_oGrid.Column2.ColumnOrder  = 2     && Contas
            loc_oGrid.Column28.ColumnOrder = 3     && ChkValida
            loc_oGrid.Column3.ColumnOrder  = 4     && Val_Jan
            loc_oGrid.Column16.ColumnOrder = 5     && Acm_Jan
            loc_oGrid.Column4.ColumnOrder  = 6     && Val_Fev
            loc_oGrid.Column17.ColumnOrder = 7     && Acm_Fev
            loc_oGrid.Column5.ColumnOrder  = 8     && Val_Mar
            loc_oGrid.Column18.ColumnOrder = 9     && Acm_Mar
            loc_oGrid.Column6.ColumnOrder  = 10    && Val_Abr
            loc_oGrid.Column19.ColumnOrder = 11    && Acm_Abr
            loc_oGrid.Column7.ColumnOrder  = 12    && Val_Mai
            loc_oGrid.Column20.ColumnOrder = 13    && Acm_Mai
            loc_oGrid.Column8.ColumnOrder  = 14    && Val_Jun
            loc_oGrid.Column21.ColumnOrder = 15    && Acm_Jun
            loc_oGrid.Column9.ColumnOrder  = 16    && Val_Jul
            loc_oGrid.Column22.ColumnOrder = 17    && Acm_Jul
            loc_oGrid.Column10.ColumnOrder = 18    && Val_Ago
            loc_oGrid.Column23.ColumnOrder = 19    && Acm_Ago
            loc_oGrid.Column11.ColumnOrder = 20    && Val_Set
            loc_oGrid.Column24.ColumnOrder = 21    && Acm_Set
            loc_oGrid.Column12.ColumnOrder = 22    && Val_Out
            loc_oGrid.Column25.ColumnOrder = 23    && Acm_Out
            loc_oGrid.Column13.ColumnOrder = 24    && Val_Nov
            loc_oGrid.Column26.ColumnOrder = 25    && Acm_Nov
            loc_oGrid.Column14.ColumnOrder = 26    && Val_Dez
            loc_oGrid.Column27.ColumnOrder = 27    && Acm_Dez
            loc_oGrid.Column15.ColumnOrder = 28    && Total

            *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (regra #18):
            *-- so Grupo, Conta, os 12 valores mensais e o check sao editaveis.
            loc_oGrid.Column15.ReadOnly = .T.
            FOR loc_nI = 16 TO 27
                STORE .T. TO ("loc_oGrid.Column" + TRANSFORM(loc_nI) + ".ReadOnly")
            ENDFOR

            *-- Reinstalar os controles de celula: o ColumnCount do
            *-- AlternarGradeDetalhe recria as Columns do zero (Header1+Text1) e
            *-- leva junto tudo que foi posto por AddObject. Os dois metodos sao
            *-- idempotentes e TEM de rodar antes de qualquer CurrentControl.
            THIS.InstalarCelulaValida(loc_oGrid)
            THIS.InstalarCelulasCentroCusto(loc_oGrid)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.FormatarGradeDetalhe")
        ENDTRY
    ENDPROC

    *-- =========================================================================
    *-- VALIDAR ANO MTZ - Valida ano de competencia
    *-- Transcrito de getAno.Valid (dispara ao SAIR do campo, nunca por tecla):
    *--   If Not Empty(This.Value)
    *--       This.Value = Padl(This.Value,4,'2000')
    *--       If Val(This.Value) <= 2000 or Val(This.Value) >= 2999
    *--           MessageBox([Informe um Ano Valido.],0+64,[Atencao])
    *--           Return .F.
    *--       EndIf
    *--   EndIf
    *-- O PADL eh a metade que faltava: medido no VFP9, PADL("2",4,"2000") = "2002"
    *-- e PADL("26",4,"2000") = "2026" - o digito solto NAO eh ano invalido, ele eh
    *-- completado. Sem o PADL, VAL("2") = 2 caia direto no <= 2000 (Erro297).
    *-- Guarda de reentrancia: o SetFocus dentro do proprio LostFocus redispara o
    *-- evento; o corpo vive no Exec para a flag ser liberada tambem nos RETURN.
    *-- =========================================================================

    PROCEDURE ValidarAnoMtz()
        IF THIS.this_lEmValidacaoAno
            RETURN
        ENDIF
        THIS.this_lEmValidacaoAno = .T.
        THIS.ValidarAnoMtzExec()
        THIS.this_lEmValidacaoAno = .F.
    ENDPROC

    PROCEDURE ValidarAnoMtzExec()
        LOCAL loc_oTxt, loc_cAno

        loc_oTxt = THIS.pgf_4c_Paginas.Page2.txt_4c_Ano
        loc_cAno = ALLTRIM(loc_oTxt.Value)

        IF EMPTY(loc_cAno)
            RETURN
        ENDIF

        *-- Legado: completa pela ESQUERDA com '2000' ("2" -> "2002", "26" -> "2026")
        loc_cAno       = PADL(loc_cAno, 4, "2000")
        loc_oTxt.Value = loc_cAno

        IF VAL(loc_cAno) <= 2000 OR VAL(loc_cAno) >= 2999
            MsgAviso("Informe um Ano V" + CHR(225) + "lido.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            *-- O legado so devolve .F. (segura o foco). NAO apagar o digitado -
            *-- apagar impede o usuario de corrigir o que escreveu (regra #50).
            loc_oTxt.SetFocus()
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- VALIDAR GRUPO MTZ - Valida grupo em SigCdGcr e preenche Classes
    *-- Original: Get_sgrupo.Valid - CursorQuery em SigCdGcr para Classes
    *-- =========================================================================

    *-- Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
    *-- campo, o que redispara este proprio LostFocus. O corpo vive em ValidarGrupoMtzExec
    *-- para que a flag seja SEMPRE liberada, inclusive nos RETURN antecipados.
    *-- Ligado a "KeyPress" o lookup abria a cada tecla, antes de o usuario
    *-- terminar de digitar o codigo (Erro195). Legado valida no Valid do campo.
    PROCEDURE ValidarGrupoMtz()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarGrupoMtzExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarGrupoMtzExec()
        LOCAL loc_cGrupo, loc_cSQL, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value)

        IF EMPTY(loc_cGrupo)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Codigos, Descrs, Classes FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(loc_cGrupo)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcBusca") > 0 AND ;
               !EOF("cursor_4c_GcBusca")
                SELECT cursor_4c_GcBusca
                THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ;
                    ALLTRIM(cursor_4c_GcBusca.Classes)

                IF EMPTY(ALLTRIM(cursor_4c_GcBusca.Classes))
                    MsgErro("Imposs" + CHR(237) + "vel efetuar lan" + ;
                            CHR(231) + CHR(227) + "amento para este grupo!" + CHR(13) + ;
                            "A classe do grupo n" + CHR(227) + "o est" + CHR(225) + ;
                            " informada!", "Aten" + CHR(231) + CHR(227) + "o")
                    *-- O legado so faz Return(.F.) neste ramo: NAO apaga o
                    *-- codigo digitado, so a descricao derivada (regra #50).
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.SetFocus()
                ELSE
                    loc_lResultado = .T.
                ENDIF
            ELSE
                IF USED("cursor_4c_GcBusca")
                    USE IN cursor_4c_GcBusca
                ENDIF
                THIS.AbrirBuscaGrupoMtz()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.ValidarGrupoMtz")
        ENDTRY

        IF USED("cursor_4c_GcBusca")
            USE IN cursor_4c_GcBusca
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- ABRIR BUSCA GRUPO MTZ - FormBuscaAuxiliar em SigCdGcr
    *-- =========================================================================

    PROCEDURE AbrirBuscaGrupoMtz()
        LOCAL loc_oBusca, loc_oErro

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_GcBusca2", "Codigos", ;
                ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value), ;
                "Grupo de Conta Corrente")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GcBusca2")
                    SELECT cursor_4c_GcBusca2
                    IF !EOF()
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value = ;
                            ALLTRIM(cursor_4c_GcBusca2.Codigos)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Class3.Value = ;
                            ALLTRIM(cursor_4c_GcBusca2.Classes)
                    ENDIF
                ENDIF
                *-- Sem ELSE: desistir do picker NAO pode apagar o codigo que o
                *-- usuario digitou - sem ele nao ha como corrigir (regra #50).

                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaGrupoMtz")
        ENDTRY

        IF USED("cursor_4c_GcBusca2")
            USE IN cursor_4c_GcBusca2
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- TECLA F4 SGRUPO - Abre busca de grupo ao pressionar F4
    *-- =========================================================================

    PROCEDURE TeclaF4Sgrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt            && guarda de reentrancia (regra #37)
        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        *-- F4 = 115 (convencao do projeto, 745 sites). O 63 eh "?" - o
        *-- comentario dizia F4 e o codigo exigia ponto-de-interrogacao;
        *-- os dois passam a abrir a lista.
        IF INLIST(par_nKeyCode, 115, 63)
            THIS.AbrirBuscaGrupoMtz()
        ENDIF
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *-- =========================================================================
    *-- VALIDAR CONTA MTZ - Valida conta em SigCdCli e preenche descricao
    *-- Original: Get_sconta.Valid - fAcessoContas + fChecarInativas
    *-- =========================================================================

    *-- Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
    *-- campo, o que redispara este proprio LostFocus. O corpo vive em ValidarContaMtzExec
    *-- para que a flag seja SEMPRE liberada, inclusive nos RETURN antecipados.
    *-- Ligado a "KeyPress" o lookup abria a cada tecla, antes de o usuario
    *-- terminar de digitar o codigo (Erro195). Legado valida no Valid do campo.
    PROCEDURE ValidarContaMtz()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarContaMtzExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarContaMtzExec()
        LOCAL loc_cConta, loc_cGrupo, loc_cSQL, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value)
        loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value)

        IF EMPTY(loc_cConta)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 IClis, Rclis, Grupos, Inativa FROM SigCdCli" + ;
                       " WHERE IClis = " + EscaparSQL(loc_cConta)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliBusca") > 0 AND ;
               !EOF("cursor_4c_CliBusca")
                SELECT cursor_4c_CliBusca
                IF NVL(cursor_4c_CliBusca.Inativa, 0) = 1
                    MsgAviso("Conta Inativa...", "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ""
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.SetFocus()
                ELSE
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ;
                        ALLTRIM(cursor_4c_CliBusca.Rclis)
                    loc_lResultado = .T.
                ENDIF
            ELSE
                IF USED("cursor_4c_CliBusca")
                    USE IN cursor_4c_CliBusca
                ENDIF
                THIS.AbrirBuscaContaMtz()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.ValidarContaMtz")
        ENDTRY

        IF USED("cursor_4c_CliBusca")
            USE IN cursor_4c_CliBusca
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- ABRIR BUSCA CONTA MTZ - FormBuscaAuxiliar em SigCdCli
    *-- =========================================================================

    PROCEDURE AbrirBuscaContaMtz()
        LOCAL loc_oBusca, loc_cGrupo, loc_cFiltro, loc_oErro

        TRY
            loc_cGrupo  = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sgrupo.Value)
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_CliBusca2", "IClis", ;
                ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value), ;
                "Conta Corrente", .F., .T., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "", "Conta")
                    loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CliBusca2")
                    SELECT cursor_4c_CliBusca2
                    IF !EOF()
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Sconta.Value  = ;
                            ALLTRIM(cursor_4c_CliBusca2.IClis)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Sdconta.Value = ;
                            ALLTRIM(cursor_4c_CliBusca2.Rclis)
                    ENDIF
                ENDIF
                *-- Sem ELSE: desistir do picker NAO pode apagar o codigo
                *-- digitado (regra #50). O legado so limpa quando o acesso eh
                *-- NEGADO ou a conta esta INATIVA - esses ramos continuam
                *-- limpando, fieis ao Get_sconta.Valid.

                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaContaMtz")
        ENDTRY

        IF USED("cursor_4c_CliBusca2")
            USE IN cursor_4c_CliBusca2
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- TECLA F4 SCONTA - Abre busca de conta ao pressionar F4
    *-- =========================================================================

    PROCEDURE TeclaF4Sconta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt            && guarda de reentrancia (regra #37)
        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        *-- F4 = 115 (convencao do projeto, 745 sites). O 63 eh "?" - o
        *-- comentario dizia F4 e o codigo exigia ponto-de-interrogacao;
        *-- os dois passam a abrir a lista.
        IF INLIST(par_nKeyCode, 115, 63)
            THIS.AbrirBuscaContaMtz()
        ENDIF
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *-- =========================================================================
    *-- VALIDAR MOEDA MTZ - Valida moeda em SigCdMoe (fwBuscaExt original)
    *-- Original: getMoeda.Valid - fwBuscaExt('SigCdMoe','CMoes','DMoes')
    *-- =========================================================================

    *-- Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
    *-- campo, o que redispara este proprio LostFocus. O corpo vive em ValidarMoedaMtzExec
    *-- para que a flag seja SEMPRE liberada, inclusive nos RETURN antecipados.
    *-- Ligado a "KeyPress" o lookup abria a cada tecla, antes de o usuario
    *-- terminar de digitar o codigo (Erro195). Legado valida no Valid do campo.
    PROCEDURE ValidarMoedaMtz()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarMoedaMtzExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE ValidarMoedaMtzExec()
        LOCAL loc_cMoeda, loc_cSQL, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        loc_cMoeda = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value)

        IF EMPTY(loc_cMoeda)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe" + ;
                       " WHERE CMoes = " + EscaparSQL(loc_cMoeda)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeBusca") > 0 AND ;
               !EOF("cursor_4c_MoeBusca")
                SELECT cursor_4c_MoeBusca
                THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ;
                    ALLTRIM(cursor_4c_MoeBusca.CMoes)
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_MoeBusca")
                    USE IN cursor_4c_MoeBusca
                ENDIF
                THIS.AbrirBuscaMoedaMtz()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.ValidarMoedaMtz")
        ENDTRY

        IF USED("cursor_4c_MoeBusca")
            USE IN cursor_4c_MoeBusca
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- ABRIR BUSCA MOEDA MTZ - FormBuscaAuxiliar em SigCdMoe
    *-- =========================================================================

    PROCEDURE AbrirBuscaMoedaMtz()
        LOCAL loc_oBusca, loc_oErro

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_MoeBusca2", "CMoes", ;
                ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value), ;
                "Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MoeBusca2")
                    SELECT cursor_4c_MoeBusca2
                    IF !EOF()
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ;
                            ALLTRIM(cursor_4c_MoeBusca2.CMoes)
                    ENDIF
                ELSE
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaMoedaMtz")
        ENDTRY

        IF USED("cursor_4c_MoeBusca2")
            USE IN cursor_4c_MoeBusca2
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- TECLA F4 MOEDA - Abre busca de moeda ao pressionar F4
    *-- =========================================================================

    PROCEDURE TeclaF4Moeda(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt            && guarda de reentrancia (regra #37)
        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        *-- F4 = 115 (convencao do projeto, 745 sites). O 63 eh "?" - o
        *-- comentario dizia F4 e o codigo exigia ponto-de-interrogacao;
        *-- os dois passam a abrir a lista.
        IF INLIST(par_nKeyCode, 115, 63)
            THIS.AbrirBuscaMoedaMtz()
        ENDIF
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *-- =========================================================================
    *-- ATUALIZA TOTAL - Recalcula Total da linha e atualiza ValorTotal header
    *-- Original: ThisForm.AtualizaTotal(csSigCdMti.cIdChaves)
    *-- =========================================================================

    PROCEDURE AtualizaTotal(par_cIdChaves)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF THIS.this_oBusinessObject.AtualizarTotal(par_cIdChaves)
                THIS.pgf_4c_Paginas.Page2.txt_4c_ValorTotal.Value = ;
                    THIS.this_oBusinessObject.this_nValorTotal
                THIS.pgf_4c_Paginas.Page2.txt_4c_Saldo.Value = ;
                    THIS.this_oBusinessObject.this_nValorTotal
                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AtualizaTotal")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- =========================================================================
    *-- BTN INSERIR LINHA CLICK - Adiciona linha em branco na grade de detalhe
    *-- Original: cmdInsFtc.Buttons(1).Click
    *-- =========================================================================

    PROCEDURE BtnInserirLinhaClick()
        LOCAL loc_cCodigo, loc_oGrid, loc_lProsseguir

        loc_lProsseguir = .T.
        TRY
            IF THIS.this_cModoAtual # "INCLUIR" AND THIS.this_cModoAtual # "ALTERAR"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cCodigo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)

                IF THIS.this_oBusinessObject.InserirLinhaDetalhe(loc_cCodigo)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
                    IF VARTYPE(loc_oGrid) = "O"
                        loc_oGrid.Refresh()
                        loc_oGrid.Column1.SetFocus()
                    ENDIF
                ENDIF

            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnInserirLinhaClick")
        ENDTRY
    ENDPROC

    *-- =========================================================================
    *-- BTN EXCLUIR LINHA CLICK - Remove linha atual da grade de detalhe
    *-- Original: cmdInsFtc.Buttons(2).Click
    *-- =========================================================================

    PROCEDURE BtnExcluirLinhaClick()
        LOCAL loc_oGrid, loc_lProsseguir

        loc_lProsseguir = .T.
        TRY
            IF THIS.this_cModoAtual # "INCLUIR" AND THIS.this_cModoAtual # "ALTERAR"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF THIS.this_oBusinessObject.ExcluirLinhaDetalhe()
                    loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Dados
                    IF VARTYPE(loc_oGrid) = "O"
                        loc_oGrid.SetFocus()
                        loc_oGrid.Refresh()
                    ENDIF
                ENDIF

            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.BtnExcluirLinhaClick")
        ENDTRY
    ENDPROC

    *-- =========================================================================
    *-- GRD DADOS AFTER ROW COL CHANGE - Valida celulas e atualiza totais
    *-- Original: Column1.Text1.Valid, Column2.Text1.Valid, Column3-14.Text1.Valid
    *-- =========================================================================

    *-- Erro298 / regra #46: a validacao de Grupo e Conta NAO mora mais aqui.
    *-- AfterRowColChange dispara DEPOIS de entrar na celula nova e nColIndex eh
    *-- a coluna de DESTINO: com "CASE par_nColIndex = 1" o lookup so rodava ao
    *-- CHEGAR na coluna 1 (ainda vazia, logo RETURN imediato) e ao SAIR dela o
    *-- indice entregue era 2. Resultado: o usuario digitava o codigo do grupo,
    *-- nenhuma lista abria e nada era validado. Agora vive no Valid da celula
    *-- (TextBoxCentroCustoMtz_4c -> ValidarGrupoGrade/ValidarContaGrade).
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_cChave

        IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
            RETURN
        ENDIF

        SELECT cursor_4c_MtI
        loc_cChave = ALLTRIM(NVL(cursor_4c_MtI.CidChaves, ""))

        IF par_nColIndex >= 3 AND par_nColIndex <= 14
            IF !EMPTY(loc_cChave)
                THIS.AtualizaTotal(loc_cChave)
            ENDIF
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- INSTALAR CELULA VALIDA - poe o CheckBox na coluna Valida (28).
    *-- Erro301: FECHAR o alias ligado ao grid ZERA o ColumnCount para 0 e
    *-- DESTROI todas as Columns. Medido no VFP9 (2026-11-04):
    *--   apos USE IN do alias   -> ColumnCount=0, "Property COLUMN5 is not found"
    *--   apos repor ColumnCount -> colunas NOVAS, so Header1+Text1,
    *--                             CurrentControl de volta em [Text1]
    *--   Column28.CurrentControl = "chk_4c_Check1" -> "Error with Column28 -
    *--   CurrentControl : Expression evaluated to an illegal value."
    *-- Quem fecha o alias eh o CarregarDetalhe (USE IN + SQLEXEC no mesmo nome
    *-- de cursor), ou seja o caminho de ALTERAR e VISUALIZAR. Por isso o
    *-- Incluir funcionava e o Alterar nao. Trocar SO o RecordSource, com o
    *-- alias vivo, PRESERVA os controles - o gatilho eh o fechamento.
    *-- Legado: Check1 Top=25 Left=31 Height=17 Width=60 Tahoma / Alignment=0 /
    *--         Centered=.T. / Caption=""
    *-- =========================================================================

    PROCEDURE InstalarCelulaValida(par_oGrid)
        LOCAL loc_oCol

        IF VARTYPE(par_oGrid) # "O" OR par_oGrid.ColumnCount < 28
            RETURN
        ENDIF

        loc_oCol = par_oGrid.Columns(28)

        IF !PEMSTATUS(loc_oCol, "chk_4c_Check1", 5)
            loc_oCol.AddObject("chk_4c_Check1", "CheckBox")
        ENDIF

        WITH loc_oCol.chk_4c_Check1
            .Caption   = ""
            .FontName  = "Tahoma"
            .Alignment = 0
            .Centered  = .T.
            .ReadOnly  = .F.
            .Visible   = .T.
            .Top       = 25
            .Left      = 31
            .Height    = 17
            .Width     = 60
        ENDWITH

        *-- CurrentControl: sem isto a coluna continua desenhando o Text1 e o
        *-- CheckBox acima NUNCA aparece (CorretorAutomatico #198)
        loc_oCol.CurrentControl = "chk_4c_Check1"
        loc_oCol.Sparse         = .F.
    ENDPROC

    *-- =========================================================================
    *-- INSTALAR CELULAS CENTRO DE CUSTO - poe TextBoxCentroCustoMtz_4c nas
    *-- colunas Grupos (1) e Contas (2) da grade de saldos. Chamado no fim do
    *-- FormatarGradeDetalhe, que roda depois de todo rebind do RecordSource:
    *-- idempotente, so adiciona quando falta (regra #18 + #46).
    *-- =========================================================================

    PROCEDURE InstalarCelulasCentroCusto(par_oGrid)
        LOCAL loc_nCol, loc_oCol

        IF VARTYPE(par_oGrid) # "O" OR par_oGrid.ColumnCount < 2
            RETURN
        ENDIF

        FOR loc_nCol = 1 TO 2
            loc_oCol = par_oGrid.Columns(loc_nCol)

            IF !PEMSTATUS(loc_oCol, "txt_4c_CentroCusto", 5)
                loc_oCol.AddObject("txt_4c_CentroCusto", "TextBoxCentroCustoMtz_4c")
            ENDIF

            WITH loc_oCol.txt_4c_CentroCusto
                .this_cCampo = IIF(loc_nCol = 1, "Grupos", "Contas")
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                *-- SigCdMtI.grupos char(10) / SigCdMtI.contas char(10)
                .MaxLength   = 10
                .Visible     = .T.
            ENDWITH

            *-- Sem CurrentControl a coluna continua desenhando o Text1 e o
            *-- controle acima NUNCA aparece; Sparse = .F. para valer em todas
            *-- as linhas, nao so na ativa (regra #18).
            loc_oCol.CurrentControl = "txt_4c_CentroCusto"
            loc_oCol.Sparse         = .F.
        ENDFOR
    ENDPROC

    *-- =========================================================================
    *-- PODE EDITAR CELULA CENTRO DE CUSTO - When de Column1/Column2.Text1:
    *--   Return(INLIST(pcEscolha,'INSERIR','ALTERAR') And crSigCdMtz.Inativas = 0)
    *-- =========================================================================

    PROCEDURE PodeEditarCelulaCentroCusto()
        LOCAL loc_lPode

        loc_lPode = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF loc_lPode AND VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lPode = !THIS.this_oBusinessObject.this_lInativas
        ENDIF

        RETURN loc_lPode
    ENDPROC

    *-- =========================================================================
    *-- VALIDAR GRUPO GRADE - Valid da celula Grupos (Column1)
    *-- Original: Column1.Text1.Valid -> fAcessoContab(Usuar,'C',This.Value,This,'')
    *-- O fAcessoContab do Framework abre o browse quando o codigo nao casa; aqui
    *-- o equivalente eh o FormBuscaAuxiliar (regra da memoria sobre fAcessoContas
    *-- como handler de UX). O valor digitado vem de par_oTxt.Value - o cursor so
    *-- recebe DEPOIS do Valid, ler do cursor validaria o valor ANTIGO (regra #46).
    *-- =========================================================================

    PROCEDURE ValidarGrupoGrade(par_oTxt)
        LOCAL loc_cGrupo, loc_cSQL, loc_lOk, loc_oErro
        loc_lOk = .T.

        IF VARTYPE(par_oTxt) # "O" OR !USED("cursor_4c_MtI")
            RETURN .T.
        ENDIF

        loc_cGrupo = ALLTRIM(NVL(par_oTxt.Value, ""))

        IF EMPTY(loc_cGrupo)
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Codigos FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(loc_cGrupo)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoCel") > 0 AND ;
               !EOF("cursor_4c_GrupoCel")
                THIS.GravarCelulaCentroCusto(par_oTxt, "Grupos", loc_cGrupo)
            ELSE
                IF USED("cursor_4c_GrupoCel")
                    USE IN cursor_4c_GrupoCel
                ENDIF
                *-- Codigo nao casou: abre a lista com o digitado como prefixo,
                *-- igual ao browse do fAcessoContab. NAO apagar o digitado
                *-- quando o usuario desiste (regra #50).
                loc_lOk = THIS.AbrirBuscaGrupoGrade(par_oTxt, loc_cGrupo)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.ValidarGrupoGrade")
        ENDTRY

        IF USED("cursor_4c_GrupoCel")
            USE IN cursor_4c_GrupoCel
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *-- =========================================================================
    *-- ABRIR BUSCA GRUPO GRADE - FormBuscaAuxiliar da celula Grupos
    *-- =========================================================================

    PROCEDURE AbrirBuscaGrupoGrade(par_oTxt, par_cValor)
        LOCAL loc_oBusca, loc_lOk, loc_oErro
        loc_lOk = .T.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_GrupoCelBusca", "Codigos", ;
                par_cValor, "Grupo de Centro de Custo")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GrupoCelBusca")
                    SELECT cursor_4c_GrupoCelBusca
                    IF !EOF()
                        THIS.GravarCelulaCentroCusto(par_oTxt, "Grupos", ;
                            ALLTRIM(cursor_4c_GrupoCelBusca.Codigos))
                    ENDIF
                ELSE
                    *-- Nada escolhido: segura o foco na celula para o usuario
                    *-- corrigir o que digitou, sem apagar (regra #50).
                    loc_lOk = .F.
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaGrupoGrade")
        ENDTRY

        IF USED("cursor_4c_GrupoCelBusca")
            USE IN cursor_4c_GrupoCelBusca
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *-- =========================================================================
    *-- VALIDAR CONTA GRADE - Valid da celula Contas (Column2)
    *-- Original: Column2.Text1.Valid
    *--   Grupo = csSigCdMtI.Grupos
    *--   llRet = Empty(This.Value) or fAcessoContas(Usuar,grupo,'C',This.Value,This,'')
    *-- O 2o argumento (pGrp) do fAcessoContas eh FILTRO: a lista de contas sai
    *-- restrita ao grupo da linha corrente, nao e a tabela inteira.
    *-- =========================================================================

    PROCEDURE ValidarContaGrade(par_oTxt)
        LOCAL loc_cConta, loc_cGrupo, loc_cSQL, loc_lOk, loc_oErro
        loc_lOk = .T.

        IF VARTYPE(par_oTxt) # "O" OR !USED("cursor_4c_MtI")
            RETURN .T.
        ENDIF

        loc_cConta = ALLTRIM(NVL(par_oTxt.Value, ""))

        IF EMPTY(loc_cConta)
            RETURN .T.
        ENDIF

        *-- O grupo JA esta no cursor (coluna anterior, Valid dela ja gravou)
        SELECT cursor_4c_MtI
        loc_cGrupo = ALLTRIM(NVL(cursor_4c_MtI.Grupos, ""))

        TRY
            loc_cSQL = "SELECT TOP 1 IClis, Inativa FROM SigCdCli" + ;
                       " WHERE IClis = " + EscaparSQL(loc_cConta)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaCel") > 0 AND ;
               !EOF("cursor_4c_ContaCel")
                SELECT cursor_4c_ContaCel
                IF TratarNulo(cursor_4c_ContaCel.Inativa, "N") = 1
                    MsgAviso("Conta Inativa ...", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lOk = .F.
                ELSE
                    THIS.GravarCelulaCentroCusto(par_oTxt, "Contas", loc_cConta)
                ENDIF
            ELSE
                IF USED("cursor_4c_ContaCel")
                    USE IN cursor_4c_ContaCel
                ENDIF
                loc_lOk = THIS.AbrirBuscaContaGrade(par_oTxt, loc_cConta, loc_cGrupo)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.ValidarContaGrade")
        ENDTRY

        IF USED("cursor_4c_ContaCel")
            USE IN cursor_4c_ContaCel
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *-- =========================================================================
    *-- ABRIR BUSCA CONTA GRADE - FormBuscaAuxiliar da celula Contas
    *-- =========================================================================

    PROCEDURE AbrirBuscaContaGrade(par_oTxt, par_cValor, par_cGrupo)
        LOCAL loc_oBusca, loc_cFiltro, loc_cGrupo, loc_lOk, loc_oErro
        loc_lOk = .T.

        *-- Grupo omitido (chamada pelo F4 da celula): le o da linha corrente.
        loc_cGrupo = IIF(VARTYPE(par_cGrupo) = "C", ALLTRIM(par_cGrupo), "")
        IF EMPTY(loc_cGrupo) AND USED("cursor_4c_MtI") AND !EOF("cursor_4c_MtI")
            loc_cGrupo = ALLTRIM(NVL(cursor_4c_MtI.Grupos, ""))
        ENDIF

        TRY
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_ContaCelBusca", "IClis", ;
                par_cValor, "Conta de Centro de Custo", .F., .T., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("IClis", "", "Conta")
                    loc_oBusca.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ContaCelBusca")
                    SELECT cursor_4c_ContaCelBusca
                    IF !EOF()
                        THIS.GravarCelulaCentroCusto(par_oTxt, "Contas", ;
                            ALLTRIM(cursor_4c_ContaCelBusca.IClis))
                    ENDIF
                ELSE
                    loc_lOk = .F.
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.AbrirBuscaContaGrade")
        ENDTRY

        IF USED("cursor_4c_ContaCelBusca")
            USE IN cursor_4c_ContaCelBusca
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *-- =========================================================================
    *-- GRAVAR CELULA CENTRO DE CUSTO - escreve o codigo escolhido no cursor E
    *-- de volta no proprio TextBox. Sem devolver para par_oTxt.Value o texto
    *-- digitado sobrescreve o cursor quando o Valid termina (regra #46).
    *-- =========================================================================

    PROTECTED PROCEDURE GravarCelulaCentroCusto(par_oTxt, par_cCampo, par_cValor)
        IF !USED("cursor_4c_MtI") OR EOF("cursor_4c_MtI")
            RETURN
        ENDIF

        par_oTxt.Value = par_cValor

        SELECT cursor_4c_MtI
        IF par_cCampo = "Grupos"
            REPLACE Grupos WITH par_cValor IN cursor_4c_MtI
        ELSE
            REPLACE Contas WITH par_cValor IN cursor_4c_MtI
        ENDIF
    ENDPROC

    *-- =========================================================================
    *-- TORNAR CONTROLES VISIVEIS - Percorre containers e pages recursivamente
    *-- =========================================================================

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

    *-- =========================================================================
    *-- FORMATAR GRID LISTA - Aplica fonte padrao no grid
    *-- =========================================================================

    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        *-- Legado: Pagina.Lista.Grade.FontName = "Tahoma" / FontSize = 8
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *-- =========================================================================
    *-- DESTROY - Libera recursos
    *-- =========================================================================

    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_MtI")
                USE IN cursor_4c_MtI
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formmtz.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


*==============================================================================
* TextBoxCentroCustoMtz_4c - celulas Grupos (Column1) e Contas (Column2) da
* grade de saldos do Formmtz (Erro298). Transcreve Column1/Column2.Text1 do
* legado:
*   When  -> Return(INLIST(pcEscolha,'INSERIR','ALTERAR') And crSigCdMtz.Inativas = 0)
*   Valid -> fAcessoContab / fAcessoContas  (validam e, no miss, abrem o browse)
* Eventos EMBUTIDOS na classe: BINDEVENT em Valid de TextBox dentro de Column
* nao dispara de forma confiavel no VFP (ver TextBoxGridLookup.prg).
*==============================================================================
DEFINE CLASS TextBoxCentroCustoMtz_4c AS TextBox
    this_cCampo = "Grupos"

    PROCEDURE When()
        LOCAL loc_lPode
        loc_lPode = .T.
        IF PEMSTATUS(THISFORM, "PodeEditarCelulaCentroCusto", 5)
            loc_lPode = THISFORM.PodeEditarCelulaCentroCusto()
        ENDIF
        RETURN loc_lPode
    ENDPROC

    PROCEDURE Valid()
        LOCAL loc_lRetorno
        loc_lRetorno = .T.
        IF THIS.this_cCampo = "Grupos"
            IF PEMSTATUS(THISFORM, "ValidarGrupoGrade", 5)
                loc_lRetorno = THISFORM.ValidarGrupoGrade(THIS)
            ENDIF
        ELSE
            IF PEMSTATUS(THISFORM, "ValidarContaGrade", 5)
                loc_lRetorno = THISFORM.ValidarContaGrade(THIS)
            ENDIF
        ENDIF
        RETURN loc_lRetorno
    ENDPROC

    *-- F4 abre a lista direto, sem precisar errar o codigo antes
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115        && F4 (convencao do projeto)
            IF THIS.this_cCampo = "Grupos"
                IF PEMSTATUS(THISFORM, "AbrirBuscaGrupoGrade", 5)
                    THISFORM.AbrirBuscaGrupoGrade(THIS, ALLTRIM(NVL(THIS.Value, "")))
                ENDIF
            ELSE
                IF PEMSTATUS(THISFORM, "AbrirBuscaContaGrade", 5)
                    THISFORM.AbrirBuscaContaGrade(THIS, ALLTRIM(NVL(THIS.Value, "")), "")
                ENDIF
            ENDIF
            NODEFAULT
        ENDIF
    ENDPROC
ENDDEFINE