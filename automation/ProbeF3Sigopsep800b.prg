SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_CaminhoFramework, gc_4c_CaminhoIcones, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .T.
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_erro_f3_sigopsep800b.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cSaida, loc_oForm, loc_oErro
loc_cSaida = "START" + CHR(13) + CHR(10)
STRTOFILE(loc_cSaida, "C:\4c\automation\probe_f3_sigopsep800b.txt")

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\sigopsepBO.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\Formsigopsep.prg" ADDITIVE

    loc_cSaida = loc_cSaida + "PROCS_LOADED" + CHR(13) + CHR(10)
    STRTOFILE(loc_cSaida, "C:\4c\automation\probe_f3_sigopsep800b.txt")

    loc_oForm = CREATEOBJECT("Formsigopsep")

    loc_cSaida = loc_cSaida + "CREATEOBJECT_RETORNOU=[" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)
    STRTOFILE(loc_cSaida, "C:\4c\automation\probe_f3_sigopsep800b.txt")

    IF VARTYPE(loc_oForm) = "O"
        loc_cSaida = loc_cSaida + "BaseClass=[" + loc_oForm.BaseClass + "]" + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "ERRO: " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cSaida, "C:\4c\automation\probe_f3_sigopsep800b.txt")

QUIT
