*====================================================================
* TestarExtrator_v2.prg
* Testa versao 2 do ExtratorPropriedades (sem RETURN de array)
*====================================================================

LOCAL loc_cArquivo, loc_oExtrator, i, loc_lSucesso

*-- Limpa .fxp
IF FILE("ExtratorPropriedades_v2.fxp")
    DELETE FILE ExtratorPropriedades_v2.fxp
ENDIF

*-- Carrega classe
SET PROCEDURE TO ExtratorPropriedades_v2.prg ADDITIVE

*-- Arquivo de teste
loc_cArquivo = "c:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt"

? "Testando ExtratorPropriedades v2..."
? "Arquivo: " + loc_cArquivo
? ""

*-- Testa extrator
TRY
    loc_oExtrator = CREATEOBJECT("ExtratorPropriedades")
    ? "Extrator criado com sucesso"

    *-- Chama ExtrairDeArquivo (agora retorna .T./.F.)
    loc_lSucesso = loc_oExtrator.ExtrairDeArquivo(loc_cArquivo)

    ? ""
    ? "Resultado: " + IIF(loc_lSucesso, "SUCESSO", "FALHA")
    ? "Propriedades encontradas: " + ALLTRIM(STR(loc_oExtrator.nResultados))
    ? ""

    IF !loc_lSucesso OR loc_oExtrator.nResultados = 0
        ? "ERRO: Nenhuma propriedade encontrada"
        RETURN
    ENDIF

    *-- Acessa array diretamente da propriedade do objeto
    ? "Array aResultados:"
    ? "  Dimensoes: " + ALLTRIM(STR(ALEN(loc_oExtrator.aResultados, 1))) + " linhas x " + ;
                         ALLTRIM(STR(ALEN(loc_oExtrator.aResultados, 2))) + " colunas"
    ? ""

    ? "Primeiras 10 propriedades encontradas:"
    ? "----------------------------------------"

    FOR i = 1 TO MIN(10, loc_oExtrator.nResultados)
        ? ALLTRIM(STR(i)) + ". Objeto: " + loc_oExtrator.aResultados[i, 1]
        ? "   Propriedade: " + loc_oExtrator.aResultados[i, 2]
        ? "   Valor: " + loc_oExtrator.aResultados[i, 3]
        ? "   Linha: " + ALLTRIM(STR(loc_oExtrator.aResultados[i, 4]))
        ? ""
    ENDFOR

    ? "Teste concluido com sucesso!"

CATCH TO loEx
    ? "ERRO: " + loEx.Message
    ? "Linha: " + ALLTRIM(STR(loEx.LineNo))
    ? "Procedimento: " + loEx.Procedure
ENDTRY
