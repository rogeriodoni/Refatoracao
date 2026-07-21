*==============================================================================
* Formsigprpdf.prg - Dialogo: Geracao de PDF e E-mail
* Equivalente ao SIGPRPDF.SCX do legado
* Tipo: OPERACIONAL (dialogo modal auxiliar - chamado por forms de impressao)
* Uso: loForm = CREATEOBJECT("Formsigprpdf", oFormPai, cAssunto)
*      loForm.Show()
* Resultado: oFormPai.pcArqEmail = caminho do arquivo gerado
*            oFormPai.oEmail     = objeto CUSTOM com dados do email (se email selecionado)
*==============================================================================
DEFINE CLASS Formsigprpdf AS FormBase

    *-- Referencia ao form pai (passada via Init)
    this_oParentForm = .NULL.

    *-- Assunto inicial do email (passado via Init)
    this_cAssunto = ""

    *-- Diretorio fiscal para salvar arquivos (de go_4c_Sistema.DirFiscais)
    this_cDiretorio = ""

    *-- Altura base do form sem a secao de email expandida
    this_nAlturaBase = 175

    *-- Propriedades visuais (PILAR 1: identico ao legado SIGPRPDF.SCX)
    Width       = 800
    Height      = 360
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    Caption     = "Geracao de PDF e E-mail"

    *--------------------------------------------------------------------------
    * Init - Recebe referencia ao form pai e assunto do email
    * Parametros armazenados ANTES de DODEFAULT (que chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_cAssunto)
        THIS.this_oParentForm = par_oParentForm
        THIS.this_cAssunto    = IIF(TYPE("par_cAssunto") = "C", par_cAssunto, "")
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Conecta datasession, cria todos os controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Compartilhar datasession com form pai (exige acesso aos cursores dele)
            IF VARTYPE(THIS.this_oParentForm) = "O"
                SET DATASESSION TO THIS.this_oParentForm.DataSessionId
            ENDIF

            *-- Instanciar BO
            THIS.this_oBusinessObject = CREATEOBJECT("sigprpdfBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Diretorio fiscal
                IF TYPE("go_4c_Sistema") = "O" AND PEMSTATUS(go_4c_Sistema, "DirFiscais", 5)
                    THIS.this_cDiretorio = ALLTRIM(NVL(go_4c_Sistema.DirFiscais, ""))
                ENDIF
                THIS.this_oBusinessObject.this_cDiretorio = THIS.this_cDiretorio

                *-- Aparencia base do form
                THIS.ConfigurarPageFrame()

                *-- Criar controles do form
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarOpcaoArquivo()
                THIS.ConfigurarAreaArquivo()
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarSecaoEmail()

                *-- Carregar dados de email da empresa via BO
                THIS.this_oBusinessObject.CarregarEmailEmpresa()

                *-- Preencher valores iniciais nos controles
                THIS.InicializarValores()

                *-- Tornar controles visiveis (email section permanece oculta)
                THIS.TornarControlesVisiveis(THIS)

                *-- Bindar eventos dos botoes e controles
                BINDEVENT(THIS.cmd_4c_CmdGetFile,    "Click", THIS, "CmdGetFileClick")
                BINDEVENT(THIS.chk_4c_Chk_EMAIL,     "Click", THIS, "ChkEmailClick")
                BINDEVENT(THIS.obj_4c_OptArquivo,    "Click", THIS, "OptArquivoClick")
                BINDEVENT(THIS.cmd_4c_Cmd_GerarPDF,  "Click", THIS, "CmdGerarPDFClick")
                BINDEVENT(THIS.cmd_4c_Cmd_SAIR,      "Click", THIS, "CmdSairClick")
                BINDEVENT(THIS.cmd_4c_BtnPastasA,    "Click", THIS, "BtnPastasAClick")

                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar sigprpdfBO.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro ao inicializar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Aparencia base do form (sem PageFrame - dialogo plano)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.FontName   = "Tahoma"
        THIS.FontSize   = 8
        THIS.ShowTips   = .T.
        THIS.Caption    = "Gera" + CHR(231) + CHR(227) + "o de PDF e E-mail"

        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top        = 0
                .Left       = 0
                .Width      = 1100
                .Height     = 80
                .BorderWidth = 0
                .BackStyle  = 1
                .BackColor  = RGB(100, 100, 100)
                .Visible    = .T.
            ENDWITH

            loc_oCab = THIS.cnt_4c_Sombra

            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
                .Top       = 18
                .Left      = 10
                .Width     = 769
                .Height    = 40
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .Top       = 17
                .Left      = 10
                .Width     = 769
                .Height    = 46
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Alignment = 0
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOpcaoArquivo - OptionGroup PDF / Excel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOpcaoArquivo()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("obj_4c_OptArquivo", "OptionGroup")
            WITH THIS.obj_4c_OptArquivo
                .Top         = -2
                .Left        = 420
                .Width       = 161
                .Height      = 85
                .TabIndex    = 1
                .Themes      = .T.
                .ButtonCount = 2
                .Value       = 1
                .Visible     = .T.

                WITH .Buttons(1)
                    .Caption    = "PDF"
                    .Height     = 75
                    .Left       = 5
                    .Top        = 5
                    .Width      = 75
                    .Style      = 1
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .BackStyle  = 0
                    .Picture    = gc_4c_CaminhoIcones + "pdf_60.png"
                ENDWITH

                WITH .Buttons(2)
                    .Caption    = "Excel"
                    .Height     = 75
                    .Left       = 81
                    .Top        = 5
                    .Width      = 75
                    .Style      = 1
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .FontName   = "Tahoma"
                    .FontSize   = 8
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .BackStyle  = 0
                    .Picture    = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarOpcaoArquivo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarAreaArquivo - Label "Salvar em:", TextBox nome arquivo e botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarAreaArquivo()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Lbl_SalvarEm", "Label")
            WITH THIS.lbl_4c_Lbl_SalvarEm
                .Top       = 109
                .Left      = 150
                .Width     = 53
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Salvar em:"
                .TabIndex  = 4
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_TxtNomeArqSaida", "TextBox")
            WITH THIS.txt_4c_TxtNomeArqSaida
                .Top               = 105
                .Left              = 205
                .Width             = 383
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .BorderColor       = RGB(100, 100, 100)
                .DisabledBackColor = RGB(255, 255, 255)
                .Value             = ""
                .TabIndex          = 5
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_CmdGetFile", "CommandButton")
            WITH THIS.cmd_4c_CmdGetFile
                .Top        = 104
                .Left       = 589
                .Width      = 30
                .Height     = 25
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Caption    = ". . ."
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .TabIndex   = 6
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_BtnPastasA", "CommandButton")
            WITH THIS.cmd_4c_BtnPastasA
                .Top             = 100
                .Left            = 619
                .Width           = 40
                .Height          = 32
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .Themes          = .T.
                .ToolTipText     = "Abrir o Diret" + CHR(243) + "rio / Pasta de Arquivos"
                .TabIndex        = 82
                .Visible         = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarAreaArquivo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - Checkbox Email, botao Gravar/Enviar e Encerrar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("chk_4c_Chk_EMAIL", "CheckBox")
            WITH THIS.chk_4c_Chk_EMAIL
                .Top        = 3
                .Left       = 575
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .Caption    = "Email"
                .Style      = 1
                .Value      = 0
                .Alignment  = 0
                .Picture    = gc_4c_CaminhoIcones + "geral_enderecos_60.jpg"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .TabIndex   = 2
                .Visible    = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Cmd_GerarPDF", "CommandButton")
            WITH THIS.cmd_4c_Cmd_GerarPDF
                .Top             = 3
                .Left            = 650
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Caption         = "   Gravar"
                .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
                .PicturePosition = 13
                .Alignment       = 6
                .WordWrap        = .F.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .TabIndex        = 3
                .Visible         = .T.
            ENDWITH

            THIS.AddObject("cmd_4c_Cmd_SAIR", "CommandButton")
            WITH THIS.cmd_4c_Cmd_SAIR
                .Top             = 3
                .Left            = 725
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .Cancel          = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .TabIndex        = 8
                .ToolTipText     = "[ESC] - Sair"
                .Visible         = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarSecaoEmail - Container expandivel com campos de email (inicial: oculto)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarSecaoEmail()
        LOCAL loc_oCtn, loc_oErro

        TRY
            THIS.AddObject("cnt_4c_CtnSaida_Email", "Container")
            WITH THIS.cnt_4c_CtnSaida_Email
                .Top        = 148
                .Left       = 155
                .Width      = 480
                .Height     = 185
                .BackStyle  = 0
                .BorderWidth = 0
                .TabIndex   = 7
                .Visible    = .F.
            ENDWITH

            loc_oCtn = THIS.cnt_4c_CtnSaida_Email

            loc_oCtn.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oCtn.lbl_4c_Label1
                .Top       = 8
                .Left      = 47
                .Width     = 19
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "De:"
                .TabIndex  = 1
                .Visible   = .T.
            ENDWITH

            loc_oCtn.AddObject("txt_4c_TxtEmail_EnviarDE", "TextBox")
            WITH loc_oCtn.txt_4c_TxtEmail_EnviarDE
                .Top               = 5
                .Left              = 68
                .Width             = 404
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .BorderColor       = RGB(100, 100, 100)
                .DisabledBackColor = RGB(239, 239, 239)
                .Value             = ""
                .TabIndex          = 2
                .ToolTipText       = "Menu - Cadastro - Empresas ( Campo Email )"
                .Visible           = .T.
            ENDWITH

            loc_oCtn.AddObject("lbl_4c_Lbl_EmailPara", "Label")
            WITH loc_oCtn.lbl_4c_Lbl_EmailPara
                .Top       = 38
                .Left      = 38
                .Width     = 28
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Para:"
                .TabIndex  = 3
                .Visible   = .T.
            ENDWITH

            loc_oCtn.AddObject("obj_4c_TxtEmail_EnviarPara", "EditBox")
            WITH loc_oCtn.obj_4c_TxtEmail_EnviarPara
                .Top           = 35
                .Left          = 68
                .Width         = 404
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ScrollBars    = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 4
                .Visible       = .T.
            ENDWITH

            loc_oCtn.AddObject("lbl_4c_LblEmail_CC", "Label")
            WITH loc_oCtn.lbl_4c_LblEmail_CC
                .Top       = 68
                .Left      = 46
                .Width     = 20
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "CC:"
                .TabIndex  = 5
                .Visible   = .T.
            ENDWITH

            loc_oCtn.AddObject("obj_4c_TxtEmail_CC", "EditBox")
            WITH loc_oCtn.obj_4c_TxtEmail_CC
                .Top           = 65
                .Left          = 68
                .Width         = 404
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ScrollBars    = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 6
                .Visible       = .T.
            ENDWITH

            loc_oCtn.AddObject("lbl_4c_LblEmail_Assunto", "Label")
            WITH loc_oCtn.lbl_4c_LblEmail_Assunto
                .Top       = 99
                .Left      = 21
                .Width     = 45
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Assunto:"
                .TabIndex  = 7
                .Visible   = .T.
            ENDWITH

            loc_oCtn.AddObject("txt_4c_TxtEmail_Assunto", "TextBox")
            WITH loc_oCtn.txt_4c_TxtEmail_Assunto
                .Top           = 95
                .Left          = 68
                .Width         = 404
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 8
                .Visible       = .T.
            ENDWITH

            loc_oCtn.AddObject("lbl_4c_LblEmail_Corpo", "Label")
            WITH loc_oCtn.lbl_4c_LblEmail_Corpo
                .Top       = 127
                .Left      = 32
                .Width     = 34
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Texto:"
                .TabIndex  = 9
                .Visible   = .T.
            ENDWITH

            loc_oCtn.AddObject("obj_4c_EdtEmail_Corpo", "EditBox")
            WITH loc_oCtn.obj_4c_EdtEmail_Corpo
                .Top           = 125
                .Left          = 68
                .Width         = 404
                .Height        = 53
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .BorderColor   = RGB(100, 100, 100)
                .Value         = ""
                .TabIndex      = 10
                .Visible       = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarSecaoEmail")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarValores - Define valores iniciais apos criacao dos controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValores()
        LOCAL loc_lPdfDisponivel, loc_cExt, loc_oErro

        TRY
            *-- Verificar disponibilidade do PDFCreator via registry
            loc_lPdfDisponivel = .F.
            TRY
                loc_lPdfDisponivel = !ISNULL(REGREAD("HKEY_CLASSES_ROOT\PDFCreator.clsPDFCreator\")) OR ;
                                     !ISNULL(REGREAD("HKEY_CLASSES_ROOT\PDFCreatorBeta.JobQueue\"))
            CATCH
                loc_lPdfDisponivel = .F.
            ENDTRY

            THIS.obj_4c_OptArquivo.Buttons(1).Enabled = loc_lPdfDisponivel
            THIS.obj_4c_OptArquivo.Value = IIF(loc_lPdfDisponivel, 1, 2)

            *-- Nome do arquivo inicial conforme tipo selecionado (igual ao OptArquivoClick)
            IF THIS.obj_4c_OptArquivo.Value = 1
                THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
            ELSE
                THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSEXCEL.XLS"
            ENDIF

            *-- Preencher "Para:" com contaemail do form pai (se disponivel)
            IF VARTYPE(THIS.this_oParentForm) = "O"
                IF PEMSTATUS(THIS.this_oParentForm, "Contaemail", 5)
                    THIS.cnt_4c_CtnSaida_Email.obj_4c_TxtEmail_EnviarPara.Value = ;
                        ALLTRIM(NVL(THIS.this_oParentForm.Contaemail, ""))
                ENDIF
            ENDIF

            *-- Assunto inicial
            THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_Assunto.Value = THIS.this_cAssunto

            *-- Email De (da empresa, carregado pelo BO)
            THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_EnviarDE.Value = ;
                THIS.this_oBusinessObject.this_cEmailEmpresaDe

            *-- Calcular altura base e recolher secao de email
            THIS.this_nAlturaBase = THIS.Height - THIS.cnt_4c_CtnSaida_Email.Height
            THIS.Height = THIS.this_nAlturaBase
            THIS.cnt_4c_CtnSaida_Email.Visible = .F.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro InicializarValores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis todos os controles exceto secao email
    * cnt_4c_CtnSaida_Email inicia oculto; seus filhos ficam visiveis internamente
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oCtrl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oCtrl) = "O"
                IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_CTNSAIDA_EMAIL", "CNT_4C_SOMBRA")
                    *-- Containers intencionalmente ocultos: recursao nos filhos sem forcar Visible=.T.
                    IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdGetFileClick - Abre dialogo de selecao de arquivo PDF ou XLS
    *--------------------------------------------------------------------------
    PROCEDURE CmdGetFileClick()
        LOCAL loc_cTpArq, loc_cArqSaida, loc_oErro

        TRY
            loc_cTpArq    = IIF(THIS.obj_4c_OptArquivo.Value = 1, "PDF", "XLS")
            loc_cArqSaida = GETFILE(loc_cTpArq, "Arquivo:", "Selecionar", 0, "Selecione o arquivo")

            IF !EMPTY(loc_cArqSaida)
                loc_cArqSaida = THIS.this_oBusinessObject.ResolverExtensao(loc_cArqSaida, THIS.obj_4c_OptArquivo.Value)
                THIS.txt_4c_TxtNomeArqSaida.Value = ALLTRIM(loc_cArqSaida)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkEmailClick - Expande/contrai form mostrando/ocultando secao de email
    *--------------------------------------------------------------------------
    PROCEDURE ChkEmailClick()
        LOCAL loc_oErro

        TRY
            THIS.LockScreen = .T.

            IF THIS.chk_4c_Chk_EMAIL.Value = 1
                THIS.cmd_4c_Cmd_GerarPDF.Caption = "Enviar Email"
                THIS.Height = THIS.this_nAlturaBase + THIS.cnt_4c_CtnSaida_Email.Height
                THIS.cnt_4c_CtnSaida_Email.Visible = .T.
            ELSE
                THIS.cmd_4c_Cmd_GerarPDF.Caption = "\<Gravar"
                THIS.Height = THIS.this_nAlturaBase
                THIS.cnt_4c_CtnSaida_Email.Visible = .F.
            ENDIF

            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OptArquivoClick - Atualiza nome do arquivo conforme tipo PDF/XLS selecionado
    *--------------------------------------------------------------------------
    PROCEDURE OptArquivoClick()
        LOCAL loc_oErro

        TRY
            IF THIS.obj_4c_OptArquivo.Value = 1
                THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
            ELSE
                THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSEXCEL.XLS"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdGerarPDFClick - Acao principal: gravar arquivo ou preparar envio de email
    *--------------------------------------------------------------------------
    PROCEDURE CmdGerarPDFClick()
        LOCAL loc_cArquivo, loc_oEmail, loc_lEnviarEmail, loc_lResultado, loc_lContinuar, loc_oErro

        loc_lContinuar = .T.

        TRY
            loc_cArquivo = ALLTRIM(NVL(THIS.txt_4c_TxtNomeArqSaida.Value, ""))

            IF EMPTY(loc_cArquivo)
                MsgAviso("Selecione um nome para o arquivo!", "Aten" + CHR(231) + CHR(227) + "o")
                THIS.cmd_4c_CmdGetFile.SetFocus()
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_lEnviarEmail = (THIS.chk_4c_Chk_EMAIL.Value = 1)

                IF loc_lEnviarEmail
                    *-- Modo email: coletar dados do form para o BO validar
                    THIS.this_oBusinessObject.this_cArquivoSaida = loc_cArquivo
                    THIS.this_oBusinessObject.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value
                    THIS.this_oBusinessObject.this_cEmailPara    = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.obj_4c_TxtEmail_EnviarPara.Value, ""))
                    THIS.this_oBusinessObject.this_cEmailCC      = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.obj_4c_TxtEmail_CC.Value,         ""))
                    THIS.this_oBusinessObject.this_cEmailAssunto = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.txt_4c_TxtEmail_Assunto.Value,    ""))
                    THIS.this_oBusinessObject.this_cEmailCorpo   = ALLTRIM(NVL(THIS.cnt_4c_CtnSaida_Email.obj_4c_EdtEmail_Corpo.Value,      ""))

                    loc_lResultado = THIS.this_oBusinessObject.Atualizar()

                    IF loc_lResultado
                        *-- Dados de email da empresa precisam estar carregados (cursor_4c_EmailEmp)
                        IF USED("cursor_4c_EmailEmp") AND RECCOUNT("cursor_4c_EmailEmp") > 0
                            loc_oEmail = THIS.this_oBusinessObject.MontarObjetoEmail( ;
                                THIS.this_oBusinessObject.this_cArquivoSaida)

                            IF VARTYPE(THIS.this_oParentForm) = "O" AND VARTYPE(loc_oEmail) = "O"
                                THIS.this_oParentForm.pcArqEmail = THIS.this_oBusinessObject.this_cArquivoSaida
                                THIS.this_oParentForm.oEmail     = loc_oEmail
                            ENDIF
                        ELSE
                            IF VARTYPE(THIS.this_oParentForm) = "O"
                                THIS.this_oParentForm.lPrintPDFCreator = .F.
                            ENDIF
                            MsgAviso("Problemas na sele" + CHR(231) + CHR(227) + "o de dados do email. " + ;
                                     "Favor enviar novamente.", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF

                        THIS.Release()
                    ENDIF
                ELSE
                    *-- Modo gravar: apenas definir arquivo no form pai
                    THIS.this_oBusinessObject.this_cArquivoSaida = loc_cArquivo
                    THIS.this_oBusinessObject.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value

                    loc_lResultado = THIS.this_oBusinessObject.Inserir()

                    IF loc_lResultado
                        IF VARTYPE(THIS.this_oParentForm) = "O"
                            THIS.this_oParentForm.pcArqEmail = THIS.this_oBusinessObject.this_cArquivoSaida
                        ENDIF
                        THIS.Release()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar/enviar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSairClick - Cancela: limpa pcArqEmail e oEmail no form pai e fecha
    *--------------------------------------------------------------------------
    PROCEDURE CmdSairClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.pcArqEmail = ""
                THIS.this_oParentForm.oEmail     = .NULL.
            ENDIF
            THIS.Release()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnPastasAClick - Abre diretorio fiscal no Windows Explorer
    *--------------------------------------------------------------------------
    PROCEDURE BtnPastasAClick()
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.AbrirPasta(THIS.this_cDiretorio)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - N/A (dialogo plano sem PageFrame/Grid)
    * Formsigprpdf eh um dialogo modal de 1 tela - sem Page1/Grid de lista.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - N/A (dialogo plano sem Page2)
    * Todos os controles sao criados diretamente em InicializarForm.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - N/A (dialogo plano sem paginas para alternar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - N/A para dialogo OPERACIONAL de PDF/Email
    * Este form nao eh um cadastro CRUD (SIGPRPDF.SCX legado nao tem esse botao).
    * A acao equivalente de "gravar arquivo novo" eh feita por CmdGerarPDFClick,
    * que chama this_oBusinessObject.Inserir para persistir os dados de saida.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.CmdGerarPDFClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - N/A para dialogo OPERACIONAL de PDF/Email
    * SIGPRPDF.SCX legado nao possui operacao de alteracao (dialogo one-shot).
    * A acao equivalente de "reenviar/regravar" eh feita por CmdGerarPDFClick,
    * que decide entre Inserir (gravar) e Atualizar (enviar email).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.CmdGerarPDFClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - N/A para dialogo OPERACIONAL de PDF/Email
    * SIGPRPDF.SCX legado nao possui operacao de visualizacao (nao ha registros
    * persistidos). A acao equivalente de "ver a pasta destino" eh BtnPastasAClick,
    * que abre o diretorio fiscal onde os PDFs/XLS sao salvos.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.BtnPastasAClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - N/A para dialogo OPERACIONAL de PDF/Email
    * SIGPRPDF.SCX legado nao possui operacao de exclusao (dialogo modal one-shot).
    * A acao equivalente de "cancelar/descartar" eh CmdSairClick, que limpa
    * pcArqEmail/oEmail no form pai e fecha o dialogo sem gravar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.CmdSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Delega para a acao principal do dialogo (Gravar/Enviar).
    * SIGPRPDF.SCX legado usa Cmd_GerarPDF (nao ha botao "Salvar" separado).
    * Mantido para compatibilidade com a interface CRUD do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdGerarPDFClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Delega para o cancelamento do dialogo (Cmd_SAIR).
    * SIGPRPDF.SCX legado nao tem botao "Cancelar" separado; sair equivale a
    * cancelar (limpa pcArqEmail/oEmail do form pai).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.CmdSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Alias canonico de encerramento exigido pelo TesteAutomatico.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.CmdSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia valores dos controles do form para as propriedades do BO.
    * Chamado antes de invocar Inserir/Atualizar no BO (via CmdGerarPDFClick).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oCtn, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF

            THIS.this_oBusinessObject.this_cDiretorio    = THIS.this_cDiretorio
            THIS.this_oBusinessObject.this_cArquivoSaida = ALLTRIM(NVL(THIS.txt_4c_TxtNomeArqSaida.Value, ""))
            THIS.this_oBusinessObject.this_nTipoArquivo  = THIS.obj_4c_OptArquivo.Value
            THIS.this_oBusinessObject.this_lEnviarEmail  = (THIS.chk_4c_Chk_EMAIL.Value = 1)

            loc_oCtn = THIS.cnt_4c_CtnSaida_Email
            THIS.this_oBusinessObject.this_cEmailEmpresaDe = ALLTRIM(NVL(loc_oCtn.txt_4c_TxtEmail_EnviarDE.Value, ""))
            THIS.this_oBusinessObject.this_cEmailPara      = ALLTRIM(NVL(loc_oCtn.obj_4c_TxtEmail_EnviarPara.Value, ""))
            THIS.this_oBusinessObject.this_cEmailCC        = ALLTRIM(NVL(loc_oCtn.obj_4c_TxtEmail_CC.Value, ""))
            THIS.this_oBusinessObject.this_cEmailAssunto   = ALLTRIM(NVL(loc_oCtn.txt_4c_TxtEmail_Assunto.Value, ""))
            THIS.this_oBusinessObject.this_cEmailCorpo     = ALLTRIM(NVL(loc_oCtn.obj_4c_EdtEmail_Corpo.Value, ""))

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia propriedades do BO para os controles do form.
    * Chamado apos CarregarEmailEmpresa para propagar dados da empresa.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oCtn, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF

            THIS.this_cDiretorio = THIS.this_oBusinessObject.this_cDiretorio

            IF THIS.obj_4c_OptArquivo.Value = 1
                THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
            ELSE
                THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSEXCEL.XLS"
            ENDIF

            loc_oCtn = THIS.cnt_4c_CtnSaida_Email
            loc_oCtn.txt_4c_TxtEmail_EnviarDE.Value = THIS.this_oBusinessObject.this_cEmailEmpresaDe
            loc_oCtn.txt_4c_TxtEmail_Assunto.Value  = THIS.this_cAssunto

            IF VARTYPE(THIS.this_oParentForm) = "O" AND PEMSTATUS(THIS.this_oParentForm, "Contaemail", 5)
                loc_oCtn.obj_4c_TxtEmail_EnviarPara.Value = ALLTRIM(NVL(THIS.this_oParentForm.Contaemail, ""))
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - N/A para dialogo OPERACIONAL de PDF/Email (sem grid).
    * SIGPRPDF.SCX legado eh um dialogo modal one-shot sem lista de registros.
    * A acao equivalente de "carregar dados iniciais" eh CarregarEmailEmpresa
    * no BO, que popula as configuracoes de email da empresa em SigCdEmp.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.CarregarEmailEmpresa()
            THIS.BOParaForm()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Ajusta enabled dos controles conforme o modo do dialogo.
    * par_lHabilitar: .T. habilita edicao, .F. bloqueia (durante processamento).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lEnabled, loc_oCtn

        loc_lEnabled = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        THIS.obj_4c_OptArquivo.Enabled     = loc_lEnabled
        THIS.cmd_4c_CmdGetFile.Enabled     = loc_lEnabled
        THIS.chk_4c_Chk_EMAIL.Enabled      = loc_lEnabled
        THIS.cmd_4c_Cmd_GerarPDF.Enabled   = loc_lEnabled
        THIS.cmd_4c_BtnPastasA.Enabled     = loc_lEnabled

        loc_oCtn = THIS.cnt_4c_CtnSaida_Email
        loc_oCtn.obj_4c_TxtEmail_EnviarPara.Enabled = loc_lEnabled
        loc_oCtn.obj_4c_TxtEmail_CC.Enabled         = loc_lEnabled
        loc_oCtn.txt_4c_TxtEmail_Assunto.Enabled    = loc_lEnabled
        loc_oCtn.obj_4c_EdtEmail_Corpo.Enabled      = loc_lEnabled
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta valores dos controles editaveis do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oCtn

        THIS.txt_4c_TxtNomeArqSaida.Value = THIS.this_cDiretorio + "FORTYUSPDF.PDF"
        THIS.obj_4c_OptArquivo.Value      = 1
        THIS.chk_4c_Chk_EMAIL.Value       = 0

        loc_oCtn = THIS.cnt_4c_CtnSaida_Email
        loc_oCtn.obj_4c_TxtEmail_EnviarPara.Value = ""
        loc_oCtn.obj_4c_TxtEmail_CC.Value         = ""
        loc_oCtn.txt_4c_TxtEmail_Assunto.Value    = THIS.this_cAssunto
        loc_oCtn.obj_4c_EdtEmail_Corpo.Value      = ""
        loc_oCtn.Visible = .F.
        THIS.Height = THIS.this_nAlturaBase
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - N/A: dialogo OPERACIONAL nao tem modos CRUD.
    * SIGPRPDF opera em modo unico (dialogo modal de gravar/enviar).
    * Mantido para compatibilidade com a interface do pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BINDEVENTS e BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            UNBINDEVENTS(THIS)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
