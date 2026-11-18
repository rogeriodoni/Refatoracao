* CompilarF8SigOpStc807.prg
* Fase 8 / task807 - compila FormSIGOPSTC.prg e SIGOPSTCBO.prg e grava a
* PROVA num arquivo de saida (.fxp nao prova execucao e exit=0 nao prova
* nada - ver licao "vfp9 compila e sai sem executar nesta sessao").
* Inclui CONTROLE NEGATIVO: uma copia do form com "PUBLIC PROCEDURE"
* (regra #9.1) colada no fim DEVE gerar .ERR - se nao gerar, o detector
* esta cego e o resultado limpo dos outros dois nao vale nada.
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO, loc_cNeg, loc_cOut, loc_cRel

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPSTC.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SIGOPSTCBO.prg"
loc_cNeg  = "C:\4c\automation\_f8stc_negativo.prg"
loc_cOut  = "C:\4c\automation\_f8stc_compile.txt"

loc_cRel = "CHECKPOINT - script vivo " + TTOC(DATETIME()) + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

*-- Controle negativo: form + erro de sintaxe conhecido no fim
STRTOFILE(FILETOSTR(loc_cForm) + CHR(13) + CHR(10) + ;
          "DEFINE CLASS XNegativoF8Stc AS Custom" + CHR(13) + CHR(10) + ;
          "    PUBLIC PROCEDURE QuebraDeProposito()" + CHR(13) + CHR(10) + ;
          "    ENDPROC" + CHR(13) + CHR(10) + ;
          "ENDDEFINE" + CHR(13) + CHR(10), loc_cNeg)

LOCAL ARRAY loc_aArq[3]
loc_aArq[1] = loc_cForm
loc_aArq[2] = loc_cBO
loc_aArq[3] = loc_cNeg

LOCAL loc_nI, loc_cFxp, loc_cErr
FOR loc_nI = 1 TO 3
    loc_cFxp = STRTRAN(UPPER(loc_aArq[loc_nI]), ".PRG", ".FXP")
    loc_cErr = STRTRAN(UPPER(loc_aArq[loc_nI]), ".PRG", ".ERR")

    IF FILE(loc_cFxp)
        ERASE (loc_cFxp)
    ENDIF
    IF FILE(loc_cErr)
        ERASE (loc_cErr)
    ENDIF

    COMPILE (loc_aArq[loc_nI])

    loc_cRel = loc_cRel + JUSTFNAME(loc_aArq[loc_nI]) + ;
               "  FXP=" + IIF(FILE(loc_cFxp), "SIM", "NAO") + ;
               "  ERR=" + IIF(FILE(loc_cErr), "SIM", "NAO") + CHR(13) + CHR(10)

    IF FILE(loc_cErr)
        loc_cRel = loc_cRel + "---- " + JUSTFNAME(loc_cErr) + " ----" + CHR(13) + CHR(10) + ;
                   FILETOSTR(loc_cErr) + CHR(13) + CHR(10)
    ENDIF

    STRTOFILE(loc_cRel, loc_cOut)
ENDFOR

loc_cRel = loc_cRel + "FIM" + CHR(13) + CHR(10)
STRTOFILE(loc_cRel, loc_cOut)

QUIT
