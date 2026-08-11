*==============================================================================
* GcpBO.prg
* Business Object: Grupos/Contas Permitidas por Operacao (SigCdGcp)
* Herda de: BusinessBase
*
* Tabela principal: SigCdGcp
* Chave primaria  : cidchaves (char 20, gerado via GerarCidChaves)
*
* SigCdGcp schema:
*   cidchaves  char(20) PK
*   contas     char(10) FK SigCdCli.iclis
*   dopes      char(20) FK SigCdOpe.Dopes
*   grupos     char(10) FK SigCdGcr.Codigos
*   orides     char(1)  O=Origem / D=Destino / A=Ambos
*   blqcts     numeric(1,0)  1=Permitidas / 2=Nao Permitidas
*==============================================================================

DEFINE CLASS GcpBO AS BusinessBase

    *-- Identificacao da tabela (exigido pelo BusinessBase)
    this_cTabela     = "SigCdGcp"
    this_cCampoChave = "cidchaves"

    *--------------------------------------------------------------------------
    * Propriedades de dados - mapeamento direto das colunas de SigCdGcp
    *--------------------------------------------------------------------------
    this_cCidChaves = ""   && char(20) - chave unica PK
    this_cContas    = ""   && char(10) - codigo da conta/cliente (FK SigCdCli.iclis)
    this_cDopes     = ""   && char(20) - codigo da operacao (FK SigCdOpe.Dopes)
    this_cGrupos    = ""   && char(10) - codigo do grupo contabil (FK SigCdGcr.Codigos)
    this_cOriDes    = ""   && char(1)  - O=Origem / D=Destino / A=Ambos
    this_nBlqCts    = 0    && numeric(1,0) - 1=Permitidas / 2=Nao Permitidas

    *--------------------------------------------------------------------------
    * Propriedades desnormalizadas (preenchidas via JOIN no carregamento)
    *--------------------------------------------------------------------------
    this_cDgrus = ""   && descricao do grupo  (SigCdGcr.Descrs)
    this_cRclis = ""   && nome do cliente/conta (SigCdCli.Rclis)

    *--------------------------------------------------------------------------
    * Propriedades de contexto de colecao
    * Este BO gerencia um CONJUNTO de registros para uma operacao
    *--------------------------------------------------------------------------
    this_cDopesAtual  = ""  && operacao atualmente sendo editada (filtro da colecao)
    this_nBlqCtsAtual = 1   && status da colecao (1=Permitidas / 2=Nao Permitidas)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGcp"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para o sistema de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCidChaves - Gera chave unica de 20 caracteres (substituto de fUniqueIds)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarCidChaves()
        LOCAL loc_cParte1, loc_cParte2
        loc_cParte1 = ALLTRIM(SYS(2015))
        loc_cParte2 = ALLTRIM(SYS(2015))
        RETURN PADR(loc_cParte1 + loc_cParte2, 20)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cContas    = TratarNulo(contas,    "C")
            THIS.this_cDopes     = TratarNulo(dopes,     "C")
            THIS.this_cGrupos    = TratarNulo(grupos,    "C")
            THIS.this_cOriDes    = TratarNulo(orides,    "C")
            THIS.this_nBlqCts    = TratarNulo(blqcts,    "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega registros de SigCdGcp com JOIN de descricoes
    * par_cFiltro: filtro adicional WHERE (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF !EMPTY(THIS.this_cDopesAtual)
                loc_cWhere = "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopesAtual)
            ENDIF
            IF TYPE("par_cFiltro") = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                IF EMPTY(loc_cWhere)
                    loc_cWhere = "WHERE " + par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.Contas, a.Dopes, a.Grupos," + ;
                       " a.OriDes, a.BlqCts," + ;
                       " ISNULL(b.Descrs,'') AS Dgrus," + ;
                       " ISNULL(c.Rclis,'') AS Rclis" + ;
                       " FROM SigCdGcp a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis   = a.Contas" + ;
                       " " + loc_cWhere + ;
                       " ORDER BY a.Grupos, a.Contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao buscar grupos/contas:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo CidChaves
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.Contas, a.Dopes, a.Grupos," + ;
                       " a.OriDes, a.BlqCts," + ;
                       " ISNULL(b.Descrs,'') AS Dgrus," + ;
                       " ISNULL(c.Rclis,'') AS Rclis" + ;
                       " FROM SigCdGcp a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis   = a.Contas" + ;
                       " WHERE a.CidChaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um registro em SigCdGcp (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = THIS.GerarCidChaves()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdGcp" + ;
                       " (CidChaves, Contas, Dopes, Grupos, OriDes, BlqCts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cContas)    + ", " + ;
                       EscaparSQL(THIS.this_cDopes)     + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)    + ", " + ;
                       EscaparSQL(THIS.this_cOriDes)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqCts) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo/conta:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro em SigCdGcp (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGcp SET" + ;
                       " Contas = " + EscaparSQL(THIS.this_cContas)         + "," + ;
                       " Dopes  = " + EscaparSQL(THIS.this_cDopes)          + "," + ;
                       " Grupos = " + EscaparSQL(THIS.this_cGrupos)         + "," + ;
                       " OriDes = " + EscaparSQL(THIS.this_cOriDes)         + "," + ;
                       " BlqCts = " + FormatarNumeroSQL(THIS.this_nBlqCts)  + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo/conta:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de um registro (chamado por BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGcp" + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao excluir grupo/conta:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTmpGcOpe - Cria cursor local TmpGcOpe com dados de uma operacao
    * par_cDopes  : codigo da operacao (SigCdOpe.Dopes)
    * par_nBlqCts : BlqCts inicial (1=Permitidas / 2=Nao Permitidas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTmpGcOpe(par_cDopes, par_nBlqCts)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cDopesAtual  = par_cDopes
            THIS.this_nBlqCtsAtual = par_nBlqCts

            IF USED("TmpGcOpe")
                USE IN TmpGcOpe
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpGcOpe ;
                (CidChaves C(20), Dopes C(20), Grupos C(10), Contas C(10), ;
                 Dgrus C(60), Rclis C(80), OriDes C(1), BlqCts N(1))
            SET NULL OFF

            loc_cSQL = "SELECT a.CidChaves, a.Dopes, a.Grupos, a.Contas," + ;
                       " ISNULL(b.Descrs,'') AS Dgrus," + ;
                       " ISNULL(c.Rclis,'') AS Rclis," + ;
                       " a.OriDes, a.BlqCts" + ;
                       " FROM SigCdGcp a" + ;
                       " LEFT JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis   = a.Contas" + ;
                       " WHERE a.Dopes = " + EscaparSQL(par_cDopes) + ;
                       " ORDER BY a.Grupos, a.Contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcpTemp")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_GcpTemp") > 0
                    SELECT TmpGcOpe
                    APPEND FROM DBF("cursor_4c_GcpTemp")
                ENDIF
                SELECT TmpGcOpe
                GO TOP
                loc_lResultado = .T.
            ELSE
                MostrarErro("Erro ao carregar grupos/contas da opera" + ;
                            CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_GcpTemp")
                USE IN cursor_4c_GcpTemp
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.CarregarTmpGcOpe")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicatas - Verifica se ha Grupos/Contas duplicados no TmpGcOpe
    * Retorna .T. se NAO ha duplicatas (pode salvar)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicatas()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        TRY
            IF USED("cursor_4c_SecKey")
                USE IN cursor_4c_SecKey
            ENDIF

            SELECT Grupos, Contas, SUM(1) AS Total ;
                FROM TmpGcOpe ;
                GROUP BY Grupos, Contas ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_SecKey NOFILTER

            IF RECCOUNT("cursor_4c_SecKey") > 0
                MostrarErro("Existem Grupos/Contas em duplicidade. Favor acertar!!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_SecKey")
                USE IN cursor_4c_SecKey
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ValidarDuplicatas")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarTmpGcOpe - Persiste TmpGcOpe no banco (SigCdGcp) para a operacao
    * Deleta registros antigos da operacao e insere os do TmpGcOpe
    * par_cDopes  : codigo da operacao
    * par_nBlqCts : BlqCts a aplicar em todos os registros
    *--------------------------------------------------------------------------
    PROCEDURE SalvarTmpGcOpe(par_cDopes, par_nBlqCts)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_cChave, loc_cGrupos, loc_cContas, loc_cOriDes, loc_nBlqCts
        loc_lResultado = .F.

        TRY
            IF !USED("TmpGcOpe")
                MostrarErro("Cursor TmpGcOpe n" + CHR(227) + ;
                            "o encontrado!", "Erro")
            ELSE
                *-- Remove linhas em branco do cursor local
                SELECT TmpGcOpe
                DELETE FOR EMPTY(ALLTRIM(Grupos)) OR EMPTY(ALLTRIM(Contas))
                PACK

                *-- Valida duplicatas antes de persistir
                IF !THIS.ValidarDuplicatas()
                    loc_lResultado = .F.
                ELSE
                    *-- Atualiza Dopes e BlqCts em todo o cursor local
                    SELECT TmpGcOpe
                    REPLACE ALL Dopes WITH par_cDopes, BlqCts WITH par_nBlqCts

                    *-- Garante CidChaves em linhas novas
                    GO TOP
                    DO WHILE !EOF()
                        IF EMPTY(ALLTRIM(CidChaves))
                            REPLACE CidChaves WITH THIS.GerarCidChaves()
                        ENDIF
                        SKIP
                    ENDDO

                    *-- Persiste no SQL Server em transacao atomica
                    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "cursor_4c_Trn")
                    IF USED("cursor_4c_Trn")
                        USE IN cursor_4c_Trn
                    ENDIF

                    *-- Deleta registros antigos da operacao
                    loc_cSQL = "DELETE FROM SigCdGcp WHERE Dopes = " + ;
                               EscaparSQL(par_cDopes)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                    IF USED("cursor_4c_Del")
                        USE IN cursor_4c_Del
                    ENDIF

                    IF loc_nResultado < 0
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
                        IF USED("cursor_4c_Rb")
                            USE IN cursor_4c_Rb
                        ENDIF
                        MostrarErro("Erro ao limpar registros antigos:" + CHR(13) + ;
                                    CapturarErroSQL(), "Erro SQL")
                        loc_lResultado = .F.
                    ELSE
                        *-- Insere linhas do TmpGcOpe
                        SELECT TmpGcOpe
                        GO TOP
                        loc_lResultado = .T.

                        DO WHILE !EOF() AND loc_lResultado
                            loc_cChave  = ALLTRIM(CidChaves)
                            loc_cGrupos = ALLTRIM(Grupos)
                            loc_cContas = ALLTRIM(Contas)
                            loc_cOriDes = ALLTRIM(OriDes)
                            loc_nBlqCts = BlqCts

                            loc_cSQL = "INSERT INTO SigCdGcp" + ;
                                       " (CidChaves, Dopes, Grupos, Contas, OriDes, BlqCts)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cChave)  + ", " + ;
                                       EscaparSQL(par_cDopes)  + ", " + ;
                                       EscaparSQL(loc_cGrupos) + ", " + ;
                                       EscaparSQL(loc_cContas) + ", " + ;
                                       EscaparSQL(loc_cOriDes) + ", " + ;
                                       FormatarNumeroSQL(loc_nBlqCts) + ;
                                       ")"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                            IF USED("cursor_4c_Ins")
                                USE IN cursor_4c_Ins
                            ENDIF

                            IF loc_nResultado < 0
                                MostrarErro("Erro ao inserir linha:" + CHR(13) + ;
                                            CapturarErroSQL(), "Erro SQL")
                                loc_lResultado = .F.
                            ENDIF

                            SKIP
                        ENDDO

                        IF loc_lResultado
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "cursor_4c_Cmt")
                            IF USED("cursor_4c_Cmt")
                                USE IN cursor_4c_Cmt
                            ENDIF
                            THIS.RegistrarAuditoria("INSERT")
                        ELSE
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
                            IF USED("cursor_4c_Rb")
                                USE IN cursor_4c_Rb
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
            IF USED("cursor_4c_Rb")
                USE IN cursor_4c_Rb
            ENDIF
            MostrarErro(loException, "GcpBO.SalvarTmpGcOpe")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida Grupo em SigCdGcr e retorna descricao
    * par_cGrupo : codigo a validar
    * par_cDescrs: (BYREF OUTPUT) descricao encontrada
    * Retorna .T. se grupo existe
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo(par_cGrupo, par_cDescrs)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        par_cDescrs    = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cGrupo))
                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF

                loc_cSQL = "SELECT Descrs FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(par_cGrupo)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Gcr") > 0
                    SELECT cursor_4c_Gcr
                    par_cDescrs = ALLTRIM(Descrs)
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ValidarGrupo")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - Valida Conta em SigCdCli e retorna Rclis
    * par_cConta : codigo da conta (SigCdCli.Iclis) a validar
    * par_cRclis : (BYREF OUTPUT) nome/razao social do cliente
    * Retorna .T. se conta existe
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConta(par_cConta, par_cRclis)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        par_cRclis     = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cConta))
                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF

                loc_cSQL = "SELECT Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(par_cConta)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Cli") > 0
                    SELECT cursor_4c_Cli
                    par_cRclis = ALLTRIM(Rclis)
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "GcpBO.ValidarConta")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("TmpGcOpe")
            USE IN TmpGcOpe
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
