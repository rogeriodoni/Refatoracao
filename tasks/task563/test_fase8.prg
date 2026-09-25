SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF

LOCAL lcLog, loForm, loErr, llOk
lcLog = "C:\4c\tasks\task563\test_fase8_saida.txt"
STRTOFILE("== TESTE FASE 8 FormSIGMVCMV ==" + CHR(13) + CHR(10), lcLog)

CD C:\4c\projeto\app\start
DO config.prg

PUBLIC gb_4c_ValidandoUI, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste   = .T.
*-- messages.prg so suprime o dialog quando gb_4c_ModoTeste = .T. E
*-- gc_4c_ArquivoErroTeste e' CHARACTER (as duas condicoes, ver
*-- EscreverErroParaArquivo) - sem isso o MsgAviso abre modal e trava o teste.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task563\test_fase8_msgs.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

*-- config.prg carrega ~300 .prg com SET PROCEDURE ADDITIVE e as primeiras
*-- entradas caem da lista; recarregar aqui o que este teste precisa.
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils + "functions.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils + "messages.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils + "validators.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SIGMVCMVBO.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGMVCMV.prg") ADDITIVE

PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
STRTOFILE("Conexao handle: " + TRANSFORM(gnConnHandle) + CHR(13) + CHR(10), lcLog, 1)

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGMVCMV")
CATCH TO loErr
    STRTOFILE("FALHA CREATEOBJECT: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
ENDTRY

STRTOFILE("VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13) + CHR(10), lcLog, 1)

IF VARTYPE(loForm) = "O"
    *-- metodos que o harness chama de FORA da classe (tem de ser PUBLIC)
    LOCAL ARRAY laM[6]
    laM[1] = "CarregarLista"
    laM[2] = "AjustarBotoesPorModo"
    laM[3] = "FormParaBO"
    laM[4] = "BOParaForm"
    laM[5] = "HabilitarCampos"
    laM[6] = "LimparTela"
    FOR lnI = 1 TO 6
        STRTOFILE("PEMSTATUS " + laM[lnI] + " = " + TRANSFORM(PEMSTATUS(loForm, laM[lnI], 5)) + ;
            CHR(13) + CHR(10), lcLog, 1)
    ENDFOR

    *-- Chamadas REAIS de fora da classe (prova que sao PUBLIC de verdade)
    TRY
        loForm.CarregarLista()
        STRTOFILE("CarregarLista(): OK" + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("CarregarLista() FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    TRY
        loForm.AjustarBotoesPorModo()
        STRTOFILE("AjustarBotoesPorModo(): OK - Processa.Enabled=" + ;
            TRANSFORM(loForm.cmd_4c_Processa.Enabled) + " Cancela.Enabled=" + ;
            TRANSFORM(loForm.cmd_4c_Cancela.Enabled) + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("AjustarBotoesPorModo() FALHOU: " + loErr.Message + " LN=" + ;
            TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    TRY
        loForm.HabilitarCampos(.F.)
        STRTOFILE("HabilitarCampos(.F.): OK - DtIni.Enabled=" + ;
            TRANSFORM(loForm.txt_4c_DtInicial.Enabled) + " Cancela.Enabled=" + ;
            TRANSFORM(loForm.cmd_4c_Cancela.Enabled) + CHR(13) + CHR(10), lcLog, 1)
        loForm.HabilitarCampos(.T.)
        STRTOFILE("HabilitarCampos(.T.): OK - DtIni.Enabled=" + ;
            TRANSFORM(loForm.txt_4c_DtInicial.Enabled) + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("HabilitarCampos FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    *-- FormParaBO/BOParaForm sao PROTECTED (escopo herdado do FormBase):
    *-- exercitados pelos callers REAIS de dentro da classe (Processamento e
    *-- LimparTela). Confirma tambem que chamar de FORA estoura - e' o
    *-- contrato esperado, nao um defeito.
    TRY
        llOk = loForm.FormParaBO()
        STRTOFILE("ALERTA: FormParaBO() chamavel de FORA (esperado PROTECTED)" + ;
            CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("FormParaBO() de fora: bloqueado como esperado (" + loErr.Message + ")" + ;
            CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    *-- Periodo VAZIO -> Processamento nao deve chamar ProcessarLancamentos
    TRY
        loForm.txt_4c_DtInicial.Value = {}
        loForm.txt_4c_DtFinal.Value   = {}
        loForm.this_oBusinessObject.this_nQtdProcessada = -1
        loForm.Processamento()
        STRTOFILE("Processamento() periodo vazio: OK - QtdProcessada=" + ;
            TRANSFORM(loForm.this_oBusinessObject.this_nQtdProcessada) + ;
            " (esperado -1, ou seja BO nao foi acionado)" + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("Processamento() vazio FALHOU: " + loErr.Message + " LN=" + ;
            TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    *-- Periodo INVERTIDO -> idem (BO nao acionado)
    TRY
        loForm.txt_4c_DtInicial.Value = DATE()
        loForm.txt_4c_DtFinal.Value   = DATE() - 10
        loForm.this_oBusinessObject.this_nQtdProcessada = -1
        loForm.Processamento()
        STRTOFILE("Processamento() periodo invertido: OK - QtdProcessada=" + ;
            TRANSFORM(loForm.this_oBusinessObject.this_nQtdProcessada) + ;
            " (esperado -1)" + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("Processamento() invertido FALHOU: " + loErr.Message + " LN=" + ;
            TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    *-- Periodo VALIDO -> FormParaBO preenche as 6 propriedades do BO
    TRY
        loForm.txt_4c_DtInicial.Value = DATE() - 30
        loForm.txt_4c_DtFinal.Value   = DATE()
        loForm.txt_4c__cd_moeda.Value = "USD"
        loForm.txt_4c__ds_moeda.Value = "DOLAR"
        loForm.txt_4c_Empresa.Value   = "001"
        loForm.txt_4c_DEmpresa.Value  = "EMPRESA TESTE"
        loForm.Processamento()
        STRTOFILE("Processamento() periodo valido: OK" + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("  BO.this_dDataInicial = " + TRANSFORM(loForm.this_oBusinessObject.this_dDataInicial) + ;
            " (VARTYPE " + VARTYPE(loForm.this_oBusinessObject.this_dDataInicial) + ", esperado D)" + ;
            CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("  BO.this_dDataFinal   = " + TRANSFORM(loForm.this_oBusinessObject.this_dDataFinal) + ;
            CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("  BO.this_cCdMoeda   = [" + loForm.this_oBusinessObject.this_cCdMoeda + "]" + ;
            CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("  BO.this_cDsMoeda   = [" + loForm.this_oBusinessObject.this_cDsMoeda + "]" + ;
            CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("  BO.this_cCdEmpresa = [" + loForm.this_oBusinessObject.this_cCdEmpresa + "]" + ;
            CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("  BO.this_cDsEmpresa = [" + loForm.this_oBusinessObject.this_cDsEmpresa + "]" + ;
            CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("Processamento() valido FALHOU: " + loErr.Message + " LN=" + ;
            TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    *-- LimparTela: zera BO + escreve na tela via BOParaForm
    TRY
        loForm.LimparTela()
        STRTOFILE("LimparTela(): OK - DtIni=[" + TRANSFORM(loForm.txt_4c_DtInicial.Value) + ;
            "] moeda=[" + loForm.txt_4c__cd_moeda.Value + "] empresa=[" + ;
            loForm.txt_4c_Empresa.Value + "] dsEmpresa=[" + loForm.txt_4c_DEmpresa.Value + "]" + ;
            CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("  BO.this_cCdMoeda apos limpar = [" + ;
            loForm.this_oBusinessObject.this_cCdMoeda + "]" + CHR(13) + CHR(10), lcLog, 1)
    CATCH TO loErr
        STRTOFILE("LimparTela() FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
    ENDTRY

    loForm.Release()
    loForm = .NULL.
ENDIF

STRTOFILE("== FIM ==" + CHR(13) + CHR(10), lcLog, 1)
QUIT
