*====================================================================
* SigMvMenBO.prg
*
* Business Object para o dialogo "Mensagem da Movimentacao"
* Formulario legado: SIGPDMEN (SigMvMen.scx)
*
* O legado abre este popup a partir da tela de Movimentacao passando
* o codigo da operacao (pDopes) e exibe o texto configurado para essa
* operacao. O campo memo Mensagem NAO pertence a SigOpCdd (tabela que
* o Init legado consulta via CursorQuery, sem nunca ler o resultado) e
* sim a SigOpCdI - mesma chave Dopes, coluna mensagem (text). E dali
* que o BO busca o texto (docs/schema.sql: dbo.SigOpCdi.mensagem).
*
* Tabela: SigOpCdI
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigMvMenBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigOpCdI)
    this_cDopes    = ""    && dopes char(20) - PK (codigo da operacao)
    this_cMensagem = ""    && mensagem text

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpCdI"
            THIS.this_cCampoChave = "dopes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigMvMenBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia as colunas do cursor para as propriedades
    *====================================================================
    * O 2o argumento de TratarNulo eh o VALOR PADRAO, nao um codigo de tipo:
    * FUNCTION TratarNulo(puValor, puPadrao) / IF ISNULL(puValor) ... /
    * RETURN puPadrao (utils\functions.prg). Passar "C" faz a coluna NULL
    * virar a STRING "C" - e mensagem eh text NULL em todas as 38 linhas de
    * SigOpCdI neste banco, entao o painel do dialogo exibia a letra "C" em
    * vez de ficar em branco (medido em 2026-09-25,
    * tasks\task573\logs\diag_db2.txt). O legado faz Nvl(...,[]) - branco.
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDopes    = TratarNulo(dopes, "")
            THIS.this_cMensagem = TratarNulo(mensagem, "")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Busca em SigOpCdI a mensagem configurada para a
    * operacao informada (equivalente funcional ao que o legado tentava
    * fazer lendo CrSigOpCdI - ver comentario no cabecalho do arquivo).
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(par_cDopes, "")))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_SigMvMen")
            USE IN cursor_4c_SigMvMen
        ENDIF

        loc_cSQL = "SELECT dopes, mensagem FROM SigOpCdI WHERE dopes = " + ;
            EscaparSQL(PADR(ALLTRIM(par_cDopes), 20))

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvMen")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_SigMvMen") > 0
                    THIS.CarregarDoCursor("cursor_4c_SigMvMen")
                ELSE
                    * Operacao sem registro de configuracao em SigOpCdI: o legado
                    * exibia a mensagem em branco (Nvl(...,[])) - reproduzir aqui.
                    THIS.this_cDopes    = ALLTRIM(par_cDopes)
                    THIS.this_cMensagem = ""
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar mensagem da opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED("cursor_4c_SigMvMen")
            USE IN cursor_4c_SigMvMen
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterChavePrimaria - Chave do registro atual (para auditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cDopes, ""))
    ENDPROC

    *====================================================================
    * Inserir / Atualizar - retornam .F. de proposito: este BO/form
    * so grava atraves deles quando alguem chamar Salvar(), o que
    * nunca acontece neste dialogo somente-leitura.
    *
    * O legado (SIGPDMEN) e um dialogo somente-leitura: getMemo tem
    * ReadOnly = .T. e o unico botao ("Ok") apenas fecha a tela - nao
    * existe Salvar. SigOpCdI e o registro MESTRE de configuracao da
    * Operacao (mais de 140 colunas NOT NULL alem de "mensagem"),
    * mantido pelo cadastro de Operacoes; implementar INSERT/UPDATE
    * aqui exigiria inventar valores para colunas que esta tela nunca
    * exibe, arriscando sobrescrever configuracao real (Pilar 2).
    * BusinessBase.Salvar() nunca eh chamado por este BO/form.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Este di" + CHR(225) + "logo n" + CHR(227) + "o grava dados"
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Este di" + CHR(225) + "logo n" + CHR(227) + "o grava dados"
        RETURN .F.
    ENDPROC

ENDDEFINE
