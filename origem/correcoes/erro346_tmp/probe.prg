SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcDir = "C:\4c\origem\correcoes\erro346_tmp\"
gcOut = gcDir + "probe.txt"
STRTOFILE("", gcOut)
LOCAL loE, loF, lnI
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = gcDir + "erros.txt"
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"

    GarantirClasse("FormSigReEsp")
    loF = CREATEOBJECT("FormSigReEsp")
    L("form = " + VARTYPE(loF))
    SET DATASESSION TO loF.DataSessionId

    Cen(loF, 0,  1, "Tipo=0 OUTROS (o default TODOS) + Lancamento")
    Cen(loF, 7,  1, "Tipo=7 COMPRAS + Lancamento")
    Cen(loF, 4,  1, "Tipo=4 VENDAS  + Lancamento")
    Cen(loF, 7,  3, "Tipo=7 COMPRAS + Ult.Alteracao")
    Cen(loF, 7,  4, "Tipo=7 COMPRAS + Fechamento")

    L("")
    L("erros: [" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]")
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT

PROCEDURE Cen(par_oF, par_nTipo, par_nPeriodo, par_cDesc)
    LOCAL loB, llOk, loErr
    TRY
        loB = par_oF.this_oRelatorio
        WITH loB
            .this_dDtInicial  = DATE(2000, 1, 1)
            .this_dDtFinal    = DATE(2026, 11, 11)
            .this_nPeriodo    = par_nPeriodo
            .this_nCdTpOpe    = par_nTipo
            .this_cNmOperacao = ""
            .this_nNumero     = 0
            .this_cCdConta    = ""
            .this_cCdVendedor = ""
            .this_cCidade     = ""
            .this_cEstado     = ""
            .this_nFiltro     = 3
            .this_nAnaSin     = 2
            .this_lIndus      = .F.
        ENDWITH
        llOk = loB.PrepararDados()
        L(PADR(par_cDesc, 46) + " -> " + TRANSFORM(llOk) + ;
          "  csRelatorio=" + TRANSFORM(IIF(USED("csRelatorio"), RECCOUNT("csRelatorio"), -1)) + ;
          "  msg=[" + loB.ObterMensagemErro() + "]")
    CATCH TO loErr
        L(PADR(par_cDesc, 46) + " -> ERRO " + TRANSFORM(loErr.ErrorNo) + " linha " + ;
          TRANSFORM(loErr.LineNo) + " " + loErr.Message)
    ENDTRY
ENDPROC

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
