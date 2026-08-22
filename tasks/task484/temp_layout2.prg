SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cScx, loc_cDir
loc_cScx = 'C:\4c\tasks\task484\SIGCDPAT.SCX'
loc_cDir = 'C:\4c\tasks\task484'
? 'Antes do ExtratorLayout'
DO 'C:\4c\projeto\app\utils\ExtratorLayout.prg' WITH loc_cScx, loc_cDir
STRTOFILE('ExtratorLayout DONE', 'C:\4c\tasks\task484\debug_layout.txt')
QUIT

