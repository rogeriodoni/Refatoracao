SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro344_tmp\"
gcOut = gcDir + "probe3.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loPag, lnI
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros3.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"

    GarantirClasse("FormSIGREEQR")
    loF = CREATEOBJECT("FormSIGREEQR")
    SET DATASESSION TO loF.DataSessionId
    loPag = loF.pgf_4c_Paginas.Page1

    L("=== o que o BINDEVENT do botao Visualizar realmente chama ===")
    L("Buttons(1).Caption = [" + loF.cmg_4c_Botoes.Buttons(1).Caption + "]")
    L("handler ligado     = CmgVisualizarClick")
    L("")
    L("=== simula: marcar (v) + preencher empresa + clicar Visualizar ===")
    loF.CmdSelTudoClick()
    loPag.txt_4c_CdEmpresa.Value = "001"
    loPag.txt_4c_DsEmpresa.Value = "MARCELLA BAHIA"
    loPag.obj_4c_OptRfestoque.Value = 1
    loPag.obj_4c_OptCalcusto.Value  = 1

    *-- so a PARTE do handler que processa (o Show() modal travaria o headless)
    L("Atualizar via CmgVisualizarClick seria chamado agora.")
    L("Executando o equivalente sem o Show() modal:")
    loF.FormParaBO()
    L("   Atualizar = " + TRANSFORM(loF.this_oRelatorio.Atualizar()))
    L("   csTempoGr = " + TRANSFORM(IIF(USED("csTempoGr"), RECCOUNT("csTempoGr"), -1)))
    L("   CsTempoCp = " + TRANSFORM(IIF(USED("CsTempoCp"), RECCOUNT("CsTempoCp"), -1)))
    L("")
    L("=== o visualizador que o handler abre ===")
    GarantirClasse("FormSigReEqT")
    LOCAL loVis
    loVis = CREATEOBJECT("FormSigReEqT", loF)
    L("   CREATEOBJECT  = " + VARTYPE(loVis))
    L("   Caption       = [" + loVis.Caption + "]")
    L("   RecordSource  = [" + loVis.pgf_4c_Paginas.Page1.grd_4c_Dados.RecordSource + "]")
    L("   ColumnCount   = " + TRANSFORM(loVis.pgf_4c_Paginas.Page1.grd_4c_Dados.ColumnCount))
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
