SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\origem\correcoes\erro342_tmp\"
gcOut = gcDir + "probe2.txt"
STRTOFILE("", gcOut)
LOCAL loE, loBO, lnI
TRY
    DO ("C:\4c\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"

    GarantirClasse("SIGREEQRBO")
    loBO = CREATEOBJECT("SIGREEQRBO")
    loBO.InicializarSelecao()
    L("Selecao = " + TRANSFORM(IIF(USED("Selecao"), RECCOUNT("Selecao"), -1)) + " linhas")
    IF USED("Selecao")
        SELECT Selecao
        SCAN
            L("   marcas=" + TRANSFORM(Selecao.marcas) + " grupos=[" + Selecao.grupos + "] contas=[" + Selecao.contas + "]")
        ENDSCAN
        *-- simula o botao "Selecionar" (marca tudo)
        REPLACE ALL marcas WITH 1
        GO TOP
    ENDIF

    loBO.this_cCdEmpresa = "001"
    loBO.this_nRfEstoque = 1      && Estoque Atual
    loBO.this_nCalcusto  = 1      && Total
    L("")
    L("=== MODO 1: Estoque Atual ===")
    L("PrepararDados = " + TRANSFORM(loBO.PrepararDados()))
    L("msg           = [" + loBO.ObterMensagemErro() + "]")
    L("csTempoGr     = " + TRANSFORM(IIF(USED("csTempoGr"), RECCOUNT("csTempoGr"), -1)) + " linhas (sintetico)")
    L("CsTempoCp     = " + TRANSFORM(IIF(USED("CsTempoCp"), RECCOUNT("CsTempoCp"), -1)) + " linhas (analitico)")
    IF USED("csTempoGr") AND RECCOUNT("csTempoGr") > 0
        SELECT csTempoGr
        GO TOP
        FOR lnI = 1 TO MIN(6, RECCOUNT("csTempoGr"))
            L("   tipo=" + csTempoGr.Tipos + " gru=[" + csTempoGr.grupos + "] cta=[" + csTempoGr.contas + ;
              "] qtd=" + TRANSFORM(csTempoGr.tqtds) + " venda=" + TRANSFORM(csTempoGr.vlvenda) + ;
              " custo=" + TRANSFORM(csTempoGr.vlcusto))
            SKIP
        ENDFOR
    ENDIF

    L("")
    L("=== MODO 2: Estoque Retroativo em 14/03/2024 ===")
    loBO.this_nRfEstoque = 2
    loBO.this_dDataSaldo = DATE(2024, 3, 14)
    L("PrepararDados = " + TRANSFORM(loBO.PrepararDados()))
    L("msg           = [" + loBO.ObterMensagemErro() + "]")
    L("csTempoGr     = " + TRANSFORM(IIF(USED("csTempoGr"), RECCOUNT("csTempoGr"), -1)) + " linhas")

    L("")
    L("=== VISUALIZADOR: o form filho enxerga os cursores? ===")
    GarantirClasse("SigReEqTBO")
    LOCAL loVB
    loVB = CREATEOBJECT("SigReEqTBO")
    L("this_cCursorGrupos   = [" + loVB.this_cCursorGrupos + "] USED=" + TRANSFORM(USED(loVB.this_cCursorGrupos)))
    L("this_cCursorProdutos = [" + loVB.this_cCursorProdutos + "] USED=" + TRANSFORM(USED(loVB.this_cCursorProdutos)))
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT
PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
