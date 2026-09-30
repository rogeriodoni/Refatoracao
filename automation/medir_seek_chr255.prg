SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NEAR OFF
SET EXACT ON
LOCAL lcOut, lcArq
lcArq = "C:\4c\automation\medir_seek_chr255.txt"
lcOut = "=== SEEK em indice NUMERICO (NCopias) ===" + CHR(13) + CHR(10)

CREATE CURSOR curTeste (ncopias N(6,0), bancos C(3), agencias C(4), ncontas C(10), ncheques C(6))
INSERT INTO curTeste VALUES (1, "001", "1234", "0000000111", "000001")
INSERT INTO curTeste VALUES (2, "002", "5678", "0000000222", "000002")
INSERT INTO curTeste VALUES (3, "003", "9012", "0000000333", "000003")
SELECT curTeste
INDEX ON ncopias TAG NCopias
INDEX ON bancos + agencias + ncontas + ncheques TAG Cheque
SET ORDER TO NCopias
GO TOP

*-- Teste 1: SEEK CHR(255) com ordem NUMERICA
TRY
    SEEK CHR(255) IN curTeste ORDER NCopias ASCENDING
    lcOut = lcOut + "T1 SEEK CHR(255) ordem numerica : SEM ERRO | FOUND=" + ;
        TRANSFORM(FOUND("curTeste")) + " EOF=" + TRANSFORM(EOF("curTeste")) + ;
        " RECNO=" + TRANSFORM(RECNO("curTeste")) + CHR(13) + CHR(10)
CATCH TO loErr
    lcOut = lcOut + "T1 SEEK CHR(255) ordem numerica : ERRO " + ;
        TRANSFORM(loErr.ErrorNo) + " - " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

*-- Teste 2: SEEK chave CHARACTER com ordem NUMERICA corrente
SELECT curTeste
SET ORDER TO NCopias
GO TOP
TRY
    IF !SEEK("0011234000000011100000 1", "curTeste")
        lcOut = lcOut + "T2 SEEK char/ordem numerica    : SEM ERRO | nao achou (Go Top)" + CHR(13) + CHR(10)
    ELSE
        lcOut = lcOut + "T2 SEEK char/ordem numerica    : SEM ERRO | ACHOU" + CHR(13) + CHR(10)
    ENDIF
CATCH TO loErr
    lcOut = lcOut + "T2 SEEK char/ordem numerica    : ERRO " + ;
        TRANSFORM(loErr.ErrorNo) + " - " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

*-- Teste 3: SEEK na tag Cheque (chave posicional correta, sem ALLTRIM)
SELECT curTeste
GO TOP
LOCAL lcChave
lcChave = curTeste.bancos + curTeste.agencias + curTeste.ncontas + curTeste.ncheques
GO BOTTOM
TRY
    IF SEEK(lcChave, "curTeste", "Cheque")
        lcOut = lcOut + "T3 SEEK tag Cheque             : ACHOU RECNO=" + ;
            TRANSFORM(RECNO("curTeste")) + " (len chave=" + TRANSFORM(LEN(lcChave)) + ")" + CHR(13) + CHR(10)
    ELSE
        lcOut = lcOut + "T3 SEEK tag Cheque             : nao achou" + CHR(13) + CHR(10)
    ENDIF
CATCH TO loErr
    lcOut = lcOut + "T3 SEEK tag Cheque             : ERRO " + ;
        TRANSFORM(loErr.ErrorNo) + " - " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

*-- Teste 4: GO BOTTOM na ordem NCopias (alternativa ao Seek Chr(255))
SELECT curTeste
SET ORDER TO NCopias
GO BOTTOM
lcOut = lcOut + "T4 GO BOTTOM ordem NCopias     : RECNO=" + TRANSFORM(RECNO("curTeste")) + ;
    " ncopias=" + TRANSFORM(curTeste.ncopias) + " EOF=" + TRANSFORM(EOF("curTeste")) + CHR(13) + CHR(10)

*-- Teste 5: ZAP com SAFETY OFF em DataSession corrente
TRY
    SELECT curTeste
    ZAP
    lcOut = lcOut + "T5 ZAP (SAFETY OFF)            : OK RECCOUNT=" + ;
        TRANSFORM(RECCOUNT("curTeste")) + CHR(13) + CHR(10)
CATCH TO loErr
    lcOut = lcOut + "T5 ZAP                         : ERRO " + loErr.Message + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(lcOut, lcArq)
QUIT
