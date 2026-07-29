SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL lcArq1, lcArq2, lcErr1, lcErr2

lcArq1 = 'C:\4c\projeto\app\classes\ClienteBO.prg'
lcArq2 = 'C:\4c\projeto\app\forms\operacionais\FormCliente.prg'
lcErr1 = FORCEEXT(lcArq1, 'err')
lcErr2 = FORCEEXT(lcArq2, 'err')

IF FILE(lcErr1)
    DELETE FILE (lcErr1)
ENDIF
IF FILE(lcErr2)
    DELETE FILE (lcErr2)
ENDIF

? "Compilando ClienteBO.prg..."
COMPILE (lcArq1)
IF FILE(lcErr1)
    ? "ERRO: " + FILETOSTR(lcErr1)
ELSE
    ? "OK"
ENDIF

? "Compilando FormCliente.prg..."
COMPILE (lcArq2)
IF FILE(lcErr2)
    ? "ERRO: " + FILETOSTR(lcErr2)
ELSE
    ? "OK"
ENDIF

? "Concluido."
QUIT
