*-- ExtratoReduzido.prg
*-- Cria versao reduzida (slim) do arquivo fonte para forms grandes
*-- Objetivo: Reduzir arquivos >400KB para evitar erro "Prompt is too long" no Claude CLI
*--
*-- Input: arquivo_fonte.txt (original extraido pelo ExtractSCXCode.prg)
*-- Output: arquivo_fonte_slim.txt (versao reduzida)
*--
*-- Estrategia de Reducao:
*-- - SECAO 1 (Estrutura): Manter 100%
*-- - SECAO 2 (Propriedades): Manter 100%
*-- - SECAO 3 (Metodos): Reduzir ~80% (remover metodos padrao/herdados)
*-- - SECAO 4 (Outros): Manter 100%
*--
*-- Resultado esperado: 696KB -> ~285KB (abaixo do limite de 400KB)
*--
*-- Uso:
*--   DO ExtratoReduzido WITH "C:\4c\tasks\task023\sigcdpgr_form_codigo_fonte.txt", 400
*--   Resultado: C:\4c\tasks\task023\sigcdpgr_form_codigo_fonte_slim.txt
*--

LPARAMETERS par_cArquivoOrigem, par_nLimiteKB

LOCAL loc_cArquivoSlim, loc_nTamanhoOriginalKB
LOCAL loc_oExtrator

*-- Validar parametros
IF EMPTY(par_cArquivoOrigem) OR !FILE(par_cArquivoOrigem)
    ? "ERRO: Arquivo de origem nao encontrado: " + TRANSFORM(par_cArquivoOrigem)
    RETURN ""
ENDIF

*-- Limite padrao: 400KB
IF EMPTY(par_nLimiteKB) OR par_nLimiteKB <= 0
    par_nLimiteKB = 400
ENDIF

*-- Verificar tamanho do arquivo usando ADIR()
LOCAL loc_aArquivo[1,5]
ADIR(loc_aArquivo, par_cArquivoOrigem)
loc_nTamanhoOriginalKB = loc_aArquivo[1,2] / 1024

? "ExtratoReduzido - Processando arquivo"
? "  Arquivo: " + par_cArquivoOrigem
? "  Tamanho: " + TRANSFORM(INT(loc_nTamanhoOriginalKB)) + " KB"
? "  Limite: " + TRANSFORM(par_nLimiteKB) + " KB"

*-- Se arquivo jah estah abaixo do limite, nao precisa reduzir
IF loc_nTamanhoOriginalKB <= par_nLimiteKB
    ? "  Resultado: Arquivo jah estah abaixo do limite, nao precisa reduzir"
    RETURN par_cArquivoOrigem
ENDIF

? "  Iniciando reducao..."

*-- Criar instancia do extrator
loc_oExtrator = CREATEOBJECT("ExtratorReduzido")

*-- Processar arquivo
loc_cArquivoSlim = loc_oExtrator.ProcessarArquivo(par_cArquivoOrigem, par_nLimiteKB)

IF !EMPTY(loc_cArquivoSlim) AND FILE(loc_cArquivoSlim)
    LOCAL loc_nTamanhoSlimKB, loc_aArquivoSlim[1,5]
    ADIR(loc_aArquivoSlim, loc_cArquivoSlim)
    loc_nTamanhoSlimKB = loc_aArquivoSlim[1,2] / 1024
    ? "  Resultado: Arquivo reduzido criado com sucesso"
    ? "  Novo arquivo: " + loc_cArquivoSlim
    ? "  Novo tamanho: " + TRANSFORM(INT(loc_nTamanhoSlimKB)) + " KB"
    ? "  Reducao: " + TRANSFORM(INT((1 - loc_nTamanhoSlimKB / loc_nTamanhoOriginalKB) * 100)) + "%"
ELSE
    ? "  ERRO: Falha ao criar arquivo reduzido"
ENDIF

*-- Liberar objeto
loc_oExtrator = .NULL.
RELEASE loc_oExtrator

RETURN loc_cArquivoSlim


