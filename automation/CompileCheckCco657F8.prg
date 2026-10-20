*-- Verificacao de compilacao de FormSIGOPCCO + SIGOPCCOBO (task657, Fase 8).
*-- SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cForm, loc_cBO, loc_cErrForm, loc_cErrBO, loc_cSaida

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPCCO.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SIGOPCCOBO.prg"

*-- COMPILE pode NAO reescrever um .fxp existente: apagar antes (CLAUDE.md #29).
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigopcco.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigopcco.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGOPCCO.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSIGOPCCO.err"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigopccobo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigopccobo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SIGOPCCOBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SIGOPCCOBO.err"
ENDIF

COMPILE (loc_cForm)
COMPILE (loc_cBO)

loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGOPCCO.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGOPCCO.err")
ENDIF

loc_cErrBO = ""
IF FILE("C:\4c\projeto\app\classes\SIGOPCCOBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SIGOPCCOBO.err")
ENDIF

loc_cSaida = "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigopcco.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10) + ;
             "FXP_BO=" + IIF(FILE("C:\4c\projeto\app\classes\sigopccobo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=[" + ALLTRIM(loc_cErrBO) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrForm)) AND EMPTY(ALLTRIM(loc_cErrBO)) ;
   AND FILE("C:\4c\projeto\app\forms\operacionais\formsigopcco.FXP") ;
   AND FILE("C:\4c\projeto\app\classes\sigopccobo.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FALHOU"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\resultado_cco657_f8.txt")
QUIT
