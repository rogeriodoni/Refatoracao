*==============================================================================
* Formpaf.prg - Formulario de Configuracao PAF-ECF
* Migrado de: SIGCDPAF.SCX (frmcadastro)
* PAF-ECF: Programa Aplicativo Fiscal - Emissor de Cupom Fiscal
* Apenas ALTERAR e suportado (insercao/exclusao gerenciadas automaticamente)
* Grid: DopePafEcfs (Funcao), Cx (N do caixa), TrNf (Finalizadora Nao Fiscal)
*==============================================================================

DEFINE CLASS Formpaf AS FormBase

    Height      = 600
    Width       = 1000
    Caption     = "PAF-ECF"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    * Sincroniza SigCdPaf com operacoes PAF antes de carregar lista
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Configura" + CHR(231) + CHR(227) + "o PAF-ECF"
            THIS.this_oBusinessObject = CREATEOBJECT("pafBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar pafBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formpaf.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = ;
                    "Configura" + CHR(231) + CHR(227) + "o PAF-ECF"
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
                    "Configura" + CHR(231) + CHR(227) + "o PAF-ECF"
                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    *-- Sincroniza SigCdPaf com operacoes PAF ativas (equiv. Init() legado)
                    THIS.this_oBusinessObject.SincronizarDados()
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar Formpaf:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Formpaf.InicializarForm")
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
    * ConfigurarPaginaLista - Page1 com Grid e botoes (Visualizar, Alterar, Buscar)
    * Sem Incluir/Excluir: registros PAF gerenciados automaticamente (plAcInserir=.F.)
    * Grid colunas: DopePafEcfs (Funcao), Cx (N do caixa), TrNf (Finalizadora)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho (cntSombra no legado: Top=1, com compensacao +29: Top=31)
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
            .Caption   = "Configura" + CHR(231) + CHR(227) + "o PAF-ECF"
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
            .Caption   = "Configura" + CHR(231) + CHR(227) + "o PAF-ECF"
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

        *-- Botoes CRUD (Grupo_op legado: Left=312, Top=-1; canonico com +29: Top=29)
        *-- Apenas Visualizar/Alterar/Buscar (sem Incluir/Excluir per plAcInserir=.F)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 315
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Visualizar (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left = 155
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

        *-- Botao Buscar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left = 305
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

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
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

        *-- Grid de listagem PAF-ECF
        *-- Colunas decodificadas: DopePafEcfs/Cx/TrNf (populadas por pafBO.Buscar)
        *-- ColumnCount FORA do WITH (Problema 36)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 3
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
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
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnAlterarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2 com campos PAF-ECF editaveis
    * Campos: Descricao (readonly), Inativa (checkbox), TipoDoc (optiongroup 5 opcoes)
    *         NroCaixa (txt 3 digitos), CupomNfis (txt lookup SigFiNtb)
    * Top compensation: legado Top + 29 (PageFrame.Top=-29)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Botoes de acao (Grupo_Salva legado: Left=819, Top=9; +29: Top=33)
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

        *-- Botao Confirmar (Salva no legado)
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

        *-- Botao Cancelar (volta para lista)
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

        *----------------------------------------------------------------------
        * DESCRICAO (Get_desc: Top=172+29=201, Left=268, Width=150, Height=23)
        * Say1: Top=176+29=205, Left=191, Width=78 - SOMENTE LEITURA (DopePafEcfs)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Top       = 205
            .Left      = 191
            .Width     = 78
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 201
            .Left          = 268
            .Width         = 150
            .Height        = 23
            .FontName      = "Courier New"
            .FontSize      = 8
            .MaxLength     = 50
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * INATIVA (Chk_Inativar: Top=176+29=205, Left=443, Width=74, Height=15)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("chk_4c_Inativar", "CheckBox")
        WITH loc_oPagina.chk_4c_Inativar
            .Caption   = "INATIVA"
            .Top       = 205
            .Left      = 443
            .Width     = 74
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .T.
            .Value     = 0
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * LABEL DOCUMENTO (Say2: Top=220+29=249, Left=189)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Documento", "Label")
        WITH loc_oPagina.lbl_4c_Documento
            .Caption   = "Documento :"
            .Top       = 249
            .Left      = 189
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TIPO DOCUMENTO (op_doc: Top=220+29=249, Left=263, Width=140, Height=63)
        * 5 botoes: CF(1), CNF(2), DAV RG(3), DAV A4(4), PRE VENDA(5)
        * ButtonCount ANTES do WITH para criar os botoes (analogo ao ColumnCount do Grid)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("opt_4c_TipoDoc", "OptionGroup")
        loc_oPagina.opt_4c_TipoDoc.ButtonCount = 5
        WITH loc_oPagina.opt_4c_TipoDoc
            .Top         = 249
            .Left        = 263
            .Width       = 140
            .Height      = 63
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Enabled     = .F.
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "CF"
                .Top       = 2
                .Left      = 5
                .Width     = 34
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "CNF"
                .Top       = 2
                .Left      = 74
                .Width     = 42
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "DAV RG"
                .Top       = 19
                .Left      = 5
                .Width     = 64
                .Height    = 17
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH .Buttons(4)
                .Caption   = "DAV A4"
                .Top       = 19
                .Left      = 74
                .Width     = 61
                .Height    = 17
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
            ENDWITH

            WITH .Buttons(5)
                .Caption   = "PRE VENDA"
                .Top       = 38
                .Left      = 5
                .Width     = 88
                .Height    = 17
                .FontName  = "Verdana"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(36, 84, 155)
            ENDWITH
        ENDWITH

        *----------------------------------------------------------------------
        * LABEL NR CAIXA (Say29: Top=292+29=321, Left=135)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_NroCaixa", "Label")
        WITH loc_oPagina.lbl_4c_NroCaixa
            .Caption   = "N" + CHR(186) + " do Caixa - NSEQ. :"
            .Top       = 321
            .Left      = 135
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * NR CAIXA (Get_ncaixa: Top=289+29=318, Left=268, Width=31, Height=21)
        * Valid: se preenchido, obrigatorio 3 digitos
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_NroCaixa", "TextBox")
        WITH loc_oPagina.txt_4c_NroCaixa
            .Value         = ""
            .Top           = 318
            .Left          = 268
            .Width         = 31
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_NroCaixa, "KeyPress", THIS, "ValidarNroCaixa")

        *----------------------------------------------------------------------
        * LABEL FINALIZADORA NAO FISCAL (Say18: Top=319+29=348, Left=125)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_FinalizNaoFiscal", "Label")
        WITH loc_oPagina.lbl_4c_FinalizNaoFiscal
            .Caption   = "Finalizadora N" + CHR(227) + "o Fiscal :"
            .Top       = 348
            .Left      = 125
            .Height    = 17
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CUPOM NAO FISCAL (Get_cupomnfis: Top=316+29=345, Left=268, Width=24, Height=21)
        * Lookup em SigFiNtb.ordems (F4/F5 ou LostFocus)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_CupomNfis", "TextBox")
        WITH loc_oPagina.txt_4c_CupomNfis
            .Value         = ""
            .Top           = 345
            .Left          = 268
            .Width         = 24
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "99"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CupomNfis, "KeyPress", THIS, "ValidarCupomNfis")
        BINDEVENT(loc_oPagina.txt_4c_CupomNfis, "KeyPress", THIS, "TeclaLookupCupomNfis")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Popula grid com cursor_4c_Dados (colunas decodificadas)
    * Ordem legado: pColuna('DopePafEcfs',200), pColuna('CX',90), pColuna('TRNF',161)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount  = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- ControlSource APOS RecordSource (Problema 48)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.DopePafEcfs"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Cx"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TrNf"

                loc_oGrid.Column1.Width = 200
                loc_oGrid.Column2.Width = 90
                loc_oGrid.Column3.Width = 161

                *-- Headers APOS RecordSource (Problema 2/32)
                loc_oGrid.Column1.Header1.Caption = "Fun" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column2.Header1.Caption = "N" + CHR(186) + " do caixa"
                loc_oGrid.Column3.Header1.Caption = "Finalizadora N" + CHR(227) + "o Fiscal"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Formpaf.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
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

        CATCH TO loc_oErro
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, ;
                "Formpaf.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loc_oErro
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loc_oErro.Message, ;
                "Formpaf.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cDopes
        loc_cDopes = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cDopes = ALLTRIM(cursor_4c_Dados.Dopes)
        ENDIF

        IF EMPTY(loc_cDopes)
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 em modo edicao com validacao MD5 previa
    * REGRA PAF: Valida integridade MD5 antes de abrir edicao (legado: Grupo_op.Click)
    * Se MD5 invalido: exibe aviso e permanece em Page1
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cDopes, loc_cDopesDecod
        loc_cDopes      = ""
        loc_cDopesDecod = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cDopes      = ALLTRIM(cursor_4c_Dados.Dopes)
            loc_cDopesDecod = ALLTRIM(cursor_4c_Dados.DopePafEcfs)
        ENDIF

        IF EMPTY(loc_cDopes)
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            IF !THIS.this_oBusinessObject.ValidarIntegridade(loc_cDopesDecod)
                MsgErro("Par" + CHR(226) + "metros de Fun" + CHR(231) + CHR(227) + "o Incorreto. " + ;
                        "Os Dados Foram alterados!!!" + CHR(13) + ;
                        "Favor Sair da Tela de Fun" + CHR(231) + CHR(227) + "o e Entrar Novamente.", " ")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Inclusao nao suportada: registros PAF-ECF gerenciados automaticamente
    * O sistema sincroniza SigCdPaf com SigOpCdd no Init (plAcInserir=.F. no legado)
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        MsgInfo("Inclus" + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel." + CHR(13) + ;
                "Os registros PAF-ECF s" + CHR(227) + "o gerenciados automaticamente" + CHR(13) + ;
                "com base nas opera" + CHR(231) + CHR(245) + "es cadastradas.")
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclusao nao suportada: registros PAF-ECF gerenciados automaticamente
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        MsgInfo("Exclus" + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel." + CHR(13) + ;
                "Os registros PAF-ECF s" + CHR(227) + "o gerenciados automaticamente" + CHR(13) + ;
                "com base nas opera" + CHR(231) + CHR(245) + "es cadastradas.")
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre picker na lista PAF-ECF (colunas decodificadas)
    * Usa cursor_4c_Dados existente (ja decodificado por Buscar)
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca

        TRY
            IF !USED("cursor_4c_Dados")
                THIS.CarregarLista()
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_Dados"
                loc_oBusca.this_cTitulo        = "Buscar PAF-ECF"
                loc_oBusca.mAddColuna("DopePafEcfs", "", "Fun" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("Cx",          "", "N" + CHR(186) + " do caixa")
                loc_oBusca.mAddColuna("TrNf",        "", "Finalizadora N" + CHR(227) + "o Fiscal")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Dados")
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "Formpaf.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma e salva (apenas ALTERAR e suportado)
    * Transfere form -> BO -> BO.Salvar() -> volta para Page1
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        IF THIS.this_cModoAtual != "ALTERAR"
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados do form para o BO antes de salvar
    * Campos editaveis: nOpDoc, lInativa, cNcaixa, cCupomNfis
    * cDopePafEcfs (readonly) ja esta no BO de CarregarPorCodigo - nao transfere
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_nOpDoc     = loc_oPagina.opt_4c_TipoDoc.Value
        THIS.this_oBusinessObject.this_lInativa   = (loc_oPagina.chk_4c_Inativar.Value = 1)
        THIS.this_oBusinessObject.this_cNcaixa    = ALLTRIM(loc_oPagina.txt_4c_NroCaixa.Value)
        THIS.this_oBusinessObject.this_cCupomNfis = ALLTRIM(loc_oPagina.txt_4c_CupomNfis.Value)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere dados do BO para o form apos CarregarPorCodigo
    * opt_4c_TipoDoc.Value = 1-5 (CF/CNF/DAV RG/DAV A4/PRE VENDA); 0 = default CF
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_nOpDoc
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_nOpDoc  = THIS.this_oBusinessObject.this_nOpDoc

        loc_oPagina.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cDopePafEcfs
        loc_oPagina.chk_4c_Inativar.Value  = IIF(THIS.this_oBusinessObject.this_lInativa, 1, 0)
        loc_oPagina.txt_4c_NroCaixa.Value  = THIS.this_oBusinessObject.this_cNcaixa
        loc_oPagina.txt_4c_CupomNfis.Value = THIS.this_oBusinessObject.this_cCupomNfis

        IF loc_nOpDoc >= 1 AND loc_nOpDoc <= 5
            loc_oPagina.opt_4c_TipoDoc.Value = loc_nOpDoc
        ELSE
            loc_oPagina.opt_4c_TipoDoc.Value = 1
        ENDIF
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos editaveis de Page2
    * txt_4c_Descricao sempre ReadOnly (exibe DopePafEcfs decodificado)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "chk_4c_Inativar", 5)
            loc_oPagina.chk_4c_Inativar.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_TipoDoc", 5)
            loc_oPagina.opt_4c_TipoDoc.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_NroCaixa", 5)
            loc_oPagina.txt_4c_NroCaixa.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CupomNfis", 5)
            loc_oPagina.txt_4c_CupomNfis.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa valores dos campos editaveis de Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_Descricao", 5)
            loc_oPagina.txt_4c_Descricao.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "chk_4c_Inativar", 5)
            loc_oPagina.chk_4c_Inativar.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPagina, "opt_4c_TipoDoc", 5)
            loc_oPagina.opt_4c_TipoDoc.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_NroCaixa", 5)
            loc_oPagina.txt_4c_NroCaixa.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina, "txt_4c_CupomNfis", 5)
            loc_oPagina.txt_4c_CupomNfis.Value = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita Confirmar apenas em ALTERAR
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEditando
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = (THIS.this_cModoAtual = "ALTERAR")

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
    * ValidarNroCaixa - Valida Nr Caixa ao sair do campo (Get_ncaixa.Valid do legado)
    * Obrigatorio 3 digitos quando preenchido
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE ValidarNroCaixa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina, "txt_4c_NroCaixa", 5)
            loc_cValor = ALLTRIM(loc_oPagina.txt_4c_NroCaixa.Value)
            IF !EMPTY(loc_cValor) AND LEN(loc_cValor) < 3
                MsgAviso("Obrigatorio Preenchimento de 3 digitos")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * TeclaLookupCupomNfis - Abre lookup SigFiNtb com F4(115) ou F5(116)
    * PUBLIC: BINDEVENT exige metodo publico com parametros do evento KeyPress
    *===========================================================================
    PROCEDURE TeclaLookupCupomNfis(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCupomNfis()
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarCupomNfis - Valida Finalizadora Nao Fiscal ao sair do campo
    * Busca SigFiNtb por ordems; se nao encontrar abre picker
    * PUBLIC: BINDEVENT exige metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE ValidarCupomNfis(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor, loc_nOrdem, loc_cSQL, loc_nResult
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina, "txt_4c_CupomNfis", 5)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(loc_oPagina.txt_4c_CupomNfis.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_nOrdem  = VAL(loc_cValor)
        loc_cSQL    = "SELECT ordems, descrs FROM SigFiNtb ORDER BY ordems"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NtbVal")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_NtbVal") > 0
            SELECT cursor_4c_NtbVal
            LOCATE FOR cursor_4c_NtbVal.ordems = loc_nOrdem
            IF FOUND()
                loc_oPagina.txt_4c_CupomNfis.Value = ALLTRIM(STR(cursor_4c_NtbVal.ordems, 2))
                IF USED("cursor_4c_NtbVal")
                    USE IN cursor_4c_NtbVal
                ENDIF
            ELSE
                IF USED("cursor_4c_NtbVal")
                    USE IN cursor_4c_NtbVal
                ENDIF
                THIS.AbrirBuscaCupomNfis()
            ENDIF
        ELSE
            IF USED("cursor_4c_NtbVal")
                USE IN cursor_4c_NtbVal
            ENDIF
            THIS.AbrirBuscaCupomNfis()
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirBuscaCupomNfis - Abre FormBuscaAuxiliar para selecionar SigFiNtb.ordems
    * Equivale ao fwBuscaExt do legado: Get_cupomnfis.Valid
    * Colunas: ordems/descrs/Imps/OpeRnf (mesmas do legado mAddColuna)
    *===========================================================================
    PROCEDURE AbrirBuscaCupomNfis()
        LOCAL loc_oPagina, loc_cSQL, loc_nResult, loc_oBusca
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cSQL    = "SELECT ordems, descrs, Imps, OpeRnf FROM SigFiNtb ORDER BY ordems"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NtbBusca")

            IF loc_nResult >= 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_NtbBusca"
                    loc_oBusca.this_cTitulo        = "Sele" + CHR(231) + CHR(227) + "o"
                    loc_oBusca.mAddColuna("ordems", "xxxxx",               "Ordem")
                    loc_oBusca.mAddColuna("descrs", "xxxxxxxxxXxxxxxxxxxx", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Imps",   "",                    "Impressora")
                    loc_oBusca.mAddColuna("OpeRnf", "xxxxxx",              "Codigo")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_NtbBusca")
                        SELECT cursor_4c_NtbBusca
                        IF PEMSTATUS(loc_oPagina, "txt_4c_CupomNfis", 5)
                            loc_oPagina.txt_4c_CupomNfis.Value = ALLTRIM(STR(cursor_4c_NtbBusca.ordems, 2))
                        ENDIF
                    ELSE
                        *-- ESC: limpa o campo (legado: this.value = '0')
                        IF PEMSTATUS(loc_oPagina, "txt_4c_CupomNfis", 5)
                            loc_oPagina.txt_4c_CupomNfis.Value = "0"
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgErro("Erro ao carregar SigFiNtb: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Formpaf.AbrirBuscaCupomNfis: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_NtbBusca")
            USE IN cursor_4c_NtbBusca
        ENDIF
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
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
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_NtbVal")
            USE IN cursor_4c_NtbVal
        ENDIF

        IF USED("cursor_4c_NtbBusca")
            USE IN cursor_4c_NtbBusca
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
