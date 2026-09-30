*==============================================================================
* InstantiateCheckPrGf1F6.prg - valida a Fase 6 de FormSigPrGf1
*
* Prova MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form ainda INSTANCIA depois das mudancas da fase;
*   2. os dois campos de periodo nascem com os defaults do BO (1o/ultimo dia
*      do mes corrente, como o Init legado) e com as propriedades transcritas
*      (Format="K" do SCX, Alignment=3/Themes=.F. da classe fweditdata,
*      InputMask de data);
*   3. os handlers de KeyPress ligados por BINDEVENT existem, sao PUBLIC e
*      espelham o valor digitado nas properties do BO;
*   4. ValidarPeriodo() (migracao do mchkvalid legado) recusa os TRES casos do
*      legado com a MESMA mensagem e com o foco no MESMO campo, e aceita o
*      periodo valido - sem exibir dialogo (quem exibe eh o Click, Fase 8).
*
* NAO chama ConfigurarAmbiente() (pendura nesta maquina): carrega a mao so as
* dependencias do form. Cada passo eh GRAVADO EM DISCO na hora (LogPasso ->
* STRTOFILE ADDITIVE): se o processo travar, o log mostra onde parou.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogPassoF6
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_prgf1_f6.txt"
gc_4c_LogPassoF6       = "C:\4c\automation\instantiate_prgf1_f6_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogPassoF6)
    DELETE FILE (gc_4c_LogPassoF6)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_lOk
