SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

LOCAL loc_lErro
loc_lErro = .F.

? "=== Compilando sigopindBO.prg ==="
TRY
  COMPILE 'C:\4c\projeto\app\classes\sigopindBO.prg'
  ? "sigopindBO.prg: OK"
CATCH TO loc_oErro
  ? "sigopindBO.prg: ERRO - " + loc_oErro.Message
  loc_lErro = .T.
ENDTRY

? "=== Compilando Formsigopind.prg ==="
TRY
  COMPILE 'C:\4c\projeto\app\forms\operacionais\Formsigopind.prg'
  ? "Formsigopind.prg: OK"
CATCH TO loc_oErro
  ? "Formsigopind.prg: ERRO - " + loc_oErro.Message
  loc_lErro = .T.
ENDTRY

IF loc_lErro
  ? "RESULTADO: ERRO"
ELSE
  ? "RESULTADO: SUCESSO"
ENDIF

QUIT
