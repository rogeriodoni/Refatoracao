SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF

LOCAL loc_lErro
loc_lErro = .F.

? "=== Compilando sigopcgvBO.prg ==="
TRY
  COMPILE 'C:\4c\projeto\app\classes\sigopcgvBO.prg'
  ? "sigopcgvBO.prg: OK"
CATCH TO loc_oErro
  ? "sigopcgvBO.prg: ERRO - " + loc_oErro.Message
  loc_lErro = .T.
ENDTRY

? "=== Compilando Formsigopcgv.prg ==="
TRY
  COMPILE 'C:\4c\projeto\app\forms\operacionais\Formsigopcgv.prg'
  ? "Formsigopcgv.prg: OK"
CATCH TO loc_oErro
  ? "Formsigopcgv.prg: ERRO - " + loc_oErro.Message
  loc_lErro = .T.
ENDTRY

? "=== Compilando menu.prg ==="
TRY
  COMPILE 'C:\4c\projeto\app\menu\menu.prg'
  ? "menu.prg: OK"
CATCH TO loc_oErro
  ? "menu.prg: ERRO - " + loc_oErro.Message
  loc_lErro = .T.
ENDTRY

IF loc_lErro
  ? "RESULTADO: ERRO"
ELSE
  ? "RESULTADO: SUCESSO"
ENDIF

QUIT
