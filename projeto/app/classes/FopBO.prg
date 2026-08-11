*==============================================================================
* FopBO.prg - Business Object para Fornecedores do Produto
* Tabela   : SigPrFnc
* Herda de : BusinessBase
* Migrado de: SIGCDFOP.SCX (task421)
*==============================================================================
DEFINE CLASS FopBO AS BusinessBase

    *---------------------------------------------------------------------------
    *-- Campos da tabela SigPrFnc (schema.sql)
    *---------------------------------------------------------------------------
    this_cCidChaves  = ""   && PK char(20)
    this_cCpros      = ""   && Produto char(14) - FK SigCdPro
    this_cIfors      = ""   && Fornecedor char(10) - FK SigCdCli
    this_cRClis      = ""   && Razao Social (JOIN SigCdCli - exibicao, nao persistido)
    this_cReffs      = ""   && Referencia do Fornecedor char(40)
    this_cMoevs      = ""   && Moeda char(3) - FK SigCdMoe
    this_nPvens      = 0    && Preco de Custo numeric(10,2)
    this_dDtvalid    = {}   && Validade datetime NULL
    this_nSituas     = 0    && Situacao numeric(1,0) - checkbox (Situas)
    this_cColecoes   = ""   && Grupo Venda char(10) - FK SigCdCol
    this_cCodcors    = ""   && Cor char(4) - FK SigCdCor
    this_cCodtams    = ""   && Tamanho char(4) - FK SigCdTam

    *---------------------------------------------------------------------------
    *-- Estado operacional do formulario
    *---------------------------------------------------------------------------
    this_cCprosAtivo = ""   && Codigo do produto em edicao
    this_lHouveIncl  = .F.  && Houve inclusoes nesta sessao
    this_lHouveExcl  = .F.  && Houve exclusoes nesta sessao
    this_cModoAtual  = ""   && Modo atual: INSERIR / ALTERAR / VISUALIZAR

    *===========================================================================
    PROCEDURE Init()
    *===========================================================================
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrFnc"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FopBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *===========================================================================
        RETURN THIS.this_cCidChaves
    ENDPROC

    *===========================================================================
    PROCEDURE BuscarPorProduto(par_cCpros)
    *===========================================================================
    * Carrega fornecedores do produto do SQL Server para cursor crSigPrFnc.
    * O cursor inclui coluna lNovo (.F. para registros ja existentes no DB).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_cCPros, loc_cIfors, loc_cRClis
        LOCAL loc_cReffs, loc_cMoevs, loc_nPvens, loc_dDtvalid
        LOCAL loc_nSituas, loc_cColecoes, loc_cCodcors, loc_cCodtams

        loc_lSucesso = .F.

        TRY
            IF USED("crSigPrFncTemp")
                USE IN crSigPrFncTemp
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.cPros, a.iFors, " + ;
                       "ISNULL(b.rClis, '') AS rClis, " + ;
                       "a.Reffs, a.MoeVs, a.PVens, a.DtValid, " + ;
                       "a.Situas, a.Colecoes, a.CodCors, a.CodTams " + ;
                       "FROM SigPrFnc a " + ;
                       "LEFT JOIN SigCdCli b ON b.iClis = a.iFors " + ;
                       "WHERE a.cPros = " + EscaparSQL(par_cCpros)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrFncTemp")

            IF loc_nRet < 0
                MsgErro("Erro ao carregar fornecedores do produto.", "Erro em BuscarPorProduto")
            ELSE
                IF USED("crSigPrFnc")
                    TABLEREVERT(.T., "crSigPrFnc")
                    USE IN crSigPrFnc
                ENDIF

                SET NULL ON
                CREATE CURSOR crSigPrFnc ;
                    (CidChaves C(20) NULL, cPros C(14) NULL, iFors C(10) NULL, ;
                     rClis C(50) NULL, Reffs C(40) NULL, MoeVs C(3) NULL, ;
                     PVens N(10,2) NULL, DtValid T NULL, Situas N(1,0) NULL, ;
                     Colecoes C(10) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                     lNovo L)
                SET NULL OFF

                SELECT crSigPrFncTemp
                GO TOP
                SCAN
                    loc_cCidChaves = NVL(crSigPrFncTemp.CidChaves, "")
                    loc_cCPros     = NVL(crSigPrFncTemp.cPros, "")
                    loc_cIfors     = NVL(crSigPrFncTemp.iFors, "")
                    loc_cRClis     = NVL(crSigPrFncTemp.rClis, "")
                    loc_cReffs     = NVL(crSigPrFncTemp.Reffs, "")
                    loc_cMoevs     = NVL(crSigPrFncTemp.MoeVs, "")
                    loc_nPvens     = NVL(crSigPrFncTemp.PVens, 0)
                    loc_dDtvalid   = crSigPrFncTemp.DtValid
                    loc_nSituas    = NVL(crSigPrFncTemp.Situas, 0)
                    loc_cColecoes  = NVL(crSigPrFncTemp.Colecoes, "")
                    loc_cCodcors   = NVL(crSigPrFncTemp.CodCors, "")
                    loc_cCodtams   = NVL(crSigPrFncTemp.CodTams, "")

                    SELECT crSigPrFnc
                    APPEND BLANK
                    REPLACE CidChaves WITH loc_cCidChaves, ;
                            cPros     WITH loc_cCPros, ;
                            iFors     WITH loc_cIfors, ;
                            rClis     WITH loc_cRClis, ;
                            Reffs     WITH loc_cReffs, ;
                            MoeVs     WITH loc_cMoevs, ;
                            PVens     WITH loc_nPvens, ;
                            DtValid   WITH loc_dDtvalid, ;
                            Situas    WITH loc_nSituas, ;
                            Colecoes  WITH loc_cColecoes, ;
                            CodCors   WITH loc_cCodcors, ;
                            CodTams   WITH loc_cCodtams, ;
                            lNovo     WITH .F.

                    SELECT crSigPrFncTemp
                ENDSCAN

                USE IN crSigPrFncTemp

                SELECT crSigPrFnc
                GO TOP

                THIS.this_cCprosAtivo = par_cCpros
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarPorProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE InserirLinha(par_cCpros)
    *===========================================================================
    * Adiciona linha em branco ao cursor crSigPrFnc (ainda nao persiste no DB).
    * Replica cmdInserir.Click: localiza linha vazia existente, senao append.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cChave, loc_lAchou

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                MsgErro("Cursor crSigPrFnc n" + CHR(227) + "o inicializado.", "Erro em InserirLinha")
            ELSE
                SELECT crSigPrFnc
                SET EXACT ON
                LOCATE FOR ALLTRIM(cPros) == ALLTRIM(par_cCpros) AND EMPTY(iFors) AND !DELETED()
                loc_lAchou = !EOF()

                IF !loc_lAchou
                    loc_cChave = THIS.GerarCidChaves()
                    APPEND BLANK
                    REPLACE CidChaves WITH loc_cChave, ;
                            cPros     WITH par_cCpros, ;
                            iFors     WITH "", ;
                            rClis     WITH "", ;
                            Reffs     WITH "", ;
                            MoeVs     WITH "", ;
                            PVens     WITH 0, ;
                            Situas    WITH 0, ;
                            Colecoes  WITH "", ;
                            CodCors   WITH "", ;
                            CodTams   WITH "", ;
                            lNovo     WITH .T.
                    THIS.this_lHouveIncl = .T.
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InserirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE ExcluirLinha()
    *===========================================================================
    * Marca a linha corrente do cursor para exclusao (replica cmdExcluir.Click).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                loc_lSucesso = .T.
            ELSE
                SELECT crSigPrFnc
                IF !EOF() AND ALLTRIM(cPros) == ALLTRIM(THIS.this_cCprosAtivo) AND !DELETED()
                    DELETE
                    SKIP
                    SKIP - 1
                    THIS.this_lHouveExcl = .T.
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ExcluirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE RepetirLinha(par_nVezes)
    *===========================================================================
    * Duplica a linha corrente do cursor N vezes (replica getQtde.Valid).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_i, loc_cChave
        LOCAL loc_cIfors, loc_cRClis, loc_cReffs, loc_cMoevs
        LOCAL loc_nPvens, loc_dDtvalid, loc_nSituas
        LOCAL loc_cColecoes, loc_cCodcors, loc_cCodtams, loc_cCpros

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                loc_lSucesso = .T.
            ELSE
                SELECT crSigPrFnc
                IF EMPTY(iFors)
                    MsgAviso("Selecione um registro para ser repetido.", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_cIfors    = ALLTRIM(iFors)
                    loc_cRClis    = ALLTRIM(rClis)
                    loc_cReffs    = ALLTRIM(Reffs)
                    loc_cMoevs    = ALLTRIM(MoeVs)
                    loc_nPvens    = NVL(PVens, 0)
                    loc_dDtvalid  = DtValid
                    loc_nSituas   = NVL(Situas, 0)
                    loc_cColecoes = ALLTRIM(Colecoes)
                    loc_cCodcors  = ALLTRIM(CodCors)
                    loc_cCodtams  = ALLTRIM(CodTams)
                    loc_cCpros    = ALLTRIM(cPros)

                    FOR loc_i = 1 TO par_nVezes
                        loc_cChave = THIS.GerarCidChaves()
                        SELECT crSigPrFnc
                        APPEND BLANK
                        REPLACE CidChaves WITH loc_cChave, ;
                                cPros     WITH loc_cCpros, ;
                                iFors     WITH loc_cIfors, ;
                                rClis     WITH loc_cRClis, ;
                                Reffs     WITH loc_cReffs, ;
                                MoeVs     WITH loc_cMoevs, ;
                                PVens     WITH loc_nPvens, ;
                                DtValid   WITH loc_dDtvalid, ;
                                Situas    WITH loc_nSituas, ;
                                Colecoes  WITH loc_cColecoes, ;
                                CodCors   WITH loc_cCodcors, ;
                                CodTams   WITH loc_cCodtams, ;
                                lNovo     WITH .T.
                    ENDFOR

                    THIS.this_lHouveIncl = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RepetirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE ValidarCursor(par_cModo)
    *===========================================================================
    * Valida todas as linhas do cursor antes de salvar (replica cmdSair.Click).
    * Retorna .T. se valido, .F. se invalido (com MsgAviso ao usuario).
    *---------------------------------------------------------------------------
        LOCAL loc_lValido
        LOCAL loc_cIfors, loc_cReffs, loc_cColecoes, loc_nPvens
        LOCAL loc_nDupli

        loc_lValido = .T.

        TRY
            IF USED("crSigPrFnc") AND INLIST(UPPER(par_cModo), "INSERIR", "ALTERAR")
                SELECT crSigPrFnc
                GO TOP
                SCAN
                    IF DELETED()
                        LOOP
                    ENDIF

                    IF EMPTY(iFors)
                        MsgAviso("Fornecedor deve ser informado!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    IF EMPTY(Reffs)
                        MsgAviso("A refer" + CHR(234) + "ncia do fornecedor deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    IF EMPTY(MoeVs)
                        MsgAviso("A Moeda deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    loc_cIfors    = ALLTRIM(iFors)
                    loc_cReffs    = ALLTRIM(Reffs)
                    loc_cColecoes = ALLTRIM(Colecoes)
                    loc_nPvens    = NVL(PVens, 0)

                    SELECT COUNT(*) AS nDupli ;
                        FROM crSigPrFnc a ;
                        WHERE ALLTRIM(a.iFors)    == m.loc_cIfors ;
                          AND ALLTRIM(a.Reffs)    == m.loc_cReffs ;
                          AND ALLTRIM(a.Colecoes) == m.loc_cColecoes ;
                          AND NVL(a.PVens, 0)      = m.loc_nPvens ;
                          AND !DELETED() ;
                        INTO CURSOR crAuxDupli READWRITE

                    SELECT crAuxDupli
                    loc_nDupli = NVL(crAuxDupli.nDupli, 0)
                    USE IN crAuxDupli

                    IF loc_nDupli > 1
                        MsgAviso("Fornecedor j" + CHR(225) + " informado para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    SELECT crSigPrFnc
                ENDSCAN

                SELECT crSigPrFnc
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ValidarCursor")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *===========================================================================
    PROCEDURE SalvarAlteracoes(par_cCpros)
    *===========================================================================
    * Persiste as alteracoes do cursor crSigPrFnc no SQL Server.
    * Estrategia: DELETE todos existentes para o produto + INSERT os nao-deletados.
    * Isso replica o comportamento do fSqlConector.ReQuery do legado.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_cIfors, loc_cReffs, loc_cMoevs
        LOCAL loc_nPvens, loc_dDtvalid, loc_nSituas
        LOCAL loc_cColecoes, loc_cCodcors, loc_cCodtams

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "DELETE FROM SigPrFnc WHERE cPros = " + EscaparSQL(par_cCpros)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet < 0
                    MsgErro("Erro ao excluir registros anteriores de SigPrFnc.", ;
                            "Erro em SalvarAlteracoes")
                ELSE
                    SELECT crSigPrFnc
                    GO TOP
                    SCAN
                        IF DELETED()
                            LOOP
                        ENDIF

                        loc_cCidChaves = ALLTRIM(CidChaves)
                        loc_cIfors     = ALLTRIM(iFors)
                        loc_cReffs     = ALLTRIM(Reffs)
                        loc_cMoevs     = ALLTRIM(MoeVs)
                        loc_nPvens     = NVL(PVens, 0)
                        loc_dDtvalid   = DtValid
                        loc_nSituas    = NVL(Situas, 0)
                        loc_cColecoes  = ALLTRIM(Colecoes)
                        loc_cCodcors   = ALLTRIM(CodCors)
                        loc_cCodtams   = ALLTRIM(CodTams)

                        loc_cSQL = "INSERT INTO SigPrFnc " + ;
                                   "(CidChaves, cPros, iFors, Reffs, MoeVs, " + ;
                                   "PVens, DtValid, Situas, Colecoes, CodCors, CodTams) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", " + ;
                                   EscaparSQL(par_cCpros) + ", " + ;
                                   EscaparSQL(loc_cIfors) + ", " + ;
                                   EscaparSQL(loc_cReffs) + ", " + ;
                                   EscaparSQL(loc_cMoevs) + ", " + ;
                                   FormatarNumeroSQL(loc_nPvens, 2) + ", " + ;
                                   IIF(ISNULL(loc_dDtvalid) OR EMPTY(loc_dDtvalid), ;
                                       "NULL", FormatarDataSQL(loc_dDtvalid)) + ", " + ;
                                   FormatarNumeroSQL(loc_nSituas, 0) + ", " + ;
                                   EscaparSQL(loc_cColecoes) + ", " + ;
                                   EscaparSQL(loc_cCodcors) + ", " + ;
                                   EscaparSQL(loc_cCodtams) + ")"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nRet < 0
                            MsgErro("Erro ao inserir fornecedor " + loc_cIfors + " em SigPrFnc.", ;
                                    "Erro em SalvarAlteracoes")
                            EXIT
                        ENDIF

                        SELECT crSigPrFnc
                    ENDSCAN

                    IF loc_nRet >= 0
                        SELECT crSigPrFnc
                        GO TOP
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em SalvarAlteracoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE CarregarDoCursor(par_cAlias)
    *===========================================================================
    * Mapeia campos do cursor para propriedades do BO.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                THIS.this_cCpros     = TratarNulo(cPros, "C")
                THIS.this_cIfors     = TratarNulo(iFors, "C")
                THIS.this_cRClis     = TratarNulo(rClis, "C")
                THIS.this_cReffs     = TratarNulo(Reffs, "C")
                THIS.this_cMoevs     = TratarNulo(MoeVs, "C")
                THIS.this_nPvens     = NVL(PVens, 0)
                THIS.this_dDtvalid   = NVL(DtValid, {})
                THIS.this_nSituas    = NVL(Situas, 0)
                THIS.this_cColecoes  = TratarNulo(Colecoes, "C")
                THIS.this_cCodcors   = TratarNulo(CodCors, "C")
                THIS.this_cCodtams   = TratarNulo(CodTams, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED FUNCTION GerarCidChaves()
    *===========================================================================
    * Gera chave unica de 20 chars para CidChaves (replica fUniqueIds do legado).
    * Usa NEWID() do SQL Server (GUID sem hifens, truncado em 20 chars).
    *---------------------------------------------------------------------------
        LOCAL loc_cChave

        loc_cChave = ""

        TRY
            IF SQLEXEC(gnConnHandle, ;
                       "SELECT LEFT(REPLACE(CAST(NEWID() AS VARCHAR(36)),'-',''),20) AS nk", ;
                       "crChaveTemp") > 0
                SELECT crChaveTemp
                loc_cChave = ALLTRIM(TRANSFORM(crChaveTemp.nk))
                USE IN crChaveTemp
            ENDIF
        CATCH TO loc_oErro
            * Fallback local se SQL Server nao disponivel
        ENDTRY

        IF EMPTY(loc_cChave)
            loc_cChave = LEFT(STRTRAN(STRTRAN(STRTRAN(TRANSFORM(DATETIME()), "/", ""), " ", ""), ":", "") + ;
                              SYS(3) + SYS(3), 20)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *===========================================================================
    PROCEDURE Inserir()
    *===========================================================================
    * Insere UM registro individual de SigPrFnc usando as propriedades this_*.
    * Chamado internamente por SalvarAlteracoes ou standalone via CarregarDoCursor.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_cChave

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCpros)
                MsgAviso("Produto n" + CHR(227) + "o informado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(THIS.this_cIfors)
                    MsgAviso("Fornecedor deve ser informado!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF EMPTY(THIS.this_cReffs)
                        MsgAviso("A refer" + CHR(234) + "ncia do fornecedor deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF EMPTY(THIS.this_cMoevs)
                            MsgAviso("A Moeda deve ser informada!", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ELSE
                            loc_cChave = ALLTRIM(THIS.this_cCidChaves)
                            IF EMPTY(loc_cChave)
                                loc_cChave = THIS.GerarCidChaves()
                                THIS.this_cCidChaves = loc_cChave
                            ENDIF

                            loc_cSQL = "INSERT INTO SigPrFnc " + ;
                                       "(CidChaves, cPros, iFors, Reffs, MoeVs, " + ;
                                       "PVens, DtValid, Situas, Colecoes, CodCors, CodTams) " + ;
                                       "VALUES (" + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cIfors)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cReffs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cMoevs)) + ", " + ;
                                       FormatarNumeroSQL(THIS.this_nPvens, 2) + ", " + ;
                                       IIF(ISNULL(THIS.this_dDtvalid) OR EMPTY(THIS.this_dDtvalid), ;
                                           "NULL", FormatarDataSQL(THIS.this_dDtvalid)) + ", " + ;
                                       FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cColecoes)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCodcors)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCodtams)) + ")"

                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                            IF loc_nRet < 0
                                MsgErro("Erro ao inserir fornecedor do produto no SQL Server.", ;
                                        "Erro em Inserir")
                            ELSE
                                THIS.RegistrarAuditoria("INCLUSAO")
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE Atualizar()
    *===========================================================================
    * Atualiza UM registro individual de SigPrFnc pela chave primaria CidChaves.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave prim" + CHR(225) + "ria (CidChaves) n" + CHR(227) + ;
                        "o informada. N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
                        "vel atualizar.", "Erro em Atualizar")
            ELSE
                IF EMPTY(THIS.this_cIfors)
                    MsgAviso("Fornecedor deve ser informado!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF EMPTY(THIS.this_cReffs)
                        MsgAviso("A refer" + CHR(234) + "ncia do fornecedor deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF EMPTY(THIS.this_cMoevs)
                            MsgAviso("A Moeda deve ser informada!", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ELSE
                            loc_cSQL = "UPDATE SigPrFnc SET " + ;
                                       "cPros = "    + EscaparSQL(ALLTRIM(THIS.this_cCpros))    + ", " + ;
                                       "iFors = "    + EscaparSQL(ALLTRIM(THIS.this_cIfors))    + ", " + ;
                                       "Reffs = "    + EscaparSQL(ALLTRIM(THIS.this_cReffs))    + ", " + ;
                                       "MoeVs = "    + EscaparSQL(ALLTRIM(THIS.this_cMoevs))    + ", " + ;
                                       "PVens = "    + FormatarNumeroSQL(THIS.this_nPvens, 2)   + ", " + ;
                                       "DtValid = "  + IIF(ISNULL(THIS.this_dDtvalid) OR EMPTY(THIS.this_dDtvalid), ;
                                                           "NULL", FormatarDataSQL(THIS.this_dDtvalid)) + ", " + ;
                                       "Situas = "   + FormatarNumeroSQL(THIS.this_nSituas, 0)  + ", " + ;
                                       "Colecoes = " + EscaparSQL(ALLTRIM(THIS.this_cColecoes)) + ", " + ;
                                       "CodCors = "  + EscaparSQL(ALLTRIM(THIS.this_cCodcors))  + ", " + ;
                                       "CodTams = "  + EscaparSQL(ALLTRIM(THIS.this_cCodtams))  + " " + ;
                                       "WHERE CidChaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                            IF loc_nRet < 0
                                MsgErro("Erro ao atualizar fornecedor do produto no SQL Server.", ;
                                        "Erro em Atualizar")
                            ELSE
                                THIS.RegistrarAuditoria("ALTERACAO")
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *===========================================================================
    * Executa DELETE de UM registro individual pela chave CidChaves.
    * Chamado por BusinessBase.Excluir() (PUBLIC).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave prim" + CHR(225) + "ria (CidChaves) n" + CHR(227) + ;
                        "o informada.", "Erro em ExecutarExclusao")
            ELSE
                THIS.RegistrarAuditoria("EXCLUSAO")

                loc_cSQL = "DELETE FROM SigPrFnc WHERE CidChaves = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet < 0
                    MsgErro("Erro ao excluir fornecedor do produto no SQL Server.", ;
                            "Erro em ExecutarExclusao")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE LiberarCursores()
    *===========================================================================
    * Libera todos os cursores do BO. Chamar no Destroy do Form.
    *---------------------------------------------------------------------------
        TRY
            IF USED("crSigPrFnc")
                TABLEREVERT(.T., "crSigPrFnc")
                USE IN crSigPrFnc
            ENDIF
            IF USED("crSigPrFncTemp")
                USE IN crSigPrFncTemp
            ENDIF
            IF USED("crAuxDupli")
                USE IN crAuxDupli
            ENDIF
            IF USED("crChaveTemp")
                USE IN crChaveTemp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LiberarCursores")
        ENDTRY
    ENDPROC

ENDDEFINE
