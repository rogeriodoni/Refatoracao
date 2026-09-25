SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
loc_cArquivo = "C:\4c\projeto\app\forms\operacionais\FormSIGMVCTH.prg"
IF FILE(loc_cArquivo)
    COMPILE (loc_cArquivo)
    IF FILE("C:\4c\projeto\app\forms\operacionais\formsigmvcth.fxp")
        STRTOFILE("OK - compilou sem erro", "C:\4c\automation\vfp_helpers\compile_task566_fase6_result.txt")
    ELSE
        STRTOFILE("FALHOU - fxp nao gerado", "C:\4c\automation\vfp_helpers\compile_task566_fase6_result.txt")
    ENDIF
ELSE
    STRTOFILE("ARQUIVO NAO ENCONTRADO", "C:\4c\automation\vfp_helpers\compile_task566_fase6_result.txt")
ENDIF
QUIT
