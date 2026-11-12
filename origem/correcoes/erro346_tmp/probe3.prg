SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro346_tmp\"
gcOut = gcDir + "probe3.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, loPag
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros3.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("FormSigReEsp")
    loF = CREATEOBJECT("FormSigReEsp")
    L("form = " + VARTYPE(loF))
    SET DATASESSION TO loF.DataSessionId
    loPag = loF.pgf_4c_Paginas.Page1

    L("")
    L("=== estado inicial ===")
    L("CdTpOpe=[" + TRANSFORM(loPag.txt_4c_CdTpOpe.Value) + "]  DsTpOpe=[" + ALLTRIM(loPag.txt_4c_DsTpOpe.Value) + "]")

    L("")
    L("=== CASO 1: usuario digita 7 no Tipo e sai do campo ===")
    loPag.txt_4c_CdTpOpe.Value = 7
    loF.CdTpOpeLostFocus()
    L("CdTpOpe=[" + TRANSFORM(loPag.txt_4c_CdTpOpe.Value) + "]  DsTpOpe=[" + ALLTRIM(loPag.txt_4c_DsTpOpe.Value) + "]")

    L("")
    L("=== CASO 2: usuario digita 4 ===")
    loPag.txt_4c_CdTpOpe.Value = 4
    loF.CdTpOpeLostFocus()
    L("CdTpOpe=[" + TRANSFORM(loPag.txt_4c_CdTpOpe.Value) + "]  DsTpOpe=[" + ALLTRIM(loPag.txt_4c_DsTpOpe.Value) + "]")

    L("")
    L("=== CASO 3: usuario apaga o codigo (volta ao default) ===")
    loPag.txt_4c_CdTpOpe.Value = 0
    loF.CdTpOpeLostFocus()
    L("CdTpOpe=[" + TRANSFORM(loPag.txt_4c_CdTpOpe.Value) + "]  DsTpOpe=[" + ALLTRIM(loPag.txt_4c_DsTpOpe.Value) + "]")

    L("")
    L("=== CASO 4: usuario digita a DESCRICAO 'VENDAS' e sai ===")
    loPag.txt_4c_DsTpOpe.Value = "VENDAS"
    loF.DsTpOpeLostFocus()
    L("CdTpOpe=[" + TRANSFORM(loPag.txt_4c_CdTpOpe.Value) + "]  DsTpOpe=[" + ALLTRIM(loPag.txt_4c_DsTpOpe.Value) + "]")

    L("")
    L("=== CASO 5: descricao 'TODOS' zera o codigo (nao abre browse) ===")
    loPag.txt_4c_DsTpOpe.Value = "TODOS"
    loF.DsTpOpeLostFocus()
    L("CdTpOpe=[" + TRANSFORM(loPag.txt_4c_CdTpOpe.Value) + "]  DsTpOpe=[" + ALLTRIM(loPag.txt_4c_DsTpOpe.Value) + "]")

    L("")
    L("=== CASO 6: guarda de reentrancia nao fica travada ===")
    L("this_lEmLookup apos tudo = " + TRANSFORM(loF.this_lEmLookup) + "  (tem de ser .F.)")

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
