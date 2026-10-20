*============================================================================
* SigOpAtuBO.prg - Business Object para o dialogo "Operacao para Atualizacao"
*
* Tabela principal : SigCdOpe  (PK: dopes char(20) - coluna unica, codigo
*                     e descricao ao mesmo tempo - regra CLAUDE.md
*                     "SigCdOpe eh single-column")
*
* Este BO suporta um dialogo OPERACIONAL simples (SIGOPATU no legado): o
* usuario informa/seleciona o codigo de uma Operacao de Estoque ja
* cadastrada em SigCdOpe e confirma. Nao ha INSERT/UPDATE/DELETE no legado -
* o unico codigo-fonte do dialogo (Comando1.Click e DopEstq.Valid, ver
* tasks\task643\comportamento.json) apenas valida o valor digitado contra o
* cursor CrOpera (Seek) e, se nao encontrar, abre o picker (fwBuscaInt) para
* escolha; o botao "Ok" so confere que o campo nao esta vazio e libera o
* form. Nao ha AddCursor nem TABLEUPDATE: SigCdOpe eh consultada, nunca
* gravada, por esta tela.
*
* Fase 2/8: Inserir() e Atualizar() permanecem SEM override - o
* comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh o
* correto para este BO, porque inventar um INSERT/UPDATE em SigCdOpe aqui
* violaria a regra de que a lista de colunas vem do schema/legado, nunca de
* suposicao, e este dialogo nunca grava naquela tabela.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - CarregarDoCursor() e ObterChavePrimaria()
*============================================================================

DEFINE CLASS SigOpAtuBO AS BusinessBase

    *==========================================================================
    * Propriedade da entidade SigCdOpe (chave e descricao, na mesma coluna)
    *==========================================================================
    this_cDopEstq = ""   && char(20) - Operacao de Estoque (SigCdOpe.dopes)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- A tabela TEM de ir no DODEFAULT: BusinessBase.Init() so cria
            *-- this_oDataAccess quando recebe pcTabela. Com DODEFAULT() vazio
            *-- o objeto de acesso a dados fica .NULL. e todo metodo herdado
            *-- que depende dele (Buscar) devolve .F. com "Objeto de acesso a
            *-- dados nao inicializado".
            DODEFAULT("SigCdOpe")
            THIS.this_cTabela     = "SigCdOpe"
            THIS.this_cCampoChave = "dopes"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (dopes)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopEstq)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega this_cDopEstq a partir de um cursor que
    * contenha a coluna dopes (regra CLAUDE.md #9: SELECT (par_cAliasCursor)
    * antes de acessar os campos, nunca campo)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDopEstq = TratarNulo(dopes, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExisteOperacao - Confere se o codigo informado existe em SigCdOpe.
    * Usado pelo Form (Valid/LostFocus do campo DopEstq) para reproduzir o
    * Seek(This.Value, 'CrOpera') do legado antes de abrir o picker
    * FormBuscaAuxiliar - regra CLAUDE.md "SigCdOpe eh single-column"
    * (NUNCA referenciar descrs/Descrs: dopes eh codigo E descricao).
    *==========================================================================
    FUNCTION ExisteOperacao(par_cCodigo)
        LOCAL loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        IF EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_SigOpAtu_Existe")
            USE IN cursor_4c_SigOpAtu_Existe
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
            "cursor_4c_SigOpAtu_Existe")

        IF loc_nResultado > 0
            loc_lExiste = (RECCOUNT("cursor_4c_SigOpAtu_Existe") > 0)
        ENDIF

        IF USED("cursor_4c_SigOpAtu_Existe")
            USE IN cursor_4c_SigOpAtu_Existe
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE
