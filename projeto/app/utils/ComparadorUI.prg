*====================================================================
* ComparadorUI.prg
*
* Classe para comparar propriedades visuais entre original e migrado
*
* Uso:
*   loc_oComparador = CREATEOBJECT("ComparadorUI")
*   loc_oComparador.Comparar(loc_aPropsOriginal, loc_oFormMigrado)
*
* Retorno:
*   Armazena diferencas em THIS.aDiferencas e THIS.nDiferencasEncontradas
*====================================================================

DEFINE CLASS ComparadorUI AS Custom

    *-- Array de diferencas encontradas
    DIMENSION aDiferencas[1, 7]
    nDiferencasEncontradas = 0

    *-- Tolerancia para valores numericos (pixels)
    nTolerancia = 2

    *-- Mapeamento de objetos (original -> migrado)
    DIMENSION aMapeamento[1, 2]
    nMapeamentos = 0
    cArquivoMapeamento = ""  && Caminho do JSON de mapeamento

    *====================================================================
    * Comparar
    * Compara propriedades do ExtratorPropriedades com form migrado
    * par_oExtrator - Objeto ExtratorPropriedades com dados extraidos
    * par_oFormMigrado - Form migrado a ser comparado
    *====================================================================
    PROCEDURE Comparar(par_oExtrator, par_oFormMigrado)
        LOCAL i, loc_cObjeto, loc_cProp, loc_cValorOriginal
        LOCAL loc_oObjetoMigrado, loc_vValorMigrado
        LOCAL loc_lDiferente

        THIS.nDiferencasEncontradas = 0
        DIMENSION THIS.aDiferencas[1, 7]

        *-- Valida objeto extrator
        IF ISNULL(par_oExtrator)
            ? "ERRO ComparadorUI: Extrator eh NULL"
            RETURN
        ENDIF

        IF par_oExtrator.nResultados = 0
            ? "ERRO ComparadorUI: Nenhuma propriedade no extrator"
            RETURN
        ENDIF

        *-- Variavel publica para controlar debug
        PUBLIC gb_DebugResolucao
        gb_DebugResolucao = .F.

        *-- Percorre propriedades do original (direto do objeto)
        FOR i = 1 TO par_oExtrator.nResultados
            loc_cObjeto = par_oExtrator.aResultados[i, 1]
            loc_cProp = par_oExtrator.aResultados[i, 2]
            loc_cValorOriginal = par_oExtrator.aResultados[i, 3]

            *-- Debug apenas nas primeiras 3 propriedades
            IF i <= 3
                ? ""
                ? "=== Comparando propriedade " + ALLTRIM(STR(i)) + " de " + ALLTRIM(STR(par_oExtrator.nResultados)) + " ==="
                ? "Objeto: [" + loc_cObjeto + "]"
                ? "Propriedade: " + loc_cProp + " = [" + loc_cValorOriginal + "]"
                gb_DebugResolucao = .T.
            ELSE
                gb_DebugResolucao = .F.
            ENDIF

            *-- Tenta acessar objeto no form migrado
            loc_oObjetoMigrado = THIS.ResolverObjeto(par_oFormMigrado, loc_cObjeto)

            LOCAL loc_lObjetoValido
            loc_lObjetoValido = .F.
            IF TYPE("loc_oObjetoMigrado") = "O"
                IF NOT ISNULL(loc_oObjetoMigrado)
                    loc_lObjetoValido = .T.
                ENDIF
            ENDIF

            IF NOT loc_lObjetoValido
                *-- Objeto nao encontrado no form migrado (ou retornou valor nao-objeto)
                *-- Classificar como AVISO (nao ERRO) quando:
                *--   1. Caminho comeca com nome do form legado (ex: SIGOPIND.Page.xxx)
                *--      -> renomeacao de hierarquia esperada na nova arquitetura
                *--   2. Objeto pai tem mapeamento mas filho tem nome legado
                *--      -> filho renomeado com sufixo _4c_ (esperado)
                LOCAL loc_cTipoProblema
                loc_cTipoProblema = "ERRO"

                *-- Se o caminho tem pai mapeado (lookup progressivo encontrou algo),
                *-- o filho nao encontrado eh resultado da renomeacao, nao de omissao
                IF THIS.nMapeamentos > 0 AND "." $ loc_cObjeto
                    LOCAL loc_jj, loc_cPaiTest, loc_nUltPonto
                    loc_nUltPonto = RAT(".", loc_cObjeto)
                    IF loc_nUltPonto > 0
                        loc_cPaiTest = LEFT(loc_cObjeto, loc_nUltPonto - 1)
                        *-- Verifica se algum prefixo do caminho esta no mapeamento
                        DO WHILE !EMPTY(loc_cPaiTest)
                            FOR loc_jj = 1 TO THIS.nMapeamentos
                                IF UPPER(THIS.aMapeamento[loc_jj, 1]) = UPPER(loc_cPaiTest)
                                    *-- Pai encontrado no mapeamento -> filho renomeado (esperado)
                                    loc_cTipoProblema = "AVISO"
                                    EXIT
                                ENDIF
                            ENDFOR
                            IF loc_cTipoProblema = "AVISO"
                                EXIT
                            ENDIF
                            loc_nUltPonto = RAT(".", loc_cPaiTest)
                            IF loc_nUltPonto = 0
                                EXIT
                            ENDIF
                            loc_cPaiTest = LEFT(loc_cPaiTest, loc_nUltPonto - 1)
                        ENDDO
                    ENDIF
                ENDIF

                THIS.AdicionarDiferenca(loc_cObjeto, loc_cProp, loc_cValorOriginal, ;
                                        "(objeto n" + CHR(227) + "o encontrado)", ;
                                        loc_cTipoProblema, par_oExtrator.aResultados[i, 4], par_oExtrator.aResultados[i, 5])
                LOOP
            ENDIF

            *-- Verifica se propriedade existe
            IF !PEMSTATUS(loc_oObjetoMigrado, loc_cProp, 5)
                *-- Propriedade nao existe
                THIS.AdicionarDiferenca(loc_cObjeto, loc_cProp, loc_cValorOriginal, ;
                                        "(propriedade n" + CHR(227) + "o existe)", ;
                                        "AVISO", par_oExtrator.aResultados[i, 4], par_oExtrator.aResultados[i, 5])
                LOOP
            ENDIF

            *-- Obtem valor atual da propriedade (GETPEM eh mais seguro que EVALUATE)
            LOCAL loc_lErroAcesso
            loc_lErroAcesso = .F.
            TRY
                loc_vValorMigrado = GETPEM(loc_oObjetoMigrado, loc_cProp)
            CATCH
                loc_lErroAcesso = .T.
            ENDTRY

            IF loc_lErroAcesso
                THIS.AdicionarDiferenca(loc_cObjeto, loc_cProp, loc_cValorOriginal, ;
                                        "(erro ao acessar)", ;
                                        "ERRO", par_oExtrator.aResultados[i, 4], par_oExtrator.aResultados[i, 5])
                LOOP
            ENDIF

            *-- Compara valores
            loc_lDiferente = THIS.ValoresDiferentes(loc_cValorOriginal, loc_vValorMigrado, loc_cProp)

            IF loc_lDiferente
                THIS.AdicionarDiferenca(loc_cObjeto, loc_cProp, loc_cValorOriginal, ;
                                        THIS.FormatarValor(loc_vValorMigrado, loc_cProp), ;
                                        "DIFERENCA", par_oExtrator.aResultados[i, 4], par_oExtrator.aResultados[i, 5])
            ENDIF
        ENDFOR
    ENDPROC

    *====================================================================
    * ResolverObjeto
    * Resolve caminho do objeto no form migrado
    * Exemplo: "pgf_Principal.Page1" -> par_oForm.pgf_Principal.Page1
    *====================================================================
    PROTECTED PROCEDURE ResolverObjeto(par_oForm, par_cCaminho)
        LOCAL loc_cExpressao, loc_oObjeto
        LOCAL loc_cCaminhoOriginal
        LOCAL loc_lDebug

        *-- Verifica se variavel de debug existe
        loc_lDebug = TYPE("gb_DebugResolucao") = "L" AND gb_DebugResolucao

        IF par_cCaminho = "Form"
            RETURN par_oForm
        ENDIF

        *-- Guarda caminho original para mapeamento
        loc_cCaminhoOriginal = par_cCaminho

        *-- Se mapeamento carregado, usa-o para resolver o caminho
        IF THIS.nMapeamentos > 0
            IF loc_lDebug
                ? "  [DEBUG] Mapeamentos carregados: " + ALLTRIM(STR(THIS.nMapeamentos))
                ? "  [DEBUG] Buscando: [" + loc_cCaminhoOriginal + "]"
            ENDIF

            par_cCaminho = THIS.ResolverObjetoComMapeamento(par_cCaminho)

            IF loc_lDebug
                ? "  [DEBUG] Mapeado para: [" + par_cCaminho + "]"
            ENDIF

            *-- Se mapeou para "Form", retorna o form
            IF UPPER(par_cCaminho) = "FORM"
                RETURN par_oForm
            ENDIF
        ELSE
            IF loc_lDebug
                ? "  [DEBUG] Sem mapeamento, usando fallback"
            ENDIF

            *-- Sem mapeamento: Remove prefixos comuns do sistema legado (fallback)
            par_cCaminho = STRTRAN(par_cCaminho, "Sigcdcor.", "")
            par_cCaminho = STRTRAN(par_cCaminho, "Sigcdcar.", "")
            par_cCaminho = STRTRAN(par_cCaminho, "Sigcddpt.", "")
            par_cCaminho = STRTRAN(par_cCaminho, "SigRePLc.", "")
            par_cCaminho = STRTRAN(par_cCaminho, "Sigcdpro.", "")
        ENDIF

        *-- Monta expressao para avaliar
        loc_cExpressao = "par_oForm." + par_cCaminho

        IF loc_lDebug
            ? "  [DEBUG] Avaliando: [" + loc_cExpressao + "]"
        ENDIF

        *-- Tenta avaliar (sem TRY/CATCH para evitar RETURN dentro)
        loc_oObjeto = .NULL.

        TRY
            loc_oObjeto = EVALUATE(loc_cExpressao)
            IF loc_lDebug
                IF ISNULL(loc_oObjeto)
                    ? "  [DEBUG] Resultado: NULL (n" + CHR(227) + "o encontrado)"
                ELSE
                    ? "  [DEBUG] Resultado: Objeto encontrado!"
                ENDIF
            ENDIF
        CATCH
            IF loc_lDebug
                ? "  [DEBUG] ERRO ao avaliar express" + CHR(227) + "o"
            ENDIF
            *-- Ignora erro, retorna NULL
        ENDTRY

        RETURN loc_oObjeto
    ENDPROC

    *====================================================================
    * ValoresDiferentes
    * Compara dois valores considerando tipo e tolerancia
    *====================================================================
    PROTECTED PROCEDURE ValoresDiferentes(par_vOriginal, par_vMigrado, par_cProp)
        LOCAL loc_cOriginalStr, loc_cMigradoStr
        LOCAL loc_nOriginal, loc_nMigrado

        *-- Converte valores para string para comparacao
        loc_cOriginalStr = THIS.FormatarValor(par_vOriginal, par_cProp)
        loc_cMigradoStr = THIS.FormatarValor(par_vMigrado, par_cProp)

        *-- Normalizar Picture: comparar apenas nome do arquivo (paths diferentes sao OK)
        IF par_cProp = "Picture"
            loc_cOriginalStr = UPPER(JUSTFNAME(loc_cOriginalStr))
            loc_cMigradoStr = UPPER(JUSTFNAME(loc_cMigradoStr))
        ENDIF

        *-- Normalizar Caption: remover hotkey markers \<
        IF par_cProp = "Caption"
            loc_cOriginalStr = STRTRAN(loc_cOriginalStr, "\<", "")
            loc_cMigradoStr = STRTRAN(loc_cMigradoStr, "\<", "")
        ENDIF

        *-- Caption dinamica: expressoes VFP como (prompt()) nao sao comparaveis
        IF par_cProp = "Caption" AND LEFT(ALLTRIM(loc_cOriginalStr), 1) = "("
            RETURN .F.
        ENDIF

        *-- Se strings sao identicas, nao ha diferenca
        IF loc_cOriginalStr == loc_cMigradoStr
            RETURN .F.
        ENDIF

        *-- Para propriedades numericas (Width, Height, Top, Left), aplica tolerancia
        IF INLIST(par_cProp, "Width", "Height", "Top", "Left")
            loc_nOriginal = VAL(loc_cOriginalStr)
            loc_nMigrado = VAL(loc_cMigradoStr)

            IF ABS(loc_nOriginal - loc_nMigrado) <= THIS.nTolerancia
                RETURN .F.  && Diferenca dentro da tolerancia
            ENDIF
        ENDIF

        *-- Valores diferentes
        RETURN .T.
    ENDPROC

    *====================================================================
    * FormatarValor
    * Formata valor para string comparavel
    *====================================================================
    PROTECTED PROCEDURE FormatarValor(par_vValor, par_cProp)
        LOCAL loc_cTipo, loc_cRetorno

        loc_cTipo = VARTYPE(par_vValor)

        DO CASE
        CASE loc_cTipo = "C"
            *-- String
            *-- Se for propriedade de cor no formato "90,90,90", normaliza para RGB()
            IF (par_cProp = "BackColor" OR par_cProp = "ForeColor") AND "," $ par_vValor
                *-- Verifica se ja esta no formato RGB()
                IF LEFT(UPPER(ALLTRIM(par_vValor)), 4) != "RGB("
                    RETURN THIS.TextoParaRGB(par_vValor)
                ENDIF
            ENDIF
            RETURN ALLTRIM(par_vValor)

        CASE loc_cTipo = "N"
            *-- Numero
            IF par_cProp = "BackColor" OR par_cProp = "ForeColor"
                *-- Converte numero para RGB(r,g,b)
                RETURN THIS.NumeroParaRGB(par_vValor)
            ELSE
                RETURN ALLTRIM(STR(par_vValor, 10, 0))
            ENDIF

        CASE loc_cTipo = "L"
            *-- Logico
            RETURN IIF(par_vValor, ".T.", ".F.")

        OTHERWISE
            RETURN ""
        ENDCASE
    ENDPROC

    *====================================================================
    * TextoParaRGB
    * Converte texto "90,90,90" para formato "RGB(90,90,90)"
    *====================================================================
    PROTECTED PROCEDURE TextoParaRGB(par_cCor)
        LOCAL loc_nR, loc_nG, loc_nB, loc_cTexto, loc_nPos1, loc_nPos2, loc_cResto

        loc_cTexto = ALLTRIM(par_cCor)

        *-- Remove espacos em branco
        loc_cTexto = STRTRAN(loc_cTexto, " ", "")

        *-- Extrai componentes
        loc_nPos1 = AT(",", loc_cTexto)
        IF loc_nPos1 = 0
            RETURN par_cCor  && Nao eh formato esperado, retorna original
        ENDIF

        loc_nR = VAL(LEFT(loc_cTexto, loc_nPos1 - 1))

        loc_cResto = SUBSTR(loc_cTexto, loc_nPos1 + 1)
        loc_nPos2 = AT(",", loc_cResto)

        IF loc_nPos2 = 0
            RETURN par_cCor  && Nao eh formato esperado, retorna original
        ENDIF

        loc_nG = VAL(LEFT(loc_cResto, loc_nPos2 - 1))
        loc_nB = VAL(SUBSTR(loc_cResto, loc_nPos2 + 1))

        RETURN "RGB(" + ALLTRIM(STR(loc_nR)) + "," + ;
                        ALLTRIM(STR(loc_nG)) + "," + ;
                        ALLTRIM(STR(loc_nB)) + ")"
    ENDPROC

    *====================================================================
    * NumeroParaRGB
    * Converte numero de cor para formato RGB(r,g,b)
    *====================================================================
    PROTECTED PROCEDURE NumeroParaRGB(par_nCor)
        LOCAL loc_nR, loc_nG, loc_nB

        IF VARTYPE(par_nCor) != "N"
            RETURN ALLTRIM(par_nCor)
        ENDIF

        *-- Extrai componentes RGB
        loc_nR = BITAND(par_nCor, 0xFF)
        loc_nG = BITAND(BITRSHIFT(par_nCor, 8), 0xFF)
        loc_nB = BITAND(BITRSHIFT(par_nCor, 16), 0xFF)

        RETURN "RGB(" + ALLTRIM(STR(loc_nR)) + "," + ;
                        ALLTRIM(STR(loc_nG)) + "," + ;
                        ALLTRIM(STR(loc_nB)) + ")"
    ENDPROC

    *====================================================================
    * AdicionarDiferenca
    * Adiciona diferenca ao array de resultados
    *====================================================================
    PROTECTED PROCEDURE AdicionarDiferenca(par_cObjeto, par_cProp, par_cValorOriginal, ;
                                           par_cValorMigrado, par_cTipo, par_nLinha, par_cContexto)
        THIS.nDiferencasEncontradas = THIS.nDiferencasEncontradas + 1

        IF THIS.nDiferencasEncontradas > ALEN(THIS.aDiferencas, 1)
            DIMENSION THIS.aDiferencas[THIS.nDiferencasEncontradas + 50, 7]  && Expande em blocos
        ENDIF

        THIS.aDiferencas[THIS.nDiferencasEncontradas, 1] = par_cObjeto
        THIS.aDiferencas[THIS.nDiferencasEncontradas, 2] = par_cProp
        THIS.aDiferencas[THIS.nDiferencasEncontradas, 3] = par_cValorOriginal
        THIS.aDiferencas[THIS.nDiferencasEncontradas, 4] = par_cValorMigrado
        THIS.aDiferencas[THIS.nDiferencasEncontradas, 5] = par_cTipo
        THIS.aDiferencas[THIS.nDiferencasEncontradas, 6] = par_nLinha
        THIS.aDiferencas[THIS.nDiferencasEncontradas, 7] = par_cContexto
    ENDPROC

    *====================================================================
    * CarregarMapeamento
    * Carrega mapeamento de arquivo JSON
    *====================================================================
    PROCEDURE CarregarMapeamento(par_cArquivoJSON)
        LOCAL loc_nHandle, loc_cJSON, loc_cLinha
        LOCAL loc_cOriginal, loc_cNovo
        LOCAL loc_nPos1, loc_nPos2

        THIS.cArquivoMapeamento = par_cArquivoJSON
        THIS.nMapeamentos = 0
        DIMENSION THIS.aMapeamento[1, 2]

        *-- Verifica se arquivo existe
        IF !FILE(par_cArquivoJSON)
            ? "AVISO ComparadorUI: Arquivo de mapeamento n" + CHR(227) + "o encontrado: " + par_cArquivoJSON
            RETURN .F.
        ENDIF

        *-- Le arquivo
        loc_nHandle = FOPEN(par_cArquivoJSON, 0)

        IF loc_nHandle < 0
            ? "ERRO ComparadorUI: N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir arquivo de mapeamento"
            RETURN .F.
        ENDIF

        ? "Carregando mapeamento: " + par_cArquivoJSON
        ? "DEBUG: Iniciando leitura do JSON..."

        LOCAL loc_nLinhas, loc_nLinhasProcessadas, loc_nLinhasIgnoradas
        loc_nLinhas = 0
        loc_nLinhasProcessadas = 0
        loc_nLinhasIgnoradas = 0

        *-- Le linha por linha e extrai mapeamentos
        DO WHILE !FEOF(loc_nHandle)
            loc_cLinha = FGETS(loc_nHandle)
            loc_nLinhas = loc_nLinhas + 1

            *-- Debug ANTES do ALLTRIM
            IF loc_nLinhas <= 10
                ? "  Linha " + ALLTRIM(STR(loc_nLinhas)) + " (len=" + ALLTRIM(STR(LEN(loc_cLinha))) + "): [" + LEFT(loc_cLinha, 80) + "]"
            ENDIF

            loc_cLinha = ALLTRIM(loc_cLinha)

            *-- Debug APOS o ALLTRIM
            IF loc_nLinhas <= 10
                ? "    Apos ALLTRIM (len=" + ALLTRIM(STR(LEN(loc_cLinha))) + "): [" + LEFT(loc_cLinha, 80) + "]"
            ENDIF

            *-- Pula linhas vazias
            IF EMPTY(loc_cLinha)
                IF loc_nLinhas <= 10
                    ? "    -> Linha vazia, pulando"
                ENDIF
                loc_nLinhasIgnoradas = loc_nLinhasIgnoradas + 1
                LOOP
            ENDIF

            *-- Procura por linhas no formato: "original": "novo"
            IF CHR(34) $ loc_cLinha AND ":" $ loc_cLinha
                IF loc_nLinhas <= 10
                    ? "    -> Tem aspas e dois pontos, processando..."
                ENDIF

                *-- Extrai primeira string (entre primeira e segunda aspas)
                loc_nPos1 = AT(CHR(34), loc_cLinha)  && Primeira aspa
                IF loc_nPos1 = 0
                    loc_nLinhasIgnoradas = loc_nLinhasIgnoradas + 1
                    LOOP
                ENDIF

                loc_nPos2 = AT(CHR(34), loc_cLinha, 2)  && Segunda aspa (2a ocorrencia)
                IF loc_nPos2 = 0
                    LOOP
                ENDIF

                loc_cOriginal = SUBSTR(loc_cLinha, loc_nPos1 + 1, loc_nPos2 - loc_nPos1 - 1)

                IF loc_nLinhas <= 10
                    ? "    Extraiu primeira string: [" + loc_cOriginal + "] (pos " + ALLTRIM(STR(loc_nPos1)) + "-" + ALLTRIM(STR(loc_nPos2)) + ")"
                ENDIF

                *-- Procura dois pontos APOS a segunda aspa
                *-- Usa SUBSTR para pegar substring a partir de loc_nPos2
                LOCAL loc_cResto, loc_nPosResto
                loc_cResto = SUBSTR(loc_cLinha, loc_nPos2 + 1)  && Tudo apos a segunda aspa
                loc_nPosResto = AT(":", loc_cResto)

                IF loc_nPosResto = 0
                    IF loc_nLinhas <= 10
                        ? "    -> LOOP: Nao tem ':' depois da primeira string"
                    ENDIF
                    LOOP
                ENDIF

                *-- Ajusta posicao para referencia na string original
                loc_nPos1 = loc_nPos2 + loc_nPosResto

                IF loc_nLinhas <= 10
                    ? "    Encontrou ':' na pos " + ALLTRIM(STR(loc_nPos1))
                ENDIF

                *-- Procura terceira aspa (abre segunda string) APOS os dois pontos
                loc_cResto = SUBSTR(loc_cLinha, loc_nPos1 + 1)
                loc_nPosResto = AT(CHR(34), loc_cResto)

                IF loc_nPosResto = 0
                    IF loc_nLinhas <= 10
                        ? "    -> LOOP: Nao tem aspa depois do ':'"
                    ENDIF
                    LOOP
                ENDIF

                loc_nPos1 = loc_nPos1 + loc_nPosResto  && Posicao da terceira aspa

                IF loc_nLinhas <= 10
                    ? "    Encontrou terceira aspa na pos " + ALLTRIM(STR(loc_nPos1))
                ENDIF

                *-- Procura quarta aspa (fecha segunda string)
                loc_cResto = SUBSTR(loc_cLinha, loc_nPos1 + 1)
                loc_nPosResto = AT(CHR(34), loc_cResto)

                IF loc_nPosResto = 0
                    IF loc_nLinhas <= 10
                        ? "    -> LOOP: Nao tem quarta aspa"
                    ENDIF
                    LOOP
                ENDIF

                loc_nPos2 = loc_nPos1 + loc_nPosResto  && Posicao da quarta aspa

                IF loc_nLinhas <= 10
                    ? "    Encontrou quarta aspa na pos " + ALLTRIM(STR(loc_nPos2))
                ENDIF

                *-- Extrai segunda string
                loc_cNovo = SUBSTR(loc_cLinha, loc_nPos1 + 1, loc_nPos2 - loc_nPos1 - 1)

                IF loc_nLinhas <= 10
                    ? "    Extraiu segunda string: [" + loc_cNovo + "]"
                ENDIF

                *-- Debug: primeiras extrações
                IF loc_nLinhas <= 10
                    ? "    Extraido: [" + loc_cOriginal + "] -> [" + loc_cNovo + "]"
                ENDIF

                *-- Ignora linhas de metadados (form_original, form_migrado, entidade)
                IF !INLIST(loc_cOriginal, "form_original", "form_migrado", "entidade", "mapeamento")
                    *-- Adiciona ao array
                    THIS.nMapeamentos = THIS.nMapeamentos + 1
                    loc_nLinhasProcessadas = loc_nLinhasProcessadas + 1

                    IF THIS.nMapeamentos > ALEN(THIS.aMapeamento, 1)
                        DIMENSION THIS.aMapeamento[THIS.nMapeamentos + 50, 2]
                    ENDIF

                    THIS.aMapeamento[THIS.nMapeamentos, 1] = loc_cOriginal
                    THIS.aMapeamento[THIS.nMapeamentos, 2] = loc_cNovo

                    *-- Debug: primeiros mapeamentos
                    IF THIS.nMapeamentos <= 3
                        ? "    -> Mapeamento " + ALLTRIM(STR(THIS.nMapeamentos)) + " adicionado!"
                    ENDIF
                ELSE
                    IF loc_nLinhas <= 10
                        ? "    -> Ignorado (metadados)"
                    ENDIF
                ENDIF
            ELSE
                loc_nLinhasIgnoradas = loc_nLinhasIgnoradas + 1
            ENDIF
        ENDDO

        FCLOSE(loc_nHandle)

        ? "DEBUG: Total linhas lidas: " + ALLTRIM(STR(loc_nLinhas))
        ? "DEBUG: Linhas processadas: " + ALLTRIM(STR(loc_nLinhasProcessadas))
        ? "DEBUG: Linhas ignoradas: " + ALLTRIM(STR(loc_nLinhasIgnoradas))
        ? "  - " + ALLTRIM(STR(THIS.nMapeamentos)) + " mapeamentos carregados"

        RETURN .T.
    ENDPROC

    *====================================================================
    * ResolverObjetoComMapeamento
    * Resolve caminho do objeto usando mapeamento
    * Decompoe o caminho em partes e mapeia cada uma individualmente
    *====================================================================
    PROTECTED PROCEDURE ResolverObjetoComMapeamento(par_cCaminhoOriginal)
        LOCAL i, loc_cCaminhoNovo, loc_cCaminhoAcumulado
        LOCAL loc_nPartes, loc_aParte[1], loc_cParteOriginal, loc_cParteNova
        LOCAL loc_cCaminhoCompleto

        *-- Se o caminho esta mapeado diretamente, usa o mapeamento direto
        FOR i = 1 TO THIS.nMapeamentos
            IF UPPER(THIS.aMapeamento[i, 1]) = UPPER(par_cCaminhoOriginal)
                *-- Mapeamento direto encontrado, mas precisa construir caminho completo
                *-- incluindo os pais (PageFrame, Page, etc.)
                RETURN THIS.ConstruirCaminhoCompleto(par_cCaminhoOriginal, THIS.aMapeamento[i, 2])
            ENDIF
        ENDFOR

        *-- Nao encontrou mapeamento direto
        *-- Tenta lookup progressivo: encontra o prefixo mais longo que tem mapeamento
        *-- e concatena o sufixo restante (filhos nao mapeados explicitamente)
        *-- Ex: "SIGOPIND.Page.SALDO.cntSombra.lblSombra"
        *--   -> prefixo "SIGOPIND.Page.SALDO.cntSombra" mapeado para "cnt_4c_Sombra"
        *--   -> sufixo ".lblSombra" (filho nao mapeado)
        *--   -> resultado: "pgf_4c_Principal.Page1.cnt_4c_Sombra.lblSombra"
        LOCAL loc_cTentativa, loc_cSufixo, loc_nUltimoPonto, loc_cCaminhoMapeado
        loc_cTentativa = par_cCaminhoOriginal
        loc_cSufixo = ""

        DO WHILE .T.
            loc_nUltimoPonto = RAT(".", loc_cTentativa)
            IF loc_nUltimoPonto = 0
                EXIT
            ENDIF

            *-- Acumula a parte removida no sufixo
            IF EMPTY(loc_cSufixo)
                loc_cSufixo = SUBSTR(loc_cTentativa, loc_nUltimoPonto + 1)
            ELSE
                loc_cSufixo = SUBSTR(loc_cTentativa, loc_nUltimoPonto + 1) + "." + loc_cSufixo
            ENDIF

            *-- Tenta prefixo menor
            loc_cTentativa = LEFT(loc_cTentativa, loc_nUltimoPonto - 1)

            *-- Procura no mapeamento
            FOR i = 1 TO THIS.nMapeamentos
                IF UPPER(THIS.aMapeamento[i, 1]) = UPPER(loc_cTentativa)
                    *-- Encontrou! Constroi caminho do prefixo e concatena sufixo
                    loc_cCaminhoMapeado = THIS.ConstruirCaminhoCompleto(loc_cTentativa, THIS.aMapeamento[i, 2])
                    RETURN loc_cCaminhoMapeado + "." + loc_cSufixo
                ENDIF
            ENDFOR
        ENDDO

        *-- Nenhum prefixo encontrado no mapeamento, retorna original
        RETURN par_cCaminhoOriginal
    ENDPROC

    *====================================================================
    * ConstruirCaminhoCompleto
    * Constroi caminho completo mapeando cada parte hierarquicamente
    * Exemplo: "SIGCDCOR.Pagina.Dados.Say1" -> "pgf_4c_Principal.Page2.lbl_4c_Codigo"
    *====================================================================
    PROTECTED PROCEDURE ConstruirCaminhoCompleto(par_cCaminhoOriginal, par_cNomeFinal)
        LOCAL i, loc_cCaminhoAcumulado, loc_aCaminhoNovo[1], loc_nPosAtual
        LOCAL loc_cParteOriginal, loc_cParteNova, loc_nPos, loc_cResto, loc_cCaminhoFinal
        LOCAL loc_lDebug

        loc_lDebug = TYPE("gb_DebugResolucao") = "L" AND gb_DebugResolucao

        IF loc_lDebug
            ? "    [ConstruirCaminho] Original=[" + par_cCaminhoOriginal + "] NomeFinal=[" + par_cNomeFinal + "]"
        ENDIF

        *-- Inicializa array para armazenar partes do caminho novo
        DIMENSION loc_aCaminhoNovo[1]
        loc_nPosAtual = 0

        *-- Divide o caminho original em partes
        *-- Ex: "SIGCDCOR.Pagina.Dados.Say1" -> ["SIGCDCOR", "SIGCDCOR.Pagina", "SIGCDCOR.Pagina.Dados"]
        loc_cCaminhoAcumulado = ""

        DO WHILE .T.
            *-- Pega proximo componente
            IF EMPTY(loc_cCaminhoAcumulado)
                *-- Primeiro componente
                loc_nPos = AT(".", par_cCaminhoOriginal)
                IF loc_nPos = 0
                    *-- Caminho tem apenas 1 componente
                    loc_cCaminhoAcumulado = par_cCaminhoOriginal
                ELSE
                    loc_cCaminhoAcumulado = LEFT(par_cCaminhoOriginal, loc_nPos - 1)
                ENDIF
            ELSE
                *-- Proximo componente
                loc_cResto = SUBSTR(par_cCaminhoOriginal, LEN(loc_cCaminhoAcumulado) + 2)
                loc_nPos = AT(".", loc_cResto)

                IF loc_nPos = 0
                    *-- Chegou no ultimo componente
                    EXIT
                ELSE
                    loc_cCaminhoAcumulado = loc_cCaminhoAcumulado + "." + LEFT(loc_cResto, loc_nPos - 1)
                ENDIF
            ENDIF

            *-- Procura mapeamento para este nivel
            FOR i = 1 TO THIS.nMapeamentos
                IF UPPER(THIS.aMapeamento[i, 1]) = UPPER(loc_cCaminhoAcumulado)
                    loc_cParteNova = THIS.aMapeamento[i, 2]

                    *-- Ignora "Form" (nao adiciona ao caminho)
                    IF UPPER(loc_cParteNova) != "FORM"
                        *-- Adiciona ao array
                        loc_nPosAtual = loc_nPosAtual + 1
                        DIMENSION loc_aCaminhoNovo[loc_nPosAtual]
                        loc_aCaminhoNovo[loc_nPosAtual] = loc_cParteNova
                    ENDIF
                    EXIT
                ENDIF
            ENDFOR

            *-- Verifica se chegou no final
            IF loc_cCaminhoAcumulado = par_cCaminhoOriginal
                EXIT
            ENDIF
        ENDDO

        *-- Adiciona o nome final APENAS se ainda nao foi mapeado
        *-- Se loc_cCaminhoAcumulado = par_cCaminhoOriginal, significa que o
        *-- caminho completo foi mapeado no loop e o nome final ja foi adicionado
        IF loc_cCaminhoAcumulado != par_cCaminhoOriginal OR loc_nPosAtual = 0
            loc_nPosAtual = loc_nPosAtual + 1
            DIMENSION loc_aCaminhoNovo[loc_nPosAtual]
            loc_aCaminhoNovo[loc_nPosAtual] = par_cNomeFinal
        ENDIF

        *-- Reconstroi caminho completo juntando com "."
        loc_cCaminhoFinal = ""

        FOR i = 1 TO loc_nPosAtual
            IF i = 1
                loc_cCaminhoFinal = loc_aCaminhoNovo[i]
            ELSE
                loc_cCaminhoFinal = loc_cCaminhoFinal + "." + loc_aCaminhoNovo[i]
            ENDIF
        ENDFOR

        IF loc_lDebug
            ? "    [ConstruirCaminho] Resultado=[" + loc_cCaminhoFinal + "]"
        ENDIF

        RETURN loc_cCaminhoFinal
    ENDPROC

ENDDEFINE
