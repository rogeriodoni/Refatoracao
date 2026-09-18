*====================================================================
* GeradorEsqueletos.prg
*
* Script para gerar codigo base de BO e Form com ~70% completo
* baseado no analise.json gerado pelo AnalisadorTarefa.prg
*
* PARAMETROS:
*   par_cArquivoJSON - Caminho completo do analise.json
*                      Ex: 'C:\4c\tasks\task1\analise.json'
*
* RETORNO:
*   Gera arquivos na pasta 'esqueletos' do task:
*   - [Entidade]BO_esqueleto.prg
*   - Form[Entidade]_esqueleto.prg
*
* EXEMPLOS:
*   VFP9.EXE GeradorEsqueletos('C:\4c\tasks\task1\analise.json')
*   DO GeradorEsqueletos WITH "C:\4c\tasks\task1\analise.json"
*====================================================================
LPARAMETERS par_cArquivoJSON

*-- Validacao de parametros
IF EMPTY(par_cArquivoJSON) OR VARTYPE(par_cArquivoJSON) # "C"
    ? "ERRO: Parametro par_cArquivoJSON nao fornecido ou invalido!"
    QUIT RETURN 1
ENDIF

IF !FILE(par_cArquivoJSON)
    ? "ERRO: Arquivo nao encontrado: " + par_cArquivoJSON
    QUIT RETURN 1
ENDIF

*-- Variaveis principais
LOCAL loc_cTaskDir, loc_cEsqueletosDir
LOCAL loc_cJSON, loc_oParser
LOCAL loc_cBOFile, loc_cFormFile

*-- Determina diretorios
loc_cTaskDir = JUSTPATH(par_cArquivoJSON)
loc_cEsqueletosDir = ADDBS(loc_cTaskDir) + "esqueletos"

*-- Cria pasta de esqueletos se nao existir
IF !DIRECTORY(loc_cEsqueletosDir)
    MKDIR (loc_cEsqueletosDir)
ENDIF

? "========================================================================"
? "GeradorEsqueletos - Gera" + CHR(231) + CHR(227) + "o de C" + CHR(243) + "digo Base"
? "========================================================================"
? "Arquivo JSON: " + par_cArquivoJSON
? "Pasta Esqueletos: " + loc_cEsqueletosDir
? "========================================================================"
? ""

*-- Carrega e parseia JSON
loc_oParser = CREATEOBJECT("ParserJSON")
IF !loc_oParser.Carregar(par_cArquivoJSON)
    ? "ERRO: Falha ao carregar JSON"
    QUIT RETURN 1
ENDIF

? "Dados carregados:"
? "  - FormClass: " + loc_oParser.cFormClass
? "  - BOClass: " + loc_oParser.cBOClass
? "  - Tabela: " + loc_oParser.cTabela
? "  - Campos: " + ALLTRIM(STR(loc_oParser.nCampos))
? "  - Lookups: " + ALLTRIM(STR(loc_oParser.nLookups))
? ""

*-- Gera BO
loc_cBOFile = ADDBS(loc_cEsqueletosDir) + loc_oParser.cBOClass + "_esqueleto.prg"
IF !GerarBO(loc_oParser, loc_cBOFile)
    ? "ERRO: Falha ao gerar BO"
    QUIT RETURN 1
ENDIF
? "BO gerado: " + loc_cBOFile

*-- Gera Form
loc_cFormFile = ADDBS(loc_cEsqueletosDir) + loc_oParser.cFormClass + "_esqueleto.prg"
IF !GerarForm(loc_oParser, loc_cFormFile)
    ? "ERRO: Falha ao gerar Form"
    QUIT RETURN 1
ENDIF
? "Form gerado: " + loc_cFormFile

? ""
? "===== ESQUELETOS GERADOS COM SUCESSO ====="
? "Pasta: " + loc_cEsqueletosDir
? ""
? "Pr" + CHR(243) + "ximos passos:"
? "1. Revisar e completar os esqueletos"
? "2. Copiar para pastas finais (classes/ e forms/cadastros/)"
? "3. Adicionar SET PROCEDURE no config.prg"
? ""

QUIT RETURN 0

