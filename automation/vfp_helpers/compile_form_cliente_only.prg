SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

LOCAL lcArq, lcErr

lcArq = 'C:\4c\projeto\app\forms\operacionais\FormCliente.prg'
lcErr = FORCEEXT(lcArq, 'err')

IF FILE(lcErr)
    DELETE FILE (lcErr)
ENDIF
IF FILE(FORCEEXT(lcArq, 'fxp'))
    DELETE FILE (FORCEEXT(lcArq, 'fxp'))
ENDIF

? "Compilando FormCliente.prg..."
COMPILE (lcArq)
IF FILE(lcErr)
    ? "ERRO: " + FILETOSTR(lcErr)
ELSE
    ? "OK - sem erros"
ENDIF

QUIT
