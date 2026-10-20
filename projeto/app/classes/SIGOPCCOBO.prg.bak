*====================================================================
* SIGOPCCOBO.prg
*
* Business Object para Carta de Correcao de Nota Fiscal
* Tabela: SigNfCor
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGOPCCOBO AS BusinessBase

    *-- Propriedades da entidade (tabela SigNfCor - Carta de Correcao de NF)
    this_cCidchaves  = ""   && cidchaves char(20) - PK (chave unica Fortyus)
    this_cEmps       = ""   && cemps char(3) - empresa
    this_cSeries     = ""   && cseries char(3) - serie da nota fiscal
    this_cNfis       = ""   && cnfis char(6) - numero da nota fiscal
    this_nNoccors    = 0    && noccors numeric(3,0) - numero da ocorrencia (FK SigCcOco.ncodigos)
    this_cMretifs    = ""   && mretifs text - texto da retificacao/correcao

    *-- Propriedades de contexto (parametros recebidos do form chamador)
    this_dEmisDe     = {}   && data de emissao inicial (filtro repassado na impressao)
    this_dEmisAte    = {}   && data de emissao final (filtro repassado na impressao)

    *-- Propriedade auxiliar (tabela SigCdEmp - razao social da empresa)
    this_cRazas      = ""   && SigCdEmp.razas char(40) - razao social da empresa

    *-- Resultado de ConfirmarCorrecao(): .T. quando o lote gravou pelo
    *-- menos 1 retificacao (equivalente ao buffer crSigNfCor nao vazio do
    *-- Ok.Click legado); .F. quando nenhuma linha da grade tinha retifs
    *-- preenchido (ramo "Confirma Impressao da Correcao ?")
    this_lTemCorrecoesGravadas = .F.

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigNfCor"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia todas as colunas de SigNfCor (CrSigNfCor)
    * para as propriedades this_* do BO.
    *
    * TratarNulo(valor, PADRAO): o 2o argumento e o VALOR de fallback usado
    * quando a coluna vem NULL - NAO o tipo. Por isso "" para char/text e 0
    * para numeric (mretifs e text NULL no schema, logo o caso NULL e real).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                THIS.this_cEmps      = TratarNulo(cemps,     "")
                THIS.this_cSeries    = TratarNulo(cseries,   "")
                THIS.this_cNfis      = TratarNulo(cnfis,     "")
                THIS.this_nNoccors   = TratarNulo(noccors,   0)
                THIS.this_cMretifs   = TratarNulo(mretifs,   "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SIGOPCCOBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Grava nova ocorrencia de Carta de Correcao em SigNfCor
    * Gera cidchaves (PK Fortyus) quando o registro ainda nao tem uma
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigNfCor (cemps, cseries, cnfis, noccors, mretifs, cidchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cSeries)>>,
                    <<EscaparSQL(THIS.this_cNfis)>>,
                    <<FormatarNumeroSQL(THIS.this_nNoccors, 0)>>,
                    <<EscaparSQL(THIS.this_cMretifs)>>,
                    <<EscaparSQL(THIS.this_cCidchaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao inserir Carta de Corre" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message, "SIGOPCCOBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza o texto de retificacao de uma ocorrencia
    * existente em SigNfCor (chave primaria cidchaves)
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigNfCor
                SET cemps    = <<EscaparSQL(THIS.this_cEmps)>>,
                    cseries  = <<EscaparSQL(THIS.this_cSeries)>>,
                    cnfis    = <<EscaparSQL(THIS.this_cNfis)>>,
                    noccors  = <<FormatarNumeroSQL(THIS.this_nNoccors, 0)>>,
                    mretifs  = <<EscaparSQL(THIS.this_cMretifs)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidchaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao atualizar Carta de Corre" + CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message, "SIGOPCCOBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarOcorrencias - popula cursor_4c_TiposOcorrencia com a LISTA
    * COMPLETA de ocorrencias de correcao (tabela SigCcOco).
    *
    * Equivalente ao cursor CrSigCcOco do legado:
    *   .AddCursor('SigCcOco','ncodigos','CrSigCcOco','','')
    *   ThisForm.poDataMgr.Requery('CrSigCcOco')
    *
    * O legado nao filtra nada - traz a tabela inteira - e ordena por
    * ncodigos (chave do AddCursor), que e a ordem em que as ocorrencias
    * aparecem na grade.
    *
    * Colunas conferidas em docs/schema.sql: SigCcOco.ncodigos numeric(3,0),
    * SigCcOco.cdescrs char(30).
    *====================================================================
    PROCEDURE CarregarOcorrencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT ncodigos, cdescrs" + ;
                       "  FROM SigCcOco" + ;
                       " ORDER BY ncodigos"

            IF USED("cursor_4c_TiposOcorrencia")
                USE IN cursor_4c_TiposOcorrencia
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposOcorrencia")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao carregar ocorr" + CHR(234) + "ncias de corre" + CHR(231) + CHR(227) + "o:" + ;
                            CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCCOBO.CarregarOcorrencias")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarCorrecoes - popula cursor_4c_Correcoes com as retificacoes
    * JA GRAVADAS para uma nota fiscal (tabela SigNfCor).
    *
    * Equivalente ao cursor CrSigNfCor do legado, com a MESMA query:
    *   lcQryCorNf = [Select * From SigNfCor ]+
    *                [Where cemps = ?pcEmps And cseries = ?pcSeries
    *                       And cnfis = ?pcNFis ]+
    *                [Order By cemps,cseries,cnfis,noccors ]
    *
    * O legado passa os 3 filtros SEMPRE (inclusive vazios, via parametro do
    * fSqlConector) e re-executa a mesma query em Get_NotaIni.Valid trocando
    * so pcNFisDe - aqui isso vira o parametro par_cNfis.
    *
    * PADR nas larguras do schema (cemps/cseries char(3), cnfis char(6)) -
    * igual ao Padr(...,3)/Padr(...,6) que o proprio legado usa nos Delete/
    * Update do Ok.Click.
    *====================================================================
    PROCEDURE CarregarCorrecoes(par_cEmps, par_cSeries, par_cNfis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_cEmps, loc_cSeries, loc_cNfis
        loc_lSucesso = .F.

        loc_cEmps   = PADR(IIF(VARTYPE(par_cEmps)   = "C", ALLTRIM(par_cEmps),   ""), 3)
        loc_cSeries = PADR(IIF(VARTYPE(par_cSeries) = "C", ALLTRIM(par_cSeries), ""), 3)
        loc_cNfis   = PADR(IIF(VARTYPE(par_cNfis)   = "C", ALLTRIM(par_cNfis),   ""), 6)

        TRY
            loc_cSQL = "SELECT cemps, cseries, cnfis, noccors, mretifs, cidchaves" + ;
                       "  FROM SigNfCor" + ;
                       " WHERE cemps   = " + EscaparSQL(loc_cEmps) + ;
                       "   AND cseries = " + EscaparSQL(loc_cSeries) + ;
                       "   AND cnfis   = " + EscaparSQL(loc_cNfis) + ;
                       " ORDER BY cemps, cseries, cnfis, noccors"

            IF USED("cursor_4c_Correcoes")
                USE IN cursor_4c_Correcoes
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Correcoes")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao carregar as corre" + CHR(231) + CHR(245) + "es da nota fiscal:" + ;
                            CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCCOBO.CarregarCorrecoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ConfirmarCorrecao - grava a Carta de Correcao da nota fiscal como UM
    * LOTE SQL atomico: apaga as retificacoes anteriores (SigNfCor) e grava
    * so as linhas de cursor_4c_Ocorrencias (a grade do form) com texto de
    * retificacao preenchido, atualizando a flag SigMvNfi.Correcs.
    *
    * Equivalente ao Ok.Click do legado:
    *   Delete From SigNfCor Where CEmps=... And CSeries=... And CNfis=...
    *   Update SigMvNfi Set Correcs = .F. Where ...   (commit)
    *   Zap In crSigNfCor
    *   <para cada linha de XCorNf com Retifs preenchido:
    *        Insert Into crSigNfCor (cEmps,cSeries,cNfis,nOccors,mRetifs,cIdChaves)>
    *   Update(crSigNfCor)
    *   Se crSigNfCor nao ficou vazio:
    *       Update SigMvNfi Set Correcs = .T. Where ...   (commit)
    *
    * BEGIN/COMMIT via SQLEXEC separados NAO protegem (a conexao
    * SQLSTRINGCONNECT ja nasce com @@TRANCOUNT=1 - um par BEGIN/COMMIT so
    * aninha o contador e um ROLLBACK depois nao desfaz nada). A
    * atomicidade pretendida pelo legado (tudo ou nada) vai num SQLEXEC
    * UNICO com SAVE TRANSACTION/TRY/CATCH/THROW em T-SQL, no mesmo padrao
    * de ProdutoBO.CopiarProduto.
    *
    * fUniqueIds() gera a PK (cidchaves) de cada linha nova - igual ao
    * Insert Into do legado. this_lTemCorrecoesGravadas fica .T. quando
    * pelo menos 1 linha foi incluida no lote.
    *====================================================================
    PROCEDURE ConfirmarCorrecao(par_cEmps, par_cSeries, par_cNfis)
        LOCAL loc_cEmps, loc_cSeries, loc_cNfis, loc_cLote, loc_cInserts
        LOCAL loc_nResultado, loc_lSucesso, loc_oErro

        *-- Argumento ausente cai na PROPRIA property, que o FormParaBO do
        *-- form acabou de preencher - assim o form nao precisa repassar como
        *-- argumento o que ja esta no BO (fonte unica). PADR nas larguras do
        *-- schema (cemps/cseries char(3), cnfis char(6)), igual ao
        *-- Padr(...,3)/Padr(...,6) do Ok.Click legado.
        loc_cEmps   = PADR(ALLTRIM(IIF(VARTYPE(par_cEmps)   = "C", par_cEmps,   THIS.this_cEmps)),   3)
        loc_cSeries = PADR(ALLTRIM(IIF(VARTYPE(par_cSeries) = "C", par_cSeries, THIS.this_cSeries)), 3)
        loc_cNfis   = PADR(ALLTRIM(IIF(VARTYPE(par_cNfis)   = "C", par_cNfis,   THIS.this_cNfis)),   6)

        THIS.this_cMensagemErro         = ""
        THIS.this_lErroExibido          = .F.
        THIS.this_lTemCorrecoesGravadas = .F.
        loc_lSucesso = .F.
        loc_cInserts = ""

        TRY
            IF !USED("cursor_4c_Ocorrencias")
                THIS.this_cMensagemErro = "Grade de ocorr" + CHR(234) + "ncias n" + CHR(227) + "o carregada."
                THIS.ExibirFalha("Confirmar")
            ELSE
                *-- "Zap In crSigNfCor" + 1o Scan (so as linhas com Retifs
                *-- preenchido entram no buffer)
                SELECT cursor_4c_Ocorrencias
                GO TOP
                SCAN
                    IF !EMPTY(cursor_4c_Ocorrencias.retifs)
                        *-- ALLTRIM tira espacos sobrando que o EditBox pode
                        *-- deixar no texto digitado antes de gravar
                        loc_cInserts = loc_cInserts + ;
                            "INSERT INTO SigNfCor (cemps, cseries, cnfis, noccors, mretifs, cidchaves) VALUES (" + ;
                            EscaparSQL(loc_cEmps) + ", " + ;
                            EscaparSQL(loc_cSeries) + ", " + ;
                            EscaparSQL(loc_cNfis) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_Ocorrencias.cods, 0) + ", " + ;
                            EscaparSQL(ALLTRIM(cursor_4c_Ocorrencias.retifs)) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ");" + CHR(13) + CHR(10)
                        SELECT cursor_4c_Ocorrencias
                    ENDIF
                ENDSCAN

                THIS.this_lTemCorrecoesGravadas = !EMPTY(loc_cInserts)

                loc_cLote = "SET NOCOUNT ON;" + CHR(13) + CHR(10) + ;
                    "DECLARE @nivel int = @@TRANCOUNT;" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 BEGIN TRANSACTION" + CHR(13) + CHR(10) + ;
                    "ELSE SAVE TRANSACTION Cco4c;" + CHR(13) + CHR(10) + ;
                    "BEGIN TRY" + CHR(13) + CHR(10) + ;
                    "DELETE FROM SigNfCor WHERE cemps = " + EscaparSQL(loc_cEmps) + ;
                        " AND cseries = " + EscaparSQL(loc_cSeries) + ;
                        " AND cnfis = " + EscaparSQL(loc_cNfis) + ";" + CHR(13) + CHR(10) + ;
                    loc_cInserts + ;
                    "UPDATE SigMvNfi SET correcs = " + IIF(THIS.this_lTemCorrecoesGravadas, "1", "0") + ;
                        " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                        " AND series = " + EscaparSQL(loc_cSeries) + ;
                        " AND nfis = " + EscaparSQL(loc_cNfis) + ";" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 COMMIT TRANSACTION;" + CHR(13) + CHR(10) + ;
                    "END TRY" + CHR(13) + CHR(10) + ;
                    "BEGIN CATCH" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + CHR(10) + ;
                    "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Cco4c; END;" + CHR(13) + CHR(10) + ;
                    "THROW;" + CHR(13) + CHR(10) + ;
                    "END CATCH"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cLote)

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    THIS.ExibirFalha("Confirmar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.ExibirFalha("Confirmar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterEmpDopNums - devolve SigMvNfi.empdopnums (coluna ja
    * materializada = Emps char(3) + Dopes char(20) + Str(Numes,6), total
    * char(29) - regra #42) da nota fiscal atual.
    *
    * Equivalente a "CrSigMvNfi.Emps + CrSigMvNfi.Dopes +
    * Str(CrSigMvNfi.Numes,6)" do Ok.Click legado, que monta a chave a
    * partir do cursor global do FORM CHAMADOR (CrSigMvNfi). Sem form
    * chamador nesta migracao (SIGOPCCO abre direto do menu), a mesma linha
    * e localizada pela chave natural Emps/Series/Nfis que os Updates de
    * ConfirmarCorrecao() ja usam.
    *====================================================================
    PROCEDURE ObterEmpDopNums(par_cEmps, par_cSeries, par_cNfis)
        LOCAL loc_cSQL, loc_nResultado, loc_cRetorno, loc_oErro

        loc_cRetorno = ""

        TRY
            *-- Argumento ausente cai na PROPRIA property (preenchida pelo
            *-- FormParaBO do form), mesmo criterio de ConfirmarCorrecao
            loc_cSQL = "SELECT empdopnums" + ;
                       "  FROM SigMvNfi" + ;
                       " WHERE emps   = " + EscaparSQL(PADR(ALLTRIM(IIF(VARTYPE(par_cEmps)   = "C", par_cEmps,   THIS.this_cEmps)),   3)) + ;
                       "   AND series = " + EscaparSQL(PADR(ALLTRIM(IIF(VARTYPE(par_cSeries) = "C", par_cSeries, THIS.this_cSeries)), 3)) + ;
                       "   AND nfis   = " + EscaparSQL(PADR(ALLTRIM(IIF(VARTYPE(par_cNfis)   = "C", par_cNfis,   THIS.this_cNfis)),   6))

            IF USED("cursor_4c_EmpDopNums")
                USE IN cursor_4c_EmpDopNums
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDopNums")

            IF loc_nResultado >= 0 AND USED("cursor_4c_EmpDopNums") AND RECCOUNT("cursor_4c_EmpDopNums") > 0
                loc_cRetorno = cursor_4c_EmpDopNums.empdopnums
            ENDIF

            IF USED("cursor_4c_EmpDopNums")
                USE IN cursor_4c_EmpDopNums
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCCOBO.ObterEmpDopNums")
        ENDTRY

        RETURN loc_cRetorno
    ENDPROC


ENDDEFINE
