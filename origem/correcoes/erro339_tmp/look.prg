SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro339_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loPg
TRY
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "relatoriobase.prg"), (gcDir + "sigreegpBO.prg"), (gcDir + "Formsigreegp.prg") ADDITIVE
    loF = CREATEOBJECT("FormT")
    SET DATASESSION TO loF.DataSessionId
    loPg = loF.pgf_4c_Paginas.Page1
    loPg.txt_4c__Cd_GrEstoque.Value = "1"
    loF.TeclaCdGrEstoque(13, 0)
    L("  grupo est=[" + loPg.txt_4c__Cd_GrEstoque.Value + "] desc=[" + loPg.txt_4c__Ds_GrEstoque.Value + "]")
    loPg.txt_4c__Cd_GrEstoque.Value = "11210"
    loF.TeclaCdGrEstoque(13, 0)
    L("  grupo est=[" + loPg.txt_4c__Cd_GrEstoque.Value + "] desc=[" + loPg.txt_4c__Ds_GrEstoque.Value + "]")
    loPg.txt_4c__moeda.Value = "U"
    loF.TeclaCdMoeda(13, 0)
    L("  moeda=[" + loPg.txt_4c__moeda.Value + "]")
    loPg.txt_4c__cd_empresa.Value = "0"
    loF.TeclaCdEmpresa(13, 0)
    L("  empresa=[" + loPg.txt_4c__cd_empresa.Value + "]")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
DEFINE CLASS FormT AS Formsigreegp
  PROCEDURE AbrirBuscaGrEstoque()
    THIS.Lista("SigCdGcr", "codigos", THIS.pgf_4c_Paginas.Page1.txt_4c__Cd_GrEstoque.Value)
  ENDPROC
  PROCEDURE AbrirBuscaMoeda()
    THIS.Lista("SigCdMoe", "cmoes", THIS.pgf_4c_Paginas.Page1.txt_4c__moeda.Value)
  ENDPROC
  PROCEDURE AbrirBuscaEmpresa()
    THIS.Lista("SigCdEmp", "cemps", THIS.pgf_4c_Paginas.Page1.txt_4c__cd_empresa.Value)
  ENDPROC
  PROCEDURE Lista(t, c, v)
    LOCAL o
    o = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, t, "cur_x", c, ALLTRIM(v), "x", "")
    L("ABRIU LISTA " + t + " valor=[" + v + "] linhas=" + TRANSFORM(IIF(USED("cur_x"), RECCOUNT("cur_x"), 0)))
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
