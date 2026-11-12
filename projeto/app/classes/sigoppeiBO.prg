*==============================================================================
* sigoppeiBO.prg - Business Object para Formsigoppei (Itens dos Subniveis)
* Herda de BusinessBase
*
* Origem legado: tasks\task780\sigoppei.SCX (form SIGOPPEI, DataSession = 2,
* WindowType = 1 - dialogo MODAL de CONSULTA aberto pela tela de movimentacao).
*
* ATENCAO - ESTE DIALOGO NAO TEM TABELA PROPRIA NO SQL SERVER:
* o SIGOPPEI legado nao executa Insert/Update/Delete em lugar nenhum. O Init
* dele monta um cursor de exibicao (TmpItePen) a partir de DOIS cursores que
* pertencem ao FORM PAI (xBaixa e xBaixa2, criados em SIGMVCAB - ver
* tasks\task560\sigmvcab_form_codigo_fonte.txt linhas 24405 e 24411) e faz um
* unico acesso remoto, de LEITURA, em SigCdPro para buscar a descricao do
* produto. Por isso this_cTabela fica vazio (ver Init) e o comportamento padrao
* herdado de BusinessBase para Salvar/Excluir ja eh o correto.
*
* Estrutura EXATA dos cursores do form pai (transcrita do dump legado):
*   xBaixa  ( CPros c(14), Qtds n(12,3), QtBaixas n(12,3), QtProds n(12,3),
*             pVens n(15,6), Moevs c(3) )              Index on CPros Tag Cpros
*   xBaixa2 ( CPros c(14), CodCors c(4), CodTams c(4), Qtds n(12,3),
*             QtBaixas n(12,3), QtProds n(12,3) )
*                                   Index on CPros + CodCors + CodTams Tag Cpros
*
* Cursor de exibicao do legado (TmpItePen), montado em DOIS ramos no Init:
*   (a) xBaixa2 COM linhas -> Select *, Space(40) as Dpros from xBaixa2
*       UNION ALL com os produtos de xBaixa que NAO estao em xBaixa2
*       (as colunas 2 e 3 do segundo Select entram como Space(3); o legado
*        escreve "Space(3) as CodCors" nas duas, mas em UNION ALL os NOMES vem
*        do PRIMEIRO Select, logo a coluna 2 eh CodCors e a 3 eh CodTams, na
*        ordem de xBaixa2 - transcrever por POSICAO, nao pelo alias repetido);
*   (b) xBaixa2 VAZIO -> Select *, Space(40) as Dpros, Space(3) as CodTams,
*                               Space(3) as CodCors from xBaixa
* Em seguida o legado percorre o cursor e, para cada linha, faz
*   Select Dpros from SigCdPro Where CPros = '<cpros>'
* gravando o resultado em Dpros (SigCdPro.dpros eh char(65) no schema, mas o
* legado o recebe num campo de 40 - manter 40 preserva a exibicao do legado).
*
* Totais do rodape (Init legado, sobre o cursor de exibicao):
*   Sum qtds     to lnItn    -> gettotitens
*   Sum qtBaixas to lnBaixa  -> gettotbaixa
*   (lnItn - lnBaixa)        -> gettotdisp
*
* FASE 1/8: declaracao de TODAS as propriedades + Init.
* FASE 2/8: CarregarItensPendentes (monta o cursor de exibicao a partir dos
* cursores do form pai + descricao via SigCdPro), CarregarDoCursor (linha
* corrente -> propriedades) e ObterChavePrimaria. Inserir/Atualizar/
* ExecutarExclusao ficam com o default herdado - dialogo somente-leitura.
*==============================================================================
DEFINE CLASS sigoppeiBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades do ITEM corrente (colunas do cursor de exibicao, uma a uma
    * na grade de 7 colunas do legado)
    *--------------------------------------------------------------------------
    this_cCpros     = ""      && CPros    c(14) - codigo de barras do produto (Grade.Column1)
    this_cDpros     = ""      && Dpros    c(40) - descricao vinda de SigCdPro  (Grade.Column2)
    this_nQtds      = 0       && Qtds     n(12,3) - quantidade do item         (Grade.Column3)
    this_nQtBaixas  = 0       && QtBaixas n(12,3) - quantidade utilizada       (Grade.Column4)
    this_cCodTams   = ""      && CodTams  c(4) - tamanho                       (Grade.Column5)
    this_cCodCors   = ""      && CodCors  c(4) - cor                           (Grade.Column6)
    this_nPendente  = 0       && Qtds - QtBaixas - pendente                    (Grade.Column7)
    this_nQtProds   = 0       && QtProds  n(12,3) - existe nos dois cursores do
                              && form pai e eh carregado junto, mesmo sem coluna
                              && na grade (o legado o traz no Select e no UNION)

    *--------------------------------------------------------------------------
    * Totais do rodape - fonte UNICA de calculo (o form apenas espelha)
    *--------------------------------------------------------------------------
    this_nTotItens  = 0       && Sum qtds     -> gettotitens
    this_nTotBaixa  = 0       && Sum qtBaixas -> gettotbaixa
    this_nTotDisp   = 0       && this_nTotItens - this_nTotBaixa -> gettotdisp

    *--------------------------------------------------------------------------
    * Estado da carga
    *--------------------------------------------------------------------------
    this_nTotalRegistros  = 0    && RECCOUNT do cursor de exibicao
    this_lDadosCarregados = .F.  && .T. depois de montar o cursor de exibicao
                                 && (o Init legado faz "Return .f." quando
                                 && xBaixa nao esta disponivel, e o dialogo
                                 && nem chega a aparecer)

    *--------------------------------------------------------------------------
    * Cursores e tabela de consulta
    * Os nomes dos cursores do FORM PAI (xBaixa / xBaixa2) sao CONTRATO com a
    * tela de movimentacao que abre este dialogo e por isso NAO sao renomeados;
    * os cursores criados por este BO seguem a nomenclatura nova (PILAR 3).
    * Os nomes dos DOIS cursores proprios sao UNICOS no projeto inteiro (medido:
    * zero outros arquivos os citam) e isso eh REQUISITO, nao estilo. Este
    * dialogo entra na data session do form PAI (ver Init do Form), entao um
    * nome generico como "cursor_4c_Dados" - usado por 491 forms - poderia JA
    * ESTAR ABERTO na sessao, com os dados do pai: USED() daria .T.,
    * o cursor vazio nao seria criado e a grade exibiria os dados do PAI, sem
    * erro e sem log. Com TmpItePen o legado nao corria esse risco: o nome ja
    * era proprio da tela.
    *--------------------------------------------------------------------------
    this_cCursorItens   = "cursor_4c_ItePen"    && migrado de TmpItePen (grade)
    this_cCursorTemp    = "cursor_4c_ProDesc"  && migrado de TmpPro (lookup SigCdPro)
    this_cCursorBaixa   = "xBaixa"            && cursor do form pai (nome legado)
    this_cCursorBaixa2  = "xBaixa2"           && cursor do form pai (nome legado)
    this_cTabelaProduto = "SigCdPro"          && unica tabela remota lida (descricao)

    *--------------------------------------------------------------------------
    * Larguras do cursor de exibicao, transcritas do legado - servem de fonte
    * unica para o CREATE CURSOR, que precisa ter a MESMA estrutura em todo
    * lugar que popula a grade. CodTams/CodCors ficam com 4 (largura real em
    * xBaixa2); no ramo em que vem de xBaixa o legado os preenche com Space(3),
    * que cabe em 4 sem truncar nada.
    *--------------------------------------------------------------------------
    this_nTamCpros   = 14     && CPros   c(14) em xBaixa e xBaixa2
    this_nTamDpros   = 40     && Space(40) as Dpros no Init legado
    this_nTamCodTams = 4      && CodTams c(4) em xBaixa2
    this_nTamCodCors = 4      && CodCors c(4) em xBaixa2

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *
    * this_cTabela fica VAZIO de proposito: este dialogo nao persiste em tabela
    * nenhuma (ver cabecalho), entao nao ha DataAccess a instanciar. O campo
    * chave eh CPros, que eh a chave do produto dentro dos cursores do form pai
    * (xBaixa indexa por CPros; xBaixa2 por CPros + CodCors + CodTams) e tambem
    * a chave usada na consulta de descricao em SigCdPro.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = "CPros"

                *-- Estado inicial: nenhum item corrente e nenhum total apurado.
                *-- Zerado aqui (e nao apenas na declaracao) para que reusar a
                *-- mesma instancia do BO numa segunda abertura do dialogo nunca
                *-- exiba os totais da abertura anterior.
                THIS.this_cCpros     = ""
                THIS.this_cDpros     = ""
                THIS.this_nQtds      = 0
                THIS.this_nQtBaixas  = 0
                THIS.this_cCodTams   = ""
                THIS.this_cCodCors   = ""
                THIS.this_nPendente  = 0
                THIS.this_nQtProds   = 0

                THIS.this_nTotItens  = 0
                THIS.this_nTotBaixa  = 0
                THIS.this_nTotDisp   = 0

                THIS.this_nTotalRegistros  = 0
                THIS.this_lDadosCarregados = .F.

                THIS.this_cMensagemErro = ""
                THIS.this_lErroExibido  = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItensPendentes - FASE 2: reproduz o Init do SIGOPPEI legado.
    * Monta this_cCursorItens (cursor_4c_Dados, equivalente a TmpItePen) a
    * partir de this_cCursorBaixa/this_cCursorBaixa2 (cursores do FORM PAI -
    * ver contrato no cabecalho do arquivo), busca a descricao de cada produto
    * em SigCdPro e apura os totais do rodape. Chamado pelo Form DEPOIS de
    * SET DATASESSION TO <sessao do pai> (o proprio Init legado faz isso antes
    * de referenciar xBaixa/xBaixa2 - responsabilidade do Form, nao do BO).
    *
    * Guarda IDENTICA ao legado: so verifica USED(xBaixa2) - o
    * "and !Eof([xBaixa])" do Init original esta COMENTADO la, por isso NAO
    * entra aqui (transcricao literal - CLAUDE.md #17).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItensPendentes()
        LOCAL loc_lSucesso, loc_cSQL, loc_cCpros, loc_nResultado, ;
              loc_nTotItens, loc_nTotBaixa, loc_lTemConexao

        loc_lSucesso = .F.
        THIS.this_cMensagemErro   = ""
        THIS.this_lDadosCarregados = .F.

        TRY
            IF !USED(THIS.this_cCursorBaixa2)
                THIS.this_cMensagemErro = "Cursor de baixa (" + THIS.this_cCursorBaixa2 + ;
                    ") n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel"
            ELSE
                IF USED(THIS.this_cCursorItens)
                    USE IN (THIS.this_cCursorItens)
                ENDIF

                IF RECCOUNT(THIS.this_cCursorBaixa2) > 0
                    *-- xBaixa2 tem linhas: todas elas + as de xBaixa que NAO
                    *-- estao em xBaixa2. No 2o SELECT do UNION ALL as colunas
                    *-- 2/3 entram por POSICAO como CodCors/CodTams do 1o
                    *-- SELECT - NAO pelo alias "CodCors" repetido que o
                    *-- legado escreve nas duas (ver cabecalho do arquivo).
                    SELECT *, ;
                           SPACE(THIS.this_nTamDpros) AS Dpros, ;
                           (Qtds - QtBaixas) AS Pendente ;
                        FROM (THIS.this_cCursorBaixa2) ;
                        UNION ALL ;
                        SELECT CPros, ;
                               SPACE(THIS.this_nTamCodCors) AS CodCors, ;
                               SPACE(THIS.this_nTamCodTams) AS CodCors, ;
                               Qtds, QtBaixas, QtProds, ;
                               SPACE(THIS.this_nTamDpros) AS Dpros, ;
                               (Qtds - QtBaixas) AS Pendente ;
                            FROM (THIS.this_cCursorBaixa) ;
                            WHERE CPros NOT IN (SELECT CPros FROM (THIS.this_cCursorBaixa2)) ;
                        INTO CURSOR (THIS.this_cCursorItens) READWRITE
                ELSE
                    *-- xBaixa2 vazio: a exibicao vem toda de xBaixa.
                    SELECT *, ;
                           SPACE(THIS.this_nTamDpros) AS Dpros, ;
                           SPACE(THIS.this_nTamCodTams) AS CodTams, ;
                           SPACE(THIS.this_nTamCodCors) AS CodCors, ;
                           (Qtds - QtBaixas) AS Pendente ;
                        FROM (THIS.this_cCursorBaixa) ;
                        INTO CURSOR (THIS.this_cCursorItens) READWRITE
                ENDIF

                *-- Descricao do produto: unico acesso remoto do dialogo, SEMPRE
                *-- em cursor TEMPORARIO (regra: nunca SQLEXEC sobre o alias
                *-- ligado ao Grid). Reselecionar this_cCursorItens apos cada
                *-- SQLEXEC - ele muda a area ativa e o SCAN precisa achar a
                *-- mesma area selecionada para avancar corretamente.
                loc_lTemConexao = (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)

                IF loc_lTemConexao
                    SELECT (THIS.this_cCursorItens)
                    SCAN
                        loc_cCpros = ALLTRIM(CPros)
                        loc_cSQL = "SELECT Dpros FROM " + THIS.this_cTabelaProduto + ;
                                   " WHERE CPros = " + EscaparSQL(loc_cCpros)

                        IF USED(THIS.this_cCursorTemp)
                            USE IN (THIS.this_cCursorTemp)
                        ENDIF
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)

                        SELECT (THIS.this_cCursorItens)
                        IF loc_nResultado >= 0 AND USED(THIS.this_cCursorTemp) ;
                                AND RECCOUNT(THIS.this_cCursorTemp) > 0
                            REPLACE Dpros WITH EVALUATE(THIS.this_cCursorTemp + ".Dpros") ;
                                IN (THIS.this_cCursorItens)
                        ENDIF
                    ENDSCAN

                    IF USED(THIS.this_cCursorTemp)
                        USE IN (THIS.this_cCursorTemp)
                    ENDIF
                ENDIF

                *-- Totais do rodape - fonte UNICA de calculo (Sum sem FOR,
                *-- igual ao legado: soma o cursor inteiro, nenhuma linha fica
                *-- de fora - regra #17, criterio dos totais eh regra tambem).
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_nTotItens = 0
                loc_nTotBaixa = 0
                SUM Qtds     TO loc_nTotItens
                GO TOP
                SUM QtBaixas TO loc_nTotBaixa
                GO TOP

                THIS.this_nTotItens = loc_nTotItens
                THIS.this_nTotBaixa = loc_nTotBaixa
                THIS.this_nTotDisp  = THIS.this_nTotItens - THIS.this_nTotBaixa

                THIS.this_nTotalRegistros  = RECCOUNT(THIS.this_cCursorItens)
                THIS.this_lDadosCarregados = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - FASE 2: copia os campos da linha CORRENTE de
    * this_cCursorItens para as propriedades this_* do item. No legado,
    * getCProd/getDProd tinham ControlSource direto em TmpItepen e se
    * atualizavam sozinhos ao mudar de linha na grade; o migrado nao liga
    * TextBox a cursor, entao o Form chama este metodo (tipicamente no
    * AfterRowColChange do grid) para espelhar a linha corrente.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorItens)

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            THIS.this_cCpros    = ""
            THIS.this_cDpros    = ""
            THIS.this_nQtds     = 0
            THIS.this_nQtBaixas = 0
            THIS.this_cCodTams  = ""
            THIS.this_cCodCors  = ""
            THIS.this_nPendente = 0
            THIS.this_nQtProds  = 0
            RETURN .F.
        ENDIF

        THIS.this_cCpros    = TratarNulo(EVALUATE(loc_cAlias + ".CPros"), "")
        THIS.this_cDpros    = TratarNulo(EVALUATE(loc_cAlias + ".Dpros"), "")
        THIS.this_nQtds     = TratarNulo(EVALUATE(loc_cAlias + ".Qtds"), 0)
        THIS.this_nQtBaixas = TratarNulo(EVALUATE(loc_cAlias + ".QtBaixas"), 0)
        THIS.this_cCodTams  = TratarNulo(EVALUATE(loc_cAlias + ".CodTams"), "")
        THIS.this_cCodCors  = TratarNulo(EVALUATE(loc_cAlias + ".CodCors"), "")
        THIS.this_nPendente = TratarNulo(EVALUATE(loc_cAlias + ".Pendente"), 0)
        THIS.this_nQtProds  = TratarNulo(EVALUATE(loc_cAlias + ".QtProds"), 0)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - FASE 2: chave do item corrente eh CPros (mesma
    * chave usada pelos indices de xBaixa/xBaixa2 e pela consulta a SigCdPro).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir()/Atualizar()/ExecutarExclusao() - FASE 2: PROPOSITALMENTE nao
    * sobrescritos. Este dialogo nao grava nada (ver cabecalho do arquivo: o
    * legado nao executa Insert/Update/Delete em lugar nenhum, e o unico botao
    * eh "Retornar", que so fecha a tela) - o comportamento padrao herdado de
    * BusinessBase ja eh o correto, e nunca chega a ser acionado porque nada
    * no Form chama Salvar()/Excluir().
    *--------------------------------------------------------------------------

ENDDEFINE
