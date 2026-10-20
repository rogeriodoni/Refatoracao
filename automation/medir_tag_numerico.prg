SET SAFETY OFF
SET RESOURCE OFF
LOCAL loc_cOut, loc_oF, loc_oErr
loc_cOut = ""

loc_oF = CREATEOBJECT("Form")
loc_oF.AddObject("txt1", "TextBox")
loc_oF.txt1.Value = 12.5

loc_cOut = loc_cOut + "Tag default VARTYPE=[" + VARTYPE(loc_oF.txt1.Tag) + "]" + CHR(13) + CHR(10)

TRY
    loc_oF.txt1.Tag = loc_oF.txt1.Value
    loc_cOut = loc_cOut + "APOS Tag=<numeric 12.5>: VARTYPE=[" + VARTYPE(loc_oF.txt1.Tag) + "] valor=[" + TRANSFORM(loc_oF.txt1.Tag) + "]" + CHR(13) + CHR(10)
CATCH TO loc_oErr
    loc_cOut = loc_cOut + "ERRO ao atribuir numerico ao Tag: " + loc_oErr.Message + CHR(13) + CHR(10)
ENDTRY

TRY
    IF loc_oF.txt1.Value != loc_oF.txt1.Tag
        loc_cOut = loc_cOut + "COMPARACAO Value != Tag => .T." + CHR(13) + CHR(10)
    ELSE
        loc_cOut = loc_cOut + "COMPARACAO Value != Tag => .F." + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErr
    loc_cOut = loc_cOut + "ERRO na comparacao Value != Tag: " + loc_oErr.Message + " (erro " + TRANSFORM(loc_oErr.ErrorNo) + ")" + CHR(13) + CHR(10)
ENDTRY

*-- segundo cenario: Tag nunca atribuido (default) comparado com numerico
LOCAL loc_oF2
loc_oF2 = CREATEOBJECT("Form")
loc_oF2.AddObject("txt2", "TextBox")
loc_oF2.txt2.Value = 7
TRY
    IF loc_oF2.txt2.Value != loc_oF2.txt2.Tag
        loc_cOut = loc_cOut + "DEFAULT Tag: Value != Tag => .T." + CHR(13) + CHR(10)
    ELSE
        loc_cOut = loc_cOut + "DEFAULT Tag: Value != Tag => .F." + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErr
    loc_cOut = loc_cOut + "DEFAULT Tag ERRO: " + loc_oErr.Message + " (erro " + TRANSFORM(loc_oErr.ErrorNo) + ")" + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cOut, "C:\4c\automation\medir_tag_numerico.out")
QUIT
