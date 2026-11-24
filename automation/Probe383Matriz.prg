SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcL = "C:\4c\automation\probe383matriz.txt"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:" + CHR(92) + "4c" + CHR(92) + "automation" + CHR(92) + "probe383m_dialogs.txt"
STRTOFILE("MATRIZ CAMINHO REAL (FormParaRelatorio + PrepararDados + Visualizar)" + CHR(13)+CHR(10), gcL)

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

LOCAL ARRAY laC[8,5]
laC[1,1]=1
laC[2,1]=1
laC[3,1]=2
laC[4,1]=3
laC[5,1]=4
laC[6,1]=6
laC[7,1]=7
laC[8,1]=8
LOCAL i
FOR i = 1 TO 8
    laC[i,2] = 2
    laC[i,3] = 2
    laC[i,4] = ""
ENDFOR
laC[2,2] = 1
laC[2,3] = 1
laC[3,4] = "1116"
laC[1,5]="TipoRel=1 Resumido (tudo Nao)"
laC[2,5]="TipoRel=1 Resumido (tudo Sim, Foto Sim)"
laC[3,5]="TipoRel=2 Analitico (Produto 1116)"
laC[4,5]="TipoRel=3 Etiqueta"
laC[5,5]="TipoRel=4 Ocorrencia (grade marcada)"
laC[6,5]="TipoRel=6 Relacao c/Barra"
laC[7,5]="TipoRel=7 Estoque x Leitura"
laC[8,5]="TipoRel=8 Etiqueta por Estoque"

LOCAL loF, loPg, loE, lcAntes, lcDepois, lcArqD, llOk
lcArqD = gc_4c_ArquivoErroTeste

FOR i = 1 TO 8
    L383("")
    L383("########## " + laC[i,5] + " ##########")
    lcAntes = IIF(FILE(lcArqD), FILETOSTR(lcArqD), "")
    loF = .NULL.
    TRY
        loF = CREATEOBJECT("FormTeste383", 3)
    CATCH TO loE
        L383("  CREATEOBJECT falhou: " + loE.Message)
    ENDTRY
    IF VARTYPE(loF) <> "O"
        LOOP
    ENDIF
    SET DATASESSION TO (loF.DataSessionId)
    loPg = loF.pgf_4c_Paginas.Page1
    loPg.optg_4c_TipoRel.Value     = laC[i,1]
    loPg.optg_4c_TipoDif.Value     = 2
    loPg.optg_4c_TipoLeitura.Value = 1
    loPg.optg_4c_TipoAnal.Value    = 1
    loPg.optg_4c_Foto.Value        = laC[i,2]
    loPg.optg_4c_TpCusto.Value     = laC[i,3]
    loPg.optg_4c_TpVenda.Value     = laC[i,3]
    loPg.optg_4c_Etiq.Value        = laC[i,3]
    loPg.optg_4c_Obs.Value         = laC[i,3]
    loPg.optg_4c_Ctg.Value         = laC[i,3]
    loPg.optg_4c_Col.Value         = laC[i,3]
    loPg.txt_4c_CodProduto.Value   = laC[i,4]
    IF laC[i,1] = 4 AND USED("CsOperacaos")
        SELECT CsOperacaos
        SCAN
            REPLACE Marcas WITH 1
        ENDSCAN
        GO TOP
    ENDIF

    *-- 1) FormParaRelatorio REAL (via subclasse, por ser PROTECTED)
    TRY
        loF.TesteFormParaRelatorio()
        L383("  FormParaRelatorio OK -> TipoRel=" + TRANSFORM(loF.this_oRelatorio.this_nTipoRel) + ;
             " Foto=" + TRANSFORM(loF.this_oRelatorio.this_nOptFoto) + ;
             " Produto=[" + ALLTRIM(loF.this_oRelatorio.this_cProduto) + "]")
    CATCH TO loE
        L383("  >>> FormParaRelatorio EXCECAO: " + loE.Message)
    ENDTRY

    *-- 2) PrepararDados REAL
    llOk = .F.
    TRY
        llOk = loF.this_oRelatorio.PrepararDados()
    CATCH TO loE
        L383("  >>> PrepararDados EXCECAO: " + loE.Message)
    ENDTRY
    L383("  PrepararDados=" + TRANSFORM(llOk) + " msg=[" + loF.this_oRelatorio.ObterMensagemErro() + "]")
    IF USED("CsRelatorio")
        SELECT CsRelatorio
        L383("  CsRelatorio RECCOUNT=" + TRANSFORM(RECCOUNT()))
    ENDIF

    *-- 3) Visualizar REAL (preview em NOWAIT para nao bloquear)
    IF llOk
        TRY
            loF.TesteVisualizarNoWait()
        CATCH TO loE
            L383("  >>> Visualizar EXCECAO: " + loE.Message)
        ENDTRY
    ENDIF

    lcDepois = IIF(FILE(lcArqD), FILETOSTR(lcArqD), "")
    IF LEN(lcDepois) > LEN(lcAntes)
        L383("  >>> ERRO EXIBIDO: " + STRTRAN(STRTRAN(SUBSTR(lcDepois, LEN(lcAntes) + 1), CHR(13), " "), CHR(10), ""))
    ELSE
        L383("  OK - nenhum erro exibido")
    ENDIF
    SET DATASESSION TO 1
