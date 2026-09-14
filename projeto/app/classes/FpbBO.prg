*==============================================================================
* FpbBO.prg - Business Object: Cadastro de BIN
* Tabela: SigOpFpb
* PK: cidchaves char(20)
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS FpbBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Chave Primaria
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""    && cidchaves char(20) - PK tecnica (auto-gerada)

    *--------------------------------------------------------------------------
    * Propriedades - Campos da tabela SigOpFpb
    *--------------------------------------------------------------------------
    this_cCodBins    = ""    && codbins   char(6)      - codigo BIN
    this_cDescs      = ""    && descs     char(30)     - descricao
    this_dDataIs     = {}    && datais    datetime NULL - validade de
    this_dDataFs     = {}    && datafs    datetime NULL - validade ate
    this_cFpags      = ""    && fpags     char(12)     - FK condicao de pagamento

    *--------------------------------------------------------------------------
    * Propriedades de controle
    *--------------------------------------------------------------------------
    this_lGravaDados = .F.   && indica se houve alteracao nos dados do grid

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpFpb"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cCodBins   = TratarNulo(codbins,   "C")
                THIS.this_cDescs     = TratarNulo(descs,     "C")
                THIS.this_dDataIs    = IIF(ISNULL(datais), {}, IIF(VARTYPE(datais) = "T", TTOD(datais), datais))
                THIS.this_dDataFs    = IIF(ISNULL(datafs), {}, IIF(VARTYPE(datafs) = "T", TTOD(datafs), datafs))
                THIS.this_cFpags     = TratarNulo(fpags,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCodBins)
            MsgAviso("C" + CHR(243) + "digo BIN " + CHR(233) + ;
                " " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cFpags)
            MsgAviso("Condi" + CHR(231) + CHR(227) + "o de pagamento " + CHR(233) + ;
                " obrigat" + CHR(243) + "ria.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo BIN no banco de dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarDados()
                THIS.this_cCidChaves = THIS.GerarChavePrimaria()

                loc_cSQL = "INSERT INTO SigOpFpb " + ;
                           "(cidchaves, codbins, descs, datais, datafs, fpags) " + ;
                           "VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves)    + ", " + ;
                           EscaparSQL(THIS.this_cCodBins)      + ", " + ;
                           EscaparSQL(THIS.this_cDescs)        + ", " + ;
                           FormatarDataSQL(THIS.this_dDataIs)  + ", " + ;
                           FormatarDataSQL(THIS.this_dDataFs)  + ", " + ;
                           EscaparSQL(THIS.this_cFpags)        + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir BIN no banco de dados.", "FpbBO.Inserir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza BIN existente no banco de dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigOpFpb SET " + ;
                           "codbins = " + EscaparSQL(THIS.this_cCodBins)     + ", " + ;
                           "descs   = " + EscaparSQL(THIS.this_cDescs)       + ", " + ;
                           "datais  = " + FormatarDataSQL(THIS.this_dDataIs) + ", " + ;
                           "datafs  = " + FormatarDataSQL(THIS.this_dDataFs) + ", " + ;
                           "fpags   = " + EscaparSQL(THIS.this_cFpags)       + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    THIS.RegistrarAuditoria("A")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar BIN no banco de dados.", "FpbBO.Atualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui BIN do banco de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigOpFpb " + ;
                       "WHERE fpags = " + EscaparSQL(THIS.this_cFpags)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir BIN do banco de dados.", "FpbBO.ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBINs - Carrega BINs de uma condicao de pagamento em cursor local
    *--------------------------------------------------------------------------
    FUNCTION CarregarBINs(par_cFpags)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BINs")
                USE IN cursor_4c_BINs
            ENDIF
            IF USED("cursor_4c_BINsTemp")
                USE IN cursor_4c_BINsTemp
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_BINs ( ;
                cidchaves C(20) NULL, ;
                codbins   C(6)  NULL, ;
                descs     C(30) NULL, ;
                datais    T     NULL, ;
                datafs    T     NULL, ;
                fpags     C(12) NULL  ;
            )
            SET NULL OFF

            loc_cSQL = "SELECT cidchaves, codbins, descs, datais, datafs, fpags " + ;
                       "FROM SigOpFpb " + ;
                       "WHERE fpags = " + EscaparSQL(par_cFpags) + ;
                       " ORDER BY codbins"

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BINsTemp")

            IF USED("cursor_4c_BINsTemp")
                SELECT cursor_4c_BINs
                APPEND FROM DBF("cursor_4c_BINsTemp")
                USE IN cursor_4c_BINsTemp
            ENDIF

            SELECT cursor_4c_BINs
            INDEX ON codbins TAG codbins
            SET ORDER TO
            GOTO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.CarregarBINs")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicidade - Verifica se ha codbins duplicados no cursor
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicidade(par_cCursorBINs)
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.
        TRY
            IF USED(par_cCursorBINs)
                IF USED("cursor_4c_DupBINs")
                    USE IN cursor_4c_DupBINs
                ENDIF

                SELECT codbins, SUM(1) AS nQtd ;
                    FROM (par_cCursorBINs) ;
                    WHERE !EMPTY(codbins) ;
                    GROUP BY codbins ;
                    HAVING SUM(1) > 1 ;
                    INTO CURSOR cursor_4c_DupBINs READWRITE

                IF RECCOUNT("cursor_4c_DupBINs") > 0
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_DupBINs")
                    USE IN cursor_4c_DupBINs
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.ValidarDuplicidade")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarBINs - Exclui BINs antigos e reinsere todos do cursor local
    *--------------------------------------------------------------------------
    FUNCTION SalvarBINs(par_cFpags, par_cCursorBINs)
        LOCAL loc_lSucesso, loc_lErroInsert, loc_cSQL, loc_cChave, loc_oErro
        loc_lSucesso    = .F.
        loc_lErroInsert = .F.
        TRY
            IF THIS.ValidarDuplicidade(par_cCursorBINs)
                loc_cSQL = "DELETE FROM SigOpFpb WHERE fpags = " + EscaparSQL(par_cFpags)
                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    IF USED(par_cCursorBINs)
                        SELECT (par_cCursorBINs)
                        GOTO TOP
                        SCAN WHILE !loc_lErroInsert
                            IF !EMPTY(codbins)
                                loc_cChave = THIS.GerarChavePrimaria()

                                loc_cSQL = "INSERT INTO SigOpFpb " + ;
                                           "(cidchaves, codbins, descs, datais, datafs, fpags) " + ;
                                           "VALUES (" + ;
                                           EscaparSQL(loc_cChave)   + ", " + ;
                                           EscaparSQL(codbins)       + ", " + ;
                                           EscaparSQL(descs)         + ", " + ;
                                           FormatarDataSQL(datais)   + ", " + ;
                                           FormatarDataSQL(datafs)   + ", " + ;
                                           EscaparSQL(par_cFpags)    + ")"

                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                                    MsgErro("Erro ao salvar BIN: " + ALLTRIM(codbins), ;
                                        "FpbBO.SalvarBINs")
                                    loc_lErroInsert = .T.
                                ENDIF
                            ENDIF
                        ENDSCAN
                        loc_lSucesso = !loc_lErroInsert
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir BINs anteriores da condi" + CHR(231) + CHR(227) + ;
                        "o de pagamento.", "FpbBO.SalvarBINs")
                ENDIF
            ELSE
                MsgAviso("Dados inconsistentes. C" + CHR(243) + "digo BIN em duplicidade!!!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FpbBO.SalvarBINs")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChavePrimaria - Gera chave unica de 20 chars (substitui fUniqueIds)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChavePrimaria()
        LOCAL loc_cTs, loc_cRand, loc_cChave
        loc_cTs    = TTOC(DATETIME(), 1)
        loc_cRand  = TRANSFORM(INT(RAND() * 999999), "999999")
        loc_cChave = LEFT(loc_cTs + loc_cRand, 20)
        RETURN loc_cChave
    ENDFUNC

ENDDEFINE
