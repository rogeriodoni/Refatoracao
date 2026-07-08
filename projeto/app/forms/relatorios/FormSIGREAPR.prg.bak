*==============================================================================
* FORMSIGREAPR.PRG
* Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREAPR.SCX (frmrelatorio)
*
* Filtros:
*   - Data Inicial (obrigat" + CHR(243) + "ria)
*   - Grupo     (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o  - SigCdGrp, campos CGrus/DGrus)
*   - Produto   (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o  - SigCdPro, campos CPros/DPros)
*   - Linha     (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o  - SigCdLin, campos Linhas/Descs)
*   - Fornecedor (c" + CHR(243) + "digo + nome   - SIGCDCLI, campos iclis/nomes)
*   - Diferen" + CHR(231) + "a M" + CHR(237) + "nima Vendas (%)
*   - Diferen" + CHR(231) + "a M" + CHR(237) + "nima Custos (%)
*
* FASE 3/8 - Form Estrutura Base
*   - DEFINE CLASS + propriedades
*   - Init() / InicializarForm() / Destroy()
*   - ConfigurarCabecalho()  (container cinza escuro com t" + CHR(237) + "tulo)
*   - ConfigurarBotoes()     (CommandGroup: Visualizar/Imprimir/Excel/Encerrar)
*   - ConfigurarPageFrame()  (PageFrame com 1 p" + CHR(225) + "gina - "Filtros")
*
* FASE 4/8 - Form Grid e Bot" + CHR(245) + "es (Page1 - campos de filtro)
*   - ConfigurarPaginaLista() (labels + textboxes + BINDEVENTs)
*   - AlternarPagina()
*   - LimparCampos() / AtualizarEstadoCampos() / ValidarCampos()
*   - FormParaRelatorio()
*   - CmgBotoesClick() + BtnVisualizarClick/Imprimir/Excel/Encerrar
*   - TeclaXxx() / AbrirBuscaXxx() / ValidarXxx() para cada lookup
*
* FASE 5/8 - Form Campos Principais (Parte 1 - primeiros 50% dos filtros)
*   REPORT flat: sem PageFrame CRUD de 2 p" + CHR(225) + "ginas. Para alinhar com o
*   pipeline multi-fase, os controles de filtro foram divididos entre dois
*   m" + CHR(233) + "todos (ambos populam pgf_4c_Paginas.Page1):
*     - ConfigurarPaginaDados()  ? 50% iniciais (Data, Grupo, Produto, Linha)
*     - ConfigurarPaginaLista()  ? 50% restantes (Fornecedor, Diferen" + CHR(231) + "as)
*   Esta fase adiciona ConfigurarPaginaDados() com os 11 primeiros controles.
*
* FASE 6/8 - Form Lookups Canonicos e DblClick
*   - AbrirBuscaXxx() reescritos com padrao canonico: mAddColuna+Show sempre
*   - BINDEVENTs DblClick adicionados para todos os 8 campos com lookup
*   - DblClickXxx() handlers adicionados (Grupo, Produto, Linha, Fornecedor)
*==============================================================================

