SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLog, lcRes, lnC, lcChave, lcFiltro
lcLog = "C:\4c\automation\logs\medir_setorder_limpa.txt"
lcRes = ""

CREATE CURSOR T (CPros C(14), CodCors C(4), CodTams C(4), Priors N(2))
INSERT INTO T (CPros, CodCors, CodTams, Priors) VALUES ("PROD001", "01", "M", 1)
INSERT INTO T (CPros, CodCors, CodTams, Priors) VALUES ("PROD002", "02", "G", 1)
INSERT INTO T (CPros, CodCors, CodTams, Priors) VALUES ("PROD002", "02", "G", 2)
SELECT T
INDEX ON CPros + CodCors + CodTams + STR(Priors, 2) TAG CPros

lcChave = PADR("PROD001", 14) + PADR("01", 4) + PADR("M", 4)

*-- CASO 1: SET KEY + SET ORDER TO (o que o legado faz no Processar)
SELECT T
SET ORDER TO CPros
SET KEY TO lcChave
GO TOP
COUNT TO lnC
lcRes = lcRes + "SET KEY ativo             -> visiveis = " + TRANSFORM(lnC) + " (esperado 1)" + CHR(13) + CHR(10)
SET ORDER TO
GO TOP
COUNT TO lnC
lcRes = lcRes + "depois de SET ORDER TO    -> visiveis = " + TRANSFORM(lnC) + " (3 = SET ORDER LIMPOU o key)" + CHR(13) + CHR(10)

*-- CASO 2: SET FILTER + SET ORDER TO
SELECT T
SET ORDER TO CPros
SET KEY TO
lcFiltro = "CPros + CodCors + CodTams == [" + lcChave + "]"
SET FILTER TO &lcFiltro
GO TOP
COUNT TO lnC
lcRes = lcRes + "SET FILTER ativo          -> visiveis = " + TRANSFORM(lnC) + " (esperado 1)" + CHR(13) + CHR(10)
SET ORDER TO
GO TOP
COUNT TO lnC
lcRes = lcRes + "depois de SET ORDER TO    -> visiveis = " + TRANSFORM(lnC) + ;
    " (se 1, o FILTER SOBREVIVE e o Processar veria so 1 item)" + CHR(13) + CHR(10)
SET FILTER TO
GO TOP
COUNT TO lnC
lcRes = lcRes + "depois de SET FILTER TO   -> visiveis = " + TRANSFORM(lnC) + " (esperado 3)" + CHR(13) + CHR(10)

*-- CASO 3: REPLACE ALL com filtro ativo alcanca tudo?
SELECT T
lcFiltro = "CPros + CodCors + CodTams == [" + lcChave + "]"
SET FILTER TO &lcFiltro
REPLACE ALL Priors WITH 9
SET FILTER TO
GO TOP
COUNT FOR Priors = 9 TO lnC
lcRes = lcRes + "REPLACE ALL sob FILTER    -> linhas alteradas = " + TRANSFORM(lnC) + ;
    " (1 = filtro restringiu; 3 = nao restringiu)" + CHR(13) + CHR(10)

STRTOFILE(lcRes, lcLog)
QUIT
