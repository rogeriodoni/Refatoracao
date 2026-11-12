SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro344_tmp\"
gcOut = gcDir + "probe.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF1, loF2, loVis
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    L("conn = " + TRANSFORM(gnConnHandle))
    go_4c_Sistema.cCodEmpresa = "001"

    L("")
    L("=== A) Posicao de Etiquetas (Formsigreeqe) ===")
    TRY
        GarantirClasse("Formsigreeqe")
        loF1 = CREATEOBJECT("Formsigreeqe")
        L("   CREATEOBJECT -> " + VARTYPE(loF1))
        IF VARTYPE(loF1) = "O"
            L("   Caption = [" + loF1.Caption + "]")
            L("   FRX SigReEqe.frx existe = " + TRANSFORM(FILE(gc_4c_CaminhoReports + "SigReEqe.frx")))
        ENDIF
    CATCH TO loE
        L("   ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
    ENDTRY

    L("")
    L("=== B) Posicao de Estoque Retroativo (FormSIGREEQR) ===")
    TRY
        GarantirClasse("FormSIGREEQR")
        loF2 = CREATEOBJECT("FormSIGREEQR")
        L("   CREATEOBJECT -> " + VARTYPE(loF2))
        IF VARTYPE(loF2) = "O"
            L("   Caption = [" + loF2.Caption + "]")
        ENDIF
    CATCH TO loE
        L("   ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
    ENDTRY

    IF VARTYPE(loF2) = "O"
        SET DATASESSION TO loF2.DataSessionId
        L("")
        L("=== C) marcar + processar ===")
        loF2.CmdSelTudoClick()
        loF2.this_oRelatorio.this_cCdEmpresa = "001"
        loF2.this_oRelatorio.this_nRfEstoque = 1
        loF2.this_oRelatorio.this_nCalcusto  = 1
        L("   Atualizar = " + TRANSFORM(loF2.this_oRelatorio.Atualizar()))
        L("   csTempoGr = " + TRANSFORM(IIF(USED("csTempoGr"), RECCOUNT("csTempoGr"), -1)))
        L("   CsTempoCp = " + TRANSFORM(IIF(USED("CsTempoCp"), RECCOUNT("CsTempoCp"), -1)))

        L("")
        L("=== D) VISUALIZADOR FormSigReEqT (so CREATEOBJECT, sem Show) ===")
        TRY
            GarantirClasse("FormSigReEqT")
            loVis = CREATEOBJECT("FormSigReEqT", loF2)
            L("   CREATEOBJECT -> " + VARTYPE(loVis))
            IF VARTYPE(loVis) = "O"
                L("   Caption = [" + loVis.Caption + "]")
            ELSE
                L("   <<< Init devolveu .F.: a tela NAO abre")
            ENDIF
        CATCH TO loE
            L("   ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
        ENDTRY
    ENDIF

    L("")
    L("erros capturados: [" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]")
CATCH TO loE
    L("ERRO GERAL " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
