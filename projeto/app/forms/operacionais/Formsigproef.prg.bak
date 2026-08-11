*====================================================================
* Formsigproef.prg
* Formulario Operacional - Selecao de Transacao TEF
* Legado: sigproef.SCX (form, 580x334)
* Herda de: FormBase
* Tabela principal: SigFiTef / SigOpFp
*====================================================================

DEFINE CLASS Formsigproef AS FormBase

    *-- ===================================================================
    *-- PROPRIEDADES VISUAIS (pixel-perfect do legado)
    *-- ===================================================================
    Width        = 580
    Height       = 334
    AutoCenter   = .T.
    WindowType   = 1
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 1
    KeyPreview   = .T.
    FontName     = "Tahoma"
    FontSize     = 8

    *-- ===================================================================
    *-- BUSINESS OBJECT
    *-- ===================================================================
    this_oBusinessObject = .NULL.

    *-- ===================================================================
    *-- ESTADO OPERACIONAL
    *-- ===================================================================
    this_cNsuRetorno = ""
    this_cOperacao   = ""
    this_cNoCaixa    = ""
    this_cNoFab      = ""

    *====================================================================
    * Init
    *====================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *====================================================================
    * InicializarForm - Cria BO, carrega configuracao TEF e monta estrutura
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lBOOk, loc_lConfOk
        loc_lSucesso = .F.
        loc_lBOOk    = .F.
        loc_lConfOk  = .F.

        TRY
            THIS.Caption = "Sele" + CHR(231) + CHR(227) + "o da Transa" + CHR(231) + CHR(227) + "o"

            THIS.this_oBusinessObject = CREATEOBJECT("sigproefBO")
            loc_lBOOk = (VARTYPE(THIS.this_oBusinessObject) = "O")

            IF loc_lBOOk
                *-- UI construida antes da carga de DB (sem dependencia de conexao)
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Transa.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.this_cNsuRetorno = ""

                loc_lConfOk = THIS.this_oBusinessObject.CarregarConfiguracao()

                IF loc_lConfOk
                    *-- Propagar configuracoes da impressora fiscal para o form
                    THIS.this_cNoCaixa  = THIS.this_oBusinessObject.this_cCnCaixas
                    THIS.this_cOperacao = PADR(THIS.this_cNoCaixa + THIS.this_cNoFab + "ADM", 20)
                ENDIF

                THIS.TornarControlesVisiveis(THIS.cnt_4c_Transa)

                BINDEVENT(THIS.cnt_4c_Transa.cmd_4c_Gerencial,                       "Click",    THIS, "BtnGerencialClick")
                BINDEVENT(THIS.cnt_4c_Transa.cmd_4c_Ultimo,                          "Click",    THIS, "BtnUltimoClick")
                BINDEVENT(THIS.cnt_4c_Transa.cmd_4c_Reimprime,                       "Click",    THIS, "BtnReimprimirClick")
                BINDEVENT(THIS.cnt_4c_Transa.cmd_4c_Cancela,                         "Click",    THIS, "BtnCancelaClick")
                BINDEVENT(THIS.cnt_4c_Transa.cmd_4c_Sair,                            "Click",    THIS, "BtnSairClick")
                BINDEVENT(THIS,                                                       "KeyPress", THIS, "FormKeyPress")
                BINDEVENT(THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial,        "KeyPress", THIS, "DtInicialKeyPress")
                BINDEVENT(THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtFinal,          "KeyPress", THIS, "DtFinalKeyPress")

                THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.Value = DATE()
                THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtFinal.Value   = DATE()

                IF loc_lConfOk
                    THIS.SqlTrans()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        IF !loc_lBOOk
            MsgErro("Erro ao criar Business Object sigproefBO", "Erro")
        ENDIF
        IF loc_lBOOk AND !loc_lConfOk
            MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o TEF: " + ;
                    THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfigurarPageFrame - Constroi o "frame" visual do form operacional.
    * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
    * estrutura fixa (container principal + cabecalho) para manter
    * compatibilidade com o pipeline multi-fase.
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Transa", "Container")
        WITH THIS.cnt_4c_Transa
            .Top           = 3
            .Left          = 1
            .Height        = THIS.Height - 3
            .Width         = THIS.Width  - 2
            .SpecialEffect = 0
            .BorderWidth   = 0
            .BackStyle     = 1
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *====================================================================
    * ConfigurarCabecalho - Label titulo e linha separadora
    *====================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Transa

        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .Caption    = "Transa" + CHR(231) + CHR(245) + "es Efetuadas"
            .FontBold   = .T.
            .FontItalic = .T.
            .FontSize   = 12
            .FontName   = "Tahoma"
            .ForeColor  = RGB(0, 0, 160)
            .Left       = 191
            .Top        = 9
            .AutoSize   = .T.
            .BackStyle  = 0
            .Visible    = .T.
        ENDWITH

        loc_oCnt.AddObject("lin_4c_Separador", "Line")
        WITH loc_oCnt.lin_4c_Separador
            .BorderWidth = 4
            .Height      = 0
            .Left        = 7
            .Top         = 29
            .Width       = 571
            .BorderColor = RGB(0, 0, 160)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *====================================================================
    * ObterNsuRetorno - Retorna NSU da transacao corrente
    * Equivalente ao Unload do legado: Return(IIF(USED("TRANSACAO"),Transacao.cnnsus,""))
    *====================================================================
    PROCEDURE ObterNsuRetorno()
        IF USED("Transacao")
            SELECT Transacao
            IF !EOF()
                RETURN ALLTRIM(NVL(cnnsus, ""))
            ENDIF
        ENDIF
        RETURN ""
    ENDPROC

    *====================================================================
    * Destroy - Libera recursos e cursores
    *====================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            THIS.this_cNsuRetorno = THIS.ObterNsuRetorno()

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("Transacao")
                USE IN Transacao
            ENDIF
            IF USED("Selecao")
                USE IN Selecao
            ENDIF
            IF USED("Selecao2")
                USE IN Selecao2
            ENDIF
            IF USED("LocalPar")
                USE IN LocalPar
            ENDIF
            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF
            IF USED("crSigCdPac")
                USE IN crSigCdPac
            ENDIF
            IF USED("crSigFiMpF")
                USE IN crSigFiMpF
            ENDIF
            IF USED("csSigOpFp")
                USE IN csSigOpFp
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *====================================================================
    * ConfigurarPaginaLista - Grid de transacoes, filtro de periodo e botoes
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oCnt, loc_oPer

        TRY
            loc_oCnt = THIS.cnt_4c_Transa

            *-- Grid de transacoes TEF (pixel-perfect: Top=41, Left=8, 569x230, 7 colunas)
            loc_oCnt.AddObject("grd_4c_Dados", "Grid")
            WITH loc_oCnt.grd_4c_Dados
                .Top           = 41
                .Left          = 8
                .Width         = 569
                .Height        = 230
                .ColumnCount   = 7
                .ReadOnly      = .T.
                .DeleteMark    = .F.
                .RecordMark    = .F.
                .ScrollBars    = 2
                .FontName      = "Tahoma"
                .FontSize      = 8
                .GridLineColor = RGB(192, 192, 192)
                .HeaderHeight  = 16
                .RowHeight     = 15
                .Visible       = .T.
            ENDWITH

            *-- Cabecalhos iniciais das colunas (definidos antes de RecordSource para
            *-- evitar cabecalhos genericos "Column1/Column2" enquanto SqlTrans carrega)
            WITH loc_oCnt.grd_4c_Dados
                .ColumnCount                  = 7
                .Column1.Width                = 70
                .Column1.Header1.Caption      = "Rede"
                .Column1.Header1.Alignment    = 2
                .Column1.Header1.FontSize     = 8
                .Column2.Width                = 78
                .Column2.Header1.Caption      = "N.Autorizacao"
                .Column2.Header1.Alignment    = 2
                .Column2.Header1.FontSize     = 8
                .Column3.Width                = 75
                .Column3.Header1.Caption      = "Valor"
                .Column3.Header1.Alignment    = 2
                .Column3.Header1.FontSize     = 8
                .Column4.Width                = 65
                .Column4.Alignment            = 2
                .Column4.Header1.Caption      = "Data"
                .Column4.Header1.Alignment    = 2
                .Column4.Header1.FontSize     = 8
                .Column5.Width                = 55
                .Column5.Header1.Caption      = "Header1"
                .Column5.Header1.Alignment    = 2
                .Column5.Header1.FontSize     = 8
                .Column6.Width                = 60
                .Column6.Header1.Caption      = "Header1"
                .Column6.Header1.Alignment    = 2
                .Column6.Header1.FontSize     = 8
                .Column7.Width                = 120
                .Column7.Header1.Caption      = "Header1"
                .Column7.Header1.Alignment    = 2
                .Column7.Header1.FontSize     = 8
            ENDWITH

            *-- Container do filtro de periodo (pixel-perfect: Top=278, Left=7, 217x52)
            loc_oCnt.AddObject("cnt_4c_Periodo", "Container")
            WITH loc_oCnt.cnt_4c_Periodo
                .Top           = 278
                .Left          = 7
                .Width         = 217
                .Height        = 52
                .SpecialEffect = 0
                .BorderWidth   = 0
                .BackStyle     = 1
                .BackColor     = RGB(240, 240, 240)
                .Visible       = .T.
            ENDWITH

            loc_oPer = loc_oCnt.cnt_4c_Periodo

            loc_oPer.AddObject("lbl_4c_Periodo", "Label")
            WITH loc_oPer.lbl_4c_Periodo
                .Caption       = "Per" + CHR(237) + "odo"
                .FontBold      = .T.
                .FontItalic    = .T.
                .FontSize      = 10
                .FontUnderline = .T.
                .AutoSize      = .F.
                .Width         = 59
                .Height        = 18
                .Left          = 16
                .Top           = 3
                .ForeColor     = RGB(0, 0, 160)
                .BackStyle     = 0
                .Visible       = .T.
            ENDWITH

            loc_oPer.AddObject("txt_4c_DtInicial", "TextBox")
            WITH loc_oPer.txt_4c_DtInicial
                .Value     = {}
                .Alignment = 3
                .Height    = 23
                .Left      = 14
                .Top       = 22
                .Width     = 81
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            loc_oPer.AddObject("lbl_4c_A", "Label")
            WITH loc_oPer.lbl_4c_A
                .Caption   = "a"
                .Left      = 103
                .Top       = 25
                .AutoSize  = .T.
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPer.AddObject("txt_4c_DtFinal", "TextBox")
            WITH loc_oPer.txt_4c_DtFinal
                .Value     = {}
                .Alignment = 3
                .Height    = 23
                .Left      = 119
                .Top       = 22
                .Width     = 81
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .T.
            ENDWITH

            *-- Shape decorativo de fundo dos botoes (pixel-perfect: Top=277, Left=245, 331x53)
            loc_oCnt.AddObject("shp_4c_Botoes", "Shape")
            WITH loc_oCnt.shp_4c_Botoes
                .Top           = 277
                .Left          = 245
                .Height        = 53
                .Width         = 331
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- Botao Gerencial F2 (pixel-perfect: Top=281, Left=251, 64x46)
            loc_oCnt.AddObject("cmd_4c_Gerencial", "CommandButton")
            WITH loc_oCnt.cmd_4c_Gerencial
                .Top      = 281
                .Left     = 251
                .Height   = 46
                .Width    = 64
                .Caption  = "<F2> Gerencial"
                .FontBold = .T.
                .FontName = "Small Fonts"
                .FontSize = 7
                .ForeColor = RGB(0, 0, 255)
                .WordWrap  = .T.
                .Picture   = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
                .Themes    = .T.
                .Visible   = .T.
            ENDWITH

            *-- Botao Ultimo F3 (pixel-perfect: Top=281, Left=315, 64x46)
            loc_oCnt.AddObject("cmd_4c_Ultimo", "CommandButton")
            WITH loc_oCnt.cmd_4c_Ultimo
                .Top      = 281
                .Left     = 315
                .Height   = 46
                .Width    = 64
                .Caption  = "<F3> " + CHR(218) + "ltimo"
                .FontBold = .T.
                .FontName = "Small Fonts"
                .FontSize = 7
                .ForeColor = RGB(0, 0, 255)
                .WordWrap  = .T.
                .Picture   = gc_4c_CaminhoIcones + "geral_documento_60.jpg"
                .Themes    = .T.
                .Visible   = .T.
            ENDWITH

            *-- Botao Reimprimir F4 (pixel-perfect: Top=281, Left=379, 64x46)
            loc_oCnt.AddObject("cmd_4c_Reimprime", "CommandButton")
            WITH loc_oCnt.cmd_4c_Reimprime
                .Top      = 281
                .Left     = 379
                .Height   = 46
                .Width    = 64
                .Caption  = "<F4> Reimprimir"
                .FontBold = .T.
                .FontName = "Small Fonts"
                .FontSize = 7
                .ForeColor = RGB(0, 0, 255)
                .WordWrap  = .T.
                .Picture   = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
                .Themes    = .T.
                .Visible   = .T.
            ENDWITH

            *-- Botao Cancelar F5 (pixel-perfect: Top=281, Left=443, 64x46)
            loc_oCnt.AddObject("cmd_4c_Cancela", "CommandButton")
            WITH loc_oCnt.cmd_4c_Cancela
                .Top      = 281
                .Left     = 443
                .Height   = 46
                .Width    = 64
                .Caption  = "<F5> Cancelar"
                .FontBold = .T.
                .FontName = "Small Fonts"
                .FontSize = 7
                .ForeColor = RGB(0, 0, 255)
                .WordWrap  = .T.
                .Picture   = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .Themes    = .T.
                .Visible   = .T.
            ENDWITH

            *-- Botao Sair ESC (pixel-perfect: Top=281, Left=507, 64x46)
            loc_oCnt.AddObject("cmd_4c_Sair", "CommandButton")
            WITH loc_oCnt.cmd_4c_Sair
                .Top      = 281
                .Left     = 507
                .Height   = 75
                .Width    = 75
                .Caption  = "<ESC> Sair"
                .Cancel   = .T.
                .FontBold = .T.
                .FontName = "Small Fonts"
                .FontSize = 7
                .ForeColor = RGB(0, 0, 255)
                .WordWrap  = .T.
                .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Themes    = .T.
                .Visible   = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *====================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *====================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
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

    *====================================================================
    * ConfigurarPaginaDados - Form OPERACIONAL nao tem Page2 de dados
    * Conteudo visual concentrado em ConfigurarPaginaLista e ConfigurarCabecalho
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *====================================================================
    * AlternarPagina - Compatibilidade com pipeline multi-fase
    * Form OPERACIONAL nao usa alternancia de paginas
    *====================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *====================================================================
    * BtnIncluirClick - Recarrega grid de transacoes TEF no periodo
    * Semantica CRUD "Incluir" mapeada para o unico gesto de entrada de
    * dados deste form OPERACIONAL: disparar nova consulta SqlTrans que
    * traz para o grid as transacoes recem-efetuadas na loja.
    *====================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_dDtIni, loc_dDtFin

        loc_dDtIni = THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.Value
        loc_dDtFin = THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtFinal.Value

        IF EMPTY(loc_dDtIni) OR EMPTY(loc_dDtFin)
            MsgAviso("Informe o per" + CHR(237) + "odo (data inicial e final) " + ;
                     "antes de carregar as transa" + CHR(231) + CHR(245) + "es.", "Aviso")
            THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.SetFocus()
            RETURN
        ENDIF

        IF loc_dDtFin < loc_dDtIni
            THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.Value = loc_dDtFin
        ENDIF

        THIS.SqlTrans()
    ENDPROC

    *====================================================================
    * BtnAlterarClick - Alterna status de fiscal/nao-fiscal da transacao
    * Semantica CRUD "Alterar" mapeada para o unico gesto de mutacao
    * disponivel neste form OPERACIONAL: reprocessar a transacao corrente
    * chamando o handler de reimpressao (que reemite o comprovante fiscal
    * com base no NSU original e atualiza o status na base).
    *====================================================================
    PROCEDURE BtnAlterarClick()
        IF !USED("Transacao")
            MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + ;
                     "es efetuadas para alterar.", "Aviso")
            RETURN
        ENDIF

        SELECT Transacao
        IF EOF()
            MsgAviso("Selecione uma transa" + CHR(231) + CHR(227) + ;
                     "o na grade antes de alterar.", "Aviso")
            RETURN
        ENDIF

        IF ALLTRIM(Transacao.cStatus) = "CNC"
            MsgAviso("Transa" + CHR(231) + CHR(227) + "o cancelada n" + CHR(227) + ;
                     "o pode ser alterada.", "Aviso")
            RETURN
        ENDIF

        THIS.BtnReimprimirClick()
    ENDPROC

    *====================================================================
    * BtnVisualizarClick - Exibe detalhes da transacao TEF selecionada
    * Semantica CRUD "Visualizar" mapeada para BtnUltimoClick, que abre
    * o form SigPrOer/SigTfSup em modo de consulta somente-leitura para
    * a transacao corrente no grid.
    *====================================================================
    PROCEDURE BtnVisualizarClick()
        IF !USED("Transacao")
            MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + ;
                     "es efetuadas para visualizar.", "Aviso")
            RETURN
        ENDIF

        SELECT Transacao
        IF EOF()
            MsgAviso("Selecione uma transa" + CHR(231) + CHR(227) + ;
                     "o na grade antes de visualizar.", "Aviso")
            RETURN
        ENDIF

        THIS.BtnUltimoClick()
    ENDPROC

    *====================================================================
    * BtnExcluirClick - Cancela transacao TEF selecionada
    * Semantica CRUD "Excluir" mapeada para BtnCancelaClick. Cancelamento
    * de TEF nao remove fisicamente o registro (integridade fiscal); marca
    * cStatus='CNC', grava usuario cancelante em UsuCancs e reverte parcelas
    * em SigMvPar via lCancelas=.T. (padrao SigOpCtf/SigTfCan).
    *====================================================================
    PROCEDURE BtnExcluirClick()
        IF !USED("Transacao")
            MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + ;
                     "es efetuadas para cancelar.", "Aviso")
            RETURN
        ENDIF

        SELECT Transacao
        IF EOF()
            MsgAviso("Selecione uma transa" + CHR(231) + CHR(227) + ;
                     "o na grade antes de cancelar.", "Aviso")
            RETURN
        ENDIF

        THIS.BtnCancelaClick()
    ENDPROC

    *====================================================================
    * SqlTrans - Carrega transacoes TEF no periodo e configura o grid
    * Equivalente ao sqltrans do form original
    *====================================================================
    PROCEDURE SqlTrans()
        LOCAL loc_lResultado, loc_dDtI, loc_dDtF, loc_oGrid

        loc_lResultado = .F.

        TRY
            loc_dDtI = THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.Value
            loc_dDtF = THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtFinal.Value

            IF EMPTY(loc_dDtI) OR EMPTY(loc_dDtF)
                loc_lResultado = .F.
            ENDIF

            THIS.LockScreen = .T.
            WAIT WINDOW "Aguarde..." NOWAIT

            loc_lResultado = THIS.this_oBusinessObject.BuscarTransacoes(loc_dDtI, loc_dDtF)

            IF loc_lResultado AND USED("Transacao")
                loc_oGrid = THIS.cnt_4c_Transa.grd_4c_Dados

                loc_oGrid.RecordSource = "Transacao"
                loc_oGrid.ColumnCount  = 7
                loc_oGrid.ReadOnly     = .T.

                loc_oGrid.Column1.ControlSource    = "Transacao.cCupomNvs"
                loc_oGrid.Column1.Width            = 70
                loc_oGrid.Column1.FontSize         = 8
                loc_oGrid.Column1.Movable          = .F.
                loc_oGrid.Column1.Resizable        = .F.
                loc_oGrid.Column1.ReadOnly         = .T.
                loc_oGrid.Column1.Header1.Caption  = "Rede"
                loc_oGrid.Column1.Header1.Alignment = 2
                loc_oGrid.Column1.Header1.FontSize  = 8

                loc_oGrid.Column2.ControlSource    = "Transacao.cnnsus"
                loc_oGrid.Column2.Width            = 78
                loc_oGrid.Column2.FontSize         = 8
                loc_oGrid.Column2.Movable          = .F.
                loc_oGrid.Column2.Resizable        = .F.
                loc_oGrid.Column2.ReadOnly         = .T.
                loc_oGrid.Column2.Header1.Caption  = "N.Autorizacao"
                loc_oGrid.Column2.Header1.Alignment = 2
                loc_oGrid.Column2.Header1.FontSize  = 8

                loc_oGrid.Column3.ControlSource    = "Transacao.cnValors"
                loc_oGrid.Column3.Width            = 75
                loc_oGrid.Column3.FontSize         = 8
                loc_oGrid.Column3.Movable          = .F.
                loc_oGrid.Column3.Resizable        = .F.
                loc_oGrid.Column3.ReadOnly         = .T.
                loc_oGrid.Column3.Header1.Caption  = "Valor"
                loc_oGrid.Column3.Header1.Alignment = 2
                loc_oGrid.Column3.Header1.FontSize  = 8

                loc_oGrid.Column4.ControlSource    = "Transacao.cnDtTrans"
                loc_oGrid.Column4.Width            = 65
                loc_oGrid.Column4.FontSize         = 8
                loc_oGrid.Column4.Movable          = .F.
                loc_oGrid.Column4.Resizable        = .F.
                loc_oGrid.Column4.ReadOnly         = .T.
                loc_oGrid.Column4.Alignment        = 2
                loc_oGrid.Column4.Header1.Caption  = "Data"
                loc_oGrid.Column4.Header1.Alignment = 2
                loc_oGrid.Column4.Header1.FontSize  = 8

                loc_oGrid.Column5.ControlSource    = "Transacao.CnHrTrans"
                loc_oGrid.Column5.Width            = 55
                loc_oGrid.Column5.FontSize         = 8
                loc_oGrid.Column5.Movable          = .F.
                loc_oGrid.Column5.Resizable        = .F.
                loc_oGrid.Column5.ReadOnly         = .T.
                loc_oGrid.Column5.Header1.Caption  = "Header1"
                loc_oGrid.Column5.Header1.Alignment = 2
                loc_oGrid.Column5.Header1.FontSize  = 8

                loc_oGrid.Column6.ControlSource    = "Transacao.cnCupoms"
                loc_oGrid.Column6.Width            = 60
                loc_oGrid.Column6.FontSize         = 8
                loc_oGrid.Column6.Movable          = .F.
                loc_oGrid.Column6.Resizable        = .F.
                loc_oGrid.Column6.ReadOnly         = .T.
                loc_oGrid.Column6.Header1.Caption  = "Header1"
                loc_oGrid.Column6.Header1.Alignment = 2
                loc_oGrid.Column6.Header1.FontSize  = 8

                loc_oGrid.Column7.ControlSource    = "Transacao.cDopes"
                loc_oGrid.Column7.Width            = 120
                loc_oGrid.Column7.FontSize         = 8
                loc_oGrid.Column7.Movable          = .F.
                loc_oGrid.Column7.Resizable        = .F.
                loc_oGrid.Column7.ReadOnly         = .T.
                loc_oGrid.Column7.Header1.Caption  = "Header1"
                loc_oGrid.Column7.Header1.Alignment = 2
                loc_oGrid.Column7.Header1.FontSize  = 8

                loc_oGrid.SetAll("DynamicForeColor", ;
                    "IIF(Transacao.lCancel, RGB(255,0,0), RGB(0,0,0))", "Column")
                loc_oGrid.Refresh()
                loc_oGrid.SetFocus()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SqlTrans")
        ENDTRY

        WAIT CLEAR
        THIS.LockScreen = .F.

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * FormKeyPress - Handler de teclado do form (F2=Gerencial, F3=Ultimo,
    *                F4=Reimprime, F5=Cancela)
    *====================================================================
    PROCEDURE FormKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        DO CASE
            CASE par_nKeyCode = -1
                NODEFAULT
                THIS.BtnGerencialClick()
            CASE par_nKeyCode = -2
                NODEFAULT
                THIS.BtnUltimoClick()
            CASE par_nKeyCode = -3
                NODEFAULT
                THIS.BtnReimprimirClick()
            CASE par_nKeyCode = -4 AND THIS.cnt_4c_Transa.cmd_4c_Cancela.Visible
                NODEFAULT
                THIS.BtnCancelaClick()
        ENDCASE
    ENDPROC

    *====================================================================
    * DtInicialKeyPress - Ao sair de DtInicial, move foco para DtFinal
    *====================================================================
    PROCEDURE DtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtFinal.SetFocus()
        ENDIF
    ENDPROC

    *====================================================================
    * DtFinalKeyPress - Ao confirmar DtFinal, recarrega transacoes
    *====================================================================
    PROCEDURE DtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_dIni, loc_dFim

        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_dIni = THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.Value
            loc_dFim = THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtFinal.Value

            IF !EMPTY(loc_dFim) AND !EMPTY(loc_dIni)
                IF loc_dFim < loc_dIni
                    THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.Value = loc_dFim
                ENDIF
            ENDIF

            THIS.SqlTrans()
        ENDIF
    ENDPROC

    *====================================================================
    * BtnGerencialClick - Operacao gerencial TEF (F2)
    *====================================================================
    PROCEDURE BtnGerencialClick()
        LOCAL loc_nResposta

        IF !USED("Transacao")
            MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
            RETURN
        ENDIF

        SELECT Transacao
        IF EOF()
            MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
            RETURN
        ENDIF

        TRY
            loc_nResposta = SigPrTef( ;
                THIS.this_oBusinessObject.this_cNumIps, ;
                110, ;
                Transacao.cnValors, ;
                "1", ;
                THIS.this_oBusinessObject.this_cCnCaixas, ;
                .NULL., ;
                "SW000001", ;
                0)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Gerencial")
        ENDTRY

        THIS.Release()
    ENDPROC

    *====================================================================
    * BtnUltimoClick - Exibe ultima transacao TEF (F3)
    *====================================================================
    PROCEDURE BtnUltimoClick()
        LOCAL loc_cNSU, loc_cData

        IF !USED("Transacao")
            MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
            RETURN
        ENDIF

        SELECT Transacao
        IF EOF()
            MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
            RETURN
        ENDIF

        TRY
            THIS.this_oBusinessObject.CarregarPagamentoFP(ALLTRIM(Transacao.FPags))

            loc_cNSU  = ALLTRIM(Transacao.cnnsus)
            loc_cData = DTOC(Transacao.cnDtTrans)
            loc_cData = SUBSTR(loc_cData, 1, 2) + SUBSTR(loc_cData, 4, 2) + SUBSTR(loc_cData, 7, 4)
            SKIP

            IF ALLTRIM(THIS.this_oBusinessObject.this_cVerSitefs) = "4.1"
                DO FORM SigPrOer WITH ;
                    THIS.this_oBusinessObject.this_cNumIps, ;
                    THIS.this_oBusinessObject.this_cCnCaixas, ;
                    loc_cNSU, "", "", "", "", ;
                    NVL(csSigOpFp.CodEstabs, "")
            ELSE
                DO FORM SigTfSup WITH ;
                    THIS.this_oBusinessObject.this_cNumIps, ;
                    THIS.this_oBusinessObject.this_cCnCaixas, ;
                    loc_cNSU, "", "", "", "", ;
                    NVL(csSigOpFp.CodEstabs, "")
            ENDIF

            IF USED("Transacao")
                SELECT Transacao
                GO BOTTOM
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro " + CHR(218) + "ltimo")
        ENDTRY

        THIS.Release()
    ENDPROC

    *====================================================================
    * BtnReimprimirClick - Reimprime comprovante TEF (F4)
    *====================================================================
    PROCEDURE BtnReimprimirClick()
        LOCAL loc_cNSU, loc_cData

        IF !USED("Transacao")
            MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
            RETURN
        ENDIF

        SELECT Transacao
        IF EOF()
            MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
            RETURN
        ENDIF

        IF ALLTRIM(Transacao.cStatus) = "CNC"
            MsgAviso("Transa" + CHR(231) + CHR(227) + "o cancelada", "Aviso")
            RETURN
        ENDIF

        TRY
            loc_cNSU  = ALLTRIM(Transacao.cnnsus)
            loc_cData = DTOC(Transacao.cnDtTrans)
            loc_cData = SUBSTR(loc_cData, 1, 2) + SUBSTR(loc_cData, 4, 2) + SUBSTR(loc_cData, 7, 4)
            SKIP

            THIS.this_oBusinessObject.CarregarPagamentoFP(ALLTRIM(Transacao.FPags))

            IF ALLTRIM(THIS.this_oBusinessObject.this_cVerSitefs) = "4.1"
                DO FORM SigPrOer WITH ;
                    THIS.this_oBusinessObject.this_cNumIps, ;
                    THIS.this_oBusinessObject.this_cCnCaixas, ;
                    loc_cNSU, loc_cData, ;
                    Transacao.cnValors, Transacao.cnDtTrans, Transacao.CnHrTrans, ;
                    NVL(csSigOpFp.CodEstabs, "")
            ELSE
                DO FORM SigTfSup WITH ;
                    THIS.this_oBusinessObject.this_cNumIps, ;
                    THIS.this_oBusinessObject.this_cCnCaixas, ;
                    loc_cNSU, loc_cData, ;
                    Transacao.cnValors, Transacao.cnDtTrans, Transacao.CnHrTrans, ;
                    NVL(csSigOpFp.CodEstabs, "")
            ENDIF

            IF USED("Transacao")
                SELECT Transacao
                SKIP -1
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Reimprimir")
        ENDTRY

        THIS.Release()
    ENDPROC

    *====================================================================
    * BtnCancelaClick - Cancela transacao TEF selecionada (F5)
    *====================================================================
    PROCEDURE BtnCancelaClick()
        LOCAL loc_lCancel, loc_cData

        IF !USED("Transacao")
            MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
            RETURN
        ENDIF

        SELECT Transacao
        IF EOF()
            MsgAviso("N" + CHR(227) + "o existem transa" + CHR(231) + CHR(245) + "es efetuadas", "Aviso")
            RETURN
        ENDIF

        IF ALLTRIM(Transacao.cStatus) = "CNC"
            MsgAviso("Transa" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cancelada", "Aviso")
            RETURN
        ENDIF

        IF Transacao.CupFis = 3
            IF !MsgConfirma("Aten" + CHR(231) + CHR(227) + "o! Esta " + CHR(233) + " uma opera" + ;
                            CHR(231) + CHR(227) + "o de Cupom N" + CHR(227) + "o Fiscal." + CHR(13) + ;
                            "Deseja realmente continuar com o cancelamento?")
                RETURN
            ENDIF
        ENDIF

        TRY
            THIS.this_oBusinessObject.CarregarPagamentoFP(ALLTRIM(Transacao.FPags))
            THIS.this_oBusinessObject.CarregarTransacaoCorrente("Transacao")

            loc_cData = DTOC(Transacao.cnDtTrans)
            loc_cData = SUBSTR(loc_cData, 1, 2) + SUBSTR(loc_cData, 4, 2) + SUBSTR(loc_cData, 7, 4)

            loc_lCancel = .F.

            IF ALLTRIM(THIS.this_oBusinessObject.this_cVerSitefs) = "4.1"
                DO FORM SigOpCtf WITH ;
                    THIS.this_oBusinessObject.this_cNumIps, ;
                    THIS.this_oBusinessObject.this_cCnCaixas, ;
                    Transacao.cnValors, ;
                    NVL(csSigOpFp.Opers, ""), ;
                    loc_cData, ;
                    ALLTRIM(Transacao.cnnsus), ;
                    NVL(csSigOpFp.lCartao, .F.), ;
                    .F., ;
                    NVL(csSigOpFp.CodEstabs, "") ;
                    TO loc_lCancel
            ELSE
                DO FORM SigTfCan WITH ;
                    THIS.this_oBusinessObject.this_cNumIps, ;
                    THIS.this_oBusinessObject.this_cCnCaixas, ;
                    Transacao.cnValors, ;
                    NVL(csSigOpFp.Opers, ""), ;
                    loc_cData, ;
                    ALLTRIM(Transacao.cnnsus), ;
                    NVL(csSigOpFp.lCartao, .F.), ;
                    .F., ;
                    NVL(csSigOpFp.CodEstabs, "") ;
                    TO loc_lCancel
            ENDIF

            IF loc_lCancel
                THIS.this_oBusinessObject.CancelarTransacao( ;
                    THIS.this_oBusinessObject.this_cCnNsus, ;
                    THIS.this_oBusinessObject.this_cEmpDopNums, ;
                    THIS.this_oBusinessObject.this_cCnIdents)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Cancelar")
        ENDTRY

        THIS.Release()
    ENDPROC

    *====================================================================
    * BtnSairClick - Fecha o form (ESC)
    *====================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *====================================================================
    * MontarRetorno - Gera arquivos de resposta SiTef para integracao TEF
    * Equivalente ao montaretorno do form original
    *====================================================================
    PROCEDURE MontarRetorno(par_sTipTran, par_sDataHora, par_sCupom, par_sCartao, ;
                             par_sNsu, par_sAutoriza, par_sFinaliza, par_nValPago)
        LOCAL loc_sValPago, loc_nLinha, loc_sPos, loc_sCupomTemp
        LOCAL loc_aCartao[11]

        loc_sValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        loc_aCartao[1]  = "Outro, nao definido"
        loc_aCartao[2]  = "Visa"
        loc_aCartao[3]  = "Mastercard"
        loc_aCartao[4]  = "Diners"
        loc_aCartao[5]  = "American Express"
        loc_aCartao[6]  = "Sollo"
        loc_aCartao[7]  = "Sidecard (Redecard)"
        loc_aCartao[8]  = "Private Label (Redecard)"
        loc_aCartao[9]  = "Redeshop"
        loc_aCartao[10] = ""
        loc_aCartao[11] = "Fininvest"

        IF USED("crSiTef")
            USE IN crSiTef
        ENDIF
        CREATE CURSOR crSiTef (tef C(100))

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + TRANSFORM(THIS.this_cOperacao))
        INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_sValPago)
        INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(par_sCartao) + 1])
        INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_sTipTran)
        INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_sNsu)
        INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_sAutoriza)
        INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + ;
            SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 9, 6))
        INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("018-000 = 1")
        INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + ;
            SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 1, 4))
        INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_sDataHora, 9, 6))
        INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_sFinaliza)
        INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_sDataHora, 9, 6))
        INSERT INTO crSiTef (Tef) VALUES ("028-000 = 27")

        loc_sPos       = 1
        loc_nLinha     = 1
        loc_sCupomTemp = par_sCupom

        DO WHILE loc_sPos <> 0
            loc_sPos = AT(CHR(10), loc_sCupomTemp)
            INSERT INTO crSiTef (Tef) VALUES ( ;
                "029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
                IIF(loc_sPos <> 0, SUBSTR(loc_sCupomTemp, 1, loc_sPos - 1), loc_sCupomTemp))
            loc_sCupomTemp = SUBSTR(loc_sCupomTemp, loc_sPos + 1)
            loc_nLinha     = loc_nLinha + 1
        ENDDO

        INSERT INTO crSiTef (Tef) VALUES ("030-000 = Transacao OK")
        INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        SELECT crSiTef
        COPY TO C:\client\Resp\IntPos.001 SDF
        ZAP

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + TRANSFORM(THIS.this_cOperacao))
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        COPY TO C:\client\Resp\IntPos.STS SDF

        USE IN crSiTef
    ENDPROC

    *====================================================================
    * CarregarLista - Compatibilidade CRUD: recarrega grid de transacoes
    *====================================================================
    PROCEDURE CarregarLista()
        RETURN THIS.SqlTrans()
    ENDPROC

    *====================================================================
    * BtnBuscarClick - Recarrega transacoes com o periodo informado
    *====================================================================
    PROCEDURE BtnBuscarClick()
        THIS.SqlTrans()
    ENDPROC

    *====================================================================
    * BtnEncerrarClick - Fecha o form
    *====================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *====================================================================
    * BtnSalvarClick - Nao aplicavel neste form OPERACIONAL (sem edicao)
    * Mantido para compatibilidade com o pipeline multi-fase
    *====================================================================
    PROCEDURE BtnSalvarClick()
        RETURN .T.
    ENDPROC

    *====================================================================
    * BtnCancelarClick - Nao aplicavel neste form OPERACIONAL
    * Distinguir de BtnCancelaClick (que cancela transacao TEF)
    * Mantido para compatibilidade com o pipeline multi-fase
    *====================================================================
    PROCEDURE BtnCancelarClick()
        RETURN .T.
    ENDPROC

    *====================================================================
    * FormParaBO - Transfere dados do form para o BO
    * Campos editaveis: periodo de consulta (datas)
    *====================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_dDataInicial = ;
                    THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.Value
                THIS.this_oBusinessObject.this_dDataFinal   = ;
                    THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtFinal.Value
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BOParaForm - Transfere dados do BO para o form
    * As datas sao gerenciadas diretamente nos TextBoxes; a configuracao
    * TEF foi carregada em InicializarForm via CarregarConfiguracao.
    *====================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF !EMPTY(THIS.this_oBusinessObject.this_dDataInicial)
                    THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.Value = ;
                        THIS.this_oBusinessObject.this_dDataInicial
                ENDIF
                IF !EMPTY(THIS.this_oBusinessObject.this_dDataFinal)
                    THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtFinal.Value   = ;
                        THIS.this_oBusinessObject.this_dDataFinal
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme estado do grid
    * No form OPERACIONAL o unico campo editavel e o filtro de periodo.
    * O botao Cancela fica visivel apenas quando ha transacao selecionada.
    *====================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lTemTransacao, loc_lTemGrid

        TRY
            loc_lTemGrid = VARTYPE(THIS.cnt_4c_Transa) = "O" AND ;
                           VARTYPE(THIS.cnt_4c_Transa.grd_4c_Dados) = "O"

            loc_lTemTransacao = USED("Transacao") AND !EOF("Transacao")

            THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.Enabled = .T.
            THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtFinal.Enabled   = .T.

            THIS.cnt_4c_Transa.cmd_4c_Cancela.Visible = loc_lTemTransacao

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    *====================================================================
    * LimparCampos - Reseta filtro de periodo para a data de hoje
    *====================================================================
    PROCEDURE LimparCampos()
        TRY
            THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtInicial.Value = DATE()
            THIS.cnt_4c_Transa.cnt_4c_Periodo.txt_4c_DtFinal.Value   = DATE()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *====================================================================
    * AjustarBotoesPorModo - Form OPERACIONAL nao tem modos CRUD
    * Mantido para compatibilidade com o pipeline multi-fase
    *====================================================================
    PROCEDURE AjustarBotoesPorModo()
        RETURN .T.
    ENDPROC

ENDDEFINE
