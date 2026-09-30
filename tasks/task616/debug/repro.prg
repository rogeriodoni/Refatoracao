*-- Standalone repro: isolates FormSigPrGloT instantiation from the FormTester harness
CLOSE ALL
SYS(2335, 0)
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

PUBLIC gb_4c_ValidandoUI
gb_4c_ValidandoUI = .T.
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task616\debug\vfp_error_details.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE("00-before-config" + CHR(13) + CHR(10), "C:\4c\tasks\task616\debug\trace.log", .F.)

LOCAL loc_cDirAtual
loc_cDirAtual = SYS(5) + CURDIR()
CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
gb_4c_ValidandoUI = .T.
CD (loc_cDirAtual)

PUBLIC gnConnHandle
gnConnHandle = 0

STRTOFILE("00b-config-done-before-createobject" + CHR(13) + CHR(10), "C:\4c\tasks\task616\debug\trace.log", .T.)

LOCAL loc_oForm, loc_oErr
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSigPrGloT")
CATCH TO loc_oErr
    STRTOFILE("99-EXCEPTION: " + loc_oErr.Message + " Ln:" + TRANSFORM(loc_oErr.LineNo) + " Proc:" + loc_oErr.Procedure + CHR(13) + CHR(10), "C:\4c\tasks\task616\debug\trace.log", .T.)
ENDTRY

STRTOFILE("15-createobject-returned VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), "C:\4c\tasks\task616\debug\trace.log", .T.)

IF VARTYPE(loc_oForm) = "O"
    loc_oForm.Release()
    loc_oForm = .NULL.
ENDIF

STRTOFILE("16-done" + CHR(13) + CHR(10), "C:\4c\tasks\task616\debug\trace.log", .T.)

QUIT
