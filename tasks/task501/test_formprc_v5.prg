SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

PUBLIC gb_4c_ValidandoUI, gb_4c_ModoTeste
gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste   = .T.

LOCAL loc_log5
loc_log5 = "C:\4c\tasks\task501\logs\06_testForm.log"
LOCAL loc_h5

loc_h5 = FCREATE(loc_log5)
=FPUTS(loc_h5, "=== TESTE v5 ===")
=FCLOSE(loc_h5)

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

TRY
    LOCAL loc_oForm5
    loc_oForm5 = CREATEOBJECT("Formprc")
    loc_h5 = FOPEN(loc_log5, 1)
    =FSEEK(loc_h5, 0, 2)
    =FPUTS(loc_h5, "OK - Formprc created")
    =FCLOSE(loc_h5)
CATCH TO loEx5
    loc_h5 = FOPEN(loc_log5, 1)
    =FSEEK(loc_h5, 0, 2)
    =FPUTS(loc_h5, "ERR " + TRANSFORM(loEx5.ErrorNo) + ": " + loEx5.Message)
    =FPUTS(loc_h5, "LineNo: " + TRANSFORM(loEx5.LineNo))
    =FPUTS(loc_h5, "Procedure: " + loEx5.Procedure)
    =FPUTS(loc_h5, "Details: " + loEx5.Details)
    IF TYPE("loEx5.LineContents") = "C"
        =FPUTS(loc_h5, "Line: " + loEx5.LineContents)
    ENDIF
    =FCLOSE(loc_h5)
ENDTRY

IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
    SQLDISCONNECT(gnConnHandle)
ENDIF

loc_h5 = FOPEN(loc_log5, 1)
=FSEEK(loc_h5, 0, 2)
=FPUTS(loc_h5, "DONE")
=FCLOSE(loc_h5)

QUIT
