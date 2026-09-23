*==============================================================================
* FormVEN.prg - Formulario de Cadastro de Presenca de Vendedores
* Migrado de: SIGCDVEN.SCX (frmcadastro)
* Tabela: SigCdVen | PK: codigo
*==============================================================================

DEFINE CLASS FormVEN AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Presenca de Vendedores"
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

    *-- Guardas anti-retrigger para validacoes LostFocus (Problema 45)
    this_cUltimoEmpsValidado     = ""
    this_cUltimoVensValidado     = ""
    this_cUltimoDVensValidado    = ""
    this_cUltimaSituacaoValidada = ""

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
            THIS.Caption = "Cadastro de Presen" + CHR(231) + "a de Vendedores"

            THIS.this_oBusinessObject = CREATEOBJECT("VENBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar VENBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormVEN.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormVEN:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormVEN.InicializarForm")
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
    * ConfigurarPaginaLista - Estrutura completa da Page1 (Lista)
    * Cabecalho canonico (1o AddObject) + botoes CRUD (Grupo_op) +
    * cnt_4c_Saida/Encerrar (padrao canonico, regra #10) + Grid de listagem
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - Top=2+29=31
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

        *-- Container Botoes CRUD (Grupo_op no legado)
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

        *-- Botao Incluir (Left=5)
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

        *-- Botao Visualizar (Left=80)
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

        *-- Botao Alterar (Left=155)
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

        *-- Botao Excluir (Left=230)
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

        *-- Botao Buscar (Left=305)
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

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, regra #10)
        *-- Legado: Grupo_Saida.Left=919, Top=-1. Canonico: Left=917, Top=29, Width=90
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

        *-- Grid de listagem de vendedores
        *-- Original: Grade.Top=131, Left=29, Width=940, Height=456
        *-- Canonico framework: Top=160 (131+29 compensacao), Left=26, Width=880, Height=456
        *-- (Width=880 para nao sobrepor cnt_4c_Saida em Left=917; Height preservada do legado)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 11
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 160
            .Left               = 26
            .Width              = 880
            .Height             = 456
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
    * ConfigurarPaginaDados - Estrutura completa da Page2 (Dados)
    * Cabecalho canonico (1o AddObject) + container de botoes Confirmar/Cancelar
    * + todos os campos de dados do vendedor + lookups/validacoes via BINDEVENT
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - regra #11
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

        *-- Container BotoesAcao (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Grupo_Salva.Salva no legado)
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

        *-- Botao Cancelar (Grupo_Salva.Cancelar no legado)
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

        *-- Codigo: Say7.Top=124, getcodigo.Top=121 (legado: When retorna .F. - nunca recebe foco)
        *-- Sem shift de cabecalho: primeiro controle (Top=121) ja fica abaixo da faixa (29+80=109) - regra #11
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "C" + CHR(243) + "digo : "
            .Top       = 124
            .Left      = 325
            .Width     = 47
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 121
            .Left          = 372
            .Width         = 160
            .Height        = 24
            .MaxLength     = 20
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Loja/Empresa: Say1.Top=151, getEmps.Top=148 (editavel so em INCLUIR)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Cod Loja : "
            .Top       = 151
            .Left      = 316
            .Width     = 56
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPagina.txt_4c_Emps
            .Value         = ""
            .Top           = 148
            .Left          = 372
            .Width         = 33
            .Height        = 24
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        *-- Lookup/validacao: LostFocus busca UF em SigcdEmp + fAcessoEmpresa (regra #27, VerificarAcessoEmpresa)
        BINDEVENT(loc_oPagina.txt_4c_Emps, "KeyPress", THIS, "ValidarEmpsDados")

        *-- Empresa Registro: Say12.Top=152, GetEmpReg.Top=148 (readonly, preenchido via pegaempreg)
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Empresa Registro :"
            .Top       = 152
            .Left      = 590
            .Width     = 95
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_EmpReg", "TextBox")
        WITH loc_oPagina.txt_4c_EmpReg
            .Value         = ""
            .Top           = 148
            .Left          = 685
            .Width         = 33
            .Height        = 24
            .MaxLength     = 3
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Estado: Say3.Top=178, GetUfs.Top=175 (readonly, preenchido via lookup de Emps)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Estado : "
            .Top       = 178
            .Left      = 325
            .Width     = 47
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ufs", "TextBox")
        WITH loc_oPagina.txt_4c_Ufs
            .Value         = ""
            .Top           = 175
            .Left          = 372
            .Width         = 33
            .Height        = 24
            .MaxLength     = 2
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Grupo Vendedor: Say8.Top=205, getGrupo.Top=202 (readonly, legado: When retorna .F.)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Grupo Vendedor :"
            .Top       = 205
            .Left      = 280
            .Width     = 92
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value         = ""
            .Top           = 202
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .MaxLength     = 10
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Cod Vendedor: Say2.Top=232, GetVens.Top=229 (editavel so em INCLUIR) + GetdVens (descricao, readonly)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Cod Vendedor :"
            .Top       = 232
            .Left      = 290
            .Width     = 82
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Vens", "TextBox")
        WITH loc_oPagina.txt_4c_Vens
            .Value         = ""
            .Top           = 229
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DVens", "TextBox")
        WITH loc_oPagina.txt_4c_DVens
            .Value         = ""
            .Top           = 229
            .Left          = 468
            .Width         = 250
            .Height        = 24
            .MaxLength     = 50
            .Enabled       = .F.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- Lookup/validacao: fAcessoContas 'C'/'D' (portada em utils\functions.prg) + pegaempreg (so no Cod Vendedor)
        BINDEVENT(loc_oPagina.txt_4c_Vens,  "KeyPress", THIS, "ValidarVensDados")
        BINDEVENT(loc_oPagina.txt_4c_DVens, "KeyPress", THIS, "ValidarDVensDados")

        *-- Data Inicial: Say5.Top=259, getDtini.Top=256 (editavel em INCLUIR/ALTERAR)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Data Inicial :"
            .Top       = 259
            .Left      = 305
            .Width     = 67
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
        WITH loc_oPagina.txt_4c_Dtini
            .Value         = {}
            .Top           = 256
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Data Final: Say6.Top=286, GetDtfin.Top=283 (editavel em INCLUIR/ALTERAR)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Data Final :"
            .Top       = 286
            .Left      = 310
            .Width     = 62
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dtfin", "TextBox")
        WITH loc_oPagina.txt_4c_Dtfin
            .Value         = {}
            .Top           = 283
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Situacao: Say4.Top=313, CmbSituas.Top=310 (RowSource EXATO do legado)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o : "
            .Top       = 313
            .Left      = 317
            .Width     = 55
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("cbo_4c_CmbSituas", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbSituas
            .RowSourceType = 1
            .RowSource     = "ATIVO,AFASTADO POR ACIDENTE,AFASTADO POR DOENCA,AFASTADO POR MATERNIDADE,DEMITIDO,FERIAS,TREINAMENTO,FOLGA"
            .Value         = ""
            .Top           = 310
            .Left          = 372
            .Width         = 160
            .Height        = 24
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        *-- Validacao: FOLGA exige fChecaAcesso ou usuario/vendedor na mesma empresa (transcrito do legado)
        BINDEVENT(loc_oPagina.cbo_4c_CmbSituas, "KeyPress", THIS, "ValidarSituacao")

        *-- Cargo: Say9.Top=340, cmbCargo.Top=337 (RowSource EXATO do legado)
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Cargo : "
            .Top       = 340
            .Left      = 329
            .Width     = 43
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("cbo_4c_CmbCargo", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbCargo
            .RowSourceType = 1
            .RowSource     = "GERENTE,VENDEDOR"
            .Value         = ""
            .Top           = 337
            .Left          = 372
            .Width         = 160
            .Height        = 24
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Comissao %: Say10.Top=369, getpdes.Top=364 (InputMask EXATO do legado)
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "Comiss" + CHR(227) + "o % : "
            .Top       = 369
            .Left      = 299
            .Width     = 73
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Comis", "TextBox")
        WITH loc_oPagina.txt_4c_Comis
            .Value         = 0
            .Top           = 364
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Subsidio %: Say11.Top=396, getSubsidio.Top=391 (InputMask EXATO do legado)
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "Subs" + CHR(237) + "dio % : "
            .Top       = 396
            .Left      = 305
            .Width     = 67
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Subsidio", "TextBox")
        WITH loc_oPagina.txt_4c_Subsidio
            .Value         = 0
            .Top           = 391
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Meta %: Say13.Top=423, getpmeta.Top=418 (InputMask EXATO do legado)
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Meta % : "
            .Top       = 423
            .Left      = 320
            .Width     = 52
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Pmeta", "TextBox")
        WITH loc_oPagina.txt_4c_Pmeta
            .Value         = 0
            .Top           = 418
            .Left          = 372
            .Width         = 94
            .Height        = 24
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega cursor_4c_Dados via VENBO.Buscar() e configura o Grid
    * Colunas espelham o legado (Init: AddCursor + pColuna x11)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- PROBLEMA 48: ColumnCount/RecordSource ANTES de ControlSource (FORA do WITH - Problema 36)
                loc_oGrid.ColumnCount  = 11
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codvens"
                loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.nome"
                loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.emps"
                loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.empreg"
                loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.gruvens"
                loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.dtini"
                loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.dtfin"
                loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.situas"
                loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.cargo"
                loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.usualts"
                loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.dtalts"

                *-- Larguras EXATAS do legado (Init: pColuna(...,largura,...))
                loc_oGrid.Column1.Width  = 75
                loc_oGrid.Column2.Width  = 150
                loc_oGrid.Column3.Width  = 75
                loc_oGrid.Column4.Width  = 75
                loc_oGrid.Column5.Width  = 75
                loc_oGrid.Column6.Width  = 75
                loc_oGrid.Column7.Width  = 75
                loc_oGrid.Column8.Width  = 75
                loc_oGrid.Column9.Width  = 75
                loc_oGrid.Column10.Width = 75
                loc_oGrid.Column11.Width = 75

                *-- PROBLEMA 2/32/40: Headers APOS RecordSource, captions EXATOS do legado
                loc_oGrid.Column1.Header1.Caption  = "Vendedor"
                loc_oGrid.Column2.Header1.Caption  = "Nome"
                loc_oGrid.Column3.Header1.Caption  = "Empresa"
                loc_oGrid.Column4.Header1.Caption  = "Emp Reg"
                loc_oGrid.Column5.Header1.Caption  = "Grupo"
                loc_oGrid.Column6.Header1.Caption  = "Dt In" + CHR(237) + "cio"
                loc_oGrid.Column7.Header1.Caption  = "Dt Final"
                loc_oGrid.Column8.Header1.Caption  = "Situa" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column9.Header1.Caption  = "Cargo"
                loc_oGrid.Column10.Header1.Caption = "Usu" + CHR(225) + "rio"
                loc_oGrid.Column11.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormVEN.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
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
                "FormVEN.AlternarPagina")
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
                "FormVEN.FormatarGridLista")
        ENDTRY
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
    * BtnIncluirClick - Abre Page2 para incluir novo registro
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 para alterar registro selecionado
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do vendedor [" + loc_cCodigo + "]?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre picker para localizar registro na lista
    * Apos selecao, posiciona o cursor no registro encontrado
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdVen", "cursor_4c_BuscaVen", "codigo", "", ;
                "Buscar Vendedor")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigo",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("codvens", "", "Vendedor")
                loc_oBusca.mAddColuna("situas",  "", "Situa" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVen")
                    SELECT cursor_4c_BuscaVen
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaVen.codigo)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaVen")
                USE IN cursor_4c_BuscaVen
            ENDIF

            IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(codigo) == loc_cCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormVEN.BtnBuscarClick")
            IF USED("cursor_4c_BuscaVen")
                USE IN cursor_4c_BuscaVen
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
    *
    * Campos SEMPRE readonly no legado (When retorna .F. / preenchidos por lookup):
    *   txt_4c_Codigo, txt_4c_Ufs, txt_4c_Grupo, txt_4c_EmpReg
    * txt_4c_DVens: editavel apenas quando txt_4c_Vens esta vazio (legado:
    *   When = Empty(Parent.GetVens.Value)) - permite busca por descricao
    * Campos editaveis SOMENTE em modo INCLUIR (When = INLIST(pcEscolha,'INSERIR')):
    *   txt_4c_Emps, txt_4c_Vens
    * Campos editaveis em INCLUIR e ALTERAR:
    *   txt_4c_Dtini, txt_4c_Dtfin, cbo_4c_CmbSituas, cbo_4c_CmbCargo,
    *   txt_4c_Comis, txt_4c_Subsidio, txt_4c_Pmeta
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Emps", 5)
            loc_oPagina.txt_4c_Emps.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Vens", 5)
            loc_oPagina.txt_4c_Vens.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_DVens", 5)
            loc_oPagina.txt_4c_DVens.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR") ;
                AND EMPTY(ALLTRIM(loc_oPagina.txt_4c_Vens.Value))
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Dtini", 5)
            loc_oPagina.txt_4c_Dtini.Enabled = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Dtfin", 5)
            loc_oPagina.txt_4c_Dtfin.Enabled = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        ENDIF

        IF PEMSTATUS(loc_oPagina, "cbo_4c_CmbSituas", 5)
            loc_oPagina.cbo_4c_CmbSituas.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina, "cbo_4c_CmbCargo", 5)
            loc_oPagina.cbo_4c_CmbCargo.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Comis", 5)
            loc_oPagina.txt_4c_Comis.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Subsidio", 5)
            loc_oPagina.txt_4c_Subsidio.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina, "txt_4c_Pmeta", 5)
            loc_oPagina.txt_4c_Pmeta.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
    * INCLUIR/ALTERAR: Confirmar habilitado | VISUALIZAR: Confirmar desabilitado
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditando
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
            ENDIF
            IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos da Page2 para o BusinessObject
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina, loc_oBO
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oBO     = THIS.this_oBusinessObject

        loc_oBO.this_cEmps     = ALLTRIM(loc_oPagina.txt_4c_Emps.Value)
        loc_oBO.this_cUfs      = ALLTRIM(loc_oPagina.txt_4c_Ufs.Value)
        loc_oBO.this_cGrupo    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_oBO.this_cCodVens  = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
        loc_oBO.this_dDtIni    = loc_oPagina.txt_4c_Dtini.Value
        loc_oBO.this_dDtFin    = loc_oPagina.txt_4c_Dtfin.Value
        loc_oBO.this_cSituas   = ALLTRIM(loc_oPagina.cbo_4c_CmbSituas.Value)
        loc_oBO.this_cCargo    = ALLTRIM(loc_oPagina.cbo_4c_CmbCargo.Value)
        loc_oBO.this_nComis    = loc_oPagina.txt_4c_Comis.Value
        loc_oBO.this_nSubsidio = loc_oPagina.txt_4c_Subsidio.Value
        loc_oBO.this_nPmeta    = loc_oPagina.txt_4c_Pmeta.Value
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BusinessObject para os campos da Page2
    * Reconstroi a descricao do vendedor (SigCdCli.Rclis) e a empresa de
    * registro (THIS.PegaEmpReg), equivalentes ao CrTmpCli/pegaempreg do legado
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_oBO
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oBO     = THIS.this_oBusinessObject

        loc_oPagina.txt_4c_Codigo.Value    = loc_oBO.this_cCodigo
        loc_oPagina.txt_4c_Emps.Value      = loc_oBO.this_cEmps
        loc_oPagina.txt_4c_Ufs.Value       = loc_oBO.this_cUfs
        loc_oPagina.txt_4c_Grupo.Value     = loc_oBO.this_cGrupo
        loc_oPagina.txt_4c_Vens.Value      = loc_oBO.this_cCodVens
        loc_oPagina.txt_4c_Dtini.Value     = loc_oBO.this_dDtIni
        loc_oPagina.txt_4c_Dtfin.Value     = loc_oBO.this_dDtFin
        loc_oPagina.cbo_4c_CmbSituas.Value = loc_oBO.this_cSituas
        loc_oPagina.cbo_4c_CmbCargo.Value  = loc_oBO.this_cCargo
        loc_oPagina.txt_4c_Comis.Value     = loc_oBO.this_nComis
        loc_oPagina.txt_4c_Subsidio.Value  = loc_oBO.this_nSubsidio
        loc_oPagina.txt_4c_Pmeta.Value     = loc_oBO.this_nPmeta

        THIS.this_cUltimoEmpsValidado     = ALLTRIM(loc_oBO.this_cEmps)
        THIS.this_cUltimoVensValidado     = ALLTRIM(loc_oBO.this_cCodVens)
        THIS.this_cUltimaSituacaoValidada = ALLTRIM(loc_oBO.this_cSituas)

        *-- Descricao do vendedor (CrTmpCli.Rclis no legado: Grupo_op.Click)
        loc_oPagina.txt_4c_DVens.Value = ""
        IF !EMPTY(ALLTRIM(loc_oBO.this_cCodVens))
            IF USED("cursor_4c_DescVen")
                USE IN cursor_4c_DescVen
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_oBO.this_cCodVens) + ;
                    " AND Grupos = " + EscaparSQL(loc_oBO.this_cGrupo), "cursor_4c_DescVen") >= 1
                IF RECCOUNT("cursor_4c_DescVen") > 0
                    loc_oPagina.txt_4c_DVens.Value = TratarNulo(cursor_4c_DescVen.Rclis, "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_DescVen")
                USE IN cursor_4c_DescVen
            ENDIF
        ENDIF
        THIS.this_cUltimoDVensValidado = ALLTRIM(loc_oPagina.txt_4c_DVens.Value)

        THIS.PegaEmpReg()
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa campos da Page2 para novo registro (modo INCLUIR)
    * Preenche txt_4c_Grupo com o grupo padrao (SigCdPam.GrPadVens), igual ao
    * legado (Init/Grupo_op.Click: thisform.pagina.dados.getGrupo.value = crSigCdPam.GrPadVens)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = ""
        loc_oPagina.txt_4c_Emps.Value      = ""
        loc_oPagina.txt_4c_EmpReg.Value    = ""
        loc_oPagina.txt_4c_Ufs.Value       = ""
        loc_oPagina.txt_4c_Grupo.Value     = ""
        loc_oPagina.txt_4c_Vens.Value      = ""
        loc_oPagina.txt_4c_DVens.Value     = ""
        loc_oPagina.txt_4c_Dtini.Value     = {}
        loc_oPagina.txt_4c_Dtfin.Value     = {}
        loc_oPagina.cbo_4c_CmbSituas.Value = ""
        loc_oPagina.cbo_4c_CmbCargo.Value  = ""
        loc_oPagina.txt_4c_Comis.Value     = 0
        loc_oPagina.txt_4c_Subsidio.Value  = 0
        loc_oPagina.txt_4c_Pmeta.Value     = 0

        THIS.this_cUltimoEmpsValidado     = ""
        THIS.this_cUltimoVensValidado     = ""
        THIS.this_cUltimoDVensValidado    = ""
        THIS.this_cUltimaSituacaoValidada = ""

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            IF USED("cursor_4c_ParamGrupo")
                USE IN cursor_4c_ParamGrupo
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT GrPadVens FROM SigCdPam", "cursor_4c_ParamGrupo") >= 1
                IF RECCOUNT("cursor_4c_ParamGrupo") > 0
                    loc_oPagina.txt_4c_Grupo.Value = TratarNulo(cursor_4c_ParamGrupo.GrPadVens, "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_ParamGrupo")
                USE IN cursor_4c_ParamGrupo
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * PegaEmpReg - Apresenta a empresa de registro do vendedor (SigCdCli)
    * Transcrito de PROCEDURE pegaempreg do legado
    *===========================================================================
    PROTECTED PROCEDURE PegaEmpReg()
        LOCAL loc_oPagina, loc_cGrupo, loc_cVens
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
        loc_cVens   = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)

        IF EMPTY(loc_cGrupo) OR EMPTY(loc_cVens)
            loc_oPagina.txt_4c_EmpReg.Value = ""
        ELSE
            IF USED("cursor_4c_AuxCli")
                USE IN cursor_4c_AuxCli
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT emps FROM SigCdCli WHERE grupos = " + EscaparSQL(loc_cGrupo) + ;
                    " AND iclis = " + EscaparSQL(loc_cVens), "cursor_4c_AuxCli") >= 1
                IF RECCOUNT("cursor_4c_AuxCli") > 0
                    loc_oPagina.txt_4c_EmpReg.Value = TratarNulo(cursor_4c_AuxCli.emps, "")
                ELSE
                    loc_oPagina.txt_4c_EmpReg.Value = ""
                ENDIF
            ENDIF
            IF USED("cursor_4c_AuxCli")
                USE IN cursor_4c_AuxCli
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarEmpsDados - LostFocus de txt_4c_Emps (Page2)
    * Legado: LostFocus busca UF em SigcdEmp; Valid chama fAcessoEmpresa
    * (nao portada - regra #27 - substituida por VerificarAcessoEmpresa, que
    * so faz o CHECK de acesso, sem popular textbox)
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE ValidarEmpsDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cEmp
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cEmp    = ALLTRIM(loc_oPagina.txt_4c_Emps.Value)

        IF loc_cEmp == THIS.this_cUltimoEmpsValidado
            RETURN
        ENDIF
        THIS.this_cUltimoEmpsValidado = loc_cEmp

        IF EMPTY(loc_cEmp)
            loc_oPagina.txt_4c_Ufs.Value = ""
            RETURN
        ENDIF

        IF USED("cursor_4c_LocalEmp")
            USE IN cursor_4c_LocalEmp
        ENDIF
        IF SQLEXEC(gnConnHandle, "SELECT * FROM SigcdEmp WHERE cemps = " + EscaparSQL(loc_cEmp), "cursor_4c_LocalEmp") < 1
            MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados.", "Erro")
        ELSE
            IF RECCOUNT("cursor_4c_LocalEmp") > 0
                loc_oPagina.txt_4c_Ufs.Value = TratarNulo(cursor_4c_LocalEmp.estas, "")
            ELSE
                loc_oPagina.txt_4c_Ufs.Value = ""
            ENDIF
        ENDIF
        IF USED("cursor_4c_LocalEmp")
            USE IN cursor_4c_LocalEmp
        ENDIF

        IF !VerificarAcessoEmpresa(gc_4c_UsuarioLogado, loc_cEmp)
            MsgErro("Empresa Inv" + CHR(225) + "lida !!", "Erro")
            loc_oPagina.txt_4c_Emps.Value = ""
            loc_oPagina.txt_4c_Ufs.Value  = ""
            THIS.this_cUltimoEmpsValidado = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarVensDados - LostFocus de txt_4c_Vens (Page2)
    * Legado: Valid chama fAcessoContas(Usuar,Grupo,'C',Value,This,getDVENS) e,
    * se autorizado, thisform.pegaempreg() (portado em utils\functions.prg)
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE ValidarVensDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cVens, loc_cGrupo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cVens   = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)

        IF loc_cVens == THIS.this_cUltimoVensValidado
            RETURN
        ENDIF
        THIS.this_cUltimoVensValidado = loc_cVens

        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        IF EMPTY(loc_cVens)
            loc_oPagina.txt_4c_DVens.Value = ""
            THIS.this_cUltimoDVensValidado = ""
        ELSE
            IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cVens, loc_oPagina.txt_4c_Vens, loc_oPagina.txt_4c_DVens)
                MsgErro("Acesso Negado !!", "Erro")
                loc_oPagina.txt_4c_Vens.Value  = ""
                loc_oPagina.txt_4c_DVens.Value = ""
                THIS.this_cUltimoVensValidado  = ""
                THIS.this_cUltimoDVensValidado = ""
            ELSE
                THIS.this_cUltimoDVensValidado = ALLTRIM(loc_oPagina.txt_4c_DVens.Value)
                THIS.PegaEmpReg()
            ENDIF
        ENDIF

        loc_oPagina.txt_4c_DVens.Enabled = loc_oPagina.txt_4c_Vens.Enabled AND EMPTY(ALLTRIM(loc_oPagina.txt_4c_Vens.Value))
    ENDPROC

    *===========================================================================
    * ValidarDVensDados - LostFocus de txt_4c_DVens (Page2)
    * Legado: Valid chama fAcessoContas(Usuar,Grupo,'D',Value,getVens,This)
    * (busca por descricao, portado em utils\functions.prg)
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE ValidarDVensDados(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cDVens, loc_cGrupo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cDVens  = ALLTRIM(loc_oPagina.txt_4c_DVens.Value)

        IF loc_cDVens == THIS.this_cUltimoDVensValidado
            RETURN
        ENDIF
        THIS.this_cUltimoDVensValidado = loc_cDVens

        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

        IF EMPTY(loc_cDVens)
            loc_oPagina.txt_4c_Vens.Value = ""
            THIS.this_cUltimoVensValidado = ""
        ELSE
            IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_cDVens, loc_oPagina.txt_4c_Vens, loc_oPagina.txt_4c_DVens)
                MsgErro("Acesso Negado !!", "Erro")
                loc_oPagina.txt_4c_Vens.Value  = ""
                loc_oPagina.txt_4c_DVens.Value = ""
                THIS.this_cUltimoVensValidado  = ""
                THIS.this_cUltimoDVensValidado = ""
            ELSE
                THIS.this_cUltimoVensValidado = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
                THIS.PegaEmpReg()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarSituacao - LostFocus de cbo_4c_CmbSituas (Page2)
    * Legado: so permite gravar situacao FOLGA quem tem acesso (fChecaAcesso)
    * ou se usuario logado eh da mesma empresa do vendedor (SigCdCli)
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE ValidarSituacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cSituacao, loc_cCodVens, loc_cSQL
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_cSituacao = ALLTRIM(loc_oPagina.cbo_4c_CmbSituas.Value)

        IF loc_cSituacao == THIS.this_cUltimaSituacaoValidada
            RETURN
        ENDIF
        THIS.this_cUltimaSituacaoValidada = loc_cSituacao

        IF loc_cSituacao != "FOLGA"
            RETURN
        ENDIF

        IF fChecaAcesso("SIGCDVEN", "FOLGA")
            RETURN
        ENDIF

        loc_cCodVens = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
        loc_cSQL = "SELECT emps FROM SigCdCli WHERE iclis = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
            " AND emps IN (SELECT emps FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCodVens) + ")"

        IF USED("cursor_4c_ChecaFolga")
            USE IN cursor_4c_ChecaFolga
        ENDIF

        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChecaFolga") < 1 OR RECCOUNT("cursor_4c_ChecaFolga") = 0
            MsgErro("Acesso Negado para definir situa" + CHR(231) + CHR(227) + "o FOLGA!", "Erro")
            loc_oPagina.cbo_4c_CmbSituas.Value = ""
            THIS.this_cUltimaSituacaoValidada  = ""
        ENDIF

        IF USED("cursor_4c_ChecaFolga")
            USE IN cursor_4c_ChecaFolga
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e grava o registro (Confirmar)
    * Validacoes e verificacao de sobreposicao de periodo transcritas
    * LITERALMENTE do legado (Pagina.Dados.Grupo_Salva.Salva.Click) - regra #17
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cCheCod, loc_cDatI, loc_cDatF, loc_cQuery
        LOCAL loc_cCodVens, loc_cSituas, loc_dDtIni, loc_dDtFin, loc_cEmps
        LOCAL loc_cAnoMes, loc_cCodigoGerado, loc_lProsseguir
        loc_oPagina     = THIS.pgf_4c_Paginas.Page2
        loc_lProsseguir = .T.

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_cEmps    = ALLTRIM(loc_oPagina.txt_4c_Emps.Value)
            loc_cCodVens = ALLTRIM(loc_oPagina.txt_4c_Vens.Value)
            loc_dDtIni   = loc_oPagina.txt_4c_Dtini.Value
            loc_dDtFin   = loc_oPagina.txt_4c_Dtfin.Value
            loc_cSituas  = ALLTRIM(loc_oPagina.cbo_4c_CmbSituas.Value)

            IF EMPTY(loc_cEmps)
                MsgErro("Empresa n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
                loc_oPagina.txt_4c_Emps.SetFocus
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(loc_cCodVens)
                MsgErro("Vendedor n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
                loc_oPagina.txt_4c_Emps.SetFocus
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(loc_dDtIni)
                MsgErro("Data Inicial n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
                loc_oPagina.txt_4c_Dtini.SetFocus
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND loc_cSituas != "ATIVO" AND EMPTY(loc_dDtFin)
                MsgErro("Data final n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
                loc_oPagina.txt_4c_Dtfin.SetFocus
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(loc_cSituas)
                MsgErro("Situa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!", "Confirmar")
                loc_oPagina.cbo_4c_CmbSituas.SetFocus
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !EMPTY(loc_dDtFin) AND loc_dDtIni > loc_dDtFin
                MsgErro("As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!", "Confirmar")
                loc_oPagina.txt_4c_Dtini.SetFocus
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                *-- Verifica sobreposicao de periodo para o mesmo vendedor (transcrito do legado)
                loc_cCheCod = ""
                IF THIS.this_cModoAtual = "ALTERAR"
                    loc_cCheCod = " AND codigo <> " + EscaparSQL(THIS.this_oBusinessObject.this_cCodigo)
                ENDIF

                loc_cDatI = SUBSTR(DTOS(loc_dDtIni), 1, 4) + "-" + SUBSTR(DTOS(loc_dDtIni), 5, 2) + "-" + SUBSTR(DTOS(loc_dDtIni), 7, 2)
                IF !EMPTY(loc_dDtFin)
                    loc_cDatF = SUBSTR(DTOS(loc_dDtFin), 1, 4) + "-" + SUBSTR(DTOS(loc_dDtFin), 5, 2) + "-" + SUBSTR(DTOS(loc_dDtFin), 7, 2)
                ELSE
                    loc_cDatF = loc_cDatI
                ENDIF

                IF loc_cSituas != "ATIVO"
                    loc_cQuery = "SELECT * FROM SigCdVen WHERE codvens = " + EscaparSQL(loc_cCodVens) + ;
                        " AND situas <> 'ATIVO'" + ;
                        " AND (" + EscaparSQL(loc_cDatI) + " BETWEEN LEFT(CONVERT(VARCHAR, dtini, 120), 10) AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                        " OR " + EscaparSQL(loc_cDatF) + " BETWEEN LEFT(CONVERT(VARCHAR, dtini, 120), 10) AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                        " OR LEFT(CONVERT(VARCHAR, dtini, 120), 10) BETWEEN " + EscaparSQL(loc_cDatI) + " AND " + EscaparSQL(loc_cDatF) + ;
                        " OR LEFT(CONVERT(VARCHAR, dtfin, 120), 10) BETWEEN " + EscaparSQL(loc_cDatI) + " AND " + EscaparSQL(loc_cDatF) + ")" + ;
                        loc_cCheCod
                ELSE
                    loc_cQuery = "SELECT * FROM SigCdVen WHERE codvens = " + EscaparSQL(loc_cCodVens) + ;
                        " AND situas = 'ATIVO'" + ;
                        " AND (" + EscaparSQL(loc_cDatI) + " BETWEEN LEFT(CONVERT(VARCHAR, dtini, 120), 10) AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                        " OR " + EscaparSQL(loc_cDatF) + " BETWEEN LEFT(CONVERT(VARCHAR, dtini, 120), 10) AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                        " OR LEFT(CONVERT(VARCHAR, dtini, 120), 10) BETWEEN " + EscaparSQL(loc_cDatI) + " AND " + EscaparSQL(loc_cDatF) + ;
                        " OR LEFT(CONVERT(VARCHAR, dtfin, 120), 10) BETWEEN " + EscaparSQL(loc_cDatI) + " AND " + EscaparSQL(loc_cDatF) + ;
                        " OR dtfin IS NULL)" + ;
                        loc_cCheCod
                ENDIF

                IF USED("cursor_4c_CheckPeriodo")
                    USE IN cursor_4c_CheckPeriodo
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_CheckPeriodo") < 1
                    MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados.", "Erro")
                    loc_lProsseguir = .F.
                ELSE
                    IF RECCOUNT("cursor_4c_CheckPeriodo") > 0
                        MsgErro("Esse intervalo j" + CHR(225) + " est" + CHR(225) + " cadastrado para esse vendedor!", "Confirmar")
                        loc_oPagina.txt_4c_Dtini.SetFocus
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_CheckPeriodo")
                    USE IN cursor_4c_CheckPeriodo
                ENDIF
            ENDIF
        ENDIF

        IF loc_lProsseguir
            THIS.FormParaBO()

            IF THIS.this_cModoAtual = "INCLUIR"
                loc_cAnoMes = SUBSTR(ALLTRIM(STR(YEAR(DATE()))), 3) + PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")
                loc_cCodigoGerado = ALLTRIM(THIS.this_oBusinessObject.this_cCodVens) + loc_cAnoMes + ;
                    PADL(ALLTRIM(STR(fGerUniqueKey(ALLTRIM(THIS.this_oBusinessObject.this_cCodVens) + loc_cAnoMes))), 5, "0")
                THIS.this_oBusinessObject.this_cCodigo = loc_cCodigoGerado
            ENDIF

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Confirmar")
                THIS.AlternarPagina(1)
            ELSE
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para a lista (Cancelar)
    * PUBLIC: BINDEVENT requer metodo publico (regra #3)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
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

        DODEFAULT()
    ENDPROC

ENDDEFINE
