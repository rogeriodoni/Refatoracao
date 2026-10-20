SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_aArquivos[2], loc_i, loc_cResultado, loc_lTodosOk
DIMENSION loc_aArquivos[2]
loc_aArquivos[1] = "C:\4c\projeto\app\classes\SIGPRNSEBO.prg"
loc_aArquivos[2] = "C:\4c\projeto\app\forms\operacionais\FormSIGPRNSE.prg"

loc_cResultado = ""
loc_lTodosOk = .T.

FOR loc_i = 1 TO ALEN(loc_aArquivos, 1)
    LOCAL loc_cFxp
    loc_cFxp = STRTRAN(UPPER(loc_aArquivos[loc_i]), ".PRG", ".FXP")
    IF FILE(loc_cFxp)
        DELETE FILE (loc_cFxp)
    ENDIF

    COMPILE (loc_aArquivos[loc_i])

    IF FILE(loc_cFxp)
        loc_cResultado = loc_cResultado + loc_aArquivos[loc_i] + " => OK" + CHR(13)
    ELSE
        loc_cResultado = loc_cResultado + loc_aArquivos[loc_i] + " => FALHOU" + CHR(13)
        loc_lTodosOk = .F.
    ENDIF
ENDFOR

STRTOFILE(loc_cResultado, "C:\4c\automation\compile_check_sigprnse_result.txt")
QUIT
