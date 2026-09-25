*====================================================================
* SIGMVCTHBO.prg
*
* Business Object para Historico de Cotacoes (consulta de cotacoes
* anteriores de um produto dentro de uma proposta de compra)
* Tabelas: SigCtTCt (itens de cotacao), SigCtTDc (documento/aprovacao
*          da cotacao), SigCtTFn (fornecedor vencedor por cotacao)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGMVCTHBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para SigCtTCt/SigCtTDc/SigCtTFn)
    this_cCPros       = ""   && cpros char(14) - SigCtTCt - proposta filtrada
    this_nCodigos     = 0    && codigos numeric(6,0) - SigCtTCt - produto atual (excluido do historico)
    this_cCursorDados = ""   && nome do cursor de resultado exibido na grade (equivalente a crHistPeds do legado)

    *-- Propriedades espelhando a linha corrente de THIS.this_cCursorDados
    *-- (mapeadas por CarregarDoCursor - TODAS as colunas de cursor_4c_HistPeds)
    this_nSituas      = 0    && Situas n(1) - situacao da aprovacao (SigCtTDc.situas)
    this_dDatas       = {}   && Datas d(8) - data da cotacao (SigCtTDc.dtcotas)
    this_nQtdAdqs     = 0    && QtdAdqs n(12,2) - quantidade adquirida (SigCtTCt.qtdadqs)
    this_cCUnis       = ""   && CUnis c(3) - unidade (SigCtTCt.cunis)
    this_nValAdqs     = 0    && ValAdqs n(12,2) - valor adquirido (SigCtTCt.valadqs)
    this_nUnits       = 0    && Units n(12,2) - valor unitario da marca vencedora (unit01..unit06)
    this_nTotas       = 0    && Totas n(12,2) - valor total da marca vencedora (tota01..tota06)
    this_cIClis       = ""   && IClis c(10) - codigo do fornecedor vencedor (SigCtTFn.iclis)
    this_cFornecs     = ""   && Fornecs c(50) - nome do fornecedor vencedor (SigCtTFn.fornecs)
    this_cComprador   = ""   && Comprador c(10) - comprador responsavel (SigCtTDc.comprador)
    this_cAprovador   = ""   && Aprovador c(10) - aprovador responsavel (SigCtTDc.aprovador)
    this_dDtAprovs    = {}   && DtAprovs d(8) - data da aprovacao (SigCtTDc.dtaprovs)
    this_cObsAprovs   = ""   && ObsAprovs m(4) - observacao da aprovacao (SigCtTDc.obsaprovs)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela      = "SigCtTCt"
            THIS.this_cCampoChave  = "cidchaves"
            THIS.this_cCPros       = ""
            THIS.this_nCodigos     = 0
            THIS.this_cCursorDados = "cursor_4c_HistPeds"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarHistorico - Busca o historico de cotacoes do produto dentro
    * da proposta filtrada (THIS.this_cCPros / THIS.this_nCodigos).
    *
    * Porta o metodo "CarregaPedidos" do legado: para cada linha de
    * SigCtTCt (itens cotados) casada com SigCtTDc (documento/aprovacao),
    * resolve qual das 6 marcas (Marca01..Marca06) foi a vencedora e busca
    * o fornecedor correspondente em SigCtTFn (chave Codigos+Grades).
    *
    * Popula THIS.this_cCursorDados (cursor_4c_HistPeds), com a MESMA
    * estrutura de campos que o Load() do legado criava para crHistPeds.
    *====================================================================
    PROCEDURE CarregarHistorico()
        LOCAL loc_cSQL, loc_cSQLFn, loc_nResultado, loc_nResultadoFn
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cLetra, loc_nUnit, loc_nTotal
        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorDados) (Situas N(1), Datas D(8), QtdAdqs N(12,2), ;
                CUnis C(3), ValAdqs N(12,2), Units N(12,2), Totas N(12,2), IClis C(10), ;
                Fornecs C(50), Comprador C(10), Aprovador C(10), DtAprovs D(8), ObsAprovs M(4))
            SET NULL OFF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Modo de validacao de UI (sem conexao SQL) - cursor fica vazio e o form abre normalmente
                loc_lSucesso = .T.
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cCPros))
                    MostrarErro("Proposta n" + CHR(227) + "o informada.", "SIGMVCTHBO.CarregarHistorico")
                    loc_lProsseguir = .F.
                ENDIF

                IF loc_lProsseguir
                    loc_cSQL = "SELECT a.Codigos, b.DtCotas AS Datas, b.Situas, a.QtdAdqs, a.CUnis, a.ValAdqs, " + ;
                        "a.Marca01, a.Unit01, a.Tota01, a.Marca02, a.Unit02, a.Tota02, " + ;
                        "a.Marca03, a.Unit03, a.Tota03, a.Marca04, a.Unit04, a.Tota04, " + ;
                        "a.Marca05, a.Unit05, a.Tota05, a.Marca06, a.Unit06, a.Tota06, " + ;
                        "b.Comprador, b.Aprovador, b.DtAprovs, b.ObsAprovs " + ;
                        "FROM SigCtTCt a, SigCtTDc b " + ;
                        "WHERE a.CPros = " + EscaparSQL(THIS.this_cCPros) + " " + ;
                        "AND a.Codigos <> " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + " " + ;
                        "AND a.Codigos = b.Codigos " + ;
                        "ORDER BY b.DtCotas DESC, a.Codigos ASC"

                    IF USED("cursor_4c_HistPedsCt")
                        USE IN cursor_4c_HistPedsCt
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistPedsCt")

                    IF loc_nResultado < 0
                        MostrarErro("Falha ao carregar hist" + CHR(243) + "rico de cota" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF

                IF loc_lProsseguir
                    SELECT cursor_4c_HistPedsCt
                    SCAN
                        loc_cLetra = " "
                        loc_nUnit  = 0
                        loc_nTotal = 0

                        DO CASE
                            CASE cursor_4c_HistPedsCt.Marca01
                                loc_cLetra = "A"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit01
                                loc_nTotal = cursor_4c_HistPedsCt.Tota01
                            CASE cursor_4c_HistPedsCt.Marca02
                                loc_cLetra = "B"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit02
                                loc_nTotal = cursor_4c_HistPedsCt.Tota02
                            CASE cursor_4c_HistPedsCt.Marca03
                                loc_cLetra = "C"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit03
                                loc_nTotal = cursor_4c_HistPedsCt.Tota03
                            CASE cursor_4c_HistPedsCt.Marca04
                                loc_cLetra = "D"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit04
                                loc_nTotal = cursor_4c_HistPedsCt.Tota04
                            CASE cursor_4c_HistPedsCt.Marca05
                                loc_cLetra = "E"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit05
                                loc_nTotal = cursor_4c_HistPedsCt.Tota05
                            CASE cursor_4c_HistPedsCt.Marca06
                                loc_cLetra = "F"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit06
                                loc_nTotal = cursor_4c_HistPedsCt.Tota06
                        ENDCASE

                        IF !EMPTY(loc_cLetra)
                            INSERT INTO (THIS.this_cCursorDados) ;
                                (Situas, Datas, QtdAdqs, CUnis, ValAdqs, Comprador, Aprovador, DtAprovs, ObsAprovs, Units, Totas) ;
                                VALUES ( ;
                                    cursor_4c_HistPedsCt.Situas, ;
                                    ConverterParaData(cursor_4c_HistPedsCt.Datas), ;
                                    cursor_4c_HistPedsCt.QtdAdqs, ;
                                    cursor_4c_HistPedsCt.CUnis, ;
                                    cursor_4c_HistPedsCt.ValAdqs, ;
                                    cursor_4c_HistPedsCt.Comprador, ;
                                    cursor_4c_HistPedsCt.Aprovador, ;
                                    ConverterParaData(cursor_4c_HistPedsCt.DtAprovs), ;
                                    TratarNulo(cursor_4c_HistPedsCt.ObsAprovs, ""), ;
                                    loc_nUnit, ;
                                    loc_nTotal)

                            loc_cSQLFn = "SELECT a.IClis, a.Fornecs FROM SigCtTFn a " + ;
                                "WHERE a.Codigos = " + FormatarNumeroSQL(cursor_4c_HistPedsCt.Codigos, 0) + " " + ;
                                "AND a.Grades = " + EscaparSQL(loc_cLetra)

                            IF USED("cursor_4c_HistPedsFn")
                                USE IN cursor_4c_HistPedsFn
                            ENDIF
                            loc_nResultadoFn = SQLEXEC(gnConnHandle, loc_cSQLFn, "cursor_4c_HistPedsFn")

                            IF loc_nResultadoFn < 0
                                MostrarErro("Falha ao carregar fornecedor vencedor da cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lProsseguir = .F.
                            ELSE
                                IF RECCOUNT("cursor_4c_HistPedsFn") > 0
                                    SELECT (THIS.this_cCursorDados)
                                    GO BOTTOM
                                    REPLACE IClis   WITH cursor_4c_HistPedsFn.IClis, ;
                                            Fornecs WITH cursor_4c_HistPedsFn.Fornecs
                                ENDIF
                                IF USED("cursor_4c_HistPedsFn")
                                    USE IN cursor_4c_HistPedsFn
                                ENDIF
                            ENDIF
                        ENDIF

                        IF !loc_lProsseguir
                            EXIT
                        ENDIF

                        SELECT cursor_4c_HistPedsCt
                    ENDSCAN

                    IF USED("cursor_4c_HistPedsCt")
                        USE IN cursor_4c_HistPedsCt
                    ENDIF
                    IF USED("cursor_4c_HistPedsFn")
                        USE IN cursor_4c_HistPedsFn
                    ENDIF
                ENDIF

                loc_lSucesso = loc_lProsseguir
            ENDIF

            IF loc_lSucesso AND USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.CarregarHistorico")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia a linha CORRENTE de par_cAliasCursor
    * (tipicamente THIS.this_cCursorDados, a linha selecionada na grade)
    * para as propriedades this_* do Business Object.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nSituas    = TratarNulo(Situas, 0)
                THIS.this_dDatas     = ConverterParaData(TratarNulo(Datas, {}))
                THIS.this_nQtdAdqs   = TratarNulo(QtdAdqs, 0)
                THIS.this_cCUnis     = TratarNulo(CUnis, "")
                THIS.this_nValAdqs   = TratarNulo(ValAdqs, 0)
                THIS.this_nUnits     = TratarNulo(Units, 0)
                THIS.this_nTotas     = TratarNulo(Totas, 0)
                THIS.this_cIClis     = TratarNulo(IClis, "")
                THIS.this_cFornecs   = TratarNulo(Fornecs, "")
                THIS.this_cComprador = TratarNulo(Comprador, "")
                THIS.this_cAprovador = TratarNulo(Aprovador, "")
                THIS.this_dDtAprovs  = ConverterParaData(TratarNulo(DtAprovs, {}))
                THIS.this_cObsAprovs = TratarNulo(ObsAprovs, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir/Atualizar/ExecutarExclusao/ObterChavePrimaria/RegistrarAuditoria
    * continuam exatamente como herdados de BusinessBase, por fidelidade ao
    * legado: o formulario SIGMVCTH.SCX e um visualizador de historico
    * SOMENTE LEITURA - as tres consultas acima (SELECT em SigCtTCt/
    * SigCtTDc/SigCtTFn) sao a totalidade do SQL que ele executa. O unico
    * botao (cmdSalva.btnSair, rotulado "Retornar") apenas fecha a tela
    * (ThisForm.Release) - o legado nao tem nenhum INSERT/UPDATE/DELETE
    * para portar, e este form nunca aciona THIS.Salvar() nem
    * THIS.Excluir(). O comportamento herdado de BusinessBase (recusar a
    * operacao e avisar o usuario) ja reproduz essa realidade com
    * fidelidade, entao sobrescrever aqui apenas duplicaria codigo sem
    * alterar nada em tempo de execucao.
    *====================================================================

ENDDEFINE
