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
    loF = CREATEOBJECT("FormT")
    SET DATASESSION TO loF.DataSessionId
    loPg = loF.pgf_4c_Paginas.Page1
    loPg.txt_4c_GetGrupo.Value = "1"
    loF.TeclaGetGrupo(13, 0)
    L("  grupo=[" + loPg.txt_4c_GetGrupo.Value + "] desc=[" + loPg.txt_4c_GetDGrupo.Value + "]")
    loPg.txt_4c_GetGrupo.Value = "11210"
    loF.TeclaGetGrupo(13, 0)
    L("  grupo=[" + loPg.txt_4c_GetGrupo.Value + "] desc=[" + loPg.txt_4c_GetDGrupo.Value + "]")
    loPg.txt_4c_GetConta.Value = "1"
    loF.TeclaGetConta(13, 0)
    L("  conta=[" + loPg.txt_4c_GetConta.Value + "] desc=[" + loPg.txt_4c_GetDConta.Value + "]")
    loPg.txt_4c_GetConta.Value = "1121001"
    loF.TeclaGetConta(13, 0)
    L("  conta=[" + loPg.txt_4c_GetConta.Value + "] desc=[" + loPg.txt_4c_GetDConta.Value + "]")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
DEFINE CLASS FormT AS FormSigReDpD
  PROCEDURE AbrirBuscaGrupo()
    THIS.Lista("SigCdGcr", "Codigos", THIS.pgf_4c_Paginas.Page1.txt_4c_GetGrupo.Value)
  ENDPROC
  PROCEDURE AbrirBuscaConta()
    THIS.Lista("SigCdCli", "IClis", THIS.pgf_4c_Paginas.Page1.txt_4c_GetConta.Value)
  ENDPROC
  PROCEDURE Lista(t, c, v)
    LOCAL o
    o = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, t, "cur_x", c, ALLTRIM(v), "x", .F., .F., "GerBals = 1")
    L("ABRIU LISTA " + t + " valor=[" + v + "] achou=" + TRANSFORM(o.this_lAchouRegistro) + " linhas=" + TRANSFORM(IIF(USED("cur_x"), RECCOUNT("cur_x"), 0)))
    IF USED("cur_x")
      SELECT cur_x
      SCAN
        L("    " + EVALUATE(c))
      ENDSCAN
      USE IN cur_x
    ENDIF
    o.Release()
  ENDPROC
ENDDEFINE
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC
FUNCTION MsgErro(par_cMsg, par_cTit)
    L("MsgErro: [" + TRANSFORM(par_cMsg) + "] " + TRANSFORM(par_cTit))
ENDFUNC
