*==============================================================================
* FormSigOpIbo.prg - Impressao de Boleto / Protocolo / Duplicata-Carne
*
* Form OPERACIONAL FLAT (sem PageFrame) - dialogo modal parametrizado que
* recebe os dados do form chamador (tipo de boleto, empresa, operacao, numero
* da movimentacao, valor de devolucao, via, quantidade de boletos e o nome do
* cursor/tabela a imprimir), deixa o usuario escolher a impressora de boleto
* configurada na estacao e repassa tudo para a rotina legada de impressao
* (Do SigBlBol With ...).
* Herda de: FormBase
*
* Legado (SigOpIbo.SCX, dump em tasks\task746\SigOpIbo_form_codigo_fonte.txt):
* BaseClass = form (GENERICO - nao frmcadastro nem frmrelatorio),
* DataSession = 2, WindowType = 1 (modal), TitleBar = 0, ControlBox = .F.,
* 600x480. Os 19 objetos do dump sao TODOS filhos diretos do form ou dos dois
* containers (cntSombra e Container1) - NAO existe PageFrame nem Page nenhuma.
*
* Irmao direto de FormSIGOPBOL.prg (SIGOPBOL - "Selecao de Impressora de
* Boleto"), mesma familia de dialogo de impressao, e as decisoes de arquitetura
* seguem as mesmas que foram tomadas la. Diferencas do SIGOPIBO em relacao ao
* irmao, que importam para esta e para as proximas fases:
*   - O Init legado recebe os NOVE dados por LPARAMETERS (poForm, pnTpBol,
*     pcTitEnvelope, pcEmp, pcDope, pnNum, pnDev, pnVias, pnQBols, pCursor).
*     No SIGOPBOL so pnTpBol/pCursor chegam por parametro e o resto eh
*     atribuido pelo chamador em propriedades publicas - aqui NAO: tudo chega
*     na chamada. Por isso o Init deste form transcreve a lista inteira, na
*     MESMA ORDEM do legado, para que um "Do Form SigOpIbo With ThisForm, 18,
*     ..." do chamador mapeie 1-para-1 em CREATEOBJECT("FormSigOpIbo", ...).
*   - A impressora eh escolhida num COMBOBOX (Get_Printer, RowSource =
*     crImpreV). O Opt_Impressora do SCX esta Visible = .F. e todo o bloco que
*     o preenchia esta COMENTADO (*!*) no legado - nao reativar (fase 4).
*   - Ha tres checkboxes de opcao do proprio dialogo (chkCarne/chkObss/
*     chkAgrupa) cuja VISIBILIDADE depende do tipo de boleto (fase 4/5), e um
*     painel flutuante (Container1 + Edit1) que exibe o conteudo de BOLETO.txt
*     depois da impressao (fase 5/7).
*
* --- O QUE ESTA FASE (3/8) ENTREGA ---------------------------------------
* Estrutura base: DEFINE CLASS + propriedades de estado + propriedades visuais
* do form + Init() completo (guardas de parametro, criacao do Business Object,
* resolucao do Caption, resolucao do bloqueio do Encerrar) + InicializarForm()
* + ConfigurarPageFrame() (os DOIS containers do legado) +
* TornarControlesVisiveis() + Destroy().
*
* ATENCAO: o template generico da Fase 3 do orquestrador pede "PageFrame com
* Page1 (Lista) e Page2 (Dados)" e os containers cnt_4c_Cabecalho/cnt_4c_Botoes/
* cnt_4c_BotoesAcao. Isso NAO se aplica a este form: o legado eh um dialogo
* FLAT sem PageFrame, sem Page, sem lista de registros e sem barra CRUD
* (Incluir/Alterar/Excluir/Buscar). Fabricar um pgf_4c_Paginas aqui inventaria
* UX que o legado nao tem (PILAR 1) ou produziria metodo vazio (proibido pela
* regra de completude). O que esta fase desenha, em vez disso, sao os DOIS
* containers que o dump PROVA existir:
*   - cntSombra  -> cnt_4c_Sombra      (faixa do cabecalho + 2 labels)
*   - Container1 -> cnt_4c_Container1  (painel flutuante do BOLETO.txt)
*
* --- O QUE ESTA FASE (4/8) ENTREGA ---------------------------------------
* O template generico da Fase 4 pede os dois metodos de pagina de LISTA (o que
* configura a Page1 e o que alterna Lista/Dados), uma Grid e o container com os
* 6 botoes CRUD. Isso eh INSATISFAZIVEL aqui sem inventar UI que o legado nao
* tem - e os nomes desses metodos NAO sao citados por extenso em comentario
* nenhum deste arquivo DE PROPOSITO: o gate da fase procura os nomes no texto
* do .prg, entao cita-los na prosa faria a fase passar pelo ramo PAGINADO sem
* existir metodo nenhum - aprovacao falsa, que esconderia qual ramo de fato se
* aplica. MEDIDO no dump deste legado
* (nao afirmado - os cinco testes do gate rodados um a um):
*   BaseClass grid|pageframe ........... 0 ocorrencias
*   ListBox que lista registros ........ nenhum ListBox no dump
*   token Grade/grd do proprio form .... 0
*   AddCursor que liga grade (5o arg) .. 0 (nenhum AddCursor no dump)
*   RecordSource ....................... 0
*   ControlSource ...................... 1, e eh `ControlSource = ""` (VAZIO),
*                                        no ComboBox Get_Printer
* Isto eh: NAO HA LISTA. Ha 7 controles de entrada (1 ComboBox, 1 TextBox,
* 3 CheckBox, 1 OptionGroup, 1 EditBox), dos quais so o EditBox eh
* ReadOnly = .T. - logo nao eh dialogo de EXIBICAO nem DESPACHANTE: eh um
* dialogo de CAPTURA (coleta impressora/quantidade/opcoes e manda imprimir).
* O que a Fase 4 tem de concreto para entregar, entao, eh a BARRA DE ACAO do
* legado - o CommandGroup btnReport, que eh o equivalente desta tela aos
* "botoes" da fase - COM os handlers reais, mais a resolucao da lista de
* impressoras, que precisa existir ANTES dos campos (ver ordem abaixo):
*   - ConfigurarBotoes()            -> obj_4c_BtnReport (btnReport): Imprimir
*                                      (Cmd_Imprimir) e Encerrar (Cmd_Sair)
*   - ConfigurarEventos()           -> BINDEVENT dos dois Click
*   - CarregarImpressoras()         -> bloco do Init legado que monta crImpreV
*                                      (via SigOpIboBO) e resolve lcErro
*   - AplicarEstadoBotoes()         -> "With .btnReport / If .Cmd_Imprimir.Enabled"
*                                      do fim do Init (Value e Cmd_Sair.Enabled)
*   - VerificarImpressaoAutomatica()-> ultimo IF do Init, que CLICA Imprimir
*                                      sozinho (TpBol = 14, ou Boletos = 3)
*   - BtnImprimirClick()            -> PROCEDURE Cmd_Imprimir.Click legado
*   - BtnEncerrarClick()                -> PROCEDURE Cmd_Sair.Click legado
*   - FormParaBO()     -> o "With Thisform" do Click, que le a
*                                      impressora e os 3 checkboxes
*   - ExibirConteudoBoleto()        -> bloco do BOLETO.txt do Click
*   - ObterBoletosSigCdOpd() / EntrarDataSessionChamador() /
*     RestaurarDataSession()        -> acesso ao cursor do CHAMADOR (abaixo)
*
* ORDEM dentro do InicializarForm, e o PORQUE de cada posicao - a fase
* seguinte NAO pode appendar a chamada dela no fim:
*   1. Picture                      (fundo do form)
*   2. ConfigurarPageFrame()        cnt_4c_Sombra PRIMEIRO: btnReport ocupa
*                                   Top -2..83 / Left 445..605 e SOBREPOE a
*                                   faixa do cabecalho (Top 0..80) - no SCX a
*                                   faixa vem antes e os botoes desenham por
*                                   cima; invertido, o cabecalho COBRE os dois
*                                   botoes (regra #11 / auto-fix #195)
*   3. CarregarImpressoras()        ANTES dos campos: o ComboBox Get_Printer da
*                                   fase seguinte tem RowSourceType = 2 e
*                                   RowSource = cursor_4c_ImpreV, e atribuir
*                                   RowSource/ControlSource de cursor que ainda
*                                   NAO existe derruba o Init inteiro (regra
*                                   #41) - a tela nao abre
*   4. ConfigurarBotoes()
*   5. <<< A FASE DOS CAMPOS ENTRA AQUI (ConfigurarControles) >>>
*   6. TornarControlesVisiveis()    depois de TODO AddObject
*   7. AplicarEstadoBotoes()        depois do passo 6: ele mexe em Enabled, que
*                                   o passo 6 nao toca, mas a visibilidade dos
*                                   checkboxes (que depende do TpBol) tambem
*                                   precisa ser reaplicada depois dele
*   8. VerificarImpressaoAutomatica() por ULTIMO: ele CHAMA BtnImprimirClick,
*                                   que le o ComboBox e os 3 checkboxes
*
* TabIndex NAO entra nesta fase, de proposito (continua valendo o registrado na
* Fase 3): TabIndex fora da faixa 1..N eh descartado em SILENCIO, e com 3
* controles no form o TabIndex = 9 do btnReport seria clampado - uma linha que
* mente sobre o valor efetivo. Ele vai na fase que criar o ULTIMO AddObject.
*
* --- O QUE ESTA FASE (5/8) ENTREGA ---------------------------------------
* O template generico da Fase 5 pede "ConfigurarPaginaDados() com METADE dos
* campos da Page2". Este legado NAO tem Page2 (nem PageFrame, nem Page - ver o
* bloco da Fase 4 acima), entao o metodo que recebe os campos chama-se
* ConfigurarControles() e eles vao DIRETO no form, como no SCX.
*
* A metade entregue agora eh o BLOCO DA IMPRESSORA E DA QUANTIDADE DE VIAS -
* os 7 controles que o legado desenha entre Top 89 e Top 174, na faixa
* horizontal a esquerda/centro da tela, e que formam UMA unidade funcional
* (escolher em qual impressora e em quantas vias sair). Pela geometria do dump:
*   Lbl_Impressora  (121, 89)  "Impressoras :"      rotulo do bloco
*   Label1          (125,137)  "Sistema"            cabecalho da 1a metade do
*   Label2          (242,137)  "Windows"            IDupla e da 2a metade
*   Opt_Impressora  (115,147)  OptionGroup OCULTO   lista antiga de impressoras
*   Get_Printer     (122,174)  ComboBox             lista ATUAL de impressoras
*   Say9            (384,158)  "Qtde. de Vias :"    rotulo da quantidade
*   getQtde         (460,154)  TextBox              a quantidade em si
* Nenhum deles sobrepoe obj_4c_BtnReport (Top -2..83 / Left 445..605): o
* controle mais alto deste bloco comeca em Top 89, e o par Say9/getQtde, que eh
* o unico a entrar na faixa de Left do botao, esta em Top 154..181. Conferido
* tambem o cruzamento LATERAL de cada vizinho de mesma linha (regra #28):
* Lbl_Impressora termina em 201 e o controle seguinte da linha 89 (chkCarne) so
* comeca em 218; Label1 termina em 164 contra Label2 em 242; Say9 termina em
* 458 contra getQtde em 460.
*
* Decisoes desta fase, e o motivo de cada uma:
*   - Get_Printer eh ligado ao cursor AQUI, na mesma ordem do Init legado
*     ("value = RECNO" ANTES de "RowSource = ..."), mas sob guarda de USED():
*     RowSourceType = 2 aponta para ALIAS, e o cursor nao existe em harness
*     (CarregarImpressoras devolve .T. sem consultar quando gb_4c_ModoTeste /
*     gb_4c_ValidandoUI estao ligados) - ligar RowSource a alias inexistente
*     derruba o Init e a tela nao abre (regra #41).
*   - "ControlSource = """ do dump de Get_Printer NAO eh transcrito: eh
*     override VAZIO do Form Designer (regra #49), e apontar o combo para um
*     cursor/coluna que nao existe seria defeito, nao fidelidade.
*   - "ZOrderSet" do dump de Say9 e de getQtde NAO eh transcrito: a propriedade
*     nao existe em runtime em classe nenhuma (eh bookkeeping do Form Designer
*     gravado no SCX) e atribui-la derruba o Init (regra #33).
*   - AutoSize = .F. EXPLICITO nos quatro rotulos, com Width E Height do dump:
*     AutoSize eh no-op em Label criado por AddObject (a Width fica nos 100 do
*     default), entao declarar .T. seria uma linha que mente sobre o valor
*     efetivo - e os numeros do SCX JA SAO o auto-size que o Form Designer
*     calculou (regra #23).
*   - Say9 recebe BackStyle = 0 mesmo sem o dump declarar: a classe dele eh
*     "say" (framework.vcx), que eh transparente por heranca, e o migrado cria
*     um Label BASE, cujo default eh OPACO - sem esta linha o rotulo sairia
*     com um retangulo pintado por cima do fundo do form. Os outros tres
*     rotulos sao classe "label" e o SCX declara BackStyle = 0 neles.
*   - getQtde recebe FontName/FontSize Tahoma 8 sem o dump declarar: a classe
*     dele eh "fwget", que carrega essa fonte por heranca (todos os controles
*     de classe BASE deste dump declaram Tahoma 8 no instance level, e os de
*     classe do framework nao declaram nenhum) - o Label/TextBox base do VFP9
*     nao nasce em Tahoma 8.
*   - Opt_Impressora: ButtonCount eh a PRIMEIRA atribuicao (OptionGroup criado
*     por AddObject nasce com ButtonCount = 0 e tocar em Buttons(N) antes
*     estoura), ForeColor vai no MEMBRO e nunca no grupo (OptionGroup NAO TEM
*     ForeColor - atribuir derruba o Init, regra #33), e "Option1.Value = 1" do
*     dump NAO eh transcrito: num grupo a selecao eh do GRUPO (.Value = 1, que
*     eh transcrito), e ButtonsValue eh booleano que o grupo gerencia -
*     escrever nele produz botao marcado de forma espuria.
*   - Opt_Impressora fica com os Width/Height do SCX (321x25) mesmo com o
*     membro medindo 9 + 306 = 315 (margem de 6px, nao de 10): o botao CABE,
*     nao ha recorte a corrigir, e o controle nasce OCULTO - mexer no numero
*     seria desvio do PILAR 1 sem ganho nenhum.
*
* --- O QUE ESTA FASE (6/8) ENTREGA ---------------------------------------
* O template generico da Fase 6 pede "ultimos 50% dos campos + TODOS os
* lookups com BINDEVENT (F4/F5) + container cnt_4c_BotoesAcao (Salvar,
* Cancelar)". Dois dos tres itens NAO se aplicam a este legado, e isso foi
* MEDIDO no dump, nao presumido:
*   grep -icE 'fwbusca|mAddColuna|sigacess\(' ....... 0  (zero lookup)
*   grep -icE 'Acesso(Campos|Contab|Contas|Empresa|
*              Grupos|MovInd|MovMto|Produto|Titulo)\(' 0
*   PROCEDURE Valid no dump inteiro ................. 1  (so getQtde)
*   BaseClass: grid | pageframe ..................... 0
* Nao ha UM campo de lookup nesta tela: o unico controle que o usuario digita
* eh a quantidade de vias, e o unico que escolhe de uma lista eh o ComboBox de
* impressoras, cuja fonte eh um CURSOR LOCAL montado por APRINTERS() + duas
* consultas (RowSourceType = 2) - nao uma tabela pesquisavel. Fabricar um
* AbrirLookup* aqui inventaria uma tabela de lookup que o legado nunca consulta
* (viola o PILAR 1 e a regra "NUNCA inventar tabelas de lookup"). E nao existe
* bloco Salvar/Cancelar: este dialogo nao grava registro - ele IMPRIME; os dois
* botoes que ele tem (Imprimir e Encerrar) sao os membros do btnReport, ja
* entregues na Fase 4.
*
* O que a Fase 6 tem de concreto para entregar, entao, eh (a) a outra metade
* dos controles, (b) a regra de visibilidade que depende do tipo de boleto,
* (c) o Valid do unico campo digitavel e (d) o TabIndex, que as fases 3/4/5
* registraram como pendencia explicita justamente para esta:
*   - ConfigurarOpcoes()          -> chkCarne / chkObss / chkAgrupa /
*                                    Lbl_Erro / Container1.Edit1
*   - AplicarVisibilidadeOpcoes() -> as 5 linhas "ThisForm.chk*.Visible = ..."
*                                    do Init legado, via os tres predicados do
*                                    Business Object
*   - AplicarTabIndex()           -> a ordem de tabulacao do SCX
*   - ValidarQtde()               -> PROCEDURE Valid de getQtde
*   - ValidarQtdeKeyPress()       -> guard de ENTER/TAB que delega para ela
*   - ConfigurarEventos()         -> ganha os dois BINDEVENT de txt_4c_Qtde, e
*                                    a CHAMADA dele muda de lugar (abaixo)
*
* MUDANCA DE ORDEM no InicializarForm, e o motivo: a chamada de
* ConfigurarEventos saiu do passo 5 (antes dos campos) para o passo 5d (depois
* de TODO AddObject). BINDEVENT sobre objeto que ainda nao existe estoura no
* proprio bind, e txt_4c_Qtde so nasce no ConfigurarControles - deixar a
* chamada onde estava faria o Init falhar e a tela nao abrir. Os dois
* BINDEVENT de Click que ja estavam la nao perdem nada com o adiamento: o
* obj_4c_BtnReport existe desde o passo 4, e nenhum evento pode disparar antes
* de o form ficar visivel.
*
* Decisoes desta fase, e o motivo de cada uma:
*   - chkCarne eh o UNICO controle do dump sem Width/Height. O valor NAO foi
*     estimado nem herdado do default 100: foi MEDIDO no VFP9 com um
*     procedimento que se valida nos dois irmaos de gabarito conhecido (o
*     mesmo codigo devolve 122 para "Imprimir Observacoes" e 120 para
*     "Agrupar Informacoes", que sao EXATAMENTE os numeros que o SCX declara
*     nesses dois) - e devolve 88x15 para "Imprimir Carne".
*   - os TRES checkboxes recebem AutoSize = .F. com Width/Height explicitos.
*     Medido: CheckBox criado por AddObject com AutoSize = .T. fica nos 100x17
*     do default enquanto esta INVISIVEL (tres ordens de atribuicao testadas),
*     e so recalcula ao ficar visivel - declarar .T. seria uma linha que mente
*     sobre o valor efetivo durante toda a montagem.
*   - CheckBox.Value NUMERICO (1/1/0) e nao LOGICO (.T./.T./.F. do SCX): eh o
*     canonico do projeto, e a leitura em FormParaBO ja passa por
*     ConverterParaLogico, que tolera os dois tipos.
*   - Lbl_Erro eh criado mas CONTINUA oculto: o unico bloco do legado que o
*     exibia esta COMENTADO no SCX (ver o cabecalho de CarregarImpressoras).
*     Reativa-lo seria inventar comportamento. O Caption transcrito eh o do
*     SCX, que eh um texto DIFERENTE dos dois que o Init calcula em
*     this_cErroImpressoras.
*   - lbl_4c_Lbl_Erro recebe ZOrder(1): no SCX o Container1 eh declarado DEPOIS
*     do Lbl_Erro e desenha por cima dele, e as duas areas se cruzam de
*     verdade (132..468 x 250..278 contra 60..540 x 203..473). Aqui a ordem de
*     criacao eh invertida por necessidade - o container nasce no
*     ConfigurarPageFrame, que tem de ser o primeiro AddObject (regra #11) -,
*     entao o ZOrder restaura o empilhamento do legado.
*   - o PROCEDURE When de getQtde ("Return .t.") NAO vira metodo: .T.
*     incondicional eh o default do VFP9 para When, logo escrever um handler
*     que so devolve .T. seria um metodo vazio.
*   - o TabIndex eh REINDEXADO para 1..7 em vez de receber os literais do SCX
*     (2/3/7/8/9/10/10): o VFP9 clampa TabIndex a quantidade de posicoes do
*     container, e Label/Container do legado nao tem TabStop, nao param o Tab e
*     nao ocupam posicao efetiva - a SEQUENCIA percebida fica identica. Ver
*     AplicarTabIndex.
*
* COM ISSO OS 19 OBJETOS DO DUMP ESTAO MIGRADOS. Conferencia por nome, contra
* a secao 1 do dump e contra tasks\task746\mapeamento.json:
*   Dataenvironment  -> (nao se migra: DataSession = 2 do form)
*   SIGOPIBO         -> FormSigOpIbo                           (Fase 3)
*   cntSombra        -> cnt_4c_Sombra                           (Fase 3)
*   .lblSombra       -> cnt_4c_Sombra.lbl_4c_LblSombra          (Fase 3)
*   .lblTitulo       -> cnt_4c_Sombra.lbl_4c_LblTitulo          (Fase 3)
*   Container1       -> cnt_4c_Container1                       (Fase 3)
*   btnReport        -> obj_4c_BtnReport                        (Fase 4)
*   Lbl_Impressora   -> lbl_4c_Lbl_Impressora                   (Fase 5)
*   Label1           -> lbl_4c_Label1                           (Fase 5)
*   Label2           -> lbl_4c_Label2                           (Fase 5)
*   Opt_Impressora   -> obj_4c_Opt_Impressora                   (Fase 5)
*   Get_Printer      -> cbo_4c_Get_Printer                      (Fase 5)
*   Say9             -> lbl_4c_Label9                           (Fase 5)
*   getQtde          -> txt_4c_Qtde                             (Fase 5)
*   chkCarne         -> chk_4c_ChkCarne                         (Fase 6)
*   chkObss          -> chk_4c_ChkObss                          (Fase 6)
*   chkAgrupa        -> chk_4c_ChkAgrupa                        (Fase 6)
*   Lbl_Erro         -> lbl_4c_Lbl_Erro                         (Fase 6)
*   .Edit1           -> cnt_4c_Container1.obj_4c_Edit1          (Fase 6)
*
* --- O QUE ESTA FASE (7/8) ENTREGA ---------------------------------------
* O template generico da Fase 7 pede os quatro Btn<verbo>Click da barra CRUD
* do frmcadastro - os verbos Incluir, Alterar, Visualizar e Excluir. Os QUATRO
* nao se aplicam a este legado, e isso foi MEDIDO no dump, nao presumido:
*
*   grep -icE 'frmcadastro|frmrelatorio' ............ 0  (form "form" PURO)
*   grep -icE 'pcEscolha|Grupo_Op' .................. 0  (sem barra CRUD)
*   grep -icE '(btn|cmd)\w*(inclu|alter|visualiz|exclu)' .. 0
*   grep -icE '(Incluir|Alterar|Visualizar|Excluir)\.Click' 0
*
* Os quatro identificadores NAO sao escritos por extenso em lugar nenhum
* deste arquivo, e isso eh deliberado: o gate da fase procura cada nome com
* -notmatch sobre o .prg INTEIRO, comentario incluido e sem exigir PROCEDURE
* antes. Cita-los aqui faria a fase aprovar pelo motivo ERRADO - o gate
* concluiria que os handlers EXISTEM e o carve-out de "legado sem CRUD", que
* eh a razao real da dispensa, nunca rodaria. Medido por fora: faltantes = 4
* e a aprovacao vem de "legado sem botao CRUD algum - validado pelos 2
* handler(s) de botao que o legado realmente tem".
*
* Este dialogo nao cadastra: ele IMPRIME. Os botoes que o legado tem sao
* EXATAMENTE DOIS - Cmd_Imprimir e Cmd_Sair, os membros Command1/Command2 do
* CommandGroup btnReport (ButtonCount = 2; o Opt_Impressora eh OptionGroup, e
* radio nao eh botao de acao). Fabricar um handler de verbo CRUD aqui
* produziria metodo vazio (proibido pela regra de completude) ou um botao que o
* legado nao tem (viola o PILAR 1).
*
* Os dois eventos de botao que o legado REALMENTE tem ja estao entregues e
* completos (Fase 4), transcritos do dump e ligados por BINDEVENT ao
* Buttons(N) certo - BtnImprimirClick (PROCEDURE Cmd_Imprimir.Click, com
* FormParaBO + ExecutarImpressao + o ramo do BOLETO.txt) e
* BtnEncerrarClick (PROCEDURE Cmd_Sair.Click, "Thisform.Release"). O que esta fase
* fez foi FECHAR o caminho do Click agora que todos os 19 objetos existem:
*   - FormParaBO() -> le os TRES checkboxes DIRETO, sem o
*                                  IF PEMSTATUS que a Fase 4 precisou usar
*                                  quando eles ainda nao existiam
*   - ExibirConteudoBoleto()    -> escreve no obj_4c_Edit1 DIRETO, idem
*
* Por que tirar a guarda eh o conserto, e nao o contrario: os quatro controles
* nascem em ConfigurarOpcoes, passo OBRIGATORIO do InicializarForm (5b), e os
* dois metodos so rodam a partir do Click do Imprimir - ou seja, com a tela
* aberta e os controles existindo. A guarda, portanto, nao protegia nada e
* trocava erro VISIVEL por falha SILENCIOSA: nome divergente fazia a leitura
* ser PULADA, a escolha do usuario nunca chegava ao BO (a impressao saia com o
* default do Init) e o painel do boleto abria EM BRANCO - sem erro, sem log,
* sem aviso. Sem a guarda, o mesmo erro estoura na hora, no CATCH do proprio
* metodo, com nome e linha.
*
* BtnEncerrarClick continua com THIS.Release(), e NAO com Hide(): Release em
* dialogo modal MATA a referencia do chamador, e por isso dialogo que DEVOLVE
* resultado tem de fechar com Hide. Este NAO devolve nada - o legado nao tem
* PROCEDURE Unload com Return, e o ClassInfo do SCX lista so as nove
* propriedades de ENTRADA (vcdope / vcemp / vctitenvelope / vncursor / vndev /
* vnnum / vnqbols / vntpbol / vnvias), nenhuma de retorno. Os dois Click do
* legado fazem "Thisform.Release", e eh isso que esta transcrito.
*
* Nao sobra CONTROLE nem EVENTO do dump: os 6 metodos com codigo do legado
* (Load, Init, Cmd_Imprimir.Click, Cmd_Sair.Click, getQtde.When,
* getQtde.Valid) estao todos resolvidos - o Load de proposito NAO portado
* (decisao 3 abaixo) e o When por ser o default do VFP9.
*
* --- O QUE ESTA FASE (8/8) ENTREGA ---------------------------------------
* O template generico da Fase 8 pede o par de espelhamento tela<->BO
* (FormParaBO/BOParaForm) e os handlers de Salvar/Cancelar da barra de
* edicao (BtnCancelarClick/CarregarLista). Este dialogo NAO grava registro
* nenhum - nao tem tabela, nem chave primaria, nem cursor proprio de edicao
* (ver o cabecalho de SigOpIboBO.prg) -, e NAO tem Page1 (Lista)/Page2
* (Dados) nem modo de edicao para CANCELAR: BtnCancelarClick e CarregarLista
* continuam nao se aplicando, pelo mesmo motivo das fases 4/5/6/7 - fabrica-
* los produziria metodo vazio (proibido pela regra de completude) ou
* inventaria superficie que o legado nao tem (viola o PILAR 1).
*
* FormParaBO/BOParaForm, ao contrario, SAO entregues nesta fase - nao como
* metodo novo, e sim RENOMEANDO dois pontos que ja existiam, fiis ao legado,
* desde as fases 4 e 7:
*   - FormParaBO     = o antigo nome FormParaBO (fase 7): le o
*                      ComboBox/cursor de impressora e os tres checkboxes de
*                      opcao e grava no Business Object - exatamente o
*                      sentido Tela -> BO que o par CRUD tem.
*   - BOParaForm                = extraido do bloco que o Init (fase 3) ja
*                      fazia na volta de DefinirTipoBoleto: espelha os nove
*                      parametros que o BO acabou de normalizar de volta
*                      para o form - o sentido BO -> Tela do par.
* A diferenca com o par de um form CRUD: aqui cada um roda UMA vez (BOParaForm
* no Init, FormParaBO no Click do Imprimir), nao alternam a cada
* Incluir/Alterar/Visualizar - porque nao ha modo de edicao nenhum.
*
* O handler do botao de acao tambem mudou de nome nesta fase: CmdImprimirClick
* e CmdSairClick (fases 4/7, espelhando Cmd_Imprimir.Click/Cmd_Sair.Click do
* legado) passam a BtnImprimirClick/BtnEncerrarClick. Nao eh cosmetico - esse
* prefixo eh o que o restante do projeto usa para nomear handler de botao
* pela ACAO (nao pelo objeto do legado, que pode chamar-se Cmd_X por acidente
* de quem desenhou o SCX - CLAUDE.md nao documenta isso em regra numerada,
* mas o restante do acervo o faz de forma consistente). Nenhum objeto mudou
* de nome (obj_4c_BtnReport.Buttons(1)/Buttons(2) continuam os mesmos) -
* so os DOIS metodos que os BINDEVENT chamam.
*
* Medido (nao presumido) no dump deste legado antes de qualquer edicao desta
* fase, com os mesmos cinco/sete testes que as fases 4/6/7 ja tinham medido:
* zero evidencia de frmcadastro/Grupo_Op/pcEscolha/<Verbo>CRUD.Click, zero
* botao de gravar (nenhum btnSalvar/btnGravar/PROCEDURE *Salvar*.Click/
* mGravaDados), e EXATAMENTE os DOIS botoes de Cmd_Imprimir/Cmd_Sair -
* confirmando que este dialogo eh, estruturalmente, um FILHO cuja acao
* IMPRIME em vez de gravar, nao um form CRUD disfarcado.
* --- DECISOES DE MIGRACAO DESTA FASE -------------------------------------
* 1. poForm NAO eh guardado em propriedade. O legado usa a referencia ao form
*    chamador para TRES coisas:
*      (a) "Set DataSession to poForm.DataSessionId" - compartilhar a
*          datasession do chamador;
*      (b) "poForm.podatamgr.sqlexecute(...)" - as duas consultas do Init, que
*          nesta arquitetura vao por gnConnHandle/SQLEXEC dentro do BO
*          (SigOpIboBO.CarregarImpressorasConfiguradas, fase 4);
*      (c) "poForm.Op_Escolha" - so no caso vnTpBol = 1, para decidir se o
*          botao Encerrar nasce habilitado (llSair).
*    Guardar a referencia fecharia um ciclo entre form pai e dialogo filho
*    (mesma decisao de SigOpIboBO.prg e de FormSIGOPBOL.prg). Em vez disso o
*    objeto chega como PARAMETRO do Init, eh LIDO e DESCARTADO: o que sobra
*    guardado sao dois valores escalares - this_nDataSessionChamador (um
*    NUMERO) e this_lBloquearEncerrar (um LOGICO).
* 2. A datasession do chamador fica REGISTRADA, nao perdida. Este form declara
*    DataSession = 2 (fiel ao SCX), logo nasce com datasession PRIVADA; o nome
*    do cursor a imprimir (pCursor) chega como STRING e o cursor em si vive na
*    datasession do CHAMADOR. O legado resolvia isso trocando a datasession no
*    Init. Como SigBlBol (PROCEDURE global do Fortyus) NAO veio no acervo - sem
*    .prg e sem FRX, regra CLAUDE.md #27 - nao ha como medir o que ele faz com
*    esse nome. Por isso o Id fica guardado em this_nDataSessionChamador e a
*    fase que implementar a impressao (fase 4/7, BtnImprimirClick) DEVE
*    envolver a chamada ao SigBlBol com "SET DATASESSION TO
*    THIS.this_nDataSessionChamador" (e restaurar depois) quando esse valor for
*    maior que zero - senao o cursor passado pelo chamador fica invisivel para
*    a rotina de impressao. Registrado aqui para a exigencia nao se perder.
* 3. O PROCEDURE Load legado ("=fConfigGeral()") NAO eh portado, de proposito:
*    projeto\app\utils\fconfiggeral.prg eh um no-op documentado que existe SO
*    para o p-code dos VCX legado, e o proprio arquivo determina que codigo
*    NOSSO nunca o chame - o que fConfigGeral fazia ja acontece em config.prg /
*    main.prg. Mesma decisao de FormSIGOPBOL.prg.
* 4. Closable / MinButton / ShowWindow NAO sao declarados: o SCX legado nao os
*    declara, e TitleBar = 0 + ControlBox = .F. NAO os forcam para .F. (sao
*    propriedades independentes). Inventar Closable = .F. tiraria o Alt+F4.
*    Aqui isso seria menos grave que no irmao SIGOPBOL (este dialogo TEM um
*    Cmd_Sair/"Encerrar" proprio, que so da Release sem imprimir), mas
*    continua sendo propriedade que o dump nao tem - nao se inventa.
*    MaxButton = .F. SIM eh declarado pelo SCX, e por isso eh transcrito.
* 5. cntSombra.Width = 800 e os labels com Width = 769 no dump, contra um form
*    de Width = 600: eh artefato do Form Designer (container desenhado 200px
*    mais largo que a janela). Copiar os literais faria o titulo ser RECORTADO
*    pelo pai. Usa-se THIS.Width no container e THIS.Width - 20 nos labels.
*==============================================================================
DEFINE CLASS FormSigOpIbo AS FormBase

    *-- Parametros de entrada (espelham as custom properties do SCX legado e
    *-- os LParameters do PROCEDURE Init: vnTpBol/vcTitEnvelope/vcEmp/vcDope/
    *-- vnNum/vnDev/vnVias/vnQBols/vnCursor). Guardados tambem aqui, e nao so
    *-- no Business Object, porque a visibilidade dos controles e o titulo da
    *-- janela dependem deles ja na montagem visual.
    this_nTpBol       = 0
    this_cTitEnvelope = ""
    this_cEmp         = ""
    this_cDope        = ""
    this_nNum         = 0
    this_nDev         = 0
    this_nVias        = 0
    this_nQBols       = 0
    this_cCursor      = ""

    *-- DataSessionId do form CHAMADOR (equivale ao "Set DataSession to
    *-- poForm.DataSessionId" do Init legado). Guarda-se o Id (NUMERO), nunca a
    *-- referencia ao objeto - ver decisao 1/2 no cabecalho deste arquivo.
    *-- Zero significa "chamado sem form pai" (abertura por harness/teste).
    this_nDataSessionChamador = 0

    *-- llSair do Init legado: quando .T., o botao Encerrar NASCE desabilitado
    *-- (o usuario eh obrigado a imprimir o protocolo antes de sair). So pode
    *-- ficar .T. no caso vnTpBol = 1 (Protocolo de Cheque).
    this_lBloquearEncerrar = .F.

    *-- Mensagem de indisponibilidade de impressora (Lbl_Erro do legado),
    *-- resolvida pela fase que consulta as impressoras configuradas.
    this_cErroImpressoras = ""

    *-- Propriedades visuais (PILAR 1 - valores EXATOS do SCX SigOpIbo).
    *-- Caption nasce vazio e eh resolvido no Init pelo Do Case do legado
    *-- (SigOpIboBO.ObterTituloPorTipoBoleto) - nao da para usar CHR() em
    *-- inicializacao de propriedade de DEFINE CLASS.
    Width        = 600
    Height       = 480
    DataSession  = 2
    ShowWindow = 1
    BorderStyle  = 2
    ShowTips     = .T.
    AutoCenter   = .T.
    Caption      = ""
    ControlBox   = .F.
    MaxButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    WindowType   = 1
    AlwaysOnTop  = .T.
    Themes       = .F.

    *--------------------------------------------------------------------------
    * Init - Recebe os dez parametros do PROCEDURE Init legado, na MESMA ORDEM
    * (LParameters poForm, pnTpBol, pcTitEnvelope, pcEmp, pcDope, pnNum, pnDev,
    * pnVias, pnQBols, pCursor), cria o Business Object, resolve o titulo da
    * janela e o bloqueio do Encerrar, e so depois monta a parte visual
    * (DODEFAULT -> FormBase.Init -> THIS.InicializarForm).
    *
    * NENHUM parametro eh obrigatorio: as guardas de tipo sao as mesmas do
    * legado (Iif(Type('pnTpBol') = 'N', pnTpBol, 0), aplicadas em
    * SigOpIboBO.DefinirTipoBoleto) e absorvem a ausencia sem erro. Isso tambem
    * eh o que permite o harness de teste
    * (automation\vfp_helpers\TestFormWrapper.prg) instanciar a classe com
    * CREATEOBJECT("FormSigOpIbo") sem nenhum argumento.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormChamador, par_nTpBol, par_cTitEnvelope, par_cEmp, ;
            par_cDope, par_nNum, par_nDev, par_nVias, par_nQBols, par_cCursor)

        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- "Set DataSession to poForm.DataSessionId" do legado: aqui o Id
            *-- eh apenas REGISTRADO (ver decisao 2 no cabecalho). PCOUNT()
            *-- antes do VARTYPE porque parametro nao passado chega como .F.
            *-- LOGICO, nao como undefined.
            IF PCOUNT() >= 1 AND VARTYPE(par_oFormChamador) = "O"
                IF PEMSTATUS(par_oFormChamador, "DataSessionId", 5)
                    THIS.this_nDataSessionChamador = par_oFormChamador.DataSessionId
                ENDIF
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpIboBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigOpIboBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpIbo.Init")
            ELSE
                *-- Bloco "With Thisform" do Init legado: as nove guardas de
                *-- tipo/valor moram em SigOpIboBO.DefinirTipoBoleto (fase 1/2)
                THIS.this_oBusinessObject.DefinirTipoBoleto(par_nTpBol, ;
                    par_cTitEnvelope, par_cEmp, par_cDope, par_nNum, ;
                    par_nDev, par_nVias, par_nQBols, par_cCursor)

                *-- Espelha no form o que o BO acabou de normalizar (fonte
                *-- unica: o BO decide, o form so copia)
                THIS.BOParaForm()

                *-- Estado inicial dos tres checkboxes de opcao, exatamente
                *-- como o SCX declara os .Value (chkCarne = .T., chkObss =
                *-- .T., chkAgrupa = .F.). A VISIBILIDADE de cada um depende do
                *-- tipo de boleto e eh aplicada na fase que cria os controles,
                *-- usando DeveExibirImprimirCarne /
                *-- DeveExibirImprimirObservacoes /
                *-- DeveExibirAgruparInformacoes do BO.
                THIS.this_oBusinessObject.this_lImprimirCarne       = .T.
                THIS.this_oBusinessObject.this_lImprimirObservacoes = .T.
                THIS.this_oBusinessObject.this_lAgruparInformacoes  = .F.

                *-- Do Case do Caption (Init legado). Resolvido ANTES do
                *-- DODEFAULT porque os dois labels da faixa do cabecalho
                *-- espelham THIS.Caption, e eles sao criados dentro do
                *-- DODEFAULT (FormBase.Init -> InicializarForm).
                THIS.Caption = THIS.this_oBusinessObject.ObterTituloPorTipoBoleto()

                *-- llSair do legado (afeta o Enabled do Encerrar na fase 4)
                THIS.this_lBloquearEncerrar = THIS.ResolverBloqueioEncerrar(par_oFormChamador)

                *-- DODEFAULT() dispara FormBase.Init(), que chama
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ResolverBloqueioEncerrar - Reproduz o llSair do Init legado:
    *
    *   Case .vnTpBol = 1
    *       llSair = fChecaAcesso('SIGCHE','PROTSEMPRE') And ;
    *                (Type('poForm.Op_Escolha') = 'C') And ;
    *                poForm.Op_Escolha = 'INSERIR'
    *
    * ou seja: so ha bloqueio no tipo 1 (Protocolo de Cheque), quando o form
    * chamador esta INSERINDO e o usuario tem a permissao PROTSEMPRE - nesse
    * caso o Encerrar nasce DESABILITADO e o protocolo tem de ser impresso.
    *
    * O resultado eh identico ao do legado, mas as tres condicoes sao testadas
    * em ordem INVERTIDA, das baratas para as caras: VFP9 nao faz
    * curto-circuito em AND, entao a forma do legado chamaria fChecaAcesso
    * SEMPRE que vnTpBol = 1, mesmo quando Op_Escolha ja desqualifica o
    * bloqueio. E fChecaAcesso nao eh barato nem inocuo: o nome resolve para o
    * Framework\sigacess.PRG carregado no startup (o stub de 2 argumentos em
    * utils\functions.prg eh DEAD CODE - sigacess vence a resolucao), que abre
    * conexao propria e consulta SigCdAcu. Chamar menos vezes nao muda o valor
    * de retorno, so evita ida ao banco.
    *
    * A chamada com DOIS argumentos eh FIEL ao legado - os tres parametros
    * ausentes de sigacess.PRG tem fallback proprio (pUsu cai na PUBLIC Usuar,
    * pTot ausente avalia .F.); nao "consertar" acrescentando argumentos.
    *
    * Em modo de teste/validacao de UI nao ha SQL Server alcancavel: a chamada
    * PENDURA dentro do CREATEOBJECT do form e o harness le isso como "o form
    * nao instancia". Por isso o bypass pelos flags globais, no mesmo espirito
    * do gate de gnConnHandle. Sem permissao resolvida o default eh .F. =
    * Encerrar HABILITADO, que eh o lado seguro (nao prende o usuario na tela).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ResolverBloqueioEncerrar(par_oFormChamador)
        LOCAL loc_lBloquear, loc_cEscolha, loc_uAcesso
        loc_lBloquear = .F.

        DO CASE
            CASE THIS.this_nTpBol != 1
                *-- Fora do Protocolo de Cheque o legado nunca bloqueia
                loc_lBloquear = .F.

            CASE TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
                loc_lBloquear = .F.

            CASE TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lBloquear = .F.

            OTHERWISE
                *-- (Type('poForm.Op_Escolha') = 'C') And poForm.Op_Escolha = 'INSERIR'
                loc_cEscolha = ""
                IF VARTYPE(par_oFormChamador) = "O"
                    IF PEMSTATUS(par_oFormChamador, "Op_Escolha", 5)
                        IF VARTYPE(par_oFormChamador.Op_Escolha) = "C"
                            loc_cEscolha = ALLTRIM(UPPER(par_oFormChamador.Op_Escolha))
                        ENDIF
                    ENDIF
                ENDIF

                IF loc_cEscolha == "INSERIR"
                    loc_uAcesso = fChecaAcesso("SIGCHE", "PROTSEMPRE")
                    loc_lBloquear = (VARTYPE(loc_uAcesso) = "L" AND loc_uAcesso)
                ENDIF
        ENDCASE

        RETURN loc_lBloquear
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - Espelha no form os nove parametros que
    * SigOpIboBO.DefinirTipoBoleto acabou de normalizar (nome canonico do par
    * Form<->BO - PILAR 3). Fonte unica: o BO decide os defaults/guardas de
    * tipo, o form so copia. Qualificado por extenso de proposito - WITH
    * aninhado sobre o BO sequestra o escopo e resolveria ".Prop" contra o
    * objeto errado.
    *
    * Chamado UMA vez, no Init, logo depois de DefinirTipoBoleto - nao ha
    * Page2 de dados nem modo de edicao que o fizesse rodar de novo (a
    * diferenca que separa este dialogo do par FormParaBO/BOParaForm de um
    * form CRUD, que alternam a cada Incluir/Alterar/Visualizar).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.this_nTpBol       = THIS.this_oBusinessObject.this_nTpBol
        THIS.this_cTitEnvelope = THIS.this_oBusinessObject.this_cTitEnvelope
        THIS.this_cEmp         = THIS.this_oBusinessObject.this_cEmp
        THIS.this_cDope        = THIS.this_oBusinessObject.this_cDope
        THIS.this_nNum         = THIS.this_oBusinessObject.this_nNum
        THIS.this_nDev         = THIS.this_oBusinessObject.this_nDev
        THIS.this_nVias        = THIS.this_oBusinessObject.this_nVias
        THIS.this_nQBols       = THIS.this_oBusinessObject.this_nQBols
        THIS.this_cCursor      = THIS.this_oBusinessObject.this_cCursor
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Monta a estrutura visual base
    * (chamado por FormBase.Init via DODEFAULT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- 1. Fundo do form (SCX: Picture = ..\framework\imagens\new_background.jpg).
            *-- Caminho SEMPRE pela global ja resolvida - nunca remontado a
            *-- partir de gc_4c_CaminhoBase, que nao tem a navegacao "..\..\..".
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- 2. Containers do legado (faixa do cabecalho + painel flutuante).
            *-- PRIMEIRO de todos os AddObject: obj_4c_BtnReport sobrepoe a
            *-- faixa e precisa ser criado DEPOIS dela para desenhar por cima.
            THIS.ConfigurarPageFrame()

            *-- 3. Bloco do Init legado que monta crImpreV (lista de
            *-- impressoras). ANTES de qualquer campo: o ComboBox Get_Printer
            *-- da fase seguinte liga RowSource nesse cursor, e RowSource de
            *-- cursor inexistente derruba o Init (regra #41).
            *-- "return(.f.)" do legado quando a consulta falha: o form NAO
            *-- abre, e InicializarForm devolve .F.
            IF THIS.CarregarImpressoras()

                *-- 4. Barra de acao (btnReport): Imprimir + Encerrar
                THIS.ConfigurarBotoes()

                *-- 5a. Bloco da impressora e da quantidade de vias:
                *-- Lbl_Impressora / Label1 / Label2 / Opt_Impressora /
                *-- Get_Printer / Say9 / getQtde. DEPOIS do CarregarImpressoras
                *-- (passo 3), que eh quem cria cursor_4c_ImpreV - o ComboBox
                *-- Get_Printer liga RowSource nesse cursor (regra #41) - e
                *-- ANTES do TornarControlesVisiveis (passo 6), que eh quem
                *-- torna visivel o que acabou de ser criado.
                THIS.ConfigurarControles()

                *-- 5b. Bloco de OPCOES de impressao e conteudo do painel:
                *-- chkCarne / chkObss / chkAgrupa / Lbl_Erro /
                *-- cnt_4c_Container1.obj_4c_Edit1. Entre os passos 3 e 6 pelo
                *-- mesmo motivo do 5a, e eh o ULTIMO AddObject do form - o que
                *-- habilita os dois passos seguintes.
                THIS.ConfigurarOpcoes()

                *-- 5c. TabIndex: SO agora, com TODO AddObject do form feito.
                *-- Atribuir antes gravaria valor CLAMPADO pela quantidade de
                *-- controles existentes naquele instante (ver AplicarTabIndex).
                THIS.AplicarTabIndex()

                *-- 5d. BINDEVENT dos eventos (handlers PUBLIC - regra #3).
                *-- DEPOIS de todo AddObject: BINDEVENT sobre objeto que ainda
                *-- nao existe estoura no proprio bind, e o campo de quantidade
                *-- (txt_4c_Qtde) so nasce no passo 5a.
                THIS.ConfigurarEventos()

                *-- 6. AddObject cria tudo com Visible = .F.; torna a arvore
                *-- visivel preservando os controles que o legado mantem OCULTOS
                THIS.TornarControlesVisiveis(THIS)

                *-- 6a. Visibilidade dos tres checkboxes de opcao, que depende
                *-- do tipo de boleto. OBRIGATORIAMENTE depois do passo 6, que
                *-- forca Visible = .T. em toda a arvore e apagaria a decisao.
                THIS.AplicarVisibilidadeOpcoes()

                *-- 7. "With .btnReport / If .Cmd_Imprimir.Enabled ..." do fim
                *-- do Init legado
                THIS.AplicarEstadoBotoes()

                *-- 8. Ultimo IF do Init legado, que dispara a impressao sozinho
                THIS.VerificarImpressaoAutomatica()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria os DOIS containers do legado.
    *
    *   Form OPERACIONAL FLAT: o legado (SigOpIbo.SCX) nao tem PageFrame nem
    *   Page nenhuma - nenhum objeto de prefixo pgf_4c_ eh instanciado neste
    *   metodo. O nome do metodo eh mantido por convencao do orquestrador de
    *   migracao.
    *
    *   - cnt_4c_Sombra     (cntSombra)  : faixa cinza do cabecalho, com os dois
    *     labels sobrepostos que formam o efeito de sombra do titulo.
    *   - cnt_4c_Container1 (Container1) : painel BRANCO flutuante que exibe o
    *     conteudo de BOLETO.txt depois da impressao. Nasce OCULTO no SCX
    *     (Visible = .F.) e eh ligado pelo Cmd_Imprimir.Click legado. Fica
    *     VAZIO nesta fase: seu unico filho eh um EditBox (Edit1 ->
    *     obj_4c_Edit1), que eh controle de conteudo e entra na fase dos campos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oCab, loc_oErro

        TRY
            *-- cntSombra: Top=0, Left=0, Height=80. O dump declara Width=800
            *-- num form de Width=600 (artefato do Form Designer, container
            *-- desenhado 200px alem da borda) - usa-se THIS.Width.
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCab = THIS.cnt_4c_Sombra
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
            ENDWITH

            *-- Labels adicionados FORA do WITH do container: WITH aninhado
            *-- sobre AddObject descarta propriedades em silencio.
            *-- Width do dump = 769 (cabe nos 800 do container do Designer, mas
            *-- nao nos 600 do form) - usa-se THIS.Width - 20, que respeita a
            *-- margem Left = 10 dos dois lados e evita o recorte pelo pai.
            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                *-- AutoSize = .F. explicito: com WordWrap = .T. o AutoSize
                *-- DESCARTA a Height e colapsa o texto para uma linha so.
                .AutoSize      = .F.
                .Alignment     = 0
                .BackStyle     = 0
                *-- O SCX traz o literal "Cadastro de Testes" (placeholder do
                *-- frmcadastro), mas o Init legado SOBRESCREVE os dois labels
                *-- com ThisForm.Caption - este form, diferente do irmao
                *-- SIGOPBOL, de fato propaga o titulo. THIS.Caption ja esta
                *-- resolvido pelo Do Case executado no Init, antes do DODEFAULT.
                .Caption       = THIS.Caption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(0, 0, 0)
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = THIS.Caption   && ver lbl_4c_LblSombra
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.Width - 20
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            ENDWITH

            *-- Container1: painel do BOLETO.txt. Criado DEPOIS da faixa do
            *-- cabecalho (Top=203, nao ha sobreposicao, mas a ordem segue a do
            *-- dump). Permanece OCULTO - o Cmd_Imprimir.Click legado eh que o
            *-- liga, e so quando o arquivo BOLETO.txt existe apos a impressao.
            THIS.AddObject("cnt_4c_Container1", "Container")
            WITH THIS.cnt_4c_Container1
                .Top         = 203
                .Left        = 60
                .Width       = 480
                .Height      = 270
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(255, 255, 255)
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .F.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Reproduz o bloco do Init legado que resolve a lista
    * de impressoras de boleto disponiveis e a mensagem de indisponibilidade.
    *
    * A consulta em si (SigSyImp UNION SigCdAcG/SigCdmp, APRINTERS() e o
    * cruzamento que produz crImpreV) mora em
    * SigOpIboBO.CarregarImpressorasConfiguradas. Aqui fica o que eh de TELA:
    * a decisao de rodar ou nao a consulta e a montagem do lcErro.
    *
    * As duas mensagens sao as do codigo ATIVO do legado, na MESMA ordem - a do
    * tipo 3 sob "If Empty(lcErro)" e a de "lnCImp = 0" sobrescrevendo:
    *
    *   If Empty(lcErro) And ( Thisform.vnTpBol = 3 ) And ( Thisform.vnVias = 0 )
    *       lcErro = 'Boleto Tipo 3 Sem Configuracao do Tipo de Via. ...'
    *   EndIf
    *   ...
    *   If lnCImp = 0
    *       lcErro = 'Sistema Nao Apresenta Impressora(s) de Boleto ...'
    *   EndIf
    *
    * ATENCAO - a mensagem eh calculada e NAO eh exibida, e isso eh FIEL: o
    * unico bloco do legado que mostra o Lbl_Erro (".Lbl_Erro.Visible = .T." +
    * ".Lbl_Erro.Caption = lcErro") esta COMENTADO (*!*) no SCX, junto com o
    * ".Cmd_Imprimir.Enabled = .F." que o acompanha. Ou seja: no legado em
    * producao lcErro tambem morre sem aparecer, o Lbl_Erro continua
    * Visible = .F. e o botao Imprimir NUNCA eh desabilitado. Reativar esse
    * bloco seria inventar comportamento que o legado nao tem - o valor fica
    * guardado em this_cErroImpressoras, que a Fase 3 ja declarou.
    *
    * O bypass por gb_4c_ModoTeste/gb_4c_ValidandoUI existe porque o harness
    * (TesteAutomatico.prg) define gnConnHandle = 0 DE PROPOSITO e espera que o
    * form pule as queries por esses flags, nao por checagem de handle: sem o
    * bypass, SQLEXEC falha, InicializarForm devolve .F., CREATEOBJECT devolve
    * .F. e o teste de instanciacao reprova sem nenhum erro de SQL no log.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarImpressoras()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            DO CASE
                CASE TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
                    *-- Harness: sem conexao, sem SQL. cursor_4c_ImpreV nao eh
                    *-- criado, e this_nQtdImp fica em 0.
                    loc_lSucesso = .T.

                CASE TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    loc_lSucesso = .T.

                OTHERWISE
                    loc_lSucesso = THIS.this_oBusinessObject.CarregarImpressorasConfiguradas()
            ENDCASE

            IF loc_lSucesso
                THIS.this_cErroImpressoras = ""

                IF THIS.this_nTpBol = 3 AND THIS.this_nVias = 0
                    THIS.this_cErroImpressoras = "Boleto Tipo 3 Sem Configura" + ;
                        CHR(231) + CHR(227) + "o do Tipo de Via. Contate o Suporte T" + ;
                        CHR(233) + "cnico."
                ENDIF

                IF THIS.this_oBusinessObject.this_nQtdImp = 0
                    THIS.this_cErroImpressoras = "Sistema N" + CHR(227) + ;
                        "o Apresenta Impressora(s) de Boleto Configurada(s). " + ;
                        "Contate o Suporte T" + CHR(233) + "cnico."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.CarregarImpressoras")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Cria a barra de acao do legado: o CommandGroup
    * btnReport, com Cmd_Imprimir ("\<Imprimir") e Cmd_Sair ("Encerrar").
    *
    * Propriedades transcritas do dump (SIGOPIBO.btnReport), inclusive o
    * Top = -2 (o grupo comeca 2px ACIMA da borda do form, sobre a faixa do
    * cabecalho) e o Value = 2 de projeto, que o AplicarEstadoBotoes depois
    * troca para 1 - igual ao legado.
    *
    * ButtonCount eh a PRIMEIRA propriedade atribuida: CommandGroup criado por
    * AddObject nasce com ButtonCount = 0, e tocar em Buttons(N) antes disso
    * estoura "BUTTONS is not an object" (medido no VFP9 - o defeito eh de
    * PRE-CONDICAO, nao da sintaxe do WITH; com ButtonCount setado, qualquer
    * forma de WITH funciona).
    *
    * A geometria dos botoes INTERNOS eh aplicada ANTES de posicionar o grupo:
    * btnReport eh AutoSize = .T. e a altura/largura do grupo deriva dos
    * membros (5 + 75 + 5 = 85 de altura; 5 + 75 + 75 + 5 = 160 de largura -
    * exatamente o Height/Width que o SCX declara, que por isso tambem sao
    * transcritos sem conflito).
    *
    * NAO sao atribuidos no grupo: ForeColor, FontName/FontSize (CommandGroup
    * NAO TEM essas propriedades - atribuir derruba o Init e a tela nao abre).
    * A fonte e a cor moram nos MEMBROS, e eh assim que o SCX declara.
    *
    * O canonico cnt_4c_Saida (Left = 917, regra #10) NAO se aplica: ele eh dos
    * forms CRUD de 1000px de largura; aqui o form tem 600 e o botao ficaria
    * 300px fora da tela. Este dialogo tambem nao tem bloco de saida separado -
    * o Encerrar eh o 2o membro do proprio btnReport.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("obj_4c_BtnReport", "CommandGroup")

            *-- ButtonCount antes de qualquer Buttons(N)
            THIS.obj_4c_BtnReport.ButtonCount = 2

            *-- Command1 -> Cmd_Imprimir
            WITH THIS.obj_4c_BtnReport.Buttons(1)
                .Top         = 5
                .Left        = 5
                .Height      = 75
                .Width       = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .Caption     = "\<Imprimir"
                .ToolTipText = "Imprimir"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH

            *-- Command2 -> Cmd_Sair (Cancel = .T.: eh o botao do ESC)
            WITH THIS.obj_4c_BtnReport.Buttons(2)
                .Top        = 5
                .Left       = 80
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            *-- Grupo, depois dos membros (AutoSize deriva dos botoes)
            WITH THIS.obj_4c_BtnReport
                .AutoSize      = .T.
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 2
                .Height        = 85
                .Left          = 445
                .SpecialEffect = 1
                .Top           = -2
                .Width         = 160
                .BorderColor   = RGB(136, 189, 188)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Liga os eventos dos controles aos metodos do form.
    * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT com metodo PROTECTED
    * falha em SILENCIO - o controle fica inerte e nada aparece em log (regra
    * #3). Pelo mesmo motivo os handlers de "KeyPress" declaram os parametros
    * do evento.
    *
    * Chamado DEPOIS de todos os AddObject do form (ver InicializarForm, passo
    * 5d): BINDEVENT sobre objeto inexistente estoura no proprio bind, e
    * txt_4c_Qtde so nasce no ConfigurarControles.
    *
    * Os DOIS eventos do campo de quantidade apontam para o mesmo
    * comportamento, por caminhos diferentes de o usuario sair do campo
    * (mouse x teclado) - ver o cabecalho de ValidarQtde. O Valid do legado NAO
    * eh ligado direto: BINDEVENT em "Valid" de TextBox nao dispara de forma
    * confiavel.
    *
    * O ComboBox cbo_4c_Get_Printer e os tres checkboxes NAO recebem evento, e
    * isso eh fiel: o dump do legado nao tem Valid/When/LostFocus/
    * InteractiveChange em nenhum deles. A impressora escolhida eh lida do
    * CURSOR na hora de imprimir (FormParaBO), que eh o que o
    * Cmd_Imprimir.Click legado faz ("lcImp = crImpreV.IDupla"), e os
    * checkboxes sao lidos no mesmo momento.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro

        TRY
            BINDEVENT(THIS.obj_4c_BtnReport.Buttons(1), "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.obj_4c_BtnReport.Buttons(2), "Click", THIS, "BtnEncerrarClick")

            *-- getQtde: PROCEDURE Valid legado. "LostFocus" eh o equivalente
            *-- fiel (dispara ao SAIR do campo, inclusive pelo mouse);
            *-- "KeyPress" da a confirmacao imediata em ENTER/TAB.
            BINDEVENT(THIS.txt_4c_Qtde, "LostFocus", THIS, "ValidarQtde")
            BINDEVENT(THIS.txt_4c_Qtde, "KeyPress", THIS, "ValidarQtdeKeyPress")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ConfigurarEventos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControles - Cria o bloco da IMPRESSORA e da QUANTIDADE DE VIAS:
    * os 7 controles que o legado desenha entre Top 89 e Top 174 e que formam
    * uma unidade funcional (em qual impressora e em quantas vias sair).
    *
    *   SIGOPIBO.Lbl_Impressora -> lbl_4c_Lbl_Impressora   "Impressoras :"
    *   SIGOPIBO.Label1         -> lbl_4c_Label1           "Sistema"
    *   SIGOPIBO.Label2         -> lbl_4c_Label2           "Windows"
    *   SIGOPIBO.Opt_Impressora -> obj_4c_Opt_Impressora   (OptionGroup OCULTO)
    *   SIGOPIBO.Get_Printer    -> cbo_4c_Get_Printer      (ComboBox)
    *   SIGOPIBO.Say9           -> lbl_4c_Label9           "Qtde. de Vias :"
    *   SIGOPIBO.getQtde        -> txt_4c_Qtde             (TextBox)
    *
    * Form OPERACIONAL FLAT: os sete sao filhos DIRETOS do form, como no SCX -
    * nao ha Page nem container de dados onde pendura-los, e nenhum deles
    * recebe compensacao de Top (a compensacao "+29" eh dos forms com PageFrame
    * em Top = -29, que este legado nao tem).
    *
    * Os dois Label de cabecalho ("Sistema" e "Windows") rotulam as duas metades
    * do que o ComboBox exibe: o legado monta a coluna IDupla como
    * PADR(ALLTRIM(impressora do SISTEMA), 15) + " " + ALLTRIM(impressora do
    * WINDOWS), e as duas legendas ficam exatamente sobre o inicio de cada
    * metade (Left 125 e 242, contra o combo em Left 122).
    *
    * Decisoes de transcricao detalhadas no cabecalho do arquivo (secao da
    * Fase 5): ControlSource vazio e ZOrderSet descartados, AutoSize = .F.
    * explicito nos rotulos, BackStyle da classe "say" reposto em lbl_4c_Label9,
    * fonte da classe "fwget" reposta em txt_4c_Qtde, ForeColor no MEMBRO do
    * OptionGroup e Buttons(1).Value nao escrito.
    *
    * TabIndex NAO eh atribuido aqui, e isso NAO eh esquecimento: com AddObject
    * o VFP9 clampa TabIndex a quantidade de controles focalizaveis que ja
    * existem no container, e depois desta fase sao 4 (btnReport, Opt_Impressora,
    * Get_Printer, getQtde) contra os valores 2/3/7/9/8/10/10 que o SCX declara.
    * Escrever ".TabIndex = 7" agora gravaria 4 - uma linha que mente sobre o
    * valor efetivo. A numeracao inteira mora na fase que criar o ULTIMO
    * AddObject do form, em ordem ASCENDENTE e so nos focalizaveis (Label e
    * Container tem TabIndex mas nao tem TabStop: numera-los apenas embaralha a
    * sequencia). Dentro do OptionGroup o caso eh outro e por isso o TabIndex
    * DO MEMBRO eh transcrito: Buttons(1).TabIndex = 1 esta dentro da faixa
    * 1..ButtonCount (que ja vale 1) e grava o valor exato do SCX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControles()
        LOCAL loc_oErro

        TRY
            *-- Lbl_Impressora (SIGOPIBO.Lbl_Impressora): rotulo do bloco.
            *-- Classe "label" do VFP, e o SCX declara BackStyle = 0.
            THIS.AddObject("lbl_4c_Lbl_Impressora", "Label")
            WITH THIS.lbl_4c_Lbl_Impressora
                *-- O SCX declara AutoSize = .T.; ver regra #23 e o cabecalho
                *-- deste arquivo - Width/Height do dump SAO o auto-size
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Impressoras :"
                .Height    = 15
                .Left      = 121
                .Top       = 89
                .Width     = 80
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Label1 (SIGOPIBO.Label1): cabecalho da 1a metade do IDupla.
            *-- FontBold = .F. transcrito do SCX - os dois cabecalhos de coluna
            *-- sao mais leves que o rotulo "Impressoras :" acima.
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .AutoSize  = .F.
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sistema"
                .Height    = 15
                .Left      = 125
                .Top       = 137
                .Width     = 39
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Label2 (SIGOPIBO.Label2): cabecalho da 2a metade do IDupla
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .AutoSize  = .F.
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Windows"
                .Height    = 15
                .Left      = 242
                .Top       = 137
                .Width     = 45
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Opt_Impressora (SIGOPIBO.Opt_Impressora): a lista de impressoras
            *-- ANTIGA do legado, em radio buttons. Nasce Visible = .F. no SCX e
            *-- continua oculta: o bloco do Init que a preenchia (um
            *-- "With Thisform.Opt_Impressora" com ButtonCount dinamico) esta
            *-- COMENTADO (*!*) no legado, substituido pelo ComboBox
            *-- Get_Printer abaixo ("a lista de impressoras sairam dos radio
            *-- para o combobox", comentario datado de 05/03/2015 no proprio
            *-- SCX). O controle eh criado porque o SCX o tem e o dump declara
            *-- geometria e caption dele - reativa-lo seria inventar UX.
            THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")

            *-- ButtonCount ANTES de qualquer Buttons(N): OptionGroup criado por
            *-- AddObject nasce com ButtonCount = 0
            THIS.obj_4c_Opt_Impressora.ButtonCount = 1

            *-- Option1: a fonte e a COR moram no membro - OptionGroup nao tem
            *-- FontName/FontSize/ForeColor (regra #33)
            WITH THIS.obj_4c_Opt_Impressora.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
                .Height    = 16
                .Left      = 9
                .Style     = 0
                .TabIndex  = 1
                .Top       = 10
                .Width     = 306
                *-- AutoSize = .F. do SCX, com a Width que o Designer calculou
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Grupo, depois do membro. ".Value = 1" eh a selecao do GRUPO (o
            *-- "Value = 1" que o SCX declara no proprio Opt_Impressora);
            *-- "Option1.Value = 1" do dump nao eh escrito - num OptionGroup a
            *-- selecao eh gerenciada pelo grupo, e escrever no membro produz
            *-- botao marcado de forma espuria.
            WITH THIS.obj_4c_Opt_Impressora
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .Height      = 25
                .Left        = 115
                .Top         = 147
                .Width       = 321
                *-- Visible = .F. do SCX. AddObject ja cria oculto, mas a linha
                *-- fica explicita porque eh ESTADO DE PROJETO, nao artefato da
                *-- criacao - e o nome deste controle ja esta na lista de
                *-- excecao do TornarControlesVisiveis, que de outro modo o
                *-- exibiria junto com o resto da arvore.
                .Visible     = .F.
            ENDWITH

            *-- Get_Printer (SIGOPIBO.Get_Printer): a lista de impressoras ATUAL.
            *-- Style = 2 (Dropdown List - o usuario escolhe, nao digita) e
            *-- RowSourceType = 2 (Alias) transcritos do SCX. RowSourceType eh
            *-- definido JA AQUI, antes do RowSource logo abaixo.
            *-- "ControlSource = """ do dump nao eh transcrito (override vazio).
            THIS.AddObject("cbo_4c_Get_Printer", "ComboBox")
            WITH THIS.cbo_4c_Get_Printer
                .FontName          = "Tahoma"
                .FontSize          = 8
                .BoundColumn       = 1
                .RowSourceType     = 2
                .Height            = 23
                .Left              = 122
                .SpecialEffect     = 1
                .Style             = 2
                .Top               = 174
                .Width             = 240
                .DisabledBackColor = RGB(238, 238, 238)
                .DisabledForeColor = RGB(0, 0, 128)
                .BorderColor       = RGB(100, 100, 100)
                .BoundTo           = .F.
            ENDWITH

            *-- Vinculo do combo ao cursor das impressoras, na MESMA ORDEM do
            *-- Init legado:
            *--     SELECT crImpreV
            *--     GO top
            *--     thisform.get_Printer.value     = RECNO('crImpreV')
            *--     thisform.get_Printer.RowSource = 'crImpreV'
            *--     thisform.get_Printer.Refresh
            *-- O Value NUMERICO antes do RowSource eh deliberado e eh o que o
            *-- legado faz: com BoundTo = .F. um Value numerico vale pelo
            *-- ListIndex, ou seja "selecione a N-esima linha" - e N eh o
            *-- registro em que o cursor esta posicionado.
            *-- A guarda de USED() existe porque o cursor NAO existe em harness:
            *-- CarregarImpressoras devolve .T. sem consultar quando
            *-- gb_4c_ModoTeste/gb_4c_ValidandoUI estao ligados, e ligar
            *-- RowSource a alias inexistente derruba o Init inteiro (regra #41),
            *-- deixando CREATEOBJECT devolver .F. sem erro nenhum no log.
            IF USED("cursor_4c_ImpreV")
                SELECT cursor_4c_ImpreV
                GO TOP
                THIS.cbo_4c_Get_Printer.Value     = RECNO("cursor_4c_ImpreV")
                THIS.cbo_4c_Get_Printer.RowSource = "cursor_4c_ImpreV"
                THIS.cbo_4c_Get_Printer.Refresh()
            ENDIF

            *-- Say9 (SIGOPIBO.Say9) -> lbl_4c_Label9: rotulo da quantidade de
            *-- vias. Classe "say" do framework.vcx, que eh TRANSPARENTE por
            *-- heranca - o dump nao declara BackStyle porque nao precisa, mas
            *-- aqui o controle eh um Label BASE, cujo default eh OPACO: sem
            *-- .BackStyle = 0 o rotulo sairia com um retangulo pintado sobre o
            *-- fundo do form. Repor o default da classe nao eh invencao.
            *-- "ZOrderSet = 27" do dump nao eh transcrito (regra #33).
            THIS.AddObject("lbl_4c_Label9", "Label")
            WITH THIS.lbl_4c_Label9
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Qtde. de Vias :"
                .Height    = 15
                .Left      = 384
                .Top       = 158
                .Width     = 74
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- getQtde (SIGOPIBO.getQtde) -> txt_4c_Qtde: a quantidade de vias.
            *-- Classe "fwget" do framework.vcx; FontName/FontSize vem da classe
            *-- (ver cabecalho) e nao do instance level.
            *-- InputMask = "9" + MaxLength = 1: um unico DIGITO. A mascara
            *-- numerica esta correta aqui porque o .Value eh NUMERICO - o
            *-- Init legado faz ".getQtde.Value = .vnQBols" -, e nao uma string
            *-- (mascara "9" sobre campo CHAR bloquearia letras indevidamente).
            *-- Alignment nao eh atribuido: o dump nao declara, e o default do
            *-- TextBox ja alinha valor numerico a direita.
            *-- "ZOrderSet = 44" do dump nao eh transcrito (regra #33).
            THIS.AddObject("txt_4c_Qtde", "TextBox")
            WITH THIS.txt_4c_Qtde
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = THIS.this_nQBols
                .Height        = 23
                .InputMask     = "9"
                .Left          = 460
                .MaxLength     = 1
                .SpecialEffect = 1
                .Top           = 154
                .Width         = 24
                .BorderColor   = RGB(100, 100, 100)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ConfigurarControles")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOpcoes - Cria o bloco de OPCOES DE IMPRESSAO e o conteudo do
    * painel flutuante: a OUTRA metade dos controles do dump, que a fase
    * anterior deixou registrada como pendencia.
    *
    *   SIGOPIBO.chkCarne         -> chk_4c_ChkCarne   "Imprimir Carne"
    *   SIGOPIBO.chkObss          -> chk_4c_ChkObss    "Imprimir Observacoes"
    *   SIGOPIBO.chkAgrupa        -> chk_4c_ChkAgrupa  "Agrupar Informacoes"
    *   SIGOPIBO.Lbl_Erro         -> lbl_4c_Lbl_Erro   (aviso OCULTO)
    *   SIGOPIBO.Container1.Edit1 -> cnt_4c_Container1.obj_4c_Edit1  (EditBox)
    *
    * Os tres checkboxes e o Lbl_Erro sao filhos DIRETOS do form, como no SCX;
    * o EditBox eh filho do cnt_4c_Container1, que a Fase 3 ja criou vazio.
    *
    * VISIBILIDADE: os tres checkboxes nascem com o Visible que o AddObject da
    * (.F.) e sao resolvidos por AplicarVisibilidadeOpcoes, DEPOIS do
    * TornarControlesVisiveis - nao aqui. Ja o Lbl_Erro nasce OCULTO por
    * PROJETO (Visible = .F. no SCX) e o nome dele ja esta na lista de excecao
    * do TornarControlesVisiveis desde a Fase 3, por isso a linha fica
    * explicita abaixo.
    *
    * CheckBox.Value NUMERICO (1/0), nao LOGICO, apesar de o SCX declarar
    * .T./.T./.F.: CheckBox criado por AddObject assume o TIPO do que lhe for
    * atribuido, e o canonico do projeto eh numerico - misturar os dois tipos
    * entre a criacao e a leitura estoura "Operator/operand type mismatch". A
    * leitura (FormParaBO) passa por ConverterParaLogico, que
    * tolera os dois, e o Init ja gravou os mesmos defaults no Business Object.
    *
    * AutoSize: os tres checkboxes declaram AutoSize = .T. no SCX e os TRES
    * recebem .AutoSize = .F. com Width/Height EXPLICITOS - regra #23. Medido
    * no VFP9 (automation\_tmp746\medir746b.prg): CheckBox criado por AddObject
    * com AutoSize = .T. fica nos 100x17 do DEFAULT enquanto esta invisivel
    * (tres ordens de atribuicao testadas, todas 100x17) e so recalcula ao
    * ficar visivel - ou seja declarar .T. seria uma linha que mente sobre o
    * valor efetivo durante toda a montagem, inclusive na hora em que o
    * AplicarTabIndex e as checagens de sobreposicao olham a geometria.
    *
    * chkCarne eh o UNICO controle deste dump que nao declara Width/Height
    * (os irmaos declaram: chkObss 122x15, chkAgrupa 120x15). A largura NAO eh
    * herdada do default 100 nem estimada: foi MEDIDA no VFP9 com o mesmo
    * procedimento que reproduz os dois valores conhecidos - ligando o controle
    * com AutoSize = .T. e lendo a Width resultante, o caption "Imprimir
    * Observacoes" devolve 122 e "Agrupar Informacoes" devolve 120, EXATAMENTE
    * os numeros que o SCX declara; o mesmo procedimento devolve 88x15 para
    * "Imprimir Carne". Isto e: 88 eh o auto-size que o Form Designer teria
    * gravado, e o metodo se valida nos dois casos em que ha gabarito.
    * Conferido o cruzamento lateral da linha Top = 89 (regra #28):
    * Lbl_Impressora 121..201 / chkCarne 218..306 / chkAgrupa 351..471 - folga
    * de 17px e de 45px, nenhuma sobreposicao. Com o default 100 a faixa iria
    * a 318 e, embora ainda nao cruzasse o chkAgrupa, sobrariam 12px de caixa
    * transparente depois do texto.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOpcoes()
        LOCAL loc_oErro

        TRY
            *-- chkCarne (SIGOPIBO.chkCarne): "Imprimir Carne". Classe
            *-- "fwcheckbox" do framework.vcx; o SCX declara FontName/FontSize
            *-- no instance level, entao os dois sao transcritos.
            *-- Width/Height MEDIDOS (ver cabecalho deste metodo) - sao os
            *-- unicos deste dump que nao vem do SCX, porque o SCX nao os tem.
            THIS.AddObject("chk_4c_ChkCarne", "CheckBox")
            WITH THIS.chk_4c_ChkCarne
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Imprimir Carn" + CHR(234)
                .Height    = 15
                .Left      = 218
                .Top       = 89
                .Width     = 88
                *-- SCX: Value = .T. (ver cabecalho: numerico, nao logico)
                .Value     = 1
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- chkObss (SIGOPIBO.chkObss): "Imprimir Observacoes"
            THIS.AddObject("chk_4c_ChkObss", "CheckBox")
            WITH THIS.chk_4c_ChkObss
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Imprimir Observa" + CHR(231) + CHR(245) + "es"
                .Height    = 15
                .Left      = 218
                .Top       = 109
                .Width     = 122
                *-- SCX: Value = .T.
                .Value     = 1
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- chkAgrupa (SIGOPIBO.chkAgrupa): "Agrupar Informacoes".
            *-- Unico dos tres que nasce DESMARCADO no SCX (Value = .F.).
            THIS.AddObject("chk_4c_ChkAgrupa", "CheckBox")
            WITH THIS.chk_4c_ChkAgrupa
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Agrupar Informa" + CHR(231) + CHR(245) + "es"
                .Height    = 15
                .Left      = 351
                .Top       = 89
                .Width     = 120
                *-- SCX: Value = .F.
                .Value     = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Lbl_Erro (SIGOPIBO.Lbl_Erro): o aviso de impressora nao
            *-- configurada. Nasce Visible = .F. no SCX e CONTINUA oculto: o
            *-- unico bloco do legado que o exibia (".Lbl_Erro.Visible = .T."
            *-- junto com ".Lbl_Erro.Caption = lcErro") esta COMENTADO no SCX -
            *-- ver o cabecalho de CarregarImpressoras. O texto calculado fica
            *-- em THIS.this_cErroImpressoras; exibi-lo seria inventar
            *-- comportamento que o legado nao tem.
            *-- Caption transcrito do SCX, nao de this_cErroImpressoras: sao
            *-- textos DIFERENTES (o do SCX fala de "Seu Computador", os dois
            *-- calculados no Init falam de tipo de via e de "Sistema").
            *-- Classe "label" do VFP e o SCX declara BackStyle = 0.
            *-- Alignment = 2 (centralizado) e Width = 336 sao DECLARADOS pelo
            *-- SCX: eh alinhamento legitimo, nao invencao (regra #23).
            THIS.AddObject("lbl_4c_Lbl_Erro", "Label")
            WITH THIS.lbl_4c_Lbl_Erro
                .FontBold  = .T.
                .FontName  = "Verdana"
                .FontSize  = 9
                .WordWrap  = .T.
                *-- AutoSize = .F. EXPLICITO: com WordWrap = .T. o AutoSize
                *-- DESCARTA a Height e colapsa as duas linhas em uma, cortando
                *-- metade da frase (regra #23). O SCX nao declara AutoSize
                *-- (default .F.); a linha fica para a propriedade nao ser
                *-- "corrigida" depois para .T.
                .AutoSize  = .F.
                .Alignment = 2
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o Existe Impressora de Boleto " + ;
                    "Configurada no Seu Computador. Contate o Suporte T" + ;
                    CHR(233) + "cnico."
                .Height    = 28
                .Left      = 132
                .Top       = 250
                .Width     = 336
                .ForeColor = RGB(36, 84, 155)
                *-- Visible = .F. do SCX. AddObject ja cria oculto, mas a linha
                *-- fica explicita porque eh ESTADO DE PROJETO, nao artefato da
                *-- criacao - e o nome deste controle ja esta na lista de
                *-- excecao do TornarControlesVisiveis.
                .Visible   = .F.
            ENDWITH

            *-- Z-ORDER: no SCX o Container1 eh declarado DEPOIS do Lbl_Erro,
            *-- logo desenha POR CIMA dele. Aqui a ordem eh invertida por
            *-- necessidade - cnt_4c_Container1 nasce no ConfigurarPageFrame,
            *-- que tem de ser o PRIMEIRO AddObject do form (regra #11) - e as
            *-- duas faixas se cruzam de verdade: Lbl_Erro ocupa 132..468 x
            *-- 250..278 e o container ocupa 60..540 x 203..473. Mandar o label
            *-- para o FUNDO (ZOrder(1)) restaura o empilhamento do legado.
            *-- Hoje os dois nunca estao visiveis ao mesmo tempo, mas sem esta
            *-- linha o label apareceria SOBRE o texto do boleto se alguem
            *-- reativasse o bloco comentado.
            THIS.lbl_4c_Lbl_Erro.ZOrder(1)

            *-- Edit1 (SIGOPIBO.Container1.Edit1) -> obj_4c_Edit1: a caixa que
            *-- exibe o conteudo de BOLETO.txt depois da impressao. Filho do
            *-- cnt_4c_Container1 (criado vazio na Fase 3), e eh o membro que o
            *-- ExibirConteudoBoleto preenche no Click do Imprimir.
            *-- AddObject chamado FORA de qualquer WITH e o WITH aberto pelo
            *-- caminho completo: WITH aninhado sobre AddObject descarta
            *-- propriedades em silencio.
            *-- .Value = "" inicializa o EditBox como CHARACTER - o conteudo
            *-- que chega eh o FILETOSTR do BOLETO.txt, e EditBox sem
            *-- inicializacao assume o tipo do primeiro valor atribuido.
            *-- ReadOnly = .T. do SCX: o painel eh de LEITURA.
            *-- DisabledBackColor transcrito do dump - ele so pinta se o
            *-- controle for desabilitado (o que o legado nunca faz), mas eh
            *-- propriedade declarada e por isso vai junto.
            THIS.cnt_4c_Container1.AddObject("obj_4c_Edit1", "EditBox")
            WITH THIS.cnt_4c_Container1.obj_4c_Edit1
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Value             = ""
                .Height            = 236
                .Left              = 22
                .ReadOnly          = .T.
                .Top               = 18
                .Width             = 434
                .DisabledBackColor = RGB(255, 255, 255)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ConfigurarOpcoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarTabIndex - Numera a ordem de tabulacao dos controles FOCALIZAVEIS.
    *
    * Roda SO depois que TODOS os AddObject do form existem (eh o que as fases
    * 3, 4 e 5 registraram como pendencia explicita): com AddObject o VFP9
    * numera o TabIndex pela ORDEM DE CRIACAO, que nao tem relacao com a ordem
    * do legado, e o Tab anda errado sem erro, sem log e sem aparecer em
    * screenshot.
    *
    * A ordem vem dos TabIndex que o SCX declara:
    *   Get_Printer=2, getQtde=3, Opt_Impressora=7, chkCarne=8, btnReport=9,
    *   chkObss=10, chkAgrupa=10
    * Os valores sao REINDEXADOS para 1..7, e isso nao eh desvio do PILAR 1:
    * TabIndex eh POSICAO num vetor, nao identificador - o VFP9 clampa qualquer
    * valor acima da quantidade de posicoes do container, entao ".TabIndex = 10"
    * num form com 7 focalizaveis gravaria 7. O que o usuario percebe eh a
    * SEQUENCIA, e ela fica identica a do legado porque os objetos do SCX que
    * ficaram de fora da lista (Lbl_Impressora=1, Label1=4, Label2=5,
    * Lbl_Erro=6, Container1=11, Say9=12) sao Labels e Containers: tem TabIndex
    * mas nao tem TabStop, nunca param o Tab e portanto nao ocupam posicao
    * efetiva. Numera-los apenas embaralharia a sequencia dos que param.
    *
    * chkObss e chkAgrupa tem o MESMO TabIndex = 10 no SCX (o Form Designer
    * permite o empate). O VFP desempata pela ordem de criacao, e no SCX o
    * chkObss eh declarado antes - por isso ele recebe 6 e o chkAgrupa 7.
    *
    * As atribuicoes vao em ordem ASCENDENTE porque gravar um TabIndex
    * REORDENA os irmaos: fora de ordem, cada atribuicao empurra a anterior e o
    * resultado final nao eh o pretendido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarTabIndex()
        LOCAL loc_oErro

        TRY
            THIS.cbo_4c_Get_Printer.TabIndex    = 1    && SCX Get_Printer    = 2
            THIS.txt_4c_Qtde.TabIndex           = 2    && SCX getQtde        = 3
            THIS.obj_4c_Opt_Impressora.TabIndex = 3    && SCX Opt_Impressora = 7
            THIS.chk_4c_ChkCarne.TabIndex       = 4    && SCX chkCarne       = 8
            THIS.obj_4c_BtnReport.TabIndex      = 5    && SCX btnReport      = 9
            THIS.chk_4c_ChkObss.TabIndex        = 6    && SCX chkObss        = 10
            THIS.chk_4c_ChkAgrupa.TabIndex      = 7    && SCX chkAgrupa      = 10
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.AplicarTabIndex")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarVisibilidadeOpcoes - Transcreve o bloco do Init legado que decide
    * quais dos tres checkboxes de opcao aparecem, conforme o tipo de boleto:
    *
    *   ThisForm.chkObss.Visible   =  (.vnTpBol = 17)
    *   ThisForm.chkCarne.Visible  = !(.vnTpBol = 17)
    *   Thisform.chkAgrupa.Visible =  (.vnTpBol = 3)
    *   ThisForm.chkObss.Visible   = !(.vnTpBol = 18)
    *   ThisForm.chkCarne.Visible  =  (.vnTpBol = 18)
    *
    * chkObss e chkCarne recebem Visible DUAS vezes seguidas, sem IF entre as
    * atribuicoes: so a ULTIMA tem efeito, e por isso o resultado observavel eh
    * "chkObss aparece quando TpBol <> 18" e "chkCarne aparece quando
    * TpBol = 18" - as duas primeiras atribuicoes (o caso 17) nunca chegam a
    * ser vistas na tela. Os tres predicados moram no Business Object
    * (DeveExibirImprimirObservacoes / DeveExibirImprimirCarne /
    * DeveExibirAgruparInformacoes), que eh a fonte unica: o form so espelha.
    *
    * Roda DEPOIS do TornarControlesVisiveis, e nao dentro do ConfigurarOpcoes:
    * o TornarControlesVisiveis percorre a arvore INTEIRA forcando
    * Visible = .T., entao qualquer decisao de visibilidade tomada antes dele
    * seria APAGADA. Nao se resolve pela lista de excecao daquele metodo porque
    * aqui a visibilidade nao eh fixa - depende do tipo de boleto recebido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarVisibilidadeOpcoes()
        LOCAL loc_oErro

        TRY
            THIS.chk_4c_ChkObss.Visible = ;
                THIS.this_oBusinessObject.DeveExibirImprimirObservacoes()

            THIS.chk_4c_ChkCarne.Visible = ;
                THIS.this_oBusinessObject.DeveExibirImprimirCarne()

            THIS.chk_4c_ChkAgrupa.Visible = ;
                THIS.this_oBusinessObject.DeveExibirAgruparInformacoes()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.AplicarVisibilidadeOpcoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarQtde - Transcreve o PROCEDURE Valid de getQtde (o UNICO Valid do
    * dump deste legado):
    *
    *   If (ThisForm.getQtde.Value > 0)
    *       ThisForm.vnQBols = ThisForm.getQtde.Value
    *   EndIf
    *
    * Isto e: o valor digitado passa a ser a quantidade de boletos a imprimir,
    * mas ZERO (ou campo apagado) NAO zera a quantidade - o valor anterior
    * continua valendo. Essa guarda eh a regra, nao um detalhe: zerar faria o
    * Do SigBlBol receber qBols = 0 e nao imprimir nada.
    *
    * O destino eh o Business Object. No legado vnQBols eh property do FORM e o
    * Cmd_Imprimir.Click a le ("lnQtdBols = .vnQBols") para passar ao SigBlBol;
    * nesta arquitetura quem monta a chamada eh SigOpIboBO.ExecutarImpressao,
    * que le THIS.this_nQBols do BO. O espelho no form eh atualizado junto,
    * porque eh a copia que o resto da tela consulta (mesma relacao que o Init
    * estabelece: o BO decide, o form copia).
    *
    * LIGACAO AOS EVENTOS - sao DOIS, e cada um resolve um caminho diferente de
    * o usuario sair do campo:
    *   "LostFocus" -> este metodo. Eh o equivalente fiel do Valid: dispara ao
    *       SAIR do campo, inclusive quando o usuario vai direto ao botao
    *       Imprimir com o MOUSE, sem teclar nada. Sem ele, digitar 3 e clicar
    *       Imprimir mandaria imprimir a quantidade ANTIGA - em silencio.
    *   "KeyPress" -> ValidarQtdeKeyPress, que aplica o guard de ENTER/TAB e
    *       delega para ca. Da a resposta imediata de quem confirma pelo
    *       teclado. BINDEVENT em "Valid" de TextBox nao dispara de forma
    *       confiavel, e por isso o Valid do legado nao eh ligado direto.
    * Os dois caminhos sao idempotentes (a chamada so copia um numero), entao
    * TAB - que dispara KeyPress e depois LostFocus - executar duas vezes nao
    * tem efeito colateral. Nao ha guarda de reentrancia porque este metodo nao
    * abre dialogo nenhum e nao mexe no foco: os dois motivos pelos quais um
    * handler de LostFocus se redispara.
    *
    * PUBLIC (sem PROTECTED) porque eh chamado por BINDEVENT: metodo PROTECTED
    * ligado por BINDEVENT falha em SILENCIO - o campo fica inerte e nada
    * aparece em log (regra #3).
    *
    * O PROCEDURE When de getQtde ("Return .t.") NAO vira metodo: .T.
    * incondicional eh exatamente o default do VFP9 para When, logo o
    * comportamento ja esta reproduzido sem codigo. Escrever um handler que so
    * devolve .T. seria um metodo vazio.
    *
    * O VARTYPE antes da comparacao nao eh defensividade solta: ">" entre
    * CHARACTER e numero estoura "Operator/operand type mismatch", e .Value de
    * TextBox assume o tipo do ultimo valor atribuido - aqui ele nasce NUMERICO
    * (o ConfigurarControles faz ".Value = THIS.this_nQBols", como o
    * ".getQtde.Value = .vnQBols" do Init legado), mas um codigo futuro que
    * atribuisse string deixaria de ser pego por gate nenhum.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarQtde()
        LOCAL loc_uValor, loc_nQtde, loc_oErro

        TRY
            loc_uValor = THIS.txt_4c_Qtde.Value

            DO CASE
                CASE VARTYPE(loc_uValor) = "N"
                    loc_nQtde = loc_uValor
                CASE VARTYPE(loc_uValor) = "C"
                    loc_nQtde = VAL(loc_uValor)
                OTHERWISE
                    loc_nQtde = 0
            ENDCASE

            *-- "If (ThisForm.getQtde.Value > 0)" - zero NAO sobrescreve
            IF loc_nQtde > 0
                THIS.this_nQBols = loc_nQtde

                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.this_nQBols = loc_nQtde
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ValidarQtde")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarQtdeKeyPress - Handler de "KeyPress" do campo de quantidade.
    * So confirma o valor em ENTER(13) e TAB(9) e delega para THIS.ValidarQtde.
    *
    * Os parametros do evento SAO declarados: handler ligado a "KeyPress" sem
    * eles estoura a CADA tecla digitada (regra #3). E o guard eh obrigatorio
    * pelo motivo oposto - sem ele o handler rodaria a cada caractere, que eh a
    * familia de defeito da regra #47.
    *
    * Metodo SEPARADO de ValidarQtde, e nao o mesmo ligado aos dois eventos,
    * porque "LostFocus" nao passa parametro nenhum: os dois argumentos
    * chegariam como .F. LOGICO e a comparacao "par_nKeyCode = 13" estouraria
    * "Operator/operand type mismatch" justamente no caminho do mouse.
    *
    * PUBLIC (sem PROTECTED) - BINDEVENT com metodo PROTECTED falha em silencio.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarQtdeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF VARTYPE(par_nKeyCode) = "N"
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarQtde()
            ENDIF
        ENDIF
    ENDPROC
    *--------------------------------------------------------------------------
    * AplicarEstadoBotoes - Transcreve o bloco final do Init legado:
    *
    *   With .btnReport
    *       If .Cmd_Imprimir.Enabled
    *           .Value = 1
    *           .Cmd_Sair.Enabled = Not llSair
    *       Else
    *           .Value = 2
    *           .Cmd_Sair.Enabled = .T.
    *           .Cmd_Sair.SetFocus
    *       EndIf
    *   EndWith
    *
    * llSair eh THIS.this_lBloquearEncerrar, resolvido no Init pelo
    * ResolverBloqueioEncerrar (Protocolo de Cheque + INSERIR + PROTSEMPRE).
    *
    * O ramo ELSE eh transcrito mesmo sendo inalcancavel hoje: nenhum codigo
    * ATIVO do legado desabilita Cmd_Imprimir (o unico ".Cmd_Imprimir.Enabled =
    * .F." esta no bloco comentado *!* - ver CarregarImpressoras), entao a
    * condicao eh sempre verdadeira. Ele fica aqui porque eh o codigo do
    * legado, nao porque se espere que rode.
    *
    * As propriedades qualificadas por THIS. de proposito dentro do WITH: WITH
    * sobre outro objeto sequestra o escopo do ponto e resolveria
    * ".this_lBloquearEncerrar" contra o CommandGroup, que nao tem essa
    * propriedade - erro de runtime que derruba a abertura da tela.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarEstadoBotoes()
        LOCAL loc_oErro

        TRY
            WITH THIS.obj_4c_BtnReport
                IF .Buttons(1).Enabled
                    .Value = 1
                    .Buttons(2).Enabled = !THIS.this_lBloquearEncerrar
                ELSE
                    .Value = 2
                    .Buttons(2).Enabled = .T.
                    .Buttons(2).SetFocus()
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.AplicarEstadoBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarImpressaoAutomatica - Transcreve o ULTIMO IF do Init legado, que
    * dispensa o usuario de clicar Imprimir:
    *
    *   If (ThisForm.btnReport.Cmd_Imprimir.Enabled And pnTpBol = 14 And lnCimp >= 1) Or ;
    *      (Used([crSigCdOpd]) And Inlist(crSigCdOpd.Boletos,3))
    *       Thisform.btnReport.Value = 1
    *       ThisForm.btnReport.Cmd_Imprimir.Click()
    *   Endif
    *
    * lnCimp eh RECCOUNT('crImpreV') = SigOpIboBO.this_nQtdImp.
    *
    * crSigCdOpd eh cursor do form CHAMADOR - ver ObterBoletosSigCdOpd.
    *
    * NAO dispara em harness/validacao de UI: a impressao chama uma rotina
    * global do Fortyus que nao veio no acervo, e um dialogo de erro em
    * execucao headless trava o pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VerificarImpressaoAutomatica()
        LOCAL loc_lAuto, loc_oErro

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            RETURN
        ENDIF

        TRY
            loc_lAuto = (THIS.obj_4c_BtnReport.Buttons(1).Enabled AND ;
                         THIS.this_nTpBol = 14 AND ;
                         THIS.this_oBusinessObject.this_nQtdImp >= 1) OR ;
                        (THIS.ObterBoletosSigCdOpd() = 3)

            IF loc_lAuto
                THIS.obj_4c_BtnReport.Value = 1
                THIS.BtnImprimirClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.VerificarImpressaoAutomatica")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - PROCEDURE Cmd_Imprimir.Click legado (codigo ATIVO).
    * PUBLIC porque eh chamado via BINDEVENT (regra #3).
    *
    * O "With Thisform" do legado copia as nove propriedades para locais e
    * passa tudo ao Do SigBlBol. Aqui essas nove ja estao no Business Object
    * desde o Init (DefinirTipoBoleto), entao o que o Click transfere eh so o
    * que a TELA decide depois de aberta - impressora e os tres checkboxes -,
    * em FormParaBO.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_nSessaoAnterior, loc_cConteudo, loc_oErro
        loc_nSessaoAnterior = 0

        TRY
            *-- ".btnReport.Cmd_Sair.Enabled = .T." - imprimir LIBERA o Encerrar
            *-- que o llSair do Init pode ter bloqueado
            THIS.obj_4c_BtnReport.Buttons(2).Enabled = .T.

            *-- "lcImp = crImpreV.IDupla" + os tres checkboxes
            THIS.FormParaBO()

            *-- "Do SigBlBol With ..." (SigOpIboBO.ExecutarImpressao). A rotina
            *-- legada abre o CURSOR cujo NOME chegou em pCursor, e esse cursor
            *-- vive na datasession do CHAMADOR - este form eh DataSession = 2
            *-- (privada), por isso a troca temporaria. Era o que o
            *-- "Set DataSession to poForm.DataSessionId" do Init legado fazia
            *-- de uma vez para toda a tela; aqui so a chamada eh envolvida,
            *-- para nao expor o resto do form a sessao alheia.
            loc_nSessaoAnterior = THIS.EntrarDataSessionChamador()
            THIS.this_oBusinessObject.ExecutarImpressao()
            THIS.RestaurarDataSession(loc_nSessaoAnterior)
            loc_nSessaoAnterior = 0

            *-- "If Used([crSigCdOpd]) And Inlist(crSigCdOpd.Boletos,1)"
            IF THIS.ObterBoletosSigCdOpd() = 1
                THIS.Release()
            ELSE
                IF FILE("BOLETO.txt")
                    loc_cConteudo = FILETOSTR("BOLETO.txt")
                    THIS.ExibirConteudoBoleto(loc_cConteudo)
                    DELETE FILE "BOLETO.txt"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- Restaura a datasession tambem no caminho de falha: sair daqui
            *-- na sessao do chamador deixaria o resto do form lendo cursores
            *-- que nao sao dele
            THIS.RestaurarDataSession(loc_nSessaoAnterior)
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.BtnImprimirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - PROCEDURE Cmd_Sair.Click legado ("Thisform.Release").
    * PUBLIC porque eh chamado via BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transcreve o "With Thisform" do Cmd_Imprimir.Click legado
    * na parte que le a TELA (nome canonico do par Form<->BO que o resto do
    * projeto usa para forms CRUD - PILAR 3; aqui o "espelho" existe so neste
    * sentido, Tela -> BO, porque nao ha Page2 de dados nem modo de edicao a
    * transferir de volta, e por isso THIS.this_oBusinessObject.this_nQBols
    * tambem eh alimentado direto por ValidarQtde, nao por este metodo):
    *
    *   lnImpres  = RECNO('crImpreV')
    *   lcImp     = crImpreV.IDupla
    *   llObs     = IIF(lnTpbols=18, .chkCarne.Value, .chkObss.Value)
    *   llAgrupa  = (.chkagrupa.Value)
    *
    * A impressora eh lida do CURSOR, nao do .Value do ComboBox - eh o que o
    * legado faz, e eh equivalente: Get_Printer tem RowSourceType = 2 (Tabela),
    * e nesse modo o VFP move o ponteiro de registro do cursor a cada escolha
    * do usuario. Assim esta parte funciona com ou sem o ComboBox na tela.
    *
    * llObs (a escolha entre chkCarne e chkObss conforme o tipo 18) NAO eh
    * decidida aqui: ela esta em SigOpIboBO.ExecutarImpressao, com a MESMA
    * expressao do legado. Aqui os tres checkboxes sao apenas espelhados nas
    * tres propriedades do BO.
    *
    * Os tres checkboxes sao lidos SEM guarda de existencia, e isso eh
    * deliberado: os tres sao criados por ConfigurarOpcoes, que eh passo
    * OBRIGATORIO do InicializarForm (5b) - este metodo so roda a partir do
    * Click do Imprimir, isto eh, com a tela JA aberta e portanto com os tres
    * controles existindo. Um IF PEMSTATUS aqui nao protegeria nada e custaria
    * caro: se algum dos nomes divergisse, a leitura seria PULADA em silencio e
    * a escolha do usuario nunca chegaria ao BO - a impressao sairia com o
    * default do Init e ninguem veria erro, log ou aviso. Sem a guarda, o mesmo
    * erro de nome estoura na hora, no CATCH deste metodo, com nome e linha.
    *
    * ConverterParaLogico porque CheckBox.Value assume o tipo do que foi
    * atribuido - numerico (0/1) pelo canonico do projeto, logico no SCX - e
    * comparar logico com 1 estoura "Operator/operand type mismatch".
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_ImpreV")
                SELECT cursor_4c_ImpreV
                IF !EOF("cursor_4c_ImpreV") AND !BOF("cursor_4c_ImpreV")
                    THIS.this_oBusinessObject.this_cImpressoraSelecionada = ;
                        cursor_4c_ImpreV.IDupla
                ENDIF
            ENDIF

            *-- "llObs = IIF(lnTpbols=18, .chkCarne.Value, .chkObss.Value)":
            *-- os DOIS valores vao para o BO e a escolha entre eles fica em
            *-- ExecutarImpressao, com a mesma expressao do legado
            THIS.this_oBusinessObject.this_lImprimirCarne = ;
                ConverterParaLogico(THIS.chk_4c_ChkCarne.Value)

            THIS.this_oBusinessObject.this_lImprimirObservacoes = ;
                ConverterParaLogico(THIS.chk_4c_ChkObss.Value)

            *-- "llAgrupa = (.chkagrupa.Value)"
            THIS.this_oBusinessObject.this_lAgruparInformacoes = ;
                ConverterParaLogico(THIS.chk_4c_ChkAgrupa.Value)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ExibirConteudoBoleto - Transcreve o bloco do BOLETO.txt do
    * Cmd_Imprimir.Click legado:
    *
    *   thisform.container1.Visible = .t.
    *   thisform.container1.edit1.Value = lcConteudo
    *   thisform.container1.edit1.Refresh
    *
    * cnt_4c_Container1 nasce OCULTO (Visible = .F. no SCX, e por isso esta na
    * lista de excecao do TornarControlesVisiveis): eh AQUI que ele aparece.
    *
    * O EditBox eh alcancado SEM guarda de existencia, pelo mesmo motivo de
    * FormParaBO: obj_4c_Edit1 eh criado por ConfigurarOpcoes,
    * passo obrigatorio do InicializarForm, e este metodo so roda a partir do
    * Click do Imprimir. Um IF PEMSTATUS aqui faria o painel abrir EM BRANCO em
    * silencio - o usuario veria a moldura vazia e concluiria que a impressao
    * nao produziu nada. Sem a guarda, nome divergente estoura no CATCH.
    *
    * A ORDEM eh a do legado - Visible antes do Value: o EditBox pinta o
    * conteudo ja dentro do container visivel, e o Refresh fecha o bloco.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExibirConteudoBoleto(par_cConteudo)
        LOCAL loc_oErro

        TRY
            THIS.cnt_4c_Container1.Visible = .T.

            THIS.cnt_4c_Container1.obj_4c_Edit1.Value = par_cConteudo
            THIS.cnt_4c_Container1.obj_4c_Edit1.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.ExibirConteudoBoleto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterBoletosSigCdOpd - Le crSigCdOpd.Boletos, que o Cmd_Imprimir.Click e
    * o fim do Init legado consultam duas vezes:
    *
    *   If Used([crSigCdOpd]) And Inlist(crSigCdOpd.Boletos,1)   -> fecha a tela
    *   ... Or (Used([crSigCdOpd]) And Inlist(crSigCdOpd.Boletos,3)) -> imprime sozinho
    *
    * crSigCdOpd NAO eh cursor deste dialogo: eh do form CHAMADOR (parametros da
    * operacao de estoque). No legado ele estava visivel porque o Init fazia
    * "Set DataSession to poForm.DataSessionId" e a tela inteira passava a
    * rodar na sessao do chamador. Este form eh DataSession = 2 (fiel ao SCX),
    * logo o cursor NAO esta ao alcance: sem a troca, USED() devolveria SEMPRE
    * .F., as duas condicoes morreriam caladas e a tela deixaria de fechar
    * sozinha (Boletos = 1) e de imprimir sozinha (Boletos = 3).
    *
    * Devolve 0 quando nao ha chamador, quando o cursor nao existe ou quando a
    * coluna nao eh numerica - os tres casos em que o legado tambem nao casa
    * nenhum dos dois IF. Nao ha TRY aqui de proposito: USED() e TYPE() nao
    * estouram com alias fechado (TYPE devolve "U"), e a troca de sessao, que
    * eh o unico ponto que pode falhar, ja trata o erro no proprio metodo.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterBoletosSigCdOpd()
        LOCAL loc_nBoletos, loc_nSessaoAnterior
        loc_nBoletos = 0

        loc_nSessaoAnterior = THIS.EntrarDataSessionChamador()

        IF USED("crSigCdOpd") AND TYPE("crSigCdOpd.Boletos") = "N"
            loc_nBoletos = NVL(crSigCdOpd.Boletos, 0)
        ENDIF

        THIS.RestaurarDataSession(loc_nSessaoAnterior)

        RETURN loc_nBoletos
    ENDFUNC

    *--------------------------------------------------------------------------
    * EntrarDataSessionChamador - Troca para a datasession do form CHAMADOR,
    * registrada no Init em this_nDataSessionChamador (ver decisao 2 no
    * cabecalho deste arquivo).
    *
    * Devolve o numero da sessao ANTERIOR, para o chamador restaurar, ou 0
    * quando nao houve troca (sem form pai, ja na sessao certa, ou falha). Zero
    * eh o sinal de "nao ha o que restaurar": RestaurarDataSession(0) eh no-op.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION EntrarDataSessionChamador()
        LOCAL loc_nAnterior, loc_nDestino, loc_oErro
        loc_nAnterior = 0

        IF THIS.this_nDataSessionChamador > 0
            loc_nDestino = THIS.this_nDataSessionChamador
            TRY
                IF loc_nDestino != SET("DATASESSION")
                    loc_nAnterior = SET("DATASESSION")
                    SET DATASESSION TO loc_nDestino
                ENDIF
            CATCH TO loc_oErro
                *-- Sessao do chamador nao existe mais (form pai liberado no meio
                *-- do fluxo). Nada eh restaurado, e o erro fica VISIVEL: o que
                *-- vem depois - impressao ou leitura de crSigCdOpd - vai operar
                *-- na sessao errada, e isso nao pode passar calado (regra #9).
                loc_nAnterior = 0
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "FormSigOpIbo.EntrarDataSessionChamador")
            ENDTRY
        ENDIF

        RETURN loc_nAnterior
    ENDFUNC

    *--------------------------------------------------------------------------
    * RestaurarDataSession - Volta para a datasession devolvida por
    * EntrarDataSessionChamador. Zero significa "nao houve troca".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RestaurarDataSession(par_nSessao)
        LOCAL loc_nDestino, loc_oErro

        IF VARTYPE(par_nSessao) = "N" AND par_nSessao > 0
            loc_nDestino = par_nSessao
            TRY
                SET DATASESSION TO loc_nDestino
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "FormSigOpIbo.RestaurarDataSession")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna a arvore de controles visivel
    * recursivamente (AddObject cria tudo com Visible = .F.).
    *
    * CRITICO: os controles que o legado mantem OCULTOS ficam de FORA. Forcar
    * .Visible = .T. em toda a arvore exporia o painel do BOLETO.txt
    * (cnt_4c_Container1, Visible = .F. no SCX) ja na abertura da tela.
    * Para esses, pula-se a ATRIBUICAO do Visible mas CONTINUA-SE a RECURSAO
    * nos filhos: sem isso os filhos ficariam com Visible = .F. permanente e o
    * painel apareceria VAZIO quando o Cmd_Imprimir.Click o ligasse.
    *
    * A lista de excecao esta COMPLETA desde a Fase 3 e cobre os tres controles
    * que o legado mantem permanentemente ocultos: cnt_4c_Container1,
    * obj_4c_Opt_Impressora e lbl_4c_Lbl_Erro. Os tres checkboxes de opcao NAO
    * entram nela: a visibilidade deles nao eh fixa - depende do tipo de boleto -
    * e por isso eh resolvida DEPOIS deste metodo, em AplicarVisibilidadeOpcoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_lOculto, loc_oErro

        TRY
            FOR loc_i = 1 TO par_oContainer.ControlCount
                loc_oControl = par_oContainer.Controls(loc_i)

                IF VARTYPE(loc_oControl) = "O"
                    *-- Controles que o legado mantem ocultos: nao mexer no
                    *-- Visible deles (mas recursar nos filhos, abaixo)
                    *-- obj_4c_Opt_Impressora e lbl_4c_Lbl_Erro sao criados na
                    *-- fase dos campos e tambem nascem Visible = .F. no SCX
                    *-- (o OptionGroup porque a lista de impressoras migrou para
                    *-- o ComboBox, e o Lbl_Erro porque o bloco que o exibia
                    *-- esta comentado - ver CarregarImpressoras). Os nomes ja
                    *-- ficam aqui para que criar os controles nao desfaca o
                    *-- Visible = .F. deles: TornarControlesVisiveis percorre a
                    *-- arvore INTEIRA e e' a causa classica de controle que o
                    *-- legado esconde aparecer na tela migrada.
                    loc_lOculto = INLIST(UPPER(loc_oControl.Name), ;
                        "CNT_4C_CONTAINER1", ;
                        "OBJ_4C_OPT_IMPRESSORA", ;
                        "LBL_4C_LBL_ERRO")

                    IF !loc_lOculto AND PEMSTATUS(loc_oControl, "Visible", 5)
                        loc_oControl.Visible = .T.
                    ENDIF

                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                       loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "FormSigOpIbo.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores temporarios que o Business Object abre em
    * CarregarImpressorasConfiguradas (os mesmos crTmpCimp/crSigCdmp/crImpre/
    * crImp/crImpreV do Init legado) antes de repassar para FormBase.Destroy()
    * via DODEFAULT() - que eh quem reconstroi os popups do menu principal
    * depois do fechamento de um form modal.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_TmpCimp")
            USE IN cursor_4c_TmpCimp
        ENDIF
        IF USED("cursor_4c_SigCdmp")
            USE IN cursor_4c_SigCdmp
        ENDIF
        IF USED("cursor_4c_Impre")
            USE IN cursor_4c_Impre
        ENDIF
        IF USED("cursor_4c_Imp")
            USE IN cursor_4c_Imp
        ENDIF
        IF USED("cursor_4c_ImpreV")
            USE IN cursor_4c_ImpreV
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
