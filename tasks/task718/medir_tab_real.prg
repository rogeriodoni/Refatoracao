SET SAFETY OFF
SET RESOURCE OFF
*-- Replica EXATA da composicao do Formsigopden: 1 Container, 4 Shape,
*-- 3 Label, 12 TextBox, 1 EditBox, 1 CommandButton = 22 controles, com o
*-- botao criado em 3o lugar (como no form real). Shape NAO tem TabIndex,
*-- entao so 18 controles participam da numeracao.
LOCAL loc_oF, loc_cR, loc_nI, loc_nSeq, loc_oE
LOCAL ARRAY loc_aO[18]
loc_cR = ""
TRY
    loc_oF = CREATEOBJECT("Form")
    loc_oF.AddObject("cnt1",  "Container")
    loc_oF.AddObject("shp1",  "Shape")
    loc_oF.AddObject("btnOk", "CommandButton")
    loc_oF.AddObject("shp2",  "Shape")
    loc_oF.AddObject("lblA",  "Label")
    FOR loc_nI = 1 TO 6
        loc_oF.AddObject("txt" + PADL(loc_nI, 2, "0"), "TextBox")
    ENDFOR
    loc_oF.AddObject("shp3",  "Shape")
    loc_oF.AddObject("lblB",  "Label")
    FOR loc_nI = 7 TO 12
        loc_oF.AddObject("txt" + PADL(loc_nI, 2, "0"), "TextBox")
    ENDFOR
    loc_oF.AddObject("shp4",  "Shape")
    loc_oF.AddObject("lblC",  "Label")
    loc_oF.AddObject("edt13", "EditBox")

    loc_cR = loc_cR + "ControlCount=" + TRANSFORM(loc_oF.ControlCount) + CHR(13)
    loc_cR = loc_cR + "ANTES : btnOk=" + TRANSFORM(loc_oF.btnOk.TabIndex) + ;
             " cnt1=" + TRANSFORM(loc_oF.cnt1.TabIndex) + ;
             " txt01=" + TRANSFORM(loc_oF.txt01.TabIndex) + ;
             " edt13=" + TRANSFORM(loc_oF.edt13.TabIndex) + CHR(13)

    loc_aO[1]="cnt1"
    loc_aO[2]="lblA"
    loc_aO[3]="lblB"
    loc_aO[4]="lblC"
    FOR loc_nI = 1 TO 12
        loc_aO[4 + loc_nI] = "txt" + PADL(loc_nI, 2, "0")
    ENDFOR
    loc_aO[17]="edt13"
    loc_aO[18]="btnOk"

    loc_nSeq = 0
    FOR loc_nI = 1 TO ALEN(loc_aO)
        IF PEMSTATUS(EVALUATE("loc_oF." + loc_aO[loc_nI]), "TabIndex", 5)
            loc_nSeq = loc_nSeq + 1
            STORE loc_nSeq TO ("loc_oF." + loc_aO[loc_nI] + ".TabIndex")
        ENDIF
    ENDFOR
    loc_cR = loc_cR + "numerados=" + TRANSFORM(loc_nSeq) + CHR(13)
    loc_cR = loc_cR + "DEPOIS: btnOk=" + TRANSFORM(loc_oF.btnOk.TabIndex) + ;
             " cnt1=" + TRANSFORM(loc_oF.cnt1.TabIndex) + ;
             " lblA=" + TRANSFORM(loc_oF.lblA.TabIndex) + ;
             " txt01=" + TRANSFORM(loc_oF.txt01.TabIndex) + ;
             " txt12=" + TRANSFORM(loc_oF.txt12.TabIndex) + ;
             " edt13=" + TRANSFORM(loc_oF.edt13.TabIndex) + CHR(13)
    loc_cR = loc_cR + "btnOk eh o MAIOR? " + TRANSFORM(loc_oF.btnOk.TabIndex = loc_nSeq) + CHR(13)
    loc_oF.Release()
CATCH TO loc_oE
    loc_cR = loc_cR + "EXCECAO: " + loc_oE.Message + " LN=" + TRANSFORM(loc_oE.LineNo)
ENDTRY
STRTOFILE(loc_cR, "C:\4c\tasks\task718\medir_tab_real.out")
QUIT
