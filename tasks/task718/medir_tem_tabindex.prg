SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_oF, loc_cR, loc_nI, loc_oE
LOCAL ARRAY loc_aC[10]
loc_aC[1]="Container"
loc_aC[2]="Shape"
loc_aC[3]="Label"
loc_aC[4]="TextBox"
loc_aC[5]="EditBox"
loc_aC[6]="CommandButton"
loc_aC[7]="Image"
loc_aC[8]="Line"
loc_aC[9]="Separator"
loc_aC[10]="OptionGroup"
loc_cR = ""
loc_oF = CREATEOBJECT("Form")
FOR loc_nI = 1 TO ALEN(loc_aC)
    TRY
        loc_oF.AddObject("o" + TRANSFORM(loc_nI), loc_aC[loc_nI])
        loc_cR = loc_cR + PADR(loc_aC[loc_nI], 16) + ;
            " PEMSTATUS=" + TRANSFORM(PEMSTATUS(EVALUATE("loc_oF.o" + TRANSFORM(loc_nI)), "TabIndex", 5))
        TRY
            STORE 1 TO ("loc_oF.o" + TRANSFORM(loc_nI) + ".TabIndex")
            loc_cR = loc_cR + "   STORE=OK"
        CATCH
            loc_cR = loc_cR + "   STORE=ERRO"
        ENDTRY
        loc_cR = loc_cR + CHR(13)
    CATCH TO loc_oE
        loc_cR = loc_cR + PADR(loc_aC[loc_nI], 16) + " AddObject falhou: " + loc_oE.Message + CHR(13)
    ENDTRY
ENDFOR
loc_oF.Release()
STRTOFILE(loc_cR, "C:\4c\tasks\task718\medir_tem_tabindex.out")
QUIT
