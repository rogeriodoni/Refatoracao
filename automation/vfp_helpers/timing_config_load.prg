*-- Mede quanto tempo config.prg + ConfigurarAmbiente() levam.
*-- Diagnostico do TIMEOUT de 120s na ETAPA 1 do TestFormWrapper.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

LOCAL loc_tIni, loc_nSeg, loc_cSaida, loc_oErro
loc_cSaida = "C:\4c\tasks\task577\timing_config.txt"
loc_tIni = DATETIME()

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()
    loc_nSeg = DATETIME() - loc_tIni
    STRTOFILE("OK|" + ALLTRIM(STR(loc_nSeg)) + " seg", loc_cSaida)
CATCH TO loc_oErro
    loc_nSeg = DATETIME() - loc_tIni
    STRTOFILE("ERRO|" + ALLTRIM(STR(loc_nSeg)) + " seg|" + loc_oErro.Message, loc_cSaida)
ENDTRY

QUIT
