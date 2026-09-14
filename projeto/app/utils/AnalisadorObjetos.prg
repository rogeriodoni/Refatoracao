*====================================================================
* AnalisadorObjetos.prg
*
* Classe para analisar hierarquia de objetos do codigo fonte extraido
*
* Uso:
*   loc_oAnalisador = CREATEOBJECT("AnalisadorObjetos")
*   loc_oAnalisador.Analisar("C:\4c\tasks\task1\SIGCDCOR_codigo_fonte.txt")
*
* Retorno:
*   THIS.aObjetos - Array com objetos identificados
*   [n, 1] = Caminho completo (ex: "SIGCDCOR.Pagina.Dados.Getcods")
*   [n, 2] = Nome simples (ex: "Getcods")
*   [n, 3] = Tipo (ex: "TextBox")
*   [n, 4] = Caminho pai (ex: "SIGCDCOR.Pagina.Dados")
*   [n, 5] = Caption
*   [n, 6] = ControlSource
*   [n, 7] = InputMask
*   [n, 8] = Width
*   [n, 9] = Height
*   [n, 10] = Top
*   [n, 11] = Left
*====================================================================

DEFINE CLASS AnalisadorObjetos AS Custom

    DIMENSION aObjetos[1, 11]
    nObjetos = 0

    cNomeFormOriginal = ""  && Nome do form original (ex: "SIGCDCOR")

    *====================================================================
    * Analisar
    * Analisa arquivo de codigo fonte extraido e extrai hierarquia
    *====================================================================
    PROCEDURE Analisar(par_cArquivo)
        LOCAL loc_nHandle, loc_cLinha
        LOCAL loc_cObjetoAtual, loc_cParentAtual, loc_cClassAtual, loc_cBaseClassAtual
        LOCAL loc_cCaminhoCompleto

        *-- Inicializa
        DIMENSION THIS.aObjetos[1, 11]
        THIS.nObjetos = 0
        THIS.cNomeFormOriginal = ""

        *-- Abre arquivo
        loc_nHandle = FOPEN(par_cArquivo, 0)

        IF loc_nHandle < 0
            ? "ERRO AnalisadorObjetos: N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir arquivo"
            RETURN .F.
        ENDIF

        *-- Le arquivo linha por linha
        DO WHILE !FEOF(loc_nHandle)
            loc_cLinha = FGETS(loc_nHandle)
            loc_cLinha = ALLTRIM(loc_cLinha)

            *-- Detecta inicio de objeto (linha "Objeto: NomeDoObjeto")
            IF LEFT(UPPER(loc_cLinha), 7) = "OBJETO:"
                *-- Extrai nome do objeto
                loc_cObjetoAtual = ALLTRIM(SUBSTR(loc_cLinha, 8))

                *-- Inicializa variaveis
                loc_cParentAtual = ""
                loc_cClassAtual = ""
                loc_cBaseClassAtual = ""

                *-- Le proximas linhas para extrair Parent, Class, BaseClass
                DO WHILE !FEOF(loc_nHandle)
                    loc_cLinha = FGETS(loc_nHandle)
                    loc_cLinha = ALLTRIM(loc_cLinha)

                    *-- Se linha vazia ou inicio de novo objeto, para
                    IF EMPTY(loc_cLinha) OR LEFT(UPPER(loc_cLinha), 7) = "OBJETO:" OR LEFT(loc_cLinha, 1) = "="
                        EXIT
                    ENDIF

                    *-- Extrai Parent
                    IF LEFT(UPPER(loc_cLinha), 7) = "PARENT:"
                        loc_cParentAtual = ALLTRIM(SUBSTR(loc_cLinha, 8))
                    ENDIF

                    *-- Extrai BaseClass
                    IF LEFT(UPPER(loc_cLinha), 10) = "BASECLASS:"
                        loc_cBaseClassAtual = ALLTRIM(SUBSTR(loc_cLinha, 11))
                    ENDIF
                ENDDO

                *-- Monta caminho completo
                IF EMPTY(loc_cParentAtual) OR UPPER(loc_cParentAtual) = "(RAIZ)"
                    *-- Objeto raiz (Form ou DataEnvironment)
                    loc_cCaminhoCompleto = loc_cObjetoAtual

                    *-- Se for Form, guarda nome original
                    IF UPPER(loc_cBaseClassAtual) = "FORM"
                        THIS.cNomeFormOriginal = loc_cObjetoAtual
                    ENDIF
                ELSE
                    *-- Objeto filho - monta caminho completo
                    loc_cCaminhoCompleto = loc_cParentAtual + "." + loc_cObjetoAtual
                ENDIF

                *-- Converte BaseClass para tipo padrao
                loc_cBaseClassAtual = THIS.ConverterBaseClassParaTipo(loc_cBaseClassAtual)

                *-- Adiciona ao array (se nao for DataEnvironment)
                IF UPPER(loc_cBaseClassAtual) != "DATAENVIRONMENT"
                    THIS.AdicionarObjeto(loc_cCaminhoCompleto, loc_cObjetoAtual, ;
                                        loc_cBaseClassAtual, loc_cParentAtual)

                    *-- IMPORTANTE: Extrai objetos intermediarios do Parent
                    *-- Ex: Se Parent = "SIGCDCOR.Pagina.Dados", extrai "Pagina" e "Dados"
                    IF !EMPTY(loc_cParentAtual) AND UPPER(loc_cParentAtual) != "(RAIZ)"
                        THIS.ExtrairObjetosIntermediariosDoParent(loc_cParentAtual)
                    ENDIF
                ENDIF
            ENDIF
        ENDDO

        FCLOSE(loc_nHandle)

        ? "AnalisadorObjetos: " + ALLTRIM(STR(THIS.nObjetos)) + " objetos extraidos"

        *-- Segunda passagem: extrair propriedades de cada objeto
        THIS.ExtrairPropriedades(par_cArquivo)

        RETURN .T.
    ENDPROC

    *====================================================================
    * ExtrairObjetosIntermediariosDoParent
    * Extrai objetos intermediarios do caminho do Parent
    * Ex: "SIGCDCOR.Pagina.Dados" extrai "Pagina" e "Dados" se nao existirem
    *====================================================================
    PROTECTED PROCEDURE ExtrairObjetosIntermediariosDoParent(par_cParent)
        LOCAL ARRAY loc_aParts[1]
        LOCAL loc_nParts, loc_cCaminho, i, j
        LOCAL loc_cNome, loc_cPai, loc_cTipo
        LOCAL loc_lJaExiste

        *-- Separa Parent em partes
        loc_nParts = ALINES(loc_aParts, par_cParent, 1, ".")

        *-- Reconstroi caminho progressivamente e adiciona objetos que faltam
        loc_cCaminho = ""
        FOR i = 1 TO loc_nParts
            *-- Monta caminho atual
            IF EMPTY(loc_cCaminho)
                loc_cCaminho = loc_aParts[i]
            ELSE
                loc_cCaminho = loc_cCaminho + "." + loc_aParts[i]
            ENDIF

            *-- Verifica se ja existe no array
            loc_lJaExiste = .F.
            FOR j = 1 TO THIS.nObjetos
                IF UPPER(ALLTRIM(THIS.aObjetos[j, 1])) == UPPER(ALLTRIM(loc_cCaminho))
                    loc_lJaExiste = .T.
                    EXIT
                ENDIF
            ENDFOR

            *-- Se nao existe, adiciona
            IF !loc_lJaExiste
                loc_cNome = loc_aParts[i]

                *-- Determina pai
                IF i = 1
                    loc_cPai = ""
                ELSE
                    *-- Reconstroi caminho do pai
                    loc_cPai = ""
                    FOR j = 1 TO i - 1
                        IF !EMPTY(loc_cPai)
                            loc_cPai = loc_cPai + "."
                        ENDIF
                        loc_cPai = loc_cPai + loc_aParts[j]
                    ENDFOR
                ENDIF

                *-- Infere tipo baseado na posicao
                *-- Primeira parte depois do form = PageFrame
                *-- Segunda parte = Page
                *-- Terceira+ = Container
                IF i = 1
                    *-- Eh o form
                    loc_cTipo = "Form"
                ELSE
                    IF i = 2
                        *-- Primeira parte depois do form = PageFrame
                        loc_cTipo = "PageFrame"
                    ELSE
                        IF i = 3
                            *-- Segunda parte = Page
                            loc_cTipo = "Page"
                        ELSE
                            *-- Demais = Container
                            loc_cTipo = "Container"
                        ENDIF
                    ENDIF
                ENDIF

                *-- Adiciona ao array
                THIS.AdicionarObjeto(loc_cCaminho, loc_cNome, loc_cTipo, loc_cPai)
            ENDIF
        ENDFOR
    ENDPROC

    *====================================================================
    * ConverterBaseClassParaTipo
    * Converte BaseClass do VFP para tipo padrao
    *====================================================================
    PROTECTED PROCEDURE ConverterBaseClassParaTipo(par_cBaseClass)
        LOCAL loc_cTipo

        par_cBaseClass = UPPER(ALLTRIM(par_cBaseClass))

        DO CASE
        CASE par_cBaseClass = "FORM"
            loc_cTipo = "Form"
        CASE par_cBaseClass = "TEXTBOX"
            loc_cTipo = "TextBox"
        CASE par_cBaseClass = "LABEL"
            loc_cTipo = "Label"
        CASE par_cBaseClass = "COMMANDBUTTON"
            loc_cTipo = "CommandButton"
        CASE par_cBaseClass = "GRID"
            loc_cTipo = "Grid"
        CASE par_cBaseClass = "PAGEFRAME"
            loc_cTipo = "PageFrame"
        CASE par_cBaseClass = "PAGE"
            loc_cTipo = "Page"
        CASE par_cBaseClass = "COMBOBOX"
            loc_cTipo = "ComboBox"
        CASE par_cBaseClass = "CHECKBOX"
            loc_cTipo = "CheckBox"
        CASE par_cBaseClass = "CONTAINER"
            loc_cTipo = "Container"
        CASE par_cBaseClass = "SHAPE"
            loc_cTipo = "Shape"
        CASE par_cBaseClass = "IMAGE"
            loc_cTipo = "Image"
        CASE par_cBaseClass = "LINE"
            loc_cTipo = "Line"
        OTHERWISE
            loc_cTipo = "Unknown"
        ENDCASE

        RETURN loc_cTipo
    ENDPROC

    *====================================================================
    * AdicionarObjeto
    * Adiciona objeto ao array
    *====================================================================
    PROTECTED PROCEDURE AdicionarObjeto(par_cCaminho, par_cNome, par_cTipo, par_cPai)
        THIS.nObjetos = THIS.nObjetos + 1

        IF THIS.nObjetos > ALEN(THIS.aObjetos, 1)
            DIMENSION THIS.aObjetos[THIS.nObjetos + 50, 11]
        ENDIF

        THIS.aObjetos[THIS.nObjetos, 1] = par_cCaminho
        THIS.aObjetos[THIS.nObjetos, 2] = par_cNome
        THIS.aObjetos[THIS.nObjetos, 3] = par_cTipo
        THIS.aObjetos[THIS.nObjetos, 4] = par_cPai
        THIS.aObjetos[THIS.nObjetos, 5] = ""  && Caption
        THIS.aObjetos[THIS.nObjetos, 6] = ""  && ControlSource
        THIS.aObjetos[THIS.nObjetos, 7] = ""  && InputMask
        THIS.aObjetos[THIS.nObjetos, 8] = ""  && Width
        THIS.aObjetos[THIS.nObjetos, 9] = ""  && Height
        THIS.aObjetos[THIS.nObjetos, 10] = ""  && Top
        THIS.aObjetos[THIS.nObjetos, 11] = ""  && Left
    ENDPROC

    *====================================================================
    * ExtrairPropriedades
    * Segunda passagem: extrai propriedades de cada objeto
    *====================================================================
    PROTECTED PROCEDURE ExtrairPropriedades(par_cArquivo)
        LOCAL loc_nHandle, loc_cLinha
        LOCAL loc_cObjetoAtual, loc_cPropriedade, loc_cValor
        LOCAL i, loc_nPos

        loc_nHandle = FOPEN(par_cArquivo, 0)

        IF loc_nHandle < 0
            RETURN
        ENDIF

        loc_cObjetoAtual = ""

        *-- Le arquivo linha por linha
        DO WHILE !FEOF(loc_nHandle)
            loc_cLinha = FGETS(loc_nHandle)
            loc_cLinha = ALLTRIM(loc_cLinha)

            *-- Detecta secao de propriedades (SECAO 2)
            IF "SECAO 2" $ UPPER(loc_cLinha)
                *-- Comeca a ler propriedades
                DO WHILE !FEOF(loc_nHandle)
                    loc_cLinha = FGETS(loc_nHandle)
                    loc_cLinha = ALLTRIM(loc_cLinha)

                    *-- Ignora linhas vazias e separadores
                    IF EMPTY(loc_cLinha) OR LEFT(loc_cLinha, 1) = "=" OR LEFT(loc_cLinha, 1) = "*"
                        LOOP
                    ENDIF

                    *-- Detecta inicio de objeto (Objeto: NomeDoObjeto)
                    IF LEFT(UPPER(loc_cLinha), 7) = "OBJETO:"
                        loc_cObjetoAtual = ALLTRIM(SUBSTR(loc_cLinha, 8))
                        LOOP
                    ENDIF

                    *-- Se tem objeto atual, processa propriedade
                    IF !EMPTY(loc_cObjetoAtual)
                        *-- Detecta propriedade (formato: NomePropriedade = Valor)
                        loc_nPos = AT(" = ", loc_cLinha)

                        IF loc_nPos > 0
                            loc_cPropriedade = ALLTRIM(LEFT(loc_cLinha, loc_nPos - 1))
                            loc_cValor = ALLTRIM(SUBSTR(loc_cLinha, loc_nPos + 3))

                            *-- Atualiza propriedade no objeto
                            THIS.AtualizarPropriedade(loc_cObjetoAtual, loc_cPropriedade, loc_cValor)
                        ENDIF
                    ENDIF
                ENDDO

                EXIT  && Terminou secao de propriedades
            ENDIF
        ENDDO

        FCLOSE(loc_nHandle)
    ENDPROC

    *====================================================================
    * AtualizarPropriedade
    * Atualiza propriedade do objeto no array
    *====================================================================
    PROTECTED PROCEDURE AtualizarPropriedade(par_cCaminho, par_cPropriedade, par_cValor)
        LOCAL i

        *-- Propriedades relevantes
        IF !INLIST(UPPER(par_cPropriedade), "CAPTION", "CONTROLSOURCE", "INPUTMASK", ;
                   "WIDTH", "HEIGHT", "TOP", "LEFT")
            RETURN
        ENDIF

        *-- Procura objeto no array
        FOR i = 1 TO THIS.nObjetos
            IF UPPER(ALLTRIM(THIS.aObjetos[i, 1])) == UPPER(ALLTRIM(par_cCaminho))
                *-- Atualiza propriedade
                DO CASE
                CASE UPPER(par_cPropriedade) = "CAPTION"
                    THIS.aObjetos[i, 5] = THIS.LimparValor(par_cValor)
                CASE UPPER(par_cPropriedade) = "CONTROLSOURCE"
                    THIS.aObjetos[i, 6] = THIS.LimparValor(par_cValor)
                CASE UPPER(par_cPropriedade) = "INPUTMASK"
                    THIS.aObjetos[i, 7] = THIS.LimparValor(par_cValor)
                CASE UPPER(par_cPropriedade) = "WIDTH"
                    THIS.aObjetos[i, 8] = THIS.LimparValor(par_cValor)
                CASE UPPER(par_cPropriedade) = "HEIGHT"
                    THIS.aObjetos[i, 9] = THIS.LimparValor(par_cValor)
                CASE UPPER(par_cPropriedade) = "TOP"
                    THIS.aObjetos[i, 10] = THIS.LimparValor(par_cValor)
                CASE UPPER(par_cPropriedade) = "LEFT"
                    THIS.aObjetos[i, 11] = THIS.LimparValor(par_cValor)
                ENDCASE

                EXIT
            ENDIF
        ENDFOR
    ENDPROC

    *====================================================================
    * LimparValor
    * Remove aspas e espacos de valor
    *====================================================================
    PROTECTED PROCEDURE LimparValor(par_cValor)
        LOCAL loc_cResultado

        loc_cResultado = ALLTRIM(par_cValor)

        *-- Remove aspas
        loc_cResultado = STRTRAN(loc_cResultado, CHR(34), "")
        loc_cResultado = STRTRAN(loc_cResultado, "'", "")
        loc_cResultado = STRTRAN(loc_cResultado, "[", "")
        loc_cResultado = STRTRAN(loc_cResultado, "]", "")

        RETURN ALLTRIM(loc_cResultado)
    ENDPROC

ENDDEFINE
