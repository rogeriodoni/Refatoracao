SET SAFETY OFF
SET RESOURCE OFF

TRY
  COMPILE "C:\4c\projeto\app\classes\prcBO.prg"
  STRTOFILE('prcBO.prg: OK' + CHR(13)+CHR(10), 'C:\4c\tasks\task501\compile_result.txt', .T.)
CATCH TO loErr
  STRTOFILE('prcBO.prg ERROR: ' + loErr.Message + CHR(13)+CHR(10), 'C:\4c\tasks\task501\compile_result.txt', .T.)
ENDTRY

TRY
  COMPILE "C:\4c\projeto\app\forms\cadastros\Formprc.prg"
  STRTOFILE('Formprc.prg: OK' + CHR(13)+CHR(10), 'C:\4c\tasks\task501\compile_result.txt', .T.)
CATCH TO loErr
  STRTOFILE('Formprc.prg ERROR: ' + loErr.Message + CHR(13)+CHR(10), 'C:\4c\tasks\task501\compile_result.txt', .T.)
ENDTRY

QUIT
