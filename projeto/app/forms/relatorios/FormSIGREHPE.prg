*==============================================================================
* FORMSIGREHPE.PRG
* Relatorio SIGREHPE - Resumo de Cheques em Aberto
*
* Herda de FormBase
* Tipo: REPORT (layout FLAT - sem PageFrame CRUD)
* BO:   SIGREHPEBO (herda RelatorioBase)
* Migrado de: SIGREHPE.SCX (frmrelatorio)
*
* Sem campos de filtro - relatorio gera dados fixos
*==============================================================================

DEFINE CLASS FormSIGREHPE AS FormBase

    *-- Dimensoes: Width=1000 padrao sistema, Height=300 do original
    Height      = 300
    Width       = 1000
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

    KeyPreview         = .T.

    *-- BO e controle de erro
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Rastreamento de pagina (REPORT eh FLAT - sempre pagina 1)
    this_nPaginaAtual  = 1

    *==========================================================================
    * INIT
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * INICIALIZARFORM - Cria estrutura FLAT do form de relatorio
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.ConfigurarPageFrame()

            THIS.this_oRelatorio = CREATEOBJECT("SIGREHPEBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio de Cheques Pendentes", "InicializarForm")
            ELSE
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoes()
                THIS.LimparCampos()
                THIS.AlternarPagina(1)
                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGEFRAME - Propriedades da janela e fundo do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Caption     = "Resumo de Cheques Pendentes"
        THIS.Picture     = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.Icon        = gc_4c_CaminhoIcones + "icon.ico"
        THIS.AutoCenter  = .T.
        THIS.BorderStyle = 2
        THIS.WindowType  = 1
        THIS.ControlBox  = .F.
        THIS.MaxButton   = .F.
        THIS.MinButton   = .F.
        THIS.TitleBar    = 0
        THIS.Themes      = .F.
        THIS.ShowTips    = .T.
        THIS.BackColor   = RGB(255, 255, 255)
    ENDPROC

    *==========================================================================
    * CONFIGURARCABECALHO - Container escuro com labels titulo/sombra
    *==========================================================================
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
                .Top       = 15
                .Left      = 12
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = "Resumo de Cheques Pendentes"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "Resumo de Cheques Pendentes"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * CONFIGURARBOTOES - CommandGroup 4 botoes (padrao frmrelatorio framework.vcx)
    * Left=727: posicao flush-direita em form 1000px (1000-273=727)
    * Top=3: original btnReport.Top=3
    * Geometria: Width=273, Height=80, ButtonCount=4, BackStyle=0
    * Lefts internos: 5, 71, 137, 203 (incrementos de 66)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 3
            .Left          = 727
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
                .Picture         = loc_cIcones + "relatorio_video_26.jpg"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .WordWrap        = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .Picture         = loc_cIcones + "relatorio_impressora_26.jpg"
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
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "\<Arquivos Email"
                .Picture         = loc_cIcones + "geral_envelope_32.jpg"
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
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Sair"
                .Picture         = loc_cIcones + "relatorio_sair_60.jpg"
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
                .Cancel          = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * ATUALIZARESTADOCONTROLES - Override: form de relatorio nao usa CRUD
    *==========================================================================
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINALISTA - REPORT FLAT sem filtros: sem conteudo adicional
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINADADADOS - REPORT FLAT: sem Page2 de dados
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *==========================================================================
    * ALTERNARPAGINA - REPORT FLAT: rastreia pagina logica (sempre 1)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(PCOUNT() < 1 OR VARTYPE(par_nPagina) != "N", 1, par_nPagina)
        IF loc_nPagina < 1
            loc_nPagina = 1
        ENDIF
        THIS.this_nPaginaAtual = loc_nPagina
    ENDPROC

    *==========================================================================
    * FORMPARARELATORIO - Sem campos de filtro: nada a transferir para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaRelatorio()
        RETURN
    ENDPROC

    *==========================================================================
    * LIMPARCAMPOS - Sem campos de filtro: nada a limpar
    *==========================================================================
    PROCEDURE LimparCampos()
        RETURN
    ENDPROC

    *==========================================================================
    * BTNVISUALIZARCLICK - Botao 1: Visualizar relatorio em preview na tela
    * Equivalente ao PROCEDURE visualizacao do legado
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Visualizar()
            IF !loc_lSucesso
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNIMPRIMIRCLICK - Botao 2: Imprimir relatorio na impressora
    * Equivalente ao PROCEDURE impressao do legado
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Imprimir()
            IF !loc_lSucesso
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNEXCELCLICK - Botao 3: Exportar dados para Excel
    *==========================================================================
    PROCEDURE BtnExcelClick()
        LOCAL loc_lSucesso, loc_cArqXls
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            IF THIS.this_oRelatorio.PrepararDados()
                IF USED("CsRelatorio")
                    loc_cArqXls = SYS(2023) + "\SigReHpe_" + ;
                                  STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    SELECT CsRelatorio
                    COPY TO (loc_cArqXls) TYPE XL5
                    THIS.this_oRelatorio.LimparCursores()
                    MsgInfo("Arquivo Excel gerado em: " + loc_cArqXls, "Excel")
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Nenhum dado encontrado para exportar.", "Excel")
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNCANCELARCLICK - Botao 4: Fechar o form (ESC)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BTNINCLUIRCLICK - Relatorio: equivalente a Visualizar
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Visualizar()
            IF !loc_lSucesso
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Gerar Relat" + CHR(243) + "rio")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNALTERARCLICK - Relatorio: limpar campos / redefinir estado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        TRY
            THIS.LimparCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNEXCLUIRCLICK - Relatorio: encerrar form (sem operacao CRUD)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * FORMKEYPRESS - Enter dispara Visualizar; ESC eh tratado pelo Buttons(4).Cancel
    *==========================================================================
    PROCEDURE KeyPress(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13
            THIS.BtnVisualizarClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNSALVARCLICK - Relatorio: imprimir (sem operacao CRUD de salvar)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *==========================================================================
    * BTNBUSCARCLICK - Relatorio: visualizar preview
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *==========================================================================
    * BTNENCERRARCLICK - Fecha o form de relatorio
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * FORMPARABO - REPORT FLAT: delega para FormParaRelatorio (sem filtros)
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *==========================================================================
    * BOPARAFORM - REPORT FLAT: sem campos de filtro para atualizar na tela
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    *==========================================================================
    * HABILITARCAMPOS - REPORT FLAT: sem campos editaveis
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *==========================================================================
    * CARREGARLISTA - REPORT FLAT: sem lista de registros
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN
    ENDPROC

    *==========================================================================
    * AJUSTARBOTOESPORMODO - REPORT FLAT: sem modos CRUD
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *==========================================================================
    * DESTROY - Libera BO e chama base
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
