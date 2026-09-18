*====================================================================
* AnalisadorTarefa.prg
*
* Script para analisar arquivo de codigo fonte extraido e gerar
* JSON estruturado com dados detalhados para alimentar o Claude.
*
* PARAMETROS:
*   par_cArquivoTXT - Caminho completo do .TXT com codigo fonte extraido
*                     Ex: 'C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt'
*
* RETORNO:
*   Gera arquivo analise.json no mesmo diretorio do .TXT
*
* EXEMPLOS:
*   VFP9.EXE AnalisadorTarefa('C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt')
*   DO AnalisadorTarefa WITH "C:\4c\tasks\task1\SIGCDCOR_form_codigo_fonte.txt"
*
* OUTPUT (analise.json):
*   {
*     "form": { "baseName": "SIGCDCOR", "formClass": "FormCor", "tabela": "SigCdCor" },
*     "campos": [...],
*     "lookups": [...],
*     "grid": {...},
*     "propriedadesVisuais": {...}
*   }
*====================================================================
LPARAMETERS par_cArquivoTXT

*-- Validacao de parametros
IF EMPTY(par_cArquivoTXT) OR VARTYPE(par_cArquivoTXT) # "C"
    ? "ERRO: Parametro par_cArquivoTXT nao fornecido ou invalido!"
    QUIT RETURN 1
ENDIF

IF !FILE(par_cArquivoTXT)
    ? "ERRO: Arquivo nao encontrado: " + par_cArquivoTXT
    QUIT RETURN 1
ENDIF

*-- Variaveis principais
LOCAL loc_cTaskDir, loc_cBaseName, loc_cFormClass, loc_cBOClass, loc_cEntidade
LOCAL loc_cJSON, loc_nHandle, loc_cArquivoJSON
LOCAL loc_oAnalise

*-- Determina diretorio e nomes
loc_cTaskDir = JUSTPATH(par_cArquivoTXT)
loc_cBaseName = JUSTSTEM(par_cArquivoTXT)
loc_cBaseName = STRTRAN(loc_cBaseName, "_form_codigo_fonte", "")
loc_cBaseName = STRTRAN(loc_cBaseName, "_codigo_fonte", "")

*-- Infere nomes de classes
IF LEFT(UPPER(loc_cBaseName), 5) = "SIGCD"
    loc_cEntidade = SUBSTR(loc_cBaseName, 6)
    loc_cFormClass = "Form" + loc_cEntidade
    loc_cBOClass = loc_cEntidade + "BO"
ELSE
    loc_cEntidade = loc_cBaseName
    loc_cFormClass = "Form" + loc_cBaseName
    loc_cBOClass = loc_cBaseName + "BO"
ENDIF

? "========================================================================"
? "AnalisadorTarefa - An" + CHR(225) + "lise Inteligente de Formul" + CHR(225) + "rio"
? "========================================================================"
? "Arquivo: " + par_cArquivoTXT
? "BaseName: " + loc_cBaseName
? "FormClass: " + loc_cFormClass
? "BOClass: " + loc_cBOClass
? "========================================================================"
? ""

*-- Cria objeto de analise
loc_oAnalise = CREATEOBJECT("AnalisadorFormulario")
loc_oAnalise.cBaseName = loc_cBaseName
loc_oAnalise.cFormClass = loc_cFormClass
loc_oAnalise.cBOClass = loc_cBOClass
loc_oAnalise.cEntidade = loc_cEntidade

*-- Executa analise
IF !loc_oAnalise.Analisar(par_cArquivoTXT)
    ? "ERRO: Falha ao analisar arquivo"
    QUIT RETURN 1
ENDIF

*-- Gera JSON
loc_cJSON = loc_oAnalise.GerarJSON()

*-- Salva JSON
loc_cArquivoJSON = ADDBS(loc_cTaskDir) + "analise.json"
loc_nHandle = FCREATE(loc_cArquivoJSON)

IF loc_nHandle < 0
    ? "ERRO: Nao foi possivel criar arquivo JSON: " + loc_cArquivoJSON
    QUIT RETURN 1
ENDIF

FWRITE(loc_nHandle, loc_cJSON)
FCLOSE(loc_nHandle)

? ""
? "===== ANALISE CONCLUIDA COM SUCESSO ====="
? "Arquivo JSON: " + loc_cArquivoJSON
? "Campos: " + ALLTRIM(STR(loc_oAnalise.nCampos))
? "Lookups: " + ALLTRIM(STR(loc_oAnalise.nLookups))
? "Grid: " + IIF(loc_oAnalise.lTemGrid, "Sim", "Nao")
? ""

QUIT RETURN 0

