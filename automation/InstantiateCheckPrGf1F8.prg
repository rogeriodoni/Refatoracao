*==============================================================================
* InstantiateCheckPrGf1F8.prg - valida a Fase 8 (consolidacao) de FormSigPrGf1
*
* Prova MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form ainda INSTANCIA depois das mudancas da fase;
*   2. as propriedades que a Fase 8 transcreveu do SCX estao valendo em runtime
*      (Closable, DataSession, TabIndex dos 4 objetos, acelerador do botao
*      Processar);
*   3. o par FormParaBO()/BOParaForm() existe, eh PUBLIC e faz o round-trip
*      dos dois campos de data;
*   4. this_oFormGrafico/LiberarFormGrafico() existem e LiberarFormGrafico eh
*      idempotente (nao estoura com .NULL. nem chamado duas vezes);
*   5. SigPrGf1BO.Processar() RESTAURA DECIMALS/FIXED/EXACT mesmo quando falha
*      (o restore vive fora do TRY justamente por isso).
*
* NAO chama ConfigurarAmbiente() (pendura nesta maquina). Cada passo eh gravado
* em disco na hora: se travar, o log mostra onde parou.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogPassoF8
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_prgf1_f8.txt"
gc_4c_LogPassoF8       = "C:\4c\automation\instantiate_prgf1_f8_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogPassoF8)
    DELETE FILE (gc_4c_LogPassoF8)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_lOk
LogPasso("FASE8 CHECK FormSigPrGf1 - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGf1BO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGf1.prg") ADDITIVE
    LogPasso("0 SETUP: OK")
CATCH TO loc_oErro
    LogPasso("0 SETUP FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
ENDTRY

*-- 1. instanciacao
TRY
    loc_oForm = CREATEOBJECT("FormSigPrGf1")
    LogPasso("1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " W=" + TRANSFORM(loc_oForm.Width) + ;
        " H=" + TRANSFORM(loc_oForm.Height) + " Cap=[" + loc_oForm.Caption + "]", ""))
