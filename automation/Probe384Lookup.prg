SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcL = "C:\4c\automation\probe384lookup.txt"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:" + CHR(92) + "4c" + CHR(92) + "automation" + CHR(92) + "probe384lookup_d.txt"
STRTOFILE("LOOKUP da Operacao (SigCdOpe.Dopes) - Erro384" + CHR(13)+CHR(10), gcL)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
PUBLIC gnConnHandle
gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
IF gnConnHandle > 0
    SQLSETPROP(gnConnHandle, "QueryTimeOut", 120)
    SQLSETPROP(gnConnHandle, "DispWarnings", .F.)
    IF TYPE("go_4c_Sistema") = "O"
        go_4c_Sistema.cCodEmpresa = "001"
    ENDIF
ENDIF
GarantirClasse("Formsigreipe")

*-- Instancia o picker igual o ValidarNmOperacao faz, SEM Show() (modal trava
*-- headless): basta inspecionar o que o Init resolveu e o que o cursor traz.
LOCAL ARRAY laT[4]
laT[1] = "V"
laT[2] = "VENDA"
laT[3] = "C"
laT[4] = "ZZZ"
LOCAL i, loB, loE, lnQ, lcAmostra
FOR i = 1 TO 4
    L384("")
    L384("### digitado = [" + laT[i] + "]")
    loB = .NULL.
    TRY
        loB = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", laT[i], ;
            "Opera" + CHR(231) + CHR(227) + "o")
    CATCH TO loE
        L384("  EXCECAO: " + loE.Message)
    ENDTRY
    IF VARTYPE(loB) <> "O"
        LOOP
    ENDIF
    lnQ = IIF(USED("cursor_4c_BuscaOpe"), RECCOUNT("cursor_4c_BuscaOpe"), -1)
    L384("  this_lAchouRegistro = " + TRANSFORM(loB.this_lAchouRegistro) + ;
         "   (.T. = resolveu sozinho, nao abre lista)")
    L384("  linhas na lista      = " + TRANSFORM(lnQ))
    IF lnQ > 0
        lcAmostra = ""
        SELECT cursor_4c_BuscaOpe
        GO TOP
        SCAN
            lcAmostra = lcAmostra + IIF(EMPTY(lcAmostra), "", " | ") + ALLTRIM(cursor_4c_BuscaOpe.Dopes)
            IF RECNO() >= 6
                EXIT
            ENDIF
        ENDSCAN
        L384("  amostra              = " + lcAmostra)
    ENDIF
    IF USED("cursor_4c_BuscaOpe")
        USE IN cursor_4c_BuscaOpe
    ENDIF
    loB.Release()
ENDFOR
L384("")
L384("FIM")
QUIT

PROCEDURE L384(par_c)
    STRTOFILE(par_c + CHR(13)+CHR(10), gcL, 1)
ENDPROC
