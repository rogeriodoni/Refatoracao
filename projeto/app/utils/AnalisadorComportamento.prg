*====================================================================
* AnalisadorComportamento.prg
*
* Script para analisar SECAO 3 (metodos e eventos) do arquivo de
* codigo fonte extraido e gerar comportamento.json com analise
* profunda da logica comportamental.
*
* PARAMETROS:
*   par_cArquivoTXT - Caminho completo do .TXT com codigo fonte
*   par_cSchemaSQL  - Caminho completo do schema.sql (UTF-16)
*
* RETORNO:
*   Gera arquivo comportamento.json no mesmo diretorio do .TXT
*
* EXEMPLOS:
*   DO AnalisadorComportamento WITH ;
*      "C:\4c\tasks\task026\sigopind_form_codigo_fonte.txt", ;
*      "C:\4c\docs\schema.sql"
*====================================================================
LPARAMETERS par_cArquivoTXT, par_cSchemaSQL

*-- Validacao de parametros
IF EMPTY(par_cArquivoTXT) OR VARTYPE(par_cArquivoTXT) # "C"
    ? "ERRO: Parametro par_cArquivoTXT nao fornecido ou invalido!"
    QUIT RETURN 1
ENDIF

IF !FILE(par_cArquivoTXT)
    ? "ERRO: Arquivo nao encontrado: " + par_cArquivoTXT
    QUIT RETURN 1
ENDIF

IF EMPTY(par_cSchemaSQL) OR VARTYPE(par_cSchemaSQL) # "C"
    ? "AVISO: par_cSchemaSQL nao fornecido - validacao de schema desabilitada"
    par_cSchemaSQL = ""
ENDIF

IF !EMPTY(par_cSchemaSQL) AND !FILE(par_cSchemaSQL)
    ? "AVISO: Schema nao encontrado: " + par_cSchemaSQL + " - validacao desabilitada"
    par_cSchemaSQL = ""
ENDIF

*-- Variaveis principais
LOCAL loc_cTaskDir, loc_cArquivoJSON
LOCAL loc_oAnalisador

loc_cTaskDir = JUSTPATH(par_cArquivoTXT)
loc_cArquivoJSON = ADDBS(loc_cTaskDir) + "comportamento.json"

? "AnalisadorComportamento v1.0"
? "Arquivo: " + par_cArquivoTXT
? "Schema:  " + IIF(EMPTY(par_cSchemaSQL), "(nenhum)", par_cSchemaSQL)
? "Output:  " + loc_cArquivoJSON
?

*-- Cria e executa analisador
loc_oAnalisador = CREATEOBJECT("AnalisadorComportamento")

IF !loc_oAnalisador.Analisar(par_cArquivoTXT, par_cSchemaSQL)
    ? "ERRO: Falha na analise comportamental"
    QUIT RETURN 1
ENDIF

*-- Gera JSON
LOCAL loc_cJSON
loc_cJSON = loc_oAnalisador.GerarJSON()

IF EMPTY(loc_cJSON)
    ? "ERRO: JSON gerado vazio"
    QUIT RETURN 1
ENDIF

*-- Salva arquivo
LOCAL loc_nHandle
loc_nHandle = FCREATE(loc_cArquivoJSON)
IF loc_nHandle < 0
    ? "ERRO: Nao foi possivel criar: " + loc_cArquivoJSON
    QUIT RETURN 1
ENDIF

=FWRITE(loc_nHandle, loc_cJSON)
=FCLOSE(loc_nHandle)

? "comportamento.json gerado com sucesso!"
? "  Metodos: " + TRANSFORM(loc_oAnalisador.this_nTotalMetodos)
? "  Queries SQL: " + TRANSFORM(loc_oAnalisador.this_nTotalSQL)
? "  Validacoes: " + TRANSFORM(loc_oAnalisador.this_nTotalValidacoes)
? "  Funcoes externas: " + TRANSFORM(loc_oAnalisador.this_nTotalFuncoesExternas)

IF loc_oAnalisador.this_nTotalColunasInvalidas > 0
    ? "  *** COLUNAS INVALIDAS: " + TRANSFORM(loc_oAnalisador.this_nTotalColunasInvalidas) + " ***"
ENDIF

loc_oAnalisador = .NULL.

QUIT RETURN 0

