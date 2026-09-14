* Test wrapper for FormNfl
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormNfl', 'C:\4c\tasks\task475', 'CRUD'
QUIT
