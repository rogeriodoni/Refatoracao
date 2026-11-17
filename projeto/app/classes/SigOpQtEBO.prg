*==============================================================================
* SigOpQtEBO.prg
*
* Business Object para SIGOPQTE (Quantidade de Etiquetas por Peso)
*
* Origem legado : SigOpQtE.SCX
*                 tasks\task792\SigOpQtE_form_codigo_fonte.txt
*
* Tabela: (nenhuma - dialogo FILHO de entrada, sem persistencia propria)
*
* O QUE ESTA TELA FAZ
* -------------------
* E o menor dialogo MODAL do sistema: uma unica caixa de texto onde o
* usuario digita QUANTAS etiquetas devem ser impressas para um produto, e
* um botao "Retornar" que apenas fecha a janela. O valor digitado NAO e
* gravado em tabela nenhuma - ele volta para o form PAI, que o usa na
* montagem da fila de impressao de etiquetas.
*
* O dump legado inteiro tem SO estes dois metodos:
*
*   PROCEDURE Init                            (SIGOPQTE)
*       LParameters pPro
*       This.Caption = [Etiquetas Para : ] + pPro
*       ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
*       ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
*
*   PROCEDURE btnSair.Click                   (SIGOPQTE.OK)
*       ThisForm.Release
*
* Nao ha Valid, nao ha When, nao ha Load, nao ha consulta: o campo e ligado
* direto por ControlSource a uma variavel PUBLIC (veja abaixo) e o botao so
* libera o form. Toda a "regra" da tela esta nas propriedades do SCX.
*
* CONTRATO COM O FORM PAI (variavel PUBLIC _QtEtiq)
* -------------------------------------------------
* O TextBox do SCX tem ControlSource = "_QtEtiq", que NAO e coluna de
* cursor: e a variavel PUBLIC que o chamador declara e ZERA antes de abrir
* a tela. Os dois chamadores conhecidos, conferidos nos dumps:
*
*   tasks\task569\sigcdpro_form_codigo_fonte.txt (linhas 23001-23005)
*       If (crUni.pQtds='S')
*           Public _qtetiq
*           _qtetiq = 0
*           Do Form SigOpQtE With pPro
*           Insert Into dbImpressao (Cpros, Qtds, Empresa) ;
*                             Values (pPro, _QtEtiq, _Empr)
*       EndIf
*
*   tasks\task742\sigopfis_form_codigo_fonte.txt (linhas 5090-5108)
*       If Type( "_QtEtiq" ) # "N"
*           Public _QtEtiq
*       EndIf
*       _QtEtiq = crEesti.Qtds
*       _QtPeso = CrEesti.Pesos
*       If crSigCdUni.pqtds='S' And crSigCdUni.Etiqs#'S'
*           _QtEtiq = 0
*           _QtPeso = 0
*           Do Form SigOpQtE With crEesti.Cpros
*       EndIf
*       ... Insert Into dbImpressao (cpros, qtds, qtdeEtiq, ...) ;
*                             Values (..., 1, _QtEtiq, ...)
*
* Dai tres fatos que as fases seguintes tem de respeitar:
*
*   1. O parametro pPro e o CODIGO DO PRODUTO - SigCdPro.cpros char(14)
*      (conferido em docs\schema.sql, lido com Get-Content -Raw por ser
*      UTF-16 - regra #14). Em sigcdpro vem da variavel pPro do proprio
*      form; em sigopfis vem de crEesti.Cpros. So entra no Caption: a tela
*      nao consulta o produto em lugar nenhum, e inventar um SELECT de
*      descricao aqui seria acrescentar comportamento que o legado nao tem.
*
*   2. A quantidade sai desta tela pela variavel PUBLIC _QtEtiq, e os
*      chamadores a leem IMEDIATAMENTE depois do "Do Form". Por isso o BO
*      guarda o nome dessa variavel em this_cVariavelLegado: na arquitetura
*      nova o valor vive em this_nQtEtiq, mas a PUBLIC continua sendo o
*      ponto de encontro com quem ainda le o nome legado. Quem escreve nos
*      dois lados e o Form (fases seguintes); o BO e a fonte unica do valor.
*
*   3. O chamador ZERA _QtEtiq antes de abrir a tela, de proposito: se o
*      usuario nao digitar nada, a quantidade volta ZERO e o chamador
*      insere zero. Esse comportamento e do legado e NAO deve ser
*      "melhorado" com default 1 - o Formsigopfis migrado inclusive avisa e
*      NAO insere a linha justamente para nao gerar etiqueta com
*      quantidade zero em silencio (regra #27, ausencia visivel).
*
* O QUE O SCX DEFINE SOBRE O CAMPO (transcrito, nao deduzido)
* -----------------------------------------------------------
*   SIGOPQTE.Text1   ControlSource = "_QtEtiq"    -> variavel PUBLIC
*                    InputMask     = "9999"       -> 4 digitos, so numero
*                    Alignment     = 3            -> direita (numerico)
*                    FontName      = "Courier New"
*                    Width 39 / Height 22 / Left 108 / Top 91 / Margin 0
*
* A mascara "9999" e a UNICA restricao que o legado impoe ao valor: nao ha
* Valid no campo, nao ha teto conferido em codigo. Por isso o limite que
* este BO declara (this_nMaxQtEtiq) e exatamente o que a mascara ja impede
* de digitar - 9999 - e nao um teto novo inventado por aqui.
*
* O Caption vem do Init legado: o literal "Etiquetas Para : " concatenado
* com o produto, copiado em seguida para os DOIS labels da faixa do
* cabecalho (lblSombra e lblTitulo). Fica em propriedade para o Form ter
* fonte unica em vez de repetir o literal em tres lugares.
*
* GRAVACAO
* --------
* Inserir(), Atualizar(), ExecutarExclusao() e RegistrarAuditoria() ficam
* HERDADOS de BusinessBase - o comportamento padrao herdado (recusar a
* operacao e reportar a recusa pelo ExibirFalha do Salvar, regra #20) ja e
* o correto, porque o dump legado prova que esta tela nao grava em tabela
* nenhuma: zero TABLEUPDATE(, zero .AddCursor(, zero Insert Into / Update /
* Delete From, zero SqlExecute. O unico efeito da tela e o valor que fica
* na variavel PUBLIC, e quem o persiste e o form PAI, no cursor LOCAL
* dbImpressao (Cpros c(14), Qtds n(9), Empresa c(3), Obs c(10) - criado em
* sigcdpro_form_codigo_fonte.txt linha 22991), que nem existe no schema do
* SQL Server. Escrever um INSERT/UPDATE aqui exigiria ADIVINHAR a lista de
* colunas, que e o que a regra #22 do CLAUDE.md proibe.
*
* Fase 1/8: declaracao de TODAS as propriedades + Init.
*
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpQtEBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Titulo da janela
    *
    * this_cPrefixoTitulo e o literal do Init legado ([Etiquetas Para : ]),
    * com os espacos EXATOS do dump - um antes e um depois dos dois pontos.
    * this_cTitulo e o Caption ja montado (prefixo + produto), que o Form
    * copia para o proprio Caption e para os dois labels da faixa.
    *
    * Enquanto nenhum produto chegou, this_cTitulo nasce so com o prefixo:
    * e o mesmo texto que o legado exibiria se pPro viesse vazio.
    *--------------------------------------------------------------------------
    this_cPrefixoTitulo = ""        && literal "Etiquetas Para : " do Init legado
    this_cTitulo = ""               && Caption do form / dos labels da faixa

    *--------------------------------------------------------------------------
    * Produto para o qual as etiquetas serao impressas
    *
    * E o parametro pPro do Init legado - SigCdPro.cpros char(14). Entra
    * SOMENTE na montagem do Caption; a tela nao consulta a tabela.
    *--------------------------------------------------------------------------
    this_cCpros = ""                && cpros char(14) - produto recebido (pPro)

    *--------------------------------------------------------------------------
    * Quantidade de etiquetas - o unico dado que esta tela produz
    *
    * this_nQtEtiq e o valor do TextBox, equivalente a variavel PUBLIC
    * _QtEtiq do legado. Nasce ZERO porque e assim que os dois chamadores
    * entram na tela ("_qtetiq = 0" antes do "Do Form").
    *
    * this_cVariavelLegado guarda o nome dessa PUBLIC em vez de espalhar o
    * literal "_QtEtiq" pelo codigo: e por ela que o valor volta para quem
    * ainda le o nome legado.
    *
    * this_cMascaraQtEtiq e o InputMask transcrito do SCX; this_nMaxQtEtiq
    * e o maior valor que essa mascara deixa digitar (4 digitos). Nenhum
    * dos dois e teto novo - sao a mesma restricao, escrita de duas formas:
    * a mascara para o TextBox, o numero para quem precisar conferir.
    *--------------------------------------------------------------------------
    this_nQtEtiq = 0                && quantidade digitada (PUBLIC _QtEtiq)
    this_cVariavelLegado = ""       && nome da PUBLIC do ControlSource legado
    this_cMascaraQtEtiq = ""        && InputMask "9999" transcrito do SCX
    this_nMaxQtEtiq = 0             && 9999 - teto que a mascara ja impoe

    *==========================================================================
    * Init - Inicializa Business Object
    *
    * DODEFAULT() e a PRIMEIRA linha (BusinessBase.Init poe o BO em modo
    * consulta: this_lEmEdicao / this_lNovoRegistro / this_lDadosAlterados em
    * .F.). Ele e chamado SEM argumento de proposito: passar um nome de
    * tabela faria BusinessBase instanciar um DataAccess, e esta tela nao
    * tem tabela proprietaria.
    *
    * Por isso as duas propriedades herdadas ficam vazias - os nomes
    * corretos sao this_cTabela e this_cCampoChave.
    *
    * Os defaults atribuidos aqui sao os do legado, nao invencao:
    *   - this_cPrefixoTitulo e o literal do Init do SCX, e this_cTitulo
    *     nasce com ele porque nenhum produto chegou ainda;
    *   - this_nQtEtiq nasce ZERO, que e o valor com que os chamadores
    *     entram na tela;
    *   - this_cVariavelLegado e o ControlSource do TextBox ("_QtEtiq");
    *   - this_cMascaraQtEtiq e o InputMask do TextBox ("9999") e
    *     this_nMaxQtEtiq e o maior numero que ele aceita (9999).
    *
    * O produto (this_cCpros) nao e inicializado com valor nenhum: ele so
    * passa a valer quando o chamador o informar, do mesmo jeito que o
    * pPro do legado so existe na chamada.
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo de entrada: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        *-- Titulo: literal do Init legado ("Etiquetas Para : " + pPro)
        THIS.this_cPrefixoTitulo = "Etiquetas Para : "
        THIS.this_cTitulo = THIS.this_cPrefixoTitulo

        *-- Produto recebido do chamador (SigCdPro.cpros char(14))
        THIS.this_cCpros = ""

        *-- Quantidade: nasce zerada, como os chamadores a entregam
        THIS.this_nQtEtiq = 0
        THIS.this_cVariavelLegado = "_QtEtiq"
        THIS.this_cMascaraQtEtiq = "9999"
        THIS.this_nMaxQtEtiq = 9999

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Fase 2/8 - decisao de projeto: CarregarDoCursor, Inserir, Atualizar,
    * ObterChavePrimaria e RegistrarAuditoria ficam HERDADOS de BusinessBase
    *
    * O dump legado (SigOpQtE_form_codigo_fonte.txt, confirmado linha a
    * linha na Fase 1) prova ausencia de gravacao: zero TABLEUPDATE(, zero
    * .AddCursor(, zero Insert Into / Update / Delete From. O unico efeito
    * da tela e o valor que fica em _QtEtiq (via this_nQtEtiq); quem o
    * persiste e o form PAI, no cursor LOCAL dbImpressao, que nem existe no
    * SQL Server. Sobrescrever CarregarDoCursor() mapeando coluna de cursor,
    * ou Inserir()/Atualizar() com SQL INSERT/UPDATE, exigiria inventar
    * tabela e colunas que este dialogo nao tem - a regra #22 do CLAUDE.md
    * proibe exatamente isso (a lista de colunas vem do schema, nunca de
    * suposicao).
    *
    *   - CarregarDoCursor(pcCursor) herdado devolve .T. sem tocar
    *     propriedade nenhuma: correto aqui, porque nao ha cursor remoto
    *     para esta tela ler (ela so recebe pPro por parametro no Init).
    *   - ObterChavePrimaria() herdado devolve "": correto, este dialogo
    *     nao tem chave primaria - nao existe registro, so um valor
    *     digitado pelo usuario.
    *   - Inserir()/Atualizar() herdados recusam a operacao preenchendo
    *     this_cMensagemErro, e sao reportados pelo ExibirFalha do Salvar
    *     (regra #20) se algum dia forem chamados por engano.
    *   - RegistrarAuditoria() herdado so grava quando ObterChavePrimaria()
    *     traz chave; como ela e vazia aqui, o registro de auditoria nunca
    *     ocorre - comportamento correto para uma tela que nunca grava.
    *
    * O comportamento padrao herdado de BusinessBase ja e o correto para
    * os cinco metodos.
    *==========================================================================

ENDDEFINE

*==============================================================================
* FIM DE SigOpQtEBO.prg
*==============================================================================
