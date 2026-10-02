SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
#DEFINE OUT "C:\4c\automation\medir_autosize_chk.txt"
LOCAL loF, lnI, lcOut
LOCAL ARRAY laCap[16]
laCap[1]="Consigna"
laCap[2]="Fabr. " + CHR(80) + CHR(114) + CHR(243) + "pria"
laCap[3]="N" + CHR(227) + "o Comprar"
laCap[4]="Sem Consultas"
laCap[5]="Mostruario"
laCap[6]="Exc. Encomenda"
laCap[7]="Disp. Encomenda"
laCap[8]="Off"
laCap[9]="Ativo"
laCap[10]="Brinco Espelh" + CHR(225) + "vel"
laCap[11]="Produto Novo"
laCap[12]="Masculino"
laCap[13]="Feminino"
laCap[14]="Unissex"
laCap[15]="Baby"
laCap[16]="Kids"
lcOut = ""
loF = CREATEOBJECT("Form")
FOR lnI = 1 TO ALEN(laCap)
    loF.AddObject("c" + TRANSFORM(lnI), "CheckBox")
    WITH EVALUATE("loF.c" + TRANSFORM(lnI))
        .FontName = "Tahoma"
        .FontSize = 8
        .AutoSize = .T.
        .Caption  = laCap[lnI]
    ENDWITH
    lcOut = lcOut + PADR(laCap[lnI], 20) + " AutoSize=.T. W=" + ;
        TRANSFORM(EVALUATE("loF.c" + TRANSFORM(lnI) + ".Width")) + " H=" + ;
        TRANSFORM(EVALUATE("loF.c" + TRANSFORM(lnI) + ".Height")) + CHR(13)+CHR(10)
NEXT
*-- mesma coisa com FontSize 9 bold (os do segmento)
loF.AddObject("b1", "CheckBox")
WITH loF.b1
    .FontName = "Tahoma"
    .FontSize = 9
    .FontBold = .T.
    .AutoSize = .T.
    .Caption  = "Masculino"
ENDWITH
lcOut = lcOut + "Masculino (9 bold)  AutoSize=.T. W=" + TRANSFORM(loF.b1.Width) + ;
    " H=" + TRANSFORM(loF.b1.Height) + CHR(13)+CHR(10)
*-- default sem AutoSize, para comparar
loF.AddObject("d1", "CheckBox")
loF.d1.Caption = "Consigna"
lcOut = lcOut + "Consigna (default)  AutoSize=.F. W=" + TRANSFORM(loF.d1.Width) + ;
    " H=" + TRANSFORM(loF.d1.Height) + CHR(13)+CHR(10)
STRTOFILE(lcOut, OUT)
QUIT
