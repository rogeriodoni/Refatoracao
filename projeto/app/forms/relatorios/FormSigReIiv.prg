*==============================================================================
* FORMSIGREIIV.PRG
* Impress[a]o de Invoice - Formul[a]rio de Impress[a]o
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREIIV.SCX (frmrelatorio)
*
* Filtros:
*   - chk_4c_Listagem : Imprimir Listagem (SigReIpk)
*
* Chamado com par[a]metros:
*   CREATEOBJECT("FormSigReIiv", cEmp, cDop, nNum, nTpImp)
*   nTpImp: 1=preview, 2=imprime, 3=auto-imprime, 4=auto-imprime+prompt
*
* Modo auto (nTpImp=3 ou 4): imprime e fecha sem exibir o formul[a]rio.
*==============================================================================

DEFINE CLASS FormSigReIiv AS FormBase

    Height      = 125
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

    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""
    this_pEmp          = ""
    this_pDop          = ""
    this_pNum          = 0
    this_pTpImp        = 0
    this_cContaEmail   = ""    && Email acumulado (ContaEmail do original)

    *--------------------------------------------------------------------------
    * Init - Armazena par[a]metros, inicializa form; auto-imprime se nTpImp=3/4
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_pEmp, par_pDop, par_nNum, par_nTpImp)
        THIS.this_pEmp   = IIF(VARTYPE(par_pEmp)   = "C", par_pEmp,   "")
        THIS.this_pDop   = IIF(VARTYPE(par_pDop)   = "C", par_pDop,   "")
        THIS.this_pNum   = IIF(VARTYPE(par_nNum)   = "N", par_nNum,   0)
        THIS.this_pTpImp = IIF(VARTYPE(par_nTpImp) = "N", par_nTpImp, 0)

        IF !DODEFAULT()
            RETURN .F.
        ENDIF

        IF INLIST(THIS.this_pTpImp, 3, 4)
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Imprimir()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do formul[a]rio de relat[o]rio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Impress" + CHR(227) + "o de Invoice"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SigReIivBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReIivBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.Visible  = .T.
                loc_lSucesso  = .T.
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
    * ConfigurarCabecalho - Container escuro superior com t[i]tulo do relat[o]rio
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
                .Caption   = THIS.Caption
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
                .Caption   = THIS.Caption
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
    * ConfigurarBotoes - CommandGroup com 4 bot[o]es de relat[o]rio
    *   Geometria EXATA do framework frmrelatorio:
    *     Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *   Bot[o]es: Visualizar(1)/Imprimir(2)/Excel(3)/Encerrar(4)
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
    * ConfigurarPageFrame - PageFrame com 1 p[a]gina (Filtros)
    *   Form Height=125, cabe[c]alho Height=80 -> PageFrame Height=40
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
    * ConfigurarPaginaLista - CheckBox "Imprimir Listagem" na Page1
    *   Original: chkListagem Top=94, Left=72 (form-relativo)
    *   Page1.Top = 94 - 85 = 9 (relativo ao PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("chk_4c_Listagem", "CheckBox")
        WITH loc_oPg.chk_4c_Listagem
            .Top       = 9
            .Left      = 72
            .Width     = 101
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Imprimir Listagem"
            .Value     = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Sem campos adicionais neste relatorio
    *
    * SIGREIIV e um frmrelatorio com layout FLAT (Height=125px).
    * O unico controle de filtro (chkListagem) ja foi criado em
    * ConfigurarPaginaLista(). Nao ha Page2 de edicao de dados.
    * Todos os dados de entrada chegam via parametros do Init():
    *   par_pEmp, par_pDop, par_nNum, par_nTpImp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterContaEmail - Retorna email acumulado dos clientes de origem/destino
    * Original: ThisForm.ContaEmail (preenchido em selecionadados)
    * Novo: this_oRelatorio.this_cContaEmail (preenchido em SelecionarDados)
    *--------------------------------------------------------------------------
    PROCEDURE ObterContaEmail()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_cContaEmail = THIS.this_oRelatorio.this_cContaEmail
        ENDIF
        RETURN THIS.this_cContaEmail
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia par[a]metros e controles para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_lListagem
        loc_lListagem = .F.
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "chk_4c_Listagem", 5)
                    loc_lListagem = (THIS.pgf_4c_Paginas.Page1.chk_4c_Listagem.Value = 1)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormParaRelatorio")
        ENDTRY
        WITH THIS.this_oRelatorio
            .this_cEmps             = THIS.this_pEmp
            .this_cDopes            = THIS.this_pDop
            .this_nNumes            = THIS.this_pNum
            .this_nTpImp            = THIS.this_pTpImp
            .this_lImprimirListagem = loc_lListagem
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Par[a]metros j[a] fornecidos via Init(), sem valida[c][a]o
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * A[C][O]ES DOS BOT[O]ES DO RELAT[O]RIO
    *==========================================================================

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZAR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("IMPRIMIR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcelClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF PEMSTATUS(THIS.this_oRelatorio, "ExportarExcel", 5)
                    IF !THIS.this_oRelatorio.ExportarExcel()
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                    ELSE
                        THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
                    ENDIF
                ELSE
                    MsgInfo("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + ;
                        "o implementada para Invoice.", ;
                        "Recurso n" + CHR(227) + "o dispon" + CHR(237) + "vel")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT (aliases para compatibilidade com pipeline)
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
            CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
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

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        RETURN .T.
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN .T.
    ENDPROC

    PROCEDURE LimparCampos()
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "chk_4c_Listagem", 5)
                    THIS.pgf_4c_Paginas.Page1.chk_4c_Listagem.Value = 0
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN .T.
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
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera refer[e]ncia ao BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
