*==============================================================================
* SigPrEopBO.prg - Business Object: Selecao de Operacoes
* Entidade  : SigPrEop
* Tabela    : (sem tabela propria - opera com cursores temporarios)
* Tipo      : OPERACIONAL (seletor de operacoes)
*==============================================================================
DEFINE CLASS SigPrEopBO AS BusinessBase

    *-- Operacao selecionada (linha corrente no grid)
    this_cDopes      = ""  && Codigo da operacao (20 chars)
    this_nNumes      = 0   && Numero da operacao
    this_dDatas      = {}  && Data da operacao
    this_dPrazoEnts  = {}  && Previsao de entrega
    this_cEmps       = ""  && Codigo da empresa (3 chars)
    this_cContas     = ""  && Conta / numero do pedido
    this_cRClis      = ""  && Nome do cliente
    this_cConjuges   = ""  && Operacao conjugada
    this_nSelecionada = 0  && Flag de selecao (0=nao, 1=sim)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO de Selecao de Operacoes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de linha do cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nSelecionada = NVL(Selecionada, 0)
            THIS.this_cDopes       = ALLTRIM(NVL(Dopes, ""))
            THIS.this_nNumes       = NVL(Numes, 0)
            THIS.this_dDatas       = NVL(Datas, {})
            THIS.this_dPrazoEnts   = NVL(PrazoEnts, {})
            THIS.this_cEmps        = ALLTRIM(NVL(Emps, ""))
            THIS.this_cContas      = ALLTRIM(NVL(Contas, ""))
            THIS.this_cRClis       = ALLTRIM(NVL(RClis, ""))
            THIS.this_cConjuges    = ALLTRIM(NVL(Conjuges, ""))
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarOperacoes - Cria cursor_4c_Operacoes a partir do cursor de origem
    * par_cCursorOrigem: nome do cursor com operacoes pre-carregadas (crTprMvCab)
    *--------------------------------------------------------------------------
    PROCEDURE InicializarOperacoes(par_cCursorOrigem)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            IF USED(par_cCursorOrigem)
                SELECT 1 AS Selecionada, * FROM (par_cCursorOrigem) ;
                    INTO CURSOR cursor_4c_Operacoes READWRITE
                loc_lSucesso = .T.
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Operacoes ;
                    (Selecionada N(1,0) NULL, ;
                     Emps        C(3)   NULL, ;
                     Dopes       C(20)  NULL, ;
                     Numes       N(6,0) NULL, ;
                     Datas       D      NULL, ;
                     PrazoEnts   D      NULL, ;
                     Contas      C(20)  NULL, ;
                     RClis       C(60)  NULL, ;
                     Conjuges    C(20)  NULL)
                SET NULL OFF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecao - Inverte o flag Selecionada da linha corrente do cursor
    * Equivalente ao GATHER MEMVAR do legado (Check1 KeyPress + MouseDown)
    * par_cAliasCursor: alias do cursor (padrao: cursor_4c_Operacoes)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecao(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_nNovoValor, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Operacoes", par_cAliasCursor)
        TRY
            IF USED(loc_cAlias) AND !EOF(loc_cAlias)
                SELECT (loc_cAlias)
                loc_nNovoValor = IIF(Selecionada = 0, 1, 0)
                REPLACE Selecionada WITH loc_nNovoValor
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarDesmarcarTodos - Marca ou desmarca todas as operacoes
    * par_nValor: 1 = marcar todos, 0 = desmarcar todos (equivale a ck_Marca.Click)
    * par_cAliasCursor: alias do cursor (padrao: cursor_4c_Operacoes)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarDesmarcarTodos(par_nValor, par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Operacoes", par_cAliasCursor)
        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                REPLACE ALL Selecionada WITH par_nValor
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularFilOper - Varre cursor de operacoes e popula cursor destino
    * com as operacoes selecionadas (Selecionada = 1)
    * Equivalente ao SCAN em cmdSair.Click do legado
    * par_cCursorDest  : nome do cursor destino (crFilOper no legado)
    * par_cCursorOrigem: cursor fonte (padrao: cursor_4c_Operacoes)
    * Formato de cada registro: Emps(3) + Dopes(20) + Numes(6) = 29 chars
    *--------------------------------------------------------------------------
    PROCEDURE PopularFilOper(par_cCursorDest, par_cCursorOrigem)
        LOCAL loc_lSucesso, loc_oErro, loc_cAlias, loc_cChave
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cCursorOrigem), "cursor_4c_Operacoes", par_cCursorOrigem)
        TRY
            IF USED(loc_cAlias) AND USED(par_cCursorDest)
                ZAP IN (par_cCursorDest)
                SELECT (loc_cAlias)
                GO TOP
                SCAN
                    IF Selecionada = 1
                        loc_cChave = PADR(Emps, 3) + PADR(Dopes, 20) + PADL(STR(Numes, 6), 6)
                        INSERT INTO (par_cCursorDest) VALUES (loc_cChave)
                    ENDIF
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta da operacao corrente
    * Formato: Emps(3) + Dopes(20) + Numes(6) = 29 chars
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + PADL(STR(THIS.this_nNumes, 6), 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra as operacoes selecionadas no cursor destino (crFilOper)
    * BO OPERACIONAL de selecao: nao persiste em tabela SQL Server.
    * Equivalente ao SCAN em cmdSair.Click do legado que popula crFilOper com
    * as operacoes marcadas (Selecionada = 1) e serve de filtro para o form pai.
    * Requer THIS.this_cCursorDestino previamente configurado (default: crFilOper).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cCursorDest, loc_nRegistros, loc_lContinua
        loc_lSucesso    = .F.
        loc_lContinua   = .T.
        loc_nRegistros  = 0
        loc_cCursorDest = IIF(PEMSTATUS(THIS, "this_cCursorDestino", 5) AND ;
                              !EMPTY(THIS.this_cCursorDestino), ;
                              THIS.this_cCursorDestino, "crFilOper")

        TRY
            IF !USED("cursor_4c_Operacoes")
                THIS.this_cMensagemErro = "Cursor de opera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o inicializado"
                loc_lContinua = .F.
            ENDIF

            IF loc_lContinua AND !USED(loc_cCursorDest)
                THIS.this_cMensagemErro = "Cursor destino '" + loc_cCursorDest + ;
                    "' n" + CHR(227) + "o encontrado"
                loc_lContinua = .F.
            ENDIF

            IF loc_lContinua AND !THIS.PopularFilOper(loc_cCursorDest, "cursor_4c_Operacoes")
                THIS.this_cMensagemErro = "Falha ao popular cursor destino"
                loc_lContinua = .F.
            ENDIF

            IF loc_lContinua
                SELECT (loc_cCursorDest)
                GO TOP
                COUNT TO loc_nRegistros

                IF loc_nRegistros = 0
                    THIS.this_cMensagemErro = "Nenhuma opera" + CHR(231) + CHR(227) + ;
                        "o foi selecionada"
                    loc_lContinua = .F.
                ENDIF
            ENDIF

            IF loc_lContinua
                THIS.RegistrarAuditoria("SELECT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza o estado de selecao da operacao corrente no cursor
    * BO OPERACIONAL de selecao: nao persiste em tabela SQL Server.
    * Equivalente ao GATHER MEMVAR Fields Selecionada do Check1 (KeyPress/MouseDown).
    * Usa this_nSelecionada (definido via CarregarDoCursor ou setter externo)
    * para atualizar o registro corrente do cursor de operacoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_lContinua
        loc_lSucesso  = .F.
        loc_lContinua = .T.

        TRY
            IF !USED("cursor_4c_Operacoes")
                THIS.this_cMensagemErro = "Cursor de opera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o inicializado"
                loc_lContinua = .F.
            ENDIF

            IF loc_lContinua
                SELECT cursor_4c_Operacoes
                IF EOF() OR BOF()
                    THIS.this_cMensagemErro = "Nenhuma opera" + CHR(231) + CHR(227) + ;
                        "o corrente para atualizar"
                    loc_lContinua = .F.
                ENDIF
            ENDIF

            IF loc_lContinua
                REPLACE Selecionada  WITH THIS.this_nSelecionada, ;
                        Emps         WITH THIS.this_cEmps, ;
                        Dopes        WITH THIS.this_cDopes, ;
                        Numes        WITH THIS.this_nNumes, ;
                        Datas        WITH THIS.this_dDatas, ;
                        PrazoEnts    WITH THIS.this_dPrazoEnts, ;
                        Contas       WITH THIS.this_cContas, ;
                        RClis        WITH THIS.this_cRClis, ;
                        Conjuges     WITH THIS.this_cConjuges

                THIS.RegistrarAuditoria("TOGGLE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override para BO OPERACIONAL sem tabela
    * BO de selecao opera apenas em cursores de sessao (nao persiste em tabela).
    * Nao ha registro em LogAuditoria (this_cTabela vazio inviabiliza SQL de log).
    * Metodo mantido para preservar contrato com BusinessBase.Salvar/Excluir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

ENDDEFINE
