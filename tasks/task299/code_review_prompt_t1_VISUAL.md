# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 251: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprico.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (722 linhas total):

*-- Linhas 77 a 104:
77: 
78:     *============================================================================
79:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
80:     * PageFrame.Top = -29 e Tabs = .F. seguindo padrao do framework
81:     *============================================================================
82:     PROTECTED PROCEDURE ConfigurarPageFrame()
83:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
84: 
85:         WITH THIS.pgf_4c_Paginas
86:             .Top        = -29
87:             .Left       = 0
88:             .Width      = THIS.Width
89:             .Height     = THIS.Height + 29
90:             .PageCount  = 2
91:             .Tabs       = .F.
92:             .BorderWidth = 0
93:             .Themes     = .F.
94:             .Visible    = .F.
95: 
96:             .Page1.Caption = "Lista"
97:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98: 
99:             .Page2.Caption = "Dados"
100:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:         ENDWITH
102:     ENDPROC
103: 
104:     *============================================================================

*-- Linhas 114 a 163:
114:         *-- Container do cabecalho escuro (topo da pagina Lista)
115:         loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
116:         WITH loc_oPag1.cnt_4c_Cabecalho
117:             .Top         = 31
118:             .Left        = 0
119:             .Width       = THIS.Width
120:             .Height      = 80
121:             .BackStyle   = 1
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         *-- Container dos botoes CRUD (lado direito, sera populado na Fase 4)
128:         loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
129:         WITH loc_oPag1.cnt_4c_Botoes
130:             .Top         = 29
131:             .Left        = 542
132:             .Width       = 390
133:             .Height      = 85
134:             .BackStyle   = 1
135:             .BackColor   = RGB(53, 53, 53)
136:             .BorderWidth = 0
137:             .Visible     = .T.
138:         ENDWITH
139: 
140:         *-- Container de Saida/Encerrar (padrao canonico)
141:         loc_oPag1.AddObject("cnt_4c_Saida", "Container")
142:         WITH loc_oPag1.cnt_4c_Saida
143:             .Top         = 29
144:             .Left        = 917
145:             .Width       = 90
146:             .Height      = 85
147:             .BackStyle   = 0
148:             .BorderWidth = 0
149:             .Visible     = .T.
150:         ENDWITH
151: 
152:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
153: 
154:         *-- Container dos botoes de acao da pagina Dados (Salvar/Cancelar)
155:         loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
156:         WITH loc_oPag2.cnt_4c_BotoesAcao
157:             .Top         = 33
158:             .Left        = 842
159:             .Width       = 160
160:             .Height      = 85
161:             .BackStyle   = 0
162:             .BorderWidth = 0
163:             .Visible     = .T.

*-- Linhas 211 a 258:
211: 
212:         *-- Labels do cabecalho (sombra deslocada + titulo branco)
213:         WITH loc_oPag1.cnt_4c_Cabecalho
214:             .AddObject("lbl_4c_Sombra", "Label")
215:             WITH .lbl_4c_Sombra
216:                 .Top       = 15
217:                 .Left      = 12
218:                 .Width     = 769
219:                 .Height    = 40
220:                 .AutoSize  = .F.
221:                 .Caption   = "Mapa Visual"
222:                 .FontName  = "Tahoma"
223:                 .FontSize  = 16
224:                 .FontBold  = .T.
225:                 .ForeColor = RGB(0, 0, 0)
226:                 .BackStyle = 0
227:             ENDWITH
228: 
229:             .AddObject("lbl_4c_Titulo", "Label")
230:             WITH .lbl_4c_Titulo
231:                 .Top       = 18
232:                 .Left      = 10
233:                 .Width     = 769
234:                 .Height    = 46
235:                 .AutoSize  = .F.
236:                 .Caption   = "Mapa Visual"
237:                 .FontName  = "Tahoma"
238:                 .FontSize  = 16
239:                 .FontBold  = .T.
240:                 .ForeColor = RGB(255, 255, 255)
241:                 .BackStyle = 0
242:             ENDWITH
243:         ENDWITH
244: 
245:         *-- Botao Encerrar (padrao canonico cnt_4c_Saida)
246:         WITH loc_oPag1.cnt_4c_Saida
247:             .AddObject("cmd_4c_Encerrar", "CommandButton")
248:             WITH .cmd_4c_Encerrar
249:                 .Top             = 5
250:                 .Left            = 5
251:                 .Width           = 75
252:                 .Height          = 75
253:                 .Caption         = "Encerrar"
254:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
255:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
256:                 .FontName        = "Comic Sans MS"
257:                 .FontBold        = .T.
258:                 .FontItalic      = .T.

