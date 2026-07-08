*====================================================================
* GeradorMapeamento.prg
*
* Script para gerar mapeamento automatico de objetos legado -> novo padrao
*
* PARAMETROS:
*   par_cArquivoTXT - Caminho completo do .TXT com codigo fonte extraido
*                     Ex: 'C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt'
*   par_cTaskDir    - Diretorio do task onde salvar o mapeamento.json
*                     Ex: 'C:\4c\tasks\task1'
*
* RETORNO:
*   Gera arquivo mapeamento.json no diretorio do task
*
* EXEMPLOS:
*   VFP9.EXE GeradorMapeamento('C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt', 'C:\4c\tasks\task1')
*   DO GeradorMapeamento WITH "C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt", "C:\4c\tasks\task1"
*====================================================================
LPARAMETERS par_cArquivoTXT, par_cTaskDir

*-- Validacao de parametros
IF EMPTY(par_cArquivoTXT) OR VARTYPE(par_cArquivoTXT) # "C"
    MESSAGEBOX("Parametro par_cArquivoTXT nao fornecido ou invalido!" + CHR(13) + ;
               "Recebido: [" + IIF(VARTYPE(par_cArquivoTXT)="C", par_cArquivoTXT, "tipo=" + VARTYPE(par_cArquivoTXT)) + "]", 16, "Erro")
    RETURN .F.
ENDIF

IF EMPTY(par_cTaskDir) OR VARTYPE(par_cTaskDir) # "C"
    MESSAGEBOX("Parametro par_cTaskDir nao fornecido ou invalido!" + CHR(13) + ;
               "Recebido: [" + IIF(VARTYPE(par_cTaskDir)="C", par_cTaskDir, "tipo=" + VARTYPE(par_cTaskDir)) + "]", 16, "Erro")
    RETURN .F.
ENDIF

*-- Infere nome da classe do form a partir do nome do arquivo
*-- Ex: SIGCDCOR_form_codigo_fonte.txt -> FormCor
LOCAL par_cClasseFormNovo
par_cClasseFormNovo = JUSTSTEM(par_cArquivoTXT)
par_cClasseFormNovo = STRTRAN(par_cClasseFormNovo, "_form_codigo_fonte", "")
par_cClasseFormNovo = STRTRAN(par_cClasseFormNovo, "_codigo_fonte", "")

*-- Remove prefixo SIGCD se existir (ex: SIGCDCOR -> COR -> FormCor)
IF LEFT(UPPER(par_cClasseFormNovo), 5) = "SIGCD"
    par_cClasseFormNovo = "Form" + SUBSTR(par_cClasseFormNovo, 6)
ELSE
    par_cClasseFormNovo = "Form" + par_cClasseFormNovo
ENDIF

*-- Renomeia par_cArquivoTXT para par_cArquivoOriginal (compatibilidade com resto do codigo)
LOCAL par_cArquivoOriginal
par_cArquivoOriginal = par_cArquivoTXT

LOCAL loc_cCaminhoBase, loc_cCaminhoUtils, loc_cCaminhoTasks
LOCAL loc_oAnalisador, loc_oRegras
LOCAL loc_cArquivoCompleto, loc_cArquivoJSON
LOCAL loc_cJSON, loc_cEntidade, loc_nHandle
LOCAL i, loc_cCaminhoOriginal, loc_cNomeOriginal, loc_cTipo
LOCAL loc_cCaminhoNovo, loc_cCaption, loc_cContexto
LOCAL loc_cArquivoLog, loc_cTimestamp

*-- Configura caminhos
*-- Usa caminho absoluto para garantir funcionamento sem config.fpw
loc_cCaminhoUtils = "C:\4c\projeto\app\utils\"
loc_cCaminhoTasks = "C:\4c\tasks\"

*-- Configura arquivo de log
loc_cTimestamp = TTOC(DATETIME(), 1)
loc_cTimestamp = STRTRAN(loc_cTimestamp, " ", "_")
loc_cTimestamp = STRTRAN(loc_cTimestamp, ":", "")
loc_cTimestamp = STRTRAN(loc_cTimestamp, "/", "")

loc_cArquivoLog = loc_cCaminhoUtils + "logs\GeradorMapeamento_" + par_cClasseFormNovo + "_" + loc_cTimestamp + ".txt"

*-- Cria pasta de logs se nao existir
IF !DIRECTORY(loc_cCaminhoUtils + "logs")
    MKDIR (loc_cCaminhoUtils + "logs")
ENDIF

