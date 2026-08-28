*==============================================================================
* RccBO.prg - Business Object para Rateio de Centros de Custo
* Tabelas: SigCdRcc (cabecalho) + SigCdRci (itens)
* Migrado de: SIGCDRCC.SCX
*==============================================================================

DEFINE CLASS RccBO AS BusinessBase

    *-- Propriedades do cabecalho (SigCdRcc)
    this_cDescRats  = ""    && Descricao do rateio (PK)
    this_cEmpOs     = ""    && Codigo da empresa
    this_cCidChaves = ""    && Chave unica do registro
    this_dDatas     = {}    && Data de criacao
    this_dDtAlts    = {}    && Data de alteracao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdRcc"
        THIS.this_cCampoChave = "DescRats"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cDescRats
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigCdRcc
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.DescRats, a.EmpOs, b.Razas AS DEmpresa" + ;
                       " FROM SigCdRcc a" + ;
                       " LEFT JOIN SigCdEmp b ON b.CEmps = a.EmpOs" + ;
                       " ORDER BY a.DescRats"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = STRTRAN(loc_cSQL, " ORDER BY", ;
                    " WHERE a.DescRats LIKE " + EscaparSQL(par_cFiltro + "%") + " ORDER BY")
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar rateios: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo DescRats (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cDescRats)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DescRats, EmpOs, CidChaves, Datas, DtAlts" + ;
                       " FROM SigCdRcc" + ;
                       " WHERE DescRats = " + EscaparSQL(par_cDescRats)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.CarregarPorCodigo: " + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Preenche propriedades a partir do cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDescRats  = TratarNulo(DescRats, "C")
            THIS.this_cEmpOs     = TratarNulo(EmpOs, "C")
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_dDatas     = TratarNulo(Datas, "D")
            THIS.this_dDtAlts    = TratarNulo(DtAlts, "D")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensPorRateio - Carrega itens de SigCdRci para o grid (modo VISUALIZAR)
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensPorRateio(par_cDescRats)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.DescRats, a.Emps, a.Grupos, a.Contas," + ;
                       " a.PercRats, a.CidChaves, c.rclis AS Descs" + ;
                       " FROM SigCdRci a" + ;
                       " LEFT JOIN SigCdCli c ON c.iclis = a.Contas" + ;
                       " WHERE a.DescRats = " + EscaparSQL(par_cDescRats) + ;
                       " ORDER BY a.Grupos, a.Contas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Itens")
                TABLEREVERT(.T., "cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.CarregarItensPorRateio: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarClientesPorGrupoColetora - Popula cursor_4c_RateioEdit para edicao
    * Carrega todos os clientes do grupo coletora 9, marcando os ja salvos
    *--------------------------------------------------------------------------
    FUNCTION CarregarClientesPorGrupoColetora(par_cDescRatsExistente)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_RateioEdit")
                USE IN cursor_4c_RateioEdit
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_RateioEdit ( ;
                Marcas    I, ;
                Emps      C(3), ;
                Grupos    C(20), ;
                Contas    C(20), ;
                Descs     C(60), ;
                PercRats  N(5,2), ;
                Manual    I ;
            )
            SET NULL OFF

            loc_cSQL = "SELECT 0 AS Marcas, SPACE(3) AS Emps, a.grupos," + ;
                       " a.iclis AS Contas, a.rclis AS Descs," + ;
                       " CAST(0.00 AS NUMERIC(5,2)) AS PercRats, 0 AS Manual" + ;
                       " FROM SigCdCli a" + ;
                       " JOIN SigCdGcr b ON a.grupos = b.codigos" + ;
                       " WHERE b.coletors = 9" + ;
                       " ORDER BY a.grupos, a.rclis"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_RateioEditTemp")
                TABLEREVERT(.T., "cursor_4c_RateioEditTemp")
                USE IN cursor_4c_RateioEditTemp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RateioEditTemp")
            IF loc_nResultado >= 0
                SELECT cursor_4c_RateioEdit
                APPEND FROM DBF("cursor_4c_RateioEditTemp")
                USE IN cursor_4c_RateioEditTemp

                IF !EMPTY(par_cDescRatsExistente)
                    THIS.MarcarItensExistentes(par_cDescRatsExistente)
                ENDIF

                GO TOP IN cursor_4c_RateioEdit
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar clientes: " + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_RateioEditTemp")
                    USE IN cursor_4c_RateioEditTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.CarregarClientesPorGrupoColetora: " + loException.Message, "Erro")
            IF USED("cursor_4c_RateioEditTemp")
                USE IN cursor_4c_RateioEditTemp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarItensExistentes - Marca no cursor_4c_RateioEdit os itens ja salvos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MarcarItensExistentes(par_cDescRats)
        LOCAL loc_cSQL, loc_nResultado
        LOCAL loc_cGrupos, loc_cContas, loc_nPerc

        TRY
            loc_cSQL = "SELECT Grupos, Contas, PercRats FROM SigCdRci" + ;
                       " WHERE DescRats = " + EscaparSQL(par_cDescRats)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_RciExist")
                TABLEREVERT(.T., "cursor_4c_RciExist")
                USE IN cursor_4c_RciExist
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RciExist")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_RciExist") > 0
                SELECT cursor_4c_RateioEdit
                INDEX ON Grupos + Contas TAG GruConta ADDITIVE

                SELECT cursor_4c_RciExist
                GO TOP
                DO WHILE !EOF("cursor_4c_RciExist")
                    loc_cGrupos = ALLTRIM(cursor_4c_RciExist.Grupos)
                    loc_cContas = ALLTRIM(cursor_4c_RciExist.Contas)
                    loc_nPerc   = cursor_4c_RciExist.PercRats

                    IF SEEK(loc_cGrupos + loc_cContas, "cursor_4c_RateioEdit", "GruConta")
                        REPLACE Marcas WITH 1, PercRats WITH loc_nPerc IN cursor_4c_RateioEdit
                    ENDIF

                    SKIP IN cursor_4c_RciExist
                ENDDO
            ENDIF

            IF USED("cursor_4c_RciExist")
                USE IN cursor_4c_RciExist
            ENDIF

            SELECT cursor_4c_RateioEdit
            SET ORDER TO
            GO TOP
        CATCH TO loException
            MsgErro("Erro em MarcarItensExistentes: " + loException.Message, "Erro")
            IF USED("cursor_4c_RciExist")
                USE IN cursor_4c_RciExist
            ENDIF
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularRateioAuto - Distribui % automaticamente entre itens marcados
    *--------------------------------------------------------------------------
    PROCEDURE CalcularRateioAuto()
        LOCAL loc_nQtde, loc_nRat, loc_nPTotal

        IF !USED("cursor_4c_RateioEdit")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_RateioEdit
            loc_nQtde = 0
            GO TOP
            COUNT FOR Marcas = 1 TO loc_nQtde

            IF loc_nQtde > 0
                loc_nRat = ROUND(100 / loc_nQtde, 2)
                SCAN FOR Marcas = 1
                    REPLACE PercRats WITH loc_nRat IN cursor_4c_RateioEdit
                ENDSCAN
            ENDIF

            SELECT cursor_4c_RateioEdit
            loc_nPTotal = 0
            SUM PercRats TO loc_nPTotal

            IF loc_nPTotal > 100
                GO TOP
                LOCATE FOR Marcas = 1
                IF FOUND()
                    REPLACE PercRats WITH PercRats - (loc_nPTotal - 100) IN cursor_4c_RateioEdit
                ENDIF
                loc_nPTotal = 0
                SUM PercRats TO loc_nPTotal
            ENDIF

            IF !EMPTY(loc_nPTotal) AND loc_nPTotal < 100
                GO TOP
                LOCATE FOR Marcas = 1
                IF FOUND()
                    REPLACE PercRats WITH PercRats + ((loc_nPTotal - 100) * -1) IN cursor_4c_RateioEdit
                ENDIF
            ENDIF

            GO TOP
        CATCH TO loException
            MsgErro("Erro em RccBO.CalcularRateioAuto: " + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTotalRateio - Verifica se soma dos itens marcados = 100%
    *--------------------------------------------------------------------------
    FUNCTION ValidarTotalRateio()
        LOCAL loc_nTotal, loc_lValido
        loc_lValido = .F.

        IF !USED("cursor_4c_RateioEdit")
            MsgAviso("Nenhum item de rateio carregado.", "Aviso")
            RETURN loc_lValido
        ENDIF

        TRY
            SELECT cursor_4c_RateioEdit
            loc_nTotal = 0
            SUM PercRats FOR Marcas = 1 TO loc_nTotal

            IF loc_nTotal <> 100
                MsgAviso("Total de rateio diferente de 100%. " + ;
                    "Total atual: " + TRANSFORM(loc_nTotal) + "%", ;
                    "Lan" + CHR(231) + "amento incorreto")
            ELSE
                loc_lValido = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarTotalRateio: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDescricaoExistente - Checa duplicidade em INSERIR
    *--------------------------------------------------------------------------
    FUNCTION VerificarDescricaoExistente(par_cDescRats)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdRcc WHERE DescRats = " + ;
                       EscaparSQL(par_cDescRats)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkExist")
                TABLEREVERT(.T., "cursor_4c_ChkExist")
                USE IN cursor_4c_ChkExist
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExist")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkExist") > 0
                SELECT cursor_4c_ChkExist
                loc_lExiste = (cursor_4c_ChkExist.Total > 0)
            ENDIF
            IF USED("cursor_4c_ChkExist")
                USE IN cursor_4c_ChkExist
            ENDIF
        CATCH TO loException
            MsgErro("Erro em VerificarDescricaoExistente: " + loException.Message, "Erro")
            IF USED("cursor_4c_ChkExist")
                USE IN cursor_4c_ChkExist
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdRcc + SigCdRci (atomico)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lTransAberta
        loc_lSucesso     = .F.
        loc_lTransAberta = .F.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAberta = .T.

            loc_cSQL = "INSERT INTO SigCdRcc (CidChaves, DescRats, EmpOs, Datas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(SYS(2015)) + ", " + ;
                       EscaparSQL(THIS.this_cDescRats) + ", " + ;
                       EscaparSQL(THIS.this_cEmpOs) + ", " + ;
                       "GETDATE())"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                IF THIS.SalvarItensRateio()
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransAberta = .F.
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao salvar itens de rateio.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir cabe" + CHR(231) + "alho: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.Inserir: " + loException.Message, "Erro")
        ENDTRY

        IF loc_lTransAberta
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Recria SigCdRcc + SigCdRci atomicamente (delete+insert)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lTransAberta, loc_lEtapaOk
        loc_lSucesso     = .F.
        loc_lTransAberta = .F.
        loc_lEtapaOk     = .T.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAberta = .T.

            IF loc_lEtapaOk
                loc_cSQL = "DELETE FROM SigCdRci WHERE DescRats = " + ;
                           EscaparSQL(THIS.this_cDescRats)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao remover itens antigos: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                loc_cSQL = "DELETE FROM SigCdRcc WHERE DescRats = " + ;
                           EscaparSQL(THIS.this_cDescRats)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao remover cabe" + CHR(231) + "alho antigo: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                loc_cSQL = "INSERT INTO SigCdRcc (CidChaves, DescRats, EmpOs, Datas, DtAlts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                           EscaparSQL(THIS.this_cDescRats) + ", " + ;
                           EscaparSQL(THIS.this_cEmpOs) + ", " + ;
                           FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "GETDATE())"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao reinserir cabe" + CHR(231) + "alho: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                IF THIS.SalvarItensRateio()
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransAberta = .F.
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao salvar itens de rateio.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.Atualizar: " + loException.Message, "Erro")
        ENDTRY

        IF loc_lTransAberta
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarItensRateio - INSERT em SigCdRci para cada item marcado no cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SalvarItensRateio()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .T.

        IF !USED("cursor_4c_RateioEdit")
            RETURN .T.
        ENDIF

        TRY
            SELECT cursor_4c_RateioEdit
            GO TOP
            SCAN FOR Marcas = 1
                IF EMPTY(Grupos) AND EMPTY(Contas)
                    LOOP
                ENDIF

                loc_cSQL = "INSERT INTO SigCdRci" + ;
                           " (CidChaves, DescRats, Emps, Grupos, Contas, PercRats)" + ;
                           " VALUES (" + ;
                           EscaparSQL(SYS(2015)) + ", " + ;
                           EscaparSQL(THIS.this_cDescRats) + ", " + ;
                           EscaparSQL(Emps) + ", " + ;
                           EscaparSQL(Grupos) + ", " + ;
                           EscaparSQL(Contas) + ", " + ;
                           FormatarNumeroSQL(PercRats) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir item de rateio: " + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN
        CATCH TO loException
            MsgErro("Erro em SalvarItensRateio: " + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdRci e SigCdRcc (atomico)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lTransAberta, loc_lEtapaOk
        loc_lSucesso     = .F.
        loc_lTransAberta = .F.
        loc_lEtapaOk     = .T.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAberta = .T.

            IF loc_lEtapaOk
                loc_cSQL = "DELETE FROM SigCdRci WHERE DescRats = " + ;
                           EscaparSQL(THIS.this_cDescRats)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir itens: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                loc_cSQL = "DELETE FROM SigCdRcc WHERE DescRats = " + ;
                           EscaparSQL(THIS.this_cDescRats)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir cabe" + CHR(231) + "alho: " + CapturarErroSQL(), "Erro SQL")
                    loc_lEtapaOk = .F.
                ENDIF
            ENDIF

            IF loc_lEtapaOk
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                loc_lTransAberta = .F.
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em RccBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        IF loc_lTransAberta
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_RateioEdit")
            USE IN cursor_4c_RateioEdit
        ENDIF
        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
