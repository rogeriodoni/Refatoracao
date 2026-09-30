SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

LOCAL loc_cFile, loc_cFxp
loc_cFile = "C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg"
loc_cFxp  = "C:\4c\projeto\app\forms\operacionais\Formsigprccp.fxp"

IF FILE(loc_cFxp)
	DELETE FILE (loc_cFxp)
ENDIF

COMPILE (loc_cFile)

IF FILE(loc_cFxp)
	STRTOFILE("OK - compilou sem erro", "C:\4c\automation\compile_fase3_sigprccp_result.txt")
ELSE
	STRTOFILE("FALHOU - ver mensagens do compilador", "C:\4c\automation\compile_fase3_sigprccp_result.txt")
ENDIF

QUIT
