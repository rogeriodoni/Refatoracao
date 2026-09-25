SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_details.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cResultado, loc_oForm, loc_oErro
loc_cResultado = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    loc_oForm = CREATEOBJECT("FormSigMvSbn")

    IF VARTYPE(loc_oForm) = "O"
        loc_cResultado = "OK" + ;
            " Width=" + TRANSFORM(loc_oForm.Width) + ;
            " Height=" + TRANSFORM(loc_oForm.Height) + ;
            " grd_4c_Subniveis=" + TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_Subniveis", 5)) + ;
            " grd_4c_Itens=" + TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_Itens", 5)) + ;
            " ColCount1=" + TRANSFORM(loc_oForm.grd_4c_Subniveis.ColumnCount) + ;
            " ColCount2=" + TRANSFORM(loc_oForm.grd_4c_Itens.ColumnCount) + ;
            " Hdr1=" + loc_oForm.grd_4c_Subniveis.Column2.Header1.Caption + ;
            " Hdr8=" + loc_oForm.grd_4c_Itens.Column3.Header1.Caption
        loc_oForm.Release()
    ELSE
        loc_cResultado = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cResultado = "EXCEPTION: " + loc_oErro.Message + " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

STRTOFILE(loc_cResultado, "C:\4c\automation\instantiate_check_result.txt")
QUIT
