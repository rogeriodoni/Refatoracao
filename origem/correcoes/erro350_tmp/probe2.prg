SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro350_tmp\"
gcOut = gcDir + "probe2.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loB
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros2.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("Formsigreeun")
    loF = CREATEOBJECT("Formsigreeun")
    SET DATASESSION TO loF.DataSessionId
    loB = loF.this_oRelatorio

    L("=== valores que a TELA mostra (como na imagem) ===")
    LOCAL loPg
    loPg = loF.pgf_4c_Paginas.Page1
    L("Grupo   =[" + TRANSFORM(loPg.txt_4c_CdGrestoque.Value) + "] [" + TRANSFORM(loPg.txt_4c_DsGrestoque.Value) + "]")
    L("Conta   =[" + TRANSFORM(loPg.txt_4c_CdEstoque.Value) + "] [" + TRANSFORM(loPg.txt_4c_DsEstoque.Value) + "]")
    L("Unidade =[" + TRANSFORM(loPg.txt_4c_CdUnidade.Value) + "] [" + TRANSFORM(loPg.txt_4c_DsUnidade.Value) + "]")
    L("Data    =[" + TRANSFORM(loPg.txt_4c_Data.Value) + "]")
    L("Moeda   =[" + TRANSFORM(loPg.txt_4c_CdMoeda.Value) + "] [" + TRANSFORM(loPg.txt_4c_DsMoeda.Value) + "]")
    L("DtCotac =[" + TRANSFORM(loPg.txt_4c_DtCotacao.Value) + "]")

    L("")
    L("=== clique em Visualizar (handler REAL) ===")
    TRY
        loF.BtnVisualizarClick()
        L("voltou do handler")
    CATCH TO loE
        L("EXCECAO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + ;
          " " + loE.Message + " | proc=" + loE.Procedure)
    ENDTRY
    L("dbRelatorio USED=" + TRANSFORM(USED("dbRelatorio")) + ;
      "  linhas=" + TRANSFORM(IIF(USED("dbRelatorio"), RECCOUNT("dbRelatorio"), -1)))
    L("msg do BO = [" + loB.ObterMensagemErro() + "]")
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
