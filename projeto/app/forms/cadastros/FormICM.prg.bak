*==============================================================================
* FormICM.prg - Formulario de Cadastro de Indices de Comissao
* Migrado de: SIGCDICM.SCX
* Tabela: SigCdCmi
* Tipo: CRUD (frmcadastro)
*==============================================================================

DEFINE CLASS FormICM AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Estado interno
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.Caption = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            *-- Criar BO
            THIS.this_oBusinessObject = CREATEOBJECT("ICMBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar ICMBO", "FormICM.InicializarForm")
            ELSE
                *-- Estrutura PageFrame + Containers
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar lista inicial (pular se validando UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "FormICM.InicializarForm")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        THIS.pgf_4c_Paginas.Top       = -29
        THIS.pgf_4c_Paginas.Left      = 0
        THIS.pgf_4c_Paginas.Width     = THIS.Width
        THIS.pgf_4c_Paginas.Height    = THIS.Height + 29
        THIS.pgf_4c_Paginas.PageCount = 2
        THIS.pgf_4c_Paginas.Tabs      = .F.
        THIS.pgf_4c_Paginas.Visible   = .T.

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(100, 100, 100)
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(100, 100, 100)
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *==========================================================================
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro com titulo (cntSombra no legado)
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
            .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
            .Top       = 15
            .Left      = 10
            .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
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
            .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
            .Top       = 18
            .Left      = 10
            .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
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
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Incluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 5
            .Width = 75
            .Height = 75
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .MousePointer = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 80
            .Width = 75
            .Height = 75
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .MousePointer = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 155
            .Width = 75
            .Height = 75
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .MousePointer = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 230
            .Width = 75
            .Height = 75
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .MousePointer = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 305
            .Width = 75
            .Height = 75
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .MousePointer = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (padrao canonico)
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
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 5
            .Width = 75
            .Height = 75
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .MousePointer = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Grade no legado): Top=88+29, Left=12, Width=940
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top              = 117
        loc_oGrid.Left             = 12
        loc_oGrid.Width            = 940
        loc_oGrid.Height           = 470
        loc_oGrid.ColumnCount      = 9
        loc_oGrid.FontName         = "Verdana"
        loc_oGrid.FontSize         = 8
        loc_oGrid.ForeColor        = RGB(90, 90, 90)
        loc_oGrid.BackColor        = RGB(255, 255, 255)
        loc_oGrid.GridLineColor    = RGB(238, 238, 238)
        loc_oGrid.GridLines        = 3
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle   = 2
        loc_oGrid.DeleteMark       = .F.
        loc_oGrid.RecordMark       = .F.
        loc_oGrid.RowHeight        = 16
        loc_oGrid.ScrollBars       = 2
        loc_oGrid.ReadOnly         = .T.
        loc_oGrid.Visible          = .T.

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro (igual Page1)
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
            .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
            .Top       = 15
            .Left      = 10
            .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
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
            .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
            .Top       = 18
            .Left      = 10
            .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33   && 4 + 29
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Confirmar (Salvar)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Cancelar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *--------------------------------------------------------------------------
        *-- CAMPOS PARTE 1: Empresa, Tabela de Desconto, Cargo
        *--------------------------------------------------------------------------

        *-- [Empresa] Label
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Empresa :"
            .Top       = 206   && 177 + 29
            .Left      = 145
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- [Empresa] Codigo (Emps)
        loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPagina.txt_4c_Empresa
            .Value       = ""
            .Top         = 203   && 174 + 29
            .Left        = 207
            .Width       = 31
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 3
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Empresa] Descricao (RazaoSocial via SigCdEmp - somente leitura)
        loc_oPagina.AddObject("txt_4c_DEmpresa", "TextBox")
        WITH loc_oPagina.txt_4c_DEmpresa
            .Value       = ""
            .Top         = 203   && 174 + 29
            .Left        = 240
            .Width       = 290
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 60
            .BackColor   = RGB(220, 220, 220)
            .ForeColor   = RGB(0, 0, 0)
            .ReadOnly    = .T.
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Tabela de Desconto] Label
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Tabela de Desconto :"
            .Top       = 231   && 202 + 29
            .Left      = 91
            .Width     = 115
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- [Tabela de Desconto] Codigo (TabDes via SigOpTdz)
        loc_oPagina.AddObject("txt_4c_TabDes", "TextBox")
        WITH loc_oPagina.txt_4c_TabDes
            .Value       = ""
            .Top         = 228   && 199 + 29
            .Left        = 207
            .Width       = 80
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 10
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Tabela de Desconto] Descricao (Descrs via SigOpTdz - somente leitura)
        loc_oPagina.AddObject("txt_4c_DTabDes", "TextBox")
        WITH loc_oPagina.txt_4c_DTabDes
            .Value       = ""
            .Top         = 228   && 199 + 29
            .Left        = 289
            .Width       = 220
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 40
            .BackColor   = RGB(220, 220, 220)
            .ForeColor   = RGB(0, 0, 0)
            .ReadOnly    = .T.
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Cargo] Label
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Cargo :"
            .Top       = 256   && 227 + 29
            .Left      = 157
            .Width     = 49
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- [Cargo] Codigo (CCargs via SigCdCrg)
        loc_oPagina.AddObject("txt_4c_Cargo", "TextBox")
        WITH loc_oPagina.txt_4c_Cargo
            .Value       = ""
            .Top         = 253   && 224 + 29
            .Left        = 207
            .Width       = 80
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 10
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Cargo] Descricao (DCargs via SigCdCrg - somente leitura)
        loc_oPagina.AddObject("txt_4c_DCargo", "TextBox")
        WITH loc_oPagina.txt_4c_DCargo
            .Value       = ""
            .Top         = 253   && 224 + 29
            .Left        = 289
            .Width       = 150
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 40
            .BackColor   = RGB(220, 220, 220)
            .ForeColor   = RGB(0, 0, 0)
            .ReadOnly    = .T.
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Condição] Label
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Condi" + CHR(231) + CHR(227) + "o :"
            .Top       = 281   && 252 + 29
            .Left      = 142
            .Width     = 64
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- [Condição] Codigo (FPags via SigOpFp)
        loc_oPagina.AddObject("txt_4c_FPags", "TextBox")
        WITH loc_oPagina.txt_4c_FPags
            .Value       = ""
            .Top         = 278   && 249 + 29
            .Left        = 207
            .Width       = 94
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 12
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Comissão] Label
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Comiss" + CHR(227) + "o :"
            .Top       = 318   && 289 + 29
            .Left      = 141
            .Width     = 65
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- [Período] Label
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 318   && 289 + 29
            .Left      = 285
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- [à] Separador periodo
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = CHR(224)
            .Top       = 318   && 289 + 29
            .Left      = 430
            .Width     = 15
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- [Comissão] Percentual (comiss, InputMask="99.99")
        loc_oPagina.AddObject("txt_4c_Comiss", "TextBox")
        WITH loc_oPagina.txt_4c_Comiss
            .Value       = 0
            .Top         = 315   && 286 + 29
            .Left        = 207
            .Width       = 45
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .InputMask   = "99.99"
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 2
            .Visible     = .T.
        ENDWITH

        *-- [Período] Data Inicial (dtinis)
        loc_oPagina.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oPagina.txt_4c_DtIni
            .Value       = {}
            .Top         = 315   && 286 + 29
            .Left        = 340
            .Width       = 80
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Período] Data Final (dtfins)
        loc_oPagina.AddObject("txt_4c_DtFin", "TextBox")
        WITH loc_oPagina.txt_4c_DtFin
            .Value       = {}
            .Top         = 315   && 286 + 29
            .Left        = 450
            .Width       = 80
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- BINDEVENTs para lookups (F4 = nKeyCode 28 em TextBox padrao)
        BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "EmpresaLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Empresa, "DblClick", THIS, "EmpresaLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_TabDes,  "KeyPress", THIS, "TabDesLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_TabDes,  "DblClick", THIS, "TabDesLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Cargo,   "KeyPress", THIS, "CargoLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Cargo,   "DblClick", THIS, "CargoLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_FPags,   "KeyPress", THIS, "FPagsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_FPags,   "DblClick", THIS, "FPagsLookupDblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista()
    *==========================================================================
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.
        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 9
                    loc_oGrid.RecordSource       = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.emps"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.razas"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tabdes"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.descrs_tabdes"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cargos"
                    loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.fpags"
                    loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.dtinis"
                    loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtfins"
                    loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.comiss"
                    loc_oGrid.Column1.Width      = 35
                    loc_oGrid.Column2.Width      = 160
                    loc_oGrid.Column3.Width      = 75
                    loc_oGrid.Column4.Width      = 140
                    loc_oGrid.Column5.Width      = 80
                    loc_oGrid.Column6.Width      = 90
                    loc_oGrid.Column7.Width      = 80
                    loc_oGrid.Column8.Width      = 80
                    loc_oGrid.Column9.Width      = 55
                    loc_oGrid.Column9.Alignment  = 2
                    loc_oGrid.Column1.Header1.Caption = "Emp"
                    loc_oGrid.Column2.Header1.Caption = "Empresa"
                    loc_oGrid.Column3.Header1.Caption = "Tb.Desconto"
                    loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Tabela"
                    loc_oGrid.Column5.Header1.Caption = "Cargo"
                    loc_oGrid.Column6.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column7.Header1.Caption = "Data Inicial"
                    loc_oGrid.Column8.Header1.Caption = "Data Final"
                    loc_oGrid.Column9.Header1.Caption = "Comiss.%"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.CarregarLista")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF
        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.AlternarPagina")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
    *==========================================================================
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *==========================================================================
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.AjustarBotoesPorModo()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *==========================================================================
        LOCAL loc_cId
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para visualizar.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cId = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.AjustarBotoesPorModo()
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *==========================================================================
        LOCAL loc_cId
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cId = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.AjustarBotoesPorModo()
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *==========================================================================
        LOCAL loc_cId
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cId = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF MsgConfirma("Deseja excluir este " + CHR(237) + "ndice de comiss" + CHR(227) + "o?", ;
                       "Confirmar Exclus" + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *==========================================================================
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
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
    PROCEDURE BtnSalvarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN loc_lResultado
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_TabDes.Value))
            MsgAviso("Tabela de Descontos Inv" + CHR(225) + "lida!!!", "")
            RETURN loc_lResultado
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Cargo.Value))
            MsgAviso("Cargo Inv" + CHR(225) + "lido!!!", "")
            RETURN loc_lResultado
        ENDIF

        IF loc_oPg2.txt_4c_Comiss.Value <= 0
            MsgAviso("Comiss" + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "")
            RETURN loc_lResultado
        ENDIF

        IF EMPTY(loc_oPg2.txt_4c_DtIni.Value)
            MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!", "")
            RETURN loc_lResultado
        ENDIF

        IF EMPTY(loc_oPg2.txt_4c_DtFin.Value)
            MsgAviso("Data Final Inv" + CHR(225) + "lida!!!", "")
            RETURN loc_lResultado
        ENDIF

        IF loc_oPg2.txt_4c_DtIni.Value > loc_oPg2.txt_4c_DtFin.Value
            MsgAviso("Data Inicial N" + CHR(227) + "o Pode Ser Maior do Que a Final!!!", "")
            RETURN loc_lResultado
        ENDIF

        TRY
            IF THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Registro salvo com sucesso!", "")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.BtnSalvarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *==========================================================================
        THIS.this_cModoAtual = "LISTA"
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
    *==========================================================================
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oPg2.txt_4c_Empresa.Value  = ""
        loc_oPg2.txt_4c_DEmpresa.Value = ""
        loc_oPg2.txt_4c_TabDes.Value   = ""
        loc_oPg2.txt_4c_DTabDes.Value  = ""
        loc_oPg2.txt_4c_Cargo.Value    = ""
        loc_oPg2.txt_4c_DCargo.Value   = ""
        loc_oPg2.txt_4c_FPags.Value    = ""
        loc_oPg2.txt_4c_Comiss.Value   = 0
        loc_oPg2.txt_4c_DtIni.Value    = {}
        loc_oPg2.txt_4c_DtFin.Value    = {}
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *==========================================================================
        LOCAL loc_oPg2, loc_nBackEd, loc_nBackRo
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_nBackEd = RGB(255, 255, 255)
        loc_nBackRo = RGB(220, 220, 220)

        loc_oPg2.txt_4c_Empresa.ReadOnly  = !par_lHabilitar
        loc_oPg2.txt_4c_TabDes.ReadOnly   = !par_lHabilitar
        loc_oPg2.txt_4c_Cargo.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_FPags.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_Comiss.ReadOnly   = !par_lHabilitar
        loc_oPg2.txt_4c_DtIni.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_DtFin.ReadOnly    = !par_lHabilitar

        loc_oPg2.txt_4c_Empresa.BackColor  = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)
        loc_oPg2.txt_4c_TabDes.BackColor   = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)
        loc_oPg2.txt_4c_Cargo.BackColor    = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)
        loc_oPg2.txt_4c_FPags.BackColor    = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)
        loc_oPg2.txt_4c_Comiss.BackColor   = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)
        loc_oPg2.txt_4c_DtIni.BackColor    = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)
        loc_oPg2.txt_4c_DtFin.BackColor    = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)

        *-- Campos de descricao: sempre somente leitura
        loc_oPg2.txt_4c_DEmpresa.ReadOnly = .T.
        loc_oPg2.txt_4c_DTabDes.ReadOnly  = .T.
        loc_oPg2.txt_4c_DCargo.ReadOnly   = .T.

        *-- Botao Confirmar: habilitado somente em INCLUIR/ALTERAR
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *==========================================================================
        LOCAL loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oPg2.txt_4c_Empresa.Value  = THIS.this_oBusinessObject.this_cEmps
            loc_oPg2.txt_4c_DEmpresa.Value = THIS.this_oBusinessObject.this_cDEmpresa
            loc_oPg2.txt_4c_TabDes.Value   = THIS.this_oBusinessObject.this_cTabDes
            loc_oPg2.txt_4c_DTabDes.Value  = THIS.this_oBusinessObject.this_cDTabDes
            loc_oPg2.txt_4c_Cargo.Value    = THIS.this_oBusinessObject.this_cCargos
            loc_oPg2.txt_4c_DCargo.Value   = THIS.this_oBusinessObject.this_cDCargo
            loc_oPg2.txt_4c_FPags.Value    = THIS.this_oBusinessObject.this_cFPags
            loc_oPg2.txt_4c_Comiss.Value   = THIS.this_oBusinessObject.this_nComiss
            loc_oPg2.txt_4c_DtIni.Value    = THIS.this_oBusinessObject.this_dDtInis
            loc_oPg2.txt_4c_DtFin.Value    = THIS.this_oBusinessObject.this_dDtFins
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
    *==========================================================================
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.this_oBusinessObject.this_cEmps    = ALLTRIM(loc_oPg2.txt_4c_Empresa.Value)
            THIS.this_oBusinessObject.this_cTabDes   = ALLTRIM(loc_oPg2.txt_4c_TabDes.Value)
            THIS.this_oBusinessObject.this_cCargos   = ALLTRIM(loc_oPg2.txt_4c_Cargo.Value)
            THIS.this_oBusinessObject.this_cFPags    = ALLTRIM(loc_oPg2.txt_4c_FPags.Value)
            THIS.this_oBusinessObject.this_nComiss   = loc_oPg2.txt_4c_Comiss.Value
            THIS.this_oBusinessObject.this_dDtInis   = loc_oPg2.txt_4c_DtIni.Value
            THIS.this_oBusinessObject.this_dDtFins   = loc_oPg2.txt_4c_DtFin.Value
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.FormParaBO")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Lookup Empresa (SigCdEmp: Cemps / Razas)
    *==========================================================================
    PROCEDURE EmpresaLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE EmpresaLookupDblClick()
        THIS.AbrirLookupEmpresa()
    ENDPROC

    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_oPg2
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_Empresa.ReadOnly
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", ;
            "cursor_4c_BuscaEmpresa", ;
            "Cemps", ;
            ALLTRIM(loc_oPg2.txt_4c_Empresa.Value), ;
            "Selecionar Empresa")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaEmpresa")
                    loc_oPg2.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
                    loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "d.")
                loc_oBusca.mAddColuna("Razas", "", "Empresa")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
                    loc_oPg2.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
                    loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaEmpresa")
                USE IN cursor_4c_BuscaEmpresa
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookup Tabela de Desconto (SigOpTdz: Codigos / Descrs)
    *==========================================================================
    PROCEDURE TabDesLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupTabDes()
        ENDIF
    ENDPROC

    PROCEDURE TabDesLookupDblClick()
        THIS.AbrirLookupTabDes()
    ENDPROC

    PROCEDURE AbrirLookupTabDes()
        LOCAL loc_oBusca, loc_oPg2
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_TabDes.ReadOnly
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpTdz", ;
            "cursor_4c_BuscaTabDes", ;
            "Codigos", ;
            ALLTRIM(loc_oPg2.txt_4c_TabDes.Value), ;
            "Selecionar Tabela de Desconto")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaTabDes")
                    loc_oPg2.txt_4c_TabDes.Value  = ALLTRIM(cursor_4c_BuscaTabDes.Codigos)
                    loc_oPg2.txt_4c_DTabDes.Value = ALLTRIM(cursor_4c_BuscaTabDes.Descrs)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabDes")
                    loc_oPg2.txt_4c_TabDes.Value  = ALLTRIM(cursor_4c_BuscaTabDes.Codigos)
                    loc_oPg2.txt_4c_DTabDes.Value = ALLTRIM(cursor_4c_BuscaTabDes.Descrs)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaTabDes")
                USE IN cursor_4c_BuscaTabDes
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookup Cargo (SigCdCrg: CCargs / DCargs)
    *==========================================================================
    PROCEDURE CargoLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupCargo()
        ENDIF
    ENDPROC

    PROCEDURE CargoLookupDblClick()
        THIS.AbrirLookupCargo()
    ENDPROC

    PROCEDURE AbrirLookupCargo()
        LOCAL loc_oBusca, loc_oPg2
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_Cargo.ReadOnly
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCrg", ;
            "cursor_4c_BuscaCargo", ;
            "CCargs", ;
            ALLTRIM(loc_oPg2.txt_4c_Cargo.Value), ;
            "Selecionar Cargo")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaCargo")
                    loc_oPg2.txt_4c_Cargo.Value  = ALLTRIM(cursor_4c_BuscaCargo.CCargs)
                    loc_oPg2.txt_4c_DCargo.Value = ALLTRIM(cursor_4c_BuscaCargo.DCargs)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("CCargs", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DCargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCargo")
                    loc_oPg2.txt_4c_Cargo.Value  = ALLTRIM(cursor_4c_BuscaCargo.CCargs)
                    loc_oPg2.txt_4c_DCargo.Value = ALLTRIM(cursor_4c_BuscaCargo.DCargs)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaCargo")
                USE IN cursor_4c_BuscaCargo
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookup Condição de Pagamento (SigOpFp: FPags)
    *==========================================================================
    PROCEDURE FPagsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupFPags()
        ENDIF
    ENDPROC

    PROCEDURE FPagsLookupDblClick()
        THIS.AbrirLookupFPags()
    ENDPROC

    PROCEDURE AbrirLookupFPags()
        LOCAL loc_oBusca, loc_oPg2
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_FPags.ReadOnly
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpFp", ;
            "cursor_4c_BuscaFPags", ;
            "FPags", ;
            ALLTRIM(loc_oPg2.txt_4c_FPags.Value), ;
            "Selecionar Condi" + CHR(231) + CHR(227) + "o de Pagamento")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaFPags")
                    loc_oPg2.txt_4c_FPags.Value = ALLTRIM(cursor_4c_BuscaFPags.FPags)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("FPags", "", "Condi" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFPags")
                    loc_oPg2.txt_4c_FPags.Value = ALLTRIM(cursor_4c_BuscaFPags.FPags)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaFPags")
                USE IN cursor_4c_BuscaFPags
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    *==========================================================================
        LOCAL loc_oPg1, loc_lEmLista
        TRY
            loc_oPg1     = THIS.pgf_4c_Paginas.Page1
            loc_lEmLista = (THIS.this_cModoAtual = "LISTA")
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEmLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEmLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEmLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEmLista
            loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lEmLista
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
