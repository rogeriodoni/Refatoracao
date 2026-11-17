SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cSaida, loF, loG
loc_cSaida = ""

*-- A) Simula o LOAD do SCX legado: filhos na ordem dos REGISTROS,
*--    aplicando o TabIndex literal logo apos cada AddObject.
loF = CREATEOBJECT("Form")
loF.Width = 456
loF.Height = 133
loF.AddObject("cntSombra", "Container")
loF.AddObject("Label1", "Label")
loF.AddObject("Text1", "TextBox")
loF.AddObject("OK", "CommandGroup")
loF.OK.ButtonCount = 1
loF.OK.TabIndex = 1                       && literal do SCX
loF.OK.Buttons(1).TabIndex = 4            && literal do SCX (btnSair)

loc_cSaida = loc_cSaida + "[A] LOAD LEGADO" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  cntSombra=" + TRANSFORM(loF.cntSombra.TabIndex) + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  Label1   =" + TRANSFORM(loF.Label1.TabIndex) + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  Text1    =" + TRANSFORM(loF.Text1.TabIndex) + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  OK       =" + TRANSFORM(loF.OK.TabIndex) + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  btnSair  =" + TRANSFORM(loF.OK.Buttons(1).TabIndex) + CHR(13) + CHR(10)

*-- B) Ordem de criacao do MIGRADO, com o passe ascendente proposto
loG = CREATEOBJECT("Form")
loG.Width = 456
loG.Height = 133
loG.AddObject("cnt_4c_Sombra", "Container")
loG.AddObject("lbl_4c_Label1", "Label")
loG.AddObject("txt_4c_Text1", "TextBox")
loG.AddObject("cmg_4c_Saida", "CommandGroup")
loG.cmg_4c_Saida.ButtonCount = 1

loc_cSaida = loc_cSaida + "[B] MIGRADO ANTES DO PASSE" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  cnt=" + TRANSFORM(loG.cnt_4c_Sombra.TabIndex) + ;
    "  lbl=" + TRANSFORM(loG.lbl_4c_Label1.TabIndex) + ;
    "  txt=" + TRANSFORM(loG.txt_4c_Text1.TabIndex) + ;
    "  cmg=" + TRANSFORM(loG.cmg_4c_Saida.TabIndex) + CHR(13) + CHR(10)

loG.cmg_4c_Saida.TabIndex = 1
loG.txt_4c_Text1.TabIndex = 2

loc_cSaida = loc_cSaida + "[C] MIGRADO DEPOIS DO PASSE" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  cnt=" + TRANSFORM(loG.cnt_4c_Sombra.TabIndex) + ;
    "  lbl=" + TRANSFORM(loG.lbl_4c_Label1.TabIndex) + ;
    "  txt=" + TRANSFORM(loG.txt_4c_Text1.TabIndex) + ;
    "  cmg=" + TRANSFORM(loG.cmg_4c_Saida.TabIndex) + CHR(13) + CHR(10)

*-- D) CommandGroup com AutoSize: a geometria do botao interno define o grupo?
loG.cmg_4c_Saida.AutoSize = .T.
loG.cmg_4c_Saida.Left = 374
loG.cmg_4c_Saida.Top = -2
loG.cmg_4c_Saida.Width = 85
loG.cmg_4c_Saida.Height = 85
WITH loG.cmg_4c_Saida.Buttons(1)
    .Top = 5
    .Left = 5
    .Height = 75
    .Width = 75
    .Caption = "Retornar"
ENDWITH
loc_cSaida = loc_cSaida + "[D] AUTOSIZE GRUPO  W=" + TRANSFORM(loG.cmg_4c_Saida.Width) + ;
    " H=" + TRANSFORM(loG.cmg_4c_Saida.Height) + CHR(13) + CHR(10)

STRTOFILE(loc_cSaida, "C:\4c\automation\probe_tabindex_t792.txt")
QUIT
