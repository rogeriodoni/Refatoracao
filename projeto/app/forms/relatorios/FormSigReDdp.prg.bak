*==============================================================================
* FORMSIGREDDP.PRG
* Relatorio Demonstrativo de Balanco
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SigReDdp.SCX (frmrelatorio)
*
* Filtros (layout FLAT - controles diretos no form):
*   - Demonstrativo  (nome - SigPrDmo.Nome, com lookup F4)
*   - Data           (data de referencia para apuracao)
*
* Processamento (SigReDdpBO.PrepararDados):
*   Apura saldo inicial + linhas do demonstrativo via SigCdFcx, SigOpCfe,
*   SigCdDpr, SigCdFes, SigMvEst, SigMvHst, SigCdCli.
*==============================================================================

DEFINE CLASS FormSigReDdp AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=300)
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
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria SigReDdpBO (pula SQL inicial em modo UI)
    *   3. Monta cabecalho escuro + botoes do relatorio + campos FLAT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Demonstrativo de Balan" + CHR(231) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SigReDdpBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReDdpBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente a cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- Campos de filtro FLAT (posicoes exatas do original)
                THIS.ConfigurarCampos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Vincular KeyPress do campo Demonstrativo (F4=busca, Enter/Tab=valida)
                BINDEVENT(THIS.txt_4c_Demonstrativo, ;
                          "KeyPress", THIS, "TxtDemonstrativoKeyPress")

                *-- Vincular Click dos botoes de relatorio
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Valores iniciais dos campos de filtro
                THIS.LimparCampos()

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
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura = Width do form (cobre toda a faixa superior).
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

            *-- Sombra (deslocada 2px para efeito 3D do texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Demonstrativo de Balan" + CHR(231) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Demonstrativo de Balan" + CHR(231) + "o"
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
    * ConfigurarBotoes - CommandGroup de botoes de relatorio (btnReport area)
    *   Original: btnReport.Top=3, Left=526, Width~273, Height=80
    *   Botoes: Visualiza(6), Imprime(72), DocExcel(138), Sair(204)
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
    * ConfigurarCampos - Adiciona controles de filtro DIRETAMENTE no form
    *   Posicoes EXATAS do original (Top/Left relativos ao form):
    *     Say4 (Tipo):          Top=149, Left=301
    *     Get_Demonstrativo:    Top=144, Left=336, Width=154, Height=25
    *     lbl_vencimento (Data): Top=174, Left=298, Width=35
    *     get_dt_final:         Top=171, Left=336, Width=80, Height=25
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()

        *-- Label "Tipo : " (Say4 original: Top=149, Left=301)
        THIS.AddObject("lbl_4c_Say4", "Label")
        WITH THIS.lbl_4c_Say4
            .Top       = 149
            .Left      = 301
            .Width     = 35
            .Height    = 17
            .Caption   = "Tipo : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Demonstrativo (Get_Demonstrativo: Top=144, Left=336, Width=154, Height=25)
        THIS.AddObject("txt_4c_Demonstrativo", "TextBox")
        WITH THIS.txt_4c_Demonstrativo
            .Top         = 144
            .Left        = 336
            .Width       = 154
            .Height      = 25
            .Value       = ""
            .MaxLength   = 20
            .Format      = "K"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .ToolTipText = "Nome do Demonstrativo (F4 = busca)"
            .Visible     = .T.
        ENDWITH

        *-- Label "Data : " (lbl_vencimento: Top=174, Left=298, Width=35)
        THIS.AddObject("lbl_4c_LblData", "Label")
        WITH THIS.lbl_4c_LblData
            .Top       = 174
            .Left      = 298
            .Width     = 35
            .Height    = 17
            .Caption   = "Data : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Data final (get_dt_final: Top=171, Left=336, Width=80, Height=25)
        THIS.AddObject("txt_4c_DtFinal", "TextBox")
        WITH THIS.txt_4c_DtFinal
            .Top         = 171
            .Left        = 336
            .Width       = 80
            .Height      = 25
            .Value       = {}
            .MaxLength   = 10
            .Format      = "D"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Define valores iniciais dos campos de filtro
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.txt_4c_Demonstrativo) = "O"
            THIS.txt_4c_Demonstrativo.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_DtFinal) = "O"
            THIS.txt_4c_DtFinal.Value = DATE()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere filtros do form para o BO antes de imprimir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        WITH THIS.this_oRelatorio
            .this_cNome    = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
            .this_dDtFinal = THIS.txt_4c_DtFinal.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios antes de processar relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        IF EMPTY(ALLTRIM(THIS.txt_4c_Demonstrativo.Value))
            MsgAviso("Nome do Demonstrativo Inv" + CHR(225) + "lido!!!", "Aviso")
            THIS.txt_4c_Demonstrativo.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.txt_4c_DtFinal.Value)
            MsgAviso("Data Inv" + CHR(225) + "lida!!!", "Aviso")
            THIS.txt_4c_DtFinal.SetFocus()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDemonstrativo - Abre FormBuscaAuxiliar para SigPrDmo.Nome
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDemonstrativo()
        LOCAL loc_oForm, loc_oErro
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                                     gnConnHandle, ;
                                     "SigPrDmo", ;
                                     "cursor_4c_BuscaDmo", ;
                                     "Nome", ;
                                     ALLTRIM(THIS.txt_4c_Demonstrativo.Value), ;
                                     "Selecionar Demonstrativo")
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaDmo")
                        SELECT cursor_4c_BuscaDmo
                        IF !EOF()
                            THIS.txt_4c_Demonstrativo.Value = ALLTRIM(cursor_4c_BuscaDmo.Nome)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("Nome", "", "Demonstrativo")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou
                        IF USED("cursor_4c_BuscaDmo")
                            SELECT cursor_4c_BuscaDmo
                            IF !EOF()
                                THIS.txt_4c_Demonstrativo.Value = ALLTRIM(cursor_4c_BuscaDmo.Nome)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaDmo")
                    USE IN cursor_4c_BuscaDmo
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDemonstrativo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDemonstrativoKeyPress - Handler de KeyPress para txt_4c_Demonstrativo
    *   F4(115): abre busca direto
    *   Enter(13) / Tab(9): valida valor digitado contra SigPrDmo
    *--------------------------------------------------------------------------
    PROCEDURE TxtDemonstrativoKeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDemonstrativo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor, loc_cSQL, loc_nResult
            loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
            IF EMPTY(loc_cValor)
                RETURN
            ENDIF
            loc_cSQL = "SELECT Nome FROM SigPrDmo " + ;
                       "WHERE Nome = " + EscaparSQL(loc_cValor)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DmoVal")
            IF loc_nResult > 0
                SELECT cursor_4c_DmoVal
                IF EOF()
                    IF USED("cursor_4c_DmoVal")
                        USE IN cursor_4c_DmoVal
                    ENDIF
                    THIS.AbrirBuscaDemonstrativo()
                ELSE
                    THIS.txt_4c_Demonstrativo.Value = ALLTRIM(cursor_4c_DmoVal.Nome)
                    IF USED("cursor_4c_DmoVal")
                        USE IN cursor_4c_DmoVal
                    ENDIF
                ENDIF
            ELSE
                IF USED("cursor_4c_DmoVal")
                    USE IN cursor_4c_DmoVal
                ENDIF
                THIS.AbrirBuscaDemonstrativo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Valida filtros e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Valida filtros e imprime relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Visualiza relatorio (Excel nao disponivel para este layout)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias semantico CRUD para FormParaRelatorio
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega filtros do BO de volta para os campos do form
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oRelatorio
            THIS.txt_4c_Demonstrativo.Value = ALLTRIM(.this_cNome)
            IF EMPTY(.this_dDtFinal)
                THIS.txt_4c_DtFinal.Value = DATE()
            ELSE
                THIS.txt_4c_DtFinal.Value = .this_dDtFinal
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Reinicializa estado dos filtros do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF VARTYPE(THIS.this_oRelatorio) = "O" ;
                AND !EMPTY(THIS.this_oRelatorio.this_cNome)
            THIS.BOParaForm()
        ELSE
            THIS.LimparCampos()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias semantico CRUD para BtnVisualizarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Alias semantico CRUD para BtnSairClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o BO e delega limpeza para FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
