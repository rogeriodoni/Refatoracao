SET SAFETY OFF
SET RESOURCE OFF
SET EXACT ON
LOCAL loc_cOut, loc_cFiltro
loc_cOut = "SET EXACT ON (como o config.prg)" + CHR(13) + CHR(10)

*-- Cods char(4) guardando codigo de 2 chars (caso do crSigLcNv4)
CREATE CURSOR cNiv (Cods C(4), Codigo C(4), Descs C(20))
INSERT INTO cNiv VALUES ("01", "0001", "FILHO A")
INSERT INTO cNiv VALUES ("01", "0002", "FILHO B")
INSERT INTO cNiv VALUES ("02", "0003", "FILHO C")

loc_cFiltro = "01"
SELECT * FROM cNiv WHERE Cods = m.loc_cFiltro INTO CURSOR cR1 READWRITE
loc_cOut = loc_cOut + "WHERE Cods = m.loc_cFiltro ('01')        -> " + TRANSFORM(RECCOUNT("cR1")) + " linha(s)" + CHR(13) + CHR(10)

SELECT * FROM cNiv WHERE ALLTRIM(Cods) == m.loc_cFiltro INTO CURSOR cR2 READWRITE
loc_cOut = loc_cOut + "WHERE ALLTRIM(Cods) == m.loc_cFiltro    -> " + TRANSFORM(RECCOUNT("cR2")) + " linha(s)" + CHR(13) + CHR(10)

*-- e o caso inverso: filtro mais LONGO que o dado
loc_cFiltro = "0100"
SELECT * FROM cNiv WHERE Cods = m.loc_cFiltro INTO CURSOR cR3 READWRITE
loc_cOut = loc_cOut + "WHERE Cods = '0100' (filtro mais longo)  -> " + TRANSFORM(RECCOUNT("cR3")) + " linha(s)" + CHR(13) + CHR(10)

*-- SEEK sobre tag Codigo com valor curto, SET NEAR ON (como o legado)
SELECT cNiv
INDEX ON Codigo TAG Codigo
SET NEAR ON
loc_cOut = loc_cOut + "SEEK('0002') tag Codigo                  -> " + TRANSFORM(SEEK("0002", "cNiv", "Codigo")) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "SEEK('2') tag Codigo (parcial)           -> " + TRANSFORM(SEEK("2", "cNiv", "Codigo")) + CHR(13) + CHR(10)
SET NEAR OFF

STRTOFILE(loc_cOut, "C:\4c\automation\medir_exact_cods.txt")
QUIT
