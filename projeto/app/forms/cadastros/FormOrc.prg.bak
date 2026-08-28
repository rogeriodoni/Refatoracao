*==============================================================================
* FormOrc.prg - Formulario de Cadastro de Orcamento/Previsao
* Migrado de: SIGCDORC.SCX (frmcadastro)
* Tabela: SigCdMrp (chave composta: cEmps+cMes+cAno+cTitulo+Moeda)
*==============================================================================

DEFINE CLASS FormOrc AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Orcamento"
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

    *-- Controle de ultimo valor validado (evitar revalidacao no LostFocus)
    this_cUltimaEmpValidada   = ""
    this_cUltimoMesValidado   = ""
    this_cUltimoAnoValidado   = ""
    this_cUltimaMoedaValidada = ""

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
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
            THIS.Caption = "Or" + CHR(231) + "amento"

            THIS.this_oBusinessObject = CREATEOBJECT("OrcBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar OrcBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormOrc.InicializarForm")
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
            MostrarErro("Erro ao inicializar FormOrc:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormOrc.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1: Grid de lista + botoes CRUD
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado, Top=1+29=30)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 30
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
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
        ENDWITH

        *-- Container Botoes CRUD (Grupo_Op no legado, Top=0+29=29)
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

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        *-- Container Saida canonico (Left=917, Width=90, cmd Width=75)
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
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        *-- Botao Copiar (cmdCopiar legado: Top=78+29=107, Left=614, W=115, H=55)
        loc_oPagina.AddObject("cmd_4c_Copiar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Copiar
            .Caption         = "Copiar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 107
            .Left            = 614
            .Width           = 115
            .Height          = 55
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        *-- Grid de orcamentos (Top=117, abaixo do bloco cabecalho+botoes)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 4
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 450
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
            .ReadOnly           = .T.
            .GridLines          = 3
        ENDWITH

        WITH loc_oPagina.grd_4c_Lista
            .Column1.Header1.Caption = "Empresa"
            .Column1.Width           = 45

            .Column2.Header1.Caption = "M" + CHR(234) + "s/Ano"
            .Column2.Width           = 59

            .Column3.Header1.Caption = "Titulo"
            .Column3.Width           = 290

            .Column4.Header1.Caption = "Moeda"
            .Column4.Width           = 40
        ENDWITH

        *-- BINDEVENTs dos botoes (PUBLIC methods - sem PROTECTED)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_Copiar,                   "Click", THIS, "BtnCopiarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2: botoes + campos cabecalho
    * Fase 5: Container BotoesAcao + Labels/TextBoxes do cabecalho
    * Fase 6: Total Orcado + Grids Grupos/Contas + Total Lancado
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Confirmar/Cancelar)
        *-- Original: Grupo_Salva.Top=4. Com compensacao +29: Top=33
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
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH

        *-- Label "Emp:" (Say6 - Top=164+29=193, Left=32)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Emp:"
            .Top       = 193
            .Left      = 32
            .Width     = 30
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Empresa (Get_Emps - Top=160+29=189, Left=65, Width=31, Height=23)
        loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPagina.txt_4c_Emps
            .Value     = ""
            .Top       = 189
            .Left      = 65
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
        ENDWITH

        *-- Label "Mes:" (Say1 - Top=165+29=194, Left=104)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "M" + CHR(234) + "s:"
            .Top       = 194
            .Left      = 104
            .Width     = 26
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Mes (Get_Mes - Top=160+29=189, Left=133, Width=24, Height=23)
        loc_oPagina.AddObject("txt_4c_Mes", "TextBox")
        WITH loc_oPagina.txt_4c_Mes
            .Value     = ""
            .Top       = 189
            .Left      = 133
            .Width     = 24
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 2
        ENDWITH

        *-- Label "Ano:" (Say4 - Top=165+29=194, Left=165)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Ano:"
            .Top       = 194
            .Left      = 165
            .Width     = 26
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Ano (Get_Ano - Top=160+29=189, Left=193, Width=38, Height=23)
        loc_oPagina.AddObject("txt_4c_Ano", "TextBox")
        WITH loc_oPagina.txt_4c_Ano
            .Value     = ""
            .Top       = 189
            .Left      = 193
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 4
        ENDWITH

        *-- Label "Titulo :" (Say5 - Top=165+29=194, Left=238)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "T" + CHR(237) + "tulo :"
            .Top       = 194
            .Left      = 238
            .Width     = 38
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Titulo (Get_Titulo - Top=160+29=189, Left=278, Width=280, Height=23)
        loc_oPagina.AddObject("txt_4c_Titulo", "TextBox")
        WITH loc_oPagina.txt_4c_Titulo
            .Value     = ""
            .Top       = 189
            .Left      = 278
            .Width     = 280
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 40
        ENDWITH

        *-- Label "Moeda :" (lbl_moeda - Top=165+29=194, Left=563, Width=41)
        loc_oPagina.AddObject("lbl_4c_Lbl_moeda", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_moeda
            .Caption   = "Moeda :"
            .Top       = 194
            .Left      = 563
            .Width     = 41
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Codigo Moeda (Get_cd_Moeda - Top=160+29=189, Left=609, Width=31, Height=23)
        loc_oPagina.AddObject("txt_4c_Cd_Moeda", "TextBox")
        WITH loc_oPagina.txt_4c_Cd_Moeda
            .Value     = ""
            .Top       = 189
            .Left      = 609
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 3
        ENDWITH

        *-- TextBox Descricao Moeda (get_ds_moeda - Top=160+29=189, Left=643, Width=115, Height=23)
        loc_oPagina.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH loc_oPagina.txt_4c__ds_moeda
            .Value     = ""
            .Top       = 189
            .Left      = 643
            .Width     = 115
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 40
        ENDWITH

        *-- Label "Total Orcado :" (Say7 - Top=192+29=221, Left=50, Height=15)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Total Or" + CHR(231) + "ado :"
            .Top       = 221
            .Left      = 50
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Total Orcado (get_nVlTots - Top=187+29=216, Left=132, Width=135, H=23)
        loc_oPagina.AddObject("txt_4c__nVlTots", "TextBox")
        WITH loc_oPagina.txt_4c__nVlTots
            .Value     = 0
            .Top       = 216
            .Left      = 132
            .Width     = 135
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999,999,999.99"
        ENDWITH

        *-- Label "Grupos" (Say2 - Top=214+29=243, Left=35, Width=54, Height=18)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Grupos"
            .Top       = 243
            .Left      = 35
            .Width     = 54
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- Grid Grupos (grd_Grupos - Top=233+29=262, Left=36, Width=719, Height=116)
        loc_oPagina.AddObject("grd_4c_Grupos", "Grid")
        loc_oPagina.grd_4c_Grupos.RecordSource = ""
        loc_oPagina.grd_4c_Grupos.ColumnCount  = 4
        WITH loc_oPagina.grd_4c_Grupos
            .Top                = 262
            .Left               = 36
            .Width              = 719
            .Height             = 116
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
            .Column1.Header1.Caption = "Grupo"
            .Column1.Width           = 80
            .Column1.ReadOnly        = .T.
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width           = 300
            .Column2.ReadOnly        = .T.
            .Column3.Header1.Caption = "Valor"
            .Column3.Width           = 170
            .Column3.Alignment       = 1
            .Column4.Header1.Caption = "%"
            .Column4.Width           = 100
            .Column4.Alignment       = 1
        ENDWITH

        *-- Label "Contas" (Say3 - Top=362+29=391, Left=39, Width=54, Height=18)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Contas"
            .Top       = 391
            .Left      = 39
            .Width     = 54
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- Grid Contas (grd_Contas - Top=380+29=409, Left=36, Width=719, Height=132)
        loc_oPagina.AddObject("grd_4c_Contas", "Grid")
        loc_oPagina.grd_4c_Contas.RecordSource = ""
        loc_oPagina.grd_4c_Contas.ColumnCount  = 4
        WITH loc_oPagina.grd_4c_Contas
            .Top                = 409
            .Left               = 36
            .Width              = 719
            .Height             = 132
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
            .Column1.Header1.Caption = "Conta"
            .Column1.Width           = 80
            .Column1.ReadOnly        = .T.
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width           = 300
            .Column2.ReadOnly        = .T.
            .Column3.Header1.Caption = "Valor"
            .Column3.Width           = 170
            .Column3.Alignment       = 1
            .Column4.Header1.Caption = "%"
            .Column4.Width           = 100
            .Column4.Alignment       = 1
        ENDWITH

        *-- Label "Total Lancado :" (Say8 - Top=528+29=557, Left=399, Width=87)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Total Lan" + CHR(231) + "ado :"
            .Top       = 557
            .Left      = 399
            .Width     = 87
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox Total Lancado (getTotLancado - Top=523+29=552, Left=488, Width=125, ReadOnly)
        loc_oPagina.AddObject("txt_4c_TotLancado", "TextBox")
        WITH loc_oPagina.txt_4c_TotLancado
            .Value     = 0
            .Top       = 552
            .Left      = 488
            .Width     = 125
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .InputMask = "999,999,999.99"
        ENDWITH

        *-- BINDEVENTs de validacao dos campos do cabecalho
        BINDEVENT(loc_oPagina.txt_4c_Emps,     "KeyPress", THIS, "ValidarEmps")
        BINDEVENT(loc_oPagina.txt_4c_Mes,       "KeyPress", THIS, "ValidarMes")
        BINDEVENT(loc_oPagina.txt_4c_Ano,       "KeyPress", THIS, "ValidarAno")
        BINDEVENT(loc_oPagina.txt_4c_Cd_Moeda,  "KeyPress", THIS, "ValidarMoedaCodigo")
        BINDEVENT(loc_oPagina.txt_4c__ds_moeda, "KeyPress", THIS, "ValidarMoedaDesc")
        BINDEVENT(loc_oPagina.txt_4c__nVlTots,  "KeyPress", THIS, "VlTotsLostFocus")
        BINDEVENT(loc_oPagina.grd_4c_Grupos,    "AfterRowColChange", THIS, "GruposAfterRowColChange")
        BINDEVENT(loc_oPagina.grd_4c_Contas,    "AfterRowColChange", THIS, "ContasAfterRowColChange")

        *-- BINDEVENTs dos botoes Page2
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Busca orcamentos e vincula cursor ao grid da Page1
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (cemps C(3), cmes C(2), cano C(4), ctitulo C(40), moeda C(3), nvltots N(15,2), cidchaves C(20))
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF !THIS.this_oBusinessObject.Buscar("")
                    MsgErro("Erro ao carregar or" + CHR(231) + "amentos.", "Erro")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid.ColumnCount = 4
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cemps"
                    loc_oGrid.Column2.ControlSource = [ALLTRIM(cursor_4c_Dados.cmes) + IIF(!EMPTY(cursor_4c_Dados.cmes), "/", "") + ALLTRIM(cursor_4c_Dados.cano)]
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.ctitulo"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.moeda"

                    *-- Reconfigurar cabecalhos apos RecordSource (obrigatorio - RecordSource reseta)
                    loc_oGrid.Column1.Header1.Caption = "Empresa"
                    loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s/Ano"
                    loc_oGrid.Column3.Header1.Caption = "Titulo"
                    loc_oGrid.Column4.Header1.Caption = "Moeda"

                    loc_oGrid.Column1.Width = 45
                    loc_oGrid.Column2.Width = 59
                    loc_oGrid.Column3.Width = 290
                    loc_oGrid.Column4.Width = 40

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "FormOrc.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOrc.AlternarPagina")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara novo orcamento e vai para Page2
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_oBusinessObject.BuscarGrupos()
        THIS.this_oBusinessObject.BuscarContas()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.AjustarBotoesPorModo()
        THIS.HabilitarCampos(.T.)
        THIS.ConfigurarGridsDetalhe()
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega orcamento selecionado para visualizacao
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cIdChaves
        loc_cIdChaves = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves = ALLTRIM(cidchaves)
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um or" + CHR(231) + "amento para visualizar.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            THIS.this_oBusinessObject.BuscarGrupos()
            THIS.this_oBusinessObject.BuscarContas()
            THIS.this_oBusinessObject.CarregarDetalhe()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.AjustarBotoesPorModo()
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega orcamento selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cIdChaves
        loc_cIdChaves = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves = ALLTRIM(cidchaves)
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um or" + CHR(231) + "amento para alterar.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            THIS.this_oBusinessObject.BuscarGrupos()
            THIS.this_oBusinessObject.BuscarContas()
            THIS.this_oBusinessObject.CarregarDetalhe()
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.AjustarBotoesPorModo()
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui orcamento selecionado apos confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cIdChaves, loc_cDescricao, loc_lConfirma
        loc_cIdChaves = ""
        loc_cDescricao = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves  = ALLTRIM(cidchaves)
            loc_cDescricao = ALLTRIM(ctitulo) + " (" + ALLTRIM(cmes) + "/" + ALLTRIM(cano) + ")"
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um or" + CHR(231) + "amento para excluir.", "Aviso")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o:" + CHR(13) + ;
            loc_cDescricao, "Confirmar Exclus" + CHR(227) + "o")

        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Or" + CHR(231) + "amento exclu" + CHR(237) + "do com sucesso.", "Sucesso")
                THIS.CarregarLista()
            ELSE
                MsgErro("Erro ao excluir or" + CHR(231) + "amento.", "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Filtra lista de orcamentos por titulo
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBusca, loc_cFiltro, loc_oGrid
        loc_cBusca = INPUTBOX("T" + CHR(237) + "tulo para filtrar:", "Buscar Or" + CHR(231) + "amento", "")

        IF EMPTY(ALLTRIM(loc_cBusca))
            THIS.CarregarLista()
            RETURN
        ENDIF

        loc_cFiltro = "ctitulo LIKE " + EscaparSQL("%" + ALLTRIM(loc_cBusca) + "%")
        IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
            loc_oGrid.ColumnCount = 4
            loc_oGrid.RecordSource          = "cursor_4c_Dados"
            loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cemps"
            loc_oGrid.Column2.ControlSource = [ALLTRIM(cursor_4c_Dados.cmes) + IIF(!EMPTY(cursor_4c_Dados.cmes), "/", "") + ALLTRIM(cursor_4c_Dados.cano)]
            loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.ctitulo"
            loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.moeda"
            loc_oGrid.Column1.Header1.Caption = "Empresa"
            loc_oGrid.Column2.Header1.Caption = "M" + CHR(234) + "s/Ano"
            loc_oGrid.Column3.Header1.Caption = "Titulo"
            loc_oGrid.Column4.Header1.Caption = "Moeda"
            loc_oGrid.Refresh()
        ELSE
            MsgAviso("Nenhum or" + CHR(231) + "amento encontrado.", "Busca")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCopiarClick - Copia orcamento selecionado para novo registro
    * Carrega grupos/contas do original; usuario altera cabecalho e salva como novo
    *===========================================================================
    PROCEDURE BtnCopiarClick()
        LOCAL loc_cIdChaves
        loc_cIdChaves = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves = ALLTRIM(cidchaves)
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um or" + CHR(231) + "amento para copiar.", "Aviso")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
            IF THIS.this_oBusinessObject.BuscarGrupos() AND ;
               THIS.this_oBusinessObject.BuscarContas() AND ;
               THIS.this_oBusinessObject.CarregarDetalhe()

                THIS.this_oBusinessObject.NovoRegistro()
                THIS.this_cModoAtual = "INCLUIR"
                THIS.pgf_4c_Paginas.ActivePage = 2
            ELSE
                MsgErro("Erro ao carregar detalhe do or" + CHR(231) + "amento.", "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos do formulario
    *===========================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF
            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao destruir FormOrc:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Iterar Pages E Controls para PageFrames
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
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarGridsDetalhe - Vincula grd_4c_Grupos e grd_4c_Contas aos cursores
    * Chamado apos BuscarGrupos() e BuscarContas() estarem populados
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarGridsDetalhe()
        LOCAL loc_oPg2, loc_oGrdGrupos, loc_oGrdContas
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oGrdGrupos = loc_oPg2.grd_4c_Grupos
            IF USED("cursor_4c_Grupos")
                loc_oGrdGrupos.ColumnCount = 4
                loc_oGrdGrupos.RecordSource          = "cursor_4c_Grupos"
                loc_oGrdGrupos.Column1.ControlSource = "cursor_4c_Grupos.codigos"
                loc_oGrdGrupos.Column2.ControlSource = "cursor_4c_Grupos.descrs"
                loc_oGrdGrupos.Column3.ControlSource = "cursor_4c_Grupos.Valor"
                loc_oGrdGrupos.Column4.ControlSource = "cursor_4c_Grupos.Perc"
                loc_oGrdGrupos.Column1.Header1.Caption = "Grupo"
                loc_oGrdGrupos.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrdGrupos.Column3.Header1.Caption = "Valor"
                loc_oGrdGrupos.Column4.Header1.Caption = "%"
                loc_oGrdGrupos.Column1.Width = 80
                loc_oGrdGrupos.Column2.Width = 300
                loc_oGrdGrupos.Column3.Width = 170
                loc_oGrdGrupos.Column4.Width = 100
                GO TOP IN cursor_4c_Grupos
            ENDIF

            loc_oGrdContas = loc_oPg2.grd_4c_Contas
            IF USED("cursor_4c_Contas")
                *-- Indexar por grupos para viabilizar SET KEY TO (filtro de exibicao)
                SELECT cursor_4c_Contas
                INDEX ON ALLTRIM(grupos) TAG grupos
                loc_oGrdContas.ColumnCount = 4
                loc_oGrdContas.RecordSource          = "cursor_4c_Contas"
                loc_oGrdContas.Column1.ControlSource = "cursor_4c_Contas.iclis"
                loc_oGrdContas.Column2.ControlSource = "cursor_4c_Contas.rclis"
                loc_oGrdContas.Column3.ControlSource = "cursor_4c_Contas.Valor"
                loc_oGrdContas.Column4.ControlSource = "cursor_4c_Contas.Perc"
                loc_oGrdContas.Column1.Header1.Caption = "Conta"
                loc_oGrdContas.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrdContas.Column3.Header1.Caption = "Valor"
                loc_oGrdContas.Column4.Header1.Caption = "%"
                loc_oGrdContas.Column1.Width = 80
                loc_oGrdContas.Column2.Width = 300
                loc_oGrdContas.Column3.Width = 170
                loc_oGrdContas.Column4.Width = 100

                *-- Filtrar contas para o primeiro grupo
                IF USED("cursor_4c_Grupos") AND !EOF("cursor_4c_Grupos")
                    SELECT cursor_4c_Grupos
                    SET KEY TO ALLTRIM(codigos) IN cursor_4c_Contas
                    GO TOP IN cursor_4c_Contas
                ENDIF
            ENDIF

            THIS.RetornarTotalLancado()

        CATCH TO loException
            MostrarErro(loException, "FormOrc.ConfigurarGridsDetalhe")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do BO para os campos visuais da Page2
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Emps.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
            loc_oPg2.txt_4c_Mes.Value         = ALLTRIM(THIS.this_oBusinessObject.this_cMes)
            loc_oPg2.txt_4c_Ano.Value         = ALLTRIM(THIS.this_oBusinessObject.this_cAno)
            loc_oPg2.txt_4c_Titulo.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cTitulo)
            loc_oPg2.txt_4c_Cd_Moeda.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cMoeda)
            loc_oPg2.txt_4c__ds_moeda.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDescMoeda)
            loc_oPg2.txt_4c__nVlTots.Value    = THIS.this_oBusinessObject.this_nVlTots

            THIS.ConfigurarGridsDetalhe()
        CATCH TO loException
            MostrarErro(loException, "FormOrc.BOParaForm")
        ENDTRY
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere campos visuais da Page2 para o BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            THIS.this_oBusinessObject.this_cEmps      = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
            THIS.this_oBusinessObject.this_cMes       = ALLTRIM(loc_oPg2.txt_4c_Mes.Value)
            THIS.this_oBusinessObject.this_cAno       = ALLTRIM(loc_oPg2.txt_4c_Ano.Value)
            THIS.this_oBusinessObject.this_cTitulo    = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)
            THIS.this_oBusinessObject.this_cMoeda     = ALLTRIM(loc_oPg2.txt_4c_Cd_Moeda.Value)
            THIS.this_oBusinessObject.this_cDescMoeda = ALLTRIM(loc_oPg2.txt_4c__ds_moeda.Value)
            THIS.this_oBusinessObject.this_nVlTots    = loc_oPg2.txt_4c__nVlTots.Value
        CATCH TO loException
            MostrarErro(loException, "FormOrc.FormParaBO")
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos editaveis da Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Emps.Value      = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_oPg2.txt_4c_Mes.Value        = ""
            loc_oPg2.txt_4c_Ano.Value        = ""
            loc_oPg2.txt_4c_Titulo.Value     = ""
            loc_oPg2.txt_4c_Cd_Moeda.Value   = ""
            loc_oPg2.txt_4c__ds_moeda.Value  = ""
            loc_oPg2.txt_4c__nVlTots.Value   = 0
            loc_oPg2.txt_4c_TotLancado.Value = 0
            THIS.this_cUltimaEmpValidada   = ""
            THIS.this_cUltimoMesValidado   = ""
            THIS.this_cUltimoAnoValidado   = ""
            THIS.this_cUltimaMoedaValidada = ""
        CATCH TO loException
            MostrarErro(loException, "FormOrc.LimparCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos da Page2 conforme modo
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEdit
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lEdit = (par_lHabilitar = .T.)

        TRY
            *-- Empresa: editavel apenas no INCLUIR (chave composta nao pode mudar no ALTERAR)
            loc_oPg2.txt_4c_Emps.Enabled     = loc_lEdit AND THIS.this_cModoAtual = "INCLUIR"
            loc_oPg2.txt_4c_Mes.Enabled      = loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR")
            loc_oPg2.txt_4c_Ano.Enabled      = loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR")
            loc_oPg2.txt_4c_Titulo.Enabled   = loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR")
            loc_oPg2.txt_4c_Cd_Moeda.Enabled = loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR")
            loc_oPg2.txt_4c__ds_moeda.Enabled = loc_lEdit AND ;
                INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR") AND ;
                EMPTY(ALLTRIM(loc_oPg2.txt_4c_Cd_Moeda.Value))
            loc_oPg2.txt_4c__nVlTots.Enabled = loc_lEdit AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            *-- Grids: colunas 1 e 2 sempre ReadOnly; colunas 3 e 4 editaveis no INCLUIR/ALTERAR
            IF VARTYPE(loc_oPg2.grd_4c_Grupos) = "O"
                loc_oPg2.grd_4c_Grupos.ReadOnly        = !loc_lEdit
                loc_oPg2.grd_4c_Grupos.Column1.ReadOnly = .T.
                loc_oPg2.grd_4c_Grupos.Column2.ReadOnly = .T.
            ENDIF
            IF VARTYPE(loc_oPg2.grd_4c_Contas) = "O"
                loc_oPg2.grd_4c_Contas.ReadOnly        = !loc_lEdit
                loc_oPg2.grd_4c_Contas.Column1.ReadOnly = .T.
                loc_oPg2.grd_4c_Contas.Column2.ReadOnly = .T.
            ENDIF

            *-- Botoes
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdit
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loException
            MostrarErro(loException, "FormOrc.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e salva o orcamento (Confirmar)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cEmps, loc_cMes, loc_cAno, loc_cTitulo, loc_cMoeda
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes FORA do TRY (CLAUDE.md regra #1)
        loc_cEmps   = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
        loc_cMes    = ALLTRIM(loc_oPg2.txt_4c_Mes.Value)
        loc_cAno    = ALLTRIM(loc_oPg2.txt_4c_Ano.Value)
        loc_cTitulo = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)
        loc_cMoeda  = ALLTRIM(loc_oPg2.txt_4c_Cd_Moeda.Value)

        IF EMPTY(loc_cEmps)
            MsgAviso("Informe a empresa.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Emps.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cMes)
            MsgAviso("Informe o m" + CHR(234) + "s.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Mes.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cAno)
            MsgAviso("Informe o ano.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Ano.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cTitulo)
            MsgAviso("Informe o t" + CHR(237) + "tulo.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Titulo.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cMoeda)
            MsgAviso("Informe a moeda.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Cd_Moeda.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        *-- Verificar duplicidade apenas para INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarDuplicidade()
                MsgAviso("J" + CHR(225) + " existe or" + CHR(231) + "amento para " + ;
                    loc_cEmps + "/" + loc_cMes + "/" + loc_cAno + "/" + ;
                    loc_cTitulo + "/" + loc_cMoeda + ".", "Duplicidade")
                RETURN
            ENDIF
        ENDIF

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Or" + CHR(231) + "amento salvo com sucesso.", "Sucesso")
            THIS.AlternarPagina(1)
        ELSE
            MsgErro("Erro ao salvar or" + CHR(231) + "amento.", "Erro")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela e retorna para a lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * ValidarEmps - Valida codigo de empresa (LostFocus do txt_4c_Emps)
    * Verifica existencia em SigCdEmp; padrao para empresa logada se vazio
    *===========================================================================
    PROCEDURE ValidarEmps(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cEmps, loc_nResult, loc_cSQL
        loc_cEmps = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value)

        IF loc_cEmps == THIS.this_cUltimaEmpValidada
            RETURN
        ENDIF
        THIS.this_cUltimaEmpValidada = loc_cEmps

        IF EMPTY(loc_cEmps)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            THIS.this_cUltimaEmpValidada = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT cemps FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmps)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpChk")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EmpChk")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value = PADR(loc_cEmps, 3)
            ELSE
                MsgAviso("Empresa " + loc_cEmps + " n" + CHR(227) + "o encontrada.", "Aviso")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                THIS.this_cUltimaEmpValidada = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.SetFocus()
            ENDIF
            IF USED("cursor_4c_EmpChk")
                USE IN cursor_4c_EmpChk
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOrc.ValidarEmps")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarMes - Valida mes entre 1 e 12 (LostFocus do txt_4c_Mes)
    *===========================================================================
    PROCEDURE ValidarMes(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cMes, loc_nMes
        loc_cMes = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Mes.Value)

        IF loc_cMes == THIS.this_cUltimoMesValidado
            RETURN
        ENDIF
        THIS.this_cUltimoMesValidado = loc_cMes

        IF EMPTY(loc_cMes)
            RETURN
        ENDIF

        loc_nMes = VAL(loc_cMes)
        IF !BETWEEN(loc_nMes, 1, 12)
            MsgAviso("M" + CHR(234) + "s inv" + CHR(225) + "lido, verifique!", "Aviso")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Mes.Value = ""
            THIS.this_cUltimoMesValidado = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_Mes.SetFocus()
        ELSE
            THIS.pgf_4c_Paginas.Page2.txt_4c_Mes.Value = PADL(TRANSFORM(loc_nMes), 2, "0")
            THIS.this_cUltimoMesValidado = THIS.pgf_4c_Paginas.Page2.txt_4c_Mes.Value
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarAno - Valida ano >= 1900 (LostFocus do txt_4c_Ano)
    * Expande ano de 2 digitos para 4 digitos (ex: "26" -> "2026")
    *===========================================================================
    PROCEDURE ValidarAno(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cAno, loc_nAno
        loc_cAno = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value)

        IF loc_cAno == THIS.this_cUltimoAnoValidado
            RETURN
        ENDIF
        THIS.this_cUltimoAnoValidado = loc_cAno

        IF EMPTY(loc_cAno)
            RETURN
        ENDIF

        loc_nAno = VAL(loc_cAno)
        IF loc_nAno < 100
            loc_nAno = 2000 + loc_nAno
        ENDIF

        IF loc_nAno < 1900
            MsgAviso("Ano inv" + CHR(225) + "lido, verifique!", "Aviso")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value = ""
            THIS.this_cUltimoAnoValidado = ""
            THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.SetFocus()
        ELSE
            THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value = TRANSFORM(loc_nAno)
            THIS.this_cUltimoAnoValidado = THIS.pgf_4c_Paginas.Page2.txt_4c_Ano.Value
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarMoedaCodigo - Valida codigo de moeda em SigCdMoe (LostFocus)
    * Se nao encontrado, abre lookup de selecao
    *===========================================================================
    PROCEDURE ValidarMoedaCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCod, loc_nResult, loc_cSQL
        loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value)

        IF loc_cCod == THIS.this_cUltimaMoedaValidada
            RETURN
        ENDIF

        IF EMPTY(loc_cCod)
            THIS.pgf_4c_Paginas.Page2.txt_4c__ds_moeda.Value = ""
            THIS.this_cUltimaMoedaValidada = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                       "WHERE cmoes = " + EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeChk")

            IF loc_nResult > 0 AND !EOF("cursor_4c_MoeChk")
                SELECT cursor_4c_MoeChk
                THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value  = ALLTRIM(cmoes)
                THIS.pgf_4c_Paginas.Page2.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                THIS.this_cUltimaMoedaValidada = ALLTRIM(cmoes)
            ELSE
                THIS.AbrirLookupMoeda()
            ENDIF

            IF USED("cursor_4c_MoeChk")
                USE IN cursor_4c_MoeChk
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOrc.ValidarMoedaCodigo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarMoedaDesc - Valida descricao de moeda em SigCdMoe (LostFocus)
    * Se nao encontrado, abre lookup de selecao
    *===========================================================================
    PROCEDURE ValidarMoedaDesc(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDesc, loc_nResult, loc_cSQL
        loc_cDesc = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__ds_moeda.Value)

        IF EMPTY(loc_cDesc)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value = ""
            THIS.this_cUltimaMoedaValidada = ""
            RETURN
        ENDIF

        TRY
            THIS.AbrirLookupMoeda()
        CATCH TO loException
            MostrarErro(loException, "FormOrc.ValidarMoedaDesc")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirLookupMoeda - Abre FormBuscaAuxiliar para selecao de moeda (SigCdMoe)
    *===========================================================================
    PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
        loc_cCodigo    = ""
        loc_cDescricao = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
                ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value), ;
                "Buscar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    loc_cCodigo    = ALLTRIM(cmoes)
                    loc_cDescricao = ALLTRIM(dmoes)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Cd_Moeda.Value  = loc_cCodigo
                    THIS.pgf_4c_Paginas.Page2.txt_4c__ds_moeda.Value = loc_cDescricao
                    THIS.this_cUltimaMoedaValidada = loc_cCodigo
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOrc.AbrirLookupMoeda")
        ENDTRY
    ENDPROC

    *===========================================================================
    * VlTotsLostFocus - Disparado quando txt_4c__nVlTots perde foco
    * Se valor mudou, recalcula proporcoes de grupos e contas
    *===========================================================================
    PROCEDURE VlTotsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nVlTots, loc_nVlAnterior
        loc_nVlTots   = THIS.pgf_4c_Paginas.Page2.txt_4c__nVlTots.Value
        loc_nVlAnterior = THIS.this_oBusinessObject.this_nVlTots

        IF loc_nVlTots <> 0 AND loc_nVlTots <> loc_nVlAnterior
            THIS.this_oBusinessObject.this_nVlTots = loc_nVlTots
            THIS.RecalcularValores()
        ENDIF
    ENDPROC

    *===========================================================================
    * RecalcularValores - Recalcula Valor de grupos e contas a partir dos %
    * Replica logica do SIGCDORC.RecalculaValores no legado
    *===========================================================================
    PROTECTED PROCEDURE RecalcularValores()
        LOCAL loc_nVlTots, loc_nValor

        loc_nVlTots = THIS.this_oBusinessObject.this_nVlTots

        TRY
            IF USED("cursor_4c_Grupos")
                SELECT cursor_4c_Grupos
                SCAN
                    IF cursor_4c_Grupos.Perc <> 0
                        loc_nValor = ROUND(loc_nVlTots * (cursor_4c_Grupos.Perc / 100), 2)
                        REPLACE Valor WITH loc_nValor
                    ENDIF
                ENDSCAN
            ENDIF

            IF USED("cursor_4c_Contas")
                SELECT cursor_4c_Contas
                SCAN
                    IF cursor_4c_Contas.Perc <> 0
                        loc_nValor = ROUND(loc_nVlTots * (cursor_4c_Contas.Perc / 100), 2)
                        REPLACE Valor WITH loc_nValor
                    ENDIF
                ENDSCAN
            ENDIF

            THIS.RetornarTotalLancado()

            IF USED("cursor_4c_Grupos")
                THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
            ENDIF
            IF USED("cursor_4c_Contas")
                THIS.pgf_4c_Paginas.Page2.grd_4c_Contas.Refresh()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOrc.RecalcularValores")
        ENDTRY
    ENDPROC

    *===========================================================================
    * RetornarTotalLancado - Soma grupos + contas e exibe em txt_4c_TotLancado
    * Replica logica do SIGCDORC.RetTotLancado no legado
    * OBS: VFP SELECT SQL ignora SET KEY TO -> soma todos os registros (correto)
    *===========================================================================
    PROCEDURE RetornarTotalLancado()
        LOCAL loc_nTotGrupos, loc_nTotContas, loc_nVlLancado
        loc_nTotGrupos = 0
        loc_nTotContas = 0
        loc_nVlLancado = 0

        TRY
            IF USED("cursor_4c_Grupos")
                SELECT SUM(Valor) AS TotLancado FROM cursor_4c_Grupos ;
                    INTO CURSOR cursor_4c_TotGrp
                IF !EOF("cursor_4c_TotGrp")
                    loc_nTotGrupos = NVL(cursor_4c_TotGrp.TotLancado, 0)
                ENDIF
                IF USED("cursor_4c_TotGrp")
                    USE IN cursor_4c_TotGrp
                ENDIF
            ENDIF

            IF USED("cursor_4c_Contas")
                SELECT SUM(Valor) AS TotLancado FROM cursor_4c_Contas ;
                    INTO CURSOR cursor_4c_TotCta
                IF !EOF("cursor_4c_TotCta")
                    loc_nTotContas = NVL(cursor_4c_TotCta.TotLancado, 0)
                ENDIF
                IF USED("cursor_4c_TotCta")
                    USE IN cursor_4c_TotCta
                ENDIF
            ENDIF

            loc_nVlLancado = loc_nTotGrupos + loc_nTotContas
            THIS.pgf_4c_Paginas.Page2.txt_4c_TotLancado.Value = loc_nVlLancado
        CATCH TO loException
            MostrarErro(loException, "FormOrc.RetornarTotalLancado")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GruposAfterRowColChange - Linha/coluna do grd_4c_Grupos mudou
    * Filtra cursor_4c_Contas pelo grupo atual e recalcula total lancado
    * BINDEVENT exige declaracao de par_nColIndex
    *===========================================================================
    PROCEDURE GruposAfterRowColChange(par_nColIndex)
        TRY
            IF USED("cursor_4c_Grupos") AND USED("cursor_4c_Contas") AND ;
               !EOF("cursor_4c_Grupos")
                SELECT cursor_4c_Grupos
                SET KEY TO ALLTRIM(codigos) IN cursor_4c_Contas
                GO TOP IN cursor_4c_Contas
                THIS.RetornarTotalLancado()
                THIS.pgf_4c_Paginas.Page2.grd_4c_Contas.Refresh()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormOrc.GruposAfterRowColChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ContasAfterRowColChange - Linha/coluna do grd_4c_Contas mudou
    * Recalcula total lancado apos mudanca de valor em conta
    * BINDEVENT exige declaracao de par_nColIndex
    *===========================================================================
    PROCEDURE ContasAfterRowColChange(par_nColIndex)
        TRY
            THIS.RetornarTotalLancado()
        CATCH TO loException
            MostrarErro(loException, "FormOrc.ContasAfterRowColChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD da Page1
    * conforme modo atual: LISTA / INCLUIR / ALTERAR / VISUALIZAR
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lNaLista
        loc_oPg1    = THIS.pgf_4c_Paginas.Page1
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lNaLista = (THIS.this_cModoAtual = "LISTA")

        TRY
            *-- Botoes CRUD da Page1: habilitados apenas quando na lista
            WITH loc_oPg1.cnt_4c_Botoes
                .cmd_4c_Incluir.Enabled    = loc_lNaLista
                .cmd_4c_Visualizar.Enabled = loc_lNaLista
                .cmd_4c_Alterar.Enabled    = loc_lNaLista
                .cmd_4c_Excluir.Enabled    = loc_lNaLista
                .cmd_4c_Buscar.Enabled     = loc_lNaLista
                .Visible     = .T.
            ENDWITH
            loc_oPg1.cmd_4c_Copiar.Enabled = loc_lNaLista

            *-- Botoes da Page2: Confirmar habilitado so em INCLUIR/ALTERAR
            IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
                    INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = !loc_lNaLista
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "FormOrc.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

ENDDEFINE
