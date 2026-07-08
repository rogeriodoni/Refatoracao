*====================================================================
* TestarExtrator.prg
* Script de teste para debugar ExtratorPropriedades
*====================================================================

LOCAL loc_cArquivo, loc_oExtrator, loc_aResultado, i

*-- Limpa .fxp
IF FILE("ExtratorPropriedades.fxp")
    DELETE FILE ExtratorPropriedades.fxp
ENDIF

*-- Carrega classe
SET PROCEDURE TO ExtratorPropriedades.prg ADDITIVE

*-- Arquivo de teste
loc_cArquivo = "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt"

? "Testando ExtratorPropriedades..."
? "Arquivo: " + loc_cArquivo
? ""

*-- Testa extrator
TRY
    loc_oExtrator = CREATEOBJECT("ExtratorPropriedades")
    ? "Extrator criado com sucesso"

    loc_aResultado = loc_oExtrator.ExtrairDeArquivo(loc_cArquivo)

    ? ""
    ? "Tipo do retorno: " + VARTYPE(loc_aResultado)

    IF ISNULL(loc_aResultado)
        ? "ERRO: ExtrairDeArquivo retornou NULL"
        RETURN
    ENDIF

    IF VARTYPE(loc_aResultado) != "A"
        ? "ERRO: Retorno nao eh array, tipo = " + VARTYPE(loc_aResultado)
        RETURN
    ENDIF

    ? ""
    ? "Array retornado:"
    ? "  Dimensoes: " + ALLTRIM(STR(ALEN(loc_aResultado, 1))) + " linhas x " + ALLTRIM(STR(ALEN(loc_aResultado, 2))) + " colunas"
    ? ""

    IF ALEN(loc_aResultado, 1) > 0
        ? "Primeiras 10 propriedades encontradas:"
        ? "----------------------------------------"

        FOR i = 1 TO MIN(10, ALEN(loc_aResultado, 1))
            ? ALLTRIM(STR(i)) + ". Objeto: " + loc_aResultado[i, 1]
            ? "   Propriedade: " + loc_aResultado[i, 2]
            ? "   Valor: " + loc_aResultado[i, 3]
            ? "   Linha: " + ALLTRIM(STR(loc_aResultado[i, 4]))
            ? ""
        ENDFOR
    ENDIF

    ? "Teste concluido com sucesso!"

CATCH TO loEx
    ? "ERRO: " + loEx.Message
    ? "Linha: " + ALLTRIM(STR(loEx.LineNo))
    ? "Procedimento: " + loEx.Procedure
ENDTRY
