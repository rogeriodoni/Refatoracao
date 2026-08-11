*******************************************************************************
* sigprtamBO.prg - Business Object: Peso Medio por Tamanho do Produto
* Herda de BusinessBase
* Tabela principal: sigprtam
*******************************************************************************

DEFINE CLASS sigprtamBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela     = "sigprtam"
    this_cCampoChave = "cidchaves"

    *-- Chave primaria
    this_cCidChaves  = ""

    *-- Codigo do tamanho (FK -> SigCdTam.cods)
    this_cCodTams    = ""

    *-- Descricao do tamanho (virtual - SigCdTam.descs, nao persiste em sigprtam)
    this_cDescs      = ""

    *-- Codigo do produto (FK -> SigCdPro.cpros)
    this_cCPros      = ""

    *-- Peso medio por tamanho
    this_nPesoMs     = 0

    *-- Percentual sobre preco de venda
    this_nPercs      = 0

    *-- Valor calculado (preco de venda + percentual)
    this_nValor      = 0

    *-- Dias prazo de entrega
    this_nDiasPrz    = 0

    *-- Data da ultima alteracao
    this_dDataAlts   = {}

    *-- Data de transferencia
    this_dDataTrans  = {}

    *-- Data de movimento
    this_dDtMovs     = {}

    *-- Contexto do produto pai (carregado de SigCdPro)
    this_cDPros      = ""
    this_nPVens      = 0
    this_nPCuss      = 0

    *-- Nome do cursor de trabalho para o grid de tamanhos
    this_cCursorDados = "cursor_4c_TamPro"

    *---------------------------------------------------------------------------
    PROCEDURE Init()
    *---------------------------------------------------------------------------
        THIS.this_cTabela     = "sigprtam"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *---------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = NVL(ALLTRIM(cidchaves), "")
            THIS.this_cCodTams    = NVL(ALLTRIM(codtams), "")
            THIS.this_cCPros      = NVL(ALLTRIM(cpros), "")
            THIS.this_nPesoMs     = NVL(pesoms, 0)
            THIS.this_nPercs      = NVL(percs, 0)
            THIS.this_nValor      = NVL(valor, 0)
            THIS.this_nDiasPrz    = NVL(diasprz, 0)
            THIS.this_dDataAlts   = NVL(dataalts, {})
            THIS.this_dDataTrans  = NVL(datatrans, {})
            THIS.this_dDtMovs     = NVL(dtmovs, {})
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarTamanhos - Carrega tamanhos do produto do SQL Server para cursor
    * par_cCPros: codigo do produto
    *---------------------------------------------------------------------------
    PROCEDURE CarregarTamanhos(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                IF USED(THIS.this_cCursorDados)
                    TABLEREVERT(.T., THIS.this_cCursorDados)
                ENDIF
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cSql = "SELECT a.cidchaves, a.codtams, a.cpros, " + ;
                        "       a.pesoms, a.percs, a.valor, a.diasprz, " + ;
                        "       a.dataalts, a.datatrans, a.dtmovs, " + ;
                        "       ISNULL(b.descs, '') AS descs " + ;
                        "  FROM sigprtam a " + ;
                        "  LEFT JOIN SigCdTam b ON b.cods = a.codtams " + ;
                        " WHERE a.cpros = " + EscaparSQL(par_cCPros) + ;
                        " ORDER BY a.codtams"

            IF SQLEXEC(gnConnHandle, loc_cSql, THIS.this_cCursorDados) > 0
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar tamanhos do produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarProduto - Carrega dados do produto pai (PVens, PCuss, Dpros)
    * par_cCPros: codigo do produto
    *---------------------------------------------------------------------------
    PROCEDURE CarregarProduto(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_ProdutoPai")
                USE IN cursor_4c_ProdutoPai
            ENDIF
            loc_cSql = "SELECT TOP 1 dpros, pvens, pcuss " + ;
                        "  FROM SigCdPro " + ;
                        " WHERE cpros = " + EscaparSQL(par_cCPros)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_ProdutoPai") > 0
                IF !EOF("cursor_4c_ProdutoPai")
                    SELECT cursor_4c_ProdutoPai
                    THIS.this_cDPros  = NVL(ALLTRIM(dpros), "")
                    THIS.this_nPVens  = NVL(pvens, 0)
                    THIS.this_nPCuss  = NVL(pcuss, 0)
                    loc_lSucesso = .T.
                ENDIF
                USE IN cursor_4c_ProdutoPai
            ELSE
                MsgErro("Erro ao carregar dados do produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_ProdutoPai")
                USE IN cursor_4c_ProdutoPai
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * InserirLinhaGrid - Insere linha em branco no cursor do grid (local)
    * par_cCPros: codigo do produto
    *---------------------------------------------------------------------------
    PROCEDURE InserirLinhaGrid(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cIdChaves
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados)
                MsgErro("Cursor de tamanhos n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar se ja existe linha vazia para este produto
            SELECT (THIS.this_cCursorDados)
            LOCATE FOR ALLTRIM(codtams) = "" AND ALLTRIM(cpros) = ALLTRIM(par_cCPros)
            IF !EOF()
                loc_lSucesso = .T.
            ENDIF

            loc_cIdChaves = fUniqueIds()

            INSERT INTO (THIS.this_cCursorDados) ;
                (cidchaves, codtams, cpros, descs, pesoms, percs, valor, diasprz) ;
                VALUES (loc_cIdChaves, "", par_cCPros, "", 0, 0, 0, 0)

            SELECT (THIS.this_cCursorDados)
            GO BOTTOM
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExcluirLinhaGrid - Remove linha corrente do cursor do grid (local)
    * par_cCPros: codigo do produto
    *---------------------------------------------------------------------------
    PROCEDURE ExcluirLinhaGrid(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados)
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorDados)
            IF !EOF() AND ALLTRIM(cpros) = ALLTRIM(par_cCPros)
                DELETE
                SKIP
                IF EOF()
                    SKIP -1
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarTamanhoExiste - Verifica se codtams ja esta em uso para cpros
    * (exceto o registro corrente identificado por cIdChaves)
    * Retorna .T. se duplicado (ja existe), .F. se OK
    *---------------------------------------------------------------------------
    PROCEDURE ValidarTamanhoExiste(par_cCodTams, par_cIdChavesAtual)
    *---------------------------------------------------------------------------
        LOCAL loc_lDuplicado, loc_oErro
        loc_lDuplicado = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                LOCATE FOR ALLTRIM(codtams) = ALLTRIM(par_cCodTams) AND ;
                           ALLTRIM(cidchaves) <> ALLTRIM(par_cIdChavesAtual)
                loc_lDuplicado = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicado
    ENDPROC

    *---------------------------------------------------------------------------
    * BuscarDescricaoTamanho - Busca descricao do tamanho em SigCdTam
    * par_cCodTams: codigo do tamanho
    * Retorna descricao (string) ou "" se nao encontrado
    *---------------------------------------------------------------------------
    PROCEDURE BuscarDescricaoTamanho(par_cCodTams)
    *---------------------------------------------------------------------------
        LOCAL loc_cDescs, loc_oErro, loc_cSql
        loc_cDescs = ""
        TRY
            IF USED("cursor_4c_BuscaTam")
                USE IN cursor_4c_BuscaTam
            ENDIF
            loc_cSql = "SELECT TOP 1 cods, descs FROM SigCdTam " + ;
                        " WHERE cods = " + EscaparSQL(par_cCodTams)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_BuscaTam") > 0
                IF !EOF("cursor_4c_BuscaTam")
                    SELECT cursor_4c_BuscaTam
                    loc_cDescs = NVL(ALLTRIM(descs), "")
                ENDIF
                USE IN cursor_4c_BuscaTam
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaTam")
                USE IN cursor_4c_BuscaTam
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cDescs
    ENDPROC

    *---------------------------------------------------------------------------
    * SalvarTamanhos - Persiste todas as linhas do cursor no SQL Server
    * par_cCPros: codigo do produto
    * Estrategia: DELETE all + INSERT all (mesma logica do legado via TABLEREVERT/TABLEUPDATE)
    *---------------------------------------------------------------------------
    PROCEDURE SalvarTamanhos(par_cCPros)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        LOCAL loc_cCidChaves, loc_cCodTams, loc_nPesoMs
        LOCAL loc_nPercs, loc_nValor, loc_nDiasPrz
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados)
                loc_lSucesso = .F.
            ENDIF

            *-- Validar: todos os registros devem ter tamanho informado
            SELECT (THIS.this_cCursorDados)
            SCAN
                IF EMPTY(ALLTRIM(codtams))
                    MsgAviso("Tamanho n" + CHR(227) + "o informado!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN

            *-- Deletar registros existentes no SQL Server
            loc_cSql = "DELETE FROM sigprtam WHERE cpros = " + EscaparSQL(par_cCPros)
            IF SQLEXEC(gnConnHandle, loc_cSql) < 0
                MsgErro("Erro ao excluir tamanhos anteriores.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Inserir todos os registros do cursor
            SELECT (THIS.this_cCursorDados)
            SCAN FOR !DELETED() AND ALLTRIM(cpros) = ALLTRIM(par_cCPros) ;
                AND !EMPTY(ALLTRIM(codtams))
                loc_cCidChaves = ALLTRIM(cidchaves)
                loc_cCodTams   = ALLTRIM(codtams)
                loc_nPesoMs    = NVL(pesoms, 0)
                loc_nPercs     = NVL(percs, 0)
                loc_nValor     = NVL(valor, 0)
                loc_nDiasPrz   = NVL(diasprz, 0)

                loc_cSql = "INSERT INTO sigprtam " + ;
                            "(cidchaves, codtams, cpros, pesoms, percs, valor, diasprz, dataalts) " + ;
                            "VALUES (" + ;
                            EscaparSQL(loc_cCidChaves) + ", " + ;
                            EscaparSQL(loc_cCodTams) + ", " + ;
                            EscaparSQL(par_cCPros) + ", " + ;
                            FormatarNumeroSQL(loc_nPesoMs, 3) + ", " + ;
                            FormatarNumeroSQL(loc_nPercs, 2) + ", " + ;
                            FormatarNumeroSQL(loc_nValor, 5) + ", " + ;
                            FormatarNumeroSQL(loc_nDiasPrz, 0) + ", " + ;
                            "GETDATE())"

                IF SQLEXEC(gnConnHandle, loc_cSql) < 0
                    MsgErro("Erro ao salvar tamanho " + loc_cCodTams + ".", "Erro")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularValorPorPercentual - Calcula Valor a partir de Percs e PVens
    * par_nPercs:  percentual informado
    * par_nPVens:  preco de venda do produto
    * Retorna valor calculado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularValorPorPercentual(par_nPercs, par_nPVens)
    *---------------------------------------------------------------------------
        LOCAL loc_nValor
        loc_nValor = 0
        IF par_nPVens <> 0 AND par_nPercs <> 0
            loc_nValor = par_nPVens + (par_nPVens * (par_nPercs / 100))
        ENDIF
        RETURN loc_nValor
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularPercentualPorValor - Calcula Percs a partir de Valor e PVens
    * par_nValor:  valor informado
    * par_nPVens:  preco de venda do produto
    * Retorna percentual calculado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularPercentualPorValor(par_nValor, par_nPVens)
    *---------------------------------------------------------------------------
        LOCAL loc_nPercs
        loc_nPercs = 0
        IF par_nPVens <> 0 AND par_nValor <> 0
            loc_nPercs = ((par_nValor - par_nPVens) / par_nPVens) * 100
        ENDIF
        RETURN loc_nPercs
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Insere um unico registro de tamanho no SQL Server
    * Usa as propriedades this_* para montar o INSERT
    *---------------------------------------------------------------------------
    PROCEDURE Inserir()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSql = "INSERT INTO sigprtam " + ;
                        "(cidchaves, codtams, cpros, " + ;
                        " pesoms, percs, valor, diasprz, dataalts) " + ;
                        "VALUES (" + ;
                        EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                        EscaparSQL(THIS.this_cCodTams) + ", " + ;
                        EscaparSQL(THIS.this_cCPros) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nPesoMs, 3) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nPercs, 2) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nValor, 5) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nDiasPrz, 0) + ", " + ;
                        "GETDATE())"

            IF SQLEXEC(gnConnHandle, loc_cSql) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tamanho " + ALLTRIM(THIS.this_cCodTams) + ".", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Atualiza um unico registro de tamanho no SQL Server
    * Usa as propriedades this_* para montar o UPDATE
    *---------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            loc_cSql = "UPDATE sigprtam SET " + ;
                        " codtams = " + EscaparSQL(THIS.this_cCodTams) + ", " + ;
                        " cpros   = " + EscaparSQL(THIS.this_cCPros) + ", " + ;
                        " pesoms  = " + FormatarNumeroSQL(THIS.this_nPesoMs, 3) + ", " + ;
                        " percs   = " + FormatarNumeroSQL(THIS.this_nPercs, 2) + ", " + ;
                        " valor   = " + FormatarNumeroSQL(THIS.this_nValor, 5) + ", " + ;
                        " diasprz = " + FormatarNumeroSQL(THIS.this_nDiasPrz, 0) + ", " + ;
                        " dataalts = GETDATE() " + ;
                        " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSql) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tamanho " + ALLTRIM(THIS.this_cCodTams) + ".", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExecutarExclusao - Remove um registro de tamanho do SQL Server (PROTECTED)
    * Chamado por BusinessBase.Excluir()
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            loc_cSql = "DELETE FROM sigprtam " + ;
                        " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSql) > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir tamanho.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


ENDDEFINE
