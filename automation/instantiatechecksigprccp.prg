SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprccp.txt"
IF FILE(gc_4c_ArquivoErroTeste)
	DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro
loc_cRes = "FAIL"

TRY
	CD C:\4c\projeto\app\start
	DO config.prg
	ConfigurarAmbiente()

	loc_oForm = CREATEOBJECT("Formsigprccp", .F.)

	IF VARTYPE(loc_oForm) = "O"
		loc_cRes = "OK" + ;
			" W=" + TRANSFORM(loc_oForm.Width) + ;
			" H=" + TRANSFORM(loc_oForm.Height) + ;
			" Caption=[" + loc_oForm.Caption + "]" + ;
			" CabTop=" + TRANSFORM(loc_oForm.cnt_4c_Cabecalho.Top) + ;
			" CabW=" + TRANSFORM(loc_oForm.cnt_4c_Cabecalho.Width) + ;
			" SombraCap=[" + loc_oForm.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption + "]" + ;
			" TituloCap=[" + loc_oForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption + "]" + ;
			" BOTipo=" + VARTYPE(loc_oForm.this_oBusinessObject) + ;
			" Automatico=" + TRANSFORM(loc_oForm.this_lAutomatico)

		loc_oForm.Release()
	ELSE
		loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
	ENDIF
CATCH TO loc_oErro
	loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
		" Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE("C:\4c\automation\vfp_error_sigprccp.txt")
	loc_cRes = loc_cRes + CHR(13) + CHR(10) + "DIALOGOS: " + FILETOSTR("C:\4c\automation\vfp_error_sigprccp.txt")
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprccp_result.txt")
QUIT
