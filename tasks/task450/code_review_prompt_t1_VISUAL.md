# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (10)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 218: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 252: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 273: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 295: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 317: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 339: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 373: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 427: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 448: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormIct.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1724 linhas total):

*-- Linhas 44 a 52:
44:         loc_lResultado = .F.
45: 
46:         TRY
47:             THIS.Caption = "Tipo de Tributa" + CHR(231) + CHR(227) + "o do ICMS"
48: 
49:             THIS.this_oBusinessObject = CREATEOBJECT("IctBO")
50: 
51:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
52:                 MostrarErro("Erro ao criar IctBO", "FormIct.InicializarForm")

*-- Linhas 77 a 96:
77:     PROTECTED PROCEDURE ConfigurarPageFrame()
78:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
79:         WITH THIS.pgf_4c_Paginas
80:             .Top       = -29
81:             .Left      = 0
82:             .Width     = THIS.Width
83:             .Height    = THIS.Height + 29
84:             .PageCount = 2
85:             .Tabs      = .F.
86:             .Visible   = .T.
87: 
88:             .Page1.Caption = "Lista"
89:             .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
90: 
91:             .Page2.Caption = "Dados"
92:             .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
93:         ENDWITH
94:     ENDPROC
95: 
96:     *====================================================================

*-- Linhas 106 a 143:
106:         *-- Cabecalho cinza (cntSombra legado) Top=1+29=30
107:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
108:         WITH loc_oPagina.cnt_4c_Cabecalho
109:             .Top         = 30
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BackColor   = RGB(100, 100, 100)
114:             .BackStyle   = 1
115:             .BorderWidth = 0
116:             .Visible     = .T.
117: 
118:             .AddObject("lbl_4c_Sombra", "Label")
119:             WITH .lbl_4c_Sombra
120:                 .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o do ICMS"
121:                 .Top       = 15
122:                 .Left      = 10
123:                 .Width     = THIS.Width
124:                 .Height    = 40
125:                 .AutoSize  = .F.
126:                 .FontName  = "Tahoma"
127:                 .FontSize  = 16
128:                 .FontBold  = .T.
129:                 .ForeColor = RGB(0, 0, 0)
130:                 .BackStyle = 0
131:                 .Visible   = .T.
132:             ENDWITH
133: 
134:             .AddObject("lbl_4c_Titulo", "Label")
135:             WITH .lbl_4c_Titulo
136:                 .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o do ICMS"
137:                 .Top       = 18
138:                 .Left      = 10
139:                 .Width     = THIS.Width
140:                 .Height    = 46
141:                 .AutoSize  = .F.
142:                 .FontName  = "Tahoma"
143:                 .FontSize  = 16

*-- Linhas 152 a 161:
152:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
153:         loc_oPagina.grd_4c_Lista.ColumnCount = 13
154:         WITH loc_oPagina.grd_4c_Lista
155:             .Top                = 117
156:             .Left               = 11
157:             .Width              = 956
158:             .Height             = 498
159:             .FontName           = "Verdana"
160:             .FontSize           = 8
161:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 173 a 224:
173:             .Visible            = .T.
174: 
175:             .Column1.Width            = 50
176:             .Column1.Header1.Caption  = "Tipo"
177:             .Column2.Width            = 90
178:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
179:             .Column3.Width            = 35
180:             .Column3.Header1.Caption  = "Mov"
181:             .Column4.Width            = 60
182:             .Column4.Header1.Caption  = "CFOP"
183:             .Column5.Width            = 160
184:             .Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o CFOP"
185:             .Column6.Width            = 35
186:             .Column6.Header1.Caption  = "Orig"
187:             .Column7.Width            = 100
188:             .Column7.Header1.Caption  = "Estado Origem"
189:             .Column8.Width            = 35
190:             .Column8.Header1.Caption  = "Dest"
191:             .Column9.Width            = 100
192:             .Column9.Header1.Caption  = "Estado Destino"
193:             .Column10.Width           = 65
194:             .Column10.Header1.Caption = "Al" + CHR(237) + "quota"
195:             .Column10.Alignment       = 1
196:             .Column11.Width           = 55
197:             .Column11.Header1.Caption = "Base Red."
198:             .Column11.Alignment       = 1
199:             .Column12.Width           = 60
200:             .Column12.Header1.Caption = "Al. Red."
201:             .Column12.Alignment       = 1
202:             .Column13.Width           = 65
203:             .Column13.Header1.Caption = "Al. Subst."
204:             .Column13.Alignment       = 1
205:         ENDWITH
206: 
207:         *-- Botao Copiar standalone (Command1 legado - abre copia como novo registro)
208:         *-- Top=4+29=33; Left=430 (imediatamente antes do bloco cnt_4c_Botoes)
209:         loc_oPagina.AddObject("cmd_4c_Copiar", "CommandButton")
210:         WITH loc_oPagina.cmd_4c_Copiar
211:             .Caption         = "Copiar"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
213:             .PicturePosition = 13
214:             .Top             = 33
215:             .Left            = 430
216:             .Width           = 75
217:             .Height          = 75
218:             .FontName        = "Comic Sans MS"
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .FontSize        = 8
222:             .ForeColor       = RGB(90, 90, 90)
223:             .BackColor       = RGB(255, 255, 255)
224:             .Themes          = .F.

