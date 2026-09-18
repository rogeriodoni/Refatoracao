*==============================================================================
* VALIDATORS.PRG
* Validações comuns da aplicação
* Funções para validar dados de entrada
*==============================================================================

*------------------------------------------------------------------------------
* ValidarCPF - Valida CPF
* Parâmetros: pcCPF - CPF a ser validado (com ou sem formatação)
* Retorno: .T. se válido, .F. se inválido
*------------------------------------------------------------------------------
FUNCTION ValidarCPF(pcCPF)
    LOCAL lcCPF, lnI, lnSoma, lnResto, lnDigito1, lnDigito2

    IF VARTYPE(pcCPF) != "C" OR EMPTY(pcCPF)
        RETURN .F.
    ENDIF

    * Remove formatação
    lcCPF = SomenteNumeros(pcCPF)

    * Verifica tamanho
    IF LEN(lcCPF) != 11
        RETURN .F.
    ENDIF

    * Verifica sequências inválidas (todos os dígitos iguais)
    IF lcCPF $ "00000000000,11111111111,22222222222,33333333333,44444444444," + ;
               "55555555555,66666666666,77777777777,88888888888,99999999999"
        RETURN .F.
    ENDIF

    * Valida primeiro dígito verificador
    lnSoma = 0
    FOR lnI = 1 TO 9
        lnSoma = lnSoma + VAL(SUBSTR(lcCPF, lnI, 1)) * (11 - lnI)
    ENDFOR

    lnResto = MOD(lnSoma, 11)
    lnDigito1 = IIF(lnResto < 2, 0, 11 - lnResto)

    IF lnDigito1 != VAL(SUBSTR(lcCPF, 10, 1))
        RETURN .F.
    ENDIF

    * Valida segundo dígito verificador
    lnSoma = 0
    FOR lnI = 1 TO 10
        lnSoma = lnSoma + VAL(SUBSTR(lcCPF, lnI, 1)) * (12 - lnI)
    ENDFOR

    lnResto = MOD(lnSoma, 11)
    lnDigito2 = IIF(lnResto < 2, 0, 11 - lnResto)

    IF lnDigito2 != VAL(SUBSTR(lcCPF, 11, 1))
        RETURN .F.
    ENDIF

    RETURN .T.
ENDFUNC

*------------------------------------------------------------------------------
* ValidarCNPJ - Valida CNPJ
* Parâmetros: pcCNPJ - CNPJ a ser validado (com ou sem formatação)
* Retorno: .T. se válido, .F. se inválido
*------------------------------------------------------------------------------
FUNCTION ValidarCNPJ(pcCNPJ)
    LOCAL lcCNPJ, lnI, lnSoma, lnResto, lnDigito1, lnDigito2
    LOCAL laPeso1[12], laPeso2[13]

    IF VARTYPE(pcCNPJ) != "C" OR EMPTY(pcCNPJ)
        RETURN .F.
    ENDIF

    * Remove formatação
    lcCNPJ = SomenteNumeros(pcCNPJ)

    * Verifica tamanho
    IF LEN(lcCNPJ) != 14
        RETURN .F.
    ENDIF

    * Verifica sequências inválidas
    IF lcCNPJ $ "00000000000000,11111111111111,22222222222222,33333333333333," + ;
                "44444444444444,55555555555555,66666666666666,77777777777777," + ;
                "88888888888888,99999999999999"
        RETURN .F.
    ENDIF

    * Define pesos para validação
    laPeso1[1] = 5
    laPeso1[2] = 4
    laPeso1[3] = 3
    laPeso1[4] = 2
    laPeso1[5] = 9
    laPeso1[6] = 8
    laPeso1[7] = 7
    laPeso1[8] = 6
    laPeso1[9] = 5
    laPeso1[10] = 4
    laPeso1[11] = 3
    laPeso1[12] = 2

    laPeso2[1] = 6
    FOR lnI = 2 TO 13
        laPeso2[lnI] = laPeso1[lnI - 1]
    ENDFOR

    * Valida primeiro dígito
    lnSoma = 0
    FOR lnI = 1 TO 12
        lnSoma = lnSoma + VAL(SUBSTR(lcCNPJ, lnI, 1)) * laPeso1[lnI]
    ENDFOR

    lnResto = MOD(lnSoma, 11)
    lnDigito1 = IIF(lnResto < 2, 0, 11 - lnResto)

    IF lnDigito1 != VAL(SUBSTR(lcCNPJ, 13, 1))
        RETURN .F.
    ENDIF

    * Valida segundo dígito
    lnSoma = 0
    FOR lnI = 1 TO 13
        lnSoma = lnSoma + VAL(SUBSTR(lcCNPJ, lnI, 1)) * laPeso2[lnI]
    ENDFOR

    lnResto = MOD(lnSoma, 11)
    lnDigito2 = IIF(lnResto < 2, 0, 11 - lnResto)

    IF lnDigito2 != VAL(SUBSTR(lcCNPJ, 14, 1))
        RETURN .F.
    ENDIF

    RETURN .T.
