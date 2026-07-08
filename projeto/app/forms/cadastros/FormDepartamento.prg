*==============================================================================
* FormDepartamento.prg - Formulario de Cadastro de Departamentos
* Tabela: SigCdDpt | PK: codigos
* Legado: SIGCDDPT.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormDepartamento AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Departamentos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2
    FontName    = "Tahoma"
    ForeColor   = RGB(90, 90, 90)

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("DepartamentoBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object DepartamentoBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Pula CarregarLista() em modo de validacao UI
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Falha nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao inicializar FormDepartamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura PageFrame principal
    * Legado: pagina.Width=1003, PageFrame.Top=-29 (oculta abas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption  = "Lista"
            .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption  = "Dados"
            .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Compensacao +29: PageFrame.Top=-29 desloca conteudo 29px para cima
    * cnt_4c_Cabecalho: Top=2+29=31 | cnt_4c_Botoes: Top=0+29=29
    * grd_4c_Lista: Top=107+29=136, Left=30, Width=941, Height=470
    * Colunas: codigos(80), Descricaos(290), Diretors(80)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (cntSombra: Top=2 -> 31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackStyle   = 1
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
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
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
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (grupo_op: Left=544, Top=0 -> 29, Width=390, Height=85)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (inserir: Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (consultar: Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (alterar: Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (excluir: Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 230
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (procurar: Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 305
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida (grupo_saida: Left=919, Top=0 -> 29, Width=85, Height=85)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grade de lista (grade: Left=30, Top=107 -> 136, Width=941, Height=470)
        *-- 3 colunas: codigos(80), Descricaos(290), Diretors(80)
        *-- FontName="Tahoma" conforme original
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 3
        WITH loc_oPagina.grd_4c_Lista
            .Top               = 136
            .Left              = 30
            .Width             = 941
            .Height            = 470
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .GridLines         = 3
            .GridLineColor     = RGB(192, 192, 192)
            .AllowHeaderSizing = .T.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .HighlightStyle    = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .RowHeight         = 18
            .Visible           = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Compensacao +29 em TODOS os controles
    * cnt_4c_BotoesAcao: Top=4+29=33, Left=834, Width=160, Height=85
    * Campos de dados com posicoes do legado + 29
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *======================================================================
        *-- Container de botoes Salvar/Cancelar
        *-- grupo_salva: Left=834, Top=4 -> 33, Width=160, Height=85
        *======================================================================
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 834
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *======================================================================
        *-- Campos de dados (todos com +29 de compensacao)
        *-- Label1 (C" + CHR(243) + "digo): Top=158+29=187, Left=377
        *-- getcodigos: Top=152+29=181, Left=421, Width=80
        *======================================================================
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 187
            .Left      = 377
            .Width     = 42
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value         = ""
            .Top           = 181
            .Left          = 421
            .Width         = 80
            .Height        = 21
            .MaxLength     = 10
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label2 (Descri" + CHR(231) + CHR(227) + "o): Top=181+29=210, Left=364
        *-- getDescricaos: Top=177+29=206, Left=421, Width=290, Height=23
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 210
            .Left      = 364
            .Width     = 55
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descricaos", "TextBox")
        WITH loc_oPagina.txt_4c_Descricaos
            .Value         = ""
            .Top           = 206
            .Left          = 421
            .Width         = 290
            .Height        = 23
            .MaxLength     = 40
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH

        *-- Label3 (Diretor): Top=206+29=235, Left=377
        *-- getDiretores: Top=202+29=231, Left=421, Width=80, Height=23
        loc_oPagina.AddObject("lbl_4c_Diretor", "Label")
        WITH loc_oPagina.lbl_4c_Diretor
            .Caption   = "Diretor :"
            .Top       = 235
            .Left      = 377
            .Width     = 42
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Diretores", "TextBox")
        WITH loc_oPagina.txt_4c_Diretores
            .Value         = ""
            .Top           = 231
            .Left          = 421
            .Width         = 80
            .Height        = 23
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Diretores, "KeyPress", THIS, "ValidarDiretor")

        *-- Label4 (Obriga Subclas. Encerramento): Top=231+29=260, Left=265
        *-- Optiongroup1 (nChkSubs): Top=228+29=257, Left=416, Width=109, Height=24
        loc_oPagina.AddObject("lbl_4c_ChkSubs", "Label")
        WITH loc_oPagina.lbl_4c_ChkSubs
            .Caption   = "Obriga Subclas. Encerramento :"
            .Top       = 260
            .Left      = 265
            .Width     = 154
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_ChkSubs", "OptionGroup")
        WITH loc_oPagina.opt_4c_ChkSubs
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 257
            .Left        = 416
            .Width       = 132
            .Height      = 24
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_ChkSubs.Buttons(1)
            .Caption   = "Sim"
            .Value     = 1
            .Left      = 5
            .Top       = 3
            .Width     = 61
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_ChkSubs.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 61
            .Top       = 3
            .Width     = 61
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label5 (Tipo): Top=249+29=278, Left=390
        *-- Optiongroup2 (nChkTipos): Top=246+29=275, Left=416, Width=109, Height=24
        loc_oPagina.AddObject("lbl_4c_ChkTipos", "Label")
        WITH loc_oPagina.lbl_4c_ChkTipos
            .Caption   = "Tipo :"
            .Top       = 278
            .Left      = 390
            .Width     = 29
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_ChkTipos", "OptionGroup")
        WITH loc_oPagina.opt_4c_ChkTipos
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 275
            .Left        = 416
            .Width       = 132
            .Height      = 24
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_ChkTipos.Buttons(1)
            .Caption   = "Sim"
            .Value     = 1
            .Left      = 5
            .Top       = 3
            .Width     = 61
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_ChkTipos.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 61
            .Top       = 3
            .Width     = 61
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label6 (Autom" + CHR(225) + "tico): Top=267+29=296, Left=359
        *-- optAutos: Top=264+29=293, Left=416, Width=109, Height=24
        *-- Option1.Value=0 (Sim/autos=0), Option2.Value=1 (N" + CHR(227) + "o/autos=1)
        loc_oPagina.AddObject("lbl_4c_Autos", "Label")
        WITH loc_oPagina.lbl_4c_Autos
            .Caption   = "Autom" + CHR(225) + "tico:"
            .Top       = 296
            .Left      = 359
            .Width     = 60
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Autos", "OptionGroup")
        WITH loc_oPagina.opt_4c_Autos
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 293
            .Left        = 416
            .Width       = 132
            .Height      = 24
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Autos.Buttons(1)
            .Caption   = "Sim"
            .Value     = 0
            .Left      = 5
            .Top       = 3
            .Width     = 61
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Autos.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Value     = 1
            .Left      = 61
            .Top       = 3
            .Width     = 61
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid da Page1
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.diretors"

                    loc_oGrid.Column1.Width = 80
                    loc_oGrid.Column2.Width = 290
                    loc_oGrid.Column3.Width = 80

                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Departamento"
                    loc_oGrid.Column3.Header1.Caption = "Diretor"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.CarregarLista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.AlternarPagina:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
            THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)
            THIS.this_oBusinessObject.this_cDiretor   = ALLTRIM(loc_oPagina.txt_4c_Diretores.Value)

            *-- nchksubs: opt.Value=1(Sim)=DB 1, opt.Value=2(N" + CHR(227) + "o)=DB 0
            THIS.this_oBusinessObject.this_nChkSubs  = IIF(loc_oPagina.opt_4c_ChkSubs.Value = 1, 1, 0)
            THIS.this_oBusinessObject.this_nChkTipos = IIF(loc_oPagina.opt_4c_ChkTipos.Value = 1, 1, 0)

            *-- autos: Option1.Value=0(Sim/autos=0), Option2.Value=1(N" + CHR(227) + "o/autos=1)
            THIS.this_oBusinessObject.this_nAutos = loc_oPagina.opt_4c_Autos.Value
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.FormParaBO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do Business Object para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPagina.txt_4c_Codigos.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
            loc_oPagina.txt_4c_Descricaos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
            loc_oPagina.txt_4c_Diretores.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cDiretor)

            *-- nchksubs: DB 1=Sim(opt.Value=1), DB 0=N" + CHR(227) + "o(opt.Value=2)
            loc_oPagina.opt_4c_ChkSubs.Value  = IIF(THIS.this_oBusinessObject.this_nChkSubs = 1, 1, 2)
            loc_oPagina.opt_4c_ChkTipos.Value = IIF(THIS.this_oBusinessObject.this_nChkTipos = 1, 1, 2)

            *-- autos: DB 0=Sim(opt.Value=0), DB 1=N" + CHR(227) + "o(opt.Value=1)
            loc_oPagina.opt_4c_Autos.Value = THIS.this_oBusinessObject.this_nAutos
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.BOParaForm:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPagina.txt_4c_Codigos.Value    = ""
            loc_oPagina.txt_4c_Descricaos.Value = ""
            loc_oPagina.txt_4c_Diretores.Value  = ""
            loc_oPagina.opt_4c_ChkSubs.Value    = 2
            loc_oPagina.opt_4c_ChkTipos.Value   = 2
            *-- optAutos: default N" + CHR(227) + "o (autos=1, opt.Value=1) conforme original
            loc_oPagina.opt_4c_Autos.Value      = 1
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.LimparCampos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lEdit
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lEdit   = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)

        TRY
            *-- Codigo: editavel apenas em INCLUIR
            loc_oPagina.txt_4c_Codigos.ReadOnly  = !(loc_lEdit AND THIS.this_cModoAtual = "INCLUIR")
            loc_oPagina.txt_4c_Descricaos.ReadOnly = !loc_lEdit
            loc_oPagina.txt_4c_Diretores.ReadOnly  = !loc_lEdit

            *-- OptionGroups: habilitar/desabilitar buttons
            loc_oPagina.opt_4c_ChkSubs.Enabled  = loc_lEdit
            loc_oPagina.opt_4c_ChkTipos.Enabled = loc_lEdit
            loc_oPagina.opt_4c_Autos.Enabled    = loc_lEdit

            *-- Botoes de acao
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdit
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.HabilitarCampos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_lLista
        loc_oPg1  = THIS.pgf_4c_Paginas.Page1
        loc_lLista = (THIS.this_cModoAtual = "LISTA")

        TRY
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled   = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled   = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled   = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled    = loc_lLista
            loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled   = loc_lLista
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.AjustarBotoesPorModo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia inclusao de novo departamento
    * Legado: optAutos.Value=2 (N" + CHR(227) + "o), foco em getcodigos
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.BtnIncluirClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre registro selecionado para visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione um registro na lista.", "Aviso")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.LimparCampos()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.BtnVisualizarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre registro selecionado para alteracao
    * Legado: foco em getDescricaos, optAutos fixado se vazio
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione um registro na lista.", "Aviso")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.LimparCampos()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AlternarPagina(2)
                    *-- Se optAutos sem selecao valida, manter N" + CHR(227) + "o por seguranca
                    LOCAL loc_nAutoVal
                    loc_nAutoVal = THIS.pgf_4c_Paginas.Page2.opt_4c_Autos.Value
                    IF EMPTY(loc_nAutoVal) OR loc_nAutoVal < 0
                        THIS.pgf_4c_Paginas.Page2.opt_4c_Autos.Value = 1
                    ENDIF
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Descricaos.SetFocus
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.BtnAlterarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado
    * Legado: verifica uso em SigCdUsu antes de excluir
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
            ENDIF

            IF EMPTY(loc_cCodigo)
                MsgAviso("Selecione um registro na lista.", "Aviso")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.LimparCampos()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "EXCLUIR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.BtnExcluirClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Busca registro por codigo
    * Legado: msv_procurar -> LocateCursor('crSigCdDpt','codigos',getcodigos.Value)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdDpt", "cursor_4c_BuscaDpt", "codigos", loc_cCodigo, ;
                "Buscar Departamento")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Departamento")
                    loc_oBusca.mAddColuna("diretors",   "", "Diretor")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDpt")
                    SELECT cursor_4c_BuscaDpt
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaDpt.codigos)
                    *-- Posicionar grid na linha correspondente
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(cursor_4c_Dados.codigos) = loc_cCodigo
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaDpt")
                USE IN cursor_4c_BuscaDpt
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_BuscaDpt")
                USE IN cursor_4c_BuscaDpt
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.BtnEncerrarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e salva o registro
    * Legado: valida codigo+descricao, ChkRegister, optAutos unicidade
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cCodigo, loc_cDescricao
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo   = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
        loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)

        *-- Validacoes FORA do TRY (permitem RETURN direto)
        IF THIS.this_cModoAtual = "EXCLUIR"
            *-- Modo exclusao: apenas confirmar
            IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do departamento '" + loc_cCodigo + "'?", "Exclus" + CHR(227) + "o")
                RETURN
            ENDIF
            IF !THIS.this_oBusinessObject.Excluir()
                RETURN
            ENDIF
            MsgSucesso("Departamento exclu" + CHR(237) + "do com sucesso!")
            THIS.AlternarPagina(1)
            THIS.this_cModoAtual = "LISTA"
            RETURN
        ENDIF

        IF THIS.this_cModoAtual = "VISUALIZAR"
            THIS.AlternarPagina(1)
            THIS.this_cModoAtual = "LISTA"
            RETURN
        ENDIF

        *-- Validacoes de campo obrigatorio
        IF EMPTY(loc_cCodigo)
            MsgAviso("O C" + CHR(243) + "digo precisa ser Informado...", "Validacao")
            loc_oPagina.txt_4c_Codigos.SetFocus
            RETURN
        ENDIF

        IF EMPTY(loc_cDescricao)
            MsgAviso("A Descri" + CHR(231) + CHR(227) + "o precisa ser Informada...", "Validacao")
            loc_oPagina.txt_4c_Descricaos.SetFocus
            RETURN
        ENDIF

        TRY
            *-- Verificar unicidade do codigo (apenas no INSERT)
            IF THIS.this_cModoAtual = "INCLUIR"
                LOCAL loc_cSQLChk, loc_nChk
                loc_cSQLChk = "SELECT COUNT(*) AS nExiste FROM SigCdDpt WHERE codigos = " + EscaparSQL(loc_cCodigo)
                loc_nChk = SQLEXEC(gnConnHandle, loc_cSQLChk, "cursor_4c_ChkCod")
                IF loc_nChk >= 0 AND RECCOUNT("cursor_4c_ChkCod") > 0
                    SELECT cursor_4c_ChkCod
                    IF cursor_4c_ChkCod.nExiste > 0
                        IF USED("cursor_4c_ChkCod")
                            USE IN cursor_4c_ChkCod
                        ENDIF
                        MsgAviso("C" + CHR(243) + "digo do Departamento j" + CHR(225) + " Cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
                        loc_oPagina.txt_4c_Codigos.SetFocus
                        RETURN
                    ENDIF
                ENDIF
                IF USED("cursor_4c_ChkCod")
                    USE IN cursor_4c_ChkCod
                ENDIF
            ENDIF

            *-- Verificar unicidade do registro automatico (optAutos.Value=1 = N" + CHR(227) + "o = autos=1)
            IF loc_oPagina.opt_4c_Autos.Value = 1
                LOCAL loc_cSQLAuto, loc_nAuto
                loc_cSQLAuto = "SELECT COUNT(*) AS nAutos FROM SigCdDpt WHERE autos = 1 AND codigos <> " + EscaparSQL(loc_cCodigo)
                loc_nAuto = SQLEXEC(gnConnHandle, loc_cSQLAuto, "cursor_4c_ChkAuto")
                IF loc_nAuto >= 0 AND RECCOUNT("cursor_4c_ChkAuto") > 0
                    SELECT cursor_4c_ChkAuto
                    IF cursor_4c_ChkAuto.nAutos > 0
                        IF USED("cursor_4c_ChkAuto")
                            USE IN cursor_4c_ChkAuto
                        ENDIF
                        MsgAviso("J" + CHR(225) + " existe registro com c" + CHR(243) + "digo autom" + CHR(225) + "tico!", "Aviso")
                        loc_oPagina.opt_4c_Autos.SetFocus
                        RETURN
                    ENDIF
                ENDIF
                IF USED("cursor_4c_ChkAuto")
                    USE IN cursor_4c_ChkAuto
                ENDIF
            ENDIF

            *-- Transferir Form -> BO e salvar
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgSucesso("Departamento salvo com sucesso!")
                THIS.AlternarPagina(1)
                THIS.this_cModoAtual = "LISTA"
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.BtnSalvarClick:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
            IF USED("cursor_4c_ChkAuto")
                USE IN cursor_4c_ChkAuto
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.AlternarPagina(1)
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.BtnCancelarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDiretor - LostFocus em txt_4c_Diretores: valida e abre lookup
    * Legado: getDiretores.Valid -> fwBuscaExt em SigCdUsu filtro cAtivos<>'N'
    * Colunas: Usuarios (Diretor), NComps (Nome)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDiretor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ""

        TRY
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Diretores.Value)

            IF EMPTY(loc_cValor)
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaDiretor", "Usuarios", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", .T., .F., "cAtivos <> 'N'")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Usuarios", "", "Diretor")
                    loc_oBusca.mAddColuna("NComps",   "", "Nome")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDiretor")
                    SELECT cursor_4c_BuscaDiretor
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaDiretor.Usuarios)
                ELSE
                    IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Diretores.Value = ""
                    ELSE
                        IF loc_oBusca.this_lAchouRegistro AND USED("cursor_4c_BuscaDiretor")
                            SELECT cursor_4c_BuscaDiretor
                            THIS.pgf_4c_Paginas.Page2.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaDiretor.Usuarios)
                        ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaDiretor")
                USE IN cursor_4c_BuscaDiretor
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.ValidarDiretor:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_BuscaDiretor")
                USE IN cursor_4c_BuscaDiretor
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
                .SetAll("ForeColor", RGB(90, 90, 90), "Column")
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.FormatarGridLista:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Filtrar containers que devem iniciar ocultos (nenhum neste form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome
        loc_nI    = 0
        loc_oObjeto = .NULL.
        loc_cNome  = ""

        TRY
            FOR loc_nI = 1 TO par_oContainer.ControlCount
                loc_oObjeto = par_oContainer.Controls(loc_nI)

                IF VARTYPE(loc_oObjeto) = "O"
                    IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                        loc_oObjeto.Visible = .T.
                    ENDIF

                    IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                        LOCAL loc_nP
                        FOR loc_nP = 1 TO loc_oObjeto.PageCount
                            THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                        ENDFOR
                    ENDIF

                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loException
            MostrarErro("Erro em FormDepartamento.TornarControlesVisiveis:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Liberacao de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_BuscaDiretor")
                USE IN cursor_4c_BuscaDiretor
            ENDIF
        CATCH TO loException
            *-- Ignorar erros na destruicao
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
