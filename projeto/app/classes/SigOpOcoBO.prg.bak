*==============================================================================
* SigOpOcoBO.prg
*
* Business Object para FormSigOpOco (dialogo "Ocorrencia")
* Origem legado : SigOpOco.SCX  (tasks\task775\SigOpOco_form_codigo_fonte.txt)
* Tipo de form  : OPERACIONAL (dialogo FILHO, WindowType = 1 / TitleBar = 0)
* Tabela        : SigIvTrH   (historico de leitura do inventario)
* Herda de      : BusinessBase
*
*------------------------------------------------------------------------------
* CONTRATO EXTERNO - o cursor de historico eh do FORM CHAMADOR
*
* O "PROCEDURE Init" do SCX legado recebe seis parametros do chamador
*
*     LParameters lcCodBarra, oOldForm, llRepete, lcObs, lnTop, lnLeft
*
* e, sem abrir cursor nenhum, faz
*
*     Select Historico
*     Set Order To CBars
*     Set Key To lcCodBarra
*     Go Top
*
* ou seja: o alias "Historico" JA ESTA ABERTO quando o dialogo sobe. Ele eh
* montado pelo form pai SIGCDBAL (migrado como FormBAL) com
*
*     .AddCursor("SigIvTrH", "CIdChaves", "Historico", "", "", lcQryInvH)
*     lcQryInvH = Select a.*, isnull(b.cbars_old,0) as cbars_old
*                 From SigIvTrH a left join SigOpEta b on a.cbars = b.cbars_new
*                 Where a.Emps = ?_Empr And a.Codigos = ?lnCodBal
*                 Order By a.CidChaves
*
* No sistema novo esse cursor eh "cursor_4c_Historico", criado por
* FormBAL.CarregarHistorico(). Consequencias que valem para CADA metodo deste
* BO (regra #52 do CLAUDE.md e licao do FormSigOpLoc):
*
*   (a) este BO NAO abre e NAO fecha o cursor de historico - quem abriu eh o
*       chamador, e fechar aqui deixaria a grade do pai morta;
*   (b) o nome do alias chega por propriedade (this_cCursorHistorico), nunca
*       literal espalhado pelo codigo, porque o chamador pode usar outro;
*   (c) as colunas sao lidas com guarda de existencia - o SELECT do pai pode
*       nao trazer todas as colunas de SigIvTrH.
*
*------------------------------------------------------------------------------
* GRAVACAO - o legado NAO persiste neste dialogo
*
* O "Saida.Click" do SCX tem o UPDATE inteiro COMENTADO (*!*) e executa apenas
* "ThisForm.Release". A unica escrita do legado eh no CURSOR compartilhado
*
*     Replace Usuars With Usuar In Historico       && Column3.Text1.Valid
*
* Quem comita SigIvTrH eh o form pai (TABLEUPDATE sobre o cursor do AddCursor).
* Portanto este BO opera em modo leitura sobre a tabela e escreve apenas no
* cursor do chamador: o comportamento padrao herdado de BusinessBase para
* Inserir()/Atualizar()/ExecutarExclusao() (recusar a operacao e reportar pelo
* ExibirFalha do Salvar) ja eh o correto e deve ser preservado.
*
*------------------------------------------------------------------------------
* LOOKUP DE OCORRENCIAS (SigBaOco)
*
* O "Column3.Text1.Valid" do legado consulta
*
*     Select * From SigBaOco Where Tipos = "O" And Autos <> "S"
*
* indexa por Codigos/Descrs e, nao achando o valor digitado (Seek), abre o
* browse fwBuscaInt com as colunas Codigos (mascara XXXXXXXXXX) e Descrs.
* Os dois literais O e S sao REGRA DE NEGOCIO transcrita do dump
* (this_cFiltroTipos / this_cFiltroAutosExcluido) - nao sao palpite.
*==============================================================================

DEFINE CLASS SigOpOcoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da entidade - espelho das colunas de SigIvTrH
    * (tipos e tamanhos conferidos em docs\schema.sql)
    *--------------------------------------------------------------------------
    this_cCidchaves = ""        && cidchaves  char(20)      NOT NULL - PK
    this_cEmps      = ""        && emps       char(3)       NOT NULL - empresa
    this_nCodigos   = 0         && codigos    numeric(4,0)  NOT NULL - balanco
    this_nCbars     = 0         && cbars      numeric(14,0) NOT NULL - barras
    this_cCpros     = ""        && cpros      char(14)      NOT NULL - produto
    this_cCodcors   = ""        && codcors    char(4)       NOT NULL - cor
    this_cCodtams   = ""        && codtams    char(4)       NOT NULL - tamanho
    this_cContas    = ""        && contas     char(10)      NOT NULL - conta
    this_cLocalis   = ""        && localis    char(10)      NOT NULL - local lido
    this_cLocals    = ""        && locals     char(10)      NOT NULL - local
    this_nNtrans    = 0         && ntrans     numeric(6,0)  NOT NULL - transacao
    this_cOcors     = ""        && ocors      char(10)      NOT NULL - ocorrencia
    this_cObs       = ""        && obs        text          NULL     - observacao
    this_nPesreals  = 0         && pesreals   numeric(8,2)  NOT NULL - peso real
    this_nPesos     = 0         && pesos      numeric(12,3) NOT NULL - peso
    this_nQtds      = 0         && qtds       numeric(11,3) NOT NULL - quantidade
    this_nTipos     = 0         && tipos      numeric(1,0)  NOT NULL - 1=lido
    this_cColetas   = ""        && coletas    char(1)       NOT NULL - coletor
    this_cUsuars    = ""        && usuars     char(10)      NOT NULL - usuario
    this_dDatas     = {}        && datas      datetime      NULL
    this_dDatatrans = {}        && datatrans  datetime      NULL

    *-- Coluna DERIVADA do cursor do chamador (isnull(b.cbars_old,0) do
    *-- left join com SigOpEta) - nao existe em SigIvTrH, por isso nunca
    *-- entra em INSERT/UPDATE.
    this_nCbarsOld  = 0         && cbars_old  numeric(14,0) - etiqueta anterior

    *--------------------------------------------------------------------------
    * Propriedades do lookup de ocorrencias - espelho de SigBaOco
    *--------------------------------------------------------------------------
    this_cOcoCodigos = ""       && SigBaOco.codigos char(10) NOT NULL - PK
    this_cOcoDescrs  = ""       && SigBaOco.descrs  char(40) NOT NULL
    this_cOcoTipos   = ""       && SigBaOco.tipos   char(1)  NOT NULL
    this_cOcoAutos   = ""       && SigBaOco.autos   char(1)  NOT NULL
    this_cOcoGrupos  = ""       && SigBaOco.grupos  char(10) NOT NULL
    this_cOcoOpers   = ""       && SigBaOco.opers   char(2)  NOT NULL
    this_cOcoApuras  = ""       && SigBaOco.apuras  char(1)  NOT NULL
    this_cOcoLancas  = ""       && SigBaOco.lancas  char(1)  NOT NULL

    *--------------------------------------------------------------------------
    * Filtro do lookup - TRANSCRITO do Column3.Text1.Valid do legado:
    *   Select * From SigBaOco Where Tipos = "O" And Autos <> "S"
    * Os dois literais sao regra de negocio: Tipos = O seleciona as linhas de
    * Ocorrencia (e nao as de apuracao) e Autos = S seria lancamento
    * automatico, que o usuario nao pode escolher a mao.
    *--------------------------------------------------------------------------
    this_cFiltroTipos         = "O"
    this_cFiltroAutosExcluido = "S"

    *--------------------------------------------------------------------------
    * Estado recebido do form CHAMADOR
    * (LParameters lcCodBarra, oOldForm, llRepete, lcObs, lnTop, lnLeft)
    *--------------------------------------------------------------------------
    this_nCodBarra     = 0      && lcCodBarra - Set Key To do alias Historico
    this_oFormChamador = .NULL. && oOldForm   - ThisForm.ParentForm do legado
    this_lRepeteObs    = .F.    && llRepete   - Chk_RepeteObs.Value do pai
    this_cObservas     = ""     && lcObs      - ThisForm.Observas / ObsAnterior
    this_nTopChamador  = 0      && lnTop      - usado em Top  = lnTop + 22
    this_nLeftChamador = 0      && lnLeft     - o legado usa lnTop + 390 aqui

    *--------------------------------------------------------------------------
    * Aliases dos cursores (nunca literais espalhados pelo codigo)
    *--------------------------------------------------------------------------
    this_cCursorHistorico   = "cursor_4c_Historico"    && do CHAMADOR, SigIvTrH
    this_cCursorOcorrencias = "cursor_4c_Ocorrencias"  && CsOcorr do legado
    this_cCursorBusca       = "cursor_4c_BuscaOco"     && picker de ocorrencia

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Nao abre conexao, nao consulta o banco e nao toca no cursor do chamador:
    * o alias de historico ainda pode nao estar aberto quando o BO eh criado
    * (harness de teste), e Init que devolve .F. MATA o form.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            *-- Nomes CORRETOS das propriedades herdadas de BusinessBase
            THIS.this_cTabela     = "SigIvTrH"
            THIS.this_cCampoChave = "cidchaves"

            *-- Usuario logado: o legado faz "Replace Usuars With Usuar"
            *-- usando a PUBLIC global Usuar do Framework Fortyus, que no
            *-- sistema novo eh gc_4c_UsuarioLogado.
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            *-- Empresa corrente (SigIvTrH.emps char(3)); _EMPR do legado
            IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                IF PEMSTATUS(go_4c_Sistema, "cCodEmpresa", 5)
                    THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SigOpOcoBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave primaria da entidade (coluna cidchaves)
    * Usada por RegistrarAuditoria de BusinessBase.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades desta entidade a partir da
    * linha CORRENTE do cursor par_cAliasCursor (tipicamente
    * this_cCursorHistorico = "cursor_4c_Historico", o alias "Historico" do
    * legado, aberto e populado pelo FORM PAI - ver contrato no cabecalho
    * deste arquivo). Cada coluna eh lida com guarda de existencia (TYPE()
    * != "U") porque o SELECT do pai pode nao trazer todas as colunas de
    * SigIvTrH, e cbars_old eh uma coluna DERIVADA (left join com SigOpEta)
    * que so existe no cursor do chamador, nunca na tabela.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF TYPE("cidchaves") != "U"
                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
            ENDIF

            IF TYPE("emps") != "U"
                THIS.this_cEmps = TratarNulo(emps, "")
            ENDIF

            IF TYPE("codigos") != "U"
                THIS.this_nCodigos = NVL(codigos, 0)
            ENDIF

            IF TYPE("cbars") != "U"
                THIS.this_nCbars = NVL(cbars, 0)
            ENDIF

            IF TYPE("cpros") != "U"
                THIS.this_cCpros = TratarNulo(cpros, "")
            ENDIF

            IF TYPE("codcors") != "U"
                THIS.this_cCodcors = TratarNulo(codcors, "")
            ENDIF

            IF TYPE("codtams") != "U"
                THIS.this_cCodtams = TratarNulo(codtams, "")
            ENDIF

            IF TYPE("contas") != "U"
                THIS.this_cContas = TratarNulo(contas, "")
            ENDIF

            IF TYPE("localis") != "U"
                THIS.this_cLocalis = TratarNulo(localis, "")
            ENDIF

            IF TYPE("locals") != "U"
                THIS.this_cLocals = TratarNulo(locals, "")
            ENDIF

            IF TYPE("ntrans") != "U"
                THIS.this_nNtrans = NVL(ntrans, 0)
            ENDIF

            IF TYPE("ocors") != "U"
                THIS.this_cOcors = TratarNulo(ocors, "")
            ENDIF

            IF TYPE("obs") != "U"
                THIS.this_cObs = TratarNulo(obs, "")
            ENDIF

            IF TYPE("pesreals") != "U"
                THIS.this_nPesreals = NVL(pesreals, 0)
            ENDIF

            IF TYPE("pesos") != "U"
                THIS.this_nPesos = NVL(pesos, 0)
            ENDIF

            IF TYPE("qtds") != "U"
                THIS.this_nQtds = NVL(qtds, 0)
            ENDIF

            IF TYPE("tipos") != "U"
                THIS.this_nTipos = NVL(tipos, 0)
            ENDIF

            IF TYPE("coletas") != "U"
                THIS.this_cColetas = TratarNulo(coletas, "")
            ENDIF

            IF TYPE("usuars") != "U"
                THIS.this_cUsuars = TratarNulo(usuars, "")
            ENDIF

            IF TYPE("datas") != "U"
                THIS.this_dDatas = TratarNulo(datas, {})
            ENDIF

            IF TYPE("datatrans") != "U"
                THIS.this_dDatatrans = TratarNulo(datatrans, {})
            ENDIF

            *-- cbars_old: coluna derivada (isnull(b.cbars_old,0) do left join
            *-- com SigOpEta no AddCursor do form pai) - so existe no cursor
            *-- do chamador, nunca na tabela SigIvTrH.
            IF TYPE("cbars_old") != "U"
                THIS.this_nCbarsOld = NVL(cbars_old, 0)
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GravarUsuarioHistorico - Grava o usuario logado na linha CORRENTE do
    * cursor do chamador. Transcrito do Column3.Text1.Valid do legado:
    *
    *     Replace Usuars With Usuar In Historico
    *
    * onde "Usuar" eh a PUBLIC global do Framework Fortyus (sigacess.PRG),
    * substituida no sistema novo por gc_4c_UsuarioLogado (THIS.this_cUsuars
    * ja recebe esse valor em Init()). Quem comita a tabela SigIvTrH eh o
    * form pai (TABLEUPDATE sobre o cursor do AddCursor) - este metodo so
    * marca a linha, nunca grava em SQL Server.
    *==========================================================================
    PROCEDURE GravarUsuarioHistorico(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            REPLACE usuars WITH THIS.this_cUsuars
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PopularOcorrencias - Executa a query de ocorrencias validas no cursor
    * this_cCursorOcorrencias e indexa por Codigos/Descrs. Transcrito do
    * Column3.Text1.Valid do legado:
    *
    *     lStrQuery = [Select * From SigBaOco Where Tipos = 'O' And Autos <> 'S' ]
    *     ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'CsOcorr')
    *     Select CsOcorr
    *     Index On Codigos Tag Codigos
    *     Index On Descrs  Tag Descrs
    *     Set Order To Codigos
    *
    * this_cFiltroTipos ("O") e this_cFiltroAutosExcluido ("S") sao os dois
    * literais de regra de negocio ja documentados no cabecalho das
    * propriedades - NUNCA trocar por outro valor sem conferir o dump.
    *==========================================================================
    PROTECTED FUNCTION PopularOcorrencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorOcorrencias)
            USE IN (THIS.this_cCursorOcorrencias)
        ENDIF

        loc_cSQL = "SELECT * FROM SigBaOco" + ;
                   " WHERE Tipos = " + EscaparSQL(THIS.this_cFiltroTipos) + ;
                   " AND Autos <> " + EscaparSQL(THIS.this_cFiltroAutosExcluido)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOcorrencias)

        IF loc_nResultado >= 0 AND USED(THIS.this_cCursorOcorrencias)
            SELECT (THIS.this_cCursorOcorrencias)
            INDEX ON Codigos TAG Codigos
            INDEX ON Descrs  TAG Descrs
            SET ORDER TO TAG Codigos
            GO TOP
            loc_lSucesso = .T.
        ELSE
            MostrarErro("Favor reinicializar o processo !!!" + CHR(13) + ;
                        CapturarErroSQL(), "Falha na Conexao (Ocorrencias)")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarOcorrencia - Procura par_cCodigo no cursor de ocorrencias
    * (populando-o antes, se necessario) e, achando, copia a linha para as
    * propriedades this_cOco*. Equivalente ao Seek(This.Value) do legado;
    * quando devolve .F., o Form (fase de UI) abre o picker sobre o MESMO
    * cursor this_cCursorOcorrencias - ja filtrado - no lugar de reconsultar.
    *==========================================================================
    PROCEDURE ValidarOcorrencia(par_cCodigo)
        LOCAL loc_lAchou
        loc_lAchou = .F.

        IF EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorOcorrencias)
            IF !THIS.PopularOcorrencias()
                RETURN .F.
            ENDIF
        ENDIF

        SELECT (THIS.this_cCursorOcorrencias)
        SET ORDER TO TAG Codigos

        IF SEEK(PADR(ALLTRIM(par_cCodigo), 10))
            THIS.this_cOcoCodigos = TratarNulo(Codigos, "")
            THIS.this_cOcoDescrs  = TratarNulo(Descrs, "")
            THIS.this_cOcoTipos   = TratarNulo(Tipos, "")
            THIS.this_cOcoAutos   = TratarNulo(Autos, "")
            THIS.this_cOcoGrupos  = TratarNulo(Grupos, "")
            THIS.this_cOcoOpers   = TratarNulo(Opers, "")
            THIS.this_cOcoApuras  = TratarNulo(Apuras, "")
            THIS.this_cOcoLancas  = TratarNulo(Lancas, "")
            loc_lAchou = .T.
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *==========================================================================
    * DECISAO DE PROJETO - BO somente-leitura quanto a persistencia em
    * SQL Server, sem Inserir()/Atualizar()/ExecutarExclusao() proprios
    *
    * O "Saida.Click" do dump legado tem o UNICO Update da tela inteiramente
    * COMENTADO (*!*) e executa apenas "ThisForm.Release" (ver cabecalho,
    * secao GRAVACAO). A unica escrita de fato eh "Replace Usuars With Usuar
    * In Historico" sobre o cursor do CHAMADOR (GravarUsuarioHistorico acima)
    * - nunca um INSERT/UPDATE contra SigIvTrH. Por isso este BO nao
    * sobrescreve Inserir()/Atualizar()/ExecutarExclusao(): o comportamento
    * padrao herdado de BusinessBase (recusar a operacao via ExibirFalha) ja
    * eh o correto, e CarregarDoCursor()/GravarUsuarioHistorico() acima sao a
    * fonte unica de leitura e escrita deste dialogo.
    *==========================================================================

ENDDEFINE
