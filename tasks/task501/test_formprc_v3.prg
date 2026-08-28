SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

LOCAL loc_log
loc_log = "C:\4c\tasks\task501\logs\06_testForm.log"
LOCAL loc_h3

loc_h3 = FCREATE(loc_log)
=FPUTS(loc_h3, "=== TESTE Formprc ===")
=FPUTS(loc_h3, "[ETAPA 1] Carregando dependencias...")
=FCLOSE(loc_h3)

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

loc_h3 = FOPEN(loc_log, 1)
=FSEEK(loc_h3, 0, 2)
=FPUTS(loc_h3, "OK - Dependencias carregadas")
=FCLOSE(loc_h3)

PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
IF gnConnHandle < 0
    loc_h3 = FOPEN(loc_log, 1)
    =FSEEK(loc_h3, 0, 2)
    =FPUTS(loc_h3, "ERRO - Falha na conexao SQL")
    =FCLOSE(loc_h3)
    QUIT
ENDIF
SQLSETPROP(gnConnHandle, "QueryTimeOut", 60)
loc_h3 = FOPEN(loc_log, 1)
=FSEEK(loc_h3, 0, 2)
=FPUTS(loc_h3, "OK - Conectado (Handle: " + TRANSFORM(gnConnHandle) + ")")
=FCLOSE(loc_h3)

loc_h3 = FOPEN(loc_log, 1)
=FSEEK(loc_h3, 0, 2)
=FPUTS(loc_h3, "[ETAPA 2] Criando objeto Formprc...")
=FCLOSE(loc_h3)

LOCAL loc_oForm3
TRY
    loc_oForm3 = CREATEOBJECT("Formprc")
    IF ISNULL(loc_oForm3) OR TYPE("loc_oForm3") # "O"
        loc_h3 = FOPEN(loc_log, 1)
        =FSEEK(loc_h3, 0, 2)
        =FPUTS(loc_h3, "ERRO - CREATEOBJECT retornou NULL")
        =FCLOSE(loc_h3)
    ELSE
        loc_h3 = FOPEN(loc_log, 1)
        =FSEEK(loc_h3, 0, 2)
        =FPUTS(loc_h3, "OK - Objeto criado: " + loc_oForm3.Class)
        =FCLOSE(loc_h3)
    ENDIF
CATCH TO loEx
    loc_h3 = FOPEN(loc_log, 1)
    =FSEEK(loc_h3, 0, 2)
    =FPUTS(loc_h3, "ERRO CREATEOBJECT: " + loEx.Message + " L" + TRANSFORM(loEx.LineNo) + " P:" + loEx.Procedure)
    =FCLOSE(loc_h3)
ENDTRY

IF TYPE("loc_oForm3") = "O" AND !ISNULL(loc_oForm3)
    loc_h3 = FOPEN(loc_log, 1)
    =FSEEK(loc_h3, 0, 2)
    =FPUTS(loc_h3, "[ETAPA 3] Mostrando formulario...")
    =FCLOSE(loc_h3)
    TRY
        loc_oForm3.WindowType = 0
        loc_oForm3.Show()
        DOEVENTS
        loc_h3 = FOPEN(loc_log, 1)
        =FSEEK(loc_h3, 0, 2)
        =FPUTS(loc_h3, "OK - Visivel=" + TRANSFORM(loc_oForm3.Visible) + " Width=" + TRANSFORM(loc_oForm3.Width))
        =FCLOSE(loc_h3)
    CATCH TO loEx
        loc_h3 = FOPEN(loc_log, 1)
        =FSEEK(loc_h3, 0, 2)
        =FPUTS(loc_h3, "ERRO Show: " + loEx.Message + " L" + TRANSFORM(loEx.LineNo))
        =FCLOSE(loc_h3)
    ENDTRY

    TRY
        loc_oForm3.Release()
        loc_h3 = FOPEN(loc_log, 1)
        =FSEEK(loc_h3, 0, 2)
        =FPUTS(loc_h3, "[ETAPA 5] OK - Formulario fechado")
        =FCLOSE(loc_h3)
    CATCH TO loEx
        loc_h3 = FOPEN(loc_log, 1)
        =FSEEK(loc_h3, 0, 2)
        =FPUTS(loc_h3, "ERRO Fechar: " + loEx.Message)
        =FCLOSE(loc_h3)
    ENDTRY
ENDIF

IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
    SQLDISCONNECT(gnConnHandle)
    gnConnHandle = 0
ENDIF

loc_h3 = FOPEN(loc_log, 1)
=FSEEK(loc_h3, 0, 2)
=FPUTS(loc_h3, "=== FIM DO TESTE === " + TTOC(DATETIME()))
=FCLOSE(loc_h3)

QUIT
