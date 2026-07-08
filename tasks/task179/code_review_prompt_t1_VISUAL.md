# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (7)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 185: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 209: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 289: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 313: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 361: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 611: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1957 linhas total):

*-- Linhas 75 a 92:
75:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
76:         WITH THIS.pgf_4c_Paginas
77:             .PageCount = 2
78:             .Top       = -29
79:             .Left      = 0
80:             .Width     = THIS.Width
81:             .Height    = THIS.Height + 29
82:             .Tabs      = .F.
83:             .Visible   = .T.
84:             .Page1.Caption   = "Lista"
85:             .Page1.BackColor = RGB(100, 100, 100)
86:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
87:             .Page2.Caption   = "Dados"
88:             .Page2.BackColor = RGB(100, 100, 100)
89:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90:         ENDWITH
91:     ENDPROC
92: 

*-- Linhas 103 a 140:
103:         *-- Cabecalho (cntSombra: Top=2+29=31 compensacao PageFrame)
104:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
105:         WITH loc_oPagina.cnt_4c_Cabecalho
106:             .Top         = 31
107:             .Left        = 0
108:             .Width       = THIS.Width
109:             .Height      = 80
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible     = .T.
113:         ENDWITH
114: 
115:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
116:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
117:             .Caption   = THIS.Caption
118:             .Top       = 15
119:             .Left      = 10
120:             .Width     = THIS.Width - 20
121:             .Height    = 40
122:             .FontName  = "Tahoma"
123:             .FontSize  = 16
124:             .FontBold  = .T.
125:             .ForeColor = RGB(0, 0, 0)
126:             .BackStyle = 0
127:             .AutoSize  = .F.
128:             .Visible   = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
133:             .Caption   = THIS.Caption
134:             .Top       = 18
135:             .Left      = 10
136:             .Width     = THIS.Width - 20
137:             .Height    = 46
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.

*-- Linhas 147 a 215:
147:         *-- Container botao Consultar (Grupo_Op original: Width=10+80=90, apenas Consultar visivel)
148:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
149:         WITH loc_oPagina.cnt_4c_Botoes
150:             .Top         = 29
151:             .Left        =  542
152:             .Width       = 90
153:             .Height      = 85
154:             .BackStyle = 1
155:             .BackColor = RGB(255, 255, 255)
156:             .BorderWidth = 0
157:             .Visible     = .T.
158:         ENDWITH
159: 
160:         *-- Container Encerrar - padrao canonico (Left=917, Width=90)
161:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
162:         WITH loc_oPagina.cnt_4c_Saida
163:             .Top         = 29
164:             .Left        = 917
165:             .Width       = 90
166:             .Height      = 85
167:             .BackStyle = 1
168:             .BackColor = RGB(255, 255, 255)
169:             .BorderWidth = 0
170:             .Visible     = .T.
171:         ENDWITH
172: 
173:         *-- Botao Consultar (original: so Consultar visivel; Inserir/Alterar/Excluir/Procurar ocultos)
174:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Consultar", "CommandButton")
175:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar
176:             .Caption         = "Consultar"
177:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
178:             .PicturePosition = 13
179:             .Top             = 5
180:             .Left            = 5
181:             .Width           = 75
182:             .Height          = 75
183:             .BackColor       = RGB(255, 255, 255)
184:             .ForeColor       = RGB(90, 90, 90)
185:             .FontName        = "Comic Sans MS"
186:             .FontSize        = 8
187:             .FontBold        = .T.
188:             .FontItalic      = .T.
189:             .Themes          = .F.
190:             .SpecialEffect   = 0
191:             .MousePointer    = 15
192:             .WordWrap        = .T.
193:             .AutoSize        = .F.
194:             .Visible         = .T.
195:         ENDWITH
196: 
197:         *-- Botao Encerrar (padrao canonico)
198:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
199:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
200:             .Caption         = "Encerrar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 5
205:             .Width           = 75
206:             .Height          = 75
207:             .BackColor       = RGB(255, 255, 255)
208:             .ForeColor       = RGB(90, 90, 90)
209:             .FontName        = "Comic Sans MS"
210:             .FontSize        = 8
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .Themes          = .F.
214:             .SpecialEffect   = 0
215:             .MousePointer    = 15

*-- Linhas 222 a 231:
222:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
223:         loc_oPagina.grd_4c_Lista.ColumnCount = 11
224:         WITH loc_oPagina.grd_4c_Lista
225:             .Top                = 117
226:             .Left               = 26
227:             .Width              = 890
228:             .Height             = 460
229:             .DeleteMark         = .F.
230:             .RecordMark         = .F.
231:             .GridLineColor      = RGB(238, 238, 238)

*-- Linhas 243 a 253:
243:         ENDWITH
244: 
245:         *-- BINDEVENTs dos botoes (metodos PUBLIC, sem PROTECTED)
246:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar, "Click", ;
247:                   THIS, "BtnConsultarClick")
248:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", ;
249:                   THIS, "BtnEncerrarClick")
250: 
251:         THIS.TornarControlesVisiveis(loc_oPagina)
252:     ENDPROC
253: 

