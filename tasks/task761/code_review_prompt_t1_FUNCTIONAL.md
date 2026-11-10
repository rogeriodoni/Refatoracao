# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Value()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarEmpDopNumsMovimento()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLim.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1811 linhas total):

*-- Linhas 23 a 81:
23: *
24: * Herda de: FormBase
25: *
26: * FASE 3/8 - Estrutura Base: DEFINE CLASS, propriedades, Init, InicializarForm,
27: * aparencia + faixa do cabecalho, Destroy.
28: *------------------------------------------------------------------------------
29: * FASE 4/8 - Grid e botoes CRUD: NADA A ACRESCENTAR (medido, nao presumido)
30: *
31: * A Fase 4 pede o metodo de configuracao da pagina Lista com Grid, o
32: * cnt_4c_Botoes com 6 botoes CRUD e o metodo de alternancia entre as paginas.
33: * NENHUMA das tres superficies existe no legado: criar Grid/PageFrame
34: * Lista-Dados/botoes CRUD aqui violaria o PILAR 1 e a regra "NUNCA inventar",
35: * e escrever esses dois metodos VAZIOS so para casar com o regex do gate eh o
36: * "stub disfarcado" que a regra de completude proibe. Esta tela cabe inteira
37: * nas Fases 3 e 5-8.
38: *
39: * Os nomes desses dois metodos NAO aparecem por extenso em nenhum lugar deste
40: * arquivo, de proposito: o gate casa o identificador com -match sobre o .prg
41: * INTEIRO, comentario incluido (sem exigir PROCEDURE antes), entao cita-los
42: * aqui faria a fase passar pelo ramo PAGINADO - isto eh, o gate concluiria que
43: * este form TEM pagina Lista - em vez do ramo CAPTURA, que eh o motivo real.
44: * Passar pelo caminho errado esconderia um form de verdade incompleto e
45: * convidaria o proximo sweep a "consertar" o que esta correto.
46: *
47: * MEDICAO no dump (tasks\task761\SigOpLim_form_codigo_fonte.txt), que eh o que
48: * dispensa a fase - nao a afirmacao solta "nao tem lista":
49: *
50: *   BaseClass: grid ............. 0     BaseClass: pageframe ....... 0
51: *   BaseClass: listbox .......... 0     commandbutton/commandgroup . 0
52: *   AddCursor ................... 0     pColuna .................... 0
53: *   RecordSource ................ 0     ControlSource .............. 0
54: *   token \bGrade\b | \bgrd ..... 0     API de nos (.Nodes.Add...) . 0
55: *   BaseClass: textbox .......... 3     (usuario, senha, get_Motivo)
56: *   ReadOnly = .T. .............. 0     (os 3 campos sao de ENTRADA)
57: *
58: * Nao ha UM CommandButton/CommandGroup na arvore: o dialogo se encerra pelos
59: * proprios Valid dos campos (thisform.release()), nunca por botao - por isso
60: * nao existe nem o cnt_4c_Saida/cmd_4c_Encerrar canonico (regra #10, que eh
61: * dos CRUD de 1000px; em 400px o Left=917 ficaria 517px fora da tela).
62: *
63: * Com zero lista e campos de ENTRADA (nenhum ReadOnly), o gate da Fase 4
64: * dispensa Grid/CRUD pelo ramo CAPTURA (temLayoutCaptura, case 4 do
65: * OrquestradorMigracao.ps1) - o mesmo ramo de SIGMVVDE/FormSigMvVde. Medido
66: * com os helpers REAIS do orquestrador: temListaEstritaF4 = False,
67: * temCampoCapturaF4 = True, DialogoExibicao = False => legadoCapturaF4 = True.
68: *
69: * Os tres campos (usuario/senha/get_Motivo) ficam para a Fase 5; os lookups
70: * fwBuscaSel (TmpUsu / TmpMdsc) para a Fase 6; os Valid que resolvem a alcada
71: * e fecham o dialogo devolvendo zsenha, para as Fases 7-8. O TabIndex tambem
72: * NAO cabe aqui: TabIndex fora da faixa 1..N eh descartado em silencio, logo
73: * a ordem de tabulacao vai na fase que cria o ULTIMO AddObject.
74: *------------------------------------------------------------------------------
75: * CONTRATO DE USO (espelha o Init/Unload do legado)
76: *
77: * Legado:
78: *     SIGOPLIM.Init   -> Parameter totite,valor,pvalor,tipo,poform,Pcx,
79: *                                   pMotivo,pClaConta,plCheckBin,plCheckTabD,
80: *                                   pcEmpresa
81: *     SIGOPLIM.Unload -> Return ThisForm.zsenha

