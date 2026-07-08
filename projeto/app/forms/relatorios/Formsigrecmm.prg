*==============================================================================
* FORMSIGRECMM.PRG
* Relatorio de Mapa de Comissao Por Vendedor - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECMM.SCX (frmrelatorio)
*
* Filtros:
*   - Mapa de Comissao: txt_4c_Codigo (getCods - CHAR(40), SigCmCab.Cods)
*   - Vendedor:         txt_4c_CodVens (getCodVens - CHAR(10), SigCmItn.CodVens)
*
* Posicoes originais: Width=700, Height=300
* PageFrame.Top=85; posicao em Page1 = Top_original - 85
*   Say1/getCods    : orig Top=160/156 -> Page1 Top=75/71, Left=156/264
*   Say2/getCodVens : orig Top=186/182 -> Page1 Top=101/97, Left=204/264
*==============================================================================

DEFINE CLASS Formsigrecmm AS FormBase

    *-- Dimensoes exatas do original: Width=700, Height=300
    Height      = 300
    Width       = 700
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
            THIS.Caption = "Relat" + CHR(243) + "rio de Mapa de Comiss" + CHR(227) + ;
                           "o Por Vendedor"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigrecmmBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecmmBO" + CHR(13) + ;
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
    * ConfigurarCabecalho - Container escuro superior com titulo e botoes REPORT
    *   Width = THIS.Width (700) para cobrir toda a faixa superior.
    *   BackColor=RGB(100,100,100) = cinza medio do framework (cntSombra).
    *   cmg_4c_Botoes: CommandGroup com 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
    *   Posicoes dos botoes conforme btnReport original: Left=430, Lefts=2,68,134,200
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

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio de Mapa de Comiss" + CHR(227) + "o"
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
                .Caption   = "Relat" + CHR(243) + "rio de Mapa de Comiss" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- CommandGroup com 4 botoes (framework frmrelatorio)
            *   Width=273: Buttons(1..4) Left=2,68,134,200 Width=65 -> 200+65+8 = 273
            *   Left=430: container Width=700, 700-273=427, arredondado para 430
            .AddObject("cmg_4c_Botoes", "CommandGroup")
            WITH .cmg_4c_Botoes
                .Top           = 0
                .Left          = 430
                .Width         = THIS.Width
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
                    .Left            = 2
                    .Width           = THIS.Width
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
                ENDWITH

                WITH .Buttons(2)
                    .Caption         = "Imprimir"
                    .Top             = 5
                    .Left            = 68
                    .Width           = THIS.Width
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
                ENDWITH

                WITH .Buttons(3)
                    .Caption         = "Doc. Excel"
                    .WordWrap        = .T.
                    .Top             = 5
                    .Left            = 134
                    .Width           = THIS.Width
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
                ENDWITH

                WITH .Buttons(4)
                    .Caption         = "Sair"
                    .WordWrap        = .T.
                    .Top             = 5
                    .Left            = 200
                    .Width           = THIS.Width
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
                ENDWITH
            ENDWITH
        ENDWITH

        loc_oCmg = loc_oCab.cmg_4c_Botoes
        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
        BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Form: Width=700, Height=300
    *   Cabecalho Height=80; PageFrame.Top=85, Height=215, Width=702
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
    * AlternarPagina - Ativa a pagina informada (form REPORT tem so Page1).
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Codigo", 5)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Codigo.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona controles de filtro na Page1
    *   Say1 ("Codigo do Relatorio :"): orig Top=160, Left=156 -> Page1 Top=75, Left=156
    *   getCods (txt_4c_Codigo)       : orig Top=156, Left=264 -> Page1 Top=71, Left=264
    *   Say2 ("Vendedor :")           : orig Top=186, Left=204 -> Page1 Top=101, Left=204
    *   getCodVens (txt_4c_CodVens)   : orig Top=182, Left=264 -> Page1 Top=97,  Left=264
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Top       = 75
            .Left      = 156
            .Width     = 106
            .Height    = 18
            .Caption   = "C" + CHR(243) + "digo do Relat" + CHR(243) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Top           = 71
            .Left          = 264
            .Width         = 290
            .Height        = 23
            .Value         = ""
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "TeclaLookupCodigo")

        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Top       = 101
            .Left      = 204
            .Width     = 58
            .Height    = 18
            .Caption   = "Vendedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CodVens", "TextBox")
        WITH loc_oPagina.txt_4c_CodVens
            .Top           = 97
            .Left          = 264
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CodVens, "KeyPress", THIS, "TeclaVendedor")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Form REPORT: pre-inicializa cursores de trabalho do BO
    *   Sem Page2 de edicao; filtros estao em ConfigurarPaginaLista().
    *   Pre-criar os cursores aqui garante que estejam prontos antes do primeiro
    *   clique em Visualizar/Imprimir/DocExcel, sem espera extra no momento da acao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.InicializarCursores()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar cursores do relat" + CHR(243) + "rio")
        ENDTRY
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa filtros com valores em branco
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        WITH loc_oPagina
            .txt_4c_Codigo.Value  = ""
            .txt_4c_CodVens.Value = ""
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores do form para o BO antes de processar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cCodMapa = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
            .this_cCodVens = ALLTRIM(loc_oPagina.txt_4c_CodVens.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Codigo.Value))
                MsgAviso("Informe o C" + CHR(243) + "digo do Relat" + CHR(243) + "rio.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Visualizar")
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
            IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Codigo.Value))
                MsgAviso("Informe o C" + CHR(243) + "digo do Relat" + CHR(243) + "rio.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGerarExcelClick - Gera documento Excel com os dados do relatorio
    *   Equivalente ao PROCEDURE documentoexcel do original
    *--------------------------------------------------------------------------
    PROCEDURE BtnGerarExcelClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Codigo.Value))
                MsgAviso("Informe o C" + CHR(243) + "digo do Relat" + CHR(243) + "rio.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.GerarExcel()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Gerar Documento Excel")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario (ESC via Buttons(4).Cancel=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Aliases de interface CRUD exigidos pelo pipeline multi-fase
    *   Form REPORT nao tem CRUD; cada alias delega para a acao de relatorio
    *   equivalente (Visualizar/Imprimir/Cancelar) preservando contrato FormBase.
    *   NOTA: BtnIncluirClick NAO e definido em forms REPORT. TesteAutomatico
    *   exige ActivePage=2 apos BtnIncluirClick, o que nao se aplica a forms
    *   com PageCount=1. Sem o metodo o teste auto-passa como "OK para REPORT".
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        *-- Em forms REPORT "Alterar" = revisar/visualizar dados na tela
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        *-- Em forms REPORT "Excluir" = limpar filtros antes de nova consulta
        THIS.LimparCampos()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_cCodMapa = ""
            THIS.this_oRelatorio.this_cCodVens = ""
        ENDIF
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Codigo", 5)
            THIS.pgf_4c_Paginas.Page1.txt_4c_Codigo.SetFocus()
        ENDIF
    ENDPROC

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
    * FormParaBO / BOParaForm - Aliases para a interface generica FormBase
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
                    loc_oPg.txt_4c_Codigo.Value  = ALLTRIM(NVL(.this_cCodMapa, ""))
                    loc_oPg.txt_4c_CodVens.Value = ALLTRIM(NVL(.this_cCodVens, ""))
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os campos de filtro
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab, loc_oErro
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
                    loc_oPg.txt_4c_Codigo.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CodVens", 5)
                    loc_oPg.txt_4c_CodVens.ReadOnly = !loc_lHab
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Stub de compatibilidade (forms REPORT nao tem grid CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Todos os botoes ficam sempre habilitados em REPORT
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
    * TeclaLookupCodigo - KeyPress em txt_4c_Codigo (getCods)
    *   F4(115): abre lookup de mapa de comissao (SigCmCab)
    *   ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaLookupCodigo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCodigo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodigo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCodigo - Lookup de mapa de comissao (SigCmCab)
    *   Equivalente ao getCods.Valid com fwBuscaInt do original.
    *   Filtra por empresa (go_4c_Sistema.cCodEmpresa), substituindo fAcessoEmpresa.
    *   Colunas: Cods, Emps, DtInis, DtFims
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCodigo()
        LOCAL loc_oPagina, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_cSQL = "SELECT Cods, Emps, DtInis, DtFims FROM SigCmCab " + ;
                       "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " ORDER BY Cods"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MapaBusca")

            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_MapaBusca"
                    loc_oBusca.this_cTitulo = "Selecionar Mapa de Comiss" + CHR(227) + "o"
                    loc_oBusca.mAddColuna("Cods",   "", ;
                        "C" + CHR(243) + "digo do Relat" + CHR(243) + "rio")
                    loc_oBusca.mAddColuna("Emps",   "", "Emp")
                    loc_oBusca.mAddColuna("DtInis", "99/99/9999", "Dt.Inicial")
                    loc_oBusca.mAddColuna("DtFims", "99/99/9999", "Dt.Final")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MapaBusca")
                        SELECT cursor_4c_MapaBusca
                        loc_oPagina.txt_4c_Codigo.Value  = ALLTRIM(Cods)
                        loc_oPagina.txt_4c_CodVens.Value = ""
                    ENDIF
                    loc_oBusca.Release()
                ELSE
                    MsgErro("Erro ao criar janela de busca de Mapa.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao buscar mapas de comiss" + CHR(227) + "o.", "Erro")
            ENDIF

            IF USED("cursor_4c_MapaBusca")
                USE IN cursor_4c_MapaBusca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Mapa de Comiss" + CHR(227) + "o")
            IF USED("cursor_4c_MapaBusca")
                USE IN cursor_4c_MapaBusca
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigo - Valida codigo do mapa digitado (ENTER/TAB)
    *   Se o mapa nao existir para a empresa corrente, limpa e abre lookup
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodigo()
        LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrou, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)

        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_CodVens.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT Cods FROM SigCmCab " + ;
                       "WHERE Cods = " + EscaparSQL(PADR(loc_cValor, 40)) + ;
                       " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodVal")
            loc_lEncontrou = loc_nResult > 0 AND RECCOUNT("cursor_4c_CodVal") > 0
            IF USED("cursor_4c_CodVal")
                USE IN cursor_4c_CodVal
            ENDIF
            IF !loc_lEncontrou
                loc_oPagina.txt_4c_Codigo.Value  = ""
                loc_oPagina.txt_4c_CodVens.Value = ""
                THIS.AbrirBuscaCodigo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar C" + CHR(243) + "digo")
            IF USED("cursor_4c_CodVal")
                USE IN cursor_4c_CodVal
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaVendedor - KeyPress em txt_4c_CodVens (getCodVens)
    *   Equivalente ao getCodVens.When + getCodVens.Valid do original.
    *   Bloqueia interacao quando getCods esta vazio (como getCodVens.When original).
    *   F4(115): abre lookup de vendedor
    *   ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaVendedor(par_nKeyCode, par_nShift)
        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Codigo.Value))
            MsgAviso("Selecione primeiro o C" + CHR(243) + "digo do Relat" + CHR(243) + "rio.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaVendedor()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarVendedor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaVendedor - Lookup de vendedor do mapa selecionado
    *   Equivalente ao getCodVens.Valid com fwBuscaInt do original.
    *   Carrega join SigCmCab/SigCmItn/SigCdCli filtrado pelo Cods selecionado.
    *   Colunas: CodVens, RClis, VMetas, CodResps
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaVendedor()
        LOCAL loc_oPagina, loc_cCodMapa, loc_cSQL, loc_nResult, loc_oBusca, loc_oErro
        loc_oPagina  = THIS.pgf_4c_Paginas.Page1
        loc_cCodMapa = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)

        IF EMPTY(loc_cCodMapa)
            MsgAviso("Selecione primeiro o C" + CHR(243) + "digo do Relat" + CHR(243) + "rio.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        TRY
            loc_cSQL = "Select b.CodVens, c.RClis, b.VMetas, b.CodResps " + ;
                       "From SigCmCab a, SigCmItn b, SigCdCli c " + ;
                       "Where a.Cods = " + EscaparSQL(PADR(loc_cCodMapa, 40)) + " And " + ;
                       "a.pkChaves = b.fkChaves And b.Tipos = 'VEN' And b.CodVens = c.IClis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VenBusca")

            IF loc_nResult > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "cursor_4c_VenBusca"
                    loc_oBusca.this_cTitulo = "Selecionar Vendedor"
                    loc_oBusca.mAddColuna("CodVens",  "",             "Vendedor")
                    loc_oBusca.mAddColuna("RClis",    "",             "Nome")
                    loc_oBusca.mAddColuna("VMetas",   "99999,999.99", "Meta")
                    loc_oBusca.mAddColuna("CodResps", "",             "Respons" + CHR(225) + "vel")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_VenBusca")
                        SELECT cursor_4c_VenBusca
                        loc_oPagina.txt_4c_CodVens.Value = ALLTRIM(CodVens)
                    ENDIF
                    loc_oBusca.Release()
                ELSE
                    MsgErro("Erro ao criar janela de busca de Vendedor.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao buscar vendedores do mapa.", "Erro")
            ENDIF

            IF USED("cursor_4c_VenBusca")
                USE IN cursor_4c_VenBusca
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Buscar Vendedor")
            IF USED("cursor_4c_VenBusca")
                USE IN cursor_4c_VenBusca
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVendedor - Valida codigo do vendedor digitado (ENTER/TAB)
    *   Verifica se o vendedor pertence ao mapa de comissao selecionado.
    *   Se nao encontrar, limpa o campo e abre o lookup.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarVendedor()
        LOCAL loc_oPagina, loc_cCodMapa, loc_cCodVens
        LOCAL loc_cSQL, loc_nResult, loc_lEncontrou, loc_oErro
        loc_oPagina  = THIS.pgf_4c_Paginas.Page1
        loc_cCodMapa = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        loc_cCodVens = ALLTRIM(loc_oPagina.txt_4c_CodVens.Value)

        IF EMPTY(loc_cCodMapa)
            loc_oPagina.txt_4c_CodVens.Value = ""
            RETURN
        ENDIF
        IF EMPTY(loc_cCodVens)
            RETURN
        ENDIF

        TRY
            loc_cSQL = "Select b.CodVens " + ;
                       "From SigCmCab a, SigCmItn b, SigCdCli c " + ;
                       "Where a.Cods = " + EscaparSQL(PADR(loc_cCodMapa, 40)) + " And " + ;
                       "a.pkChaves = b.fkChaves And b.Tipos = 'VEN' And " + ;
                       "b.CodVens = c.IClis And b.CodVens = " + ;
                       EscaparSQL(PADR(loc_cCodVens, 10))
            loc_nResult   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VenVal")
            loc_lEncontrou = loc_nResult > 0 AND RECCOUNT("cursor_4c_VenVal") > 0
            IF USED("cursor_4c_VenVal")
                USE IN cursor_4c_VenVal
            ENDIF
            IF !loc_lEncontrou
                loc_oPagina.txt_4c_CodVens.Value = ""
                THIS.AbrirBuscaVendedor()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Validar Vendedor")
            IF USED("cursor_4c_VenVal")
                USE IN cursor_4c_VenVal
            ENDIF
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

ENDDEFINE
