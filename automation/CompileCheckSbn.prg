SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_lOk
loc_lOk = .T.
TRY
    COMPILE "C:\4c\projeto\app\classes\SigMvSbnBO.prg"
CATCH TO loc_oErro
    ? "ERRO BO: " + loc_oErro.Message + " Linha:" + TRANSFORM(loc_oErro.LineNo)
    loc_lOk = .F.
ENDTRY
TRY
    COMPILE "C:\4c\projeto\app\forms\operacionais\FormSigMvSbn.prg"
CATCH TO loc_oErro2
    ? "ERRO FORM: " + loc_oErro2.Message + " Linha:" + TRANSFORM(loc_oErro2.LineNo)
    loc_lOk = .F.
ENDTRY
IF loc_lOk
    ? "COMPILE_OK"
ELSE
    ? "COMPILE_FAIL"
ENDIF
STRTOFILE(IIF(loc_lOk,"OK","FAIL"), "C:\4c\automation\compile_check_result.txt")
QUIT