*-- Linhas 265 a 319:
265:         *-- Container botoes acao (Grupo_Salva: top=4+29=33)
266:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
267:         WITH loc_oPagina.cnt_4c_BotoesAcao
268:             .Top         = 33
269:             .Left        = 842
270:             .Width       = 160
271:             .Height      = 85
272:             .BackStyle = 1
273:             .BackColor = RGB(255, 255, 255)
274:             .Visible     = .T.
275:         ENDWITH
276: 
277:         *-- Botao Confirmar (Salva/OK no CONSULTAR)
278:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
279:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
280:             .Caption         = "Confirmar"
281:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
282:             .PicturePosition = 13
283:             .Top             = 5
284:             .Left            = 5
285:             .Width           = 75
286:             .Height          = 75
287:             .BackColor       = RGB(255, 255, 255)
288:             .ForeColor       = RGB(90, 90, 90)
289:             .FontName        = "Comic Sans MS"
290:             .FontSize        = 8
291:             .FontBold        = .T.
292:             .FontItalic      = .T.
293:             .Themes          = .F.
294:             .SpecialEffect   = 0
295:             .MousePointer    = 15
296:             .WordWrap        = .T.
297:             .AutoSize        = .F.
298:             .Visible         = .T.
299:         ENDWITH
300: 
301:         *-- Botao Cancelar (volta para lista)
302:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
303:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
304:             .Caption         = "Encerrar"
305:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
306:             .PicturePosition = 13
307:             .Top             = 5
308:             .Left            = 80
309:             .Width           = 75
310:             .Height          = 75
311:             .BackColor       = RGB(255, 255, 255)
312:             .ForeColor       = RGB(90, 90, 90)
313:             .FontName        = "Comic Sans MS"
314:             .FontSize        = 8
315:             .FontBold        = .T.
316:             .FontItalic      = .T.
317:             .Themes          = .F.
318:             .SpecialEffect   = 0
319:             .MousePointer    = 15

*-- Linhas 326 a 335:
326:         loc_oPagina.AddObject("grd_4c_Operacao", "Grid")
327:         loc_oPagina.grd_4c_Operacao.ColumnCount = 1
328:         WITH loc_oPagina.grd_4c_Operacao
329:             .Top                = 39
330:             .Left               = 679
331:             .Width              = 112
332:             .Height             = 148
333:             .DeleteMark         = .F.
334:             .RecordMark         = .F.
335:             .GridLineColor      = RGB(238, 238, 238)

