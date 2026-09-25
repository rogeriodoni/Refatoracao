SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

loc_cArquivo = "C:\4c\projeto\app\forms\operacionais\Formsigmvitn.prg"
loc_cFxp     = "C:\4c\projeto\app\forms\operacionais\formsigmvitn.fxp"
loc_cErr     = "C:\4c\projeto\app\forms\operacionais\formsigmvitn.err"
loc_cSaida   = "C:\4c\automation\vfp_helpers\compile_task571_fase7_result.txt"
loc_cTexto   = ""

IF FILE(loc_cFxp)
    ERASE (loc_cFxp)
ENDIF
IF FILE(loc_cErr)
    ERASE (loc_cErr)
ENDIF

IF FILE(loc_cArquivo)
    COMPILE (loc_cArquivo)

    IF FILE(loc_cErr)
        loc_cTexto = "ERROS DE COMPILACAO:" + CHR(13) + CHR(10) + FILETOSTR(loc_cErr)
    ELSE
        IF FILE(loc_cFxp)
            loc_cTexto = "OK - compilou sem erro - FXP em " + TTOC(DATETIME())
        ELSE
            loc_cTexto = "FALHOU - fxp nao gerado e sem .err"
        ENDIF
    ENDIF
ELSE
    loc_cTexto = "ARQUIVO NAO ENCONTRADO: " + loc_cArquivo
ENDIF

STRTOFILE(loc_cTexto, loc_cSaida)
QUIT
