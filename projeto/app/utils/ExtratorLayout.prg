*====================================================================
* ExtratorLayout.prg
*
* Le o SCX como tabela DBF e gera layout.json com posicoes exatas
* de todos os controles, agrupados por Page/Container.
*
* PARAMETROS:
*   par_cSCXFile - Caminho completo do .SCX
*   par_cTaskDir - Diretorio do task onde salvar o layout.json
*
* RETORNO:
*   Gera arquivo layout.json no diretorio do task
*====================================================================
PARAMETERS par_cSCXFile, par_cTaskDir

SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF


IF EMPTY(par_cSCXFile) OR VARTYPE(par_cSCXFile) # "C"
    RETURN .F.
ENDIF
IF EMPTY(par_cTaskDir) OR VARTYPE(par_cTaskDir) # "C"
    RETURN .F.
ENDIF

LOCAL loc_cOutputFile, loc_cJSON, loc_nObjCount
loc_cOutputFile = ADDBS(par_cTaskDir) + "layout.json"
loc_cJSON = ""
loc_nObjCount = 0

*-- Abrir o SCX como tabela DBF
LOCAL loc_cAlias
loc_cAlias = "scx_layout_" + SYS(2015)

IF !FILE(par_cSCXFile)
    RETURN .F.
ENDIF

USE (par_cSCXFile) ALIAS (loc_cAlias) IN 0 SHARED NOUPDATE

SELECT (loc_cAlias)
GO TOP

*-- Detectar nome do form (registro com BaseClass = "form")
LOCAL loc_cFormName, loc_cFormClass
loc_cFormName = ""
loc_cFormClass = ""

SCAN FOR ALLTRIM(LOWER(BaseClass)) = "form"
    loc_cFormName = ALLTRIM(ObjName)
    loc_cFormClass = ALLTRIM(Class)
ENDSCAN

IF EMPTY(loc_cFormName)
    USE IN (loc_cAlias)
    RETURN .F.
ENDIF

*-- Coletar propriedades do form
GO TOP

*-- Estrutura para JSON: arrays de objetos por page
LOCAL loc_cFormProps, loc_cPages, loc_cFormObjects
LOCAL loc_nFormWidth, loc_nFormHeight
loc_nFormWidth = 0
loc_nFormHeight = 0
loc_cPages = ""

*-- Primeiro, coletar dimensoes do form e propriedades de PageFrame
SCAN
    LOCAL loc_cObjName, loc_cParent, loc_cBase, loc_cProps
    loc_cObjName = ALLTRIM(ObjName)
    loc_cParent  = ALLTRIM(Parent)
    loc_cBase    = ALLTRIM(LOWER(BaseClass))
    loc_cProps   = Properties

    *-- Form dimensions
    IF loc_cBase = "form"
        loc_nFormWidth = VAL(ALLTRIM(ExtrairProp(loc_cProps, "Width")))
        loc_nFormHeight = VAL(ALLTRIM(ExtrairProp(loc_cProps, "Height")))
    ENDIF
ENDSCAN

*-- Agora coletar todos os objetos com posicoes
GO TOP
loc_cJSON = '{"form":{"name":' + QuotarJSON(loc_cFormName) + ;
            ',"class":' + QuotarJSON(loc_cFormClass) + ;
            ',"width":' + ALLTRIM(STR(loc_nFormWidth)) + ;
            ',"height":' + ALLTRIM(STR(loc_nFormHeight)) + '},' + CHR(13) + CHR(10)

loc_cJSON = loc_cJSON + ' "objects":['  + CHR(13) + CHR(10)

LOCAL loc_lFirst
loc_lFirst = .T.