*====================================================================
* Classe AnalisadorComportamento
*====================================================================
DEFINE CLASS AnalisadorComportamento AS Custom

    *-- Contadores
    this_nTotalMetodos = 0
    this_nTotalSQL = 0
    this_nTotalValidacoes = 0
    this_nTotalFuncoesExternas = 0
    this_nTotalColunasInvalidas = 0

    *-- Arrays de dados
    DIMENSION this_aLinhas[1]
    this_nLinhas = 0

    DIMENSION this_aMetodos[1, 12]
    *-- Colunas: 1=Objeto, 2=Evento, 3=NumLinhas, 4=CodigoOriginal,
    *--          5=TemSQL, 6=TemValidacao, 7=TemLookup, 8=TemNavegacao,
    *--          9=FuncoesExternas, 10=MetodosFormChamados,
    *--          11=ControlesReferenciados, 12=RetornaFalso
    this_nMetodos = 0

    DIMENSION this_aQueries[1, 5]
    *-- Colunas: 1=NomeMetodo, 2=QueryOriginal, 3=Tabelas, 4=Colunas, 5=ColunasInvalidas
    this_nQueries = 0

    DIMENSION this_aSchema[1, 3]
    *-- Colunas: 1=NomeTabela, 2=ColunasCSV, 3=ColunaTiposCSV (col:tipo,col:tipo - somente BIT e DATETIME)
    this_nSchema = 0

    DIMENSION this_aColunaTipos[1, 3]
    *-- Colunas: 1=NomeTabela, 2=NomeColuna, 3=TipoSQL
    this_nColunaTipos = 0

    DIMENSION this_aFuncoesExternas[1]
    this_nFuncoesExternas = 0

    DIMENSION this_aTabelasUsadas[1]
    this_nTabelasUsadas = 0

    DIMENSION this_aColunasInvalidas[1, 3]
    *-- Colunas: 1=Tabela, 2=Coluna, 3=Metodo
    this_nColunasInvalidas = 0

    *====================================================================
    * Analisar - Metodo principal
    *====================================================================
    PROCEDURE Analisar(par_cArquivoTXT, par_cSchemaSQL)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- 1. Carregar arquivo
            IF !THIS.CarregarArquivo(par_cArquivoTXT)
                ? "ERRO: Falha ao carregar arquivo"
                loc_lResultado = .F.
            ELSE
                *-- 2. Carregar schema (se disponivel)
                IF !EMPTY(par_cSchemaSQL)
                    THIS.CarregarSchema(par_cSchemaSQL)
                ENDIF

                *-- 3. Extrair metodos da SECAO 3
                THIS.ExtrairMetodos()

                *-- 4. Extrair queries SQL dos metodos
                THIS.ExtrairQueries()

                *-- 5. Validar colunas contra schema
                IF THIS.this_nSchema > 0
                    THIS.ValidarColunasContraSchema()
                ENDIF

                *-- 5b. Extrair tipos de colunas (BIT/DATETIME) para tabelas usadas
                IF THIS.this_nSchema > 0 AND THIS.this_nTabelasUsadas > 0
                    THIS.ExtrairColunaTipos()
                ENDIF

                *-- 6. Coletar funcoes externas unicas
                THIS.ColetarFuncoesExternas()

                *-- Atualizar contadores
                THIS.this_nTotalMetodos = THIS.this_nMetodos
                THIS.this_nTotalSQL = THIS.this_nQueries
                THIS.this_nTotalColunasInvalidas = THIS.this_nColunasInvalidas

                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            ? "ERRO em Analisar(): Linha " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarArquivo - Le arquivo e split em linhas
    *====================================================================
    PROTECTED PROCEDURE CarregarArquivo(par_cArquivo)
        LOCAL loc_cConteudo
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Usar FILETOSTR() para ler arquivo completo
            *-- NOTA: FSIZE() eh para campos de tabela, NAO para arquivos!
            loc_cConteudo = FILETOSTR(par_cArquivo)

            IF EMPTY(loc_cConteudo)
                ? "ERRO: Arquivo vazio: " + par_cArquivo
                loc_lResultado = .F.
            ELSE
                THIS.this_nLinhas = ALINES(THIS.this_aLinhas, loc_cConteudo)
                ? "  Linhas carregadas: " + TRANSFORM(THIS.this_nLinhas)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            ? "ERRO em CarregarArquivo(): " + loException.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarSchema - Le schema.sql (UTF-16) e extrai tabelas/colunas
    *====================================================================
    PROTECTED PROCEDURE CarregarSchema(par_cArquivoSchema)
        LOCAL loc_cConteudo, loc_cASCII
        LOCAL loc_cLinha, loc_cTabelaAtual, loc_cColunas
        LOCAL loc_nI, loc_nLinhas, loc_lDentroTabela
        LOCAL loc_nPos1, loc_nPos2, loc_cNome, loc_nFim, loc_cColuna
        LOCAL loc_cPrimeiro
        LOCAL ARRAY loc_aLinhasSchema[1]

        TRY
            loc_cConteudo = FILETOSTR(par_cArquivoSchema)

            IF EMPTY(loc_cConteudo)
                ? "AVISO: Schema vazio ou nao lido: " + par_cArquivoSchema
                RETURN
            ENDIF

            *-- Remover BOM (FF FE) se presente
            IF LEFT(loc_cConteudo, 2) = CHR(255) + CHR(254)
                loc_cConteudo = SUBSTR(loc_cConteudo, 3)
            ENDIF

            *-- Remover bytes nulos (UTF-16 -> ASCII)
            loc_cASCII = CHRTRAN(loc_cConteudo, CHR(0), "")

            *-- Liberar memoria do conteudo original
            loc_cConteudo = ""

            *-- Split em linhas
            loc_nLinhas = ALINES(loc_aLinhasSchema, loc_cASCII)

            *-- Liberar memoria
            loc_cASCII = ""

            ? "  Schema carregado: " + TRANSFORM(loc_nLinhas) + " linhas"

            *-- Parsear CREATE TABLE statements
            loc_lDentroTabela = .F.
            loc_cTabelaAtual = ""
            loc_cColunas = ""
            LOCAL loc_cColTipos
            loc_cColTipos = ""

            FOR loc_nI = 1 TO loc_nLinhas
                loc_cLinha = ALLTRIM(loc_aLinhasSchema[loc_nI])

                *-- Skip de linhas vazias e comentarios (maioria do schema)
                IF EMPTY(loc_cLinha) OR LEFT(loc_cLinha, 2) = "--" OR LEFT(loc_cLinha, 2) = "/*"
                    LOOP
                ENDIF

                loc_cPrimeiro = LEFT(loc_cLinha, 1)

                IF !loc_lDentroTabela
                    *-- Fora de tabela: so interessa CREATE TABLE
                    IF ATC("CREATE TABLE", loc_cLinha) > 0
                        loc_nPos1 = ATC("[dbo].[", loc_cLinha)
                        IF loc_nPos1 > 0
                            loc_nPos1 = loc_nPos1 + 6
                            loc_nPos2 = AT("]", loc_cLinha, 3)
                            IF loc_nPos2 > loc_nPos1
                                loc_cNome = SUBSTR(loc_cLinha, loc_nPos1 + 1, loc_nPos2 - loc_nPos1 - 1)
                                loc_cTabelaAtual = loc_cNome
                                loc_cColunas = ""
                                loc_cColTipos = ""
                                loc_lDentroTabela = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ELSE
                    *-- Dentro de tabela: extrair colunas ou detectar fim
                    IF loc_cPrimeiro = "["
                        loc_nFim = AT("]", loc_cLinha)
                        IF loc_nFim > 1
                            loc_cColuna = SUBSTR(loc_cLinha, 2, loc_nFim - 2)
                            IF !EMPTY(loc_cColunas)
                                loc_cColunas = loc_cColunas + ","
                            ENDIF
                            loc_cColunas = loc_cColunas + LOWER(ALLTRIM(loc_cColuna))

                            *-- Extrair tipo da coluna: formato [coluna] [tipo]
                            *-- Segundo par de colchetes contem o tipo
                            LOCAL loc_nTipoIni, loc_nTipoFim, loc_cTipoCol
                            loc_nTipoIni = AT("[", loc_cLinha, 2)
                            loc_nTipoFim = AT("]", loc_cLinha, 2)
                            IF loc_nTipoIni > 0 AND loc_nTipoFim > loc_nTipoIni
                                loc_cTipoCol = LOWER(SUBSTR(loc_cLinha, loc_nTipoIni + 1, loc_nTipoFim - loc_nTipoIni - 1))
                                *-- Somente BIT e DATETIME causam bugs de migracao
                                IF loc_cTipoCol = "bit" OR loc_cTipoCol = "datetime"
                                    IF !EMPTY(loc_cColTipos)
                                        loc_cColTipos = loc_cColTipos + ","
                                    ENDIF
                                    loc_cColTipos = loc_cColTipos + LOWER(ALLTRIM(loc_cColuna)) + ":" + loc_cTipoCol
                                ENDIF
                            ENDIF
                        ENDIF
                    ELSE
                        IF ATC("CONSTRAINT", loc_cLinha) > 0 OR ;
                           (loc_cPrimeiro = ")" AND ATC("ON", loc_cLinha) > 0)
                            IF !EMPTY(loc_cTabelaAtual) AND !EMPTY(loc_cColunas)
                                THIS.this_nSchema = THIS.this_nSchema + 1
                                DIMENSION THIS.this_aSchema[THIS.this_nSchema, 3]
                                THIS.this_aSchema[THIS.this_nSchema, 1] = LOWER(loc_cTabelaAtual)
                                THIS.this_aSchema[THIS.this_nSchema, 2] = loc_cColunas
                                THIS.this_aSchema[THIS.this_nSchema, 3] = loc_cColTipos
                            ENDIF
                            loc_lDentroTabela = .F.
                            loc_cTabelaAtual = ""
                        ENDIF
                    ENDIF
                ENDIF
            ENDFOR

            ? "  Tabelas no schema: " + TRANSFORM(THIS.this_nSchema)

        CATCH TO loException
            ? "AVISO em CarregarSchema(): Linha " + TRANSFORM(loException.LineNo) + " - " + loException.Message
        ENDTRY
    ENDPROC

    *====================================================================
    * ExtrairMetodos - Parseia SECAO 3 e extrai metodos/eventos
    *====================================================================
    PROTECTED PROCEDURE ExtrairMetodos()
        LOCAL loc_nI, loc_cLinha, loc_cLinhaUpper
        LOCAL loc_lDentroSecao3, loc_cObjetoAtual
        LOCAL loc_lDentroMetodo, loc_cNomeMetodo, loc_cCorpoMetodo
        LOCAL loc_nLinhasMetodo, loc_cEvento

        loc_lDentroSecao3 = .F.
        loc_cObjetoAtual = ""
        loc_lDentroMetodo = .F.
        loc_cNomeMetodo = ""
        loc_cCorpoMetodo = ""
        loc_nLinhasMetodo = 0
        loc_cEvento = ""

        FOR loc_nI = 1 TO THIS.this_nLinhas
            loc_cLinha = THIS.this_aLinhas[loc_nI]
            loc_cLinhaUpper = UPPER(ALLTRIM(loc_cLinha))

            *-- Detectar inicio da SECAO 3
            IF ATC("SECAO 3:", loc_cLinhaUpper) > 0 AND ATC("METODOS", loc_cLinhaUpper) > 0
                loc_lDentroSecao3 = .T.
                LOOP
            ENDIF

            *-- Detectar inicio da SECAO 4 (fim da SECAO 3)
            IF ATC("SECAO 4:", loc_cLinhaUpper) > 0
                *-- Salvar ultimo metodo se aberto
                IF loc_lDentroMetodo AND !EMPTY(loc_cNomeMetodo)
                    THIS.SalvarMetodo(loc_cObjetoAtual, loc_cNomeMetodo, ;
                        loc_nLinhasMetodo, loc_cCorpoMetodo)
                ENDIF
                EXIT
            ENDIF

            IF !loc_lDentroSecao3
                LOOP
            ENDIF

            *-- Detectar bloco de OBJETO
            IF LEFT(loc_cLinhaUpper, 10) = "* OBJETO: "
                *-- Salvar metodo anterior se aberto
                IF loc_lDentroMetodo AND !EMPTY(loc_cNomeMetodo)
                    THIS.SalvarMetodo(loc_cObjetoAtual, loc_cNomeMetodo, ;
                        loc_nLinhasMetodo, loc_cCorpoMetodo)
                    loc_lDentroMetodo = .F.
                ENDIF
                loc_cObjetoAtual = ALLTRIM(SUBSTR(ALLTRIM(loc_cLinha), 11))
                LOOP
            ENDIF

            *-- Detectar PROCEDURE/FUNCTION header comment
            IF LEFT(loc_cLinhaUpper, 12) = "* PROCEDURE " OR ;
               LEFT(loc_cLinhaUpper, 11) = "* FUNCTION "
                *-- Salvar metodo anterior se aberto
                IF loc_lDentroMetodo AND !EMPTY(loc_cNomeMetodo)
                    THIS.SalvarMetodo(loc_cObjetoAtual, loc_cNomeMetodo, ;
                        loc_nLinhasMetodo, loc_cCorpoMetodo)
                ENDIF
                *-- Extrair nome do metodo/evento
                IF LEFT(loc_cLinhaUpper, 12) = "* PROCEDURE "
                    loc_cNomeMetodo = ALLTRIM(SUBSTR(ALLTRIM(loc_cLinha), 13))
                ELSE
                    loc_cNomeMetodo = ALLTRIM(SUBSTR(ALLTRIM(loc_cLinha), 12))
                ENDIF
                loc_cCorpoMetodo = ""
                loc_nLinhasMetodo = 0
                loc_lDentroMetodo = .F.
                LOOP
            ENDIF

            *-- Detectar inicio do codigo (PROCEDURE/FUNCTION keyword)
            IF (LEFT(loc_cLinhaUpper, 10) = "PROCEDURE " OR ;
                LEFT(loc_cLinhaUpper, 9) = "FUNCTION ") AND ;
               !loc_lDentroMetodo
                loc_lDentroMetodo = .T.
                loc_nLinhasMetodo = 0
                loc_cCorpoMetodo = ""
                *-- Se nao pegou nome do header, pegar daqui
                IF EMPTY(loc_cNomeMetodo)
                    IF LEFT(loc_cLinhaUpper, 10) = "PROCEDURE "
                        loc_cNomeMetodo = ALLTRIM(SUBSTR(loc_cLinhaUpper, 11))
                    ELSE
                        loc_cNomeMetodo = ALLTRIM(SUBSTR(loc_cLinhaUpper, 10))
                    ENDIF
                ENDIF
                LOOP
            ENDIF

            *-- Detectar fim do metodo
            IF loc_lDentroMetodo AND loc_cLinhaUpper = "ENDPROC"
                THIS.SalvarMetodo(loc_cObjetoAtual, loc_cNomeMetodo, ;
                    loc_nLinhasMetodo, loc_cCorpoMetodo)
                loc_lDentroMetodo = .F.
                loc_cNomeMetodo = ""
                loc_cCorpoMetodo = ""
                loc_nLinhasMetodo = 0
                LOOP
            ENDIF

            *-- Acumular corpo do metodo
            IF loc_lDentroMetodo
                loc_nLinhasMetodo = loc_nLinhasMetodo + 1
                IF LEN(loc_cCorpoMetodo) < 4000
                    loc_cCorpoMetodo = loc_cCorpoMetodo + ;
                        IIF(EMPTY(loc_cCorpoMetodo), "", CHR(10)) + loc_cLinha
                ENDIF
            ENDIF
        ENDFOR

        *-- Salvar ultimo metodo se ficou aberto (sem ENDPROC)
        IF loc_lDentroMetodo AND !EMPTY(loc_cNomeMetodo)
            THIS.SalvarMetodo(loc_cObjetoAtual, loc_cNomeMetodo, ;
                loc_nLinhasMetodo, loc_cCorpoMetodo)
        ENDIF

        ? "  Metodos extraidos: " + TRANSFORM(THIS.this_nMetodos)
    ENDPROC

    *====================================================================
    * SalvarMetodo - Analisa e salva um metodo
    *====================================================================
    PROTECTED PROCEDURE SalvarMetodo(par_cObjeto, par_cNomeMetodo, par_nLinhas, par_cCorpo)
        LOCAL loc_cCorpoUpper, loc_cEvento
        LOCAL loc_lTemSQL, loc_lTemValidacao, loc_lTemLookup, loc_lTemNavegacao
        LOCAL loc_cFuncoesExternas, loc_cMetodosForm, loc_cControles, loc_lRetornaFalso

        IF EMPTY(par_cNomeMetodo)
            RETURN
        ENDIF

        loc_cCorpoUpper = UPPER(par_cCorpo)

        *-- Determinar evento (Valid, Click, Init, etc.)
        loc_cEvento = THIS.DeterminarEvento(par_cNomeMetodo, par_cObjeto)

        *-- Detectar SQL
        loc_lTemSQL = (ATC("SQLEXEC", loc_cCorpoUpper) > 0 OR ;
                       ATC("SELECT ", loc_cCorpoUpper) > 0 OR ;
                       ATC("INSERT ", loc_cCorpoUpper) > 0 OR ;
                       ATC("UPDATE ", loc_cCorpoUpper) > 0 OR ;
                       ATC("DELETE ", loc_cCorpoUpper) > 0)

        *-- Detectar validacao
        loc_lTemValidacao = (ATC("RETURN .F.", loc_cCorpoUpper) > 0 OR ;
                             ATC("MESSAGEBOX", loc_cCorpoUpper) > 0 OR ;
                             ATC("MSGERRO", loc_cCorpoUpper) > 0 OR ;
                             ATC("MSGAVISO", loc_cCorpoUpper) > 0 OR ;
                             ATC("MOSTRARERRO", loc_cCorpoUpper) > 0 OR ;
                             ATC("EMPTY(", loc_cCorpoUpper) > 0)

        IF loc_lTemValidacao
            THIS.this_nTotalValidacoes = THIS.this_nTotalValidacoes + 1
        ENDIF

        *-- Detectar lookup
        loc_lTemLookup = (ATC("FWBUSCAEXT", loc_cCorpoUpper) > 0 OR ;
                          ATC("FWBUSCAINT", loc_cCorpoUpper) > 0 OR ;
                          ATC("FACESSOCONTAB", loc_cCorpoUpper) > 0 OR ;
                          ATC("FACESSOCONTAS", loc_cCorpoUpper) > 0 OR ;
                          ATC("FACESSOEMPRESA", loc_cCorpoUpper) > 0 OR ;
                          ATC("FORMBUSCAAUXILIAR", loc_cCorpoUpper) > 0 OR ;
                          ATC("LOOKUP", loc_cCorpoUpper) > 0)

        *-- Detectar navegacao
        loc_lTemNavegacao = (ATC("ACTIVEPAGE", loc_cCorpoUpper) > 0 OR ;
                             ATC("ALTERNARPAGINA", loc_cCorpoUpper) > 0 OR ;
                             ATC(".VISIBLE", loc_cCorpoUpper) > 0 OR ;
                             ATC(".ENABLED", loc_cCorpoUpper) > 0 OR ;
                             ATC(".SETFOCUS", loc_cCorpoUpper) > 0)

        *-- Detectar retorna .F.
        loc_lRetornaFalso = (ATC("RETURN .F.", loc_cCorpoUpper) > 0)

        *-- Extrair funcoes externas
        loc_cFuncoesExternas = THIS.ExtrairFuncoesExternas(par_cCorpo)

        *-- Extrair metodos de form chamados
        loc_cMetodosForm = THIS.ExtrairMetodosForm(par_cCorpo)

        *-- Extrair controles referenciados
        loc_cControles = THIS.ExtrairControlesReferenciados(par_cCorpo)

        *-- Salvar no array
        THIS.this_nMetodos = THIS.this_nMetodos + 1
        DIMENSION THIS.this_aMetodos[THIS.this_nMetodos, 12]
        THIS.this_aMetodos[THIS.this_nMetodos, 1] = par_cObjeto
        THIS.this_aMetodos[THIS.this_nMetodos, 2] = loc_cEvento
        THIS.this_aMetodos[THIS.this_nMetodos, 3] = par_nLinhas
        *-- Truncar codigo a 500 chars
        IF LEN(par_cCorpo) > 500
            THIS.this_aMetodos[THIS.this_nMetodos, 4] = LEFT(par_cCorpo, 500) + "... [TRUNCADO]"
        ELSE
            THIS.this_aMetodos[THIS.this_nMetodos, 4] = par_cCorpo
        ENDIF
        THIS.this_aMetodos[THIS.this_nMetodos, 5] = loc_lTemSQL
        THIS.this_aMetodos[THIS.this_nMetodos, 6] = loc_lTemValidacao
        THIS.this_aMetodos[THIS.this_nMetodos, 7] = loc_lTemLookup
        THIS.this_aMetodos[THIS.this_nMetodos, 8] = loc_lTemNavegacao
        THIS.this_aMetodos[THIS.this_nMetodos, 9] = loc_cFuncoesExternas
        THIS.this_aMetodos[THIS.this_nMetodos, 10] = loc_cMetodosForm
        THIS.this_aMetodos[THIS.this_nMetodos, 11] = loc_cControles
        THIS.this_aMetodos[THIS.this_nMetodos, 12] = loc_lRetornaFalso
    ENDPROC

    *====================================================================
    * DeterminarEvento - Determina tipo de evento a partir do nome
    *====================================================================
    PROTECTED PROCEDURE DeterminarEvento(par_cNome, par_cObjeto)
        LOCAL loc_cNomeUpper
        loc_cNomeUpper = UPPER(par_cNome)

        *-- Eventos conhecidos (pelo nome do metodo)
        DO CASE
        CASE ATC("VALID", loc_cNomeUpper) > 0 OR ;
             ATC(".VALID", UPPER(par_cObjeto + "." + par_cNome)) > 0
            RETURN "Valid"

        CASE ATC("CLICK", loc_cNomeUpper) > 0
            RETURN "Click"

        CASE ATC("DBLCLICK", loc_cNomeUpper) > 0
            RETURN "DblClick"

        CASE ATC("INIT", loc_cNomeUpper) > 0 AND loc_cNomeUpper = "INIT"
            RETURN "Init"

        CASE ATC("DESTROY", loc_cNomeUpper) > 0
            RETURN "Destroy"

        CASE ATC("GOTFOCUS", loc_cNomeUpper) > 0
            RETURN "GotFocus"

        CASE ATC("LOSTFOCUS", loc_cNomeUpper) > 0
            RETURN "LostFocus"

        CASE ATC("KEYPRESS", loc_cNomeUpper) > 0
            RETURN "KeyPress"

        CASE ATC("WHEN", loc_cNomeUpper) > 0 AND loc_cNomeUpper = "WHEN"
            RETURN "When"

        CASE ATC("INTERACTIVECHANGE", loc_cNomeUpper) > 0
            RETURN "InteractiveChange"

        CASE ATC("REFRESH", loc_cNomeUpper) > 0 AND loc_cNomeUpper = "REFRESH"
            RETURN "Refresh"

        CASE ATC("ACTIVATE", loc_cNomeUpper) > 0
            RETURN "Activate"

        OTHERWISE
            RETURN "Procedure"
        ENDCASE
    ENDPROC

    *====================================================================
    * ExtrairFuncoesExternas - Extrai chamadas a funcoes externas
    *====================================================================
    PROTECTED PROCEDURE ExtrairFuncoesExternas(par_cCorpo)
        LOCAL loc_cResultado, loc_nI, loc_cLinha, loc_cLinhaUpper
        LOCAL loc_nJ, loc_nPos, loc_cChar, loc_cFuncao, loc_nStart, loc_nEnd2
        LOCAL ARRAY loc_aLinhasCorpo[1]
        LOCAL loc_nLinhasCorpo

        loc_cResultado = ""
        loc_nLinhasCorpo = ALINES(loc_aLinhasCorpo, par_cCorpo)

        *-- Lista de funcoes externas conhecidas do framework legado
        LOCAL ARRAY loc_aFuncoes[20]
        loc_aFuncoes[1] = "fAcessoContab"
        loc_aFuncoes[2] = "fAcessoContas"
        loc_aFuncoes[3] = "fAcessoEmpresa"
        loc_aFuncoes[4] = "fChecaAcesso"
        loc_aFuncoes[5] = "fwBuscaExt"
        loc_aFuncoes[6] = "fwBuscaInt"
        loc_aFuncoes[7] = "fwBuscaSel"
        loc_aFuncoes[8] = "fVerificaPasta"
        loc_aFuncoes[9] = "fDtoSQL"
        loc_aFuncoes[10] = "MontaGrade"
        loc_aFuncoes[11] = "VfpxTab"
        loc_aFuncoes[12] = "MontaWhere"
        loc_aFuncoes[13] = "AplicaFiltro"
        loc_aFuncoes[14] = "Ordena"
        loc_aFuncoes[15] = "fBarraAcesso"
        loc_aFuncoes[16] = "mGerar_Pdf"
        loc_aFuncoes[17] = "mGerar_eMail"
        loc_aFuncoes[18] = "fGetCdMoeda"
        loc_aFuncoes[19] = "fGetCdEmpresa"
        loc_aFuncoes[20] = "fAcessoMoedas"

        FOR loc_nJ = 1 TO 20
            IF ATC(loc_aFuncoes[loc_nJ], par_cCorpo) > 0
                IF !EMPTY(loc_cResultado)
                    loc_cResultado = loc_cResultado + ","
                ENDIF
                loc_cResultado = loc_cResultado + loc_aFuncoes[loc_nJ]
            ENDIF
        ENDFOR

        *-- Detectar chamadas genericas de funcao: f[A-Z]xxx(
        *-- Pattern: palavras que comecam com "f" seguido de maiuscula e "("
        FOR loc_nI = 1 TO loc_nLinhasCorpo
            loc_cLinha = ALLTRIM(loc_aLinhasCorpo[loc_nI])
            IF LEFT(loc_cLinha, 1) = "*" OR LEFT(loc_cLinha, 2) = CHR(38) + CHR(38)
                LOOP
            ENDIF

            *-- Buscar funcoes com padrao fXxxXxx(
            loc_nPos = ATC("=F", UPPER(loc_cLinha))
            IF loc_nPos = 0
                loc_nPos = ATC(" F", UPPER(loc_cLinha))
            ENDIF
            IF loc_nPos = 0
                loc_nPos = ATC("(F", UPPER(loc_cLinha))
            ENDIF

            IF loc_nPos > 0
                *-- Extrair nome da funcao
                loc_nStart = loc_nPos + 1
                loc_nEnd2 = AT("(", loc_cLinha, 1)
                IF loc_nEnd2 > loc_nStart AND loc_nEnd2 - loc_nStart < 30
                    loc_cFuncao = SUBSTR(loc_cLinha, loc_nStart, loc_nEnd2 - loc_nStart)
                    loc_cFuncao = ALLTRIM(loc_cFuncao)
                    *-- Verificar se parece funcao externa (comeca com f)
                    IF LEFT(LOWER(loc_cFuncao), 1) = "f" AND LEN(loc_cFuncao) > 2
                        IF ATC(loc_cFuncao, loc_cResultado) = 0
                            IF !EMPTY(loc_cResultado)
                                loc_cResultado = loc_cResultado + ","
                            ENDIF
                            loc_cResultado = loc_cResultado + loc_cFuncao
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR

        RETURN loc_cResultado
    ENDPROC

    *====================================================================
    * ExtrairMetodosForm - Extrai metodos do ThisForm chamados
    *====================================================================
    PROTECTED PROCEDURE ExtrairMetodosForm(par_cCorpo)
        LOCAL loc_cResultado, loc_nI, loc_cLinha, loc_nPos
        LOCAL loc_cResto, loc_nParen, loc_cMetodo, loc_nUltPonto
        LOCAL ARRAY loc_aLinhasCorpo[1]
        LOCAL loc_nLinhasCorpo

        loc_cResultado = ""
        loc_nLinhasCorpo = ALINES(loc_aLinhasCorpo, par_cCorpo)

        FOR loc_nI = 1 TO loc_nLinhasCorpo
            loc_cLinha = ALLTRIM(loc_aLinhasCorpo[loc_nI])
            IF LEFT(loc_cLinha, 1) = "*" OR LEFT(loc_cLinha, 2) = CHR(38) + CHR(38)
                LOOP
            ENDIF

            *-- Buscar ThisForm.Metodo(
            loc_nPos = ATC("THISFORM.", loc_cLinha)
            IF loc_nPos > 0
                loc_cResto = SUBSTR(loc_cLinha, loc_nPos + 9)
                loc_nParen = AT("(", loc_cResto)
                IF loc_nParen > 0 AND loc_nParen < 40
                    loc_cMetodo = LEFT(loc_cResto, loc_nParen - 1)
                    *-- Remover subpropriedades (pegar apenas ultimo segmento)
                    IF AT(".", loc_cMetodo) > 0
                        loc_nUltPonto = RAT(".", loc_cMetodo)
                        loc_cMetodo = SUBSTR(loc_cMetodo, loc_nUltPonto + 1)
                    ENDIF
                    loc_cMetodo = ALLTRIM(loc_cMetodo)

                    IF !EMPTY(loc_cMetodo) AND ATC(loc_cMetodo, loc_cResultado) = 0
                        IF !EMPTY(loc_cResultado)
                            loc_cResultado = loc_cResultado + ","
                        ENDIF
                        loc_cResultado = loc_cResultado + loc_cMetodo
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR

        RETURN loc_cResultado
    ENDPROC

    *====================================================================
    * ExtrairControlesReferenciados - Extrai controles do form referenciados
    *====================================================================
    PROTECTED PROCEDURE ExtrairControlesReferenciados(par_cCorpo)
        LOCAL loc_cResultado, loc_nI, loc_cLinha, loc_cLinhaUpper
        LOCAL loc_nJ, loc_nPosCtrl, loc_cResto2, loc_cCtrl, loc_nFimCtrl, loc_cChar2
        LOCAL ARRAY loc_aLinhasCorpo[1]
        LOCAL loc_nLinhasCorpo

        *-- Prefixos de controles conhecidos
        LOCAL ARRAY loc_aPrefixos[8]
        loc_aPrefixos[1] = "GET_"
        loc_aPrefixos[2] = "GRD_"
        loc_aPrefixos[3] = "TXT_"
        loc_aPrefixos[4] = "EDT_"
        loc_aPrefixos[5] = "CMD_"
        loc_aPrefixos[6] = "OPT"
        loc_aPrefixos[7] = "CHK"
        loc_aPrefixos[8] = "CMB_"

        loc_cResultado = ""
        loc_nLinhasCorpo = ALINES(loc_aLinhasCorpo, par_cCorpo)

        FOR loc_nI = 1 TO loc_nLinhasCorpo
            loc_cLinha = ALLTRIM(loc_aLinhasCorpo[loc_nI])
            IF EMPTY(loc_cLinha) OR LEFT(loc_cLinha, 1) = "*" OR LEFT(loc_cLinha, 2) = CHR(38) + CHR(38)
                LOOP
            ENDIF

            loc_cLinhaUpper = UPPER(loc_cLinha)

            FOR loc_nJ = 1 TO 8
                loc_nPosCtrl = ATC(loc_aPrefixos[loc_nJ], loc_cLinhaUpper)
                DO WHILE loc_nPosCtrl > 0
                    *-- Extrair nome do controle
                    loc_cResto2 = SUBSTR(loc_cLinha, loc_nPosCtrl)
                    loc_nFimCtrl = 1
                    DO WHILE loc_nFimCtrl <= LEN(loc_cResto2)
                        loc_cChar2 = SUBSTR(loc_cResto2, loc_nFimCtrl, 1)
                        IF INLIST(loc_cChar2, ".", " ", ")", "=", CHR(13), CHR(10), ",")
                            EXIT
                        ENDIF
                        loc_nFimCtrl = loc_nFimCtrl + 1
                    ENDDO
                    loc_cCtrl = ALLTRIM(LEFT(loc_cResto2, loc_nFimCtrl - 1))

                    IF !EMPTY(loc_cCtrl) AND LEN(loc_cCtrl) > 3 AND ;
                       ATC(loc_cCtrl, loc_cResultado) = 0
                        IF !EMPTY(loc_cResultado)
                            loc_cResultado = loc_cResultado + ","
                        ENDIF
                        loc_cResultado = loc_cResultado + loc_cCtrl
                    ENDIF

                    *-- Buscar proxima ocorrencia a partir da posicao atual
                    LOCAL loc_nOffset
                    loc_nOffset = loc_nPosCtrl + LEN(loc_aPrefixos[loc_nJ])
                    IF loc_nOffset <= LEN(loc_cLinhaUpper)
                        loc_nPosCtrl = ATC(loc_aPrefixos[loc_nJ], SUBSTR(loc_cLinhaUpper, loc_nOffset))
                        IF loc_nPosCtrl > 0
                            loc_nPosCtrl = loc_nPosCtrl + loc_nOffset - 1
                        ENDIF
                    ELSE
                        loc_nPosCtrl = 0
                    ENDIF
                ENDDO
            ENDFOR
        ENDFOR

        RETURN loc_cResultado
    ENDPROC

    *====================================================================
    * ExtrairQueries - Extrai queries SQL dos metodos
    *====================================================================
    PROTECTED PROCEDURE ExtrairQueries()
        LOCAL loc_nI

        FOR loc_nI = 1 TO THIS.this_nMetodos
            IF !THIS.this_aMetodos[loc_nI, 5]
                LOOP
            ENDIF

            *-- Metodo tem SQL - extrair queries
            LOCAL loc_cCorpo, loc_cObjeto, loc_cEvento
            loc_cCorpo = THIS.this_aMetodos[loc_nI, 4]
            loc_cObjeto = THIS.this_aMetodos[loc_nI, 1]
            loc_cEvento = THIS.this_aMetodos[loc_nI, 2]
            LOCAL loc_cNomeMetodo
            loc_cNomeMetodo = loc_cObjeto + "." + loc_cEvento

            *-- Buscar SELECT/INSERT/UPDATE/DELETE statements
            THIS.ExtrairQueryDeCorpo(loc_cNomeMetodo, loc_cCorpo)
        ENDFOR

        ? "  Queries SQL extraidas: " + TRANSFORM(THIS.this_nQueries)
    ENDPROC

    *====================================================================
    * ExtrairQueryDeCorpo - Extrai queries SQL do corpo de um metodo
    *====================================================================
    PROTECTED PROCEDURE ExtrairQueryDeCorpo(par_cNomeMetodo, par_cCorpo)
        LOCAL loc_nI, loc_cLinha, loc_cLinhaUpper
        LOCAL loc_cQueryAccum, loc_lDentroQuery
        LOCAL ARRAY loc_aLinhasCorpo[1]
        LOCAL loc_nLinhasCorpo

        loc_nLinhasCorpo = ALINES(loc_aLinhasCorpo, par_cCorpo)
        loc_cQueryAccum = ""
        loc_lDentroQuery = .F.

        FOR loc_nI = 1 TO loc_nLinhasCorpo
            loc_cLinha = ALLTRIM(loc_aLinhasCorpo[loc_nI])
            loc_cLinhaUpper = UPPER(loc_cLinha)

            *-- Ignorar comentarios
            IF LEFT(loc_cLinha, 1) = "*" OR LEFT(loc_cLinha, 2) = CHR(38) + CHR(38)
                IF LEFT(loc_cLinha, 3) = "*!*"
                    LOOP
                ENDIF
                LOOP
            ENDIF

            *-- Detectar inicio de query SQL
            IF !loc_lDentroQuery
                IF ATC("SELECT ", loc_cLinhaUpper) > 0 OR ;
                   ATC("INSERT ", loc_cLinhaUpper) > 0 OR ;
                   ATC("UPDATE ", loc_cLinhaUpper) > 0 OR ;
                   ATC("DELETE ", loc_cLinhaUpper) > 0

                    *-- Verificar se eh SQL real (nao SELECT dentro de VFP)
                    *-- Ignorar "Select alias" sem FROM (VFP SELECT workarea)
                    IF ATC("SELECT ", loc_cLinhaUpper) > 0 AND ;
                       ATC("FROM ", loc_cLinhaUpper) = 0 AND ;
                       RIGHT(ALLTRIM(loc_cLinha), 1) # ";" AND ;
                       ATC("INTO", loc_cLinhaUpper) = 0 AND ;
                       ATC(",", loc_cLinha) = 0
                        LOOP
                    ENDIF

                    loc_cQueryAccum = loc_cLinha
                    *-- Se continua (termina com ; ou +])
                    IF RIGHT(ALLTRIM(loc_cLinha), 1) = ";" OR ;
                       RIGHT(ALLTRIM(loc_cLinha), 2) = "]+";
                       OR ATC("]+", loc_cLinha) > 0
                        loc_lDentroQuery = .T.
                    ELSE
                        *-- Query de uma linha - salvar
                        THIS.SalvarQuery(par_cNomeMetodo, loc_cQueryAccum)
                        loc_cQueryAccum = ""
                    ENDIF
                ENDIF
            ELSE
                *-- Continuacao de query multilinha
                loc_cQueryAccum = loc_cQueryAccum + " " + loc_cLinha

                *-- Detectar fim da query
                IF RIGHT(ALLTRIM(loc_cLinha), 1) # ";" AND ;
                   ATC("]+", loc_cLinha) = 0 AND ;
                   RIGHT(ALLTRIM(loc_cLinha), 2) # "+;"
                    THIS.SalvarQuery(par_cNomeMetodo, loc_cQueryAccum)
                    loc_cQueryAccum = ""
                    loc_lDentroQuery = .F.
                ENDIF

                *-- Limitar tamanho
                IF LEN(loc_cQueryAccum) > 2000
                    THIS.SalvarQuery(par_cNomeMetodo, loc_cQueryAccum)
                    loc_cQueryAccum = ""
                    loc_lDentroQuery = .F.
                ENDIF
            ENDIF
        ENDFOR

        *-- Salvar query pendente
        IF !EMPTY(loc_cQueryAccum)
            THIS.SalvarQuery(par_cNomeMetodo, loc_cQueryAccum)
        ENDIF
    ENDPROC

    *====================================================================
    * SalvarQuery - Analisa e salva uma query SQL
    *====================================================================
    PROTECTED PROCEDURE SalvarQuery(par_cNomeMetodo, par_cQuery)
        LOCAL loc_cTabelas, loc_cColunas

        *-- Extrair tabelas da query
        loc_cTabelas = THIS.ExtrairTabelasDeQuery(par_cQuery)

        *-- Extrair colunas da query
        loc_cColunas = THIS.ExtrairColunasDeQuery(par_cQuery)

        IF EMPTY(loc_cTabelas) AND EMPTY(loc_cColunas)
            RETURN
        ENDIF

        THIS.this_nQueries = THIS.this_nQueries + 1
        DIMENSION THIS.this_aQueries[THIS.this_nQueries, 5]
        THIS.this_aQueries[THIS.this_nQueries, 1] = par_cNomeMetodo
        *-- Truncar query
        IF LEN(par_cQuery) > 500
            THIS.this_aQueries[THIS.this_nQueries, 2] = LEFT(par_cQuery, 500)
        ELSE
            THIS.this_aQueries[THIS.this_nQueries, 2] = par_cQuery
        ENDIF
        THIS.this_aQueries[THIS.this_nQueries, 3] = loc_cTabelas
        THIS.this_aQueries[THIS.this_nQueries, 4] = loc_cColunas
        THIS.this_aQueries[THIS.this_nQueries, 5] = ""

        *-- Registrar tabelas usadas
        LOCAL loc_nJ
        LOCAL ARRAY loc_aTabArray[1]
        LOCAL loc_nTabCount
        loc_nTabCount = ALINES(loc_aTabArray, loc_cTabelas, 1, ",")
        FOR loc_nJ = 1 TO loc_nTabCount
            LOCAL loc_cTab
            loc_cTab = ALLTRIM(loc_aTabArray[loc_nJ])
            IF !EMPTY(loc_cTab)
                *-- Verificar se ja registrada
                LOCAL loc_lJaExiste, loc_nK
                loc_lJaExiste = .F.
                FOR loc_nK = 1 TO THIS.this_nTabelasUsadas
                    IF LOWER(THIS.this_aTabelasUsadas[loc_nK]) = LOWER(loc_cTab)
                        loc_lJaExiste = .T.
                        EXIT
                    ENDIF
                ENDFOR
                IF !loc_lJaExiste
                    THIS.this_nTabelasUsadas = THIS.this_nTabelasUsadas + 1
                    DIMENSION THIS.this_aTabelasUsadas[THIS.this_nTabelasUsadas]
                    THIS.this_aTabelasUsadas[THIS.this_nTabelasUsadas] = loc_cTab
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *====================================================================
    * ExtrairTabelasDeQuery - Extrai nomes de tabelas de uma query SQL
    *====================================================================
    PROTECTED PROCEDURE ExtrairTabelasDeQuery(par_cQuery)
        LOCAL loc_cQueryUpper, loc_cResultado
        LOCAL loc_nPos, loc_cResto, loc_cToken

        loc_cQueryUpper = UPPER(par_cQuery)
        loc_cResultado = ""

        *-- Pattern: FROM tabela / JOIN tabela / INTO tabela / UPDATE tabela
        LOCAL ARRAY loc_aKeywords[5]
        loc_aKeywords[1] = " FROM "
        loc_aKeywords[2] = " JOIN "
        loc_aKeywords[3] = " INTO "
        loc_aKeywords[4] = "UPDATE "
        loc_aKeywords[5] = "INSERT INTO "

        LOCAL loc_nJ
        FOR loc_nJ = 1 TO 5
            loc_nPos = ATC(loc_aKeywords[loc_nJ], loc_cQueryUpper)
            DO WHILE loc_nPos > 0
                loc_cResto = SUBSTR(par_cQuery, loc_nPos + LEN(loc_aKeywords[loc_nJ]))
                loc_cResto = LTRIM(loc_cResto)

                *-- Remover aspas/colchetes
                IF LEFT(loc_cResto, 1) = "[" OR LEFT(loc_cResto, 1) = "'"
                    loc_cResto = SUBSTR(loc_cResto, 2)
                ENDIF

                *-- Extrair nome da tabela (ate espaco, virgula, paren, WHERE, etc.)
                LOCAL loc_nFimTab
                loc_nFimTab = 1
                DO WHILE loc_nFimTab <= LEN(loc_cResto)
                    LOCAL loc_cCharTab
                    loc_cCharTab = SUBSTR(loc_cResto, loc_nFimTab, 1)
                    IF INLIST(loc_cCharTab, " ", ",", "(", ")", "]", "'", CHR(13), CHR(10), ";")
                        EXIT
                    ENDIF
                    loc_nFimTab = loc_nFimTab + 1
                ENDDO
                loc_cToken = LEFT(loc_cResto, loc_nFimTab - 1)
                loc_cToken = ALLTRIM(loc_cToken)

                *-- Filtrar: deve comecer com Sig ou ser tabela conhecida
                IF !EMPTY(loc_cToken) AND LEN(loc_cToken) > 2 AND ;
                   LEFT(loc_cToken, 1) # "?" AND LEFT(loc_cToken, 1) # "(" AND ;
                   !INLIST(UPPER(loc_cToken), "CURSOR", "TABLE", "SET", "WHERE", "BLANK", "PRINT", "MEMVAR")

                    *-- Remover alias (a., b.) - NAO usar LOOP (causa loop infinito se loc_nPos nao avanca)
                    IF AT(".", loc_cToken) = 0
                        IF ATC(loc_cToken, loc_cResultado) = 0
                            IF !EMPTY(loc_cResultado)
                                loc_cResultado = loc_cResultado + ","
                            ENDIF
                            loc_cResultado = loc_cResultado + loc_cToken
                        ENDIF
                    ENDIF
                ENDIF

                *-- Proxima ocorrencia
                LOCAL loc_nNextSearch
                loc_nNextSearch = loc_nPos + LEN(loc_aKeywords[loc_nJ])
                IF loc_nNextSearch < LEN(loc_cQueryUpper)
                    loc_nPos = ATC(loc_aKeywords[loc_nJ], SUBSTR(loc_cQueryUpper, loc_nNextSearch))
                    IF loc_nPos > 0
                        loc_nPos = loc_nPos + loc_nNextSearch - 1
                    ENDIF
                ELSE
                    loc_nPos = 0
                ENDIF
            ENDDO
        ENDFOR

        RETURN loc_cResultado
    ENDPROC

    *====================================================================
    * ExtrairColunasDeQuery - Extrai nomes de colunas de SELECT query
    *====================================================================
    PROTECTED PROCEDURE ExtrairColunasDeQuery(par_cQuery)
        LOCAL loc_cQueryUpper, loc_cResultado
        LOCAL loc_nSelectPos, loc_nFromPos, loc_cCampos

        loc_cQueryUpper = UPPER(par_cQuery)
        loc_cResultado = ""

        *-- Extrair campos entre SELECT e FROM
        loc_nSelectPos = ATC("SELECT ", loc_cQueryUpper)
        IF loc_nSelectPos = 0
            *-- Para UPDATE: extrair SET campo = valor
            IF ATC("UPDATE ", loc_cQueryUpper) > 0
                RETURN THIS.ExtrairColunasDeUpdate(par_cQuery)
            ENDIF
            *-- Para INSERT: extrair colunas
            IF ATC("INSERT ", loc_cQueryUpper) > 0
                RETURN THIS.ExtrairColunasDeInsert(par_cQuery)
            ENDIF
            RETURN ""
        ENDIF

        loc_nFromPos = ATC(" FROM ", loc_cQueryUpper)
        IF loc_nFromPos = 0
            loc_nFromPos = ATC(" INTO ", loc_cQueryUpper)
        ENDIF

        IF loc_nFromPos = 0
            RETURN ""
        ENDIF

        *-- Extrair parte dos campos
        loc_cCampos = SUBSTR(par_cQuery, loc_nSelectPos + 7, loc_nFromPos - loc_nSelectPos - 7)
        loc_cCampos = ALLTRIM(loc_cCampos)

        *-- Separar por virgula e extrair nomes de colunas
        LOCAL ARRAY loc_aCamposSplit[1]
        LOCAL loc_nCamposCount, loc_nI
        loc_nCamposCount = ALINES(loc_aCamposSplit, loc_cCampos, 1, ",")

        FOR loc_nI = 1 TO loc_nCamposCount
            LOCAL loc_cCampo
            loc_cCampo = ALLTRIM(loc_aCamposSplit[loc_nI])

            *-- Ignorar asterisco
            IF loc_cCampo = "*"
                LOOP
            ENDIF

            *-- Remover alias: a.campo -> campo
            IF AT(".", loc_cCampo) > 0
                loc_cCampo = SUBSTR(loc_cCampo, RAT(".", loc_cCampo) + 1)
            ENDIF

            *-- Remover AS alias
            LOCAL loc_nAs
            loc_nAs = ATC(" AS ", UPPER(loc_cCampo))
            IF loc_nAs > 0
                loc_cCampo = LEFT(loc_cCampo, loc_nAs - 1)
            ENDIF

            *-- Limpar
            loc_cCampo = ALLTRIM(loc_cCampo)
            loc_cCampo = STRTRAN(loc_cCampo, "[", "")
            loc_cCampo = STRTRAN(loc_cCampo, "]", "")
            loc_cCampo = STRTRAN(loc_cCampo, "'", "")

            *-- Filtrar: apenas nomes simples de colunas (sem funcoes, expressoes)
            IF !EMPTY(loc_cCampo) AND LEN(loc_cCampo) > 1 AND ;
               AT("(", loc_cCampo) = 0 AND ;
               AT(" ", loc_cCampo) = 0 AND ;
               AT("+", loc_cCampo) = 0 AND ;
               LEFT(loc_cCampo, 1) # "'" AND ;
               !INLIST(UPPER(loc_cCampo), "SPACE", "NULL", "TOP", "DISTINCT")

                IF ATC(loc_cCampo, loc_cResultado) = 0
                    IF !EMPTY(loc_cResultado)
                        loc_cResultado = loc_cResultado + ","
                    ENDIF
                    loc_cResultado = loc_cResultado + loc_cCampo
                ENDIF
            ENDIF
        ENDFOR

        *-- Tambem extrair colunas do WHERE
        LOCAL loc_cWhereCols
        loc_cWhereCols = THIS.ExtrairColunasDeWhere(par_cQuery)
        IF !EMPTY(loc_cWhereCols)
            LOCAL ARRAY loc_aWhereCols[1]
            LOCAL loc_nWC
            loc_nWC = ALINES(loc_aWhereCols, loc_cWhereCols, 1, ",")
            LOCAL loc_nW
            FOR loc_nW = 1 TO loc_nWC
                LOCAL loc_cWCol
                loc_cWCol = ALLTRIM(loc_aWhereCols[loc_nW])
                IF !EMPTY(loc_cWCol) AND ATC(loc_cWCol, loc_cResultado) = 0
                    IF !EMPTY(loc_cResultado)
                        loc_cResultado = loc_cResultado + ","
                    ENDIF
                    loc_cResultado = loc_cResultado + loc_cWCol
                ENDIF
            ENDFOR
        ENDIF

        RETURN loc_cResultado
    ENDPROC

    *====================================================================
    * ExtrairColunasDeWhere - Extrai colunas de clausula WHERE
    *====================================================================
    PROTECTED PROCEDURE ExtrairColunasDeWhere(par_cQuery)
        LOCAL loc_cQueryUpper, loc_nWherePos, loc_cWhere, loc_cResultado
        loc_cQueryUpper = UPPER(par_cQuery)
        loc_nWherePos = ATC(" WHERE ", loc_cQueryUpper)
        loc_cResultado = ""

        IF loc_nWherePos = 0
            RETURN ""
        ENDIF

        loc_cWhere = SUBSTR(par_cQuery, loc_nWherePos + 7)

        *-- Extrair tokens que parecem nomes de colunas (antes de = ou comparador)
        LOCAL ARRAY loc_aTokens[1]
        LOCAL loc_nTokenCount, loc_nI
        loc_cWhere = STRTRAN(loc_cWhere, " AND ", " ")
        loc_cWhere = STRTRAN(loc_cWhere, " OR ", " ")
        loc_cWhere = STRTRAN(loc_cWhere, "=", " ")
        loc_cWhere = STRTRAN(loc_cWhere, "<>", " ")
        loc_cWhere = STRTRAN(loc_cWhere, "#", " ")
        loc_nTokenCount = ALINES(loc_aTokens, loc_cWhere, 1, " ")

        FOR loc_nI = 1 TO loc_nTokenCount
            LOCAL loc_cToken
            loc_cToken = ALLTRIM(loc_aTokens[loc_nI])

            *-- Remover alias
            IF AT(".", loc_cToken) > 0
                loc_cToken = SUBSTR(loc_cToken, RAT(".", loc_cToken) + 1)
            ENDIF

            *-- Limpar
            loc_cToken = STRTRAN(loc_cToken, "'", "")
            loc_cToken = STRTRAN(loc_cToken, "(", "")
            loc_cToken = STRTRAN(loc_cToken, ")", "")
            loc_cToken = ALLTRIM(loc_cToken)

            *-- Filtrar: nome de coluna (letras/numeros, comeca com letra, > 2 chars)
            IF !EMPTY(loc_cToken) AND LEN(loc_cToken) > 2 AND ;
               ISALPHA(LEFT(loc_cToken, 1)) AND ;
               AT(" ", loc_cToken) = 0 AND ;
               !INLIST(UPPER(loc_cToken), "AND", "NOT", "NULL", "EMPTY", "ORDER", "BY", "ASC", "DESC", "GROUP", "LIKE", "BETWEEN", "INTO", "CURSOR")

                IF ATC(loc_cToken, loc_cResultado) = 0
                    IF !EMPTY(loc_cResultado)
                        loc_cResultado = loc_cResultado + ","
                    ENDIF
                    loc_cResultado = loc_cResultado + loc_cToken
                ENDIF
            ENDIF
        ENDFOR

        RETURN loc_cResultado
    ENDPROC

    *====================================================================
    * ExtrairColunasDeUpdate - Extrai colunas de UPDATE SET
    *====================================================================
    PROTECTED PROCEDURE ExtrairColunasDeUpdate(par_cQuery)
        LOCAL loc_cQueryUpper, loc_nSetPos, loc_nWherePos
        LOCAL loc_cSet, loc_cResultado
        loc_cQueryUpper = UPPER(par_cQuery)
        loc_cResultado = ""

        loc_nSetPos = ATC(" SET ", loc_cQueryUpper)
        IF loc_nSetPos = 0
            RETURN ""
        ENDIF

        loc_nWherePos = ATC(" WHERE ", loc_cQueryUpper)
        IF loc_nWherePos > 0
            loc_cSet = SUBSTR(par_cQuery, loc_nSetPos + 5, loc_nWherePos - loc_nSetPos - 5)
        ELSE
            loc_cSet = SUBSTR(par_cQuery, loc_nSetPos + 5)
        ENDIF

        *-- Separar por virgula e extrair campo antes do =
        LOCAL ARRAY loc_aParts[1]
        LOCAL loc_nParts, loc_nI
        loc_nParts = ALINES(loc_aParts, loc_cSet, 1, ",")

        FOR loc_nI = 1 TO loc_nParts
            LOCAL loc_cPart, loc_nEq
            loc_cPart = ALLTRIM(loc_aParts[loc_nI])
            loc_nEq = AT("=", loc_cPart)
            IF loc_nEq > 0
                LOCAL loc_cCol
                loc_cCol = ALLTRIM(LEFT(loc_cPart, loc_nEq - 1))
                loc_cCol = STRTRAN(loc_cCol, "[", "")
                loc_cCol = STRTRAN(loc_cCol, "]", "")
                IF !EMPTY(loc_cCol) AND ISALPHA(LEFT(loc_cCol, 1))
                    IF !EMPTY(loc_cResultado)
                        loc_cResultado = loc_cResultado + ","
                    ENDIF
                    loc_cResultado = loc_cResultado + loc_cCol
                ENDIF
            ENDIF
        ENDFOR

        RETURN loc_cResultado
    ENDPROC

    *====================================================================
    * ExtrairColunasDeInsert - Extrai colunas de INSERT INTO
    *====================================================================
    PROTECTED PROCEDURE ExtrairColunasDeInsert(par_cQuery)
        LOCAL loc_cQueryUpper, loc_nParen1, loc_nParen2
        LOCAL loc_cCols, loc_cResultado

        loc_cQueryUpper = UPPER(par_cQuery)
        loc_cResultado = ""

        *-- INSERT INTO tabela (col1, col2, ...) VALUES (...)
        loc_nParen1 = AT("(", par_cQuery)
        loc_nParen2 = AT(")", par_cQuery)

        IF loc_nParen1 = 0 OR loc_nParen2 = 0 OR loc_nParen2 <= loc_nParen1
            RETURN ""
        ENDIF

        loc_cCols = SUBSTR(par_cQuery, loc_nParen1 + 1, loc_nParen2 - loc_nParen1 - 1)

        LOCAL ARRAY loc_aColsSplit[1]
        LOCAL loc_nColsCount, loc_nI
        loc_nColsCount = ALINES(loc_aColsSplit, loc_cCols, 1, ",")

        FOR loc_nI = 1 TO loc_nColsCount
            LOCAL loc_cCol2
            loc_cCol2 = ALLTRIM(loc_aColsSplit[loc_nI])
            loc_cCol2 = STRTRAN(loc_cCol2, "[", "")
            loc_cCol2 = STRTRAN(loc_cCol2, "]", "")
            loc_cCol2 = STRTRAN(loc_cCol2, " ", "")

            IF !EMPTY(loc_cCol2) AND ISALPHA(LEFT(loc_cCol2, 1)) AND ;
               LEN(loc_cCol2) > 1
                IF !EMPTY(loc_cResultado)
                    loc_cResultado = loc_cResultado + ","
                ENDIF
                loc_cResultado = loc_cResultado + loc_cCol2
            ENDIF
        ENDFOR

        RETURN loc_cResultado
    ENDPROC

    *====================================================================
    * ValidarColunasContraSchema - Cruza colunas com schema.sql
    *====================================================================
    PROTECTED PROCEDURE ValidarColunasContraSchema()
        LOCAL loc_nI, loc_nJ

        FOR loc_nI = 1 TO THIS.this_nQueries
            LOCAL loc_cTabelas, loc_cColunas, loc_cNomeMetodo
            LOCAL loc_cColunasInvalidas
            loc_cTabelas = THIS.this_aQueries[loc_nI, 3]
            loc_cColunas = THIS.this_aQueries[loc_nI, 4]
            loc_cNomeMetodo = THIS.this_aQueries[loc_nI, 1]
            loc_cColunasInvalidas = ""

            IF EMPTY(loc_cTabelas) OR EMPTY(loc_cColunas)
                LOOP
            ENDIF

            *-- Para cada tabela na query
            LOCAL ARRAY loc_aTabArray2[1]
            LOCAL loc_nTabCount2
            loc_nTabCount2 = ALINES(loc_aTabArray2, loc_cTabelas, 1, ",")

            FOR loc_nJ = 1 TO loc_nTabCount2
                LOCAL loc_cTabela
                loc_cTabela = LOWER(ALLTRIM(loc_aTabArray2[loc_nJ]))

                *-- Encontrar no schema
                LOCAL loc_cSchemaColumns, loc_nK, loc_lEncontrada
                loc_cSchemaColumns = ""
                loc_lEncontrada = .F.
                FOR loc_nK = 1 TO THIS.this_nSchema
                    IF LOWER(THIS.this_aSchema[loc_nK, 1]) = loc_cTabela
                        loc_cSchemaColumns = THIS.this_aSchema[loc_nK, 2]
                        loc_lEncontrada = .T.
                        EXIT
                    ENDIF
                ENDFOR

                IF !loc_lEncontrada
                    LOOP
                ENDIF

                *-- Verificar cada coluna da query contra o schema
                LOCAL ARRAY loc_aColArray[1]
                LOCAL loc_nColCount
                loc_nColCount = ALINES(loc_aColArray, loc_cColunas, 1, ",")

                LOCAL loc_nL
                FOR loc_nL = 1 TO loc_nColCount
                    LOCAL loc_cColuna
                    loc_cColuna = LOWER(ALLTRIM(loc_aColArray[loc_nL]))

                    IF EMPTY(loc_cColuna)
                        LOOP
                    ENDIF

                    *-- Verificar se a coluna existe no schema da tabela
                    IF ATC(loc_cColuna, loc_cSchemaColumns) = 0
                        *-- Coluna nao encontrada no schema!
                        IF !EMPTY(loc_cColunasInvalidas)
                            loc_cColunasInvalidas = loc_cColunasInvalidas + ","
                        ENDIF
                        loc_cColunasInvalidas = loc_cColunasInvalidas + loc_cColuna

                        *-- Registrar no array global
                        THIS.this_nColunasInvalidas = THIS.this_nColunasInvalidas + 1
                        DIMENSION THIS.this_aColunasInvalidas[THIS.this_nColunasInvalidas, 3]
                        THIS.this_aColunasInvalidas[THIS.this_nColunasInvalidas, 1] = loc_cTabela
                        THIS.this_aColunasInvalidas[THIS.this_nColunasInvalidas, 2] = loc_cColuna
                        THIS.this_aColunasInvalidas[THIS.this_nColunasInvalidas, 3] = loc_cNomeMetodo
                    ENDIF
                ENDFOR
            ENDFOR

            *-- Salvar colunas invalidas na query
            THIS.this_aQueries[loc_nI, 5] = loc_cColunasInvalidas
        ENDFOR

        IF THIS.this_nColunasInvalidas > 0
            ? "  *** COLUNAS INVALIDAS DETECTADAS: " + TRANSFORM(THIS.this_nColunasInvalidas) + " ***"
            LOCAL loc_nM
            FOR loc_nM = 1 TO THIS.this_nColunasInvalidas
                ? "    - " + THIS.this_aColunasInvalidas[loc_nM, 1] + "." + ;
                  THIS.this_aColunasInvalidas[loc_nM, 2] + ;
                  " (em " + THIS.this_aColunasInvalidas[loc_nM, 3] + ")"
            ENDFOR
        ELSE
            ? "  Validacao de schema: OK (todas as colunas existem)"
        ENDIF
    ENDPROC

    *====================================================================
    * ExtrairColunaTipos - Extrai tipos BIT/DATETIME das tabelas usadas
    *====================================================================
    PROTECTED PROCEDURE ExtrairColunaTipos()
        LOCAL loc_nI, loc_nJ
        LOCAL loc_cTabela, loc_cColTipos

        FOR loc_nI = 1 TO THIS.this_nTabelasUsadas
            loc_cTabela = LOWER(THIS.this_aTabelasUsadas[loc_nI])

            *-- Encontrar tabela no schema
            loc_cColTipos = ""
            FOR loc_nJ = 1 TO THIS.this_nSchema
                IF LOWER(THIS.this_aSchema[loc_nJ, 1]) = loc_cTabela
                    loc_cColTipos = THIS.this_aSchema[loc_nJ, 3]
                    EXIT
                ENDIF
            ENDFOR

            IF EMPTY(loc_cColTipos)
                LOOP
            ENDIF

            *-- Parsear pares col:tipo e adicionar ao array
            LOCAL ARRAY loc_aPares[1]
            LOCAL loc_nPares, loc_nK
            loc_nPares = ALINES(loc_aPares, loc_cColTipos, 1, ",")

            FOR loc_nK = 1 TO loc_nPares
                LOCAL loc_cPar, loc_nSep, loc_cCol, loc_cTipo
                loc_cPar = ALLTRIM(loc_aPares[loc_nK])
                IF EMPTY(loc_cPar)
                    LOOP
                ENDIF
                loc_nSep = AT(":", loc_cPar)
                IF loc_nSep > 0
                    loc_cCol = LEFT(loc_cPar, loc_nSep - 1)
                    loc_cTipo = SUBSTR(loc_cPar, loc_nSep + 1)
                    THIS.this_nColunaTipos = THIS.this_nColunaTipos + 1
                    DIMENSION THIS.this_aColunaTipos[THIS.this_nColunaTipos, 3]
                    THIS.this_aColunaTipos[THIS.this_nColunaTipos, 1] = loc_cTabela
                    THIS.this_aColunaTipos[THIS.this_nColunaTipos, 2] = loc_cCol
                    THIS.this_aColunaTipos[THIS.this_nColunaTipos, 3] = loc_cTipo
                ENDIF
            ENDFOR
        ENDFOR

        IF THIS.this_nColunaTipos > 0
            ? "  Colunas BIT/DATETIME encontradas: " + TRANSFORM(THIS.this_nColunaTipos)
        ENDIF
    ENDPROC

    *====================================================================
    * ColetarFuncoesExternas - Coleta lista unica de funcoes externas
    *====================================================================
    PROTECTED PROCEDURE ColetarFuncoesExternas()
        LOCAL loc_nI

        FOR loc_nI = 1 TO THIS.this_nMetodos
            LOCAL loc_cFuncoes
            loc_cFuncoes = THIS.this_aMetodos[loc_nI, 9]
            IF EMPTY(loc_cFuncoes)
                LOOP
            ENDIF

            LOCAL ARRAY loc_aFuncs[1]
            LOCAL loc_nFuncCount, loc_nJ
            loc_nFuncCount = ALINES(loc_aFuncs, loc_cFuncoes, 1, ",")

            FOR loc_nJ = 1 TO loc_nFuncCount
                LOCAL loc_cFunc, loc_lJaExiste2, loc_nK2
                loc_cFunc = ALLTRIM(loc_aFuncs[loc_nJ])
                IF EMPTY(loc_cFunc)
                    LOOP
                ENDIF

                loc_lJaExiste2 = .F.
                FOR loc_nK2 = 1 TO THIS.this_nFuncoesExternas
                    IF LOWER(THIS.this_aFuncoesExternas[loc_nK2]) = LOWER(loc_cFunc)
                        loc_lJaExiste2 = .T.
                        EXIT
                    ENDIF
                ENDFOR

                IF !loc_lJaExiste2
                    THIS.this_nFuncoesExternas = THIS.this_nFuncoesExternas + 1
                    DIMENSION THIS.this_aFuncoesExternas[THIS.this_nFuncoesExternas]
                    THIS.this_aFuncoesExternas[THIS.this_nFuncoesExternas] = loc_cFunc
                ENDIF
            ENDFOR
        ENDFOR

        THIS.this_nTotalFuncoesExternas = THIS.this_nFuncoesExternas
    ENDPROC

    *====================================================================
    * GerarJSON - Gera o comportamento.json
    *====================================================================
    PROCEDURE GerarJSON()
        LOCAL loc_cJSON

        loc_cJSON = "{" + CHR(13) + CHR(10)

        *-- Resumo
        loc_cJSON = loc_cJSON + '  "resumo": {' + CHR(13) + CHR(10)
        loc_cJSON = loc_cJSON + '    "totalMetodos": ' + TRANSFORM(THIS.this_nMetodos) + "," + CHR(13) + CHR(10)
        loc_cJSON = loc_cJSON + '    "metodosComSQL": ' + TRANSFORM(THIS.ContarMetodosComSQL()) + "," + CHR(13) + CHR(10)
        loc_cJSON = loc_cJSON + '    "metodosComValidacao": ' + TRANSFORM(THIS.this_nTotalValidacoes) + "," + CHR(13) + CHR(10)
        loc_cJSON = loc_cJSON + '    "totalQueries": ' + TRANSFORM(THIS.this_nQueries) + "," + CHR(13) + CHR(10)
        loc_cJSON = loc_cJSON + '    "colunasInvalidas": ' + TRANSFORM(THIS.this_nColunasInvalidas) + "," + CHR(13) + CHR(10)

        *-- Funcoes externas no resumo
        loc_cJSON = loc_cJSON + '    "funcoesExternas": ['
        LOCAL loc_nI
        FOR loc_nI = 1 TO THIS.this_nFuncoesExternas
            IF loc_nI > 1
                loc_cJSON = loc_cJSON + ", "
            ENDIF
            loc_cJSON = loc_cJSON + '"' + THIS.EscaparJSONString(THIS.this_aFuncoesExternas[loc_nI]) + '"'
        ENDFOR
        loc_cJSON = loc_cJSON + "]" + CHR(13) + CHR(10)
        loc_cJSON = loc_cJSON + "  }," + CHR(13) + CHR(10)

        *-- Metodos
        loc_cJSON = loc_cJSON + '  "metodos": [' + CHR(13) + CHR(10)
        FOR loc_nI = 1 TO THIS.this_nMetodos
            IF loc_nI > 1
                loc_cJSON = loc_cJSON + "," + CHR(13) + CHR(10)
            ENDIF
            loc_cJSON = loc_cJSON + "    {" + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '      "objeto": "' + THIS.EscaparJSONString(THIS.this_aMetodos[loc_nI, 1]) + '",' + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '      "evento": "' + THIS.EscaparJSONString(THIS.this_aMetodos[loc_nI, 2]) + '",' + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '      "linhas": ' + TRANSFORM(THIS.this_aMetodos[loc_nI, 3]) + "," + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '      "codigoOriginal": "' + THIS.EscaparJSONString(THIS.this_aMetodos[loc_nI, 4]) + '",' + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '      "analise": {' + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '        "temSQL": ' + IIF(THIS.this_aMetodos[loc_nI, 5], "true", "false") + "," + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '        "temValidacao": ' + IIF(THIS.this_aMetodos[loc_nI, 6], "true", "false") + "," + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '        "temLookup": ' + IIF(THIS.this_aMetodos[loc_nI, 7], "true", "false") + "," + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '        "temNavegacao": ' + IIF(THIS.this_aMetodos[loc_nI, 8], "true", "false") + "," + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '        "funcoesExternas": "' + THIS.EscaparJSONString(THIS.this_aMetodos[loc_nI, 9]) + '",' + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '        "metodosFormChamados": "' + THIS.EscaparJSONString(THIS.this_aMetodos[loc_nI, 10]) + '",' + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '        "controlesReferenciados": "' + THIS.EscaparJSONString(THIS.this_aMetodos[loc_nI, 11]) + '",' + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '        "retornaFalso": ' + IIF(THIS.this_aMetodos[loc_nI, 12], "true", "false") + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + "      }" + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + "    }"
        ENDFOR
        loc_cJSON = loc_cJSON + CHR(13) + CHR(10) + "  ]," + CHR(13) + CHR(10)

        *-- SQL Queries
        loc_cJSON = loc_cJSON + '  "sqlQueries": [' + CHR(13) + CHR(10)
        FOR loc_nI = 1 TO THIS.this_nQueries
            IF loc_nI > 1
                loc_cJSON = loc_cJSON + "," + CHR(13) + CHR(10)
            ENDIF
            loc_cJSON = loc_cJSON + "    {" + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '      "metodo": "' + THIS.EscaparJSONString(THIS.this_aQueries[loc_nI, 1]) + '",' + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '      "queryOriginal": "' + THIS.EscaparJSONString(THIS.this_aQueries[loc_nI, 2]) + '",' + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '      "tabelas": "' + THIS.EscaparJSONString(THIS.this_aQueries[loc_nI, 3]) + '",' + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '      "colunas": "' + THIS.EscaparJSONString(THIS.this_aQueries[loc_nI, 4]) + '",' + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + '      "colunasInvalidas": "' + THIS.EscaparJSONString(THIS.this_aQueries[loc_nI, 5]) + '"' + CHR(13) + CHR(10)
            loc_cJSON = loc_cJSON + "    }"
        ENDFOR
        loc_cJSON = loc_cJSON + CHR(13) + CHR(10) + "  ]," + CHR(13) + CHR(10)

        *-- Validacao de Schema
        loc_cJSON = loc_cJSON + '  "validacaoSchema": {' + CHR(13) + CHR(10)

        *-- Tabelas usadas
        loc_cJSON = loc_cJSON + '    "tabelasUsadas": ['
        FOR loc_nI = 1 TO THIS.this_nTabelasUsadas
            IF loc_nI > 1
                loc_cJSON = loc_cJSON + ", "
            ENDIF
            loc_cJSON = loc_cJSON + '"' + THIS.EscaparJSONString(THIS.this_aTabelasUsadas[loc_nI]) + '"'
        ENDFOR
        loc_cJSON = loc_cJSON + "]," + CHR(13) + CHR(10)

        *-- Colunas verificadas
        loc_cJSON = loc_cJSON + '    "colunasVerificadas": ' + IIF(THIS.this_nSchema > 0, "true", "false") + "," + CHR(13) + CHR(10)

        *-- Colunas invalidas detalhadas
        loc_cJSON = loc_cJSON + '    "colunasInvalidas": ['
        IF THIS.this_nColunasInvalidas > 0
            loc_cJSON = loc_cJSON + CHR(13) + CHR(10)
            FOR loc_nI = 1 TO THIS.this_nColunasInvalidas
                IF loc_nI > 1
                    loc_cJSON = loc_cJSON + "," + CHR(13) + CHR(10)
                ENDIF
                loc_cJSON = loc_cJSON + '      {"tabela": "' + THIS.EscaparJSONString(THIS.this_aColunasInvalidas[loc_nI, 1]) + '"'
                loc_cJSON = loc_cJSON + ', "coluna": "' + THIS.EscaparJSONString(THIS.this_aColunasInvalidas[loc_nI, 2]) + '"'
                loc_cJSON = loc_cJSON + ', "metodo": "' + THIS.EscaparJSONString(THIS.this_aColunasInvalidas[loc_nI, 3]) + '"}'
            ENDFOR
            loc_cJSON = loc_cJSON + CHR(13) + CHR(10) + "    "
        ENDIF
        loc_cJSON = loc_cJSON + "]," + CHR(13) + CHR(10)

        *-- Avisos
        loc_cJSON = loc_cJSON + '    "avisos": []' + CHR(13) + CHR(10)
        loc_cJSON = loc_cJSON + "  }," + CHR(13) + CHR(10)

        *-- Coluna Tipos (BIT e DATETIME que causam bugs de migracao)
        loc_cJSON = loc_cJSON + '  "colunaTipos": {'
        IF THIS.this_nColunaTipos > 0
            loc_cJSON = loc_cJSON + CHR(13) + CHR(10)

            *-- Agrupar por tabela
            LOCAL loc_cTabelaAnterior, loc_lPrimeiraTabela, loc_lPrimeiraColuna
            loc_cTabelaAnterior = ""
            loc_lPrimeiraTabela = .T.

            FOR loc_nI = 1 TO THIS.this_nColunaTipos
                LOCAL loc_cTabelaAtual2
                loc_cTabelaAtual2 = THIS.this_aColunaTipos[loc_nI, 1]

                IF loc_cTabelaAtual2 # loc_cTabelaAnterior
                    *-- Fechar tabela anterior
                    IF !EMPTY(loc_cTabelaAnterior)
                        loc_cJSON = loc_cJSON + CHR(13) + CHR(10)
                        loc_cJSON = loc_cJSON + "    }," + CHR(13) + CHR(10)
                    ENDIF
                    *-- Abrir nova tabela
                    loc_cJSON = loc_cJSON + '    "' + THIS.EscaparJSONString(loc_cTabelaAtual2) + '": {' + CHR(13) + CHR(10)
                    loc_cTabelaAnterior = loc_cTabelaAtual2
                    loc_lPrimeiraColuna = .T.
                ENDIF

                IF !loc_lPrimeiraColuna
                    loc_cJSON = loc_cJSON + "," + CHR(13) + CHR(10)
                ENDIF
                loc_cJSON = loc_cJSON + '      "' + THIS.EscaparJSONString(THIS.this_aColunaTipos[loc_nI, 2]) + '": "'
                loc_cJSON = loc_cJSON + THIS.EscaparJSONString(THIS.this_aColunaTipos[loc_nI, 3]) + '"'
                loc_lPrimeiraColuna = .F.
            ENDFOR

            *-- Fechar ultima tabela
            IF !EMPTY(loc_cTabelaAnterior)
                loc_cJSON = loc_cJSON + CHR(13) + CHR(10)
                loc_cJSON = loc_cJSON + "    }" + CHR(13) + CHR(10)
            ENDIF
            loc_cJSON = loc_cJSON + "  }" + CHR(13) + CHR(10)
        ELSE
            loc_cJSON = loc_cJSON + "}" + CHR(13) + CHR(10)
        ENDIF

        loc_cJSON = loc_cJSON + "}" + CHR(13) + CHR(10)

        RETURN loc_cJSON
    ENDPROC

    *====================================================================
    * ContarMetodosComSQL - Conta metodos que contem SQL
    *====================================================================
    PROTECTED PROCEDURE ContarMetodosComSQL()
        LOCAL loc_nCount, loc_nI
        loc_nCount = 0
        FOR loc_nI = 1 TO THIS.this_nMetodos
            IF THIS.this_aMetodos[loc_nI, 5]
                loc_nCount = loc_nCount + 1
            ENDIF
        ENDFOR
        RETURN loc_nCount
    ENDPROC

    *====================================================================
    * EscaparJSONString - Escapa string para JSON
    *====================================================================
    PROTECTED PROCEDURE EscaparJSONString(par_cString)
        LOCAL loc_cResultado
        IF VARTYPE(par_cString) # "C"
            RETURN ""
        ENDIF

        loc_cResultado = par_cString
        loc_cResultado = STRTRAN(loc_cResultado, "\", "\\")
        loc_cResultado = STRTRAN(loc_cResultado, '"', '\"')
        loc_cResultado = STRTRAN(loc_cResultado, CHR(13), "\r")
        loc_cResultado = STRTRAN(loc_cResultado, CHR(10), "\n")
        loc_cResultado = STRTRAN(loc_cResultado, CHR(9), "\t")
        loc_cResultado = STRTRAN(loc_cResultado, CHR(0), "")

        RETURN loc_cResultado
    ENDPROC

ENDDEFINE
