SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loBO, loc_oPg, loc_nI, loc_oA, loc_nEnv, loR
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro367\mensagens.txt"
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("FormSigReHev")
    loForm = CREATEOBJECT("FormSigReHev")
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + CHR(13)+CHR(10)
    loc_oPg = loForm.pgf_4c_Paginas.Page1
    FOR loc_nI = 1 TO loc_oPg.ControlCount
        loc_oA = loc_oPg.Controls(loc_nI)
        loc_cOut = loc_cOut + PADR(loc_oA.Name, 18) + " T=" + PADL(loc_oA.Top,4) + " L=" + PADL(loc_oA.Left,4) + " W=" + PADL(loc_oA.Width,4) + CHR(13)+CHR(10)
    ENDFOR
    SET DATASESSION TO loForm.DataSessionId
    loBO = loForm.this_oRelatorio
    DIMENSION laE[3]
    laE[1] = 900001
    laE[2] = 900002
    laE[3] = 90001
    FOR loc_nI = 1 TO 3
        loBO.this_nEnvelope = laE[loc_nI]
        loc_cOut = loc_cOut + "== envelope " + TRANSFORM(laE[loc_nI]) + ": PrepararDados=" + TRANSFORM(loBO.PrepararDados()) + ;
            " regs=" + TRANSFORM(IIF(USED("Temp_HisOp"), RECCOUNT("Temp_HisOp"), -1)) + CHR(13)+CHR(10)
        IF USED("Temp_HisOp")
            SELECT Temp_HisOp
            SCAN
                loc_cOut = loc_cOut + "   " + TRANSFORM(Nenvs) + " " + TTOC(Datas) + " " + ALLTRIM(Dopps) + "/" + TRANSFORM(Numps) + ;
                    " orig=" + ALLTRIM(ContaOs) + "-" + ALLTRIM(Dopes) + " dest=" + ALLTRIM(ContaDs) + "-" + ALLTRIM(EmpDnPs) + ;
                    " peso=" + TRANSFORM(Pesos) + " qtd=" + TRANSFORM(Qtds) + " acesso=" + TRANSFORM(Acesso) + " (" + VARTYPE(Acesso) + ")" + CHR(13)+CHR(10)
            ENDSCAN
        ENDIF
        IF loc_nI = 1
            loc_cOut = loc_cOut + "   cab: " + ALLTRIM(csCabecalho.cb_titulo) + CHR(13)+CHR(10)
            loR = CREATEOBJECT("T367BO")
            loc_cOut = loc_cOut + "   render paginas=" + TRANSFORM(loR.Renderizar(gc_4c_CaminhoReports + "SigReHev.frx", "C:\4c\refatoracao\automation\erro367\env_900001.png")) + CHR(13)+CHR(10)
            loR = .NULL.
        ENDIF
    ENDFOR
    SET DATASESSION TO 1
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro367\simulacao_out.txt")
QUIT

DEFINE CLASS T367BO AS SigReHevBO
    PROCEDURE Renderizar(par_cFrx, par_cPng)
        LOCAL loL
        SELECT Temp_HisOp
        GO TOP
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 90
        loL = CREATEOBJECT("ReportListener")
        loL.ListenerType = 3
        REPORT FORM (par_cFrx) OBJECT loL
        loL.OutputPage(1, par_cPng, 104)
        RETURN loL.PageTotal
    ENDPROC
ENDDEFINE
