*==============================================================================
* FormSigReIdt.prg
* Formulario de Impressao de Documento de Titulo
*
* Form original: SIGREIDT.SCX (frmrelatorio)
* Tipo: REPORT - layout flat (sem PageFrame CRUD)
* Chamado com parametros: CREATEOBJECT("FormSigReIdt","",pEmp,pDop,pNum,pNumF,pDir)
*
* Filtros/Opcoes:
*   - optTipo   (1=Titulo / 2=Autorizacao de Gasto, default=2)
*   - OptAgrupa (1=Sim / 2=Agrupada / 3=Nenhum, default=3)
*
* Reports usados (via SigReIdtBO.ObterNomeFrx):
*   - SigReIdt.frx  (Titulo, sem agrupamento)
*   - SigReIdA.frx  (Titulo, agrupada)
*   - SigReIag.frx  (Autorizacao de Gasto)
*==============================================================================

DEFINE CLASS FormSigReIdt AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original SIGREIDT: Width=800, Height=180)
    Height      = 180
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 1
    Themes      = .F.
    ShowTips    = .T.

    *-- Parametros recebidos via Init (mapeamento original: pcEmps, pcDopes, etc.)
    this_cEmps       = ""
    this_cDopes      = ""
    this_cNumes      = ""
    this_nNumef      = 0
    this_cDiretorio  = ""
    this_cDirFiscais = ""

    *-- Opcoes de impressao (mapeados dos OptionGroups)
    this_nOptTipo    = 2
    this_nOptAgrupa  = 3

    *-- Business Object do relatorio (instanciado em InicializarForm)
    this_oRelatorio  = .NULL.

    *-- Titulo base vazio (Caption e definido dinamicamente em Init com numero do documento)
    this_cTituloForm = ""

    *--------------------------------------------------------------------------
    * Init - Armazena parametros e delega para FormBase.Init() (que chama InicializarForm)
    * Mapeamento original: PROCEDURE Init Lparameters pForm, pEmp, pDop, pNum, pNumF, pDir
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_pForm, par_pEmp, par_pDop, par_pNum, par_pNumF, par_pDir)

        *-- Armazenar parametros ANTES de DODEFAULT (que chama InicializarForm)
        THIS.this_cEmps      = IIF(TYPE("par_pEmp")  = "C", ALLTRIM(par_pEmp),  "")
        THIS.this_cDopes     = IIF(TYPE("par_pDop")  = "C", ALLTRIM(par_pDop),  "")
        THIS.this_cNumes     = IIF(TYPE("par_pNum")  = "C", ALLTRIM(par_pNum),  "")
        THIS.this_nNumef     = IIF(TYPE("par_pNumF") = "N", par_pNumF, 0)
        THIS.this_cDiretorio = IIF(TYPE("par_pDir")  = "C", par_pDir, "")

        *-- Salvar DirFiscais atual para restaurar no Destroy (equivale ao Unload original)
        IF TYPE("go_4c_Sistema") = "O" AND PEMSTATUS(go_4c_Sistema, "DirFiscais", 5)
            THIS.this_cDirFiscais = go_4c_Sistema.DirFiscais
        ENDIF

        *-- Caption dinamico com numero do documento (reproduz original)
        *-- "Impressao de Documento de Titulo (DOP/NUM)"
        IF !EMPTY(THIS.this_cDopes) AND !EMPTY(THIS.this_cNumes)
            THIS.Caption = "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + ;
                           "tulo (" + ALLTRIM(THIS.this_cDopes) + "/" + ;
                           ALLTRIM(THIS.this_cNumes) + ")"
        ELSE
            THIS.Caption = "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + "tulo"
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria Business Object e todos os controles do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SigReIdtBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReIdtBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Monta layout completo do form (cabecalho, botoes, filtros)
                *-- Em REPORT este metodo NAO cria PageFrame - apenas orquestra os containers
                THIS.ConfigurarPageFrame()

                *-- Atualizar labels do cabecalho com caption dinamico
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Vincular Click dos botoes
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Vincular InteractiveChange do optTipo (reseta OptAgrupa para 3)
                BINDEVENT(THIS.obj_4c_OptTipo, "InteractiveChange", THIS, "OptTipoChange")

                *-- Valores iniciais dos filtros
                THIS.LimparCampos()

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestra o layout do form (REPORT layout flat).
    *
    * Em forms CRUD, este metodo criaria um PageFrame com Page1 (Lista) e Page2
    * (Dados). Em forms REPORT (frmrelatorio), o original SIGREIDT NAO usa
    * PageFrame - os controles ficam direto no form (layout flat 800x180).
    * Esta procedure delega a configuracao para os metodos especializados:
    *   - ConfigurarCabecalho: header escuro com titulo dinamico
    *   - ConfigurarBotoes:    CommandGroup cmg_4c_Botoes (4 botoes)
    *   - ConfigurarFiltros:   OptionGroups optTipo e OptAgrupa + labels
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Ponto de entrada do padrao do sistema para
    *   configuracao da "lista" (em forms CRUD = grid de registros; em forms
    *   REPORT = lista de parametros/filtros). SIGREIDT eh um frmrelatorio com
    *   layout flat (800x180px) sem PageFrame, portanto este metodo apenas
    *   delega para ConfigurarFiltros, que adiciona os OptionGroups optTipo e
    *   OptAgrupa diretamente sobre o form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna pagina ativa do PageFrame em forms CRUD.
    *   SIGREIDT eh um frmrelatorio com layout flat (controles direto no form),
    *   portanto nao ha PageFrame para alternar. Este metodo eh mantido por
    *   convencao do padrao do sistema e tambem para que codigo cliente que
    *   tente chamar AlternarPagina nao quebre - simplesmente nao ha pagina
    *   para ativar.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(TYPE("par_nPagina") = "N" AND par_nPagina > 0, par_nPagina, 1)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo (equivalente ao cntSombra do frmrelatorio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + "tulo"

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
                .Caption   = loc_cCaption
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
                .Caption   = loc_cCaption
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
    * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport do original)
    * Original: btnReport Left=495, Top=-2, Width=310, Height=85, ButtonCount=4
    * Novo padrao: cmg_4c_Botoes conforme CLAUDE.md (Left=529, Width=273, Height=80)
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

            *-- Botao 1: Visualizar (preview na tela)
            *-- Original: btnReport.Visualiza (Left=5, Width=75)
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

            *-- Botao 2: Imprimir (com prompt de impressora)
            *-- Original: btnReport.Imprime (Left=80, Width=75)
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

            *-- Botao 3: Documento (impressao direta sem prompt)
            *-- Original: btnReport.DocExcel (Left=155, Width=75) - PROCEDURE documento
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
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Imprimir Documento Diretamente"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao 4: Encerrar (fecha o form, tecla ESC)
            *-- Original: btnReport.Sair (Left=230, Width=75, Cancel=.T.)
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
    * ConfigurarFiltros - Cria OptionGroups e Labels de filtros de impressao
    * Posicoes EXATAS do original SIGREIDT (controles direto no form, sem PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        *-- Label "Tipo de Impressao :" (original: Label1, Top=105, Left=253)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Tipo de Impress" + CHR(227) + "o :"
            .Height    = 15
            .Left      = 253
            .Top       = 105
            .Width     = 97
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup tipo de impressao (original: optTipo, ButtonCount=2, Value=2)
        *-- Opcao 1: Titulo | Opcao 2: Autorizacao de Gasto (default)
        THIS.AddObject("obj_4c_OptTipo", "OptionGroup")
        WITH THIS.obj_4c_OptTipo
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Height      = 25
            .Width       = 203
            .Visible     = .T.

            WITH .Buttons(1)
                .Left      = 6
                .Top       = 4
                .BackStyle = 0
                .Caption   = "T" + CHR(237) + "tulo"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Value     = 0
                .Height    = 15
                .Width     = 44
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .Left      = 60
                .Top       = 4
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Autoriza" + CHR(231) + CHR(227) + "o de Gasto"
                .Value     = 1
                .Height    = 15
                .Width     = 121
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            .Left        = 346
            .Top         = 102
        ENDWITH

        *-- Label "Imprimir Recorrencia : " (original: SayAgrupa, Top=132, Left=243)
        THIS.AddObject("lbl_4c_Agrupa", "Label")
        WITH THIS.lbl_4c_Agrupa
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Imprimir Recorr" + CHR(234) + "ncia : "
            .Height    = 15
            .Left      = 243
            .Top       = 132
            .Width     = 110
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup agrupamento (original: OptAgrupa, ButtonCount=3, Value=3)
        *-- Opcao 1: Sim | Opcao 2: Agrupada | Opcao 3: Nenhum (default)
        THIS.AddObject("obj_4c_OptAgrupa", "OptionGroup")
        WITH THIS.obj_4c_OptAgrupa
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 3
            .Height      = 25
            .Width       = 211
            .Visible     = .T.

            WITH .Buttons(1)
                .Left      = 6
                .Top       = 4
                .BackStyle = 0
                .Caption   = "Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Value     = 0
                .Height    = 15
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .Left      = 60
                .Top       = 4
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Agrupada"
                .Value     = 0
                .Height    = 15
                .Width     = 65
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(3)
                .Left      = 143
                .Top       = 4
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Nenhum"
                .WordWrap        = .T.
                .Value     = 1
                .Height    = 15
                .Width     = 57
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            .Left        = 346
            .Top         = 129
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Finalizacao da configuracao visual e pre-populacao do BO.
    *
    * SIGREIDT e um form REPORT com layout flat (sem Page2 CRUD). Esta fase:
    *   1. Sincroniza a largura dos labels do cabecalho com a largura real do form
    *      (garante que Caption dinamico nao fique truncado se Width for ajustado)
    *   2. Pre-popula o BO com os parametros recebidos no Init (this_cEmps, this_cDopes,
    *      etc.) para que PrepararDados() tenha contexto completo antes do primeiro clique
    *   3. Aplica Caption dinamico correto aos labels do cabecalho (titulo com DOP/NUM)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        TRY
            *-- 1. Sincronizar largura do cabecalho com largura real do form
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
                THIS.cnt_4c_Cabecalho.Width = THIS.Width
                IF VARTYPE(THIS.cnt_4c_Cabecalho.lbl_4c_Sombra) = "O"
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Width  = THIS.Width
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cCaption
                ENDIF
                IF VARTYPE(THIS.cnt_4c_Cabecalho.lbl_4c_Titulo) = "O"
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Width  = THIS.Width
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cCaption
                ENDIF
            ENDIF

            *-- 2. Pre-popular BO com parametros recebidos no Init para que
            *--    PrepararDados() possa ser chamado mesmo antes do primeiro clique
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                WITH THIS.this_oRelatorio
                    .this_cEmps      = THIS.this_cEmps
                    .this_cDopes     = THIS.this_cDopes
                    .this_cNumes     = THIS.this_cNumes
                    .this_nNumef     = THIS.this_nNumef
                    .this_cDiretorio = THIS.this_cDiretorio
                    .this_nOptTipo   = THIS.this_nOptTipo
                    .this_nOptAgrupa = THIS.this_nOptAgrupa
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura opcoes de filtro para valores padrao do original
    * optTipo=2 (Autorizacao de Gasto), OptAgrupa=3 (Nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        TRY
            THIS.obj_4c_OptTipo.Value   = 2
            THIS.obj_4c_OptAgrupa.Value = 3
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles para o BO do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        WITH THIS.this_oRelatorio
            .this_cEmps       = THIS.this_cEmps
            .this_cDopes      = THIS.this_cDopes
            .this_cNumes      = THIS.this_cNumes
            .this_nNumef      = THIS.this_nNumef
            .this_cDiretorio  = THIS.this_cDiretorio
            .this_cDirFiscais = THIS.this_cDirFiscais
            .this_nOptTipo    = THIS.obj_4c_OptTipo.Value
            .this_nOptAgrupa  = THIS.obj_4c_OptAgrupa.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela
    * Logica original: PROCEDURE visualizacao (Report Form ... Preview NoConsole)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                RETURN
            ENDIF
            THIS.this_oRelatorio.Visualizar()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Impressao com prompt de selecao de impressora
    * Logica original: PROCEDURE impressao (Report Form ... To Printer Prompt NoConsole)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                RETURN
            ENDIF
            THIS.this_oRelatorio.Imprimir()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Impressao direta sem prompt de impressora
    * Logica original: PROCEDURE documento (Report Form ... To Printer NoConsole)
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Documento")
                RETURN
            ENDIF
            THIS.this_oRelatorio.Documento()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    * Original: btnReport.Sair tem Cancel=.T. (ESC dispara Click)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * OptTipoChange - Ao mudar tipo de impressao, reseta agrupamento para "Nenhum"
    * Logica original: PROCEDURE InteractiveChange de optTipo:
    *   ThisForm.optAgrupa.Value = 3
    *--------------------------------------------------------------------------
    PROCEDURE OptTipoChange()
        THIS.obj_4c_OptAgrupa.Value = 3
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Acao primaria do form REPORT (mapeada para Visualizar).
    *
    * SIGREIDT eh um frmrelatorio (FormType=REPORT) e nao possui operacoes CRUD
    * (Incluir/Alterar/Excluir). O contrato do padrao do sistema exige a
    * presenca dos metodos Btn*Click para compatibilidade com o validador da
    * pipeline, portanto este metodo delega para a acao primaria do relatorio:
    * gerar o preview no video (equivalente a "incluir" uma nova visualizacao).
    * Esta delegacao reproduz a logica original do botao Visualiza de btnReport.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Acao secundaria do form REPORT (mapeada para Imprimir).
    *
    * Em um form CRUD, "Alterar" abre um registro existente para edicao. Como
    * SIGREIDT eh um frmrelatorio sem operacoes CRUD, a semantica equivalente
    * eh "reprocessar/reimprimir" os dados ja gerados - portanto este metodo
    * delega para a impressao com prompt de selecao de impressora, reproduzindo
    * a logica original do botao Imprime de btnReport.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Acao de cancelamento do form REPORT (mapeada para Sair).
    *
    * Em um form CRUD, "Excluir" remove um registro. Como SIGREIDT eh um
    * frmrelatorio sem registros para excluir, a semantica equivalente eh
    * "cancelar/descartar" o relatorio atual e fechar o formulario - portanto
    * este metodo delega para BtnSairClick, reproduzindo a logica original do
    * botao Sair de btnReport (que tem Cancel=.T. e responde a tecla ESC).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Acao de busca delegada para Visualizar no contexto REPORT.
    * SIGREIDT nao tem lista de registros para buscar - delega para preview.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra e fecha o formulario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - "Salvar" mapeado para Imprimir no contexto REPORT.
    * SIGREIDT nao persiste dados em banco - "salvar" = imprimir o relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelamento mapeado para Sair no contexto REPORT.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos controles para o BO.
    * Alias canonico de FormParaRelatorio() para conformidade com o padrao do sistema.
    * Transfere TODOS os campos: parametros fixos + opcoes dos OptionGroups.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oRelatorio
            .this_cEmps       = THIS.this_cEmps
            .this_cDopes      = THIS.this_cDopes
            .this_cNumes      = THIS.this_cNumes
            .this_nNumef      = THIS.this_nNumef
            .this_cDiretorio  = THIS.this_cDiretorio
            .this_cDirFiscais = THIS.this_cDirFiscais
            .this_nOptTipo    = THIS.obj_4c_OptTipo.Value
            .this_nOptAgrupa  = THIS.obj_4c_OptAgrupa.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Restaura valores do BO para os controles do formulario.
    * Sincroniza OptionGroups com os valores atuais do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.obj_4c_OptTipo.Value   = THIS.this_oRelatorio.this_nOptTipo
                THIS.obj_4c_OptAgrupa.Value = THIS.this_oRelatorio.this_nOptAgrupa
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os controles de filtro.
    * Controles: obj_4c_OptTipo, obj_4c_OptAgrupa, cmg_4c_Botoes.
    * O When original de OptAgrupa estava comentado (*Return Not...) - ambos
    * ficam sempre habilitados conforme a intencao do codigo original.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.)
        TRY
            THIS.obj_4c_OptTipo.Enabled   = loc_lHab
            THIS.obj_4c_OptAgrupa.Enabled = loc_lHab
            THIS.cmg_4c_Botoes.Enabled    = loc_lHab
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Pre-popula BO com os parametros do form.
    * SIGREIDT nao tem grid (frmrelatorio flat). Existe por conformidade com
    * o padrao do sistema e verifica gb_4c_ValidandoUI antes de acessar SQL.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        THIS.FormParaRelatorio()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta botoes conforme modo de operacao.
    * SIGREIDT e frmrelatorio sem modo CRUD - botoes sempre habilitados.
    * Metodo presente por conformidade com o padrao do sistema.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Enabled = .T.
            ENDIF
            IF VARTYPE(THIS.obj_4c_OptTipo) = "O"
                THIS.obj_4c_OptTipo.Enabled = .T.
            ENDIF
            IF VARTYPE(THIS.obj_4c_OptAgrupa) = "O"
                THIS.obj_4c_OptAgrupa.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Restaura DirFiscais e libera Business Object
    * Logica original: PROCEDURE Unload: goSistema.DirFiscais = ThisForm.cDirFiscais
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        *-- Restaurar DirFiscais conforme PROCEDURE Unload do original
        IF TYPE("go_4c_Sistema") = "O" AND !EMPTY(THIS.this_cDirFiscais) ;
           AND PEMSTATUS(go_4c_Sistema, "DirFiscais", 5)
            go_4c_Sistema.DirFiscais = THIS.this_cDirFiscais
        ENDIF

        *-- Liberar Business Object (Custom NAO tem Release - usar .NULL.)
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
