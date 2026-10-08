SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task622\probe_f8_erros.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL lcOut, loForm, loErro, lnSesAnt, lnI
LOCAL ARRAY laEv[1]
lcOut = "PROBE FASE 8 - FormSigPrIbb" + CHR(13) + CHR(10)

CD C:\4c\projeto\app\start
DO config.prg
gb_4c_ValidandoUI = .T.

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
    lcOut = lcOut + "1) instanciou OK. BaseClass=[" + loForm.BaseClass + "]" + CHR(13)+CHR(10)

    *-- 2) handlers renomeados existem?
    lcOut = lcOut + "2) PEM BtnEncerrarClick=" + TRANSFORM(PEMSTATUS(loForm,"BtnEncerrarClick",5)) + ;
        " BtnImprimirClick=" + TRANSFORM(PEMSTATUS(loForm,"BtnImprimirClick",5)) + ;
        " BtnEncerrarVISIBLE=" + TRANSFORM(PEMSTATUS(loForm,"BtnEncerrarClick",2)) + ;
        " BtnImprimirVISIBLE=" + TRANSFORM(PEMSTATUS(loForm,"BtnImprimirClick",2)) + CHR(13)+CHR(10)
    lcOut = lcOut + "   nomes antigos (esperado .F.): CmdOkClick=" + TRANSFORM(PEMSTATUS(loForm,"CmdOkClick",5)) + ;
        " CmdBtnImprimirClick=" + TRANSFORM(PEMSTATUS(loForm,"CmdBtnImprimirClick",5)) + CHR(13)+CHR(10)

    *-- 3) BINDEVENT dos dois botoes aponta para o nome NOVO?
    IF AEVENTS(laEv, loForm.cmd_4c_BtnImprimir) > 0
        FOR lnI = 1 TO ALEN(laEv, 1)
            lcOut = lcOut + "3) bind cmd_4c_BtnImprimir: evento=[" + TRANSFORM(laEv[lnI,2]) + ;
                "] delegate=[" + TRANSFORM(laEv[lnI,4]) + "]" + CHR(13)+CHR(10)
        ENDFOR
    ELSE
        lcOut = lcOut + "3) FALHA: cmd_4c_BtnImprimir SEM BINDEVENT" + CHR(13)+CHR(10)
    ENDIF
    IF AEVENTS(laEv, loForm.cmd_4c_Ok) > 0
        FOR lnI = 1 TO ALEN(laEv, 1)
            lcOut = lcOut + "   bind cmd_4c_Ok: evento=[" + TRANSFORM(laEv[lnI,2]) + ;
                "] delegate=[" + TRANSFORM(laEv[lnI,4]) + "]" + CHR(13)+CHR(10)
        ENDFOR
    ELSE
        lcOut = lcOut + "   FALHA: cmd_4c_Ok SEM BINDEVENT" + CHR(13)+CHR(10)
    ENDIF

    *-- cursor DENTRO da sessao privada
    lnSesAnt = SET("DATASESSION")
    SET DATASESSION TO loForm.DataSessionId
    IF USED("cursor_4c_Dados")
        USE IN cursor_4c_Dados
    ENDIF
    CREATE CURSOR cursor_4c_Dados (FPags C(12), Parcs N(2,0), CLocals C(100), ;
        Vencs D, Datas D, Valos N(12,2), CTxtCds M)
    INSERT INTO cursor_4c_Dados (FPags, Parcs, CLocals, CTxtCds, Valos) ;
        VALUES ("30/60/90", 1, "LOCAL 1", "TEXTO 1", 100.00)
    INSERT INTO cursor_4c_Dados (FPags, Parcs, CLocals, CTxtCds, Valos) ;
        VALUES ("A VISTA", 7, "LOCAL 7", "TEXTO 7", 250.00)
    GO BOTTOM

    *-- 4) a linha SELECIONADA (a 2a) chega ao BO?
    loForm.GridDadosAfterRowColChange(1)
    lcOut = lcOut + "4) BO apos linha 2: FPags=[" + ALLTRIM(loForm.this_oBusinessObject.this_cFPagsAtual) + ;
        "] Parcs=" + TRANSFORM(loForm.this_oBusinessObject.this_nParcsAtual) + ;
        "  (esperado A VISTA / 7)" + CHR(13)+CHR(10)

    *-- 5) Imprimir pede confirmacao citando a parcela SELECIONADA e,
    *--    com MsgConfirma=.F. em modo teste, NAO imprime.
    loForm.BtnImprimirClick()
    IF FILE(gc_4c_ArquivoErroTeste)
        lcOut = lcOut + "5) dialogo registrado:" + CHR(13)+CHR(10) + ;
            FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10)
        DELETE FILE (gc_4c_ArquivoErroTeste)
    ELSE
        lcOut = lcOut + "5) FALHA: BtnImprimirClick nao pediu confirmacao" + CHR(13)+CHR(10)
    ENDIF

    *-- 6) grade vazia = no-op silencioso (fiel ao "If Not Eof('crGrade')")
    SELECT cursor_4c_Dados
    ZAP
    loForm.BtnImprimirClick()
    lcOut = lcOut + "6) grade vazia: dialogo exibido=" + TRANSFORM(FILE(gc_4c_ArquivoErroTeste)) + ;
        "  (esperado .F.)" + CHR(13)+CHR(10)

    SET DATASESSION TO (lnSesAnt)

    *-- 7) Encerrar libera o form
    loForm.BtnEncerrarClick()
    lcOut = lcOut + "7) apos BtnEncerrarClick: VARTYPE(loForm)=[" + VARTYPE(loForm) + ;
        "]  (esperado O com Release pendente ou L)" + CHR(13)+CHR(10)
ENDIF

STRTOFILE(lcOut, "C:\4c\tasks\task622\probe_f8_out.txt")
QUIT
