*==============================================================================
* SIGPRCOTBO.prg - Business Object para Cotacao de Moeda
* Tabela principal: SigCdCot
* Tipo: OPERACIONAL
* Migracao de: SIGPRCOT.SCX
*==============================================================================
SET RESOURCE OFF
SET SAFETY OFF

DEFINE CLASS SIGPRCOTBO AS BusinessBase

    *-- Campos de SigCdCot (schema: docs/schema.sql)
    this_cMoes      = ""   && char(3)       - codigo da moeda
    this_dDatas     = {}   && date NULL      - data da cotacao
    this_cHoras     = ""   && char(8)        - hora da cotacao
    this_nValos     = 0    && numeric(11,6)  - valor da cotacao
    this_cCidChaves = ""   && char(20)       - chave unica (PK)
    this_dDtAlts    = {}   && date NULL      - data da ultima alteracao
    this_cUsuars    = ""   && char(10)       - usuario que inseriu/alterou

    *-- Nome do cursor de trabalho (grid de cotacoes)
    this_cCursorCotacoes = "cursor_4c_Cotacoes"

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdCot"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cMoes      = TratarNulo(cmoes,     "C")
            THIS.this_dDatas     = TratarNulo(datas,     "D")
            THIS.this_cHoras     = TratarNulo(horas,     "C")
            THIS.this_nValos     = TratarNulo(valos,     "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_dDtAlts    = TratarNulo(dtalts,    "D")
            THIS.this_cUsuars    = TratarNulo(usuars,    "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de inserir/atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cMoes))
            THIS.this_cMensagem = "Informe o c" + CHR(243) + "digo da moeda."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDatas)
            THIS.this_cMensagem = "Informe a data da cota" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF
        IF THIS.this_nValos <= 0
            THIS.this_cMensagem = "Informe o valor da cota" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave unica char(20) para cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarChaveUnica()
        RETURN LEFT(SYS(2015) + SYS(2015), 20)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCotacoes - Carrega cotacoes de uma moeda no cursor de trabalho
    * O cursor resultante (cursor_4c_Cotacoes) eh READWRITE para edicao no grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCotacoes(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCotacoes)
                USE IN (THIS.this_cCursorCotacoes)
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Cotacoes ;
                (cmoes C(3) NULL, datas D NULL, horas C(8) NULL, ;
                 valos N(11,6) NULL, cidchaves C(20) NULL, ;
                 dtalts D NULL, usuars C(10) NULL)
            SET NULL OFF

            INDEX ON cidchaves                    TAG CidChaves
            INDEX ON cmoes + DTOS(datas) + horas  TAG Cotacaos

            loc_cSQL = "SELECT cmoes, CAST(datas AS date) AS datas, horas, valos, " + ;
                "cidchaves, CAST(dtalts AS date) AS dtalts, usuars " + ;
                "FROM SigCdCot " + ;
                "WHERE cmoes = " + EscaparSQL(par_cMoeda) + " " + ;
                "ORDER BY datas DESC, horas DESC"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotacoesTemp")

            IF loc_nRet > 0
                IF USED("cursor_4c_CotacoesTemp") AND RECCOUNT("cursor_4c_CotacoesTemp") > 0
                    SELECT cursor_4c_Cotacoes
                    APPEND FROM DBF("cursor_4c_CotacoesTemp")
                ENDIF
                IF USED("cursor_4c_CotacoesTemp")
                    USE IN cursor_4c_CotacoesTemp
                ENDIF

                SELECT cursor_4c_Cotacoes
                IF RECCOUNT() > 0
                    SET ORDER TO TAG Cotacaos
                    GO BOTTOM
                ENDIF
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                IF USED("cursor_4c_CotacoesTemp")
                    USE IN cursor_4c_CotacoesTemp
                ENDIF
                MsgErro("Erro ao carregar cota" + CHR(231) + CHR(245) + "es: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirNovaCotacao - Insere nova cotacao vazia para a moeda informada
    * Verifica duplicidade: somente insere se nao houver cotacao para hoje
    * Replica logica do botao "inserir" do legado (Click do SIGPRCOT.inserir)
    *--------------------------------------------------------------------------
    PROCEDURE InserirNovaCotacao(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_cCidChave, loc_dHoje, loc_cHoras
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorCotacoes)
            RETURN .F.
        ENDIF

        TRY
            loc_dHoje  = DATE()
            loc_cHoras = TIME()

            *-- Verificar duplicidade no cursor (cotacao para hoje ja existe?)
            *-- Usa LOCATE porque SET EXACT ON impede SEEK parcial em indice composto
            SELECT cursor_4c_Cotacoes
            LOCATE FOR ALLTRIM(cmoes) = ALLTRIM(par_cMoeda) AND datas = loc_dHoje
            IF FOUND()
                MsgAviso("J" + CHR(225) + " existe cota" + CHR(231) + CHR(227) + ;
                    "o cadastrada para hoje.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Gerar chave unica
                loc_cCidChave = THIS.GerarChaveUnica()

                *-- INSERT no SQL Server (valos=0 inicialmente; usuario edita no grid)
                loc_cSQL = "INSERT INTO SigCdCot " + ;
                    "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;
                    "VALUES (" + ;
                    EscaparSQL(ALLTRIM(par_cMoeda)) + ", " + ;
                    FormatarDataSQL(loc_dHoje) + ", " + ;
                    EscaparSQL(loc_cHoras) + ", " + ;
                    "0, " + ;
                    EscaparSQL(loc_cCidChave) + ", " + ;
                    FormatarDataSQL(loc_dHoje) + ", " + ;
                    EscaparSQL(gc_4c_UsuarioLogado) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet > 0
                    *-- Adicionar ao cursor de trabalho; APPEND BLANK deixa ponteiro no novo registro
                    SELECT cursor_4c_Cotacoes
                    SET ORDER TO
                    APPEND BLANK
                    REPLACE cmoes     WITH ALLTRIM(par_cMoeda)
                    REPLACE datas     WITH loc_dHoje
                    REPLACE horas     WITH loc_cHoras
                    REPLACE valos     WITH 0
                    REPLACE cidchaves WITH loc_cCidChave
                    REPLACE dtalts    WITH loc_dHoje
                    REPLACE usuars    WITH gc_4c_UsuarioLogado

                    THIS.this_cCidChaves = loc_cCidChave
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lSucesso = .T.
                ELSE
                    AERROR(loc_aErro)
                    MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o: " + ;
                        loc_aErro[2], "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirCotacaoAtual - Exclui cotacao pelo cidchaves do registro corrente
    * Replica logica do botao "delete" do legado
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirCotacaoAtual(par_cCidChave)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cCidChave))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCdCot " + ;
                "WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChave))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                *-- Remover do cursor de trabalho
                IF USED(THIS.this_cCursorCotacoes)
                    SELECT cursor_4c_Cotacoes
                    LOCATE FOR ALLTRIM(cidchaves) = ALLTRIM(par_cCidChave)
                    IF FOUND()
                        DELETE
                        PACK
                        IF RECCOUNT() > 0
                            SET ORDER TO TAG Cotacaos
                            GO BOTTOM
                        ENDIF
                    ENDIF
                ENDIF

                THIS.this_cCidChaves = par_cCidChave
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlteracoesCursor - Sincroniza cursor de cotacoes com SQL Server
    * Replica logica do botao "sair" do legado:
    * 1. Remove registros com data vazia ou valor zero/null
    * 2. Atualiza SigCdCot com os valores editados no cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAlteracoesCursor()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cChave, loc_dDatas, loc_cHoras, loc_nValos
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorCotacoes)
            RETURN .F.
        ENDIF

        TRY
            *-- Passo 1: Remover registros incompletos (data vazia ou valor <= 0)
            SELECT cursor_4c_Cotacoes
            SET ORDER TO
            GO TOP
            SCAN
                loc_cChave = ALLTRIM(cidchaves)
                IF EMPTY(datas) OR NVL(valos, 0) <= 0
                    IF !EMPTY(loc_cChave)
                        loc_cSQL = "DELETE FROM SigCdCot " + ;
                            "WHERE cidchaves = " + EscaparSQL(loc_cChave)
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    SELECT cursor_4c_Cotacoes
                    DELETE
                ENDIF
                SELECT cursor_4c_Cotacoes
            ENDSCAN

            PACK

            *-- Passo 2: Atualizar SigCdCot com valores editados no cursor
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                loc_cChave  = ALLTRIM(cidchaves)
                loc_dDatas  = datas
                loc_cHoras  = ALLTRIM(horas)
                loc_nValos  = valos

                IF !EMPTY(loc_cChave)
                    loc_cSQL = "UPDATE SigCdCot SET " + ;
                        "datas = " + FormatarDataSQL(loc_dDatas) + ", " + ;
                        "horas = " + EscaparSQL(loc_cHoras) + ", " + ;
                        "valos = " + FormatarNumeroSQL(loc_nValos, 6) + ", " + ;
                        "dtalts = GETDATE(), " + ;
                        "usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
                        "WHERE cidchaves = " + EscaparSQL(loc_cChave)
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF

                SELECT cursor_4c_Cotacoes
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova cotacao usando propriedades this_* do BO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro, loc_cCidChave
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF !THIS.ValidarDados()
            MsgAviso(THIS.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cCidChave         = THIS.GerarChaveUnica()
            THIS.this_cCidChaves  = loc_cCidChave
            THIS.this_dDtAlts     = DATE()
            THIS.this_cUsuars     = gc_4c_UsuarioLogado

            IF EMPTY(ALLTRIM(THIS.this_cHoras))
                THIS.this_cHoras = TIME()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdCot " + ;
                "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cMoes) + ", " + ;
                FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                EscaparSQL(THIS.this_cHoras) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValos, 6) + ", " + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                FormatarDataSQL(THIS.this_dDtAlts) + ", " + ;
                EscaparSQL(THIS.this_cUsuars) + ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza cotacao existente usando propriedades this_* do BO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF !THIS.ValidarDados()
            MsgAviso(THIS.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = gc_4c_UsuarioLogado

            loc_cSQL = "UPDATE SigCdCot SET " + ;
                "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                "horas = " + EscaparSQL(THIS.this_cHoras) + ", " + ;
                "valos = " + FormatarNumeroSQL(THIS.this_nValos, 6) + ", " + ;
                "dtalts = " + FormatarDataSQL(THIS.this_dDtAlts) + ", " + ;
                "usuars = " + EscaparSQL(THIS.this_cUsuars) + " " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui cotacao de SigCdCot (chamado por Excluir() do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCot " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) VALUES (" + ;
                EscaparSQL("SigCdCot") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE
