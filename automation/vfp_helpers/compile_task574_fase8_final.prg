*==============================================================================
* compile_task574_fase8_final.prg - Compila BO + Form da task574 juntos e
* reporta erros. Apaga o .fxp ANTES (COMPILE pode nao reescrever um .fxp
* existente - CLAUDE.md regra #29). Execucao UNATTENDED.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, lcTxt, lcCRLF, lnI
LOCAL ARRAY laPrg[2]
lcCRLF = CHR(13) + CHR(10)
laPrg[1] = "C:\4c\projeto\app\classes\SIGMVMVTBO.prg"
laPrg[2] = "C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.prg"

lcSaida = "C:\4c\automation\vfp_helpers\compile_task574_fase8_final_resultado.txt"
lcTxt   = "=== COMPILACAO task574 (BO + Form) ===" + lcCRLF

FOR lnI = 1 TO ALEN(laPrg)
    LOCAL lcPrg, lcFxp, lcErr
    lcPrg = laPrg[lnI]
    lcFxp = STRTRAN(UPPER(lcPrg), ".PRG", ".FXP")
    lcErr = STRTRAN(UPPER(lcPrg), ".PRG", ".ERR")

    IF FILE(lcFxp)
        DELETE FILE (lcFxp)
    ENDIF
    IF FILE(lcErr)
        DELETE FILE (lcErr)
    ENDIF

    COMPILE (lcPrg)

    lcTxt = lcTxt + lcCRLF + "--- " + JUSTFNAME(lcPrg) + " ---" + lcCRLF
    lcTxt = lcTxt + "  FXP gerado: " + IIF(FILE(lcFxp), "SIM", "NAO") + lcCRLF
    IF FILE(lcErr)
        lcTxt = lcTxt + "  ERROS:" + lcCRLF + FILETOSTR(lcErr) + lcCRLF
    ELSE
        lcTxt = lcTxt + "  SEM .err (compilacao limpa)" + lcCRLF
    ENDIF
ENDFOR

STRTOFILE(lcTxt, lcSaida)
QUIT