*-- Linhas 231 a 345:
231:         *-- Container botoes CRUD (grupo_op legado) Top=-1+29=28; Left=512
232:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
233:         WITH loc_oPagina.cnt_4c_Botoes
234:             .Top         = 28
235:             .Left        =  542
236:             .Width       = 414
237:             .Height      = 85
238:             .BackColor   = RGB(53, 53, 53)
239:             .BackStyle   = 1
240:             .BorderWidth = 0
241:             .Visible     = .T.
242: 
243:             .AddObject("cmd_4c_Incluir", "CommandButton")
244:             WITH .cmd_4c_Incluir
245:                 .Caption         = "Incluir"
246:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
247:                 .PicturePosition = 13
248:                 .Top             = 5
249:                 .Left            =  542
250:                 .Width           = 75
251:                 .Height          = 75
252:                 .FontName        = "Comic Sans MS"
253:                 .FontBold        = .T.
254:                 .FontItalic      = .T.
255:                 .FontSize        = 8
256:                 .ForeColor       = RGB(90, 90, 90)
257:                 .BackColor       = RGB(255, 255, 255)
258:                 .SpecialEffect   = 0
259:                 .MousePointer    = 15
260:                 .WordWrap        = .T.
261:                 .Visible         = .T.
262:             ENDWITH
263: 
264:             .AddObject("cmd_4c_Visualizar", "CommandButton")
265:             WITH .cmd_4c_Visualizar
266:                 .Caption         = "Visualizar"
267:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
268:                 .PicturePosition = 13
269:                 .Top             = 5
270:                 .Left            =  542
271:                 .Width           = 75
272:                 .Height          = 75
273:                 .FontName        = "Comic Sans MS"
274:                 .FontBold        = .T.
275:                 .FontItalic      = .T.
276:                 .FontSize        = 8
277:                 .ForeColor       = RGB(90, 90, 90)
278:                 .BackColor       = RGB(255, 255, 255)
279:                 .Themes          = .F.
280:                 .SpecialEffect   = 0
281:                 .MousePointer    = 15
282:                 .WordWrap        = .T.
283:                 .Visible         = .T.
284:             ENDWITH
285: 
286:             .AddObject("cmd_4c_Alterar", "CommandButton")
287:             WITH .cmd_4c_Alterar
288:                 .Caption         = "Alterar"
289:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
290:                 .PicturePosition = 13
291:                 .Top             = 5
292:                 .Left            =  542
293:                 .Width           = 75
294:                 .Height          = 75
295:                 .FontName        = "Comic Sans MS"
296:                 .FontBold        = .T.
297:                 .FontItalic      = .T.
298:                 .FontSize        = 8
299:                 .ForeColor       = RGB(90, 90, 90)
300:                 .BackColor       = RGB(255, 255, 255)
301:                 .Themes          = .F.
302:                 .SpecialEffect   = 0
303:                 .MousePointer    = 15
304:                 .WordWrap        = .T.
305:                 .Visible         = .T.
306:             ENDWITH
307: 
308:             .AddObject("cmd_4c_Excluir", "CommandButton")
309:             WITH .cmd_4c_Excluir
310:                 .Caption         = "Excluir"
311:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
312:                 .PicturePosition = 13
313:                 .Top             = 5
314:                 .Left            =  542
315:                 .Width           = 75
316:                 .Height          = 75
317:                 .FontName        = "Comic Sans MS"
318:                 .FontBold        = .T.
319:                 .FontItalic      = .T.
320:                 .FontSize        = 8
321:                 .ForeColor       = RGB(90, 90, 90)
322:                 .BackColor       = RGB(255, 255, 255)
323:                 .Themes          = .F.
324:                 .SpecialEffect   = 0
325:                 .MousePointer    = 15
326:                 .WordWrap        = .T.
327:                 .Visible         = .T.
328:             ENDWITH
329: 
330:             .AddObject("cmd_4c_Buscar", "CommandButton")
331:             WITH .cmd_4c_Buscar
332:                 .Caption         = "Buscar"
333:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
334:                 .PicturePosition = 13
335:                 .Top             = 5
336:                 .Left            =  542
337:                 .Width           = 75
338:                 .Height          = 75
339:                 .FontName        = "Comic Sans MS"
340:                 .FontBold        = .T.
341:                 .FontItalic      = .T.
342:                 .FontSize        = 8
343:                 .ForeColor       = RGB(90, 90, 90)
344:                 .BackColor       = RGB(255, 255, 255)
345:                 .Themes          = .F.