*-- Linhas 347 a 383:
347:         ENDWITH
348: 
349:         *-- Botao Entrega (cmdEntrega original: CommandGroup 1-botao, top=7+29=36)
350:         loc_oPagina.AddObject("cmd_4c_Entrega", "CommandButton")
351:         WITH loc_oPagina.cmd_4c_Entrega
352:             .Caption         = "Entrega"
353:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
354:             .PicturePosition = 13
355:             .Top             = 36
356:             .Left            = 23
357:             .Width           = 90
358:             .Height          = 110
359:             .BackColor       = RGB(255, 255, 255)
360:             .ForeColor       = RGB(90, 90, 90)
361:             .FontName        = "Comic Sans MS"
362:             .FontSize        = 8
363:             .FontBold        = .T.
364:             .FontItalic      = .T.
365:             .Themes          = .F.
366:             .SpecialEffect   = 0
367:             .MousePointer    = 15
368:             .WordWrap        = .T.
369:             .AutoSize        = .F.
370:             .Visible         = .T.
371:         ENDWITH
372: 
373:         *-- Area de cabecalho: 1a linha (Codigo, Data, Prz.Entrega)
374:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
375:         WITH loc_oPagina.lbl_4c_Codigo
376:             .Caption   = "C" + CHR(243) + "digo"
377:             .Top       = 43
378:             .Left      = 131
379:             .Width     = 61
380:             .Height    = 15
381:             .FontName  = "Tahoma"
382:             .FontSize  = 8
383:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 390 a 415:
390:         WITH loc_oPagina.txt_4c_Codigo
391:             .Value         = ""
392:             .ReadOnly      = .T.
393:             .Top           = 60
394:             .Left          = 131
395:             .Width         = 61
396:             .Height        = 23
397:             .FontName      = "Tahoma"
398:             .FontSize      = 8
399:             .BackColor     = RGB(255, 255, 255)
400:             .ForeColor     = RGB(90, 90, 90)
401:             .BorderStyle   = 1
402:             .SpecialEffect = 0
403:             .Visible       = .T.
404:         ENDWITH
405: 
406:         loc_oPagina.AddObject("lbl_4c_Data", "Label")
407:         WITH loc_oPagina.lbl_4c_Data
408:             .Caption   = "Data"
409:             .Top       = 43
410:             .Left      = 201
411:             .Width     = 80
412:             .Height    = 15
413:             .FontName  = "Tahoma"
414:             .FontSize  = 8
415:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 422 a 447:
422:         WITH loc_oPagina.txt_4c_Data
423:             .Value         = {}
424:             .ReadOnly      = .T.
425:             .Top           = 60
426:             .Left          = 201
427:             .Width         = 80
428:             .Height        = 23
429:             .FontName      = "Tahoma"
430:             .FontSize      = 8
431:             .BackColor     = RGB(255, 255, 255)
432:             .ForeColor     = RGB(90, 90, 90)
433:             .BorderStyle   = 1
434:             .SpecialEffect = 0
435:             .Visible       = .T.
436:         ENDWITH
437: 
438:         loc_oPagina.AddObject("lbl_4c_PrvEnts", "Label")
439:         WITH loc_oPagina.lbl_4c_PrvEnts
440:             .Caption   = "Prz Entrega"
441:             .Top       = 43
442:             .Left      = 289
443:             .Width     = 80
444:             .Height    = 15
445:             .FontName  = "Tahoma"
446:             .FontSize  = 8
447:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 454 a 480:
454:         WITH loc_oPagina.txt_4c_PrvEnts
455:             .Value         = {}
456:             .ReadOnly      = .T.
457:             .Top           = 60
458:             .Left          = 289
459:             .Width         = 80
460:             .Height        = 23
461:             .FontName      = "Tahoma"
462:             .FontSize      = 8
463:             .BackColor     = RGB(255, 255, 255)
464:             .ForeColor     = RGB(90, 90, 90)
465:             .BorderStyle   = 1
466:             .SpecialEffect = 0
467:             .Visible       = .T.
468:         ENDWITH
469: 
470:         *-- 2a linha: OP, Docto, Tb.Desconto, Status
471:         loc_oPagina.AddObject("lbl_4c_Nop", "Label")
472:         WITH loc_oPagina.lbl_4c_Nop
473:             .Caption   = "OP"
474:             .Top       = 91
475:             .Left      = 131
476:             .Width     = 55
477:             .Height    = 15
478:             .FontName  = "Tahoma"
479:             .FontSize  = 8
480:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 487 a 512:
487:         WITH loc_oPagina.txt_4c_Nop
488:             .Value         = ""
489:             .ReadOnly      = .T.
490:             .Top           = 108
491:             .Left          = 131
492:             .Width         = 55
493:             .Height        = 23
494:             .FontName      = "Tahoma"
495:             .FontSize      = 8
496:             .BackColor     = RGB(255, 255, 255)
497:             .ForeColor     = RGB(90, 90, 90)
498:             .BorderStyle   = 1
499:             .SpecialEffect = 0
500:             .Visible       = .T.
501:         ENDWITH
502: 
503:         loc_oPagina.AddObject("lbl_4c_Nota", "Label")
504:         WITH loc_oPagina.lbl_4c_Nota
505:             .Caption   = "Docto"
506:             .Top       = 91
507:             .Left      = 193
508:             .Width     = 30
509:             .Height    = 15
510:             .FontName  = "Tahoma"
511:             .FontSize  = 8
512:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 519 a 544:
519:         WITH loc_oPagina.txt_4c_Nota
520:             .Value         = ""
521:             .ReadOnly      = .T.
522:             .Top           = 107
523:             .Left          = 193
524:             .Width         = 66
525:             .Height        = 23
526:             .FontName      = "Tahoma"
527:             .FontSize      = 8
528:             .BackColor     = RGB(255, 255, 255)
529:             .ForeColor     = RGB(90, 90, 90)
530:             .BorderStyle   = 1
531:             .SpecialEffect = 0
532:             .Visible       = .T.
533:         ENDWITH
534: 
535:         loc_oPagina.AddObject("lbl_4c_Tabd", "Label")
536:         WITH loc_oPagina.lbl_4c_Tabd
537:             .Caption   = "Tb. Desconto"
538:             .Top       = 91
539:             .Left      = 269
540:             .Width     = 80
541:             .Height    = 15
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8
544:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 551 a 576:
551:         WITH loc_oPagina.txt_4c_Tabd
552:             .Value         = ""
553:             .ReadOnly      = .T.
554:             .Top           = 108
555:             .Left          = 269
556:             .Width         = 80
557:             .Height        = 23
558:             .FontName      = "Tahoma"
559:             .FontSize      = 8
560:             .BackColor     = RGB(255, 255, 255)
561:             .ForeColor     = RGB(90, 90, 90)
562:             .BorderStyle   = 1
563:             .SpecialEffect = 0
564:             .Visible       = .T.
565:         ENDWITH
566: 
567:         loc_oPagina.AddObject("lbl_4c_PStatus", "Label")
568:         WITH loc_oPagina.lbl_4c_PStatus
569:             .Caption   = "Status"
570:             .Top       = 91
571:             .Left      = 358
572:             .Width     = 36
573:             .Height    = 15
574:             .FontName  = "Tahoma"
575:             .FontSize  = 8
576:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 583 a 617:
583:         WITH loc_oPagina.txt_4c_PStatus
584:             .Value         = ""
585:             .ReadOnly      = .T.
586:             .Top           = 108
587:             .Left          = 358
588:             .Width         = 36
589:             .Height        = 23
590:             .FontName      = "Tahoma"
591:             .FontSize      = 8
592:             .BackColor     = RGB(255, 255, 255)
593:             .ForeColor     = RGB(90, 90, 90)
594:             .BorderStyle   = 1
595:             .SpecialEffect = 0
596:             .Visible       = .T.
597:         ENDWITH
598: 
599:         *-- Botao SubNiveis (top=125+29=154, left=833)
600:         loc_oPagina.AddObject("cmd_4c_SubNiveis", "CommandButton")
601:         WITH loc_oPagina.cmd_4c_SubNiveis
602:             .Caption         = "Sub" + CHR(237) + "veis"
603:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
604:             .PicturePosition = 13
605:             .Top             = 154
606:             .Left            = 833
607:             .Width           = 137
608:             .Height          = 40
609:             .BackColor       = RGB(255, 255, 255)
610:             .ForeColor       = RGB(90, 90, 90)
611:             .FontName        = "Comic Sans MS"
612:             .FontSize        = 8
613:             .FontBold        = .T.
614:             .FontItalic      = .T.
615:             .Themes          = .F.
616:             .SpecialEffect   = 0
617:             .MousePointer    = 15

