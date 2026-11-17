SET SAFETY OFF
SET RESOURCE OFF
PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe786_erros.txt"

LOCAL lcOut, loForm, loErr, lnSess
lcOut = ""
STRTOFILE("[1] inicio" + CHR(13) + CHR(10), "C:\4c\automation\probe786_out.txt")

DO config.prg
SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
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
STRTOFILE("[2] deps carregadas" + CHR(13) + CHR(10), "C:\4c\automation\probe786_out.txt", 1)

TRY
    loForm = CREATEOBJECT("FormSIGOPPGC")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO_CREATEOBJECT=" + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY
STRTOFILE("[3] createobject feito" + CHR(13) + CHR(10), "C:\4c\automation\probe786_out.txt", 1)

lcOut = lcOut + "VARTYPE_FORM=" + VARTYPE(loForm) + CHR(13) + CHR(10)

IF VARTYPE(loForm) = "O"
    lcOut = lcOut + "LBL2_CAP=[" + loForm.lbl_4c_Label2.Caption + "] W=" + TRANSFORM(loForm.lbl_4c_Label2.Width) + " TOP=" + TRANSFORM(loForm.lbl_4c_Label2.Top) + " FORE=" + TRANSFORM(loForm.lbl_4c_Label2.ForeColor) + CHR(13) + CHR(10)
    lcOut = lcOut + "LBL3_CAP=[" + loForm.lbl_4c_Label3.Caption + "] W=" + TRANSFORM(loForm.lbl_4c_Label3.Width) + " TOP=" + TRANSFORM(loForm.lbl_4c_Label3.Top) + CHR(13) + CHR(10)
    lcOut = lcOut + "COL1_CURCTL=[" + loForm.grd_4c_Dados.Column1.CurrentControl + "] SPARSE=" + TRANSFORM(loForm.grd_4c_Dados.Column1.Sparse) + CHR(13) + CHR(10)
    lcOut = lcOut + "COL2_CURCTL=[" + loForm.grd_4c_Dados.Column2.CurrentControl + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "COL1_CLS=[" + loForm.grd_4c_Dados.Column1.txt_4c_CelBarra.Class + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "COL2_CLS=[" + loForm.grd_4c_Dados.Column2.txt_4c_CelValor.Class + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "COL2_WHEN=" + TRANSFORM(loForm.grd_4c_Dados.Column2.txt_4c_CelValor.When()) + CHR(13) + CHR(10)
    lcOut = lcOut + "SALDO_INI=" + TRANSFORM(loForm.txt_4c_Saldo.Value) + CHR(13) + CHR(10)

    *-- Cursor vive na datasession PRIVADA do form
    lnSess = SET("Datasession")
    SET DATASESSION TO loForm.DataSessionId
    lcOut = lcOut + "USED_BARBONUS=" + TRANSFORM(USED("BarBonus")) + CHR(13) + CHR(10)

    loForm.this_oBusinessObject.this_nSaldoInicial = 100
    loForm.this_oBusinessObject.this_nValorPorBarra = 30

    SELECT BarBonus
    ZAP
    INSERT INTO BarBonus (Codigos, Valors) VALUES (1001000001, 30)
    INSERT INTO BarBonus (Codigos, Valors) VALUES (1001000002, 30)
    INSERT INTO BarBonus (Codigos, Valors) VALUES (0, 0)
    GO TOP
    lcOut = lcOut + "RECCOUNT=" + TRANSFORM(RECCOUNT("BarBonus")) + CHR(13) + CHR(10)

    *-- Funil de totais: BO calcula, form espelha
    loForm.AtualizarSaldoEQuantidade()
    lcOut = lcOut + "BO_QTDE=" + TRANSFORM(loForm.this_oBusinessObject.this_nQtdeBarras) + " (esperado 2)" + CHR(13) + CHR(10)
    lcOut = lcOut + "BO_SALDO=" + TRANSFORM(loForm.this_oBusinessObject.this_nSaldoAtual) + " (esperado 40)" + CHR(13) + CHR(10)
    lcOut = lcOut + "LBL3_RUNTIME=[" + loForm.lbl_4c_Label3.Caption + "] (esperado [ 2 ])" + CHR(13) + CHR(10)
    lcOut = lcOut + "SALDO_RUNTIME=" + TRANSFORM(loForm.txt_4c_Saldo.Value) + CHR(13) + CHR(10)
    lcOut = lcOut + "RECNO_POS=" + TRANSFORM(RECNO("BarBonus")) + " ALIAS=" + ALIAS() + CHR(13) + CHR(10)

    *-- Cursor VAZIO: legado devolve zero linhas e saldo = inicial
    SELECT BarBonus
    ZAP
    loForm.AtualizarSaldoEQuantidade()
    lcOut = lcOut + "VAZIO_QTDE=" + TRANSFORM(loForm.this_oBusinessObject.this_nQtdeBarras) + " (esperado 0)" + CHR(13) + CHR(10)
    lcOut = lcOut + "VAZIO_SALDO=" + TRANSFORM(loForm.this_oBusinessObject.this_nSaldoAtual) + " (esperado 100)" + CHR(13) + CHR(10)

    SET DATASESSION TO lnSess
    loForm.Release()
ENDIF

lcOut = lcOut + "ERROS_TESTE=" + IIF(FILE("C:\4c\automation\probe786_erros.txt"), FILETOSTR("C:\4c\automation\probe786_erros.txt"), "(nenhum)") + CHR(13) + CHR(10)
STRTOFILE(lcOut, "C:\4c\automation\probe786_out.txt", 1)
QUIT
