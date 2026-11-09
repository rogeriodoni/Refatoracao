LPARAMETERS par_cX, par_cOpc
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro338_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loBO, lnT
TRY
    _SCREEN.Visible = .T.
    _SCREEN.WindowState = 2
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "relatoriobase.prg"), (gcDir + "sigredtvBO.prg"), (gcDir + "Formsigredtv.prg") ADDITIVE
    loF = CREATEOBJECT("FormT")
    SET DATASESSION TO loF.DataSessionId
    L("emps=" + TRANSFORM(RECCOUNT("csSigCdEmp")) + " mri=" + TRANSFORM(RECCOUNT("crSigCdMri")))
    loF.txt_4c_Demons.Value = IIF("9" $ par_cOpc, "999", "TESTE DRE")
    loF.txt_4c_DtInicial.Value = {^2000-01-01}
    loF.txt_4c_DtFinal.Value = {^2026-11-09}
    loF.txt_4c_CodMoeda.Value = "R"
    loF.txt_4c_DesMoeda.Value = "REAIS"
    IF "D" $ par_cOpc
       loF.obj_4c_OptContras.Value = 2
    ENDIF
    IF "C" $ par_cOpc
       loF.obj_4c_OptCompara.Value = 3
       loF.txt_4c_Comp1.Value = {^1999-01-01}
       loF.txt_4c_Comp2.Value = {^2025-11-09}
    ENDIF
    loF.Exec()
    loBO = loF.this_oRelatorio
    IF loBO.PrepararDados()
        L("dbRelatorio=" + TRANSFORM(RECCOUNT("dbRelatorio")) + " frx=" + loBO.NomeFRX())
        SELECT dbRelatorio
        SET ORDER TO dRecno
        SCAN
          L(STR(Ordems,3) + " ps=" + Ps + " " + Grupos + "|" + Contas + "|" + LEFT(Ds_contas,25) + "|" + LEFT(Ds_grupos,20) + "|" + TRANSFORM(Valor) + "|" + Operacaos + "|" + Emps + "|" + Titulos)
        ENDSCAN
        IF USED("Tempo")
          L("Tempo=" + TRANSFORM(RECCOUNT("Tempo")))
        ENDIF
        GO TOP
        IF par_cX == "P"
          SET POINT TO "."
          SET SEPARATOR TO ","
          SET REPORTBEHAVIOR 80
          loBO.PrevNoWait()
          IF WEXIST("Report Designer")
            ZOOM WINDOW "Report Designer" MAX
          ENDIF
          L("PRONTO")
          lnT = SECONDS()
          DO WHILE SECONDS() - lnT < 25
            DOEVENTS
          ENDDO
        ENDIF
    ELSE
        L("FALHOU [" + loBO.this_cMensagemErro + "]")
    ENDIF
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
DEFINE CLASS FormT AS Formsigredtv
  PROCEDURE Exec()
    THIS.FormParaRelatorio()
  ENDPROC
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