*-- Linhas 624 a 755:
624:         *-- Original: top=173+29=202, left=27, width=582, height=164
625:         loc_oPagina.AddObject("cnt_4c_Origem", "Container")
626:         WITH loc_oPagina.cnt_4c_Origem
627:             .Top         = 202
628:             .Left        = 27
629:             .Width       = 582
630:             .Height      = 164
631:             .BackStyle   = 1
632:             .BackColor   = RGB(255, 255, 255)
633:             .SpecialEffect = 0
634:             .Visible     = .T.
635:         ENDWITH
636: 
637:         *-- Labels de secao (Origem, Destino, Representante)
638:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_LblOrigem", "Label")
639:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_LblOrigem
640:             .Caption   = "Origem"
641:             .Top       = 5
642:             .Left      = 5
643:             .FontName  = "Tahoma"
644:             .FontSize  = 8
645:             .FontBold  = .T.
646:             .ForeColor = RGB(90, 90, 90)
647:             .BackStyle = 0
648:             .AutoSize  = .F.
649:             .Visible   = .T.
650:         ENDWITH
651: 
652:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_LblDestino", "Label")
653:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_LblDestino
654:             .Caption   = "Destino"
655:             .Top       = 59
656:             .Left      = 5
657:             .FontName  = "Tahoma"
658:             .FontSize  = 8
659:             .FontBold  = .T.
660:             .ForeColor = RGB(90, 90, 90)
661:             .BackStyle = 0
662:             .AutoSize  = .F.
663:             .Visible   = .T.
664:         ENDWITH
665: 
666:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_LblRepres", "Label")
667:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_LblRepres
668:             .Caption   = "Representante"
669:             .Top       = 113
670:             .Left      = 5
671:             .FontName  = "Tahoma"
672:             .FontSize  = 8
673:             .FontBold  = .T.
674:             .ForeColor = RGB(90, 90, 90)
675:             .BackStyle = 0
676:             .AutoSize  = .F.
677:             .Visible   = .T.
678:         ENDWITH
679: 
680:         *-- Labels Grupo/Conta (linha Origem: top=30, linha Destino: top=85, linha Repres: top=138)
681:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_GrupO1", "Label")
682:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_GrupO1
683:             .Caption   = "Grupo :"
684:             .Top       = 30
685:             .Left      = 19
686:             .FontName  = "Tahoma"
687:             .FontSize  = 8
688:             .ForeColor = RGB(90, 90, 90)
689:             .BackStyle = 0
690:             .AutoSize  = .F.
691:             .Visible   = .T.
692:         ENDWITH
693: 
694:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_ContO1", "Label")
695:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_ContO1
696:             .Caption   = "Conta :"
697:             .Top       = 30
698:             .Left      = 154
699:             .FontName  = "Tahoma"
700:             .FontSize  = 8
701:             .ForeColor = RGB(90, 90, 90)
702:             .BackStyle = 0
703:             .AutoSize  = .F.
704:             .Visible   = .T.
705:         ENDWITH
706: 
707:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_GrupD1", "Label")
708:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_GrupD1
709:             .Caption   = "Grupo :"
710:             .Top       = 85
711:             .Left      = 19
712:             .FontName  = "Tahoma"
713:             .FontSize  = 8
714:             .ForeColor = RGB(90, 90, 90)
715:             .BackStyle = 0
716:             .AutoSize  = .F.
717:             .Visible   = .T.
718:         ENDWITH
719: 
720:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_ContD1", "Label")
721:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_ContD1
722:             .Caption   = "Conta :"
723:             .Top       = 85
724:             .Left      = 154
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .ForeColor = RGB(90, 90, 90)
728:             .BackStyle = 0
729:             .AutoSize  = .F.
730:             .Visible   = .T.
731:         ENDWITH
732: 
733:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_GrupR1", "Label")
734:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_GrupR1
735:             .Caption   = "Grupo :"
736:             .Top       = 138
737:             .Left      = 19
738:             .FontName  = "Tahoma"
739:             .FontSize  = 8
740:             .ForeColor = RGB(90, 90, 90)
741:             .BackStyle = 0
742:             .AutoSize  = .F.
743:             .Visible   = .T.
744:         ENDWITH
745: 
746:         loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_ContR1", "Label")
747:         WITH loc_oPagina.cnt_4c_Origem.lbl_4c_ContR1
748:             .Caption   = "Conta :"
749:             .Top       = 138
750:             .Left      = 154
751:             .FontName  = "Tahoma"
752:             .FontSize  = 8
753:             .ForeColor = RGB(90, 90, 90)
754:             .BackStyle = 0
755:             .AutoSize  = .F.

*-- Linhas 761 a 770:
761:         WITH loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOs
762:             .Value         = ""
763:             .ReadOnly      = .T.
764:             .Top           = 27
765:             .Left          = 61
766:             .Width         = 80
767:             .Height        = 21
768:             .FontName      = "Tahoma"
769:             .FontSize      = 8
770:             .FontBold      = .T.

*-- Linhas 778 a 787:
778:         WITH loc_oPagina.cnt_4c_Origem.txt_4c_ContaOs
779:             .Value         = ""
780:             .ReadOnly      = .T.
781:             .Top           = 27
782:             .Left          = 197
783:             .Width         = 80
784:             .Height        = 21
785:             .FontName      = "Tahoma"
786:             .FontSize      = 8
787:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 794 a 803:
794:         WITH loc_oPagina.cnt_4c_Origem.txt_4c_Dconta
795:             .Value         = ""
796:             .ReadOnly      = .T.
797:             .Top           = 27
798:             .Left          = 277
799:             .Width         = 267
800:             .Height        = 21
801:             .FontName      = "Tahoma"
802:             .FontSize      = 8
803:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 811 a 820:
811:         WITH loc_oPagina.cnt_4c_Origem.txt_4c_GrupoDs
812:             .Value         = ""
813:             .ReadOnly      = .T.
814:             .Top           = 82
815:             .Left          = 61
816:             .Width         = 80
817:             .Height        = 21
818:             .FontName      = "Tahoma"
819:             .FontSize      = 8
820:             .FontBold      = .T.

