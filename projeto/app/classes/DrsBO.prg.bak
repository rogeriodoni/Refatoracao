*===============================================================================
* DrsBO.prg - Business Object para Fichas Tecnicas (SigSyCrs)
* Herda de BusinessBase
*
* Tabela principal: SigSyCrs
* Tabela config: SigSyCit
*
* MODELO DE DADOS (key-value store):
*   SigSyCrs (Tits C20, Cods N, Campos C10, Resps M, Pergs C, cIdChaves C,
*             ChkApro L, ChkSubn L)
*   SigSyCit (Tits C20, Campos C10, Descs C, Tipos C1, Ordems N, Listas N,
*             Linhas N, Files C, Fields C, Chaves C, cIdChaves C, CampoOAs C,
*             CampoDAs C, Associados C, Cadeado N, Vinculados C,
*             Obrigatorios L, Pictures C)
*
* Um "registro logico" = conjunto de rows em SigSyCrs com mesmo (Tits, Cods).
* Cada row armazena um campo: Campos=nome, Resps=valor, Pergs=rotulo.
* cIdChaves e a PK fisica de cada row individual.
*===============================================================================

DEFINE CLASS DrsBO AS BusinessBase

    *---------------------------------------------------------------------------
    * Identificacao do registro logico (Tits + Cods formam a PK logica)
    *---------------------------------------------------------------------------
    this_cTits   = ""   && Tipo de ficha C(20) - identifica o formulario/processo
    this_nCods   = 0    && Codigo do registro (PK logica dentro do Tits)

    *---------------------------------------------------------------------------
    * Status do workflow de aprovacao/baixa
    *---------------------------------------------------------------------------
    this_lChkApro  = .F.    && Aprovado
    this_lChkSubn  = .F.    && Baixado/Encerrado (ChkSubn)

    *---------------------------------------------------------------------------
    * Campos fixos de cabecalho (armazenados como key-value em SigSyCrs)
    * Campos = 'Emps', 'Dopes', 'Numes', 'Aprova', 'Datas', 'Baixa'
    *---------------------------------------------------------------------------
    this_cEmps   = ""   && Empresa (C3) - referencia SigCdEmp.CEmps
    this_cDopes  = ""   && Operacao (C20) - referencia SigCdOpe.Dopes
    this_cNumes  = ""   && Numero da operacao (C6)
    this_cAprova = ""   && Aprovador - usuario que aprovou (C10)
    this_cDatas  = ""   && Data de aprovacao como string (C20)
    this_cBaixa  = ""   && Usuario que registrou baixa (C10)

    *---------------------------------------------------------------------------
    * Nomes dos cursores de trabalho (mantidos como constantes aqui para
    * referencia cruzada com o Form)
    *---------------------------------------------------------------------------
    this_cCursorRs    = "crGrvCadRs"    && Cursor escrita SigSyCrs (key=cIdChaves)
    this_cCursorLista = "crSigSyCrs"    && Cursor lista SigSyCrs (key=Cods)
    this_cCursorCit   = "crSigSyCit"    && Cursor config SigSyCit
    this_cCursorLocal = "LocalCadRs"    && Cursor local de respostas (key=CodCampos)

    *===========================================================================
    PROCEDURE Init()
    *===========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigSyCrs"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * Destroy - Fecha cursores ao destruir o BO
    *===========================================================================
    PROCEDURE Destroy()
        THIS.FecharCursores()
        DODEFAULT()
    ENDPROC

    *===========================================================================
    * ObterChavePrimaria - Retorna chave para auditoria
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN EscaparSQL(ALLTRIM(THIS.this_cTits)) + ", " + ;
               FormatarNumeroSQL(THIS.this_nCods)
    ENDFUNC

    *===========================================================================
    * FecharCursores - Fecha todos os cursores de trabalho
    *===========================================================================
    PROCEDURE FecharCursores()
        IF USED("crSigSyCrs")
            USE IN crSigSyCrs
        ENDIF
        IF USED("LocalCadRs")
            USE IN LocalCadRs
        ENDIF
        IF USED("crSigSyCit")
            USE IN crSigSyCit
        ENDIF
        IF USED("crGrvCadRs")
            USE IN crGrvCadRs
        ENDIF
    ENDPROC

    *===========================================================================
    * InicializarCursores - Cria cursor de escrita crGrvCadRs
    *===========================================================================
    FUNCTION InicializarCursores()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crGrvCadRs")
                USE IN crGrvCadRs
            ENDIF
            SET NULL ON
            CREATE CURSOR crGrvCadRs ( ;
                Tits      C(20),  ;
                Campos    C(10),  ;
                Cods      N(10,0), ;
                cIdChaves C(38),  ;
                Resps     M,      ;
                Pergs     C(200), ;
                ChkApro   L,      ;
                ChkSubn   L )
            SET NULL OFF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarSigSyCit - Carrega definicoes de campos de SigSyCit para este Tits
    *===========================================================================
    FUNCTION CarregarSigSyCit()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crSigSyCit")
                USE IN crSigSyCit
            ENDIF

            *-- Test mode without DB: create empty cursor so form can initialize
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                SET NULL ON
                CREATE CURSOR crSigSyCit (Tits C(20), Campos C(10), Descs C(60), Tipos C(1), ;
                    Ordems N(3,0), Listas N(1,0), Linhas N(3,0), Files C(200), Fields C(200), ;
                    Chaves C(100), cIdChaves C(38), CampoOAs C(20), CampoDAs C(20), ;
                    Associados C(100), Cadeado N(1,0), Vinculados C(100), ;
                    Obrigatorios N(1,0), Pictures C(50))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE

            loc_cSQL = "SELECT Tits, Campos, Descs, Tipos, Ordems, Listas, Linhas, Files," + ;
                       " Fields, Chaves, cIdChaves, CampoOAs, CampoDAs, Associados, Cadeado," + ;
                       " Vinculados, Obrigatorios, Pictures FROM SigSyCit" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + " ORDER BY Ordems"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigSyCit")
            IF loc_nResult > 0
                IF RECCOUNT("crSigSyCit") > 0
                    SELECT crSigSyCit
                    INDEX ON STR(Ordems, 2) TAG Ordems ADDITIVE
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar SigSyCit:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            ENDIF && gnConnHandle
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * ApanhaRespostas - Carrega todas as respostas de SigSyCrs em LocalCadRs indexado
    *===========================================================================
    FUNCTION ApanhaRespostas()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("LocalCadRs")
                USE IN LocalCadRs
            ENDIF
            loc_cSQL = "SELECT Cods, Campos, CAST(Resps AS VARCHAR(8000)) AS Resps" + ;
                       " FROM SigSyCrs WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " ORDER BY Cods, Campos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCadRs")
            IF loc_nResult > 0
                IF RECCOUNT("LocalCadRs") > 0
                    SELECT LocalCadRs
                    INDEX ON STR(Cods, 6) + Campos TAG CodCampos ADDITIVE
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar respostas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * AlimentaLista - Preenche colunas dinamicas de crSigSyCrs via LocalCadRs
    *===========================================================================
    PROCEDURE AlimentaLista()
        LOCAL loc_cCpo
        TRY
            IF USED("crSigSyCrs") AND USED("LocalCadRs") AND USED("crSigSyCit") ;
                    AND RECCOUNT("crSigSyCrs") > 0 AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCrs
                SCAN
                    SELECT crSigSyCit
                    SCAN
                        IF crSigSyCit.Listas = 1
                            loc_cCpo = ALLTRIM(crSigSyCit.Campos)
                            IF SEEK(STR(crSigSyCrs.Cods, 6) + crSigSyCit.Campos, ;
                                    "LocalCadRs", "CodCampos")
                                IF crSigSyCit.Tipos = "N"
                                    REPLACE &loc_cCpo. WITH VAL(LocalCadRs.Resps) IN crSigSyCrs
                                ELSE
                                    REPLACE &loc_cCpo. WITH LocalCadRs.Resps IN crSigSyCrs
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN
                    SELECT crSigSyCrs
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Buscar - Lista registros em crSigSyCrs com colunas dinamicas de SigSyCit
    * par_cFiltro: aceita "TODAS"/"" (sem filtro), status=0 (em aberto) ou "BAIXADAS" (ChkSubn=1)
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lResultado, loc_cCpo
        loc_lResultado = .F.
        IF VARTYPE(par_cFiltro) <> "C"
            par_cFiltro = ""
        ENDIF
        TRY
            IF !USED("crSigSyCit")
                THIS.CarregarSigSyCit()
            ENDIF
            IF !USED("LocalCadRs")
                THIS.ApanhaRespostas()
            ENDIF
            DO CASE
                CASE UPPER(ALLTRIM(par_cFiltro)) = "PENDENTES"
                    loc_cWhere = " AND ChkSubn = 0"
                CASE UPPER(ALLTRIM(par_cFiltro)) = "BAIXADAS"
                    loc_cWhere = " AND ChkSubn = 1"
                OTHERWISE
                    loc_cWhere = ""
            ENDCASE
            loc_cSQL = "SELECT DISTINCT ChkSubn, ChkApro, Cods"
            IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCit
                SCAN
                    IF crSigSyCit.Listas = 1
                        loc_cCpo = ALLTRIM(crSigSyCit.Campos)
                        DO CASE
                            CASE crSigSyCit.Tipos = "N"
                                loc_cSQL = loc_cSQL + ;
                                           ", CAST(9999999999.99 AS DECIMAL(14,2)) AS " + loc_cCpo
                            CASE crSigSyCit.Tipos = "M"
                                loc_cSQL = loc_cSQL + ", SPACE(50) AS " + loc_cCpo
                            OTHERWISE
                                loc_cSQL = loc_cSQL + ", SPACE(12) AS " + loc_cCpo
                        ENDCASE
                    ENDIF
                ENDSCAN
            ENDIF
            loc_cSQL = loc_cSQL + ;
                       " FROM SigSyCrs WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       loc_cWhere + " ORDER BY Cods"
            IF USED("crSigSyCrs")
                USE IN crSigSyCrs
            ENDIF
            *-- Test mode without DB: create empty cursor
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                SET NULL ON
                CREATE CURSOR crSigSyCrs (ChkSubn L, ChkApro L, Cods N(10,0))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigSyCrs")
                IF loc_nResult > 0
                    THIS.AlimentaLista()
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * GerarNovoCods - Gera proximo Cods disponivel para este Tits
    *===========================================================================
    FUNCTION GerarNovoCods()
        LOCAL loc_cSQL, loc_nCods, loc_nResult
        loc_nCods = 0
        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_nCods = 1
            ELSE
                loc_cSQL = "SELECT ISNULL(MAX(Cods), 0) + 1 AS NextCods FROM SigSyCrs" + ;
                           " WHERE Tits = " + EscaparSQL(THIS.this_cTits)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_NextCods")
                    TABLEREVERT(.T., "cursor_4c_NextCods")
                    USE IN cursor_4c_NextCods
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NextCods")
                IF loc_nResult > 0 AND !EOF("cursor_4c_NextCods")
                    loc_nCods = cursor_4c_NextCods.NextCods
                    USE IN cursor_4c_NextCods
                ELSE
                    MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    IF USED("cursor_4c_NextCods")
                        USE IN cursor_4c_NextCods
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCods
    ENDFUNC

    *===========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *===========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCods    = TratarNulo(Cods, "N")
                THIS.this_lChkApro = (TratarNulo(ChkApro, "N") <> 0)
                THIS.this_lChkSubn = (TratarNulo(ChkSubn, "N") <> 0)
                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarPorCodigo - Carrega propriedades do BO para um Cods especifico
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_nCods)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !USED("LocalCadRs")
                THIS.ApanhaRespostas()
            ENDIF
            IF USED("LocalCadRs")
                THIS.this_nCods = par_nCods
                IF SEEK(STR(par_nCods, 6) + PADR("Emps", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cEmps = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cEmps = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Dopes", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cDopes = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cDopes = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Numes", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cNumes = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cNumes = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Aprova", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cAprova = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cAprova = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Datas", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cDatas = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cDatas = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Baixa", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cBaixa = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cBaixa = ""
                ENDIF
            ENDIF
            IF USED("crSigSyCrs")
                SELECT crSigSyCrs
                LOCATE FOR Cods = par_nCods
                IF !EOF("crSigSyCrs")
                    THIS.this_lChkApro = crSigSyCrs.ChkApro
                    THIS.this_lChkSubn = crSigSyCrs.ChkSubn
                    loc_lResultado = .T.
                ENDIF
            ELSE
                loc_cSQL = "SELECT TOP 1 ChkApro, ChkSubn FROM SigSyCrs" + ;
                           " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(par_nCods)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_CarregaFlags")
                    TABLEREVERT(.T., "cursor_4c_CarregaFlags")
                    USE IN cursor_4c_CarregaFlags
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFlags")
                IF loc_nResult > 0 AND !EOF("cursor_4c_CarregaFlags")
                    THIS.this_lChkApro = (cursor_4c_CarregaFlags.ChkApro <> 0)
                    THIS.this_lChkSubn = (cursor_4c_CarregaFlags.ChkSubn <> 0)
                    loc_lResultado = .T.
                ENDIF
                IF USED("cursor_4c_CarregaFlags")
                    USE IN cursor_4c_CarregaFlags
                ENDIF
            ENDIF
            IF loc_lResultado
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * SalvarCampos - PRIVADO - Executa DELETE+INSERT de crGrvCadRs em SigSyCrs
    * Retorna .T. se salvou com sucesso
    *===========================================================================
    PROTECTED FUNCTION SalvarCampos()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_lTransacao
        loc_lResultado = .F.
        loc_lTransacao = .F.
        TRY
            IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") >= 0
                loc_lTransacao = .T.
            ELSE
                MsgErro("Erro ao iniciar transa" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF loc_lTransacao
                loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                           EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Erro ao excluir registros anteriores:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF
            IF loc_lTransacao AND USED("crGrvCadRs") AND RECCOUNT("crGrvCadRs") > 0
                SELECT crGrvCadRs
                SCAN WHILE loc_lTransacao
                    loc_cSQL = "INSERT INTO SigSyCrs" + ;
                               " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                               " VALUES (" + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Tits)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Campos)) + ", " + ;
                               FormatarNumeroSQL(crGrvCadRs.Cods) + ", " + ;
                               "CAST(NEWID() AS VARCHAR(38)), " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Resps)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Pergs)) + ", " + ;
                               IIF(crGrvCadRs.ChkApro, "1", "0") + ", " + ;
                               IIF(crGrvCadRs.ChkSubn, "1", "0") + ;
                               ")"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao inserir campo '" + ALLTRIM(crGrvCadRs.Campos) + ;
                                "':" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lTransacao = .F.
                    ENDIF
                ENDSCAN
            ENDIF
            IF loc_lTransacao
                IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") >= 0
                    loc_lTransacao = .F.
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro no commit:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransacao = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransacao = .F.
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Inserir - Salva novo registro (chamado por BusinessBase.Salvar)
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.SalvarCampos()
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Atualizar - Atualiza registro existente (chamado por BusinessBase.Salvar)
    * Usa padrao delete-insert identico ao original
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.SalvarCampos()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * ExecutarExclusao - Exclui todos os campos de um registro logico (Tits+Cods)
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Aprovar - Aprova o registro atual (seta ChkApro=.T., grava Aprova/Datas)
    * par_cUsuario: nome do usuario que esta aprovando
    *===========================================================================
    FUNCTION Aprovar(par_cUsuario)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cDataHora
        loc_lResultado = .F.
        TRY
            loc_cDataHora = TTOC(DATETIME())
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods) + ;
                       " AND Campos IN ('Aprova', 'Datas')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "INSERT INTO SigSyCrs" + ;
                       " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cTits) + ", 'Aprova', " + ;
                       FormatarNumeroSQL(THIS.this_nCods) + ", " + ;
                       "CAST(NEWID() AS VARCHAR(38)), " + ;
                       EscaparSQL(ALLTRIM(par_cUsuario)) + ", 'Aprovado', 1, 0)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_cSQL = "INSERT INTO SigSyCrs" + ;
                           " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cTits) + ", 'Datas', " + ;
                           FormatarNumeroSQL(THIS.this_nCods) + ", " + ;
                           "CAST(NEWID() AS VARCHAR(38)), " + ;
                           EscaparSQL(loc_cDataHora) + ", 'Data', 1, 0)"
                SQLEXEC(gnConnHandle, loc_cSQL)
                loc_cSQL = "UPDATE SigSyCrs SET ChkApro = 1" + ;
                           " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.this_lChkApro = .T.
                    THIS.this_cAprova  = ALLTRIM(par_cUsuario)
                    THIS.this_cDatas   = loc_cDataHora
                    THIS.ApanhaRespostas()
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao aprovar registro:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao gravar aprovador:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Desaprovar - Remove aprovacao do registro atual (seta ChkApro=.F.)
    *===========================================================================
    FUNCTION Desaprovar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods) + ;
                       " AND Campos IN ('Aprova', 'Datas')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "UPDATE SigSyCrs SET ChkApro = 0" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lChkApro = .F.
                THIS.this_cAprova  = ""
                THIS.this_cDatas   = ""
                THIS.ApanhaRespostas()
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao desaprovar registro:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CancelarBaixa - Cancela baixa do registro (seta ChkSubn=.F., remove campos de baixa)
    *===========================================================================
    FUNCTION CancelarBaixa(par_nCods)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(par_nCods) + ;
                       " AND Campos IN ('Emps', 'Dopes', 'Numes', 'Baixa')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "UPDATE SigSyCrs SET ChkSubn = 0" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(par_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lChkSubn = .F.
                THIS.this_cEmps    = ""
                THIS.this_cDopes   = ""
                THIS.this_cNumes   = ""
                THIS.this_cBaixa   = ""
                THIS.ApanhaRespostas()
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao cancelar baixa:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
