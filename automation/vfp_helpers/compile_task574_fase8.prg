SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

loc_cSaida = "C:\4c\automation\vfp_helpers\compile_task574_fase8_result.txt"
loc_cTexto = ""

DIMENSION loc_aArquivos[2]
loc_aArquivos[1] = "C:\4c\projeto\app\classes\SIGMVMVTBO.prg"
loc_aArquivos[2] = "C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.prg"

FOR loc_nI = 1 TO ALEN(loc_aArquivos)
    loc_cArquivo = loc_aArquivos[loc_nI]
    loc_cFxp     = STRTRAN(LOWER(loc_cArquivo), ".prg", ".fxp")
    loc_cErr     = STRTRAN(LOWER(loc_cArquivo), ".prg", ".err")

    IF FILE(loc_cFxp)
        ERASE (loc_cFxp)
    ENDIF
    IF FILE(loc_cErr)
        ERASE (loc_cErr)
    ENDIF

    loc_cTexto = loc_cTexto + "=== " + loc_cArquivo + " ===" + CHR(13) + CHR(10)

    IF FILE(loc_cArquivo)
        COMPILE (loc_cArquivo)

        IF FILE(loc_cErr)
            loc_cTexto = loc_cTexto + "ERROS DE COMPILACAO:" + CHR(13) + CHR(10) + FILETOSTR(loc_cErr)
        ELSE
            IF FILE(loc_cFxp)
                loc_cTexto = loc_cTexto + "OK - compilou sem erro - FXP em " + TTOC(DATETIME())
            ELSE
                loc_cTexto = loc_cTexto + "FALHOU - fxp nao gerado e sem .err"
            ENDIF
        ENDIF
    ELSE
        loc_cTexto = loc_cTexto + "ARQUIVO NAO ENCONTRADO: " + loc_cArquivo
    ENDIF

    loc_cTexto = loc_cTexto + CHR(13) + CHR(10) + CHR(13) + CHR(10)
ENDFOR

STRTOFILE(loc_cTexto, loc_cSaida)
QUIT
