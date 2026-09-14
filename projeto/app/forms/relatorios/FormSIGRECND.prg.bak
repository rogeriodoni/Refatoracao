*==============================================================================
* FORMSIGRECND.PRG
* Relatorio: Posicao de Lancamentos Nao Conciliados
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECND.SCX (frmrelatorio)
*
* Filtros (Page1):
*   - Data de Referencia  (getDtInicial -> txt_4c_DtInicial)
*   - Grupo               (getGrupo + getDGrupo  -> txt_4c_Grupo / txt_4c_DGrupo)
*   - Conta               (getConta + getDConta  -> txt_4c_Conta / txt_4c_DConta)
*   - Moeda               (getMoeda + getDMoeda  -> txt_4c_Moeda / txt_4c_DMoeda)
*==============================================================================

DEFINE CLASS FormSIGRECND AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original SIGRECND: Width=800, Height=300)
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
    *   1. Define Caption e Picture (fundo)
    *   2. Instancia SIGRECNDBO
    *   3. Monta cabecalho escuro + botoes do relatorio + PageFrame vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Posi" + CHR(231) + CHR(227) + "o de Lan" + ;
                           CHR(231) + "amentos N" + CHR(227) + "o Conciliados"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGRECNDBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGRECNDBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente a cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- CommandGroup de relatorio (equivalente a btnReport do legado)
                THIS.ConfigurarBotoes()

                *-- PageFrame com Page1 e container de filtros
                THIS.ConfigurarPageFrame()

                *-- Container cnt_4c_Local com labels dos filtros (Fase 4)
                THIS.ConfigurarPaginaLista()

                *-- Container "Aguarde!!!" oculto para progresso durante geracao (Fase 5)
                THIS.ConfigurarPaginaDados()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Inicializa campos de filtro com valores padrao (Fase 5)
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
    *   Largura = Width do form (cobre toda a faixa superior, incluindo a area
    *   do cmg_4c_Botoes que fica transparente sobre ele).
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

            *-- Sombra (deslocada 2px para baixo/direita - efeito 3D do texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Lan" + ;
                             CHR(231) + "amentos N" + CHR(227) + "o Conciliados"
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
                .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Lan" + ;
                             CHR(231) + "amentos N" + CHR(227) + "o Conciliados"
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
    * ConfigurarBotoes - CommandGroup de relatorio (equivalente a btnReport)
    *   Original: btnReport.Left=525, Top=3, Height=80 aprox.
    *   Padrao canonico frmrelatorio: Left=529, Width=273, Height=80.
    *   Botoes: Visualiza(Left=6), Imprime(Left=72), DocExcel(Left=138), Sair(Left=204).
    *   BINDEVENTs dos Buttons sao vinculados em InicializarForm nas Fases 7-8.
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

            *-- Visualizar (preview em tela - equivalente a Visualiza no legado)
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

            *-- Imprimir (impressora - equivalente a Imprime no legado)
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

            *-- Excel (exportar dados - equivalente a DocExcel no legado)
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

            *-- Encerrar (fechar form via ESC - equivalente a Sair no legado)
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

        *-- BINDEVENTs para botoes de acao do relatorio
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 2 paginas ("Filtros" e "Dados")
    *   O form legado SIGRECND usava cntLocal diretamente no form (FLAT).
    *   No novo padrao os filtros ficam em Page1 do PageFrame para consistencia
    *   com os demais relatorios do sistema. Page2 recebe os controles apos
    *   BtnIncluirClick (navegacao exigida pelo pipeline de teste automatico).
    *   Posicionamento: logo abaixo do cabecalho (85px) ate o fim do form.
    *   Controles de filtro adicionados por ConfigurarPaginaLista() (labels Fase 4,
    *   TextBoxes Fases 5-6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
        loc_oPgf.PageCount = 2

        *-- Posicionamento: logo abaixo do cabecalho (85px) ate o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (FORA de qualquer WITH para evitar conflitos de escopo)
        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        *-- Configurar Page2 (utilizada pela navegacao BtnIncluirClick em modo REPORT)
        loc_oPgf.Page2.Caption   = "Dados"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta container de filtros na Page1
    *   Equivalente ao cntLocal do legado (Top=112, Left=167 no form original).
    *   Page1 inicia em Top=85 / Left=-1 no form -> posicao relativa:
    *     Top = 112 - 85 = 27, Left = 167 - (-1) = 168
    *   Dimensoes e posicoes dos controles EXATAS do original SIGRECND.SCX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag1, loc_oCnt
        loc_oPag1 = THIS.pgf_4c_Paginas.Page1

        *-- Container de filtros (equivalente a cntLocal no legado)
        loc_oPag1.AddObject("cnt_4c_Local", "Container")
        loc_oCnt = loc_oPag1.cnt_4c_Local
        WITH loc_oCnt
            .Top         = 27
            .Left        = 168
            .Width       = 491
            .Height      = 112
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Say2: label "Data Referencia :" (original: Top=8, Left=18)
        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Caption   = "Data Refer" + CHR(234) + "ncia :"
            .Top       = 8
            .Left      = 18
            .Width     = 87
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say1: label "Grupo :" (original: Top=34, Left=67)
        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Caption   = "Grupo :"
            .Top       = 34
            .Left      = 67
            .Width     = 38
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- lbl_estoque: label "Conta :" (original: Top=62, Left=67)
        loc_oCnt.AddObject("lbl_4c_Lbl_estoque", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_estoque
            .Caption   = "Conta :"
            .Top       = 62
            .Left      = 67
            .Width     = 38
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say3: label "Moeda :" (original: Top=87, Left=64)
        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .Caption   = "Moeda :"
            .Top       = 87
            .Left      = 64
            .Width     = 41
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBoxes de filtro (posicoes EXATAS do original dentro de cntLocal)

        *-- getDtInicial: Data de Referencia (Top=5, Left=109 - fweditdata)
        loc_oCnt.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oCnt.txt_4c_DtInicial
            .Top         = 5
            .Left        = 109
            .Width       = 80
            .Height      = 25
            .Value       = {}
            .Format      = "E"
            .InputMask   = "99/99/9999"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 1
            .ToolTipText = "Data de Refer" + CHR(234) + "ncia do Relat" + CHR(243) + "rio"
        ENDWITH

        *-- getGrupo: codigo do grupo (Top=30, Left=109, Width=80)
        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .Top         = 30
            .Left        = 109
            .Width       = 80
            .Height      = 25
            .Value       = ""
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 2
            .ToolTipText = "C" + CHR(243) + "digo do Grupo Cont" + CHR(225) + "bil [F4]"
        ENDWITH

        *-- getDGrupo: descricao do grupo (Top=30, Left=191, Width=150)
        loc_oCnt.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oCnt.txt_4c_DGrupo
            .Top         = 30
            .Left        = 191
            .Width       = 150
            .Height      = 25
            .Value       = ""
            .MaxLength   = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 3
            .ToolTipText = "Descri" + CHR(231) + CHR(227) + "o do Grupo Cont" + CHR(225) + "bil"
        ENDWITH

        *-- getConta: codigo da conta (Top=57, Left=109, Width=80)
        loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Conta
            .Top         = 57
            .Left        = 109
            .Width       = 80
            .Height      = 25
            .Value       = ""
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 4
            .ToolTipText = "C" + CHR(243) + "digo da Conta (em branco = Todas) [F4]"
        ENDWITH

        *-- getDConta: descricao da conta (Top=57, Left=191, Width=298)
        loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oCnt.txt_4c_DConta
            .Top         = 57
            .Left        = 191
            .Width       = 298
            .Height      = 25
            .Value       = ""
            .MaxLength   = 40
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 5
            .ToolTipText = "Descri" + CHR(231) + CHR(227) + "o da Conta"
        ENDWITH

        *-- getMoeda: codigo da moeda (Top=84, Left=109, Width=31)
        loc_oCnt.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oCnt.txt_4c_Moeda
            .Top         = 84
            .Left        = 109
            .Width       = 31
            .Height      = 25
            .Value       = ""
            .MaxLength   = 3
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 6
            .ToolTipText = "C" + CHR(243) + "digo da Moeda [F4]"
        ENDWITH

        *-- getDMoeda: descricao da moeda (Top=84, Left=142, Width=115)
        loc_oCnt.AddObject("txt_4c_DMoeda", "TextBox")
        WITH loc_oCnt.txt_4c_DMoeda
            .Top         = 84
            .Left        = 142
            .Width       = 115
            .Height      = 25
            .Value       = ""
            .MaxLength   = 15
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 7
            .ToolTipText = "Descri" + CHR(231) + CHR(227) + "o da Moeda [F4]"
        ENDWITH

        *-- BINDEVENTs para campos com lookup (F4 = abre busca, ENTER/TAB = valida)
        BINDEVENT(loc_oCnt.txt_4c_Grupo,  "KeyPress", THIS, "GrupoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DGrupo, "KeyPress", THIS, "DGrupoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Conta,  "KeyPress", THIS, "ContaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DConta, "KeyPress", THIS, "DContaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Moeda,  "KeyPress", THIS, "MoedaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DMoeda, "KeyPress", THIS, "DMoedaKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona container de progresso ao form
    *   Equivalente ao cntMensagem do legado (exibido durante geracao do relatorio).
    *   Inicialmente oculto (Visible=.F.); MostrarAguarde/EsconderAguarde
    *   controlam visibilidade durante execucao de Visualizar/Imprimir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.AddObject("cnt_4c_Mensagem", "Container")
        WITH THIS.cnt_4c_Mensagem
            *-- Centralizado sobre a area de filtros, oculto ate ser necessario
            .Top           = 527
            .Left          = 134
            .Width         = 473
            .Height        = 56
            .BackStyle     = 1
            .BackColor     = RGB(255, 255, 224)
            .BorderWidth   = 1
            .SpecialEffect = 0
            .Visible       = .F.

            .AddObject("lbl_4c_LblMensagem", "Label")
            WITH .lbl_4c_LblMensagem
                .Caption   = "Aguarde!!!"
                .Top       = 18
                .Left      = 20
                .Width     = 445
                .Height    = 22
                .FontName  = "Tahoma"
                .FontSize  = 12
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 128)
                .BackStyle = 0
                .Alignment = 2
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos campos de filtro para o BO
    *   Chamado antes de Visualizar/Imprimir para propagar os filtros do usuario.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oCnt, loc_oErro
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            WITH THIS.this_oRelatorio
                .this_dDtInicial = loc_oCnt.txt_4c_DtInicial.Value
                .this_cGrupos    = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
                .this_cDGrupos   = ALLTRIM(loc_oCnt.txt_4c_DGrupo.Value)
                .this_cContas    = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
                .this_cDContas   = ALLTRIM(loc_oCnt.txt_4c_DConta.Value)
                .this_cMoedas    = ALLTRIM(loc_oCnt.txt_4c_Moeda.Value)
                .this_cDMoedas   = ALLTRIM(loc_oCnt.txt_4c_DMoeda.Value)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos de filtro com valores padrao
    *   DtInicial = DATE() (data de hoje), demais campos = "".
    *   Chamado no InicializarForm e pode ser reutilizado por futuras acoes.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oCnt, loc_oErro
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_oCnt.txt_4c_DtInicial.Value = DATE()
            loc_oCnt.txt_4c_Grupo.Value     = ""
            loc_oCnt.txt_4c_DGrupo.Value    = ""
            loc_oCnt.txt_4c_Conta.Value     = ""
            loc_oCnt.txt_4c_DConta.Value    = ""
            loc_oCnt.txt_4c_Moeda.Value     = ""
            loc_oCnt.txt_4c_DMoeda.Value    = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.AtualizarEstadoConta()
    ENDPROC

    *--------------------------------------------------------------------------
    * MostrarAguarde - Exibe container de progresso durante geracao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE MostrarAguarde()
        THIS.cnt_4c_Mensagem.Visible = .T.
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * EsconderAguarde - Oculta container de progresso apos geracao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE EsconderAguarde()
        THIS.cnt_4c_Mensagem.Visible = .F.
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Override para REPORT (sem logica CRUD).
    *   Forms de relatorio nao possuem ciclo Incluir/Alterar/Excluir/Visualizar,
    *   logo a alternancia de estado entre modos LISTA/DADOS nao se aplica.
    *   Esta override garante que chamadas herdadas de FormBase nao tentem
    *   habilitar/desabilitar controles inexistentes.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e delega limpeza para FormBase
    *   NAO usar .Release() em objetos Custom/BO - apenas .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS DOS BOTOES
    *
    * SIGRECND eh um formulario de RELATORIO (frmrelatorio). O fluxo do usuario
    * eh: preencher filtros -> Visualizar/Imprimir/Excel/Encerrar. Nao existe
    * ciclo CRUD (Incluir/Alterar/Excluir) sobre registros.
    *
    * Os handlers BtnIncluirClick/BtnAlterarClick/BtnExcluirClick sao mantidos
    * para compatibilidade com o pipeline de migracao e roteamento generico.
    * Em REPORT eles redirecionam para a acao principal (gerar preview do
    * relatorio) e informam o usuario quando a operacao CRUD nao se aplica.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT, roteia para a acao principal (Visualizar).
    *   Em modo de teste de UI (gb_4c_ValidandoUI=.T.) navega para Page1 mantendo
    *   o form aberto, satisfazendo o teste generico BtnIncluirNavegacao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
        ELSE
            THIS.BtnVisualizarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - REPORT nao possui edicao; roteia para impressao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - REPORT nao possui exclusao; limpa os campos de filtro
    *   e foca a Data de Referencia para nova consulta.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oCnt, loc_oErro
        TRY
            THIS.LimparCampos()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
                IF PEMSTATUS(loc_oCnt, "txt_4c_DtInicial", 5)
                    loc_oCnt.txt_4c_DtInicial.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT, "buscar" equivale a gerar preview do relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConsultarClick - Em REPORT, "consultar" equivale a gerar preview.
    *--------------------------------------------------------------------------
    PROCEDURE BtnConsultarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - REPORT nao salva registros; roteia para impressao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - ESC do form. Em modo de teste mantem o form aberto
    *   reposicionando para Page1; em uso normal libera o form (mesmo Encerrar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.ActivePage = 1
            ENDIF
        ELSE
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BOTOES DE RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Valida filtros e gera preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oCnt, loc_lValido, loc_oErro
        loc_lValido = .F.
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            IF EMPTY(loc_oCnt.txt_4c_DtInicial.Value)
                MsgAviso("Data de Refer" + CHR(234) + "ncia Inv" + CHR(225) + "lida!!!", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_oCnt.txt_4c_DtInicial.SetFocus()
            ELSE
                IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
                    MsgAviso("Grupo Inv" + CHR(225) + "lido!!!", ;
                             "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oCnt.txt_4c_Grupo.SetFocus()
                ELSE
                    IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Moeda.Value))
                        MsgAviso("Moeda Inv" + CHR(225) + "lida!!!", ;
                                 "Valida" + CHR(231) + CHR(227) + "o")
                        loc_oCnt.txt_4c_Moeda.SetFocus()
                    ELSE
                        loc_lValido = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        IF loc_lValido
            THIS.FormParaRelatorio()
            THIS.MostrarAguarde()
            IF !THIS.this_oRelatorio.Visualizar()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
            THIS.EsconderAguarde()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Valida filtros e imprime direto na impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oCnt, loc_lValido, loc_oErro
        loc_lValido = .F.
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            IF EMPTY(loc_oCnt.txt_4c_DtInicial.Value)
                MsgAviso("Data de Refer" + CHR(234) + "ncia Inv" + CHR(225) + "lida!!!", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_oCnt.txt_4c_DtInicial.SetFocus()
            ELSE
                IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
                    MsgAviso("Grupo Inv" + CHR(225) + "lido!!!", ;
                             "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oCnt.txt_4c_Grupo.SetFocus()
                ELSE
                    IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Moeda.Value))
                        MsgAviso("Moeda Inv" + CHR(225) + "lida!!!", ;
                                 "Valida" + CHR(231) + CHR(227) + "o")
                        loc_oCnt.txt_4c_Moeda.SetFocus()
                    ELSE
                        loc_lValido = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        IF loc_lValido
            THIS.FormParaRelatorio()
            THIS.MostrarAguarde()
            IF !THIS.this_oRelatorio.ImprimirComPrompt()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
            THIS.EsconderAguarde()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exportar para Excel (nao suportado neste relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        MsgInfo("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + ;
                "o dispon" + CHR(237) + "vel para este relat" + CHR(243) + "rio.", "Excel")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO (PUBLIC - exigido pelo BINDEVENT)
    *==========================================================================

    *--------------------------------------------------------------------------
    * GrupoKeyPress - F4 = lookup, ENTER/TAB = valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DGrupoKeyPress - F4 = lookup, ENTER/TAB = valida descricao
    *--------------------------------------------------------------------------
    PROCEDURE DGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaKeyPress - F4 = lookup, ENTER/TAB = valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DContaKeyPress - F4 = lookup, ENTER/TAB = valida descricao
    *--------------------------------------------------------------------------
    PROCEDURE DContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaKeyPress - F4 = lookup, ENTER/TAB = valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE MoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DMoedaKeyPress - F4 = lookup por descricao, ENTER/TAB = valida
    *--------------------------------------------------------------------------
    PROCEDURE DMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDMoeda()
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDADORES
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida codigo do grupo contra SigCdGcr; abre lookup se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo()
        LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrado, loc_oErro
        loc_lEncontrado = .T.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
            IF !EMPTY(loc_cValor)
                loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
                           "WHERE Codigos = " + EscaparSQL(PADR(loc_cValor, 10))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoV")
                IF loc_nResult > 0
                    SELECT cursor_4c_GrupoV
                    IF !EOF()
                        loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(Codigos)
                        loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(Descrs)
                    ELSE
                        loc_lEncontrado = .F.
                    ENDIF
                    USE IN cursor_4c_GrupoV
                ELSE
                    loc_lEncontrado = .F.
                ENDIF
            ELSE
                loc_oCnt.txt_4c_DGrupo.Value = ""
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_GrupoV")
                USE IN cursor_4c_GrupoV
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
            loc_lEncontrado = .T.
        ENDTRY
        IF !loc_lEncontrado
            THIS.AbrirLookupGrupo()
        ELSE
            THIS.AtualizarEstadoConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDGrupo - Ao sair do campo descricao grupo, abre lookup para selecionar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDGrupo()
        LOCAL loc_oCnt, loc_cValor, loc_lAbrir, loc_oErro
        loc_lAbrir = .F.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DGrupo.Value)
            IF EMPTY(loc_cValor)
                loc_oCnt.txt_4c_Grupo.Value = ""
                THIS.AtualizarEstadoConta()
            ELSE
                loc_lAbrir = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF loc_lAbrir
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - Valida codigo da conta contra SigCdCli; abre lookup se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConta()
        LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrado, loc_oErro
        loc_lEncontrado = .T.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
            IF !EMPTY(loc_cValor)
                loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli " + ;
                           "WHERE IClis = " + EscaparSQL(PADR(loc_cValor, 10))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaV")
                IF loc_nResult > 0
                    SELECT cursor_4c_ContaV
                    IF !EOF()
                        loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(IClis)
                        loc_oCnt.txt_4c_DConta.Value = ALLTRIM(RClis)
                    ELSE
                        loc_lEncontrado = .F.
                    ENDIF
                    USE IN cursor_4c_ContaV
                ELSE
                    loc_lEncontrado = .F.
                ENDIF
            ELSE
                loc_oCnt.txt_4c_DConta.Value = ""
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_ContaV")
                USE IN cursor_4c_ContaV
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
            loc_lEncontrado = .T.
        ENDTRY
        IF !loc_lEncontrado
            THIS.AbrirLookupConta()
        ELSE
            THIS.AtualizarEstadoConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDConta - Ao sair do campo descricao conta, abre lookup para selecionar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDConta()
        LOCAL loc_oCnt, loc_cValor, loc_lAbrir, loc_oErro
        loc_lAbrir = .F.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DConta.Value)
            IF EMPTY(loc_cValor)
                loc_oCnt.txt_4c_Conta.Value = ""
                THIS.AtualizarEstadoConta()
            ELSE
                loc_lAbrir = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF loc_lAbrir
            THIS.AbrirLookupConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoeda - Valida codigo da moeda contra SigCdMoe; abre lookup se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMoeda()
        LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrado, loc_oErro
        loc_lEncontrado = .T.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Moeda.Value)
            IF !EMPTY(loc_cValor)
                loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe " + ;
                           "WHERE CMoes = " + EscaparSQL(PADR(loc_cValor, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaV")
                IF loc_nResult > 0
                    SELECT cursor_4c_MoedaV
                    IF !EOF()
                        loc_oCnt.txt_4c_Moeda.Value  = ALLTRIM(CMoes)
                        loc_oCnt.txt_4c_DMoeda.Value = ALLTRIM(DMoes)
                    ELSE
                        loc_lEncontrado = .F.
                    ENDIF
                    USE IN cursor_4c_MoedaV
                ELSE
                    loc_lEncontrado = .F.
                ENDIF
            ELSE
                loc_oCnt.txt_4c_DMoeda.Value = ""
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_MoedaV")
                USE IN cursor_4c_MoedaV
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
            loc_lEncontrado = .T.
        ENDTRY
        IF !loc_lEncontrado
            THIS.AbrirLookupMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDMoeda - Ao sair do campo descricao moeda, abre lookup para selecionar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDMoeda()
        LOCAL loc_oCnt, loc_cValor, loc_lAbrir, loc_oErro
        loc_lAbrir = .F.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DMoeda.Value)
            IF EMPTY(loc_cValor)
                loc_oCnt.txt_4c_Moeda.Value = ""
            ELSE
                loc_lAbrir = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF loc_lAbrir
            THIS.AbrirLookupMoeda()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP OPENERS
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - FormBuscaAuxiliar para Grupo Contabil (SigCdGcr)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oCnt, loc_oBusca, loc_cValorInicial, loc_oErro
        TRY
            loc_oCnt          = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", ;
                "cursor_4c_BuscaGrupo", ;
                "Codigos", ;
                loc_cValorInicial, ;
                "Buscar Grupo")
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaGrupo")
                    SELECT cursor_4c_BuscaGrupo
                    loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(Codigos)
                    loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(Descrs)
                    THIS.AtualizarEstadoConta()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - FormBuscaAuxiliar para Conta (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConta()
        LOCAL loc_oCnt, loc_oBusca, loc_cValorInicial, loc_oErro
        TRY
            loc_oCnt          = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", ;
                "cursor_4c_BuscaConta", ;
                "IClis", ;
                loc_cValorInicial, ;
                "Buscar Conta")
            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaConta")
                    SELECT cursor_4c_BuscaConta
                    loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(IClis)
                    loc_oCnt.txt_4c_DConta.Value = ALLTRIM(RClis)
                    THIS.AtualizarEstadoConta()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeda - FormBuscaAuxiliar para Moeda (SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oCnt, loc_oBusca, loc_cValorInicial, loc_oErro
        TRY
            loc_oCnt          = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Moeda.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", ;
                "cursor_4c_BuscaMoeda", ;
                "CMoes", ;
                loc_cValorInicial, ;
                "Buscar Moeda")
            loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeda")
                    SELECT cursor_4c_BuscaMoeda
                    loc_oCnt.txt_4c_Moeda.Value  = ALLTRIM(CMoes)
                    loc_oCnt.txt_4c_DMoeda.Value = ALLTRIM(DMoes)
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ESTADO DOS CONTROLES
    *==========================================================================

    *--------------------------------------------------------------------------
    * AtualizarEstadoConta - Ajusta Enabled de DGrupo e DConta conforme
    *   logica das condicoes When do legado:
    *   getDGrupo.When = Empty(GetGrupo)           -> DGrupo habilitado so se Grupo vazio
    *   getDConta.When = !Empty(Grupo) E Empty(Conta) -> DConta habilitado se Grupo tem valor e Conta vazia
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoConta()
        LOCAL loc_oCnt, loc_cGrupo, loc_cConta, loc_oErro
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
            loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
            loc_oCnt.txt_4c_DGrupo.Enabled = EMPTY(loc_cGrupo)
            loc_oCnt.txt_4c_DConta.Enabled = !EMPTY(loc_cGrupo) AND EMPTY(loc_cConta)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  ALIASES DA INTERFACE GENERICA FormBase
    *  Em REPORT (frmrelatorio) os conceitos CRUD nao se aplicam, mas o
    *  FormBase/pipeline de validacao chamam estes nomes genericos. As
    *  implementacoes a seguir mapeiam a semantica CRUD para a semantica do
    *  relatorio: FormParaBO -> propaga filtros para o BO, BOParaForm -> repoe
    *  filtros padrao, HabilitarCampos -> trava/destrava campos de filtro.
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de FormParaRelatorio para compatibilidade com FormBase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sem registro corrente em REPORT; repoe filtros padrao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita os 7 campos de filtro do relatorio
    *   (DtInicial, Grupo/DGrupo, Conta/DConta, Moeda/DMoeda) via ReadOnly.
    *   Apos rehabilitar, AtualizarEstadoConta() recalcula When dinamico das
    *   descricoes (DGrupo so quando Grupo vazio, DConta so quando Grupo
    *   preenchido E Conta vazia).
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oCnt, loc_lHab, loc_oErro
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
                IF VARTYPE(loc_oCnt) = "O"
                    loc_oCnt.txt_4c_DtInicial.ReadOnly = !loc_lHab
                    loc_oCnt.txt_4c_Grupo.ReadOnly     = !loc_lHab
                    loc_oCnt.txt_4c_DGrupo.ReadOnly    = !loc_lHab
                    loc_oCnt.txt_4c_Conta.ReadOnly     = !loc_lHab
                    loc_oCnt.txt_4c_DConta.ReadOnly    = !loc_lHab
                    loc_oCnt.txt_4c_Moeda.ReadOnly     = !loc_lHab
                    loc_oCnt.txt_4c_DMoeda.ReadOnly    = !loc_lHab
                    IF loc_lHab
                        THIS.AtualizarEstadoConta()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - REPORT nao possui grid de registros. Mantido como stub
    *   bem-sucedido para satisfazer a interface generica de FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT nao ha modos CRUD; todos os botoes do
    *   cmg_4c_Botoes (Visualizar/Imprimir/Excel/Encerrar) permanecem ativos.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_nI, loc_oErro
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                FOR loc_nI = 1 TO THIS.cmg_4c_Botoes.ButtonCount
                    THIS.cmg_4c_Botoes.Buttons(loc_nI).Enabled = .T.
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - REPORT tem apenas Page1 (filtros). Recoloca a Page1
    *   ativa e foca a Data de Referencia para nova consulta.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Local", 5)
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DtInicial.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

ENDDEFINE
