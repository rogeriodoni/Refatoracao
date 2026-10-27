SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL

PUBLIC gb_4c_ValidandoUI, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_tmp_instantiate_errors.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cLog, loc_oForm, loc_oErro
loc_cLog = "C:\4c\automation\_tmp_instantiate_check.log"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    loc_oForm = CREATEOBJECT("FormSIGOPCFE")

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE("INSTANTIATE_OK " + loc_oForm.Class + CHR(13) + CHR(10), loc_cLog)
        loc_oForm.Release()
    ELSE
        STRTOFILE("INSTANTIATE_FAIL VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), loc_cLog)
    ENDIF
CATCH TO loc_oErro
    STRTOFILE("EXCEPTION: " + loc_oErro.Message + " | Linha " + TRANSFORM(loc_oErro.LineNo) + " | " + loc_oErro.Procedure + CHR(13) + CHR(10), loc_cLog)
ENDTRY

QUIT
