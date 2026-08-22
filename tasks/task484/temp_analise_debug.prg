SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cArq, loc_cLog
loc_cArq = 'C:\4c\tasks\task484\SIGCDPAT_form_codigo_fonte.txt'
loc_cLog = ''
IF FILE(loc_cArq)
    loc_cLog = loc_cLog + "FILE OK: " + loc_cArq + CHR(13)+CHR(10)
ELSE
    loc_cLog = loc_cLog + "FILE NOT FOUND: " + loc_cArq + CHR(13)+CHR(10)
ENDIF
STRTOFILE(loc_cLog, 'C:\4c\tasks\task484\debug_analise.txt')
DO 'C:\4c\projeto\app\utils\AnalisadorTarefa.prg' WITH loc_cArq
STRTOFILE(loc_cLog + "DONE", 'C:\4c\tasks\task484\debug_analise.txt')
QUIT
