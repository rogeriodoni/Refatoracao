*==============================================================================
* FormTCL.prg
* Formulario de Cadastro de Classes (SIGCDTCL)
*
* Tabela principal: SigCdCss (classes PK)
* Tipo: CRUD (frmcadastro)
* BO: TCLBO
*==============================================================================

DEFINE CLASS FormTCL AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Classes"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual       = "LISTA"

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("TCLBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar TCLBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
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

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: cabecalho (faixa) + botoes CRUD
    * (Incluir/Visualizar/Alterar/Excluir/Buscar/Encerrar) + grid de listagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oBotoes
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Cabecalho cinza (PRIMEIRO AddObject da pagina - CLAUDE.md regra #11)
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

        *-- Container de botoes CRUD (Grupo_op no legado: Left=542, Top=29)
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
        BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPg1.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPg1.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar
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
        BINDEVENT(loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem de classes (colunas do legado: classes, descrs, nivels -
        *-- pColuna('classes',...,100), pColuna('descrs',...,319), pColuna('nivels',...,83))
        *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oPg1.grd_4c_Lista.ColumnCount = 3
        WITH loc_oPg1.grd_4c_Lista
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
        BINDEVENT(loc_oPg1.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: faixa de cabecalho + container de botoes
    * de acao + primeiros 50% dos campos (Nivel, Classe, Descricao)
    * CLAUDE.md regra #11: a faixa deve ser o PRIMEIRO AddObject da pagina;
    * containers de botao (Top=29..33) sao criados DEPOIS para desenhar por cima.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oCab, loc_oBotoesAcao
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Faixa de cabecalho cinza (PRIMEIRO AddObject da pagina)
        loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg2.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 29
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

        *-- Container de botoes de acao (Grupo_Salva no legado) - criado DEPOIS
        *-- da faixa para desenhar por cima (Top=33 fica dentro da area 29..109)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
        WITH loc_oBotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- ===================================================================
        *-- CAMPOS PRINCIPAIS - PARTE 1/2 (FASE 5/8)
        *-- Compensacao PageFrame.Top=-29: Top_migrado = Top_original + 29
        *-- ===================================================================

        *-- txt_4c_Nivel (Get_nivel: ControlSource=crSigCdCss.nivels, Top=175,
        *-- Left=448, Width=17, Height=25) - numeric(1,0), dominio [1,2,3]
        loc_oPg2.AddObject("txt_4c_Nivel", "TextBox")
        WITH loc_oPg2.txt_4c_Nivel
            .Top           = 204
            .Left          = 448
            .Width         = 17
            .Height        = 25
            .InputMask     = "9"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ForeColor     = RGB(0, 0, 0)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label1 (Say1: "N?vel :", Top=180, Left=414)
        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .AutoSize  = .T.
            .Caption   = "N" + CHR(237) + "vel :"
            .Top       = 209
            .Left      = 414
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label3 (Say3: dica de dominio "[1,2,3]", Top=179, Left=468)
        loc_oPg2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2.lbl_4c_Label3
            .AutoSize  = .T.
            .Caption   = "[1,2,3]"
            .Top       = 208
            .Left      = 468
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Classe (Get_classe: ControlSource=crSigCdCss.classes, Top=202,
        *-- Left=448, Width=80, Height=25) - char(10), tamanho depende do nivel
        loc_oPg2.AddObject("txt_4c_Classe", "TextBox")
        WITH loc_oPg2.txt_4c_Classe
            .Top           = 231
            .Left          = 448
            .Width         = 80
            .Height        = 25
            .MaxLength     = 10
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ForeColor     = RGB(0, 0, 0)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label4 (Say4: "Classe :", Top=207, Left=406)
        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .AutoSize  = .T.
            .Caption   = "Classe :"
            .Top       = 236
            .Left      = 406
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Descr (Get_descr: ControlSource=crSigCdCss.descrs, Top=229,
        *-- Left=448, Width=220, Height=25) - char(30)
        loc_oPg2.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPg2.txt_4c_Descr
            .Top           = 258
            .Left          = 448
            .Width         = 220
            .Height        = 25
            .MaxLength     = 30
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ForeColor     = RGB(0, 0, 0)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label2 (Say2: "Descri??o :", Top=234, Left=391)
        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .AutoSize  = .T.
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 263
            .Left      = 391
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENT Nivel/Classe - reproduz Get_nivel.Valid e Get_classe.GotFocus
        *-- do legado (ajuste dinamico de mascara + forca opbalancos=Sim quando nivel<>1)
        BINDEVENT(loc_oPg2.txt_4c_Nivel, "LostFocus", THIS, "ValidarCampoNivel")
        BINDEVENT(loc_oPg2.txt_4c_Classe, "GotFocus", THIS, "AjustarMascaraClasse")

        *-- ===================================================================
        *-- CAMPOS PRINCIPAIS - PARTE 2/2 (FASE 6/8)
        *-- OptionGroups (SEM lookup - comportamento.json confirma temLookup=false
        *-- em todos os 9 metodos do form original; nenhuma tabela auxiliar
        *-- referenciada via fwbuscaext/fwBuscaSel/sigacess)
        *-- ===================================================================

        *-- opt_4c_OpBalanco (optGreps: ControlSource=crSigCdCss.opbalancos,
        *-- Top=255, Left=442, Height=25) - "Incluir em Invent?rio" Sim(1)/Nao(2)
        loc_oPg2.AddObject("opt_4c_OpBalanco", "OptionGroup")
        WITH loc_oPg2.opt_4c_OpBalanco
            .ButtonCount = 2
            .Top         = 284
            .Left        = 442
            .Width       = 95
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.opt_4c_OpBalanco.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.opt_4c_OpBalanco.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 50
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        *-- lbl_4c_Label5 (Say5: "Incluir em Invent?rio :", Top=260, Left=338)
        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .AutoSize  = .T.
            .Caption   = "Incluir em Invent" + CHR(225) + "rio :"
            .Top       = 289
            .Left      = 338
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- opt_4c_InvEmisCc (Fwoption1: ControlSource=crSigCdCss.invemisccs,
        *-- Top=278, Left=442, Height=25) - "Trocar CC por Emissor" Sim(1)/Nao(2)
        loc_oPg2.AddObject("opt_4c_InvEmisCc", "OptionGroup")
        WITH loc_oPg2.opt_4c_InvEmisCc
            .ButtonCount = 2
            .Top         = 307
            .Left        = 442
            .Width       = 95
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg2.opt_4c_InvEmisCc.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        WITH loc_oPg2.opt_4c_InvEmisCc.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 50
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH

        *-- lbl_4c_Label6 (Say6: "Trocar CC por Emissor :", Top=283, Left=331)
        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .AutoSize  = .T.
            .Caption   = "Trocar CC por Emissor :"
            .Top       = 312
            .Left      = 331
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- BOTOES DE ACAO (Grupo_Salva no legado) - dentro de cnt_4c_BotoesAcao
        *-- criado em InicializarForm/ConfigurarPaginaDados acima (Top=33,Left=842)
        *-- ===================================================================

        *-- cmd_4c_Confirmar (Salva: Left=5, Top=5)
        loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Confirmar
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
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- cmd_4c_Cancelar (Cancelar: Left=80, Top=5)
        loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oBotoesAcao.cmd_4c_Cancelar
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
        BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCampoNivel - Equivalente ao SIGCDTCL.Pagina.Dados.Get_nivel.Valid
    * do legado: nivel fora de [1,2,3] avisa e devolve foco; nivel <> 1 forca
    * "Incluir em Invent?rio" = Sim (Buttons(1)) automaticamente.
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCampoNivel()
        LOCAL loc_oPg2, loc_nNivel

        TRY
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2
            loc_nNivel = VAL(TRANSFORM(loc_oPg2.txt_4c_Nivel.Value))

            IF EMPTY(ALLTRIM(TRANSFORM(loc_oPg2.txt_4c_Nivel.Value)))
                *-- campo vazio: nao valida agora (sera pego na validacao final do BO)
            ELSE
                IF !INLIST(loc_nNivel, 1, 2, 3)
                    MsgAviso("N" + CHR(237) + "vel Inv" + CHR(225) + "lido !!")
                    loc_oPg2.txt_4c_Nivel.SetFocus()
                ELSE
                    *-- Get_nivel.Valid: This.Parent.optGreps.Value = Iif(nivel==1, atual, 1)
                    IF loc_nNivel != 1
                        loc_oPg2.opt_4c_OpBalanco.Value = 1
                        loc_oPg2.opt_4c_OpBalanco.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.ValidarCampoNivel")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarMascaraClasse - Equivalente ao SIGCDTCL.Pagina.Dados.Get_classe.GotFocus
    * do legado: monta InputMask conforme o nivel (1 digito/2 digitos/4 digitos)
    * e limpa o valor se ele nao couber mais na nova mascara.
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarMascaraClasse()
        LOCAL loc_oPg2, loc_nNivel, loc_nMaxDig

        TRY
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_nNivel = VAL(TRANSFORM(loc_oPg2.txt_4c_Nivel.Value))
            loc_nMaxDig = 0

            DO CASE
                CASE loc_nNivel = 1
                    loc_oPg2.txt_4c_Classe.InputMask = "9"
                    loc_nMaxDig = 1
                CASE loc_nNivel = 2
                    loc_oPg2.txt_4c_Classe.InputMask = "99"
                    loc_nMaxDig = 2
                CASE loc_nNivel = 3
                    loc_oPg2.txt_4c_Classe.InputMask = "9999"
                    loc_nMaxDig = 4
            ENDCASE

            *-- So limpa o campo se diminuiu o tamanho de digitos possiveis
            IF loc_nMaxDig > 0 AND LEN(ALLTRIM(loc_oPg2.txt_4c_Classe.Value)) > loc_nMaxDig
                loc_oPg2.txt_4c_Classe.Value = ""
                loc_oPg2.txt_4c_Classe.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.AjustarMascaraClasse")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no grid da Page1 (cursor_4c_Dados)
    * Colunas: classes (100), descrs (319), nivels (83) - conforme AddCursor/
    * pColuna do SIGCDTCL.Init original
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource ANTES de ControlSource (ColumnCount FORA do WITH)
                    loc_oGrid.ColumnCount  = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    *-- ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.classes"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.nivels"

                    loc_oGrid.Column1.Width = 100
                    loc_oGrid.Column2.Width = 319
                    loc_oGrid.Column3.Width = 83

                    *-- Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
                    loc_oGrid.Column1.Header1.Caption = "Classe"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "N" + CHR(237) + "vel"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormTCL.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista
    *--------------------------------------------------------------------------
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
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormTCL.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loc_oErro
            MsgErro("Erro ao formatar grid:" + CHR(13) + loc_oErro.Message, "FormTCL.FormatarGridLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
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
    * FormParaBO - Transfere valores dos campos da Page2 para o BO
    * (chamado antes de THIS.this_oBusinessObject.Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            THIS.this_oBusinessObject.this_cClasse    = ALLTRIM(TRANSFORM(loc_oPg2.txt_4c_Classe.Value))
            THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
            THIS.this_oBusinessObject.this_nNivel     = TRANSFORM(loc_oPg2.txt_4c_Nivel.Value)
            THIS.this_oBusinessObject.this_nOpBalanco = loc_oPg2.opt_4c_OpBalanco.Value
            THIS.this_oBusinessObject.this_nInvEmisCc = loc_oPg2.opt_4c_InvEmisCc.Value
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os campos da Page2
    * (chamado apos CarregarPorCodigo, em Alterar/Visualizar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Classe.Value = ALLTRIM(THIS.this_oBusinessObject.this_cClasse)
            loc_oPg2.txt_4c_Descr.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
            loc_oPg2.txt_4c_Nivel.Value  = THIS.this_oBusinessObject.this_nNivel

            *-- Ajusta InputMask da Classe conforme o nivel carregado
            *-- (mesma logica do GotFocus/AjustarMascaraClasse)
            DO CASE
                CASE THIS.this_oBusinessObject.this_nNivel = 1
                    loc_oPg2.txt_4c_Classe.InputMask = "9"
                CASE THIS.this_oBusinessObject.this_nNivel = 2
                    loc_oPg2.txt_4c_Classe.InputMask = "99"
                CASE THIS.this_oBusinessObject.this_nNivel = 3
                    loc_oPg2.txt_4c_Classe.InputMask = "9999"
                OTHERWISE
                    loc_oPg2.txt_4c_Classe.InputMask = ""
            ENDCASE

            loc_oPg2.opt_4c_OpBalanco.Value = IIF(THIS.this_oBusinessObject.this_nOpBalanco = 0, 1, THIS.this_oBusinessObject.this_nOpBalanco)
            loc_oPg2.opt_4c_InvEmisCc.Value = IIF(THIS.this_oBusinessObject.this_nInvEmisCc = 0, 1, THIS.this_oBusinessObject.this_nInvEmisCc)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2 (modo INCLUIR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Classe.InputMask = ""
            loc_oPg2.txt_4c_Classe.Value     = ""
            loc_oPg2.txt_4c_Descr.Value      = ""
            loc_oPg2.txt_4c_Nivel.Value      = 0
            loc_oPg2.opt_4c_OpBalanco.Value  = 1
            loc_oPg2.opt_4c_InvEmisCc.Value  = 1
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
    * txt_4c_Classe (PK) so fica editavel em modo INCLUIR (Alterar mantem
    * a chave travada, igual ao legado - classes nao pode ser trocada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lHabilitar

        TRY
            loc_oPg2       = THIS.pgf_4c_Paginas.Page2
            loc_lHabilitar = (par_lHabilitar = .T.)

            loc_oPg2.txt_4c_Classe.Enabled     = loc_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
            loc_oPg2.txt_4c_Nivel.Enabled      = loc_lHabilitar
            loc_oPg2.txt_4c_Descr.Enabled      = loc_lHabilitar
            loc_oPg2.opt_4c_OpBalanco.Enabled  = loc_lHabilitar
            loc_oPg2.opt_4c_InvEmisCc.Enabled  = loc_lHabilitar

            *-- Confirmar tambem fica habilitado em modo EXCLUIR (padrao CLAUDE.md)
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHabilitar OR (THIS.this_cModoAtual = "EXCLUIR")
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.

            THIS.AjustarBotoesPorModo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara BO e formulario para inclusao de nova classe
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Nivel.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega classe selecionada na grade e habilita edicao
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cClasse

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma classe para alterar!")
            ELSE
                SELECT cursor_4c_Dados
                IF EOF()
                    MsgAviso("Selecione uma classe para alterar!")
                ELSE
                    loc_cClasse = ALLTRIM(cursor_4c_Dados.classes)

                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cClasse)
                        THIS.this_oBusinessObject.EditarRegistro()
                        THIS.this_cModoAtual = "ALTERAR"
                        THIS.BOParaForm()
                        THIS.HabilitarCampos(.T.)
                        THIS.AlternarPagina(2)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega classe selecionada em modo somente leitura
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cClasse

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma classe para visualizar!")
            ELSE
                SELECT cursor_4c_Dados
                IF EOF()
                    MsgAviso("Selecione uma classe para visualizar!")
                ELSE
                    loc_cClasse = ALLTRIM(cursor_4c_Dados.classes)

                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cClasse)
                        THIS.this_cModoAtual = "VISUALIZAR"
                        THIS.BOParaForm()
                        THIS.HabilitarCampos(.F.)
                        THIS.AlternarPagina(2)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui a classe selecionada na grade
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cClasse

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Selecione uma classe para excluir!")
            ELSE
                SELECT cursor_4c_Dados
                IF EOF()
                    MsgAviso("Selecione uma classe para excluir!")
                ELSE
                    loc_cClasse = ALLTRIM(cursor_4c_Dados.classes)

                    IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da classe " + loc_cClasse + "?")
                        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cClasse)
                            THIS.this_cModoAtual = "EXCLUIR"

                            IF THIS.this_oBusinessObject.Excluir()
                                MsgInfo("Classe exclu" + CHR(237) + "da com sucesso!")
                                THIS.this_cModoAtual = "LISTA"
                                THIS.CarregarLista()
                            ELSE
                                THIS.this_cModoAtual = "LISTA"
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Filtra a lista pelo codigo/descricao da classe
    * (nao existe fwbuscaext/fwBuscaSel/sigacess no original - comportamento.json
    * confirma temLookup=false em todos os 9 metodos; "Buscar" aqui e o filtro
    * simples da lista, equivalente ao LocateCursor do Procedure do legado)
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_cClasse

        TRY
            loc_cClasse = ALLTRIM(INPUTBOX("Digite a classe para filtrar (em branco lista todas):", "Buscar Classe", ""))

            IF EMPTY(loc_cClasse)
                loc_cFiltro = ""
            ELSE
                loc_cFiltro = "classes LIKE " + EscaparSQL(loc_cClasse + "%")
            ENDIF

            IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                MsgErro("Erro ao buscar classes!", "FormTCL.BtnBuscarClick")
            ELSE
                LOCAL loc_oGrid
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount  = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.classes"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.nivels"

                loc_oGrid.Column1.Width = 100
                loc_oGrid.Column2.Width = 319
                loc_oGrid.Column3.Width = 83

                loc_oGrid.Column1.Header1.Caption = "Classe"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "N" + CHR(237) + "vel"

                THIS.FormatarGridLista(loc_oGrid)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirma inclusao/alteracao: valida, transfere Form->BO
    * e persiste (Salvar() decide INSERT/UPDATE por this_lNovoRegistro)
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Classe salva com sucesso!")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao/visualizacao e volta para a lista
    * PUBLIC (sem PROTECTED) - OBRIGATORIO para BINDEVENT funcionar (CLAUDE.md #3)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar conforme this_cModoAtual
    * (INCLUIR/ALTERAR: Confirmar habilitado; VISUALIZAR: Confirmar desabilitado;
    * EXCLUIR: Confirmar habilitado - padrao CLAUDE.md, ver HabilitarCampos)
    * PUBLIC (sem PROTECTED) - TesteAutomatico.prg chama THIS.oForm.AjustarBotoesPorModo()
    * de fora da classe; PROTECTED bloqueia a chamada externa mesmo com PEMSTATUS = .T.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao

        TRY
            loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

            DO CASE
                CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                    loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                    loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
                CASE THIS.this_cModoAtual = "VISUALIZAR"
                    loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                    loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
                CASE THIS.this_cModoAtual = "EXCLUIR"
                    loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                    loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
                OTHERWISE
                    loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                    loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormTCL.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
