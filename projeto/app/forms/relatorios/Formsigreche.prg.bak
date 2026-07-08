*==============================================================================
* FORMSIGRECHE.PRG
* Relatorio de Cheques (SIGRECHE) - Fase 3/8: Form Estrutura Base
*
* Herda de FormBase
* Tipo: REPORT (layout FLAT - sem PageFrame CRUD)
* BO:   sigrecheBO (herda RelatorioBase)
* Migrado de: sigreche.SCX (frmrelatorio)
*==============================================================================

DEFINE CLASS Formsigreche AS FormBase

    *-- Dimensoes EXATAS do original (Height=400, Width=1000)
    Height      = 400
    Width       = 1000
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

    *-- BO e controle de erro
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Rastreamento de pagina (REPORT eh FLAT mas mantemos o contrato CRUD para compatibilidade)
    this_nPaginaAtual = 1

    *==========================================================================
    * INIT
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * INICIALIZARFORM - Cria estrutura do form de relatorio FLAT (sem PageFrame CRUD)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.ConfigurarPageFrame()

            THIS.this_oRelatorio = CREATEOBJECT("sigrecheBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio de Cheques", "InicializarForm")
            ELSE
                THIS.this_oRelatorio.InicializarCursores()

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarBotoes()
                THIS.ConfigurarPaginaLista()

                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    THIS.this_oRelatorio.CarregarOpcoes()
                    THIS.AtualizarTitulosOpcao()
                ENDIF

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
    * CONFIGURARPAGEFRAME - Configura propriedades de janela e moldura do form
    *
    * REPORT (frmrelatorio) usa layout FLAT: nao ha PageFrame de 2 abas como
    * em forms CRUD. Este metodo aplica as propriedades do "frame" da janela
    * (Caption, Picture de fundo, Icon, comportamento de janela) e estabelece
    * a area util para os containers de cabecalho, filtros e botoes que sao
    * adicionados diretamente ao Form em ConfigurarCabecalho/ConfigurarBotoes.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Caption     = "Relat" + CHR(243) + "rio de Cheques"
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
            .Top       = 0
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 80
            .BackStyle = 1
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible   = .T.

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
                .Caption   = THIS.Caption
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
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * CONFIGURARBOTOES - CommandGroup com 4 botoes (EXATO do framework frmrelatorio)
    * Geometria canonical: ButtonCount=4, Width=273, Height=80, BackStyle=0
    * Posicao: Left=726 (do SCX original), Top=6
    * Lefts internos: Btn1=5, Btn2=71, Btn3=137, Btn4=203 (incrementos de 66)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_cIcones
        loc_cIcones = gc_4c_CaminhoIcones

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top         = 6
            .Left        = 726
            .Width       = 273
            .Height      = 80
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes      = .F.
            .Visible     = .T.

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
    * CONFIGURARPAGINALISTA - Monta a "pagina" principal do relatorio (FLAT)
    *
    * Em forms CRUD esta procedure monta a Page1 (grid de registros + botoes
    * Incluir/Alterar/Excluir/Buscar). Em REPORT (frmrelatorio) o layout eh
    * FLAT - nao existe PageFrame de 2 abas. A "pagina de lista" do relatorio
    * eh a area de filtros + grids de selecao (operacoes/campos a imprimir).
    *
    * Este wrapper centraliza a montagem dessa area: filtros, grid de operacoes
    * e grid de campos a imprimir. Os botoes de acao (Visualizar/Imprimir/
    * Excel/Sair) ja foram criados em ConfigurarBotoes() como CommandGroup
    * cmg_4c_Botoes (padrao frmrelatorio do framework.vcx).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCamposFiltro()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarGridOperacoes()
        THIS.ConfigurarGridImprimir()
    ENDPROC

    *==========================================================================
    * ALTERNARPAGINA - Controle de pagina (REPORT eh FLAT - 1 pagina logica)
    *
    * Em forms CRUD esta procedure faz THIS.pgf_4c_Paginas.ActivePage = N para
    * alternar entre Page1 (Lista) e Page2 (Dados). Em REPORT (frmrelatorio)
    * nao ha PageFrame de 2 abas - o form eh FLAT. Mesmo assim mantemos o
    * contrato do metodo e rastreamos a pagina logica em this_nPaginaAtual
    * para que codigo externo (ou validacao automatica) possa consultar o
    * estado da janela. Em REPORT par_nPagina sempre eh 1.
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
    * FORMPARARELATORIO - Transfere valores dos controles do form para o BO
    * Usa PEMSTATUS para cada controle (safe em todas as fases de migracao)
    *==========================================================================
    PROTECTED PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oRelatorio
            *-- Tipo de relatorio (OptionGroup)
            IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
                .this_nNrTipo = THIS.obj_4c_NrTipo.Value
            ENDIF
            *-- Opcao com/sem nota (OptionGroup)
            IF PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
                .this_nNrOpcao = THIS.obj_4c_NrOpcao.Value
            ENDIF
            *-- Ordem de classificacao (ComboBox)
            IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
                .this_nOrdem = THIS.cbo_4c_Ordem.Value
            ENDIF
            *-- Apenas ultima movimentacao (CheckBox - valor numerico 0/1)
            IF PEMSTATUS(THIS, "chk_4c_Ultima", 5)
                .this_lUltima = (THIS.chk_4c_Ultima.Value = 1)
            ENDIF
            *-- Periodo
            IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
                .this_dDtInicial = THIS.txt_4c_DtInicial.Value
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
                .this_dDtFinal = THIS.txt_4c_DtFinal.Value
            ENDIF
            *-- Empresa
            IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
                .this_cCdEmpresa = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)
                .this_cDsEmpresa = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
            ENDIF
            *-- Carteira (grupo/conta)
            IF PEMSTATUS(THIS, "txt_4c_CdCarGrupo", 5)
                .this_cCdCarGrupo = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsCarGrupo", 5)
                .this_cDsCarGrupo = ALLTRIM(THIS.txt_4c_DsCarGrupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdCarConta", 5)
                .this_cCdCarConta = ALLTRIM(THIS.txt_4c_CdCarConta.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsCarConta", 5)
                .this_cDsCarConta = ALLTRIM(THIS.txt_4c_DsCarConta.Value)
            ENDIF
            *-- Deposito (grupo/conta)
            IF PEMSTATUS(THIS, "txt_4c_CdDepGrupo", 5)
                .this_cCdDepGrupo = ALLTRIM(THIS.txt_4c_CdDepGrupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsDepGrupo", 5)
                .this_cDsDepGrupo = ALLTRIM(THIS.txt_4c_DsDepGrupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdDepConta", 5)
                .this_cCdDepConta = ALLTRIM(THIS.txt_4c_CdDepConta.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsDepConta", 5)
                .this_cDsDepConta = ALLTRIM(THIS.txt_4c_DsDepConta.Value)
            ENDIF
            *-- Emissor (grupo/conta)
            IF PEMSTATUS(THIS, "txt_4c_CdEmiGrupo", 5)
                .this_cCdEmiGrupo = ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsEmiGrupo", 5)
                .this_cDsEmiGrupo = ALLTRIM(THIS.txt_4c_DsEmiGrupo.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdEmiConta", 5)
                .this_cCdEmiConta = ALLTRIM(THIS.txt_4c_CdEmiConta.Value)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsEmiConta", 5)
                .this_cDsEmiConta = ALLTRIM(THIS.txt_4c_DsEmiConta.Value)
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * BTNVISUALIZARCLICK - Botao 1: Visualizar relatorio em tela
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Visualizar()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNIMPRIMIRCLICK - Botao 2: Imprimir relatorio em impressora
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Imprimir()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNEXCELCLICK - Botao 3: Exportar para Excel
    *==========================================================================
    PROCEDURE BtnExcelClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Validar()
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                RETURN
            ENDIF
            IF USED("cursor_4c_Relatorio")
                LOCAL loc_cArqXls
                loc_cArqXls = SYS(2023) + "\SigReChe_" + STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                COPY TO (loc_cArqXls) TYPE XL5
                MsgInfo("Arquivo Excel gerado em: " + loc_cArqXls, "Excel")
                loc_lSucesso = .T.
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
    * BTNINCLUIRCLICK - "Gerar novo relatorio" (frmrelatorio: visualizar)
    * Em forms REPORT, "Incluir" mapeia para gerar/visualizar o relatorio
    * com os filtros atuais. Equivalente funcional ao botao Visualizar.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Visualizar()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Gerar Relat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNALTERARCLICK - "Alterar parametros" (frmrelatorio: reset filtros)
    * Em forms REPORT, "Alterar" mapeia para limpar/redefinir os filtros
    * do relatorio. Equivalente funcional ao reset de campos.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        TRY
            THIS.LimparCampos()
            IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
                THIS.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNEXCLUIRCLICK - "Cancelar/Encerrar" (frmrelatorio: fechar)
    * Em forms REPORT, "Excluir" nao tem sentido CRUD. Pede confirmacao
    * e encerra o formulario de relatorio. Equivalente ao botao Encerrar.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja encerrar o relat" + CHR(243) + "rio?", ;
                       "Encerrar")
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * CONFIGURARCAMPOSFILTRO - Periodo, Empresa, Deposito, Emissor (esq/baixo)
    * Controles adicionados DIRETAMENTE ao form (layout FLAT - sem PageFrame)
    * Opcao/Situacao/Ordem/Ultima/Carteira: ver ConfigurarPaginaDados()
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposFiltro()

        *-- == PERIODO ==
        THIS.AddObject("lbl_4c_Periodo", "Label")
        WITH THIS.lbl_4c_Periodo
            .Top       = 113
            .Left      = 52
            .Width     = 50
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtInicial", "TextBox")
        WITH THIS.txt_4c_DtInicial
            .Top       = 107
            .Left      = 101
            .Width     = 80
            .Height    = 23
            .Value     = DATE()
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_PeriodoA", "Label")
        WITH THIS.lbl_4c_PeriodoA
            .Top       = 112
            .Left      = 186
            .Width     = 10
            .Height    = 18
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtFinal", "TextBox")
        WITH THIS.txt_4c_DtFinal
            .Top       = 107
            .Left      = 200
            .Width     = 80
            .Height    = 23
            .Value     = DATE()
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- == EMPRESA ==
        THIS.AddObject("lbl_4c_Empresa", "Label")
        WITH THIS.lbl_4c_Empresa
            .Top       = 137
            .Left      = 47
            .Width     = 54
            .Height    = 18
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH THIS.txt_4c_CdEmpresa
            .Top      = 132
            .Left     = 101
            .Width    = 31
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH THIS.txt_4c_DsEmpresa
            .Top      = 132
            .Left     = 132
            .Width    = 290
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- == DEPOSITO - GRUPO ==
        THIS.AddObject("lbl_4c_DepGrupo", "Label")
        WITH THIS.lbl_4c_DepGrupo
            .Top       = 275
            .Left      = 451
            .Width     = 84
            .Height    = 18
            .Caption   = "Grupo/Dep" + CHR(243) + "sito :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdDepGrupo", "TextBox")
        WITH THIS.txt_4c_CdDepGrupo
            .Top      = 270
            .Left     = 540
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsDepGrupo", "TextBox")
        WITH THIS.txt_4c_DsDepGrupo
            .Top      = 270
            .Left     = 621
            .Width    = 365
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- == DEPOSITO - CONTA ==
        THIS.AddObject("lbl_4c_DepConta", "Label")
        WITH THIS.lbl_4c_DepConta
            .Top       = 300
            .Left      = 451
            .Width     = 84
            .Height    = 18
            .Caption   = "Conta/Dep" + CHR(243) + "sito :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdDepConta", "TextBox")
        WITH THIS.txt_4c_CdDepConta
            .Top      = 295
            .Left     = 540
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsDepConta", "TextBox")
        WITH THIS.txt_4c_DsDepConta
            .Top      = 295
            .Left     = 621
            .Width    = 365
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- == EMISSOR - GRUPO ==
        THIS.AddObject("lbl_4c_EmiGrupo", "Label")
        WITH THIS.lbl_4c_EmiGrupo
            .Top       = 325
            .Left      = 457
            .Width     = 78
            .Height    = 18
            .Caption   = "Grupo/Emissor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdEmiGrupo", "TextBox")
        WITH THIS.txt_4c_CdEmiGrupo
            .Top      = 320
            .Left     = 540
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEmiGrupo", "TextBox")
        WITH THIS.txt_4c_DsEmiGrupo
            .Top      = 320
            .Left     = 621
            .Width    = 365
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- == EMISSOR - CONTA ==
        THIS.AddObject("lbl_4c_EmiConta", "Label")
        WITH THIS.lbl_4c_EmiConta
            .Top       = 350
            .Left      = 457
            .Width     = 78
            .Height    = 18
            .Caption   = "Conta/Emissor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdEmiConta", "TextBox")
        WITH THIS.txt_4c_CdEmiConta
            .Top      = 345
            .Left     = 540
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEmiConta", "TextBox")
        WITH THIS.txt_4c_DsEmiConta
            .Top      = 345
            .Left     = 621
            .Width    = 365
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Vincular KeyPress handlers periodo/empresa/deposito/emissor
        BINDEVENT(THIS.txt_4c_DtInicial,  "KeyPress", THIS, "TeclaDtInicial")
        BINDEVENT(THIS.txt_4c_DtFinal,    "KeyPress", THIS, "TeclaDtFinal")
        BINDEVENT(THIS.txt_4c_CdEmpresa,  "KeyPress", THIS, "TeclaCdEmpresa")
        BINDEVENT(THIS.txt_4c_DsEmpresa,  "KeyPress", THIS, "TeclaDsEmpresa")
        BINDEVENT(THIS.txt_4c_CdDepGrupo, "KeyPress", THIS, "TeclaCdDepGrupo")
        BINDEVENT(THIS.txt_4c_DsDepGrupo, "KeyPress", THIS, "TeclaDsDepGrupo")
        BINDEVENT(THIS.txt_4c_CdDepConta, "KeyPress", THIS, "TeclaCdDepConta")
        BINDEVENT(THIS.txt_4c_DsDepConta, "KeyPress", THIS, "TeclaDsDepConta")
        BINDEVENT(THIS.txt_4c_CdEmiGrupo, "KeyPress", THIS, "TeclaCdEmiGrupo")
        BINDEVENT(THIS.txt_4c_DsEmiGrupo, "KeyPress", THIS, "TeclaDsEmiGrupo")
        BINDEVENT(THIS.txt_4c_CdEmiConta, "KeyPress", THIS, "TeclaCdEmiConta")
        BINDEVENT(THIS.txt_4c_DsEmiConta, "KeyPress", THIS, "TeclaDsEmiConta")
    ENDPROC

    *==========================================================================
    * CONFIGURARPAGINADADADOS - Controles filtro DIREITA Parte 1 (Fase 5/8)
    * Opcao (com/sem nota), Situacao/Tipo, Ordem, Ultima Mov, Carteira Grupo/Conta
    * Posicoes EXATAS do layout.json (PILAR 1 - pixel-perfect)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- == OPCAO (OptionGroup - com/sem nota fiscal) ==
        THIS.AddObject("lbl_4c_LblOpcao", "Label")
        WITH THIS.lbl_4c_LblOpcao
            .Top       = 121
            .Left      = 495
            .Width     = 44
            .Height    = 18
            .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_NrOpcao", "OptionGroup")
        WITH THIS.obj_4c_NrOpcao
            .Top         = 117
            .Left        = 540
            .Width       = 182
            .Height      = 23
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Value       = 3
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption = "Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left    = 0
                .Top     = 3
                .Width   = 60
                .Height  = 17
                .Visible = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "N" + CHR(227) + "o"
                .Left     = 61
                .Top      = 3
                .Width    = 60
                .Height   = 17
                .FontName = "Comic Sans MS"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            WITH .Buttons(3)
                .Caption  = "Ambos"
                .WordWrap        = .T.
                .Left     = 122
                .Top      = 3
                .Width    = 60
                .Height   = 17
                .FontName = "Comic Sans MS"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
        ENDWITH

        *-- == SITUACAO / TIPO (abertos/geral/dt operacao/dt vencto) ==
        THIS.AddObject("lbl_4c_Situacao", "Label")
        WITH THIS.lbl_4c_Situacao
            .Top       = 148
            .Left      = 485
            .Width     = 52
            .Height    = 18
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("obj_4c_NrTipo", "OptionGroup")
        WITH THIS.obj_4c_NrTipo
            .Top         = 143
            .Left        = 541
            .Width       = 213
            .Height      = 26
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption = "Abertos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left    = 0
                .Top     = 5
                .Width   = 51
                .Height  = 17
                .Visible = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "Geral"
                .Left     = 52
                .Top      = 5
                .Width    = 51
                .Height   = 17
                .FontName = "Comic Sans MS"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            WITH .Buttons(3)
                .Caption  = "Dt Opera" + CHR(231) + CHR(227) + "o"
                .WordWrap        = .T.
                .Left     = 104
                .Top      = 5
                .Width    = 55
                .Height   = 17
                .FontName = "Comic Sans MS"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
            WITH .Buttons(4)
                .Caption  = "Dt Vencto"
                .WordWrap        = .T.
                .Left     = 160
                .Top      = 5
                .Width    = 53
                .Height   = 17
                .FontName = "Comic Sans MS"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
        ENDWITH

        *-- == ORDEM (ComboBox de classificacao do relatorio) ==
        THIS.AddObject("lbl_4c_Ordem", "Label")
        WITH THIS.lbl_4c_Ordem
            .Top       = 172
            .Left      = 494
            .Width     = 44
            .Height    = 18
            .Caption   = "Ordem :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("cbo_4c_Ordem", "ComboBox")
        WITH THIS.cbo_4c_Ordem
            .Top           = 168
            .Left          = 543
            .Width         = 189
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = "Carteira,Dep" + CHR(243) + "sito,Emissor," + ;
                             "Dt Entrada,C.P.F.,Nome"
            .Style         = 2
            .Value         = 1
            .Visible       = .T.
        ENDWITH

        *-- == ULTIMA MOVIMENTACAO (CheckBox) ==
        THIS.AddObject("chk_4c_Ultima", "CheckBox")
        WITH THIS.chk_4c_Ultima
            .Top       = 195
            .Left      = 543
            .Width     = 141
            .Height    = 17
            .Caption   = CHR(218) + "ltima Movimenta" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 1
            .BackStyle = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- == CARTEIRA - GRUPO ==
        THIS.AddObject("lbl_4c_CarGrupo", "Label")
        WITH THIS.lbl_4c_CarGrupo
            .Top       = 225
            .Left      = 454
            .Width     = 84
            .Height    = 18
            .Caption   = "Grupo/Carteira :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdCarGrupo", "TextBox")
        WITH THIS.txt_4c_CdCarGrupo
            .Top      = 220
            .Left     = 540
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsCarGrupo", "TextBox")
        WITH THIS.txt_4c_DsCarGrupo
            .Top      = 220
            .Left     = 621
            .Width    = 365
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- == CARTEIRA - CONTA ==
        THIS.AddObject("lbl_4c_CarConta", "Label")
        WITH THIS.lbl_4c_CarConta
            .Top       = 250
            .Left      = 454
            .Width     = 84
            .Height    = 18
            .Caption   = "Conta/Carteira :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdCarConta", "TextBox")
        WITH THIS.txt_4c_CdCarConta
            .Top      = 245
            .Left     = 540
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsCarConta", "TextBox")
        WITH THIS.txt_4c_DsCarConta
            .Top      = 245
            .Left     = 621
            .Width    = 365
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Vincular KeyPress handlers para carteira (F4=115, ENTER=13, TAB=9)
        BINDEVENT(THIS.txt_4c_CdCarGrupo, "KeyPress", THIS, "TeclaCdCarGrupo")
        BINDEVENT(THIS.txt_4c_DsCarGrupo, "KeyPress", THIS, "TeclaDsCarGrupo")
        BINDEVENT(THIS.txt_4c_CdCarConta, "KeyPress", THIS, "TeclaCdCarConta")
        BINDEVENT(THIS.txt_4c_DsCarConta, "KeyPress", THIS, "TeclaDsCarConta")
    ENDPROC

    *==========================================================================
    * CONFIGURARGRIDOPERACOES - Grid de selecao de operacoes (3 colunas)
    * Cursor: cursor_4c_Operacoes (Marcas L, Operacaos C15, Tipos C2)
    * Original: grdOperacaos Top=158, Left=101, Width=188, Height=147
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridOperacoes()
        LOCAL loc_oGrid, loc_oCol

        THIS.AddObject("lbl_4c_Operacao", "Label")
        WITH THIS.lbl_4c_Operacao
            .Top       = 160
            .Left      = 41
            .Width     = 57
            .Height    = 18
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("grd_4c_Operacoes", "Grid")
        WITH THIS.grd_4c_Operacoes
            .Top          = 158
            .Left         = 101
            .Width        = 188
            .Height       = 147
            .ColumnCount  = 3
            .RecordSource = "cursor_4c_Operacoes"
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .ScrollBars   = 2
            .RowHeight    = 18
            .FontName     = "Tahoma"
            .FontSize     = 8
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .GridLineColor = RGB(238, 238, 238)
            .HighlightStyle = 2
            .Visible      = .T.

            *-- Coluna 1: CheckBox para marcar operacao (LOGICAL)
            WITH .Column1
                .Width   = 22
                .HeaderHeight       = 0
                .Resizable = .F.
                .AddObject("Check1", "CheckBox")
                WITH .Check1
                    .Caption  = ""
                    .Value    = 0
                    .Visible  = .T.
                ENDWITH
                .CurrentControl  = "Check1"
                .ControlSource   = "cursor_4c_Operacoes.Marcas"
                .Header1.Caption = ""
            ENDWITH

            *-- Coluna 2: Descricao da operacao
            WITH .Column2
                .Width          = 96
                .ControlSource  = "cursor_4c_Operacoes.Operacaos"
                .ReadOnly       = .T.
                .Header1.Caption = ""
            ENDWITH

            *-- Coluna 3: Tipo da operacao
            WITH .Column3
                .Width          = 40
                .ControlSource  = "cursor_4c_Operacoes.Tipos"
                .ReadOnly       = .T.
                .Header1.Caption = ""
            ENDWITH
        ENDWITH

        loc_oGrid = THIS.grd_4c_Operacoes
        BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "TeclaCheckOperacoes")
        BINDEVENT(loc_oGrid.Column1.Check1, "Click",    THIS, "CliqueCheckOperacoes")
    ENDPROC

    *==========================================================================
    * CONFIGURARGRIDIMPRIMIR - Grid de selecao de campos de impressao (2 colunas)
    * Cursor: cursor_4c_Imprimir (Marcas L, Campos C20)
    * Original: grdImprimir Top=311, Left=101, Width=188, Height=58
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGridImprimir()
        LOCAL loc_oGrid

        THIS.AddObject("lbl_4c_Campos", "Label")
        WITH THIS.lbl_4c_Campos
            .Top       = 311
            .Left      = 50
            .Width     = 50
            .Height    = 18
            .Caption   = "Campos :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("grd_4c_Imprimir", "Grid")
        WITH THIS.grd_4c_Imprimir
            .Top          = 311
            .Left         = 101
            .Width        = 188
            .Height       = 58
            .ColumnCount  = 2
            .RecordSource = "cursor_4c_Imprimir"
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .ScrollBars   = 2
            .RowHeight    = 18
            .FontName     = "Tahoma"
            .FontSize     = 8
            .ForeColor    = RGB(90, 90, 90)
            .BackColor    = RGB(255, 255, 255)
            .GridLineColor = RGB(238, 238, 238)
            .HighlightStyle = 2
            .Visible      = .T.

            *-- Coluna 1: CheckBox para marcar campo (LOGICAL)
            WITH .Column1
                .Width   = 22
                .HeaderHeight       = 0
                .Resizable = .F.
                .AddObject("Check1", "CheckBox")
                WITH .Check1
                    .Caption  = ""
                    .Value    = 0
                    .Visible  = .T.
                ENDWITH
                .CurrentControl  = "Check1"
                .ControlSource   = "cursor_4c_Imprimir.Marcas"
                .Header1.Caption = ""
            ENDWITH

            *-- Coluna 2: Nome do campo de impressao
            WITH .Column2
                .Width           = 146
                .ControlSource   = "cursor_4c_Imprimir.Campos"
                .ReadOnly        = .T.
                .Header1.Caption = ""
            ENDWITH
        ENDWITH

        loc_oGrid = THIS.grd_4c_Imprimir
        BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "TeclaCheckImprimir")
        BINDEVENT(loc_oGrid.Column1.Check1, "Click",    THIS, "CliqueCheckImprimir")
    ENDPROC

    *==========================================================================
    * LIMPARCAMPOS - Restaura campos de filtro para valores padrao
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
            THIS.txt_4c_DtInicial.Value = DATE()
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
            THIS.txt_4c_DtFinal.Value = DATE()
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
            THIS.txt_4c_CdEmpresa.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)
            THIS.txt_4c_DsEmpresa.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdCarGrupo", 5)
            THIS.txt_4c_CdCarGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsCarGrupo", 5)
            THIS.txt_4c_DsCarGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdCarConta", 5)
            THIS.txt_4c_CdCarConta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsCarConta", 5)
            THIS.txt_4c_DsCarConta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdDepGrupo", 5)
            THIS.txt_4c_CdDepGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsDepGrupo", 5)
            THIS.txt_4c_DsDepGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdDepConta", 5)
            THIS.txt_4c_CdDepConta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsDepConta", 5)
            THIS.txt_4c_DsDepConta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmiGrupo", 5)
            THIS.txt_4c_CdEmiGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsEmiGrupo", 5)
            THIS.txt_4c_DsEmiGrupo.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmiConta", 5)
            THIS.txt_4c_CdEmiConta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsEmiConta", 5)
            THIS.txt_4c_DsEmiConta.Value = ""
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
            THIS.obj_4c_NrOpcao.Value = 3
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
            THIS.obj_4c_NrTipo.Value = 2
        ENDIF
        IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
            THIS.cbo_4c_Ordem.Value = 1
        ENDIF
        IF PEMSTATUS(THIS, "chk_4c_Ultima", 5)
            THIS.chk_4c_Ultima.Value = 1
        ENDIF
    ENDPROC

    *==========================================================================
    * ATUALIZARTITULOSOPCAO - Aplica titulos dinamicos do SigCdPac ao OptionGroup
    * Chamado apos CarregarOpcoes() quando ha conexao disponivel
    *==========================================================================
    PROCEDURE AtualizarTitulosOpcao()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF !PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
            RETURN
        ENDIF
        WITH THIS.obj_4c_NrOpcao
            .Buttons(1).Caption = THIS.this_oRelatorio.this_cTituloOpcao1
            .Buttons(2).Caption = THIS.this_oRelatorio.this_cTituloOpcao2
            .Buttons(3).Caption = THIS.this_oRelatorio.this_cTituloOpcao3
        ENDWITH
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLA - KeyPress para campos de filtro (F4=115, ENTER=13, TAB=9)
    * Campos de data nao tem lookup - handlers vazios conforme padrao
    *==========================================================================
    PROCEDURE TeclaDtInicial(par_nKeyCode, par_nShift)
    ENDPROC

    PROCEDURE TeclaDtFinal(par_nKeyCode, par_nShift)
    ENDPROC

    PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdCarGrupo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCarGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdCarGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsCarGrupo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCarGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsCarGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdCarConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCarConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdCarConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsCarConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCarConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsCarConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdDepGrupo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDepGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdDepGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsDepGrupo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDepGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsDepGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdDepConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDepConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdDepConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsDepConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDepConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsDepConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdEmiGrupo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmiGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmiGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmiGrupo(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmiGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmiGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdEmiConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmiConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmiConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmiConta(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmiConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmiConta()
        ENDIF
    ENDPROC

    *==========================================================================
    * TECLACHECK* - Toggle de checkbox nos grids via teclado (ENTER=13 / SPACE=32)
    *==========================================================================
    PROCEDURE TeclaCheckOperacoes(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 32
            IF USED("cursor_4c_Operacoes") AND !EOF("cursor_4c_Operacoes")
                SELECT cursor_4c_Operacoes
                REPLACE Marcas WITH !Marcas
                THIS.grd_4c_Operacoes.Refresh()
            ENDIF
        ENDIF
        IF par_nKeyCode = 9
            IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
                THIS.obj_4c_NrTipo.Buttons(1).SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaCheckImprimir(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 32
            IF USED("cursor_4c_Imprimir") AND !EOF("cursor_4c_Imprimir")
                SELECT cursor_4c_Imprimir
                REPLACE Marcas WITH !Marcas
                THIS.grd_4c_Imprimir.Refresh()
            ENDIF
        ENDIF
        IF par_nKeyCode = 9
            IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
                THIS.cbo_4c_Ordem.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CLIQUECHECKOPERACOES - Refresh do grid apos toggle por clique de mouse
    * O ControlSource atualiza Marcas automaticamente; apenas sincroniza display
    *==========================================================================
    PROCEDURE CliqueCheckOperacoes()
        IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
            THIS.grd_4c_Operacoes.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CLIQUECHECKIMPRIMIR - Refresh do grid apos toggle por clique de mouse
    *==========================================================================
    PROCEDURE CliqueCheckImprimir()
        IF PEMSTATUS(THIS, "grd_4c_Imprimir", 5)
            THIS.grd_4c_Imprimir.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - EMPRESA
    * Tabela: SigCdEmp, Codigo: cEmps, Descricao: Razas
    *==========================================================================
    PROCEDURE ValidarCdEmpresa()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsEmpresa.Value = ""
            RETURN
        ENDIF
        loc_cSQL    = "SELECT Emps, Razas FROM SigCdEmp WHERE Emps = " + EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0 AND USED("cursor_4c_EmpVal")
            SELECT cursor_4c_EmpVal
            IF !EOF()
                THIS.txt_4c_DsEmpresa.Value = ALLTRIM(Razas)
            ELSE
                THIS.txt_4c_CdEmpresa.Value = ""
                THIS.txt_4c_DsEmpresa.Value = ""
                THIS.AbrirBuscaEmpresa()
            ENDIF
            USE IN cursor_4c_EmpVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsEmpresa()
        LOCAL loc_cNome
        loc_cNome = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
        IF EMPTY(loc_cNome)
            THIS.txt_4c_CdEmpresa.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaEmpresa()
    ENDPROC

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loLookup, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loLookup = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loLookup) = "O"
                loLookup.this_cCursorDestino = "cursor_4c_EmpLst"
                loLookup.ConfigurarBusca("SigCdEmp", "cEmps", "Razas", ;
                    "Empresa", ALLTRIM(THIS.txt_4c_CdEmpresa.Value))
                loLookup.Show()
                IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                    THIS.txt_4c_CdEmpresa.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                    THIS.txt_4c_DsEmpresa.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                ENDIF
                loLookup = .NULL.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - CARTEIRA GRUPO
    * Grupo de carteira (fAcessoContab no legado)
    *==========================================================================
    PROCEDURE ValidarCdCarGrupo()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsCarGrupo.Value = ""
            THIS.txt_4c_CdCarConta.Value = ""
            THIS.txt_4c_DsCarConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL    = "SELECT DISTINCT GruCarts AS Codigo, GruCarts AS Descricao " + ;
                      "FROM SigCqChm WHERE GruCarts = " + EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarGrupoVal")
        IF loc_nResult > 0 AND USED("cursor_4c_CarGrupoVal")
            SELECT cursor_4c_CarGrupoVal
            IF !EOF()
                THIS.txt_4c_DsCarGrupo.Value = ALLTRIM(Codigo)
            ELSE
                THIS.txt_4c_CdCarGrupo.Value = ""
                THIS.txt_4c_DsCarGrupo.Value = ""
                THIS.txt_4c_CdCarConta.Value = ""
                THIS.txt_4c_DsCarConta.Value = ""
            ENDIF
            USE IN cursor_4c_CarGrupoVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsCarGrupo()
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(THIS.txt_4c_DsCarGrupo.Value)
        IF EMPTY(loc_cDescricao)
            THIS.txt_4c_CdCarGrupo.Value = ""
            THIS.txt_4c_CdCarConta.Value = ""
            THIS.txt_4c_DsCarConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaCarGrupo()
    ENDPROC

    PROCEDURE AbrirBuscaCarGrupo()
        LOCAL loLookup, loc_cSQL, loc_nResult
        TRY
            loc_cSQL = "SELECT DISTINCT GruCarts AS codigo, GruCarts AS descricao " + ;
                       "FROM SigCqChm ORDER BY GruCarts"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarGrupoLst")
            IF loc_nResult > 0 AND USED("cursor_4c_CarGrupoLst")
                loLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loLookup) = "O"
                    loLookup.this_cCursorDestino = "cursor_4c_CarGrupoLst"
                    loLookup.ConfigurarBuscaCursor("cursor_4c_CarGrupoLst", ;
                        "codigo", "descricao", "Grupo Carteira", ;
                        ALLTRIM(THIS.txt_4c_CdCarGrupo.Value))
                    loLookup.Show()
                    IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                        THIS.txt_4c_CdCarGrupo.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                        THIS.txt_4c_DsCarGrupo.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                        THIS.txt_4c_CdCarConta.Value = ""
                        THIS.txt_4c_DsCarConta.Value = ""
                    ENDIF
                    loLookup = .NULL.
                ENDIF
                USE IN cursor_4c_CarGrupoLst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaCarGrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - CARTEIRA CONTA
    * Conta dentro do grupo de carteira selecionado
    *==========================================================================
    PROCEDURE ValidarCdCarConta()
        LOCAL loc_cGrupo, loc_cCodigo, loc_cSQL, loc_nResult
        loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdCarConta.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsCarConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT DISTINCT ConCarts AS Codigo, Iclis AS Descricao " + ;
                   "FROM SigCqChm WHERE ConCarts = " + EscaparSQL(loc_cCodigo)
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + " AND GruCarts = " + EscaparSQL(loc_cGrupo)
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarContaVal")
        IF loc_nResult > 0 AND USED("cursor_4c_CarContaVal")
            SELECT cursor_4c_CarContaVal
            IF !EOF()
                THIS.txt_4c_DsCarConta.Value = ALLTRIM(Codigo)
            ELSE
                MsgAviso("Acesso Negado!!", "Carteira")
                THIS.txt_4c_CdCarConta.Value = ""
                THIS.txt_4c_DsCarConta.Value = ""
            ENDIF
            USE IN cursor_4c_CarContaVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsCarConta()
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(THIS.txt_4c_DsCarConta.Value)
        IF EMPTY(loc_cDescricao)
            THIS.txt_4c_CdCarConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaCarConta()
    ENDPROC

    PROCEDURE AbrirBuscaCarConta()
        LOCAL loLookup, loc_cGrupo, loc_cSQL, loc_nResult
        TRY
            loc_cGrupo = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
            loc_cSQL   = "SELECT DISTINCT ConCarts AS codigo, ConCarts AS descricao " + ;
                         "FROM SigCqChm"
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " WHERE GruCarts = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY ConCarts"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarContaLst")
            IF loc_nResult > 0 AND USED("cursor_4c_CarContaLst")
                loLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loLookup) = "O"
                    loLookup.this_cCursorDestino = "cursor_4c_CarContaLst"
                    loLookup.ConfigurarBuscaCursor("cursor_4c_CarContaLst", ;
                        "codigo", "descricao", "Conta Carteira", ;
                        ALLTRIM(THIS.txt_4c_CdCarConta.Value))
                    loLookup.Show()
                    IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                        THIS.txt_4c_CdCarConta.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                        THIS.txt_4c_DsCarConta.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                    ENDIF
                    loLookup = .NULL.
                ENDIF
                USE IN cursor_4c_CarContaLst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaCarConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - DEPOSITO GRUPO
    *==========================================================================
    PROCEDURE ValidarCdDepGrupo()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdDepGrupo.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsDepGrupo.Value = ""
            THIS.txt_4c_CdDepConta.Value = ""
            THIS.txt_4c_DsDepConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL    = "SELECT DISTINCT Grupos AS Codigo, Grupos AS Descricao " + ;
                      "FROM SigCqChm WHERE Grupos = " + EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepGrupoVal")
        IF loc_nResult > 0 AND USED("cursor_4c_DepGrupoVal")
            SELECT cursor_4c_DepGrupoVal
            IF !EOF()
                THIS.txt_4c_DsDepGrupo.Value = ALLTRIM(Codigo)
            ELSE
                THIS.txt_4c_CdDepGrupo.Value = ""
                THIS.txt_4c_DsDepGrupo.Value = ""
                THIS.txt_4c_CdDepConta.Value = ""
                THIS.txt_4c_DsDepConta.Value = ""
            ENDIF
            USE IN cursor_4c_DepGrupoVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsDepGrupo()
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(THIS.txt_4c_DsDepGrupo.Value)
        IF EMPTY(loc_cDescricao)
            THIS.txt_4c_CdDepGrupo.Value = ""
            THIS.txt_4c_CdDepConta.Value = ""
            THIS.txt_4c_DsDepConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDepGrupo()
    ENDPROC

    PROCEDURE AbrirBuscaDepGrupo()
        LOCAL loLookup, loc_cSQL, loc_nResult
        TRY
            loc_cSQL    = "SELECT DISTINCT Grupos AS codigo, Grupos AS descricao " + ;
                          "FROM SigCqChm ORDER BY Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepGrupoLst")
            IF loc_nResult > 0 AND USED("cursor_4c_DepGrupoLst")
                loLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loLookup) = "O"
                    loLookup.this_cCursorDestino = "cursor_4c_DepGrupoLst"
                    loLookup.ConfigurarBuscaCursor("cursor_4c_DepGrupoLst", ;
                        "codigo", "descricao", "Grupo Dep" + CHR(243) + "sito", ;
                        ALLTRIM(THIS.txt_4c_CdDepGrupo.Value))
                    loLookup.Show()
                    IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                        THIS.txt_4c_CdDepGrupo.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                        THIS.txt_4c_DsDepGrupo.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                        THIS.txt_4c_CdDepConta.Value = ""
                        THIS.txt_4c_DsDepConta.Value = ""
                    ENDIF
                    loLookup = .NULL.
                ENDIF
                USE IN cursor_4c_DepGrupoLst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDepGrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - DEPOSITO CONTA
    * Conta de deposito (link SigCqChm.Contas ? SigCdCli.Iclis)
    *==========================================================================
    PROCEDURE ValidarCdDepConta()
        LOCAL loc_cGrupo, loc_cCodigo, loc_cSQL, loc_nResult
        loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdDepGrupo.Value)
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdDepConta.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsDepConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT a.Contas AS Codigo, e.Rclis AS Descricao " + ;
                   "FROM SigCqChm a JOIN SigCdCli e ON a.Contas = e.Iclis " + ;
                   "WHERE a.Contas = " + EscaparSQL(loc_cCodigo)
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepContaVal")
        IF loc_nResult > 0 AND USED("cursor_4c_DepContaVal")
            SELECT cursor_4c_DepContaVal
            IF !EOF()
                THIS.txt_4c_DsDepConta.Value = ALLTRIM(Descricao)
            ELSE
                MsgAviso("Acesso Negado!!", "Dep" + CHR(243) + "sito")
                THIS.txt_4c_CdDepConta.Value = ""
                THIS.txt_4c_DsDepConta.Value = ""
            ENDIF
            USE IN cursor_4c_DepContaVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsDepConta()
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(THIS.txt_4c_DsDepConta.Value)
        IF EMPTY(loc_cDescricao)
            THIS.txt_4c_CdDepConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDepConta()
    ENDPROC

    PROCEDURE AbrirBuscaDepConta()
        LOCAL loLookup, loc_cGrupo, loc_cSQL, loc_nResult
        TRY
            loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdDepGrupo.Value)
            loc_cSQL    = "SELECT DISTINCT a.Contas AS codigo, e.Rclis AS descricao " + ;
                          "FROM SigCqChm a JOIN SigCdCli e ON a.Contas = e.Iclis"
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " WHERE a.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_cSQL    = loc_cSQL + " ORDER BY e.Rclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepContaLst")
            IF loc_nResult > 0 AND USED("cursor_4c_DepContaLst")
                loLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loLookup) = "O"
                    loLookup.this_cCursorDestino = "cursor_4c_DepContaLst"
                    loLookup.ConfigurarBuscaCursor("cursor_4c_DepContaLst", ;
                        "codigo", "descricao", "Conta Dep" + CHR(243) + "sito", ;
                        ALLTRIM(THIS.txt_4c_CdDepConta.Value))
                    loLookup.Show()
                    IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                        THIS.txt_4c_CdDepConta.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                        THIS.txt_4c_DsDepConta.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                    ENDIF
                    loLookup = .NULL.
                ENDIF
                USE IN cursor_4c_DepContaLst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDepConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - EMISSOR GRUPO
    *==========================================================================
    PROCEDURE ValidarCdEmiGrupo()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsEmiGrupo.Value = ""
            THIS.txt_4c_CdEmiConta.Value = ""
            THIS.txt_4c_DsEmiConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL    = "SELECT DISTINCT Grclis AS Codigo, Grclis AS Descricao " + ;
                      "FROM SigCqChm WHERE Grclis = " + EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiGrupoVal")
        IF loc_nResult > 0 AND USED("cursor_4c_EmiGrupoVal")
            SELECT cursor_4c_EmiGrupoVal
            IF !EOF()
                THIS.txt_4c_DsEmiGrupo.Value = ALLTRIM(Codigo)
            ELSE
                THIS.txt_4c_CdEmiGrupo.Value = ""
                THIS.txt_4c_DsEmiGrupo.Value = ""
                THIS.txt_4c_CdEmiConta.Value = ""
                THIS.txt_4c_DsEmiConta.Value = ""
            ENDIF
            USE IN cursor_4c_EmiGrupoVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsEmiGrupo()
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(THIS.txt_4c_DsEmiGrupo.Value)
        IF EMPTY(loc_cDescricao)
            THIS.txt_4c_CdEmiGrupo.Value = ""
            THIS.txt_4c_CdEmiConta.Value = ""
            THIS.txt_4c_DsEmiConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaEmiGrupo()
    ENDPROC

    PROCEDURE AbrirBuscaEmiGrupo()
        LOCAL loLookup, loc_cSQL, loc_nResult
        TRY
            loc_cSQL    = "SELECT DISTINCT Grclis AS codigo, Grclis AS descricao " + ;
                          "FROM SigCqChm ORDER BY Grclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiGrupoLst")
            IF loc_nResult > 0 AND USED("cursor_4c_EmiGrupoLst")
                loLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loLookup) = "O"
                    loLookup.this_cCursorDestino = "cursor_4c_EmiGrupoLst"
                    loLookup.ConfigurarBuscaCursor("cursor_4c_EmiGrupoLst", ;
                        "codigo", "descricao", "Grupo Emissor", ;
                        ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value))
                    loLookup.Show()
                    IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                        THIS.txt_4c_CdEmiGrupo.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                        THIS.txt_4c_DsEmiGrupo.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                        THIS.txt_4c_CdEmiConta.Value = ""
                        THIS.txt_4c_DsEmiConta.Value = ""
                    ENDIF
                    loLookup = .NULL.
                ENDIF
                USE IN cursor_4c_EmiGrupoLst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaEmiGrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO E LOOKUP - EMISSOR CONTA
    * Conta de emissor (link SigCqChm.Iclis ? SigCdCli.Iclis)
    *==========================================================================
    PROCEDURE ValidarCdEmiConta()
        LOCAL loc_cGrupo, loc_cCodigo, loc_cSQL, loc_nResult
        loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value)
        loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEmiConta.Value)
        IF EMPTY(loc_cCodigo)
            THIS.txt_4c_DsEmiConta.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT DISTINCT a.Iclis AS Codigo, d.Rclis AS Descricao " + ;
                   "FROM SigCqChm a JOIN SigCdCli d ON a.Iclis = d.Iclis " + ;
                   "WHERE a.Iclis = " + EscaparSQL(loc_cCodigo)
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + " AND a.Grclis = " + EscaparSQL(loc_cGrupo)
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiContaVal")
        IF loc_nResult > 0 AND USED("cursor_4c_EmiContaVal")
            SELECT cursor_4c_EmiContaVal
            IF !EOF()
                THIS.txt_4c_DsEmiConta.Value = ALLTRIM(Descricao)
            ELSE
                MsgAviso("Acesso Negado!!", "Emissor")
                THIS.txt_4c_CdEmiConta.Value = ""
                THIS.txt_4c_DsEmiConta.Value = ""
            ENDIF
            USE IN cursor_4c_EmiContaVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsEmiConta()
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(THIS.txt_4c_DsEmiConta.Value)
        IF EMPTY(loc_cDescricao)
            THIS.txt_4c_CdEmiConta.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaEmiConta()
    ENDPROC

    PROCEDURE AbrirBuscaEmiConta()
        LOCAL loLookup, loc_cGrupo, loc_cSQL, loc_nResult
        TRY
            loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value)
            loc_cSQL    = "SELECT DISTINCT a.Iclis AS codigo, d.Rclis AS descricao " + ;
                          "FROM SigCqChm a JOIN SigCdCli d ON a.Iclis = d.Iclis"
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " WHERE a.Grclis = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_cSQL    = loc_cSQL + " ORDER BY d.Rclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiContaLst")
            IF loc_nResult > 0 AND USED("cursor_4c_EmiContaLst")
                loLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loLookup) = "O"
                    loLookup.this_cCursorDestino = "cursor_4c_EmiContaLst"
                    loLookup.ConfigurarBuscaCursor("cursor_4c_EmiContaLst", ;
                        "codigo", "descricao", "Conta Emissor", ;
                        ALLTRIM(THIS.txt_4c_CdEmiConta.Value))
                    loLookup.Show()
                    IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
                        THIS.txt_4c_CdEmiConta.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
                        THIS.txt_4c_DsEmiConta.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
                    ENDIF
                    loLookup = .NULL.
                ENDIF
                USE IN cursor_4c_EmiContaLst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaEmiConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNBUSCARCLICK - "Buscar" no contexto de relatorio: gerar visualizacao
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Visualizar()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Gerar Relat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BTNENCERRARCLICK - Encerrar/fechar o form de relatorio
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BTNSALVARCLICK - "Salvar" no contexto de relatorio: imprimir
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.FormParaRelatorio()
            loc_lSucesso = THIS.this_oRelatorio.Imprimir()
            IF !loc_lSucesso
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FORMPARABO - Alias de FormParaRelatorio (compatibilidade com FormBase)
    *==========================================================================
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *==========================================================================
    * BOPARAFORM - Carrega estado do BO de volta para os controles do form
    * Inverso de FormParaRelatorio: popula controles com valores atuais do BO
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        WITH THIS.this_oRelatorio
            IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
                THIS.obj_4c_NrTipo.Value = .this_nNrTipo
            ENDIF
            IF PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
                THIS.obj_4c_NrOpcao.Value = .this_nNrOpcao
            ENDIF
            IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
                THIS.cbo_4c_Ordem.Value = .this_nOrdem
            ENDIF
            IF PEMSTATUS(THIS, "chk_4c_Ultima", 5)
                THIS.chk_4c_Ultima.Value = IIF(.this_lUltima = .T., 1, 0)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
                THIS.txt_4c_DtInicial.Value = .this_dDtInicial
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
                THIS.txt_4c_DtFinal.Value = .this_dDtFinal
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
                THIS.txt_4c_CdEmpresa.Value = ALLTRIM(.this_cCdEmpresa)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)
                THIS.txt_4c_DsEmpresa.Value = ALLTRIM(.this_cDsEmpresa)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdCarGrupo", 5)
                THIS.txt_4c_CdCarGrupo.Value = ALLTRIM(.this_cCdCarGrupo)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsCarGrupo", 5)
                THIS.txt_4c_DsCarGrupo.Value = ALLTRIM(.this_cDsCarGrupo)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdCarConta", 5)
                THIS.txt_4c_CdCarConta.Value = ALLTRIM(.this_cCdCarConta)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsCarConta", 5)
                THIS.txt_4c_DsCarConta.Value = ALLTRIM(.this_cDsCarConta)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdDepGrupo", 5)
                THIS.txt_4c_CdDepGrupo.Value = ALLTRIM(.this_cCdDepGrupo)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsDepGrupo", 5)
                THIS.txt_4c_DsDepGrupo.Value = ALLTRIM(.this_cDsDepGrupo)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdDepConta", 5)
                THIS.txt_4c_CdDepConta.Value = ALLTRIM(.this_cCdDepConta)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsDepConta", 5)
                THIS.txt_4c_DsDepConta.Value = ALLTRIM(.this_cDsDepConta)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdEmiGrupo", 5)
                THIS.txt_4c_CdEmiGrupo.Value = ALLTRIM(.this_cCdEmiGrupo)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsEmiGrupo", 5)
                THIS.txt_4c_DsEmiGrupo.Value = ALLTRIM(.this_cDsEmiGrupo)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_CdEmiConta", 5)
                THIS.txt_4c_CdEmiConta.Value = ALLTRIM(.this_cCdEmiConta)
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_DsEmiConta", 5)
                THIS.txt_4c_DsEmiConta.Value = ALLTRIM(.this_cDsEmiConta)
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * HABILITARCAMPOS - Habilita/desabilita todos os controles de filtro
    * par_lHabilitar: .T. = editavel, .F. = somente leitura
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(PCOUNT() < 1 OR VARTYPE(par_lHabilitar) != "L", .T., par_lHabilitar)

        IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
            THIS.txt_4c_DtInicial.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
            THIS.txt_4c_DtFinal.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
            THIS.txt_4c_CdEmpresa.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)
            THIS.txt_4c_DsEmpresa.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdCarGrupo", 5)
            THIS.txt_4c_CdCarGrupo.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsCarGrupo", 5)
            THIS.txt_4c_DsCarGrupo.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdCarConta", 5)
            THIS.txt_4c_CdCarConta.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsCarConta", 5)
            THIS.txt_4c_DsCarConta.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdDepGrupo", 5)
            THIS.txt_4c_CdDepGrupo.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsDepGrupo", 5)
            THIS.txt_4c_DsDepGrupo.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdDepConta", 5)
            THIS.txt_4c_CdDepConta.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsDepConta", 5)
            THIS.txt_4c_DsDepConta.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmiGrupo", 5)
            THIS.txt_4c_CdEmiGrupo.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsEmiGrupo", 5)
            THIS.txt_4c_DsEmiGrupo.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CdEmiConta", 5)
            THIS.txt_4c_CdEmiConta.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DsEmiConta", 5)
            THIS.txt_4c_DsEmiConta.ReadOnly = !loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
            THIS.obj_4c_NrOpcao.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
            THIS.obj_4c_NrTipo.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
            THIS.cbo_4c_Ordem.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "chk_4c_Ultima", 5)
            THIS.chk_4c_Ultima.Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * CARREGARLISTA - Recarrega grids de operacoes e campos de impressao
    * Para forms REPORT, recria cursores e atualiza opcoes do BO via banco
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                loc_lSucesso = .F.
            ENDIF
            THIS.this_oRelatorio.InicializarCursores()
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                THIS.this_oRelatorio.CarregarOpcoes()
                THIS.AtualizarTitulosOpcao()
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
                THIS.grd_4c_Operacoes.Refresh()
            ENDIF
            IF PEMSTATUS(THIS, "grd_4c_Imprimir", 5)
                THIS.grd_4c_Imprimir.Refresh()
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AJUSTARBOTOESPORMODO - Ajusta estado dos botoes
    * Para forms REPORT, todos os botoes de acao permanecem habilitados
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        IF !PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            RETURN
        ENDIF
        WITH THIS.cmg_4c_Botoes
            .Buttons(1).Enabled = .T.
            .Buttons(2).Enabled = .T.
            .Buttons(3).Enabled = .T.
            .Buttons(4).Enabled = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * DESTROY - Limpeza de recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
