SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
ERASE "C:\4c\automation\_tmp\compila_f8.err"
COMPILE "C:\4c\projeto\app\classes\SIGPRIFFBO.prg"
COMPILE "C:\4c\projeto\app\forms\operacionais\FormSIGPRIFF.prg"
LOCAL loc_c
loc_c = ""
IF FILE("C:\4c\projeto\app\classes\SIGPRIFFBO.err")
    loc_c = loc_c + "SIGPRIFFBO.err: " + FILETOSTR("C:\4c\projeto\app\classes\SIGPRIFFBO.err") + CHR(13) + CHR(10)
ELSE
    loc_c = loc_c + "SIGPRIFFBO.err: (nenhum)" + CHR(13) + CHR(10)
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRIFF.err")
    loc_c = loc_c + "FormSIGPRIFF.err: " + FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSIGPRIFF.err") + CHR(13) + CHR(10)
ELSE
    loc_c = loc_c + "FormSIGPRIFF.err: (nenhum)" + CHR(13) + CHR(10)
ENDIF
loc_c = loc_c + "FXP BO:   " + IIF(FILE("C:\4c\projeto\app\classes\SIGPRIFFBO.fxp"), "gerado", "AUSENTE") + CHR(13) + CHR(10)
loc_c = loc_c + "FXP Form: " + IIF(FILE("C:\4c\projeto\app\forms\operacionais\FormSIGPRIFF.fxp"), "gerado", "AUSENTE") + CHR(13) + CHR(10)
STRTOFILE(loc_c, "C:\4c\automation\_tmp\compila_f8.txt")
QUIT
