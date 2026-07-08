*====================================================================
* RegrasNomenclatura.prg
*
* Classe com regras de conversao de nomenclatura legado -> novo padrao
*
* Uso:
*   loc_oRegras = CREATEOBJECT("RegrasNomenclatura")
*   loc_cNovoNome = loc_oRegras.ConverterNome(loc_cNomeOriginal, loc_cTipo, loc_cCaption, loc_cContext)
*
* Baseado em CLAUDE.md - Padrao de nomenclatura _4c_
*====================================================================

DEFINE CLASS RegrasNomenclatura AS Custom

    *====================================================================
    * ConverterNome
    * Converte nome original para novo padrao
    *
    * Parametros:
    *   par_cNomeOriginal - Nome no codigo legado (ex: "Getcods", "Say1")
    *   par_cTipo - Tipo do controle (TextBox, Label, CommandButton, etc)
    *   par_cCaption - Caption do controle (se aplicavel)
    *   par_cContexto - Contexto/hierarquia (ex: "Pagina.Dados")
    *====================================================================
    PROCEDURE ConverterNome(par_cNomeOriginal, par_cTipo, par_cCaption, par_cContexto)
        LOCAL loc_cNomeNovo, loc_cPrefixo, loc_cBase

        *-- Remove espacos
        par_cNomeOriginal = ALLTRIM(par_cNomeOriginal)
        par_cTipo = ALLTRIM(par_cTipo)
        par_cCaption = ALLTRIM(par_cCaption)
        par_cContexto = ALLTRIM(par_cContexto)

        *-- Casos especiais: Form
        IF par_cTipo = "Form"
            RETURN "Form"
        ENDIF

        *-- Determina prefixo baseado no tipo
        loc_cPrefixo = THIS.ObterPrefixo(par_cTipo)

        *-- Extrai base do nome
        loc_cBase = THIS.ExtrairBase(par_cNomeOriginal, par_cTipo, par_cCaption)

        *-- Monta nome final
        loc_cNomeNovo = loc_cPrefixo + "_4c_" + loc_cBase

        RETURN loc_cNomeNovo
    ENDPROC

    *====================================================================
    * ObterPrefixo
    * Retorna prefixo baseado no tipo de controle
    *====================================================================
    PROTECTED PROCEDURE ObterPrefixo(par_cTipo)
        LOCAL loc_cPrefixo

        DO CASE
        CASE par_cTipo = "TextBox"
            loc_cPrefixo = "txt"
        CASE par_cTipo = "Label"
            loc_cPrefixo = "lbl"
        CASE par_cTipo = "CommandButton"
            loc_cPrefixo = "cmd"
        CASE par_cTipo = "Grid"
            loc_cPrefixo = "grd"
        CASE par_cTipo = "PageFrame"
            loc_cPrefixo = "pgf"
        CASE par_cTipo = "Page"
            loc_cPrefixo = "Page"  && Pages nao usam prefixo, apenas Page1, Page2, etc
        CASE par_cTipo = "ComboBox"
            loc_cPrefixo = "cbo"
        CASE par_cTipo = "CheckBox"
            loc_cPrefixo = "chk"
        CASE par_cTipo = "Container"
            loc_cPrefixo = "cnt"
        CASE par_cTipo = "Shape"
            loc_cPrefixo = "shp"
        CASE par_cTipo = "Image"
            loc_cPrefixo = "img"
        CASE par_cTipo = "Line"
            loc_cPrefixo = "lin"
        OTHERWISE
            loc_cPrefixo = "obj"  && Generico
        ENDCASE

        RETURN loc_cPrefixo
    ENDPROC

    *====================================================================
    * ExtrairBase
    * Extrai nome base aplicando regras de conversao
    *====================================================================
    PROTECTED PROCEDURE ExtrairBase(par_cNomeOriginal, par_cTipo, par_cCaption)
        LOCAL loc_cBase, loc_cNomeLower

        loc_cNomeLower = LOWER(par_cNomeOriginal)

        *-- Page: Retorna numero baseado no nome
        IF par_cTipo = "Page"
            RETURN THIS.ConverterNomePage(par_cNomeOriginal)
        ENDIF

        *-- TextBox: Remove prefixos comuns (Get, get, Get_)
        IF par_cTipo = "TextBox"
            RETURN THIS.ConverterNomeTextBox(par_cNomeOriginal)
        ENDIF

        *-- Label: Usa Caption se disponivel
        IF par_cTipo = "Label"
            RETURN THIS.ConverterNomeLabel(par_cNomeOriginal, par_cCaption)
        ENDIF

        *-- CommandButton: Mapeia acoes conhecidas
        IF par_cTipo = "CommandButton"
            RETURN THIS.ConverterNomeButton(par_cNomeOriginal)
        ENDIF

        *-- Container: Analisa semantica
        IF par_cTipo = "Container"
            RETURN THIS.ConverterNomeContainer(par_cNomeOriginal)
        ENDIF

        *-- PageFrame: Padrao generico
        IF par_cTipo = "PageFrame"
            RETURN "Dados"  && Padrao: pgf_4c_Dados
        ENDIF

        *-- Grid: Padrao generico
        IF par_cTipo = "Grid"
            RETURN "Dados"  && Padrao: grd_4c_Dados
        ENDIF

        *-- Outros: Capitaliza e limpa
        loc_cBase = THIS.Capitalizar(par_cNomeOriginal)

        RETURN loc_cBase
    ENDPROC

    *====================================================================
    * ConverterNomePage
    * Converte nome de Page (Lista -> 1, Dados -> 2)
    *====================================================================
    PROTECTED PROCEDURE ConverterNomePage(par_cNome)
        LOCAL loc_cNomeLower

        loc_cNomeLower = LOWER(ALLTRIM(par_cNome))

        DO CASE
        CASE loc_cNomeLower = "lista"
            RETURN "1"  && Page1
        CASE loc_cNomeLower = "dados"
            RETURN "2"  && Page2
        CASE loc_cNomeLower = "page1"
            RETURN "1"
        CASE loc_cNomeLower = "page2"
            RETURN "2"
        CASE loc_cNomeLower = "page3"
            RETURN "3"
        OTHERWISE
            RETURN "1"  && Default
        ENDCASE
    ENDPROC

    *====================================================================
    * ConverterNomeTextBox
    * Converte nome de TextBox (remove Get, get, Get_)
    *====================================================================
    PROTECTED PROCEDURE ConverterNomeTextBox(par_cNome)
        LOCAL loc_cBase, loc_cNomeLower

        loc_cBase = ALLTRIM(par_cNome)
        loc_cNomeLower = LOWER(loc_cBase)

        *-- Remove prefixos comuns
        DO CASE
        CASE LEFT(loc_cBase, 4) = "Get_"
            loc_cBase = SUBSTR(loc_cBase, 5)
        CASE LEFT(loc_cNomeLower, 3) = "get"
            loc_cBase = SUBSTR(loc_cBase, 4)
        ENDCASE

        *-- Mapeamentos conhecidos
        loc_cNomeLower = LOWER(loc_cBase)

        DO CASE
        CASE loc_cNomeLower = "cods"
            loc_cBase = "Codigo"
        CASE loc_cNomeLower = "descs"
            loc_cBase = "Descricao"
        CASE loc_cNomeLower = "grupo"
            loc_cBase = "Grupo"
        CASE loc_cNomeLower = "tanque"
            loc_cBase = "Tanque"
        CASE loc_cNomeLower = "diasents"
            loc_cBase = "DiasEntrega"
        CASE loc_cNomeLower = "peso"
            loc_cBase = "Peso"
        CASE loc_cNomeLower = "varias"
            loc_cBase = "VariacaoPreco"
        CASE loc_cNomeLower = "tpcor"
            loc_cBase = "TipoCor"
        OTHERWISE
            loc_cBase = THIS.Capitalizar(loc_cBase)
        ENDCASE

        RETURN loc_cBase
    ENDPROC

    *====================================================================
    * ConverterNomeLabel
    * Converte nome de Label (extrai do Caption se possivel)
    *====================================================================
    PROTECTED PROCEDURE ConverterNomeLabel(par_cNome, par_cCaption)
        LOCAL loc_cBase

        *-- Se Caption disponivel, extrai palavra-chave
        IF !EMPTY(par_cCaption)
            loc_cBase = THIS.ExtrairPalavraChave(par_cCaption)
            IF !EMPTY(loc_cBase)
                RETURN loc_cBase
            ENDIF
        ENDIF

        *-- Senao, tenta inferir do nome
        loc_cBase = STRTRAN(par_cNome, "Say", "")
        loc_cBase = STRTRAN(loc_cBase, "Label", "")

        *-- Se sobrou apenas numero, usa generico
        IF ISDIGIT(loc_cBase)
            RETURN "Label" + loc_cBase
        ENDIF

        RETURN THIS.Capitalizar(loc_cBase)
    ENDPROC

    *====================================================================
    * ConverterNomeButton
    * Converte nome de CommandButton (mapeia acoes)
    *====================================================================
    PROTECTED PROCEDURE ConverterNomeButton(par_cNome)
        LOCAL loc_cBase, loc_cNomeLower

        loc_cNomeLower = LOWER(ALLTRIM(par_cNome))

        *-- Mapeamentos de acoes conhecidas
        DO CASE
        CASE loc_cNomeLower = "inserir"
            loc_cBase = "Incluir"
        CASE loc_cNomeLower = "consultar"
            loc_cBase = "Consultar"
        CASE loc_cNomeLower = "alterar"
            loc_cBase = "Alterar"
        CASE loc_cNomeLower = "excluir"
            loc_cBase = "Excluir"
        CASE loc_cNomeLower = "procurar"
            loc_cBase = "Procurar"
        CASE loc_cNomeLower = "sair"
            loc_cBase = "Sair"
        CASE loc_cNomeLower = "salva" OR loc_cNomeLower = "salvar" OR loc_cNomeLower = "gravar"
            loc_cBase = "Confirmar"
        CASE loc_cNomeLower = "cancelar"
            loc_cBase = "Cancelar"
        CASE loc_cNomeLower = "imprimir"
            loc_cBase = "Imprimir"
        OTHERWISE
            loc_cBase = THIS.Capitalizar(par_cNome)
        ENDCASE

        RETURN loc_cBase
    ENDPROC

    *====================================================================
    * ConverterNomeContainer
    * Converte nome de Container (analisa semantica)
    *====================================================================
    PROTECTED PROCEDURE ConverterNomeContainer(par_cNome)
        LOCAL loc_cBase, loc_cNomeLower

        loc_cNomeLower = LOWER(ALLTRIM(par_cNome))

        *-- Mapeamentos conhecidos
        DO CASE
        CASE "grupo_op" $ loc_cNomeLower OR "grupo_crud" $ loc_cNomeLower
            loc_cBase = "BotoesCRUD"
        CASE "grupo_salva" $ loc_cNomeLower OR "grupo_confirma" $ loc_cNomeLower
            loc_cBase = "BotoesConfirmacao"
        CASE "grupo_saida" $ loc_cNomeLower
            loc_cBase = "BotoesSaida"
        CASE "sombra" $ loc_cNomeLower OR "shadow" $ loc_cNomeLower
            loc_cBase = "Sombra"
        OTHERWISE
            loc_cBase = THIS.Capitalizar(par_cNome)
            loc_cBase = STRTRAN(loc_cBase, "Grupo_", "")
            loc_cBase = STRTRAN(loc_cBase, "Cnt", "")
        ENDCASE

        RETURN loc_cBase
    ENDPROC

    *====================================================================
    * ExtrairPalavraChave
    * Extrai palavra-chave do Caption (ex: "Codigo :" -> "Codigo")
    *====================================================================
    PROTECTED PROCEDURE ExtrairPalavraChave(par_cCaption)
        LOCAL loc_cPalavra, loc_nPos

        *-- Remove caracteres comuns
        loc_cPalavra = ALLTRIM(par_cCaption)
        loc_cPalavra = STRTRAN(loc_cPalavra, ":", "")
        loc_cPalavra = STRTRAN(loc_cPalavra, " ", "")

        *-- Remove acentos comuns via CHR() reverso (aproximacao)
        *-- (Idealmente usaria funcao de remocao de acentos, mas vamos simplificar)

        *-- Se ficou vazio ou muito curto, retorna vazio
        IF LEN(loc_cPalavra) < 3
            RETURN ""
        ENDIF

        *-- Mapeamentos conhecidos de palavras acentuadas
        loc_cPalavra = LOWER(loc_cPalavra)

        DO CASE
        CASE "codigo" $ loc_cPalavra OR "c" + CHR(243) + "digo" $ loc_cPalavra
            RETURN "Codigo"
        CASE "descri" $ loc_cPalavra
            RETURN "Descricao"
        CASE "grupo" $ loc_cPalavra
            RETURN "Grupo"
        CASE "varia" $ loc_cPalavra AND "pre" $ loc_cPalavra
            RETURN "VariacaoPreco"
        CASE "varia" $ loc_cPalavra AND "peso" $ loc_cPalavra
            RETURN "VariacaoPeso"
        CASE "tipo" $ loc_cPalavra AND "cor" $ loc_cPalavra
            RETURN "TipoCor"
        CASE "adicionar" $ loc_cPalavra AND "entrega" $ loc_cPalavra
            RETURN "AdicionarEntrega"
        CASE "dias" $ loc_cPalavra
            RETURN "Dias"
        CASE "tanque" $ loc_cPalavra
            RETURN "Tanque"
        OTHERWISE
            RETURN THIS.Capitalizar(loc_cPalavra)
        ENDCASE
    ENDPROC

    *====================================================================
    * Capitalizar
    * Converte primeira letra para maiuscula
    *====================================================================
    PROTECTED PROCEDURE Capitalizar(par_cTexto)
        LOCAL loc_cResultado

        IF EMPTY(par_cTexto)
            RETURN ""
        ENDIF

        par_cTexto = ALLTRIM(par_cTexto)

        *-- Primeira letra maiuscula, resto mantem
        loc_cResultado = UPPER(LEFT(par_cTexto, 1)) + SUBSTR(par_cTexto, 2)

        RETURN loc_cResultado
    ENDPROC

ENDDEFINE
