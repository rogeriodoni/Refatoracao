SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcRes
lcRes = "M1 inicio" + CHR(13) + CHR(10)
STRTOFILE(lcRes, "C:\4c\tasks\task772\compilar_form_fase4_resultado.txt")

lcRes = lcRes + "M2 antes do COMPILE" + CHR(13) + CHR(10)
STRTOFILE(lcRes, "C:\4c\tasks\task772\compilar_form_fase4_resultado.txt")

COMPILE C:\4c\projeto\app\forms\operacionais\FormSIGOPNOP.prg

lcRes = lcRes + "M3 COMPILE voltou" + CHR(13) + CHR(10)
lcRes = lcRes + "FXP=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSIGOPNOP.fxp"), "SIM", "NAO") + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGOPNOP.err")
    lcRes = lcRes + "ERR_CONTEUDO:" + CHR(13) + CHR(10) + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGOPNOP.err")
ELSE
    lcRes = lcRes + "ERR=ausente (compilacao limpa)" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(lcRes, "C:\4c\tasks\task772\compilar_form_fase4_resultado.txt")
QUIT
