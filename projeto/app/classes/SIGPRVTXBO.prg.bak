*==============================================================================
* SIGPRVTXBO.prg - Business Object para FormSIGPRVTX
* Importacao de planilha Excel para atualizacao de SKUs (sigprvtx)
* Data: 2026-07-19
* Tabela principal: sigprvtx | PK: cidchaves
* Tabela auxiliar: SigCdPac (leitura de sigkeys)
*==============================================================================
DEFINE CLASS SIGPRVTXBO AS BusinessBase

    *-- -----------------------------------------------------------------------
    *-- CHAVE DE CONFIGURACAO (SigCdPac.sigkeys - lida no Init do Form)
    *-- -----------------------------------------------------------------------
    this_cSigKey        = ""    && sigkeys char(3) - chave de pacote de config

    *-- -----------------------------------------------------------------------
    *-- CAMINHO DA PLANILHA SELECIONADA
    *-- -----------------------------------------------------------------------
    this_cPlanilha      = ""    && Caminho completo do arquivo .xls selecionado

    *-- -----------------------------------------------------------------------
    *-- CAMPOS DA TABELA sigprvtx (PK + campos da planilha + demais colunas)
    *-- -----------------------------------------------------------------------
    this_cCidChaves     = ""    && cidchaves char(20)  NOT NULL - PK (fUniqueIds)
    this_cNomeSku       = ""    && nomesku   char(100) NOT NULL
    this_cRefSku        = ""    && refsku    char(40)  NOT NULL
    this_cSkuAtivo      = ""    && skuativo  char(3)   NOT NULL
    this_cSkuId         = ""    && skuid     char(10)  NOT NULL
    this_cCpros         = ""    && cpros     char(14)  NOT NULL
    this_cDescritivo    = ""    && descritivo char(45) NOT NULL
    this_cTamanho       = ""    && tamanho   char(4)   NOT NULL
    this_nQtd           = 0     && qtd       numeric(11,3) NOT NULL
    this_nBxQtd         = 0     && bxqtd     numeric(11,3) NOT NULL
    this_lChkAtuStock   = .F.   && chkatustock bit NULL
    this_nPvens         = 0     && pvens     numeric(11,5) NOT NULL
    this_nPrecode       = 0     && precode   numeric(11,5) NOT NULL
    this_lCkVtexUp      = .F.   && ckvtexup  bit NULL
    this_lCkAtuDesc     = .F.   && ckAtudesc bit NULL
    this_nVtexProdId    = 0     && vtexProdId int NULL

    *-- -----------------------------------------------------------------------
    *-- NOME DO CURSOR DA GRADE (padrao OPERACIONAL - cursor_4c_Grade)
    *-- -----------------------------------------------------------------------
    this_cCursorDados   = "cursor_4c_Grade"

    *--------------------------------------------------------------------------
    * Init - Configura BO: tabela e campo-chave da sigprvtx
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "sigprvtx"
            THIS.this_cCampoChave = "cidchaves"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves do registro corrente
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cSkuId      = ALLTRIM(NVL(skuid, ""))
                THIS.this_cNomeSku    = ALLTRIM(NVL(nomesku, ""))
                THIS.this_cSkuAtivo   = ALLTRIM(NVL(skuativo, ""))
                THIS.this_cRefSku     = ALLTRIM(NVL(refsku, ""))
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor " + par_cAliasCursor + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " em uso"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um registro na tabela sigprvtx
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO sigprvtx " + ;
                "(cidchaves, nomesku, refsku, skuativo, skuid, " + ;
                "cpros, descritivo, tamanho, qtd, bxqtd, " + ;
                "chkatustock, pvens, precode, ckvtexup, ckAtudesc, vtexProdId) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cNomeSku, 100)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cRefSku, 40)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSkuAtivo, 3)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSkuId, 10)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cDescritivo, 45)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTamanho, 4)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtd, 3) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBxQtd, 3) + ", " + ;
                IIF(THIS.this_lChkAtuStock, "1", "NULL") + ", " + ;
                FormatarNumeroSQL(THIS.this_nPvens, 5) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPrecode, 5) + ", " + ;
                IIF(THIS.this_lCkVtexUp, "1", "NULL") + ", " + ;
                IIF(THIS.this_lCkAtuDesc, "1", "NULL") + ", " + ;
                IIF(THIS.this_nVtexProdId = 0, "NULL", FormatarNumeroSQL(THIS.this_nVtexProdId, 0)) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em sigprvtx (SKU: " + ;
                    ALLTRIM(THIS.this_cSkuId) + ")"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela sigprvtx
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_cVtexProdId
        loc_lSucesso    = .F.
        loc_cVtexProdId = IIF(THIS.this_nVtexProdId = 0, "NULL", FormatarNumeroSQL(THIS.this_nVtexProdId, 0))

        TRY
            loc_cSQL = "UPDATE sigprvtx SET " + ;
                "nomesku = "     + EscaparSQL(LEFT(THIS.this_cNomeSku, 100)) + ", " + ;
                "refsku = "      + EscaparSQL(LEFT(THIS.this_cRefSku, 40)) + ", " + ;
                "skuativo = "    + EscaparSQL(LEFT(THIS.this_cSkuAtivo, 3)) + ", " + ;
                "skuid = "       + EscaparSQL(LEFT(THIS.this_cSkuId, 10)) + ", " + ;
                "cpros = "       + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                "descritivo = "  + EscaparSQL(LEFT(THIS.this_cDescritivo, 45)) + ", " + ;
                "tamanho = "     + EscaparSQL(LEFT(THIS.this_cTamanho, 4)) + ", " + ;
                "qtd = "         + FormatarNumeroSQL(THIS.this_nQtd, 3) + ", " + ;
                "bxqtd = "       + FormatarNumeroSQL(THIS.this_nBxQtd, 3) + ", " + ;
                "chkatustock = " + IIF(THIS.this_lChkAtuStock, "1", "NULL") + ", " + ;
                "pvens = "       + FormatarNumeroSQL(THIS.this_nPvens, 5) + ", " + ;
                "precode = "     + FormatarNumeroSQL(THIS.this_nPrecode, 5) + ", " + ;
                "ckvtexup = "    + IIF(THIS.this_lCkVtexUp, "1", "NULL") + ", " + ;
                "ckAtudesc = "   + IIF(THIS.this_lCkAtuDesc, "1", "NULL") + ", " + ;
                "vtexProdId = "  + loc_cVtexProdId + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em sigprvtx (cidchaves: " + ;
                    ALLTRIM(THIS.this_cCidChaves) + ")"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - Popula o cursor da grade com os registros ja persistidos
    *                 em sigprvtx (usado por BtnVisualizarClick / refresh).
    *                 Cria cursor local com as 4 colunas do grid (skuid,
    *                 nomesku, skuativo, refsku) via SQLEXEC intermediario e
    *                 depois REPLICA em cursor local com nome canonico.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade(par_cCursorGrade)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCursorTmp
        loc_lSucesso   = .F.
        loc_cCursorTmp = "cursor_4c_GradeTmp"

        TRY
            loc_cSQL = "SELECT skuid, nomesku, skuativo, refsku FROM sigprvtx"

            IF USED(loc_cCursorTmp)
                USE IN (loc_cCursorTmp)
            ENDIF

            SET NULL ON
            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
                *-- (Re)cria cursor com nome canonico e ordem/estrutura
                *-- identicas ao placeholder do form (protege ColumnCount/tags)
                IF USED(par_cCursorGrade)
                    SELECT (par_cCursorGrade)
                    USE
                ENDIF

                CREATE CURSOR (par_cCursorGrade) (;
                    skuid    C(10)  NULL, ;
                    nomesku  C(100) NULL, ;
                    skuativo C(3)   NULL, ;
                    refsku   C(40)  NULL)
                SELECT (par_cCursorGrade)
                INDEX ON skuid TAG skuid

                SELECT (loc_cCursorTmp)
                GO TOP
                SCAN
                    INSERT INTO (par_cCursorGrade) ;
                        (skuid, nomesku, skuativo, refsku) VALUES ( ;
                            NVL(skuid, ""), ;
                            NVL(nomesku, ""), ;
                            NVL(skuativo, ""), ;
                            NVL(refsku, ""))
                    SELECT (loc_cCursorTmp)
                ENDSCAN

                IF USED(loc_cCursorTmp)
                    USE IN (loc_cCursorTmp)
                ENDIF

                SELECT (par_cCursorGrade)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao consultar sigprvtx"
            ENDIF
            SET NULL OFF
        CATCH TO loc_oErro
            SET NULL OFF
            IF USED(loc_cCursorTmp)
                USE IN (loc_cCursorTmp)
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarGrade - Deleta todos os registros de sigprvtx e reinsere a
    *                  partir do cursor da grade (replica logica cmdok.Click)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarGrade(par_cCursorGrade)
        LOCAL loc_lSucesso, loc_lTransacao, loc_cSQL
        loc_lSucesso = .F.
        loc_lTransacao = .F.

        TRY
            IF !USED(par_cCursorGrade)
                THIS.this_cMensagemErro = "Cursor " + par_cCursorGrade + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " em uso"
            ELSE
                SELECT (par_cCursorGrade)
                GO TOP

                IF RECCOUNT(par_cCursorGrade) = 0
                    THIS.this_cMensagemErro = "Nenhum registro para atualiza" + ;
                        CHR(231) + CHR(227) + "o"
                ELSE
                    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                    loc_lTransacao = .T.

                    loc_cSQL = "DELETE FROM sigprvtx"
                    loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL) >= 1)

                    IF loc_lSucesso
                        SELECT (par_cCursorGrade)
                        GO TOP

                        SCAN WHILE loc_lSucesso
                            IF THIS.CarregarDoCursor(par_cCursorGrade)
                                IF !THIS.Inserir()
                                    loc_lSucesso = .F.
                                ENDIF
                            ELSE
                                loc_lSucesso = .F.
                            ENDIF
                            SELECT (par_cCursorGrade)
                        ENDSCAN

                        IF loc_lSucesso
                            SQLEXEC(gnConnHandle, "COMMIT")
                            loc_lTransacao = .F.
                        ENDIF
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao excluir registros de sigprvtx"
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lSucesso AND loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
