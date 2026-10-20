SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cArq, loc_cFxp, loc_nH

loc_cArq = "C:\4c\projeto\app\classes\SIGPRVTXBO.prg"
loc_cFxp = "C:\4c\projeto\app\classes\SIGPRVTXBO.fxp"
IF FILE(loc_cFxp)
    DELETE FILE (loc_cFxp)
ENDIF
COMPILE (loc_cArq)

loc_cArq = "C:\4c\projeto\app\forms\operacionais\FormSIGPRVTX.prg"
loc_cFxp = "C:\4c\projeto\app\forms\operacionais\FormSIGPRVTX.fxp"
IF FILE(loc_cFxp)
    DELETE FILE (loc_cFxp)
ENDIF
COMPILE (loc_cArq)

loc_nH = FCREATE("C:\4c\automation\_checkfase4sigprvtx_result.txt")
IF FILE("C:\4c\projeto\app\classes\SIGPRVTXBO.fxp")
    FPUTS(loc_nH, "SIGPRVTXBO.prg: OK")
ELSE
    FPUTS(loc_nH, "SIGPRVTXBO.prg: FALHOU")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRVTX.fxp")
    FPUTS(loc_nH, "FormSIGPRVTX.prg: OK")
ELSE
    FPUTS(loc_nH, "FormSIGPRVTX.prg: FALHOU")
ENDIF
FCLOSE(loc_nH)

QUIT
