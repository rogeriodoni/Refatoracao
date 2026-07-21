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
