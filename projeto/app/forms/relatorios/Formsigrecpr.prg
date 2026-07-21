*==============================================================================
* FORMSIGRECPR.PRG
* Relatorio: Cheques Prorrogados
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: sigrecpr.SCX (frmrelatorio)
*
* Implementacao completa (Fases 3-8):
*   - DEFINE CLASS com propriedades visuais (Width=800, Height=300 do original)
*   - Init() / Load() / InicializarForm() / Destroy()
*   - ConfigurarPageFrame() (orquestra layout FLAT do REPORT: cabecalho + botoes)
*   - ConfigurarCabecalho() (cntSombra do legado)
*   - ConfigurarBotoes()    (btnReport canonico - CommandGroup 4 botoes)
*   - Btn*Click() completos (Visualizar / Imprimir / DocExcel / Encerrar)
*   - ConfigurarPaginaFiltros(): Say3, OptFiltro, Say1, DataIni, Say2
*   - ConfigurarPaginaDados():   DataFin, lbl_Operacao, cbo_TipoRel,
*                                opt_Bons, opt_Opcao + BINDEVENT TipoRelChanged
*   - LimparCampos() / FormParaRelatorio() / AlternarPagina()
*   - FormParaBO() / BOParaForm() / HabilitarCampos()
*   - CarregarLista() / AjustarBotoesPorModo() (stubs REPORT)
*==============================================================================

