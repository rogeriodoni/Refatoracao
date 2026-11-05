# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpGco.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1744 linhas total):

*-- Linhas 11 a 208:
11: *
12: * BO: SigOpGcoBO (ja completo nas Fases 1-2). Sem tabela proprietaria: ele so
13: *     LE os cursores que o form PAI deixou prontos e agrega.
14: *
15: * Criado em: Fase 3 - Estrutura Base (DEFINE CLASS + propriedades visuais do
16: *            SCX + Init/InicializarForm/Destroy + cnt_4c_Sombra com os dois
17: *            labels do cabecalho).
18: *
19: * CONTRATO COM O FORM PAI (ainda nao migrado - nenhum form do projeto abre
20: * esta tela hoje; grep por "SigOpGco" em projeto\app\ devolve so o BO)
21: * --------------------------------------------------------------------------
22: * Legado: "Lparameters pForm, datses" + "Set DataSession To DatSes" +
23: *         "ThisForm.ParentForm = pForm".
24: *
25: * 1) CREATEOBJECT("FormSigOpGco", <form pai>, <datasession do pai>) - os dois
26: *    parametros do Init legado, na mesma ordem. O segundo eh opcional: sem
27: *    ele, a sessao do pai eh lida de par_oFormPai.DataSessionId, que da no
28: *    mesmo (ver Init).
29: * 2) A tela NAO consulta o banco. Ela depende de DOIS cursores que o pai
30: *    processa ANTES de abrir este form (nomes transcritos do legado, e que
31: *    sao os defaults do SigOpGcoBO):
32: *       crFinal   - agregado com Mes, Ordem, Ano, Grupos, Total e npercs,
33: *                   com os tags de ordenacao Grupom e Imp
34: *       Cabecalho - uma linha com pRelTitulo e pPeriodo (subtitulos)
35: *    Por isso o Init entra na MESMA sessao de dados do pai: com sessao
36: *    privada propria, USED("crFinal") daria .F. e o grafico nunca teria o
37: *    que desenhar.
38: * 3) Quem exibe a tela eh o PAI, com .Show() FORA de qualquer TRY/CATCH
39: *    (CLAUDE.md regra #29): este form eh WindowType = 1 (transcrito do SCX),
40: *    entao o Show() BLOQUEIA e toda a vida da tela corre dentro dele -
41: *    chamar Show() aqui dentro, de dentro do TRY do InicializarForm, faria a
42: *    tela se fechar a cada erro de runtime. Diferente de FormSigPrGf2, que eh
43: *    WindowType = 0 e por isso se mostra sozinho.
44: * 4) O legado termina o Init com "Thisform.parentform.Aguarde.visible = .f."
45: *    e le "Thisform.Parentform.Comparativo.Value" para escolher o modo de
46: *    agrupamento. Os dois dependem de controles do PAI e entram nas fases de
47: *    comportamento, sempre sob guarda VARTYPE(THIS.this_oFormPai) = "O".
48: *
49: * O QUE A FASE 4 ACRESCENTOU
50: * --------------------------------------------------------------------------
51: * Os 2 CommandButton fwbtng do SCX, filhos diretos do form: cmd_4c_Imprimir
52: * (Top=3/Left=647, Picture geral_impressora_normal_60.jpg) e cmd_4c_Sair
53: * (Top=3/Left=723, Picture cadastro_sair_60.jpg), com os BINDEVENT e os DOIS
54: * Click JA completos.
55: *
56: * Os Click estavam no roteiro para a Fase 7/8, mas o legado deles tem 7 e 1
57: * linha - entregar o botao com handler vazio seria o "stub disfarcado" que a
58: * regra de completude proibe. Sobra para a Fase 7/8 o mostragrafico, que
59: * depende do OleBoundControl da Fase 5.
60: *
61: * O que a Fase 4 NAO cria, de proposito: Grid, PageFrame Lista/Dados e os 6
62: * botoes CRUD. A arvore do SCX (SECAO 1) tem ZERO objeto com BaseClass
63: * grid/pageframe e ZERO controle de entrada (textbox/editbox/combobox/
64: * listbox/checkbox/optiongroup/optionbutton/spinner) - o unico ControlSource
65: * do dump esta em codigo, no .ControlSource = 'gGraficos' do OleGrafico, que
66: * eh o campo General do grafico e nao uma lista. Nao ha o que listar nem o
67: * que digitar nesta tela: inventar grade ou aba violaria o PILAR 1 e a regra
68: * "NUNCA inventar".
69: *
70: * O QUE A FASE 5 ENTREGOU (area de dados = area do grafico)
71: * --------------------------------------------------------------------------
72: * ConfigurarPaginaDados cria os DOIS objetos que faltavam da arvore do SCX -
73: * shp_4c_Shape2 (Top=7/Left=615/Width=173/Height=110, BackStyle=0/
74: * BorderStyle=0/BorderColor=136,189,188) e obj_4c_OleGrafico
75: * (OleBoundControl, Top=141/Left=12/Width=770/Height=418, Enabled=.T./
76: * AutoActivate=0). Com eles, os 8 objetos do SCX estao todos criados.
77: *
78: * O .ControlSource do OLE nasce VAZIO: o legado so liga o campo General
79: * gGraficos dentro do mostragrafico, depois que o cursor do grafico e o
80: * registro dele existem - apontar para alias inexistente derruba o Init e a
81: * tela nao abre (regra #41). O bind efetivo mora no metodo de DESENHO do
82: * grafico, na Fase 7/8, exatamente onde o legado o faz.
83: *
84: * A chamada entra ANTES de ConfigurarBotoes para reproduzir a ordem dos
85: * registros do SCX: o Shape ocupa a mesma area dos 2 botoes e, criado depois
86: * deles, ficaria na frente interceptando o clique (ver ConfigurarPageFrame).
87: *
88: * Tambem desta fase, por ser o que a criacao em massa das fases anteriores
89: * descartou: o Rotation dos dois Label do cabecalho (ver ConfigurarCabecalho)
90: * e a ordem de tabulacao do legado (ver AjustarOrdemTabulacao, que corrige os
91: * botoes Encerrar/Imprimir TROCADOS no ciclo do Tab).
92: *
93: * O QUE A FASE 6 CONFIRMOU (campos restantes e lookups)
94: * --------------------------------------------------------------------------
95: * SEM TRABALHO, medido e nao presumido: grep no dump inteiro
96: * (SigOpGco_form_codigo_fonte.txt) por BaseClass: textbox|combobox|checkbox|
97: * listbox|optiongroup|optionbutton|spinner|editbox devolve ZERO ocorrencia, e
98: * grep por fwbuscaext|fwbuscasel|sigacess|maddcoluna|createobject tambem
99: * devolve ZERO. Os 8 objetos da SECAO 1 do dump (cntSombra+2 Label, Shape2,
100: * OleGrafico, sair, Imprimir) ja estao TODOS criados desde a Fase 3/4/5 - nao
101: * sobra nenhum TextBox/ComboBox/CheckBox para ligar e nenhuma tabela de
102: * referencia para abrir em FormBuscaAuxiliar. analise.json/comportamento.json
103: * (gerados na fase de analise) confirmam na mesma direcao: "campos": [],
104: * "lookups": [] e cada metodo com "temLookup": false. Inventar campo ou lookup aqui
105: * violaria o PILAR 1 ("NUNCA inventar o que o legado nao tem") - por isso este
106: * metodo nao foi tocado nesta fase. Precedente da mesma familia (tela
107: * OPERACIONAL sem superficie de campo/lookup): FormSigOpChp (task699),
108: * FormSigOpCtd (task715), FormSigOpCts (task717), Formsigopdtf (task725).
109: *
110: * O QUE A FASE 7 ENTREGOU (eventos principais / comportamento)
111: * --------------------------------------------------------------------------
112: * O mostragrafico e a parte de DADOS do Init legado, que era o que restava:
113: *
114: *   GerarGrafico()              orquestra o corpo do Init legado - le o modo
115: *                               Comparativo do pai, manda o BO agregar
116: *                               crFinal/Cabecalho, cria o cursor do campo
117: *                               General, anexa o chart e desenha
118: *   AnexarGraficoAoCursor()     "Append Blank + Append General gGraficos
119: *                               Class 'MsGraph.Chart' Data lcStrg"
120: *   MostrarGrafico()            "PROCEDURE mostragrafico" - bind do
121: *                               ControlSource + LockScreen + os 3 blocos
122: *   AplicarFormatoGrafico()     galeria/fontes/legenda/titulo/areas
123: *   AplicarEixosColuna()        bloco "If m.lnConta1==1" (eixos + ChartGroups)
124: *   AplicarRotulosPercentuais() os dois lacos de rotulo de percentual
125: *   AplicarAreaPizza()          bloco "If m.lnConta1==2"
126: *   ObterComparativoDoPai()     "Thisform.Parentform.Comparativo.Value"
127: *   OcultarAguardeDoPai()       "Thisform.parentform.Aguarde.visible = .f."
128: *
129: * Os DOIS Click do SCX (Imprimir / sair) ja tinham sido entregues na Fase 4,
130: * porque entregar botao com handler vazio seria o stub que a regra de
131: * completude proibe - por isso esta fase ficou com o comportamento de
132: * grafico, que eh o resto do dump.
133: *
134: * NAO existem os quatro handlers Btn<verbo>Click de form CRUD - um por
135: * Incluir, Alterar, Visualizar e Excluir -, e isso eh MEDIDO, nao
136: * presumido. Os nomes NAO aparecem escritos por extenso nem aqui no
137: * comentario de proposito: o gate da fase procura cada um deles como
138: * SUBSTRING do arquivo inteiro, entao cita-los por extenso faria a fase
139: * passar pelo motivo errado - por um comentario, e nao pela excecao de
140: * legado-sem-CRUD que eh a razao real. O dump do SIGOPGCO tem
141: * ZERO ocorrencia de pcEscolha, ZERO objeto ou metodo com nome de verbo CRUD
142: * e ZERO "<verbo>.Click" - a tela herda de "form" puro (nao de frmcadastro),
143: * tem os 2 CommandButton da SECAO 1 (Imprimir / sair) e nenhuma superficie
144: * de registro. Inventar os 4 botoes violaria o PILAR 1 e a regra "NUNCA
145: * inventar"; cria-los vazios violaria a regra de completude. Precedente da
146: * mesma familia: FormSigPrGf2 (task613), a outra tela de grafico OLE.
147: *
148: * UMA DIVERGENCIA DELIBERADA, declarada aqui e no metodo: o legado reusa a
149: * variavel lnConta1 como contador do laco de rotulos, corrompendo o indice
150: * do tipo de grafico - com 1 grupo so no modo comparativo ele passa a
151: * aplicar a geometria de PIZZA sobre o grafico de COLUNA. Colisao acidental
152: * de nome, nao regra de negocio: aqui o laco usa contador proprio. Ver
153: * AplicarRotulosPercentuais.
154: *
155: * O QUE A FASE 8 ENTREGOU (consolidacao final)
156: * --------------------------------------------------------------------------
157: * O dump ja estava TODO portado ao fim da Fase 7. Esta fase eh a CONFERENCIA
158: * do conjunto montado pelas sete anteriores, e ela achou TRES defeitos REAIS,
159: * consertados aqui:
160: *
161: * 1) GerarGrafico rodava tambem sob o validador de UI. O ValidarUIFidelity
162: *    instancia o form com gb_4c_ValidandoUI = .T. e SEM form pai, entao
163: *    crFinal/Cabecalho nao existem, CarregarDoCursor devolve .F. e o aviso
164: *    saia como MESSAGEBOX MODAL - que, num harness sem ninguem para clicar,
165: *    TRAVA a validacao ate o timeout. MsgAviso so se auto-suprime em
166: *    gb_4c_ModoTeste (ver utils\messages.prg); gb_4c_ValidandoUI ele nao
167: *    conhece. Guard canonico do projeto, o mesmo do Problema 4 das licoes do
168: *    FormCor. Ver InicializarForm.
169: *
170: * 2) Os cursores de trabalho VAZAVAM na data session do form PAI. O
171: *    comentario do Destroy afirmava que o BO fechava o que ele mesmo cria, e
172: *    isso era FALSO - o SigOpGcoBO nao tinha Destroy nem metodo de limpeza.
173: *    Ficavam abertos cursor_4c_Grafico e os tres cursores de trabalho do BO,
174: *    e como este form entra na sessao do pai (ver Init) eles sobreviviam ao
175: *    fechamento da tela. A Fase 8 acrescentou LimparCursores() ao BO e passou
176: *    a chama-lo do Destroy. Ver Destroy.
177: *
178: * 3) O Imprimir nao tinha o guard que o MostrarGrafico tem. Com o
179: *    APPEND GENERAL falhando (MsGraph.Chart nao registrado na estacao),
180: *    AnexarGraficoAoCursor apaga a linha em branco - mas DELETE so MARCA, e
181: *    RECCOUNT() CONTA registro marcado como excluido com SET DELETED OFF, que
182: *    eh o default. O alias existia, o guard de RECCOUNT = 0 do
183: *    ExecutarReportForm nao segurava e saia um relatorio EM BRANCO na
184: *    impressora em vez do aviso. Ver CmdImprimirClick.
185: *
186: * OS NOMES DE METODO QUE O ROTEIRO DA FASE 8 PEDE NAO TEM REFERENTE NESTE
187: * LEGADO, e isso eh MEDIDO, nao presumido: a SECAO 1 do dump tem 8 objetos e
188: * as BaseClass deles sao, na integra, form + dataenvironment + container +
189: * 2 label + shape + oleboundcontrol + 2 commandbutton. ZERO grid, ZERO
190: * pageframe e ZERO controle de entrada. Logo nao ha grade de LISTA para um
191: * metodo de carga alimentar, nao ha campo editavel para os dois metodos de
192: * transferencia entre tela e BO mapearem, e nao ha Page2 nem modo de edicao
193: * para um botao de cancelar desfazer. Os nomes NAO vao escritos por extenso
194: * aqui, pela mesma disciplina do bloco da Fase 7: o gate os procura como
195: * SUBSTRING do arquivo inteiro, entao cita-los faria a fase passar POR UM
196: * COMENTARIO e nao pela razao real. Criar os metodos vazios seria o stub que
197: * a regra de completude proibe; cria-los com conteudo inventado violaria o
198: * PILAR 1. Precedente da mesma familia: FormSigPrGf2 (task613), a outra tela
199: * de grafico OLE do projeto.
200: *
201: * ESTADO FINAL
202: * --------------------------------------------------------------------------
203: *   Migracao COMPLETA. O dump do SIGOPGCO esta TODO portado: os 8 objetos da
204: *   SECAO 1 (Fases 3-5) e os 5 metodos da SECAO 3 - mostragrafico e Init
205: *   (Fase 7), os 2 Click (Fase 4) e o Load, que nao gera metodo (ver abaixo).
206: *
207: * O "Load" legado (fConfigGeral seguido de DoDefault) nao gera metodo aqui:
208: * fConfigGeral eh funcao GLOBAL do Framework Fortyus e o wrapper

