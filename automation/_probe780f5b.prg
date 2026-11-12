SET SAFETY OFF
SET RESOURCE OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe780f5b_dialogs.txt"
gb_4c_ValidandoUI      = .F.
gnConnHandle           = 0
LOCAL lcOut, loForm, lnI, lcR, loF2, loL
lcOut = "C:\4c\automation\_probe780f5b_out.txt"
ON ERROR STRTOFILE("ON ERROR: " + MESSAGE() + " LINENO=" + TRANSFORM(LINENO()) + CHR(13)+CHR(10), lcOut, .T.)
CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
GarantirClasse("Formsigoppei")
loForm = CREATEOBJECT("Formsigoppei")
lcR = "=== TabIndex EFETIVO de todos os controles ===" + CHR(13)+CHR(10)
FOR lnI = 1 TO loForm.ControlCount
    lcR = lcR + PADR(loForm.Controls(lnI).Name, 20) + PADR(loForm.Controls(lnI).BaseClass, 15) + ;
          "TabIndex=" + PADL(TRANSFORM(loForm.Controls(lnI).TabIndex), 3) + CHR(13)+CHR(10)
ENDFOR
loForm.Release()
lcR = lcR + CHR(13)+CHR(10) + "=== MEDICAO ISOLADA: VFP9 aceita TabIndex > ControlCount? ===" + CHR(13)+CHR(10)
loF2 = CREATEOBJECT("Form")
loF2.AddObject("t1", "TextBox")
loF2.AddObject("t2", "TextBox")
loF2.t2.TabIndex = 16
lcR = lcR + "2 controles, t2.TabIndex atribuido 16 -> lido " + TRANSFORM(loF2.t2.TabIndex) + ;
      " / t1 ficou " + TRANSFORM(loF2.t1.TabIndex) + CHR(13)+CHR(10)
loF2.AddObject("l1", "Label")
loF2.l1.TabIndex = 1
lcR = lcR + "Label l1.TabIndex atribuido 1 -> lido " + TRANSFORM(loF2.l1.TabIndex) + ;
      " / t1 virou " + TRANSFORM(loF2.t1.TabIndex) + " / t2 virou " + TRANSFORM(loF2.t2.TabIndex) + ;
      "   (Label ROUBA slot e EMPURRA os TextBox)" + CHR(13)+CHR(10)
STRTOFILE(lcR, lcOut)
QUIT
