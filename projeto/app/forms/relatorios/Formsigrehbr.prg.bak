*==============================================================================
* FORMSIGREHBR.PRG
* Relatorio Codigos de Barras Por Estoque
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREHBR.SCX (frmrelatorio)
*
* Filtros:
*   - Periodo            (data inicial / data final)
*   - Grupo de Estoque   (cod+desc - fAcessoContab -> SigCdGpr?)
*   - Conta de Estoque   (cod+desc - fAcessoContas)
*   - Fornecedor         (cod+desc - fAcessoContas -> crSigCdPam.GrPadFors)
*   - Empresa            (cod+desc - fAcessoEmpresa -> SigCdEmp)
*   - Grande Grupo       (cod+desc - SigCdGpr.Codigos/Descs)
*   - Grupo de Produto   (cod+desc - SigCdGrp.CGrus/DGrus)
*   - Subgrupo de Prod.  (cod+desc - SigCdPsg.Codigos/Descricaos)
*   - Produto            (cod+desc - SigCdPro.cpros/dpros)
*   - Codigo de Barras   (SigOpEtq.cbars - busca via SQLEXEC)
*   - Cod. Reduzido      (Left(CodAmss, 3))
*   - Impressao          (Check3=Duracao, Check4=Imagem, Check1=Venda,
*                         Check2=Custo, Check5=Analitico)
*
* Acoes: Visualizar (preview) / Imprimir (com dialogo) / Documento / Encerrar
*==============================================================================

