*------------------------------------------------------------------------------
* SigPrTarBO.prg - Business Object para FormSigPrTar
* Sub-formulario modal de visualizacao de Observacao de Inspecao
* Herda de BusinessBase
*------------------------------------------------------------------------------
DEFINE CLASS SigPrTarBO AS BusinessBase

    *-- ObsInsp do cursor csTmpPrTar compartilhado pelo form pai
    this_cObsInsp = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega ObsInsp do cursor csTmpPrTar compartilhado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cObsInsp = TratarNulo(ObsInsp, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave logica do registro visualizado
    * Retorna hash do conteudo ObsInsp (permite auditar visualizacoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        IF EMPTY(THIS.this_cObsInsp)
            loc_cChave = "SEM_OBSERVACAO"
        ELSE
            loc_cChave = LEFT(ALLTRIM(THIS.this_cObsInsp), 40)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao suportado (sub-form somente leitura)
    * O EditBox getObsInsp tem ReadOnly=.T. no SCX legado
    * A tabela real eh mantida pelo form pai via cursor csTmpPrTar compartilhado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de visualiza" + CHR(231) + CHR(227) + ;
                                  "o de observa" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o suporta inclus" + CHR(227) + "o. As altera" + CHR(231) + ;
                                  CHR(245) + "es s" + CHR(227) + "o feitas no formul" + CHR(225) + "rio principal."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao suportado (sub-form somente leitura)
    * O EditBox getObsInsp tem ReadOnly=.T. no SCX legado
    * A tabela real eh mantida pelo form pai via cursor csTmpPrTar compartilhado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de visualiza" + CHR(231) + CHR(227) + ;
                                  "o de observa" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o suporta altera" + CHR(231) + CHR(227) + "o. As altera" + CHR(231) + ;
                                  CHR(245) + "es s" + CHR(227) + "o feitas no formul" + CHR(225) + "rio principal."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra evento de visualizacao de observacao
    * Override do BusinessBase: usa nome logico "SigPrTar" na coluna Tabela
    * (o BO nao tem tabela fisica dedicada; audita a acao do sub-form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_nResultado

        loc_cChave = THIS.ObterChavePrimaria()

        IF EMPTY(loc_cChave)
            RETURN .F.
        ENDIF

        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + ;
                   EscaparSQL("SigPrTar") + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(loc_cChave) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", " + ;
                   "GETDATE())"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        RETURN (loc_nResultado >= 0)
    ENDPROC

ENDDEFINE
