SET SAFETY OFF
SET RESOURCE OFF
SYS(2335, 0)
LOCAL c, loForm, loE
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
c = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    GarantirClasse("FormSIGREFXV")
    loForm = CREATEOBJECT("FormSIGREFXV")
    WITH loForm.cnt_4c_Cabecalho.lbl_4c_Titulo
        c = "titulo L=" + TRANSFORM(.Left) + " T=" + TRANSFORM(.Top) + " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
            " fim=" + TRANSFORM(.Left + .Width) + " base=" + TRANSFORM(.Top + .Height) + " wrap=" + TRANSFORM(.WordWrap)
    ENDWITH
    c = c + " | botoes L=" + TRANSFORM(loForm.cmg_4c_Botoes.Left)
    loForm.Release()
CATCH TO loE
    c = c + "ERRO: " + loE.Message
ENDTRY
STRTOFILE(c, "C:\4c\refatoracao\automation\erro362\titulo_out.txt")
QUIT
