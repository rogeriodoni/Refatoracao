SET SAFETY OFF
SET RESOURCE OFF
PUBLIC gcOut
gcOut = "C:\4c\automation\probe784f8.txt"
STRTOFILE("", gcOut)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe784f8_dialogs.txt"

DO L WITH "0 - inicio"

CD C:\4c\projeto\app\start
DO config.prg
DO L WITH "1 - config.prg OK"

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
DO L WITH "2 - dependencias carregadas"

*-- ===== 1) instanciacao SEM form pai (harness/probe/ValidarUIFidelity) =====
LOCAL loc_oForm
loc_oForm = CREATEOBJECT("FormSigOpPdt")
DO L WITH "3 - CREATEOBJECT sem pai VARTYPE=[" + VARTYPE(loc_oForm) + "]"

IF VARTYPE(loc_oForm) != "O"
    DO L WITH "ABORT: form nao instanciou sem pai"
    QUIT
ENDIF

DO L WITH "4 - Caption=[" + loc_oForm.Caption + "] this_cOpEscolha=[" + loc_oForm.this_cOpEscolha + "]"
DO L WITH "5 - ColumnCount=[" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + "] RecordSource=[" + loc_oForm.grd_4c_Dados.RecordSource + "]"
DO L WITH "6 - cmd_4c_SelTudo.Visible=[" + TRANSFORM(loc_oForm.cmd_4c_SelTudo.Visible) + "] (esperado .T., modo INSERIR default)"
DO L WITH "7 - txt_4c_Procura.Visible=[" + TRANSFORM(loc_oForm.txt_4c_Procura.Visible) + "]"

*-- ===== 2) BtnOkClick sem form pai - nao pode estourar, so fecha =====
LOCAL loc_lPassou
loc_lPassou = .F.
TRY
    loc_oForm.BtnOkClick()
    loc_lPassou = .T.
CATCH TO loc_oErro
    DO L WITH "ERRO no BtnOkClick sem pai: " + loc_oErro.Message
ENDTRY
DO L WITH "8 - BtnOkClick sem pai executou sem estourar=[" + TRANSFORM(loc_lPassou) + "]"

*-- ===== 3) instanciacao COM form pai fake (reabilitacao real) =====
DO L WITH "8b - antes de criar form pai fake"
PUBLIC goFormPaiFake
goFormPaiFake = CREATEOBJECT("Form")
DO L WITH "8c - form pai fake CREATEOBJECT ok VARTYPE=[" + VARTYPE(goFormPaiFake) + "]"
goFormPaiFake.AddProperty("pcEscolha", "INSERIR")
DO L WITH "8d - AddProperty ok"
goFormPaiFake.Enabled = .F.
DO L WITH "9 - form pai fake criado, Enabled=[" + TRANSFORM(goFormPaiFake.Enabled) + "]"

LOCAL loc_oForm2
loc_oForm2 = CREATEOBJECT("FormSigOpPdt", goFormPaiFake, 1)
DO L WITH "10 - CREATEOBJECT com pai VARTYPE=[" + VARTYPE(loc_oForm2) + "] this_cOpEscolha=[" + loc_oForm2.this_cOpEscolha + "]"

IF VARTYPE(loc_oForm2) = "O"
    loc_oForm2.BtnOkClick()
    DO L WITH "11 - apos BtnOkClick: form pai Enabled=[" + TRANSFORM(goFormPaiFake.Enabled) + "] (esperado .T.)"
ENDIF

goFormPaiFake.Release()

SET DATASESSION TO 1
DO L WITH "FIM OK"
QUIT

PROCEDURE L
    LPARAMETERS par_cMsg
    STRTOFILE(par_cMsg + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
