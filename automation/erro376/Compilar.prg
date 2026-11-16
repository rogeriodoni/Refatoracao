SET SAFETY OFF
SET RESOURCE OFF
LOCAL c
c = ""
TRY
    COMPILE "C:\4c\refatoracao\automation\erro376\menu_sim.prg"
    c = IIF(FILE("C:\4c\refatoracao\automation\erro376\menu_sim.err"), FILETOSTR("C:\4c\refatoracao\automation\erro376\menu_sim.err"), "OK sem erros; fxp=" + TRANSFORM(FILE("C:\4c\refatoracao\automation\erro376\menu_sim.fxp")))
CATCH TO loE
    c = "ERRO: " + loE.Message
ENDTRY
STRTOFILE(c, "C:\4c\refatoracao\automation\erro376\compile_out.txt")
QUIT
