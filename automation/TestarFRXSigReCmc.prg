*==============================================================================
* TestarFRXSigReCmc.prg
* Renderiza SigReCm1/2/3 com DADOS REAIS, pelo mesmo caminho do BO, gravando
* a saida em ASCII para conferencia (REPORT FORM ... TO FILE, sem PREVIEW -
* PREVIEW abriria janela modal e travaria o teste headless).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\frxtmp\teste_frx_dialogos.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL lcLog
lcLog = "C:\4c\automation\frxtmp\teste_frx.log"
STRTOFILE("INICIO " + TTOC(DATETIME()) + CHR(13) + CHR(10), lcLog)

CD C:\4c\projeto\app\start
DO config.prg
SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")  ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "relatoriobase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "sigrecmcBO.prg")    ADDITIVE

PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
IF gnConnHandle < 1
    STRTOFILE("FALHA CONEXAO" + CHR(13) + CHR(10), lcLog, 1)
    QUIT
ENDIF
=SQLSETPROP(gnConnHandle, "Transactions", 1)
PUBLIC gc_4c_UsuarioLogado
gc_4c_UsuarioLogado = "TESTE"

LOCAL loBO
loBO = CREATEOBJECT("sigrecmcBO")
loBO.CarregarDadosIniciais()

*-- cenario, comparativo, dadoscli, selrel, frx
LOCAL ARRAY laC[3, 5]
laC[1,1] = "SigReCm1 (padrao, Valor)"
laC[1,2] = 0
laC[1,3] = 0
laC[1,4] = 1
laC[1,5] = "SigReCm1"

laC[2,1] = "SigReCm2 (comparativo, Quantidade)"
laC[2,2] = 1
laC[2,3] = 0
laC[2,4] = 2
laC[2,5] = "SigReCm2"

laC[3,1] = "SigReCm3 (dados do cliente, Valor)"
laC[3,2] = 0
laC[3,3] = 1
laC[3,4] = 1
laC[3,5] = "SigReCm3"

LOCAL j, llOk, lcFRX, lcSaida, lnVis
FOR j = 1 TO 3
    WITH loBO
        .this_cEmpresa     = "001"
        .this_cDEmpresa    = "MARCELLA BAHIA"
        .this_cNmOperacao  = ""
        .this_dDtInicial   = DATE(2021, 10, 15)
        .this_dDtFinal     = DATE(2026, 10, 15)
        .this_cMoeda       = "R"
        .this_cMoedaDesc   = "REAIS"
        .this_nQtde        = 50
        .this_nQtMin       = 0
        .this_cCdConta     = ""
        .this_cDsConta     = ""
        .this_cCdVendedor  = ""
        .this_cDsVendedor  = ""
        .this_cCdProduto   = ""
        .this_cDsProduto   = ""
        .this_nOrdem       = 1
        .this_nOptCompara  = 1
        .this_nOptMovCad   = 1
        .this_nComparativo = laC[j,2]
        .this_nChkCidade   = 0
        .this_nChkDadosCli = laC[j,3]
        .this_nChkValor    = 0
        .this_nOptSelRel   = laC[j,4]
    ENDWITH

    STRTOFILE("--- " + laC[j,1] + " ---" + CHR(13) + CHR(10), lcLog, 1)
    llOk = loBO.PrepararDados()
    STRTOFILE("  PrepararDados=" + TRANSFORM(llOk) + CHR(13) + CHR(10), lcLog, 1)
    IF !llOk
        LOOP
    ENDIF

    lcFRX   = "C:\4c\projeto\app\reports\" + laC[j,5] + ".frx"
    lcSaida = "C:\4c\automation\frxtmp\saida_" + laC[j,5] + ".txt"
    IF FILE(lcSaida)
        DELETE FILE (lcSaida)
    ENDIF

    *-- REPORTBEHAVIOR 80: no modo 90 o VFP9 IGNORA a clausula ASCII e emite PDF
    SET REPORTBEHAVIOR 80
    SELECT TmpResult
    GO TOP
    COUNT TO lnVis
    GO TOP
    STRTOFILE("  TmpResult visiveis=" + TRANSFORM(lnVis) + ;
        " total=" + TRANSFORM(RECCOUNT("TmpResult")) + CHR(13) + CHR(10), lcLog, 1)

    TRY
        REPORT FORM (lcFRX) TO FILE (lcSaida) ASCII NOCONSOLE
        STRTOFILE("  REPORT FORM OK - saida existe=" + TRANSFORM(FILE(lcSaida)) + ;
            " bytes=" + TRANSFORM(IIF(FILE(lcSaida), FSIZE(lcSaida), 0)) + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("  REPORT FORM ERRO linha " + TRANSFORM(loErr.LineNo) + ": " + ;
            loErr.Message + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY
ENDFOR

STRTOFILE("FIM" + CHR(13) + CHR(10), lcLog, 1)
QUIT
