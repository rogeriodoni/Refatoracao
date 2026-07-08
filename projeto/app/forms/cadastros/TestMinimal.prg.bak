*-- Teste MINIMO para verificar se VFP headless funciona

LOCAL loc_nHandle
loc_nHandle = FCREATE("C:\temp\test_minimal.txt")

IF loc_nHandle > 0
	FPUTS(loc_nHandle, "VFP headless funcionando!")
	FPUTS(loc_nHandle, "Data/Hora: " + TTOC(DATETIME()))
	FCLOSE(loc_nHandle)
ENDIF

QUIT
