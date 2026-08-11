*==============================================================================
* FormSigPrScn.prg
* Form Operacional: Libera" + CHR(231) + CHR(227) + "o de Acesso ao Sistema
* Herda de: FormBase
* Legado: SigPrScn.SCX
* Tipo: OPERACIONAL - dialogo de autenticacao
*==============================================================================

DEFINE CLASS FormSigPrScn AS FormBase

    *-- Dimensoes e comportamento identicos ao legado
    Width       = 800
    Height      = 160
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    ControlBox  = .F.
    WindowType  = 1
    BorderStyle = 2
    DataSession = 2

    *-- Estado interno
    this_lTbVisivel = .F.
    this_cUsuario   = ""
    this_cSenha     = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrScnBO")

            THIS.Caption = "Libera" + CHR(231) + CHR(227) + "o de Acesso ao Sistema"

            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarCamposLogin()

            BINDEVENT(THIS.txt_4c_Senha, "KeyPress", THIS, "TxtSenhaKeyPress")

            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
    *-- Form OPERACIONAL dialogo (login): NAO usa PageFrame (SCX legado eh
    *-- form simples 436x160 sem Pagina/PageFrame). Este metodo centraliza a
    *-- normalizacao de estado da janela e a barra de atalhos herdada do
    *-- goSistema (equivalente ao Init original que ocultava BarraAtalho).
        IF TYPE("goSistema") = "O" AND !ISNULL(goSistema) AND ;
           PEMSTATUS(goSistema, "BarraAtalho", 5)
            THIS.this_lTbVisivel = goSistema.BarraAtalho.Visible
            goSistema.BarraAtalho.Visible = .F.
        ENDIF

        THIS.AutoCenter  = .T.
        THIS.WindowState = 0
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        LOCAL loc_cTitulo
        loc_cTitulo = "Libera" + CHR(231) + CHR(227) + "o de Acesso ao Sistema"

        THIS.AddObject("cnt_4c_Sombra", "Container")

        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = loc_cTitulo
            .Height    = 40
            .Left      = 10
            .Top       = 18
            .Width     = THIS.cnt_4c_Sombra.Width - 20
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .Caption   = loc_cTitulo
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = THIS.cnt_4c_Sombra.Width - 20
            .ForeColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF TYPE("goSistema") = "O" AND !ISNULL(goSistema) AND ;
           PEMSTATUS(goSistema, "BarraAtalho", 5)
            goSistema.BarraAtalho.Visible = THIS.this_lTbVisivel
        ENDIF

        IF !ISNULL(THIS.this_oBusinessObject) AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposLogin()
    *==========================================================================
        *-- Label "Usu" + CHR(225) + "rio :"
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .BackStyle = 0
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Height    = 21
            .Left      = 78
            .Top       = 91
            .Width     = 75
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Senha :"
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .BackStyle = 0
            .Caption   = "Senha :"
            .Height    = 21
            .Left      = 90
            .Top       = 126
            .Width     = 63
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox Usu" + CHR(225) + "rio
        THIS.AddObject("txt_4c_Usuario", "TextBox")
        WITH THIS.txt_4c_Usuario
            .FontBold       = .T.
            .FontName       = "Arial"
            .FontSize       = 14
            .BackStyle      = 1
            .Format         = "K"
            .Height         = 30
            .InputMask      = "!!!!!!!!!!"
            .Left           = 160
            .SelectOnEntry  = .F.
            .SpecialEffect  = 1
            .TabIndex       = 2
            .Top            = 86
            .Width          = 136
            .BackColor      = RGB(255, 255, 255)
            .Value          = ""
        ENDWITH

        *-- TextBox Senha
        THIS.AddObject("txt_4c_Senha", "TextBox")
        WITH THIS.txt_4c_Senha
            .FontBold       = .T.
            .FontName       = "Arial"
            .FontSize       = 14
            .BackStyle      = 1
            .Format         = "K"
            .Height         = 30
            .InputMask      = "!!!!!!!!!!"
            .Left           = 160
            .PasswordChar   = "*"
            .SpecialEffect  = 1
            .TabIndex       = 3
            .Top            = 121
            .Width          = 136
            .BackColor      = RGB(255, 255, 255)
            .Value          = ""
        ENDWITH
    ENDPROC

    *==========================================================================
    * TxtSenhaKeyPress - Valida credenciais ao pressionar ENTER ou TAB no campo Senha
    *==========================================================================
    PROCEDURE TxtSenhaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        LOCAL loc_lAutenticar, loc_lAutenticado, loc_oErro
        loc_lAutenticar  = .T.
        loc_lAutenticado = .F.

        TRY
            THIS.this_oBusinessObject.this_cUsuario = ALLTRIM(THIS.txt_4c_Usuario.Value)
            THIS.this_oBusinessObject.this_cSenha   = ALLTRIM(THIS.txt_4c_Senha.Value)

            IF EMPTY(THIS.this_oBusinessObject.this_cUsuario)
                MsgAviso("Informe o usu" + CHR(225) + "rio.", "Login")
                THIS.txt_4c_Usuario.SetFocus()
                loc_lAutenticar = .F.
            ENDIF

            IF loc_lAutenticar
                IF THIS.this_oBusinessObject.ValidarCredenciais()
                    IF NOT FILE(SYS(5) + SYS(2003) + "\SetFiscal.Ini")
                        THIS.this_oBusinessObject.CarregarParametros()
                    ENDIF

                    THIS.this_oBusinessObject.GravarLog("L", THIS.Name, ;
                        ALLTRIM(THIS.this_oBusinessObject.this_cUsuario), THIS.Caption)

                    IF TYPE("goSistema") = "O" AND !ISNULL(goSistema) AND ;
                       PEMSTATUS(goSistema, "BarraAtalho", 5)
                        IF THIS.this_lTbVisivel
                            goSistema.BarraAtalho.Visible = .T.
                        ENDIF
                    ENDIF

                    loc_lAutenticado = .T.
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Login")
                    THIS.txt_4c_Senha.Value   = ""
                    THIS.txt_4c_Usuario.Value = ""
                    THIS.txt_4c_Usuario.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Login")
        ENDTRY

        IF loc_lAutenticado
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *==========================================================================
    *-- Form OPERACIONAL dialogo de login (SigPrScn/436x160 sem PageFrame).
    *-- Nao possui Page1=Lista/Page2=Dados nem botoes CRUD (Incluir/Alterar/
    *-- Excluir/Consultar/Encerrar). Todos os controles visuais sao criados
    *-- em ConfigurarCabecalho() e ConfigurarCamposLogin(). Este metodo
    *-- existe apenas para compatibilidade com o contrato do FormBase e com
    *-- a instrumentacao do pipeline de migracao.
        RETURN
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
    *-- Form OPERACIONAL dialogo de login (SigPrScn/436x160 sem PageFrame).
    *-- NAO possui Page2 com campos de edicao - todos os campos de entrada
    *-- (txt_4c_Usuario / txt_4c_Senha) sao criados diretamente no form
    *-- plano por ConfigurarCamposLogin(). Este stub existe apenas para
    *-- compatibilidade com o contrato do FormBase e instrumentacao do pipeline.
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Nao aplicavel a form OPERACIONAL de login
    *==========================================================================
    * Form OPERACIONAL SigPrScn (dialogo de autenticacao 436x160) NAO possui
    * botao Incluir no SCX legado - nao ha grid nem cadastro CRUD. A unica
    * acao do form eh validar credenciais no LostFocus do campo Senha
    * (portado para TxtSenhaKeyPress). Este metodo existe apenas para
    * compatibilidade com o contrato do FormBase e instrumentacao do pipeline
    * multi-fase.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Nao aplicavel a form OPERACIONAL de login
    *==========================================================================
    * Form OPERACIONAL SigPrScn (dialogo de autenticacao) NAO possui botao
    * Alterar - o unico fluxo eh digitar usuario/senha e pressionar ENTER/TAB
    * no campo Senha (TxtSenhaKeyPress -> BO.ValidarCredenciais). Stub para
    * compatibilidade com o contrato do FormBase.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Nao aplicavel a form OPERACIONAL de login
    *==========================================================================
    * Form OPERACIONAL SigPrScn (dialogo de autenticacao) NAO possui botao
    * Visualizar/Consultar - nao ha grid nem registro corrente para exibir.
    * Stub para compatibilidade com o contrato do FormBase.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Nao aplicavel a form OPERACIONAL de login
    *==========================================================================
    * Form OPERACIONAL SigPrScn (dialogo de autenticacao) NAO possui botao
    * Excluir - form nao gerencia registros de SigCdUsu, apenas verifica
    * credencial via SELECT em BO.ValidarCredenciais. Stub para
    * compatibilidade com o contrato do FormBase.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Nao aplicavel a form OPERACIONAL de login
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Nao aplicavel a form OPERACIONAL de login
    *==========================================================================
    * SCX legado nao tem botao Encerrar/Cancelar. O form so encerra apos
    * autenticacao bem-sucedida em TxtSenhaKeyPress (THIS.Release()).
    PROCEDURE BtnEncerrarClick()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Nao aplicavel a form OPERACIONAL de login
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Nao aplicavel a form OPERACIONAL de login
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere campos do form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_cUsuario = ALLTRIM(THIS.txt_4c_Usuario.Value)
        THIS.this_oBusinessObject.this_cSenha   = ALLTRIM(THIS.txt_4c_Senha.Value)
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        THIS.txt_4c_Usuario.Value = ALLTRIM(THIS.this_oBusinessObject.this_cUsuario)
        THIS.txt_4c_Senha.Value   = ""
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Controla habilitacao dos campos
    * Form de login: campos sempre habilitados (nao ha modo VISUALIZAR/CRUD)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        THIS.txt_4c_Usuario.Enabled = par_lHabilitar
        THIS.txt_4c_Senha.Enabled   = par_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa os campos de entrada do form de login
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c_Usuario.Value = ""
        THIS.txt_4c_Senha.Value   = ""
        THIS.txt_4c_Usuario.SetFocus()
    ENDPROC

    *==========================================================================
    * CarregarLista - Nao aplicavel a form OPERACIONAL de login
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Nao aplicavel a form OPERACIONAL de login
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

ENDDEFINE
