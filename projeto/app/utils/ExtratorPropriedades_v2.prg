*====================================================================
* ExtratorPropriedades.prg
*
* Classe para extrair propriedades visuais de codigo fonte original (.txt)
* VERSAO 2: Usa propriedade publica ao inves de RETURN (compatibilidade VFP9)
*====================================================================

DEFINE CLASS ExtratorPropriedades AS Custom

    *-- Propriedades criticas a extrair
    DIMENSION aPropriedadesCriticas[18]
    aPropriedadesCriticas[1] = "Width"
    aPropriedadesCriticas[2] = "Height"
    aPropriedadesCriticas[3] = "Top"
    aPropriedadesCriticas[4] = "Left"
    aPropriedadesCriticas[5] = "BackColor"
    aPropriedadesCriticas[6] = "ForeColor"
    aPropriedadesCriticas[7] = "FontName"
    aPropriedadesCriticas[8] = "FontSize"
    aPropriedadesCriticas[9] = "FontBold"
    aPropriedadesCriticas[10] = "FontItalic"
    aPropriedadesCriticas[11] = "BorderStyle"
    aPropriedadesCriticas[12] = "SpecialEffect"
    aPropriedadesCriticas[13] = "Picture"
    aPropriedadesCriticas[14] = "Themes"
    aPropriedadesCriticas[15] = "Caption"
    aPropriedadesCriticas[16] = "PicturePosition"
    aPropriedadesCriticas[17] = "Alignment"
    aPropriedadesCriticas[18] = "InputMask"

    *-- Array de resultados (PUBLICO - acessivel externamente)
    DIMENSION aResultados[1, 5]
    nResultados = 0

    *====================================================================
    * ExtrairDeArquivo
    * Extrai propriedades criticas de arquivo .txt
    * RETORNA: .T. se sucesso, .F. se erro
    * RESULTADO: Armazenado em THIS.aResultados e THIS.nResultados
    *====================================================================
    PROCEDURE ExtrairDeArquivo(par_cArquivo)
        LOCAL loc_nHandle, loc_cLinha, loc_nLinha
        LOCAL loc_cObjeto, loc_cPropriedade, loc_cValor
        LOCAL loc_lDentroSecaoProps

        IF !FILE(par_cArquivo)
            ? "ERRO: Arquivo nao encontrado: " + par_cArquivo
            RETURN .F.
        ENDIF

        THIS.nResultados = 0
        DIMENSION THIS.aResultados[1, 5]

        loc_nHandle = FOPEN(par_cArquivo, 0)  && Read only

        IF loc_nHandle < 0
            ? "ERRO: Nao foi possivel abrir arquivo: " + par_cArquivo
            RETURN .F.
        ENDIF

        loc_nLinha = 0
        loc_cObjeto = ""
        loc_lDentroSecaoProps = .F.

        DO WHILE !FEOF(loc_nHandle)
            loc_cLinha = FGETS(loc_nHandle)
            loc_nLinha = loc_nLinha + 1

            *-- Remove espacos em branco das extremidades
            loc_cLinha = ALLTRIM(loc_cLinha)

            *-- Ignora linhas vazias
            IF EMPTY(loc_cLinha)
                LOOP
            ENDIF

            *-- Verifica se entrou na secao de propriedades
            IF "* SECAO 2: PROPRIEDADES CUSTOMIZADAS" $ loc_cLinha
                loc_lDentroSecaoProps = .T.
                LOOP
            ENDIF

            *-- So processa se estiver dentro da secao de propriedades
            IF !loc_lDentroSecaoProps
                LOOP
            ENDIF

            *-- Identifica inicio de bloco de propriedades
            *-- Formato: "* PROPRIEDADES DE: SIGCDCOR.Pagina.Dados.Say1"
            IF "* PROPRIEDADES DE:" $ loc_cLinha
                loc_cObjeto = THIS.ExtrairNomeObjeto(loc_cLinha)
                LOOP
            ENDIF

            *-- Verifica se linha contem propriedade critica
            IF !EMPTY(loc_cObjeto) AND THIS.EhPropriedadeCritica(loc_cLinha)
                loc_cPropriedade = THIS.ExtrairNomePropriedade(loc_cLinha)
                loc_cValor = THIS.ExtrairValorPropriedade(loc_cLinha)

                *-- Adiciona ao array de resultados
                THIS.AdicionarResultado(loc_cObjeto, loc_cPropriedade, loc_cValor, loc_nLinha, loc_cLinha)
            ENDIF
        ENDDO

        FCLOSE(loc_nHandle)

        IF THIS.nResultados > 0
            ? "ExtratorPropriedades: " + ALLTRIM(STR(THIS.nResultados)) + " propriedades extraidas"
            RETURN .T.
        ELSE
            ? "ExtratorPropriedades: NENHUMA propriedade encontrada!"
            RETURN .F.
        ENDIF
    ENDPROC

    *====================================================================
    * ExtrairNomeObjeto
    * Extrai nome do objeto de linha "* PROPRIEDADES DE: xxx"
    *====================================================================
    PROTECTED PROCEDURE ExtrairNomeObjeto(par_cLinha)
        LOCAL loc_nPos, loc_cNome

        *-- Procura por "* PROPRIEDADES DE:"
        loc_nPos = AT("* PROPRIEDADES DE:", par_cLinha)
        IF loc_nPos = 0
            RETURN "Desconhecido"
        ENDIF

        *-- Pega tudo apos "* PROPRIEDADES DE:"
        loc_cNome = ALLTRIM(SUBSTR(par_cLinha, loc_nPos + 20))

        *-- Remove primeiro componente (nome do form) para compatibilidade
        *-- "SIGCDCOR.Pagina.Dados.Say1" -> "Pagina.Dados.Say1"
        IF AT(".", loc_cNome) > 0
            loc_cNome = SUBSTR(loc_cNome, AT(".", loc_cNome) + 1)
        ENDIF

        RETURN loc_cNome
    ENDPROC

    *====================================================================
    * EhPropriedadeCritica
    * Verifica se linha contem propriedade critica
    *====================================================================
    PROTECTED PROCEDURE EhPropriedadeCritica(par_cLinha)
        LOCAL i

        *-- Ignora linhas de comentario e separadores
        IF LEFT(par_cLinha, 1) = "*" OR LEFT(par_cLinha, 1) = "="
            RETURN .F.
        ENDIF

        FOR i = 1 TO ALEN(THIS.aPropriedadesCriticas)
            IF THIS.aPropriedadesCriticas[i] + " = " $ par_cLinha
                RETURN .T.
            ENDIF
        ENDFOR

        RETURN .F.
    ENDPROC

    *====================================================================
    * ExtrairNomePropriedade
    * Extrai nome da propriedade de linha (Width = 800)
    *====================================================================
    PROTECTED PROCEDURE ExtrairNomePropriedade(par_cLinha)
        LOCAL loc_nPos, loc_cNome

        loc_nPos = AT(" = ", par_cLinha)
        IF loc_nPos = 0
            RETURN ""
        ENDIF

        loc_cNome = ALLTRIM(LEFT(par_cLinha, loc_nPos - 1))
        RETURN loc_cNome
    ENDPROC

    *====================================================================
    * ExtrairValorPropriedade
    * Extrai valor da propriedade de linha (Width = 800)
    *====================================================================
    PROTECTED PROCEDURE ExtrairValorPropriedade(par_cLinha)
        LOCAL loc_nPos, loc_cValor

        loc_nPos = AT(" = ", par_cLinha)
        IF loc_nPos = 0
            RETURN ""
        ENDIF

        loc_cValor = ALLTRIM(SUBSTR(par_cLinha, loc_nPos + 3))

        *-- Remove aspas se for string
        IF LEFT(loc_cValor, 1) = '"' AND RIGHT(loc_cValor, 1) = '"'
            loc_cValor = SUBSTR(loc_cValor, 2, LEN(loc_cValor) - 2)
        ENDIF

        RETURN loc_cValor
    ENDPROC

    *====================================================================
    * AdicionarResultado
    * Adiciona propriedade ao array de resultados
    *====================================================================
    PROTECTED PROCEDURE AdicionarResultado(par_cObjeto, par_cProp, par_cValor, par_nLinha, par_cContexto)
        THIS.nResultados = THIS.nResultados + 1

        IF THIS.nResultados > ALEN(THIS.aResultados, 1)
            DIMENSION THIS.aResultados[THIS.nResultados + 100, 5]  && Expande em blocos
        ENDIF

        THIS.aResultados[THIS.nResultados, 1] = par_cObjeto
        THIS.aResultados[THIS.nResultados, 2] = par_cProp
        THIS.aResultados[THIS.nResultados, 3] = par_cValor
        THIS.aResultados[THIS.nResultados, 4] = par_nLinha
        THIS.aResultados[THIS.nResultados, 5] = par_cContexto
    ENDPROC

ENDDEFINE