ENDFOR
L383("")
L383("FIM")
QUIT

PROCEDURE L383(par_c)
    STRTOFILE(par_c + CHR(13)+CHR(10), gcL, 1)
ENDPROC

*-- Subclasse: so para alcancar o FormParaRelatorio PROTECTED e trocar o
*-- PREVIEW bloqueante por NOWAIT, sem tocar no codigo de producao.
DEFINE CLASS FormTeste383 AS Formsigreinr
    PROCEDURE TesteFormParaRelatorio()
        THIS.FormParaRelatorio()
    ENDPROC
    PROCEDURE TesteVisualizarNoWait()
        LOCAL loBO, lcFrx, loE2
        loBO = THIS.this_oRelatorio
        PUBLIC _TipoDif_INV, _lTrataPeso_INV, _Titulo, _Empresa, _DProduto, _Leitura, _cTelaOrigem
        PUBLIC _TipoLeitura, _Saldo, _SaldoPs, _TotalnLido, _TotalnEsto, ImpCustos
        _TipoDif_INV    = loBO.this_nTipoDif
        _lTrataPeso_INV = loBO.this_lTrataPeso
        _Titulo      = loBO.this_cTitulo
        _Empresa     = loBO.this_cEmpresa
        _DProduto    = ""
        _Leitura     = ""
        _cTelaOrigem = "SIGREINR"
        _TipoLeitura = loBO.this_nTipoLeitura
        _Saldo       = loBO.this_nSaldo
        _SaldoPs     = loBO.this_nSaldoPs
        _TotalnLido  = loBO.this_nTotalLido
        _TotalnEsto  = loBO.this_nTotalEsto
        ImpCustos    = loBO.this_nOptTpCusto
        DO CASE
            CASE loBO.this_nTipoRel = 1
                lcFrx = IIF(loBO.this_nOptFoto = 1, "SigReBrf", IIF(loBO.this_lHorizontal, "SigReBlh", "SigReBlr"))
            CASE loBO.this_nTipoRel = 2
                lcFrx = "SigReBla"
            CASE loBO.this_nTipoRel = 3
                lcFrx = IIF(loBO.this_lBalcTrats, "SigReBe2", "SigReBle")
            CASE loBO.this_nTipoRel = 4
                lcFrx = "SigReBlo"
            CASE loBO.this_nTipoRel = 6
                lcFrx = "SigReBlb"
            CASE loBO.this_nTipoRel = 7
                lcFrx = "SigReBel"
            CASE loBO.this_nTipoRel = 8
                lcFrx = "SigReBl3"
            OTHERWISE
                lcFrx = ""
        ENDCASE
        IF EMPTY(lcFrx)
            RETURN
        ENDIF
        SELECT CsRelatorio
        GO TOP
        TRY
            REPORT FORM (lcFrx) PREVIEW NOWAIT NOCONSOLE
            L383("  REPORT FORM " + lcFrx + " OK")
        CATCH TO loE2
            L383("  >>> REPORT FORM " + lcFrx + " FALHOU: " + loE2.Message)
        ENDTRY
    ENDPROC
ENDDEFINE
