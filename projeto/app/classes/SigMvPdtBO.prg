*====================================================================
* SigMvPdtBO.prg
*
* Business Object para o form OPERACIONAL SigMvPdt ("Aguarde Processando
* Dados") - dialogo intermediario que consulta a operacao em SigCdOpd
* (chave Dopps) e despacha para o form de movimentacao SigPdMp6.
* Tabela de consulta: SigCdOpd (chave Dopps)
* Herda de: BusinessBase
*
* PILAR 3: o legado usa um objeto "PoDataMgr6" (fSqlConector) criado no
* Init do form para rodar CursorQuery. A nova arquitetura NAO replica
* esse padrao - o BO acessa o SQL Server diretamente via SQLEXEC, entao
* a propriedade "podatamgr6" do legado foi OMITIDA de proposito (mesma
* decisao ja adotada em sigmvitnBO).
*====================================================================

DEFINE CLASS SigMvPdtBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para parametros/consulta do form legado)
    this_cDope  = ""     && pDope  - Dopps char(20), codigo da operacao/documento (chave de filtro em SigCdOpd)
    this_cTipo  = " "    && pTipo  - Tipos do chamador (' ' = padrao, 'C' = Contas a Pagar/Receber)
    this_nNume  = 0      && pNume  - Numero do documento (preenchido apenas quando this_cTipo = "C")
    this_cEmp   = ""     && pEmp   - Codigo da empresa (preenchido apenas quando this_cTipo = "C")
    this_lPccs  = .F.    && Pccs bit NOT NULL - retornado pela consulta em SigCdOpd para a operacao corrente
    this_lErro  = .F.    && Erro  - flag de erro do processamento (equivalente a ThisForm.Erro no legado)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT("SigCdOpd")
            THIS.this_cTabela     = "SigCdOpd"
            THIS.this_cCampoChave = "Dopps"

            THIS.this_cDope = ""
            THIS.this_cTipo = " "
            THIS.this_nNume = 0
            THIS.this_cEmp  = ""
            THIS.this_lPccs = .F.
            THIS.this_lErro = .F.

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigMvPdtBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia as colunas retornadas pela consulta em
    * SigCdOpd (Dopps, Pccs) para as propriedades do BO. Espelha
    * exatamente as duas colunas que o legado pedia no CursorQuery
    * ('SigCdOpd','CrSigCdOpd','Dopps',Upper(pDope),[Dopps,Pccs]) -
    * o restante das 230+ colunas NOT NULL de SigCdOpd nunca era lido
    * por este dialogo. SEMPRE SELECT (par_cAliasCursor) antes de
    * acessar os campos (regra #8/CLAUDE.md).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cDope = TratarNulo(Dopps, "")

            *-- Pccs (bit) chega como Logico ou Numerico conforme o driver
            *-- (CLAUDE.md regra #13) - testar VARTYPE antes de comparar.
            IF VARTYPE(Pccs) = "L"
                THIS.this_lPccs = Pccs
            ELSE
                THIS.this_lPccs = (NVL(Pccs, 0) = 1)
            ENDIF

            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *====================================================================
    * BuscarOperacao - Equivalente funcional ao
    * ThisForm.Podatamgr6.cursorquery('SigCdOpd','CrSigCdOpd','Dopps',
    * Upper(ThisForm.pDope),[Dopps,Pccs]) do legado: consulta SigCdOpd
    * pela chave Dopps e traz apenas Dopps/Pccs, que sao os dois valores
    * usados pelo PROCEDURE Processo.Click para decidir qual variante de
    * SigPdMp6 abrir.
    *====================================================================
    FUNCTION BuscarOperacao(par_cDope)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(par_cDope, "")))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_SigMvPdt")
            USE IN cursor_4c_SigMvPdt
        ENDIF

        loc_cSQL = "SELECT Dopps, Pccs FROM SigCdOpd WHERE Dopps = " + ;
            EscaparSQL(UPPER(PADR(ALLTRIM(par_cDope), 20)))

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvPdt")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_SigMvPdt") > 0
                    THIS.CarregarDoCursor("cursor_4c_SigMvPdt")
                ELSE
                    *-- Operacao nao cadastrada em SigCdOpd: sem registro para ler
                    *-- Pccs, mantem o codigo digitado e assume Pccs = .F.
                    THIS.this_cDope = UPPER(ALLTRIM(par_cDope))
                    THIS.this_lPccs = .F.
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED("cursor_4c_SigMvPdt")
            USE IN cursor_4c_SigMvPdt
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterChavePrimaria - Chave do registro atual (para auditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cDope, ""))
    ENDPROC

    *====================================================================
    * Inserir / Atualizar - retornam .F. de proposito: este BO/form so
    * grava atraves deles quando alguem chamar Salvar(), o que nunca
    * acontece neste dialogo.
    *
    * O legado (SIGMVPDT) e um dialogo intermediario "Aguarde Processando
    * Dados": consulta SigCdOpd so para ler Dopps/Pccs e despacha para
    * SigPdMp6 (DO FORM). Nao ha Salvar/Confirmar - o unico controle e o
    * botao Processo, que dispara a consulta e a navegacao. SigCdOpd e o
    * registro MESTRE de configuracao da Operacao (230+ colunas NOT NULL
    * alem de Dopps/Pccs), mantido pelo cadastro de Operacoes; implementar
    * INSERT/UPDATE aqui exigiria inventar valores para colunas que esta
    * tela nunca exibe, arriscando sobrescrever configuracao real (Pilar 2).
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
