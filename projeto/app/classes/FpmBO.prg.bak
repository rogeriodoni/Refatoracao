*------------------------------------------------------------------------------
* FpmBO.prg - Business Object para Valores Min/Max de Condicao de Pagamento
* Tabela: SigOpFpi
* Origem: SIGCDFPM.SCX (sub-form de SigCdFpm)
*------------------------------------------------------------------------------

DEFINE CLASS FpmBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela     = "SigOpFpi"
    this_cCampoChave = "fpags"

    *-- Campos de SigOpFpi
    this_cFpags      = ""  && char(12) - codigo da condicao de pagamento (FK)
    this_nNparcs     = 0   && numeric(2,0) - numero de parcelas
    this_nValmins    = 0   && numeric(11,2) - valor minimo
    this_nValmaxs    = 0   && numeric(11,2) - valor maximo
    this_cEmps       = ""  && char(3) - codigo da empresa

    *-- Contexto de edicao (recebido do form pai via parametro)
    this_cFpagsAtual = ""  && fpags da condicao em edicao (filtro do SQLEXEC)

    PROCEDURE Init()
        THIS.this_cTabela     = "SigOpFpi"
        THIS.this_cCampoChave = "fpags"
        RETURN DODEFAULT()
    ENDPROC

    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cFpags
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorCondicao - Carrega registros de SigOpFpi para cursor do grid
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorCondicao(par_cFpags)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_FpagI")
                TABLEREVERT(.T., "cursor_4c_FpagI")
                USE IN cursor_4c_FpagI
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_FpagI ;
                (fpags    C(12) NULL, ;
                 nparcs   N(2,0) NULL, ;
                 valmins  N(11,2) NULL, ;
                 valmaxs  N(11,2) NULL, ;
                 emps     C(3) NULL)
            SET NULL OFF

            INDEX ON fpags + STR(nparcs, 2) TAG fpags
            INDEX ON nparcs TAG nparcs
            SET ORDER TO

            loc_cSQL = "SELECT fpags, nparcs, valmins, valmaxs, emps " + ;
                       "FROM SigOpFpi " + ;
                       "WHERE fpags = " + EscaparSQL(par_cFpags) + ;
                       " ORDER BY nparcs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpagITemp") > 0
                SELECT cursor_4c_FpagI
                APPEND FROM DBF("cursor_4c_FpagITemp")
                IF USED("cursor_4c_FpagITemp")
                    USE IN cursor_4c_FpagITemp
                ENDIF
                SELECT cursor_4c_FpagI
                SET ORDER TO
                GO TOP
                THIS.this_cFpagsAtual = par_cFpags
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_FpagITemp")
                    USE IN cursor_4c_FpagITemp
                ENDIF
                MsgErro("Falha ao carregar parcelas da condi" + CHR(231) + CHR(227) + "o de pagamento.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BuscarPorCondicao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinha - Insere nova linha em branco no cursor local do grid
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinha(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED("cursor_4c_FpagI")
            MsgAviso("Cursor de parcelas n" + CHR(227) + "o inicializado.", "Aviso")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT cursor_4c_FpagI
            INSERT INTO cursor_4c_FpagI (fpags, nparcs, valmins, valmaxs, emps) ;
                VALUES (par_cFpags, 0, 0, 0, "")
            GO BOTTOM
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InserirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinha - Marca linha corrente para exclusao no cursor local
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinha()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED("cursor_4c_FpagI")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT cursor_4c_FpagI
            IF !EOF()
                DELETE
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ExcluirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteNparcs - Verifica se numero de parcelas ja existe no cursor local
    * Usado pelo form para validacao inline na grade
    *--------------------------------------------------------------------------
    PROCEDURE ExisteNparcs(par_nNparcs)
        LOCAL loc_lExiste, loc_nRecNoAtual
        loc_lExiste = .F.

        IF !USED("cursor_4c_FpagI") OR par_nNparcs <= 0
            RETURN loc_lExiste
        ENDIF

        SELECT cursor_4c_FpagI
        loc_nRecNoAtual = RECNO("cursor_4c_FpagI")

        SET ORDER TO fpags
        IF SEEK(cursor_4c_FpagI.fpags + STR(par_nNparcs, 2), "cursor_4c_FpagI", "fpags")
            SKIP
            IF !EOF("cursor_4c_FpagI")
                IF cursor_4c_FpagI.fpags + STR(cursor_4c_FpagI.nparcs, 2) = ;
                   cursor_4c_FpagI.fpags + STR(par_nNparcs, 2)
                    loc_lExiste = .T.
                ENDIF
            ENDIF
        ENDIF

        SET ORDER TO
        IF loc_nRecNoAtual > 0
            GO (loc_nRecNoAtual) IN cursor_4c_FpagI
        ELSE
            GO BOTTOM IN cursor_4c_FpagI
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConsistencia - Valida duplicidade de nparcs antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConsistencia()
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.

        IF !USED("cursor_4c_FpagI")
            RETURN loc_lValido
        ENDIF

        TRY
            SELECT nparcs, SUM(1) AS nTotal ;
                FROM cursor_4c_FpagI ;
                WHERE (nparcs > 0 OR valmaxs > 0) AND !DELETED() ;
                GROUP BY nparcs ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_ValidTT READWRITE

            IF RECCOUNT("cursor_4c_ValidTT") > 0
                MsgAviso("Dados Inconsistentes!!! N" + CHR(250) + "mero de parcelas duplicado.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF

            IF USED("cursor_4c_ValidTT")
                USE IN cursor_4c_ValidTT
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarConsistencia")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Persiste cursor local no SQL Server
    * Delete todos registros existentes e reinsere do cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAlteracoes(par_cFpags)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cFpags, loc_nNparcs, loc_nValmins, loc_nValmaxs, loc_cEmps
        loc_lSucesso = .F.

        IF !USED("cursor_4c_FpagI")
            MsgAviso("Cursor de parcelas n" + CHR(227) + "o inicializado.", "Aviso")
            RETURN loc_lSucesso
        ENDIF

        TRY
            *-- Deletar registros existentes para esta condicao de pagamento
            loc_cSQL = "DELETE FROM SigOpFpi WHERE fpags = " + EscaparSQL(par_cFpags)
            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Falha ao remover parcelas anteriores.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF

            *-- Reinserir do cursor local (apenas linhas validas: nparcs != 0 OU valmaxs != 0)
            IF loc_lSucesso
                SELECT cursor_4c_FpagI
                GO TOP
                DO WHILE !EOF() AND loc_lSucesso
                    IF !DELETED() AND (!EMPTY(cursor_4c_FpagI.nparcs) OR !EMPTY(cursor_4c_FpagI.valmaxs))
                        loc_cFpags   = cursor_4c_FpagI.fpags
                        loc_nNparcs  = cursor_4c_FpagI.nparcs
                        loc_nValmins = cursor_4c_FpagI.valmins
                        loc_nValmaxs = cursor_4c_FpagI.valmaxs
                        loc_cEmps    = cursor_4c_FpagI.emps

                        loc_cSQL = "INSERT INTO SigOpFpi " + ;
                                   "(fpags, nparcs, valmins, valmaxs, emps) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cFpags) + ", " + ;
                                   FormatarNumeroSQL(loc_nNparcs, 0) + ", " + ;
                                   FormatarNumeroSQL(loc_nValmins, 2) + ", " + ;
                                   FormatarNumeroSQL(loc_nValmaxs, 2) + ", " + ;
                                   EscaparSQL(loc_cEmps) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Falha ao inserir parcela nParcs=" + ;
                                    TRANSFORM(loc_nNparcs) + ".", "Erro")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                    SKIP
                ENDDO
            ENDIF

            IF loc_lSucesso
                THIS.RegistrarAuditoria("SALVAR")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SalvarAlteracoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cFpags  = TratarNulo(fpags, "C")
            THIS.this_nNparcs = TratarNulo(nparcs, "N")
            THIS.this_nValmins = TratarNulo(valmins, "N")
            THIS.this_nValmaxs = TratarNulo(valmaxs, "N")
            THIS.this_cEmps   = TratarNulo(emps, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *-- ValidarDados: validacao inline feita no grid; satisfaz cadeia BusinessBase
    PROTECTED PROCEDURE ValidarDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Persiste uma linha de SigOpFpi.
    * Usa propriedades this_c*/this_n* populadas previamente por
    * CarregarDoCursor ou FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpFpi " + ;
                       "(fpags, nparcs, valmins, valmaxs, emps) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNparcs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmins, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmaxs, 2) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("INSERIR")
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir parcela nParcs=" + ;
                                          TRANSFORM(THIS.this_nNparcs)
                MsgErro(THIS.this_cMensagemErro, "Erro em Inserir")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de SigOpFpi identificada por fpags+nparcs.
    * Usa propriedades this_n* populadas previamente por CarregarDoCursor ou
    * FormParaBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cFpags)
                THIS.this_cMensagemErro = "Chave fpags vazia."
                MsgErro(THIS.this_cMensagemErro, "Erro em Atualizar")
            ELSE
                loc_cSQL = "UPDATE SigOpFpi SET " + ;
                           "valmins = " + FormatarNumeroSQL(THIS.this_nValmins, 2) + ", " + ;
                           "valmaxs = " + FormatarNumeroSQL(THIS.this_nValmaxs, 2) + ", " + ;
                           "emps = " + EscaparSQL(THIS.this_cEmps) + " " + ;
                           "WHERE fpags = " + EscaparSQL(THIS.this_cFpags) + ;
                           " AND nparcs = " + FormatarNumeroSQL(THIS.this_nNparcs, 0)

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("ATUALIZAR")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar parcela fpags=" + ;
                                              ALLTRIM(THIS.this_cFpags)
                    MsgErro(THIS.this_cMensagemErro, "Erro em Atualizar")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove linha de SigOpFpi identificada por fpags+nparcs.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cFpags)
                THIS.this_cMensagemErro = "Chave fpags vazia."
                MsgErro(THIS.this_cMensagemErro, "Erro em ExecutarExclusao")
            ELSE
                loc_cSQL = "DELETE FROM SigOpFpi " + ;
                           "WHERE fpags = " + EscaparSQL(THIS.this_cFpags) + ;
                           " AND nparcs = " + FormatarNumeroSQL(THIS.this_nNparcs, 0)

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("EXCLUIR")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao excluir parcela fpags=" + ;
                                              ALLTRIM(THIS.this_cFpags)
                    MsgErro(THIS.this_cMensagemErro, "Erro em ExecutarExclusao")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
