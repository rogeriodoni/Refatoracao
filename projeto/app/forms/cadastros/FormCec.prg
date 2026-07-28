*==============================================================================
* FormCec.prg - Formulario de Cadastro de Acesso a Consulta Generica
* Tabela: SigFiChc
* Migracao de: SIGCDCEC.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormCec AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Acesso a Consulta Generica de Situacao"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Estado do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormCec:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Cadastro de Acesso a Consulta Generica de Situacao"

            THIS.this_oBusinessObject = CREATEOBJECT("CecBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio CecBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

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
        CATCH TO loc_oErro
            MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .PageCount  = 2
            .Tabs       = .F.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCab, loc_oCnt, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (cntSombra no legado) - Top compensado +29 pelo PageFrame.Top=-29
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPagina.cnt_4c_Cabecalho
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

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
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

        *-- Container botoes CRUD (grupo_op canonico: Left=542, Width=390)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        loc_oCnt = loc_oPagina.cnt_4c_Botoes
        WITH loc_oCnt
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container saida - padrao canonico: Left=917, Width=90
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
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
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

        *-- Grid da lista - colunas: Emps (Emp.), Razas (Razao Social), Tipos (Rede)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top         = 117
        loc_oGrid.Left        = 12
        loc_oGrid.Width       = 890
        loc_oGrid.Height      = 450
        loc_oGrid.ColumnCount = 3
        WITH loc_oGrid
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

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes salvar/cancelar (grupo_salva no legado)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c_Salva

        loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        *-- EMPRESA (Labelocup2 + getEmpresa + getDesEmpresa)
        *-- getEmpresa.When: somente INSERIR/PROCURAR; getDesEmpresa.When: quando getEmpresa vazio
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup2", "Label")
        WITH loc_oPagina.lbl_4c_Ocup2
            .Caption   = "Empresa :"
            .Top       = 86
            .Left      = 188
            .Width     = 90
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPagina.txt_4c_Empresa
            .Value     = ""
            .Top       = 84
            .Left      = 240
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "ValidarEmpresaCec")

        loc_oPagina.AddObject("txt_4c_DesEmpresa", "TextBox")
        WITH loc_oPagina.txt_4c_DesEmpresa
            .Value     = ""
            .Top       = 84
            .Left      = 273
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- TIPO (Labelocup1 + cmbTCons)
        *-- cmbTCons.When: somente INSERIR/PROCURAR
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup1", "Label")
        WITH loc_oPagina.lbl_4c_Ocup1
            .Caption   = "Tipo :"
            .Top       = 111
            .Left      = 209
            .Width     = 50
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("cbo_4c_CmbTCons", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbTCons
            .Value         = ""
            .Top           = 108
            .Left          = 240
            .Width         = 115
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "CHEQUE PRE,SERASA,ACSP"
            .Style         = 2
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cbo_4c_CmbTCons, "InteractiveChange", THIS, "TipoConsultaChanged")

        *----------------------------------------------------------------------
        *-- CONTRATO (Labelocup3 + GetContrato)
        *-- GetContrato.When: somente quando Tipos = "CHEQUE PRE" E INSERIR/ALTERAR
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup3", "Label")
        WITH loc_oPagina.lbl_4c_Ocup3
            .Caption   = "Contrato :"
            .Top       = 135
            .Left      = 186
            .Width     = 70
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Contrato", "TextBox")
        WITH loc_oPagina.txt_4c_Contrato
            .Value     = ""
            .Top       = 133
            .Left      = 239
            .Width     = 365
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 100
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CODIGO DA REDE (Labelocup5 + GetRede)
        *-- GetRede.When: somente quando Tipos = "CHEQUE PRE" E INSERIR/ALTERAR
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup5", "Label")
        WITH loc_oPagina.lbl_4c_Ocup5
            .Caption   = "Codigo da Rede :"
            .Top       = 159
            .Left      = 153
            .Width     = 105
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Rede", "TextBox")
        WITH loc_oPagina.txt_4c_Rede
            .Value     = ""
            .Top       = 157
            .Left      = 240
            .Width     = 365
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 100
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CODIGO DA LOJA (Labelocup6 + GetLoja)
        *-- GetLoja.When: somente quando Tipos = "CHEQUE PRE" E INSERIR/ALTERAR
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup6", "Label")
        WITH loc_oPagina.lbl_4c_Ocup6
            .Caption   = "Codigo do Loja :"
            .Top       = 183
            .Left      = 158
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Loja", "TextBox")
        WITH loc_oPagina.txt_4c_Loja
            .Value     = ""
            .Top       = 181
            .Left      = 240
            .Width     = 365
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 100
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- LOGON (Labelocup4 + GetLogon)
        *-- GetLogon.When: somente quando Tipos <> "CHEQUE PRE" E INSERIR/ALTERAR
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup4", "Label")
        WITH loc_oPagina.lbl_4c_Ocup4
            .Caption   = "Logon :"
            .Top       = 207
            .Left      = 200
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Logon", "TextBox")
        WITH loc_oPagina.txt_4c_Logon
            .Value     = ""
            .Top       = 205
            .Left      = 240
            .Width     = 68
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- SENHA (Labelocup7 + GetSenha)
        *-- GetSenha.When: somente quando Tipos <> "CHEQUE PRE" E INSERIR/ALTERAR
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup7", "Label")
        WITH loc_oPagina.lbl_4c_Ocup7
            .Caption   = "Senha :"
            .Top       = 231
            .Left      = 199
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Senha", "TextBox")
        WITH loc_oPagina.txt_4c_Senha
            .Value        = ""
            .Top          = 229
            .Left         = 240
            .Width        = 68
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .MaxLength    = 8
            .PasswordChar = "*"
            .Visible      = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- CONSULTA SERASA (Labelocup12 + fwget1)
        *-- Ativo somente quando Tipos = "SERASA" E INSERIR/ALTERAR
        *-- Valid original: aceita apenas ' ', 'CP', 'CH'
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup12", "Label")
        WITH loc_oPagina.lbl_4c_Ocup12
            .Caption   = "Consulta Serasa :"
            .Top       = 256
            .Left      = 151
            .Width     = 115
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
        WITH loc_oPagina.txt_4c_Fwget1
            .Value     = ""
            .Top       = 254
            .Left      = 240
            .Width     = 24
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 2
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Fwget1, "KeyPress", THIS, "ValidarTipoSerasa")

        *----------------------------------------------------------------------
        *-- VALOR MINIMO (Labelocup9 + GetValMin)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup9", "Label")
        WITH loc_oPagina.lbl_4c_Ocup9
            .Caption   = "Valor Minimo :"
            .Top       = 281
            .Left      = 170
            .Width     = 95
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ValMin", "TextBox")
        WITH loc_oPagina.txt_4c_ValMin
            .Value     = 0
            .Top       = 279
            .Left      = 240
            .Width     = 130
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "N"
            .InputMask = "999999999.99"
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- VALOR FIXO (Labelocup10 + GetValFix)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup10", "Label")
        WITH loc_oPagina.lbl_4c_Ocup10
            .Caption   = "Valor Fixo :"
            .Top       = 305
            .Left      = 182
            .Width     = 80
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ValFix", "TextBox")
        WITH loc_oPagina.txt_4c_ValFix
            .Value     = 0
            .Top       = 303
            .Left      = 240
            .Width     = 130
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "N"
            .InputMask = "999999999.99"
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- URL / IP PROXY (Labelocup8 + GetIp)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup8", "Label")
        WITH loc_oPagina.lbl_4c_Ocup8
            .Caption   = "URL / IP - Proxi :"
            .Top       = 332
            .Left      = 156
            .Width     = 115
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ip", "TextBox")
        WITH loc_oPagina.txt_4c_Ip
            .Value     = ""
            .Top       = 328
            .Left      = 240
            .Width     = 365
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 32
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- PORTA (Labelocup11 + GetPorta)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup11", "Label")
        WITH loc_oPagina.lbl_4c_Ocup11
            .Caption   = "Porta :"
            .Top       = 355
            .Left      = 203
            .Width     = 50
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Porta", "TextBox")
        WITH loc_oPagina.txt_4c_Porta
            .Value     = 0
            .Top       = 353
            .Left      = 240
            .Width     = 43
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "N"
            .InputMask = "99999"
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- USUARIO PROXY (Labelocup13 + GetUsuProxy)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup13", "Label")
        WITH loc_oPagina.lbl_4c_Ocup13
            .Caption   = "Usuario Proxy :"
            .Top       = 380
            .Left      = 162
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_UsuProxy", "TextBox")
        WITH loc_oPagina.txt_4c_UsuProxy
            .Value     = ""
            .Top       = 378
            .Left      = 240
            .Width     = 363
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 64
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- SENHA PROXY (Labelocup14 + GetSenProxy)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Ocup14", "Label")
        WITH loc_oPagina.lbl_4c_Ocup14
            .Caption   = "Senha Proxy :"
            .Top       = 405
            .Left      = 168
            .Width     = 95
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_SenProxy", "TextBox")
        WITH loc_oPagina.txt_4c_SenProxy
            .Value        = ""
            .Top          = 403
            .Left         = 240
            .Width        = 198
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .MaxLength    = 20
            .PasswordChar = "*"
            .Visible      = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                CREATE CURSOR cursor_4c_Dados (Emps C(3), Razas C(40), Tipos C(20))
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Emps"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Razas"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Tipos"
                    loc_oGrid.Column1.Width          = 50
                    loc_oGrid.Column2.Width          = 300
                    loc_oGrid.Column3.Width          = 150
                    loc_oGrid.Column1.Header1.Caption = "Emp."
                    loc_oGrid.Column2.Header1.Caption = "Razao Social"
                    loc_oGrid.Column3.Header1.Caption = "Rede"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
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
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.Emps), ALLTRIM(cursor_4c_Dados.Tipos))
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.Emps), ALLTRIM(cursor_4c_Dados.Tipos))
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Aviso")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.Emps), ALLTRIM(cursor_4c_Dados.Tipos))
            THIS.BOParaForm()
            THIS.this_cModoAtual = "EXCLUIR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "BUSCAR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_cTipo, loc_lSucesso
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Modo EXCLUIR: confirma e exclui sem validar campos
        IF THIS.this_cModoAtual = "EXCLUIR"
            IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", "Confirmar")
                loc_lSucesso = .F.
                TRY
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                        THIS.this_cModoAtual = "LISTA"
                        THIS.AlternarPagina(1)
                        THIS.CarregarLista()
                        loc_lSucesso = .T.
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "Erro")
                ENDTRY
            ENDIF
            RETURN
        ENDIF

        *-- Modo VISUALIZAR: apenas volta para lista
        IF THIS.this_cModoAtual = "VISUALIZAR"
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        *-- Modos INCLUIR / ALTERAR / PROCURAR / BUSCAR: validar e salvar
        loc_cTipo = ALLTRIM(loc_oPagina.cbo_4c_CmbTCons.Value)

        IF EMPTY(loc_cTipo)
            MsgAviso("Tipo da Consulta " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aviso")
            loc_oPagina.cbo_4c_CmbTCons.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Empresa.Value))
            MsgAviso("Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Aviso")
            loc_oPagina.txt_4c_Empresa.SetFocus()
            RETURN
        ENDIF

        IF loc_cTipo == "CHEQUE PRE"
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Contrato.Value))
                MsgAviso("Contrato " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aviso")
                loc_oPagina.txt_4c_Contrato.SetFocus()
                RETURN
            ENDIF
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Rede.Value))
                MsgAviso("C" + CHR(243) + "digo de Rede " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aviso")
                loc_oPagina.txt_4c_Rede.SetFocus()
                RETURN
            ENDIF
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Loja.Value))
                MsgAviso("C" + CHR(243) + "digo da Loja " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aviso")
                loc_oPagina.txt_4c_Loja.SetFocus()
                RETURN
            ENDIF
        ELSE
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Logon.Value))
                MsgAviso("Logon " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aviso")
                loc_oPagina.txt_4c_Logon.SetFocus()
                RETURN
            ENDIF
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Senha.Value))
                MsgAviso("Senha " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Aviso")
                loc_oPagina.txt_4c_Senha.SetFocus()
                RETURN
            ENDIF
            IF loc_cTipo == "SERASA"
                LOCAL loc_cTpSer
                loc_cTpSer = ALLTRIM(loc_oPagina.txt_4c_Fwget1.Value)
                IF !EMPTY(loc_cTpSer) AND !INLIST(loc_cTpSer, "CP", "CH")
                    MsgAviso("Tipo de Consulta Inv" + CHR(225) + "lida, Informar CP ou CH !!!", "Aviso")
                    loc_oPagina.txt_4c_Fwget1.SetFocus()
                    RETURN
                ENDIF
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR")
            IF THIS.this_oBusinessObject.VerificarDuplicidade()
                MsgAviso("J" + CHR(225) + " existe um registro para esta Empresa e Tipo de Consulta.", "Aviso")
                RETURN
            ENDIF
        ENDIF

        loc_lSucesso = .F.
        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                THIS.CarregarLista()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresaCec(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cEmpresa, loc_cSQL, loc_nRes, loc_oBusca
        loc_oPagina  = THIS.pgf_4c_Paginas.Page2
        loc_cEmpresa = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)

        loc_oPagina.txt_4c_DesEmpresa.Value = ""

        IF EMPTY(loc_cEmpresa)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT cEmps, Razas FROM SigCdEmp WHERE cEmps = " + EscaparSQL(loc_cEmpresa)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")

            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_Emp") > 0
                SELECT cursor_4c_Emp
                loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_Emp.Razas)
            ELSE
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
                    "cursor_4c_EmpBusca", "cEmps", loc_cEmpresa, "Empresa")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("cEmps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_EmpBusca")
                        SELECT cursor_4c_EmpBusca
                        loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_EmpBusca.cEmps)
                        loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_EmpBusca.Razas)
                    ELSE
                        loc_oPagina.txt_4c_Empresa.Value = ""
                    ENDIF
                    loc_oBusca.Release()
                    IF USED("cursor_4c_EmpBusca")
                        USE IN cursor_4c_EmpBusca
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar empresa:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
            IF USED("cursor_4c_EmpBusca")
                USE IN cursor_4c_EmpBusca
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE TipoConsultaChanged()
        LOCAL loc_oPagina, loc_cTipo, loc_lChequePre
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_cTipo      = ALLTRIM(loc_oPagina.cbo_4c_CmbTCons.Value)
        loc_lChequePre = (loc_cTipo == "CHEQUE PRE")

        *-- Campos somente CHEQUE PRE
        loc_oPagina.txt_4c_Contrato.Visible = loc_lChequePre
        loc_oPagina.lbl_4c_Ocup3.Visible    = loc_lChequePre
        loc_oPagina.txt_4c_Rede.Visible     = loc_lChequePre
        loc_oPagina.lbl_4c_Ocup5.Visible    = loc_lChequePre
        loc_oPagina.txt_4c_Loja.Visible     = loc_lChequePre
        loc_oPagina.lbl_4c_Ocup6.Visible    = loc_lChequePre

        *-- Campos somente nao CHEQUE PRE
        loc_oPagina.txt_4c_Logon.Visible   = !loc_lChequePre
        loc_oPagina.lbl_4c_Ocup4.Visible   = !loc_lChequePre
        loc_oPagina.txt_4c_Senha.Visible   = !loc_lChequePre
        loc_oPagina.lbl_4c_Ocup7.Visible   = !loc_lChequePre

        *-- Campo somente SERASA
        loc_oPagina.txt_4c_Fwget1.Visible  = (loc_cTipo == "SERASA")
        loc_oPagina.lbl_4c_Ocup12.Visible  = (loc_cTipo == "SERASA")
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarVisibilidadeCampos()
        THIS.TipoConsultaChanged()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cEmps   = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
        THIS.this_oBusinessObject.this_cRazas  = ALLTRIM(loc_oPagina.txt_4c_DesEmpresa.Value)
        THIS.this_oBusinessObject.this_cTipos  = ALLTRIM(loc_oPagina.cbo_4c_CmbTCons.Value)
        THIS.this_oBusinessObject.this_cCtr       = ALLTRIM(loc_oPagina.txt_4c_Contrato.Value)
        THIS.this_oBusinessObject.this_cRde       = ALLTRIM(loc_oPagina.txt_4c_Rede.Value)
        THIS.this_oBusinessObject.this_cRdeLja    = ALLTRIM(loc_oPagina.txt_4c_Loja.Value)
        THIS.this_oBusinessObject.this_cLogon     = ALLTRIM(loc_oPagina.txt_4c_Logon.Value)
        THIS.this_oBusinessObject.this_cSenha     = ALLTRIM(loc_oPagina.txt_4c_Senha.Value)
        THIS.this_oBusinessObject.this_cCTipos    = ALLTRIM(loc_oPagina.txt_4c_Fwget1.Value)
        THIS.this_oBusinessObject.this_nVlrMin    = loc_oPagina.txt_4c_ValMin.Value
        THIS.this_oBusinessObject.this_nVlrFixo   = loc_oPagina.txt_4c_ValFix.Value
        THIS.this_oBusinessObject.this_cCipchps   = ALLTRIM(loc_oPagina.txt_4c_Ip.Value)
        THIS.this_oBusinessObject.this_nPortachps = loc_oPagina.txt_4c_Porta.Value
        THIS.this_oBusinessObject.this_cUsuProxys = ALLTRIM(loc_oPagina.txt_4c_UsuProxy.Value)
        THIS.this_oBusinessObject.this_cSenProxys = ALLTRIM(loc_oPagina.txt_4c_SenProxy.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
        loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(THIS.this_oBusinessObject.this_cRazas)
        loc_oPagina.cbo_4c_CmbTCons.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
        loc_oPagina.txt_4c_Contrato.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cCtr)
        loc_oPagina.txt_4c_Rede.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cRde)
        loc_oPagina.txt_4c_Loja.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cRdeLja)
        loc_oPagina.txt_4c_Logon.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cLogon)
        loc_oPagina.txt_4c_Senha.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cSenha)
        loc_oPagina.txt_4c_Fwget1.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cCTipos)
        loc_oPagina.txt_4c_ValMin.Value     = THIS.this_oBusinessObject.this_nVlrMin
        loc_oPagina.txt_4c_ValFix.Value     = THIS.this_oBusinessObject.this_nVlrFixo
        loc_oPagina.txt_4c_Ip.Value         = ALLTRIM(THIS.this_oBusinessObject.this_cCipchps)
        loc_oPagina.txt_4c_Porta.Value      = THIS.this_oBusinessObject.this_nPortachps
        loc_oPagina.txt_4c_UsuProxy.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cUsuProxys)
        loc_oPagina.txt_4c_SenProxy.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cSenProxys)
        THIS.AtualizarVisibilidadeCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Empresa: editavel somente em INCLUIR/PROCURAR/BUSCAR
        loc_oPagina.txt_4c_Empresa.ReadOnly    = !INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR", "BUSCAR")
        loc_oPagina.txt_4c_DesEmpresa.ReadOnly = .T.
        loc_oPagina.cbo_4c_CmbTCons.Enabled    = INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR", "BUSCAR") AND par_lHabilitar
        loc_oPagina.txt_4c_Contrato.ReadOnly   = !par_lHabilitar
        loc_oPagina.txt_4c_Rede.ReadOnly       = !par_lHabilitar
        loc_oPagina.txt_4c_Loja.ReadOnly       = !par_lHabilitar
        loc_oPagina.txt_4c_Logon.ReadOnly      = !par_lHabilitar
        loc_oPagina.txt_4c_Senha.ReadOnly      = !par_lHabilitar
        loc_oPagina.txt_4c_Fwget1.ReadOnly    = !par_lHabilitar
        loc_oPagina.txt_4c_ValMin.ReadOnly    = !par_lHabilitar
        loc_oPagina.txt_4c_ValFix.ReadOnly    = !par_lHabilitar
        loc_oPagina.txt_4c_Ip.ReadOnly        = !par_lHabilitar
        loc_oPagina.txt_4c_Porta.ReadOnly     = !par_lHabilitar
        loc_oPagina.txt_4c_UsuProxy.ReadOnly  = !par_lHabilitar
        loc_oPagina.txt_4c_SenProxy.ReadOnly  = !par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Empresa.Value    = ""
        loc_oPagina.txt_4c_DesEmpresa.Value = ""
        loc_oPagina.cbo_4c_CmbTCons.Value   = ""
        loc_oPagina.txt_4c_Contrato.Value   = ""
        loc_oPagina.txt_4c_Rede.Value       = ""
        loc_oPagina.txt_4c_Loja.Value       = ""
        loc_oPagina.txt_4c_Logon.Value      = ""
        loc_oPagina.txt_4c_Senha.Value      = ""
        loc_oPagina.txt_4c_Fwget1.Value    = ""
        loc_oPagina.txt_4c_ValMin.Value    = 0
        loc_oPagina.txt_4c_ValFix.Value    = 0
        loc_oPagina.txt_4c_Ip.Value        = ""
        loc_oPagina.txt_4c_Porta.Value     = 0
        loc_oPagina.txt_4c_UsuProxy.Value  = ""
        loc_oPagina.txt_4c_SenProxy.Value  = ""
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidarTipoSerasa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Fwget1.Value)

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        IF !INLIST(loc_cValor, "CP", "CH")
            MsgAviso("Tipo de Consulta Inv" + CHR(225) + "lida, Informar CP ou CH !!!", "Aviso")
            loc_oPagina.txt_4c_Fwget1.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_cCaption
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva

        DO CASE
        CASE THIS.this_cModoAtual = "EXCLUIR"
            loc_cCaption = "Excluir"
        CASE THIS.this_cModoAtual = "VISUALIZAR"
            loc_cCaption = "Fechar"
        OTHERWISE
            loc_cCaption = "Confirmar"
        ENDCASE

        loc_oCnt.cmd_4c_Confirmar.Caption = loc_cCaption
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
