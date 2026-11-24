SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL, gb_4c_ModoTeste
gcL = "C:\4c\automation\probe380rel.txt"
gb_4c_ModoTeste = .T.
STRTOFILE("INICIO" + CHR(13)+CHR(10), gcL)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
L380("ambiente OK  PATH tem reports? " + TRANSFORM("REPORTS" $ UPPER(SET("PATH"))))

*-- conexao: ConectarBancoDados mora em main.prg, que nao da para rodar aqui
*-- (abre menu e READ EVENTS). Replica o essencial.
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
L380("gnConnHandle=" + TRANSFORM(gnConnHandle))
IF gnConnHandle > 0
    SQLSETPROP(gnConnHandle, "QueryTimeOut", 60)
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)
    *-- CarregarEmpresa() tambem mora em main.prg; o BO so precisa do codigo
    IF TYPE("go_4c_Sistema") = "O"
        go_4c_Sistema.cCodEmpresa = "001"
    ENDIF
ENDIF
GarantirClasse("Formsigreinr")

LOCAL loF, loBO, llOk
loF = CREATEOBJECT("Formsigreinr", 3)
L380("form VARTYPE=" + VARTYPE(loF))

IF VARTYPE(loF) = "O"
    loF.FormParaRelatorio()
    loBO = loF.this_oRelatorio
    L380("TipoRel=" + TRANSFORM(loBO.this_nTipoRel) + ;
         " TipoDif=" + TRANSFORM(loBO.this_nTipoDif) + ;
         " OptFoto=" + TRANSFORM(loBO.this_nOptFoto) + ;
         " NumBal="  + TRANSFORM(loBO.this_nNumBal))
    L380("ValidarFiltros=" + TRANSFORM(loBO.ValidarFiltros()) + " msg=[" + loBO.ObterMensagemErro() + "]")

    SET DATASESSION TO (loF.DataSessionId)
    llOk = loBO.PrepararDados()
    L380("PrepararDados=" + TRANSFORM(llOk) + " msg=[" + loBO.ObterMensagemErro() + "]")
    IF USED("CsRelatorio")
        SELECT CsRelatorio
        L380("CsRelatorio RECCOUNT=" + TRANSFORM(RECCOUNT()) + " FCOUNT=" + TRANSFORM(FCOUNT()))
    ELSE
        L380("CsRelatorio NAO EXISTE")
    ENDIF
    L380("this_lHorizontal=" + TRANSFORM(loBO.this_lHorizontal))

    *-- qual FRX o ramo TipoRel=1 usaria
    LOCAL lcFrx
    lcFrx = IIF(loBO.this_nOptFoto = 1, "SigReBrf", IIF(loBO.this_lHorizontal, "SigReBlh", "SigReBlr"))
        L380("DataSessionId=" + TRANSFORM(loF.DataSessionId) + " sessao atual=" + TRANSFORM(SET("DATASESSION")))
    L380("FRX do ramo = " + lcFrx + "  FILE(bare)=" + TRANSFORM(FILE(lcFrx + ".frx")))

    *-- prova que o FRX carrega e processa os dados: saida ASCII em arquivo
    SELECT CsRelatorio
    GO TOP
    PUBLIC _TipoDif_INV, _lTrataPeso_INV
    _TipoDif_INV    = loBO.this_nTipoDif
    _lTrataPeso_INV = loBO.this_lTrataPeso
    *-- mesmas publics que sigreinrBO.Visualizar() declara
    PUBLIC _Titulo, _Empresa, _DProduto, _Leitura
    _Titulo   = loBO.this_cTitulo
    _Empresa  = loBO.this_cEmpresa
    _DProduto = ""
    _Leitura  = ""
    L380("_Titulo=[" + _Titulo + "] _Empresa=[" + _Empresa + "]")
    TRY
        REPORT FORM (lcFrx) PREVIEW NOWAIT NOCONSOLE
        L380("REPORT FORM PREVIEW OK - janelas abertas=" + TRANSFORM(_SCREEN.FormCount))
    CATCH TO loE
        L380("REPORT FORM FALHOU: " + loE.Message)
    ENDTRY
ENDIF
L380("FIM")
QUIT

PROCEDURE L380(par_c)
    STRTOFILE(par_c + CHR(13)+CHR(10), gcL, 1)
ENDPROC
