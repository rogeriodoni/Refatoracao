SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLog, lcRes, lnC1, lnC2, lcV1, lcV2
lcLog = "C:\4c\automation\logs\medir_setkey.txt"
lcRes = ""

CREATE CURSOR PAI (k C(3))
INSERT INTO PAI (k) VALUES ("AAA")
INSERT INTO PAI (k) VALUES ("BBB")

*-- AAA tem 2 filhos, BBB tem 3 -> as contagens DISTINGUEM os dois casos
CREATE CURSOR FILHO (k C(3), v N(3))
INSERT INTO FILHO (k, v) VALUES ("AAA", 1)
INSERT INTO FILHO (k, v) VALUES ("AAA", 2)
INSERT INTO FILHO (k, v) VALUES ("BBB", 7)
INSERT INTO FILHO (k, v) VALUES ("BBB", 8)
INSERT INTO FILHO (k, v) VALUES ("BBB", 9)
SELECT FILHO
INDEX ON k TAG k

SELECT PAI
GO TOP
SELECT FILHO
SET ORDER TO k
SET KEY TO PAI.k

GO TOP
COUNT TO lnC1
GO TOP
lcV1 = IIF(EOF(), "EOF", TRANSFORM(FILHO.v))
lcRes = lcRes + "PAI=AAA (esperado 2 filhos) -> COUNT=" + TRANSFORM(lnC1) + " 1o v=" + lcV1 + CHR(13) + CHR(10)

SELECT PAI
SKIP
lcRes = lcRes + "PAI movido para = " + PAI.k + " (sem reemitir SET KEY)" + CHR(13) + CHR(10)

SELECT FILHO
GO TOP
COUNT TO lnC2
GO TOP
lcV2 = IIF(EOF(), "EOF", TRANSFORM(FILHO.v))
lcRes = lcRes + "PAI=BBB (3 filhos se DINAMICO, 2 se ESTATICO) -> COUNT=" + TRANSFORM(lnC2) + " 1o v=" + lcV2 + CHR(13) + CHR(10)

DO CASE
    CASE lnC2 = 3 AND lcV2 = "7"
        lcRes = lcRes + "VEREDITO: SET KEY EH DINAMICO - reavalia a expressao a cada acesso" + CHR(13) + CHR(10)
    CASE lnC2 = 2 AND lcV2 = "1"
        lcRes = lcRes + "VEREDITO: SET KEY EH ESTATICO - congelou na faixa de AAA" + CHR(13) + CHR(10)
    OTHERWISE
        lcRes = lcRes + "VEREDITO: INCONCLUSIVO" + CHR(13) + CHR(10)
ENDCASE

*-- SEEK para chave FORA da faixa corrente do SET KEY
SELECT FILHO
lcRes = lcRes + "SEEK('AAA') com PAI=BBB -> " + TRANSFORM(SEEK("AAA", "FILHO", "k")) + CHR(13) + CHR(10)
SET KEY TO
GO TOP
COUNT TO lnC1
lcRes = lcRes + "Apos SET KEY TO (limpar) -> COUNT=" + TRANSFORM(lnC1) + " (esperado 5)" + CHR(13) + CHR(10)
lcRes = lcRes + "SEEK('AAA') sem SET KEY -> " + TRANSFORM(SEEK("AAA", "FILHO", "k")) + CHR(13) + CHR(10)

STRTOFILE(lcRes, lcLog)
QUIT
