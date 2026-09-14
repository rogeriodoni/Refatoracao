*==============================================================================
* SIGPRALEBO.prg - Business Object para FormSIGPRALE
* Dialogo de progresso/aguarde exibido durante processamentos
*==============================================================================
DEFINE CLASS SIGPRALEBO AS BusinessBase

    *-- Parametros do dialogo
    this_cBitmap    = ""    && Caminho da imagem a exibir
    this_cMensagem1 = ""    && Linha 1 da mensagem (caption "Aguarde...")
    this_cMensagem2 = ""    && Linha 2 da mensagem
    this_cMensagem3 = ""    && Linha 3 da mensagem

    *--------------------------------------------------------------------------
    * Init - Configura BO (sem tabela - form nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega parametros de exibicao a partir de cursor
    * Form nao possui campos persistidos; cursor apenas transporta parametros
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF TYPE("cBitmap") = "C"
                    THIS.this_cBitmap    = TratarNulo(cBitmap,    "C")
                ENDIF
                IF TYPE("cMensagem1") = "C"
                    THIS.this_cMensagem1 = TratarNulo(cMensagem1, "C")
                ENDIF
                IF TYPE("cMensagem2") = "C"
                    THIS.this_cMensagem2 = TratarNulo(cMensagem2, "C")
                ENDIF
                IF TYPE("cMensagem3") = "C"
                    THIS.this_cMensagem3 = TratarNulo(cMensagem3, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form nao possui tabela nem chave primaria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Dialogo nao-persistente (apenas exibe parametros ao usuario)
    * Retorna .T. porque nao ha tabela para persistir dados
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            IF !EMPTY(THIS.this_cTabela)
                loc_lSucesso = DODEFAULT()

                IF loc_lSucesso
                    THIS.RegistrarAuditoria("I")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Dialogo nao-persistente (apenas exibe parametros ao usuario)
    * Retorna .T. porque nao ha tabela para persistir dados
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        TRY
            IF !EMPTY(THIS.this_cTabela)
                loc_lSucesso = DODEFAULT()

                IF loc_lSucesso
                    THIS.RegistrarAuditoria("A")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Dialogo nao-persistente (nao ha registros para excluir)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Sem tabela, sem auditoria (nao-op)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        IF !EMPTY(THIS.this_cTabela)
            DODEFAULT(par_cOperacao)
        ENDIF
    ENDPROC

ENDDEFINE
