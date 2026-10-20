*-- Verificacao de compilacao do menu.prg apos a mudanca do AbrirFormSIGPRTRF.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cMenu, loc_cErr, loc_cSaida

loc_cMenu = "C:\4c\projeto\app\menu\menu.prg"

IF FILE("C:\4c\projeto\app\menu\menu.FXP")
    DELETE FILE "C:\4c\projeto\app\menu\menu.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\menu\menu.err")
    DELETE FILE "C:\4c\projeto\app\menu\menu.err"
ENDIF

COMPILE (loc_cMenu)

loc_cErr = ""
IF FILE("C:\4c\projeto\app\menu\menu.err")
    loc_cErr = FILETOSTR("C:\4c\projeto\app\menu\menu.err")
ENDIF

loc_cSaida = "FXP_MENU=" + IIF(FILE("C:\4c\projeto\app\menu\menu.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_MENU=[" + ALLTRIM(loc_cErr) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErr)) AND FILE("C:\4c\projeto\app\menu\menu.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_menu_trf684.txt")
QUIT
