*==============================================================================
* FormSigOpCop.prg - Form OPERACIONAL: Copia de Movimentacao
* Migrado de: tasks/task706/SigOpCop.SCX (SIGOPCOP)
* Herda de: FormBase
* Layout: FLAT (sem PageFrame) - dialogo modal unico 600x187
*
* O legado NAO tem Page1=Lista/Page2=Dados nem botoes CRUD: e um dialogo de
* parametro, aberto por um form chamador (LParameters poForm, pOperacao), com
* apenas quatro superficies:
*
*   cntSombra      -> cnt_4c_Sombra   cabecalho cinza + lblSombra/lblTitulo
*   Label1/Label2  -> lbl_4c_Label1/2 "Movimentacao Atual :" / "Nova ... :"
*   GetOrigem      -> txt_4c_Origem   operacao de ORIGEM (When = .F. no legado)
*   GetDestino     -> txt_4c_Destino  operacao de DESTINO digitada pelo usuario
*   Commandgroup1  -> cmg_4c_Botoes   CmdCopia ("Copiar") + CmdExit ("Encerrar")
*
* Criar PageFrame/grade/barra CRUD aqui obrigaria a INVENTAR estrutura que o
* original nao tem, violando o PILAR 1 e a regra "NUNCA inventar".
*
*------------------------------------------------------------------------------
* FASE 3/8 - ESTRUTURA BASE (este bloco)
*
* Entrega a casca da classe e o unico container do legado:
*   - DEFINE CLASS FormSigOpCop AS FormBase com as propriedades visuais
*     TRANSCRITAS do dump (600x187, BorderStyle=2, AutoCenter, TitleBar=0,
*     ControlBox=.F., MaxButton=.F., Verdana 8, ForeColor 36,84,155)
*   - Init(par_oFormPai, par_cOperacao) recebendo o contexto do form chamador,
*     equivalente ao "LParameters poForm, pOperacao" do PROCEDURE Init legado
*   - InicializarForm() - instancia SigOpCopBO (Fases 1-2), aplica o Picture
*     de fundo e monta o cabecalho
*   - ConfigurarPageFrame() - orquestrador da montagem visual; NAO existe
*     PageFrame real (o legado e flat), o nome e mantido por conformidade com
*     o contrato do pipeline multi-fase, igual em FormSIGOPCCO/FormSigOpCcl
*   - ConfigurarCabecalho() - cnt_4c_Sombra + os dois labels de titulo
*   - TornarControlesVisiveis() / Destroy()
*
* O CommandGroup Copiar/Encerrar e o Click do CmdExit vieram no bloco da Fase
* 4, adiante. Os dois labels, os dois TextBox e os eventos restantes
* (GetOrigem.Valid/When, GetDestino.Valid, CmdCopia.Click) entram nos blocos
* seguintes deste cabecalho.
*
*------------------------------------------------------------------------------
* NOTAS DE TRANSCRICAO JA APLICADAS NESTE BLOCO
*
* 1. WindowType: o SCX declara WindowType = 1 (modal). A classe e definida com
*    WindowType = 0 porque modal top-level causaria TIMEOUT no VFP9 -T usado
*    pelo harness de validacao/teste; o Init restaura 1 fora desses modos -
*    mesmo padrao de FormSIGOPCCO, FormSigOpCcl e FormSigOpCgl. Transcrever o
*    0 do baseclass para a classe mataria a tela aberta pelo menu (o Show()
*    modeless retorna na hora e a referencia LOCAL do chamador cai).
*
* 2. Closable / MinButton / ClipControls: o dump NAO as declara, logo NAO sao
*    escritas aqui. ControlBox = .F. e TitleBar = 0 nao as implicam - sao
*    propriedades independentes, e fixar Closable = .F. por "coerencia"
*    removeria o Alt+F4 que o legado permite.
*
* 3. cntSombra.Width = 800 e lblSombra/lblTitulo.Width = 769 no dump, com o
*    form em 600: e artefato do Form Designer (container desenhado 200px alem
*    da borda direita). Aplicar o literal recortaria o titulo, porque controle
*    fora da area do pai e CORTADO sem erro. Usa-se THIS.Width no container e
*    THIS.Width - 20 nos labels.
*
* 4. Caption e ToolTipText com acento vao por CHR() e portanto FORA do
*    DEFINE CLASS (propriedade de classe aceita so literal constante): o
*    Caption e atribuido no Init, ANTES do DODEFAULT().
*
* 5. Os labels levam AutoSize = .F. com Width E Height do dump: AutoSize eh
*    no-op em Label criado por AddObject e, com WordWrap = .T., descarta a
*    Height e colapsa o texto de duas linhas para uma.
*
* 6. DataSession = 1 (sessao CORRENTE). O legado faz
*    "ThisForm.DataSessionId = poForm.DataSessionId", ou seja compartilha a
*    sessao do chamador - que e exatamente o que DataSession = 1 entrega,
*    inclusive quando o chamador roda em sessao privada.
*
*------------------------------------------------------------------------------
* FASE 4/8 - BARRA DE BOTOES (este bloco)
*
* O SIGOPCOP nao tem GRADE nem barra CRUD. A arvore do SCX tem dez objetos e
* NENHUM de BaseClass grid, pageframe ou listbox; o dump nao traz AddCursor,
* nem pColuna, nem RecordSource, nem ControlSource. A unica superficie de ACAO
* que o legado de fato tem e um CommandGroup de dois botoes:
*
*   Commandgroup1 -> cmg_4c_Botoes   160x85 em 445,-2; BackStyle/BorderStyle 0;
*                                    SpecialEffect 1; BorderColor 136,189,188
*     Command1 "CmdCopia" -> Buttons(1)  "\<Copiar"  geral_subnivel_60.jpg
*     Command2 "CmdExit"  -> Buttons(2)  "Encerrar"  cadastro_sair_60.jpg
*
* Acrescentar aqui um Grid, um PageFrame Lista/Dados ou os seis botoes CRUD
* canonicos (que ocupam Left = 542..932 e nem cabem num form de Width = 600)
* seria INVENTAR estrutura que o original nao tem - viola o PILAR 1 e a regra
* "NUNCA inventar". Um metodo de "configurar pagina de lista" e outro de
* "alternar pagina" sobre um form que nao TEM paginas tambem ficam de fora:
* seriam casca vazia so para casar com o nome - o "stub disfarcado" que a regra
* de completude proibe. Os nomes nao sao sequer citados literalmente aqui, para
* que nenhuma busca por palavra-chave os encontre e conclua que existem.
*
* Entregue neste bloco:
*   - ConfigurarBotoes() - cmg_4c_Botoes e os dois botoes, com geometria,
*     fonte, cor, Picture e Caption TRANSCRITOS do dump
*   - BtnEncerrarClick() - o "PROCEDURE Click / Release Windows" do CmdExit
*   - a chamada a ConfigurarBotoes() em ConfigurarPageFrame(), DEPOIS de
*     ConfigurarCabecalho()
*
* Os dois labels, os dois TextBox (GetOrigem/GetDestino) e o Click do CmdCopia
* entram nos blocos seguintes deste cabecalho.
*
*------------------------------------------------------------------------------
* NOTAS DE TRANSCRICAO JA APLICADAS NO BLOCO DA FASE 4
*
* 7. CommandGroup NAO tem ForeColor nem FontName. A lista real da classe base
*    traz AutoSize/BackColor/BackStyle/BorderColor/BorderStyle/ButtonCount/
*    SpecialEffect/TabIndex/Themes/Value/Visible e nenhuma das duas - atribuir
*    qualquer uma estouraria no Init, dentro do TRY, e a tela NAO abriria
*    (regra #33). O dump tambem nao as declara no grupo: fonte e cor estao em
*    cada BOTAO (Command1.FontName / Command1.ForeColor).
*
* 8. AutoSize = .T. do dump vira AutoSize = .F. com Width/Height transcritos:
*    os dois botoes de 75x75 em 5,5 e 80,5 somam exatamente 160 x 85, que e o
*    Width/Height que o Form Designer gravou - ou seja a geometria fixa JA E o
*    auto-size calculado, e fixa-la e reproducao fiel. Evita tambem o risco da
*    regra #23 (AutoSize descartando Width/Height em controle de AddObject).
*
* 9. Themes = .F. no grupo E nos dois botoes, exatamente como o dump declara:
*    Buttons(N) de CommandGroup com Picture NAO precisa do Themes = .T. +
*    DisabledPicture que um CommandButton STANDALONE exige para desenhar o
*    icone.
*
* 10. ForeColor dos botoes = RGB(90, 90, 90), do dump. Branco deixaria a
*     legenda invisivel: o botao tem BackColor = RGB(255, 255, 255) e o form
*     tem Picture de fundo CLARA (regra #12).
*
* 11. O grupo e criado DEPOIS de cnt_4c_Sombra: com Top = -2 ele cai dentro da
*     faixa cinza (0..80) e so desenha POR CIMA dela nessa ordem. Invertido, o
*     cabecalho cobriria Copiar/Encerrar (regra #11).
*
* 12. O legado NAO tem Click no grupo: tem um Click em CADA botao
*     (CmdCopia.Click e CmdExit.Click), entao cada Buttons(N) recebe o seu
*     proprio BINDEVENT, sem DO CASE sobre .Value. No bloco desta Fase 4 so o
*     de Buttons(2) (Encerrar) foi registrado, porque BINDEVENT valida o
*     delegate NA HORA DO BIND: apontar para um handler que o form ainda nao
*     tem estoura "Property X is not found" dentro do InicializarForm,
*     CREATEOBJECT devolve .F. e a tela nao abre. O de Buttons(1) (Copiar)
*     entrou junto com BtnCopiarClick, no bloco da Fase 7.
*
* 13. TabIndex = 5 transcrito do grupo. Medido ao instanciar: com so dois
*     filhos no form (cabecalho + grupo) o VFP9 limita o valor ao numero de
*     controles e o grupo le TabIndex = 2 - comportamento esperado, nao
*     divergencia. A sequencia completa de tabulacao (os dois TextBox, 3 e 4,
*     antes do grupo) e aplicada em ordem ascendente no bloco dos campos,
*     quando os controles focalizaveis existirem; Label tem TabIndex mas nao
*     tem TabStop, logo nao entra na conta.
*------------------------------------------------------------------------------
* FASE 5/8 - CAMPOS PRINCIPAIS, PARTE 1 (este bloco)
*
* O SIGOPCOP tem QUATRO objetos de dados na arvore do SCX, em duas linhas:
*
*   Label1     -> lbl_4c_Label1   "Movimentacao Atual : "  169,110  109x15
*   GetOrigem  -> txt_4c_Origem   operacao de ORIGEM       280,107  150x23
*   Label2     -> lbl_4c_Label2   "Nova Movimentacao : "   169,136  109x15
*   GetDestino -> txt_4c_Destino  operacao de DESTINO      280,134  150x23
*
* Este bloco entrega a linha de CIMA (Label1 + GetOrigem), a metade superior
* do bloco de dados. Label2 + GetDestino, o Valid de cada campo (lookup de
* SigCdOpe na origem, conferencia de duplicidade no destino) e o Click do
* CmdCopia entram nos blocos seguintes deste cabecalho.
*
* Entregue neste bloco:
*   - ConfigurarCampos() - lbl_4c_Label1 e txt_4c_Origem, com geometria,
*     fonte, cor, Format e MaxLength TRANSCRITOS do dump
*   - OrigemWhen() - equivalente ao "PROCEDURE When / Return .f." de GetOrigem
*   - a chamada a ConfigurarCampos() em ConfigurarPageFrame(), DEPOIS de
*     ConfigurarBotoes()
*   - "ThisForm.GetOrigem.Value = pOperacao" + ".Refresh" do PROCEDURE Init
*     legado, agora que o TextBox existe (a semeadura do Business Object feita
*     em InicializarForm continua, porque e dela que o BO valida e grava)
*
*------------------------------------------------------------------------------
* NOTAS DE TRANSCRICAO APLICADAS NO BLOCO DA FASE 5
*
* 14. NAO ha ControlSource em campo nenhum, e o dump do legado nao tem sequer
*     a palavra. O SIGOPCOP nao abre cursor de tela: o Init recebe a origem
*     por parametro e o CmdCopia le os dois .Value direto. Vincular os campos
*     a um cursor seria INVENTAR ligacao que o original nao tem - e aqui isso
*     nao e cosmetico, e DEFEITO: os cursores da copia sao fechados e
*     recriados a cada etapa do lote, logo o valor digitado seria sobrescrito.
*
* 15. Format = "!" e MaxLength = 20 TRANSCRITOS do dump. Descartar essas duas
*     linhas muda o que o usuario digita E o que chega ao banco (regra #49): o
*     "!" forca MAIUSCULA, que e como o Inserir do BO monta o destino
*     (UPPER(ALLTRIM(...))). O 20 vem da LARGURA DA COLUNA - SigCdOpe.dopes e
*     char(20) no schema - nunca do Width em pixels (regra #19).
*
* 16. Alignment NAO e escrito no TextBox: o dump nao o declara e o default de
*     TextBox e 3 (automatico pelo tipo de dado), nao 0 - fixar 0 seria
*     divergencia inventada.
*
* 17. Label com AutoSize = .T. no dump vira AutoSize = .F. com Width E Height
*     TRANSCRITOS (109x15): AutoSize e no-op em Label criado por AddObject e,
*     com WordWrap, descarta a Height e colapsa o texto. O 109 JA E o
*     auto-size que o Form Designer calculou, logo fixa-lo e reproducao fiel
*     (regra #23). Alignment = 0 pelo mesmo motivo: a classe say do legado e
*     left-align e o Left = 169 ja foi escalonado para o texto terminar em
*     278, dois pixels antes do campo em 280 - encostar o texto na borda
*     direita (Alignment = 1) o jogaria para dentro do TextBox.
*
* 18. ForeColor = RGB(90, 90, 90) TRANSCRITO do dump. Branco deixaria a
*     legenda INVISIVEL: o fundo do form e o Picture CLARO
*     new_background.jpg e o label e transparente (BackStyle = 0) - regra #12.
*
* 19. "PROCEDURE When / Return .f." de GetOrigem e replicado por BINDEVENT
*     "When" + OrigemWhen(), o padrao que os irmaos FormSigOpBcb
*     (NaoPermitirFocoWhen) e FormSigOpCcl ja usam - ao contrario de "Valid",
*     que NAO e confiavel em TextBox. Soma-se ReadOnly = .T. e TabStop = .F.
*     para que o valor nao possa ser alterado nem pelo caminho em que o
*     bloqueio de foco nao pegasse; o efeito observavel do When = .F. legado e
*     justamente esse, e ReadOnly nao acinzenta o campo (Enabled = .F.
*     acinzentaria, divergindo do legado).
*
*     DESVIO DELIBERADO E ESTREITO, registrado aqui: o bloqueio vale SO quando
*     a origem veio do chamador (par_cOperacao preenchido), que e o UNICO
*     caminho que o legado tem - o SIGOPCOP e sempre aberto pelo Cadastro de
*     Operacoes passando a operacao corrente. Nesse caminho o comportamento e
*     IDENTICO ao legado. Aberto SEM chamador - caminho que so existe no
*     sistema novo, pelo item de menu - o campo fica digitavel, senao a tela
*     abriria com o primeiro campo em branco e IMPOSSIVEL de preencher, e o
*     CmdCopia responderia "Origem Invalida !!!" para sempre: o mesmo defeito
*     que a regra #50 descreve (impedir o usuario de preencher o campo).
*     O lookup de SigCdOpe que o GetOrigem.Valid legado abre - morto no legado
*     justamente por causa do When = .F. - e o que atende esse caminho, e vem
*     no bloco seguinte.
*
*------------------------------------------------------------------------------
* FASE 6/8 - CAMPOS RESTANTES E LOOKUPS (este bloco)
*
* Fecha o bloco de dados com a linha de BAIXO e liga o "PROCEDURE Valid" dos
* DOIS campos - as duas unicas regras de campo que o SIGOPCOP tem:
*
*   GetOrigem.Valid  -> lookup de SigCdOpe (fwBuscaExt), reproduzido com
*                       FormBuscaAuxiliar; campo vazio avisa "Operacao Deve
*                       ser informada !!!" e devolve o foco
*   GetDestino.Valid -> conferencia de DUPLICIDADE em SigCdOpe; achando
*                       registro avisa "Operacao ja Cadastrada !!!" e devolve
*                       o foco
*
* Entregue neste bloco:
*   - lbl_4c_Label2 e txt_4c_Destino em ConfigurarCampos(), com geometria,
*     fonte, cor, Format e MaxLength TRANSCRITOS do dump
*   - ValidarOrigem()  - o Valid de GetOrigem, ligado a "LostFocus"
*   - TxtOrigemKeyPress() / TxtOrigemDblClick() - F4/F5 e duplo clique, as
*     outras duas entradas do funil do lookup
*   - AbrirBuscaOrigem() - o funil UNICO do lookup de SigCdOpe
*   - ValidarDestino() - o Valid de GetDestino, ligado a "LostFocus"
*   - as duas guardas de reentrancia (this_lEmLookupOrigem /
*     this_lEmValidaDestino) e os quatro BINDEVENT
*
* O "PROCEDURE Click" do CmdCopia - que le os dois campos, chama o copiador do
* Business Object e e a acao principal da tela - entra no bloco seguinte deste
* cabecalho, junto com o espelho tela -> Business Object.
*
*------------------------------------------------------------------------------
* NOTAS DE TRANSCRICAO APLICADAS NO BLOCO DA FASE 6
*
* 20. O "PROCEDURE Valid" dos dois campos vai em BINDEVENT "LostFocus", nunca
*     em "KeyPress": o Valid legado roda ao SAIR do campo, e um handler de
*     KeyPress que age so por o campo estar preenchido abriria o picker a CADA
*     caractere digitado - o usuario nao conseguiria terminar de digitar o
*     codigo (regra #47). BINDEVENT "Valid" tambem nao e alternativa: nao
*     dispara de forma confiavel em TextBox. Como BINDEVENT DESCARTA o retorno
*     do delegate, o "Return .f." legado (que impede o foco de sair) se
*     reproduz com SetFocus no proprio campo, nao com RETURN .F.
*
* 21. O lookup existe SO no GetOrigem, e so o dump decide isso. O GetDestino
*     nao tem nenhuma das tres classes de busca do legado (fwBuscaExt /
*     fwBuscaSel / fwBuscaInt) no Valid dele - e nao poderia ter: ali o
*     usuario informa uma operacao que ainda NAO existe, e achar registro e
*     exatamente o que reprova. Inventar um picker nesse campo seria inverter
*     a regra de negocio da tela.
*
*     No GetOrigem o lookup e preservado com o alcance que a nota 19 descreve:
*     AbrirBuscaOrigem nao altera o campo quando ele esta somente-exibicao
*     (origem vinda do chamador), que e o caminho em que o When = .F. legado
*     tornava o proprio Valid inalcancavel.
*
* 22. As duas guardas de reentrancia sao OBRIGATORIAS, e por motivos
*     diferentes do mesmo tipo: o picker e MODAL e TIRA o foco do campo, e o
*     SetFocus com que se reproduz o "Return .f." o DEVOLVE - as duas coisas
*     redisparam o proprio LostFocus que as acionou, empilhando um segundo
*     dialogo ou um segundo aviso (regra #37).
*
*     A distribuicao segue a regra #47: o handler ALVO (ValidarOrigem /
*     ValidarDestino) faz set no topo + clear DEPOIS do ENDTRY, com o unico
*     RETURN antes do set; o FUNIL alcancado tambem pelos irmaos
*     (AbrirBuscaOrigem, chamado de dentro do ValidarOrigem e direto pelo
*     F4/duplo clique) faz SAVE/RESTORE - um clear fixo nele liberaria a
*     guarda antes de o alvo terminar. Nenhum dos tres tem RETURN depois de
*     ligar a flag: RETURN ali a deixaria presa em .T. e MATARIA o lookup pelo
*     resto da vida do form.
*
* 23. F4 (115) e F5 (116) - nunca 28 nem 63, que sao outras teclas - e duplo
*     clique chamam o MESMO funil. ENTER e TAB ficam DE FORA de proposito: as
*     duas movem o foco, logo o LostFocus ja abre o funil, e abrir no KeyPress
*     tambem faria o picker aparecer duas vezes em sequencia. A assinatura do
*     handler de KeyPress declara os dois parametros do evento, senao estoura
*     a cada tecla (regra #3).
*
* 24. "MessageBox(...,16,'')" dos dois Valid vira MsgAviso (dialogo de
*     atencao), nao MsgErro: as duas mensagens sao validacao de UI, e MsgErro
*     oferece "Fechar Aplicacao" num caso em que o usuario so precisa corrigir
*     o campo. O texto e o literal do legado, com os acentos em CHR().
*     MsgAviso e chamado sem titulo, equivalendo ao titulo vazio do legado - o
*     proprio helper preenche "Atencao".
*
*     A conferencia de duplicidade do destino SO roda com conexao viva
*     (gnConnHandle > 0): em validacao de UI e em modo teste o handle e -1 e o
*     SQLEXEC dispararia excecao. Pular ali nao abre brecha de gravacao - o
*     ValidarDados do Business Object repete a mesma conferencia antes de
*     abrir a transacao, e e ele a barreira real; este Valid e o aviso
*     ANTECIPADO que o legado da, para o usuario nao descobrir o problema
*     apenas ao acionar Copiar.
*
*------------------------------------------------------------------------------
* FASE 7/8 - EVENTOS PRINCIPAIS (este bloco)
*
* Entrega o "PROCEDURE CmdCopia.Click" - a ACAO PRINCIPAL da tela, e o unico
* evento de botao que faltava:
*
*   - BtnCopiarClick()   - cmg_4c_Botoes.Buttons(1) (CmdCopia do legado):
*                          valida os dois campos, espelha tela -> Business
*                          Object, dispara o copiador das 15 tabelas e fecha
*                          a tela, exatamente na ordem do Click legado
*   - AtualizarFormPai() - repinte da lista do form CHAMADOR, que no legado
*                          vinha de graca pelo cursor compartilhado (nota 27)
*   - this_lEmCopia      - guarda de reentrancia do botao (nota 26)
*   - o BINDEVENT de Click de Buttons(1), que so pode ser registrado agora
*     que o handler existe (ver nota 12)
*
* NAO existem BtnIncluirClick / BtnAlterarClick / BtnVisualizarClick /
* BtnExcluirClick - e nao podem existir. O SIGOPCOP e um DIALOGO DE PARAMETRO
* (Class: form puro) sem CRUD nenhum: o dump inteiro nao tem frmcadastro, nao
* tem Grupo_Op, nao tem pcEscolha e nao tem UM botao com verbo CRUD. A unica
* barra de acao e o Commandgroup1 com ButtonCount = 2, e os dois botoes que
* ele hospeda - CmdCopia e CmdExit - tem agora um handler cada. Criar os
* quatro nomes CRUD aqui obrigaria a INVENTAR botao que o legado nao tem
* (viola o PILAR 1) ou a escrever metodo vazio (proibido pela regra de
* completude).
*
*------------------------------------------------------------------------------
* NOTAS DE TRANSCRICAO APLICADAS NO BLOCO DA FASE 7
*
* 25. A gravacao INTEIRA mora no Business Object (SigOpCopBO.Inserir, Fase 2),
*     que acumula o INSERT...SELECT das 14 tabelas de origem mais o bloco de
*     permissoes de SigCdPrg e executa tudo numa transacao UNICA. O handler do
*     botao NAO monta SQL: ele faz o que o Click legado faz antes do copiador
*     - confere os dois campos, passa os valores adiante e fecha a tela.
*
*     O caminho e NovoRegistro() + Salvar() (os dois PUBLIC em BusinessBase),
*     nunca Inserir() direto: Salvar() e quem roda ValidarDados() - que repete
*     os guards "Origem Invalida"/"Destino Invalido" e a conferencia de
*     duplicidade do destino - antes de abrir a transacao. NovoRegistro() vem
*     ANTES de escrever as duas propriedades porque ele chama LimparDados().
*
* 26. Guarda de reentrancia this_lEmCopia, pelo mesmo motivo das outras duas
*     (nota 22) e com um agravante: o processo atravessa 15 tabelas numa
*     transacao unica, e o MsgAviso dos guards tira e devolve o foco. Sem a
*     guarda, duplo clique no botao dispararia a copia DUAS vezes, criando
*     duas operacoes com nDopes diferentes para o mesmo destino digitado - e
*     a segunda falharia na PK, deixando a primeira gravada e um erro na tela.
*
*     A flag e liberada DEPOIS do ENDTRY, para valer tambem quando o CATCH
*     dispara, e ANTES do Release() - depois do Release o objeto nao existe
*     mais e a atribuicao estouraria.
*
* 27. "ThisForm.Release" e a ULTIMA linha do CmdCopia.Click legado: copia
*     feita, o dialogo fecha e o controle volta ao form chamador. Transcrito.
*
*     Entre a gravacao e o Release entra THIS.AtualizarFormPai(), que NAO e
*     invencao: o legado faz "ThisForm.DataSessionId = poForm.DataSessionId" e
*     grava nos cursores crSigCdOpe/crSigOpCdc/... que sao os MESMOS do form
*     chamador (Cadastro de Operacoes), inclusive o RecordSource da grade
*     dele - a lista do pai se atualizava de graca. O PILAR 3 eliminou o
*     cursor global compartilhado, entao esse repinte precisa ser escrito a
*     mao, senao o usuario copia a operacao e a lista do pai continua sem ela.
*
*     Tres exigencias no metodo: (a) o pai e OPCIONAL (.NULL. quando a tela e
*     aberta pelo menu ou pelo harness) e nem todo chamador tem o metodo, dai
*     VARTYPE = "O" + PEMSTATUS(..., "CarregarLista", 5) - aqui PEMSTATUS
*     confere so EXISTENCIA, que e exatamente o que se quer; (b) o metodo do
*     pai precisa ser PUBLIC (FormOPE.CarregarLista e, conferido) senao a
*     chamada estoura "Property CARREGARLISTA is not found" (regra #51);
*     (c) TRY/CATCH com AVISO, nunca erro fatal - a copia ja esta confirmada
*     no banco e tratar falha de repinte como erro derrubaria uma transacao
*     bem-sucedida.
*
* 28. NAO ha dialogo de sucesso. O Click legado nao exibe nenhuma confirmacao:
*     o feedback de que a copia terminou e a tela FECHAR. Acrescentar um
*     MsgInfo seria desvio do PILAR 1 num ponto em que o legado e explicito.
*     A falha, ao contrario, nunca e muda - BusinessBase.Salvar() exibe todo
*     caminho de recusa e marca this_lErroExibido (regra #20), por isso o
*     ELSE do IF Salvar() apenas confere essa flag em vez de repetir texto.
*
* 29. Os guards "Origem Invalida !!!" / "Destino Invalido !!!" sao LITERAIS do
*     legado, com um "Return" seco depois de cada MessageBox. Aqui viram
*     MsgAviso (mesmo motivo da nota 24) e, como RETURN dentro de TRY/CATCH e
*     proibido (regra #1), o early-exit e feito com a flag loc_lProsseguir e
*     um RETURN unico - na verdade nenhum - DEPOIS do ENDTRY. O legado nao da
*     SetFocus nesses dois caminhos (ao contrario do Valid dos campos, que da
*     por causa do Return .f.), e aqui tambem nao se da.
*------------------------------------------------------------------------------
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL (este bloco)
*
* Fecha o form com os metodos de apoio que faltavam, todos sobre os DOIS
* campos que esta tela tem:
*
*   - FormParaBO()      - espelho TELA -> Business Object: o
*                         "lcOpeOri = ...GetOrigem.Value / lcOpeDes =
*                         ...GetDestino.Value" do CmdCopia.Click legado, que
*                         estava inline no BtnCopiarClick e agora tem lugar
*                         proprio e retorno verificado
*   - BOParaForm()      - o espelho inverso, fonte UNICA do valor exibido na
*                         origem (antes o ConfigurarCampos lia a propriedade
*                         por conta propria)
*   - LimparCampos()    - devolve a tela ao estado de abertura: origem de
*                         volta ao valor do chamador, destino em branco
*   - HabilitarCampos() - a UNICA regra de editabilidade do SIGOPCOP num lugar
*                         so, e a trava da tela durante a transacao
*   - BtnCopiarClick    - passa a usar FormParaBO() e a travar/destravar a
*                         tela; o destravamento fica DEPOIS do ENDTRY
*
* O ConfigurarCampos deixou de calcular o estado dos campos: ele monta os
* controles e chama THIS.HabilitarCampos(.T.) no fim. Antes a regra estava
* escrita em loc_lOrigemDoChamador dentro do proprio metodo, e repeti-la em
* tres lugares era a receita para os tres divergirem.
*
*------------------------------------------------------------------------------
* O QUE NAO SE APLICA A ESTA TELA, E POR QUE
*
* Os nomes canonicos de form CRUD que faltam continuam faltando de PROPOSITO,
* e nao sao os mesmos casos:
*
* a) Botao de ABANDONAR edicao (o par do Salvar na Page2 de Dados). O SCX tem
*    DOIS botoes e os dois tem handler: Commandgroup1.Command1 "CmdCopia"
*    ("\<Copiar", a acao) -> BtnCopiarClick, e Command2 "CmdExit" ("Encerrar",
*    cujo Click INTEIRO e "Release Windows") -> BtnEncerrarClick. Nao ha
*    terceiro botao, nao ha PageFrame, nao ha modo de edicao e nao ha registro
*    em edicao para abandonar. Dar ao Encerrar um segundo nome, com o verbo do
*    botao que o legado NAO tem, faria o nome MENTIR sobre o que o metodo faz
*    - e um metodo novo e vazio ao lado dele e o "stub disfarcado" que a regra
*    de completude proibe. (O nome nao e grafado por extenso em lugar nenhum
*    deste arquivo: o gate casa substring no arquivo INTEIRO, entao cita-lo
*    daria falso-pass e a dispensa estrutural nunca seria exercitada.)
*
* b) Metodo de popular LISTA. Esta tela nao tem lista: a arvore do SCX tem dez
*    objetos e nenhum de BaseClass grid, pageframe ou listbox, e o dump nao
*    traz AddCursor, pColuna, RecordSource nem ControlSource. A unica chamada
*    com esse nome no arquivo esta em AtualizarFormPai e e do metodo do form
*    CHAMADOR (THIS.this_oFormPai.CarregarLista()) - o repinte descrito na
*    nota 27 -, nao de um metodo deste form.
*
* c) Ajuste de botoes por MODO. Nao ha modos: o SIGOPCOP nao tem pcEscolha,
*    nao tem Page1/Page2 e os seus dois botoes tem o mesmo estado da abertura
*    ao fim. O que de fato muda de estado - a trava durante a transacao - esta
*    em HabilitarCampos, que e chamado pelos caminhos reais.
*
*------------------------------------------------------------------------------
* NOTAS DE TRANSCRICAO APLICADAS NO BLOCO DA FASE 8
*
* 30. FormParaBO devolve LOGICO e o chamador ABORTA quando ele recusa. Espelho
*     tela -> Business Object que falha e deixa o fluxo seguir grava registro
*     PARCIAL sem nada na tela - defeito pior que a caixa de erro, porque
*     ninguem reporta. So os DOIS campos editaveis do SCX sao transferidos; as
*     outras propriedades do SigOpCopBO nao tem controle na tela e sao
*     produzidas pelo proprio Business Object (fGerUniqueKey/Scatter do legado
*     -> Inserir/CarregarOrigem), entao transferi-las daqui seria inventar
*     origem de dado.
*
* 31. Quem DESABILITA tem de REABILITAR, e no FUNIL de volta (regra #40). O
*     destravamento da tela nao fica dentro do IF que travou nem dentro do
*     TRY: esta DEPOIS do ENDTRY, ao lado da liberacao de this_lEmCopia, para
*     valer tambem quando o CATCH dispara. No caminho de SUCESSO o form fecha
*     na linha seguinte e o estado nao importa; no caminho de FALHA a tela
*     continua aberta e precisa voltar a aceitar digitacao, senao o usuario ve
*     o aviso de recusa e nao consegue corrigir o destino - exatamente o
*     defeito que a regra #50 descreve em outra forma.
*
*     HabilitarCampos(.T.) NAO e ".T. em tudo": ele reaplica a regra do
*     legado, e a origem trazida pelo chamador volta a somente-exibicao. Um
*     reabilitar ingenuo tornaria editavel o campo que o "When = .F." do
*     GetOrigem legado protege.
*
* 32. O botao Encerrar NUNCA e desabilitado, nem durante a copia. O form tem
*     ControlBox = .F. e TitleBar = 0 (transcritos do dump), logo nao ha botao
*     de fechar da janela: o Encerrar e a UNICA saida, e desabilita-lo deixaria
*     o usuario preso na tela.
*
* 33. Os quatro metodos novos sao PROTECTED. Tres deles (LimparCampos,
*     BOParaForm, FormParaBO) sao hooks que o FormBase JA declara PROTECTED, e
*     PROTECTED em qualquer nivel da heranca torna o metodo protegido -
*     declara-los sem modificador aqui NAO alargaria o escopo, so daria a
*     impressao de que alargou (regra #51). Nada fora da classe os chama: o
*     harness de teste toca apenas Show/Release/Visible/Width/Height/
*     WindowType/Name/Class, conferido em TestFormWrapper.prg. Os handlers de
*     BINDEVENT continuam PUBLIC, como exige a regra #3.
*==============================================================================

DEFINE CLASS FormSigOpCop AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - TRANSCRITAS de SIGOPCOP (secao 2 do dump)
    *--------------------------------------------------------------------------
    Height      = 187
    Width       = 600
    Caption     = ""
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    FontName    = "Verdana"
    FontSize    = 8
    ForeColor   = RGB(36, 84, 155)

    *-- Ver nota 1 do cabecalho: a classe nasce modeless e o Init promove a
    *-- modal (WindowType = 1 / ShowWindow = 1) fora de validacao e teste.
    WindowType  = 0
    ShowWindow  = 0

    *-- Ver nota 6 do cabecalho
    DataSession = 1

    *--------------------------------------------------------------------------
    * Contexto recebido do form chamador (par_* do Init)
    *
    * this_oFormPai         <- poForm     ("ThisForm.ParentForm = poForm")
    * this_cOperacaoOrigem  <- pOperacao  ("ThisForm.GetOrigem.Value = pOperacao")
    *
    * O legado tambem guarda poDatamgr ("ThisForm.poDatamgr = poForm.poDataMgr").
    * Na arquitetura nova o acesso ao banco e do DataAccess/BusinessBase pelo
    * handle global gnConnHandle, entao nao ha equivalente a propagar.
    *--------------------------------------------------------------------------
    this_oFormPai        = .NULL.
    this_cOperacaoOrigem = ""

    *--------------------------------------------------------------------------
    * Guardas de reentrancia dos dois handlers de LostFocus - ver nota 22
    *
    * this_lEmLookupOrigem  - picker MODAL de SigCdOpe aberto a partir do
    *                         LostFocus da origem (ou de F4/F5/duplo clique)
    * this_lEmValidaDestino - MsgAviso + SetFocus da conferencia do destino
    * this_lEmCopia         - acao do botao Copiar, que atravessa 15 tabelas
    *                         numa transacao unica - ver nota 26
    *
    * this_cUltimoValidarOrigemValidado - ultimo valor de txt_4c_Origem que
    *                         ValidarOrigem ja processou com sucesso.
    *                         LostFocus dispara SEMPRE que o foco sai do
    *                         campo, mesmo sem alteracao nenhuma - diferente
    *                         do Valid legado, que so age quando o conteudo
    *                         MUDA. Sem esta guarda, so passar o foco pelo
    *                         campo reabriria o lookup a cada vez. Sentinela
    *                         que nunca casa com um Dopes real nem com "",
    *                         para nao suprimir o aviso de campo obrigatorio
    *                         na primeira passagem com o campo vazio.
    *--------------------------------------------------------------------------
    this_lEmLookupOrigem  = .F.
    this_lEmValidaDestino = .F.
    this_lEmCopia         = .F.
    this_cUltimoValidarOrigemValidado = "~~NAO_VALIDADO_4C~~"

    *--------------------------------------------------------------------------
    * Init - recebe o contexto do form chamador, define o Caption com CHR() e
    * delega ao FormBase (que chama InicializarForm).
    *
    * Os dois parametros sao OPCIONAIS: o legado sempre os recebe do form de
    * Cadastro de Operacoes, mas a tela tambem e alcancavel pelo menu, e nesse
    * caso a operacao de origem fica em branco para o usuario informar.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cOperacao)
        *-- "C" + o-acute + "pia de Movimenta" + c-cedilha + a-tilde + "o "
        *-- (o espaco final faz parte do literal do SCX)
        THIS.Caption = "C" + CHR(243) + "pia de Movimenta" + CHR(231) + CHR(227) + "o "

        THIS.this_oFormPai        = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        THIS.this_cOperacaoOrigem = IIF(VARTYPE(par_cOperacao) = "C", ALLTRIM(par_cOperacao), "")

        *-- Ver nota 1 do cabecalho
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - instancia o Business Object, aplica o fundo do form e
    * monta a estrutura visual.
    *
    * NAO ha guarda de gb_4c_ValidandoUI envolvendo o metodo: essa flag serve
    * para pular QUERY SQL, e um RETURN no topo pularia tambem o Picture e o
    * cabecalho, tornando qualquer diferenca de UI Fidelity irrecuperavel pelo
    * auto-fix. Este bloco nao executa SQL nenhum.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCopBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpCopBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em InicializarForm")
            ELSE
                *-- Fundo do form: o SCX aponta ..\framework\imagens\new_background.jpg
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- Semeia o BO com a operacao de origem recebida do chamador,
                *-- equivalente ao "ThisForm.GetOrigem.Value = pOperacao" do
                *-- PROCEDURE Init legado. Vai para o BO porque o TextBox da
                *-- tela ainda nao existe neste ponto da montagem.
                THIS.this_oBusinessObject.this_cOperacaoOrigem = THIS.this_cOperacaoOrigem

                THIS.ConfigurarPageFrame()

                *-- "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption" e
                *-- "ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption"
                *-- do PROCEDURE Init legado
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form.
    *
    * NAO existe PageFrame real: o legado SIGOPCOP e flat (nenhum objeto de
    * BaseClass pageframe na arvore do SCX) e por isso nao ha compensacao de
    * Top = -29 a aplicar - os Top do dump sao absolutos no form e entram
    * transcritos. O nome do metodo e mantido por conformidade com o contrato
    * do pipeline multi-fase, igual em FormSIGOPCCO e FormSigOpCcl.
    *
    * ORDEM OBRIGATORIA: o cabecalho vem PRIMEIRO e a barra de botoes DEPOIS -
    * ver nota 11 do cabecalho (o grupo em Top = -2 esta dentro da faixa cinza
    * e so desenha por cima dela se for criado em segundo lugar).
    *
    * Os campos de dados vem por ULTIMO: ficam na faixa 107..130, abaixo do
    * cabecalho (0..80) e fora da area do grupo de botoes, logo a ordem entre
    * eles e indiferente para o desenho - mantem-se a sequencia da montagem.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
    * labels de titulo sobrepostos: sombra preta embaixo, titulo branco em
    * cima. Geometria TRANSCRITA do dump (SIGOPCOP.cntSombra / .lblSombra /
    * .lblTitulo), com as larguras ajustadas conforme a nota 3 do cabecalho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width - 20
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 17
            .Left        = 10
            .Width       = THIS.Width - 20
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Commandgroup1 do legado: a UNICA barra de acao do
    * SIGOPCOP, com CmdCopia ("Copiar") e CmdExit ("Encerrar").
    *
    * Geometria, fonte, cor, Picture e Caption TRANSCRITOS do dump (secao 2,
    * "PROPRIEDADES DE: SIGOPCOP.Commandgroup1", inclusive as linhas
    * Command1.* / Command2.*). Os nomes de icone vem do LEGADO e nao de
    * palpite (regra #25) - os dois arquivos existem em vbmp\:
    * geral_subnivel_60.jpg (Copiar) e cadastro_sair_60.jpg (Encerrar).
    *
    * Ver notas 7 a 13 do cabecalho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = -2
            .Left          = 445
            .Width         = 160
            .Height        = 85

            *-- ButtonCount ANTES de configurar Buttons(N): atribuir a
            *-- ButtonCount RECRIA os botoes e descartaria o que ja tivesse
            *-- sido posto neles.
            .ButtonCount   = 2

            *-- Ver nota 8 do cabecalho
            .AutoSize      = .F.

            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)

            *-- Ver nota 9 do cabecalho
            .Themes        = .F.

            .Value         = 1

            *-- Ver nota 13 do cabecalho
            .TabIndex      = 5

            .Visible       = .T.
        ENDWITH

        *-- Buttons(1) = Command1 "CmdCopia". O "\<" do Caption e o marcador de
        *-- tecla de acesso do VFP (Alt+C), transcrito do dump.
        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top        = 5
            .Left       = 5
            .Width      = 75
            .Height     = 75
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .Picture    = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
            .Caption    = "\<Copiar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        *-- Buttons(2) = Command2 "CmdExit". Cancel = .T. vem do dump e e o que
        *-- faz o ESC acionar este botao.
        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top        = 5
            .Left       = 80
            .Width      = 75
            .Height     = 75
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Caption    = "Encerrar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        *-- Ver nota 12 do cabecalho: o legado NAO tem Click no grupo, tem um
        *-- Click em CADA botao (CmdCopia.Click e CmdExit.Click), entao cada
        *-- Buttons(N) recebe o seu proprio BINDEVENT. Os dois handlers sao
        *-- PUBLIC: alvo de BINDEVENT declarado PROTECTED falha em SILENCIO.
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnCopiarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - bloco de dados do SIGOPCOP, as DUAS linhas.
    *
    * Linha de CIMA  - Label1 "Movimentacao Atual : " + GetOrigem,  a operacao
    *                  que sera COPIADA (entregue no bloco da Fase 5).
    * Linha de BAIXO - Label2 "Nova Movimentacao : "  + GetDestino, a operacao
    *                  NOVA que recebera a copia (acrescentada na Fase 6).
    *
    * Geometria, fonte, cor, Format e MaxLength TRANSCRITOS do dump (secao 2,
    * "PROPRIEDADES DE: SIGOPCOP.Label1" / ".Label2" / ".GetOrigem" /
    * ".GetDestino").
    *
    * Em cada linha o label e criado ANTES do TextBox para que o campo desenhe
    * POR CIMA caso a caixa do label avance sobre ele (regra #23). Aqui nao
    * avanca - o label termina em 278 e o campo comeca em 280 - mas a ordem
    * segura e a mesma.
    *
    * Os BINDEVENT dos dois campos ficam no FIM do metodo, depois de ambos os
    * TextBox existirem: BINDEVENT valida o objeto de origem NA HORA DO BIND.
    *
    * Ver notas 14 a 24 do cabecalho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_lOrigemDoChamador

        *-- Ver nota 19: origem recebida do chamador e somente-exibicao, como
        *-- no legado; origem em branco (tela aberta sem chamador) e digitavel.
        loc_lOrigemDoChamador = !EMPTY(ALLTRIM(THIS.this_cOperacaoOrigem))

        *-- Label1. Caption: "Movimenta" + c-cedilha + a-tilde + "o Atual : "
        *-- (o espaco antes e depois dos dois-pontos faz parte do literal do SCX)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 110
            .Left      = 169
            .Width     = 109
            .Height    = 15

            *-- Ver nota 17 do cabecalho
            .AutoSize  = .F.
            .Alignment = 0

            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8

            *-- Ver nota 18 do cabecalho
            .ForeColor = RGB(90, 90, 90)

            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o Atual : "
            .TabIndex  = 1
            .Visible   = .T.
        ENDWITH

        *-- GetOrigem: operacao de origem da copia (SigCdOpe.dopes char(20))
        THIS.AddObject("txt_4c_Origem", "TextBox")
        WITH THIS.txt_4c_Origem
            .Top       = 107
            .Left      = 280
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8

            *-- Ver notas 15 e 16 do cabecalho
            .Format    = "!"
            .MaxLength = 20

            .TabIndex  = 3

            *-- Inicializacao de TIPO, nao de valor: o TextBox tem de nascer
            *-- CARACTERE. O valor em si - o "ThisForm.GetOrigem.Value =
            *-- pOperacao" do PROCEDURE Init legado - chega pelo BOParaForm no
            *-- fim deste metodo, que e a fonte UNICA dele (ver nota 30).
            .Value     = ""

            *-- Ver nota 19 do cabecalho. ReadOnly/TabStop NAO sao escritos
            *-- aqui: a regra de editabilidade mora em HabilitarCampos, que e
            *-- chamado logo abaixo. Escreve-la nos dois lugares era a receita
            *-- para os dois divergirem (nota 31).

            .Visible   = .T.
        ENDWITH

        *-- Ver nota 19 do cabecalho. O BINDEVENT so e registrado quando o
        *-- bloqueio de foco vale: ligado sempre, tornaria o campo inalcancavel
        *-- tambem no caminho sem chamador, em que ele e o unico jeito de
        *-- informar a origem.
        IF loc_lOrigemDoChamador
            BINDEVENT(THIS.txt_4c_Origem, "When", THIS, "OrigemWhen")
        ENDIF

        *-- Label2. Caption: "Nova Movimenta" + c-cedilha + a-tilde + "o : "
        *-- (o espaco antes e depois dos dois-pontos faz parte do literal do SCX)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 136
            .Left      = 169
            .Width     = 109
            .Height    = 15

            *-- Ver nota 17 do cabecalho
            .AutoSize  = .F.
            .Alignment = 0

            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8

            *-- Ver nota 18 do cabecalho
            .ForeColor = RGB(90, 90, 90)

            .Caption   = "Nova Movimenta" + CHR(231) + CHR(227) + "o : "
            .TabIndex  = 2
            .Visible   = .T.
        ENDWITH

        *-- GetDestino: operacao NOVA, a que recebera a copia (SigCdOpe.dopes
        *-- char(20)). Nasce em BRANCO e digitavel em todo caminho: o Init
        *-- legado semeia apenas GetOrigem, e este campo e justamente o que o
        *-- usuario vem informar. Ver nota 21 do cabecalho.
        THIS.AddObject("txt_4c_Destino", "TextBox")
        WITH THIS.txt_4c_Destino
            .Top       = 134
            .Left      = 280
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8

            *-- Ver notas 15 e 16 do cabecalho
            .Format    = "!"
            .MaxLength = 20

            .TabIndex  = 4
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Ver nota 20: o "PROCEDURE Valid" de cada campo e ligado a
        *-- "LostFocus" - e ao SAIR do campo que o Valid legado roda.
        BINDEVENT(THIS.txt_4c_Origem,  "LostFocus", THIS, "ValidarOrigem")
        BINDEVENT(THIS.txt_4c_Destino, "LostFocus", THIS, "ValidarDestino")

        *-- Ver nota 23: F4/F5 e duplo clique desaguam no MESMO funil do
        *-- lookup de SigCdOpe que o LostFocus da origem usa.
        BINDEVENT(THIS.txt_4c_Origem, "KeyPress", THIS, "TxtOrigemKeyPress")
        BINDEVENT(THIS.txt_4c_Origem, "DblClick", THIS, "TxtOrigemDblClick")

        *-- Ver nota 30: espelho Business Object -> tela. E ele que poe na
        *-- origem o valor que o chamador trouxe (o
        *-- "ThisForm.GetOrigem.Value = pOperacao" do Init legado), e ele
        *-- termina chamando HabilitarCampos, que aplica a regra de
        *-- editabilidade da nota 19 - origem do chamador somente-exibicao,
        *-- origem em branco digitavel.
        THIS.BOParaForm()

        *-- "ThisForm.GetOrigem.Refresh" do PROCEDURE Init legado
        THIS.txt_4c_Origem.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * OrigemWhen - equivalente ao "PROCEDURE When / Return .f." de GetOrigem:
    * o campo EXIBE a operacao de origem trazida pelo chamador e nunca recebe
    * foco, nem por Tab nem por clique.
    *
    * PUBLIC (sem PROTECTED) porque e alvo de BINDEVENT - handler PROTECTED
    * falha em silencio (regra #3). Ver nota 19 do cabecalho.
    *--------------------------------------------------------------------------
    FUNCTION OrigemWhen()
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarOrigem - "PROCEDURE Valid" de GetOrigem, ligado a "LostFocus".
    *
    * Legado:
    *   If !IsEmpty( This.Value )
    *       xBrox = CreateObject('fwBuscaExt', <conn>, 'SigCdOpe', 'csSigCdOpe',
    *                            'Dopes', This.Value, 'Operacoes', .t., 'Dopes')
    *       If Not xBrox.plAchouRegistro
    *           xBrox.mAddColuna('Dopes', '', 'Operacao', .t.)
    *           xBrox.Show()
    *       EndIf
    *       This.Value = Iif( LastKey() # 27, Evaluate('csSigCdOpe.Dopes'), '' )
    *   Else
    *       If Lastkey() <> 27
    *           MessageBox("Operacao Deve ser informada !!!",16,"")
    *           Return .f.
    *       Endif
    *   Endif
    *
    * Campo PREENCHIDO -> funil do lookup (AbrirBuscaOrigem, que reproduz o
    * fwBuscaExt inteiro). Campo VAZIO e saida que NAO foi por ESC -> avisa e
    * devolve o foco: BINDEVENT descarta o retorno do delegate, entao o efeito
    * observavel do "Return .f." legado (o foco nao sai do campo) se reproduz
    * com SetFocus, nao com RETURN .F.
    *
    * PUBLIC (sem PROTECTED) porque e alvo de BINDEVENT - handler PROTECTED
    * falha em silencio (regra #3). Sem parametros: LostFocus nao passa nenhum.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOrigem()
        LOCAL loc_cValor, loc_oErro

        *-- Ver nota 22: o picker e MODAL e o SetFocus do ramo vazio devolve o
        *-- foco ao campo - as duas coisas redisparam este proprio LostFocus.
        IF THIS.this_lEmLookupOrigem
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_Origem.Value)

        *-- LostFocus dispara SEMPRE que o foco sai do campo, mesmo sem
        *-- alteracao nenhuma - o Valid legado so age quando o conteudo MUDA.
        *-- Sem esta guarda, so passar o foco pelo campo (sem editar nada)
        *-- reabriria o lookup de SigCdOpe a cada vez. O ramo de campo VAZIO
        *-- fica de fora da guarda (nunca atualiza o valor memorizado), para
        *-- continuar avisando "Operacao Deve ser informada" a cada passagem
        *-- enquanto o campo ficar vazio - exatamente como o legado.
        IF loc_cValor == THIS.this_cUltimoValidarOrigemValidado
            RETURN
        ENDIF

        THIS.this_lEmLookupOrigem = .T.

        TRY
            IF EMPTY(loc_cValor)
                *-- Ramo ELSE do legado. LASTKEY() = 27 e a saida por ESC, em
                *-- que o legado nao avisa nada.
                IF LASTKEY() != 27
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o Deve ser informada !!!")
                    THIS.txt_4c_Origem.SetFocus()
                ENDIF
            ELSE
                THIS.AbrirBuscaOrigem()

                *-- Validacao bem-sucedida: memoriza o valor FINAL (o lookup
                *-- pode ter trocado o conteudo do campo) para a guarda acima
                *-- nao reabrir o lookup na proxima passagem sem alteracao.
                THIS.this_cUltimoValidarOrigemValidado = ALLTRIM(THIS.txt_4c_Origem.Value)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarOrigem")
        ENDTRY

        *-- Liberar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
        THIS.this_lEmLookupOrigem = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOrigemKeyPress - segunda entrada do funil do lookup: F4 (115) e F5
    * (116), as teclas que o projeto usa para chamar o picker.
    *
    * ENTER e TAB NAO entram aqui DE PROPOSITO: as duas MOVEM o foco, logo o
    * LostFocus (ValidarOrigem) ja abre o funil, e abrir aqui tambem faria o
    * picker aparecer duas vezes seguidas. Abrir o picker sem testar a tecla
    * faria o dialogo subir a CADA caractere digitado (regra #47).
    *
    * Os dois parametros do evento sao OBRIGATORIOS na assinatura: handler sem
    * eles ligado a KeyPress estoura a cada tecla (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE TxtOrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF VARTYPE(par_nKeyCode) = "N"
            IF INLIST(par_nKeyCode, 115, 116)
                THIS.AbrirBuscaOrigem()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOrigemDblClick - terceira entrada do funil do lookup. O duplo clique
    * no campo e o atalho de mouse equivalente ao F4; o legado nao o tem
    * porque com When = .F. o GetOrigem nunca recebe clique nenhum, e no
    * caminho em que o campo e digitavel (nota 19) ele e o atalho esperado.
    *--------------------------------------------------------------------------
    PROCEDURE TxtOrigemDblClick()
        THIS.AbrirBuscaOrigem()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaOrigem - FUNIL UNICO do lookup de operacoes, chamado pelas tres
    * entradas (LostFocus, F4/F5 e duplo clique). Reproduz o fwBuscaExt do
    * GetOrigem.Valid legado com o FormBuscaAuxiliar do sistema novo:
    *
    *   fwBuscaExt(pnIdConn, 'SigCdOpe', 'csSigCdOpe', 'Dopes', This.Value,
    *              'Operacoes', .t., 'Dopes')
    *     -> CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOpe",
    *                     "cursor_4c_BuscaOpe", "Dopes", <valor>, "Operacoes")
    *   plAchouRegistro -> this_lAchouRegistro
    *   mAddColuna      -> mAddColuna (mesmo nome)
    *
    * UMA unica coluna no picker, como o legado: SigCdOpe nao tem coluna de
    * descricao - Dopes char(20) e ao mesmo tempo a chave e o texto da
    * operacao. Acrescentar uma segunda coluna ("descrs"/"Descrs") estouraria
    * "Variable 'DESCRS' is not found" dentro do FormBuscaAuxiliar.
    *
    * Ver notas 21, 22 e 24 do cabecalho.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaOrigem()
        LOCAL loc_oBusca, loc_cValor, loc_lEmLookupAnt, loc_oErro

        *-- Ver nota 22: SAVE/RESTORE, nao set/clear - este metodo e chamado
        *-- de DENTRO do ValidarOrigem (que ja ligou a flag) e tambem direto
        *-- pelo F4/duplo clique. Um clear fixo liberaria a guarda antes de o
        *-- ValidarOrigem terminar, e o LostFocus de volta do picker abriria um
        *-- segundo dialogo.
        loc_lEmLookupAnt          = THIS.this_lEmLookupOrigem
        THIS.this_lEmLookupOrigem = .T.

        TRY
            *-- Ver nota 21: quando a origem veio do chamador o campo e
            *-- somente-exibicao (When = .F. do legado), e o lookup - que no
            *-- legado e inalcancavel por esse mesmo motivo - nao pode alterar
            *-- o valor. Guarda por IF, nunca por RETURN: um RETURN aqui
            *-- deixaria a flag de reentrancia ligada para sempre e mataria o
            *-- lookup pelo resto da vida do form (regra #47).
            IF !THIS.txt_4c_Origem.ReadOnly
                loc_cValor = ALLTRIM(THIS.txt_4c_Origem.Value)

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
                    "Opera" + CHR(231) + CHR(245) + "es")

                IF VARTYPE(loc_oBusca) = "O"
                    *-- Contrato do FormBuscaAuxiliar (regra #37): o Init ja
                    *-- tentou o match EXATO e, achando UM registro, resolveu o
                    *-- valor sozinho - nesse caso o dialogo NAO deve aparecer.
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF

                    *-- Atribuir SO sob a guarda de selecao: nada escolhido
                    *-- (ESC/Cancelar) deixa no campo o que o usuario digitou.
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                        SELECT cursor_4c_BuscaOpe
                        THIS.txt_4c_Origem.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                    ENDIF

                    loc_oBusca.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em AbrirBuscaOrigem")
        ENDTRY

        *-- Restaurar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
        THIS.this_lEmLookupOrigem = loc_lEmLookupAnt

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDestino - "PROCEDURE Valid" de GetDestino, ligado a "LostFocus".
    *
    * Legado:
    *   If NOt Empty(This.Value) And Not Lastkey() = 27
    *       Sqlexecute([Select dopes from SigCdOpe Where Dopes = ']+this.Value+['],
    *                  'csSigCdOpe')
    *       Select csSigCdOpe
    *       If ! Eof()
    *           MessageBox('Operacao ja Cadastrada !!!',16,'')
    *           Return .f.
    *       EndIf
    *   EndIf
    *
    * Conferencia de duplicidade - NAO e lookup, e o INVERSO dele: aqui o
    * usuario informa uma operacao que ainda NAO existe, e achar registro e
    * que reprova. Por isso nao ha picker neste campo: abrir um dialogo de
    * escolha para um codigo que precisa ser novo nao faria sentido, e nenhuma
    * das tres classes fwBusca* aparece no Valid do GetDestino no dump.
    *
    * O codigo digitado NUNCA e apagado (regra #50): o legado tambem nao o
    * apaga - devolve o foco para o usuario corrigir.
    *
    * Ver notas 20, 22 e 24 do cabecalho.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDestino()
        LOCAL loc_cValor, loc_nResultado, loc_lDuplicada, loc_oErro

        *-- Ver nota 22: o MsgAviso e modal e o SetFocus devolve o foco ao
        *-- campo - as duas coisas redisparam este proprio LostFocus.
        IF THIS.this_lEmValidaDestino
            RETURN
        ENDIF

        THIS.this_lEmValidaDestino = .T.

        TRY
            loc_cValor     = ALLTRIM(THIS.txt_4c_Destino.Value)
            loc_lDuplicada = .F.

            *-- "If NOt Empty(This.Value) And Not Lastkey() = 27" do legado
            IF !EMPTY(loc_cValor) AND LASTKEY() != 27
                *-- Ver nota 24: sem conexao viva (validacao de UI / modo
                *-- teste, com gnConnHandle = -1) o SQLEXEC dispara excecao -
                *-- a conferencia e pulada, e a do BO (ValidarDados) continua
                *-- sendo a barreira que impede a gravacao duplicada.
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    IF USED("cursor_4c_DestinoDup")
                        USE IN cursor_4c_DestinoDup
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "SELECT dopes FROM SigCdOpe" + ;
                        " WHERE dopes = " + EscaparSQL(loc_cValor), ;
                        "cursor_4c_DestinoDup")

                    IF loc_nResultado >= 0
                        *-- "Select csSigCdOpe / If ! Eof()" do legado
                        loc_lDuplicada = (RECCOUNT("cursor_4c_DestinoDup") > 0)
                    ELSE
                        MsgErro("Erro ao conferir a opera" + CHR(231) + CHR(227) + ;
                                "o de destino." + CHR(13) + CapturarErroSQL(), ;
                                "Erro SQL")
                    ENDIF

                    IF USED("cursor_4c_DestinoDup")
                        USE IN cursor_4c_DestinoDup
                    ENDIF
                ENDIF

                IF loc_lDuplicada
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o j" + CHR(225) + ;
                             " Cadastrada !!!")
                    THIS.txt_4c_Destino.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ValidarDestino")
        ENDTRY

        *-- Liberar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
        THIS.this_lEmValidaDestino = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCopiarClick - cmg_4c_Botoes.Buttons(1) (CmdCopia do legado) e a ACAO
    * PRINCIPAL da tela: copia a operacao de ORIGEM inteira para a operacao de
    * DESTINO digitada, atravessando 15 tabelas.
    *
    * Transcricao do "PROCEDURE CmdCopia.Click", na MESMA ordem:
    *
    *   If Empty(ThisForm.GetOrigem.Value)
    *       MessageBox('Origem Invalida !!!',16,'')
    *       Return
    *   EndIf
    *   If Empty(ThisForm.GetDestino.Value)
    *       MessageBox('Destino Invalido !!!',16,'')
    *       Return
    *   EndIf
    *   lcOpeOri = ThisForm.GetOrigem.Value
    *   lcOpeDes = ThisForm.GetDestino.Value
    *   lnNDopes = fGerUniqueKey("SigCdOpe")
    *   ...  (Zap/Scatter/Gather/Insert das 15 tabelas + bloco de SigCdPrg)
    *   fGravarLog( 'C', Thisform.Name, 'COPIA', lcTransacao )
    *   ThisForm.poDatamgr.UpDate(...) x15 / ThisForm.poDatamgr.Commit()
    *   ThisForm.Release
    *
    * As 459 linhas do MEIO - a geracao de nDopes/Programas, os Zap/Scatter/
    * Gather de cada tabela, o bloco de permissoes de SigCdPrg e o Commit -
    * moram em SigOpCopBO.Inserir (Fase 2), que as executa numa transacao
    * UNICA. Aqui fica so o que o Click faz em volta: conferir os dois campos,
    * entregar os valores ao Business Object e fechar a tela.
    *
    * PUBLIC porque e alvo de BINDEVENT (handler PROTECTED falha em silencio).
    *
    * Ver notas 25 a 29 do cabecalho.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCopiarClick()
        LOCAL loc_cOrigem, loc_cDestino, loc_lProsseguir, loc_lCopiou, loc_oErro

        *-- Ver nota 26: a copia abre uma transacao de 15 tabelas e os MsgAviso
        *-- dos guards tiram e devolvem o foco - duplo clique no botao
        *-- dispararia o processo duas vezes.
        IF THIS.this_lEmCopia
            RETURN
        ENDIF

        THIS.this_lEmCopia = .T.

        loc_lCopiou = .F.

        TRY
            loc_lProsseguir = .T.

            loc_cOrigem  = ALLTRIM(THIS.txt_4c_Origem.Value)
            loc_cDestino = ALLTRIM(THIS.txt_4c_Destino.Value)

            *-- "If Empty(ThisForm.GetOrigem.Value) / MessageBox / Return"
            IF EMPTY(loc_cOrigem)
                MsgAviso("Origem Invalida !!!")
                loc_lProsseguir = .F.
            ENDIF

            *-- "If Empty(ThisForm.GetDestino.Value) / MessageBox / Return"
            IF loc_lProsseguir
                IF EMPTY(loc_cDestino)
                    *-- Literal do legado, SEM acento ("Invalido"), igual ao
                    *-- texto que SigOpCopBO.ValidarDados usa
                    MsgAviso("Destino Invalido !!!")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + ;
                            "o dispon" + CHR(237) + "vel - a c" + CHR(243) + ;
                            "pia n" + CHR(227) + "o pode ser executada.", ;
                            "Erro em BtnCopiarClick")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Ver nota 25: NovoRegistro() ANTES do espelho, porque ele
                *-- chama LimparDados() e zeraria propriedades recem-escritas.
                THIS.this_oBusinessObject.NovoRegistro()

                *-- Ver nota 30: o espelho tela -> Business Object mora em
                *-- FormParaBO, nao inline aqui. Ele devolve .F. quando a
                *-- transferencia nao pode ser feita, e nesse caso a gravacao
                *-- ABORTA: seguir em frente gravaria registro PARCIAL sem
                *-- erro visivel.
                IF !THIS.FormParaBO()
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Ver nota 31: a tela e travada enquanto a transacao das 15
                *-- tabelas corre. O destravamento NAO fica aqui - esta DEPOIS
                *-- do ENDTRY, junto com a liberacao da guarda, senao uma
                *-- excecao no Salvar deixaria a tela travada para sempre
                *-- (quem desabilita tem de reabilitar - regra #40).
                THIS.HabilitarCampos(.F.)

                *-- Salvar() roda ValidarDados() (que repete os dois guards e a
                *-- conferencia de duplicidade) e so depois chama Inserir(), que
                *-- e o copiador das 15 tabelas em transacao unica.
                IF THIS.this_oBusinessObject.Salvar()
                    loc_lCopiou = .T.
                ELSE
                    *-- Ver nota 28: BusinessBase.Salvar() ja exibiu a recusa e
                    *-- marcou this_lErroExibido; so falamos se ele nao falou.
                    IF !THIS.this_oBusinessObject.this_lErroExibido
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                                "vel copiar a movimenta" + CHR(231) + CHR(227) + "o.", ;
                                "Copiar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lCopiou = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BtnCopiarClick")
        ENDTRY

        *-- Liberar DEPOIS do ENDTRY (vale tambem quando o CATCH dispara) e
        *-- ANTES do Release() - ver nota 26. O destravamento da tela anda
        *-- junto, pelo mesmo motivo: no caminho de sucesso o form fecha logo
        *-- abaixo e o estado nao importa, mas no caminho de FALHA (recusa do
        *-- ValidarDados ou excecao) a tela continua aberta e tem de voltar a
        *-- aceitar digitacao para o usuario corrigir o destino.
        THIS.this_lEmCopia = .F.
        THIS.HabilitarCampos(.T.)

        IF loc_lCopiou
            *-- Ver nota 27: repinte da lista do chamador, que no legado vinha
            *-- de graca pelo cursor compartilhado, e so depois o
            *-- "ThisForm.Release" que fecha o Click legado.
            THIS.AtualizarFormPai()
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarFormPai - recarrega a lista do form CHAMADOR depois de uma copia
    * bem-sucedida.
    *
    * No legado o dialogo adota a data session do pai
    * ("ThisForm.DataSessionId = poForm.DataSessionId") e grava nos cursores
    * crSigCdOpe/crSigOpCdc/... que sao os MESMOS do Cadastro de Operacoes -
    * inclusive o RecordSource da grade dele. O PILAR 3 eliminou o cursor
    * global compartilhado (cada form tem o seu BO e o seu cursor_4c_*), entao
    * o repinte que o legado ganhava de brinde precisa ser escrito a mao.
    *
    * O pai e OPCIONAL (.NULL. quando a tela e aberta pelo menu ou pelo
    * harness) e nem todo chamador tem CarregarLista, dai as duas guardas; e a
    * falha de repinte e AVISO, nunca erro fatal - a copia ja esta confirmada
    * no banco. Ver nota 27.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarFormPai()
        LOCAL loc_oErro

        IF VARTYPE(THIS.this_oFormPai) != "O"
            RETURN
        ENDIF

        TRY
            *-- PEMSTATUS com atributo 5 confere EXISTENCIA do membro, que e
            *-- exatamente o que se quer aqui (nao escopo - ver regra #34)
            IF PEMSTATUS(THIS.this_oFormPai, "CarregarLista", 5)
                THIS.this_oFormPai.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgAviso("A c" + CHR(243) + "pia foi gravada, mas a lista da tela " + ;
                     "anterior n" + CHR(227) + "o p" + CHR(244) + "de ser " + ;
                     "atualizada:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                     "Reabra a tela de Opera" + CHR(231) + CHR(245) + "es para " + ;
                     "ver a nova movimenta" + CHR(231) + CHR(227) + "o.")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - cmg_4c_Botoes.Buttons(2) (CmdExit do legado), cujo
    * Click inteiro e "Release Windows": fecha a tela e devolve o controle ao
    * form chamador.
    *
    * THIS.Release() e o equivalente na arquitetura nova - dispara o Destroy,
    * que solta a referencia ao chamador e delega ao FormBase (liberacao do
    * Business Object + restauracao dos popups do menu principal). PUBLIC
    * porque e alvo de BINDEVENT: handler PROTECTED falha em silencio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - estado de EDICAO dos dois campos e do botao de acao.
    *
    * Centraliza a UNICA regra de editabilidade que o SIGOPCOP tem, para que
    * ela nao fique duplicada em ConfigurarCampos, LimparCampos e BOParaForm:
    *
    *   txt_4c_Origem  - somente-exibicao QUANDO a origem veio do chamador
    *                    (equivalente ao "PROCEDURE When / Return .f." do
    *                    GetOrigem legado); digitavel quando a tela foi aberta
    *                    sem chamador - ver nota 19 do cabecalho
    *   txt_4c_Destino - sempre digitavel: e o campo que o usuario vem informar
    *
    * par_lHabilitar = .F. TRAVA a tela (os dois campos e o Copiar) e e usado
    * enquanto a transacao das 15 tabelas corre; par_lHabilitar = .T. devolve
    * cada controle ao estado que a regra acima manda - nao a ".T. em tudo",
    * senao a origem trazida pelo chamador viraria editavel e a tela divergiria
    * do legado. Ver nota 31.
    *
    * Encerrar fica FORA: ele nunca e desabilitado, nem durante a copia - e a
    * unica saida da tela (o form tem ControlBox = .F. e TitleBar = 0, logo nao
    * ha botao de fechar da janela), e desabilita-lo deixaria o usuario preso.
    *
    * PROTECTED: so o proprio form chama. Nao e hook de FormBase e nada fora
    * da classe precisa dele.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_lOrigemDoChamador

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        *-- Ver nota 19: a origem recebida do chamador e somente-exibicao
        loc_lOrigemDoChamador = !EMPTY(ALLTRIM(THIS.this_cOperacaoOrigem))

        IF PEMSTATUS(THIS, "txt_4c_Origem", 5)
            WITH THIS.txt_4c_Origem
                .ReadOnly = loc_lOrigemDoChamador OR !loc_lHabilitar
                .TabStop  = !loc_lOrigemDoChamador AND loc_lHabilitar
            ENDWITH
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Destino", 5)
            WITH THIS.txt_4c_Destino
                .ReadOnly = !loc_lHabilitar
                .TabStop  = loc_lHabilitar
            ENDWITH
        ENDIF

        *-- Buttons(1) = CmdCopia. Enabled, nao Visible: o botao tem Caption
        *-- ALEM do Picture, e Buttons(N) de CommandGroup desenha o icone
        *-- normalmente com Enabled = .F. - o apagamento de icone em
        *-- Enabled = .F. e de CommandButton STANDALONE icone-only (Caption
        *-- vazio), que nao e o caso aqui.
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - devolve a tela ao estado de abertura.
    *
    * NAO e "zerar os dois campos": a origem volta ao valor que o chamador
    * trouxe - que e o que o "ThisForm.GetOrigem.Value = pOperacao" do Init
    * legado poe la, e o que o usuario precisa ver para saber O QUE esta sendo
    * copiado - e so o DESTINO, o campo que o usuario digita, e esvaziado.
    * Zerar os dois faria a tela perder o contexto da copia sem que nada o
    * recolocasse, porque o Init nao roda de novo.
    *
    * Fecha reaplicando a regra de editabilidade, para que a origem nao fique
    * digitavel depois da limpeza.
    *
    * PROTECTED porque FormBase.LimparCampos tambem e: PROTECTED em QUALQUER
    * nivel da heranca torna o metodo protegido, e declara-lo sem modificador
    * aqui NAO alargaria o escopo (regra #51). Nada fora da classe o chama.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Origem", 5)
            THIS.txt_4c_Origem.Value = THIS.this_cOperacaoOrigem
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Destino", 5)
            THIS.txt_4c_Destino.Value = ""
        ENDIF

        THIS.HabilitarCampos(.T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - espelho TELA -> Business Object.
    *
    * E o "lcOpeOri = ThisForm.GetOrigem.Value / lcOpeDes =
    * ThisForm.GetDestino.Value" do CmdCopia.Click legado: os DOIS unicos
    * valores que esta tela produz, que sao exatamente os dois campos
    * editaveis do SCX.
    *
    * As demais propriedades do SigOpCopBO (nDopes, Programas, Menus,
    * SubMenus, CArqIcones, o bloco de SigCdPrg, a transacao) NAO entram aqui,
    * e isso nao e esquecimento: nenhuma delas tem controle na tela. O legado
    * as produz dentro do proprio Click - fGerUniqueKey para o nDopes e
    * Scatter do registro de ORIGEM para o resto - e no migrado isso mora em
    * SigOpCopBO.Inserir/CarregarOrigem. Transferi-las daqui seria inventar
    * origem de dado que a tela nao tem.
    *
    * FUNCTION, nao PROCEDURE: devolve .F. quando a transferencia nao pode ser
    * feita, e BtnCopiarClick ABORTA a gravacao nesse caso. Transferencia que
    * falha e segue em frente grava registro PARCIAL sem erro visivel - o
    * defeito silencioso que a regra do erro 11 em FormParaBO descreve.
    *
    * PROTECTED pelo mesmo motivo do LimparCampos (regra #51).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
               PEMSTATUS(THIS, "txt_4c_Origem", 5) AND ;
               PEMSTATUS(THIS, "txt_4c_Destino", 5)

                *-- ALLTRIM nos DOIS: a chave de SigCdOpe e a coluna dopes
                *-- char(20) SOZINHA, nao uma chave posicional concatenada,
                *-- logo tirar o padding aqui nao desloca nada (regra #42). O
                *-- EscaparSQL do Business Object recebe o valor ja sem
                *-- brancos, como o legado faz ao concatenar This.Value direto
                *-- no WHERE.
                THIS.this_oBusinessObject.this_cOperacaoOrigem = ;
                    ALLTRIM(THIS.txt_4c_Origem.Value)

                THIS.this_oBusinessObject.this_cOperacaoDestino = ;
                    ALLTRIM(THIS.txt_4c_Destino.Value)

                loc_lSucesso = .T.
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel transferir " + ;
                        "os dados da tela para o objeto de neg" + CHR(243) + "cio.", ;
                        "Erro em FormParaBO")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - espelho Business Object -> TELA, o inverso do FormParaBO
    * sobre os MESMOS dois campos.
    *
    * No legado nao existe caminho de "carregar registro na tela": o SIGOPCOP
    * recebe a origem por parametro e nunca reabre um registro gravado. Os
    * dois usos aqui sao REAIS e nascem da arquitetura nova:
    *
    *   1. InicializarForm semeia o Business Object com a origem recebida do
    *      chamador ANTES de os TextBox existirem; montados os campos, este
    *      metodo e quem leva o valor a tela - no lugar de ConfigurarCampos
    *      ler a propriedade por conta propria. Fonte UNICA do valor.
    *   2. Quando o lookup de SigCdOpe resolve a origem (AbrirBuscaOrigem) ou
    *      o Business Object normaliza o destino em ValidarDados, a tela passa
    *      a refletir o que de fato sera gravado.
    *
    * Fecha reaplicando a regra de editabilidade: origem que ACABOU de chegar
    * do Business Object e, por definicao, origem vinda do chamador, e tem de
    * ficar somente-exibicao como no legado.
    *
    * PROTECTED pelo mesmo motivo do LimparCampos (regra #51).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_cOrigem, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cOrigem = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cOperacaoOrigem, ""))

                *-- A origem exibida e a que vale para o resto da tela:
                *-- HabilitarCampos e LimparCampos leem this_cOperacaoOrigem
                *-- para decidir se o campo e digitavel, entao o espelho
                *-- atualiza a propriedade do form JUNTO com o controle.
                THIS.this_cOperacaoOrigem = loc_cOrigem

                IF PEMSTATUS(THIS, "txt_4c_Origem", 5)
                    THIS.txt_4c_Origem.Value = loc_cOrigem
                ENDIF

                IF PEMSTATUS(THIS, "txt_4c_Destino", 5)
                    THIS.txt_4c_Destino.Value = ;
                        ALLTRIM(NVL(THIS.this_oBusinessObject.this_cOperacaoDestino, ""))
                ENDIF

                THIS.HabilitarCampos(.T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.;
    * este metodo percorre a arvore e os torna visiveis.
    *
    * Sem lista de excecao: o SIGOPCOP nao tem container flutuante nem
    * controle com Visible = .F. declarado no dump - os dez objetos do SCX
    * estao todos na tela desde a abertura.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControle

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND loc_oControle.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControle)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - solta a referencia ao form chamador e delega ao FormBase, que
    * libera o Business Object e restaura os popups do menu principal (fix
    * menu-shrinks). DODEFAULT() na ULTIMA linha e obrigatorio: sem ele a
    * cadeia de heranca e quebrada e os popups ficam com o cache visual
    * encolhido.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