*-- Linhas 353 a 397:
353:         *-- Container Saida canonico Left=917, Width=90
354:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
355:         WITH loc_oPagina.cnt_4c_Saida
356:             .Top         = 29
357:             .Left        = 917
358:             .Width       = 90
359:             .Height      = 85
360:             .BackStyle   = 0
361:             .BorderWidth = 0
362:             .Visible     = .T.
363: 
364:             .AddObject("cmd_4c_Encerrar", "CommandButton")
365:             WITH .cmd_4c_Encerrar
366:                 .Caption         = "Encerrar"
367:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
368:                 .PicturePosition = 13
369:                 .Top             = 5
370:                 .Left            = 917
371:                 .Width           = 75
372:                 .Height          = 75
373:                 .FontName        = "Comic Sans MS"
374:                 .FontBold        = .T.
375:                 .FontItalic      = .T.
376:                 .FontSize        = 8
377:                 .ForeColor       = RGB(90, 90, 90)
378:                 .BackColor       = RGB(255, 255, 255)
379:                 .SpecialEffect   = 0
380:                 .MousePointer    = 15
381:                 .WordWrap        = .T.
382:                 .Visible         = .T.
383:             ENDWITH
384:         ENDWITH
385: 
386:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
387:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
388:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
389:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
390:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
391:         BINDEVENT(loc_oPagina.cmd_4c_Copiar,                    "Click", THIS, "BtnCopiarClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
393: 
394:         THIS.TornarControlesVisiveis(loc_oPagina)
395:     ENDPROC
396: 
397:     *====================================================================

*-- Linhas 407 a 454:
407:         *-- Container Salvar/Cancelar (grupo_salva legado) Top=-4+29=25
408:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
409:         WITH loc_oPagina.cnt_4c_Salva
410:             .Top         = 25
411:             .Left        = 837
412:             .Width       = 161
413:             .Height      = 85
414:             .BackStyle   = 0
415:             .BorderWidth = 0
416:             .Visible     = .T.
417: 
418:             .AddObject("cmd_4c_Confirmar", "CommandButton")
419:             WITH .cmd_4c_Confirmar
420:                 .Caption         = "Confirmar"
421:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
422:                 .PicturePosition = 13
423:                 .Top             = 5
424:                 .Left            = 5
425:                 .Width           = 75
426:                 .Height          = 75
427:                 .FontName        = "Comic Sans MS"
428:                 .FontBold        = .T.
429:                 .FontItalic      = .T.
430:                 .FontSize        = 8
431:                 .ForeColor       = RGB(90, 90, 90)
432:                 .BackColor       = RGB(255, 255, 255)
433:                 .SpecialEffect   = 0
434:                 .MousePointer    = 15
435:                 .WordWrap        = .T.
436:                 .Visible         = .T.
437:             ENDWITH
438: 
439:             .AddObject("cmd_4c_Cancelar", "CommandButton")
440:             WITH .cmd_4c_Cancelar
441:                 .Caption         = "Encerrar"
442:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
443:                 .PicturePosition = 13
444:                 .Top             = 5
445:                 .Left            = 81
446:                 .Width           = 75
447:                 .Height          = 75
448:                 .FontName        = "Comic Sans MS"
449:                 .FontBold        = .T.
450:                 .FontItalic      = .T.
451:                 .FontSize        = 8
452:                 .ForeColor       = RGB(90, 90, 90)
453:                 .BackColor       = RGB(255, 255, 255)
454:                 .Themes          = .F.

*-- Linhas 462 a 799:
462:         *-- Container principal dos dados (Container1 legado) Top=49+29=78
463:         loc_oPagina.AddObject("cnt_4c_Container1", "Container")
464:         WITH loc_oPagina.cnt_4c_Container1
465:             .Top           = 78
466:             .Left          = 119
467:             .Width         = 732
468:             .Height        = 420
469:             .BackStyle     = 0
470:             .BorderWidth   = 0
471:             .SpecialEffect = 0
472:             .Visible       = .T.
473:         ENDWITH
474: 
475:         loc_oCnt = loc_oPagina.cnt_4c_Container1
476: 
477:         *-- Labels (Say1-Say11)
478:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
479:         WITH loc_oCnt.lbl_4c_Label1
480:             .Caption   = "Tipo :"
481:             .Top       = 84
482:             .Left      = 156
483:             .AutoSize  = .T.
484:             .FontName  = "MS Sans Serif"
485:             .FontSize  = 8
486:             .BackStyle = 0
487:             .Visible   = .T.
488:         ENDWITH
489: 
490:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
491:         WITH loc_oCnt.lbl_4c_Label2
492:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
493:             .Top       = 110
494:             .Left      = 130
495:             .AutoSize  = .T.
496:             .FontName  = "MS Sans Serif"
497:             .FontSize  = 8
498:             .BackStyle = 0
499:             .Visible   = .T.
500:         ENDWITH
501: 
502:         loc_oCnt.AddObject("lbl_4c_Label3", "Label")
503:         WITH loc_oCnt.lbl_4c_Label3
504:             .Caption   = "C.F.O.P. :"
505:             .Top       = 136
506:             .Left      = 133
507:             .AutoSize  = .T.
508:             .FontName  = "MS Sans Serif"
509:             .FontSize  = 8
510:             .BackStyle = 0
511:             .Visible   = .T.
512:         ENDWITH
513: 
514:         loc_oCnt.AddObject("lbl_4c_Label4", "Label")
515:         WITH loc_oCnt.lbl_4c_Label4
516:             .Caption   = "Estado Origem :"
517:             .Top       = 162
518:             .Left      = 106
519:             .AutoSize  = .T.
520:             .FontName  = "MS Sans Serif"
521:             .FontSize  = 8
522:             .BackStyle = 0
523:             .Visible   = .T.
524:         ENDWITH
525: 
526:         loc_oCnt.AddObject("lbl_4c_Label5", "Label")
527:         WITH loc_oCnt.lbl_4c_Label5
528:             .Caption   = "Estado Destino :"
529:             .Top       = 188
530:             .Left      = 104
531:             .AutoSize  = .T.
532:             .FontName  = "MS Sans Serif"
533:             .FontSize  = 8
534:             .BackStyle = 0
535:             .Visible   = .T.
536:         ENDWITH
537: 
538:         loc_oCnt.AddObject("lbl_4c_Label9", "Label")
539:         WITH loc_oCnt.lbl_4c_Label9
540:             .Caption   = "Tipo de Movimento :"
541:             .Top       = 213
542:             .Left      = 86
543:             .AutoSize  = .T.
544:             .FontName  = "MS Sans Serif"
545:             .FontSize  = 8
546:             .BackStyle = 0
547:             .Visible   = .T.
548:         ENDWITH
549: 
550:         loc_oCnt.AddObject("lbl_4c_Label10", "Label")
551:         WITH loc_oCnt.lbl_4c_Label10
552:             .Caption   = "[E]ntrada / [S]a" + CHR(237) + "da"
553:             .Top       = 215
554:             .Left      = 223
555:             .AutoSize  = .T.
556:             .FontName  = "MS Sans Serif"
557:             .FontSize  = 8
558:             .BackStyle = 0
559:             .Visible   = .T.
560:         ENDWITH
561: 
562:         loc_oCnt.AddObject("lbl_4c_Label6", "Label")
563:         WITH loc_oCnt.lbl_4c_Label6
564:             .Caption   = "Al" + CHR(237) + "quota :"
565:             .Top       = 240
566:             .Left      = 137
567:             .AutoSize  = .T.
568:             .FontName  = "MS Sans Serif"
569:             .FontSize  = 8
570:             .BackStyle = 0
571:             .Visible   = .T.
572:         ENDWITH
573: 
574:         loc_oCnt.AddObject("lbl_4c_Label7", "Label")
575:         WITH loc_oCnt.lbl_4c_Label7
576:             .Caption   = "Base Reduzida :"
577:             .Top       = 266
578:             .Left      = 106
579:             .AutoSize  = .T.
580:             .FontName  = "MS Sans Serif"
581:             .FontSize  = 8
582:             .BackStyle = 0
583:             .Visible   = .T.
584:         ENDWITH
585: 
586:         loc_oCnt.AddObject("lbl_4c_Label8", "Label")
587:         WITH loc_oCnt.lbl_4c_Label8
588:             .Caption   = "Al" + CHR(237) + "quota Reduzida :"
589:             .Top       = 292
590:             .Left      = 90
591:             .AutoSize  = .T.
592:             .FontName  = "MS Sans Serif"
593:             .FontSize  = 8
594:             .BackStyle = 0
595:             .Visible   = .T.
596:         ENDWITH
597: 
598:         loc_oCnt.AddObject("lbl_4c_Label11", "Label")
599:         WITH loc_oCnt.lbl_4c_Label11
600:             .Caption   = "Al" + CHR(237) + "quota Substitui" + CHR(231) + CHR(227) + "o :"
601:             .Top       = 318
602:             .Left      = 76
603:             .AutoSize  = .T.
604:             .FontName  = "MS Sans Serif"
605:             .FontSize  = 8
606:             .BackStyle = 0
607:             .Visible   = .T.
608:         ENDWITH
609: 
610:         *-- TextBoxes
611:         loc_oCnt.AddObject("txt_4c_Tipo", "TextBox")
612:         WITH loc_oCnt.txt_4c_Tipo
613:             .Value     = ""
614:             .Top       = 81
615:             .Left      = 190
616:             .Width     = 40
617:             .Height    = 23
618:             .FontName  = "MS Sans Serif"
619:             .FontSize  = 8
620:             .MaxLength = 4
621:             .ReadOnly  = .T.
622:             .Visible   = .T.
623:         ENDWITH
624: 
625:         loc_oCnt.AddObject("txt_4c_Desc", "TextBox")
626:         WITH loc_oCnt.txt_4c_Desc
627:             .Value     = ""
628:             .Top       = 107
629:             .Left      = 190
630:             .Width     = 184
631:             .Height    = 23
632:             .FontName  = "MS Sans Serif"
633:             .FontSize  = 8
634:             .MaxLength = 20
635:             .ReadOnly  = .T.
636:             .Visible   = .T.
637:         ENDWITH
638: 
639:         loc_oCnt.AddObject("txt_4c_CFOP", "TextBox")
640:         WITH loc_oCnt.txt_4c_CFOP
641:             .Value     = ""
642:             .Top       = 133
643:             .Left      = 190
644:             .Width     = 92
645:             .Height    = 23
646:             .FontName  = "MS Sans Serif"
647:             .FontSize  = 8
648:             .MaxLength = 10
649:             .ReadOnly  = .T.
650:             .Visible   = .T.
651:         ENDWITH
652: 
653:         loc_oCnt.AddObject("txt_4c_DCFOP", "TextBox")
654:         WITH loc_oCnt.txt_4c_DCFOP
655:             .Value     = ""
656:             .Top       = 133
657:             .Left      = 287
658:             .Width     = 386
659:             .Height    = 23
660:             .FontName  = "MS Sans Serif"
661:             .FontSize  = 8
662:             .MaxLength = 60
663:             .ReadOnly  = .T.
664:             .Visible   = .T.
665:         ENDWITH
666: 
667:         loc_oCnt.AddObject("txt_4c_Origem", "TextBox")
668:         WITH loc_oCnt.txt_4c_Origem
669:             .Value     = ""
670:             .Top       = 159
671:             .Left      = 190
672:             .Width     = 26
673:             .Height    = 23
674:             .FontName  = "MS Sans Serif"
675:             .FontSize  = 8
676:             .MaxLength = 2
677:             .ReadOnly  = .T.
678:             .Visible   = .T.
679:         ENDWITH
680: 
681:         loc_oCnt.AddObject("txt_4c_DOrigem", "TextBox")
682:         WITH loc_oCnt.txt_4c_DOrigem
683:             .Value     = ""
684:             .Top       = 159
685:             .Left      = 219
686:             .Width     = 185
687:             .Height    = 23
688:             .FontName  = "MS Sans Serif"
689:             .FontSize  = 8
690:             .MaxLength = 50
691:             .ReadOnly  = .T.
692:             .Visible   = .T.
693:         ENDWITH
694: 
695:         loc_oCnt.AddObject("txt_4c_Destino", "TextBox")
696:         WITH loc_oCnt.txt_4c_Destino
697:             .Value     = ""
698:             .Top       = 185
699:             .Left      = 190
700:             .Width     = 26
701:             .Height    = 23
702:             .FontName  = "MS Sans Serif"
703:             .FontSize  = 8
704:             .MaxLength = 2
705:             .ReadOnly  = .T.
706:             .Visible   = .T.
707:         ENDWITH
708: 
709:         loc_oCnt.AddObject("txt_4c_DDestino", "TextBox")
710:         WITH loc_oCnt.txt_4c_DDestino
711:             .Value     = ""
712:             .Top       = 185
713:             .Left      = 219
714:             .Width     = 185
715:             .Height    = 23
716:             .FontName  = "MS Sans Serif"
717:             .FontSize  = 8
718:             .MaxLength = 50
719:             .ReadOnly  = .T.
720:             .Visible   = .T.
721:         ENDWITH
722: 
723:         loc_oCnt.AddObject("txt_4c_Movs", "TextBox")
724:         WITH loc_oCnt.txt_4c_Movs
725:             .Value     = ""
726:             .Top       = 211
727:             .Left      = 190
728:             .Width     = 26
729:             .Height    = 23
730:             .FontName  = "MS Sans Serif"
731:             .FontSize  = 8
732:             .MaxLength = 1
733:             .ReadOnly  = .T.
734:             .Visible   = .T.
735:         ENDWITH
736: 
737:         loc_oCnt.AddObject("txt_4c_Aliquota", "TextBox")
738:         WITH loc_oCnt.txt_4c_Aliquota
739:             .Value    = 0
740:             .Top      = 237
741:             .Left     = 190
742:             .Width    = 75
743:             .Height   = 23
744:             .FontName = "MS Sans Serif"
745:             .FontSize = 8
746:             .Format   = "N"
747:             .ReadOnly = .T.
748:             .Visible  = .T.
749:         ENDWITH
750: 
751:         loc_oCnt.AddObject("txt_4c_Base", "TextBox")
752:         WITH loc_oCnt.txt_4c_Base
753:             .Value    = 0
754:             .Top      = 263
755:             .Left     = 190
756:             .Width    = 75
757:             .Height   = 23
758:             .FontName = "MS Sans Serif"
759:             .FontSize = 8
760:             .Format   = "N"
761:             .ReadOnly = .T.
762:             .Visible  = .T.
763:         ENDWITH
764: 
765:         loc_oCnt.AddObject("txt_4c_Reduz", "TextBox")
766:         WITH loc_oCnt.txt_4c_Reduz
767:             .Value    = 0
768:             .Top      = 289
769:             .Left     = 190
770:             .Width    = 75
771:             .Height   = 23
772:             .FontName = "MS Sans Serif"
773:             .FontSize = 8
774:             .Format   = "N"
775:             .ReadOnly = .T.
776:             .Visible  = .T.
777:         ENDWITH
778: 
779:         loc_oCnt.AddObject("txt_4c_Subst", "TextBox")
780:         WITH loc_oCnt.txt_4c_Subst
781:             .Value    = 0
782:             .Top      = 315
783:             .Left     = 190
784:             .Width    = 75
785:             .Height   = 23
786:             .FontName = "MS Sans Serif"
787:             .FontSize = 8
788:             .Format   = "N"
789:             .ReadOnly = .T.
790:             .Visible  = .T.
791:         ENDWITH
792: 
793:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
794:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
795: 
796:         *-- Lookups: F4 e DblClick para campos com busca auxiliar
797:         BINDEVENT(loc_oCnt.txt_4c_CFOP,     "KeyPress", THIS, "CFOPKeyPress")
798:         BINDEVENT(loc_oCnt.txt_4c_CFOP,     "DblClick",  THIS, "CFOPDblClick")
799:         BINDEVENT(loc_oCnt.txt_4c_DCFOP,    "KeyPress", THIS, "DCFOPKeyPress")

*-- Linhas 845 a 880:
845: 
846:                     *-- Reconfirmar headers e widths apos RecordSource (auto-bind reseta)
847:                     loc_oGrid.Column1.Width            = 50
848:                     loc_oGrid.Column1.Header1.Caption  = "Tipo"
849:                     loc_oGrid.Column2.Width            = 90
850:                     loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
851:                     loc_oGrid.Column3.Width            = 35
852:                     loc_oGrid.Column3.Header1.Caption  = "Mov"
853:                     loc_oGrid.Column4.Width            = 60
854:                     loc_oGrid.Column4.Header1.Caption  = "CFOP"
855:                     loc_oGrid.Column5.Width            = 160
856:                     loc_oGrid.Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o CFOP"
857:                     loc_oGrid.Column6.Width            = 35
858:                     loc_oGrid.Column6.Header1.Caption  = "Orig"
859:                     loc_oGrid.Column7.Width            = 100
860:                     loc_oGrid.Column7.Header1.Caption  = "Estado Origem"
861:                     loc_oGrid.Column8.Width            = 35
862:                     loc_oGrid.Column8.Header1.Caption  = "Dest"
863:                     loc_oGrid.Column9.Width            = 100
864:                     loc_oGrid.Column9.Header1.Caption  = "Estado Destino"
865:                     loc_oGrid.Column10.Width           = 65
866:                     loc_oGrid.Column10.Header1.Caption = "Al" + CHR(237) + "quota"
867:                     loc_oGrid.Column10.Alignment       = 1
868:                     loc_oGrid.Column11.Width           = 55
869:                     loc_oGrid.Column11.Header1.Caption = "Base Red."
870:                     loc_oGrid.Column11.Alignment       = 1
871:                     loc_oGrid.Column12.Width           = 60
872:                     loc_oGrid.Column12.Header1.Caption = "Al. Red."
873:                     loc_oGrid.Column12.Alignment       = 1
874:                     loc_oGrid.Column13.Width           = 65
875:                     loc_oGrid.Column13.Header1.Caption = "Al. Subst."
876:                     loc_oGrid.Column13.Alignment       = 1
877: 
878:                     THIS.FormatarGridLista(loc_oGrid)
879:                     loc_lResultado = .T.
880:                 ENDIF

*-- Linhas 1150 a 1161:
1150:                 loc_oCnt.txt_4c_Destino.Value  = ALLTRIM(.this_cDestinos)
1151:                 loc_oCnt.txt_4c_DDestino.Value = ALLTRIM(.this_cDestinoD)
1152:                 loc_oCnt.txt_4c_Movs.Value     = ALLTRIM(.this_cMovs)
1153:                 loc_oCnt.txt_4c_Aliquota.Value = .this_nAliquotas
1154:                 loc_oCnt.txt_4c_Base.Value     = .this_nBases
1155:                 loc_oCnt.txt_4c_Reduz.Value    = .this_nReduzidas
1156:                 loc_oCnt.txt_4c_Subst.Value    = .this_nAliqicmsts
1157:             ENDWITH
1158:             loc_lResultado = .T.
1159:         CATCH TO loException
1160:             MostrarErro("Erro ao popular campos:" + CHR(13) + loException.Message, ;
1161:                 "FormIct.BOParaForm")

*-- Linhas 1221 a 1229:
1221:             loc_lAlterar = par_lHabilitar AND THIS.this_cModoAtual = "ALTERAR"
1222:             loc_lBuscar  = par_lHabilitar AND THIS.this_cModoAtual = "BUSCAR"
1223: 
1224:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
1225: 
1226:             *-- Campos PK: editaveis em INCLUIR e BUSCAR (exceto Movs que e so INCLUIR)
1227:             loc_oCnt.txt_4c_Tipo.ReadOnly    = !(loc_lIncluir OR loc_lBuscar)
1228:             loc_oCnt.txt_4c_CFOP.ReadOnly    = !(loc_lIncluir OR loc_lBuscar)
1229:             loc_oCnt.txt_4c_Origem.ReadOnly  = !(loc_lIncluir OR loc_lBuscar)

*-- Linhas 1301 a 1310:
1301:             loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
1302: 
1303:             WITH loc_oPg2.cnt_4c_Salva
1304:                 .cmd_4c_Confirmar.Enabled = loc_lEditar
1305:                 .cmd_4c_Cancelar.Enabled  = .T.
1306:                 .Visible     = .T.
1307:             ENDWITH
1308:         CATCH TO loException
1309:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + ;
1310:                 loException.Message, "FormIct.AjustarBotoesPorModo")


