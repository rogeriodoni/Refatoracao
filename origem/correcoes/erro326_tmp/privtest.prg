SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
LOCAL lcOut, loT, loE
lcOut = "C:\4c\refatoracao\origem\correcoes\erro326_tmp\privtest.txt"
STRTOFILE("", lcOut)
TRY
    CREATE CURSOR crPriv (campo C(10))
    INSERT INTO crPriv VALUES ("AAA")
    INSERT INTO crPriv VALUES ("BBB")
    CREATE REPORT "C:\4c\refatoracao\origem\correcoes\erro326_tmp\rpriv" FROM crPriv
    SELECT 0
    USE "C:\4c\refatoracao\origem\correcoes\erro326_tmp\rpriv.frx" EXCLUSIVE ALIAS frxp
    LOCATE FOR objtype = 8 AND ATC("campo", expr) > 0
    REPLACE expr WITH "campo + '|' + TRANSFORM(pn_4c_Teste) + '|' + IIF(campo <> pc_4c_Teste, 'DIF', 'IGUAL')"
    USE IN frxp
    loT = CREATEOBJECT("TPriv")
    STRTOFILE("metodo Custom: " + loT.Rodar() + CHR(13) + CHR(10), lcOut, .T.)
    STRTOFILE(FILETOSTR("C:\4c\refatoracao\origem\correcoes\erro326_tmp\rpriv.txt"), lcOut, .T.)
CATCH TO loE
    STRTOFILE("ERRO " + loE.Message + CHR(13) + CHR(10), lcOut, .T.)
ENDTRY
QUIT

DEFINE CLASS TPriv AS Custom
    PROCEDURE Rodar()
        LOCAL loE2, lcR
        PRIVATE pn_4c_Teste, pc_4c_Teste
        pn_4c_Teste = 1
        pc_4c_Teste = "BBB"
        lcR = "OK"
        TRY
            SELECT crPriv
            GO TOP
            REPORT FORM "C:\4c\refatoracao\origem\correcoes\erro326_tmp\rpriv" TO FILE "C:\4c\refatoracao\origem\correcoes\erro326_tmp\rpriv.txt" ASCII NOCONSOLE
        CATCH TO loE2
            lcR = "ERRO " + TRANSFORM(loE2.ErrorNo) + " " + loE2.Message
        ENDTRY
        RETURN lcR
    ENDPROC
ENDDEFINE
