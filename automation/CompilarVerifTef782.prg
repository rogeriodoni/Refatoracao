SET SAFETY OFF
SET RESOURCE OFF
COMPILE ("C:\4c\projeto\app\utils\verifteF.prg")
=STRTOFILE("FXP=" + TRANSFORM(FILE("C:\4c\projeto\app\utils\verifteF.fxp")) + " ERR=" + TRANSFORM(FILE("C:\4c\projeto\app\utils\verifteF.err")), "C:\4c\automation\_compila_verifteF.txt")
QUIT
