SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL, gb_4c_ModoTeste
gcL = "C:\4c\automation\probe381.txt"
gb_4c_ModoTeste = .T.
STRTOFILE("INICIO" + CHR(13)+CHR(10), gcL)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
L381("gnConnHandle=" + TRANSFORM(gnConnHandle))
IF gnConnHandle > 0
    SQLSETPROP(gnConnHandle, "QueryTimeOut", 120)
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)
    IF TYPE("go_4c_Sistema") = "O"
        go_4c_Sistema.cCodEmpresa = "001"
    ENDIF
ENDIF
GarantirClasse("Formsigreinr")

LOCAL loF, loPg, loBO, llOk, loE
loF = CREATEOBJECT("Formsigreinr", 3)
L381("form VARTYPE=" + VARTYPE(loF))

IF VARTYPE(loF) = "O"
    loPg = loF.pgf_4c_Paginas.Page1
    *-- Parametros do Erro381 (screenshot): tudo "Sim"
    loPg.optg_4c_TipoRel.Value     = 1    && Resumido
    loPg.optg_4c_TipoDif.Value     = 2    && Com Diferenca
    loPg.optg_4c_TipoLeitura.Value = 1    && Leitura
    loPg.optg_4c_TipoAnal.Value    = 1    && Produto
    loPg.optg_4c_TpCusto.Value     = 1    && Sim
    loPg.optg_4c_TpVenda.Value     = 1    && Sim
    loPg.optg_4c_Foto.Value        = 1    && Sim
    loPg.optg_4c_Etiq.Value        = 1    && Sim
    loPg.optg_4c_Obs.Value         = 1    && Sim
    loPg.optg_4c_Ctg.Value         = 1    && Sim (Categoria)
    loPg.optg_4c_Col.Value         = 1    && Sim (Colecao)

    L381("APOS ATRIBUIR: Foto=" + TRANSFORM(loPg.optg_4c_Foto.Value) + ;
         " tipo=" + VARTYPE(loPg.optg_4c_Foto.Value) + ;
         " TpCusto=" + TRANSFORM(loPg.optg_4c_TpCusto.Value) + ;
         " Ctg=" + TRANSFORM(loPg.optg_4c_Ctg.Value) + ;
         " Vis=" + TRANSFORM(loPg.optg_4c_Foto.Visible) + ;
         " Enab=" + TRANSFORM(loPg.optg_4c_Foto.Enabled) + ;
         " btn1Val=" + TRANSFORM(loPg.optg_4c_Foto.Buttons(1).Value) + ;
         " btn2Val=" + TRANSFORM(loPg.optg_4c_Foto.Buttons(2).Value))
    *-- FormParaRelatorio eh PROTECTED (regra #51): chamada externa falha.
    *-- Replica o que ele faz, com os parametros do screenshot do Erro381.
    loBO = loF.this_oRelatorio
    loBO.this_nTipoRel     = 1
    loBO.this_nTipoDif     = 2
    loBO.this_nTipoLeitura = 1
    loBO.this_nTipoAnal    = 1
    loBO.this_cProduto     = ""
    loBO.this_cDsProduto   = ""
    loBO.this_cLocal       = ""
    loBO.this_cDsLocal     = ""
    loBO.this_nBarra       = 0
    loBO.this_nOptTpCusto  = 1
    loBO.this_nOptTpVenda  = 1
    loBO.this_nOptFoto     = 1
    loBO.this_nOptEtiq     = 1
    loBO.this_nOptObs      = 1
    loBO.this_nOptCtg      = 1
    loBO.this_nOptCol      = 1
    L381("TipoRel=" + TRANSFORM(loBO.this_nTipoRel) + " TipoDif=" + TRANSFORM(loBO.this_nTipoDif) + ;
         " Foto=" + TRANSFORM(loBO.this_nOptFoto) + " TpCusto=" + TRANSFORM(loBO.this_nOptTpCusto) + ;
         " TpVenda=" + TRANSFORM(loBO.this_nOptTpVenda) + " Etiq=" + TRANSFORM(loBO.this_nOptEtiq) + ;
         " Obs=" + TRANSFORM(loBO.this_nOptObs) + " Ctg=" + TRANSFORM(loBO.this_nOptCtg) + ;
         " Col=" + TRANSFORM(loBO.this_nOptCol))

    SET DATASESSION TO (loF.DataSessionId)
    TRY
        llOk = loBO.PrepararDados()
        L381("PrepararDados=" + TRANSFORM(llOk) + " msg=[" + loBO.ObterMensagemErro() + "]")
    CATCH TO loE
        L381("PrepararDados EXCECAO: " + loE.Message + " | linha " + TRANSFORM(loE.LineNo) + ;
             " | proc " + loE.Procedure + " | [" + loE.LineContents + "]")
    ENDTRY

    IF USED("CsRelatorio")
        SELECT CsRelatorio
        L381("CsRelatorio RECCOUNT=" + TRANSFORM(RECCOUNT()))
    ELSE
        L381("CsRelatorio NAO EXISTE")
    ENDIF

    *-- renderiza o relatorio como o Visualizar faz
    IF USED("CsRelatorio")
        PUBLIC _TipoDif_INV, _lTrataPeso_INV, _Titulo, _Empresa, _DProduto, _Leitura, _cTelaOrigem
        _cTelaOrigem = "SIGREINR"
        _TipoDif_INV    = loBO.this_nTipoDif
        _lTrataPeso_INV = loBO.this_lTrataPeso
        _Titulo   = loBO.this_cTitulo
        _Empresa  = loBO.this_cEmpresa
        _DProduto = ""
        _Leitura  = ""
        LOCAL lcFrx
        lcFrx = IIF(loBO.this_nOptFoto = 1, "SigReBrf", IIF(loBO.this_lHorizontal, "SigReBlh", "SigReBlr"))
        L381("FRX do ramo = " + lcFrx + " FILE=" + TRANSFORM(FILE(lcFrx + ".frx")))
        SELECT CsRelatorio
        GO TOP
        TRY
            REPORT FORM (lcFrx) PREVIEW NOWAIT NOCONSOLE
            L381("REPORT FORM PREVIEW OK - janelas=" + TRANSFORM(_SCREEN.FormCount))
        CATCH TO loE
            L381("REPORT FORM FALHOU: " + loE.Message)
        ENDTRY
    ENDIF
ENDIF
L381("FIM")
QUIT

PROCEDURE L381(par_c)
    STRTOFILE(par_c + CHR(13)+CHR(10), gcL, 1)
ENDPROC
