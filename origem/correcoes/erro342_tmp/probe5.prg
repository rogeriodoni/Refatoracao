SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro342_tmp\"
gcOut = gcDir + "probe5.txt"
STRTOFILE("", gcOut)
LOCAL loE, loForm, loPag, lnI
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros5.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("FormSIGREEQR")
    loForm = CREATEOBJECT("FormSIGREEQR")
    SET DATASESSION TO loForm.DataSessionId
    loPag = loForm.pgf_4c_Paginas.Page1

    *-- usuario clica no (v) Selecionar
    loForm.CmdSelTudoClick()
    loPag.txt_4c_CdEmpresa.Value = "001"
    loForm.this_oRelatorio.this_cCdEmpresa = "001"
    loForm.this_oRelatorio.this_nRfEstoque = 1
    loForm.this_oRelatorio.this_nCalcusto  = 1

    L("=== ESTOQUE ATUAL (apos clicar no (v) Selecionar) ===")
    L("Atualizar = " + TRANSFORM(loForm.this_oRelatorio.Atualizar()))
    L("msg       = [" + loForm.this_oRelatorio.ObterMensagemErro() + "]")
    L("csTempoGr = " + TRANSFORM(IIF(USED("csTempoGr"), RECCOUNT("csTempoGr"), -1)) + " linhas (o que a tela filha mostra na aba Resultado)")
    L("CsTempoCp = " + TRANSFORM(IIF(USED("CsTempoCp"), RECCOUNT("CsTempoCp"), -1)) + " linhas (aba Produtos)")
    IF USED("csTempoGr") AND RECCOUNT("csTempoGr") > 0
        SELECT csTempoGr
        GO TOP
        FOR lnI = 1 TO MIN(8, RECCOUNT("csTempoGr"))
            L("   tipo=" + csTempoGr.Tipos + " gru=[" + ALLTRIM(csTempoGr.grupos) + "] cta=[" + ;
              ALLTRIM(csTempoGr.contas) + "] qtd=" + TRANSFORM(csTempoGr.tqtds) + ;
              " venda=" + TRANSFORM(csTempoGr.vlvenda) + " custo=" + TRANSFORM(csTempoGr.vlcusto))
            SKIP
        ENDFOR
    ENDIF
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
