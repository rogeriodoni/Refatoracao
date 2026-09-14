*------------------------------------------------------------------------------
* IBPBO.prg - Business Object para SigCdIbp (Cadastro IBPT)
* Herda de BusinessBase
* Tabela: SigCdIbp / PK: cidchaves
*------------------------------------------------------------------------------

DEFINE CLASS IBPBO AS BusinessBase

    *-- Chave primaria
    this_cCidChaves  = ""   && char(20) NOT NULL

    *-- Campos da tabela SigCdIbp
    this_cUfs        = ""   && char(2)
    this_cCodigo     = ""   && char(10)
    this_cEx         = ""   && char(3)
    this_nTipo       = 0    && numeric(3,0)
    this_cDescricao  = ""   && text (memo)
    this_dDatIni     = {}   && datetime
    this_dDatFin     = {}   && datetime
    this_nNacFederal = 0    && numeric(5,2)
    this_nImpFederal = 0    && numeric(5,2)
    this_nEstadual   = 0    && numeric(5,2)
    this_nMunicipal  = 0    && numeric(5,2)
    this_cChave      = ""   && char(10)
    this_cVersao     = ""   && char(10)
    this_cFonte      = ""   && char(10)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigCdIbp"
        THIS.this_cCampoChave  = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtro opcional; cursor_4c_Dados para o grid
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cidchaves C(20), ufs C(2), codigo C(10), ;
                        ex C(3), tipo N(3,0), descricao M, ;
                        datini T, datfin T, nacfederal N(5,2), impfederal N(5,2), ;
                        estadual N(5,2), municipal N(5,2), chave C(10), versao C(10), fonte C(10))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF TYPE("par_cFiltro") = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                    loc_cWhere = " WHERE " + par_cFiltro
                ELSE
                    loc_cWhere = ""
                ENDIF

                loc_cSQL = "SELECT cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                           " datini, datfin, nacfederal, impfederal, estadual," + ;
                           " municipal, chave, versao, fonte" + ;
                           " FROM SigCdIbp" + ;
                           loc_cWhere + ;
                           " ORDER BY ufs, codigo, versao"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Dados")
                    TABLEREVERT(.T., "cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar registros IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT por cidchaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       " datini, datfin, nacfederal, impfederal, estadual," + ;
                       " municipal, chave, versao, fonte" + ;
                       " FROM SigCdIbp" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            TRY
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cUfs        = TratarNulo(ufs,        "C")
                THIS.this_cCodigo     = TratarNulo(codigo,     "C")
                THIS.this_cEx         = TratarNulo(ex,         "C")
                THIS.this_nTipo       = TratarNulo(tipo,       "N")
                THIS.this_cDescricao  = TratarNulo(descricao,  "C")
                THIS.this_dDatIni     = TratarNulo(datini,     "D")
                THIS.this_dDatFin     = TratarNulo(datfin,     "D")
                THIS.this_nNacFederal = TratarNulo(nacfederal, "N")
                THIS.this_nImpFederal = TratarNulo(impfederal, "N")
                THIS.this_nEstadual   = TratarNulo(estadual,   "N")
                THIS.this_nMunicipal  = TratarNulo(municipal,  "N")
                THIS.this_cChave      = TratarNulo(chave,      "C")
                THIS.this_cVersao     = TratarNulo(versao,     "C")
                THIS.this_cFonte      = TratarNulo(fonte,      "C")
                loc_lSucesso = .T.
            CATCH TO loException
                MsgErro("Erro em IBPBO.CarregarDoCursor:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro via CRUD standard
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCidChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdIbp" + ;
                       " (cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       "  datini, datfin, nacfederal, impfederal," + ;
                       "  estadual, municipal, chave, versao, fonte)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cUfs) + "," + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cEx) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTipo) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       FormatarDataSQL(THIS.this_dDatIni) + "," + ;
                       FormatarDataSQL(THIS.this_dDatFin) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNacFederal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nImpFederal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEstadual) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMunicipal) + "," + ;
                       EscaparSQL(THIS.this_cChave) + "," + ;
                       EscaparSQL(THIS.this_cVersao) + "," + ;
                       EscaparSQL(THIS.this_cFonte) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE pelo cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdIbp SET" + ;
                       " ufs        = " + EscaparSQL(THIS.this_cUfs) + "," + ;
                       " codigo     = " + EscaparSQL(THIS.this_cCodigo) + "," + ;
                       " ex         = " + EscaparSQL(THIS.this_cEx) + "," + ;
                       " tipo       = " + FormatarNumeroSQL(THIS.this_nTipo) + "," + ;
                       " descricao  = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " datini     = " + FormatarDataSQL(THIS.this_dDatIni) + "," + ;
                       " datfin     = " + FormatarDataSQL(THIS.this_dDatFin) + "," + ;
                       " nacfederal = " + FormatarNumeroSQL(THIS.this_nNacFederal) + "," + ;
                       " impfederal = " + FormatarNumeroSQL(THIS.this_nImpFederal) + "," + ;
                       " estadual   = " + FormatarNumeroSQL(THIS.this_nEstadual) + "," + ;
                       " municipal  = " + FormatarNumeroSQL(THIS.this_nMunicipal) + "," + ;
                       " chave      = " + EscaparSQL(THIS.this_cChave) + "," + ;
                       " versao     = " + EscaparSQL(THIS.this_cVersao) + "," + ;
                       " fonte      = " + EscaparSQL(THIS.this_cFonte) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE pelo cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdIbp" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarPlanilha - Importa dados IBPT de arquivos CSV de uma pasta
    * Portado de SIGCDIBP.importaplan
    * CSV: c1=codigo, c2=ex(skip se !empty), c4=descricao, c5=nacfed, c6=impfed,
    *       c7=estadual, c8=municipal, c9=datini, c10=datfin, c11=chave,
    *       c12=versao, c13=fonte. UF extraida do nome do arquivo (pos 13-14).
    *--------------------------------------------------------------------------
    FUNCTION ImportarPlanilha()
        IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
           (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            RETURN .F.
        ENDIF
        LOCAL loc_lSucesso, loc_lOk, loc_lcDir, loc_nQtdArq
        LOCAL loc_lcArq, loc_lcUf, loc_lcCodigo, loc_lcDesc
        LOCAL loc_lnAliq5, loc_lnAliq6, loc_lnAliq7, loc_lnAliq8
        LOCAL loc_ldDatIni, loc_ldDatFin
        LOCAL loc_lcChave, loc_lcVersao, loc_lcFonte
        LOCAL loc_lcCidChaves, loc_lcQuery, loc_nResult, loc_i
        loc_lSucesso = .F.
        loc_lOk      = .F.

        *-- Selecionar pasta (fora do TRY - RETURN .F. e valido aqui)
        loc_lcDir = GETDIR([], "Selecione a Pasta com os Arquivos CSV do IBPT", ;
                           "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rios", 2)
        IF EMPTY(loc_lcDir)
            RETURN .F.
        ENDIF

        DIMENSION loc_laArqs[1, 5]
        loc_nQtdArq = ADIR(loc_laArqs, loc_lcDir + "*.csv")
        IF loc_nQtdArq = 0
            MsgAviso("Nenhum arquivo CSV encontrado na pasta selecionada.", "Aviso")
            RETURN .F.
        ENDIF

        loc_lOk = .T.

        TRY
            CREATE CURSOR localIbpt (c1 c(10), c2 c(50), c3 c(50), c4 c(100), ;
                c5 c(50), c6 c(50), c7 c(50), c8 c(50), ;
                c9 c(50), c10 c(50), c11 c(50), c12 c(50), c13 c(50))

            FOR loc_i = 1 TO loc_nQtdArq
                loc_lcArq = loc_lcDir + loc_laArqs[loc_i, 1]
                IF EMPTY(loc_lcArq)
                    LOOP
                ENDIF

                *-- UF extraida do nome do arquivo (posicoes 13-14 do nome original)
                loc_lcUf = SUBSTR(ALLTRIM(loc_laArqs[loc_i, 1]), 13, 2)

                SELECT localIbpt
                ZAP
                APPEND FROM (loc_lcArq) DELIMITED WITH CHARACTER ";"
                GO TOP
                DELETE
                DELETE ALL FOR !EMPTY(c2)
                GO TOP

                SCAN
                    loc_lcCodigo = ALLTRIM(c1)
                    loc_lcDesc   = ALLTRIM(c4)
                    loc_lnAliq5  = VAL(ALLTRIM(c5))
                    loc_lnAliq6  = VAL(ALLTRIM(c6))
                    loc_lnAliq7  = VAL(ALLTRIM(c7))
                    loc_lnAliq8  = VAL(ALLTRIM(c8))
                    loc_ldDatIni = DTOT(CTOD(ALLTRIM(c9)))
                    loc_ldDatFin = DTOT(CTOD(ALLTRIM(c10)))
                    loc_lcChave  = ALLTRIM(c11)
                    loc_lcVersao = ALLTRIM(c12)
                    loc_lcFonte  = ALLTRIM(c13)

                    loc_lcQuery = "SELECT cidchaves FROM SigCdIbp" + ;
                                  " WHERE ufs    = " + EscaparSQL(loc_lcUf) + ;
                                  " AND   codigo = " + EscaparSQL(loc_lcCodigo) + ;
                                  " AND   chave  = " + EscaparSQL(loc_lcChave) + ;
                                  " AND   versao = " + EscaparSQL(loc_lcVersao)

                    *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                    IF USED("cursor_4c_AuxIbp")
                        TABLEREVERT(.T., "cursor_4c_AuxIbp")
                        USE IN cursor_4c_AuxIbp
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_AuxIbp")
                    IF loc_nResult < 0
                        MsgErro("Imposs" + CHR(237) + "vel conectar ao servidor de banco de dados.", "Erro")
                        loc_lOk = .F.
                        IF USED("cursor_4c_AuxIbp")
                            USE IN cursor_4c_AuxIbp
                        ENDIF
                        EXIT
                    ENDIF

                    IF RECCOUNT("cursor_4c_AuxIbp") = 0
                        *-- Novo registro
                        loc_lcCidChaves = LEFT(fUniqueIds(), 20)
                        loc_lcQuery = "INSERT INTO SigCdIbp" + ;
                                      " (cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                                      "  datini, datfin, nacfederal, impfederal," + ;
                                      "  estadual, municipal, chave, versao, fonte)" + ;
                                      " VALUES (" + ;
                                      EscaparSQL(loc_lcCidChaves) + "," + ;
                                      EscaparSQL(loc_lcUf) + "," + ;
                                      EscaparSQL(loc_lcCodigo) + "," + ;
                                      EscaparSQL("") + "," + ;
                                      "0," + ;
                                      EscaparSQL(loc_lcDesc) + "," + ;
                                      FormatarDataSQL(loc_ldDatIni) + "," + ;
                                      FormatarDataSQL(loc_ldDatFin) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq5) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq6) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq7) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq8) + "," + ;
                                      EscaparSQL(loc_lcChave) + "," + ;
                                      EscaparSQL(loc_lcVersao) + "," + ;
                                      EscaparSQL(loc_lcFonte) + ;
                                      ")"
                    ELSE
                        *-- Registro existente - atualizar aliquotas e datas
                        SELECT cursor_4c_AuxIbp
                        loc_lcCidChaves = ALLTRIM(cursor_4c_AuxIbp.cidchaves)
                        loc_lcQuery = "UPDATE SigCdIbp SET" + ;
                                      " descricao  = " + EscaparSQL(loc_lcDesc) + "," + ;
                                      " datini     = " + FormatarDataSQL(loc_ldDatIni) + "," + ;
                                      " datfin     = " + FormatarDataSQL(loc_ldDatFin) + "," + ;
                                      " nacfederal = " + FormatarNumeroSQL(loc_lnAliq5) + "," + ;
                                      " impfederal = " + FormatarNumeroSQL(loc_lnAliq6) + "," + ;
                                      " estadual   = " + FormatarNumeroSQL(loc_lnAliq7) + "," + ;
                                      " municipal  = " + FormatarNumeroSQL(loc_lnAliq8) + "," + ;
                                      " fonte      = " + EscaparSQL(loc_lcFonte) + ;
                                      " WHERE cidchaves = " + EscaparSQL(loc_lcCidChaves)
                    ENDIF

                    IF USED("cursor_4c_AuxIbp")
                        USE IN cursor_4c_AuxIbp
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery)
                    IF loc_nResult < 0
                        MsgErro("Erro ao importar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lOk = .F.
                        EXIT
                    ENDIF

                    SELECT localIbpt
                ENDSCAN

                IF !loc_lOk
                    EXIT
                ENDIF
            ENDFOR

            IF USED("localIbpt")
                USE IN localIbpt
            ENDIF

            loc_lSucesso = loc_lOk
        CATCH TO loException
            MsgErro("Erro em IBPBO.ImportarPlanilha:" + CHR(13) + loException.Message, "Erro")
            IF USED("localIbpt")
                USE IN localIbpt
            ENDIF
            IF USED("cursor_4c_AuxIbp")
                USE IN cursor_4c_AuxIbp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
