SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_UsuarioLogado

gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_712_f6b_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"

ERASE C:\4c\automation\probe_712_f6b_dialogs.txt

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\SigOpCprBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\operacionais\FormSigOpCpr.prg ADDITIVE

LOCAL lcOut, loF, loPai, loErr, loStub
lcOut = ""

lcOut = lcOut + "=== RECUSA: BO reporta destino DUPLICADO ===" + CHR(13) + CHR(10)
loPai = CREATEOBJECT("Form")
loF   = CREATEOBJECT("FormSigOpCpr", loPai, "PROC ORIGEM 1", .F.)

*-- Troca o BO por um stub que recusa, e finge conexao viva para o guard
*-- da nota 31 deixar a conferencia passar.
loStub = CREATEOBJECT("StubBORecusa")
loF.this_oBusinessObject = loStub
gnConnHandle = 99

loF.txt_4c_Destino.Value = "PROC JA EXISTE"
TRY
    loF.ValidarDestino()
    lcOut = lcOut + "  ValidarDestino rodou sem excecao" + CHR(13) + CHR(10)
CATCH TO loErr
    lcOut = lcOut + "  EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY
lcOut = lcOut + "  BO foi consultado    = " + TRANSFORM(loStub.lChamado) + " (esperado .T.)" + CHR(13) + CHR(10)
lcOut = lcOut + "  valor recebido pelo BO = [" + loStub.cRecebido + "] (esperado PROC JA EXISTE)" + CHR(13) + CHR(10)
lcOut = lcOut + "  Value preservado     = [" + loF.txt_4c_Destino.Value + "] (NUNCA apagar - regra #50)" + CHR(13) + CHR(10)
lcOut = lcOut + "  guarda liberada      = " + TRANSFORM(loF.this_lEmValidaDestino) + " (esperado .F.)" + CHR(13) + CHR(10)

lcOut = lcOut + CHR(13) + CHR(10) + "=== REENTRANCIA: guarda ligada bloqueia 2a entrada ===" + CHR(13) + CHR(10)
loStub.lChamado  = .F.
loStub.cRecebido = ""
loF.this_lEmValidaDestino = .T.
loF.ValidarDestino()
lcOut = lcOut + "  BO consultado com guarda ligada = " + TRANSFORM(loStub.lChamado) + " (esperado .F.)" + CHR(13) + CHR(10)
lcOut = lcOut + "  guarda intacta = " + TRANSFORM(loF.this_lEmValidaDestino) + " (esperado .T. - nao liberou)" + CHR(13) + CHR(10)
loF.this_lEmValidaDestino = .F.

lcOut = lcOut + CHR(13) + CHR(10) + "=== ESC (LASTKEY 27) e campo VAZIO nao consultam ===" + CHR(13) + CHR(10)
loStub.lChamado = .F.
loF.txt_4c_Destino.Value = ""
loF.ValidarDestino()
lcOut = lcOut + "  campo vazio -> BO consultado = " + TRANSFORM(loStub.lChamado) + " (esperado .F.)" + CHR(13) + CHR(10)

gnConnHandle = -1
loF.Release()

lcOut = lcOut + CHR(13) + CHR(10) + "=== DIALOGOS capturados ===" + CHR(13) + CHR(10)
IF FILE("C:\4c\automation\probe_712_f6b_dialogs.txt")
    lcOut = lcOut + FILETOSTR("C:\4c\automation\probe_712_f6b_dialogs.txt")
ELSE
    lcOut = lcOut + "  (nenhum dialogo gravado)" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\probe_712_f6b_out.txt")
QUIT

DEFINE CLASS StubBORecusa AS Custom
    lChamado          = .F.
    cRecebido         = ""
    this_cMensagemErro = ""
    this_lComissao     = .F.

    FUNCTION ValidarDestino(par_cDestino)
        THIS.lChamado  = .T.
        THIS.cRecebido = IIF(VARTYPE(par_cDestino) = "C", par_cDestino, "<nao-C>")
        THIS.this_cMensagemErro = "Processo J" + CHR(225) + " Cadastrado!!!"
        RETURN .F.
    ENDFUNC
ENDDEFINE
