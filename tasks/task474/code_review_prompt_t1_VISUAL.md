# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 189: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 214: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 239: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 264: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 289: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 327: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 402: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 427: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormNcf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1128 linhas total):

*-- Linhas 51 a 69:
51:         loc_lResultado = .F.
52: 
53:         TRY
54:             THIS.Caption = "Cadastro de N" + CHR(227) + "o-Conformidades"
55: 
56:             THIS.this_oBusinessObject = CREATEOBJECT("NcfBO")
57: 
58:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
59:                 MsgErro("Falha ao criar NcfBO", "Erro")
60:             ELSE
61:                 THIS.ConfigurarPageFrame()
62: 
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65: 
66:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
67:                     THIS.CarregarLista()
68:                 ENDIF
69: 

*-- Linhas 89 a 106:
89: 
90:         WITH loc_oPgf
91:             .PageCount       = 2
92:             .Top             = -29
93:             .Left            = 0
94:             .Width           = THIS.Width
95:             .Height          = THIS.Height + 29
96:             .Tabs            = .F.
97:             .Visible         = .T.
98:             .Page1.Caption   = "Lista"
99:             .Page1.BackColor = RGB(100, 100, 100)
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Caption   = "Dados"
102:             .Page2.BackColor = RGB(100, 100, 100)
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()

*-- Linhas 119 a 157:
119:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
120:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
121:         WITH loc_oCab
122:             .Top         = 31
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130: 
131:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oCab.lbl_4c_Sombra
133:             .AutoSize  = .F.
134:             .Caption   = THIS.Caption
135:             .Top       = 15
136:             .Left      = 10
137:             .Width     = THIS.Width
138:             .Height    = 40
139:             .FontName  = "Tahoma"
140:             .FontSize  = 16
141:             .FontBold  = .T.
142:             .ForeColor = RGB(0, 0, 0)
143:             .BackStyle = 0
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
148:         WITH loc_oCab.lbl_4c_Titulo
149:             .AutoSize  = .F.
150:             .Caption   = THIS.Caption
151:             .Top       = 18
152:             .Left      = 10
153:             .Width     = THIS.Width
154:             .Height    = 46
155:             .FontName  = "Tahoma"
156:             .FontSize  = 16
157:             .FontBold  = .T.