*=====================================================================
* CLASSE: ExtratorReduzido
* Processa arquivo fonte e cria versao reduzida
*=====================================================================
DEFINE CLASS ExtratorReduzido AS Custom

    *-- Lista de metodos padrao a remover (herdados/eventos simples)
    DIMENSION this_aMetodosRemover[30]
    this_nMetodosRemover = 0

    *-- Lista de palavras-chave que indicam logica de negocio (MANTER)
    DIMENSION this_aPalavrasChaveManter[20]
    this_nPalavrasChaveManter = 0

    *-- Estatisticas
    this_nMetodosOriginais = 0
    this_nMetodosRemovidos = 0
    this_nMetodosMantidos = 0

    *-------------------------------------------------------------
    PROCEDURE Init()
        *-- Inicializar lista de metodos padrao a REMOVER
        *-- (eventos simples, metodos herdados que apenas chamam DODEFAULT)
        THIS.this_nMetodosRemover = 0

        THIS.AdicionarMetodoRemover("Init")
        THIS.AdicionarMetodoRemover("Destroy")
        THIS.AdicionarMetodoRemover("Refresh")
        THIS.AdicionarMetodoRemover("Click")
        THIS.AdicionarMetodoRemover("DblClick")
        THIS.AdicionarMetodoRemover("Load")
        THIS.AdicionarMetodoRemover("Unload")
        THIS.AdicionarMetodoRemover("GotFocus")
        THIS.AdicionarMetodoRemover("LostFocus")
        THIS.AdicionarMetodoRemover("When")
        THIS.AdicionarMetodoRemover("Valid")
        THIS.AdicionarMetodoRemover("Activate")
        THIS.AdicionarMetodoRemover("Deactivate")
        THIS.AdicionarMetodoRemover("KeyPress")
        THIS.AdicionarMetodoRemover("MouseMove")
        THIS.AdicionarMetodoRemover("MouseDown")
        THIS.AdicionarMetodoRemover("MouseUp")
        THIS.AdicionarMetodoRemover("InteractiveChange")
        THIS.AdicionarMetodoRemover("ProgrammaticChange")
        THIS.AdicionarMetodoRemover("Error")
        THIS.AdicionarMetodoRemover("Resize")
        THIS.AdicionarMetodoRemover("Moved")
        THIS.AdicionarMetodoRemover("Paint")
        THIS.AdicionarMetodoRemover("QueryUnload")
        THIS.AdicionarMetodoRemover("RightClick")
        THIS.AdicionarMetodoRemover("MiddleClick")
        THIS.AdicionarMetodoRemover("MouseWheel")
        THIS.AdicionarMetodoRemover("Scrolled")

        *-- Inicializar lista de palavras-chave que indicam logica de negocio (MANTER)
        THIS.this_nPalavrasChaveManter = 0

        THIS.AdicionarPalavraChaveManter("sigacess")
        THIS.AdicionarPalavraChaveManter("fwBuscaExt")
        THIS.AdicionarPalavraChaveManter("fwBuscaSel")
        THIS.AdicionarPalavraChaveManter("SQLEXEC")
        THIS.AdicionarPalavraChaveManter("SQLCOMMIT")
        THIS.AdicionarPalavraChaveManter("SQLROLLBACK")
        THIS.AdicionarPalavraChaveManter("MESSAGEBOX")
        THIS.AdicionarPalavraChaveManter("THISFORM.Gravar")
        THIS.AdicionarPalavraChaveManter("THISFORM.Salvar")
        THIS.AdicionarPalavraChaveManter("THISFORM.Excluir")
        THIS.AdicionarPalavraChaveManter("THISFORM.Validar")
        THIS.AdicionarPalavraChaveManter("THISFORM.Calcular")
        THIS.AdicionarPalavraChaveManter("THISFORM.Atualizar")
        THIS.AdicionarPalavraChaveManter("SELECT ")
        THIS.AdicionarPalavraChaveManter("INSERT ")
        THIS.AdicionarPalavraChaveManter("UPDATE ")
        THIS.AdicionarPalavraChaveManter("DELETE ")

        RETURN .T.
    ENDPROC

    *-------------------------------------------------------------
    PROTECTED PROCEDURE AdicionarMetodoRemover(par_cMetodo)
        THIS.this_nMetodosRemover = THIS.this_nMetodosRemover + 1
        DIMENSION THIS.this_aMetodosRemover[THIS.this_nMetodosRemover]
        THIS.this_aMetodosRemover[THIS.this_nMetodosRemover] = UPPER(par_cMetodo)
    ENDPROC

    *-------------------------------------------------------------
    PROTECTED PROCEDURE AdicionarPalavraChaveManter(par_cPalavra)
        THIS.this_nPalavrasChaveManter = THIS.this_nPalavrasChaveManter + 1
        DIMENSION THIS.this_aPalavrasChaveManter[THIS.this_nPalavrasChaveManter]
        THIS.this_aPalavrasChaveManter[THIS.this_nPalavrasChaveManter] = UPPER(par_cPalavra)
    ENDPROC

    *-------------------------------------------------------------
    * ProcessarArquivo - Metodo principal
    * Processa o arquivo fonte e cria versao reduzida
    *-------------------------------------------------------------
    PROCEDURE ProcessarArquivo(par_cArquivoOrigem, par_nLimiteKB)
        LOCAL loc_cConteudo, loc_cArquivoSlim
        LOCAL loc_cSecao1, loc_cSecao2, loc_cSecao3, loc_cSecao4
        LOCAL loc_cSecao3Reduzida, loc_cConteudoFinal
        LOCAL loc_nHandle

        *-- Resetar estatisticas
        THIS.this_nMetodosOriginais = 0
        THIS.this_nMetodosRemovidos = 0
        THIS.this_nMetodosMantidos = 0

        *-- Ler arquivo original
        loc_cConteudo = FILETOSTR(par_cArquivoOrigem)

        IF EMPTY(loc_cConteudo)
            ? "    ERRO: Arquivo vazio ou erro de leitura"
            RETURN ""
        ENDIF

        *-- Separar secoes
        ? "    Separando secoes..."
        loc_cSecao1 = THIS.ExtrairSecao(loc_cConteudo, "SECAO 1", "SECAO 2")
        loc_cSecao2 = THIS.ExtrairSecao(loc_cConteudo, "SECAO 2", "SECAO 3")
        loc_cSecao3 = THIS.ExtrairSecao(loc_cConteudo, "SECAO 3", "SECAO 4")
        loc_cSecao4 = THIS.ExtrairSecao(loc_cConteudo, "SECAO 4", "")

        ? "    Tamanho SECAO 1: " + TRANSFORM(LEN(loc_cSecao1)) + " bytes"
        ? "    Tamanho SECAO 2: " + TRANSFORM(LEN(loc_cSecao2)) + " bytes"
        ? "    Tamanho SECAO 3: " + TRANSFORM(LEN(loc_cSecao3)) + " bytes"
        ? "    Tamanho SECAO 4: " + TRANSFORM(LEN(loc_cSecao4)) + " bytes"

        *-- Processar SECAO 3 (metodos) - REDUCAO PRINCIPAL
        ? "    Processando SECAO 3 (metodos)..."
        loc_cSecao3Reduzida = THIS.ProcessarSecao3(loc_cSecao3)

        ? "    Metodos originais: " + TRANSFORM(THIS.this_nMetodosOriginais)
        ? "    Metodos removidos: " + TRANSFORM(THIS.this_nMetodosRemovidos)
        ? "    Metodos mantidos: " + TRANSFORM(THIS.this_nMetodosMantidos)

        *-- Recombinar secoes
        loc_cConteudoFinal = ""

        IF !EMPTY(loc_cSecao1)
            loc_cConteudoFinal = loc_cConteudoFinal + loc_cSecao1
        ENDIF

        IF !EMPTY(loc_cSecao2)
            loc_cConteudoFinal = loc_cConteudoFinal + loc_cSecao2
        ENDIF

        IF !EMPTY(loc_cSecao3Reduzida)
            loc_cConteudoFinal = loc_cConteudoFinal + loc_cSecao3Reduzida
        ENDIF

        IF !EMPTY(loc_cSecao4)
            loc_cConteudoFinal = loc_cConteudoFinal + loc_cSecao4
        ENDIF

        *-- Gerar nome do arquivo de saida
        loc_cArquivoSlim = STRTRAN(par_cArquivoOrigem, ".txt", "_slim.txt")

        *-- Salvar arquivo reduzido
        STRTOFILE(loc_cConteudoFinal, loc_cArquivoSlim)

        RETURN loc_cArquivoSlim
    ENDPROC

    *-------------------------------------------------------------
    * ExtrairSecao - Extrai uma secao especifica do conteudo
    *-------------------------------------------------------------
    PROTECTED PROCEDURE ExtrairSecao(par_cConteudo, par_cSecaoInicio, par_cSecaoFim)
        LOCAL loc_nPosInicio, loc_nPosFim, loc_cSecao
        LOCAL loc_cMarcadorInicio, loc_cMarcadorFim

        *-- Construir marcadores (formato: "* SECAO X:" - com asterisco no inicio)
        loc_cMarcadorInicio = "* " + par_cSecaoInicio + ":"

        IF EMPTY(par_cSecaoFim)
            *-- Ultima secao - vai ate o final
            loc_nPosInicio = ATC(loc_cMarcadorInicio, par_cConteudo)
            IF loc_nPosInicio = 0
                RETURN ""
            ENDIF
            loc_cSecao = SUBSTR(par_cConteudo, loc_nPosInicio)
        ELSE
            loc_cMarcadorFim = "* " + par_cSecaoFim + ":"

            loc_nPosInicio = ATC(loc_cMarcadorInicio, par_cConteudo)
            loc_nPosFim = ATC(loc_cMarcadorFim, par_cConteudo)

            IF loc_nPosInicio = 0
                RETURN ""
            ENDIF

            IF loc_nPosFim = 0 OR loc_nPosFim <= loc_nPosInicio
                *-- Secao seguinte nao encontrada, pegar ate o final
                loc_cSecao = SUBSTR(par_cConteudo, loc_nPosInicio)
            ELSE
                loc_cSecao = SUBSTR(par_cConteudo, loc_nPosInicio, loc_nPosFim - loc_nPosInicio)
            ENDIF
        ENDIF

        RETURN loc_cSecao
    ENDPROC

    *-------------------------------------------------------------
    * ProcessarSecao3 - Processa a secao de metodos
    * Remove metodos padrao, mantem metodos com logica de negocio
    *-------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarSecao3(par_cSecao3)
        LOCAL loc_cResultado, loc_aLinhas, loc_nLinhas, loc_nI
        LOCAL loc_lDentroMetodo, loc_cMetodoAtual, loc_cConteudoMetodo
        LOCAL loc_cLinha, loc_cLinhaUpper, loc_cNomeMetodo
        LOCAL loc_lManterMetodo, loc_cCabecalhoSecao

        IF EMPTY(par_cSecao3)
            RETURN ""
        ENDIF

        *-- Separar linhas
        loc_nLinhas = ALINES(loc_aLinhas, par_cSecao3)

        *-- Extrair cabecalho da secao (primeiras linhas com "=====" ou "* SECAO")
        loc_cCabecalhoSecao = ""
        FOR loc_nI = 1 TO MIN(10, loc_nLinhas)
            IF "=====" $ loc_aLinhas[loc_nI] OR "* SECAO" $ UPPER(loc_aLinhas[loc_nI])
                loc_cCabecalhoSecao = loc_cCabecalhoSecao + loc_aLinhas[loc_nI] + CHR(13) + CHR(10)
            ELSE
                IF !EMPTY(loc_cCabecalhoSecao)
                    EXIT
                ENDIF
            ENDIF
        ENDFOR

        *-- Iniciar resultado com cabecalho
        loc_cResultado = loc_cCabecalhoSecao
        loc_cResultado = loc_cResultado + "*-- SECAO 3 REDUZIDA (metodos padrao removidos)" + CHR(13) + CHR(10)
        loc_cResultado = loc_cResultado + "*-- Para arquivo completo, ver original" + CHR(13) + CHR(10)
        loc_cResultado = loc_cResultado + CHR(13) + CHR(10)

        loc_lDentroMetodo = .F.
        loc_cMetodoAtual = ""
        loc_cConteudoMetodo = ""
        loc_cNomeMetodo = ""

        FOR loc_nI = 1 TO loc_nLinhas
            loc_cLinha = loc_aLinhas[loc_nI]
            loc_cLinhaUpper = UPPER(ALLTRIM(loc_cLinha))

            *-- Detectar inicio de metodo (PROCEDURE ou FUNCTION)
            IF (LEFT(loc_cLinhaUpper, 10) = "PROCEDURE " OR ;
                LEFT(loc_cLinhaUpper, 9) = "FUNCTION " OR ;
                "*-- PROCEDURE " $ loc_cLinhaUpper OR ;
                "*-- FUNCTION " $ loc_cLinhaUpper)

                *-- Se estava dentro de um metodo, processar o anterior
                IF loc_lDentroMetodo AND !EMPTY(loc_cMetodoAtual)
                    THIS.this_nMetodosOriginais = THIS.this_nMetodosOriginais + 1

                    loc_lManterMetodo = THIS.DeveManterMetodo(loc_cNomeMetodo, loc_cConteudoMetodo)

                    IF loc_lManterMetodo
                        loc_cResultado = loc_cResultado + loc_cConteudoMetodo
                        THIS.this_nMetodosMantidos = THIS.this_nMetodosMantidos + 1
                    ELSE
                        THIS.this_nMetodosRemovidos = THIS.this_nMetodosRemovidos + 1
                    ENDIF
                ENDIF

                *-- Iniciar novo metodo
                loc_lDentroMetodo = .T.
                loc_cNomeMetodo = THIS.ExtrairNomeMetodo(loc_cLinha)
                loc_cConteudoMetodo = loc_cLinha + CHR(13) + CHR(10)
                loc_cMetodoAtual = loc_cNomeMetodo

            ELSE IF loc_lDentroMetodo
                *-- Adicionar linha ao metodo atual
                loc_cConteudoMetodo = loc_cConteudoMetodo + loc_cLinha + CHR(13) + CHR(10)

                *-- Detectar fim de metodo (ENDPROC ou ENDFUNC)
                IF LEFT(loc_cLinhaUpper, 7) = "ENDPROC" OR ;
                   LEFT(loc_cLinhaUpper, 7) = "ENDFUNC"

                    THIS.this_nMetodosOriginais = THIS.this_nMetodosOriginais + 1

                    loc_lManterMetodo = THIS.DeveManterMetodo(loc_cNomeMetodo, loc_cConteudoMetodo)

                    IF loc_lManterMetodo
                        loc_cResultado = loc_cResultado + loc_cConteudoMetodo + CHR(13) + CHR(10)
                        THIS.this_nMetodosMantidos = THIS.this_nMetodosMantidos + 1
                    ELSE
                        THIS.this_nMetodosRemovidos = THIS.this_nMetodosRemovidos + 1
                    ENDIF

                    loc_lDentroMetodo = .F.
                    loc_cMetodoAtual = ""
                    loc_cConteudoMetodo = ""
                    loc_cNomeMetodo = ""
                ENDIF
            ELSE
                *-- Linha fora de metodo (comentarios, cabecalhos de objeto)
                *-- Manter apenas se for cabecalho de objeto ou linha relevante
                IF "====" $ loc_cLinha OR ;
                   "*-- Objeto:" $ loc_cLinha OR ;
                   "*-- Classe:" $ loc_cLinha OR ;
                   "*-- Parent:" $ loc_cLinha OR ;
                   "DEFINE CLASS" $ loc_cLinhaUpper OR ;
                   "ENDDEFINE" $ loc_cLinhaUpper
                    loc_cResultado = loc_cResultado + loc_cLinha + CHR(13) + CHR(10)
                ENDIF
            ENDIF
            ENDIF
        ENDFOR

        *-- Processar ultimo metodo se estava pendente
        IF loc_lDentroMetodo AND !EMPTY(loc_cConteudoMetodo)
            THIS.this_nMetodosOriginais = THIS.this_nMetodosOriginais + 1

            loc_lManterMetodo = THIS.DeveManterMetodo(loc_cNomeMetodo, loc_cConteudoMetodo)

            IF loc_lManterMetodo
                loc_cResultado = loc_cResultado + loc_cConteudoMetodo
                THIS.this_nMetodosMantidos = THIS.this_nMetodosMantidos + 1
            ELSE
                THIS.this_nMetodosRemovidos = THIS.this_nMetodosRemovidos + 1
            ENDIF
        ENDIF

        RETURN loc_cResultado
    ENDPROC

    *-------------------------------------------------------------
    * ExtrairNomeMetodo - Extrai o nome do metodo da linha
    *-------------------------------------------------------------
    PROTECTED PROCEDURE ExtrairNomeMetodo(par_cLinha)
        LOCAL loc_cLinhaUpper, loc_cNome, loc_nPos

        loc_cLinhaUpper = UPPER(ALLTRIM(par_cLinha))

        *-- Remover prefixo PROCEDURE ou FUNCTION
        IF "PROCEDURE " $ loc_cLinhaUpper
            loc_nPos = ATC("PROCEDURE ", loc_cLinhaUpper)
            loc_cNome = SUBSTR(loc_cLinhaUpper, loc_nPos + 10)
        ELSE IF "FUNCTION " $ loc_cLinhaUpper
            loc_nPos = ATC("FUNCTION ", loc_cLinhaUpper)
            loc_cNome = SUBSTR(loc_cLinhaUpper, loc_nPos + 9)
        ELSE
            loc_cNome = loc_cLinhaUpper
        ENDIF
        ENDIF

        *-- Remover parenteses e parametros
        loc_nPos = AT("(", loc_cNome)
        IF loc_nPos > 0
            loc_cNome = LEFT(loc_cNome, loc_nPos - 1)
        ENDIF

        *-- Extrair apenas o nome do metodo (apos o ponto, se houver)
        *-- Ex: "Pageframe1.Page1.Command1.Click" -> "Click"
        loc_nPos = RAT(".", loc_cNome)
        IF loc_nPos > 0
            loc_cNome = SUBSTR(loc_cNome, loc_nPos + 1)
        ENDIF

        RETURN ALLTRIM(loc_cNome)
    ENDPROC

    *-------------------------------------------------------------
    * DeveManterMetodo - Decide se o metodo deve ser mantido
    * Retorna .T. se deve manter, .F. se deve remover
    *-------------------------------------------------------------
    PROTECTED PROCEDURE DeveManterMetodo(par_cNomeMetodo, par_cConteudoMetodo)
        LOCAL loc_nI, loc_cNomeUpper, loc_cConteudoUpper
        LOCAL loc_lEhMetodoPadrao, loc_lTemLogicaNegocio

        loc_cNomeUpper = UPPER(par_cNomeMetodo)
        loc_cConteudoUpper = UPPER(par_cConteudoMetodo)

        *-- 1. Verificar se eh metodo padrao (candidato a remocao)
        loc_lEhMetodoPadrao = .F.

        FOR loc_nI = 1 TO THIS.this_nMetodosRemover
            IF THIS.this_aMetodosRemover[loc_nI] == loc_cNomeUpper
                loc_lEhMetodoPadrao = .T.
                EXIT
            ENDIF
        ENDFOR

        *-- Se nao eh metodo padrao, MANTER
        IF !loc_lEhMetodoPadrao
            RETURN .T.
        ENDIF

        *-- 2. Metodo padrao, verificar se tem logica de negocio
        *-- Se tiver, MANTER mesmo sendo metodo padrao

        loc_lTemLogicaNegocio = .F.

        FOR loc_nI = 1 TO THIS.this_nPalavrasChaveManter
            IF THIS.this_aPalavrasChaveManter[loc_nI] $ loc_cConteudoUpper
                loc_lTemLogicaNegocio = .T.
                EXIT
            ENDIF
        ENDFOR

        IF loc_lTemLogicaNegocio
            RETURN .T.
        ENDIF

        *-- 3. Verificar se o metodo faz mais do que apenas DODEFAULT ou RETURN
        *-- (metodo trivial = apenas DODEFAULT, RETURN .T., ou vazio)

        LOCAL loc_nLinhas, loc_aLinhas, loc_nLinhasReais
        loc_nLinhas = ALINES(loc_aLinhas, par_cConteudoMetodo)
        loc_nLinhasReais = 0

        FOR loc_nI = 1 TO loc_nLinhas
            LOCAL loc_cLinhaTemp
            loc_cLinhaTemp = ALLTRIM(UPPER(loc_aLinhas[loc_nI]))

            *-- Ignorar linhas vazias, comentarios, declaracoes
            IF EMPTY(loc_cLinhaTemp) OR ;
               LEFT(loc_cLinhaTemp, 1) = "*" OR ;
               LEFT(loc_cLinhaTemp, 2) = "&&" OR ;
               LEFT(loc_cLinhaTemp, 9) = "PROCEDURE" OR ;
               LEFT(loc_cLinhaTemp, 8) = "FUNCTION" OR ;
               LEFT(loc_cLinhaTemp, 7) = "ENDPROC" OR ;
               LEFT(loc_cLinhaTemp, 7) = "ENDFUNC" OR ;
               LEFT(loc_cLinhaTemp, 5) = "LOCAL" OR ;
               LEFT(loc_cLinhaTemp, 10) = "LPARAMETER" OR ;
               loc_cLinhaTemp = "DODEFAULT()" OR ;
               loc_cLinhaTemp = "RETURN" OR ;
               loc_cLinhaTemp = "RETURN .T." OR ;
               loc_cLinhaTemp = "RETURN .F."

               *-- Nao contar como linha real
               LOOP
            ENDIF

            loc_nLinhasReais = loc_nLinhasReais + 1
        ENDFOR

        *-- Se tem mais de 2 linhas reais de codigo, MANTER
        IF loc_nLinhasReais > 2
            RETURN .T.
        ENDIF

        *-- Metodo padrao sem logica de negocio, REMOVER
        RETURN .F.
    ENDPROC

ENDDEFINE
