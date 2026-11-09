SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro337_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loPg
TRY
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "relatoriobase.prg"), (gcDir + "SigReDpDBO.prg"), (gcDir + "FormSigReDpD.prg") ADDITIVE
    loF = CREATEOBJECT("FormSigReDpD")
    SET DATASESSION TO loF.DataSessionId
    L("Gcr=" + TRANSFORM(RECCOUNT("CrSigCdGcr")) + " Cli=" + TRANSFORM(RECCOUNT("CrSigCdCli")) + " exact=" + SET("EXACT"))
    loPg = loF.pgf_4c_Paginas.Page1
    L("conta enabled antes=" + TRANSFORM(loPg.txt_4c_GetConta.Enabled))
    loPg.txt_4c_GetGrupo.Value = "1"
    loF.TeclaGetGrupo(13, 0)
    L("grupo=[" + loPg.txt_4c_GetGrupo.Value + "] desc=[" + loPg.txt_4c_GetDGrupo.Value + "] conta enabled=" + TRANSFORM(loPg.txt_4c_GetConta.Enabled))
    loPg.txt_4c_GetConta.Value = "1"
    loF.TeclaGetConta(13, 0)
    L("conta=[" + loPg.txt_4c_GetConta.Value + "] desc=[" + loPg.txt_4c_GetDConta.Value + "]")
    loPg.txt_4c_GetGrupo.Value = "3"
    loF.TeclaGetGrupo(13, 0)
    L("grupo=[" + loPg.txt_4c_GetGrupo.Value + "] desc=[" + loPg.txt_4c_GetDGrupo.Value + "] conta=[" + loPg.txt_4c_GetConta.Value + "]")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC
FUNCTION MsgErro(par_cMsg, par_cTit)
    L("MsgErro: [" + TRANSFORM(par_cMsg) + "] " + TRANSFORM(par_cTit))
ENDFUNC