ENDFUNC

*------------------------------------------------------------------------------
* ValidarEmail - Valida formato de e-mail
* Parâmetros: pcEmail - e-mail a ser validado
* Retorno: .T. se válido, .F. se inválido
*------------------------------------------------------------------------------
FUNCTION ValidarEmail(pcEmail)
    LOCAL lcEmail, lnPosArroba, lnPosPonto

    IF VARTYPE(pcEmail) != "C" OR EMPTY(pcEmail)
        RETURN .F.
    ENDIF

    lcEmail = ALLTRIM(pcEmail)

    * Verifica tamanho mínimo
    IF LEN(lcEmail) < 5
        RETURN .F.
    ENDIF

    * Verifica presença de @
    lnPosArroba = AT("@", lcEmail)
    IF lnPosArroba = 0 OR lnPosArroba = 1 OR lnPosArroba = LEN(lcEmail)
        RETURN .F.
    ENDIF

    * Verifica se há apenas um @
    IF AT("@", lcEmail, 2) > 0
        RETURN .F.
    ENDIF

    * Verifica presença de ponto após @
    lnPosPonto = RAT(".", lcEmail)
    IF lnPosPonto = 0 OR lnPosPonto <= lnPosArroba + 1 OR lnPosPonto = LEN(lcEmail)
        RETURN .F.
    ENDIF

    * Verifica caracteres inválidos
    IF AT(" ", lcEmail) > 0
        RETURN .F.
    ENDIF

    RETURN .T.
ENDFUNC

*------------------------------------------------------------------------------
* ValidarCEP - Valida formato de CEP
* Parâmetros: pcCEP - CEP a ser validado
* Retorno: .T. se válido, .F. se inválido
*------------------------------------------------------------------------------
FUNCTION ValidarCEP(pcCEP)
    LOCAL lcCEP

    IF VARTYPE(pcCEP) != "C" OR EMPTY(pcCEP)
        RETURN .F.
    ENDIF

    lcCEP = SomenteNumeros(pcCEP)

    * Verifica tamanho
    IF LEN(lcCEP) != 8
        RETURN .F.
    ENDIF

    * Verifica se é sequência de zeros
    IF lcCEP = "00000000"
        RETURN .F.
    ENDIF

    RETURN .T.
ENDFUNC

*------------------------------------------------------------------------------
* ValidarData - Valida se data é válida
* Parâmetros: pdData - data a ser validada
* Retorno: .T. se válida, .F. se inválida
*------------------------------------------------------------------------------
FUNCTION ValidarData(pdData)
    IF VARTYPE(pdData) != "D" AND VARTYPE(pdData) != "T"
        RETURN .F.
    ENDIF

    RETURN !EMPTY(pdData)
ENDFUNC

*------------------------------------------------------------------------------
* ValidarDataFutura - Valida se data é futura
* Parâmetros: pdData - data a ser validada
* Retorno: .T. se futura, .F. se não
*------------------------------------------------------------------------------
FUNCTION ValidarDataFutura(pdData)
    IF !ValidarData(pdData)
        RETURN .F.
    ENDIF

    RETURN pdData > DATE()
ENDFUNC

*------------------------------------------------------------------------------
* ValidarDataPassada - Valida se data é passada
* Parâmetros: pdData - data a ser validada
* Retorno: .T. se passada, .F. se não
*------------------------------------------------------------------------------
FUNCTION ValidarDataPassada(pdData)
    IF !ValidarData(pdData)
        RETURN .F.
    ENDIF

    RETURN pdData < DATE()
ENDFUNC

*------------------------------------------------------------------------------
* ValidarIntervaloData - Valida intervalo entre duas datas
* Parâmetros: pdDataInicial - data inicial
*            pdDataFinal - data final
* Retorno: .T. se data final >= data inicial, .F. caso contrário
*------------------------------------------------------------------------------
FUNCTION ValidarIntervaloData(pdDataInicial, pdDataFinal)
    IF !ValidarData(pdDataInicial) OR !ValidarData(pdDataFinal)
        RETURN .F.
    ENDIF

    RETURN pdDataFinal >= pdDataInicial
