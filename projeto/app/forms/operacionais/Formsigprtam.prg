*==============================================================================
* Formsigprtam.prg - Form Operacional: Peso M" + CHR(233) + "dio por Tamanho do Produto
* Migrado de SIGPRTAM.SCX
* Herda de FormBase
* Tipo: OPERACIONAL (form filho/modal, chamado pelo form de produto)
*
* Uso: loForm = CREATEOBJECT("Formsigprtam", oParentForm, nDataSes, cEscolha, cCPros)
*      loForm.Show()
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado (Width=638, Height=540, flat)
*   BD   -> Schema IDENTICO (sigprtam, SigCdTam)
*   CODE -> arquitetura em camadas (FormBase / sigprtamBO)
*==============================================================================

DEFINE CLASS Formsigprtam AS FormBase

    *-- Propriedades visuais (exatas do SCX SIGPRTAM)
    Width       = 638
    Height      = 540
    AutoCenter  = .T.
    BorderStyle = 2
    Caption     = "Peso m" + CHR(233) + "dio por tamanho"
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    WindowState = 0
    DataSession = 1
    Themes      = .F.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Codigo do produto (passado como parametro no Init)
    this_cCPros = ""

    *-- Descricao do produto (carregada do BO apos CarregarProduto)
    this_cDPros = ""

    *-- Modo de operacao: "INSERIR" / "ALTERAR" / "CONSULTAR"
    this_cPcEscolha = ""

    *-- Referencia ao form pai (para reabilitar ao fechar)
    this_oParentForm = .NULL.

    *-- Flags de operacoes realizadas (lidas pelo form pai apos fechamento)
    this_lHouveIncl = .F.
    this_lHouveExcl = .F.

    *-- Valor anterior na celula ativa para calculo bidirecional Percs <-> Valor
    this_nPeAntValue = 0

    *==========================================================================
    * Init - Recebe parametros do form pai ANTES de DODEFAULT
    * par_oParentForm: referencia ao form pai (para reativar ao fechar)
    * par_nDataSes:    sessao de dados do legado (nao utilizado - DataSession=1 global)
    * par_cPcEscolha:  modo de operacao: "INSERIR" / "ALTERAR" / "CONSULTAR"
    * par_cCPros:      codigo do produto cujos tamanhos serao gerenciados
    *==========================================================================
    PROCEDURE Init(par_oParentForm, par_nDataSes, par_cPcEscolha, par_cCPros)
        LOCAL loc_lSucesso

        *-- Armazenar parametros ANTES de DODEFAULT (que dispara InicializarForm)
        IF TYPE("par_oParentForm") = "O"
            THIS.this_oParentForm = par_oParentForm
        ENDIF
        IF TYPE("par_cPcEscolha") = "C"
            THIS.this_cPcEscolha = UPPER(ALLTRIM(par_cPcEscolha))
        ENDIF
        IF TYPE("par_cCPros") = "C"
            THIS.this_cCPros = ALLTRIM(par_cCPros)
        ENDIF

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Form OPERACIONAL plano (sem PageFrame real)
    * Configura fundo e propriedades base do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    * Orquestra a criacao dos controles e carregamento de dados
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = NEWOBJECT("sigprtamBO", gc_4c_CaminhoClasses + "sigprtamBO.prg")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object sigprtamBO.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                IF gnConnHandle <= 0
                    MsgErro("Imposs" + CHR(237) + "vel efetuar conex" + CHR(227) + ;
                            "o com o servidor.", "Conex" + CHR(227) + "o")
                ELSE
                    THIS.ConfigurarPageFrame()
                    THIS.ConfigurarCabecalho()
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.ConfigurarPaginaLista()
                    THIS.CarregarDados()
                    THIS.ConfigurarPaginaDados()
                    THIS.ConfigurarGrdDados()
                    THIS.TornarControlesVisiveis(THIS)
                    THIS.AjustarBotoesPorModo()
                    THIS.ConfigurarBINDEVENTs()
                    THIS.AlternarPagina(1)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria container de cabecalho (equiv. cntSombra legado)
    * Exato: Top=0, Left=0, Width=800, Height=80, BackColor=RGB(100,100,100)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

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
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize    = .F.
            .Top         = 25
            .Left        = 10
            .Width       = 769
            .Height      = 40
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(0, 0, 0)
            .Caption     = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize    = .F.
            .Top         = 24
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Orquestra a "pagina de lista" (form flat OPERACIONAL)
    * O form SIGPRTAM eh flat (sem PageFrame). A "lista" eh o grid de tamanhos
    * com os botoes CRUD (Inserir/Excluir/Encerrar) equivalendo aos 3 do legado.
    * Este metodo agrupa a configuracao para satisfazer o padrao arquitetural.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarGrid()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Ativa "pagina" logica (form flat: unica pagina = grid)
    * par_nPagina: 1 = grid de tamanhos (unica pagina existente)
    * Delega foco ao grid quando a pagina alvo eh a de lista.
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        IF loc_nPagina = 1
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND VARTYPE(THIS.grd_4c_Dados) = "O"
                IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
                    THIS.grd_4c_Dados.SetFocus()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria botoes de acao standalone (posicoes exatas do legado)
    * cmdInserir Left=413, cmdExcluir Left=488, cmdSair Left=563, todos Top=3
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()

        *-- cmd_4c_Inserir (cmdInserir legado: Left=413, Top=3)
        THIS.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH THIS.cmd_4c_Inserir
            .Top             = 3
            .Left            = 413
            .Width           = 75
            .Height          = 75
            .Caption         = "Inserir"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
        ENDWITH

        *-- cmd_4c_Excluir (cmdExcluir legado: Left=488, Top=3)
        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top             = 3
            .Left            = 488
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
        ENDWITH

        *-- cmd_4c_Encerrar (cmdSair legado: Left=563, Top=3)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 563
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Renderiza area de dados do produto pai
    * Chamado APOS CarregarDados() (dados ja em this_oBusinessObject)
    * Cria:
    *   - shp_4c_PainelAcoes: Shape1 do legado (frame visual dos botoes)
    *     Legado: Top=12, Left=372, Width=256, Height=110 (envolve os 3 botoes)
    *   - lbl_4c_Produto: exibe codigo + descricao do produto (contexto de edicao)
    *     Aproveita this_cCPros + this_cDPros carregados de SigCdPro
    *   - lbl_4c_Precos: exibe PVens/PCuss para referencia rapida durante calculos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_cCaptionProd, loc_cCaptionPrecos, loc_cDPros
        LOCAL loc_nPVens, loc_nPCuss

        *-- Shape1 (frame visual dos botoes - legado: Top=12 Left=372 W=256 H=110)
        THIS.AddObject("shp_4c_PainelAcoes", "Shape")
        WITH THIS.shp_4c_PainelAcoes
            .Top           = 12
            .Left          = 372
            .Width         = 256
            .Height        = 110
            .BackStyle     = 0
            .BorderColor   = RGB(136, 189, 188)
            .BorderWidth   = 1
            .SpecialEffect = 0
            .Curvature     = 0
        ENDWITH
        THIS.shp_4c_PainelAcoes.ZOrder(1)

        *-- Ler dados do produto pai carregados por CarregarDados
        loc_cDPros = ""
        loc_nPVens = 0
        loc_nPCuss = 0
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cDPros = NVL(THIS.this_oBusinessObject.this_cDPros, "")
            loc_nPVens = NVL(THIS.this_oBusinessObject.this_nPVens, 0)
            loc_nPCuss = NVL(THIS.this_oBusinessObject.this_nPCuss, 0)
        ENDIF

        loc_cCaptionProd = "Produto: " + ALLTRIM(THIS.this_cCPros) + ;
                           IIF(EMPTY(ALLTRIM(loc_cDPros)), "", " - " + ALLTRIM(loc_cDPros))

        loc_cCaptionPrecos = "Pre" + CHR(231) + "o Venda: " + ;
                             TRANSFORM(loc_nPVens, "@$ 9,999,999.99") + ;
                             "     Custo: " + ;
                             TRANSFORM(loc_nPCuss, "@$ 9,999,999.99")

        *-- Label produto: identifica qual produto esta sendo editado
        THIS.AddObject("lbl_4c_Produto", "Label")
        WITH THIS.lbl_4c_Produto
            .Top       = 85
            .Left      = 10
            .Width     = 355
            .Height    = 18
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 9
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(15, 41, 104)
            .Alignment = 0
            .Caption   = loc_cCaptionProd
        ENDWITH

        *-- Label precos: exibe PVens/PCuss para referencia dos calculos Percs/Valor
        THIS.AddObject("lbl_4c_Precos", "Label")
        WITH THIS.lbl_4c_Precos
            .Top       = 85
            .Left      = 370
            .Width     = 260
            .Height    = 18
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Caption   = loc_cCaptionPrecos
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Cria estrutura do grid de tamanhos
    * Grade legado: Top=111, Left=9, Width=620, Height=394, 6 colunas
    * Propriedades pixel-perfect do SCX original
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrd

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = THIS.grd_4c_Dados

        loc_oGrd.ColumnCount = 6

        WITH loc_oGrd
            .Top                 = 111
            .Left                = 9
            .Width               = 620
            .Height              = 394
            .FontName            = "Tahoma"
            .FontSize            = 8
            .ForeColor           = RGB(90, 90, 90)
            .BackColor           = RGB(255, 255, 255)
            .GridLineColor       = RGB(238, 238, 238)
            .HighlightBackColor  = RGB(255, 255, 255)
            .HighlightForeColor  = RGB(15, 41, 104)
            .HighlightStyle      = 2
            .DeleteMark          = .F.
            .RecordMark          = .F.
            .RowHeight           = 17
            .ScrollBars          = 2
            .AllowHeaderSizing   = .F.
            .AllowRowSizing      = .F.
            .AllowCellSelection  = .T.
            .Panel               = 1

            *-- Column1: codtams - Tam. (Width=38 do SCX)
            WITH .Column1
                .Width           = 38
                .Movable         = .F.
                .Resizable       = .F.
                .Header1.Caption = "Tam."
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column2: descs - Descricao (Width=216 do SCX)
            WITH .Column2
                .Width           = 216
                .Movable         = .F.
                .Resizable       = .F.
                .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column3: pesoms - Peso Medio (Width=100 do SCX)
            WITH .Column3
                .Width           = 100
                .Movable         = .F.
                .Resizable       = .F.
                .Header1.Caption = "Peso M" + CHR(233) + "dio"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column4: percs - Percentual (Width=80, InputMask="999.99" do SCX)
            WITH .Column4
                .Width           = 80
                .Movable         = .F.
                .Resizable       = .F.
                .InputMask       = "999.99"
                .Header1.Caption = "Percentual"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column5: valor - Valor calculado (Width=100, InputMask do SCX)
            WITH .Column5
                .Width           = 100
                .Movable         = .F.
                .Resizable       = .F.
                .InputMask       = "9999,999.99999"
                .Header1.Caption = "Valor"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Column6: diasprz - Prazo de entrega (Width=60, InputMask="99" do SCX)
            WITH .Column6
                .Width           = 60
                .Movable         = .F.
                .Resizable       = .F.
                .InputMask       = "99"
                .Header1.Caption = "Entrega"
                .Header1.FontName = "Tahoma"
                .Header1.FontSize = 8
                .Header1.Alignment = 2
                .Header1.ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarDados - Carrega dados do produto pai e tamanhos do SQL Server
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(THIS.this_cCPros)
            *-- Carregar contexto do produto (PVens, PCuss, Dpros para calculos)
            THIS.this_oBusinessObject.CarregarProduto(THIS.this_cCPros)
            THIS.this_cDPros = THIS.this_oBusinessObject.this_cDPros

            *-- Carregar tamanhos do produto no cursor de trabalho
            loc_lSucesso = THIS.this_oBusinessObject.CarregarTamanhos(THIS.this_cCPros)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarGrdDados - Vincula grid ao cursor apos CarregarDados
    * ColumnCount setado antes de RecordSource para evitar auto-expansao
    * Headers redefinidos apos RecordSource (VFP9 os reseta ao trocar fonte)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdDados()
        LOCAL loc_oGrd, loc_cCursor

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        loc_oGrd = THIS.grd_4c_Dados

        *-- ColumnCount e RecordSource FORA do WITH: atribuir RecordSource dentro de WITH
        *-- reconstroi as colunas internamente e o WITH perde acesso a Column1..N
        loc_oGrd.ColumnCount = 6
        loc_oGrd.RecordSource = loc_cCursor

        WITH loc_oGrd
            .Column1.ControlSource   = loc_cCursor + ".codtams"
            .Column2.ControlSource   = loc_cCursor + ".descs"
            .Column3.ControlSource   = loc_cCursor + ".pesoms"
            .Column4.ControlSource   = loc_cCursor + ".percs"
            .Column5.ControlSource   = loc_cCursor + ".valor"
            .Column6.ControlSource   = loc_cCursor + ".diasprz"

            *-- Redefinir cabecalhos apos RecordSource (VFP9 os reseta)
            .Column1.Header1.Caption = "Tam."
            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Caption = "Peso M" + CHR(233) + "dio"
            .Column4.Header1.Caption = "Percentual"
            .Column5.Header1.Caption = "Valor"
            .Column6.Header1.Caption = "Entrega"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Liga eventos aos controles via BINDEVENT
    * Botoes: Inserir / Excluir / Encerrar
    * Grid Column1/2: lookup SigCdTam por codigo ou descricao
    * Grid Column4/5: calculo bidirecional Percs <-> Valor
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.cmd_4c_Inserir,  "Click", THIS, "BtnInserirClick")
        BINDEVENT(THIS.cmd_4c_Excluir,  "Click", THIS, "BtnExcluirClick")
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdColuna1KeyPress")
        BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "GrdColuna2KeyPress")
        BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "KeyPress", THIS, "GrdColuna4KeyPress")
        BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GrdColuna5KeyPress")
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Oculta botoes de edicao em modo CONSULTAR
    * Chamado APOS TornarControlesVisiveis para sobrescrever visibilidade
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lModoEdicao, loc_i
        loc_lModoEdicao = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
        THIS.cmd_4c_Inserir.Visible = loc_lModoEdicao
        THIS.cmd_4c_Excluir.Visible = loc_lModoEdicao

        *-- Tornar colunas do grid read-only em CONSULTAR (equiv. Column.When=.F. do legado)
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            FOR loc_i = 1 TO THIS.grd_4c_Dados.ColumnCount
                THIS.grd_4c_Dados.Columns(loc_i).ReadOnly = !loc_lModoEdicao
            ENDFOR
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * AddObject cria controles com Visible=.F. por default
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Ativa modo INSERIR (form OPERACIONAL child)
    * Ajusta visibilidade dos botoes CRUD e insere linha em branco
    * Alias de BtnInserirClick (padrao SCX legado usa "Inserir" = "Incluir")
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_cPcEscolha = "INSERIR"
        THIS.AjustarBotoesPorModo()
        THIS.this_lHouveIncl = .T.
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           THIS.this_oBusinessObject.InserirLinhaGrid(THIS.this_cCPros)
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Ativa modo ALTERAR (form OPERACIONAL child)
    * Habilita edicao no grid mantendo os tamanhos ja carregados
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.this_cPcEscolha = "ALTERAR"
        THIS.AjustarBotoesPorModo()
        IF VARTYPE(THIS.grd_4c_Dados) = "O" AND THIS.grd_4c_Dados.Visible
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Ativa modo CONSULTAR (form OPERACIONAL child)
    * Bloqueia edicao no grid (colunas ReadOnly=.T.) e oculta botoes de edicao
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.this_cPcEscolha = "CONSULTAR"
        THIS.AjustarBotoesPorModo()
        IF VARTYPE(THIS.grd_4c_Dados) = "O" AND THIS.grd_4c_Dados.Visible
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnInserirClick - Insere linha em branco no grid de tamanhos
    * Equiv. cmdInserir.Click legado: locate linha vazia, se nao houver insere
    *==========================================================================
    PROCEDURE BtnInserirClick()
        THIS.this_lHouveIncl = .T.
        IF THIS.this_oBusinessObject.InserirLinhaGrid(THIS.this_cCPros)
            THIS.grd_4c_Dados.Refresh()
            THIS.grd_4c_Dados.Column1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Remove linha corrente do grid de tamanhos
    * Equiv. cmdExcluir.Click legado: DELETE + Skip/Skip-1
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.this_lHouveExcl = .T.
        IF THIS.this_oBusinessObject.ExcluirLinhaGrid(THIS.this_cCPros)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Valida, salva e fecha o form
    * Equiv. cmdSair.Click legado: valida CodTams preenchido, libera ParentForm
    * Em modo INSERIR/ALTERAR: persiste via SalvarTamanhos() no SQL Server
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        IF THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible
            IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
                IF !THIS.this_oBusinessObject.SalvarTamanhos(THIS.this_cCPros)
                    THIS.grd_4c_Dados.Column1.SetFocus()
                    RETURN
                ENDIF
            ENDIF
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * GrdColuna1KeyPress - KeyPress em Column1.Text1 (codigo do tamanho)
    * ENTER/TAB/F4: busca exata em SigCdTam por cods; se nao achar, abre picker
    * Se vazio: limpa codtams + descs na linha corrente
    *==========================================================================
    PROCEDURE GrdColuna1KeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        LOCAL loc_cCodTams, loc_cIdChavesAtual, loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
        loc_cCodTams = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
        loc_cIdChavesAtual = ""

        IF USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            loc_cIdChavesAtual = ALLTRIM(cidchaves)
        ENDIF

        IF EMPTY(loc_cCodTams)
            IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                SELECT (loc_cCursor)
                REPLACE codtams WITH "", descs WITH ""
            ENDIF
            THIS.grd_4c_Dados.Refresh()
            RETURN
        ENDIF

        THIS.AbrirBuscaTamanho("cods", loc_cCodTams, loc_cIdChavesAtual)
    ENDPROC

    *==========================================================================
    * GrdColuna2KeyPress - KeyPress em Column2.Text1 (descricao do tamanho)
    * Apenas ativo quando Column1 (codtams) estiver vazio (legado: When retorna .F. se col1 preenchida)
    * ENTER/TAB/F4: busca SigCdTam por descs LIKE; abre picker
    *==========================================================================
    PROCEDURE GrdColuna2KeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        *-- Column2 editavel somente quando Column1 (codtams) estiver vazio
        IF !EMPTY(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value))
            RETURN
        ENDIF

        LOCAL loc_cDescs, loc_cIdChavesAtual, loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
        loc_cDescs  = ALLTRIM(THIS.grd_4c_Dados.Column2.Text1.Value)
        loc_cIdChavesAtual = ""

        IF USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            loc_cIdChavesAtual = ALLTRIM(cidchaves)
        ENDIF

        IF EMPTY(loc_cDescs)
            IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                SELECT (loc_cCursor)
                REPLACE codtams WITH "", descs WITH ""
            ENDIF
            THIS.grd_4c_Dados.Refresh()
            RETURN
        ENDIF

        THIS.AbrirBuscaTamanho("descs", loc_cDescs, loc_cIdChavesAtual)
    ENDPROC

    *==========================================================================
    * GrdColuna4KeyPress - KeyPress em Column4.Text1 (percentual)
    * ENTER/TAB: calcula Valor = PVens + (PVens * Percs/100)
    * Equiv. Column4.Text1.Valid legado
    *==========================================================================
    PROCEDURE GrdColuna4KeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        LOCAL loc_nPercs, loc_nValor, loc_cCursor

        loc_nPercs  = THIS.grd_4c_Dados.Column4.Text1.Value
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF loc_nPercs = 0
            RETURN
        ENDIF

        loc_nValor = THIS.this_oBusinessObject.CalcularValorPorPercentual( ;
                         loc_nPercs, THIS.this_oBusinessObject.this_nPVens)

        IF USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            REPLACE valor WITH loc_nValor
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * GrdColuna5KeyPress - KeyPress em Column5.Text1 (valor)
    * ENTER/TAB: calcula Percs = ((Valor - PVens) / PVens) * 100
    * Valida PVens > 0; equiv. Column5.Text1.Valid legado
    *==========================================================================
    PROCEDURE GrdColuna5KeyPress(par_nKeyCode, par_nShiftAltCtrl)

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        LOCAL loc_nValor, loc_nPercs, loc_cCursor

        loc_nValor  = THIS.grd_4c_Dados.Column5.Text1.Value
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados

        IF loc_nValor = 0
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.this_nPVens = 0
            MsgAviso("Favor informar o Pre" + CHR(231) + "o de Venda do Produto.", "Aviso")
            IF USED(loc_cCursor) AND !EOF(loc_cCursor)
                SELECT (loc_cCursor)
                REPLACE valor WITH 0
            ENDIF
            THIS.grd_4c_Dados.Column5.Text1.Value = 0
            THIS.grd_4c_Dados.Refresh()
            RETURN
        ENDIF

        loc_nPercs = THIS.this_oBusinessObject.CalcularPercentualPorValor( ;
                         loc_nValor, THIS.this_oBusinessObject.this_nPVens)

        IF USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            REPLACE percs WITH loc_nPercs
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * AbrirBuscaTamanho - Helper: abre FormBuscaAuxiliar para SigCdTam
    * par_cCampoBusca:    "cods" ou "descs" (campo de busca na tabela)
    * par_cValorBusca:    valor a pesquisar
    * par_cIdChavesAtual: cidchaves da linha corrente (exclusao na validacao dup.)
    * Apos selecao: verifica duplicidade, aplica codtams+descs no cursor do grid
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaTamanho(par_cCampoBusca, par_cValorBusca, par_cIdChavesAtual)
        LOCAL loc_oBusca, loc_cCodSel, loc_cDescSel, loc_cCursor
        loc_cCursor  = THIS.this_oBusinessObject.this_cCursorDados
        loc_cCodSel  = ""
        loc_cDescSel = ""

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", ;
                                   "cursor_4c_BuscaTam", par_cCampoBusca, par_cValorBusca, ;
                                   "Sele" + CHR(231) + CHR(227) + "o de Tamanho", ;
                                   .T., .T., "")

        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF

        IF !loc_oBusca.this_lAchouRegistro
            loc_oBusca.mAddColuna("cods",  "XXXX", ;
                                   "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", ;
                                   "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
        ENDIF

        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaTam") AND !EOF("cursor_4c_BuscaTam")
                SELECT cursor_4c_BuscaTam
                loc_cCodSel  = NVL(ALLTRIM(cods),  "")
                loc_cDescSel = NVL(ALLTRIM(descs), "")
            ENDIF
        ENDIF

        loc_oBusca.Release()

        IF USED("cursor_4c_BuscaTam")
            USE IN cursor_4c_BuscaTam
        ENDIF

        IF EMPTY(loc_cCodSel)
            RETURN
        ENDIF

        *-- Verificar duplicidade (excluindo linha corrente pelo cidchaves)
        IF THIS.this_oBusinessObject.ValidarTamanhoExiste(loc_cCodSel, par_cIdChavesAtual)
            MsgAviso("Tamanho j" + CHR(225) + " informado para este produto!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        *-- Aplicar selecao no cursor do grid
        IF USED(loc_cCursor) AND !EOF(loc_cCursor)
            SELECT (loc_cCursor)
            REPLACE codtams WITH loc_cCodSel, descs WITH loc_cDescSel
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega o grid de tamanhos do produto pai
    * Wrapper canonico CRUD: reexecuta a query no BO, reconecta o grid ao cursor
    * e forca refresh visual. Usado apos BtnCancelarClick (descarta alteracoes)
    * e apos operacoes que invalidam o cursor de trabalho.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O" OR EMPTY(THIS.this_cCPros)
            RETURN .F.
        ENDIF

        loc_lSucesso = THIS.this_oBusinessObject.CarregarTamanhos(THIS.this_cCPros)

        IF loc_lSucesso
            THIS.ConfigurarGrdDados()
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere estado do Form para o Business Object
    * Form OPERACIONAL: propriedades this_cCPros e this_cPcEscolha (contexto de
    * edicao) sao repassadas ao BO antes de persistir. Os dados dos tamanhos
    * ja estao no cursor gerenciado pelo BO (edicao direta via grid).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.this_cCPros = ALLTRIM(THIS.this_cCPros)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere estado do Business Object para o Form
    * Sincroniza this_cDPros (descricao do produto) e atualiza label de precos
    * Form OPERACIONAL: chamado apos CarregarDados quando dados do produto pai
    * (PVens/PCuss/Dpros) foram lidos de SigCdPro pelo BO.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_cCaptionPrecos

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        THIS.this_cDPros = NVL(THIS.this_oBusinessObject.this_cDPros, "")

        IF PEMSTATUS(THIS, "lbl_4c_Produto", 5) AND VARTYPE(THIS.lbl_4c_Produto) = "O"
            THIS.lbl_4c_Produto.Caption = "Produto: " + ALLTRIM(THIS.this_cCPros) + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cDPros)), "", " - " + ALLTRIM(THIS.this_cDPros))
        ENDIF

        IF PEMSTATUS(THIS, "lbl_4c_Precos", 5) AND VARTYPE(THIS.lbl_4c_Precos) = "O"
            loc_cCaptionPrecos = "Pre" + CHR(231) + "o Venda: " + ;
                TRANSFORM(NVL(THIS.this_oBusinessObject.this_nPVens, 0), "@$ 9,999,999.99") + ;
                "     Custo: " + ;
                TRANSFORM(NVL(THIS.this_oBusinessObject.this_nPCuss, 0), "@$ 9,999,999.99")
            THIS.lbl_4c_Precos.Caption = loc_cCaptionPrecos
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Persiste tamanhos e fecha o form
    * Wrapper canonico CRUD: valida modo INSERIR/ALTERAR, transfere estado ao BO,
    * chama SalvarTamanhos() e fecha o form. Equivalente ao ramo positivo de
    * BtnEncerrarClick para forms OPERACIONAIS.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF !THIS.this_oBusinessObject.SalvarTamanhos(THIS.this_cCPros)
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
            RETURN
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Descarta alteracoes e fecha o form
    * Reseta flags this_lHouveIncl/this_lHouveExcl (form pai NAO reprocessa),
    * recarrega o cursor original (descartando edicoes em memoria) e fecha.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_lHouveIncl = .F.
        THIS.this_lHouveExcl = .F.

        *-- Recarregar do banco descarta modificacoes locais no cursor
        THIS.CarregarLista()

        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o form
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro, loc_cCursor
        TRY
            loc_cCursor = ""
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF
            IF USED("cursor_4c_ProdutoPai")
                USE IN cursor_4c_ProdutoPai
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar erros em Destroy (form sendo destruido)
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
