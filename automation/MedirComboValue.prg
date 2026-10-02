SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
#DEFINE OUT "C:\4c\automation\medir_combovalue.txt"
LOCAL loF, lcOut, loEx
lcOut = ""
loF = CREATEOBJECT("Form")
loF.AddObject("cbo", "ComboBox")
loF.cbo.FontName = "Tahoma"
loF.cbo.FontSize = 8
lcOut = lcOut + "default .Value VARTYPE = [" + VARTYPE(loF.cbo.Value) + "]" + ;
    " valor=[" + TRANSFORM(loF.cbo.Value) + "]" + CHR(13) + CHR(10)

TRY
    loF.cbo.Value = 3
    lcOut = lcOut + "atribuir NUMERICO 3  -> OK, VARTYPE=[" + VARTYPE(loF.cbo.Value) + ;
        "] valor=[" + TRANSFORM(loF.cbo.Value) + "]" + CHR(13) + CHR(10)
CATCH TO loEx
    lcOut = lcOut + "atribuir NUMERICO 3  -> ERRO: " + loEx.Message + CHR(13) + CHR(10)
ENDTRY

TRY
    loF.cbo.Value = "3"
    lcOut = lcOut + "atribuir CHAR '3'    -> OK, VARTYPE=[" + VARTYPE(loF.cbo.Value) + ;
        "] valor=[" + TRANSFORM(loF.cbo.Value) + "]" + CHR(13) + CHR(10)
CATCH TO loEx
    lcOut = lcOut + "atribuir CHAR '3'    -> ERRO: " + loEx.Message + CHR(13) + CHR(10)
ENDTRY

*-- e o CheckBox ligado a coluna bit: o .Value nasce numerico?
loF.AddObject("chk", "CheckBox")
lcOut = lcOut + CHR(13) + CHR(10) + "CheckBox default .Value VARTYPE = [" + ;
    VARTYPE(loF.chk.Value) + "] valor=[" + TRANSFORM(loF.chk.Value) + "]" + CHR(13) + CHR(10)
TRY
    loF.chk.Value = .T.
    lcOut = lcOut + "atribuir LOGICO .T.  -> OK, VARTYPE=[" + VARTYPE(loF.chk.Value) + ;
        "] valor=[" + TRANSFORM(loF.chk.Value) + "]" + CHR(13) + CHR(10)
CATCH TO loEx
    lcOut = lcOut + "atribuir LOGICO .T.  -> ERRO: " + loEx.Message + CHR(13) + CHR(10)
ENDTRY
TRY
    loF.chk.Value = 1
    lcOut = lcOut + "atribuir NUMERICO 1  -> OK, VARTYPE=[" + VARTYPE(loF.chk.Value) + ;
        "] valor=[" + TRANSFORM(loF.chk.Value) + "]" + CHR(13) + CHR(10)
CATCH TO loEx
    lcOut = lcOut + "atribuir NUMERICO 1  -> ERRO: " + loEx.Message + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(lcOut, OUT)
QUIT