*-- Linhas 164 a 352:
164:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
165:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
166:         WITH loc_oBotoes
167:             .Top         = 29
168:             .Left        = 542
169:             .Width       = 390
170:             .Height      = 85
171:             .BackColor   = RGB(53, 53, 53)
172:             .BackStyle   = 1
173:             .BorderWidth = 0
174:             .Visible     = .T.
175:         ENDWITH
176: 
177:         *-- Botao Incluir
178:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
179:         WITH loc_oBotoes.cmd_4c_Incluir
180:             .Caption         = "Incluir"
181:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
182:             .PicturePosition = 13
183:             .Top             = 5
184:             .Left            = 5
185:             .Width           = 75
186:             .Height          = 75
187:             .BackColor       = RGB(255, 255, 255)
188:             .ForeColor       = RGB(90, 90, 90)
189:             .FontName        = "Comic Sans MS"
190:             .FontSize        = 8
191:             .FontBold        = .T.
192:             .FontItalic      = .T.
193:             .Themes          = .F.
194:             .SpecialEffect   = 0
195:             .MousePointer    = 15
196:             .WordWrap        = .T.
197:             .AutoSize        = .F.
198:             .Visible         = .T.
199:         ENDWITH
200:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
201: 
202:         *-- Botao Visualizar
203:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
204:         WITH loc_oBotoes.cmd_4c_Visualizar
205:             .Caption         = "Visualizar"
206:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
207:             .PicturePosition = 13
208:             .Top             = 5
209:             .Left            = 80
210:             .Width           = 75
211:             .Height          = 75
212:             .BackColor       = RGB(255, 255, 255)
213:             .ForeColor       = RGB(90, 90, 90)
214:             .FontName        = "Comic Sans MS"
215:             .FontSize        = 8
216:             .FontBold        = .T.
217:             .FontItalic      = .T.
218:             .Themes          = .F.
219:             .SpecialEffect   = 0
220:             .MousePointer    = 15
221:             .WordWrap        = .T.
222:             .AutoSize        = .F.
223:             .Visible         = .T.
224:         ENDWITH
225:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
226: 
227:         *-- Botao Alterar
228:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
229:         WITH loc_oBotoes.cmd_4c_Alterar
230:             .Caption         = "Alterar"
231:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
232:             .PicturePosition = 13
233:             .Top             = 5
234:             .Left            = 155
235:             .Width           = 75
236:             .Height          = 75
237:             .BackColor       = RGB(255, 255, 255)
238:             .ForeColor       = RGB(90, 90, 90)
239:             .FontName        = "Comic Sans MS"
240:             .FontSize        = 8
241:             .FontBold        = .T.
242:             .FontItalic      = .T.
243:             .Themes          = .F.
244:             .SpecialEffect   = 0
245:             .MousePointer    = 15
246:             .WordWrap        = .T.
247:             .AutoSize        = .F.
248:             .Visible         = .T.
249:         ENDWITH
250:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
251: 
252:         *-- Botao Excluir
253:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
254:         WITH loc_oBotoes.cmd_4c_Excluir
255:             .Caption         = "Excluir"
256:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
257:             .PicturePosition = 13
258:             .Top             = 5
259:             .Left            = 230
260:             .Width           = 75
261:             .Height          = 75
262:             .BackColor       = RGB(255, 255, 255)
263:             .ForeColor       = RGB(90, 90, 90)
264:             .FontName        = "Comic Sans MS"
265:             .FontSize        = 8
266:             .FontBold        = .T.
267:             .FontItalic      = .T.
268:             .Themes          = .F.
269:             .SpecialEffect   = 0
270:             .MousePointer    = 15
271:             .WordWrap        = .T.
272:             .AutoSize        = .F.
273:             .Visible         = .T.
274:         ENDWITH
275:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
276: 
277:         *-- Botao Buscar
278:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
279:         WITH loc_oBotoes.cmd_4c_Buscar
280:             .Caption         = "Buscar"
281:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
282:             .PicturePosition = 13
283:             .Top             = 5
284:             .Left            = 305
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
300:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
301: 
302:         *-- Container saida canonico (Left=917, Width=90, transparente)
303:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
304:         loc_oSaida = loc_oPg1.cnt_4c_Saida
305:         WITH loc_oSaida
306:             .Top         = 29
307:             .Left        = 917
308:             .Width       = 90
309:             .Height      = 85
310:             .BackStyle   = 0
311:             .BorderWidth = 0
312:             .Visible     = .T.
313:         ENDWITH
314: 
315:         *-- Botao Encerrar (canonico)
316:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
317:         WITH loc_oSaida.cmd_4c_Encerrar
318:             .Caption         = "Encerrar"
319:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
320:             .PicturePosition = 13
321:             .Top             = 5
322:             .Left            = 5
323:             .Width           = 75
324:             .Height          = 75
325:             .BackColor       = RGB(255, 255, 255)
326:             .ForeColor       = RGB(90, 90, 90)
327:             .FontName        = "Comic Sans MS"
328:             .FontSize        = 8
329:             .FontBold        = .T.
330:             .FontItalic      = .T.
331:             .Themes          = .F.
332:             .SpecialEffect   = 0
333:             .MousePointer    = 15
334:             .WordWrap        = .T.
335:             .AutoSize        = .F.
336:             .Visible         = .T.
337:         ENDWITH
338:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
339: 
340:         *-- Grid de lista: top=121+29=150 (compensacao PageFrame), left=12, width=940, height=470
341:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
342:         loc_oGrid = loc_oPg1.grd_4c_Lista
343:         loc_oGrid.RecordSource = ""
344:         loc_oGrid.ColumnCount  = 2
345:         WITH loc_oGrid
346:             .Top                = 150
347:             .Left               = 12
348:             .Width              = 940
349:             .Height             = 470
350:             .FontName           = "Verdana"
351:             .FontSize           = 8
352:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 378 a 451:
378:         loc_oPg2.AddObject("cnt_4c_Salva", "Container")
379:         loc_oSalva = loc_oPg2.cnt_4c_Salva
380:         WITH loc_oSalva
381:             .Top         = 52
382:             .Left        = 616
383:             .Width       = 160
384:             .Height      = 85
385:             .BackStyle   = 0
386:             .BorderWidth = 0
387:             .Visible     = .T.
388:         ENDWITH
389: 
390:         *-- Botao Confirmar (Salva original: Left=5, Top=5)
391:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
392:         WITH loc_oSalva.cmd_4c_Confirmar
393:             .Caption         = "Confirmar"
394:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
395:             .PicturePosition = 13
396:             .Top             = 5
397:             .Left            = 5
398:             .Width           = 75
399:             .Height          = 75
400:             .BackColor       = RGB(255, 255, 255)
401:             .ForeColor       = RGB(90, 90, 90)
402:             .FontName        = "Comic Sans MS"
403:             .FontSize        = 8
404:             .FontBold        = .T.
405:             .FontItalic      = .T.
406:             .Themes          = .F.
407:             .SpecialEffect   = 0
408:             .MousePointer    = 15
409:             .WordWrap        = .T.
410:             .AutoSize        = .F.
411:             .Visible         = .T.
412:         ENDWITH
413:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
414: 
415:         *-- Botao Cancelar (Cancelar original: Left=80, Top=5)
416:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
417:         WITH loc_oSalva.cmd_4c_Cancelar
418:             .Caption         = "Encerrar"
419:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
420:             .PicturePosition = 13
421:             .Top             = 5
422:             .Left            = 80
423:             .Width           = 75
424:             .Height          = 75
425:             .BackColor       = RGB(255, 255, 255)
426:             .ForeColor       = RGB(90, 90, 90)
427:             .FontName        = "Comic Sans MS"
428:             .FontSize        = 8
429:             .FontBold        = .T.
430:             .FontItalic      = .T.
431:             .Themes          = .F.
432:             .SpecialEffect   = 0
433:             .MousePointer    = 15
434:             .WordWrap        = .T.
435:             .AutoSize        = .F.
436:             .Visible         = .T.
437:         ENDWITH
438:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
439: 
440:         *-- Label Codigo (Label2: Top=237+29=266, Left=184, Width=42, Height=15)
441:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
442:         WITH loc_oPg2.lbl_4c_Label2
443:             .AutoSize  = .T.
444:             .Caption   = "C" + CHR(243) + "digo :"
445:             .Top       = 266
446:             .Left      = 184
447:             .Width     = 42
448:             .Height    = 15
449:             .FontName  = "Tahoma"
450:             .FontSize  = 8
451:             .BackStyle = 0

