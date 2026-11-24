*==============================================================================
* SIGOPTORBO.PRG
* Business Object para o dialogo "Total" (SIGOPTOR) - dialogo filho MODAL
* aberto pelo form pai de Orcamento/Pre-Custo via
* "Do Form SigOpTor With ThisForm, nDataSession, pcVisual", NAO acessivel
* direto pelo menu.
*
* NATUREZA DESTE DIALOGO (lido do legado, SIGOPTOR.Init):
*   O Init recebe (pform, datses, pVisual): pform e o form PAI, datses e a
*   DataSession do pai (o dialogo faz "Set Datasession To DatSes" para
*   conseguir ler os cursores do pai - crSigMvOrp/crSigMvOrc/crSigOpCdd/
*   crSigCdOpe - ANTES de qualquer coisa; NAO abre DataSession propria,
*   apesar de DataSession = 2 declarado no SCX).
*
*   pVisual = "P"  -> modo "Total Previsao":
*     - Select Datas, Sum(Valos) as Valos, Sum(VlBaixas) as VlBaixas,
*       Sum(Valos - VlBaixas) as VlPends From crSigMvOrp Group By Datas
*       (SQL LOCAL do VFP sobre cursor ja carregado pelo pai - NAO usa
*       gnConnHandle) alimenta a grade grdTotPrev (Data/Previsto/
*       Realizado/Diferenca).
*     - Select Sum(Valos), Sum(VlBaixas), Sum(Valos - VlBaixas) From
*       crSigMvOrp (sem Group By) alimenta os totalizadores
*       getTotPrev/getTotReal/getTotDif.
*     - Select Citens, Dpros, Sum(tota1s+tota2s+tota3s) From crSigMvOrc
*       Where cBlocos In ('SUBTOTAIS','TAXA','TOTAL','IMPOSTO',
*       'TOTALGERAL') Group By Citens, Dpros alimenta a grade grdTotal
*       (Item/Total NFs).
*
*   pVisual <> "P" -> modo "Itens Subnivel" (Tiago - 14/04/2014 - SRCOM):
*     busca todos os subniveis que o item (crSigMvOrc.nCodigos) passou,
*     subindo a cadeia via SigCdOpe.Dopes + Str(Nume,6) = EmpDopNums e
*     consultando (via poDataMgr do form AVO, nao gnConnHandle direto):
*       Select b.Datas, a.nCodigos, c.citens, c.cpros, c.dpros, c.qtds,
*         c.cunis, c.pesos, c.cunips, c.fators, c.units, c.moedas,
*         c.totas, d.Dunis as Dcunis, e.Dunis as Dcunips
*       From SigMvItn a
*       Inner Join SigMvCab b On a.EmpDopNums = b.EmpDopNums
*       Inner Join SigMvOrc c On a.EmpDopNums = c.EmpDopNums
*                             And a.Citens = c.Citens
*       Inner Join SigCdUni d On a.Cunis = d.Cunis
*       Inner Join SigCdUni e On a.Cunips = e.Cunis
*       Where a.EmpDopNums = '<Emps+Dopes+Str(Nume,6)>'
*         And a.Cpros = '<crSigMvOrc.Cpros>'
*     repetido em loop (Do While llAchou) at? o proximo nCodigos nao
*     encontrar mais SigCdOpe correspondente - cada linha alimenta a
*     grade grdItem (Movimentacao/Quantidade/Periodo/Unitario/Data/
*     Turno/Unidade/Unidade/Total).
*
*   O dialogo e SOMENTE LEITURA em AMBOS os modos (todas as colunas das
*   tres grades tem ReadOnly = .T. no SCX, sem nenhum botao de gravacao) -
*   o unico botao e OK.btnSair (Caption "Retornar"), que reabilita o form
*   pai e libera o dialogo:
*     ThisForm.ParentForm.Enabled = .T.
*     ThisForm.Release()
*
*   Por isso este BO NAO sobrescreve Inserir()/Atualizar()/
*   ExecutarExclusao(): o comportamento padrao herdado de BusinessBase
*   (recusar a operacao e reportar pelo ExibirFalha do Salvar) ja eh o
*   correto, e inventar INSERT/UPDATE aqui violaria a regra #22 do
*   CLAUDE.md (a lista de colunas vem do schema, nunca de adivinhacao).
*
* Tabela de contexto : SigMvOrc (orcamento/pre-custo) - usada para montar
*                       o filtro do modo Itens Subnivel (crSigMvOrc.Cpros/
*                       nCodigos/DPros, vindos do form pai) e consultada
*                       via JOIN com SigMvItn/SigMvCab/SigCdUni/SigCdOpe.
* Chave Real (contexto): Citens  CHAR - identifica a linha de orcamento
*                       corrente no form pai (SigMvOrc.Citens).
*==============================================================================

