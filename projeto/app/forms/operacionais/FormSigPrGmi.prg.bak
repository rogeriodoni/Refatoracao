*==============================================================================
* FormSigPrGmi.prg - Geracao de Pedido de Estoque Minimo (SIGPRGMI)
* Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
* Migrado de: SIGPRGMI.SCX
* Fase 8/8: Form - COMPLETO
* NOTA: Form OPERACIONAL - legado tem Processar/Encerrar. Os handlers
*   BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
*   mapeiam a semantica CRUD para as acoes operacionais equivalentes:
*     - Incluir     -> executa novo processamento (chama BtnProcessarClick)
*     - Alterar     -> reabre form para reconfiguracao dos parametros
*     - Visualizar  -> abre picker de linhas de producao (SigCdLin)
*     - Excluir     -> cancela e limpa parametros digitados
*==============================================================================

DEFINE CLASS FormSigPrGmi AS FormBase

    *-- Propriedades visuais (copiadas exatamente do original)
    Height       = 292
    Width        = 800
    Caption      = "Gera" + CHR(231) + CHR(227) + "o de Pedido de Estoque M" + CHR(237) + "nimo"
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    ShowTips     = .T.
    KeyPreview   = .T.

    *-- Estado / Negocio
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_nPaginaAtual    = 1

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        *-- DataSession=2 reseta SET DATE/CENTURY (regra 9.4)
        SET DATE TO BRITISH
        SET CENTURY ON
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGmiBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrGmi.", "Erro")
            ELSE
                *-- Carregar cursor de linhas de producao para lookup local
                THIS.this_oBusinessObject.CarregarCursorLinhas()

                *-- Montar interface visual
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarBindings()

                *-- Propagar titulo para labels do cabecalho
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro FormSigPrGmi.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.Picture      = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
        THIS.ClipControls = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BackColor  = RGB(100, 100, 100)
            .BorderWidth = 0
            .BackStyle  = 1

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize   = .F.
                .BackStyle  = 0
                .Caption    = ""
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .ForeColor  = RGB(0, 0, 0)
                .Height     = 40
                .Left       = 10
                .Top        = 18
                .Width      = THIS.Width
                .WordWrap   = .T.
                .Alignment  = 0
                .Visible    = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize    = .F.
                .BackStyle   = 0
                .Caption     = ""
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .ForeColor   = RGB(255, 255, 255)
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.Width
                .WordWrap    = .T.
                .Alignment   = 0
                .ToolTipText = "T" + CHR(237) + "tulo"
                .Visible     = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - OPERACIONAL: monta interface unica (campos + botoes)
    * NOTA: Form flat sem PageFrame; "PaginaLista" agrupa a instanciacao dos
    * containers e widgets equivalentes ao Page1 dos forms CRUD.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - OPERACIONAL: configura area de campos (parametros)
    * NOTA: Form flat sem PageFrame Page1/Page2. Neste form OPERACIONAL, os
    * campos de parametros (Empresa/Grupo/Conta/Linha/Negativo/Data) sao adicionados
    * diretamente ao Form via AddObject. Este metodo eh o ponto de entrada canonico
    * para adicao dos campos de dados/parametros da operacao (equivalente aos campos
    * de Page2 dos forms CRUD).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        THIS.ConfigurarCampos()
    ENDPROC

    *==========================================================================
    * AlternarPagina - OPERACIONAL: reinicia estado da unica pagina de parametros
    * Em OPERACIONAL flat nao ha Page1/Page2; este metodo prepara a tela para
    * uma nova execucao (reset de campos + foco inicial + estado botao Processar).
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPag
        loc_nPag = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1, par_nPagina, 1)
        THIS.this_nPaginaAtual = loc_nPag

        THIS.LimparCampos()

        IF PEMSTATUS(THIS, "cmd_4c_Processa", 5)
            THIS.cmd_4c_Processa.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
            THIS.txt_4c_CdEmpresa.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_oAlvo

        IF VARTYPE(par_oContainer) = "O"
            loc_oAlvo = par_oContainer
        ELSE
            loc_oAlvo = THIS
        ENDIF

        FOR loc_i = 1 TO loc_oAlvo.ControlCount
            loc_oControl = loc_oAlvo.Controls(loc_i)
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
    * ConfigurarCampos - Adiciona campos de parametros e labels ao formulario
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos
        *-- Decorativo Shape1
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 698
            .Width       = 46
            .Height      = 41
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- Empresa
        THIS.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH THIS.lbl_4c_LblEmpresa
            .AutoSize  = .T.
            .Caption   = "Empresa : "
            .Left      = 211
            .Top       = 118
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH THIS.txt_4c_CdEmpresa
            .FontName      = "Courier New"
            .FontSize      = 9
            .Format        = "K"
            .Height        = 25
            .Left          = 268
            .MaxLength     = 3
            .InputMask     = "XXX"
            .SpecialEffect = 0
            .Top           = 113
            .Width         = 31
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH THIS.txt_4c_DsEmpresa
            .FontName  = "Courier New"
            .FontSize  = 9
            .Format    = "K"
            .Height    = 25
            .Left      = 348
            .MaxLength = 40
            .Top       = 113
            .Width     = 290
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Grupo de Estoque
        THIS.AddObject("lbl_4c_Say1", "Label")
        WITH THIS.lbl_4c_Say1
            .AutoSize  = .T.
            .Caption   = "Grupo de Estoque : "
            .Left      = 166
            .Top       = 142
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdGrEstoque", "TextBox")
        WITH THIS.txt_4c_CdGrEstoque
            .FontName  = "Courier New"
            .FontSize  = 9
            .Format    = "K"
            .Height    = 25
            .Left      = 268
            .MaxLength = 10
            .Top       = 138
            .Width     = 80
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsGrEstoque", "TextBox")
        WITH THIS.txt_4c_DsGrEstoque
            .FontName  = "Courier New"
            .FontSize  = 9
            .Format    = "K"
            .Height    = 25
            .Left      = 348
            .MaxLength = 20
            .Top       = 138
            .Width     = 150
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Estoque (Conta)
        THIS.AddObject("lbl_4c_LblEstoque", "Label")
        WITH THIS.lbl_4c_LblEstoque
            .AutoSize  = .T.
            .Caption   = "Estoque : "
            .Left      = 213
            .Top       = 168
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH THIS.txt_4c_CdEstoque
            .FontName      = "Courier New"
            .FontSize      = 9
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 25
            .Left          = 268
            .MaxLength     = 10
            .SpecialEffect = 0
            .Top           = 163
            .Width         = 80
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH THIS.txt_4c_DsEstoque
            .FontName  = "Courier New"
            .FontSize  = 9
            .Format    = "K"
            .Height    = 25
            .Left      = 348
            .MaxLength = 40
            .Top       = 163
            .Width     = 290
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Linha de Producao
        THIS.AddObject("lbl_4c_Say2", "Label")
        WITH THIS.lbl_4c_Say2
            .AutoSize  = .T.
            .Caption   = "Linha de Produ" + CHR(231) + CHR(227) + "o : "
            .Left      = 164
            .Top       = 193
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Linha", "TextBox")
        WITH THIS.txt_4c_Linha
            .FontName      = "Courier New"
            .FontSize      = 9
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 25
            .Left          = 268
            .MaxLength     = 10
            .SpecialEffect = 0
            .Top           = 188
            .Width         = 80
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsLinha", "TextBox")
        WITH THIS.txt_4c_DsLinha
            .FontName  = "Courier New"
            .FontSize  = 9
            .Format    = "K"
            .Height    = 25
            .Left      = 348
            .MaxLength = 40
            .Top       = 188
            .Width     = 290
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Somente Negativos
        THIS.AddObject("lbl_4c_Say3", "Label")
        WITH THIS.lbl_4c_Say3
            .AutoSize  = .T.
            .Caption   = "Somente Negativos :"
            .Left      = 162
            .Top       = 218
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Negativo", "TextBox")
        WITH THIS.txt_4c_Negativo
            .FontName      = "Courier New"
            .FontSize      = 9
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 25
            .Left          = 268
            .MaxLength     = 1
            .SpecialEffect = 0
            .Top           = 213
            .Width         = 17
            .Value         = "N"
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Say4", "Label")
        WITH THIS.lbl_4c_Say4
            .AutoSize  = .T.
            .Caption   = "< S / N >"
            .Left      = 292
            .Top       = 217
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Data de Geracao
        THIS.AddObject("lbl_4c_SayConta", "Label")
        WITH THIS.lbl_4c_SayConta
            .AutoSize  = .T.
            .Caption   = "Data Gera" + CHR(231) + CHR(227) + "o :"
            .Left      = 189
            .Top       = 243
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Datai", "TextBox")
        WITH THIS.txt_4c_Datai
            .Alignment = 3
            .Height    = 23
            .Left      = 268
            .Top       = 238
            .Width     = 82
            .Value     = DATE() - 7
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Adiciona botoes Processar e Encerrar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        THIS.AddObject("cmd_4c_Processa", "CommandButton")
        WITH THIS.cmd_4c_Processa
            .Top             = 4
            .Left            = 648
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
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
            .Picture         = loc_cIcones + "geral_processar_60.jpg"
            .DisabledPicture = loc_cIcones + "geral_processar_60.jpg"
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top             = 4
            .Left            = 723
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
            .Cancel          = .T.
            .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBindings - Conecta eventos dos controles aos handlers
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBindings
        BINDEVENT(THIS.txt_4c_CdEmpresa,   "KeyPress", THIS, "TxtCdEmpresaKeyPress")
        BINDEVENT(THIS.txt_4c_DsEmpresa,   "KeyPress", THIS, "TxtDsEmpresaKeyPress")
        BINDEVENT(THIS.txt_4c_CdGrEstoque, "KeyPress", THIS, "TxtCdGrEstoqueKeyPress")
        BINDEVENT(THIS.txt_4c_DsGrEstoque, "KeyPress", THIS, "TxtDsGrEstoqueKeyPress")
        BINDEVENT(THIS.txt_4c_CdEstoque,   "KeyPress", THIS, "TxtCdEstoqueKeyPress")
        BINDEVENT(THIS.txt_4c_DsEstoque,   "KeyPress", THIS, "TxtDsEstoqueKeyPress")
        BINDEVENT(THIS.txt_4c_Linha,       "KeyPress", THIS, "TxtLinhaKeyPress")
        BINDEVENT(THIS.txt_4c_DsLinha,     "KeyPress", THIS, "TxtDsLinhaKeyPress")
        BINDEVENT(THIS.txt_4c_Negativo,    "KeyPress", THIS, "TxtNegativoKeyPress")
        BINDEVENT(THIS.cmd_4c_Processa,    "Click",    THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Cancela,     "Click",    THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos para o Business Object
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO
        WITH THIS.this_oBusinessObject
            .this_cEmpresa     = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
            .this_cDsEmpresa   = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
            .this_cGrEstoque   = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            .this_cDsGrEstoque = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
            .this_cEstoque     = ALLTRIM(THIS.txt_4c_CdEstoque.Value)
            .this_cDsEstoque   = ALLTRIM(THIS.txt_4c_DsEstoque.Value)
            .this_cLinha       = ALLTRIM(THIS.txt_4c_Linha.Value)
            .this_cDsLinha     = ALLTRIM(THIS.txt_4c_DsLinha.Value)
            .this_cNegativo    = UPPER(ALLTRIM(THIS.txt_4c_Negativo.Value))
            .this_dDatai       = THIS.txt_4c_Datai.Value
        ENDWITH
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta todos os campos de parametros
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos
        THIS.txt_4c_CdEmpresa.Value   = ""
        THIS.txt_4c_DsEmpresa.Value   = ""
        THIS.txt_4c_CdGrEstoque.Value = ""
        THIS.txt_4c_DsGrEstoque.Value = ""
        THIS.txt_4c_CdEstoque.Value   = ""
        THIS.txt_4c_DsEstoque.Value   = ""
        THIS.txt_4c_Linha.Value       = ""
        THIS.txt_4c_DsLinha.Value     = ""
        THIS.txt_4c_Negativo.Value    = "N"
        THIS.txt_4c_Datai.Value       = {}
        THIS.txt_4c_CdEmpresa.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Novo pedido de estoque minimo (equivale a "Processar")
    * Em OPERACIONAL, a acao de "incluir" corresponde a executar a geracao
    * de novos pedidos, que e exatamente o que o botao Processar faz.
    *==========================================================================
    PROCEDURE BtnIncluirClick
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Reconfigurar parametros para novo processamento
    * "Alterar" em OPERACIONAL significa ajustar os parametros de entrada
    * antes de reprocessar. Reseta a tela para nova parametrizacao.
    *==========================================================================
    PROCEDURE BtnAlterarClick
        THIS.LimparCampos()
        THIS.AlternarPagina(1)
        IF PEMSTATUS(THIS, "cmd_4c_Processa", 5)
            THIS.cmd_4c_Processa.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
            THIS.txt_4c_CdEmpresa.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar linhas de producao disponiveis
    * "Visualizar" em OPERACIONAL abre picker de referencia (SigCdLin) para
    * o usuario consultar as linhas antes de escolher o parametro de filtro.
    *==========================================================================
    PROCEDURE BtnVisualizarClick
        THIS.AbrirBuscaLinha("C", ALLTRIM(THIS.txt_4c_Linha.Value))
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Cancelar operacao / limpar parametros
    * "Excluir" em OPERACIONAL corresponde a cancelar a parametrizacao em
    * andamento e voltar ao estado inicial (com confirmacao do usuario).
    *==========================================================================
    PROCEDURE BtnExcluirClick
        LOCAL loc_lConfirma
        loc_lConfirma = MsgConfirma("Deseja cancelar a opera" + CHR(231) + CHR(227) + ;
            "o e limpar os par" + CHR(226) + "metros?", ;
            "Confirma" + CHR(231) + CHR(227) + "o")
        IF loc_lConfirma
            THIS.LimparCampos()
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Executa geracao de pedidos de estoque minimo
    *==========================================================================
    PROCEDURE BtnProcessarClick
        LOCAL loc_oErro, loc_lPodeProcessar
        loc_lPodeProcessar = .T.
        TRY
            THIS.FormParaBO()

            *-- Validar campos obrigatorios e setar foco (UX identico ao legado)
            IF loc_lPodeProcessar AND EMPTY(ALLTRIM(THIS.txt_4c_CdEmpresa.Value))
                MsgAviso(CHR(201) + " obrigat" + CHR(243) + "rio informar a Empresa...", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_CdEmpresa.SetFocus()
                loc_lPodeProcessar = .F.
            ENDIF
            IF loc_lPodeProcessar AND EMPTY(ALLTRIM(THIS.txt_4c_CdGrEstoque.Value))
                MsgAviso(CHR(201) + " obrigat" + CHR(243) + "rio informar o Grupo...", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_CdGrEstoque.SetFocus()
                loc_lPodeProcessar = .F.
            ENDIF
            IF loc_lPodeProcessar AND EMPTY(ALLTRIM(THIS.txt_4c_CdEstoque.Value))
                MsgAviso(CHR(201) + " obrigat" + CHR(243) + "rio informar a Conta...", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_CdEstoque.SetFocus()
                loc_lPodeProcessar = .F.
            ENDIF
            IF loc_lPodeProcessar AND EMPTY(ALLTRIM(THIS.txt_4c_Linha.Value))
                MsgAviso(CHR(201) + " obrigat" + CHR(243) + "rio informar a Linha de Produ" + CHR(231) + CHR(227) + "o...", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_Linha.SetFocus()
                loc_lPodeProcessar = .F.
            ENDIF
            IF loc_lPodeProcessar AND EMPTY(THIS.txt_4c_Datai.Value)
                MsgAviso(CHR(201) + " obrigat" + CHR(243) + "rio informar a Data de Gera" + CHR(231) + CHR(227) + "o...", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_Datai.SetFocus()
                loc_lPodeProcessar = .F.
            ENDIF

            IF loc_lPodeProcessar
                IF THIS.this_oBusinessObject.Inserir()
                    MsgInfo("Pedidos de Estoque M" + CHR(237) + "nimo gerados com sucesso!", "Sucesso")
                    THIS.AlternarPagina(1)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnProcessarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TxtCdEmpresaKeyPress - Lookup empresa por codigo (SigCdEmp.Cemps)
    *==========================================================================
    PROCEDURE TxtCdEmpresaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cCod
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
        IF par_nKeyCode = 115 OR EMPTY(loc_cCod)
            THIS.AbrirBuscaEmpresa("C", loc_cCod)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                EscaparSQL(PADR(loc_cCod, 3))
            IF USED("cursor_4c_EmpTmp")
                USE IN cursor_4c_EmpTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_EmpTmp
                IF !EOF("cursor_4c_EmpTmp")
                    THIS.txt_4c_CdEmpresa.Value = ALLTRIM(NVL(cursor_4c_EmpTmp.Cemps, ""))
                    THIS.txt_4c_DsEmpresa.Value = ALLTRIM(NVL(cursor_4c_EmpTmp.Razas, ""))
                    USE IN cursor_4c_EmpTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_EmpTmp
            ENDIF
            THIS.AbrirBuscaEmpresa("C", loc_cCod)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtCdEmpresaKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtDsEmpresaKeyPress - Lookup empresa por razao social (SigCdEmp.Razas)
    *==========================================================================
    PROCEDURE TxtDsEmpresaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaEmpresa("D", ALLTRIM(THIS.txt_4c_DsEmpresa.Value))
    ENDPROC

    *==========================================================================
    * AbrirBuscaEmpresa - FormBuscaAuxiliar para SigCdEmp (Cemps + Razas)
    *==========================================================================
    PROCEDURE AbrirBuscaEmpresa(par_cModo, par_cValor)
        LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere
        TRY
            IF par_cModo = "C"
                loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
                    "WHERE Cemps LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
            ELSE
                loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
                    "WHERE RTRIM(Razas) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
            ENDIF
            loc_cSQL = "SELECT TOP 200 Cemps, Razas FROM SigCdEmp " + loc_cWhere + " ORDER BY Cemps"

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
            IF loc_nResultado < 1
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
                "cursor_4c_BuscaEmp", IIF(par_cModo = "C", "Cemps", "Razas"), "", ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa", .T., .T., "")
            loc_oBusca.mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                THIS.txt_4c_CdEmpresa.Value = ALLTRIM(NVL(cursor_4c_BuscaEmp.Cemps, ""))
                THIS.txt_4c_DsEmpresa.Value = ALLTRIM(NVL(cursor_4c_BuscaEmp.Razas, ""))
            ENDIF

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaEmpresa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtCdGrEstoqueKeyPress - Lookup grupo estoque por codigo (SigCdGcr.codigos)
    *==========================================================================
    PROCEDURE TxtCdGrEstoqueKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cCod
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
        IF par_nKeyCode = 115 OR EMPTY(loc_cCod)
            THIS.AbrirBuscaGrEstoque("C", loc_cCod)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                EscaparSQL(PADR(loc_cCod, 10))
            IF USED("cursor_4c_GrTmp")
                USE IN cursor_4c_GrTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_GrTmp
                IF !EOF("cursor_4c_GrTmp")
                    THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(NVL(cursor_4c_GrTmp.codigos, ""))
                    THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(NVL(cursor_4c_GrTmp.descrs, ""))
                    USE IN cursor_4c_GrTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_GrTmp
            ENDIF
            THIS.AbrirBuscaGrEstoque("C", loc_cCod)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtCdGrEstoqueKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtDsGrEstoqueKeyPress - Lookup grupo estoque por descricao
    *==========================================================================
    PROCEDURE TxtDsGrEstoqueKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaGrEstoque("D", ALLTRIM(THIS.txt_4c_DsGrEstoque.Value))
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrEstoque - FormBuscaAuxiliar para SigCdGcr
    * NOTA: SigCdGcr usa coluna descrs (com r), nao descrs
    *==========================================================================
    PROCEDURE AbrirBuscaGrEstoque(par_cModo, par_cValor)
        LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere
        TRY
            IF par_cModo = "C"
                loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
                    "WHERE codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
            ELSE
                loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
                    "WHERE RTRIM(descrs) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
            ENDIF
            loc_cSQL = "SELECT TOP 200 codigos, descrs FROM SigCdGcr " + loc_cWhere + " ORDER BY codigos"

            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr")
            IF loc_nResultado < 1
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
                "cursor_4c_BuscaGcr", IIF(par_cModo = "C", "codigos", "descrs"), "", ;
                "Sele" + CHR(231) + CHR(227) + "o de Grupo de Estoque", .T., .T., "")
            loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(NVL(cursor_4c_BuscaGcr.codigos, ""))
                THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(NVL(cursor_4c_BuscaGcr.descrs, ""))
            ENDIF

            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaGrEstoque")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtCdEstoqueKeyPress - Lookup conta estoque por codigo (SigCdCli.IClis)
    *==========================================================================
    PROCEDURE TxtCdEstoqueKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_nResultado, loc_cSQL, loc_cCod, loc_cGrp
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(THIS.txt_4c_CdEstoque.Value)
        loc_cGrp = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
        IF par_nKeyCode = 115 OR EMPTY(loc_cCod)
            THIS.AbrirBuscaEstoque("C", loc_cGrp, loc_cCod)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                EscaparSQL(PADR(loc_cCod, 10))
            IF !EMPTY(loc_cGrp)
                loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(PADR(loc_cGrp, 10))
            ENDIF
            IF USED("cursor_4c_EstTmp")
                USE IN cursor_4c_EstTmp
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstTmp")
            IF loc_nResultado >= 1
                SELECT cursor_4c_EstTmp
                IF !EOF("cursor_4c_EstTmp")
                    THIS.txt_4c_CdEstoque.Value = ALLTRIM(NVL(cursor_4c_EstTmp.IClis, ""))
                    THIS.txt_4c_DsEstoque.Value = ALLTRIM(NVL(cursor_4c_EstTmp.RClis, ""))
                    USE IN cursor_4c_EstTmp
                    RETURN
                ENDIF
                USE IN cursor_4c_EstTmp
            ENDIF
            THIS.AbrirBuscaEstoque("C", loc_cGrp, loc_cCod)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtCdEstoqueKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtDsEstoqueKeyPress - Lookup conta estoque por descricao (SigCdCli.RClis)
    *==========================================================================
    PROCEDURE TxtDsEstoqueKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaEstoque("D", ALLTRIM(THIS.txt_4c_CdGrEstoque.Value), ;
            ALLTRIM(THIS.txt_4c_DsEstoque.Value))
    ENDPROC

    *==========================================================================
    * AbrirBuscaEstoque - FormBuscaAuxiliar para SigCdCli filtrado por grupo
    *==========================================================================
    PROCEDURE AbrirBuscaEstoque(par_cModo, par_cGrupo, par_cValor)
        LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere, loc_cWhereGrp
        TRY
            loc_cWhereGrp = IIF(EMPTY(ALLTRIM(par_cGrupo)), "", ;
                " AND Grupos = " + EscaparSQL(PADR(ALLTRIM(par_cGrupo), 10)))
            IF par_cModo = "C"
                IF EMPTY(ALLTRIM(par_cValor)) AND !EMPTY(ALLTRIM(par_cGrupo))
                    loc_cWhere = "WHERE Grupos = " + EscaparSQL(PADR(ALLTRIM(par_cGrupo), 10))
                ELSE
                    loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
                        "WHERE IClis LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + loc_cWhereGrp)
                ENDIF
            ELSE
                IF EMPTY(ALLTRIM(par_cValor)) AND !EMPTY(ALLTRIM(par_cGrupo))
                    loc_cWhere = "WHERE Grupos = " + EscaparSQL(PADR(ALLTRIM(par_cGrupo), 10))
                ELSE
                    loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
                        "WHERE RTRIM(RClis) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + loc_cWhereGrp)
                ENDIF
            ENDIF
            loc_cSQL = "SELECT TOP 200 IClis, RClis FROM SigCdCli " + loc_cWhere + " ORDER BY IClis"

            IF USED("cursor_4c_BuscaEst")
                USE IN cursor_4c_BuscaEst
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEst")
            IF loc_nResultado < 1
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
                "cursor_4c_BuscaEst", IIF(par_cModo = "C", "IClis", "RClis"), "", ;
                "Sele" + CHR(231) + CHR(227) + "o de Estoque", .T., .T., "")
            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                THIS.txt_4c_CdEstoque.Value = ALLTRIM(NVL(cursor_4c_BuscaEst.IClis, ""))
                THIS.txt_4c_DsEstoque.Value = ALLTRIM(NVL(cursor_4c_BuscaEst.RClis, ""))
            ENDIF

            IF USED("cursor_4c_BuscaEst")
                USE IN cursor_4c_BuscaEst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaEstoque")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtLinhaKeyPress - Lookup linha de producao por codigo (SigCdLin.linhas)
    *==========================================================================
    PROCEDURE TxtLinhaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cCod
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(THIS.txt_4c_Linha.Value)
        IF par_nKeyCode = 115 OR EMPTY(loc_cCod)
            THIS.AbrirBuscaLinha("C", loc_cCod)
            RETURN
        ENDIF
        IF USED("cursor_4c_SigCdLin")
            SELECT cursor_4c_SigCdLin
            SET ORDER TO TAG linhas
            IF SEEK(PADR(loc_cCod, 10), "cursor_4c_SigCdLin", "linhas")
                THIS.txt_4c_Linha.Value   = ALLTRIM(NVL(cursor_4c_SigCdLin.linhas, ""))
                THIS.txt_4c_DsLinha.Value = ALLTRIM(NVL(cursor_4c_SigCdLin.descs, ""))
                RETURN
            ENDIF
        ENDIF
        THIS.AbrirBuscaLinha("C", loc_cCod)
    ENDPROC

    *==========================================================================
    * TxtDsLinhaKeyPress - Lookup linha de producao por descricao
    *==========================================================================
    PROCEDURE TxtDsLinhaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaLinha("D", ALLTRIM(THIS.txt_4c_DsLinha.Value))
    ENDPROC

    *==========================================================================
    * AbrirBuscaLinha - FormBuscaAuxiliar para SigCdLin
    *==========================================================================
    PROCEDURE AbrirBuscaLinha(par_cModo, par_cValor)
        LOCAL loc_oBusca, loc_nResultado, loc_cSQL, loc_cWhere
        TRY
            IF par_cModo = "C"
                loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
                    "WHERE linhas LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
            ELSE
                loc_cWhere = IIF(EMPTY(ALLTRIM(par_cValor)), "", ;
                    "WHERE RTRIM(descs) LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%"))
            ENDIF
            loc_cSQL = "SELECT TOP 200 linhas, descs FROM SigCdLin " + loc_cWhere + " ORDER BY descs"

            IF USED("cursor_4c_BuscaLinha")
                USE IN cursor_4c_BuscaLinha
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaLinha")
            IF loc_nResultado < 1
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "", ;
                "cursor_4c_BuscaLinha", IIF(par_cModo = "C", "linhas", "descs"), "", ;
                "Sele" + CHR(231) + CHR(227) + "o de Linha de Produ" + CHR(231) + CHR(227) + "o", .T., .T., "")
            loc_oBusca.mAddColuna("linhas", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                THIS.txt_4c_Linha.Value   = ALLTRIM(NVL(cursor_4c_BuscaLinha.linhas, ""))
                THIS.txt_4c_DsLinha.Value = ALLTRIM(NVL(cursor_4c_BuscaLinha.descs, ""))
            ENDIF

            IF USED("cursor_4c_BuscaLinha")
                USE IN cursor_4c_BuscaLinha
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaLinha")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtNegativoKeyPress - Valida que o valor e S ou N
    *==========================================================================
    PROCEDURE TxtNegativoKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cVal
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        loc_cVal = UPPER(ALLTRIM(THIS.txt_4c_Negativo.Value))
        IF !INLIST(loc_cVal, "S", "N", "")
            MsgAviso("Informe S ou N para o campo Somente Negativos.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Negativo.Value = "N"
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula campos do formulario a partir do Business Object
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm
        WITH THIS.this_oBusinessObject
            THIS.txt_4c_CdEmpresa.Value   = ALLTRIM(.this_cEmpresa)
            THIS.txt_4c_DsEmpresa.Value   = ALLTRIM(.this_cDsEmpresa)
            THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(.this_cGrEstoque)
            THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(.this_cDsGrEstoque)
            THIS.txt_4c_CdEstoque.Value   = ALLTRIM(.this_cEstoque)
            THIS.txt_4c_DsEstoque.Value   = ALLTRIM(.this_cDsEstoque)
            THIS.txt_4c_Linha.Value       = ALLTRIM(.this_cLinha)
            THIS.txt_4c_DsLinha.Value     = ALLTRIM(.this_cDsLinha)
            THIS.txt_4c_Negativo.Value    = IIF(EMPTY(.this_cNegativo), "N", ALLTRIM(.this_cNegativo))
            THIS.txt_4c_Datai.Value       = IIF(EMPTY(.this_dDatai), DATE() - 7, .this_dDatai)
        ENDWITH
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita todos os campos de parametros
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        THIS.txt_4c_CdEmpresa.Enabled   = loc_lHab
        THIS.txt_4c_DsEmpresa.Enabled   = loc_lHab
        THIS.txt_4c_CdGrEstoque.Enabled = loc_lHab
        THIS.txt_4c_DsGrEstoque.Enabled = loc_lHab
        THIS.txt_4c_CdEstoque.Enabled   = loc_lHab
        THIS.txt_4c_DsEstoque.Enabled   = loc_lHab
        THIS.txt_4c_Linha.Enabled       = loc_lHab
        THIS.txt_4c_DsLinha.Enabled     = loc_lHab
        THIS.txt_4c_Negativo.Enabled    = loc_lHab
        THIS.txt_4c_Datai.Enabled       = loc_lHab
        IF PEMSTATUS(THIS, "cmd_4c_Processa", 5)
            THIS.cmd_4c_Processa.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Reativa botoes apos processamento
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        IF PEMSTATUS(THIS, "cmd_4c_Processa", 5)
            THIS.cmd_4c_Processa.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
            THIS.cmd_4c_Cancela.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - OPERACIONAL sem grid de lista; presente por compatibilidade
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre picker de linhas de producao (atalho de busca)
    *==========================================================================
    PROCEDURE BtnBuscarClick
        THIS.AbrirBuscaLinha("C", ALLTRIM(THIS.txt_4c_Linha.Value))
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias de BtnProcessarClick para compatibilidade CRUD
    *==========================================================================
    PROCEDURE BtnSalvarClick
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Limpar parametros / cancelar operacao em andamento
    *==========================================================================
    PROCEDURE BtnCancelarClick
        THIS.LimparCampos()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_SigCdLin")
            USE IN cursor_4c_SigCdLin
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
