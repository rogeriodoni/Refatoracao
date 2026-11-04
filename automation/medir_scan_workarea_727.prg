*-- medir_scan_workarea_727.prg - mede se SCAN/ENDSCAN sobrevive a troca e ao
*-- FECHAMENTO de work area DENTRO do laco (padrao usado por
*-- sigopecmBO.GerarArquivoExportacao, que faz USE IN de cursores auxiliares
*-- dentro do SCAN de produtos).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF

LOCAL lcOut, lnI, lcVisit
lcOut = ""

*-- Cenario A: SCAN simples, sem tocar work area
CREATE CURSOR cA (k N(2))
FOR lnI = 1 TO 3
    INSERT INTO cA (k) VALUES (lnI)
ENDFOR
lcVisit = ""
SELECT cA
SCAN
    lcVisit = lcVisit + TRANSFORM(cA.k)
ENDSCAN
lcOut = lcOut + "A-simples=[" + lcVisit + "] esperado=[123]" + CHR(13) + CHR(10)

*-- Cenario B: troca de work area DENTRO do laco (sem voltar antes do ENDSCAN)
CREATE CURSOR cB (k N(2))
FOR lnI = 1 TO 3
    INSERT INTO cB (k) VALUES (lnI)
ENDFOR
lcVisit = ""
SELECT cA
SCAN
    lcVisit = lcVisit + TRANSFORM(cA.k)
    SELECT cB
    GO BOTTOM
ENDSCAN
lcOut = lcOut + "B-troca=[" + lcVisit + "] esperado=[123]" + CHR(13) + CHR(10)

*-- Cenario C: FECHA (USE IN) a work area corrente dentro do laco - o caso do BO
lcVisit = ""
SELECT cA
GO TOP
SCAN
    lcVisit = lcVisit + TRANSFORM(cA.k)
    CREATE CURSOR cTmp (z N(1))
    INSERT INTO cTmp (z) VALUES (9)
    SELECT cTmp
    IF USED("cTmp")
        USE IN cTmp
    ENDIF
    *-- aqui ALIAS() esta VAZIO: nenhuma work area selecionada
ENDSCAN
lcOut = lcOut + "C-useIn=[" + lcVisit + "] esperado=[123]" + CHR(13) + CHR(10)

*-- Cenario D: SCAN aninhado + USE IN do cursor interno, igual ao BO
CREATE CURSOR cOut1 (g N(2))
INSERT INTO cOut1 (g) VALUES (1)
INSERT INTO cOut1 (g) VALUES (2)
lcVisit = ""
SELECT cOut1
SCAN
    lcVisit = lcVisit + "g" + TRANSFORM(cOut1.g)
    CREATE CURSOR cIn1 (p N(2))
    INSERT INTO cIn1 (p) VALUES (10)
    INSERT INTO cIn1 (p) VALUES (20)
    SELECT cIn1
    SCAN
        lcVisit = lcVisit + "p" + TRANSFORM(cIn1.p)
    ENDSCAN
    IF USED("cIn1")
        USE IN cIn1
    ENDIF
ENDSCAN
lcOut = lcOut + "D-aninhado=[" + lcVisit + "] esperado=[g1p10p20g2p10p20]" + CHR(13) + CHR(10)

*-- Cenario E: PADL sobre NUMERICO inteiro (this_nIds / this_nOrdens do BO)
LOCAL lnIds, lnOrd
SET DECIMALS TO 2
lnIds = 57
lnOrd = 4
lcOut = lcOut + "E-padl-var-int=[" + PADL(lnIds, 8, "0") + "] esperado=[00000057]" + CHR(13) + CHR(10)
lcOut = lcOut + "E-padl-var-ord=[" + PADL(lnOrd, 8, "0") + "] esperado=[00000004]" + CHR(13) + CHR(10)
lcOut = lcOut + "E-str-ord8=["     + ALLTRIM(STR(lnOrd, 8)) + "] esperado=[4]" + CHR(13) + CHR(10)

*-- Cenario F: PADL sobre COLUNA numeric(10,0) vs sobre VARIAVEL (SET DECIMALS)
CREATE CURSOR cNum (ids N(10,0), pesoms N(8,3), pvens N(11,5))
INSERT INTO cNum (ids, pesoms, pvens) VALUES (57, 12.345, 123.45678)
SELECT cNum
LOCAL lnP, lnV
lnP = cNum.pesoms
lnV = cNum.pvens
lcOut = lcOut + "F-col-ids=["   + PADL(cNum.ids, 8, "0") + "]" + CHR(13) + CHR(10)
lcOut = lcOut + "F-col-peso=["  + STRTRAN(PADL(cNum.pesoms, 8, "0"), ".", ",") + "]  <- LEGADO" + CHR(13) + CHR(10)
lcOut = lcOut + "F-str-peso=["  + STRTRAN(PADL(ALLTRIM(STR(lnP, 12, 3)), 8, "0"), ".", ",") + "]  <- MIGRADO" + CHR(13) + CHR(10)
lcOut = lcOut + "F-col-pven=["  + STRTRAN(PADL(cNum.pvens, 8, "0"), ".", ",") + "]  <- LEGADO" + CHR(13) + CHR(10)
lcOut = lcOut + "F-str-pven=["  + STRTRAN(PADL(ALLTRIM(STR(lnV, 18, 5)), 8, "0"), ".", ",") + "]  <- MIGRADO" + CHR(13) + CHR(10)
lcOut = lcOut + "F-var-peso-PADLdireto=[" + STRTRAN(PADL(lnP, 8, "0"), ".", ",") + "]" + CHR(13) + CHR(10)

*-- Cenario G: DTOC com e sem SET CENTURY (largura do campo Data(10) do td03)
LOCAL ldD
ldD = DATE(2026, 10, 31)
SET CENTURY ON
SET DATE TO BRITISH
lcOut = lcOut + "G-dtoc-century-ON=["  + DTOC(ldD) + "] len=" + TRANSFORM(LEN(DTOC(ldD))) + CHR(13) + CHR(10)
SET CENTURY OFF
lcOut = lcOut + "G-dtoc-century-OFF=[" + DTOC(ldD) + "] len=" + TRANSFORM(LEN(DTOC(ldD))) + CHR(13) + CHR(10)
SET CENTURY ON
lcOut = lcOut + "G-dtoc-vazia=["       + DTOC({}) + "] len=" + TRANSFORM(LEN(DTOC({}))) + CHR(13) + CHR(10)

STRTOFILE(lcOut, "C:\4c\automation\medir_scan_workarea_727.out", 0)
QUIT
