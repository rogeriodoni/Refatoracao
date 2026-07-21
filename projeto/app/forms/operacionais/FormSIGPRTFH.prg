*==============================================================================
* FormSIGPRTFH.prg - Form Consulta de Cheque SiTef
* Legado: SIGPRTFH.SCX (classe SIGPRIFF)
* Tipo: OPERACIONAL - Dialogo de integracao SiTef via CliSiTef32I.DLL
* Chamada: DO FORM FormSIGPRTFH WITH params
*==============================================================================

DEFINE CLASS FormSIGPRTFH AS FormBase

    *-- Dimensoes originais (dialog pequeno, nao o padrao 1000x600)
    Height          = 350
    Width           = 467
    AutoCenter      = .T.
    BorderStyle     = 2
    Caption         = "SiTef - Consulta de Cheque"
    ShowWindow = 1
    ControlBox      = .F.
    Closable        = .T.
    MaxButton       = .F.
    MinButton       = .F.
    ClipControls    = .T.
    TitleBar        = 0
    WindowType      = 1
    WindowState     = 0
    FontName        = "Tahoma"
    FontSize        = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Valor de retorno da consulta SiTef
    this_cRetValores     = ""

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
    LPARAMETERS par_cIP, par_nInicio, par_nValor, par_cCupom, par_cCaixa, ;
                par_nIdent, par_cPos, par_nParcelas, par_cFuncoes, ;
                par_cBanco, par_cAgencia, par_cConta, par_cNumeroCheque, ;
                par_cDtCheque, par_cCPF, par_cTipoPessoa, par_cCupomNV, ;
                par_cAgenciaDV, par_cContaDV, par_cChequeDV, par_cPraca, ;
                par_cPesquisa, par_cCMC7, par_cTeste

        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRTFHBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar SIGPRTFHBO.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Repassa todos os parametros da transacao ao BO
            THIS.this_oBusinessObject.CarregarParametros( ;
                IIF(VARTYPE(par_cIP)          = "C", par_cIP,          ""), ;
                IIF(VARTYPE(par_nInicio)       = "N", par_nInicio,       0), ;
                IIF(VARTYPE(par_nValor)        = "N", par_nValor,        0), ;
                IIF(VARTYPE(par_cCupom)        = "C", par_cCupom,        ""), ;
                IIF(VARTYPE(par_cCaixa)        = "C", par_cCaixa,        ""), ;
                IIF(VARTYPE(par_nIdent)        = "N", par_nIdent,        0), ;
                IIF(VARTYPE(par_cPos)          = "C", par_cPos,          ""), ;
                IIF(VARTYPE(par_nParcelas)     = "N", par_nParcelas,     0), ;
                IIF(VARTYPE(par_cFuncoes)      = "C", par_cFuncoes,      ""), ;
                IIF(VARTYPE(par_cBanco)        = "C", par_cBanco,        ""), ;
                IIF(VARTYPE(par_cAgencia)      = "C", par_cAgencia,      ""), ;
                IIF(VARTYPE(par_cConta)        = "C", par_cConta,        ""), ;
                IIF(VARTYPE(par_cNumeroCheque) = "C", par_cNumeroCheque, ""), ;
                IIF(VARTYPE(par_cDtCheque)     = "C", par_cDtCheque,     ""), ;
                IIF(VARTYPE(par_cCPF)          = "C", par_cCPF,          ""), ;
                IIF(VARTYPE(par_cTipoPessoa)   = "C", par_cTipoPessoa,   "F"), ;
                IIF(VARTYPE(par_cCupomNV)      = "C", par_cCupomNV,      ""), ;
                IIF(VARTYPE(par_cAgenciaDV)    = "C", par_cAgenciaDV,    ""), ;
                IIF(VARTYPE(par_cContaDV)      = "C", par_cContaDV,      ""), ;
                IIF(VARTYPE(par_cChequeDV)     = "C", par_cChequeDV,     ""), ;
                IIF(VARTYPE(par_cPraca)        = "C", par_cPraca,        ""), ;
                IIF(VARTYPE(par_cPesquisa)     = "C", par_cPesquisa,     ""), ;
                IIF(VARTYPE(par_cCMC7)         = "C", par_cCMC7,         "") ;
            )

            loc_lSucesso = DODEFAULT()
            IF loc_lSucesso
                THIS.PopularCamposDoBO()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao inicializar FormSIGPRTFH")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        TRY
            THIS.ConfigurarPageFrame()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarBotaoCancela()
            THIS.ConfigurarCorpoForm()
            THIS.ConfigurarCamposForm()
            THIS.ConfigurarContainerStatus()
            THIS.TornarControlesVisiveis(THIS)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro InicializarForm SIGPRTFH")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame
    * Form OPERACIONAL (SiTef Consulta Cheque) usa layout customizado 467x350
    * sem PageFrame - controles diretos no Form. Este metodo cria o cabecalho
    * cinza superior (cnt_4c_Cabecalho + lbl_4c_Sombra + lbl_4c_Titulo) que eh
    * a estrutura visual base do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 1
            .Left        = 1
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top      = 18
            .Left     = 10
            .Width    = THIS.cnt_4c_Cabecalho.Width - 20
            .Height   = 40
            .AutoSize = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(0,0,0)
            .WordWrap  = .T.
            .Caption   = "SiTef - Consulta de Cheque"
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top      = 17
            .Left     = 10
            .Width    = THIS.cnt_4c_Cabecalho.Width - 20
            .Height   = 46
            .AutoSize = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255,255,255)
            .WordWrap  = .T.
            .Caption   = "SiTef - Consulta de Cheque"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotaoCancela
    * Botao CANCELA: unico controle focalizavel (todos os txt_ tem Enabled=.F.)
    * O GotFocus dispara automaticamente ao abrir o form e inicia o loop SiTef.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotaoCancela
        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top           = -1
            .Left          = 387
            .Width         = 75
            .Height        = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90,90,90)
            .BackColor     = RGB(255,255,255)
            .Picture       = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .Themes        = .T.
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .SpecialEffect = 0
            .PicturePosition = 13
            .WordWrap      = .T.
            .Cancel        = .T.
            .Caption       = "<Esc> \<Sair"
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Cancela, "GotFocus", THIS, "CmdCancelaGotFocus")
        BINDEVENT(THIS.cmd_4c_Cancela, "Click",    THIS, "CmdCancelaClick")
    ENDPROC

    *==========================================================================
    * ConfigurarCorpoForm
    * Painel visual (Shape2) que delimita a area de dados do cheque
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCorpoForm
        THIS.AddObject("shp_4c_Painel", "Shape")
        WITH THIS.shp_4c_Painel
            .Top           = 84
            .Left          = 0
            .Width         = 466
            .Height        = 202
            .SpecialEffect = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerStatus
    * Container1 do legado: exibe mensagens de status durante a consulta SiTef
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerStatus
        THIS.AddObject("cnt_4c_Status", "Container")
        WITH THIS.cnt_4c_Status
            .Top           = 288
            .Left          = 37
            .Width         = 393
            .Height        = 58
            .SpecialEffect = 0
            .BackStyle     = 1
            .BackColor     = RGB(255,255,255)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Status.AddObject("lbl_4c_Status1", "Label")
        WITH THIS.cnt_4c_Status.lbl_4c_Status1
            .Top       = 8
            .Left      = 4
            .Width     = 383
            .Height    = 43
            .AutoSize  = .F.
            .Alignment = 2
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "Aguarde Consulta de Cheque"
        ENDWITH

        THIS.cnt_4c_Status.AddObject("lbl_4c_Status2", "Label")
        WITH THIS.cnt_4c_Status.lbl_4c_Status2
            .Top       = 3
            .Left      = 4
            .Width     = 383
            .Height    = 20
            .AutoSize  = .F.
            .Alignment = 2
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "Aguarde Consulta de Cheque"
        ENDWITH

        THIS.cnt_4c_Status.AddObject("lbl_4c_Status3", "Label")
        WITH THIS.cnt_4c_Status.lbl_4c_Status3
            .Top       = 21
            .Left      = 4
            .Width     = 383
            .Height    = 19
            .AutoSize  = .F.
            .Alignment = 2
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "Aguarde Consulta de Cheque"
        ENDWITH

        THIS.cnt_4c_Status.AddObject("lbl_4c_Status4", "Label")
        WITH THIS.cnt_4c_Status.lbl_4c_Status4
            .Top       = 39
            .Left      = 4
            .Width     = 383
            .Height    = 19
            .AutoSize  = .F.
            .Alignment = 2
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = ""
        ENDWITH
    ENDPROC

    *==========================================================================
    * CmdCancelaGotFocus
    * Disparado automaticamente ao abrir o form (todos os txt_ tem Enabled=.F.,
    * CANCELA eh o unico controle focalizavel). Executa a consulta SiTef.
    *==========================================================================
    PROCEDURE CmdCancelaGotFocus
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CarregarDLL()

                THIS.AtualizarStatus( ;
                    "Aguarde...", ;
                    "Consultando cheque no SiTef", ;
                    "", ;
                    "")

                loc_lSucesso = THIS.this_oBusinessObject.Inserir()

                THIS.ExibirResultadoConsulta(loc_lSucesso)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ConsultaSiTef")
        ENDTRY
        *-- Nao fecha o form aqui: usuario precisa ler o resultado antes de clicar Sair.
        *-- CmdCancelaClick (botao fisico / ESC) faz THIS.Release().
    ENDPROC

    *==========================================================================
    PROCEDURE CmdCancelaClick
    *==========================================================================
        IF LASTKEY() = 13
            RETURN
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lAbandona = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * AtualizarStatus - Atualiza as mensagens do container de status
    *==========================================================================
    PROCEDURE AtualizarStatus(par_cLinha1, par_cLinha2, par_cLinha3, par_cLinha4)
        IF VARTYPE(THIS.cnt_4c_Status) # "O"
            RETURN
        ENDIF
        WITH THIS.cnt_4c_Status
            .lbl_4c_Status2.Caption = IIF(VARTYPE(par_cLinha1) = "C", par_cLinha1, "")
            .lbl_4c_Status3.Caption = IIF(VARTYPE(par_cLinha2) = "C", par_cLinha2, "")
            .lbl_4c_Status4.Caption = IIF(VARTYPE(par_cLinha3) = "C", par_cLinha3, "")
            .Visible     = .T.
        ENDWITH
        THIS.cnt_4c_Status.Refresh()
    ENDPROC

    *==========================================================================
    * ConfigurarCamposForm
    * Adiciona labels e textboxes de exibicao dos dados do cheque consultado.
    * Todos os TextBox sao Enabled=.F. (somente leitura; dados vem via parametro).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposForm
        *-- Praca de Compensacao
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 97
            .Left      = 64
            .Width     = 132
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "Praca de Compesacao :"
        ENDWITH

        THIS.AddObject("txt_4c_Praca", "TextBox")
        WITH THIS.txt_4c_Praca
            .Top                = 94
            .Left               = 198
            .Width              = 32
            .Height             = 23
            .Alignment          = 3
            .FontBold           = .T.
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Enabled            = .F.
            .DisabledForeColor  = RGB(0,0,0)
            .Value              = ""
        ENDWITH

        *-- Banco
        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .Top       = 129
            .Left      = 154
            .Width     = 42
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "Banco :"
        ENDWITH

        THIS.AddObject("txt_4c_Banco", "TextBox")
        WITH THIS.txt_4c_Banco
            .Top                = 126
            .Left               = 198
            .Width              = 32
            .Height             = 23
            .Alignment          = 3
            .FontBold           = .T.
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Enabled            = .F.
            .DisabledForeColor  = RGB(0,0,0)
            .Value              = ""
        ENDWITH

        *-- Agencia + DV
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 161
            .Left      = 143
            .Width     = 53
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "Agencia :"
        ENDWITH

        THIS.AddObject("txt_4c_Agencia", "TextBox")
        WITH THIS.txt_4c_Agencia
            .Top       = 158
            .Left      = 198
            .Width     = 40
            .Height    = 23
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255,255,255)
            .Enabled   = .F.
            .Value     = ""
        ENDWITH

        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .Top       = 162
            .Left      = 288
            .Width     = 20
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "DV:"
        ENDWITH

        THIS.AddObject("txt_4c_DvAgencia", "TextBox")
        WITH THIS.txt_4c_DvAgencia
            .Top                = 158
            .Left               = 310
            .Width              = 19
            .Height             = 23
            .FontBold           = .T.
            .FontName           = "Tahoma"
            .FontSize           = 8
            .BackColor          = RGB(255,255,255)
            .DisabledForeColor  = RGB(64,0,64)
            .Enabled            = .F.
            .Value              = ""
        ENDWITH

        *-- Conta + DV
        THIS.AddObject("lbl_4c_Label7", "Label")
        WITH THIS.lbl_4c_Label7
            .Top       = 193
            .Left      = 155
            .Width     = 41
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "Conta :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Top      = 190
            .Left     = 198
            .Width    = 78
            .Height   = 23
            .FontBold = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Value    = ""
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 194
            .Left      = 288
            .Width     = 20
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "DV:"
        ENDWITH

        THIS.AddObject("txt_4c_DvConta", "TextBox")
        WITH THIS.txt_4c_DvConta
            .Top      = 190
            .Left     = 310
            .Width    = 19
            .Height   = 23
            .FontBold = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Enabled  = .F.
            .Value    = ""
        ENDWITH

        *-- Numero de Cheque + DV
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 225
            .Left      = 82
            .Width     = 114
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "Numero de Cheque :"
        ENDWITH

        THIS.AddObject("txt_4c_Cheque", "TextBox")
        WITH THIS.txt_4c_Cheque
            .Top                = 222
            .Left               = 198
            .Width              = 54
            .Height             = 23
            .FontBold           = .T.
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Enabled            = .F.
            .DisabledForeColor  = RGB(0,0,0)
            .Value              = ""
        ENDWITH

        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 226
            .Left      = 288
            .Width     = 20
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "DV:"
        ENDWITH

        THIS.AddObject("txt_4c_DvCheque", "TextBox")
        WITH THIS.txt_4c_DvCheque
            .Top                = 222
            .Left               = 310
            .Width              = 19
            .Height             = 23
            .FontBold           = .T.
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Enabled            = .F.
            .DisabledForeColor  = RGB(0,0,0)
            .Value              = ""
        ENDWITH

        *-- CPF / CGC do portador (caption ajustado dinamicamente em PopularCamposDoBO)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 257
            .Left      = 168
            .Width     = 28
            .Height    = 15
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Caption   = "CPF :"
        ENDWITH

        THIS.AddObject("txt_4c_Cpf", "TextBox")
        WITH THIS.txt_4c_Cpf
            .Top                = 254
            .Left               = 198
            .Width              = 132
            .Height             = 23
            .Alignment          = 3
            .FontBold           = .T.
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Enabled            = .F.
            .DisabledForeColor  = RGB(0,0,0)
            .Value              = ""
        ENDWITH
    ENDPROC

    *==========================================================================
    * PopularCamposDoBO - Preenche os campos de exibicao com dados do BO
    * Chamado apos InicializarForm (via DODEFAULT no Init)
    *==========================================================================
    PROCEDURE PopularCamposDoBO()
        LOCAL loc_oBo

        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN
        ENDIF
        loc_oBo = THIS.this_oBusinessObject

        IF VARTYPE(THIS.txt_4c_Praca) = "O"
            THIS.txt_4c_Praca.Value = loc_oBo.this_cPraca
        ENDIF
        IF VARTYPE(THIS.txt_4c_Banco) = "O"
            THIS.txt_4c_Banco.Value = loc_oBo.this_cBanco
        ENDIF
        IF VARTYPE(THIS.txt_4c_Agencia) = "O"
            THIS.txt_4c_Agencia.Value = loc_oBo.this_cAgencia
        ENDIF
        IF VARTYPE(THIS.txt_4c_DvAgencia) = "O"
            THIS.txt_4c_DvAgencia.Value = loc_oBo.this_cAgenciaDV
        ENDIF
        IF VARTYPE(THIS.txt_4c_Conta) = "O"
            THIS.txt_4c_Conta.Value = loc_oBo.this_cConta
        ENDIF
        IF VARTYPE(THIS.txt_4c_DvConta) = "O"
            THIS.txt_4c_DvConta.Value = loc_oBo.this_cContaDV
        ENDIF
        IF VARTYPE(THIS.txt_4c_Cheque) = "O"
            THIS.txt_4c_Cheque.Value = loc_oBo.this_cNumeroCheque
        ENDIF
        IF VARTYPE(THIS.txt_4c_DvCheque) = "O"
            THIS.txt_4c_DvCheque.Value = loc_oBo.this_cChequeDV
        ENDIF
        IF VARTYPE(THIS.txt_4c_Cpf) = "O"
            THIS.txt_4c_Cpf.Value = loc_oBo.this_cCPF
        ENDIF

        *-- Caption do label CPF vs CGC baseado no tipo de pessoa
        IF VARTYPE(THIS.lbl_4c_Label1) = "O"
            THIS.lbl_4c_Label1.Caption = IIF(loc_oBo.this_cTipoPessoa = "F", "CPF :", "CGC :")
        ENDIF

        *-- Labels de status 2/3/4 iniciam ocultos (aparecem apenas em resultado Serasa multi-linha)
        IF VARTYPE(THIS.cnt_4c_Status) = "O"
            WITH THIS.cnt_4c_Status
                .lbl_4c_Status2.Visible = .F.
                .lbl_4c_Status3.Visible = .F.
                .lbl_4c_Status4.Visible = .F.
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    * ExibirResultadoConsulta - Atualiza container de status com resultado SiTef
    * Detecta codigos Serasa e exibe descricao em 3 linhas (vermelho)
    * par_lSucesso - .T. se consulta completou com aprovacao
    *==========================================================================
    PROCEDURE ExibirResultadoConsulta(par_lSucesso)
        LOCAL loc_oBo, loc_cRetorno
        LOCAL loc_lnSrSearch, loc_lnSrIdx
        LOCAL loc_cLinha1, loc_cLinha2, loc_cLinha3

        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.cnt_4c_Status) # "O"
            RETURN
        ENDIF

        loc_oBo     = THIS.this_oBusinessObject
        loc_cRetorno = ALLTRIM(loc_oBo.this_cRetornoCheque)

        IF par_lSucesso
            THIS.this_cRetValores = loc_cRetorno
            WITH THIS.cnt_4c_Status
                .lbl_4c_Status1.Visible   = .T.
                .lbl_4c_Status1.ForeColor = RGB(0,120,0)
                .lbl_4c_Status1.FontSize  = 16
                .lbl_4c_Status1.Caption   = loc_cRetorno
                .lbl_4c_Status2.Visible   = .F.
                .lbl_4c_Status3.Visible   = .F.
                .lbl_4c_Status4.Visible   = .F.
            ENDWITH
        ELSE
            THIS.this_cRetValores = ""

            *-- Verificar se o retorno contem codigo Serasa (2 primeiros chars)
            loc_lnSrIdx = 0
            IF LEN(loc_cRetorno) >= 2
                FOR loc_lnSrSearch = 1 TO 8
                    IF loc_oBo.ObterCodigoSerasa(loc_lnSrSearch) = SUBSTR(loc_cRetorno, 1, 2)
                        loc_lnSrIdx = loc_lnSrSearch
                        EXIT
                    ENDIF
                NEXT
            ENDIF

            IF loc_lnSrIdx = 0
                *-- Erro simples: exibe mensagem em Status1 (vermelho)
                WITH THIS.cnt_4c_Status
                    .lbl_4c_Status1.Visible   = .T.
                    .lbl_4c_Status1.ForeColor = RGB(255,0,0)
                    .lbl_4c_Status1.Caption   = IIF(EMPTY(loc_cRetorno), ;
                        ALLTRIM(loc_oBo.this_cMensagemErro), loc_cRetorno)
                    .lbl_4c_Status2.Visible   = .F.
                    .lbl_4c_Status3.Visible   = .F.
                    .lbl_4c_Status4.Visible   = .F.
                ENDWITH
            ELSE
                *-- Resultado Serasa: oculta Status1, exibe 3 linhas em Status2/3/4
                loc_cLinha1 = loc_oBo.ObterRetornoSerasa(loc_lnSrIdx, 1)
                loc_cLinha2 = loc_oBo.ObterRetornoSerasa(loc_lnSrIdx, 2)
                loc_cLinha3 = loc_oBo.ObterRetornoSerasa(loc_lnSrIdx, 3)
                WITH THIS.cnt_4c_Status
                    .lbl_4c_Status1.Visible   = .F.
                    .lbl_4c_Status2.Visible   = .T.
                    .lbl_4c_Status3.Visible   = .T.
                    .lbl_4c_Status4.Visible   = .T.
                    .lbl_4c_Status2.ForeColor = RGB(255,0,0)
                    .lbl_4c_Status3.ForeColor = RGB(255,0,0)
                    .lbl_4c_Status4.ForeColor = RGB(255,0,0)
                    .lbl_4c_Status2.Caption   = loc_cLinha1
                    .lbl_4c_Status3.Caption   = loc_cLinha2
                    .lbl_4c_Status4.Caption   = loc_cLinha3
                ENDWITH
            ENDIF
        ENDIF

        THIS.cnt_4c_Status.Refresh()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - N/A (form OPERACIONAL de dialogo SiTef, sem PageFrame)
    * FormSIGPRTFH eh um dialogo modal 467x350 de consulta de cheque via CliSiTef32I.DLL,
    * sem Page1/Grid/Botoes CRUD. Todo o layout eh construido em InicializarForm() por
    * ConfigurarPageFrame (cabecalho), ConfigurarBotaoCancela, ConfigurarCorpoForm,
    * ConfigurarCamposForm e ConfigurarContainerStatus. Nao existe lista de registros.
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 4).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Sem-operacao: form nao possui PageFrame nem grid de lista.
        *-- Ver InicializarForm() e ConfigurarCamposForm() para o layout real.
        RETURN
    ENDPROC

    *==========================================================================
    * AlternarPagina - N/A (form OPERACIONAL de dialogo SiTef, sem PageFrame)
    * FormSIGPRTFH nao alterna entre paginas; sempre exibe o mesmo layout durante
    * a consulta SiTef (cabecalho + campos do cheque + container de status).
    * Metodo mantido apenas para conformidade com o contrato da pipeline (Fase 4).
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        *-- Sem-operacao: dialogo nao possui paginas para alternar.
        RETURN
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - N/A (form OPERACIONAL de dialogo SiTef, sem Page2)
    * FormSIGPRTFH e um dialogo modal 467x350 de consulta de cheque via
    * CliSiTef32I.DLL, sem PageFrame nem separacao Lista/Dados. Todos os campos
    * de exibicao (Praca, Banco, Agencia, Conta, Cheque, CPF + respectivos DVs)
    * sao construidos como controles diretos no form em ConfigurarCamposForm().
    * Metodo mantido para conformidade com o contrato da pipeline (Fase 5).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Sem-operacao: form nao possui Page2/Dados.
        *-- Ver ConfigurarCamposForm() para os campos de exibicao do cheque.
        RETURN
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - N/A (form de dialogo SiTef, sem operacao CRUD)
    * FormSIGPRTFH e um dialogo modal de consulta de cheque via CliSiTef32I.DLL.
    * Nao ha Incluir/Alterar/Visualizar/Excluir: a unica operacao e a consulta SiTef
    * disparada automaticamente pelo GotFocus do botao CANCELA ao abrir o form.
    * Metodo mantido para conformidade com o contrato da pipeline (Fase 7).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        *-- Sem-operacao: dialogo SiTef nao suporta inclusao de registros.
        *-- Ver CmdCancelaGotFocus() para o fluxo real de consulta.
        RETURN
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - N/A (form de dialogo SiTef, sem operacao CRUD)
    * Ver BtnIncluirClick acima para explicacao completa.
    * Metodo mantido para conformidade com o contrato da pipeline (Fase 7).
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        *-- Sem-operacao: dialogo SiTef nao suporta alteracao de registros.
        RETURN
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - N/A (form de dialogo SiTef, sem operacao CRUD)
    * Ver BtnIncluirClick acima para explicacao completa.
    * Metodo mantido para conformidade com o contrato da pipeline (Fase 7).
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        *-- Sem-operacao: dialogo SiTef nao suporta visualizacao de registros CRUD.
        *-- O resultado da consulta e exibido automaticamente em ExibirResultadoConsulta().
        RETURN
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - N/A (form de dialogo SiTef, sem operacao CRUD)
    * Ver BtnIncluirClick acima para explicacao completa.
    * Metodo mantido para conformidade com o contrato da pipeline (Fase 7).
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        *-- Sem-operacao: dialogo SiTef nao suporta exclusao de registros.
        RETURN
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o dialogo SiTef (equivale ao SAIDA.Click do legado)
    * Apenas LASTKEY()=13 (Enter) eh bloqueado para evitar fechamento inadvertido
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        IF LASTKEY() = 13
            RETURN
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lAbandona = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - N/A (dialogo SiTef sem busca de registros)
    * A unica acao do dialogo e a consulta SiTef executada automaticamente
    * pelo GotFocus do cmd_4c_Cancela ao abrir o form.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - N/A (dialogo SiTef sem persistencia em banco de dados)
    * O "salvar" equivalente e a gravacao dos arquivos IntPos.001/IntPos.STS
    * realizada internamente por SIGPRTFHBO.MontaRetorno / RetornoFalha.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Abandona a transacao SiTef e fecha o dialogo
    * Mesmo comportamento do cmd_4c_Cancela: sinaliza abandono ao BO e fecha.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lAbandona = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * CarregarLista - N/A (dialogo SiTef sem lista de registros)
    * Nao ha grid ou lista neste form. Os dados do cheque sao exibidos via
    * PopularCamposDoBO() apos a consulta SiTef.
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormParaBO - N/A (dialogo SiTef sem campos editaveis pelo usuario)
    * Os parametros da transacao sao passados diretamente via Init (lparameters)
    * e repassados ao BO via CarregarParametros() no prorio Init do form.
    * Nao ha campos de entrada que precisem ser sincronizados com o BO.
    *==========================================================================
    PROCEDURE FormParaBO()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula campos de exibicao com dados do BO
    * Delega a PopularCamposDoBO() que atualiza todos os TextBox de exibicao.
    *==========================================================================
    PROCEDURE BOParaForm()
        THIS.PopularCamposDoBO()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - N/A (todos os campos sao Enabled=.F. - somente leitura)
    * FormSIGPRTFH exibe dados do cheque sem permitir edicao pelo usuario.
    * Os campos sao preenchidos via parametros ao abrir o form.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa os campos de exibicao (reseta para estado inicial)
    * Usado internamente se for necessario reinicializar o dialogo.
    *==========================================================================
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.txt_4c_Praca) = "O"
            THIS.txt_4c_Praca.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_Banco) = "O"
            THIS.txt_4c_Banco.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_Agencia) = "O"
            THIS.txt_4c_Agencia.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_DvAgencia) = "O"
            THIS.txt_4c_DvAgencia.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_Conta) = "O"
            THIS.txt_4c_Conta.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_DvConta) = "O"
            THIS.txt_4c_DvConta.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_Cheque) = "O"
            THIS.txt_4c_Cheque.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_DvCheque) = "O"
            THIS.txt_4c_DvCheque.Value = ""
        ENDIF
        IF VARTYPE(THIS.txt_4c_Cpf) = "O"
            THIS.txt_4c_Cpf.Value = ""
        ENDIF
        IF VARTYPE(THIS.cnt_4c_Status) = "O"
            WITH THIS.cnt_4c_Status
                .lbl_4c_Status1.Caption = "Aguarde Consulta de Cheque"
                .lbl_4c_Status2.Caption = ""
                .lbl_4c_Status3.Caption = ""
                .lbl_4c_Status4.Caption = ""
                .Visible     = .T.
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - N/A (dialogo SiTef sem modos CRUD)
    * FormSIGPRTFH tem apenas um modo operacional: consulta de cheque.
    * O unico botao focalizavel (cmd_4c_Cancela) permanece habilitado o tempo todo.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                IF INLIST(LOWER(loc_oControl.Name), "cnt_4c_cabecalho")
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
            ENDIF
        NEXT
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
