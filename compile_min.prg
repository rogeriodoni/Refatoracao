SET SAFETY OFF
SET RESOURCE OFF
STRTOFILE("STEP0", "C:\4c\compile_min_result.txt")
COMPILE C:\4c\projeto\app\classes\sigrebalBO.prg
STRTOFILE("STEP1_BO_OK", "C:\4c\compile_min_result.txt")
COMPILE C:\4c\projeto\app\forms\relatorios\Formsigrebal.prg
STRTOFILE("STEP2_FORM_OK", "C:\4c\compile_min_result.txt")
STRTOFILE("ALL_OK", "C:\4c\compile_min_result.txt")
QUIT
