SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_oF, loc_cR, loc_oE
loc_cR = ""
TRY
    loc_oF = CREATEOBJECT("Form")
    loc_oF.AddObject("b1", "CommandButton")
    loc_oF.AddObject("t1", "TextBox")
    loc_oF.AddObject("t2", "TextBox")
    loc_cR = loc_cR + "-- apos AddObject (ordem de criacao) --" + CHR(13)
    loc_cR = loc_cR + "b1=" + TRANSFORM(loc_oF.b1.TabIndex) + " t1=" + TRANSFORM(loc_oF.t1.TabIndex) + ;
             " t2=" + TRANSFORM(loc_oF.t2.TabIndex) + CHR(13)

    *-- A: atribuir DURANTE a criacao (como o form migrado faz hoje)
    loc_oF.b1.TabIndex = 11
    loc_oF.t1.TabIndex = 5
    loc_oF.t2.TabIndex = 5
    loc_cR = loc_cR + "-- A) atribuindo 11/5/5 --" + CHR(13)
    loc_cR = loc_cR + "b1=" + TRANSFORM(loc_oF.b1.TabIndex) + " t1=" + TRANSFORM(loc_oF.t1.TabIndex) + ;
             " t2=" + TRANSFORM(loc_oF.t2.TabIndex) + CHR(13)

    *-- B: passe final, valores UNICOS e dentro da faixa 1..ControlCount
    loc_oF.t1.TabIndex = 1
    loc_oF.t2.TabIndex = 2
    loc_oF.b1.TabIndex = 3
    loc_cR = loc_cR + "-- B) passe final 1/2/3 (unicos) --" + CHR(13)
    loc_cR = loc_cR + "b1=" + TRANSFORM(loc_oF.b1.TabIndex) + " t1=" + TRANSFORM(loc_oF.t1.TabIndex) + ;
             " t2=" + TRANSFORM(loc_oF.t2.TabIndex) + CHR(13)
    loc_cR = loc_cR + "ControlCount=" + TRANSFORM(loc_oF.ControlCount) + CHR(13)
    loc_oF.Release()
CATCH TO loc_oE
    loc_cR = loc_cR + "EXCECAO: " + loc_oE.Message
ENDTRY
STRTOFILE(loc_cR, "C:\4c\tasks\task718\medir_tabindex.out")
QUIT
