*==============================================================================
* Formsigproer.prg - Form Reimpressao SiTef
* Form original: SIGPROER.SCX
* Tipo: OPERACIONAL (dialogo especializado de terminal de pagamento SiTef)
* Herda de: FormBase
*==============================================================================

DEFINE CLASS Formsigproer AS FormBase

    *-- Propriedades visuais do dialogo compacto SiTef
    Width       = 400
    Height      = 200
    AutoCenter  = .T.
    Caption     = "Reimpressao do SiTef"
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    BorderStyle = 2

    *-- Parametros recebidos na abertura (populados no Init antes do DODEFAULT)
    this_cEndSitef   = ""
    this_cCaixa      = ""
    this_cNSU        = ""
    this_cData       = ""
    this_cValor      = ""
    this_cHora       = ""
    this_cCodEstabs  = ""

    *-- Estado do protocolo SiTef (equivalem as PUBLIC vars do legado)
    this_nProximoComando  = 0
    this_nTipoCampo       = 0
    this_nTamanhoMinimo   = 0
    this_nTamanhoMaximo   = 0
    this_cBuffer          = ""
    this_nContinua        = 0
    this_lIdent           = .F.
    this_cNSULocal        = ""
    this_cDataLocal       = ""
    this_cMensagem        = ""

    *-- Estado da carga da DLL SiTef
    this_lDllCarregada    = .F.
    this_cErroDll         = ""

    *--------------------------------------------------------------------------
    * Init - Captura parametros e inicia o form
    * Equivale ao Init + Load do legado (Load declara DLLs, Init armazena params)
    * LPARAMETERS: EndSitef, pcCaixa, pcNSU, pcData, pcValor,
    *              pcdata (duplicata legado), pcHora, pcCodEstabs
    *--------------------------------------------------------------------------
    PROCEDURE Init
    LPARAMETERS par_cEndSitef, par_cCaixa, par_cNSU, par_cData, par_cValor, ;
                par_cData2, par_cHora, par_cCodEstabs

        THIS.CarregarDlls()

        THIS.this_cEndSitef  = IIF(VARTYPE(par_cEndSitef)  = "C", ALLTRIM(par_cEndSitef),  "")
        THIS.this_cCaixa     = IIF(VARTYPE(par_cCaixa)     = "C", ALLTRIM(par_cCaixa),     "")
        THIS.this_cNSU       = IIF(VARTYPE(par_cNSU)       = "C", ALLTRIM(par_cNSU),       "")
        THIS.this_cData      = IIF(VARTYPE(par_cData)      = "C", ALLTRIM(par_cData),      "")
        THIS.this_cValor     = IIF(VARTYPE(par_cValor)     = "C", ALLTRIM(par_cValor),     "")
        THIS.this_cHora      = IIF(VARTYPE(par_cHora)      = "C", ALLTRIM(par_cHora),      "")
        THIS.this_cCodEstabs = IIF(VARTYPE(par_cCodEstabs) = "C", ALLTRIM(par_cCodEstabs), "")

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO, conecta ao SiTef e monta layout
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigproerBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                WITH THIS.this_oBusinessObject
                    .this_cEndSitef  = THIS.this_cEndSitef
                    .this_cCaixa     = THIS.this_cCaixa
                    .this_cNSU       = THIS.this_cNSU
                    .this_cData      = THIS.this_cData
                    .this_cValor     = THIS.this_cValor
                    .this_cHora      = THIS.this_cHora
                    .this_cCodEstabs = THIS.this_cCodEstabs
                ENDWITH

                *-- Inicializa vars do protocolo SiTef com params recebidos no Init
                THIS.this_cNSULocal  = THIS.this_cNSU
                THIS.this_cDataLocal = THIS.this_cData

                *-- Monta layout visual independentemente da disponibilidade da DLL
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                loc_lSucesso = .T.

                *-- DLL ausente: aviso informativo, nao impede a instanciacao
                IF !THIS.this_lDllCarregada
                    MsgErro("DLL SiTef n" + CHR(227) + "o carregada: " + THIS.this_cErroDll, "Erro")
                ELSE
                    IF !EMPTY(THIS.this_cEndSitef)
                        THIS.this_oBusinessObject.CarregarDadosEmpresa()
                        THIS.this_oBusinessObject.IniciarProtocolo()
                    ELSE
                        MsgAviso("Endere" + CHR(231) + "o do servidor SiTef n" + CHR(227) + "o informado.", ;
                                 "Valida" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ELSE
                MsgErro("Erro ao criar sigproerBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDlls - Declara funcoes externas da DLL CliSiTef32I.DLL
    * Equivale ao PROCEDURE Load do legado
    * DLL pode estar ausente em ambientes de teste; erro e diferido para
    * InicializarForm onde MsgErro e exibido antes de tentar usar o protocolo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDlls()
        LOCAL loc_oErro
        TRY
            DECLARE INTEGER ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                STRING lsEndereco, STRING lsLoja, STRING lsTerminal, INTEGER lnReservado
            DECLARE INTEGER IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnModalidade, STRING lsValor, STRING lsCupom, STRING lsData, ;
                STRING lsHorario, STRING lsOperador, STRING lsRestricao
            DECLARE INTEGER ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER @lnComando, INTEGER @lnTipo, INTEGER @lnMinimo, INTEGER @lnMaximo, ;
                STRING @lsBuffer, INTEGER lnTamanho, INTEGER lnResultado
            THIS.this_lDllCarregada = .T.
        CATCH TO loc_oErro
            THIS.this_lDllCarregada = .F.
            THIS.this_cErroDll = loc_oErro.Message
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestra construcao visual do form dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarAreaPrincipal()
        THIS.ConfigurarSaida()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Header cinza escuro (equivale ao cntSombra do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 1
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .BackStyle = 0
            .Caption   = "Reimpress" + CHR(227) + "o do SiTef"
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = loc_oCab.Width
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .BackStyle = 0
            .Caption   = "Reimpress" + CHR(227) + "o do SiTef"
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = loc_oCab.Width
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAreaPrincipal - Area de interacao SiTef com Shape, Labels, TextBoxes
    * Posicoes originais: Shape1(Top=94,L=76,W=247,H=42) + Label3 + GetSenha +
    * SENHA + Container1 - todos relativos a Top=82 (pos apos header)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAreaPrincipal()
        LOCAL loc_oArea
        THIS.AddObject("cnt_4c_Area", "Container")
        loc_oArea = THIS.cnt_4c_Area
        WITH loc_oArea
            .Top         = 82
            .Left        = 0
            .Width       = THIS.Width - 90
            .Height      = THIS.Height - 82
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Shape visual ao redor da area de entrada (Shape1: Top=94 -> rel=12)
        loc_oArea.AddObject("shp_4c_Borda", "Shape")
        WITH loc_oArea.shp_4c_Borda
            .Top         = 12
            .Left        = 76
            .Width       = 247
            .Height      = 42
            .BackStyle   = 0
            .BorderColor = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        *-- Label "Senha do Supervisor :" (Label3: Top=108 -> rel=26)
        loc_oArea.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oArea.lbl_4c_Label3
            .AutoSize  = .F.
            .Top       = 26
            .Left      = 90
            .Width     = 108
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Senha do Supervisor :"
            .Visible   = .T.
        ENDWITH

        *-- TextBox GetSenha para leitura de cartao (Top=103 -> rel=21)
        *-- PasswordChar="*" oculta dados sensiveis do cartao
        loc_oArea.AddObject("txt_4c_GetSenha", "TextBox")
        WITH loc_oArea.txt_4c_GetSenha
            .Top          = 21
            .Left         = 214
            .Width        = 100
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .Value        = ""
            .PasswordChar = "*"
            .Visible      = .T.
        ENDWITH
        BINDEVENT(loc_oArea.txt_4c_GetSenha, "GotFocus",  THIS, "TxtGetSenhaGotFocus")
        BINDEVENT(loc_oArea.txt_4c_GetSenha, "KeyPress", THIS, "TxtGetSenhaLostFocus")
        BINDEVENT(loc_oArea.txt_4c_GetSenha, "When",      THIS, "TxtGetSenhaWhen")

        *-- TextBox SENHA do supervisor - mesma posicao que GetSenha
        *-- Protocolo SiTef alterna foco via When (so foca quando o outro ja esta preenchido)
        loc_oArea.AddObject("txt_4c_Senha", "TextBox")
        WITH loc_oArea.txt_4c_Senha
            .Top          = 21
            .Left         = 214
            .Width        = 100
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .Value        = ""
            .PasswordChar = "*"
            .Visible      = .T.
        ENDWITH
        BINDEVENT(loc_oArea.txt_4c_Senha, "GotFocus",  THIS, "TxtSenhaGotFocus")
        BINDEVENT(loc_oArea.txt_4c_Senha, "KeyPress", THIS, "TxtSenhaLostFocus")
        BINDEVENT(loc_oArea.txt_4c_Senha, "When",      THIS, "TxtSenhaWhen")

        *-- Container instrucao equivale ao Container1 (Top=141 -> rel=59, W=171, H=56)
        loc_oArea.AddObject("cnt_4c_Instrucao", "Container")
        WITH loc_oArea.cnt_4c_Instrucao
            .Top         = 59
            .Left        = 114
            .Width       = 171
            .Height      = 56
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oArea.cnt_4c_Instrucao.AddObject("lbl_4c_Instrucao", "Label")
        WITH loc_oArea.cnt_4c_Instrucao.lbl_4c_Instrucao
            .AutoSize  = .F.
            .Top       = 17
            .Left      = 9
            .Width     = 157
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .T.
            .Alignment = 2
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .WordWrap  = .T.
            .Caption   = "Insira ou Passe o Cart" + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarSaida - Botao Cancelar (equivale ao SAIDA CommandGroup do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarSaida()
        LOCAL loc_oSaida
        THIS.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = THIS.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 82
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oSaida.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Cancelar
            .Top             = 5
            .Left            = 5
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
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oSaida.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGetSenhaWhen - Permite foco em GetSenha apenas quando vazio
    * Equivale ao GetSenha.When: Return(EMPTY(This.Value)) do legado
    *--------------------------------------------------------------------------
    PROCEDURE TxtGetSenhaWhen()
        RETURN EMPTY(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGetSenhaGotFocus - Loop protocolo SiTef ate TipoCampo=500 (aguarda cartao)
    * Equivale ao GetSenha.GotFocus do legado (41 linhas)
    *--------------------------------------------------------------------------
    PROCEDURE TxtGetSenhaGotFocus()
        THIS.this_nProximoComando  = 0
        THIS.this_nTipoCampo       = 0
        THIS.this_nTamanhoMinimo   = 0
        THIS.this_nTamanhoMaximo   = 0
        THIS.this_cBuffer          = REPLICATE(CHR(0), 2000)
        THIS.this_nContinua        = 0
        THIS.this_cMensagem        = ""
        THIS.ExecutarLoopContinua(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGetSenhaLostFocus - Envia dado do cartao ao protocolo SiTef
    * Equivale ao GetSenha.LostFocus do legado (43 linhas)
    * Acumula TipoCampo 121/122 e finaliza com MontaRetorno se retorno=0
    *--------------------------------------------------------------------------
    PROCEDURE TxtGetSenhaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nRetorno, loc_cBuf, loc_cCupom, loc_lFalhou
        LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax

        IF EMPTY(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
            RETURN
        ENDIF

        loc_cBuf = ALLTRIM(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
        loc_cBuf = loc_cBuf + REPLICATE(CHR(0), 2000 - LEN(loc_cBuf))
        THIS.this_cBuffer   = loc_cBuf
        THIS.this_nContinua = 1000
        THIS.this_cMensagem = ""
        loc_cCupom          = ""
        loc_lFalhou         = .F.

        loc_nCmd  = THIS.this_nProximoComando
        loc_nTipo = THIS.this_nTipoCampo
        loc_nMin  = THIS.this_nTamanhoMinimo
        loc_nMax  = THIS.this_nTamanhoMaximo
        loc_cBuf  = THIS.this_cBuffer

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nCmd, @loc_nTipo, @loc_nMin, ;
            @loc_nMax, @loc_cBuf, LEN(loc_cBuf), THIS.this_nContinua)

        THIS.this_nProximoComando = loc_nCmd
        THIS.this_nTipoCampo      = loc_nTipo
        THIS.this_nTamanhoMinimo  = loc_nMin
        THIS.this_nTamanhoMaximo  = loc_nMax
        THIS.this_cBuffer         = loc_cBuf
        THIS.this_nContinua       = 0

        DO WHILE loc_nRetorno = 10000
            loc_nCmd  = THIS.this_nProximoComando
            loc_nTipo = THIS.this_nTipoCampo
            loc_nMin  = THIS.this_nTamanhoMinimo
            loc_nMax  = THIS.this_nTamanhoMaximo
            loc_cBuf  = THIS.this_cBuffer

            loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nCmd, @loc_nTipo, @loc_nMin, ;
                @loc_nMax, @loc_cBuf, LEN(loc_cBuf), THIS.this_nContinua)

            THIS.this_nProximoComando = loc_nCmd
            THIS.this_nTipoCampo      = loc_nTipo
            THIS.this_nTamanhoMinimo  = loc_nMin
            THIS.this_nTamanhoMaximo  = loc_nMax
            THIS.this_cBuffer         = loc_cBuf

            IF loc_nRetorno < 0
                THIS.RetornoFalha(THIS.this_cMensagem)
                loc_lFalhou = .T.
                EXIT
            ENDIF

            IF UPPER(ALLTRIM(THIS.this_cBuffer)) = "DOC INEXISTENTE"
                THIS.RetornoFalha("DOC INEXISTENTE")
                loc_lFalhou = .T.
                EXIT
            ENDIF

            IF THIS.this_nTipoCampo = 121 AND EMPTY(loc_cCupom)
                loc_cCupom = THIS.this_cBuffer + THIS.this_cBuffer
            ENDIF
            IF THIS.this_nTipoCampo = 122
                loc_cCupom = loc_cCupom + THIS.this_cBuffer
            ENDIF

            IF THIS.this_nProximoComando = 20
                loc_cBuf = "0" + REPLICATE(CHR(0), 1999)
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 1000
                LOOP
            ELSE
                THIS.this_cMensagem = THIS.this_cBuffer
                loc_cBuf            = REPLICATE(CHR(0), 2000)
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 0
            ENDIF
        ENDDO

        IF !loc_lFalhou AND loc_nRetorno = 0
            THIS.MontaRetorno(loc_cCupom)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtSenhaWhen - Permite foco em SENHA apenas quando vazio
    * Equivale ao SENHA.When: Return(EMPTY(This.Value)) do legado
    *--------------------------------------------------------------------------
    PROCEDURE TxtSenhaWhen()
        RETURN EMPTY(THIS.cnt_4c_Area.txt_4c_Senha.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtSenhaGotFocus - Prepara loop SiTef para entrada de senha supervisor
    * Equivale ao SENHA.GotFocus do legado (42 linhas)
    *--------------------------------------------------------------------------
    PROCEDURE TxtSenhaGotFocus()
        THIS.cnt_4c_Area.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = ;
            "Digite a Senha" + CHR(13) + "do Supervisor"

        THIS.this_nProximoComando  = 0
        THIS.this_nTipoCampo       = 0
        THIS.this_nTamanhoMinimo   = 0
        THIS.this_nTamanhoMaximo   = 0
        THIS.this_cBuffer          = REPLICATE(CHR(0), 2000)
        THIS.this_nContinua        = 0
        THIS.this_cMensagem        = ""
        THIS.ExecutarLoopContinua(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtSenhaLostFocus - Envia senha do supervisor, monta cupom em caso de sucesso
    * Equivale ao SENHA.LostFocus do legado (65 linhas)
    * Trata TipoCampo 515(data)/516(NSU), 121/122(cupom), VIA A SER REIMPRESSA
    *--------------------------------------------------------------------------
    PROCEDURE TxtSenhaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_nRetorno, loc_cBuf, loc_cCupom, loc_llVias, loc_lFalhou
        LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax

        IF EMPTY(THIS.cnt_4c_Area.txt_4c_Senha.Value)
            RETURN
        ENDIF

        loc_cBuf = ALLTRIM(THIS.cnt_4c_Area.txt_4c_Senha.Value)
        loc_cBuf = loc_cBuf + REPLICATE(CHR(0), 2000 - LEN(loc_cBuf))
        THIS.this_cBuffer   = loc_cBuf
        THIS.this_nContinua = 1000
        THIS.this_cMensagem = ""
        loc_cCupom          = ""
        loc_llVias          = .F.
        loc_lFalhou         = .F.

        loc_nCmd  = THIS.this_nProximoComando
        loc_nTipo = THIS.this_nTipoCampo
        loc_nMin  = THIS.this_nTamanhoMinimo
        loc_nMax  = THIS.this_nTamanhoMaximo
        loc_cBuf  = THIS.this_cBuffer

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nCmd, @loc_nTipo, @loc_nMin, ;
            @loc_nMax, @loc_cBuf, LEN(loc_cBuf), THIS.this_nContinua)

        THIS.this_nProximoComando = loc_nCmd
        THIS.this_nTipoCampo      = loc_nTipo
        THIS.this_nTamanhoMinimo  = loc_nMin
        THIS.this_nTamanhoMaximo  = loc_nMax
        THIS.this_cBuffer         = loc_cBuf
        THIS.this_nContinua       = 0

        DO WHILE loc_nRetorno = 10000
            loc_nCmd  = THIS.this_nProximoComando
            loc_nTipo = THIS.this_nTipoCampo
            loc_nMin  = THIS.this_nTamanhoMinimo
            loc_nMax  = THIS.this_nTamanhoMaximo
            loc_cBuf  = THIS.this_cBuffer

            loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nCmd, @loc_nTipo, @loc_nMin, ;
                @loc_nMax, @loc_cBuf, LEN(loc_cBuf), THIS.this_nContinua)

            THIS.this_nProximoComando = loc_nCmd
            THIS.this_nTipoCampo      = loc_nTipo
            THIS.this_nTamanhoMinimo  = loc_nMin
            THIS.this_nTamanhoMaximo  = loc_nMax
            THIS.this_cBuffer         = loc_cBuf

            IF loc_nRetorno < 0
                THIS.RetornoFalha(THIS.this_cMensagem)
                loc_lFalhou = .T.
                EXIT
            ENDIF

            IF UPPER(ALLTRIM(THIS.this_cBuffer)) = "DOC INEXISTENTE"
                THIS.RetornoFalha("DOC INEXISTENTE")
                loc_lFalhou = .T.
                EXIT
            ENDIF

            *-- TipoCampo 515: protocolo pede data da transacao original
            IF THIS.this_nProximoComando = 30 AND THIS.this_nTipoCampo = 515
                loc_cBuf = THIS.this_cDataLocal + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cDataLocal))
                THIS.this_cBuffer = loc_cBuf
                LOOP
            ENDIF

            *-- TipoCampo 516: protocolo pede NSU da transacao original
            IF THIS.this_nProximoComando = 30 AND THIS.this_nTipoCampo = 516
                IF !EMPTY(THIS.this_cValor)
                    loc_cBuf = TRANSFORM(VAL(THIS.this_cNSULocal), "@L 999999")
                ELSE
                    loc_cBuf = TRANSFORM(VAL(THIS.this_cNSULocal), "@L 999999999")
                ENDIF
                loc_cBuf = loc_cBuf + REPLICATE(CHR(0), 2000 - LEN(loc_cBuf))
                THIS.this_cBuffer = loc_cBuf
                LOOP
            ENDIF

            IF THIS.this_nTipoCampo = 121 AND EMPTY(loc_cCupom)
                loc_cCupom = THIS.this_cBuffer + THIS.this_cBuffer
            ENDIF
            IF THIS.this_nTipoCampo = 122
                loc_cCupom = loc_cCupom + THIS.this_cBuffer
            ENDIF

            *-- Protocolo indica reimpressao de via: responder com "3"
            IF loc_llVias
                loc_cBuf = "3" + REPLICATE(CHR(0), 1999)
                THIS.this_cBuffer = loc_cBuf
                loc_llVias        = .F.
                LOOP
            ENDIF

            IF UPPER(THIS.this_cBuffer) = "VIA A SER REIMPRESSA"
                loc_llVias = .T.
            ENDIF

            IF THIS.this_nProximoComando = 20
                loc_cBuf = "0" + REPLICATE(CHR(0), 1999)
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 1000
                LOOP
            ELSE
                THIS.this_cMensagem = THIS.this_cBuffer
                loc_cBuf            = REPLICATE(CHR(0), 2000)
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 0
            ENDIF
        ENDDO

        IF !loc_lFalhou AND loc_nRetorno = 0
            THIS.MontaRetorno(loc_cCupom)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarLoopContinua - Loop ContinuaFuncaoSiTefInterativo ate TipoCampo=500
    * Compartilhado por TxtGetSenhaGotFocus e TxtSenhaGotFocus
    * par_nTipo: 1=NSU formatado numerico, 2=NSU raw string
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarLoopContinua(par_nTipo)
        LOCAL loc_nRetorno, loc_nCmd, loc_nTipoLocal, loc_nMin, loc_nMax, loc_cBuf

        DO WHILE THIS.this_nTipoCampo <> 500
            loc_nCmd       = THIS.this_nProximoComando
            loc_nTipoLocal = THIS.this_nTipoCampo
            loc_nMin       = THIS.this_nTamanhoMinimo
            loc_nMax       = THIS.this_nTamanhoMaximo
            loc_cBuf       = THIS.this_cBuffer

            loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nCmd, @loc_nTipoLocal, @loc_nMin, ;
                @loc_nMax, @loc_cBuf, LEN(loc_cBuf), THIS.this_nContinua)

            THIS.this_nProximoComando = loc_nCmd
            THIS.this_nTipoCampo      = loc_nTipoLocal
            THIS.this_nTamanhoMinimo  = loc_nMin
            THIS.this_nTamanhoMaximo  = loc_nMax
            THIS.this_cBuffer         = loc_cBuf

            IF loc_nRetorno < 0
                THIS.RetornoFalha(THIS.this_cMensagem)
                EXIT
            ENDIF

            IF THIS.this_nProximoComando = 30 AND !EMPTY(THIS.this_cNSULocal)
                IF par_nTipo = 1
                    loc_cBuf = TRANSFORM(VAL(THIS.this_cNSULocal), "@L 999999999")
                    loc_cBuf = loc_cBuf + REPLICATE(CHR(0), 2000 - LEN(loc_cBuf))
                ELSE
                    loc_cBuf = THIS.this_cNSULocal + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cNSULocal))
                ENDIF
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 0
            ENDIF

            IF THIS.this_nProximoComando = 28 AND !EMPTY(THIS.this_cDataLocal)
                loc_cBuf = THIS.this_cDataLocal + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cDataLocal))
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 0
            ENDIF

            IF THIS.this_nProximoComando = 39
                loc_cBuf = "0" + REPLICATE(CHR(0), 1999)
                THIS.this_cBuffer   = loc_cBuf
                THIS.this_nContinua = 0
            ENDIF
        ENDDO
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela operacao SiTef e fecha o form
    * Equivale ao SAIDA.Command1.Click do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia novo ciclo de reimpressao (equivalente F2/Novo)
    * Zera estado do protocolo SiTef, limpa campos e reinicia sessao com o
    * servidor. Usado para consultar um novo cupom sem fechar o dialogo.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            THIS.this_nProximoComando = 0
            THIS.this_nTipoCampo      = 0
            THIS.this_nTamanhoMinimo  = 0
            THIS.this_nTamanhoMaximo  = 0
            THIS.this_cBuffer         = REPLICATE(CHR(0), 2000)
            THIS.this_nContinua       = 0
            THIS.this_cMensagem       = ""
            THIS.this_lIdent          = .F.

            THIS.cnt_4c_Area.txt_4c_GetSenha.Value = ""
            THIS.cnt_4c_Area.txt_4c_Senha.Value    = ""

            THIS.AlternarPagina(1)

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.IniciarProtocolo()
            ENDIF

            THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Reenvia senha do supervisor (equivalente F3/Editar)
    * Limpa apenas o campo de senha e retorna o foco para nova digitacao,
    * mantendo o estado do protocolo SiTef ate o comando 30/senha.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF EMPTY(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
                MsgAviso("Passe o cart" + CHR(227) + "o antes de reenviar a senha.", ;
                        "Reimpress" + CHR(227) + "o SiTef")
                THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
            ELSE
                THIS.cnt_4c_Area.txt_4c_Senha.Value = ""
                THIS.AlternarPagina(2)
                THIS.cnt_4c_Area.txt_4c_Senha.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Direciona o usuario para o inicio do fluxo de
    * reimpressao (equivalente F5/Visualizar). Foca o campo de leitura do
    * cartao e apresenta a instrucao "Insira ou Passe o Cartao".
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(1)
            THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Cancela a operacao SiTef em andamento (equivalente
    * F4/Excluir). Delega ao mesmo fluxo do botao Cancelar apos confirmacao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma, loc_oErro
        TRY
            loc_lConfirma = MsgConfirma("Cancelar a opera" + CHR(231) + CHR(227) + "o SiTef em andamento?", ;
                                       "Confirma" + CHR(231) + CHR(227) + "o")
            IF loc_lConfirma
                THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MontaRetorno - Finaliza com sucesso: popula crSiTef via BO e fecha form
    * Equivale ao PROCEDURE MontaRetorno() do legado
    *--------------------------------------------------------------------------
    PROCEDURE MontaRetorno(par_cCupom)
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.MontaRetorno(par_cCupom)
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna instrucoes entre modo cartao e modo senha supervisor
    * par_nModo: 1=Insira cartao, 2=Senha supervisor
    * (Equivale a alternancia de instrucoes no Container1 original)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nModo)
        LOCAL loc_oLabel
        loc_oLabel = THIS.cnt_4c_Area.cnt_4c_Instrucao.lbl_4c_Instrucao
        IF par_nModo = 2
            loc_oLabel.Caption = "Digite a Senha" + CHR(13) + "do Supervisor"
        ELSE
            loc_oLabel.Caption = "Insira ou Passe o Cart" + CHR(227) + "o"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Compatibilidade com pipeline (dialogo sem lista/grid)
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarPaginaLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Compatibilidade com pipeline (dialogo sem Page2 CRUD)
    * Toda a area interativa ja foi criada em ConfigurarAreaPrincipal (Fase 3/4)
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * RetornoFalha - Registra falha no protocolo e fecha o form
    * Equivale ao PROCEDURE RetornoFalha() do legado
    *--------------------------------------------------------------------------
    PROCEDURE RetornoFalha(par_cMensagem)
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.RetornoFalha(par_cMensagem)
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Compatibilidade com pipeline (dialogo sem lista de registros)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        *-- Dialogo SiTef nao tem lista de registros para carregar
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos controles pelo modo corrente
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.cnt_4c_Saida) = "O"
                IF PEMSTATUS(THIS.cnt_4c_Saida, "cmd_4c_Cancelar", 5)
                    THIS.cnt_4c_Saida.cmd_4c_Cancelar.Enabled = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de entrada do protocolo SiTef
    * par_lHabilitar: .T. = habilitar, .F. = desabilitar
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_oErro
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        TRY
            IF VARTYPE(THIS.cnt_4c_Area) = "O"
                IF PEMSTATUS(THIS.cnt_4c_Area, "txt_4c_GetSenha", 5)
                    THIS.cnt_4c_Area.txt_4c_GetSenha.Enabled = loc_lHabilitar
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Area, "txt_4c_Senha", 5)
                    THIS.cnt_4c_Area.txt_4c_Senha.Enabled = loc_lHabilitar
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa os campos de entrada do dialogo SiTef
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.cnt_4c_Area) = "O"
                IF PEMSTATUS(THIS.cnt_4c_Area, "txt_4c_GetSenha", 5)
                    THIS.cnt_4c_Area.txt_4c_GetSenha.Value = ""
                ENDIF
                IF PEMSTATUS(THIS.cnt_4c_Area, "txt_4c_Senha", 5)
                    THIS.cnt_4c_Area.txt_4c_Senha.Value = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Atualiza BO com estado corrente do form
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF
            WITH THIS.this_oBusinessObject
                .this_cEndSitef       = THIS.this_cEndSitef
                .this_cCaixa          = THIS.this_cCaixa
                .this_cNSU            = THIS.this_cNSU
                .this_cData           = THIS.this_cData
                .this_cValor          = THIS.this_cValor
                .this_cHora           = THIS.this_cHora
                .this_cCodEstabs      = THIS.this_cCodEstabs
                .this_nProximoComando = THIS.this_nProximoComando
                .this_nTipoCampo      = THIS.this_nTipoCampo
                .this_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
                .this_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
                .this_cBuffer         = THIS.this_cBuffer
                .this_nContinua       = THIS.this_nContinua
                .this_cMensagem       = THIS.this_cMensagem
                .this_lIdentificado   = THIS.this_lIdent
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza estado do form com dados do BO
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF
            THIS.this_nProximoComando = THIS.this_oBusinessObject.this_nProximoComando
            THIS.this_nTipoCampo      = THIS.this_oBusinessObject.this_nTipoCampo
            THIS.this_nTamanhoMinimo  = THIS.this_oBusinessObject.this_nTamanhoMinimo
            THIS.this_nTamanhoMaximo  = THIS.this_oBusinessObject.this_nTamanhoMaximo
            THIS.this_cBuffer         = THIS.this_oBusinessObject.this_cBuffer
            THIS.this_nContinua       = THIS.this_oBusinessObject.this_nContinua
            THIS.this_cMensagem       = THIS.this_oBusinessObject.this_cMensagem
            THIS.this_lIdent          = THIS.this_oBusinessObject.this_lIdentificado
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Reinicia o foco no campo de leitura do cartao
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            THIS.AlternarPagina(1)
            THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Cancela operacao e encerra o dialogo SiTef com confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_lConfirma, loc_oErro
        TRY
            loc_lConfirma = MsgConfirma("Encerrar a reimpress" + CHR(227) + "o SiTef?", ;
                                       "Confirma" + CHR(231) + CHR(227) + "o")
            IF loc_lConfirma
                THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o encerrada pelo usu" + CHR(225) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Processa o campo de entrada corrente e avanca o protocolo SiTef
    * Se SENHA preenchido: envia senha do supervisor para finalizacao
    * Se GetSenha preenchido: processa dado do cartao
    * Se vazio: foca no campo de leitura do cartao
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro
        TRY
            IF !EMPTY(THIS.cnt_4c_Area.txt_4c_Senha.Value)
                THIS.TxtSenhaLostFocus()
            ELSE
                IF !EMPTY(THIS.cnt_4c_Area.txt_4c_GetSenha.Value)
                THIS.TxtGetSenhaLostFocus()
            ELSE
                THIS.cnt_4c_Area.txt_4c_GetSenha.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