*-- Redireciona saida para arquivo de log
SET ALTERNATE TO (loc_cArquivoLog)
SET ALTERNATE ON
SET CONSOLE ON

*-- Usa caminho completo do arquivo fornecido
loc_cArquivoCompleto = par_cArquivoOriginal

*-- Verifica se arquivo existe
IF !FILE(loc_cArquivoCompleto)
    ? "ERRO: Arquivo original n" + CHR(227) + "o encontrado: " + loc_cArquivoCompleto
    SET ALTERNATE OFF
    SET ALTERNATE TO
    RETURN .F.
ENDIF

? "========================================================================"
? "GeradorMapeamento - Gera" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica de Mapeamento"
? "========================================================================"
? "Arquivo Original: " + loc_cArquivoCompleto
? "Classe Form Nova: " + par_cClasseFormNovo
? "========================================================================"
? ""

*-- Carrega classes necessarias (usa caminhos absolutos)
? "Carregando classes..."
SET PROCEDURE TO "C:\4c\projeto\app\utils\AnalisadorObjetos.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\RegrasNomenclatura.prg" ADDITIVE

*-- 1. Analisa codigo original
? "Analisando c" + CHR(243) + "digo original..."
loc_oAnalisador = CREATEOBJECT("AnalisadorObjetos")

IF !loc_oAnalisador.Analisar(loc_cArquivoCompleto)
    ? "ERRO: Falha ao analisar c" + CHR(243) + "digo original"
    SET ALTERNATE OFF
    SET ALTERNATE TO
    RETURN .F.
ENDIF

? "  - " + ALLTRIM(STR(loc_oAnalisador.nObjetos)) + " objetos encontrados"
? ""

*-- DEBUG: Mostra primeiros 10 objetos extraidos
? "DEBUG: Primeiros objetos extra" + CHR(237) + "dos:"
FOR i = 1 TO MIN(10, loc_oAnalisador.nObjetos)
    ? "  [" + ALLTRIM(STR(i)) + "] Caminho: [" + loc_oAnalisador.aObjetos[i, 1] + "]"
    ? "      Nome: [" + loc_oAnalisador.aObjetos[i, 2] + "]"
    ? "      Tipo: [" + loc_oAnalisador.aObjetos[i, 3] + "]"
    ? "      Pai: [" + loc_oAnalisador.aObjetos[i, 4] + "]"
ENDFOR
? ""
? "DEBUG: cNomeFormOriginal = [" + loc_oAnalisador.cNomeFormOriginal + "]"
? ""

*-- 2. Aplica regras de nomenclatura
? "Aplicando regras de nomenclatura..."
loc_oRegras = CREATEOBJECT("RegrasNomenclatura")

*-- 3. Extrai nome da entidade (ex: "FormCor" -> "Cor")
IF LEFT(par_cClasseFormNovo, 4) = "Form"
    loc_cEntidade = SUBSTR(par_cClasseFormNovo, 5)
ELSE
    loc_cEntidade = par_cClasseFormNovo
ENDIF

*-- 4. Gera JSON
? "Gerando JSON..."

*-- DEBUG: Variavel publica para controlar debug em ConverterCaminho
PUBLIC gb_DebugConversao
gb_DebugConversao = .F.

*-- Inicia JSON
loc_cJSON = "{" + CHR(13) + CHR(10)
loc_cJSON = loc_cJSON + '  "form_original": "' + loc_oAnalisador.cNomeFormOriginal + '",' + CHR(13) + CHR(10)
loc_cJSON = loc_cJSON + '  "form_migrado": "' + par_cClasseFormNovo + '",' + CHR(13) + CHR(10)
loc_cJSON = loc_cJSON + '  "entidade": "' + loc_cEntidade + '",' + CHR(13) + CHR(10)
loc_cJSON = loc_cJSON + '  "mapeamento": {' + CHR(13) + CHR(10)

