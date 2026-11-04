*==============================================================================
* CompilarF8SigOpDpe724.prg - prova de compilacao da Fase 8 (task724)
*
* Apaga os .fxp ANTES de compilar: COMPILE pode NAO reescrever um .fxp
* existente, e sem apagar o teste rodaria sobre codigo velho.
*
* SET SAFETY OFF / SET RESOURCE OFF porque o pipeline roda sem supervisao -
* dialogo modal travaria a execucao indefinidamente.
*
* Uso: vfp9.exe -t "C:\4c\automation\CompilarF8SigOpDpe724.prg"
*      saida em automation\CompilarF8SigOpDpe724.log
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET CONSOLE OFF

LOCAL loc_cLog, loc_cBO, loc_cForm
loc_cLog  = "C:\4c\automation\CompilarF8SigOpDpe724.log"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpDpeBO.prg"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpDpe.prg"

STRTOFILE("INICIO " + TRANSFORM(DATETIME()) + CHR(13) + CHR(10), loc_cLog)

IF FILE(STRTRAN(loc_cBO, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cBO, ".prg", ".fxp"))
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))
    DELETE FILE (STRTRAN(loc_cForm, ".prg", ".fxp"))
ENDIF

COMPILE (loc_cBO)
STRTOFILE("BO_FXP=" + IIF(FILE(STRTRAN(loc_cBO, ".prg", ".fxp")), "SIM", "NAO") + ;
          " ERROS=" + TRANSFORM(_TALLY) + CHR(13) + CHR(10), loc_cLog, 1)

COMPILE (loc_cForm)
STRTOFILE("FORM_FXP=" + IIF(FILE(STRTRAN(loc_cForm, ".prg", ".fxp")), "SIM", "NAO") + ;
          " ERROS=" + TRANSFORM(_TALLY) + CHR(13) + CHR(10), loc_cLog, 1)

STRTOFILE("FIM" + CHR(13) + CHR(10), loc_cLog, 1)
QUIT
