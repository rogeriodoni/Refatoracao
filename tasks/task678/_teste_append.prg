*==============================================================================
* _teste_append.prg - mede se APPEND FROM DBF() ve as linhas recem-inseridas
* num cursor construido localmente por CREATE CURSOR + INSERT INTO.
*
* Reproduz a sequencia real: BO monta cursor_4c_SenhasTemp com INSERT INTO e o
* Form faz ZAP + APPEND FROM DBF() no alias da grade. Testa tambem dentro de
* uma DataSession PRIVADA (o form eh DataSession = 2).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcRes, lnI, lnDepois, lcSafety
lcRes = ""

*-- Alias destino, como o cursor_4c_Senhas da grade
CREATE CURSOR cursor_4c_Senhas ( ;
    datas      T        NULL, ;
    horas      C(8)     NULL, ;
    senhads    C(6)     NULL, ;
    usuars     C(10)    NULL, ;
    cidchaves  C(20)    NULL, ;
    tipos      N(1, 0)  NULL)

*-- Alias de lote, montado por INSERT INTO (como o BO faz)
CREATE CURSOR cursor_4c_SenhasTemp ( ;
    datas      T        NULL, ;
    horas      C(8)     NULL, ;
    senhads    C(6)     NULL, ;
    usuars     C(10)    NULL, ;
    cidchaves  C(20)    NULL, ;
    tipos      N(1, 0)  NULL)

FOR lnI = 1 TO 7
    INSERT INTO cursor_4c_SenhasTemp (datas, horas, senhads, usuars, cidchaves, tipos) ;
        VALUES (DATETIME(), "10:00:0" + TRANSFORM(lnI), ;
                STR(100000 + lnI, 6), "TESTE", "CH" + TRANSFORM(lnI), 0)
ENDFOR

lcRes = lcRes + "lote montado: RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_SenhasTemp")) + CHR(13) + CHR(10)
lcRes = lcRes + "DBF() do lote = " + DBF("cursor_4c_SenhasTemp") + CHR(13) + CHR(10)

*-- Sequencia do RecarregarGradeDoTemp, SEM nenhum FLUSH
lcSafety = SET("SAFETY")
SET SAFETY OFF
ZAP IN cursor_4c_Senhas
IF lcSafety = "ON"
    SET SAFETY ON
ENDIF

SELECT cursor_4c_Senhas
APPEND FROM DBF("cursor_4c_SenhasTemp")
GO TOP

lnDepois = RECCOUNT("cursor_4c_Senhas")
lcRes = lcRes + "APPEND FROM DBF (sem FLUSH): destino RECCOUNT=" + TRANSFORM(lnDepois) + ;
        "  esperado 7" + CHR(13) + CHR(10)
lcRes = lcRes + "   1a linha senhads=[" + ALLTRIM(NVL(cursor_4c_Senhas.senhads, "")) + ;
        "]  horas=[" + ALLTRIM(NVL(cursor_4c_Senhas.horas, "")) + "]" + CHR(13) + CHR(10)
GO BOTTOM
lcRes = lcRes + "   ultima linha senhads=[" + ALLTRIM(NVL(cursor_4c_Senhas.senhads, "")) + ;
        "]" + CHR(13) + CHR(10)

lcRes = lcRes + "RESULTADO: " + IIF(lnDepois = 7, "OK - APPEND ve tudo sem FLUSH", ;
        "FALHOU - faltaram linhas, precisa de FLUSH") + CHR(13) + CHR(10)

STRTOFILE(lcRes, "C:\4c\tasks\task678\_teste_append.out", 0)
QUIT