ENDFUNC

*------------------------------------------------------------------------------
* ValidarNumeroPositivo - Valida se número é positivo
* Parâmetros: pnNumero - número a ser validado
* Retorno: .T. se positivo, .F. se não
*------------------------------------------------------------------------------
FUNCTION ValidarNumeroPositivo(pnNumero)
    IF VARTYPE(pnNumero) != "N"
        RETURN .F.
    ENDIF

    RETURN pnNumero > 0
ENDFUNC

*------------------------------------------------------------------------------
* ValidarNumeroNaoNegativo - Valida se número não é negativo
* Parâmetros: pnNumero - número a ser validado
* Retorno: .T. se não negativo, .F. se negativo
*------------------------------------------------------------------------------
FUNCTION ValidarNumeroNaoNegativo(pnNumero)
    IF VARTYPE(pnNumero) != "N"
        RETURN .F.
    ENDIF

    RETURN pnNumero >= 0
ENDFUNC

*------------------------------------------------------------------------------
* ValidarTelefone - Valida formato de telefone brasileiro
* Parâmetros: pcTelefone - telefone a ser validado
* Retorno: .T. se válido, .F. se inválido
*------------------------------------------------------------------------------
FUNCTION ValidarTelefone(pcTelefone)
    LOCAL lcTelefone

    IF VARTYPE(pcTelefone) != "C" OR EMPTY(pcTelefone)
        RETURN .F.
    ENDIF

    lcTelefone = SomenteNumeros(pcTelefone)

    * Verifica se tem 10 (fixo) ou 11 (celular) dígitos
    IF LEN(lcTelefone) < 10 OR LEN(lcTelefone) > 11
        RETURN .F.
    ENDIF

    * Verifica se não é sequência de zeros
    IF lcTelefone = REPLICATE("0", LEN(lcTelefone))
        RETURN .F.
    ENDIF

    RETURN .T.
ENDFUNC

*------------------------------------------------------------------------------
* ValidarCampoObrigatorio - Valida se campo obrigatório foi preenchido
* Parâmetros: puValor - valor a ser validado
* Retorno: .T. se preenchido, .F. se vazio
*------------------------------------------------------------------------------
FUNCTION ValidarCampoObrigatorio(puValor)
    LOCAL lcTipo

    lcTipo = VARTYPE(puValor)

    DO CASE
        CASE lcTipo = "C"
            RETURN !EMPTY(ALLTRIM(puValor))

        CASE lcTipo = "N"
            RETURN .T.  && Números sempre são considerados preenchidos (podem ser zero)

        CASE lcTipo = "D" OR lcTipo = "T"
            RETURN !EMPTY(puValor)

        CASE lcTipo = "L"
            RETURN .T.  && Lógicos sempre são considerados preenchidos

        OTHERWISE
            RETURN .F.
    ENDCASE
ENDFUNC

*------------------------------------------------------------------------------
* ValidarTamanhoMinimo - Valida tamanho mínimo de string
* Parâmetros: pcTexto - texto a validar
*            pnTamanho - tamanho mínimo
* Retorno: .T. se atende tamanho, .F. se não
*------------------------------------------------------------------------------
FUNCTION ValidarTamanhoMinimo(pcTexto, pnTamanho)
    IF VARTYPE(pcTexto) != "C"
        RETURN .F.
    ENDIF

    IF VARTYPE(pnTamanho) != "N"
        RETURN .F.
    ENDIF

    RETURN LEN(ALLTRIM(pcTexto)) >= pnTamanho
ENDFUNC

*------------------------------------------------------------------------------
* ValidarTamanhoMaximo - Valida tamanho máximo de string
* Parâmetros: pcTexto - texto a validar
*            pnTamanho - tamanho máximo
* Retorno: .T. se atende tamanho, .F. se não
*------------------------------------------------------------------------------
FUNCTION ValidarTamanhoMaximo(pcTexto, pnTamanho)
    IF VARTYPE(pcTexto) != "C"
        RETURN .F.
    ENDIF

    IF VARTYPE(pnTamanho) != "N"
        RETURN .F.
    ENDIF

    RETURN LEN(ALLTRIM(pcTexto)) <= pnTamanho
ENDFUNC
