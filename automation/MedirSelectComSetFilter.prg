*==============================================================================
* MedirSelectComSetFilter.prg - Mede se o SELECT SQL local do VFP9 respeita um
* SET FILTER ativo no alias de origem. Decide se o AtuaTotas legado
* ("Select Sum(Totas) From crGrade Where Marcas") soma o tipo FILTRADO ou a
* composicao INTEIRA - e portanto se o total do rodape do migrado esta fiel.
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXACT ON

LOCAL lcOut, lnCount, lnSumSel, lnSumScan
lcOut = "=== SELECT SQL local x SET FILTER ativo ===" + CHR(13) + CHR(10)

CREATE CURSOR crTeste (Marcas L, Totas N(11,3), Tipos C(20))
INSERT INTO crTeste (Marcas, Totas, Tipos) VALUES (.T., 10, PADR("TIPO A", 20))
INSERT INTO crTeste (Marcas, Totas, Tipos) VALUES (.F., 20, PADR("TIPO A", 20))
INSERT INTO crTeste (Marcas, Totas, Tipos) VALUES (.T., 40, PADR("TIPO B", 20))
INSERT INTO crTeste (Marcas, Totas, Tipos) VALUES (.T., 50, PADR("TIPO B", 20))
INSERT INTO crTeste (Marcas, Totas, Tipos) VALUES (.F., 60, PADR("TIPO B", 20))

SELECT crTeste
SET FILTER TO Tipos == "TIPO B              "
GO TOP

COUNT TO lnCount
lcOut = lcOut + "COUNT navegacional (respeita filtro) = " + TRANSFORM(lnCount) + ;
        "  (esperado 3)" + CHR(13) + CHR(10)

*-- SCAN tambem eh navegacional
lnSumScan = 0
SELECT crTeste
SCAN FOR Marcas
    lnSumScan = lnSumScan + crTeste.Totas
ENDSCAN
lcOut = lcOut + "SCAN FOR Marcas                      = " + TRANSFORM(lnSumScan) + ;
        "  (90 = so TIPO B / 100 = tudo)" + CHR(13) + CHR(10)

*-- o construto do legado / do BO
SELECT SUM(Totas) AS SomaTotas FROM crTeste WHERE Marcas = .T. INTO CURSOR crSoma
lnSumSel = NVL(crSoma.SomaTotas, 0)
lcOut = lcOut + "SELECT SUM(..) WHERE Marcas          = " + TRANSFORM(lnSumSel) + ;
        "  (90 = RESPEITA o filtro / 100 = IGNORA)" + CHR(13) + CHR(10)
USE IN crSoma

*-- variante com Group By 1, exatamente como o AtuaTotas legado
SELECT " " AS Agrupar, SUM(Totas) AS Totas FROM crTeste WHERE Marcas ;
    GROUP BY 1 INTO CURSOR crSoma2
lcOut = lcOut + "SELECT .. GROUP BY 1 (forma legado)  = " + TRANSFORM(NVL(crSoma2.Totas, 0)) + ;
        CHR(13) + CHR(10)
USE IN crSoma2

lcOut = lcOut + CHR(13) + CHR(10) + "CONCLUSAO: o SELECT SQL local " + ;
        IIF(lnSumSel = 90, "RESPEITA", "IGNORA") + " o SET FILTER do alias." + CHR(13) + CHR(10)

= STRTOFILE(lcOut, "C:\4c\automation\medir_select_setfilter.txt")
QUIT
