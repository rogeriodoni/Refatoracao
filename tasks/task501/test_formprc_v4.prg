SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

LOCAL loc_log4
loc_log4 = "C:\4c\tasks\task501\logs\06_testForm.log"
LOCAL loc_h4

loc_h4 = FCREATE(loc_log4)
=FPUTS(loc_h4, "=== TESTE v4 ===")
=FCLOSE(loc_h4)

CD C:\4c\projeto\app\start
DO config.prg
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\FormBuscaAuxiliar.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\FormErro.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\prcBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\cadastros\Formprc.prg ADDITIVE

PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
SQLSETPROP(gnConnHandle, "QueryTimeOut", 60)

loc_h4 = FOPEN(loc_log4, 1)
=FSEEK(loc_h4, 0, 2)
=FPUTS(loc_h4, "Loaded OK. gnConnHandle=" + TRANSFORM(gnConnHandle))
=FCLOSE(loc_h4)

*-- Test prcBO directly
TRY
    LOCAL loc_oBO4
    loc_oBO4 = CREATEOBJECT("prcBO")
    loc_h4 = FOPEN(loc_log4, 1)
    =FSEEK(loc_h4, 0, 2)
    =FPUTS(loc_h4, "prcBO created: " + loc_oBO4.Class)
    =FCLOSE(loc_h4)
CATCH TO loEx4
    loc_h4 = FOPEN(loc_log4, 1)
    =FSEEK(loc_h4, 0, 2)
    =FPUTS(loc_h4, "prcBO ERR: " + loEx4.Message + " L" + TRANSFORM(loEx4.LineNo) + " P:" + loEx4.Procedure)
    =FCLOSE(loc_h4)
ENDTRY

*-- Test setting gb_4c_ValidandoUI to suppress CarregarLista
PUBLIC gb_4c_ValidandoUI
gb_4c_ValidandoUI = .T.

*-- Test Formprc
TRY
    LOCAL loc_oForm4
    loc_oForm4 = CREATEOBJECT("Formprc")
    loc_h4 = FOPEN(loc_log4, 1)
    =FSEEK(loc_h4, 0, 2)
    =FPUTS(loc_h4, "Formprc created: " + loc_oForm4.Class)
    =FCLOSE(loc_h4)
CATCH TO loEx4
    loc_h4 = FOPEN(loc_log4, 1)
    =FSEEK(loc_h4, 0, 2)
    =FPUTS(loc_h4, "Formprc ERR: " + loEx4.Message + " L" + TRANSFORM(loEx4.LineNo) + " P:" + loEx4.Procedure)
    =FCLOSE(loc_h4)
ENDTRY

IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
    SQLDISCONNECT(gnConnHandle)
ENDIF

loc_h4 = FOPEN(loc_log4, 1)
=FSEEK(loc_h4, 0, 2)
=FPUTS(loc_h4, "DONE")
=FCLOSE(loc_h4)

QUIT
