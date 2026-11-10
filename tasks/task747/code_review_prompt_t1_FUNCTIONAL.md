# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarLoteImpressao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpIgm.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1679 linhas total):

*-- Linhas 39 a 132:
39: *                     ResolverTipoBoleto, ImprimirDocumentoDaLinha,
40: *                     MarcarLinhaComoImpressa, ContarMarcadas, ValidarDados).
41: *   Fase 3          - DEFINE CLASS, propriedades visuais e de estado,
42: *                     Init/Destroy/InicializarForm, o orquestrador de
43: *                     montagem ConfigurarPageFrame(), o cabecalho
44: *                     cnt_4c_Sombra (cntSombra do legado, com lbl_4c_LblSombra
45: *                     e lbl_4c_LblTitulo) e TornarControlesVisiveis().
46: *                     O cursor da grade tambem nasce aqui, via
47: *                     SigOpIgmBO.CriarCursorMovimentacoes() - equivalente ao
48: *                     "Create Cursor csPgto" do PROCEDURE Load legado, que
49: *                     roda ANTES de qualquer controle existir e precisa estar
50: *                     aberto para a grade da Fase 4 poder se ligar a ele.
51: *   Fase 4 (esta)   - grd_4c_Dados (Grd do legado: 3 colunas - CheckBox de
52: *                     marcacao, Movimentacoes e Valor), a carga da grade
53: *                     (CarregarLista(), que chama SigOpIgmBO.Buscar() e
54: *                     repinta a grade) e os QUATRO botoes de acao que o
55: *                     legado tem como filhos diretos do form, via
56: *                     ConfigurarBotoes(): cmd_4c_BtnBoleto / cmd_4c_Imprimir /
57: *                     cmd_4c_Grade / cmd_4c_Sair. A visibilidade condicional
58: *                     do Boleto (AjustarVisibilidadeBoleto) tambem entra aqui,
59: *                     porque depende do botao ja existir.
60: *   Fase 5-6        - campos e eventos de celula da grade.
61: *   Fase 7          - os Click dos quatro botoes e o respectivo BINDEVENT de
62: *                     cada um (BINDEVENT valida o delegate NA HORA DO BIND,
63: *                     entao o bind vai junto com o handler, nunca adiantado),
64: *                     mais o KeyPress do form (KeyPreview = .T.: F2 aciona
65: *                     Imprimir e F3 aciona Grade, conforme o PROCEDURE
66: *                     KeyPress legado).
67: *   Fase 8 (esta)   - os eventos AUXILIARES que faltavam e a consolidacao
68: *                     final (detalhado abaixo).
69: *
70: * --- O QUE A FASE 8/8 ENTREGA -------------------------------------------
71: *
72: * 1. O ULTIMO evento com codigo que restava no dump legado: o Click do
73: *    checkbox da coluna 1 da grade (SIGOPIGM.Grd.Column1.Check1.Click,
74: *    "if !(csPgto.printed) / This.value = .t."). Entra como o quarteto
75: *    canonico Click/MouseDown/MouseUp/KeyPress com NODEFAULT
76: *    (ChkMarca*), porque CheckBox posto em Column por AddObject NAO
77: *    alterna pelo binding nativo. Com isto NAO sobra metodo do legado sem
78: *    migrar: Load -> SigOpIgmBO.CriarCursorMovimentacoes, Init ->
79: *    Init/InicializarForm/FormParaBO/CarregarLista/BOParaForm, KeyPress ->
80: *    KeyPress, Check1.Click -> ChkMarca*, Column2/Column3.Text1.When
81: *    ("Return .f.") -> Column.ReadOnly = .T. em ConfigurarGrid,
82: *    Sair.Click -> BtnSairClick, Grade.Click -> BtnGradeClick,
83: *    Imprimir.Click -> BtnImprimirClick, btnBoleto.Click ->
84: *    BtnBoletoClick.
85: *
86: * 2. FormParaBO() / BOParaForm(), o par de espelhamento tela<->BO que o
87: *    template da Fase 8 pede - aqui como FUNIL dos dois sentidos que este
88: *    dialogo de fato tem, NAO como metodo novo sem uso:
89: *      FormParaBO  - empurra para o BO os cinco dados que o Init legado
90: *                    recebe por parametro (Emps/Dopes/Numes/pChkImpDoc/
91: *                    Boleto); era a chamada solta a DefinirParametros()
92: *                    dentro de InicializarForm.
93: *      BOParaForm  - traz do BO o que a tela EXIBE depois da carga: a
94: *                    visibilidade do botao Boleto (a ultima linha do Init
95: *                    legado), o estado dos botoes de acao e o repintar da
96: *                    grade; era a chamada solta a AjustarVisibilidadeBoleto().
97: *    Nao ha campo digitavel FORA da grade neste dialogo (o dump tem
98: *    cntSombra + grade + 4 botoes, e nada mais): as tres colunas se ligam
99: *    ao cursor por ControlSource, entao o "campo a campo" do par CRUD
100: *    nao tem outro referente aqui.
101: *
102: * 3. AjustarBotoesPorModo() / HabilitarCampos(), cumprindo o que o
103: *    cabecalho de ConfigurarBotoes() promete desde a Fase 7 (os botoes
104: *    nascem com Themes = .T. + DisabledPicture justamente para poderem
105: *    ficar Enabled = .F. sem perder o icone): refletem na tela a guarda
106: *    this_lProcessandoLote que BtnImprimirClick/BtnBoletoClick/
107: *    BtnSairClick ja consultavam. Nao e comportamento novo - e a mesma
108: *    decisao, visivel.
109: *
110: * 4. ValidarLoteImpressao(), que consolida numa FONTE UNICA o aviso de
111: *    grade vazia ("Nao existem observacoes a serem auteticadas", grafia
112: *    do legado) - o mesmo texto estava LITERAL nos dois handlers e ainda
113: *    em SigOpIgmBO.ValidarDados, que ninguem chamava. Agora os dois
114: *    handlers chamam o BO.
115: *
116: * --- NOMES DO TEMPLATE CRUD QUE NAO SE APLICAM --------------------------
117: *
118: * BtnSalvarClick / BtnCancelarClick / BtnBuscarClick / BtnEncerrarClick /
119: * LimparCampos nao tem referente neste legado, pelo mesmo motivo das
120: * Fases 4 a 7 (e igual ao irmao FormSigOpIbo):
121: *   - o dialogo nao grava registro nenhum (nao tem tabela propria, nem
122: *     chave primaria, nem cursor de edicao - ver o cabecalho de
123: *     SigOpIgmBO.prg): nao ha o que SALVAR nem o que CANCELAR;
124: *   - nao ha PageFrame, nem Page1 (Lista)/Page2 (Dados), nem modo de
125: *     edicao - o dump nao tem "BaseClass: pageframe";
126: *   - a saida da tela e o botao Sair do legado (Cancel = .T., Click =
127: *     "ThisForm.Release"), entregue como BtnSairClick; renomea-lo para
128: *     Cancelar/Encerrar faria o nome MENTIR sobre o que o metodo faz;
129: *   - nao ha filtro nem campo de busca a BUSCAR: a consulta e UMA so,
130: *     pela chave posicional que o chamador passa por parametro;
131: *   - nao ha campo a LIMPAR fora da grade, e a grade e recarregada por
132: *     CarregarLista (ZAP + INSERT no BO), nunca "limpa" campo a campo.

