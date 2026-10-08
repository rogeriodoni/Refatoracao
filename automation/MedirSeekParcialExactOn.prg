SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLog, lcRes, lcChave
lcLog = "C:\4c\automation\logs\medir_seek_parcial.txt"
lcRes = ""

*-- Reproduz cursor_4c_TmpSaldg: chave de indice MAIOR que o prefixo buscado
CREATE CURSOR T (CPros C(14), CodCors C(4), CodTams C(4), Priors N(2), Grupos C(10))
INSERT INTO T (CPros, CodCors, CodTams, Priors, Grupos) VALUES ("PROD001", "01", "M", 1, "GRP01")
INSERT INTO T (CPros, CodCors, CodTams, Priors, Grupos) VALUES ("PROD002", "02", "G", 1, "GRP02")
SELECT T
INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) + Grupos TAG CPros

lcChave = PADR("PROD001", 14) + PADR("01", 4) + PADR("M", 4)   && 22 chars; indice tem 34

SET EXACT ON
SELECT T
SET ORDER TO CPros
lcRes = lcRes + "SET EXACT ON  - SEEK prefixo 22 em indice 34 -> " + TRANSFORM(SEEK(lcChave, "T", "CPros")) + ;
    " (RECNO=" + TRANSFORM(RECNO("T")) + ")" + CHR(13) + CHR(10)

SET EXACT OFF
SELECT T
GO TOP
lcRes = lcRes + "SET EXACT OFF - SEEK prefixo 22 em indice 34 -> " + TRANSFORM(SEEK(lcChave, "T", "CPros")) + ;
    " (RECNO=" + TRANSFORM(RECNO("T")) + ")" + CHR(13) + CHR(10)

*-- E o SET KEY, que eh o mecanismo usado nas grades de resumo
SET EXACT ON
SELECT T
SET ORDER TO CPros
SET KEY TO lcChave
GO TOP
LOCAL lnC
COUNT TO lnC
lcRes = lcRes + "SET EXACT ON  - SET KEY prefixo 22 -> linhas visiveis = " + TRANSFORM(lnC) + ;
    " (esperado 1)" + CHR(13) + CHR(10)
SET KEY TO

STRTOFILE(lcRes, lcLog)
QUIT