*-- Linhas 144 a 217:
144: * O retorno eh lido por "to chklim" (o Unload) e testado com
145: * Type('ChkLim') = 'L' And Not chklim: LOGICO .F. significa NEGADO e
146: * qualquer CARACTERE significa autorizado. ObterResultado() devolve a mesma
147: * coisa para quem abrir por CREATEOBJECT.
148: *
149: * Consumo:
150: *   loDlg = CREATEOBJECT("FormSigOpLim", lnItens, lnValor, lnPerc, "D", .T.)
151: *   IF VARTYPE(loDlg) = "O"
152: *       loDlg.Show()                    && modal - bloqueia
153: *       luZSenha = loDlg.ObterResultado()
154: *   ENDIF                               && com Release - ver FecharDialogo
155: *==============================================================================
156: 
157: DEFINE CLASS FormSigOpLim AS FormBase
158: 
159:     *--------------------------------------------------------------------------
160:     * Propriedades visuais - transcritas do SCX legado (PILAR 1)
161:     *
162:     * ShowWindow = 1 (In Top-Level Form) eh o UNICO valor que nao vem do dump:
163:     * eh canonico do sistema novo para dialogo modal (sem ele o form fecha
164:     * imediatamente) e o CorretorAutomatico o injeta de qualquer forma -
165:     * declarar aqui evita que o sweep reescreva o arquivo.
166:     *--------------------------------------------------------------------------
167:     Width       = 400
168:     Height      = 250
169:     DataSession = 1
170:     BorderStyle = 2
171:     AutoCenter  = .T.
172:     ShowWindow  = 1
173:     ControlBox  = .F.
174:     TitleBar    = 0
175:     WindowType  = 1
176: 
177:     *-- Business Object (SigOpLimBO) - instanciado em InicializarForm.
178:     this_oBusinessObject = .NULL.
179: 
180:     *-- Redeclarada aqui (alem da FormBase) porque o CorretorAutomatico
181:     *-- (MENSAGEMERRO_AUSENTE) exige a declaracao local em todo form que leia
182:     *-- THIS.this_cMensagemErro.
183:     this_cMensagemErro = ""
184: 
185:     *--------------------------------------------------------------------------
186:     * Parametros do Init legado (Parameter totite,valor,pvalor,tipo,poform,
187:     * Pcx,pMotivo,pClaConta,plCheckBin,plCheckTabD,pcEmpresa). Guardados aqui
188:     * no FORM - igual ao legado (ThisForm.totite/valdesc/pdescs/...) - e so
189:     * transferidos para o BO pelo hook FormParaBO, que entra na fase de
190:     * consolidacao (depois dos campos existirem).
191:     *--------------------------------------------------------------------------
192:     this_nTotIte   = 0      && totite  - Total de itens da operacao
193:     this_nValDesc  = 0      && valor   - Valor do desconto/acrescimo pedido
194:     this_nPDescs   = 0      && pvalor  - Percentual do desconto/acrescimo pedido
195:     this_cTipo     = "D"    && tipo    - "D"/"C"/"X"/"L" (default "D", legado)
196:     this_lMotivo   = .F.    && pMotivo - .T. quando a tela exige informar motivo
197:     this_cClaConta = " "    && pClaConta - Classificacao da conta (SigCdClc)
198:     this_lCheckBin = .F.    && plCheckBin  - filtra motivos com ChkBins  <> 1
199:     this_lCheckTbd = .F.    && plCheckTabD - filtra motivos com BlqTabDs <> 1
200:     this_cEmps     = ""     && pcEmpresa - vazio = BO usa a empresa logada
201: 
202:     *-- ThisForm.Zsenha do legado - resultado lido pelo chamador apos o
203:     *-- Show(). .F. = liberacao negada / dialogo encerrado sem autorizar.
204:     this_uZSenha = .F.
205: 
206:     *--------------------------------------------------------------------------
207:     * somotivo do legado (Init): ( totite + valor + pvalor = 0 ) And
208:     * ( Tipo <> [X] ). Quando .T. a tela pede SOMENTE o motivo, sem
209:     * usuario/senha. Calculado em SincronizarParametrosBO, depois de
210:     * this_cTipo estar resolvido.
211:     *--------------------------------------------------------------------------
212:     this_lSoMotivo = .F.
213: 
214:     *--------------------------------------------------------------------------
215:     * Guardas de reentrancia dos lookups e validacoes (regra #47 do CLAUDE.md)
216:     *
217:     * O picker eh MODAL: ao subir ele tira o foco do campo e, ao descer, o

*-- Linhas 235 a 284:
235: 
236:     *--------------------------------------------------------------------------
237:     * Init - recebe os parametros de abertura (equivalente ao Parameter do
238:     * legado) e delega ao FormBase, que chama InicializarForm().
239:     *
240:     * Sem TRY/CATCH de proposito: o bloco so guarda parametros (nenhuma
241:     * operacao capaz de estourar) - o tratamento de erro da inicializacao
242:     * fica em InicializarForm, onde ha o que proteger.
243:     *--------------------------------------------------------------------------
244:     PROCEDURE Init(par_nTotIte, par_nValDesc, par_nPDescs, par_cTipo, ;
245:             par_lMotivo, par_cClaConta, par_lCheckBin, par_lCheckTbd, par_cEmps)
246:         LOCAL loc_lSucesso
247: 
248:         IF PCOUNT() >= 1 AND VARTYPE(par_nTotIte) = "N"
249:             THIS.this_nTotIte = par_nTotIte
250:         ENDIF
251: 
252:         IF PCOUNT() >= 2 AND VARTYPE(par_nValDesc) = "N"
253:             THIS.this_nValDesc = par_nValDesc
254:         ENDIF
255: 
256:         IF PCOUNT() >= 3 AND VARTYPE(par_nPDescs) = "N"
257:             THIS.this_nPDescs = par_nPDescs
258:         ENDIF
259: 
260:         *-- Legado: Tipo = Iif(Type([TIPO])<>[C], [D], Tipo)
261:         IF PCOUNT() >= 4 AND VARTYPE(par_cTipo) = "C" AND !EMPTY(par_cTipo)
262:             THIS.this_cTipo = par_cTipo
263:         ELSE
264:             THIS.this_cTipo = "D"
265:         ENDIF
266: 
267:         IF PCOUNT() >= 5
268:             THIS.this_lMotivo = IIF(VARTYPE(par_lMotivo) = "L", par_lMotivo, .F.)
269:         ENDIF
270: 
271:         *-- Legado: Claconta = Iif(Type('pClaConta')='C',pClaConta,' ')
272:         IF PCOUNT() >= 6 AND VARTYPE(par_cClaConta) = "C"
273:             THIS.this_cClaConta = par_cClaConta
274:         ELSE
275:             THIS.this_cClaConta = " "
276:         ENDIF
277: 
278:         IF PCOUNT() >= 7
279:             THIS.this_lCheckBin = IIF(VARTYPE(par_lCheckBin) = "L", par_lCheckBin, .F.)
280:         ENDIF
281: 
282:         IF PCOUNT() >= 8
283:             THIS.this_lCheckTbd = IIF(VARTYPE(par_lCheckTbd) = "L", par_lCheckTbd, .F.)
284:         ENDIF

*-- Linhas 298 a 476:
298:     ENDPROC
299: 
300:     *--------------------------------------------------------------------------
301:     * InicializarForm - instancia o BO e monta a estrutura base do dialogo
302:     *
303:     * Chamado automaticamente por FormBase.Init() - NAO chamar de novo no
304:     * Init (AddObject duplicado dispararia "member object already exists").
305:     *
306:     * RETURN fica FORA do TRY/CATCH (regra #1 do CLAUDE.md): dentro do bloco
307:     * usa-se a flag loc_lSucesso.
308:     *--------------------------------------------------------------------------
309:     PROTECTED PROCEDURE InicializarForm()
310:         LOCAL loc_lSucesso, loc_oErro
311:         loc_lSucesso = .F.
312: 
313:         TRY
314:             *-- Caption inicial do legado (o Init tambem o reatribui em
315:             *-- runtime para "Limite Ultrapassado..." - fica para a fase que
316:             *-- escreve esse bloco, pois depende dos campos ja existirem).
317:             THIS.Caption = "Limite de Descontos"
318: 
319:             *-- Business Object gerado nas Fases 1-2
320:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpLimBO")
321: 
322:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
323:                 *-- Aparencia base do form (fundo do framework legado)
324:                 THIS.ConfigurarAparenciaBase()
325: 
326:                 *-- Faixa cinza do cabecalho (cntSombra do legado)
327:                 THIS.ConfigurarCabecalho()
328: 
329:                 *-- Parametros de abertura -> BO. Tem de rodar ANTES de
330:                 *-- qualquer lookup: BuscarUsuariosAutorizados() e
331:                 *-- BuscarMotivos() leem this_cTipo / this_nValDesc /
332:                 *-- this_nPDescs / this_cClaConta / this_cEmps DO BO - sem a
333:                 *-- sincronizacao as duas consultas rodariam com os defaults
334:                 *-- da classe e devolveriam o conjunto ERRADO em silencio.
335:                 THIS.SincronizarParametrosBO()
336: 
337:                 *-- Campos do dialogo (Partes 1 e 2). Tem de rodar ANTES do
338:                 *-- TornarControlesVisiveis: AddObject nasce Visible = .F.
339:                 THIS.ConfigurarCampos()
340: 
341:                 *-- Ordem de tabulacao do SCX - depois de TODOS os AddObject
342:                 THIS.AplicarTabIndex()
343: 
344:                 *-- Valid / When do legado (regra #3: delegados sao PUBLIC)
345:                 THIS.VincularEventos()
346: 
347:                 *-- AddObject cria tudo com Visible = .F.
348:                 THIS.TornarControlesVisiveis(THIS)
349: 
350:                 *-- Regras de exibicao do Init legado (Caption + quais campos
351:                 *-- aparecem conforme Tipo/somotivo/Motivo). Roda DEPOIS do
352:                 *-- TornarControlesVisiveis, que forca Visible = .T. em TUDO e
353:                 *-- acabaria de apagar o Visible = .F. que o SCX declara em
354:                 *-- Say3/senha.
355:                 THIS.AplicarRegrasDeExibicao()
356: 
357:                 loc_lSucesso = .T.
358:             ELSE
359:                 THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
360:                     "vel criar o SigOpLimBO."
361:                 MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
362:             ENDIF
363:         CATCH TO loc_oErro
364:             THIS.this_cMensagemErro = loc_oErro.Message
365:             MsgErro(loc_oErro.Message + ;
366:                 " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
367:                 " | Procedure: " + loc_oErro.Procedure, ;
368:                 "Erro ao inicializar FormSigOpLim")
369:             loc_lSucesso = .F.
370:         ENDTRY
371: 
372:         RETURN loc_lSucesso
373:     ENDPROC
374: 
375:     *--------------------------------------------------------------------------
376:     * ConfigurarAparenciaBase - propriedades do form que dependem de variavel
377:     * global, logo nao cabem no inicializador da classe.
378:     *
379:     * Legado: Picture = ..\framework\imagens\new_background.jpg
380:     * O caminho vem de gc_4c_CaminhoFramework (regra #170 do CLAUDE.md) -
381:     * NUNCA reconstruir a partir de gc_4c_CaminhoBase, que nao navega os tres
382:     * niveis acima. Atribuicao direta, sem guard IF FILE(): guard mascara
383:     * Picture ausente, que o VFP9 aceita em silencio (regra #25).
384:     *
385:     * Este form NAO tem PageFrame (o legado nao tem Page nenhuma), por isso
386:     * nao ha Page1.Picture/Page2.Picture a definir - o fundo vai no proprio
387:     * form, igual ao legado.
388:     *--------------------------------------------------------------------------
389:     PROTECTED PROCEDURE ConfigurarAparenciaBase()
390:         THIS.Picture    = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
391:         THIS.ScrollBars = 0
392:     ENDPROC
393: 
394:     *--------------------------------------------------------------------------
395:     * ConfigurarCabecalho - faixa cinza do titulo (cntSombra do legado)
396:     *
397:     * Legado: cntSombra   Top=0  Left=0  Width=800 Height=80
398:     *                     BorderWidth=0  BackColor=100,100,100
399:     *         lblSombra   Top=18 Left=10 Width=769 Height=40  ForeColor=0,0,0
400:     *         lblTitulo   Top=17 Left=10 Width=769 Height=46  ForeColor=255,255,255
401:     *                     ambos Tahoma 18 bold, WordWrap=.T., Alignment=0,
402:     *                     BackStyle=0
403:     *
404:     * Os DOIS labels sobrepostos com 1px de diferenca no Top sao o efeito de
405:     * sombra do framework: o preto desenha atras, o branco na frente. O
406:     * Caption dos dois vem de THIS.Caption, igual ao Init do legado
407:     * (cntSombra.lblSombra.Caption = ThisForm.Caption).
408:     *
409:     * Width = THIS.Width nos tres objetos, NAO os literais 800/769: o SCX
410:     * declara o container (800) e os labels (769) mais largos que o proprio
411:     * form (400) - artefato do Form Designer, que desenha o container alem
412:     * da borda da janela. Copiar o literal faria o filho extrapolar o pai e
413:     * ser RECORTADO (regra #30), alem do titulo sair cortado.
414:     *
415:     * AutoSize = .F. explicito nos dois labels (regra #23): em Label criado
416:     * por AddObject o AutoSize eh no-op e, com WordWrap = .T., ele DESCARTA a
417:     * Height e colapsa o texto para uma linha.
418:     *
419:     * Nenhum controle de dados pode ficar com Top < 80 nesta tela: a faixa
420:     * ocupa a area 0..80, e o legado respeita isso (Frase comeca em 91).
421:     *--------------------------------------------------------------------------
422:     PROTECTED PROCEDURE ConfigurarCabecalho()
423:         *-- Container da faixa cinza
424:         THIS.AddObject("cnt_4c_Sombra", "Container")
425:         WITH THIS.cnt_4c_Sombra
426:             .Top           = 0
427:             .Left          = 0
428:             .Width         = THIS.Width
429:             .Height        = 80
430:             .BorderWidth   = 0
431:             .BackStyle     = 1
432:             .BackColor     = RGB(100, 100, 100)
433:             .SpecialEffect = 0
434:             .Visible       = .T.
435:         ENDWITH
436: 
437:         *-- Label de sombra (preto, 1px abaixo do titulo)
438:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
439:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
440:             .AutoSize      = .F.
441:             .FontName      = "Tahoma"
442:             .FontSize      = 18
443:             .FontBold      = .T.
444:             .FontUnderline = .F.
445:             .WordWrap      = .T.
446:             .Alignment     = 0
447:             .BackStyle     = 0
448:             .Caption       = THIS.Caption
449:             .Top           = 18
450:             .Left          = 10
451:             .Width         = THIS.Width
452:             .Height        = 40
453:             .ForeColor     = RGB(0, 0, 0)
454:             .Visible       = .T.
455:         ENDWITH
456: 
457:         *-- Label do titulo (branco sobre o cinza do container OPACO - esta
458:         *-- eh a excecao legitima da regra #12, que proibe ForeColor branco
459:         *-- em label de DADOS)
460:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
461:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
462:             .AutoSize    = .F.
463:             .FontName    = "Tahoma"
464:             .FontSize    = 18
465:             .FontBold    = .T.
466:             .WordWrap    = .T.
467:             .Alignment   = 0
468:             .BackStyle   = 0
469:             .Caption     = THIS.Caption
470:             .Top         = 17
471:             .Left        = 10
472:             .Width       = THIS.Width
473:             .Height      = 46
474:             .ForeColor   = RGB(255, 255, 255)
475:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
476:             .Visible     = .T.

*-- Linhas 524 a 567:
524:     * Inventar .Alignment = 1 encostaria o texto na borda direita da caixa,
525:     * dentro do campo, e a legenda sairia comida.
526:     *--------------------------------------------------------------------------
527:     PROTECTED PROCEDURE ConfigurarCampos()
528: 
529:         *----------------------------------------------------------------------
530:         * Frase - rotulo de instrucao do dialogo
531:         *
532:         * Width = 275 (nao os 134 px do Caption de projeto): o Init legado
533:         * REATRIBUI este Caption em runtime, e a maior das tres frases
534:         * ("Informe usuario c/ acesso a libera" + CHR(231) + CHR(227) + "o e
535:         * Motivo:") mede 268 px em Tahoma 8 bold - medido nesta sessao. Como o
536:         * AutoSize eh no-op, uma Width dimensionada para o texto de projeto
537:         * cortaria a frase de runtime, que eh a que o usuario le. 19 + 275 =
538:         * 294, dentro dos 400 do form.
539:         *----------------------------------------------------------------------
540:         THIS.AddObject("lbl_4c_Frase", "Label")
541:         WITH THIS.lbl_4c_Frase
542:             .AutoSize   = .F.
543:             .FontName   = "Tahoma"
544:             .FontSize   = 8
545:             .FontBold   = .T.
546:             .FontItalic = .F.
547:             .BackStyle  = 0
548:             .Alignment  = 0
549:             .Caption    = "Libera" + CHR(231) + CHR(227) + "o de Descontos"
550:             .Left       = 19
551:             .Top        = 91
552:             .Width      = 275
553:             .Height     = 15
554:             .ForeColor  = RGB(90, 90, 90)
555:             .Visible    = .T.
556:         ENDWITH
557: 
558:         *----------------------------------------------------------------------
559:         * Say1 "Motivo : " + get_Motivo (codigo do motivo - SigCdFs.Codigos)
560:         *----------------------------------------------------------------------
561:         THIS.AddObject("lbl_4c_Label1", "Label")
562:         WITH THIS.lbl_4c_Label1
563:             .AutoSize  = .F.
564:             .FontName  = "Tahoma"
565:             .FontSize  = 8
566:             .FontBold  = .T.
567:             .BackStyle = 0

*-- Linhas 652 a 695:
652:         * revela: no Init quando Tipo = "L" (senha livre), ou no FIM de
653:         * usuario.Valid, depois de o autorizador ser resolvido. Por isso a
654:         * visibilidade NAO fica aqui - fica em AplicarRegrasDeExibicao(), que
655:         * roda DEPOIS do TornarControlesVisiveis.
656:         *
657:         * senha NAO declara Alignment no dump - ao contrario de usuario e
658:         * get_Motivo, que declaram Alignment = 3. Transcricao fiel: fica o
659:         * default da classe, NAO se copia o Alignment dos irmaos.
660:         *
661:         * Format / DisabledBackColor / DisabledForeColor nao estao no SCX
662:         * porque vem da CLASSE fwget (framework.vcx), lida como DBF nesta
663:         * sessao: Format = "K", DisabledBackColor = 192,192,192,
664:         * DisabledForeColor = 0,0,0, Themes = .F. (o SCX sobrescreve Themes
665:         * para .T.). Transcrever a classe eh fidelidade, nao invencao.
666:         *
667:         * MaxLength = 10 vem da LARGURA DA COLUNA (regra #19): SigCdUsu.senhas
668:         * eh char(10), e o InputMask do dump tem exatamente 10 "!" - nunca do
669:         * Width em pixels.
670:         *
671:         * Width = 44 no label: "Senha : " mede 44 px em Tahoma 8 bold, e
672:         * 120 + 44 = 164, 4 px antes do TextBox em Left = 168 - a mesma conta
673:         * dos outros dois labels. AutoSize = .F. explicito porque em Label
674:         * criado por AddObject o AutoSize eh NO-OP (regra #23).
675:         *----------------------------------------------------------------------
676:         THIS.AddObject("lbl_4c_Label3", "Label")
677:         WITH THIS.lbl_4c_Label3
678:             .AutoSize  = .F.
679:             .FontName  = "Tahoma"
680:             .FontSize  = 8
681:             .FontBold  = .T.
682:             .BackStyle = 0
683:             .Alignment = 0
684:             .Caption   = "Senha : "
685:             .Left      = 120
686:             .Top       = 212
687:             .Width     = 44
688:             .Height    = 15
689:             .ForeColor = RGB(90, 90, 90)
690:             .Visible   = .F.
691:         ENDWITH
692: 
693:         THIS.AddObject("txt_4c_Senha", "TextBox")
694:         WITH THIS.txt_4c_Senha
695:             .Value             = ""

*-- Linhas 724 a 1014:
724:     * this_cClaConta. Sem esta sincronizacao as duas consultas rodam com os
725:     * defaults da classe e devolvem o conjunto ERRADO - sem erro, sem log.
726:     *--------------------------------------------------------------------------
727:     PROTECTED PROCEDURE SincronizarParametrosBO()
728:         WITH THIS.this_oBusinessObject
729:             .this_nTotIte   = THIS.this_nTotIte
730:             .this_nValDesc  = THIS.this_nValDesc
731:             .this_nPDescs   = THIS.this_nPDescs
732:             .this_cTipo     = THIS.this_cTipo
733:             .this_lMotivo   = THIS.this_lMotivo
734:             .this_cClaConta = THIS.this_cClaConta
735:             .this_lCheckBin = THIS.this_lCheckBin
736:             .this_lCheckTbd = THIS.this_lCheckTbd
737:         ENDWITH
738: 
739:         *-- this_cEmps SO quando o chamador informou: estando vazio, o Init do
740:         *-- BO ja resolveu para go_4c_Sistema.cCodEmpresa, e sobrescrever com
741:         *-- "" faria o filtro de motivos do legado
742:         *-- (Where Nvl(Emps, pEmps) = pEmps) nunca casar.
743:         IF !EMPTY(ALLTRIM(THIS.this_cEmps))
744:             THIS.this_oBusinessObject.this_cEmps = ALLTRIM(THIS.this_cEmps)
745:         ELSE
746:             THIS.this_cEmps = THIS.this_oBusinessObject.this_cEmps
747:         ENDIF
748: 
749:         *-- Legado (Init): Somotivo = ( totite+valor+pvalor = 0 ) And
750:         *--                           (ThisForm.Tipo <> [X])
751:         THIS.this_lSoMotivo = ;
752:             (THIS.this_nTotIte + THIS.this_nValDesc + THIS.this_nPDescs = 0) ;
753:             AND (THIS.this_cTipo != "X")
754: 
755:         THIS.this_oBusinessObject.this_lSoMotivo = THIS.this_lSoMotivo
756:     ENDPROC
757: 
758:     *--------------------------------------------------------------------------
759:     * AplicarTabIndex - ordem de tabulacao do SCX
760:     *
761:     * Dump: get_Motivo=1  usuario=2  senha=3  Frase=4  Say2=5  Say1=6  Say3=7
762:     *
763:     * Numerar SO os FOCALIZAVEIS: Label tem TabIndex mas nao tem TabStop - nao
764:     * recebe foco -, entao transcrever o TabIndex dos quatro labels eh inerte
765:     * e ainda embaralharia a sequencia dos tres campos. Atribuir em ordem
766:     * ASCENDENTE: cada atribuicao poe o controle na posicao pedida e empurra
767:     * os demais para tras.
768:     *
769:     * Tem de rodar depois de TODOS os AddObject - por isso eh metodo proprio,
770:     * e nao linhas no fim de ConfigurarCampos.
771:     *--------------------------------------------------------------------------
772:     PROTECTED PROCEDURE AplicarTabIndex()
773:         THIS.txt_4c__Motivo.TabIndex = 1
774:         THIS.txt_4c_Usuario.TabIndex = 2
775:         THIS.txt_4c_Senha.TabIndex   = 3
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * VincularEventos - liga os Valid do legado aos handlers do form
780:     *
781:     * O Valid do legado dispara ao SAIR do campo, logo vai em "LostFocus"
782:     * (regra #47). Ligado a "KeyPress" sem testar a tecla, o picker subiria a
783:     * CADA caractere digitado e o usuario nao conseguiria terminar o codigo.
784:     *
785:     * F4/F5 e duplo clique NAO estao no dump - o legado so abre o browse pelo
786:     * proprio Valid. Sao os atalhos canonicos do sistema novo para o MESMO
787:     * funil (AbrirBusca*) e sao ADITIVOS: nao mudam nada do que o Valid faz,
788:     * so dao ao usuario uma segunda porta para o picker que ele ja veria.
789:     * O KeyPress TEM guarda de tecla, justamente para nao recair na regra #47.
790:     *
791:     * senha NAO recebe lookup: nao ha universo a escolher (a senha eh
792:     * conferida, nao selecionada) - so o Valid.
793:     *--------------------------------------------------------------------------
794:     PROTECTED PROCEDURE VincularEventos()
795:         BINDEVENT(THIS.txt_4c__Motivo, "LostFocus", THIS, "ValidarMotivo")
796:         BINDEVENT(THIS.txt_4c__Motivo, "KeyPress",  THIS, "MotivoKeyPress")
797:         BINDEVENT(THIS.txt_4c__Motivo, "DblClick",  THIS, "MotivoDblClick")
798: 
799:         BINDEVENT(THIS.txt_4c_Usuario, "LostFocus", THIS, "ValidarUsuario")
800:         BINDEVENT(THIS.txt_4c_Usuario, "KeyPress",  THIS, "UsuarioKeyPress")
801:         BINDEVENT(THIS.txt_4c_Usuario, "DblClick",  THIS, "UsuarioDblClick")
802: 
803:         BINDEVENT(THIS.txt_4c_Senha,   "LostFocus", THIS, "ValidarSenha")
804:     ENDPROC
805: 
806:     *--------------------------------------------------------------------------
807:     * AplicarRegrasDeExibicao - bloco de visibilidade do Init legado
808:     *
809:     * Legado (SIGOPLIM.Init), transcrito:
810:     *
811:     *   Caption = "Limite Ultrapassado..."
812:     *   cntSombra.lblSombra.Caption = Caption
813:     *   cntSombra.lblTitulo.Caption = Caption
814:     *   If Tipo = 'L'                       && senha livre
815:     *       Say1/Get_Motivo/Say2/Usuario -> .F.   Say3/senha -> .T.
816:     *   Else
817:     *       If somotivo
818:     *           Frase = "Informe Motivo para liberacao :"
819:     *           Say2/Usuario -> .F.
820:     *       Else
821:     *           If Motivo
822:     *               Frase = "Informe usuario c/ acesso a liberacao e Motivo:"
823:     *           Else
824:     *               Frase = "Informe usuario c/ acesso a liberacao :"
825:     *               Say1/Get_Motivo -> .F.
826:     *           EndIf
827:     *       EndIf
828:     *   Endif
829:     *
830:     * PUBLIC de proposito: o chamador pode reabrir o dialogo reatribuindo os
831:     * parametros, e esta eh a unica porta para reaplicar as regras. Por ser o
832:     * FUNIL DE REENTRADA, eh aqui que o estado de encerramento eh zerado - sem
833:     * isso o segundo Show() abriria uma tela com this_lEncerrando ainda em .T.,
834:     * ou seja com TODAS as validacoes mortas (os wrappers devolvem na primeira
835:     * linha) e carregando o resultado da rodada anterior.
836:     *--------------------------------------------------------------------------
837:     PROCEDURE AplicarRegrasDeExibicao()
838:         THIS.this_lEncerrando      = .F.
839:         THIS.this_lEmLookupUsuario = .F.
840:         THIS.this_lEmLookupMotivo  = .F.
841:         THIS.this_lEmValidarSenha  = .F.
842:         THIS.this_uZSenha          = .F.
843: 
844:         *-- Campos e estado da rodada anterior (este metodo eh o FUNIL DE
845:         *-- REENTRADA): sem isto o segundo Show() nasce com o usuario e a
846:         *-- senha do autorizador anterior ainda carregados no BO.
847:         THIS.LimparCampos()
848: 
849:         THIS.Caption = "Limite Ultrapassado..."
850:         THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
851:         THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
852: 
853:         IF THIS.this_cTipo = "L"
854:             THIS.lbl_4c_Label1.Visible  = .F.
855:             THIS.txt_4c__Motivo.Visible = .F.
856:             THIS.lbl_4c_Label2.Visible  = .F.
857:             THIS.txt_4c_Usuario.Visible = .F.
858:             THIS.lbl_4c_Label3.Visible  = .T.
859:             THIS.txt_4c_Senha.Visible   = .T.
860:         ELSE
861:             *-- Say3/senha nascem Visible = .F. no SCX e so aparecem no fim de
862:             *-- usuario.Valid (ValidarUsuarioExec). Aqui so se desfaz o
863:             *-- Visible = .T. que TornarControlesVisiveis acabou de forcar.
864:             THIS.lbl_4c_Label3.Visible = .F.
865:             THIS.txt_4c_Senha.Visible  = .F.
866: 
867:             IF THIS.this_lSoMotivo
868:                 THIS.lbl_4c_Frase.Caption = "Informe Motivo para libera" + ;
869:                     CHR(231) + CHR(227) + "o :"
870:                 THIS.lbl_4c_Label2.Visible  = .F.
871:                 THIS.txt_4c_Usuario.Visible = .F.
872:             ELSE
873:                 IF THIS.this_lMotivo
874:                     THIS.lbl_4c_Frase.Caption = "Informe usuario c/ acesso a libera" + ;
875:                         CHR(231) + CHR(227) + "o e Motivo:"
876:                 ELSE
877:                     THIS.lbl_4c_Frase.Caption = "Informe usuario c/ acesso a libera" + ;
878:                         CHR(231) + CHR(227) + "o :"
879:                     THIS.lbl_4c_Label1.Visible  = .F.
880:                     THIS.txt_4c__Motivo.Visible = .F.
881:                 ENDIF
882:             ENDIF
883:         ENDIF
884: 
885:         *-- Gates do legado (os When dos campos), reproduzidos como Enabled.
886:         *-- Pelo ponto unico, para nao haver duas listas de campos a
887:         *-- divergir (HabilitarCampos delega aos dois metodos de gate).
888:         THIS.HabilitarCampos(.T.)
889:     ENDPROC
890: 
891:     *--------------------------------------------------------------------------
892:     * ValidarAcessoMotivo - Legado: get_Motivo.When -> Return (ThisForm.Motivo)
893:     *
894:     * BINDEVENT em "When" nao dispara de forma confiavel em TextBox. Como
895:     * ThisForm.Motivo eh fixado no Init e NUNCA muda durante a vida do
896:     * dialogo, o gate equivale a Enabled - que nao depende de evento nenhum.
897:     *
898:     * Diferenca visual aceita e declarada: campo com When = .F. no legado
899:     * continua branco (so nao recebe foco); com Enabled = .F. ele usa o
900:     * DisabledBackColor da propria classe fwget (192,192,192) e fica cinza.
901:     * Em troca, o gate eh deterministico em vez de depender de um evento que
902:     * o VFP9 nao entrega por BINDEVENT.
903:     *--------------------------------------------------------------------------
904:     PROCEDURE ValidarAcessoMotivo()
905:         THIS.txt_4c__Motivo.Enabled = THIS.this_lMotivo
906:     ENDPROC
907: 
908:     *--------------------------------------------------------------------------
909:     * ValidarAcessoSenha - Legado: senha.When ->
910:     *     Return (!Empty(ThisForm.Usuario.Value) Or Thisform.Tipo = 'L')
911:     *
912:     * Este gate MUDA em runtime (depende de Usuario.Value), por isso eh
913:     * reavaliado no fim de ValidarUsuarioExec - exatamente o momento em que o
914:     * usuario autorizador passa a estar preenchido.
915:     *--------------------------------------------------------------------------
916:     PROCEDURE ValidarAcessoSenha()
917:         THIS.txt_4c_Senha.Enabled = ;
918:             (!EMPTY(ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, ""))) ;
919:              OR THIS.this_cTipo = "L")
920:     ENDPROC
921: 
922:     *--------------------------------------------------------------------------
923:     * ValidarMotivo - wrapper do Valid de get_Motivo (ligado a "LostFocus")
924:     *
925:     * Wrapper fino + <Nome>Exec (regra #47): o corpo tem RETURN antecipado,
926:     * entao a liberacao da flag TEM de ficar aqui - dentro do corpo ela
927:     * ficaria presa em .T. e o lookup morreria para o resto da vida do form.
928:     *--------------------------------------------------------------------------
929:     PROCEDURE ValidarMotivo()
930:         IF THIS.this_lEncerrando OR THIS.this_lEmLookupMotivo
931:             RETURN
932:         ENDIF
933: 
934:         THIS.this_lEmLookupMotivo = .T.
935:         THIS.ValidarMotivoExec()
936:         THIS.this_lEmLookupMotivo = .F.
937:     ENDPROC
938: 
939:     *--------------------------------------------------------------------------
940:     * ValidarMotivoExec - corpo do get_Motivo.Valid legado
941:     *
942:     * Legado (SIGOPLIM.get_Motivo.Valid), transcrito:
943:     *
944:     *   If Not IsEmpty(This.Value)
945:     *       <monta LocalMdsc1 / LocalMdsc / TmpMdsc>   = BO.BuscarMotivos()
946:     *       If SqlExecute < 1 -> MessageBox 'Favor Reinicializar o Processo!!!'
947:     *       Select TmpMdsc ; Index on Codigos Tag Codigos
948:     *       If !Seek(This.Value,'TmpMdsc','Codigos')
949:     *           fwBuscaSel('TmpMdsc','codigos',...)    = AbrirBuscaMotivo()
950:     *           This.Value = TmpMdsc.Codigos
951:     *       Endif
952:     *       If Lastkey() = 27 -> Zsenha = .F. ; release
953:     *       Else
954:     *           If somotivo -> Zsenha = Space(10) + This.Value ; Release
955:     *       EndIf
956:     *   Else
957:     *       Resp = Messagebox('Motivo nao Informado!, Deseja Continuar ? (S/N)',
958:     *                          4+256, '')
959:     *       If Resp = 7 -> Zsenha = .F. ; release   Else return 0
960:     *   EndIf
961:     *
962:     * SEEK com PADR ate a largura REAL da coluna (FSIZE), nao com o valor cru.
963:     * Medido no VFP9 nesta sessao: SEEK com chave CURTA nao falha - ele casa
964:     * por PREFIXO (e isso independe de SET EXACT, que governa o operador "=",
965:     * nao o SEEK). O defeito seria pior que falhar: quem digitasse "7" casaria
966:     * com o motivo "70" e o dialogo autorizaria o codigo ERRADO, em silencio.
967:     * Com PADR ate a largura da coluna a chave tem o tamanho da chave do
968:     * indice e o match volta a ser exato.
969:     *
970:     * O picker cancelado eh o "Lastkey() = 27" do legado: nada escolhido =
971:     * desistiu = nega e encerra. NAO se exibe aviso nem se apaga o codigo
972:     * digitado (regras #37 e #50).
973:     *--------------------------------------------------------------------------
974:     PROTECTED PROCEDURE ValidarMotivoExec()
975:         LOCAL loc_cValor, loc_cCursor, loc_lAchou, loc_oErro
976: 
977:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c__Motivo.Value, ""))
978: 
979:         IF EMPTY(loc_cValor)
980:             *-- Legado: Resp = 7 (Nao) -> nega e encerra; Sim -> "return 0",
981:             *-- que recusava sair do campo (aqui: devolve o foco a ele).
982:             IF MsgConfirma("Motivo n" + CHR(227) + "o Informado!, Deseja Continuar ? (S/N)", "")
983:                 THIS.txt_4c__Motivo.SetFocus()
984:             ELSE
985:                 THIS.FecharDialogo(.F.)
986:             ENDIF
987:             RETURN
988:         ENDIF
989: 
990:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorMotivos
991:         loc_lAchou  = .F.
992: 
993:         TRY
994:             IF THIS.this_oBusinessObject.BuscarMotivos()
995:                 *-- BuscarMotivos ja fecha com INDEX ON codigos TAG codigos
996:                 IF USED(loc_cCursor)
997:                     SELECT (loc_cCursor)
998:                     loc_lAchou = SEEK(PADR(loc_cValor, FSIZE("codigos", loc_cCursor)), ;
999:                         loc_cCursor, "codigos")
1000:                 ENDIF
1001: 
1002:                 IF !loc_lAchou
1003:                     THIS.AbrirBuscaMotivo()
1004: 
1005:                     loc_cValor = ALLTRIM(NVL(THIS.txt_4c__Motivo.Value, ""))
1006:                     IF USED(loc_cCursor) AND !EMPTY(loc_cValor)
1007:                         SELECT (loc_cCursor)
1008:                         loc_lAchou = SEEK(PADR(loc_cValor, FSIZE("codigos", loc_cCursor)), ;
1009:                             loc_cCursor, "codigos")
1010:                     ENDIF
1011:                 ENDIF
1012: 
1013:                 IF loc_lAchou
1014:                     THIS.this_oBusinessObject.CarregarMotivoDoCursor(loc_cCursor)

*-- Linhas 1045 a 1188:
1045:         CATCH TO loc_oErro
1046:             MsgErro(loc_oErro.Message + CHR(13) + ;
1047:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1048:                 "Procedure: " + loc_oErro.Procedure, ;
1049:                 "Erro ao validar o Motivo")
1050:         ENDTRY
1051:     ENDPROC
1052: 
1053:     *--------------------------------------------------------------------------
1054:     * AbrirBuscaMotivo - picker de motivos (legado: fwBuscaSel sobre TmpMdsc)
1055:     *
1056:     * fwBuscaSel busca em CURSOR LOCAL ja populado, nao em tabela: por isso o
1057:     * FormBuscaAuxiliar eh usado pela API de cursor pre-populado
1058:     * (CREATEOBJECT sem parametros + DefinirCursor + Mostrar), nunca pelo Init
1059:     * com parametros - esse faz SQLEXEC proprio contra uma TABELA e abriria o
1060:     * picker VAZIO, alem de ignorar os filtros de Emps/ClaConta que o BO ja
1061:     * aplicou.
1062:     *
1063:     * O cursor NAO eh fechado aqui: ValidarMotivoExec faz o SEEK nele logo
1064:     * depois, e o ciclo de vida dele eh do BO (BuscarMotivos fecha e recria).
1065:     *--------------------------------------------------------------------------
1066:     PROCEDURE AbrirBuscaMotivo()
1067:         LOCAL loc_oBusca, loc_cCursor, loc_lEmLookupAnt, loc_oErro
1068: 
1069:         IF THIS.this_lEncerrando
1070:             RETURN
1071:         ENDIF
1072: 
1073:         *-- save/restore, nao set/clear: este metodo eh chamado de DENTRO de
1074:         *-- ValidarMotivoExec (que ja ligou a flag) e tambem direto pelo F4 e
1075:         *-- pelo duplo clique. Um clear simples liberaria a flag cedo demais
1076:         *-- no primeiro caso (regra #47).
1077:         loc_lEmLookupAnt = THIS.this_lEmLookupMotivo
1078:         THIS.this_lEmLookupMotivo = .T.
1079: 
1080:         TRY
1081:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorMotivos
1082: 
1083:             IF !USED(loc_cCursor)
1084:                 THIS.this_oBusinessObject.BuscarMotivos()
1085:             ENDIF
1086: 
1087:             IF USED(loc_cCursor)
1088:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1089: 
1090:                 IF VARTYPE(loc_oBusca) = "O"
1091:                     loc_oBusca.this_cCursorDestino = loc_cCursor
1092:                     loc_oBusca.DefinirCursor(loc_cCursor, "codigos", "descrs", ;
1093:                         "Cadastro de Motivos")
1094: 
1095:                     *-- DefinirCursor usa o NOME do campo como caption; o
1096:                     *-- legado usa AddColuna('Codigos','','Codigo') e
1097:                     *-- AddColuna('Descrs','','Descricao'). Refaz as colunas
1098:                     *-- com os titulos do legado (PILAR 1).
1099:                     loc_oBusca.this_nColunas = 0
1100:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1101:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1102: 
1103:                     IF loc_oBusca.Mostrar()
1104:                         *-- Atribui SO sob a guarda de selecao (regra #37):
1105:                         *-- fora dela, cancelar ZERARIA o codigo digitado.
1106:                         IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1107:                             THIS.txt_4c__Motivo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1108:                         ENDIF
1109:                     ENDIF
1110: 
1111:                     loc_oBusca.Release()
1112:                 ENDIF
1113:             ELSE
1114:                 MsgErro("Favor Reinicializar o Processo!!!", ;
1115:                     "Falha na Conex" + CHR(227) + "o (Motivos)")
1116:             ENDIF
1117: 
1118:         CATCH TO loc_oErro
1119:             MsgErro(loc_oErro.Message + CHR(13) + ;
1120:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1121:                 "Procedure: " + loc_oErro.Procedure, ;
1122:                 "Erro ao abrir a busca de Motivos")
1123:         ENDTRY
1124: 
1125:         THIS.this_lEmLookupMotivo = loc_lEmLookupAnt
1126:     ENDPROC
1127: 
1128:     *--------------------------------------------------------------------------
1129:     * MotivoKeyPress / MotivoDblClick - atalhos para o MESMO funil do picker
1130:     *
1131:     * A guarda de tecla eh OBRIGATORIA (regra #47): sem ela o picker abriria a
1132:     * cada caractere e o usuario nao conseguiria terminar de digitar o codigo.
1133:     * F4 = 115, F5 = 116.
1134:     *--------------------------------------------------------------------------
1135:     PROCEDURE MotivoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1136:         IF INLIST(par_nKeyCode, 115, 116)
1137:             THIS.AbrirBuscaMotivo()
1138:         ENDIF
1139:     ENDPROC
1140: 
1141:     PROCEDURE MotivoDblClick()
1142:         THIS.AbrirBuscaMotivo()
1143:     ENDPROC
1144: 
1145:     *--------------------------------------------------------------------------
1146:     * ValidarUsuario - wrapper do Valid de usuario (ligado a "LostFocus")
1147:     *--------------------------------------------------------------------------
1148:     PROCEDURE ValidarUsuario()
1149:         IF THIS.this_lEncerrando OR THIS.this_lEmLookupUsuario
1150:             RETURN
1151:         ENDIF
1152: 
1153:         THIS.this_lEmLookupUsuario = .T.
1154:         THIS.ValidarUsuarioExec()
1155:         THIS.this_lEmLookupUsuario = .F.
1156:     ENDPROC
1157: 
1158:     *--------------------------------------------------------------------------
1159:     * ValidarUsuarioExec - corpo do usuario.Valid legado
1160:     *
1161:     * Legado (SIGOPLIM.usuario.Valid), transcrito:
1162:     *
1163:     *   If !IsEmpty(This.Value)
1164:     *       <Do Case por Tipo -> TmpUsu>   = BO.BuscarUsuariosAutorizados()
1165:     *       If SqlExecute < 1 -> MessageBox 'Favor Reinicializar o Processo!!!'
1166:     *       Select TmpUsu ; Index on usuarios Tag usuarios
1167:     *       If !Seek(This.Value,'TmpUsu','Usuarios')
1168:     *           fwBuscaSel('TmpUsu','Usuarios',...)   = AbrirBuscaUsuario()
1169:     *           This.Value = TmpUsu.Usuarios
1170:     *       Endif
1171:     *       Usual = This.Value
1172:     *       If IsEmpty(usual) Or Lastkey() = 27 -> Zsenha = .F. ; release
1173:     *       Select TmpUsu
1174:     *       If limdescs = "S" And Tipo <> [X]
1175:     *           zsen  = padr(ThisForm.GeraSenha(date()),06)
1176:     *           zsen1 = fCriptografar(senhas)
1177:     *       else
1178:     *           zsen  = fCriptografar(senhas)
1179:     *       endif
1180:     *       thisform.say3.visible  = .t.
1181:     *       thisform.senha.visible = .t.
1182:     *   Else
1183:     *       ThisForm.zSenha = .f. ; ThisForm.Release
1184:     *   EndIf
1185:     *
1186:     * O BLOCO zsen/zsen1 NAO eh reproduzido, e a omissao eh deliberada - sao
1187:     * DEAD STORES no proprio legado: nem zsen nem zsen1 sao lidos em lugar
1188:     * nenhum do SCX (senha.Valid recalcula a senha do zero com

*-- Linhas 1199 a 1242:
1199:     * A conferencia REAL da senha fica onde o legado tambem a faz: em
1200:     * senha.Valid -> SigOpLimBO.ValidarSenhaUsuario().
1201:     *--------------------------------------------------------------------------
1202:     PROTECTED PROCEDURE ValidarUsuarioExec()
1203:         LOCAL loc_cValor, loc_cCursor, loc_lAchou, loc_oErro
1204: 
1205:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, ""))
1206: 
1207:         IF EMPTY(loc_cValor)
1208:             *-- Legado (ramo Else): ThisForm.zSenha = .f. / ThisForm.Release
1209:             THIS.FecharDialogo(.F.)
1210:             RETURN
1211:         ENDIF
1212: 
1213:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorUsuarios
1214:         loc_lAchou  = .F.
1215: 
1216:         TRY
1217:             IF THIS.this_oBusinessObject.BuscarUsuariosAutorizados()
1218:                 *-- BuscarUsuariosAutorizados ja fecha com
1219:                 *-- INDEX ON usuarios TAG usuarios
1220:                 IF USED(loc_cCursor)
1221:                     SELECT (loc_cCursor)
1222:                     loc_lAchou = SEEK(PADR(loc_cValor, FSIZE("usuarios", loc_cCursor)), ;
1223:                         loc_cCursor, "usuarios")
1224:                 ENDIF
1225: 
1226:                 IF !loc_lAchou
1227:                     THIS.AbrirBuscaUsuario()
1228: 
1229:                     loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, ""))
1230:                     IF USED(loc_cCursor) AND !EMPTY(loc_cValor)
1231:                         SELECT (loc_cCursor)
1232:                         loc_lAchou = SEEK(PADR(loc_cValor, FSIZE("usuarios", loc_cCursor)), ;
1233:                             loc_cCursor, "usuarios")
1234:                     ENDIF
1235:                 ENDIF
1236: 
1237:                 IF loc_lAchou
1238:                     *-- Legado: Select TmpUsu (a linha do autorizador fica
1239:                     *-- corrente e senha.Valid le TmpUsu.senhas/.usuarios)
1240:                     THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
1241: 
1242:                     *-- Legado: thisform.say3.visible  = .t.

*-- Linhas 1267 a 1811:
1267:         CATCH TO loc_oErro
1268:             MsgErro(loc_oErro.Message + CHR(13) + ;
1269:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1270:                 "Procedure: " + loc_oErro.Procedure, ;
1271:                 "Erro ao validar o Usu" + CHR(225) + "rio")
1272:         ENDTRY
1273:     ENDPROC
1274: 
1275:     *--------------------------------------------------------------------------
1276:     * AbrirBuscaUsuario - picker de autorizadores (legado: fwBuscaSel sobre
1277:     * TmpUsu, com AddColuna('Usuarios','','Codigo') e
1278:     * AddColuna('CCargs','','Cargo'))
1279:     *
1280:     * Mesma API de cursor pre-populado do AbrirBuscaMotivo. O universo aqui
1281:     * NAO eh "todos os usuarios" - eh so quem tem alcada para o valor e o
1282:     * percentual pedidos (o Do Case por Tipo do BO). Trocar por um SELECT
1283:     * direto em SigCdUsu mostraria usuarios sem alcada e deixaria o dialogo
1284:     * autorizar o que o legado recusa.
1285:     *--------------------------------------------------------------------------
1286:     PROCEDURE AbrirBuscaUsuario()
1287:         LOCAL loc_oBusca, loc_cCursor, loc_lEmLookupAnt, loc_oErro
1288: 
1289:         IF THIS.this_lEncerrando
1290:             RETURN
1291:         ENDIF
1292: 
1293:         loc_lEmLookupAnt = THIS.this_lEmLookupUsuario
1294:         THIS.this_lEmLookupUsuario = .T.
1295: 
1296:         TRY
1297:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorUsuarios
1298: 
1299:             IF !USED(loc_cCursor)
1300:                 THIS.this_oBusinessObject.BuscarUsuariosAutorizados()
1301:             ENDIF
1302: 
1303:             IF USED(loc_cCursor)
1304:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1305: 
1306:                 IF VARTYPE(loc_oBusca) = "O"
1307:                     loc_oBusca.this_cCursorDestino = loc_cCursor
1308:                     loc_oBusca.DefinirCursor(loc_cCursor, "usuarios", "ccargs", ;
1309:                         "Cadastro de Usu" + CHR(225) + "rios")
1310: 
1311:                     loc_oBusca.this_nColunas = 0
1312:                     loc_oBusca.mAddColuna("usuarios", "", "C" + CHR(243) + "digo")
1313:                     loc_oBusca.mAddColuna("ccargs",   "", "Cargo")
1314: 
1315:                     IF loc_oBusca.Mostrar()
1316:                         IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1317:                             THIS.txt_4c_Usuario.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1318:                         ENDIF
1319:                     ENDIF
1320: 
1321:                     loc_oBusca.Release()
1322:                 ENDIF
1323:             ELSE
1324:                 MsgErro("Favor Reinicializar o Processo!!!", ;
1325:                     "Falha na Conex" + CHR(227) + "o (Usu" + CHR(225) + "rios)")
1326:             ENDIF
1327: 
1328:         CATCH TO loc_oErro
1329:             MsgErro(loc_oErro.Message + CHR(13) + ;
1330:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1331:                 "Procedure: " + loc_oErro.Procedure, ;
1332:                 "Erro ao abrir a busca de Usu" + CHR(225) + "rios")
1333:         ENDTRY
1334: 
1335:         THIS.this_lEmLookupUsuario = loc_lEmLookupAnt
1336:     ENDPROC
1337: 
1338:     PROCEDURE UsuarioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1339:         IF INLIST(par_nKeyCode, 115, 116)
1340:             THIS.AbrirBuscaUsuario()
1341:         ENDIF
1342:     ENDPROC
1343: 
1344:     PROCEDURE UsuarioDblClick()
1345:         THIS.AbrirBuscaUsuario()
1346:     ENDPROC
1347: 
1348:     *--------------------------------------------------------------------------
1349:     * ValidarSenha - wrapper do Valid de senha (ligado a "LostFocus")
1350:     *
1351:     * senha eh um dos campos que ESTA fase cria: entregar a caixa de senha sem
1352:     * o Valid dela deixaria o dialogo com a acao principal do usuario sem
1353:     * efeito nenhum - e, como o form compila e abre, nenhum outro gate pegaria.
1354:     *--------------------------------------------------------------------------
1355:     PROCEDURE ValidarSenha()
1356:         IF THIS.this_lEncerrando OR THIS.this_lEmValidarSenha
1357:             RETURN
1358:         ENDIF
1359: 
1360:         THIS.this_lEmValidarSenha = .T.
1361:         THIS.ValidarSenhaExec()
1362:         THIS.this_lEmValidarSenha = .F.
1363:     ENDPROC
1364: 
1365:     *--------------------------------------------------------------------------
1366:     * ValidarSenhaExec - corpo do senha.Valid legado
1367:     *
1368:     * Legado (SIGOPLIM.senha.Valid), transcrito:
1369:     *
1370:     *   If Thisform.Tipo = 'L'                     && senha livre
1371:     *       Select ... From SigPrSnd Where SenhaDs = <valor>
1372:     *       If Eof -> 'Senha invalida.' ; Zsenha = .F. ; release
1373:     *       If !Empty(EmpDopNums) -> 'Senha ja utilizada.' ; Zsenha=.F. ; release
1374:     *       lcEDN = TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)
1375:     *       Update SigPrSnd Set EmpDopNums = lcEDN Where CidChaves = ...
1376:     *       ThisForm.Zsenha = Usuar ; release
1377:     *   Else
1378:     *       Senha = fCriptografar(TmpUsu.senhas)
1379:     *       If Padr(this.value,10) <> Padr(senha,10)
1380:     *           resp = messagebox('Senha Conflitante. Deseja Continuar?',4+256,'Aviso')
1381:     *           if resp = 7 -> Zsenha = .F. ; release   else return 0
1382:     *       Else
1383:     *           Zsenha = Iif(Tipo = [X], Usuario.Value,
1384:     *                        TmpUsu.Usuarios + Get_motivo.Value)
1385:     *           release
1386:     *       Endif
1387:     *   Endif
1388:     *
1389:     * Os tres ramos de composicao do retorno moram no BO
1390:     * (ComporAutorizacaoSenhaLivre / ComporAutorizacaoUsuarioSenha, mais
1391:     * ComporAutorizacaoSoMotivo usado por get_Motivo.Valid) - fonte unica,
1392:     * PILAR 3.
1393:     *--------------------------------------------------------------------------
1394:     PROTECTED PROCEDURE ValidarSenhaExec()
1395:         LOCAL loc_cValor, loc_cMsgBO, loc_oErro
1396: 
1397:         *-- Ponto UNICO de leitura dos campos (regra: a normalizacao mora
1398:         *-- em FormParaBO, nao repetida em cada call site). Falhando, ABORTA
1399:         *-- antes de tocar o BO - autorizacao pela metade seria pior que
1400:         *-- nenhuma. O RETURN fica FORA do TRY (regra #1).
1401:         IF !THIS.FormParaBO()
1402:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler os " + ;
1403:                 "campos do di" + CHR(225) + "logo.", "Erro ao validar a Senha")
1404:             RETURN
1405:         ENDIF
1406: 
1407:         loc_cValor = THIS.this_oBusinessObject.this_cSenhaDigitada
1408: 
1409:         TRY
1410:             IF THIS.this_cTipo = "L"
1411:                 IF THIS.this_oBusinessObject.ValidarEConsumirSenhaLivre(loc_cValor, ;
1412:                         THIS.MontarEmpDopNumsMovimento())
1413:                     THIS.this_oBusinessObject.ComporAutorizacaoSenhaLivre()
1414:                     THIS.FecharDialogo(.T.)
1415:                 ELSE
1416:                     *-- Legado: Messagebox(...,48,'Senha livre') nos dois
1417:                     *-- motivos de recusa ('Senha invalida.' / 'Senha ja
1418:                     *-- utilizada.'), que o BO ja distingue na mensagem.
1419:                     loc_cMsgBO = ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro)
1420:                     MsgAviso(IIF(EMPTY(loc_cMsgBO), ;
1421:                         "Senha inv" + CHR(225) + "lida.", loc_cMsgBO), "Senha livre")
1422:                     THIS.FecharDialogo(.F.)
1423:                 ENDIF
1424:             ELSE
1425:                 IF THIS.this_oBusinessObject.ValidarSenhaUsuario(loc_cValor)
1426:                     *-- Legado: Zsenha = Iif(Tipo = [X], Usuario.Value,
1427:                     *--                          TmpUsu.Usuarios + Get_motivo.Value)
1428:                     *-- Os DOIS argumentos sao o que esta DIGITADO; quem decide
1429:                     *-- usar o do cursor (TmpUsu.Usuarios) no ramo Else eh o
1430:                     *-- proprio BO, que ja tem this_cUsuarios.
1431:                     THIS.this_oBusinessObject.ComporAutorizacaoUsuarioSenha( ;
1432:                         THIS.this_oBusinessObject.this_cUsuarioDigitado, ;
1433:                         THIS.this_oBusinessObject.this_cMotivoDigitado)
1434:                     THIS.FecharDialogo(.T.)
1435:                 ELSE
1436:                     *-- ValidarSenhaUsuario devolve .F. por DOIS motivos
1437:                     *-- diferentes: senha que nao casa (this_cMensagemErro =
1438:                     *-- "Senha Conflitante.", literal definido no proprio BO) e
1439:                     *-- falha TECNICA capturada pelo CATCH dele - tipicamente
1440:                     *-- fCriptografar() ausente (regra #27). Disfarcar a falha
1441:                     *-- tecnica de "senha conflitante" esconderia o defeito
1442:                     *-- real atras de uma pergunta que o usuario responde
1443:                     *-- "Sim" e segue tentando para sempre.
1444:                     loc_cMsgBO = ALLTRIM(THIS.this_oBusinessObject.this_cMensagemErro)
1445: 
1446:                     IF loc_cMsgBO == "Senha Conflitante."
1447:                         IF MsgConfirma("Senha Conflitante. Deseja Continuar?", "Aviso")
1448:                             *-- Legado: "return 0" - recusa sair do campo
1449:                             THIS.txt_4c_Senha.SetFocus()
1450:                         ELSE
1451:                             THIS.FecharDialogo(.F.)
1452:                         ENDIF
1453:                     ELSE
1454:                         MsgErro(IIF(EMPTY(loc_cMsgBO), ;
1455:                             "N" + CHR(227) + "o foi poss" + CHR(237) + ;
1456:                             "vel conferir a senha.", loc_cMsgBO), ;
1457:                             "Erro ao conferir a senha")
1458:                         THIS.FecharDialogo(.F.)
1459:                     ENDIF
1460:                 ENDIF
1461:             ENDIF
1462: 
1463:         CATCH TO loc_oErro
1464:             MsgErro(loc_oErro.Message + CHR(13) + ;
1465:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1466:                 "Procedure: " + loc_oErro.Procedure, ;
1467:                 "Erro ao validar a Senha")
1468:         ENDTRY
1469:     ENDPROC
1470: 
1471:     *--------------------------------------------------------------------------
1472:     * MontarEmpDopNumsMovimento - chave do movimento que consome a senha livre
1473:     *
1474:     * Legado: lcEDN = TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)
1475:     *
1476:     * Chave POSICIONAL (regra #42): o padding FAZ PARTE da chave. Emps char(3)
1477:     * + Dopes char(20) + STR(Numes,6) = 29 = SigPrSnd.EmpDopNums char(29) -
1478:     * conferido no docs/schema.sql. PADR em CADA parte; ALLTRIM nas partes
1479:     * encurtaria a chave e o UPDATE casaria a linha errada (ou nenhuma).
1480:     *
1481:     * TprMvCab eh cursor GLOBAL do form chamador (Fortyus), que este dialogo
1482:     * nao possui. Ausente, devolve vazio - e o BO gravaria EmpDopNums em
1483:     * branco, que para o legado significa "senha ainda disponivel", ou seja a
1484:     * senha seria aceita e continuaria reutilizavel. Por isso o retorno vazio
1485:     * NAO eh silencioso: quem chamar com Tipo = "L" sem TprMvCab aberto recebe
1486:     * o aviso.
1487:     *--------------------------------------------------------------------------
1488:     PROTECTED FUNCTION MontarEmpDopNumsMovimento()
1489:         LOCAL loc_cChave
1490: 
1491:         loc_cChave = ""
1492: 
1493:         IF USED("TprMvCab")
1494:             IF !EOF("TprMvCab")
1495:                 loc_cChave = PADR(NVL(TprMvCab.Emps, ""), 3) + ;
1496:                     PADR(NVL(TprMvCab.Dopes, ""), 20) + ;
1497:                     STR(NVL(TprMvCab.Numes, 0), 6)
1498:             ENDIF
1499:         ENDIF
1500: 
1501:         IF EMPTY(loc_cChave)
1502:             MsgAviso("Movimento n" + CHR(227) + "o identificado: a senha ser" + ;
1503:                 CHR(225) + " consumida sem v" + CHR(237) + "nculo com documento.", ;
1504:                 "Senha livre")
1505:         ENDIF
1506: 
1507:         RETURN loc_cChave
1508:     ENDFUNC
1509: 
1510:     *--------------------------------------------------------------------------
1511:     * FecharDialogo - UNICA saida do dialogo
1512:     *
1513:     * Fecha com Hide(), NUNCA com Release(): o chamador le o resultado DEPOIS
1514:     * de o Show() retornar, e Release() destroi o objeto na hora (form nao
1515:     * segue refcount) - a leitura seguinte estouraria "is not an object", num
1516:     * erro que aparece no CHAMADOR, longe daqui. Mesmo desenho do
1517:     * FormBuscaAuxiliar; quem abriu chama Release() depois de ler.
1518:     *
1519:     * Para o usuario a tela fecha igual (Hide em form modal tambem devolve o
1520:     * Show) - muda so o tempo de vida do objeto, que eh PILAR 3.
1521:     *
1522:     * O resultado eh CACHEADO aqui, ANTES do Hide: Destroy e Unload disparam
1523:     * depois, e nesse momento o BO pode ja ter sido liberado.
1524:     *--------------------------------------------------------------------------
1525:     PROCEDURE FecharDialogo(par_lAutorizado)
1526:         LOCAL loc_lAutorizado
1527: 
1528:         *-- PCOUNT antes de ler o parametro logico: omitido, ele nao chega
1529:         *-- como .F. - chega como tipo indefinido.
1530:         loc_lAutorizado = (PCOUNT() >= 1 AND VARTYPE(par_lAutorizado) = "L" ;
1531:             AND par_lAutorizado)
1532: 
1533:         IF loc_lAutorizado AND VARTYPE(THIS.this_oBusinessObject) = "O"
1534:             THIS.this_uZSenha = THIS.this_oBusinessObject.this_cZSenha
1535:         ELSE
1536:             THIS.this_uZSenha = .F.
1537:         ENDIF
1538: 
1539:         *-- Impede que o LostFocus disparado pelo proprio Hide() reentre na
1540:         *-- validacao e sobrescreva o resultado que o chamador vai ler.
1541:         THIS.this_lEncerrando = .T.
1542: 
1543:         THIS.Hide()
1544:     ENDPROC
1545: 
1546:     *--------------------------------------------------------------------------
1547:     * ObterResultado - ThisForm.zsenha do legado
1548:     *
1549:     * .F.        -> liberacao NEGADA (ou dialogo encerrado sem autorizar)
1550:     * caractere  -> credencial de quem autorizou, no formato do legado:
1551:     *               Tipo "X"   -> usuario digitado
1552:     *               Tipo "L"   -> usuario logado
1553:     *               so motivo  -> Space(10) + codigo do motivo
1554:     *               demais     -> SigCdUsu.usuarios + codigo do motivo
1555:     *
1556:     * Contrato de uso: CREATEOBJECT -> Show() -> ObterResultado() -> Release().
1557:     *--------------------------------------------------------------------------
1558:     FUNCTION ObterResultado()
1559:         RETURN THIS.this_uZSenha
1560:     ENDFUNC
1561: 
1562:     *--------------------------------------------------------------------------
1563:     * Unload - Legado: PROCEDURE Unload / Return ThisForm.zsenha
1564:     *
1565:     * Mantido para quem abrir com DO FORM ... TO <var>, que eh como o legado
1566:     * recebia o resultado. Dispara DEPOIS do Destroy, por isso le a property
1567:     * JA cacheada por FecharDialogo - nunca o BO, que a essa altura foi
1568:     * liberado.
1569:     *--------------------------------------------------------------------------
1570:     PROCEDURE Unload()
1571:         RETURN THIS.this_uZSenha
1572:     ENDPROC
1573: 
1574:     *--------------------------------------------------------------------------
1575:     * FormParaBO - leva os TRES campos digitados para o BO
1576:     *
1577:     * PROTECTED EXPLICITO e obrigatorio: FormBase declara este nome como
1578:     * PROTECTED e em VFP9 a subclasse NAO alarga escopo - escrever
1579:     * "PROCEDURE FormParaBO" nao o torna publico, so mente para quem le.
1580:     * Chamar sempre por THIS. de dentro da classe (regra #8). Num probe
1581:     * headless a chamada de fora NAO devolve erro legivel: abre um Program
1582:     * Error que ninguem fecha e o processo PENDURA ate o timeout, sem uma
1583:     * linha de log - exercitar por uma DEFINE CLASS Probe AS FormSigOpLim,
1584:     * com TRY/CATCH em volta de CADA chamada.
1585:     *
1586:     * Escreve nas properties de ESPELHO (this_cUsuarioDigitado /
1587:     * this_cMotivoDigitado / this_cSenhaDigitada), NUNCA em this_cUsuarios /
1588:     * this_cCodigoMotivo / this_cSenhas, que pertencem ao CURSOR e sao
1589:     * carregadas por CarregarDoCursor / CarregarMotivoDoCursor. O legado le as
1590:     * duas origens no MESMO statement e com significados opostos
1591:     * ("Zsenha = Iif(Tipo = [X], Usuario.Value, TmpUsu.Usuarios + ...)"):
1592:     * sobrescrever as do cursor com o digitado faria o ramo Else devolver quem
1593:     * DIGITOU em vez de quem AUTORIZOU - credencial errada gravada no
1594:     * movimento, sem erro e sem aviso.
1595:     *
1596:     * ALLTRIM aqui, no unico ponto de leitura: os campos tem InputMask de 10
1597:     * "!" e o VFP9 devolve o conteudo PADDED. Os consumidores comparam com
1598:     * PADR(..., 10) ou PADR(..., FSIZE()) de proposito (regra #42 - chave
1599:     * posicional), entao a normalizacao tem de ser UMA so e ficar aqui, nao
1600:     * repetida em cada call site.
1601:     *
1602:     * FUNCTION, nao PROCEDURE: devolve .F. quando o BO nao existe, e quem
1603:     * chama ABORTA - transferencia que falha nao pode deixar o fluxo seguir e
1604:     * autorizar pela metade (corolario da regra #187).
1605:     *--------------------------------------------------------------------------
1606:     PROTECTED FUNCTION FormParaBO()
1607:         LOCAL loc_lSucesso
1608:         loc_lSucesso = .F.
1609: 
1610:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1611:             WITH THIS.this_oBusinessObject
1612:                 .this_cUsuarioDigitado = ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, ""))
1613:                 .this_cMotivoDigitado  = ALLTRIM(NVL(THIS.txt_4c__Motivo.Value, ""))
1614:                 .this_cSenhaDigitada   = ALLTRIM(NVL(THIS.txt_4c_Senha.Value, ""))
1615:             ENDWITH
1616: 
1617:             loc_lSucesso = .T.
1618:         ENDIF
1619: 
1620:         RETURN loc_lSucesso
1621:     ENDFUNC
1622: 
1623:     *--------------------------------------------------------------------------
1624:     * BOParaForm - devolve aos campos o codigo CANONICO que veio do cursor
1625:     *
1626:     * Equivale ao "This.Value = TmpUsu.Usuarios" / "This.Value =
1627:     * TmpMdsc.Codigos" que o legado executa logo depois do browse: o valor que
1628:     * vale eh o do CURSOR, nao o que o usuario tinha digitado.
1629:     *
1630:     * SO escreve quando a property esta PREENCHIDA (regras #37 e #50): no
1631:     * instante em que o motivo eh resolvido, this_cUsuarios ainda esta vazio
1632:     * (o autorizador so eh escolhido depois) - sem a guarda, este metodo
1633:     * APAGARIA o campo Usuario, e o When da senha, que le justamente esse
1634:     * campo, voltaria a .F. travando a tela no meio do fluxo.
1635:     *
1636:     * A SENHA NAO eh escrita de volta, em hipotese nenhuma. Nao eh descuido:
1637:     * this_cSenhas eh a senha GRAVADA do autorizador, lida de SigCdUsu -
1638:     * joga-la no campo faria a tela CONFERIR a credencial contra ela mesma,
1639:     * que eh autorizacao automatica. O legado nunca atribui nada a
1640:     * senha.Value.
1641:     *
1642:     * PROTECTED EXPLICITO - mesmo motivo de FormParaBO.
1643:     *--------------------------------------------------------------------------
1644:     PROTECTED PROCEDURE BOParaForm()
1645:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1646:             RETURN
1647:         ENDIF
1648: 
1649:         IF !EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cUsuarios, "")))
1650:             THIS.txt_4c_Usuario.Value = ;
1651:                 ALLTRIM(THIS.this_oBusinessObject.this_cUsuarios)
1652:         ENDIF
1653: 
1654:         IF !EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCodigoMotivo, "")))
1655:             THIS.txt_4c__Motivo.Value = ;
1656:                 ALLTRIM(THIS.this_oBusinessObject.this_cCodigoMotivo)
1657:         ENDIF
1658:     ENDPROC
1659: 
1660:     *--------------------------------------------------------------------------
1661:     * LimparCampos - zera os tres campos E o estado da rodada no BO
1662:     *
1663:     * Chamado por AplicarRegrasDeExibicao, que eh o FUNIL DE REENTRADA (o
1664:     * chamador pode reabrir o MESMO objeto de dialogo reatribuindo os
1665:     * parametros e dando Show() de novo).
1666:     *
1667:     * Sem esta limpeza a segunda rodada nasce com o usuario e a senha da
1668:     * PRIMEIRA ainda digitados - e isso nao eh cosmetico. O reset do BO
1669:     * (LimparDados) eh o que descarta this_cSenhas, a senha gravada do
1670:     * autorizador anterior; mantida, ela continuaria sendo o ALVO da
1671:     * comparacao de ValidarSenhaUsuario, e a rodada nova seria autorizada com
1672:     * a senha de quem liberou a rodada velha, SEM o novo autorizador ter sido
1673:     * sequer escolhido. Nao estoura, nao entra em log: eh estado que ninguem
1674:     * restaura (mesma familia da regra #40).
1675:     *
1676:     * LimparDados eh PUBLIC na BusinessBase, logo pode ser chamado daqui
1677:     * (regra #51), e preserva os parametros de abertura - so o estado da
1678:     * autorizacao eh zerado.
1679:     *
1680:     * PROTECTED EXPLICITO - mesmo motivo de FormParaBO.
1681:     *--------------------------------------------------------------------------
1682:     PROTECTED PROCEDURE LimparCampos()
1683:         THIS.txt_4c__Motivo.Value = ""
1684:         THIS.txt_4c_Usuario.Value = ""
1685:         THIS.txt_4c_Senha.Value   = ""
1686: 
1687:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1688:             THIS.this_oBusinessObject.LimparDados()
1689:         ENDIF
1690:     ENDPROC
1691: 
1692:     *--------------------------------------------------------------------------
1693:     * HabilitarCampos - ponto unico dos gates de entrada do dialogo
1694:     *
1695:     * PUBLIC de verdade (este nome NAO existe em FormBase, ao contrario dos
1696:     * tres acima): o chamador e o harness alcancam.
1697:     *
1698:     * par_lHabilitar = .T. (default) -> aplica os When do legado
1699:     * par_lHabilitar = .F.           -> trava os tres campos
1700:     *
1701:     * Os When do legado sao DOIS, e um deles muda em runtime:
1702:     *     get_Motivo.When -> Return ( ThisForm.Motivo )
1703:     *     senha.When      -> Return (!Empty(ThisForm.Usuario.Value) Or
1704:     *                                Thisform.Tipo = 'L')
1705:     * usuario NAO tem When no dump - fica sempre habilitado, e eh por isso que
1706:     * ele recebe .T. no ramo de cima em vez de um gate inventado.
1707:     *
1708:     * Delega a ValidarAcessoMotivo/ValidarAcessoSenha em vez de repetir as
1709:     * expressoes: as duas continuam sendo chamadas isoladamente por quem
1710:     * precisa reavaliar UM gate (ValidarUsuarioExec reavalia so o da senha, no
1711:     * instante em que o autorizador passa a estar preenchido), e duplicar a
1712:     * condicao aqui criaria duas versoes da mesma regra para divergirem.
1713:     *
1714:     * PCOUNT antes de ler o parametro logico: omitido, ele nao chega como .F.
1715:     * - chega como tipo indefinido.
1716:     *--------------------------------------------------------------------------
1717:     PROCEDURE HabilitarCampos(par_lHabilitar)
1718:         LOCAL loc_lHabilitar
1719: 
1720:         loc_lHabilitar = .T.
1721:         IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
1722:             loc_lHabilitar = par_lHabilitar
1723:         ENDIF
1724: 
1725:         IF loc_lHabilitar
1726:             THIS.txt_4c_Usuario.Enabled = .T.
1727:             THIS.ValidarAcessoMotivo()
1728:             THIS.ValidarAcessoSenha()
1729:         ELSE
1730:             THIS.txt_4c__Motivo.Enabled = .F.
1731:             THIS.txt_4c_Usuario.Enabled = .F.
1732:             THIS.txt_4c_Senha.Enabled   = .F.
1733:         ENDIF
1734:     ENDPROC
1735: 
1736:     *--------------------------------------------------------------------------
1737:     * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.
1738:     *
1739:     * Recursivo: percorre os filhos diretos do form e desce nos containers.
1740:     * NAO ha lista de excecao aqui de proposito: Say3/senha nascem
1741:     * Visible = .F. no SCX (regra do legado, nao defeito de migracao - so
1742:     * aparecem no fluxo de senha livre/Tipo "L" ou depois de o autorizador
1743:     * ser resolvido), mas essa decisao depende de this_cTipo/somotivo e eh
1744:     * aplicada por AplicarRegrasDeExibicao(), chamado DEPOIS desta varredura.
1745:     * A ordem eh: criar os campos -> tornar tudo visivel -> reocultar os
1746:     * condicionais. Filtrar por nome AQUI duplicaria a regra em dois lugares.
1747:     *
1748:     * Nao recursa em Pages por nao haver PageFrame nesta tela.
1749:     *--------------------------------------------------------------------------
1750:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1751:         LOCAL loc_nI, loc_oControle
1752: 
1753:         IF VARTYPE(par_oContainer) != "O"
1754:             RETURN
1755:         ENDIF
1756: 
1757:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1758:             loc_oControle = par_oContainer.Controls(loc_nI)
1759: 
1760:             IF VARTYPE(loc_oControle) = "O"
1761:                 IF PEMSTATUS(loc_oControle, "Visible", 5)
1762:                     loc_oControle.Visible = .T.
1763:                 ENDIF
1764: 
1765:                 IF PEMSTATUS(loc_oControle, "ControlCount", 5)
1766:                     IF loc_oControle.ControlCount > 0
1767:                         THIS.TornarControlesVisiveis(loc_oControle)
1768:                     ENDIF
1769:                 ENDIF
1770:             ENDIF
1771:         ENDFOR
1772:     ENDPROC
1773: 
1774:     *--------------------------------------------------------------------------
1775:     * Destroy - libera o BO e devolve ao FormBase
1776:     *
1777:     * DODEFAULT() na ULTIMA linha eh obrigatorio: eh o FormBase.Destroy que
1778:     * reconstroi os popups do menu principal apos o fechamento de um form
1779:     * modal; sem ele o menu do sistema aparece encolhido (regra #145).
1780:     *--------------------------------------------------------------------------
1781:     PROCEDURE Destroy()
1782:         LOCAL loc_nI
1783:         LOCAL ARRAY loc_aCursores[5]
1784: 
1785:         *-- Os cursores do BO vivem na datasession COMPARTILHADA
1786:         *-- (DataSession = 1, como o legado): deixados abertos, vazam para o
1787:         *-- resto do sistema e o proximo form que usar um alias homonimo
1788:         *-- herda a estrutura errada. Fechados AQUI, com o BO ainda vivo -
1789:         *-- os nomes sao properties dele.
1790:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1791:             loc_aCursores[1] = THIS.this_oBusinessObject.this_cCursorUsuarios
1792:             loc_aCursores[2] = THIS.this_oBusinessObject.this_cCursorMotivos
1793:             loc_aCursores[3] = THIS.this_oBusinessObject.this_cCursorMotivosBase
1794:             loc_aCursores[4] = THIS.this_oBusinessObject.this_cCursorSenhaLivre
1795:             loc_aCursores[5] = THIS.this_oBusinessObject.this_cCursorClaMotivo
1796: 
1797:             FOR loc_nI = 1 TO 5
1798:                 IF VARTYPE(loc_aCursores[loc_nI]) = "C"
1799:                     IF !EMPTY(loc_aCursores[loc_nI]) AND USED(loc_aCursores[loc_nI])
1800:                         USE IN (loc_aCursores[loc_nI])
1801:                     ENDIF
1802:                 ENDIF
1803:             ENDFOR
1804: 
1805:             THIS.this_oBusinessObject = .NULL.
1806:         ENDIF
1807: 
1808:         DODEFAULT()
1809:     ENDPROC
1810: 
1811: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpLimBO.prg):
*==============================================================================
* SigOpLimBO.prg - Business Object para SigOpLim (Limite de Descontos)
*
* Form OPERACIONAL do tipo DIALOGO DE AUTORIZACAO ("Limite Ultrapassado...").
* Nao eh cadastro: nao inclui, nao altera e nao exclui registro proprio. O
* legado (SIGOPLIM.SCX) eh chamado por outra tela quando o operador tenta um
* desconto/acrescimo acima do limite do cargo dele, e devolve em ThisForm.zsenha
* a credencial de quem liberou (ou .F. quando a liberacao foi negada).
*
* Fluxos do legado, selecionados por this_cTipo:
*   "D" - Desconto  : confere SigCdCrg.Limdescs / DescPors
*   "A" - Acrescimo : confere SigCdCrg.Limacres / AcrePors  (ramo Other do Do Case)
*   "X" - Limite    : confere SigCdCrg.Limites = "S" (ignora valor/percentual)
*   "L" - Senha livre: ignora usuario/cargo e consome senha pre-cadastrada
*                      em SigPrSnd (marcando-a como utilizada)
*
* Tabelas lidas (nomes e colunas conferidos em docs/schema.sql):
*   SigCdUsu  usuarios, senhas, ccargs, cativos, limdescs char(1)
*   SigCdCrg  ccargs, limdescs/descpors/limacres/acrepors numeric, nivels, limites
*   SigPrSnd  senhads, empdopnums, cidchaves          (senha livre)
*   SigCdFs   codigos, descrs, tipos, chkbins, blqtabds (motivos)
*   SigCdFsI  codigos, emps                            (motivo por empresa)
*   SigCdClc  codigos, cidchaves                       (classificacao da conta)
*   SigCdCmt  codigos, fkchaves, tipos                 (motivos da classificacao)
*
* ATENCAO - colunas homonimas de tipos DIFERENTES (regra #22 do CLAUDE.md):
*   SigCdUsu.limdescs eh char(1)        -> this_cLimDescs  (teste = "S")
*   SigCdCrg.limdescs eh numeric(11,2)  -> entra so no WHERE da consulta
* O "If limdescs = 'S'" do legado roda sobre TmpUsu (Select a.* de SigCdUsu),
* portanto eh a coluna CHAR. Trocar uma pela outra quebra a comparacao.
*
* Unica gravacao do fluxo: UPDATE SigPrSnd SET EmpDopNums (marca senha livre
* como consumida). Nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao() -
* o comportamento padrao herdado de BusinessBase ja eh o correto.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpLimBO AS BusinessBase

    *==========================================================================
    * Parametros recebidos do form chamador
    * Legado: Parameter totite, valor, pvalor, tipo, poform, Pcx, pMotivo,
    *                   pClaConta, plCheckBin, plCheckTabD, pcEmpresa
    * (poform/Pcx - form pai e data manager - ficam no Form, nao no BO: o
    *  acesso a dados aqui usa gnConnHandle)
    *==========================================================================
    this_nTotIte   = 0      && totite  - Total de itens da operacao
    this_nValDesc  = 0      && valor   - Valor do desconto/acrescimo pedido
    this_nPDescs   = 0      && pvalor  - Percentual do desconto/acrescimo pedido
    this_cTipo     = "D"    && tipo    - "D"/"C"/"X"/"L" (default "D" como no legado)
    this_lMotivo   = .F.    && pMotivo - .T. quando a tela exige informar motivo
    this_cClaConta = " "    && pClaConta - Classificacao da conta (SigCdClc.codigos)
    this_lCheckBin = .F.    && plCheckBin  - .T. filtra motivos com SigCdFs.ChkBins  <> 1
    this_lCheckTbd = .F.    && plCheckTabD - .T. filtra motivos com SigCdFs.BlqTabDs <> 1
    this_cEmps     = ""     && pcEmpresa - Empresa (SigCdFsI.emps); default = empresa logada

    *==========================================================================
    * Estado derivado (calculado a partir dos parametros)
    *==========================================================================
    *-- somotivo do legado: ( totite + valor + pvalor = 0 ) And ( Tipo <> "X" )
    *-- Quando .T. a tela pede SOMENTE o motivo, sem usuario/senha.
    this_lSoMotivo = .F.

    *==========================================================================
    * Resultado da autorizacao (equivale a ThisForm.zsenha do legado)
    *
    * No legado zsenha eh variante: recebe .F. quando negado e uma STRING
    * quando liberado. Aqui a decisao fica em this_lAutorizado (logico) e o
    * conteudo em this_cZSenha (caractere), para nao haver property de tipo
    * ambiguo; o Form remonta o valor de retorno do dialogo.
    *
    * Conteudo por tipo, conforme o legado:
    *   "X" -> usuario digitado
    *   "L" -> usuario logado (Usuar)
    *   so motivo -> Space(10) + codigo do motivo
    *   demais    -> SigCdUsu.usuarios + codigo do motivo
    *==========================================================================
    this_lAutorizado = .F.
    this_cZSenha     = ""

    *==========================================================================
    * Usuario autorizador selecionado (SigCdUsu / TmpUsu do legado)
    *==========================================================================
    this_cUsuarios = ""    && char(10) - Codigo do usuario que libera
    this_cSenhas   = ""     && char(10) - Senha gravada (conferida via fCriptografar)
    this_cCCargs   = ""     && char(10) - Cargo do usuario (FK SigCdCrg.ccargs)
    this_cLimDescs = ""     && char(1)  - SigCdUsu.limdescs ("S" = senha por data)

    *==========================================================================
    * Motivo selecionado (SigCdFs)
    *==========================================================================
    this_cCodigoMotivo  = ""   && char(10) - SigCdFs.codigos
    this_cDescrsMotivo  = ""   && char(40) - SigCdFs.descrs

    *==========================================================================
    * Senha livre (SigPrSnd) - fluxo this_cTipo = "L"
    *==========================================================================
    this_cSenhaDs     = ""   && char(6)  - Senha pre-cadastrada digitada
    this_cCidChaves   = ""   && char(20) - PK da senha livre localizada
    this_cEmpDopNums  = ""   && char(29) - Movimento que consumiu a senha
                             &&            (vazio = senha ainda disponivel)

    *==========================================================================
    * Espelho do que esta DIGITADO nos tres campos do dialogo (FormParaBO)
    *
    * Sao DIFERENTES de this_cUsuarios / this_cCodigoMotivo, que o legado le
    * do CURSOR (TmpUsu / TmpMdsc) via CarregarDoCursor/CarregarMotivoDoCursor
    * - nao se pode reusar as mesmas properties: o legado consulta as DUAS
    * origens no MESMO statement e elas tem significados distintos. Em
    * senha.Valid, "Zsenha = Iif(Tipo = [X], Usuario.Value,
    * TmpUsu.Usuarios + Get_motivo.Value)": o ramo "X" devolve o DIGITADO e o
    * ramo Else devolve o do CURSOR. Achatar os dois num campo so faria o
    * ramo "X" devolver o autorizador em vez de quem foi digitado - sem erro
    * e sem aviso, trocando a credencial gravada no movimento.
    *
    * this_cSenhaDigitada x this_cSenhaDs: o legado tem os dois usos tambem -
    * SenhaDs eh a senha pre-cadastrada que vira CHAVE DE BUSCA em SigPrSnd
    * (fluxo "L"), enquanto no fluxo normal a senha digitada eh so COMPARADA
    * com fCriptografar(SigCdUsu.Senhas) e nunca consultada em tabela.
    *==========================================================================
    this_cUsuarioDigitado = ""   && usuario.Value    - codigo digitado no campo
    this_cMotivoDigitado  = ""   && get_Motivo.Value - codigo digitado no campo
    this_cSenhaDigitada   = ""   && senha.Value      - senha digitada no campo

    *==========================================================================
    * Aliases dos cursores que este BO popula/consome
    * (mantidos como property para o Form nao repetir literais)
    *==========================================================================
    this_cCursorUsuarios   = "cursor_4c_Usuarios"     && TmpUsu     - usuarios com alcada
    this_cCursorMotivos    = "cursor_4c_Motivos"      && TmpMdsc    - motivos ja filtrados
    this_cCursorMotivosBase = "cursor_4c_MotivosBase" && LocalMdsc  - motivos antes da classificacao
    this_cCursorSenhaLivre = "cursor_4c_SenhaLivre"   && TmpPrSnd   - senha livre consultada
    this_cCursorClaMotivo  = "cursor_4c_ClaMotivo"    && TmpClaMt   - motivos da classificacao

    *==========================================================================
    * Init - Configura tabela/chave e resolve os defaults do legado
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Tabela principal consultada: cadastro de usuarios autorizadores
            THIS.this_cTabela     = "SigCdUsu"
            THIS.this_cCampoChave = "usuarios"

            *-- Empresa default = empresa logada.
            *-- Legado: ThisForm.pEmps = Iif(Type('pcempresa') = [C], pcempresa, _Empr)
            *-- _EMPR eh legado e nao se usa: a fonte eh go_4c_Sistema.cCodEmpresa.
            IF EMPTY(THIS.this_cEmps)
                IF VARTYPE(go_4c_Sistema) = "O"
                    THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar SigOpLimBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega o usuario autorizador selecionado a partir
    * de uma linha de cursor_4c_Usuarios (equivalente a "Select TmpUsu" do
    * legado, lido direto por THIS.this_cUsuarios/Senhas/CCargs/LimDescs).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cUsuarios = TratarNulo(usuarios, "")
            THIS.this_cSenhas   = TratarNulo(senhas, "")
            THIS.this_cCCargs   = TratarNulo(ccargs, "")
            THIS.this_cLimDescs = TratarNulo(limdescs, "")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarUsuariosAutorizados - Legado: SIGOPLIM.usuario.Valid, Do Case
    * por this_cTipo. Popula this_cCursorUsuarios (TmpUsu do legado) com os
    * usuarios cujo cargo (SigCdCrg) tem alcada para o valor/percentual
    * pedidos. "X" confere Limites = "S" (ignora valor/percentual); os
    * demais ("D" Desconto e "C" Acrescimo, os dois pelo Other do Do Case)
    * conferem o
    * limite e o percentual do cargo.
    *==========================================================================
    PROCEDURE BuscarUsuariosAutorizados()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF USED(THIS.this_cCursorUsuarios)
                USE IN (THIS.this_cCursorUsuarios)
            ENDIF

            DO CASE
                CASE THIS.this_cTipo = "D"
                    loc_cSQL = "SELECT a.* FROM SigCdUsu a, SigCdCrg b " + ;
                        "WHERE NOT a.cativos = 'N' " + ;
                        "AND (b.limdescs = 0 OR b.limdescs >= " + FormatarNumeroSQL(THIS.this_nValDesc, 2) + ") " + ;
                        "AND (b.descpors = 0 OR b.descpors >= " + FormatarNumeroSQL(THIS.this_nPDescs, 2) + ") " + ;
                        "AND (b.limdescs <> 0 OR b.descpors <> 0) " + ;
                        "AND a.ccargs = b.ccargs " + ;
                        "AND b.nivels = 'S' " + ;
                        "AND a.senhas <> '  '"

                CASE THIS.this_cTipo = "X"
                    loc_cSQL = "SELECT a.* FROM SigCdUsu a, SigCdCrg b " + ;
                        "WHERE NOT a.cativos = 'N' " + ;
                        "AND a.ccargs = b.ccargs " + ;
                        "AND b.limites = 'S' " + ;
                        "AND a.senhas <> '  '"

                OTHERWISE
                    *-- "A" (Acrescimo) - ramo Other do Do Case legado
                    loc_cSQL = "SELECT a.* FROM SigCdUsu a, SigCdCrg b " + ;
                        "WHERE NOT a.cativos = 'N' " + ;
                        "AND (b.limacres = 0 OR b.limacres >= " + FormatarNumeroSQL(THIS.this_nValDesc, 2) + ") " + ;
                        "AND (b.acrepors = 0 OR b.acrepors >= " + FormatarNumeroSQL(THIS.this_nPDescs, 2) + ") " + ;
                        "AND (b.limacres <> 0 OR b.acrepors <> 0) " + ;
                        "AND a.ccargs = b.ccargs " + ;
                        "AND b.nivels = 'S' " + ;
                        "AND a.senhas <> '  '"
            ENDCASE

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorUsuarios)

            IF loc_nResultado < 1 OR !USED(THIS.this_cCursorUsuarios)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                SELECT (THIS.this_cCursorUsuarios)
                INDEX ON usuarios TAG usuarios
                GO TOP
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarMotivos - Legado: SIGOPLIM.get_Motivo.Valid. Monta a base
    * (SigCdFs Left Join SigCdFsI, filtrada por Tipos/ChkBins/BlqTabDs) em
    * this_cCursorMotivosBase (LocalMdsc do legado, ja filtrada por Emps) e
    * copia para this_cCursorMotivos (TmpMdsc do legado), que eh o cursor
    * final - restringido por FiltrarMotivosPorClassificacao() quando
    * this_cClaConta estiver preenchido.
    *==========================================================================
    PROCEDURE BuscarMotivos()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cCursorJoin
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""
        loc_cCursorJoin = "cursor_4c_MotivosJoin"

        TRY
            IF USED(loc_cCursorJoin)
                USE IN (loc_cCursorJoin)
            ENDIF
            IF USED(THIS.this_cCursorMotivosBase)
                USE IN (THIS.this_cCursorMotivosBase)
            ENDIF
            IF USED(THIS.this_cCursorMotivos)
                USE IN (THIS.this_cCursorMotivos)
            ENDIF

            loc_cSQL = "SELECT a.*, b.emps FROM SigCdFs a LEFT JOIN SigCdFsI b ON a.codigos = b.codigos " + ;
                "WHERE a.tipos = " + EscaparSQL(THIS.this_cTipo) + " " + ;
                IIF(THIS.this_lCheckBin, "AND a.chkbins <> 1 ", "") + ;
                IIF(THIS.this_lCheckTbd, "AND a.blqtabds <> 1 ", "") + ;
                "ORDER BY a.codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorJoin)

            IF loc_nResultado < 1 OR !USED(loc_cCursorJoin)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                *-- Legado: Select Distinct Codigos, Descrs From LocalMdsc1
                *--         Where Nvl(Emps, pEmps) = pEmps Into Cursor LocalMdsc
                SELECT DISTINCT codigos, descrs FROM (loc_cCursorJoin) ;
                    WHERE NVL(emps, THIS.this_cEmps) = THIS.this_cEmps ;
                    INTO CURSOR (THIS.this_cCursorMotivosBase) READWRITE

                USE IN (loc_cCursorJoin)

                *-- Legado: Select * From LocalMdsc Into Cursor TmpMdsc ReadWrite
                SELECT * FROM (THIS.this_cCursorMotivosBase) ;
                    INTO CURSOR (THIS.this_cCursorMotivos) READWRITE

                IF !EMPTY(ALLTRIM(NVL(THIS.this_cClaConta, "")))
                    THIS.FiltrarMotivosPorClassificacao()
                ENDIF

                SELECT (THIS.this_cCursorMotivos)
                INDEX ON codigos TAG codigos
                GO TOP
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FiltrarMotivosPorClassificacao - Legado: bloco "If Not Empty(ThisForm.
    * ClaConta)" dentro de get_Motivo.Valid. SigCdCmt.Tipos=1 RESTRINGE
    * this_cCursorMotivos aos codigos daquela classificacao; Tipos=2
    * EXCLUI os codigos daquela classificacao. So chamado por BuscarMotivos.
    *==========================================================================
    PROTECTED PROCEDURE FiltrarMotivosPorClassificacao()
        LOCAL loc_cSQL, loc_nResultado

        TRY
            IF USED(THIS.this_cCursorClaMotivo)
                USE IN (THIS.this_cCursorClaMotivo)
            ENDIF

            loc_cSQL = "SELECT b.* FROM SigCdClc a, SigCdCmt b " + ;
                "WHERE a.codigos = " + EscaparSQL(ALLTRIM(THIS.this_cClaConta)) + " " + ;
                "AND a.cidchaves = b.fkchaves"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorClaMotivo)

            IF loc_nResultado >= 1 AND USED(THIS.this_cCursorClaMotivo)
                SELECT (THIS.this_cCursorClaMotivo)
                LOCATE FOR tipos = 1

                IF FOUND()
                    *-- Legado: Select a.* From LocalMdsc a, TmpClaMt b
                    *--         Where a.Codigos = b.codigos And b.Tipos = 1
                    *--         Into Cursor TmpMdsc ReadWrite
                    SELECT a.* FROM (THIS.this_cCursorMotivosBase) a, (THIS.this_cCursorClaMotivo) b ;
                        WHERE a.codigos = b.codigos AND b.tipos = 1 ;
                        INTO CURSOR (THIS.this_cCursorMotivos) READWRITE
                ELSE
                    SELECT (THIS.this_cCursorClaMotivo)
                    LOCATE FOR tipos = 2

                    IF FOUND()
                        *-- Legado: Select * From LocalMdsc Where Codigos Not in
                        *--         (Select Codigos From TmpClaMt Where Tipos = 2)
                        *--         Into Cursor TmpMdsc ReadWrite
                        SELECT * FROM (THIS.this_cCursorMotivosBase) ;
                            WHERE codigos NOT IN ;
                                (SELECT codigos FROM (THIS.this_cCursorClaMotivo) WHERE tipos = 2) ;
                            INTO CURSOR (THIS.this_cCursorMotivos) READWRITE
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarMotivoDoCursor - Carrega o motivo selecionado a partir de uma
    * linha de cursor_4c_Motivos (equivalente a ler TmpMdsc.Codigos/Descrs
    * apos o Seek do legado).
    *==========================================================================
    PROCEDURE CarregarMotivoDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigoMotivo = TratarNulo(codigos, "")
            THIS.this_cDescrsMotivo = TratarNulo(descrs, "")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GeraSenha - Transcricao literal de ThisForm.GeraSenha (SIGOPLIM.SCX).
    *
    * ATENCAO - metodo preservado so por fidelidade (PILAR 3), o resultado
    * NAO eh consultado em lugar nenhum do fluxo legado: pridig/segdig nunca
    * sao atribuidos (ficam 0) porque o legado esperava que fValidarCNPJ()
    * os preenchesse por efeito colateral (variavel nao-local visivel na
    * pilha de chamada); o wrapper novo (utils\fvalidarcnpj.prg) delega a
    * ValidarCNPJ() e devolve so um logico, sem esse efeito. zsen/zsen1,
    * calculados em usuario.Valid a partir deste metodo, tambem nunca sao
    * lidos depois. Quem chamar este metodo NAO deve basear autorizacao
    * nenhuma no retorno.
    *==========================================================================
    PROCEDURE GeraSenha(par_dData)
        LOCAL loc_nPriDig, loc_nSegDig, loc_cVar, loc_cVar1, loc_cSenha

        loc_nPriDig = 0
        loc_nSegDig = 0
        loc_cVar  = SUBSTR(DTOC(par_dData), 1, 2) + SUBSTR(DTOC(par_dData), 4, 2) + SUBSTR(DTOC(par_dData), 7, 2)
        loc_cVar  = loc_cVar + loc_cVar
        loc_cVar1 = TRANSFORM(loc_cVar + "00", "@R 99999999/9999-99")
        = fValidarCNPJ(loc_cVar1)
        loc_cSenha  = STR(loc_nPriDig, 1) + STR(loc_nSegDig, 1)
        loc_nPriDig = 0
        loc_nSegDig = 0
        loc_cVar1 = PADL(ALLTRIM(STR(VAL(loc_cVar) + VAL(loc_cSenha), 12)), 12, "0")
        loc_cVar1 = TRANSFORM(loc_cVar1 + "00", "@R 99999999/9999-99")
        loc_cSenha  = loc_cSenha + STR(loc_nPriDig, 1) + STR(loc_nSegDig, 1)

        RETURN loc_cSenha
    ENDPROC

    *==========================================================================
    * ValidarSenhaUsuario - Legado: SIGOPLIM.senha.Valid (ramo Else, Tipo
    * <> 'L'). Confere a senha digitada contra SigCdUsu.Senhas (ja carregada
    * em this_cSenhas por CarregarDoCursor) via fCriptografar.
    *
    * fCriptografar() NUNCA foi portada (funcao global legado Fortyus,
    * sig.prg/SIGFUNCS.PRG - nao vieram no acervo, e o algoritmo do hash nao
    * esta legivel em fonte nenhum). Transcrever a chamada literalmente e
    * deixar estourar dentro do TRY: o CATCH devolve a mensagem ao Form via
    * this_cMensagemErro em vez de fechar a tela (regra #27 do CLAUDE.md -
    * "DEIXAR AUSENTE", nunca inventar stub que devolva valor de calculo).
    *==========================================================================
    PROCEDURE ValidarSenhaUsuario(par_cSenhaDigitada)
        LOCAL loc_lResultado, loc_cSenhaPad, loc_cSenhaCripto
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cSenhaPad    = PADR(ALLTRIM(NVL(par_cSenhaDigitada, "")), 10)
            loc_cSenhaCripto = fCriptografar(THIS.this_cSenhas)

            IF loc_cSenhaPad == PADR(loc_cSenhaCripto, 10)
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Senha Conflitante."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarEConsumirSenhaLivre - Legado: SIGOPLIM.senha.Valid (ramo Tipo
    * = 'L'). Confere a senha pre-cadastrada em SigPrSnd e, se ainda nao
    * consumida, marca EmpDopNums com a chave do movimento que a consumiu.
    *
    * par_cEmpDopNumsMovimento: chave POSICIONAL (Emps char(3) + Dopes
    * char(20) + Str(Numes,6) = 29, igual EmpDopNums) - o Form monta com
    * PADR em cada parte (NUNCA ALLTRIM nas partes, regra da chave
    * posicional) a partir do cursor global TprMvCab do form chamador, que
    * este BO nao possui.
    *==========================================================================
    PROCEDURE ValidarEConsumirSenhaLivre(par_cSenhaDigitada, par_cEmpDopNumsMovimento)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cEmpDopNums
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF USED(THIS.this_cCursorSenhaLivre)
                USE IN (THIS.this_cCursorSenhaLivre)
            ENDIF

            THIS.this_cSenhaDs = ALLTRIM(NVL(par_cSenhaDigitada, ""))

            loc_cSQL = "SELECT empdopnums, cidchaves FROM SigPrSnd WHERE senhads = " + ;
                EscaparSQL(THIS.this_cSenhaDs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorSenhaLivre)

            IF loc_nResultado < 1 OR !USED(THIS.this_cCursorSenhaLivre) OR RECCOUNT(THIS.this_cCursorSenhaLivre) = 0
                THIS.this_cMensagemErro = "Senha inv" + CHR(225) + "lida."
            ELSE
                SELECT (THIS.this_cCursorSenhaLivre)
                GO TOP

                IF !EMPTY(empdopnums)
                    THIS.this_cMensagemErro = "Senha j" + CHR(225) + " utilizada."
                ELSE
                    THIS.this_cCidChaves = ALLTRIM(cidchaves)
                    loc_cEmpDopNums = PADR(NVL(par_cEmpDopNumsMovimento, ""), 29)

                    loc_cSQL = "UPDATE SigPrSnd SET empdopnums = " + EscaparSQL(loc_cEmpDopNums) + ;
                        " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                    SQLEXEC(gnConnHandle, loc_cSQL)

                    THIS.this_cEmpDopNums = loc_cEmpDopNums
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ComporAutorizacaoSoMotivo - Legado: get_Motivo.Valid, "If ThisForm.
    * somotivo / ThisForm.Zsenha = Space(10) + This.Value". Usado quando a
    * tela so pede o motivo (totite+valor+pvalor=0 e Tipo<>'X').
    *==========================================================================
    PROCEDURE ComporAutorizacaoSoMotivo(par_cCodigoMotivo)
        THIS.this_cZSenha = SPACE(10) + NVL(par_cCodigoMotivo, "")
        THIS.this_lAutorizado = .T.
        THIS.RegistrarAuditoria("AUTORIZACAO")
    ENDPROC

    *==========================================================================
    * ComporAutorizacaoSenhaLivre - Legado: senha.Valid, Tipo = 'L',
    * "ThisForm.Zsenha = Usuar" apos ValidarEConsumirSenhaLivre() ter
    * sucesso. Usuar (legado) = gc_4c_UsuarioLogado (CLAUDE.md: _EMPR/Usuar
    * sao legado, nunca usar direto).
    *==========================================================================
    PROCEDURE ComporAutorizacaoSenhaLivre()
        THIS.this_cZSenha = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
        THIS.this_lAutorizado = .T.
        THIS.RegistrarAuditoria("AUTORIZACAO")
    ENDPROC

    *==========================================================================
    * ComporAutorizacaoUsuarioSenha - Legado: senha.Valid, ramo Else, apos
    * ValidarSenhaUsuario() ter sucesso. Tipo = "X" devolve o usuario
    * DIGITADO (par_cUsuarioDigitado); os demais devolvem o usuario
    * AUTORIZADOR (this_cUsuarios, carregado por CarregarDoCursor) + o
    * codigo do motivo.
    *==========================================================================
    PROCEDURE ComporAutorizacaoUsuarioSenha(par_cUsuarioDigitado, par_cCodigoMotivo)
        IF THIS.this_cTipo = "X"
            THIS.this_cZSenha = ALLTRIM(NVL(par_cUsuarioDigitado, ""))
        ELSE
            THIS.this_cZSenha = THIS.this_cUsuarios + NVL(par_cCodigoMotivo, "")
        ENDIF
        THIS.this_lAutorizado = .T.
        THIS.RegistrarAuditoria("AUTORIZACAO")
    ENDPROC

    *==========================================================================
    * LimparDados - zera SO o estado de uma rodada de autorizacao, PRESERVANDO
    * os parametros de abertura (this_nTotIte/this_nValDesc/this_nPDescs/
    * this_cTipo/this_lMotivo/this_cClaConta/this_lCheckBin/this_lCheckTbd/
    * this_cEmps/this_lSoMotivo).
    *
    * A separacao eh o ponto deste metodo, nao detalhe: os parametros de
    * abertura descrevem O QUE foi pedido (chegam pelo Init do Form e nao
    * mudam durante a vida do dialogo), enquanto o estado abaixo descreve QUEM
    * autorizou. Zerar os parametros aqui faria a rodada seguinte consultar
    * alcada para valor 0 com Tipo "D" - ou seja, QUALQUER usuario passaria a
    * ter alcada, em silencio.
    *
    * PUBLIC (eh PUBLIC na BusinessBase, regra #51): o Form chama no funil de
    * reentrada (LimparCampos). Sem este reset, reabrir o MESMO objeto de
    * dialogo deixaria this_cUsuarios/this_cSenhas carregados do autorizador
    * ANTERIOR - e como ValidarSenhaUsuario confere a senha digitada contra
    * this_cSenhas, a segunda rodada autorizaria com a senha de quem liberou
    * a primeira, sem que o novo usuario fosse sequer escolhido.
    *==========================================================================
    PROCEDURE LimparDados()
        *-- Resultado da autorizacao
        THIS.this_lAutorizado = .F.
        THIS.this_cZSenha     = ""

        *-- Usuario autorizador (TmpUsu do legado)
        THIS.this_cUsuarios = ""
        THIS.this_cSenhas   = ""
        THIS.this_cCCargs   = ""
        THIS.this_cLimDescs = ""

        *-- Motivo selecionado (TmpMdsc do legado)
        THIS.this_cCodigoMotivo = ""
        THIS.this_cDescrsMotivo = ""

        *-- Senha livre (TmpPrSnd do legado)
        THIS.this_cSenhaDs    = ""
        THIS.this_cCidChaves  = ""
        THIS.this_cEmpDopNums = ""

        *-- Espelho dos campos digitados
        THIS.this_cUsuarioDigitado = ""
        THIS.this_cMotivoDigitado  = ""
        THIS.this_cSenhaDigitada   = ""

        *-- BusinessBase.LimparDados limpa this_cMensagemErro
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Usuario autorizador (ou o usuario logado, no
    * fluxo de senha livre, que nao passa por CarregarDoCursor). Usado so
    * por RegistrarAuditoria - nunca chamado de fora do BO (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(NVL(THIS.this_cUsuarios, ""))

        IF EMPTY(loc_cChave) AND TYPE("gc_4c_UsuarioLogado") = "C"
            loc_cChave = ALLTRIM(gc_4c_UsuarioLogado)
        ENDIF

        RETURN loc_cChave
    ENDPROC

ENDDEFINE

