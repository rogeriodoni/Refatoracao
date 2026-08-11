SET SAFETY OFF
SET RESOURCE OFF
COMPILE C:\4c\projeto\app\classes\DrsBO.prg
IF FILE('C:\4c\projeto\app\classes\DrsBO.err')
    ? "BO COMPILE ERROR:"
    ? FILETOSTR('C:\4c\projeto\app\classes\DrsBO.err')
ELSE
    ? "BO: OK"
ENDIF
COMPILE C:\4c\projeto\app\forms\cadastros\FormDrs.prg
IF FILE('C:\4c\projeto\app\forms\cadastros\FormDrs.err')
    ? "FORM COMPILE ERROR:"
    ? FILETOSTR('C:\4c\projeto\app\forms\cadastros\FormDrs.err')
ELSE
    ? "FORM: OK"
ENDIF
QUIT