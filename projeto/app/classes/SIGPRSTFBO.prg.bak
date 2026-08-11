*==============================================================================
* SIGPRSTFBO.prg - Business Object para dialogo Senha de Risco
* Herda de: BusinessBase
* Responsabilidade: Encapsular estado do dialogo de senha de supervisor
*==============================================================================

DEFINE CLASS SIGPRSTFBO AS BusinessBase

    *-- Senha digitada pelo usuario
    this_cSenha     = ""

    *-- Indica se o usuario cancelou (F. = confirmou, T. = cancelou)
    this_lCancelado = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - nao aplica (dialogo sem tabela SQL)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSenha     = TratarNulo(cSenha, "C")
            THIS.this_lCancelado = .F.
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - verifica que a senha nao esta vazia
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cSenha))
            THIS.this_cMensagemErro = "A senha do supervisor n" + CHR(227) + "o pode estar em branco."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - nao aplica (dialogo sem tabela SQL); retorna .T. por interface
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        IF !THIS.ValidarDados()
            RETURN .F.
        ENDIF
        THIS.RegistrarAuditoria("SENHA_RISCO")
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - nao aplica (dialogo sem tabela SQL); retorna .T. por interface
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        IF !THIS.ValidarDados()
            RETURN .F.
        ENDIF
        THIS.RegistrarAuditoria("SENHA_RISCO_ALT")
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - registra acesso ao dialogo de senha de risco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .T.

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, Usuario, DataHora) VALUES (" + ;
                       EscaparSQL("SIGPRSTF") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)

        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
            loc_lSucesso = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
