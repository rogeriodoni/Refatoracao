SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

LOCAL loc_log, loc_h
loc_log = "C:\4c\tasks\task501\logs\06_testForm.log"

loc_h = FCREATE(loc_log)
=FPUTS(loc_h, "=== TESTE v7 ===")
=FPUTS(loc_h, "S1: Iniciando config...")
=FCLOSE(loc_h)

CD C:\4c\projeto\app\start
DO config.prg

*-- IMPORTANTE: config.prg seta gb_4c_ValidandoUI=.F.
*-- Restaurar para .T. para evitar SQL na criacao do form
PUBLIC gb_4c_ValidandoUI, gb_4c_ModoTeste
gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste   = .T.

loc_h = FOPEN(loc_log, 1)
=FSEEK(loc_h, 0, 2)
=FPUTS(loc_h, "S2: config.prg OK, ValidandoUI=" + TRANSFORM(gb_4c_ValidandoUI))
=FCLOSE(loc_h)

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

loc_h = FOPEN(loc_log, 1)
=FSEEK(loc_h, 0, 2)
=FPUTS(loc_h, "S3: Procedimentos carregados")
=FCLOSE(loc_h)

PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
SQLSETPROP(gnConnHandle, "QueryTimeOut", 60)

loc_h = FOPEN(loc_log, 1)
=FSEEK(loc_h, 0, 2)
=FPUTS(loc_h, "S4: DB conectado (handle=" + TRANSFORM(gnConnHandle) + ")")
=FCLOSE(loc_h)

TRY
    LOCAL loc_oForm
    loc_oForm = CREATEOBJECT("Formprc")
    loc_h = FOPEN(loc_log, 1)
    =FSEEK(loc_h, 0, 2)
    =FPUTS(loc_h, "OK - Formprc created")
    =FCLOSE(loc_h)
CATCH TO loEx7
    loc_h = FOPEN(loc_log, 1)
    =FSEEK(loc_h, 0, 2)
    =FPUTS(loc_h, "ERR " + TRANSFORM(loEx7.ErrorNo) + ": " + loEx7.Message)
    =FPUTS(loc_h, "LineNo: " + TRANSFORM(loEx7.LineNo))
    =FPUTS(loc_h, "Procedure: " + loEx7.Procedure)
    =FPUTS(loc_h, "Details: " + loEx7.Details)
    IF TYPE("loEx7.LineContents") = "C"
        =FPUTS(loc_h, "Line: " + loEx7.LineContents)
    ENDIF
    =FCLOSE(loc_h)
ENDTRY

IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
    SQLDISCONNECT(gnConnHandle)
ENDIF

loc_h = FOPEN(loc_log, 1)
=FSEEK(loc_h, 0, 2)
=FPUTS(loc_h, "DONE")
=FCLOSE(loc_h)

QUIT
