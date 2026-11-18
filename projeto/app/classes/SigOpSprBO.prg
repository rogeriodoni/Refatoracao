*==============================================================================
* SigOpSprBO.prg - Business Object para "Selecionar Produtos" (SIGOPSPR)
*
* Origem legado : SigOpSpr.SCX  (tasks\task805)
* Tipo de form  : OPERACIONAL (dialogo FILHO, chamado pelo form pai)
* Tabela base   : SigCdPro | PK: CPros
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo filho que monta a lista de produtos do form pai (o legado recebe
* "poForm" no Init, troca para a DataSession do pai e manipula o cursor
* LOCAL "crProdutos", que pertence ao pai - no migrado esse alias fica em
* THIS.this_cCursorProdutos). O usuario pode:
*   1) Inserir/Excluir linhas na grade e digitar o produto (lookup em
*      SigCdPro por CPros ou por DPros - fwBuscaExt do legado);
*   2) Processar em LOTE (tres botoes, so quando o pai eh o SIGCDBAL e
*      pcEscolha esta em INSERIR/ALTERAR):
*        Value = 1 "Produtos com Mov."  -> SigMvItn
*        Value = 2 "Produtos nao Inv."  -> SigMvEst com SQtds <> 0
*        Value = 3 "Todos nao Inv."     -> SigCdPro
*      Os tres excluem o que ja foi inventariado em SigPrIvl desde a data de
*      corte (Date() - Dias) e aplicam as faixas de filtro herdadas do pai
*      (loFil: Mercs / CGrus / SGrus / Colecoes / Linhas / IFors).
*
* GRAVACAO
* --------
* Toda escrita do legado tem por destino o CURSOR LOCAL do form pai
* (Append Blank / Insert Into crProdutos From Memvar / Delete In crProdutos);
* o acesso ao SQL Server eh 100% de leitura (Select). Por isso este BO NAO
* sobrescreve Inserir() / Atualizar() / ExecutarExclusao(): o comportamento
* padrao herdado de BusinessBase ja eh o correto, e inventar INSERT/UPDATE
* aqui violaria a regra #22 (a lista de colunas vem do schema, nunca de
* adivinhacao).
*
* METODOS DE DADOS (equivalentes a CRUD para este form de leitura)
* ------------------------------------------------------------------
*   CarregarDoCursor(par_cAliasCursor) - mapeia CPros/DPros de uma linha de
*       lookup para this_cCPros/this_cDPros.
*   MontarFiltroFaixas()               - helper PROTECTED: monta o lcWhe do
*       legado a partir das faixas herdadas do pai.
*   ObterProdutosEmLote(par_nOpcao)    - equivalente ao cmdProcessar.Click
*       (as 3 consultas SigMvItn/SigMvEst/SigCdPro). O Form faz o SCAN e o
*       Insert Into no cursor local do pai (manipulacao de cursor VFP, fora
*       deste BO).
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas em MaxLength e LEFT()
* -------------------------------------------------------------------
*   SigCdPro.CPros    char(14)   SigCdPro.Mercs    char(3)
*   SigCdPro.DPros    char(65)   SigCdPro.CGrus    char(3)
*   SigMvItn.Emps     char(3)    SigCdPro.SGrus    char(6)
*   SigMvEst.Emps     char(3)    SigCdPro.Colecoes char(10)
*   SigPrIvl.Emps     char(3)    SigCdPro.Linhas   char(10)
*   SigPrIvl.DtHrs    datetime   SigCdPro.IFors    char(10)
*   SigMvEst.SQtds    numeric(11,3)
*==============================================================================

