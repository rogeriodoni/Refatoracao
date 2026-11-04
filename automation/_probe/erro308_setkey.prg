*-- Erro308: onde SET KEY TO <expr> IN <alias> avalia a expressao?
*-- ATENCAO: rotinas DEPOIS do QUIT - PROCEDURE no meio encerra o principal.
SET SAFETY OFF
SET RESOURCE OFF
SET EXCLUSIVE OFF
PUBLIC gcLog
gcLog = "C:\4c\automation\_probe\_erro308_setkey.txt"
STRTOFILE("INICIO" + CHR(13) + CHR(10), gcLog)
ON ERROR DO Anota WITH "ON ERROR linha " + TRANSFORM(LINENO()) + ": " + MESSAGE()

*=== T1: indice CRU + chave NAO qualificada (o que o migrado faz)
DO Montar WITH 3
SELECT crC
INDEX ON grupos TAG grupos
SELECT crG
GO TOP
TRY
    SET KEY TO codigos IN crC
    DO Anota WITH "T1 indice CRU     / chave 'codigos'      -> OK, visiveis=" + TRANSFORM(Visiveis())
CATCH TO oE
    DO Anota WITH "T1 indice CRU     / chave 'codigos'      -> ERRO: " + oE.Message
ENDTRY

*=== T2: indice CRU + chave QUALIFICADA (o que o legado faz)
DO Montar WITH 3
SELECT crC
INDEX ON grupos TAG grupos
SELECT crG
GO TOP
TRY
    SET KEY TO crG.codigos IN crC
    DO Anota WITH "T2 indice CRU     / chave 'crG.codigos'  -> OK, visiveis=" + TRANSFORM(Visiveis())
CATCH TO oE
    DO Anota WITH "T2 indice CRU     / chave 'crG.codigos'  -> ERRO: " + oE.Message
ENDTRY

*=== T3: indice ALLTRIM + chave QUALIFICADA crua (regra #42)
DO Montar WITH 3
SELECT crC
INDEX ON ALLTRIM(grupos) TAG grupos
SELECT crG
GO TOP
TRY
    SET KEY TO crG.codigos IN crC
    DO Anota WITH "T3 indice ALLTRIM / chave crua           -> OK, visiveis=" + TRANSFORM(Visiveis())
CATCH TO oE
    DO Anota WITH "T3 indice ALLTRIM / chave crua           -> ERRO: " + oE.Message
ENDTRY

*=== T4: indice ALLTRIM + chave ALLTRIM
DO Montar WITH 3
SELECT crC
INDEX ON ALLTRIM(grupos) TAG grupos
SELECT crG
GO TOP
TRY
    SET KEY TO ALLTRIM(crG.codigos) IN crC
    DO Anota WITH "T4 indice ALLTRIM / chave ALLTRIM        -> OK, visiveis=" + TRANSFORM(Visiveis())
CATCH TO oE
    DO Anota WITH "T4 indice ALLTRIM / chave ALLTRIM        -> ERRO: " + oE.Message
ENDTRY

*=== T5: indice CRU, LARGURAS DIFERENTES (codigos C(3) x grupos C(5))
DO Montar WITH 5
SELECT crC
INDEX ON grupos TAG grupos
SELECT crG
GO TOP
TRY
    SET KEY TO crG.codigos IN crC
    DO Anota WITH "T5 CRU larg 3x5   / chave crua           -> OK, visiveis=" + TRANSFORM(Visiveis())
CATCH TO oE
    DO Anota WITH "T5 CRU larg 3x5   / chave crua           -> ERRO: " + oE.Message
ENDTRY

*=== T6: sem indice nenhum - SET KEY eh no-op ou erro?
DO Montar WITH 3
SELECT crG
GO TOP
TRY
    SET KEY TO crG.codigos IN crC
    DO Anota WITH "T6 SEM indice     / chave crua           -> OK, visiveis=" + TRANSFORM(Visiveis())
CATCH TO oE
    DO Anota WITH "T6 SEM indice     / chave crua           -> ERRO: " + oE.Message
ENDTRY

*=== T7: crC selecionado na hora do SET KEY
DO Montar WITH 3
SELECT crC
INDEX ON grupos TAG grupos
TRY
    SET KEY TO crG.codigos IN crC
    DO Anota WITH "T7 crC corrente   / chave 'crG.codigos'  -> OK, visiveis=" + TRANSFORM(Visiveis())
CATCH TO oE
    DO Anota WITH "T7 crC corrente   / chave 'crG.codigos'  -> ERRO: " + oE.Message
ENDTRY

*=== T8: chave = coluna do ALVO, sem qualificar
DO Montar WITH 3
SELECT crC
INDEX ON grupos TAG grupos
SELECT crG
GO TOP
TRY
    SET KEY TO grupos IN crC
    DO Anota WITH "T8 indice CRU     / chave 'grupos' (col do ALVO) -> OK, visiveis=" + TRANSFORM(Visiveis())
CATCH TO oE
    DO Anota WITH "T8 indice CRU     / chave 'grupos' (col do ALVO) -> ERRO: " + oE.Message
ENDTRY

DO Anota WITH "FIM"
QUIT

PROCEDURE Anota(lcTxt)
    STRTOFILE(lcTxt + CHR(13) + CHR(10), gcLog, 1)
ENDPROC

FUNCTION Visiveis()
    LOCAL lnN, lcAnt
    lcAnt = ALIAS()
    lnN = 0
    SELECT crC
    GO TOP
    SCAN
        lnN = lnN + 1
    ENDSCAN
    IF !EMPTY(lcAnt)
        SELECT (lcAnt)
    ENDIF
    RETURN lnN
ENDFUNC

PROCEDURE Montar(lnLarg)
    IF USED("crG")
        USE IN crG
    ENDIF
    IF USED("crC")
        USE IN crC
    ENDIF
    CREATE CURSOR crG (codigos C(3), descrs C(20))
    INSERT INTO crG VALUES ("001", "GRUPO 1")
    INSERT INTO crG VALUES ("002", "GRUPO 2")
    IF lnLarg = 3
        CREATE CURSOR crC (grupos C(3), iclis C(6))
    ELSE
        CREATE CURSOR crC (grupos C(5), iclis C(6))
    ENDIF
    INSERT INTO crC VALUES ("001", "A")
    INSERT INTO crC VALUES ("001", "B")
    INSERT INTO crC VALUES ("002", "C")
ENDPROC
