* ProbeF1SigOpLbC756.prg
* Instancia SigOpLbCBO (Fase 1) e grava o resultado em arquivo.
* Nao usa ConfigurarAmbiente (que bloqueia probe) nem conexao SQL: o Init
* chama DODEFAULT() SEM tabela, logo BusinessBase nao cria o DataAccess.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gnConnHandle    = -1

LOCAL loc_cOut, loc_oBO, loc_cRel, loc_nI, loc_nQtd, loc_nTot
LOCAL ARRAY loc_aProps[1]
loc_cOut = "C:\4c\tasks\task756\probe_fase1.txt"
loc_cRel = ""

SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\SigOpLbCBO.prg") ADDITIVE

TRY
    loc_oBO = CREATEOBJECT("SigOpLbCBO")

    IF VARTYPE(loc_oBO) = "O"
        loc_cRel = loc_cRel + "INSTANCIOU: OK (VARTYPE=O)" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "this_cTabela     = [" + TRANSFORM(loc_oBO.this_cTabela) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "this_cCampoChave = [" + TRANSFORM(loc_oBO.this_cCampoChave) + "]" + CHR(13) + CHR(10)

        loc_nQtd = AMEMBERS(loc_aProps, loc_oBO, 0)
        loc_nTot = 0
        FOR loc_nI = 1 TO loc_nQtd
            IF UPPER(LEFT(loc_aProps[loc_nI], 5)) == "THIS_"
                loc_nTot = loc_nTot + 1
            ENDIF
        ENDFOR
        loc_cRel = loc_cRel + "PROPS this_ na instancia = " + TRANSFORM(loc_nTot) + CHR(13) + CHR(10)

        loc_cRel = loc_cRel + "--- leitura de cada property declarada ---" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "cOperacao=["           + TRANSFORM(loc_oBO.this_cOperacao) + "] "
        loc_cRel = loc_cRel + "cDopes=["              + TRANSFORM(loc_oBO.this_cDopes) + "] "
        loc_cRel = loc_cRel + "nTipoOps=["            + TRANSFORM(loc_oBO.this_nTipoOps) + "] "
        loc_cRel = loc_cRel + "cNivels=["             + TRANSFORM(loc_oBO.this_cNivels) + "] "
        loc_cRel = loc_cRel + "nLimCres=["            + TRANSFORM(loc_oBO.this_nLimCres) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "cEmps=["               + TRANSFORM(loc_oBO.this_cEmps) + "] "
        loc_cRel = loc_cRel + "nNumes=["              + TRANSFORM(loc_oBO.this_nNumes) + "] "
        loc_cRel = loc_cRel + "nValorMovimento=["     + TRANSFORM(loc_oBO.this_nValorMovimento) + "] "
        loc_cRel = loc_cRel + "cGrupo=["              + TRANSFORM(loc_oBO.this_cGrupo) + "] "
        loc_cRel = loc_cRel + "cConta=["              + TRANSFORM(loc_oBO.this_cConta) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "cCampoGrupoSQL=["      + TRANSFORM(loc_oBO.this_cCampoGrupoSQL) + "] "
        loc_cRel = loc_cRel + "cCampoContaSQL=["      + TRANSFORM(loc_oBO.this_cCampoContaSQL) + "] "
        loc_cRel = loc_cRel + "cChaveLimiteCredito=[" + TRANSFORM(loc_oBO.this_cChaveLimiteCredito) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "nLimiteCredito=["      + TRANSFORM(loc_oBO.this_nLimiteCredito) + "] "
        loc_cRel = loc_cRel + "cMoeda=["              + TRANSFORM(loc_oBO.this_cMoeda) + "] "
        loc_cRel = loc_cRel + "cGruContas=["          + TRANSFORM(loc_oBO.this_cGruContas) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "cRazaoCliente=["       + TRANSFORM(loc_oBO.this_cRazaoCliente) + "] "
        loc_cRel = loc_cRel + "cDescricaoConta=["     + TRANSFORM(loc_oBO.this_cDescricaoConta) + "] "
        loc_cRel = loc_cRel + "nGerGdmis=["           + TRANSFORM(loc_oBO.this_nGerGdmis) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "nOpPendsParam=["       + TRANSFORM(loc_oBO.this_nOpPendsParam) + "] "
        loc_cRel = loc_cRel + "lChqLimiteCredito=["   + TRANSFORM(loc_oBO.this_lChqLimiteCredito) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "nCotacao=["            + TRANSFORM(loc_oBO.this_nCotacao) + "] "
        loc_cRel = loc_cRel + "nSaldoContaCorrente=[" + TRANSFORM(loc_oBO.this_nSaldoContaCorrente) + "] "
        loc_cRel = loc_cRel + "nTotalCheques=["       + TRANSFORM(loc_oBO.this_nTotalCheques) + "] "
        loc_cRel = loc_cRel + "nChequesPendentes=["   + TRANSFORM(loc_oBO.this_nChequesPendentes) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "nPendente=["           + TRANSFORM(loc_oBO.this_nPendente) + "] "
        loc_cRel = loc_cRel + "nPendenteOutros=["     + TRANSFORM(loc_oBO.this_nPendenteOutros) + "] "
        loc_cRel = loc_cRel + "nSaldoDisponivel=["    + TRANSFORM(loc_oBO.this_nSaldoDisponivel) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "cCursorOperacoes=["    + TRANSFORM(loc_oBO.this_cCursorOperacoes) + "] "
        loc_cRel = loc_cRel + "cCursorCredOpe=["      + TRANSFORM(loc_oBO.this_cCursorCredOpe) + "] "
        loc_cRel = loc_cRel + "cCursorLimiteConta=["  + TRANSFORM(loc_oBO.this_cCursorLimiteConta) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "cCursorOpePendente=["  + TRANSFORM(loc_oBO.this_cCursorOpePendente) + "] "
        loc_cRel = loc_cRel + "cCursorTipoOpePend=["  + TRANSFORM(loc_oBO.this_cCursorTipoOpePend) + "] "
        loc_cRel = loc_cRel + "cCursorMovCabecalho=[" + TRANSFORM(loc_oBO.this_cCursorMovCabecalho) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "cCursorMovFiltrado=["  + TRANSFORM(loc_oBO.this_cCursorMovFiltrado) + "] "
        loc_cRel = loc_cRel + "cCursorItensMov=["     + TRANSFORM(loc_oBO.this_cCursorItensMov) + "] "
        loc_cRel = loc_cRel + "cCursorCliente=["      + TRANSFORM(loc_oBO.this_cCursorCliente) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "cCursorSaldoConta=["   + TRANSFORM(loc_oBO.this_cCursorSaldoConta) + "] "
        loc_cRel = loc_cRel + "cCursorCheques=["      + TRANSFORM(loc_oBO.this_cCursorCheques) + "] "
        loc_cRel = loc_cRel + "cCursorFormaPagto=["   + TRANSFORM(loc_oBO.this_cCursorFormaPagto) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "cCursorPendencia=["    + TRANSFORM(loc_oBO.this_cCursorPendencia) + "] "
        loc_cRel = loc_cRel + "cCursorTipoOperacao=[" + TRANSFORM(loc_oBO.this_cCursorTipoOperacao) + "] "
        loc_cRel = loc_cRel + "cCursorParametros=["   + TRANSFORM(loc_oBO.this_cCursorParametros) + "]" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "lDadosCarregados=["    + TRANSFORM(loc_oBO.this_lDadosCarregados) + "] "
        loc_cRel = loc_cRel + "lFalhaConexao=["       + TRANSFORM(loc_oBO.this_lFalhaConexao) + "] "
        loc_cRel = loc_cRel + "lContaIndefinida=["    + TRANSFORM(loc_oBO.this_lContaIndefinida) + "]" + CHR(13) + CHR(10)

        loc_cRel = loc_cRel + "--- escopo herdado (atributo 2 = PROTECTED, deve ser .F.) ---" + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "Buscar=["           + TRANSFORM(PEMSTATUS(loc_oBO, "Buscar", 2)) + "] "
        loc_cRel = loc_cRel + "CarregarDoCursor=[" + TRANSFORM(PEMSTATUS(loc_oBO, "CarregarDoCursor", 2)) + "] "
        loc_cRel = loc_cRel + "LimparDados=["      + TRANSFORM(PEMSTATUS(loc_oBO, "LimparDados", 2)) + "] "
        loc_cRel = loc_cRel + "ValidarDados=["     + TRANSFORM(PEMSTATUS(loc_oBO, "ValidarDados", 2)) + "]" + CHR(13) + CHR(10)

        loc_cRel = loc_cRel + "RESULTADO: SUCESSO" + CHR(13) + CHR(10)
    ELSE
        loc_cRel = loc_cRel + "FALHA: CREATEOBJECT devolveu VARTYPE=" + VARTYPE(loc_oBO) + CHR(13) + CHR(10)
        loc_cRel = loc_cRel + "RESULTADO: FALHA" + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cRel = loc_cRel + "EXCECAO: " + loc_oErro.Message + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "  Proc : " + TRANSFORM(loc_oErro.Procedure) + CHR(13) + CHR(10)
    loc_cRel = loc_cRel + "RESULTADO: FALHA" + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cRel, loc_cOut)
QUIT
