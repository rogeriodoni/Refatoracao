*==============================================================================
* GpsBO.prg - Business Object para Grupos de Produtos (Sub-nivel)
* Tabelas: SigCdGgp (tipo GGP) / SigCdGps (tipo GPS)
* Gerado: Fase 1/8 - Propriedades e Init
*         Fase 2/8 - Metodos CRUD
*==============================================================================

DEFINE CLASS GpsBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da entidade
    *--------------------------------------------------------------------------

    *-- Identificacao da operacao (Dopes de SigCdOpe)
    this_cDopes     = ""

    *-- Codigo do grupo (Cgrus de SigCdGrp - char(3))
    this_cCgrus     = ""

    *-- Descricao do grupo (Dgrus de SigCdGrp - char(30))
    this_cDgrus     = ""

    *-- Controla qual tabela usar: .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    this_lTipoggp   = .F.

    *-- Modo de edicao recebido do form pai: 'INSERIR', 'ALTERAR', etc.
    this_cEscolha   = ""

    *-- Flag que indica se houve alteracao de dados no grid
    this_lGravaDados = .F.

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- Tabela padrao GGP; o form comuta para GPS via this_lTipoggp
        THIS.this_cTabela     = "SigCdGgp"
        THIS.this_cCampoChave = "pkchave"

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta (Dopes + Cgrus) para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes) + "|" + ALLTRIM(THIS.this_cCgrus)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor de trabalho nas propriedades do BO
    * par_cAliasCursor: nome do cursor (Dopes c(20), Cgrus c(3), Dgrus c(30))
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes = TratarNulo(Dopes, "C")
                THIS.this_cCgrus = TratarNulo(Cgrus, "C")
                THIS.this_cDgrus = TratarNulo(Dgrus, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um unico registro de grupo no SQL Server
    * Usa: this_cDopes, this_cCgrus, this_lTipoggp
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_cPkCampo, loc_cChave, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.this_lTipoggp
                loc_cTabela  = "SigCdGgp"
                loc_cPkCampo = "pkchave"
            ELSE
                loc_cTabela  = "SigCdGps"
                loc_cPkCampo = "cIdChaves"
            ENDIF

            loc_cChave = LOWER(SYS(2015) + SYS(2015))

            loc_cSQL = "INSERT INTO " + loc_cTabela + ;
                       " (Dopes, Cgrus, " + loc_cPkCampo + ") VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCgrus)) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir grupo.", "Erro em Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel: grupos sao gerenciados via SalvarGrupos (batch)
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui todos os grupos de uma operacao (Dopes)
    * Chamado internamente pelo ciclo de salvamento (SalvarGrupos)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cTabela = IIF(THIS.this_lTipoggp, "SigCdGgp", "SigCdGps")
            loc_cSQL = "DELETE FROM " + loc_cTabela + ;
                       " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir grupos existentes.", "Erro em ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarGrupos - Carrega grupos do SQL Server em cursor temporario
    * par_cDopes   : Dopes da operacao (SigCdOpe)
    * par_lTipoggp : .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    * Resultado: cursor_4c_GruposTemp (Dopes c(20), Cgrus c(3), Dgrus c(30))
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrupos(par_cDopes, par_lTipoggp)
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF

            loc_cTabela = IIF(par_lTipoggp, "SigCdGgp", "SigCdGps")
            loc_cSQL = "SELECT a.Dopes, a.Cgrus, b.Dgrus " + ;
                       "FROM " + loc_cTabela + " a " + ;
                       "INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                       "WHERE a.Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTemp") > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos da opera" + CHR(231) + CHR(227) + "o.", "Erro em CarregarGrupos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarGrupos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicados - Verifica duplicidade de Cgrus no cursor de trabalho
    * par_cCursorOpe : Nome do cursor de trabalho (ex: "cursor_4c_Operacao")
    * Retorna .T. se valido (sem duplicatas), .F. se ha duplicatas
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicados(par_cCursorOpe)
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.
        TRY
            IF USED(par_cCursorOpe) AND RECCOUNT(par_cCursorOpe) > 0
                IF USED("cursor_4c_DupVerif")
                    USE IN cursor_4c_DupVerif
                ENDIF

                SELECT Cgrus, SUM(1) AS Qt ;
                    FROM (par_cCursorOpe) ;
                    WHERE NOT EMPTY(ALLTRIM(Cgrus)) ;
                    GROUP BY Cgrus ;
                    HAVING SUM(1) > 1 ;
                    INTO CURSOR cursor_4c_DupVerif READWRITE

                IF USED("cursor_4c_DupVerif") AND RECCOUNT("cursor_4c_DupVerif") > 0
                    loc_lValido = .F.
                    MsgAviso("Existem lan" + CHR(231) + "amentos de Grupos Em Duplicidade!!!", "Valida" + CHR(231) + CHR(227) + "o")
                ENDIF

                IF USED("cursor_4c_DupVerif")
                    USE IN cursor_4c_DupVerif
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDuplicados")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Ciclo completo: exclui registros existentes e reinsere
    * par_cDopes     : Dopes da operacao identificando os grupos
    * par_lTipoggp   : .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    * par_cCursorOpe : Nome do cursor de trabalho com grupos editados pelo usuario
    * Retorna .T. se salvou com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION SalvarGrupos(par_cDopes, par_lTipoggp, par_cCursorOpe)
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_cPkCampo
        LOCAL loc_cChave, loc_cCgrus, loc_lTransAtiva, loc_lErroInsert, loc_oErro
        loc_lSucesso    = .F.
        loc_lTransAtiva = .F.
        loc_lErroInsert = .F.
        TRY
            loc_cTabela  = IIF(par_lTipoggp, "SigCdGgp", "SigCdGps")
            loc_cPkCampo = IIF(par_lTipoggp, "pkchave", "cIdChaves")

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAtiva = .T.

            loc_cSQL = "DELETE FROM " + loc_cTabela + ;
                       " WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0

                IF USED(par_cCursorOpe)
                    SELECT (par_cCursorOpe)
                    GO TOP
                    DO WHILE !EOF() AND !loc_lErroInsert
                        IF !DELETED()
                            loc_cCgrus = ALLTRIM(Cgrus)
                            IF !EMPTY(loc_cCgrus)
                                loc_cChave = LOWER(SYS(2015) + SYS(2015))
                                loc_cSQL = "INSERT INTO " + loc_cTabela + ;
                                           " (Dopes, Cgrus, " + loc_cPkCampo + ") VALUES (" + ;
                                           EscaparSQL(ALLTRIM(par_cDopes)) + ", " + ;
                                           EscaparSQL(loc_cCgrus) + ", " + ;
                                           EscaparSQL(loc_cChave) + ")"
                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                    loc_lErroInsert = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                        IF !loc_lErroInsert
                            SELECT (par_cCursorOpe)
                            SKIP
                        ENDIF
                    ENDDO
                ENDIF

                IF !loc_lErroInsert
                    IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") > 0
                        loc_lTransAtiva = .F.
                        THIS.this_cDopes    = ALLTRIM(par_cDopes)
                        THIS.this_lTipoggp  = par_lTipoggp
                        THIS.RegistrarAuditoria("A")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao confirmar transa" + CHR(231) + CHR(227) + "o.", "Erro em SalvarGrupos")
                    ENDIF
                ELSE
                    MsgErro("Erro ao inserir grupo " + loc_cCgrus + ".", "Erro em SalvarGrupos")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir grupos existentes.", "Erro em SalvarGrupos")
            ENDIF

            IF loc_lTransAtiva AND !loc_lSucesso
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransAtiva = .F.
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransAtiva
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em SalvarGrupos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
