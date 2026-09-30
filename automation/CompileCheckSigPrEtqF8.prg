*-- Compilacao dos dois artefatos da task609 (Fase 8), sem supervisao.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cLog, loc_cForm, loc_cBO

loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg"
loc_cBO   = "C:\4c\projeto\app\classes\SigPrEtqBO.prg"
loc_cLog  = "C:\4c\automation\compile_sigpretq_f8.txt"

STRTOFILE("=== COMPILE CHECK SigPrEtq (Fase 8) ===" + CHR(13) + CHR(10), loc_cLog)

COMPILE (loc_cBO)
COMPILE (loc_cForm)

STRTOFILE("BO  .fxp existe : " + TRANSFORM(FILE(STRTRAN(loc_cBO, ".prg", ".fxp")))   + CHR(13) + CHR(10), loc_cLog, 1)
STRTOFILE("BO  .err existe : " + TRANSFORM(FILE(STRTRAN(loc_cBO, ".prg", ".err")))   + CHR(13) + CHR(10), loc_cLog, 1)
STRTOFILE("FRM .fxp existe : " + TRANSFORM(FILE(STRTRAN(loc_cForm, ".prg", ".fxp"))) + CHR(13) + CHR(10), loc_cLog, 1)
STRTOFILE("FRM .err existe : " + TRANSFORM(FILE(STRTRAN(loc_cForm, ".prg", ".err"))) + CHR(13) + CHR(10), loc_cLog, 1)

IF FILE(STRTRAN(loc_cBO, ".prg", ".err"))
    STRTOFILE("--- ERR BO ---" + CHR(13) + CHR(10) + FILETOSTR(STRTRAN(loc_cBO, ".prg", ".err")), loc_cLog, 1)
ENDIF
IF FILE(STRTRAN(loc_cForm, ".prg", ".err"))
    STRTOFILE("--- ERR FORM ---" + CHR(13) + CHR(10) + FILETOSTR(STRTRAN(loc_cForm, ".prg", ".err")), loc_cLog, 1)
ENDIF

QUIT
