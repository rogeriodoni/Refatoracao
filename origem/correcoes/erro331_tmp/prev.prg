SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro331_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, loForm, loPg, lnT
_SCREEN.Visible = .T.
_SCREEN.WindowState = 2
TRY
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "SIGRECTPBO.prg"), (gcDir + "FormSIGRECTP.prg") ADDITIVE
    loForm = CREATEOBJECT("FormSIGRECTP")
    L("form=" + VARTYPE(loForm))
    SET DATASESSION TO loForm.DataSessionId
    SET DATE TO BRITISH
    SET CENTURY ON
    loPg = loForm.pgf_4c_Paginas.Page1
    L("tela ao abrir: " + TRANSFORM(loPg.txt_4c_DtInicial.Value) + " a " + TRANSFORM(loPg.txt_4c_DtFinal.Value) + ;
      " Pedidos=" + TRANSFORM(loPg.opt_4c_Pedidos.Value) + " Aprovados=" + TRANSFORM(loPg.opt_4c_Aprovados.Value))
    Cen(loForm, "01/11 a 09/11/2026", DATE(2026,11,1), DATE(2026,11,9), 3, 3, "", "")
    SELECT crImpressao
    GO TOP
    SET POINT TO "."
    SET SEPARATOR TO ","
    SET REPORTBEHAVIOR 80
    REPORT FORM (gc_4c_CaminhoReports + "SigReCtp") PREVIEW NOWAIT NOCONSOLE
    IF WEXIST("Report Designer")
        ZOOM WINDOW "Report Designer" MAX
    ENDIF
    L("PRONTO")
    lnT = SECONDS()
    DO WHILE SECONDS() - lnT < 25
        DOEVENTS
    ENDDO
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")

PROCEDURE Cen(par_oForm, par_cNome, par_dI, par_dF, par_nPed, par_nApr, par_cPro, par_cFor)
    LOCAL loPg, loB, lcN
    loPg = par_oForm.pgf_4c_Paginas.Page1
    loPg.txt_4c_DtInicial.Value = par_dI
    loPg.txt_4c_DtFinal.Value   = par_dF
    loPg.opt_4c_Pedidos.Value   = par_nPed
    loPg.opt_4c_Aprovados.Value = par_nApr
    loPg.txt_4c_CPros.Value     = par_cPro
    loPg.txt_4c_IClis.Value     = par_cFor
    loB = par_oForm.this_oRelatorio
    WITH loB
        .this_dDtInicial = loPg.txt_4c_DtInicial.Value
        .this_dDtFinal   = loPg.txt_4c_DtFinal.Value
        .this_dDtValidIs = loPg.txt_4c_DtValidIs.Value
        .this_dDtValidFs = loPg.txt_4c_DtValidFs.Value
        .this_cComprador = ALLTRIM(loPg.txt_4c_Comprador.Value)
        .this_cAprovador = ""
        .this_cCPros     = ALLTRIM(loPg.txt_4c_CPros.Value)
        .this_cIClis     = ALLTRIM(loPg.txt_4c_IClis.Value)
        .this_nPedidos   = loPg.opt_4c_Pedidos.Value
        .this_nAprovados = loPg.opt_4c_Aprovados.Value
    ENDWITH
    IF loB.PrepararDados()
        lcN = ""
        SELECT crImpressao
        SCAN
            lcN = lcN + TRANSFORM(Codigos) + IIF(Contador = 1, ":" + ALLTRIM(CPros) + "/" + ALLTRIM(IClis), ":ped" + TRANSFORM(Numes)) + " "
        ENDSCAN
        L(PADR(par_cNome, 28) + " -> linhas=" + TRANSFORM(RECCOUNT("crImpressao")) + " " + lcN)
    ELSE
        L(PADR(par_cNome, 28) + " -> FALHOU " + loB.this_cMensagemErro)
    ENDIF
ENDPROC

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC
