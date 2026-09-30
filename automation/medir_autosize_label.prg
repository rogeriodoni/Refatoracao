*==============================================================================
* medir_autosize_label.prg - Mede o comportamento REAL de Label.AutoSize em
* Label criado por AddObject, com WordWrap = .T., variando a ORDEM em que
* AutoSize/Caption/Width/Height sao atribuidos.
* Origem: FASE 8 do FormSIGPRALE (task582) - o lbl_4c_Mensagem3 saiu com
* Height = 25 em runtime apesar de .Height = 48 no codigo (dump do SCX = 48).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF

LOCAL lcLog, lcCRLF, loF, lcTxt
lcCRLF = CHR(13) + CHR(10)
lcLog  = "C:\4c\automation\medir_autosize_label.txt"
lcTxt  = "Por Favor. N" + CHR(227) + "o Desligue a impressora Fiscal."

STRTOFILE("=== Label.AutoSize em AddObject (WordWrap = .T., Tahoma 14 bold) ===" + lcCRLF, lcLog, 0)
STRTOFILE("Alvo do dump SCX: Width = 248, Height = 48" + lcCRLF + lcCRLF, lcLog, 1)

loF = CREATEOBJECT("Form")
loF.Width  = 419
loF.Height = 115

*-- CASO 1: ordem do FormSIGPRALE (AutoSize=.T. primeiro, Height por ultimo)
loF.AddObject("l1", "Label")
WITH loF.l1
    .AutoSize = .T.
    .FontBold = .T.
    .FontName = "Tahoma"
    .FontSize = 14
    .WordWrap = .T.
    .Caption  = lcTxt
    .Width    = 248
    .Height   = 48
ENDWITH
STRTOFILE("1) AutoSize=.T. -> Caption -> Width -> Height : W=" + ;
    TRANSFORM(loF.l1.Width) + " H=" + TRANSFORM(loF.l1.Height) + lcCRLF, lcLog, 1)

*-- CASO 2: Height DEPOIS de tudo, inclusive ForeColor/Visible
loF.AddObject("l2", "Label")
WITH loF.l2
    .AutoSize  = .T.
    .FontBold  = .T.
    .FontName  = "Tahoma"
    .FontSize  = 14
    .WordWrap  = .T.
    .Caption   = lcTxt
    .Width     = 248
    .ForeColor = RGB(255,0,0)
    .Visible   = .T.
    .Height    = 48
ENDWITH
STRTOFILE("2) ... ForeColor/Visible -> Height (ultimo)   : W=" + ;
    TRANSFORM(loF.l2.Width) + " H=" + TRANSFORM(loF.l2.Height) + lcCRLF, lcLog, 1)

*-- CASO 3: AutoSize = .F. (default do Label) com Width/Height do dump
loF.AddObject("l3", "Label")
WITH loF.l3
    .AutoSize = .F.
    .FontBold = .T.
    .FontName = "Tahoma"
    .FontSize = 14
    .WordWrap = .T.
    .Caption  = lcTxt
    .Width    = 248
    .Height   = 48
ENDWITH
STRTOFILE("3) AutoSize=.F. -> Caption -> Width -> Height : W=" + ;
    TRANSFORM(loF.l3.Width) + " H=" + TRANSFORM(loF.l3.Height) + lcCRLF, lcLog, 1)

*-- CASO 4: AutoSize ligado DEPOIS de Width/Height
loF.AddObject("l4", "Label")
WITH loF.l4
    .FontBold = .T.
    .FontName = "Tahoma"
    .FontSize = 14
    .WordWrap = .T.
    .Caption  = lcTxt
    .Width    = 248
    .Height   = 48
    .AutoSize = .T.
ENDWITH
STRTOFILE("4) Width -> Height -> AutoSize=.T. (ultimo)   : W=" + ;
    TRANSFORM(loF.l4.Width) + " H=" + TRANSFORM(loF.l4.Height) + lcCRLF, lcLog, 1)

*-- CASO 5: AutoSize=.T. + WordWrap=.F. (para isolar o efeito do WordWrap)
loF.AddObject("l5", "Label")
WITH loF.l5
    .AutoSize = .T.
    .FontBold = .T.
    .FontName = "Tahoma"
    .FontSize = 14
    .WordWrap = .F.
    .Caption  = lcTxt
    .Width    = 248
    .Height   = 48
ENDWITH
STRTOFILE("5) AutoSize=.T. + WordWrap=.F.                : W=" + ;
    TRANSFORM(loF.l5.Width) + " H=" + TRANSFORM(loF.l5.Height) + lcCRLF, lcLog, 1)

*-- CASO 6: trocar a Caption DEPOIS (o que o Init legado faz com _msg3),
*--         com AutoSize=.F. e geometria do dump
loF.AddObject("l6", "Label")
WITH loF.l6
    .AutoSize = .F.
    .FontBold = .T.
    .FontName = "Tahoma"
    .FontSize = 14
    .WordWrap = .T.
    .Caption  = lcTxt
    .Width    = 248
    .Height   = 48
ENDWITH
loF.l6.Caption = "Mensagem muito mais longa vinda do chamador em tempo de execucao para ver se a geometria muda"
STRTOFILE("6) AutoSize=.F., Caption trocada em runtime    : W=" + ;
    TRANSFORM(loF.l6.Width) + " H=" + TRANSFORM(loF.l6.Height) + lcCRLF, lcLog, 1)

*-- CASO 7: mesma troca de Caption com AutoSize=.T.
loF.AddObject("l7", "Label")
WITH loF.l7
    .AutoSize = .T.
    .FontBold = .T.
    .FontName = "Tahoma"
    .FontSize = 14
    .WordWrap = .T.
    .Caption  = lcTxt
    .Width    = 248
    .Height   = 48
ENDWITH
loF.l7.Caption = "Mensagem muito mais longa vinda do chamador em tempo de execucao para ver se a geometria muda"
STRTOFILE("7) AutoSize=.T., Caption trocada em runtime    : W=" + ;
    TRANSFORM(loF.l7.Width) + " H=" + TRANSFORM(loF.l7.Height) + lcCRLF, lcLog, 1)

*-- CASO 8: AutoSize eh READ-ONLY em runtime? (PEMSTATUS modo 2)
STRTOFILE(lcCRLF + "AutoSize read-only? " + TRANSFORM(PEMSTATUS(loF.l1, "AutoSize", 2)) + lcCRLF, lcLog, 1)
STRTOFILE("Height   read-only? " + TRANSFORM(PEMSTATUS(loF.l1, "Height", 2)) + lcCRLF, lcLog, 1)

STRTOFILE(lcCRLF + "FIM" + lcCRLF, lcLog, 1)
loF = .NULL.
QUIT
