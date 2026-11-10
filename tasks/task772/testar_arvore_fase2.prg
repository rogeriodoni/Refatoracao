*-- Testa MontarCursorArvore, cujo predicado de agregacao foi trocado de
*-- "WHERE !Servicos" para "WHERE Servicos = 0".
*-- Prova (a) que o agregado EXCLUI as linhas de servico, como no legado
*-- ("Where Not Servicos"), e (b) que o predicado NAO estoura quando a coluna
*-- chega NUMERICA - que eh como ela chega agora (CAST(... AS INT)).
SET SAFETY OFF
SET RESOURCE OFF
SET CONSOLE OFF
SET TALK OFF

LOCAL loc_cLog, loc_cSaida, loc_oBO, loc_lOK, loc_nEsperado

loc_cLog = "C:\4c\tasks\task772\testar_arvore_fase2_resultado.txt"
loc_cSaida = ""

SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\SIGOPNOPBO.prg") ADDITIVE

loc_oBO = CREATEOBJECT("TesteArvoreBO")

*-- Cursor de origem igual ao que o SQLEXEC produz: Servicos NUMERICO.
*-- Duas movimentacoes; na primeira, uma das linhas eh SERVICO (Servicos = 1)
*-- e o peso dela (1000) NAO pode entrar no total.
CREATE CURSOR cursor_4c_Nensi ( ;
    Cidchaves C(20), Nenvs N(10,0), EmpDnPs C(33), Datas D, ;
    Grupoos C(10), Contaos C(10), Grupods C(10), Contads C(10), ;
    Servicos N(1,0), Nops N(10,0), Cmats C(14), Dpros C(65), ;
    Qtds N(9,3), Cunis C(3), Peso2s N(9,3), Cunips C(3), ;
    Pesos N(9,3), Cpros C(14), NopMaes N(10,0))

INSERT INTO cursor_4c_Nensi (Cidchaves, EmpDnPs, Servicos, Nops, Cmats, Pesos) ;
    VALUES ("CHV01", PADR("001MOV-A", 33), 0, 10, "MAT-1", 100.000)
INSERT INTO cursor_4c_Nensi (Cidchaves, EmpDnPs, Servicos, Nops, Cmats, Pesos) ;
    VALUES ("CHV01", PADR("001MOV-A", 33), 0, 10, "MAT-2", 50.500)
INSERT INTO cursor_4c_Nensi (Cidchaves, EmpDnPs, Servicos, Nops, Cmats, Pesos) ;
    VALUES ("CHV01", PADR("001MOV-A", 33), 1, 10, "SERV-X", 1000.000)
INSERT INTO cursor_4c_Nensi (Cidchaves, EmpDnPs, Servicos, Nops, Cmats, Pesos) ;
    VALUES ("CHV02", PADR("001MOV-B", 33), 0, 20, "MAT-3", 7.250)

loc_lOK = loc_oBO.ExporMontarCursorArvore("cursor_4c_Nensi")

loc_cSaida = loc_cSaida + "TESTE - MontarCursorArvore (WHERE Servicos = 0)" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  retorno             = " + IIF(loc_lOK, ".T.", ".F.") + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "  cursor arvore aberto= " + IIF(USED("cursor_4c_Arvore"), "SIM", "NAO") + CHR(13) + CHR(10)

IF USED("cursor_4c_Arvore")
    SELECT cursor_4c_Arvore
    loc_cSaida = loc_cSaida + "  RECCOUNT            = " + TRANSFORM(RECCOUNT()) + ;
        " (esperado 4 - a linha de servico SEGUE na arvore)" + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + "  tem coluna TotPesos = " + ;
        IIF(TYPE("cursor_4c_Arvore.TotPesos") = "N", "SIM", "NAO") + CHR(13) + CHR(10)

    *-- MOV-A: total = 100 + 50.5 = 150.5 (os 1000 do servico ficam FORA)
    LOCATE FOR ALLTRIM(cursor_4c_Arvore.Cmats) == "MAT-1"
    loc_cSaida = loc_cSaida + "  TotPesos de MOV-A   = " + TRANSFORM(cursor_4c_Arvore.TotPesos) + ;
        " (esperado 150.500 = 100 + 50.5, SEM os 1000 do servico)" + CHR(13) + CHR(10)

    *-- a propria linha de SERVICO recebe o total da movimentacao dela
    LOCATE FOR ALLTRIM(cursor_4c_Arvore.Cmats) == "SERV-X"
    loc_cSaida = loc_cSaida + "  TotPesos de SERV-X  = " + TRANSFORM(cursor_4c_Arvore.TotPesos) + ;
        " (esperado 150.500 - mesma movimentacao)" + CHR(13) + CHR(10)

    LOCATE FOR ALLTRIM(cursor_4c_Arvore.Cmats) == "MAT-3"
    loc_cSaida = loc_cSaida + "  TotPesos de MOV-B   = " + TRANSFORM(cursor_4c_Arvore.TotPesos) + ;
        " (esperado 7.250)" + CHR(13) + CHR(10)

    *-- READWRITE eh exigencia do SELECT da arvore
    loc_cSaida = loc_cSaida + "  Buffering           = " + ;
        TRANSFORM(CURSORGETPROP("Buffering", "cursor_4c_Arvore")) + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cSaida, loc_cLog)

QUIT


DEFINE CLASS TesteArvoreBO AS SIGOPNOPBO

    PROCEDURE Init()
        THIS.this_cCursorArvore = "cursor_4c_Arvore"
        THIS.this_cCursorProduto = "cursor_4c_Produto"
        RETURN .T.
    ENDPROC

    PROCEDURE ExporMontarCursorArvore(par_cCursorOrigem)
        RETURN THIS.MontarCursorArvore(par_cCursorOrigem)
    ENDPROC

ENDDEFINE
