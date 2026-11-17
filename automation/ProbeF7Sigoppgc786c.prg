SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_f7_786c_msgs.txt"
gb_4c_ValidandoUI      = .F.

LOCAL lcLog
lcLog = "C:\4c\automation\probe_f7_786c.txt"
STRTOFILE("C0 inicio" + CHR(13)+CHR(10), lcLog)

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
SET PROCEDURE TO (gcCaminhoClasses + "SIGOPPGCBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPPGC.prg") ADDITIVE

LOCAL lnSes, loPai
lnSes = SET("DATASESSION")
loPai = CREATEOBJECT("Form")
loPai.Enabled = .T.

CREATE CURSOR BarBonus (Codigos N(10), Valors N(12,2), Seqs N(3))
INSERT INTO BarBonus (Codigos, Valors, Seqs) VALUES (111, 9.99, 1)

LOCAL loForm, loErro, llRet
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGOPPGC", loPai, lnSes, 150.00, .NULL.)
CATCH TO loErro
    STRTOFILE("C1 ERRO: " + loErro.Message + " LN=" + TRANSFORM(loErro.LineNo) + ;
              " PROC=" + loErro.Procedure + CHR(13)+CHR(10), lcLog, 1)
ENDTRY

STRTOFILE("C1 VARTYPE(loForm)=" + VARTYPE(loForm) + "  Pai.Enabled=" + ;
          TRANSFORM(loPai.Enabled) + "  (legado: .F. enquanto o dialogo esta aberto)" + CHR(13)+CHR(10), lcLog, 1)

IF VARTYPE(loForm) = "O"
    STRTOFILE("C2 BarBonus pos-Init: RECCOUNT=" + TRANSFORM(RECCOUNT("BarBonus")) + ;
              "  FCOUNT=" + TRANSFORM(FCOUNT("BarBonus")) + ;
              "  Codigos=" + TRANSFORM(BarBonus.Codigos) + ;
              "  Saldo=" + TRANSFORM(loForm.txt_4c_Saldo.Value) + CHR(13)+CHR(10), lcLog, 1)

    *-- Confirmar com saldo != 0: RECUSA e o pai SEGUE desabilitado
    llRet = loForm.BtnConfirmarClick()
    STRTOFILE("C3 Confirmar(saldo 150): retorno=" + TRANSFORM(llRet) + ;
              "  Pai.Enabled=" + TRANSFORM(loPai.Enabled) + CHR(13)+CHR(10), lcLog, 1)

    *-- Confirmar com saldo zerado: ACEITA, reabilita o pai e NAO zapa o cursor
    loForm.txt_4c_Saldo.Value = 0
    llRet = loForm.BtnConfirmarClick()
    STRTOFILE("C4 Confirmar(saldo 0): retorno=" + TRANSFORM(llRet) + ;
              "  Pai.Enabled=" + TRANSFORM(loPai.Enabled) + ;
              "  BarBonus RECCOUNT=" + TRANSFORM(RECCOUNT("BarBonus")) + ;
              "  VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13)+CHR(10), lcLog, 1)

    *-- Cancelar: ZAPA o cursor do chamador (sinal de cancelamento)
    loPai.Enabled = .F.
    loForm.BtnCancelarClick()
    STRTOFILE("C5 Cancelar: Pai.Enabled=" + TRANSFORM(loPai.Enabled) + ;
              "  BarBonus RECCOUNT=" + TRANSFORM(RECCOUNT("BarBonus")) + ;
              "  FCOUNT=" + TRANSFORM(FCOUNT("BarBonus")) + ;
              "  VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13)+CHR(10), lcLog, 1)

    loForm.Release()
    STRTOFILE("C6 Release do chamador: VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13)+CHR(10), lcLog, 1)
ENDIF

STRTOFILE("FIM" + CHR(13)+CHR(10), lcLog, 1)
QUIT