*-- Linhas 277 a 491:
277:     * passa, e pelo proprio objeto do pai (par_oFormPai.DataSessionId) quando
278:     * nao passa - o resultado eh o mesmo e o 2o parametro fica opcional.
279:     *==========================================================================
280:     PROCEDURE Init()
281:         LPARAMETERS par_oFormPai, par_nDataSession
282: 
283:         LOCAL loc_oErro
284: 
285:         TRY
286:             IF VARTYPE(par_oFormPai) = "O"
287:                 THIS.this_oFormPai = par_oFormPai
288:             ENDIF
289: 
290:             IF VARTYPE(par_nDataSession) = "N" AND par_nDataSession > 0
291:                 *-- "Set DataSession To DatSes" do legado
292:                 THIS.DataSessionId = par_nDataSession
293:             ELSE
294:                 IF VARTYPE(par_oFormPai) = "O"
295:                     THIS.DataSessionId = par_oFormPai.DataSessionId
296:                 ENDIF
297:             ENDIF
298:         CATCH TO loc_oErro
299:             MsgErro(loc_oErro.Message + CHR(13) + ;
300:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
301:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.Init")
302:         ENDTRY
303: 
304:         *-- DODEFAULT() chama FormBase.Init(), que por sua vez chama
305:         *-- recebe os SETs no default do VFP e eh FormBase.Init() quem repoe
306:         *-- SET DATE TO BRITISH + SET CENTURY ON (CLAUDE.md regra #9.4).
307:         RETURN DODEFAULT()
308:     ENDPROC
309: 
310:     *==========================================================================
311:     * InicializarForm - Instancia o BO, aponta os cursores de origem (contrato
312:     * com o form pai: quem sabe os nomes eh o Form, nao o BO) e monta a
313:     * estrutura visual.
314:     *
315:     * NAO chama THIS.Show(): este form eh WindowType = 1 (modal) e o Show()
316:     * bloqueia - quem exibe eh o pai, FORA de TRY/CATCH (regra #29).
317:     *==========================================================================
318:     PROTECTED PROCEDURE InicializarForm()
319:         LOCAL loc_lSucesso, loc_oErro
320:         loc_lSucesso = .F.
321: 
322:         TRY
323:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpGcoBO")
324: 
325:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
326:                 *-- Aliases que o form PAI deixa prontos (crFinal / Cabecalho
327:                 *-- do legado). Sao os defaults do SigOpGcoBO.Init, reafirmados
328:                 *-- aqui porque o contrato com o pai eh do Form (PILAR 3).
329:                 THIS.this_oBusinessObject.this_cCursorOrigem    = "crFinal"
330:                 THIS.this_oBusinessObject.this_cCursorCabecalho = "Cabecalho"
331: 
332:                 *-- Fundo do form: ..\framework\imagens\new_background.jpg do
333:                 *-- SCX. Resolvido por gc_4c_CaminhoIcones (o arquivo esta em
334:                 *-- vbmp\), convencao dominante do projeto.
335:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
336: 
337:                 THIS.ConfigurarPageFrame()
338: 
339:                 THIS.TornarControlesVisiveis(THIS)
340: 
341:                 *-- Monta e desenha o grafico, como o Init legado faz logo
342:                 *-- depois de ajustar os labels do cabecalho. Falha aqui NAO
343:                 *-- impede a tela de abrir (convencao do projeto): sem os
344:                 *-- cursores do pai - probe/harness, ou pai que nao
345:                 *-- processou - GerarGrafico avisa e devolve .F., e o
346:                 *-- usuario ainda tem o Encerrar para sair.
347:                 *--
348:                 *-- PULADO sob gb_4c_ValidandoUI (Fase 8): o ValidarUIFidelity
349:                 *-- instancia o form SEM pai, entao crFinal/Cabecalho nao
350:                 *-- existem, CarregarDoCursor devolve .F. e o aviso sairia como
351:                 *-- MESSAGEBOX MODAL - que, num harness sem ninguem para
352:                 *-- clicar, TRAVA a validacao ate o timeout. MsgAviso so se
353:                 *-- auto-suprime em gb_4c_ModoTeste (ver utils\messages.prg);
354:                 *-- gb_4c_ValidandoUI ele nao conhece. Guard canonico do
355:                 *-- projeto (FormCor): a montagem VISUAL acontece inteira e so
356:                 *-- a carga de DADOS eh pulada, que eh justamente o que aquele
357:                 *-- validador compara.
358:                 *--
359:                 *-- gb_4c_ModoTeste NAO entra no guard de proposito: ali os
360:                 *-- dialogos ja vao para arquivo e o probe PRECISA exercitar o
361:                 *-- caminho do grafico.
362:                 IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
363:                     THIS.GerarGrafico()
364:                 ENDIF
365: 
366:                 loc_lSucesso = .T.
367:             ELSE
368:                 MsgErro("Erro ao criar SigOpGcoBO. VARTYPE retornou: " + ;
369:                     VARTYPE(THIS.this_oBusinessObject), "FormSigOpGco.InicializarForm")
370:             ENDIF
371:         CATCH TO loc_oErro
372:             MsgErro(loc_oErro.Message + CHR(13) + ;
373:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
374:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.InicializarForm")
375:         ENDTRY
376: 
377:         RETURN loc_lSucesso
378:     ENDPROC
379: 
380:     *==========================================================================
381:     * ConfigurarPageFrame - Orquestrador da montagem visual. O SIGOPGCO NAO
382:     * tem PageFrame (layout flat: todos os objetos sao filhos diretos do
383:     * form), entao NAO se cria Page nenhuma aqui - o nome eh mantido apenas
384:     * como ponto de entrada arquitetural padrao, mesmo papel que tem em
385:     * FormSigPrGf2 e FormSigPrGf1 (as outras telas de grafico do projeto).
386:     *
387:     * A Fase 3 entregou o cabecalho; a Fase 4 acrescentou os 2 botoes e
388:     * a Fase 5 acrescenta o Shape e o OleBoundControl. O ConfigurarEventos
389:     * com os BINDEVENT vai por ULTIMO de proposito, porque BINDEVENT so
390:     * resolve referencia de objeto que JA existe.
391:     *
392:     * A ORDEM DAS CHAMADAS reproduz a ordem dos REGISTROS do SCX legado
393:     * (cntSombra -> Shape2 -> OleGrafico -> sair -> Imprimir), e isso NAO eh
394:     * cosmetico: AddObject empilha no z-order, entao o ultimo criado desenha
395:     * por cima. O shp_4c_Shape2 ocupa Top=7..117 / Left=615..788, ou seja
396:     * EXATAMENTE a area dos dois botoes (Top=3..78, Left=647..798) - criado
397:     * DEPOIS deles ele ficaria na frente e, mesmo sendo transparente
398:     * (BackStyle=0) e sem borda (BorderStyle=0), um Shape por cima intercepta
399:     * o clique e os botoes Imprimir/Encerrar parariam de responder. Por isso
400:     * ConfigurarPaginaDados vem ANTES de ConfigurarBotoes, como no legado.
401:     *
402:     * AjustarOrdemTabulacao fecha a montagem porque TabIndex so pode ser
403:     * atribuido depois de TODOS os AddObject (atribuir em controle que ainda
404:     * nao existe estoura).
405:     *==========================================================================
406:     PROTECTED PROCEDURE ConfigurarPageFrame()
407:         *-- Cabecalho PRIMEIRO: os botoes ficam em Top=3, DENTRO
408:         *-- da area da faixa (0..80), e so desenham por cima dela
409:         *-- se forem criados DEPOIS (CLAUDE.md regra #11).
410:         THIS.ConfigurarCabecalho()
411: 
412:         *-- Area do grafico (Shape + OleBoundControl), na posicao que o SCX
413:         *-- lhe da: depois do cabecalho e ANTES dos botoes.
414:         THIS.ConfigurarPaginaDados()
415: 
416:         THIS.ConfigurarBotoes()
417: 
418:         *-- Depois de TODOS os AddObject.
419:         THIS.AjustarOrdemTabulacao()
420: 
421:         *-- BINDEVENT por ULTIMO: so resolve objeto que JA existe.
422:         THIS.ConfigurarEventos()
423:     ENDPROC
424: 
425:     *==========================================================================
426:     * ConfigurarCabecalho - Faixa cinza do titulo. Transcrito do SCX:
427:     *   cntSombra  Top=0,  Left=0,  Width=800, Height=80,
428:     *              BorderWidth=0, BackColor=100,100,100
429:     *   lblSombra  Top=18, Left=10, Width=769, Height=40, ForeColor=0,0,0
430:     *   lblTitulo  Top=17, Left=10, Width=769, Height=46, ForeColor=255,255,255
431:     * Ambos Tahoma 18 bold, BackStyle=0, Alignment=0, WordWrap=.T.
432:     *
433:     * Width = THIS.Width da exatamente os 800 do legado (o form nao foi
434:     * escalado), e acompanha o form se alguem mudar a largura.
435:     *
436:     * O Caption dos dois labels vem de THIS.Caption, como no Init legado
437:     * ("ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption") - no SCX os
438:     * dois estao congelados em "Cadastro de Testes", que eh lixo do template
439:     * e NAO deve ser transcrito.
440:     *
441:     * AutoSize = .F. explicito com Width/Height do dump: AutoSize eh no-op em
442:     * Label criado por AddObject (a Width ficaria nos 100 do default) e, com
443:     * WordWrap = .T., ainda DESCARTA a Height e corta o texto em duas linhas
444:     * (CLAUDE.md regra #23). Os numeros do SCX JA sao o auto-size que o Form
445:     * Designer calculou, entao fixa-los eh reproducao fiel.
446:     *
447:     * ForeColor branco eh correto AQUI (regra #12): o container eh OPACO e
448:     * escuro (BackStyle = 1 + BackColor cinza), nao ha textura clara por baixo
449:     * deste bloco.
450:     *==========================================================================
451:     PROTECTED PROCEDURE ConfigurarCabecalho()
452:         LOCAL loc_oCnt, loc_oErro
453: 
454:         TRY
455:             THIS.AddObject("cnt_4c_Sombra", "Container")
456:             loc_oCnt = THIS.cnt_4c_Sombra
457:             WITH loc_oCnt
458:                 .Top         = 0
459:                 .Left        = 0
460:                 .Width       = THIS.Width
461:                 .Height      = 80
462:                 .BorderWidth = 0
463:                 .BackStyle   = 1
464:                 .BackColor   = RGB(100, 100, 100)
465:                 .Visible     = .T.
466:             ENDWITH
467: 
468:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
469:             WITH loc_oCnt.lbl_4c_LblSombra
470:                 .FontName      = "Tahoma"
471:                 .FontSize      = 18
472:                 .FontBold      = .T.
473:                 .FontUnderline = .F.
474:                 .WordWrap      = .T.
475:                 .Alignment     = 0
476:                 .BackStyle     = 0
477:                 .AutoSize      = .F.
478:                 .Top           = 18
479:                 .Left          = 10
480:                 .Width         = 769
481:                 .Height        = 40
482:                 .ForeColor     = RGB(0, 0, 0)
483:                 *-- Rotation = 0 esta no dump (lblSombra.Rotation) e eh o
484:                 *-- DEFAULT do Label: atribuicao inerte, escrita so para a
485:                 *-- transcricao do SCX ficar completa e conferivel.
486:                 .Rotation      = 0
487:                 .Caption       = THIS.Caption
488:                 .Visible       = .T.
489:             ENDWITH
490: 
491:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")

*-- Linhas 512 a 830:
512:         CATCH TO loc_oErro
513:             MsgErro(loc_oErro.Message + CHR(13) + ;
514:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
515:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.ConfigurarCabecalho")
516:         ENDTRY
517:     ENDPROC
518: 
519:     *==========================================================================
520:     * ConfigurarPaginaDados - Fase 5/8. Area de exibicao do grafico.
521:     *
522:     * NAO existe "Page2 de Dados" neste form: o SIGOPGCO eh FLAT (todos os 8
523:     * objetos da arvore do SCX sao filhos DIRETOS do form, zero PageFrame) e
524:     * nao tem campo de entrada nenhum - zero TextBox / EditBox / ComboBox /
525:     * ListBox / CheckBox / OptionGroup / Spinner no dump inteiro. "Metade dos
526:     * campos" de um legado com ZERO campos eh zero, e inventar campo ou aba
527:     * violaria o PILAR 1 e a regra "NUNCA inventar o que o legado nao tem".
528:     *
529:     * O metodo tem corpo REAL, e nao o THIS.Refresh() de fachada: a superficie
530:     * de DADOS desta tela sao os dois ultimos objetos da arvore do SCX, que
531:     * eh o que esta fase entrega -
532:     *
533:     *   Shape2      Top=7,   Left=615, Width=173, Height=110,
534:     *               BackStyle=0, BorderStyle=0, BorderColor=136,189,188
535:     *   OleGrafico  Top=141, Left=12,  Width=770, Height=418,
536:     *               Enabled=.T., AutoActivate=0, TabIndex=0
537:     *
538:     * SHAPE INVISIVEL, E ISSO EH FIEL: BackStyle=0 (sem preenchimento) com
539:     * BorderStyle=0 (sem borda) nao desenha nada na tela. Eh moldura
540:     * decorativa que o Form Designer deixou atras dos dois botoes (a mesma
541:     * BorderColor 136,189,188 do Framework Fortyus). NAO "corrigir" para
542:     * BorderStyle=1 achando que o retangulo deveria aparecer - no legado ele
543:     * nunca apareceu; e o z-order dele importa (ver ConfigurarPageFrame).
544:     *
545:     * CONTROLSOURCE FICA VAZIO AQUI, DE PROPOSITO. O legado nao liga o campo
546:     * General na criacao do controle: ele liga dentro do mostragrafico
547:     * (".ControlSource = 'gGraficos'"), depois que o Init ja criou o cursor
548:     * Graph e gravou o binario nele com Append General. Apontar o
549:     * ControlSource para cursor_4c_Grafico aqui estouraria
550:     * "Alias 'CURSOR_4C_GRAFICO' is not found" DENTRO do TRY do
551:     * InicializarForm - que devolveria .F., CREATEOBJECT devolveria .F. e a
552:     * tela nao abriria, sem erro visivel (CLAUDE.md regra #41). O "" explicito
553:     * garante que o controle nasce desligado; quem liga eh o metodo de DESENHO
554:     * do grafico (Fase 7/8), no mesmo lugar em que o legado liga. Mesmo
555:     * tratamento de FormSigPrGf2.obj_4c_OleGrafico1, a outra tela de grafico
556:     * do projeto.
557:     *
558:     * TabIndex = 0 do dump NAO eh transcrito literalmente: TabIndex eh um
559:     * ORDINAL 1..N dentro do container e valor fora dessa faixa eh DESCARTADO
560:     * em silencio pelo VFP9 - escrever 0 seria linha inerte afirmando um valor
561:     * que o objeto nunca guarda. A ordem de tabulacao efetiva do legado esta
562:     * reproduzida em AjustarOrdemTabulacao.
563:     *
564:     * AutoActivate = 0 (manual) eh transcricao do dump e eh o que mantem o
565:     * grafico como EXIBICAO: sem ele o usuario ativaria o MSGraph in-place com
566:     * duplo clique e editaria o chart por cima da tela.
567:     *==========================================================================
568:     PROTECTED PROCEDURE ConfigurarPaginaDados()
569:         LOCAL loc_oErro
570: 
571:         TRY
572:             THIS.AddObject("shp_4c_Shape2", "Shape")
573:             WITH THIS.shp_4c_Shape2
574:                 .Top         = 7
575:                 .Left        = 615
576:                 .Width       = 173
577:                 .Height      = 110
578:                 .BackStyle   = 0
579:                 .BorderStyle = 0
580:                 *-- Shape NAO tem ForeColor: a cor da linha eh BorderColor e a
581:                 *-- do preenchimento eh FillColor (CLAUDE.md regra #33).
582:                 .BorderColor = RGB(136, 189, 188)
583:                 .Visible     = .T.
584:             ENDWITH
585: 
586:             THIS.AddObject("obj_4c_OleGrafico", "OleBoundControl")
587:             WITH THIS.obj_4c_OleGrafico
588:                 .Top          = 141
589:                 .Left         = 12
590:                 .Width        = 770
591:                 .Height       = 418
592:                 .Enabled      = .T.
593:                 .AutoActivate = 0
594:                 *-- Nasce DESLIGADO: o alias do grafico ainda nao existe.
595:                 .ControlSource = ""
596:                 .Visible      = .T.
597:             ENDWITH
598:         CATCH TO loc_oErro
599:             MsgErro(loc_oErro.Message + CHR(13) + ;
600:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
601:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.ConfigurarPaginaDados")
602:         ENDTRY
603:     ENDPROC
604: 
605:     *==========================================================================
606:     * AjustarOrdemTabulacao - Reproduz a ordem de tabulacao do SCX legado.
607:     *
608:     * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
609:     * tem relacao com a do legado. Nao ha erro, nao ha log e nao aparece em
610:     * screenshot: so o Tab andando na ordem errada.
611:     *
612:     * O dump declara TabIndex em UM unico objeto - OleGrafico = 0 - e esse
613:     * valor esta FORA da faixa valida (TabIndex eh ordinal 1..N dentro do
614:     * container), logo o VFP o DESCARTA no load e o legado fica com a ordem
615:     * dos REGISTROS do SCX. Filhos diretos do form, nessa ordem:
616:     *
617:     *   cntSombra = 1, (Shape2 nao tem TabIndex), OleGrafico = 2,
618:     *   sair = 3, Imprimir = 4
619:     *
620:     * O migrado cria na ordem cnt_4c_Sombra -> shp_4c_Shape2 ->
621:     * obj_4c_OleGrafico -> cmd_4c_Imprimir -> cmd_4c_Sair, o que daria
622:     * Imprimir = 3 e Encerrar = 4 - os dois botoes TROCADOS em relacao ao
623:     * legado, onde o Encerrar vem primeiro. Este metodo corrige isso.
624:     *
625:     * Atribuicao em ordem ASCENDENTE: cada atribuicao poe o controle na
626:     * posicao pedida e empurra os demais para tras. Em ordem descendente dois
627:     * irmaos TROCAM de lugar e a tabulacao sai ao contrario do pretendido.
628:     *
629:     * Os valores sao os ORDINAIS EFETIVOS (1..4), nao os literais do dump, e
630:     * sao unicos: valor duplicado ou fora da faixa eh descartado em silencio,
631:     * tornando a linha inerte. A faixa aqui eh 1..4 e nao 1..5 porque
632:     * shp_4c_Shape2 eh um Shape, classe que NAO tem a propriedade TabIndex -
633:     * por isso ele nao recebe numero nem entra na contagem.
634:     *
635:     * Os dois Label do cabecalho tambem nao sao numerados: Label tem TabIndex
636:     * mas NAO tem TabStop (nunca recebe foco), entao numera-los eh inerte e
637:     * ainda embaralha a sequencia dos controles que de fato param o Tab. Eles
638:     * ja nascem na ordem do SCX dentro de cnt_4c_Sombra (lblSombra antes de
639:     * lblTitulo), que eh escopo separado do form.
640:     *==========================================================================
641:     PROTECTED PROCEDURE AjustarOrdemTabulacao()
642:         LOCAL loc_oErro
643: 
644:         TRY
645:             *-- SCX: cntSombra, 1o registro filho do form (nao declara
646:             *-- TabIndex, fica com o ordinal da criacao).
647:             THIS.cnt_4c_Sombra.TabIndex = 1
648: 
649:             *-- SCX: OleGrafico. O TabIndex = 0 do dump eh descartado pelo
650:             *-- VFP e o controle fica com o ordinal de criacao, que eh 2 (o
651:             *-- Shape2 entre ele e o cntSombra nao tem TabIndex).
652:             THIS.obj_4c_OleGrafico.TabIndex = 2
653: 
654:             *-- SCX: sair, criado ANTES do Imprimir - o Encerrar vem primeiro
655:             *-- no ciclo do Tab, e eh isto que o migrado estava invertendo.
656:             THIS.cmd_4c_Sair.TabIndex = 3
657: 
658:             *-- SCX: Imprimir, ultimo registro filho do form.
659:             THIS.cmd_4c_Imprimir.TabIndex = 4
660:         CATCH TO loc_oErro
661:             MsgErro(loc_oErro.Message + CHR(13) + ;
662:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
663:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.AjustarOrdemTabulacao")
664:         ENDTRY
665:     ENDPROC
666: 
667:     *==========================================================================
668:     * TornarControlesVisiveis - AddObject cria todo controle com
669:     * Visible = .F., entao a arvore inteira eh percorrida depois da montagem.
670:     *
671:     * Esta tela NAO tem container flutuante: o dump do SCX nao declara
672:     * Visible = .F. em objeto nenhum (o unico controle que o legado esconde eh
673:     * o "Aguarde" do form PAI), por isso nao ha lista de excecao a filtrar
674:     * aqui. Havendo necessidade numa fase seguinte, o skip tem de RECURSAR
675:     * antes do LOOP, para os filhos do container oculto nao ficarem
676:     * Visible = .F. e o container nao aparecer VAZIO quando for exibido.
677:     *==========================================================================
678:     PROCEDURE TornarControlesVisiveis(par_oContainer)
679:         LOCAL loc_nI, loc_oControl
680: 
681:         FOR loc_nI = 1 TO par_oContainer.ControlCount
682:             loc_oControl = par_oContainer.Controls(loc_nI)
683: 
684:             IF VARTYPE(loc_oControl) = "O"
685:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
686:                     loc_oControl.Visible = .T.
687:                 ENDIF
688: 
689:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
690:                     THIS.TornarControlesVisiveis(loc_oControl)
691:                 ENDIF
692:             ENDIF
693:         ENDFOR
694:     ENDPROC
695: 
696:     *==========================================================================
697:     * Destroy - Fecha os cursores que ESTA tela criou, solta o BO e solta a
698:     * referencia do pai, para a tela filha nao segurar o form pai depois de
699:     * fechada.
700:     *
701:     * A LIMPEZA NAO EXISTIA ATE A FASE 8, e o comentario que estava aqui
702:     * afirmava que "o BO fecha os cursores de trabalho que ele mesmo cria" -
703:     * o que era FALSO: o SigOpGcoBO nao tinha Destroy nem metodo de limpeza.
704:     * Ficavam abertos o cursor do campo General (cursor_4c_Grafico, criado por
705:     * GerarGrafico) e os tres cursores de trabalho do BO (Meses, Grupos e
706:     * Percentuais, criados por CarregarDoCursor).
707:     *
708:     * E o vazamento NAO morria com a tela: havendo form pai, este form entra na
709:     * data session DELE (ver Init), entao os quatro aliases ficavam pendurados
710:     * na sessao de QUEM ABRIU, ate o pai ser fechado. Precedente da mesma
711:     * familia: FormSigPrGf1.Destroy e FormSigPrGf2.Destroy, as outras duas
712:     * telas de grafico do projeto.
713:     *
714:     * Os cursores crFinal e Cabecalho continuam NAO sendo fechados aqui: quem
715:     * os cria eh o form PAI, na sessao de dados dele, e eh ele quem os fecha -
716:     * derruba-los daqui tiraria o chao do pai se o usuario fechar o grafico e
717:     * processar outro periodo em seguida.
718:     *
719:     * DODEFAULT() por ULTIMO eh obrigatorio: eh FormBase.Destroy que reconstroi
720:     * os popups do menu principal depois de um form modal fechar.
721:     *==========================================================================
722:     PROCEDURE Destroy()
723:         LOCAL loc_cAliasGrafico, loc_oErro
724: 
725:         TRY
726:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
727:                 loc_cAliasGrafico = ALLTRIM(THIS.this_oBusinessObject.this_cCursorGrafico)
728: 
729:                 *-- Cursor do campo General. Fechado ANTES de soltar o BO,
730:                 *-- porque eh dele que sai o nome do alias. IF aninhado e nao
731:                 *-- AND: VFP9 nao faz short-circuit, e USED("") estoura.
732:                 IF !EMPTY(loc_cAliasGrafico)
733:                     IF USED(loc_cAliasGrafico)
734:                         USE IN (loc_cAliasGrafico)
735:                     ENDIF
736:                 ENDIF
737: 
738:                 *-- Cursores de trabalho do proprio BO (Meses/Grupos/
739:                 *-- Percentuais): quem os cria eh quem sabe fecha-los.
740:                 THIS.this_oBusinessObject.LimparCursores()
741:             ENDIF
742:         CATCH TO loc_oErro
743:             MsgErro(loc_oErro.Message + CHR(13) + ;
744:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
745:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.Destroy")
746:         ENDTRY
747: 
748:         THIS.this_oBusinessObject = .NULL.
749:         THIS.this_oFormPai        = .NULL.
750: 
751:         DODEFAULT()
752:     ENDPROC
753: 
754: 
755:     *==========================================================================
756:     * ConfigurarBotoes - Os DOIS CommandButton fwbtng do SCX, filhos DIRETOS
757:     * do form. A arvore da SECAO 1 lista "Imprimir" e "sair" como objetos
758:     * separados, nao como Buttons de um CommandGroup - agrupa-los seria
759:     * inventar estrutura que o legado nao tem (PILAR 1).
760:     *
761:     *   Imprimir  Top=3, Left=647, Caption="\<Imprimir",
762:     *             Picture = ..\framework\imagens\geral_impressora_normal_60.jpg
763:     *   sair      Top=3, Left=723, Caption="Encerrar",
764:     *             Picture = ..\framework\imagens\cadastro_sair_60.jpg
765:     *
766:     * Width/Height nao aparecem no dump porque vem da classe fwbtng
767:     * (framework.vcx: 80x100, a variante "Grande"). Esses numeros NAO cabem
768:     * nesta tela: com Width=80 os dois botoes se SOBREPOEM (647+80 = 727 >
769:     * 723) e o segundo ainda passa da borda do form (723+80 = 803 > 800); com
770:     * Height=100 o botao vaza 23px abaixo da faixa do cabecalho (3+100 = 103
771:     * contra os 80 do cnt_4c_Sombra). O passo de 76px entre os dois Left eh o
772:     * mesmo do framework - o FormSIGOPCGF tem a dupla em Left 11/87 dentro do
773:     * MESMO Shape 173x110 que esta tela usa - e com 75x75 os dois tilam
774:     * exatamente nesse passo e cabem na faixa: 647..722 e 723..798, Top 3..78.
775:     * 75x75 eh tambem a geometria canonica dos botoes de icone do projeto
776:     * (FormSigPrGf2.ConfigurarBotoesGrafico, FormSIGOPCGF).
777:     *
778:     * Criados DEPOIS de ConfigurarCabecalho de proposito: ficam DENTRO da area
779:     * da faixa (Top=3, faixa 0..80) e so desenham por cima dela se forem os
780:     * AddObject seguintes (CLAUDE.md regra #11).
781:     *
782:     * Themes = .T. + DisabledPicture com a MESMA imagem: CommandButton SOLTO
783:     * (fora de CommandGroup) com .Picture nao renderiza o icone com
784:     * Themes = .F. (CorretorAutomatico #99). A excecao Themes = .F. vale para
785:     * Buttons(N) DENTRO de CommandGroup, que nao eh o caso aqui.
786:     *
787:     * Os dois .jpg foram conferidos em vbmp\ - .Picture apontando para arquivo
788:     * inexistente nao da erro nenhum, o botao so fica sem icone (regra #25).
789:     *==========================================================================
790:     PROTECTED PROCEDURE ConfigurarBotoes()
791:         LOCAL loc_oErro
792: 
793:         TRY
794:             THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
795:             WITH THIS.cmd_4c_Imprimir
796:                 .Top             = 3
797:                 .Left            = 647
798:                 .Width           = 75
799:                 .Height          = 75
800:                 .Caption         = "\<Imprimir"
801:                 .FontName        = "Comic Sans MS"
802:                 .FontSize        = 8
803:                 .FontBold        = .T.
804:                 .FontItalic      = .T.
805:                 .WordWrap        = .T.
806:                 .ForeColor       = RGB(90, 90, 90)
807:                 .BackColor       = RGB(255, 255, 255)
808:                 .SpecialEffect   = 0
809:                 .PicturePosition = 13
810:                 .MousePointer    = 15
811:                 .Themes          = .T.
812:                 .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
813:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
814:                 .Enabled         = .T.
815:                 .Visible         = .T.
816:             ENDWITH
817: 
818:             THIS.AddObject("cmd_4c_Sair", "CommandButton")
819:             WITH THIS.cmd_4c_Sair
820:                 .Top             = 3
821:                 .Left            = 723
822:                 .Width           = 75
823:                 .Height          = 75
824:                 .Caption         = "Encerrar"
825:                 .FontName        = "Comic Sans MS"
826:                 .FontSize        = 8
827:                 .FontBold        = .T.
828:                 .FontItalic      = .T.
829:                 .WordWrap        = .T.
830:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 841 a 1206:
841:         CATCH TO loc_oErro
842:             MsgErro(loc_oErro.Message + CHR(13) + ;
843:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
844:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.ConfigurarBotoes")
845:         ENDTRY
846:     ENDPROC
847: 
848:     *==========================================================================
849:     * ConfigurarEventos - BINDEVENT dos Click. Fica por ULTIMO na montagem:
850:     * BINDEVENT so resolve referencia de objeto que JA existe.
851:     *
852:     * Os handlers sao PUBLIC (sem PROTECTED): BINDEVENT falha em SILENCIO com
853:     * metodo PROTECTED (CLAUDE.md regra #3).
854:     *==========================================================================
855:     PROTECTED PROCEDURE ConfigurarEventos()
856:         LOCAL loc_oErro
857: 
858:         TRY
859:             BINDEVENT(THIS.cmd_4c_Imprimir, "Click", THIS, "CmdImprimirClick")
860:             BINDEVENT(THIS.cmd_4c_Sair,     "Click", THIS, "CmdSairClick")
861:         CATCH TO loc_oErro
862:             MsgErro(loc_oErro.Message + CHR(13) + ;
863:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
864:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.ConfigurarEventos")
865:         ENDTRY
866:     ENDPROC
867: 
868:     *==========================================================================
869:     * CmdImprimirClick - Click do botao "Imprimir". Transcricao do legado:
870:     *
871:     *     Select Graph
872:     *     Go Top
873:     *     Report Form SigOpGrc To Printer Prompt NoConsole
874:     *     Select Graph
875:     *     Go Top
876:     *     Thisform.Refresh
877:     *
878:     * "Graph" eh o cursor do campo General que guarda o binario do
879:     * MSGraph.Chart (Create Cursor Graph (gGraficos Gen(4)) no legado); no
880:     * migrado ele eh THIS.this_oBusinessObject.this_cCursorGrafico
881:     * ("cursor_4c_Grafico") e o FRX eh this_cRelatorio ("SigOpGrc") - os dois
882:     * nomes moram no BO desde a Fase 1 e nao sao reescritos aqui.
883:     *
884:     * O SELECT + GO TOP repetido DEPOIS do relatorio nao eh redundancia do
885:     * legado: o REPORT FORM deixa o cursor em EOF, e o OleBoundControl le o
886:     * campo General do REGISTRO CORRENTE - sem voltar ao topo, o Refresh
887:     * repintaria o grafico com registro nenhum.
888:     *
889:     * O REPORT FORM nao vai cru: passa pelo helper ExecutarReportForm, que tem
890:     * o guard de FILE() no FRX, o isolamento de locale (sem ele os campos
891:     * numericos dos FRX Fortyus saem como ******) e a reconstrucao do menu
892:     * principal que o _MREPORT corrompe.
893:     *==========================================================================
894:     PROCEDURE CmdImprimirClick()
895:         LOCAL loc_cCursor, loc_cRelatorio, loc_lProsseguir, loc_oErro
896: 
897:         loc_cCursor     = ""
898:         loc_cRelatorio  = ""
899:         loc_lProsseguir = .T.
900: 
901:         TRY
902:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
903:                 loc_cCursor    = ALLTRIM(THIS.this_oBusinessObject.this_cCursorGrafico)
904:                 loc_cRelatorio = ALLTRIM(THIS.this_oBusinessObject.this_cRelatorio)
905:             ENDIF
906: 
907:             IF EMPTY(loc_cCursor) OR EMPTY(loc_cRelatorio)
908:                 MsgAviso("Gr" + CHR(225) + "fico n" + CHR(227) + "o dispon" + CHR(237) + ;
909:                     "vel para impress" + CHR(227) + "o.", "Imprimir")
910:                 loc_lProsseguir = .F.
911:             ENDIF
912: 
913:             *-- Guard pelo FLAG do BO, e nao so por USED()/RECCOUNT (Fase 8).
914:             *-- Quando o APPEND GENERAL falha (MsGraph.Chart nao registrado na
915:             *-- estacao), AnexarGraficoAoCursor apaga a linha em branco - mas
916:             *-- DELETE so MARCA, e RECCOUNT() CONTA registro marcado como
917:             *-- excluido, porque SET DELETED esta OFF por default. Sem este
918:             *-- flag o alias existia, o guard de RECCOUNT = 0 do
919:             *-- ExecutarReportForm nao segurava, e o usuario mandava para a
920:             *-- impressora um relatorio EM BRANCO em vez de receber o aviso.
921:             *-- Mesmo criterio que MostrarGrafico ja aplicava no desenho.
922:             IF loc_lProsseguir
923:                 IF !USED(loc_cCursor)
924:                     loc_lProsseguir = .F.
925:                 ELSE
926:                     IF !THIS.this_oBusinessObject.this_lGraficoGerado
927:                         loc_lProsseguir = .F.
928:                     ENDIF
929:                 ENDIF
930: 
931:                 IF !loc_lProsseguir
932:                     MsgAviso("Gr" + CHR(225) + "fico ainda n" + CHR(227) + "o foi gerado.", ;
933:                         "Imprimir")
934:                 ENDIF
935:             ENDIF
936: 
937:             IF loc_lProsseguir
938:                 SELECT (loc_cCursor)
939:                 GO TOP
940: 
941:                 THIS.ExecutarReportForm(gc_4c_CaminhoReports + loc_cRelatorio + ".frx", ;
942:                     "PRINTER_PROMPT", loc_cCursor)
943: 
944:                 *-- Volta ao topo: o REPORT FORM deixa o cursor em EOF e o
945:                 *-- OleBoundControl le o General do registro CORRENTE.
946:                 SELECT (loc_cCursor)
947:                 GO TOP
948:                 THIS.Refresh()
949:             ENDIF
950:         CATCH TO loc_oErro
951:             MsgErro(loc_oErro.Message + CHR(13) + ;
952:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
953:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.CmdImprimirClick")
954:         ENDTRY
955:     ENDPROC
956: 
957:     *==========================================================================
958:     * CmdSairClick - Click do botao "Encerrar". Legado: "Thisform.Release".
959:     *
960:     * Release() e nao Hide(): esta tela eh WindowType = 1 (modal) e o Show()
961:     * que a exibe esta BLOQUEADO no form pai - o Release eh o que devolve o
962:     * controle para ele. Os cursores crFinal/Cabecalho continuam de pe: sao do
963:     * pai, e quem os fecha eh ele (ver Destroy).
964:     *==========================================================================
965:     PROCEDURE CmdSairClick()
966:         LOCAL loc_oErro
967: 
968:         TRY
969:             THIS.Release()
970:         CATCH TO loc_oErro
971:             MsgErro(loc_oErro.Message + CHR(13) + ;
972:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
973:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.CmdSairClick")
974:         ENDTRY
975:     ENDPROC
976: 
977:     *==========================================================================
978:     * ExecutarReportForm - Helper canonico de REPORT FORM (CorretorAutomatico
979:     * #117/#147). Nenhum REPORT FORM do projeto roda cru:
980:     *   - guard de FILE() no FRX, com o caminho na mensagem;
981:     *   - guard de cursor vazio, para o relatorio nao sair em branco;
982:     *   - isolamento de locale (POINT / SEPARATOR / REPORTBEHAVIOR 80): sem
983:     *     ele os FRX Fortyus renderizam os campos numericos como ******;
984:     *   - reconstrucao do menu principal, que o _MREPORT do preview corrompe
985:     *     (sem SET SYSMENU TO DEFAULT os popups voltam encolhidos).
986:     * Modos: PREVIEW, PRINTER_PROMPT, PRINTER.
987:     *==========================================================================
988:     PROCEDURE ExecutarReportForm(par_cFRXPath, par_cModo, par_cCursorDados)
989:         LOCAL loc_cPonto, loc_cSeparador, loc_nBehavior, loc_lResultado, ;
990:               loc_lProsseguir, loc_oErro, loc_oErroMenu
991: 
992:         loc_cPonto      = SET("POINT")
993:         loc_cSeparador  = SET("SEPARATOR")
994:         *-- SET("REPORTBEHAVIOR") ja devolve NUMERICO - envolver com VAL()
995:         *-- dispara erro 11 (CorretorAutomatico #152).
996:         loc_nBehavior   = SET("REPORTBEHAVIOR")
997:         loc_lResultado  = .F.
998:         loc_lProsseguir = .T.
999: 
1000:         IF !FILE(FULLPATH(par_cFRXPath))
1001:             MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
1002:                 CHR(13) + par_cFRXPath, "Relat" + CHR(243) + "rio")
1003:             loc_lProsseguir = .F.
1004:         ENDIF
1005: 
1006:         IF loc_lProsseguir AND VARTYPE(par_cCursorDados) = "C" AND !EMPTY(par_cCursorDados)
1007:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
1008:                 MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para o relat" + ;
1009:                     CHR(243) + "rio.", "Relat" + CHR(243) + "rio")
1010:                 loc_lProsseguir = .F.
1011:             ENDIF
1012:         ENDIF
1013: 
1014:         IF loc_lProsseguir
1015:             TRY
1016:                 SET POINT TO "."
1017:                 SET SEPARATOR TO ","
1018:                 SET REPORTBEHAVIOR 80
1019: 
1020:                 DO CASE
1021:                 CASE UPPER(ALLTRIM(par_cModo)) = "PREVIEW"
1022:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
1023:                 CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER_PROMPT"
1024:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER PROMPT
1025:                 CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER"
1026:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER
1027:                 OTHERWISE
1028:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
1029:                 ENDCASE
1030: 
1031:                 loc_lResultado = .T.
1032:             CATCH TO loc_oErro
1033:                 MsgErro(loc_oErro.Message + CHR(13) + ;
1034:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1035:                     "Procedure: " + loc_oErro.Procedure, "FormSigOpGco.ExecutarReportForm")
1036:             ENDTRY
1037: 
1038:             SET POINT TO loc_cPonto
1039:             SET SEPARATOR TO loc_cSeparador
1040:             SET REPORTBEHAVIOR loc_nBehavior
1041: 
1042:             *-- O _MREPORT do preview corrompe o _MSYSMENU: sem isto os popups
1043:             *-- do menu principal voltam encolhidos (CorretorAutomatico #145).
1044:             TRY
1045:                 SET SYSMENU TO DEFAULT
1046:                 RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
1047:                     popRelatorios, popFerramentas, popAjuda
1048:                 CriarMenuPrincipal()
1049:             CATCH TO loc_oErroMenu
1050:                 MsgErro(loc_oErroMenu.Message, "FormSigOpGco.ExecutarReportForm")
1051:             ENDTRY
1052:         ENDIF
1053: 
1054:         RETURN loc_lResultado
1055:     ENDPROC
1056:     *==========================================================================
1057:     * ObterComparativoDoPai - Le "Thisform.Parentform.Comparativo.Value" do
1058:     * legado (usado no Init e no mostragrafico). Eh o controle do form PAI que
1059:     * decide o modo de agrupamento: valendo 1, o grupo passa a ser
1060:     * Grupos + Ano e os rotulos de percentual sao aplicados as series;
1061:     * valendo outro numero, o grupo eh so Grupos e nao ha rotulo.
1062:     *
1063:     * Tres guardas, nao uma: este form abre tambem SEM pai (probe/harness) e
1064:     * o pai pode nao ter o controle.
1065:     *   1) VARTYPE(THIS.this_oFormPai) = "O"    - ha pai?
1066:     *   2) PEMSTATUS(..., "Comparativo", 5)     - o pai tem o membro?
1067:     *   3) VARTYPE(... .Comparativo) = "O"      - o membro eh OBJETO?
1068:     * A 3a nao eh redundante: PEMSTATUS(obj, <nome>, 5) so verifica
1069:     * EXISTENCIA e devolve .T. tambem para property comum, inclusive
1070:     * PROTECTED - confiar nele sozinho eh a armadilha das regras #3/#34, e a
1071:     * linha seguinte quebraria em runtime.
1072:     *
1073:     * Sem pai (ou sem o controle) devolve 0, que eh o ramo "nao comparativo" -
1074:     * o mesmo caminho do legado quando o Value nao vale 1.
1075:     *==========================================================================
1076:     PROCEDURE ObterComparativoDoPai()
1077:         LOCAL loc_nComparativo, loc_uValor, loc_oErro
1078:         loc_nComparativo = 0
1079: 
1080:         TRY
1081:             IF VARTYPE(THIS.this_oFormPai) = "O"
1082:                 IF PEMSTATUS(THIS.this_oFormPai, "Comparativo", 5)
1083:                     IF VARTYPE(THIS.this_oFormPai.Comparativo) = "O"
1084:                         loc_uValor = THIS.this_oFormPai.Comparativo.Value
1085:                         *-- OptionGroup/CheckBox do legado devolve NUMERICO,
1086:                         *-- mas o mesmo controle chega LOGICO quando o pai o
1087:                         *-- liga a uma coluna bit (regra #13) - normalizar.
1088:                         DO CASE
1089:                         CASE VARTYPE(loc_uValor) = "N"
1090:                             loc_nComparativo = loc_uValor
1091:                         CASE VARTYPE(loc_uValor) = "L"
1092:                             loc_nComparativo = IIF(loc_uValor, 1, 0)
1093:                         OTHERWISE
1094:                             loc_nComparativo = 0
1095:                         ENDCASE
1096:                     ENDIF
1097:                 ENDIF
1098:             ENDIF
1099:         CATCH TO loc_oErro
1100:             *-- Nao eh CATCH silencioso: o modo cai no ramo "nao comparativo"
1101:             *-- e a falha fica registrada para GerarGrafico exibir UMA vez.
1102:             THIS.this_cFalhaGrafico = loc_oErro.Message
1103:             loc_nComparativo = 0
1104:         ENDTRY
1105: 
1106:         RETURN loc_nComparativo
1107:     ENDPROC
1108: 
1109:     *==========================================================================
1110:     * OcultarAguardeDoPai - Ultima linha do Init legado:
1111:     *
1112:     *     Thisform.parentform.Aguarde.visible = .f.
1113:     *
1114:     * O pai acende um painel "Aguarde..." antes de processar crFinal e abrir
1115:     * este grafico; quem o apaga eh ESTA tela, quando o desenho terminou.
1116:     * Mesmas tres guardas de ObterComparativoDoPai - sem pai (probe/harness)
1117:     * ou sem o painel, nao ha nada a apagar e o metodo eh inocuo.
1118:     *==========================================================================
1119:     PROCEDURE OcultarAguardeDoPai()
1120:         LOCAL loc_oErro
1121: 
1122:         TRY
1123:             IF VARTYPE(THIS.this_oFormPai) = "O"
1124:                 IF PEMSTATUS(THIS.this_oFormPai, "Aguarde", 5)
1125:                     IF VARTYPE(THIS.this_oFormPai.Aguarde) = "O"
1126:                         THIS.this_oFormPai.Aguarde.Visible = .F.
1127:                     ENDIF
1128:                 ENDIF
1129:             ENDIF
1130:         CATCH TO loc_oErro
1131:             THIS.this_cFalhaGrafico = loc_oErro.Message
1132:         ENDTRY
1133:     ENDPROC
1134: 
1135:     *==========================================================================
1136:     * GerarGrafico - Transcricao do corpo do Init legado (a parte de DADOS; a
1137:     * de layout ja esta nas Fases 3-5). Sequencia do legado, na ordem:
1138:     *
1139:     *   Select Distinct ... Into Array laMeses / laGrupos    -> BO
1140:     *   Declare m.laPerc(...) / m.laPerc = 0                 -> BO
1141:     *   Create Cursor Graph (gGraficos Gen (4))              -> aqui
1142:     *   Select crFinal / Set order to Grupom / Scan ...      -> BO
1143:     *   Select crFinal / Set Order To Imp / Do While ...     -> BO
1144:     *   If Not Empty(lcStrg)
1145:     *       Select Graph / Append Blank
1146:     *       Append General gGraficos Class 'MsGraph.Chart' Data lcStrg
1147:     *       Thisform.MostraGrafico()
1148:     *   Endif
1149:     *   Select CrFinal / Go Top / Select Graph / Go Top
1150:     *   Thisform.parentform.Aguarde.visible = .f.
1151:     *
1152:     * A montagem da matriz TAB/CRLF (lcStrg) inteira mora no BO, em
1153:     * CarregarDoCursor (Fase 2) - aqui fica so o que eh OLE e cursor de campo
1154:     * General, que eh do Form por decisao de arquitetura (PILAR 3: o BO nao
1155:     * manipula objeto OLE). Mesma divisao de FormSigPrGf2.
1156:     *
1157:     * PUBLIC: o legado expoe mostragrafico como metodo customizado do form
1158:     * (RESERVED3/ClassInfo do dump), e o pai pode mandar redesenhar depois de
1159:     * reprocessar o periodo. Metodo chamado de fora NUNCA pode ser PROTECTED
1160:     * em nivel nenhum da heranca (regra #51).
1161:     *
1162:     * O CREATE CURSOR acontece SEMPRE, inclusive sem dado - como no legado,
1163:     * em que o "Create Cursor Graph" vem ANTES do "If Not Empty(lcStrg)" e o
1164:     * "Select Graph / Go Top" do fim conta com o alias existindo.
1165:     *==========================================================================
1166:     PROCEDURE GerarGrafico()
1167:         LOCAL loc_oBO, loc_cAliasGrafico, loc_cOrigem, loc_cDados, ;
1168:               loc_lResultado, loc_lFalhaOle, loc_oErro, loc_oErroOle
1169: 
1170:         loc_lResultado = .F.
1171:         loc_lFalhaOle  = .F.
1172: 
1173:         THIS.this_cFalhaGrafico  = ""
1174:         THIS.this_lGraficoPronto = .F.
1175: 
1176:         TRY
1177:             loc_oBO = THIS.this_oBusinessObject
1178: 
1179:             IF VARTYPE(loc_oBO) = "O"
1180:                 loc_cAliasGrafico = ALLTRIM(loc_oBO.this_cCursorGrafico)
1181:                 loc_cOrigem       = ALLTRIM(loc_oBO.this_cCursorOrigem)
1182: 
1183:                 *-- Modo de agrupamento, lido do PAI como no legado. Tem de
1184:                 *-- ser atribuido ANTES do CarregarDoCursor: eh ele que decide
1185:                 *-- se a chave de grupo leva o Ano e se a matriz de
1186:                 *-- percentuais eh preenchida.
1187:                 loc_oBO.this_nComparativo = THIS.ObterComparativoDoPai()
1188: 
1189:                 *-- Cursor do campo General, equivalente ao "Create Cursor
1190:                 *-- Graph (gGraficos Gen (4))" do legado. Recriado a cada
1191:                 *-- geracao: o grafico eh UM registro so (o legado tambem faz
1192:                 *-- um Append Blank por abertura da tela), entao nao ha cache
1193:                 *-- por chave como em FormSigPrGf2 - esta tela desenha um
1194:                 *-- conjunto unico de series.
1195:                 IF USED(loc_cAliasGrafico)
1196:                     *-- Guardar pelo BUFFERING, nunca so por USED(): sem
1197:                     *-- buffering o TABLEREVERT nao eh no-op, estoura o erro
1198:                     *-- 1586 (CLAUDE.md regra #52). CREATE CURSOR nasce com
1199:                     *-- Buffering = 1, entao aqui o TABLEREVERT eh pulado e o
1200:                     *-- USE IN fecha o alias de qualquer forma.
1201:                     IF CURSORGETPROP("Buffering", loc_cAliasGrafico) > 1
1202:                         TABLEREVERT(.T., loc_cAliasGrafico)
1203:                     ENDIF
1204:                     USE IN (loc_cAliasGrafico)
1205:                 ENDIF
1206:                 CREATE CURSOR (loc_cAliasGrafico) (gGraficos G(4))

*-- Linhas 1220 a 1393:
1220:                     ELSE
1221:                         *-- Periodo sem movimento: nao eh erro, eh resultado
1222:                         *-- vazio. O legado simplesmente nao desenha nada.
1223:                         MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para montar o gr" + ;
1224:                             CHR(225) + "fico comparativo.", "Gr" + CHR(225) + "fico Comparativo")
1225:                     ENDIF
1226:                 ELSE
1227:                     MsgAviso(IIF(EMPTY(loc_oBO.this_cMensagemErro), ;
1228:                         "N" + CHR(227) + "o foi poss" + CHR(237) + "vel preparar os dados do gr" + ;
1229:                             CHR(225) + "fico.", ;
1230:                         loc_oBO.this_cMensagemErro), "Gr" + CHR(225) + "fico Comparativo")
1231:                 ENDIF
1232: 
1233:                 *-- "Select CrFinal / Go Top / Select Graph / Go Top" do fim
1234:                 *-- do Init legado: devolve os dois cursores ao topo. O do
1235:                 *-- grafico por ULTIMO e de proposito - o OleBoundControl le o
1236:                 *-- campo General do registro CORRENTE.
1237:                 IF USED(loc_cOrigem)
1238:                     SELECT (loc_cOrigem)
1239:                     GO TOP
1240:                 ENDIF
1241:                 *-- Mesmo motivo do guard de MostrarGrafico: so reposiciona
1242:                 *-- quando ha grafico de verdade, nunca sobre a linha que o
1243:                 *-- CATCH do APPEND GENERAL deixou marcada como excluida.
1244:                 IF USED(loc_cAliasGrafico) AND loc_oBO.this_lGraficoGerado
1245:                     SELECT (loc_cAliasGrafico)
1246:                     GO TOP
1247:                 ENDIF
1248:             ENDIF
1249:         CATCH TO loc_oErro
1250:             MsgErro(loc_oErro.Message + CHR(13) + ;
1251:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1252:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.GerarGrafico")
1253:         ENDTRY
1254: 
1255:         *-- Falha de OLE tem de ficar VISIVEL (regra #27): ausencia silenciosa
1256:         *-- faria o usuario olhar uma tela em branco sem saber por que.
1257:         IF loc_lFalhaOle
1258:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o gr" + CHR(225) + ;
1259:                 "fico (componente MsGraph.Chart indispon" + CHR(237) + "vel nesta esta" + ;
1260:                 CHR(231) + CHR(227) + "o)." + CHR(13) + CHR(13) + THIS.this_cFalhaGrafico, ;
1261:                 "Gr" + CHR(225) + "fico Comparativo")
1262:         ENDIF
1263: 
1264:         *-- O painel "Aguarde" do pai eh apagado em TODO caminho, como no
1265:         *-- legado (a linha eh a ultima do Init, fora de qualquer IF): se
1266:         *-- ficasse so no caminho de sucesso, falha de dado deixaria o pai
1267:         *-- com o aviso aceso para sempre.
1268:         THIS.OcultarAguardeDoPai()
1269: 
1270:         THIS.this_lGraficoPronto = loc_lResultado
1271: 
1272:         RETURN loc_lResultado
1273:     ENDPROC
1274: 
1275:     *==========================================================================
1276:     * AnexarGraficoAoCursor - "Select Graph / Append Blank / Append General
1277:     * gGraficos Class 'MsGraph.Chart' Data lcStrg" do Init legado.
1278:     *
1279:     * Isolado num metodo (e num TRY) proprio porque o OLE server
1280:     * "MsGraph.Chart" pode nao estar registrado na estacao - medido nesta
1281:     * maquina: OLE error 0x800401f3 "Cadeia de caracteres de classe
1282:     * invalida", porque o MSGraph vem com o Microsoft Office. Nesse caso o
1283:     * APPEND BLANK JA inseriu a linha quando o APPEND GENERAL estoura, e sem
1284:     * desfazer o OleBoundControl exibe esse registro VAZIO como se fosse
1285:     * resultado valido - a tela mentiria que desenhou. Por isso o CATCH apaga
1286:     * a linha e devolve .F., e quem chama avisa o usuario.
1287:     *
1288:     * O nome do campo vai LITERAL ("gGraficos"): APPEND GENERAL nao aceita
1289:     * expressao de campo, ao contrario do alias do cursor. O IF confere que o
1290:     * BO continua chamando o campo assim - divergirem faria o APPEND GENERAL
1291:     * escrever num campo que o ControlSource de MostrarGrafico nao le.
1292:     *==========================================================================
1293:     PROTECTED PROCEDURE AnexarGraficoAoCursor(par_cAliasGrafico, par_cDados)
1294:         LOCAL loc_oBO, loc_lResultado, loc_oErro
1295:         loc_lResultado = .F.
1296: 
1297:         loc_oBO = THIS.this_oBusinessObject
1298: 
1299:         IF UPPER(ALLTRIM(loc_oBO.this_cCampoGeral)) != "GGRAFICOS"
1300:             THIS.this_cFalhaGrafico = "Campo General do BO (" + ;
1301:                 ALLTRIM(loc_oBO.this_cCampoGeral) + ") divergente de gGraficos."
1302:         ELSE
1303:             TRY
1304:                 SELECT (par_cAliasGrafico)
1305:                 APPEND BLANK
1306:                 APPEND GENERAL gGraficos CLASS "MsGraph.Chart" DATA (par_cDados)
1307: 
1308:                 loc_oBO.this_lGraficoGerado = .T.
1309:                 loc_lResultado = .T.
1310:             CATCH TO loc_oErro
1311:                 THIS.this_cFalhaGrafico     = loc_oErro.Message
1312:                 loc_oBO.this_lGraficoGerado = .F.
1313: 
1314:                 *-- Apaga a linha em branco deixada pelo APPEND BLANK.
1315:                 SELECT (par_cAliasGrafico)
1316:                 IF !EOF() AND !BOF()
1317:                     DELETE
1318:                 ENDIF
1319:             ENDTRY
1320:         ENDIF
1321: 
1322:         RETURN loc_lResultado
1323:     ENDPROC
1324: 
1325:     *==========================================================================
1326:     * MostrarGrafico - Transcricao do "PROCEDURE mostragrafico" do SCX.
1327:     * Liga o campo General ao OleBoundControl e aplica a formatacao do
1328:     * MSGraph (galeria, fontes, legenda, titulo, areas, eixos, rotulos).
1329:     *
1330:     * LockScreen = .T./.F. em volta, como no legado (o metodo dele abre e
1331:     * fecha com "Thisform.LockScreen"): a formatacao toca dezenas de
1332:     * propriedades do chart e sem isso a tela pisca a cada uma.
1333:     *
1334:     * POR QUE A FORMATACAO ESTA DIVIDIDA EM BLOCOS COM TRY PROPRIO
1335:     * --------------------------------------------------------------------
1336:     * O legado nao usa TRY/CATCH: ele troca o ON ERROR por um que so acende
1337:     * uma flag ("On Error m.llOnErro1 = .t.") e restaura o anterior no fim.
1338:     * A diferenca eh de CONTROLE DE FLUXO, nao de estilo: com ON ERROR a
1339:     * execucao CONTINUA na linha seguinte, entao uma propriedade que o
1340:     * servidor OLE recuse nao impede as outras 40 de serem aplicadas; com um
1341:     * TRY unico em volta de tudo, a primeira recusa abandonaria todo o resto
1342:     * da formatacao e o grafico sairia meio formatado.
1343:     *
1344:     * Por isso cada bloco tem o seu TRY e devolve .T./.F.: um bloco que falhe
1345:     * nao derruba os demais, reproduzindo a tolerancia do ON ERROR legado. E
1346:     * nenhum CATCH eh silencioso (regra #9) - todos registram a mensagem em
1347:     * this_cFalhaGrafico, exibida UMA vez no fim; quatro MsgErro seguidos
1348:     * seriam pior que o problema.
1349:     *
1350:     * LockScreen = .F. fica FORA dos TRY, para a tela nunca ficar congelada
1351:     * por causa de uma falha de formatacao.
1352:     *==========================================================================
1353:     PROCEDURE MostrarGrafico()
1354:         LOCAL loc_oBO, loc_oOle, loc_cAliasGrafico, loc_lResultado, loc_oErro
1355:         loc_lResultado = .F.
1356: 
1357:         TRY
1358:             loc_oBO = THIS.this_oBusinessObject
1359: 
1360:             IF VARTYPE(loc_oBO) = "O"
1361:                 loc_cAliasGrafico = ALLTRIM(loc_oBO.this_cCursorGrafico)
1362:                 loc_oOle          = THIS.obj_4c_OleGrafico
1363: 
1364:                 *-- Guard pelo FLAG do BO, nao por RECCOUNT: RECCOUNT()
1365:                 *-- CONTA registro marcado como excluido (SET DELETED esta
1366:                 *-- OFF por default), e eh exatamente isso que sobra no
1367:                 *-- cursor quando o APPEND GENERAL falha e
1368:                 *-- AnexarGraficoAoCursor apaga a linha em branco. Com
1369:                 *-- RECCOUNT > 0 este metodo passaria a desenhar sobre um
1370:                 *-- registro excluido se o form PAI o chamasse direto (ele
1371:                 *-- eh PUBLIC) - a tela exibiria grafico vazio como se
1372:                 *-- fosse resultado valido.
1373:                 IF USED(loc_cAliasGrafico) AND loc_oBO.this_lGraficoGerado
1374:                     SELECT (loc_cAliasGrafico)
1375:                     GO TOP
1376: 
1377:                     THIS.LockScreen = .T.
1378: 
1379:                     *-- ".ControlSource = 'gGraficos'" do legado, aqui
1380:                     *-- QUALIFICADO com o alias: o legado conta com a work
1381:                     *-- area corrente ser a do cursor do grafico, o que deixa
1382:                     *-- o bind dependente de quem chamou (regra #41).
1383:                     loc_oOle.ControlSource = loc_cAliasGrafico + "." + ;
1384:                         ALLTRIM(loc_oBO.this_cCampoGeral)
1385: 
1386:                     loc_lResultado = THIS.AplicarFormatoGrafico(loc_oOle)
1387: 
1388:                     *-- "If m.lnConta1==1" do legado - o ramo COLUNA. O indice
1389:                     *-- vem do BO (this_nIndiceTipoGrafico), que o calcula
1390:                     *-- pelo mesmo At()/6 do legado sobre o tipo corrente.
1391:                     IF loc_oBO.this_nIndiceTipoGrafico = 1
1392:                         THIS.AplicarEixosColuna(loc_oOle)
1393:                     ENDIF

*-- Linhas 1412 a 1502:
1412:         CATCH TO loc_oErro
1413:             MsgErro(loc_oErro.Message + CHR(13) + ;
1414:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1415:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.MostrarGrafico")
1416:             loc_lResultado = .F.
1417:         ENDTRY
1418: 
1419:         *-- FORA do TRY: falha de formatacao nao pode deixar a tela congelada.
1420:         THIS.LockScreen = .F.
1421: 
1422:         *-- Falha de bloco de formatacao fica VISIVEL, uma vez so.
1423:         IF loc_lResultado AND !EMPTY(THIS.this_cFalhaGrafico)
1424:             MsgAviso("O gr" + CHR(225) + "fico foi desenhado, mas parte da formata" + ;
1425:                 CHR(231) + CHR(227) + "o n" + CHR(227) + "o p" + CHR(244) + "de ser aplicada:" + ;
1426:                 CHR(13) + CHR(13) + THIS.this_cFalhaGrafico, "Gr" + CHR(225) + "fico Comparativo")
1427:             THIS.this_cFalhaGrafico = ""
1428:         ENDIF
1429: 
1430:         RETURN loc_lResultado
1431:     ENDPROC
1432: 
1433:     *==========================================================================
1434:     * AplicarFormatoGrafico - Primeiro bloco do mostragrafico legado: galeria
1435:     * (autoformat), fontes, legenda, titulo e as areas do chart.
1436:     *
1437:     *   .autoformat(laTpgra1[lnConta1,1], laTpgra1[lnConta1,2])
1438:     *   .chartarea.font.name / .size / .bold
1439:     *   .HasLegend / .Legend.Position = 1 / .Legend.Shadow
1440:     *   .hastitle / .charttitle.font.* / .charttitle.text
1441:     *   .displayblanksas = 3
1442:     *   .chartarea.interior.color / .border.color / .shadow
1443:     *   .plotarea.interior.color
1444:     *
1445:     * O par galeria/formato vem do BO (this_nGaleriaAtual/this_nFormatoAtual),
1446:     * que guarda a MESMA tabela laTpgra1 do legado (COLUNA -4100/4 e
1447:     * PIZZA -4102/7) e o indice corrente.
1448:     *
1449:     * DUAS ATRIBUICOES MORTAS do legado NAO sao transcritas, por serem
1450:     * sobrescritas pelo PROPRIO legado poucas linhas depois, sem nada ler o
1451:     * valor intermediario:
1452:     *   .ChartArea.interior.color = Rgb(192,192,192) -> depois Rgb(255,255,255)
1453:     *   .PlotArea.interior.color  = Rgb(222,222,222) -> depois Rgb(255,255,255)
1454:     * Os valores EFETIVOS (branco nas duas areas) sao os aplicados aqui.
1455:     * Idem ".chartarea.font.name = 'Arial'", que o legado repete identico.
1456:     *
1457:     * O titulo eh a concatenacao das QUATRO linhas do legado (lcTitulo +
1458:     * lcStitulo + lcStitulo2 + lcStitulo3), separadas por CHR(13): titulo
1459:     * fixo, pRelTitulo e pPeriodo (do cursor Cabecalho, lidos pelo BO) e
1460:     * "Todas as Empresas".
1461:     *==========================================================================
1462:     PROTECTED PROCEDURE AplicarFormatoGrafico(par_oOle)
1463:         LOCAL loc_oBO, loc_cTitulo, loc_lResultado, loc_oErro
1464:         loc_lResultado = .F.
1465: 
1466:         TRY
1467:             loc_oBO = THIS.this_oBusinessObject
1468: 
1469:             loc_cTitulo = ALLTRIM(loc_oBO.this_cTitulo)     + CHR(13) + ;
1470:                           ALLTRIM(loc_oBO.this_cSubTitulo1) + CHR(13) + ;
1471:                           ALLTRIM(loc_oBO.this_cSubTitulo2) + CHR(13) + ;
1472:                           ALLTRIM(loc_oBO.this_cSubTitulo3)
1473: 
1474:             WITH par_oOle
1475:                 .AutoFormat(loc_oBO.this_nGaleriaAtual, loc_oBO.this_nFormatoAtual)
1476: 
1477:                 .ChartArea.Font.Name = "Arial"
1478:                 .ChartArea.Font.Size = 8
1479:                 .ChartArea.Font.Bold = .T.
1480: 
1481:                 .HasLegend       = .T.
1482:                 .Legend.Position = 1
1483:                 .Legend.Shadow   = .T.
1484: 
1485:                 .HasTitle               = .T.
1486:                 .ChartTitle.Font.Size   = 9
1487:                 .ChartTitle.Font.Bold   = .T.
1488:                 .ChartTitle.Font.Italic = .F.
1489:                 .ChartTitle.Text        = loc_cTitulo
1490: 
1491:                 .DisplayBlanksAs = 3
1492: 
1493:                 *-- Valores EFETIVOS do legado (ver cabecalho: os cinzas
1494:                 *-- 192/222 sao sobrescritos por ele mesmo logo abaixo).
1495:                 .ChartArea.Interior.Color = RGB(255, 255, 255)
1496:                 .ChartArea.Border.Color   = RGB(0, 0, 0)
1497:                 .ChartArea.Shadow         = .T.
1498:                 .PlotArea.Interior.Color  = RGB(255, 255, 255)
1499:             ENDWITH
1500: 
1501:             loc_lResultado = .T.
1502:         CATCH TO loc_oErro

*-- Linhas 1540 a 1583:
1540:     * MORTA - duas linhas depois, dentro do "With .ChartGroups(1)", o proprio
1541:     * legado poe .HasSeriesLines = .f.. O valor efetivo (.F.) eh o aplicado.
1542:     *==========================================================================
1543:     PROTECTED PROCEDURE AplicarEixosColuna(par_oOle)
1544:         LOCAL loc_oBO, loc_cTituloX, loc_cTituloY, loc_lResultado, loc_oErro
1545:         loc_lResultado = .F.
1546: 
1547:         TRY
1548:             loc_oBO      = THIS.this_oBusinessObject
1549:             loc_cTituloX = ALLTRIM(loc_oBO.this_cTituloEixoX)
1550:             loc_cTituloY = ALLTRIM(loc_oBO.this_cTituloEixoY)
1551: 
1552:             WITH par_oOle
1553:                 .PlotArea.Width = 610
1554:                 .PlotArea.Left  = 1
1555: 
1556:                 *-- Eixo 2 = eixo dos VALORES
1557:                 .Axes(2).MaximumScaleIsAuto = .T.
1558:                 .Axes(2).HasTitle           = .T.
1559:                 .Axes(2).AxisTitle.Caption  = loc_cTituloY
1560: 
1561:                 IF !EMPTY(loc_cTituloY)
1562:                     .Axes(2).AxisTitle.Orientation  = 90
1563:                     .Axes(2).TickLabels.Orientation = 0
1564:                 ENDIF
1565: 
1566:                 *-- Eixo 1 = eixo das CATEGORIAS (os meses)
1567:                 .Axes(1).HasTitle          = .T.
1568:                 .Axes(1).AxisTitle.Caption = loc_cTituloX
1569: 
1570:                 IF !EMPTY(loc_cTituloX)
1571:                     *-- "Iif((m.lnTmX>5),90,0)" do legado: rotulo longo vira
1572:                     *-- vertical. lnTmX nunca eh atribuido antes deste ponto
1573:                     *-- no legado, entao o Iif de guarda dele resolve 0 - e o
1574:                     *-- BO guarda esse mesmo 0 em this_nTamanhoRotuloX.
1575:                     .Axes(1).TickLabels.Orientation = IIF(loc_oBO.this_nTamanhoRotuloX > 5, 90, 0)
1576:                     .Axes(1).TickLabels.Font.Size   = 6
1577:                 ENDIF
1578: 
1579:                 WITH .ChartGroups(1)
1580:                     *-- Valor EFETIVO: o legado liga .hasserieslines fora do
1581:                     *-- WITH e desliga aqui dentro (ver cabecalho).
1582:                     .HasSeriesLines = .F.
1583:                     .GapWidth       = 10

*-- Linhas 1651 a 1694:
1651:     * grupo so", esta tela desenha a coluna com a geometria de coluna, e o
1652:     * legado desenhava com a de pizza.
1653:     *==========================================================================
1654:     PROTECTED PROCEDURE AplicarRotulosPercentuais(par_oOle)
1655:         LOCAL loc_oBO, loc_oSerie, loc_oRotulo, loc_nGrupo, loc_nMes, ;
1656:               loc_nPercentual, loc_lResultado, loc_oErro
1657:         loc_lResultado = .F.
1658: 
1659:         TRY
1660:             loc_oBO = THIS.this_oBusinessObject
1661: 
1662:             FOR loc_nGrupo = 1 TO loc_oBO.this_nTotalGrupos
1663:                 IF TYPE("THIS.obj_4c_OleGrafico.ChartGroups(1).SeriesCollection(m.loc_nGrupo)") == "O"
1664:                     loc_oSerie = par_oOle.ChartGroups(1).SeriesCollection(loc_nGrupo)
1665: 
1666:                     *-- Transcrito do legado nas DUAS linhas, na ordem dele.
1667:                     loc_oSerie.ApplyDataLabels      = .T.
1668:                     loc_oSerie.ApplyDataLabels.Type = 2
1669: 
1670:                     FOR loc_nMes = 1 TO loc_oBO.this_nTotalMeses
1671:                         IF TYPE("THIS.obj_4c_OleGrafico.ChartGroups(1).SeriesCollection(m.loc_nGrupo).Points(m.loc_nMes).DataLabel") == "O"
1672:                             loc_oRotulo = loc_oSerie.PointsDataLabel
1673: 
1674:                             *-- laPerc(grupo, mes) do legado
1675:                             loc_nPercentual = loc_oBO.ObterPercentual(loc_nGrupo, loc_nMes)
1676: 
1677:                             WITH loc_oRotulo
1678:                                 .Top = (.Top - 10)
1679:                                 *-- InList(,2,4) do legado: REGRA DE NEGOCIO,
1680:                                 *-- so a 2a e a 4a serie levam o numero.
1681:                                 .Caption = IIF(INLIST(loc_nGrupo, 2, 4), ;
1682:                                     ALLTRIM(STR(loc_nPercentual, 20, 0)), "")
1683:                                 .Font.Name   = "Arial "
1684:                                 .Font.Size   = 8
1685:                                 .Font.Bold   = .T.
1686:                                 .Font.Shadow = .F.
1687:                             ENDWITH
1688:                         ENDIF
1689:                     ENDFOR
1690:                 ENDIF
1691:             ENDFOR
1692: 
1693:             loc_lResultado = .T.
1694:         CATCH TO loc_oErro

*-- Linhas 1719 a 1744:
1719:     * uma atribuicao, e sem este bloco a pizza sairia com a geometria de
1720:     * coluna. Omitir seria entregar metade da tabela de tipos.
1721:     *==========================================================================
1722:     PROTECTED PROCEDURE AplicarAreaPizza(par_oOle)
1723:         LOCAL loc_lResultado, loc_oErro
1724:         loc_lResultado = .F.
1725: 
1726:         TRY
1727:             WITH par_oOle
1728:                 .PlotArea.Width = 240
1729:                 .PlotArea.Top   = 63
1730:                 .PlotArea.Left  = 110
1731:             ENDWITH
1732: 
1733:             loc_lResultado = .T.
1734:         CATCH TO loc_oErro
1735:             IF EMPTY(THIS.this_cFalhaGrafico)
1736:                 THIS.this_cFalhaGrafico = "AplicarAreaPizza: " + loc_oErro.Message
1737:             ENDIF
1738:             loc_lResultado = .F.
1739:         ENDTRY
1740: 
1741:         RETURN loc_lResultado
1742:     ENDPROC
1743: 
1744: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpGcoBO.prg):
*============================================================================
* SigOpGcoBO.prg - Business Object para "Grafico Comparativo" (SIGOPGCO)
*
* Form OPERACIONAL (SIGOPGCO / FormSigOpGco): tela de EXIBICAO de grafico
* (MSGraph.Chart via OleBoundControl), aberta pelo form PAI, que ja processou
* e deixou prontos dois cursores:
*
*   crFinal   - resultado agregado com as colunas Mes, Ordem, Ano, Grupos,
*               Total e npercs, com os tags de ordenacao Grupom e Imp
*               (o Init legado faz "Set order to Grupom" e "Set Order To Imp")
*   Cabecalho - uma linha com pRelTitulo e pPeriodo, usados como subtitulos
*               do grafico (lcStitulo / lcStitulo2 do mostragrafico legado)
*
* O SIGOPGCO NAO consulta o banco: ele apenas agrega/formata o que veio nos
* cursores do pai, monta a matriz TAB/CRLF das series (uma coluna por mes,
* uma linha por grupo) e guarda o binario do grafico num cursor local com
* campo General (Create Cursor Graph (gGraficos Gen(4)) no legado).
*
* O modo de montagem depende do controle Comparativo do form pai
* (Thisform.Parentform.Comparativo.Value): valendo 1, o grupo passa a ser
* Grupos + Ano e os rotulos de percentual (laPerc) sao aplicados as series;
* valendo outro numero, o grupo eh so Grupos e nao ha rotulo de percentual.
*
* Nao existe tabela proprietaria (this_cTabela fica vazio): este BO nao faz
* INSERT/UPDATE/DELETE contra o SQL Server, so agrega os cursores de origem.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpGcoBO AS BusinessBase

    *==========================================================================
    * CURSORES DE ORIGEM (fornecidos pelo form PAI - este BO so os consulta)
    *==========================================================================

    *-- crFinal do legado: agregado com Mes, Ordem, Ano, Grupos, Total, npercs
    this_cCursorOrigem = ""

    *-- Cabecalho do legado: uma linha com pRelTitulo e pPeriodo
    this_cCursorCabecalho = ""

    *-- Tags de ordenacao que o Init legado usa sobre o cursor de origem:
    *-- Grupom para varrer os meses e Imp para varrer os grupos na montagem
    this_cOrdemMeses  = ""
    this_cOrdemGrupos = ""

    *==========================================================================
    * CURSORES DE TRABALHO (criados por este BO)
    *==========================================================================

    *-- Cursor Graph do legado (gGraficos Gen(4)): guarda o binario do
    *-- MSGraph.Chart gerado pelo Append General. Eh tambem o alias que o
    *-- OleBoundControl consome via ControlSource e que o Imprimir seleciona
    *-- antes do Report Form.
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

    *-- Report Form SigOpGrc To Printer Prompt NoConsole (Click do Imprimir)
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
    * TIPO DE GRAFICO - a tabela laTpgra1(2,3) do legado tem duas linhas
    * fixas: COLUNA (-4100, 4) e PIZZA (-4102, 7). O indice vem de
    * lnConta1 = ((At(AllTrim(lcTpReg),'COLUNAPIZZA ')+5)/6), ou seja
    * 1 para COLUNA e 2 para PIZZA.
    *==========================================================================

    *-- lcTpReg do legado, fixo em 'COLUNA' no Init e no mostragrafico
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

    *-- lnNmeses  = Alen(laMeses, 1)  - colunas do grafico
    this_nTotalMeses = 0

    *-- lnNgrupos = Alen(laGrupos, 1) - series do grafico
    this_nTotalGrupos = 0

    *-- lnTmX do legado: tamanho do maior rotulo do eixo X. Passando de 5, o
    *-- mostragrafico gira os rotulos em 90 graus
    *-- (.axes(1).ticklabels.orientation = Iif((lnTmX>5),90,0)).
    this_nTamanhoRotuloX = 0

    *-- Thisform.Parentform.Comparativo.Value: valendo 1, agrupa por
    *-- Grupos + Ano e aplica os rotulos de percentual nas series
    this_nComparativo = 0

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

    *-- .T. quando a montagem produziu matriz nao vazia (If Not Empty(lcStrg)
    *-- do Init legado, que eh o guard do Append General)
    this_lDadosValidos = .F.

    *-- .T. quando o binario do MSGraph.Chart foi gravado no cursor de grafico
    this_lGraficoGerado = .F.

    *==========================================================================
    * Init - Nao ha tabela proprietaria (a tela so exibe/agrega o que o form
    * pai processou), entao this_cTabela e this_cCampoChave ficam vazios.
    * Inicializa os nomes canonicos dos cursores de trabalho, os titulos fixos
    * e a tabela de tipos de grafico do legado.
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

            *-- Cursores de origem (crFinal e Cabecalho do legado). O form pai
            *-- pode sobrescrever estes nomes antes de mandar montar o grafico.
            THIS.this_cCursorOrigem    = "crFinal"
            THIS.this_cCursorCabecalho = "Cabecalho"
            THIS.this_cOrdemMeses      = "Grupom"
            THIS.this_cOrdemGrupos     = "Imp"

            *-- Cursores de trabalho criados por este BO
            THIS.this_cCursorGrafico     = "cursor_4c_Grafico"
            THIS.this_cCampoGeral        = "gGraficos"
            THIS.this_cCursorMeses       = "cursor_4c_Meses"
            THIS.this_cCursorGrupos      = "cursor_4c_Grupos"
            THIS.this_cCursorPercentuais = "cursor_4c_Percentuais"

            *-- Classe OLE do Append General e FRX do botao Imprimir
            THIS.this_cClasseOLE = "MsGraph.Chart"
            THIS.this_cRelatorio = "SigOpGrc"

            *-- Titulos fixos do mostragrafico legado. Os subtitulos 1 e 2 vem
            *-- do cursor Cabecalho e sao preenchidos na montagem.
            THIS.this_cTitulo      = "Gr" + CHR(225) + "fico Comparativo"
            THIS.this_cSubTitulo1  = ""
            THIS.this_cSubTitulo2  = ""
            THIS.this_cSubTitulo3  = "Todas as Empresas"
            THIS.this_cTituloEixoX = ""
            THIS.this_cTituloEixoY = "Desempenho"

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
            *-- dos cursores do pai
            THIS.this_nTotalMeses     = 0
            THIS.this_nTotalGrupos    = 0
            THIS.this_nTamanhoRotuloX = 0
            THIS.this_nComparativo    = 0

            *-- Series ainda sem conteudo
            THIS.this_cDadosGrafico = ""
            THIS.this_cLinhaMeses   = ""

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
    * O dump do legado (SigOpGco_form_codigo_fonte.txt) nao tem nenhum
    * TABLEUPDATE(, nenhum .AddCursor( e nenhum "Insert Into"/"Update "/
    * "Delete From" contra tabela remota - o unico alvo de escrita e o
    * cursor LOCAL "Graph" (Create Cursor Graph (gGraficos Gen(4)) seguido
    * de Append Blank + Append General), que aqui vira
    * this_cCursorGrafico/cursor_4c_Grafico. Este BO so LE crFinal e
    * Cabecalho (preenchidos pelo form PAI) e agrega.
    *
    * Por isso o trabalho real desta fase fica concentrado em
    * CarregarDoCursor() (agregacao de crFinal + Cabecalho nos cursores de
    * trabalho e na matriz this_cDadosGrafico), e Inserir()/Atualizar()
    * NAO sao sobrescritos aqui: o comportamento herdado de BusinessBase
    * (recusar a operacao com mensagem de erro) ja eh o correto para uma
    * tela que nunca grava registro em tabela do SQL Server.
    * ObterChavePrimaria() tambem fica herdado (devolve "") porque nao ha
    * chave primaria - a tela nao representa uma linha de tabela, entao
    * RegistrarAuditoria() nunca chega a ser chamado.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Agrega os cursores do form pai (crFinal + Cabecalho)
    * e monta a matriz TAB/CRLF que o Append General do grafico espera
    * (lcStrg do legado), alem dos cursores de trabalho de meses/grupos e
    * da matriz de percentuais.
    *
    * Nao ha "registro" para carregar (este BO nao representa uma linha de
    * tabela): par_cCursorOrigem/par_cCursorCabecalho substituem os nomes
    * padrao this_cCursorOrigem/this_cCursorCabecalho quando o form pai
    * usar outro alias. THIS.this_nComparativo deve ser atribuido pelo
    * Form ANTES de chamar este metodo - eh o equivalente a
    * Thisform.Parentform.Comparativo.Value do legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cCursorOrigem, par_cCursorCabecalho)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cOrigem, loc_cCabecalho
        LOCAL loc_nMes, loc_cMesNome, loc_cLinhaMeses, loc_cStrg
        LOCAL loc_cGrupoAtual, loc_nMesPos, loc_nGrupoPos
        loc_lResultado = .F.

        TRY
            loc_cOrigem    = IIF(EMPTY(par_cCursorOrigem), THIS.this_cCursorOrigem, par_cCursorOrigem)
            loc_cCabecalho = IIF(EMPTY(par_cCursorCabecalho), THIS.this_cCursorCabecalho, par_cCursorCabecalho)

            THIS.this_lDadosValidos  = .F.
            THIS.this_lGraficoGerado = .F.

            IF !USED(loc_cOrigem) OR !USED(loc_cCabecalho)
                THIS.this_cMensagemErro = "Cursores de origem n" + CHR(227) + "o encontrados."
                loc_lResultado = .F.
            ELSE
                THIS.this_cCursorOrigem    = loc_cOrigem
                THIS.this_cCursorCabecalho = loc_cCabecalho

                *-- Subtitulos (lcStitulo/lcStitulo2 do legado - Cabecalho.
                *-- pRelTitulo / Cabecalho.pPeriodo, uma linha so)
                SELECT (loc_cCabecalho)
                GO TOP
                THIS.this_cSubTitulo1 = TratarNulo(EVALUATE(loc_cCabecalho + ".pRelTitulo"), "")
                THIS.this_cSubTitulo2 = TratarNulo(EVALUATE(loc_cCabecalho + ".pPeriodo"), "")

                *-- lnTmX do legado: nunca foi atribuido antes deste ponto,
                *-- entao Iif(Type('lnTmX')=='N',lnTmX,0) sempre resolve 0
                THIS.this_nTamanhoRotuloX = 0

                *-- Meses distintos (Select Distinct Mes From crFinal Into
                *-- Array laMeses do legado - aqui, cursor em vez de array)
                IF USED(THIS.this_cCursorMeses)
                    USE IN (THIS.this_cCursorMeses)
                ENDIF
                SELECT DISTINCT Mes FROM (loc_cOrigem) ORDER BY Mes INTO CURSOR (THIS.this_cCursorMeses)

                *-- Grupos distintos (Select Distinct Str(Ordem,1)+Str(Ano,4)
                *-- As cGrupos do legado)
                IF USED(THIS.this_cCursorGrupos)
                    USE IN (THIS.this_cCursorGrupos)
                ENDIF
                SELECT DISTINCT (STR(Ordem, 1) + STR(Ano, 4)) AS cGrupos ;
                    FROM (loc_cOrigem) ;
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
                *-- ordenado por this_cOrdemGrupos (tag Imp do legado)
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
                        *-- meio, entao a legenda do grafico sairia
                        *-- "LOJA A              2025" (os 14 brancos do
                        *-- char(20)) em vez de "LOJA A2025". Compila limpo
                        *-- e so aparece na legenda do chart.
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
    * LimparCursores - Fecha os cursores de trabalho que ESTE BO cria em
    * CarregarDoCursor (Meses, Grupos e Percentuais).
    *
    * ACRESCENTADO NA FASE 8, porque a limpeza nao existia em lugar nenhum: o
    * Destroy do FormSigOpGco afirmava, em comentario, que "o BO fecha os
    * cursores de trabalho que ele mesmo cria", e nao havia nem Destroy nem
    * metodo de limpeza aqui. Os tres aliases ficavam ABERTOS depois que a tela
    * fechava - e, como aquele form entra na data session do form PAI quando ha
    * pai, o vazamento nem morria com a tela: ficava pendurado na sessao de quem
    * abriu, ate o PAI ser fechado.
    *
    * NAO fecha o cursor do GRAFICO (this_cCursorGrafico): quem o cria eh o
    * Form (CREATE CURSOR ... (gGraficos G(4)) em GerarGrafico), porque ele eh
    * consumido por objeto OLE - e OLE nao entra no BO (PILAR 3). Quem cria,
    * fecha: o Destroy do Form cuida dele, logo antes de chamar este metodo.
    *
    * NAO fecha crFinal nem Cabecalho: sao do form PAI, que os processou antes
    * de abrir o grafico e pode precisar deles depois - derruba-los daqui
    * tiraria o chao de quem chamou.
    *
    * PUBLIC (sem PROTECTED): quem chama eh o Form, de FORA da classe. Metodo
    * chamado de fora NUNCA pode ser PROTECTED em nivel nenhum da heranca
    * (CLAUDE.md regra #51) - PROTECTED aqui estouraria
    * "Property LIMPARCURSORES is not found" ao fechar a tela.
    *
    * Guard por BUFFERING e nao so por USED(): sem buffering o TABLEREVERT nao
    * eh no-op, dispara o erro 1586 (CLAUDE.md regra #52). Cursor de
    * CREATE CURSOR e de SELECT ... INTO CURSOR nasce com Buffering = 1, entao
    * na pratica o TABLEREVERT eh pulado e o USE IN fecha o alias de qualquer
    * forma - o ramo existe para o caso de alguem ligar buffering depois.
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
                "Procedure: " + loc_oErro.Procedure, "Erro em SigOpGcoBO.LimparCursores")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

