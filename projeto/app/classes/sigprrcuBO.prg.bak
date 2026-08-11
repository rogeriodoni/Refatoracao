*==============================================================================
* sigprrcuBO.prg - Business Object: Recalculo de Custos de Produto
* Herda de: BusinessBase
* Tabela principal: SigOpClC (fila de recalculo de custos em lote)
*==============================================================================
DEFINE CLASS sigprrcuBO AS BusinessBase

    *-- Estado do processamento
    this_lParametrizado = .F.    && .T. quando acionado via Fortyus.Exe
    this_lErroConexao   = .F.    && .T. se houve queda de conexao durante o loop
    this_lProcessando   = .F.    && .T. enquanto loop de processamento esta ativo
    this_cArquivoLog    = ""     && Caminho do arquivo de log (Fortyus.Log)
    this_nContadorAnima = 0      && Contador de animacao dos pontos no label de status

    *-- Campos de SigOpClC
    this_cCidChave  = ""    && CidChaves PK (uniqueidentifier)
    this_cEmps      = ""    && Empresa
    this_cCpros     = ""    && Codigo do Produto
    this_dDatas     = {}    && Data de referencia
    this_cUsuars    = ""    && Usuario que enfileirou
    this_cEmpCpros  = ""    && Emps + Cpros (chave de ordenacao)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigOpClC"
        THIS.this_cCampoChave = "CidChaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChave
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChave  = TratarNulo(CidChaves, "C")
            THIS.this_cEmps      = TratarNulo(Emps,      "C")
            THIS.this_cCpros     = TratarNulo(Cpros,     "C")
            THIS.this_dDatas     = TratarNulo(Datas,     "D")
            THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
            THIS.this_cEmpCpros  = TratarNulo(EmpCpros,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_cCpros)
                THIS.this_cMensagemErro = "Empresa e produto s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
            ELSE
                THIS.this_cEmpCpros = RTRIM(THIS.this_cEmps) + RTRIM(THIS.this_cCpros)

                loc_cSQL = "INSERT INTO SigOpClC (CidChaves, Emps, Cpros, Datas, Usuars, EmpCpros) VALUES (" + ;
                           "NEWID(), " + ;
                           EscaparSQL(THIS.this_cEmps) + ", " + ;
                           EscaparSQL(THIS.this_cCpros) + ", " + ;
                           FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(THIS.this_cEmpCpros) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao inserir item na fila de recalculo."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChave)
                THIS.this_cMensagemErro = "Chave n" + CHR(227) + "o informada para atualiza" + CHR(231) + CHR(227) + "o."
            ELSE
                loc_cSQL = "UPDATE SigOpClC SET Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                           " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChave)

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("ATUALIZAR")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar item na fila de recalculo."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Carrega itens da fila SigOpClC em cursor local (CrSigOpClC) para recalculo
    * par_nHandle: handle de conexao SQL (da transacao ativa do form)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutosPendentes(par_nHandle)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF USED("CrSigOpClC")
                USE IN CrSigOpClC
            ENDIF
            loc_cSQL = "SELECT 0 AS Flag, * FROM SigOpClC ORDER BY EmpCpros"
            loc_nRet = SQLEXEC(par_nHandle, loc_cSQL, "CrSigOpClC")
            loc_lSucesso = (loc_nRet > 0)

            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao buscar produtos pendentes."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarEmProcessamento - UPDATE SigOpClC para criar lock transacional
    * par_nHandle:   handle de conexao (transacao ativa)
    * par_cCidChave: CidChaves do item a marcar
    * Retorna: 1 sucesso | 0 falha | -3 queda de conexao
    *--------------------------------------------------------------------------
    PROCEDURE MarcarEmProcessamento(par_nHandle, par_cCidChave)
        LOCAL loc_cSQL, loc_nRet
        loc_cSQL = "UPDATE SigOpClC SET Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                   " WHERE CidChaves = " + EscaparSQL(par_cCidChave)
        loc_nRet = SQLEXEC(par_nHandle, loc_cSQL)
        RETURN loc_nRet
    ENDPROC

    *--------------------------------------------------------------------------
    * RemoverDaFila - DELETE FROM SigOpClC apos processamento bem-sucedido
    * par_nHandle:   handle de conexao (transacao ativa)
    * par_cCidChave: CidChaves do item processado
    *--------------------------------------------------------------------------
    PROCEDURE RemoverDaFila(par_nHandle, par_cCidChave)
        LOCAL loc_cSQL, loc_nRet
        loc_cSQL = "DELETE FROM SigOpClC WHERE CidChaves = " + EscaparSQL(par_cCidChave)
        loc_nRet = SQLEXEC(par_nHandle, loc_cSQL)
        RETURN (loc_nRet > 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarRecalculo - Chama fRecalculaC para recalcular custo do produto
    * par_cEmps:  empresa (usa go_4c_Sistema.cCodEmpresa se vazio)
    * par_cCpros: codigo do produto
    * par_dDatas: data de referencia
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarRecalculo(par_cEmps, par_cCpros, par_dDatas)
        LOCAL loc_lSucesso, loc_oErro, loc_cEmps
        loc_lSucesso = .F.

        TRY
            loc_cEmps = IIF(EMPTY(par_cEmps), go_4c_Sistema.cCodEmpresa, par_cEmps)

            loc_lSucesso = fRecalculaC(loc_cEmps, par_cCpros, par_dDatas)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarRecalculoFinal - Segunda chamada de fRecalculaC (commit calculo)
    * par_nHandle: handle de conexao da transacao ativa
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarRecalculoFinal(par_nHandle)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = fRecalculaC(.T., .T., .F., par_nHandle, .T.)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarLog - Escreve cabecalho no arquivo Fortyus.Log
    *--------------------------------------------------------------------------
    PROCEDURE IniciarLog()
        LOCAL loc_cLinha

        THIS.this_cArquivoLog = "Fortyus.Log"
        STRTOFILE("", THIS.this_cArquivoLog, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = "Iniciando o Processamento : Fortyus.Exe (SigOpClC) - Recalculo de Custos"
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = "Data : " + DTOC(DATE()) + " - Hora : " + TIME()
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConcluirLog - Escreve rodape no arquivo Fortyus.Log
    *--------------------------------------------------------------------------
    PROCEDURE ConcluirLog()
        LOCAL loc_cLinha

        STRTOFILE("", THIS.this_cArquivoLog, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = "Concluindo o Processamento : Prod2005.Exe (SigOpClC) - Recalculo de Custos"
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = "Data : " + DTOC(DATE()) + " - Hora : " + TIME()
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarEntradaLog - Escreve uma linha no arquivo de log
    *--------------------------------------------------------------------------
    PROCEDURE GravarEntradaLog(par_cMensagem)
        IF !EMPTY(THIS.this_cArquivoLog)
            STRTOFILE(par_cMensagem + CHR(10), THIS.this_cArquivoLog, .T.)
        ENDIF
    ENDPROC

ENDDEFINE
