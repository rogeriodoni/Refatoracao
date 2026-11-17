SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_f7_786_msgs.txt"
gb_4c_ValidandoUI      = .F.

LOCAL lcLog
lcLog = "C:\4c\automation\probe_f7_786.txt"
STRTOFILE("P0 inicio" + CHR(13)+CHR(10), lcLog)

DO config.prg
STRTOFILE("P1 config.prg OK" + CHR(13)+CHR(10), lcLog, 1)

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
STRTOFILE("P2 SET PROCEDURE OK" + CHR(13)+CHR(10), lcLog, 1)

*-- Simula o CHAMADOR (SIGOPPAG): cria BarBonus com as 3 colunas dele,
*-- com LIXO dentro, para provar que o Zap do Init limpa e o Append Blank
*-- deixa exatamente UMA linha.
CREATE CURSOR BarBonus (Codigos N(10), Valors N(12,2), Seqs N(3))
INSERT INTO BarBonus (Codigos, Valors, Seqs) VALUES (111, 9.99, 1)
INSERT INTO BarBonus (Codigos, Valors, Seqs) VALUES (222, 8.88, 2)
STRTOFILE("P3 BarBonus do chamador = " + TRANSFORM(RECCOUNT("BarBonus")) + ;
          " linhas / " + TRANSFORM(FCOUNT("BarBonus")) + " colunas" + CHR(13)+CHR(10), lcLog, 1)

LOCAL loForm, loErro
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGOPPGC", .NULL., 0, 150.00, .NULL.)
CATCH TO loErro
    STRTOFILE("P4 ERRO CREATEOBJECT: " + loErro.Message + " LN=" + ;
        TRANSFORM(loErro.LineNo) + " PROC=" + loErro.Procedure + CHR(13)+CHR(10), lcLog, 1)
ENDTRY

STRTOFILE("P4 VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13)+CHR(10), lcLog, 1)

IF VARTYPE(loForm) = "O"
    STRTOFILE("P5 pos-Init: RECCOUNT(BarBonus) = " + TRANSFORM(RECCOUNT("BarBonus")) + ;
              "  FCOUNT = " + TRANSFORM(FCOUNT("BarBonus")) + ;
              "  Codigos linha 1 = " + TRANSFORM(BarBonus.Codigos) + CHR(13)+CHR(10), lcLog, 1)
    STRTOFILE("P5 Grid.RecordSource = [" + loForm.grd_4c_Dados.RecordSource + "]" + ;
              "  ColumnCount = " + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + CHR(13)+CHR(10), lcLog, 1)
    STRTOFILE("P5 txt_4c_Saldo.Value = " + TRANSFORM(loForm.txt_4c_Saldo.Value) + CHR(13)+CHR(10), lcLog, 1)

    *-- CONFIRMAR com saldo <> 0: tem de RECUSAR (nao esconde a tela)
    LOCAL llRet
    llRet = loForm.BtnConfirmarClick()
    STRTOFILE("P6 Confirmar com saldo 150 -> retorno = " + TRANSFORM(llRet) + ;
              "  Visible = " + TRANSFORM(loForm.Visible) + CHR(13)+CHR(10), lcLog, 1)

    *-- CONFIRMAR com saldo ZERO: tem de ACEITAR
    loForm.txt_4c_Saldo.Value = 0
    llRet = loForm.BtnConfirmarClick()
    STRTOFILE("P7 Confirmar com saldo 0 -> retorno = " + TRANSFORM(llRet) + ;
              "  Visible = " + TRANSFORM(loForm.Visible) + ;
              "  VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13)+CHR(10), lcLog, 1)
    STRTOFILE("P7 BarBonus preservado = " + TRANSFORM(RECCOUNT("BarBonus")) + " linha(s)" + CHR(13)+CHR(10), lcLog, 1)

    *-- CANCELAR: tem de ZAPAR o cursor do chamador (sem travar em dialogo de SAFETY)
    loForm.BtnCancelarClick()
    STRTOFILE("P8 pos-Cancelar: RECCOUNT(BarBonus) = " + TRANSFORM(RECCOUNT("BarBonus")) + ;
              "  FCOUNT = " + TRANSFORM(FCOUNT("BarBonus")) + ;
              "  Visible = " + TRANSFORM(loForm.Visible) + ;
              "  VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13)+CHR(10), lcLog, 1)

    loForm.Release()
    STRTOFILE("P9 apos Release do chamador: VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13)+CHR(10), lcLog, 1)
ENDIF

STRTOFILE("FIM" + CHR(13)+CHR(10), lcLog, 1)
QUIT
