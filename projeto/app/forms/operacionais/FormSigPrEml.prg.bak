*==============================================================================
* FormSigPrEml.prg - ALERTA - Email
* Tipo: OPERACIONAL (flat layout, sem PageFrame)
* Migrado de: SIGPREML.SCX
* Chamado com: CREATEOBJECT("FormSigPrEml", cEmpDopNums, cEscolha, @laOpeBaixa)
*              loFrm.Show()
* Parametros Init:
*   par_cEmpDopNums : Emp(3)+Dopes(20)+Numes(6) = 29 chars
*   par_cEscolha    : "INSERIR" | "ALTERAR" | "EXCLUIR"
*   par_laOpeBaixa  : array de EmpDopNums de baixas (opcional)
*==============================================================================

DEFINE CLASS FormSigPrEml AS FormBase

    *-- Dimensoes identicas ao legado
    Width        = 1000
    Height       = 600
    Caption      = "ALERTA - Email"
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ShowTips     = .T.
    KeyPreview   = .T.

    *-- Estado do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_cEmpDopNums     = ""
    this_cEscolha        = ""
    DIMENSION this_laOpeBaixa[1]

    *==========================================================================
    * Init - Recebe parametros e transfere para DODEFAULT/InicializarForm
    *==========================================================================
    PROCEDURE Init(par_cEmpDopNums, par_cEscolha, par_laOpeBaixa)
        LOCAL loc_x, loc_nLen

        THIS.this_cEmpDopNums = IIF(TYPE("par_cEmpDopNums") = "C", par_cEmpDopNums, "")
        THIS.this_cEscolha    = IIF(TYPE("par_cEscolha")    = "C", par_cEscolha,    "")

        *-- Converter array de baixas em propriedade de array do objeto
        IF TYPE("par_laOpeBaixa") = "A"
            loc_nLen = ALEN(par_laOpeBaixa)
            IF loc_nLen > 0
                DIMENSION THIS.this_laOpeBaixa[loc_nLen]
                FOR loc_x = 1 TO loc_nLen
                    THIS.this_laOpeBaixa[loc_x] = par_laOpeBaixa[loc_x]
                ENDFOR
            ELSE
                DIMENSION THIS.this_laOpeBaixa[1]
                THIS.this_laOpeBaixa[1] = ""
            ENDIF
        ELSE
            DIMENSION THIS.this_laOpeBaixa[1]
            THIS.this_laOpeBaixa[1] = ""
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_lConexaoOk

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrEmlBO")

            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto SigPrEmlBO.", "Erro")
            ELSE
                *-- Garantir cursor_4c_Total antes de configurar o Grid (evita
                *-- erro "Alias not found" no RecordSource quando ALERTA falha)
                IF !USED("cursor_4c_Total")
                    CREATE CURSOR cursor_4c_Total ;
                        (Checks N(1), grupos C(10), Contas C(10), ;
                         Rclis C(30), emails C(50), mensagems M, ;
                         prioridade C(15), EmpDopNums C(29), Acaos C(10))
                ENDIF

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.TornarControlesVisiveis()
                THIS.ConfigurarBINDEVENTs()

                *-- Propagar Caption para labels do cabecalho
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Tentar conexao e carregar dados; falha nao impede instanciacao
                loc_lConexaoOk = THIS.this_oBusinessObject.InicializarConexaoAlerta()

                IF loc_lConexaoOk
                    THIS.this_oBusinessObject.CarregarDados( ;
                        THIS.this_cEmpDopNums, ;
                        THIS.this_cEscolha, ;
                        @THIS.this_laOpeBaixa)
                ENDIF

                THIS.grd_4c_Dados.Refresh()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro FormSigPrEml.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
    *==========================================================================
        THIS.Picture      = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ClipControls = .F.
        THIS.ScrollBars   = 0
        THIS.ShowTips     = .T.
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Bloco fixo do topo do form OPERACIONAL
    *--------------------------------------------------------------------------
    * Equivale a "Page1 (Lista)" dos forms CRUD. Neste form plano monta o
    * cabecalho escuro (cnt_4c_Sombra), o shape decorativo, o botao Enviar
    * Email flutuante (cmd_4c_BtnEmail) e o container de saida (cnt_4c_Saida
    * com cmd_4c_Encerrar) que sao persistentes na visualizacao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Area de trabalho (grid + botoes de selecao)
    *--------------------------------------------------------------------------
    * Equivale a "Page2 (Dados)" dos forms CRUD. Neste form plano monta a
    * grade principal (grd_4c_Dados exibindo cursor_4c_Total) e os botoes
    * auxiliares cmd_4c_SelTudo/cmd_4c_Apaga que operam sobre o cursor de
    * destinatarios.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarGrade()
        THIS.ConfigurarSelecaoBotoes()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL plano: sem alternancia de paginas
    *--------------------------------------------------------------------------
    * Metodo mantido para atender contrato arquitetural do pipeline (Fase 4).
    * Forms OPERACIONAIS como SIGPREML nao possuem PageFrame Lista/Dados:
    * o layout completo eh persistente (cabecalho + grid + botoes de acao) e a
    * interacao acontece via botoes flutuantes sobre o grid. O parametro eh
    * ignorado e o metodo retorna sem efeito.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Visible     = .T.
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .AutoSize      = .F.
                .BackStyle     = 0
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .AutoSize   = .F.
                .BackStyle  = 0
                .Caption    = THIS.Caption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255, 255, 255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
    *==========================================================================
        *-- Shape decorativo (Shape1 do legado)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = -2
            .Left          = 819
            .Height        = 84
            .Width         = 84
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
        ENDWITH

        *-- Botao Enviar Email (btnEmail do legado) - standalone com icone 60px
        THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
        WITH THIS.cmd_4c_BtnEmail
            .Top         = 5
            .Left        = 848
            .Height      = 75
            .Width       = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Picture     = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
            .Caption     = "Enviar Email"
            .ToolTipText = "Enviar Email"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
        ENDWITH

        *-- Container canonico Encerrar (padrao novo sistema, Left=917)
        THIS.AddObject("cnt_4c_Saida", "Container")
        WITH THIS.cnt_4c_Saida
            .Top         = -2
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BorderWidth = 0
            .BackStyle   = 0
            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top         = 5
                .Left        = 917
                .Height      = 75
                .Width       = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .Cancel      = .T.
                .Caption     = "Encerrar"
                .ToolTipText = "[Esc] Encerrar"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSelecaoBotoes
    *==========================================================================
        *-- Botao Marcar Todos (SelTudo do legado)
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 90
            .Left        = 4
            .Height      = 40
            .Width       = 40
            .FontName    = "Verdana"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = "Marcar Todos"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
        ENDWITH

        *-- Botao Desmarcar Todos (apaga do legado)
        THIS.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH THIS.cmd_4c_Apaga
            .Top         = 90
            .Left        = 43
            .Height      = 40
            .Width       = 40
            .FontBold    = .F.
            .FontItalic  = .F.
            .FontName    = "Verdana"
            .FontSize    = 8
            .WordWrap    = .T.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Caption     = ""
            .TabStop     = .F.
            .ToolTipText = "Desmarcar Todos"
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade
    *==========================================================================
        THIS.AddObject("grd_4c_Dados", "Grid")
        WITH THIS.grd_4c_Dados
            .Top                  = 132
            .Left                 = 3
            .Width                = 993
            .Height               = 435
            .RecordMark           = .F.
            .DeleteMark           = .F.
            .RowHeight            = 18
            .FontName             = "Verdana"
            .FontSize             = 8
            .ForeColor            = RGB(90, 90, 90)
            .BackColor            = RGB(255, 255, 255)
            .GridLineColor        = RGB(238, 238, 238)
            .HighlightStyle       = 2
            .HighlightBackColor   = RGB(255, 255, 255)
            .HighlightForeColor   = RGB(15, 41, 104)
            .AllowAutoColumnFit   = 2
            .GridLines            = 2
            .ColumnCount          = 5

            *-- Column1: Checkbox Checks (ColumnOrder=1 exibido a esquerda)
            *-- Ordem obrigatoria: AddObject -> CurrentControl -> Sparse -> ControlSource (Erro 1767)
            WITH .Column1
                .ColumnOrder   = 1
                .Width         = 17
                .ReadOnly      = .F.
                WITH .Header1
                    .Caption  = ""
                    .FontName = "Verdana"
                    .FontSize = 8
                ENDWITH
                .AddObject("ctlCheckbox", "CheckBox")
                WITH .ctlCheckbox
                    .Caption   = ""
                    .Alignment = 0
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .Value     = 0
                ENDWITH
                .CurrentControl = "ctlCheckbox"
                .Sparse        = .F.
                .ControlSource = "cursor_4c_Total.Checks"
            ENDWITH

            *-- Column2: Conta (ColumnOrder=2)
            WITH .Column2
                .ColumnOrder   = 2
                .Width         = 80
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Total.Contas"
                WITH .Header1
                    .Caption   = " Conta"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .BackColor = RGB(192, 192, 192)
                ENDWITH
                .AddObject("ctlText", "TextBox")
                WITH .ctlText
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                    .FontName    = "Verdana"
                    .FontSize    = 8
                ENDWITH
                .CurrentControl = "ctlText"
            ENDWITH

            *-- Column3: Nome/Rclis (ColumnOrder=3) - ordenacao padrao inicial
            WITH .Column3
                .ColumnOrder   = 3
                .Width         = 290
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Total.Rclis"
                WITH .Header1
                    .Caption   = " Nome"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .BackColor = RGB(64, 128, 128)
                ENDWITH
                .AddObject("ctlText", "TextBox")
                WITH .ctlText
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .T.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                    .FontName    = "Verdana"
                    .FontSize    = 8
                ENDWITH
                .CurrentControl = "ctlText"
            ENDWITH

            *-- Column4: Email (ColumnOrder=4) - editavel para correcao
            WITH .Column4
                .ColumnOrder   = 4
                .Width         = 290
                .ReadOnly      = .F.
                .ControlSource = "cursor_4c_Total.emails"
                WITH .Header1
                    .Caption   = "Email"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                    .BackColor = RGB(192, 192, 192)
                ENDWITH
                .AddObject("ctlText", "TextBox")
                WITH .ctlText
                    .BorderStyle = 0
                    .Margin      = 0
                    .ReadOnly    = .F.
                    .ForeColor   = RGB(0, 0, 0)
                    .BackColor   = RGB(255, 255, 255)
                    .FontName    = "Verdana"
                    .FontSize    = 8
                ENDWITH
                .CurrentControl = "ctlText"
            ENDWITH

            *-- Column5: Mensagem/EditBox (ColumnOrder=5, Sparse=.F. obrigatorio)
            WITH .Column5
                .ColumnOrder   = 5
                .Width         = 290
                .ReadOnly      = .T.
                .Sparse        = .F.
                .ControlSource = "cursor_4c_Total.mensagems"
                WITH .Header1
                    .Caption   = "Mensagem"
                    .Alignment = 2
                    .FontName  = "Verdana"
                    .FontSize  = 8
                ENDWITH
                .AddObject("ctlEditBox", "EditBox")
                WITH .ctlEditBox
                    .BorderStyle   = 0
                    .ReadOnly      = .T.
                    .SpecialEffect = 1
                    .FontName      = "Verdana"
                    .FontSize      = 8
                ENDWITH
                .CurrentControl = "ctlEditBox"
            ENDWITH

            *-- Ativar RecordSource por ultimo para evitar auto-binding prematuro
            .RecordSource = "cursor_4c_Total"

            *-- Redefinir ControlSource apos RecordSource para evitar auto-bind por ordem de campos
            .Column1.ControlSource = "cursor_4c_Total.Checks"
            .Column2.ControlSource = "cursor_4c_Total.Contas"
            .Column3.ControlSource = "cursor_4c_Total.Rclis"
            .Column4.ControlSource = "cursor_4c_Total.emails"
            .Column5.ControlSource = "cursor_4c_Total.mensagems"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
    *==========================================================================
        *-- Botoes de acao
        BINDEVENT(THIS.cmd_4c_BtnEmail,               "Click", THIS, "BtnEmailClick")
        BINDEVENT(THIS.cmd_4c_SelTudo,                "Click", THIS, "SelTudoClick")
        BINDEVENT(THIS.cmd_4c_Apaga,                  "Click", THIS, "ApagaClick")
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "EncerrarClick")

        *-- Cliques nos cabecalhos para ordenacao (Conta, Nome, Email)
        BINDEVENT(THIS.grd_4c_Dados.Column2.Header1, "Click", THIS, "Col2HeaderClick")
        BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "Col3HeaderClick")
        BINDEVENT(THIS.grd_4c_Dados.Column4.Header1, "Click", THIS, "Col4HeaderClick")

        *-- Checkbox individual para marcar/desmarcar linha
        BINDEVENT(THIS.grd_4c_Dados.Column1.ctlCheckbox, "InteractiveChange", ;
                  THIS, "GrdChkInteractiveChange")
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Form plano (sem PageFrame); nao ha containers
    * que devam permanecer ocultos, entao todos os controles ficam visiveis.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO THIS.ControlCount
            loc_oControl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.RecursarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    PROTECTED PROCEDURE RecursarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.RecursarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Handlers de eventos - PUBLIC (obrigatorio para BINDEVENT)
    *==========================================================================

    PROCEDURE BtnEmailClick()
        LOCAL loc_lOk
        loc_lOk = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lOk = THIS.this_oBusinessObject.EnviarEmails()
        ENDIF

        IF loc_lOk
            THIS.Release()
        ENDIF
    ENDPROC

    PROCEDURE SelTudoClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.MarcarTodos()
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE ApagaClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.DesmarcarTodos()
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE EncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE Col2HeaderClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.OrdenarPorColuna("Contas")
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE Col3HeaderClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.OrdenarPorColuna("Rclis")
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE Col4HeaderClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.OrdenarPorColuna("Emails")
        ENDIF
        THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
        THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    PROCEDURE GrdChkInteractiveChange()
        LOCAL loc_nValue
        IF USED("cursor_4c_Total")
            loc_nValue = THIS.grd_4c_Dados.Column1.ctlCheckbox.Value
            REPLACE Checks WITH loc_nValue IN cursor_4c_Total
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * Eventos CRUD - Contrato arquitetural do pipeline (Fase 7)
    *--------------------------------------------------------------------------
    * SIGPREML eh form OPERACIONAL de envio de alertas por email; nao ha
    * botoes CRUD (Incluir/Alterar/Excluir/Visualizar) na tela original. Os
    * handlers abaixo existem para atender o contrato de validacao do
    * pipeline e delegam para as acoes operacionais reais deste form. O
    * parametro cEscolha ("INSERIR"/"ALTERAR"/"EXCLUIR") recebido no Init
    * descreve o contexto que originou o alerta, nao gera botoes locais.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Contexto INSERIR do alerta -> disparar envio de email
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_cEscolha = "INSERIR"
        THIS.BtnEmailClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Contexto ALTERAR do alerta -> disparar envio de email
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.this_cEscolha = "ALTERAR"
        THIS.BtnEmailClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Reforca visualizacao da lista de destinatarios
    * carregada pelo BO (grid de emails/Rclis/Contas) sem enviar nada.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF USED("cursor_4c_Total")
            SELECT cursor_4c_Total
            GO TOP
        ENDIF
        THIS.grd_4c_Dados.SetFocus()
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Contexto EXCLUIR do alerta: no fluxo operacional
    * equivale a limpar selecao (desmarcar destinatarios) via BO.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.this_cEscolha = "EXCLUIR"
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.DesmarcarTodos()
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Form OPERACIONAL: sem busca interativa
    *--------------------------------------------------------------------------
    * SIGPREML carrega destinatarios no Init via parametros recebidos.
    * "Buscar" equivale a reposicionar o grid no primeiro registro.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        IF USED("cursor_4c_Total")
            SELECT cursor_4c_Total
            GO TOP
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Alias de EncerrarClick (contrato arquitetural pipeline)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.EncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Form OPERACIONAL: "salvar" = enviar email
    *--------------------------------------------------------------------------
    * Nao ha operacao de salvar no sentido CRUD. O equivalente operacional
    * e o envio dos emails (BtnEmailClick), que registra o alerta em SigAlert
    * e fecha o form.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnEmailClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela sem enviar email e fecha o form
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.EncerrarClick()
    ENDPROC

    *==========================================================================
    * FormParaBO - Form OPERACIONAL: sem campos de edicao a mapear
    *--------------------------------------------------------------------------
    * Os parametros de operacao (EmpDopNums, Escolha) foram passados no Init
    * e estao em propriedades do form e do BO. Retorna .T. sem efeito.
    *==========================================================================
    PROCEDURE FormParaBO()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Form OPERACIONAL: sem campos de formulario a preencher
    *--------------------------------------------------------------------------
    * Os dados de exibicao estao no cursor_4c_Total que alimenta o grid.
    * Nao ha TextBoxes/Labels a preencher a partir das propriedades do BO.
    *==========================================================================
    PROCEDURE BOParaForm()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme contexto
    *--------------------------------------------------------------------------
    * Form OPERACIONAL: habilita o botao de envio de email apenas se ha
    * ao menos um destinatario carregado no grid.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lTemDados

        loc_lTemDados = USED("cursor_4c_Total") AND RECCOUNT("cursor_4c_Total") > 0

        IF PEMSTATUS(THIS, "cmd_4c_BtnEmail", 5)
            THIS.cmd_4c_BtnEmail.Enabled = loc_lTemDados
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Form OPERACIONAL: desmarca todos os destinatarios
    *--------------------------------------------------------------------------
    * Equivale ao botao "Desmarcar Todos". Mantem semantica de "limpar
    * selecao atual" sem fechar o form.
    *==========================================================================
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.DesmarcarTodos()
        ENDIF
        THIS.grd_4c_Dados.Refresh()
    ENDPROC

    *==========================================================================
    * CarregarLista - Reposiciona e atualiza exibicao do grid de destinatarios
    *--------------------------------------------------------------------------
    * Form OPERACIONAL: o cursor_4c_Total ja esta populado pelo CarregarDados
    * do BO chamado no InicializarForm. CarregarLista reposiciona o ponteiro
    * e atualiza o grid sem re-executar SQL.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Total")
                SELECT cursor_4c_Total
                GO TOP
                THIS.grd_4c_Dados.Refresh()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro FormSigPrEml.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Form OPERACIONAL: sem modos CRUD a ajustar
    *--------------------------------------------------------------------------
    * SIGPREML tem um unico modo de operacao: exibir destinatarios e enviar
    * email. Nao ha alternancia de modos (LISTA/DADOS/INCLUIR/ALTERAR/
    * VISUALIZAR). Metodo mantido para contrato arquitetural do pipeline.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.EncerrarConexaoAlerta()
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