SCAN
    loc_cObjName = ALLTRIM(ObjName)
    loc_cParent  = ALLTRIM(Parent)
    loc_cBase    = ALLTRIM(LOWER(BaseClass))
    loc_cProps   = Properties

    *-- Pular dataenvironment e o proprio form
    IF INLIST(loc_cBase, "dataenvironment", "cursor", "relation")
        LOOP
    ENDIF

    *-- Extrair propriedades de posicao
    LOCAL loc_cTop, loc_cLeft, loc_cWidth, loc_cHeight
    LOCAL loc_cCaption, loc_cVisible, loc_cClassName
    loc_cTop     = ExtrairProp(loc_cProps, "Top")
    loc_cLeft    = ExtrairProp(loc_cProps, "Left")
    loc_cWidth   = ExtrairProp(loc_cProps, "Width")
    loc_cHeight  = ExtrairProp(loc_cProps, "Height")
    loc_cCaption = ExtrairProp(loc_cProps, "Caption")
    loc_cVisible = ExtrairProp(loc_cProps, "Visible")
    loc_cClassName = ALLTRIM(Class)

    *-- Propriedades extras para controles especificos
    LOCAL loc_cExtra
    loc_cExtra = ""

    IF loc_cBase = "pageframe"
        LOCAL loc_cPageCount, loc_cTabs, loc_cActiveP
        loc_cPageCount = ExtrairProp(loc_cProps, "PageCount")
        loc_cTabs      = ExtrairProp(loc_cProps, "Tabs")
        IF !EMPTY(loc_cPageCount)
            loc_cExtra = loc_cExtra + ',"pageCount":' + ALLTRIM(loc_cPageCount)
        ENDIF
        IF !EMPTY(loc_cTabs)
            loc_cExtra = loc_cExtra + ',"tabs":' + IIF(LOWER(ALLTRIM(loc_cTabs)) = ".f.", "false", "true")
        ENDIF
    ENDIF

    IF loc_cBase = "grid"
        LOCAL loc_cColumnCount, loc_cGridLines, loc_cRecSrc
        loc_cColumnCount = ExtrairProp(loc_cProps, "ColumnCount")
        loc_cGridLines   = ExtrairProp(loc_cProps, "GridLines")
        loc_cRecSrc      = ExtrairProp(loc_cProps, "RecordSource")
        IF !EMPTY(loc_cColumnCount)
            loc_cExtra = loc_cExtra + ',"columnCount":' + ALLTRIM(loc_cColumnCount)
        ENDIF
        IF !EMPTY(loc_cGridLines)
            loc_cExtra = loc_cExtra + ',"gridLines":' + ALLTRIM(loc_cGridLines)
        ENDIF
    ENDIF

    IF INLIST(loc_cBase, "commandbutton", "commandgroup", "optiongroup")
        LOCAL loc_cBtnCount
        loc_cBtnCount = ExtrairProp(loc_cProps, "ButtonCount")
        IF !EMPTY(loc_cBtnCount)
            loc_cExtra = loc_cExtra + ',"buttonCount":' + ALLTRIM(loc_cBtnCount)
        ENDIF
    ENDIF

    IF loc_cBase = "checkbox"
        LOCAL loc_cValue
        loc_cValue = ExtrairProp(loc_cProps, "Value")
        IF !EMPTY(loc_cValue)
            loc_cExtra = loc_cExtra + ',"value":' + QuotarJSON(ALLTRIM(loc_cValue))
        ENDIF
    ENDIF

    *-- Montar entrada JSON
    IF !loc_lFirst
        loc_cJSON = loc_cJSON + ","  + CHR(13) + CHR(10)
    ENDIF
    loc_lFirst = .F.

    loc_cJSON = loc_cJSON + '  {"name":' + QuotarJSON(loc_cObjName)
    loc_cJSON = loc_cJSON + ',"parent":' + QuotarJSON(loc_cParent)
    loc_cJSON = loc_cJSON + ',"baseClass":' + QuotarJSON(loc_cBase)
    loc_cJSON = loc_cJSON + ',"class":' + QuotarJSON(loc_cClassName)

    IF !EMPTY(loc_cTop)
        loc_cJSON = loc_cJSON + ',"top":' + ALLTRIM(loc_cTop)
    ENDIF
    IF !EMPTY(loc_cLeft)
        loc_cJSON = loc_cJSON + ',"left":' + ALLTRIM(loc_cLeft)
    ENDIF
    IF !EMPTY(loc_cWidth)
        loc_cJSON = loc_cJSON + ',"width":' + ALLTRIM(loc_cWidth)
    ENDIF
    IF !EMPTY(loc_cHeight)
        loc_cJSON = loc_cJSON + ',"height":' + ALLTRIM(loc_cHeight)
    ENDIF
    IF !EMPTY(loc_cCaption)
        loc_cJSON = loc_cJSON + ',"caption":' + QuotarJSON(ALLTRIM(loc_cCaption))
    ENDIF
    IF !EMPTY(loc_cVisible)
        LOCAL loc_lVis
        loc_lVis = IIF(LOWER(ALLTRIM(loc_cVisible)) = ".f.", "false", "true")
        loc_cJSON = loc_cJSON + ',"visible":' + loc_lVis
    ENDIF

    loc_cJSON = loc_cJSON + loc_cExtra
    loc_cJSON = loc_cJSON + '}'

    loc_nObjCount = loc_nObjCount + 1
