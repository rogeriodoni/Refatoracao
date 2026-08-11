*====================================================================
* FormENR.prg - Cadastro de Endere??os (SIGCDENR)
*
* Tabela: SigCdEnr (pkchaves PK)
* Tipo: CRUD (frmcadastro)
* BO: ENRBO
*====================================================================

DEFINE CLASS FormENR AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *====================================================================
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init()
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.Caption = "Endere" + CHR(231) + CHR(111) + "s"

            THIS.this_oBusinessObject = CREATEOBJECT("ENRBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar ENRBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2
        loc_oPgf.Top       = -29
        loc_oPgf.Left      = 0
        loc_oPgf.Width     = THIS.Width
        loc_oPgf.Height    = THIS.Height + 29
        loc_oPgf.Tabs      = .F.
        loc_oPgf.Visible   = .T.

        WITH loc_oPgf
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *====================================================================
    * ConfigurarPaginaLista - Page1: cabecalho + botoes CRUD + grid
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho cinza (Top = 2 + 29 = 31)
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
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
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
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
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (canonico: Top=29, Left=542, Width=390)
        loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
        loc_oBotoes = loc_oPg1.cnt_4c_Botoes
        WITH loc_oBotoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
        loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Incluir
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
        loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Visualizar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Alterar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Excluir
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305)
        loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oBotoes.cmd_4c_Buscar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (canonico: Top=29, Left=917, Width=90)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (Top = 88+29 = 117, Width nao alcanca cnt_4c_Saida)
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPg1.grd_4c_Lista

        *-- RecordSource e ColumnCount FORA de WITH (problema #36)
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 3

        WITH loc_oGrid
            .Top               = 117
            .Left              = 26
            .Width             = 880
            .Height            = 455
            .FontName          = "Verdana"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .GridLineColor     = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle    = 2
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .GridLines         = 3
            .Visible           = .T.

            .Column1.Width           = 100
            .Column1.FontName        = "Verdana"
            .Column1.FontSize        = 8

            .Column2.Width           = 450
            .Column2.FontName        = "Verdana"
            .Column2.FontSize        = 8

            .Column3.Width           = 300
            .Column3.FontName        = "Verdana"
            .Column3.FontSize        = 8
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *====================================================================
    * ConfigurarPaginaDados - Page2: labels + campos + botoes Salvar/Cancelar
    * Campos txt_4c_CEP, txt_4c_Endereco, txt_4c_Bairro adicionados na Fase 5
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oSalva

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container botoes Salvar/Cancelar (canonico: Top=33, Left=842, Width=160)
        loc_oPg2.AddObject("cnt_4c_Salva", "Container")
        loc_oSalva = loc_oPg2.cnt_4c_Salva
        WITH loc_oSalva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Confirmar
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oSalva.cmd_4c_Cancelar
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label CEP (Say6: top=196+29=225, left=196)
        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .Caption   = "CEP :"
            .Top       = 225
            .Left      = 196
            .Width     = 30
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox CEP (GetCEP: top=193+29=222, left=226, width=80)
        loc_oPg2.AddObject("txt_4c_CEP", "TextBox")
        WITH loc_oPg2.txt_4c_CEP
            .Value       = ""
            .Top         = 222
            .Left        = 226
            .Width       = 80
            .Height      = 23
            .MaxLength   = 9
            .InputMask   = "99999-999"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .F.
        ENDWITH
        BINDEVENT(loc_oPg2.txt_4c_CEP, "LostFocus", THIS, "LostFocusCEP")

        *-- Label Endere?o (Say4: top=219+29=248, left=170)
        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .Caption   = "Endere" + CHR(231) + "o :"
            .Top       = 248
            .Left      = 170
            .Width     = 56
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Endere?o (GetEndere?o: top=216+29=245, left=226, width=403)
        loc_oPg2.AddObject("txt_4c_Endereco", "TextBox")
        WITH loc_oPg2.txt_4c_Endereco
            .Value       = ""
            .Top         = 245
            .Left        = 226
            .Width       = 403
            .Height      = 23
            .MaxLength   = 60
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .F.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_Endereco, "LostFocus", THIS, "LostFocusEndereco")

        *-- Label Bairro (Say5: top=242+29=271, left=187)
        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .Caption   = "Bairro :"
            .Top       = 271
            .Left      = 187
            .Width     = 40
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Bairro (GetBairro: top=239+29=268, left=226, width=272, Format="K!" = uppercase)
        loc_oPg2.AddObject("txt_4c_Bairro", "TextBox")
        WITH loc_oPg2.txt_4c_Bairro
            .Value       = ""
            .Top         = 268
            .Left        = 226
            .Width       = 272
            .Height      = 23
            .MaxLength   = 60
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *====================================================================
    * CarregarLista - Consulta BO e vincula grid ao cursor crSigCdEnr
    *====================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_nDS
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_nDS = SET("DATASESSION")
                SET DATASESSION TO 1
                IF USED("cursor_4c_Lista")
                    USE IN cursor_4c_Lista
                ENDIF
                CREATE CURSOR cursor_4c_Lista (pkchaves C(20), ceps C(9), endes C(60), bairs C(40))
                SET DATASESSION TO (loc_nDS)
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- Desanexar grid antes de recarregar para evitar "Unknown member"
                loc_oGrid.RecordSource = ""

                IF THIS.this_oBusinessObject.Buscar("")
                    *-- Vincular grid ao cursor recriado pelo BO
                    loc_oGrid.RecordSource          = "crSigCdEnr"
                    loc_oGrid.Column1.ControlSource = "crSigCdEnr.ceps"
                    loc_oGrid.Column2.ControlSource = "crSigCdEnr.endes"
                    loc_oGrid.Column3.ControlSource = "crSigCdEnr.bairs"

                    *-- Reconfigura??o de headers apos RecordSource (obrigatorio - problema #32)
                    loc_oGrid.Column1.Header1.Caption = "CEP"
                    loc_oGrid.Column2.Header1.Caption = "Endere" + CHR(231) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Bairro"

                    *-- Larguras das colunas
                    loc_oGrid.Column1.Width = 100
                    loc_oGrid.Column2.Width = 450
                    loc_oGrid.Column3.Width = 300

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * FormatarGridLista - Aplica formatacao visual ao grid da lista
    *====================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *====================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *====================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * FormParaBO - Transfere valores do form para o BO
    *====================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
            THIS.this_oBusinessObject.this_cCep = ALLTRIM(loc_oPg2.txt_4c_CEP.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
            THIS.this_oBusinessObject.this_cEndereco = ALLTRIM(loc_oPg2.txt_4c_Endereco.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
            THIS.this_oBusinessObject.this_cBairro = ALLTRIM(loc_oPg2.txt_4c_Bairro.Value)
        ENDIF
    ENDPROC

    *====================================================================
    * BOParaForm - Transfere valores do BO para o form
    *====================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
            loc_oPg2.txt_4c_CEP.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCep)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
            loc_oPg2.txt_4c_Endereco.Value = ALLTRIM(THIS.this_oBusinessObject.this_cEndereco)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
            loc_oPg2.txt_4c_Bairro.Value = ALLTRIM(THIS.this_oBusinessObject.this_cBairro)
        ENDIF
    ENDPROC

    *====================================================================
    * LimparCampos - Limpa valores dos campos da Page2
    *====================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
            loc_oPg2.txt_4c_CEP.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
            loc_oPg2.txt_4c_Endereco.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
            loc_oPg2.txt_4c_Bairro.Value = ""
        ENDIF
    ENDPROC

    *====================================================================
    * HabilitarCampos - Habilita ou desabilita campos da Page2
    *====================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_oSalva
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_oSalva = loc_oPg2.cnt_4c_Salva

        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
            loc_oPg2.txt_4c_CEP.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
            loc_oPg2.txt_4c_Endereco.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
            loc_oPg2.txt_4c_Bairro.Enabled   = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oSalva, "cmd_4c_Confirmar", 5)
            loc_oSalva.cmd_4c_Confirmar.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oSalva, "cmd_4c_Cancelar", 5)
            loc_oSalva.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

    *====================================================================
    * AjustarBotoesPorModo - Configura botoes conforme o modo atual
    *====================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lPodeEditar, loc_oSalva
        loc_lPodeEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        loc_oSalva = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva

        IF PEMSTATUS(loc_oSalva, "cmd_4c_Confirmar", 5)
            loc_oSalva.cmd_4c_Confirmar.Enabled = loc_lPodeEditar
        ENDIF
        IF PEMSTATUS(loc_oSalva, "cmd_4c_Cancelar", 5)
            loc_oSalva.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

    *====================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *====================================================================
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

    *====================================================================
    * BtnIncluirClick - Prepara form para inclusao de novo registro
    *====================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *====================================================================
    * BtnVisualizarClick - Abre registro selecionado em modo leitura
    *====================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cPk, loc_lCarregou
        loc_lCarregou = .F.

        IF !USED("crSigCdEnr") OR EOF("crSigCdEnr")
            MsgAviso("Nenhum registro selecionado para visualizar.")
            RETURN
        ENDIF

        TRY
            SELECT crSigCdEnr
            loc_cPk = ALLTRIM(crSigCdEnr.pkchaves)
            loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPk)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.BtnVisualizarClick")
        ENDTRY

        IF loc_lCarregou
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *====================================================================
    * BtnAlterarClick - Abre registro selecionado em modo edicao
    *====================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cPk, loc_lCarregou
        loc_lCarregou = .F.

        IF !USED("crSigCdEnr") OR EOF("crSigCdEnr")
            MsgAviso("Nenhum registro selecionado para alterar.")
            RETURN
        ENDIF

        TRY
            SELECT crSigCdEnr
            loc_cPk = ALLTRIM(crSigCdEnr.pkchaves)
            loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPk)
            IF loc_lCarregou
                THIS.this_oBusinessObject.EditarRegistro()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.BtnAlterarClick")
        ENDTRY

        IF loc_lCarregou
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *====================================================================
    * BtnExcluirClick - Exclui o registro selecionado apos confirmacao
    *====================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cPk, loc_lCarregou
        loc_lCarregou = .F.

        IF !USED("crSigCdEnr") OR EOF("crSigCdEnr")
            MsgAviso("Nenhum registro selecionado para excluir.")
            RETURN
        ENDIF

        TRY
            SELECT crSigCdEnr
            loc_cPk = ALLTRIM(crSigCdEnr.pkchaves)
            loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPk)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.BtnExcluirClick")
        ENDTRY

        IF loc_lCarregou
            IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste endere" + CHR(231) + "o?", "Excluir")
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Endere" + CHR(231) + "o exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *====================================================================
    * BtnBuscarClick - Recarrega a lista de registros
    *====================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *====================================================================
    * BtnEncerrarClick - Fecha o formulario
    *====================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *====================================================================
    * BtnSalvarClick - Valida, transfere form->BO e salva
    *====================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPg2, loc_cCep, loc_cEndes, loc_cBairs, loc_cSQL
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Valida??o obrigatoria: CEP
        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_CEP.Value))
                MsgAviso("Obrigat" + CHR(243) + "rio informar o CEP.")
                RETURN
            ENDIF
        ENDIF

        *-- Captura valores para verifica??o de duplicidade
        loc_cCep   = ""
        loc_cEndes = ""
        loc_cBairs = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
            loc_cCep = ALLTRIM(loc_oPg2.txt_4c_CEP.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
            loc_cEndes = ALLTRIM(loc_oPg2.txt_4c_Endereco.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
            loc_cBairs = ALLTRIM(loc_oPg2.txt_4c_Bairro.Value)
        ENDIF

        *-- Verifica duplicidade apenas no modo INSERIR
        IF THIS.this_cModoAtual = "INCLUIR"
            loc_cSQL = "SELECT COUNT(*) AS total FROM SigCdEnr" + ;
                       " WHERE ceps = " + EscaparSQL(loc_cCep) + ;
                       " AND endes = " + EscaparSQL(loc_cEndes) + ;
                       " AND bairs = " + EscaparSQL(loc_cBairs)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck") > 0
                IF !EOF("cursor_4c_DupCheck") AND cursor_4c_DupCheck.total > 0
                    MsgAviso("Endere" + CHR(231) + "o j" + CHR(225) + " cadastrado.")
                    IF USED("cursor_4c_DupCheck")
                        USE IN cursor_4c_DupCheck
                    ENDIF
                    RETURN
                ENDIF
            ENDIF
            IF USED("cursor_4c_DupCheck")
                USE IN cursor_4c_DupCheck
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!")
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *====================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *====================================================================
    * LostFocusCEP - Ao sair do campo CEP, tenta preencher Endere?o e Bairro
    * Busca na propria tabela SigCdEnr se o CEP ja foi cadastrado antes
    *====================================================================
    PROCEDURE LostFocusCEP()
        LOCAL loc_lResultado, loc_cCep, loc_cSQL, loc_oPg2
        loc_lResultado = .F.
        loc_cCep = ""

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
                loc_cCep = ALLTRIM(loc_oPg2.txt_4c_CEP.Value)
            ENDIF

            IF !EMPTY(STRTRAN(loc_cCep, "-", ""))
                loc_cSQL = "SELECT TOP 1 endes, bairs FROM SigCdEnr" + ;
                           " WHERE ceps = " + EscaparSQL(loc_cCep)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCep") > 0
                    IF !EOF("cursor_4c_BuscaCep")
                        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
                            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Endereco.Value))
                                loc_oPg2.txt_4c_Endereco.Value = ALLTRIM(cursor_4c_BuscaCep.endes)
                            ENDIF
                        ENDIF
                        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
                            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Bairro.Value))
                                loc_oPg2.txt_4c_Bairro.Value = ALLTRIM(cursor_4c_BuscaCep.bairs)
                            ENDIF
                        ENDIF
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.LostFocusCEP")
        ENDTRY

        IF USED("cursor_4c_BuscaCep")
            USE IN cursor_4c_BuscaCep
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * LostFocusEndereco - Ao sair do campo Endere?o, busca CEP/Bairro na tabela
    * Original: GetEndere?o.LostFocus usa fwCep com modo NOMES para auto-completar
    * Equivalente: busca na SigCdEnr por endes LIKE valor digitado
    *====================================================================
    PROCEDURE LostFocusEndereco()
        LOCAL loc_lResultado, loc_cEndereco, loc_cSQL, loc_oPg2
        loc_lResultado = .F.
        loc_cEndereco  = ""

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
                loc_cEndereco = ALLTRIM(loc_oPg2.txt_4c_Endereco.Value)
            ENDIF

            *-- Endereco habilitado apenas quando CEP esta vazio (regra do legado:
            *-- GetEndere?o.When retorna .T. somente se Empty(getCEP))
            *-- Portanto, se o usuario digitou aqui, o CEP esta vazio -> buscar por endes
            IF !EMPTY(STRTRAN(loc_cEndereco, "-", ""))
                loc_cSQL = "SELECT TOP 1 ceps, endes, bairs FROM SigCdEnr" + ;
                           " WHERE endes LIKE " + EscaparSQL(loc_cEndereco + "%") + ;
                           " ORDER BY ceps"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEndes") > 0
                    IF !EOF("cursor_4c_BuscaEndes")
                        IF PEMSTATUS(loc_oPg2, "txt_4c_CEP", 5)
                            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_CEP.Value))
                                loc_oPg2.txt_4c_CEP.Value = ALLTRIM(cursor_4c_BuscaEndes.ceps)
                            ENDIF
                        ENDIF
                        IF PEMSTATUS(loc_oPg2, "txt_4c_Endereco", 5)
                            loc_oPg2.txt_4c_Endereco.Value = ALLTRIM(cursor_4c_BuscaEndes.endes)
                        ENDIF
                        IF PEMSTATUS(loc_oPg2, "txt_4c_Bairro", 5)
                            IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Bairro.Value))
                                loc_oPg2.txt_4c_Bairro.Value = ALLTRIM(cursor_4c_BuscaEndes.bairs)
                            ENDIF
                        ENDIF
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormENR.LostFocusEndereco")
        ENDTRY

        IF USED("cursor_4c_BuscaEndes")
            USE IN cursor_4c_BuscaEndes
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Destroy - Libera recursos
    *====================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("crSigCdEnr")
            USE IN crSigCdEnr
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
