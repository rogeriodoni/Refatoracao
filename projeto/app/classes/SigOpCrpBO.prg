*==============================================================================
* SigOpCrpBO.prg
*
* Business Object para FormSigOpCrp - Procura de Lancamento de Conta Corrente
* Legado: SigOpCrp.SCX (task714)
*
* Cursor pesquisado : CrSigMvCcr (grade de lancamentos do form pai)
* Tabela de origem  : SigMvCcr (chave: cidchaves char(20))
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo FILHO, modal e sem barra de titulo, aberto pelo extrato de Conta
* Corrente Individual (SIGOPIND / Formsigopind) no clique do botao "Procura":
*
*     DO FORM SigOpCrp WITH THIS.DataSessionId, THIS
*
* A tela NAO consulta o servidor e NAO grava nada. Ela apenas POSICIONA o
* cursor que o form pai mantem aberto na grade de lancamentos, com LOCATE /
* CONTINUE, por um destes tres criterios:
*
*     Data      -> getLancamento -> CrSigMvCcr.Datas   (D)
*     Valor     -> getValor      -> CrSigMvCcr.Valors  (N(11,2))
*     Historico -> getHistorico  -> CrSigMvCcr.Hists   (C(60))
*
* Por isso o legado comeca com "Set DataSession To Arquivos": o dialogo entra
* na MESMA data session do pai e so assim enxerga CrSigMvCcr. O DataSessionId
* recebido fica guardado em this_nDataSessionPai.
*
*------------------------------------------------------------------------------
* TIPOS DOS CAMPOS - CONFERIDOS NAS DUAS PONTAS
*
* O criterio eh comparado contra o CURSOR, nao contra a tabela, e os dois
* divergem num ponto que importa: na tabela a coluna datas eh datetime, mas
* no cursor que o pai cria (Formsigopind, CREATE CURSOR CrSigMvCcr) a coluna
* Datas eh do tipo D. Conferido em docs/schema.sql (UTF-16, lido com
* Get-Content -Raw, regra #14) e no CREATE CURSOR do form pai:
*
*     coluna      SigMvCcr          CrSigMvCcr       property
*     ----------  ----------------  ---------------  -------------
*     datas       datetime NULL     Datas   D        this_dDatas
*     valors      numeric(11,2)     Valors  N(11,2)  this_nValors
*     hists       char(60) NULL     Hists   C(60)    this_cHists
*
* Dai duas consequencias:
*   - a property de data eh DATE, igual ao Ctod() vazio que o legado atribui
*     ao TextBox, e a montagem da chave passa por ConverterParaData antes do
*     DTOS para nao depender do caminho por onde o valor chegou (regra #16:
*     TTOD estoura erro 11 quando recebe DATE);
*   - o MaxLength do campo Historico eh 60, a largura da COLUNA, e nao a
*     largura em pixels do controle (regra #19).
*
*------------------------------------------------------------------------------
* BUSCA SEQUENCIAL - O QUE this_cContinuar GUARDA
*
* O legado guarda a ultima chave pesquisada na property "continuar" do form e
* usa esse valor para decidir entre RECOMECAR do topo ou CONTINUAR de onde
* parou (transcricao do btnOK.Click):
*
*     Case ThisForm.getValor.Value # 0
*         lcChave = ThisForm.getValor.Value
*         If lcChave = Val(ThisForm.Continuar) .and. !llFinal
*             Continue
*         Else
*             ThisForm.Continuar = Str(lcChave,12,2)
*             Go Top
*             Locate For lcChave = Valors
*         Endif
*
* Ou seja: mesma chave da vez anterior e cursor ainda nao no fim -> CONTINUE
* (proxima ocorrencia); chave nova -> grava a chave, GO TOP e LOCATE. Por isso
* "continuar" eh CARACTERE mesmo no criterio numerico - o legado guarda
* Str(valor,12,2) e compara com Val(). this_cContinuar reproduz isso
* literalmente, inclusive o formato de 12 posicoes com 2 decimais.
*
* llFinal eh medido ANTES da busca e espelhado em this_lFinalArquivo:
*
*     llFinal = Eof()
*     If !llFinal
*         Skip
*         llFinal = Eof()
*         Skip - 1
*     Endif
*
* isto eh, "estou no ultimo registro (ou alem dele)" - o CONTINUE so eh
* permitido quando ainda ha para onde avancar.
*
*------------------------------------------------------------------------------
* PRECEDENCIA DOS CRITERIOS E DESTINO DO FOCO
*
* O Do Case do legado usa UM criterio por vez, nesta ordem: Data, Valor,
* Historico - e os Valid dos tres campos zeram os outros dois, de modo que na
* pratica so um fica preenchido. O MESMO teste decide, no segundo Do Case, o
* que acontece depois da busca:
*
*     criterio    chave          comparacao          depois da busca
*     ----------  -------------  ------------------  --------------------
*     DATA        Dtos(Datas)    igualdade exata     fecha o dialogo
*     VALOR       Valors         igualdade numerica  foco em getValor
*     HISTORICO   Hists          lcChave $ Hists     foco em getHistorico
*     (nenhum)    -              -                   fecha o dialogo
*
* A assimetria eh do legado e eh proposital: a data identifica um lancamento
* (fecha), valor e historico repetem (o dialogo fica aberto para o usuario
* clicar Procurar de novo e cair na ocorrencia seguinte). O criterio escolhido
* fica em this_cTipoBusca e o destino do foco em this_cCampoFoco /
* this_lFecharDialogo.
*
* Atencao ao criterio de HISTORICO: o operador eh "$" (contido em), nao "=".
* Trocar por igualdade restringiria a busca e mudaria o comportamento da tela.
*
*------------------------------------------------------------------------------
* AUSENCIA DE MENSAGEM QUANDO NAO ACHA - EH DO LEGADO
*
* Quando o LOCATE falha, o legado NAO avisa nada: ele apenas da Refresh e
* SetFocus na grade do pai. Nao cabe acrescentar MsgAviso de "nao encontrado"
* nem limpar o criterio digitado - isso impediria o usuario de corrigir o
* valor e repetir a busca (regra #50). O resultado do LOCATE fica apenas em
* this_lAchouRegistro, para o form poder reposicionar a grade.
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA - BO SOMENTE-LEITURA
*
* O legado nao tem INSERT, UPDATE, DELETE, TABLEUPDATE nem AddCursor: o unico
* efeito da tela eh o PONTEIRO do cursor do pai. Portanto este BO nao
* sobrescreve Inserir(), Atualizar() nem ExecutarExclusao() - o comportamento
* padrao herdado de BusinessBase (recusar a operacao e reportar pelo
* ExibirFalha do Salvar) ja eh o correto, e sobrescrever esses metodos
* exigiria INVENTAR uma lista de colunas, o que a regra #22 proibe.
*
* Pelo mesmo motivo o Init NAO passa o nome da tabela para o DODEFAULT: sem
* nenhuma ida ao servidor nao ha DataAccess a instanciar. this_cTabela e
* this_cCampoChave sao preenchidos direto, como contexto da entidade.
*==============================================================================

DEFINE CLASS SigOpCrpBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CRITERIOS DE BUSCA
    *
    * Uma property por caixa da tela, com a grafia da COLUNA do cursor
    * preservada (inclusive o sufixo "s" do padrao Fortyus - NUNCA "corrigir"
    * para o singular). Os valores iniciais reproduzem o Init do legado:
    *
    *     ThisForm.getLancamento.Value = Ctod('  /  /  ')
    *     ThisForm.getValor.Value      = 0.00
    *     ThisForm.getHistorico.Value  = ''
    *--------------------------------------------------------------------------
    this_dDatas  = {}   && Datas  D        - getLancamento "Data :"
    this_nValors = 0.00 && Valors N(11,2)  - getValor      "Valor :" (legado: 0.00)
    this_cHists  = ""   && Hists  C(60)    - getHistorico  "Historico :"

    *--------------------------------------------------------------------------
    * ESTADO DA BUSCA SEQUENCIAL
    *
    * this_cContinuar eh o "continuar" do form legado: CARACTERE, guardando
    * Str(valor,12,2) no criterio numerico e Alltrim(historico) no criterio
    * texto. Vazio significa "a proxima busca comeca do topo".
    *
    * this_lFinalArquivo eh o llFinal medido ANTES da busca: com ele ligado o
    * CONTINUE nao eh tentado, porque nao ha registro seguinte.
    *--------------------------------------------------------------------------
    this_cContinuar    = ""     && legado: ThisForm.Continuar
    this_lFinalArquivo = .F.    && legado: llFinal (cursor no ultimo registro)

    *--------------------------------------------------------------------------
    * CRITERIO ESCOLHIDO E DESTINO DO FOCO
    *
    * this_cTipoBusca eh o seletor dos DOIS Do Case do btnOK.Click legado,
    * resolvido uma vez e reusado: "DATA" / "VALOR" / "HISTORICO" / "" (nenhum
    * criterio preenchido). As outras duas properties sao a traducao do segundo
    * Do Case, para o form apenas obedecer:
    *
    *     this_lFecharDialogo = .T.  -> ThisForm.Release
    *     this_cCampoFoco = "VALOR" ou "HISTORICO" -> SetFocus no campo
    *--------------------------------------------------------------------------
    this_cTipoBusca     = ""    && DATA / VALOR / HISTORICO / vazio
    this_cCampoFoco     = ""    && VALOR / HISTORICO / vazio
    this_lFecharDialogo = .F.   && .T. quando o legado faz ThisForm.Release

    *--------------------------------------------------------------------------
    * RESULTADO DA BUSCA
    *
    * this_lAchouRegistro recebe o FOUND() do LOCATE / CONTINUE. Nao gera
    * mensagem nenhuma (ver nota "AUSENCIA DE MENSAGEM" no cabecalho): serve
    * para o form decidir se vale reposicionar a grade.
    *
    * this_nRegistroAchado guarda o RECNO() da ocorrencia e
    * this_nRegistroAnterior o RECNO() de onde a busca partiu - o que permite
    * devolver o ponteiro ao lugar de origem quando nada eh encontrado, em vez
    * de deixar a grade parada em EOF.
    *--------------------------------------------------------------------------
    this_lAchouRegistro    = .F.
    this_nRegistroAchado   = 0
    this_nRegistroAnterior = 0
    this_nTotalRegistros   = 0

    *--------------------------------------------------------------------------
    * VALORES DO REGISTRO LOCALIZADO (preenchidos por CarregarDoCursor)
    *
    * Espelho das tres colunas pesquisadas, LIDAS da linha em que o LOCATE /
    * CONTINUE parou. Sao DISTINTAS das properties de criterio (this_dDatas /
    * this_nValors / this_cHists) de proposito, e a separacao eh obrigatoria:
    * o primeiro Do Case do BuscarRegistro escolhe o criterio TESTANDO as
    * properties de criterio, entao carregar a linha achada em cima delas
    * TROCARIA o criterio da busca seguinte - uma busca por Valor passaria a
    * ser por Data (a coluna Datas da linha achada nunca esta vazia), em
    * silencio. Com o par separado, CarregarDoCursor eh so leitura e nao tem
    * como interferir na sequencia de buscas.
    *
    * Tipos conferidos nas duas pontas (ver cabecalho do arquivo): no cursor
    * do form pai Datas eh D, Valors eh N(11,2) e Hists eh C(60).
    *--------------------------------------------------------------------------
    this_dDatasAchado  = {}   && Datas  da linha localizada
    this_nValorsAchado = 0    && Valors da linha localizada
    this_cHistsAchado  = ""   && Hists  da linha localizada

    *--------------------------------------------------------------------------
    * CURSOR PESQUISADO E CONTEXTO DO FORM PAI
    *
    * this_cCursorBusca eh o alias que o form pai mantem ligado ao RecordSource
    * da grade de lancamentos - CrSigMvCcr em
    * Formsigopind.pgf_4c_1.Page2.grd_4c_Lancamento. Fica numa property, e nao
    * numa constante espalhada pelo codigo, porque TODA operacao deste BO eh
    * sobre esse alias.
    *
    * this_nDataSessionPai eh o primeiro parametro do form legado ("Arquivos"),
    * usado no "Set DataSession To Arquivos": sem entrar na data session do
    * pai, o alias nem existe para este dialogo.
    *--------------------------------------------------------------------------
    this_cCursorBusca    = "CrSigMvCcr"
    this_nDataSessionPai = 0

    *--------------------------------------------------------------------------
    * NOMES DAS COLUNAS PESQUISADAS
    *
    * Centralizados aqui para que LOCATE, CONTINUE e montagem de chave usem
    * sempre a mesma grafia - a do CREATE CURSOR do form pai, que eh tambem a
    * da tabela (regra #48: nome de coluna nao se deduz, se confere).
    *--------------------------------------------------------------------------
    this_cColunaData      = "Datas"
    this_cColunaValor     = "Valors"
    this_cColunaHistorico = "Hists"

    *--------------------------------------------------------------------------
    * VALOR ANTERIOR DE CADA CAMPO (legado: This.Tag no GotFocus)
    *
    * Os tres campos tem o par GotFocus / Valid: o GotFocus guarda o valor de
    * entrada e o Valid compara com o valor de saida para saber se o usuario
    * MUDOU o criterio - e, mudando, zera os outros dois campos e reinicia a
    * sequencia. O legado guarda isso no Tag do proprio controle, sempre como
    * CARACTERE:
    *
    *     getLancamento.GotFocus -> This.Tag = Dtos(This.Value)
    *     getValor.GotFocus      -> This.Tag = Str(This.Value,12,2)
    *     getHistorico.GotFocus  -> This.Tag = Alltrim(This.Value)
    *
    * Ficam espelhadas no BO, tambem como CARACTERE e no mesmo formato, porque
    * Tag de TextBox aceita SO caractere e porque guardar o estado no BO deixa
    * uma fonte unica para a comparacao.
    *--------------------------------------------------------------------------
    this_cTagDatas  = ""    && Dtos(valor de entrada)     - 8 posicoes
    this_cTagValors = ""    && Str(valor de entrada,12,2)  - 12 posicoes
    this_cTagHists  = ""    && Alltrim(valor de entrada)

    *--------------------------------------------------------------------------
    * LARGURAS DE DIGITACAO
    *
    * Vem da largura da COLUNA no cursor / schema, nunca do Width em pixels do
    * controle (regra #19). Usadas pelo MaxLength dos campos e pelo corte do
    * criterio de historico.
    *--------------------------------------------------------------------------
    this_nTamanhoHists   = 60   && Hists  C(60)
    this_nTamanhoValors  = 12   && Valors N(11,2) -> Str(x,12,2)
    this_nDecimaisValors = 2    && Valors N(11,2)

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Parametros (ambos opcionais):
    *     par_nDataSessionPai - DataSessionId do form pai, o "Arquivos" do
    *                           legado. Guardado para o form poder executar
    *                           SET DATASESSION TO e alcancar o cursor.
    *     par_cCursorBusca    - alias a pesquisar. Omitido, fica o canonico
    *                           CrSigMvCcr do extrato de Conta Corrente.
    *
    * DODEFAULT() eh chamado SEM o nome da tabela de proposito: este BO nao vai
    * ao servidor e nao precisa de DataAccess (ver nota de arquitetura no
    * cabecalho).
    *
    * Devolve SEMPRE .T.: nao ha pre-requisito que possa falhar aqui - nenhum
    * SQL, nenhum cursor a abrir - e Init de BO que devolve .F. transforma o
    * CREATEOBJECT em logico e derruba o Init do proprio form, deixando a tela
    * sem abrir.
    *==========================================================================
    PROCEDURE Init(par_nDataSessionPai, par_cCursorBusca)
        LOCAL loc_nDataSession, loc_cCursor

        DODEFAULT()

        *-- Contexto da entidade (nenhuma ida ao servidor acontece aqui)
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "cidchaves"

        *-- DataSession do form pai (legado: Set DataSession To Arquivos)
        loc_nDataSession = 0
        IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
            loc_nDataSession = par_nDataSessionPai
        ENDIF
        THIS.this_nDataSessionPai = loc_nDataSession

        *-- Alias pesquisado (default: a grade de lancamentos do extrato)
        loc_cCursor = ""
        IF VARTYPE(par_cCursorBusca) = "C"
            loc_cCursor = ALLTRIM(par_cCursorBusca)
        ENDIF
        IF EMPTY(loc_cCursor)
            loc_cCursor = "CrSigMvCcr"
        ENDIF
        THIS.this_cCursorBusca = loc_cCursor

        *-- Colunas pesquisadas (grafia do CREATE CURSOR do form pai)
        THIS.this_cColunaData      = "Datas"
        THIS.this_cColunaValor     = "Valors"
        THIS.this_cColunaHistorico = "Hists"

        *-- Criterios zerados, como no Init do legado
        *-- 0.00 (nao 0): o legado grava getValor.Value = 0.00 e o VFP9
        *-- preserva as casas decimais do literal, entao o campo da tela tem
        *-- de voltar a exibir "0.00". O form espelha esta property no
        *-- TxtValorLostFocus, logo o zero daqui chega a tela.
        THIS.this_dDatas  = {}
        THIS.this_nValors = 0.00
        THIS.this_cHists  = ""

        *-- A sequencia de busca comeca do topo
        THIS.this_cContinuar    = ""
        THIS.this_lFinalArquivo = .F.

        *-- Nenhum criterio escolhido e nenhum destino de foco decidido
        THIS.this_cTipoBusca     = ""
        THIS.this_cCampoFoco     = ""
        THIS.this_lFecharDialogo = .F.

        *-- Nenhuma busca executada ainda
        THIS.this_lAchouRegistro    = .F.
        THIS.this_nRegistroAchado   = 0
        THIS.this_nRegistroAnterior = 0
        THIS.this_nTotalRegistros   = 0

        *-- Nenhuma linha localizada ainda
        THIS.LimparRegistroAchado()

        *-- Valores de entrada dos campos (legado: This.Tag no GotFocus)
        THIS.this_cTagDatas  = ""
        THIS.this_cTagValors = ""
        THIS.this_cTagHists  = ""

        *-- Larguras vindas da coluna, nao do Width do controle
        THIS.this_nTamanhoHists   = 60
        THIS.this_nTamanhoValors  = 12
        THIS.this_nDecimaisValors = 2

        *-- Estado de edicao herdado: esta tela eh de consulta
        THIS.this_lEmEdicao     = .F.
        THIS.this_lNovoRegistro = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BuscarRegistro - Posiciona o cursor do form pai no registro encontrado
    *
    * Transcricao de SIGOPCRP.Commandgroup1.btnOK.Click (ver cabecalho do
    * arquivo, secoes "BUSCA SEQUENCIAL" e "PRECEDENCIA DOS CRITERIOS").
    *
    * O metodo faz SO a parte de DADOS do Click legado - LOCATE/CONTINUE no
    * cursor do pai e o calculo de qual criterio foi usado. As acoes de
    * TELA do legado (Refresh/SetFocus na grade do pai, SetFocus no proprio
    * campo, Release do dialogo) ficam no FORM, que le this_cTipoBusca /
    * this_cCampoFoco / this_lFecharDialogo / this_lAchouRegistro depois de
    * chamar este metodo.
    *
    * Devolve o mesmo valor guardado em this_lAchouRegistro. NUNCA exibe
    * mensagem quando nao acha - eh do legado (nota "AUSENCIA DE MENSAGEM"
    * no cabecalho do arquivo).
    *==========================================================================
    PROCEDURE BuscarRegistro()
        LOCAL loc_cAlias, loc_cColData, loc_cColValor, loc_cColHist, ;
              loc_cChaveTexto, loc_nChaveNumero, loc_lFinal, loc_lAchou

        loc_lAchou = .F.

        THIS.this_lAchouRegistro  = .F.
        THIS.this_nRegistroAchado = 0
        THIS.this_cCampoFoco      = ""
        THIS.this_lFecharDialogo  = .F.

        *-- A linha localizada da busca ANTERIOR nao vale mais
        THIS.LimparRegistroAchado()

        *-- Entra na data session do form pai - sem isso o alias nem existe
        *-- (legado: Set DataSession To Arquivos)
        IF THIS.this_nDataSessionPai > 0
            SET DATASESSION TO (THIS.this_nDataSessionPai)
        ENDIF

        loc_cAlias = THIS.this_cCursorBusca

        IF !USED(loc_cAlias)
            THIS.this_cTipoBusca     = ""
            THIS.this_lFecharDialogo = .T.
            RETURN .F.
        ENDIF

        loc_cColData  = THIS.this_cColunaData
        loc_cColValor = THIS.this_cColunaValor
        loc_cColHist  = THIS.this_cColunaHistorico

        SELECT (loc_cAlias)
        THIS.this_nRegistroAnterior = RECNO()
        THIS.this_nTotalRegistros   = RECCOUNT()

        SET NEAR ON

        *-- llFinal: "estou no ultimo registro (ou alem dele)", medido
        *-- ANTES da busca - igual ao legado
        loc_lFinal = EOF()
        IF !loc_lFinal
            SKIP
            loc_lFinal = EOF()
            SKIP -1
        ENDIF
        THIS.this_lFinalArquivo = loc_lFinal

        DO CASE
            *-- Criterio DATA: igualdade exata, sempre recomeca do topo
            CASE !EMPTY(THIS.this_dDatas)
                THIS.this_cTipoBusca = "DATA"
                THIS.this_cContinuar = ""
                loc_cChaveTexto = DTOS(ConverterParaData(THIS.this_dDatas))
                LOCATE FOR DTOS(&loc_cColData) = loc_cChaveTexto
                loc_lAchou = FOUND()

            *-- Criterio VALOR: mesma chave da vez anterior + ainda nao no
            *-- fim do arquivo -> Continue; senao grava a chave, Go Top e
            *-- Locate
            CASE THIS.this_nValors <> 0
                THIS.this_cTipoBusca = "VALOR"
                THIS.this_cCampoFoco = "VALOR"
                loc_nChaveNumero = THIS.this_nValors
                IF loc_nChaveNumero = VAL(THIS.this_cContinuar) AND !loc_lFinal
                    CONTINUE
                ELSE
                    THIS.this_cContinuar = STR(loc_nChaveNumero, ;
                        THIS.this_nTamanhoValors, THIS.this_nDecimaisValors)
                    GO TOP
                    LOCATE FOR loc_nChaveNumero = &loc_cColValor
                ENDIF
                loc_lAchou = FOUND()

            *-- Criterio HISTORICO: "$" (contido em), NUNCA "=" - mesma
            *-- logica de Continue do criterio Valor
            CASE !EMPTY(THIS.this_cHists)
                THIS.this_cTipoBusca = "HISTORICO"
                THIS.this_cCampoFoco = "HISTORICO"
                loc_cChaveTexto = ALLTRIM(THIS.this_cHists)
                IF ALLTRIM(THIS.this_cContinuar) = loc_cChaveTexto AND !loc_lFinal
                    CONTINUE
                ELSE
                    THIS.this_cContinuar = loc_cChaveTexto
                    GO TOP
                    LOCATE FOR loc_cChaveTexto $ &loc_cColHist
                ENDIF
                loc_lAchou = FOUND()

            *-- Nenhum criterio preenchido - legado so fecha o dialogo
            OTHERWISE
                THIS.this_cTipoBusca = ""
        ENDCASE

        SET NEAR OFF

        *-- DATA fecha sempre; sem nenhum criterio preenchido tambem fecha
        *-- (Otherwise do segundo Do Case legado); VALOR/HISTORICO deixam o
        *-- dialogo aberto com foco no proprio campo
        THIS.this_lFecharDialogo = INLIST(THIS.this_cTipoBusca, "DATA", "")

        THIS.this_lAchouRegistro = loc_lAchou
        IF loc_lAchou
            THIS.this_nRegistroAchado = RECNO(loc_cAlias)

            *-- Le a linha em que o LOCATE / CONTINUE parou para as
            *-- properties this_*Achado (o cursor JA esta posicionado nela;
            *-- CarregarDoCursor apenas le e NAO move o ponteiro)
            THIS.CarregarDoCursor(loc_cAlias)
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *==========================================================================
    * AtualizarTagDatas / AtualizarTagValors / AtualizarTagHistorico
    *
    * Espelham o GotFocus dos tres campos (This.Tag = <valor de entrada>,
    * sempre como CARACTERE - ver nota "VALOR ANTERIOR DE CADA CAMPO" no
    * cabecalho). O form chama um destes no GotFocus do TextBox
    * correspondente, passando o .Value de ENTRADA (antes da edicao).
    *==========================================================================
    PROCEDURE AtualizarTagDatas(par_dValorEntrada)
        THIS.this_cTagDatas = DTOS(ConverterParaData(par_dValorEntrada))
    ENDPROC

    PROCEDURE AtualizarTagValors(par_nValorEntrada)
        THIS.this_cTagValors = STR(par_nValorEntrada, ;
            THIS.this_nTamanhoValors, THIS.this_nDecimaisValors)
    ENDPROC

    PROCEDURE AtualizarTagHistorico(par_cValorEntrada)
        THIS.this_cTagHists = ALLTRIM(par_cValorEntrada)
    ENDPROC

    *==========================================================================
    * ValidarCriterioDatas / ValidarCriterioValors / ValidarCriterioHistorico
    *
    * Espelham o Valid dos tres campos: comparam o valor de SAIDA do
    * controle com o Tag guardado no GotFocus (AtualizarTag*) para saber se
    * o usuario MUDOU aquele criterio. Mudando, zeram os OUTROS criterios -
    * exatamente o Do Case de cada Valid no legado (ver cabecalho do
    * arquivo). O form chama no Valid do TextBox correspondente, passando o
    * .Value de SAIDA, e zera na TELA os campos cuja property voltou a
    * vazio/zero.
    *
    * Devolvem .T. quando o criterio mudou (os outros campos foram
    * zerados) e .F. quando nao mudou nada.
    *
    *--------------------------------------------------------------------------
    * CADA UM GUARDA O PROPRIO CRITERIO (Fase 8)
    *--------------------------------------------------------------------------
    * Os tres zeram os OUTROS dois criterios e, antes disso, guardam na propria
    * property o valor de SAIDA que acabaram de receber. No legado isso nao
    * precisa existir porque o CONTROLE eh o armazenamento
    * (ThisForm.getValor.Value eh, ao mesmo tempo, tela e modelo); na
    * arquitetura em camadas o modelo eh a property, e sem esta linha ela ficava
    * com o valor ANTERIOR - a property so era alimentada pelo FormParaBO, que
    * roda no Procurar, nao no Valid.
    *
    * MEDIDO no VFP9 (automation\probe714c.prg) - sem o "guarda o proprio", o
    * BOParaForm da Fase 8 (que espelha os TRES campos) devolvia a property
    * velha para o campo e APAGAVA o valor que o usuario tinha acabado de
    * digitar: ValidarValor com 777 deixava a tela em [ / / |0|]. Eh o defeito
    * da regra #50 (apagar o digitado), e a alternativa - o Form espelhar "todos
    * menos o que mudou" - devolveria o BOParaForm as tres copias com pares
    * diferentes de campos que a Fase 8 unificou.
    *
    * Guardar FORA do IF, de proposito: a property tem de refletir o campo
    * tambem quando o criterio NAO mudou, senao o estado do modelo passa a
    * depender de o usuario ter mexido no campo.
    *==========================================================================
    PROCEDURE ValidarCriterioDatas(par_dValorSaida)
        LOCAL loc_dTagComoData, loc_lMudou

        *-- legado: Ctod(Subs(Tag,7,2)+'/'+Subs(Tag,5,2)+'/'+Subs(Tag,1,4))
        *-- Tag em DTOS (YYYYMMDD) -> reconstroi DD/MM/YYYY (SET DATE BRITISH)
        loc_dTagComoData = CTOD(SUBSTR(THIS.this_cTagDatas, 7, 2) + "/" + ;
                                 SUBSTR(THIS.this_cTagDatas, 5, 2) + "/" + ;
                                 SUBSTR(THIS.this_cTagDatas, 1, 4))

        loc_lMudou = (ConverterParaData(par_dValorSaida) <> loc_dTagComoData)

        *-- ConverterParaData (nao TTOD) porque o valor vem de TextBox criado
        *-- com .Value = {}, isto eh DATE, e TTOD com DATE dispara erro 11 em
        *-- runtime (regra #16)
        THIS.this_dDatas = ConverterParaData(par_dValorSaida)

        IF loc_lMudou
            THIS.this_nValors = 0.00   && legado: ThisForm.getValor.Value = 0.00
            THIS.this_cHists  = ""
        ENDIF

        RETURN loc_lMudou
    ENDPROC

    PROCEDURE ValidarCriterioValors(par_nValorSaida)
        LOCAL loc_lMudou

        loc_lMudou = (par_nValorSaida <> VAL(THIS.this_cTagValors))

        THIS.this_nValors = par_nValorSaida

        IF loc_lMudou
            THIS.this_cContinuar = ""
            THIS.this_dDatas     = {}
            THIS.this_cHists     = ""
        ENDIF

        RETURN loc_lMudou
    ENDPROC

    PROCEDURE ValidarCriterioHistorico(par_cValorSaida)
        LOCAL loc_lMudou

        loc_lMudou = (THIS.this_cTagHists <> ALLTRIM(par_cValorSaida))

        *-- Guarda o texto CRU, nao o ALLTRIM: o ALLTRIM eh da COMPARACAO e da
        *-- montagem da chave em BuscarRegistro; apagar os espacos aqui mudaria
        *-- o que o usuario ve no campo quando o BOParaForm espelhar de volta.
        THIS.this_cHists = par_cValorSaida

        IF loc_lMudou
            THIS.this_cContinuar = ""
            THIS.this_dDatas     = {}
            THIS.this_nValors    = 0.00   && legado: ThisForm.getValor.Value = 0.00
        ENDIF

        RETURN loc_lMudou
    ENDPROC

    *==========================================================================
    * LimparRegistroAchado - Zera o espelho da linha localizada
    *
    * Chamado no Init e na ENTRADA do BuscarRegistro: a linha achada na busca
    * anterior nao vale mais assim que uma nova busca comeca, e deixa-la para
    * tras faria o chamador ler o registro errado quando o LOCATE falhasse.
    *
    * Nao leva PROTECTED (regra #51): metodo que o Form pode chamar de fora
    * nunca pode ser protegido em nivel nenhum da heranca.
    *==========================================================================
    PROCEDURE LimparRegistroAchado()
        THIS.this_dDatasAchado  = {}
        THIS.this_nValorsAchado = 0
        THIS.this_cHistsAchado  = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Le a linha CORRENTE do cursor pesquisado
    *
    * Override do metodo homonimo da BusinessBase, que na base eh um stub
    * documentando justamente este contrato: "ler a linha corrente do alias
    * recebido para as properties do BO", com EVALUATE(pcCursor + ".coluna").
    *
    * Aqui ele le as tres colunas pesquisadas - Datas, Valors e Hists - da
    * linha em que o cursor do form pai esta POSICIONADO, para as properties
    * this_dDatasAchado / this_nValorsAchado / this_cHistsAchado. Serve para o
    * chamador saber QUAL lancamento a busca encontrou sem ter de mexer no
    * cursor do pai (que eh o RecordSource da grade de lancamentos e nao deve
    * ser navegado por fora).
    *
    * ESCOPO - o que este metodo NAO faz, de proposito:
    *   - NAO escreve em property de CRITERIO (this_dDatas / this_nValors /
    *     this_cHists): isso trocaria o criterio da busca seguinte em silencio
    *     (ver nota nas properties this_*Achado);
    *   - NAO habilita edicao: este BO eh somente-leitura, o legado so move o
    *     ponteiro do cursor e nao tem INSERT / UPDATE / DELETE nem
    *     TABLEUPDATE (ver nota de arquitetura no cabecalho do arquivo);
    *   - NAO move o ponteiro: EVALUATE apenas le.
    *
    * Parametro:
    *     par_cAliasCursor - alias a ler. Omitido ou vazio, usa o cursor
    *                        pesquisado (this_cCursorBusca = CrSigMvCcr).
    *
    * Devolve .T. quando leu uma linha valida e .F. quando o alias nao esta
    * aberto ou o cursor esta vazio / em EOF - neste caso o espelho fica
    * zerado, nunca com o resto da leitura anterior.
    *
    * NOTAS DE IMPLEMENTACAO
    *
    * (a) SELECT (par_cAliasCursor) ANTES de qualquer leitura, e acesso por
    *     EVALUATE(alias + "." + coluna) - NUNCA a sintaxe campo,
    *     que nao existe em VFP9 e estoura "Function name is missing )".
    *
    * (b) A existencia de cada coluna eh conferida com TYPE(alias + ".col"),
    *     nao com PEMSTATUS: PEMSTATUS exige OBJETO no 1o argumento e com
    *     nome de cursor dispara erro 11.
    *
    * (c) TratarNulo(valor, <PADRAO>) - o 2o argumento eh o VALOR PADRAO, nao
    *     um codigo de tipo. Dai {} / 0 / "" e nunca "D" / "N" / "C", que
    *     gravariam a LETRA na property.
    *
    * (d) A data passa por ConverterParaData porque a MESMA coluna chega com
    *     tipos diferentes conforme a origem: D no cursor que o form pai cria
    *     com CREATE CURSOR, T quando o alias vem de um SELECT sobre
    *     SigMvCcr.datas (datetime). TTOD() nao serve - com DATE ele dispara
    *     erro 11 em runtime (regra #16).
    *
    * (e) Valor e historico tambem sao conferidos por VARTYPE antes de serem
    *     aceitos (regra #13): coluna numerica que chegue como caractere viria
    *     a estourar "Operator/operand type mismatch" na primeira conta.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lSucesso, loc_cPrefixo, ;
              loc_uDatas, loc_uValors, loc_uHists

        loc_lSucesso = .F.

        *-- Alias a ler: o informado ou, na falta, o cursor pesquisado
        loc_cAlias = ""
        IF VARTYPE(par_cAliasCursor) = "C"
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ENDIF
        IF EMPTY(loc_cAlias)
            loc_cAlias = THIS.this_cCursorBusca
        ENDIF

        *-- Espelho sempre zerado antes de ler: alias fechado ou cursor em
        *-- EOF nao pode deixar para tras o registro da leitura anterior
        THIS.LimparRegistroAchado()

        IF USED(loc_cAlias)
            *-- (a) OBRIGATORIO antes de ler campo com alias dinamico
            SELECT (loc_cAlias)

            IF RECCOUNT() > 0 AND !EOF()
                loc_cPrefixo = loc_cAlias + "."

                *-- Datas  D  (no cursor do pai) / datetime (na tabela)
                IF TYPE(loc_cPrefixo + THIS.this_cColunaData) != "U"
                    loc_uDatas = EVALUATE(loc_cPrefixo + THIS.this_cColunaData)
                    THIS.this_dDatasAchado = ConverterParaData(TratarNulo(loc_uDatas, {}))
                ENDIF

                *-- Valors N(11,2)
                IF TYPE(loc_cPrefixo + THIS.this_cColunaValor) != "U"
                    loc_uValors = TratarNulo(EVALUATE(loc_cPrefixo + THIS.this_cColunaValor), 0)
                    IF VARTYPE(loc_uValors) = "N"
                        THIS.this_nValorsAchado = loc_uValors
                    ELSE
                        THIS.this_nValorsAchado = 0
                    ENDIF
                ENDIF

                *-- Hists  C(60)
                IF TYPE(loc_cPrefixo + THIS.this_cColunaHistorico) != "U"
                    loc_uHists = TratarNulo(EVALUATE(loc_cPrefixo + THIS.this_cColunaHistorico), "")
                    IF VARTYPE(loc_uHists) = "C"
                        THIS.this_cHistsAchado = LEFT(loc_uHists, THIS.this_nTamanhoHists)
                    ELSE
                        THIS.this_cHistsAchado = ""
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
