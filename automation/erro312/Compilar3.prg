*==============================================================================
* Compilar3.prg - Erro312
* Compila os 3 forms reaplicados + 1 CONTROLE NEGATIVO (copia com erro de
* sintaxe proposital). Sem o controle negativo, ".ERR ausente" nao prova nada:
* seria indistinguivel de "o VFP nem tentou".
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cDir, loc_cOut, loc_nI, loc_cAlvo, loc_cFxp, loc_cErr
LOCAL ARRAY loc_aF[4]

loc_cDir  = "C:\4c\projeto\app\forms\cadastros\"
loc_aF[1] = loc_cDir + "FormCOM.prg"
loc_aF[2] = loc_cDir + "FormCVE.prg"
loc_aF[3] = loc_cDir + "FormObs.prg"
loc_aF[4] = "C:\4c\automation\erro312\_controle_negativo.prg"

*-- monta o controle negativo: copia do FormObs + linha solta fora de procedure
LOCAL loc_cSrc
loc_cSrc = FILETOSTR(loc_cDir + "FormObs.prg")
loc_cSrc = loc_cSrc + CHR(13) + CHR(10) + "IF .T." + CHR(13) + CHR(10) + ;
           "? " + CHR(34) + "x" + CHR(34) + CHR(13) + CHR(10)
STRTOFILE(loc_cSrc, loc_aF[4])

loc_cOut = "=== Erro312 - compilacao dos 3 reaplicados + controle negativo ===" + ;
           CHR(13) + CHR(10)

FOR loc_nI = 1 TO 4
    loc_cAlvo = loc_aF[loc_nI]
    loc_cFxp  = FORCEEXT(loc_cAlvo, "fxp")
    loc_cErr  = FORCEEXT(loc_cAlvo, "err")
    IF FILE(loc_cFxp)
        ERASE (loc_cFxp)
    ENDIF
    IF FILE(loc_cErr)
        ERASE (loc_cErr)
    ENDIF

    COMPILE (loc_cAlvo)

    loc_cOut = loc_cOut + PADR(JUSTFNAME(loc_cAlvo), 28) + ;
               "FXP=" + IIF(FILE(loc_cFxp), "SIM", "nao") + ;
               "  ERR=" + IIF(FILE(loc_cErr), "SIM", "nao")
    IF FILE(loc_cErr)
        loc_cOut = loc_cOut + "  -> " + ALLTRIM(STRTRAN(FILETOSTR(loc_cErr), CHR(13) + CHR(10), " | "))
    ENDIF
    loc_cOut = loc_cOut + CHR(13) + CHR(10)
ENDFOR

loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
    "Esperado: os 3 primeiros FXP=SIM ERR=nao; o controle negativo ERR=SIM." + ;
    CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\erro312\compila_out.txt")
QUIT
