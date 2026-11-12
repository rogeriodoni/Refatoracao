*==============================================================================
* Mede o efeito de SET EXACT sobre "SET KEY TO <valor parcial>" num indice
* COMPOSTO (Tipos + Str(Ordem,3) + Cpros) - a mesma chave do csGrade do
* SIGCDPRO. Pergunta: com EXACT ON o filtro do legado ainda casa?
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE OUT "C:\4c\automation\_tmp_medirsetkey777.txt"

LOCAL loc_nV, loc_cTxt

CREATE CURSOR CsGrade (Tipos c(1), Ordem n(3), Cpros c(14), Valos n(12,3))
INSERT INTO CsGrade VALUES ("V", 1, "PROD001", 50.000)
INSERT INTO CsGrade VALUES ("V", 2, "PROD002", 200.000)
INSERT INTO CsGrade VALUES ("V", 3, "PROD003", 0.000)
INSERT INTO CsGrade VALUES ("C", 1, "PROD004", 80.000)
INSERT INTO CsGrade VALUES ("C", 2, "PROD005", 50.000)
INDEX ON Tipos + STR(Ordem, 3) + Cpros TAG Ordem

loc_cTxt = "=== SET KEY TO parcial em indice COMPOSTO ===" + CHR(13) + CHR(10)

SET EXACT ON
SELECT CsGrade
SET ORDER TO TAG Ordem
SET KEY TO "V"
loc_nV = 0
COUNT TO loc_nV
loc_cTxt = loc_cTxt + "EXACT ON  -> visiveis = " + TRANSFORM(loc_nV) + CHR(13) + CHR(10)
SET KEY TO

SET EXACT OFF
SELECT CsGrade
SET ORDER TO TAG Ordem
SET KEY TO "V"
loc_nV = 0
COUNT TO loc_nV
loc_cTxt = loc_cTxt + "EXACT OFF -> visiveis = " + TRANSFORM(loc_nV) + CHR(13) + CHR(10)
SET KEY TO

*-- Alternativa que NAO depende de SET EXACT: faixa explicita RANGE
SET EXACT ON
SELECT CsGrade
SET ORDER TO TAG Ordem
SET KEY TO RANGE "V", "V" + REPLICATE(CHR(255), 17)
loc_nV = 0
COUNT TO loc_nV
loc_cTxt = loc_cTxt + "EXACT ON + SET KEY TO RANGE -> visiveis = " + TRANSFORM(loc_nV) + CHR(13) + CHR(10)
SET KEY TO

*-- E a chave PADRONIZADA no tamanho da expressao do indice
SET EXACT ON
SELECT CsGrade
SET ORDER TO TAG Ordem
SET KEY TO PADR("V", 18)
loc_nV = 0
COUNT TO loc_nV
loc_cTxt = loc_cTxt + "EXACT ON + PADR(chave,18) -> visiveis = " + TRANSFORM(loc_nV) + CHR(13) + CHR(10)
SET KEY TO

loc_cTxt = loc_cTxt + "SET('EXACT') corrente = " + SET("EXACT") + CHR(13) + CHR(10)

STRTOFILE(loc_cTxt, OUT)
QUIT