*====================================================================
* CLASSE: AnalisadorFormulario
* Analisa arquivo de codigo fonte e extrai dados estruturados
*====================================================================
DEFINE CLASS AnalisadorFormulario AS Custom

    *-- Informacoes basicas
    cBaseName = ""
    cFormClass = ""
    cBOClass = ""
    cEntidade = ""
    cFormType = "CRUD"      && Tipo do formulario: CRUD, REPORT ou OPERACIONAL
    cTabela = ""
    cCursorName = ""

    *-- Arrays de dados
    DIMENSION aCampos[1, 12]    && [n,1]=objeto, [n,2]=novoNome, [n,3]=colunaBD, [n,4]=tipo,
                                 && [n,5]=obrigatorio, [n,6]=inputMask, [n,7]=width, [n,8]=height,
                                 && [n,9]=top, [n,10]=left, [n,11]=caption, [n,12]=tabIndex
    nCampos = 0

    DIMENSION aLookups[1, 7]    && [n,1]=campo, [n,2]=tabela, [n,3]=campoCodigo, [n,4]=campoDescricao,
                                 && [n,5]=tecla, [n,6]=classe, [n,7]=evento
    nLookups = 0

    DIMENSION aLabels[1, 10]    && [n,1]=objeto, [n,2]=novoNome, [n,3]=caption, [n,4]=top, [n,5]=left,
                                 && [n,6]=fontName, [n,7]=fontSize, [n,8]=backColor, [n,9]=foreColor, [n,10]=width
    nLabels = 0

    *-- Grid
    lTemGrid = .F.
    nGridColunas = 0
    cGridWidth = ""
    cGridHeight = ""
    cGridTop = ""
    cGridLeft = ""
    DIMENSION aGridColunas[1, 4]  && [n,1]=header, [n,2]=controlSource, [n,3]=width, [n,4]=nome

    *-- Propriedades visuais do Form
    cFormWidth = ""
    cFormHeight = ""
    cFormCaption = ""
    cFormBackColor = ""
    cFormForeColor = ""
    cFormFontName = ""
    cFormFontSize = ""
    cPageFrameTop = ""
    cPageFrameLeft = ""

    *-- Conteudo do arquivo
    DIMENSION aLinhas[1]
    nLinhas = 0

    *====================================================================
    * Analisar - Metodo principal
    *====================================================================
    PROCEDURE Analisar(par_cArquivo)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- Carrega arquivo em memoria
        IF !THIS.CarregarArquivo(par_cArquivo)
            RETURN .F.
        ENDIF

        *-- Detecta tipo do formulario (CRUD ou REPORT)
        THIS.DetectarTipoFormulario()

        *-- Extrai informacoes
        THIS.ExtrairInformacoesForm()
        THIS.ExtrairCampos()
        THIS.ExtrairLookups()
        THIS.ExtrairGrid()
        THIS.ExtrairLabels()

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarArquivo - Carrega arquivo em array de linhas
    *====================================================================
    PROTECTED PROCEDURE CarregarArquivo(par_cArquivo)
        LOCAL loc_nHandle, loc_cConteudo

        loc_nHandle = FOPEN(par_cArquivo, 0)
        IF loc_nHandle < 0
            RETURN .F.
        ENDIF

        loc_cConteudo = FREAD(loc_nHandle, 1000000)  && Le ate 1MB
        FCLOSE(loc_nHandle)

        THIS.nLinhas = ALINES(THIS.aLinhas, loc_cConteudo)

        ? "  - " + ALLTRIM(STR(THIS.nLinhas)) + " linhas carregadas"

        RETURN .T.
    ENDPROC

    *====================================================================
    * DetectarTipoFormulario - Detecta CRUD ou REPORT a partir da Secao 1
    * Procura o objeto raiz (Parent=raiz, BaseClass=form) e le sua Class
    *====================================================================
    PROTECTED PROCEDURE DetectarTipoFormulario()
        LOCAL i, loc_cLinha
        LOCAL loc_lEmSecao1, loc_cClasseAtual, loc_lTemParentRaiz

        loc_lEmSecao1     = .F.
        loc_cClasseAtual  = ""
        loc_lTemParentRaiz = .F.

        FOR i = 1 TO THIS.nLinhas
            loc_cLinha = ALLTRIM(THIS.aLinhas[i])

            *-- Detecta inicio da secao 1
            IF "* SECAO 1:" $ UPPER(loc_cLinha)
                loc_lEmSecao1 = .T.
                LOOP
            ENDIF

            *-- Para na secao 2
            IF loc_lEmSecao1 AND "* SECAO 2:" $ UPPER(loc_cLinha)
                EXIT
            ENDIF

            IF loc_lEmSecao1
                *-- Inicio de novo objeto reseta estado
                IF UPPER(LEFT(loc_cLinha, 7)) = "OBJETO:"
                    loc_cClasseAtual  = ""
                    loc_lTemParentRaiz = .F.
                    LOOP
                ENDIF

                *-- Parent: (raiz) indica o objeto de nivel raiz
                IF UPPER(LEFT(loc_cLinha, 14)) = "PARENT: (RAIZ)"
                    loc_lTemParentRaiz = .T.
                    LOOP
                ENDIF

                *-- Captura a classe (frmrelatorio, frmcadastro, etc.)
                IF UPPER(LEFT(loc_cLinha, 7)) = "CLASS: "
                    loc_cClasseAtual = LOWER(ALLTRIM(SUBSTR(loc_cLinha, 8)))
                    LOOP
                ENDIF

                *-- BaseClass: form confirma que eh o formulario raiz
                IF UPPER(LEFT(loc_cLinha, 11)) = "BASECLASS: " AND ;
                   LOWER(ALLTRIM(SUBSTR(loc_cLinha, 12))) = "form" AND ;
                   loc_lTemParentRaiz
                        DO CASE
                    CASE loc_cClasseAtual = "frmrelatorio"
                        THIS.cFormType = "REPORT"
                        ? "  - TipoForm: REPORT (frmrelatorio)"
                    CASE loc_cClasseAtual = "form"
                        *-- Class: form (generico, sem herdar frmcadastro)
                        *-- Detecta OPERACIONAL pela AUSENCIA de botoes CRUD padrao
                        *-- Forms CRUD herdam de frmcadastro; forms operacionais usam Class: form diretamente
                        THIS.cFormType = "OPERACIONAL"
                        ? "  - TipoForm: OPERACIONAL (form generico, sem frmcadastro)"
                    OTHERWISE
                        THIS.cFormType = "CRUD"
                        ? "  - TipoForm: CRUD (" + loc_cClasseAtual + ")"
                    ENDCASE
                    EXIT
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *====================================================================
    * ExtrairInformacoesForm - Extrai propriedades do Form
    *====================================================================
    PROTECTED PROCEDURE ExtrairInformacoesForm()
        LOCAL i, loc_cLinha, loc_nPos
        LOCAL loc_lEmPropsForm

        loc_lEmPropsForm = .F.

        FOR i = 1 TO THIS.nLinhas
            loc_cLinha = ALLTRIM(THIS.aLinhas[i])

            *-- Detecta secao de propriedades do form
            IF "* PROPRIEDADES DE:" $ UPPER(loc_cLinha) AND THIS.cBaseName $ UPPER(loc_cLinha)
                *-- Verifica se eh o form principal (sem ponto apos basename)
                IF !("." $ STRTRAN(UPPER(loc_cLinha), UPPER(THIS.cBaseName), ""))
                    loc_lEmPropsForm = .T.
                    LOOP
                ENDIF
            ENDIF

            IF loc_lEmPropsForm
                *-- Linha vazia ou nova secao encerra
                IF EMPTY(loc_cLinha) OR LEFT(loc_cLinha, 4) = "----"
                    loc_lEmPropsForm = .F.
                    LOOP
                ENDIF

                *-- Extrai propriedades
                loc_nPos = AT(" = ", loc_cLinha)
                IF loc_nPos > 0
                    THIS.ProcessarPropriedadeForm(LEFT(loc_cLinha, loc_nPos - 1), ALLTRIM(SUBSTR(loc_cLinha, loc_nPos + 3)))
                ENDIF
            ENDIF

            *-- Detecta tabela do AddCursor
            IF "ADDCURSOR(" $ UPPER(loc_cLinha)
                THIS.ExtrairTabelaDoCursor(loc_cLinha)
            ENDIF
        ENDFOR

        ? "  - Form: Width=" + THIS.cFormWidth + ", Height=" + THIS.cFormHeight
        ? "  - Tabela: " + THIS.cTabela
    ENDPROC

    *====================================================================
    * ProcessarPropriedadeForm - Processa uma propriedade do form
    *====================================================================
    PROTECTED PROCEDURE ProcessarPropriedadeForm(par_cProp, par_cValor)
        LOCAL loc_cProp
        loc_cProp = UPPER(ALLTRIM(par_cProp))

        DO CASE
        CASE loc_cProp = "WIDTH"
            THIS.cFormWidth = par_cValor
        CASE loc_cProp = "HEIGHT"
            THIS.cFormHeight = par_cValor
        CASE loc_cProp = "CAPTION"
            THIS.cFormCaption = THIS.LimparString(par_cValor)
        CASE loc_cProp = "BACKCOLOR"
            THIS.cFormBackColor = par_cValor
        CASE loc_cProp = "FORECOLOR"
            THIS.cFormForeColor = par_cValor
        CASE loc_cProp = "FONTNAME"
            THIS.cFormFontName = THIS.LimparString(par_cValor)
        CASE loc_cProp = "FONTSIZE"
            THIS.cFormFontSize = par_cValor
        CASE "PAGINA.TOP" $ loc_cProp OR "PAGEFRAME.TOP" $ loc_cProp
            THIS.cPageFrameTop = par_cValor
        ENDCASE
    ENDPROC

    *====================================================================
    * ExtrairTabelaDoCursor - Extrai nome da tabela do AddCursor
    *====================================================================
    PROTECTED PROCEDURE ExtrairTabelaDoCursor(par_cLinha)
        LOCAL loc_nPos1, loc_nPos2, loc_cParams

        loc_nPos1 = AT("(", par_cLinha)
        loc_nPos2 = AT(")", par_cLinha)

        IF loc_nPos1 > 0 AND loc_nPos2 > loc_nPos1
            loc_cParams = SUBSTR(par_cLinha, loc_nPos1 + 1, loc_nPos2 - loc_nPos1 - 1)

            *-- Primeiro parametro eh o nome da tabela
            loc_nPos1 = AT(",", loc_cParams)
            IF loc_nPos1 > 0
                THIS.cTabela = THIS.LimparString(LEFT(loc_cParams, loc_nPos1 - 1))

                *-- Terceiro parametro eh o cursor
                loc_cParams = SUBSTR(loc_cParams, loc_nPos1 + 1)
                loc_nPos1 = AT(",", loc_cParams)
                IF loc_nPos1 > 0
                    loc_cParams = SUBSTR(loc_cParams, loc_nPos1 + 1)
                    loc_nPos1 = AT(",", loc_cParams)
                    IF loc_nPos1 > 0
                        THIS.cCursorName = THIS.LimparString(LEFT(loc_cParams, loc_nPos1 - 1))
                    ELSE
                        THIS.cCursorName = THIS.LimparString(loc_cParams)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *====================================================================
    * ExtrairCampos - Extrai campos (TextBox) do formulario
    *====================================================================
    PROTECTED PROCEDURE ExtrairCampos()
        LOCAL i, loc_cLinha, loc_cObjeto, loc_cParent
        LOCAL loc_lEmObjeto, loc_cTipo, loc_nPos
        LOCAL loc_cControlSource, loc_cInputMask, loc_cWidth, loc_cHeight
        LOCAL loc_cTop, loc_cLeft, loc_cTabIndex

        loc_lEmObjeto = .F.
        loc_cObjeto = ""

        FOR i = 1 TO THIS.nLinhas
            loc_cLinha = ALLTRIM(THIS.aLinhas[i])

            *-- Detecta inicio de secao de propriedades de um objeto
            IF "* PROPRIEDADES DE:" $ UPPER(loc_cLinha) AND ".DADOS." $ UPPER(loc_cLinha)
                *-- Extrai nome do objeto (formato: "* PROPRIEDADES DE: SIGCDCOR.Pagina.Dados.Getcods")
                loc_nPos = AT(":", loc_cLinha)
                IF loc_nPos > 0
                    loc_cObjeto = ALLTRIM(SUBSTR(loc_cLinha, loc_nPos + 1))

                    *-- Extrai apenas o nome do objeto (ultima parte)
                    loc_nPos = RAT(".", loc_cObjeto)
                    IF loc_nPos > 0
                        loc_cObjeto = SUBSTR(loc_cObjeto, loc_nPos + 1)
                    ENDIF

                    *-- Verifica se parece ser um campo (Get*, txt*, etc)
                    IF LEFT(UPPER(loc_cObjeto), 3) = "GET" OR ;
                       LEFT(UPPER(loc_cObjeto), 3) = "TXT" OR ;
                       LEFT(UPPER(loc_cObjeto), 3) = "EDT"

                        loc_lEmObjeto = .T.
                        loc_cControlSource = ""
                        loc_cInputMask = ""
                        loc_cWidth = ""
                        loc_cHeight = ""
                        loc_cTop = ""
                        loc_cLeft = ""
                        loc_cTabIndex = ""
                    ENDIF
                ENDIF
                LOOP
            ENDIF

            IF loc_lEmObjeto
                *-- Linha vazia ou nova secao encerra
                IF EMPTY(loc_cLinha) OR LEFT(loc_cLinha, 4) = "----"
                    *-- Salva campo se tiver ControlSource
                    IF !EMPTY(loc_cControlSource)
                        THIS.AdicionarCampo(loc_cObjeto, loc_cControlSource, loc_cInputMask, ;
                                           loc_cWidth, loc_cHeight, loc_cTop, loc_cLeft, loc_cTabIndex)
                    ENDIF
                    loc_lEmObjeto = .F.
                    LOOP
                ENDIF

                *-- Extrai propriedades
                loc_nPos = AT(" = ", loc_cLinha)
                IF loc_nPos > 0
                    LOCAL loc_cProp, loc_cValor
                    loc_cProp = UPPER(ALLTRIM(LEFT(loc_cLinha, loc_nPos - 1)))
                    loc_cValor = ALLTRIM(SUBSTR(loc_cLinha, loc_nPos + 3))

                    DO CASE
                    CASE loc_cProp = "CONTROLSOURCE"
                        loc_cControlSource = THIS.LimparString(loc_cValor)
                    CASE loc_cProp = "INPUTMASK"
                        loc_cInputMask = THIS.LimparString(loc_cValor)
                    CASE loc_cProp = "WIDTH"
                        loc_cWidth = loc_cValor
                    CASE loc_cProp = "HEIGHT"
                        loc_cHeight = loc_cValor
                    CASE loc_cProp = "TOP"
                        loc_cTop = loc_cValor
                    CASE loc_cProp = "LEFT"
                        loc_cLeft = loc_cValor
                    CASE loc_cProp = "TABINDEX"
                        loc_cTabIndex = loc_cValor
                    ENDCASE
                ENDIF
            ENDIF
        ENDFOR

        ? "  - " + ALLTRIM(STR(THIS.nCampos)) + " campos identificados"
    ENDPROC

    *====================================================================
    * AdicionarCampo - Adiciona campo ao array
    *====================================================================
    PROTECTED PROCEDURE AdicionarCampo(par_cObjeto, par_cControlSource, par_cInputMask, ;
                                       par_cWidth, par_cHeight, par_cTop, par_cLeft, par_cTabIndex)
        LOCAL loc_cNovoNome, loc_cColunaBD, loc_cTipo, loc_nPos

        THIS.nCampos = THIS.nCampos + 1
        IF THIS.nCampos > ALEN(THIS.aCampos, 1)
            DIMENSION THIS.aCampos[THIS.nCampos + 20, 12]
        ENDIF

        *-- Determina nome da coluna BD (parte apos o ponto no ControlSource)
        loc_nPos = AT(".", par_cControlSource)
        IF loc_nPos > 0
            loc_cColunaBD = SUBSTR(par_cControlSource, loc_nPos + 1)
        ELSE
            loc_cColunaBD = par_cControlSource
        ENDIF

        *-- Gera novo nome no padrao _4c_
        loc_cNovoNome = THIS.GerarNovoNomeCampo(par_cObjeto, loc_cColunaBD)

        *-- Infere tipo baseado em InputMask
        loc_cTipo = THIS.InferirTipo(par_cInputMask, loc_cColunaBD)

        THIS.aCampos[THIS.nCampos, 1] = par_cObjeto
        THIS.aCampos[THIS.nCampos, 2] = loc_cNovoNome
        THIS.aCampos[THIS.nCampos, 3] = loc_cColunaBD
        THIS.aCampos[THIS.nCampos, 4] = loc_cTipo
        THIS.aCampos[THIS.nCampos, 5] = .T.  && Assume obrigatorio por padrao
        THIS.aCampos[THIS.nCampos, 6] = par_cInputMask
        THIS.aCampos[THIS.nCampos, 7] = par_cWidth
        THIS.aCampos[THIS.nCampos, 8] = par_cHeight
        THIS.aCampos[THIS.nCampos, 9] = par_cTop
        THIS.aCampos[THIS.nCampos, 10] = par_cLeft
        THIS.aCampos[THIS.nCampos, 11] = ""  && Caption do label associado
        THIS.aCampos[THIS.nCampos, 12] = par_cTabIndex
    ENDPROC

    *====================================================================
    * GerarNovoNomeCampo - Gera nome padronizado para campo
    *====================================================================
    PROTECTED PROCEDURE GerarNovoNomeCampo(par_cObjeto, par_cColunaBD)
        LOCAL loc_cNome

        *-- Remove prefixos comuns
        loc_cNome = par_cColunaBD

        *-- Capitaliza primeira letra
        IF LEN(loc_cNome) > 1
            loc_cNome = UPPER(LEFT(loc_cNome, 1)) + LOWER(SUBSTR(loc_cNome, 2))
        ENDIF

        RETURN "txt_4c_" + loc_cNome
    ENDPROC

    *====================================================================
    * InferirTipo - Infere tipo baseado em InputMask
    *====================================================================
    PROTECTED PROCEDURE InferirTipo(par_cInputMask, par_cColunaBD)
        LOCAL loc_cTipo

        loc_cTipo = "C"  && Default: Character

        IF !EMPTY(par_cInputMask)
            DO CASE
            CASE "9" $ par_cInputMask AND "." $ par_cInputMask
                loc_cTipo = "N"  && Numeric com decimais
            CASE "9" $ par_cInputMask
                loc_cTipo = "I"  && Integer
            CASE "!" $ par_cInputMask
                loc_cTipo = "C"  && Character uppercase
            CASE "D" $ UPPER(par_cInputMask)
                loc_cTipo = "D"  && Date
            ENDCASE
        ENDIF

        RETURN loc_cTipo
    ENDPROC

    *====================================================================
    * ExtrairLookups - Extrai lookups do codigo
    *====================================================================
    PROTECTED PROCEDURE ExtrairLookups()
        LOCAL i, loc_cLinha, loc_cObjeto, loc_cEvento
        LOCAL loc_lEmMetodo

        loc_lEmMetodo = .F.
        loc_cObjeto = ""
        loc_cEvento = ""

        FOR i = 1 TO THIS.nLinhas
            loc_cLinha = ALLTRIM(THIS.aLinhas[i])

            *-- Detecta inicio de metodo
            IF "* PROCEDURE" $ UPPER(loc_cLinha) OR "PROCEDURE " $ UPPER(loc_cLinha)
                *-- Verifica se eh evento Valid ou DblClick
                IF "VALID" $ UPPER(loc_cLinha) OR "DBLCLICK" $ UPPER(loc_cLinha) OR "GOTFOCUS" $ UPPER(loc_cLinha)
                    loc_lEmMetodo = .T.

                    *-- Extrai nome do objeto (antes do ponto)
                    loc_cObjeto = THIS.ExtrairNomeObjetoDoMetodo(loc_cLinha)
                    loc_cEvento = IIF("VALID" $ UPPER(loc_cLinha), "Valid", ;
                                  IIF("DBLCLICK" $ UPPER(loc_cLinha), "DblClick", "GotFocus"))
                ENDIF
                LOOP
            ENDIF

            IF loc_lEmMetodo
                *-- Detecta fim do metodo
                IF "ENDPROC" $ UPPER(loc_cLinha)
                    loc_lEmMetodo = .F.
                    LOOP
                ENDIF

                *-- Procura padroes de lookup
                THIS.DetectarLookup(loc_cLinha, loc_cObjeto, loc_cEvento)
            ENDIF
        ENDFOR

        ? "  - " + ALLTRIM(STR(THIS.nLookups)) + " lookups identificados"
    ENDPROC

    *====================================================================
    * ExtrairNomeObjetoDoMetodo - Extrai nome do objeto do cabecalho do metodo
    *====================================================================
    PROTECTED PROCEDURE ExtrairNomeObjetoDoMetodo(par_cLinha)
        LOCAL loc_cNome, loc_nPos

        *-- Formato: "* PROCEDURE Pagina.Dados.getTanque.Valid" ou similar
        loc_nPos = AT(".", par_cLinha)
        IF loc_nPos > 0
            *-- Pega penultima parte (antes do evento)
            loc_cNome = par_cLinha
            loc_nPos = RAT(".", loc_cNome)
            IF loc_nPos > 0
                loc_cNome = LEFT(loc_cNome, loc_nPos - 1)
                loc_nPos = RAT(".", loc_cNome)
                IF loc_nPos > 0
                    loc_cNome = SUBSTR(loc_cNome, loc_nPos + 1)
                ENDIF
            ENDIF
        ELSE
            loc_cNome = ""
        ENDIF

        RETURN ALLTRIM(loc_cNome)
    ENDPROC

    *====================================================================
    * DetectarLookup - Detecta padroes de lookup na linha
    *====================================================================
    PROTECTED PROCEDURE DetectarLookup(par_cLinha, par_cObjeto, par_cEvento)
        LOCAL loc_cLinha, loc_cTabela, loc_cCampoCod, loc_cCampoDesc, loc_cClasse

        loc_cLinha = UPPER(par_cLinha)

        *-- Padrao 1: fwbuscaext
        IF "FWBUSCAEXT" $ loc_cLinha
            loc_cClasse = "fwbuscaext"
            loc_cTabela = THIS.ExtrairParametroLookup(par_cLinha, 3)
            loc_cCampoCod = THIS.ExtrairParametroLookup(par_cLinha, 5)
            loc_cCampoDesc = ""

            THIS.AdicionarLookup(par_cObjeto, loc_cTabela, loc_cCampoCod, loc_cCampoDesc, "F4", loc_cClasse, par_cEvento)
            RETURN
        ENDIF

        *-- Padrao 2: fwBuscaSel
        IF "FWBUSCASEL" $ loc_cLinha
            loc_cClasse = "fwBuscaSel"
            loc_cTabela = THIS.ExtrairParametroLookup(par_cLinha, 2)
            loc_cCampoCod = ""
            loc_cCampoDesc = ""

            THIS.AdicionarLookup(par_cObjeto, loc_cTabela, loc_cCampoCod, loc_cCampoDesc, "F4", loc_cClasse, par_cEvento)
            RETURN
        ENDIF

        *-- Padrao 3: sigacess
        IF "SIGACESS" $ loc_cLinha
            loc_cClasse = "sigacess"
            loc_cTabela = THIS.ExtrairParametroLookup(par_cLinha, 1)
            loc_cCampoCod = ""
            loc_cCampoDesc = ""

            THIS.AdicionarLookup(par_cObjeto, loc_cTabela, loc_cCampoCod, loc_cCampoDesc, "F4", loc_cClasse, par_cEvento)
            RETURN
        ENDIF
    ENDPROC

    *====================================================================
    * ExtrairParametroLookup - Extrai parametro de chamada de funcao
    *====================================================================
    PROTECTED PROCEDURE ExtrairParametroLookup(par_cLinha, par_nPosicao)
        LOCAL loc_nPos1, loc_nPos2, loc_cParams, i
        LOCAL ARRAY loc_aParams[1]

        loc_nPos1 = AT("(", par_cLinha)
        loc_nPos2 = AT(")", par_cLinha)

        IF loc_nPos1 = 0 OR loc_nPos2 = 0
            RETURN ""
        ENDIF

        loc_cParams = SUBSTR(par_cLinha, loc_nPos1 + 1, loc_nPos2 - loc_nPos1 - 1)

        *-- Separa por virgula
        ALINES(loc_aParams, loc_cParams, 1, ",")

        IF par_nPosicao <= ALEN(loc_aParams)
            RETURN THIS.LimparString(loc_aParams[par_nPosicao])
        ENDIF

        RETURN ""
    ENDPROC

    *====================================================================
    * AdicionarLookup - Adiciona lookup ao array
    *====================================================================
    PROTECTED PROCEDURE AdicionarLookup(par_cObjeto, par_cTabela, par_cCampoCod, par_cCampoDesc, par_cTecla, par_cClasse, par_cEvento)
        LOCAL loc_cCampoNovo, i

        *-- Verifica se ja existe
        FOR i = 1 TO THIS.nLookups
            IF UPPER(THIS.aLookups[i, 1]) == UPPER(par_cObjeto)
                RETURN  && Ja existe, nao duplica
            ENDIF
        ENDFOR

        THIS.nLookups = THIS.nLookups + 1
        IF THIS.nLookups > ALEN(THIS.aLookups, 1)
            DIMENSION THIS.aLookups[THIS.nLookups + 10, 7]
        ENDIF

        *-- Encontra nome novo do campo
        loc_cCampoNovo = THIS.EncontrarNomeNovoCampo(par_cObjeto)

        THIS.aLookups[THIS.nLookups, 1] = loc_cCampoNovo
        THIS.aLookups[THIS.nLookups, 2] = par_cTabela
        THIS.aLookups[THIS.nLookups, 3] = par_cCampoCod
        THIS.aLookups[THIS.nLookups, 4] = par_cCampoDesc
        THIS.aLookups[THIS.nLookups, 5] = par_cTecla
        THIS.aLookups[THIS.nLookups, 6] = par_cClasse
        THIS.aLookups[THIS.nLookups, 7] = par_cEvento
    ENDPROC

    *====================================================================
    * EncontrarNomeNovoCampo - Encontra nome novo de um campo original
    *====================================================================
    PROTECTED PROCEDURE EncontrarNomeNovoCampo(par_cObjetoOriginal)
        LOCAL i

        FOR i = 1 TO THIS.nCampos
            IF UPPER(THIS.aCampos[i, 1]) == UPPER(par_cObjetoOriginal)
                RETURN THIS.aCampos[i, 2]
            ENDIF
        ENDFOR

        *-- Se nao encontrou, gera nome generico
        RETURN "txt_4c_" + par_cObjetoOriginal
    ENDPROC

    *====================================================================
    * ExtrairGrid - Extrai informacoes do Grid
    *====================================================================
    PROTECTED PROCEDURE ExtrairGrid()
        LOCAL i, loc_cLinha, loc_nPos

        FOR i = 1 TO THIS.nLinhas
            loc_cLinha = ALLTRIM(THIS.aLinhas[i])

            *-- Detecta propriedades do Grid
            IF "GRADE." $ UPPER(loc_cLinha) OR "GRID." $ UPPER(loc_cLinha)
                THIS.lTemGrid = .T.

                loc_nPos = AT(" = ", loc_cLinha)
                IF loc_nPos > 0
                    LOCAL loc_cProp, loc_cValor
                    loc_cProp = UPPER(ALLTRIM(LEFT(loc_cLinha, loc_nPos - 1)))
                    loc_cValor = ALLTRIM(SUBSTR(loc_cLinha, loc_nPos + 3))

                    DO CASE
                    CASE "WIDTH" $ loc_cProp
                        THIS.cGridWidth = loc_cValor
                    CASE "HEIGHT" $ loc_cProp
                        THIS.cGridHeight = loc_cValor
                    CASE "TOP" $ loc_cProp
                        THIS.cGridTop = loc_cValor
                    CASE "LEFT" $ loc_cProp
                        THIS.cGridLeft = loc_cValor
                    ENDCASE
                ENDIF
            ENDIF

            *-- Detecta colunas do Grid no Init (pColuna)
            IF "PCOLUNA(" $ UPPER(loc_cLinha)
                THIS.ExtrairColunaGrid(loc_cLinha)
            ENDIF
        ENDFOR

        IF THIS.lTemGrid
            ? "  - Grid: " + ALLTRIM(STR(THIS.nGridColunas)) + " colunas"
        ENDIF
    ENDPROC

    *====================================================================
    * ExtrairColunaGrid - Extrai informacoes de uma coluna do Grid
    *====================================================================
    PROTECTED PROCEDURE ExtrairColunaGrid(par_cLinha)
        LOCAL loc_nPos1, loc_nPos2, loc_cParams
        LOCAL ARRAY loc_aParams[1]
        LOCAL loc_cNome, loc_cHeader, loc_cWidth

        loc_nPos1 = AT("(", par_cLinha)
        loc_nPos2 = AT(")", par_cLinha)

        IF loc_nPos1 = 0 OR loc_nPos2 = 0
            RETURN
        ENDIF

        loc_cParams = SUBSTR(par_cLinha, loc_nPos1 + 1, loc_nPos2 - loc_nPos1 - 1)
        ALINES(loc_aParams, loc_cParams, 1, ",")

        IF ALEN(loc_aParams) >= 4
            THIS.nGridColunas = THIS.nGridColunas + 1
            IF THIS.nGridColunas > ALEN(THIS.aGridColunas, 1)
                DIMENSION THIS.aGridColunas[THIS.nGridColunas + 10, 4]
            ENDIF

            THIS.aGridColunas[THIS.nGridColunas, 1] = THIS.LimparString(loc_aParams[4])  && Header
            THIS.aGridColunas[THIS.nGridColunas, 2] = THIS.LimparString(loc_aParams[1])  && ControlSource
            THIS.aGridColunas[THIS.nGridColunas, 3] = IIF(ALEN(loc_aParams) >= 5, THIS.LimparString(loc_aParams[5]), "100")  && Width
            THIS.aGridColunas[THIS.nGridColunas, 4] = "Column" + ALLTRIM(STR(THIS.nGridColunas))
        ENDIF
    ENDPROC

    *====================================================================
    * ExtrairLabels - Extrai informacoes dos Labels
    *====================================================================
    PROTECTED PROCEDURE ExtrairLabels()
        LOCAL i, loc_cLinha, loc_cObjeto
        LOCAL loc_lEmObjeto, loc_nPos
        LOCAL loc_cCaption, loc_cTop, loc_cLeft, loc_cFontName, loc_cFontSize
        LOCAL loc_cBackColor, loc_cForeColor, loc_cWidth

        loc_lEmObjeto = .F.

        FOR i = 1 TO THIS.nLinhas
            loc_cLinha = ALLTRIM(THIS.aLinhas[i])

            *-- Detecta inicio de secao de propriedades de um Label
            IF "* PROPRIEDADES DE:" $ UPPER(loc_cLinha) AND ".DADOS.SAY" $ UPPER(loc_cLinha)
                loc_nPos = AT(":", loc_cLinha)
                IF loc_nPos > 0
                    loc_cObjeto = ALLTRIM(SUBSTR(loc_cLinha, loc_nPos + 1))
                    loc_nPos = RAT(".", loc_cObjeto)
                    IF loc_nPos > 0
                        loc_cObjeto = SUBSTR(loc_cObjeto, loc_nPos + 1)
                    ENDIF

                    loc_lEmObjeto = .T.
                    loc_cCaption = ""
                    loc_cTop = ""
                    loc_cLeft = ""
                    loc_cFontName = ""
                    loc_cFontSize = ""
                    loc_cBackColor = ""
                    loc_cForeColor = ""
                    loc_cWidth = ""
                ENDIF
                LOOP
            ENDIF

            IF loc_lEmObjeto
                IF EMPTY(loc_cLinha) OR LEFT(loc_cLinha, 4) = "----"
                    *-- Salva label
                    IF !EMPTY(loc_cCaption)
                        THIS.AdicionarLabel(loc_cObjeto, loc_cCaption, loc_cTop, loc_cLeft, ;
                                           loc_cFontName, loc_cFontSize, loc_cBackColor, loc_cForeColor, loc_cWidth)
                    ENDIF
                    loc_lEmObjeto = .F.
                    LOOP
                ENDIF

                loc_nPos = AT(" = ", loc_cLinha)
                IF loc_nPos > 0
                    LOCAL loc_cProp, loc_cValor
                    loc_cProp = UPPER(ALLTRIM(LEFT(loc_cLinha, loc_nPos - 1)))
                    loc_cValor = ALLTRIM(SUBSTR(loc_cLinha, loc_nPos + 3))

                    DO CASE
                    CASE loc_cProp = "CAPTION"
                        loc_cCaption = THIS.LimparString(loc_cValor)
                    CASE loc_cProp = "TOP"
                        loc_cTop = loc_cValor
                    CASE loc_cProp = "LEFT"
                        loc_cLeft = loc_cValor
                    CASE loc_cProp = "WIDTH"
                        loc_cWidth = loc_cValor
                    CASE loc_cProp = "FONTNAME"
                        loc_cFontName = THIS.LimparString(loc_cValor)
                    CASE loc_cProp = "FONTSIZE"
                        loc_cFontSize = loc_cValor
                    CASE loc_cProp = "BACKCOLOR"
                        loc_cBackColor = loc_cValor
                    CASE loc_cProp = "FORECOLOR"
                        loc_cForeColor = loc_cValor
                    ENDCASE
                ENDIF
            ENDIF
        ENDFOR

        ? "  - " + ALLTRIM(STR(THIS.nLabels)) + " labels identificados"
    ENDPROC

    *====================================================================
    * AdicionarLabel - Adiciona label ao array
    *====================================================================
    PROTECTED PROCEDURE AdicionarLabel(par_cObjeto, par_cCaption, par_cTop, par_cLeft, ;
                                       par_cFontName, par_cFontSize, par_cBackColor, par_cForeColor, par_cWidth)
        LOCAL loc_cNovoNome

        THIS.nLabels = THIS.nLabels + 1
        IF THIS.nLabels > ALEN(THIS.aLabels, 1)
            DIMENSION THIS.aLabels[THIS.nLabels + 20, 10]
        ENDIF

        *-- Gera novo nome baseado no caption
        loc_cNovoNome = THIS.GerarNovoNomeLabel(par_cCaption)

        THIS.aLabels[THIS.nLabels, 1] = par_cObjeto
        THIS.aLabels[THIS.nLabels, 2] = loc_cNovoNome
        THIS.aLabels[THIS.nLabels, 3] = par_cCaption
        THIS.aLabels[THIS.nLabels, 4] = par_cTop
        THIS.aLabels[THIS.nLabels, 5] = par_cLeft
        THIS.aLabels[THIS.nLabels, 6] = IIF(EMPTY(par_cFontName), "Tahoma", par_cFontName)
        THIS.aLabels[THIS.nLabels, 7] = IIF(EMPTY(par_cFontSize), "8", par_cFontSize)
        THIS.aLabels[THIS.nLabels, 8] = par_cBackColor
        THIS.aLabels[THIS.nLabels, 9] = IIF(EMPTY(par_cForeColor), "90,90,90", par_cForeColor)
        THIS.aLabels[THIS.nLabels, 10] = par_cWidth
    ENDPROC

    *====================================================================
    * GerarNovoNomeLabel - Gera nome padronizado para label
    *====================================================================
    PROTECTED PROCEDURE GerarNovoNomeLabel(par_cCaption)
        LOCAL loc_cNome

        *-- Remove caracteres especiais e espacos
        loc_cNome = STRTRAN(par_cCaption, ":", "")
        loc_cNome = STRTRAN(loc_cNome, " ", "")
        loc_cNome = STRTRAN(loc_cNome, CHR(225), "a")  && á
        loc_cNome = STRTRAN(loc_cNome, CHR(227), "a")  && ã
        loc_cNome = STRTRAN(loc_cNome, CHR(231), "c")  && ç
        loc_cNome = STRTRAN(loc_cNome, CHR(233), "e")  && é
        loc_cNome = STRTRAN(loc_cNome, CHR(237), "i")  && í
        loc_cNome = STRTRAN(loc_cNome, CHR(243), "o")  && ó
        loc_cNome = STRTRAN(loc_cNome, CHR(250), "u")  && ú

        *-- Limita tamanho
        IF LEN(loc_cNome) > 20
            loc_cNome = LEFT(loc_cNome, 20)
        ENDIF

        RETURN "lbl_4c_" + loc_cNome
    ENDPROC

    *====================================================================
    * LimparString - Remove aspas e espacos de string
    *====================================================================
    PROTECTED PROCEDURE LimparString(par_cValor)
        LOCAL loc_cResultado

        loc_cResultado = ALLTRIM(par_cValor)
        loc_cResultado = STRTRAN(loc_cResultado, CHR(34), "")
        loc_cResultado = STRTRAN(loc_cResultado, "'", "")
        loc_cResultado = STRTRAN(loc_cResultado, "[", "")
        loc_cResultado = STRTRAN(loc_cResultado, "]", "")

        RETURN ALLTRIM(loc_cResultado)
    ENDPROC

    *====================================================================
    * GerarJSON - Gera JSON estruturado com todos os dados
    *====================================================================
    PROCEDURE GerarJSON()
        LOCAL loc_cJSON, i
        LOCAL loc_cCRLF

        loc_cCRLF = CHR(13) + CHR(10)

        *-- Inicia JSON
        loc_cJSON = "{" + loc_cCRLF

        *-- Secao: form
        loc_cJSON = loc_cJSON + '  "form": {' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "baseName": "' + THIS.cBaseName + '",' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "formClass": "' + THIS.cFormClass + '",' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "boClass": "' + THIS.cBOClass + '",' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "entidade": "' + THIS.cEntidade + '",' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "tabela": "' + THIS.cTabela + '",' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "cursorName": "' + THIS.cCursorName + '",' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "formType": "' + THIS.cFormType + '"' + loc_cCRLF
        loc_cJSON = loc_cJSON + '  },' + loc_cCRLF

        *-- Secao: propriedadesVisuais
        loc_cJSON = loc_cJSON + '  "propriedadesVisuais": {' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "Width": ' + IIF(EMPTY(THIS.cFormWidth), "1000", THIS.cFormWidth) + ',' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "Height": ' + IIF(EMPTY(THIS.cFormHeight), "600", THIS.cFormHeight) + ',' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "Caption": "' + THIS.EscaparJSON(THIS.cFormCaption) + '",' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "BackColor": "' + IIF(EMPTY(THIS.cFormBackColor), "RGB(100,100,100)", THIS.cFormBackColor) + '",' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "FontName": "' + IIF(EMPTY(THIS.cFormFontName), "Tahoma", THIS.cFormFontName) + '",' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "FontSize": ' + IIF(EMPTY(THIS.cFormFontSize), "8", THIS.cFormFontSize) + loc_cCRLF
        loc_cJSON = loc_cJSON + '  },' + loc_cCRLF

        *-- Secao: campos
        loc_cJSON = loc_cJSON + '  "campos": [' + loc_cCRLF
        FOR i = 1 TO THIS.nCampos
            loc_cJSON = loc_cJSON + '    {' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "objetoOriginal": "' + THIS.aCampos[i, 1] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "novoNome": "' + THIS.aCampos[i, 2] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "colunaBD": "' + THIS.aCampos[i, 3] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "tipo": "' + THIS.aCampos[i, 4] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "inputMask": "' + THIS.EscaparJSON(THIS.aCampos[i, 6]) + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "width": ' + IIF(EMPTY(THIS.aCampos[i, 7]), "100", THIS.aCampos[i, 7]) + ',' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "height": ' + IIF(EMPTY(THIS.aCampos[i, 8]), "24", THIS.aCampos[i, 8]) + ',' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "top": ' + IIF(EMPTY(THIS.aCampos[i, 9]), "0", THIS.aCampos[i, 9]) + ',' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "left": ' + IIF(EMPTY(THIS.aCampos[i, 10]), "0", THIS.aCampos[i, 10]) + ',' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "tabIndex": ' + IIF(EMPTY(THIS.aCampos[i, 12]), "0", THIS.aCampos[i, 12]) + loc_cCRLF
            loc_cJSON = loc_cJSON + '    }' + IIF(i < THIS.nCampos, ",", "") + loc_cCRLF
        ENDFOR
        loc_cJSON = loc_cJSON + '  ],' + loc_cCRLF

        *-- Secao: lookups
        loc_cJSON = loc_cJSON + '  "lookups": [' + loc_cCRLF
        FOR i = 1 TO THIS.nLookups
            loc_cJSON = loc_cJSON + '    {' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "campo": "' + THIS.aLookups[i, 1] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "tabela": "' + THIS.aLookups[i, 2] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "campoCodigo": "' + THIS.aLookups[i, 3] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "tecla": "' + THIS.aLookups[i, 5] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "classeOriginal": "' + THIS.aLookups[i, 6] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "evento": "' + THIS.aLookups[i, 7] + '"' + loc_cCRLF
            loc_cJSON = loc_cJSON + '    }' + IIF(i < THIS.nLookups, ",", "") + loc_cCRLF
        ENDFOR
        loc_cJSON = loc_cJSON + '  ],' + loc_cCRLF

        *-- Secao: labels
        loc_cJSON = loc_cJSON + '  "labels": [' + loc_cCRLF
        FOR i = 1 TO THIS.nLabels
            loc_cJSON = loc_cJSON + '    {' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "objetoOriginal": "' + THIS.aLabels[i, 1] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "novoNome": "' + THIS.aLabels[i, 2] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "caption": "' + THIS.EscaparJSON(THIS.aLabels[i, 3]) + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "top": ' + IIF(EMPTY(THIS.aLabels[i, 4]), "0", THIS.aLabels[i, 4]) + ',' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "left": ' + IIF(EMPTY(THIS.aLabels[i, 5]), "0", THIS.aLabels[i, 5]) + ',' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "fontName": "' + THIS.aLabels[i, 6] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "fontSize": ' + THIS.aLabels[i, 7] + ',' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "foreColor": "' + THIS.aLabels[i, 9] + '"' + loc_cCRLF
            loc_cJSON = loc_cJSON + '    }' + IIF(i < THIS.nLabels, ",", "") + loc_cCRLF
        ENDFOR
        loc_cJSON = loc_cJSON + '  ],' + loc_cCRLF

        *-- Secao: grid
        loc_cJSON = loc_cJSON + '  "grid": {' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "temGrid": ' + IIF(THIS.lTemGrid, "true", "false") + ',' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "width": ' + IIF(EMPTY(THIS.cGridWidth), "940", THIS.cGridWidth) + ',' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "height": ' + IIF(EMPTY(THIS.cGridHeight), "470", THIS.cGridHeight) + ',' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "top": ' + IIF(EMPTY(THIS.cGridTop), "121", THIS.cGridTop) + ',' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "left": ' + IIF(EMPTY(THIS.cGridLeft), "12", THIS.cGridLeft) + ',' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "colunas": [' + loc_cCRLF
        FOR i = 1 TO THIS.nGridColunas
            loc_cJSON = loc_cJSON + '      {' + loc_cCRLF
            loc_cJSON = loc_cJSON + '        "header": "' + THIS.EscaparJSON(THIS.aGridColunas[i, 1]) + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '        "controlSource": "' + THIS.aGridColunas[i, 2] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '        "width": ' + IIF(EMPTY(THIS.aGridColunas[i, 3]), "100", THIS.aGridColunas[i, 3]) + loc_cCRLF
            loc_cJSON = loc_cJSON + '      }' + IIF(i < THIS.nGridColunas, ",", "") + loc_cCRLF
        ENDFOR
        loc_cJSON = loc_cJSON + '    ]' + loc_cCRLF
        loc_cJSON = loc_cJSON + '  }' + loc_cCRLF

        *-- Fecha JSON
        loc_cJSON = loc_cJSON + '}' + loc_cCRLF

        RETURN loc_cJSON
    ENDPROC

    *====================================================================
    * EscaparJSON - Escapa caracteres especiais para JSON
    *====================================================================
    PROTECTED PROCEDURE EscaparJSON(par_cValor)
        LOCAL loc_cResultado

        IF VARTYPE(par_cValor) # "C"
            RETURN ""
        ENDIF

        loc_cResultado = par_cValor
        loc_cResultado = STRTRAN(loc_cResultado, '\', '\\')
        loc_cResultado = STRTRAN(loc_cResultado, '"', '\"')
        loc_cResultado = STRTRAN(loc_cResultado, CHR(13), '\r')
        loc_cResultado = STRTRAN(loc_cResultado, CHR(10), '\n')
        loc_cResultado = STRTRAN(loc_cResultado, CHR(9), '\t')

        RETURN loc_cResultado
    ENDPROC

ENDDEFINE
