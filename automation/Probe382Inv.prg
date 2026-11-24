SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcL = "C:\4c\automation\probe382inv.txt"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:" + CHR(92) + "4c" + CHR(92) + "automation" + CHR(92) + "probe382inv_dialogs.txt"
STRTOFILE("FormSigReInv - parametros do screenshot Erro382" + CHR(13)+CHR(10), gcL)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
L382("gnConnHandle=" + TRANSFORM(gnConnHandle))
IF gnConnHandle > 0
    SQLSETPROP(gnConnHandle, "QueryTimeOut", 240)
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)
    IF TYPE("go_4c_Sistema") = "O"
        go_4c_Sistema.cCodEmpresa = "001"
    ENDIF
ENDIF
GarantirClasse("FormSigReInv")

LOCAL loF, loBO, loE, llOk
loF = CREATEOBJECT("FormSigReInv")
L382("form VARTYPE=" + VARTYPE(loF))
IF VARTYPE(loF) = "O"
    SET DATASESSION TO (loF.DataSessionId)
    *-- screenshot: Empresa 001 | Inventario=Proprio | Saldo=Positivo
    *--             Valor=PEPS | ICMS=Nao | Posicao=Atual
    loF.txt_4c_CdEmpresa.Value = "001"
    loF.chk_4c_Inv1.Value   = 1
    loF.chk_4c_Inv2.Value   = 0
    loF.chk_4c_Inv3.Value   = 0
    loF.chk_4c_Saldo1.Value = 1
    loF.chk_4c_Saldo2.Value = 0
    loF.chk_4c_Valor1.Value = 0   && UEPS
    loF.chk_4c_Valor2.Value = 1   && PEPS
    loF.chk_4c_Valor3.Value = 0   && Custo
    loF.chk_4c_Valor4.Value = 0   && Custo Medio
    loF.chk_4c_Valor5.Value = 0   && Venda
    loF.opt_4c_ICMS.Value    = 2  && Nao
    loF.opt_4c_Posicao.Value = 1  && Atual

    loF.FormParaRelatorio()
    loBO = loF.this_oRelatorio
    L382("TipoVal antes=[" + loBO.this_cTipoVal + "] ChkValor2=" + TRANSFORM(loBO.this_nChkValor2))

    llOk = .F.
    TRY
        llOk = loBO.PrepararDados()
    CATCH TO loE
        L382(">>> PrepararDados EXCECAO: " + loE.Message)
    ENDTRY
    L382("PrepararDados=" + TRANSFORM(llOk) + " msg=[" + loBO.ObterMensagemErro() + "]")
    L382("TipoVal=[" + loBO.this_cTipoVal + "] TipoRel=[" + loBO.this_cTipoRel + "]")
    L382("CsCabecalho existe? " + TRANSFORM(USED("CsCabecalho")))
    IF USED("CsCabecalho")
        SELECT CsCabecalho
        GO TOP
        L382("  CsCabecalho RECCOUNT=" + TRANSFORM(RECCOUNT()) + ;
             " UniVals=[" + ALLTRIM(CsCabecalho.UniVals) + "] TotVals=[" + ALLTRIM(CsCabecalho.TotVals) + "]")
    ENDIF
    L382("cursor dados = [" + loBO.this_cCursorDados + "] existe? " + TRANSFORM(USED(loBO.this_cCursorDados)))
    IF USED(loBO.this_cCursorDados)
        SELECT (loBO.this_cCursorDados)
        L382("  RECCOUNT=" + TRANSFORM(RECCOUNT()))
        GO TOP
        TRY
            REPORT FORM (gc_4c_CaminhoReports + "SigReIv1") PREVIEW NOWAIT NOCONSOLE
            L382("  REPORT FORM SigReIv1 OK")
        CATCH TO loE
            L382("  >>> REPORT FORM SigReIv1 FALHOU: " + loE.Message)
        ENDTRY
    ENDIF
    SET DATASESSION TO 1
ENDIF
L382("FIM")
QUIT

PROCEDURE L382(par_c)
    STRTOFILE(par_c + CHR(13)+CHR(10), gcL, 1)
ENDPROC
