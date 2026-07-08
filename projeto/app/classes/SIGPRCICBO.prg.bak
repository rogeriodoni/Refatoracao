*==============================================================================
* SIGPRCICBO.prg - Business Object para Seletor de Icones de Programas
* Data: 2026-07-02
* Funcao: Dialog de escolha de icone para item de menu/programa
* Obs: Form opera na datasession do form pai (sem SQL proprio)
*==============================================================================

DEFINE CLASS SIGPRCICBO AS BusinessBase

    *-- Chave do programa passada pelo form pai (pcIdChaves no legado)
    this_cIdChaves      = ""    && pkChaves do programa (crProg1/crProg2)

    *-- Icone atualmente selecionado (barrapict no legado)
    this_cArqIcone      = ""    && nome do arquivo de icone (ex: "geral_ok_26.jpg")

    *-- Descricao do programa exibida no campo readonly
    this_cDescricao     = ""    && descricaos de crProg2

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGPRCIC"
        THIS.this_cCampoChave = "pkChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de crProg2 ou alias
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves  = TratarNulo(pkChaves,   "C")
                THIS.this_cArqIcone  = LOWER(ALLTRIM(TratarNulo(barrapict,  "C")))
                THIS.this_cDescricao = TratarNulo(descricaos, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave do programa selecionado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarIcone - Atualiza barrapict em crProg1 e crProg2 (cursor REPLACE)
    * Este form opera na datasession do form pai; nao usa SQLEXEC proprio.
    * A gravacao definitiva no SQL Server eh feita pelo form pai ao salvar.
    *--------------------------------------------------------------------------
    FUNCTION SelecionarIcone(par_cArqIcone, par_cIdChaves)
        LOCAL loc_lSucesso, loc_cIcone
        loc_lSucesso = .F.

        TRY
            loc_cIcone = LOWER(ALLTRIM(par_cArqIcone))
            IF loc_cIcone = "< nenhum >"
                loc_cIcone = ""
            ENDIF

            IF USED("crProg1") AND SEEK(par_cIdChaves, "crProg1", "pkChaves")
                SELECT crProg1
                REPLACE barrapict WITH loc_cIcone, ;
                        barraforms WITH IIF(!EMPTY(barraforms), barraforms, crProg1.programas)
            ENDIF

            IF USED("crProg2") AND SEEK(par_cIdChaves, "crProg2", "pkChaves")
                SELECT crProg2
                REPLACE barrapict WITH loc_cIcone, ;
                        barraforms WITH IIF(!EMPTY(barraforms), barraforms, crProg2.programas)
            ENDIF

            THIS.this_cArqIcone = loc_cIcone
            THIS.this_cIdChaves = par_cIdChaves
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Atribui um icone ao programa (primeira selecao)
    * Faz REPLACE em crProg1/crProg2 com o icone selecionado + audita.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cMensagemErro = "Chave do programa n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.SelecionarIcone(THIS.this_cArqIcone, THIS.this_cIdChaves)
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atribuir " + CHR(237) + "cone"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Troca o icone atribuido ao programa
    * Faz REPLACE em crProg1/crProg2 com o novo icone + audita.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cMensagemErro = "Chave do programa n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.SelecionarIcone(THIS.this_cArqIcone, THIS.this_cIdChaves)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar " + CHR(237) + "cone"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove o icone atribuido (barrapict = "")
    * Faz REPLACE em crProg1/crProg2 zerando o icone + audita.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cMensagemErro = "Chave do programa n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF USED("crProg1") AND SEEK(THIS.this_cIdChaves, "crProg1", "pkChaves")
                SELECT crProg1
                REPLACE barrapict WITH "", barraforms WITH ""
            ENDIF

            IF USED("crProg2") AND SEEK(THIS.this_cIdChaves, "crProg2", "pkChaves")
                SELECT crProg2
                REPLACE barrapict WITH "", barraforms WITH ""
            ENDIF

            THIS.this_cArqIcone = ""
            THIS.RegistrarAuditoria("DELETE")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava a alteracao de icone em LogAuditoria
    * Override: escreve com Tabela="SIGPRCIC" (form nao mapeia tabela real)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario

        loc_cChave = THIS.ObterChavePrimaria()

        IF EMPTY(loc_cChave) OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + EscaparSQL(THIS.this_cTabela) + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(loc_cChave) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", GETDATE())"

        SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarIconeAtual - Le o icone atual do cursor crProg2 para o par_cIdChaves
    *--------------------------------------------------------------------------
    FUNCTION BuscarIconeAtual(par_cIdChaves)
        LOCAL loc_cIcone
        loc_cIcone = ""

        TRY
            IF USED("crProg2") AND SEEK(par_cIdChaves, "crProg2", "pkChaves")
                IF !EMPTY(crProg2.barrapict)
                    loc_cIcone = PADR(LOWER(ALLTRIM(crProg2.barrapict)), 64)
                ENDIF
                THIS.this_cDescricao = TratarNulo(crProg2.descricaos, "C")
            ENDIF

            IF EMPTY(loc_cIcone) AND !EMPTY(par_cIdChaves)
                loc_cIcone = PADR(LOWER(ALLTRIM(JUSTFNAME(par_cIdChaves))), 64)
            ENDIF

            THIS.this_cArqIcone = loc_cIcone
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cIcone
    ENDPROC

ENDDEFINE
