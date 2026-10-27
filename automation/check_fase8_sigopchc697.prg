SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF

LOCAL loc_cForm, loc_cBO, loc_cOut, loc_cErrF, loc_cErrB

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpChc.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpChcBO.prg"
loc_cOut  = ""

*-- Apagar .FXP/.ERR antigos: sem isso o VFP pode rodar/relatar codigo VELHO
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpChc.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpChc.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpChc.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpChc.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpChcBO.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpChcBO.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpChcBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpChcBO.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

*-- COMPILE nao dispara excecao em erro de sintaxe: ele grava no .ERR
loc_cErrB = ""
IF FILE("C:\4c\projeto\app\classes\SigOpChcBO.err")
    loc_cErrB = FILETOSTR("C:\4c\projeto\app\classes\SigOpChcBO.err")
ENDIF
loc_cErrF = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpChc.err")
    loc_cErrF = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpChc.err")
ENDIF

loc_cOut = loc_cOut + "FXP_BO_CRIADO=" + ;
    IIF(FILE("C:\4c\projeto\app\classes\SigOpChcBO.fxp"), "SIM", "NAO") + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "FXP_FORM_CRIADO=" + ;
    IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpChc.fxp"), "SIM", "NAO") + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "ERR_BO=[" + ALLTRIM(loc_cErrB) + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "ERR_FORM=[" + ALLTRIM(loc_cErrF) + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "RESULTADO=" + ;
    IIF(EMPTY(loc_cErrB) AND EMPTY(loc_cErrF), "COMPILE_OK", "COMPILE_FAIL") + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\fase8_sigopchc697_compile.txt")
QUIT
