SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_f7_786b_msgs.txt"
gb_4c_ValidandoUI      = .F.

LOCAL lcLog
lcLog = "C:\4c\automation\probe_f7_786b.txt"
STRTOFILE("P0 inicio - datasession do chamador = " + TRANSFORM(SET("DATASESSION")) + CHR(13)+CHR(10), lcLog)

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

LOCAL lnSesChamador
lnSesChamador = SET("DATASESSION")

CREATE CURSOR BarBonus (Codigos N(10), Valors N(12,2), Seqs N(3))
INSERT INTO BarBonus (Codigos, Valors, Seqs) VALUES (111, 9.99, 1)
INSERT INTO BarBonus (Codigos, Valors, Seqs) VALUES (222, 8.88, 2)
STRTOFILE("P1 chamador criou BarBonus na sessao " + TRANSFORM(lnSesChamador) + ;
          " com " + TRANSFORM(RECCOUNT("BarBonus")) + " linhas" + CHR(13)+CHR(10), lcLog, 1)

LOCAL loForm, loErro
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGOPPGC", .NULL., lnSesChamador, 150.00, .NULL.)
CATCH TO loErro
    STRTOFILE("P2 ERRO CREATEOBJECT: " + loErro.Message + " LN=" + ;
        TRANSFORM(loErro.LineNo) + " PROC=" + loErro.Procedure + CHR(13)+CHR(10), lcLog, 1)
ENDTRY

STRTOFILE("P2 VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13)+CHR(10), lcLog, 1)

IF VARTYPE(loForm) = "O"
    STRTOFILE("P3 loForm.DataSessionId = " + TRANSFORM(loForm.DataSessionId) + ;
              "  SET(DATASESSION) agora = " + TRANSFORM(SET("DATASESSION")) + CHR(13)+CHR(10), lcLog, 1)

    *-- volta explicitamente para a sessao do chamador para medir o cursor DELE
    SET DATASESSION TO (lnSesChamador)
    STRTOFILE("P4 cursor do CHAMADOR pos-Init: USED=" + TRANSFORM(USED("BarBonus")) + ;
              "  RECCOUNT=" + TRANSFORM(IIF(USED("BarBonus"), RECCOUNT("BarBonus"), -1)) + ;
              "  FCOUNT=" + TRANSFORM(IIF(USED("BarBonus"), FCOUNT("BarBonus"), -1)) + CHR(13)+CHR(10), lcLog, 1)

    SET DATASESSION TO (loForm.DataSessionId)
    STRTOFILE("P5 sessao PRIVADA do form: USED(BarBonus)=" + TRANSFORM(USED("BarBonus")) + ;
              "  RECCOUNT=" + TRANSFORM(IIF(USED("BarBonus"), RECCOUNT("BarBonus"), -1)) + ;
              "  FCOUNT=" + TRANSFORM(IIF(USED("BarBonus"), FCOUNT("BarBonus"), -1)) + CHR(13)+CHR(10), lcLog, 1)
    SET DATASESSION TO (lnSesChamador)

    *-- CANCELAR: onde o Zap cai?
    loForm.BtnCancelarClick()

    SET DATASESSION TO (lnSesChamador)
    STRTOFILE("P6 pos-Cancelar, cursor do CHAMADOR: RECCOUNT=" + ;
              TRANSFORM(IIF(USED("BarBonus"), RECCOUNT("BarBonus"), -1)) + CHR(13)+CHR(10), lcLog, 1)
    SET DATASESSION TO (loForm.DataSessionId)
    STRTOFILE("P7 pos-Cancelar, sessao PRIVADA: RECCOUNT=" + ;
              TRANSFORM(IIF(USED("BarBonus"), RECCOUNT("BarBonus"), -1)) + CHR(13)+CHR(10), lcLog, 1)
    SET DATASESSION TO (lnSesChamador)

    loForm.Release()
ENDIF

STRTOFILE("FIM" + CHR(13)+CHR(10), lcLog, 1)
QUIT
