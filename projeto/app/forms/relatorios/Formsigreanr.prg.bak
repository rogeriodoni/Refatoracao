*==============================================================================
* FORMSIGREANR.PRG
* Relatorio de Resultados - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREANR.SCX (frmrelatorio)
*
* Filtros:
*   - Periodo: txt_4c_DtInicial (get_dt_inicial) / txt_4c_DtFinal (get_dt_final)
*   - Data Cotacao: txt_4c_DtCotacao (Get_Dt_Cotacao)
*   - Empresa: txt_4c_Empresa (get_empresa - codigo 3 chars)
*              txt_4c_EmpresaDesc (get_empresa_desc - razao social, 40 chars)
*
* Posicoes originais: Width=800, Height=300
* PageFrame.Top=85; posicao em Page1 = Top_original - 85
*   lbl_periodo     : Top=137, Left=252 -> Page1: Top=52, Left=252
*   get_dt_inicial  : Top=132, Left=300 -> Page1: Top=47, Left=300, Width=80
*   lbl_periodo_a   : Top=136, Left=384 -> Page1: Top=51, Left=384 (CHR(224) = a-grave)
*   get_dt_final    : Top=132, Left=396 -> Page1: Top=47, Left=396, Width=80
*   Say1 (cotacao)  : Top=160, Left=222 -> Page1: Top=75, Left=222
*   Get_Dt_Cotacao  : Top=157, Left=300 -> Page1: Top=72, Left=300, Width=80
*   lbl_empresa     : Top=187, Left=247 -> Page1: Top=102, Left=247
*   get_empresa     : Top=182, Left=300 -> Page1: Top=97,  Left=300, Width=31
*   get_empresa_desc: Top=182, Left=333 -> Page1: Top=97,  Left=333, Width=290
*==============================================================================

