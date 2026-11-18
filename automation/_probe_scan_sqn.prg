SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cOut, loc_nI, loc_nVoltas
loc_cOut = ""

*-- (A) SCAN sobrevive a troca de work area dentro do corpo?
CREATE CURSOR cTeste (campo C(5))
INSERT INTO cTeste (campo) VALUES ("A")
INSERT INTO cTeste (campo) VALUES ("B")
INSERT INTO cTeste (campo) VALUES ("C")

loc_nVoltas = 0
SELECT cTeste
SCAN
    loc_nVoltas = loc_nVoltas + 1
    IF loc_nVoltas > 20
        EXIT
    ENDIF
    loc_cOut = loc_cOut + ALLTRIM(cTeste.campo)
    *-- simula o que o BO faz: cria outro alias e fecha, deixando a work
    *-- area corrente DIFERENTE da do SCAN
    CREATE CURSOR cOutro (x C(1))
    USE IN cOutro
ENDSCAN
loc_cOut = "A) voltas=" + TRANSFORM(loc_nVoltas) + " seq=[" + loc_cOut + "]" + CHR(13) + CHR(10)

*-- (A2) mesma coisa SEM fechar o outro alias (fica selecionado)
loc_nVoltas = 0
LOCAL loc_cSeq2
loc_cSeq2 = ""
SELECT cTeste
GO TOP
SCAN
    loc_nVoltas = loc_nVoltas + 1
    IF loc_nVoltas > 20
        EXIT
    ENDIF
    loc_cSeq2 = loc_cSeq2 + ALLTRIM(cTeste.campo)
    IF USED("cOutro2")
        USE IN cOutro2
    ENDIF
    CREATE CURSOR cOutro2 (x C(1))
ENDSCAN
loc_cOut = loc_cOut + "A2) voltas=" + TRANSFORM(loc_nVoltas) + " seq=[" + loc_cSeq2 + "]" + CHR(13) + CHR(10)
IF USED("cOutro2")
    USE IN cOutro2
ENDIF

*-- (B) INSERT em cursor local com colunas OMITIDAS -> blank ou .NULL.?
*--    1) cursor criado por CREATE CURSOR sem NULL
SELECT 0
CREATE CURSOR cIns1 (cdopes C(20), cidchaves C(20), cnivels C(20), seqs N(2,0))
INSERT INTO cIns1 (cdopes, cidchaves) VALUES ("OP", "K1")
loc_cOut = loc_cOut + "B1) CREATE CURSOR: cnivels ISNULL=" + TRANSFORM(ISNULL(cIns1.cnivels)) + ;
    " EMPTY=" + TRANSFORM(EMPTY(cIns1.cnivels)) + ;
    " seqs ISNULL=" + TRANSFORM(ISNULL(cIns1.seqs)) + CHR(13) + CHR(10)

*--    2) cursor criado com SET NULL ON (como vem de SQLEXEC nullable)
SET NULL ON
CREATE CURSOR cIns2 (cdopes C(20), cidchaves C(20), cnivels C(20), seqs N(2,0))
SET NULL OFF
INSERT INTO cIns2 (cdopes, cidchaves) VALUES ("OP", "K1")
loc_cOut = loc_cOut + "B2) SET NULL ON: cnivels ISNULL=" + TRANSFORM(ISNULL(cIns2.cnivels)) + ;
    " EMPTY=" + TRANSFORM(EMPTY(cIns2.cnivels)) + ;
    " seqs ISNULL=" + TRANSFORM(ISNULL(cIns2.seqs)) + CHR(13) + CHR(10)

*-- (C) EMPTY(.NULL.) e LOCATE com campo NULL
loc_cOut = loc_cOut + "C) EMPTY(.NULL.)=" + TRANSFORM(EMPTY(.NULL.)) + CHR(13) + CHR(10)

*-- (D) SET DELETED com macro de variavel local
LOCAL loc_cDel
SET DELETED ON
loc_cDel = SET("DELETED")
SET DELETED OFF
SET DELETED &loc_cDel
loc_cOut = loc_cOut + "D) macro SET DELETED restaurou=[" + SET("DELETED") + "] guardado=[" + loc_cDel + "]" + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, "C:\4c\automation\_probe_scan_sqn.txt")
QUIT