*-- Adiciona mapeamentos
FOR i = 1 TO loc_oAnalisador.nObjetos
    loc_cCaminhoOriginal = loc_oAnalisador.aObjetos[i, 1]
    loc_cNomeOriginal = loc_oAnalisador.aObjetos[i, 2]
    loc_cTipo = loc_oAnalisador.aObjetos[i, 3]
    loc_cCaption = loc_oAnalisador.aObjetos[i, 5]
    loc_cContexto = loc_oAnalisador.aObjetos[i, 4]

    *-- DEBUG: Mostra apenas primeiros 3 para nao poluir
    IF i <= 3
        ? ""
        ? "DEBUG: Convertendo objeto " + ALLTRIM(STR(i)) + ":"
        ? "  Original: [" + loc_cCaminhoOriginal + "]"
        gb_DebugConversao = .T.  && Habilita debug detalhado
    ELSE
        gb_DebugConversao = .F.  && Desabilita debug detalhado
    ENDIF

    *-- Converte nome usando regras
    loc_cCaminhoNovo = ConverterCaminho(loc_cCaminhoOriginal, loc_oAnalisador, loc_oRegras)

    IF i <= 3
        ? "  Convertido: [" + loc_cCaminhoNovo + "]"
    ENDIF

    *-- Adiciona ao JSON
    loc_cJSON = loc_cJSON + '    "' + loc_cCaminhoOriginal + '": "' + loc_cCaminhoNovo + '"'

    *-- Adiciona virgula se nao for o ultimo
    IF i < loc_oAnalisador.nObjetos
        loc_cJSON = loc_cJSON + ","
    ENDIF

    loc_cJSON = loc_cJSON + CHR(13) + CHR(10)
ENDFOR

*-- Fecha JSON
loc_cJSON = loc_cJSON + '  }' + CHR(13) + CHR(10)
loc_cJSON = loc_cJSON + '}' + CHR(13) + CHR(10)

*-- 5. Salva JSON na pasta da task
loc_cArquivoJSON = ADDBS(par_cTaskDir) + "mapeamento.json"

loc_nHandle = FCREATE(loc_cArquivoJSON)

IF loc_nHandle < 0
    ? "ERRO: N" + CHR(227) + "o foi poss" + CHR(237) + "vel criar arquivo JSON"
    SET ALTERNATE OFF
    SET ALTERNATE TO
    RETURN .F.
ENDIF

FWRITE(loc_nHandle, loc_cJSON)
FCLOSE(loc_nHandle)

? ""
? "===== MAPEAMENTO GERADO COM SUCESSO ====="
? "Arquivo JSON: " + loc_cArquivoJSON
? "Objetos mapeados: " + ALLTRIM(STR(loc_oAnalisador.nObjetos))
? "Arquivo de Log: " + loc_cArquivoLog
? ""
? "Pr" + CHR(243) + "ximo passo:"
? "1. Revisar o JSON gerado (se necess" + CHR(225) + "rio)"
? "2. Implementar formul" + CHR(225) + "rio seguindo o mapeamento"
? "3. Validar com ValidarUIFidelity"
? ""

*-- Fecha arquivo de log
SET ALTERNATE OFF
SET ALTERNATE TO

* Mapeamento gerado com sucesso
? "Mapeamento gerado com sucesso!"
? "Arquivo JSON: " + loc_cArquivoJSON
? "Log: " + loc_cArquivoLog
? "Objetos mapeados: " + ALLTRIM(STR(loc_oAnalisador.nObjetos))

QUIT RETURN 0

