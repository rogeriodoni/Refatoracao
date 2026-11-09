LPARAMETERS par_cX, par_cOpc
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro339_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loBO, lnT, loPg
TRY
    _SCREEN.Visible = .T.
    _SCREEN.WindowState = 2
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "relatoriobase.prg"), (gcDir + "sigreegpBO.prg"), (gcDir + "Formsigreegp.prg") ADDITIVE
    loF = CREATEOBJECT("FormT")
    SET DATASESSION TO loF.DataSessionId
    loPg = loF.pgf_4c_Paginas.Page1
    IF par_cX == "F"
      loF.Show()
      L("PRONTO")
      lnT = SECONDS()
      DO WHILE SECONDS() - lnT < 25
        DOEVENTS
      ENDDO
    ELSE
    IF "1" $ par_cOpc
       loPg.cbo_4c_CmbOrdem.ListIndex = 1
    ENDIF
    IF "U" $ par_cOpc
       loPg.obj_4c_OptUnis.Value = 1
    ENDIF
    IF "H" $ par_cOpc
       loPg.txt_4c__data.Value = {^2026-10-31}
    ENDIF
    loF.Exec()
    loBO = loF.this_oRelatorio
    L("ordem=" + TRANSFORM(loBO.this_nCmbOrdem) + " data=" + DTOC(loBO.this_dData) + " emp=" + loBO.this_cCdEmpresa)
    IF loBO.PrepararDados()
        L("dbRelatorio=" + TRANSFORM(RECCOUNT("dbRelatorio")))
        SELECT dbRelatorio
        SCAN
          L(RTRIM(Detalhe))
        ENDSCAN
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
    ENDIF
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
DEFINE CLASS FormT AS Formsigreegp
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
