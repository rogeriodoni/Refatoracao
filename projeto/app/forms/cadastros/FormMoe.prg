*==============================================================================
* FormMoe.prg - Formulario de Cadastro de Moedas
* Migrado de: SigCdMoe.SCX (frmcadastro)
* Tabela: SigCdMoe
* Chave: cmoes char(3)
*==============================================================================

DEFINE CLASS FormMoe AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 591
    Width       = 1000
    Caption     = "Cadastro de Moedas"
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
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("MoeBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar MoeBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormMoe.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                THIS.CarregarLista()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormMoe:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormMoe.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 esconde abas; todos os controles compensam +29 no Top
    *==========================================================================
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

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD e grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original: cntSombra.Top=1. Com compensacao PageFrame +29: Top=30
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Cadastro de Moedas"
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
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
            .Caption   = "Cadastro de Moedas"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op no legado)
        *-- Original: Grupo_op.Top=0. Com compensacao +29: Top=29; Left canonico: 542
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(100, 100, 100)
            .BackStyle = 0
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

        *-- Botao Cambio (COTACAO no legado) - especifico deste form para cotacoes
        *-- Original: Top=5, Left=296. Com compensacao +29: Top=34
        loc_oPagina.AddObject("cmd_4c_Cambio", "CommandButton")
        WITH loc_oPagina.cmd_4c_Cambio
            .Caption         = "\<C" + CHR(226) + "mbio"
            .Picture         = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
            .PicturePosition = 13
            .Top             = 34
            .Left            = 296
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid de lista (Grade no legado)
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
        loc_oPagina.grd_4c_Lista.ColumnCount = 3

        WITH loc_oPagina.grd_4c_Lista
            .Column1.Header1.Caption = "Moeda"
            .Column1.Width           = 120
            .Column1.Alignment       = 0

            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width           = 330
            .Column2.Alignment       = 0

            .Column3.Header1.Caption = "Ordem de Impress" + CHR(227) + "o"
            .Column3.Width           = 129
            .Column3.Alignment       = 1
        ENDWITH

        *-- BINDEVENTs - metodos devem ser PUBLIC (sem PROTECTED) para funcionar
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_Cambio,                   "Click", THIS, "BtnCambioClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2: botoes Salvar/Cancelar + TODOS os campos
    * Campos: Codigo, Descricao, Cotacao, FMult, Spinner, MoeEq, Qtde, Tabref,
    *   FPG (lookup SigOpFp), Toleras, OptTipo(Consultas), DisfPres, ValAdics,
    *   Grupo, SubGrupo + shapes separadores
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
        *-- Original: Grupo_Salva.Top=16, Left=619. Compensacao +29: Top=45
        *-- Left canonico do framework: 842 (form Width=1000)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 45
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
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

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
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

        *-- GRUPO 1: Codigo e Descricao
        *-- Say1 "Código :" - Original Top=66, +29=95, Left=298, Width=42, Height=15
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption    = "C" + CHR(243) + "digo :"
            .Top        = 95
            .Left       = 298
            .Width      = 42
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- Get_moeda cmoes - Original Top=61, +29=90, Left=347, Width=31, Height=23
        *-- Desabilitado em modo ALTERAR (campo chave nao editavel)
        loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPagina.txt_4c_Moeda
            .Value      = ""
            .Top        = 90
            .Left       = 347
            .Width      = 31
            .Height     = 23
            .FontName   = "Courier New"
            .FontSize   = 8
            .FontItalic = .F.
            .MaxLength  = 3
            .Visible    = .T.
        ENDWITH

        *-- Say2 "Descrição :" - Original Top=92, +29=121, Left=285
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption    = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top        = 121
            .Left       = 285
            .Width      = 60
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- Get_descricao dmoes - Original Top=87, +29=116, Left=347, Width=115
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value      = ""
            .Top        = 116
            .Left       = 347
            .Width      = 115
            .Height     = 23
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .MaxLength  = 15
            .Visible    = .T.
        ENDWITH

        *-- GRUPO 2: Cotacao (checkbox)
        *-- fwcheckbox_cotacao - Original Top=115, +29=144, Left=295, Width=65, Height=15
        loc_oPagina.AddObject("chk_4c_Cotacao", "CheckBox")
        WITH loc_oPagina.chk_4c_Cotacao
            .Caption    = "Cota" + CHR(231) + CHR(227) + "o :"
            .Value      = 0
            .Top        = 144
            .Left       = 295
            .Width      = 65
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .Alignment  = 1
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .T.
            .Visible    = .T.
        ENDWITH

        *-- GRUPO 3: Fator Multiplicador (N/S)
        *-- Say3 - Original Top=139, +29=168, Left=243
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption    = "Fator Multiplicador :"
            .Top        = 168
            .Left       = 243
            .Width      = 100
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- Get_fmult fmults char(1) - Original Top=134, +29=163, Left=347, Width=20
        *-- InputMask "N,S" aceita apenas N ou S
        loc_oPagina.AddObject("txt_4c_Fmult", "TextBox")
        WITH loc_oPagina.txt_4c_Fmult
            .Value      = ""
            .Top        = 163
            .Left       = 347
            .Width      = 20
            .Height     = 23
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .InputMask  = "N,S"
            .Visible    = .T.
        ENDWITH

        *-- GRUPO 4: Spinner - Numero da Coluna nos Relatorios (0-5)
        *-- spnNordrels - Original Top=160, +29=189, Left=347, Width=33, Height=25
        loc_oPagina.AddObject("obj_4c_SpnNordrels", "Spinner")
        WITH loc_oPagina.obj_4c_SpnNordrels
            .Value             = 0
            .Top               = 189
            .Left              = 347
            .Width             = 33
            .Height            = 25
            .FontName          = "Courier New"
            .FontSize          = 8
            .InputMask         = "9"
            .SpinnerHighValue  = 5
            .SpinnerLowValue   = 0
            .KeyboardHighValue = 5
            .KeyboardLowValue  = 0
            .Visible           = .T.
        ENDWITH

        *-- Say4 "Nº da Coluna nos Relatórios :" - Original Top=165, +29=194, Left=197
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption    = "N" + CHR(186) + " da Coluna nos Relat" + CHR(243) + "rios :"
            .Top        = 194
            .Left       = 197
            .Width      = 145
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- GRUPO 5: Moeda Equivalente e Quantidade de Conversao
        *-- Say8 "Moeda Equivalente :" - Original Top=192, +29=221, Left=240, Width=100, Height=15
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption    = "Moeda Equivalente :"
            .Top        = 221
            .Left       = 240
            .Width      = 100
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- Get_moeEq moeqs - Original Top=188, +29=217, Left=347, Width=31
        *-- Lookup em SigCdMoe; When: habilitado apenas quando cotacao NAO marcada
        loc_oPagina.AddObject("txt_4c_MoeEq", "TextBox")
        WITH loc_oPagina.txt_4c_MoeEq
            .Value      = ""
            .Top        = 217
            .Left       = 347
            .Width      = 31
            .Height     = 23
            .FontName   = "Courier New"
            .FontSize   = 8
            .FontItalic = .F.
            .MaxLength  = 3
            .Visible    = .T.
        ENDWITH

        *-- Say9 "Qtde: " - Original Top=192, +29=221, Left=386, Width=33, Height=15
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption    = "Qtde: "
            .Top        = 221
            .Left       = 386
            .Width      = 33
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- Get_Qtde qtdeqs numeric(12,6) - Original Top=188, +29=217, Left=421, Width=92
        *-- Habilitado apenas quando txt_4c_MoeEq tem valor preenchido
        loc_oPagina.AddObject("txt_4c_Qtde", "TextBox")
        WITH loc_oPagina.txt_4c_Qtde
            .Value      = 0
            .Top        = 217
            .Left       = 421
            .Width      = 92
            .Height     = 23
            .FontName   = "Courier New"
            .FontSize   = 8
            .FontItalic = .F.
            .InputMask  = "999999.999999"
            .Visible    = .T.
        ENDWITH

        *-- GRUPO 6: Imprime Tabela Referencia
        *-- fwcheckbox_tabref - Original Top=216, +29=245, Left=156, Width=205, Height=17
        loc_oPagina.AddObject("chk_4c_Tabref", "CheckBox")
        WITH loc_oPagina.chk_4c_Tabref
            .Caption    = "Imprime Tabela Refer" + CHR(234) + "ncia :"
            .Value      = 0
            .Top        = 245
            .Left       = 156
            .Width      = 205
            .Height     = 17
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .BackStyle  = 0
            .Alignment  = 1
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- GRUPO 7: Cond.Pagto Automatica (GET_FPG) - lookup SigOpFp
        *-- Say13 "Cond.Pagto Automática :" - Original Top=242, +29=271, Left=217
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption    = "Cond.Pagto Autom" + CHR(225) + "tica :"
            .Top        = 271
            .Left       = 217
            .Width      = 120
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- GET_FPG fpags char(12) - Original Top=238, +29=267, Left=348, Width=94
        *-- Lookup em SigOpFp (Fpags=cod, Descrs=desc)
        loc_oPagina.AddObject("txt_4c_FPG", "TextBox")
        WITH loc_oPagina.txt_4c_FPG
            .Value      = ""
            .Top        = 267
            .Left       = 348
            .Width      = 94
            .Height     = 23
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .MaxLength  = 12
            .Visible    = .T.
        ENDWITH

        *-- GRUPO 8: Tolerancia Conversao
        *-- Say14 "Tolerância Conversão :" - Original Top=268, +29=297, Left=227, Width=113
        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption    = "Toler" + CHR(226) + "ncia Convers" + CHR(227) + "o :"
            .Top        = 297
            .Left       = 227
            .Width      = 113
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- Get_Toleras toleras numeric(4,2) - Original Top=264, +29=293, Left=348, Width=45
        loc_oPagina.AddObject("txt_4c_Toleras", "TextBox")
        WITH loc_oPagina.txt_4c_Toleras
            .Value      = 0
            .Top        = 293
            .Left       = 348
            .Width      = 45
            .Height     = 23
            .FontName   = "Courier New"
            .FontSize   = 8
            .FontItalic = .F.
            .InputMask  = "99.99"
            .Visible    = .T.
        ENDWITH

        *-- GRUPO 9: Listar na consulta (OptionGroup - Consultas)
        *-- Say15 "Listar na consulta :" - Original Top=293, +29=322, Left=247, Width=93
        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Caption    = "Listar na consulta :"
            .Top        = 322
            .Left       = 247
            .Width      = 93
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .T.
            .Visible    = .T.
        ENDWITH

        *-- opt_tipo Consultas numeric(1) - Original Top=288, +29=317, Left=343
        *-- ButtonCount=2: Buttons(1)="Sim"(Value=1), Buttons(2)="Não"; OptionGroup.Value=1 default
        loc_oPagina.AddObject("obj_4c_OptTipo", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptTipo
            .ButtonCount = 2
            .Top         = 317
            .Left        = 343
            .Width       = 109
            .Height      = 25
            .AutoSize    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTipo.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptTipo.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 62
            .Top       = 5
            .Width     = 37
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- SECAO: Preco na Etiqueta do Produto
        *-- Shape2 separador - Original Top=352, +29=381, Left=150, Width=367, Height=2
        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top           = 381
            .Left          = 150
            .Width         = 367
            .Height        = 2
            .BackStyle     = 0
            .BorderStyle   = 1
            .BorderWidth   = 2
            .SpecialEffect = 0
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Say7 "Preço na Etiqueta do Produto" - Original Top=335, +29=364, Left=150
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption    = "Pre" + CHR(231) + "o na Etiqueta do Produto"
            .Top        = 364
            .Left       = 150
            .Width      = 200
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- Say5 "Codifica na Etiqueta do Produto :" - Original Top=364, +29=393, Left=166
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption    = "Codifica na Etiqueta do Produto :"
            .Top        = 393
            .Left       = 166
            .Width      = 175
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- Get_DisfPres disfpres char(1) - Original Top=359, +29=388, Left=347, Width=20
        *-- InputMask "N,S,A,P" - valores permitidos
        loc_oPagina.AddObject("txt_4c_DisfPres", "TextBox")
        WITH loc_oPagina.txt_4c_DisfPres
            .Value      = ""
            .Top        = 388
            .Left       = 347
            .Width      = 20
            .Height     = 23
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .InputMask  = "N,S,A,P"
            .Visible    = .T.
        ENDWITH

        *-- Say6 "Valor Adicional :" - Original Top=389, +29=418, Left=249
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption    = "Valor Adicional :"
            .Top        = 418
            .Left       = 249
            .Width      = 90
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- GetValAdics valadics numeric(3,0) - Original Top=385, +29=414, Left=347, Width=31
        *-- When: habilitado somente quando disfpres='A'; Valid: valor >= 0
        loc_oPagina.AddObject("txt_4c_ValAdics", "TextBox")
        WITH loc_oPagina.txt_4c_ValAdics
            .Value      = 0
            .Top        = 414
            .Left       = 347
            .Width      = 31
            .Height     = 23
            .FontName   = "Courier New"
            .FontSize   = 8
            .FontItalic = .F.
            .InputMask  = "999"
            .Visible    = .T.
        ENDWITH

        *-- SECAO: Valorizacao do Estoque
        *-- Shape3 separador - Original Top=438, +29=467, Left=150, Width=367, Height=2
        loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPagina.shp_4c_Shape3
            .Top           = 467
            .Left          = 150
            .Width         = 367
            .Height        = 2
            .BackStyle     = 0
            .BorderStyle   = 1
            .BorderWidth   = 2
            .SpecialEffect = 0
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        *-- Say11 "Valorização do Estoque" - Original Top=422, +29=451, Left=150
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption    = "Valoriza" + CHR(231) + CHR(227) + "o do Estoque"
            .Top        = 451
            .Left       = 150
            .Width      = 200
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- Say12 "Grupo :" - Original Top=449, +29=478, Left=299
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption    = "Grupo :"
            .Top        = 478
            .Left       = 299
            .Width      = 45
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- Get_Grupo grumoes char(10) - Original Top=445, +29=474, Left=347, Width=80
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value      = ""
            .Top        = 474
            .Left       = 347
            .Width      = 80
            .Height     = 23
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .MaxLength  = 10
            .Visible    = .T.
        ENDWITH

        *-- Say10 "Sub-Grupo :" - Original Top=475, +29=504, Left=277
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption    = "Sub-Grupo :"
            .Top        = 504
            .Left       = 277
            .Width      = 65
            .Height     = 15
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .F.
            .FontItalic = .F.
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .AutoSize   = .F.
            .Visible    = .T.
        ENDWITH

        *-- Get_Subg submoes char(10) - Original Top=471, +29=500, Left=347, Width=80
        loc_oPagina.AddObject("txt_4c_Subg", "TextBox")
        WITH loc_oPagina.txt_4c_Subg
            .Value      = ""
            .Top        = 500
            .Left       = 347
            .Width      = 80
            .Height     = 23
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontItalic = .F.
            .MaxLength  = 10
            .Visible    = .T.
        ENDWITH

        *-- BINDEVENTs para Page2 - metodos PUBLIC (sem PROTECTED) para funcionar com BINDEVENT
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click",     THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click",     THIS, "BtnCancelarClick")
        BINDEVENT(loc_oPagina.txt_4c_MoeEq,                  "KeyPress", THIS, "ValidarMoeEq")
        BINDEVENT(loc_oPagina.txt_4c_FPG,                    "KeyPress", THIS, "ValidarFpag")
        BINDEVENT(loc_oPagina.txt_4c_FPG,                    "KeyPress",  THIS, "FpgKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_ValAdics,               "KeyPress", THIS, "ValidarValAdics")

        THIS.TornarControlesVisiveis(loc_oPagina)
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
    * FormatarGridLista - Formata visual do grid da lista
    * Fonte Verdana (padrao do framework Grade), tamanho 8
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
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

        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF

        IF USED("cursor_4c_BuscaFpag")
            USE IN cursor_4c_BuscaFpag
        ENDIF

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    * par_nPagina: 1=Lista, 2=Dados
    *==========================================================================
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

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    * Chama MoeBO.Buscar() e vincula cursor ao grid
    * Columns: cmoes (Moeda/120), dmoes (Descricao/330), nordrels (Ordem/129)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (cmoes C(3), dmoes C(15), nordrels N(1,0))
            ENDIF
            loc_lResultado = .T.
        ELSE
            TRY
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cmoes"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dmoes"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.nordrels"

                    *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
                    loc_oGrid.Column1.Header1.Caption = "Moeda"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Ordem de Impress" + CHR(227) + "o"

                    loc_oGrid.Column1.Width = 120
                    loc_oGrid.Column2.Width = 330
                    loc_oGrid.Column3.Width = 129

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

    *==========================================================================
    * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.SetFocus
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega registro selecionado e navega para Page2 leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione uma moeda para visualizar!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cmoes)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega registro selecionado e navega para Page2 edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione uma moeda para alterar!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cmoes)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Confirma e exclui o registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDesc
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione uma moeda para excluir!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cmoes)
        loc_cDesc   = ALLTRIM(cursor_4c_Dados.dmoes)
        IF MsgConfirma("Confirma exclus" + CHR(227) + "o da moeda:" + CHR(13) + ;
                loc_cCodigo + " - " + loc_cDesc, "Excluir Moeda")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Moeda exclu" + CHR(237) + "da com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega a lista de moedas
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnCambioClick - Abre gestao de cotacoes (COTACAO no legado)
    * Original: Do Form SIGPRCOT With ThisForm,ThisForm.DataSessionId
    * Verifica se moeda permite cotacao antes de prosseguir
    *==========================================================================
    PROCEDURE BtnCambioClick()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione uma moeda para acessar o c" + CHR(226) + "mbio!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        IF !(NVL(cursor_4c_Dados.cotas, 0) = 1)
            MsgAviso("Moeda " + ALLTRIM(cursor_4c_Dados.cmoes) + ;
                " n" + CHR(227) + "o permite altera" + CHR(231) + CHR(227) + ;
                "o de cota" + CHR(231) + CHR(227) + "o!", ;
                "C" + CHR(226) + "mbio")
            RETURN
        ENDIF
        MsgInfo("Form de C" + CHR(226) + "mbio (SIGPRCOT) pendente de migra" + ;
            CHR(231) + CHR(227) + "o.", "C" + CHR(226) + "mbio")
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva o registro atual (Confirmar no legado)
    * Validacoes da Salva.Click original:
    *   INSERT: cmoes nao vazio, nao duplicado, nordrels entre 0-5
    *   INSERT/ALTER: disfpres padrao 'S' se vazio (tratado no FormParaBO)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cCodigo, loc_nOrdem, loc_lSucesso
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes ANTES do TRY (RETURN fora de TRY e correto)
        IF THIS.this_cModoAtual = "INCLUIR"
            loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
            IF EMPTY(loc_cCodigo)
                MsgAviso("Moeda inv" + CHR(225) + "lida !!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.txt_4c_Moeda.SetFocus
                RETURN
            ENDIF

            *-- Verificar duplicidade
            loc_lSucesso = .F.
            TRY
                LOCAL loc_nDup
                loc_nDup = SQLEXEC(gnConnHandle, ;
                    "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodigo), ;
                    "cursor_4c_DupCheck")
                IF loc_nDup > 0 AND USED("cursor_4c_DupCheck") AND RECCOUNT("cursor_4c_DupCheck") > 0
                    IF USED("cursor_4c_DupCheck")
                        USE IN cursor_4c_DupCheck
                    ENDIF
                    MsgAviso("Moeda j" + CHR(225) + " cadastrada !!!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oPg2.txt_4c_Moeda.SetFocus
                    RETURN
                ENDIF
                IF USED("cursor_4c_DupCheck")
                    USE IN cursor_4c_DupCheck
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao verificar duplicidade: " + loc_oErro.Message, "Erro")
                IF USED("cursor_4c_DupCheck")
                    USE IN cursor_4c_DupCheck
                ENDIF
                RETURN
            ENDTRY

            *-- Verificar nordrels entre 0-5
            loc_nOrdem = loc_oPg2.obj_4c_SpnNordrels.Value
            IF !BETWEEN(loc_nOrdem, 0, 5)
                MsgAviso("Ordem de Impress" + CHR(227) + "o nos Relat" + CHR(243) + ;
                    "rios Inv" + CHR(225) + "lido !!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg2.obj_4c_SpnNordrels.SetFocus
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Moeda salva com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    * Original: Cancelar.Click chama DoDefault() e mAtivaPagina1 se plCancelar
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * ValidarMoeEq - Lookup de Moeda Equivalente (LostFocus do txt_4c_MoeEq)
    * Original: Get_moeEq.Valid com fwBuscaExt em SigCdMoe
    * Abre FormBuscaAuxiliar se codigo nao encontrado exato
    *==========================================================================
    PROCEDURE ValidarMoeEq
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_oPg2, loc_cMoeEq, loc_oBusca, loc_nResult
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cMoeEq = ALLTRIM(loc_oPg2.txt_4c_MoeEq.Value)

        IF EMPTY(loc_cMoeEq)
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cMoeEq), ;
                "cursor_4c_BuscaMoe")

            IF loc_nResult > 0 AND USED("cursor_4c_BuscaMoe") AND RECCOUNT("cursor_4c_BuscaMoe") > 0
                *-- Encontrou exato, manter valor
                IF USED("cursor_4c_BuscaMoe")
                    USE IN cursor_4c_BuscaMoe
                ENDIF
            ELSE
                *-- Nao encontrou exato, abrir busca
                IF USED("cursor_4c_BuscaMoe")
                    USE IN cursor_4c_BuscaMoe
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", loc_cMoeEq, "Moedas")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        loc_oPg2.txt_4c_MoeEq.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                    ELSE
                        loc_oPg2.txt_4c_MoeEq.Value = ""
                        loc_oPg2.txt_4c_Qtde.Value  = 0
                    ENDIF
                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaMoe")
                    USE IN cursor_4c_BuscaMoe
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar moeda equivalente: " + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * FpgKeyPress - Handler de KeyPress para txt_4c_FPG (F4 abre lookup SigOpFp)
    * BINDEVENT exige metodo PUBLIC com parametros de KeyPress
    *==========================================================================
    PROCEDURE FpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupFpag()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarFpag - LostFocus de txt_4c_FPG: valida condicao de pagamento em SigOpFp
    * Original: GET_FPG.Valid com fwBuscaExt em SigOpFp (Fpags/Descrs)
    *==========================================================================
    PROCEDURE ValidarFpag
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2, loc_cFpag, loc_nResult
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cFpag = ALLTRIM(loc_oPg2.txt_4c_FPG.Value)

        IF EMPTY(loc_cFpag)
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_BuscaFpag")
                USE IN cursor_4c_BuscaFpag
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Fpags, Descrs FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cFpag), ;
                "cursor_4c_BuscaFpag")

            IF loc_nResult > 0 AND USED("cursor_4c_BuscaFpag") AND RECCOUNT("cursor_4c_BuscaFpag") > 0
                *-- Encontrou exato, manter valor
                IF USED("cursor_4c_BuscaFpag")
                    USE IN cursor_4c_BuscaFpag
                ENDIF
            ELSE
                *-- Nao encontrou, abrir busca
                IF USED("cursor_4c_BuscaFpag")
                    USE IN cursor_4c_BuscaFpag
                ENDIF
                THIS.AbrirLookupFpag()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao validar cond. pagamento: " + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_BuscaFpag")
                USE IN cursor_4c_BuscaFpag
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupFpag - Abre FormBuscaAuxiliar para SigOpFp (Cond. Pagamento)
    * Original: GET_FPG.Valid fwBuscaExt SigOpFp / Fpags / Descrs
    *==========================================================================
    PROCEDURE AbrirLookupFpag()
        LOCAL loc_oPg2, loc_cFpag, loc_oBusca
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cFpag = ALLTRIM(loc_oPg2.txt_4c_FPG.Value)

        IF USED("cursor_4c_BuscaFpag")
            USE IN cursor_4c_BuscaFpag
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpFp", "cursor_4c_BuscaFpag", "Fpags", loc_cFpag, ;
            "Condi" + CHR(231) + CHR(245) + "es de Pagamento")

        IF VARTYPE(loc_oBusca) = "O"
            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpag")
                loc_oPg2.txt_4c_FPG.Value = ALLTRIM(cursor_4c_BuscaFpag.Fpags)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oPg2.txt_4c_FPG.Value = ""
                ENDIF
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaFpag")
            USE IN cursor_4c_BuscaFpag
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarValAdics - LostFocus de txt_4c_ValAdics: valor deve ser >= 0
    * Original: GetValAdics.Valid: If This.Value < 0 -> MessageBox + Return 0
    *==========================================================================
    PROCEDURE ValidarValAdics
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF loc_oPg2.txt_4c_ValAdics.Value < 0
            MsgAviso("Valor Inv" + CHR(225) + "lido !!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_ValAdics.Value = 0
            loc_oPg2.txt_4c_ValAdics.SetFocus
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do Form para o BO antes de Salvar
    * Todos os campos: Moeda, Descricao, Cotacao, FMult, Nordrels, MoeEq, Qtde,
    *   Tabref, FPG, Toleras, OptTipo(Consultas), DisfPres, ValAdics, Grupo, Subg
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_cDisfpres
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
            .this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
            .this_lCotas     = (loc_oPg2.chk_4c_Cotacao.Value = 1)
            .this_cFmults    = ALLTRIM(loc_oPg2.txt_4c_Fmult.Value)
            .this_nNordrels  = loc_oPg2.obj_4c_SpnNordrels.Value
            .this_cMoeqs     = ALLTRIM(loc_oPg2.txt_4c_MoeEq.Value)
            .this_nQtdeqs    = loc_oPg2.txt_4c_Qtde.Value
            .this_lTabrefs   = (loc_oPg2.chk_4c_Tabref.Value = 1)
            .this_cFpags     = ALLTRIM(loc_oPg2.txt_4c_FPG.Value)
            .this_nToleras   = loc_oPg2.txt_4c_Toleras.Value
            .this_nConsultas = loc_oPg2.obj_4c_OptTipo.Value
            .this_cDisfpres  = ALLTRIM(loc_oPg2.txt_4c_DisfPres.Value)
            .this_nValadics  = loc_oPg2.txt_4c_ValAdics.Value
            .this_cGrumoes   = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
            .this_cSubmoes   = ALLTRIM(loc_oPg2.txt_4c_Subg.Value)
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para o Form apos CarregarPorCodigo
    * Todos os campos mapeados ao BO
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPg2.txt_4c_Moeda.Value          = ALLTRIM(.this_cCodigo)
            loc_oPg2.txt_4c_Descricao.Value       = ALLTRIM(.this_cDescricao)
            loc_oPg2.chk_4c_Cotacao.Value         = .this_lCotas
            loc_oPg2.txt_4c_Fmult.Value           = ALLTRIM(.this_cFmults)
            loc_oPg2.obj_4c_SpnNordrels.Value     = .this_nNordrels
            loc_oPg2.txt_4c_MoeEq.Value           = ALLTRIM(.this_cMoeqs)
            loc_oPg2.txt_4c_Qtde.Value            = .this_nQtdeqs
            loc_oPg2.chk_4c_Tabref.Value          = .this_lTabrefs
            loc_oPg2.txt_4c_FPG.Value             = ALLTRIM(.this_cFpags)
            loc_oPg2.txt_4c_Toleras.Value         = .this_nToleras
            loc_oPg2.obj_4c_OptTipo.Value         = IIF(.this_nConsultas >= 1 AND .this_nConsultas <= 2, .this_nConsultas, 1)
            loc_oPg2.txt_4c_DisfPres.Value        = ALLTRIM(.this_cDisfpres)
            loc_oPg2.txt_4c_ValAdics.Value        = .this_nValadics
            loc_oPg2.txt_4c_Grupo.Value           = ALLTRIM(.this_cGrumoes)
            loc_oPg2.txt_4c_Subg.Value            = ALLTRIM(.this_cSubmoes)
        ENDWITH
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores de todos os campos do form (todos mapeados)
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Moeda.Value          = ""
        loc_oPg2.txt_4c_Descricao.Value       = ""
        loc_oPg2.chk_4c_Cotacao.Value         = 0
        loc_oPg2.txt_4c_Fmult.Value           = ""
        loc_oPg2.obj_4c_SpnNordrels.Value     = 0
        loc_oPg2.txt_4c_MoeEq.Value           = ""
        loc_oPg2.txt_4c_Qtde.Value            = 0
        loc_oPg2.chk_4c_Tabref.Value          = 0
        loc_oPg2.txt_4c_FPG.Value             = ""
        loc_oPg2.txt_4c_Toleras.Value         = 0
        loc_oPg2.obj_4c_OptTipo.Value         = 1
        loc_oPg2.txt_4c_DisfPres.Value        = ""
        loc_oPg2.txt_4c_ValAdics.Value        = 0
        loc_oPg2.txt_4c_Grupo.Value           = ""
        loc_oPg2.txt_4c_Subg.Value            = ""
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme o modo atual
    * par_lHabilitar: .T. = edicao (INCLUIR/ALTERAR), .F. = leitura (VISUALIZAR)
    * Regra: txt_4c_Moeda (PK) so habilitado no modo INCLUIR
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lCodigo
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lCodigo = (THIS.this_cModoAtual = "INCLUIR")

        loc_oPg2.txt_4c_Moeda.Enabled          = loc_lCodigo
        loc_oPg2.txt_4c_Descricao.Enabled       = par_lHabilitar
        loc_oPg2.chk_4c_Cotacao.Enabled         = par_lHabilitar
        loc_oPg2.txt_4c_Fmult.Enabled           = par_lHabilitar
        loc_oPg2.obj_4c_SpnNordrels.Enabled     = par_lHabilitar
        loc_oPg2.txt_4c_MoeEq.Enabled           = par_lHabilitar
        loc_oPg2.txt_4c_Qtde.Enabled            = par_lHabilitar
        loc_oPg2.chk_4c_Tabref.Enabled          = par_lHabilitar
        loc_oPg2.txt_4c_FPG.Enabled             = par_lHabilitar
        loc_oPg2.txt_4c_Toleras.Enabled         = par_lHabilitar
        loc_oPg2.obj_4c_OptTipo.Enabled         = par_lHabilitar
        loc_oPg2.txt_4c_DisfPres.Enabled        = par_lHabilitar
        loc_oPg2.txt_4c_ValAdics.Enabled        = par_lHabilitar
        loc_oPg2.txt_4c_Grupo.Enabled           = par_lHabilitar
        loc_oPg2.txt_4c_Subg.Enabled            = par_lHabilitar
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 pelo modo atual
    * INCLUIR/ALTERAR: Confirmar habilitado, Cancelar habilitado
    * VISUALIZAR: Confirmar desabilitado, Cancelar habilitado (padrao canonico)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lPodeConfirmar
        loc_oPg2           = THIS.pgf_4c_Paginas.Page2
        loc_lPodeConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lPodeConfirmar
        loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

ENDDEFINE
