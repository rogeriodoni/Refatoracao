*-- Verificacao de compilacao da task695 (SIGOPCGV), Fase 8.
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cBO, loc_cMenu, loc_cSaida

loc_cForm = "C:\4c\projeto\app\forms\operacionais\Formsigopcgv.prg"
loc_cBO   = "C:\4c\projeto\app\classes\sigopcgvBO.prg"
loc_cMenu = "C:\4c\projeto\app\menu\menu.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigopcgv.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigopcgv.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopcgv.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\Formsigopcgv.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigopcgvbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigopcgvbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigopcgvBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigopcgvBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\menu\menu.FXP")
    DELETE FILE "C:\4c\projeto\app\menu\menu.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\menu\menu.err")
    DELETE FILE "C:\4c\projeto\app\menu\menu.err"
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)
COMPILE (loc_cMenu)

loc_cSaida = "FORM FXP : " + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigopcgv.FXP"), "OK", "AUSENTE") + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "BO   FXP : " + IIF(FILE("C:\4c\projeto\app\classes\sigopcgvbo.FXP"), "OK", "AUSENTE") + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "MENU FXP : " + IIF(FILE("C:\4c\projeto\app\menu\menu.FXP"), "OK", "AUSENTE") + CHR(13) + CHR(10)

IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigopcgv.err")
    loc_cSaida = loc_cSaida + "=== ERROS FORM ===" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigopcgv.err") + CHR(13) + CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "FORM: sem .err" + CHR(13) + CHR(10)
ENDIF

IF FILE("C:\4c\projeto\app\classes\sigopcgvBO.err")
    loc_cSaida = loc_cSaida + "=== ERROS BO ===" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\classes\sigopcgvBO.err") + CHR(13) + CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "BO: sem .err" + CHR(13) + CHR(10)
ENDIF

IF FILE("C:\4c\projeto\app\menu\menu.err")
    loc_cSaida = loc_cSaida + "=== ERROS MENU ===" + CHR(13) + CHR(10) + ;
        FILETOSTR("C:\4c\projeto\app\menu\menu.err") + CHR(13) + CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "MENU: sem .err" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\CompileCheckCgv695F8.out")

QUIT
