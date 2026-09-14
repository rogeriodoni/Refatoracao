*====================================================================
* ValidarUIFidelity.prg
*
* Script para validar fidelidade visual entre formulario original e migrado
*
* Uso:
*   DO ValidarUIFidelity WITH "task1\SIGCDCOR_form_codigo_fonte.txt", "FormCor"
*
* Parametros:
*   par_cArquivoOriginal - Caminho do .txt com codigo fonte extraido
*   par_cClasseForm      - Nome da classe do form migrado
*
* Retorno:
*   Gera relatorio HTML em projeto\app\utils\relatorios\
*====================================================================

LPARAMETERS par_cArquivoOriginal, par_cClasseForm

*-- Validacao defensiva de parametros (protege contra .fxp stale ou execucao manual sem WITH)
LOCAL loc_lParametrosOk
loc_lParametrosOk = .T.

IF TYPE("par_cArquivoOriginal") != "C"
    loc_lParametrosOk = .F.
ELSE
    IF EMPTY(par_cArquivoOriginal)
        loc_lParametrosOk = .F.
    ENDIF
ENDIF
IF TYPE("par_cClasseForm") != "C"
    loc_lParametrosOk = .F.
ELSE
    IF EMPTY(par_cClasseForm)
        loc_lParametrosOk = .F.
    ENDIF
ENDIF

IF NOT loc_lParametrosOk
    ? "ERRO: Parametros obrigatorios nao fornecidos."
    ? "USO: DO ValidarUIFidelity WITH 'taskX\arquivo_fonte.txt', 'FormClasse'"
    QUIT RETURN 99
ENDIF

LOCAL loc_cCaminhoBase, loc_cCaminhoUtils, loc_cCaminhoTasks
LOCAL loc_oExtrator, loc_oComparador, loc_oRelatorio
LOCAL loc_oFormMigrado
LOCAL loc_cArquivoCompleto, loc_cRelatorioPath
LOCAL loc_lSucesso, loc_cMsgErro
LOCAL loc_cCaminhoClasses, loc_cCaminhoForms, loc_cNomeBO, loc_cArquivoForm
LOCAL loc_cArquivoLog, loc_cTimestamp

*-- Inicializa controle de fluxo
loc_lSucesso = .T.
loc_cMsgErro = ""

*-- Configura caminhos
loc_cCaminhoBase = JUSTPATH(SYS(16))
loc_cCaminhoUtils = ADDBS(loc_cCaminhoBase)
loc_cCaminhoTasks = ADDBS(loc_cCaminhoBase) + "..\..\..\tasks\"

*-- Configura arquivo de log
loc_cTimestamp = TTOC(DATETIME(), 1)  && YYYYMMDDHHMMSS
loc_cTimestamp = STRTRAN(loc_cTimestamp, " ", "_")
loc_cTimestamp = STRTRAN(loc_cTimestamp, ":", "")
loc_cTimestamp = STRTRAN(loc_cTimestamp, "/", "")

loc_cArquivoLog = loc_cCaminhoUtils + "logs\ValidarUI_" + par_cClasseForm + "_" + loc_cTimestamp + ".txt"

*-- Cria pasta de logs se nao existir
IF !DIRECTORY(loc_cCaminhoUtils + "logs")
    MKDIR (loc_cCaminhoUtils + "logs")
ENDIF

*-- Redireciona saida para arquivo de log
SET ALTERNATE TO (loc_cArquivoLog)
SET ALTERNATE ON
SET CONSOLE ON  && Mantem saida na tela tambem

? "========================================================================"
? "ValidarUIFidelity - Log de Execu" + CHR(231) + CHR(227) + "o"
? "========================================================================"
? "Data/Hora: " + TTOC(DATETIME())
? "Formul" + CHR(225) + "rio: " + par_cClasseForm
? "Arquivo Original: " + par_cArquivoOriginal
? "Arquivo de Log: " + loc_cArquivoLog
? "========================================================================"
? ""

