*==============================================================================
* FPPBO.prg - Business Object: Desconto por No. de Parcelas
* Tabela: SigOpFpp
* Herda de: BusinessBase
*
* Colunas SigOpFpp (schema.sql):
*   cidchaves  char(20)       - Chave unica PK (gerada por SYS(2015))
*   descs      numeric(5,2)   - % Desconto
*   fpags      char(12)       - Codigo da condicao de pagamento (FK SigOpFp)
*   nparcs     numeric(2,0)   - No. de parcelas
*   parcdes    numeric(1,0)   - Qtd parcelas de desconto (P)
*   valmins    numeric(11,2)  - Valor minimo
*   valmaxs    numeric(11,2)  - Valor maximo
*
* Cursor local de edicao: xFPagi (criado em CarregarDados, usado pelo Form)
* Salvar: DELETE FROM SigOpFpp + re-INSERT linha a linha via SQLEXEC
*==============================================================================

DEFINE CLASS FPPBO AS BusinessBase

    this_cTabela      = "SigOpFpp"
    this_cCampoChave  = "cidchaves"

    *-- Props de SigOpFpp
    this_cFpags       = ""   && fpags char(12)
    this_nNparcs      = 0    && nparcs numeric(2,0)
    this_nDescs       = 0    && descs numeric(5,2)
    this_nValMins     = 0    && valmins numeric(11,2)
    this_nValMaxs     = 0    && valmaxs numeric(11,2)
    this_nParcDes     = 0    && parcdes numeric(1,0)
    this_cCidChaves   = ""   && cidchaves char(20)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigOpFpp"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia campos do cursor xFPagi para props do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cFpags     = TratarNulo(fpags,     "C")
            THIS.this_nNparcs    = TratarNulo(nparcs,    "N")
            THIS.this_nDescs     = TratarNulo(Descs,     "N")
            THIS.this_nValMins   = TratarNulo(ValMins,   "N")
            THIS.this_nValMaxs   = TratarNulo(ValMaxs,   "N")
            THIS.this_nParcDes   = TratarNulo(parcDes,   "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma linha individual em SigOpFpp
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSql, loc_cChave

        loc_lSucesso = .F.

        TRY
            loc_cChave           = SYS(2015)
            THIS.this_cCidChaves = loc_cChave

            loc_cSql = "INSERT INTO SigOpFpp " + ;
                       "(cidchaves, fpags, nparcs, descs, valmins, valmaxs, parcdes) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNparcs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDescs,  2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValMins, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValMaxs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nParcDes, 0) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSql) < 1
                MsgErro("Erro ao inserir registro em SigOpFpp.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * CarregarDados - carrega registros de SigOpFpp para cursor local xFPagi
    * par_cFpags: codigo da condicao de pagamento (SigOpFp.fpags)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro, loc_cSql

        loc_lSucesso = .F.

        TRY
            IF USED("xFPagi")
                USE IN xFPagi
            ENDIF

            SET NULL ON
            CREATE CURSOR xFPagi (;
                fpags     C(12)   NULL, ;
                nparcs    N(2,0)  NULL, ;
                Descs     N(5,2)  NULL, ;
                ValMins   N(11,2) NULL, ;
                ValMaxs   N(11,2) NULL, ;
                parcDes   N(1,0)  NULL, ;
                cidchaves C(20)   NULL  ;
            )
            SET NULL OFF

            loc_cSql = "SELECT fpags, nparcs, descs, valmins, valmaxs, parcdes, cidchaves " + ;
                       "FROM SigOpFpp " + ;
                       "WHERE fpags = " + EscaparSQL(par_cFpags) + " " + ;
                       "ORDER BY nparcs"

            IF SQLEXEC(gnConnHandle, loc_cSql, "xFPagiTemp") > 0
                SELECT xFPagi
                ZAP
                APPEND FROM DBF("xFPagiTemp")
                IF USED("xFPagiTemp")
                    USE IN xFPagiTemp
                ENDIF
            ENDIF

            SELECT xFPagi
            IF RECCOUNT() > 0
                INDEX ON nparcs TAG nparcs
                SET ORDER TO
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao carregar dados")
            *-- Cursor foi criado antes do SQLEXEC: form pode instanciar com grid vazio
            loc_lSucesso = USED("xFPagi")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinha - adiciona nova linha vazia no cursor local xFPagi
    * par_cFpags: codigo da condicao de pagamento para preencher fpags
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinha(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("xFPagi")
                SELECT xFPagi
                INSERT INTO xFPagi ;
                    (fpags, nparcs, Descs, ValMins, ValMaxs, parcDes, cidchaves) ;
                    VALUES (par_cFpags, 0, 0, 0, 0, 0, "")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao inserir linha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinha - remove linha atual do cursor local xFPagi
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinha()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("xFPagi") AND NOT EOF("xFPagi")
                SELECT xFPagi
                DELETE
                SKIP
                SKIP -1
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao excluir linha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAntesDeSalvar - verifica duplicidade nparcs+descs em xFPagi
    * Retorna .T. se os dados sao validos para gravar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarAntesDeSalvar()
        LOCAL loc_lValido, loc_lDuplic

        loc_lValido = .T.

        IF USED("xFPagi")
            SELECT nparcs, Descs, SUM(1) AS nQtd ;
                FROM xFPagi ;
                WHERE nparcs > 0 AND (Descs > 0 OR parcDes > 0) ;
                GROUP BY nparcs, Descs ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_DupCheck READWRITE

            loc_lDuplic = (RECCOUNT("cursor_4c_DupCheck") > 0)

            IF USED("cursor_4c_DupCheck")
                USE IN cursor_4c_DupCheck
            ENDIF

            IF loc_lDuplic
                MsgAviso("Dados Inconsistentes. No. de Parcelas/% Desconto em duplicidade!!!", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarDados - persiste cursor local xFPagi em SigOpFpp via SQLEXEC
    * par_cFpags: codigo da condicao de pagamento
    * Fluxo: valida -> DELETE FROM SigOpFpp -> re-INSERT linha a linha
    *--------------------------------------------------------------------------
    PROCEDURE SalvarDados(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro, loc_cSql, loc_cChave, loc_lErroInsert

        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarAntesDeSalvar()

                *-- Remove todos os registros anteriores desta condicao de pagamento
                loc_cSql = "DELETE FROM SigOpFpp WHERE fpags = " + EscaparSQL(par_cFpags)

                IF SQLEXEC(gnConnHandle, loc_cSql) < 1
                    MsgErro("Erro ao remover registros de SigOpFpp.", "Erro")
                ELSE
                    *-- Re-insere a partir do cursor local xFPagi
                    loc_lErroInsert = .F.

                    IF USED("xFPagi")
                        SELECT xFPagi
                        GO TOP
                        SCAN WHILE !loc_lErroInsert
                            IF !EMPTY(xFPagi.nparcs) AND ;
                               (!EMPTY(xFPagi.Descs) OR !EMPTY(xFPagi.parcDes))

                                loc_cChave = SYS(2015)

                                loc_cSql = "INSERT INTO SigOpFpp " + ;
                                           "(cidchaves, fpags, nparcs, descs, " + ;
                                           " valmins, valmaxs, parcdes) " + ;
                                           "VALUES (" + ;
                                           EscaparSQL(loc_cChave) + ", " + ;
                                           EscaparSQL(xFPagi.fpags) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.nparcs,  0) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.Descs,   2) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.ValMins, 2) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.ValMaxs, 2) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.parcDes, 0) + ")"

                                IF SQLEXEC(gnConnHandle, loc_cSql) < 1
                                    MsgErro("Erro ao inserir linha em SigOpFpp." + CHR(13) + ;
                                            "Parcelas: " + TRANSFORM(xFPagi.nparcs), "Erro")
                                    loc_lErroInsert = .T.
                                ENDIF
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF !loc_lErroInsert
                        THIS.RegistrarAuditoria("SALVAR")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao salvar dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSql, loc_oErro

        TRY
            loc_cSql = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Tabela, Operacao, ChaveRegistro, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL(THIS.this_cTabela) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSql)
        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE
