*==============================================================================
* FpdBO.PRG
* Business Object para Condicoes de Pagamento por Tabela de Desconto (SIGCDFPD)
*
* Tabela Principal : SigOpFpd - Condicoes de pagamento por tabela
*                               (cidchaves char(20), fpags char(12),
*                                nparcs numeric(2), tabds char(10))
* Tabela Lookup    : SigOpFp  - Cadastro de condicoes de pagamento
*                               (fpags char(12), descrs char(30))
*
* Logica: Gerencia colecao de condicoes de pagamento vinculadas a uma
*         tabela de desconto (TabDs). Salvar = DELETE all for TabDs
*         + re-INSERT from cursor crSigOpFpD.
*==============================================================================

DEFINE CLASS FpdBO AS BusinessBase

    *-- Campos de SigOpFpd
    this_cCidChaves = ""    && cidchaves CHAR(20) - chave unica (PK)
    this_nNParcs    = 0     && nparcs    NUMERIC(2,0) - numero de parcelas
    this_cFpags     = ""    && fpags     CHAR(12) - codigo condicao de pagamento
    this_cTabDs     = ""    && tabds     CHAR(10) - discriminador (chave do parent)

    *-- Cursor de dados da grade (nome legado obrigatorio - FRX/grid referencia este nome)
    this_cCursorDados = "crSigOpFpD"

    *-- Cursor de lookup para condicoes de pagamento
    this_cCursorLookup = "LocalFpag"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpFpd"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega registros de SigOpFpd com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT cidchaves, fpags, nparcs, tabds FROM SigOpFpd"
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT cidchaves, fpags, nparcs, tabds FROM SigOpFpd" + ;
                       " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpdCarga")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_FpdCarga") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_FpdCarga")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_FpdCarga")
            USE IN cursor_4c_FpdCarga
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cFpags     = TratarNulo(fpags, "C")
            THIS.this_nNParcs    = TratarNulo(nparcs, "N")
            THIS.this_cTabDs     = TratarNulo(tabds, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigOpFpd (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigOpFpd (cidchaves, fpags, nparcs, tabds)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNParcs) + ", " + ;
                       EscaparSQL(THIS.this_cTabDs) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigOpFpd (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigOpFpd SET " + ;
                       "fpags = " + EscaparSQL(THIS.this_cFpags) + ", " + ;
                       "nparcs = " + FormatarNumeroSQL(THIS.this_nNParcs) + ", " + ;
                       "tabds = " + EscaparSQL(THIS.this_cTabDs) + ;
                       " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigOpFpd (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigOpFpd WHERE RTRIM(cidchaves) = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosGrid - Carrega crSigOpFpD do servidor para o TabDs informado
    * Cria cursor editavel local a partir dos dados do SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosGrid(par_cTabDs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crSigOpFpD")
                USE IN crSigOpFpD
            ENDIF
            IF USED("cursor_4c_FpdLoad")
                USE IN cursor_4c_FpdLoad
            ENDIF

            loc_cSQL = "SELECT cidchaves, fpags, nparcs, tabds FROM SigOpFpd" + ;
                       " WHERE RTRIM(tabds) = " + EscaparSQL(ALLTRIM(par_cTabDs))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FpdLoad")

            IF loc_nResult >= 0
                SET NULL ON
                CREATE CURSOR crSigOpFpD (cidchaves C(20), fpags C(12), nparcs N(2,0), tabds C(10))
                SET NULL OFF

                IF RECCOUNT("cursor_4c_FpdLoad") > 0
                    APPEND FROM DBF("cursor_4c_FpdLoad")
                ENDIF

                IF USED("cursor_4c_FpdLoad")
                    USE IN cursor_4c_FpdLoad
                ENDIF

                GO TOP IN crSigOpFpD
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar dados da grade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLookupFpag - Carrega LocalFpag de SigOpFp indexado por fpags
    * Necessario para validacao/busca na Column1 da grade
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLookupFpag()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("LocalFpag")
                USE IN LocalFpag
            ENDIF

            loc_cSQL = "SELECT fpags, descrs FROM SigOpFp ORDER BY fpags"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalFpag")

            IF loc_nResult >= 0
                SELECT LocalFpag
                INDEX ON ALLTRIM(fpags) TAG fpags
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lookup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFpags - Verifica se codigo Fpags existe em LocalFpag
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFpags(par_cFpags)
        LOCAL loc_lValido
        loc_lValido = .F.
        IF USED("LocalFpag") AND !EMPTY(par_cFpags)
            loc_lValido = SEEK(ALLTRIM(par_cFpags), "LocalFpag", "fpags")
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGrid - Persiste grade crSigOpFpD no servidor para o TabDs dado
    * Logica: limpa vazios -> valida duplicatas -> DELETE all -> INSERT batch
    * Retorna .T. se gravado, .F. se duplicata detectada ou erro
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGrid(par_cTabDs)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nCount
        LOCAL loc_cChave, loc_cFpags, loc_nNParcs
        loc_lSucesso = .F.

        IF !USED("crSigOpFpD")
            MsgErro("Cursor crSigOpFpD nao encontrado.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- Passo 1: Remover linhas com Fpags ou nParcs vazios
            SELECT crSigOpFpD
            DELETE FOR EMPTY(ALLTRIM(fpags))
            DELETE FOR EMPTY(nparcs)
            PACK

            *-- Passo 2: Atribuir cidchaves para registros sem chave unica
            SELECT crSigOpFpD
            GO TOP
            DO WHILE !EOF()
                IF EMPTY(ALLTRIM(cidchaves))
                    REPLACE cidchaves WITH LEFT(PADL(TRANSFORM(RECNO()), 10, "0") + SYS(2015), 20)
                ENDIF
                SKIP
            ENDDO

            *-- Passo 3: Verificar duplicatas (fpags + nparcs) - logica do legado
            SELECT fpags, nparcs, SUM(1) AS TT ;
                FROM crSigOpFpD ;
                GROUP BY 1, 2 ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_FpdDupls READWRITE
            loc_nCount = RECCOUNT("cursor_4c_FpdDupls")
            IF USED("cursor_4c_FpdDupls")
                USE IN cursor_4c_FpdDupls
            ENDIF

            IF loc_nCount > 0
                MsgAviso("Dados em duplicidade! Verifique a grade antes de salvar.", "Duplicidade")
            ELSE
                *-- Passo 4: DELETE todos os registros existentes para TabDs
                loc_cSQL = "DELETE FROM SigOpFpd WHERE RTRIM(tabds) = " + ;
                           EscaparSQL(ALLTRIM(par_cTabDs))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    *-- Passo 5: INSERT cada linha valida do cursor
                    loc_lSucesso = .T.
                    SELECT crSigOpFpD
                    GO TOP
                    DO WHILE !EOF() AND loc_lSucesso
                        loc_cChave  = ALLTRIM(cidchaves)
                        loc_cFpags  = ALLTRIM(fpags)
                        loc_nNParcs = nparcs

                        IF !EMPTY(loc_cFpags)
                            loc_cSQL = "INSERT INTO SigOpFpd (cidchaves, fpags, nparcs, tabds)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cChave) + ", " + ;
                                       EscaparSQL(loc_cFpags) + ", " + ;
                                       FormatarNumeroSQL(loc_nNParcs) + ", " + ;
                                       EscaparSQL(ALLTRIM(par_cTabDs)) + ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResult < 0
                                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                        ENDIF

                        SKIP
                    ENDDO

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir registros antigos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursores - Fecha cursores abertos pelo BO (chamado no Destroy do Form)
    *--------------------------------------------------------------------------
    PROCEDURE FecharCursores()
        IF USED("crSigOpFpD")
            USE IN crSigOpFpD
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("LocalFpag")
            USE IN LocalFpag
        ENDIF
    ENDPROC

ENDDEFINE