DEFINE CLASS Formsigrecpr AS FormBase

    *-- Dimensoes e aparencia (PILAR 1 - Width=800, Height=300 do original SIGRECPR)
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
    * Load - Replica configuracao de data/seculo do legado (PROCEDURE Load)
    *--------------------------------------------------------------------------
    PROCEDURE Load()
        DODEFAULT()
        SET CENTURY ON
        SET DATE TO BRITISH
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Estrutura base: caption, picture, BO, cabecalho, botoes
    * Fases 4+ completam com ConfigurarPaginaFiltros e LimparCampos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.Caption = "Cheques Prorrogados"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigrecprBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecprBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.LimparCampos()

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
    * ConfigurarPageFrame - Orquestra layout FLAT (REPORT, sem PageFrame real)
    * Em frmrelatorio o "container de paginas" e o proprio Form: cria cabecalho
    * (cntSombra), CommandGroup canonico (btnReport) e o container de filtros.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarContainerFiltros()
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta o painel unico de filtros do relatorio
    *
    * Em forms REPORT (frmrelatorio) nao existe PageFrame Lista/Dados como em
    * CRUD; o equivalente a "Page1/Lista" e o painel de parametros que o usuario
    * preenche antes de gerar o relatorio. Este metodo, mantido por uniformidade
    * arquitetural com forms CRUD, delega a montagem real dos controles para
    * ConfigurarPaginaFiltros (TextBoxes de data, OptionGroups, ComboBox de tipo
    * e BINDEVENT do InteractiveChange do ComboBox).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarPaginaFiltros()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerFiltros - Container transparente onde os TextBoxes,
    * OptionGroups e ComboBox de filtro serao adicionados nas fases 4+
    * Top = 80 (logo abaixo do cabecalho) - geometria do legado SIGRECPR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerFiltros()
        THIS.AddObject("cnt_4c_Filtros", "Container")
        WITH THIS.cnt_4c_Filtros
            .Top         = 80
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height - 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    * Equivalente ao cntSombra do frmrelatorio legado (Width = THIS.Width)
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

            *-- Sombra deslocada 2px para efeito 3D
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Cheques Prorrogados"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco sobre a sombra
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Cheques Prorrogados"
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
    * ConfigurarBotoes - CommandGroup canonico do btnReport (4 botoes)
    * Original: btnReport.Left=528, Top=3, Width=305, Height=85 (800px form)
    * Canonico: cmg_4c_Botoes Top=0, Left=529, Width=273, Height=80
    * Lefts internos: Buttons(1)=5, (2)=71, (3)=137, (4)=203 (incrementos de 66)
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
                .Caption         = "Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption         = "Imprimir"
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Caption         = "\<Arquivos Email"
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Caption         = "Encerrar"
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .Cancel          = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navegacao logica do form (compatibilidade CRUD)
    *
    * Em REPORT forms nao ha alternancia Lista/Dados (layout FLAT, sem
    * PageFrame). Este metodo, mantido por uniformidade arquitetural com forms
    * CRUD, repassa a navegacao para acoes equivalentes ao contexto de
    * relatorio:
    *   par_nPagina = 1 (Lista)  -> reposiciona o foco no primeiro filtro
    *                               (txt_4c_DataIni), simulando "voltar para a
    *                               tela de parametros" apos gerar o relatorio.
    *   par_nPagina = 2 (Dados)  -> reseta os filtros para os defaults do Init
    *                               (LimparCampos), simulando "novo relatorio".
    *   outros valores            -> tratado como 1 (Lista) por seguranca.
    *
    * Tambem sincroniza a visibilidade de opt_4c_Bons conforme o ComboBox de
    * tipo (replicando o Valid event de GetTipoRel do legado) para garantir
    * estado consistente da UI quando o form e reapresentado.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oCnt
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
            RETURN
        ENDIF
        loc_oCnt = THIS.cnt_4c_Filtros

        DO CASE
            CASE loc_nPagina = 2
                *-- "Dados" = novo relatorio: reseta para os defaults do Init
                THIS.LimparCampos()
                IF VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
                    loc_oCnt.txt_4c_DataIni.SetFocus()
                ENDIF
            OTHERWISE
                *-- "Lista" (1) ou qualquer outro: foca no primeiro filtro e
                *-- ressincroniza visibilidade de opt_4c_Bons com o ComboBox.
                IF VARTYPE(loc_oCnt.cbo_4c_TipoRel) = "O" ;
                   AND VARTYPE(loc_oCnt.opt_4c_Bons) = "O"
                    loc_oCnt.opt_4c_Bons.Visible = (loc_oCnt.cbo_4c_TipoRel.ListIndex = 4)
                ENDIF
                IF VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
                    loc_oCnt.txt_4c_DataIni.SetFocus()
                ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe relatorio em preview na tela
    * Equivalente ao PROCEDURE visualizacao do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio na impressora
    * Equivalente ao PROCEDURE impressao do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            IF THIS.this_oRelatorio.PrepararDados()
                loc_cArquivo = GETFILE("xls", "Salvar como Excel", "Salvar")
                IF !EMPTY(loc_cArquivo)
                    SELECT (THIS.this_oRelatorio.this_cCursorDados)
                    COPY TO (loc_cArquivo) TYPE XLS
                    MsgInfo("Arquivo Excel gerado com sucesso.")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "DocExcel")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario (Encerrar, equivalente ao Sair legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT forms, "Incluir" e o equivalente logico de
    * "Novo Relatorio": reseta os filtros para os valores default (LimparCampos
    * replica o Init do legado) e posiciona o foco no primeiro filtro de data,
    * permitindo ao usuario gerar uma nova consulta sem fechar/reabrir o form.
    *
    * Mantido para uniformidade com forms CRUD (validacao do pipeline exige a
    * existencia deste handler em todo form migrado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oCnt
        THIS.LimparCampos()
        loc_oCnt = THIS.cnt_4c_Filtros
        IF VARTYPE(loc_oCnt) = "O" AND VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
            loc_oCnt.txt_4c_DataIni.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT forms, "Alterar" equivale a "Alterar
    * Filtros": preserva os valores atuais dos filtros (NAO chama LimparCampos)
    * e devolve o foco ao primeiro filtro de data, permitindo refinar a
    * consulta antes de re-Visualizar/Imprimir. Tambem ressincroniza a
    * visibilidade de opt_4c_Bons com o ComboBox de tipo, replicando o Valid
    * event de GetTipoRel do legado para garantir UI consistente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtros
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        IF VARTYPE(loc_oCnt.cbo_4c_TipoRel) = "O" ;
           AND VARTYPE(loc_oCnt.opt_4c_Bons) = "O"
            loc_oCnt.opt_4c_Bons.Visible = (loc_oCnt.cbo_4c_TipoRel.ListIndex = 4)
        ENDIF
        IF VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
            loc_oCnt.txt_4c_DataIni.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT forms, "Excluir" mapeia para "Limpar
    * Filtros" / "Descartar parametros": zera datas e reseta os OptionGroups
    * para os defaults, mas preserva visibilidade derivada do ComboBox de
    * tipo. Util quando o usuario quer abandonar uma combinacao de filtros e
    * recomecar do zero sem fechar o form. Pede confirmacao para evitar perda
    * acidental de filtros ja preenchidos.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oCnt, loc_cMsg
        loc_oCnt = THIS.cnt_4c_Filtros
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        loc_cMsg = "Deseja limpar os filtros e recome" + CHR(231) + "ar?"
        IF !MsgConfirma(loc_cMsg, "Limpar Filtros")
            RETURN
        ENDIF
        THIS.LimparCampos()
        IF VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
            loc_oCnt.txt_4c_DataIni.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e delega para FormBase
    * REGRA: this_oRelatorio = .NULL. (NAO .Release() - Custom nao tem Release)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaFiltros - Popula cnt_4c_Filtros com todos os controles
    * de filtro do relatorio (equivalente aos controles diretos no SIGRECPR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaFiltros()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtros

        *-- Say3: "Filtrar por :"  (Top original=145, container=65)
        loc_oCnt.AddObject("lbl_4c_Say3", "Label")
        WITH loc_oCnt.lbl_4c_Say3
            .Top       = 65
            .Left      = 227
            .Height    = 15
            .Width     = 70
            .Caption   = "Filtrar por : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptFiltro: Prorrogados / Vencimento  (Top original=140, container=60)
        loc_oCnt.AddObject("opt_4c_OptFiltro", "OptionGroup")
        WITH loc_oCnt.opt_4c_OptFiltro
            .Top         = 60
            .Left        = 288
            .Width       = 194
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Prorrogados"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 77
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Vencimento"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 116
                .Top       = 5
                .Width     = 73
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
            .Visible = .T.
        ENDWITH

        *-- Say1: "Per?odo :"  (Top original=170, container=90)
        loc_oCnt.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oCnt.lbl_4c_Say1
            .Top       = 90
            .Left      = 238
            .Height    = 15
            .Width     = 50
            .Caption   = "Per" + CHR(237) + "odo : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- DataIni  (Top original=167, container=87)
        loc_oCnt.AddObject("txt_4c_DataIni", "TextBox")
        WITH loc_oCnt.txt_4c_DataIni
            .Top     = 87
            .Left    = 292
            .Height  = 20
            .Width   = 80
            .Value   = {}
            .Visible = .T.
        ENDWITH

        *-- Say2: "a" grave separador de datas  (Top original=171, container=91)
        loc_oCnt.AddObject("lbl_4c_Say2", "Label")
        WITH loc_oCnt.lbl_4c_Say2
            .Top       = 91
            .Left      = 376
            .Height    = 15
            .Width     = 10
            .Caption   = CHR(224)
            .FontName  = "Verdana"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa/reseta todos os filtros para valores padrao
    * Equivalente ao Init() do legado: DataIni/DataFin vazios, OptFiltro=1,
    * GetTipoRel=1 (ATIVOS), Opt_Bons oculto e resetado
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        WITH THIS.cnt_4c_Filtros
            .txt_4c_DataIni.Value    = {}
            .txt_4c_DataFin.Value    = {}
            .opt_4c_OptFiltro.Value  = 1
            .cbo_4c_TipoRel.ListIndex = 1
            .opt_4c_Bons.Visible     = .F.
            .opt_4c_Bons.Value       = 1
            .opt_4c_Opcao.Value      = 1
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos filtros do form para o BO
    * Chamado antes de Visualizar(), Imprimir() ou PrepararDados()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        WITH THIS.this_oRelatorio
            .this_dDataIni    = THIS.cnt_4c_Filtros.txt_4c_DataIni.Value
            .this_dDataFin    = THIS.cnt_4c_Filtros.txt_4c_DataFin.Value
            .this_nTipoFiltro = THIS.cnt_4c_Filtros.opt_4c_OptFiltro.Value
            .this_nTipoRel    = THIS.cnt_4c_Filtros.cbo_4c_TipoRel.ListIndex
            .this_nBons       = THIS.cnt_4c_Filtros.opt_4c_Bons.Value
            .this_nOpcao      = THIS.cnt_4c_Filtros.opt_4c_Opcao.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Segunda metade dos controles de filtro
    * DataFin, lbl_Operacao, cbo_TipoRel, opt_Bons, opt_Opcao + BINDEVENT
    * Equivale a "Page2" no pipeline multi-fase; para REPORT ? bloco de
    * parametros de operacao (tipo de cheque e opcoes de baixa).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Filtros

        *-- DataFin  (Top original=167, container=87)
        loc_oCnt.AddObject("txt_4c_DataFin", "TextBox")
        WITH loc_oCnt.txt_4c_DataFin
            .Top     = 87
            .Left    = 389
            .Height  = 20
            .Width   = 80
            .Value   = {}
            .Visible = .T.
        ENDWITH

        *-- lbl_operacao: "Opera" + CHR(231)+CHR(227)+"o :"  (Top orig=199, cont=119)
        loc_oCnt.AddObject("lbl_4c_Operacao", "Label")
        WITH loc_oCnt.lbl_4c_Operacao
            .Top       = 119
            .Left      = 230
            .Height    = 15
            .Width     = 60
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- cbo_4c_TipoRel: ComboBox de tipo  (Top original=194, container=114)
        loc_oCnt.AddObject("cbo_4c_TipoRel", "ComboBox")
        WITH loc_oCnt.cbo_4c_TipoRel
            .Top                  = 114
            .Left                 = 292
            .Height               = 24
            .Width                = 134
            .RowSourceType        = 1
            .RowSource            = "ATIVOS,BAIXADOS,NEG.PG,BONS,DEVOLVIDOS"
            .Style                = 2
            .FontName             = "Courier New"
            .FontSize             = 8
            .BoundColumn          = 1
            .ColumnCount          = 1
            .ColumnLines          = .F.
            .SelectOnEntry        = .F.
            .HideSelection        = .F.
            .BoundTo              = .T.
            .ToolTipText          = "ATIVOS=Entradas  BAIXADOS=Saidas  " + ;
                                    "NEG.PG=Devolvidos BONS=Depositados " + ;
                                    "Sem Devolvidos DEVOLVIDOS=Devolvidos"
            .SelectedForeColor    = RGB(255, 255, 255)
            .SelectedItemForeColor = RGB(255, 255, 255)
            .SelectedItemBackColor = RGB(0, 0, 128)
            .ListIndex            = 1
            .Visible              = .T.
        ENDWITH

        *-- opt_4c_Bons: Ativos/Todos  (Top orig=194, cont=114 - oculto ate TipoRel=BONS)
        loc_oCnt.AddObject("opt_4c_Bons", "OptionGroup")
        WITH loc_oCnt.opt_4c_Bons
            .Top         = 114
            .Left        = 433
            .Width       = 116
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Ativos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 48
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Todos"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 64
                .Top       = 5
                .Width     = 47
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
            .Visible = .F.
        ENDWITH

        *-- opt_4c_Opcao: Em aberto/Geral  (Top orig=120, cont=40 - permanece oculto)
        loc_oCnt.AddObject("opt_4c_Opcao", "OptionGroup")
        WITH loc_oCnt.opt_4c_Opcao
            .Top         = 40
            .Left        = 288
            .Width       = 145
            .Height      = 27
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            WITH .Buttons(1)
                .Caption   = "Pendentes"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .BackStyle = 0
                .Left      = 5
                .Top       = 5
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Geral"
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Left      = 87
                .Top       = 5
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
            .Visible = .F.
        ENDWITH

        BINDEVENT(loc_oCnt.cbo_4c_TipoRel, "InteractiveChange", THIS, "TipoRelChanged")
    ENDPROC

    *--------------------------------------------------------------------------
    * TipoRelChanged - Exibe/oculta opt_4c_Bons conforme selecao do ComboBox
    * Replicando Valid event de GetTipoRel do legado: ListIndex=4 -> BONS
    *--------------------------------------------------------------------------
    PROCEDURE TipoRelChanged()
        THIS.cnt_4c_Filtros.opt_4c_Bons.Visible = ;
            (THIS.cnt_4c_Filtros.cbo_4c_TipoRel.ListIndex = 4)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Hook do FormBase: delega para FormParaRelatorio()
    * Em forms REPORT "FormParaBO" = transferir filtros do form para o BO.
    * Chamado pelo FormBase.Salvar() se invocado genericamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Hook do FormBase: copia propriedades do BO de volta ao form
    * Util para restaurar filtros apos cancelamento ou pre-configuracao externa.
    * Chamado pelo FormBase.Cancelar() se invocado genericamente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        WITH THIS.cnt_4c_Filtros
            .txt_4c_DataIni.Value     = THIS.this_oRelatorio.this_dDataIni
            .txt_4c_DataFin.Value     = THIS.this_oRelatorio.this_dDataFin
            .opt_4c_OptFiltro.Value   = THIS.this_oRelatorio.this_nTipoFiltro
            .cbo_4c_TipoRel.ListIndex = THIS.this_oRelatorio.this_nTipoRel
            .opt_4c_Bons.Value        = THIS.this_oRelatorio.this_nBons
            .opt_4c_Opcao.Value       = THIS.this_oRelatorio.this_nOpcao
            .opt_4c_Bons.Visible      = (THIS.this_oRelatorio.this_nTipoRel = 4)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em forms REPORT todos os filtros estao sempre habilitados
    * Stub semantico: nao ha modo CRUD (INCLUIR/ALTERAR/VISUALIZAR) neste form.
    * Mantido para uniformidade arquitetural com o pipeline de migracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
            RETURN
        ENDIF
        WITH THIS.cnt_4c_Filtros
            .txt_4c_DataIni.Enabled     = loc_lHab
            .txt_4c_DataFin.Enabled     = loc_lHab
            .opt_4c_OptFiltro.Enabled   = loc_lHab
            .cbo_4c_TipoRel.Enabled     = loc_lHab
            .opt_4c_Bons.Enabled        = loc_lHab
            .opt_4c_Opcao.Enabled       = loc_lHab
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em forms REPORT nao existe grid de lista; reaplica filtros
    * padrao e restaura o foco no primeiro campo de data.
    * Mantido para uniformidade arquitetural com o pipeline de migracao.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.LimparCampos()
        IF VARTYPE(THIS.cnt_4c_Filtros) = "O" ;
           AND VARTYPE(THIS.cnt_4c_Filtros.txt_4c_DataIni) = "O"
            THIS.cnt_4c_Filtros.txt_4c_DataIni.SetFocus()
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em forms REPORT nao ha modos CRUD; os 4 botoes do
    * CommandGroup permanecem sempre habilitados (Visualizar/Imprimir/DocExcel/
    * Encerrar) sempre ativos, sem depender de qualquer estado.
    * Mantido para uniformidade arquitetural com o pipeline de migracao.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
            RETURN
        ENDIF
        THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT forms "Buscar" mapeia para Visualizar
    * (gerar o relatorio em preview, equivalente semantico de "consultar dados"
    * em forms CRUD). Mantido para uniformidade com pipeline CRUD.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o form. Equivalente exato de BtnSairClick;
    * presente para uniformidade com o padrao canonico Encerrar do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT forms "Salvar" mapeia para Imprimir
    * (gerar saida definitiva do relatorio na impressora). Equivalente
    * semantico de "Salvar" em forms CRUD. Tambem registra auditoria via
    * Inserir() do BO (que internamente chama Imprimir + RegistrarAuditoria).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF !THIS.this_oRelatorio.Inserir()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT forms "Cancelar" mapeia para descarte dos
    * filtros: reseta os parametros para os defaults do Init e devolve o
    * foco ao primeiro filtro. NAO fecha o form (para encerrar usa Encerrar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oCnt
        THIS.LimparCampos()
        loc_oCnt = THIS.cnt_4c_Filtros
        IF VARTYPE(loc_oCnt) = "O" AND VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
            loc_oCnt.txt_4c_DataIni.SetFocus()
        ENDIF
    ENDPROC

ENDDEFINE