DEFINE CLASS SIGOPTORBO AS BusinessBase

    *--------------------------------------------------------------------------
    * MODO DE EXIBICAO - espelha o parametro pVisual recebido pelo Form
    * "P" = Total Previsao | qualquer outro valor = Itens Subnivel
    *--------------------------------------------------------------------------
    this_cModoExibicao          = ""  && pVisual - "P" ou vazio/outro
    this_cTituloDialogo          = ""  && Caption montado conforme o modo

    *--------------------------------------------------------------------------
    * CONTEXTO - SigMvOrc (crSigMvOrc no legado, cursor do form pai)
    * Linha corrente de orcamento que originou a abertura do dialogo.
    *--------------------------------------------------------------------------
    this_nCodigoAtual            = 0   && nCodigos  N      - ponto de partida do loop Itens Subnivel
    this_cProdutoAtual           = ""  && Cpros     CHAR(14) - filtro a.Cpros nas consultas do modo item
    this_cDescricaoProduto       = ""  && DPros     CHAR(40) - getDProd.Value (contexto, so leitura)

    *--------------------------------------------------------------------------
    * MODO "P" - TOTAIS GERAIS (crTmpTotOrp2 no legado, linha unica)
    * Alimentam getTotPrev/getTotReal/getTotDif.
    *--------------------------------------------------------------------------
    this_nTotalPrevisto          = 0   && Sum(Valos) de crSigMvOrp         - getTotPrev.Value
    this_nTotalRealizado         = 0   && Sum(VlBaixas) de crSigMvOrp      - getTotReal.Value
    this_nTotalDiferenca         = 0   && Sum(Valos - VlBaixas)            - getTotDif.Value

    *--------------------------------------------------------------------------
    * CURSORES DE GRADE (nascem vazios no InicializarForm; populados pelos
    * metodos Carregar* nas fases seguintes)
    *--------------------------------------------------------------------------
    this_cCursorTotalPorData     = "cursor_4c_TotalPorData"     && grdTotPrev <- crTmpTotOrp  (Datas, Valos, VlBaixas, VlPends)
    this_cCursorTotalGeral       = "cursor_4c_TotalGeral"       && grdTotal   <- crTmpTotal    (Dpros, Tota1s)
    this_cCursorItensPendentes   = "cursor_4c_ItensPendentes"   && grdItem    <- TmpItePen     (DopeNums, CPros, Dpros, Qtds, Cunis, Pesos, CuniPs, Fators, Units, Moedas, Totas, Datas, Dcunis, Dcunips)

    *--------------------------------------------------------------------------
    * LINHA CORRENTE - grdTotPrev (cursor_4c_TotalPorData)
    *--------------------------------------------------------------------------
    this_dDatasTotal             = {}  && Datas     D        - data do agrupamento
    this_nValos                  = 0   && Valos     N(15,2)  - total previsto do dia
    this_nVlBaixas                = 0   && VlBaixas  N(15,2)  - total realizado (baixado) do dia
    this_nVlPends                = 0   && VlPends   N(15,2)  - diferenca (Valos - VlBaixas)

    *--------------------------------------------------------------------------
    * LINHA CORRENTE - grdTotal (cursor_4c_TotalGeral)
    *--------------------------------------------------------------------------
    this_cDprosTotal              = ""  && Dpros     CHAR(40) - descricao do item de total (subtotais/taxa/imposto/total geral)
    this_nTota1s                  = 0   && Tota1s    N(15,2)  - Sum(tota1s + tota2s + tota3s) do item

    *--------------------------------------------------------------------------
    * LINHA CORRENTE - grdItem (cursor_4c_ItensPendentes / TmpItePen)
    *--------------------------------------------------------------------------
    this_cDopeNums                = ""  && DopeNums  CHAR(26) - Dopes + Str(Nume,6), identifica a movimentacao
    this_cCPros                   = ""  && CPros     CHAR(14) - codigo do produto da linha
    this_cDpros                   = ""  && Dpros     CHAR(40) - descricao do produto da linha
    this_nQtds                    = 0   && Qtds      N(12,3)  - quantidade movimentada
    this_cCunis                   = ""  && Cunis     CHAR(3)  - unidade da quantidade
    this_nPesos                   = 0   && Pesos     N(12,3)  - peso movimentado
    this_cCuniPs                  = ""  && CuniPs    CHAR(3)  - unidade do peso
    this_nFators                  = 0   && Fators    N(12,3)  - fator de conversao
    this_nUnits                   = 0   && Units     N(12,3)  - valor unitario
    this_cMoedas                  = ""  && Moedas    CHAR(3)  - moeda do valor
    this_nTotas                   = 0   && Totas     N(15,2)  - valor total da linha
    this_dDatas                   = {}  && Datas     D        - data da movimentacao
    this_cDcunis                  = ""  && Dcunis    CHAR(20) - descricao da unidade da quantidade (SigCdUni.Dunis)
    this_cDcunips                 = ""  && Dcunips   CHAR(20) - descricao da unidade do peso (SigCdUni.Dunis)

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    *--------------------------------------------------------------------------
    this_nTotalRegistrosTotPrev   = 0   && RECCOUNT de cursor_4c_TotalPorData apos a carga
    this_nTotalRegistrosTotal     = 0   && RECCOUNT de cursor_4c_TotalGeral apos a carga
    this_nTotalRegistrosItens     = 0   && RECCOUNT de cursor_4c_ItensPendentes apos a carga

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * DODEFAULT() sem parametro: nao instancia DataAccess, porque este
    * dialogo nao grava em tabela remota (ver cabecalho). this_cTabela e
    * this_cCampoChave apontam para a tabela de contexto/consulta
    * (SigMvOrc), usada para montar as duas grades.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvOrc"
        THIS.this_cCampoChave = "Citens"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTotalPorData - Modo "P" (Total Previsao), 1a grade (grdTotPrev).
    * Replica "Select Datas, Sum(Valos) ..., Group By Datas" do Init legado,
    * agregando LOCALMENTE (sem gnConnHandle) sobre o cursor de movimentacao
    * (equivalente a crSigMvOrp) que o Form ja recebe populado do form pai.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTotalPorData(par_cCursorOrigemOrp)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cCursorOrigemOrp)
            THIS.this_cMensagemErro = "Cursor de movimenta" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o est" + CHR(225) + " aberto: " + par_cCursorOrigemOrp
            RETURN .F.
        ENDIF

        TRY
            IF USED(THIS.this_cCursorTotalPorData)
                USE IN (THIS.this_cCursorTotalPorData)
            ENDIF

            SELECT Datas, SUM(Valos) AS Valos, SUM(VlBaixas) AS VlBaixas, ;
                    SUM(Valos - VlBaixas) AS VlPends ;
                FROM (par_cCursorOrigemOrp) ;
                GROUP BY Datas ;
                INTO CURSOR (THIS.this_cCursorTotalPorData) READWRITE

            SELECT (THIS.this_cCursorTotalPorData)
            GO TOP

            THIS.this_nTotalRegistrosTotPrev = RECCOUNT(THIS.this_cCursorTotalPorData)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar o total por data: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTotaisGerais - Modo "P", totalizadores getTotPrev/getTotReal/
    * getTotDif. Replica "Select Sum(Valos), Sum(VlBaixas), Sum(Valos-VlBaixas)
    * From crSigMvOrp" (sem Group By - uma unica linha) do Init legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTotaisGerais(par_cCursorOrigemOrp)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cCursorOrigemOrp)
            THIS.this_cMensagemErro = "Cursor de movimenta" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o est" + CHR(225) + " aberto: " + par_cCursorOrigemOrp
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_TmpTotOrp2")
                USE IN cursor_4c_TmpTotOrp2
            ENDIF

            SELECT SUM(Valos) AS Valos, SUM(VlBaixas) AS VlBaixas, ;
                    SUM(Valos - VlBaixas) AS VlPends ;
                FROM (par_cCursorOrigemOrp) ;
                INTO CURSOR cursor_4c_TmpTotOrp2 READWRITE

            THIS.this_nTotalPrevisto  = TratarNulo(cursor_4c_TmpTotOrp2.Valos, 0)
            THIS.this_nTotalRealizado = TratarNulo(cursor_4c_TmpTotOrp2.VlBaixas, 0)
            THIS.this_nTotalDiferenca = TratarNulo(cursor_4c_TmpTotOrp2.VlPends, 0)

            USE IN cursor_4c_TmpTotOrp2

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar os totais gerais: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTotalGeral - Modo "P", 2a grade (grdTotal). Replica
    * "Select Citens, Dpros, Sum(tota1s+tota2s+tota3s) ... Where cBlocos
    * In (...) Group By Citens, Dpros" do Init legado, sobre o cursor de
    * orcamento (equivalente a crSigMvOrc).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTotalGeral(par_cCursorOrigemOrc)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cCursorOrigemOrc)
            THIS.this_cMensagemErro = "Cursor de or" + CHR(231) + "amento n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto: " + par_cCursorOrigemOrc
            RETURN .F.
        ENDIF

        TRY
            IF USED(THIS.this_cCursorTotalGeral)
                USE IN (THIS.this_cCursorTotalGeral)
            ENDIF

            SELECT Citens, Dpros, SUM(tota1s + tota2s + tota3s) AS Tota1s ;
                FROM (par_cCursorOrigemOrc) ;
                WHERE INLIST(cBlocos, "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
                GROUP BY Citens, Dpros ;
                INTO CURSOR (THIS.this_cCursorTotalGeral) READWRITE

            SELECT (THIS.this_cCursorTotalGeral)
            GO TOP

            THIS.this_nTotalRegistrosTotal = RECCOUNT(THIS.this_cCursorTotalGeral)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar o total geral: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarModoPrevisao - Orquestra o modo "P" (Total Previsao) completo:
    * as duas grades (grdTotPrev/grdTotal) e os 3 totalizadores.
    * par_cCursorOrigemOrp / par_cCursorOrigemOrc sao os aliases (ja abertos
    * pelo Form, recebidos do form pai) equivalentes a crSigMvOrp/crSigMvOrc.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarModoPrevisao(par_cCursorOrigemOrp, par_cCursorOrigemOrc)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_cMensagemErro  = ""
        THIS.this_cModoExibicao  = "P"
        THIS.this_cTituloDialogo = "Total Previs" + CHR(227) + "o"

        IF THIS.CarregarTotalPorData(par_cCursorOrigemOrp) AND ;
           THIS.CarregarTotaisGerais(par_cCursorOrigemOrp) AND ;
           THIS.CarregarTotalGeral(par_cCursorOrigemOrc)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarModoItensSubnivel - Modo "Itens Subnivel" (grdItem). Replica o
    * loop "Do While llAchou" do Init legado (Tiago - 14/04/2014 - SRCOM):
    * sobe a cadeia de subniveis que o item (par_nCodigoInicial) passou,
    * resolvendo Dopes via SigCdOpe.Ndopes e consultando SigMvItn/SigMvCab/
    * SigMvOrc/SigCdUni, ate o proximo nCodigos nao encontrar mais nenhum
    * item (ou falha de conexao).
    *
    * Aqui, diferente do modo "P" (que agrega cursores LOCAIS ja carregados),
    * cada passo da cadeia e uma consulta REMOTA via gnConnHandle - o legado
    * tambem faz assim (ThisForm.Parentform.ParentForm.poDataMgr.SqlExecute).
    *
    * par_cEmps substitui o "TprMvCab.Emps" do legado: o dump original le a
    * empresa de um cursor global (TprMvCab) aberto por um ancestral do form
    * pai que nao faz parte deste acervo isolado (SIGOPTOR e um dialogo
    * filho de um form de Orcamento/Pre-Custo nao migrado nesta tarefa). O
    * Form (Fase 3) deve repassar aqui a empresa do registro de origem (ex.:
    * o Emps do cursor de orcamento do form pai, ou
    * go_4c_Sistema.cCodEmpresa como fallback).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarModoItensSubnivel(par_nCodigoInicial, par_cCpros, par_cEmps)
        LOCAL loc_lSucesso, loc_lErroFatal, loc_nCodigo, loc_lAchou, ;
              loc_nDope, loc_nNume, loc_cDope, loc_cEDN, loc_cSQL, loc_nResultado

        loc_lSucesso   = .F.
        loc_lErroFatal = .F.

        THIS.this_cMensagemErro  = ""
        THIS.this_cModoExibicao  = "I"
        THIS.this_cTituloDialogo = "Itens Subn" + CHR(237) + "vel"
        THIS.this_nCodigoAtual   = par_nCodigoInicial
        THIS.this_cProdutoAtual  = par_cCpros

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            IF USED(THIS.this_cCursorItensPendentes)
                USE IN (THIS.this_cCursorItensPendentes)
            ENDIF

            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorItensPendentes) ( ;
                DopeNums C(26), CPros C(14), Dpros C(65), Qtds N(9,3), Cunis C(3), ;
                Pesos N(9,3), CuniPs C(3), Fators N(8,3), Units N(15,6), Moedas C(3), ;
                Totas N(11,2), Datas D, Dcunis C(20), Dcunips C(20))
            SET NULL OFF
            INDEX ON Datas TAG Datas

            loc_nCodigo = par_nCodigoInicial
            loc_lAchou  = .T.

            DO WHILE loc_lAchou
                loc_nDope = VAL(LEFT(STR(loc_nCodigo, 10), 4))
                loc_nNume = VAL(RIGHT(STR(loc_nCodigo, 10), 6))

                IF USED("cursor_4c_OpeSubnTmp")
                    USE IN cursor_4c_OpeSubnTmp
                ENDIF
                loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Ndopes = " + FormatarNumeroSQL(loc_nDope, 0)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeSubnTmp")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor reinicializar o processo. (SigCdOpe)"
                    loc_lErroFatal = .T.
                    loc_lAchou = .F.
                    EXIT
                ENDIF

                IF !USED("cursor_4c_OpeSubnTmp") OR EOF("cursor_4c_OpeSubnTmp")
                    * Nao ha mais SigCdOpe correspondente - fim normal da cadeia
                    loc_lAchou = .F.
                    EXIT
                ENDIF

                loc_cDope = cursor_4c_OpeSubnTmp.Dopes
                USE IN cursor_4c_OpeSubnTmp

                *-- SEM ALLTRIM nas partes: chave posicional de 29 caracteres
                *-- (Emps(3) + Dopes(20) + Str(Numes,6) = EmpDopNums - regra #42)
                loc_cEDN = PADR(NVL(par_cEmps, ""), 3) + loc_cDope + STR(loc_nNume, 6)

                IF USED("cursor_4c_MvPecSubnTmp")
                    USE IN cursor_4c_MvPecSubnTmp
                ENDIF

                loc_cSQL = "SELECT b.Datas, a.nCodigos, c.citens, c.cpros, c.dpros, c.qtds, " + ;
                    "c.cunis, c.pesos, c.cunips, c.fators, c.units, c.moedas, c.totas, " + ;
                    "d.Dunis AS Dcunis, e.Dunis AS Dcunips " + ;
                    "FROM SigMvItn a " + ;
                    "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                    "INNER JOIN SigMvOrc c ON a.EmpDopNums = c.EmpDopNums AND a.Citens = c.Citens " + ;
                    "INNER JOIN SigCdUni d ON a.Cunis = d.Cunis " + ;
                    "INNER JOIN SigCdUni e ON a.Cunips = e.Cunis " + ;
                    "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEDN) + " " + ;
                    "AND a.Cpros = " + EscaparSQL(par_cCpros) + " " + ;
                    "ORDER BY c.Citens"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvPecSubnTmp")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor reinicializar o processo. (Itens do Subn" + CHR(237) + "vel)"
                    loc_lErroFatal = .T.
                    loc_lAchou = .F.
                    EXIT
                ENDIF

                IF !USED("cursor_4c_MvPecSubnTmp") OR EOF("cursor_4c_MvPecSubnTmp")
                    * Nao ha mais item upstream - fim normal da cadeia
                    loc_lAchou = .F.
                    EXIT
                ENDIF

                INSERT INTO (THIS.this_cCursorItensPendentes) ( ;
                        DopeNums, CPros, Dpros, Qtds, Cunis, Pesos, CuniPs, Fators, ;
                        Units, Moedas, Totas, Datas, Dcunis, Dcunips) ;
                    VALUES ( ;
                        loc_cDope + STR(loc_nNume, 6), ;
                        cursor_4c_MvPecSubnTmp.cpros, ;
                        cursor_4c_MvPecSubnTmp.dpros, ;
                        cursor_4c_MvPecSubnTmp.qtds, ;
                        cursor_4c_MvPecSubnTmp.cunis, ;
                        cursor_4c_MvPecSubnTmp.pesos, ;
                        cursor_4c_MvPecSubnTmp.cunips, ;
                        cursor_4c_MvPecSubnTmp.fators, ;
                        cursor_4c_MvPecSubnTmp.units, ;
                        cursor_4c_MvPecSubnTmp.moedas, ;
                        cursor_4c_MvPecSubnTmp.totas, ;
                        cursor_4c_MvPecSubnTmp.datas, ;
                        cursor_4c_MvPecSubnTmp.dcunis, ;
                        cursor_4c_MvPecSubnTmp.dcunips)

                loc_nCodigo = cursor_4c_MvPecSubnTmp.nCodigos

                USE IN cursor_4c_MvPecSubnTmp
            ENDDO

            SELECT (THIS.this_cCursorItensPendentes)
            GO TOP

            THIS.this_nTotalRegistrosItens = RECCOUNT(THIS.this_cCursorItensPendentes)
            loc_lSucesso = !loc_lErroFatal

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar os itens do subn" + CHR(237) + "vel: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a LINHA CORRENTE de qualquer uma das 3 grades
    * (identificada pelo alias recebido) para as properties "linha corrente"
    * declaradas na Fase 1. Dialogo e somente leitura (ver cabecalho do
    * arquivo) - usado so para inspecionar/auditar a linha ativa, nunca para
    * gravar.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        DO CASE
        CASE UPPER(par_cAliasCursor) == UPPER(THIS.this_cCursorItensPendentes)
            THIS.this_cDopeNums = TratarNulo(DopeNums, "")
            THIS.this_cCPros    = TratarNulo(CPros, "")
            THIS.this_cDpros    = TratarNulo(Dpros, "")
            THIS.this_nQtds     = TratarNulo(Qtds, 0)
            THIS.this_cCunis    = TratarNulo(Cunis, "")
            THIS.this_nPesos    = TratarNulo(Pesos, 0)
            THIS.this_cCuniPs   = TratarNulo(CuniPs, "")
            THIS.this_nFators   = TratarNulo(Fators, 0)
            THIS.this_nUnits    = TratarNulo(Units, 0)
            THIS.this_cMoedas   = TratarNulo(Moedas, "")
            THIS.this_nTotas    = TratarNulo(Totas, 0)
            THIS.this_dDatas    = Datas
            THIS.this_cDcunis   = TratarNulo(Dcunis, "")
            THIS.this_cDcunips  = TratarNulo(Dcunips, "")

        CASE UPPER(par_cAliasCursor) == UPPER(THIS.this_cCursorTotalPorData)
            THIS.this_dDatasTotal = Datas
            THIS.this_nValos      = TratarNulo(Valos, 0)
            THIS.this_nVlBaixas   = TratarNulo(VlBaixas, 0)
            THIS.this_nVlPends    = TratarNulo(VlPends, 0)

        CASE UPPER(par_cAliasCursor) == UPPER(THIS.this_cCursorTotalGeral)
            THIS.this_cDprosTotal = TratarNulo(Dpros, "")
            THIS.this_nTota1s     = TratarNulo(Tota1s, 0)

        ENDCASE

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresGrade - Fecha os 3 cursores das grades. Replica o
    * PROCEDURE Release do SIGOPTOR legado (Use In crTmpTotOrp/crTmpTotOrp2/
    * TmpItePen) - o Form (Fase 3) chama isto no proprio Release/Destroy.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresGrade()
        IF USED(THIS.this_cCursorTotalPorData)
            USE IN (THIS.this_cCursorTotalPorData)
        ENDIF
        IF USED(THIS.this_cCursorTotalGeral)
            USE IN (THIS.this_cCursorTotalGeral)
        ENDIF
        IF USED(THIS.this_cCursorItensPendentes)
            USE IN (THIS.this_cCursorItensPendentes)
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave de CONTEXTO (nao de persistencia: este
    * dialogo e somente leitura, ver cabecalho do arquivo - Salvar/Excluir/
    * RegistrarAuditoria nunca sao chamados aqui). A sobrescrita existe so
    * para documentar qual seria a chave do item em exibicao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigoAtual)
    ENDPROC

ENDDEFINE
