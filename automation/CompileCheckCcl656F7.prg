*-- Verificacao de compilacao da task656 (SigOpCcl), Fase 7.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cBO, loc_cSaida, loc_cErrForm, loc_cErrBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpCcl.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpCclBO.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigopccl.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigopccl.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCcl.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpCcl.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigopcclbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigopcclbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpCclBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpCclBO.err"
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpCcl.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpCcl.err")
ENDIF
loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\SigOpCclBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigOpCclBO.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigopccl.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10) + ;
             "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigopcclbo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrForm)) AND EMPTY(ALLTRIM(loc_cErrBO)) AND ;
        FILE("C:\4c\projeto\app\forms\operacionais\formsigopccl.FXP") AND ;
        FILE("C:\4c\projeto\app\classes\sigopcclbo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_ccl656_f7.txt")
QUIT
