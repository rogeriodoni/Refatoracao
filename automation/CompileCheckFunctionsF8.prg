SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cRes, loc_cErros
loc_cRes = ""

IF FILE("C:\4c\projeto\app\utils\functions.fxp")
    DELETE FILE "C:\4c\projeto\app\utils\functions.fxp"
ENDIF

COMPILE C:\4c\projeto\app\utils\functions.prg

loc_cRes = "FXP functions = " + TRANSFORM(FILE("C:\4c\projeto\app\utils\functions.fxp")) + CHR(13) + CHR(10)

IF FILE("C:\4c\projeto\app\utils\functions.err")
    loc_cErros = FILETOSTR("C:\4c\projeto\app\utils\functions.err")
    loc_cRes = loc_cRes + "ERROS: " + IIF(EMPTY(loc_cErros), "(vazio)", loc_cErros) + CHR(13) + CHR(10)
ELSE
    loc_cRes = loc_cRes + "ERROS: nenhum arquivo .err gerado" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\compile_functions_f8_result.txt")
QUIT