ENDSCAN

loc_cJSON = loc_cJSON + CHR(13) + CHR(10) + ' ],' + CHR(13) + CHR(10)
loc_cJSON = loc_cJSON + ' "totalObjects":' + ALLTRIM(STR(loc_nObjCount)) + CHR(13) + CHR(10)
loc_cJSON = loc_cJSON + '}'

*-- Fechar tabela
USE IN (loc_cAlias)

*-- Salvar JSON
STRTOFILE(loc_cJSON, loc_cOutputFile)

RETURN .T.


*====================================================================
* ExtrairProp - Extrai valor de uma propriedade do campo Properties
*====================================================================
PROCEDURE ExtrairProp
    LPARAMETERS par_cProps, par_cNomeProp
    LOCAL loc_cValor, loc_nPos, loc_nFim, loc_cLinha
    loc_cValor = ""

    IF EMPTY(par_cProps) OR EMPTY(par_cNomeProp)
        RETURN ""
    ENDIF

    *-- Procura "NomeProp = valor" no campo Properties (separado por CR+LF)
    LOCAL loc_nLinhas, loc_i
    DIMENSION loc_aLinhas[1]
    loc_nLinhas = ALINES(loc_aLinhas, par_cProps)

    FOR loc_i = 1 TO loc_nLinhas
        loc_cLinha = ALLTRIM(loc_aLinhas[loc_i])
        *-- Match: NomeProp = valor (case insensitive)
        IF UPPER(LEFT(loc_cLinha, LEN(par_cNomeProp) + 1)) = UPPER(par_cNomeProp) + " " OR ;
           UPPER(LEFT(loc_cLinha, LEN(par_cNomeProp) + 1)) = UPPER(par_cNomeProp) + "="
            *-- Extrair valor apos o "="
            loc_nPos = AT("=", loc_cLinha)
            IF loc_nPos > 0
                loc_cValor = ALLTRIM(SUBSTR(loc_cLinha, loc_nPos + 1))
            ENDIF
            EXIT
        ENDIF
    ENDFOR

    RETURN loc_cValor
ENDPROC


*====================================================================
* QuotarJSON - Escapa e aspeia uma string para JSON
*====================================================================
PROCEDURE QuotarJSON
    PARAMETERS par_cTexto
    IF EMPTY(par_cTexto)
        RETURN '""'
    ENDIF
    LOCAL loc_c
    loc_c = par_cTexto
    loc_c = STRTRAN(loc_c, '\', '\\')
    loc_c = STRTRAN(loc_c, '"', '\"')
    loc_c = STRTRAN(loc_c, CHR(13), '\r')
    loc_c = STRTRAN(loc_c, CHR(10), '\n')
    loc_c = STRTRAN(loc_c, CHR(9), '\t')
    RETURN '"' + loc_c + '"'
ENDPROC
