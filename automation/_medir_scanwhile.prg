SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcOut, loc_lValido, lnVoltas
lcOut = ""

CREATE CURSOR cTeste (mins N(3,0), ctits C(10))
INSERT INTO cTeste VALUES (0, "A")
INSERT INTO cTeste VALUES (5, "B")
INSERT INTO cTeste VALUES (0, "C")

loc_lValido = .T.
lnVoltas    = 0
SELECT cTeste
GO TOP IN cTeste
SCAN WHILE loc_lValido
    lnVoltas = lnVoltas + 1
    lcOut = lcOut + "  volta " + TRANSFORM(lnVoltas) + " ctits=" + ALLTRIM(cTeste.ctits) + CHR(13) + CHR(10)
    IF cTeste.mins > 0
        loc_lValido = .F.
    ENDIF
ENDSCAN

lcOut = "SCAN WHILE <memvar local>:" + CHR(13) + CHR(10) + lcOut
lcOut = lcOut + "voltas = " + TRANSFORM(lnVoltas) + " (esperado 2: para na 2a linha)" + CHR(13) + CHR(10)
lcOut = lcOut + "loc_lValido final = " + TRANSFORM(loc_lValido) + " (esperado .F.)" + CHR(13) + CHR(10)
STRTOFILE(lcOut, "C:\4c\automation\_scanwhile_medicao.txt")
QUIT
