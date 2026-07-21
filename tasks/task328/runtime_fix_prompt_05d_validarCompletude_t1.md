# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrScn.prg] Procedure vazia (sem codigo): ConfigurarPaginaLista
[FormSigPrScn.prg] Procedure vazia (sem codigo): ConfigurarPaginaDados
[FormSigPrScn.prg] Procedure vazia (sem codigo): AlternarPagina
[FormSigPrScn.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrScn.prg):
*==============================================================================
* FormSigPrScn.prg
* Form Operacional: Libera" + CHR(231) + CHR(227) + "o de Acesso ao Sistema
* Herda de: FormBase
* Legado: SigPrScn.SCX
* Tipo: OPERACIONAL - dialogo de autenticacao
*==============================================================================

DEFINE CLASS FormSigPrScn AS FormBase

    *-- Dimensoes e comportamento identicos ao legado
    Width       = 436
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
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
    *-- Form OPERACIONAL dialogo de login (SigPrScn/436x160 sem PageFrame).
    *-- NAO possui Page2 com campos de edicao - todos os campos de entrada
    *-- (txt_4c_Usuario / txt_4c_Senha) sao criados diretamente no form
    *-- plano por ConfigurarCamposLogin(). Este stub existe apenas para
    *-- compatibilidade com o contrato do FormBase e instrumentacao do pipeline.
    ENDPROC

    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    *==========================================================================
        *-- Form de login sem paginacao - compatibilidade com FormBase
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
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrScnBO.prg):
*==============================================================================
* SigPrScnBO.prg - Business Object: Libera" + CHR(231) + CHR(227) + "o de Acesso ao Sistema
* Herda de: BusinessBase
* Tabela: SigCdUsu
*==============================================================================