*-- Linhas 828 a 837:
828:         WITH loc_oPagina.cnt_4c_Origem.txt_4c_ContaD
829:             .Value         = ""
830:             .ReadOnly      = .T.
831:             .Top           = 82
832:             .Left          = 196
833:             .Width         = 80
834:             .Height        = 21
835:             .FontName      = "Tahoma"
836:             .FontSize      = 8
837:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 844 a 853:
844:         WITH loc_oPagina.cnt_4c_Origem.txt_4c_Dcontad
845:             .Value         = ""
846:             .ReadOnly      = .T.
847:             .Top           = 82
848:             .Left          = 277
849:             .Width         = 267
850:             .Height        = 21
851:             .FontName      = "Tahoma"
852:             .FontSize      = 8
853:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 861 a 870:
861:         WITH loc_oPagina.cnt_4c_Origem.txt_4c_GruResp
862:             .Value         = ""
863:             .ReadOnly      = .T.
864:             .Top           = 135
865:             .Left          = 61
866:             .Width         = 80
867:             .Height        = 21
868:             .FontName      = "Tahoma"
869:             .FontSize      = 8
870:             .FontBold      = .T.

*-- Linhas 878 a 887:
878:         WITH loc_oPagina.cnt_4c_Origem.txt_4c_Resps
879:             .Value         = ""
880:             .ReadOnly      = .T.
881:             .Top           = 135
882:             .Left          = 195
883:             .Width         = 80
884:             .Height        = 21
885:             .FontName      = "Tahoma"
886:             .FontSize      = 8
887:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 894 a 921:
894:         WITH loc_oPagina.cnt_4c_Origem.txt_4c_Dresps
895:             .Value         = ""
896:             .ReadOnly      = .T.
897:             .Top           = 135
898:             .Left          = 277
899:             .Width         = 267
900:             .Height        = 21
901:             .FontName      = "Tahoma"
902:             .FontSize      = 8
903:             .ForeColor     = RGB(0, 0, 0)
904:             .BackColor     = RGB(255, 255, 255)
905:             .BorderStyle   = 1
906:             .Visible       = .T.
907:         ENDWITH
908: 
909:         *-- Botao acesso cadastro conta destino (btnCadastros: top=79, left=549, w=27, h=31)
910:         loc_oPagina.cnt_4c_Origem.AddObject("cmd_4c_BtnCadastros", "CommandButton")
911:         WITH loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros
912:             .Caption         = ""
913:             .Picture         = gc_4c_CaminhoIcones + "geral_pastas_28.jpg"
914:             .PicturePosition = 0
915:             .Top             = 79
916:             .Left            = 549
917:             .Width           = 27
918:             .Height          = 31
919:             .BackColor       = RGB(255, 255, 255)
920:             .ForeColor       = RGB(90, 90, 90)
921:             .FontName        = "Tahoma"

*-- Linhas 929 a 949:
929:         *-- Container de Observacoes do movimento (Container1: top=173+29=202, left=614)
930:         loc_oPagina.AddObject("cnt_4c_Container1", "Container")
931:         WITH loc_oPagina.cnt_4c_Container1
932:             .Top       = 202
933:             .Left      = 614
934:             .Width     = 373
935:             .Height    = 164
936:             .BackStyle = 0
937:             .Visible   = .T.
938:         ENDWITH
939: 
940:         loc_oPagina.cnt_4c_Container1.AddObject("lbl_4c_ObsCnt", "Label")
941:         WITH loc_oPagina.cnt_4c_Container1.lbl_4c_ObsCnt
942:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
943:             .Top       = 3
944:             .Left      = 7
945:             .Width     = 69
946:             .Height    = 15
947:             .FontName  = "Tahoma"
948:             .FontSize  = 8
949:             .FontBold  = .T.

*-- Linhas 957 a 966:
957:         WITH loc_oPagina.cnt_4c_Container1.txt_4c_MemoObs
958:             .Value     = ""
959:             .ReadOnly  = .T.
960:             .Top       = 20
961:             .Left      = 7
962:             .Width     = 359
963:             .Height    = 138
964:             .FontName  = "Tahoma"
965:             .FontSize  = 8
966:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 973 a 982:
973:         loc_oPagina.AddObject("grd_4c_Itens", "Grid")
974:         loc_oPagina.grd_4c_Itens.ColumnCount = 10
975:         WITH loc_oPagina.grd_4c_Itens
976:             .Top                = 379
977:             .Left               = 23
978:             .Width              = 732
979:             .Height             = 191
980:             .DeleteMark         = .F.
981:             .RecordMark         = .F.
982:             .AllowHeaderSizing  = .F.

*-- Linhas 996 a 1008:
996:         ENDWITH
997: 
998:         *-- Label Descricao do item (Say2: top=546+29=575, left=23)
999:         loc_oPagina.AddObject("lbl_4c_DescItem", "Label")
1000:         WITH loc_oPagina.lbl_4c_DescItem
1001:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1002:             .Top       = 575
1003:             .Left      = 23
1004:             .FontName  = "Tahoma"
1005:             .FontSize  = 8
1006:             .ForeColor = RGB(90, 90, 90)
1007:             .BackStyle = 0
1008:             .AutoSize  = .F.

