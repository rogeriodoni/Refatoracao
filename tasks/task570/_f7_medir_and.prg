SET SAFETY OFF
SET RESOURCE OFF
CLEAR ALL
lcLog = "C:\4c\tasks\task570\_f7_medir_and.log"
IF FILE(lcLog)
    DELETE FILE (lcLog)
ENDIF
STRTOFILE("INICIO" + CHR(13) + CHR(10), lcLog)

STRTOFILE("A) AND  1-linha, arg AUSENTE : " + TestaAnd()    + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("B) AND  1-linha, arg = 'C'   : " + TestaAnd("C") + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("C) AND  1-linha, arg = 'X'   : " + TestaAnd("X") + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("D) IF aninhado, arg AUSENTE  : " + TestaNest()    + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("E) IF aninhado, arg = 'C'    : " + TestaNest("C") + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("FIM" + CHR(13) + CHR(10), lcLog, 1)
QUIT

FUNCTION TestaAnd(par_cTipos)
    LOCAL lcRes
    TRY
        IF VARTYPE(par_cTipos) = "C" AND INLIST(par_cTipos, "C", "A")
            lcRes = "entrou no IF (.T.)"
        ELSE
            lcRes = "nao entrou (.F.) - SEM erro => AND faz short-circuit"
        ENDIF
    CATCH TO loE
        lcRes = "*** ERRO: " + loE.Message + " => AND NAO faz short-circuit"
    ENDTRY
    RETURN lcRes
ENDFUNC

FUNCTION TestaNest(par_cTipos)
    LOCAL lcRes
    TRY
        lcRes = "nao entrou"
        IF VARTYPE(par_cTipos) = "C"
            IF INLIST(par_cTipos, "C", "A")
                lcRes = "entrou nos dois IF"
            ENDIF
        ENDIF
    CATCH TO loE
        lcRes = "*** ERRO: " + loE.Message
    ENDTRY
    RETURN lcRes
ENDFUNC
