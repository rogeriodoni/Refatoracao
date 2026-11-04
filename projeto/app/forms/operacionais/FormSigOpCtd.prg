*==============================================================================
* FormSigOpCtd.prg
*
* Dialogo de Modo de Procura por Descricao (" Iniciais"/" Finais"/"Qualquer
* Posicao"/"Desc. Exata") - Legado: SigOpCtd.SCX (task715)
*
* FASE 3/8 - ESTRUTURA BASE. Esta fase entregou a CASCA do dialogo:
*
*   DEFINE CLASS + propriedades, Init() (recebe os parametros do antigo
*   "Do Form SigOpCtd With lcMsg, ThisForm" + os dois que o BO precisa para
*   montar o termo de busca sozinho), InicializarForm() (cria o BO, aplica o
*   Picture/Caption e monta o cabecalho) e Destroy().
*
* FASE 4/8 - "Grid e botoes CRUD (Page1)" no template generico. NAO SE
* APLICA: este dialogo nao tem Page1/Page2 nem Grid (mesma familia de
* falso-positivo do precedente FormSigOpCrp.prg/task714 e de
* task699/SIGOPCHP - ver skill propagate-lesson, feedback
* "gate_fase4_dialogo_multicontas_sem_lista"). O que o template chama de
* "botoes" e' Label1, Label2, Optiongroup1 e Commandgroup1 - a pergunta + as
* 4 opcoes + os botoes Procurar/Encerrar, que SAO a superficie funcional
* completa do dialogo. Entregues em ConfigurarControlesOpcao() (metodo
* abaixo) + BtnProcurarClick/BtnEncerrarClick.
*
* FASE 5/8 - "Campos principais (Page2 - Parte 1)" no template generico. O
* enunciado NAO alcanca este dialogo, por duas ausencias MEDIDAS no dump
* (tasks\task715\SigOpCtd_form_codigo_fonte.txt, SECAO 1 - 9 objetos, 5 filhos
* diretos do form):
*
*   1) Nao ha Page2 nem PageFrame - zero "BaseClass: pageframe". Criar um
*      ConfigurarPaginaDados() aqui seria o "stub disfarcado" que a regra de
*      completude proibe (precedente medido: feedback
*      "configurarpaginadados_stub_e_nunca_chamado").
*
*   2) Nao ha campo de ENTRADA algum - zero textbox / editbox / combobox /
*      spinner / checkbox no dump. Toda a superficie de captura do dialogo e'
*      o Optiongroup1 (os 4 modos), entregue na Fase 4. Metade de ZERO campos
*      e' zero, e acrescentar um TextBox seria inventar UI que o legado nao
*      tem (PILAR 1). Mesmo perfil do precedente FormSigOpCrp.prg (task714,
*      Fase 5) e do feedback "gate_fase5_exige_campos_inexistentes".
*
* O que a fase DE FATO entrega e' a AUDITORIA propriedade-por-propriedade do
* dump contra o que as Fases 3/4 transcreveram - o trabalho util da Fase 5 num
* form FLAT, onde a fase anterior cria muitos controles de uma vez e derruba as
* propriedades "pequenas" - MAIS um defeito de contrato que a auditoria
* desenterrou ao exercitar o dialogo instanciado (item "e" abaixo), este sim
* com efeito em runtime. Cinco divergencias achadas e corrigidas:
*
*   a) lbl_4c_LblSombra.Rotation / lbl_4c_LblTitulo.Rotation - o dump declara
*      Rotation = 0 nos dois e a Fase 3 descartou. Coincide com o default
*      (medido), entao a correcao e' de FIDELIDADE, nao de comportamento;
*   b) obj_4c_Commandgroup1.ToolTipText = "7" - declarado no dump, descartado
*      na Fase 4;
*   c) ShowTips = .F. - ver o bloco de propriedades da classe abaixo;
*   d) os 4 OptionButton sairam da Fase 4 com AutoSize = .T.; viraram .F. com
*      Width/Height explicitos - ver ConfigurarControlesOpcao();
*   e) os dois botoes fechavam a tela com THIS.Release(), que DESTROI a
*      instancia e torna o resultado ILEGIVEL pelo chamador - o dialogo existe
*      so para devolver o modo escolhido e ficava sem como devolve-lo. Agora os
*      dois passam pelo funil FecharDialogo() (Hide + copia para o form pai),
*      e o Release fica com o chamador. Medido no VFP9 - ver o cabecalho de
*      FecharDialogo() e o bloco "Uso" acima.
*
* FASE 6/8 - "Form - Campos Restantes e Lookups (Page2 - Parte 2)" no template
* generico (ultimos 50% dos TextBox/Labels + TODOS os lookups com BINDEVENT
* F4/F5 + cnt_4c_BotoesAcao). NAO SE APLICA, pela MESMA dupla ausencia medida
* na Fase 5 e confirmada de novo agora linha a linha no dump (SECAO 1 de
* tasks\task715\SigOpCtd_form_codigo_fonte.txt - 9 objetos: dataenvironment,
* form, container, 4 label, optiongroup, commandgroup):
*
*   1) Zero campo de ENTRADA - nenhum textbox/editbox/combobox/spinner/
*      checkbox no dump inteiro. "Ultimos 50% dos campos" de um total de ZERO
*      continua sendo ZERO; a unica superficie de captura e' o Optiongroup1,
*      que a Fase 4 ja entregou completo (ConfigurarControlesOpcao, incluindo
*      ordem/legenda/Value do grupo - regra #45).
*
*   2) Zero candidato a lookup - nenhum "fwbuscaext"/"fwBuscaSel"/"sigacess("/
*      "CreateObject(" nem "PROCEDURE Valid" no dump (comportamento.json:
*      4 metodos, temSQL=false, temValidacao=false, temLookup=false nos 4).
*      Inventar BINDEVENT("KeyPress", ...) + AbrirLookupXxx() sobre um campo
*      que nao existe seria tanto "stub disfarcado" (metodo chamando algo que
*      nao faz nada) quanto violacao do PILAR 1 (UI que o legado nao tem).
*
* Nao ha tambem cnt_4c_BotoesAcao (Salvar/Cancelar) do template: os botoes
* REAIS deste dialogo sao Procurar/Encerrar, dentro de obj_4c_Commandgroup1,
* entregues na Fase 4 com BINDEVENT("Click", ...) proprio - forma diferente do
* template porque o dump e' CommandGroup, nao dois CommandButton soltos.
*
* Mesmo perfil de falso-positivo do precedente FormSigOpCrp.prg (task714) e de
* task699/SIGOPCHP (perfil CAPTURA) - ver skill propagate-lesson, memoria
* "feedback_noop_guard_sem_excecao_para_fase_sem_trabalho" (secao
* "Segunda ocorrencia real medida em 2026-10-31 (task715/SigOpCtd)") e
* "feedback_gate_fase6_exige_lookup_inexistente".
*
* Conferido e MANTIDO como estava (nao sao divergencias) - tudo medido no VFP9
* em 2026-10-31:
*   - ButtonsPicturePosition = 13 e' o DEFAULT do VFP9 para CommandButton,
*     logo bate com o legado, que nao declara a propriedade;
*   - MousePointer = 15 nos dois botoes NAO esta no dump (default = 0). FICA:
*     e' propriedade comum a TODOS os botoes de icone do sistema novo
*     (docs\framework_frmcadastro_layout.md), e este SCX copiou a mao o resto
*     do visual canonico (75x75, Comic Sans MS 8 bold+italico, ForeColor
*     90,90,90, BackColor branco, Themes = .F.) sobre um commandgroup base. A
*     divergencia se limita ao CURSOR, sem efeito de layout;
*   - Commandgroup1 com AutoSize = .T. atribuido ANTES da geometria dos
*     Buttons NAO deformou o grupo: medido 160x85 em (645,-2), identico ao
*     dump (regra #31 - 5+75+75+5 = 160 e 5+75+5 = 85 fecham exato).
*
* FASE 7/8 - "Form - Eventos Principais" no template generico, que pede
* BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick. Esses
* QUATRO NAO SE APLICAM: o legado nao tem CRUD nenhum. Medido em 2026-10-31
* replicando o proprio gate da fase (case 7 de automation\Orquestrador-
* Migracao.ps1, helpers extraidos por AST - nunca dot-source, ver feedback
* "dot_source_orquestrador_dispara_migracao"):
*
*     legadoSemCrud = True    (sem frmcadastro, sem Grupo_Op, pcEscolha viva
*                              = 0, sem nome btn|cmd<Verbo>, sem <Verbo>.Click)
*     nBotoesLegado = 2       (Commandgroup1.ButtonCount; o ButtonCount = 4 do
*                              Optiongroup1 NAO entra - radio nao eh botao)
*     minHandlersF7 = 2   nHandlers = 2   -> PASSA
*
* Criar os quatro aqui seria INVENTAR botao (viola o PILAR 1) ou escrever
* metodo vazio (proibido pela regra de completude) - ver feedbacks
* "gate_fase7_piso_dois_handlers" e "gate_fase7_grupo_op_sem_verbo_crud".
*
* A superficie de evento do legado e' FECHADA e tem exatamente 4 metodos
* (comportamento.json: totalMetodos = 4), todos ja implementados:
*
*   SIGOPCTD.Init                      -> Init() + InicializarForm()   [Fase 3]
*   SIGOPCTD.Destroy                   -> Destroy()                    [Fase 3]
*   Commandgroup1.Command1.Click       -> BtnProcurarClick()           [Fase 4]
*   Commandgroup1.Command2.Click       -> BtnEncerrarClick()           [Fase 4]
*
* Logo o que esta fase DE FATO entrega e' a PROVA EM RUNTIME de que esses
* eventos disparam e produzem o contrato - o smoke test do VFP9 passou nesta
* sessao, entao deu para instanciar de verdade e nao so conferir estaticamente
* (feedback "vfp9_compila_e_sai_sem_executar_nesta_sessao"). Tudo medido em
* 2026-10-31:
*
*   1) COMPILACAO limpa de Form e BO (.FXP presente, .ERR ausente) com
*      CONTROLE NEGATIVO obrigatorio: uma COPIA deste form com
*      "PUBLIC PROCEDURE" colado no fim (regra #9.1) gerou .ERR apontando SO
*      as linhas acrescentadas - o que prova que o detector funciona E que as
*      688 linhas originais estao limpas.
*
*   2) O BINDEVENT dos botoes DESPACHA: acionar
*      obj_4c_Commandgroup1.Buttons(1).Click() / Buttons(2).Click() - o
*      caminho REAL do usuario, nao a chamada direta ao handler - executou
*      BtnProcurarClick/BtnEncerrarClick e mudou o estado do BO. Confirma que
*      o bind em botao-MEMBRO de CommandGroup vale (padrao dominante do
*      projeto: 401 sites contra 31 no Click do grupo).
*
*   3) O contrato 0..4 fecha com o legado, pelo Click real do botao:
*        opt 1 -> ret 1  oper "Like"  termo [MARIA%]    len 6
*        opt 2 -> ret 2  oper "Like"  termo [%MARIA]    len 6
*        opt 3 -> ret 3  oper "Like"  termo [%MARIA%]   len 7
*        opt 4 -> ret 4  oper "="     termo PADR(,50)   len 50
*        Encerrar -> ret 0  confirmou .F.  termo vazio
*      e em TODOS os cinco a copia para o form pai (legado: poForm.pnRetorno =
*      pnReturno) chegou com o mesmo valor.
*
*   4) Os dois handlers sao PUBLIC - PEMSTATUS(oForm, "Btn...Click", 2) = .F.
*      nos dois (regras #3 e #51: PEMSTATUS(...,5) daria .T. ate em metodo
*      PROTECTED e nao serve de prova).
*
*   5) O form SOBREVIVE ao fechamento: depois do Click de cada botao, o
*      objeto e o BO seguem legiveis (Hide, nao Release) - e' o que torna o
*      resultado recuperavel pelo chamador (ver item "e" da Fase 5).
*
*   6) Buttons(2).Cancel = .T. sobreviveu a instanciacao, entao o ESC do
*      legado (Command2.Cancel) continua caindo em BtnEncerrarClick; e
*      Buttons(1).Default = .F., igual ao legado, que NAO tem botao default -
*      Enter nao dispara Procurar, como antes.
*
* NAO foi preciso TRY/CATCH nos dois handlers: eles sao de 3 linhas, o BO eh
* garantidamente nao-nulo (InicializarForm devolve .F. e a tela nao abre se o
* CREATEOBJECT falhar) e e' a mesma forma do precedente FormSigOpCrp.prg
* (task714, mesmo perfil de dialogo).
*
* DIVERGENCIA MEDIDA que fica REGISTRADA e NAO foi mexida - esta no BO
* (ConfirmarOpcao, escopo da Fase 2) e NAO e' alcancavel pela UI: o legado faz
* "pnReturno = Optiongroup1.Value" CRU, enquanto ConfirmarOpcao() prende o
* valor na faixa 1..4. Com Optiongroup1.Value = 0 (nenhum modo marcado) o
* legado gravaria 0 ("Encerrar", o chamador nao consulta nada) e o migrado
* grava 1 (procura por iniciais) - medido: CK31 ret=1. So que Value = 0 NAO
* tem como acontecer pela tela: o SCX nasce com Value = 1 e radio nao se
* desmarca por clique; o estado so aparece atribuindo 0 por codigo, o que
* nenhum chamador faz. Mantido como esta por ser guarda defensiva, e anotado
* aqui para quem for repontar FormCTA/FormCliente para este form.
*
* FASE 8/8 - "Form - Eventos Auxiliares e Consolidacao Final" no template
* generico, que pede BtnBuscarClick/BtnEncerrarClick, BtnSalvarClick/
* BtnCancelarClick, FormParaBO/BOParaForm, HabilitarCampos/LimparCampos,
* CarregarLista/AjustarBotoesPorModo. Separando o que TEM referente neste
* dialogo do que nao tem - tudo medido no dump de task715, nao presumido:
*
* ENTREGUE nesta fase (tem referente):
*
*   FormParaBO()  - a tela TEM uma superficie de captura: obj_4c_Optiongroup1,
*                   os 4 modos. O Click legado faz "ThisForm.pnReturno =
*                   ThisForm.Optiongroup1.Value", que e' exatamente um
*                   FormParaBO de UM campo. A transferencia ja existia desde a
*                   Fase 4, mas INLINE no BtnProcurarClick; virou hook para ser
*                   FONTE UNICA do modo escolhido.
*   BOParaForm()  - caminho inverso, chamado por InicializarForm(): e' o que
*                   faz a tela abrir com " Iniciais" marcado, agora a partir do
*                   default do BO em vez de um 1 escrito duas vezes.
*
* Alem disso BtnProcurarClick passou a ABORTAR quando FormParaBO falha, em vez
* de confirmar um modo que nao veio da tela.
*
* DEFEITO DE ESCOPO achado AO EXERCITAR (nao por leitura do fonte): os dois
* hooks sairam desta fase como "FUNCTION" simples e o probe PENDUROU o VFP -
* sem log, sem erro e sem exit code - exatamente na 1a chamada de fora. Causa:
* FormBase declara "PROTECTED PROCEDURE FormParaBO/BOParaForm" (linhas 285 e
* 280) e o VFP9 NAO deixa a subclasse ALARGAR escopo herdado; chamar de fora
* estoura "Property BOPARAFORM is not found", e esse Program Error num VFP
* headless trava o processo. Omitir o PROTECTED nao tornava nada publico, so
* MENTIA para quem le. Os dois agora sao PROTECTED EXPLICITOS, chamados so por
* THIS. de dentro da classe (regra #8), e o probe os exercita por uma
* SUBCLASSE (ProbeSigOpCtd AS FormSigOpCtd) - script solto nao alcanca membro
* protegido. Ver regra #51 e a memoria
* "formbase_hooks_protected_nao_alargam". Isto NAO afeta o gate: a regex dele
* aceita o modificador ("^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)").
*
* PROVA EM RUNTIME desta fase (automation\ProbeF8SigOpCtd715.prg, medido em
* 2026-10-31 - o smoke test do VFP9 passou nesta sessao, entao houve execucao
* de verdade e nao so compilacao):
*
*   CK6  abertura: OptionGroup.Value = 1 e BO.this_nOpcaoSelecionada = 1
*   CK7  BO = 3 com a tela em 1 -> BOParaForm leva a tela para 3  (a fonte do
*        default e' o BO, nao o .Value de ConfigurarControlesOpcao)
*   CK8  BO = 0 -> tela 1   e   BO = 9 -> tela 1  (nunca DESMARCA os 4 radios)
*   CK9  tela 1..4 -> BO 1..4, CRU (sem +1/-1)
*   CK10 contrato pelo Click REAL do botao, agora passando por FormParaBO:
*          opt 1 -> ret 1  oper "Like"  termo [MARIA%]    len 6
*          opt 2 -> ret 2  oper "Like"  termo [%MARIA]    len 6
*          opt 3 -> ret 3  oper "Like"  termo [%MARIA%]   len 7
*          opt 4 -> ret 4  oper "="     termo PADR(,50)   len 50
*          Encerrar -> ret 0  confirmou .F.  termo e operador vazios
*        identico ao que a Fase 7 mediu ANTES do refactor - o hook nao mudou
*        comportamento, so a origem da leitura;
*   CK11 FormParaBO/BOParaForm protegidos = .T./.T. (atributo 2; o 5 responde
*        "existe?" e daria .T. de qualquer jeito - nao serve de prova)
*   CK12 BtnProcurarClick/BtnEncerrarClick protegidos = .F./.F. (continuam
*        PUBLIC, porque o BINDEVENT do CommandGroup os chama de fora)
*   CK13 o form segue vivo e legivel depois dos dois Click (Hide, nao Release)
*
* COMPILACAO limpa de Form e BO com CONTROLE NEGATIVO: uma copia do form com
* "PUBLIC PROCEDURE" colado no fim gerou .ERR apontando SO as duas linhas
* acrescentadas ("Error in line 967: Syntax error." / "line 968: Nesting
* error."), o que prova que o detector funciona E que o restante esta limpo.
*
* NAO SE APLICAM - e os motivos nao sao os mesmos, por isso vao um a um:
*
*   BtnEncerrarClick  - JA existe desde a Fase 4, com o nome do legado
*                       (Commandgroup1.Command2, Caption "Encerrar").
*   BtnBuscarClick    - o template usa "Buscar" para o botao que FILTRA a grade
*                       da Page1. Nao ha grade. O botao de ACAO deste dialogo e'
*                       "Procurar" (Command1) e seu handler BtnProcurarClick ja
*                       EH essa acao - batiza-lo de BtnBuscarClick trocaria o
*                       nome do legado por um nome do template.
*   BtnSalvarClick    - nao ha botao de gravar: o dump tem UM Commandgroup1 de
*                       ButtonCount = 2 (Procurar/Encerrar) e NENHUM
*                       btnSalvar/btnGravar/mGravaDados. O proprio gate da fase
*                       mede isso (legadoSemSalvar = True) e por isso nao cobra
*                       o nome.
*   BtnCancelarClick  - e' o botao que ABANDONA uma edicao na Page2 de Dados.
*                       Nao ha PageFrame, nem Page2, nem modo de edicao, nem
*                       registro em edicao. O 2o botao do SCX e' "Encerrar", que
*                       so fecha, e vem entregue com o nome do legado;
*                       renomea-lo faria o nome MENTIR sobre o que o metodo faz.
*   CarregarLista     - nao ha grade NEM cursor de listagem NESTE form, e o
*                       dialogo nao consulta banco nenhum (comportamento.json:
*                       metodosComSQL = 0, totalQueries = 0; o BO nao tem
*                       this_cTabela). Quem consulta e' o CHAMADOR, DEPOIS de
*                       ler o modo - inventar um CarregarLista aqui criaria uma
*                       SEGUNDA fonte para a consulta do pai.
*   HabilitarCampos   - habilita/desabilita os campos da Page2 conforme o modo
*   AjustarBotoesPorModo  CRUD (INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR). Nao ha modo
*                       CRUD neste dialogo (medido na Fase 7: legadoSemCrud =
*                       True) nem campo a habilitar - o OptionGroup esta sempre
*                       editavel, como no legado, e os dois botoes estao sempre
*                       ativos. Os dois metodos seriam corpos vazios ou
*                       atribuicoes constantes - o "stub disfarcado" que a regra
*                       de completude proibe.
*   LimparCampos      - limpa os campos da Page2 ao entrar em INCLUIR. Sem modo
*                       INCLUIR e sem campo de digitacao nao ha o que limpar; o
*                       estado inicial do unico controle e' posto por
*                       BOParaForm() na abertura, que e' o lugar certo para ele.
*
* O gate desta fase cobra BtnCancelarClick/FormParaBO/BOParaForm/CarregarLista.
* Medido em 2026-10-31 com automation\VerificarGateFase8Task715.ps1 (que roda o
* PROPRIO bloco "case 8" do orquestrador, helpers extraidos por AST - nunca
* dot-source, ver feedback "dot_source_orquestrador_dispara_migracao"), os 15
* ramos de excecao existentes devolveram TODOS False, sendo o mais proximo o
* RETORNO-AO-PAI (task655/SigOpCcj), que reprova por TRES motivos
* independentes:
*
*   1) a prova (1) dele exige que o Init confira o parametro com
*      Type('<par>') = 'O'; o Init legado deste SCX recebe
*      "Lparameters pcCaption, poForm" e NAO confere nada;
*   2) a prova (2) exige atribuicao a ThisForm.ParentForm.<membro>; aqui a
*      devolucao e' a uma PROPERTY do pai recebido por parametro
*      (ThisForm.poForm.pnRetorno), e nenhum CONTROLE do pai e' tocado;
*   3) a prova (3) exige que a atribuicao more no MESMO bloco Click que fecha a
*      tela; aqui ela mora no Destroy, e os Click fecham com "Release Windows",
*      nao com ThisForm.Release.
*
* Por isso a Fase 8 acrescentou ao orquestrador o 16o ramo, ESCOLHA-AO-PAI, com
* o helper Test-LegadoEscolhaAoPai - ver o comentario dele no orquestrador para
* as provas e a largura medida. Ele dispensa SO BtnCancelarClick/CarregarLista
* (os dois sem referente acima) e continua EXIGINDO FormParaBO/BOParaForm mais
* o handler do botao de acao, que e' justamente o que esta fase entregou:
* ausencia de grade nao autoriza entregar a tela pela metade.
*
*------------------------------------------------------------------------------
* NAO E UM CRUD - e' um dialogo FILHO, modal, sem barra de titulo (no SCX:
* WindowType = 1, TitleBar = 0, ControlBox = .F., BorderStyle = 2, 800x200),
* aberto pelo Cadastro de Contas (SIGCDCTA / FormCTA) dentro do msv_procurar.
* Ver o cabecalho de SigOpCtdBO.prg para o CONTRATO completo (os cinco
* retornos 0..4, a montagem do termo e a relacao com o FormOpcaoBusca ja
* existente, que continua sendo quem FormCTA/FormCliente usam hoje - repontar
* os dois para este form e' decisao SEPARADA desta task).
*
* Por isso este form:
*   - NAO tem PageFrame Page1=Lista/Page2=Dados (layout FLAT, 800x200, igual
*     ao SCX legado);
*   - NAO tem this_oBusinessObject.this_cTabela/this_cCampoChave (a tela nao
*     tem entidade propria - ver nota de arquitetura em SigOpCtdBO.prg);
*   - recebe o objeto do form pai (legado: "poForm") so para reproduzir a
*     copia que o Destroy legado faz (ThisForm.poForm.pnRetorno =
*     ThisForm.pnReturno) - guardado em this_oFormPai, NUNCA no BO (fecharia
*     um ciclo de referencias pai -> dialogo -> BO -> pai). O consumo
*     CANONICO do resultado, porem, nao depende disso: e' o chamador ler
*     this_oBusinessObject.this_nRetorno depois do Show(), no mesmo padrao
*     que FormBuscaAuxiliar e FormOpcaoBusca ja seguem.
*
* Uso (modal - regra #29: o Show() fica FORA de qualquer TRY). Os dois botoes
* fecham a tela por FecharDialogo(), que usa Hide() - quem chama Release() e' o
* CHAMADOR, DEPOIS de ler o resultado (mesmo contrato do FormBuscaAuxiliar).
* Fluxo medido no VFP9 em 2026-10-31:
*
*     loc_oDlg = CREATEOBJECT("FormSigOpCtd", loc_cMensagem, THISFORM, ;
*                             loc_cTermoDigitado, 50)
*     IF VARTYPE(loc_oDlg) = "O"
*         loc_oDlg.Show()                        && bloqueia ate o Hide
*         WITH loc_oDlg.this_oBusinessObject
*             loc_nRetorno = .this_nRetorno      && 0 = Encerrar, 1..4 = modo
*             loc_cTermo   = .this_cTermoBusca   && 'x%' / '%x' / '%x%' / PADR
*             loc_cOper    = .this_cOperador     && "Like" ou "="
*         ENDWITH
*         loc_oDlg = .NULL.
*     ENDIF
*
* Alternativa do legado (nao exclui a de cima): o chamador passa a si mesmo em
* par_oFormPai e declara a property pnRetorno; FecharDialogo() grava ali antes
* do Show() devolver, igual ao msv_procurar do SIGCDCTA. Medido: Procurar no
* modo 2 deixou poForm.pnRetorno = 2 e Encerrar deixou 0.
*==============================================================================

DEFINE CLASS FormSigOpCtd AS FormBase

    *--------------------------------------------------------------------------
    * Layout (pixel-perfect do legado - SIGOPCTD.SCX)
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width       = 800
    Height      = 200
    AutoCenter  = .T.
    BorderStyle = 2
    TitleBar    = 0
    ControlBox  = .F.
    WindowType  = 1
    ShowWindow  = 1
    FontName    = "Arial"
    Caption     = ""

    *--------------------------------------------------------------------------
    * ShowTips = .F. - FASE 5. O SCX NAO declara ShowTips e o default do VFP9
    * para Form e' .F. (medido em 2026-10-31): no legado NENHUM tooltip chegava
    * a aparecer. A FormBase declara ShowTips = .T., e isso faria aparecer os
    * dois ToolTipText que este dump declara - "Titulo do Relatorio" no
    * lbl_4c_LblTitulo (sobra do template do framework: este dialogo nao e'
    * relatorio) e o literal "7" no obj_4c_Commandgroup1. Os dois sao
    * transcritos por fidelidade ao dump; com ShowTips = .F. ficam INERTES,
    * exatamente como no legado, em vez de exibir texto que o usuario nunca viu.
    *--------------------------------------------------------------------------
    ShowTips    = .F.

    *--------------------------------------------------------------------------
    * this_oFormPai - legado: ThisForm.poForm. Objeto do form que abriu este
    * dialogo (ex.: FormCTA). Fica no FORM, nunca no BO - ver cabecalho de
    * SigOpCtdBO.prg, secao "ONDE FICA O poForm". So existe para o Destroy
    * reproduzir a copia que o legado faz; o consumo canonico (ler
    * this_oBusinessObject.this_nRetorno apos o Show()) nao depende dele.
    *--------------------------------------------------------------------------
    this_oFormPai = .NULL.

    *--------------------------------------------------------------------------
    * Guarda temporaria dos parametros do Init - FormBase.Init() chama
    * THIS.InicializarForm() SEM argumentos, entao o que o Init recebe tem de
    * ficar em property ate InicializarForm() ler e entregar ao BO.
    *--------------------------------------------------------------------------
    this_cMensagemPendente = ""   && legado: pcCaption / lcMsg do msv_procurar
    this_cTermoPendente    = ""   && texto digitado no campo do form pai, cru
    this_nTamanhoPendente  = 0    && largura da coluna consultada (0 = usar o default do BO)

    *==========================================================================
    * Init - recebe os parametros do antigo "Do Form SigOpCtd With pcCaption,
    * poForm" MAIS os dois que o BO precisa para montar o termo de busca
    * sozinho (par_cTermoDigitado/par_nTamanhoTermo - ver SigOpCtdBO.prg,
    * secao "MONTAGEM DO TERMO"). Todos opcionais: parametro omitido chega
    * como .F. (logico), por isso cada guarda testa o VARTYPE esperado antes
    * de guardar.
    *==========================================================================
    PROCEDURE Init(par_cMensagem, par_oFormPai, par_cTermoDigitado, par_nTamanhoTermo)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        IF VARTYPE(par_cMensagem) = "C"
            THIS.this_cMensagemPendente = par_cMensagem
        ENDIF

        IF VARTYPE(par_cTermoDigitado) = "C"
            THIS.this_cTermoPendente = par_cTermoDigitado
        ENDIF

        IF VARTYPE(par_nTamanhoTermo) = "N"
            THIS.this_nTamanhoPendente = par_nTamanhoTermo
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Hook de FormBase.Init(). Cria o BO (sem acesso a
    * servidor nenhum - ver nota de arquitetura em SigOpCtdBO.prg, por isso
    * roda sempre, inclusive em gb_4c_ValidandoUI, sem o guard que outros
    * forms usam para pular carga de dados), aplica o Picture/Caption
    * legados e monta o cabecalho.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCtdBO", ;
                THIS.this_cMensagemPendente, ;
                THIS.this_cTermoPendente, ;
                THIS.this_nTamanhoPendente)

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar o objeto de neg" + CHR(243) + "cio SigOpCtdBO.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF loc_lSucesso
                *-- legado: ThisForm.Caption = pcCaption
                THIS.Caption = THIS.this_oBusinessObject.this_cMensagem

                *-- legado: Picture = ..\framework\imagens\new_background.jpg
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarCabecalho()

                THIS.ConfigurarControlesOpcao()

                *-- FASE 8: marca no OptionGroup o modo que o BO traz como
                *-- default (this_nOpcaoSelecionada = 1, " Iniciais"), que e' o
                *-- Optiongroup1.Value = 1 do dump. Depois de
                *-- ConfigurarControlesOpcao() por obrigacao - o grupo precisa
                *-- existir e ja ter o ButtonCount = 4 (regra #18/#33).
                THIS.BOParaForm()

                THIS.TornarControlesVisiveis(THIS)
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - cnt_4c_Sombra + lbl_4c_LblSombra + lbl_4c_LblTitulo
    *
    * Transcricao pixel-perfect de SIGOPCTD.cntSombra (SECAO 2 do dump:
    * tasks\task715\SigOpCtd_form_codigo_fonte.txt). Nomes fixados em
    * tasks\task715\mapeamento.json. Como o Form legado JA tem 800px (o mesmo
    * Width desta classe), os valores entram literais - nao ha o
    * reescalonamento que FormSigOpCrp precisou fazer para o SCX de 520px.
    *
    * lblSombra (preto, por baixo) e lblTitulo (branco, por cima) formam o
    * efeito de sombra do titulo - os DOIS Caption acompanham THIS.Caption,
    * exatamente como o Init legado faz nas duas linhas finais.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Rotation      = 0        && SCX lblSombra: Rotation = 0 (FASE 5)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Rotation    = 0          && SCX lblTitulo: Rotation = 0 (FASE 5)
            .Caption     = THIS.Caption
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * FASE 4/8 - ConfigurarControlesOpcao: Label1/Label2 (a pergunta) +
    * Optiongroup1 (os 4 modos de procura) + Commandgroup1 (Procurar/
    * Encerrar).
    *
    * Esta e' a superficie funcional do dialogo que o template generico da
    * Fase 4 chama de "Grid e botoes CRUD (Page1)" - ver a nota no cabecalho
    * do arquivo (Fase 3): nao ha Grid nem barra CRUD aqui, e inventa-los
    * violaria o PILAR 1 e a regra "NUNCA inventar". Mesmo perfil de
    * falso-positivo documentado no precedente FormSigOpCrp.prg (task714) e em
    * [[feedback_gate_fase4_dialogo_multicontas_sem_lista]] (task699/SIGOPCHP).
    *
    * Transcricao pixel-perfect do dump (SECAO 2 de
    * tasks\task715\SigOpCtd_form_codigo_fonte.txt). mapeamento.json de
    * task715 nao fixa estes quatro objetos; os nomes seguem o padrao
    * obj_4c_<NomeOriginal>/lbl_4c_<NomeOriginal> ja usado em FormSigOpCrp.prg.
    *
    * ForeColor dos dois Label e dos quatro OptionButton = RGB(90,90,90)
    * (regra #12): nenhum dos dois fica dentro do cabecalho (cnt_4c_Sombra), e
    * sim direto no Form, cujo Picture (textura clara) tornaria ForeColor
    * branco invisivel. AutoSize = .T. do dump nos dois Label vira .F. +
    * Width/Height explicitos (regra #23 - AutoSize e' no-op em Label criado
    * por AddObject; os numeros do dump JA SAO o auto-size calculado pelo Form
    * Designer).
    *
    * FASE 5 - a MESMA regra #23 vale para os 4 OptionButton, que o dump tambem
    * declara com AutoSize = .T. e que a Fase 4 havia transcrito literalmente:
    * medido no VFP9 em 2026-10-31, AutoSize e' no-op tambem em OptionButton
    * criado por AddObject (nas duas ordens - Width/Height antes e depois de
    * AutoSize - os quatro ficaram com os 53/48/101/76 x 15 do dump, e sem
    * Width/Height o default mede 61x17). Por isso ficam .AutoSize = .F. com
    * Width/Height explicitos: os numeros do dump JA SAO o auto-size que o Form
    * Designer calculou, logo fixa-los e' reproducao fiel. ButtonsValue NAO
    * eh atribuido (o dump declara Option1.Value = 1, mas quem seleciona e' o
    * .Value = 1 do GRUPO - regra "NUNCA setar ButtonsValue != 0").
    *
    * Optiongroup1.ButtonCount tem de ser atribuido ANTES de configurar
    * Buttons(N) (regra #18/#33 - senao "BUTTONS is not an object"). A ORDEM e
    * a LEGENDA de cada botao vem do dump, nunca inventadas (regra #45): o
    * Value do grupo (1..4) E' o retorno que SigOpCtdBO.ConfirmarOpcao()
    * entrega ao chamador - ver SigOpCtdBO.prg, secao "O CONTRATO".
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControlesOpcao()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Left      = 233
            .Top       = 103
            .Width     = 277
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "N" + CHR(227) + "o Foi Encontrado Um Nome Igual ao Digitado!!! "
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Left      = 251
            .Top       = 123
            .Width     = 236
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Deseja Procurar Pelo Conteudo Digitado ?"
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * obj_4c_Optiongroup1 - os 4 modos de procura (legado: Option1..4).
        * Numeros/legendas conforme SigOpCtdBO.prg: this_nModoIniciais=1,
        * this_nModoFinais=2, this_nModoQualquer=3, this_nModoExata=4.
        *
        * FASE 8 - o .Value = 1 abaixo e' a transcricao do dump
        * (Optiongroup1.Value = 1) e NAO compete com o default do BO: quem diz
        * qual modo abre marcado e' THIS.BOParaForm(), que InicializarForm()
        * chama DEPOIS deste metodo e sobrescreve este valor com
        * this_nOpcaoSelecionada. Mudar o default, portanto, se faz no BO - aqui
        * fica so o valor inicial do controle, igual ao que o SCX declara.
        *----------------------------------------------------------------------
        THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
        WITH THIS.obj_4c_Optiongroup1
            .ButtonCount   = 4
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Left          = 229
            .Top           = 145
            .Width         = 341
            .Height        = 29
            .Value         = 1
            .Visible       = .T.
        ENDWITH

        WITH THIS.obj_4c_Optiongroup1.Buttons(1)
            .Left      = 5
            .Top       = 6
            .Width     = 53
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = " Iniciais"
        ENDWITH

        WITH THIS.obj_4c_Optiongroup1.Buttons(2)
            .Left      = 71
            .Top       = 6
            .Width     = 48
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = " Finais"
        ENDWITH

        WITH THIS.obj_4c_Optiongroup1.Buttons(3)
            .Left      = 130
            .Top       = 6
            .Width     = 101
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Qualquer Posi" + CHR(231) + CHR(227) + "o"
        ENDWITH

        WITH THIS.obj_4c_Optiongroup1.Buttons(4)
            .Left      = 252
            .Top       = 6
            .Width     = 76
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Desc. Exata"
        ENDWITH

        *----------------------------------------------------------------------
        * obj_4c_Commandgroup1 - Procurar (Buttons(1)) / Encerrar (Buttons(2)).
        * Mesmos icones/fonte do CommandGroup canonico (framework.vcx),
        * identico ao de FormSigOpCrp.prg (task714, mesmo perfil de dialogo).
        *----------------------------------------------------------------------
        THIS.AddObject("obj_4c_Commandgroup1", "CommandGroup")
        WITH THIS.obj_4c_Commandgroup1
            .ButtonCount   = 2
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 1
            .Top           = -2
            .Left          = 645
            .Width         = 160
            .Height        = 85
            .Themes        = .F.
            *-- FASE 5: literal do dump (SCX Commandgroup1.ToolTipText = "7").
            *-- Fica inerte porque a classe declara ShowTips = .F., como no
            *-- legado - ver o bloco de ShowTips nas propriedades da classe.
            .ToolTipText   = "7"
            .Visible       = .T.
        ENDWITH

        WITH THIS.obj_4c_Commandgroup1.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .MousePointer    = 15
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .Caption         = "\<Procurar"
        ENDWITH
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnProcurarClick")

        WITH THIS.obj_4c_Commandgroup1.Buttons(2)
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .MousePointer    = 15
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .Caption         = "Encerrar"
        ENDWITH
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * FASE 8 - FormParaBO: Tela -> BO.
    *
    * Transfere a UNICA superficie de captura do dialogo (obj_4c_Optiongroup1,
    * os 4 modos) para a property que o BO consome. E' a traducao literal da
    * 1a linha de SIGOPCTD.Commandgroup1.Command1.Click:
    *
    *     ThisForm.pnReturno = ThisForm.Optiongroup1.Value
    *
    * Esta transferencia ja existia, mas INLINE dentro de BtnProcurarClick
    * (Fase 4). Trazida para o hook canonico para virar FONTE UNICA: enquanto
    * morava no Click, qualquer segundo caminho que precisasse do modo
    * escolhido teria de reler o controle e as duas copias divergiriam em
    * silencio no primeiro ajuste (CLAUDE.md #44, item 6).
    *
    * Por que o valor vai CRU (sem +1/-1 e sem remapeamento): o OptionGroup do
    * legado nao tem ControlSource - o Click le .Value e esse NUMERO (1..4) E'
    * o retorno do dialogo. A ORDEM dos botoes, definida em
    * ConfigurarControlesOpcao() a partir do dump, E' o contrato (regra #45);
    * deslocar aqui faria o chamador consultar por um modo diferente do que o
    * usuario marcou, sem erro nenhum na tela.
    *
    * FUNCTION com retorno logico (nao PROCEDURE): BtnProcurarClick ABORTA a
    * confirmacao quando a transferencia falha, em vez de seguir e confirmar um
    * modo que nao veio da tela. FormBase declara o hook como PROCEDURE, mas em
    * VFP9 PROCEDURE e FUNCTION sao intercambiaveis e as duas devolvem valor -
    * o unico call site da base (FormBase.Salvar, linha 156) descarta o retorno,
    * entao devolver logico nao muda nada para quem herda.
    *
    * PROTECTED EXPLICITO - nao eh estilo, eh o escopo REAL: FormBase declara
    * "PROTECTED PROCEDURE FormParaBO" (linha 285) e o VFP9 NAO deixa a
    * subclasse ALARGAR escopo herdado. Escrever so "FUNCTION" nao tornaria o
    * metodo publico, apenas MENTIRIA para quem le - e chamar de fora
    * (loForm.FormParaBO()) estoura "Property FORMPARABO is not found", que num
    * harness headless PENDURA o processo (medido nesta fase, 2026-10-31: o
    * probe travou exatamente nessa linha). Por isso os dois hooks sao
    * chamados SO por THIS., de dentro da classe (regra #8), e o probe os
    * exercita por uma subclasse (ProbeSigOpCtd AS FormSigOpCtd) - script solto
    * nao alcanca membro protegido. Ver regra #51 e a memoria
    * "formbase_hooks_protected_nao_alargam".
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           VARTYPE(THIS.obj_4c_Optiongroup1) = "O"
            THIS.this_oBusinessObject.this_nOpcaoSelecionada = THIS.obj_4c_Optiongroup1.Value
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FASE 8 - BOParaForm: BO -> Tela.
    *
    * Caminho inverso do FormParaBO: marca no OptionGroup o modo que o BO
    * guarda em this_nOpcaoSelecionada. Chamado por InicializarForm() logo
    * depois de ConfigurarControlesOpcao(), e e' o que faz o dialogo ABRIR com
    * " Iniciais" marcado - o Optiongroup1.Value = 1 do dump.
    *
    * Existe por FONTE UNICA, nao por simetria decorativa: o default do
    * dialogo e' regra do BO (SigOpCtdBO.this_nOpcaoSelecionada = 1, que
    * this_nModoIniciais nomeia), e sem este hook o 1 ficaria escrito DUAS
    * vezes - uma no BO e outra no .Value do ConfigurarControlesOpcao. As duas
    * copias divergiriam no primeiro ajuste de default, e o dialogo passaria a
    * abrir num modo e confirmar outro caso o usuario nao tocasse no grupo.
    *
    * A guarda de faixa (1..this_nTotalModos) NAO eh enfeite: OptionGroup e'
    * 1-based e atribuir 0 DESMARCA os quatro botoes (regra "ControlSource
    * numerico = indice 1-based" / IIF(valor >= 1, valor, 1) na volta). Com os
    * quatro desmarcados o usuario veria a pergunta sem nenhuma resposta
    * pre-selecionada, o que o legado nunca faz. Fora da faixa cai no modo
    * Iniciais, o MESMO fallback que SigOpCtdBO.ConfirmarOpcao() aplica - a
    * divergencia medida contra o legado nesse estado inalcancavel ja esta
    * registrada no bloco da Fase 7, acima.
    *
    * PROTECTED EXPLICITO pelo MESMO motivo do FormParaBO acima (FormBase
    * declara "PROTECTED PROCEDURE BOParaForm" na linha 280) - ver o cabecalho
    * dele.
    *==========================================================================
    PROTECTED FUNCTION BOParaForm()
        LOCAL loc_lSucesso, loc_nModo
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           VARTYPE(THIS.obj_4c_Optiongroup1) = "O"
            loc_nModo = THIS.this_oBusinessObject.this_nOpcaoSelecionada

            IF VARTYPE(loc_nModo) != "N" OR ;
               loc_nModo < 1 OR loc_nModo > THIS.this_oBusinessObject.this_nTotalModos
                loc_nModo = THIS.this_oBusinessObject.this_nModoIniciais
            ENDIF

            THIS.obj_4c_Optiongroup1.Value = loc_nModo
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BtnProcurarClick - transcricao de SIGOPCTD.Commandgroup1.Command1.Click:
    *     ThisForm.pnReturno = ThisForm.Optiongroup1.Value
    *     Release Windows
    *
    * FASE 8: a leitura do controle saiu daqui para o hook THIS.FormParaBO()
    * (ver o cabecalho dele) - o Click deixou de ser um SEGUNDO lugar que
    * conhece o nome do OptionGroup. O efeito em runtime e' o mesmo medido na
    * Fase 7 (contrato 0..4 fechado): FormParaBO entrega o modo marcado ao BO e
    * ConfirmarOpcao() calcula this_nRetorno/this_cTermoBusca/this_cOperador a
    * partir dele (ver SigOpCtdBO.prg, PROCEDURE ConfirmarOpcao).
    *
    * Falhando a transferencia, NAO se confirma nada: sem o modo da tela o
    * ConfirmarOpcao gravaria o valor que o BO trazia de antes, e o chamador
    * consultaria por um modo que o usuario nao escolheu. Nesse caminho o
    * dialogo segue aberto, para o usuario poder tentar de novo ou Encerrar.
    *
    * "Release Windows" do legado fecha o dialogo - aqui pelo funil
    * THIS.FecharDialogo(), NAO por THIS.Release() (ver o cabecalho de
    * FecharDialogo).
    *==========================================================================
    PROCEDURE BtnProcurarClick()
        IF !THIS.FormParaBO()
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler o modo de procura " + ;
                "selecionado.", "Erro")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.ConfirmarOpcao()
        THIS.FecharDialogo()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - transcricao de SIGOPCTD.Commandgroup1.Command2.Click:
    *     ThisForm.pnReturno = 0
    *     Release Windows
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.this_oBusinessObject.Cancelar()
        THIS.FecharDialogo()
    ENDPROC

    *==========================================================================
    * FecharDialogo - FASE 5. Funil unico de saida dos dois botoes, com o
    * "Release Windows" do legado traduzido para Hide() + a copia para o form
    * pai.
    *
    * POR QUE NAO THIS.Release(): form NAO segue refcount: Release() DESTROI o
    * objeto mesmo com o chamador segurando a referencia. Medido no VFP9 em
    * 2026-10-31 neste proprio form - depois de BtnProcurarClick() terminar
    * (com Release), a instancia fica inutilizavel e ler QUALQUER property
    * dela, inclusive this_oBusinessObject, dispara Program Error (em sessao
    * headless -T isso PENDURA o processo). Ou seja: o dialogo se destruia
    * antes de o chamador ler o modo escolhido - era aberto justamente para
    * produzir esse valor e ficava sem como devolve-lo.
    *
    * Hide() em form modal TAMBEM devolve o Show(), entao para o usuario a
    * tela fecha igual (PILAR 1 preservado); muda so o tempo de vida do objeto,
    * que e' PILAR 3. Quem chama Release() e' o CHAMADOR, depois de ler - e
    * esse e' o desenho que o projeto JA adota em FormBuscaAuxiliar
    * ("Usa Hide() em vez de Release() para permitir leitura de propriedades"),
    * logo os chamadores do sistema novo ja esperam liberar o dialogo eles
    * mesmos. Ver o bloco "Uso" no cabecalho deste arquivo.
    *
    * A copia para o pai (legado: ThisForm.poForm.pnRetorno = ThisForm.
    * pnReturno) vem para CA porque com Hide() o Destroy so roda quando o
    * chamador liberar o form - tarde demais para quem le pnRetorno logo apos
    * o Show(), que e' o que o msv_procurar legado faz. O Destroy mantem a
    * mesma copia como rede de seguranca; as duas gravam o MESMO valor, entao
    * repetir e' inocuo.
    *
    * NAO existe PROCEDURE Unload() devolvendo o resultado: o SCX legado nao
    * tem Unload e o chamador legado nao abre com "DO FORM ... TO" - ele passa
    * ThisForm como poForm e le a propria pnRetorno. Criar esse retorno seria
    * caminho que o legado nao tem.
    *==========================================================================
    PROTECTED PROCEDURE FecharDialogo()
        IF VARTYPE(THIS.this_oFormPai) = "O" AND VARTYPE(THIS.this_oBusinessObject) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "pnRetorno", 5)
                THIS.this_oFormPai.pnRetorno = THIS.this_oBusinessObject.this_nRetorno
            ENDIF
        ENDIF

        THIS.Hide()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - padrao generico (percorre Pages de PageFrame e
    * Controls de Container recursivamente). Este form nao tem PageFrame nem
    * container flutuante Visible=.F.; Optiongroup1/Commandgroup1 (Fase 4)
    * entram direto no Form.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - legado: ThisForm.poForm.pnRetorno = ThisForm.pnReturno
    *
    * Reproduz a copia do Destroy legado quando o form pai existe e expoe a
    * property pnRetorno (ver SigOpCtdBO.prg, secao "ONDE FICA O poForm") -
    * guardado com PEMSTATUS porque nenhum chamador atual (FormCTA/FormCliente
    * seguem usando FormOpcaoBusca) declara essa property; sem ela, o bloco e'
    * inerte e nao impede nada. O consumo CANONICO (ler
    * this_oBusinessObject.this_nRetorno apos o Show()) nao depende deste
    * bloco. DODEFAULT() preserva o fix de menu/popup da FormBase (regra #29 /
    * Erro58) - tem de ser chamado DEPOIS de ler this_oBusinessObject, que a
    * FormBase.Destroy() zera.
    *
    * FASE 5: com o fechamento por Hide() (ver FecharDialogo), este Destroy so
    * roda quando o CHAMADOR liberar o form - tarde para quem le pnRetorno logo
    * apos o Show(). Por isso a copia passou a acontecer tambem em
    * FecharDialogo(); aqui ela fica como rede de seguranca (mesmo valor, logo
    * repetir e' inocuo) e para cobrir quem libere o dialogo sem passar pelos
    * botoes.
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oFormPai) = "O" AND VARTYPE(THIS.this_oBusinessObject) = "O"
            IF PEMSTATUS(THIS.this_oFormPai, "pnRetorno", 5)
                THIS.this_oFormPai.pnRetorno = THIS.this_oBusinessObject.this_nRetorno
            ENDIF
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