*-- Linhas 1014 a 1039:
1014:         WITH loc_oPagina.txt_4c_Descr
1015:             .Value         = ""
1016:             .ReadOnly      = .T.
1017:             .Top           = 591
1018:             .Left          = 23
1019:             .Width         = 454
1020:             .Height        = 23
1021:             .FontName      = "Tahoma"
1022:             .FontSize      = 8
1023:             .ForeColor     = RGB(0, 0, 0)
1024:             .BackColor     = RGB(255, 255, 255)
1025:             .BorderStyle   = 1
1026:             .Visible       = .T.
1027:         ENDWITH
1028: 
1029:         *-- Label Observacao do item (Say_Obs: top=544+29=573, left=496)
1030:         loc_oPagina.AddObject("lbl_4c_ObsItem", "Label")
1031:         WITH loc_oPagina.lbl_4c_ObsItem
1032:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do item"
1033:             .Top       = 573
1034:             .Left      = 496
1035:             .FontName  = "Tahoma"
1036:             .FontSize  = 8
1037:             .ForeColor = RGB(90, 90, 90)
1038:             .BackStyle = 0
1039:             .AutoSize  = .F.

*-- Linhas 1045 a 1084:
1045:         WITH loc_oPagina.txt_4c_ObsItem
1046:             .Value     = ""
1047:             .ReadOnly  = .T.
1048:             .Top       = 590
1049:             .Left      = 496
1050:             .Width     = 454
1051:             .Height    = 24
1052:             .FontName  = "Tahoma"
1053:             .FontSize  = 8
1054:             .ForeColor = RGB(0, 0, 0)
1055:             .BackColor = RGB(255, 255, 255)
1056:             .Visible   = .T.
1057:         ENDWITH
1058: 
1059:         *-- Imagem do produto (FigJpg: top=365+29=394, left=762, width=225, height=163, Visible=.F.)
1060:         loc_oPagina.AddObject("img_4c_FigJpg", "Image")
1061:         WITH loc_oPagina.img_4c_FigJpg
1062:             .Top     = 394
1063:             .Left    = 762
1064:             .Width   = 225
1065:             .Height  = 163
1066:             .Stretch = 1
1067:             .Visible = .F.
1068:         ENDWITH
1069: 
1070:         *-- BINDEVENTs (metodos PUBLIC para funcionar com BINDEVENT)
1071:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", ;
1072:                   THIS, "BtnConfirmarClick")
1073:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", ;
1074:                   THIS, "BtnCancelarClick")
1075:         BINDEVENT(loc_oPagina.cmd_4c_Entrega, "Click", ;
1076:                   THIS, "BtnEntregaClick")
1077:         BINDEVENT(loc_oPagina.cmd_4c_SubNiveis, "Click", ;
1078:                   THIS, "BtnSubNiveisClick")
1079:         BINDEVENT(loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros, "Click", ;
1080:                   THIS, "BtnCadastrosClick")
1081:         BINDEVENT(loc_oPagina.grd_4c_Itens, "AfterRowColChange", ;
1082:                   THIS, "GrdItensAfterRowColChange")
1083:         BINDEVENT(loc_oPagina.img_4c_FigJpg, "Click", ;
1084:                   THIS, "ImgFigJpgClick")

*-- Linhas 1133 a 1151:
1133:                         loc_oGrid.Column11.Width = 55
1134: 
1135:                         *-- Headers APOS RecordSource (RecordSource reseta captions - Problem 2)
1136:                         loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
1137:                         loc_oGrid.Column2.Header1.Caption  = "Data"
1138:                         loc_oGrid.Column3.Header1.Caption  = "Grupo"
1139:                         loc_oGrid.Column4.Header1.Caption  = "Origem"
1140:                         loc_oGrid.Column5.Header1.Caption  = "Grupo"
1141:                         loc_oGrid.Column6.Header1.Caption  = "Destino"
1142:                         loc_oGrid.Column7.Header1.Caption  = "Doc.Op"
1143:                         loc_oGrid.Column8.Header1.Caption  = "Usu" + CHR(225) + "rio"
1144:                         loc_oGrid.Column9.Header1.Caption  = "Status"
1145:                         loc_oGrid.Column10.Header1.Caption = "EmpO"
1146:                         loc_oGrid.Column11.Header1.Caption = "EmpD"
1147: 
1148:                         loc_oGrid.Refresh()
1149:                     ENDIF
1150: 
1151:                     loc_lResultado = .T.

*-- Linhas 1327 a 1335:
1327:                         loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1328:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Operacoes.Dopes"
1329:                         loc_oGrid.Column1.Width = 110
1330:                         loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1331:                         loc_oGrid.Refresh()
1332:                     ENDIF
1333: 
1334:                     loc_lSucesso = .T.
1335:                 ELSE

*-- Linhas 1593 a 1610:
1593:                             loc_oGrid.Column9.Width  = 45
1594:                             loc_oGrid.Column10.Width = 40
1595: 
1596:                             loc_oGrid.Column1.Header1.Caption  = "Produto"
1597:                             loc_oGrid.Column2.Header1.Caption  = "Produzido"
1598:                             loc_oGrid.Column3.Header1.Caption  = "Qtd."
1599:                             loc_oGrid.Column4.Header1.Caption  = "Saldo"
1600:                             loc_oGrid.Column5.Header1.Caption  = "Qtd.Baixa"
1601:                             loc_oGrid.Column6.Header1.Caption  = "Produzir"
1602:                             loc_oGrid.Column7.Header1.Caption  = ""
1603:                             loc_oGrid.Column8.Header1.Caption  = "Peso"
1604:                             loc_oGrid.Column9.Header1.Caption  = "%Ent."
1605:                             loc_oGrid.Column10.Header1.Caption = "Tam."
1606: 
1607:                             loc_oGrid.Refresh()
1608: 
1609:                             IF RECCOUNT("cursor_4c_ItensPam") > 0
1610:                                 SELECT cursor_4c_ItensPam

