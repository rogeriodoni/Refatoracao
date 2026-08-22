SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cTxt, loc_cDir, loc_cEsq
loc_cTxt = 'C:\4c\tasks\task484\SIGCDPAT_form_codigo_fonte.txt'
loc_cDir = 'C:\4c\tasks\task484'
loc_cEsq = 'C:\4c\tasks\task484\esqueletos'
DO 'C:\4c\projeto\app\utils\GeradorEsqueletos.prg' WITH loc_cTxt, loc_cDir, loc_cEsq
QUIT

