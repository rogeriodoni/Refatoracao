SET SAFETY OFF
SET RESOURCE OFF
PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe786b_erros.txt"

LOCAL lcOut, loForm, loCel, lnSess
lcOut = ""
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

loForm = CREATEOBJECT("FormSIGOPPGC")
IF VARTYPE(loForm) = "O"
    loCel = loForm.grd_4c_Dados.Column1.txt_4c_CelBarra
    lnSess = SET("Datasession")
    SET DATASESSION TO loForm.DataSessionId

    loForm.this_oBusinessObject.this_nSaldoInicial  = 100
    loForm.this_oBusinessObject.this_nValorPorBarra = 30

    SELECT BarBonus
    ZAP
    INSERT INTO BarBonus (Codigos, Valors) VALUES (0, 0)
    GO TOP

    *-- (a) When da celula: SET CONFIRM ON + guarda o valor anterior
    loCel.Value = 0
    lcOut = lcOut + "WHEN_RET=" + TRANSFORM(loCel.When()) + " (esperado .T.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "CONFIRM_POS_WHEN=[" + SET("Confirm") + "] (esperado ON)" + CHR(13) + CHR(10)
    lcOut = lcOut + "ANTERIOR_1=" + TRANSFORM(loForm.this_nCodigoBarraAnterior) + " (esperado 0)" + CHR(13) + CHR(10)

    loCel.Value = 1001000007
    = loCel.When()
    lcOut = lcOut + "ANTERIOR_2=" + TRANSFORM(loForm.this_nCodigoBarraAnterior) + " (esperado 1001000007)" + CHR(13) + CHR(10)

    *-- (b) Valid com celula em 0: curto-circuito do legado (If This.Value > 0)
    loForm.this_nCodigoBarraAnterior = 0
    loCel.Value = 0
    lcOut = lcOut + "VALID_ZERO=" + TRANSFORM(loCel.Valid()) + " (esperado .T.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "RECCOUNT_ZERO=" + TRANSFORM(RECCOUNT("BarBonus")) + " (esperado 1 - nada inserido)" + CHR(13) + CHR(10)

    *-- (c) Valid com barra > 0 e SEM conexao: BO recusa -> celula zerada e .F.
    loCel.Value = 1001000009
    lcOut = lcOut + "VALID_RECUSA=" + TRANSFORM(loCel.Valid()) + " (esperado .F.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "CEL_POS_RECUSA=" + TRANSFORM(loCel.Value) + " (esperado 0)" + CHR(13) + CHR(10)
    lcOut = lcOut + "CURSOR_POS_RECUSA=" + TRANSFORM(BarBonus.Codigos) + " (esperado 0)" + CHR(13) + CHR(10)
    lcOut = lcOut + "RECCOUNT_RECUSA=" + TRANSFORM(RECCOUNT("BarBonus")) + " (esperado 1)" + CHR(13) + CHR(10)

    *-- (d) LostFocus: SET CONFIRM OFF (par do When)
    loForm.AtualizarSaldoEQuantidade()
    lcOut = lcOut + "CONFIRM_POS_LOSTFOCUS=[" + SET("Confirm") + "] (esperado OFF)" + CHR(13) + CHR(10)

    SET DATASESSION TO lnSess
    loForm.Release()
ELSE
    lcOut = lcOut + "FALHOU_CREATEOBJECT" + CHR(13) + CHR(10)
ENDIF

lcOut = lcOut + "--- ERROS CAPTURADOS ---" + CHR(13) + CHR(10)
lcOut = lcOut + IIF(FILE("C:\4c\automation\probe786b_erros.txt"), FILETOSTR("C:\4c\automation\probe786b_erros.txt"), "(nenhum)")
STRTOFILE(lcOut, "C:\4c\automation\probe786b_out.txt")
QUIT
