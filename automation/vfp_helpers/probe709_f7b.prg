*-- Probe 7b do task709 (FormSIGOPCPE) - BINDEVENT dos dois botoes e
*-- conferencia de que o caminho de recusa mostra UM dialogo so.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcRes, lcOut, loForm, loErr, lnC, lnE, lnI
lcOut = "C:\4c\automation\vfp_helpers\probe709_f7b_resultado.txt"
lcRes = ""

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\probe709_f7b_dialogs.txt"

PUBLIC gnConnHandle
gnConnHandle = 0

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SIGOPCPEBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSIGOPCPE.prg") ADDITIVE

*-- ON ERROR proprio: config.prg instala um handler que ENGOLE o erro e
*-- segue para a linha seguinte - foi isso que fez o bloco de BINDEVENT do
*-- probe anterior sair VAZIO em vez de acusar a falha.
PUBLIC gcProbeErro
gcProbeErro = ""
ON ERROR gcProbeErro = gcProbeErro + "[ERRO " + TRANSFORM(ERROR()) + " LN=" + TRANSFORM(LINENO()) + ": " + MESSAGE() + "]"

loForm = .NULL.
loForm = CREATEOBJECT("FormSIGOPCPE")
lcRes = lcRes + "VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13) + CHR(10)
STRTOFILE(lcRes, lcOut)

IF VARTYPE(loForm) = "O"
    *-- AEVENTS sobre o OBJETO devolve os eventos ligados por BINDEVENT.
    LOCAL ARRAY laEvC[1]
    LOCAL ARRAY laEvE[1]

    lnC = AEVENTS(laEvC, loForm.cnt_4c_Botoes.cmd_4c_Confirmar)
    lcRes = lcRes + "AEVENTS(cmd_4c_Confirmar) = " + TRANSFORM(lnC) + CHR(13) + CHR(10)
    IF lnC > 0
        FOR lnI = 1 TO lnC
            lcRes = lcRes + "   [" + TRANSFORM(lnI) + "] evento=" + ;
                    TRANSFORM(laEvC[lnI, 2]) + " delegate=" + ;
                    TRANSFORM(laEvC[lnI, 4]) + CHR(13) + CHR(10)
        ENDFOR
    ENDIF

    lnE = AEVENTS(laEvE, loForm.cnt_4c_Botoes.cmd_4c_Encerrar)
    lcRes = lcRes + "AEVENTS(cmd_4c_Encerrar)  = " + TRANSFORM(lnE) + CHR(13) + CHR(10)
    IF lnE > 0
        FOR lnI = 1 TO lnE
            lcRes = lcRes + "   [" + TRANSFORM(lnI) + "] evento=" + ;
                    TRANSFORM(laEvE[lnI, 2]) + " delegate=" + ;
                    TRANSFORM(laEvE[lnI, 4]) + CHR(13) + CHR(10)
        ENDFOR
    ENDIF
    STRTOFILE(lcRes, lcOut)

    *-- Recusa por falta de conexao: um dialogo SO (ver _dialogs.txt).
    loForm.BtnConfirmarClick()
    lcRes = lcRes + "form ABERTO apos Confirmar recusado = " + ;
            TRANSFORM(VARTYPE(loForm) = "O") + CHR(13) + CHR(10)
    lcRes = lcRes + "this_lErroExibido = " + ;
            TRANSFORM(loForm.this_oBusinessObject.this_lErroExibido) + CHR(13) + CHR(10)

    *-- Click REAL (o do usuario) em vez da chamada direta ao metodo: prova
    *-- que o BINDEVENT dispara o handler.
    loForm.cnt_4c_Botoes.cmd_4c_Encerrar.Click()
    lcRes = lcRes + "VARTYPE(loForm) apos Click no Encerrar = " + VARTYPE(loForm) + CHR(13) + CHR(10)
ENDIF

lcRes = lcRes + "ON ERROR capturou: [" + gcProbeErro + "]" + CHR(13) + CHR(10)
lcRes = lcRes + "FIM" + CHR(13) + CHR(10)
STRTOFILE(lcRes, lcOut)
QUIT
