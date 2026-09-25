SET SAFETY OFF
SET RESOURCE OFF
CLEAR ALL
lcLog = "C:\4c\tasks\task570\_f7_medir_inlist.log"
IF FILE(lcLog)
    DELETE FILE (lcLog)
ENDIF
STRTOFILE("INICIO" + CHR(13) + CHR(10), lcLog)

STRTOFILE("1) arg AUSENTE ........: " + TestaInlist() + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("2) arg = 'C' ..........: " + TestaInlist("C") + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("3) arg = .F. ..........: " + TestaInlist(.F.) + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("4) arg = objeto .......: " + TestaInlist(CREATEOBJECT("Custom")) + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("5) PADR(ausente, 20) ..: " + TestaPadr() + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("6) PADR(objeto, 20) ...: " + TestaPadr(CREATEOBJECT("Custom")) + CHR(13) + CHR(10), lcLog, 1)
STRTOFILE("FIM" + CHR(13) + CHR(10), lcLog, 1)
QUIT

FUNCTION TestaInlist(par_cTipos)
    LOCAL lcRes
    TRY
        lcRes = "VARTYPE=" + VARTYPE(par_cTipos) + " INLIST=" + TRANSFORM(INLIST(par_cTipos, "C", "A"))
    CATCH TO loE
        lcRes = "VARTYPE=" + VARTYPE(par_cTipos) + " *** ERRO: " + loE.Message
    ENDTRY
    RETURN lcRes
ENDFUNC

FUNCTION TestaPadr(par_c)
    LOCAL lcRes
    TRY
        lcRes = "ok=[" + PADR(par_c, 20) + "]"
    CATCH TO loE
        lcRes = "*** ERRO: " + loE.Message
    ENDTRY
    RETURN lcRes
ENDFUNC
