*==============================================================================
* FormSigPdM11.prg - Pagamento de Servicos (sub-form modal)
* Tipo: OPERACIONAL - aberto pelo form pai para edicao de itens de servico
* Parametros Init: par_oParentForm (form pai com .pcEscolha e cursores compartilhados)
* Compartilha DataSession com o form pai para acesso a:
*   xNensiS, xNensiR, CsContas, TmpGccr, TmpCli, crSigCdOpd, crSigCdSvc
*==============================================================================
DEFINE CLASS FormSigPdM11 AS FormBase

    Width            = 1000
    Height           = 600
    Caption          = ""
    DataSession      = 2
    BorderStyle      = 2
    TitleBar         = 0
    ControlBox       = .F.
    Closable         = .F.
    MaxButton        = .F.
    MinButton        = .F.
    Movable          = .F.
    WindowType       = 1
    ShowWindow       = 1
    AutoCenter       = .T.
    ClipControls     = .F.
    ContinuousScroll = .F.
    Themes           = .F.
    Picture          = ""
    KeyPreview       = .F.

    *-- Estado
    this_oBusinessObject = .NULL.
    this_oPaiForm        = .NULL.
    this_cPcEscolha      = ""
    this_nUltColuna      = 0     && Ultima coluna ativa no grid (para validacao)
    this_cAntValue       = ""    && Valor anterior (controle ESC equivalente ao AntValue do legado)
    this_lChkCoef        = .F.   && Indica se a chamada inicial pediu checagem de coeficiente
    this_cDopp           = ""    && _Dopp recebido do form pai (chave para crSigCdOpd.Dopps)

    *-- Cabecalho escuro (cntSombra do legado)
    ADD OBJECT cnt_4c_Sombra AS Container WITH ;
        Top = 0, Left = 0, Width = 1100, Height = 80, ;
        BorderWidth = 0, BackColor = RGB(100,100,100)

    *-- Container transparente de informacoes da operacao (Opera...o do legado)
    ADD OBJECT cnt_4c_Operacao AS Container WITH ;
        Top = 81, Left = 101, Width = 386, Height = 44, ;
        BackStyle = 0, BorderWidth = 0, Visible = .F.

    *-- OptionGroup: Contas de Movimentacao ou Cadastro
    ADD OBJECT opt_4c_OptMov AS OptionGroup WITH ;
        AutoSize = .F., ButtonCount = 2, ;
        BackStyle = 0, BorderStyle = 0, ;
        Value = 1, Height = 25, Left = 700, Top = 91, Width = 199, ;
        Visible = .F.

    *-- Label "Contas de :"
    ADD OBJECT lbl_4c_ContasLabel AS Label WITH ;
        AutoSize = .T., FontBold = .T., FontName = "Tahoma", FontSize = 8, ;
        BackStyle = 0, Caption = "Contas de :", ;
        Height = 15, Left = 634, Top = 96, Width = 64, ;
        ForeColor = RGB(90,90,90), Visible = .F.

    *-- Botao1: indicador vermelho / abre SigPdM12 ao clicar (Retrabalhos)
    ADD OBJECT txt_4c_Botao1 AS TextBox WITH ;
        Height = 22, Left = 490, Top = 92, Width = 27, ;
        ReadOnly = .T., BackColor = RGB(255,0,0), ;
        SpecialEffect = 1, MousePointer = 15, ;
        ToolTipText = "Clique para visualizar o Retrabalho", ;
        BorderStyle = 0, Value = "", Visible = .F.

    *-- Botao2: indicador azul (O.S. de Retorno - apenas visual)
    ADD OBJECT txt_4c_Botao2 AS TextBox WITH ;
        Height = 22, Left = 517, Top = 92, Width = 27, ;
        ReadOnly = .T., BackColor = RGB(0,0,255), ;
        SpecialEffect = 1, ;
        ToolTipText = "O.S. de Retorno", ;
        BorderStyle = 0, Value = "", Visible = .F.

    *-- Shape decorativo atras da area do botao OK
    ADD OBJECT shp_4c_Shape1 AS Shape WITH ;
        Top = 10, Left = 900, Height = 110, Width = 90, ;
        BackStyle = 0, BorderStyle = 0, BorderColor = RGB(136,189,188), Visible = .F.

    *-- Grid principal de itens (configurado na Fase 4)
    ADD OBJECT grd_4c_Grade AS Grid WITH ;
        Top = 126, Left = 50, Width = 899, Height = 413, ;
        ColumnCount = 9, ;
        FontBold = .T., HeaderHeight = 15, ;
        GridLineColor = RGB(238,238,238), ;
        RecordMark = .F., DeleteMark = .F., ;
        Visible = .F.

    *-- TextBox descricao do servico (display da categoria selecionada)
    ADD OBJECT txt_4c_DescCat AS TextBox WITH ;
        FontName = "Tahoma", FontSize = 8, ;
        Height = 23, Left = 128, Top = 569, Width = 744, ;
        ReadOnly = .T., Visible = .F.

    *-- Label descricao do servico
    ADD OBJECT lbl_4c_Label3 AS Label WITH ;
        AutoSize = .T., FontName = "Tahoma", FontSize = 8, ;
        BackStyle = 0, ;
        Height = 15, Left = 128, Top = 548, Width = 108, ;
        ForeColor = RGB(90,90,90), Visible = .F.

    *-- Container canonico do botao OK (padrao cnt_4c_Saida com confirmacao)
    ADD OBJECT cnt_4c_Saida AS Container WITH ;
        Top = 3, Left = 917, Width = 90, Height = 85, ;
        BackStyle = 0, BorderWidth = 0, SpecialEffect = 0, Visible = .F.

    *==========================================================================
    * Init - Compartilha sessao de dados com o form pai e armazena estado
    * Equivalente ao LPARAMETERS pForm, DatSes do legado SIGPDM11.SCX
    *==========================================================================
    PROCEDURE Init(par_oParentForm, par_lChkCoef)
        IF VARTYPE(par_oParentForm) = "O"
            THIS.this_oPaiForm  = par_oParentForm
            THIS.DataSessionId  = par_oParentForm.DataSessionId
            IF TYPE("par_oParentForm.pcEscolha") = "C"
                THIS.this_cPcEscolha = ALLTRIM(par_oParentForm.pcEscolha)
            ENDIF
            *-- Captura _Dopp do form pai para posicionar crSigCdOpd
            IF TYPE("par_oParentForm._Dopp") <> "U"
                THIS.this_cDopp = TRANSFORM(par_oParentForm._Dopp)
            ENDIF
        ENDIF
        THIS.this_lChkCoef  = IIF(VARTYPE(par_lChkCoef) = "L", par_lChkCoef, .F.)
        THIS.this_cAntValue = SPACE(10)
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, prepara dados e configura a interface
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.this_oBusinessObject = CREATEOBJECT("SigPdM11BO")
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            MsgErro("Erro ao criar SigPdM11BO.", "Erro")
            RETURN loc_lSucesso
        ENDIF

        TRY
            THIS.Caption = "Pagamento de Servi" + CHR(231) + "os"
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject.this_cPcEscolha = THIS.this_cPcEscolha

            *-- Bloqueia tela durante setup (equivalente a This.LockScreen = .t. do legado)
            THIS.LockScreen = .T.

            *-- Garante cursores compartilhados (defensivo - se parent nao criou)
            THIS.ConfigurarDataEnvironment()

            *-- Posiciona crSigCdOpd na operacao passada (=Seek(pForm._Dopp,'crSigCdOpd','Dopps'))
            THIS.PosicionarOperacao()

            *-- Pre-preenche GrupoFs/ContaFs quando existe apenas uma conta
            THIS.InicializarGrupoContas()

            *-- Pre-calcula coeficientes de servico (equivalente ao Gravacat inicial)
            IF USED("xNensiS")
                SET CONFIRM ON
                SELECT xNensiS
                GO TOP
                THIS.this_oBusinessObject.GravarItens(.F.)
            ENDIF

            *-- Configura aparencia base do form (OPERACIONAL sem PageFrame CRUD)
            THIS.ConfigurarPageFrame()

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarOperacao()
            THIS.ConfigurarOptMov()
            THIS.ConfigurarDescricaoServico()
            THIS.ConfigurarSaida()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarBotoes()
            THIS.TornarControlesVisiveis(THIS)
            *-- AjustarIndicadores APOS TornarControlesVisiveis para sobrescrever
            *-- Visible dos indicadores Botao1/Botao2 conforme dados xNensiS atual
            THIS.AjustarIndicadores()

            THIS.LockScreen = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro ao inicializar FormSigPdM11")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarDataEnvironment - Garante existencia dos cursores compartilhados
    * Forms OPERACIONAIS compartilham datasession com o pai. Se um cursor
    * esperado nao foi aberto pelo pai, cria placeholder vazio para evitar
    * "Alias not found" nos ControlSource estaticos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDataEnvironment()
        LOCAL loc_oErro

        TRY
            *-- tmpnens: cursor com emps/dopps/numps usado pelo container Operacao
            IF NOT USED("tmpnens")
                CREATE CURSOR tmpnens ( ;
                    emps  C(2), ;
                    dopps C(30), ;
                    numps N(10,0))
                APPEND BLANK
                REPLACE tmpnens.emps  WITH go_4c_Sistema.cCodEmpresa, ;
                        tmpnens.dopps WITH "", ;
                        tmpnens.numps WITH 0
            ENDIF

            *-- crSigCdOpd: cadastro de operacoes (usado em SEEK por _Dopp)
            IF NOT USED("crSigCdOpd")
                CREATE CURSOR crSigCdOpd ( ;
                    Dopps C(30), ;
                    Codops C(10), ;
                    Emps   C(2))
                INDEX ON Dopps TAG Dopps
            ENDIF

            *-- xNensiS: cursor principal de itens de servico
            IF NOT USED("xNensiS")
                CREATE CURSOR xNensiS ( ;
                    Nenvs    N(10,0), ;
                    Cats     C(10), ;
                    Fators   N(14,2), ;
                    Qtds     N(14,2), ;
                    Contafs  C(10), ;
                    Grupofs  C(10), ;
                    cRetrabs C(10), ;
                    Coefs    N(14,2), ;
                    Coefinfs N(14,2), ;
                    Retrabs  L, ;
                    OsRets   L, ;
                    cDescs   C(60))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ConfigurarDataEnvironment")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PosicionarOperacao - Posiciona crSigCdOpd na linha do _Dopp recebido
    * Equivalente a =Seek(pForm._Dopp,'crSigCdOpd','Dopps') do legado
    *==========================================================================
    PROTECTED PROCEDURE PosicionarOperacao()
        LOCAL loc_oErro

        TRY
            IF EMPTY(THIS.this_cDopp) OR NOT USED("crSigCdOpd")
                RETURN
            ENDIF
            =SEEK(THIS.this_cDopp, "crSigCdOpd", "Dopps")
        CATCH TO loc_oErro
            *-- Falha de seek nao deve abortar form; campos ficam em branco
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Aparencia base do form (OPERACIONAL sem PageFrame)
    * Forms OPERACIONAIS (sub-modais de edicao) nao usam PageFrame Page1/Page2
    * como CRUD. Este metodo apenas define propriedades visuais globais do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *==========================================================================
    * AlternarPagina - Form OPERACIONAL plano: sem alternancia de paginas
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * InicializarGrupoContas - Se CsContas tem 1 conta, pre-preenche todos os itens
    *==========================================================================
    PROTECTED PROCEDURE InicializarGrupoContas()
        LOCAL loc_oErro

        TRY
            IF USED("CsContas")
                SELECT SUM(1) AS Qtd, Grupos, Contas ;
                    FROM CsContas ;
                    GROUP BY Grupos, Contas ;
                    INTO CURSOR CsTotal

                SELECT CsTotal
                IF RECCOUNT() = 1
                    SELECT CsContas
                    GO TOP
                    SELECT xNensiS
                    REPLACE ALL GrupoFs WITH CsContas.Grupos, ;
                                ContaFs WITH CsContas.Contas
                ENDIF

                IF USED("CsTotal")
                    USE IN CsTotal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarGrupoContas")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Adiciona labels de titulo no cnt_4c_Sombra
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        WITH THIS.cnt_4c_Sombra
            .ADDOBJECT("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = loc_cCaption
                .Height     = 40
                .Left       = 10
                .Top        = 18
                .Width      = 769
                .ForeColor  = RGB(0,0,0)
                .Visible    = .T.
            ENDWITH

            .ADDOBJECT("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = loc_cCaption
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = 769
                .ForeColor  = RGB(255,255,255)
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarOperacao - Configura container de informacoes da operacao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOperacao()
        WITH THIS.cnt_4c_Operacao
            .ADDOBJECT("lbl_4c_Say4", "Label")
            WITH .lbl_4c_Say4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
                .Left      = 23
                .Top       = 14
                .ForeColor = RGB(90,90,90)
                .Visible   = .T.
            ENDWITH

            *-- Empresa (tmpnens.emps)
            .ADDOBJECT("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .ControlSource     = "tmpnens.emps"
                .Height            = 23
                .Left              = 103
                .Top               = 10
                .Width             = 36
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .DisabledBackColor = RGB(255,255,255)
                .Visible           = .T.
            ENDWITH

            *-- Operacao descricao (tmpnens.dopps)
            .ADDOBJECT("txt_4c_Operacao", "TextBox")
            WITH .txt_4c_Operacao
                .ControlSource     = "tmpnens.dopps"
                .Height            = 23
                .Left              = 141
                .Top               = 10
                .Width             = 156
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .DisabledBackColor = RGB(255,255,255)
                .Visible           = .T.
            ENDWITH

            *-- Numero da operacao (tmpnens.numps)
            .ADDOBJECT("txt_4c_NumCodigo", "TextBox")
            WITH .txt_4c_NumCodigo
                .ControlSource     = "tmpnens.numps"
                .Format            = "L"
                .InputMask         = "9999999999"
                .Left              = 299
                .Top               = 10
                .Width             = 81
                .ReadOnly          = .T.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .DisabledBackColor = RGB(255,255,255)
                .Visible           = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarOptMov - Configura OptionGroup Movimentacao / Cadastro
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOptMov()
        WITH THIS.opt_4c_OptMov
            WITH .Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Value     = 1
                .Height    = 15
                .Left      = 3
                .Top       = 5
                .Width     = 87
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Cadastro"
                .Height    = 15
                .Left      = 112
                .Top       = 5
                .Width     = 62
                .AutoSize  = .T.
                .ForeColor = RGB(90,90,90)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarDescricaoServico - Configura label e textbox de descricao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDescricaoServico()
        WITH THIS.lbl_4c_Label3
            .Caption = "Descri" + CHR(231) + CHR(227) + "o do Servi" + CHR(231) + "o :"
        ENDWITH

        WITH THIS.txt_4c_DescCat
            .ControlSource = "xNensiS.cDescs"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarSaida - Adiciona cmd_4c_Ok no cnt_4c_Saida
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarSaida()
        WITH THIS.cnt_4c_Saida
            .ADDOBJECT("cmd_4c_Ok", "CommandButton")
            WITH .cmd_4c_Ok
                .Left            = 5
                .Top             = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "OK"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Cancel          = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
    ENDPROC

    *==========================================================================
    * BtnOkClick - Valida, grava itens e fecha o form retornando controle ao pai
    *==========================================================================
    PROCEDURE BtnOkClick()
        LOCAL loc_lOk, loc_lSucesso, loc_oErro
        loc_lOk      = .F.
        loc_lSucesso = .T.

        TRY
            loc_lOk = THIS.this_oBusinessObject.GravarItens(.T.)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnOkClick")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            IF !loc_lOk
                MsgAviso("Servi" + CHR(231) + "o n" + CHR(227) + "o cadastrado " + ;
                         "para este Grupo/conta!!!", "Aviso")
            ELSE
                IF VARTYPE(THIS.this_oPaiForm) = "O"
                    THIS.this_oPaiForm.Enabled = .T.
                ENDIF
                THIS.Release()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura grid grd_4c_Grade com 9 colunas
    * Widths e propriedades exatos do original SIGPDM11.SCX (PILAR 1)
    * Column1(O.S.)=98 | Column2(Cat.)=52 | Column3(Valor)=110 |
    * Column4(Qtds)=110 | Column5(Conta)=110 | Column6(Grupo)=110 |
    * Column7(Retrab.)=50 | Column8(ValorRetrab.)=110 | Column9(ValorInd.)=110
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_lEdit, loc_oGrd, loc_oErro
        loc_lEdit = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

        TRY
            loc_oGrd = THIS.grd_4c_Grade
            WITH loc_oGrd
                .RecordSource       = "xNensiS"
                .ColumnCount        = 9
                .HighlightStyle     = 2
                .HighlightBackColor = RGB(255,255,255)
                .HighlightForeColor = RGB(15,41,104)
                .ScrollBars         = 3
                .RowHeight          = 18
                .FontName           = "Verdana"
                .FontSize           = 8

                *-- Coluna 1: O.S. (Nenvs) - leitura, Courier New, Width=98
                WITH .Column1
                    .ControlSource = "xNensiS.Nenvs"
                    .ReadOnly      = .T.
                    .Width         = 98
                    .Alignment     = 2
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontName      = "Courier New"
                    .FontBold      = .T.
                    .Format        = "L"
                    .InputMask     = "9999999999"
                    WITH .Header1
                        .Caption   = "O.S."
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .BackColor   = RGB(255,255,255)
                        .ForeColor   = RGB(0,0,0)
                        .FontName    = "Courier New"
                        .FontBold    = .T.
                        .Margin      = 0
                    ENDWITH
                ENDWITH

                *-- Coluna 2: Cat. (Cats) - editavel, Width=52
                WITH .Column2
                    .ControlSource = "xNensiS.Cats"
                    .ReadOnly      = !loc_lEdit
                    .Width         = 52
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontBold      = .T.
                    WITH .Header1
                        .Caption   = "Cat."
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .BackColor   = RGB(255,255,255)
                        .ForeColor   = RGB(0,0,0)
                        .FontBold    = .T.
                        .Margin      = 0
                    ENDWITH
                ENDWITH

                *-- Coluna 3: Valor (Fators) - leitura, Width=110
                WITH .Column3
                    .ControlSource = "xNensiS.Fators"
                    .ReadOnly      = .T.
                    .Width         = 110
                    .Alignment     = 1
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontBold      = .T.
                    WITH .Header1
                        .Caption   = "Valor"
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .BackColor   = RGB(255,255,255)
                        .ForeColor   = RGB(0,0,0)
                        .FontBold    = .T.
                        .Margin      = 0
                    ENDWITH
                ENDWITH

                *-- Coluna 4: Quantidade (Qtds) - leitura, Width=110
                WITH .Column4
                    .ControlSource = "xNensiS.Qtds"
                    .ReadOnly      = .T.
                    .Width         = 110
                    .Alignment     = 1
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontBold      = .T.
                    WITH .Header1
                        .Caption   = "Quantidade"
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .BackColor   = RGB(255,255,255)
                        .ForeColor   = RGB(0,0,0)
                        .FontBold    = .T.
                        .Margin      = 0
                    ENDWITH
                ENDWITH

                *-- Coluna 5: Conta (Contafs) - editavel, Width=110
                WITH .Column5
                    .ControlSource = "xNensiS.Contafs"
                    .ReadOnly      = !loc_lEdit
                    .Width         = 110
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontBold      = .T.
                    WITH .Header1
                        .Caption   = "Conta"
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .BackColor   = RGB(255,255,255)
                        .ForeColor   = RGB(0,0,0)
                        .FontBold    = .T.
                        .Margin      = 0
                    ENDWITH
                ENDWITH

                *-- Coluna 6: Grupo (Grupofs) - editavel se opt=2, Width=110
                WITH .Column6
                    .ControlSource = "xNensiS.Grupofs"
                    .ReadOnly      = !loc_lEdit OR THIS.opt_4c_OptMov.Value <> 2
                    .Width         = 110
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontBold      = .T.
                    WITH .Header1
                        .Caption   = "Grupo"
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .BackColor   = RGB(255,255,255)
                        .ForeColor   = RGB(0,0,0)
                        .FontBold    = .T.
                        .Margin      = 0
                    ENDWITH
                ENDWITH

                *-- Coluna 7: Retrab. (cRetrabs) - editavel, Width=50
                WITH .Column7
                    .ControlSource = "xNensiS.cRetrabs"
                    .ReadOnly      = !loc_lEdit
                    .Width         = 50
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontBold      = .T.
                    WITH .Header1
                        .Caption   = "Retrab."
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .BackColor   = RGB(255,255,255)
                        .ForeColor   = RGB(0,0,0)
                        .FontBold    = .T.
                        .Margin      = 0
                    ENDWITH
                ENDWITH

                *-- Coluna 8: Valor Retrab. (Coefs) - leitura, Width=110
                WITH .Column8
                    .ControlSource = "xNensiS.Coefs"
                    .ReadOnly      = .T.
                    .Width         = 110
                    .Alignment     = 1
                    .Movable       = .F.
                    .FontBold      = .T.
                    WITH .Header1
                        .Caption   = "Valor Retrab."
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .BackColor   = RGB(255,255,255)
                        .ForeColor   = RGB(0,0,0)
                        .FontBold    = .T.
                        .Margin      = 0
                    ENDWITH
                ENDWITH

                *-- Coluna 9: Valor Indicado (Coefinfs) - leitura, Width=110
                WITH .Column9
                    .ControlSource = "xNensiS.Coefinfs"
                    .ReadOnly      = .T.
                    .Width         = 110
                    .Alignment     = 1
                    .Movable       = .F.
                    .Resizable     = .F.
                    .FontBold      = .T.
                    WITH .Header1
                        .Caption   = "Valor Indicado"
                        .Alignment = 2
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                    ENDWITH
                    WITH .Text1
                        .BorderStyle = 0
                        .BackColor   = RGB(255,255,255)
                        .ForeColor   = RGB(0,0,0)
                        .FontBold    = .T.
                        .Margin      = 0
                    ENDWITH
                ENDWITH
            ENDWITH

            *-- Aplica DynamicForeColor em TODAS as colunas
            *-- Retrabs (vermelho RGB(255,0,0)) tem precedencia sobre OsRets (azul RGB(0,0,255))
            *-- Equivalente ao .SetAll('DynamicForeColor', ...) do legado linha 920 do SCX
            loc_oGrd.SetAll("DynamicForeColor", ;
                "IIF(IIF(VARTYPE(xNensiS.Retrabs)='L',NVL(xNensiS.Retrabs,.F.),NVL(xNensiS.Retrabs,0)=1)," + ;
                "RGB(255,0,0)," + ;
                "IIF(IIF(VARTYPE(xNensiS.OsRets)='L',NVL(xNensiS.OsRets,.F.),NVL(xNensiS.OsRets,0)=1)," + ;
                "RGB(0,0,255),RGB(0,0,0)))", ;
                "Column")

            loc_oGrd.Refresh()

            BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdGradeAfterRowColChange")

            *-- F4/F5 explicito por coluna de lookup (Cat./Conta/Grupo/Retrab.)
            *-- Equivale aos PROCEDURE Valid do SCX legado, mas acionado tambem
            *-- por F4/F5/ENTER alem do AfterRowColChange (cell exit)
            BINDEVENT(loc_oGrd.Column2.Text1, "KeyPress", THIS, "GrdColCatKeyPress")
            BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress", THIS, "GrdColContaKeyPress")
            BINDEVENT(loc_oGrd.Column6.Text1, "KeyPress", THIS, "GrdColGrupoKeyPress")
            BINDEVENT(loc_oGrd.Column7.Text1, "KeyPress", THIS, "GrdColRetrabKeyPress")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - BINDEVENT para Botao1 (abre SigPdM12), Botao2 (info) e OptMov
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        BINDEVENT(THIS.txt_4c_Botao1,   "Click", THIS, "BtnBotao1Click")
        BINDEVENT(THIS.txt_4c_Botao2,   "Click", THIS, "BtnBotao2Click")
        BINDEVENT(THIS.opt_4c_OptMov,   "Click", THIS, "OptMovClick")
    ENDPROC

    *==========================================================================
    * GrdColCatKeyPress - F4/F5 dispara lookup explicito na coluna Categoria
    * F4=115, F5=116. Equivalente ao Valid do Column2.Text1 do SCX legado
    *==========================================================================
    PROCEDURE GrdColCatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.ValidarCategoria()
            THIS.grd_4c_Grade.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdColContaKeyPress - F4/F5 dispara lookup explicito na coluna Conta
    *==========================================================================
    PROCEDURE GrdColContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.ValidarConta()
            THIS.grd_4c_Grade.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdColGrupoKeyPress - F4/F5 dispara lookup explicito na coluna Grupo
    * Apenas ativo quando opt_4c_OptMov.Value = 2 (Cadastro)
    *==========================================================================
    PROCEDURE GrdColGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            IF THIS.opt_4c_OptMov.Value = 2
                THIS.ValidarGrupo()
                THIS.grd_4c_Grade.Refresh()
                NODEFAULT
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdColRetrabKeyPress - F4/F5 dispara lookup explicito na coluna Retrab.
    *==========================================================================
    PROCEDURE GrdColRetrabKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 116
            THIS.ValidarRetrabalho()
            THIS.grd_4c_Grade.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBotao2Click - Indicador visual de O.S. de Retorno (apenas informativo)
    *==========================================================================
    PROCEDURE BtnBotao2Click()
        MsgInfo("Este item " + CHR(233) + " uma O.S. de Retorno.", ;
                "O.S. de Retorno")
    ENDPROC

    *==========================================================================
    * GrdGradeAfterRowColChange - Atualiza DescCat e valida coluna anterior
    *==========================================================================
    PROCEDURE GrdGradeAfterRowColChange(par_nColIndex)
        THIS.txt_4c_DescCat.Refresh()
        THIS.AjustarIndicadores()

        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            DO CASE
            CASE THIS.this_nUltColuna = 2
                THIS.ValidarCategoria()
            CASE THIS.this_nUltColuna = 5
                THIS.ValidarConta()
            CASE THIS.this_nUltColuna = 6
                THIS.ValidarGrupo()
            CASE THIS.this_nUltColuna = 7
                THIS.ValidarRetrabalho()
            ENDCASE
        ENDIF

        THIS.this_nUltColuna = par_nColIndex
    ENDPROC

    *==========================================================================
    * AjustarIndicadores - Atualiza cor dos indicadores Botao1/Botao2
    *==========================================================================
    PROTECTED PROCEDURE AjustarIndicadores()
        LOCAL loc_lRetrab, loc_lOsRet, loc_oErro

        TRY
            IF USED("xNensiS") AND !EOF("xNensiS")
                IF VARTYPE(xNensiS.Retrabs) = "L"
                    loc_lRetrab = NVL(xNensiS.Retrabs, .F.)
                ELSE
                    loc_lRetrab = IIF(NVL(xNensiS.Retrabs, 0) = 1, .T., .F.)
                ENDIF
                IF VARTYPE(xNensiS.OsRets) = "L"
                    loc_lOsRet = NVL(xNensiS.OsRets, .F.)
                ELSE
                    loc_lOsRet = IIF(NVL(xNensiS.OsRets, 0) = 1, .T., .F.)
                ENDIF
                THIS.txt_4c_Botao1.Visible = loc_lRetrab
                THIS.txt_4c_Botao2.Visible = loc_lOsRet
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AjustarIndicadores")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarCategoria - Valida campo Cat. (Col2) ao sair da celula
    * Verifica em crSigCdSvc; se nao encontrado, abre lookup filtrado
    *==========================================================================
    PROCEDURE ValidarCategoria()
        LOCAL loc_cValor, loc_lEncontrado, loc_cGrupo, loc_cConta
        LOCAL loc_oBusca, loc_oErro

        TRY
            IF NOT USED("xNensiS") OR EOF("xNensiS")
                RETURN
            ENDIF
            SELECT xNensiS
            loc_cValor = ALLTRIM(NVL(xNensiS.Cats,    ""))
            loc_cGrupo = ALLTRIM(NVL(xNensiS.Grupofs, ""))
            loc_cConta = ALLTRIM(NVL(xNensiS.Contafs, ""))

            IF EMPTY(loc_cValor)
                RETURN
            ENDIF

            loc_lEncontrado = .F.

            IF USED("crSigCdSvc")
                LOCAL loc_nWa
                loc_nWa = SELECT()
                SELECT crSigCdSvc
                SET ORDER TO CaGruCo
                DO CASE
                CASE SEEK(xNensiS.Cats + xNensiS.Grupofs + xNensiS.Contafs)
                    loc_lEncontrado = .T.
                CASE SEEK(xNensiS.Cats + xNensiS.Grupofs + SPACE(10))
                    loc_lEncontrado = .T.
                CASE SEEK(xNensiS.Cats + SPACE(20))
                    loc_lEncontrado = .T.
                ENDCASE
                SELECT (loc_nWa)
            ENDIF

            IF !loc_lEncontrado AND USED("crSigCdSvc")
                SELECT * FROM crSigCdSvc ;
                    WHERE (RTRIM(Grupos)+RTRIM(Contas) = RTRIM(m.loc_cGrupo)+RTRIM(m.loc_cConta)) ;
                    OR  (RTRIM(Grupos) = RTRIM(m.loc_cGrupo) AND LTRIM(RTRIM(Contas)) = "") ;
                    OR  (LTRIM(RTRIM(Grupos)) = "") ;
                    INTO CURSOR cursor_4c_BuscaCat READWRITE

                IF USED("cursor_4c_BuscaCat") AND RECCOUNT("cursor_4c_BuscaCat") > 0
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCat"
                        loc_oBusca.this_cTitulo = "Sele" + CHR(231) + CHR(227) + "o de Categoria"
                        loc_oBusca.mAddColuna("CCats",  "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("CDescs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
                            SELECT xNensiS
                            REPLACE xNensiS.Cats WITH ALLTRIM(cursor_4c_BuscaCat.CCats)
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaCat")
                    USE IN cursor_4c_BuscaCat
                ENDIF
            ENDIF

            THIS.this_oBusinessObject.GravarItens(.F.)
            THIS.txt_4c_DescCat.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ValidarCategoria")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarConta - Valida campo Conta (Col5) ao sair da celula
    * opt=1: lookup em CsContas filtrado por Nenvs
    * opt=2: Grupo ja trata a conta (coluna 6 assume controle)
    *==========================================================================
    PROCEDURE ValidarConta()
        LOCAL loc_cValor, loc_lEncontrado, loc_nNenvs
        LOCAL loc_oBusca, loc_oErro

        TRY
            IF NOT USED("xNensiS") OR EOF("xNensiS")
                RETURN
            ENDIF
            SELECT xNensiS
            loc_cValor = ALLTRIM(NVL(xNensiS.Contafs, ""))
            loc_nNenvs = NVL(xNensiS.Nenvs, 0)

            IF EMPTY(loc_cValor)
                RETURN
            ENDIF

            IF THIS.opt_4c_OptMov.Value = 1 AND USED("CsContas")
                SELECT * FROM CsContas ;
                    WHERE Nenvs = loc_nNenvs ;
                    INTO CURSOR cursor_4c_BuscaConta READWRITE

                IF USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
                    SELECT cursor_4c_BuscaConta
                    INDEX ON Contas TAG Contas

                    loc_lEncontrado = SEEK(loc_cValor, "cursor_4c_BuscaConta", "Contas")
                    IF !loc_lEncontrado
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                        IF VARTYPE(loc_oBusca) = "O"
                            loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
                            loc_oBusca.this_cTitulo = "Cadastro de Contas"
                            loc_oBusca.mAddColuna("Contas", "", "Conta")
                            loc_oBusca.mAddColuna("Grupos", "", "Grupo")
                            loc_oBusca.Show()
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                                SELECT xNensiS
                                REPLACE xNensiS.Contafs WITH ALLTRIM(cursor_4c_BuscaConta.Contas), ;
                                        xNensiS.Grupofs WITH ALLTRIM(cursor_4c_BuscaConta.Grupos)
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                    ELSE
                        SELECT xNensiS
                        REPLACE xNensiS.Contafs WITH ALLTRIM(cursor_4c_BuscaConta.Contas), ;
                                xNensiS.Grupofs WITH ALLTRIM(cursor_4c_BuscaConta.Grupos)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF

                THIS.this_oBusinessObject.GravarItens(.F.)
                THIS.txt_4c_DescCat.Refresh()
            ELSE
                IF THIS.opt_4c_OptMov.Value = 2 AND USED("TmpCli")
                *-- opt=2: lookup em TmpCli (cursor de clientes/contas do form pai)
                loc_lEncontrado = SEEK(loc_cValor, "TmpCli", "BalCodigo")
                IF !loc_lEncontrado
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "TmpCli"
                        loc_oBusca.this_cTitulo = "Cadastro de Contas"
                        loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("RClis",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("Grupos", "", "Grupo")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("TmpCli")
                            SELECT xNensiS
                            REPLACE xNensiS.Contafs WITH ALLTRIM(TmpCli.IClis), ;
                                    xNensiS.Grupofs WITH ALLTRIM(TmpCli.Grupos)
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ELSE
                    SELECT xNensiS
                    REPLACE xNensiS.Contafs WITH ALLTRIM(TmpCli.IClis), ;
                            xNensiS.Grupofs WITH ALLTRIM(TmpCli.Grupos)
                ENDIF

                THIS.this_oBusinessObject.GravarItens(.F.)
                THIS.txt_4c_DescCat.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ValidarConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarGrupo - Valida campo Grupo (Col6) ao sair da celula
    * Ativo apenas quando opt_4c_OptMov.Value = 2
    * Lookup em TmpGccr indexado por BalCodigo
    *==========================================================================
    PROCEDURE ValidarGrupo()
        LOCAL loc_cValor, loc_lEncontrado
        LOCAL loc_oBusca, loc_oErro

        TRY
            IF NOT USED("xNensiS") OR EOF("xNensiS")
                RETURN
            ENDIF
            IF THIS.opt_4c_OptMov.Value <> 2
                RETURN
            ENDIF

            SELECT xNensiS
            loc_cValor = ALLTRIM(NVL(xNensiS.Grupofs, ""))
            IF EMPTY(loc_cValor)
                RETURN
            ENDIF

            loc_lEncontrado = .F.
            IF USED("TmpGccr")
                loc_lEncontrado = SEEK(loc_cValor, "TmpGccr", "BalCodigo")
            ENDIF

            IF !loc_lEncontrado AND USED("TmpGccr")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.this_cCursorDestino = "TmpGccr"
                    loc_oBusca.this_cTitulo = "Cadastro de Grupos"
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("TmpGccr")
                        SELECT xNensiS
                        REPLACE xNensiS.Grupofs WITH ALLTRIM(TmpGccr.Codigos)
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                IF loc_lEncontrado AND USED("TmpGccr")
                SELECT xNensiS
                REPLACE xNensiS.Grupofs WITH ALLTRIM(TmpGccr.Codigos)
                ENDIF
            ENDIF

            THIS.this_oBusinessObject.GravarItens(.F.)
            THIS.txt_4c_DescCat.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ValidarGrupo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarRetrabalho - Valida campo Retrab. (Col7) ao sair da celula
    * Lookup em SigPrCrt via SQLEXEC
    *==========================================================================
    PROCEDURE ValidarRetrabalho()
        LOCAL loc_cValor, loc_lEncontrado, loc_cSQL, loc_nResult
        LOCAL loc_oBusca, loc_oErro

        TRY
            IF NOT USED("xNensiS") OR EOF("xNensiS")
                RETURN
            ENDIF
            SELECT xNensiS
            loc_cValor = ALLTRIM(NVL(xNensiS.cRetrabs, ""))
            IF EMPTY(loc_cValor)
                RETURN
            ENDIF

            loc_cSQL = "SELECT Cods, Descrs FROM SigPrCrt " + ;
                       "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       "  OR LTRIM(RTRIM(Emps)) = ''"

            IF USED("cursor_4c_BuscaRetrab")
                USE IN cursor_4c_BuscaRetrab
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaRetrab")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaRetrab") > 0
                SELECT cursor_4c_BuscaRetrab
                INDEX ON Cods TAG Cods
                loc_lEncontrado = SEEK(loc_cValor, "cursor_4c_BuscaRetrab", "Cods")
                IF !loc_lEncontrado
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaRetrab"
                        loc_oBusca.this_cTitulo = "Retrabalhos"
                        loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRetrab")
                            SELECT xNensiS
                            REPLACE xNensiS.cRetrabs WITH ALLTRIM(cursor_4c_BuscaRetrab.Cods)
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Retrabalho n" + CHR(227) + "o encontrado.", "Aviso")
                SELECT xNensiS
                REPLACE xNensiS.cRetrabs WITH ""
            ENDIF

            IF USED("cursor_4c_BuscaRetrab")
                USE IN cursor_4c_BuscaRetrab
            ENDIF

            THIS.this_oBusinessObject.GravarItens(.F.)
            THIS.txt_4c_DescCat.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ValidarRetrabalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * OptMovClick - Ajusta ReadOnly da coluna Grupo ao mudar opcao de movimentacao
    *==========================================================================
    PROCEDURE OptMovClick()
        LOCAL loc_lEdit
        loc_lEdit = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
        THIS.grd_4c_Grade.Column6.ReadOnly = !loc_lEdit OR THIS.opt_4c_OptMov.Value <> 2
    ENDPROC

    *==========================================================================
    * BtnBotao1Click - Abre FormSigPdM12 (detalhe de retrabalhos) se ha registro
    *==========================================================================
    PROCEDURE BtnBotao1Click()
        LOCAL loc_oForm, loc_oErro

        TRY
            IF USED("xNensiR") AND !EOF("xNensiR")
                THIS.Enabled = .F.
                loc_oForm = CREATEOBJECT("FormSigPdM12", THIS)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                ELSE
                    THIS.Enabled = .T.
                    MsgAviso("Formul" + CHR(225) + "rio de Retrabalhos n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.Enabled = .T.
            MsgErro(loc_oErro.Message, "Erro ao abrir FormSigPdM12")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Define modo INSERIR: grid fica editavel para novas entradas
    * Chamado quando o form pai precisa reabrir a edicao em modo inclusao
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_cPcEscolha = "INSERIR"
        THIS.this_oBusinessObject.this_cPcEscolha = "INSERIR"
        THIS.AjustarModoEdicao()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Define modo ALTERAR: grid fica editavel para correcoes
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.this_cPcEscolha = "ALTERAR"
        THIS.this_oBusinessObject.this_cPcEscolha = "ALTERAR"
        THIS.AjustarModoEdicao()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Define modo VISUALIZAR: grid fica somente leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.this_cPcEscolha = "VISUALIZAR"
        THIS.this_oBusinessObject.this_cPcEscolha = "VISUALIZAR"
        THIS.AjustarModoEdicao()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclusao de itens nao suportada neste sub-form
    * Regra de negocio: a gestao do conjunto de itens (adicionar/remover linhas
    * de xNensiS) e responsabilidade do form pai (SigPdM10). Este form edita
    * propriedades de itens existentes mas nao remove registros do cursor.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        MsgAviso("A exclus" + CHR(227) + "o de itens de pagamento " + ;
                 CHR(233) + " gerenciada pelo formul" + CHR(225) + "rio principal.", ;
                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    *==========================================================================
    * AjustarModoEdicao - Aplica ReadOnly nas colunas editaveis conforme pcEscolha
    * Centraliza a logica que antes estava embutida em ConfigurarPaginaLista
    *==========================================================================
    PROTECTED PROCEDURE AjustarModoEdicao()
        LOCAL loc_lEdit

        loc_lEdit = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

        WITH THIS.grd_4c_Grade
            .Column2.ReadOnly = !loc_lEdit
            .Column5.ReadOnly = !loc_lEdit
            .Column6.ReadOnly = !loc_lEdit OR THIS.opt_4c_OptMov.Value <> 2
            .Column7.ReadOnly = !loc_lEdit
        ENDWITH

        THIS.grd_4c_Grade.Refresh()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - API publica para ajustar modo de edicao do grid
    * Delega para AjustarModoEdicao. Chamado pelo form pai quando necessario
    * mudar pcEscolha apos o sub-form ja estar aberto.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        THIS.AjustarModoEdicao()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita colunas editaveis do grid
    * Equivalente ao HabilitarCampos de forms CRUD, adaptado para grid-only.
    * par_lHabilitar: .T. = modo edicao ativo (INSERIR/ALTERAR)
    *                 .F. = modo leitura (VISUALIZAR)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lEdit

        IF VARTYPE(par_lHabilitar) = "L"
            loc_lEdit = par_lHabilitar
        ELSE
            loc_lEdit = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
        ENDIF

        WITH THIS.grd_4c_Grade
            .Column2.ReadOnly = !loc_lEdit
            .Column5.ReadOnly = !loc_lEdit
            .Column6.ReadOnly = !loc_lEdit OR THIS.opt_4c_OptMov.Value <> 2
            .Column7.ReadOnly = !loc_lEdit
        ENDWITH

        THIS.grd_4c_Grade.Refresh()
    ENDPROC

    *==========================================================================
    * CarregarLista - Religa grid ao cursor xNensiS e reaplica formatacao
    * Chamado apos o form pai atualizar dados em xNensiS sem recriar o form.
    * O ColumnCount e preservado para nao perder headers e ControlSources.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oErro

        TRY
            WITH THIS.grd_4c_Grade
                .RecordSource = "xNensiS"
                .Refresh()
            ENDWITH
            THIS.txt_4c_DescCat.Refresh()
            THIS.AjustarIndicadores()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em CarregarLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Reaplica formatacao visual padrao no grid
    * Preserva FontName=Verdana (padrao do framework para grids).
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
            .SetAll("FontBold", .T., "Column")
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormParaBO - Mapeia linha atual de xNensiS para propriedades do BO
    * Delega para CarregarDoCursor do BO, que faz NVL/TRIM em cada campo.
    * Tambem propaga estado de modo (this_cPcEscolha) e opcao OptMov.
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                loc_lSucesso = .F.
            ENDIF

            *-- Propaga estado atual do form para o BO
            THIS.this_oBusinessObject.this_cPcEscolha = THIS.this_cPcEscolha
            THIS.this_oBusinessObject.this_nOptMov    = THIS.opt_4c_OptMov.Value

            *-- Contexto do cabecalho (tmpnens) se existir
            IF USED("tmpnens") AND !EOF("tmpnens")
                SELECT tmpnens
                THIS.this_oBusinessObject.this_nNumps = NVL(tmpnens.numps, 0)
                THIS.this_oBusinessObject.this_cEmps  = ALLTRIM(NVL(tmpnens.emps,  ""))
                THIS.this_oBusinessObject.this_cDopps = ALLTRIM(NVL(tmpnens.dopps, ""))
            ENDIF

            *-- Mapeia linha corrente do grid (xNensiS)
            IF USED("xNensiS") AND !EOF("xNensiS")
                loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor("xNensiS")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Reflete estado do BO no form (modo, opcao, refresh do grid)
    * Como o grid esta bindado a xNensiS via ControlSource, basta refrescar
    * os controles vinculados. Tambem ajusta ReadOnly conforme modo do BO.
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                RETURN
            ENDIF

            *-- Sincroniza modo a partir do BO (caso BO tenha mudado)
            IF !EMPTY(THIS.this_oBusinessObject.this_cPcEscolha)
                THIS.this_cPcEscolha = THIS.this_oBusinessObject.this_cPcEscolha
            ENDIF

            *-- Sincroniza OptMov (1=Movimentacao, 2=Cadastro)
            IF THIS.this_oBusinessObject.this_nOptMov >= 1 ;
               AND THIS.this_oBusinessObject.this_nOptMov <= 2
                THIS.opt_4c_OptMov.Value = THIS.this_oBusinessObject.this_nOptMov
            ENDIF

            *-- Aplica modo de edicao nas colunas do grid
            THIS.AjustarModoEdicao()

            THIS.grd_4c_Grade.Refresh()
            THIS.txt_4c_DescCat.Refresh()
            THIS.AjustarIndicadores()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta estado visual e propriedades do BO sem destruir
    * o cursor xNensiS (compartilhado com o form pai - nao pode ser zapado).
    * Posiciona no topo, limpa descricao e indicadores e zera props do BO.
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_nNenvs     = 0
                THIS.this_oBusinessObject.this_cCats      = ""
                THIS.this_oBusinessObject.this_nFators    = 0
                THIS.this_oBusinessObject.this_nQtds      = 0
                THIS.this_oBusinessObject.this_cContafs   = ""
                THIS.this_oBusinessObject.this_cGrupofs   = ""
                THIS.this_oBusinessObject.this_cCretrabs  = ""
                THIS.this_oBusinessObject.this_nCoefs     = 0
                THIS.this_oBusinessObject.this_nCoefinfs  = 0
                THIS.this_oBusinessObject.this_lRetrabs   = .F.
                THIS.this_oBusinessObject.this_lOsRets    = .F.
                THIS.this_oBusinessObject.this_cCdescs    = ""
                THIS.this_oBusinessObject.this_cGrupofins = ""
                THIS.this_oBusinessObject.this_cMoedas    = ""
                THIS.this_oBusinessObject.this_cDescsCat  = ""
                THIS.this_oBusinessObject.this_cAntValueCats = ""
            ENDIF

            THIS.this_cAntValue  = SPACE(10)
            THIS.this_nUltColuna = 0

            *-- Reposiciona cursor no topo (nao destroi dados - cursor compartilhado)
            IF USED("xNensiS")
                SELECT xNensiS
                LOCATE
                IF !EOF()
                    GO TOP
                ENDIF
            ENDIF

            *-- Esconde indicadores e refresca descricao
            THIS.txt_4c_Botao1.Visible = .F.
            THIS.txt_4c_Botao2.Visible = .F.
            THIS.txt_4c_DescCat.Refresh()
            THIS.grd_4c_Grade.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma alteracoes (equivalente ao OK do legado)
    * Delega para BtnOkClick que executa Gravacat e fecha o form se sucesso.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnOkClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Restaura valor anterior (equivalente ao AntValue ESC)
    * No legado, ESC restaura AntValue na celula sem fechar o form. Aqui,
    * limpamos o valor da celula corrente do grid e retornamos para o pai.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            *-- Restaura AntValue (valor anterior) na celula ativa do grid
            IF USED("xNensiS") AND !EOF("xNensiS") AND !EMPTY(THIS.this_cAntValue)
                LOCAL loc_nCol
                loc_nCol = THIS.grd_4c_Grade.ActiveColumn
                DO CASE
                CASE loc_nCol = 2  && Cat.
                    REPLACE xNensiS.Cats     WITH THIS.this_cAntValue IN xNensiS
                CASE loc_nCol = 5  && Conta
                    REPLACE xNensiS.Contafs  WITH THIS.this_cAntValue IN xNensiS
                CASE loc_nCol = 6  && Grupo
                    REPLACE xNensiS.Grupofs  WITH THIS.this_cAntValue IN xNensiS
                CASE loc_nCol = 7  && Retrab.
                    REPLACE xNensiS.cRetrabs WITH THIS.this_cAntValue IN xNensiS
                ENDCASE
                THIS.this_cAntValue = SPACE(10)
            ENDIF

            THIS.grd_4c_Grade.Refresh()
            THIS.txt_4c_DescCat.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Atualiza grid e reposiciona cursor xNensiS no topo
    * Como xNensiS e compartilhado com o pai, "buscar" significa recarregar
    * a visualizacao e revalidar coeficientes do servico nos itens existentes.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro

        TRY
            IF USED("xNensiS")
                SELECT xNensiS
                GO TOP
                *-- Revalida coeficientes (equivalente ao Gravacat inicial)
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.GravarItens(.F.)
                ENDIF
            ENDIF
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o sub-form devolvendo controle ao form pai
    * Equivalente a ThisForm.ParentForm.Enabled = .t. + ThisForm.Release
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oPaiForm) = "O"
                THIS.this_oPaiForm.Enabled = .T.
            ENDIF
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        THIS.this_oPaiForm        = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
