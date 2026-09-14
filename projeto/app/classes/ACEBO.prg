*==============================================================================
* ACEBO.PRG
* Business Object para Acesso de Empresas (SIGCDACE)
*
* Tabela Principal : SigCdEmp  - Lista de empresas (Cemps, Razas)
* Tabela de Acesso : SigCdAcE  - Mapeamento empresa-usuario
*                                (emps char(3), usuarios char(10), pkchaves char(13))
* Tabela de Usuarios: SigCdUsu - Cadastro de usuarios (usuarios char(10))
*
* Logica: Gerencia quais usuarios tem acesso a cada empresa.
*         Inserir/Atualizar = DELETE + re-INSERT em SigCdAcE por empresa.
*         Excluir           = DELETE todos os acessos da empresa em SigCdAcE.
*         Buscar            = SELECT de empresas em SigCdEmp (exibicao no grid).
*==============================================================================

DEFINE CLASS ACEBO AS BusinessBase

    *-- Propriedades da empresa (SigCdEmp)
    this_cEmpresa            = ""   && Cemps/emps CHAR(3)  - Codigo da empresa (PK)
    this_cDescricaoEmpresa   = ""   && Razas       CHAR(40) - Descricao da empresa

    *-- Nome do cursor que o Form preenche com os usuarios com acesso antes de Salvar()
    this_cCursorUsuariosAcesso = "cursor_4c_UsuariosAcesso"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEmp"
        THIS.this_cCampoChave = "Cemps"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpresa
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados da empresa de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpresa          = TratarNulo(Cemps, "C")
                THIS.this_cDescricaoEmpresa = TratarNulo(Razas, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades de dados
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cEmpresa          = ""
        THIS.this_cDescricaoEmpresa = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo da empresa obrigat" + CHR(243) + "rio"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista empresas no grid (SELECT de SigCdEmp)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp" + ;
                           " WHERE Cemps LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY Cemps"
            ELSE
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega dados de uma empresa pelo codigo Cemps
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cEmpresa) != "C" OR EMPTY(ALLTRIM(par_cEmpresa))
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo da empresa n" + CHR(227) + "o informado"
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpresa))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ALLTRIM(par_cEmpresa)
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUsuariosDisponiveis - Usuarios sem acesso a esta empresa
    * Retorna cursor_4c_UsuariosDispon (campo: Usuarios)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUsuariosDisponiveis(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_UsuariosDispon")
                USE IN cursor_4c_UsuariosDispon
            ENDIF

            loc_cSQL = "SELECT DISTINCT Usuarios FROM SigCdUsu" + ;
                       " WHERE NOT cativos = 'N'" + ;
                       " AND Usuarios NOT IN" + ;
                       " (SELECT Usuarios FROM SigCdAcE WHERE emps = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpresa)) + ")" + ;
                       " ORDER BY Usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosDispon")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUsuariosComAcesso - Usuarios com acesso a esta empresa
    * Retorna cursor_4c_UsuariosAcesso (campo: Usuarios)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUsuariosComAcesso(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_UsuariosAcesso")
                USE IN cursor_4c_UsuariosAcesso
            ENDIF

            loc_cSQL = "SELECT DISTINCT Usuarios FROM SigCdAcE" + ;
                       " WHERE emps = " + EscaparSQL(ALLTRIM(par_cEmpresa)) + ;
                       " ORDER BY Usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosAcesso")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursorAcesso - Cria cursor vazio para o Form preencher com usuarios
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursorAcesso()
        TRY
            IF USED("cursor_4c_UsuariosAcesso")
                USE IN cursor_4c_UsuariosAcesso
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_UsuariosAcesso (Usuarios C(10))
            SET NULL OFF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT: DELETE acessos antigos + INSERT novos (PROTECTED)
    * O Form preenche cursor_4c_UsuariosAcesso antes de chamar Salvar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nI
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAcE WHERE emps = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcE")
            IF USED("cursor_4c_DelAcE")
                USE IN cursor_4c_DelAcE
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar acessos antigos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_UsuariosAcesso") AND RECCOUNT("cursor_4c_UsuariosAcesso") > 0
                    loc_nI = 0
                    SELECT cursor_4c_UsuariosAcesso
                    GO TOP
                    SCAN
                        loc_nI = loc_nI + 1
                        loc_cSQL = "INSERT INTO SigCdAcE (usuarios, emps, pkchaves) VALUES (" + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_UsuariosAcesso.Usuarios)) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cEmpresa)) + ", " + ;
                                   EscaparSQL(LEFT(SYS(2015) + SYS(2015), 13)) + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcE")
                        IF USED("cursor_4c_InsAcE")
                            USE IN cursor_4c_InsAcE
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE: mesma logica do Inserir (DELETE + re-INSERT) (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nI
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAcE WHERE emps = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcE")
            IF USED("cursor_4c_DelAcE")
                USE IN cursor_4c_DelAcE
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_UsuariosAcesso") AND RECCOUNT("cursor_4c_UsuariosAcesso") > 0
                    loc_nI = 0
                    SELECT cursor_4c_UsuariosAcesso
                    GO TOP
                    SCAN
                        loc_nI = loc_nI + 1
                        loc_cSQL = "INSERT INTO SigCdAcE (usuarios, emps, pkchaves) VALUES (" + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_UsuariosAcesso.Usuarios)) + ", " + ;
                                   EscaparSQL(ALLTRIM(THIS.this_cEmpresa)) + ", " + ;
                                   EscaparSQL(LEFT(SYS(2015) + SYS(2015), 13)) + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcE")
                        IF USED("cursor_4c_InsAcE")
                            USE IN cursor_4c_InsAcE
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove todos os acessos da empresa (PROTECTED)
    * Nao deleta a empresa em si (SigCdEmp), apenas os registros em SigCdAcE
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
                MsgErro("Empresa n" + CHR(227) + "o selecionada para exclus" + CHR(227) + "o", "Erro")
            ELSE
                loc_cSQL = "DELETE FROM SigCdAcE WHERE emps = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelExcl")
                IF USED("cursor_4c_DelExcl")
                    USE IN cursor_4c_DelExcl
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
