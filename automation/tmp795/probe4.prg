SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
#DEFINE LOGF "C:\4c\automation\tmp795\probe4_out.txt"
ON ERROR DO RegLog WITH "ERRO: " + MESSAGE() + " LN " + TRANSFORM(LINENO())
STRTOFILE("inicio" + CHR(13) + CHR(10), LOGF)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\tmp795\probe4_dialogs.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)
CD "C:\4c\projeto\app\start"
DO config.prg
ConfigurarAmbiente()
GarantirClasse("FormSIGOPRES")
SET PROCEDURE TO "C:\4c\automation\tmp795\stub_bo795.prg" ADDITIVE
gnConnHandle = 0

LOCAL loForm, llOK
loForm = CREATEOBJECT("FormSIGOPRES", 123.456)
loForm.this_oBusinessObject = CREATEOBJECT("StubSIGOPRESBO")
loForm.this_oBusinessObject.this_nSaldoInicial = 123.456

*-- CASO 1: projecao com SUCESSO, ponteiro na "data da operacao" (reg 5)
llOK = loForm.CarregarDados()
DO RegLog WITH "C1 CarregarDados sucesso = " + TRANSFORM(llOK)
DO RegLog WITH "C2 RECNO da grade        = " + TRANSFORM(RECNO("cursor_4c_Dados")) + ;
    "   (esperado 5 - a linha da data da operacao; antes do fix vinha 1)"
DO RegLog WITH "C3 estoque na linha      = " + TRANSFORM(cursor_4c_Dados.estoque) + "  (esperado 50)"
DO RegLog WITH "C4 form.this_nSaldo      = " + TRANSFORM(loForm.this_nSaldo) + "  (esperado 50)"
DO RegLog WITH "C5 this_lCalculoOK       = " + TRANSFORM(loForm.this_lCalculoOK)
DO RegLog WITH "C6 Grid ColumnCount=" + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + ;
    " RecSrc=[" + loForm.grd_4c_Dados.RecordSource + "]" + ;
    " C1cap=[" + loForm.grd_4c_Dados.Column1.Header1.Caption + "]" + ;
    " reccount=" + TRANSFORM(RECCOUNT("cursor_4c_Dados"))

*-- CASO 2: projecao FALHA - grade tem de voltar ao topo e o saldo de partida
*-- tem de sobreviver
loForm.this_oBusinessObject.this_lDeveFalhar = .T.
llOK = loForm.CarregarDados()
DO RegLog WITH "D1 CarregarDados sucesso = " + TRANSFORM(llOK) + "  (esperado .F.)"
DO RegLog WITH "D2 RECNO da grade        = " + TRANSFORM(RECNO("cursor_4c_Dados")) + ;
    "   (esperado 1 - fallback GO TOP)"
DO RegLog WITH "D3 form.this_nSaldo      = " + TRANSFORM(loForm.this_nSaldo) + ;
    "  (esperado 123.456 - saldo de partida, nao zero)"
DO RegLog WITH "D4 this_lCalculoOK       = " + TRANSFORM(loForm.this_lCalculoOK) + "  (esperado .F.)"

loForm.cmd_4c_Fwbtng1.Click()
DO RegLog WITH "D5 apos Click this_nSaldo= " + TRANSFORM(loForm.this_nSaldo) + "  (esperado 123.456)"

loForm.Release()
DO RegLog WITH "FIM"
QUIT

PROCEDURE RegLog
    LPARAMETERS pcMsg
    STRTOFILE(pcMsg + CHR(13) + CHR(10), LOGF, 1)
ENDPROC
