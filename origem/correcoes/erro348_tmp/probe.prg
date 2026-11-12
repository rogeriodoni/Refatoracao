SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro348_tmp\"
gcOut = gcDir + "probe.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"

    L("=== A) Estatistica de Pedidos (FormSigReEsp) ===")
    TRY
        GarantirClasse("FormSigReEsp")
        loF = CREATEOBJECT("FormSigReEsp")
        L("   CREATEOBJECT -> " + VARTYPE(loF))
        IF VARTYPE(loF) = "O"
            L("   Caption = [" + loF.Caption + "]")
        ENDIF
    CATCH TO loE
        L("   ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
    ENDTRY

    L("")
    L("=== B) Estoque Por Localizacao (FormSigReEtl) - a do ReverterXML ===")
    TRY
        GarantirClasse("FormSigReEtl")
        loF = CREATEOBJECT("FormSigReEtl")
        L("   CREATEOBJECT -> " + VARTYPE(loF))
        IF VARTYPE(loF) = "O"
            L("   Caption = [" + loF.Caption + "]")
            SET DATASESSION TO loF.DataSessionId
            L("   crSigLcNv2 = " + TRANSFORM(IIF(USED("crSigLcNv2"), RECCOUNT("crSigLcNv2"), -1)) + " linhas")
            L("   crSigLcNv3 = " + TRANSFORM(IIF(USED("crSigLcNv3"), RECCOUNT("crSigLcNv3"), -1)) + " linhas")
            L("   crSigLcNv4 = " + TRANSFORM(IIF(USED("crSigLcNv4"), RECCOUNT("crSigLcNv4"), -1)) + " linhas")
        ENDIF
    CATCH TO loE
        L("   ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
    ENDTRY

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
