*==============================================================================
* FormSigPdMpf.prg - Movimentacoes de Producao por Funcionario
* Tabela  : SigCdNec (movimentacoes) + SigCdOpd (operacoes de producao)
* Baseado : SIGPDMPF.SCX
* Tipo    : OPERACIONAL - form de filtro que abre FormSigPdMp7 com resultados
*           Layout PLANO (sem PageFrame): cabecalho + container filtros + botoes
*==============================================================================

DEFINE CLASS FormSigPdMpf AS FormBase

    *-- Propriedades visuais exatas do original SIGPDMPF
    Width       = 800
    Height      = 254
    AutoCenter  = .T.
    DataSession = 2
    BorderStyle = 2
    TitleBar    = 0
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Themes      = .F.
    WindowType  = 1
    ShowWindow  = 1

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, configura interface e inicializa filtros
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SigPdMpfBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SigPdMpfBO.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            THIS.Caption = "Movimenta" + CHR(231) + CHR(245) + "es de produ" + ;
                           CHR(231) + CHR(227) + "o por funcion" + CHR(225) + "rio"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()

            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
            ENDIF

            THIS.TornarControlesVisiveis(THIS)

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.InicializarFiltros()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Form OPERACIONAL plano (sem PageFrame):
    * aplica propriedades globais de fonte equivalentes ao container raiz do legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Orquestra a montagem da "pagina" principal do form
    * OPERACIONAL (cabecalho + filtros + botoes). Equivale a Page1 (Lista) dos
    * forms CRUD: monta toda a UI visivel ao usuario no estado inicial.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarFiltros()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Em forms OPERACIONAIS planos (sem Page2), este
    * metodo faz o "afinamento" dos campos de entrada apos criacao da UI base:
    * - Define TabIndex (ordem de tabulacao identica ao legado: periodo > op >
    *   grupo > conta > optionGroup)
    * - Aplica ToolTipText/StatusBarText para acessibilidade dos filtros
    * - Sintoniza propriedades comportamentais ausentes no AddObject inicial
    *
    * Equivale ao bloco ConfigurarPaginaDados() dos forms CRUD, mas operando
    * sobre o container cnt_4c_Filtros (o equivalente a Page Dados deste form).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtros

        *-- Ordem de tabulacao (espelha sequencia visual do legado)
        loc_oCnt.txt_4c_DtInicial.TabIndex  = 1
        loc_oCnt.txt_4c_DtFinal.TabIndex    = 2
        loc_oCnt.txt_4c_NmOperacao.TabIndex = 3
        loc_oCnt.txt_4c_Grupo.TabIndex      = 4
        loc_oCnt.txt_4c_DGrupo.TabIndex     = 5
        loc_oCnt.txt_4c_Conta.TabIndex      = 6
        loc_oCnt.txt_4c_DConta.TabIndex     = 7
        loc_oCnt.obj_4c_OptConta.TabIndex   = 8

        *-- Tooltips dos campos (acessibilidade - feedback ao usuario)
        loc_oCnt.txt_4c_DtInicial.ToolTipText  = "Data inicial do per" + CHR(237) + "odo de consulta"
        loc_oCnt.txt_4c_DtFinal.ToolTipText    = "Data final do per" + CHR(237) + "odo de consulta"
        loc_oCnt.txt_4c_NmOperacao.ToolTipText = "Nome da movimenta" + CHR(231) + CHR(227) + "o (opcional)"
        loc_oCnt.txt_4c_Grupo.ToolTipText      = "C" + CHR(243) + "digo do grupo financeiro (F4 abre busca)"
        loc_oCnt.txt_4c_DGrupo.ToolTipText     = "Descri" + CHR(231) + CHR(227) + "o do grupo - habilitado quando C" + CHR(243) + "digo vazio"
        loc_oCnt.txt_4c_Conta.ToolTipText      = "C" + CHR(243) + "digo da conta/funcion" + CHR(225) + "rio (F4 abre busca)"
        loc_oCnt.txt_4c_DConta.ToolTipText     = "Nome - habilitado quando Grupo preenchido e C" + CHR(243) + "digo vazio"
        loc_oCnt.obj_4c_OptConta.ToolTipText   = "Filtra movimenta" + CHR(231) + CHR(245) + "es por Origem, Destino ou ambos"

        *-- StatusBarText (texto exibido na status bar enquanto campo recebe foco)
        loc_oCnt.txt_4c_DtInicial.StatusBarText  = "Per" + CHR(237) + "odo: data inicial"
        loc_oCnt.txt_4c_DtFinal.StatusBarText    = "Per" + CHR(237) + "odo: data final"
        loc_oCnt.txt_4c_NmOperacao.StatusBarText = "Filtro por nome da movimenta" + CHR(231) + CHR(227) + "o"
        loc_oCnt.txt_4c_Grupo.StatusBarText      = "Grupo - F4 abre busca por c" + CHR(243) + "digo"
        loc_oCnt.txt_4c_DGrupo.StatusBarText     = "Grupo - F4 abre busca por descri" + CHR(231) + CHR(227) + "o"
        loc_oCnt.txt_4c_Conta.StatusBarText      = "Conta - F4 abre busca por c" + CHR(243) + "digo"
        loc_oCnt.txt_4c_DConta.StatusBarText     = "Conta - F4 abre busca por nome"
        loc_oCnt.obj_4c_OptConta.StatusBarText   = "Filtrar por: Origem (1) / Destino (2) / Todos (3)"

        *-- Habilita campos condicionais conforme regras When do legado:
        *-- DGrupo so editavel se Grupo vazio; DConta so editavel se Grupo
        *-- preenchido e Conta vazia. No estado inicial, ambos descritivos
        *-- ficam habilitados pois codigos estao vazios.
        loc_oCnt.txt_4c_DGrupo.Enabled = EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
        loc_oCnt.txt_4c_DConta.Enabled = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)) AND ;
                                         EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))

        *-- Foco inicial no primeiro campo de filtro (periodo inicial)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            *-- Em modo validacao de UI nao mover foco
        ELSE
            *-- SetFocus executa apos form visivel (chamado pelo AlternarPagina/Init)
        ENDIF
    ENDPROC

    *==========================================================================
    * AlternarPagina - Restaura o estado do form de filtros ao retornar do form
    * de resultados (FormSigPdMp7). Re-habilita inputs, devolve foco para a data
    * inicial e marca o filtro de periodo como ponto de partida da nova consulta.
    * par_nPagina = 1 (LISTA/Filtros) - unico modo deste form OPERACIONAL.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF par_nPagina != 1
            RETURN
        ENDIF

        THIS.Enabled = .T.

        IF VARTYPE(THIS.cnt_4c_Filtros) = "O" AND ;
           TYPE("THIS.cnt_4c_Filtros.txt_4c_DtInicial.Value") != "U"
            THIS.cnt_4c_Filtros.txt_4c_DtInicial.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cabecalho escuro (cntSombra no legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Cadastro de Testes"
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = 769
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = "Cadastro de Testes"
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = 769
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarFiltros - Container de filtros (Container1 no legado) com todos
    * os controles: Labels, TextBoxes de periodo/operacao/grupo/conta, OptionGroup
    * e BINDEVENTs de lookup para Grupo e Conta (F4/ENTER/TAB)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Filtros", "Container")
        WITH THIS.cnt_4c_Filtros
            .Top           = 92
            .Left          = 151
            .Width         = 498
            .Height        = 141
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 2
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(136, 189, 188)
            .Visible       = .T.
        ENDWITH

        loc_oCnt = THIS.cnt_4c_Filtros

        *-- Label "Per?odo :" (lbl_periodo)
        loc_oCnt.AddObject("lbl_4c_Lbl_periodo", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_periodo
            .AutoSize  = .T.
            .Caption   = "Per" + CHR(237) + "odo :"
            .Height    = 15
            .Left      = 61
            .Top       = 13
            .Width     = 45
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox Data Inicial (get_dt_inicial) - tipo Date via .Value = DATE()
        loc_oCnt.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oCnt.txt_4c_DtInicial
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 25
            .Left          = 108
            .SpecialEffect = 1
            .Top           = 9
            .Width         = 80
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = DATE()
        ENDWITH

        *-- Label "?" separador entre datas (lbl_periodo_a)
        loc_oCnt.AddObject("lbl_4c_Lbl_periodo_a", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_periodo_a
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .Left      = 193
            .Top       = 13
            .Width     = 8
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox Data Final (get_dt_final) - tipo Date via .Value = DATE()
        loc_oCnt.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oCnt.txt_4c_DtFinal
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .Height        = 25
            .Left          = 206
            .SpecialEffect = 1
            .Top           = 9
            .Width         = 80
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = DATE()
        ENDWITH

        *-- Label "Movimenta??o :" (Say1)
        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .AutoSize  = .T.
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Height    = 15
            .Left      = 28
            .Top       = 40
            .Width     = 78
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox Opera??o/Movimenta??o (get_nm_operacao) - MaxLength=20, Format=K!
        loc_oCnt.AddObject("txt_4c_NmOperacao", "TextBox")
        WITH loc_oCnt.txt_4c_NmOperacao
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Height        = 25
            .Left          = 108
            .MaxLength     = 20
            .SpecialEffect = 1
            .Top           = 36
            .Width         = 150
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = ""
        ENDWITH

        *-- Label "Grupo :" (Say3)
        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .AutoSize  = .T.
            .Caption   = "Grupo :"
            .Height    = 15
            .Left      = 68
            .Top       = 67
            .Width     = 38
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox C?digo do Grupo (Get_grupo) - F4 abre lookup SigCdGcr por Codigos
        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 108
            .SpecialEffect = 1
            .Top           = 63
            .Width         = 80
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = ""
        ENDWITH

        *-- TextBox Descri??o do Grupo (get_Dgrupo) - F4 abre lookup SigCdGcr por Descrs
        *-- Apenas acess?vel quando txt_4c_Grupo estiver vazio (reproduz When do legado)
        loc_oCnt.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oCnt.txt_4c_DGrupo
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Height            = 23
            .Left              = 189
            .MaxLength         = 40
            .SpecialEffect     = 1
            .Top               = 63
            .Width             = 302
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 128)
            .BorderColor       = RGB(100, 100, 100)
            .Themes            = .F.
            .Value             = ""
        ENDWITH

        *-- Label "Conta :" (Say2)
        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .AutoSize  = .T.
            .Caption   = "Conta :"
            .Height    = 15
            .Left      = 68
            .Top       = 93
            .Width     = 38
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox C?digo da Conta/Funcion?rio (Get_conta) - F4 abre lookup SigCdCli por IClis
        loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Conta
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 108
            .SpecialEffect = 1
            .Top           = 89
            .Width         = 80
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = ""
        ENDWITH

        *-- TextBox Nome da Conta/Funcion?rio (Get_dconta) - F4 abre lookup SigCdCli por RClis
        *-- Apenas acess?vel quando Grupo preenchido e Conta vazia (reproduz When do legado)
        loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oCnt.txt_4c_DConta
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 189
            .SpecialEffect = 1
            .Top           = 89
            .Width         = 303
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Value         = ""
        ENDWITH

        *-- Label "Filtrar por :" (Say4)
        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .AutoSize  = .T.
            .Caption   = "Filtrar por :"
            .Height    = 15
            .Left      = 50
            .Top       = 120
            .Width     = 56
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- OptionGroup "Filtrar por:" (OptConta) - 3 opcoes: Origem/Destino/Todos
        *-- Padrao Value=3 seleciona "Todos" (terceiro botao)
        loc_oCnt.AddObject("obj_4c_OptConta", "OptionGroup")
        WITH loc_oCnt.obj_4c_OptConta
            .ButtonCount   = 3
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 3
            .Height        = 27
            .Left          = 100
            .SpecialEffect = 0
            .Top           = 114
            .Width         = 200

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "Origem"
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 52
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Destino"
                .Left      = 69
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Todos"
                .Height    = 17
                .Left      = 134
                .Top       = 5
                .Width     = 61
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- BINDEVENTs: lookups disparados por ENTER(13)/TAB(9)/F4(115) ou DblClick
        BINDEVENT(loc_oCnt.txt_4c_NmOperacao, "KeyPress", THIS, "TxtNmOperacaoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Grupo,  "KeyPress", THIS, "TxtGrupoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DGrupo, "KeyPress", THIS, "TxtDGrupoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Conta,  "KeyPress", THIS, "TxtContaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DConta, "KeyPress", THIS, "TxtDContaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Grupo,  "DblClick", THIS, "TxtGrupoDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DGrupo, "DblClick", THIS, "TxtDGrupoDblClick")
        BINDEVENT(loc_oCnt.txt_4c_Conta,  "DblClick", THIS, "TxtContaDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DConta, "DblClick", THIS, "TxtDContaDblClick")
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Botao Pesquisar e container Encerrar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Shape decorativo ao redor do botao Encerrar
        *-- (reproduz SpecialEffect=1 + BorderColor do CommandGroup sair do legado)
        THIS.AddObject("shp_4c_Saida", "Shape")
        WITH THIS.shp_4c_Saida
            .Top         = -2
            .Left        = 718
            .Width       = 87
            .Height      = 87
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- Botao Pesquisar (consulta no legado): Top=3, Left=650
        THIS.AddObject("cmd_4c_Pesquisar", "CommandButton")
        WITH THIS.cmd_4c_Pesquisar
            .Top             = 5
            .Left            = 650
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
            .Caption         = "Pesquisar"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .Themes           = .T.
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Pesquisar, "Click", THIS, "CmdPesquisarClick")

        *-- Container Encerrar (sair CommandGroup no legado): Top=-2, Left=720
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top         = -2
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
            .Top             = 5
            .Left            = 5
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .SpecialEffect   = 0
            .PicturePosition = 13
            .Themes          = .F.
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *==========================================================================
    * InicializarFiltros - Define valores default dos filtros no BO
    * Espelho do bloco With .Container1 do Init() original
    *==========================================================================
    PROTECTED PROCEDURE InicializarFiltros()
        THIS.this_oBusinessObject.this_dDtInicial  = DATE()
        THIS.this_oBusinessObject.this_dDtFinal    = DATE()
        THIS.this_oBusinessObject.this_cNmOperacao = ""
        THIS.this_oBusinessObject.this_cGrupo      = ""
        THIS.this_oBusinessObject.this_cDGrupo     = ""
        THIS.this_oBusinessObject.this_cConta      = ""
        THIS.this_oBusinessObject.this_cDConta     = ""
        THIS.this_oBusinessObject.this_nOptConta   = 3
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza valores dos controles de filtro da UI com o BO
    * Usa TYPE() para verificar existencia dos controles de forma segura:
    * funciona tanto antes (Fase 3) quanto depois (Fases 5-6) de criar os TextBoxes
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBo
        loc_oBo = THIS.this_oBusinessObject

        IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
            RETURN
        ENDIF

        IF TYPE("THIS.cnt_4c_Filtros.txt_4c_DtInicial.Value") != "U"
            loc_oBo.this_dDtInicial = THIS.cnt_4c_Filtros.txt_4c_DtInicial.Value
        ENDIF

        IF TYPE("THIS.cnt_4c_Filtros.txt_4c_DtFinal.Value") != "U"
            loc_oBo.this_dDtFinal = THIS.cnt_4c_Filtros.txt_4c_DtFinal.Value
        ENDIF

        IF TYPE("THIS.cnt_4c_Filtros.txt_4c_NmOperacao.Value") != "U"
            loc_oBo.this_cNmOperacao = ALLTRIM(THIS.cnt_4c_Filtros.txt_4c_NmOperacao.Value)
        ENDIF

        IF TYPE("THIS.cnt_4c_Filtros.txt_4c_Grupo.Value") != "U"
            loc_oBo.this_cGrupo = ALLTRIM(THIS.cnt_4c_Filtros.txt_4c_Grupo.Value)
        ENDIF

        IF TYPE("THIS.cnt_4c_Filtros.txt_4c_DGrupo.Value") != "U"
            loc_oBo.this_cDGrupo = ALLTRIM(THIS.cnt_4c_Filtros.txt_4c_DGrupo.Value)
        ENDIF

        IF TYPE("THIS.cnt_4c_Filtros.txt_4c_Conta.Value") != "U"
            loc_oBo.this_cConta = ALLTRIM(THIS.cnt_4c_Filtros.txt_4c_Conta.Value)
        ENDIF

        IF TYPE("THIS.cnt_4c_Filtros.txt_4c_DConta.Value") != "U"
            loc_oBo.this_cDConta = ALLTRIM(THIS.cnt_4c_Filtros.txt_4c_DConta.Value)
        ENDIF

        IF TYPE("THIS.cnt_4c_Filtros.obj_4c_OptConta.Value") != "U"
            loc_oBo.this_nOptConta = THIS.cnt_4c_Filtros.obj_4c_OptConta.Value
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdPesquisarClick - Executa consulta e abre FormSigPdMp7 com resultados
    * Equivale ao consulta.Click do legado: valida periodo, monta SQL, abre SigPdMp7
    *==========================================================================
    PROCEDURE CmdPesquisarClick()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_oFormResultado
        loc_lSucesso = .F.

        TRY
            THIS.FormParaBO()
            loc_cSQL = THIS.this_oBusinessObject.ExecutarConsulta()

            IF !EMPTY(ALLTRIM(loc_cSQL))
                THIS.Enabled = .F.

                TRY
                    loc_oFormResultado = CREATEOBJECT("FormSigPdMp7", loc_cSQL, THIS)
                    IF VARTYPE(loc_oFormResultado) = "O"
                        loc_oFormResultado.Show()
                    ELSE
                        MsgErro("Falha ao criar FormSigPdMp7.", "Erro")
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro("Erro ao abrir resultados: " + loc_oErro.Message, "Erro")
                ENDTRY

                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.AlternarPagina(1)
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE CmdEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Nova consulta: restaura filtros aos valores padrao
    * (data inicial/final = hoje, demais campos vazios, OptionGroup = Todos).
    * Equivalente operacional ao "incluir" CRUD: prepara o form para uma nova
    * consulta limpa, devolvendo o estado inicial do Init() do legado.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oCnt, loc_oErro
        TRY
            IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
                RETURN
            ENDIF
            loc_oCnt = THIS.cnt_4c_Filtros

            loc_oCnt.txt_4c_DtInicial.Value  = DATE()
            loc_oCnt.txt_4c_DtFinal.Value    = DATE()
            loc_oCnt.txt_4c_NmOperacao.Value = ""
            loc_oCnt.txt_4c_Grupo.Value      = ""
            loc_oCnt.txt_4c_DGrupo.Value     = ""
            loc_oCnt.txt_4c_Conta.Value      = ""
            loc_oCnt.txt_4c_DConta.Value     = ""
            loc_oCnt.obj_4c_OptConta.Value   = 3

            *-- Re-sincroniza BO e re-aplica regras de habilitacao (When do legado)
            THIS.InicializarFiltros()
            loc_oCnt.txt_4c_DGrupo.Enabled = .T.
            loc_oCnt.txt_4c_DConta.Enabled = .F.

            loc_oCnt.txt_4c_DtInicial.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Modificar filtros: re-habilita o form (caso esteja
    * Enabled=.F. apos abrir resultados) e leva o foco para o primeiro campo
    * para permitir edicao imediata dos criterios de consulta.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oCnt, loc_oErro
        TRY
            IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
                RETURN
            ENDIF
            loc_oCnt = THIS.cnt_4c_Filtros

            THIS.Enabled = .T.

            *-- Re-aplica regras de habilitacao condicional (When do legado):
            *-- DGrupo so editavel se Grupo vazio
            loc_oCnt.txt_4c_DGrupo.Enabled = EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
            *-- DConta so editavel se Grupo preenchido e Conta vazia
            loc_oCnt.txt_4c_DConta.Enabled = !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)) AND ;
                                              EMPTY(ALLTRIM(loc_oCnt.txt_4c_Conta.Value))

            loc_oCnt.txt_4c_DtInicial.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar resultado: executa a consulta atual
    * (alias operacional do botao Pesquisar do legado, que abre FormSigPdMp7
    * com as movimentacoes filtradas para visualizacao em grid).
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        RETURN THIS.CmdPesquisarClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Limpar filtros: zera todos os campos de criterio
    * (utilitario para o usuario remover filtros restritivos antes de uma
    * nova consulta ampla). Mantem periodo padrao para evitar consulta sem
    * limite temporal.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oCnt, loc_oErro
        TRY
            IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
                RETURN
            ENDIF
            IF !MsgConfirma("Limpar todos os filtros desta consulta?", ;
                            "Confirma" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            loc_oCnt = THIS.cnt_4c_Filtros

            loc_oCnt.txt_4c_NmOperacao.Value = ""
            loc_oCnt.txt_4c_Grupo.Value      = ""
            loc_oCnt.txt_4c_DGrupo.Value     = ""
            loc_oCnt.txt_4c_Conta.Value      = ""
            loc_oCnt.txt_4c_DConta.Value     = ""
            loc_oCnt.obj_4c_OptConta.Value   = 3

            *-- Mantem periodo padrao (hoje-hoje) para evitar consulta sem limite
            loc_oCnt.txt_4c_DtInicial.Value  = DATE()
            loc_oCnt.txt_4c_DtFinal.Value    = DATE()

            *-- Sincroniza BO e re-aplica regras de habilitacao (When do legado)
            THIS.FormParaBO()
            loc_oCnt.txt_4c_DGrupo.Enabled = .T.
            loc_oCnt.txt_4c_DConta.Enabled = .F.

            loc_oCnt.txt_4c_DtInicial.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * TxtNmOperacaoKeyPress - Normaliza o filtro de nome de operacao ao sair
    * Reproduz get_nm_operacao.Valid do legado (fAcessoMovInd era controle de
    * acesso do Framework; no novo sistema o campo e filtro LIKE aceita qualquer
    * valor e o Format="K!" ja converte para maiusculas automaticamente)
    *==========================================================================
    PROCEDURE TxtNmOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(THIS.cnt_4c_Filtros.txt_4c_NmOperacao.Value)
        THIS.cnt_4c_Filtros.txt_4c_NmOperacao.Value = loc_cValor
    ENDPROC

    *==========================================================================
    * TxtGrupoKeyPress - Abre lookup de grupo financeiro por c?digo
    * Dispara em ENTER(13), TAB(9) ou F4(115)
    *==========================================================================
    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaGrupo()
    ENDPROC

    *==========================================================================
    * TxtDGrupoKeyPress - Abre lookup de grupo financeiro por descri??o
    * Reproduz o When legado: apenas quando txt_4c_Grupo estiver vazio
    *==========================================================================
    PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.cnt_4c_Filtros.txt_4c_Grupo.Value))
            RETURN
        ENDIF
        THIS.AbrirBuscaGrupoPorDesc()
    ENDPROC

    *==========================================================================
    * TxtContaKeyPress - Abre lookup de conta/funcion?rio por c?digo (IClis)
    *==========================================================================
    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaConta()
    ENDPROC

    *==========================================================================
    * TxtDContaKeyPress - Abre lookup de conta/funcion?rio por nome (RClis)
    * Reproduz o When legado: apenas quando Grupo preenchido e Conta vazia
    *==========================================================================
    PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.cnt_4c_Filtros.txt_4c_Grupo.Value)) OR ;
           !EMPTY(ALLTRIM(THIS.cnt_4c_Filtros.txt_4c_Conta.Value))
            RETURN
        ENDIF
        THIS.AbrirBuscaContaPorDesc()
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrupo - FormBuscaAuxiliar para SigCdGcr pesquisando por Codigos
    * Preenche txt_4c_Grupo (codigos) e txt_4c_DGrupo (descrs) ao selecionar
    *==========================================================================
    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oCnt, loc_cValor, loc_oBusca, loc_oErro

        loc_oCnt   = THIS.cnt_4c_Filtros
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupo", "codigos", loc_cValor, ;
                "Busca de Grupos Financeiros")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    *-- Auto-encontrou e selecionou registro unico
                    IF USED("cursor_4c_BuscaGrupo")
                        loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
                        loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    *-- Nao encontrou (ou valor vazio): exibe lista para selecao
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                        loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
                        loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrupoPorDesc - FormBuscaAuxiliar para SigCdGcr pesquisando por Descrs
    * Usado quando usu?rio digita descri??o em txt_4c_DGrupo
    * Preenche txt_4c_Grupo (codigos) e txt_4c_DGrupo (descrs) ao selecionar
    *==========================================================================
    PROCEDURE AbrirBuscaGrupoPorDesc()
        LOCAL loc_oCnt, loc_cValor, loc_oBusca, loc_oErro

        loc_oCnt   = THIS.cnt_4c_Filtros
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DGrupo.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrupo", "descrs", loc_cValor, ;
                "Busca de Grupos por Descri" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    *-- Auto-encontrou e selecionou registro unico
                    IF USED("cursor_4c_BuscaGrupo")
                        loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
                        loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    *-- Nao encontrou (ou valor vazio): exibe lista para selecao
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                        loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.codigos)
                        loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaConta - FormBuscaAuxiliar para SigCdCli pesquisando por IClis
    * Preenche txt_4c_Conta (IClis) e txt_4c_DConta (RClis) ao selecionar
    * Se txt_4c_Grupo vazio, tamb?m preenche com Grupos do registro selecionado
    *==========================================================================
    PROCEDURE AbrirBuscaConta()
        LOCAL loc_oCnt, loc_cValor, loc_oBusca, loc_oErro

        loc_oCnt   = THIS.cnt_4c_Filtros
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "IClis", loc_cValor, ;
                "Busca de Contas/Funcion" + CHR(225) + "rios")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    *-- Auto-encontrou e selecionou registro unico
                    IF USED("cursor_4c_BuscaConta")
                        loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                        loc_oCnt.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                        IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
                            loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaConta.Grupos)
                        ENDIF
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    *-- Nao encontrou (ou valor vazio): exibe lista para selecao
                    loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("RClis",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Grupos", "", "Grupo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                        loc_oCnt.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                        IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
                            loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaConta.Grupos)
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaContaPorDesc - FormBuscaAuxiliar para SigCdCli pesquisando por RClis
    * Usado quando usu?rio digita nome em txt_4c_DConta
    * Preenche txt_4c_Conta (IClis) e txt_4c_DConta (RClis) ao selecionar
    *==========================================================================
    PROCEDURE AbrirBuscaContaPorDesc()
        LOCAL loc_oCnt, loc_cValor, loc_oBusca, loc_oErro

        loc_oCnt   = THIS.cnt_4c_Filtros
        loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DConta.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaConta", "RClis", loc_cValor, ;
                "Busca por Nome/Raz" + CHR(227) + "o Social")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    *-- Auto-encontrou e selecionou registro unico
                    IF USED("cursor_4c_BuscaConta")
                        loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                        loc_oCnt.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    *-- Nao encontrou (ou valor vazio): exibe lista para selecao
                    loc_oBusca.mAddColuna("RClis",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Grupos", "", "Grupo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                        loc_oCnt.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
    ENDPROC

    *==========================================================================
    * Handlers DblClick - chamam os mesmos metodos de lookup dos KeyPress
    *==========================================================================
    PROCEDURE TxtGrupoDblClick()
        THIS.AbrirBuscaGrupo()
    ENDPROC

    PROCEDURE TxtDGrupoDblClick()
        IF !EMPTY(ALLTRIM(THIS.cnt_4c_Filtros.txt_4c_Grupo.Value))
            RETURN
        ENDIF
        THIS.AbrirBuscaGrupoPorDesc()
    ENDPROC

    PROCEDURE TxtContaDblClick()
        THIS.AbrirBuscaConta()
    ENDPROC

    PROCEDURE TxtDContaDblClick()
        IF EMPTY(ALLTRIM(THIS.cnt_4c_Filtros.txt_4c_Grupo.Value)) OR ;
           !EMPTY(ALLTRIM(THIS.cnt_4c_Filtros.txt_4c_Conta.Value))
            RETURN
        ENDIF
        THIS.AbrirBuscaContaPorDesc()
    ENDPROC

    *==========================================================================
    * BOParaForm - Sincroniza valores do BO de volta para os controles da UI
    * Inverso de FormParaBO: usado apos CarregarDoCursor ou InicializarFiltros
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBo, loc_oCnt
        loc_oBo = THIS.this_oBusinessObject

        IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
            RETURN
        ENDIF
        loc_oCnt = THIS.cnt_4c_Filtros

        IF TYPE("loc_oCnt.txt_4c_DtInicial.Value") != "U"
            loc_oCnt.txt_4c_DtInicial.Value = loc_oBo.this_dDtInicial
        ENDIF

        IF TYPE("loc_oCnt.txt_4c_DtFinal.Value") != "U"
            loc_oCnt.txt_4c_DtFinal.Value = loc_oBo.this_dDtFinal
        ENDIF

        IF TYPE("loc_oCnt.txt_4c_NmOperacao.Value") != "U"
            loc_oCnt.txt_4c_NmOperacao.Value = loc_oBo.this_cNmOperacao
        ENDIF

        IF TYPE("loc_oCnt.txt_4c_Grupo.Value") != "U"
            loc_oCnt.txt_4c_Grupo.Value = loc_oBo.this_cGrupo
        ENDIF

        IF TYPE("loc_oCnt.txt_4c_DGrupo.Value") != "U"
            loc_oCnt.txt_4c_DGrupo.Value = loc_oBo.this_cDGrupo
        ENDIF

        IF TYPE("loc_oCnt.txt_4c_Conta.Value") != "U"
            loc_oCnt.txt_4c_Conta.Value = loc_oBo.this_cConta
        ENDIF

        IF TYPE("loc_oCnt.txt_4c_DConta.Value") != "U"
            loc_oCnt.txt_4c_DConta.Value = loc_oBo.this_cDConta
        ENDIF

        IF TYPE("loc_oCnt.obj_4c_OptConta.Value") != "U"
            loc_oCnt.obj_4c_OptConta.Value = loc_oBo.this_nOptConta
        ENDIF

        *-- Re-aplica regras de habilitacao condicional (When do legado)
        loc_oCnt.txt_4c_DGrupo.Enabled = EMPTY(ALLTRIM(loc_oBo.this_cGrupo))
        loc_oCnt.txt_4c_DConta.Enabled = !EMPTY(ALLTRIM(loc_oBo.this_cGrupo)) AND ;
                                         EMPTY(ALLTRIM(loc_oBo.this_cConta))
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita todos os controles de filtro
    * par_lHabilitar = .T. para habilitar, .F. para desabilitar
    * Preserva as regras de habilitacao condicional (When do legado) quando
    * par_lHabilitar = .T.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oCnt, loc_cGrupo, loc_cConta
        IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
            RETURN
        ENDIF
        loc_oCnt  = THIS.cnt_4c_Filtros
        loc_cGrupo = ""
        loc_cConta = ""

        IF par_lHabilitar
            loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
            loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
        ENDIF

        loc_oCnt.txt_4c_DtInicial.Enabled   = par_lHabilitar
        loc_oCnt.txt_4c_DtFinal.Enabled     = par_lHabilitar
        loc_oCnt.txt_4c_NmOperacao.Enabled  = par_lHabilitar
        loc_oCnt.txt_4c_Grupo.Enabled       = par_lHabilitar
        loc_oCnt.txt_4c_Conta.Enabled       = par_lHabilitar
        loc_oCnt.obj_4c_OptConta.Enabled    = par_lHabilitar

        *-- DGrupo: apenas editavel quando Grupo vazio (preserva When do legado)
        IF par_lHabilitar
            loc_oCnt.txt_4c_DGrupo.Enabled = EMPTY(loc_cGrupo)
        ELSE
            loc_oCnt.txt_4c_DGrupo.Enabled = .F.
        ENDIF

        *-- DConta: apenas editavel quando Grupo preenchido e Conta vazia (When do legado)
        IF par_lHabilitar
            loc_oCnt.txt_4c_DConta.Enabled = !EMPTY(loc_cGrupo) AND EMPTY(loc_cConta)
        ELSE
            loc_oCnt.txt_4c_DConta.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera todos os campos de filtro retornando ao estado inicial
    * Datas voltam para DATA() (hoje) para evitar consulta sem limite temporal
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oCnt
        IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
            RETURN
        ENDIF
        loc_oCnt = THIS.cnt_4c_Filtros

        loc_oCnt.txt_4c_DtInicial.Value  = DATE()
        loc_oCnt.txt_4c_DtFinal.Value    = DATE()
        loc_oCnt.txt_4c_NmOperacao.Value = ""
        loc_oCnt.txt_4c_Grupo.Value      = ""
        loc_oCnt.txt_4c_DGrupo.Value     = ""
        loc_oCnt.txt_4c_Conta.Value      = ""
        loc_oCnt.txt_4c_DConta.Value     = ""
        loc_oCnt.obj_4c_OptConta.Value   = 3

        *-- Sincroniza BO e re-aplica regras de habilitacao (When do legado)
        THIS.InicializarFiltros()
        loc_oCnt.txt_4c_DGrupo.Enabled = .T.
        loc_oCnt.txt_4c_DConta.Enabled = .F.
    ENDPROC

    *==========================================================================
    * CarregarLista - Para forms OPERACIONAIS planos (sem grid de lista),
    * sincroniza os valores do BO para a UI (BOParaForm).
    * Nao executa SQLEXEC - a consulta so roda quando usuario clica Pesquisar.
    *==========================================================================
    PROCEDURE CarregarLista()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            THIS.BOParaForm()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Form OPERACIONAL nao tem modos CRUD (INCLUIR/
    * ALTERAR/VISUALIZAR). Garante que o botao Pesquisar permaneca sempre
    * habilitado e que o form esteja em estado interativo apos retorno de
    * FormSigPdMp7.
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        THIS.Enabled = .T.

        IF VARTYPE(THIS.cmd_4c_Pesquisar) = "O"
            THIS.cmd_4c_Pesquisar.Enabled = .T.
        ENDIF

        IF VARTYPE(THIS.cnt_4c_Saida) = "O" AND ;
           VARTYPE(THIS.cnt_4c_Saida.cmd_4c_Encerrar) = "O"
            THIS.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = .T.
        ENDIF

        THIS.HabilitarCampos(.T.)
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Botao Buscar: equivale ao Pesquisar no contexto OPERACIONAL
    * Executa a consulta com os filtros atuais e abre FormSigPdMp7
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CmdPesquisarClick()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Botao Encerrar via framework: fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - No contexto OPERACIONAL (sem CRUD), "salvar" equivale a
    * executar a consulta: sincroniza filtros no BO e abre FormSigPdMp7
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.CmdPesquisarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancelar: limpa todos os filtros retornando ao estado
    * inicial (equivale a "nova consulta" no contexto OPERACIONAL)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()

        IF VARTYPE(THIS.cnt_4c_Filtros) = "O" AND ;
           TYPE("THIS.cnt_4c_Filtros.txt_4c_DtInicial.Value") != "U"
            THIS.cnt_4c_Filtros.txt_4c_DtInicial.SetFocus()
        ENDIF
    ENDPROC

ENDDEFINE
