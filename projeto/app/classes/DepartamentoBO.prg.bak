*============================================================================
* DepartamentoBO.prg - Business Object: Cadastro de Departamentos
* Migrado de: SIGCDDPT.SCX
* Tabela principal : SigCdDpt  (chave: codigos)
* Tabela relacionada: sigdptgg (grupos do departamento)
*============================================================================
DEFINE CLASS DepartamentoBO AS BusinessBase

    *-- Propriedades: SigCdDpt
    this_cCodigo       = ""   && codigos     C(10) - Chave Primaria
    this_cDescricao    = ""   && descricaos  C(40) - Descricao do departamento
    this_cDiretor      = ""   && diretors    C(10) - FK SigCdUsu.Usuarios
    this_nChkSubs = 0    && nchksubs    N(1)  - Obriga Subclas. Encerramento (1=Sim 2=Nao)
    this_nChkTipos         = 0    && nchktipos   N(1)  - Tipo do departamento (1=Sim 2=Nao)
    this_nAutos   = 0    && autos       N(1)  - Automatico (1=Sim 2=Nao)
    this_nUtilizaLanc  = 0    && UtiLacto - campo exibido no form (nao existe no schema atual)

    *-- Nome do cursor de grupos (sigdptgg)
    this_cCursorGrupos = "cursor_4c_DptGg"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdDpt"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT todos os departamentos (filtro opcional por descricao)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, diretors" + ;
                       " FROM SigCdDpt"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                    " WHERE UPPER(descricaos) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar departamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT registro por chave primaria + grupos
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, diretors," + ;
                       " nchksubs, nchktipos, autos" + ;
                       " FROM SigCdDpt" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo       = ALLTRIM(TratarNulo(codigos, "C"))
                THIS.this_cDescricao    = ALLTRIM(TratarNulo(descricaos, "C"))
                THIS.this_cDiretor      = ALLTRIM(TratarNulo(diretors, "C"))
                THIS.this_nChkSubs = TratarNulo(nchksubs, "N")
                THIS.this_nChkTipos         = TratarNulo(nchktipos, "N")
                THIS.this_nAutos   = TratarNulo(autos, "N")
                THIS.this_nUtilizaLanc  = 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdDpt + salvar grupos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdDpt" + ;
                       " (codigos, descricaos, diretors, nchksubs, nchktipos, autos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       EscaparSQL(THIS.this_cDiretor) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkSubs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkTipos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutos) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = THIS.SalvarGrupos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Departamento inserido mas erro ao salvar grupos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdDpt + reprocessar grupos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdDpt SET" + ;
                       " descricaos = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " diretors   = " + EscaparSQL(THIS.this_cDiretor)   + "," + ;
                       " nchksubs   = " + FormatarNumeroSQL(THIS.this_nChkSubs) + "," + ;
                       " nchktipos  = " + FormatarNumeroSQL(THIS.this_nChkTipos)         + "," + ;
                       " autos      = " + FormatarNumeroSQL(THIS.this_nAutos)   + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = THIS.SalvarGrupos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Departamento atualizado mas erro ao salvar grupos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE sigdptgg + DELETE SigCdDpt
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            *-- Remove grupos relacionados primeiro
            loc_cSQL = "DELETE FROM sigdptgg WHERE coddepto = " + ;
                       EscaparSQL(THIS.this_cCodigo)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelGg")
                TABLEREVERT(.T., "cursor_4c_DelGg")
                USE IN cursor_4c_DelGg
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelGg")
            IF USED("cursor_4c_DelGg")
                USE IN cursor_4c_DelGg
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir grupos do departamento:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Remove o registro principal
                loc_cSQL = "DELETE FROM SigCdDpt WHERE codigos = " + ;
                           EscaparSQL(THIS.this_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Del")
                    TABLEREVERT(.T., "cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir departamento:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ExecutarExclusao:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarGrupos - Carrega grupos do dpto no cursor_4c_DptGg (para o grid)
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrupos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_nTotal, loc_nI, loc_aDepto[1], loc_aGrupo[1], loc_aDescs[1]
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorGrupos)
                USE IN (THIS.this_cCursorGrupos)
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_DptGg (CodDepto C(10), CodGrupo C(3), descs C(40))
            SET NULL OFF

            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT a.coddepto, a.codgrupo, b.descs" + ;
                           " FROM sigdptgg a" + ;
                           " JOIN SigCdGpr b ON a.codgrupo = b.codigos" + ;
                           " WHERE a.coddepto = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                           " ORDER BY a.codgrupo"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_DptGgTmp")
                    TABLEREVERT(.T., "cursor_4c_DptGgTmp")
                    USE IN cursor_4c_DptGgTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DptGgTmp")
                IF loc_nResultado >= 0
                    loc_nTotal = RECCOUNT("cursor_4c_DptGgTmp")
                    IF loc_nTotal > 0
                        DIMENSION loc_aDepto[loc_nTotal]
                        DIMENSION loc_aGrupo[loc_nTotal]
                        DIMENSION loc_aDescs[loc_nTotal]
                        SELECT cursor_4c_DptGgTmp
                        GO TOP
                        FOR loc_nI = 1 TO loc_nTotal
                            loc_aDepto[loc_nI] = ALLTRIM(cursor_4c_DptGgTmp.coddepto)
                            loc_aGrupo[loc_nI] = ALLTRIM(cursor_4c_DptGgTmp.codgrupo)
                            loc_aDescs[loc_nI]  = ALLTRIM(cursor_4c_DptGgTmp.descs)
                            IF !EOF("cursor_4c_DptGgTmp")
                                SKIP IN cursor_4c_DptGgTmp
                            ENDIF
                        ENDFOR
                        FOR loc_nI = 1 TO loc_nTotal
                            SELECT cursor_4c_DptGg
                            APPEND BLANK
                            REPLACE CodDepto WITH loc_aDepto[loc_nI], ;
                                    CodGrupo WITH loc_aGrupo[loc_nI], ;
                                    descs    WITH loc_aDescs[loc_nI]
                        ENDFOR
                    ENDIF
                    IF USED("cursor_4c_DptGgTmp")
                        USE IN cursor_4c_DptGgTmp
                    ENDIF
                ELSE
                    MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            *-- Garante linha em branco para o grid poder receber entrada
            IF RECCOUNT("cursor_4c_DptGg") = 0
                SELECT cursor_4c_DptGg
                APPEND BLANK
            ENDIF

            GO TOP IN cursor_4c_DptGg
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarGrupos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Persiste cursor_4c_DptGg em sigdptgg
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SalvarGrupos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_nTotal, loc_nI, loc_aGrupos[1]
        loc_lResultado = .F.

        TRY
            *-- Remove todos os grupos existentes para este departamento
            loc_cSQL = "DELETE FROM sigdptgg WHERE coddepto = " + ;
                       EscaparSQL(ALLTRIM(par_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelGrp")
                TABLEREVERT(.T., "cursor_4c_DelGrp")
                USE IN cursor_4c_DelGrp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelGrp")
            IF USED("cursor_4c_DelGrp")
                USE IN cursor_4c_DelGrp
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.

                *-- Coleta grupos nao-vazios do cursor numa array
                IF USED(THIS.this_cCursorGrupos)
                    loc_nTotal = RECCOUNT(THIS.this_cCursorGrupos)
                    IF loc_nTotal > 0
                        DIMENSION loc_aGrupos[loc_nTotal]
                        SELECT (THIS.this_cCursorGrupos)
                        GO TOP
                        FOR loc_nI = 1 TO loc_nTotal
                            loc_aGrupos[loc_nI] = ALLTRIM(cursor_4c_DptGg.CodGrupo)
                            IF !EOF("cursor_4c_DptGg")
                                SKIP IN cursor_4c_DptGg
                            ENDIF
                        ENDFOR

                        *-- Insere os grupos via SQL
                        FOR loc_nI = 1 TO loc_nTotal
                            IF !EMPTY(loc_aGrupos[loc_nI])
                                loc_cSQL = "INSERT INTO sigdptgg (pkchave, coddepto, codgrupo)" + ;
                                           " VALUES (" + ;
                                           "LEFT(REPLACE(CONVERT(VARCHAR(36),NEWID()),'-',''),20)," + ;
                                           EscaparSQL(ALLTRIM(par_cCodigo)) + "," + ;
                                           EscaparSQL(LEFT(loc_aGrupos[loc_nI], 3)) + ")"
                                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                                IF USED("cursor_4c_InsGrp")
                                    TABLEREVERT(.T., "cursor_4c_InsGrp")
                                    USE IN cursor_4c_InsGrp
                                ENDIF

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsGrp")
                                IF USED("cursor_4c_InsGrp")
                                    USE IN cursor_4c_InsGrp
                                ENDIF
                                IF loc_nResultado < 0
                                    MsgErro("Erro ao inserir grupo " + loc_aGrupos[loc_nI] + ;
                                             ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                    loc_lResultado = .F.
                                ENDIF
                            ENDIF
                        ENDFOR
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.SalvarGrupos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGruposDuplicados - Verifica se ha codigos de grupo repetidos
    *--------------------------------------------------------------------------
    FUNCTION ValidarGruposDuplicados()
        LOCAL loc_lValido, loc_nDuplic
        loc_lValido = .T.

        TRY
            IF USED(THIS.this_cCursorGrupos) AND RECCOUNT(THIS.this_cCursorGrupos) > 0
                SELECT CodGrupo FROM cursor_4c_DptGg ;
                       WHERE !EMPTY(CodGrupo) ;
                       GROUP BY CodGrupo ;
                       HAVING COUNT(*) > 1 ;
                       INTO CURSOR cursor_4c_Duplicas

                loc_nDuplic = RECCOUNT("cursor_4c_Duplicas")
                IF USED("cursor_4c_Duplicas")
                    USE IN cursor_4c_Duplicas
                ENDIF

                IF loc_nDuplic > 0
                    loc_lValido = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarGruposDuplicados:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarAutomatico - Verifica se ja existe outro departamento automatico
    * par_cCodIgnorar: codigo do registro atual (para excluir da verificacao)
    *--------------------------------------------------------------------------
    FUNCTION ValidarAutomatico(par_cCodIgnorar)
        LOCAL loc_lValido, loc_cSQL, loc_nResultado, loc_nTotal
        loc_lValido = .T.

        TRY
            IF THIS.this_nAutos = 1
                loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDpt WHERE autos = 1"
                IF VARTYPE(par_cCodIgnorar) = "C" AND !EMPTY(par_cCodIgnorar)
                    loc_cSQL = loc_cSQL + ;
                        " AND codigos <> " + EscaparSQL(ALLTRIM(par_cCodIgnorar))
                ENDIF

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_AutoChk")
                    TABLEREVERT(.T., "cursor_4c_AutoChk")
                    USE IN cursor_4c_AutoChk
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AutoChk")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_AutoChk
                    loc_nTotal = cursor_4c_AutoChk.Total
                    IF loc_nTotal > 0
                        loc_lValido = .F.
                    ENDIF
                ELSE
                    MsgErro("Erro ao verificar automatico:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_AutoChk")
                    USE IN cursor_4c_AutoChk
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarAutomatico:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDepartamentoEmUso - Verifica se o depto esta vinculado a usuarios
    *--------------------------------------------------------------------------
    FUNCTION ValidarDepartamentoEmUso(par_cCodigo)
        LOCAL loc_lEmUso, loc_cSQL, loc_nResultado, loc_nTotal
        loc_lEmUso = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdUsu" + ;
                       " WHERE deptos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_UsoChk")
                TABLEREVERT(.T., "cursor_4c_UsoChk")
                USE IN cursor_4c_UsoChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsoChk")
            IF loc_nResultado >= 0
                SELECT cursor_4c_UsoChk
                loc_nTotal = cursor_4c_UsoChk.Total
                IF loc_nTotal > 0
                    loc_lEmUso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao verificar uso do departamento:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UsoChk")
                USE IN cursor_4c_UsoChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarDepartamentoEmUso:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lEmUso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCodigoExistente - Verifica se o codigo ja existe na tabela
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigoExistente(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResultado, loc_nTotal
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDpt" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_CodChk")
                TABLEREVERT(.T., "cursor_4c_CodChk")
                USE IN cursor_4c_CodChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodChk")
            IF loc_nResultado >= 0
                SELECT cursor_4c_CodChk
                loc_nTotal = cursor_4c_CodChk.Total
                IF loc_nTotal > 0
                    loc_lExiste = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao verificar codigo:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_CodChk")
                USE IN cursor_4c_CodChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarCodigoExistente:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE
