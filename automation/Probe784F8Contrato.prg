SET SAFETY OFF
SET RESOURCE OFF
PUBLIC gcOut
gcOut = "C:\4c\automation\probe784f8contrato.txt"
STRTOFILE("", gcOut)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe784f8contrato_dialogs.txt"

CD C:\4c\projeto\app\start
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
SET PROCEDURE TO (gcCaminhoClasses + "SigOpPdtBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpPdt.prg") ADDITIVE
DO L WITH "0 - ambiente OK"

*-- pai stand-in COM o metodo (como o Formdmo real)
PUBLIC goPaiCom
goPaiCom = CREATEOBJECT("T784PaiCom")
goPaiCom.AddProperty("pcEscolha", "INSERIR")

*-- pai stand-in SEM o metodo (parent que nao implementa o contrato)
PUBLIC goPaiSem
goPaiSem = CREATEOBJECT("Form")
goPaiSem.AddProperty("pcEscolha", "INSERIR")

LOCAL loc_oDlg
loc_oDlg = CREATEOBJECT("T784Dlg", goPaiCom, 1)
DO L WITH "1 - dialogo com pai VARTYPE=[" + VARTYPE(loc_oDlg) + "]"

IF VARTYPE(loc_oDlg) = "O"
    *-- semeia as tres descricoes no BO, como MarcarPendencia faria
    loc_oDlg.this_oBusinessObject.this_cOrigemDesc      = "RAZAO ORIGEM"
    loc_oDlg.this_oBusinessObject.this_cDestinoDesc     = "RAZAO DESTINO"
    loc_oDlg.this_oBusinessObject.this_cResponsavelDesc = "RAZAO RESP"

    loc_oDlg.ChamarPai()
    DO L WITH "2 - pai recebeu chamadas=[" + TRANSFORM(goPaiCom.nChamadas) + "] (esperado 1)"
    DO L WITH "3 - args: [" + goPaiCom.cA + "] [" + goPaiCom.cB + "] [" + goPaiCom.cC + "]"

    *-- pai SEM o metodo: PEMSTATUS tem de evitar o estouro
    loc_oDlg.this_oFormPai = goPaiSem
    TRY
        loc_oDlg.ChamarPai()
        DO L WITH "4 - pai SEM o metodo: no-op sem estourar OK"
    CATCH TO loc_oErro
        DO L WITH "4 - ERRO com pai sem metodo: " + loc_oErro.Message
    ENDTRY

    *-- sem pai nenhum
    loc_oDlg.this_oFormPai = .NULL.
    TRY
        loc_oDlg.ChamarPai()
        DO L WITH "5 - sem pai: no-op sem estourar OK"
    CATCH TO loc_oErro
        DO L WITH "5 - ERRO sem pai: " + loc_oErro.Message
    ENDTRY
ENDIF

SET DATASESSION TO 1
DO L WITH "FIM OK"
QUIT

PROCEDURE L
LPARAMETERS par_cMsg
=STRTOFILE(par_cMsg + CHR(13) + CHR(10), gcOut, 1)
ENDPROC

DEFINE CLASS T784Dlg AS FormSigOpPdt
    PROCEDURE ChamarPai()
        THIS.AtualizarFormPai()
    ENDPROC
ENDDEFINE

DEFINE CLASS T784PaiCom AS Form
    nChamadas = 0
    cA = ""
    cB = ""
    cC = ""
    PROCEDURE AtualizarDadosPendencia(par_cDescOrigem, par_cDescDestino, par_cDescResponsavel)
        THIS.nChamadas = THIS.nChamadas + 1
        THIS.cA = IIF(VARTYPE(par_cDescOrigem) = "C", par_cDescOrigem, "<nao-C>")
        THIS.cB = IIF(VARTYPE(par_cDescDestino) = "C", par_cDescDestino, "<nao-C>")
        THIS.cC = IIF(VARTYPE(par_cDescResponsavel) = "C", par_cDescResponsavel, "<nao-C>")
    ENDPROC
ENDDEFINE
