SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
IF FILE("C:\4c\projeto\app\classes\sigopclgbo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigopclgbo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigopclgBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\sigopclgBO.err"
ENDIF
COMPILE ("C:\4c\projeto\app\classes\sigopclgBO.prg")
LOCAL loc_c
loc_c = ""
IF FILE("C:\4c\projeto\app\classes\sigopclgBO.err")
    loc_c = FILETOSTR("C:\4c\projeto\app\classes\sigopclgBO.err")
ENDIF
STRTOFILE("ERR=[" + ALLTRIM(loc_c) + "]" + CHR(13)+CHR(10) + IIF(FILE("C:\4c\projeto\app\classes\sigopclgbo.FXP") AND EMPTY(loc_c), "COMPILE_OK", "COMPILE_FAIL"), "C:\4c\automation\compile_check_sigopclgbo_f3.txt")
QUIT
