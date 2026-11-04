SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcForm, lcFxp, lcSaida

lcForm = "C:\4c\projeto\app\forms\operacionais\Formsigopcks.prg"
lcFxp  = "C:\4c\projeto\app\forms\operacionais\Formsigopcks.fxp"
lcSaida = "C:\4c\automation\vfp_helpers\compile_task702_f5.txt"

IF FILE(lcFxp)
    DELETE FILE (lcFxp)
ENDIF

COMPILE (lcForm)

IF FILE(lcFxp)
    STRTOFILE("OK - FXP gerado em " + TTOC(DATETIME()) + CHR(13) + CHR(10), lcSaida)
ELSE
    STRTOFILE("FALHA - FXP NAO gerado" + CHR(13) + CHR(10), lcSaida)
ENDIF

IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopcks.err")
    STRTOFILE("ERR:" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigopcks.err"), lcSaida, 1)
ELSE
    STRTOFILE("ERR: (nenhum arquivo .err)" + CHR(13) + CHR(10), lcSaida, 1)
ENDIF

QUIT
