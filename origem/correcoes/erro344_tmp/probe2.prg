SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro344_tmp\"
gcOut = gcDir + "probe2.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF2, loVis, loG, lnI
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros2.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"

    GarantirClasse("FormSIGREEQR")
    loF2 = CREATEOBJECT("FormSIGREEQR")
    SET DATASESSION TO loF2.DataSessionId
    loF2.CmdSelTudoClick()
    loF2.this_oRelatorio.this_cCdEmpresa = "001"
    loF2.this_oRelatorio.this_nRfEstoque = 1
    loF2.this_oRelatorio.this_nCalcusto  = 1
    L("Atualizar = " + TRANSFORM(loF2.this_oRelatorio.Atualizar()))

    GarantirClasse("FormSigReEqT")
    loVis = CREATEOBJECT("FormSigReEqT", loF2)
    L("visualizador = " + VARTYPE(loVis))

    L("")
    L("=== GRADES DO VISUALIZADOR (o que o abort do SplitBar destruia) ===")
    FOR lnI = 1 TO loVis.pgf_4c_Paginas.PageCount
        L("Page" + TRANSFORM(lnI) + " caption = [" + loVis.pgf_4c_Paginas.Pages(lnI).Caption + "]")
    ENDFOR
    loG = loVis.pgf_4c_Paginas.Page1.grd_4c_Dados
    L("")
    L("Page1.grd_4c_Dados.RecordSource = [" + loG.RecordSource + "]")
    L("Page1.grd_4c_Dados.ColumnCount  = " + TRANSFORM(loG.ColumnCount))
    FOR lnI = 1 TO MIN(loG.ColumnCount, 10)
        L("   Col" + TRANSFORM(lnI) + " w=" + PADL(EVALUATE("loG.Column" + TRANSFORM(lnI) + ".Width"), 4) + ;
          " src=[" + EVALUATE("loG.Column" + TRANSFORM(lnI) + ".ControlSource") + "]" + ;
          " hdr=[" + EVALUATE("loG.Column" + TRANSFORM(lnI) + ".Header1.Caption") + "]")
    ENDFOR
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
