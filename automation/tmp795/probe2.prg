SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE LOGF "C:\4c\automation\tmp795\probe2_out.txt"
ON ERROR DO RegLog WITH "ERRO: " + MESSAGE() + " | LINHA " + TRANSFORM(LINENO()) + " | " + PROGRAM()
STRTOFILE("inicio" + CHR(13) + CHR(10), LOGF)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\tmp795\probe2_dialogs.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

CD "C:\4c\projeto\app\start"
DO config.prg
ConfigurarAmbiente()
GarantirClasse("FormSIGOPRES")
gnConnHandle = 0

LOCAL loForm, lnEv
LOCAL ARRAY laEv[1]

*-- Init com parametros, como o chamador faz
loForm = CREATEOBJECT("FormSIGOPRES", 123.456)
DO RegLog WITH "A1 CREATEOBJECT(123.456) VARTYPE=" + VARTYPE(loForm)
DO RegLog WITH "A2 this_nSaldoInicial=" + TRANSFORM(loForm.this_nSaldoInicial) + ;
    " this_nSaldo(antes)=" + TRANSFORM(loForm.this_nSaldo) + ;
    " BO.this_nSaldoInicial=" + TRANSFORM(loForm.this_oBusinessObject.this_nSaldoInicial)

lnEv = AEVENTS(laEv, 1)
DO RegLog WITH "A3 AEVENTS total bindings=" + TRANSFORM(lnEv)
IF lnEv > 0
    LOCAL lnI
    FOR lnI = 1 TO ALEN(laEv, 1)
        DO RegLog WITH "    bind: " + TRANSFORM(laEv[lnI,2]) + " -> " + TRANSFORM(laEv[lnI,4])
    ENDFOR
ENDIF

*-- Simula o BO tendo calculado o estoque (sem tocar no banco)
loForm.this_oBusinessObject.this_nSaldo = 987.654
loForm.cmd_4c_Fwbtng1.Click()
DO RegLog WITH "A4 apos Click: form.this_nSaldo=" + TRANSFORM(loForm.this_nSaldo) + ;
    " (esperado 987.654) Visible=" + TRANSFORM(loForm.Visible) + ;
    " objeto vivo=" + VARTYPE(loForm)

loForm.Release()
DO RegLog WITH "A5 Release OK"
DO RegLog WITH "FIM"
QUIT

PROCEDURE RegLog
    LPARAMETERS pcMsg
    STRTOFILE(pcMsg + CHR(13) + CHR(10), LOGF, 1)
ENDPROC
