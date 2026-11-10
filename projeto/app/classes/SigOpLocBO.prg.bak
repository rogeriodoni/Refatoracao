*====================================================================
* SigOpLocBO.prg
*
* Business Object para FormSigOpLoc (Selecao de Ocorrencias Para
* Impressao)
* Tabela: SigOpOco
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpLocBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigOpOco)
    this_cCodigos = ""    && codigos char(10) - PK
    this_cDescrs  = ""    && descrs  char(30)
    this_cGrupos  = ""    && grupos  char(10)
    this_cContas  = ""    && contas  char(10)
    this_cDcontas = ""    && dcontas char(50)
    this_cOpers   = ""    && opers   char(2)
    this_nContabs = 0     && contabs numeric(1,0)
    this_lImps    = .F.   && imps    bit
    this_nNotas   = 0     && notas   numeric(1,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpOco"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpLocBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades desta entidade a
    * partir da linha CORRENTE do cursor par_cAliasCursor (tipicamente
    * crSigOpOco, montado pelo FORM PAI antes de abrir este dialogo de
    * selecao - o PROCEDURE Init do dump legado comeca com
    * "Select crSigOpOco", pressupondo o cursor ja aberto pelo chamador).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigos = TratarNulo(Codigos, "")
            THIS.this_cDescrs  = TratarNulo(Descrs, "")

            IF TYPE("Grupos") != "U"
                THIS.this_cGrupos = TratarNulo(Grupos, "")
            ENDIF

            IF TYPE("Contas") != "U"
                THIS.this_cContas = TratarNulo(Contas, "")
            ENDIF

            IF TYPE("Dcontas") != "U"
                THIS.this_cDcontas = TratarNulo(Dcontas, "")
            ENDIF

            IF TYPE("Opers") != "U"
                THIS.this_cOpers = TratarNulo(Opers, "")
            ENDIF

            IF TYPE("Contabs") != "U"
                THIS.this_nContabs = NVL(Contabs, 0)
            ENDIF

            IF TYPE("Imps") = "L"
                THIS.this_lImps = Imps
            ELSE
                IF VARTYPE(Imps) = "L"
                    THIS.this_lImps = Imps
                ELSE
                    THIS.this_lImps = (NVL(Imps, 0) = 1)
                ENDIF
            ENDIF

            IF TYPE("Notas") != "U"
                THIS.this_nNotas = NVL(Notas, 0)
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria da entidade (coluna Codigos)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *====================================================================
    * MarcarTodos - Marca TODAS as linhas de crSigOpOco para impressao.
    * Equivalente ao PROCEDURE Click de MarcarEmp no legado:
    *   Select crSigOpOco
    *   Replace All Imps with .t.
    *   Go Top
    *   ThisForm.GridSels.Refresh
    * (o Refresh da grade fica a cargo do Form, apos chamar este metodo)
    *====================================================================
    PROCEDURE MarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("crSigOpOco")
            SELECT crSigOpOco
            REPLACE ALL Imps WITH .T.
            GO TOP
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DesmarcarTodos - Desmarca TODAS as linhas de crSigOpOco.
    * Equivalente ao PROCEDURE Click de DesmarcarEmp no legado.
    *====================================================================
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("crSigOpOco")
            SELECT crSigOpOco
            REPLACE ALL Imps WITH .F.
            GO TOP
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AlternarSelecao - Inverte o flag Imps da linha CORRENTE de
    * crSigOpOco. Equivalente ao PROCEDURE KeyPress (Enter/Espaco) e ao
    * PROCEDURE MouseDown do Check1 no legado:
    *   m.Imps = (!SigOpOco.Imps)
    *   Select crSigOpOco
    *   Gather Memvar Fields Imps
    *====================================================================
    PROCEDURE AlternarSelecao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("crSigOpOco") AND !EOF("crSigOpOco")
            SELECT crSigOpOco
            REPLACE Imps WITH !Imps
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DECISAO DE PROJETO - BO somente-leitura, sem Inserir()/Atualizar()
    * gravando em SQL Server
    *
    * O dump do legado (tasks\task763\SigOpLoc_form_codigo_fonte.txt) nao
    * tem AddCursor nem TableUpdate em lugar nenhum. Os unicos
    * "Insert Into"/"Replace"/"Update" do form (PROCEDURE Init, Click de
    * MarcarEmp/DesmarcarEmp, KeyPress/MouseDown do Check1) tem como alvo
    * exclusivo o cursor LOCAL crSigOpOco, montado pelo FORM PAI antes de
    * abrir este dialogo de selecao. Por isso este BO NAO sobrescreve
    * Inserir() nem Atualizar() - o comportamento padrao herdado de
    * BusinessBase ja e o correto, e CarregarDoCursor() acima e a fonte
    * unica de leitura das colunas de SigOpOco quando uma linha precisa
    * ser inspecionada por codigo.
    *====================================================================

ENDDEFINE