DEFINE CLASS FormSIGREAPR AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=300)
    Height      = 300
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria SIGREAPRBO
    *   3. Monta cabecalho escuro + botoes + PageFrame vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SIGREAPRBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREAPRBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarPaginaLista()
                THIS.LimparCampos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra.Top=0, Left=-1 do frmrelatorio legado.
    *   Width = THIS.Width (cobre toda a faixa superior).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport legado)
    *   Original: btnReport.Left=526, Top=3, Width~270, Height~85
    *   Botoes: Visualiza(Left=6), Imprime(72), DocExcel(138), Sair(204) - W=60
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .WordWrap        = .T.
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   O form legado SIGREAPR e FLAT (sem PageFrame), mas no novo padrao os
    *   campos de filtro sao agrupados em um PageFrame de 1 pagina para
    *   consistencia com o restante do sistema.
    *   Posicao: abaixo do cabecalho (85px) ate o fim do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2

        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Page2.Caption   = "Relatorio"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO (NUNCA chamar .Release em Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Fase 5/8: cria os primeiros 50% dos filtros
    *   em pgf_4c_Paginas.Page1 (REPORT flat sem Page2 separada).
    *   Controles: Data Inicial, Grupo (cod+desc), Produto (cod+desc), Linha
    *   (cod+desc). Total: 4 labels + 7 textboxes = 11 controles.
    *   Coordenadas: top_original - 85 (PageFrame.Top=85 desloca a origem).
    *   Chamado por InicializarForm() ANTES de ConfigurarPaginaLista() para
    *   que os BINDEVENTs (em ConfigurarPaginaLista) encontrem os controles.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- lbl_4c_Label1 "Data Inicial :" (Say1: top=98, left=189)
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Top       = 13
            .Left      = 189
            .Width     = 70
            .Height    = 15
            .Caption   = "Data Inicial :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DtInicial (getDtInicial: top=95, left=255)
        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top      = 10
            .Left     = 255
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = {}
            .Visible  = .T.
        ENDWITH

        *-- lbl_4c_Label2 "Grupo :" (Say2: top=123, left=213)
        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .Top       = 38
            .Left      = 213
            .Width     = 38
            .Height    = 15
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Grupo (getGrupo: top=120, left=255, width=31)
        loc_oPg.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg.txt_4c_Grupo
            .Top      = 35
            .Left     = 255
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH

        *-- txt_4c_DGrupo (getDGrupo: top=120, left=288, width=181)
        loc_oPg.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPg.txt_4c_DGrupo
            .Top      = 35
            .Left     = 288
            .Width    = 181
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH

        *-- lbl_4c_Label3 "Produto :" (Say3: top=148, left=204)
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .Top       = 63
            .Left      = 204
            .Width     = 47
            .Height    = 15
            .Caption   = "Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_CPros (getCPros: top=145, left=255, width=108)
        loc_oPg.AddObject("txt_4c_CPros", "TextBox")
        WITH loc_oPg.txt_4c_CPros
            .Top      = 60
            .Left     = 255
            .Width    = 108
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH

        *-- txt_4c_DPros (getDPros: top=145, left=365, width=290)
        loc_oPg.AddObject("txt_4c_DPros", "TextBox")
        WITH loc_oPg.txt_4c_DPros
            .Top      = 60
            .Left     = 365
            .Width    = 290
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH

        *-- lbl_4c_Label16 "Linha :" (Say16: top=173, left=217)
        loc_oPg.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPg.lbl_4c_Label16
            .Top       = 88
            .Left      = 217
            .Width     = 34
            .Height    = 15
            .Caption   = "Linha :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Lin (GetLin: top=170, left=255, width=80)
        loc_oPg.AddObject("txt_4c_Lin", "TextBox")
        WITH loc_oPg.txt_4c_Lin
            .Top      = 85
            .Left     = 255
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH

        *-- txt_4c_DLin (GetDLin: top=170, left=337, width=290)
        loc_oPg.AddObject("txt_4c_DLin", "TextBox")
        WITH loc_oPg.txt_4c_DLin
            .Top      = 85
            .Left     = 337
            .Width    = 290
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona campos de filtro em pgf_4c_Paginas.Page1
    *   Nome "Lista" mantido por convencao do pipeline; neste form REPORT a
    *   Page1 hospeda os FILTROS (nao ha grid de registros - frmrelatorio FLAT).
    *   Coordenadas: top_original - 85 (PageFrame.Top=85 desloca a origem).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Controles da PARTE SUPERIOR (Data, Grupo, Produto, Linha) sao
        *-- criados em ConfigurarPaginaDados() - Fase 5.
        *-- Aqui (Fase 4 + extensoes) configuramos a PARTE INFERIOR:
        *-- Fornecedor + Diferencas Minimas (Venda/Custo).

        *-- lbl_4c_Lbl_fornecedor "Fornecedor :" (lbl_fornecedor: top=198, left=187)
        loc_oPg.AddObject("lbl_4c_Lbl_fornecedor", "Label")
        WITH loc_oPg.lbl_4c_Lbl_fornecedor
            .Top       = 113
            .Left      = 187
            .Width     = 64
            .Height    = 15
            .Caption   = "Fornecedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Fornecedor (getFornecedor: top=195, left=255, width=80)
        loc_oPg.AddObject("txt_4c_Fornecedor", "TextBox")
        WITH loc_oPg.txt_4c_Fornecedor
            .Top      = 110
            .Left     = 255
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH

        *-- txt_4c_DFornecedor (getDFornecedor: top=195, left=337, width=290)
        loc_oPg.AddObject("txt_4c_DFornecedor", "TextBox")
        WITH loc_oPg.txt_4c_DFornecedor
            .Top      = 110
            .Left     = 337
            .Width    = 290
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Value    = ""
            .Visible  = .T.
        ENDWITH

        *-- lbl_4c_Label5 " Diferenca Minima " (Say5: top=226, left=187)
        loc_oPg.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg.lbl_4c_Label5
            .Top       = 141
            .Left      = 187
            .Width     = 106
            .Height    = 15
            .Caption   = " Diferen" + CHR(231) + "a M" + CHR(237) + "nima "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- shp_4c_Shape1 - linha separadora (Shape1: top=242, left=177, w=450, h=2)
        loc_oPg.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPg.shp_4c_Shape1
            .Top         = 157
            .Left        = 177
            .Width       = 450
            .Height      = 2
            .BackStyle   = 1
            .BackColor   = RGB(200, 200, 200)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- lbl_4c_Label4 "Venda :" (Say4: top=252, left=212)
        loc_oPg.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg.lbl_4c_Label4
            .Top       = 167
            .Left      = 212
            .Width     = 39
            .Height    = 15
            .Caption   = "Venda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_MinVendas (getMinVendas: top=249, left=255, width=52)
        loc_oPg.AddObject("txt_4c_MinVendas", "TextBox")
        WITH loc_oPg.txt_4c_MinVendas
            .Top       = 164
            .Left      = 255
            .Width     = 52
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
            .InputMask = "99.99"
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label6 "%" (Say6: top=253, left=310)
        loc_oPg.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg.lbl_4c_Label6
            .Top       = 168
            .Left      = 310
            .Width     = 13
            .Height    = 15
            .Caption   = "%"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label7 "Custo :" (Say7: top=252, left=351)
        loc_oPg.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg.lbl_4c_Label7
            .Top       = 167
            .Left      = 351
            .Width     = 37
            .Height    = 15
            .Caption   = "Custo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_MinCustos (getMinCustos: top=249, left=391, width=52)
        loc_oPg.AddObject("txt_4c_MinCustos", "TextBox")
        WITH loc_oPg.txt_4c_MinCustos
            .Top       = 164
            .Left      = 391
            .Width     = 52
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
            .InputMask = "99.99"
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label8 "%" (Say8: top=253, left=446)
        loc_oPg.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPg.lbl_4c_Label8
            .Top       = 168
            .Left      = 446
            .Width     = 13
            .Height    = 15
            .Caption   = "%"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs para campos com lookup (F4/F5 e Enter/Tab)
        BINDEVENT(loc_oPg.txt_4c_Grupo,       "KeyPress", THIS, "TeclaGrupo")
        BINDEVENT(loc_oPg.txt_4c_DGrupo,      "KeyPress", THIS, "TeclaDGrupo")
        BINDEVENT(loc_oPg.txt_4c_CPros,        "KeyPress", THIS, "TeclaCPros")
        BINDEVENT(loc_oPg.txt_4c_DPros,        "KeyPress", THIS, "TeclaDPros")
        BINDEVENT(loc_oPg.txt_4c_Lin,          "KeyPress", THIS, "TeclaLin")
        BINDEVENT(loc_oPg.txt_4c_DLin,         "KeyPress", THIS, "TeclaDLin")
        BINDEVENT(loc_oPg.txt_4c_Fornecedor,   "KeyPress", THIS, "TeclaFornecedor")
        BINDEVENT(loc_oPg.txt_4c_DFornecedor,  "KeyPress", THIS, "TeclaDFornecedor")

        *-- BINDEVENT para CommandGroup de botoes do relatorio
        BINDEVENT(THIS.cmg_4c_Botoes, "Click", THIS, "CmgBotoesClick")

        *-- DblClick abre lookup diretamente (complementa o F4 do KeyPress)
        BINDEVENT(loc_oPg.txt_4c_Grupo,       "DblClick", THIS, "DblClickGrupo")
        BINDEVENT(loc_oPg.txt_4c_DGrupo,      "DblClick", THIS, "DblClickGrupo")
        BINDEVENT(loc_oPg.txt_4c_CPros,       "DblClick", THIS, "DblClickProduto")
        BINDEVENT(loc_oPg.txt_4c_DPros,       "DblClick", THIS, "DblClickProduto")
        BINDEVENT(loc_oPg.txt_4c_Lin,         "DblClick", THIS, "DblClickLinha")
        BINDEVENT(loc_oPg.txt_4c_DLin,        "DblClick", THIS, "DblClickLinha")
        BINDEVENT(loc_oPg.txt_4c_Fornecedor,  "DblClick", THIS, "DblClickFornecedor")
        BINDEVENT(loc_oPg.txt_4c_DFornecedor, "DblClick", THIS, "DblClickFornecedor")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Exibe a pagina informada no PageFrame de filtros
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF par_nPagina > 0 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ELSE
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Redefine todos os filtros para valores iniciais do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.txt_4c_DtInicial.Value      = DATE()
        loc_oPg.txt_4c_Grupo.Value          = ""
        loc_oPg.txt_4c_DGrupo.Value         = ""
        loc_oPg.txt_4c_DGrupo.ReadOnly      = .F.
        loc_oPg.txt_4c_CPros.Value           = ""
        loc_oPg.txt_4c_DPros.Value           = ""
        loc_oPg.txt_4c_DPros.ReadOnly        = .F.
        loc_oPg.txt_4c_Lin.Value             = ""
        loc_oPg.txt_4c_DLin.Value            = ""
        loc_oPg.txt_4c_DLin.ReadOnly         = .F.
        loc_oPg.txt_4c_Fornecedor.Value      = ""
        loc_oPg.txt_4c_DFornecedor.Value     = ""
        loc_oPg.txt_4c_DFornecedor.ReadOnly  = .F.
        loc_oPg.txt_4c_MinVendas.Value       = 0
        loc_oPg.txt_4c_MinCustos.Value       = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Sincroniza ReadOnly dos campos de descricao
    *   Descricao fica somente-leitura quando o codigo correspondente esta
    *   preenchido (replica comportamento When do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_oPg.txt_4c_DGrupo.ReadOnly      = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
        loc_oPg.txt_4c_DPros.ReadOnly       = !EMPTY(ALLTRIM(loc_oPg.txt_4c_CPros.Value))
        loc_oPg.txt_4c_DLin.ReadOnly        = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Lin.Value))
        loc_oPg.txt_4c_DFornecedor.ReadOnly = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Fornecedor.Value))
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCampos - Verifica campos obrigatorios antes de gerar relatorio
    *   Data Inicial e o unico campo obrigatorio (igual ao legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        IF EMPTY(loc_oPg.txt_4c_DtInicial.Value)
            MsgAviso("Data Inicial " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_DtInicial.SetFocus()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            .this_dDtInicial   = loc_oPg.txt_4c_DtInicial.Value
            .this_cGrupo       = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
            .this_cDGrupo      = ALLTRIM(loc_oPg.txt_4c_DGrupo.Value)
            .this_cCPros       = ALLTRIM(loc_oPg.txt_4c_CPros.Value)
            .this_cDPros       = ALLTRIM(loc_oPg.txt_4c_DPros.Value)
            .this_cLin         = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
            .this_cDLin        = ALLTRIM(loc_oPg.txt_4c_DLin.Value)
            .this_cFornecedor  = ALLTRIM(loc_oPg.txt_4c_Fornecedor.Value)
            .this_cDFornecedor = ALLTRIM(loc_oPg.txt_4c_DFornecedor.Value)
            .this_nMinVendas   = loc_oPg.txt_4c_MinVendas.Value
            .this_nMinCustos   = loc_oPg.txt_4c_MinCustos.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgBotoesClick - Roteia clique nos botoes do relatorio
    *   Buttons: 1=Visualizar, 2=Imprimir, 3=Excel, 4=Encerrar
    *--------------------------------------------------------------------------
    PROCEDURE CmgBotoesClick()
        DO CASE
            CASE THIS.cmg_4c_Botoes.Value = 1
                THIS.BtnVisualizarClick()
            CASE THIS.cmg_4c_Botoes.Value = 2
                THIS.BtnImprimirClick()
            CASE THIS.cmg_4c_Botoes.Value = 3
                THIS.BtnExcelClick()
            CASE THIS.cmg_4c_Botoes.Value = 4
                THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Gera preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnVisualizarClick()
        IF !THIS.ValidarCampos()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                     "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnImprimirClick()
        IF !THIS.ValidarCampos()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                     "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para planilha Excel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnExcelClick()
        IF !THIS.ValidarCampos()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.ExportarExcel()
            MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                     "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - REPORT form: operacao CRUD nao se aplica
    *   Este formulario eh do tipo frmrelatorio (apenas filtros + saida em FRX),
    *   nao possui registros para incluir. Mantido por convencao da pipeline
    *   multi-fase de migracao para preservar simetria com forms CRUD. Se for
    *   invocado programaticamente, redireciona para a acao mais proxima
    *   (Visualizar) para que o usuario obtenha o resultado esperado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - REPORT form: operacao CRUD nao se aplica
    *   Mantido por convencao da pipeline. Redireciona para Imprimir.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        MsgInfo("Este formul" + CHR(225) + "rio " + CHR(233) + " de relat" + CHR(243) + "rio." + CHR(13) + ;
                "Use Visualizar, Imprimir ou Excel para gerar o resultado.", ;
                "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - REPORT form: operacao CRUD nao se aplica
    *   Mantido por convencao da pipeline. Encerra o formulario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        MsgInfo("Este formul" + CHR(225) + "rio " + CHR(233) + " de relat" + CHR(243) + "rio." + CHR(13) + ;
                "Use Visualizar, Imprimir ou Excel para gerar o resultado.", ;
                "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGrupo - F4/F5 abre busca de grupos; Enter/Tab valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupo(par_nKeyCode, par_nShift)
        LOCAL loc_cCod
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaGrupo()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
            IF !EMPTY(loc_cCod)
                THIS.ValidarGrupo(loc_cCod)
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value   = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.ReadOnly = .F.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDGrupo - F4/F5 abre busca de grupos; Enter/Tab abre lista filtrada
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDGrupo(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaGrupo()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value))
                THIS.AbrirBuscaGrupo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida codigo digitado contra SigCdGrp; abre busca se invalido
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarGrupo(par_cCodigo)
        LOCAL loc_oPg, loc_cSQL, loc_nResult
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
                   EscaparSQL(par_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GrupoVal
            IF !EOF()
                loc_oPg.txt_4c_DGrupo.Value   = ALLTRIM(DGrus)
                loc_oPg.txt_4c_DGrupo.ReadOnly = .T.
            ELSE
                USE IN cursor_4c_GrupoVal
                THIS.AbrirBuscaGrupo()
                RETURN
            ENDIF
            USE IN cursor_4c_GrupoVal
        ELSE
            MsgAviso("Erro ao buscar grupo", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para SigCdGrp (CGrus/DGrus)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DGrupo.Value)
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdGrp", "cursor_4c_GrupoBusca", "CGrus", loc_cValor, ;
                    "Selecionar Grupo")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
        loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oForm.Show()

        IF loc_oForm.this_lSelecionou
            IF USED("cursor_4c_GrupoBusca")
                SELECT cursor_4c_GrupoBusca
                loc_oPg.txt_4c_Grupo.Value  = ALLTRIM(CGrus)
                loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(DGrus)
            ENDIF
        ENDIF

        IF USED("cursor_4c_GrupoBusca")
            USE IN cursor_4c_GrupoBusca
        ENDIF
        loc_oForm.Release()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCPros - F4/F5 abre busca de produtos; Enter/Tab valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCPros(par_nKeyCode, par_nShift)
        LOCAL loc_cCod
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaProduto()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CPros.Value)
            IF !EMPTY(loc_cCod)
                THIS.ValidarProduto(loc_cCod)
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_DPros.Value   = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DPros.ReadOnly = .F.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDPros - F4/F5 abre busca de produtos; Enter/Tab abre lista filtrada
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDPros(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaProduto()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DPros.Value))
                THIS.AbrirBuscaProduto()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarProduto - Valida codigo digitado contra SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarProduto(par_cCodigo)
        LOCAL loc_oPg, loc_cSQL, loc_nResult
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + ;
                   EscaparSQL(par_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ProdVal
            IF !EOF()
                loc_oPg.txt_4c_DPros.Value   = ALLTRIM(DPros)
                loc_oPg.txt_4c_DPros.ReadOnly = .T.
            ELSE
                USE IN cursor_4c_ProdVal
                THIS.AbrirBuscaProduto()
                RETURN
            ENDIF
            USE IN cursor_4c_ProdVal
        ELSE
            MsgAviso("Erro ao buscar produto", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaProduto - Abre FormBuscaAuxiliar para SigCdPro (CPros/DPros)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaProduto()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CPros.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DPros.Value)
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", "cursor_4c_ProdBusca", "CPros", loc_cValor, ;
                    "Selecionar Produto")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
        loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oForm.Show()

        IF loc_oForm.this_lSelecionou
            IF USED("cursor_4c_ProdBusca")
                SELECT cursor_4c_ProdBusca
                loc_oPg.txt_4c_CPros.Value   = ALLTRIM(CPros)
                loc_oPg.txt_4c_DPros.Value   = ALLTRIM(DPros)
            ENDIF
        ENDIF

        IF USED("cursor_4c_ProdBusca")
            USE IN cursor_4c_ProdBusca
        ENDIF
        loc_oForm.Release()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaLin - F4/F5 abre busca de linhas; Enter/Tab valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE TeclaLin(par_nKeyCode, par_nShift)
        LOCAL loc_cCod
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaLinha()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Lin.Value)
            IF !EMPTY(loc_cCod)
                THIS.ValidarLinha(loc_cCod)
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_DLin.Value   = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DLin.ReadOnly = .F.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDLin - F4/F5 abre busca de linhas; Enter/Tab abre lista filtrada
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDLin(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaLinha()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DLin.Value))
                THIS.AbrirBuscaLinha()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLinha - Valida codigo digitado contra SigCdLin (Linhas/Descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarLinha(par_cCodigo)
        LOCAL loc_oPg, loc_cSQL, loc_nResult
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_cSQL = "SELECT Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
                   EscaparSQL(par_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinVal")
        IF loc_nResult > 0
            SELECT cursor_4c_LinVal
            IF !EOF()
                loc_oPg.txt_4c_DLin.Value   = ALLTRIM(Descs)
                loc_oPg.txt_4c_DLin.ReadOnly = .T.
            ELSE
                USE IN cursor_4c_LinVal
                THIS.AbrirBuscaLinha()
                RETURN
            ENDIF
            USE IN cursor_4c_LinVal
        ELSE
            MsgAviso("Erro ao buscar linha", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaLinha - Abre FormBuscaAuxiliar para SigCdLin (Linhas/Descs)
    *   Colunas Linhas/Descs conforme codigo fonte original (fwBuscaExt)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaLinha()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DLin.Value)
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdLin", "cursor_4c_LinBusca", "Linhas", loc_cValor, ;
                    "Selecionar Linha")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        loc_oForm.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
        loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oForm.Show()

        IF loc_oForm.this_lSelecionou
            IF USED("cursor_4c_LinBusca")
                SELECT cursor_4c_LinBusca
                loc_oPg.txt_4c_Lin.Value  = ALLTRIM(Linhas)
                loc_oPg.txt_4c_DLin.Value = ALLTRIM(Descs)
            ENDIF
        ENDIF

        IF USED("cursor_4c_LinBusca")
            USE IN cursor_4c_LinBusca
        ENDIF
        loc_oForm.Release()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaFornecedor - F4/F5 abre busca de fornecedor; Enter/Tab valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE TeclaFornecedor(par_nKeyCode, par_nShift)
        LOCAL loc_cCod
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaFornecedor()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cCod = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Fornecedor.Value)
            IF !EMPTY(loc_cCod)
                THIS.ValidarFornecedor(loc_cCod)
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_DFornecedor.Value   = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DFornecedor.ReadOnly = .F.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDFornecedor - F4/F5 abre busca de fornecedor; Enter/Tab abre lista
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDFornecedor(par_nKeyCode, par_nShift)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaFornecedor()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            IF !EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DFornecedor.Value))
                THIS.AbrirBuscaFornecedor()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFornecedor - Valida codigo digitado contra SIGCDCLI (iclis/nomes)
    *   Substitui fAcessoContas() do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFornecedor(par_cCodigo)
        LOCAL loc_oPg, loc_cSQL, loc_nResult
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_cSQL = "SELECT iclis, nomes FROM SIGCDCLI WHERE iclis = " + ;
                   EscaparSQL(par_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FornVal")
        IF loc_nResult > 0
            SELECT cursor_4c_FornVal
            IF !EOF()
                loc_oPg.txt_4c_DFornecedor.Value   = ALLTRIM(nomes)
                loc_oPg.txt_4c_DFornecedor.ReadOnly = .T.
            ELSE
                USE IN cursor_4c_FornVal
                THIS.AbrirBuscaFornecedor()
                RETURN
            ENDIF
            USE IN cursor_4c_FornVal
        ELSE
            MsgAviso("Erro ao buscar fornecedor", "Aviso")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaFornecedor - Abre FormBuscaAuxiliar para SIGCDCLI (iclis/nomes)
    *   Substitui fAcessoContas() do legado (tabela SIGCDCLI = clientes/fornec)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaFornecedor()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Fornecedor.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DFornecedor.Value)
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SIGCDCLI", "cursor_4c_FornBusca", "iclis", loc_cValor, ;
                    "Selecionar Fornecedor")

        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
        loc_oForm.mAddColuna("nomes", "", "Nome")
        loc_oForm.Show()

        IF loc_oForm.this_lSelecionou
            IF USED("cursor_4c_FornBusca")
                SELECT cursor_4c_FornBusca
                loc_oPg.txt_4c_Fornecedor.Value   = ALLTRIM(iclis)
                loc_oPg.txt_4c_DFornecedor.Value  = ALLTRIM(nomes)
            ENDIF
        ENDIF

        IF USED("cursor_4c_FornBusca")
            USE IN cursor_4c_FornBusca
        ENDIF
        loc_oForm.Release()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * DblClickXxx - Handlers para duplo-clique nos campos de lookup
    *   BINDEVENT registrado em ConfigurarPaginaLista()
    *--------------------------------------------------------------------------
    PROCEDURE DblClickGrupo()
        THIS.AbrirBuscaGrupo()
    ENDPROC

    PROCEDURE DblClickProduto()
        THIS.AbrirBuscaProduto()
    ENDPROC

    PROCEDURE DblClickLinha()
        THIS.AbrirBuscaLinha()
    ENDPROC

    PROCEDURE DblClickFornecedor()
        THIS.AbrirBuscaFornecedor()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - REPORT form: Buscar equivale a Visualizar (preview)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - REPORT form: Salvar equivale a Imprimir
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - REPORT form: Cancelar retorna para pagina de filtros (Page1)
    *   NAO fecha o form; BtnEncerrarClick e quem fecha.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.pgf_4c_Paginas.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Delega para FormParaRelatorio (padrao REPORT)
    *   Mantido para compatibilidade com FormBase; a logica real esta em
    *   FormParaRelatorio() que ja e chamada pelos botoes de acao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega filtros do BO de volta para os controles do form
    *   Util para restaurar o estado dos filtros apos uma geracao de relatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            IF VARTYPE(.this_dDtInicial) = "D" AND !EMPTY(.this_dDtInicial)
                loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
            ENDIF
            loc_oPg.txt_4c_Grupo.Value         = .this_cGrupo
            loc_oPg.txt_4c_DGrupo.Value        = .this_cDGrupo
            loc_oPg.txt_4c_CPros.Value          = .this_cCPros
            loc_oPg.txt_4c_DPros.Value          = .this_cDPros
            loc_oPg.txt_4c_Lin.Value            = .this_cLin
            loc_oPg.txt_4c_DLin.Value           = .this_cDLin
            loc_oPg.txt_4c_Fornecedor.Value     = .this_cFornecedor
            loc_oPg.txt_4c_DFornecedor.Value    = .this_cDFornecedor
            loc_oPg.txt_4c_MinVendas.Value      = .this_nMinVendas
            loc_oPg.txt_4c_MinCustos.Value      = .this_nMinCustos
        ENDWITH

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Garante que todos os campos de filtro estao editaveis
    *   Em forms REPORT, todos os filtros permanecem sempre habilitados.
    *   par_lHabilitar reservado para compatibilidade com a assinatura FormBase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.txt_4c_DtInicial.Enabled  = .T.
        loc_oPg.txt_4c_Grupo.Enabled      = .T.
        loc_oPg.txt_4c_CPros.Enabled      = .T.
        loc_oPg.txt_4c_Lin.Enabled        = .T.
        loc_oPg.txt_4c_Fornecedor.Enabled = .T.
        loc_oPg.txt_4c_MinVendas.Enabled  = .T.
        loc_oPg.txt_4c_MinCustos.Enabled  = .T.

        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - REPORT form: nao ha grid de registros para popular
    *   Retorna .T. para compatibilidade com FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - REPORT form: botoes sempre habilitados
    *   Em forms CRUD, ajusta habilitacao conforme modo (LISTA/DADOS/VISUALIZAR).
    *   Em forms REPORT, Visualizar/Imprimir/Excel/Encerrar ficam sempre ativos.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

ENDDEFINE