*-- Monta caminho completo do arquivo original
IF !("\" $ par_cArquivoOriginal) AND !("/" $ par_cArquivoOriginal)
    *-- Apenas nome do arquivo, assume que esta em tasks\
    loc_cArquivoCompleto = loc_cCaminhoTasks + par_cArquivoOriginal
ELSE
    loc_cArquivoCompleto = par_cArquivoOriginal
ENDIF

*-- Verifica se arquivo existe
IF !FILE(loc_cArquivoCompleto)
    ? "ERRO: Arquivo original n" + CHR(227) + "o encontrado: " + loc_cArquivoCompleto
    SET ALTERNATE OFF
    SET ALTERNATE TO
    QUIT RETURN 1
ENDIF

*-- Limpa arquivos .fxp compilados para forcar recompilacao
? "Limpando arquivos .fxp..."
IF FILE(loc_cCaminhoUtils + "ExtratorPropriedades.fxp")
    DELETE FILE (loc_cCaminhoUtils + "ExtratorPropriedades.fxp")
ENDIF
IF FILE(loc_cCaminhoUtils + "ComparadorUI.fxp")
    DELETE FILE (loc_cCaminhoUtils + "ComparadorUI.fxp")
ENDIF
IF FILE(loc_cCaminhoUtils + "RelatorioUI.fxp")
    DELETE FILE (loc_cCaminhoUtils + "RelatorioUI.fxp")
ENDIF

*-- Carrega classes necessarias para validacao
SET PROCEDURE TO (loc_cCaminhoUtils + "ExtratorPropriedades.prg") ADDITIVE
SET PROCEDURE TO (loc_cCaminhoUtils + "ComparadorUI.prg") ADDITIVE
SET PROCEDURE TO (loc_cCaminhoUtils + "RelatorioUI.prg") ADDITIVE

*-- Cria variaveis globais minimas necessarias
? "Configurando ambiente..."
PUBLIC gnConnHandle, gc_4c_CaminhoIcones, gb_4c_ValidandoUI
gnConnHandle = -1  && Nao ha conexao (apenas validacao visual)
gb_4c_ValidandoUI = .T.  && Flag para pular queries SQL durante validacao
gc_4c_CaminhoIcones = ADDBS(loc_cCaminhoBase) + "..\..\..\vbmp\"

*-- Carrega dependencias minimas do formulario
? "Carregando dependencias do formul" + CHR(225) + "rio..."

*-- De C:\4c\projeto\app\utils para C:\4c\projeto\app\classes
loc_cCaminhoClasses = ADDBS(loc_cCaminhoBase) + "..\classes\"

*-- Buscar form em todas as pastas de formularios (cadastros, relatorios, operacionais)
LOCAL loc_cCaminhoFormsBase
loc_cCaminhoFormsBase = ADDBS(loc_cCaminhoBase) + "..\forms\"

DO CASE
CASE FILE(loc_cCaminhoFormsBase + "cadastros\" + par_cClasseForm + ".prg")
    loc_cCaminhoForms = loc_cCaminhoFormsBase + "cadastros\"
    ? "  Form encontrado em: cadastros\"
CASE FILE(loc_cCaminhoFormsBase + "relatorios\" + par_cClasseForm + ".prg")
    loc_cCaminhoForms = loc_cCaminhoFormsBase + "relatorios\"
    ? "  Form encontrado em: relatorios\"
CASE FILE(loc_cCaminhoFormsBase + "operacionais\" + par_cClasseForm + ".prg")
    loc_cCaminhoForms = loc_cCaminhoFormsBase + "operacionais\"
    ? "  Form encontrado em: operacionais\"
OTHERWISE
    loc_cCaminhoForms = loc_cCaminhoFormsBase + "cadastros\"
    ? "  AVISO: Form n" + CHR(227) + "o encontrado em nenhuma pasta, tentando cadastros\"
ENDCASE

*-- Funcoes utilitarias (necessarias para FormBase e BOs)
SET PROCEDURE TO (loc_cCaminhoUtils + "functions.prg") ADDITIVE
SET PROCEDURE TO (loc_cCaminhoUtils + "messages.prg") ADDITIVE
SET PROCEDURE TO (loc_cCaminhoUtils + "validators.prg") ADDITIVE

*-- Classes base necessarias
SET PROCEDURE TO (loc_cCaminhoClasses + "dataaccess.prg") ADDITIVE
SET PROCEDURE TO (loc_cCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (loc_cCaminhoClasses + "formbase.prg") ADDITIVE
SET PROCEDURE TO (loc_cCaminhoClasses + "gridbase.prg") ADDITIVE

*-- RelatorioBase (necessario para BOs de relatorio)
IF FILE(loc_cCaminhoClasses + "relatoriobase.prg")
    SET PROCEDURE TO (loc_cCaminhoClasses + "relatoriobase.prg") ADDITIVE
ENDIF

*-- Business object especifico (FormCor precisa de CorBO)
*-- Remove "Form" do inicio para obter nome do BO
IF LEFT(par_cClasseForm, 4) = "Form"
    loc_cNomeBO = SUBSTR(par_cClasseForm, 5) + "BO"
ELSE
    loc_cNomeBO = par_cClasseForm + "BO"
ENDIF

IF FILE(loc_cCaminhoClasses + loc_cNomeBO + ".prg")
    SET PROCEDURE TO (loc_cCaminhoClasses + loc_cNomeBO + ".prg") ADDITIVE
ENDIF

*-- FormBuscaAuxiliar (usado por lookups em muitos forms)
IF FILE(loc_cCaminhoClasses + "formbuscaauxiliar.prg")
    SET PROCEDURE TO (loc_cCaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
ENDIF

*-- GeradorRelatorio (usado por forms de relatorio)
IF FILE(loc_cCaminhoClasses + "geradorrelatorio.prg")
    SET PROCEDURE TO (loc_cCaminhoClasses + "geradorrelatorio.prg") ADDITIVE
ENDIF

*-- Formulario
loc_cArquivoForm = loc_cCaminhoForms + par_cClasseForm + ".prg"

IF !FILE(loc_cArquivoForm)
    ? "ERRO: Formul" + CHR(225) + "rio n" + CHR(227) + "o encontrado: " + loc_cArquivoForm
    ? "  Procurado em: " + loc_cArquivoForm
    SET ALTERNATE OFF
    SET ALTERNATE TO
    QUIT RETURN 2
ENDIF

SET PROCEDURE TO (loc_cArquivoForm) ADDITIVE

*-- 1. Extrai propriedades do arquivo original (FORA do TRY)
? "Extraindo propriedades do arquivo original..."
loc_oExtrator = CREATEOBJECT("ExtratorPropriedades")

IF !loc_oExtrator.ExtrairDeArquivo(loc_cArquivoCompleto)
    ? "ERRO: Nenhuma propriedade encontrada no arquivo original"
    SET ALTERNATE OFF
    SET ALTERNATE TO
    QUIT RETURN 2
ENDIF

? "  - " + ALLTRIM(STR(loc_oExtrator.nResultados)) + " propriedades encontradas"

*-- 2. Instancia formulario migrado
? "Instanciando formul" + CHR(225) + "rio migrado..."
? "  AVISO: Se o Init() do formulario tiver TRY/CATCH com RETURN, pode dar erro"

*-- Captura erro de TRY/CATCH com RETURN
LOCAL loc_lErroInit
loc_lErroInit = .F.

ON ERROR loc_lErroInit = .T.
loc_oFormMigrado = CREATEOBJECT(par_cClasseForm)
ON ERROR

IF loc_lErroInit
    ? "ERRO: O Init() do formul" + CHR(225) + "rio tem TRY/CATCH com RETURN dentro."
    ? "Corrija o FormBase.prg ou " + par_cClasseForm + ".prg primeiro."
    ? "REGRA VFP9: NUNCA use RETURN dentro de TRY/CATCH!"
    SET ALTERNATE OFF
    SET ALTERNATE TO
    QUIT RETURN 2
ENDIF

IF ISNULL(loc_oFormMigrado)
    ? "ERRO: Formul" + CHR(225) + "rio retornou NULL ao instanciar: " + par_cClasseForm
    ? "Verifique se ha erros no Init() do formul" + CHR(225) + "rio"
    SET ALTERNATE OFF
    SET ALTERNATE TO
    QUIT RETURN 2
ENDIF

*-- 3. Compara propriedades
? "Comparando propriedades..."
loc_oComparador = CREATEOBJECT("ComparadorUI")

*-- Tenta carregar mapeamento JSON (se existir)
LOCAL loc_cArquivoMapeamento
loc_cArquivoMapeamento = loc_cCaminhoUtils + "mapeamentos\" + par_cClasseForm + "_mapeamento.json"

IF FILE(loc_cArquivoMapeamento)
    ? "Mapeamento encontrado, carregando..."
    loc_oComparador.CarregarMapeamento(loc_cArquivoMapeamento)
ELSE
    ? "Mapeamento n" + CHR(227) + "o encontrado (usando resolu" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o)"
ENDIF

loc_oComparador.Comparar(loc_oExtrator, loc_oFormMigrado)

? "  - " + ALLTRIM(STR(loc_oComparador.nDiferencasEncontradas)) + " diferen" + CHR(231) + "as encontradas"

*-- 4. Gera relatorio
? "Gerando relat" + CHR(243) + "rio..."
loc_oRelatorio = CREATEOBJECT("RelatorioUI")

*-- Copia array para variavel local (VFP9 nao aceita @objeto.propriedade)
LOCAL ARRAY loc_aDiferencasTemp[1, 7]
LOCAL loc_i

IF loc_oComparador.nDiferencasEncontradas > 0
    DIMENSION loc_aDiferencasTemp[loc_oComparador.nDiferencasEncontradas, 7]
    FOR loc_i = 1 TO loc_oComparador.nDiferencasEncontradas
        loc_aDiferencasTemp[loc_i, 1] = loc_oComparador.aDiferencas[loc_i, 1]
        loc_aDiferencasTemp[loc_i, 2] = loc_oComparador.aDiferencas[loc_i, 2]
        loc_aDiferencasTemp[loc_i, 3] = loc_oComparador.aDiferencas[loc_i, 3]
        loc_aDiferencasTemp[loc_i, 4] = loc_oComparador.aDiferencas[loc_i, 4]
        loc_aDiferencasTemp[loc_i, 5] = loc_oComparador.aDiferencas[loc_i, 5]
        loc_aDiferencasTemp[loc_i, 6] = loc_oComparador.aDiferencas[loc_i, 6]
        loc_aDiferencasTemp[loc_i, 7] = loc_oComparador.aDiferencas[loc_i, 7]
    ENDFOR
ENDIF

*-- Passa array (arrays sao passados por referencia por padrao no VFP9)
*-- NAO usar @ porque VFP9 perde o tipo do array
loc_cRelatorioPath = loc_oRelatorio.Gerar(par_cClasseForm, ;
                                           @loc_aDiferencasTemp, ;
                                           loc_oComparador.nDiferencasEncontradas)

*-- 5. Libera formulario (verifica se eh realmente um objeto)
IF VARTYPE(loc_oFormMigrado) = "O" AND !ISNULL(loc_oFormMigrado)
    loc_oFormMigrado.Release()
ENDIF

*-- 6. Limpa flag de validacao
gb_4c_ValidandoUI = .F.

*-- 7. Exibe resultado
? ""
? "===== VALIDACAO CONCLUIDA ====="
? "Formul" + CHR(225) + "rio: " + par_cClasseForm
? "Original: " + loc_cArquivoCompleto
? "Diferen" + CHR(231) + "as: " + ALLTRIM(STR(loc_oComparador.nDiferencasEncontradas))
? "Relat" + CHR(243) + "rio HTML: " + loc_cRelatorioPath
? "Arquivo de Log: " + loc_cArquivoLog
? ""

IF loc_oComparador.nDiferencasEncontradas = 0
    ? "*** UI FIDELITY OK - Nenhuma diferen" + CHR(231) + "a encontrada! ***"
    ? ""

    *-- Fecha arquivo de log
    SET ALTERNATE OFF
    SET ALTERNATE TO

    ? "UI Fidelity OK! Nenhuma diferen" + CHR(231) + "a encontrada."
    ? "Log: " + loc_cArquivoLog
    QUIT RETURN 0
ELSE
    ? "*** AVISO: Diferen" + CHR(231) + "as encontradas! Verifique o relat" + CHR(243) + "rio. ***"
    ? ""

    *-- Fecha arquivo de log
    SET ALTERNATE OFF
    SET ALTERNATE TO

    ? "Diferen" + CHR(231) + "as encontradas: " + ALLTRIM(STR(loc_oComparador.nDiferencasEncontradas))
    ? "Relat" + CHR(243) + "rio HTML: " + loc_cRelatorioPath
    ? "Log: " + loc_cArquivoLog
    QUIT RETURN 1
ENDIF
