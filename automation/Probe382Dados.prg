SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcL = "C:\4c\automation\probe382dados.txt"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:" + CHR(92) + "4c" + CHR(92) + "automation" + CHR(92) + "probe382_dialogs.txt"
STRTOFILE("TESTE DOS DADOS NOVOS - inventario 3" + CHR(13)+CHR(10), gcL)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
IF gnConnHandle > 0
    SQLSETPROP(gnConnHandle, "QueryTimeOut", 180)
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)
    IF TYPE("go_4c_Sistema") = "O"
        go_4c_Sistema.cCodEmpresa = "001"
    ENDIF
ENDIF
GarantirClasse("Formsigreinr")

LOCAL loF, loBO, llOk, loE, lnMarc

*===================== TipoRel = 4 : Ocorrencias =====================
L382("")
L382("##### TipoRel=4 Ocorrencias (marcando 91/92/93 na grade) #####")
loF = CREATEOBJECT("Formsigreinr", 3)
SET DATASESSION TO (loF.DataSessionId)
loBO = loF.this_oRelatorio
L382("  CsOperacaos existe? " + TRANSFORM(USED("CsOperacaos")))
IF USED("CsOperacaos")
    SELECT CsOperacaos
    L382("  linhas na grade de ocorrencias = " + TRANSFORM(RECCOUNT()))
    lnMarc = 0
    SCAN
        REPLACE Marcas WITH 1
        lnMarc = lnMarc + 1
        L382("    marcado: [" + ALLTRIM(CsOperacaos.Codigos) + "] " + ALLTRIM(CsOperacaos.Descrs))
    ENDSCAN
    L382("  marcados = " + TRANSFORM(lnMarc))
ENDIF
loBO.this_nTipoRel = 4
loBO.this_nTipoDif = 2
loBO.this_nTipoLeitura = 1
loBO.this_nTipoAnal = 1
loBO.this_cProduto = ""
loBO.this_cLocal = ""
loBO.this_nBarra = 0
llOk = loBO.PrepararDados()
L382("  PrepararDados=" + TRANSFORM(llOk) + " msg=[" + loBO.ObterMensagemErro() + "]")
IF USED("CsRelatorio")
    SELECT CsRelatorio
    L382("  CsRelatorio RECCOUNT=" + TRANSFORM(RECCOUNT()))
    GO TOP
    SCAN
        L382("    CBars=" + TRANSFORM(CsRelatorio.CBars) + " Ocors=[" + ALLTRIM(CsRelatorio.Ocors) + ;
             "] Localis=[" + ALLTRIM(CsRelatorio.Localis) + "]")
    ENDSCAN
    GO TOP
    PubRel(loBO)
    TRY
        REPORT FORM SigReBlo PREVIEW NOWAIT NOCONSOLE
        L382("  REPORT FORM SigReBlo OK")
    CATCH TO loE
        L382("  >>> SigReBlo FALHOU: " + loE.Message)
    ENDTRY
ENDIF
SET DATASESSION TO 1

*===================== TipoRel = 2 : Analitico, produto 1116 =====================
L382("")
L382("##### TipoRel=2 Analitico (Produto = 1116) #####")
loF = CREATEOBJECT("Formsigreinr", 3)
SET DATASESSION TO (loF.DataSessionId)
loBO = loF.this_oRelatorio
loBO.this_nTipoRel = 2
loBO.this_nTipoDif = 2
loBO.this_nTipoLeitura = 1
loBO.this_nTipoAnal = 1
loBO.this_cProduto = "1116"
loBO.this_cLocal = ""
loBO.this_nBarra = 0
llOk = loBO.PrepararDados()
L382("  PrepararDados=" + TRANSFORM(llOk) + " msg=[" + loBO.ObterMensagemErro() + "]")
IF USED("CsRelatorio")
    SELECT CsRelatorio
    L382("  CsRelatorio RECCOUNT=" + TRANSFORM(RECCOUNT()))
    GO TOP
    PubRel(loBO)
    TRY
        REPORT FORM SigReBla PREVIEW NOWAIT NOCONSOLE
        L382("  REPORT FORM SigReBla OK")
    CATCH TO loE
        L382("  >>> SigReBla FALHOU: " + loE.Message)
    ENDTRY
ENDIF
SET DATASESSION TO 1

L382("")
L382("FIM")
QUIT

PROCEDURE PubRel(par_oBO)
    PUBLIC _TipoDif_INV, _lTrataPeso_INV, _Titulo, _Empresa, _DProduto, _Leitura, _cTelaOrigem
    PUBLIC _TipoLeitura, _Saldo, _SaldoPs, _TotalnLido, _TotalnEsto, ImpCustos
    _TipoDif_INV    = par_oBO.this_nTipoDif
    _lTrataPeso_INV = par_oBO.this_lTrataPeso
    _Titulo      = par_oBO.this_cTitulo
    _Empresa     = par_oBO.this_cEmpresa
    _DProduto    = ""
    _Leitura     = ""
    _cTelaOrigem = "SIGREINR"
    _TipoLeitura = par_oBO.this_nTipoLeitura
    _Saldo       = par_oBO.this_nSaldo
    _SaldoPs     = par_oBO.this_nSaldoPs
    _TotalnLido  = par_oBO.this_nTotalLido
    _TotalnEsto  = par_oBO.this_nTotalEsto
    ImpCustos    = par_oBO.this_nOptTpCusto
ENDPROC

PROCEDURE L382(par_c)
    STRTOFILE(par_c + CHR(13)+CHR(10), gcL, 1)
ENDPROC