*====================================================================
* GerarBO - Gera arquivo de Business Object
*====================================================================
PROCEDURE GerarBO(par_oParser, par_cArquivo)
    LOCAL loc_cCodigo, loc_nHandle, i
    LOCAL loc_cCRLF, loc_cTAB

    loc_cCRLF = CHR(13) + CHR(10)
    loc_cTAB = CHR(9)

    *-- Header
    loc_cCodigo = "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "* " + par_oParser.cBOClass + ".prg" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "*" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "* Business Object para " + par_oParser.cEntidade + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "* Tabela: " + par_oParser.cTabela + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "*" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "* GERADO AUTOMATICAMENTE - Revisar e completar" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- Classe
    loc_cCodigo = loc_cCodigo + "DEFINE CLASS " + par_oParser.cBOClass + " AS BusinessBase" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- Propriedades
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*-- Propriedades da entidade" + loc_cCRLF
    FOR i = 1 TO par_oParser.nCampos
        LOCAL loc_cProp, loc_cTipo, loc_cDefault
        loc_cProp = "this_c" + PROPER(par_oParser.aCampos[i, 3])
        loc_cTipo = par_oParser.aCampos[i, 4]

        *-- Determina prefixo e valor default baseado no tipo
        DO CASE
        CASE loc_cTipo = "N" OR loc_cTipo = "I"
            loc_cProp = "this_n" + PROPER(par_oParser.aCampos[i, 3])
            loc_cDefault = "0"
        CASE loc_cTipo = "D"
            loc_cProp = "this_d" + PROPER(par_oParser.aCampos[i, 3])
            loc_cDefault = "{}"
        CASE loc_cTipo = "L"
            loc_cProp = "this_l" + PROPER(par_oParser.aCampos[i, 3])
            loc_cDefault = ".F."
        OTHERWISE
            loc_cDefault = '""'
        ENDCASE

        loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cProp + " = " + loc_cDefault + loc_cCRLF
    ENDFOR
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- Init
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* Init - Inicializa Business Object" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROCEDURE Init()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "DODEFAULT()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + 'THIS.this_cTabela = "' + par_oParser.cTabela + '"' + loc_cCRLF

    *-- Determina campo chave (primeiro campo ou 'cods')
    LOCAL loc_cCampoChave
    loc_cCampoChave = "cods"
    IF par_oParser.nCampos > 0
        loc_cCampoChave = par_oParser.aCampos[1, 3]
    ENDIF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + 'THIS.this_cCampoChave = "' + loc_cCampoChave + '"' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "RETURN .T." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- Buscar
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* Buscar - Busca registros no banco" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROCEDURE Buscar(par_cFiltro)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "LOCAL loc_lResultado, loc_cSQL, loc_nResultado" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "loc_lResultado = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "TRY" + loc_cCRLF

    *-- Monta SELECT com colunas do grid
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'loc_cSQL = "SELECT '
    FOR i = 1 TO par_oParser.nCampos
        IF i > 1
            loc_cCodigo = loc_cCodigo + ", "
        ENDIF
        loc_cCodigo = loc_cCodigo + par_oParser.aCampos[i, 3]
    ENDFOR
    loc_cCodigo = loc_cCodigo + ' " + ;' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + '"FROM ' + par_oParser.cTabela + ' " + ;' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + '"ORDER BY ' + loc_cCampoChave + '"' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "IF !EMPTY(par_cFiltro)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + '*-- TODO: Adicionar filtro ao SQL' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "ENDIF" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "IF loc_nResultado >= 0" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + "loc_lResultado = .T." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "ELSE" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + 'THIS.this_cMensagemErro = "Erro ao buscar dados"' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + "loc_lResultado = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "ENDIF" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "CATCH TO loException" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'THIS.this_cMensagemErro = "Erro: " + loException.Message' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "loc_lResultado = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "ENDTRY" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "RETURN loc_lResultado" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- CarregarDoCursor
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* CarregarDoCursor - Carrega dados do cursor para propriedades" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROCEDURE CarregarDoCursor(par_cAliasCursor)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "LOCAL loc_lResultado" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "loc_lResultado = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "IF !USED(par_cAliasCursor)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "RETURN .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "ENDIF" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "*-- CRITICO: SELECT antes de acessar campos" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "SELECT (par_cAliasCursor)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF

    *-- Carrega cada campo
    FOR i = 1 TO par_oParser.nCampos
        LOCAL loc_cPropBO, loc_cColuna, loc_cTipoCampo
        loc_cColuna = par_oParser.aCampos[i, 3]
        loc_cTipoCampo = par_oParser.aCampos[i, 4]

        *-- Determina nome da propriedade
        DO CASE
        CASE loc_cTipoCampo = "N" OR loc_cTipoCampo = "I"
            loc_cPropBO = "THIS.this_n" + PROPER(loc_cColuna)
        CASE loc_cTipoCampo = "D"
            loc_cPropBO = "THIS.this_d" + PROPER(loc_cColuna)
        CASE loc_cTipoCampo = "L"
            loc_cPropBO = "THIS.this_l" + PROPER(loc_cColuna)
        OTHERWISE
            loc_cPropBO = "THIS.this_c" + PROPER(loc_cColuna)
        ENDCASE

        loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cPropBO + ' = TratarNulo(' + loc_cColuna + ', "' + LEFT(loc_cTipoCampo, 1) + '")' + loc_cCRLF
    ENDFOR

    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "loc_lResultado = .T." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "RETURN loc_lResultado" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- Inserir (PROTECTED)
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* Inserir - Insere novo registro" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROTECTED PROCEDURE Inserir()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "LOCAL loc_lResultado, loc_cSQL, loc_nResultado" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "loc_lResultado = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "TRY" + loc_cCRLF

    *-- Monta INSERT
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'loc_cSQL = "INSERT INTO ' + par_oParser.cTabela + ' ('
    FOR i = 1 TO par_oParser.nCampos
        IF i > 1
            loc_cCodigo = loc_cCodigo + ", "
        ENDIF
        loc_cCodigo = loc_cCodigo + par_oParser.aCampos[i, 3]
    ENDFOR
    loc_cCodigo = loc_cCodigo + ') " + ;' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + '"VALUES ("'
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- Valores
    FOR i = 1 TO par_oParser.nCampos
        LOCAL loc_cPropBO2, loc_cTipoCampo2
        loc_cTipoCampo2 = par_oParser.aCampos[i, 4]

        DO CASE
        CASE loc_cTipoCampo2 = "N" OR loc_cTipoCampo2 = "I"
            loc_cPropBO2 = "THIS.this_n" + PROPER(par_oParser.aCampos[i, 3])
            loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'loc_cSQL = loc_cSQL + FormatarNumeroSQL(' + loc_cPropBO2 + ', 2)'
        CASE loc_cTipoCampo2 = "D"
            loc_cPropBO2 = "THIS.this_d" + PROPER(par_oParser.aCampos[i, 3])
            loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'loc_cSQL = loc_cSQL + FormatarDataSQL(' + loc_cPropBO2 + ')'
        OTHERWISE
            loc_cPropBO2 = "THIS.this_c" + PROPER(par_oParser.aCampos[i, 3])
            loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'loc_cSQL = loc_cSQL + EscaparSQL(' + loc_cPropBO2 + ')'
        ENDCASE

        IF i < par_oParser.nCampos
            loc_cCodigo = loc_cCodigo + ' + ", "'
        ELSE
            loc_cCodigo = loc_cCodigo + ' + ")"'
        ENDIF
        loc_cCodigo = loc_cCodigo + loc_cCRLF
    ENDFOR

    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "IF loc_nResultado >= 0" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + 'THIS.RegistrarAuditoria("INSERT")' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + "loc_lResultado = .T." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "ELSE" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + 'THIS.this_cMensagemErro = "Erro ao inserir registro"' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + "loc_lResultado = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "ENDIF" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "CATCH TO loException" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'THIS.this_cMensagemErro = "Erro: " + loException.Message' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "loc_lResultado = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "ENDTRY" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "RETURN loc_lResultado" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- Atualizar (PROTECTED)
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* Atualizar - Atualiza registro existente" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROTECTED PROCEDURE Atualizar()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "LOCAL loc_lResultado, loc_cSQL, loc_nResultado" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "loc_lResultado = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "TRY" + loc_cCRLF

    *-- Monta UPDATE
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'loc_cSQL = "UPDATE ' + par_oParser.cTabela + ' SET "' + loc_cCRLF

    FOR i = 1 TO par_oParser.nCampos
        IF i > 1  && Pula campo chave no SET
            LOCAL loc_cPropBO3, loc_cTipoCampo3, loc_cColuna3
            loc_cColuna3 = par_oParser.aCampos[i, 3]
            loc_cTipoCampo3 = par_oParser.aCampos[i, 4]

            DO CASE
            CASE loc_cTipoCampo3 = "N" OR loc_cTipoCampo3 = "I"
                loc_cPropBO3 = "THIS.this_n" + PROPER(loc_cColuna3)
                loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'loc_cSQL = loc_cSQL + "' + loc_cColuna3 + ' = " + FormatarNumeroSQL(' + loc_cPropBO3 + ', 2)'
            CASE loc_cTipoCampo3 = "D"
                loc_cPropBO3 = "THIS.this_d" + PROPER(loc_cColuna3)
                loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'loc_cSQL = loc_cSQL + "' + loc_cColuna3 + ' = " + FormatarDataSQL(' + loc_cPropBO3 + ')'
            OTHERWISE
                loc_cPropBO3 = "THIS.this_c" + PROPER(loc_cColuna3)
                loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'loc_cSQL = loc_cSQL + "' + loc_cColuna3 + ' = " + EscaparSQL(' + loc_cPropBO3 + ')'
            ENDCASE

            IF i < par_oParser.nCampos
                loc_cCodigo = loc_cCodigo + ' + ", "'
            ENDIF
            loc_cCodigo = loc_cCodigo + loc_cCRLF
        ENDIF
    ENDFOR

    *-- WHERE
    LOCAL loc_cPropChave
    loc_cPropChave = "THIS.this_c" + PROPER(loc_cCampoChave)
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'loc_cSQL = loc_cSQL + " WHERE ' + loc_cCampoChave + ' = " + EscaparSQL(' + loc_cPropChave + ')' + loc_cCRLF

    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "IF loc_nResultado >= 0" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + 'THIS.RegistrarAuditoria("UPDATE")' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + "loc_lResultado = .T." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "ELSE" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + 'THIS.this_cMensagemErro = "Erro ao atualizar registro"' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + "loc_lResultado = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "ENDIF" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "CATCH TO loException" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'THIS.this_cMensagemErro = "Erro: " + loException.Message' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "loc_lResultado = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "ENDTRY" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "RETURN loc_lResultado" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- ObterChavePrimaria
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* ObterChavePrimaria - Retorna valor da chave primaria para auditoria" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROTECTED PROCEDURE ObterChavePrimaria()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "RETURN " + loc_cPropChave + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- Fecha classe
    loc_cCodigo = loc_cCodigo + "ENDDEFINE" + loc_cCRLF

    *-- Salva arquivo
    loc_nHandle = FCREATE(par_cArquivo)
    IF loc_nHandle < 0
        RETURN .F.
    ENDIF

    FWRITE(loc_nHandle, loc_cCodigo)
    FCLOSE(loc_nHandle)

    RETURN .T.
