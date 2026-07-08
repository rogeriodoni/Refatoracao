SET SAFETY OFF
SET RESOURCE OFF
ON ERROR DO errhandler WITH ERROR(), MESSAGE(), LINENO()

PROCEDURE errhandler(par_nErr, par_cMsg, par_nLine)
    STRTOFILE("ERROR " + TRANSFORM(par_nErr) + ": " + par_cMsg + " (line " + TRANSFORM(par_nLine) + ")" + CHR(13)+CHR(10), "C:\4c\sigreetl_err.txt", .T.)
    QUIT
ENDPROC

STRTOFILE("", "C:\4c\sigreetl_err.txt")

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\relatoriobase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE

STRTOFILE("Compilando SigReEtlBO.prg..." + CHR(13)+CHR(10), "C:\4c\sigreetl_err.txt", .T.)
COMPILE C:\4c\projeto\app\classes\SigReEtlBO.prg
STRTOFILE("SigReEtlBO OK" + CHR(13)+CHR(10), "C:\4c\sigreetl_err.txt", .T.)

STRTOFILE("Compilando FormSigReEtl.prg..." + CHR(13)+CHR(10), "C:\4c\sigreetl_err.txt", .T.)
COMPILE C:\4c\projeto\app\forms\relatorios\FormSigReEtl.prg
STRTOFILE("FormSigReEtl OK" + CHR(13)+CHR(10), "C:\4c\sigreetl_err.txt", .T.)

STRTOFILE("DONE" + CHR(13)+CHR(10), "C:\4c\sigreetl_err.txt", .T.)
QUIT