*-- Linhas 1927 a 1955:
1927: 
1928:             *-- Page1: botao Consultar habilitado apenas no modo LISTA
1929:             IF VARTYPE(loc_oPg1.cnt_4c_Botoes) = "O"
1930:                 IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Consultar) = "O"
1931:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Consultar.Enabled = loc_lLista
1932:                 ENDIF
1933:             ENDIF
1934: 
1935:             *-- Page2: botoes de acao habilitados apenas no modo VISUALIZAR
1936:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
1937:                 IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar) = "O"
1938:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lLista
1939:                 ENDIF
1940:                 IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar) = "O"
1941:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = !loc_lLista
1942:                 ENDIF
1943:             ENDIF
1944: 
1945:             IF VARTYPE(loc_oPg2.cmd_4c_SubNiveis) = "O"
1946:                 loc_oPg2.cmd_4c_SubNiveis.Enabled = !loc_lLista
1947:             ENDIF
1948: 
1949:             IF VARTYPE(loc_oPg2.cmd_4c_Entrega) = "O"
1950:                 loc_oPg2.cmd_4c_Entrega.Enabled = !loc_lLista
1951:             ENDIF
1952:         CATCH TO loException
1953:             MostrarErro(loException, "Formsigpres2.AjustarBotoesPorModo")
1954:         ENDTRY
1955:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigpres2BO.prg):
*==============================================================================
* sigpres2BO.prg - Business Object para SIGPRES2 (Detalhe de Movimento)
* Herda de BusinessBase
* Formulario OPERACIONAL - consulta de itens de movimento de pedido
*==============================================================================

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Chave composta do movimento: Emps+Dopes+Str(Numes,6) padded
    this_cEmpDopNums = ""

    *-- Identificacao do movimento
    this_cEmps        = ""  && Empresa origem C(3)
    this_cDopes       = ""  && Tipo de operacao C(20)
    this_nNumes       = 0   && Numero do movimento N(6,0)
    this_cChave       = ""  && _Chave passado no Init (= Dopes)
    this_cMascNum     = ""  && Codigo mascarado do movimento C(10) - SigMvCab.mascnum

    *-- Cabecalho do movimento (SigMvCab)
    this_dDatas       = {}  && Data do movimento D - SigMvCab.datas
    this_cNotas       = ""  && Numero do documento C(6) - SigMvCab.notas
    this_nNops        = 0   && Numero da OP N - SigMvCab.nops
    this_cPStatus     = ""  && Status do pedido C(1) - SigMvCab.pstatus
    this_cTabds       = ""  && Tabela de desconto C(10) - SigMvCab.tabds
    this_cUsuars      = ""  && Usuario C(10) - SigMvCab.usuars
    this_dPrazoEnts   = {}  && Prazo de entrega D - SigMvCab.prazoents
    this_cObses       = ""  && Observacoes do movimento C/M - SigMvCab.obses
    this_lChkSubn     = .F. && Possui sub-niveis L - SigMvCab.chksubn
    this_lChkBxParcs  = .F. && Baixa parcial L - SigMvCab.chkbxparcs

    *-- Origem (conta origem) - SigMvCab
    this_cGrupoOs     = ""  && Grupo de conta origem C(10) - SigMvCab.grupoos
    this_cContaOs     = ""  && Conta origem C(10) - SigMvCab.contaos
    this_cDContaOs    = ""  && Descricao da conta origem C (de SigCdCli)

    *-- Destino (conta destino) - SigMvCab
    this_cGrupoDs     = ""  && Grupo de conta destino C(10) - SigMvCab.grupods
    this_cContaDs     = ""  && Conta destino C(10) - SigMvCab.contads
    this_cDContaDs    = ""  && Descricao da conta destino C (de SigCdCli)
    this_cEmpds       = ""  && Empresa destino C(3) - SigMvCab.empds

    *-- Vendedor - SigMvCab
    this_cGrvends     = ""  && Grupo do vendedor C(10) - SigMvCab.grvends
    this_cVends       = ""  && Codigo do vendedor C(10) - SigMvCab.vends
    this_cDVends      = ""  && Descricao do vendedor C (de SigCdCli)

    *-- Representante - SigMvCab
    this_cGrresps     = ""  && Grupo do representante C(10) - SigMvCab.grresps
    this_cResps       = ""  && Codigo do representante C(10) - SigMvCab.resps
    this_cDResps      = ""  && Descricao do representante C (de SigCdCli)

    *-- Configuracao da operacao (SigCdOpe)
    this_nBlqDatas    = 0   && Bloqueio de datas N - SigCdOpe.blqdatas
    this_nDtEntrs     = 0   && Tipo de entrega N - SigCdOpe.dtentrs

    *-- Tipo de instalacao (global gcTpInstalas)
    this_cTpInstalas  = ""  && Tipo de instalacao C

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de movimentos filtrados pelo Dopes (operacao)
    * par_cFiltro: filtro SQL adicional (WHERE clause extra, sem WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Emps, a.Dopes, a.Numes," + ;
                       " a.Datas, a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs," + ;
                       " a.Nops, a.Usuars, a.PStatus, a.Empds" + ;
                       " FROM SigMvCab a" + ;
                       " WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes)

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Numes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar movimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega cabecalho do movimento por EmpDopNums
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Emps, a.Dopes, a.Numes, a.MascNum," + ;
                       " a.Datas, a.Notas, a.Nops, a.PStatus, a.Tabds, a.Usuars," + ;
                       " a.PrazoEnts, a.Obses, a.ChkSubn, a.ChkBxParcs," + ;
                       " a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.Empds," + ;
                       " a.Vends, a.Grvends, a.Resps, a.Grresps" + ;
                       " FROM SigMvCab a" + ;
                       " WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lSucesso
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * REGRA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmpDopNums  = ALLTRIM(TratarNulo(EmpDopNums, "C"))
            THIS.this_cEmps        = ALLTRIM(TratarNulo(Emps, "C"))
            THIS.this_cDopes       = ALLTRIM(TratarNulo(Dopes, "C"))
            THIS.this_nNumes       = TratarNulo(Numes, "N")

            *-- MascNum so existe no cursor completo (CarregarPorCodigo)
            IF TYPE("MascNum") != "U"
                THIS.this_cMascNum = ALLTRIM(TratarNulo(MascNum, "C"))
            ENDIF

            THIS.this_dDatas       = TratarNulo(Datas, "D")
            THIS.this_dPrazoEnts   = TratarNulo(PrazoEnts, "D")
            THIS.this_cNotas       = ALLTRIM(TratarNulo(Notas, "C"))
            THIS.this_nNops        = TratarNulo(Nops, "N")
            THIS.this_cPStatus     = ALLTRIM(TratarNulo(PStatus, "C"))
            THIS.this_cTabds       = ALLTRIM(TratarNulo(Tabds, "C"))
            THIS.this_cUsuars      = ALLTRIM(TratarNulo(Usuars, "C"))
            THIS.this_cObses       = TratarNulo(Obses, "C")
            THIS.this_lChkSubn     = (TratarNulo(ChkSubn, "N") = 1)
            THIS.this_lChkBxParcs  = (TratarNulo(ChkBxParcs, "N") = 1)

            THIS.this_cGrupoOs     = ALLTRIM(TratarNulo(GrupoOs, "C"))
            THIS.this_cContaOs     = ALLTRIM(TratarNulo(ContaOs, "C"))
            THIS.this_cGrupoDs     = ALLTRIM(TratarNulo(GrupoDs, "C"))
            THIS.this_cContaDs     = ALLTRIM(TratarNulo(ContaDs, "C"))
            THIS.this_cEmpds       = ALLTRIM(TratarNulo(Empds, "C"))

            THIS.this_cGrvends     = ALLTRIM(TratarNulo(Grvends, "C"))
            THIS.this_cVends       = ALLTRIM(TratarNulo(Vends, "C"))
            THIS.this_cGrresps     = ALLTRIM(TratarNulo(Grresps, "C"))
            THIS.this_cResps       = ALLTRIM(TratarNulo(Resps, "C"))

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega itens do movimento (SigMvPec) por EmpDopNums
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Codigos, a.Emps, a.Dopes, a.Numes," + ;
                       " a.Datas, a.Ntrans, a.Locals, a.Valobxs, a.Cidchaves," + ;
                       " a.ChkSubn, a.ChkPagos, a.Nparcs, a.Valps, a.PStatus" + ;
                       " FROM SigMvPec a" + ;
                       " WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + ;
                       " ORDER BY a.Codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarItens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - Carrega configuracao da operacao (SigCdOpe)
    * Popula this_nBlqDatas e this_nDtEntrs
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacao(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF

            loc_cSQL = "SELECT a.Dopes, a.BlqDatas, a.DtEntrs" + ;
                       " FROM SigCdOpe a" + ;
                       " WHERE a.Dopes = " + EscaparSQL(par_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Operacao") > 0
                SELECT cursor_4c_Operacao
                THIS.this_nBlqDatas = TratarNulo(BlqDatas, "N")
                THIS.this_nDtEntrs  = TratarNulo(DtEntrs, "N")
                loc_lSucesso = .T.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar opera" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarOperacao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Operacao")
            USE IN cursor_4c_Operacao
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricaoConta - Carrega descricao de uma conta (SigCdCli)
    * Retorna a descricao ou string vazia se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricaoConta(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF EMPTY(par_cConta)
            RETURN loc_cDescricao
        ENDIF

        TRY
            IF USED("cursor_4c_DescConta")
                USE IN cursor_4c_DescConta
            ENDIF

            loc_cSQL = "SELECT TOP 1 a.IClis, a.Rclis" + ;
                       " FROM SigCdCli a" + ;
                       " WHERE a.IClis = " + EscaparSQL(par_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescConta")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescConta") > 0
                SELECT cursor_4c_DescConta
                loc_cDescricao = ALLTRIM(TratarNulo(Rclis, "C"))
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarDescricaoConta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_DescConta")
            USE IN cursor_4c_DescConta
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO aplicavel para este formulario operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        MsgErro("Inser" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
                CHR(237) + "vel neste formul" + CHR(225) + "rio.", "Aviso")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvCab (data, contas origem/destino, obs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cEmpDopNums)
            MsgErro("Chave do movimento n" + CHR(227) + "o definida.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigMvCab SET" + ;
                       " Datas = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " GrupoOs = " + EscaparSQL(THIS.this_cGrupoOs) + "," + ;
                       " ContaOs = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
                       " GrupoDs = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
                       " ContaDs = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
                       " Vends = " + EscaparSQL(THIS.this_cVends) + "," + ;
                       " Grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
                       " PrazoEnts = " + FormatarDataSQL(THIS.this_dPrazoEnts) + "," + ;
                       " Notas = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                       " Tabds = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                       " Obses = " + EscaparSQL(THIS.this_cObses) + "," + ;
                       " DtAlts = GETDATE()" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - NAO aplicavel para este formulario operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        MsgErro("Exclus" + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
                CHR(237) + "vel neste formul" + CHR(225) + "rio.", "Aviso")
        RETURN .F.
    ENDPROC

ENDDEFINE

