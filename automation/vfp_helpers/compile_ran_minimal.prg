SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

LOCAL loc_cOut, loc_lOk
loc_cOut = "C:\4c\automation\vfp_helpers\compile_ran_result.txt"
loc_lOk = .T.

TRY
    COMPILE "C:\4c\projeto\app\classes\RANBO.prg"
    IF FILE("C:\4c\projeto\app\classes\RANBO.err")
        loc_lOk = .F.
        STRTOFILE("BO FALHOU:" + FILETOSTR("C:\4c\projeto\app\classes\RANBO.err"), loc_cOut)
    ELSE
        STRTOFILE("BO OK", loc_cOut)
    ENDIF
CATCH TO loE
    loc_lOk = .F.
    STRTOFILE("BO EXCECAO:" + loE.Message + " L:" + TRANSFORM(loE.LineNo), loc_cOut)
ENDTRY

TRY
    COMPILE "C:\4c\projeto\app\forms\cadastros\FormRAN.prg"
    IF FILE("C:\4c\projeto\app\forms\cadastros\FormRAN.err")
        loc_lOk = .F.
        STRTOFILE("FORM FALHOU:" + FILETOSTR("C:\4c\projeto\app\forms\cadastros\FormRAN.err"), loc_cOut, .T.)
    ELSE
        STRTOFILE("FORM OK", loc_cOut, .T.)
    ENDIF
CATCH TO loE
    loc_lOk = .F.
    STRTOFILE("FORM EXCECAO:" + loE.Message + " L:" + TRANSFORM(loE.LineNo), loc_cOut, .T.)
ENDTRY

QUIT
