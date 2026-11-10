* CompilarF8Sigopgrc743.prg
* Compila FormSIGOPGRC.prg (Fase 8) + SIGOPGRCBO.prg com COMPILE DENTRO do
* script (nao -T), para nao deixar o VFP pendurado no IDE. So prova SINTAXE.
* Compila tambem _negctl743.prg (copia do form + PUBLIC PROCEDURE, que a
* regra #9.1 proibe) como CONTROLE NEGATIVO: sem ele, .ERR ausente eh
* indistinguivel de "o VFP nem tentou".
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO, loc_cNeg, loc_cOut

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPGRC.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SIGOPGRCBO.prg"
loc_cNeg  = "C:\4c\automation\_negctl743.prg"

LOCAL ARRAY loc_aAlvos[3]
loc_aAlvos[1] = loc_cBO
loc_aAlvos[2] = loc_cForm
loc_aAlvos[3] = loc_cNeg

LOCAL loc_nI, loc_cFxp, loc_cErr
FOR loc_nI = 1 TO 3
    loc_cFxp = STRTRAN(loc_aAlvos[loc_nI], ".prg", ".fxp")
    loc_cErr = STRTRAN(loc_aAlvos[loc_nI], ".prg", ".err")
    IF FILE(loc_cFxp)
        DELETE FILE (loc_cFxp)
    ENDIF
    IF FILE(loc_cErr)
        DELETE FILE (loc_cErr)
    ENDIF
ENDFOR

COMPILE (loc_cBO)
COMPILE (loc_cForm)
COMPILE (loc_cNeg)

loc_cOut = ""
FOR loc_nI = 1 TO 3
    loc_cFxp = STRTRAN(loc_aAlvos[loc_nI], ".prg", ".fxp")
    loc_cErr = STRTRAN(loc_aAlvos[loc_nI], ".prg", ".err")
    loc_cOut = loc_cOut + JUSTFNAME(loc_aAlvos[loc_nI]) + ;
        "  FXP=" + IIF(FILE(loc_cFxp), "SIM", "NAO") + ;
        "  ERR=" + IIF(FILE(loc_cErr), "SIM", "NAO") + CHR(13) + CHR(10)
    IF FILE(loc_cErr)
        loc_cOut = loc_cOut + "    " + STRTRAN(FILETOSTR(loc_cErr), CHR(13) + CHR(10), ;
            CHR(13) + CHR(10) + "    ") + CHR(13) + CHR(10)
    ENDIF
ENDFOR

STRTOFILE(loc_cOut, "C:\4c\automation\_resultado_compilaf8_743.txt")
QUIT
