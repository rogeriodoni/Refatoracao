*-- compile_check_f4.prg - compila FormSigPrFem.prg e grava o resultado
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cPrg, loc_cErr, loc_cOut

loc_cPrg = "C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg"
loc_cErr = "C:\4c\tasks\task610\compile_f4.err"
loc_cOut = "C:\4c\tasks\task610\compile_f4.txt"

IF FILE(loc_cErr)
    ERASE (loc_cErr)
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrFem.fxp")
    ERASE ("C:\4c\projeto\app\forms\operacionais\FormSigPrFem.fxp")
ENDIF

COMPILE (loc_cPrg)

LOCAL loc_cRes
loc_cRes = ""

IF FILE(loc_cErr)
    loc_cRes = loc_cRes + "ERROS DE COMPILACAO:" + CHR(13) + CHR(10)
    loc_cRes = loc_cRes + FILETOSTR(loc_cErr)
ELSE
    loc_cRes = loc_cRes + "COMPILACAO SEM ERROS" + CHR(13) + CHR(10)
ENDIF

IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrFem.fxp")
    loc_cRes = loc_cRes + "FXP GERADO" + CHR(13) + CHR(10)
ELSE
    loc_cRes = loc_cRes + "FXP NAO GERADO" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRes, loc_cOut)

QUIT
