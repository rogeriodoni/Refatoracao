*==============================================================================
* ProbeTclDigitar.prg - ERRO205b: quantos caracteres a Classe aceita de fato?
* Digita "1234" via KEYBOARD num TextBox e le o Value resultante.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut
gcOut = ""

DO Caso WITH "A migrado nivel0: Value=''   MaxLen=10 Mask=''",     "",        10, ""
DO Caso WITH "B migrado nivel1: Value=''   MaxLen=10 Mask='9'",    "",        10, "9"
DO Caso WITH "C migrado nivel2: Value=''   MaxLen=10 Mask='99'",   "",        10, "99"
DO Caso WITH "D migrado nivel3: Value=''   MaxLen=10 Mask='9999'", "",        10, "9999"
DO Caso WITH "E legado-like   : Value=SP10 MaxLen=0  Mask='9999'", SPACE(10),  0, "9999"
DO Caso WITH "F legado-like   : Value=SP10 MaxLen=0  Mask=''",     SPACE(10),  0, ""
DO Caso WITH "G Value=''      : MaxLen=0  Mask=''",                "",         0, ""

STRTOFILE(gcOut, "C:\4c\automation\probe_tcl_digitar.txt")
QUIT

PROCEDURE Caso(pcRotulo, puValor, pnMaxLen, pcMask)
    LOCAL loF
    loF = CREATEOBJECT("frmDig", pcRotulo, puValor, pnMaxLen, pcMask)
    loF.Show(0)
    READ EVENTS
    loF = .NULL.
ENDPROC

DEFINE CLASS frmDig AS Form
    Width = 320
    Height = 90
    AutoCenter = .T.
    this_cRotulo = ""

    ADD OBJECT t1 AS TextBox WITH Top = 10, Left = 10, Width = 220, Height = 25
    ADD OBJECT tmr AS tmrDig WITH Interval = 600

    PROCEDURE Init(pcRotulo, puValor, pnMaxLen, pcMask)
        THIS.this_cRotulo  = pcRotulo
        THIS.t1.Value      = puValor
        THIS.t1.MaxLength  = pnMaxLen
        THIS.t1.InputMask  = pcMask
    ENDPROC

    PROCEDURE Activate
        THIS.t1.SetFocus()
        KEYBOARD "1234" PLAIN
    ENDPROC
ENDDEFINE

DEFINE CLASS tmrDig AS Timer
    PROCEDURE Timer
        LOCAL lcV
        THIS.Enabled = .F.
        lcV = TRANSFORM(THISFORM.t1.Value)
        gcOut = gcOut + PADR(THISFORM.this_cRotulo, 50) + ;
            " digitei[1234] -> Value=[" + lcV + "] aceitou " + ;
            TRANSFORM(LEN(ALLTRIM(lcV))) + " caractere(s)" + CHR(13)+CHR(10)
        THISFORM.Release()
        CLEAR EVENTS
    ENDPROC
ENDDEFINE
