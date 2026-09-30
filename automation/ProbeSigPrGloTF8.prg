*-- Probe SEM ConfigurarAmbiente(): a maquina do pipeline nao alcanca o SQL
*-- Server (192.168.200.10:1433). Prova o que DA para provar offline:
*--   a) as classes carregam e a definicao da classe eh valida;
*--   b) nao ha erro de membro/sintaxe ANTES do gate de conexao;
*--   c) onde exatamente o Init para sem banco.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprglot_probe.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_oBO
loc_cRes = "PROBE OFFLINE FormSigPrGloT - " + TTOC(DATETIME()) + CHR(13)+CHR(10)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    *-- ConfigurarAmbiente() faz o SET PROCEDURE das classes MAS tambem abre a
    *-- conexao SQL, que TRAVA nesta maquina (sem rota para 192.168.200.10).
    *-- Registrar as classes na mao, como o harness do FormSigPrGl2.
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGloTBO.prg")  ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGloT.prg") ADDITIVE

    loc_cRes = loc_cRes + "0 config.prg: OK  PATH itens=" + ;
        TRANSFORM(OCCURS(",", SET("PATH")) + 1) + CHR(13)+CHR(10)
CATCH TO loc_oErro
    loc_cRes = loc_cRes + "0 config.prg FALHOU: " + loc_oErro.Message + CHR(13)+CHR(10)
ENDTRY

*-- BO isolado: prova que a classe existe, instancia e tem as 21 props de filtro
TRY
    loc_oBO = CREATEOBJECT("SigPrGloTBO")
    loc_cRes = loc_cRes + "1 BO instancia: VARTYPE=" + VARTYPE(loc_oBO) + ;
        " Tabela=[" + loc_oBO.this_cTabela + "]" + ;
        " Chave=["  + loc_oBO.this_cCampoChave + "]" + CHR(13)+CHR(10) + ;
        "  props filtro: Dataei=" + TRANSFORM(PEMSTATUS(loc_oBO,"this_dDataei",5)) + ;
        " Previsao="   + TRANSFORM(PEMSTATUS(loc_oBO,"this_dPrevisao",5)) + ;
        " CodEmpresa=" + TRANSFORM(PEMSTATUS(loc_oBO,"this_cCodEmpresa",5)) + ;
        " TipoGerOP="  + TRANSFORM(PEMSTATUS(loc_oBO,"this_cTipoGerOP",5)) + ;
        " NumeroOP="   + TRANSFORM(PEMSTATUS(loc_oBO,"this_nNumeroOP",5)) + ;
        " ProcessarOP="+ TRANSFORM(PEMSTATUS(loc_oBO,"ProcessarOP",5)) + CHR(13)+CHR(10)
    loc_oBO = .NULL.
CATCH TO loc_oErro
    loc_cRes = loc_cRes + "1 BO FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13)+CHR(10)
ENDTRY

*-- Form: sem conexao o InicializarForm para no gate CarregarOperacoes
TRY
    loc_oForm = CREATEOBJECT("FormSigPrGloT", .F., .F., .F., .T.)
    loc_cRes = loc_cRes + "2 FORM CREATEOBJECT: VARTYPE=" + VARTYPE(loc_oForm) + CHR(13)+CHR(10)
    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = loc_cRes + "  (instanciou) W=" + TRANSFORM(loc_oForm.Width) + CHR(13)+CHR(10)
        loc_oForm.Release()
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + "2 FORM EXCECAO: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13)+CHR(10)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRes = loc_cRes + "--- DIALOGOS CAPTURADOS ---" + CHR(13)+CHR(10) + ;
               FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\probe_sigprglot_f8.txt")
QUIT
