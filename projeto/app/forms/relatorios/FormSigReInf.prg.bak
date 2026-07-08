*==============================================================================
* FORMSIGREINF.PRG
* Impress" + CHR(227) + "o de Nota Fiscal
* Tipo: RELATORIO OPERACIONAL (recebe par" + CHR(226) + "metros via Init, sem filtros)
* Migrado de: SigReInf.SCX (frmrelatorio)
*
* Par" + CHR(226) + "metros Init: par_cEmps, par_cDopes, par_nNumes, par_cSerie
* Layout FLAT: sem PageFrame (form h=130, apenas cabe" + CHR(231) + "alho + bot" + CHR(245) + "es)
* Bot" + CHR(245) + "es: Visualizar, Imprimir, Excel(desabilitado), Encerrar
* Ao Imprimir: BO.Imprimir() -> libera form (mesmo comportamento do original)
* Ao Visualizar: BO.Visualizar() -> form permanece aberto
* DocExcel: sempre desabilitado (lacexcel=.F. no original)
*==============================================================================

DEFINE CLASS FormSigReInf AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=130)
    Height      = 130
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio e estado de erro
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Par" + CHR(226) + "metros recebidos no Init (armazenados antes de InicializarForm ser chamado)
    this_cEmps  = ""
    this_cDopes = ""
    this_nNumes = 0
    this_cSerie = ""

    *--------------------------------------------------------------------------
    * Init - Salva par" + CHR(226) + "metros e delega para FormBase.Init()
    *   FormBase.Init() chama THIS.InicializarForm() automaticamente.
    *   Par" + CHR(226) + "metros devem ser salvos ANTES do DODEFAULT() pois InicializarForm()
    *   j" + CHR(225) + " os usa para configurar o BO.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_cSerie)
        THIS.this_cEmps  = ""
        THIS.this_cDopes = ""
        THIS.this_nNumes = 0
        THIS.this_cSerie = ""

        IF PCOUNT() >= 1 AND VARTYPE(par_cEmps) = "C"
            THIS.this_cEmps = par_cEmps
        ENDIF
        IF PCOUNT() >= 2 AND VARTYPE(par_cDopes) = "C"
            THIS.this_cDopes = par_cDopes
        ENDIF
        IF PCOUNT() >= 3 AND VARTYPE(par_nNumes) = "N"
            THIS.this_nNumes = par_nNumes
        ENDIF
        IF PCOUNT() >= 4 AND VARTYPE(par_cSerie) = "C"
            THIS.this_cSerie = par_cSerie
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta estrutura do form: BO + cabe" + CHR(231) + "alho + bot" + CHR(245) + "es
    *   Layout FLAT (sem PageFrame): apenas cnt_4c_Cabecalho + cmg_4c_Botoes.
    *   Ap" + CHR(243) + "s criar visual, vincula eventos e ajusta estados dos bot" + CHR(245) + "es.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Impress" + CHR(227) + "o de Nota Fiscal"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Criar BO
            THIS.this_oRelatorio = CREATEOBJECT("SigReInfBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReInfBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Transfere par" + CHR(226) + "metros do form para o BO
                THIS.this_oRelatorio.this_cEmps  = THIS.this_cEmps
                THIS.this_oRelatorio.this_cDopes = THIS.this_cDopes
                THIS.this_oRelatorio.this_nNumes = THIS.this_nNumes
                THIS.this_oRelatorio.this_cSerie = THIS.this_cSerie

                *-- Carrega configura" + CHR(231) + CHR(245) + "es (SigCdPam -> habilita bot" + CHR(245) + "es)
                *   Pula se estiver em modo de valida" + CHR(231) + CHR(227) + "o de UI (sem conex" + CHR(227) + "o SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !THIS.this_oRelatorio.CarregarConfiguracoes()
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Estrutura visual: cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es de relat" + CHR(243) + "rio
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()

                *-- Atualiza captions dos labels do cabe" + CHR(231) + "alho
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Vincula eventos dos bot" + CHR(245) + "es (BINDEVENT s" + CHR(243) + " em m" + CHR(233) + "todos PUBLIC)
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Aplica estado dos bot" + CHR(245) + "es conforme flags carregadas do BO
                THIS.AjustarBotoesPorModo()

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
    * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo do form
    *   Equivalente ao cntSombra do frmrelatorio legado (Top=0, full-width).
    *   Largura = Width do form para cobrir toda a faixa superior.
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

            *-- Sombra (deslocada 2px para efeito de profundidade no texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o de Nota Fiscal"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- T" + CHR(237) + "tulo branco (sobre a sombra preta)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o de Nota Fiscal"
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
    * ConfigurarBotoes - CommandGroup com 4 bot" + CHR(245) + "es de relat" + CHR(243) + "rio
    *   Equivalente ao btnReport do frmrelatorio legado.
    *   Posicionado no lado direito, sobrepondo o cabe" + CHR(231) + "alho (Background).
    *   Bot" + CHR(227) + "o(3) DocExcel: sempre desabilitado (lacexcel=.F. no original).
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

            *-- Bot" + CHR(227) + "o 1: Visualizar (preview na tela)
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
                .ToolTipText     = "Visualizar Nota Fiscal"
                .Themes          = .F.
                .Enabled         = .F.
                .Visible         = .T.
            ENDWITH

            *-- Bot" + CHR(227) + "o 2: Imprimir (impressora - fecha form ap" + CHR(243) + "s imprimir)
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
                .ToolTipText     = "Imprimir Nota Fiscal"
                .Themes          = .F.
                .Enabled         = .F.
                .Visible         = .T.
            ENDWITH

            *-- Bot" + CHR(227) + "o 3: DocExcel - sempre desabilitado (lacexcel=.F. no original)
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
                .Enabled         = .F.
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Bot" + CHR(227) + "o 4: Encerrar (ESC fecha o form)
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
    * AjustarBotoesPorModo - Habilita bot" + CHR(245) + "es conforme flags do BO
    *   Visualizar: somente se BO.this_lVisualizarHabilitado (SigCdPam == 999)
    *   Imprimir:   somente se BO.this_lImprimirHabilitado (sempre .T. no BO)
    *   Excel:      sempre desabilitado (lacexcel=.F. no original)
    *   Encerrar:   sempre habilitado
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lVisualizar, loc_lImprimir
        TRY
            loc_lVisualizar = .F.
            loc_lImprimir   = .F.

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_lVisualizar = THIS.this_oRelatorio.this_lVisualizarHabilitado
                loc_lImprimir   = THIS.this_oRelatorio.this_lImprimirHabilitado
            ENDIF

            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lVisualizar
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lImprimir
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .F.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview da NF na tela
    *   Equivalente ao procedure 'visualizacao' do original (modo "V").
    *   Form permanece aberto ap" + CHR(243) + "s visualizar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lExecutar
        loc_lExecutar = VARTYPE(THIS.this_oRelatorio) = "O"
        TRY
            IF loc_lExecutar
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Impressao direta da NF; fecha o form ap" + CHR(243) + "s imprimir
    *   Equivalente ao procedure 'impressao' do original (modo "I" + Release).
    *   THIS.Release() chamado FORA do TRY (regra VFP9: sem RETURN em TRY)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lOk
        loc_lOk = .F.
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_lOk = THIS.this_oRelatorio.Imprimir()
                IF !loc_lOk
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        IF loc_lOk
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * M" + CHR(233) + "TODOS DE COMPATIBILIDADE COM O PIPELINE FORMBASE
    * Este form n" + CHR(227) + "o usa opera" + CHR(231) + CHR(245) + "es CRUD nem filtros; m" + CHR(233) + "todos abaixo
    * existem para satisfazer contratos do FormBase sem quebrar inicializa" + CHR(231) + CHR(227) + "o.
    *==========================================================================

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Stub de compatibilidade (REPORT layout FLAT)
    *   Este form herda de FormBase mas usa layout FLAT (h=130px) sem PageFrame.
    *   A inicializa" + CHR(231) + CHR(227) + "o visual eh feita por ConfigurarCabecalho() + ConfigurarBotoes().
    *   M" + CHR(233) + "todo existe apenas para satisfazer o contrato do pipeline de migra" + CHR(231) + CHR(227) + "o.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Stub de compatibilidade (REPORT sem p" + CHR(225) + "gina lista)
    *   Forms REPORT usam layout FLAT; n" + CHR(227) + "o h" + CHR(225) + " Page1 de lista nem Grid CRUD.
    *   M" + CHR(233) + "todo existe para satisfazer contrato do pipeline de migra" + CHR(231) + CHR(227) + "o.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Stub de compatibilidade (REPORT layout FLAT)
    *   SigReInf eh form operacional FLAT (h=130px): sem Page2, sem campos de
    *   entrada. Todos os dados chegam via Init (par_cEmps/par_cDopes/etc.).
    *   Stub existe para satisfazer contrato do pipeline de migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROCEDURE FormParaRelatorio()
        RETURN
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        RETURN
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    PROCEDURE LimparCampos()
        RETURN
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    PROCEDURE BtnIncluirClick()
        RETURN
    ENDPROC

    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera refer" + CHR(234) + "ncia ao BO (NUNCA chamar .Release em Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
