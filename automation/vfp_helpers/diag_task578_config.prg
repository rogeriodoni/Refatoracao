SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cLog
loc_cLog = ""

TRY
    CD C:\4c\projeto\app\start
    loc_cLog = loc_cLog + "CD OK" + CHR(13)
    STRTOFILE(loc_cLog, "C:\4c\automation\vfp_helpers\diag_task578_config.log")

    DO config.prg
    loc_cLog = loc_cLog + "config.prg OK" + CHR(13)
    STRTOFILE(loc_cLog, "C:\4c\automation\vfp_helpers\diag_task578_config.log")

    ConfigurarAmbiente()
    loc_cLog = loc_cLog + "ConfigurarAmbiente OK" + CHR(13)
    STRTOFILE(loc_cLog, "C:\4c\automation\vfp_helpers\diag_task578_config.log")

CATCH TO loc_oErro
    loc_cLog = loc_cLog + "ERRO: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13)
    STRTOFILE(loc_cLog, "C:\4c\automation\vfp_helpers\diag_task578_config.log")
ENDTRY

QUIT