CATCH TO loc_oErro
    LogPasso("1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"

    *-- 2. propriedades transcritas do SCX na Fase 8
    TRY
        LogPasso("2 form: Closable=" + TRANSFORM(loc_oForm.Closable) + " [SCX .F.]" + ;
            "  DataSession=" + TRANSFORM(loc_oForm.DataSession) + " [SCX 2]" + ;
            "  DataSessionId=" + TRANSFORM(loc_oForm.DataSessionId) + ;
            "  TitleBar=" + TRANSFORM(loc_oForm.TitleBar) + " [SCX 0]" + ;
            "  ControlBox=" + TRANSFORM(loc_oForm.ControlBox) + " [SCX .F.]")
        LogPasso("2a SETs na sessao privada: DATE=" + SET("DATE") + ;
            " CENTURY=" + SET("CENTURY") + " [FormBase.Init deve ter posto BRITISH/ON]")
    CATCH TO loc_oErro
        LogPasso("2 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        LogPasso("2b TabIndex: DtIni=" + TRANSFORM(loc_oForm.txt_4c_Dtinicial.TabIndex) + " [SCX 1]" + ;
            " DtFim=" + TRANSFORM(loc_oForm.txt_4c_Dtfinal.TabIndex) + " [SCX 2]" + ;
            " lblPeriodo=" + TRANSFORM(loc_oForm.lbl_4c_Lbl_periodo.TabIndex) + " [SCX 3]" + ;
            " cntAguarde=" + TRANSFORM(loc_oForm.cnt_4c_Aguarde.TabIndex) + " [SCX 4]" + ;
            " cmdGrupo=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.TabIndex) + " [SCX 5]")
    CATCH TO loc_oErro
        LogPasso("2b FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        LogPasso("2c CommandGroup: W=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.Width) + ;
            " H=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.Height) + " [SCX 160x85 com AutoSize]" + ;
            " Value=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.Value) + ;
            " AutoSize=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.AutoSize))
        LogPasso("2d Buttons(1).Caption=[" + loc_oForm.obj_4c_CmdGprocessa.Buttons(1).Caption + ;
            "] [SCX tem o acelerador Alt+P]" + ;
            "  Buttons(2).Caption=[" + loc_oForm.obj_4c_CmdGprocessa.Buttons(2).Caption + ;
            "] Cancel=" + TRANSFORM(loc_oForm.obj_4c_CmdGprocessa.Buttons(2).Cancel))
        LogPasso("2e cnt_4c_Aguarde.Visible=" + TRANSFORM(loc_oForm.cnt_4c_Aguarde.Visible) + ;
            " [deve ser .F.]  filhos: L1=" + TRANSFORM(loc_oForm.cnt_4c_Aguarde.lbl_4c_Label1.Visible) + ;
            " L2=" + TRANSFORM(loc_oForm.cnt_4c_Aguarde.lbl_4c_Label2.Visible) + " [ambos .T.]")
    CATCH TO loc_oErro
        LogPasso("2c/d/e FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 3. FormParaBO / BOParaForm
    TRY
        LogPasso("3 metodos: FormParaBO=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + ;
            " BOParaForm=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + ;
            " LiberarFormGrafico=" + TRANSFORM(PEMSTATUS(loc_oForm, "LiberarFormGrafico", 5)) + ;
            " this_oFormGrafico=" + TRANSFORM(PEMSTATUS(loc_oForm, "this_oFormGrafico", 5)) + ;
            " SincronizarPeriodoComBO(deve ser .F.)=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "SincronizarPeriodoComBO", 5)))
    CATCH TO loc_oErro
        LogPasso("3 FALHOU: " + loc_oErro.Message)
    ENDTRY

    TRY
        LogPasso("3a carga inicial (BOParaForm no ConfigurarFiltroPeriodo): DtIni=" + ;
            TRANSFORM(loc_oForm.txt_4c_Dtinicial.Value) + " DtFim=" + ;
            TRANSFORM(loc_oForm.txt_4c_Dtfinal.Value) + ;
            "  [legado: " + TRANSFORM(DATE(YEAR(DATE()), MONTH(DATE()), 1)) + " e " + ;
            TRANSFORM(GOMONTH(DATE(YEAR(DATE()), MONTH(DATE()), 1), 1) - 1) + "]" + ;
            "  tipos=" + VARTYPE(loc_oForm.txt_4c_Dtinicial.Value) + ;
            VARTYPE(loc_oForm.txt_4c_Dtfinal.Value))
    CATCH TO loc_oErro
        LogPasso("3a FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- FormParaBO/BOParaForm sao PROTECTED (escopo herdado de FormBase, que
    *-- nao se alarga na subclasse) - chamar de fora estoura "Property
    *-- FORMPARABO is not found" mesmo com PEMSTATUS devolvendo .T. Por isso o
    *-- teste exercita os dois pelos caminhos REAIS de dentro da classe:
    *--   FormParaBO  <- DtInicialKeyPress/DtFinalKeyPress (PUBLIC, BINDEVENT)
    *--   BOParaForm  <- ConfigurarFiltroPeriodo, ja medido no passo 3a
    TRY
        loc_oForm.FormParaBO()
        LogPasso("3b chamada EXTERNA de FormParaBO passou - inesperado " + ;
            "(deveria ser PROTECTED)")
    CATCH TO loc_oErro
        LogPasso("3b chamada EXTERNA de FormParaBO recusada, como esperado: " + ;
            loc_oErro.Message)
    ENDTRY

    TRY
        loc_oForm.txt_4c_Dtinicial.Value = {^2026-04-01}
        loc_oForm.txt_4c_Dtfinal.Value   = {^2026-04-30}
        loc_oForm.DtInicialKeyPress(13, 0)
        loc_oForm.DtFinalKeyPress(13, 0)
        LogPasso("3c FormParaBO pelo KeyPress(13): BO.Ini=" + ;
            TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataInicial) + ;
            " BO.Fim=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataFinal) + ;
            " [esperado 01/04/2026 e 30/04/2026]")
    CATCH TO loc_oErro
        LogPasso("3c FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        *-- ValidarPeriodo (PUBLIC) tambem passa por FormParaBO: le da TELA.
        loc_oForm.txt_4c_Dtinicial.Value = {^2026-06-01}
        loc_oForm.txt_4c_Dtfinal.Value   = {^2026-06-30}
        loc_lOk = loc_oForm.ValidarPeriodo()
        LogPasso("3d ValidarPeriodo -> FormParaBO: retorno=" + TRANSFORM(loc_lOk) + ;
            " BO.Ini=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataInicial) + ;
            " BO.Fim=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataFinal) + ;
            " Msg=[" + loc_oForm.this_cMsgValidacao + "] [esperado .T., 01/06 a 30/06, msg vazia]")
    CATCH TO loc_oErro
        LogPasso("3d FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 4. LiberarFormGrafico idempotente
    TRY
        loc_oForm.LiberarFormGrafico()
        loc_oForm.LiberarFormGrafico()
        LogPasso("4 LiberarFormGrafico 2x com .NULL.: OK, prop VARTYPE=" + ;
            VARTYPE(loc_oForm.this_oFormGrafico))
    CATCH TO loc_oErro
        LogPasso("4 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 5. Processar restaura os SETs mesmo falhando
    TRY
        SET DECIMALS TO 2
        SET FIXED OFF
        SET EXACT ON
        LogPasso("5 antes de Processar: DEC=" + TRANSFORM(SET("Decimals")) + ;
            " FIXED=" + SET("Fixed") + " EXACT=" + SET("Exact"))
        loc_lOk = loc_oForm.this_oBusinessObject.Processar()
        LogPasso("5a Processar retorno=" + TRANSFORM(loc_lOk) + ;
            " Msg=[" + LEFT(loc_oForm.this_oBusinessObject.this_cMensagemErro, 90) + "]")
        LogPasso("5b DEPOIS de Processar: DEC=" + TRANSFORM(SET("Decimals")) + ;
            " FIXED=" + SET("Fixed") + " EXACT=" + SET("Exact") + ;
            "  [tem de voltar a 2 / OFF / ON]")
    CATCH TO loc_oErro
        LogPasso("5 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.Release()
        LogPasso("6 Release do pai: VARTYPE=" + VARTYPE(loc_oForm) + " [X = liberado]")
    CATCH TO loc_oErro
        LogPasso("6 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogPasso("DIALOGOS SUPRIMIDOS: " + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogPasso("DIALOGOS SUPRIMIDOS: nenhum")
ENDIF

LogPasso("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogPasso(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogPassoF8, .T.)
ENDPROC
