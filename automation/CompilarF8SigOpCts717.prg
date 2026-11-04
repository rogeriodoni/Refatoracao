*==============================================================================
* CompilarF8SigOpCts717.prg - Compila o Form/BO do SigOpCts (Fase 8, task717) e
* grava o resultado em arquivo. Script auxiliar de pipeline: SET SAFETY OFF +
* SET RESOURCE OFF obrigatorios (regra #6 - execucao unattended).
*
* Inclui CONTROLE NEGATIVO: compila um .prg com erro proposital para provar que
* o teste de fato detecta erro (senao "nenhum .ERR" fica indistinguivel de
* compilador que nao rodou).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cSaida, loc_cForm, loc_cBO, loc_cLog, loc_cNeg

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigOpCts.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigOpCtsBO.prg"
loc_cNeg  = "C:\4c\tmp\NegativoF8Cts717.prg"
loc_cLog  = "C:\4c\automation\compilar_f8_sigopcts717.txt"

loc_cSaida = "=== COMPILACAO Fase 8 - task717 ===" + CHR(13) + CHR(10)

*-- Apaga os .FXP e .ERR antes (o VFP pode NAO reescrever um .fxp existente)
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

*-- CONTROLE NEGATIVO
STRTOFILE("DEFINE CLASS Xpto AS Custom" + CHR(13) + CHR(10) + ;
          "    PUBLIC PROCEDURE Quebra()" + CHR(13) + CHR(10) + ;
          "    ENDPROC" + CHR(13) + CHR(10) + ;
          "ENDDEFINE" + CHR(13) + CHR(10), loc_cNeg)
IF FILE(STRTRAN(loc_cNeg, ".prg", ".err"))
    DELETE FILE (STRTRAN(loc_cNeg, ".prg", ".err"))
ENDIF
COMPILE (loc_cNeg)
loc_cSaida = loc_cSaida + "--- CONTROLE NEGATIVO (deve ter erro) ---" + CHR(13) + CHR(10)
IF FILE(STRTRAN(loc_cNeg, ".prg", ".err"))
    loc_cSaida = loc_cSaida + "detectou erro: SIM" + CHR(13) + CHR(10) + ;
        FILETOSTR(STRTRAN(loc_cNeg, ".prg", ".err")) + CHR(13) + CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "detectou erro: NAO -> HARNESS NAO MEDE NADA" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cSaida, loc_cLog)

QUIT