LogPasso("FASE6 CHECK FormSigPrGf1 - inicio " + TTOC(DATETIME()))

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

    *-- 2. defaults + propriedades transcritas dos dois campos
    TRY
        LogPasso("2 DtInicial: Val=[" + TRANSFORM(loc_oForm.txt_4c_Dtinicial.Value) + ;
            "] Tipo=" + VARTYPE(loc_oForm.txt_4c_Dtinicial.Value) + ;
            " Fmt=[" + loc_oForm.txt_4c_Dtinicial.Format + ;
            "] Mask=[" + loc_oForm.txt_4c_Dtinicial.InputMask + ;
            "] Align=" + TRANSFORM(loc_oForm.txt_4c_Dtinicial.Alignment) + ;
            " Themes=" + TRANSFORM(loc_oForm.txt_4c_Dtinicial.Themes) + ;
            " Tab=" + TRANSFORM(loc_oForm.txt_4c_Dtinicial.TabIndex) + ;
            " Vis=" + TRANSFORM(loc_oForm.txt_4c_Dtinicial.Visible))
        LogPasso("2 DtFinal  : Val=[" + TRANSFORM(loc_oForm.txt_4c_Dtfinal.Value) + ;
            "] Tipo=" + VARTYPE(loc_oForm.txt_4c_Dtfinal.Value) + ;
            " Fmt=[" + loc_oForm.txt_4c_Dtfinal.Format + ;
            "] Mask=[" + loc_oForm.txt_4c_Dtfinal.InputMask + ;
            "] Align=" + TRANSFORM(loc_oForm.txt_4c_Dtfinal.Alignment) + ;
            " Themes=" + TRANSFORM(loc_oForm.txt_4c_Dtfinal.Themes) + ;
            " Tab=" + TRANSFORM(loc_oForm.txt_4c_Dtfinal.TabIndex) + ;
            " Vis=" + TRANSFORM(loc_oForm.txt_4c_Dtfinal.Visible))
        *-- Legado: getDtInicial = Ctod('01/<mes>/<ano>'), getDtFinal = GoMonth(inicial,1)-1
        LogPasso("2a esperado legado: Ini=" + ;
            TRANSFORM(DATE(YEAR(DATE()), MONTH(DATE()), 1)) + " Fim=" + ;
            TRANSFORM(GOMONTH(DATE(YEAR(DATE()), MONTH(DATE()), 1), 1) - 1))
    CATCH TO loc_oErro
        LogPasso("2 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 3. handlers de KeyPress: existem, PUBLIC, e espelham no BO
    TRY
        LogPasso("3 handlers existem: DtInicialKeyPress=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "DtInicialKeyPress", 5)) + ;
            " DtFinalKeyPress=" + TRANSFORM(PEMSTATUS(loc_oForm, "DtFinalKeyPress", 5)) + ;
            " SincronizarPeriodoComBO=" + TRANSFORM(PEMSTATUS(loc_oForm, "SincronizarPeriodoComBO", 5)) + ;
            " ValidarPeriodo=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarPeriodo", 5)))
    CATCH TO loc_oErro
        LogPasso("3 FALHOU: " + loc_oErro.Message)
    ENDTRY

    TRY
        loc_oForm.txt_4c_Dtinicial.Value = {^2026-03-01}
        loc_oForm.txt_4c_Dtfinal.Value   = {^2026-03-31}
        loc_oForm.DtInicialKeyPress(13, 0)
        loc_oForm.DtFinalKeyPress(13, 0)
        LogPasso("3a pos KeyPress(13): BO.Ini=" + ;
            TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataInicial) + ;
            " BO.Fim=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataFinal) + ;
            " [esperado 01/03/2026 e 31/03/2026]")
    CATCH TO loc_oErro
        LogPasso("3a FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.txt_4c_Dtinicial.Value = {^2026-05-10}
        loc_oForm.DtInicialKeyPress(65, 0)
        LogPasso("3b KeyPress de tecla comum (65='A') NAO sincroniza: BO.Ini=" + ;
            TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataInicial) + ;
            " [deve continuar 01/03/2026]")
    CATCH TO loc_oErro
        LogPasso("3b FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 4. ValidarPeriodo - os TRES casos do mchkvalid legado + o caso valido
    TRY
        loc_oForm.txt_4c_Dtinicial.Value = {^2026-03-01}
        loc_oForm.txt_4c_Dtfinal.Value   = {^2026-03-31}
        loc_lOk = loc_oForm.ValidarPeriodo()
        LogPasso("4a periodo VALIDO (01/03 a 31/03): retorno=" + TRANSFORM(loc_lOk) + ;
            " Msg=[" + loc_oForm.this_cMsgValidacao + "] [esperado .T. e msg vazia]")
    CATCH TO loc_oErro
        LogPasso("4a FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.txt_4c_Dtinicial.Value = {^2026-03-01}
        loc_oForm.txt_4c_Dtfinal.Value   = {}
        loc_lOk = loc_oForm.ValidarPeriodo()
        LogPasso("4b Data Final VAZIA: retorno=" + TRANSFORM(loc_lOk) + ;
            " Msg=[" + loc_oForm.this_cMsgValidacao + "]" + ;
            " [legado: 'Data Final Invalida!!!' + foco em getDtFinal]")
    CATCH TO loc_oErro
        LogPasso("4b FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.txt_4c_Dtinicial.Value = {^2026-03-31}
        loc_oForm.txt_4c_Dtfinal.Value   = {^2026-03-01}
        loc_lOk = loc_oForm.ValidarPeriodo()
        LogPasso("4c Inicial > Final: retorno=" + TRANSFORM(loc_lOk) + ;
            " Msg=[" + loc_oForm.this_cMsgValidacao + "]" + ;
            " [legado: 'Data Inicial Maior Que a Data Final!!!' + foco em getDtInicial]")
    CATCH TO loc_oErro
        LogPasso("4c FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        *-- Legado: anos diferentes e (12 - MesIni) + MesFim + 1 > 12
        *--         01/2026 -> 12/2027: (12-1) + 12 + 1 = 24 > 12
        loc_oForm.txt_4c_Dtinicial.Value = {^2026-01-01}
        loc_oForm.txt_4c_Dtfinal.Value   = {^2027-12-31}
        loc_lOk = loc_oForm.ValidarPeriodo()
        LogPasso("4d periodo > 12 meses: retorno=" + TRANSFORM(loc_lOk) + ;
            " Msg=[" + loc_oForm.this_cMsgValidacao + "]" + ;
            " [legado: 'Periodo Ultrapassa Doze Meses!!!' + foco em getDtInicial]")
    CATCH TO loc_oErro
        LogPasso("4d FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    TRY
        loc_oForm.Release()
        LogPasso("5 Release: VARTYPE=" + VARTYPE(loc_oForm) + " [X = liberado]")
    CATCH TO loc_oErro
        LogPasso("5 FALHOU: " + loc_oErro.Message + " PROC=" + loc_oErro.Procedure)
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
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogPassoF6, .T.)
ENDPROC