DEFINE CLASS Formsigrehbr AS FormBase

    *-- Dimensoes EXATAS do original (layout.json: Width=800, Height=650)
    Height      = 650
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

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura completa do formulario de relatorio:
    *   1. Define Caption / Picture (fundo)
    *   2. Cria sigrehbrBO e define valores padrao do periodo
    *   3. Monta cabecalho escuro + CommandGroup botoes + PageFrame filtros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "C" + CHR(243) + "digos de Barras Por Estoque"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("sigrehbrBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrehbrBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.LimparCampos()

                THIS.Visible   = .T.
                loc_lSucesso   = .T.
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
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   BackColor=RGB(100,100,100) cinza medio opaco (NAO escuro).
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
                .Caption   = "C" + CHR(243) + "digos de Barras Por Estoque"
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
                .Caption   = "C" + CHR(243) + "digos de Barras Por Estoque"
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
    * ConfigurarBotoes - CommandGroup btnReport (padrao frmrelatorio framework)
    *   Geometria EXATA: Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *   Lefts: Visualizar(5), Imprimir(71), Documento(137), Encerrar(203)
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
                .Caption         = "Documento"
                .WordWrap        = .T.
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
                .ToolTipText     = "Gerar Documento do Relat" + CHR(243) + "rio Sem Di" + ;
                                   CHR(225) + "logo"
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
    * ConfigurarPageFrame - PageFrame com 1 pagina de filtros
    *   Posicionado abaixo do cabecalho (85px).
    *   Os controles de filtro serao adicionados nas Fases 4-6.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1

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

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao.
    *   Sempre reseta propriedades do BO. Acessa controles via PEMSTATUS
    *   para compatibilidade com fases parciais (controles adicionados nas
    *   Fases 4-6).
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_oErro
        TRY
            *-- Inicializa propriedades do BO com valores padrao
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.this_dDtInicial   = DATE()
                THIS.this_oRelatorio.this_dDtFinal     = DATE()
                THIS.this_oRelatorio.this_cCdGrEstoque = ""
                THIS.this_oRelatorio.this_cDsGrEstoque = ""
                THIS.this_oRelatorio.this_cCdEstoque   = ""
                THIS.this_oRelatorio.this_cDsEstoque   = ""
                THIS.this_oRelatorio.this_cIFors       = ""
                THIS.this_oRelatorio.this_cDFors       = ""
                THIS.this_oRelatorio.this_cCdEmpresa   = ""
                THIS.this_oRelatorio.this_cDsEmpresa   = ""
                THIS.this_oRelatorio.this_cCGgps       = ""
                THIS.this_oRelatorio.this_cDGgps       = ""
                THIS.this_oRelatorio.this_cCdGPro      = ""
                THIS.this_oRelatorio.this_cDsGPro      = ""
                THIS.this_oRelatorio.this_cCdSgrupo    = ""
                THIS.this_oRelatorio.this_cDsSgrupo    = ""
                THIS.this_oRelatorio.this_cCdCodigo    = ""
                THIS.this_oRelatorio.this_cDsCodigo    = ""
                THIS.this_oRelatorio.this_cCBars       = ""
                THIS.this_oRelatorio.this_cReduzs      = ""
                THIS.this_oRelatorio.this_nCheck1      = 0
                THIS.this_oRelatorio.this_nCheck2      = 0
                THIS.this_oRelatorio.this_nCheck3      = 0
                THIS.this_oRelatorio.this_nCheck4      = 0
                THIS.this_oRelatorio.this_nCheck5      = 0
            ENDIF

            *-- Sincroniza controles via PEMSTATUS (seguro em fase parcial)
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page1

                IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                    loc_oPg.txt_4c_DtInicial.Value = DATE()
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                    loc_oPg.txt_4c_DtFinal.Value = DATE()
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdGrEstoque", 5)
                    loc_oPg.txt_4c_CdGrEstoque.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsGrEstoque", 5)
                    loc_oPg.txt_4c_DsGrEstoque.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdEstoque", 5)
                    loc_oPg.txt_4c_CdEstoque.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsEstoque", 5)
                    loc_oPg.txt_4c_DsEstoque.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_IFors", 5)
                    loc_oPg.txt_4c_IFors.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DFors", 5)
                    loc_oPg.txt_4c_DFors.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdEmpresa", 5)
                    loc_oPg.txt_4c_CdEmpresa.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsEmpresa", 5)
                    loc_oPg.txt_4c_DsEmpresa.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CGgps", 5)
                    loc_oPg.txt_4c_CGgps.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DGgps", 5)
                    loc_oPg.txt_4c_DGgps.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdGPro", 5)
                    loc_oPg.txt_4c_CdGPro.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsGPro", 5)
                    loc_oPg.txt_4c_DsGPro.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdSgrupo", 5)
                    loc_oPg.txt_4c_CdSgrupo.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsSgrupo", 5)
                    loc_oPg.txt_4c_DsSgrupo.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdCodigo", 5)
                    loc_oPg.txt_4c_CdCodigo.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsCodigo", 5)
                    loc_oPg.txt_4c_DsCodigo.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CBars", 5)
                    loc_oPg.txt_4c_CBars.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Reduzs", 5)
                    loc_oPg.txt_4c_Reduzs.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check1", 5)
                    loc_oPg.chk_4c_Check1.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check2", 5)
                    loc_oPg.chk_4c_Check2.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check3", 5)
                    loc_oPg.chk_4c_Check3.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check4", 5)
                    loc_oPg.chk_4c_Check4.Value = 0
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check5", 5)
                    loc_oPg.chk_4c_Check5.Value = 0
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO.
    *   Usa PEMSTATUS para compatibilidade com fases parciais.
    *   Equivalente ao bloco 'processamento' do form legado SIGREHBR.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                    .this_dDtInicial = loc_oPg.txt_4c_DtInicial.Value
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                    .this_dDtFinal = loc_oPg.txt_4c_DtFinal.Value
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdGrEstoque", 5)
                    .this_cCdGrEstoque = ALLTRIM(loc_oPg.txt_4c_CdGrEstoque.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsGrEstoque", 5)
                    .this_cDsGrEstoque = ALLTRIM(loc_oPg.txt_4c_DsGrEstoque.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdEstoque", 5)
                    .this_cCdEstoque = ALLTRIM(loc_oPg.txt_4c_CdEstoque.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsEstoque", 5)
                    .this_cDsEstoque = ALLTRIM(loc_oPg.txt_4c_DsEstoque.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_IFors", 5)
                    .this_cIFors = ALLTRIM(loc_oPg.txt_4c_IFors.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DFors", 5)
                    .this_cDFors = ALLTRIM(loc_oPg.txt_4c_DFors.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdEmpresa", 5)
                    .this_cCdEmpresa = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsEmpresa", 5)
                    .this_cDsEmpresa = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CGgps", 5)
                    .this_cCGgps = ALLTRIM(loc_oPg.txt_4c_CGgps.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DGgps", 5)
                    .this_cDGgps = ALLTRIM(loc_oPg.txt_4c_DGgps.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdGPro", 5)
                    .this_cCdGPro = ALLTRIM(loc_oPg.txt_4c_CdGPro.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsGPro", 5)
                    .this_cDsGPro = ALLTRIM(loc_oPg.txt_4c_DsGPro.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdSgrupo", 5)
                    .this_cCdSgrupo = ALLTRIM(loc_oPg.txt_4c_CdSgrupo.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsSgrupo", 5)
                    .this_cDsSgrupo = ALLTRIM(loc_oPg.txt_4c_DsSgrupo.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdCodigo", 5)
                    .this_cCdCodigo = ALLTRIM(loc_oPg.txt_4c_CdCodigo.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsCodigo", 5)
                    .this_cDsCodigo = ALLTRIM(loc_oPg.txt_4c_DsCodigo.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CBars", 5)
                    .this_cCBars = ALLTRIM(loc_oPg.txt_4c_CBars.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Reduzs", 5)
                    .this_cReduzs = ALLTRIM(loc_oPg.txt_4c_Reduzs.Value)
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check1", 5)
                    .this_nCheck1 = loc_oPg.chk_4c_Check1.Value
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check2", 5)
                    .this_nCheck2 = loc_oPg.chk_4c_Check2.Value
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check3", 5)
                    .this_nCheck3 = loc_oPg.chk_4c_Check3.Value
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check4", 5)
                    .this_nCheck4 = loc_oPg.chk_4c_Check4.Value
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check5", 5)
                    .this_nCheck5 = loc_oPg.chk_4c_Check5.Value
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica periodo valido.
    *   Demais filtros sao opcionais (equivalente ao original: sem validacao
    *   obrigatoria alem do periodo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg, loc_dIni, loc_dFim, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                loc_lResultado = .F.
            ENDIF
            loc_dIni = THIS.this_oRelatorio.this_dDtInicial
            loc_dFim = THIS.this_oRelatorio.this_dDtFinal

            IF EMPTY(loc_dIni)
                MsgAviso("Informe o per" + CHR(237) + "odo inicial.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    loc_oPg = THIS.pgf_4c_Paginas.Page1
                    IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                        loc_oPg.txt_4c_DtInicial.SetFocus()
                    ENDIF
                ENDIF
                loc_lResultado = .F.
            ENDIF

            IF EMPTY(loc_dFim)
                MsgAviso("Informe o per" + CHR(237) + "odo final.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    loc_oPg = THIS.pgf_4c_Paginas.Page1
                    IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                        loc_oPg.txt_4c_DtFinal.SetFocus()
                    ENDIF
                ENDIF
                loc_lResultado = .F.
            ENDIF

            IF loc_dIni > loc_dFim
                MsgAviso("Data Final Menor Que a Inicial!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                    loc_oPg = THIS.pgf_4c_Paginas.Page1
                    IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                        loc_oPg.txt_4c_DtFinal.SetFocus()
                    ENDIF
                ENDIF
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em preview na tela
    *   Equivalente ao PROCEDURE visualizacao do legado SIGREHBR.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF THIS.ValidarFiltros()
                IF !THIS.this_oRelatorio.Visualizar()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de selecao de impressora
    *   Equivalente ao PROCEDURE impressao do legado SIGREHBR.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF THIS.ValidarFiltros()
                IF !THIS.this_oRelatorio.Imprimir()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Envia relatorio direto para impressora sem dialogo
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF THIS.ValidarFiltros()
                IF !THIS.this_oRelatorio.ImprimirDireto()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT
    * Aliases para compatibilidade com pipeline que espera metodos CRUD.
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        LOCAL loc_oPg, loc_oErro
        TRY
            THIS.LimparCampos()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page1
                IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                    loc_oPg.txt_4c_DtInicial.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Sincroniza ReadOnly dos campos de descricao.
    *   Campos de descricao ficam ReadOnly quando o codigo correspondente
    *   esta preenchido (simulando o When original do fwget).
    *   Usa PEMSTATUS - seguro nas fases parciais.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        LOCAL loc_oPg, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            IF PEMSTATUS(loc_oPg, "txt_4c_DsGrEstoque", 5) AND ;
               PEMSTATUS(loc_oPg, "txt_4c_CdGrEstoque", 5)
                loc_oPg.txt_4c_DsGrEstoque.ReadOnly = ;
                    !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdGrEstoque.Value))
            ENDIF

            IF PEMSTATUS(loc_oPg, "txt_4c_DsEstoque", 5) AND ;
               PEMSTATUS(loc_oPg, "txt_4c_CdEstoque", 5)
                loc_oPg.txt_4c_DsEstoque.ReadOnly = ;
                    !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdEstoque.Value))
            ENDIF

            IF PEMSTATUS(loc_oPg, "txt_4c_DFors", 5) AND ;
               PEMSTATUS(loc_oPg, "txt_4c_IFors", 5)
                loc_oPg.txt_4c_DFors.ReadOnly = ;
                    !EMPTY(ALLTRIM(loc_oPg.txt_4c_IFors.Value))
            ENDIF

            IF PEMSTATUS(loc_oPg, "txt_4c_DsEmpresa", 5) AND ;
               PEMSTATUS(loc_oPg, "txt_4c_CdEmpresa", 5)
                loc_oPg.txt_4c_DsEmpresa.ReadOnly = ;
                    !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value))
            ENDIF

            IF PEMSTATUS(loc_oPg, "txt_4c_DGgps", 5) AND ;
               PEMSTATUS(loc_oPg, "txt_4c_CGgps", 5)
                loc_oPg.txt_4c_DGgps.ReadOnly = ;
                    !EMPTY(ALLTRIM(loc_oPg.txt_4c_CGgps.Value))
            ENDIF

            IF PEMSTATUS(loc_oPg, "txt_4c_DsGPro", 5) AND ;
               PEMSTATUS(loc_oPg, "txt_4c_CdGPro", 5)
                loc_oPg.txt_4c_DsGPro.ReadOnly = ;
                    !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdGPro.Value))
            ENDIF

            IF PEMSTATUS(loc_oPg, "txt_4c_DsSgrupo", 5) AND ;
               PEMSTATUS(loc_oPg, "txt_4c_CdSgrupo", 5)
                loc_oPg.txt_4c_DsSgrupo.ReadOnly = ;
                    !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdSgrupo.Value))
            ENDIF

            IF PEMSTATUS(loc_oPg, "txt_4c_DsCodigo", 5) AND ;
               PEMSTATUS(loc_oPg, "txt_4c_CdCodigo", 5)
                loc_oPg.txt_4c_DsCodigo.ReadOnly = ;
                    !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdCodigo.Value))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * METODOS PADRAO FormBase (compatibilidade com pipeline)
    *==========================================================================

    PROCEDURE CarregarLista()
        LOCAL loc_oPg, loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page1
                IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                    loc_oPg.txt_4c_DtInicial.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                    loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                    loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdGrEstoque", 5)
                    loc_oPg.txt_4c_CdGrEstoque.Value = .this_cCdGrEstoque
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsGrEstoque", 5)
                    loc_oPg.txt_4c_DsGrEstoque.Value = .this_cDsGrEstoque
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdEstoque", 5)
                    loc_oPg.txt_4c_CdEstoque.Value = .this_cCdEstoque
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsEstoque", 5)
                    loc_oPg.txt_4c_DsEstoque.Value = .this_cDsEstoque
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_IFors", 5)
                    loc_oPg.txt_4c_IFors.Value = .this_cIFors
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DFors", 5)
                    loc_oPg.txt_4c_DFors.Value = .this_cDFors
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdEmpresa", 5)
                    loc_oPg.txt_4c_CdEmpresa.Value = .this_cCdEmpresa
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsEmpresa", 5)
                    loc_oPg.txt_4c_DsEmpresa.Value = .this_cDsEmpresa
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CGgps", 5)
                    loc_oPg.txt_4c_CGgps.Value = .this_cCGgps
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DGgps", 5)
                    loc_oPg.txt_4c_DGgps.Value = .this_cDGgps
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdGPro", 5)
                    loc_oPg.txt_4c_CdGPro.Value = .this_cCdGPro
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsGPro", 5)
                    loc_oPg.txt_4c_DsGPro.Value = .this_cDsGPro
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdSgrupo", 5)
                    loc_oPg.txt_4c_CdSgrupo.Value = .this_cCdSgrupo
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsSgrupo", 5)
                    loc_oPg.txt_4c_DsSgrupo.Value = .this_cDsSgrupo
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdCodigo", 5)
                    loc_oPg.txt_4c_CdCodigo.Value = .this_cCdCodigo
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsCodigo", 5)
                    loc_oPg.txt_4c_DsCodigo.Value = .this_cDsCodigo
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CBars", 5)
                    loc_oPg.txt_4c_CBars.Value = .this_cCBars
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Reduzs", 5)
                    loc_oPg.txt_4c_Reduzs.Value = .this_cReduzs
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check1", 5)
                    loc_oPg.chk_4c_Check1.Value = .this_nCheck1
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check2", 5)
                    loc_oPg.chk_4c_Check2.Value = .this_nCheck2
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check3", 5)
                    loc_oPg.chk_4c_Check3.Value = .this_nCheck3
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check4", 5)
                    loc_oPg.chk_4c_Check4.Value = .this_nCheck4
                ENDIF
                IF PEMSTATUS(loc_oPg, "chk_4c_Check5", 5)
                    loc_oPg.chk_4c_Check5.Value = .this_nCheck5
                ENDIF
            ENDWITH
            THIS.AtualizarEstadoControles()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab, loc_oErro
        TRY
            IF PCOUNT() = 0
                loc_lHab = .T.
            ELSE
                loc_lHab = par_lHabilitar
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                loc_oPg.txt_4c_DtInicial.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                loc_oPg.txt_4c_DtFinal.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_CdGrEstoque", 5)
                loc_oPg.txt_4c_CdGrEstoque.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_CdEstoque", 5)
                loc_oPg.txt_4c_CdEstoque.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_IFors", 5)
                loc_oPg.txt_4c_IFors.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_CdEmpresa", 5)
                loc_oPg.txt_4c_CdEmpresa.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_CGgps", 5)
                loc_oPg.txt_4c_CGgps.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_CdGPro", 5)
                loc_oPg.txt_4c_CdGPro.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_CdSgrupo", 5)
                loc_oPg.txt_4c_CdSgrupo.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_CdCodigo", 5)
                loc_oPg.txt_4c_CdCodigo.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_CBars", 5)
                loc_oPg.txt_4c_CBars.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "txt_4c_Reduzs", 5)
                loc_oPg.txt_4c_Reduzs.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "chk_4c_Check1", 5)
                loc_oPg.chk_4c_Check1.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "chk_4c_Check2", 5)
                loc_oPg.chk_4c_Check2.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "chk_4c_Check3", 5)
                loc_oPg.chk_4c_Check3.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "chk_4c_Check4", 5)
                loc_oPg.chk_4c_Check4.Enabled = loc_lHab
            ENDIF
            IF PEMSTATUS(loc_oPg, "chk_4c_Check5", 5)
                loc_oPg.chk_4c_Check5.Enabled = loc_lHab
            ENDIF

            IF loc_lHab
                THIS.AtualizarEstadoControles()
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_DsGrEstoque", 5)
                    loc_oPg.txt_4c_DsGrEstoque.Enabled = .F.
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsEstoque", 5)
                    loc_oPg.txt_4c_DsEstoque.Enabled = .F.
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DFors", 5)
                    loc_oPg.txt_4c_DFors.Enabled = .F.
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsEmpresa", 5)
                    loc_oPg.txt_4c_DsEmpresa.Enabled = .F.
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DGgps", 5)
                    loc_oPg.txt_4c_DGgps.Enabled = .F.
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsGPro", 5)
                    loc_oPg.txt_4c_DsGPro.Enabled = .F.
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsSgrupo", 5)
                    loc_oPg.txt_4c_DsSgrupo.Enabled = .F.
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsCodigo", 5)
                    loc_oPg.txt_4c_DsCodigo.Enabled = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nDestino, loc_oPgf, loc_oPg, loc_oErro
        TRY
            loc_oPgf = THIS.pgf_4c_Paginas
            IF VARTYPE(loc_oPgf) != "O"
                RETURN
            ENDIF
            IF PCOUNT() = 0 OR VARTYPE(par_nPagina) != "N"
                loc_nDestino = 1
            ELSE
                loc_nDestino = INT(par_nPagina)
            ENDIF
            IF loc_nDestino < 1
                loc_nDestino = 1
            ENDIF
            IF loc_nDestino > loc_oPgf.PageCount
                loc_nDestino = loc_oPgf.PageCount
            ENDIF
            loc_oPgf.ActivePage = loc_nDestino
            loc_oPg = loc_oPgf.Pages(loc_nDestino)
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                loc_oPg.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINADADOS - Primeiros 50% dos filtros (Fase 5)
    * Em forms REPORT, "Page Dados" representa o bloco principal de parametros.
    * Aqui ficam os filtros de cabecalho: Periodo, Grupo de Estoque, Conta de
    * Estoque, Fornecedor, Empresa e Grande Grupo. Restante em ConfigurarPaginaLista.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- ===== PERIODO =====
        loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPg.lbl_4c_LblPeriodo
            .Top       = 24
            .Left      = 206
            .Width     = 45
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top         = 20
            .Left        = 256
            .Width       = 80
            .Height      = 25
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPg.lbl_4c_PeriodoA
            .Top       = 24
            .Left      = 341
            .Width     = 8
            .Height    = 15
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top         = 20
            .Left        = 353
            .Width       = 80
            .Height      = 25
            .Value       = {}
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- ===== GRUPO DE ESTOQUE =====
        loc_oPg.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPg.lbl_4c_LblGrupo
            .Top       = 53
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

        loc_oPg.AddObject("txt_4c_CdGrEstoque", "TextBox")
        WITH loc_oPg.txt_4c_CdGrEstoque
            .Top         = 48
            .Left        = 256
            .Width       = 80
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsGrEstoque", "TextBox")
        WITH loc_oPg.txt_4c_DsGrEstoque
            .Top         = 48
            .Left        = 339
            .Width       = 316
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- ===== CONTA DE ESTOQUE =====
        loc_oPg.AddObject("lbl_4c_LblConta", "Label")
        WITH loc_oPg.lbl_4c_LblConta
            .Top       = 81
            .Left      = 213
            .Width     = 38
            .Height    = 15
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH loc_oPg.txt_4c_CdEstoque
            .Top         = 76
            .Left        = 256
            .Width       = 80
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH loc_oPg.txt_4c_DsEstoque
            .Top         = 76
            .Left        = 339
            .Width       = 316
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- ===== FORNECEDOR =====
        loc_oPg.AddObject("lbl_4c_LblFornecedor", "Label")
        WITH loc_oPg.lbl_4c_LblFornecedor
            .Top       = 109
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

        loc_oPg.AddObject("txt_4c_IFors", "TextBox")
        WITH loc_oPg.txt_4c_IFors
            .Top         = 104
            .Left        = 256
            .Width       = 80
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DFors", "TextBox")
        WITH loc_oPg.txt_4c_DFors
            .Top         = 104
            .Left        = 339
            .Width       = 316
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- ===== EMPRESA =====
        loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oPg.lbl_4c_LblEmpresa
            .Top       = 137
            .Left      = 201
            .Width     = 50
            .Height    = 15
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_CdEmpresa
            .Top         = 132
            .Left        = 256
            .Width       = 31
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_DsEmpresa
            .Top         = 132
            .Left        = 290
            .Width       = 365
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- ===== GRANDE GRUPO =====
        loc_oPg.AddObject("lbl_4c_LblGGpro", "Label")
        WITH loc_oPg.lbl_4c_LblGGpro
            .Top       = 165
            .Left      = 175
            .Width     = 76
            .Height    = 15
            .Caption   = "Grande Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CGgps", "TextBox")
        WITH loc_oPg.txt_4c_CGgps
            .Top         = 160
            .Left        = 256
            .Width       = 31
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DGgps", "TextBox")
        WITH loc_oPg.txt_4c_DGgps
            .Top         = 160
            .Left        = 290
            .Width       = 365
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINALISTA - Campos de filtro em Page1 (segundo bloco)
    * Em forms REPORT, Page1 contem os parametros/filtros do relatorio.
    * Posicoes originais SIGREHBR (800x650px) menos offset de 136px do header.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Primeiros 50% dos filtros (Periodo, Grupo Estoque, Conta, Fornecedor, Empresa, Grande Grupo)
        THIS.ConfigurarPaginaDados()

        *-- ===== GRUPO DE PRODUTO =====
        loc_oPg.AddObject("lbl_4c_LblGPro", "Label")
        WITH loc_oPg.lbl_4c_LblGPro
            .Top       = 193
            .Left      = 157
            .Width     = 94
            .Height    = 15
            .Caption   = "Grupo de Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdGPro", "TextBox")
        WITH loc_oPg.txt_4c_CdGPro
            .Top         = 188
            .Left        = 256
            .Width       = 31
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsGPro", "TextBox")
        WITH loc_oPg.txt_4c_DsGPro
            .Top         = 188
            .Left        = 290
            .Width       = 365
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- ===== SUBGRUPO DE PRODUTO =====
        loc_oPg.AddObject("lbl_4c_LblSgrupo", "Label")
        WITH loc_oPg.lbl_4c_LblSgrupo
            .Top       = 221
            .Left      = 140
            .Width     = 111
            .Height    = 15
            .Caption   = "Subgrupo de Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdSgrupo", "TextBox")
        WITH loc_oPg.txt_4c_CdSgrupo
            .Top         = 216
            .Left        = 256
            .Width       = 52
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsSgrupo", "TextBox")
        WITH loc_oPg.txt_4c_DsSgrupo
            .Top         = 216
            .Left        = 311
            .Width       = 344
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- ===== PRODUTO =====
        loc_oPg.AddObject("lbl_4c_LblProduto", "Label")
        WITH loc_oPg.lbl_4c_LblProduto
            .Top       = 249
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

        loc_oPg.AddObject("txt_4c_CdCodigo", "TextBox")
        WITH loc_oPg.txt_4c_CdCodigo
            .Top         = 244
            .Left        = 256
            .Width       = 108
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsCodigo", "TextBox")
        WITH loc_oPg.txt_4c_DsCodigo
            .Top         = 244
            .Left        = 367
            .Width       = 288
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- ===== CODIGO DE BARRAS =====
        loc_oPg.AddObject("lbl_4c_LblBarra", "Label")
        WITH loc_oPg.lbl_4c_LblBarra
            .Top       = 277
            .Left      = 216
            .Width     = 35
            .Height    = 15
            .Caption   = "Barra :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CBars", "TextBox")
        WITH loc_oPg.txt_4c_CBars
            .Top         = 272
            .Left        = 256
            .Width       = 108
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- ===== CODIGO REDUZIDO =====
        loc_oPg.AddObject("lbl_4c_LblReduzido", "Label")
        WITH loc_oPg.lbl_4c_LblReduzido
            .Top       = 305
            .Left      = 162
            .Width     = 89
            .Height    = 15
            .Caption   = "C" + CHR(243) + "digo Reduzido :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Reduzs", "TextBox")
        WITH loc_oPg.txt_4c_Reduzs
            .Top         = 300
            .Left        = 256
            .Width       = 31
            .Height      = 25
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- ===== IMPRESSAO / CHECKBOXES =====
        loc_oPg.AddObject("lbl_4c_LblImpressao", "Label")
        WITH loc_oPg.lbl_4c_LblImpressao
            .Top       = 469
            .Left      = 192
            .Width     = 59
            .Height    = 15
            .Caption   = "Impress" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Check3", "CheckBox")
        WITH loc_oPg.chk_4c_Check3
            .Top       = 469
            .Left      = 257
            .Width     = 58
            .Height    = 15
            .Caption   = "Dura" + CHR(231) + CHR(227) + "o"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Check4", "CheckBox")
        WITH loc_oPg.chk_4c_Check4
            .Top       = 469
            .Left      = 340
            .Width     = 56
            .Height    = 15
            .Caption   = "Imagem"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Check2", "CheckBox")
        WITH loc_oPg.chk_4c_Check2
            .Top       = 469
            .Left      = 429
            .Width     = 46
            .Height    = 15
            .Caption   = "Custo"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Check1", "CheckBox")
        WITH loc_oPg.chk_4c_Check1
            .Top       = 469
            .Left      = 504
            .Width     = 48
            .Height    = 15
            .Caption   = "Venda"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Check5", "CheckBox")
        WITH loc_oPg.chk_4c_Check5
            .Top       = 469
            .Left      = 578
            .Width     = 58
            .Height    = 15
            .Caption   = "Anal" + CHR(237) + "tico"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs - campos de data (sem lookup, apenas validacao de periodo)
        BINDEVENT(loc_oPg.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
        BINDEVENT(loc_oPg.txt_4c_DtFinal,   "KeyPress", THIS, "TeclaDataFinal")

        *-- BINDEVENTs - Grupo de Estoque
        BINDEVENT(loc_oPg.txt_4c_CdGrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
        BINDEVENT(loc_oPg.txt_4c_CdGrEstoque, "DblClick", THIS, "AbrirBuscaCdGrEstoque")
        BINDEVENT(loc_oPg.txt_4c_DsGrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
        BINDEVENT(loc_oPg.txt_4c_DsGrEstoque, "DblClick", THIS, "AbrirBuscaDsGrEstoque")

        *-- BINDEVENTs - Conta de Estoque
        BINDEVENT(loc_oPg.txt_4c_CdEstoque, "KeyPress", THIS, "TeclaCdEstoque")
        BINDEVENT(loc_oPg.txt_4c_CdEstoque, "DblClick", THIS, "AbrirBuscaCdEstoque")
        BINDEVENT(loc_oPg.txt_4c_DsEstoque, "KeyPress", THIS, "TeclaDsEstoque")
        BINDEVENT(loc_oPg.txt_4c_DsEstoque, "DblClick", THIS, "AbrirBuscaDsEstoque")

        *-- BINDEVENTs - Fornecedor
        BINDEVENT(loc_oPg.txt_4c_IFors, "KeyPress", THIS, "TeclaIFors")
        BINDEVENT(loc_oPg.txt_4c_IFors, "DblClick", THIS, "AbrirBuscaIFors")
        BINDEVENT(loc_oPg.txt_4c_DFors, "KeyPress", THIS, "TeclaDFors")
        BINDEVENT(loc_oPg.txt_4c_DFors, "DblClick", THIS, "AbrirBuscaDFors")

        *-- BINDEVENTs - Empresa
        BINDEVENT(loc_oPg.txt_4c_CdEmpresa, "KeyPress", THIS, "TeclaCdEmpresa")
        BINDEVENT(loc_oPg.txt_4c_CdEmpresa, "DblClick", THIS, "AbrirBuscaCdEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DsEmpresa, "KeyPress", THIS, "TeclaDsEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DsEmpresa, "DblClick", THIS, "AbrirBuscaDsEmpresa")

        *-- BINDEVENTs - Grande Grupo
        BINDEVENT(loc_oPg.txt_4c_CGgps, "KeyPress", THIS, "TeclaCGgps")
        BINDEVENT(loc_oPg.txt_4c_CGgps, "DblClick", THIS, "AbrirBuscaCGgps")
        BINDEVENT(loc_oPg.txt_4c_DGgps, "KeyPress", THIS, "TeclaDGgps")
        BINDEVENT(loc_oPg.txt_4c_DGgps, "DblClick", THIS, "AbrirBuscaDGgps")

        *-- BINDEVENTs - Grupo de Produto
        BINDEVENT(loc_oPg.txt_4c_CdGPro, "KeyPress", THIS, "TeclaCdGPro")
        BINDEVENT(loc_oPg.txt_4c_CdGPro, "DblClick", THIS, "AbrirBuscaCdGPro")
        BINDEVENT(loc_oPg.txt_4c_DsGPro, "KeyPress", THIS, "TeclaDsGPro")
        BINDEVENT(loc_oPg.txt_4c_DsGPro, "DblClick", THIS, "AbrirBuscaDsGPro")

        *-- BINDEVENTs - Subgrupo
        BINDEVENT(loc_oPg.txt_4c_CdSgrupo, "KeyPress", THIS, "TeclaCdSgrupo")
        BINDEVENT(loc_oPg.txt_4c_CdSgrupo, "DblClick", THIS, "AbrirBuscaCdSgrupo")
        BINDEVENT(loc_oPg.txt_4c_DsSgrupo, "KeyPress", THIS, "TeclaDsSgrupo")
        BINDEVENT(loc_oPg.txt_4c_DsSgrupo, "DblClick", THIS, "AbrirBuscaDsSgrupo")

        *-- BINDEVENTs - Produto
        BINDEVENT(loc_oPg.txt_4c_CdCodigo, "KeyPress", THIS, "TeclaCdCodigo")
        BINDEVENT(loc_oPg.txt_4c_CdCodigo, "DblClick", THIS, "AbrirBuscaCdCodigo")
        BINDEVENT(loc_oPg.txt_4c_DsCodigo, "KeyPress", THIS, "TeclaDsCodigo")
        BINDEVENT(loc_oPg.txt_4c_DsCodigo, "DblClick", THIS, "AbrirBuscaDsCodigo")

        *-- BINDEVENTs - Codigo de Barras (validacao via SQLEXEC)
        BINDEVENT(loc_oPg.txt_4c_CBars, "KeyPress", THIS, "TeclaCBars")

        *-- BINDEVENTs - Check5 exclui Check3 (Analitico exclui Duracao)
        BINDEVENT(loc_oPg.chk_4c_Check5, "Click", THIS, "ChkCheck5Click")

        THIS.AtualizarEstadoControles()
    ENDPROC

    *==========================================================================
    * TECLA* - Handlers de KeyPress (BINDEVENT requer metodos PUBLIC)
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdGrEstoque.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdGrEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrEstoque()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsGrEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsGrEstoque()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEstoque()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEstoque()
        ENDIF
    ENDPROC

    PROCEDURE TeclaIFors(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaIFors()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarIFors()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDFors(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDFors()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDFors()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCGgps(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCGgps()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCGgps()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDGgps(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDGgps()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDGgps()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdGPro(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdGPro()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGPro()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsGPro(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsGPro()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsGPro()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdSgrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdSgrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdSgrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsSgrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsSgrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsSgrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdCodigo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdCodigo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsCodigo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsCodigo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCBars(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCBars()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - GRUPO DE ESTOQUE (SigCdGcr: codigos / descrs)
    *==========================================================================

    PROCEDURE AbrirBuscaCdGrEstoque()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdGrEstoque.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrEstoque", "codigos", loc_cValor, ;
            "Grupo de Estoque", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaGrEstoque")
                    loc_oPg.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEstoque.codigos)
                    loc_oPg.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEstoque.descrs)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEstoque")
                        loc_oPg.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEstoque.codigos)
                        loc_oPg.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEstoque.descrs)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGrEstoque")
            USE IN cursor_4c_BuscaGrEstoque
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE AbrirBuscaDsGrEstoque()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsGrEstoque.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrEstoque", "descrs", loc_cValor, ;
            "Grupo de Estoque", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaGrEstoque")
                    loc_oPg.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEstoque.descrs)
                    loc_oPg.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEstoque.codigos)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEstoque")
                        loc_oPg.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEstoque.descrs)
                        loc_oPg.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEstoque.codigos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGrEstoque")
            USE IN cursor_4c_BuscaGrEstoque
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarCdGrEstoque()
        LOCAL loc_cValor, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdGrEstoque.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsGrEstoque.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
            EscaparSQL(loc_cValor), "cursor_4c_GrEstVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GrEstVal
            IF !EOF()
                loc_oPg.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_GrEstVal.descrs)
            ELSE
                loc_oPg.txt_4c_DsGrEstoque.Value = ""
                THIS.AbrirBuscaCdGrEstoque()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DsGrEstoque.Value = ""
        ENDIF
        IF USED("cursor_4c_GrEstVal")
            USE IN cursor_4c_GrEstVal
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarDsGrEstoque()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsGrEstoque.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdGrEstoque.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        THIS.AbrirBuscaDsGrEstoque()
    ENDPROC

    *==========================================================================
    * LOOKUP - CONTA DE ESTOQUE (SigCdCli: iclis / rclis)
    * a.Contas = d.iclis (confirmado no SQL principal do legado)
    *==========================================================================

    PROCEDURE AbrirBuscaCdEstoque()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEstoque.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaEstoque", "iclis", loc_cValor, ;
            "Conta de Estoque", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaEstoque")
                    loc_oPg.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
                    loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.rclis)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstoque")
                        loc_oPg.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
                        loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.rclis)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEstoque")
            USE IN cursor_4c_BuscaEstoque
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE AbrirBuscaDsEstoque()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsEstoque.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaEstoque", "rclis", loc_cValor, ;
            "Conta de Estoque", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaEstoque")
                    loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.rclis)
                    loc_oPg.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstoque")
                        loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.rclis)
                        loc_oPg.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaEstoque.iclis)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEstoque")
            USE IN cursor_4c_BuscaEstoque
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarCdEstoque()
        LOCAL loc_cValor, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEstoque.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsEstoque.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + ;
            EscaparSQL(loc_cValor), "cursor_4c_EstVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EstVal
            IF !EOF()
                loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_EstVal.rclis)
            ELSE
                loc_oPg.txt_4c_DsEstoque.Value = ""
                THIS.AbrirBuscaCdEstoque()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DsEstoque.Value = ""
        ENDIF
        IF USED("cursor_4c_EstVal")
            USE IN cursor_4c_EstVal
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarDsEstoque()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsEstoque.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdEstoque.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        THIS.AbrirBuscaDsEstoque()
    ENDPROC

    *==========================================================================
    * LOOKUP - FORNECEDOR (SigCdCli: iclis / rclis)
    * b.IFors filtra SigCdPro; o fornecedor eh um cliente do grupo GrPadFors
    *==========================================================================

    PROCEDURE AbrirBuscaIFors()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_IFors.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaFors", "iclis", loc_cValor, ;
            "Fornecedor", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaFors")
                    loc_oPg.txt_4c_IFors.Value = ALLTRIM(cursor_4c_BuscaFors.iclis)
                    loc_oPg.txt_4c_DFors.Value = ALLTRIM(cursor_4c_BuscaFors.rclis)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFors")
                        loc_oPg.txt_4c_IFors.Value = ALLTRIM(cursor_4c_BuscaFors.iclis)
                        loc_oPg.txt_4c_DFors.Value = ALLTRIM(cursor_4c_BuscaFors.rclis)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaFors")
            USE IN cursor_4c_BuscaFors
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE AbrirBuscaDFors()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DFors.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaFors", "rclis", loc_cValor, ;
            "Fornecedor", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaFors")
                    loc_oPg.txt_4c_DFors.Value = ALLTRIM(cursor_4c_BuscaFors.rclis)
                    loc_oPg.txt_4c_IFors.Value = ALLTRIM(cursor_4c_BuscaFors.iclis)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("rclis", "", "Nome")
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFors")
                        loc_oPg.txt_4c_DFors.Value = ALLTRIM(cursor_4c_BuscaFors.rclis)
                        loc_oPg.txt_4c_IFors.Value = ALLTRIM(cursor_4c_BuscaFors.iclis)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaFors")
            USE IN cursor_4c_BuscaFors
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarIFors()
        LOCAL loc_cValor, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_IFors.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DFors.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + ;
            EscaparSQL(loc_cValor), "cursor_4c_ForsVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ForsVal
            IF !EOF()
                loc_oPg.txt_4c_DFors.Value = ALLTRIM(cursor_4c_ForsVal.rclis)
            ELSE
                loc_oPg.txt_4c_DFors.Value = ""
                THIS.AbrirBuscaIFors()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DFors.Value = ""
        ENDIF
        IF USED("cursor_4c_ForsVal")
            USE IN cursor_4c_ForsVal
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarDFors()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DFors.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_IFors.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        THIS.AbrirBuscaDFors()
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA (sigcdemp: cemps / razas)
    * Confirmado no Init: CursorQuery([SigCdEmp], ..., [Cemps, Razas])
    *==========================================================================

    PROCEDURE AbrirBuscaCdEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "sigcdemp", "cursor_4c_BuscaEmpresa", "cemps", loc_cValor, ;
            "Empresa", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaEmpresa")
                    loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.cemps)
                    loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.razas)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
                        loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.cemps)
                        loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE AbrirBuscaDsEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "sigcdemp", "cursor_4c_BuscaEmpresa", "razas", loc_cValor, ;
            "Empresa", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaEmpresa")
                    loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.razas)
                    loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.cemps)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
                        loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.razas)
                        loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.cemps)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarCdEmpresa()
        LOCAL loc_cValor, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsEmpresa.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT cemps, razas FROM sigcdemp WHERE cemps = " + ;
            EscaparSQL(loc_cValor), "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.razas)
            ELSE
                loc_oPg.txt_4c_DsEmpresa.Value = ""
                THIS.AbrirBuscaCdEmpresa()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DsEmpresa.Value = ""
        ENDIF
        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarDsEmpresa()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdEmpresa.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        THIS.AbrirBuscaDsEmpresa()
    ENDPROC

    *==========================================================================
    * LOOKUP - GRANDE GRUPO (SigCdGpr: codigos / descs)
    * Confirmado em getDGgps.Valid: SigCdGpr, Codigos, Descs
    *==========================================================================

    PROCEDURE AbrirBuscaCGgps()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CGgps.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGpr", "cursor_4c_BuscaGGpro", "Codigos", loc_cValor, ;
            "Grande Grupo", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaGGpro")
                    loc_oPg.txt_4c_CGgps.Value = ALLTRIM(cursor_4c_BuscaGGpro.Codigos)
                    loc_oPg.txt_4c_DGgps.Value = ALLTRIM(cursor_4c_BuscaGGpro.Descs)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGGpro")
                        loc_oPg.txt_4c_CGgps.Value = ALLTRIM(cursor_4c_BuscaGGpro.Codigos)
                        loc_oPg.txt_4c_DGgps.Value = ALLTRIM(cursor_4c_BuscaGGpro.Descs)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGGpro")
            USE IN cursor_4c_BuscaGGpro
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE AbrirBuscaDGgps()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DGgps.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGpr", "cursor_4c_BuscaGGpro", "Descs", loc_cValor, ;
            "Grande Grupo", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaGGpro")
                    loc_oPg.txt_4c_DGgps.Value = ALLTRIM(cursor_4c_BuscaGGpro.Descs)
                    loc_oPg.txt_4c_CGgps.Value = ALLTRIM(cursor_4c_BuscaGGpro.Codigos)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGGpro")
                        loc_oPg.txt_4c_DGgps.Value = ALLTRIM(cursor_4c_BuscaGGpro.Descs)
                        loc_oPg.txt_4c_CGgps.Value = ALLTRIM(cursor_4c_BuscaGGpro.Codigos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGGpro")
            USE IN cursor_4c_BuscaGGpro
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarCGgps()
        LOCAL loc_cValor, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CGgps.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DGgps.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
            EscaparSQL(loc_cValor), "cursor_4c_GGproVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GGproVal
            IF !EOF()
                loc_oPg.txt_4c_DGgps.Value = ALLTRIM(cursor_4c_GGproVal.Descs)
            ELSE
                loc_oPg.txt_4c_DGgps.Value = ""
                THIS.AbrirBuscaCGgps()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DGgps.Value = ""
        ENDIF
        IF USED("cursor_4c_GGproVal")
            USE IN cursor_4c_GGproVal
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarDGgps()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DGgps.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CGgps.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        THIS.AbrirBuscaDGgps()
    ENDPROC

    *==========================================================================
    * LOOKUP - GRUPO DE PRODUTO (SigCdGrp: CGrus / DGrus)
    * Confirmado em Get_Ds_GPro.Valid: SigCdGrp, CGrus, DGrus
    *==========================================================================

    PROCEDURE AbrirBuscaCdGPro()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdGPro.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_BuscaGPro", "CGrus", loc_cValor, ;
            "Grupo de Produto", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaGPro")
                    loc_oPg.txt_4c_CdGPro.Value = ALLTRIM(cursor_4c_BuscaGPro.CGrus)
                    loc_oPg.txt_4c_DsGPro.Value = ALLTRIM(cursor_4c_BuscaGPro.DGrus)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGPro")
                        loc_oPg.txt_4c_CdGPro.Value = ALLTRIM(cursor_4c_BuscaGPro.CGrus)
                        loc_oPg.txt_4c_DsGPro.Value = ALLTRIM(cursor_4c_BuscaGPro.DGrus)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGPro")
            USE IN cursor_4c_BuscaGPro
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE AbrirBuscaDsGPro()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsGPro.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrp", "cursor_4c_BuscaGPro", "DGrus", loc_cValor, ;
            "Grupo de Produto", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaGPro")
                    loc_oPg.txt_4c_DsGPro.Value = ALLTRIM(cursor_4c_BuscaGPro.DGrus)
                    loc_oPg.txt_4c_CdGPro.Value = ALLTRIM(cursor_4c_BuscaGPro.CGrus)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGPro")
                        loc_oPg.txt_4c_DsGPro.Value = ALLTRIM(cursor_4c_BuscaGPro.DGrus)
                        loc_oPg.txt_4c_CdGPro.Value = ALLTRIM(cursor_4c_BuscaGPro.CGrus)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGPro")
            USE IN cursor_4c_BuscaGPro
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarCdGPro()
        LOCAL loc_cValor, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdGPro.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsGPro.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
            EscaparSQL(loc_cValor), "cursor_4c_GProVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GProVal
            IF !EOF()
                loc_oPg.txt_4c_DsGPro.Value = ALLTRIM(cursor_4c_GProVal.DGrus)
            ELSE
                loc_oPg.txt_4c_DsGPro.Value = ""
                THIS.AbrirBuscaCdGPro()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DsGPro.Value = ""
        ENDIF
        IF USED("cursor_4c_GProVal")
            USE IN cursor_4c_GProVal
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarDsGPro()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsGPro.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdGPro.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        THIS.AbrirBuscaDsGPro()
    ENDPROC

    *==========================================================================
    * LOOKUP - SUBGRUPO DE PRODUTO (SigCdPsg: Codigos / Descricaos)
    * Confirmado em get_ds_sgrupo.Valid: SigCdPsg, Codigos, Descricaos
    *==========================================================================

    PROCEDURE AbrirBuscaCdSgrupo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdSgrupo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPsg", "cursor_4c_BuscaSgrupo", "Codigos", loc_cValor, ;
            "Subgrupo de Produto", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaSgrupo")
                    loc_oPg.txt_4c_CdSgrupo.Value = ALLTRIM(cursor_4c_BuscaSgrupo.Codigos)
                    loc_oPg.txt_4c_DsSgrupo.Value = ALLTRIM(cursor_4c_BuscaSgrupo.Descricaos)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos",     "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSgrupo")
                        loc_oPg.txt_4c_CdSgrupo.Value = ALLTRIM(cursor_4c_BuscaSgrupo.Codigos)
                        loc_oPg.txt_4c_DsSgrupo.Value = ALLTRIM(cursor_4c_BuscaSgrupo.Descricaos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaSgrupo")
            USE IN cursor_4c_BuscaSgrupo
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE AbrirBuscaDsSgrupo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsSgrupo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPsg", "cursor_4c_BuscaSgrupo", "Descricaos", loc_cValor, ;
            "Subgrupo de Produto", .F.)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaSgrupo")
                    loc_oPg.txt_4c_DsSgrupo.Value = ALLTRIM(cursor_4c_BuscaSgrupo.Descricaos)
                    loc_oPg.txt_4c_CdSgrupo.Value = ALLTRIM(cursor_4c_BuscaSgrupo.Codigos)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos",     "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSgrupo")
                        loc_oPg.txt_4c_DsSgrupo.Value = ALLTRIM(cursor_4c_BuscaSgrupo.Descricaos)
                        loc_oPg.txt_4c_CdSgrupo.Value = ALLTRIM(cursor_4c_BuscaSgrupo.Codigos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaSgrupo")
            USE IN cursor_4c_BuscaSgrupo
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarCdSgrupo()
        LOCAL loc_cValor, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdSgrupo.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsSgrupo.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
            EscaparSQL(loc_cValor), "cursor_4c_SgrupoVal")
        IF loc_nResult > 0
            SELECT cursor_4c_SgrupoVal
            IF !EOF()
                loc_oPg.txt_4c_DsSgrupo.Value = ALLTRIM(cursor_4c_SgrupoVal.Descricaos)
            ELSE
                loc_oPg.txt_4c_DsSgrupo.Value = ""
                THIS.AbrirBuscaCdSgrupo()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DsSgrupo.Value = ""
        ENDIF
        IF USED("cursor_4c_SgrupoVal")
            USE IN cursor_4c_SgrupoVal
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarDsSgrupo()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsSgrupo.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdSgrupo.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        THIS.AbrirBuscaDsSgrupo()
    ENDPROC

    *==========================================================================
    * LOOKUP - PRODUTO (SigCdPro: cpros / dpros)
    * Quando CdGPro preenchido, filtra por cgrus (igual ao legado)
    * Confirmado em get_cd_codigo.Valid e get_ds_codigo.Valid
    *==========================================================================

    PROCEDURE AbrirBuscaCdCodigo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg, loc_cWhere
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdCodigo.Value)
        loc_cWhere = ""
        IF PEMSTATUS(loc_oPg, "txt_4c_CdGPro", 5) AND ;
           !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdGPro.Value))
            loc_cWhere = "cgrus = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CdGPro.Value))
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaCodigo", "cpros", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Produto", .F., .T., loc_cWhere)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaCodigo")
                    loc_oPg.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.cpros)
                    loc_oPg.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.dpros)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCodigo")
                        loc_oPg.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.cpros)
                        loc_oPg.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.dpros)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCodigo")
            USE IN cursor_4c_BuscaCodigo
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE AbrirBuscaDsCodigo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg, loc_cWhere
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsCodigo.Value)
        loc_cWhere = ""
        IF PEMSTATUS(loc_oPg, "txt_4c_CdGPro", 5) AND ;
           !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdGPro.Value))
            loc_cWhere = "cgrus = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CdGPro.Value))
        ENDIF
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaCodigo", "dpros", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Produto", .F., .T., loc_cWhere)
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaCodigo")
                    loc_oPg.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.dpros)
                    loc_oPg.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.cpros)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCodigo")
                        loc_oPg.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.dpros)
                        loc_oPg.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.cpros)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCodigo")
            USE IN cursor_4c_BuscaCodigo
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarCdCodigo()
        LOCAL loc_cValor, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdCodigo.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsCodigo.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT cpros, dpros FROM SigCdPro WHERE cpros = " + ;
            EscaparSQL(loc_cValor), "cursor_4c_CodigoVal")
        IF loc_nResult > 0
            SELECT cursor_4c_CodigoVal
            IF !EOF()
                loc_oPg.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_CodigoVal.dpros)
            ELSE
                loc_oPg.txt_4c_DsCodigo.Value = ""
                THIS.AbrirBuscaCdCodigo()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DsCodigo.Value = ""
        ENDIF
        IF USED("cursor_4c_CodigoVal")
            USE IN cursor_4c_CodigoVal
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    PROCEDURE ValidarDsCodigo()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsCodigo.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdCodigo.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        THIS.AbrirBuscaDsCodigo()
    ENDPROC

    *==========================================================================
    * VALIDARCBARS - Codigo de Barras: busca produto em SigOpEtq
    * Equivalente ao getCBars.Valid do legado (SQLEXEC direto)
    *==========================================================================

    PROCEDURE ValidarCBars()
        LOCAL loc_cValor, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CBars.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdCodigo.Value = ""
            loc_oPg.txt_4c_DsCodigo.Value = ""
            THIS.AtualizarEstadoControles()
            RETURN
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT DISTINCT a.cpros, b.dpros " + ;
            "FROM SigOpEtq a LEFT JOIN SigCdPro b ON a.cpros = b.cpros " + ;
            "WHERE a.cbars = " + EscaparSQL(loc_cValor), "cursor_4c_BarsVal")
        IF loc_nResult > 0
            SELECT cursor_4c_BarsVal
            IF !EOF()
                loc_oPg.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_BarsVal.cpros)
                loc_oPg.txt_4c_DsCodigo.Value = ALLTRIM(NVL(cursor_4c_BarsVal.dpros, ""))
            ELSE
                MsgAviso("C" + CHR(243) + "digo de barras n" + CHR(227) + ;
                    "o encontrado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_CBars.Value = ""
            ENDIF
        ELSE
            MsgAviso("Falha ao consultar c" + CHR(243) + "digo de barras.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
        IF USED("cursor_4c_BarsVal")
            USE IN cursor_4c_BarsVal
        ENDIF
        THIS.AtualizarEstadoControles()
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkCheck5Click - Check5 (Analitico) e Check3 (Duracao) sao mutuamente
    * exclusivos. Selecionar Analitico desmarca Duracao.
    * Equivalente ao Check5.Click do legado: If This.Value=1 Then Check3.Value=0
    *--------------------------------------------------------------------------
    PROCEDURE ChkCheck5Click()
        LOCAL loc_oPg, loc_oErro
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPg, "chk_4c_Check5", 5) AND ;
               PEMSTATUS(loc_oPg, "chk_4c_Check3", 5)
                IF loc_oPg.chk_4c_Check5.Value = 1
                    loc_oPg.chk_4c_Check3.Value = 0
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
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

ENDDEFINE
