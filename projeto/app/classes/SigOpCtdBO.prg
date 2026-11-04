*==============================================================================
* SigOpCtdBO.prg
*
* Business Object para FormSigOpCtd - Modo de Procura por Descricao
* Legado: SigOpCtd.SCX (task715)
*
* Tabela: NENHUMA - ver "NOTA DE ARQUITETURA" no fim deste cabecalho
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo FILHO, modal e sem barra de titulo (no SCX: WindowType = 1,
* TitleBar = 0, ControlBox = .F., 800 x 200), aberto pelo Cadastro de Contas
* (SIGCDCTA / FormCTA) de dentro do metodo msv_procurar:
*
*     lcMsg = Iif(Empty(lcGru), [Procura Sem Grupo Definido], ;
*                 [Procura No Grupo "] + Alltrim(lcGru) + ["])
*
*     Do Form SigOpCtd With lcMsg, ThisForm
*
* Sao QUATRO call sites, todos no mesmo msv_procurar
* (tasks\task388\SIGCDCTA_form_codigo_fonte.txt, linhas 9111, 9146, 9183 e
* 9208) - um por campo de texto pelo qual se pode procurar uma conta.
*
* A tela NAO consulta o servidor e NAO grava nada. Ela so pergunta COMO casar
* o texto que o usuario digitou e devolve um NUMERO ao form que a abriu; quem
* monta e executa a consulta eh o CHAMADOR. Os dois textos fixos da tela dizem
* exatamente isso:
*
*     Label1 "Nao Foi Encontrado Um Nome Igual ao Digitado!!! "
*     Label2 "Deseja Procurar Pelo Conteudo Digitado ?"
*
*------------------------------------------------------------------------------
* O CONTRATO - pnReturno, QUE EH A UNICA SAIDA DA TELA
*
* O legado tem duas properties customizadas (RESERVED3/ClassInfo do SCX):
* pnreturno e poform. Os dois botoes do Commandgroup1 escrevem a primeira e o
* Destroy a copia para o form pai:
*
*     Command1.Click ("Procurar") -> ThisForm.pnReturno = ThisForm.Optiongroup1.Value
*     Command2.Click ("Encerrar") -> ThisForm.pnReturno = 0
*     Destroy                     -> ThisForm.poForm.pnRetorno = ThisForm.pnReturno
*
* (a grafia difere entre as duas pontas - pnReturno no dialogo, pnRetorno no
* pai - e isso se transcreve, nao se "corrige")
*
* Como o Optiongroup1 nao tem ControlSource, o Value dele EH o indice do botao
* marcado, e esse indice EH o retorno. Dai os cinco valores possiveis, lidos
* nos call sites e conferidos contra as legendas dos quatro OptionButton:
*
*     retorno  legenda no SCX        termo montado  casamento
*     -------  --------------------  -------------  ---------------------
*        1     " Iniciais"           'x%'           comeca com o digitado
*        2     " Finais"             '%x'           termina com o digitado
*        3     "Qualquer Posicao"    '%x%'          contem o digitado
*        4     "Desc. Exata"         (ver abaixo)   igualdade
*        0     (botao Encerrar)      -              o chamador nao consulta
*
* O default eh 1: o SCX declara Optiongroup1.Value = 1, e o Wait Window do
* chamador confirma ("Procurando Contas INICIADAS Com a Descricao Informada").
*
*------------------------------------------------------------------------------
* MONTAGEM DO TERMO - TRANSCRITA DOS CALL SITES (regra #17)
*
* O chamador decide o operador e os sinais de porcentagem assim:
*
*     If ThisForm.pnRetorno <> 0
*         If Not ThisForm.pnRetorno = 4
*             lcTmp = Iif(ThisForm.pnRetorno = 2 or ThisForm.pnRetorno = 3, '%', '') + ;
*                     Alltrim(.getNome.Value) + ;
*                     Iif(ThisForm.pnRetorno = 1 or ThisForm.pnRetorno = 3, '%', '')
*         EndIf
*
*         lcQuery = [Select * ] + ;
*                     [From SigCdCli ] + ;
*                    [Where Rtrim(RClis) ] + Iif(ThisForm.pnRetorno = 4, [=], [Like]) + [ ?lcTmp] + ;
*                           Iif(Empty(lcGru), [], [ And Grupos = ?lcGru])
*     EndIf
*
* Tres detalhes do legado que NAO se simplificam:
*
* (1) o ALLTRIM eh aplicado ao valor do campo DE NOVO na hora de montar o
*     termo, e nao ao valor que o chamador ja tinha guardado antes;
*
* (2) no modo 4 (Desc. Exata) o If interno nao entra e lcTmp PERMANECE com o
*     Padr(<valor>, N) que o chamador atribuiu ANTES de abrir o dialogo, isto
*     eh, o termo exato vai ao servidor PREENCHIDO COM BRANCOS ate a largura
*     da coluna. Eh assim que o legado consulta e eh assim que se reproduz;
*
* (3) o N do Padr eh a largura da COLUNA consultada, nunca pixel de controle
*     (regra #19) - conferido em docs/schema.sql (UTF-16, lido com
*     Get-Content -Raw, regra #14):
*
*     call site   campo do pai     coluna consultada   Padr   schema
*     ---------   --------------   -----------------   ----   ---------------
*     9111        get_Descr        Rtrim(RClis)         50    rclis   char(50)
*     9146        getNome          Rtrim(RClis)         50    rclis   char(50)
*     9183        getRazao         Rtrim(Razaos)        50    razaos  char(50)
*     9208        get_Contato      Rtrim(Contato)       40    contato char(40)
*
* Por isso this_nTamanhoTermo eh property com default 50 (o caso majoritario)
* e nao constante: o call site do campo Contato passa 40.
*
*------------------------------------------------------------------------------
* ONDE FICA O poForm
*
* A referencia ao form pai NAO entra neste BO. Ela eh contexto de INTERFACE e,
* guardada aqui, fecharia um ciclo de referencias (pai -> dialogo -> BO ->
* pai) que atrasa a liberacao dos objetos. Fica em FormSigOpCtd, que eh quem
* reproduz a copia feita pelo Destroy legado.
*
* O consumo canonico do resultado no sistema novo eh o chamador LER a property
* depois do Show(), padrao que FormBuscaAuxiliar e FormOpcaoBusca ja seguem:
*
*     loc_oDlg = CREATEOBJECT("FormSigOpCtd", loc_cMsg)
*     IF VARTYPE(loc_oDlg) = "O"
*         loc_oDlg.Show()                        && modal: bloqueia ate o Hide()
*         loc_nRetorno = loc_oDlg.this_nRetorno  && LER antes de soltar
*         loc_oDlg = .NULL.
*     ENDIF
*
* Duas regras valem nesse caminho: o Show() de form modal fica FORA de
* qualquer TRY (regra #29 - dentro dele, o primeiro erro de runtime derruba a
* tela), e os botoes chamam Hide(), nao Release() - Release() destroi o objeto
* e a leitura da linha seguinte estoura com "is not an object" (Erro168).
*
*------------------------------------------------------------------------------
* RELACAO COM O FormOpcaoBusca JA EXISTENTE
*
* classes\FormOpcaoBusca.prg foi escrito quando o SigOpCtd.SCX ainda nao estava
* no acervo: o contrato dele havia sido deduzido destes mesmos call sites do
* msv_procurar, e eh ele que FormCTA e FormCliente usam hoje. Com o SCX em
* maos, os numeros 0..4, a ordem dos quatro modos e o default 1 se confirmam
* IDENTICOS - ou seja, o comportamento em producao esta correto, e o que esta
* migracao acrescenta eh a fidelidade VISUAL (as 800 x 200 com cntSombra, os
* quatro OptionButton em UMA linha horizontal e o Commandgroup1 com
* Procurar/Encerrar). Trocar os dois chamadores para FormSigOpCtd eh decisao
* separada desta task, e nada neste arquivo depende dela.
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA - BO SEM TABELA E SOMENTE-LEITURA
*
* O dump do legado nao tem SELECT, INSERT, UPDATE, DELETE, TABLEUPDATE nem
* .AddCursor( - os quatro metodos da tela (Init, Destroy e os dois Click)
* somam SEIS linhas de codigo e mexem apenas em properties. Logo:
*
*   - this_cTabela e this_cCampoChave ficam VAZIOS: a tela nao tem entidade
*     propria. A tabela que os chamadores consultam (SigCdCli) eh deles, nao
*     deste dialogo, e fixa-la aqui daria a impressao falsa de que este BO
*     grava nela;
*
*   - o DODEFAULT() do Init eh chamado SEM nome de tabela, de proposito: sem
*     nenhuma ida ao servidor nao ha DataAccess a instanciar;
*
*   - este BO nao sobrescreve Inserir(), Atualizar() nem ExecutarExclusao(). O
*     comportamento padrao herdado de BusinessBase (recusar a operacao e
*     reportar pelo ExibirFalha do Salvar) ja eh o correto, e sobrescrever
*     esses metodos exigiria INVENTAR uma lista de colunas, o que a regra #22
*     proibe;
*
*   - ObterChavePrimaria() e RegistrarAuditoria() tambem ficam herdados, e o
*     par ja se resolve sozinho: a base devolve chave VAZIA e o
*     RegistrarAuditoria sai com .F. antes de montar o INSERT em LogAuditoria.
*     Eh o resultado certo - dialogo que nao persiste nada nao tem o que
*     auditar, e forcar uma linha de auditoria exigiria inventar a
*     this_cTabela que o primeiro item deste bloco deixa vazia de proposito;
*
*   - CarregarDoCursor() eh o UNICO que vale sobrescrever, e NAO para ler
*     coluna nenhuma: a versao da base devolve .T. sem carregar nada, isto eh,
*     anuncia sucesso a quem a chamar. Num BO sem cursor esse .T. MENTE, e o
*     unico jeito de ele nao mentir eh recusar - exatamente o que
*     Inserir()/Atualizar() ja fazem na base. Ver o metodo logo apos o Init.
*==============================================================================

DEFINE CLASS SigOpCtdBO AS BusinessBase

    *--------------------------------------------------------------------------
    * MENSAGEM DE CONTEXTO
    *
    * O primeiro parametro do form legado (pcCaption) nao eh um titulo
    * generico: eh a frase que o msv_procurar monta para dizer em que grupo a
    * procura vai acontecer - 'Procura No Grupo "<grupo>"' ou 'Procura Sem
    * Grupo Definido'. O legado a usa em TRES lugares (ThisForm.Caption,
    * cntSombra.lblSombra.Caption e cntSombra.lblTitulo.Caption), por isso ela
    * tem fonte unica aqui em vez de ser lida da tela.
    *--------------------------------------------------------------------------
    this_cMensagem = ""             && legado: pcCaption / lcMsg do chamador

    *--------------------------------------------------------------------------
    * MODO MARCADO NA TELA E RETORNO ENTREGUE AO CHAMADOR
    *
    * Sao DUAS properties, e a separacao eh a do legado: Optiongroup1.Value
    * guarda o que esta marcado (e continua marcado mesmo se o usuario
    * desistir) e pnReturno guarda o que a tela entrega - zero quando o botao
    * acionado foi o Encerrar. Juntar as duas faria o cancelamento apagar a
    * escolha, e o chamador perderia a unica informacao que distingue
    * "cancelou" de "escolheu Iniciais".
    *
    * this_nOpcaoSelecionada nasce em 1 porque o SCX declara
    * Optiongroup1.Value = 1 (" Iniciais" eh o default do legado).
    *
    * this_lConfirmou eh o estado explicito do botao acionado: .T. para
    * Procurar, .F. para Encerrar e para o fechamento pelo ESC (Command2 tem
    * Cancel = .T. no SCX). Existe para que form e chamador nao tenham de
    * deduzir a intencao do usuario a partir de this_nRetorno = 0.
    *--------------------------------------------------------------------------
    this_nOpcaoSelecionada = 1      && legado: Optiongroup1.Value (1..4)
    this_nRetorno          = 0      && legado: pnReturno -> poForm.pnRetorno
    this_lConfirmou        = .F.    && .T. so quando o botao foi "Procurar"

    *--------------------------------------------------------------------------
    * OS QUATRO MODOS, COM NOME
    *
    * Os numeros do contrato ficam em property nomeada em vez de literais
    * espalhados pelo codigo: eh a ORDEM dos OptionButton no SCX que define o
    * valor entregue, e comparacao contra 1/2/3/4 escrita de memoria eh
    * candidata a inverter dois modos em silencio (regra #45).
    *
    * this_nTotalModos eh o ButtonCount = 4 do Optiongroup1, usado para
    * recusar valor fora da faixa antes de entrega-lo ao chamador.
    *--------------------------------------------------------------------------
    this_nModoIniciais = 1          && " Iniciais"         -> 'x%'
    this_nModoFinais   = 2          && " Finais"           -> '%x'
    this_nModoQualquer = 3          && "Qualquer Posicao"  -> '%x%'
    this_nModoExata    = 4          && "Desc. Exata"       -> igualdade
    this_nTotalModos   = 4          && legado: Optiongroup1.ButtonCount

    *--------------------------------------------------------------------------
    * MONTAGEM DO TERMO - ENTRADA E SAIDA
    *
    * O legado monta o termo DENTRO de cada call site, com a expressao
    * transcrita no cabecalho deste arquivo. Mante-la num lugar unico evita que
    * os quatro call sites (e os dois chamadores do sistema novo, FormCTA e
    * FormCliente) divirjam entre si.
    *
    * ENTRADA:
    *   this_cTermoDigitado - o texto que o usuario digitou no campo do form
    *                         pai, CRU: sem ALLTRIM e sem PADR aplicados, pois
    *                         as duas transformacoes acontecem na montagem e
    *                         dependem do modo escolhido.
    *   this_nTamanhoTermo  - largura da COLUNA consultada, que eh o N do
    *                         Padr(<valor>, N) do chamador e so importa no
    *                         modo Desc. Exata. Default 50 (rclis/razaos); o
    *                         call site do campo Contato passa 40.
    *
    * SAIDA:
    *   this_cTermoBusca    - o lcTmp do legado, ja com os '%' do modo ou com
    *                         o preenchimento de brancos do modo exato.
    *   this_cOperador      - "Like" ou "=", o Iif(pnRetorno = 4, [=], [Like]).
    *
    * Ler as duas properties de saida eh OPCIONAL para o chamador: o contrato
    * minimo do legado continua sendo apenas o numero em this_nRetorno.
    *--------------------------------------------------------------------------
    this_cTermoDigitado = ""        && valor cru do campo do form pai
    this_nTamanhoTermo  = 50        && largura da coluna consultada
    this_cTermoBusca    = ""        && legado: lcTmp
    this_cOperador      = ""        && legado: Iif(pnRetorno = 4, [=], [Like])

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Parametros, todos opcionais:
    *     par_cMensagem      - a frase de contexto do chamador (o pcCaption do
    *                          form legado). Omitida, fica vazia e o form
    *                          exibe o titulo sem complemento.
    *     par_cTermoDigitado - o texto digitado no campo do form pai, cru.
    *     par_nTamanhoTermo  - largura da coluna consultada. Omitida ou fora de
    *                          faixa, fica o default 50.
    *
    * DODEFAULT() eh chamado SEM o nome da tabela de proposito - ver a nota de
    * arquitetura no cabecalho do arquivo.
    *
    * Devolve SEMPRE .T.: nao ha pre-requisito que possa falhar aqui (nenhum
    * SQL, nenhum cursor a abrir), e Init de BO que devolve .F. transforma o
    * CREATEOBJECT em logico e derruba o Init do proprio form, deixando a tela
    * sem abrir.
    *==========================================================================
    PROCEDURE Init(par_cMensagem, par_cTermoDigitado, par_nTamanhoTermo)
        LOCAL loc_cMensagem, loc_cTermo, loc_nTamanho

        DODEFAULT()

        *-- A tela nao tem entidade propria: a tabela consultada eh do
        *-- chamador, nao deste dialogo (nota de arquitetura no cabecalho)
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        *-- Frase de contexto (legado: ThisForm.Caption = pcCaption)
        loc_cMensagem = ""
        IF VARTYPE(par_cMensagem) = "C"
            loc_cMensagem = ALLTRIM(par_cMensagem)
        ENDIF
        THIS.this_cMensagem = loc_cMensagem

        *-- Modo marcado: 1 (" Iniciais"), como o SCX declara
        THIS.this_nOpcaoSelecionada = THIS.this_nModoIniciais

        *-- Nenhum botao acionado ainda: fechar a tela sem escolher equivale ao
        *-- Encerrar, e nesse caso o chamador nao executa consulta nenhuma
        THIS.this_nRetorno   = 0
        THIS.this_lConfirmou = .F.

        *-- Texto digitado no campo do form pai, guardado CRU
        loc_cTermo = ""
        IF VARTYPE(par_cTermoDigitado) = "C"
            loc_cTermo = par_cTermoDigitado
        ENDIF
        THIS.this_cTermoDigitado = loc_cTermo

        *-- Largura da coluna consultada: 50 em rclis/razaos, 40 em contato
        loc_nTamanho = 0
        IF VARTYPE(par_nTamanhoTermo) = "N"
            loc_nTamanho = INT(par_nTamanhoTermo)
        ENDIF
        IF loc_nTamanho <= 0
            loc_nTamanho = 50
        ENDIF
        THIS.this_nTamanhoTermo = loc_nTamanho

        *-- Nenhum termo montado ainda
        THIS.this_cTermoBusca = ""
        THIS.this_cOperador   = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - RECUSA, de proposito: esta tela nao tem cursor
    *
    * Sobrescreve a versao de BusinessBase, que devolve .T. sem ler nada. Esse
    * .T. da base eh um "carreguei" para quem chamou, e num BO sem tabela ele
    * ESCONDERIA o erro do chamador em vez de mostra-lo. O dump do legado
    * (task715) nao tem SELECT, nao tem .AddCursor( e nao tem TABLEUPDATE: as
    * properties desta tela chegam todas pelo Init, como o
    * "Do Form SigOpCtd With lcMsg, ThisForm" do msv_procurar entrega.
    *
    * Logo a recusa EH o comportamento final, no mesmo padrao que a base ja
    * usa em Inserir()/Atualizar(): devolve .F. e deixa o motivo em
    * this_cMensagemErro, de onde ObterMensagemErro() o entrega ao chamador.
    * Sem MsgErro aqui - este dialogo ja eh modal, e quem abre caixa na base eh
    * o ExibirFalha do Salvar/Excluir, que este BO nao alcanca.
    *
    * par_cAliasCursor entra apenas na mensagem, para o chamador saber QUAL
    * alias pediu. O alias nunca eh aberto, selecionado nem lido.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = ""
        IF VARTYPE(par_cAliasCursor) = "C"
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ENDIF

        THIS.this_cMensagemErro = "SigOpCtdBO n" + CHR(227) + "o carrega dados de cursor" + ;
            IIF(EMPTY(loc_cAlias), "", " (" + loc_cAlias + ")") + ;
            ": a tela SigOpCtd apenas pergunta o modo de procura e devolve o " + ;
            "n" + CHR(250) + "mero em this_nRetorno. O texto digitado e a largura da " + ;
            "coluna v" + CHR(234) + "m pelo Init."

        RETURN .F.
    ENDPROC

    *==========================================================================
    * MontarTermoBusca - Monta o termo de busca e o operador conforme o modo
    * marcado em this_nOpcaoSelecionada
    *
    * Transcricao literal (regra #17) do que o chamador legado faz dentro do
    * If ThisForm.pnRetorno <> 0 (ver cabecalho do arquivo, secao "MONTAGEM DO
    * TERMO"):
    *
    *     If Not ThisForm.pnRetorno = 4
    *         lcTmp = Iif(pnRetorno = 2 Or pnRetorno = 3, '%', '') + ;
    *                 Alltrim(<valor>) + ;
    *                 Iif(pnRetorno = 1 Or pnRetorno = 3, '%', '')
    *     EndIf
    *     ... Iif(pnRetorno = 4, [=], [Like]) ...
    *
    * No modo Desc. Exata (4) o If interno NAO roda, e lcTmp permanece com o
    * Padr(<valor>, N) que o chamador atribuiu ANTES de abrir a tela - aqui
    * reproduzido com o valor cru (this_cTermoDigitado) e a largura da coluna
    * (this_nTamanhoTermo) que este BO recebeu no Init.
    *==========================================================================
    PROCEDURE MontarTermoBusca()
        LOCAL loc_cTermo

        loc_cTermo = ALLTRIM(THIS.this_cTermoDigitado)

        IF THIS.this_nOpcaoSelecionada = THIS.this_nModoExata
            THIS.this_cTermoBusca = PADR(loc_cTermo, THIS.this_nTamanhoTermo)
            THIS.this_cOperador   = "="
        ELSE
            THIS.this_cTermoBusca = ;
                IIF(INLIST(THIS.this_nOpcaoSelecionada, THIS.this_nModoFinais, THIS.this_nModoQualquer), "%", "") + ;
                loc_cTermo + ;
                IIF(INLIST(THIS.this_nOpcaoSelecionada, THIS.this_nModoIniciais, THIS.this_nModoQualquer), "%", "")
            THIS.this_cOperador = "Like"
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ConfirmarOpcao - Legado: Commandgroup1.Command1.Click ("Procurar")
    *     ThisForm.pnReturno = ThisForm.Optiongroup1.Value
    *
    * Marca o retorno com o modo atualmente selecionado (this_nOpcaoSelecionada
    * - ver regra #45 do CLAUDE.md: a ORDEM/numero vem do OptionGroup, nunca de
    * literal reescrito), monta o termo de busca correspondente e sinaliza que
    * o usuario confirmou a escolha, em vez de ter encerrado sem decidir.
    *
    * Chamado PUBLIC porque o botao "Procurar" do form o aciona via
    * BINDEVENT/Click direto (regra #3 do CLAUDE.md).
    *==========================================================================
    PROCEDURE ConfirmarOpcao()
        IF THIS.this_nOpcaoSelecionada < 1 OR THIS.this_nOpcaoSelecionada > THIS.this_nTotalModos
            THIS.this_nOpcaoSelecionada = THIS.this_nModoIniciais
        ENDIF

        THIS.this_nRetorno   = THIS.this_nOpcaoSelecionada
        THIS.this_lConfirmou = .T.

        THIS.MontarTermoBusca()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Cancelar - Legado: Commandgroup1.Command2.Click ("Encerrar")
    *     ThisForm.pnReturno = 0
    *
    * Mesmo efeito do ESC (o SCX declara Command2.Cancel = .T.): o chamador
    * nao deve executar consulta nenhuma, entao o termo e o operador voltam a
    * vazio junto com o retorno.
    *==========================================================================
    PROCEDURE Cancelar()
        THIS.this_nRetorno    = 0
        THIS.this_lConfirmou  = .F.
        THIS.this_cTermoBusca = ""
        THIS.this_cOperador   = ""

        RETURN .T.
    ENDPROC

ENDDEFINE
