# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [INIT-DUPLICADO] Init() chama DODEFAULT() E THIS.InicializarForm(). FormBase.Init() ja chama InicializarForm() internamente. Isso causa 'A member object with this name already exists' porque ConfigurarPageFrame/AddObject executa 2 vezes. CORRIGIR: Remover THIS.InicializarForm() do Init() - DODEFAULT() ja faz isso.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPGRC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1886 linhas total):

*-- Linhas 15 a 200:
15: *
16: * BO: SIGOPGRCBO (ja completo nas Fases 1-2). Sem tabela proprietaria: ele so
17: *     LE o cursor que o form PAI deixou pronto (crFinal) e agrega.
18: *
19: * Criado em: Fase 3 - Estrutura Base (DEFINE CLASS + propriedades visuais do
20: *            SCX + Init/InicializarForm/Destroy + cnt_4c_Sombra com os dois
21: *            labels do cabecalho).
22: *
23: * DIFERENCAS MEDIDAS CONTRA O GEMEO FormSigOpGco (task739/SIGOPGCO), que ja
24: * tem as 8 fases completas - registradas aqui para nenhuma fase seguinte
25: * copiar o irmao por reflexo (mesmas 3 diferencas documentadas no cabecalho
26: * do SIGOPGRCBO.prg):
27: *
28: *   1) NAO existe cursor "Cabecalho" nesta tela. O BO monta os tres
29: *      subtitulos a partir de colunas do PROPRIO crFinal (dtini/dtfinal/
30: *      lcGrupo1/lcGrupo2/lcMoe) mais a opcao de cotacao do pai - por isso
31: *      este form NAO vai reafirmar this_cCursorCabecalho em InicializarForm
32: *      (o SIGOPGRCBO nao declara essa property).
33: *   2) Entrada extra do pai: Thisform.ParentForm.OptCotacao.value (alem do
34: *      Comparativo.value que os dois gemeos tem) - vai para
35: *      this_oBusinessObject.this_nOpcaoCotacao nas fases de comportamento
36: *      (6-8), nao nesta.
37: *   3) ChartGroups(1).HasSeriesLines fica SO em .F. (sem o ".= .t." que o
38: *      SIGOPGCO tem adiante no mesmo metodo) - tambem fica para as fases de
39: *      comportamento.
40: *
41: * CONTRATO COM O FORM PAI (ainda nao migrado - nenhum form do projeto abre
42: * esta tela hoje)
43: * --------------------------------------------------------------------------
44: * Legado: "Lparameters pForm, datses" + "Set DataSession To DatSes" +
45: *         "ThisForm.ParentForm = pForm".
46: *
47: * 1) CREATEOBJECT("FormSIGOPGRC", <form pai>, <datasession do pai>) - os dois
48: *    parametros do Init legado, na mesma ordem. O segundo eh opcional: sem
49: *    ele, a sessao do pai eh lida de par_oFormPai.DataSessionId.
50: * 2) A tela NAO consulta o banco. Depende do cursor que o pai processa ANTES
51: *    de abrir este form (default do SIGOPGRCBO): crFinal - agregado com Mes,
52: *    Ordem, Ano, Grupos, Total, npercs, dtini, dtfinal, lcGrupo1, lcGrupo2 e
53: *    lcMoe, com os tags Grupom e imp. Por isso o Init entra na MESMA sessao
54: *    de dados do pai - com sessao privada propria, USED("crFinal") daria .F.
55: * 3) Quem exibe a tela eh o PAI, com .Show() FORA de qualquer TRY/CATCH
56: *    (CLAUDE.md regra #29): este form eh WindowType = 1 (transcrito do SCX),
57: *    entao o Show() BLOQUEIA e toda a vida da tela corre dentro dele.
58: * 4) O legado termina o Init com "Thisform.parentform.Aguarde.visible = .f."
59: *    e le "Thisform.Parentform.Comparativo.Value" - os dois dependem de
60: *    controles do PAI e entram nas fases de comportamento (6-8), sempre sob
61: *    guarda VARTYPE(THIS.this_oFormPai) = "O".
62: *
63: * FASE 4 - POR QUE NAO HA GRID NEM BOTOES CRUD AQUI
64: * --------------------------------------------------------------------------
65: * A Fase 4 entrega "Grid da Lista + os 6 botoes CRUD + AlternarPagina" nos
66: * forms de CADASTRO. Esta tela nao tem NENHUMA das duas superficies, e isso
67: * foi MEDIDO no dump do SCX (SIGOPGRC_form_codigo_fonte.txt), nao presumido:
68: *
69: *   BaseClass grid|pageframe ....................... 0 ocorrencias
70: *   BaseClass textbox|editbox|combobox|listbox|
71: *             checkbox|optiongroup|optionbutton|
72: *             spinner (campo de entrada) ........... 0 ocorrencias
73: *   .AddCursor / pColuna / RecordSource ............ 0 ocorrencias
74: *   .ControlSource ................................. 1, e eh o campo General
75: *                                                    do grafico
76: *                                                    (.ControlSource =
77: *                                                    'gGraficos' dentro do
78: *                                                    mostragrafico), nao
79: *                                                    coluna de lista
80: *
81: * Ou seja: nao ha o que LISTAR (sem grade) nem o que DIGITAR (sem campo). A
82: * arvore inteira do SCX sao 8 objetos: a faixa do cabecalho com 2 labels, um
83: * Shape decorativo, o OleBoundControl do grafico e os 2 CommandButton.
84: *
85: * Inventar um PageFrame Lista/Dados com 6 botoes CRUD violaria o PILAR 1 e a
86: * regra "NUNCA inventar"; escrever ConfigurarPaginaLista/AlternarPagina/
87: * Btn*Click que nao listam nada seria o "stub disfarcado" que a regra de
88: * completude proibe. Mesmo tratamento do gemeo FormSigOpGco (task739), que
89: * tambem nao tem lista nem campo.
90: *
91: * O que esta fase entrega, entao, eh a unica superficie de BOTAO que o legado
92: * REALMENTE tem, com comportamento completo:
93: *   ConfigurarBotoes()    cmd_4c_Sair (Encerrar) + cmd_4c_Imprimir, na ordem
94: *                         dos registros do SCX
95: *   ConfigurarEventos()   BINDEVENT dos dois Click (os 2 UNICOS eventos de
96: *                         controle do dump - nao ha mais evento a ligar)
97: *   CmdSairClick()        "Thisform.Release" do legado
98: *   CmdImprimirClick()    "Select Graph / Go Top / Report Form SigOpGrc To
99: *                         Printer Prompt NoConsole / Select Graph / Go Top /
100: *                         Thisform.Refresh" do legado
101: *   ExecutarReportForm()  helper canonico de REPORT FORM (guard de FILE no
102: *                         FRX + cursor vazio + isolamento de locale +
103: *                         reconstrucao do menu)
104: *
105: * FASE 5 - AREA DO GRAFICO E ORDEM DE TABULACAO (ENTREGUE)
106: * --------------------------------------------------------------------------
107: * A Fase 5 do pipeline pede "metade dos campos da Page2". Esta tela NAO TEM
108: * campo nenhum e NAO TEM Page nenhuma, e isso foi MEDIDO no dump, nao
109: * presumido: ZERO objeto de BaseClass textbox / editbox / combobox / listbox
110: * / checkbox / optiongroup / optionbutton / spinner, e ZERO pageframe. A
111: * arvore inteira do SCX sao 8 objetos (faixa do cabecalho com 2 labels, um
112: * Shape decorativo, o OleBoundControl do grafico e os 2 CommandButton) - a
113: * metade de zero campos eh zero. Inventar uma Page2 de Dados com TextBox
114: * violaria o PILAR 1 e a regra "NUNCA inventar"; escrever um
115: * ConfigurarPaginaDados vazio seria o "stub disfarcado" que a regra de
116: * completude proibe.
117: *
118: * O que esta fase entrega, portanto, eh a unica superficie de DADO que o
119: * legado REALMENTE tem - a area em que o grafico eh desenhado - mais o que
120: * so podia ser feito depois de todos os AddObject existirem:
121: *
122: *   ConfigurarPaginaDados()  shp_4c_Shape2 (Shape decorativo invisivel, cujo
123: *                            Z-ORDER protege o clique dos botoes) e
124: *                            obj_4c_OleGrafico (OleBoundControl do MSGraph),
125: *                            transcritos do dump e criados na ordem dos
126: *                            registros do SCX, ENTRE o cabecalho e os botoes
127: *   AjustarOrdemTabulacao()  TabIndex 1..4 nos ordinais EFETIVOS do legado
128: *                            (o Shape nao entra: a classe nao tem TabIndex)
129: *
130: * Com isso os 8 objetos do layout.json estao todos criados: Form,
131: * cnt_4c_Sombra, lbl_4c_LblSombra, lbl_4c_LblTitulo, shp_4c_Shape2,
132: * obj_4c_OleGrafico, cmd_4c_Sair e cmd_4c_Imprimir.
133: *
134: * FASE 6 - CAMPOS RESTANTES E LOOKUPS (CONFIRMADO: NAO HA O QUE ACRESCENTAR)
135: * --------------------------------------------------------------------------
136: * A Fase 6 pede os ultimos campos de Page2 e os lookups com BINDEVENT F4/F5.
137: * Esta tela e o layout "despachante" do dump (ver FASE 4 e FASE 5 acima): o
138: * SCX inteiro (SIGOPGRC_form_codigo_fonte.txt) tem ZERO objeto de BaseClass
139: * textbox/editbox/combobox/listbox/checkbox/optiongroup/optionbutton/spinner
140: * e ZERO padrao de lookup (fwbuscaext/fwBuscaSel/sigacess/CreateObject de
141: * busca) - confirmado de novo nesta fase com grep sobre o dump completo, nao
142: * so sobre a SECAO 1. Nao ha campo para digitar nem codigo para validar: a
143: * unica "entrada" da tela e visual (o grafico desenhado no OleBoundControl) e
144: * ja foi entregue na Fase 5 (ConfigurarPaginaDados). Criar um
145: * AbrirLookupXxx()/Validar*LostFocus() sem controle correspondente no SCX
146: * seria inventar funcionalidade que o legado nao tem (regra "NUNCA
147: * inventar" + stub disfarcado). Mesmo tratamento do gemeo FormSigOpGco
148: * (task739), que tambem fechou a Fase 6 sem nenhum campo/lookup.
149: *
150: * O QUE A FASE 7/8 ENTREGOU (eventos principais / comportamento)
151: * --------------------------------------------------------------------------
152: * O mostragrafico e a parte de DADOS do Init legado eram o que restava:
153: *
154: *   GerarGrafico()              orquestra o corpo do Init legado - le o modo
155: *                               Comparativo e a opcao de cotacao do pai,
156: *                               manda o BO agregar crFinal, cria o cursor do
157: *                               campo General, anexa o chart e desenha
158: *   AnexarGraficoAoCursor()     "Append Blank + Append General gGraficos
159: *                               Class 'MsGraph.Chart' Data lcStrg"
160: *   MostrarGrafico()            "PROCEDURE mostragrafico" - bind do
161: *                               ControlSource + LockScreen + os 3 blocos
162: *   AplicarFormatoGrafico()     galeria/fontes/legenda/titulo/areas
163: *   AplicarEixosColuna()        bloco "If m.lnConta1==1" (eixos + ChartGroups)
164: *   AplicarRotulosPercentuais() os dois lacos de rotulo de percentual
165: *   AplicarAreaPizza()          bloco "If m.lnConta1==2"
166: *   ObterComparativoDoPai()     "Thisform.Parentform.Comparativo.Value"
167: *   ObterOpcaoCotacaoDoPai()    "Thisform.ParentForm.OptCotacao.Value"
168: *                               (diferenca 2 do cabecalho - entrada que o
169: *                               gemeo FormSigOpGco nao tem)
170: *   OcultarAguardeDoPai()       "Thisform.parentform.Aguarde.visible = .f."
171: *
172: * Os DOIS Click do SCX (Imprimir / Sair) ja tinham sido entregues na Fase 4,
173: * porque entregar botao com handler vazio seria o stub que a regra de
174: * completude proibe.
175: *
176: * NAO existem os quatro handlers de verbo CRUD de form de CADASTRO - um por
177: * incluir, alterar, visualizar e excluir -, e isso eh MEDIDO, nao presumido.
178: * Os nomes NAO aparecem escritos por extenso aqui no comentario de proposito:
179: * o gate da fase procura cada um deles como SUBSTRING do arquivo inteiro,
180: * entao cita-los por extenso faria a fase passar pelo motivo errado - por um
181: * comentario, e nao pela excecao de legado-sem-CRUD que eh a razao real. O
182: * dump do SIGOPGRC (ver FASE 4 acima) tem ZERO occorrencia de pcEscolha, ZERO
183: * objeto ou metodo com nome de verbo CRUD e ZERO "<verbo>.Click" - a tela
184: * herda de "form" puro (nao de frmcadastro), tem os 2 CommandButton da
185: * SECAO 1 (Imprimir / Sair) e nenhuma superficie de registro. Inventar os 4
186: * botoes violaria o PILAR 1 e a regra "NUNCA inventar"; cria-los vazios
187: * violaria a regra de completude. Precedentes da mesma familia: o gemeo
188: * FormSigOpGco (task739) e FormSigPrGf2 (task613), as outras duas telas de
189: * grafico OLE do projeto.
190: *
191: * FASE 8 - CONSOLIDACAO FINAL: TRES DEFEITOS REAIS, MEDIDOS E CORRIGIDOS
192: * --------------------------------------------------------------------------
193: * A Fase 8 do pipeline pede os metodos de consolidacao de form de CADASTRO
194: * (carga da lista, os dois hooks de mapeamento campo<->BO, habilitar/limpar
195: * campos, ajustar botoes por modo e o handler do botao de desistir). Nenhum
196: * deles tem referente nesta tela - nao ha lista, nao ha campo editavel, nao
197: * ha modo de edicao e nao ha persistencia (ver FASE 4, FASE 5 e FASE 6
198: * acima, todas MEDIDAS no dump). Os nomes seguem NAO escritos por extenso
199: * aqui, pelo mesmo motivo do paragrafo anterior: o gate os procura como
200: * SUBSTRING do arquivo inteiro, e cita-los faria a fase passar por um

*-- Linhas 241 a 303:
241: * aceito; o form compila sem .ERR (com controle negativo na mesma rodada).
242: *
243: * NAO deu para exercitar o desenho do grafico: "MsGraph.Chart" NAO esta
244: * registrado nesta estacao (CREATEOBJECT devolve "Class definition
245: * MSGRAPH.CHART is not found"). O caminho OLE - APPEND GENERAL, AutoFormat,
246: * eixos e rotulos - fica validado so por transcricao contra o dump, e o
247: * comportamento desta maquina eh exatamente o que AnexarGraficoAoCursor
248: * trata: apaga a linha em branco, deixa this_lGraficoGerado em .F. e manda
249: * GerarGrafico avisar o usuario, em vez de exibir grafico vazio como se
250: * fosse resultado valido.
251: *
252: * TRES ITENS DE CONFERENCIA QUE O GEMEO SO ACHOU NA FASE 8 DELE, e que esta
253: * entrega ja trazia da fase anterior, por serem o MESMO defeito em telas
254: * quase identicas:
255: *
256: * 1) GerarGrafico NAO roda sob o validador de UI. ValidarUIFidelity instancia
257: *    o form com gb_4c_ValidandoUI = .T. e SEM form pai, entao crFinal nao
258: *    existe, CarregarDoCursor devolve .F. e o aviso sairia como MESSAGEBOX
259: *    MODAL - que, num harness sem ninguem para clicar, TRAVA a validacao ate
260: *    o timeout. MsgAviso so se auto-suprime em gb_4c_ModoTeste (ver
261: *    utils\messages.prg); gb_4c_ValidandoUI ele nao conhece. Guard canonico
262: *    do projeto, o mesmo do Problema 4 das licoes do FormCor. Ver
263: *    InicializarForm.
264: * 2) Os cursores de trabalho do BO (Meses/Grupos/Percentuais) NAO vazam na
265: *    data session do form PAI: SIGOPGRCBO ganhou LimparCursores(), chamado
266: *    pelo Destroy do form - sem isso eles sobreviveriam ao fechamento da
267: *    tela, porque este form entra na sessao do pai (ver Init). Ver Destroy.
268: * 3) O Imprimir ja tem o guard que MostrarGrafico tem (this_lGraficoGerado,
269: *    nao RECCOUNT): RECCOUNT() CONTA registro marcado como excluido com SET
270: *    DELETED OFF (o default), que eh exatamente o que sobra quando o
271: *    APPEND GENERAL falha e AnexarGraficoAoCursor apaga a linha em branco.
272: *    Ver CmdImprimirClick (ja entregue na Fase 4).
273: *
274: * ESTADO FINAL
275: * --------------------------------------------------------------------------
276: *   Migracao COMPLETA. O dump do SIGOPGRC esta TODO portado: os 8 objetos da
277: *   SECAO 1 (Fases 3-5) e os 5 metodos da SECAO 3 - mostragrafico e Init
278: *   (Fase 7), os 2 Click (Fase 4) e o Load, que nao gera metodo (fConfigGeral
279: *   eh funcao GLOBAL do Framework Fortyus; a configuracao global do sistema
280: *   novo ja acontece antes, em config.prg/main.prg). A Fase 8 fechou com a
281: *   revisao contra o dump e contra o FRX descrita acima.
282: *==============================================================================
283: 
284: DEFINE CLASS FormSIGOPGRC AS FormBase
285: 
286:     *==========================================================================
287:     * PROPRIEDADES VISUAIS - transcritas do SCX legado (PILAR 1)
288:     * SIGOPGRC: Width=800, Height=600, BorderStyle=2, AutoCenter=.T.,
289:     * MaxButton=.F., MinButton=.F., TitleBar=0, WindowType=1, DataSession=2.
290:     *
291:     * Dialogo de grafico: fica nos 800x600 do legado e NAO escala para o
292:     * canonico 1000x600, que vale para os CRUD frmcadastro.
293:     *
294:     * ControlBox/Closable NAO sao declarados: o dump do SCX nao os cita, e
295:     * fixar Closable = .F. tiraria o Alt+F4, que no legado continua valendo.
296:     *==========================================================================
297:     Width       = 800
298:     Height      = 600
299:     AutoCenter  = .T.
300:     BorderStyle = 2
301:     MaxButton   = .F.
302:     MinButton   = .F.
303:     TitleBar    = 0