*-- Linhas 457 a 482:
457:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
458:         WITH loc_oPg2.txt_4c_Codigo
459:             .Value     = ""
460:             .Top       = 263
461:             .Left      = 234
462:             .Width     = 80
463:             .Height    = 23
464:             .FontName  = "Tahoma"
465:             .FontSize  = 8
466:             .ForeColor = RGB(0, 0, 0)
467:             .MaxLength = 10
468:             .Visible   = .T.
469:         ENDWITH
470: 
471:         *-- Label Descricao (Label1: Top=262+29=291, Left=171, Width=55, Height=15)
472:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
473:         WITH loc_oPg2.lbl_4c_Label1
474:             .AutoSize  = .T.
475:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
476:             .Top       = 291
477:             .Left      = 171
478:             .Width     = 55
479:             .Height    = 15
480:             .FontName  = "Tahoma"
481:             .FontSize  = 8
482:             .BackStyle = 0

*-- Linhas 488 a 649:
488:         loc_oPg2.AddObject("txt_4c_Descricao", "TextBox")
489:         WITH loc_oPg2.txt_4c_Descricao
490:             .Value     = ""
491:             .Top       = 288
492:             .Left      = 234
493:             .Width     = 430
494:             .Height    = 23
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .ForeColor = RGB(0, 0, 0)
498:             .MaxLength = 60
499:             .Visible   = .T.
500:         ENDWITH
501: 
502:         *-- Label "Descricao Fixa :" (Say9: Top=286+29=315, Left=148)
503:         loc_oPg2.AddObject("lbl_4c_Label9", "Label")
504:         WITH loc_oPg2.lbl_4c_Label9
505:             .AutoSize  = .T.
506:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fixa :"
507:             .Top       = 315
508:             .Left      = 148
509:             .FontName  = "Tahoma"
510:             .FontSize  = 8
511:             .BackStyle = 0
512:             .ForeColor = RGB(90, 90, 90)
513:             .Visible   = .T.
514:         ENDWITH
515: 
516:         *-- OptionGroup Descricao Fixa (Opt_Menu: fixos 1=Sim/2=Nao, Top=284+29=313, Left=231)
517:         loc_oPg2.AddObject("opt_4c_OptMenu", "OptionGroup")
518:         WITH loc_oPg2.opt_4c_OptMenu
519:             .ButtonCount   = 2
520:             .Value         = 2
521:             .Top           = 313
522:             .Left          = 231
523:             .Width         = 89
524:             .Height        = 20
525:             .SpecialEffect = 0
526:             .BackStyle     = 0
527:             .BorderStyle   = 0
528:             .Visible       = .T.
529:         ENDWITH
530:         WITH loc_oPg2.opt_4c_OptMenu.Buttons(1)
531:             .Caption   = "Sim"
532:             .BackStyle = 0
533:             .Left      = 4
534:             .Top       = 2
535:             .AutoSize  = .T.
536:             .Alignment = 0
537:             .FontName  = "Tahoma"
538:             .FontSize  = 8
539:             .ForeColor = RGB(90, 90, 90)
540:             .Themes    = .F.
541:             .Visible   = .T.
542:         ENDWITH
543:         WITH loc_oPg2.opt_4c_OptMenu.Buttons(2)
544:             .Caption   = "N" + CHR(227) + "o"
545:             .BackStyle = 0
546:             .Left      = 43
547:             .Top       = 2
548:             .AutoSize  = .T.
549:             .FontName  = "Tahoma"
550:             .FontSize  = 8
551:             .ForeColor = RGB(90, 90, 90)
552:             .Themes    = .F.
553:             .Visible   = .T.
554:         ENDWITH
555: 
556:         *-- Label "Tipo :" (Say1: Top=306+29=335, Left=197)
557:         loc_oPg2.AddObject("lbl_4c_LabelTipo", "Label")
558:         WITH loc_oPg2.lbl_4c_LabelTipo
559:             .AutoSize  = .T.
560:             .Caption   = "Tipo :"
561:             .Top       = 335
562:             .Left      = 197
563:             .FontName  = "Tahoma"
564:             .FontSize  = 8
565:             .BackStyle = 0
566:             .ForeColor = RGB(90, 90, 90)
567:             .Visible   = .T.
568:         ENDWITH
569: 
570:         *-- OptionGroup Tipo (get_tipo: tipos 1-4, Top=304+29=333, Left=231, Width=279, Height=43)
571:         loc_oPg2.AddObject("opt_4c_GetTipo", "OptionGroup")
572:         WITH loc_oPg2.opt_4c_GetTipo
573:             .ButtonCount   = 4
574:             .Value         = 1
575:             .Top           = 333
576:             .Left          = 231
577:             .Width         = 279
578:             .Height        = 43
579:             .SpecialEffect = 0
580:             .BackStyle     = 0
581:             .BorderStyle   = 0
582:             .Visible       = .T.
583:         ENDWITH
584:         WITH loc_oPg2.opt_4c_GetTipo.Buttons(1)
585:             .Caption   = "N" + CHR(227) + "o Conforme"
586:             .Left      = 4
587:             .Top       = 2
588:             .AutoSize  = .T.
589:             .Alignment = 0
590:             .FontName  = "Tahoma"
591:             .FontSize  = 8
592:             .BackStyle = 0
593:             .ForeColor = RGB(90, 90, 90)
594:             .Themes    = .F.
595:             .Visible   = .T.
596:         ENDWITH
597:         WITH loc_oPg2.opt_4c_GetTipo.Buttons(2)
598:             .Caption   = "Limite Qtd"
599:             .Left      = 115
600:             .Top       = 2
601:             .AutoSize  = .T.
602:             .FontName  = "Tahoma"
603:             .FontSize  = 8
604:             .BackStyle = 0
605:             .ForeColor = RGB(90, 90, 90)
606:             .Themes    = .F.
607:             .Visible   = .T.
608:         ENDWITH
609:         WITH loc_oPg2.opt_4c_GetTipo.Buttons(3)
610:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o Peso"
611:             .Left      = 4
612:             .Top       = 21
613:             .Width     = 85
614:             .Height    = 15
615:             .AutoSize  = .T.
616:             .FontName  = "Tahoma"
617:             .FontSize  = 8
618:             .BackStyle = 0
619:             .ForeColor = RGB(90, 90, 90)
620:             .Themes    = .F.
621:             .Visible   = .T.
622:         ENDWITH
623:         WITH loc_oPg2.opt_4c_GetTipo.Buttons(4)
624:             .Caption   = "Reposi" + CHR(231) + CHR(227) + "o S/Composi" + CHR(231) + CHR(227) + "o"
625:             .Left      = 115
626:             .Top       = 21
627:             .Width     = 137
628:             .Height    = 15
629:             .AutoSize  = .T.
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .BackStyle = 0
633:             .ForeColor = RGB(90, 90, 90)
634:             .Themes    = .F.
635:             .Visible   = .T.
636:         ENDWITH
637: 
638:         *-- Label "Empresa :" (Say20: Top=350+29=379, Left=176, Width=50, Height=15)
639:         loc_oPg2.AddObject("lbl_4c_Label20", "Label")
640:         WITH loc_oPg2.lbl_4c_Label20
641:             .AutoSize  = .T.
642:             .Caption   = "Empresa :"
643:             .Top       = 379
644:             .Left      = 176
645:             .Width     = 50
646:             .Height    = 15
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .BackStyle = 0