DEFINE CLASS SigPrScnBO AS BusinessBase

    *-- Usuario digitado para autenticacao
    this_cUsuario    = ""
    *-- Senha digitada (texto plano para comparacao com hash do BD)
    this_cSenha      = ""
    *-- Hash da senha recuperado do banco (SigCdUsu.senhas)
    this_cSenhasDB   = ""
    *-- Resultado da autenticacao
    this_lAutenticado = .F.
    *-- Estado da barra de atalhos antes de abrir o form (para restaurar)
    this_lTbVisivel  = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela     = "SigCdUsu"
        THIS.this_cCampoChave = "usuarios"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ALLTRIM(THIS.this_cUsuario)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cUsuario  = TratarNulo(usuarios, "C")
            THIS.this_cSenhasDB = TratarNulo(senhas, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCredenciais - Autentica usuario/senha contra SigCdUsu
    * Retorna .T. se credenciais validas, .F. caso contrario
    * Em caso de erro preenche this_cMensagemErro
    *--------------------------------------------------------------------------
    FUNCTION ValidarCredenciais()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuarioPad, loc_cSenhaPad
        loc_lSucesso = .F.

        TRY
            loc_cUsuarioPad = PADR(ALLTRIM(THIS.this_cUsuario), 10)
            loc_cSenhaPad   = PADR(ALLTRIM(THIS.this_cSenha), 10)

            IF EMPTY(ALLTRIM(loc_cUsuarioPad))
                THIS.this_cMensagemErro = "Informe o usu" + CHR(225) + "rio."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "SELECT a.usuarios, a.senhas " + ;
                       "FROM SigCdUsu a " + ;
                       "WHERE NOT a.cAtivos = 'N' " + ;
                       "AND a.usuarios = '" + ALLTRIM(loc_cUsuarioPad) + "' " + ;
                       "ORDER BY 1"

            IF USED("cursor_4c_ScnUsu")
                USE IN cursor_4c_ScnUsu
            ENDIF

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ScnUsu")

            IF !USED("cursor_4c_ScnUsu")
                THIS.this_cMensagemErro = "Erro ao consultar usu" + CHR(225) + "rio."
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_ScnUsu

            IF EOF() OR EMPTY(ALLTRIM(loc_cUsuarioPad))
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio ou Senha incorretos."
                loc_lSucesso = .F.
            ENDIF

            IF loc_cSenhaPad <> fCriptografar(cursor_4c_ScnUsu.senhas)
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio ou Senha incorretos."
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cSenhasDB    = TratarNulo(cursor_4c_ScnUsu.senhas, "C")
            THIS.this_lAutenticado = .T.
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_ScnUsu")
            USE IN cursor_4c_ScnUsu
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de timeout de SigCdPam
    * Chamado quando SetFiscal.Ini nao existe
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT nTmpChks, nTmpApps FROM SigCdPam"

            IF USED("cursor_4c_ScnParam")
                USE IN cursor_4c_ScnParam
            ENDIF

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ScnParam")

            IF USED("cursor_4c_ScnParam")
                SELECT cursor_4c_ScnParam
                GOTO TOP
                IF !EOF()
                    fTempoApp(cursor_4c_ScnParam.nTmpChks, cursor_4c_ScnParam.nTmpApps)
                ENDIF
                USE IN cursor_4c_ScnParam
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarLog - Registra acesso ao sistema via fGravarLog legado
    *--------------------------------------------------------------------------
    FUNCTION GravarLog(par_cEvento, par_cNomeForm, par_cUsuario, par_cCaption)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            fGravarLog(par_cEvento, par_cNomeForm, par_cUsuario, par_cCaption)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Registra evento de acesso autenticado do usuario
    * Contexto SIGPRSCN (Liberacao de Acesso): "insercao" = gravar registro
    * de acesso no LogAuditoria + atualizar data ultimo acesso em SigCdUsu.
    * Chamado apos ValidarCredenciais() retornar .T.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_nRet
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = ALLTRIM(THIS.this_cUsuario)

            IF EMPTY(loc_cUsuario)
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            IF !THIS.this_lAutenticado
                THIS.this_cMensagemErro = "Credenciais n" + CHR(227) + "o validadas."
                loc_lSucesso = .F.
            ENDIF

            *-- Grava data/hora do acesso na coluna tdtsenhas do usuario
            loc_cSQL = "UPDATE SigCdUsu " + ;
                       "SET tdtsenhas = GETDATE() " + ;
                       "WHERE usuarios = " + EscaparSQL(loc_cUsuario)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Erro ao registrar hor" + CHR(225) + "rio de acesso."
                loc_lSucesso = .F.
            ENDIF

            *-- Registra no LogAuditoria via BusinessBase
            THIS.RegistrarAuditoria("ACESSO")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza dados do usuario autenticado
    * Contexto SIGPRSCN: sincroniza flag obrigsenhas / cativos apos login
    * bem-sucedido. Preserva o hash de senha (senhas) intocado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_nRet
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = ALLTRIM(THIS.this_cUsuario)

            IF EMPTY(loc_cUsuario)
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            *-- Atualiza tdtsenhas (data ultima autenticacao)
            loc_cSQL = "UPDATE SigCdUsu " + ;
                       "SET tdtsenhas = GETDATE() " + ;
                       "WHERE usuarios = " + EscaparSQL(loc_cUsuario) + " " + ;
                       "AND NOT cAtivos = 'N'"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Erro ao atualizar dados do usu" + CHR(225) + "rio."
                loc_lSucesso = .F.
            ENDIF

            *-- Registra alteracao no LogAuditoria
            THIS.RegistrarAuditoria("ATUALIZAR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Desativa usuario (soft-delete via cAtivos='N')
    * NAO executa DELETE fisico - SIGPRSCN nunca remove usuario da base.
    * Marca cAtivos='N' para bloquear acessos futuros.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_nRet
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = ALLTRIM(THIS.this_cUsuario)

            IF EMPTY(loc_cUsuario)
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdUsu " + ;
                       "SET cAtivos = 'N' " + ;
                       "WHERE usuarios = " + EscaparSQL(loc_cUsuario)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Erro ao desativar usu" + CHR(225) + "rio."
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("EXCLUIR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

