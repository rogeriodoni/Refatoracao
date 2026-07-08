*==============================================================================
* ValidarCompilacao.prg
*
* PROPOSITO: Compila arquivos .prg e verifica erros de sintaxe
*            Gera arquivo .err se houver erros de compilacao
*
* CHAMADA:   DO ValidarCompilacao WITH "C:\4c\projeto\app\forms\cadastros\FormCor.prg"
*            OU com multiplos arquivos separados por ponto-e-virgula
*
* RETORNO:   0 = Sucesso (todos os arquivos compilaram)
*            1 = Erro de compilacao (ver arquivos .err)
*            99 = Erro de parametros
*
* SAIDA:     Arquivo resultado_compilacao.json no mesmo diretorio do primeiro arquivo
*
* AUTOR:     Sistema de Migracao Automatizada
* DATA:      2026-02-04
*==============================================================================

LPARAMETERS par_cArquivos

LOCAL loc_nReturnCode, loc_aArquivos[1], loc_nArquivos, loc_i
LOCAL loc_cArquivo, loc_cArquivoErr, loc_lTemErro
LOCAL loc_cResultadoJson, loc_cResultadoPath
LOCAL loc_aResultados[1, 3]  && [arquivo, sucesso, mensagem]

loc_nReturnCode = 0
loc_lTemErro = .F.

*-- Validacao de parametros
IF EMPTY(par_cArquivos)
    ? "ERRO: Parametro par_cArquivos obrigatorio"
    ? "USO: DO ValidarCompilacao WITH 'arquivo1.prg;arquivo2.prg'"
    RETURN 99
ENDIF

*-- Parseia lista de arquivos (separados por ;)
loc_nArquivos = ALINES(loc_aArquivos, par_cArquivos, 1, ";")

IF loc_nArquivos = 0
    ? "ERRO: Nenhum arquivo especificado"
    RETURN 99
ENDIF

*-- Redimensiona array de resultados
DIMENSION loc_aResultados[loc_nArquivos, 3]

? "=== VALIDACAO DE COMPILACAO ==="
? ""
? "Arquivos a validar: " + TRANSFORM(loc_nArquivos)
? ""

*-- Processa cada arquivo
FOR loc_i = 1 TO loc_nArquivos
    loc_cArquivo = ALLTRIM(loc_aArquivos[loc_i])

    IF EMPTY(loc_cArquivo)
        LOOP
    ENDIF

    ? "[" + TRANSFORM(loc_i) + "/" + TRANSFORM(loc_nArquivos) + "] " + JUSTFNAME(loc_cArquivo)

    *-- Verifica se arquivo existe
    IF !FILE(loc_cArquivo)
        ? "    ERRO: Arquivo nao encontrado"
        loc_aResultados[loc_i, 1] = loc_cArquivo
        loc_aResultados[loc_i, 2] = .F.
        loc_aResultados[loc_i, 3] = "Arquivo nao encontrado"
        loc_lTemErro = .T.
        LOOP
    ENDIF

    *-- Remove arquivo .err anterior se existir
    loc_cArquivoErr = FORCEEXT(loc_cArquivo, "err")
    IF FILE(loc_cArquivoErr)
        DELETE FILE (loc_cArquivoErr)
    ENDIF

    *-- Remove arquivo .fxp anterior se existir (forca recompilacao)
    loc_cArquivoFxp = FORCEEXT(loc_cArquivo, "fxp")
    IF FILE(loc_cArquivoFxp)
        DELETE FILE (loc_cArquivoFxp)
    ENDIF

    *-- Compila o arquivo
    TRY
        COMPILE (loc_cArquivo)

        *-- Verifica se gerou arquivo .err
        IF FILE(loc_cArquivoErr)
            ? "    ERRO: Falha na compilacao (ver " + JUSTFNAME(loc_cArquivoErr) + ")"

            *-- Le conteudo do erro
            LOCAL loc_cErroConteudo
            loc_cErroConteudo = FILETOSTR(loc_cArquivoErr)
            loc_cErroConteudo = STRTRAN(loc_cErroConteudo, CHR(13) + CHR(10), " | ")

            ? "    Detalhes: " + LEFT(loc_cErroConteudo, 200)

            loc_aResultados[loc_i, 1] = loc_cArquivo
            loc_aResultados[loc_i, 2] = .F.
            loc_aResultados[loc_i, 3] = loc_cErroConteudo
            loc_lTemErro = .T.
        ELSE
            ? "    OK - Compilado com sucesso"
            loc_aResultados[loc_i, 1] = loc_cArquivo
            loc_aResultados[loc_i, 2] = .T.
            loc_aResultados[loc_i, 3] = ""
        ENDIF

    CATCH TO loEx
        ? "    ERRO: Excecao durante compilacao: " + loEx.Message
        loc_aResultados[loc_i, 1] = loc_cArquivo
        loc_aResultados[loc_i, 2] = .F.
        loc_aResultados[loc_i, 3] = "Excecao: " + loEx.Message
        loc_lTemErro = .T.
    ENDTRY

    ? ""
