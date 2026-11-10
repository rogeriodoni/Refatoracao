*-- Probe focado nos comandos de cursor do caminho de ETIQUETAS do
*-- Formsigopfis (task742, Fase 7), que o probe principal nao alcanca porque
*-- MsgConfirma devolve .F. em modo teste e o handler aborta antes.
*--
*-- Prova TRES coisas que compilam limpo mas poderiam falhar so em runtime:
*--   (a) CREATE CURSOR dbImpressao com a estrutura do contrato
*--   (b) INSERT INTO <cursor> ... VALUES (...) com CHAMADA DE METODO entre
*--       os valores (THIS.LerSubItemEtiqueta(...))
*--   (c) UPDATE <cursor> SET <col> = <variavel LOCAL>, sem WHERE
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcOut, lcSaida, loTeste, loErro
lcSaida = "C:\4c\automation\_probe742f7b_resultado.txt"
lcOut   = ""

loTeste = CREATEOBJECT("TesteCursorEtiqueta")

TRY
    lcOut = lcOut + loTeste.Executar()
CATCH TO loErro
    lcOut = lcOut + "EXCECAO: " + loErro.Message + " LN=" + ;
            TRANSFORM(loErro.LineNo) + " PROC=" + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(lcOut, lcSaida)
QUIT

DEFINE CLASS TesteCursorEtiqueta AS Custom

    FUNCTION Executar()
        LOCAL lcOut, lcAbrev, lcSafety
        lcOut = ""

        *-- (a) estrutura igual a de PrepararCursorEtiquetas()
        SET NULL ON
        CREATE CURSOR dbImpressao ( ;
            CPros      C(14) NULL, ;
            Qtds       N(12, 3) NULL, ;
            QtdeEtiq   N(12, 3) NULL, ;
            Pedido     C(30) NULL, ;
            Obs        C(10) NULL, ;
            Moedas     C(3)  NULL, ;
            EmpDopNums C(29) NULL, ;
            PVens      N(15, 6) NULL, ;
            Pesos      N(12, 3) NULL, ;
            CItens     N(10, 0) NULL, ;
            CodTams    C(4)  NULL, ;
            CBars      N(14, 0) NULL)
        SET NULL OFF

        lcOut = lcOut + "(a) CREATE CURSOR dbImpressao : OK  (" + ;
                TRANSFORM(FCOUNT("dbImpressao")) + " colunas)" + CHR(13) + CHR(10)

        *-- INSERT do ramo de LOTE (4 colunas, CBars numerico)
        INSERT INTO dbImpressao (CPros, Qtds, CBars, Obs) ;
            VALUES ("07083280      ", 1, 12345678, LEFT("VND-000123", 10))

        lcOut = lcOut + "(b1) INSERT de lote             : OK  (" + ;
                TRANSFORM(RECCOUNT("dbImpressao")) + " linha)" + CHR(13) + CHR(10)

        *-- (b) INSERT com CHAMADA DE METODO entre os valores - a forma usada
        *--     em MontarEtiquetasDosItens()
        INSERT INTO dbImpressao (CPros, Qtds, QtdeEtiq, Pesos, Obs, ;
                PVens, Moedas, EmpDopNums, CItens, CodTams) ;
            VALUES (STR(99887766554433, 14), 1, 2, 1.5, ;
                THIS.LerSubItemEtiqueta("codcors"), ;
                12.345678, "BRL", "001MALOTE                   3", 7, ;
                THIS.LerSubItemEtiqueta("codtams"))

        lcOut = lcOut + "(b2) INSERT com metodo em VALUES: OK  (" + ;
                TRANSFORM(RECCOUNT("dbImpressao")) + " linhas)" + CHR(13) + CHR(10)

        *-- (c) UPDATE sem WHERE com variavel LOCAL
        lcAbrev = "VND"
        SELECT dbImpressao
        UPDATE dbImpressao SET Pedido = lcAbrev

        SELECT dbImpressao
        GO TOP
        lcOut = lcOut + "(c) UPDATE SET Pedido = LOCAL  : OK  (linha 1 Pedido=[" + ;
                ALLTRIM(NVL(dbImpressao.Pedido, "")) + "] Obs=[" + ;
                ALLTRIM(NVL(dbImpressao.Obs, "")) + "])" + CHR(13) + CHR(10)

        GO BOTTOM
        lcOut = lcOut + "    linha " + TRANSFORM(RECCOUNT("dbImpressao")) + ;
                ": CPros=[" + ALLTRIM(NVL(dbImpressao.CPros, "")) + "] Obs=[" + ;
                ALLTRIM(NVL(dbImpressao.Obs, "")) + "] CodTams=[" + ;
                ALLTRIM(NVL(dbImpressao.CodTams, "")) + "] Pedido=[" + ;
                ALLTRIM(NVL(dbImpressao.Pedido, "")) + "]" + CHR(13) + CHR(10)

        *-- ZAP com guarda de SAFETY, como em PrepararCursorEtiquetas()
        lcSafety = SET("SAFETY")
        SET SAFETY OFF
        SELECT dbImpressao
        ZAP
        IF lcSafety = "ON"
            SET SAFETY ON
        ENDIF

        lcOut = lcOut + "(d) ZAP com guarda de SAFETY    : OK  (" + ;
                TRANSFORM(RECCOUNT("dbImpressao")) + " linhas)" + CHR(13) + CHR(10)

        USE IN dbImpressao

        RETURN lcOut
    ENDFUNC

    *-- Dubles de LerSubItemEtiqueta: cursor crEsti2 ausente -> devolve ""
    FUNCTION LerSubItemEtiqueta(par_cCampo)
        RETURN IIF(par_cCampo == "codcors", "AZ", "M")
    ENDFUNC

ENDDEFINE
