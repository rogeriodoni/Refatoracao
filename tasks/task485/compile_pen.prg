SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL loc_cBase, loc_cLog, loc_cOutput
loc_cBase = "C:\4c\projeto\app\"
loc_cLog = "C:\4c\tasks\task485\logs\compile.log"
loc_cOutput = ""

TRY
    COMPILE (loc_cBase + "classes\PENBO.prg")
    loc_cOutput = loc_cOutput + "PENBO.prg: OK" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOutput = loc_cOutput + "PENBO.prg ERROR: " + loc_oErro.Message + " Ln:" + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10)
ENDTRY

TRY
    COMPILE (loc_cBase + "forms\cadastros\FormPEN.prg")
    loc_cOutput = loc_cOutput + "FormPEN.prg: OK" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOutput = loc_cOutput + "FormPEN.prg ERROR: " + loc_oErro.Message + " Ln:" + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOutput, loc_cLog)
QUIT