### BO (C:\4c\projeto\app\classes\IctBO.prg):
*====================================================================
* IctBO.prg
*
* Business Object para Cadastro de Tipo de Tributa??o do ICMS
* Tabela: SigPrTri
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS IctBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTri)
    this_cCidChaves   = ""    && cidchaves char(20) - PK composta (gerada)
    this_cTipos       = ""    && tipos     char(4)
    this_cDescs       = ""    && descs     char(20)
    this_cCfops       = ""    && cfops     char(10)
    this_cOrigems     = ""    && origems   char(2)
    this_cDestinos    = ""    && destinos  char(2)
    this_cMovs        = ""    && movs      char(1)
    this_nAliquotas   = 0     && aliquotas numeric(5,2)
    this_nBases       = 0     && bases     numeric(5,2)
    this_nReduzidas   = 0     && reduzidas numeric(5,2)
    this_nAliqicmsts  = 0     && aliqicmsts numeric(5,2) - Aliq. Substitui??o

    *-- Propriedades auxiliares de exibi??o (vem de JOINs, n?o s?o colunas de SigPrTri)
    this_cOrigemd     = ""    && SigCdUfs.Descrs para Origems (display)
    this_cDestinoD    = ""    && SigCdUfs.Descrs para Destinos (display)
    this_cCfopd       = ""    && SigCdCfo.Descricaos para Cfops (display)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTri"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "IctBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    * cidchaves = tipos(4) + cfops(10) + movs(1) + origems(2) + "/" + destinos(2) = 20 chars
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * GerarCidChaves - Computa a PK composta a partir dos campos-chave
    *====================================================================
    PROTECTED FUNCTION GerarCidChaves()
        RETURN PADR(ALLTRIM(THIS.this_cTipos),  4) + ;
               PADR(ALLTRIM(THIS.this_cCfops), 10) + ;
               LEFT(ALLTRIM(THIS.this_cMovs) + " ", 1) + ;
               PADR(ALLTRIM(THIS.this_cOrigems), 2) + ;
               "/" + ;
               PADR(ALLTRIM(THIS.this_cDestinos), 2)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,   "C")
                THIS.this_cTipos      = TratarNulo(Tipos,       "C")
                THIS.this_cDescs      = TratarNulo(Descs,       "C")
                THIS.this_cCfops      = TratarNulo(CFOPs,       "C")
                THIS.this_cOrigems    = TratarNulo(Origems,     "C")
                THIS.this_cDestinos   = TratarNulo(Destinos,    "C")
                THIS.this_cMovs       = TratarNulo(Movs,        "C")
                THIS.this_nAliquotas  = TratarNulo(Aliquotas,   "N")
                THIS.this_nBases      = TratarNulo(Bases,       "N")
                THIS.this_nReduzidas  = TratarNulo(Reduzidas,   "N")
                THIS.this_nAliqicmsts = TratarNulo(aliqicmsts,  "N")
                IF FCOUNT() > 11
                    THIS.this_cOrigemd  = TratarNulo(Origemd,   "C")
                    THIS.this_cDestinoD = TratarNulo(Destinod,  "C")
                    THIS.this_cCfopd    = TratarNulo(CFOPd,     "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, ;
                "IctBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cTipos))
            MsgAviso("Tipo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cCfops))
            MsgAviso("C.F.O.P. obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cMovs))
            MsgAviso("Tipo de Movimento obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ELSE
            IF !INLIST(UPPER(ALLTRIM(THIS.this_cMovs)), "E", "S")
            MsgAviso("Tipo de Movimento inv" + CHR(225) + "lido. Use E=Entrada ou S=Sa" + CHR(237) + "da.")
            loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Buscar - Busca registros na tabela SigPrTri com JOINs de display
    * par_cFiltro: condicao SQL sem WHERE (vazio = todos)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cidchaves C(20), Tipos C(4), ;
                        Descs C(20), CFOPs C(10), Origems C(2), Destinos C(2), ;
                        Movs C(1), Aliquotas N(5,2), Bases N(5,2), Reduzidas N(5,2), ;
                        aliqicmsts N(5,2), Origemd C(50), Destinod C(50), CFOPd C(60))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.cidchaves, a.Tipos, a.Descs, a.CFOPs," + ;
                    " a.Origems, a.Destinos, a.Movs, a.Aliquotas, a.Bases," + ;
                    " a.Reduzidas, a.aliqicmsts," + ;
                    " b.Descrs AS Origemd, c.Descrs AS Destinod, d.Descricaos AS CFOPd" + ;
                    " FROM SigPrTri a" + ;
                    " LEFT JOIN SigCdUfs b ON a.Origems = b.Estados" + ;
                    " LEFT JOIN SigCdUfs c ON a.Destinos = c.Estados" + ;
                    " LEFT JOIN SigCdCfo d ON a.CFOPs = d.Codigos"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Tipos, a.CFOPs, a.Movs, a.Origems, a.Destinos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "IctBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.Tipos, a.Descs, a.CFOPs," + ;
                " a.Origems, a.Destinos, a.Movs, a.Aliquotas, a.Bases," + ;
                " a.Reduzidas, a.aliqicmsts," + ;
                " b.Descrs AS Origemd, c.Descrs AS Destinod, d.Descricaos AS CFOPd" + ;
                " FROM SigPrTri a" + ;
                " LEFT JOIN SigCdUfs b ON a.Origems = b.Estados" + ;
                " LEFT JOIN SigCdUfs c ON a.Destinos = c.Estados" + ;
                " LEFT JOIN SigCdCfo d ON a.CFOPs = d.Codigos" + ;
                " WHERE a.cidchaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado!")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "IctBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigPrTri (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarCidChaves()

            loc_cSQL = "INSERT INTO SigPrTri" + ;
                " (cidchaves, Tipos, Descs, CFOPs, Origems, Destinos," + ;
                " Movs, Aliquotas, Bases, Reduzidas, aliqicmsts)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(THIS.this_cTipos)     + ", " + ;
                EscaparSQL(THIS.this_cDescs)     + ", " + ;
                EscaparSQL(THIS.this_cCfops)     + ", " + ;
                EscaparSQL(THIS.this_cOrigems)   + ", " + ;
                EscaparSQL(THIS.this_cDestinos)  + ", " + ;
                EscaparSQL(THIS.this_cMovs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotas,  2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBases,      2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nReduzidas,  2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqicmsts, 2) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir Tributa" + CHR(231) + CHR(227) + "o ICMS:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "IctBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigPrTri (PROTECTED)
    * Apenas campos editaveis em modo ALTERAR (nao atualiza chave composta)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrTri SET" + ;
                " Descs = "      + EscaparSQL(THIS.this_cDescs)             + ", " + ;
                " Aliquotas = "  + FormatarNumeroSQL(THIS.this_nAliquotas,  2) + ", " + ;
                " Bases = "      + FormatarNumeroSQL(THIS.this_nBases,      2) + ", " + ;
                " Reduzidas = "  + FormatarNumeroSQL(THIS.this_nReduzidas,  2) + ", " + ;
                " aliqicmsts = " + FormatarNumeroSQL(THIS.this_nAliqicmsts, 2) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar Tributa" + CHR(231) + CHR(227) + "o ICMS:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "IctBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro de SigPrTri (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTri WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir Tributa" + CHR(231) + CHR(227) + "o ICMS:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "IctBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

