SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loF, lcOut
lcOut = ""

loF = CREATEOBJECT("Form")
loF.Visible = .F.

*-- Ordem dos REGISTROS do SCX, aplicando o TabIndex gravado
*-- IMEDIATAMENTE apos cada AddObject (simula o load do VFP).

*-- rec 4: cntSombra (sem TabIndex)
loF.AddObject("cntSombra", "Container")
*-- rec 5/6: labels do cabecalho (sem TabIndex)
loF.cntSombra.AddObject("lblSombra", "Label")
loF.cntSombra.AddObject("lblTitulo", "Label")

*-- rec 7: CntTXT (sem TabIndex)
loF.AddObject("CntTXT", "Container")
*-- rec 8..13: filhos de CntTXT
loF.CntTXT.AddObject("Say1", "Label")
loF.CntTXT.Say1.TabIndex = 1
loF.CntTXT.AddObject("getArqTXT", "TextBox")
loF.CntTXT.getArqTXT.TabIndex = 2
loF.CntTXT.AddObject("btnGetArqO", "CommandButton")
loF.CntTXT.btnGetArqO.TabIndex = 3
loF.CntTXT.AddObject("chkImagens", "CheckBox")
loF.CntTXT.chkImagens.TabIndex = 4
loF.CntTXT.AddObject("Shape2", "Shape")
loF.CntTXT.AddObject("lblResults", "Label")
loF.CntTXT.lblResults.TabIndex = 1

*-- rec 14..18: Shape1, Cancela, Processa, chkXml, CntXml (sem TabIndex)
loF.AddObject("Shape1", "Shape")
loF.AddObject("Cancela", "CommandButton")
loF.AddObject("Processa", "CommandButton")
loF.AddObject("chkXml", "CheckBox")
loF.AddObject("CntXml", "Container")

*-- rec 19..22: filhos de CntXml
loF.CntXml.AddObject("btnDirs", "CommandButton")
loF.CntXml.btnDirs.TabIndex = 15
loF.CntXml.AddObject("Get_arquivo", "TextBox")
loF.CntXml.Get_arquivo.TabIndex = 1
loF.CntXml.AddObject("getDirs", "TextBox")
loF.CntXml.getDirs.TabIndex = 14
loF.CntXml.AddObject("Say1", "Label")
loF.CntXml.Say1.TabIndex = 13

*-- Le de volta
lcOut = lcOut + "== FORM (filhos diretos) ==" + CHR(13) + CHR(10)
lcOut = lcOut + "cntSombra = " + TRANSFORM(loF.cntSombra.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "CntTXT    = " + TRANSFORM(loF.CntTXT.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "Cancela   = " + TRANSFORM(loF.Cancela.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "Processa  = " + TRANSFORM(loF.Processa.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "chkXml    = " + TRANSFORM(loF.chkXml.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "CntXml    = " + TRANSFORM(loF.CntXml.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "Shape1 temTabIndex = " + TRANSFORM(PEMSTATUS(loF.Shape1, "TabIndex", 5)) + CHR(13) + CHR(10)

lcOut = lcOut + "== CntTXT ==" + CHR(13) + CHR(10)
lcOut = lcOut + "Say1       = " + TRANSFORM(loF.CntTXT.Say1.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "getArqTXT  = " + TRANSFORM(loF.CntTXT.getArqTXT.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "btnGetArqO = " + TRANSFORM(loF.CntTXT.btnGetArqO.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "chkImagens = " + TRANSFORM(loF.CntTXT.chkImagens.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "lblResults = " + TRANSFORM(loF.CntTXT.lblResults.TabIndex) + CHR(13) + CHR(10)

lcOut = lcOut + "== CntXml ==" + CHR(13) + CHR(10)
lcOut = lcOut + "btnDirs     = " + TRANSFORM(loF.CntXml.btnDirs.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "Get_arquivo = " + TRANSFORM(loF.CntXml.Get_arquivo.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "getDirs     = " + TRANSFORM(loF.CntXml.getDirs.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "Say1        = " + TRANSFORM(loF.CntXml.Say1.TabIndex) + CHR(13) + CHR(10)

lcOut = lcOut + "== TabStop existe? ==" + CHR(13) + CHR(10)
lcOut = lcOut + "Label.TabStop     = " + TRANSFORM(PEMSTATUS(loF.CntTXT.Say1, "TabStop", 5)) + CHR(13) + CHR(10)
lcOut = lcOut + "Container.TabStop = " + TRANSFORM(PEMSTATUS(loF.CntTXT, "TabStop", 5)) + CHR(13) + CHR(10)

STRTOFILE(lcOut, "C:\4c\automation\simtab738.txt")
QUIT