ENDPROC

*====================================================================
* GerarForm - Gera arquivo de Formulario
*====================================================================
PROCEDURE GerarForm(par_oParser, par_cArquivo)
    LOCAL loc_cCodigo, loc_nHandle, i
    LOCAL loc_cCRLF, loc_cTAB

    loc_cCRLF = CHR(13) + CHR(10)
    loc_cTAB = CHR(9)

    *-- Header
    loc_cCodigo = "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "* " + par_oParser.cFormClass + ".prg" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "*" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "* Formulario de cadastro de " + par_oParser.cEntidade + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "*" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "* GERADO AUTOMATICAMENTE - Revisar e completar" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- Classe
    loc_cCodigo = loc_cCodigo + "DEFINE CLASS " + par_oParser.cFormClass + " AS FormBase" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- Propriedades visuais
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*-- Propriedades visuais (COPIAR DO ORIGINAL)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "Height = " + par_oParser.cFormHeight + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "Width = " + par_oParser.cFormWidth + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + 'Caption = "' + par_oParser.cFormCaption + '"' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ShowWindow = 1" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "WindowType = 1" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cCRLF

    *-- Propriedades sem barra de titulo
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*-- SEM barra de titulo (padrao frmcadastro)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ControlBox = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "Closable = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "MaxButton = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "TitleBar = 0" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ClipControls = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "Themes = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "BorderStyle = 2" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cCRLF

    *-- Propriedades do Form
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*-- Propriedades do Form" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + 'this_cTituloForm = "' + par_oParser.cFormCaption + '"' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cCRLF

    *-- Init
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* Init - APENAS DODEFAULT (FormBase chama InicializarForm)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROCEDURE Init()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "*-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "*-- NAO chamar THIS.InicializarForm() novamente aqui!" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "RETURN DODEFAULT()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- InicializarForm
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* InicializarForm - Inicializa Business Object e componentes" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROTECTED PROCEDURE InicializarForm()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "LOCAL loc_lResultado" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "loc_lResultado = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "TRY" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "*-- Cria Business Object" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'THIS.this_oBusinessObject = CREATEOBJECT("' + par_oParser.cBOClass + '")' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "*-- Configura componentes" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "THIS.ConfigurarPageFrame()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "THIS.ConfigurarPaginaLista()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "THIS.ConfigurarPaginaDados()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "*-- Carrega dados iniciais" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "IF !gb_4c_ValidandoUI" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + "THIS.CarregarLista()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "ENDIF" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "loc_lResultado = .T." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "CATCH TO loException" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'MostrarErro("Erro ao inicializar: " + loException.Message, "Erro")' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "loc_lResultado = .F." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "ENDTRY" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "RETURN loc_lResultado" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- ConfigurarPageFrame
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* ConfigurarPageFrame - Cria e configura PageFrame principal" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROTECTED PROCEDURE ConfigurarPageFrame()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*-- TODO: Implementar criacao do PageFrame' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*-- Ver FormCor.prg como referencia' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*-- PageFrame.Top = -29 para esconder abas' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*-- COMPENSAR +29 pixels em TODOS os controles das Pages' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- ConfigurarPaginaLista
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* ConfigurarPaginaLista - Configura Page1 (lista/grid)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROTECTED PROCEDURE ConfigurarPaginaLista()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*-- TODO: Implementar Grid com ' + ALLTRIM(STR(par_oParser.nGridColunas)) + ' colunas' + loc_cCRLF

    *-- Lista colunas do grid como comentarios
    IF par_oParser.nGridColunas > 0
        loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*-- Colunas:' + loc_cCRLF
        FOR i = 1 TO par_oParser.nGridColunas
            loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*--   ' + ALLTRIM(STR(i)) + '. ' + par_oParser.aGridColunas[i, 1] + ' (' + par_oParser.aGridColunas[i, 2] + ')' + loc_cCRLF
        ENDFOR
    ENDIF

    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*-- TODO: Implementar botoes CRUD (Incluir, Alterar, Excluir, etc)' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*-- Ver CLAUDE.md secao "Botoes CRUD"' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- ConfigurarPaginaDados
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* ConfigurarPaginaDados - Configura Page2 (edicao)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROTECTED PROCEDURE ConfigurarPaginaDados()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*-- TODO: Implementar ' + ALLTRIM(STR(par_oParser.nCampos)) + ' campos' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*-- Campos:' + loc_cCRLF

    *-- Lista campos como comentarios
    FOR i = 1 TO par_oParser.nCampos
        loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*--   ' + par_oParser.aCampos[i, 2] + ' (' + par_oParser.aCampos[i, 3] + ')' + loc_cCRLF
    ENDFOR

    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF

    *-- Lista lookups como TODO
    IF par_oParser.nLookups > 0
        loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*-- TODO: Implementar ' + ALLTRIM(STR(par_oParser.nLookups)) + ' lookups:' + loc_cCRLF
        FOR i = 1 TO par_oParser.nLookups
            loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + '*--   ' + par_oParser.aLookups[i, 1] + ' -> ' + par_oParser.aLookups[i, 2] + ' (classe: ' + par_oParser.aLookups[i, 6] + ')' + loc_cCRLF
        ENDFOR
    ENDIF

    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- FormParaBO
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* FormParaBO - Transfere dados do Form para Business Object" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROCEDURE FormParaBO()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "WITH THIS.this_oBusinessObject" + loc_cCRLF

    FOR i = 1 TO par_oParser.nCampos
        LOCAL loc_cPropBO4, loc_cCampoForm
        loc_cCampoForm = par_oParser.aCampos[i, 2]

        DO CASE
        CASE par_oParser.aCampos[i, 4] = "N" OR par_oParser.aCampos[i, 4] = "I"
            loc_cPropBO4 = ".this_n" + PROPER(par_oParser.aCampos[i, 3])
        CASE par_oParser.aCampos[i, 4] = "D"
            loc_cPropBO4 = ".this_d" + PROPER(par_oParser.aCampos[i, 3])
        OTHERWISE
            loc_cPropBO4 = ".this_c" + PROPER(par_oParser.aCampos[i, 3])
        ENDCASE

        loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cPropBO4 + " = THIS.pgf_4c_Paginas.Page2." + loc_cCampoForm + ".Value" + loc_cCRLF
    ENDFOR

    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "ENDWITH" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- BOParaForm
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* BOParaForm - Transfere dados do Business Object para Form" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROCEDURE BOParaForm()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "WITH THIS.this_oBusinessObject" + loc_cCRLF

    FOR i = 1 TO par_oParser.nCampos
        LOCAL loc_cPropBO5, loc_cCampoForm2
        loc_cCampoForm2 = par_oParser.aCampos[i, 2]

        DO CASE
        CASE par_oParser.aCampos[i, 4] = "N" OR par_oParser.aCampos[i, 4] = "I"
            loc_cPropBO5 = ".this_n" + PROPER(par_oParser.aCampos[i, 3])
        CASE par_oParser.aCampos[i, 4] = "D"
            loc_cPropBO5 = ".this_d" + PROPER(par_oParser.aCampos[i, 3])
        OTHERWISE
            loc_cPropBO5 = ".this_c" + PROPER(par_oParser.aCampos[i, 3])
        ENDCASE

        loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "THIS.pgf_4c_Paginas.Page2." + loc_cCampoForm2 + ".Value = " + loc_cPropBO5 + loc_cCRLF
    ENDFOR

    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "ENDWITH" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- TornarControlesVisiveis
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* TornarControlesVisiveis - Torna controles do container visiveis" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "LOCAL i, loc_oControl" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "IF VARTYPE(par_oContainer) # 'O'" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "RETURN" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "ENDIF" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "FOR i = 1 TO par_oContainer.ControlCount" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "loc_oControl = par_oContainer.Controls(i)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "loc_oControl.Visible = .T." + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "*-- Recursivo para containers aninhados" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + 'IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + loc_cTAB + "THIS.TornarControlesVisiveis(loc_oControl)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "ENDIF" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "ENDFOR" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- FormatarGridLista
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "* FormatarGridLista - Formata Grid apos carregar dados" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "*====================================================================" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "PROTECTED PROCEDURE FormatarGridLista(par_oGrid)" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "IF VARTYPE(par_oGrid) # 'O'" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cTAB + "RETURN" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "ENDIF" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + 'par_oGrid.FontName = "Tahoma"' + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "par_oGrid.FontSize = 8" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + loc_cTAB + "par_oGrid.Refresh()" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cTAB + "ENDPROC" + loc_cCRLF
    loc_cCodigo = loc_cCodigo + loc_cCRLF

    *-- Fecha classe
    loc_cCodigo = loc_cCodigo + "ENDDEFINE" + loc_cCRLF

    *-- Salva arquivo
    loc_nHandle = FCREATE(par_cArquivo)
    IF loc_nHandle < 0
        RETURN .F.
    ENDIF

    FWRITE(loc_nHandle, loc_cCodigo)
    FCLOSE(loc_nHandle)

    RETURN .T.