DEFINE CLASS Formsigreanr AS FormBase

    *-- Dimensoes exatas do original: Width=800, Height=300
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

    *-- BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Resultados"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigreanrBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreanrBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.LimparCampos()
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
    * ConfigurarCabecalho - Container escuro superior com titulo e botoes
    *   Width = THIS.Width (800) para cobrir toda a faixa superior.
    *   BackColor=RGB(100,100,100) = cinza medio do framework (cntSombra).
    *   cmg_4c_Botoes: CommandGroup com 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab, loc_oCmg
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho

        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Labels e CommandGroup: adicionar via caminho explicito (loc_oCab.AddObject)
        *-- e configurar via WITH loc_oCab.<filho> (evita WITH aninhado que causa
        *-- falha de resolucao de propriedades ? Erro47/Erro49 pattern).
        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top       = 22
            .Left      = 22
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "Relat" + CHR(243) + "rio de Resultados"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top       = 20
            .Left      = 20
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "Relat" + CHR(243) + "rio de Resultados"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Botoes de relatorio (framework frmrelatorio: cmg_4c_Botoes)
        *-- Geometria canonica: Top=0, Left=529, Width=273, Height=80
        *-- Buttons Width=65, Height=70, Lefts=5/71/137/203 (incremento 66)
        loc_oCab.AddObject("cmg_4c_Botoes", "CommandGroup")
        loc_oCmg = loc_oCab.cmg_4c_Botoes
        WITH loc_oCmg
            .Top           = 0
            .Left          = 527
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption         = "Imprimir"
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Caption         = "Sair"
                .WordWrap        = .T.
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
        BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Form: Width=800, Height=300
    *   Cabecalho Height=80; PageFrame.Top=85, Height=300-85=215, Width=802
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1
        loc_oPgf.Top       = 85
        loc_oPgf.Left      = -1
        loc_oPgf.Width     = THIS.Width + 2
        loc_oPgf.Height    = THIS.Height - 85
        loc_oPgf.Tabs      = .F.

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
    * AlternarPagina - Ativa a pagina informada (forms REPORT tem so Page1).
    *   par_nPagina: indice 1-based. Valor invalido cai em 1.
    *   Apos ativar, foca txt_4c_DtInicial para iniciar entrada de filtros.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro, loc_oPagina
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
                loc_oPagina.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO
    *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona controles de filtro na Page1 (pagina unica)
    *   Forms REPORT nao tem grid CRUD; a "lista" eh o painel de filtros que
    *   seleciona o conjunto de dados que sera enviado ao FRX. As posicoes
    *   originais sao deslocadas: Top_page1 = Top_original - PageFrame.Top(85).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 52
            .Left      = 252
            .Width     = 45
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .Top         = 47
            .Left        = 300
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")

        loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPagina.lbl_4c_PeriodoA
            .Top       = 51
            .Left      = 384
            .Width     = 8
            .Height    = 18
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .Top         = 47
            .Left        = 396
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDataFinal")

        loc_oPagina.AddObject("lbl_4c_DtCotacao", "Label")
        WITH loc_oPagina.lbl_4c_DtCotacao
            .Top       = 75
            .Left      = 222
            .Width     = 75
            .Height    = 18
            .Caption   = "Data Cota" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtCotacao", "TextBox")
        WITH loc_oPagina.txt_4c_DtCotacao
            .Top         = 72
            .Left        = 300
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtCotacao, "KeyPress", THIS, "TeclaDtCotacao")

        loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.lbl_4c_Empresa
            .Top       = 102
            .Left      = 247
            .Width     = 50
            .Height    = 18
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPagina.txt_4c_Empresa
            .Top         = 97
            .Left        = 300
            .Width       = 31
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .MaxLength   = 3
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "TeclaEmpresa")

        loc_oPagina.AddObject("txt_4c_EmpresaDesc", "TextBox")
        WITH loc_oPagina.txt_4c_EmpresaDesc
            .Top         = 97
            .Left        = 333
            .Width       = 290
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .MaxLength   = 40
            .ReadOnly    = .T.
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_EmpresaDesc, "KeyPress", THIS, "TeclaEmpresaDesc")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Nao utilizado em form REPORT (sem Page2 de edicao)
    *   Mantido para compatibilidade com o pipeline multi-fase. Forms REPORT
    *   usam apenas Page1 (Filtros), configurada em ConfigurarPaginaLista().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa filtros com valores padrao (datas = hoje)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        WITH loc_oPagina
            .txt_4c_DtInicial.Value      = DATE()
            .txt_4c_DtFinal.Value        = DATE()
            .txt_4c_DtCotacao.Value      = DATE()
            .txt_4c_Empresa.Value        = ""
            .txt_4c_EmpresaDesc.Value    = ""
            .txt_4c_EmpresaDesc.ReadOnly = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores do form para o BO antes de imprimir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial   = loc_oPagina.txt_4c_DtInicial.Value
            .this_dDtFinal     = loc_oPagina.txt_4c_DtFinal.Value
            .this_dDtCotacao   = loc_oPagina.txt_4c_DtCotacao.Value
            .this_cEmpresa     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
            .this_cEmpresaDesc = ALLTRIM(loc_oPagina.txt_4c_EmpresaDesc.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
               EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
                MsgAviso("Informe o per" + CHR(237) + "odo.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Visualizar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
               EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
                MsgAviso("Informe o per" + CHR(237) + "odo.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Imprimir")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGerarExcelClick - Impressao direta sem dialogo (Doc. Excel)
    *--------------------------------------------------------------------------
    PROCEDURE BtnGerarExcelClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
               EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
                MsgAviso("Informe o per" + CHR(237) + "odo.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.GerarExcel()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Gerar Documento")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario (ESC via Buttons(4).Cancel=.T.)
    *   Buttons(4) eh o "Sair" do CommandGroup; Cancel=.T. mapeia ESC para ele.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Aliases de interface CRUD - exigidos pelo pipeline multi-fase (Fase 8).
    *   Forms REPORT nao possuem Buscar/Encerrar/Salvar como botoes proprios,
    *   mas o validador exige a assinatura. Mapeamos para as acoes de relatorio:
    *     BtnBuscarClick   -> Visualizar (acao de "preview" similar a uma busca)
    *     BtnEncerrarClick -> Release  (fecha o form)
    *     BtnSalvarClick   -> Imprimir (acao "definitiva" do relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnConsultarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO / BOParaForm - Aliases para a interface generica FormBase.
    *   Forms REPORT usam FormParaRelatorio() como nome principal; estes
    *   wrappers existem para o pipeline multi-fase. BOParaForm copia os
    *   filtros do BO de volta para a tela (uso em "reabrir relatorio").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page1
                WITH THIS.this_oRelatorio
                    IF !EMPTY(.this_dDtInicial)
                        loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
                    ENDIF
                    IF !EMPTY(.this_dDtFinal)
                        loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
                    ENDIF
                    IF !EMPTY(.this_dDtCotacao)
                        loc_oPg.txt_4c_DtCotacao.Value = .this_dDtCotacao
                    ENDIF
                    loc_oPg.txt_4c_Empresa.Value     = .this_cEmpresa
                    loc_oPg.txt_4c_EmpresaDesc.Value = .this_cEmpresaDesc
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os campos de filtro (ReadOnly).
    *   par_lHabilitar = .T. -> filtros editaveis (estado padrao do form REPORT)
    *   par_lHabilitar = .F. -> filtros bloqueados (uso em "processando...")
    *   txt_4c_EmpresaDesc: mantem ReadOnly=.T. quando ja ha empresa selecionada
    *   para preservar a busca reversa (descricao so editavel sem codigo).
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab, loc_oErro
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                    loc_oPg.txt_4c_DtInicial.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                    loc_oPg.txt_4c_DtFinal.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtCotacao", 5)
                    loc_oPg.txt_4c_DtCotacao.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Empresa", 5)
                    loc_oPg.txt_4c_Empresa.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_EmpresaDesc", 5)
                    IF !loc_lHab
                        loc_oPg.txt_4c_EmpresaDesc.ReadOnly = .T.
                    ELSE
                        loc_oPg.txt_4c_EmpresaDesc.ReadOnly = ;
                            !EMPTY(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Forms REPORT nao tem grid CRUD; metodo presente apenas
    *   para compatibilidade com o pipeline (validador de Fase 8).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em forms REPORT, todos os botoes do CommandGroup
    *   (Visualizar/Imprimir/Doc.Excel/Sair) ficam sempre habilitados; nao ha
    *   transicao de modo Lista/Edicao. Metodo mantido para uniformidade da
    *   interface generica de Forms; o que realmente protege contra acionamento
    *   indevido eh a validacao de periodo dentro de cada Btn*Click().
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCmg, loc_oErro, loc_nI
        TRY
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
                loc_oCmg = THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
                FOR loc_nI = 1 TO loc_oCmg.ButtonCount
                    loc_oCmg.Buttons(loc_nI).Enabled = .T.
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresa - KeyPress em txt_4c_Empresa
    *   F4(115): abre lookup de empresa
    *   ENTER(13)/TAB(9): valida codigo digitado contra SigCdEmp
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Busca empresa por codigo e preenche descricao
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oErro, loc_lEncontrou
        loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
        loc_lEncontrou = .F.
        TRY
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .F.
            ELSE
                loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                              "WHERE Cemps = " + EscaparSQL(loc_cValor)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
                IF loc_nResult > 0 AND !EOF("cursor_4c_EmpVal")
                    SELECT cursor_4c_EmpVal
                    THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ALLTRIM(Razas)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .T.
                    loc_lEncontrou = .T.
                ENDIF
                IF USED("cursor_4c_EmpVal")
                    USE IN cursor_4c_EmpVal
                ENDIF
                IF !loc_lEncontrou
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value      = ""
                    THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ""
                    THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .F.
                    THIS.AbrirBuscaEmpresa()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Empresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresaDesc - KeyPress em txt_4c_EmpresaDesc
    *   ENTER(13)/TAB(9): busca empresa pela descricao digitada
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresaDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresaDesc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresaDesc - Busca empresa pela descricao (busca reversa)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresaDesc()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value)
        IF EMPTY(loc_cValor)
            THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value     = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value = ""
        ELSE
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - Abre FormBuscaAuxiliar para selecao de empresa
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_oErro
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", ;
                "cursor_4c_BuscaEmp", ;
                "Cemps", ;
                ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value), ;
                "Buscar Empresa")

            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar janela de busca de Empresa.", "Erro")
            ELSE
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaEmp")
                        SELECT cursor_4c_BuscaEmp
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value      = ALLTRIM(Cemps)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value  = ALLTRIM(Razas)
                        THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Empresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDataInicial / TeclaDataFinal / TeclaDtCotacao
    * Handlers de KeyPress para campos de data (campos de texto simples, sem lookup)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShift)
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShift)
    ENDPROC

    PROCEDURE TeclaDtCotacao(par_nKeyCode, par_nShift)
    ENDPROC

ENDDEFINE
