SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cOut, loc_nI
loc_cOut = "C:\4c\automation\_probe747f2b.txt"

*-- Prova do padrao do legado: SCAN sobre o cursor de ORIGEM com
*-- INSERT INTO <outro cursor> no corpo. INSERT INTO troca a work area
*-- corrente - a questao e se o SCAN mantem o proprio alias e continua
*-- percorrendo a origem (senao so a 1a linha entraria no destino).
CREATE CURSOR csOrig (Dopes C(20), Numes N(6), Valos N(12,2))
INSERT INTO csOrig (Dopes, Numes, Valos) VALUES ("MALOTE", 1, 10.00)
INSERT INTO csOrig (Dopes, Numes, Valos) VALUES ("MALOTE", 2, 20.00)
INSERT INTO csOrig (Dopes, Numes, Valos) VALUES ("MALOTE", 3, 30.00)
INSERT INTO csOrig (Dopes, Numes, Valos) VALUES ("CAIXA",  4, 40.00)

CREATE CURSOR csDest (Marca L, Obs C(27), Printed L, Valos N(12,2))

SELECT csOrig
SCAN
    INSERT INTO csDest (Marca, Obs, Printed, Valos) ;
        VALUES (.T., PADR(csOrig.Dopes, 20) + " " + STR(csOrig.Numes, 6), .F., csOrig.Valos)
ENDSCAN

STRTOFILE("origem RECCOUNT=" + TRANSFORM(RECCOUNT("csOrig")) + CHR(13) + CHR(10), loc_cOut)
STRTOFILE("destino RECCOUNT=" + TRANSFORM(RECCOUNT("csDest")) + " (esperado 4)" + CHR(13) + CHR(10), loc_cOut, 1)
STRTOFILE("ALIAS() apos ENDSCAN=" + ALIAS() + CHR(13) + CHR(10), loc_cOut, 1)
SELECT csDest
GO TOP
SCAN
    STRTOFILE("  dest linha " + TRANSFORM(RECNO()) + ": Obs=[" + csDest.Obs + "] Valos=" + TRANSFORM(csDest.Valos) + CHR(13) + CHR(10), loc_cOut, 1)
ENDSCAN

STRTOFILE("=== FIM ===" + CHR(13) + CHR(10), loc_cOut, 1)
QUIT
