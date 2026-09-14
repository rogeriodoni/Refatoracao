*==============================================================================
* SigPrRssBO.prg - Business Object: Rec" + CHR(225) + "lculo de Saldos
* Tabela principal: SigPrSlS (fila de processamento de saldos)
* Gerado: 2026-07-18
*==============================================================================
DEFINE CLASS SigPrRssBO AS BusinessBase

    *-- Tabela e chave
    this_cTabela     = "SigPrSlS"
    this_cCampoChave = "CidChaves"

    *-- Controle de processamento (mapeados das props legadas do form)
    this_lParametrizado = .F.   && Iniciado via linha de comando (modo batch)
    this_cUsuario       = "          "   && Filtro de usuario (Space(10))
    this_lOnline        = .F.   && Modo online (processa apenas registros Onlines=1)

    *-- Estado de execucao
    this_lProcessando  = .F.   && .T. enquanto loop principal esta rodando
    this_lErroConexao  = .F.   && .T. se houve queda de conexao com BD

    *-- Campos de SigOpCls usados no processamento
    this_cCidChaves    = ""    && Chave do registro em processamento
    this_cGrupos       = ""    && Grupo da conta
    this_cContas       = ""    && Conta
    this_cMoedas       = ""    && Moeda
    this_dDatas        = {}    && Data do lancamento
    this_nOnlines      = 0     && Flag online (NUMERIC 1,0)
    this_cUsuars       = ""    && Usuario do lancamento
    this_cGruConMoes   = ""    && Chave composta grupo+conta+moeda

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            THIS.this_cContas     = TratarNulo(contas,     "C")
            THIS.this_cMoedas     = TratarNulo(moedas,     "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_nOnlines    = NVL(onlines, 0)
            THIS.this_cUsuars     = TratarNulo(usuars,     "C")
            THIS.this_cGruConMoes = TratarNulo(gruconmoes, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *--------------------------------------------------------------------------
        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cMensagemErro = "CidChaves obrigat" + CHR(243) + "rio."
            MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "INSERT INTO SigPrSlS " + ;
                    "(cidchaves, contas, datas, gruconmoes, grupos, moedas, onlines, usuars) " + ;
                    "VALUES (" + ;
                    EscaparSQL(THIS.this_cCidChaves)             + ", " + ;
                    EscaparSQL(THIS.this_cContas)                + ", " + ;
                    FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                    EscaparSQL(THIS.this_cGruConMoes)            + ", " + ;
                    EscaparSQL(THIS.this_cGrupos)                + ", " + ;
                    EscaparSQL(THIS.this_cMoedas)                + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOnlines, 0)     + ", " + ;
                    EscaparSQL(THIS.this_cUsuars)                + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao inserir em SigPrSlS." + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir em SigPrSlS:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigPrSlS SET " + ;
                    "contas     = " + EscaparSQL(THIS.this_cContas)            + ", " + ;
                    "datas      = " + FormatarDataSQL(THIS.this_dDatas)        + ", " + ;
                    "gruconmoes = " + EscaparSQL(THIS.this_cGruConMoes)        + ", " + ;
                    "grupos     = " + EscaparSQL(THIS.this_cGrupos)            + ", " + ;
                    "moedas     = " + EscaparSQL(THIS.this_cMoedas)            + ", " + ;
                    "onlines    = " + FormatarNumeroSQL(THIS.this_nOnlines, 0) + ", " + ;
                    "usuars     = " + EscaparSQL(THIS.this_cUsuars)            + " " + ;
                    "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao atualizar SigPrSlS." + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar SigPrSlS:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNaFila - Consulta SigOpCls para obter registros a processar
    * Popula cursor CrSigOpCls. Filtros: usuario especifico e/ou modo online.
    *--------------------------------------------------------------------------
    FUNCTION BuscarNaFila(par_cUsuario, par_lOnline)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF USED("CrSigOpCls")
                USE IN CrSigOpCls
            ENDIF

            IF !EMPTY(par_cUsuario) OR par_lOnline
                loc_cSQL = "SELECT 0 AS Flag, * FROM SigOpCls WHERE Onlines = 1"
                IF !EMPTY(par_cUsuario)
                    loc_cSQL = loc_cSQL + " AND Usuars = " + EscaparSQL(par_cUsuario)
                ENDIF
                loc_cSQL = loc_cSQL + " ORDER BY GruConMoes"
            ELSE
                loc_cSQL = "SELECT 0 AS Flag, * FROM SigOpCls ORDER BY GruConMoes"
            ENDIF

            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCls") > 0)
        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar registros em SigOpCls:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarProcessando - Toca registro em SigOpCls (lock otimista)
    *--------------------------------------------------------------------------
    FUNCTION MarcarProcessando(par_cCidChaves)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = (SQLEXEC(gnConnHandle, ;
                "UPDATE SigOpCls SET Usuars = Usuars " + ;
                "WHERE CidChaves = " + EscaparSQL(par_cCidChaves)) > 0)
        CATCH TO loc_oErro
            MostrarErro("Erro ao marcar processamento em SigOpCls:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarMovimentos - Verifica se existe impeditivo em SigMvSlc/SigMvCcr
    * Retorna .T. se pode continuar o processamento do registro
    *--------------------------------------------------------------------------
    FUNCTION VerificarMovimentos(par_cGruConMoes)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRes
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpSccr")
                USE IN cursor_4c_TmpSccr
            ENDIF

            *-- Verificar SigMvSlc
            loc_cSQL = "SELECT CidChaves FROM SigMvSlc " + ;
                "WHERE GruConMoes = " + EscaparSQL(par_cGruConMoes)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSccr")

            IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpSccr") > 0
                loc_lSucesso = .T.
            ELSE
                *-- Verificar SigMvCcr
                IF USED("cursor_4c_TmpMccr")
                    USE IN cursor_4c_TmpMccr
                ENDIF

                loc_cSQL = "SELECT GruConMoes, SUM(1) AS TT FROM SigMvCcr " + ;
                    "WHERE GruConMoes = " + EscaparSQL(par_cGruConMoes) + " " + ;
                    "GROUP BY GruConMoes"
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccr")

                IF loc_nRes >= 0 AND USED("cursor_4c_TmpMccr") AND ;
                        RECCOUNT("cursor_4c_TmpMccr") > 0 AND cursor_4c_TmpMccr.TT > 0
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao verificar movimentos:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarHistorico - Registra em SigPrSlS o lancamento processado
    * Equivale ao SCATTER CrSigOpCls / ZAP CrSigPrSlS / APPEND / GATHER do legado
    *--------------------------------------------------------------------------
    FUNCTION GravarHistorico(par_cCidChaves, par_cGrupos, par_cContas, par_dDatas, ;
                             par_cMoedas, par_cGruConMoes, par_nOnlines, par_cUsuars)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nCheck
        loc_lSucesso = .F.

        TRY
            *-- Remover entrada anterior se existir (emula ZAP do cursor)
            IF USED("cursor_4c_ChkSlS")
                USE IN cursor_4c_ChkSlS
            ENDIF
            loc_nCheck = SQLEXEC(gnConnHandle, ;
                "SELECT cidchaves FROM SigPrSlS WHERE cidchaves = " + ;
                EscaparSQL(par_cCidChaves), "cursor_4c_ChkSlS")
            IF loc_nCheck > 0 AND RECCOUNT("cursor_4c_ChkSlS") > 0
                SQLEXEC(gnConnHandle, "DELETE FROM SigPrSlS WHERE cidchaves = " + ;
                    EscaparSQL(par_cCidChaves))
            ENDIF

            loc_cSQL = "INSERT INTO SigPrSlS " + ;
                "(cidchaves, contas, datas, gruconmoes, grupos, moedas, onlines, usuars) " + ;
                "VALUES (" + ;
                EscaparSQL(par_cCidChaves)          + ", " + ;
                EscaparSQL(par_cContas)              + ", " + ;
                FormatarDataSQL(par_dDatas)          + ", " + ;
                EscaparSQL(par_cGruConMoes)          + ", " + ;
                EscaparSQL(par_cGrupos)              + ", " + ;
                EscaparSQL(par_cMoedas)              + ", " + ;
                FormatarNumeroSQL(par_nOnlines, 0)   + ", " + ;
                EscaparSQL(par_cUsuars)              + ")"

            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL) > 0)
        CATCH TO loc_oErro
            MostrarErro("Erro ao gravar hist" + CHR(243) + "rico em SigPrSlS:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DeletarDaFila - Remove registro ja processado da fila SigOpCls
    *--------------------------------------------------------------------------
    FUNCTION DeletarDaFila(par_cCidChaves)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = (SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigOpCls WHERE CidChaves = " + ;
                EscaparSQL(par_cCidChaves)) > 0)
        CATCH TO loc_oErro
            MostrarErro("Erro ao remover da fila SigOpCls:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularSaldo - Invoca fRecalculaS (Framework legado) para recalc de saldo
    * Equivale a: fRecalculaS(Grupos, Contas, Datas, Moedas, DataMgr) do legado
    *--------------------------------------------------------------------------
    FUNCTION RecalcularSaldo(par_cGrupos, par_cContas, par_dDatas, par_cMoedas)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = fRecalculaS(par_cGrupos, par_cContas, par_dDatas, ;
                par_cMoedas, gnConnHandle)
        CATCH TO loc_oErro
            MostrarErro("Erro ao recalcular saldo:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FinalizarRecalculo - Segunda chamada de fRecalculaS (modo finalizacao)
    * Equivale a: fRecalculaS(.T., DataMgr, .T., .F., .F., .T.) do legado
    *--------------------------------------------------------------------------
    FUNCTION FinalizarRecalculo()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = fRecalculaS(.T., gnConnHandle, .T., .F., .F., .T.)
        CATCH TO loc_oErro
            MostrarErro("Erro ao finalizar rec" + CHR(225) + "lculo:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
