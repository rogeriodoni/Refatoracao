SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL loc_cTxt, loc_cDir
loc_cTxt = 'C:\4c\tasks\task484\SIGCDPAT_form_codigo_fonte.txt'
loc_cDir = 'C:\4c\tasks\task484'
DO 'C:\4c\projeto\app\utils\GeradorMapeamento.prg' WITH loc_cTxt, loc_cDir
QUIT

