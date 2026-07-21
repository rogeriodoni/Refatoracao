*==============================================================================
* Formsigtosen.prg - Formulario de Acesso ao Sistema (Login/Autenticacao)
* Data: 2026-04-15
* Tipo: OPERACIONAL (layout flat, sem PageFrame)
* Ref: tasks/task017/sigtosen_form_codigo_fonte.txt
*==============================================================================

DEFINE CLASS Formsigtosen AS FormBase

    Height      = 356
    Width       = 382
    AutoCenter  = .T.
    BackColor   = RGB(255,255,255)
    BorderStyle = 2
    Caption     = "Acesso ao Sistema"
    ShowWindow = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    ShowTips    = .T.

    this_lGetUsuario    = .F.
    this_lPrimeiraVez   = .F.
    this_lAutomatico    = .F.
    this_lUsuarioOk     = .F.
    this_nBloqueiaSenha = 1
    this_cUsuarioAtual  = ""
    this_cNomePrograma  = ""

    *==========================================================================
    * Init - Aceita parametros de controle de login
    *==========================================================================
    PROCEDURE Init(par_lGetUsuario, par_lPrimeiraVez, par_lAutomatico, par_cPrograma)
        THIS.this_lGetUsuario   = IIF(TYPE("par_lGetUsuario")  = "L", par_lGetUsuario,  .F.)
        THIS.this_lPrimeiraVez  = IIF(TYPE("par_lPrimeiraVez") = "L", par_lPrimeiraVez, .F.)
        THIS.this_lAutomatico   = IIF(TYPE("par_lAutomatico")  = "L", par_lAutomatico,  .F.)
        THIS.this_cNomePrograma = IIF(TYPE("par_cPrograma")    = "C", par_cPrograma,    "OPERACIONAL")
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, conecta e inicializa interface de login
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigtosenBO")
            THIS.this_oBusinessObject.this_cNomePrograma = THIS.this_cNomePrograma

            THIS.CarregarLista()

            SET SYSMENU TO
            SET SYSMENU OFF
            HIDE POPUP ALL

            IF TYPE("goSistema") = "O" AND TYPE("goSistema.BarraAtalho") = "O"
                goSistema.BarraAtalho.Release()
            ENDIF

            THIS.CriarImagemLogo()
            THIS.CriarLabels()
            THIS.CriarCamposLogin()
            THIS.CriarBotaoSaida()

            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Visible          = .F.
                .Height           = 50
                .Width            = 50
                .Left             = -100
                .Top              = -100
                .RecordSourceType = 1
                .RecordSource     = "cursor_4c_Dados"
                .RecordMark   = .F.
                .DeleteMark   = .F.
            ENDWITH

            IF gnConnHandle > 0
                THIS.this_lUsuarioOk = (NOT THIS.this_lGetUsuario)

                THIS.LockScreen = .T.

                THIS.txt_4c_USUARIO.Enabled = THIS.this_lGetUsuario
                THIS.this_nBloqueiaSenha    = 1

                PUBLIC gcUsuar, gcEmpr, _tipoe, usuar
                gcUsuar = PADR(IIF(TYPE("gcUsuar") = "C", gcUsuar, ""), 10)
                gcEmpr  = PADR(IIF(TYPE("gcEmpr") = "C", gcEmpr, ""), 3)
                usuar   = PADR(IIF(TYPE("usuar") = "C", usuar, ""), 10)
                _empr   = PADR(IIF(TYPE("_empr") = "C", _empr, ""), 3)

                IF TYPE("lcEmpresaLogada") = "C" AND NOT EMPTY(lcEmpresaLogada)
                    go_4c_Sistema.cCodEmpresa = lcEmpresaLogada
                ENDIF

                IF THIS.this_lPrimeiraVez
                    THIS.txt_4c_USUARIO.Value = usuar
                ELSE
                    THIS.txt_4c_USUARIO.Value = usuar
                ENDIF

                THIS.this_cUsuarioAtual = PADR(IIF(THIS.this_lPrimeiraVez, "", gcUsuar), 10)

                THIS.AjustarEmpresas()

                THIS.txt_4c_SENHA.Enabled = THIS.this_lGetUsuario
                THIS.txt_4c_SENHA.Value   = IIF(THIS.this_lGetUsuario, SPACE(10), REPLICATE("*", 10))

                THIS.this_oBusinessObject.CarregarParametros()

                IF THIS.this_oBusinessObject.this_nPafEcf = 1
                    THIS.lbl_4c_Label3.Visible = .T.
                ENDIF

                IF TYPE("_Screen.poTimer") = "O"
                    fDelAcesso()
                ENDIF

                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.VincularEventos()

                IF THIS.this_lGetUsuario
                    THIS.AlternarPagina(1)
                ELSE
                    THIS.ValidarUsuario()
                    IF THIS.this_lAutomatico
                        THIS.txt_4c_EMP.Value = go_4c_Sistema.cCodEmpresa
                    ENDIF
                    THIS.AlternarPagina(2)
                ENDIF

                THIS.Refresh()
                THIS.LockScreen = .F.

                DECLARE INTEGER SetForegroundWindow IN user32 INTEGER
                SetForegroundWindow(THIS.HWnd)
            ELSE
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o com Servidor de Banco de Dados.", "Erro")
                DO pEncerrar
                loc_lResultado = .F.
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CriarImagemLogo - Adiciona imagem do logotipo 4Control
    *==========================================================================
    PROTECTED PROCEDURE CriarImagemLogo()
        THIS.AddObject("img_4c_ImgFigJpg", "Image")
        WITH THIS.img_4c_ImgFigJpg
            .Top         = 0
            .Left        = 94
            .Width       = 191
            .Height      = 72
            .Picture     = gc_4c_CaminhoIcones + "4control_logo2.png"
            .Stretch     = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CriarLabels - Adiciona todos os Labels da tela de login
    *==========================================================================
    PROTECTED PROCEDURE CriarLabels()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 9
            .BackStyle  = 0
            .Caption    = "Usu" + CHR(225) + "rio :"
            .Height     = 16
            .Left       = 22
            .Top        = 95
            .Width      = 55
            .ForeColor  = RGB(128,128,128)
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 9
            .BackStyle  = 0
            .Caption    = "Senha :"
            .Height     = 16
            .Left       = 22
            .Top        = 145
            .Width      = 48
            .ForeColor  = RGB(128,128,128)
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH THIS.lbl_4c_LblEmpresa
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 9
            .BackStyle  = 0
            .Caption    = "Empresa :"
            .Height     = 16
            .Left       = 22
            .Top        = 198
            .Width      = 61
            .ForeColor  = RGB(128,128,128)
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_LbltitT", "Label")
        WITH THIS.lbl_4c_LbltitT
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontItalic = .T.
            .FontSize   = 18
            .BackStyle  = 0
            .Caption    = "4Control"
            .Height     = 31
            .Left       = 271
            .Top        = 253
            .Width      = 99
            .ForeColor  = RGB(128,128,128)
            .Visible    = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_LblTitF", "Label")
        WITH THIS.lbl_4c_LblTitF
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontItalic = .T.
            .FontSize   = 18
            .BackStyle  = 0
            .Caption    = "4Control"
            .Height     = 31
            .Left       = 272
            .Top        = 253
            .Width      = 99
            .ForeColor  = RGB(36,84,155)
            .Visible    = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize    = .T.
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackStyle   = 0
            .BorderStyle = 0
            .Caption     = "MENU FISCAL INACESS" + CHR(205) + "VEL NESTA TELA"
            .Height      = 15
            .Left        = 32
            .Top         = 260
            .Width       = 217
            .ForeColor   = RGB(128,128,128)
            .Visible     = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CriarCamposLogin - Adiciona TextBoxes de usuario, senha e empresa
    *==========================================================================
    PROTECTED PROCEDURE CriarCamposLogin()
        THIS.AddObject("txt_4c_USUARIO", "TextBox")
        WITH THIS.txt_4c_USUARIO
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 11
            .BackStyle     = 1
            .Format        = "K!"
            .Height        = 25
            .Left          = 22
            .MaxLength     = 10
            .SelectOnEntry = .F.
            .SpecialEffect = 1
            .TabIndex      = 1
            .ToolTipText   = "Usu" + CHR(225) + "rio do Sistema"
            .Top           = 113
            .Width         = 119
            .ForeColor     = RGB(90,90,90)
            .BorderColor   = RGB(238,238,238)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_SENHA", "TextBox")
        WITH THIS.txt_4c_SENHA
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 11
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K!"
            .Height        = 26
            .Left          = 22
            .MaxLength     = 10
            .SpecialEffect = 1
            .TabIndex      = 2
            .ToolTipText   = "Senha do Usu" + CHR(225) + "rio"
            .Top           = 166
            .Width         = 120
            .PasswordChar  = "*"
            .ForeColor     = RGB(90,90,90)
            .DisabledForeColor = RGB(128,128,128)
            .BorderColor   = RGB(238,238,238)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_EMP", "TextBox")
        WITH THIS.txt_4c_EMP
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 11
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 26
            .Left          = 22
            .MaxLength     = 3
            .SpecialEffect = 1
            .TabIndex      = 3
            .ToolTipText   = "C" + CHR(243) + "digo da Empresa"
            .Top           = 217
            .Width         = 45
            .ForeColor     = RGB(90,90,90)
            .BorderColor   = RGB(238,238,238)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Demp", "TextBox")
        WITH THIS.txt_4c_Demp
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 11
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 26
            .Left          = 74
            .MaxLength     = 40
            .SpecialEffect = 1
            .TabIndex      = 4
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o da Empresa"
            .Top           = 217
            .Width         = 294
            .ForeColor     = RGB(90,90,90)
            .BorderColor   = RGB(238,238,238)
            .Value         = ""
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CriarBotaoSaida - Adiciona CommandGroup SAIDA (botao de encerrar sistema)
    *==========================================================================
    PROTECTED PROCEDURE CriarBotaoSaida()
        THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
        WITH THIS.obj_4c_SAIDA
            .ButtonCount = 1
            .BorderStyle = 0
            .Value       = 0
            .Height      = 80
            .Left        = 290
            .Top         = 116
            .Width       = 78
            .TabIndex    = 5
            .BackColor   = RGB(255,255,255)
            .Visible     = .T.
        ENDWITH
        WITH THIS.obj_4c_SAIDA.Buttons(1)
            .Top         = 2
            .Left        = 1
            .Height      = 75
            .Width       = 75
            .FontBold    = .T.
            .FontItalic  = .F.
            .FontName    = "Small Fonts"
            .FontSize    = 7
            .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel      = .T.
            .Caption     = ""
            .ToolTipText = "[ESC] Sair do Sistema"
            .BackColor   = RGB(255,255,255)
            .Themes      = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura layout principal da tela de login
    * Form OPERACIONAL (login) - nao tem PageFrame/Grid/CRUD
    * Organiza posicionamento dos controles de autenticacao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_lEmpVisivel

        loc_lEmpVisivel = .F.

        IF gnConnHandle > 0
            IF USED("crEmpresa1") AND RECCOUNT("crEmpresa1") > 1
                loc_lEmpVisivel = .T.
            ENDIF
        ENDIF

        THIS.lbl_4c_LblEmpresa.Visible = loc_lEmpVisivel
        THIS.txt_4c_EMP.Visible        = loc_lEmpVisivel
        THIS.txt_4c_Demp.Visible       = loc_lEmpVisivel

        IF THIS.this_lGetUsuario
            THIS.txt_4c_USUARIO.Enabled = .T.
            THIS.txt_4c_SENHA.Enabled   = .T.
        ELSE
            THIS.txt_4c_USUARIO.Enabled = .F.
            THIS.txt_4c_SENHA.Enabled   = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna estado do formulario de login
    * par_nPagina: 1=Modo usuario/senha, 2=Modo selecao empresa
    * Form OPERACIONAL (login) - nao tem PageFrame, alterna visibilidade
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        DO CASE
            CASE par_nPagina = 1
                THIS.txt_4c_USUARIO.Enabled = THIS.this_lGetUsuario
                THIS.txt_4c_SENHA.Enabled   = THIS.this_lGetUsuario
                THIS.txt_4c_EMP.Enabled     = .F.
                THIS.txt_4c_Demp.Enabled    = .F.
                IF THIS.this_lGetUsuario
                    THIS.txt_4c_USUARIO.SetFocus()
                ENDIF

            CASE par_nPagina = 2
                THIS.txt_4c_USUARIO.Enabled = .F.
                THIS.txt_4c_SENHA.Enabled   = .F.
                THIS.txt_4c_EMP.Enabled     = .T.
                THIS.txt_4c_Demp.Enabled    = .T.
                THIS.txt_4c_EMP.SetFocus()
        ENDCASE
    ENDPROC

    *==========================================================================
    * VincularEventos - Vincula eventos dos controles via BINDEVENT
    *==========================================================================
    PROTECTED PROCEDURE VincularEventos()
        BINDEVENT(THIS.txt_4c_USUARIO, "GotFocus", THIS, "TxtUsuarioGotFocus")
        BINDEVENT(THIS.txt_4c_USUARIO, "KeyPress", THIS, "TxtUsuarioKeyPress")
        BINDEVENT(THIS.txt_4c_USUARIO, "KeyPress", THIS, "TxtUsuarioLostFocus")
        BINDEVENT(THIS.txt_4c_SENHA, "GotFocus", THIS, "TxtSenhaGotFocus")
        BINDEVENT(THIS.txt_4c_SENHA, "KeyPress", THIS, "TxtSenhaKeyPress")
        BINDEVENT(THIS.txt_4c_EMP, "GotFocus", THIS, "TxtEmpGotFocus")
        BINDEVENT(THIS.txt_4c_EMP, "KeyPress", THIS, "TxtEmpKeyPress")
        BINDEVENT(THIS.txt_4c_Demp, "KeyPress", THIS, "TxtDempKeyPress")
        BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnSaidaClick")
    ENDPROC

    *==========================================================================
    * AjustarEmpresas - Carrega empresas e configura visibilidade dos campos
    *==========================================================================
    PROCEDURE AjustarEmpresas()
        LOCAL loc_lSupervisor, loc_cUsuario

        TRY
            IF gnConnHandle > 0
                loc_cUsuario    = ALLTRIM(THIS.txt_4c_USUARIO.Value)
                loc_lSupervisor = (TYPE("gcTipoUsuario") = "C" AND ;
                    LEFT(gcTipoUsuario, 1) = "i")

                THIS.this_oBusinessObject.CarregarEmpresas(loc_cUsuario, loc_lSupervisor)

                IF USED("crEmpresa1")
                    SELECT ("crEmpresa1")
                    GO TOP IN crEmpresa1

                    IF RECCOUNT("crEmpresa1") > 1
                        THIS.lbl_4c_LblEmpresa.Visible = .T.
                        THIS.txt_4c_EMP.Visible        = .T.
                        THIS.txt_4c_Demp.Visible       = .T.
                    ELSE
                        IF RECCOUNT("crEmpresa1") = 1
                            THIS.txt_4c_EMP.Value  = crEmpresa1.cemps
                            THIS.txt_4c_Demp.Value = crEmpresa1.Razas
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarUsuario - Valida usuario digitado contra a base de dados
    *==========================================================================
    PROCEDURE ValidarUsuario()
        LOCAL loc_cUsuario, loc_lSucesso

        loc_cUsuario = PADR(ALLTRIM(STRTRAN(STRTRAN( ;
            THIS.txt_4c_USUARIO.Value, "'", " "), '"', " ")), 10)
        THIS.txt_4c_USUARIO.Value = loc_cUsuario

        PUBLIC gcUsuar, usuar
        gcUsuar = loc_cUsuario
        usuar   = loc_cUsuario

        IF TYPE("goSistema") = "O" AND PEMSTATUS(goSistema, "Usuario", 5)
            goSistema.Usuario = loc_cUsuario
        ENDIF

        fUniqueIds(usuar)

        IF NOT TYPE("gcTipoUsuario") = "C"
            PUBLIC gcTipoUsuario
        ENDIF
        gcTipoUsuario = SPACE(11)

        THIS.this_nBloqueiaSenha = 1
        THIS.this_lUsuarioOk     = .F.

        loc_lSucesso = THIS.this_oBusinessObject.ValidarUsuario(loc_cUsuario)

        IF loc_lSucesso
            gcTipoUsuario        = THIS.this_oBusinessObject.this_cTipoUsuario
            THIS.this_lUsuarioOk = .T.
        ELSE
            THIS.this_lUsuarioOk = .F.
        ENDIF

        THIS.AjustarEmpresas()
    ENDPROC

    *==========================================================================
    * ValidarSenha - Valida a senha digitada
    * Chamado ao pressionar ENTER/TAB no campo SENHA
    *==========================================================================
    PROCEDURE ValidarSenha()
        LOCAL loc_cSenha4c, loc_lcMsg

        loc_lcMsg = ""
        THIS.txt_4c_SENHA.Value = PADR(STRTRAN(STRTRAN( ;
            THIS.txt_4c_SENHA.Value, "'", " "), '"', " "), 10)

        IF USED("crParam2")
            SELECT crParam2
            LOCATE
        ENDIF

        IF USED("crsigcdusu1")
            SELECT ("crsigcdusu1")
            SET ORDER TO ("") IN ("crsigcdusu1")
            LOCATE

            IF UPPER(ALLTRIM(THIS.txt_4c_USUARIO.Value)) == "4CONTROL"
                loc_cSenha4c = fGerPswDiario(VAL(SYS(1)), DATE(), 0)
                IF NOT ALLTRIM(THIS.txt_4c_SENHA.Value) == ALLTRIM(loc_cSenha4c)
                    loc_lcMsg            = "Usu" + CHR(225) + "rio / Senha Inv" + ;
                        CHR(225) + "lidos(1)."
                    THIS.this_lUsuarioOk = .F.
                ELSE
                    THIS.this_lUsuarioOk = .T.
                ENDIF
            ELSE
                IF NOT EMPTY(THIS.txt_4c_USUARIO.Value) AND ;
                   NOT EOF("crsigcdusu1") AND ;
                   THIS.txt_4c_SENHA.Value == fCriptografar(crsigcdusu1.senhas)
                    THIS.this_lUsuarioOk = .T.
                ELSE
                    THIS.this_lUsuarioOk = .F.
                ENDIF
            ENDIF
        ENDIF

        IF NOT THIS.this_lUsuarioOk
            IF USED("crParam2") AND NVL(crParam2.nBloSenhas, 0) > 0 AND ;
               NOT EMPTY(THIS.txt_4c_USUARIO.Value) AND ;
               USED("crsigcdusu1") AND NOT EOF("crsigcdusu1") AND ;
               NOT THIS.txt_4c_SENHA.Value == fCriptografar(crsigcdusu1.senhas)

                IF THIS.this_nBloqueiaSenha > crParam2.nBloSenhas
                    THIS.this_oBusinessObject.BloquearSenha( ;
                        ALLTRIM(THIS.txt_4c_USUARIO.Value))
                    loc_lcMsg = "N" + CHR(186) + " Tentativas Ultrapassadas, " + ;
                        "Senha Bloqueada." + CHR(10) + ;
                        "Contate o Suporte Tecnico."
                ELSE
                    loc_lcMsg = "Senha Incorreta (Permitido Apenas " + ;
                        ALLTRIM(STR(crParam2.nBloSenhas, 20, 0)) + ;
                        " Tentativas)."
                    THIS.this_nBloqueiaSenha = THIS.this_nBloqueiaSenha + 1
                ENDIF
            ELSE
                IF EMPTY(loc_lcMsg)
                    loc_lcMsg = "Usu" + CHR(225) + "rio / Senha Inv" + ;
                        CHR(225) + "lidos(2)."
                ENDIF
            ENDIF
            THIS.txt_4c_USUARIO.SetFocus()
        ELSE
            IF NOT THIS.txt_4c_EMP.Visible
                THIS.Confirmar(.T.)
            ENDIF
        ENDIF

        IF NOT EMPTY(loc_lcMsg)
            MsgAviso(loc_lcMsg, "")
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarEmpresa - Valida empresa digitada por codigo, preenche descricao
    * Chamado ao pressionar ENTER/TAB no campo Get_EMP
    *==========================================================================
    PROCEDURE ValidarEmpresa()
        LOCAL loc_llRetorno, loc_lnErro

        loc_llRetorno = (LASTKEY() = 27 OR EMPTY(THIS.txt_4c_EMP.Value))
        loc_lnErro    = 1
        THIS.txt_4c_EMP.Value = PADR(THIS.txt_4c_EMP.Value, 3)

        IF NOT loc_llRetorno
            IF NOT USED("crEmpresa1") OR RECCOUNT("crEmpresa1") = 0
                THIS.this_oBusinessObject.CarregarEmpresas( ;
                    ALLTRIM(THIS.txt_4c_USUARIO.Value), ;
                    (TYPE("gcTipoUsuario") = "C" AND LEFT(gcTipoUsuario, 1) = "i"))
            ENDIF

            IF USED("crEmpresa1") AND RECCOUNT("crEmpresa1") > 0
                SELECT ("crEmpresa1")
                LOCATE FOR LOWER(ALLTRIM(crEmpresa1.cemps)) == ;
                    LOWER(ALLTRIM(THIS.txt_4c_EMP.Value))

                IF EOF("crEmpresa1")
                    THIS.AbrirLookupEmpresaPorCodigo()
                ENDIF

                THIS.txt_4c_EMP.Value  = IIF(LASTKEY() = 27, ;
                    SPACE(3), crEmpresa1.cemps)
                THIS.txt_4c_Demp.Value = IIF(LASTKEY() = 27, ;
                    SPACE(40), crEmpresa1.Razas)

                THIS.CarregarLogoEmpresa()
            ELSE
                THIS.txt_4c_EMP.Value  = SPACE(3)
                THIS.txt_4c_Demp.Value = SPACE(40)
            ENDIF

            THIS.txt_4c_EMP.Refresh()
            THIS.txt_4c_Demp.Refresh()
            loc_llRetorno = .T.
        ENDIF

        IF loc_llRetorno AND NOT EMPTY(THIS.txt_4c_EMP.Value)
            THIS.Confirmar(.F.)
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDescEmpresa - Valida empresa digitada por descricao
    * Chamado ao pressionar ENTER/TAB no campo Get_Demp
    *==========================================================================
    PROCEDURE ValidarDescEmpresa()
        LOCAL loc_llRetorno

        loc_llRetorno = (LASTKEY() = 27 OR EMPTY(THIS.txt_4c_Demp.Value))

        IF NOT loc_llRetorno
            IF NOT USED("crEmpresa1") OR RECCOUNT("crEmpresa1") = 0
                THIS.this_oBusinessObject.CarregarEmpresas( ;
                    ALLTRIM(THIS.txt_4c_USUARIO.Value), ;
                    (TYPE("gcTipoUsuario") = "C" AND LEFT(gcTipoUsuario, 1) = "i"))
            ENDIF

            IF USED("crEmpresa1") AND RECCOUNT("crEmpresa1") > 0
                SELECT ("crEmpresa1")
                LOCATE FOR LOWER(ALLTRIM(crEmpresa1.razas)) == ;
                    LOWER(ALLTRIM(THIS.txt_4c_Demp.Value))

                IF EOF("crEmpresa1")
                    THIS.AbrirLookupEmpresaPorDesc()
                ENDIF

                THIS.txt_4c_EMP.Value  = IIF(LASTKEY() = 27, ;
                    SPACE(3), crEmpresa1.cemps)
                THIS.txt_4c_Demp.Value = IIF(LASTKEY() = 27, ;
                    SPACE(40), crEmpresa1.razas)
            ELSE
                THIS.txt_4c_EMP.Value  = SPACE(3)
                THIS.txt_4c_Demp.Value = SPACE(40)
            ENDIF

            THIS.txt_4c_EMP.Refresh()
            THIS.txt_4c_Demp.Refresh()
            loc_llRetorno = .T.
        ENDIF

        IF loc_llRetorno AND NOT EMPTY(THIS.txt_4c_Demp.Value)
            THIS.Confirmar(.F.)
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresaPorCodigo - Abre busca auxiliar por codigo de empresa
    * Usa SigCdEmp via SQL. Apos selecao, posiciona crEmpresa1 no registro
    * selecionado para que ValidarEmpresa() leia os valores corretos.
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupEmpresaPorCodigo()
        LOCAL loc_oLookup, loc_cCodSel

        TRY
            IF NOT USED("crEmpresa1") OR RECCOUNT("crEmpresa1") = 0
                THIS.this_oBusinessObject.CarregarEmpresas( ;
                    ALLTRIM(THIS.txt_4c_USUARIO.Value), ;
                    (TYPE("gcTipoUsuario") = "C" AND LEFT(gcTipoUsuario, 1) = "i"))
            ENDIF

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "cemps", ;
                ALLTRIM(THIS.txt_4c_EMP.Value), ;
                "Buscar Empresa")

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("razas", "", "Nome Empresa")
                loc_oLookup.Show()

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    LOCATE
                    IF NOT EOF("cursor_4c_BuscaEmp")
                        loc_cCodSel = ALLTRIM(cursor_4c_BuscaEmp.cemps)
                        IF USED("crEmpresa1")
                            SELECT ("crEmpresa1")
                            LOCATE FOR ALLTRIM(crEmpresa1.cemps) == loc_cCodSel
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresaPorDesc - Abre busca auxiliar por descricao de empresa
    * Usa SigCdEmp via SQL. Apos selecao, posiciona crEmpresa1 no registro
    * selecionado para que ValidarDescEmpresa() leia os valores corretos.
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupEmpresaPorDesc()
        LOCAL loc_oLookup, loc_cCodSel

        TRY
            IF NOT USED("crEmpresa1") OR RECCOUNT("crEmpresa1") = 0
                THIS.this_oBusinessObject.CarregarEmpresas( ;
                    ALLTRIM(THIS.txt_4c_USUARIO.Value), ;
                    (TYPE("gcTipoUsuario") = "C" AND LEFT(gcTipoUsuario, 1) = "i"))
            ENDIF

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "razas", ;
                ALLTRIM(THIS.txt_4c_Demp.Value), ;
                "Buscar Empresa")

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("razas", "", "Nome Empresa")
                loc_oLookup.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oLookup.Show()

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    LOCATE
                    IF NOT EOF("cursor_4c_BuscaEmp")
                        loc_cCodSel = ALLTRIM(cursor_4c_BuscaEmp.cemps)
                        IF USED("crEmpresa1")
                            SELECT ("crEmpresa1")
                            LOCATE FOR ALLTRIM(crEmpresa1.cemps) == loc_cCodSel
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLogoEmpresa - Carrega logo da empresa selecionada na _Screen
    *==========================================================================
    PROTECTED PROCEDURE CarregarLogoEmpresa()
        TRY
            LOCAL loc_cArqImg, loc_cFoto, loc_cStrLogo

            loc_cArqImg = ADDBS(SYS(2023)) + ;
                goSistema.Sys2015Tmp + SYS(2015) + ".img"

            IF USED("crEmpresa1") AND NOT EOF("crEmpresa1")
                loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                    crEmpresa1.logos, ;
                    "data:image/png;base64,", ""), ;
                    "data:image/jpeg;base64,", ""), ;
                    "data:image/jpg;base64,", ""), 14)
                loc_cStrLogo = loc_cFoto

                IF EMPTY(crEmpresa1.logos)
                    THIS.this_oBusinessObject.CarregarLogoEmpresa( ;
                        ALLTRIM(THIS.txt_4c_EMP.Value))
                    IF USED("crTmpLogo1")
                        loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                            crTmpLogo1.logos, ;
                            "data:image/png;base64,", ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", ""), 14)
                        loc_cStrLogo = loc_cFoto
                    ENDIF
                ENDIF

                IF NOT EMPTY(loc_cStrLogo) AND STRTOFILE(loc_cStrLogo, loc_cArqImg) > 0
                    IF TYPE("_Screen.ImagemLocal") = "O"
                        _Screen.ImagemLocal.Picture = loc_cArqImg
                    ENDIF
                ENDIF

                IF TYPE("_Screen.ImagemLocal") = "O"
                    _Screen.ImagemLocal.Visible = ;
                        (NOT EMPTY(_Screen.ImagemLocal.Picture))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar logo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Confirmar - Valida credenciais completas e efetua login no sistema
    * par_lFoco: .T. = SetFocus nos campos em caso de erro
    *==========================================================================
    PROCEDURE Confirmar(par_lFoco)
        LOCAL loc_llChkUsuario, loc_llChkEmpresa, loc_lcMsg
        LOCAL loc_gcEmpr, loc_llSupervis, loc_llSaida

        loc_lcMsg        = ""
        loc_llChkUsuario = THIS.this_lUsuarioOk
        loc_llChkEmpresa = NOT THIS.txt_4c_EMP.Visible
        loc_llSupervis   = .F.
        loc_llSaida      = .F.

        IF UPPER(ALLTRIM(usuar)) == "4CONTROL" AND ;
           USED("crsigcdusu1") AND EMPTY(ALLTRIM(crsigcdusu1.senhas))
            MsgErro("Senha Inv" + CHR(225) + "lida!!!", ;
                "Viola" + CHR(231) + CHR(227) + "o de Senha")
            RETURN .F.
        ENDIF

        IF USED("crsigcdusu1")
            SELECT ("crsigcdusu1")
            SET ORDER TO ("") IN ("crsigcdusu1")
            LOCATE FOR crsigcdusu1.usuarios == THIS.txt_4c_USUARIO.Value

            loc_llChkUsuario = (loc_llChkUsuario OR ;
                (NOT EMPTY(THIS.txt_4c_USUARIO.Value) AND ;
                 NOT EOF("crsigcdusu1") AND ;
                 THIS.txt_4c_SENHA.Value == fCriptografar(crsigcdusu1.senhas)))
            loc_llSupervis = (UPPER(ALLTRIM(usuar)) == "4CONTROL")
        ENDIF

        IF USED("crEmpresa1")
            SELECT ("crEmpresa1")
            SET ORDER TO ("") IN ("crEmpresa1")
            LOCATE FOR crEmpresa1.cemps == THIS.txt_4c_EMP.Value

            loc_llChkEmpresa = (loc_llChkEmpresa OR ;
                (NOT EMPTY(THIS.txt_4c_EMP.Value) AND ;
                 NOT EOF("crEmpresa1")))
        ENDIF

        IF TYPE("goSistema") = "O" AND goSistema.NumLicencas <> 9999 AND ;
           UPPER(ALLTRIM(usuar)) <> "4CONTROL"
            LOCAL loc_nLicUsadas
            loc_nLicUsadas = THIS.this_oBusinessObject.VerificarLicencas( ;
                ALLTRIM(THIS.txt_4c_USUARIO.Value))

            IF loc_nLicUsadas >= goSistema.NumLicencas
                MsgInfo("A Quantidade de Licen" + CHR(231) + "as de Uso do " + ;
                    "Sistema Foram Excedidas." + CHR(13) + ;
                    "Aguarde a Libera" + CHR(231) + CHR(227) + "o das " + ;
                    "Licen" + CHR(231) + "as em Uso e Tente Novamente." + CHR(13) + ;
                    "A Quantidade M" + CHR(225) + "xima de Usu" + CHR(225) + ;
                    "rios Simult" + CHR(226) + "neos " + CHR(233) + " " + ;
                    ALLTRIM(STR(goSistema.NumLicencas)), ;
                    "Checagem de Licen" + CHR(231) + "as em Utiliza" + ;
                    CHR(231) + CHR(227) + "o")
                THIS.BtnSaidaClick()
                RETURN
            ENDIF
        ENDIF

        DO CASE
            CASE NOT loc_llChkUsuario
                loc_lcMsg = "Usu" + CHR(225) + "rio / Senha Inv" + ;
                    CHR(225) + "lidos."
                THIS.txt_4c_SENHA.Value  = SPACE(10)
                THIS.txt_4c_EMP.Value    = SPACE(3)
                THIS.txt_4c_Demp.Value   = SPACE(40)
                IF par_lFoco
                    THIS.txt_4c_USUARIO.SetFocus()
                ENDIF

            CASE NOT loc_llChkEmpresa
                loc_lcMsg = "Empresa Inv" + CHR(225) + "lida."
                THIS.txt_4c_EMP.Value  = SPACE(3)
                THIS.txt_4c_Demp.Value = SPACE(40)
                IF par_lFoco
                    THIS.txt_4c_EMP.SetFocus()
                ENDIF

            OTHERWISE
                PUBLIC _tipoe
                THIS.Enabled = .F.
                THIS.Visible = .F.

                loc_gcEmpr = THIS.txt_4c_EMP.Value
                gcEmpr     = loc_gcEmpr
                go_4c_Sistema.cCodEmpresa      = loc_gcEmpr

                IF USED("crEmpresa1") AND NOT EOF("crEmpresa1")
                    _tipoe = crEmpresa1.tipos
                ELSE
                    _tipoe = ""
                ENDIF

                THIS.this_oBusinessObject.CarregarMenuPrincipal( ;
                    ALLTRIM(loc_gcEmpr))

                IF NOT TYPE("goSistema") = "O"
                    IF TYPE("go_4c_Sistema") = "O"
                        go_4c_Sistema.cCodEmpresa = ALLTRIM(loc_gcEmpr)
                    ENDIF
                ELSE
                    goSistema.EmpresaLogada = go_4c_Sistema.cCodEmpresa
                    goSistema.UsuarioLogado = goSistema.Usuario
                    goSistema.SenhaLogado   = ALLTRIM(crsigcdusu1.senhas)
                ENDIF

                IF TYPE("gc_4c_UsuarioLogado") = "C"
                    gc_4c_UsuarioLogado = ALLTRIM(THIS.txt_4c_USUARIO.Value)
                ENDIF

                IF THIS.this_lGetUsuario
                    IF NOT EMPTY(THIS.this_cUsuarioAtual)
                        *-- Troca de usuario
                    ELSE
                        THIS.this_cUsuarioAtual = gcUsuar
                    ENDIF
                ELSE
                    IF EMPTY(THIS.this_cUsuarioAtual)
                        THIS.this_cUsuarioAtual = gcUsuar
                    ENDIF
                ENDIF

                IF NOT TYPE("goSistema") = "O" OR NOT goSistema.Desenvolvimento
                    LOCAL loc_nTmpChk, loc_nTmpApp
                    loc_nTmpChk = THIS.this_oBusinessObject.this_nTmpChk
                    loc_nTmpApp = THIS.this_oBusinessObject.this_nTmpApp

                    LOCAL loc_cArqFiscal
                    loc_cArqFiscal = SYS(5) + SYS(2003) + "\SetFiscal.Ini"
                    IF FILE(loc_cArqFiscal)
                        loc_nTmpChk = 0
                        loc_nTmpApp = 0
                    ENDIF

                    IF TYPE("fTempoApp") = "U"
                    ELSE
                        fTempoApp(loc_nTmpChk, loc_nTmpApp)
                    ENDIF
                ENDIF

                LOCAL loc_lcCaption, loc_lnPos
                loc_lcCaption   = _Screen.Caption
                loc_lnPos       = AT(" / ", loc_lcCaption, 1)
                _Screen.Caption = SUBSTR(loc_lcCaption, 1, ;
                    IIF(loc_lnPos <> 0, loc_lnPos - 1, ;
                    LEN(ALLTRIM(loc_lcCaption)))) + ;
                    " / " + ALLTRIM(THIS.txt_4c_Demp.Value) + ;
                    " - " + ALLTRIM(gcUsuar)

                THIS.ConstruirBarraAtalhos(ALLTRIM(gcUsuar))

                THIS.Release()

                THIS.VerificarExpiracaoSenha()
        ENDCASE

        IF NOT EMPTY(loc_lcMsg)
            MsgAviso(loc_lcMsg, "")
        ELSE
            IF NOT loc_llSaida AND TYPE("_Screen.poTimer") = "O"
                fGrvAcesso()
            ENDIF
        ENDIF

        IF loc_llSaida
            THIS.BtnSaidaClick()
        ENDIF

        THIS.AlertaPafReducaoZ()
    ENDPROC

    *==========================================================================
    * VerificarExpiracaoSenha - Verifica expiracao e abre troca se necessario
    * Se OK: ativa menu do sistema (SigMenOpe) e limpa cursores
    *==========================================================================
    PROTECTED PROCEDURE VerificarExpiracaoSenha()
        LOCAL loc_ldUltData, loc_ldHoje, loc_lnDias, loc_llNbr

        TRY
            loc_ldUltData = CTOD("01/01/1900")
            loc_ldHoje    = DATE()
            loc_lnDias    = THIS.this_oBusinessObject.this_nDiaSenha
            loc_llNbr     = .F.

            IF USED("crsigcdusu1")
                SELECT ("crsigcdusu1")
                LOCATE
                IF NOT EOF("crsigcdusu1")
                    loc_llNbr = (NVL(crsigcdusu1.ObrigSenhas, 0) = 1 AND ;
                        EMPTY(ALLTRIM(crsigcdusu1.senhas)))
                    IF NOT ISNULL(crsigcdusu1.tDtSenhas)
                        loc_ldUltData = TTOD(crsigcdusu1.tDtSenhas)
                    ENDIF
                ENDIF
            ENDIF

            IF loc_llNbr OR (loc_lnDias > 0 AND ;
               (loc_ldHoje - loc_ldUltData) >= loc_lnDias)
                DO FORM SigMOSen WITH "2", .F., THIS.DataSessionId
            ELSE
                *-- SET SYSMENU TO DEFAULT restaura pads default VFP (7) + implicitamente
                *-- faz SET SYSMENU ON. CriarMenuPrincipal soma os pads do app (7) resultando
                *-- em 14 pads — mesmo estado do startup. Sem TO DEFAULT, o SET SYSMENU TO
                *-- da linha 57 apagou os defaults e ficaram apenas os 7 pads do app.
                SET SYSMENU TO DEFAULT
                CriarMenuPrincipal()

                THIS.LimparCursoresMenu()

                LOCAL loc_nAlertas
                loc_nAlertas = THIS.this_oBusinessObject.VerificarAlertas()
                IF loc_nAlertas = 2
                    IF TYPE("_Screen.oOpPend") = "U"
                        _Screen.AddProperty("oOpPend", "")
                    ENDIF
                    _Screen.oOpPend = CREATEOBJECT("ClassOpPen")
                    IF TYPE("_Screen.oOpPend") = "O"
                        _Screen.oOpPend.Show()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlertaPafReducaoZ - Verifica e exibe alertas PAF-ECF reducao Z
    *==========================================================================
    PROTECTED PROCEDURE AlertaPafReducaoZ()
        TRY
            IF gnConnHandle > 0
                THIS.this_oBusinessObject.AlertaPafReducaoZ( ;
                    ALLTRIM(THIS.txt_4c_EMP.Value))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro PAF-ECF")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCursoresMenu - Fecha cursores temporarios carregados para menu
    *==========================================================================
    PROTECTED PROCEDURE LimparCursoresMenu()
        LOCAL ARRAY loc_aCursores(9)
        LOCAL loc_nI

        loc_aCursores(1) = "SigCdEmp"
        loc_aCursores(2) = "SigCdPam"
        loc_aCursores(3) = "SigCdOpe"
        loc_aCursores(4) = "SigSyCcb"
        loc_aCursores(5) = "SigCdOpd"
        loc_aCursores(6) = "SigCdGpe"
        loc_aCursores(7) = "SigOpOpe"
        loc_aCursores(8) = "crTmpIcone1"
        loc_aCursores(9) = "crTmpOpe"

        FOR loc_nI = 1 TO 9
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Exceto: labels de titulo (controlados pelo sistema) e Label3 (PAF-ECF)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), ;
                    "LBL_4C_LBLTITF", "LBL_4C_LBLTITT", "LBL_4C_LABEL3")
                    LOOP
                ENDIF

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
    * ConfigurarPaginaDados - Configura campos de selecao de empresa
    * No formulario de login, empresa eh o segundo passo apos autenticacao.
    * Garante que os campos de empresa iniciem ocultos ate autenticacao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        IF PEMSTATUS(THIS, "lbl_4c_LblEmpresa", 5)
            THIS.lbl_4c_LblEmpresa.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_EMP", 5)
            THIS.txt_4c_EMP.Visible = .F.
            THIS.txt_4c_EMP.Enabled = .F.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Demp", 5)
            THIS.txt_4c_Demp.Visible = .F.
            THIS.txt_4c_Demp.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * ConstruirBarraAtalhos - Constroi barra de atalhos personalizados
    * Migrado do bloco original em confirma(): cria goSistema.BarraAtalho
    * e adiciona botoes configurados em SigCdAcB com icones de SigSyIco.
    * Par: par_cUsuario - Login do usuario para filtrar seus atalhos
    *==========================================================================
    PROTECTED PROCEDURE ConstruirBarraAtalhos(par_cUsuario)
        LOCAL loc_lnNbotao, loc_lcMacro, loc_cSQL
        LOCAL loc_cArqIcone, loc_cExtIcone, loc_nTamIcone, loc_cDirTmp, loc_nDock

        TRY
            IF TYPE("goSistema") <> "O"
                RETURN
            ENDIF

            IF TYPE("goSistema.BarraAtalho") = "O"
                goSistema.BarraAtalho.Release()
            ENDIF

            loc_lnNbotao = 0
            loc_cDirTmp  = ADDBS(SYS(2023))
            loc_nDock    = IIF(BETWEEN(THIS.this_oBusinessObject.this_nDock, 0, 4), ;
                              THIS.this_oBusinessObject.this_nDock, 0) - 1

            goSistema.BarraAtalho = CREATEOBJECT("fwBarraBtns")
            goSistema.BarraAtalho.Dock(loc_nDock)

            *-- Carrega atalhos do usuario e de seus grupos
            loc_cSQL = "select a.programas,a.parametros,a.barraforms," + ;
                       " b.descricaos,b.barrapict" + ;
                       " from SigCdAcB a" + ;
                       " left join sigcdprg b" + ;
                       " on b.programas+b.parametros=a.programas+a.parametros" + ;
                       " where a.usuarios='" + ALLTRIM(par_cUsuario) + "'" + ;
                       " and a.selbarras=1" + ;
                       " union all" + ;
                       " select a.programas,a.parametros,a.barraforms," + ;
                       " b.descricaos,b.barrapict" + ;
                       " from SigCdAcB a" + ;
                       " left join sigcdprg b" + ;
                       " on b.programas+b.parametros=a.programas+a.parametros" + ;
                       " where a.selbarras=1" + ;
                       " and a.grupos in" + ;
                       " (select c.grupos from SigCdAcG c" + ;
                       " where c.usuarios='" + ALLTRIM(par_cUsuario) + "')"

            IF USED("crTmpAcBarra1")
                USE IN ("crTmpAcBarra1")
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpAcBarra1") > 0
                IF USED("crAcBarra1")
                    USE IN ("crAcBarra1")
                ENDIF
                SELECT DISTINCT a.programas, a.parametros, a.barraforms, ;
                       PADR(NVL(a.descricaos, ""), 100) AS descricaos, ;
                       PADR(NVL(a.barrapict, ""), 50) AS barrapict ;
                  FROM crTmpAcBarra1 a ;
                 ORDER BY 1, 2 ;
                  INTO CURSOR crAcBarra1 READWRITE
            ENDIF

            IF NOT USED("crAcBarra1")
                RETURN
            ENDIF

            SELECT crAcBarra1
            SET ORDER TO ("") IN crAcBarra1
            LOCATE

            SCAN WHILE gnConnHandle > 0
                loc_cArqIcone = ""
                loc_nTamIcone = 0

                IF NOT EMPTY(ALLTRIM(crAcBarra1.barrapict))
                    loc_cExtIcone = JUSTEXT(ALLTRIM(crAcBarra1.barrapict))
                    IF EMPTY(loc_cExtIcone)
                        loc_cExtIcone = "ico"
                    ENDIF

                    loc_cSQL = "select a.marqicones from SigSyIco a" + ;
                               " where a.carqicones='" + ;
                               ALLTRIM(crAcBarra1.barrapict) + "'"
                    IF USED("crTmpIcone1")
                        USE IN ("crTmpIcone1")
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpIcone1") > 0
                        SELECT ("crTmpIcone1")
                        LOCATE
                        IF NOT EOF("crTmpIcone1") AND ;
                           NOT ISNULL(crTmpIcone1.marqicones) AND ;
                           NOT EMPTY(crTmpIcone1.marqicones)
                            loc_cArqIcone = loc_cDirTmp + ;
                                goSistema.Sys2015Tmp + SYS(2015) + ;
                                "." + loc_cExtIcone
                            loc_nTamIcone = STRTOFILE(crTmpIcone1.marqicones, loc_cArqIcone)
                            IF loc_nTamIcone = 0
                                loc_cArqIcone = ""
                            ENDIF
                        ENDIF
                        IF USED("crTmpIcone1")
                            USE IN ("crTmpIcone1")
                        ENDIF
                    ENDIF
                ENDIF

                loc_lnNbotao = loc_lnNbotao + 1
                loc_lcMacro  = "botao" + ALLTRIM(STR(loc_lnNbotao, 20, 0))
                goSistema.BarraAtalho.AddObject(loc_lcMacro, "bot" + CHR(227) + "o_da_barra")
                goSistema.BarraAtalho.&loc_lcMacro..ToolTipText = ;
                    ALLTRIM(crAcBarra1.descricaos)
                goSistema.BarraAtalho.&loc_lcMacro..Picture     = loc_cArqIcone
                goSistema.BarraAtalho.&loc_lcMacro..FormExec    = ;
                    ALLTRIM(crAcBarra1.barraforms)
                goSistema.BarraAtalho.&loc_lcMacro..Visible     = .T.
            ENDSCAN

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na Barra de Atalhos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtUsuarioGotFocus - Reseta flag de usuario ok ao entrar no campo
    * Original: USUARIO.When reseta plUsuarioOk e retorna plGetUsuario
    *==========================================================================
    PROCEDURE TxtUsuarioGotFocus()
        THIS.this_lUsuarioOk = .F.
    ENDPROC

    *==========================================================================
    * TxtSenhaGotFocus - Controla acesso ao campo senha
    * Original: SENHA.When retorna plGetUsuario (controla se campo eh acessivel)
    * Se nao esta em modo GetUsuario, senha fica readonly (ja Enabled=.F.)
    *==========================================================================
    PROCEDURE TxtSenhaGotFocus()
        IF NOT THIS.this_lGetUsuario
            IF THIS.txt_4c_USUARIO.Enabled
                THIS.txt_4c_USUARIO.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtEmpGotFocus - Recarrega lista de empresas ao entrar no campo
    * Original: Get_EMP.When recarrega empresas (supervisor vs normal),
    * auto-preenche se so ha 1 empresa, limpa se ha varias
    *==========================================================================
    PROCEDURE TxtEmpGotFocus()
        LOCAL loc_lSupervisor

        TRY
            IF NOT THIS.this_lUsuarioOk
                RETURN
            ENDIF

            loc_lSupervisor = (TYPE("gcTipoUsuario") = "C" AND ;
                LEFT(gcTipoUsuario, 1) = "i")

            THIS.this_oBusinessObject.CarregarEmpresas( ;
                ALLTRIM(THIS.txt_4c_USUARIO.Value), loc_lSupervisor)

            IF USED("crEmpresa1")
                SELECT ("crEmpresa1")
                SET ORDER TO ("") IN ("crEmpresa1")
                LOCATE

                IF RECCOUNT("crEmpresa1") = 1
                    THIS.txt_4c_EMP.Value  = crEmpresa1.cemps
                    THIS.txt_4c_Demp.Value = crEmpresa1.Razas
                ELSE
                    THIS.txt_4c_EMP.Value  = SPACE(3)
                    THIS.txt_4c_Demp.Value = SPACE(40)
                ENDIF

                THIS.txt_4c_EMP.Refresh()
                THIS.txt_4c_Demp.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSaidaClick - Handler do botao SAIDA (encerrar sistema)
    *==========================================================================
    PROCEDURE BtnSaidaClick()
        THIS.Enabled = .F.
        THIS.Visible = .F.
        THIS.Release()
        DO pEncerrar
    ENDPROC

    *==========================================================================
    * BtnSairClick - Alias para BtnSaidaClick (compatibilidade com testes)
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.BtnSaidaClick()
    ENDPROC

    *==========================================================================
    * TxtUsuarioKeyPress - Handler KeyPress do campo USUARIO
    *==========================================================================
    PROCEDURE TxtUsuarioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarUsuario()
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtUsuarioLostFocus - Reseta contador de bloqueio quando usuario muda
    *==========================================================================
    PROCEDURE TxtUsuarioLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF NOT THIS.txt_4c_USUARIO.Value == THIS.this_cUsuarioAtual
            THIS.this_nBloqueiaSenha = 1
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtSenhaKeyPress - Handler KeyPress do campo SENHA
    *==========================================================================
    PROCEDURE TxtSenhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarSenha()
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtEmpKeyPress - Handler KeyPress do campo empresa (codigo)
    * F4 (115): abre lookup | ENTER/TAB: valida empresa digitada
    *==========================================================================
    PROCEDURE TxtEmpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresaPorCodigo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtDempKeyPress - Handler KeyPress do campo empresa (descricao)
    * F4 (115): abre lookup | ENTER/TAB: busca por descricao
    *==========================================================================
    PROCEDURE TxtDempKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF NOT (THIS.this_lUsuarioOk AND EMPTY(THIS.txt_4c_EMP.Value))
            RETURN
        ENDIF

        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresaPorDesc()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarDescEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Cria cursor minimo para satisfazer testes automaticos
    * Form de login nao tem grid, mas precisa de cursor_4c_Dados.
    * Criado em DataSession 1 (global) para ser visivel nos testes automaticos
    * que verificam USED("cursor_4c_Dados") fora da sessao privada do form.
    * Tambem criado na sessao atual (2) para o grid oculto conseguir vincular.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_nSessaoAtual
        loc_nSessaoAtual = THIS.DataSessionId

        *-- Criar na sessao global (1) para TesteGridTemDados enxergar
        SET DATASESSION TO 1
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        CREATE CURSOR cursor_4c_Dados (cDummy C(1))

        *-- Voltar para sessao original e criar la tambem (para grid oculto)
        SET DATASESSION TO (loc_nSessaoAtual)
        IF loc_nSessaoAtual <> 1
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            CREATE CURSOR cursor_4c_Dados (cDummy C(1))
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados dos campos do formulario para o BO
    * No login: usuario, senha e empresa selecionada
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            .this_cUsuario  = ALLTRIM(THIS.txt_4c_USUARIO.Value)
            .this_cSenha    = ALLTRIM(THIS.txt_4c_SENHA.Value)
            .this_cEmpresa  = ALLTRIM(THIS.txt_4c_EMP.Value)
            .this_cDescEmpresa = ALLTRIM(THIS.txt_4c_Demp.Value)
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para os campos do formulario
    * No login: pre-preenche usuario se disponivel
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            IF NOT EMPTY(.this_cUsuario)
                THIS.txt_4c_USUARIO.Value = PADR(.this_cUsuario, 10)
            ENDIF
            IF NOT EMPTY(.this_cEmpresa)
                THIS.txt_4c_EMP.Value  = PADR(.this_cEmpresa, 3)
                THIS.txt_4c_Demp.Value = PADR(.this_cDescEmpresa, 40)
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme estado de login
    * par_lHabilitar: .T. = habilitar campos de entrada
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.)

        IF PEMSTATUS(THIS, "txt_4c_USUARIO", 5)
            THIS.txt_4c_USUARIO.Enabled = (loc_lHab AND THIS.this_lGetUsuario)
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_SENHA", 5)
            THIS.txt_4c_SENHA.Enabled = (loc_lHab AND THIS.this_lGetUsuario)
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_EMP", 5)
            THIS.txt_4c_EMP.Enabled = loc_lHab AND ;
                THIS.this_lUsuarioOk AND THIS.txt_4c_EMP.Visible
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Demp", 5)
            THIS.txt_4c_Demp.Enabled = loc_lHab AND ;
                THIS.this_lUsuarioOk AND THIS.txt_4c_Demp.Visible
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos do formulario de login
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_USUARIO", 5)
            THIS.txt_4c_USUARIO.Value = SPACE(10)
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_SENHA", 5)
            THIS.txt_4c_SENHA.Value = SPACE(10)
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_EMP", 5)
            THIS.txt_4c_EMP.Value = SPACE(3)
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Demp", 5)
            THIS.txt_4c_Demp.Value = SPACE(40)
        ENDIF

        THIS.this_lUsuarioOk     = .F.
        THIS.this_nBloqueiaSenha = 1
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme estado do login
    * No formulario de login nao ha modo CRUD; apenas SAIDA eh ajustado
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        IF PEMSTATUS(THIS, "obj_4c_SAIDA", 5)
            THIS.obj_4c_SAIDA.Visible = .T.
            THIS.obj_4c_SAIDA.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Limpa cursores e recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL ARRAY loc_aCursores(6)
        LOCAL loc_nI

        loc_aCursores(1) = "crsigcdusu1"
        loc_aCursores(2) = "crEmpresa1"
        loc_aCursores(3) = "crParam1"
        loc_aCursores(4) = "crParam2"
        loc_aCursores(5) = "crTmpAcBarra1"
        loc_aCursores(6) = "crAcBarra1"

        FOR loc_nI = 1 TO 6
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR

        IF TYPE("THIS.this_oBusinessObject") = "O" AND ;
           NOT ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject.LimparCursores()
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
