SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

LOCAL loc_cFile, loc_cFxp
loc_cFile = "C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.prg"
loc_cFxp  = "C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.fxp"

IF FILE(loc_cFxp)
	DELETE FILE (loc_cFxp)
ENDIF

COMPILE (loc_cFile)

IF FILE(loc_cFxp)
	STRTOFILE("OK - compilou sem erro", "C:\4c\automation\compile_fase3_sigprimp_result.txt")
ELSE
	STRTOFILE("FALHOU - ver mensagens do compilador", "C:\4c\automation\compile_fase3_sigprimp_result.txt")
ENDIF

QUIT
