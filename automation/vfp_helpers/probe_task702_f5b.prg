SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\probe_task702_f5b_err.txt"

LOCAL lcOut, loc_oForm, loc_oErro, lcTxt
lcOut = "C:\4c\automation\vfp_helpers\probe_task702_f5b.txt"
lcTxt = ""

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()

IF TYPE("gnConnHandle") != "N"
    gnConnHandle = 0
ENDIF

GarantirClasse("Formsigopcks")

TRY
    loc_oForm = CREATEOBJECT("Formsigopcks", "MAXIMO", "COND PAGTO 30/60", ;
        "segundo titulo", 123, DATE(), "001", "01", 1500.00)
CATCH TO loc_oErro
    lcTxt = lcTxt + "EXCECAO: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

lcTxt = lcTxt + "VARTYPE(form) = [" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    lcTxt = lcTxt + "Caption       = [" + loc_oForm.Caption + "]" + CHR(13) + CHR(10)
    lcTxt = lcTxt + "ControlCount  = " + TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10)
    lcTxt = lcTxt + "Form WxH      = " + TRANSFORM(loc_oForm.Width) + "x" + ;
        TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)
    lcTxt = lcTxt + REPLICATE("-", 78) + CHR(13) + CHR(10)

    LOCAL loc_i, loc_o
    FOR loc_i = 1 TO loc_oForm.ControlCount
        loc_o = loc_oForm.Controls(loc_i)
        lcTxt = lcTxt + PADR(loc_o.Name, 18) + " " + PADR(loc_o.BaseClass, 14) + ;
            " L=" + PADL(TRANSFORM(loc_o.Left), 4) + ;
            " T=" + PADL(TRANSFORM(loc_o.Top), 4) + ;
            " W=" + PADL(TRANSFORM(loc_o.Width), 4) + ;
            " H=" + PADL(TRANSFORM(loc_o.Height), 4) + ;
            " Vis=" + IIF(loc_o.Visible, "T", "F")
        IF PEMSTATUS(loc_o, "Caption", 5)
            lcTxt = lcTxt + " Cap=[" + ALLTRIM(loc_o.Caption) + "]"
        ENDIF
        IF PEMSTATUS(loc_o, "Value", 5) AND VARTYPE(loc_o.Value) = "C"
            lcTxt = lcTxt + " Val=[" + ALLTRIM(loc_o.Value) + "]"
        ENDIF
        IF PEMSTATUS(loc_o, "Picture", 5)
            lcTxt = lcTxt + " Pic=[" + ALLTRIM(loc_o.Picture) + "]" + ;
                " existe=" + IIF(FILE(ALLTRIM(loc_o.Picture)), "SIM", "NAO")
        ENDIF
        lcTxt = lcTxt + CHR(13) + CHR(10)
    ENDFOR

    lcTxt = lcTxt + REPLICATE("-", 78) + CHR(13) + CHR(10)
    lcTxt = lcTxt + "Form.Picture  = [" + ALLTRIM(loc_oForm.Picture) + "] existe=" + ;
        IIF(FILE(ALLTRIM(loc_oForm.Picture)), "SIM", "NAO") + CHR(13) + CHR(10)
    lcTxt = lcTxt + "AutoSize lbl_4c_Label2 = " + ;
        IIF(loc_oForm.lbl_4c_Label2.AutoSize, "T", "F") + CHR(13) + CHR(10)
    lcTxt = lcTxt + "MaxLength usuario/senha = " + ;
        TRANSFORM(loc_oForm.txt_4c_Usuario.MaxLength) + " / " + ;
        TRANSFORM(loc_oForm.txt_4c_Senha.MaxLength) + CHR(13) + CHR(10)
    lcTxt = lcTxt + "PasswordChar senha = [" + loc_oForm.txt_4c_Senha.PasswordChar + "]" + CHR(13) + CHR(10)
    lcTxt = lcTxt + "BO.DevePreencherUsuarioLogado = " + ;
        IIF(loc_oForm.this_oBusinessObject.DevePreencherUsuarioLogado(), "T", "F") + CHR(13) + CHR(10)
    lcTxt = lcTxt + "BO.this_cFrase = [" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cFrase) + "]" + CHR(13) + CHR(10)
    loc_oForm.Release()
ENDIF

STRTOFILE(lcTxt, lcOut)
QUIT
