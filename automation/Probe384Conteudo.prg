SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gcL, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gcL = "C:\4c\automation\probe384conteudo.txt"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:" + CHR(92) + "4c" + CHR(92) + "automation" + CHR(92) + "probe384cont_d.txt"
STRTOFILE("CONTEUDO DA ETIQUETA PROVISORIA - avaliando as expressoes do .lbx" + CHR(13)+CHR(10), gcL)

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

LOCAL loF, loPg, loE
loF = CREATEOBJECT("Formsigreipe")
SET DATASESSION TO (loF.DataSessionId)
loPg = loF.pgf_4c_Paginas.Page1
loPg.txt_4c__nm_operacao.Value = "VENDA"
loPg.txt_4c__dt_inicial.Value  = DATE(2000, 1, 1)
loPg.txt_4c__dt_final.Value    = DATE(2030, 12, 31)
loPg.obj_4c_Opt_conta.Value    = 2
loF.TxtDtFinalLostFocus()
SELECT cursor_4c_Operacoes
REPLACE ALL Marcas WITH 1
GO TOP

*-- Pais = Sim, Codigo = Nao (para provar que o Print When responde)
loPg.obj_4c_OptPais.Value   = 1
loPg.obj_4c_OptCodigo.Value = 2
loPg.obj_4c_OptProper.Value = 1   && Iniciais em maiusculo
loF.Processamento()

IF !USED("Relacao") OR RECCOUNT("Relacao") = 0
    LC("Relacao vazio - nada a avaliar")
    LC("FIM")
    QUIT
ENDIF
LC("Relacao RECCOUNT = " + TRANSFORM(RECCOUNT("Relacao")))
LC("CsCabecalho: llImpPais=" + TRANSFORM(CsCabecalho.llImpPais) + ;
   "  llImpCodigos=" + TRANSFORM(CsCabecalho.llImpCodigos) + "   (Pais=Sim, Codigo=Nao)")
LC("")

*-- le as expressoes direto do .lbx e avalia contra o 1o registro
SELECT Relacao
GO TOP
USE "C:\4c\projeto\app\reports\SigMld2.lbx" IN 0 ALIAS lbxDef SHARED
SELECT lbxDef
LOCAL lnN, lcExpr, lcSup, luVal, llImp
lnN = 0
SCAN FOR lbxDef.objtype = 8
    lnN    = lnN + 1
    lcExpr = ALLTRIM(lbxDef.expr)
    lcSup  = ALLTRIM(lbxDef.supexpr)
    SELECT Relacao
    llImp = .T.
    IF !EMPTY(lcSup)
        TRY
            llImp = EVALUATE(lcSup)
        CATCH TO loE
            llImp = .NULL.
        ENDTRY
    ENDIF
    TRY
        luVal = EVALUATE(lcExpr)
    CATCH TO loE
        luVal = "<<ERRO: " + loE.Message + ">>"
    ENDTRY
    LC("linha " + TRANSFORM(lnN) + "  imprime=" + TRANSFORM(llImp) + ;
       "  ->  [" + TRANSFORM(luVal) + "]")
    SELECT lbxDef
ENDSCAN
USE IN lbxDef
SET DATASESSION TO 1
LC("")
LC("FIM")
QUIT

PROCEDURE LC(par_c)
    STRTOFILE(par_c + CHR(13)+CHR(10), gcL, 1)
ENDPROC
