SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
#DEFINE LOGF "C:\4c\automation\tmp795\probe3_out.txt"
ON ERROR DO RegLog WITH "ERRO: " + MESSAGE() + " LN " + TRANSFORM(LINENO())
STRTOFILE("inicio" + CHR(13) + CHR(10), LOGF)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\tmp795\probe3_dialogs.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)
CD "C:\4c\projeto\app\start"
DO config.prg
ConfigurarAmbiente()
GarantirClasse("FormSIGOPRES")
gnConnHandle = 0

LOCAL loForm
*-- chamador entrega saldo de partida 123.456 e a projecao NAO roda
loForm = CREATEOBJECT("FormSIGOPRES", 123.456)
DO RegLog WITH "B1 this_nSaldo antes do Click = " + TRANSFORM(loForm.this_nSaldo) + ;
    "  (saldo de partida entregue pelo chamador)"
DO RegLog WITH "B2 BO.this_nSaldo            = " + TRANSFORM(loForm.this_oBusinessObject.this_nSaldo) + ;
    "  (projecao nao executada)"
loForm.cmd_4c_Fwbtng1.Click()
DO RegLog WITH "B3 this_nSaldo APOS o Click  = " + TRANSFORM(loForm.this_nSaldo) + ;
    "  <- o que o chamador recebe"
loForm.Release()
DO RegLog WITH "FIM"
QUIT

PROCEDURE RegLog
    LPARAMETERS pcMsg
    STRTOFILE(pcMsg + CHR(13) + CHR(10), LOGF, 1)
ENDPROC
