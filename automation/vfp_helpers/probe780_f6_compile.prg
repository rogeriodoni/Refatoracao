SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcSaida, lcArq, lcPrg, lcErr
lcSaida = ""
lcArq   = "C:\4c\automation\vfp_helpers\probe780_f6_out.txt"
lcPrg   = "C:\4c\projeto\app\forms\operacionais\Formsigoppei.prg"
lcErr   = "C:\4c\projeto\app\forms\operacionais\Formsigoppei.err"

lcSaida = lcSaida + "INICIO " + TRANSFORM(DATETIME()) + CHR(13) + CHR(10)

*-- Controle NEGATIVO: um .prg com erro de sintaxe TEM de gerar .err.
*-- Sem isso, ".err ausente" nao prova compilacao limpa.
STRTOFILE("DEFINE CLASS xx AS Form" + CHR(13) + CHR(10) + ;
          "    PUBLIC FUNCTION y()" + CHR(13) + CHR(10) + ;
          "    ENDFUNC" + CHR(13) + CHR(10) + ;
          "ENDDEFINE" + CHR(13) + CHR(10), ;
          "C:\4c\automation\vfp_helpers\probe780_ctrl_neg.prg")
ERASE "C:\4c\automation\vfp_helpers\probe780_ctrl_neg.err"
COMPILE "C:\4c\automation\vfp_helpers\probe780_ctrl_neg.prg"
lcSaida = lcSaida + "CONTROLE_NEGATIVO .err existe = " + ;
    TRANSFORM(FILE("C:\4c\automation\vfp_helpers\probe780_ctrl_neg.err")) + CHR(13) + CHR(10)

ERASE (lcErr)
COMPILE (lcPrg)
lcSaida = lcSaida + "FORM .err existe = " + TRANSFORM(FILE(lcErr)) + CHR(13) + CHR(10)
IF FILE(lcErr)
    lcSaida = lcSaida + FILETOSTR(lcErr) + CHR(13) + CHR(10)
ENDIF
lcSaida = lcSaida + "FORM .fxp existe = " + ;
    TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\Formsigoppei.fxp")) + CHR(13) + CHR(10)

*-- BO tambem, para garantir que nada foi quebrado por tabela
ERASE "C:\4c\projeto\app\classes\sigoppeiBO.err"
COMPILE "C:\4c\projeto\app\classes\sigoppeiBO.prg"
lcSaida = lcSaida + "BO .err existe = " + ;
    TRANSFORM(FILE("C:\4c\projeto\app\classes\sigoppeiBO.err")) + CHR(13) + CHR(10)
IF FILE("C:\4c\projeto\app\classes\sigoppeiBO.err")
    lcSaida = lcSaida + FILETOSTR("C:\4c\projeto\app\classes\sigoppeiBO.err") + CHR(13) + CHR(10)
ENDIF

STRTOFILE(lcSaida, lcArq)
QUIT