*-- Linhas 150 a 193:
150:     * (Cancel = .T. no legado, ou seja ESC tambem fecha).
151:     *
152:     * A Picture do form (..\framework\imagens\new_background.jpg no dump) e
153:     * resolvida em InicializarForm() via gc_4c_CaminhoFramework, com guarda
154:     * de FILE(): .Picture apontando para arquivo inexistente falha em
155:     * SILENCIO (regra CLAUDE.md #25), e aqui o caminho depende de variavel
156:     * global que so existe depois do config.prg.
157:     *--------------------------------------------------------------------------
158:     this_cMensagemErro = ""
159:     Width       = 800
160:     Height      = 304
161:     BorderStyle = 2
162:     AutoCenter  = .T.
163:     ShowTips    = .T.
164:     ShowWindow = 1
165:     ControlBox  = .F.
166:     Movable     = .F.
167:     KeyPreview  = .T.
168:     TitleBar    = 0
169:     WindowType  = 1
170:     FontName    = "Tahoma"
171:     FontSize    = 8
172: 
173:     Caption = "Impress" + CHR(227) + "o Global de Movimenta" + CHR(231) + CHR(245) + "es"
174: 
175:     *--------------------------------------------------------------------------
176:     * Propriedades de estado - equivalem as cinco propriedades customizadas
177:     * que o dump legado declara em RESERVED3/ClassInfo (boleto, omodem,
178:     * parentform, pchkimpdoc, movimentacao), renomeadas conforme o PILAR 3.
179:     *--------------------------------------------------------------------------
180: 
181:     *-- ThisForm.Parentform do legado (1o parametro do Init). Usado para ler
182:     *-- oModemEest e para devolver o foco ao fechar.
183:     this_oFormPai = .NULL.
184: 
185:     *-- ThisForm.oModem = ThisForm.Parentform.oModemEest do legado. Fica
186:     *-- .NULL. quando o form pai nao expoe oModemEest (ou quando nao ha form
187:     *-- pai, como no harness de teste).
188:     this_oModem = .NULL.
189: 
190:     *-- ThisForm.Movimentacao = _pDopes do legado. char(20) em SigMvCab.Dopes,
191:     *-- guardado com o padding da coluna porque entra na chave POSICIONAL
192:     *-- EmpDnCrds (3 + 20 + 6 = 29) montada pelo BO (regra CLAUDE.md #42).
193:     this_cMovimentacao = SPACE(20)

*-- Linhas 235 a 288:
235:     *     "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption".
236:     *
237:     * Bypass em modo teste/validacao de UI: o harness (TestFormWrapper, etapa
238:     * 06_testForm) faz CREATEOBJECT(par_cFormClass) SEM argumento nenhum. Sem
239:     * o bypass, a validacao de parametro obrigatorio dispararia MsgErro,
240:     * Init() devolveria .F. e CREATEOBJECT devolveria .F. logico, reprovando
241:     * o form sempre - mesmo estando 100% fiel ao legado. A validacao continua
242:     * valendo em producao.
243:     *
244:     * NAO ha RETURN dentro do TRY/CATCH (regra CLAUDE.md #1): o fluxo e
245:     * controlado pelas flags loc_lParametrosOk / loc_lSucesso e ha um unico
246:     * RETURN, depois do ENDTRY.
247:     *--------------------------------------------------------------------------
248:     PROCEDURE Init()
249:         LPARAMETERS par_oFormPai, par_cEmps, par_cDopes, par_nNumes, ;
250:             par_lChkImpDoc, par_nBol
251: 
252:         LOCAL loc_lSucesso, loc_lParametrosOk, loc_lBypassParametros, loc_oErro
253: 
254:         loc_lSucesso = .F.
255:         loc_lParametrosOk = .T.
256: 
257:         loc_lBypassParametros = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
258:             (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
259: 
260:         TRY
261:             IF !loc_lBypassParametros
262:                 IF PCOUNT() < 1 OR VARTYPE(par_oFormPai) != "O"
263:                     MsgErro("Formul" + CHR(225) + "rio chamador n" + CHR(227) + ;
264:                         "o informado (par_oFormPai).", "Parametros Invalidos")
265:                     loc_lParametrosOk = .F.
266:                 ENDIF
267: 
268:                 IF loc_lParametrosOk AND ;
269:                         (PCOUNT() < 3 OR VARTYPE(par_cDopes) != "C" OR EMPTY(par_cDopes))
270:                     MsgErro("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
271:                         "o informada (par_cDopes).", "Parametros Invalidos")
272:                     loc_lParametrosOk = .F.
273:                 ENDIF
274:             ENDIF
275: 
276:             IF loc_lParametrosOk
277:                 *-- Atribuicao sempre sob guarda de VARTYPE: em bypass o
278:                 *-- parametro pode nao ter sido passado e chega como .F.
279:                 *-- logico, nao como string vazia.
280:                 THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
281: 
282:                 IF VARTYPE(par_cEmps) = "C"
283:                     THIS.this_cEmps = PADR(ALLTRIM(par_cEmps), 3)
284:                 ENDIF
285: 
286:                 IF VARTYPE(par_cDopes) = "C"
287:                     THIS.this_cMovimentacao = PADR(ALLTRIM(par_cDopes), 20)
288:                 ENDIF

*-- Linhas 305 a 483:
305:                     THIS.Caption = "Impress" + CHR(227) + "o Global de Boletos"
306:                 ENDIF
307: 
308:                 THIS.this_oBusinessObject = CREATEOBJECT("SigOpIgmBO")
309: 
310:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
311:                     loc_lSucesso = DODEFAULT()
312:                 ELSE
313:                     MsgErro("Falha ao criar SigOpIgmBO.", "Erro")
314:                 ENDIF
315:             ENDIF
316:         CATCH TO loc_oErro
317:             MsgErro("Erro ao inicializar Impress" + CHR(227) + "o Global de Movimenta" + ;
318:                 CHR(231) + CHR(245) + "es: " + loc_oErro.Message + CHR(13) + ;
319:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
320:                 "Procedure: " + loc_oErro.Procedure, "Erro")
321:         ENDTRY
322: 
323:         RETURN loc_lSucesso
324:     ENDPROC
325: 
326:     *--------------------------------------------------------------------------
327:     * InicializarForm - monta a tela. O BO e verificado primeiro: sem ele nao
328:     * ha cursor de grade nem dados, e deixar seguir produziria uma tela vazia
329:     * sem explicacao.
330:     *
331:     * A ordem reproduz o legado: o "Create Cursor csPgto" do PROCEDURE Load
332:     * roda ANTES de tudo (aqui, CriarCursorMovimentacoes no BO), e os dados
333:     * da movimentacao de origem sao repassados ao BO para que ele monte a
334:     * chave posicional EmpDnCrds usada na carga da Fase 4.
335:     *
336:     * TornarControlesVisiveis() vem por ULTIMO porque AddObject cria todo
337:     * controle com Visible = .F.
338:     *--------------------------------------------------------------------------
339:     PROTECTED PROCEDURE InicializarForm()
340:         LOCAL loc_lSucesso, loc_cPicture, loc_oErro
341: 
342:         loc_lSucesso = .F.
343: 
344:         TRY
345:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
346:                 MsgErro("SigOpIgmBO n" + CHR(227) + "o foi inicializado.", "Erro")
347:             ELSE
348:                 *-- Legado: Picture = ..\framework\imagens\new_background.jpg
349:                 IF TYPE("gc_4c_CaminhoFramework") = "C"
350:                     loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
351:                     IF FILE(loc_cPicture)
352:                         THIS.Picture = loc_cPicture
353:                     ENDIF
354:                 ENDIF
355: 
356:                 *-- Repassa ao BO os parametros de dados recebidos no Init
357:                 *-- (poform fica no Form). FUNIL unico Tela -> BO, ver
358:                 *-- FormParaBO() abaixo.
359:                 THIS.FormParaBO()
360: 
361:                 *-- Equivalente ao PROCEDURE Load legado (Create Cursor csPgto)
362:                 IF !THIS.this_oBusinessObject.CriarCursorMovimentacoes()
363:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
364:                         "vel criar o cursor das movimenta" + CHR(231) + CHR(245) + ;
365:                         "es.", "Erro")
366:                 ELSE
367:                     THIS.ConfigurarPageFrame()
368: 
369:                     IF !THIS.CarregarLista()
370:                         *-- Legado (Init): "If Reccount()=0 / ThisForm.Release /
371:                         *-- Return .F." - sem nenhuma movimentacao a autenticar o
372:                         *-- dialogo nao abre, em SILENCIO (CarregarLista/o BO ja
373:                         *-- guardaram o motivo em this_cMensagemErro, sem
374:                         *-- MsgErro). loc_lSucesso continua .F. e CREATEOBJECT
375:                         *-- reprova a instanciacao - mesmo efeito pratico do
376:                         *-- Release do legado.
377:                         loc_lSucesso = .F.
378:                     ELSE
379:                         THIS.TornarControlesVisiveis(THIS)
380: 
381:                         *-- FUNIL unico BO -> Tela. Contem a ULTIMA linha do
382:                         *-- Init legado (btnBoleto.Visible =
383:                         *-- Inlist(crSigOpCdc.VenBols, 1, 3)) e por isso roda
384:                         *-- DEPOIS da varredura acima, que forca Visible = .T.
385:                         *-- em TODO controle e apagaria a decisao.
386:                         THIS.BOParaForm()
387: 
388:                         loc_lSucesso = .T.
389:                     ENDIF
390:                 ENDIF
391:             ENDIF
392:         CATCH TO loc_oErro
393:             THIS.this_cMensagemErro = loc_oErro.Message
394:             MsgErro(loc_oErro.Message + CHR(13) + ;
395:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
396:                 "Procedure: " + loc_oErro.Procedure, ;
397:                 "Erro em FormSigOpIgm.InicializarForm")
398:         ENDTRY
399: 
400:         RETURN loc_lSucesso
401:     ENDPROC
402: 
403:     *--------------------------------------------------------------------------
404:     * ConfigurarPageFrame - orquestrador da montagem visual.
405:     *
406:     * SIGOPIGM nao tem PageFrame no legado (layout plano: cntSombra + grid +
407:     * quatro botoes direto no form). O nome do metodo e mantido apenas como
408:     * ponto de entrada arquitetural padrao do projeto, mesmo papel que tem em
409:     * Formsigopfin/FormSigPrIbb/FormSigPrGst - ele NAO cria PageFrame.
410:     *
411:     * Fase 3          - ConfigurarCabecalho() (cnt_4c_Sombra).
412:     * Fase 4 (esta)   - ConfigurarGrid() (grd_4c_Dados, 3 colunas).
413:     * Fase 7-8        - ConfigurarBotoes() (cmd_4c_BtnBoleto / cmd_4c_Imprimir /
414:     *                   cmd_4c_Grade / cmd_4c_Sair) e os eventos.
415:     *--------------------------------------------------------------------------
416:     PROTECTED PROCEDURE ConfigurarPageFrame()
417:         THIS.ConfigurarCabecalho()
418:         THIS.ConfigurarGrid()
419:         THIS.ConfigurarBotoes()
420:     ENDPROC
421: 
422:     *--------------------------------------------------------------------------
423:     * ConfigurarCabecalho - faixa cinza com o titulo, equivalente ao
424:     * cntSombra do legado (dump: Top=0, Left=0, Width=800, Height=80,
425:     * BorderWidth=0, BackColor=100,100,100).
426:     *
427:     * Os dois labels sao transcritos do dump (lblSombra: Tahoma 18 bold,
428:     * Top=18, Left=10, Width=769, Height=40, ForeColor=0,0,0; lblTitulo:
429:     * mesmos fonte/posicao com Top=17, Height=46, ForeColor=255,255,255) -
430:     * sao duas copias do mesmo texto, a de baixo em preto fazendo sombra da
431:     * de cima em branco. O branco aqui e correto porque o container e OPACO e
432:     * escuro (BackColor 100,100,100), que e justamente a excecao prevista na
433:     * regra CLAUDE.md #12.
434:     *
435:     * Caption vem de THIS.Caption nos dois, reproduzindo o
436:     * "lblSombra.Caption = ThisForm.Caption" do Init legado - por isso o Init
437:     * ajusta o Caption (modo Boleto) ANTES do DODEFAULT().
438:     *
439:     * AutoSize = .F. explicito com Width/Height do dump: AutoSize e no-op em
440:     * Label criado por AddObject e, com WordWrap = .T., descarta a Height e
441:     * corta a segunda linha (regra CLAUDE.md #23).
442:     *--------------------------------------------------------------------------
443:     PROTECTED PROCEDURE ConfigurarCabecalho()
444:         LOCAL loc_oCnt, loc_oErro
445: 
446:         TRY
447:             THIS.AddObject("cnt_4c_Sombra", "Container")
448:             loc_oCnt = THIS.cnt_4c_Sombra
449:             WITH loc_oCnt
450:                 .Top           = 0
451:                 .Left          = 0
452:                 .Width         = THIS.Width
453:                 .Height        = 80
454:                 .BorderWidth   = 0
455:                 .BackStyle     = 1
456:                 .BackColor     = RGB(100, 100, 100)
457:                 .SpecialEffect = 0
458:                 .Visible       = .T.
459:             ENDWITH
460: 
461:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
462:             WITH loc_oCnt.lbl_4c_LblSombra
463:                 .FontBold      = .T.
464:                 .FontName      = "Tahoma"
465:                 .FontSize      = 18
466:                 .FontUnderline = .F.
467:                 .WordWrap      = .T.
468:                 .Alignment     = 0
469:                 .BackStyle     = 0
470:                 .AutoSize      = .F.
471:                 .Caption       = THIS.Caption
472:                 .Top           = 18
473:                 .Left          = 10
474:                 .Width         = 769
475:                 .Height        = 40
476:                 .ForeColor     = RGB(0, 0, 0)
477:                 .Visible       = .T.
478:             ENDWITH
479: 
480:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
481:             WITH loc_oCnt.lbl_4c_LblTitulo
482:                 .FontBold    = .T.
483:                 .FontName    = "Tahoma"

*-- Linhas 498 a 578:
498:         CATCH TO loc_oErro
499:             MsgErro(loc_oErro.Message + CHR(13) + ;
500:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
501:                 "Procedure: " + loc_oErro.Procedure, ;
502:                 "Erro em FormSigOpIgm.ConfigurarCabecalho")
503:         ENDTRY
504:     ENDPROC
505: 
506:     *--------------------------------------------------------------------------
507:     * ConfigurarGrid - grd_4c_Dados: a "Grd" do legado (dump, SECAO 1 -
508:     * Top=85, Left=12, Width=346, Height=212, ColumnCount=3), ligada ao
509:     * cursor criado por CriarCursorMovimentacoes() (this_cCursorGrade =
510:     * "cursor_4c_Pgto"), vazio nesta altura e populado so depois por
511:     * CarregarLista().
512:     *
513:     * ColumnCount/RecordSource ficam FORA do WITH (regra CLAUDE.md #41): com
514:     * os dois dentro do mesmo WITH que acessa .ColumnN, o VFP9 ainda nao
515:     * recriou as colunas no instante em que .Column1 e referenciado, e
516:     * estoura "Unknown member COLUMN1".
517:     *
518:     * Tres colunas, nomes e headers do dump (mapeamento.json):
519:     *   Column1 - Check1 (csPgto.Marca, L) - sem header (dump:
520:     *             Header1.Caption = "")
521:     *   Column2 - csPgto.Obs (dump: Header1.Caption = "Movimenta" + CHR(231) +
522:     *             CHR(245) + "es")
523:     *   Column3 - csPgto.Valos (dump: Header1.Caption = "Valor")
524:     *
525:     * Column1 recebe so a ESTRUTURA nesta fase (AddObject + CurrentControl +
526:     * Sparse - regra CLAUDE.md #18, sem a qual o checkbox so aparece na
527:     * linha ativa). O comportamento "if !(csPgto.printed) / This.value = .t."
528:     * do Click legado e o quarteto ChkMarca* da Fase 8, ligado por BINDEVENT
529:     * no FIM deste metodo: CheckBox posto em Column por AddObject NAO alterna
530:     * pelo binding nativo, entao sem esses handlers a celula renderiza o
531:     * quadradinho e o clique nao faz nada.
532:     *
533:     * Marca (L) liga direto ao CheckBox: csPgto nasce de CREATE CURSOR
534:     * (READWRITE, Buffering = 1), e por isso o REPLACE que o Click legado
535:     * faz em outras linhas (MarcarLinhaComoImpressa no BO) funciona - cursor
536:     * de SQLEXEC direto seria somente-leitura.
537:     *--------------------------------------------------------------------------
538:     PROTECTED PROCEDURE ConfigurarGrid()
539:         LOCAL loc_cCursor
540:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
541: 
542:         THIS.AddObject("grd_4c_Dados", "Grid")
543: 
544:         THIS.grd_4c_Dados.ColumnCount  = 3
545:         THIS.grd_4c_Dados.RecordSource = loc_cCursor
546: 
547:         WITH THIS.grd_4c_Dados
548:             .Top           = 85
549:             .Left          = 12
550:             .Width         = 346
551:             .Height        = 212
552:             .FontName      = "Tahoma"
553:             .FontSize      = 8
554:             .DeleteMark    = .F.
555:             .RecordMark    = .F.
556:             .RowHeight     = 16
557:             .ScrollBars    = 2
558:             .GridLineColor = RGB(238, 238, 238)
559: 
560:             .Column1.AddObject("Check1", "CheckBox")
561:             .Column1.Check1.Caption  = ""
562:             .Column1.Check1.Value    = 0
563:             .Column1.CurrentControl  = "Check1"
564:             .Column1.Sparse          = .F.
565:             .Column1.ReadOnly        = .F.
566:             .Column1.Width           = 40
567:             .Column1.ControlSource   = loc_cCursor + ".Marca"
568:             .Column1.Header1.Caption = ""
569: 
570:             .Column2.ControlSource     = loc_cCursor + ".Obs"
571:             .Column2.Width             = 206
572:             .Column2.ReadOnly          = .T.
573:             .Column2.Header1.Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
574: 
575:             .Column3.ControlSource     = loc_cCursor + ".Valos"
576:             .Column3.Width             = 100
577:             .Column3.ReadOnly          = .T.
578:             .Column3.Alignment         = 3

*-- Linhas 588 a 693:
588:         *-- existem para SUPRIMIR o toggle nativo (NODEFAULT) e evitar
589:         *-- alternancia dupla, MouseUp redireciona para o KeyPress e o
590:         *-- KeyPress e quem de fato altera o cursor. Ligados DEPOIS do
591:         *-- AddObject do Check1 - BINDEVENT valida o alvo e o delegate NA HORA
592:         *-- DO BIND. Os quatro delegates sao PUBLIC (metodo PROTECTED falha em
593:         *-- SILENCIO no BINDEVENT - regra CLAUDE.md #3).
594:         BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "KeyPress",  THIS, "ChkMarcaKeyPress")
595:         BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "MouseUp",   THIS, "ChkMarcaMouseUp")
596:         BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "MouseDown", THIS, "ChkMarcaMouseDown")
597:         BINDEVENT(THIS.grd_4c_Dados.Column1.Check1, "Click",     THIS, "ChkMarcaClick")
598:     ENDPROC
599: 
600:     *--------------------------------------------------------------------------
601:     * ConfigurarBotoes - os QUATRO CommandButton que o legado tem como filhos
602:     * DIRETOS do form (dump, SECAO 1: "Parent: SIGOPIGM / Class: fwbtng /
603:     * BaseClass: commandbutton"). Nao ha CommandGroup no legado - sao quatro
604:     * botoes avulsos, e agrupa-los num cmg_4c_* inventaria estrutura que o
605:     * SCX nao tem (PILAR 1).
606:     *
607:     * Geometria, Caption, Picture, TabIndex e ToolTipText TRANSCRITOS do dump
608:     * (SECAO 2), um bloco por botao - todos Top=3, Height=75, Width=75,
609:     * encostados a direita em passo de 75px:
610:     *
611:     *   objeto legado | Left | Caption      | Picture                        | TabIndex
612:     *   btnBoleto     |  499 | "\<Boleto"   | geral_boleto_60.jpg            |    2
613:     *   Imprimir      |  574 | "\<Imprimir" | geral_impressora_normal_60.jpg |    2
614:     *   Grade         |  649 | "\<Grade"    | geral_selecionar_60.jpg        |    3
615:     *   Sair          |  724 | "Sair"       | cadastro_sair_60.jpg           |    4
616:     *
617:     * O "\<" dos tres primeiros Caption e o marcador de tecla de acesso do
618:     * VFP (ALT+B / ALT+I / ALT+G): preservado LITERALMENTE, porque remove-lo
619:     * tiraria o atalho de teclado que o usuario do legado tem (PILAR 1).
620:     *
621:     * Picture copiada do dump, NUNCA escolhida por semelhanca semantica
622:     * (regra CLAUDE.md #25): "Grade" usa geral_selecionar_60.jpg e nao uma
623:     * grade/lupa, e "Imprimir" usa geral_impressora_normal_60.jpg e nao
624:     * relatorio_impressora_26.jpg. Os quatro arquivos foram conferidos em
625:     * vbmp\ - .Picture apontando para arquivo inexistente falha em SILENCIO.
626:     *
627:     * Themes = .T. + DisabledPicture: standalone CommandButton COM Picture
628:     * nao desenha o icone com Themes = .F. quando fica Enabled = .F.
629:     * (CorretorAutomatico #99) - e estes tres botoes de acao sao desabilitados
630:     * durante a impressao em lote (Fase 8). O resto do visual e o canonico da
631:     * classe fwbtng do framework.vcx (FontName "Comic Sans MS", FontBold e
632:     * FontItalic .T., FontSize 8, ForeColor 90,90,90, BackColor 255,255,255,
633:     * MousePointer 15, WordWrap .T.) + PicturePosition 13 e SpecialEffect 0.
634:     *
635:     * Cancel = .T. em Sair vem do dump e e o que faz ESC fechar o dialogo -
636:     * sem ele a tela nao tem saida pelo teclado, porque TitleBar = 0 e
637:     * ControlBox = .F.
638:     *
639:     * Os quatro BINDEVENT ficam no FIM deste metodo, depois de todos os
640:     * AddObject: BINDEVENT valida o delegate NA HORA DO BIND e estoura
641:     * "Property <handler> is not found" se o metodo nao existir, derrubando o
642:     * InicializarForm inteiro - os quatro handlers (BtnBoletoClick,
643:     * BtnImprimirClick, BtnGradeClick, BtnSairClick) estao definidos nesta
644:     * mesma classe, logo abaixo. O KeyPress do form NAO usa BINDEVENT: e
645:     * evento nativo de Form e esta sobrescrito como metodo (o legado chama
646:     * Imprimir.Click/Grade.Click em F2/F3).
647:     *--------------------------------------------------------------------------
648:     PROTECTED PROCEDURE ConfigurarBotoes()
649:         LOCAL loc_oErro
650: 
651:         TRY
652:             *-- btnBoleto: Visible e decidido por AjustarVisibilidadeBoleto(),
653:             *-- que roda DEPOIS de TornarControlesVisiveis()
654:             THIS.AddObject("cmd_4c_BtnBoleto", "CommandButton")
655:             WITH THIS.cmd_4c_BtnBoleto
656:                 .Top             = 3
657:                 .Left            = 499
658:                 .Width           = 75
659:                 .Height          = 75
660:                 .Caption         = "\<Boleto"
661:                 .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
662:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
663:                 .Themes          = .T.
664:                 .FontName        = "Comic Sans MS"
665:                 .FontBold        = .T.
666:                 .FontItalic      = .T.
667:                 .FontSize        = 8
668:                 .ForeColor       = RGB(90, 90, 90)
669:                 .BackColor       = RGB(255, 255, 255)
670:                 .SpecialEffect   = 0
671:                 .PicturePosition = 13
672:                 .MousePointer    = 15
673:                 .WordWrap        = .T.
674:                 .AutoSize        = .F.
675:                 .TabIndex        = 2
676:                 .ToolTipText     = "[F2] Imprimir"
677:             ENDWITH
678: 
679:             THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
680:             WITH THIS.cmd_4c_Imprimir
681:                 .Top             = 3
682:                 .Left            = 574
683:                 .Width           = 75
684:                 .Height          = 75
685:                 .Caption         = "\<Imprimir"
686:                 .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
687:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
688:                 .Themes          = .T.
689:                 .FontName        = "Comic Sans MS"
690:                 .FontBold        = .T.
691:                 .FontItalic      = .T.
692:                 .FontSize        = 8
693:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 757 a 1063:
757:                 .Visible         = .T.
758:             ENDWITH
759: 
760:             *-- Um BINDEVENT por botao do legado, na ordem do dump. Todos os
761:             *-- quatro delegates sao PUBLIC (sem PROTECTED): metodo PROTECTED
762:             *-- falha em SILENCIO no BINDEVENT (regra CLAUDE.md #3).
763:             BINDEVENT(THIS.cmd_4c_BtnBoleto, "Click", THIS, "BtnBoletoClick")
764:             BINDEVENT(THIS.cmd_4c_Imprimir,  "Click", THIS, "BtnImprimirClick")
765:             BINDEVENT(THIS.cmd_4c_Grade,     "Click", THIS, "BtnGradeClick")
766:             BINDEVENT(THIS.cmd_4c_Sair,      "Click", THIS, "BtnSairClick")
767:         CATCH TO loc_oErro
768:             MsgErro(loc_oErro.Message + CHR(13) + ;
769:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
770:                 "Procedure: " + loc_oErro.Procedure, ;
771:                 "Erro em FormSigOpIgm.ConfigurarBotoes")
772:         ENDTRY
773:     ENDPROC
774: 
775:     *--------------------------------------------------------------------------
776:     * AjustarVisibilidadeBoleto - a ULTIMA linha do Init legado:
777:     *
778:     *   ThisForm.btnBoleto.Visible = Inlist(crSigOpCdc.VenBols, 1, 3)
779:     *
780:     * O criterio mora no BO (DeveExibirBotaoBoleto, que le this_nVenBols
781:     * alimentado por CarregarConfiguracaoOperacao) - aqui o form apenas
782:     * espelha a decisao no controle.
783:     *
784:     * Roda DEPOIS de TornarControlesVisiveis(), senao o Visible = .T. que
785:     * aquela varredura forca em TODO controle apagaria esta decisao - e o
786:     * botao Boleto apareceria em Operacao que nao emite boleto.
787:     *--------------------------------------------------------------------------
788:     PROTECTED PROCEDURE AjustarVisibilidadeBoleto()
789:         IF PEMSTATUS(THIS, "cmd_4c_BtnBoleto", 5)
790:             THIS.cmd_4c_BtnBoleto.Visible = ;
791:                 THIS.this_oBusinessObject.DeveExibirBotaoBoleto()
792:         ENDIF
793:     ENDPROC
794: 
795:     *--------------------------------------------------------------------------
796:     * CarregarLista - Form wrapper de SigOpIgmBO.Buscar(), que encadeia
797:     * CarregarMovimentacoes() (Select + Scan/Insert do Init legado) e
798:     * CarregarConfiguracaoOperacao() (os CursorQuery de SigOpCdc/SigCdOpe/
799:     * SigOpCdd). Devolve .F. quando nao ha nenhuma movimentacao a autenticar
800:     * - o legado fecha o dialogo nesse caso ("If Reccount()=0 /
801:     * ThisForm.Release / Return .F." do Init) sem exibir mensagem nenhuma;
802:     * quem decide fechar aqui e o chamador (InicializarForm), que usa este
803:     * retorno para reprovar a propria instanciacao - mesmo efeito pratico.
804:     *
805:     * Bypass por gb_4c_ModoTeste/gb_4c_ValidandoUI no mesmo espirito de
806:     * FormSigOpIbo.CarregarImpressoras: o harness (TesteAutomatico.prg, o
807:     * TestFormWrapper da etapa 06_testForm) instancia o form sem conexao SQL
808:     * alcancavel - sem o bypass, SQLEXEC (dentro do BO) falha, este metodo
809:     * devolveria .F. e InicializarForm reprovaria o form por falta de
810:     * conexao, nao por defeito de migracao.
811:     *
812:     * GO TOP + grd_4c_Dados.Refresh() ao final: popular o cursor NAO repinta
813:     * a grade sozinha (regra CLAUDE.md #21/#21a). Nao ha RecordSource/
814:     * ControlSource para repetir aqui - CarregarMovimentacoes() do BO
815:     * esvazia o cursor com ZAP (nunca fecha/recria o alias), entao o bind da
816:     * Column1.Check1 posto por ConfigurarGrid() sobrevive (regra #41).
817:     *--------------------------------------------------------------------------
818:     PROCEDURE CarregarLista()
819:         LOCAL loc_lSucesso, loc_cCursor
820: 
821:         DO CASE
822:             CASE TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
823:                 *-- Harness: sem conexao, sem SQL. O cursor ja existe (vazio),
824:                 *-- criado por CriarCursorMovimentacoes() em InicializarForm.
825:                 loc_lSucesso = .T.
826: 
827:             CASE TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
828:                 loc_lSucesso = .T.
829: 
830:             OTHERWISE
831:                 loc_lSucesso = THIS.this_oBusinessObject.Buscar()
832:         ENDCASE
833: 
834:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
835:         IF USED(loc_cCursor)
836:             SELECT (loc_cCursor)
837:             GO TOP
838:             THIS.grd_4c_Dados.Refresh()
839:         ENDIF
840: 
841:         RETURN loc_lSucesso
842:     ENDPROC
843: 
844:     *--------------------------------------------------------------------------
845:     * TornarControlesVisiveis - AddObject cria todo controle com
846:     * Visible = .F.; este metodo percorre a arvore e os torna visiveis.
847:     *
848:     * Nao ha lista de excecao aqui: o unico controle de visibilidade
849:     * condicional do legado e o botao Boleto
850:     * (ThisForm.btnBoleto.Visible = Inlist(crSigOpCdc.VenBols, 1, 3), no fim
851:     * do Init), que nasce na Fase 8. O ajuste dele roda DEPOIS desta varredura
852:     * - chamado ao final de InicializarForm -, senao o Visible = .T. forcado
853:     * aqui apagaria a decisao.
854:     *--------------------------------------------------------------------------
855:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
856:         LOCAL loc_nI, loc_oObjeto
857: 
858:         FOR loc_nI = 1 TO par_oContainer.ControlCount
859:             loc_oObjeto = par_oContainer.Controls(loc_nI)
860: 
861:             IF VARTYPE(loc_oObjeto) = "O"
862:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
863:                     loc_oObjeto.Visible = .T.
864:                 ENDIF
865: 
866:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
867:                     THIS.TornarControlesVisiveis(loc_oObjeto)
868:                 ENDIF
869:             ENDIF
870:         ENDFOR
871:     ENDPROC
872: 
873:     *--------------------------------------------------------------------------
874:     * KeyPress - PROCEDURE KeyPress do form legado, transcrito:
875:     *
876:     *   LPARAMETERS nKeyCode, nShiftAltCtrl
877:     *   Do Case
878:     *       Case nKeyCode = -1 && F2
879:     *           NoDefault
880:     *           ThisForm.Imprimir.Click()
881:     *       Case nKeyCode = -2 && F3
882:     *           NoDefault
883:     *           ThisForm.Grade.Click()
884:     *   EndCase
885:     *
886:     * Os codigos -1 (F2) e -2 (F3) sao TRANSCRITOS do dump, nao convertidos:
887:     * sao os codigos que o VFP9 entrega em KeyPress para teclas de funcao, e
888:     * sao os mesmos que os ToolTipText dos botoes anunciam ("[F2] Imprimir",
889:     * "[F3] Grade"). NAO sao os 115/116 da regra CLAUDE.md para F4/F5 em
890:     * TextBox - aqui e o KeyPress do FORM. Mesmo par ja migrado em
891:     * FormSigOpAut.KeyPress, irmao direto deste dialogo.
892:     *
893:     * KeyPreview = .T. (propriedade da classe, vinda do dump) e o que faz a
894:     * tecla chegar aqui ANTES de qualquer controle filho - sem ela a grade
895:     * consumiria F2/F3 e este metodo nunca rodaria.
896:     *
897:     * NODEFAULT antes da chamada, como no legado: impede o VFP de repassar a
898:     * tecla ao controle que tem o foco depois de a acao ter sido disparada.
899:     *
900:     * Nao ha DODEFAULT(): FormBase nao define KeyPress, logo nao ha
901:     * comportamento herdado a encadear (conferido em classes\formbase.prg).
902:     *--------------------------------------------------------------------------
903:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
904:         DO CASE
905:             CASE par_nKeyCode = -1 && F2
906:                 NODEFAULT
907:                 THIS.BtnImprimirClick()
908: 
909:             CASE par_nKeyCode = -2 && F3
910:                 NODEFAULT
911:                 THIS.BtnGradeClick()
912:         ENDCASE
913:     ENDPROC
914: 
915:     *--------------------------------------------------------------------------
916:     * BtnGradeClick - cmd_4c_Grade.Click. Legado (Grade.Click), uma linha:
917:     *
918:     *   Thisform.Grd.Column1.Setfocus
919:     *
920:     * Leva o foco para a coluna do checkbox, que e o que o usuario precisa
921:     * para marcar/desmarcar movimentacoes pelo teclado.
922:     *--------------------------------------------------------------------------
923:     PROCEDURE BtnGradeClick()
924:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
925:             THIS.grd_4c_Dados.Column1.SetFocus()
926:         ENDIF
927:     ENDPROC
928: 
929:     *--------------------------------------------------------------------------
930:     * BtnSairClick - cmd_4c_Sair.Click. Legado (Sair.Click), uma linha:
931:     *
932:     *   ThisForm.Release
933:     *
934:     * O legado NAO exige nada antes de sair (ao contrario do irmao SigOpAut,
935:     * que bloqueia a saida enquanto ha linha nao autenticada): aqui a
936:     * impressao e opcional e o dialogo fecha a qualquer momento. Nao inventar
937:     * validacao de saida que o legado nao tem.
938:     *
939:     * O botao tem Cancel = .T. (do dump), entao o ESC cai neste mesmo
940:     * handler - e, com TitleBar = 0 e ControlBox = .F., este e o UNICO
941:     * caminho de saida da tela.
942:     *
943:     * Guarda de lote: sair no meio da varredura deixaria dialogos filhos
944:     * orfaos e o cursor da grade a meio caminho - o aviso explica em vez de
945:     * ignorar o clique em silencio.
946:     *--------------------------------------------------------------------------
947:     PROCEDURE BtnSairClick()
948:         IF THIS.this_lProcessandoLote
949:             MsgAviso("Aguarde o t" + CHR(233) + "rmino da impress" + CHR(227) + ;
950:                 "o em andamento.", "Aten" + CHR(231) + CHR(227) + "o")
951:         ELSE
952:             THIS.Release()
953:         ENDIF
954:     ENDPROC
955: 
956:     *--------------------------------------------------------------------------
957:     * BtnImprimirClick - cmd_4c_Imprimir.Click. Legado (Imprimir.Click):
958:     *
959:     *   Local lOk / lOk = .f.
960:     *   If Reccount("csPgto") <=0
961:     *       MessageBox("Nao existem observacoes a serem auteticadas",16,"")
962:     *       ThisForm.Sair.Setfocus
963:     *   EndIf
964:     *   Select csPgto
965:     *   Scan
966:     *       If csPgto.marca
967:     *           If (CsPgto.docus = 1)
968:     *               =...cursorquery('SigCdOpe','CrSigCdOpe','dopes',TprMvCab.Dopes)
969:     *               =...CursorQuery('SigOpCdc','CrSigOpCdc','Dopes',TprMvCab.Dopes)
970:     *               DO SigPrIdc with CsPgto.Emps, CsPgto.Dopes, CsPgto.Numes,
971:     *                   CsPgto.valdevs, crSigOpCdc.QtdDocs, .F., .F., .F., .F.,
972:     *                   crSigOpCdc.TpImpDocs, .F., Thisform, ThisForm.pChkImpDoc
973:     *           EndIf
974:     *           If InList(CsPgto.Docus, 3, 4)
975:     *               Do Form SigReIfx With CsPgto.Emps, CsPgto.Dopes,
976:     *                   CsPgto.Numes, CrSigOpCdc.TpImpDocs, ThisForm.pChkImpDoc
977:     *           EndIf
978:     *           Select csPgto
979:     *           Replace csPgto.marca with .f., csPgto.Printed with .t.
980:     *       EndIf
981:     *   EndScan
982:     *
983:     * Quatro pontos em que esta versao NAO e copia literal, cada um medido:
984:     *
985:     * 1. O "lOk" do legado e declarado, zerado e NUNCA LIDO neste Click (so
986:     *    no irmao SigOpAut ele recebe o retorno de Autentica()). Nao se
987:     *    transcreve variavel morta - seria codigo sem efeito.
988:     *
989:     * 2. O aviso de cursor vazio NAO interrompe o fluxo, igual ao legado: o
990:     *    If nao tem Return, so mostra a mensagem e tenta focar o Sair; o
991:     *    laco seguinte nao itera nada num cursor vazio. MESSAGEBOX(...,16,...)
992:     *    -> MsgAviso (MESSAGEBOX e proibido no projeto, e 16 era so o icone).
993:     *
994:     * 3. SCAN trocado por laco explicito por NUMERO DE REGISTRO. O SCAN depende
995:     *    da area de trabalho CORRENTE continuar sendo o cursor da grade de uma
996:     *    iteracao para a outra, e aqui cada iteracao abre um dialogo filho:
997:     *    FormSigOpIbo tem DataSession = 2 mas ENTRA na datasession do chamador
998:     *    de proposito (EntrarDataSessionChamador/RestaurarDataSession) para ler
999:     *    o cursor dele, ou seja PODE deixar outra area selecionada. Com SELECT
1000:     *    + GO explicitos a varredura fica imune a isso. O cursor nasce de
1001:     *    CREATE CURSOR alimentado por ZAP + INSERT, sem DELETE nenhum, entao
1002:     *    RECCOUNT e a contagem real e GO <n> alcanca toda linha (regra
1003:     *    CLAUDE.md "RECCOUNT conta registro excluido" nao morde aqui).
1004:     *
1005:     * 4. O "TprMvCab.Dopes" dos dois cursorquery do legado e um ALIAS QUE NAO
1006:     *    EXISTE (o cursor da consulta do Init chama-se CrTprMvCab) - a
1007:     *    divergencia deliberada e o filtro pelo Dopes da LINHA corrente, e
1008:     *    esta documentada em SigOpIgmBO.ImprimirDocumentoDaLinha, que e quem
1009:     *    faz essa recarga. Pela mesma razao o ramo Docus in (3,4) tambem le o
1010:     *    TpImpDocs recarregado para o Dopes DA LINHA, em vez de depender do
1011:     *    que sobrou em crSigOpCdc de uma iteracao anterior (no legado o valor
1012:     *    lido ali varia com a ORDEM das linhas, o que e artefato de cursor
1013:     *    estagnado, nao regra de negocio).
1014:     *
1015:     * Nao ha TRY em volta do laco, de proposito: cada linha e despachada por
1016:     * ImprimirLinhaCorrente(), que abre dialogo MODAL - Show() de form modal
1017:     * com um CATCH em QUALQUER ponto da pilha faz o erro de runtime do filho
1018:     * saltar para esse CATCH e FECHAR a tela filha (regra CLAUDE.md #29). Os
1019:     * erros continuam reportados: os metodos do BO (ImprimirDocumentoDaLinha,
1020:     * MarcarLinhaComoImpressa) tem TRY/CATCH com MsgErro proprios, e a
1021:     * criacao do dialogo filho e protegida dentro de ImprimirLinhaCorrente.
1022:     *--------------------------------------------------------------------------
1023:     PROCEDURE BtnImprimirClick()
1024:         LOCAL loc_oBO, loc_cCursor, loc_nTotal, loc_nRec
1025: 
1026:         *-- RETURN de guarda ANTES de qualquer TRY (regra CLAUDE.md #1)
1027:         IF THIS.this_lProcessandoLote
1028:             RETURN
1029:         ENDIF
1030: 
1031:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1032:             MsgErro("SigOpIgmBO n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
1033:                 CHR(237) + "vel.", "Erro")
1034:             RETURN
1035:         ENDIF
1036: 
1037:         loc_oBO     = THIS.this_oBusinessObject
1038:         loc_cCursor = loc_oBO.this_cCursorGrade
1039: 
1040:         *-- Legado: If Reccount("csPgto") <= 0 -> aviso + foco no Sair, SEM
1041:         *-- interromper (o laco abaixo simplesmente nao itera). O retorno e
1042:         *-- deliberadamente IGNORADO aqui, igual ao legado
1043:         THIS.ValidarLoteImpressao("Impress" + CHR(227) + "o")
1044: 
1045:         IF USED(loc_cCursor)
1046:             THIS.this_lProcessandoLote = .T.
1047:             THIS.AjustarBotoesPorModo()
1048: 
1049:             loc_nTotal = RECCOUNT(loc_cCursor)
1050: 
1051:             FOR loc_nRec = 1 TO loc_nTotal
1052:                 *-- Reposiciona a CADA volta: o dialogo filho da iteracao
1053:                 *-- anterior pode ter trocado a area de trabalho corrente
1054:                 SELECT (loc_cCursor)
1055:                 GO loc_nRec
1056: 
1057:                 *-- Legado: "If csPgto.marca" - so a linha MARCADA imprime.
1058:                 *-- CarregarDoCursor NAO move o ponteiro (so SELECT + leitura
1059:                 *-- dos campos), por isso pode ser chamado dentro do laco.
1060:                 IF loc_oBO.CarregarDoCursor(loc_cCursor) AND loc_oBO.this_lLinhaMarca
1061:                     THIS.ImprimirLinhaCorrente()
1062:                 ENDIF
1063:             ENDFOR

*-- Linhas 1081 a 1179:
1081:     *
1082:     * Esta separado de BtnImprimirClick por causa da regra CLAUDE.md #29: o
1083:     * ramo Docus in (3,4) abre um dialogo MODAL, e o Show() dele nao pode
1084:     * ter CATCH algum na pilha. Aqui o TRY cobre SO o CREATEOBJECT e o
1085:     * Show() fica FORA dele - padrao canonico de Formepd.BtnOperacaoClick.
1086:     *
1087:     * Os dois ramos do legado NAO sao exclusivos por construcao, sao
1088:     * exclusivos pelos DADOS: a consulta do Init filtra "b.Docus in(1,3,4)",
1089:     * e Docus e uma coluna so. Por isso ficam como dois IF independentes,
1090:     * como no legado, e nao como DO CASE.
1091:     *
1092:     * Docus = 1  -> documento de caixa (DO SigPrIdc), no BO
1093:     * Docus 3/4  -> Formsigreifx (o "Do Form SigReIfx" legado)
1094:     *
1095:     * O Replace final do legado ("csPgto.marca with .f., csPgto.Printed with
1096:     * .t.") roda SEMPRE que a linha estava marcada, inclusive quando nenhum
1097:     * dos dois ramos imprimiu - e MarcarLinhaComoImpressa() que o reproduz,
1098:     * fazendo o SELECT do cursor antes do REPLACE, exatamente como o
1099:     * "Select csPgto" que o legado tem ali.
1100:     *--------------------------------------------------------------------------
1101:     PROCEDURE ImprimirLinhaCorrente()
1102:         LOCAL loc_oBO, loc_oFormIfx, loc_oErro
1103: 
1104:         loc_oBO      = THIS.this_oBusinessObject
1105:         loc_oFormIfx = .NULL.
1106: 
1107:         *-- Legado: If (CsPgto.docus = 1) -> DO SigPrIdc with ...
1108:         *-- O BO recarrega SigCdOpe/SigOpCdc pelo Dopes desta linha (os dois
1109:         *-- cursorquery do legado) e tem TRY/CATCH + MsgErro proprios.
1110:         IF loc_oBO.this_nLinhaDocus = 1
1111:             loc_oBO.ImprimirDocumentoDaLinha(THIS)
1112:         ENDIF
1113: 
1114:         *-- Legado: If InList(CsPgto.Docus, 3, 4) -> Do Form SigReIfx With ...
1115:         IF INLIST(loc_oBO.this_nLinhaDocus, 3, 4)
1116:             *-- crSigOpCdc.TpImpDocs do legado: recarregado para o Dopes DESTA
1117:             *-- linha (ver ponto 4 do cabecalho de BtnImprimirClick)
1118:             loc_oBO.CarregarConfiguracaoOperacao(loc_oBO.this_cLinhaDopes)
1119: 
1120:             *-- CREATEOBJECT, NUNCA "DO FORM": no projeto novo os forms sao
1121:             *-- DEFINE CLASS em .prg e nao existe SigReIfx.scx - o DO FORM
1122:             *-- transcrito do legado estouraria "File 'sigreifx.scx' does not
1123:             *-- exist" e o dialogo nunca abriria. Os cinco argumentos estao na
1124:             *-- MESMA ordem do Init de Formsigreifx
1125:             *-- (par_cEmp, par_cDop, par_nNum, par_nImp, par_lChkImpDoc).
1126:             TRY
1127:                 loc_oFormIfx = CREATEOBJECT("Formsigreifx", ;
1128:                     loc_oBO.this_cLinhaEmps, ;
1129:                     loc_oBO.this_cLinhaDopes, ;
1130:                     loc_oBO.this_nLinhaNumes, ;
1131:                     loc_oBO.this_nTpImpDocs, ;
1132:                     THIS.this_lChkImpDoc)
1133:             CATCH TO loc_oErro
1134:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a impress" + ;
1135:                     CHR(227) + "o fiscal da movimenta" + CHR(231) + CHR(227) + "o " + ;
1136:                     ALLTRIM(loc_oBO.this_cLinhaObs) + ":" + CHR(13) + ;
1137:                     loc_oErro.Message + CHR(13) + ;
1138:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1139:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Imprimir")
1140:                 loc_oFormIfx = .NULL.
1141:             ENDTRY
1142: 
1143:             *-- Show() FORA do TRY (regra CLAUDE.md #29). VARTYPE tambem cobre
1144:             *-- o caso legitimo em que Formsigreifx se auto-executa e o Init
1145:             *-- devolve .F. de proposito (o relatorio ja saiu, nao ha tela)
1146:             IF VARTYPE(loc_oFormIfx) = "O"
1147:                 loc_oFormIfx.Show()
1148:             ENDIF
1149:         ENDIF
1150: 
1151:         *-- Legado: Select csPgto / Replace csPgto.marca with .f.,
1152:         *--         csPgto.Printed with .t.
1153:         loc_oBO.MarcarLinhaComoImpressa()
1154:     ENDPROC
1155: 
1156:     *--------------------------------------------------------------------------
1157:     * BtnBoletoClick - cmd_4c_BtnBoleto.Click. Legado (btnBoleto.Click):
1158:     *
1159:     *   Local lOk, lnTpB / lOk = .f.
1160:     *   If Reccount("csPgto") <=0
1161:     *       MessageBox("Nao existem observacoes a serem auteticadas",16,"")
1162:     *       ThisForm.Sair.Setfocus
1163:     *   EndIf
1164:     *   Select csPgto
1165:     *   Scan
1166:     *       lnTpB = 0
1167:     *       =...CursorQuery('SigOpCdc','crSigOpCdc','Dopes',ThisForm.Movimentacao)
1168:     *       Do Case ... EndCase            && resolve lnTpB
1169:     *       If (lnTpB > 0)
1170:     *           Do Form SigOpIbo With Thisform.Parentform, lnTpB,, csPgto.Emps,
1171:     *               csPgto.Dopes, csPgto.Numes, 0, crSigOpCdc.qvias,
1172:     *               crSigOpCdc.qtdbols
1173:     *       EndIf
1174:     *   EndScan
1175:     *
1176:     * Tres diferencas em relacao ao Imprimir, TODAS fieis ao legado e todas
1177:     * faceis de "corrigir" por engano:
1178:     *
1179:     * 1. NAO ha "If csPgto.marca": o laco do boleto percorre TODAS as linhas,

*-- Linhas 1194 a 1237:
1194:     * Laco por numero de registro e ausencia de TRY em volta dele: mesmos
1195:     * motivos dos pontos 3 e 4 do cabecalho de BtnImprimirClick.
1196:     *--------------------------------------------------------------------------
1197:     PROCEDURE BtnBoletoClick()
1198:         LOCAL loc_oBO, loc_cCursor, loc_nTotal, loc_nRec
1199: 
1200:         *-- RETURN de guarda ANTES de qualquer TRY (regra CLAUDE.md #1)
1201:         IF THIS.this_lProcessandoLote
1202:             RETURN
1203:         ENDIF
1204: 
1205:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1206:             MsgErro("SigOpIgmBO n" + CHR(227) + "o est" + CHR(225) + " dispon" + ;
1207:                 CHR(237) + "vel.", "Erro")
1208:             RETURN
1209:         ENDIF
1210: 
1211:         loc_oBO     = THIS.this_oBusinessObject
1212:         loc_cCursor = loc_oBO.this_cCursorGrade
1213: 
1214:         *-- Legado: mesmo aviso do Imprimir, tambem SEM interromper o fluxo
1215:         THIS.ValidarLoteImpressao("Boleto")
1216: 
1217:         IF USED(loc_cCursor)
1218:             THIS.this_lProcessandoLote = .T.
1219:             THIS.AjustarBotoesPorModo()
1220: 
1221:             loc_nTotal = RECCOUNT(loc_cCursor)
1222: 
1223:             FOR loc_nRec = 1 TO loc_nTotal
1224:                 SELECT (loc_cCursor)
1225:                 GO loc_nRec
1226: 
1227:                 *-- Sem "If csPgto.marca" (ponto 1 do cabecalho)
1228:                 IF loc_oBO.CarregarDoCursor(loc_cCursor)
1229:                     THIS.EmitirBoletoLinhaCorrente()
1230:                 ENDIF
1231:             ENDFOR
1232: 
1233:             THIS.this_lProcessandoLote = .F.
1234:             THIS.AjustarBotoesPorModo()
1235: 
1236:             SELECT (loc_cCursor)
1237:             GO TOP

*-- Linhas 1248 a 1679:
1248:     * Separado de BtnBoletoClick pelo mesmo motivo de
1249:     * ImprimirLinhaCorrente: FormSigOpIbo e MODAL, e o Show() de form modal
1250:     * nao pode ter CATCH na pilha (regra CLAUDE.md #29). TRY cobre so o
1251:     * CREATEOBJECT.
1252:     *
1253:     * Argumentos, na ordem do Init de FormSigOpIbo (par_oFormChamador,
1254:     * par_nTpBol, par_cTitEnvelope, par_cEmp, par_cDope, par_nNum, par_nDev,
1255:     * par_nVias, par_nQBols, par_cCursor):
1256:     *
1257:     *   legado                      | aqui
1258:     *   Thisform.Parentform         | THIS.this_oFormPai
1259:     *   lnTpB                       | loc_nTpBol (ResolverTipoBoleto no BO)
1260:     *   <omitido>                   | "" - SigOpIboBO.DefinirTipoBoleto faz
1261:     *                                 IIF(VARTYPE(x) = "C", x, ""), logo ""
1262:     *                                 e EXATAMENTE o que o parametro ausente
1263:     *                                 produz; "" evita depender de omissao
1264:     *                                 posicional em CREATEOBJECT
1265:     *   csPgto.Emps/.Dopes/.Numes   | this_cLinhaEmps/.._cLinhaDopes/.._nLinhaNumes
1266:     *   0                           | 0 (pnDev)
1267:     *   crSigOpCdc.qvias/.qtdbols   | this_nQvias / this_nQtdBols
1268:     *   <nao passado: pCursor>      | nao passado (o legado para no 9o)
1269:     *
1270:     * this_oFormPai pode ser .NULL. (dialogo instanciado sem form pai): o
1271:     * Init de FormSigOpIbo ja guarda com PCOUNT() + VARTYPE(...) = "O" e
1272:     * ignora, sem erro.
1273:     *--------------------------------------------------------------------------
1274:     PROCEDURE EmitirBoletoLinhaCorrente()
1275:         LOCAL loc_oBO, loc_nTpBol, loc_oFormIbo, loc_oErro
1276: 
1277:         loc_oBO      = THIS.this_oBusinessObject
1278:         loc_oFormIbo = .NULL.
1279: 
1280:         *-- Legado, dentro do Scan: lnTpB = 0 + CursorQuery('SigOpCdc', ...,
1281:         *-- ThisForm.Movimentacao) - a operacao de ORIGEM, nao a da linha
1282:         *-- (ponto 3 do cabecalho de BtnBoletoClick)
1283:         loc_oBO.CarregarConfiguracaoOperacao(THIS.this_cMovimentacao)
1284: 
1285:         *-- Do Case INTEIRO do legado, transcrito no BO
1286:         loc_nTpBol = loc_oBO.ResolverTipoBoleto()
1287: 
1288:         *-- Legado: If (lnTpB > 0)
1289:         IF loc_nTpBol > 0
1290:             TRY
1291:                 loc_oFormIbo = CREATEOBJECT("FormSigOpIbo", ;
1292:                     THIS.this_oFormPai, ;
1293:                     loc_nTpBol, ;
1294:                     "", ;
1295:                     loc_oBO.this_cLinhaEmps, ;
1296:                     loc_oBO.this_cLinhaDopes, ;
1297:                     loc_oBO.this_nLinhaNumes, ;
1298:                     0, ;
1299:                     loc_oBO.this_nQvias, ;
1300:                     loc_oBO.this_nQtdBols)
1301:             CATCH TO loc_oErro
1302:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir o boleto da movimenta" + ;
1303:                     CHR(231) + CHR(227) + "o " + ALLTRIM(loc_oBO.this_cLinhaObs) + ":" + CHR(13) + ;
1304:                     loc_oErro.Message + CHR(13) + ;
1305:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1306:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Emitir Boleto")
1307:                 loc_oFormIbo = .NULL.
1308:             ENDTRY
1309: 
1310:             *-- Show() FORA do TRY (regra CLAUDE.md #29)
1311:             IF VARTYPE(loc_oFormIbo) = "O"
1312:                 loc_oFormIbo.Show()
1313:             ENDIF
1314:         ENDIF
1315:     ENDPROC
1316: 
1317:     *--------------------------------------------------------------------------
1318:     * FormParaBO - FUNIL unico Tela -> Business Object.
1319:     *
1320:     * Este dialogo NAO tem campo digitavel fora da grade: o dump legado tem
1321:     * cntSombra (dois labels), a grade e quatro botoes, e nada mais. O que a
1322:     * tela tem para entregar ao BO sao os CINCO dados que o Init legado
1323:     * recebe por parametro e guarda em properties do form:
1324:     *
1325:     *   legado                  | aqui                | vai para o BO como
1326:     *   _pEmps                  | this_cEmps          | this_cEmps
1327:     *   _pDopes (Movimentacao)  | this_cMovimentacao  | this_cDopes
1328:     *   _pNumes                 | this_nNumes         | this_nNumes
1329:     *   _pChkImpDoc             | this_lChkImpDoc     | this_lChkImpDoc
1330:     *   _pBol (Boleto)          | this_nBoleto        | this_nBoleto
1331:     *
1332:     * O BO monta internamente lcEDN = Emps + Dopes + Str(Numes, 6), a chave
1333:     * POSICIONAL de 29 chars (3 + 20 + 6) usada no WHERE da carga - por isso
1334:     * os valores seguem com o padding da coluna, sem ALLTRIM (regra
1335:     * CLAUDE.md #42).
1336:     *
1337:     * poform NAO vai para o BO: fica no form (this_oFormPai), que e quem
1338:     * abre os dialogos filhos e devolve o foco no Destroy.
1339:     *
1340:     * As tres colunas da grade NAO passam por aqui - elas se ligam ao cursor
1341:     * por ControlSource, e a leitura da LINHA corrente para o BO e
1342:     * SigOpIgmBO.CarregarDoCursor(), chamado dentro dos lacos de
1343:     * BtnImprimirClick/BtnBoletoClick a cada volta.
1344:     *
1345:     * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE FormParaBO"
1346:     * e o VFP9 NAO deixa a subclasse ALARGAR o escopo herdado - escrever
1347:     * "PROCEDURE FormParaBO" aqui deixaria o metodo protegido do mesmo jeito
1348:     * e mentiria para quem le.
1349:     *--------------------------------------------------------------------------
1350:     PROTECTED PROCEDURE FormParaBO()
1351:         LOCAL loc_lOk, loc_oBO, loc_oErro
1352:         loc_lOk = .F.
1353: 
1354:         TRY
1355:             loc_oBO = THIS.this_oBusinessObject
1356: 
1357:             IF VARTYPE(loc_oBO) = "O"
1358:                 loc_oBO.DefinirParametros( ;
1359:                     THIS.this_cEmps, ;
1360:                     THIS.this_cMovimentacao, ;
1361:                     THIS.this_nNumes, ;
1362:                     THIS.this_lChkImpDoc, ;
1363:                     THIS.this_nBoleto)
1364: 
1365:                 loc_lOk = .T.
1366:             ENDIF
1367:         CATCH TO loc_oErro
1368:             MsgErro(loc_oErro.Message + CHR(13) + ;
1369:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1370:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpIgm.FormParaBO")
1371:             loc_lOk = .F.
1372:         ENDTRY
1373: 
1374:         RETURN loc_lOk
1375:     ENDPROC
1376: 
1377:     *--------------------------------------------------------------------------
1378:     * BOParaForm - FUNIL unico Business Object -> Tela, sentido inverso.
1379:     *
1380:     * Reune o que a tela EXIBE a partir de decisao do BO:
1381:     *
1382:     *   1. Visibilidade do botao Boleto - a ULTIMA linha do Init legado
1383:     *      (ThisForm.btnBoleto.Visible = Inlist(crSigOpCdc.VenBols, 1, 3)),
1384:     *      delegada a AjustarVisibilidadeBoleto()/DeveExibirBotaoBoleto().
1385:     *   2. Estado dos botoes de acao (AjustarBotoesPorModo).
1386:     *   3. Repintar a grade: popular/alterar cursor NAO repinta sozinho
1387:     *      (regra CLAUDE.md #21).
1388:     *
1389:     * As linhas da grade NAO sao reescritas a partir das properties
1390:     * this_*Linha* do BO: elas sao uma FOTO da linha corrente (leitura), e
1391:     * quem desenha as linhas e o ControlSource de cada Column ligado ao
1392:     * proprio cursor. Reescrever o cursor a partir da foto sobrescreveria
1393:     * as outras linhas com a corrente.
1394:     *
1395:     * Tem de rodar DEPOIS de TornarControlesVisiveis() - a varredura forca
1396:     * Visible = .T. em TODO controle e apagaria o item 1.
1397:     *
1398:     * PROTECTED EXPLICITO pela mesma razao de FormParaBO acima.
1399:     *--------------------------------------------------------------------------
1400:     PROTECTED PROCEDURE BOParaForm()
1401:         LOCAL loc_lOk, loc_oBO, loc_cCursor, loc_oErro
1402:         loc_lOk = .F.
1403: 
1404:         TRY
1405:             loc_oBO = THIS.this_oBusinessObject
1406: 
1407:             IF VARTYPE(loc_oBO) = "O"
1408:                 THIS.AjustarVisibilidadeBoleto()
1409:                 THIS.AjustarBotoesPorModo()
1410: 
1411:                 loc_cCursor = loc_oBO.this_cCursorGrade
1412:                 IF USED(loc_cCursor) AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
1413:                     SELECT (loc_cCursor)
1414:                     THIS.grd_4c_Dados.Refresh()
1415:                 ENDIF
1416: 
1417:                 loc_lOk = .T.
1418:             ENDIF
1419:         CATCH TO loc_oErro
1420:             MsgErro(loc_oErro.Message + CHR(13) + ;
1421:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1422:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpIgm.BOParaForm")
1423:             loc_lOk = .F.
1424:         ENDTRY
1425: 
1426:         RETURN loc_lOk
1427:     ENDPROC
1428: 
1429:     *--------------------------------------------------------------------------
1430:     * AjustarBotoesPorModo - reflete na tela a guarda this_lProcessandoLote.
1431:     *
1432:     * Este dialogo NAO tem modo de edicao (nao ha INCLUIR/ALTERAR/
1433:     * VISUALIZAR/EXCLUIR: nao grava registro nenhum, nao tem Page2 de Dados
1434:     * e nao tem botao CRUD). O unico "modo" que existe e o que o legado
1435:     * tambem tem na pratica: lote de impressao em andamento ou nao.
1436:     *
1437:     * No legado o laco e os dialogos filhos vivem na mesma pilha BLOQUEADA
1438:     * do SCX modal, entao nao ha como clicar nada durante o lote. Aqui a
1439:     * guarda this_lProcessandoLote (ver a declaracao dela) ja impedia a
1440:     * reentrancia por F2/F3; este metodo so a torna VISIVEL, desabilitando
1441:     * os tres botoes de acao - nao e comportamento novo, e a mesma decisao.
1442:     *
1443:     * Os tres botoes nascem com Themes = .T. + DisabledPicture apontando
1444:     * para a MESMA imagem (ver ConfigurarBotoes): standalone CommandButton
1445:     * com Picture nao desenha o icone com Themes = .F. quando fica
1446:     * Enabled = .F. Nenhum deles e icone-only (todos tem Caption), que e o
1447:     * caso em que Enabled = .F. apagaria o icone de qualquer jeito.
1448:     *
1449:     * Sair fica SEMPRE habilitado: com TitleBar = 0 e ControlBox = .F. ele e
1450:     * a UNICA saida da tela, e quem recusa a saida no meio do lote e o
1451:     * proprio BtnSairClick, com aviso - desabilitar o botao deixaria o
1452:     * usuario sem explicacao nenhuma.
1453:     *
1454:     * Visible NAO e tocado aqui: a do botao Boleto e decidida por
1455:     * AjustarVisibilidadeBoleto() a partir do VenBols da Operacao.
1456:     *
1457:     * PUBLIC (sem PROTECTED) porque o harness de teste automatizado chama
1458:     * AjustarBotoesPorModo direto no objeto do form, de FORA da classe -
1459:     * PEMSTATUS(oForm, "Metodo", 5) responde "existe?", nao "da para chamar
1460:     * daqui?", entao PROTECTED falharia em runtime (regra CLAUDE.md #3).
1461:     *--------------------------------------------------------------------------
1462:     PROCEDURE AjustarBotoesPorModo()
1463:         LOCAL loc_lLiberado
1464: 
1465:         loc_lLiberado = !THIS.this_lProcessandoLote
1466: 
1467:         IF PEMSTATUS(THIS, "cmd_4c_BtnBoleto", 5)
1468:             THIS.cmd_4c_BtnBoleto.Enabled = loc_lLiberado
1469:         ENDIF
1470: 
1471:         IF PEMSTATUS(THIS, "cmd_4c_Imprimir", 5)
1472:             THIS.cmd_4c_Imprimir.Enabled = loc_lLiberado
1473:         ENDIF
1474: 
1475:         IF PEMSTATUS(THIS, "cmd_4c_Grade", 5)
1476:             THIS.cmd_4c_Grade.Enabled = loc_lLiberado
1477:         ENDIF
1478: 
1479:         *-- Sair permanece habilitado de proposito (ver cabecalho)
1480:         THIS.HabilitarCampos(loc_lLiberado)
1481: 
1482:         RETURN .T.
1483:     ENDPROC
1484: 
1485:     *--------------------------------------------------------------------------
1486:     * HabilitarCampos - o unico "campo" editavel deste dialogo e a coluna 1
1487:     * da grade (o checkbox de marcacao); as colunas 2 e 3 nascem
1488:     * ReadOnly = .T., reproduzindo o "Return .f." do When dos dois Text1 do
1489:     * legado, e nao ha controle de entrada fora da grade.
1490:     *
1491:     * Com o lote em andamento a coluna e travada: marcar/desmarcar linha no
1492:     * meio da varredura mudaria, por baixo do laco, o que ainda falta
1493:     * imprimir.
1494:     *
1495:     * Column.ReadOnly e definido DEPOIS de Grid.ReadOnly (que este form nunca
1496:     * altera, ficando no default .F.) - a ordem inversa faria o valor do
1497:     * grid propagar e sobrescrever o da coluna.
1498:     *
1499:     * PUBLIC pelo mesmo motivo de AjustarBotoesPorModo.
1500:     *--------------------------------------------------------------------------
1501:     PROCEDURE HabilitarCampos(par_lHabilitar)
1502:         LOCAL loc_lHabilitar
1503: 
1504:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1505: 
1506:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1507:             THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lHabilitar
1508:         ENDIF
1509: 
1510:         RETURN .T.
1511:     ENDPROC
1512: 
1513:     *--------------------------------------------------------------------------
1514:     * ValidarLoteImpressao - FONTE UNICA do aviso de grade vazia.
1515:     *
1516:     * Legado, as duas primeiras linhas de Imprimir.Click E de
1517:     * btnBoleto.Click (texto identico nos dois):
1518:     *
1519:     *   If Reccount("csPgto") <=0
1520:     *       MessageBox("Nao existem observacoes a serem auteticadas",16,"")
1521:     *       ThisForm.Sair.Setfocus
1522:     *   EndIf
1523:     *
1524:     * O criterio e a mensagem moram em SigOpIgmBO.ValidarDados (inclusive a
1525:     * grafia "auteticadas", que e a do original - trocar texto de mensagem
1526:     * seria desvio do PILAR 1); aqui fica o que e de TELA: exibir o aviso e
1527:     * mover o foco para o botao Sair.
1528:     *
1529:     * O legado NAO interrompe o fluxo neste If - nao ha Return - e os dois
1530:     * handlers continuam ignorando este retorno de proposito: num cursor
1531:     * vazio o laco seguinte simplesmente nao itera. O retorno existe para
1532:     * quem precise da resposta sem o efeito colateral de ja ter comecado o
1533:     * lote.
1534:     *
1535:     * MsgAviso no lugar do MESSAGEBOX(..., 16, ...): MESSAGEBOX e proibido no
1536:     * projeto e o 16 era so o icone.
1537:     *--------------------------------------------------------------------------
1538:     FUNCTION ValidarLoteImpressao(par_cTitulo)
1539:         LOCAL loc_lValido, loc_cTitulo, loc_cMensagem
1540: 
1541:         loc_lValido = .F.
1542:         loc_cTitulo = IIF(VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo), ;
1543:             par_cTitulo, "Impress" + CHR(227) + "o")
1544: 
1545:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1546:             loc_lValido = THIS.this_oBusinessObject.ValidarDados()
1547: 
1548:             IF !loc_lValido
1549:                 loc_cMensagem = THIS.this_oBusinessObject.this_cMensagemErro
1550: 
1551:                 IF VARTYPE(loc_cMensagem) != "C" OR EMPTY(loc_cMensagem)
1552:                     loc_cMensagem = "N" + CHR(227) + "o existem observa" + CHR(231) + ;
1553:                         CHR(245) + "es a serem auteticadas"
1554:                 ENDIF
1555: 
1556:                 MsgAviso(loc_cMensagem, loc_cTitulo)
1557: 
1558:                 *-- Legado: ThisForm.Sair.Setfocus
1559:                 IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
1560:                     THIS.cmd_4c_Sair.SetFocus()
1561:                 ENDIF
1562:             ENDIF
1563:         ENDIF
1564: 
1565:         RETURN loc_lValido
1566:     ENDFUNC
1567: 
1568:     *--------------------------------------------------------------------------
1569:     * ChkMarcaKeyPress - o Click do checkbox da coluna 1, transcrito:
1570:     *
1571:     *   PROCEDURE Click            && SIGOPIGM.Grd.Column1.Check1
1572:     *   if !(csPgto.printed)
1573:     *       This.value = .t.
1574:     *   endif
1575:     *
1576:     * Semantica do legado, lida com o toggle NATIVO que roda ANTES do Click:
1577:     *   linha NAO impressa -> qualquer clique resulta em MARCADA (o force
1578:     *                         .t. desfaz o desmarcar);
1579:     *   linha JA impressa   -> alterna normalmente, e e assim que o usuario
1580:     *                         reimprime uma movimentacao (MarcarLinhaComoImpressa
1581:     *                         deixa Marca = .F. e Printed = .T.).
1582:     * Daqui a expressao IIF(!Printed, .T., !Marca), que produz exatamente a
1583:     * mesma tabela sem depender do toggle nativo.
1584:     *
1585:     * CheckBox posto em Column por AddObject NAO alterna pelo binding
1586:     * nativo: a celula renderiza o quadradinho, recebe foco e o clique nao
1587:     * muda nada. Por isso o quarteto canonico - MouseDown/Click suprimem o
1588:     * toggle padrao (NODEFAULT, evitando alternancia DUPLA), MouseUp
1589:     * redireciona para ca e este metodo e o unico que escreve no cursor.
1590:     *
1591:     * Marca e LOGICA (csPgto.Marca L no Create Cursor legado), nao numerica:
1592:     * por isso !Marca e nao IIF(Marca = 0, 1, 0).
1593:     *
1594:     * O REPLACE funciona porque o cursor nasce de CREATE CURSOR (READWRITE);
1595:     * cursor de SQLEXEC direto seria somente-leitura e a celula nunca
1596:     * entraria em edicao.
1597:     *
1598:     * Guarda de lote: durante a varredura a marcacao fica travada tambem por
1599:     * HabilitarCampos(.F.) - esta checagem cobre o caminho do TECLADO, que o
1600:     * ReadOnly da coluna nao impede quando a celula ja esta com o foco.
1601:     *--------------------------------------------------------------------------
1602:     PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1603:         LOCAL loc_cCursor
1604: 
1605:         IF INLIST(par_nKeyCode, 13, 32)
1606:             IF !THIS.this_lProcessandoLote AND VARTYPE(THIS.this_oBusinessObject) = "O"
1607:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
1608: 
1609:                 IF USED(loc_cCursor)
1610:                     SELECT (loc_cCursor)
1611: 
1612:                     IF RECCOUNT() > 0 AND !EOF()
1613:                         REPLACE Marca WITH IIF(!Printed, .T., !Marca)
1614:                         THIS.grd_4c_Dados.Refresh()
1615:                     ENDIF
1616:                 ENDIF
1617:             ENDIF
1618: 
1619:             NODEFAULT
1620:         ENDIF
1621:     ENDPROC
1622: 
1623:     *--------------------------------------------------------------------------
1624:     * ChkMarcaMouseUp - converte o clique do mouse na mesma acao do teclado,
1625:     * para haver UM so lugar que escreve no cursor. NODEFAULT suprime o
1626:     * toggle nativo que viria depois.
1627:     *--------------------------------------------------------------------------
1628:     PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1629:         THIS.ChkMarcaKeyPress(13, 0)
1630:         NODEFAULT
1631:     ENDPROC
1632: 
1633:     *--------------------------------------------------------------------------
1634:     * ChkMarcaMouseDown - existe SO para suprimir o toggle nativo; sem ele o
1635:     * valor alternaria duas vezes (uma pelo VFP, outra pelo MouseUp acima) e
1636:     * a marcacao pareceria nao responder ao clique.
1637:     *--------------------------------------------------------------------------
1638:     PROCEDURE ChkMarcaMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1639:         NODEFAULT
1640:     ENDPROC
1641: 
1642:     *--------------------------------------------------------------------------
1643:     * ChkMarcaClick - mesma funcao do MouseDown acima: suprimir o toggle
1644:     * padrao. A acao do legado esta em ChkMarcaKeyPress, chamado pelo
1645:     * MouseUp.
1646:     *--------------------------------------------------------------------------
1647:     PROCEDURE ChkMarcaClick()
1648:         NODEFAULT
1649:     ENDPROC
1650: 
1651:     *--------------------------------------------------------------------------
1652:     * Destroy - devolve o foco ao form chamador e encadeia para
1653:     * FormBase.Destroy(), que libera this_oBusinessObject (e e o BO quem
1654:     * fecha os cursores que abriu) e restaura o menu principal.
1655:     *
1656:     * this_oFormPai e this_oModem NAO sao liberados aqui: pertencem a quem os
1657:     * criou. Apenas as referencias deste form sao soltas.
1658:     *
1659:     * DODEFAULT() na ULTIMA linha e obrigatorio - sem ele FormBase.Destroy()
1660:     * nao roda e os popups do menu principal ficam com o cache visual velho.
1661:     *--------------------------------------------------------------------------
1662:     PROCEDURE Destroy()
1663:         LOCAL loc_oErro
1664: 
1665:         TRY
1666:             IF VARTYPE(THIS.this_oFormPai) = "O"
1667:                 THIS.this_oFormPai.Enabled = .T.
1668:             ENDIF
1669:         CATCH TO loc_oErro
1670:             MsgErro(loc_oErro.Message, "Erro ao encerrar FormSigOpIgm")
1671:         ENDTRY
1672: 
1673:         THIS.this_oModem = .NULL.
1674:         THIS.this_oFormPai = .NULL.
1675: 
1676:         DODEFAULT()
1677:     ENDPROC
1678: 
1679: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpIgmBO.prg):
*==============================================================================
* SIGOPIGMBO.prg
*
* Business Object para SIGOPIGM (Impressao Global de Movimentacoes)
*
* Este form NAO persiste dados em tabela propria - e um dialogo OPERACIONAL
* chamado por outro form (poform) para autenticar/imprimir em lote um
* conjunto de movimentacoes de uma mesma Operacao (Dopes) que ainda nao
* foram impressas. O legado monta a chave composta
* EmpDnCrds = Emps + Dopes + Str(Numes,6) a partir dos parametros recebidos
* e consulta SigMvCab/SigCdOpe/SigOpCdc para popular um cursor local
* (csPgto) com uma linha por movimentacao a autenticar - o usuario marca
* (checkbox) quais quer processar e aciona Imprimir (documentos) ou Boleto
* (impressao de boleto bancario).
*
* Tabela: (nenhuma - dialogo parametrizado, sem persistencia propria;
* csPgto e um CURSOR local criado em memoria, nao uma tabela do SQL Server)
*
* SOMENTE LEITURA - por que Inserir()/Atualizar()/ExecutarExclusao() NAO sao
* sobrescritos aqui: todo acesso remoto do legado e Select. O unico
* "Insert Into" do dump tem por destino csPgto, que e CURSOR LOCAL
* (Create Cursor no Load), e o unico Replace tambem (csPgto.marca /
* csPgto.Printed). Nao ha TableUpdate nem .AddCursor em lugar nenhum do
* dump, isto e, nada volta para o banco. Escrever um INSERT/UPDATE aqui
* significaria INVENTAR a lista de colunas, o que a regra #22 do CLAUDE.md
* proibe (a lista vem do schema, nunca de adivinhacao). O comportamento
* padrao herdado de BusinessBase (recusar a operacao e reportar pelo
* ExibirFalha do Salvar) ja e o correto.
*
* Parametros recebidos do form chamador (Init legado: Parameters poform,
* _pEmps, _pDopes, _pNumes, _pChkImpDoc, _pBol), espelhados nas properties
* abaixo:
*   - this_cEmps           : _pEmps  - Codigo da Empresa
*   - this_cDopes          : _pDopes - Codigo da Operacao (= property
*     "movimentacao" do form legado, que recebe o MESMO valor de _pDopes)
*   - this_nNumes          : _pNumes - Numero da Movimentacao de origem
*   - this_lChkImpDoc      : _pChkImpDoc - repassado para SigPrIdc/SigReIfx
*     na impressao de documentos (controla se confirma impressao por doc)
*   - this_nBoleto         : _pBol - Tipo/flag de boleto (Iif(Type=N,
*     valor, 0) no legado - Boleto > 0 troca o Caption do form para
*     "Impressao Global de Boletos")
*
* poForm (referencia ao form chamador) e oModem (ThisForm.Parentform.
* oModemEest, repassado para SigPrIdc) NAO entram neste BO - mesma decisao
* arquitetural de SigOpIboBO.prg/SigOpCtdBO.prg ("ONDE FICA O poForm"):
* guardar referencia a objeto de UI aqui fecharia um ciclo de referencias.
* Ficam no Form, e o unico metodo deste BO que precisa do form
* (ImprimirDocumentoDaLinha, por causa do 12o argumento do SigPrIdc
* legado) recebe a referencia como PARAMETRO.
*
* CHAVE POSICIONAL (regra CLAUDE.md #42) - MontarChaveEmpDnCrds monta
* lcEDN = Emps + Dopes + Str(Numes,6) com PADR EXPLICITO nas partes:
*   SigMvCab.emps      char(3)
*   SigMvCab.dopes     char(20)
*   Str(numes, 6)           6
*   ------------------------------
*   SigMvCab.empdncrds char(29)   <- a soma 3+20+6 = 29 PROVA a montagem
* O padding FAZ PARTE da chave: ALLTRIM em qualquer parte INTERIOR encurta
* a chave, ela nunca casa, o SELECT roda SEM ERRO e devolve ZERO linhas - e
* a grade aparece vazia sem nenhuma mensagem.
*
* Divisao de responsabilidade com o Form (o Form chama, o BO decide):
*   CriarCursorMovimentacoes()      Create Cursor csPgto do Load legado
*   MontarChaveEmpDnCrds()          lcEDN posicional
*   CarregarMovimentacoes()         Select + Scan/Insert do Init legado
*   CarregarConfiguracaoOperacao()  os CursorQuery de SigOpCdc/SigCdOpe/SigOpCdd
*   DeveExibirBotaoBoleto()         Inlist(crSigOpCdc.VenBols, 1, 3)
*   ResolverTipoBoleto()            o Do Case inteiro do btnBoleto.Click
*   CarregarDoCursor()              linha corrente da grade -> properties
*   ContarMarcadas()                quantas linhas o usuario marcou
*   ImprimirDocumentoDaLinha()      Do SigPrIdc with ... (Docus = 1)
*   MarcarLinhaComoImpressa()       Replace marca .F., Printed .T.
* As duas aberturas de form filho do legado (Do Form SigReIfx, quando
* Docus esta em (3,4), e Do Form SigOpIbo, no botao Boleto) ficam no Form,
* que e quem tem a referencia ao form chamador que elas exigem.
*==============================================================================

DEFINE CLASS SigOpIgmBO AS BusinessBase

    *-- Nome do cursor local da grade (csPgto no legado). Property para o
    *-- Form nao repetir string literal.
    this_cCursorGrade = "cursor_4c_Pgto"

    *-- Propriedades da entidade (parametros recebidos do form chamador,
    *-- espelhando as properties customizadas do form legado SIGOPIGM)
    this_cEmps = ""                && _pEmps - Codigo da Empresa
    this_cDopes = ""               && _pDopes - Codigo da Operacao (= "movimentacao" do legado)
    this_nNumes = 0                && _pNumes - Numero da Movimentacao de origem
    this_lChkImpDoc = .F.          && _pChkImpDoc - repassado a SigPrIdc/SigReIfx
    this_nBoleto = 0               && _pBol - Tipo/flag de boleto (Boleto > 0 muda o Caption)

    *-- Derivados de consulta SQL
    this_cChaveEmpDnCrds = ""      && lcEDN - Emps + Dopes + Str(Numes,6) (chave posicional)
    this_lExibirBotaoBoleto = .F.  && Inlist(crSigOpCdc.VenBols, 1, 3)
    this_nQtdMovimentacoes = 0     && Reccount() do cursor da grade apos a carga

    *-- Linha CORRENTE da grade (csPgto), carregada por CarregarDoCursor.
    *-- Nomes com o infixo "Linha" para nao colidir com os parametros acima:
    *-- os parametros sao a movimentacao de ORIGEM (que monta a chave), estas
    *-- sao a movimentacao da linha selecionada (que sera impressa).
    this_lLinhaMarca = .F.         && csPgto.Marca   - checkbox da coluna 1
    this_cLinhaObs = ""            && csPgto.Obs     - Dopes + " " + Str(Numes,6)
    this_lLinhaPrinted = .F.       && csPgto.Printed - linha ja processada
    this_nLinhaValos = 0           && csPgto.Valos
    this_cLinhaEmps = ""           && csPgto.Emps
    this_cLinhaDopes = ""          && csPgto.Dopes
    this_nLinhaNumes = 0           && csPgto.Numes
    this_nLinhaValdevs = 0         && csPgto.Valdevs
    this_nLinhaDocus = 0           && csPgto.Docus - 1 = SigPrIdc, 3 ou 4 = SigReIfx

    *-- Configuracao da Operacao (SigOpCdc), carregada por
    *-- CarregarConfiguracaoOperacao. Todas as colunas sao numeric no schema.
    this_nVenBols = 0              && SigOpCdc.venbols   numeric(1,0)
    this_nQtdDocs = 0              && SigOpCdc.qtddocs   numeric(2,0)
    this_nTpImpDocs = 0            && SigOpCdc.tpimpdocs numeric(1,0)
    this_nBolItes = 0              && SigOpCdc.bolites   numeric(2,0)
    this_nQvias = 0                && SigOpCdc.qvias     numeric(6,0)
    this_nQtdBols = 0              && SigOpCdc.qtdbols   numeric(2,0)

    *-- SigCdOpe.docus da Operacao (o CursorQuery('SigCdOpe', ...) que o
    *-- Imprimir.Click legado faz antes do SigPrIdc)
    this_nDocusOperacao = 0        && SigCdOpe.docus numeric(2,0)

    *-- SigOpCdd.configgers char(250) - o 1o Case do btnBoleto.Click le
    *-- Substr(ConfigGers, 233, 2)
    this_cConfigGers = ""          && SigOpCdd.configgers char(250)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo parametrizado: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.this_cEmps = ""
        THIS.this_cDopes = ""
        THIS.this_nNumes = 0
        THIS.this_lChkImpDoc = .F.
        THIS.this_nBoleto = 0

        THIS.this_cChaveEmpDnCrds = ""
        THIS.this_lExibirBotaoBoleto = .F.
        THIS.this_nQtdMovimentacoes = 0

        THIS.LimparLinha()
        THIS.LimparConfiguracaoOperacao()

        RETURN .T.
    ENDPROC

    *====================================================================
    * DefinirParametros - Recebe os cinco parametros de dados do Init
    * legado, na MESMA ORDEM (Parameters poform, _pEmps, _pDopes, _pNumes,
    * _pChkImpDoc, _pBol - poform fica no Form, ver cabecalho).
    *
    * As guardas de tipo reproduzem o legado: ele so testa o tipo de _pBol
    * (Iif(Type([_pBol])=[N], _pBol, 0)) porque e o unico parametro que o
    * chamador costuma omitir. Aqui todos tem guarda, para o harness de
    * teste poder instanciar o BO sem argumento nenhum.
    *
    * NAO usar ALLTRIM nas partes da chave: elas sao gravadas com o padding
    * das colunas char (ver CHAVE POSICIONAL no cabecalho). O PADR fica em
    * MontarChaveEmpDnCrds, que e quem conhece as larguras do schema.
    *====================================================================
    PROCEDURE DefinirParametros(par_cEmps, par_cDopes, par_nNumes, ;
            par_lChkImpDoc, par_nBol)

        THIS.this_cEmps      = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
        THIS.this_cDopes     = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        THIS.this_nNumes     = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)
        THIS.this_lChkImpDoc = IIF(VARTYPE(par_lChkImpDoc) = "L", par_lChkImpDoc, .F.)
        THIS.this_nBoleto    = IIF(VARTYPE(par_nBol) = "N", par_nBol, 0)

        THIS.this_cChaveEmpDnCrds = THIS.MontarChaveEmpDnCrds(THIS.this_cEmps, ;
            THIS.this_cDopes, THIS.this_nNumes)

        RETURN .T.
    ENDPROC

    *====================================================================
    * MontarChaveEmpDnCrds - lcEDN = _pEmps + _pDopes + Str(_pNumes,6)
    *
    * Legado (Init): lcEDN = _pEmps + _pDopes + Str(_pNumes,6)
    *
    * Chave POSICIONAL (regra CLAUDE.md #42): o padding das colunas char
    * FAZ PARTE da chave, por isso PADR EXPLICITO com a largura do schema
    * em vez de confiar no padding que a variavel por acaso trouxe. A soma
    * 3 + 20 + 6 = 29 e exatamente SigMvCab.empdncrds char(29) - e essa
    * conta que confere a montagem.
    *
    * ALLTRIM em qualquer parte INTERIOR produz uma chave curta que nunca
    * casa: o SELECT roda SEM ERRO e devolve ZERO linhas, a grade fica
    * vazia e nada aparece no log.
    *====================================================================
    PROCEDURE MontarChaveEmpDnCrds(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes

        loc_cEmps  = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        loc_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)

        RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)
    ENDPROC

    *====================================================================
    * CriarCursorMovimentacoes - Create Cursor csPgto do PROCEDURE Load
    * legado, com a MESMA ORDEM e os MESMOS tipos de campo:
    *
    *   Create Cursor csPgto (Marca L, Obs C(27), Printed L, Valos n(12,2),
    *       Emps c(3), Dopes c(20), Numes n(6), Valdevs n(12,2), Docus n(1))
    *
    * A ordem dos campos e a MESMA em todos os lugares que criam o cursor
    * (aqui e so neste metodo), e os nomes sao exatamente os que o Grid usa
    * em ControlSource (csPgto.marca / csPgto.Obs / csPgto.Valos).
    *
    * Obs C(27) = dopes char(20) + 1 espaco + Str(numes,6) = 27 - a largura
    * do campo CONFERE a montagem do texto feita em CarregarMovimentacoes.
    *
    * CREATE CURSOR nasce READWRITE e com Buffering = 1, que e o que a
    * coluna de checkbox da grade precisa para aceitar o REPLACE (o cursor
    * NUNCA vem de SQLEXEC direto, justamente por isso).
    *
    * Idempotente: se o cursor ja existe, apenas esvazia. Recriar fecharia
    * o alias e ZERARIA o ColumnCount do Grid ligado a ele.
    *
    * O ZAP vai cercado de SET SAFETY OFF porque SET SAFETY e ESCOPADO POR
    * DATA SESSION: num form com DataSession = 2 ele vale ON mesmo depois
    * do SET SAFETY OFF do main.prg, e o ZAP abre o dialogo modal
    * "Zap ... Are you sure?" que CONGELA a tela esperando um clique que
    * ninguem ve (num teste headless isso aparece como timeout sem erro).
    *====================================================================
    PROCEDURE CriarCursorMovimentacoes()
        LOCAL loc_lSucesso, loc_oErro, loc_cSafety

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)
                loc_cSafety = SET("SAFETY")
                SET SAFETY OFF
                ZAP
                IF loc_cSafety = "ON"
                    SET SAFETY ON
                ENDIF
            ELSE
                CREATE CURSOR (THIS.this_cCursorGrade) ( ;
                    Marca L, ;
                    Obs C(27), ;
                    Printed L, ;
                    Valos N(12,2), ;
                    Emps C(3), ;
                    Dopes C(20), ;
                    Numes N(6), ;
                    Valdevs N(12,2), ;
                    Docus N(1))
            ENDIF

            loc_lSucesso = USED(THIS.this_cCursorGrade)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel criar o cursor da grade:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarMovimentacoes - Select + Scan/Insert do Init legado
    *
    * Legado (Init):
    *   lcSql = [Select a.Emps, a.Dopes, a.Numes, a.EmpDopNums, a.Valos,
    *            a.ValDevs, b.Docus, c.VenBols ]
    *         + [From SigMvCab a, SigCdOpe b, SigOpCdc c ]
    *         + [Where EmpDnCrds = ']+lcEDN+[' And a.Dopes = b.Dopes
    *            And a.Dopes = c.Dopes And b.Docus in(1,3,4)]
    *   If ...Sqlexecute(lcSql,'CrTprMvCab') > 0
    *       Select CrTprMvCab
    *       Scan
    *           Scatter Memvar
    *           m.Obs   = CrTprMvCab.dopes+' '+Str(CrTprMvCab.Numes,6)
    *           m.Marca = .t.
    *           Printed = .f.
    *           Insert into csPgto from Memvar
    *       EndScan
    *   EndIf
    *   Select csPgto / Go Top / If Reccount() = 0 ... Return .F.
    *
    * EmpDnCrds fica QUALIFICADO com o alias "a" (so SigMvCab tem essa
    * coluna entre as tres tabelas - conferido no schema canonico), o que
    * e a mesma semantica do legado sem depender de resolucao implicita.
    *
    * O Scatter Memvar do legado traz EmpDopNums e VenBols, que csPgto NAO
    * tem - o Insert From Memvar simplesmente os ignora. Aqui as colunas do
    * INSERT sao explicitas, por isso as duas ficam de fora (VenBols e lido
    * de SigOpCdc em CarregarConfiguracaoOperacao, que e de onde a
    * visibilidade do botao Boleto depende de verdade).
    *
    * "Printed = .f." no legado cria uma variavel privada (Scatter Memvar
    * nao a declara, porque CrTprMvCab nao tem essa coluna) que o Insert
    * From Memvar casa pelo nome com o campo Printed de csPgto - ou seja,
    * toda linha nasce NAO impressa. Aqui isso e o literal .F. no INSERT.
    *
    * SQLEXEC vai para cursor TEMPORARIO e o cursor da grade e recarregado
    * com ZAP + INSERT: SQLEXEC sobre o alias ligado ao Grid FECHA e RECRIA
    * o alias, e o Grid cai para ColumnCount = 0 (retangulo branco sem
    * cabecalho, sem erro e sem log).
    *
    * Retorna .F. quando nada foi encontrado - o legado faz
    * "If Reccount() = 0 / ThisForm.Release / Return .F.", isto e, o
    * dialogo nem abre. Quem decide fechar e o Form; aqui so informamos.
    *====================================================================
    PROCEDURE CarregarMovimentacoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        LOCAL loc_cChave, loc_cCursorTmp

        loc_lSucesso   = .F.
        loc_cCursorTmp = "cursor_4c_TprMvCab"
        THIS.this_nQtdMovimentacoes = 0

        TRY
            loc_cChave = THIS.MontarChaveEmpDnCrds(THIS.this_cEmps, ;
                THIS.this_cDopes, THIS.this_nNumes)
            THIS.this_cChaveEmpDnCrds = loc_cChave

            IF !THIS.CriarCursorMovimentacoes()
                THIS.this_cMensagemErro = "Cursor da grade indispon" + CHR(237) + "vel."
            ELSE
                IF USED(loc_cCursorTmp)
                    USE IN (loc_cCursorTmp)
                ENDIF

                loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.EmpDopNums, " + ;
                           "a.Valos, a.ValDevs, b.Docus, c.VenBols " + ;
                           "FROM SigMvCab a, SigCdOpe b, SigOpCdc c " + ;
                           "WHERE a.EmpDnCrds = " + EscaparSQL(loc_cChave) + " " + ;
                           "AND a.Dopes = b.Dopes " + ;
                           "AND a.Dopes = c.Dopes " + ;
                           "AND b.Docus IN (1, 3, 4)"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro("Erro ao buscar as movimenta" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
                ELSE
                    SELECT (loc_cCursorTmp)
                    SCAN
                        INSERT INTO (THIS.this_cCursorGrade) ;
                            (Marca, Obs, Printed, Valos, Emps, Dopes, Numes, Valdevs, Docus) ;
                            VALUES ( ;
                                .T., ;
                                PADR(THIS.LerColunaTexto(loc_cCursorTmp, "Dopes"), 20) + " " + ;
                                    STR(THIS.LerColunaNumerica(loc_cCursorTmp, "Numes"), 6), ;
                                .F., ;
                                THIS.LerColunaNumerica(loc_cCursorTmp, "Valos"), ;
                                THIS.LerColunaTexto(loc_cCursorTmp, "Emps"), ;
                                THIS.LerColunaTexto(loc_cCursorTmp, "Dopes"), ;
                                THIS.LerColunaNumerica(loc_cCursorTmp, "Numes"), ;
                                THIS.LerColunaNumerica(loc_cCursorTmp, "ValDevs"), ;
                                THIS.LerColunaNumerica(loc_cCursorTmp, "Docus"))
                    ENDSCAN

                    IF USED(loc_cCursorTmp)
                        USE IN (loc_cCursorTmp)
                    ENDIF

                    SELECT (THIS.this_cCursorGrade)
                    GO TOP

                    *-- RECCOUNT conta registro marcado para exclusao; aqui o
                    *-- cursor acabou de ser esvaziado com ZAP, entao nao ha
                    *-- nenhum. A contagem usada para decidir "abre ou nao
                    *-- abre" e a mesma do legado (Reccount()).
                    THIS.this_nQtdMovimentacoes = RECCOUNT(THIS.this_cCursorGrade)

                    IF THIS.this_nQtdMovimentacoes = 0
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o existem movimenta" + ;
                            CHR(231) + CHR(245) + "es a serem autenticadas"
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarMovimentacoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarConfiguracaoOperacao - os CursorQuery que o legado faz por
    * Dopes, reunidos num metodo so.
    *
    * Legado (Init):
    *   =...CursorQuery('SigOpCdc','crSigOpCdc','Dopes',ThisForm.Movimentacao)
    * Legado (Imprimir.Click, por linha do Scan):
    *   =...cursorquery('SigCdOpe','CrSigCdOpe','dopes', <Dopes da linha>)
    *   =...CursorQuery('SigOpCdc','CrSigOpCdc','Dopes', <Dopes da linha>)
    * Legado (btnBoleto.Click, por linha do Scan):
    *   =...CursorQuery('SigOpCdc','crSigOpCdc','Dopes',ThisForm.Movimentacao)
    *   + Substr(crSigOpCdd.ConfigGers,233,2)
    *
    * crSigOpCdd NAO e carregado por nenhum CursorQuery do SIGOPIGM - no
    * Fortyus ele vinha pre-aberto pelo form chamador. No sistema novo nada
    * pre-abre cursor global, entao SigOpCdd entra aqui, filtrado pelo
    * MESMO Dopes (regra CLAUDE.md #27: funcao/cursor global do legado que
    * nao existe mais tem de ser reproduzido, nunca ignorado - senao o 1o
    * Case do Do Case do boleto nunca e avaliado e o tipo de boleto sai
    * errado em silencio).
    *
    * Comparacao de char no SQL Server e com blank-padding ANSI, por isso o
    * ALLTRIM aqui e inofensivo - diferente das PARTES de uma chave
    * posicional concatenada (regra #42), que nunca podem ser trimadas.
    *====================================================================
    PROCEDURE CarregarConfiguracaoOperacao(par_cDopes)
        LOCAL loc_lSucesso, loc_cDopes, loc_cSQL, loc_nResultado, loc_oErro
        LOCAL loc_cCurCdc, loc_cCurOpe, loc_cCurCdd

        loc_lSucesso = .F.
        loc_cCurCdc  = "cursor_4c_SigOpCdc"
        loc_cCurOpe  = "cursor_4c_SigCdOpe"
        loc_cCurCdd  = "cursor_4c_SigOpCdd"

        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C" AND !EMPTY(par_cDopes), ;
            par_cDopes, THIS.this_cDopes)

        THIS.LimparConfiguracaoOperacao()

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                    CHR(237) + "vel."
            ELSE
                *-- SigOpCdc: VenBols / QtdDocs / TpImpDocs / BolItes / Qvias / QtdBols
                IF USED(loc_cCurCdc)
                    USE IN (loc_cCurCdc)
                ENDIF
                loc_cSQL = "SELECT * FROM SigOpCdc " + ;
                           "WHERE Dopes = " + EscaparSQL(ALLTRIM(loc_cDopes))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCurCdc)

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro("Erro ao ler a configura" + CHR(231) + CHR(227) + "o da opera" + ;
                        CHR(231) + CHR(227) + "o (SigOpCdc):" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
                ELSE
                    IF RECCOUNT(loc_cCurCdc) > 0
                        SELECT (loc_cCurCdc)
                        GO TOP
                        THIS.this_nVenBols   = THIS.LerColunaNumerica(loc_cCurCdc, "VenBols")
                        THIS.this_nQtdDocs   = THIS.LerColunaNumerica(loc_cCurCdc, "QtdDocs")
                        THIS.this_nTpImpDocs = THIS.LerColunaNumerica(loc_cCurCdc, "TpImpDocs")
                        THIS.this_nBolItes   = THIS.LerColunaNumerica(loc_cCurCdc, "BolItes")
                        THIS.this_nQvias     = THIS.LerColunaNumerica(loc_cCurCdc, "Qvias")
                        THIS.this_nQtdBols   = THIS.LerColunaNumerica(loc_cCurCdc, "QtdBols")
                    ENDIF

                    *-- SigCdOpe: Docus (o cursorquery do Imprimir.Click legado)
                    IF USED(loc_cCurOpe)
                        USE IN (loc_cCurOpe)
                    ENDIF
                    loc_cSQL = "SELECT * FROM SigCdOpe " + ;
                               "WHERE Dopes = " + EscaparSQL(ALLTRIM(loc_cDopes))
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCurOpe)

                    IF loc_nResultado >= 0 AND RECCOUNT(loc_cCurOpe) > 0
                        SELECT (loc_cCurOpe)
                        GO TOP
                        THIS.this_nDocusOperacao = THIS.LerColunaNumerica(loc_cCurOpe, "Docus")
                    ENDIF

                    *-- SigOpCdd: ConfigGers (Substr(...,233,2) do Do Case do boleto)
                    IF USED(loc_cCurCdd)
                        USE IN (loc_cCurCdd)
                    ENDIF
                    loc_cSQL = "SELECT * FROM SigOpCdd " + ;
                               "WHERE Dopes = " + EscaparSQL(ALLTRIM(loc_cDopes))
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCurCdd)

                    IF loc_nResultado >= 0 AND RECCOUNT(loc_cCurCdd) > 0
                        SELECT (loc_cCurCdd)
                        GO TOP
                        THIS.this_cConfigGers = THIS.LerColunaTexto(loc_cCurCdd, "ConfigGers")
                    ENDIF

                    THIS.this_lExibirBotaoBoleto = THIS.DeveExibirBotaoBoleto()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarConfiguracaoOperacao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LerColunaNumerica - Le coluna numerica de cursor por NOME, tolerando
    * os tipos com que o driver ODBC entrega a mesma coluna.
    *
    * Coluna numeric(1,0) do SQL Server chega ora como Numerico, ora como
    * Logico (.T./.F.) conforme o driver - comparar Logico com 1 estoura
    * "Operator/operand type mismatch". Por isso o VARTYPE vem ANTES da
    * comparacao (regra CLAUDE.md #13).
    *
    * Acesso ao campo por EVALUATE (LEITURA): o nome do cursor e do campo
    * vem em variavel, e "campo" nao e sintaxe valida em VFP9.
    * TYPE() - nunca PEMSTATUS, que exige OBJETO no 1o argumento - confere
    * se a coluna existe antes de ler.
    *====================================================================
    PROTECTED PROCEDURE LerColunaNumerica(par_cCursor, par_cColuna)
        LOCAL loc_nValor, loc_uBruto, loc_cExpr

        loc_nValor = 0
        loc_cExpr  = par_cCursor + "." + par_cColuna

        IF USED(par_cCursor) AND TYPE(loc_cExpr) != "U"
            loc_uBruto = EVALUATE(loc_cExpr)

            DO CASE
                CASE ISNULL(loc_uBruto)
                    loc_nValor = 0
                CASE VARTYPE(loc_uBruto) = "N"
                    loc_nValor = loc_uBruto
                CASE VARTYPE(loc_uBruto) = "L"
                    loc_nValor = IIF(loc_uBruto, 1, 0)
                CASE VARTYPE(loc_uBruto) = "C"
                    loc_nValor = VAL(loc_uBruto)
                OTHERWISE
                    loc_nValor = 0
            ENDCASE
        ENDIF

        RETURN loc_nValor
    ENDPROC

    *====================================================================
    * LerColunaTexto - Le coluna CHAR de cursor por NOME, com guarda de
    * NULL e de tipo. O valor volta CRU (sem ALLTRIM): Emps e Dopes sao
    * partes de chave posicional e o padding tem de sobreviver.
    *====================================================================
    PROTECTED PROCEDURE LerColunaTexto(par_cCursor, par_cColuna)
        LOCAL loc_cValor, loc_uBruto, loc_cExpr

        loc_cValor = ""
        loc_cExpr  = par_cCursor + "." + par_cColuna

        IF USED(par_cCursor) AND TYPE(loc_cExpr) != "U"
            loc_uBruto = EVALUATE(loc_cExpr)

            IF !ISNULL(loc_uBruto) AND VARTYPE(loc_uBruto) = "C"
                loc_cValor = loc_uBruto
            ENDIF
        ENDIF

        RETURN loc_cValor
    ENDPROC

    *====================================================================
    * LerColunaLogica - Le coluna LOGICA de cursor por NOME. Marca e
    * Printed sao L no Create Cursor legado, mas a mesma leitura serve se
    * a coluna chegar Numerica (0/1) ou "S"/"N".
    *====================================================================
    PROTECTED PROCEDURE LerColunaLogica(par_cCursor, par_cColuna)
        LOCAL loc_lValor, loc_uBruto, loc_cExpr

        loc_lValor = .F.
        loc_cExpr  = par_cCursor + "." + par_cColuna

        IF USED(par_cCursor) AND TYPE(loc_cExpr) != "U"
            loc_uBruto = EVALUATE(loc_cExpr)

            DO CASE
                CASE ISNULL(loc_uBruto)
                    loc_lValor = .F.
                CASE VARTYPE(loc_uBruto) = "L"
                    loc_lValor = loc_uBruto
                CASE VARTYPE(loc_uBruto) = "N"
                    loc_lValor = (loc_uBruto != 0)
                CASE VARTYPE(loc_uBruto) = "C"
                    loc_lValor = INLIST(UPPER(LEFT(ALLTRIM(loc_uBruto), 1)), "S", "1", "T", "Y")
                OTHERWISE
                    loc_lValor = .F.
            ENDCASE
        ENDIF

        RETURN loc_lValor
    ENDPROC

    *====================================================================
    * DeveExibirBotaoBoleto - Inlist(crSigOpCdc.VenBols, 1, 3)
    *
    * Legado (Init):
    *   ThisForm.btnBoleto.Visible = Inlist(crSigOpCdc.VenBols, 1, 3)
    *
    * Depende de CarregarConfiguracaoOperacao ter rodado (ela alimenta
    * this_nVenBols). Sem configuracao lida, VenBols fica 0 e o botao nao
    * aparece - mesmo resultado pratico do legado quando o CursorQuery nao
    * acha a Operacao.
    *====================================================================
    PROCEDURE DeveExibirBotaoBoleto()
        RETURN INLIST(THIS.this_nVenBols, 1, 3)
    ENDPROC

    *====================================================================
    * ResolverTipoBoleto - o Do Case INTEIRO do btnBoleto.Click legado
    *
    * Legado (btnBoleto.Click, dentro do Scan):
    *   lnTpB = 0
    *   =...CursorQuery('SigOpCdc','crSigOpCdc','Dopes',ThisForm.Movimentacao)
    *   Do Case
    *       Case !EMPTY(substr(crSigOpCdd.ConfigGers,233,2))
    *           lnTpB = VAL(substr(crSigOpCdd.ConfigGers,233,2))
    *       Case (crSigOpCdc.BolItes = 3) && SubNiveis
    *           lnTpB = 11
    *       Case (crSigOpCdc.BolItes = 4) && Detalhado
    *           lnTpB = 13
    *       Case (crSigOpCdc.BolItes = 5) && Romaneio
    *           lnTpB = 14
    *       Case (crSigOpCdc.BolItes = 7) && Controle Interno
    *           lnTpB = 17
    *       Case (crSigOpCdc.BolItes = 6) && Vendedor
    *           lnTpB = 16
    *       Case (crSigOpCdc.BolItes = 8) && Duplicata/Carne
    *           lnTpB = 18
    *       Otherwise && Sim / Nao
    *           lnTpB = 3
    *   EndCase
    *
    * TRANSCRITO, nao reescrito (regra CLAUDE.md #17): a ORDEM dos Case e
    * regra de negocio - o ConfigGers tem precedencia sobre BolItes, e os
    * valores 7 e 6 aparecem nessa ordem invertida no legado, o que nao
    * muda o resultado mas se mantem para a comparacao ficar linha a linha.
    * Os numeros (11, 13, 14, 17, 16, 18, 3) sao os tipos de boleto que
    * SigOpIbo espera e NAO se renumeram.
    *
    * Substr(ConfigGers, 233, 2) sobre char(250) le as posicoes 233-234.
    * A guarda de tipo e de tamanho esta aqui porque this_cConfigGers fica
    * "" quando SigOpCdd nao tem linha para a Operacao - e no legado isso
    * seria um erro de alias, nao um Case verdadeiro.
    *====================================================================
    PROCEDURE ResolverTipoBoleto()
        LOCAL loc_nTpB, loc_cConfig

        loc_nTpB = 0

        loc_cConfig = ""
        IF VARTYPE(THIS.this_cConfigGers) = "C" AND LEN(THIS.this_cConfigGers) >= 234
            loc_cConfig = SUBSTR(THIS.this_cConfigGers, 233, 2)
        ENDIF

        DO CASE
            CASE !EMPTY(loc_cConfig)
                loc_nTpB = VAL(loc_cConfig)

            CASE THIS.this_nBolItes = 3      && SubNiveis
                loc_nTpB = 11

            CASE THIS.this_nBolItes = 4      && Detalhado
                loc_nTpB = 13

            CASE THIS.this_nBolItes = 5      && Romaneio
                loc_nTpB = 14

            CASE THIS.this_nBolItes = 7      && Controle Interno
                loc_nTpB = 17

            CASE THIS.this_nBolItes = 6      && Vendedor
                loc_nTpB = 16

            CASE THIS.this_nBolItes = 8      && Duplicata/Carne
                loc_nTpB = 18

            OTHERWISE                        && Sim / Nao
                loc_nTpB = 3
        ENDCASE

        RETURN loc_nTpB
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega a linha CORRENTE do cursor da grade
    * (csPgto) para as properties this_*Linha*.
    *
    * Padrao obrigatorio: SELECT (par_cAliasCursor) ANTES de acessar
    * campos - "campo" NAO e sintaxe valida em VFP9.
    *
    * Guarda de EOF/BOF: cursor sem linha posicionada devolve .F. em vez de
    * ler lixo.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorGrade)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + ;
                CHR(225) + " aberto."
        ELSE
            TRY
                *-- CRITICO: SELECT antes de acessar campos
                SELECT (loc_cAlias)

                IF EOF() OR RECCOUNT() = 0
                    THIS.this_cMensagemErro = "Nenhuma linha selecionada na grade."
                    THIS.LimparLinha()
                ELSE
                    THIS.this_lLinhaMarca   = THIS.LerColunaLogica(loc_cAlias, "Marca")
                    THIS.this_lLinhaPrinted = THIS.LerColunaLogica(loc_cAlias, "Printed")
                    THIS.this_nLinhaValos   = THIS.LerColunaNumerica(loc_cAlias, "Valos")
                    THIS.this_nLinhaNumes   = THIS.LerColunaNumerica(loc_cAlias, "Numes")
                    THIS.this_nLinhaValdevs = THIS.LerColunaNumerica(loc_cAlias, "Valdevs")
                    THIS.this_nLinhaDocus   = THIS.LerColunaNumerica(loc_cAlias, "Docus")
                    THIS.this_cLinhaObs     = THIS.LerColunaTexto(loc_cAlias, "Obs")
                    THIS.this_cLinhaEmps    = THIS.LerColunaTexto(loc_cAlias, "Emps")
                    THIS.this_cLinhaDopes   = THIS.LerColunaTexto(loc_cAlias, "Dopes")

                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
                loc_lSucesso = .F.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ContarMarcadas - Quantas linhas o usuario marcou no checkbox.
    *
    * O legado nao conta: ele so faz Scan / If csPgto.marca. A contagem
    * existe aqui para o Form poder avisar antes de comecar um lote vazio,
    * e e feita com COUNT FOR, que ignora registro marcado para exclusao -
    * ao contrario de RECCOUNT.
    *
    * COUNT move o ponteiro, por isso o RECNO e salvo e reposto: a linha
    * corrente da grade nao pode mudar so porque alguem contou.
    *====================================================================
    PROCEDURE ContarMarcadas()
        LOCAL loc_nTotal, loc_nRecno, loc_oErro

        loc_nTotal = 0

        IF USED(THIS.this_cCursorGrade)
            TRY
                SELECT (THIS.this_cCursorGrade)
                loc_nRecno = RECNO()

                COUNT FOR Marca TO loc_nTotal

                IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT()
                    GO loc_nRecno
                ELSE
                    GO TOP
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message, "Erro em ContarMarcadas")
                loc_nTotal = 0
            ENDTRY
        ENDIF

        RETURN loc_nTotal
    ENDPROC

    *====================================================================
    * ImprimirDocumentoDaLinha - Do SigPrIdc with ... do Imprimir.Click
    *
    * Legado (Imprimir.Click, dentro do Scan, quando CsPgto.docus = 1):
    *   =...cursorquery('SigCdOpe','CrSigCdOpe','dopes',TprMvCab.Dopes)
    *   =...CursorQuery('SigOpCdc','CrSigOpCdc','Dopes',TprMvCab.Dopes)
    *   DO SigPrIdc with CsPgto.Emps, CsPgto.Dopes, CsPgto.Numes,
    *       CsPgto.valdevs, crSigOpCdc.QtdDocs, .F., .F., .F., .F.,
    *       crSigOpCdc.TpImpDocs, .F., Thisform, ThisForm.pChkImpDoc
    *
    * DIVERGENCIA DELIBERADA, de UMA coisa so: os dois CursorQuery do
    * legado filtram por "TprMvCab.Dopes", e TprMvCab NAO EXISTE - o
    * cursor da consulta do Init chama-se CrTprMvCab. No Fortyus essa
    * linha so nao derruba a tela quando o form chamador por acaso tem um
    * alias TprMvCab aberto. Aqui o filtro usa o Dopes da LINHA que esta
    * sendo processada (this_cLinhaDopes), que e o valor que aquela
    * expressao pretendia alcancar - o proprio Scan e sobre csPgto, e
    * csPgto.Dopes veio de CrTprMvCab.Dopes da mesma linha. Reproduzir o
    * defeito seria reproduzir um erro de alias, nao um comportamento.
    *
    * SigPrIdc e PROCEDURE global do Fortyus (sig.prg/SIGFUNCS.PRG) que NAO
    * veio no acervo (regra CLAUDE.md #27) - nao ha fonte para reproduzir o
    * layout do documento. A chamada fica dentro de TRY/CATCH que exibe a
    * falha com MsgErro (regra #9, CATCH nunca silencioso): a ausencia fica
    * VISIVEL ao usuario, em vez de um stub que finge imprimir. Mesmo
    * tratamento que SigOpIboBO.ExecutarImpressao da ao Do SigBlBol.
    *
    * par_oForm e o 12o argumento do legado (Thisform). Vem como PARAMETRO
    * porque o BO nao guarda referencia a objeto de UI (ver cabecalho).
    *====================================================================
    PROCEDURE ImprimirDocumentoDaLinha(par_oForm)
        LOCAL loc_lSucesso, loc_oErro, loc_oForm

        loc_lSucesso = .F.
        loc_oForm = IIF(PCOUNT() >= 1 AND VARTYPE(par_oForm) = "O", par_oForm, .NULL.)

        *-- Recarrega SigCdOpe/SigOpCdc pelo Dopes DESTA linha, como os dois
        *-- cursorquery que o legado faz imediatamente antes do SigPrIdc
        THIS.CarregarConfiguracaoOperacao(THIS.this_cLinhaDopes)

        TRY
            DO SigPrIdc WITH THIS.this_cLinhaEmps, THIS.this_cLinhaDopes, ;
                THIS.this_nLinhaNumes, THIS.this_nLinhaValdevs, ;
                THIS.this_nQtdDocs, .F., .F., .F., .F., ;
                THIS.this_nTpImpDocs, .F., loc_oForm, THIS.this_lChkImpDoc
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel imprimir o documento da movimenta" + ;
                CHR(231) + CHR(227) + "o " + ALLTRIM(THIS.this_cLinhaObs) + ":" + CHR(13) + ;
                loc_oErro.Message, "Erro ao Imprimir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MarcarLinhaComoImpressa - Replace do fim do Scan do Imprimir.Click
    *
    * Legado (Imprimir.Click):
    *   Select csPgto
    *   Replace csPgto.marca with .f., csPgto.Printed with .t.
    *
    * Desmarca a linha e registra que ela ja foi processada - e o que faz o
    * Click do checkbox legado ("if !(csPgto.printed) / This.value = .t.")
    * deixar de marca-la outra vez.
    *
    * O cursor da grade vem de CREATE CURSOR, que nasce READWRITE: por isso
    * o REPLACE funciona. Cursor de SQLEXEC direto seria SOMENTE-LEITURA e
    * a celula nunca entraria em edicao.
    *====================================================================
    PROCEDURE MarcarLinhaComoImpressa()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorGrade)
            THIS.this_cMensagemErro = "Cursor da grade n" + CHR(227) + "o est" + CHR(225) + " aberto."
        ELSE
            TRY
                SELECT (THIS.this_cCursorGrade)

                IF !EOF() AND RECCOUNT() > 0
                    REPLACE Marca WITH .F., Printed WITH .T.
                    THIS.this_lLinhaMarca   = .F.
                    THIS.this_lLinhaPrinted = .T.
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhuma linha selecionada na grade."
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message, "Erro em MarcarLinhaComoImpressa")
                loc_lSucesso = .F.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparLinha - Zera as properties da linha corrente da grade
    *====================================================================
    PROCEDURE LimparLinha()
        THIS.this_lLinhaMarca   = .F.
        THIS.this_cLinhaObs     = ""
        THIS.this_lLinhaPrinted = .F.
        THIS.this_nLinhaValos   = 0
        THIS.this_cLinhaEmps    = ""
        THIS.this_cLinhaDopes   = ""
        THIS.this_nLinhaNumes   = 0
        THIS.this_nLinhaValdevs = 0
        THIS.this_nLinhaDocus   = 0

        RETURN .T.
    ENDPROC

    *====================================================================
    * LimparConfiguracaoOperacao - Zera as properties lidas de
    * SigOpCdc/SigCdOpe/SigOpCdd
    *====================================================================
    PROCEDURE LimparConfiguracaoOperacao()
        THIS.this_nVenBols       = 0
        THIS.this_nQtdDocs       = 0
        THIS.this_nTpImpDocs     = 0
        THIS.this_nBolItes       = 0
        THIS.this_nQvias         = 0
        THIS.this_nQtdBols       = 0
        THIS.this_nDocusOperacao = 0
        THIS.this_cConfigGers    = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * LimparDados - Hook de BusinessBase: zera tudo o que a tela mostra
    *====================================================================
    PROCEDURE LimparDados()
        THIS.this_cChaveEmpDnCrds = ""
        THIS.this_lExibirBotaoBoleto = .F.
        THIS.this_nQtdMovimentacoes = 0

        THIS.LimparLinha()
        THIS.LimparConfiguracaoOperacao()

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave do registro para a auditoria herdada
    *
    * PROTECTED porque e hook de BusinessBase: NUNCA chamar de fora do BO
    * (regra CLAUDE.md #51). Devolve a chave POSICIONAL da linha corrente
    * (3 + 20 + 6 = 29 chars), que e o unico identificador que este
    * dialogo tem - ele nao grava em tabela nenhuma.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.MontarChaveEmpDnCrds(THIS.this_cLinhaEmps, ;
            THIS.this_cLinhaDopes, THIS.this_nLinhaNumes)
    ENDPROC

    *====================================================================
    * Buscar - Carga da grade pela interface herdada de BusinessBase
    *
    * O filtro recebido e o Dopes da Operacao, para o Form poder chamar
    * Buscar() sem conhecer os nomes internos. Quando vem vazio, vale o
    * this_cDopes que DefinirParametros guardou - exatamente como o legado,
    * que usa sempre ThisForm.Movimentacao (= _pDopes).
    *====================================================================
    PROCEDURE Buscar(par_cFiltro, par_cOrdenacao, par_cCampos)
        LOCAL loc_lSucesso

        IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
            THIS.this_cDopes = par_cFiltro
        ENDIF

        loc_lSucesso = THIS.CarregarMovimentacoes()

        IF loc_lSucesso
            THIS.CarregarConfiguracaoOperacao(THIS.this_cDopes)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Guarda do lote de impressao
    *
    * Legado (Imprimir.Click e btnBoleto.Click, as duas primeiras linhas):
    *   If Reccount("csPgto") <=0
    *       MessageBox("Nao existem observacoes a serem auteticadas",16,"")
    *       ThisForm.Sair.Setfocus
    *   EndIf
    *
    * A mensagem fica com o texto do legado (inclusive a grafia
    * "auteticadas", que e do original) - trocar texto de mensagem seria
    * desvio do PILAR 1. Quem move o foco para o botao Sair e o Form.
    *====================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF !USED(THIS.this_cCursorGrade) OR RECCOUNT(THIS.this_cCursorGrade) <= 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o existem observa" + CHR(231) + ;
                CHR(245) + "es a serem auteticadas"
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Destroy - Fecha os cursores que este BO abriu
    *
    * USE IN fecha o alias mesmo com buffer sujo, e por isso NAO se usa
    * TABLEREVERT antes: sem buffering ligado (CREATE CURSOR nasce com
    * Buffering = 1) ele dispara o erro 1586 em vez de ser inocuo
    * (regra CLAUDE.md #52).
    *====================================================================
    PROCEDURE Destroy()
        LOCAL loc_nI, loc_aCursores[5]

        loc_aCursores[1] = THIS.this_cCursorGrade
        loc_aCursores[2] = "cursor_4c_TprMvCab"
        loc_aCursores[3] = "cursor_4c_SigOpCdc"
        loc_aCursores[4] = "cursor_4c_SigCdOpe"
        loc_aCursores[5] = "cursor_4c_SigOpCdd"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF !EMPTY(loc_aCursores[loc_nI]) AND USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

