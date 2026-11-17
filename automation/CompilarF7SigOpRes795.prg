* CompilarF7SigOpRes795.prg
* Fase 7 - prova de compilacao do FormSIGOPRES.prg (e do BO), sem executar.
* Inclui CONTROLE NEGATIVO: um .prg com erro proposital tem de gerar .ERR,
* senao ".ERR ausente" nao distingue "compilou limpo" de "COMPILE nao rodou".
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cForm, loc_cBO, loc_cNeg, loc_cLog

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSIGOPRES.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SIGOPRESBO.prg"
loc_cNeg  = "C:\4c\automation\tmp795\NegControlF7.prg"
loc_cLog  = "C:\4c\automation\tmp795\resultado_f7.txt"

*-- Controle negativo: sintaxe invalida de proposito (IF ... THEN DO inline)
STRTOFILE("PROCEDURE Teste" + CHR(13) + CHR(10) + ;
          "IF .T. THEN DO algo" + CHR(13) + CHR(10) + ;
          "ENDPROC" + CHR(13) + CHR(10), loc_cNeg)

LOCAL ARRAY loc_aAlvos[3]
loc_aAlvos[1] = loc_cForm
loc_aAlvos[2] = loc_cBO
loc_aAlvos[3] = loc_cNeg

LOCAL loc_nI, loc_cAlvo, loc_cFxp, loc_cErr, loc_cTexto
loc_cTexto = ""

FOR loc_nI = 1 TO 3
    loc_cAlvo = loc_aAlvos[loc_nI]
    loc_cFxp  = STRTRAN(UPPER(loc_cAlvo), ".PRG", ".FXP")
    loc_cErr  = STRTRAN(UPPER(loc_cAlvo), ".PRG", ".ERR")

    IF FILE(loc_cFxp)
        DELETE FILE (loc_cFxp)
    ENDIF
    IF FILE(loc_cErr)
        DELETE FILE (loc_cErr)
    ENDIF

    COMPILE (loc_cAlvo)

    loc_cTexto = loc_cTexto + JUSTFNAME(loc_cAlvo) + ;
                 "  FXP=" + IIF(FILE(loc_cFxp), "T", "F") + ;
                 "  ERR=" + IIF(FILE(loc_cErr), "T", "F") + CHR(13) + CHR(10)

    IF FILE(loc_cErr)
        loc_cTexto = loc_cTexto + "  >> " + ;
                     STRTRAN(FILETOSTR(loc_cErr), CHR(13) + CHR(10), " | ") + ;
                     CHR(13) + CHR(10)
    ENDIF
ENDFOR

STRTOFILE(loc_cTexto, loc_cLog)

QUIT
