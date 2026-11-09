SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro337_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loBO
TRY
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "relatoriobase.prg"), (gcDir + "SigReDpDBO.prg"), (gcDir + "FormSigReDpD.prg") ADDITIVE
    loF = CREATEOBJECT("FormT")
    L("form=" + VARTYPE(loF))
    SET DATASESSION TO loF.DataSessionId
    L("opd=" + TRANSFORM(RECCOUNT("CsSigCdOpd")))
    SELECT CsSigCdOpd
    SCAN
      L("  [" + DopPs + "] marca=" + TRANSFORM(Marca) + " tg=" + TRANSFORM(CodTgOps))
    ENDSCAN
    loF.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value = {^2000-01-01}
    loF.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value = {^2026-11-09}
    loF.Exec()
    loBO = loF.this_oRelatorio
    L("ok=" + TRANSFORM(loBO.PrepararDados()) + " msg=" + loBO.this_cMensagemErro)
    L("TmpNens=" + TRANSFORM(IIF(USED("TmpNens"), RECCOUNT("TmpNens"), -1)) + " CrSigCdNec=" + TRANSFORM(IIF(USED("CrSigCdNec"), RECCOUNT("CrSigCdNec"), -1)) + " TmpRelat=" + TRANSFORM(IIF(USED("TmpRelat"), RECCOUNT("TmpRelat"), -1)))
    IF USED("TmpRelat")
      SELECT TmpRelat
      SCAN
        L(Fase + "|" + IClis + "|" + RClis + "|" + CMats + "|" + DPros + "|" + TRANSFORM(Qtde) + "|" + TRANSFORM(Peso2s) + "|" + CUnis + "|" + CUniPs)
      ENDSCAN
    ENDIF
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT

DEFINE CLASS FormT AS FormSigReDpD
  PROCEDURE Exec()
    THIS.FormParaRelatorio()
  ENDPROC
ENDDEFINE
DEFINE CLASS SigReDpDBO_X AS SigReDpDBO
ENDDEFINE

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC
FUNCTION MsgErro(par_cMsg, par_cTit)
    L("MsgErro: [" + TRANSFORM(par_cMsg) + "] " + TRANSFORM(par_cTit))
ENDFUNC
FUNCTION MsgAviso(par_cMsg, par_cTit)
    L("MsgAviso: [" + TRANSFORM(par_cMsg) + "]")
ENDFUNC
