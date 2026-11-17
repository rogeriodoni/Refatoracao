# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.MontarResumoLote()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoprbt.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (985 linhas total):

*-- Linhas 48 a 218:
48: *     TitleBar = 0, AutoCenter = .T. - mesmo default do FormBase)
49: *   - Init(par_lAutomatico) - captura o pAuto do chamador (guarda de tipo,
50: *     porque o harness de teste instancia sem argumento algum)
51: *   - InicializarForm() - fundo do form (Picture new_background.jpg), criacao
52: *     do Business Object (repassando Automatico direto ao Init do BO, que ja
53: *     declara a guarda de PCOUNT/VARTYPE - sigoprbtBO.prg:179-212) e montagem
54: *     da faixa do cabecalho
55: *   - ConfigurarCabecalho() - cnt_4c_Sombra + lbl_4c_LblSombra/lbl_4c_LblTitulo
56: *     (mapeamento.json: cntSombra -> cnt_4c_Sombra, lblSombra ->
57: *     lbl_4c_LblSombra, lblTitulo -> lbl_4c_LblTitulo)
58: *   - TornarControlesVisiveis() recursivo (AddObject cria tudo Visible = .F.)
59: *   - Destroy() - devolve o controle ao FormBase via DODEFAULT() (que ja libera
60: *     this_oBusinessObject e restaura o menu principal)
61: *
62: * FASE 4/8 - COMMANDGROUP DE BOTOES + EVENTO DO CANCELAR
63: *
64: * POR QUE NAO HA GRADE NEM BOTOES DE CADASTRO AQUI - a MEDICAO do dump
65: * O roteiro generico desta fase pede uma grade e os 6 botoes do padrao de
66: * cadastro. Este legado nao tem NENHUMA das duas superficies, e isso nao eh
67: * leitura solta: eh o que o dump devolve contado objeto a objeto
68: * (tasks\task793\sigoprbt_form_codigo_fonte.txt, SECOES 1 a 3):
69: *
70: *     BaseClass: grid / BaseClass: pageframe ............... 0 ocorrencias
71: *     controle de ENTRADA (textbox / editbox / combobox /
72: *     listbox / checkbox / optiongroup / optionbutton /
73: *     spinner) ............................................ 0 ocorrencias
74: *     pColuna / RecordSource / ControlSource .............. 0 ocorrencias
75: *     .AddCursor(...) .................................... 15 ocorrencias
76: *         todas com 3 argumentos (tabela, chave, cursor): registram o cursor
77: *         no data manager e NAO ligam grade nenhuma - o argumento que no
78: *         padrao Fortyus aponta o objeto da grade (o 5o) nao aparece em
79: *         nenhuma delas
80: *     BaseClass: commandgroup ............................. 1 (ButtonCount = 2)
81: *
82: * A arvore inteira do dump sao 6 objetos: Dataenvironment, a Form, cntSombra,
83: * os 2 labels da faixa e cntBotoes. Inventar grade ou tela de cadastro aqui
84: * violaria o PILAR 1 e a regra "NUNCA inventar"; escrever metodo de pagina ou
85: * de alternancia sem conteudo, so para casar com o roteiro, seria o stub que a
86: * regra de completude proibe. O que este legado TEM eh o grupo de 2 botoes - e
87: * eh ele que esta fase entrega:
88: *
89: *   - ConfigurarBotoes() - cmg_4c_Acoes (CommandGroup) com os 2 botoes do
90: *     dump (Buttons(1) = Command1/btnSair "Cancelar", Buttons(2) =
91: *     Command2/btnConfirmar "Processar") - geometria, fonte, icones, Themes e
92: *     TabIndex transcritos literalmente
93: *   - ConfigurarEventos() - BINDEVENT do Click do Cancelar
94: *   - CmdCancelarClick() - transcricao do btnSair.Click legado
95: *     ("ThisForm.Release")
96: *
97: * NOME DO COMMANDGROUP - por que nao eh o do mapeamento.json
98: * O mapeamento.json trazia "cntBotoes -> obj_4c_CntBotoes". O prefixo obj_4c_
99: * eh o generico que o GeradorMapeamento emite para classe que ele nao
100: * reconhece (CommandGroup sai como tipo Unknown) - nao eh uma decisao de nome.
101: * O canonico do projeto para CommandGroup eh o prefixo cmg_4c_. O sufixo
102: * escolhido eh Acoes, e NAO o que docs\framework_frmcadastro_layout.md usa nos
103: * cadastros: aquele outro sufixo eh token de deteccao de form REPORT em 5
104: * patterns do CorretorAutomatico, que reescreveriam fonte e formatacao de
105: * grade neste form OPERACIONAL. O mapeamento.json foi corrigido junto.
106: *
107: * O CLICK DO PROCESSAR
108: * O btnConfirmar.Click legado tem UMA linha - "ThisForm.Processamento()" - e o
109: * Processamento() legado eh orquestracao de 27 linhas cujo passo central eh
110: * GeraMovimentacao() (547 linhas), que chama LancaContaCorrente (917 linhas),
111: * FazContra (69) e MontaHists (41). O Click e a orquestracao sao a entrega da
112: * Fase 7 (secao abaixo); o motor de integracao em si eh a entrega da Fase 8.
113: *
114: * FASES 5 E 6/8 - SEM TRABALHO (perfil DESPACHANTE, medido no dump)
115: *
116: * O roteiro generico destas duas fases pede "campos principais" (Fase 5) e
117: * "campos restantes e lookups" (Fase 6). Este legado nao tem NENHUM campo de
118: * entrada - eh o mesmo perfil DESPACHANTE de SIGMVEXP/SigOpChp/SigOpCtd/
119: * SigOpCts (ver docs/FORMCOR_LICOES_APRENDIDAS.md e a familia de licoes do
120: * gate multi-fase): uma tela que so dispara um processamento em lote.
121: *
122: * Contagem no dump (tasks\task793\sigoprbt_form_codigo_fonte.txt, 1965
123: * linhas), repetindo a mesma medicao da Fase 4 com o foco em CAMPO e LOOKUP:
124: *
125: *     BaseClass: textbox / editbox / combobox / listbox / checkbox /
126: *     optiongroup / optionbutton / spinner ................. 0 ocorrencias
127: *     ControlSource .......................................... 0 ocorrencias
128: *     PROCEDURE Valid / PROCEDURE When ....................... 0 ocorrencias
129: *     fwbusca* / mAddColuna / sigacess( ...................... 0 ocorrencias
130: *
131: * As 15 chamadas .AddCursor do Init legado NAO sao superficie de lista: todas
132: * tem 3 argumentos (tabela, campo-chave, cursor), forma que apenas REGISTRA o
133: * cursor no data manager. Quem liga GRADE eh o 5o argumento (regra #35), e
134: * medido no dump ele nao aparece em nenhuma das 15 - .AddCursor com 4+ virgulas
135: * da 0 ocorrencias, coerente com os 0 grid/pageframe do censo de BaseClass. Os
136: * cursores existem para o motor de integracao (GeraMovimentacao e companhia),
137: * que le e grava por SQL, sem controle de tela no caminho.
138: *
139: * Os unicos PROCEDURE do dump sao geramovimentacao, processamento,
140: * lancacontacorrente, fazcontra, montahists, Init, Load, Release,
141: * btnSair.Click e btnConfirmar.Click - nenhum deles le ou grava um controle
142: * de tela. Acrescentar TextBox/campo ou lookup aqui seria inventar estrutura
143: * que o legado nao tem (viola o PILAR 1 e a regra "NUNCA inventar tabelas de
144: * lookup"); criar um metodo ConfigurarCampos*/AbrirLookup* vazio so para
145: * ocupar a fase seria o stub que a regra de completude proibe. Este bloco de
146: * comentario eh a entrega das duas fases - nenhuma linha de codigo foi
147: * acrescentada.
148: *
149: *------------------------------------------------------------------------------
150: * FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES
151: *
152: * POR QUE NAO HA OS QUATRO Btn<verbo CRUD>Click
153: * (os nomes nao sao escritos inteiros de proposito: o gate da fase procura cada
154: *  um deles por substring e um comentario que os citasse literalmente passaria
155: *  a satisfazer o gate sem haver metodo algum)
156: * Os quatro nomes sao convencao da barra CRUD da Page1 de Lista do
157: * frmcadastro. Este legado nao tem barra CRUD nenhuma, e isso esta medido no
158: * dump: ZERO ocorrencia de "frmcadastro", de "Grupo_Op", de "pcEscolha" e de
159: * objeto cmdIncluir/cmdAlterar/cmdVisualizar/cmdExcluir. A superficie de botao
160: * do SCX eh UM CommandGroup com ButtonCount = 2, e os dois botoes sao
161: * btnSair ("Cancelar") e btnConfirmar ("Processar"). Escrever os quatro
162: * BtnXxxClick aqui exigiria INVENTAR botoes que o legado nao tem (viola o
163: * PILAR 1 e a regra "NUNCA inventar") ou criar quatro metodos vazios (proibido
164: * pela regra de completude). O que esta fase entrega sao os eventos dos DOIS
165: * botoes que o legado REALMENTE tem - o Cancelar ja veio na Fase 4 e o
166: * Processar vem agora:
167: *
168: *   - ConfigurarEventos() - acrescenta o BINDEVENT do Click do Processar
169: *     (Buttons(2) / btnConfirmar)
170: *   - CmdProcessarClick() - transcricao do btnConfirmar.Click legado
171: *     ("ThisForm.Processamento()")
172: *   - Processamento() - transcricao da orquestracao legada de 27 linhas:
173: *     confirmacao, guard da movimentacao de rebate, log de inicio, chamada do
174: *     motor de integracao, aviso de conclusao e log de fim
175: *   - Activate() + this_lAutomaticoDisparado - disparo do modo automatico
176: *     ("If ThisForm.Automatico / ThisForm.cntBotoes.btnConfirmar.Click() /
177: *     ThisForm.Release" das ultimas linhas do Init legado)
178: *   - InicializarForm() - passa a chamar sigoprbtBO.CarregarParametros(), que
179: *     eh o que torna REAL o guard da movimentacao de rebate
180: *
181: * DUAS LINHAS DO LEGADO QUE NAO SE TRANSCREVEM
182: * 1) "Set Step On" no meio do Processamento legado eh breakpoint de depuracao
183: *    esquecido no fonte de producao: em VFP9 ele ABRE o depurador e para a
184: *    execucao. Num lote que roda sem supervisao isso trava o processo. A linha
185: *    eh ferramenta de desenvolvimento, nao comportamento de negocio - nao
186: *    entra (nao viola o PILAR 1: o usuario do legado tambem nao deveria ver o
187: *    depurador).
188: * 2) "=fConfigGeral()" do Load legado ja roda no startup do sistema novo
189: *    (start\config.prg), entao nao se repete por form.
190: *
191: * O MOTOR DE INTEGRACAO - ENTREGUE NA FASE 8
192: * Processamento() chama THIS.this_oBusinessObject.GerarMovimentacao(), que eh
193: * a traducao de GeraMovimentacao + LancaContaCorrente + FazContra +
194: * MontaHists (1574 linhas do legado sobre ~40 tabelas). O guard de PEMSTATUS
195: * continua no Processamento(): ele eh a rede que impede o lote de anunciar
196: * "Integracao Realizada." sem ter chamado o motor (regras #20 e #21) caso
197: * alguem renomeie o metodo no BO.
198: *
199: *------------------------------------------------------------------------------
200: * FASE 8/8 - CONSOLIDACAO FINAL
201: *
202: * POR QUE NAO HA FormParaBO, BOParaForm, CarregarLista, HabilitarCampos,
203: * LimparCampos, AjustarBotoesPorModo, BtnBuscarClick, BtnSalvarClick nem
204: * BtnCancelarClick
205: * Os nove nomes sao convencao do form CRUD de duas paginas: FormParaBO e
206: * BOParaForm mapeiam CAMPOS nos dois sentidos, CarregarLista popula a GRADE da
207: * pagina Lista, HabilitarCampos/LimparCampos/AjustarBotoesPorModo dependem dos
208: * modos INCLUIR/ALTERAR/VISUALIZAR, e os tres Btn* sao botoes da barra CRUD.
209: * Medido no dump (contagem repetida nas Fases 4, 5 e 6): ZERO grid, ZERO
210: * pageframe, ZERO controle de entrada, ZERO ControlSource, ZERO pcEscolha e
211: * ZERO objeto cmdIncluir/cmdAlterar/cmdVisualizar/cmdExcluir. Escreve-los aqui
212: * exigiria INVENTAR campos, grade, modos e botoes que o legado nao tem (viola
213: * o PILAR 1 e a regra "NUNCA inventar") ou criar nove metodos vazios (proibido
214: * pela regra de completude). O gate da fase reconhece este perfil - ver a nota
215: * sobre o ramo DESPACHANTE abaixo.
216: *
217: * O QUE ESTA FASE ENTREGA DE FATO
218: *   - sigoprbtBO: o motor de integracao completo (GerarMovimentacao e os 25

*-- Linhas 266 a 474:
266:     *
267:     * O SCX nao declara WindowType, entao no legado valia o default 0
268:     * (modeless) - e la isso bastava porque o "Do Form" guardava a referencia.
269:     * Aqui o menu abre com CREATEOBJECT numa variavel LOCAL seguido de Show():
270:     * com WindowType = 0 o Show() retorna na hora, a variavel sai de escopo, a
271:     * ultima referencia cai e a tela eh DESTRUIDA - pisca e some, sem erro e
272:     * sem log. Por isso valem os valores canonicos do projeto (435 dos 459
273:     * forms). O que de fato tranca a tela (TitleBar = 0, ControlBox = .F.)
274:     * continua transcrito do dump, acima.
275:     *--------------------------------------------------------------------------
276:     ShowWindow  = 1
277:     WindowType  = 1
278: 
279:     *--------------------------------------------------------------------------
280:     * Propriedades de estado
281:     *
282:     * Unica propriedade customizada do SCX (RESERVED3: automatico, podatamgr,
283:     * sigkey, tipocep, contapar, multemps) que o FORM precisa ler para decidir
284:     * UI. As demais (sigkey/tipocep/contapar/multemps) sao estado do
285:     * PROCESSAMENTO e ja vivem no BO (sigoprbtBO.prg) - nao se duplicam aqui.
286:     * poDataMgr nao tem equivalente: a conexao eh a global gnConnHandle.
287:     *--------------------------------------------------------------------------
288:     this_lAutomatico = .F.   && SCX automatico - pAuto do Init legado
289: 
290:     *-- Sem equivalente no SCX: o legado era modal e rodava o lote UMA vez por
291:     *-- abertura de tela (Init -> Click -> Release). Aqui o disparo automatico
292:     *-- mora em Activate(), que o VFP9 chama a cada reativacao da janela, entao
293:     *-- precisa de trava para nao reprocessar o lote ao voltar o foco.
294:     this_lAutomaticoDisparado = .F.
295: 
296:     *-- this_cMensagemErro eh declarada em FormBase; redeclarada aqui porque os
297:     *-- CATCH deste form escrevem nela.
298:     this_cMensagemErro = ""
299: 
300:     *==========================================================================
301:     * Init - ponto de entrada do form
302:     *
303:     * Assinatura transcrita do SCX legado: Parameters pAuto
304:     *
305:     * Captura com guarda de VARTYPE porque em VFP9 parametro NAO passado chega
306:     * como .F. LOGICO - e o harness de teste (TestFormWrapper) instancia esta
307:     * classe sem argumento nenhum. PCOUNT() entra na guarda porque o tipo do
308:     * ausente ("L") coincide com o tipo esperado, e VARTYPE sozinho nao separa
309:     * "nao passou" de "passou .F.".
310:     *
311:     * A captura vem ANTES do DODEFAULT() de proposito: FormBase.Init chama
312:     * InicializarForm, que repassa este valor ao Business Object na criacao.
313:     *==========================================================================
314:     FUNCTION Init(par_lAutomatico)
315:         LOCAL loc_lSucesso
316: 
317:         IF PCOUNT() >= 1 AND VARTYPE(par_lAutomatico) = "L"
318:             THIS.this_lAutomatico = par_lAutomatico
319:         ENDIF
320: 
321:         *-- Constroi o form (FormBase.Init -> THIS.InicializarForm)
322:         loc_lSucesso = DODEFAULT()
323: 
324:         RETURN loc_lSucesso
325:     ENDFUNC
326: 
327:     *==========================================================================
328:     * InicializarForm - monta a estrutura base do form
329:     *
330:     * Contrato do FormBase.Init: devolver .T. em sucesso e .F. em falha (com
331:     * .F. o CREATEOBJECT do chamador devolve logico e a tela NAO abre).
332:     *==========================================================================
333:     PROTECTED PROCEDURE InicializarForm()
334:         LOCAL loc_lSucesso, loc_oErro
335:         loc_lSucesso = .F.
336: 
337:         TRY
338:             *-- 1. Fundo do form. No SCX legado:
339:             *--    Picture = ..\framework\imagens\new_background.jpg
340:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
341: 
342:             *-- 2. Business Object. O Automatico vai direto no CREATEOBJECT -
343:             *--    CREATEOBJECT repassa argumentos extras ao Init() da classe,
344:             *--    e sigoprbtBO.Init(par_lAutomatico) ja tem a mesma guarda de
345:             *--    PCOUNT/VARTYPE (sigoprbtBO.prg:179-212).
346:             THIS.this_oBusinessObject = CREATEOBJECT("sigoprbtBO", ;
347:                                                       THIS.this_lAutomatico)
348: 
349:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
350: 
351:                 *-- 2b. Parametros do sistema (SigCdGcr / SigCdPaC / SigCdPam),
352:                 *--     as tres consultas que o Init legado roda depois do
353:                 *--     =DoDefault(). E daqui que sai this_cDopRebate, que o
354:                 *--     guard do "Processar" le - sem esta carga o guard olharia
355:                 *--     uma property vazia e BLOQUEARIA todo lote legitimo.
356:                 *--
357:                 *--     A falha NAO impede a tela de abrir: CarregarParametros
358:                 *--     ja exibe o erro de SQL com a consulta que falhou, e sem
359:                 *--     DopRebate o guard do Processamento recusa o lote de
360:                 *--     qualquer forma. Devolver .F. aqui trocaria essa
361:                 *--     mensagem precisa pelo "erro ao criar formulario"
362:                 *--     generico do chamador.
363:                 THIS.this_oBusinessObject.CarregarParametros()
364: 
365:                 *-- 3. Faixa cinza do cabecalho (cntSombra do legado).
366:                 THIS.ConfigurarCabecalho()
367: 
368:                 *-- 4. Caption propagado para os dois labels da faixa, igual
369:                 *--    as duas primeiras linhas do Init legado:
370:                 *--      ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
371:                 *--      ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
372:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
373:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
374: 
375:                 *-- 4b. CommandGroup Processar/Cancelar (cntBotoes do legado).
376:                 THIS.ConfigurarBotoes()
377: 
378:                 *-- 5. AddObject cria todo controle com Visible = .F.
379:                 THIS.TornarControlesVisiveis(THIS)
380: 
381:                 *-- 6. BINDEVENT por ULTIMO: ele so resolve referencia de
382:                 *--    objeto que JA existe.
383:                 THIS.ConfigurarEventos()
384: 
385:                 loc_lSucesso = .T.
386:             ELSE
387:                 THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
388:                     CHR(237) + "vel criar o objeto de neg" + CHR(243) + ;
389:                     "cio sigoprbtBO."
390:                 MsgErro(THIS.this_cMensagemErro, "Erro")
391:             ENDIF
392: 
393:         CATCH TO loc_oErro
394:             THIS.this_cMensagemErro = loc_oErro.Message
395:             MsgErro(loc_oErro.Message + CHR(13) + ;
396:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
397:                     "Procedure: " + loc_oErro.Procedure, ;
398:                     "Erro em Formsigoprbt.InicializarForm")
399:         ENDTRY
400: 
401:         RETURN loc_lSucesso
402:     ENDPROC
403: 
404:     *==========================================================================
405:     * ConfigurarCabecalho - faixa cinza com o titulo da tela
406:     *
407:     * mapeamento.json: SIGOPRBT.cntSombra           -> cnt_4c_Sombra
408:     *                  SIGOPRBT.cntSombra.lblSombra -> lbl_4c_LblSombra
409:     *                  SIGOPRBT.cntSombra.lblTitulo -> lbl_4c_LblTitulo
410:     *
411:     * O container eh identificado pelo par BackColor = RGB(100,100,100) +
412:     * Height = 80 (regra #11 - nunca pelo nome). lbl_4c_LblSombra eh a sombra
413:     * PRETA desenhada 1px ABAIXO do titulo BRANCO (dump: lblTitulo.Top = 17,
414:     * lblSombra.Top = 18), por isso a sombra eh criada PRIMEIRO, na ordem da
415:     * arvore do SCX. O branco do titulo eh legitimo aqui: os dois labels moram
416:     * num container OPACO escuro (BackStyle = 1), que eh a excecao da regra #12.
417:     *
418:     * LARGURAS - por que NAO se copia o literal do dump
419:     * O SCX declara cntSombra.Width = 800 e os dois labels com Width = 769,
420:     * contra SIGOPRBT.Width = 718: o container do cabecalho foi desenhado no
421:     * Form Designer mais largo que a propria janela. Copiar 769 faria o label
422:     * ultrapassar a area visivel e o titulo sairia CORTADO (controle fora do
423:     * pai eh recortado sem erro - regra #30). Entao o container acompanha
424:     * THIS.Width e os labels ficam em THIS.Width - 20, preservando a margem de
425:     * 10px que o dump declara nos dois lados.
426:     *
427:     * AutoSize = .F. explicito (regra #23): AutoSize eh no-op em Label criado
428:     * por AddObject e, com WordWrap = .T., DESCARTA a .Height e corta o texto.
429:     * As Heights de 40/46 que o dump declara JA SAO o auto-size que o Form
430:     * Designer calculou, logo fixa-las eh reproducao fiel.
431:     *
432:     * Sem PageFrame neste form, entao sem compensacao de +29 no Top.
433:     *==========================================================================
434:     PROTECTED PROCEDURE ConfigurarCabecalho()
435:         LOCAL loc_oCnt
436: 
437:         THIS.AddObject("cnt_4c_Sombra", "Container")
438:         loc_oCnt = THIS.cnt_4c_Sombra
439: 
440:         WITH loc_oCnt
441:             .Top           = 0
442:             .Left          = 0
443:             .Width         = THIS.Width
444:             .Height        = 80
445:             .BorderWidth   = 0
446:             .BackStyle     = 1
447:             .BackColor     = RGB(100, 100, 100)
448:             .SpecialEffect = 0
449:             .Visible       = .T.
450:         ENDWITH
451: 
452:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
453:         WITH loc_oCnt.lbl_4c_LblSombra
454:             .FontBold      = .T.
455:             .FontName      = "Tahoma"
456:             .FontSize      = 18
457:             .FontUnderline = .F.
458:             .WordWrap      = .T.
459:             .Alignment     = 0
460:             .BackStyle     = 0
461:             .AutoSize      = .F.
462:             .Caption       = THIS.Caption
463:             .Top           = 18
464:             .Left          = 10
465:             .Width         = THIS.Width - 20
466:             .Height        = 40
467:             .ForeColor     = RGB(0, 0, 0)
468:             .Visible       = .T.
469:         ENDWITH
470: 
471:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
472:         WITH loc_oCnt.lbl_4c_LblTitulo
473:             .FontBold    = .T.
474:             .FontName    = "Tahoma"

*-- Linhas 529 a 572:
529:     * nao esconde controle nenhum: transcrito literal (PILAR 1). Os botoes
530:     * terminam em Left 158 dentro do grupo, bem antes da borda dele.
531:     *==========================================================================
532:     PROTECTED PROCEDURE ConfigurarBotoes()
533:         LOCAL loc_oGrp
534: 
535:         THIS.AddObject("cmg_4c_Acoes", "CommandGroup")
536:         loc_oGrp = THIS.cmg_4c_Acoes
537: 
538:         WITH loc_oGrp
539:             .ButtonCount   = 2
540:             .AutoSize      = .F.
541:             .BackStyle     = 0
542:             .BorderStyle   = 0
543:             .SpecialEffect = 1
544:             .BorderColor   = RGB(136, 189, 188)
545:             .Themes        = .F.
546:             .Value         = 0
547:             .Top           = -2
548:             .Left          = 560
549:             .Width         = 166
550:             .Height        = 85
551: 
552:             WITH .Buttons(1)
553:                 .Top           = 5
554:                 .Left          = 83
555:                 .Width         = 75
556:                 .Height        = 75
557:                 .FontBold      = .T.
558:                 .FontItalic    = .T.
559:                 .FontName      = "Comic Sans MS"
560:                 .FontSize      = 8
561:                 .WordWrap      = .T.
562:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
563:                 .Cancel        = .T.
564:                 .Caption       = "\<Cancelar"
565:                 .MousePointer  = 15
566:                 .TabIndex      = 2
567:                 .ToolTipText   = "[Esc] Encerrar"
568:                 .SpecialEffect = 0
569:                 .ForeColor     = RGB(90, 90, 90)
570:                 .BackColor     = RGB(255, 255, 255)
571:                 .Themes        = .F.
572:             ENDWITH

*-- Linhas 598 a 737:
598:     ENDPROC
599: 
600:     *==========================================================================
601:     * ConfigurarEventos - BINDEVENT dos Click dos botoes
602:     *
603:     * Vem por ULTIMO na montagem do form: BINDEVENT so resolve referencia de
604:     * objeto que JA existe.
605:     *
606:     * O handler eh PUBLIC (sem PROTECTED): com metodo PROTECTED o BINDEVENT
607:     * falha em SILENCIO e o botao fica inerte (regra #3).
608:     *
609:     * Os dois Click ligados aqui sao os dois unicos botoes do SCX:
610:     * Buttons(1) = btnSair ("Cancelar") e Buttons(2) = btnConfirmar
611:     * ("Processar"). A ordem dos Buttons(N) eh a de criacao no dump, nao a
612:     * visual - ver ConfigurarBotoes().
613:     *
614:     * O Click do CommandGroup (o do GRUPO, nao o do botao) NAO eh ligado: o
615:     * legado nao tem PROCEDURE cntBotoes.Click, so os dois .Click de botao.
616:     *==========================================================================
617:     PROTECTED PROCEDURE ConfigurarEventos()
618:         LOCAL loc_oErro
619: 
620:         TRY
621:             BINDEVENT(THIS.cmg_4c_Acoes.Buttons(1), "Click", ;
622:                       THIS, "CmdCancelarClick")
623: 
624:             BINDEVENT(THIS.cmg_4c_Acoes.Buttons(2), "Click", ;
625:                       THIS, "CmdProcessarClick")
626:         CATCH TO loc_oErro
627:             THIS.this_cMensagemErro = loc_oErro.Message
628:             MsgErro(loc_oErro.Message + CHR(13) + ;
629:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
630:                     "Procedure: " + loc_oErro.Procedure, ;
631:                     "Erro em Formsigoprbt.ConfigurarEventos")
632:         ENDTRY
633: 
634:         RETURN .T.
635:     ENDPROC
636: 
637:     *==========================================================================
638:     * CmdCancelarClick - Click do botao "Cancelar" (Buttons(1) / btnSair)
639:     *
640:     * Transcricao do legado, que tem uma linha so:
641:     *
642:     *     PROCEDURE btnSair.Click
643:     *     ThisForm.Release
644:     *
645:     * Release() e nao Hide(): com WindowType = 1 o Show() do chamador esta
646:     * BLOQUEADO, e eh o Release que devolve o controle a ele. Esta tela nao
647:     * devolve valor nenhum - ninguem le propriedade dela depois de fechada, nem
648:     * o proprio Init legado, que no modo automatico tambem faz
649:     * "ThisForm.Release" - entao Hide apenas deixaria o objeto vivo sem uso.
650:     *
651:     * Buttons(1) tem Cancel = .T. no dump, entao [Esc] cai neste mesmo handler.
652:     *==========================================================================
653:     PROCEDURE CmdCancelarClick()
654:         LOCAL loc_oErro
655: 
656:         TRY
657:             THIS.Release()
658:         CATCH TO loc_oErro
659:             MsgErro(loc_oErro.Message + CHR(13) + ;
660:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
661:                     "Procedure: " + loc_oErro.Procedure, ;
662:                     "Erro em Formsigoprbt.CmdCancelarClick")
663:         ENDTRY
664:     ENDPROC
665: 
666:     *==========================================================================
667:     * CmdProcessarClick - Click do botao "Processar" (Buttons(2)/btnConfirmar)
668:     *
669:     * Transcricao do legado, que tem uma linha so:
670:     *
671:     *     PROCEDURE btnConfirmar.Click
672:     *     ThisForm.Processamento()
673:     *
674:     * O retorno eh descartado aqui como no legado - quem avisa o usuario eh o
675:     * proprio Processamento(), em todos os caminhos.
676:     *
677:     * A tela NAO se fecha depois do lote: o legado so faz Release no modo
678:     * automatico (ver Activate()), e no modo interativo deixa a janela aberta
679:     * para que o usuario possa rodar outro lote ou sair pelo Cancelar.
680:     *==========================================================================
681:     PROCEDURE CmdProcessarClick()
682:         LOCAL loc_oErro
683: 
684:         TRY
685:             THIS.Processamento()
686:         CATCH TO loc_oErro
687:             MsgErro(loc_oErro.Message + CHR(13) + ;
688:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
689:                     "Procedure: " + loc_oErro.Procedure, ;
690:                     "Erro em Formsigoprbt.CmdProcessarClick")
691:         ENDTRY
692:     ENDPROC
693: 
694:     *==========================================================================
695:     * Processamento - orquestracao do lote de rebates
696:     *
697:     * Transcricao da PROCEDURE processamento legada
698:     * (sigoprbt_form_codigo_fonte.txt:763-791), passo a passo:
699:     *
700:     *     If Not Thisform.Automatico
701:     *         If Messagebox([Confirma o Lancamento dos Rebates no Sistema?],4+32,[Atencao])<>6
702:     *             Return .F.
703:     *         Endif
704:     *     Endif
705:     *     Set Step On                                    && NAO transcrito
706:     *     Select crSigCdPaC
707:     *     If IsEmpty(crSigCdPaC.DopRBT)
708:     *         If Not Thisform.Automatico
709:     *             MessageBox([Movimentacao de Rebate nao Informada.],0+48,[Aviso])
710:     *             Return .F.
711:     *         EndIf
712:     *     EndIf
713:     *     =fGravarLog('T', Thisform.Name,[REBATE],[Inicio da Gravacao],Usuar)
714:     *     If Not ThisForm.GeraMovimentacao()
715:     *         Return .F.
716:     *     EndIf
717:     *     If Not Thisform.Automatico
718:     *         MessageBox([Integracao Realizada.],0+64,[Atencao])
719:     *     EndIf
720:     *     =fGravarLog('T', Thisform.Name,[REBATE],[Atualizacao dos Dados da Integracao],Usuar)
721:     *     Return .T.
722:     *
723:     * TRES DETALHES DE TRANSCRICAO QUE NAO SE "ARRUMAM"
724:     *
725:     * 1) O guard de DopRBT so ABORTA quando Automatico = .F. Com Automatico
726:     *    = .T. e DopRBT vazio o legado NAO retorna: o IF interno nao casa e a
727:     *    execucao SEGUE para o motor de integracao. Parece descuido, mas eh o
728:     *    comportamento do legado, e a regra #17 manda transcrever o SINAL e os
729:     *    GUARDS como estao - "arrumar" aqui mudaria o que o lote automatico faz
730:     *    hoje em producao. O comentario no corpo marca o ponto.
731:     *
732:     * 2) "Set Step On" nao entra - eh breakpoint de depuracao esquecido no
733:     *    fonte legado (ver o cabecalho deste arquivo).
734:     *
735:     * 3) O "Select crSigCdPaC" do legado existe porque la a leitura era
736:     *    crSigCdPaC.DopRBT (campo de cursor). Aqui o valor ja esta na property
737:     *    this_cDopRebate, carregada por sigoprbtBO.CarregarParametros a partir

*-- Linhas 745 a 820:
745:     * guards de confirmacao e de DopRBT sao avaliados ANTES do TRY, onde o
746:     * RETURN antecipado eh legitimo.
747:     *==========================================================================
748:     PROCEDURE Processamento()
749:         LOCAL loc_lSucesso, loc_lAuto, loc_cDopRebate, loc_oBO, loc_oErro
750: 
751:         loc_lSucesso = .F.
752:         loc_oBO      = THIS.this_oBusinessObject
753: 
754:         IF VARTYPE(loc_oBO) != "O"
755:             MsgErro("O objeto de neg" + CHR(243) + "cio sigoprbtBO n" + ;
756:                     CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
757:                     "vel - nada foi processado.", "Erro")
758:             RETURN .F.
759:         ENDIF
760: 
761:         loc_lAuto = THIS.this_lAutomatico
762: 
763:         *-- Confirmacao do usuario. MsgConfirma devolve LOGICO (regra #7) -
764:         *-- nunca comparar com 6 como o MessageBox legado faz.
765:         IF !loc_lAuto
766:             IF !MsgConfirma("Confirma o Lan" + CHR(231) + "amento dos Rebates " + ;
767:                             "no Sistema?", "Aten" + CHR(231) + CHR(227) + "o")
768:                 RETURN .F.
769:             ENDIF
770:         ENDIF
771: 
772:         *-- Guard da movimentacao de rebate (SigCdPaC.DopRBT): sem ela o lote
773:         *-- nao sabe em que movimentacao lancar. EMPTY() cobre tambem o NULL,
774:         *-- porque CarregarParametros ja passou a coluna por TratarNulo - eh o
775:         *-- IsEmpty() do legado, que trata NULL como vazio.
776:         loc_cDopRebate = ALLTRIM(loc_oBO.this_cDopRebate)
777: 
778:         IF EMPTY(loc_cDopRebate)
779:             IF !loc_lAuto
780:                 MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de Rebate n" + ;
781:                          CHR(227) + "o Informada.", "Aviso")
782:                 RETURN .F.
783:             ENDIF
784:             *-- Automatico = .T.: o legado NAO aborta aqui (detalhe 1 acima) e
785:             *-- segue para o motor de integracao.
786:         ENDIF
787: 
788:         TRY
789:             =fGravarLog("T", THIS.Name, "REBATE", ;
790:                         "Inicio da Grava" + CHR(231) + CHR(227) + "o", ;
791:                         gc_4c_UsuarioLogado)
792: 
793:             *-- Motor de integracao (GeraMovimentacao + LancaContaCorrente +
794:             *-- FazContra + MontaHists do legado, traduzidos em sigoprbtBO).
795:             *-- O guard de PEMSTATUS fica: ele eh a rede que impede o lote de
796:             *-- anunciar sucesso sem ter chamado o motor (regras #20 e #21) se
797:             *-- alguem renomear o metodo no BO. PEMSTATUS com atributo 5
798:             *-- confirma a existencia do membro.
799:             IF !PEMSTATUS(loc_oBO, "GerarMovimentacao", 5)
800:                 MsgErro("O motor de integra" + CHR(231) + CHR(227) + "o de " + ;
801:                         "rebates (GerarMovimentacao) n" + CHR(227) + "o foi " + ;
802:                         "localizado em sigoprbtBO." + CHR(13) + ;
803:                         "Nenhum dado foi gravado.", ;
804:                         "Aten" + CHR(231) + CHR(227) + "o")
805:             ELSE
806:                 loc_lSucesso = loc_oBO.GerarMovimentacao()
807: 
808:                 IF loc_lSucesso
809:                     IF !loc_lAuto
810:                         *-- O legado exibe so "Integracao Realizada."; o resumo
811:                         *-- vem depois porque o lote eh cego (nao tem grade
812:                         *-- nenhuma para o usuario conferir o que entrou) e os
813:                         *-- contadores ja eram mantidos pelo BO.
814:                         MsgInfo("Integra" + CHR(231) + CHR(227) + "o Realizada." + ;
815:                                 CHR(13) + CHR(13) + THIS.MontarResumoLote(), ;
816:                                 "Aten" + CHR(231) + CHR(227) + "o")
817:                     ENDIF
818: 
819:                     =fGravarLog("T", THIS.Name, "REBATE", ;
820:                                 "Atualiza" + CHR(231) + CHR(227) + "o dos Dados " + ;

*-- Linhas 828 a 946:
828:             THIS.this_cMensagemErro = loc_oErro.Message
829:             MsgErro(loc_oErro.Message + CHR(13) + ;
830:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
831:                     "Procedure: " + loc_oErro.Procedure, ;
832:                     "Erro em Formsigoprbt.Processamento")
833:         ENDTRY
834: 
835:         RETURN loc_lSucesso
836:     ENDPROC
837: 
838:     *==========================================================================
839:     * Activate - disparo do modo automatico (pAuto)
840:     *
841:     * Equivale as ultimas linhas do Init legado:
842:     *
843:     *     If ThisForm.Automatico
844:     *         ThisForm.cntBotoes.btnConfirmar.Click()
845:     *         ThisForm.Release
846:     *     EndIf
847:     *
848:     * POR QUE EM Activate() E NAO NO Init()
849:     * No legado a tela era aberta com "Do Form", que guarda a referencia: fazer
850:     * Release dentro do Init apenas impedia a janela de aparecer. Aqui o
851:     * chamador faz CREATEOBJECT numa variavel LOCAL e depois Show() - soltar a
852:     * referencia durante o Init deixaria o CREATEOBJECT devolver objeto
853:     * inutilizavel e o Show() seguinte nao teria o que exibir. Activate() roda
854:     * depois do Show(), com a janela ja montada, e eh o ponto canonico do
855:     * projeto para lote automatico (ver Formsigprccp.Activate).
856:     *
857:     * A trava this_lAutomaticoDisparado eh obrigatoria: o VFP9 chama Activate a
858:     * CADA reativacao da janela (inclusive ao voltar de um dialogo modal) e, sem
859:     * ela, o lote rodaria de novo a cada troca de foco. O legado nao precisava
860:     * da trava porque rodava o lote no Init e fechava em seguida.
861:     *
862:     * O Release() reproduz o "ThisForm.Release" legado: no modo automatico a
863:     * tela nao tem o que mostrar depois do lote.
864:     *
865:     * O lote NAO roda em modo de teste nem em validacao de UI: ali nao ha
866:     * conexao valida e o objetivo eh apenas instanciar o form.
867:     *==========================================================================
868:     PROCEDURE Activate()
869:         IF THIS.this_lAutomatico AND !THIS.this_lAutomaticoDisparado
870:             THIS.this_lAutomaticoDisparado = .T.
871: 
872:             IF !((TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
873:                  (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI))
874:                 THIS.Processamento()
875:                 THIS.Release()
876:             ENDIF
877:         ENDIF
878:     ENDPROC
879: 
880:     *==========================================================================
881:     * TornarControlesVisiveis - AddObject cria tudo com Visible = .F.
882:     *
883:     * Recursivo (Container/PageFrame aninhados). cmg_4c_Acoes eh
884:     * CommandGroup (PEMSTATUS "ControlCount" = .F. - sem Controls()/Controls,
885:     * so Buttons()/ButtonCount) e por isso nao entra na recursao; sua
886:     * visibilidade e a dos Buttons(N) ja sao resolvidas em ConfigurarBotoes()
887:     * via .Visible = .T. no proprio grupo. Nao ha container flutuante nesta
888:     * fase, entao nenhum filtro de nome eh necessario ainda.
889:     *==========================================================================
890:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
891:         LOCAL loc_nI, loc_oControle
892: 
893:         IF VARTYPE(par_oContainer) != "O"
894:             RETURN .F.
895:         ENDIF
896: 
897:         FOR loc_nI = 1 TO par_oContainer.ControlCount
898:             loc_oControle = par_oContainer.Controls(loc_nI)
899: 
900:             IF PEMSTATUS(loc_oControle, "Visible", 5)
901:                 loc_oControle.Visible = .T.
902:             ENDIF
903: 
904:             IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND ;
905:                loc_oControle.ControlCount > 0
906:                 THIS.TornarControlesVisiveis(loc_oControle)
907:             ENDIF
908:         ENDFOR
909: 
910:         RETURN .T.
911:     ENDPROC
912: 
913:     *==========================================================================
914:     * MontarResumoLote - o resumo que acompanha o "Integracao Realizada."
915:     *
916:     * Le os contadores que o BO mantem durante o lote. Nao existe no legado:
917:     * la a tela tambem nao mostrava nada, mas la o lote era modal e rodava uma
918:     * vez por abertura. Aqui o usuario pode acionar "Processar" varias vezes
919:     * sem fechar a tela, e sem grade nenhuma para conferir o que entrou o
920:     * resumo eh a unica forma de saber o que o lote fez - inclusive distinguir
921:     * "integrou 3 dias" de "todos os dias ja estavam integrados".
922:     *==========================================================================
923:     PROTECTED FUNCTION MontarResumoLote()
924:         LOCAL loc_oBO, loc_cTexto
925: 
926:         loc_oBO = THIS.this_oBusinessObject
927: 
928:         IF VARTYPE(loc_oBO) != "O"
929:             RETURN ""
930:         ENDIF
931: 
932:         loc_cTexto = ;
933:             "Grupos Empresa/Dia/M" + CHR(234) + "s lidos: " + ;
934:                 ALLTRIM(STR(loc_oBO.this_nRegistrosLidos)) + CHR(13) + ;
935:             "Integrados agora: " + ;
936:                 ALLTRIM(STR(loc_oBO.this_nRegistrosGravados)) + CHR(13) + ;
937:             "J" + CHR(225) + " integrados (pulados): " + ;
938:                 ALLTRIM(STR(loc_oBO.this_nRegistrosPulados)) + CHR(13) + ;
939:             "Movimenta" + CHR(231) + CHR(245) + "es: " + ;
940:                 ALLTRIM(STR(loc_oBO.this_nMovimentosGerados)) + CHR(13) + ;
941:             "Itens: " + ALLTRIM(STR(loc_oBO.this_nItensGerados)) + CHR(13) + ;
942:             "Parcelas: " + ALLTRIM(STR(loc_oBO.this_nParcelasGeradas)) + CHR(13) + ;
943:             "Lan" + CHR(231) + "amentos de conta corrente: " + ;
944:                 ALLTRIM(STR(loc_oBO.this_nLancamentosCC)) + CHR(13) + ;
945:             "Valor total integrado: " + ;
946:                 ALLTRIM(TRANSFORM(loc_oBO.this_nValorTotal, "@R 999,999,999.99"))

*-- Linhas 963 a 985:
963:     * FormBase.Destroy tambem restaura o menu principal (SET SYSMENU TO
964:     * DEFAULT + CriarMenuPrincipal).
965:     *==========================================================================
966:     PROCEDURE Destroy()
967:         LOCAL loc_oErro
968: 
969:         TRY
970:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
971:                PEMSTATUS(THIS.this_oBusinessObject, "LiberarCursores", 5)
972:                 THIS.this_oBusinessObject.LiberarCursores()
973:             ENDIF
974:         CATCH TO loc_oErro
975:             *-- Falha ao fechar cursor nao pode impedir a tela de fechar, mas
976:             *-- tambem nao pode ser engolida (regra #9).
977:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel liberar " + ;
978:                      "os cursores do processamento:" + CHR(13) + ;
979:                      loc_oErro.Message, "Aviso")
980:         ENDTRY
981: 
982:         RETURN DODEFAULT()
983:     ENDPROC
984: 
985: ENDDEFINE

