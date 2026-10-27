*==============================================================================
* CompilarF7SigOpChi698.prg - Compila o Form/BO do SigOpChi (Fase 7, task698) e
* grava o resultado em arquivo. Script auxiliar de pipeline: SET SAFETY OFF +
* SET RESOURCE OFF obrigatorios (regra #6 - execucao unattended).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cSaida, loc_cForm, loc_cBO, loc_cLog

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpChi.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpChiBO.prg"
loc_cLog  = "C:\4c\automation\compilar_f7_sigopchi.txt"

loc_cSaida = "=== COMPILACAO Fase 7 - task698 ===" + CHR(13) + CHR(10)

*-- Apaga os .FXP antes (o VFP pode NAO reescrever um .fxp existente)
IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".err"))
ENDIF
IF FILE(STRTRAN(loc_cBO, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".err"))
ENDIF

COMPILE (loc_cBO)
loc_cSaida = loc_cSaida + "BO   .fxp gerado: " + ;
    TRANSFORM(FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))) + CHR(13) + CHR(10)

COMPILE (loc_cForm)
loc_cSaida = loc_cSaida + "Form .fxp gerado: " + ;
    TRANSFORM(FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))) + CHR(13) + CHR(10)

*-- ERRORS: o COMPILE grava os erros num .ERR ao lado do .prg
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    loc_cSaida = loc_cSaida + "--- ERROS DO FORM ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(STRTRAN(loc_cForm, ".prg", ".err")) + CHR(13) + CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "Form: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF

IF FILE(STRTRAN(loc_cBO, ".prg", ".err"))
    loc_cSaida = loc_cSaida + "--- ERROS DO BO ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(STRTRAN(loc_cBO, ".prg", ".err")) + CHR(13) + CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "BO: NENHUM arquivo .ERR gerado" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cSaida, loc_cLog)

QUIT