*====================================================================
* ConverterCaminho
* Converte caminho completo do objeto original para novo padrao
*====================================================================
PROCEDURE ConverterCaminho(par_cCaminhoOriginal, par_oAnalisador, par_oRegras)
    LOCAL ARRAY loc_aParts[1, 1]
    LOCAL loc_nParts, i, j
    LOCAL loc_cTipo, loc_cCaption, loc_cNome, loc_cContexto
    LOCAL loc_cCaminhoNovo, loc_cNomeNovo
    LOCAL loc_cCaminhoPai, loc_cCaminhoPaiNovo
    LOCAL loc_lDebug

    *-- Debug controlado por variavel publica
    loc_lDebug = gb_DebugConversao

    *-- Se for o form, retorna "Form"
    IF UPPER(ALLTRIM(par_cCaminhoOriginal)) == UPPER(ALLTRIM(par_oAnalisador.cNomeFormOriginal))
        IF loc_lDebug
            ? "    -> Eh o form, retornando 'Form'"
        ENDIF
        RETURN "Form"
    ENDIF

    *-- Procura objeto no array do analisador para obter tipo, caption, etc
    loc_cTipo = ""
    loc_cNome = ""

    FOR i = 1 TO par_oAnalisador.nObjetos
        IF UPPER(ALLTRIM(par_oAnalisador.aObjetos[i, 1])) == UPPER(ALLTRIM(par_cCaminhoOriginal))
            loc_cTipo = par_oAnalisador.aObjetos[i, 3]
            loc_cCaption = par_oAnalisador.aObjetos[i, 5]
            loc_cNome = par_oAnalisador.aObjetos[i, 2]
            loc_cContexto = par_oAnalisador.aObjetos[i, 4]
            EXIT
        ENDIF
    ENDFOR

    *-- Se nao encontrou, retorna nome original
    IF EMPTY(loc_cTipo)
        IF loc_lDebug
            ? "    -> Objeto nao encontrado no array, retornando original"
        ENDIF
        RETURN par_cCaminhoOriginal
    ENDIF

    IF loc_lDebug
        ? "    -> Encontrado: Nome=[" + loc_cNome + "] Tipo=[" + loc_cTipo + "]"
    ENDIF

    *-- Converte nome usando regras
    loc_cNomeNovo = par_oRegras.ConverterNome(loc_cNome, loc_cTipo, loc_cCaption, loc_cContexto)

    IF loc_lDebug
        ? "    -> Nome convertido: [" + loc_cNomeNovo + "]"
    ENDIF

    *-- Separa caminho em partes
    loc_aParts = SepararCaminho(par_cCaminhoOriginal)
    loc_nParts = ALEN(loc_aParts, 1)

    IF loc_lDebug
        ? "    -> Numero de partes no caminho: " + ALLTRIM(STR(loc_nParts))
    ENDIF

    *-- Se tem apenas 1 parte (raiz), retorna nome convertido
    IF loc_nParts = 1
        IF loc_lDebug
            ? "    -> Apenas 1 parte, retornando nome convertido: [" + loc_cNomeNovo + "]"
        ENDIF
        RETURN loc_cNomeNovo
    ENDIF

    *-- Reconstroi caminho do pai (tudo menos a ultima parte)
    loc_cCaminhoPai = ""
    FOR j = 1 TO loc_nParts - 1
        IF !EMPTY(loc_cCaminhoPai)
            loc_cCaminhoPai = loc_cCaminhoPai + "."
        ENDIF
        loc_cCaminhoPai = loc_cCaminhoPai + loc_aParts[j, 1]
    ENDFOR

    IF loc_lDebug
        ? "    -> Caminho do pai: [" + loc_cCaminhoPai + "]"
        ? "    -> cNomeFormOriginal: [" + par_oAnalisador.cNomeFormOriginal + "]"
    ENDIF

    *-- Se pai eh o form, retorna apenas nome convertido (sem prefixo "Form.")
    IF UPPER(ALLTRIM(loc_cCaminhoPai)) == UPPER(ALLTRIM(par_oAnalisador.cNomeFormOriginal))
        IF loc_lDebug
            ? "    -> Pai eh o form, retornando apenas nome: [" + loc_cNomeNovo + "]"
        ENDIF
        RETURN loc_cNomeNovo
    ENDIF

    IF loc_lDebug
        ? "    -> Convertendo pai recursivamente..."
    ENDIF

    *-- Converte caminho pai recursivamente
    loc_cCaminhoPaiNovo = ConverterCaminho(loc_cCaminhoPai, par_oAnalisador, par_oRegras)

    IF loc_lDebug
        ? "    -> Pai convertido: [" + loc_cCaminhoPaiNovo + "]"
    ENDIF

    *-- Monta caminho completo: pai + "." + nome
    loc_cCaminhoNovo = loc_cCaminhoPaiNovo + "." + loc_cNomeNovo

    IF loc_lDebug
        ? "    -> Retornando caminho completo: [" + loc_cCaminhoNovo + "]"
    ENDIF

    RETURN loc_cCaminhoNovo
ENDPROC

*====================================================================
* SepararCaminho
* Separa caminho em partes (ex: "Form.Page.Control" -> ["Form", "Page", "Control"])
*====================================================================
PROCEDURE SepararCaminho(par_cCaminho)
    LOCAL ARRAY loc_aParts[1, 1]
    LOCAL loc_nParts, loc_nPos, loc_cResto

    loc_nParts = 0
    loc_cResto = par_cCaminho

    DO WHILE "." $ loc_cResto
        loc_nParts = loc_nParts + 1
        DIMENSION loc_aParts[loc_nParts, 1]

        loc_nPos = AT(".", loc_cResto)
        loc_aParts[loc_nParts, 1] = LEFT(loc_cResto, loc_nPos - 1)
        loc_cResto = SUBSTR(loc_cResto, loc_nPos + 1)
    ENDDO

    *-- Adiciona ultima parte
    loc_nParts = loc_nParts + 1
    DIMENSION loc_aParts[loc_nParts, 1]
    loc_aParts[loc_nParts, 1] = loc_cResto

    RETURN @loc_aParts
ENDPROC