*-- Linhas 655 a 664:
655:         loc_oPg2.AddObject("txt_4c_EmpPad", "TextBox")
656:         WITH loc_oPg2.txt_4c_EmpPad
657:             .Value     = ""
658:             .Top       = 376
659:             .Left      = 232
660:             .Width     = 34
661:             .Height    = 23
662:             .FontName  = "Courier New"
663:             .FontSize  = 8
664:             .Alignment = 3

*-- Linhas 691 a 700:
691:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
692:                     loc_oGrid.Column1.Width         = 80
693:                     loc_oGrid.Column2.Width         = 290
694:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
695:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
696:                     THIS.FormatarGridLista(loc_oGrid)
697:                     loc_lResultado = .T.
698:                 ENDIF
699:             ENDIF
700:         CATCH TO loc_oErro

*-- Linhas 856 a 865:
856:             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
857:             loc_oGrid.Column1.Width         = 80
858:             loc_oGrid.Column2.Width         = 290
859:             loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
860:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
861:             THIS.FormatarGridLista(loc_oGrid)
862:             loc_oGrid.Refresh()
863:         ENDIF
864:     ENDPROC
865: 

*-- Linhas 1102 a 1115:
1102:         loc_oSalva = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
1103: 
1104:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1105:             loc_oSalva.cmd_4c_Confirmar.Enabled = .T.
1106:         ELSE
1107:             loc_oSalva.cmd_4c_Confirmar.Enabled = .F.
1108:         ENDIF
1109: 
1110:         loc_oSalva.cmd_4c_Cancelar.Enabled = .T.
1111:     ENDPROC
1112: 
1113:     *--------------------------------------------------------------------------
1114:     * Destroy - Libera recursos
1115:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\NcfBO.prg):
*==============================================================================
* NcfBO.prg - Business Object para Nao-Conformidades
* Tabela: SigCdNcf
* Migrado de: SIGCDNCF.SCX (frmcadastro)
*==============================================================================
DEFINE CLASS NcfBO AS BusinessBase

    *-- Propriedades (this_* -> coluna SQL)
    this_cCodigo    = ""    && cods  char(10)  PK
    this_cDescricao = ""    && descs char(60)
    this_nFixos     = 2     && fixos numeric(1,0)  1=Sim / 2=Nao (Descricao Fixa)
    this_nTipos     = 1     && tipos numeric(1,0)  1=Nao Conforme / 2=Limite Qtd / 3=Variacao Peso / 4=Reposicao S/Composicao
    this_cEmps      = ""    && emps  char(3)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdNcf"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de registros para o grid
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, fixos, tipos, emps" + ;
                       " FROM SigCdNcf" + ;
                       " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " OR emps = ' '" + ;
                       " ORDER BY cods"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar N" + CHR(227) + "o-Conformidades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao buscar N" + CHR(227) + "o-Conformidades:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, fixos, tipos, emps" + ;
                       " FROM SigCdNcf" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,  "C")
            THIS.this_cDescricao = TratarNulo(descs, "C")
            THIS.this_nFixos     = TratarNulo(fixos, "N")
            THIS.this_nTipos     = TratarNulo(tipos, "N")
            THIS.this_cEmps      = TratarNulo(emps,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdNcf (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdNcf (cods, descs, fixos, tipos, emps)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdNcf (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNcf SET" + ;
                       " descs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " fixos = " + FormatarNumeroSQL(THIS.this_nFixos) + "," + ;
                       " tipos = " + FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
                       " emps  = " + EscaparSQL(THIS.this_cEmps) + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao atualizar N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdNcf (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdNcf" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

