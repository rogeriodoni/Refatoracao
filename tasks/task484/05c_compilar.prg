SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_lOk, loc_cErro
loc_lOk = .T.
loc_cErro = ""

TRY
    COMPILE "C:\4c\projeto\app\forms\cadastros\FormPAT.prg"
    loc_cErro = loc_cErro + "FormPAT: OK" + CHR(13)
CATCH TO loErr
    loc_lOk = .F.
    loc_cErro = loc_cErro + "FormPAT ERRO: " + loErr.Message + " Linha:" + TRANSFORM(loErr.LineNo) + CHR(13)
ENDTRY

TRY
    COMPILE "C:\4c\projeto\app\classes\PATBO.prg"
    loc_cErro = loc_cErro + "PATBO: OK" + CHR(13)
CATCH TO loErr
    loc_lOk = .F.
    loc_cErro = loc_cErro + "PATBO ERRO: " + loErr.Message + " Linha:" + TRANSFORM(loErr.LineNo) + CHR(13)
ENDTRY

STRTOFILE(loc_cErro, "C:\4c\tasks\task484\compilacao_resultado.txt")
QUIT
