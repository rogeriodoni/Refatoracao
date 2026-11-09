LPARAMETERS par_cFRX, par_cOpc
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro337_tmp\"
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
    SET PROCEDURE TO (gcDir + "relatoriobase.prg"), (gcDir + "SigReDpDBO.prg"), (gcDir + "FormSigReDpD.prg") ADDITIVE
    loF = CREATEOBJECT("FormT")
    SET DATASESSION TO loF.DataSessionId
    loPg = loF.pgf_4c_Paginas.Page1
    loPg.txt_4c_DtInicial.Value = {^2000-01-01}
    loPg.txt_4c_DtFinal.Value = {^2026-11-09}
    IF "D" $ par_cOpc
      loPg.chk_4c_Dopes.Value = 1
    ENDIF
    IF "T" $ par_cOpc
      loPg.chk_4c_Detalhe.Value = 1
    ENDIF
    IF "V" $ par_cOpc
      loPg.chk_4c_Valor.Value = 1
    ENDIF
    IF "Q" $ par_cOpc
      loPg.chk_4c_QtdPes.Value = 1
    ENDIF
    IF "R" $ par_cOpc
      loPg.chk_4c_Relatorio.Value = 1
    ENDIF
    IF "P" $ par_cOpc
      loPg.chk_4c_Produtos.Value = 1
    ENDIF
    loF.Exec()
    loBO = loF.this_oRelatorio
    IF loBO.PrepararDados()
        L("TmpRelat=" + TRANSFORM(RECCOUNT("TmpRelat")) + " frx=" + loBO.NomeFRX())
        SELECT TmpRelat
        GO TOP
        IF loBO.NomeFRX() == "SigReDp7"
          SET POINT TO ","
          SET SEPARATOR TO "."
        ELSE
          SET POINT TO "."
          SET SEPARATOR TO ","
        ENDIF
        SET REPORTBEHAVIOR 80
        loBO.PrevNoWait(gc_4c_CaminhoReports + loBO.NomeFRX())
        IF WEXIST("Report Designer")
            ZOOM WINDOW "Report Designer" MAX
        ENDIF
        L("PRONTO")
        lnT = SECONDS()
        DO WHILE SECONDS() - lnT < 25
            DOEVENTS
        ENDDO
    ELSE
        L("FALHOU [" + loBO.this_cMensagemErro + "]")
    ENDIF
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
QUIT

DEFINE CLASS FormT AS FormSigReDpD
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