*-- Linhas 267 a 516:
267:             ENDWITH
268:         ENDWITH
269: 
270:         BINDEVENT(loc_oPag1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
271: 
272:         *-- Form puramente visual: cnt_4c_Botoes oculto (sem operacoes CRUD)
273:         loc_oPag1.cnt_4c_Botoes.Visible = .F.
274: 
275:         *-- 27 imagens do mapa visual centralizadas na area de conteudo
276:         loc_oPag1.AddObject("img_4c_Image1", "Image")
277:         WITH loc_oPag1.img_4c_Image1
278:             .Picture = gc_4c_CaminhoIcones + "form4.ico"
279:             .Stretch = 2
280:             .Top     = loc_nT + 0
281:             .Left    = loc_nL + 0
282:             .Width   = 18
283:             .Height  = 17
284:         ENDWITH
285: 
286:         loc_oPag1.AddObject("img_4c_Image2", "Image")
287:         WITH loc_oPag1.img_4c_Image2
288:             .Picture = gc_4c_CaminhoIcones + "form7.ico"
289:             .Stretch = 2
290:             .Top     = loc_nT + 18
291:             .Left    = loc_nL + 0
292:             .Width   = 18
293:             .Height  = 17
294:         ENDWITH
295: 
296:         loc_oPag1.AddObject("img_4c_Image3", "Image")
297:         WITH loc_oPag1.img_4c_Image3
298:             .Picture = gc_4c_CaminhoIcones + "ohist.ico"
299:             .Stretch = 2
300:             .Top     = loc_nT + 36
301:             .Left    = loc_nL + 0
302:             .Width   = 18
303:             .Height  = 17
304:         ENDWITH
305: 
306:         loc_oPag1.AddObject("img_4c_Image4", "Image")
307:         WITH loc_oPag1.img_4c_Image4
308:             .Picture = gc_4c_CaminhoIcones + "replace.ico"
309:             .Stretch = 2
310:             .Top     = loc_nT + 1
311:             .Left    = loc_nL + 22
312:             .Width   = 18
313:             .Height  = 17
314:         ENDWITH
315: 
316:         loc_oPag1.AddObject("img_4c_Image5", "Image")
317:         WITH loc_oPag1.img_4c_Image5
318:             .Picture = gc_4c_CaminhoIcones + "tab.ico"
319:             .Stretch = 2
320:             .Top     = loc_nT + 1
321:             .Left    = loc_nL + 44
322:             .Width   = 18
323:             .Height  = 17
324:         ENDWITH
325: 
326:         loc_oPag1.AddObject("img_4c_Image6", "Image")
327:         WITH loc_oPag1.img_4c_Image6
328:             .Picture = gc_4c_CaminhoIcones + "a_fold3.bmp"
329:             .Stretch = 2
330:             .Top     = loc_nT + 1
331:             .Left    = loc_nL + 67
332:             .Width   = 18
333:             .Height  = 17
334:         ENDWITH
335: 
336:         loc_oPag1.AddObject("img_4c_Image7", "Image")
337:         WITH loc_oPag1.img_4c_Image7
338:             .Picture = gc_4c_CaminhoIcones + "depend3.bmp"
339:             .Stretch = 2
340:             .Top     = loc_nT + 1
341:             .Left    = loc_nL + 90
342:             .Width   = 18
343:             .Height  = 17
344:         ENDWITH
345: 
346:         loc_oPag1.AddObject("img_4c_Image8", "Image")
347:         WITH loc_oPag1.img_4c_Image8
348:             .Picture = gc_4c_CaminhoIcones + "b_arrow4.bmp"
349:             .Stretch = 2
350:             .Top     = loc_nT + 24
351:             .Left    = loc_nL + 24
352:             .Width   = 18
353:             .Height  = 17
354:         ENDWITH
355: 
356:         loc_oPag1.AddObject("img_4c_Image9", "Image")
357:         WITH loc_oPag1.img_4c_Image9
358:             .Picture = gc_4c_CaminhoIcones + "b_arrow2.bmp"
359:             .Stretch = 2
360:             .Top     = loc_nT + 24
361:             .Left    = loc_nL + 53
362:             .Width   = 18
363:             .Height  = 17
364:         ENDWITH
365: 
366:         loc_oPag1.AddObject("img_4c_Image10", "Image")
367:         WITH loc_oPag1.img_4c_Image10
368:             .Picture = gc_4c_CaminhoIcones + "b_arrow3.bmp"
369:             .Stretch = 2
370:             .Top     = loc_nT + 24
371:             .Left    = loc_nL + 84
372:             .Width   = 18
373:             .Height  = 17
374:         ENDWITH
375: 
376:         loc_oPag1.AddObject("img_4c_Image11", "Image")
377:         WITH loc_oPag1.img_4c_Image11
378:             .Picture = gc_4c_CaminhoIcones + "b_arrow1.bmp"
379:             .Stretch = 2
380:             .Top     = loc_nT + 24
381:             .Left    = loc_nL + 116
382:             .Width   = 18
383:             .Height  = 17
384:         ENDWITH
385: 
386:         loc_oPag1.AddObject("img_4c_Image15", "Image")
387:         WITH loc_oPag1.img_4c_Image15
388:             .Picture = gc_4c_CaminhoIcones + "kuser.bmp"
389:             .Stretch = 2
390:             .Top     = loc_nT + 47
391:             .Left    = loc_nL + 144
392:             .Width   = 18
393:             .Height  = 17
394:         ENDWITH
395: 
396:         loc_oPag1.AddObject("img_4c_Image16", "Image")
397:         WITH loc_oPag1.img_4c_Image16
398:             .Picture = gc_4c_CaminhoIcones + "form4.ico"
399:             .Stretch = 2
400:             .Top     = loc_nT + 71
401:             .Left    = loc_nL + 5
402:             .Width   = 18
403:             .Height  = 17
404:         ENDWITH
405: 
406:         loc_oPag1.AddObject("img_4c_Image17", "Image")
407:         WITH loc_oPag1.img_4c_Image17
408:             .Picture = gc_4c_CaminhoIcones + "ohist.ico"
409:             .Stretch = 2
410:             .Top     = loc_nT + 94
411:             .Left    = loc_nL + 13
412:             .Width   = 18
413:             .Height  = 17
414:         ENDWITH
415: 
416:         loc_oPag1.AddObject("img_4c_Image18", "Image")
417:         WITH loc_oPag1.img_4c_Image18
418:             .Picture = gc_4c_CaminhoIcones + "depend3.bmp"
419:             .Stretch = 2
420:             .Top     = loc_nT + 73
421:             .Left    = loc_nL + 33
422:             .Width   = 18
423:             .Height  = 17
424:         ENDWITH
425: 
426:         loc_oPag1.AddObject("img_4c_Image19", "Image")
427:         WITH loc_oPag1.img_4c_Image19
428:             .Picture = gc_4c_CaminhoIcones + "envmail.bmp"
429:             .Stretch = 2
430:             .Top     = loc_nT + 117
431:             .Left    = loc_nL + 11
432:             .Width   = 18
433:             .Height  = 17
434:         ENDWITH
435: 
436:         loc_oPag1.AddObject("img_4c_Image20", "Image")
437:         WITH loc_oPag1.img_4c_Image20
438:             .Picture = gc_4c_CaminhoIcones + "replace.ico"
439:             .Stretch = 2
440:             .Top     = loc_nT + 95
441:             .Left    = loc_nL + 44
442:             .Width   = 18
443:             .Height  = 17
444:         ENDWITH
445: 
446:         loc_oPag1.AddObject("img_4c_Image21", "Image")
447:         WITH loc_oPag1.img_4c_Image21
448:             .Picture = gc_4c_CaminhoIcones + "server15.ico"
449:             .Stretch = 2
450:             .Top     = loc_nT + 121
451:             .Left    = loc_nL + 40
452:             .Width   = 18
453:             .Height  = 17
454:         ENDWITH
455: 
456:         loc_oPag1.AddObject("img_4c_Image22", "Image")
457:         WITH loc_oPag1.img_4c_Image22
458:             .Picture = gc_4c_CaminhoIcones + "people1.ico"
459:             .Stretch = 2
460:             .Top     = loc_nT + 84
461:             .Left    = loc_nL + 96
462:             .Width   = 18
463:             .Height  = 17
464:         ENDWITH
465: 
466:         loc_oPag1.AddObject("img_4c_Image23", "Image")
467:         WITH loc_oPag1.img_4c_Image23
468:             .Picture = gc_4c_CaminhoIcones + "home.ico"
469:             .Stretch = 2
470:             .Top     = loc_nT + 108
471:             .Left    = loc_nL + 101
472:             .Width   = 18
473:             .Height  = 17
474:         ENDWITH
475: 
476:         loc_oPag1.AddObject("img_4c_Image24", "Image")
477:         WITH loc_oPag1.img_4c_Image24
478:             .Picture = gc_4c_CaminhoIcones + "search2.ico"
479:             .Stretch = 2
480:             .Top     = loc_nT + 134
481:             .Left    = loc_nL + 106
482:             .Width   = 18
483:             .Height  = 17
484:         ENDWITH
485: 
486:         loc_oPag1.AddObject("img_4c_Image25", "Image")
487:         WITH loc_oPag1.img_4c_Image25
488:             .Picture = gc_4c_CaminhoIcones + "menu1.bmp"
489:             .Stretch = 2
490:             .Top     = loc_nT + 84
491:             .Left    = loc_nL + 192
492:             .Width   = 18
493:             .Height  = 17
494:         ENDWITH
495: 
496:         loc_oPag1.AddObject("img_4c_Image26", "Image")
497:         WITH loc_oPag1.img_4c_Image26
498:             .Picture = gc_4c_CaminhoIcones + "x_planilha1.bmp"
499:             .Stretch = 2
500:             .Top     = loc_nT + 132
501:             .Left    = loc_nL + 204
502:             .Width   = 18
503:             .Height  = 17
504:         ENDWITH
505: 
506:         loc_oPag1.AddObject("img_4c_Image27", "Image")
507:         WITH loc_oPag1.img_4c_Image27
508:             .Picture = gc_4c_CaminhoIcones + "msgstop1.gif"
509:             .Stretch = 2
510:             .Top     = loc_nT + 180
511:             .Left    = loc_nL + 240
512:             .Width   = 18
513:             .Height  = 17
514:         ENDWITH
515:     ENDPROC
516: 

*-- Linhas 527 a 566:
527:         *-- Cabecalho padrao da Page2 (cinza escuro com titulo)
528:         loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
529:         WITH loc_oPag2.cnt_4c_Cabecalho
530:             .Top         = 31
531:             .Left        = 0
532:             .Width       = THIS.Width
533:             .Height      = 80
534:             .BackStyle   = 1
535:             .BackColor   = RGB(100, 100, 100)
536:             .BorderWidth = 0
537:             .Visible     = .T.
538: 
539:             .AddObject("lbl_4c_Sombra", "Label")
540:             WITH .lbl_4c_Sombra
541:                 .Top       = 15
542:                 .Left      = 12
543:                 .Width     = THIS.Width
544:                 .Height    = 40
545:                 .AutoSize  = .F.
546:                 .Caption   = "Mapa Visual"
547:                 .FontName  = "Tahoma"
548:                 .FontSize  = 16
549:                 .FontBold  = .T.
550:                 .ForeColor = RGB(0, 0, 0)
551:                 .BackStyle = 0
552:             ENDWITH
553: 
554:             .AddObject("lbl_4c_Titulo", "Label")
555:             WITH .lbl_4c_Titulo
556:                 .Top       = 18
557:                 .Left      = 10
558:                 .Width     = THIS.Width
559:                 .Height    = 46
560:                 .AutoSize  = .F.
561:                 .Caption   = "Mapa Visual"
562:                 .FontName  = "Tahoma"
563:                 .FontSize  = 16
564:                 .FontBold  = .T.
565:                 .ForeColor = RGB(255, 255, 255)
566:                 .BackStyle = 0


### BO (C:\4c\projeto\app\classes\sigpricoBO.prg):
*==============================================================================
* sigpricoBO.prg
*
* Business Object para Formsigprico
* Formulario de mapa visual/diagrama operacional
* Sem tabela propria - apenas imagens de navegacao
*==============================================================================

DEFINE CLASS sigpricoBO AS BusinessBase

	*-- Sem propriedades de dados: formulario apenas visual (27 imagens)
	*-- Metodos CRUD implementados como no-op para conformidade com BusinessBase

	*============================================================================
	* Init - Inicializa Business Object
	*============================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela    = ""
		THIS.this_cCampoChave = ""
		RETURN .T.
	ENDPROC

	*============================================================================
	* ObterChavePrimaria - Retorna chave primaria (vazia: sem tabela)
	*============================================================================
	PROTECTED FUNCTION ObterChavePrimaria()
		RETURN ""
	ENDFUNC

	*============================================================================
	* CarregarDoCursor - No-op: form nao tem cursor de dados (apenas imagens)
	*============================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Nao ha dados para carregar de cursor
		RETURN .T.
	ENDPROC

	*============================================================================
	* Inserir - No-op: form nao persiste dados
	*============================================================================
	FUNCTION Inserir()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma operacao INSERT realizada
		THIS.this_cUltimoErro = "Formulario sem persistencia de dados"

		RETURN loc_lResultado
	ENDFUNC

	*============================================================================
	* Atualizar - No-op: form nao persiste dados
	*============================================================================
	FUNCTION Atualizar()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma operacao UPDATE realizada
		THIS.this_cUltimoErro = "Formulario sem persistencia de dados"

		RETURN loc_lResultado
	ENDFUNC

	*============================================================================
	* ExecutarExclusao - No-op: form nao persiste dados
	*============================================================================
	PROTECTED FUNCTION ExecutarExclusao()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma operacao DELETE realizada
		THIS.this_cUltimoErro = "Formulario sem persistencia de dados"

		RETURN loc_lResultado
	ENDFUNC

	*============================================================================
	* Buscar - No-op: form nao possui lista de registros
	*============================================================================
	FUNCTION Buscar(par_cFiltro)
		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Sem tabela associada: nenhuma consulta SELECT realizada
		RETURN .T.
	ENDFUNC

	*============================================================================
	* RegistrarAuditoria - No-op: sem operacoes que exijam auditoria
	*============================================================================
	PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
		*-- Formulario exclusivamente visual (mapa/diagrama)
		*-- Nenhuma operacao de dados a auditar
		RETURN
	ENDPROC

ENDDEFINE

