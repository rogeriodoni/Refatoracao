*==============================================================================
* SIGPRIFFBO.prg - Business Object para FormSIGPRIFF
* Dialogo generico de entrada (InputBox) com TextBox ou ComboBox
* Migrado de SIGPRIFF.SCX (form1 - dialogo utilitario sem tabela)
*==============================================================================
DEFINE CLASS SIGPRIFFBO AS BusinessBase

    *-- Parametros do dialogo
    this_cCabecalho = ""
    this_cTipo      = ""
    this_cTitulo    = ""
    this_nMaximo    = 0
    this_nMinimo    = 0
    this_cDado      = ""

    *-- Resposta do usuario
    this_cResposta  = ""

    *-- Sem tabela no banco (dialogo utilitario)
    this_cTabela     = ""
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cCabecalho = ""
        THIS.this_cTipo      = ""
        THIS.this_cTitulo    = ""
        THIS.this_nMaximo    = 0
        THIS.this_nMinimo    = 0
        THIS.this_cDado      = ""
        THIS.this_cResposta  = ""

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarDialogo(par_cCabecalho, par_cTipo, par_cTitulo, ;
                                 par_nMaximo, par_nMinimo, par_cDado)
    *--------------------------------------------------------------------------
        THIS.this_cCabecalho = IIF(VARTYPE(par_cCabecalho) = "C", par_cCabecalho, "")
        THIS.this_cTipo      = IIF(VARTYPE(par_cTipo)      = "C", par_cTipo,      "")
        THIS.this_cTitulo    = IIF(VARTYPE(par_cTitulo)    = "C", par_cTitulo,    "")
        THIS.this_nMaximo    = IIF(VARTYPE(par_nMaximo)    = "N", par_nMaximo,    0)
        THIS.this_nMinimo    = IIF(VARTYPE(par_nMinimo)    = "N", par_nMinimo,    0)
        THIS.this_cDado      = IIF(VARTYPE(par_cDado)      = "C", par_cDado,      "")
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterOpcoes()
    *--------------------------------------------------------------------------
        LOCAL loc_aOpcoes[1], loc_nRep, loc_i, loc_cCab
        loc_cCab  = THIS.this_cCabecalho
        loc_nRep  = OCCURS(";", loc_cCab)

        IF loc_nRep = 0
            DIMENSION loc_aOpcoes[1]
            loc_aOpcoes[1] = loc_cCab
            RETURN loc_aOpcoes
        ENDIF

        DIMENSION loc_aOpcoes[loc_nRep]
        FOR loc_i = 1 TO loc_nRep
            loc_aOpcoes[loc_i] = SUBSTR(loc_cCab, ;
                IIF(loc_i = 1, 1, AT(";", loc_cCab, loc_i - 1) + 1), ;
                AT(";", loc_cCab, loc_i) - IIF(loc_i = 1, 0, AT(";", loc_cCab, loc_i - 1)) - 1)
        ENDFOR

        RETURN loc_aOpcoes
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION ObterMaxLength()
    *--------------------------------------------------------------------------
        IF THIS.this_nMaximo < THIS.this_nMinimo
            RETURN THIS.this_nMinimo
        ENDIF
        RETURN THIS.this_nMaximo
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cResposta
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *--------------------------------------------------------------------------
        LOCAL loc_lValido, loc_nValor
        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF THIS.this_cTipo # "M"
            IF THIS.this_cDado = "V"
                loc_nValor = VAL(TRANSFORM(THIS.this_cResposta))
                IF THIS.this_nMinimo > 0 AND loc_nValor < THIS.this_nMinimo
                    THIS.this_cMensagemErro = "Valor deve ser maior ou igual a " + TRANSFORM(THIS.this_nMinimo)
                    loc_lValido = .F.
                ENDIF
                IF loc_lValido AND THIS.this_nMaximo > 0 AND loc_nValor > THIS.this_nMaximo
                    THIS.this_cMensagemErro = "Valor deve ser menor ou igual a " + TRANSFORM(THIS.this_nMaximo)
                    loc_lValido = .F.
                ENDIF
            ELSE
                IF THIS.this_cDado # "D"
                IF THIS.this_nMinimo > 0 AND LEN(ALLTRIM(THIS.this_cResposta)) < THIS.this_nMinimo
                    THIS.this_cMensagemErro = "Informe ao menos " + TRANSFORM(THIS.this_nMinimo) + " caracteres."
                    loc_lValido = .F.
                ENDIF
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        *-- Dialogo utilitario sem tabela - sem mapeamento de cursor
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        *-- Dialogo utilitario sem persistencia em banco - apenas valida resposta
        IF !THIS.ValidarDados()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        *-- Dialogo utilitario sem persistencia em banco - apenas valida resposta
        IF !THIS.ValidarDados()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CapturarRespostaTexto(par_cValor)
    *--------------------------------------------------------------------------
        IF VARTYPE(par_cValor) = "C"
            THIS.this_cResposta = par_cValor
        ELSE
            IF VARTYPE(par_cValor) = "N"
            THIS.this_cResposta = TRANSFORM(par_cValor)
        ELSE
            IF VARTYPE(par_cValor) = "D"
            THIS.this_cResposta = DTOC(par_cValor)
        ELSE
            THIS.this_cResposta = ""
            ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CapturarRespostaCombo(par_cValor)
    *--------------------------------------------------------------------------
        THIS.this_cResposta = IIF(VARTYPE(par_cValor) = "C" AND !EMPTY(par_cValor), ;
                                  SUBSTR(par_cValor, 1, 1), "")
    ENDPROC

ENDDEFINE
