SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro348_tmp\"
gcOut = gcDir + "probe2.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loB, lnI
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros2.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"

    L("=== os 7 FRX existem no projeto? ===")
    FOR lnI = 1 TO 7
        L("   SigReEt" + TRANSFORM(lnI) + ".frx = " + ;
          TRANSFORM(FILE(gc_4c_CaminhoReports + "SigReEt" + TRANSFORM(lnI) + ".frx")) + ;
          "   .frt = " + TRANSFORM(FILE(gc_4c_CaminhoReports + "SigReEt" + TRANSFORM(lnI) + ".frt")))
    ENDFOR

    GarantirClasse("FormSigReEtl")
    loF = CREATEOBJECT("FormSigReEtl")
    L("")
    L("form = " + VARTYPE(loF))
    SET DATASESSION TO loF.DataSessionId
    loB = loF.this_oRelatorio

    L("")
    L("=== caminho devolvido por SelecionarFRX para cada Tipo ===")
    FOR lnI = 1 TO 6
        loB.this_nTipoRelatorio = lnI
        loB.this_nSubTotais     = 0
        L("   Tipo=" + TRANSFORM(lnI) + " -> processa")
    ENDFOR

    L("")
    L("=== Visualizar() no Tipo 1 (Sintetico, o default da tela) ===")
    loB.this_nTipoRelatorio = 1
    loB.this_nSubTotais     = 0
    loB.this_nOrdem         = 1
    L("   PrepararDados = " + TRANSFORM(loB.PrepararDados()))
    L("   CsImpressao   = " + TRANSFORM(IIF(USED("CsImpressao"), RECCOUNT("CsImpressao"), -1)) + " linhas")
    L("   msg           = [" + loB.ObterMensagemErro() + "]")
    L("")
    L("erros: [" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
