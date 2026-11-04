*==============================================================================
* CompilarF6SigOpDmp722.prg - Compila Form/BO/TextBoxGridLookup do SigOpDmp
* (Fase 6, task722) e grava o resultado em arquivo. Script auxiliar de
* pipeline: SET SAFETY OFF + SET RESOURCE OFF obrigatorios (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cSaida, loc_cLog, loc_nI, loc_cPrg, loc_cFxp, loc_cErr
LOCAL ARRAY loc_aArq[3]

loc_aArq[1] = "C:\4c\projeto\app\classes\SigOpDmpBO.prg"
loc_aArq[2] = "C:\4c\projeto\app\classes\TextBoxGridLookup.prg"
loc_aArq[3] = "C:\4c\projeto\app\forms\cadastros\FormSigOpDmp.prg"

loc_cLog   = "C:\4c\automation\compilar_f6_sigopdmp.txt"
loc_cSaida = "=== COMPILACAO Fase 6 - task722 ===" + CHR(13) + CHR(10)

FOR loc_nI = 1 TO ALEN(loc_aArq)
    loc_cPrg = loc_aArq[loc_nI]
    loc_cFxp = STRTRAN(LOWER(loc_cPrg), ".prg", ".fxp")
    loc_cErr = STRTRAN(LOWER(loc_cPrg), ".prg", ".err")

    *-- Apaga .FXP e .ERR antes: o VFP pode NAO reescrever um .fxp existente
    IF FILE(loc_cFxp)
        DELETE FILE (loc_cFxp)
    ENDIF
    IF FILE(loc_cErr)
        DELETE FILE (loc_cErr)
    ENDIF

    COMPILE (loc_cPrg)

    loc_cSaida = loc_cSaida + JUSTFNAME(loc_cPrg) + " -> .fxp gerado: " + ;
        TRANSFORM(FILE(loc_cFxp)) + CHR(13) + CHR(10)

    IF FILE(loc_cErr)
        loc_cSaida = loc_cSaida + "--- ERROS: " + JUSTFNAME(loc_cPrg) + " ---" + ;
            CHR(13) + CHR(10) + FILETOSTR(loc_cErr) + CHR(13) + CHR(10)
    ELSE
        loc_cSaida = loc_cSaida + "    NENHUM arquivo .ERR gerado" + ;
            CHR(13) + CHR(10)
    ENDIF
ENDFOR

STRTOFILE(loc_cSaida, loc_cLog)

QUIT