ENDFOR

*-- Gera JSON de resultado
loc_cResultadoPath = JUSTPATH(loc_aArquivos[1])
IF EMPTY(loc_cResultadoPath)
    loc_cResultadoPath = SYS(5) + CURDIR()
ENDIF
loc_cResultadoPath = ADDBS(loc_cResultadoPath) + "resultado_compilacao.json"

loc_cResultadoJson = "{" + CHR(13) + CHR(10)
loc_cResultadoJson = loc_cResultadoJson + '  "timestamp": "' + TTOC(DATETIME(), 3) + '",' + CHR(13) + CHR(10)
loc_cResultadoJson = loc_cResultadoJson + '  "totalArquivos": ' + TRANSFORM(loc_nArquivos) + ',' + CHR(13) + CHR(10)
loc_cResultadoJson = loc_cResultadoJson + '  "sucesso": ' + IIF(loc_lTemErro, "false", "true") + ',' + CHR(13) + CHR(10)
loc_cResultadoJson = loc_cResultadoJson + '  "arquivos": [' + CHR(13) + CHR(10)

FOR loc_i = 1 TO loc_nArquivos
    IF !EMPTY(loc_aResultados[loc_i, 1])
        loc_cResultadoJson = loc_cResultadoJson + '    {' + CHR(13) + CHR(10)
        loc_cResultadoJson = loc_cResultadoJson + '      "arquivo": "' + STRTRAN(loc_aResultados[loc_i, 1], "\", "\\") + '",' + CHR(13) + CHR(10)
        loc_cResultadoJson = loc_cResultadoJson + '      "compilou": ' + IIF(loc_aResultados[loc_i, 2], "true", "false") + ',' + CHR(13) + CHR(10)

        *-- Escapa aspas e caracteres especiais na mensagem
        LOCAL loc_cMsgEscapada
        loc_cMsgEscapada = STRTRAN(loc_aResultados[loc_i, 3], '\', '\\')
        loc_cMsgEscapada = STRTRAN(loc_cMsgEscapada, '"', '\"')
        loc_cMsgEscapada = STRTRAN(loc_cMsgEscapada, CHR(13), '')
        loc_cMsgEscapada = STRTRAN(loc_cMsgEscapada, CHR(10), ' ')

        loc_cResultadoJson = loc_cResultadoJson + '      "mensagem": "' + loc_cMsgEscapada + '"' + CHR(13) + CHR(10)
        loc_cResultadoJson = loc_cResultadoJson + '    }'

        IF loc_i < loc_nArquivos AND !EMPTY(loc_aResultados[loc_i + 1, 1])
            loc_cResultadoJson = loc_cResultadoJson + ','
        ENDIF
        loc_cResultadoJson = loc_cResultadoJson + CHR(13) + CHR(10)
    ENDIF
ENDFOR

loc_cResultadoJson = loc_cResultadoJson + '  ]' + CHR(13) + CHR(10)
loc_cResultadoJson = loc_cResultadoJson + '}' + CHR(13) + CHR(10)

*-- Salva JSON (SET SAFETY OFF evita dialogo "already exists" em modo batch)
*-- NOTA: NAO reativar SET SAFETY ON - pipeline roda unattended
SET SAFETY OFF
STRTOFILE(loc_cResultadoJson, loc_cResultadoPath)

? "=== RESULTADO ==="
? ""
IF loc_lTemErro
    ? "STATUS: ERRO - Um ou mais arquivos nao compilaram"
    loc_nReturnCode = 1
ELSE
    ? "STATUS: SUCESSO - Todos os arquivos compilaram"
    loc_nReturnCode = 0
ENDIF

? ""
? "Resultado salvo em: " + loc_cResultadoPath
? ""

RETURN loc_nReturnCode
