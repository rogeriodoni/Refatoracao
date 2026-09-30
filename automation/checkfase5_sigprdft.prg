SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_c
loc_c = ""
ON ERROR loc_c = loc_c + "ERRO: " + MESSAGE() + CHR(13) + CHR(10)
COMPILE C:\4c\projeto\app\classes\sigprdftBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg
loc_c = loc_c + "fxp BO   : " + IIF(FILE("C:\4c\projeto\app\classes\sigprdftBO.fxp"), "OK", "AUSENTE") + CHR(13)+CHR(10)
loc_c = loc_c + "fxp FORM : " + IIF(FILE("C:\4c\projeto\app\forms\operacionais\Formsigprdft.fxp"), "OK", "AUSENTE") + CHR(13)+CHR(10)
loc_c = loc_c + "err BO   : " + IIF(FILE("C:\4c\projeto\app\classes\sigprdftBO.err"), "EXISTE", "nenhum") + CHR(13)+CHR(10)
loc_c = loc_c + "err FORM : " + IIF(FILE("C:\4c\projeto\app\forms\operacionais\Formsigprdft.err"), "EXISTE", "nenhum") + CHR(13)+CHR(10)
IF FILE("C:\4c\projeto\app\forms\operacionais\Formsigprdft.err")
    loc_c = loc_c + FILETOSTR("C:\4c\projeto\app\forms\operacionais\Formsigprdft.err") + CHR(13)+CHR(10)
ENDIF
STRTOFILE(loc_c, "C:\4c\automation\checkfase5_sigprdft.txt")
QUIT