ENDPROC

*====================================================================
* CLASSE: ParserJSON
* Parseia arquivo analise.json e extrai dados
*====================================================================
DEFINE CLASS ParserJSON AS Custom

    *-- Informacoes basicas
    cBaseName = ""
    cFormClass = ""
    cBOClass = ""
    cEntidade = ""
    cTabela = ""
    cCursorName = ""

    *-- Propriedades visuais
    cFormWidth = "1000"
    cFormHeight = "600"
    cFormCaption = ""

    *-- Arrays
    DIMENSION aCampos[1, 12]
    nCampos = 0

    DIMENSION aLookups[1, 7]
    nLookups = 0

    DIMENSION aLabels[1, 10]
    nLabels = 0

    DIMENSION aGridColunas[1, 4]
    nGridColunas = 0

    *====================================================================
    * Carregar - Carrega e parseia JSON
    *====================================================================
    PROCEDURE Carregar(par_cArquivo)
        LOCAL loc_nHandle, loc_cJSON, loc_cLinha
        LOCAL loc_cSecaoAtual, loc_nItemAtual, i

        loc_nHandle = FOPEN(par_cArquivo, 0)
        IF loc_nHandle < 0
            RETURN .F.
        ENDIF

        loc_cJSON = FREAD(loc_nHandle, 500000)
        FCLOSE(loc_nHandle)

        *-- Parse simples linha por linha
        LOCAL ARRAY loc_aLinhas[1]
        LOCAL loc_nLinhas

        loc_nLinhas = ALINES(loc_aLinhas, loc_cJSON)
        loc_cSecaoAtual = ""
        loc_nItemAtual = 0

        FOR i = 1 TO loc_nLinhas
            loc_cLinha = ALLTRIM(loc_aLinhas[i])

            *-- Detecta secao
            IF '"form":' $ loc_cLinha
                loc_cSecaoAtual = "form"
                LOOP
            ENDIF
            IF '"propriedadesVisuais":' $ loc_cLinha
                loc_cSecaoAtual = "propriedades"
                LOOP
            ENDIF
            IF '"campos":' $ loc_cLinha
                loc_cSecaoAtual = "campos"
                loc_nItemAtual = 0
                LOOP
            ENDIF
            IF '"lookups":' $ loc_cLinha
                loc_cSecaoAtual = "lookups"
                loc_nItemAtual = 0
                LOOP
            ENDIF
            IF '"labels":' $ loc_cLinha
                loc_cSecaoAtual = "labels"
                loc_nItemAtual = 0
                LOOP
            ENDIF
            IF '"grid":' $ loc_cLinha
                loc_cSecaoAtual = "grid"
                LOOP
            ENDIF
            IF '"colunas":' $ loc_cLinha
                loc_cSecaoAtual = "gridcolunas"
                loc_nItemAtual = 0
                LOOP
            ENDIF

            *-- Processa propriedades
            DO CASE
            CASE loc_cSecaoAtual = "form"
                THIS.ProcessarPropriedadeForm(loc_cLinha)

            CASE loc_cSecaoAtual = "propriedades"
                THIS.ProcessarPropriedadeVisual(loc_cLinha)

            CASE loc_cSecaoAtual = "campos"
                IF "{" $ loc_cLinha AND !("}" $ loc_cLinha)
                    loc_nItemAtual = loc_nItemAtual + 1
                    THIS.nCampos = loc_nItemAtual
                    IF THIS.nCampos > ALEN(THIS.aCampos, 1)
                        DIMENSION THIS.aCampos[THIS.nCampos + 20, 12]
                    ENDIF
                ENDIF
                IF loc_nItemAtual > 0
                    THIS.ProcessarCampo(loc_cLinha, loc_nItemAtual)
                ENDIF

            CASE loc_cSecaoAtual = "lookups"
                IF "{" $ loc_cLinha AND !("}" $ loc_cLinha)
                    loc_nItemAtual = loc_nItemAtual + 1
                    THIS.nLookups = loc_nItemAtual
                    IF THIS.nLookups > ALEN(THIS.aLookups, 1)
                        DIMENSION THIS.aLookups[THIS.nLookups + 10, 7]
                    ENDIF
                ENDIF
                IF loc_nItemAtual > 0
                    THIS.ProcessarLookup(loc_cLinha, loc_nItemAtual)
                ENDIF

            CASE loc_cSecaoAtual = "gridcolunas"
                IF "{" $ loc_cLinha AND !("}" $ loc_cLinha)
                    loc_nItemAtual = loc_nItemAtual + 1
                    THIS.nGridColunas = loc_nItemAtual
                    IF THIS.nGridColunas > ALEN(THIS.aGridColunas, 1)
                        DIMENSION THIS.aGridColunas[THIS.nGridColunas + 10, 4]
                    ENDIF
                ENDIF
                IF loc_nItemAtual > 0
                    THIS.ProcessarColunaGrid(loc_cLinha, loc_nItemAtual)
                ENDIF
            ENDCASE
        ENDFOR

        RETURN .T.
    ENDPROC

    *====================================================================
    * ProcessarPropriedadeForm - Processa propriedade da secao form
    *====================================================================
    PROTECTED PROCEDURE ProcessarPropriedadeForm(par_cLinha)
        IF '"baseName":' $ par_cLinha
            THIS.cBaseName = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"formClass":' $ par_cLinha
            THIS.cFormClass = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"boClass":' $ par_cLinha
            THIS.cBOClass = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"entidade":' $ par_cLinha
            THIS.cEntidade = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"tabela":' $ par_cLinha
            THIS.cTabela = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"cursorName":' $ par_cLinha
            THIS.cCursorName = THIS.ExtrairValor(par_cLinha)
        ENDIF
    ENDPROC

    *====================================================================
    * ProcessarPropriedadeVisual - Processa propriedade visual
    *====================================================================
    PROTECTED PROCEDURE ProcessarPropriedadeVisual(par_cLinha)
        IF '"Width":' $ par_cLinha
            THIS.cFormWidth = THIS.ExtrairValorNumerico(par_cLinha)
        ENDIF
        IF '"Height":' $ par_cLinha
            THIS.cFormHeight = THIS.ExtrairValorNumerico(par_cLinha)
        ENDIF
        IF '"Caption":' $ par_cLinha
            THIS.cFormCaption = THIS.ExtrairValor(par_cLinha)
        ENDIF
    ENDPROC

    *====================================================================
    * ProcessarCampo - Processa campo do array
    *====================================================================
    PROTECTED PROCEDURE ProcessarCampo(par_cLinha, par_nIndice)
        IF '"objetoOriginal":' $ par_cLinha
            THIS.aCampos[par_nIndice, 1] = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"novoNome":' $ par_cLinha
            THIS.aCampos[par_nIndice, 2] = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"colunaBD":' $ par_cLinha
            THIS.aCampos[par_nIndice, 3] = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"tipo":' $ par_cLinha
            THIS.aCampos[par_nIndice, 4] = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"inputMask":' $ par_cLinha
            THIS.aCampos[par_nIndice, 6] = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"width":' $ par_cLinha
            THIS.aCampos[par_nIndice, 7] = THIS.ExtrairValorNumerico(par_cLinha)
        ENDIF
        IF '"height":' $ par_cLinha
            THIS.aCampos[par_nIndice, 8] = THIS.ExtrairValorNumerico(par_cLinha)
        ENDIF
        IF '"top":' $ par_cLinha
            THIS.aCampos[par_nIndice, 9] = THIS.ExtrairValorNumerico(par_cLinha)
        ENDIF
        IF '"left":' $ par_cLinha
            THIS.aCampos[par_nIndice, 10] = THIS.ExtrairValorNumerico(par_cLinha)
        ENDIF
    ENDPROC

    *====================================================================
    * ProcessarLookup - Processa lookup do array
    *====================================================================
    PROTECTED PROCEDURE ProcessarLookup(par_cLinha, par_nIndice)
        IF '"campo":' $ par_cLinha
            THIS.aLookups[par_nIndice, 1] = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"tabela":' $ par_cLinha
            THIS.aLookups[par_nIndice, 2] = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"campoCodigo":' $ par_cLinha
            THIS.aLookups[par_nIndice, 3] = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"tecla":' $ par_cLinha
            THIS.aLookups[par_nIndice, 5] = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"classeOriginal":' $ par_cLinha
            THIS.aLookups[par_nIndice, 6] = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"evento":' $ par_cLinha
            THIS.aLookups[par_nIndice, 7] = THIS.ExtrairValor(par_cLinha)
        ENDIF
    ENDPROC

    *====================================================================
    * ProcessarColunaGrid - Processa coluna do grid
    *====================================================================
    PROTECTED PROCEDURE ProcessarColunaGrid(par_cLinha, par_nIndice)
        IF '"header":' $ par_cLinha
            THIS.aGridColunas[par_nIndice, 1] = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"controlSource":' $ par_cLinha
            THIS.aGridColunas[par_nIndice, 2] = THIS.ExtrairValor(par_cLinha)
        ENDIF
        IF '"width":' $ par_cLinha
            THIS.aGridColunas[par_nIndice, 3] = THIS.ExtrairValorNumerico(par_cLinha)
        ENDIF
    ENDPROC

    *====================================================================
    * ExtrairValor - Extrai valor de string JSON
    *====================================================================
    PROTECTED PROCEDURE ExtrairValor(par_cLinha)
        LOCAL loc_nPos1, loc_nPos2, loc_cValor

        *-- Procura valor entre aspas apos ":"
        loc_nPos1 = AT(':', par_cLinha)
        IF loc_nPos1 = 0
            RETURN ""
        ENDIF

        loc_cValor = SUBSTR(par_cLinha, loc_nPos1 + 1)
        loc_cValor = ALLTRIM(loc_cValor)

        *-- Remove aspas
        loc_cValor = STRTRAN(loc_cValor, '"', "")
        loc_cValor = STRTRAN(loc_cValor, ",", "")

        RETURN ALLTRIM(loc_cValor)
    ENDPROC

    *====================================================================
    * ExtrairValorNumerico - Extrai valor numerico de linha JSON
    *====================================================================
    PROTECTED PROCEDURE ExtrairValorNumerico(par_cLinha)
        LOCAL loc_nPos1, loc_cValor

        loc_nPos1 = AT(':', par_cLinha)
        IF loc_nPos1 = 0
            RETURN "0"
        ENDIF

        loc_cValor = SUBSTR(par_cLinha, loc_nPos1 + 1)
        loc_cValor = ALLTRIM(loc_cValor)
        loc_cValor = STRTRAN(loc_cValor, ",", "")

        RETURN ALLTRIM(loc_cValor)
    ENDPROC

ENDDEFINE
