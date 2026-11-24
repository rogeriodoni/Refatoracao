SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXCLUSIVE OFF

LOCAL lcSaida, lcTexto, lcAlias, lnLinhas, luVal, lcCompo

lcSaida = "C:\4c\automation\tmp813\probe813_saida.txt"
lcTexto = ""

*-- cursores sinteticos imitando os que o form pai prepara.
*-- SigCdOpe: flags numeric(1,0) + Cmoes char(3)
CREATE CURSOR crSigCdOpe (ChkQtds N(1), PesoVts N(1), PrecoVts N(1), ;
                          HabServs N(1), TotCompos N(1), Opers N(1), Cmoes C(3))
INSERT INTO crSigCdOpe (ChkQtds, PesoVts, PrecoVts, HabServs, TotCompos, Opers, Cmoes) ;
       VALUES (6, 1, 1, 1, 1, 3, "USD")

*-- SigOpCdc: so DocQtd2s (+ HabServs, que existe nas DUAS tabelas)
CREATE CURSOR crSigOpCdc (DocQtd2s C(12), HabServs N(1))
INSERT INTO crSigOpCdc (DocQtd2s, HabServs) VALUES ("PECAS", 0)

*-- SigOpCdd: so MtCubs
CREATE CURSOR crSigOpCdd (MtCubs N(4))
INSERT INTO crSigOpCdd (MtCubs) VALUES (7)

*-- itens, para o agrupamento
CREATE CURSOR crTpmMvItn (Cpros C(10), Qtds N(11,2))
INSERT INTO crTpmMvItn (Cpros, Qtds) VALUES ("P001", 3)
INSERT INTO crTpmMvItn (Cpros, Qtds) VALUES ("P001", 2)
INSERT INTO crTpmMvItn (Cpros, Qtds) VALUES ("P002", 5)
INSERT INTO crTpmMvItn (Cpros, Qtds) VALUES ("", 9)

*-- 1) TYPE(alias + ".coluna") distingue coluna presente de ausente?
lcTexto = lcTexto + "1) TYPE por nome montado" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   crSigCdOpe.ChkQtds  = [" + TYPE("crSigCdOpe.ChkQtds") + "]  (esperado N)" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   crSigCdOpe.Cmoes    = [" + TYPE("crSigCdOpe.Cmoes") + "]  (esperado C)" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   crSigCdOpe.MtCubs   = [" + TYPE("crSigCdOpe.MtCubs") + "]  (esperado U = ausente)" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   crSigOpCdd.MtCubs   = [" + TYPE("crSigOpCdd.MtCubs") + "]  (esperado N)" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   crSigOpCdc.DocQtd2s = [" + TYPE("crSigOpCdc.DocQtd2s") + "]  (esperado C)" + CHR(13) + CHR(10)

*-- 2) EVALUATE por nome montado devolve o valor?
lcTexto = lcTexto + "2) EVALUATE por nome montado" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   ChkQtds  = [" + TRANSFORM(EVALUATE("crSigCdOpe.ChkQtds")) + "] (esperado 6)" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   Opers    = [" + TRANSFORM(EVALUATE("crSigCdOpe.Opers")) + "] (esperado 3)" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   Cmoes    = [" + ALLTRIM(EVALUATE("crSigCdOpe.Cmoes")) + "] (esperado USD)" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   MtCubs   = [" + TRANSFORM(EVALUATE("crSigOpCdd.MtCubs")) + "] (esperado 7)" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   DocQtd2s = [" + ALLTRIM(EVALUATE("crSigOpCdc.DocQtd2s")) + "] (esperado PECAS)" + CHR(13) + CHR(10)

*-- 3) SELECT (variavel) + INTO CURSOR (variavel) READWRITE
lcAlias = "cursor_4c_CompoAgrupado"
lcTexto = lcTexto + "3) INTO CURSOR (variavel) READWRITE" + CHR(13) + CHR(10)
SELECT Cpros, SUM(Qtds) AS Qtds ;
    FROM crTpmMvItn ;
    WHERE !EMPTY(Cpros) ;
    GROUP BY Cpros ;
    INTO CURSOR (lcAlias) READWRITE
lcTexto = lcTexto + "   USED(lcAlias) = [" + IIF(USED(lcAlias), "SIM", "NAO") + "] (esperado SIM)" + CHR(13) + CHR(10)

*-- 4) SELECT (variavel) + COUNT TO + GO TOP + leitura de campo SEM qualificar
SELECT (lcAlias)
COUNT TO lnLinhas
GO TOP
lcTexto = lcTexto + "4) COUNT TO / GO TOP / campo sem qualificar" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   linhas  = [" + TRANSFORM(lnLinhas) + "] (esperado 2)" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   ALIAS() = [" + ALIAS() + "]" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   Cpros   = [" + ALLTRIM(Cpros) + "] (esperado P001)" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   Qtds    = [" + TRANSFORM(Qtds) + "] (esperado 5.00)" + CHR(13) + CHR(10)

*-- 5) o SCAN de Inserir() monta uma linha de INSERT por registro?
lcCompo = ""
SELECT (lcAlias)
SCAN
    lcCompo = lcCompo + ALLTRIM(Cpros) + "=" + ALLTRIM(TRANSFORM(Qtds)) + ";"
ENDSCAN
lcTexto = lcTexto + "5) SCAN com campo sem qualificar = [" + lcCompo + "]" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   (esperado P001=5.00;P002=5.00;)" + CHR(13) + CHR(10)

*-- 6) USE IN (variavel) fecha o alias?
USE IN (lcAlias)
lcTexto = lcTexto + "6) USE IN (variavel): USED = [" + IIF(USED(lcAlias), "SIM", "NAO") + "] (esperado NAO)" + CHR(13) + CHR(10)

*-- 7) a logica de LerFlagNumerica com coluna NULL
SET NULL ON
CREATE CURSOR crNulo (Flag N(1) NULL)
SET NULL OFF
INSERT INTO crNulo (Flag) VALUES (.NULL.)
luVal = EVALUATE("crNulo.Flag")
lcTexto = lcTexto + "7) coluna NULL" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   ISNULL   = [" + IIF(ISNULL(luVal), "SIM", "NAO") + "] (esperado SIM)" + CHR(13) + CHR(10)
lcTexto = lcTexto + "   VARTYPE  = [" + VARTYPE(luVal) + "] (X quando NULL - por isso ISNULL vem ANTES no DO CASE)" + CHR(13) + CHR(10)

*-- 8) comparar Logico com numero realmente estoura? (justifica o VARTYPE)
lcTexto = lcTexto + "8) comparar .T. com 1: "
TRY
    IF .T. = 1
        lcTexto = lcTexto + "passou sem erro"
    ELSE
        lcTexto = lcTexto + "passou sem erro (falso)"
    ENDIF
CATCH TO loErro
    lcTexto = lcTexto + "ERRO [" + loErro.Message + "] -> VARTYPE antes de comparar e obrigatorio"
ENDTRY
lcTexto = lcTexto + CHR(13) + CHR(10)

lcTexto = lcTexto + CHR(13) + CHR(10) + "PROBE CONCLUIDO" + CHR(13) + CHR(10)

STRTOFILE(lcTexto, lcSaida)

QUIT
