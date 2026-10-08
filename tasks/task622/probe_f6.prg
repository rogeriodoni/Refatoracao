SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task622\probe_f6_erros.txt"

LOCAL lcOut, loForm, loErro, lnSesAnt, lnLen1, lnLen2, lcBOAntes, lcBODepois
lcOut = "PROBE FASE 6 - FormSigPrIbb" + CHR(13) + CHR(10)

CD C:\4c\projeto\app\start
DO config.prg
gb_4c_ValidandoUI = .T.      && DEPOIS de DO config.prg (nunca antes)

*-- ConfigurarAmbiente() pendura nesta maquina: carregar a mao so o que o form usa
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
SET PROCEDURE TO (gcCaminhoClasses + "SIGPRIBLBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigPrIbbBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrIbb.prg") ADDITIVE

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigPrIbb", PADR("001TESTE", 29))
CATCH TO loErro
    lcOut = lcOut + "ERRO CREATEOBJECT: " + loErro.Message + ;
        " | Linha " + TRANSFORM(loErro.LineNo) + " | " + loErro.Procedure + CHR(13)+CHR(10)
ENDTRY

IF VARTYPE(loForm) # "O"
    lcOut = lcOut + "FALHA: CREATEOBJECT devolveu [" + VARTYPE(loForm) + "]" + CHR(13)+CHR(10)
ELSE
    lcOut = lcOut + "OK instanciou. BaseClass=[" + loForm.BaseClass + "] DataSessionId=" + ;
        TRANSFORM(loForm.DataSessionId) + CHR(13)+CHR(10)

    lcOut = lcOut + "PEM ValidarLocalPagamento = " + TRANSFORM(PEMSTATUS(loForm,"ValidarLocalPagamento",5)) + CHR(13)+CHR(10)
    lcOut = lcOut + "PEM ValidarTextoCedente   = " + TRANSFORM(PEMSTATUS(loForm,"ValidarTextoCedente",5)) + CHR(13)+CHR(10)
    lcOut = lcOut + "MaxLength GetLocals       = " + TRANSFORM(loForm.obj_4c_GetLocals.MaxLength) + "  (esperado 100)" + CHR(13)+CHR(10)
    lcOut = lcOut + "MaxLength GetTxtCds       = " + TRANSFORM(loForm.obj_4c_GetTxtCds.MaxLength) + "  (esperado 0 = sem limite)" + CHR(13)+CHR(10)

    *-- cursor TEM de nascer DENTRO da sessao privada (DataSession = 2),
    *-- senao USED() dentro dos metodos do form devolve .F.
    lnSesAnt = SET("DATASESSION")
    SET DATASESSION TO loForm.DataSessionId

    IF USED("cursor_4c_Dados")
        USE IN cursor_4c_Dados
    ENDIF
    CREATE CURSOR cursor_4c_Dados (FPags C(12), Parcs N(2,0), CLocals C(100), ;
        Vencs D, Datas D, Valos N(12,2), CTxtCds M)
    INSERT INTO cursor_4c_Dados (FPags, Parcs, CLocals, CTxtCds) ;
        VALUES ("30/60/90", 1, "LOCAL ORIGINAL", "TEXTO ORIGINAL")
    GO TOP IN cursor_4c_Dados

    loForm.obj_4c_GetLocals.ControlSource = "cursor_4c_Dados.CLocals"
    loForm.obj_4c_GetTxtCds.ControlSource = "cursor_4c_Dados.CTxtCds"

    *-- PROVA do BINDEVENT: chamar o evento NATIVO e conferir o efeito
    *-- (AEVENTS nao serve - o form tem DataSession = 2)
    loForm.obj_4c_GetLocals.Value = REPLICATE("X", 160)
    lnLen1 = LEN(ALLTRIM(loForm.obj_4c_GetLocals.Value))
    loForm.obj_4c_GetLocals.LostFocus()
    lnLen2 = LEN(ALLTRIM(loForm.obj_4c_GetLocals.Value))
    lcOut = lcOut + "LostFocus GetLocals: len antes=" + TRANSFORM(lnLen1) + ;
        " depois=" + TRANSFORM(lnLen2) + "  (esperado 160 -> 100)" + CHR(13)+CHR(10)

    loForm.obj_4c_GetTxtCds.Value = "TEXTO EDITADO PELO USUARIO"
    lcBOAntes = ALLTRIM(loForm.this_oBusinessObject.this_cTextoCedenteAtual)
    loForm.obj_4c_GetTxtCds.LostFocus()
    lcBODepois = ALLTRIM(loForm.this_oBusinessObject.this_cTextoCedenteAtual)
    lcOut = lcOut + "BO TextoCedente: antes=[" + lcBOAntes + "] depois=[" + lcBODepois + "]" + CHR(13)+CHR(10)
    lcOut = lcOut + "BO LocalPgto   : [" + ALLTRIM(loForm.this_oBusinessObject.this_cLocalPgtoAtual) + "]" + CHR(13)+CHR(10)
    lcOut = lcOut + "BO FPagsAtual  : [" + ALLTRIM(loForm.this_oBusinessObject.this_cFPagsAtual) + "]" + CHR(13)+CHR(10)
    lcOut = lcOut + "Guarda reentrancia (esperado .F.) = " + ;
        TRANSFORM(loForm.this_lSincronizandoParcela) + CHR(13)+CHR(10)

    *-- handler com o cursor em EOF nao pode estourar
    GO BOTTOM IN cursor_4c_Dados
    SKIP IN cursor_4c_Dados
    loForm.obj_4c_GetLocals.LostFocus()
    lcOut = lcOut + "LostFocus com EOF: OK (nao estourou)" + CHR(13)+CHR(10)

    SET DATASESSION TO lnSesAnt
    loForm.Release()
    loForm = .NULL.
ENDIF

STRTOFILE(lcOut, "C:\4c\tasks\task622\probe_f6_out.txt")
QUIT
