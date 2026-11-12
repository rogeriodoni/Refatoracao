SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro344_tmp\"
gcOut = gcDir + "probe4.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loPag
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros4.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("FormSIGREEQR")
    GarantirClasse("FormSigReEqT")
    loF = CREATEOBJECT("FormSIGREEQR")
    SET DATASESSION TO loF.DataSessionId
    loPag = loF.pgf_4c_Paginas.Page1

    loF.CmdSelTudoClick()
    loPag.txt_4c_CdEmpresa.Value    = "001"
    loPag.txt_4c_DsEmpresa.Value    = "MARCELLA BAHIA"
    loPag.obj_4c_OptRfestoque.Value = 1
    loPag.obj_4c_OptCalcusto.Value  = 1
    L("ANTES do clique: Form.Enabled = " + TRANSFORM(loF.Enabled))

    L("chamando CmgVisualizarClick() ...")
    loF.CmgVisualizarClick()

    *-- so chega aqui se o modal NAO abriu
    L("VOLTOU do handler (modal NAO abriu)")
    L("   csTempoGr = " + TRANSFORM(IIF(USED("csTempoGr"), RECCOUNT("csTempoGr"), -1)))
    L("   Form.Enabled = " + TRANSFORM(loF.Enabled))
    L("   erros: [" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
