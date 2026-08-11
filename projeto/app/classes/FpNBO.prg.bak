*====================================================================
* FpNBO.prg
*
* Business Object para Condicoes de Pagamento por Operacao
* Tabela: SigCdFpN (sigcdfpn)
* Schema: cidchaves char(20) PK, dopes char(20), fpags char(12)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS FpNBO AS BusinessBase

    *-- Campos de SigCdFpN (mapeamento direto com a tabela)
    this_cIdChaves = ""    && cidchaves char(20) - PK (chave unica)
    this_cDopes    = ""    && dopes char(20) - codigo da operacao (FK SigCdOpe)
    this_cFpags    = ""    && fpags char(12) - codigo da condicao de pagamento (FK SigOpFp)

    *-- Campo auxiliar de lookup (SigOpFp.descrs - nao armazenado em SigCdFpN)
    this_cDescrs   = ""    && descrs char(30) - descricao da condicao (SigOpFp)

    *-- Controle de estado operacional
    this_lGravaDados = .F. && .T. se houver alteracoes pendentes de gravacao

    *-- Cursores de trabalho
    this_cCursorOpe    = "cursor_4c_xOpe"        && cursor editavel do grid
    this_cCursorDados  = "cursor_4c_SigCdFpN"    && cursor de dados SQL Server

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFpN"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves = TratarNulo(cIdChaves, "C")
                THIS.this_cDopes    = TratarNulo(Dopes,     "C")
                THIS.this_cFpags    = TratarNulo(Fpags,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarCursorTrabalho - Cria cursor editavel para o grid
    * Estrutura identica ao cursor xOpe do legado
    *====================================================================
    PROCEDURE InicializarCursorTrabalho()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOpe)
                USE IN (THIS.this_cCursorOpe)
            ENDIF
            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorOpe) ;
                (Dopes C(20) NULL, Fpags C(12) NULL, Descrs C(30) NULL)
            SET NULL OFF
            INDEX ON Dopes TAG Dopes
            SET ORDER TO
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.InicializarCursorTrabalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarRegistros - Carrega SigCdFpN + descricao SigOpFp para o grid
    * par_cDopes = codigo da operacao (FK SigCdOpe.Dopes)
    *====================================================================
    PROCEDURE CarregarRegistros(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF !THIS.InicializarCursorTrabalho()
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "SELECT a.Dopes, a.Fpags, b.descrs " + ;
                       "FROM SigCdFpN a " + ;
                       "INNER JOIN SigOpFp b ON a.Fpags = b.Fpags " + ;
                       "WHERE a.Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpNTemp")
            IF loc_nRet < 1
                MsgAviso("Erro ao carregar condi" + CHR(231) + CHR(245) + ;
                    "es de pagamento para opera" + CHR(231) + CHR(227) + "o: " + ;
                    ALLTRIM(par_cDopes), "Aviso")
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorOpe)
            APPEND FROM DBF("cursor_4c_FpNTemp")

            IF USED("cursor_4c_FpNTemp")
                USE IN cursor_4c_FpNTemp
            ENDIF

            SELECT (THIS.this_cCursorOpe)
            SET ORDER TO
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            IF USED("cursor_4c_FpNTemp")
                USE IN cursor_4c_FpNTemp
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.CarregarRegistros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InserirLinhaVazia - Adiciona linha em branco no cursor de trabalho
    *====================================================================
    PROCEDURE InserirLinhaVazia()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOpe)
                SELECT (THIS.this_cCursorOpe)
                INSERT INTO (THIS.this_cCursorOpe) (Fpags) VALUES (SPACE(12))
                THIS.this_lGravaDados = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.InserirLinhaVazia")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirLinhaAtual - Exclui linha corrente do cursor de trabalho
    *====================================================================
    PROCEDURE ExcluirLinhaAtual()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOpe)
                SELECT (THIS.this_cCursorOpe)
                IF NOT EOF()
                    DELETE
                    SKIP
                    IF EOF()
                        GO BOTTOM
                    ENDIF
                    THIS.this_lGravaDados = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.ExcluirLinhaAtual")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDuplicatas - Verifica se ha condicoes de pagamento duplicadas
    * Retorna .T. se SEM duplicatas, .F. se houver
    *====================================================================
    FUNCTION ValidarDuplicatas()
        LOCAL loc_lValido, loc_nDupls
        loc_lValido = .T.
        TRY
            IF USED(THIS.this_cCursorOpe)
                SELECT Fpags, COUNT(*) AS Qt ;
                    FROM (THIS.this_cCursorOpe) ;
                    WHERE NOT DELETED() AND NOT EMPTY(ALLTRIM(Fpags)) ;
                    GROUP BY Fpags ;
                    HAVING COUNT(*) > 1 ;
                    INTO CURSOR cursor_4c_FpNDupl

                loc_nDupls = RECCOUNT("cursor_4c_FpNDupl")
                IF USED("cursor_4c_FpNDupl")
                    USE IN cursor_4c_FpNDupl
                ENDIF

                IF loc_nDupls > 0
                    MsgAviso("Existem lan" + CHR(231) + "amentos de Condi" + CHR(231) + ;
                        CHR(245) + "es Em Duplicidade!!!", ;
                        "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_FpNDupl")
                USE IN cursor_4c_FpNDupl
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.ValidarDuplicatas")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *====================================================================
    * ValidarLookupFpags - Valida codigo de condicao de pagamento no SQL Server
    * Retorna .T. se encontrado e preenche this_cDescrs
    *====================================================================
    FUNCTION ValidarLookupFpags(par_cFpags)
        LOCAL loc_lEncontrou, loc_cSQL, loc_nRet
        loc_lEncontrou = .F.
        TRY
            IF NOT EMPTY(ALLTRIM(par_cFpags))
                loc_cSQL = "SELECT TOP 1 Fpags, descrs FROM SigOpFp " + ;
                           "WHERE Fpags = " + EscaparSQL(ALLTRIM(par_cFpags))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpNLkp")
                IF loc_nRet >= 1 AND RECCOUNT("cursor_4c_FpNLkp") > 0
                    SELECT cursor_4c_FpNLkp
                    THIS.this_cFpags  = ALLTRIM(Fpags)
                    THIS.this_cDescrs = ALLTRIM(descrs)
                    loc_lEncontrou = .T.
                ENDIF
                IF USED("cursor_4c_FpNLkp")
                    USE IN cursor_4c_FpNLkp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_FpNLkp")
                USE IN cursor_4c_FpNLkp
            ENDIF
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.ValidarLookupFpags")
        ENDTRY
        RETURN loc_lEncontrou
    ENDFUNC

    *====================================================================
    * Inserir - Insere registro unico em SigCdFpN via SQLEXEC
    *====================================================================
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDopes)) OR EMPTY(ALLTRIM(THIS.this_cFpags))
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o e Condi" + CHR(231) + ;
                    CHR(227) + "o de Pagamento s" + CHR(227) + "o obrigat" + CHR(243) + "rios.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cIdChaves = LEFT(SYS(2015) + SYS(2015), 20)

            loc_cSQL = "INSERT INTO SigCdFpN (cIdChaves, Dopes, Fpags) VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cFpags)) + ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento.", "FpNBO.Inserir")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Atualizar - Atualiza registro unico em SigCdFpN via SQLEXEC
    *====================================================================
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDopes)) OR EMPTY(ALLTRIM(THIS.this_cFpags))
                MsgAviso("Registro n" + CHR(227) + "o identificado para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdFpN SET " + ;
                       "Fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFpags)) + " " + ;
                       "WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ;
                       " AND Fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFpags))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento.", "FpNBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - Exclui registro unico por chave primaria
    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cDopes)) OR EMPTY(ALLTRIM(THIS.this_cFpags))
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCdFpN WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ;
                       " AND Fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFpags))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento.", ;
                    "FpNBO.ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Salvar - Salva todas as condicoes de pagamento de uma operacao
    * Fluxo: validar duplicatas -> DELETE todos -> INSERT novos -> COMMIT
    * par_cDopes = codigo da operacao (FK SigCdOpe.Dopes)
    *====================================================================
    FUNCTION Salvar(par_cDopes)
        LOCAL loc_lSucesso, loc_nRet, loc_cSql, loc_cIdChaves, loc_cFpags
        loc_lSucesso = .F.
        TRY
            *-- 1. Validar duplicatas antes de qualquer operacao SQL
            IF NOT THIS.ValidarDuplicatas()
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Excluir todos os registros existentes para a operacao
            loc_cSql = "DELETE FROM SigCdFpN WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "")
            IF loc_nRet < 0
                MsgErro("Erro ao excluir registros anteriores de " + ALLTRIM(par_cDopes) + ".", ;
                    "FpNBO.Salvar")
                loc_lSucesso = .F.
            ENDIF

            *-- 3. Inserir registros nao-excluidos e nao-vazios do cursor de trabalho
            SELECT (THIS.this_cCursorOpe)
            SCAN FOR NOT DELETED() AND NOT EMPTY(ALLTRIM(Fpags))
                loc_cFpags    = ALLTRIM(Fpags)
                loc_cIdChaves = LEFT(SYS(2015) + SYS(2015), 20)

                loc_cSql = "INSERT INTO SigCdFpN (cIdChaves, Dopes, Fpags) VALUES (" + ;
                           EscaparSQL(loc_cIdChaves) + ", " + ;
                           EscaparSQL(ALLTRIM(par_cDopes)) + ", " + ;
                           EscaparSQL(loc_cFpags) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "")
                IF loc_nRet < 0
                    MsgErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o: " + loc_cFpags + ".", ;
                        "FpNBO.Salvar")
                    loc_lSucesso = .F.
                ENDIF

                SELECT (THIS.this_cCursorOpe)
            ENDSCAN

            *-- 4. Auditoria
            THIS.this_cDopes = ALLTRIM(par_cDopes)
            THIS.RegistrarAuditoria("ATUALIZAR")

            THIS.this_lGravaDados = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpNBO.Salvar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * Destroy - Libera cursores ao destruir o BO
    *====================================================================
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorOpe)
            USE IN (THIS.this_cCursorOpe)
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
