*==============================================================================
* SigOpClpBO.prg
*
* Business Object para SigOpClp (Pesquisa Operacoes da Conta)
*
* Tabela: (nenhuma - visualizador sem persistencia propria)
*
* ORIGEM LEGADA
* -------------
* SigOpClp.SCX eh o dialogo FILHO que SIGOPCCL abre no fim da consulta:
*
*     Do Form SigOpClp With ThisForm, ThisForm.datasessionid
*
* O form legado recebe DOIS parametros (pForm = form PAI, DatSes = id da
* data session do pai), faz "Set DataSession To DatSes" para entrar na
* MESMA sessao de dados do pai e liga a grade ao cursor que o PAI ja
* montou - "TmpOper" no legado, "cursor_4c_Operacoes" no migrado
* (SigOpCclBO.RecriarCursorOperacoes / CarregarMovimentos).
*
* Dai o escopo deste BO: ele NAO consulta SigMvCab nem SigCdOpe, porque
* quem faz isso eh SigOpCclBO.BuscarOperacoes() no form PAI. Tudo o que o
* legado faz aqui eh LEITURA do cursor recebido:
*
*   SIGOPCLP.Init                 le ParentForm.Origem.get_grupo /
*                                 get_Conta / get_dConta para montar o
*                                 Caption, e liga as 7 colunas da grade
*                                 a TmpOper.<coluna>
*   fwgrade.dopes.Header1.Click   "Set Order To Num" (reordena por
*                                 Emps + Dopes + MascNum, ascendente)
*   fwgrade.datas.Header1.Click   "Set Order To Datas Descending"
*   fwgrade.valos.Text1.KeyPress  TAB (9) move o foco para cmd_sair
*   grp_operacao.cmd_sair.Click   reabilita o pai, devolve o foco a
*                                 get_grupo do pai e libera a tela
*
* Por isso Inserir(), Atualizar() e ExecutarExclusao() ficam SEM override:
* o comportamento padrao herdado de BusinessBase (recusar a operacao e
* reportar pelo ExibirFalha do Salvar) ja eh o correto, porque nao existe
* NENHUMA tabela proprietaria para gravar - inventar INSERT/UPDATE aqui
* violaria a regra #22 do CLAUDE.md (a lista de colunas vem do schema,
* nunca de adivinhacao). RegistrarAuditoria() fica herdado pelo mesmo
* motivo: a base so o chama em operacao de ESCRITA, e aqui nao ha nenhuma.
* ObterChavePrimaria() EH sobrescrito (Fase 2), porque a linha corrente da
* grade tem identidade: eh a chave composta do TAG Num do cursor.
*
* O "PROCEDURE Load" do legado ("=fConfigGeral()") fica de fora: no
* Fortyus fConfigGeral era inicializacao GLOBAL da aplicacao, e na
* arquitetura nova isso ja aconteceu antes (config.prg + main.prg + os
* cursores de cada BO). O wrapper projeto\app\utils\fconfiggeral.prg
* existe APENAS para o p-code dos VCX legado - em codigo nosso essa
* funcao nunca eh chamada.
*
* ESTRUTURA DO CURSOR DA GRADE (contrato com SigOpCclBO)
* ------------------------------------------------------
* O "Create Cursor TmpOper" do pai, reproduzido em
* SigOpCclBO.RecriarCursorOperacoes(), eh:
*
*   (Emps C(3), Dopes C(20), MascNum C(10), Tipo C(10), Moeda C(3),
*    Valos N(12,2), Datas T NULL)
*   INDEX ON Emps + Dopes + MascNum TAG Num
*   INDEX ON Datas                  TAG Datas
*
* A ordem e as larguras dos campos sao as MESMAS em todo ponto que cria
* este cursor (exigencia do CLAUDE.md para CREATE CURSOR repetido), e as
* propriedades de linha declaradas abaixo espelham exatamente essas sete
* colunas, com a origem de cada uma conferida em docs\schema.sql (lido com
* Get-Content -Raw, porque o arquivo eh UTF-16 - regra #14):
*
*   Emps    <- SigMvCab.emps     char(3)
*   Dopes   <- SigMvCab.dopes    char(20)
*   MascNum <- ALLTRIM(fGerMascara(SigMvCab.numes numeric(6,0))), gravado
*              na largura de SigMvCab.mascnum char(10)
*   Tipo    <- literal "Destino" ou "Origem" (lado do movimento que o pai
*              consultou: GrupoDs/ContaDs ou GrupoOs/ContaOs)
*   Moeda   <- SigCdOpe.cmoes char(3), ou SigCdPam.moedaps char(3) quando
*              cmoes vem vazio
*   Valos   <- SigMvCab.valos    numeric(11,2)
*   Datas   <- SigMvCab.datas    datetime NULL
*
* Os dois nomes de TAG tambem fazem parte desse contrato: sao eles que os
* Header1.Click das colunas Operacao e Data usam no "Set Order To".
*
* Fase 1/8 - declaracao das propriedades e Init().
* Fase 2/8 - metodos de acesso ao registro (CarregarDoCursor, LimparDados,
*            ObterChavePrimaria, parametros/titulo da consulta, contrato do
*            cursor e as duas reordenacoes dos Header1.Click do legado).
*==============================================================================

DEFINE CLASS SigOpClpBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros recebidos do form PAI (SIGOPCCL)
    *
    * O legado le estes tres valores direto do pai, no Init, para montar o
    * Caption: 'Pesquisa Operacoes da Conta : ' + Alltrim(get_grupo.Value) +
    * ' / ' + Alltrim(get_Conta.Value) + ' - ' + Alltrim(get_dConta.Value).
    * Sao os MESMOS valores que SigOpCclBO guarda em this_cGrupo /
    * this_cConta / this_cDConta e usa como filtro de SigMvCab.
    *--------------------------------------------------------------------------
    this_cGrupo = ""                && SigMvCab.grupods/grupoos char(10)
    this_cConta = ""                && SigMvCab.contads/contaos char(10)
    this_cDConta = ""               && SigCdCli.rclis char(50) - nome da conta

    *--------------------------------------------------------------------------
    * Cursor da grade e seus indices
    *
    * this_cCursorOperacoes eh o alias que a grade consome - "TmpOper" no
    * legado, "cursor_4c_Operacoes" no migrado, o mesmo nome que
    * SigOpCclBO.Init fixa na propriedade homonima. Como o form pai eh
    * DataSession = 1 (compartilhada), o alias chega vivo a esta tela.
    *
    * this_cTagNumero e this_cTagData guardam os nomes dos dois TAG que o
    * pai cria no cursor; sao exatamente os nomes usados pelos
    * Header1.Click do legado ("Set Order To Num" e "Set Order To Datas
    * Descending"), e por isso ficam em propriedade em vez de literal
    * espalhado pelo form.
    *
    * this_cOrdemAtual nasce com o TAG "Num" porque eh essa a ordem em que
    * o pai entrega o cursor: antes de abrir esta tela ele executa
    * "SELECT (cursor) / SET ORDER TO TAG Num / GO TOP".
    *--------------------------------------------------------------------------
    this_cCursorOperacoes = ""      && alias da grade (TmpOper no legado)
    this_cTagNumero = ""            && TAG Num   - Emps + Dopes + MascNum
    this_cTagData = ""              && TAG Datas - Datas
    this_cOrdemAtual = ""           && TAG em vigor na grade
    this_lOrdemDescendente = .F.    && .T. quando a ordem corrente eh DESCENDING

    *--------------------------------------------------------------------------
    * Linha corrente da grade - espelha as 7 colunas do cursor TmpOper
    *
    * A grade do legado eh somente leitura (fwgrade.ReadOnly = .T. e as
    * sete Column<N>.ReadOnly = .T.), entao estas propriedades sao de
    * LEITURA: servem para o form publicar a linha selecionada sem ler o
    * cursor direto.
    *
    * this_dDatas acompanha a convencao do projeto ({} na declaracao) mesmo
    * sendo a coluna um datetime: a leitura normaliza o valor com
    * ConverterParaData(), nunca com TTOD() direto, porque TTOD() aceita
    * SO DATETIME e estoura erro 11 em runtime quando recebe um DATE
    * (regra #16).
    *--------------------------------------------------------------------------
    this_cEmps = ""                 && Emps    C(3)
    this_cDopes = ""                && Dopes   C(20)
    this_cMascNum = ""              && MascNum C(10)
    this_cTipo = ""                 && Tipo    C(10) - "Destino" ou "Origem"
    this_cMoeda = ""                && Moeda   C(3)
    this_nValos = 0                 && Valos   N(12,2)
    this_dDatas = {}                && Datas   T NULL

    *==========================================================================
    * Init - Inicializa Business Object
    *
    * DODEFAULT() eh a PRIMEIRA linha (BusinessBase.Init poe o BO em modo
    * consulta: this_lEmEdicao / this_lNovoRegistro / this_lDadosAlterados
    * em .F.). Ele eh chamado SEM argumento de proposito: passar um nome de
    * tabela faria BusinessBase instanciar um DataAccess, e esta tela nao
    * tem tabela proprietaria.
    *
    * Por isso as duas propriedades herdadas ficam vazias - os nomes
    * corretos sao this_cTabela e this_cCampoChave (nunca
    * this_cTabela / this_cCampoChave).
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Visualizador parametrizado: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        *-- Parametros vindos do form pai (preenchidos quando a tela abre)
        THIS.this_cGrupo = ""
        THIS.this_cConta = ""
        THIS.this_cDConta = ""

        *-- Cursor da grade e os dois TAG que o form pai cria nele
        THIS.this_cCursorOperacoes = "cursor_4c_Operacoes"
        THIS.this_cTagNumero = "Num"
        THIS.this_cTagData = "Datas"

        *-- O pai entrega o cursor em "SET ORDER TO TAG Num" + GO TOP
        THIS.this_cOrdemAtual = THIS.this_cTagNumero
        THIS.this_lOrdemDescendente = .F.

        *-- Linha corrente da grade
        THIS.this_cEmps = ""
        THIS.this_cDopes = ""
        THIS.this_cMascNum = ""
        THIS.this_cTipo = ""
        THIS.this_cMoeda = ""
        THIS.this_nValos = 0
        THIS.this_dDatas = {}

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FASE 2/8 - METODOS DE ACESSO AO REGISTRO
    *
    * ESCOPO DESTA FASE NESTE BO
    * --------------------------
    * O trio canonico de um BO de cadastro eh CarregarDoCursor() para ler a
    * linha, Inserir() para o INSERT e Atualizar() para o UPDATE. Aqui so o
    * primeiro tem conteudo proprio; os outros dois ficam exatamente como
    * BusinessBase os entrega.
    *
    * O motivo eh estrutural. O SCX legado SigOpClp.SCX nao tem UMA LINHA de
    * gravacao - conferido no dump tasks\task704\SigOpClp_form_codigo_fonte.txt:
    * zero TABLEUPDATE(, zero .AddCursor(, zero Insert Into / Update /
    * Delete From. Os seis metodos do legado sao Init (monta o Caption e liga a
    * grade), Load (=fConfigGeral()), os dois Header1.Click que reordenam o
    * cursor, um KeyPress que move o foco e o cmd_sair.Click que devolve o
    * controle ao form pai. A tela EXIBE o cursor que o pai montou - ela nao
    * possui tabela.
    *
    * Sem tabela de destino, escrever um INSERT/UPDATE aqui exigiria ADIVINHAR
    * a lista de colunas, que eh justamente o que a regra #22 do CLAUDE.md
    * proibe (a lista vem do schema, nunca de adivinhacao). E
    * BusinessBase.Inserir()/Atualizar() ja recusam a operacao e devolvem .F.
    * com this_cMensagemErro preenchido, que eh o comportamento correto: o
    * Salvar da base reporta a recusa pelo ExibirFalha (regra #20). Herdar eh,
    * portanto, a resposta certa.
    *
    * RegistrarAuditoria() segue a mesma linha e tambem fica herdado: a
    * auditoria registra operacao de ESCRITA (a base a chama em Inserir,
    * Atualizar e ExecutarExclusao), e esta tela nao executa nenhuma.
    * ObterChavePrimaria(), que eh o hook de identidade usado por essa
    * maquinaria, EH sobrescrito abaixo, porque a linha corrente da grade tem
    * identidade bem definida - a mesma chave composta do TAG Num do cursor.
    *
    * ESCOPO DE CADA METODO
    * ---------------------
    *   CarregarDoCursor           le as 7 colunas da linha corrente
    *   CarregarLinhaCorrente      atalho: CarregarDoCursor no cursor da grade
    *   LimparDados                zera as 7 propriedades de linha
    *   ObterChavePrimaria         chave composta Emps + Dopes + MascNum
    *   DefinirParametrosConsulta  recebe Grupo/Conta/Descricao do form pai
    *   ObterTituloConsulta        monta o Caption do legado
    *   CursorPronto               confere o contrato do cursor com o pai
    *   ContarOperacoes            RECCOUNT do cursor da grade
    *   PosicionarNoTopo           SELECT + GO TOP (par do Refresh da grade)
    *   OrdenarPorNumero           Header1.Click da coluna Operacao
    *   OrdenarPorData             Header1.Click da coluna Data
    *   AplicarOrdem               corpo comum das duas reordenacoes
    *==========================================================================

    *==========================================================================
    * CarregarDoCursor - le a linha corrente do cursor para as propriedades
    *
    * par_cAliasCursor - alias a ler. Normalmente THIS.this_cCursorOperacoes,
    *                    mas fica parametrizado para manter a assinatura da
    *                    base (BusinessBase.CarregarDoCursor(pcCursor)).
    *
    * Retorno: .T. quando havia linha e as 7 propriedades foram preenchidas;
    *          .F. quando o alias nao existe, esta em EOF/BOF ou nao tem a
    *          estrutura esperada - e nesse caso as propriedades sao zeradas,
    *          para a tela nunca exibir o resto de uma leitura anterior.
    *
    * TRES cuidados obrigatorios:
    *
    * 1) SELECT (par_cAliasCursor) ANTES de tocar nos campos. A sintaxe
    *    campo NAO existe em VFP9 e produz "Function name is
    *    missing )". Depois do SELECT os campos sao lidos pelo nome nu (Emps,
    *    Dopes, ...), sem prefixo de alias - padrao canonico do metodo.
    *
    * 2) A area de trabalho anterior eh RESTAURADA no fim. O form pai eh
    *    DataSession = 1 (compartilhada, igual ao legado) e esta tela entra na
    *    MESMA sessao, entao trocar a area corrente e deixar assim alteraria o
    *    estado de quem chamou. O ponteiro de registro nao eh tocado: SELECT
    *    muda de area, nunca de RECNO.
    *
    * 3) A existencia de cada coluna eh conferida com TYPE(alias + ".campo"),
    *    NUNCA com PEMSTATUS - PEMSTATUS exige OBJETO no 1o argumento, e passar
    *    um alias de cursor dispara o erro 11 do VFP9.
    *
    * Sobre os tipos: Datas eh datetime NULL no cursor e por isso passa por
    * ConverterParaData() - TTOD() aceita SO DATETIME e estoura o erro 11
    * quando recebe DATE (regra #16). Valos eh numerico e usa TratarNulo com
    * padrao 0. As colunas char usam TratarNulo com padrao "" mais ALLTRIM,
    * porque o que a tela publica eh texto de exibicao; o padding posicional
    * importa apenas em ObterChavePrimaria, que o remonta com PADR (regra #42).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasAnterior, loc_oErro

        loc_lSucesso = .F.
        loc_cAliasAnterior = ALIAS()
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        IF EMPTY(loc_cAlias)
            loc_cAlias = ALLTRIM(THIS.this_cCursorOperacoes)
        ENDIF

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) ;
                    AND TYPE(loc_cAlias + ".Emps") != "U" ;
                    AND TYPE(loc_cAlias + ".Dopes") != "U" ;
                    AND TYPE(loc_cAlias + ".MascNum") != "U" ;
                    AND TYPE(loc_cAlias + ".Tipo") != "U" ;
                    AND TYPE(loc_cAlias + ".Moeda") != "U" ;
                    AND TYPE(loc_cAlias + ".Valos") != "U" ;
                    AND TYPE(loc_cAlias + ".Datas") != "U"

                SELECT (loc_cAlias)

                IF !EOF() AND !BOF()
                    THIS.this_cEmps    = ALLTRIM(TratarNulo(Emps, ""))
                    THIS.this_cDopes   = ALLTRIM(TratarNulo(Dopes, ""))
                    THIS.this_cMascNum = ALLTRIM(TratarNulo(MascNum, ""))
                    THIS.this_cTipo    = ALLTRIM(TratarNulo(Tipo, ""))
                    THIS.this_cMoeda   = ALLTRIM(TratarNulo(Moeda, ""))
                    THIS.this_nValos   = TratarNulo(Valos, 0)
                    THIS.this_dDatas   = ConverterParaData(Datas)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF !loc_lSucesso
                *-- Sem linha para ler: zera, para a tela nao exibir o resto de
                *-- uma leitura anterior como se fosse a linha atual.
                THIS.this_cEmps    = ""
                THIS.this_cDopes   = ""
                THIS.this_cMascNum = ""
                THIS.this_cTipo    = ""
                THIS.this_cMoeda   = ""
                THIS.this_nValos   = 0
                THIS.this_dDatas   = {}
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        *-- Devolve a area de trabalho de quem chamou (sessao compartilhada)
        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarLinhaCorrente - le a linha corrente do cursor da grade
    *
    * Atalho usado pelo form quando o usuario navega na grade: evita repetir o
    * nome do cursor em cada chamada e garante que a leitura seja sempre do
    * alias que o form pai entregou (this_cCursorOperacoes).
    *
    * Retorno: o mesmo de CarregarDoCursor.
    *==========================================================================
    PROCEDURE CarregarLinhaCorrente()
        RETURN THIS.CarregarDoCursor(THIS.this_cCursorOperacoes)
    ENDPROC

    *==========================================================================
    * LimparDados - zera as propriedades de linha
    *
    * DODEFAULT() limpa this_cMensagemErro na base. Os parametros recebidos do
    * form pai (this_cGrupo/this_cConta/this_cDConta) e o contrato do cursor
    * (nome do alias e nomes dos dois TAG) NAO sao limpos aqui de proposito:
    * eles identificam a CONSULTA aberta na tela, nao a linha selecionada, e
    * continuam valendo enquanto o form existir.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cEmps    = ""
        THIS.this_cDopes   = ""
        THIS.this_cMascNum = ""
        THIS.this_cTipo    = ""
        THIS.this_cMoeda   = ""
        THIS.this_nValos   = 0
        THIS.this_dDatas   = {}
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - identidade da linha corrente da grade
    *
    * Sobrescreve o hook de BusinessBase. Continua PROTECTED porque na base ele
    * eh PROTECTED: de fora ninguem chama este metodo (regra #51).
    *
    * A chave eh a MESMA do TAG Num que o form pai cria no cursor:
    *
    *     INDEX ON Emps + Dopes + MascNum TAG Num
    *
    * Isso faz dela uma chave POSICIONAL: no cursor Emps eh C(3), Dopes eh
    * C(20) e MascNum eh C(10), logo a concatenacao dos campos carrega o padding
    * de cada coluna e mede 3 + 20 + 10 = 33 caracteres. As propriedades, ao
    * contrario, guardam o valor com ALLTRIM (CarregarDoCursor publica texto de
    * exibicao), entao remontar a chave exige PADR nas larguras do cursor -
    * ALLTRIM nas PARTES encurtaria a chave e ela nunca casaria com o indice
    * (regra #42; a conferencia eh a soma das larguras dar os 33 esperados).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + ;
               PADR(THIS.this_cDopes, 20) + ;
               PADR(THIS.this_cMascNum, 10)
    ENDPROC

    *==========================================================================
    * DefinirParametrosConsulta - recebe do form pai os tres valores do Caption
    *
    * par_cGrupo  - ParentForm.Origem.get_grupo.Value  (cnt_4c_Origem.txt_4c_Grupo)
    * par_cConta  - ParentForm.Origem.get_Conta.Value  (cnt_4c_Origem.txt_4c_Conta)
    * par_cDConta - ParentForm.Origem.get_dConta.Value (cnt_4c_Origem.txt_4c_DConta)
    *
    * O legado le estes tres valores DIRETO do form pai, no Init
    * (ThisForm.ParentForm.Origem.get_grupo.Value e os dois irmaos). Aqui eles
    * entram por parametro para o BO nao depender da arvore de objetos do pai -
    * sao os mesmos valores que SigOpCclBO usou como filtro de SigMvCab.
    *
    * VARTYPE eh conferido em cada argumento porque TextBox.Value pode chegar
    * como logico .F. quando o controle nasceu sem inicializacao, e ALLTRIM de
    * logico dispara o erro 11 do VFP9.
    *
    * Retorno: .T. quando Grupo e Conta chegaram preenchidos (o par que
    * identifica a conta consultada); .F. caso contrario, com
    * this_cMensagemErro preenchido. A descricao da conta pode vir vazia sem
    * invalidar nada - o legado apenas a concatena no Caption.
    *==========================================================================
    PROCEDURE DefinirParametrosConsulta(par_cGrupo, par_cConta, par_cDConta)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        THIS.this_cGrupo = IIF(VARTYPE(par_cGrupo) = "C", ALLTRIM(par_cGrupo), "")
        THIS.this_cConta = IIF(VARTYPE(par_cConta) = "C", ALLTRIM(par_cConta), "")
        THIS.this_cDConta = IIF(VARTYPE(par_cDConta) = "C", ALLTRIM(par_cDConta), "")

        IF EMPTY(THIS.this_cGrupo) OR EMPTY(THIS.this_cConta)
            THIS.this_cMensagemErro = "Grupo e Conta de origem s" + CHR(227) + ;
                "o obrigat" + CHR(243) + "rios para a pesquisa de opera" + ;
                CHR(231) + CHR(245) + "es."
        ELSE
            THIS.this_cMensagemErro = ""
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterTituloConsulta - monta o Caption da tela, igual ao legado
    *
    * Transcricao do Init de SIGOPCLP:
    *
    *   ThisForm.Caption = 'Pesquisa Operacoes da Conta : ' + ;
    *                      Alltrim(...get_grupo.Value)  + ' / ' + ;
    *                      Alltrim(...get_Conta.Value)  + ' - ' + ;
    *                      Alltrim(...get_dConta.Value)
    *
    * Os separadores sao exatamente os do legado (espaco-barra-espaco entre
    * Grupo e Conta, espaco-hifen-espaco antes da descricao) e os acentos vem
    * por CHR(): CHR(231) = c-cedilha, CHR(245) = o-tilde (regra #4). Esse
    * mesmo texto alimenta o Caption do form e os dois labels da faixa do
    * cabecalho (lblSombra e lblTitulo no legado).
    *
    * As propriedades ja chegam com ALLTRIM aplicado por
    * DefinirParametrosConsulta, o que reproduz os Alltrim() do legado.
    *==========================================================================
    PROCEDURE ObterTituloConsulta()
        RETURN "Pesquisa Opera" + CHR(231) + CHR(245) + "es da Conta : " + ;
               THIS.this_cGrupo + " / " + ;
               THIS.this_cConta + " - " + ;
               THIS.this_cDConta
    ENDPROC

    *==========================================================================
    * CursorPronto - confere o contrato do cursor com o form pai
    *
    * O form pai (SigOpCclBO.RecriarCursorOperacoes) cria o cursor com as sete
    * colunas Emps, Dopes, MascNum, Tipo, Moeda, Valos e Datas e os dois TAG
    * Num e Datas. Esta tela nao monta nada: ela recebe esse alias vivo pela
    * data session compartilhada. Se o alias nao chegou, ou chegou sem a
    * estrutura esperada, a grade nao tem a que se ligar - e eh melhor
    * descobrir isso antes de mexer em RecordSource/ControlSource do que ver a
    * grade virar um retangulo branco.
    *
    * As colunas sao conferidas com TYPE(alias + ".campo"), nunca com
    * PEMSTATUS (erro 11 com alias de cursor). Os TAG sao conferidos com
    * TAGNO(), que devolve 0 quando o TAG nao existe.
    *
    * Retorno: .T. quando o alias existe, tem as 7 colunas e os 2 TAG;
    *          .F. caso contrario, com this_cMensagemErro preenchido.
    *==========================================================================
    PROCEDURE CursorPronto()
        LOCAL loc_lPronto, loc_cAlias

        loc_lPronto = .F.
        loc_cAlias = ALLTRIM(THIS.this_cCursorOperacoes)

        DO CASE
            CASE EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "O cursor de opera" + CHR(231) + ;
                    CHR(245) + "es n" + CHR(227) + "o foi recebido da tela de consulta."

            CASE TYPE(loc_cAlias + ".Emps") = "U" OR ;
                 TYPE(loc_cAlias + ".Dopes") = "U" OR ;
                 TYPE(loc_cAlias + ".MascNum") = "U" OR ;
                 TYPE(loc_cAlias + ".Tipo") = "U" OR ;
                 TYPE(loc_cAlias + ".Moeda") = "U" OR ;
                 TYPE(loc_cAlias + ".Valos") = "U" OR ;
                 TYPE(loc_cAlias + ".Datas") = "U"
                THIS.this_cMensagemErro = "O cursor de opera" + CHR(231) + ;
                    CHR(245) + "es n" + CHR(227) + "o tem a estrutura esperada."

            CASE TAGNO(ALLTRIM(THIS.this_cTagNumero), "", loc_cAlias) = 0 OR ;
                 TAGNO(ALLTRIM(THIS.this_cTagData), "", loc_cAlias) = 0
                THIS.this_cMensagemErro = "O cursor de opera" + CHR(231) + ;
                    CHR(245) + "es chegou sem os " + CHR(237) + "ndices de ordena" + ;
                    CHR(231) + CHR(227) + "o."

            OTHERWISE
                THIS.this_cMensagemErro = ""
                loc_lPronto = .T.
        ENDCASE

        RETURN loc_lPronto
    ENDPROC

    *==========================================================================
    * ContarOperacoes - quantas linhas o cursor da grade tem
    *
    * RECCOUNT(alias) le a contagem SEM mexer no ponteiro de registro e sem
    * trocar a area de trabalho, ao contrario de COUNT/SCAN - que exigiriam
    * salvar e repor o RECNO. Devolve 0 quando o alias nao existe, para quem
    * chama poder tratar "nao recebi nada" e "recebi vazio" do mesmo jeito.
    *==========================================================================
    PROCEDURE ContarOperacoes()
        LOCAL loc_cAlias

        loc_cAlias = ALLTRIM(THIS.this_cCursorOperacoes)

        IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
            RETURN 0
        ENDIF

        RETURN RECCOUNT(loc_cAlias)
    ENDPROC

    *==========================================================================
    * PosicionarNoTopo - SELECT + GO TOP no cursor da grade
    *
    * Par obrigatorio do Refresh da grade: popular ou reordenar um cursor NAO
    * repinta a grade sozinho, e o legado sempre fecha com GO TOP mais
    * Grade.Refresh (regra #21). O Refresh fica no form, que eh quem tem o
    * objeto Grid; aqui fica a parte que mexe no cursor.
    *
    * Retorno: .T. quando posicionou; .F. quando o alias nao existe.
    *==========================================================================
    PROCEDURE PosicionarNoTopo()
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.
        loc_cAlias = ALLTRIM(THIS.this_cCursorOperacoes)

        IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
            SELECT (loc_cAlias)
            GO TOP
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * OrdenarPorNumero - reordena a grade por Empresa + Operacao + Numero
    *
    * Transcricao do SIGOPCLP.fwgrade.dopes.Header1.Click:
    *
    *   Select TmpOper
    *   If Not Eof() / lnRecno = Recno() / Else / lnRecno = 0 / EndIf
    *   Set Order To Num
    *   ThisForm.fwgrade.Refresh
    *   If (lnRecno <> 0) / Go lnRecno / Else / Go Top / EndIf
    *   ThisForm.fwgrade.Refresh
    *
    * O legado ordena ASCENDENTE aqui (nenhuma clausula DESCENDING), ao
    * contrario da coluna Data. O Refresh da grade eh do form.
    *==========================================================================
    PROCEDURE OrdenarPorNumero()
        RETURN THIS.AplicarOrdem(THIS.this_cTagNumero, .F.)
    ENDPROC

    *==========================================================================
    * OrdenarPorData - reordena a grade por Data, da mais recente para a mais antiga
    *
    * Transcricao do SIGOPCLP.fwgrade.datas.Header1.Click, identico ao da
    * coluna Operacao exceto por UMA palavra, que eh regra de exibicao e nao
    * detalhe: "Set Order To Datas Descending". A grade de movimentacoes abre a
    * data mais NOVA primeiro, e trocar isso por ascendente mudaria o que o
    * usuario ve na primeira linha.
    *==========================================================================
    PROCEDURE OrdenarPorData()
        RETURN THIS.AplicarOrdem(THIS.this_cTagData, .T.)
    ENDPROC

    *==========================================================================
    * AplicarOrdem - corpo comum dos dois Header1.Click do legado
    *
    * par_cTag          - nome do TAG ("Num" ou "Datas")
    * par_lDescendente  - .T. acrescenta DESCENDING (coluna Data do legado)
    *
    * O legado SALVA o RECNO antes de trocar a ordem e volta para ele depois,
    * caindo em GO TOP so quando estava em EOF. Isso eh deliberado: sem a
    * reposicao, reordenar jogaria o usuario para outra linha. GO <n> navega
    * por NUMERO de registro e nao depende da ordem corrente, entao a reposicao
    * continua valendo depois do SET ORDER.
    *
    * SET ORDER TO TAG nao aceita o nome do TAG por expressao entre parenteses:
    * o nome tem de ser literal no comando. Por isso o comando eh montado em
    * string e executado por macro-substituicao - sem o prefixo "m." dentro do
    * macro, que quebraria a expansao.
    *
    * Retorno: .T. quando a ordem foi aplicada; .F. quando o alias nao existe
    * ou o TAG nao esta no cursor. Atualiza this_cOrdemAtual e
    * this_lOrdemDescendente, para o form saber qual coluna esta ordenando.
    *==========================================================================
    PROCEDURE AplicarOrdem(par_cTag, par_lDescendente)
        LOCAL loc_lSucesso, loc_cAlias, loc_cTag, loc_lDesc, loc_nRecno, loc_cComando, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = ALLTRIM(THIS.this_cCursorOperacoes)
        loc_cTag = IIF(VARTYPE(par_cTag) = "C", ALLTRIM(par_cTag), "")
        loc_lDesc = IIF(VARTYPE(par_lDescendente) = "L", par_lDescendente, .F.)

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) AND !EMPTY(loc_cTag)
                SELECT (loc_cAlias)

                IF TAGNO(loc_cTag, "", loc_cAlias) > 0
                    *-- Legado: If Not Eof() / lnRecno = Recno() / Else / lnRecno = 0
                    IF !EOF()
                        loc_nRecno = RECNO()
                    ELSE
                        loc_nRecno = 0
                    ENDIF

                    loc_cComando = "SET ORDER TO TAG " + loc_cTag + ;
                        IIF(loc_lDesc, " DESCENDING", " ASCENDING")

                    &loc_cComando

                    *-- Legado: If (lnRecno <> 0) / Go lnRecno / Else / Go Top
                    IF loc_nRecno <> 0 AND loc_nRecno <= RECCOUNT(loc_cAlias)
                        GO loc_nRecno
                    ELSE
                        GO TOP
                    ENDIF

                    THIS.this_cOrdemAtual = loc_cTag
                    THIS.this_lOrdemDescendente = loc_lDesc
                    THIS.this_cMensagemErro = ""

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = CHR(205) + "ndice " + loc_cTag + ;
                        " n" + CHR(227) + "o existe no cursor de opera" + ;
                        CHR(231) + CHR(245) + "es."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AplicarOrdem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
