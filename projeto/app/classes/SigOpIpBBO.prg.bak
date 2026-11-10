*==============================================================================
* SigOpIpBBO.prg
*
* Business Object para SIGOPIPB (Seleciona Impressora de Etiquetas / Boletos)
*
* Origem legado : SigOpIpB.SCX
*                 tasks\task753\SigOpIpB_form_codigo_fonte.txt
*
* Tabela: (nenhuma - dialogo FILHO de selecao, sem persistencia propria)
*
* O QUE ESTA TELA FAZ
* -------------------
* E um dialogo MODAL de uma unica escolha: exibe numa grade as impressoras
* que o form PAI ja apurou e deixa o usuario marcar UMA delas. Toda a
* persistencia (a tabela SIGCDMP, de onde as impressoras vem) e consultada
* pelo form PAI; esta tela so LE e ESCREVE o flag de selecao no cursor que
* recebe pronto. Por isso this_cTabela e this_cCampoChave ficam vazios -
* mesma decisao arquitetural de SigOpClpBO.prg (visualizador parametrizado
* que consome o cursor do pai).
*
* CONTRATO DO CURSOR (csSigCdmp no legado)
* ----------------------------------------
* Os dois chamadores conhecidos montam o cursor ANTES do "Do Form SigOpIpb",
* sempre com a mesma forma. Conferido nos dumps:
*
*   tasks\task530\SIGCDTBI_form_codigo_fonte.txt (linhas 518-578)
*       Select Impres, nTpImpres From SigCdmp Where nTpImpres = ?pTip ...
*       llFlags = .f.
*       Select Impres, nTpImpres, llFlags as lMarcas, llFlags as lSituas ;
*         From Tmp1 Into Cursor csSigCdmp ReadWrite
*       Select csSigCdmp
*       Index On Impres Tag Imprime For ( lSituas = .T.)
*       Index On Impres Tag Impres
*       Goto Top In csSigCdmp
*       ... If (lnEtqImpres # 1)   && mais de uma impressora
*               Do Form SigOpIpb
*           EndIf
*       Select csSigCdmp
*       Locate for lSituas
*       Set Printer To Name (AllTrim(CsSigCdmp.impres))
*
*   tasks\task695\sigopcgv_form_codigo_fonte.txt (linhas 13817-13865)
*       Select *, llFlags as lMarcas, llFlags as lSituas ;
*         From LocalcImp Into Cursor csSigCdmp1
*       USE Dbf("csSigCdmp1") Alias csSigCdmp Again In 0
*       (mesmos dois Index On / Goto Top; depois le csSigCdmp.Impres,
*        .fontes, .expas, .expds, .maxcols)
*
* Logo o cursor da grade tem, no MINIMO, quatro colunas - as duas que a
* grade exibe mais as duas de marcacao:
*
*   Impres    C(30)     SIGCDMP.impres     - nome da impressora (Column1)
*   lSituas   L         (so no cursor)     - impressora ESCOLHIDA (Column2)
*   lMarcas   L         (so no cursor)     - marcacao do PAI (nao exibida)
*   nTpImpres N(4,0)    SIGCDMP.ntpimpres  - tipo da impressora
*
* e dois TAG: "Impres" (ordem alfabetica, a que o Init legado ativa com
* "Set Order to Impres") e "Imprime" (indice FILTRADO For lSituas = .T.,
* criado pelo pai e usado por ele depois que a tela fecha).
*
* lSituas e lMarcas NAO existem em SIGCDMP (conferido em docs\schema.sql,
* lido com Get-Content -Raw por ser UTF-16 - regra #14): sao colunas de
* trabalho que o pai acrescenta ao cursor com o "llFlags as ..." acima.
* nTpImpres aparece explicitamente no cursor do SIGCDTBI e vem no "Select *"
* do sigopcgv; a leitura dele (fase 2) tem de ser guardada por TYPE(), nunca
* presumida, porque nem todo chamador precisa dessa coluna.
*
* O cursor chega VIVO a esta tela porque o form e DataSession = 1
* (compartilhada), igual ao par SIGOPCCL/SIGOPCLP.
*
* COMPORTAMENTO A REPRODUZIR (metodos das fases seguintes)
* --------------------------------------------------------
* O legado tem cinco metodos, e os tres que mexem em dado sao:
*
*   Init                   - Set Order to Impres; SCAN zerando lSituas em
*                            TODAS as linhas; Goto Top; Replace lSituas
*                            With .T. (a PRIMEIRA linha nasce escolhida).
*                            O pai entra aqui com VARIAS linhas marcadas
*                            (ele marca toda impressora achada no painel do
*                            Windows), e e justamente por isso que o Init
*                            zera tudo antes: a tela e de escolha UNICA.
*   Column2.Check1.Valid   - If This.Value: guarda o RECNO, Replace All
*                            lSituas With .F., volta ao RECNO guardado e
*                            Replace lSituas With .T. - comportamento de
*                            radio-button dentro da grade. Desmarcar a
*                            linha corrente (This.Value = .F.) NAO faz
*                            nada: o legado nao entra no If, e a linha
*                            continua escolhida.
*   Column1.Text1.LostFocus- If IsEmpty(This.Value): cmdSair.SetFocus
*                            (navegacao de UI, fica no Form)
*
* "PROCEDURE Load" do legado e "=fConfigGeral()" - inicializacao GLOBAL da
* aplicacao no Fortyus, que na arquitetura nova ja aconteceu antes
* (config.prg + main.prg). O wrapper projeto\app\utils\fconfiggeral.prg
* existe apenas para o p-code dos VCX legado; em codigo nosso essa funcao
* nunca e chamada. Mesma decisao registrada em SigOpClpBO.prg.
*
* GRAVACAO
* --------
* Inserir(), Atualizar(), ExecutarExclusao() e RegistrarAuditoria() ficam
* HERDADOS de BusinessBase - o comportamento padrao herdado (recusar a
* operacao e reportar a recusa pelo ExibirFalha do Salvar, regra #20) ja e
* o correto, porque o dump legado prova que esta tela nao grava no SQL
* Server: zero TABLEUPDATE(, zero .AddCursor(, zero Insert Into / Update /
* Delete From. Os tres Replace que existem tem por destino o CURSOR LOCAL
* csSigCdmp, na coluna lSituas, que nem existe na tabela. Escrever um
* INSERT/UPDATE aqui exigiria ADIVINHAR a lista de colunas, que e o que a
* regra #22 do CLAUDE.md proibe.
*
* Fase 2/8: metodos de Fase 1 + CarregarDoCursor/ObterChavePrimaria/
* CursorPronto/ContarImpressoras/PrepararSelecaoInicial/SelecionarImpressora.
* Inserir(), Atualizar(), ExecutarExclusao() e RegistrarAuditoria() seguem
* SEM override, pela razao exposta acima em "GRAVACAO".
*
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpIpBBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Titulo da janela
    *
    * O Caption do form legado e fixo no SCX ("Seleciona Impressora de
    * Etiquetas / Boletos") e o Init o copia para os DOIS labels da faixa do
    * cabecalho (lblSombra e lblTitulo). Fica em propriedade para o Form ter
    * uma fonte unica em vez de repetir o literal em tres lugares.
    *--------------------------------------------------------------------------
    this_cTitulo = ""               && Caption do form / dos labels da faixa

    *--------------------------------------------------------------------------
    * Cursor da grade e seus indices
    *
    * this_cCursorImpressoras e o alias que a grade consome - "csSigCdmp" no
    * legado, "cursor_4c_Impressoras" no migrado (PILAR 3). E o PAI que cria
    * esse alias; esta tela apenas o localiza, reordena e escreve lSituas.
    *
    * this_cTagImpres e this_cTagImprime guardam os nomes dos dois TAG que o
    * pai cria no cursor, exatamente como o legado os escreve ("Impres" e
    * "Imprime"): o primeiro e o que o Init ativa ("Set Order to Impres"), o
    * segundo e o indice FILTRADO For lSituas = .T. que o pai consulta depois
    * que a tela fecha. Ficam em propriedade em vez de literal espalhado pelo
    * form.
    *
    * this_cOrdemAtual nasce com o TAG "Impres" porque e essa a ordem que o
    * Init legado impoe antes de qualquer outra coisa.
    *--------------------------------------------------------------------------
    this_cCursorImpressoras = ""    && alias da grade (csSigCdmp no legado)
    this_cTagImpres = ""            && TAG Impres  - Index On Impres
    this_cTagImprime = ""           && TAG Imprime - Index On Impres For lSituas
    this_cOrdemAtual = ""           && TAG em vigor na grade

    *--------------------------------------------------------------------------
    * Linha corrente da grade - espelha as colunas do cursor csSigCdmp
    *
    * Column1 (Impres) e somente leitura no SCX legado (Column1.ReadOnly =
    * .T. e Text1.ReadOnly = .T.); quem o usuario edita e so a Column2
    * (lSituas, o CheckBox). lMarcas nao aparece na tela: e a marcacao que o
    * PAI faz ao cruzar o cursor com APRINTERS() do Windows, e esta tela
    * NUNCA a altera - fica declarada porque a linha a carrega e o Form
    * precisa devolve-la intacta ao pai.
    *
    * nTpImpres so existe no cursor de parte dos chamadores (explicito no
    * SIGCDTBI, implicito no "Select *" do sigopcgv): a leitura dele tem de
    * ser guardada por TYPE(<cursor>.nTpImpres) != "U", nunca presumida.
    *--------------------------------------------------------------------------
    this_cImpres = ""               && Impres    C(30)  - nome da impressora
    this_lSituas = .F.              && lSituas   L      - linha escolhida
    this_lMarcas = .F.              && lMarcas   L      - marcacao do pai
    this_nTpImpres = 0              && nTpImpres N(4,0) - tipo da impressora

    *--------------------------------------------------------------------------
    * Resultado da selecao
    *
    * this_cImpressoraSelecionada e o que o chamador consome depois que a
    * tela fecha - o equivalente ao "Locate for lSituas / AllTrim(
    * CsSigCdmp.impres)" que o SIGCDTBI executa na volta.
    *
    * this_nRegistroSelecionado e o RECNO da linha escolhida: e o "lnRecNo"
    * do Check1.Valid legado, guardado ANTES do "Replace All lSituas With
    * .F." para o "Goto ( lnRecNo )" conseguir voltar. Fica em propriedade
    * porque o Form tambem precisa dele para reposicionar a grade.
    *
    * this_nTotalImpressoras e o RECCOUNT do cursor. O pai so abre esta tela
    * quando ha MAIS DE UMA impressora ("If (lnEtqImpres # 1)" no SIGCDTBI,
    * "If (Reccount() # 1 And Reccount() # 0)" no sigopcgv), entao o valor
    * esperado aqui e sempre maior ou igual a 2; guarda-lo permite a tela
    * reagir sem reconsultar o cursor.
    *--------------------------------------------------------------------------
    this_cImpressoraSelecionada = ""  && impressora com lSituas = .T.
    this_nRegistroSelecionado = 0     && RECNO da linha escolhida (lnRecNo)
    this_nTotalImpressoras = 0        && RECCOUNT do cursor da grade

    *==========================================================================
    * Init - Inicializa Business Object
    *
    * DODEFAULT() e a PRIMEIRA linha (BusinessBase.Init poe o BO em modo
    * consulta: this_lEmEdicao / this_lNovoRegistro / this_lDadosAlterados em
    * .F.). Ele e chamado SEM argumento de proposito: passar um nome de
    * tabela faria BusinessBase instanciar um DataAccess, e esta tela nao tem
    * tabela proprietaria.
    *
    * Por isso as duas propriedades herdadas ficam vazias - os nomes corretos
    * sao this_cTabela e this_cCampoChave (nunca this_cTabela /
    * this_cCampoChave).
    *
    * Os defaults atribuidos aqui sao os do legado, nao invencao:
    *   - o Caption e o literal do SCX;
    *   - os dois TAG sao os nomes que os chamadores criam ("Impres" e
    *     "Imprime");
    *   - this_cOrdemAtual nasce em "Impres" porque e a ordem que o Init
    *     legado ativa ("Set Order to Impres").
    * Os demais nascem zerados: so passam a valer quando o cursor do pai for
    * localizado e lido.
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo de selecao: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        *-- Titulo fixo do SCX legado (copiado pelo Init para os dois labels)
        THIS.this_cTitulo = "Seleciona Impressora de Etiquetas / Boletos"

        *-- Cursor da grade e os dois TAG que o form PAI cria nele
        THIS.this_cCursorImpressoras = "cursor_4c_Impressoras"
        THIS.this_cTagImpres = "Impres"
        THIS.this_cTagImprime = "Imprime"
        THIS.this_cOrdemAtual = "Impres"

        *-- Linha corrente (preenchida ao ler o cursor)
        THIS.this_cImpres = ""
        THIS.this_lSituas = .F.
        THIS.this_lMarcas = .F.
        THIS.this_nTpImpres = 0

        *-- Resultado da selecao
        THIS.this_cImpressoraSelecionada = ""
        THIS.this_nRegistroSelecionado = 0
        THIS.this_nTotalImpressoras = 0

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CursorPronto - confere o contrato do cursor com o form pai
    *
    * O form pai monta o cursor ANTES de abrir esta tela (regra do cabecalho
    * do arquivo: SIGCDTBI e sigopcgv). Se o alias nao chegou, ou chegou sem
    * a estrutura esperada, a grade nao tem a que se ligar - melhor
    * descobrir isso antes de tocar em RecordSource/ControlSource do que ver
    * a grade virar um retangulo branco (regra #46).
    *
    * Impres e lSituas sao as duas colunas que a grade exibe/edita; lMarcas
    * e exigida porque esta tela devolve a linha intacta ao pai (this_lMarcas
    * nunca e reescrito por aqui). nTpImpres NAO entra nesta conferencia - so
    * parte dos chamadores a inclui (regra do cabecalho do arquivo).
    *
    * this_cTagImpres e o TAG que PrepararSelecaoInicial precisa para o
    * "Set Order to Impres" do legado; sua ausencia indica cursor fora do
    * contrato tanto quanto a falta de uma coluna.
    *
    * Retorno: .T. quando o alias existe, tem as 3 colunas e o TAG de ordem;
    *          .F. caso contrario, com this_cMensagemErro preenchido.
    *==========================================================================
    PROCEDURE CursorPronto()
        LOCAL loc_lPronto, loc_cAlias

        loc_lPronto = .F.
        loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)

        DO CASE
            CASE EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "O cursor de impressoras n" + CHR(227) + ;
                    "o foi recebido da tela de origem."

            CASE TYPE(loc_cAlias + ".Impres") = "U" OR ;
                 TYPE(loc_cAlias + ".lSituas") = "U" OR ;
                 TYPE(loc_cAlias + ".lMarcas") = "U"
                THIS.this_cMensagemErro = "O cursor de impressoras n" + CHR(227) + ;
                    "o tem a estrutura esperada."

            CASE TAGNO(ALLTRIM(THIS.this_cTagImpres), "", loc_cAlias) = 0
                THIS.this_cMensagemErro = "O cursor de impressoras chegou sem o " + ;
                    CHR(237) + "ndice de ordena" + CHR(231) + CHR(227) + "o."

            OTHERWISE
                THIS.this_cMensagemErro = ""
                loc_lPronto = .T.
        ENDCASE

        RETURN loc_lPronto
    ENDPROC

    *==========================================================================
    * ContarImpressoras - quantas linhas o cursor da grade tem
    *
    * RECCOUNT(alias) le a contagem sem mexer no ponteiro de registro e sem
    * trocar a area de trabalho. Devolve 0 quando o alias nao existe.
    *==========================================================================
    PROCEDURE ContarImpressoras()
        LOCAL loc_cAlias

        loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)

        IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
            RETURN 0
        ENDIF

        RETURN RECCOUNT(loc_cAlias)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a LINHA CORRENTE do cursor da grade para as
    * propriedades e recalcula o resumo da selecao (this_cImpressoraSelecionada
    * / this_nRegistroSelecionado / this_nTotalImpressoras).
    *
    * par_cAliasCursor chega do Form (THIS.this_cCursorImpressoras, "cursor_4c_
    * Impressoras") - cai no fallback da property quando vier vazio, igual ao
    * SigOpClpBO.CarregarDoCursor (mesma familia de dialogo-sem-tabela).
    *
    * Impres e lSituas sao OBRIGATORIAS nos dois chamadores conhecidos (regra
    * do cabecalho do arquivo); lMarcas tambem, mas nunca e reescrita por
    * esta tela. nTpImpres so existe em PARTE dos cursores - conferida com
    * TYPE(), nunca presumida (PEMSTATUS nao serve para alias de cursor).
    *
    * O resumo da selecao (qual linha tem lSituas = .T.) e recalculado a
    * cada chamada varrendo o cursor INTEIRO com LOCATE, nao so a linha
    * corrente - equivalente ao "Locate for lSituas" que o SIGCDTBI executa
    * depois que a tela fecha, so que mantido vivo enquanto o usuario ainda
    * navega na grade. O RECNO da linha corrente e salvo e reposto, porque
    * o LOCATE move o ponteiro do cursor.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasAnterior, loc_nRecnoAtual, loc_oErro

        loc_lSucesso = .F.
        loc_cAliasAnterior = ALIAS()
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        IF EMPTY(loc_cAlias)
            loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)
        ENDIF

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) ;
                    AND TYPE(loc_cAlias + ".Impres") != "U" ;
                    AND TYPE(loc_cAlias + ".lSituas") != "U"

                SELECT (loc_cAlias)

                IF !EOF() AND !BOF()
                    THIS.this_cImpres = ALLTRIM(TratarNulo(Impres, ""))
                    THIS.this_lSituas = ConverterParaLogico(lSituas)

                    IF TYPE(loc_cAlias + ".lMarcas") != "U"
                        THIS.this_lMarcas = ConverterParaLogico(lMarcas)
                    ELSE
                        THIS.this_lMarcas = .F.
                    ENDIF

                    IF TYPE(loc_cAlias + ".nTpImpres") != "U"
                        THIS.this_nTpImpres = TratarNulo(nTpImpres, 0)
                    ELSE
                        THIS.this_nTpImpres = 0
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF

                *-- Resumo do cursor inteiro, sem perder a posicao da linha
                *-- corrente (regra #21: popular/reordenar cursor nao repinta
                *-- grade sozinho, mas aqui o que importa e nao perder RECNO).
                THIS.this_nTotalImpressoras = RECCOUNT(loc_cAlias)
                loc_nRecnoAtual = RECNO(loc_cAlias)

                LOCATE FOR lSituas

                IF FOUND()
                    THIS.this_cImpressoraSelecionada = ALLTRIM(TratarNulo(Impres, ""))
                    THIS.this_nRegistroSelecionado = RECNO(loc_cAlias)
                ELSE
                    THIS.this_cImpressoraSelecionada = ""
                    THIS.this_nRegistroSelecionado = 0
                ENDIF

                IF loc_nRecnoAtual > 0 AND loc_nRecnoAtual <= RECCOUNT(loc_cAlias)
                    GO loc_nRecnoAtual
                ENDIF
            ENDIF

            IF !loc_lSucesso
                *-- Sem linha para ler: zera a linha corrente, para a tela
                *-- nao exibir o resto de uma leitura anterior como se fosse
                *-- a atual.
                THIS.this_cImpres = ""
                THIS.this_lSituas = .F.
                THIS.this_lMarcas = .F.
                THIS.this_nTpImpres = 0
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        *-- Devolve a area de trabalho de quem chamou (sessao compartilhada -
        *-- regra do cabecalho: DataSession = 1, igual ao par SIGOPCCL/SIGOPCLP)
        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarLinhaCorrente - le a linha corrente do cursor da grade
    *
    * Atalho usado pelo Form quando o usuario navega na grade: evita repetir
    * o nome do cursor em cada chamada e garante que a leitura seja sempre do
    * alias que o form pai entregou (this_cCursorImpressoras).
    *==========================================================================
    PROCEDURE CarregarLinhaCorrente()
        RETURN THIS.CarregarDoCursor(THIS.this_cCursorImpressoras)
    ENDPROC

    *==========================================================================
    * LimparDados - zera as propriedades de linha
    *
    * DODEFAULT() limpa this_cMensagemErro na base. O contrato do cursor
    * (nome do alias e dos dois TAG) e o resumo da selecao NAO sao limpos
    * aqui de proposito: eles identificam o dialogo aberto, nao a linha
    * corrente, e continuam valendo enquanto o form existir.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cImpres = ""
        THIS.this_lSituas = .F.
        THIS.this_lMarcas = .F.
        THIS.this_nTpImpres = 0
    ENDPROC

    *==========================================================================
    * PrepararSelecaoInicial - transcricao do SIGOPIPB.Init
    *
    *   Select csSigCdmp
    *   Set Order to Impres
    *   Scan
    *       Replace csSigCdmp.lSituas With .F.
    *   EndScan
    *   Goto Top
    *   Replace csSigCdmp.lSituas With .T.
    *
    * O pai entra nesta tela com VARIAS linhas ja marcadas (ele marca toda
    * impressora achada no painel do Windows, para alimentar lMarcas) - e e
    * justamente por isso que o Init legado zera lSituas em TODAS as linhas
    * antes de escolher a primeira: esta tela e de escolha UNICA, nao de
    * marcacao multipla. A ordem "Impres" (alfabetica) e ativada ANTES do
    * SCAN, para a "primeira linha" ser a mesma que o usuario ve no topo da
    * grade.
    *
    * Chamado uma unica vez pelo Form, no InicializarForm - igual ao Init do
    * legado, que roda uma unica vez quando a tela e aberta.
    *
    * Retorno: .T. quando preparou; .F. quando o cursor nao chegou no
    * contrato esperado (this_cMensagemErro fica preenchido por
    * CursorPronto, que e conferido ANTES de tocar no cursor).
    *==========================================================================
    PROCEDURE PrepararSelecaoInicial()
        LOCAL loc_lSucesso, loc_cAlias, loc_cComando, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)

        IF !THIS.CursorPronto()
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cAlias)

            *-- SET ORDER TO TAG nao aceita o nome por expressao entre
            *-- parenteses - o nome tem de ser literal no comando, por isso
            *-- vai por macro-substituicao (igual a SigOpClpBO.AplicarOrdem).
            loc_cComando = "SET ORDER TO TAG " + ALLTRIM(THIS.this_cTagImpres)
            &loc_cComando

            SCAN
                REPLACE lSituas WITH .F.
            ENDSCAN

            GO TOP

            IF !EOF()
                REPLACE lSituas WITH .T.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em PrepararSelecaoInicial")
        ENDTRY

        IF loc_lSucesso
            THIS.CarregarDoCursor(loc_cAlias)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SelecionarImpressora - transcricao do
    * SIGOPIPB.GrdImpres.Column2.Check1.Valid
    *
    *   Local lnRecNo
    *   If This.Value
    *       Select csSigCdmp
    *       lnRecNo = RecNo('csSigCdmp')
    *       Replace All lSituas With .F.
    *       Goto ( lnRecNo )
    *       Replace lSituas With .T.
    *   EndIf
    *
    * par_nRecno e o RECNO da linha em que o usuario marcou o CheckBox - o
    * "This.Value" do legado e testado no Form (so chama este metodo quando
    * o CheckBox foi MARCADO; desmarcar a linha corrente nao faz nada, igual
    * ao legado, que simplesmente nao entra no If quando This.Value = .F.).
    *
    * Comportamento de radio-button dentro da grade: zera TODAS as linhas e
    * marca so a que o usuario escolheu. O RECNO vem por PARAMETRO (nao do
    * RECNO corrente no momento da chamada) porque o "Replace All" muda o
    * conteudo do cursor mas NAO move o ponteiro - exatamente como no
    * legado, que guarda lnRecNo ANTES do Replace All para o "Goto" seguinte
    * funcionar.
    *
    * Atualiza this_cImpressoraSelecionada e this_nRegistroSelecionado -
    * equivalente ao "Locate for lSituas" que o form pai faz depois que a
    * tela fecha, mantido vivo para o Form conseguir reposicionar a grade.
    *
    * Retorno: .T. quando marcou; .F. quando o RECNO nao existe no cursor ou
    * o alias nao esta disponivel.
    *==========================================================================
    PROCEDURE SelecionarImpressora(par_nRecno)
        LOCAL loc_lSucesso, loc_cAlias, loc_nRecno, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = ALLTRIM(THIS.this_cCursorImpressoras)
        loc_nRecno = IIF(VARTYPE(par_nRecno) = "N", par_nRecno, 0)

        IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        IF loc_nRecno <= 0 OR loc_nRecno > RECCOUNT(loc_cAlias)
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cAlias)

            REPLACE ALL lSituas WITH .F.
            GO loc_nRecno
            REPLACE lSituas WITH .T.

            THIS.this_cImpressoraSelecionada = ALLTRIM(TratarNulo(Impres, ""))
            THIS.this_nRegistroSelecionado = loc_nRecno

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em SelecionarImpressora")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - identidade da linha corrente da grade
    *
    * Sobrescreve o hook de BusinessBase (continua PROTECTED - regra #51).
    * Nunca e efetivamente invocado neste BO: RegistrarAuditoria so e
    * chamada por Inserir()/Atualizar()/ExecutarExclusao(), e os tres
    * permanecem herdados (ver "GRAVACAO" no cabecalho do arquivo) porque
    * esta tela nao grava nada no SQL Server. Fica implementado apenas para
    * o BO seguir o mesmo contrato dos demais - a chave natural da linha,
    * dentro do cursor que o pai montou, e o proprio nome da impressora.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cImpres
    ENDPROC

ENDDEFINE
