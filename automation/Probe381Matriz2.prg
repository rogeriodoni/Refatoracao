SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcL = "C:\4c\automation\probe381matriz2.txt"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:" + CHR(92) + "4c" + CHR(92) + "automation" + CHR(92) + "probe381_dialogs.txt"
STRTOFILE("MATRIZ Erro380/381 - Formsigreinr / Inventario 3" + CHR(13)+CHR(10), gcL)

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

*-- casos: TipoRel, Foto, TpCusto, TpVenda, Etiq, Obs, Ctg, Col, rotulo
LOCAL ARRAY laC[9,9]
laC[1,1]=1  && Resumido, tudo Nao
laC[2,1]=1  && Resumido, tudo Sim
laC[3,1]=1  && Resumido, Foto Sim e resto Nao
laC[4,1]=2  && Analitico
laC[5,1]=3  && Etiqueta
laC[6,1]=4  && Ocorrencia
laC[7,1]=6  && Relacao c/Barra
laC[8,1]=7  && Estoque x Leitura
laC[9,1]=8  && Etiqueta por Estoque
LOCAL i, j
FOR i = 5 TO 9
    FOR j = 2 TO 8
        laC[i,j] = 2
    ENDFOR
ENDFOR
*-- caso 2: tudo Sim
FOR j = 2 TO 8
    laC[2,j] = 1
ENDFOR
*-- caso 3: so Foto Sim
laC[3,2] = 1
laC[1,9]="TipoRel=1 tudo Nao"
laC[2,9]="TipoRel=1 tudo Sim"
laC[3,9]="TipoRel=1 so Foto Sim"
laC[4,9]="TipoRel=2 Analitico"
laC[5,9]="TipoRel=3 Etiqueta"
laC[6,9]="TipoRel=4 Ocorrencia"
laC[7,9]="TipoRel=6 Relacao c/Barra"
laC[8,9]="TipoRel=7 Estoque x Leitura"
laC[9,9]="TipoRel=8 Etiqueta por Estoque"

LOCAL loF, loBO, llOk, loE, lcFrx, lcMsg
FOR i = 5 TO 9
    L381("")
    L381("########## " + laC[i,9] + " ##########")
    loF = .NULL.
    TRY
        loF = CREATEOBJECT("Formsigreinr", 3)
    CATCH TO loE
        L381("  CREATEOBJECT falhou: " + loE.Message)
    ENDTRY
    IF VARTYPE(loF) <> "O"
        LOOP
    ENDIF
    SET DATASESSION TO (loF.DataSessionId)
    loBO = loF.this_oRelatorio
    loBO.this_nTipoRel     = laC[i,1]
    loBO.this_nTipoDif     = 2
    loBO.this_nTipoLeitura = 1
    loBO.this_nTipoAnal    = 1
    loBO.this_cProduto     = ""
    loBO.this_cDsProduto   = ""
    loBO.this_cLocal       = ""
    loBO.this_cDsLocal     = ""
    loBO.this_nBarra       = 0
    loBO.this_nOptFoto     = laC[i,2]
    loBO.this_nOptTpCusto  = laC[i,3]
    loBO.this_nOptTpVenda  = laC[i,4]
    loBO.this_nOptEtiq     = laC[i,5]
    loBO.this_nOptObs      = laC[i,6]
    loBO.this_nOptCtg      = laC[i,7]
    loBO.this_nOptCol      = laC[i,8]

    llOk = .F.
    TRY
        llOk = loBO.PrepararDados()
    CATCH TO loE
        L381("  PrepararDados EXCECAO: " + loE.Message)
    ENDTRY
    lcMsg = loBO.ObterMensagemErro()
    L381("  PrepararDados=" + TRANSFORM(llOk) + IIF(EMPTY(lcMsg), "", "  msg=[" + lcMsg + "]"))

    IF llOk AND USED("CsRelatorio")
        SELECT CsRelatorio
        L381("  CsRelatorio RECCOUNT=" + TRANSFORM(RECCOUNT()))
        PUBLIC _TipoDif_INV, _lTrataPeso_INV, _Titulo, _Empresa, _DProduto, _Leitura, _cTelaOrigem
        _TipoDif_INV    = loBO.this_nTipoDif
        _lTrataPeso_INV = loBO.this_lTrataPeso
        _Titulo   = loBO.this_cTitulo
        _Empresa  = loBO.this_cEmpresa
        _DProduto = ""
        _Leitura  = ""
        _cTelaOrigem = "SIGREINR"
        PUBLIC _TipoLeitura, _Saldo, _SaldoPs, _TotalnLido, _TotalnEsto
        _TipoLeitura = loBO.this_nTipoLeitura
        _Saldo       = loBO.this_nSaldo
        _SaldoPs     = loBO.this_nSaldoPs
        _TotalnLido  = loBO.this_nTotalLido
        _TotalnEsto  = loBO.this_nTotalEsto
        PUBLIC ImpCustos
        ImpCustos    = loBO.this_nOptTpCusto
        lcFrx = ""
        DO CASE
            CASE laC[i,1] = 1
                lcFrx = IIF(loBO.this_nOptFoto = 1, "SigReBrf", IIF(loBO.this_lHorizontal, "SigReBlh", "SigReBlr"))
            CASE laC[i,1] = 2
                lcFrx = "SigReBla"
            CASE laC[i,1] = 3
                lcFrx = IIF(loBO.this_lBalcTrats, "SigReBe2", "SigReBle")
            CASE laC[i,1] = 4
                lcFrx = "SigReBlo"
            CASE laC[i,1] = 6
                lcFrx = "SigReBlb"
            CASE laC[i,1] = 7
                lcFrx = "SigReBel"
            CASE laC[i,1] = 8
                lcFrx = "SigReBl3"
            OTHERWISE
                lcFrx = ""
        ENDCASE
        IF EMPTY(lcFrx)
            L381("  (sem FRX direto neste ramo - nao testado)")
        ELSE
            SELECT CsRelatorio
            GO TOP
            TRY
                REPORT FORM (lcFrx) PREVIEW NOWAIT NOCONSOLE
                L381("  REPORT FORM " + lcFrx + " OK")
            CATCH TO loE
                L381("  >>> REPORT FORM " + lcFrx + " FALHOU: " + loE.Message)
            ENDTRY
        ENDIF
    ENDIF
    SET DATASESSION TO 1
ENDFOR
L381("")
L381("FIM")
QUIT

PROCEDURE L381(par_c)
    STRTOFILE(par_c + CHR(13)+CHR(10), gcL, 1)
ENDPROC
