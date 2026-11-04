SET SAFETY OFF
SET RESOURCE OFF
LOCAL loF, loS, i
loS = ""

*-- SIMULACAO DO LOAD DO LEGADO: recria os filhos diretos de SIGOPECM na ordem
*-- dos REGISTROS do SCX, aplicando o TabIndex declarado LOGO APOS cada
*-- AddObject (eh assim que o VFP aplica o valor gravado no .scx).
loF = CREATEOBJECT("Form")
loF.Width = 800
loF.Height = 220

loF.AddObject("cntSombra", "Container")          && SCX: sem TabIndex
loF.AddObject("Shape1", "Shape")                 && Shape: nao tem TabIndex
loF.AddObject("Cancela", "CommandButton")
loF.Cancela.TabIndex = 6
loF.AddObject("Processa", "CommandButton")
loF.Processa.TabIndex = 5
loF.AddObject("Say1", "Label")
loF.Say1.TabIndex = 1
loF.AddObject("getArqTXT", "TextBox")
loF.getArqTXT.TabIndex = 2
loF.AddObject("btnGetArqO", "CommandButton")
loF.btnGetArqO.TabIndex = 3
loF.AddObject("chkImagens", "CheckBox")
loF.chkImagens.TabIndex = 4
loF.AddObject("Shape2", "Shape")
loF.AddObject("lblResults", "Label")
loF.lblResults.TabIndex = 1

loS = loS + "=== LEGADO SIMULADO (ordem dos registros do SCX) ===" + CHR(13) + CHR(10)
FOR i = 1 TO loF.ControlCount
    IF PEMSTATUS(loF.Controls(i), "TabIndex", 5)
        loS = loS + PADR(loF.Controls(i).Name, 14) + " TabIndex=" + ;
              TRANSFORM(loF.Controls(i).TabIndex) + ;
              "  TabStop=" + IIF(PEMSTATUS(loF.Controls(i), "TabStop", 5), ;
                 TRANSFORM(loF.Controls(i).TabStop), "<nao tem>") + CHR(13) + CHR(10)
    ELSE
        loS = loS + PADR(loF.Controls(i).Name, 14) + " <sem TabIndex>" + CHR(13) + CHR(10)
    ENDIF
ENDFOR

STRTOFILE(loS, "C:\4c\automation\medir_tabindex_727_out.txt")
QUIT
