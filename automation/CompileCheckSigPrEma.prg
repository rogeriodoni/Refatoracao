SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut
DELETE FILE "C:\4c\projeto\app\classes\sigpremaBO.fxp"
COMPILE "C:\4c\projeto\app\classes\sigpremaBO.prg"
IF FILE("C:\4c\projeto\app\classes\sigpremaBO.err")
    loc_cOut = "ERROS:" + CHR(13) + FILETOSTR("C:\4c\projeto\app\classes\sigpremaBO.err")
ELSE
    loc_cOut = "COMPILOU SEM ERROS. FXP=" + IIF(FILE("C:\4c\projeto\app\classes\sigpremaBO.fxp"), "gerado", "AUSENTE")
ENDIF
STRTOFILE(loc_cOut, "C:\4c\automation\compile_sigpremabo.txt")
QUIT
