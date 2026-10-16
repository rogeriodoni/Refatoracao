SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lc
lc = "C:\4c\automation\frxtmp\t_qr.txt"
STRTOFILE("INICIO" + CHR(13) + CHR(10), lc)

CREATE TABLE C:\4c\automation\frxtmp\tbase (ordem N(5), ciclis C(10), crclis C(50), nvalcomp N(12,2))
INSERT INTO tbase VALUES (1, "0001", "CLIENTE TESTE", 1234.56)
INSERT INTO tbase VALUES (2, "0002", "OUTRO CLIENTE", 99.90)

CREATE REPORT C:\4c\automation\frxtmp\t_qr FROM tbase COLUMN
STRTOFILE("CREATE REPORT ok, FRX existe=" + TRANSFORM(FILE("C:\4c\automation\frxtmp\t_qr.frx")) + ;
    " FRT existe=" + TRANSFORM(FILE("C:\4c\automation\frxtmp\t_qr.frt")) + CHR(13) + CHR(10), lc, 1)

*-- consegue renderizar?
SELECT tbase
GO TOP
TRY
    REPORT FORM C:\4c\automation\frxtmp\t_qr.frx TO FILE C:\4c\automation\frxtmp\t_qr_saida.txt ASCII NOCONSOLE
    STRTOFILE("REPORT FORM OK" + CHR(13) + CHR(10), lc, 1)
CATCH TO e
    STRTOFILE("REPORT FORM ERRO: " + e.Message + CHR(13) + CHR(10), lc, 1)
ENDTRY

*-- quantos registros tem o FRX gerado e quais objtype
USE C:\4c\automation\frxtmp\t_qr.frx IN 0 ALIAS frxins
SELECT frxins
STRTOFILE("FRX RECCOUNT=" + TRANSFORM(RECCOUNT()) + CHR(13) + CHR(10), lc, 1)
SCAN
    STRTOFILE("  objtype=" + TRANSFORM(frxins.objtype) + " objcode=" + TRANSFORM(frxins.objcode) + ;
        " vpos=" + TRANSFORM(frxins.vpos) + " hpos=" + TRANSFORM(frxins.hpos) + ;
        " expr=[" + LEFT(frxins.expr, 40) + "]" + CHR(13) + CHR(10), lc, 1)
ENDSCAN
USE
STRTOFILE("FIM" + CHR(13) + CHR(10), lc, 1)
QUIT