DEFINE CLASS SigOpSprBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - linha de produto selecionado
    * (colunas do cursor de produtos do form pai, espelhando SigCdPro)
    *--------------------------------------------------------------------------
    this_cCPros              = ""      && CPros char(14) - codigo do produto
    this_cDPros              = ""      && DPros char(65) - descricao do produto

    *--------------------------------------------------------------------------
    * CONTEXTO HERDADO DO FORM PAI
    * Legado: ThisForm.ParentForm.<x> / Set DataSession To poForm.DataSessionId
    *--------------------------------------------------------------------------
    this_cEscolha            = ""      && pcEscolha do pai: INSERIR / ALTERAR / PROCURAR
    this_cNomeFormPai        = ""      && Upper(ParentForm.Name) - lote so quando "SIGCDBAL"
    this_nDataSessionPai     = 0       && DataSessionId do pai (poForm.DataSessionId)
    this_cEmps               = ""      && Emps char(3) - empresa corrente (go_4c_Sistema.cCodEmpresa do legado)

    *--------------------------------------------------------------------------
    * PARAMETROS DO PROCESSAMENTO EM LOTE (cmdProcessar)
    *--------------------------------------------------------------------------
    this_nOpcaoProcessamento = 0       && 1=SigMvItn  2=SigMvEst  3=SigCdPro
    this_nDias               = 0       && getDias.Value - numeric(4), InputMask "9999"
    this_dDataCorte          = {}      && Date() - Dias  (pDat do legado, via fDtoSQL)
    this_nQtdSelecionados    = 0       && lnCnt - produtos efetivamente incluidos
    this_nMaxRegistrosBusca  = 1000    && limite do fwBuscaExt legado (ultimo argumento)

    *--------------------------------------------------------------------------
    * FAIXAS DE FILTRO HERDADAS DO PAI (ParentForm.loFil)
    * Cada par monta "And p.<col> >= 'I'" / "And p.<col> <= 'F'" somente quando
    * nao esta vazio - exatamente como o legado monta lcWhe.
    *--------------------------------------------------------------------------
    this_cMercsI             = ""      && Mercs    char(3)  - inicial
    this_cMercsF             = ""      && Mercs    char(3)  - final
    this_cCGrusI             = ""      && CGrus    char(3)  - inicial
    this_cCGrusF             = ""      && CGrus    char(3)  - final
    this_cSGrusI             = ""      && SGrus    char(6)  - inicial
    this_cSGrusF             = ""      && SGrus    char(6)  - final
    this_cColecoesI          = ""      && Colecoes char(10) - inicial
    this_cColecoesF          = ""      && Colecoes char(10) - final
    this_cLinhasI            = ""      && Linhas   char(10) - inicial
    this_cLinhasF            = ""      && Linhas   char(10) - final
    this_cIForsI             = ""      && IFors    char(10) - inicial
    this_cIForsF             = ""      && IFors    char(10) - final

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR
    * (nomes do legado entre parenteses - PILAR 3 manda renomear)
    *--------------------------------------------------------------------------
    this_cCursorProdutos     = "cursor_4c_Produtos"       && crProdutos    - cursor do PAI, editado pela grade
    this_cCursorProcessa     = "cursor_4c_ProdProcessa"   && LocalCPros    - resultado do SELECT em lote
    this_cCursorBrancos      = "cursor_4c_LinhasBrancas"  && LocalBrancos  - linhas com CPros vazio
    this_cCursorBusca        = "cursor_4c_BuscaProduto"   && crListaRemota - lookup de SigCdPro

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO
    * Legado: propriedades customizadas lhouveins / lhouveexcl do SIGOPSPR
    *--------------------------------------------------------------------------
    this_lHouveInclusao      = .F.     && lhouveins  - houve inclusao de linha
    this_lHouveExclusao      = .F.     && lhouveexcl - houve exclusao de linha

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de leitura (SigCdPro.CPros), herda a empresa
    * corrente (o _Empr do legado) e repoe os valores iniciais que o legado
    * tem no proprio SCX: getDias.Value = 0 e cmdProcessar.Value = 0.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"

        *-- Empresa corrente: o legado usa a PUBLIC _Empr; no sistema novo o
        *-- equivalente eh go_4c_Sistema.cCodEmpresa (ver CLAUDE.md).
        IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
            THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ELSE
            THIS.this_cEmps = ""
        ENDIF

        *-- Valores iniciais identicos aos do SCX legado
        THIS.this_nDias               = 0
        THIS.this_nOpcaoProcessamento = 0
        THIS.this_nQtdSelecionados    = 0
        THIS.this_dDataCorte          = DATE()
        THIS.this_lHouveInclusao      = .F.
        THIS.this_lHouveExclusao      = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCPros
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia as colunas de uma linha de SigCdPro (CPros,
    * DPros) para as propriedades do BO. Usado depois de um SELECT de
    * verificacao/lookup (ex.: cursor_4c_BuscaProduto) para o Form ler o
    * produto corrente sem acessar o cursor diretamente.
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCPros = TratarNulo(CPros, "C")
            THIS.this_cDPros = TratarNulo(DPros, "C")
            RETURN .T.
        ENDIF

        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarFiltroFaixas - Monta o trecho "AND p.<col> >= '..' AND p.<col>
    * <= '..'" a partir das faixas herdadas do pai (loFil do legado),
    * exatamente como o cmdProcessar.Click monta lcWhe: cada faixa so entra
    * quando NAO esta vazia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarFiltroFaixas()
        LOCAL loc_cWhe
        loc_cWhe = ""

        IF !EMPTY(THIS.this_cMercsI)
            loc_cWhe = loc_cWhe + " AND p.Mercs >= " + EscaparSQL(ALLTRIM(THIS.this_cMercsI))
        ENDIF
        IF !EMPTY(THIS.this_cMercsF)
            loc_cWhe = loc_cWhe + " AND p.Mercs <= " + EscaparSQL(ALLTRIM(THIS.this_cMercsF))
        ENDIF
        IF !EMPTY(THIS.this_cCGrusI)
            loc_cWhe = loc_cWhe + " AND p.CGrus >= " + EscaparSQL(ALLTRIM(THIS.this_cCGrusI))
        ENDIF
        IF !EMPTY(THIS.this_cCGrusF)
            loc_cWhe = loc_cWhe + " AND p.CGrus <= " + EscaparSQL(ALLTRIM(THIS.this_cCGrusF))
        ENDIF
        IF !EMPTY(THIS.this_cSGrusI)
            loc_cWhe = loc_cWhe + " AND p.SGrus >= " + EscaparSQL(ALLTRIM(THIS.this_cSGrusI))
        ENDIF
        IF !EMPTY(THIS.this_cSGrusF)
            loc_cWhe = loc_cWhe + " AND p.SGrus <= " + EscaparSQL(ALLTRIM(THIS.this_cSGrusF))
        ENDIF
        IF !EMPTY(THIS.this_cColecoesI)
            loc_cWhe = loc_cWhe + " AND p.Colecoes >= " + EscaparSQL(ALLTRIM(THIS.this_cColecoesI))
        ENDIF
        IF !EMPTY(THIS.this_cColecoesF)
            loc_cWhe = loc_cWhe + " AND p.Colecoes <= " + EscaparSQL(ALLTRIM(THIS.this_cColecoesF))
        ENDIF
        IF !EMPTY(THIS.this_cLinhasI)
            loc_cWhe = loc_cWhe + " AND p.Linhas >= " + EscaparSQL(ALLTRIM(THIS.this_cLinhasI))
        ENDIF
        IF !EMPTY(THIS.this_cLinhasF)
            loc_cWhe = loc_cWhe + " AND p.Linhas <= " + EscaparSQL(ALLTRIM(THIS.this_cLinhasF))
        ENDIF
        IF !EMPTY(THIS.this_cIForsI)
            loc_cWhe = loc_cWhe + " AND p.IFors >= " + EscaparSQL(ALLTRIM(THIS.this_cIForsI))
        ENDIF
        IF !EMPTY(THIS.this_cIForsF)
            loc_cWhe = loc_cWhe + " AND p.IFors <= " + EscaparSQL(ALLTRIM(THIS.this_cIForsF))
        ENDIF

        RETURN loc_cWhe
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterProdutosEmLote - Equivalente ao cmdProcessar.Click do legado.
    * par_nOpcao: 1 = "Produtos com Mov." (SigMvItn)
    *             2 = "Produtos nao Inv." (SigMvEst com SQtds <> 0)
    *             3 = "Todos nao Inv."    (SigCdPro)
    * Os tres excluem o que ja foi inventariado em SigPrIvl desde a data de
    * corte (Date() - Dias) e aplicam as faixas herdadas do pai. Resultado
    * fica em THIS.this_cCursorProcessa (equivalente a LocalCPros); quem
    * chama (o Form) faz o SCAN e o Insert Into no cursor local do pai -
    * esse ultimo passo eh manipulacao de cursor VFP, nao SQL, e por isso
    * fica fora deste BO (ver cabecalho: toda escrita vai para o cursor do
    * form pai).
    *
    * Retorna o numero de linhas (>= 0) ou -1 em falha de conexao/opcao
    * invalida - igual ao "< 1" do SqlExecute legado.
    *--------------------------------------------------------------------------
    FUNCTION ObterProdutosEmLote(par_nOpcao)
        LOCAL loc_cSQL, loc_cWhe, loc_cDataCorte, loc_nResultado

        IF THIS.this_nDias < 1
            RETURN -1
        ENDIF

        THIS.this_nOpcaoProcessamento = par_nOpcao
        THIS.this_dDataCorte          = DATE() - THIS.this_nDias
        loc_cDataCorte                = FormatarDataSQL(THIS.this_dDataCorte)
        loc_cWhe                      = THIS.MontarFiltroFaixas()

        DO CASE
            CASE par_nOpcao = 1
                loc_cSQL = "SELECT DISTINCT a.CPros, p.DPros" +;
                           " FROM SigMvItn a" +;
                           " INNER JOIN SigCdPro p ON a.CPros = p.CPros" +;
                           " WHERE a.Emps = " + EscaparSQL(THIS.this_cEmps) + loc_cWhe +;
                           " AND a.CPros NOT IN (SELECT l.CPros FROM SigPrIvl l" +;
                           " WHERE l.Emps = " + EscaparSQL(THIS.this_cEmps) +;
                           " AND l.DtHrs >= " + loc_cDataCorte + ")" +;
                           " ORDER BY a.CPros"

            CASE par_nOpcao = 2
                loc_cSQL = "SELECT DISTINCT a.CPros, p.DPros" +;
                           " FROM SigMvEst a" +;
                           " INNER JOIN SigCdPro p ON a.CPros = p.CPros" +;
                           " WHERE a.Emps = " + EscaparSQL(THIS.this_cEmps) + loc_cWhe +;
                           " AND NOT a.SQtds = 0" +;
                           " AND a.CPros NOT IN (SELECT l.CPros FROM SigPrIvl l" +;
                           " WHERE l.Emps = " + EscaparSQL(THIS.this_cEmps) +;
                           " AND l.DtHrs >= " + loc_cDataCorte + ")" +;
                           " ORDER BY a.CPros"

            CASE par_nOpcao = 3
                loc_cSQL = "SELECT DISTINCT p.CPros, p.DPros" +;
                           " FROM SigCdPro p" +;
                           " WHERE p.CPros NOT IN (SELECT l.CPros FROM SigPrIvl l" +;
                           " WHERE l.Emps = " + EscaparSQL(THIS.this_cEmps) +;
                           " AND l.DtHrs >= " + loc_cDataCorte + ")" + loc_cWhe +;
                           " ORDER BY p.CPros"

            OTHERWISE
                RETURN -1
        ENDCASE

        IF USED(THIS.this_cCursorProcessa)
            USE IN (THIS.this_cCursorProcessa)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProcessa)

        RETURN loc_nResultado
    ENDFUNC

ENDDEFINE