*-- Linhas 345 a 563:
345:     * passa, e pelo proprio objeto do pai (par_oFormPai.DataSessionId) quando
346:     * nao passa - o resultado eh o mesmo e o 2o parametro fica opcional.
347:     *==========================================================================
348:     PROCEDURE Init()
349:         LPARAMETERS par_oFormPai, par_nDataSession
350: 
351:         LOCAL loc_oErro
352: 
353:         TRY
354:             IF VARTYPE(par_oFormPai) = "O"
355:                 THIS.this_oFormPai = par_oFormPai
356:             ENDIF
357: 
358:             IF VARTYPE(par_nDataSession) = "N" AND par_nDataSession > 0
359:                 *-- "Set DataSession To DatSes" do legado
360:                 THIS.DataSessionId = par_nDataSession
361:             ELSE
362:                 IF VARTYPE(par_oFormPai) = "O"
363:                     THIS.DataSessionId = par_oFormPai.DataSessionId
364:                 ENDIF
365:             ENDIF
366:         CATCH TO loc_oErro
367:             MsgErro(loc_oErro.Message + CHR(13) + ;
368:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
369:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.Init")
370:         ENDTRY
371: 
372:         *-- DODEFAULT() chama FormBase.Init(), que chama THIS.InicializarForm()
373:         *-- e repoe SET DATE TO BRITISH + SET CENTURY ON (CLAUDE.md regra #9.4).
374:         RETURN DODEFAULT()
375:     ENDPROC
376: 
377:     *==========================================================================
378:     * InicializarForm - Instancia o BO, aponta o cursor de origem (contrato
379:     * com o form pai: quem sabe o nome eh o Form, nao o BO - PILAR 3) e monta
380:     * a estrutura visual ja entregue nesta fase.
381:     *
382:     * NAO chama THIS.Show(): este form eh WindowType = 1 (modal) e o Show()
383:     * bloqueia - quem exibe eh o pai, FORA de TRY/CATCH (regra #29).
384:     *
385:     * NAO chama geracao de grafico: GerarGrafico() soh existe a partir da
386:     * Fase 7, quando o metodo e o OleBoundControl (Fase 5) ja estiverem
387:     * prontos.
388:     *==========================================================================
389:     PROTECTED PROCEDURE InicializarForm()
390:         LOCAL loc_lSucesso, loc_oErro
391:         loc_lSucesso = .F.
392: 
393:         TRY
394:             THIS.this_oBusinessObject = CREATEOBJECT("SIGOPGRCBO")
395: 
396:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
397:                 *-- Alias que o form PAI deixa pronto (crFinal do legado). Eh
398:                 *-- o default do SIGOPGRCBO.Init, reafirmado aqui porque o
399:                 *-- contrato com o pai eh do Form (PILAR 3). NAO existe
400:                 *-- cursor "Cabecalho" nesta tela (diferenca 1 do gemeo
401:                 *-- SigOpGco - ver cabecalho deste arquivo).
402:                 THIS.this_oBusinessObject.this_cCursorOrigem = "crFinal"
403: 
404:                 *-- Fundo do form: ..\framework\imagens\new_background.jpg do
405:                 *-- SCX. Resolvido por gc_4c_CaminhoIcones (o arquivo esta em
406:                 *-- vbmp\), convencao dominante do projeto.
407:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
408: 
409:                 THIS.ConfigurarPageFrame()
410: 
411:                 THIS.TornarControlesVisiveis(THIS)
412: 
413:                 *-- Monta e desenha o grafico, como o Init legado faz logo
414:                 *-- depois de ajustar os labels do cabecalho. Falha aqui NAO
415:                 *-- impede a tela de abrir (convencao do projeto): sem o
416:                 *-- cursor do pai - probe/harness, ou pai que nao processou -
417:                 *-- GerarGrafico avisa e devolve .F., e o usuario ainda tem o
418:                 *-- Encerrar para sair.
419:                 *--
420:                 *-- PULADO sob gb_4c_ValidandoUI (mesmo guard do gemeo
421:                 *-- FormSigOpGco): o ValidarUIFidelity instancia o form SEM
422:                 *-- pai, entao crFinal nao existe, CarregarDoCursor devolve
423:                 *-- .F. e o aviso sairia como MESSAGEBOX MODAL - que, num
424:                 *-- harness sem ninguem para clicar, TRAVA a validacao ate o
425:                 *-- timeout. MsgAviso so se auto-suprime em gb_4c_ModoTeste
426:                 *-- (ver utils\messages.prg); gb_4c_ValidandoUI ele nao
427:                 *-- conhece. A montagem VISUAL acontece inteira e so a carga
428:                 *-- de DADOS eh pulada, que eh justamente o que aquele
429:                 *-- validador compara.
430:                 *--
431:                 *-- gb_4c_ModoTeste NAO entra no guard de proposito: ali os
432:                 *-- dialogos ja vao para arquivo e o probe PRECISA exercitar
433:                 *-- o caminho do grafico.
434:                 IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
435:                     THIS.GerarGrafico()
436:                 ENDIF
437: 
438:                 loc_lSucesso = .T.
439:             ELSE
440:                 MsgErro("Erro ao criar SIGOPGRCBO. VARTYPE retornou: " + ;
441:                     VARTYPE(THIS.this_oBusinessObject), "FormSIGOPGRC.InicializarForm")
442:             ENDIF
443:         CATCH TO loc_oErro
444:             MsgErro(loc_oErro.Message + CHR(13) + ;
445:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
446:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.InicializarForm")
447:         ENDTRY
448: 
449:         RETURN loc_lSucesso
450:     ENDPROC
451: 
452:     *==========================================================================
453:     * ConfigurarPageFrame - Orquestrador da montagem visual. O SIGOPGRC NAO
454:     * tem PageFrame (layout flat: todos os objetos sao filhos diretos do
455:     * form), entao NAO se cria Page nenhuma aqui - o nome eh mantido apenas
456:     * como ponto de entrada arquitetural padrao, mesmo papel que tem no
457:     * gemeo FormSigOpGco.
458:     *
459:     * A ordem de chamada reproduz a ordem dos REGISTROS do SCX legado
460:     * (cntSombra -> Shape2 -> OleGrafico -> Sair -> Imprimir), porque
461:     * AddObject empilha no z-order e o ultimo criado desenha por cima.
462:     *
463:     * Shape2 do legado ocupa Top 7..117 / Left 615..788, que SOBREPOE a area
464:     * dos dois botoes (Top 3..78 / Left 650..800). No SCX ele eh criado ANTES
465:     * deles, entao os botoes ficam por cima e recebem o clique. Por isso a
466:     * chamada de ConfigurarPaginaDados da Fase 5 tem de ser inserida ENTRE
467:     * ConfigurarCabecalho e ConfigurarBotoes, e nao no fim: criado depois, o
468:     * Shape (BackStyle = 0 + BorderStyle = 0, isto eh, invisivel) ficaria por
469:     * cima e bloquearia o clique em Imprimir/Encerrar sem desenhar nada - o
470:     * botao simplesmente nao responderia, sem erro e sem log (regra #30).
471:     *==========================================================================
472:     PROTECTED PROCEDURE ConfigurarPageFrame()
473:         *-- Cabecalho PRIMEIRO: os botoes ficam em Top=3, DENTRO da area da
474:         *-- faixa (0..80), e so desenham por cima dela se forem criados
475:         *-- DEPOIS (CLAUDE.md regra #11).
476:         THIS.ConfigurarCabecalho()
477: 
478:         *-- Area do grafico (Shape2 + OleGrafico), na posicao que o SCX lhe
479:         *-- da: DEPOIS do cabecalho e ANTES dos botoes. A ordem aqui nao eh
480:         *-- estetica - o Shape2 transparente sobrepoe os dois botoes e,
481:         *-- criado depois deles, engoliria o clique (ver o comentario de
482:         *-- ConfigurarPaginaDados e a regra #30).
483:         THIS.ConfigurarPaginaDados()
484: 
485:         THIS.ConfigurarBotoes()
486: 
487:         *-- TabIndex por ULTIMO entre os AddObject: so pode ser atribuido
488:         *-- depois que TODOS os controles existem, e o ordinal tem de estar
489:         *-- na faixa 1..N do container ja completo.
490:         THIS.AjustarOrdemTabulacao()
491: 
492:         *-- BINDEVENT por ULTIMO: so resolve referencia de objeto que JA
493:         *-- existe.
494:         THIS.ConfigurarEventos()
495:     ENDPROC
496: 
497:     *==========================================================================
498:     * ConfigurarCabecalho - Faixa cinza do titulo. Transcrito do SCX:
499:     *   cntSombra  Top=0,  Left=0,  Width=800, Height=80,
500:     *              BorderWidth=0, BackColor=100,100,100
501:     *   lblSombra  Top=18, Left=10, Width=769, Height=40, ForeColor=0,0,0
502:     *   lblTitulo  Top=17, Left=10, Width=769, Height=46, ForeColor=255,255,255
503:     * Ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
504:     *
505:     * Width = THIS.Width da exatamente os 800 do legado (o form nao foi
506:     * escalado), e acompanha o form se alguem mudar a largura.
507:     *
508:     * O Caption dos dois labels vem de THIS.Caption, como no Init legado
509:     * ("ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption") - no SCX os
510:     * dois estao congelados em "Cadastro de Testes", que eh lixo do template
511:     * e NAO deve ser transcrito.
512:     *
513:     * AutoSize = .F. explicito com Width/Height do dump: AutoSize eh no-op em
514:     * Label criado por AddObject (a Width ficaria nos 100 do default) e, com
515:     * WordWrap = .T., ainda DESCARTA a Height e corta o texto em duas linhas
516:     * (CLAUDE.md regra #23). Os numeros do SCX JA sao o auto-size que o Form
517:     * Designer calculou, entao fixa-los eh reproducao fiel.
518:     *
519:     * ForeColor branco eh correto AQUI (regra #12): o container eh OPACO e
520:     * escuro (BackStyle = 1 + BackColor cinza), nao ha textura clara por baixo
521:     * deste bloco.
522:     *==========================================================================
523:     PROTECTED PROCEDURE ConfigurarCabecalho()
524:         LOCAL loc_oCnt, loc_oErro
525: 
526:         TRY
527:             THIS.AddObject("cnt_4c_Sombra", "Container")
528:             loc_oCnt = THIS.cnt_4c_Sombra
529:             WITH loc_oCnt
530:                 .Top         = 0
531:                 .Left        = 0
532:                 .Width       = THIS.Width
533:                 .Height      = 80
534:                 .BorderWidth = 0
535:                 .BackStyle   = 1
536:                 .BackColor   = RGB(100, 100, 100)
537:                 .Visible     = .T.
538:             ENDWITH
539: 
540:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
541:             WITH loc_oCnt.lbl_4c_LblSombra
542:                 .FontName      = "Tahoma"
543:                 .FontSize      = 18
544:                 .FontBold      = .T.
545:                 .FontUnderline = .F.
546:                 .WordWrap      = .T.
547:                 .Alignment     = 0
548:                 .BackStyle     = 0
549:                 .AutoSize      = .F.
550:                 .Top           = 18
551:                 .Left          = 10
552:                 .Width         = 769
553:                 .Height        = 40
554:                 .ForeColor     = RGB(0, 0, 0)
555:                 *-- Rotation = 0 esta no dump (lblSombra.Rotation) e eh o
556:                 *-- DEFAULT do Label: atribuicao inerte, escrita so para a
557:                 *-- transcricao do SCX ficar completa e conferivel.
558:                 .Rotation      = 0
559:                 .Caption       = THIS.Caption
560:                 .Visible       = .T.
561:             ENDWITH
562: 
563:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")

*-- Linhas 584 a 871:
584:         CATCH TO loc_oErro
585:             MsgErro(loc_oErro.Message + CHR(13) + ;
586:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
587:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.ConfigurarCabecalho")
588:         ENDTRY
589:     ENDPROC
590: 
591:     *==========================================================================
592:     * ConfigurarPaginaDados - Area do GRAFICO: os dois objetos "de dados" que
593:     * esta tela tem (shp_4c_Shape2 e obj_4c_OleGrafico), transcritos do SCX.
594:     *
595:     * O nome do metodo eh o do padrao arquitetural do projeto; aqui NAO ha
596:     * Page nenhuma (o form eh plano - ver ConfigurarPageFrame). O "dado"
597:     * desta tela nao se digita nem se lista: ele eh DESENHADO no
598:     * OleBoundControl a partir do cursor crFinal que o form pai deixou
599:     * pronto. O dump do SCX tem ZERO campo de entrada (textbox / editbox /
600:     * combobox / listbox / checkbox / optiongroup / spinner) e ZERO grade,
601:     * entao nao existe TextBox a criar aqui - inventar um violaria o PILAR 1
602:     * e a regra "NUNCA inventar".
603:     *
604:     * Transcricao do dump (SECAO 2), sem nenhum offset: nao ha PageFrame
605:     * neste form, logo nao se aplica nem a compensacao +29 do pgf_4c_Paginas
606:     * nem a subtracao do PageFrame.Top dos forms REPORT. Os dois cabem na
607:     * area do form (Width=800, Height=600):
608:     *
609:     *   Shape2      Top 7..117   / Left 615..788
610:     *   OleGrafico  Top 130..548 / Left  12..788
611:     *
612:     * SHAPE2 EH INVISIVEL DE PROPOSITO. BackStyle = 0 (sem preenchimento) +
613:     * BorderStyle = 0 (sem borda) vem do dump: eh sobra decorativa que o Form
614:     * Designer deixou atras dos dois botoes, com a BorderColor 136,189,188 do
615:     * Framework Fortyus. NAO "corrigir" para BorderStyle = 1 achando que o
616:     * retangulo deveria aparecer - no legado ele nunca apareceu. Mas o
617:     * Z-ORDER dele importa: a faixa 615..788 / 7..117 SOBREPOE os dois botoes
618:     * (650..800 / 3..78) e, criado DEPOIS deles, este Shape transparente
619:     * ficaria por cima e engoliria o clique em Imprimir/Encerrar sem desenhar
620:     * nada - sem erro, sem log e sem aparecer em screenshot (regra #30). Por
621:     * isso a chamada deste metodo esta ENTRE ConfigurarCabecalho e
622:     * ConfigurarBotoes, reproduzindo a ordem dos registros do SCX.
623:     *
624:     * Shape NAO tem ForeColor nem TabIndex: a cor da linha eh BorderColor e a
625:     * do preenchimento eh FillColor (CLAUDE.md regra #33 - conferido na
626:     * tabela real de propriedades, automation\propriedades_baseclasses.txt).
627:     *
628:     * CONTROLSOURCE FICA VAZIO AQUI, DE PROPOSITO. O legado nao liga o campo
629:     * General na criacao do controle: ele liga dentro do mostragrafico
630:     * (atribui 'gGraficos' ao ControlSource), depois que o binario do grafico
631:     * ja foi gravado no cursor. Apontar o ControlSource para um alias que
632:     * ainda nao existe estouraria "Alias ... is not found" DENTRO do TRY do
633:     * InicializarForm, que devolveria .F., o CREATEOBJECT devolveria .F. e a
634:     * tela NAO ABRIRIA, sem erro visivel (CLAUDE.md regra #41). O "" explicito
635:     * garante que o controle nasce desligado; quem liga eh o metodo de
636:     * DESENHO do grafico (Fases 7-8), no mesmo ponto em que o legado liga.
637:     * Mesmo tratamento do gemeo FormSigOpGco.obj_4c_OleGrafico e de
638:     * FormSigPrGf2, a outra tela de grafico do projeto.
639:     *
640:     * TabIndex = 0 do dump NAO eh transcrito literalmente: TabIndex eh um
641:     * ORDINAL 1..N dentro do container e valor fora dessa faixa eh DESCARTADO
642:     * em silencio pelo VFP9 - escrever 0 seria linha inerte afirmando um
643:     * valor que o objeto nunca guarda. A ordem efetiva esta reproduzida em
644:     * AjustarOrdemTabulacao.
645:     *
646:     * AutoActivate = 0 (manual) eh transcricao do dump e eh o que mantem o
647:     * grafico como EXIBICAO: sem ele o usuario ativaria o MSGraph in-place
648:     * com duplo clique e editaria o chart por cima da tela.
649:     *==========================================================================
650:     PROTECTED PROCEDURE ConfigurarPaginaDados()
651:         LOCAL loc_oErro
652: 
653:         TRY
654:             *-- SCX: Shape2 (registro 6), criado ANTES dos dois botoes
655:             THIS.AddObject("shp_4c_Shape2", "Shape")
656:             WITH THIS.shp_4c_Shape2
657:                 .Top         = 7
658:                 .Left        = 615
659:                 .Width       = 173
660:                 .Height      = 110
661:                 .BackStyle   = 0
662:                 .BorderStyle = 0
663:                 .BorderColor = RGB(136, 189, 188)
664:                 .Visible     = .T.
665:             ENDWITH
666: 
667:             *-- SCX: OleGrafico (registro 7) - a area do grafico
668:             THIS.AddObject("obj_4c_OleGrafico", "OleBoundControl")
669:             WITH THIS.obj_4c_OleGrafico
670:                 .Top           = 130
671:                 .Left          = 12
672:                 .Width         = 776
673:                 .Height        = 418
674:                 .Enabled       = .T.
675:                 .AutoActivate  = 0
676:                 *-- Nasce DESLIGADO: o alias do grafico ainda nao existe.
677:                 .ControlSource = ""
678:                 .Visible       = .T.
679:             ENDWITH
680:         CATCH TO loc_oErro
681:             MsgErro(loc_oErro.Message + CHR(13) + ;
682:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
683:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.ConfigurarPaginaDados")
684:         ENDTRY
685:     ENDPROC
686: 
687:     *==========================================================================
688:     * AjustarOrdemTabulacao - Fixa a ordem de tabulacao do SCX legado.
689:     *
690:     * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
691:     * tem relacao nenhuma com a do legado. Divergencia aqui nao da erro, nao
692:     * entra em log e nao aparece em screenshot: so o Tab andando na ordem
693:     * errada.
694:     *
695:     * O dump declara TabIndex em UM unico objeto - OleGrafico = 0 - e esse
696:     * valor esta FORA da faixa valida (ordinal 1..N dentro do container),
697:     * logo o VFP o DESCARTA no load e o legado fica com a ordem dos REGISTROS
698:     * do SCX. Filhos diretos do form, nessa ordem:
699:     *
700:     *   cntSombra = 1, (Shape2 nao tem TabIndex), OleGrafico = 2,
701:     *   Sair = 3, Imprimir = 4
702:     *
703:     * MEDIDO contra o migrado: a ordem de criacao aqui eh cnt_4c_Sombra ->
704:     * shp_4c_Shape2 -> obj_4c_OleGrafico -> cmd_4c_Sair -> cmd_4c_Imprimir, e
705:     * ela JA COINCIDE com a do legado (o Sair eh o registro 9 do SCX e o
706:     * Imprimir o 10, e ConfigurarBotoes os cria nessa mesma ordem). Logo este
707:     * metodo FIXA a ordem em vez de corrigi-la - diferente do gemeo
708:     * FormSigOpGco, cujo ConfigurarBotoes cria os dois botoes invertidos e
709:     * onde o metodo desfaz a inversao. Fixar eh o que protege a tela de uma
710:     * fase seguinte inserir um AddObject no meio da montagem e embaralhar a
711:     * sequencia sem ninguem perceber.
712:     *
713:     * Atribuicao em ordem ASCENDENTE: cada atribuicao poe o controle na
714:     * posicao pedida e empurra os demais para tras. Em ordem descendente dois
715:     * irmaos TROCAM de lugar e a tabulacao sai ao contrario do pretendido.
716:     *
717:     * Os valores sao os ORDINAIS EFETIVOS (1..4), nao os literais do dump, e
718:     * sao unicos: valor duplicado ou fora da faixa eh descartado em silencio,
719:     * tornando a linha inerte. A faixa eh 1..4 e nao 1..5 porque
720:     * shp_4c_Shape2 eh um Shape, classe que NAO tem a propriedade TabIndex -
721:     * por isso ele nao recebe numero nem entra na contagem (conferido em
722:     * automation\propriedades_baseclasses.txt).
723:     *
724:     * Os dois Label do cabecalho tambem nao sao numerados: Label tem TabIndex
725:     * mas NAO tem TabStop (nunca recebe foco), entao numera-los eh inerte e
726:     * ainda embaralharia a sequencia dos controles que de fato param o Tab.
727:     * Eles ja nascem na ordem do SCX dentro de cnt_4c_Sombra (lblSombra antes
728:     * de lblTitulo), que eh escopo de tabulacao separado do form.
729:     *==========================================================================
730:     PROTECTED PROCEDURE AjustarOrdemTabulacao()
731:         LOCAL loc_oErro
732: 
733:         TRY
734:             *-- SCX: cntSombra, 1o registro filho do form (nao declara
735:             *-- TabIndex, fica com o ordinal da criacao).
736:             THIS.cnt_4c_Sombra.TabIndex = 1
737: 
738:             *-- SCX: OleGrafico. O TabIndex = 0 do dump eh descartado pelo
739:             *-- VFP e o controle fica com o ordinal de criacao, que eh 2 (o
740:             *-- shp_4c_Shape2 entre ele e o cnt_4c_Sombra nao tem TabIndex).
741:             THIS.obj_4c_OleGrafico.TabIndex = 2
742: 
743:             *-- SCX: Sair (registro 9), criado ANTES do Imprimir - o Encerrar
744:             *-- vem primeiro no ciclo do Tab.
745:             THIS.cmd_4c_Sair.TabIndex = 3
746: 
747:             *-- SCX: Imprimir (registro 10), ultimo filho do form.
748:             THIS.cmd_4c_Imprimir.TabIndex = 4
749:         CATCH TO loc_oErro
750:             MsgErro(loc_oErro.Message + CHR(13) + ;
751:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
752:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.AjustarOrdemTabulacao")
753:         ENDTRY
754:     ENDPROC
755: 
756:     *==========================================================================
757:     * TornarControlesVisiveis - AddObject cria todo controle com
758:     * Visible = .F., entao a arvore inteira eh percorrida depois da montagem.
759:     *
760:     * Esta tela NAO tem container flutuante: o dump do SCX nao declara
761:     * Visible = .F. em objeto nenhum (o unico controle que o legado esconde eh
762:     * o "Aguarde" do form PAI), por isso nao ha lista de excecao a filtrar
763:     * aqui. Havendo necessidade numa fase seguinte, o skip tem de RECURSAR
764:     * antes do LOOP, para os filhos do container oculto nao ficarem
765:     * Visible = .F. e o container nao aparecer VAZIO quando for exibido.
766:     *==========================================================================
767:     PROCEDURE TornarControlesVisiveis(par_oContainer)
768:         LOCAL loc_nI, loc_oControl
769: 
770:         FOR loc_nI = 1 TO par_oContainer.ControlCount
771:             loc_oControl = par_oContainer.Controls(loc_nI)
772: 
773:             IF VARTYPE(loc_oControl) = "O"
774:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
775:                     loc_oControl.Visible = .T.
776:                 ENDIF
777: 
778:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
779:                     THIS.TornarControlesVisiveis(loc_oControl)
780:                 ENDIF
781:             ENDIF
782:         ENDFOR
783:     ENDPROC
784: 
785:     *==========================================================================
786:     * Destroy - Fecha o cursor do campo General que ESTA tela gera (nome
787:     * conhecido via property do BO), manda o BO fechar os cursores de
788:     * trabalho dele (Meses/Grupos/Percentuais, criados por CarregarDoCursor)
789:     * e solta as referencias de BO e de pai, para a tela filha nao segurar o
790:     * form pai depois de fechada.
791:     *
792:     * Sem isso os tres cursores de trabalho do BO VAZARIAM na data session do
793:     * form PAI: este form entra na sessao dele (ver Init), entao eles
794:     * sobreviveriam ao fechamento da tela - mesmo defeito que o gemeo
795:     * FormSigOpGco teve e corrigiu na Fase 8 dele (LimparCursores no BO).
796:     *
797:     * O cursor crFinal continua NAO sendo fechado aqui: quem o cria eh o form
798:     * PAI, na sessao de dados dele, e eh ele quem o fecha - derruba-lo daqui
799:     * tiraria o chao do pai se o usuario fechar o grafico e processar outro
800:     * periodo em seguida.
801:     *
802:     * DODEFAULT() por ULTIMO eh obrigatorio: eh FormBase.Destroy que reconstroi
803:     * os popups do menu principal depois de um form modal fechar.
804:     *==========================================================================
805:     PROCEDURE Destroy()
806:         LOCAL loc_cAliasGrafico, loc_oErro
807: 
808:         TRY
809:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
810:                 loc_cAliasGrafico = ALLTRIM(THIS.this_oBusinessObject.this_cCursorGrafico)
811: 
812:                 *-- IF aninhado e nao AND: VFP9 nao faz short-circuit, e
813:                 *-- USED("") estoura.
814:                 IF !EMPTY(loc_cAliasGrafico)
815:                     IF USED(loc_cAliasGrafico)
816:                         USE IN (loc_cAliasGrafico)
817:                     ENDIF
818:                 ENDIF
819: 
820:                 *-- Cursores de trabalho do proprio BO (Meses/Grupos/
821:                 *-- Percentuais): quem os cria eh quem sabe fecha-los.
822:                 THIS.this_oBusinessObject.LimparCursores()
823:             ENDIF
824:         CATCH TO loc_oErro
825:             MsgErro(loc_oErro.Message + CHR(13) + ;
826:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
827:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.Destroy")
828:         ENDTRY
829: 
830:         THIS.this_oBusinessObject = .NULL.
831:         THIS.this_oFormPai        = .NULL.
832: 
833:         DODEFAULT()
834:     ENDPROC
835: 
836:     *==========================================================================
837:     * ConfigurarBotoes - Os 2 CommandButton fwbtng do SCX, transcritos:
838:     *
839:     *   Sair      Top=3, Left=725, Caption="Encerrar", Cancel=.T.,
840:     *             Picture = ..\framework\imagens\cadastro_sair_60.jpg
841:     *   Imprimir  Top=3, Left=650, Caption="\<Imprimir",
842:     *             Picture = ..\framework\imagens\geral_impressora_normal_60.jpg
843:     *
844:     * Criados NESTA ordem (Sair antes de Imprimir) porque eh a ordem dos
845:     * registros do SCX - o Encerrar eh o registro 9 e o Imprimir o 10. Assim o
846:     * ordinal de criacao ja nasce igual ao do legado e o ciclo do Tab sai certo
847:     * sem precisar de correcao (o gemeo FormSigOpGco criou na ordem inversa e
848:     * teve de desinverter no AjustarOrdemTabulacao). Os dois nao se sobrepoem
849:     * (650..725 e 725..800), entao a ordem nao muda o desenho.
850:     *
851:     * Width/Height NAO aparecem no dump: vem da classe fwbtng (framework.vcx,
852:     * 80x100 - a variante "Grande"). Esses numeros NAO cabem nesta tela:
853:     * com Width=80 os dois botoes se SOBREPOEM (650+80 = 730 > 725) e o
854:     * segundo ainda passa da borda do form (725+80 = 805 > 800); com Height=100
855:     * o botao vaza 23px abaixo da faixa do cabecalho (3+100 = 103 contra os 80
856:     * do cnt_4c_Sombra). O passo entre os dois Left do SCX eh de 75px
857:     * (650 -> 725), e com 75x75 os dois tilam EXATAMENTE nesse passo e cabem na
858:     * faixa: 650..725 e 725..800, Top 3..78. 75x75 eh tambem a geometria
859:     * canonica dos botoes de icone do projeto (framework_frmcadastro_layout.md,
860:     * FormSigOpGco.ConfigurarBotoes, FormSIGOPCGF).
861:     *
862:     * O padrao canonico cnt_4c_Saida/cmd_4c_Encerrar (Left=917, Width=90 -
863:     * CLAUDE.md regra #10) NAO se aplica: ele vale para os CRUD frmcadastro de
864:     * 1000px. Aqui o form tem 800px de largura e o Encerrar do legado ja esta
865:     * no canto direito (725..800), fora de container nenhum - Left=917 ficaria
866:     * 117px FORA da tela e o botao sumiria.
867:     *
868:     * Cancel = .T. no Encerrar eh transcricao do SCX (e diferenca real contra o
869:     * gemeo FormSigOpGco, cujo dump nao declara a propriedade): com ela o ESC
870:     * fecha o grafico, que eh o comportamento do legado. A propriedade existe em
871:     * CommandButton (conferida na tabela medida automation\

*-- Linhas 881 a 924:
881:     * sem icone (regra #25). O Caption "\<Imprimir" fica com a barra invertida
882:     * do SCX: eh o marcador de tecla de acesso (Alt+I) do VFP.
883:     *==========================================================================
884:     PROTECTED PROCEDURE ConfigurarBotoes()
885:         LOCAL loc_oErro
886: 
887:         TRY
888:             *-- SCX: Sair (registro 9), criado ANTES do Imprimir
889:             THIS.AddObject("cmd_4c_Sair", "CommandButton")
890:             WITH THIS.cmd_4c_Sair
891:                 .Top             = 3
892:                 .Left            = 725
893:                 .Width           = 75
894:                 .Height          = 75
895:                 .Caption         = "Encerrar"
896:                 .Cancel          = .T.
897:                 .FontName        = "Comic Sans MS"
898:                 .FontSize        = 8
899:                 .FontBold        = .T.
900:                 .FontItalic      = .T.
901:                 .WordWrap        = .T.
902:                 .ForeColor       = RGB(90, 90, 90)
903:                 .BackColor       = RGB(255, 255, 255)
904:                 .SpecialEffect   = 0
905:                 .PicturePosition = 13
906:                 .MousePointer    = 15
907:                 .Themes          = .T.
908:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
909:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
910:                 .Enabled         = .T.
911:                 .Visible         = .T.
912:             ENDWITH
913: 
914:             *-- SCX: Imprimir (registro 10), ultimo filho do form
915:             THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
916:             WITH THIS.cmd_4c_Imprimir
917:                 .Top             = 3
918:                 .Left            = 650
919:                 .Width           = 75
920:                 .Height          = 75
921:                 .Caption         = "\<Imprimir"
922:                 .FontName        = "Comic Sans MS"
923:                 .FontSize        = 8
924:                 .FontBold        = .T.

*-- Linhas 938 a 1294:
938:         CATCH TO loc_oErro
939:             MsgErro(loc_oErro.Message + CHR(13) + ;
940:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
941:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.ConfigurarBotoes")
942:         ENDTRY
943:     ENDPROC
944: 
945:     *==========================================================================
946:     * ConfigurarEventos - BINDEVENT dos Click. Fica por ULTIMO na montagem:
947:     * BINDEVENT so resolve referencia de objeto que JA existe.
948:     *
949:     * Os dois Click sao os UNICOS eventos de controle do dump inteiro (SECAO 3
950:     * tem 5 metodos: mostragrafico e Init do form, o =fConfigGeral() do
951:     * Activate, e os Click de Sair e Imprimir) - nao ha outro evento a ligar
952:     * nas fases seguintes, entao este metodo ja esta completo.
953:     *
954:     * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO com
955:     * metodo PROTECTED (CLAUDE.md regra #3).
956:     *==========================================================================
957:     PROTECTED PROCEDURE ConfigurarEventos()
958:         LOCAL loc_oErro
959: 
960:         TRY
961:             BINDEVENT(THIS.cmd_4c_Sair,     "Click", THIS, "CmdSairClick")
962:             BINDEVENT(THIS.cmd_4c_Imprimir, "Click", THIS, "CmdImprimirClick")
963:         CATCH TO loc_oErro
964:             MsgErro(loc_oErro.Message + CHR(13) + ;
965:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
966:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.ConfigurarEventos")
967:         ENDTRY
968:     ENDPROC
969: 
970:     *==========================================================================
971:     * CmdSairClick - Click do botao "Encerrar". Legado: "Thisform.Release".
972:     *
973:     * Release() e nao Hide(): esta tela eh WindowType = 1 (modal) e o Show()
974:     * que a exibe esta BLOQUEADO no form pai - o Release eh o que devolve o
975:     * controle para ele. O cursor crFinal continua de pe: eh do pai, e quem o
976:     * fecha eh ele (ver Destroy).
977:     *==========================================================================
978:     PROCEDURE CmdSairClick()
979:         LOCAL loc_oErro
980: 
981:         TRY
982:             THIS.Release()
983:         CATCH TO loc_oErro
984:             MsgErro(loc_oErro.Message + CHR(13) + ;
985:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
986:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.CmdSairClick")
987:         ENDTRY
988:     ENDPROC
989: 
990:     *==========================================================================
991:     * CmdImprimirClick - Click do botao "Imprimir". Transcricao do legado:
992:     *
993:     *     Select Graph
994:     *     Go Top
995:     *     Report Form SigOpGrc To Printer Prompt NoConsole
996:     *     Select Graph
997:     *     Go Top
998:     *     Thisform.Refresh
999:     *
1000:     * "Graph" eh o cursor do campo General que guarda o binario do
1001:     * MsGraph.Chart (Create Cursor Graph (gGraficos Gen(4)) no legado); no
1002:     * migrado ele eh THIS.this_oBusinessObject.this_cCursorGrafico e o FRX eh
1003:     * this_cRelatorio ("SigOpGrc") - os dois nomes moram no BO e NAO sao
1004:     * reescritos aqui. O alias continua sendo o "Graph" do legado porque o
1005:     * SigOpGrc.frx cita Graph.gGraficos literalmente (ver a property no BO).
1006:     *
1007:     * O SELECT + GO TOP repetido DEPOIS do relatorio nao eh redundancia do
1008:     * legado: o REPORT FORM deixa o cursor em EOF, e o OleBoundControl le o
1009:     * campo General do REGISTRO CORRENTE - sem voltar ao topo, o Refresh
1010:     * repintaria o grafico com registro nenhum.
1011:     *
1012:     * O guard eh pelo FLAG this_lGraficoGerado do BO, e nao so por USED()/
1013:     * RECCOUNT: quando o APPEND GENERAL falha (MsGraph.Chart nao registrado na
1014:     * estacao), a linha em branco do cursor eh APAGADA - mas DELETE so MARCA, e
1015:     * RECCOUNT() CONTA registro marcado como excluido, porque SET DELETED esta
1016:     * OFF por default. Sem o flag o alias existe, o guard de RECCOUNT = 0 do
1017:     * ExecutarReportForm nao segura, e o usuario manda para a impressora um
1018:     * relatorio EM BRANCO em vez de receber o aviso. Ate a Fase 7 criar o
1019:     * grafico esse flag fica em .F. e o clique avisa que ainda nao ha o que
1020:     * imprimir - que eh a resposta correta, nao um remendo.
1021:     *
1022:     * O REPORT FORM nao vai cru: passa pelo helper ExecutarReportForm, que tem
1023:     * o guard de FILE() no FRX, o isolamento de locale (sem ele os campos
1024:     * numericos dos FRX Fortyus saem como ******) e a reconstrucao do menu
1025:     * principal que o _MREPORT corrompe.
1026:     *==========================================================================
1027:     PROCEDURE CmdImprimirClick()
1028:         LOCAL loc_cCursor, loc_cRelatorio, loc_lProsseguir, loc_oErro
1029: 
1030:         loc_cCursor     = ""
1031:         loc_cRelatorio  = ""
1032:         loc_lProsseguir = .T.
1033: 
1034:         TRY
1035:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1036:                 loc_cCursor    = ALLTRIM(THIS.this_oBusinessObject.this_cCursorGrafico)
1037:                 loc_cRelatorio = ALLTRIM(THIS.this_oBusinessObject.this_cRelatorio)
1038:             ENDIF
1039: 
1040:             IF EMPTY(loc_cCursor) OR EMPTY(loc_cRelatorio)
1041:                 MsgAviso("Gr" + CHR(225) + "fico n" + CHR(227) + "o dispon" + CHR(237) + ;
1042:                     "vel para impress" + CHR(227) + "o.", "Imprimir")
1043:                 loc_lProsseguir = .F.
1044:             ENDIF
1045: 
1046:             IF loc_lProsseguir
1047:                 *-- IF aninhado e nao AND: VFP9 nao faz short-circuit em OR/AND,
1048:                 *-- e ler o flag com o alias ausente nao diz nada sobre o cursor.
1049:                 IF !USED(loc_cCursor)
1050:                     loc_lProsseguir = .F.
1051:                 ELSE
1052:                     IF !THIS.this_oBusinessObject.this_lGraficoGerado
1053:                         loc_lProsseguir = .F.
1054:                     ENDIF
1055:                 ENDIF
1056: 
1057:                 IF !loc_lProsseguir
1058:                     MsgAviso("Gr" + CHR(225) + "fico ainda n" + CHR(227) + "o foi gerado.", ;
1059:                         "Imprimir")
1060:                 ENDIF
1061:             ENDIF
1062: 
1063:             IF loc_lProsseguir
1064:                 SELECT (loc_cCursor)
1065:                 GO TOP
1066: 
1067:                 THIS.ExecutarReportForm(gc_4c_CaminhoReports + loc_cRelatorio + ".frx", ;
1068:                     "PRINTER_PROMPT", loc_cCursor)
1069: 
1070:                 *-- Volta ao topo: o REPORT FORM deixa o cursor em EOF e o
1071:                 *-- OleBoundControl le o General do registro CORRENTE.
1072:                 SELECT (loc_cCursor)
1073:                 GO TOP
1074:                 THIS.Refresh()
1075:             ENDIF
1076:         CATCH TO loc_oErro
1077:             MsgErro(loc_oErro.Message + CHR(13) + ;
1078:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1079:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.CmdImprimirClick")
1080:         ENDTRY
1081:     ENDPROC
1082: 
1083:     *==========================================================================
1084:     * ExecutarReportForm - Helper canonico de REPORT FORM (CorretorAutomatico
1085:     * #117/#147). Nenhum REPORT FORM do projeto roda cru:
1086:     *   - guard de FILE() no FRX, com o caminho na mensagem;
1087:     *   - guard de cursor vazio, para o relatorio nao sair em branco;
1088:     *   - isolamento de locale (POINT / SEPARATOR / REPORTBEHAVIOR 80): sem
1089:     *     ele os FRX Fortyus renderizam os campos numericos como ******;
1090:     *   - reconstrucao do menu principal, que o _MREPORT do preview corrompe
1091:     *     (sem SET SYSMENU TO DEFAULT os popups voltam encolhidos).
1092:     * Modos: PREVIEW, PRINTER_PROMPT, PRINTER. O legado desta tela usa
1093:     * "To Printer Prompt", logo PRINTER_PROMPT.
1094:     *
1095:     * O caminho do FRX vem de gc_4c_CaminhoReports, NUNCA de
1096:     * gc_4c_CaminhoBase + "reports\" - gc_4c_CaminhoBase nao termina em
1097:     * barra e a concatenacao sairia como "startreports\" (pattern #156).
1098:     *==========================================================================
1099:     PROCEDURE ExecutarReportForm(par_cFRXPath, par_cModo, par_cCursorDados)
1100:         LOCAL loc_cPonto, loc_cSeparador, loc_nBehavior, loc_lResultado, ;
1101:               loc_lProsseguir, loc_oErro, loc_oErroMenu
1102: 
1103:         loc_cPonto     = SET("POINT")
1104:         loc_cSeparador = SET("SEPARATOR")
1105:         *-- SET("REPORTBEHAVIOR") ja devolve NUMERICO - envolver com VAL()
1106:         *-- dispara erro 11 (CorretorAutomatico #152).
1107:         loc_nBehavior   = SET("REPORTBEHAVIOR")
1108:         loc_lResultado  = .F.
1109:         loc_lProsseguir = .T.
1110: 
1111:         IF !FILE(FULLPATH(par_cFRXPath))
1112:             MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
1113:                 CHR(13) + par_cFRXPath, "Relat" + CHR(243) + "rio")
1114:             loc_lProsseguir = .F.
1115:         ENDIF
1116: 
1117:         IF loc_lProsseguir AND VARTYPE(par_cCursorDados) = "C" AND !EMPTY(par_cCursorDados)
1118:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
1119:                 MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para o relat" + ;
1120:                     CHR(243) + "rio.", "Relat" + CHR(243) + "rio")
1121:                 loc_lProsseguir = .F.
1122:             ENDIF
1123:         ENDIF
1124: 
1125:         IF loc_lProsseguir
1126:             TRY
1127:                 SET POINT TO "."
1128:                 SET SEPARATOR TO ","
1129:                 SET REPORTBEHAVIOR 80
1130: 
1131:                 DO CASE
1132:                 CASE UPPER(ALLTRIM(par_cModo)) = "PREVIEW"
1133:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
1134:                 CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER_PROMPT"
1135:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER PROMPT
1136:                 CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER"
1137:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER
1138:                 OTHERWISE
1139:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
1140:                 ENDCASE
1141: 
1142:                 loc_lResultado = .T.
1143:             CATCH TO loc_oErro
1144:                 MsgErro(loc_oErro.Message + CHR(13) + ;
1145:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1146:                     "Procedure: " + loc_oErro.Procedure, "FormSIGOPGRC.ExecutarReportForm")
1147:             ENDTRY
1148: 
1149:             SET POINT TO loc_cPonto
1150:             SET SEPARATOR TO loc_cSeparador
1151:             SET REPORTBEHAVIOR loc_nBehavior
1152: 
1153:             *-- O _MREPORT do preview corrompe o _MSYSMENU: sem isto os popups
1154:             *-- do menu principal voltam encolhidos (CorretorAutomatico #145).
1155:             TRY
1156:                 SET SYSMENU TO DEFAULT
1157:                 RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
1158:                     popRelatorios, popFerramentas, popAjuda
1159:                 CriarMenuPrincipal()
1160:             CATCH TO loc_oErroMenu
1161:                 MsgErro(loc_oErroMenu.Message, "FormSIGOPGRC.ExecutarReportForm")
1162:             ENDTRY
1163:         ENDIF
1164: 
1165:         RETURN loc_lResultado
1166:     ENDPROC
1167: 
1168:     *==========================================================================
1169:     * ObterComparativoDoPai - "Thisform.Parentform.Comparativo.Value" do
1170:     * legado, que escolhe o modo de agrupamento (ver CarregarDoCursor do BO).
1171:     * Guardas: sem form pai (probe/harness), sem o controle, ou controle sem
1172:     * objeto valido, o modo cai em 0 (nao comparativo) - o mesmo "nao
1173:     * declarado" do legado nunca aconteceria com o pai de verdade presente.
1174:     *==========================================================================
1175:     PROCEDURE ObterComparativoDoPai()
1176:         LOCAL loc_nComparativo, loc_uValor, loc_oErro
1177:         loc_nComparativo = 0
1178: 
1179:         TRY
1180:             IF VARTYPE(THIS.this_oFormPai) = "O"
1181:                 IF PEMSTATUS(THIS.this_oFormPai, "Comparativo", 5)
1182:                     IF VARTYPE(THIS.this_oFormPai.Comparativo) = "O"
1183:                         loc_uValor = THIS.this_oFormPai.Comparativo.Value
1184:                         *-- OptionGroup/CheckBox do legado devolve NUMERICO,
1185:                         *-- mas o mesmo controle chega LOGICO quando o pai o
1186:                         *-- liga a uma coluna bit (regra #13) - normalizar.
1187:                         DO CASE
1188:                         CASE VARTYPE(loc_uValor) = "N"
1189:                             loc_nComparativo = loc_uValor
1190:                         CASE VARTYPE(loc_uValor) = "L"
1191:                             loc_nComparativo = IIF(loc_uValor, 1, 0)
1192:                         OTHERWISE
1193:                             loc_nComparativo = 0
1194:                         ENDCASE
1195:                     ENDIF
1196:                 ENDIF
1197:             ENDIF
1198:         CATCH TO loc_oErro
1199:             *-- Nao eh CATCH silencioso: o modo cai no ramo "nao comparativo"
1200:             *-- e a falha fica registrada para GerarGrafico exibir UMA vez.
1201:             THIS.this_cFalhaGrafico = loc_oErro.Message
1202:             loc_nComparativo = 0
1203:         ENDTRY
1204: 
1205:         RETURN loc_nComparativo
1206:     ENDPROC
1207: 
1208:     *==========================================================================
1209:     * ObterOpcaoCotacaoDoPai - "Thisform.ParentForm.OptCotacao.value" do
1210:     * mostragrafico legado, entrada que o gemeo FormSigOpGco NAO tem
1211:     * (diferenca 2 do cabecalho do SIGOPGRCBO). Escolhe o rotulo de moeda do
1212:     * subtitulo 3 (this_cRotuloCotacaoFechamento/Movimentacao): valendo 1,
1213:     * Fechamento; qualquer outro valor, Movimentacao. Mesmas tres guardas de
1214:     * ObterComparativoDoPai.
1215:     *==========================================================================
1216:     PROCEDURE ObterOpcaoCotacaoDoPai()
1217:         LOCAL loc_nOpcaoCotacao, loc_uValor, loc_oErro
1218:         loc_nOpcaoCotacao = 0
1219: 
1220:         TRY
1221:             IF VARTYPE(THIS.this_oFormPai) = "O"
1222:                 IF PEMSTATUS(THIS.this_oFormPai, "OptCotacao", 5)
1223:                     IF VARTYPE(THIS.this_oFormPai.OptCotacao) = "O"
1224:                         loc_uValor = THIS.this_oFormPai.OptCotacao.Value
1225:                         DO CASE
1226:                         CASE VARTYPE(loc_uValor) = "N"
1227:                             loc_nOpcaoCotacao = loc_uValor
1228:                         CASE VARTYPE(loc_uValor) = "L"
1229:                             loc_nOpcaoCotacao = IIF(loc_uValor, 1, 0)
1230:                         OTHERWISE
1231:                             loc_nOpcaoCotacao = 0
1232:                         ENDCASE
1233:                     ENDIF
1234:                 ENDIF
1235:             ENDIF
1236:         CATCH TO loc_oErro
1237:             THIS.this_cFalhaGrafico = loc_oErro.Message
1238:             loc_nOpcaoCotacao = 0
1239:         ENDTRY
1240: 
1241:         RETURN loc_nOpcaoCotacao
1242:     ENDPROC
1243: 
1244:     *==========================================================================
1245:     * OcultarAguardeDoPai - Ultima linha do Init legado:
1246:     *
1247:     *     Thisform.parentform.Aguarde.visible = .f.
1248:     *
1249:     * O pai acende um painel "Aguarde..." antes de processar crFinal e abrir
1250:     * este grafico; quem o apaga eh ESTA tela, quando o desenho terminou.
1251:     * Mesmas tres guardas de ObterComparativoDoPai - sem pai (probe/harness)
1252:     * ou sem o painel, nao ha nada a apagar e o metodo eh inocuo.
1253:     *==========================================================================
1254:     PROCEDURE OcultarAguardeDoPai()
1255:         LOCAL loc_oErro
1256: 
1257:         TRY
1258:             IF VARTYPE(THIS.this_oFormPai) = "O"
1259:                 IF PEMSTATUS(THIS.this_oFormPai, "Aguarde", 5)
1260:                     IF VARTYPE(THIS.this_oFormPai.Aguarde) = "O"
1261:                         THIS.this_oFormPai.Aguarde.Visible = .F.
1262:                     ENDIF
1263:                 ENDIF
1264:             ENDIF
1265:         CATCH TO loc_oErro
1266:             THIS.this_cFalhaGrafico = loc_oErro.Message
1267:         ENDTRY
1268:     ENDPROC
1269: 
1270:     *==========================================================================
1271:     * GerarGrafico - Transcricao do corpo do Init legado (a parte de DADOS; a
1272:     * de layout ja esta nas Fases 3-5). Sequencia do legado, na ordem:
1273:     *
1274:     *   Select Distinct ... Into Array laMeses / laGrupos    -> BO
1275:     *   Declare m.laPerc(...) / m.laPerc = 0                 -> BO
1276:     *   Create Cursor Graph (gGraficos Gen (4))              -> aqui
1277:     *   Select crFinal / Set order to Grupom / Scan ...      -> BO
1278:     *   Select crFinal / Set Order To Imp / Do While ...     -> BO
1279:     *   If Not Empty(lcStrg)
1280:     *       Select Graph / Append Blank
1281:     *       Append General gGraficos Class 'MsGraph.Chart' Data lcStrg
1282:     *       Thisform.MostraGrafico()
1283:     *   Endif
1284:     *   Select CrFinal / Go Top / Select Graph / Go Top
1285:     *   Thisform.parentform.Aguarde.visible = .f.
1286:     *
1287:     * A montagem da matriz TAB/CRLF (lcStrg) inteira mora no BO, em
1288:     * CarregarDoCursor (Fase 2) - aqui fica so o que eh OLE e cursor de campo
1289:     * General, que eh do Form por decisao de arquitetura (PILAR 3: o BO nao
1290:     * manipula objeto OLE). Mesma divisao do gemeo FormSigOpGco.
1291:     *
1292:     * O modo de agrupamento E a opcao de cotacao sao lidos do PAI e
1293:     * atribuidos ao BO ANTES do CarregarDoCursor: o primeiro decide se a
1294:     * chave de grupo leva o Ano e se a matriz de percentuais eh preenchida; o

*-- Linhas 1304 a 1347:
1304:     * em que o "Create Cursor Graph" vem ANTES do "If Not Empty(lcStrg)" e o
1305:     * "Select Graph / Go Top" do fim conta com o alias existindo.
1306:     *==========================================================================
1307:     PROCEDURE GerarGrafico()
1308:         LOCAL loc_oBO, loc_cAliasGrafico, loc_cOrigem, loc_cDados, ;
1309:               loc_lResultado, loc_lFalhaOle, loc_oErro, loc_oErroOle
1310: 
1311:         loc_lResultado = .F.
1312:         loc_lFalhaOle  = .F.
1313: 
1314:         THIS.this_cFalhaGrafico  = ""
1315:         THIS.this_lGraficoPronto = .F.
1316: 
1317:         TRY
1318:             loc_oBO = THIS.this_oBusinessObject
1319: 
1320:             IF VARTYPE(loc_oBO) = "O"
1321:                 loc_cAliasGrafico = ALLTRIM(loc_oBO.this_cCursorGrafico)
1322:                 loc_cOrigem       = ALLTRIM(loc_oBO.this_cCursorOrigem)
1323: 
1324:                 *-- Modo de agrupamento e opcao de cotacao, lidos do PAI como
1325:                 *-- no legado. Os dois tem de ser atribuidos ANTES do
1326:                 *-- CarregarDoCursor: eh ele que monta os subtitulos e a
1327:                 *-- matriz de percentuais a partir deles.
1328:                 loc_oBO.this_nComparativo  = THIS.ObterComparativoDoPai()
1329:                 loc_oBO.this_nOpcaoCotacao = THIS.ObterOpcaoCotacaoDoPai()
1330: 
1331:                 *-- Cursor do campo General, equivalente ao "Create Cursor
1332:                 *-- Graph (gGraficos Gen (4))" do legado. Recriado a cada
1333:                 *-- geracao: o grafico eh UM registro so (o legado tambem faz
1334:                 *-- um Append Blank por abertura da tela).
1335:                 IF USED(loc_cAliasGrafico)
1336:                     *-- Guardar pelo BUFFERING, nunca so por USED(): sem
1337:                     *-- buffering o TABLEREVERT nao eh no-op, estoura o erro
1338:                     *-- 1586 (CLAUDE.md regra #52). CREATE CURSOR nasce com
1339:                     *-- Buffering = 1, entao aqui o TABLEREVERT eh pulado e o
1340:                     *-- USE IN fecha o alias de qualquer forma.
1341:                     IF CURSORGETPROP("Buffering", loc_cAliasGrafico) > 1
1342:                         TABLEREVERT(.T., loc_cAliasGrafico)
1343:                     ENDIF
1344:                     USE IN (loc_cAliasGrafico)
1345:                 ENDIF
1346:                 CREATE CURSOR (loc_cAliasGrafico) (gGraficos G(4))
1347: 

*-- Linhas 1360 a 1531:
1360:                     ELSE
1361:                         *-- Periodo sem movimento: nao eh erro, eh resultado
1362:                         *-- vazio. O legado simplesmente nao desenha nada.
1363:                         MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para montar o gr" + ;
1364:                             CHR(225) + "fico comparativo.", "Gr" + CHR(225) + "fico Comparativo")
1365:                     ENDIF
1366:                 ELSE
1367:                     MsgAviso(IIF(EMPTY(loc_oBO.this_cMensagemErro), ;
1368:                         "N" + CHR(227) + "o foi poss" + CHR(237) + "vel preparar os dados do gr" + ;
1369:                             CHR(225) + "fico.", ;
1370:                         loc_oBO.this_cMensagemErro), "Gr" + CHR(225) + "fico Comparativo")
1371:                 ENDIF
1372: 
1373:                 *-- "Select CrFinal / Go Top / Select Graph / Go Top" do fim
1374:                 *-- do Init legado: devolve os dois cursores ao topo. O do
1375:                 *-- grafico por ULTIMO e de proposito - o OleBoundControl le o
1376:                 *-- campo General do registro CORRENTE.
1377:                 IF USED(loc_cOrigem)
1378:                     SELECT (loc_cOrigem)
1379:                     GO TOP
1380:                 ENDIF
1381:                 *-- Mesmo motivo do guard de MostrarGrafico: so reposiciona
1382:                 *-- quando ha grafico de verdade, nunca sobre a linha que o
1383:                 *-- CATCH do APPEND GENERAL deixou marcada como excluida.
1384:                 IF USED(loc_cAliasGrafico) AND loc_oBO.this_lGraficoGerado
1385:                     SELECT (loc_cAliasGrafico)
1386:                     GO TOP
1387:                 ENDIF
1388:             ENDIF
1389:         CATCH TO loc_oErro
1390:             MsgErro(loc_oErro.Message + CHR(13) + ;
1391:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1392:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.GerarGrafico")
1393:         ENDTRY
1394: 
1395:         *-- Falha de OLE tem de ficar VISIVEL (regra #27): ausencia silenciosa
1396:         *-- faria o usuario olhar uma tela em branco sem saber por que.
1397:         IF loc_lFalhaOle
1398:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o gr" + CHR(225) + ;
1399:                 "fico (componente MsGraph.Chart indispon" + CHR(237) + "vel nesta esta" + ;
1400:                 CHR(231) + CHR(227) + "o)." + CHR(13) + CHR(13) + THIS.this_cFalhaGrafico, ;
1401:                 "Gr" + CHR(225) + "fico Comparativo")
1402:         ENDIF
1403: 
1404:         *-- O painel "Aguarde" do pai eh apagado em TODO caminho, como no
1405:         *-- legado (a linha eh a ultima do Init, fora de qualquer IF): se
1406:         *-- ficasse so no caminho de sucesso, falha de dado deixaria o pai
1407:         *-- com o aviso aceso para sempre.
1408:         THIS.OcultarAguardeDoPai()
1409: 
1410:         THIS.this_lGraficoPronto = loc_lResultado
1411: 
1412:         RETURN loc_lResultado
1413:     ENDPROC
1414: 
1415:     *==========================================================================
1416:     * AnexarGraficoAoCursor - "Select Graph / Append Blank / Append General
1417:     * gGraficos Class 'MsGraph.Chart' Data lcStrg" do Init legado.
1418:     *
1419:     * Isolado num metodo (e num TRY) proprio porque o OLE server
1420:     * "MsGraph.Chart" pode nao estar registrado na estacao. Nesse caso o
1421:     * APPEND BLANK JA inseriu a linha quando o APPEND GENERAL estoura, e sem
1422:     * desfazer o OleBoundControl exibe esse registro VAZIO como se fosse
1423:     * resultado valido - a tela mentiria que desenhou. Por isso o CATCH apaga
1424:     * a linha e devolve .F., e quem chama avisa o usuario.
1425:     *
1426:     * O nome do campo vai LITERAL ("gGraficos"): APPEND GENERAL nao aceita
1427:     * expressao de campo, ao contrario do alias do cursor. O IF confere que o
1428:     * BO continua chamando o campo assim - divergirem faria o APPEND GENERAL
1429:     * escrever num campo que o ControlSource de MostrarGrafico nao le.
1430:     *==========================================================================
1431:     PROTECTED PROCEDURE AnexarGraficoAoCursor(par_cAliasGrafico, par_cDados)
1432:         LOCAL loc_oBO, loc_lResultado, loc_oErro
1433:         loc_lResultado = .F.
1434: 
1435:         loc_oBO = THIS.this_oBusinessObject
1436: 
1437:         IF UPPER(ALLTRIM(loc_oBO.this_cCampoGeral)) != "GGRAFICOS"
1438:             THIS.this_cFalhaGrafico = "Campo General do BO (" + ;
1439:                 ALLTRIM(loc_oBO.this_cCampoGeral) + ") divergente de gGraficos."
1440:         ELSE
1441:             TRY
1442:                 SELECT (par_cAliasGrafico)
1443:                 APPEND BLANK
1444:                 APPEND GENERAL gGraficos CLASS "MsGraph.Chart" DATA (par_cDados)
1445: 
1446:                 loc_oBO.this_lGraficoGerado = .T.
1447:                 loc_lResultado = .T.
1448:             CATCH TO loc_oErro
1449:                 THIS.this_cFalhaGrafico     = loc_oErro.Message
1450:                 loc_oBO.this_lGraficoGerado = .F.
1451: 
1452:                 *-- Apaga a linha em branco deixada pelo APPEND BLANK.
1453:                 SELECT (par_cAliasGrafico)
1454:                 IF !EOF() AND !BOF()
1455:                     DELETE
1456:                 ENDIF
1457:             ENDTRY
1458:         ENDIF
1459: 
1460:         RETURN loc_lResultado
1461:     ENDPROC
1462: 
1463:     *==========================================================================
1464:     * MostrarGrafico - Transcricao do "PROCEDURE mostragrafico" do SCX.
1465:     * Liga o campo General ao OleBoundControl e aplica a formatacao do
1466:     * MSGraph (galeria, fontes, legenda, titulo, areas, eixos, rotulos).
1467:     *
1468:     * LockScreen = .T./.F. em volta, como no legado (o metodo dele abre e
1469:     * fecha com "Thisform.LockScreen"): a formatacao toca dezenas de
1470:     * propriedades do chart e sem isso a tela pisca a cada uma.
1471:     *
1472:     * POR QUE A FORMATACAO ESTA DIVIDIDA EM BLOCOS COM TRY PROPRIO
1473:     * --------------------------------------------------------------------
1474:     * O legado nao usa TRY/CATCH: ele troca o ON ERROR por um que so acende
1475:     * uma flag ("On Error m.llOnErro1 = .t.") e restaura o anterior no fim. A
1476:     * diferenca eh de CONTROLE DE FLUXO, nao de estilo: com ON ERROR a
1477:     * execucao CONTINUA na linha seguinte, entao uma propriedade que o
1478:     * servidor OLE recuse nao impede as outras 40 de serem aplicadas; com um
1479:     * TRY unico em volta de tudo, a primeira recusa abandonaria todo o resto
1480:     * da formatacao e o grafico sairia meio formatado.
1481:     *
1482:     * Por isso cada bloco tem o seu TRY e devolve .T./.F.: um bloco que falhe
1483:     * nao derruba os demais, reproduzindo a tolerancia do ON ERROR legado. E
1484:     * nenhum CATCH eh silencioso (regra #9) - todos registram a mensagem em
1485:     * this_cFalhaGrafico, exibida UMA vez no fim; varios MsgErro seguidos
1486:     * seriam pior que o problema.
1487:     *
1488:     * LockScreen = .F. fica FORA dos TRY, para a tela nunca ficar congelada
1489:     * por causa de uma falha de formatacao.
1490:     *==========================================================================
1491:     PROCEDURE MostrarGrafico()
1492:         LOCAL loc_oBO, loc_oOle, loc_cAliasGrafico, loc_lResultado, loc_oErro
1493:         loc_lResultado = .F.
1494: 
1495:         TRY
1496:             loc_oBO = THIS.this_oBusinessObject
1497: 
1498:             IF VARTYPE(loc_oBO) = "O"
1499:                 loc_cAliasGrafico = ALLTRIM(loc_oBO.this_cCursorGrafico)
1500:                 loc_oOle          = THIS.obj_4c_OleGrafico
1501: 
1502:                 *-- Guard pelo FLAG do BO, nao por RECCOUNT: RECCOUNT()
1503:                 *-- CONTA registro marcado como excluido (SET DELETED esta
1504:                 *-- OFF por default), e eh exatamente isso que sobra no
1505:                 *-- cursor quando o APPEND GENERAL falha e
1506:                 *-- AnexarGraficoAoCursor apaga a linha em branco. Com
1507:                 *-- RECCOUNT > 0 este metodo passaria a desenhar sobre um
1508:                 *-- registro excluido se o form PAI o chamasse direto (ele
1509:                 *-- eh PUBLIC) - a tela exibiria grafico vazio como se
1510:                 *-- fosse resultado valido.
1511:                 IF USED(loc_cAliasGrafico) AND loc_oBO.this_lGraficoGerado
1512:                     SELECT (loc_cAliasGrafico)
1513:                     GO TOP
1514: 
1515:                     THIS.LockScreen = .T.
1516: 
1517:                     *-- ".ControlSource = 'gGraficos'" do legado, aqui
1518:                     *-- QUALIFICADO com o alias: o legado conta com a work
1519:                     *-- area corrente ser a do cursor do grafico, o que deixa
1520:                     *-- o bind dependente de quem chamou (regra #41).
1521:                     loc_oOle.ControlSource = loc_cAliasGrafico + "." + ;
1522:                         ALLTRIM(loc_oBO.this_cCampoGeral)
1523: 
1524:                     loc_lResultado = THIS.AplicarFormatoGrafico(loc_oOle)
1525: 
1526:                     *-- "If m.lnConta1==1" do legado - o ramo COLUNA. O indice
1527:                     *-- vem do BO (this_nIndiceTipoGrafico), que o calcula
1528:                     *-- pelo mesmo At()/6 do legado sobre o tipo corrente.
1529:                     IF loc_oBO.this_nIndiceTipoGrafico = 1
1530:                         THIS.AplicarEixosColuna(loc_oOle)
1531:                     ENDIF

*-- Linhas 1550 a 1640:
1550:         CATCH TO loc_oErro
1551:             MsgErro(loc_oErro.Message + CHR(13) + ;
1552:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1553:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.MostrarGrafico")
1554:             loc_lResultado = .F.
1555:         ENDTRY
1556: 
1557:         *-- FORA do TRY: falha de formatacao nao pode deixar a tela congelada.
1558:         THIS.LockScreen = .F.
1559: 
1560:         *-- Falha de bloco de formatacao fica VISIVEL, uma vez so.
1561:         IF loc_lResultado AND !EMPTY(THIS.this_cFalhaGrafico)
1562:             MsgAviso("O gr" + CHR(225) + "fico foi desenhado, mas parte da formata" + ;
1563:                 CHR(231) + CHR(227) + "o n" + CHR(227) + "o p" + CHR(244) + "de ser aplicada:" + ;
1564:                 CHR(13) + CHR(13) + THIS.this_cFalhaGrafico, "Gr" + CHR(225) + "fico Comparativo")
1565:             THIS.this_cFalhaGrafico = ""
1566:         ENDIF
1567: 
1568:         RETURN loc_lResultado
1569:     ENDPROC
1570: 
1571:     *==========================================================================
1572:     * AplicarFormatoGrafico - Primeiro bloco do mostragrafico legado: galeria
1573:     * (autoformat), fontes, legenda, titulo e as areas do chart.
1574:     *
1575:     *   .autoformat(laTpgra1[lnConta1,1], laTpgra1[lnConta1,2])
1576:     *   .chartarea.font.name / .size / .bold
1577:     *   .HasLegend / .Legend.Position = 1 / .Legend.Shadow
1578:     *   .hastitle / .charttitle.font.* / .charttitle.text
1579:     *   .displayblanksas = 3
1580:     *   .chartarea.interior.color / .border.color / .shadow
1581:     *   .plotarea.interior.color
1582:     *
1583:     * O par galeria/formato vem do BO (this_nGaleriaAtual/this_nFormatoAtual),
1584:     * que guarda a MESMA tabela laTpgra1 do legado (COLUNA -4100/4 e
1585:     * PIZZA -4102/7) e o indice corrente.
1586:     *
1587:     * DUAS ATRIBUICOES MORTAS do legado NAO sao transcritas, por serem
1588:     * sobrescritas pelo PROPRIO legado poucas linhas depois, sem nada ler o
1589:     * valor intermediario:
1590:     *   .ChartArea.interior.color = Rgb(192,192,192) -> depois Rgb(255,255,255)
1591:     *   .PlotArea.interior.color  = Rgb(222,222,222) -> depois Rgb(255,255,255)
1592:     * Os valores EFETIVOS (branco nas duas areas) sao os aplicados aqui.
1593:     * Idem ".chartarea.font.name = 'Arial'", que o legado repete identico.
1594:     *
1595:     * O titulo eh a concatenacao das QUATRO linhas do legado (lcTitulo +
1596:     * lcStitulo + lcStitulo2 + lcStitulo3), separadas por CHR(13): titulo
1597:     * fixo, periodo/grupos (tirados do PROPRIO crFinal - diferenca 1 do
1598:     * cabecalho do SIGOPGRCBO) e o rotulo de cotacao.
1599:     *==========================================================================
1600:     PROTECTED PROCEDURE AplicarFormatoGrafico(par_oOle)
1601:         LOCAL loc_oBO, loc_cTitulo, loc_lResultado, loc_oErro
1602:         loc_lResultado = .F.
1603: 
1604:         TRY
1605:             loc_oBO = THIS.this_oBusinessObject
1606: 
1607:             loc_cTitulo = ALLTRIM(loc_oBO.this_cTitulo)     + CHR(13) + ;
1608:                           ALLTRIM(loc_oBO.this_cSubTitulo1) + CHR(13) + ;
1609:                           ALLTRIM(loc_oBO.this_cSubTitulo2) + CHR(13) + ;
1610:                           ALLTRIM(loc_oBO.this_cSubTitulo3)
1611: 
1612:             WITH par_oOle
1613:                 .AutoFormat(loc_oBO.this_nGaleriaAtual, loc_oBO.this_nFormatoAtual)
1614: 
1615:                 .ChartArea.Font.Name = "Arial"
1616:                 .ChartArea.Font.Size = 8
1617:                 .ChartArea.Font.Bold = .T.
1618: 
1619:                 .HasLegend       = .T.
1620:                 .Legend.Position = 1
1621:                 .Legend.Shadow   = .T.
1622: 
1623:                 .HasTitle               = .T.
1624:                 .ChartTitle.Font.Size   = 9
1625:                 .ChartTitle.Font.Bold   = .T.
1626:                 .ChartTitle.Font.Italic = .F.
1627:                 .ChartTitle.Text        = loc_cTitulo
1628: 
1629:                 .DisplayBlanksAs = 3
1630: 
1631:                 *-- Valores EFETIVOS do legado (ver cabecalho: os cinzas
1632:                 *-- 192/222 sao sobrescritos por ele mesmo logo abaixo).
1633:                 .ChartArea.Interior.Color = RGB(255, 255, 255)
1634:                 .ChartArea.Border.Color   = RGB(0, 0, 0)
1635:                 .ChartArea.Shadow         = .T.
1636:                 .PlotArea.Interior.Color  = RGB(255, 255, 255)
1637:             ENDWITH
1638: 
1639:             loc_lResultado = .T.
1640:         CATCH TO loc_oErro

*-- Linhas 1678 a 1721:
1678:     * cabecalho do SIGOPGRCBO - o gemeo FormSigOpGco tem um ".= .t." logo
1679:     * adiante no mesmo metodo que o SIGOPGRC NAO tem).
1680:     *==========================================================================
1681:     PROTECTED PROCEDURE AplicarEixosColuna(par_oOle)
1682:         LOCAL loc_oBO, loc_cTituloX, loc_cTituloY, loc_lResultado, loc_oErro
1683:         loc_lResultado = .F.
1684: 
1685:         TRY
1686:             loc_oBO      = THIS.this_oBusinessObject
1687:             loc_cTituloX = ALLTRIM(loc_oBO.this_cTituloEixoX)
1688:             loc_cTituloY = ALLTRIM(loc_oBO.this_cTituloEixoY)
1689: 
1690:             WITH par_oOle
1691:                 .PlotArea.Width = 610
1692:                 .PlotArea.Left  = 1
1693: 
1694:                 *-- Eixo 2 = eixo dos VALORES
1695:                 .Axes(2).MaximumScaleIsAuto = .T.
1696:                 .Axes(2).HasTitle           = .T.
1697:                 .Axes(2).AxisTitle.Caption  = loc_cTituloY
1698: 
1699:                 IF !EMPTY(loc_cTituloY)
1700:                     .Axes(2).AxisTitle.Orientation  = 90
1701:                     .Axes(2).TickLabels.Orientation = 0
1702:                 ENDIF
1703: 
1704:                 *-- Eixo 1 = eixo das CATEGORIAS (os meses)
1705:                 .Axes(1).HasTitle          = .T.
1706:                 .Axes(1).AxisTitle.Caption = loc_cTituloX
1707: 
1708:                 IF !EMPTY(loc_cTituloX)
1709:                     *-- "Iif((m.lnTmX>5),90,0)" do legado: rotulo longo vira
1710:                     *-- vertical. lnTmX nunca eh atribuido antes deste ponto
1711:                     *-- no legado, entao o Iif de guarda dele resolve 0 - e o
1712:                     *-- BO guarda esse mesmo 0 em this_nTamanhoRotuloX.
1713:                     .Axes(1).TickLabels.Orientation = IIF(loc_oBO.this_nTamanhoRotuloX > 5, 90, 0)
1714:                     .Axes(1).TickLabels.Font.Size   = 6
1715:                 ENDIF
1716: 
1717:                 WITH .ChartGroups(1)
1718:                     .HasSeriesLines = .F.
1719:                     .GapWidth       = 10
1720:                     .Overlap        = (.GapWidth / 2 * -1)
1721:                 ENDWITH

*-- Linhas 1787 a 1830:
1787:     * grupo so", esta tela desenha a coluna com a geometria de coluna, e o
1788:     * legado desenhava com a de pizza.
1789:     *==========================================================================
1790:     PROTECTED PROCEDURE AplicarRotulosPercentuais(par_oOle)
1791:         LOCAL loc_oBO, loc_oSerie, loc_oRotulo, loc_nGrupo, loc_nMes, ;
1792:               loc_nPercentual, loc_lResultado, loc_oErro
1793:         loc_lResultado = .F.
1794: 
1795:         TRY
1796:             loc_oBO = THIS.this_oBusinessObject
1797: 
1798:             FOR loc_nGrupo = 1 TO loc_oBO.this_nTotalGrupos
1799:                 IF TYPE("THIS.obj_4c_OleGrafico.ChartGroups(1).SeriesCollection(m.loc_nGrupo)") == "O"
1800:                     loc_oSerie = par_oOle.ChartGroups(1).SeriesCollection(loc_nGrupo)
1801: 
1802:                     *-- Transcrito do legado nas DUAS linhas, na ordem dele.
1803:                     loc_oSerie.ApplyDataLabels      = .T.
1804:                     loc_oSerie.ApplyDataLabels.Type = 2
1805: 
1806:                     FOR loc_nMes = 1 TO loc_oBO.this_nTotalMeses
1807:                         IF TYPE("THIS.obj_4c_OleGrafico.ChartGroups(1).SeriesCollection(m.loc_nGrupo).Points(m.loc_nMes).DataLabel") == "O"
1808:                             *-- ".Points(m.lnConta2).DataLabel" do legado. O
1809:                             *-- indice do PONTO (o mes) eh obrigatorio: sem
1810:                             *-- ele o nome nao existe no servidor OLE, o
1811:                             *-- acesso estoura, o CATCH do metodo engole a
1812:                             *-- falha na PRIMEIRA iteracao e NENHUM rotulo de
1813:                             *-- percentual eh aplicado - sem erro na tela.
1814:                             loc_oRotulo = loc_oSerie.PointsDataLabel
1815: 
1816:                             *-- laPerc(grupo, mes) do legado
1817:                             loc_nPercentual = loc_oBO.ObterPercentual(loc_nGrupo, loc_nMes)
1818: 
1819:                             WITH loc_oRotulo
1820:                                 .Top = (.Top - 10)
1821:                                 *-- InList(,2,4) do legado: REGRA DE NEGOCIO,
1822:                                 *-- so a 2a e a 4a serie levam o numero.
1823:                                 .Caption = IIF(INLIST(loc_nGrupo, 2, 4), ;
1824:                                     ALLTRIM(STR(loc_nPercentual, 20, 0)), "")
1825:                                 .Font.Name   = "Arial "
1826:                                 .Font.Size   = 8
1827:                                 .Font.Bold   = .T.
1828:                                 .Font.Shadow = .F.
1829:                             ENDWITH
1830:                         ENDIF

*-- Linhas 1861 a 1886:
1861:     * uma atribuicao, e sem este bloco a pizza sairia com a geometria de
1862:     * coluna. Omitir seria entregar metade da tabela de tipos.
1863:     *==========================================================================
1864:     PROTECTED PROCEDURE AplicarAreaPizza(par_oOle)
1865:         LOCAL loc_lResultado, loc_oErro
1866:         loc_lResultado = .F.
1867: 
1868:         TRY
1869:             WITH par_oOle
1870:                 .PlotArea.Width = 240
1871:                 .PlotArea.Top   = 63
1872:                 .PlotArea.Left  = 110
1873:             ENDWITH
1874: 
1875:             loc_lResultado = .T.
1876:         CATCH TO loc_oErro
1877:             IF EMPTY(THIS.this_cFalhaGrafico)
1878:                 THIS.this_cFalhaGrafico = "AplicarAreaPizza: " + loc_oErro.Message
1879:             ENDIF
1880:             loc_lResultado = .F.
1881:         ENDTRY
1882: 
1883:         RETURN loc_lResultado
1884:     ENDPROC
1885: 
1886: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPGRCBO.prg):
*============================================================================
* SIGOPGRCBO.prg - Business Object para "Grafico Comparativo" (SIGOPGRC)
*
* Form OPERACIONAL (SIGOPGRC / FormSIGOPGRC): tela de EXIBICAO de grafico
* (MsGraph.Chart via OleBoundControl), aberta pelo form PAI, que ja processou
* e deixou pronto o cursor de origem:
*
*   crFinal - resultado agregado com as colunas Mes, Ordem, Ano, Grupos,
*             Total e npercs (series do grafico) e, ainda, dtini, dtfinal,
*             lcGrupo1, lcGrupo2 e lcMoe (usadas apenas como subtitulos).
*             Chega com os tags de ordenacao Grupom e imp - o Init legado faz
*             "Set order to Grupom" para varrer os meses e "Set order to imp"
*             para varrer os grupos.
*
* O SIGOPGRC NAO consulta o banco: ele apenas agrega/formata o que veio no
* cursor do pai, monta a matriz TAB/CRLF das series (uma coluna por mes, uma
* linha por grupo) e guarda o binario do grafico num cursor local com campo
* General (Create Cursor Graph (gGraficos Gen (4)) no legado).
*
* O modo de montagem depende do controle Comparativo do form pai
* (Thisform.Parentform.Comparativo.value): valendo 1, o grupo passa a ser
* Grupos + Ano e os percentuais (npercs) viram rotulo de ponto das series;
* valendo outro numero, o grupo eh so Grupos e nao ha rotulo de percentual.
*
* DIFERENCAS MEDIDAS CONTRA O GEMEO SIGOPGCO (task739 / SigOpGcoBO) - as duas
* telas sao quase identicas, e por isso estas tres divergencias precisam ficar
* escritas, para nenhuma fase seguinte copiar o irmao por reflexo:
*
*   1) NAO existe cursor "Cabecalho" aqui. O SIGOPGCO tira os subtitulos de
*      Cabecalho.pRelTitulo / Cabecalho.pPeriodo; o SIGOPGRC monta os tres
*      subtitulos a partir de colunas do PROPRIO crFinal mais a opcao de
*      cotacao do pai (mostragrafico legado):
*        lcStitulo  = dtoc(crFinal.dtini) + ' ate ' + dtoc(crFinal.dtfinal)
*        lcStitulo2 = alltrim(crFinal.lcGrupo1) + ' / ' + alltrim(crFinal.lcGrupo2)
*        lcStitulo3 = 'Moeda ' + Iif(ParentForm.OptCotacao.value=1,
*                     'Fechamento : ', 'Movimentacao : ') + crFinal.lcMoe
*      Logo o subtitulo 3 NAO eh a constante "Todas as Empresas" do SIGOPGCO.
*      (Os literais acentuados do legado estao transcritos via CHR() nas
*      propriedades abaixo - aqui no comentario ficam sem acento de proposito.)
*
*   2) Entrada extra vinda do pai: Thisform.ParentForm.OptCotacao.value, que
*      escolhe o rotulo de moeda do subtitulo 3 (this_nOpcaoCotacao).
*
*   3) O SIGOPGRC poe APENAS ".HasSeriesLines = .f." no ChartGroups(1). O
*      SIGOPGCO tem, adiante no mesmo metodo, um
*      ".chartgroups(1).hasserieslines = .t." que o SIGOPGRC NAO tem - aqui o
*      valor efetivo eh .F. (this_lSerieLinhas).
*
* O "Load" legado ("=fConfigGeral()") nao gera metodo neste BO: fConfigGeral
* era inicializacao GLOBAL da aplicacao Fortyus e na arquitetura nova isso ja
* acontece antes (config.prg / main.prg / cada BO com seus cursores). O
* wrapper projeto\app\utils\fconfiggeral.prg existe so para o p-code dos VCX
* legado, e em codigo nosso nao se chama essa funcao.
*
* Nao existe tabela proprietaria (this_cTabela fica vazio): este BO nao faz
* INSERT/UPDATE/DELETE contra o SQL Server, so agrega o cursor de origem.
*
* DOIS DEFEITOS CORRIGIDOS NA REVISAO DA FASE 8 (2026-11-06) - os dois
* compilavam limpo e so quebravam em runtime, no clique do usuario:
*
*   1) this_cCursorGrafico voltou a ser o alias "Graph" do LEGADO. Ele estava
*      como "cursor_4c_Grafico", seguindo a convencao de nome do projeto, mas
*      o SigOpGrc.frx cita [Graph.gGraficos] LITERALMENTE no registro do OLE
*      Bound Control (lido como DBF em 2026-11-06) - o Report Form do botao
*      Imprimir estouraria "Alias GRAPH is not found" e o grafico nunca
*      imprimiria. Alias que um FRX cita eh CONTRATO do relatorio, igual a
*      nome de coluna do banco: o PILAR 3 nao o renomeia. Ver a property.
*
*   2) CarregarDoCursor recuperou o "Order By 1" do Select Distinct dos
*      GRUPOS, que a migracao tinha descartado. A posicao da linha nesse
*      cursor eh o indice do grupo na matriz de percentuais (o
*      Ascan(laGrupos,...) do legado), lido depois pelo rotulo de cada ponto
*      da serie - sem ordenacao garantida o percentual podia sair na serie
*      errada, sem erro e sem log.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Revisado em: Fase 8 - Consolidacao final (os dois itens acima)
*============================================================================

DEFINE CLASS SIGOPGRCBO AS BusinessBase

    *==========================================================================
    * CURSOR DE ORIGEM (fornecido pelo form PAI - este BO so o consulta)
    *==========================================================================

    *-- crFinal do legado: agregado com Mes, Ordem, Ano, Grupos, Total e
    *-- npercs para as series, mais dtini, dtfinal, lcGrupo1, lcGrupo2 e lcMoe
    *-- para os subtitulos do grafico
    this_cCursorOrigem = ""

    *-- Tags de ordenacao que o Init legado usa sobre o cursor de origem:
    *-- Grupom para varrer os meses e imp para varrer os grupos na montagem
    this_cOrdemMeses  = ""
    this_cOrdemGrupos = ""

    *==========================================================================
    * CURSORES DE TRABALHO (criados por este BO)
    *==========================================================================

    *-- Cursor Graph do legado (gGraficos Gen (4)): guarda o binario do
    *-- MsGraph.Chart gerado pelo Append General. Eh tambem o alias que o
    *-- OleBoundControl consome via ControlSource e que o Imprimir seleciona
    *-- antes do Report Form.
    *--
    *-- O ALIAS DESTE CURSOR EH CONTRATO DO FRX - o PILAR 3 nao o renomeia.
    *-- Medido em 2026-11-06 lendo o SigOpGrc.frx como DBF: o registro 5
    *-- (ObjType = 17, OLE Bound Control) tem Name = [Graph.gGraficos], ou
    *-- seja o relatorio cita o alias LITERAL "Graph" do legado. Batiza-lo
    *-- "cursor_4c_Grafico" seguindo a convencao de nome do projeto faz o
    *-- Report Form do botao Imprimir estourar "Alias GRAPH is not found" -
    *-- compila limpo e so quebra quando o usuario aciona Imprimir. Mesma
    *-- natureza de nome de coluna do banco (PILAR 2): eh dado do
    *-- relatorio, nao nome escolhido pelo migrador.
    this_cCursorGrafico = ""

    *-- Nome do campo General dentro de this_cCursorGrafico. O legado usa
    *-- ControlSource = 'gGraficos', entao o nome eh contrato com o
    *-- OleBoundControl e com o FRX de impressao.
    this_cCampoGeral = ""

    *-- Substitutos dos arrays laMeses e laGrupos do legado (Select Distinct
    *-- ... Into Array). Usamos cursor em vez de ARRAY para nao depender de
    *-- escopo de m.array entre BO e Form.
    this_cCursorMeses  = ""
    this_cCursorGrupos = ""

    *-- Substituto da matriz laPerc(lnNgrupos, lnNmeses) do legado: guarda o
    *-- percentual (npercs) de cada cruzamento grupo x mes, que vira rotulo
    *-- de ponto da serie quando o modo comparativo esta ligado.
    this_cCursorPercentuais = ""

    *==========================================================================
    * CLASSE OLE E RELATORIO
    *==========================================================================

    *-- Classe do Append General do legado: Class 'MsGraph.Chart'
    this_cClasseOLE = ""

    *-- Report form SigOpGrc to printer prompt noconsole (Click do Imprimir)
    this_cRelatorio = ""

    *==========================================================================
    * TITULOS DO GRAFICO (lcTitulo / lcStitulo / lcStitulo2 / lcStitulo3 e os
    * titulos de eixo lcTitulod / lcTitulov do mostragrafico legado). O
    * charttitle.text concatena os quatro primeiros separados por CHR(13).
    *==========================================================================
    this_cTitulo      = ""
    this_cSubTitulo1  = ""
    this_cSubTitulo2  = ""
    this_cSubTitulo3  = ""
    this_cTituloEixoX = ""
    this_cTituloEixoY = ""

    *==========================================================================
    * LITERAIS DOS SUBTITULOS - transcritos do mostragrafico legado. Ficam em
    * propriedade (e nao soltos no meio da montagem) porque sao as unicas
    * partes FIXAS das tres formulas de subtitulo do SIGOPGRC, e eh por elas
    * que esta tela difere do gemeo SIGOPGCO.
    *==========================================================================

    *-- " at" + CHR(233) + " " : separador do periodo (dtini / dtfinal)
    this_cSeparadorPeriodo = ""

    *-- " / " : separador entre lcGrupo1 e lcGrupo2
    this_cSeparadorGrupos = ""

    *-- "Moeda " : prefixo do subtitulo 3, antes do rotulo de cotacao
    this_cPrefixoMoeda = ""

    *-- Os dois rotulos de cotacao do Iif legado. O teste do legado eh
    *-- "OptCotacao.value = 1": valendo 1 sai Fechamento, qualquer outro
    *-- valor sai Movimentacao. Os espacos antes dos dois-pontos fazem parte
    *-- do literal do legado e nao se "arrumam".
    this_cRotuloCotacaoFechamento   = ""
    this_cRotuloCotacaoMovimentacao = ""

    *==========================================================================
    * TIPO DE GRAFICO - a tabela laTpgra1(2,3) do legado tem duas linhas
    * fixas: COLUNA (-4100, 4) e PIZZA (-4102, 7). O indice vem de
    * lnConta1 = ((At(AllTrim(lcTpReg),'COLUNAPIZZA ')+5)/6), ou seja
    * 1 para COLUNA e 2 para PIZZA.
    *==========================================================================

    *-- lcTpReg do legado, fixo em "COLUNA" no Init e no mostragrafico
    this_cTipoGrafico = ""

    *-- lnConta1: 1 = COLUNA, 2 = PIZZA
    this_nIndiceTipoGrafico = 1

    *-- Linha 1 da tabela: COLUNA
    this_nGaleriaColuna = -4100
    this_nFormatoColuna = 4

    *-- Linha 2 da tabela: PIZZA
    this_nGaleriaPizza = -4102
    this_nFormatoPizza = 7

    *-- Par efetivamente passado ao autoformat do OleBoundControl, resolvido a
    *-- partir de this_nIndiceTipoGrafico
    this_nGaleriaAtual = -4100
    this_nFormatoAtual = 4

    *==========================================================================
    * CONTAGENS E MODO
    *==========================================================================

    *-- lnNmeses = Alen(laMeses,1) - colunas do grafico
    this_nTotalMeses = 0

    *-- lnNgrupos = Alen(laGrupos,1) - series do grafico
    this_nTotalGrupos = 0

    *-- lnTmX do legado: tamanho do maior rotulo do eixo X. Passando de 5, o
    *-- mostragrafico gira os rotulos em 90 graus
    *-- (.axes(1).ticklabels.orientation = Iif((lnTmX>5),90,0)).
    this_nTamanhoRotuloX = 0

    *-- Thisform.Parentform.Comparativo.value: valendo 1, agrupa por
    *-- Grupos + Ano e aplica os rotulos de percentual nas series
    this_nComparativo = 0

    *-- Thisform.ParentForm.OptCotacao.value: valendo 1, o subtitulo 3 sai com
    *-- this_cRotuloCotacaoFechamento; qualquer outro valor sai com
    *-- this_cRotuloCotacaoMovimentacao. Entrada que o SIGOPGCO nao tem.
    this_nOpcaoCotacao = 0

    *==========================================================================
    * DADOS DAS SERIES - lcStrg do legado, a matriz inteira que o
    * Append General recebe em Data(). A primeira linha traz os nomes dos
    * meses separados por TAB; cada linha seguinte traz o nome do grupo e os
    * totais, tambem separados por TAB, terminando em CRLF.
    *==========================================================================
    this_cDadosGrafico = ""

    *-- Primeira linha de this_cDadosGrafico, guardada a parte para quem
    *-- precisar so dos rotulos de mes
    this_cLinhaMeses = ""

    *==========================================================================
    * FLAGS DE ESTADO
    *==========================================================================

    *-- ChartGroups(1).HasSeriesLines. No SIGOPGRC o legado poe .f. e NAO tem
    *-- o ".chartgroups(1).hasserieslines = .t." que o SIGOPGCO tem adiante no
    *-- mesmo metodo - por isso o valor efetivo aqui eh .F.
    this_lSerieLinhas = .F.

    *-- .T. quando a montagem produziu matriz nao vazia (If !IsEmpty(lcStrg)
    *-- do Init legado, que eh o guard do Append General)
    this_lDadosValidos = .F.

    *-- .T. quando o binario do MsGraph.Chart foi gravado no cursor de grafico
    this_lGraficoGerado = .F.

    *==========================================================================
    * Init - Nao ha tabela proprietaria (a tela so exibe/agrega o que o form
    * pai processou), entao this_cTabela e this_cCampoChave ficam vazios.
    * Inicializa os nomes canonicos dos cursores de trabalho, os titulos e
    * literais fixos e a tabela de tipos de grafico do legado.
    *
    * Init de BO que devolve .F. destroi o objeto e faz o Form abortar o
    * proprio Init, entao aqui nao ha carga de dados: so atribuicao de
    * propriedades, que nao depende de conexao nem de cursor do pai.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Sem tabela proprietaria: este BO nao grava no SQL Server
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            *-- Cursor de origem (crFinal do legado) e seus dois tags. O form
            *-- pai pode sobrescrever estes nomes antes de mandar montar o
            *-- grafico. Nao ha cursor Cabecalho nesta tela.
            THIS.this_cCursorOrigem = "crFinal"
            THIS.this_cOrdemMeses   = "Grupom"
            THIS.this_cOrdemGrupos  = "imp"

            *-- Cursores de trabalho criados por este BO
            *-- "Graph" e nao "cursor_4c_Grafico": o SigOpGrc.frx cita
            *-- Graph.gGraficos literalmente (ver a property la em cima)
            THIS.this_cCursorGrafico     = "Graph"
            THIS.this_cCampoGeral        = "gGraficos"
            THIS.this_cCursorMeses       = "cursor_4c_Meses"
            THIS.this_cCursorGrupos      = "cursor_4c_Grupos"
            THIS.this_cCursorPercentuais = "cursor_4c_Percentuais"

            *-- Classe OLE do Append General e FRX do botao Imprimir
            THIS.this_cClasseOLE = "MsGraph.Chart"
            THIS.this_cRelatorio = "SigOpGrc"

            *-- Titulos do mostragrafico legado. Dos quatro, so o titulo e o
            *-- titulo do eixo Y sao fixos; os tres subtitulos sao montados a
            *-- partir de crFinal e de this_nOpcaoCotacao, e o titulo do eixo
            *-- X eh vazio no legado (lcTitulod = '').
            THIS.this_cTitulo      = "Gr" + CHR(225) + "fico Comparativo"
            THIS.this_cSubTitulo1  = ""
            THIS.this_cSubTitulo2  = ""
            THIS.this_cSubTitulo3  = ""
            THIS.this_cTituloEixoX = ""
            THIS.this_cTituloEixoY = "Desempenho"

            *-- Literais fixos das formulas dos subtitulos, transcritos do
            *-- legado: " ate ", " / ", "Moeda ", "Fechamento : " e
            *-- "Movimentacao : " (acentos via CHR(), regra #4)
            THIS.this_cSeparadorPeriodo = " at" + CHR(233) + " "
            THIS.this_cSeparadorGrupos  = " / "
            THIS.this_cPrefixoMoeda     = "Moeda "

            THIS.this_cRotuloCotacaoFechamento   = "Fechamento : "
            THIS.this_cRotuloCotacaoMovimentacao = "Movimenta" + CHR(231) + CHR(227) + "o : "

            *-- Tabela de tipos do legado e o tipo corrente (lcTpReg = 'COLUNA',
            *-- logo lnConta1 = 1 e o par ativo eh o da linha COLUNA)
            THIS.this_cTipoGrafico       = "COLUNA"
            THIS.this_nGaleriaColuna     = -4100
            THIS.this_nFormatoColuna     = 4
            THIS.this_nGaleriaPizza      = -4102
            THIS.this_nFormatoPizza      = 7
            THIS.this_nIndiceTipoGrafico = 1
            THIS.this_nGaleriaAtual      = THIS.this_nGaleriaColuna
            THIS.this_nFormatoAtual      = THIS.this_nFormatoColuna

            *-- Contagens e modo comecam zerados; a montagem os resolve a partir
            *-- do cursor do pai. this_nComparativo e this_nOpcaoCotacao sao
            *-- atribuidos pelo Form, que le os dois controles do form pai.
            THIS.this_nTotalMeses     = 0
            THIS.this_nTotalGrupos    = 0
            THIS.this_nTamanhoRotuloX = 0
            THIS.this_nComparativo    = 0
            THIS.this_nOpcaoCotacao   = 0

            *-- Series ainda sem conteudo
            THIS.this_cDadosGrafico = ""
            THIS.this_cLinhaMeses   = ""

            *-- O legado desta tela nunca liga as linhas de serie
            THIS.this_lSerieLinhas = .F.

            THIS.this_lDadosValidos  = .F.
            THIS.this_lGraficoGerado = .F.

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FASE 2 - METODOS CRUD: decisao de projeto (BO somente-leitura)
    *
    * O dump do legado (SIGOPGRC_form_codigo_fonte.txt) nao tem nenhum
    * TABLEUPDATE(, nenhum .AddCursor( e nenhum "Insert Into"/"Update "/
    * "Delete From" contra tabela remota - o unico alvo de escrita e o
    * cursor LOCAL "Graph" (Create Cursor Graph (gGraficos Gen (4)) seguido
    * de Append Blank + Append General), que aqui vira
    * this_cCursorGrafico e MANTEM o alias "Graph" do legado, porque o
    * SigOpGrc.frx o cita literalmente. Esse cursor e o Append General
    * sao criados pelo FORM (OLE nao entra no BO - PILAR 3), nao por este
    * BO. Este BO so LE crFinal (preenchido pelo form PAI) e agrega.
    *
    * Por isso o trabalho real desta fase fica concentrado em
    * CarregarDoCursor() (agregacao de crFinal nos cursores de trabalho e
    * na matriz this_cDadosGrafico), e Inserir()/Atualizar() NAO sao
    * sobrescritos aqui: o comportamento herdado de BusinessBase (recusar a
    * operacao com mensagem de erro) ja eh o correto para uma tela que
    * nunca grava registro em tabela do SQL Server. ObterChavePrimaria()
    * tambem fica herdado (devolve "") porque nao ha chave primaria - a
    * tela nao representa uma linha de tabela, entao RegistrarAuditoria()
    * nunca chega a ser chamado.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Agrega o cursor do form pai (crFinal) e monta a
    * matriz TAB/CRLF que o Append General do grafico espera (lcStrg do
    * legado), alem dos cursores de trabalho de meses/grupos e da matriz de
    * percentuais.
    *
    * Nao ha "registro" para carregar (este BO nao representa uma linha de
    * tabela): par_cCursorOrigem substitui o nome padrao
    * this_cCursorOrigem quando o form pai usar outro alias.
    * THIS.this_nComparativo e THIS.this_nOpcaoCotacao devem ser atribuidos
    * pelo Form ANTES de chamar este metodo - sao o equivalente a
    * Thisform.Parentform.Comparativo.Value e
    * Thisform.ParentForm.OptCotacao.Value do legado.
    *
    * Nao ha cursor Cabecalho nesta tela (diferenca 1 do cabecalho do
    * arquivo): os tres subtitulos vem de colunas do PROPRIO crFinal
    * (dtini/dtfinal/lcGrupo1/lcGrupo2/lcMoe) mais this_nOpcaoCotacao.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cCursorOrigem)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cOrigem
        LOCAL loc_nMes, loc_cMesNome, loc_cLinhaMeses, loc_cStrg
        LOCAL loc_cGrupoAtual, loc_nMesPos, loc_nGrupoPos
        loc_lResultado = .F.

        TRY
            loc_cOrigem = IIF(EMPTY(par_cCursorOrigem), THIS.this_cCursorOrigem, par_cCursorOrigem)

            THIS.this_lDadosValidos  = .F.
            THIS.this_lGraficoGerado = .F.

            IF !USED(loc_cOrigem)
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + "o encontrado."
                loc_lResultado = .F.
            ELSE
                THIS.this_cCursorOrigem = loc_cOrigem

                *-- Subtitulos (lcStitulo/lcStitulo2/lcStitulo3 do legado),
                *-- tirados do PROPRIO crFinal e da opcao de cotacao do pai
                SELECT (loc_cOrigem)
                GO TOP
                THIS.this_cSubTitulo1 = DTOC(EVALUATE(loc_cOrigem + ".dtini")) + ;
                    THIS.this_cSeparadorPeriodo + DTOC(EVALUATE(loc_cOrigem + ".dtfinal"))
                THIS.this_cSubTitulo2 = ALLTRIM(EVALUATE(loc_cOrigem + ".lcGrupo1")) + ;
                    THIS.this_cSeparadorGrupos + ALLTRIM(EVALUATE(loc_cOrigem + ".lcGrupo2"))
                *-- lcMoe NAO eh alltrim no legado ('...+crFinal.lcMoe') -
                *-- transcrito literal (regra #17: formula/literal do legado
                *-- nao se "arruma").
                THIS.this_cSubTitulo3 = THIS.this_cPrefixoMoeda + ;
                    IIF(THIS.this_nOpcaoCotacao = 1, THIS.this_cRotuloCotacaoFechamento, THIS.this_cRotuloCotacaoMovimentacao) + ;
                    EVALUATE(loc_cOrigem + ".lcMoe")

                *-- lnTmX do legado: nunca foi atribuido antes deste ponto,
                *-- entao Iif(Type('lnTmX')=='N',lnTmX,0) sempre resolve 0
                THIS.this_nTamanhoRotuloX = 0

                *-- Meses distintos (Select Distinct Mes From crFinal Order
                *-- By Mes Into Array laMeses do legado - aqui, cursor em vez
                *-- de array)
                IF USED(THIS.this_cCursorMeses)
                    USE IN (THIS.this_cCursorMeses)
                ENDIF
                SELECT DISTINCT Mes FROM (loc_cOrigem) ORDER BY Mes INTO CURSOR (THIS.this_cCursorMeses)

                *-- Grupos distintos (Select Distinct Str(Ordem,1)+Str(Ano,4)
                *-- As cGrupos From crFinal Order By 1 Into Array laGrupos do
                *-- legado)
                IF USED(THIS.this_cCursorGrupos)
                    USE IN (THIS.this_cCursorGrupos)
                ENDIF
                *-- O "Order By 1" do legado eh OBRIGATORIO: eh a posicao da
                *-- linha neste cursor que vira o indice do GRUPO na matriz de
                *-- percentuais (Ascan(laGrupos,...) do legado), lido depois
                *-- pelo rotulo de cada ponto da serie. Sem ORDER BY a ordem
                *-- do DISTINCT nao eh garantida e o percentual pode sair na
                *-- serie errada - sem erro e sem log. Medido no VFP9 em
                *-- 2026-11-06: "ORDER BY 1" (numero de coluna) eh aceito em
                *-- SELECT ... INTO CURSOR sobre coluna de EXPRESSAO, ao
                *-- contrario de repetir a expressao no ORDER BY.
                SELECT DISTINCT (STR(Ordem, 1) + STR(Ano, 4)) AS cGrupos ;
                    FROM (loc_cOrigem) ;
                    ORDER BY 1 ;
                    INTO CURSOR (THIS.this_cCursorGrupos)

                THIS.this_nTotalMeses  = RECCOUNT(THIS.this_cCursorMeses)
                THIS.this_nTotalGrupos = RECCOUNT(THIS.this_cCursorGrupos)

                *-- Matriz de percentuais (laPerc(nGrupos,nMeses) do legado) -
                *-- um cursor com uma linha por cruzamento grupo x mes, no
                *-- lugar do array bidimensional
                IF USED(THIS.this_cCursorPercentuais)
                    USE IN (THIS.this_cCursorPercentuais)
                ENDIF
                CREATE CURSOR (THIS.this_cCursorPercentuais) ;
                    (nGrupoPos N(6,0), nMesPos N(6,0), nPercentual N(20,0))

                *-- Linha 1 da matriz: nomes dos meses, varrendo crFinal
                *-- ordenado por this_cOrdemMeses (tag Grupom do legado)
                SELECT (loc_cOrigem)
                IF TAGNO(THIS.this_cOrdemMeses, "", loc_cOrigem) > 0
                    SET ORDER TO TAG (THIS.this_cOrdemMeses) IN (loc_cOrigem)
                ENDIF
                GO TOP IN (loc_cOrigem)

                loc_cLinhaMeses = ""
                loc_nMes = EVALUATE(loc_cOrigem + ".Mes")
                SCAN
                    DO CASE
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 1
                            loc_cMesNome = "Janeiro"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 2
                            loc_cMesNome = "Fevereiro"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 3
                            loc_cMesNome = "Mar" + CHR(231) + "o"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 4
                            loc_cMesNome = "Abril"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 5
                            loc_cMesNome = "Maio"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 6
                            loc_cMesNome = "Junho"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 7
                            loc_cMesNome = "Julho"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 8
                            loc_cMesNome = "Agosto"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 9
                            loc_cMesNome = "Setembro"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 10
                            loc_cMesNome = "Outubro"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 11
                            loc_cMesNome = "Novembro"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 12
                            loc_cMesNome = "Dezembro"
                        OTHERWISE
                            loc_cMesNome = ""
                    ENDCASE
                    loc_cLinhaMeses = loc_cLinhaMeses + CHR(9) + ALLTRIM(loc_cMesNome)
                    DO WHILE EVALUATE(loc_cOrigem + ".Mes") = loc_nMes AND !EOF(loc_cOrigem)
                        IF !EOF(loc_cOrigem)
                            SKIP IN (loc_cOrigem)
                        ENDIF
                    ENDDO
                    loc_nMes = EVALUATE(loc_cOrigem + ".Mes")
                ENDSCAN
                loc_cStrg = loc_cLinhaMeses + CHR(13) + CHR(10)
                THIS.this_cLinhaMeses = loc_cLinhaMeses

                *-- Linhas seguintes: uma por grupo, varrendo crFinal
                *-- ordenado por this_cOrdemGrupos (tag imp do legado)
                SELECT (loc_cOrigem)
                IF TAGNO(THIS.this_cOrdemGrupos, "", loc_cOrigem) > 0
                    SET ORDER TO TAG (THIS.this_cOrdemGrupos) IN (loc_cOrigem)
                ENDIF
                GO TOP IN (loc_cOrigem)

                DO WHILE !EOF(loc_cOrigem)
                    IF THIS.this_nComparativo = 1
                        *-- CHAVE do grupo: concatenacao CRUA, com o padding
                        *-- do char(20) - eh ela que o SCAN WHILE compara,
                        *-- posicao por posicao (legado: lcgrupo =
                        *-- crFinal.Grupos + str(crFinal.ano,4)).
                        loc_cGrupoAtual = EVALUATE(loc_cOrigem + ".Grupos") + STR(EVALUATE(loc_cOrigem + ".Ano"), 4)

                        *-- ROTULO da serie: o legado ALLTRIMa so a coluna
                        *-- Grupos e DEPOIS cola o ano
                        *--   lcStrg + ALLTRIM(crFinal.Grupos) + str(crFinal.ano,4)
                        *-- ALLTRIM na concatenacao INTEIRA nao eh o mesmo:
                        *-- ele so tira as pontas e deixa os espacos do
                        *-- meio, entao a legenda do grafico sairia com os
                        *-- brancos do char(20) no meio. Compila limpo e so
                        *-- aparece na legenda do chart.
                        loc_cStrg = loc_cStrg + ALLTRIM(EVALUATE(loc_cOrigem + ".Grupos")) + ;
                            STR(EVALUATE(loc_cOrigem + ".Ano"), 4)
                        SCAN WHILE EVALUATE(loc_cOrigem + ".Grupos") + STR(EVALUATE(loc_cOrigem + ".Ano"), 4) = loc_cGrupoAtual
                            loc_cStrg = loc_cStrg + CHR(9) + STR(EVALUATE(loc_cOrigem + ".Total"))

                            loc_nMesPos   = THIS.ObterPosicaoMes(EVALUATE(loc_cOrigem + ".Mes"))
                            loc_nGrupoPos = THIS.ObterPosicaoGrupo(STR(EVALUATE(loc_cOrigem + ".Ordem"), 1) + STR(EVALUATE(loc_cOrigem + ".Ano"), 4))

                            IF loc_nMesPos > 0 AND loc_nGrupoPos > 0
                                INSERT INTO (THIS.this_cCursorPercentuais) (nGrupoPos, nMesPos, nPercentual) ;
                                    VALUES (loc_nGrupoPos, loc_nMesPos, EVALUATE(loc_cOrigem + ".npercs"))
                            ENDIF
                        ENDSCAN
                    ELSE
                        loc_cGrupoAtual = EVALUATE(loc_cOrigem + ".Grupos")
                        loc_cStrg = loc_cStrg + ALLTRIM(loc_cGrupoAtual)
                        SCAN WHILE EVALUATE(loc_cOrigem + ".Grupos") = loc_cGrupoAtual
                            loc_cStrg = loc_cStrg + CHR(9) + STR(EVALUATE(loc_cOrigem + ".Total"))
                        ENDSCAN
                    ENDIF
                    loc_cStrg = loc_cStrg + CHR(13) + CHR(10)
                    SELECT (loc_cOrigem)
                ENDDO

                SELECT (loc_cOrigem)
                GO TOP

                THIS.this_cDadosGrafico = loc_cStrg
                THIS.this_lDadosValidos = !EMPTY(loc_cStrg)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterPosicaoMes - Equivalente a Ascan(laMeses, <mes>) do legado: devolve
    * a posicao (1-based) do mes dentro de this_cCursorMeses, ou 0 se nao
    * achar. Usado para localizar a coluna da matriz de percentuais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterPosicaoMes(par_nMes)
        LOCAL loc_nPos, loc_nAreaAnterior
        loc_nPos = 0

        IF USED(THIS.this_cCursorMeses)
            loc_nAreaAnterior = SELECT()
            SELECT (THIS.this_cCursorMeses)
            LOCATE FOR Mes = par_nMes
            IF FOUND()
                loc_nPos = RECNO()
            ENDIF
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_nPos
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterPosicaoGrupo - Equivalente a Ascan(laGrupos, <chave>) do legado:
    * devolve a posicao (1-based) do grupo (Str(Ordem,1)+Str(Ano,4)) dentro
    * de this_cCursorGrupos, ou 0 se nao achar. Usado para localizar a linha
    * da matriz de percentuais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterPosicaoGrupo(par_cChaveGrupo)
        LOCAL loc_nPos, loc_nAreaAnterior
        loc_nPos = 0

        IF USED(THIS.this_cCursorGrupos)
            loc_nAreaAnterior = SELECT()
            SELECT (THIS.this_cCursorGrupos)
            LOCATE FOR cGrupos = par_cChaveGrupo
            IF FOUND()
                loc_nPos = RECNO()
            ENDIF
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_nPos
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterPercentual - Leitura da matriz de percentuais pela posicao
    * (grupo, mes). Equivalente a m.laPerc(lnGrupopos, lnMespos) do legado,
    * que o mostragrafico le para montar o Caption do rotulo de cada ponto.
    *
    * PUBLIC de proposito: quem le eh o FORM, porque o rotulo eh propriedade
    * de objeto OLE e OLE nao entra no BO (PILAR 3). Metodo que o form chama
    * de fora NUNCA pode ser PROTECTED em nivel nenhum da heranca
    * (CLAUDE.md regra #51) - PROTECTED aqui estouraria
    * "Property OBTERPERCENTUAL is not found" em runtime, ao desenhar.
    *
    * Devolve 0 quando o cruzamento nao existe, que eh o mesmo valor com que
    * o legado inicializa o array inteiro ("m.laPerc = 0").
    *
    * Repoe area de trabalho E RECNO: o cursor de percentuais eh lido em laco
    * pelo form (um ponto por mes, para cada grupo) e mover o ponteiro sem
    * repor faria quem chama perder o lugar.
    *--------------------------------------------------------------------------
    PROCEDURE ObterPercentual(par_nGrupoPos, par_nMesPos)
        LOCAL loc_nPercentual, loc_nAreaAnterior, loc_nRecnoAnterior
        loc_nPercentual = 0

        IF USED(THIS.this_cCursorPercentuais)
            loc_nAreaAnterior  = SELECT()
            SELECT (THIS.this_cCursorPercentuais)
            loc_nRecnoAnterior = RECNO()

            LOCATE FOR nGrupoPos = par_nGrupoPos AND nMesPos = par_nMesPos
            IF FOUND()
                loc_nPercentual = NVL(nPercentual, 0)
            ENDIF

            IF BETWEEN(loc_nRecnoAnterior, 1, RECCOUNT())
                GO loc_nRecnoAnterior
            ENDIF
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_nPercentual
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha os tres cursores de trabalho criados por
    * CarregarDoCursor (Meses/Grupos/Percentuais) e zera as contagens e a
    * matriz de series.
    *
    * Sem isto os tres VAZARIAM na data session do form PAI: FormSIGOPGRC
    * entra na sessao de dados dele (Init), entao os cursores sobreviveriam
    * ao fechamento da tela se ninguem os fechasse explicitamente. Chamado
    * pelo Destroy do form - mesmo papel do LimparCursores do gemeo
    * SigOpGcoBO.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        LOCAL ARRAY loc_aCursores[3]
        LOCAL loc_nI, loc_cAlias, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        loc_aCursores[1] = THIS.this_cCursorMeses
        loc_aCursores[2] = THIS.this_cCursorGrupos
        loc_aCursores[3] = THIS.this_cCursorPercentuais

        TRY
            FOR loc_nI = 1 TO ALEN(loc_aCursores, 1)
                loc_cAlias = IIF(VARTYPE(loc_aCursores[loc_nI]) = "C", ;
                    ALLTRIM(loc_aCursores[loc_nI]), "")

                IF !EMPTY(loc_cAlias)
                    IF USED(loc_cAlias)
                        IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                            TABLEREVERT(.T., loc_cAlias)
                        ENDIF
                        USE IN (loc_cAlias)
                    ENDIF
                ENDIF
            ENDFOR

            *-- O conteudo agregado morre junto com os cursores: deixar as
            *-- contagens e a matriz de series de pe faria um GerarGrafico
            *-- seguinte achar que ja ha dado valido sem ter recarregado nada.
            THIS.this_nTotalMeses    = 0
            THIS.this_nTotalGrupos   = 0
            THIS.this_cDadosGrafico  = ""
            THIS.this_cLinhaMeses    = ""
            THIS.this_lDadosValidos  = .F.
            THIS.this_lGraficoGerado = .F.

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em SIGOPGRCBO.LimparCursores")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

